#!/bin/sh
if [ "$1" ]
then
  file_path=$1
  file_name=$(basename "$file_path")
  if [ -f $file_path ]; then
    file_size=$(stat -c%s $file_path)
    id=$(cat "$file_path.md5sum" | cut -d' ' -f1)
    datetime=$(grep ro\.build\.date\.utc $OUT/system/build.prop | cut -d= -f2);
    romtype=$(grep org\.freaky\.build\_type $OUT/system/build.prop | cut -d= -f2);
    ver=$(grep org\.freaky\.build\_version $OUT/system/build.prop | cut -d= -f2);
    device=$(grep ro\.product\.system\.device $OUT/system/build.prop | cut -d= -f2);
    url="https://sourceforge.net/projects/freakyos/files/$device/$file_name/download"
    echo "{\n  \"response\": [\n    {\n      \"datetime\": $datetime,\n      \"filename\": \"$file_name\",\n      \"id\": \"$id\",\n      \"romtype\": \"$romtype\",\n      \"size\": $file_size,\n      \"url\": \"$url\",\n      \"version\": \"$ver\"\n    }\n  ]\n}" > $file_path.json
  fi
fi
