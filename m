From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 19 Jun 2015 16:37:33 -0700
Subject: [Intel-wired-lan] [net-next 04/10] fm10k: TRIVIAL fix up ordering
	of __always_unused and style
In-Reply-To: <1434757059-3384-1-git-send-email-jacob.e.keller@intel.com>
References: <1434757059-3384-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1434757059-3384-4-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix some style issues in debugfs code, and correct ordering of void and
__always_unused. Technically, the order does not matter, but preferred
style is to put the macro between the type and name.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c b/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c
index f45b4d71adb8..08ecf43dffc7 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c
@@ -37,7 +37,8 @@ static void *fm10k_dbg_desc_seq_start(struct seq_file *s, loff_t *pos)
 }
 
 static void *fm10k_dbg_desc_seq_next(struct seq_file *s,
-				     void __always_unused *v, loff_t *pos)
+				     void __always_unused *v,
+				     loff_t *pos)
 {
 	struct fm10k_ring *ring = s->private;
 
@@ -45,7 +46,7 @@ static void *fm10k_dbg_desc_seq_next(struct seq_file *s,
 }
 
 static void fm10k_dbg_desc_seq_stop(struct seq_file __always_unused *s,
-				    __always_unused void *v)
+				    void __always_unused *v)
 {
 	/* Do nothing. */
 }
-- 
2.4.3

