
apk add --update nodejs

# Debug information
echo "Current directory: $(pwd)"
CONTAINER_ID=$(basename $(pwd))
echo "Container ID: $CONTAINER_ID"

# Run the node script to generate configuration files in the original location
node ./scripts/index.js

# Ensure target directories exist
mkdir -p /artifacts/$CONTAINER_ID/configurations/nginx
mkdir -p /artifacts/$CONTAINER_ID/configurations/synapse
mkdir -p /artifacts/$CONTAINER_ID/configurations/synapse-mas

# Copy files to the exact paths Docker expects
echo "Copying configuration files to Docker expected paths:"
cp ./configurations/nginx/nginx.conf /artifacts/$CONTAINER_ID/configurations/nginx/nginx.conf
cp ./configurations/nginx/index.html /artifacts/$CONTAINER_ID/configurations/nginx/index.html
cp ./configurations/synapse/homeserver.yaml /artifacts/$CONTAINER_ID/configurations/synapse/homeserver.yaml
cp ./configurations/synapse/db.yaml /artifacts/$CONTAINER_ID/configurations/synapse/db.yaml
cp ./configurations/synapse/email.yaml /artifacts/$CONTAINER_ID/configurations/synapse/email.yaml
cp ./configurations/synapse/oidc.yaml /artifacts/$CONTAINER_ID/configurations/synapse/oidc.yaml
cp ./configurations/synapse-mas/config.yaml /artifacts/$CONTAINER_ID/configurations/synapse-mas/config.yaml

# Verify files exist at the expected locations
echo "Checking if nginx.conf exists at expected path:"
ls -la /artifacts/$CONTAINER_ID/configurations/nginx/
realpath /artifacts/$CONTAINER_ID/configurations/nginx/nginx.conf