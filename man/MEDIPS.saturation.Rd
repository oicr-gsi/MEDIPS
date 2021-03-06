\name{MEDIPS.saturation}
\alias{MEDIPS.saturation}
\title{
Function calculates the saturation/reproducibility of the provided IP-Seq data.
}
\description{
The saturation analysis addresses the question, whether the number of short reads is sufficient to generate a saturated and reproducible coverage profile of the reference genome.
The main idea is that an insufficent number of short reads will not result in a saturated methylation profile. 
Only if there is a sufficient number of short reads, the resulting genome wide coverage profile will be reproducible by another independent set of a similar number of short reads.
}
\usage{
MEDIPS.saturation(file=NULL, BSgenome=NULL, nit=10, nrit=1, empty_bins=TRUE, rank=FALSE, extend=0, shift=0,  window_size=500, uniq=1e-3, chr.select=NULL, paired = F, isSecondaryAlignment = FALSE, simpleCigar=TRUE)
}
\arguments{
  \item{file}{
Path and file name of the IP data
}
  \item{BSgenome}{
The reference genome name as defined by BSgenome 
}  
  \item{nit}{
defines the number of subsets created from the full sets of available regions (default=10)
}
  \item{nrit}{
methods which randomly select data entries may be processed several times in order to obtain more stable results. 
By specifying the nrit parameter (default=1) it is possible to run the saturation analysis several times. 
The final results returned to the saturation results object are the averaged results of each random iteration step. 
}
  \item{empty_bins}{
can be either TRUE or FALSE (default TRUE). This parameter effects the way of calculating correlations between the resulting genome vectors. 
A genome vector consists of concatenated vectors for each included chromosome. The size of the vectors is defined by the bin_size parameter.
If there occur genomic bins which contain no overlapping regions, neither from the subsets of A nor from the subsets of B, 
these bins will be neglected when the paramter is set to FALSE.
}
  \item{rank}{
can be either TRUE or FALSE (default FALSE). This parameter also effects the way of calculating correlations between the resulting genome vectors.
If rank is set to TRUE, the correlation will be calculated for the ranks of the windows instead of considering the counts (Spearman correlation).
Setting this parameter to TRUE is a more robust approach that reduces the effect of possible occuring outliers (these are windows with a very high number of overlapping regions) to the correlation.
}
  \item{extend}{
defines the number of bases by which the region will be extended before the genome vector is calculated.
Regions will be extended along the plus or the minus strand as defined by their provided strand information.
Please note, the extend and shift parameter are mutual exclusive.
}
\item{shift}{
defines the number of bases by which the region will be shifted before the genome vector is calculated.
Regions will be shifted along the plus or the minus strand as defined by their provided strand information.
Please note, the extend and shift parameter are mutual exclusive.
}
  \item{window_size}{
defines the size of genome wide windows and therefore, the size of the genome vector. 
}
\item{uniq}{
The uniq parameter determines, if all reads mapping to exactly the same genomic position should be kept (uniq = 0), replaced by only one representative (uniq = 1), or if the number of stacked reads should be capped by a maximal number of stacked reads per genomic position determined by a poisson distribution of stacked reads genome wide and by a given p-value (1 > uniq > 0) (deafult: 1e-3). The smaller the p-value, the more reads at the same genomic position are potentially allowed.
}
\item{chr.select}{
specify a subset of chromosomes for which the saturation analysis is performed.
}
\item{paired}{
option for paired end reads
}
\item{isSecondaryAlignment}{
option to import only primary alignments.
}
\item{simpleCigar}{
option to import only alignments with simple Cigar string.
}
}
\value{
\item{distinctSets}{Contains the results of each iteration step (row-wise) of the saturation analysis.
The first column is the number of considered regions in each set, the second column is the resulting pearson correlation coefficient when comparing the two independent genome vectors.}
\item{estimation}{Contains the results of each iteration step (row-wise) of the estimated saturation analysis.
The first column is the number of considered regions in each set, the second column is the resulting pearson correlation coefficient when comparing the two independent genome vectors.}
\item{distinctSets}{the total number of available regions}
\item{maxEstCor}{contains the best pearson correlation (second column) obtained by considering the artifically doubled set of reads (first column)}
\item{distinctSets}{contains the best pearson correlation (second column) obtained by considering the total set of reads (first column)}
}
\author{
Lukas Chavez
}
\examples{

library(MEDIPSData)
library(BSgenome.Hsapiens.UCSC.hg19)
bam.file.hESCs.Rep1.MeDIP = system.file("extdata", "hESCs.MeDIP.Rep1.chr22.bam", package="MEDIPSData")

sr=MEDIPS.saturation(file=bam.file.hESCs.Rep1.MeDIP, BSgenome="BSgenome.Hsapiens.UCSC.hg19", uniq=1e-3, extend=250, shift=0, window_size=100, chr.select="chr22", nit=10, nrit=1, empty_bins=TRUE, rank=FALSE)

}
