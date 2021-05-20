"""
mavsim_python: drawing tools
    - Beard & McLain, PUP, 2012
    - Update history:
        2/20/2019 - RWB
        4/15/2019 - BGM
        2/24/2020 - RWB
"""

import numpy as np
import pyqtgraph.opengl as gl
from tools.rotations import Euler2Rotation
from path_managing.dubins_parameters import dubinsParameters # Not needed for chapters 2/3/4


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


class drawPath():
    def __init__(self, path, color, window):
        self.color = color
        if path.type == 'line':
            scale = 1000
            points = self.straight_line_points(path, scale)
        elif path.type == 'orbit':
            points = self.orbit_points(path)
        path_color = np.tile(color, (points.shape[0], 1))
        self.path_plot_object = gl.GLLinePlotItem(pos=points,
                                                  color=path_color,
                                                  width=2,
                                                  antialias=True,
                                                  mode='line_strip')
        window.addItem(self.path_plot_object)

    def update(self, path, color):
        if path.type == 'line':
            scale = 1000
            points = self.straight_line_points(path, scale)
        elif path.type == 'orbit':
            points = self.orbit_points(path)
        path_color = np.tile(color, (points.shape[0], 1))
        self.path_plot_object.setData(pos=points, color=path_color)

    def straight_line_points(self, path, scale):
        points = np.array([[path.line_origin.item(0),
                            path.line_origin.item(1),
                            path.line_origin.item(2)],
                           [path.line_origin.item(0) + scale * path.line_direction.item(0),
                            path.line_origin.item(1) + scale * path.line_direction.item(1),
                            path.line_origin.item(2) + scale * path.line_direction.item(2)]])
        # convert North-East Down to East-North-Up for rendering
        R = np.array([[0, 1, 0], [1, 0, 0], [0, 0, -1]])
        points = points @ R.T
        return points

    def orbit_points(self, path):
        N = 10
        theta = 0
        theta_list = [theta]
        while theta < 2 * np.pi:
            theta += 0.1
            theta_list.append(theta)
        points = np.array([[path.orbit_center.item(0) + path.orbit_radius,
                            path.orbit_center.item(1),
                            path.orbit_center.item(2)]])
        for angle in theta_list:
            new_point = np.array([[path.orbit_center.item(0) + path.orbit_radius * np.cos(angle),
                                   path.orbit_center.item(1) + path.orbit_radius * np.sin(angle),
                                   path.orbit_center.item(2)]])
            points = np.concatenate((points, new_point), axis=0)
        # convert North-East Down to East-North-Up for rendering
        R = np.array([[0, 1, 0], [1, 0, 0], [0, 0, -1]])
        points = points @ R.T
        return points


class drawWaypoints():
    def __init__(self, waypoints, radius, color, window):
        self.radius = radius
        self.color = color
        if waypoints.type == 'straight_line' or waypoints.type == 'fillet':
            points = self.straight_waypoint_points(waypoints)
        elif waypoints.type == 'dubins':
            points = self.dubins_points(waypoints, self.radius, 0.1)
        waypoint_color = np.tile(color, (points.shape[0], 1))
        self.waypoint_plot_object = gl.GLLinePlotItem(pos=points,
                                                      color=waypoint_color,
                                                      width=2,
                                                      antialias=True,
                                                      mode='line_strip')
        window.addItem(self.waypoint_plot_object)

    def update(self, waypoints):
        if waypoints.type == 'straight_line' or waypoints.type == 'fillet':
            points = self.straight_waypoint_points(waypoints)
        elif waypoints.type == 'dubins':
            points = self.dubins_points(waypoints, self.radius, 0.1)
        self.waypoint_plot_object.setData(pos=points)

    def straight_waypoint_points(self, waypoints):
        R = np.array([[0, 1, 0], [1, 0, 0], [0, 0, -1]])
        points = R @ np.copy(waypoints.ned)
        return points.T

    def dubins_points(self, waypoints, radius, Del):
        # returns a list of points along the dubins path
        initialize_points = True
        dubins_path = dubinsParameters()
        for j in range(0, waypoints.num_waypoints - 1):
            dubins_path.update(
                waypoints.ned[:, j:j + 1],
                waypoints.course.item(j),
                waypoints.ned[:, j + 1:j + 2],
                waypoints.course.item(j + 1),
                radius)

            # points along start circle
            th1 = np.arctan2(dubins_path.p_s.item(1) - dubins_path.center_s.item(1),
                             dubins_path.p_s.item(0) - dubins_path.center_s.item(0))
            th1 = self.mod(th1)
            th2 = np.arctan2(dubins_path.r1.item(1) - dubins_path.center_s.item(1),
                             dubins_path.r1.item(0) - dubins_path.center_s.item(0))
            th2 = self.mod(th2)
            th = th1
            theta_list = [th]
            if dubins_path.dir_s > 0:
                if th1 >= th2:
                    while th < th2 + 2 * np.pi:
                        th += Del
                        theta_list.append(th)
                else:
                    while th < th2:
                        th += Del
                        theta_list.append(th)
            else:
                if th1 <= th2:
                    while th > th2 - 2 * np.pi:
                        th -= Del
                        theta_list.append(th)
                else:
                    while th > th2:
                        th -= Del
                        theta_list.append(th)

            if initialize_points:
                points = np.array([[dubins_path.center_s.item(0) + dubins_path.radius * np.cos(theta_list[0]),
                                    dubins_path.center_s.item(1) + dubins_path.radius * np.sin(theta_list[0]),
                                    dubins_path.center_s.item(2)]])
                initialize_points = False
            for angle in theta_list:
                new_point = np.array([[dubins_path.center_s.item(0) + dubins_path.radius * np.cos(angle),
                                       dubins_path.center_s.item(1) + dubins_path.radius * np.sin(angle),
                                       dubins_path.center_s.item(2)]])
                points = np.concatenate((points, new_point), axis=0)

            # points along straight line
            sig = 0
            while sig <= 1:
                new_point = np.array([[(1 - sig) * dubins_path.r1.item(0) + sig * dubins_path.r2.item(0),
                                       (1 - sig) * dubins_path.r1.item(1) + sig * dubins_path.r2.item(1),
                                       (1 - sig) * dubins_path.r1.item(2) + sig * dubins_path.r2.item(2)]])
                points = np.concatenate((points, new_point), axis=0)
                sig += Del

            # points along end circle
            th2 = np.arctan2(dubins_path.p_e.item(1) - dubins_path.center_e.item(1),
                             dubins_path.p_e.item(0) - dubins_path.center_e.item(0))
            th2 = self.mod(th2)
            th1 = np.arctan2(dubins_path.r2.item(1) - dubins_path.center_e.item(1),
                             dubins_path.r2.item(0) - dubins_path.center_e.item(0))
            th1 = self.mod(th1)
            th = th1
            theta_list = [th]
            if dubins_path.dir_e > 0:
                if th1 >= th2:
                    while th < th2 + 2 * np.pi:
                        th += Del
                        theta_list.append(th)
                else:
                    while th < th2:
                        th += Del
                        theta_list.append(th)
            else:
                if th1 <= th2:
                    while th > th2 - 2 * np.pi:
                        th -= Del
                        theta_list.append(th)
                else:
                    while th > th2:
                        th -= Del
                        theta_list.append(th)
            for angle in theta_list:
                new_point = np.array([[dubins_path.center_e.item(0) + dubins_path.radius * np.cos(angle),
                                       dubins_path.center_e.item(1) + dubins_path.radius * np.sin(angle),
                                       dubins_path.center_e.item(2)]])
                points = np.concatenate((points, new_point), axis=0)

        R = np.array([[0, 1, 0], [1, 0, 0], [0, 0, -1]])
        points = points @ R.T
        return points

    def mod(self, x):
        # force x to be between 0 and 2*pi
        while x < 0:
            x += 2 * np.pi
        while x > 2 * np.pi:
            x -= 2 * np.pi
        return x


class drawMap():
    def __init__(self, map, window):
        self.window = window
        # draw map of the world: buildings
        fullMesh = np.array([], dtype=np.float32).reshape(0, 3, 3)
        fullMeshColors = np.array([], dtype=np.float32).reshape(0, 3, 4)
        for i in range(0, map.num_city_blocks):
            for j in range(0, map.num_city_blocks):
                mesh, meshColors = self.building_vert_face(map.building_north[0, i],
                                                           map.building_east[0, j],
                                                           map.building_width,
                                                           map.building_height[i, j])
                fullMesh = np.concatenate((fullMesh, mesh), axis=0)
                fullMeshColors = np.concatenate((fullMeshColors, meshColors), axis=0)
        self.ground_mesh = gl.GLMeshItem(
            vertexes=fullMesh,  # defines the triangular mesh (Nx3x3)
            vertexColors=fullMeshColors,  # defines mesh colors (Nx1)
            drawEdges=True,  # draw edges between mesh elements
            smooth=False,  # speeds up rendering
            computeNormals=False)  # speeds up rendering
        self.window.addItem(self.ground_mesh)

    def update(self, map):
        # draw map of the world: buildings
        fullMesh = np.array([], dtype=np.float32).reshape(0, 3, 3)
        fullMeshColors = np.array([], dtype=np.float32).reshape(0, 3, 4)
        for i in range(0, map.num_city_blocks):
            for j in range(0, map.num_city_blocks):
                mesh, meshColors = self.building_vert_face(map.building_north[0, i],
                                                           map.building_east[0, j],
                                                           map.building_width,
                                                           map.building_height[i, j])
                fullMesh = np.concatenate((fullMesh, mesh), axis=0)
                fullMeshColors = np.concatenate((fullMeshColors, meshColors), axis=0)
        self.ground_mesh.setData(vertexes=fullMesh, vertexColors=fullMeshColors)

    def building_vert_face(self, n, e, width, height):
        # define patches for a building located at (x, y)
        # vertices of the building
        points = np.array([[e + width / 2, n + width / 2, 0],  # NE 0
                           [e + width / 2, n - width / 2, 0],  # SE 1
                           [e - width / 2, n - width / 2, 0],  # SW 2
                           [e - width / 2, n + width / 2, 0],  # NW 3
                           [e + width / 2, n + width / 2, height],  # NE Higher 4
                           [e + width / 2, n - width / 2, height],  # SE Higher 5
                           [e - width / 2, n - width / 2, height],  # SW Higher 6
                           [e - width / 2, n + width / 2, height]])  # NW Higher 7
        mesh = np.array([[points[0], points[3], points[4]],  # North Wall
                         [points[7], points[3], points[4]],  # North Wall
                         [points[0], points[1], points[5]],  # East Wall
                         [points[0], points[4], points[5]],  # East Wall
                         [points[1], points[2], points[6]],  # South Wall
                         [points[1], points[5], points[6]],  # South Wall
                         [points[3], points[2], points[6]],  # West Wall
                         [points[3], points[7], points[6]],  # West Wall
                         [points[4], points[7], points[5]],  # Top
                         [points[7], points[5], points[6]]])  # Top

        #   define the colors for each face of triangular mesh
        red = np.array([1., 0., 0., 1])
        green = np.array([0., 1., 0., 1])
        blue = np.array([0., 0., 1., 1])
        yellow = np.array([1., 1., 0., 1])
        meshColors = np.empty((10, 3, 4), dtype=np.float32)
        meshColors[0] = green
        meshColors[1] = green
        meshColors[2] = green
        meshColors[3] = green
        meshColors[4] = green
        meshColors[5] = green
        meshColors[6] = green
        meshColors[7] = green
        meshColors[8] = yellow
        meshColors[9] = yellow
        return mesh, meshColors
