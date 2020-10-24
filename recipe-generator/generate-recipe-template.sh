#!/bin/bash
# Generate Recipe Template

GENERATED_RECIPE_TEMPLATE_NAME_PREFIX="recipe-"
DATE=$(date +%d%m%Y-%H%M%S)
GENERATED_RECIPE_TEMPLATE_NAME="${GENERATED_RECIPE_TEMPLATE_NAME_PREFIX}${DATE}.sh"
GENERATED_RECIPE_TEMPLATE_FILE="../$GENERATED_RECIPE_TEMPLATE_NAME"
INGREDIENT_HEADER_REGEX="(?<=#\|).+"
HR="# -------------------------"

function main() {
    
    if [[ "$#" -eq 1 ]]; then
        GENERATED_RECIPE_TEMPLATE_FILE="$1"
        GENERATED_RECIPE_TEMPLATE_NAME=$(basename $1)
    fi

    generate-recipe
}

function generate-recipe() {

    echo "#!/bin/bash" > $GENERATED_RECIPE_TEMPLATE_FILE
    echo "# $GENERATED_RECIPE_TEMPLATE_NAME" >> $GENERATED_RECIPE_TEMPLATE_FILE
    echo "# NOTE: Please edit this recipe file before running!" >> $GENERATED_RECIPE_TEMPLATE_FILE

    generate-recipe-section "# Core" "../ingredients/core"
    generate-recipe-section "# Development" "../ingredients/dev"
    generate-recipe-section "# Gnome" "../ingredients/gnome"
    generate-recipe-section "# Web" "../ingredients/web"
    generate-recipe-section "# Productivity" "../ingredients/productivity"
    generate-recipe-section "# Media" "../ingredients/media"
    generate-recipe-section "# Gaming" "../ingredients/gaming"
    generate-recipe-section "# Backup" "../ingredients/backup"
    generate-recipe-section "# Hardware Specific CPU" "../ingredients/cpu"
    generate-recipe-section "# VM" "../ingredients/vm"
}

function generate-recipe-section() {

    SECTION_LABEL=$1
    INGREDIENT_DIR=$2

    echo "" >> $GENERATED_RECIPE_TEMPLATE_FILE
    echo $SECTION_LABEL >> $GENERATED_RECIPE_TEMPLATE_FILE
    echo $HR >> $GENERATED_RECIPE_TEMPLATE_FILE

    for i in ${INGREDIENT_DIR}/*.sh; do
        cat $i | grep -P -o $INGREDIENT_HEADER_REGEX >> $GENERATED_RECIPE_TEMPLATE_FILE
    done
}

main "$@"