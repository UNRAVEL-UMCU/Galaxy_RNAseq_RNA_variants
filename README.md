# Galaxy_RNAseq_RNA_variants

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about-the-project">About The Project</a></li>
    <li><a href="#galaxy">Galaxy-pipeline</a></li>
    <li><a href="#rscripts">R scripts</a></li>
    <li><a href="#local-galaxy">Local Galaxy</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project

<!-- galaxy -->
## Galaxy-pipeline
<p>
  Conversion CRAM to BAM Workflow: Galaxy-Workflow-CRAM-SAM-BAM-VCF.ga
  <ol>
    <li>Samtools view</li>
    <li>Replace chromosome names</li>
    <li>chromosome_replace.txt</li>
    <li>Samtools view</li>
    <li>AddOrReplaceReadGroups</li>
    <li>FreeBayes</li>    
  </ol>
</p>

<p>
  Step 1: Samtools view
SAM/BAM/CRAM data set = Select at Runtime.
What would you like to look at? = All reads in the input dataset
What would you like to have reported? = The actual reads
Read Reformatting Options:
Collapse backward CIGAR operation = False
Output format = SAM
Include SAM header in the output? = False
Use a reference sequence = Use a built-in genome
Reference = hg19 Full
Step 2: Replace chromosome names
Tabular input dataset = Output 'outputsam' from Step 1.
Columns on which to perform the replacement = 3
Mapping table = Select at Runtime.
Comment character = Empty.
Step 3: Samtools view
SAM/BAM/CRAM data set = Output 'output' from Step 2.
What would you like to look at? = All reads in the input dataset
What would you like to have reported? = The actual reads
Read Reformatting Options:
Collapse backward CIGAR operation = False
Output format = BAM (-b)
Use a reference sequence = Use a built-in genome
Reference = hg19
Step 4: AddOrReplaceReadGroups
Select SAM/BAM dataset or dataset collection = Output 'outputsam' from Step 3.
Auto-assign = True
Auto-assign = True
Auto-assign = True
Platform/technology used to produce the reads (PL) = ILLUMINA
Platform unit (PU) = run
Sequencing center that produced the read (CN) = Not available.
Description (DS) = Not available.
Predicted median insert size (PI) = Not available.
Date that run was produced (DT) = Not available.
Select validation stringency = Lenient
Step 5: FreeBayes
Choose the source for the reference genome = Locally cached
Run in batch mode? = Run individually
BAM or CRAM dataset = Output 'outFile' from Step 4.
Using reference genome = hg19
Limit variant calling to a set of regions? = Do not limit
Read coverage = Use defaults
Choose parameter selection level = 1. Simple diploid calling
</p>

<!-- rscripts -->
## R scripts

<!-- contact -->
## Local Galaxy
<p>
  <ol>
    <li>Resizing the <a href="https://support.mydre.org/portal/en/kb/articles/resizevm" target="_blank">VM</a></li>
    <li>Cannot connect to <a href="https://support.mydre.org/portal/en/kb/articles/i-cannot-connect-to-vm-1-2-3-error#Problem" target="_black">VM</a></li>
    <li>Log in via <a href="https://support.mydre.org/portal/en/kb/articles/connect-to-virtual-machine-using-bastion" target="_black">Bastion</a> on the workstation</li>
    <li>Proxy <a href="https://support.mydre.org/portal/en/kb/articles/proxy-configurations" target="_blank">configurations</a></li>
  </ol>
</p>

<!-- acknowledgments -->
## Acknowledgments



