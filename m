From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 16 Nov 2017 11:54:44 -0800
Subject: [Intel-wired-lan] [RFC PATCH jkirsher/next-queue 6/9] ixgbe: add
 ipsec debug helpers
In-Reply-To: <1510862087-1924-1-git-send-email-shannon.nelson@oracle.com>
References: <1510862087-1924-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <1510862087-1924-7-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

These are a couple of debugfs commands to inspect and manage the ipsec
tables.  I really don't expect this patch to be in the final patchset.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c
index 5e2c1e3..0d0a9f0 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c
@@ -120,11 +120,27 @@ static ssize_t ixgbe_dbg_reg_ops_write(struct file *filp,
 		} else {
 			e_dev_info("read <reg>\n");
 		}
+#ifdef CONFIG_XFRM_OFFLOAD
+	} else if (strncmp(ixgbe_dbg_reg_ops_buf, "ipsec-sw-dump", 13) == 0) {
+		ixgbe_ipsec_dump_info(adapter);
+	} else if (strncmp(ixgbe_dbg_reg_ops_buf, "ipsec-hw-dump", 13) == 0) {
+		ixgbe_ipsec_dump_hw(adapter);
+	} else if (strncmp(ixgbe_dbg_reg_ops_buf, "ipsec-hw-clean", 14) == 0) {
+		ixgbe_ipsec_clear_hw_tables(adapter);
+	} else if (strncmp(ixgbe_dbg_reg_ops_buf, "ipsec-restore", 13) == 0) {
+		ixgbe_ipsec_restore(adapter);
+#endif /* CONFIG_XFRM_OFFLOAD */
 	} else {
 		e_dev_info("Unknown command %s\n", ixgbe_dbg_reg_ops_buf);
 		e_dev_info("Available commands:\n");
 		e_dev_info("   read <reg>\n");
 		e_dev_info("   write <reg> <value>\n");
+#ifdef CONFIG_XFRM_OFFLOAD
+		e_dev_info("   ipsec-sw-dump\n");
+		e_dev_info("   ipsec-hw-dump\n");
+		e_dev_info("   ipsec-hw-clean\n");
+		e_dev_info("   ipsec-restore\n");
+#endif /* CONFIG_XFRM_OFFLOAD */
 	}
 	return count;
 }
-- 
2.7.4

