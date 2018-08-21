# script for downloading, sorting, and unzipping samples based on study number
# created by Adam Christianson

#input: project name
#output: data files
#goal: To download and sort and unzip samples based on study number

pj_dir=false
wjid=()

#Path to file containing download links
l="/data/internal/Biocore/zebrafish_dev/zebrafish_scripts/zebrafish_data_links/Zebrafish_Data_Download_Links_final_sort.csv"

#Path to output directory
d="/data/internal/Biocore/zebrafish_dev/actual_datasets/"
n=0

#Check for study number
grep -qe "$1" "$l"
if [ "$?" = 0 ]; then

  #Create study folder
  if [ -d "$d$l" ]; then
    echo "Error: $d$1 already exists"
    exit 1
  else 
    mkdir "$d$1" && pj_dir=true
  fi
else
  echo "Error: study number $1 not found"
fi

#Check if study directory exists
if [ "$pj_dir" = true ]; then

  #Iterate thru each line in sample index file
  for (( i=1; i<$(wc -l $l | cut -d ' ' -f 1); i++)); do

    #Find study number matches
    if [ "$(head -n $i $l | tail -n 1 | cut -d , -f 2)" = "$1" ]; then 

      #Check if data is paired-end
      if [ "$(head -n $i $l | tail -n 1 | cut -d , -f 5)" = "Yes" ]; then

        #Download PE files
        wget -qP "$d$1/PE" "$(head -n $i $l | tail -n 1 | cut -d , -f 6)" &
        wjid[$n]=$!
        ((n++))
        wget -qP "$d$1/PE" "$(head -n $i $l | tail -n 1 | cut -d , -f 7 | rev | cut -c 2- | rev)" &
        wjid[$n]=$!
        ((n++))
      #Check if	data is	paired-end
      elif [ "$(head -n $i $l | tail -n 1 | cut -d , -f 5)" = "No" ]; then

        #Download SE files
        wget -qP "$d$1/SE" "$(head -n $i $l | tail -n 1 | cut -d , -f 6)" &
        wjid[$n]=$!
        ((n++))
      fi
    fi
  done
  echo "Downloading $n files..."
  for i in "${wjid[@]}"; do
    wait "$i"
    echo "PID: $i finished..."
  done
  echo "Finished downloading $n files in $1!"
  echo "Unzipping $n files..."
  for z in "$d$1/?E/*.gz"; do
    gunzip $z && rm -f $z &
  done
  wait ;
  echo "$1 ready for processing!"
fi
