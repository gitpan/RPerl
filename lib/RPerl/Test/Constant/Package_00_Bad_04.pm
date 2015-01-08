# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPARP00' >>>
# <<< COMPILE_ERROR: 'Unexpected token:  use constant' >>>

# [[[ HEADER ]]]
package RPerl::Test::Constant::Package_00_Bad_04;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CONSTANTS ]]]
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 4: allow constants
use constant PI  => my number $TYPED_PI  = 3.141_59;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { return 2; };

use constant PIE => my string $TYPED_PIE = 'pecan';

1;                  # end of package
