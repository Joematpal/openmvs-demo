# Create workspace
mkdir -p t100_fender_03 && cd t100_fender_03
mkdir images sparse dense

# Run feature extraction and mapping (CLI)
colmap feature_extractor --database_path database.db --image_path images
colmap exhaustive_matcher --database_path database.db

# Sparse reconstruction
mkdir sparse/0
colmap mapper --database_path database.db --image_path images --output_path sparse

# Dense reconstruction (optional here, OpenMVS will handle it)

# Step 2: Export to OpenMVS format
# Convert COLMAP output to OpenMVS format
mkdir mvs

# Convert camera poses and images
colmap model_converter \
    --input_path sparse/0 \
    --output_path mvs/scene.mvs \
    --output_type OpenMVS


# Step 3 Use OpenMVS
# Densify point cloud
DensifyPointCloud mvs/scene.mvs

# Reconstruct mesh
ReconstructMesh mvs/scene_dense.mvs

# Refine mesh (optional)
RefineMesh mvs/scene_dense_mesh.mvs

# Texture the mesh
TextureMesh mvs/scene_dense_mesh_refine.mvs
