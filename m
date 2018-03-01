From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date: Fri,  2 Mar 2018 00:37:23 +0100
Subject: [Intel-wired-lan] [RFC 4/5] fm10k: use seq_open_data()
In-Reply-To: <20180301233724.20440-1-linux@rasmusvillemoes.dk>
References: <20180301233724.20440-1-linux@rasmusvillemoes.dk>
Message-ID: <20180301233724.20440-4-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Simplify the code slightly by having seq_open_data do the ->private assignment.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c b/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c
index 14df09e2d964..acf034feb8fa 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c
@@ -132,20 +132,13 @@ static int fm10k_dbg_desc_open(struct inode *inode, struct file *filep)
 	struct fm10k_ring *ring = inode->i_private;
 	struct fm10k_q_vector *q_vector = ring->q_vector;
 	const struct seq_operations *desc_seq_ops;
-	int err;
 
 	if (ring < q_vector->rx.ring)
 		desc_seq_ops = &fm10k_dbg_tx_desc_seq_ops;
 	else
 		desc_seq_ops = &fm10k_dbg_rx_desc_seq_ops;
 
-	err = seq_open(filep, desc_seq_ops);
-	if (err)
-		return err;
-
-	((struct seq_file *)filep->private_data)->private = ring;
-
-	return 0;
+	return seq_open_data(filep, desc_seq_ops, ring);
 }
 
 static const struct file_operations fm10k_dbg_desc_fops = {
-- 
2.15.1

