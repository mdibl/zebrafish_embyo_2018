#input: One FASTQ file for SE HISAT2 or two FASTQ files for PE HISAT2 alignment

#output: BAM file with a name of (input)_hisat2 that will be used as input for htseq-count

#goal: to perform hisat alignment on SE/PE FASTQ files with a reference zebrafish genome.

#The basename of the index for the reference genome is hardcoded into the script as /data/transformed/hisat2-2.1.0/ensembl-92/danio_rerio-dna/hisat2-ensembl-dna


case $# in
  1)
    hisat2 -x /data/transformed//hisat2-2.1.0/ensembl-92/danio_rerio-dna/hisat2-ensembl-dna -U $1 -S ${1}_hisat2
    echo "single end hisat2"
    ;;
  2)
    hisat2 -x /data/transformed/hisat2-2.1.0/ensembl-92/danio_rerio-dna/hisat2-ensembl-dna -1 $1 -2 $2 -S ${1}_hisat2
    echo "paired end hisat2"
    ;;
esac
