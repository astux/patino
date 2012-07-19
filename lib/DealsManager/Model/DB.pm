package DealsManager::Model::DB;
use strict;
use base 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->config(
                    schema_class => 'DealsManager::Schema',

                    connect_info => {
                                     dsn => 'dbi:Pg:dbname=deals_manager',
                                     user => 'postgres',
                                     password => 'postgres',
                                     quote_char => '"',
                                     name_sep => '.'
                                    }
);

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
