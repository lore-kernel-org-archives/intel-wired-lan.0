From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 20 Mar 2019 20:09:17 +0000
Subject: [Intel-wired-lan] [PATCH] checkpatch: fix camel case seeding
 when run with --root
In-Reply-To: <20190315010334.5707-1-jacob.e.keller@intel.com>
References: <20190315010334.5707-1-jacob.e.keller@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB589232E64D@ORSMSX121.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Keller, Jacob E
> Sent: Thursday, March 14, 2019 6:04 PM
> To: linux-kernel at vger.kernel.org
> Cc: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>; netdev at vger.kernel.org;
> Keller, Jacob E <jacob.e.keller@intel.com>; joe at perches.com
> Subject: [PATCH] checkpatch: fix camel case seeding when run with --root
> 
> checkpatch.pl avoids warning about camel case of some definitions by
> seeding a file that tracks all of the currently committed camel case
> definitions.
> 
> To build this seed file, checkpatch.pl decides between using git or the
> --root parameter.
> 
> This works as long as you don't run checkpatch.pl from within
> a different git tree that is not the Linux kernel.
> 
> In this case, the check for ".git" will return true, and checkpatch will
> attempt to seed a camel case file using the current directory. This
> works fine if --root is not provided, but can result in an incorrect
> camel case seed file resulting in false positive warnings.
> 
> Fix this by checking for $root/.git instead, so that we use the --root
> parameter properly when seeding the camel case list.
> 
> Additionally, when generating the list of files to be checked, prefix
> the $root path so that the correct file will be found.
> 
> These changes allow checkpatch.pl to honor the --root parameter even if
> being run from within another git repository.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> (Resending with a not-invalid address for the netdev mailing list...)
> 

Ping? Andy? Joe?

This is a re-write of a rather old (couple of years old...) fix that I've been meaning to get around to submitting.

I'd like to have this picked up since it resolves issues with using --root while inside another git tree.

Thanks,
Jake

>  scripts/checkpatch.pl | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index d0001fd1112d..358add495e18 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -903,8 +903,8 @@ sub seed_camelcase_includes {
> 
>  	$camelcase_seeded = 1;
> 
> -	if (-e ".git") {
> -		my $git_last_include_commit = `git log --no-merges --
> pretty=format:"%h%n" -1 -- include`;
> +	if (-e "$root/.git") {
> +		my $git_last_include_commit = `cd $root && git log --no-merges --
> pretty=format:"%h%n" -1 -- include`;
>  		chomp $git_last_include_commit;
>  		$camelcase_cache = ".checkpatch-
> camelcase.git.$git_last_include_commit";
>  	} else {
> @@ -931,9 +931,10 @@ sub seed_camelcase_includes {
>  		return;
>  	}
> 
> -	if (-e ".git") {
> -		$files = `git ls-files "include/*.h"`;
> +	if (-e "$root/.git") {
> +		$files = `cd $root && git ls-files "include/*.h"`;
>  		@include_files = split('\n', $files);
> +		@include_files = map("$root/$_", @include_files);
>  	}
> 
>  	foreach my $file (@include_files) {
> --
> 2.18.0.219.gaf81d287a9da

