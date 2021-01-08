#!/bin/bash
#|#./ingredients/web/chromium-2-enable-vaapi.sh # Chromium enable VAAPI support (requires Chromium ingredient)

# Generate ~/.config/chromium-flags.conf to enable VAAPI support

cat <<EOT > "chromium-flags.conf"
--ignore-gpu-blacklist
--enable-gpu-rasterization
--enable-zero-copy
EOT

mv chromium-flags.conf ~/.config/.

echo "===~/.config/chromium-flags.conf==="
cat ~/.config/chromium-flags.conf
echo "==================================="
