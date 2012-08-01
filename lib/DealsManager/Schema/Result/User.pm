package DealsManager::Schema::Result::User;

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

DealsManager::Schema::Result::User

=cut

__PACKAGE__->table("users");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'users_id_seq'

=head2 username

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 password

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 name

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 email

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "users_id_seq",
  },
  "username",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "password",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "name",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "email",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
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
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 deals

Type: has_many

Related object: L<DealsManager::Schema::Result::Deal>

=cut

__PACKAGE__->has_many(
  "deals",
  "DealsManager::Schema::Result::Deal",
  { "foreign.responsible_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 notes

Type: has_many

Related object: L<DealsManager::Schema::Result::Note>

=cut

__PACKAGE__->has_many(
  "notes",
  "DealsManager::Schema::Result::Note",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 todos

Type: has_many

Related object: L<DealsManager::Schema::Result::Todo>

=cut

__PACKAGE__->has_many(
  "todos",
  "DealsManager::Schema::Result::Todo",
  { "foreign.assignee_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 users_roles

Type: has_many

Related object: L<DealsManager::Schema::Result::UsersRole>

=cut

__PACKAGE__->has_many(
  "users_roles",
  "DealsManager::Schema::Result::UsersRole",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2012-07-31 17:42:01
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:dHzU77IWNc/39beC69lXRQ

__PACKAGE__->many_to_many('roles', 'users_roles', 'role');

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
