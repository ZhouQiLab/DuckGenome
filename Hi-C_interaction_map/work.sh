perl ../bin/hic.generate.bed.v1.pl hic_results/matrix/duck/raw/10000/duck_10000_abs.bed select.region > new.bed
awk 'BEGIN {i=1} {print $0"\t"i;i++}' new.bed > new.bed.add
perl ../bin/sustitute.10x_matrix.v2_chain.pl new.bed.add 4 6 hic_results/matrix/duck/iced/10000/duck_10000_iced.matrix > new.matrix
sort -k1,1n -k2,2n new.matrix | awk '{if ($1<$2) {print $1"\t"$2"\t"$3} else {print $2"\t"$1"\t"$3}}' > new.matrix.tri
awk '{print $6"\t"$1}' new.bed.add > hash
perl ../bin/AddColumn.v2.pl new.matrix.tri hash 1 > new.matrix.tri.add
perl ../bin/AddColumn.v2.pl new.matrix.tri.add hash 2 > new.matrix.tri.add.add
Rscript Hi-C_map.R
