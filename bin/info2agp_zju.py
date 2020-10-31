#!/usr/bin/env python3

def formatAGP(infoFile, gap):
	from collections import defaultdict

	dic = defaultdict(lambda: 1)
	idx = defaultdict(lambda: 1)

	with open(infoFile) as f:
		for line in f:
			line = line.rstrip()
			tmp = line.split()
			chr = tmp[0]
			scaf = tmp[1]
			bg = int(tmp[2])
			ed = int(tmp[3])
			orient = tmp[4]
			l = ed-bg+1
			start = dic[chr]
			end = start+l-1
			print('%s\t%i\t%i\t%i\tW\t%s\t%i\t%i\t%s' % (chr, start, end, idx[chr], scaf, bg, ed, orient))
			dic[chr] = end+1+gap
			idx[chr] += 1

def main():
	import sys
	if len(sys.argv) != 3:
		sys.exit('python3 %s <chr.info> <gap>' % (sys.argv[0]))

	infoFile = sys.argv[1]
	gap = int(sys.argv[2])

	formatAGP(infoFile, gap)
	

if __name__ == '__main__':
	main()

