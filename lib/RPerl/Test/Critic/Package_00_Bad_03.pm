# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPARP00' >>>
# <<< COMPILE_ERROR: 'Unexpected token:  our' >>>

# [[[ HEADER ]]]
package RPerl::Test::Critic::Package_00_Bad_03;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { return 2; };

1;                  # end of package
