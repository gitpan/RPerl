#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< RUN_ERROR: 'ERROR EPVHVRV03, TYPE-CHECKING MISMATCH' >>>
# <<< RUN_ERROR: "string__hash_ref element value expected but non-string value found at key 'd'" >>>
# <<< RUN_ERROR: 'in variable $input_1 from subroutine check__string__hash_ref()' >>>

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
check__string__hash_ref( { a => 'hello', b => 'howdy', c => 'ahoy', d => -999_999.123_456 } );
