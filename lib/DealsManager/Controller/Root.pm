package DealsManager::Controller::Root;
use Moose;
use namespace::autoclean;
use Data::Dumper;

BEGIN { extends 'Catalyst::Controller' }

__PACKAGE__->config(namespace => '');

sub auto :Private {
    my ( $self, $c ) = @_;

    if ($c->controller eq $c->controller('Auth')) {
        return 1;
    }

    unless ($c->user_exists) {
        $c->res->redirect('/auth/login');
        return 0;
    }

    return 1;
}

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->stash->{dashboard_items} =
      [
       $c->model('DB::Dashboard')
       ->search_rs( undef, { order_by => { -desc => 'me.id' } } )
       ->all
      ];

    use DateTime::Duration::Fuzzy qw/time_ago/;
    $c->stash->{time_ago} = sub { time_ago($_[0]); };

    use Number::Format qw/format_number/;
    $c->stash->{format_number} = sub { format_number($_[0]); };
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
