"""
mavsim_python: drawing tools
    - Beard & McLain, PUP, 2012
    - Update history:
        4/15/2019 - BGM
"""
import numpy as np
import pyqtgraph.opengl as gl
from tools.rotations import Euler2Rotation


class drawMav():
    def __init__(self, state, window):
        """
        Draw the MAV.

        The input to this function is a (message) class with properties that define the state.
        The following properties are assumed:
            state.pn  # north position
            state.pe  # east position
            state.h   # altitude
            state.phi  # roll angle
            state.theta  # pitch angle
            state.psi  # yaw angle
        """
        # get points that define the non-rotated, non-translated mav and the mesh colors
        self.mav_points, self.mav_meshColors = self.get_points()
        self.faces = self.gatherPointNumbers()

        mav_position = np.array([[state.pn], [state.pe], [-state.h]])  # NED coordinates
        # attitude of mav as a rotation matrix from body to inertial
        rotation = Euler2Rotation(state.phi, state.theta, state.psi)
        self.mav_body = []
        for face in self.faces:
            R = rotation
            # rotate and translate points defining mav
            facePoints = np.array([self.mav_points[face[0] - 1],
                                   self.mav_points[face[1] - 1],
                                   self.mav_points[face[2] - 1]]).T
            # scale points for better rendering
            scale = 50
            facePoints = scale * facePoints
            rotated_points = self.rotate_points(facePoints, R)
            translated_points = self.translate_points(rotated_points, mav_position)
            # convert North-East Down to East-North-Up for rendering
            R = np.array([[0, 1, 0], [1, 0, 0], [0, 0, -1]])

            translated_points = R @ translated_points
            # convert points to triangular mesh defined as array of three 3D points (Nx3x3)
            mesh = self.points_to_mesh(translated_points)
            if self.faces.index(face) < 8:
                i = 0  # Yellow main body
            elif self.faces.index(face) < 10:
                i = 1  # Blue wing
            elif self.faces.index(face) < 12:
                i = 2  # Green horizontal stabilizer
            else:
                i = 3  # Red vertical stabilizer
            self.mav_body.append(gl.GLMeshItem(vertexes=mesh,  # defines the triangular mesh (Nx3x3)
                                               vertexColors=self.mav_meshColors[i],  # defines mesh colors (Nx1)
                                               drawEdges=True,  # draw edges between mesh elements
                                               smooth=False,  # speeds up rendering
                                               computeNormals=False))  # speeds up rendering
            window.addItem(self.mav_body[-1])  # add body to plot

    def update(self, state):
        mav_position = np.array([[state.pn], [state.pe], [-state.h]])  # NED coordinates
        # attitude of mav as a rotation matrix from body to inertial
        rotation = Euler2Rotation(state.phi, state.theta, state.psi)
        for face in self.faces:
            # rotate and translate points defining mav
            R = rotation
            facePoints = np.array([self.mav_points[face[0] - 1],
                                   self.mav_points[face[1] - 1],
                                   self.mav_points[face[2] - 1]]).T
            # scale points for better rendering
            scale = 50
            facePoints = scale * facePoints
            rotated_points = self.rotate_points(facePoints, R)
            translated_points = self.translate_points(rotated_points, mav_position)
            # convert North-East Down to East-North-Up for rendering
            R = np.array([[0, 1, 0], [1, 0, 0], [0, 0, -1]])

            translated_points = R @ translated_points
            # convert points to triangular mesh defined as array of three 3D points (Nx3x3)
            mesh = self.points_to_mesh(translated_points)
            if self.faces.index(face) < 8:
                i = 0  # Yellow main body
            elif self.faces.index(face) < 10:
                i = 1  # Blue wing
            elif self.faces.index(face) < 12:
                i = 2  # Green horizontal stabilizer
            else:
                i = 3  # Red vertical stabilizer
            self.mav_body[self.faces.index(face)].setMeshData(vertexes=mesh, vertexColors=self.mav_meshColors[i])

    def rotate_points(self, points, R):
        "Rotate points by the rotation matrix R"
        rotated_points = R @ points
        return rotated_points

    def translate_points(self, points, translation):
        "Translate points by the vector translation"
        translated_points = points + np.dot(translation, np.ones([1, points.shape[1]]))
        return translated_points

    def get_points(self):
        """"
            Points that define the mav, and the colors of the triangular mesh
            Define the points on the aircraft following diagram in Figure C.3
        """
        # define MAV body parameters
        unit_length = 0.25
        fuse_h = unit_length
        fuse_w = unit_length
        fuse_l1 = unit_length * 2
        fuse_l2 = unit_length
        fuse_l3 = unit_length * 4
        wing_l = unit_length
        wing_w = unit_length * 6
        tail_h = unit_length
        tail_l = unit_length
        tail_w = unit_length * 2

        # points are in NED coordinates
        #   define the points on the aircraft following diagram Fig 2.14
        points = [[fuse_l1, 0, 0],  # point 1 [0]
                  [fuse_l2, fuse_w / 2, -fuse_h / 2],  # point 2 [1]
                  [fuse_l2, -fuse_w / 2, -fuse_h / 2],  # point 3 [2]
                  [fuse_l2, -fuse_w / 2, fuse_h / 2],  # point 4 [3]
                  [fuse_l2, fuse_w / 2, fuse_h / 2],  # point 5 [4]
                  [-fuse_l3, 0, 0],  # point 6 [5]
                  [0, wing_w / 2, 0],  # point 7 [6]
                  [-wing_l, wing_w / 2, 0],  # point 8 [7]
                  [-wing_l, -wing_w / 2, 0],  # point 9 [8]
                  [0, -wing_w / 2, 0],  # point 10 [9]
                  [-(fuse_l3 - tail_l), tail_w / 2, 0],  # point 11 [10]
                  [-fuse_l3, tail_w / 2, 0],  # point 12 [11]
                  [-fuse_l3, -tail_w / 2, 0],  # point 13 [12]
                  [-(fuse_l3 - tail_l), -tail_w / 2, 0],  # point 14 [12]
                  [-(fuse_l3 - tail_l), 0, 0],  # point 15 [14]
                  [-fuse_l3, 0, -tail_h],  # point 16 [15]
                  ]

        # scale points for better rendering
        scale = 50
        points = scale * points

        #   define the colors for each face of triangular mesh
        red = np.array([1., 0., 0., 1])
        green = np.array([0., 1., 0., 1])
        blue = np.array([0., 0., 1., 1])
        yellow = np.array([1., 1., 0., 1])
        meshColors = np.empty((13, 3, 4), dtype=np.float32)
        meshColors[0] = yellow
        meshColors[1] = blue
        meshColors[2] = green
        meshColors[3] = red
        return points, meshColors

    def points_to_mesh(self, points):
        """"
        Converts points to triangular mesh
        Each mesh face is defined by three 3D points
          (a rectangle requires two triangular mesh faces)
        """
        points = points.T
        mesh = np.array([[points[0], points[1], points[2]],
                         ])
        return mesh

    def gatherPointNumbers(self):
        # Define the faces that make up the aircraft following diagram 2.14
        faces = [[1, 2, 3], [1, 3, 4], [1, 2, 5], [1, 5, 4],  # Nose
                 [3, 4, 6], [4, 5, 6], [2, 3, 6], [2, 5, 6],  # Main frame
                 [7, 8, 9], [7, 9, 10],  # Wing faces
                 [11, 12, 13], [11, 13, 14],  # Horizontal stabilizer
                 [6, 15, 16]]  # Vertical stabilizer
        return faces
