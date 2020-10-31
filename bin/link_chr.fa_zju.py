#!/usr/bin/env python3

def store_fa(faFile):
	import sys
	sys.path.append('/public/home/lijing/lib/python/util_zhouyang')
	from read_file import read_file
	from Bio import SeqIO

	dic = {}

	with read_file(faFile) as f:
		for record in SeqIO.parse(f, 'fasta'):
			dic[record.id] = record.seq
	return dic

def store_agp(agpFile):
	from collections import defaultdict
	agpDic = defaultdict(lambda: defaultdict(list))

	with open(agpFile) as f:
		for line in f:
			line = line.rstrip()
			tmp = line.split('\t')
			if tmp[4] == 'N': continue
			chr = tmp[0]
			start = int(tmp[1])
			end = int(tmp[2])
			idx = int(tmp[3])
			scaf = tmp[5]
			bg = int(tmp[6])
			ed = int(tmp[7])
			orient = tmp[8]
			agpDic[chr][idx] = [start, end, scaf, bg, ed, orient]
	return agpDic

def link_fa(agpDic, faDic):
	import sys
	#import textwrap
	import re
	for chr in sorted(agpDic.keys()):
		idx_lst = sorted(agpDic[chr].keys())
		if idx_lst[-1]  == 1:
			#continue
			start, end, scaf, bg, ed, orient = agpDic[chr][idx_lst[-1]]
			seq = faDic[scaf][bg-1:ed]
			#print(bg, ed, len(seq))
			if orient == '-':
				seq = seq.reverse_complement()
			#seq = textwrap.fill(str(seq), 60)
			seq = re.sub("(.{60})", "\\1\n", str(seq), 0, re.DOTALL)
			print('>%s\n%s' % (chr, seq))
		else:
			seq = ''
			for idx in range(1, idx_lst[-1]):
				start, end, scaf, bg, ed, orient = agpDic[chr][idx]
				seq_tmp = faDic[scaf][bg-1:ed]
				if orient == '-':
					seq_tmp = seq_tmp.reverse_complement()
				seq += seq_tmp		
				gap_size = (agpDic[chr][idx+1][0]-1) - (agpDic[chr][idx][1]+1) +1
				seq += 'N' * gap_size
			start, end, scaf, bg, ed, orient = agpDic[chr][idx_lst[-1]]
			seq_tmp = faDic[scaf][bg-1:ed]
			if orient == '-':
				seq_tmp = seq_tmp.reverse_complement()
			seq += seq_tmp
			#seq = textwrap.fill(str(seq), 60)
			seq = re.sub("(.{60})", "\\1\n", str(seq), 0, re.DOTALL)
			print('>%s\n%s' % (chr, seq))

def main():
	import sys
	if len(sys.argv) != 3:
		sys.exit('python3 %s <agp> <fa>' % (sys.argv[0]))

	agpFile = sys.argv[1]
	faFile = sys.argv[2]

	faDic = store_fa(faFile)
	agpDic = store_agp(agpFile)
	link_fa(agpDic, faDic)

if __name__ == "__main__":
	main()

