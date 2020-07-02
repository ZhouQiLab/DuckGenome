#==============================================================
# File Name: /public/home/lijing/bin/cords_sum.pl
# Author: yingyingwang
# mail: wangyingying@wias.org.cn
# Created Time: Sat 16 Mar 2019 03:50:28 PM CST
#=============================================================
#!/usr/bin/perl -w
use strict;

die "perl $0 <sizes>" unless @ARGV==1;
use List::Util qw/sum/;

my @array;
push @array,0;
open IN,$ARGV[0];
while (<IN>) {
        chomp;
        my @in = split /\s+/;
        my $sum = sum @array;
        push @array,$in[1];
        print "$_\t$sum\n";
};

###last one
my $sum = sum @array;
print "last\tna\t$sum\n";
