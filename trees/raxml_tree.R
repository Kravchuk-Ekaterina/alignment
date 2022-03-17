library(ggtree)
tr <- read.tree("data/processed_data/SUP35_raxml.raxml.bestTree")
ggtree(tr) + geom_tiplab() + xlim(0,2)
