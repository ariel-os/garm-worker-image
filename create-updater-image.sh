export BASE_IMAGE="images:ubuntu/24.04/cloud"
export TARGET_IMAGE="incus-image-updater"

set -x
set -e

function cleanup()
{
    # Delete the temporary instance
    incus delete ${TARGET_IMAGE}-temp --force
}

trap cleanup EXIT 

# Create a temporary instance from your base image
incus launch $BASE_IMAGE ${TARGET_IMAGE}-temp

# Copy over updater-scripts
incus file push -r updater-scripts ${TARGET_IMAGE}-temp/

# Enter bash inside the container
cat <<EOF | incus exec ${TARGET_IMAGE}-temp -- bash
set -x
set -e

cd /updater-scripts

for i in *.sh; do
    # ensure we're still here
    cd /updater-scripts
    # source shell snippets
    . \${i}
done

rm -Rf /updater-scripts

# Exit the container
exit

EOF

# Stop the instance and publish it as a new image
incus stop ${TARGET_IMAGE}-temp
incus publish ${TARGET_IMAGE}-temp --alias $TARGET_IMAGE --reuse
