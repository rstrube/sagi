#!/bin/bash
#|#./ingredients/dev/2_gnome-vscode-wayland.sh #Native Wayland Support for VSCode [Requires /dev/1_vscode ingredient]

function update_desktop_file_for_wayland_gnome {

    # Copy the system .desktop file to your $HOME and tweak it to launch VSCode as a native Wayland application
    if [[ ! -d "~/.local/share/applications" ]]; then
        mkdir -p ~/.local/share/applications
    fi

    cp /usr/share/applications/visual-studio-code.desktop ~/.local/share/applications/.
    sed -i 's/\/usr\/bin\/code/& --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland/' ~/.local/share/applications/visual-studio-code.desktop
}

function create_and_configure_code_flags_for_wayland_gnome {

    cat <<EOT > "code-flags.conf"	
--enable-features=UseOzonePlatform,WaylandWindowDecorations
--ozone-platform=wayland
EOT

    cp code-flags.conf ~/.config/
    rm code-flags.conf
}

create_and_configure_code_flags_for_wayland_gnome

