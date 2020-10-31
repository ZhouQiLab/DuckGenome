python3 ../bin/info2agp_zju.py psudo_chr.info 10000 > psudo_chr.info.agp
python3 ../bin/link_chr.fa_zju.py psudo_chr.info.agp scaffold.fa > chr.fa
