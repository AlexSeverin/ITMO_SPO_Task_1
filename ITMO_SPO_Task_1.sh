FILES=/C/Users/AlexeySeverin/Desktop/Practika/*
for f in $FILES
do
  filename="${f##*/}"
  NAME=$(echo "$filename" | sed 's/\.[^.]*$//')
    EXTENSION=$(echo "$filename" | sed 's/^.*\.//')
    SIZE=$(wc -c "$f" | awk '{print $1}')
  if [[ -d "$f" ]]; then
   EXTENSION="dir"
   SIZE="dir"
  fi
  DUR=$(
ffprobe -v quiet -print_format compact=print_section=0:nokey=1:escape=csv -show_entries format=duration "$f")


  
  echo -e "$NAME \t $EXTENSION \t $SIZE \t $DUR" >> myfile.xls
done