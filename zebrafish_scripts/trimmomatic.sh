#inpupt: FASTQ file(s) and output base file name in this specific order. (ex: bash trimmomatic.sh sample_1.fastq sample_2.fastq sample_trimmed)

#output: gunzipped fastq files for paired and unpaired reads (reverse and/or foward) named based on the input

#goal: Perform the tool trimmomatic on fastq files to trim adapters and low quality sequences. The 2:30:10 means that initially Trimmomatic will look for seed matches (16 bases) allowing maximally 2 mismatches. These seeds will be extended and clipped if in the case of paired end reads a score of 30 is reached (about 50 bases), or in the case of single ended reads a score of 10, (about 17 bases). The 4:20 indicates the sliding window and will scan the read with a 4-base wid sliding window, cutting when the average quality per base drops below 20. 

#The location of the adapter files for Trimmomatic are hardcoded into this script for both paired and singled end: /opt/software/external/trimmomatic/trimmomatic-0.36/adapters/TruSeq3

case $# in
  3)
    java -jar /opt/software/external/trimmomatic/trimmomatic-0.36/trimmomatic-0.36.jar PE -threads 2 -phred33 $1 $2 -baseout $3 ILLUMINACLIP:/opt/software/external/trimmomatic/trimmomatic-0.36/adapters/TruSeq3-PE.fa:2:30:10 SLIDINGWINDOW:4:20
    echo "paired end"
    ;;
  2)
    java -jar /opt/software/external/trimmomatic/trimmomatic/trimmomatic-0.36.jar SE -threads 2 -phred33 $1 $2 ILLUMINACLIP:/opt/software/external/trimmomatic/trimmomatic/adapters/TruSeq3-SE.fa:2:30:10 SLIDINGWINDOW:4:20
    echo "single end"
    ;;
esac
