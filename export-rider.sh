#!/bin/bash

# Delete any exports from a previous distrobox host
echo "Step 2: Deleting any previous exports of Rider from the host..."
distrobox-export --app rider --delete

# Export the desktop file from the Distrobox as an app
echo "Step 3: Exporting Rider app using distrobox-export..."
distrobox-export --app rider

# Step 4: Delete this script
echo "Step 4: Renaming export-rider.sh to export-rider.bak to prevent future execution."
sudo mv /opt/Rider/export-rider.sh /opt/Rider/export-rider.bak

echo "Rider export complete!"
