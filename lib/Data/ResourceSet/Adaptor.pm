# $Id: /mirror/coderepos/lang/perl/Data-ResourceSet/trunk/lib/Data/ResourceSet/Adaptor.pm 52164 2008-04-25T22:52:09.612590Z daisuke  $

package Data::ResourceSet::Adaptor;
use strict;
use warnings;
use base qw(Class::Accessor::Fast);
__PACKAGE__->mk_accessors($_) for qw(constructor class args);

sub ACCEPT_CONTEXT
{
    my $self = shift;
    return $self->_create_instance(@_);
}

sub _create_instance {
    my ($self, $c, @args) = @_;

    my $constructor = $self->constructor || 'new';
    my $args = $self->prepare_arguments($c, @args);
    my $adapted_class = $self->class;
    if (! Class::Inspector->loaded($adapted_class)) {
        $adapted_class->require or die;
    }

    return $adapted_class->$constructor($self->mangle_arguments($args));
}

sub prepare_arguments {
    my ($self, $app) = @_;
    return $self->args;
}

sub mangle_arguments {
    my ($self, $args) = @_;
    return $args;
}

1;

__END__

=head1 NAME

Data::ResourceSet::Adaptor - Adaptor Interface for ResourceSet

=head1 SYNOPSIS

  Data::ResourceSet::Adaptor->new(
    constructor => 'new', # optional. default "new"
    class => 'NameOfAdaptedClass',
    args  => \%arguments
  );

=head1 DESCRIPTION

This is a rip-off of Catalyst::Model::Adaptor

=head1 METHODS

=head2 ACCEPT_CONTEXT

=head2 prepare_arguments

=head2 mangle_arguments

=cut