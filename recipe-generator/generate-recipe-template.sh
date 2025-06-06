#!/bin/bash
# Generate Recipe Template for sagi

BLACKLIST_ARRAY=("aur.sh")

DATE=$(date +%Y-%m-%d-%H:%M:%S)
GENERATED_RECIPE_TEMPLATE_NAME="recipe.sh"
GENERATED_RECIPE_TEMPLATE_FILE="../$GENERATED_RECIPE_TEMPLATE_NAME"
INGREDIENT_HEADER_REGEX="(?<=#\|).+"
HR="# --------------------------------------------------------------------------"

function main() {
    
    if [[ "$#" -eq 1 ]]; then
        GENERATED_RECIPE_TEMPLATE_FILE="$1"
        GENERATED_RECIPE_TEMPLATE_NAME=$(basename $1)
    fi

    echo "Generating sagi recipe at $GENERATED_RECIPE_TEMPLATE_FILE"
    generate-recipe
}

function generate-recipe() {

    echo "#!/bin/bash" > $GENERATED_RECIPE_TEMPLATE_FILE
    echo "# $GENERATED_RECIPE_TEMPLATE_NAME : $DATE" >> $GENERATED_RECIPE_TEMPLATE_FILE
    echo "# NOTE: Please uncomment the ingredients you wish to install before running!" >> $GENERATED_RECIPE_TEMPLATE_FILE
    echo $HR >> $GENERATED_RECIPE_TEMPLATE_FILE
    echo "" >> $GENERATED_RECIPE_TEMPLATE_FILE
    echo "function main() {" >> $GENERATED_RECIPE_TEMPLATE_FILE
    echo "sudo pacman -Syu --noconfirm --needed" >> $GENERATED_RECIPE_TEMPLATE_FILE

    generate-recipe-section "# Shell" "../ingredients/shell"
    generate-recipe-section "# Filesystem" "../ingredients/fs"
    generate-recipe-section "# System" "../ingredients/system"
    generate-recipe-section "# Editors" "../ingredients/editor"
    generate-recipe-section "# Web" "../ingredients/web"
    generate-recipe-section "# Development" "../ingredients/dev"
    generate-recipe-section "# Productivity" "../ingredients/productivity"
    generate-recipe-section "# Media" "../ingredients/media"
    generate-recipe-section "# Gaming" "../ingredients/gaming"
    generate-recipe-section "# VM" "../ingredients/vm"
    generate-recipe-section "# Icons" "../ingredients/icons"
    generate-recipe-section "# Fonts" "../ingredients/fonts"
    generate-recipe-section "# Hardware" "../ingredients/hardware"
    generate-recipe-section "# Theming" "../ingredients/themes"
    generate-recipe-section "# Gnome Extensions" "../ingredients/gnome-ext"

    echo "" >> $GENERATED_RECIPE_TEMPLATE_FILE
    
    echo "# Additional Packages" >> $GENERATED_RECIPE_TEMPLATE_FILE
    echo $HR >> $GENERATED_RECIPE_TEMPLATE_FILE
    echo "# paru -S --noconfirm --needed {package1} {package2} ..." >> $GENERATED_RECIPE_TEMPLATE_FILE
    echo "" >> $GENERATED_RECIPE_TEMPLATE_FILE

    echo "}" >> $GENERATED_RECIPE_TEMPLATE_FILE
    echo "" >> $GENERATED_RECIPE_TEMPLATE_FILE

    echo 'main "$@"' >> $GENERATED_RECIPE_TEMPLATE_FILE

    chmod +x $GENERATED_RECIPE_TEMPLATE_FILE
}

function is-ingredient-blacklisted() {

    local ingredient="$1"
    local ingredientName="$(basename $ingredient)"
    local isIngredientBlacklisted="false"
        
    for blackListItem in "${BLACKLIST_ARRAY[@]}"
    do
        if [[ "$blackListItem" == "$ingredientName" ]]; then
            isIngredientBlacklisted="true"
        fi
    done

    echo "$isIngredientBlacklisted"
}

function generate-recipe-section() {

    local sectionLabel="$1"
    local ingedientDir="$2"

    echo "" >> $GENERATED_RECIPE_TEMPLATE_FILE
    echo $sectionLabel >> $GENERATED_RECIPE_TEMPLATE_FILE
    echo $HR >> $GENERATED_RECIPE_TEMPLATE_FILE

    for ingredient in ${ingedientDir}/*.sh
    do
        if [[ "$(is-ingredient-blacklisted $ingredient)" == "false" ]]; then
            cat $ingredient | grep -P -o $INGREDIENT_HEADER_REGEX >> $GENERATED_RECIPE_TEMPLATE_FILE
        fi
    done
}

main "$@"