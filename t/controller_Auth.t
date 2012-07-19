use strict;
use warnings;
use Test::More;


use Catalyst::Test 'DealsManager';
use DealsManager::Controller::Auth;

ok( request('/auth')->is_success, 'Request should succeed' );
done_testing();
