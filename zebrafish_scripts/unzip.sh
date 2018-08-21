
#input: zip file
#output: unzipped file
#goal: unzip file from FASTQC and remove the original zipped file

unzip $1 && rm -f $1
