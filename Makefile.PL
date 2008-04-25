use strict;
use inc::Module::Install;

name('Data-ResourceSet');
all_from('lib/Data/ResourceSet.pm');

requires 'Class::Accessor::Fast';
requires 'Class::Data::ConfigHash';
requires 'Class::Inspector';
requires 'UNIVERSAL::require';

build_requires 'Test::More';

auto_include;
WriteAll;