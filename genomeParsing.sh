#!/bin/bash
echo 'Please input current directory name containing all gtf and fasta files (something unique. no spaces.): '
read directory
cd ~
cd "$(find -type d -and -iname $directory)"
#HERE: Update this list with the genera to be analyzed.
#ALSO: FASTA and GTF intial files need to be renamed to $GENUS.$EXT (e.g. MC.fa). If you have a better way to do this, let me know.
genera='MC MMC MMD MMM MP MS'
#HERE: Update this list with the genes to be analyzed.
genes='ATM ATR BLM'
pwd
read -p 'Is this directory correct? ' approval
case "$approval" in
    y|Y|yes|Yes|YES )
        for gene in $genes ; do
           for genus in $genera ; do
               grep -i "$gene" "$genus".gtf | grep -e "CDS" > "$gene.$genus.CDS.gtf"
               bedtools getfasta -name -fi "$genus.fa" -bed "$gene.$genus.gtf" -fo "$gene.$genus.CDS.fa"
            done
        done ;;
    * ) echo "Not approved. Exiting."
        exit 1 ;;
esac
