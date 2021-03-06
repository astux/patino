package DealsManager::Schema::Result::Dashboard;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

DealsManager::Schema::Result::Dashboard

=cut

__PACKAGE__->table("dashboard");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'dashboard_id_seq'

=head2 content

  data_type: 'text'
  is_nullable: 1

=head2 created

  data_type: 'timestamp with time zone'
  is_nullable: 1

=head2 type

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 deal_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "dashboard_id_seq",
  },
  "content",
  { data_type => "text", is_nullable => 1 },
  "created",
  { data_type => "timestamp with time zone", is_nullable => 1 },
  "type",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "deal_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 deal

Type: belongs_to

Related object: L<DealsManager::Schema::Result::Deal>

=cut

__PACKAGE__->belongs_to(
  "deal",
  "DealsManager::Schema::Result::Deal",
  { id => "deal_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 user

Type: belongs_to

Related object: L<DealsManager::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "DealsManager::Schema::Result::User",
  { id => "user_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2012-07-16 19:29:22
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:3UXmN4oJrtiAYL44H/CaeQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
