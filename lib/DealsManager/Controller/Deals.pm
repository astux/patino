package DealsManager::Controller::Deals;
use Moose;
use namespace::autoclean;
use Data::Dumper;

BEGIN { extends 'Catalyst::Controller::HTML::FormFu'; }

sub base :Chained('/') PathPart('deals') CaptureArgs(0) {
    my ( $self, $c ) = @_;

    $c->stash->{resulset} = $c->model('DB::Deal');
}

sub object :Chained('base') PathPart('') CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;

    $c->stash->{object} =
      $c->stash->{resulset}->search_rs({ 'me.id' => $id });
}

sub index :Chained('base') PathPart('') Args(0) {
    my ( $self, $c ) = @_;

    my $deals_rs = $c->stash->{resulset}
      ->search(
               undef,
               {
                prefetch => ['responsible', 'contact'],
                order_by => { -asc => 'me.id' }
               }
              );

    $c->stash->{deals} = [ $deals_rs->all ];
}

sub show :Chained('object') PathPart('') Args(0) FormConfig('deals/notes/form.yml') {
    my ( $self, $c ) = @_;

    my $deal = $c->stash->{object}
      ->search_rs(undef,
                  { prefetch => [ 'responsible', 'contact', {'notes' => 'user' } ],
                    order_by => { -desc => 'notes.id' } } )
        ->first;

    $c->stash->{form}->action("/deals/" . $deal->id . "/notes/create");
    $c->stash->{form}->default_values({ deal_id => $deal->id, user_id => $c->user->id });

    $c->stash->{object} = $deal;
    use DateTime::Duration::Fuzzy qw/time_ago/;
    $c->stash->{time_ago} = sub { time_ago($_[0]); };
}

sub create :Chained('base') PathPart('create') Args(0) FormConfig('deals/form.yml') {
    my ( $self, $c ) = @_;

    my $form = $c->stash->{form};

    if ( $form->submitted_and_valid ) {
        use DateTime;
        my $datetime_now = DateTime->now;
        my $new_deal = $c->stash->{resulset}->new_result({
                                                          created => $datetime_now,
                                                          updated => $datetime_now
                                                         });
        $form->model->update( $new_deal );

        my $dashboard_item = { content => 'Deal created',
                               type => 'deal_created',
                               created => $datetime_now,
                               user_id => $c->user->id,
                               deal_id => $new_deal->id };

        my $dashboard_rs = $c->model('DB::Dashboard')->create( $dashboard_item );

        $c->flash->{success} = 'Deal <b>' . $new_deal->name  . '</b> created';
        $c->res->redirect('/deals');
    }
}

sub edit :Chained('object') PathPart('edit') Args(0) FormConfig('deals/form.yml') {
    my ( $self, $c ) = @_;

    my $form = $c->stash->{form};

    if ( $form->submitted_and_valid ) {
        use DateTime;
        my $deal = $c->stash->{object}->first;
        my $datetime_now = DateTime->now;
        $deal->updated( $datetime_now );
        $form->model->update( $deal );

       my $dashboard_item = { content => 'Deal updated',
                               type => 'deal_updated',
                               created => $datetime_now,
                               user_id => $c->user->id,
                               deal_id => $deal->id };

        my $dashboard_rs = $c->model('DB::Dashboard')->create( $dashboard_item );

        $c->flash->{success} = 'Deal <b>' . $deal->name . '</b> edited';
        $c->res->redirect('/deals');
    }
    else {
        $form->model->default_values( $c->stash->{object}->first );
    }
}

sub delete :Chained('object') PathPart('delete') Args(0) {
    my ( $self, $c ) = @_;

    my $deal = $c->stash->{object}->first;
    $c->flash->{error} = 'Deal <b>' . $deal->name . '</b> deleted';
    $deal->delete;

    $c->res->redirect('/deals');
}

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
