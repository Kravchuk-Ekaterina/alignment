# Trees
Here I use the following software:<br>
- trimAl v1.4.rev15 build[2013-12-17].<br>
- RAxML-NG v. 0.9.0 released on 20.05.2019 by The Exelixis Lab<br>
- modeltest-ng-0.1.6<br>
- IQ-TREE multicore version 2.0.3 for Linux 64-bit built Dec 20 2020 <br>
- PartitionFinder-2.1.1

Installing software:<br>
```bash
conda install -c bioconda trimal
conda install -c bioconda raxml-ng
conda install -c bioconda modeltest-ng
conda install -c bioconda iqtree
```
I work with nucleotide sequences of gene of translation termination factor (SUP35) from different species of yeasts aligned using prank:<br>
```bash
prank -codon -d=SUP35_10seqs.fa -o=SUP35_aln -F
```
The data is in ./data/raw_data
## 1. Filtering: trimal
I cut out bad fragments from alignment with trimAl:
```bash
trimal -in ./data/raw_data/SUP35_aln_prank.best.fas -out ./data/processed_data/SUP35_aln_prank.trim.fas -automated1
```
We can see that gaps were removed (Supplementary, Fig. 1)<br>
## 2. Model selection: ModelTest-NG
```bash
modeltest-ng-static -i ./data/processed_data/SUP35_aln_prank.trim.fas -o ./data/processed_data/SUP35_aln_prank_trim_modeltest
```
## 3. ModelTest model selection results
The output from the previous step is:<br>
```bash
Partition 1/1:
                         Model         Score        Weight
----------------------------------------------------------
       BIC             TIM3+G4    18180.5947        0.4140
       AIC            GTR+I+G4    18038.1381        0.7674
      AICc            GTR+I+G4    18038.1381        0.7674
```
So I choose TIM3+G4 according to BIC <br>
## 4. Building a ML-tree in RAxML-NG using the selected model.
Checking the alignment
```bash
raxml-ng --check --msa ./data/processed_data/SUP35_aln_prank.trim.fas  --model TIM3+G4 --prefix ./data/processed_data/SUP35_raxml_test
```
everything is ok. Building a tree:
```bash
raxml-ng --msa ./data/processed_data/SUP35_aln_prank.trim.fas --model TIM3+G4 --prefix ./data/processed_data/SUP35_raxml --threads 2 --seed 222 
```
## 5. Drawing the resulting tree

```{r}
library(ggtree)
tr <- read.tree("data/processed_data/SUP35_raxml.raxml.bestTree")
ggtree(tr) + geom_tiplab() + xlim(0,2)
```
The same script is in raxml_tree.R<br>
Supplementary, fig. 1
## 6. Choosing a model in ModelFinder (using IQ-TREE)
IQ-TREE1
```bash
iqtree -s ./data/processed_data/SUP35_aln_prank.trim.fas -m MFP -pre ./data/processed_data/SUP35_MF
```
IQ-TREE2
```bash
iqtree2 -m MFP -s ./data/processed_data/SUP35_aln_prank.trim.fas --prefix ./data/processed_data/SUP35_MF2
```
## 7. ModelFinder model selection results
The output:
```bash
Best-fit model: TIM3+F+G4 chosen according to BIC
```
So the results are the same
## 8. Buildind a ML-tree in IQ-TREE using the chosen model.
```bash
iqtree2 -m TIM3+F+G4 -s ./data/processed_data/SUP35_aln_prank.trim.fas --prefix ./data/processed_data/SUP35_iqtree
```
## 9. Tree built with IQ-TREE visualization
I visualized the tree using the following R script:
```{r}
library(ggtree)
tr <- read.tree("data/processed_data/SUP35_MF2.treefile")
ggtree(tr) + geom_tiplab() + xlim(0,2)
```
The same script is in iqtree2_tree.R<br>
Supplementary, fig. 2. Topologicaly it's the same.
## 10. Comparing trees build using another alignments (unfiltered and/or made by another algorithms)
Building tree for unfiltered data:
```bash
iqtree2 -s ./data/raw_data/SUP35_aln_prank.best.fas -pre ./data/processed_data/SUP35_prank_unfilt
iqtree2 -s ../alignment/data/processed_data/SUP35_10seqs_kalign.fa -pre data/processed_data/SUP35_kalign
iqtree2 -s ../alignment/data/processed_data/SUP35_10seqs_clustalw.fa -pre data/processed_data/SUP35_clustalw
iqtree2 -s ../alignment/data/processed_data/SUP35_10seqs_mafft.fa -pre data/processed_data/SUP35_mafft
iqtree2 -s ../alignment/data/processed_data/SUP35_10seqs_muscle.fa -pre data/processed_data/SUP35_muscle
iqtree2 -s ../alignment/data/processed_data/SUP35_10seqs_tcoffee.fa -pre data/processed_data/SUP35_tcoffee
```
Filtering data for other alignments:
```bash
trimal -in ../alignment/data/processed_data/SUP35_10seqs_kalign.fa -out ./data/processed_data/SUP35_10seqs_kalign.trim.fa -automated1
trimal -in ../alignment/data/processed_data/SUP35_10seqs_clustalw.fa -out ./data/processed_data/SUP35_10seqs_clustalw.trim.fa -automated1
trimal -in ../alignment/data/processed_data/SUP35_10seqs_mafft.fa -out ./data/processed_data/SUP35_10seqs_mafft.trim.fa -automated1
trimal -in ../alignment/data/processed_data/SUP35_10seqs_muscle.fa -out ./data/processed_data/SUP35_10seqs_muscle.trim.fa -automated1
trimal -in ../alignment/data/processed_data/SUP35_10seqs_tcoffee.fa -out ./data/processed_data/SUP35_10seqs_tcoffee.trim.fa -automated1
```
Building trees for other filtered alignments:
```bash
iqtree2 -s ../alignment/data/processed_data/SUP35_10seqs_kalign.trim.fa -pre data/processed_data/SUP35_kalign
iqtree2 -s ../alignment/data/processed_data/SUP35_10seqs_clustalw.trim.fa -pre data/processed_data/SUP35_clustalw
iqtree2 -s ../alignment/data/processed_data/SUP35_10seqs_mafft.trim.fa -pre data/processed_data/SUP35_mafft
iqtree2 -s ../alignment/data/processed_data/SUP35_10seqs_muscle.trim.fa -pre data/processed_data/SUP35_muscle
iqtree2 -s ../alignment/data/processed_data/SUP35_10seqs_tcoffee.trim.fa -pre data/processed_data/SUP35_tcoffee
```
According to the information extracted from log files, the best algorithm for this data are prank and muscle. Kalign is the worst.<br>
After filtering the likehood for all the algorithms grow, but the ranking stays the same.
## 11. Analysis in PartitionFinder
Preparing the data in phylip format:
```bash
trimal -in data/raw_data/SUP35_aln_prank.best.fas -out ./data/partitionfinder/SUP35_aln.best.t.phy -phylip
```
Running PartitionFinder:
```bash
python ../../bin/partitionfinder-2.1.1/PartitionFinder.py data/partitionfinder
```
The config file id attached. It is in ./data/partotionfinder/partitions.cfg
The best variant is separate. All 6 cases (all 3 position in codons for all 2 parts) should be observed separate.<br>
Building the tree:
```bash
iqtree2 -s ./data/raw_data/SUP35_aln_prank.best.fas -q ./data/partitionfinder/partitions.nex --prefix ./data/processed_data/SUP35_aln_prank.best.partitions
```
I visualize the tree using the following code:
```{r}
library(ggtree)
tr <- read.tree("data/processed_data/SUP35_aln_prank.best.partitions.treefile")
ggtree(tr) + geom_tiplab() + xlim(0,2)
```
The same script is in partitions_tree.R<br>
Supplementary, fig. 3 <br>
The topology has changed.<br>
The likehood increased comparing with initial unfiltered data (it became -9559.497)
