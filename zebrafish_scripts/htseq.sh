#input: BAM file produced from hisat2 analysis

#output: tabular data that is forced into a text document with the name of (filename)_htseq.txt

#goal: perform htseq-count tool on BAM files from HISAT2 with reference genome of zebrafish. The -f option indicates the file format and the -s option indicates whether the data is from a strand-specific assay.

#The zebrafish references genome (.gtf) is hardcoded in this script with /data/scratch/ensembl-92/danio_rerio-gtf/Danio_rerio.GRCz11.92.gtf

htseq-count -f bam -s no $1 /data/scratch/ensembl-92/danio_rerio-gtf/Danio_rerio.GRCz11.92.gtf > ${1}_htseq.txt
