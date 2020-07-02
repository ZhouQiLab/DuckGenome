/usr/local/bin/samtools faidx genome.fa
cut -f1,2 genome.fa.fai | sort -k1,1V -k2,2n  > genome.len
perl ../bin/gap2pos.pl genome.fa > genome.gap.pos
awk '{print $2"\t"$4-1"\t"$5}' genome.gap.pos | sort -k1,1V -k2,2n > genome.gap.bed
bedtools complement -i genome.gap.bed -g genome.len > genome.contig.bed
ls *.bed | while read i; do awk '{print $0"\t"$3-$2}' $i > $i.tab; done

awk '{print $0"\tcontig"}' genome.contig.bed.tab | sort -k1,1V -k2,2n > genome.contig_gap.block.bed
awk '{print $0"\tgap"}' genome.gap.bed.tab | sort -k1,1V -k2,2n >> genome.contig_gap.block.bed

sort -k1,1V -k2,2n genome.contig_gap.block.bed -o genome.contig_gap.block.bed

Rscript treemap.R

