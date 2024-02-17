
#Staging or prod
NOW_DATE=$(date '+%Y-%m-%d-%H-%M-%S')
BACKUP_FILENAME=backup_
OUT_DIR=o/o_3_6_a/
INPUT_DIR=i/i_3_6_a/



mkdir -p $OUT_DIR
if [ -d $OUT_DIR ]; then
    echo "Making backup."
    zip "${OUT_DIR}${BACKUP_FILENAME}${NOW_DATE}" $INPUT_DIR    
fi	