unit module FASTA:ver<0.1.0>:auth<github:QhpAptyj9hj0RQwMOw3ujuO3GDP3kYzkmXSh4gk>;

sub codons-to-amino-acids($codon) is export {
    given $codon {
    	  when 'ATT' { return 'isoleucine'	}
	  when 'ATC' { return 'isoleucine' 	}
	  when 'ATA' { return 'isoleucine' 	}
	  when 'CTT' { return 'leucine'	   	}
	  when 'CTC' { return 'leucine'		}
	  when 'CTA' { return 'leucine'	   	}
	  when 'CTG' { return 'leucine'	   	}
	  when 'TTA' { return 'leucine'	   	}
	  when 'TTG' { return 'leucine'		}
	  when 'GTT' { return 'valine'	   	}
	  when 'GTC' { return 'valine'	   	}
	  when 'GTA' { return 'valine'		}
	  when 'GTG' { return 'valine'	   	}
	  when 'TTT' { return 'phenylalanine' 	}
	  when 'TTC' { return 'phenylalanine'	}
	  when 'ATG' { return 'methionine'	}
	  when 'TGT' { return 'cysteine'	}
	  when 'TGC' { return 'cysteine'	}
	  when 'GCT' { return 'alanine'		}
	  when 'GCC' { return 'alanine'		}
	  when 'GCA' { return 'alanine'		}
	  when 'GCG' { return 'alanine'		}
	  when 'GGT' { return 'glycine'		}
	  when 'GGC' { return 'glycine'		}
	  when 'GGA' { return 'glycine'		}
	  when 'GGG' { return 'glycine'		}
	  when 'CCT' { return 'proline'		}
	  when 'CCC' { return 'proline'		}
	  when 'CCA' { return 'proline'		}
	  when 'CCG' { return 'proline'		}
	  when 'ACT' { return 'threonine'	}
	  when 'ACC' { return 'threonine'	}
	  when 'ACA' { return 'threonine'	}
	  when 'ACG' { return 'threonine'	}
	  when 'TCT' { return 'serine'		}
	  when 'TCC' { return 'serine'		}
	  when 'TCA' { return 'serine'		}
	  when 'TCG' { return 'serine'		}
	  when 'AGT' { return 'serine'		}
	  when 'AGC' { return 'serine'		}
	  when 'TAT' { return 'tyrosine'	}
	  when 'TAC' { return 'tyrosine'	}
	  when 'TGG' { return 'tryptophan'	}
	  when 'CAA' { return 'glutamine'	}
	  when 'CAG' { return 'glutamine'	}
	  when 'AAT' { return 'asparagine'	}
	  when 'AAC' { return 'asparagine'	}
	  when 'CAT' { return 'histidine'	}
	  when 'CAC' { return 'histidine'	}
	  when 'GAA' { return 'glutamic-acid'	}
	  when 'GAG' { return 'glutamic-acid'	}
	  when 'GAT' { return 'aspartic-acid'	}
	  when 'GAC' { return 'aspartic-acid'	}
	  when 'AAA' { return 'lysine'		}
	  when 'AAG' { return 'lysine'		}
	  when 'CGT' { return 'arginine'	}
	  when 'CGC' { return 'arginine'	}
	  when 'CGA' { return 'arginine'	}
	  when 'CGG' { return 'arginine'	}
	  when 'AGA' { return 'arginine'	}
	  when 'AGG' { return 'arginine'	}
	  when 'TAA' { return 'stop'		}
	  when 'TAG' { return 'stop'		}
	  when 'TGA' { return 'stop'		}
	  
    	  default { return "Error! Invalid codon." }
    }
}

sub read-fasta-by-codon($file) is export {

    my $overflow = '';
    my @codons;
    my $codon-regex = /<[ATGC]> ** 3/;
    
    for $file.IO.lines -> $line {

    	my $processed-line;
	next if $line.contains('>'); # change this from contains to starts-with

	# remove any white-space
	$processed-line = $line.subst(/\s+/, "", :g);

	# add any left-over characters from previous line to current line.
	$processed-line = $overflow ~ $processed-line if $overflow.chars > 0;
	$overflow = '';

	while $processed-line.chars > 3 {
	      my $codon = $processed-line.subst-mutate($codon-regex, "");
	      @codons.push($codon);
	      }

	      $overflow = $processed-line if $processed-line.chars < 3;
	}

    return @codons;
}

sub count-amino-acids(@codons) is export {

    my %amino-acids = 'isoleucine' => 0, 'leucine' => 0, 'valine' => 0, 'phenylalanine' => 0, 'methionine' => 0, 'cysteine' => 0, 'alanine' => 0, 'glycine' => 0, 'proline' => 0, 'threonine' => 0, 'serine' => 0, 'tyrosine' => 0, 'tryptophan' => 0, 'glutamine' => 0, 'asparagine' => 0, 'histidine' => 0, 'glutamic-acid' => 0, 'aspartic-acid' => 0, 'lysine' => 0, 'arginine' => 0, 'stop' => 0;

    for @codons -> $codon {

    	# It's cool to see the codon-amino acid pairs, rather than just a terminal. Consider changing below line to be opt-outable (i.e. non-verbose) in the future.
	my $amino-acid = codons-to-amino-acids($codon);
    	say $codon ~ ' ' ~ $amino-acid;
    	%amino-acids{$amino-acid} += 1;
    
    }
    return %amino-acids;
}

