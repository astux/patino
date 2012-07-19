use strict;
use warnings;
use Test::More;


use Catalyst::Test 'DealsManager';
use DealsManager::Controller::Notes;

ok( request('/notes')->is_success, 'Request should succeed' );
done_testing();
