From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  7 Jan 2019 16:55:02 -0800
Subject: [Intel-wired-lan] [PATCH] checkpatch: don't complain about
 LEADING_SPACE in CPP continuations
Message-ID: <20190108005502.4210-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

If a C preprocessor macro is continued onto another line using
a backslash line continuation, checkpatch.pl will complain about leading
spaces used to indent the multiline conditional.

This leads to warnings similar to the following

  WARNING: please, no spaces at the start of a line
  #107: FILE: arch/m68k/include/asm/mcfgpio.h:107:
  +    defined(CONFIG_M53xx) || defined(CONFIG_M54xx) || \$

  WARNING: please, no spaces at the start of a line
  #108: FILE: arch/m68k/include/asm/mcfgpio.h:108:
  +    defined(CONFIG_M5441x)$

To fix these warnings, modify the test to also exclude lines which end
in a backslach continuation, as these lines should only occur within
a multiline C Preprocessor check.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e16ce8b0c462..871bb37876b2 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3361,7 +3361,8 @@ sub process {
 #  1) within comments
 #  2) indented preprocessor commands
 #  3) hanging labels
-		if ($rawline =~ /^\+ / && $line !~ /^\+ *(?:$;|#|$Ident:)/)  {
+		if ($rawline =~ /^\+ / && $line !~ /^\+ *(?:$;|#|$Ident:)/ &&
+		    $prevline !~ /\\$/)  {
 			my $herevet = "$here\n" . cat_vet($rawline) . "\n";
 			if (WARN("LEADING_SPACE",
 				 "please, no spaces at the start of a line\n" . $herevet) &&
-- 
2.18.0.219.gaf81d287a9da

