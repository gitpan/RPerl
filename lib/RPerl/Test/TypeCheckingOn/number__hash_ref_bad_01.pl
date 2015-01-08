#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< RUN_ERROR: 'ERROR ENVHVRV03, TYPE-CHECKING MISMATCH' >>>
# <<< RUN_ERROR: "number__hash_ref element value expected but non-number value found at key 'd'" >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_001;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use RPerl::Test::TypeCheckingOn::AllTypes;

# [[[ OPERATIONS ]]]
check__number__hash_ref( { a => -999_999, b => 3, c => 4, d => q{howdy} } );
