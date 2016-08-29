From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 29 Aug 2016 14:00:47 -0700
Subject: [Intel-wired-lan] [PATCH v2] checkpatch.pl: seed camelcase from the
	provided kernel tree root
Message-ID: <20160829210047.25111-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When checkpatch.pl is run without a git tree, it seeds the camelcase
includes from the $root parameter. However, it does not use the $root
directory when seeding for a git tree. Fix this by using "cd $root &&"
so that a user may run checkpatch with the --root parameter pointing to
a valid kernel source tree. In addition, when generating the list of
files to check, we must also prefix each file with the $root parameter,
in order to properly locate the file when searching.

We avoid the use of -C parameter of git because it is not supported on
old versions of git, so we want to avoid breaking checkpatch.pl on those
systems.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 scripts/checkpatch.pl | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4de3cc42fc50..ad8d3509f2d7 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -714,8 +714,8 @@ sub seed_camelcase_includes {
 
 	$camelcase_seeded = 1;
 
-	if (-e ".git") {
-		my $git_last_include_commit = `git log --no-merges --pretty=format:"%h%n" -1 -- include`;
+	if (-e "$root/.git") {
+		my $git_last_include_commit = `cd $root && git log --no-merges --pretty=format:"%h%n" -1 -- include`;
 		chomp $git_last_include_commit;
 		$camelcase_cache = ".checkpatch-camelcase.git.$git_last_include_commit";
 	} else {
@@ -742,9 +742,10 @@ sub seed_camelcase_includes {
 		return;
 	}
 
-	if (-e ".git") {
-		$files = `git ls-files "include/*.h"`;
+	if (-e "$root/.git") {
+		$files = `cd $root && git ls-files "include/*.h"`;
 		@include_files = split('\n', $files);
+		@include_files = map("$root/$_", @include_files);
 	}
 
 	foreach my $file (@include_files) {
-- 
2.10.0.rc2.311.g2bd286e

