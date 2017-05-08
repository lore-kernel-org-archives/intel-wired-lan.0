From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 8 May 2017 18:18:09 +0200
Subject: [Intel-wired-lan] [PATCH] fm10k: Use seq_putc() in
	fm10k_dbg_desc_break()
Message-ID: <4f8686c6-76cb-3d12-934e-6af67b6f084b@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 8 May 2017 18:10:39 +0200

Two single characters should be put into a sequence.
Thus use the corresponding function "seq_putc".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c b/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c
index 5116fd043630..14df09e2d964 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c
@@ -52,9 +52,9 @@ static void fm10k_dbg_desc_seq_stop(struct seq_file __always_unused *s,
 static void fm10k_dbg_desc_break(struct seq_file *s, int i)
 {
 	while (i--)
-		seq_puts(s, "-");
+		seq_putc(s, '-');
 
-	seq_puts(s, "\n");
+	seq_putc(s, '\n');
 }
 
 static int fm10k_dbg_tx_desc_seq_show(struct seq_file *s, void *v)
-- 
2.12.2

