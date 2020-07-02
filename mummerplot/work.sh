~/software/MUMmer3.23/nucmer -b 200 duck.fa ~/reads/06.genome/01.ggal_6a_ncbi/chicken.fa ###will generate out.delta
~/software/MUMmer3.23/delta-filter -1 -l 200  out.delta > out.delta.fil
~/software/MUMmer3.23/show-coords -H -c -l -o -r -T out.delta.fil > out.delta.fil.coords
perl ../bin/coords_sum.pl duck.sizes > duck.sizes.coords
perl ../bin/coords_sum.pl chicken.sizes > chicken.sizes.coords
perl ../bin/coords2plotData.v1.pl out.delta.fil.coords duck.sizes.coords chicken.sizes.coords > duck_chicken.sizes.coords
paste duck.sizes.coords chicken.sizes.coords  | awk '{print $3"\t"$6"\t"$1"\t"$4}' > axis.txt

Rscript mummerplot.R

