library(ggtree)
tr <- read.tree("data/processed_data/SUP35_MF2.treefile")
ggtree(tr) + geom_tiplab() + xlim(0,2)
