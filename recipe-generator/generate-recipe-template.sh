#!/bin/bash
# Generate Recipe Template

DATE=$(date +%d-%m-%Y-%H:%M:%S)
GENERATED_RECIPE_TEMPLATE_NAME="recipe.sh"
GENERATED_RECIPE_TEMPLATE_FILE="../$GENERATED_RECIPE_TEMPLATE_NAME"
INGREDIENT_HEADER_REGEX="(?<=#\|).+"
HR="# ------------------------------------------------------------------------"

function main() {
    
    if [[ "$#" -eq 1 ]]; then
        GENERATED_RECIPE_TEMPLATE_FILE="$1"
        GENERATED_RECIPE_TEMPLATE_NAME=$(basename $1)
    fi

    generate-recipe
}

function generate-recipe() {

    echo "#!/bin/bash" > $GENERATED_RECIPE_TEMPLATE_FILE
    echo "# $GENERATED_RECIPE_TEMPLATE_NAME : $DATE" >> $GENERATED_RECIPE_TEMPLATE_FILE
    echo "# NOTE: Please uncomment the ingredients you wish to install before running!" >> $GENERATED_RECIPE_TEMPLATE_FILE
    echo $HR >> $GENERATED_RECIPE_TEMPLATE_FILE

    generate-recipe-section "# 1. Core" "../ingredients/core"
    generate-recipe-section "# 2. Gnome" "../ingredients/gnome"
    generate-recipe-section "# 3. Development" "../ingredients/dev"
    generate-recipe-section "# 4. Web" "../ingredients/web"
    generate-recipe-section "# 5. Productivity" "../ingredients/productivity"
    generate-recipe-section "# 6. Media" "../ingredients/media"
    generate-recipe-section "# 7. Gaming" "../ingredients/gaming"
    generate-recipe-section "# 8. Backup" "../ingredients/backup"
    generate-recipe-section "# 9. Hardware Specific CPU" "../ingredients/cpu"
    generate-recipe-section "# 10. VM" "../ingredients/vm"

    cat yay-install-func.sh >> $GENERATED_RECIPE_TEMPLATE_FILE
    
    chmod +x $GENERATED_RECIPE_TEMPLATE_FILE
}

function generate-recipe-section() {

    SECTION_LABEL=$1
    INGREDIENT_DIR=$2

    echo "" >> $GENERATED_RECIPE_TEMPLATE_FILE
    echo $SECTION_LABEL >> $GENERATED_RECIPE_TEMPLATE_FILE
    echo $HR >> $GENERATED_RECIPE_TEMPLATE_FILE
    echo "" >> $GENERATED_RECIPE_TEMPLATE_FILE

    for i in ${INGREDIENT_DIR}/*.sh; do
        cat $i | grep -P -o $INGREDIENT_HEADER_REGEX >> $GENERATED_RECIPE_TEMPLATE_FILE
        echo "" >> $GENERATED_RECIPE_TEMPLATE_FILE
    done
}

main "$@"