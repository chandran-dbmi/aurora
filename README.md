# Aurora

## 1. Data:  
The data transferred can be found under:
`/pghbio/aurora/data/received`

We have received four different analysis so far:  
a. Biospecimen *(55 xml files)*  
b. RNA-Seq *(**rna/**: 150 fastqs, 75 BAMs, 75 quant.sf and **rna2/**: 324 fastqs, 162 BAMs)*  
c. Methylation *(Level1: 396 idats, Level2: 198 tsv, Level3: 198 tsv, Level4: 1 tsv)*  
d. Variant calling  

They can be seen in the following folders:
```
achakka: received$ pwd
/pghbio/aurora/data/received
achakka: received$ ls -lh
total 220K
drwxrwxr-x+ 4 ropelews mc5fp7p  12K Oct 29 09:00 biospecimen
drwxrwxr-x+ 2 ropelews mc5fp7p  18K Aug 24 02:32 genome
drwxrwxr-x+ 3 ropelews mc5fp7p  12K Oct 18 10:44 meth
drwxrwxr-x+ 3 ropelews mc5fp7p  50K Dec 11 21:35 rna
drwxr-xr-x+ 2 ropelews mc5fp7p 130K Jan 25 20:19 rna2
```

A more details description of the files is given below.
### 1.a. Biospecimen
The biospecimen folder contains all the xml details of the patient samples. The xml files have been organized in two folder and in total we have *55 xml* files.  

**1.a.i. Files**  
The files are located in the following directories:
```
achakka: biospecimen$ pwd
/pghbio/aurora/data/received/biospecimen
achakka: biospecimen$ ls -lh
total 6.2M
drwxrwxr-x+ 2 jmw004 mc5fp7p  12K Jul 19  2018 nationwidechildrens.org_BRCA.bio.Level_1.517.0.AUR
-rw-rwx---+ 1 jmw004 mc5fp7p 1.3M Oct 29 08:56 nationwidechildrens.org_BRCA.bio.Level_1.517.0.AUR.tar
drwxrwxr-x+ 2 jmw004 mc5fp7p  14K Jul 19  2018 nationwidechildrens.org_BRCA.bio.Level_1.620.0.AUR
-rw-rwx---+ 1 jmw004 mc5fp7p 3.9M Oct 29 08:57 nationwidechildrens.org_BRCA.bio.Level_1.620.0.AUR.tar
achakka: biospecimen$ ls *
nationwidechildrens.org_BRCA.bio.Level_1.517.0.AUR.tar  nationwidechildrens.org_BRCA.bio.Level_1.620.0.AUR.tar

nationwidechildrens.org_BRCA.bio.Level_1.517.0.AUR:
nationwidechildrens.org_biospecimen.AUR-AD9E.xml  nationwidechildrens.org_biospecimen.AUR-AD9G.xml  nationwidechildrens.org_biospecimen.AUR-AD9I.xml  README.txt
nationwidechildrens.org_biospecimen.AUR-AD9F.xml  nationwidechildrens.org_biospecimen.AUR-AD9H.xml  nationwidechildrens.org_biospecimen.AUR-AD9J.xml  SUBMISSION.json

nationwidechildrens.org_BRCA.bio.Level_1.620.0.AUR:
nationwidechildrens.org_biospecimen.AUR-ADCB.xml  nationwidechildrens.org_biospecimen.AUR-AF98.xml  nationwidechildrens.org_biospecimen.AUR-AFSL.xml
nationwidechildrens.org_biospecimen.AUR-AE5G.xml  nationwidechildrens.org_biospecimen.AUR-AF99.xml  nationwidechildrens.org_biospecimen.AUR-AFSO.xml
nationwidechildrens.org_biospecimen.AUR-AE5H.xml  nationwidechildrens.org_biospecimen.AUR-AF9A.xml  nationwidechildrens.org_biospecimen.AUR-AFSP.xml
nationwidechildrens.org_biospecimen.AUR-AE6X.xml  nationwidechildrens.org_biospecimen.AUR-AFE4.xml  nationwidechildrens.org_biospecimen.AUR-AFUG.xml
nationwidechildrens.org_biospecimen.AUR-AE6Y.xml  nationwidechildrens.org_biospecimen.AUR-AFE5.xml  nationwidechildrens.org_biospecimen.AUR-AFUI.xml
nationwidechildrens.org_biospecimen.AUR-AEPZ.xml  nationwidechildrens.org_biospecimen.AUR-AFE6.xml  nationwidechildrens.org_biospecimen.AUR-AFUK.xml
nationwidechildrens.org_biospecimen.AUR-AER2.xml  nationwidechildrens.org_biospecimen.AUR-AFE7.xml  nationwidechildrens.org_biospecimen.AUR-AFUL.xml
nationwidechildrens.org_biospecimen.AUR-AER4.xml  nationwidechildrens.org_biospecimen.AUR-AFE9.xml  nationwidechildrens.org_biospecimen.AUR-AFUM.xml
nationwidechildrens.org_biospecimen.AUR-AER5.xml  nationwidechildrens.org_biospecimen.AUR-AFEA.xml  nationwidechildrens.org_biospecimen.AUR-AFUN.xml
nationwidechildrens.org_biospecimen.AUR-AER6.xml  nationwidechildrens.org_biospecimen.AUR-AFEC.xml  nationwidechildrens.org_biospecimen.AUR-AFUO.xml
nationwidechildrens.org_biospecimen.AUR-AER7.xml  nationwidechildrens.org_biospecimen.AUR-AFKB.xml  nationwidechildrens.org_biospecimen.AUR-AFUP.xml
nationwidechildrens.org_biospecimen.AUR-AER8.xml  nationwidechildrens.org_biospecimen.AUR-AFKD.xml  nationwidechildrens.org_biospecimen.AUR-AG0J.xml
nationwidechildrens.org_biospecimen.AUR-AERW.xml  nationwidechildrens.org_biospecimen.AUR-AFKF.xml  nationwidechildrens.org_biospecimen.AUR-AG0M.xml
nationwidechildrens.org_biospecimen.AUR-AERX.xml  nationwidechildrens.org_biospecimen.AUR-AFR2.xml  nationwidechildrens.org_biospecimen.AUR-AG0N.xml
nationwidechildrens.org_biospecimen.AUR-AERY.xml  nationwidechildrens.org_biospecimen.AUR-AFR3.xml  nationwidechildrens.org_biospecimen.AUR-AG12.xml
nationwidechildrens.org_biospecimen.AUR-AF94.xml  nationwidechildrens.org_biospecimen.AUR-AFR4.xml  README.txt
nationwidechildrens.org_biospecimen.AUR-AF95.xml  nationwidechildrens.org_biospecimen.AUR-AFR5.xml  SUBMISSION.json
achakka: biospecimen$ ls */*.xml | wc -l
55

```
**1.a.ii. Issues**  
None

### 1.b. RNA-Seq
The RNA-Seq files were submitted in two different folders: `rna/` and `rna2/`.
**1.b.i. Files**  
Under `rna/`, we can find the following files:
```
achakka: rna$ pwd
/pghbio/aurora/data/received/rna
achakka: rna$ ls *.bam | wc -l
75
achakka: rna$ ls *.quant.sf | wc -l
75
achakka: rna$ cd fastq/
achakka: fastq$ pwd
/pghbio/aurora/data/received/rna/fastq
achakka: fastq$ ls *.fastq.gz | wc -l
150
```
Under `rna2/`, we can find the following folders:
```
achakka: rna2$ pwd
/pghbio/aurora/data/received/rna2
achakka: rna2$ ls *.bam | wc -l
162
achakka: rna2$ ls *.fastq.gz | wc -l
324
```

RNA-Seq workflow was provided by UNC as following:
```
refdir=/datastore/nextgenout4/share/labs/bioinformatics/seqware/ref/hg38/
scriptdir=/datastore/scripts
outdir=/home/testSample
picarddir=/datastore/software/picard-tools-1.86
fq1=/home/test_r1.fastq.gz
fq2=/home/test_r2.fastq.gz

#STAR:
STAR --genomeDir $refdir/star_hg38_d1 --readFilesCommand zcat --readFilesIn $fq1 $fq2 --outSAMunmapped Within --outSAMtype BAM Unsorted --quantMode TranscriptomeSAM --runThreadN 16 --outFileNamePrefix $outdir/STAR_ #docker cpus:16 mem:4

#sort bam file
samtools sort -o $outdir/STAR_Aligned.out.sort.bam $outdir/STAR_Aligned.out.bam #docker mem:8

#index bam file
samtools index $outdir/STAR_Aligned.out.sort.bam #docker mem:4

#Salmon:
salmon quant -t $refdir/transcripts_hg38/gencode.v22.pc_transcripts.fa -l IU -a $outdir/STAR_Aligned.toTranscriptome.out.bam -o $outdir/Salmon_out # docker mem:8

#Picard rna-seq QC
java  -Xms4G -Xmx4G -XX:ParallelGCThreads=1 -jar $picarddir/CollectRnaSeqMetrics.jar REF_FLAT=$refdir/refFlat_hg38.txt RIBOSOMAL_INTERVALS=$refdir/hg38d1_rmsk_rrna.txt STRAND_SPECIFICITY=NONE CHART_OUTPUT=$outdir/RNAqc.pdf METRIC_ACCUMULATION_LEVEL=ALL_READS INPUT=$outdir/STAR_Aligned.out.sort.bam OUTPUT=$outdir/RNAqc.txt VALIDATION_STRINGENCY=SILENT # docker mem:8

#Summarize isoform and gene level
echo -e "\t$outdir/Salmon_out/quant.sf" > $outdir/Salmon_out/salmon_isoform.txt
sed -i 's|t/datastore|\t/datastore|g' $outdir/Salmon_out/salmon_isoform.txt
cut -f 1,5 $outdir/Salmon_out/quant.sf >> $outdir/Salmon_out/salmon_isoform.txt

java -Xmx4G -cp $scriptdir salmonIsoformToGene $outdir/Salmon_out/salmon_isoform.txt $refdir/transcripts_hg38/gencode.v22.annotation.gtf > $outdir/Salmon_out/salmon_gene.txt # docker mem:8

Rscript $scriptdir/normalizeGenes.R $outdir/Salmon_out/salmon_gene.txt $outdir/Salmon_out/salmon_gene_normalized.txt #docker mem:4

rm -rfv $outdir/working/* # cleanup
rm $outdir/STAR_Aligned.toTranscriptome.out.bam && rm $outdir/STAR_Aligned.out.bam # cleanup
```
**1.b.ii. Issues**  
1. Only transcript level expression values were provided.
2. We haven't received isoform and gene level files as described in the workflow yet.

### 1.c. Methylation
Four level of files were provided for Methylation data. 
**1.c.i. Files**  
The files are located in the following directories:
```
achakka: VARI_MethylationEPIC$ pwd
/pghbio/aurora/data/received/meth/VARI_MethylationEPIC
achakka: VARI_MethylationEPIC$ ls -lh
total 502M
-rwxr-xr--+ 1 ropelews mc5fp7p 178K Sep 23 08:47 Data.description_180921.pdf
-rwxr-xr--+ 1 ropelews mc5fp7p 230M Sep 14 10:38 EPIC.hg38.manifest.gencode.v22.tsv.gz
-rwxr-xr--+ 1 ropelews mc5fp7p 272M Sep 14 10:38 EPIC.hg38.manifest.tsv.gz
-r--r-xr--+ 1 ropelews mc5fp7p  194 Sep 23 11:00 @MD5_checksum.txt
drwxr-xr-x+ 6 ropelews mc5fp7p  12K Sep 23 11:00 MethylationEPIC__Current
```

All the levels can be seen as follows:
```
achakka: MethylationEPIC__Current$ ls -lh
total 140K
-r--r-xr--+ 1 ropelews mc5fp7p  53 Sep 23 11:00 @MD5_checksum.txt
drwxr-xr-x+ 5 ropelews mc5fp7p 12K Sep 23 11:03 MethylationEPIC_Level_1.Batch.Version
drwxr-xr-x+ 5 ropelews mc5fp7p 12K Sep 23 11:04 MethylationEPIC_Level_2.Batch.Version
drwxr-xr-x+ 5 ropelews mc5fp7p 12K Sep 23 11:04 MethylationEPIC_Level_3.Batch.Version
drwxr-xr-x+ 2 ropelews mc5fp7p 12K Sep 23 11:02 MethylationEPIC_Level_4.Version
-rwxr-xr--+ 1 ropelews mc5fp7p 24K Sep 21 15:34 Sample.mapping.tsv

achakka: MethylationEPIC__Current$ ls -lh MethylationEPIC_Level_1.Batch.Version/
total 77K
drwxr-xr-x+ 2 ropelews mc5fp7p 16K Sep 23 11:00 MethylationEPIC_Level_1.1.0
drwxr-xr-x+ 2 ropelews mc5fp7p 13K Sep 23 11:00 MethylationEPIC_Level_1.2.0
drwxr-xr-x+ 2 ropelews mc5fp7p 49K Sep 23 11:00 MethylationEPIC_Level_1.3.0
achakka: MethylationEPIC__Current$ ls MethylationEPIC_Level_1.Batch.Version/*/*.idat | wc -l
396

achakka: MethylationEPIC__Current$ ls -lh MethylationEPIC_Level_2.Batch.Version/
total 52K
drwxr-xr-x+ 2 ropelews mc5fp7p 14K Sep 23 11:01 MethylationEPIC_Level_2.1.0
drwxr-xr-x+ 2 ropelews mc5fp7p 12K Sep 23 11:01 MethylationEPIC_Level_2.2.0
drwxr-xr-x+ 2 ropelews mc5fp7p 27K Sep 23 11:01 MethylationEPIC_Level_2.3.0
achakka: MethylationEPIC__Current$ ls -lh MethylationEPIC_Level_2.Batch.Version/* | head
MethylationEPIC_Level_2.Batch.Version/MethylationEPIC_Level_2.1.0:
total 1.2G
-rw-r-xr--+ 1 ropelews mc5fp7p  30M Sep 23 10:00 AUR-AD9E-TTM1-A-1-1-D-A531-37_level_2.1.0.tsv
-rw-r-xr--+ 1 ropelews mc5fp7p  30M Sep 23 10:00 AUR-AD9E-TTM1-A-1-2-D-A531-37_level_2.1.0.tsv
-rw-r-xr--+ 1 ropelews mc5fp7p  30M Sep 23 10:00 AUR-AD9E-TTM1-A-2-1-D-A531-37_level_2.1.0.tsv
-rw-r-xr--+ 1 ropelews mc5fp7p  30M Sep 23 10:00 AUR-AD9E-TTM2-A-1-1-D-A531-37_level_2.1.0.tsv
-rw-r-xr--+ 1 ropelews mc5fp7p  30M Sep 23 10:00 AUR-AD9E-TTM2-A-1-2-D-A531-37_level_2.1.0.tsv
-rw-r-xr--+ 1 ropelews mc5fp7p  30M Sep 23 10:00 AUR-AD9E-TTM4-A-1-1-D-A531-37_level_2.1.0.tsv
-rw-r-xr--+ 1 ropelews mc5fp7p  30M Sep 23 10:00 AUR-AD9E-TTM4-A-1-2-D-A531-37_level_2.1.0.tsv
-rw-r-xr--+ 1 ropelews mc5fp7p  30M Sep 23 10:00 AUR-AD9E-TTM4-A-2-1-D-A531-37_level_2.1.0.tsv
achakka: MethylationEPIC__Current$ ls -lh MethylationEPIC_Level_2.Batch.Version/*/*.tsv | wc -l
198

achakka: MethylationEPIC__Current$ ls -lh MethylationEPIC_Level_3.Batch.Version/
total 52K
drwxr-xr-x+ 2 ropelews mc5fp7p 14K Sep 23 11:01 MethylationEPIC_Level_3.1.0
drwxr-xr-x+ 2 ropelews mc5fp7p 12K Sep 23 11:02 MethylationEPIC_Level_3.2.0
drwxr-xr-x+ 2 ropelews mc5fp7p 27K Sep 23 11:02 MethylationEPIC_Level_3.3.0
achakka: MethylationEPIC__Current$ ls -lh MethylationEPIC_Level_3.Batch.Version/* | head
MethylationEPIC_Level_3.Batch.Version/MethylationEPIC_Level_3.1.0:
total 969M
-rw-r-xr--+ 1 ropelews mc5fp7p  24M Sep 23 10:00 AUR-AD9E-TTM1-A-1-1-D-A531-37_level_3.1.0.tsv
-rw-r-xr--+ 1 ropelews mc5fp7p  24M Sep 23 10:00 AUR-AD9E-TTM1-A-1-2-D-A531-37_level_3.1.0.tsv
-rw-r-xr--+ 1 ropelews mc5fp7p  24M Sep 23 10:00 AUR-AD9E-TTM1-A-2-1-D-A531-37_level_3.1.0.tsv
-rw-r-xr--+ 1 ropelews mc5fp7p  25M Sep 23 10:00 AUR-AD9E-TTM2-A-1-1-D-A531-37_level_3.1.0.tsv
-rw-r-xr--+ 1 ropelews mc5fp7p  24M Sep 23 10:00 AUR-AD9E-TTM2-A-1-2-D-A531-37_level_3.1.0.tsv
-rw-r-xr--+ 1 ropelews mc5fp7p  25M Sep 23 10:00 AUR-AD9E-TTM4-A-1-1-D-A531-37_level_3.1.0.tsv
-rw-r-xr--+ 1 ropelews mc5fp7p  24M Sep 23 10:00 AUR-AD9E-TTM4-A-1-2-D-A531-37_level_3.1.0.tsv
-rw-r-xr--+ 1 ropelews mc5fp7p  25M Sep 23 10:00 AUR-AD9E-TTM4-A-2-1-D-A531-37_level_3.1.0.tsv
achakka: MethylationEPIC__Current$ ls -lh MethylationEPIC_Level_3.Batch.Version/*/*.tsv | wc -l

achakka: MethylationEPIC__Current$ ls -lh MethylationEPIC_Level_4.Version/
total 2.4G
-r--r-xr--+ 1 ropelews mc5fp7p   64 Sep 23 11:02 @MD5_checksum.txt
-rwxr-xr--+ 1 ropelews mc5fp7p 2.4G Sep 22 07:09 MethylationEPIC_level_4.0.tsv
```
**1.c.ii. Issues**  
1. The level 4 files provided only the probe id's.
2. We need to know if the annotations will be provided for them, or we need to annotated it by ourselves.

### 1.d. Variant calling
The variant calling files include the CRAM files and tsv files. They can be seen as below:
**1.d.i. Files**  
```
achakka: genome$ pwd
/pghbio/aurora/data/received/genome
achakka: genome$ ls 
0317081bc63e4d57b87f6bb3bac667c1.cram      51914196bd1548019ba1f3162701db97.cram.md5  all_sequences.fa                            AUR-AD9I-TTM3-A-1-1-D-A530-40.variants.tsv
0317081bc63e4d57b87f6bb3bac667c1.cram.md5  56490b4626d24d15a0ffd76729925312.cram      AUR-AD9E-TTM1-A-1-1-D-A530-40.variants.tsv  AUR-AD9I-TTM3-A-1-2-D-A538-40.variants.tsv
0b78216a25544aebb3021ff55ff02f1c.cram      56490b4626d24d15a0ffd76729925312.cram.md5  AUR-AD9E-TTM1-A-1-2-D-A530-40.variants.tsv  b06e22b78c0d4e84b5acea117ec863fd.cram
0b78216a25544aebb3021ff55ff02f1c.cram.md5  5db71ef95b9a446aa8598fa8f5ecb29a.cram      AUR-AD9E-TTM1-A-2-1-D-A530-40.variants.tsv  b06e22b78c0d4e84b5acea117ec863fd.cram.md5
16a9cf8ad6a84ae7a336d36859f3a0e0.cram      5db71ef95b9a446aa8598fa8f5ecb29a.cram.md5  AUR-AD9E-TTM2-A-1-1-D-A538-40.variants.tsv  b2e664b19fc44e3cb89feadc8996ea56.cram
16a9cf8ad6a84ae7a336d36859f3a0e0.cram.md5  6ebcdafea0724af39c086ce678c6af2a.cram      AUR-AD9E-TTM2-A-1-2-D-A530-40.variants.tsv  b2e664b19fc44e3cb89feadc8996ea56.cram.md5
2087de6ced5f430e99b2bafbaf685d8f.cram      6ebcdafea0724af39c086ce678c6af2a.cram.md5  AUR-AD9E-TTM4-A-1-1-D-A530-40.variants.tsv  ba6481a3985e474bbdb564f1cfc94a02.cram
2087de6ced5f430e99b2bafbaf685d8f.cram.md5  746d81b30dd245af89a08ed25da7817f.cram      AUR-AD9E-TTM4-A-1-2-D-A530-40.variants.tsv  ba6481a3985e474bbdb564f1cfc94a02.cram.md5
239365a084444321b1964ce0a63b1eb8.cram      746d81b30dd245af89a08ed25da7817f.cram.md5  AUR-AD9E-TTM4-A-2-1-D-A538-40.variants.tsv  bcb43fee90c8489c800aa54de55c7fa0.cram
239365a084444321b1964ce0a63b1eb8.cram.md5  86f8459312ea425b9f1acacb02784b79.cram      AUR-AD9G-TTM1-A-1-1-D-A530-40.variants.tsv  bcb43fee90c8489c800aa54de55c7fa0.cram.md5
296e035b327f45af8b83aaf207c2531c.cram      86f8459312ea425b9f1acacb02784b79.cram.md5  AUR-AD9G-TTM1-A-1-2-D-A530-40.variants.tsv  bddfd480a3774b36912466f06b3530c0.cram
296e035b327f45af8b83aaf207c2531c.cram.md5  88b7a03854e7454893ed2a6d9c333bce.cram      AUR-AD9G-TTM1-A-1-2-D-A538-40.variants.tsv  bddfd480a3774b36912466f06b3530c0.cram.md5
346820fcce614aecbfa9699176dede5f.cram      88b7a03854e7454893ed2a6d9c333bce.cram.md5  AUR-AD9G-TTM1-A-2-1-D-A530-40.variants.tsv  c5f2947afa00408ba52ecd0a098c6e54.cram
346820fcce614aecbfa9699176dede5f.cram.md5  89a1d908f0d24fcaa2b9ba92a3366ac1.cram      AUR-AD9G-TTM2-A-1-1-D-A530-40.variants.tsv  c5f2947afa00408ba52ecd0a098c6e54.cram.md5
3bfabd68ad90411781ef7cfa3d93a58a.cram      89a1d908f0d24fcaa2b9ba92a3366ac1.cram.md5  AUR-AD9G-TTM2-A-1-2-D-A538-40.variants.tsv  df20f068791946e8be98a48511983624.cram
3bfabd68ad90411781ef7cfa3d93a58a.cram.md5  8f93a33847ac4f20ac15046c7bf933fe.cram      AUR-AD9G-TTM2-A-2-1-D-A538-40.variants.tsv  df20f068791946e8be98a48511983624.cram.md5
4b439e193724433f80f5e27c9df1ac25.cram      8f93a33847ac4f20ac15046c7bf933fe.cram.md5  AUR-AD9G-TTM3-A-1-1-D-A530-40.variants.tsv  e97d70a106f748a6997a0a77e0662bc4.cram
4b439e193724433f80f5e27c9df1ac25.cram.md5  a505504aed6b48d687835fa23b105538.cram      AUR-AD9G-TTM3-A-1-2-D-A530-40.variants.tsv  e97d70a106f748a6997a0a77e0662bc4.cram.md5
4b7671197edf47f9a48ce2850c23c639.cram      a505504aed6b48d687835fa23b105538.cram.md5  AUR-AD9G-TTM3-A-1-2-D-A538-40.variants.tsv  f86b0de03e2640e9988c8ab04646750f.cram
4b7671197edf47f9a48ce2850c23c639.cram.md5  a8a8c5c47d834418be6b2908b7f1c52f.cram      AUR-AD9G-TTP1-B-4-0-D-A586-40.variants.tsv  f86b0de03e2640e9988c8ab04646750f.cram.md5
51914196bd1548019ba1f3162701db97.cram      a8a8c5c47d834418be6b2908b7f1c52f.cram.md5  AUR-AD9G-TTP1-B-5-0-D-A586-40.variants.tsv

achakka: genome$ ls *.cram | wc -l
30
achakka: genome$ ls *.tsv | wc -l
22

```
**1.d.ii. Issues**  
1. The number of cram files and tsv files do not match.

## 2. cBio

## 3. RNA-Seq
10-30-19

Email from Susana:
```
Hi everybody,

I have uploaded the two matrixes and 1 annotation file to genome2 and UPITT BOX:

1.	125 samples, upper quantile normalized,  no other adjustments. File name: "AURORA_UQN_Cluster_SG.5_125"
2.	125 samples, upper quantile normalized, batch corrected for FFPE vs Fresh. File name: "AURORA_UQN_125_log2_w0_70p_batch_corrected_mdctr.st"
3.	125 samples. Annotation file with the updated samples names, some clinical data, PAM50 calls and correlation to the centroids. File name: "AURORA_UQN_Cluster_SG.5_125_Annotation".

Please, let me know if you have any questions.

Susana
```

