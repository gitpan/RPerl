#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< RUN_ERROR: 'ERROR ENVAVRV03, TYPE-CHECKING MISMATCH' >>>
# <<< RUN_ERROR: 'number__array_ref element value expected but non-number value found at index 3' >>>
# <<< RUN_ERROR: 'in variable $input_1 from subroutine check__number__array_ref()' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_001;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use RPerl::Test::TypeCheckingTrace::AllTypes;

# [[[ OPERATIONS ]]]
check__number__array_ref( [ -999_999, 3, 4, 'howdy' ] );
