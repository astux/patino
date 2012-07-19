use strict;
use warnings;
use Test::More;


use Catalyst::Test 'DealsManager';
use DealsManager::Controller::Deals;

ok( request('/deals')->is_success, 'Request should succeed' );
done_testing();
