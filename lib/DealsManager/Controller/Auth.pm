package DealsManager::Controller::Auth;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

sub login :Local {
    my ($self, $c) = @_;
}

sub login_do :Local {
    my ($self, $c) = @_;

    my $authentication_response =
      $c->authenticate({ username => $c->req->params->{username},
                         password => $c->req->params->{password} });

    if ( $authentication_response ) {
        $c->res->redirect('/deals');
    }
    else {
        $c->res->redirect('/auth/login');
    }
}

sub logout :Local {
    my ($self, $c) = @_;

    $c->logout;
    $c->res->redirect('/deals');
}

__PACKAGE__->meta->make_immutable;

1;
