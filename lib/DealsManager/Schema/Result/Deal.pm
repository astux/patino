package DealsManager::Schema::Result::Deal;

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

DealsManager::Schema::Result::Deal

=cut

__PACKAGE__->table("deals");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'deals_id_seq'

=head2 name

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 responsible_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 contact_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 status

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 price

  data_type: 'integer'
  is_nullable: 1

=head2 probability

  data_type: 'integer'
  is_nullable: 1

=head2 created

  data_type: 'timestamp with time zone'
  is_nullable: 1

=head2 updated

  data_type: 'timestamp with time zone'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "deals_id_seq",
  },
  "name",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "responsible_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "contact_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "status",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "price",
  { data_type => "integer", is_nullable => 1 },
  "probability",
  { data_type => "integer", is_nullable => 1 },
  "created",
  { data_type => "timestamp with time zone", is_nullable => 1 },
  "updated",
  { data_type => "timestamp with time zone", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 dashboards

Type: has_many

Related object: L<DealsManager::Schema::Result::Dashboard>

=cut

__PACKAGE__->has_many(
  "dashboards",
  "DealsManager::Schema::Result::Dashboard",
  { "foreign.deal_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 responsible

Type: belongs_to

Related object: L<DealsManager::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "responsible",
  "DealsManager::Schema::Result::User",
  { id => "responsible_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 contact

Type: belongs_to

Related object: L<DealsManager::Schema::Result::Contact>

=cut

__PACKAGE__->belongs_to(
  "contact",
  "DealsManager::Schema::Result::Contact",
  { id => "contact_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 notes

Type: has_many

Related object: L<DealsManager::Schema::Result::Note>

=cut

__PACKAGE__->has_many(
  "notes",
  "DealsManager::Schema::Result::Note",
  { "foreign.deal_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2012-07-16 19:29:22
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:s+rSd2i0W6ol4rLqf6hn5A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
