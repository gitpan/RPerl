# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPAPL03' >>>
# <<< COMPILE_ERROR: 'Misplaced _ in number' >>>

# [[[ HEADER ]]]
package RPerl::Test::LiteralNumber::Package_48_Bad_01;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

our void $empty_sub = sub { return 23_456._2; };

1;                  # end of package
