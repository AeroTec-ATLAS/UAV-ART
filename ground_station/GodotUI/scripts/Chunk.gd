extends Spatial
class_name Chunk

var mesh_instance
var x
var z
var chunk_size
var should_remove = true




func _init(x,z,chunk_size):
	self.x = x
	self.z = z
	self.chunk_size = chunk_size

func _ready():
	var material = SpatialMaterial.new()
	material.albedo_color = Color(randi())
	generate_chunk(material)

func generate_chunk(material):
	var plane_mesh = PlaneMesh.new()
	plane_mesh.size = Vector2(chunk_size,chunk_size)
	plane_mesh.subdivide_depth = 2 #chunk_size*0.5
	plane_mesh.subdivide_width = 2 #chunk_size*0.5
	
	var surface_tool = SurfaceTool.new()
	var data_tool = MeshDataTool.new()
	
	surface_tool.create_from(plane_mesh,0)
	var array_plane = surface_tool.commit()
	var _error = data_tool.create_from_surface(array_plane,0)
#	for i in range(data_tool.get_vertex_count()): #does nothing
#		var vertex = data_tool.get_vertex(i)
#		data_tool.set_vertex(i,vertex)
	for s in range(array_plane.get_surface_count()):
		array_plane.surface_remove(s)
	
	data_tool.commit_to_surface(array_plane)
	surface_tool.begin(Mesh.PRIMITIVE_TRIANGLES)
	
	surface_tool.create_from(array_plane,0)
	surface_tool.set_material(material)
	surface_tool.generate_normals()
	
	mesh_instance = MeshInstance.new()
	mesh_instance.mesh = surface_tool.commit()
	mesh_instance.create_trimesh_collision()
	mesh_instance.cast_shadow = GeometryInstance.SHADOW_CASTING_SETTING_OFF
	add_child(mesh_instance)
	
