use strict;
use warnings;
use Test::More;


use Catalyst::Test 'DealsManager';
use DealsManager::Controller::Deals::Notes;

ok( request('/deals/notes')->is_success, 'Request should succeed' );
done_testing();
