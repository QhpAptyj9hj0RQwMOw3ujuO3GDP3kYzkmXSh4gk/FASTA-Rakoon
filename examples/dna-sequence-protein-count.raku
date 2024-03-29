# This imports the module, reads the example .fna file by codon, and then counts the amino acids in the .fna file.

use FASTA;

my @codons = read-fasta-by-codon('home/user/fasta-parser/ncbi-test-data/Fmr1_datasets/Fmr1_datasets/ncbi_dataset/data/gene.fna');
say @codons;
say count-amino-acids(@codons);

