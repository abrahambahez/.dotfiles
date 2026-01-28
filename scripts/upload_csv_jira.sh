#!/bin/bash

# Configuración
PROJECT_KEY="SL" # La clave de tu proyecto, que es 'SL' según el enlace.
EPIC_LINK_FIELD_NAME="Epic Link" # Asegúrate de que este es el nombre de tu campo para enlazar la épica.

# Comando acli para crear historias a partir del CSV
# La acción 'runFromCsv' ejecuta el comando '--common' por cada línea del CSV.
# El mapeo de columnas del CSV a campos de Jira se hace dentro de '--common'.
acli jiracloud --action runFromCsv \
    --file "items.csv" \
    --common "--action createIssue \
        --project $PROJECT_KEY \
        --type Story \
        --summary %Title% \
        --description %Body% \
        --labels %Labels% \
        --field '$EPIC_LINK_FIELD_NAME'='SL-9' \
        --continue"

# Nota:
# - '--summary %Title%' usa el valor de la columna 'Title' para el Summary.
# - '--description %Body%' usa el valor de la columna 'Body' para la Description.
# - '--labels %Labels%' usa el valor de la columna 'Labels' para las etiquetas.
# - '--field '$EPIC_LINK_FIELD_NAME'='SL-9'' asocia la historia a tu épica (SL-9). 
#   Asegúrate de que 'Epic Link' es el nombre del campo en tu instancia de Jira.
# - '--continue' hace que el script siga aunque falle una fila (opcional).
