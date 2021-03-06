package DealsManager::Schema::Result::Todo;

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

DealsManager::Schema::Result::Todo

=cut

__PACKAGE__->table("todos");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'todos_id_seq'

=head2 deal_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 assignee_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 body

  data_type: 'text'
  is_nullable: 1

=head2 scheduled

  data_type: 'timestamp with time zone'
  is_nullable: 1

=head2 status

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 title

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

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
    sequence          => "todos_id_seq",
  },
  "deal_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "assignee_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "body",
  { data_type => "text", is_nullable => 1 },
  "scheduled",
  { data_type => "timestamp with time zone", is_nullable => 1 },
  "status",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "title",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "created",
  { data_type => "timestamp with time zone", is_nullable => 1 },
  "updated",
  { data_type => "timestamp with time zone", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 assignee

Type: belongs_to

Related object: L<DealsManager::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "assignee",
  "DealsManager::Schema::Result::User",
  { id => "assignee_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

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


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2012-07-31 21:26:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:zBJWn3wYFCnJ9KU54dsPEw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
