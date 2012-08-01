package DealsManager::Controller::Deals::TODOs;
use Moose;
use namespace::autoclean;
use Data::Dumper;
BEGIN { extends 'Catalyst::Controller::HTML::FormFu'; }

sub base :Chained('/deals/object') PathPart('todos') CaptureArgs(0) {
    my ( $self, $c ) = @_;

    $c->stash->{deal} = $c->stash->{deals_rs}->first;

    $c->stash->{todos_rs} = $c->model('DB::Todo');
}

sub object :Chained('base') PathPart('') CaptureArgs(1) {
    my ( $self, $c, $todo_id ) = @_;

    $c->stash->{todos_rs} = $c->stash->{todos_rs}->search_rs({ id => $todo_id,
                                                               deal_id => $c->stash->{deal}->id });
}

sub index :Chained('base') PathPart('') Args(0) {
    my ( $self, $c ) = @_;

    $c->stash->{todos} = [ $c->stash->{todos_rs}->search_rs({ deal_id => $c->stash->{deal}->id })->all ];
}

sub create :Chained('base') PathPart('create') Args(0) FormConfig('deals/todos/form.yml') {
    my ( $self, $c ) = @_;

    my $form = $c->stash->{form};

    if ($form->submitted_and_valid) {
        $self->_save( $c, $form );
    }
}

sub edit :Chained('object') PathPart('edit') Args(0) FormConfig('deals/todos/form.yml') {
    my ( $self, $c ) = @_;

    my $form = $c->stash->{form};
    $form->model->default_values( $c->stash->{todos_rs}->first );

    if ($form->submitted_and_valid) {
        $self->_save( $c, $form, $c->stash->{todos_rs}->first );
    }
}

sub _save :Private {
    my ( $self, $c, $form, $todo ) = @_;

    if ($todo) {              # edit
        $form->model->update( $todo );

        $c->flash->{success} = 'TODO <b>' . $todo->title . '</b> edited.';
    }
    else {                    # create
        my $new_todo = $c->stash->{todos_rs}->new_result({ deal_id => $c->stash->{deal}->id });
        $form->model->update( $new_todo );

        $c->flash->{success} = 'TODO <b>' . $new_todo->title . '</b> created.';
    }
    $c->res->redirect( $c->uri_for('/deals', $c->stash->{deal}->id, 'todos') );
}

sub show :Chained('object') PathPart('') Args(0) FormConfig('deals/todos/comments/form.yml') {
    my ( $self, $c ) = @_;

    $c->stash->{todo} = $c->stash->{todos_rs}->first;
    $c->stash->{form}->action("/deals/" . $c->stash->{deal}->id . "/todos/" .
                              $c->stash->{todo}->id . "/comments/create");
    $c->stash->{form}->default_values({ deal_id => $c->stash->{deal}->id,
                                        todo_id => $c->stash->{todo}->id });
}

sub delete :Chained('object') PathPart('delete') Args(0) {
    my ( $self, $c ) = @_;

    my $todo = $c->stash->{todos_rs}->first;
    $c->flash->{success} = 'TODO <b>' . $todo->title . '</b> deleted.';
    $todo->delete;

    $c->res->redirect( $c->uri_for('/deals', $c->stash->{deal}->id, 'todos') );
}

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
