# Topology and rooting
## Topology stability estimation
### 1. 100 replicas of regular bootstrap
Regular bootstrap:
```bash
iqtree2 -s ./data/raw_data/SUP35_aln_prank.trim.fas -m TIM3+F+G4 -pre ./data/processed_data/SUP35_TIM3
```
Standard bootsrap with 100 replicas:
```bash
iqtree2 -s ./data/raw_data/SUP35_aln_prank.trim.fas -m TIM3+F+G4 -pre ./data/processed_data/SUP35_TIM3_b -b 100
```
### 2. 1000 replicas of ultrafast bootstrap
```bash
iqtree2 -s ./data/raw_data/SUP35_aln_prank.trim.fas -m TIM3+F+G4 -pre ./data/processed_data/SUP35_TIM3_ufb -B 1000
```
### 3. Comparing regular and ultrafast bootstrap speed
Time for 100 replicas of standard bootstrap:
```bash
real    1m36,104s
user    1m54,359s
sys     0m1,551s
```
Time for 1000 replicas of ultrafast bootstrap:
```bash
real    0m3,228s
user    0m3,388s
sys     0m0,040s
```
For regular bootstrap it took about 96/100 ~ 1 s per replica, for ultrafast bootstrap ~ 0.003338 ms per replica. Utrafast bootstrap is ~300000 times faster
### 4. With 1000 uftrafast bootstrap + 1000 alrt + abayes
```bash
iqtree2 -s ./data/raw_data/SUP35_aln_prank.trim.fas -m TIM3+F+G4 -pre ./data/processed_data/SUP35_TIM3_B_alrt_abayes -B 1000 -alrt 1000 -abayes
```
### 5-6. Drawing trees
I drew the trees using iTOL (Interactive Tree of Life), Supplementary, fig. 1-4.<br>
All the trees have the same points which are reliable. It's possible to use ultrafast bootstrap to save time and get close results. 
## Rooting
### 7. Rooting a tree with associated data concerning the specified outgroup
```bash
iqtree2 -s ./data/raw_data/SUP35_aln_prank.trim.fas -m TIM3+F+G4 -pre ./data/processed_data/SUP35_TIM3_root_outgroup -o SUP35_Kla_AB039749,SUP35_Agos_ATCC_10895_NM_211584
```
### 8. Rooting with midpoint rooting in iTOL
In Control panel chose 'Adwamced', 'Other functions' and 'Midpoint root'<br>
Results: see Supplementary, fig.5
### 9. Non-reversible rooting in iq-tree2
```bash
iqtree2 -s ./data/raw_data/SUP35_aln_prank.trim.fas -m TIM3+F+G4 -pre ./data/processed_data/SUP35_TIM3_root_auto --model-joint 12.12 -B 1000
```
### 10. Drawing tree with rootstrap
I drew the tree in iTOL. Supplementary, fig. 6.
