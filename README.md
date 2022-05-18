# Count_total_SNP_per_population
Want to count how much single nucleotide polymorphism (SNP) each of your population have. You are in the right place. This Shiny app helps you to count SNP that are present in subset of a vcf file. Within the subset, if a site is not all reference allele, or all same-alternative allele then it is counted as a SNP. Please mind that if there is unknown genotype (. in the vcf) then it is counted as a SNP


## Input data
You need a vcf.gz
## Requirements 

You need to have bcftools installed on your computer. It has been tested on linux ubuntu 20.04 with bcftools Version: 1.10.2 (using htslib 1.10.2-3)

---

## How to run the shiny app
To run the shiny, you can install the **shiny** package in R, and
use the function `runGitHub()`. For example:

```R
if (!require('shiny')) install.packages("shiny")
shiny::runGitHub("Count_total_SNP_per_population", "BastienBennetot",ref="main")
```

Or you can clone or download this repository, and use `runApp()` function.

## How to ?
Using this shiny app you can choose a subset of individuals to count how much snp there is in this subset. You can count SNP by counting line without header of a vcf too but if you are subsetting some individuals you may have some SNP that won't be SNP anymore. For bigger populations you may want to use a file containing name of samples to use for the count. You can use bcftools to do that following the command located on this repository at "Fast_bash_command_to_count_SNP_for_one_population"
