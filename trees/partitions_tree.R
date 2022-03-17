library(ggtree)
tr <- read.tree("data/processed_data/SUP35_aln_prank.best.partitions.treefile")
ggtree(tr) + geom_tiplab() + xlim(0,2)
