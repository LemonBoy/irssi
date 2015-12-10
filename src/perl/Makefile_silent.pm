push @ExtUtils::MakeMaker::Overridable, qw(pm_to_blib);
package MY {
    sub _center {
	my $z = shift;
	length $z == 2 ? "  $z   " : length $z == 4 ? " $z  " : " $z "
    }
    sub _silent {
	my $z = shift;
	$z =~ s{\t(?:- ?)?\K(?=\$\((?|(CC)CMD|(XS)UBPPRUN|(LD)|(CHMOD)|(RM)_R?F|(CP)_NONEMPTY|FULL_(AR)\)))}{q{$(NOECHO)echo "}._center($1).q{" $@;}}ge;
	$z
    }
    sub c_o { _silent(shift->SUPER::c_o(@_)) }
    sub xs_c { _silent(shift->SUPER::xs_c(@_)) }
    sub xs_o { _silent(shift->SUPER::xs_o(@_)) }
    sub dynamic_lib { _silent(shift->SUPER::dynamic_lib(@_)) }
    sub static_lib { _silent(shift->SUPER::static_lib(@_)) }
    sub dynamic_bs {
	my $ret = shift->SUPER::dynamic_bs(@_);
	$ret =~ s{Running Mkbootstrap for}{_center('BS')}ge;
	_silent($ret)
    }
    sub pm_to_blib {
	my $ret = shift->SUPER::pm_to_blib(@_);
	$ret =~ s{^(\t(?:- ?)?)(?:\$\(NOECHO\) ?)?(.*-e ['"]pm_to_blib(.*\\\n)*.*)$}{$1.q{$(NOECHO)echo "}._center('BLIB').q{" $@;}.$2.q{ >/dev/null}}mge;
	$ret
    }
};
1;
