# [[[ HEADER ]]]
package RPerl::Test::LiteralString::Package_SingleQ_07_Good;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { return q{@ $}; };

1;                  # end of package
