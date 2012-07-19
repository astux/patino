package DealsManager::Controller::Deals::Notes;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller::HTML::FormFu'; }

sub base :Chained('/deals/object') :PathPart('notes') :CaptureArgs(0) {
    my ( $self, $c ) = @_;

    $c->stash->{object_note} = $c->model('DB::Note');
}

sub object :Chained('/deals/object') :PathPart('notes') :CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;

    $c->stash->{object_note} = $c->model('DB::Note')->search_rs({ 'me.id' => $id });
}

sub index :Chained('base') :PathPart('') :Args(0) {
    my ( $self, $c ) = @_;

    $c->stash->{notes} = [$c->stash->{object}->first->notes];
}

sub create :Chained('base') :PathPart('create') :Args(0) :FormConfig('deals/notes/form.yml') {
    my ( $self, $c ) = @_;

    my $form = $c->stash->{form};

    use DateTime;

    my $datetime_now = DateTime->now;
    my $new_note = $c->stash->{object_note}->new_result({
                                                         created => $datetime_now
                                                        });

    $form->model->update( $new_note );

    my $dashboard_item = { content => $new_note->note,
                           type => 'note_created',
                           created => $datetime_now,
                           user_id => $c->user->id,
                           deal_id => $new_note->deal->id };

    my $dashboard_rs = $c->model('DB::Dashboard')->create( $dashboard_item );

    $c->res->redirect( $c->uri_for('/deals', $c->stash->{object}->first->id) );
}

sub delete :Chained('object') PathPart('delete') Args(0) {
    my ( $self, $c ) = @_;

    $c->stash->{object_note}->delete;
    $c->res->redirect( $c->uri_for('/deals', $c->stash->{object}->first->id) );
}

__PACKAGE__->meta->make_immutable;

1;
