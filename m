From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  4 Oct 2017 17:33:58 -0700
Subject: [Intel-wired-lan] [PATCH] checkpatch.pl: allow commit descriptions
	to include date
Message-ID: <20171005003358.3879-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Since commit d311cd44545f ("checkpatch: add test for commit id
formatting style in commit log") checkpatch has supported a check that
git commit references are done in a standardized way.

Some communities (the Git mailing list, among others) advocate the
addition of a date to the end of the description, converting

  d311cd44545f ("checkpatch: add test for commit id formatting style in commit log")

into

  d311cd44545f ("checkpatch: add test for commit id formatting style in commit log", 2014-08-06)

Extend checkpatch.pl to allow such a date, and add verification that the
date matches the commit author date, if it exists.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 scripts/checkpatch.pl | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index ebea4f078246..2076e9833025 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -871,15 +871,15 @@ sub seed_camelcase_includes {
 }
 
 sub git_commit_info {
-	my ($commit, $id, $desc) = @_;
+	my ($commit, $id, $date, $desc) = @_;
 
-	return ($id, $desc) if ((which("git") eq "") || !(-e ".git"));
+	return ($id, $date, $desc) if ((which("git") eq "") || !(-e ".git"));
 
-	my $output = `git log --no-color --format='%H %s' -1 $commit 2>&1`;
+	my $output = `git log --date=short --no-color --format='%H %ad %s' -1 $commit 2>&1`;
 	$output =~ s/^\s*//gm;
 	my @lines = split("\n", $output);
 
-	return ($id, $desc) if ($#lines < 0);
+	return ($id, $date, $desc) if ($#lines < 0);
 
 	if ($lines[0] =~ /^error: short SHA1 $commit is ambiguous\./) {
 # Maybe one day convert this block of bash into something that returns
@@ -895,10 +895,11 @@ sub git_commit_info {
 		$id = undef;
 	} else {
 		$id = substr($lines[0], 0, 12);
-		$desc = substr($lines[0], 41);
+		$date = substr($lines[0], 41, 10);
+		$desc = substr($lines[0], 52);
 	}
 
-	return ($id, $desc);
+	return ($id, $date, $desc);
 }
 
 $chk_signoff = 0 if ($file);
@@ -2597,6 +2598,8 @@ sub process {
 			my $hasdesc = 0;
 			my $hasparens = 0;
 			my $id = '0123456789ab';
+			my $orig_date = undef;
+			my $date = "";
 			my $orig_desc = "commit description";
 			my $description = "";
 
@@ -2611,29 +2614,32 @@ sub process {
 			$long = 1 if ($line =~ /\bcommit\s+[0-9a-f]{41,}/i);
 			$space = 0 if ($line =~ /\bcommit [0-9a-f]/i);
 			$case = 0 if ($line =~ /\b[Cc]ommit\s+[0-9a-f]{5,40}[^A-F]/);
-			if ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)"\)/i) {
+			if ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)"(,\s*([-0-9]+))?\)/i) {
 				$orig_desc = $1;
+				$orig_date = $3;
 				$hasparens = 1;
 			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s*$/i &&
 				 defined $rawlines[$linenr] &&
-				 $rawlines[$linenr] =~ /^\s*\("([^"]+)"\)/) {
+				 $rawlines[$linenr] =~ /^\s*\("([^"]+)"(,\s*([-0-9]+))?\)/) {
 				$orig_desc = $1;
+				$orig_date = $3;
 				$hasparens = 1;
 			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("[^"]+$/i &&
 				 defined $rawlines[$linenr] &&
-				 $rawlines[$linenr] =~ /^\s*[^"]+"\)/) {
+				 $rawlines[$linenr] =~ /^\s*[^"]+"(,\s*([-0-9]+))?\)/) {
 				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)$/i;
 				$orig_desc = $1;
-				$rawlines[$linenr] =~ /^\s*([^"]+)"\)/;
+				$rawlines[$linenr] =~ /^\s*([^"]+)"(,\s*([-0-9]+))?\)/;
 				$orig_desc .= " " . $1;
+				$orig_date = $3;
 				$hasparens = 1;
 			}
 
-			($id, $description) = git_commit_info($orig_commit,
-							      $id, $orig_desc);
+			($id, $date, $description) = git_commit_info($orig_commit,
+						      $id, $orig_date, $orig_desc);
 
 			if (defined($id) &&
-			   ($short || $long || $space || $case || ($orig_desc ne $description) || !$hasparens)) {
+			   ($short || $long || $space || $case || ($orig_desc ne $description) || ($orig_date && $orig_date ne $date) || !$hasparens)) {
 				ERROR("GIT_COMMIT_ID",
 				      "Please use git commit description style 'commit <12+ chars of sha1> (\"<title line>\")' - ie: '${init_char}ommit $id (\"$description\")'\n" . $herecurr);
 			}
-- 
2.14.1.436.g33e61a4f0239

