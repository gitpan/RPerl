# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPAPC02' >>>
# <<< COMPILE_ERROR: 'Perl::Critic::Policy::Modules::RequireExplicitPackage' >>>

# [[[ HEADER ]]]
use RPerl::Test::Foo;
package RPerl::Test::Include::Package_00_Bad_07;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ INCLUDES ]]]
use RPerl::Test::Bar;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { return 2; };

1;                  # end of package
