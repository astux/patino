use strict;
use warnings;
use Test::More;


use Catalyst::Test 'DealsManager';
use DealsManager::Controller::Contacts;

ok( request('/contacts')->is_success, 'Request should succeed' );
done_testing();
