From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 31 Aug 2016 20:27:50 +0000
Subject: [Intel-wired-lan] [PATCH v2] checkpatch.pl: seed camelcase from
 the	provided kernel tree root
In-Reply-To: <20160829210047.25111-1-jacob.e.keller@intel.com>
References: <20160829210047.25111-1-jacob.e.keller@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81F7A0C0@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Monday, August 29, 2016 2:01 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH v2] checkpatch.pl: seed camelcase from the
> provided kernel tree root
> 
> When checkpatch.pl is run without a git tree, it seeds the camelcase
> includes from the $root parameter. However, it does not use the $root
> directory when seeding for a git tree. Fix this by using "cd $root &&"
> so that a user may run checkpatch with the --root parameter pointing to
> a valid kernel source tree. In addition, when generating the list of
> files to check, we must also prefix each file with the $root parameter,
> in order to properly locate the file when searching.
> 
> We avoid the use of -C parameter of git because it is not supported on
> old versions of git, so we want to avoid breaking checkpatch.pl on those
> systems.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  scripts/checkpatch.pl | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Well, it does throw a few checkpatch warnings...  oh the irony.
---------------------------------------------------------------------
WARNING: A patch subject line should describe the change not the tool that found it
#4:
Subject: [PATCH] checkpatch.pl: seed camelcase from the provided kernel tree

WARNING: line over 80 characters
#35: FILE: scripts/checkpatch.pl:718:
+               my $git_last_include_commit = `cd $root && git log --no-merges --pretty=format:"%h%n" -1 -- include`;

total: 0 errors, 2 warnings, 22 lines checked
---------------------------------------------------------------------
The first is clearly a false warning, thinks checkpatch is the tool that found the error rather than the tool being fixed.  ;)   The second is just a long line in the perl code, which I don't really consider a blocking issue so...

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
