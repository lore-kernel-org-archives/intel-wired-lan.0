From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 11 May 2016 21:17:27 +0000
Subject: [Intel-wired-lan] [PATCH v1] checkpatch.pl: seed camelcase from
 the	provided kernel tree root
In-Reply-To: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D608D@ORSMSX104.amr.corp.intel.com>
References: <20160505231108.1934-1-jacob.e.keller@intel.com>
 <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D608D@ORSMSX104.amr.corp.intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81EFC15B@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Yup, I see it too.  I had not traced it down to the set of unique patches, but I'm seeing that when I throw a whole bunch (1000) patches into checkpatch starting from the top (via a relatively dumb check patches script.) 

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bowers, AndrewX
> Sent: Wednesday, May 11, 2016 8:08 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: Re: [Intel-wired-lan] [PATCH v1] checkpatch.pl: seed camelcase from
> the provided kernel tree root
> 
> I think I found an issue, if I run the checkpatch against bb152c3 (Refactor
> ethtool get settings)  it
> gives me an "unknown option: -C" error and then a bunch of Avoid
> CamelCase checks (See attachment)
> 
> > -----Original Message-----
> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> > Behalf Of Jacob Keller
> > Sent: Thursday, May 05, 2016 4:11 PM
> > To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> > Subject: [Intel-wired-lan] [PATCH v1] checkpatch.pl: seed camelcase from
> > the provided kernel tree root
> >
> > When checkpatch.pl is run without a git tree, it seeds the camelcase
> includes
> > from the $root parameter. However, it does not use the $root directory
> > when seeding for a git tree. Fix this by using "-C $root" so that a user may
> run
> > checkpatch with the --root parameter pointing to a valid kernel source tree.
> > In addition, when generating the list of files to check, we must also prefix
> > each file with the $root parameter, in order to properly locate the file when
> > searching.
> >
> > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > ---
> >  scripts/checkpatch.pl | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl index
> > d574d13ba963..8ec10e8cff73 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -665,8 +665,8 @@ sub seed_camelcase_includes {
> >
> >  	$camelcase_seeded = 1;
> >
> > -	if (-e ".git") {
> > -		my $git_last_include_commit = `git log --no-merges --
> > pretty=format:"%h%n" -1 -- include`;
> > +	if (-e "$root/.git") {
> > +		my $git_last_include_commit = `git -C $root log --no-merges
> > +--pretty=format:"%h%n" -1 -- include`;
> >  		chomp $git_last_include_commit;
> >  		$camelcase_cache = ".checkpatch-
> > camelcase.git.$git_last_include_commit";
> >  	} else {
> > @@ -693,9 +693,10 @@ sub seed_camelcase_includes {
> >  		return;
> >  	}
> >
> > -	if (-e ".git") {
> > -		$files = `git ls-files "include/*.h"`;
> > +	if (-e "$root/.git") {
> > +		$files = `git -C $root ls-files "include/*.h"`;
> >  		@include_files = split('\n', $files);
> > +		@include_files = map("$root/$_", @include_files);
> >  	}
> >
> >  	foreach my $file (@include_files) {
> > --
> > 2.8.1.493.g7b22612
> >
> > _______________________________________________
> > Intel-wired-lan mailing list
> > Intel-wired-lan at lists.osuosl.org
> > http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
