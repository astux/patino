package DealsManager::Controller::Contacts;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller::HTML::FormFu'; }

sub base :Chained('/') PathPart('contacts') CaptureArgs(0) {
    my ( $self, $c ) = @_;

    $c->stash->{resulset} = $c->model('DB::Contact');
}

sub object :Chained('base') PathPart('') CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;

    $c->stash->{object} =
      $c->stash->{resulset}->search_rs({ 'me.id' => $id });
}

sub index :Chained('base') PathPart('') Args(0) {
    my ( $self, $c ) = @_;

    my $rs = $c->stash->{resulset};

    $c->stash->{contacts} = [ $rs->all ];
}

sub show :Chained('object') PathPart('') Args(0) {
    my ( $self, $c ) = @_;

    my $contact = $c->stash->{object}->first;

    $c->stash->{object} = $c->stash->{object}
      ->search_rs(undef,
                  { prefetch => [ 'deals' ] } )
        ->first;
}

sub create :Chained('base') PathPart('create') Args(0) FormConfig('contacts/form.yml') {
    my ( $self, $c ) = @_;

    my $form = $c->stash->{form};

    if ( $form->submitted_and_valid ) {
        my $new_contact = $c->stash->{resulset}->new_result({});
        $form->model->update( $new_contact );
        $c->res->redirect('/contacts');
    }
}

sub edit :Chained('object') PathPart('edit') Args(0) FormConfig('contacts/form.yml') {
    my ( $self, $c ) = @_;

    my $form = $c->stash->{form};

    if ( $form->submitted_and_valid ) {
        $form->model->update( $c->stash->{object}->first );
        $c->res->redirect('/contacts');
    }
    else {
        $form->model->default_values( $c->stash->{object}->first );
    }
}

sub delete :Chained('object') PathPart('delete') Args(0) {
    my ( $self, $c ) = @_;

    $c->stash->{object}->first->delete;
    $c->res->redirect('/contacts');
}

=head1 AUTHOR

sgrs,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
