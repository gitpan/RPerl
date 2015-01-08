#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< RUN_ERROR: 'ERROR EAVRV10, BOUND-CHECKING MISMATCH: Argument $input_vector_1 is not of magnitude 4' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_020;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use RPerl::Algorithm::Math::GeometricAlgebra;

# [[[ OPERATIONS ]]]
my number__array_ref $input_vector_1 = [ -999_999, 3.0, 4.0 ];
my number__array_ref $input_vector_2 = [ -999_999, 3.0, 4.0, -12.0 ];
my number $retval_number
    = inner_product__vector_vector_euclidean( $input_vector_1,
    $input_vector_2 );
print $retval_number . "\n";
