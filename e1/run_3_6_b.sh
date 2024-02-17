
#Staging or prod
NOW_DATE=$(date '+%Y-%m-%d-%H-%M-%S')
BACKUP_FILENAME=backup_
OUT_DIR=o/o_3_6_b/
INPUT_DIR=i/i_3_6_b/

## FUNCS
datetime_greater_than() {
    datetime1="$1"
    datetime2="$2"

    # Extract date and hour components for each datetime
    date1="${datetime1%-*}"
    hour1="${datetime1##*-}"
    date2="${datetime2%-*}"
    hour2="${datetime2##*-}"

    # Reorder the components to the format YYYYMMDDHH
    reordered_datetime1="${date1//-/}${hour1}"
    reordered_datetime2="${date2//-/}${hour2}"

    # Compare the reordered datetimes as strings
    if [ "$reordered_datetime1" -gt "$reordered_datetime2" ]; then
        return 0
    else
        return 1
    fi
}


mkdir -p $OUT_DIR
if [ -d $OUT_DIR ]; then
    BACKUP_EXPIRED=$(date -d "6 seconds ago" '+%Y-%m-%d-%H-%M-%S')
    
    echo "Making backup."
    zip "${OUT_DIR}${BACKUP_FILENAME}${NOW_DATE}" $INPUT_DIR    

    for file in $OUT_DIR/*; do
        if [ -f "$file" ]; then
            file=$(basename $file)
            if [[ $file == *$BACKUP_FILENAME* ]]; then
                FILE_DATE=${file:7:19}
                if datetime_greater_than "$BACKUP_EXPIRED" "$FILE_DATE"; then
                    echo "Backup was made recently, deleting ${OUT_DIR}${file}"
                    rm "${OUT_DIR}${file}"
                fi
            fi
        fi
    done
fi	