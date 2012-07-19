use strict;
use warnings;

use DealsManager;

my $app = DealsManager->apply_default_middlewares(DealsManager->psgi_app);
$app;

