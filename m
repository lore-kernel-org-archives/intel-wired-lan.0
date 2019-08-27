From: Joe Perches <joe@perches.com>
Date: Tue, 27 Aug 2019 13:49:09 -0700
Subject: [Intel-wired-lan] [PATCH] checkpatch: Allow consecutive close braces
In-Reply-To: <c2279a78904b581924894b712403299903eacbfc.camel@intel.com>
References: <20190823191421.3318-1-ffleming@gmail.com>
 <c2279a78904b581924894b712403299903eacbfc.camel@intel.com>
Message-ID: <bfdb49ae2c3fa7b52fa168769e38b48f959880e2.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

checkpatch allows consecutive open braces, so it
should also allow consecutive close braces.

Signed-off-by: Joe Perches <joe@perches.com>
Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 287fe73688f0..ac5e0f06e1af 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4687,7 +4687,7 @@ sub process {
 
 # closing brace should have a space following it when it has anything
 # on the line
-		if ($line =~ /}(?!(?:,|;|\)))\S/) {
+		if ($line =~ /}(?!(?:,|;|\)|\}))\S/) {
 			if (ERROR("SPACING",
 				  "space required after that close brace '}'\n" . $herecurr) &&
 			    $fix) {


