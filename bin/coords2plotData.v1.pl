#==============================================================
# File Name: ../../bin/coords2plotData.v1.pl
# Author: yingyingwang
# mail: wangyingying@wias.org.cn
# Created Time: Sat 16 Mar 2019 03:43:46 PM CST
#=============================================================
#!/usr/bin/perl -w
use strict;

die "perl $0 <cords> <ref.sizes> <qry.sizes>" unless @ARGV==3;

my %hash;
my %hash1;
open IN, $ARGV[1];
while (<IN>) {
        chomp;
        my @in = split /\s+/;
        $hash{$in[0]} = $in[2];
};

open IN, $ARGV[2];
while (<IN>) {
        chomp;
        my @in = split /\s+/;
        $hash1{$in[0]} = $in[2];
};

open IN, $ARGV[0];
while (<IN>) {
        chomp;
        my @in = split /\s+/;
        if ($in[2]>$in[3] and exists $hash{$in[11]} and exists $hash1{$in[12]}) {
                $in[0]+=$hash{$in[11]};
                $in[1]+=$hash{$in[11]};
                $in[2]+=$hash1{$in[12]};
                $in[3]+=$hash1{$in[12]};
                print join("\t",@in)."\t-\n";
        }elsif($in[2]<$in[3] and exists $hash{$in[11]} and exists $hash1{$in[12]}) {
                $in[0]+=$hash{$in[11]};
                $in[1]+=$hash{$in[11]};
                $in[2]+=$hash1{$in[12]};
                $in[3]+=$hash1{$in[12]};
                print join("\t",@in)."\t+\n";
        };
};

