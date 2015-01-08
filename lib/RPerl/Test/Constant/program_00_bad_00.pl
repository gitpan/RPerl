#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPAPL03' >>>
# <<< COMPILE_ERROR: 'Useless use of a constant' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CONSTANTS ]]]
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 4: allow constants
 PI  => my number $TYPED_PI  = 3.141_59;
use constant PIE => my string $TYPED_PIE = 'pecan';

# [[[ OPERATIONS ]]]
my integer $i = 2 + 2;