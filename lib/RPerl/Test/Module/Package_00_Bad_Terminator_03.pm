# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPAPC02' >>>
# <<< COMPILE_ERROR: 'Perl::Critic::Policy::Modules::RequireEndWithOne' >>>

# [[[ HEADER ]]]
package RPerl::Test::Module::Package_00_Bad_Terminator_03;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { return 2; };

1                  # end of package
