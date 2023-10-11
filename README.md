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
<div align="center">
  <img src="pipeline.pdf" alt="Logo" width="80" height="80">
</div>

<p>
  Conversion CRAM to BAM Workflow: Galaxy-Workflow-CRAM-SAM-BAM-VCF.ga
  <ol>
    <li>Samtools view</li>
    <li>Replace chromosome names, use chromosome_replace.txt</li>
    <li>Samtools view</li>
    <li>AddOrReplaceReadGroups</li>
    <li>FreeBayes</li>    
  </ol>
</p>

<p>
  <ol>
    <li>Step 1: Samtools view
      <ul>
        <li>SAM/BAM/CRAM data set = Select at Runtime.</li>
        <li>What would you like to look at? = All reads in the input dataset</li>
        <li>What would you like to have reported? = The actual reads</li>
        <li>Read Reformatting Options:</li>
        <li>Collapse backward CIGAR operation = False</li>
        <li>Output format = SAM</li>
        <li>Include SAM header in the output? = False</li>
        <li>Use a reference sequence = Use a built-in genome</li>
        <li>Reference = hg19 Full</li>
      </ul>
    </li>
      <li>Step 2: Replace chromosome names
      <ul>
        <li>Tabular input dataset = Output 'outputsam' from Step 1.</li>
        <li>Columns on which to perform the replacement = 3</li>
        <li>Mapping table = Select at Runtime.</li>
        <li>Comment character = Empty.</li>
      </ul>
    </li>
      <li>Step 3: Samtools view
      <ul>
        <li>SAM/BAM/CRAM data set = Output 'output' from Step 2.</li>
        <li>What would you like to look at? = All reads in the input dataset</li>
        <li>What would you like to have reported? = The actual reads</li>
        <li>Read Reformatting Options:</li>
        <li>Collapse backward CIGAR operation = False</li>
        <li>Output format = BAM (-b)</li>
        <li>Use a reference sequence = Use a built-in genome</li>
        <li>Reference = hg19</li>
      </ul>
    </li>
      <li>Step 4: AddOrReplaceReadGroups
      <ul>
        <li>Select SAM/BAM dataset or dataset collection = Output 'outputsam' from Step 3.</li>
        <li>Auto-assign = True</li>
        <li>Auto-assign = True</li>
        <li>Auto-assign = True</li>
        <li>Platform/technology used to produce the reads (PL) = ILLUMINA</li>
        <li>Platform unit (PU) = run</li>
        <li>Sequencing center that produced the read (CN) = Not available.</li>
        <li>Description (DS) = Not available.</li>
        <li>Predicted median insert size (PI) = Not available.</li>
        <li>Date that run was produced (DT) = Not available.</li>
        <li>Select validation stringency = Lenient</li>        
      </ul>
    </li>
    <li>Step 5: FreeBayes
      <ul>
        <li>Choose the source for the reference genome = Locally cached</li>
        <li>Run in batch mode? = Run individually</li>
        <li>BAM or CRAM dataset = Output 'outFile' from Step 4.</li>
        <li>Using reference genome = hg19</li>
        <li>Limit variant calling to a set of regions? = Do not limit</li>
        <li>Read coverage = Use defaults</li>
        <li>Choose parameter selection level = 1. Simple diploid calling</li>
      </ul>
    </li>
  </ol>
</p>

<!-- rscripts -->
## R scripts
<p>
  Datasets for plotting can be found on the UMC Utrecht werkstation
</p>

<!-- Local galaxy -->
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



