#!/bin/bash
#|#./ingredients/gnome/theme-dracula.sh #Gnome Dracula theme

# Please refer to https://draculatheme.com/contribute/ for a full list of hex codes

function main() {

    install
}

function install() {

    configure_gtk_theme
    configure_gnome_terminal_theme
    configure_gedit_theme
    configure_fish_theme
    configure_dracula_papirus_icons
}

function configure_gtk_theme {

    echo "Installing Dracula GTK theme..."

    curl -O -L https://github.com/dracula/gtk/archive/master.zip

    if [[ -d ~/.local/share/themes/Dracula ]]; then
        echo "Deleting existing locally installed Dracula GTK theme..."
        rm -rf ~/.local/share/themes/Dracula
    fi

    mkdir -p ~/.local/share/themes

    unzip master.zip -d ~/.local/share/themes
    mv ~/.local/share/themes/gtk-master ~/.local/share/themes/Dracula

    rm master.zip

    # Get GTK theme to Dracula (which was locally installed in ~/.local/share/themes)
    gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
    gsettings set org.gnome.desktop.wm.preferences theme "Dracula"
}

function configure_gnome_terminal_theme {

    echo "Installing Dracula theme for gnome-terminal..."

    # Reset gnome-terminal
    dconf reset -f /org/gnome/terminal/

    GT_DCONF_DIR=/org/gnome/terminal/legacy/profiles:
    GT_PROFILE_ID="$(uuidgen)"
    GT_DCONF_PROFILE_DIR="${GT_DCONF_DIR}/:$GT_PROFILE_ID"

    GT_PROFILE_NAME="'Dracula'"
    GT_PROFILE_BACKGROUND_COLOR="'#282A36'"
    GT_PROFILE_BOLD_COLOR="'#BD93F9'"
    GT_PROFILE_FOREGROUND_COLOR="'#F8F8F2'"

    #                    Background B-Pink     B-Green    B-Yellow   B-Purple   B-Red      B-Cyan     B-Orange   Curr Line  Pink       Green      Yellow     Purple     Red        Cyan       Orange
    GT_PROFILE_PALLETE="['#282A36', '#FF79C6', '#50FA7B', '#F1FA8C', '#BD93F9', '#FF5555', '#8BE9FD', '#FFB86C', '#44475A', '#FF79C6', '#50FA7B', '#F1FA8C', '#BD93F9', '#FF5555', '#8BE9FD', '#FFB86C']"

    dconf write ${GT_DCONF_DIR}/default "'$GT_PROFILE_ID'"
    dconf write ${GT_DCONF_DIR}/list "['$GT_PROFILE_ID']"

    dconf write ${GT_DCONF_PROFILE_DIR}/background-color $GT_PROFILE_BACKGROUND_COLOR
    dconf write ${GT_DCONF_PROFILE_DIR}/bold-color $GT_PROFILE_BOLD_COLOR
    dconf write ${GT_DCONF_PROFILE_DIR}/bold-color-same-as-fg "false"
    dconf write ${GT_DCONF_PROFILE_DIR}/foreground-color $GT_PROFILE_FOREGROUND_COLOR
    dconf write ${GT_DCONF_PROFILE_DIR}/palette "$GT_PROFILE_PALLETE"
    dconf write ${GT_DCONF_PROFILE_DIR}/use-theme-colors "false"
    dconf write ${GT_DCONF_PROFILE_DIR}/visible-name $GT_PROFILE_NAME
}

function configure_gedit_theme {

    echo "Installing Dracula theme for gedit..."

    curl -O https://raw.githubusercontent.com/dracula/gedit/master/dracula.xml

    GEDIT_STYLE_PATH=$HOME/.local/share/gedit/styles

    if [[ ! -d $GEDIT_STYLE_PATH ]]; then
        mkdir -p $GEDIT_STYLE_PATH
    fi

    mv dracula.xml $GEDIT_STYLE_PATH
    
    gsettings set org.gnome.gedit.preferences.editor scheme 'dracula'
}

function configure_fish_theme {

    echo "Installing Dracula theme for fish shell..."

    if [[ -d ~/.config/fish ]]; then
        cat <<EOT > "dracula.fish"
# Reset all explicitly defined fish shell colors to use built in terminal colors

set -g fish_color_autosuggestion      brblack
set -g fish_color_cancel              -r
set -g fish_color_command             brgreen
set -g fish_color_comment             brmagenta
set -g fish_color_cwd                 green
set -g fish_color_cwd_root            red
set -g fish_color_end                 brmagenta
set -g fish_color_error               brred
set -g fish_color_escape              brcyan
set -g fish_color_history_current     --bold
set -g fish_color_host                normal
set -g fish_color_match               --background=brblue
set -g fish_color_normal              normal
set -g fish_color_operator            cyan
set -g fish_color_param               brblue
set -g fish_color_quote               yellow
set -g fish_color_redirection         bryellow
set -g fish_color_search_match        'bryellow' '--background=brblack'
set -g fish_color_selection           'white' '--bold' '--background=brblack'
set -g fish_color_status              red
set -g fish_color_user                brgreen
set -g fish_color_valid_path          --underline
set -g fish_pager_color_completion    normal
set -g fish_pager_color_description   yellow
set -g fish_pager_color_prefix        'white' '--bold' '--underline'
set -g fish_pager_color_progress      'brblack' '--background=cyan'

# Helper function which displays terminal and fish shell colors
function print_fish_colors --description 'Displays the terminal and fish colors being used'
    echo 'Current terminal colors:'
    set_color --print-colors
    echo ''
    echo 'Current fish colors:'
    set -l clr_list (set -n | grep fish | grep color | grep -v __)
    if test -n "$clr_list"
        set -l bclr (set_color normal)
        set -l bold (set_color --bold)
        printf "\n| %-38s | %-38s |\n" Variable Definition
        echo '|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯|'
        for var in $clr_list
            set -l def $$var
            set -l clr (set_color $def ^/dev/null)
            or begin
                printf "| %-38s | %s%-38s$bclr |\n" "$var" (set_color --bold white --background=red) "$def"
                continue
            end
            printf "| $clr%-38s$bclr | $bold%-38s$bclr |\n" "$var" "$def"
        end
        echo '|________________________________________|________________________________________|'\n
    end
end
EOT
        cp dracula.fish ~/.config/fish/
        rm dracula.fish
        echo "# Dracula theme" >> ~/.config/fish/config.fish
        echo "source ~/.config/fish/dracula.fish" >> ~/.config/fish/config.fish
    fi
}

function configure_dracula_papirus_icons {

    GNOME_CURRENT_ICON_THEME=$(gsettings get org.gnome.desktop.interface icon-theme)

    if [[ "$GNOME_CURRENT_ICON_THEME" == "'Papirus-Dark'" ]]; then

        echo "Setting papirus icons folder color to 'grey' via 'papirus-folders'..."

        paru -Syu --noconfirm --needed papirus-folders
        papirus-folders -C grey --theme Papirus-Dark
    fi
}

main "$@"
