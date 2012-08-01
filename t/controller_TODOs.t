use strict;
use warnings;
use Test::More;


use Catalyst::Test 'DealsManager';
use DealsManager::Controller::TODOs;

ok( request('/todos')->is_success, 'Request should succeed' );
done_testing();
