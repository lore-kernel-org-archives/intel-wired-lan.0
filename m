From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 23 May 2018 20:08:13 +0800
Subject: [Intel-wired-lan] [PATCH net-next] ixgbe: introduce a helper to
 simplify code
Message-ID: <20180523120813.14800-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ixgbe_dbg_reg_ops_read and ixgbe_dbg_netdev_ops_read copy-pasting
the same code except for ixgbe_dbg_netdev_ops_buf/ixgbe_dbg_reg_ops_buf,
so introduce a helper ixgbe_dbg_common_ops_read to remove redundant code.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c | 57 +++++++++---------------
 1 file changed, 21 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c
index 55fe811..50dfb02 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c
@@ -10,15 +10,9 @@ static struct dentry *ixgbe_dbg_root;
 
 static char ixgbe_dbg_reg_ops_buf[256] = "";
 
-/**
- * ixgbe_dbg_reg_ops_read - read for reg_ops datum
- * @filp: the opened file
- * @buffer: where to write the data for the user to read
- * @count: the size of the user's buffer
- * @ppos: file position offset
- **/
-static ssize_t ixgbe_dbg_reg_ops_read(struct file *filp, char __user *buffer,
-				    size_t count, loff_t *ppos)
+static ssize_t ixgbe_dbg_common_ops_read(struct file *filp, char __user *buffer,
+					 size_t count, loff_t *ppos,
+					 char *dbg_buf)
 {
 	struct ixgbe_adapter *adapter = filp->private_data;
 	char *buf;
@@ -29,8 +23,7 @@ static ssize_t ixgbe_dbg_reg_ops_read(struct file *filp, char __user *buffer,
 		return 0;
 
 	buf = kasprintf(GFP_KERNEL, "%s: %s\n",
-			adapter->netdev->name,
-			ixgbe_dbg_reg_ops_buf);
+			adapter->netdev->name, dbg_buf);
 	if (!buf)
 		return -ENOMEM;
 
@@ -46,6 +39,20 @@ static ssize_t ixgbe_dbg_reg_ops_read(struct file *filp, char __user *buffer,
 }
 
 /**
+ * ixgbe_dbg_reg_ops_read - read for reg_ops datum
+ * @filp: the opened file
+ * @buffer: where to write the data for the user to read
+ * @count: the size of the user's buffer
+ * @ppos: file position offset
+ **/
+static ssize_t ixgbe_dbg_reg_ops_read(struct file *filp, char __user *buffer,
+				      size_t count, loff_t *ppos)
+{
+	return ixgbe_dbg_common_ops_read(filp, buffer, count, ppos,
+					 ixgbe_dbg_reg_ops_buf);
+}
+
+/**
  * ixgbe_dbg_reg_ops_write - write into reg_ops datum
  * @filp: the opened file
  * @buffer: where to find the user's data
@@ -121,33 +128,11 @@ static char ixgbe_dbg_netdev_ops_buf[256] = "";
  * @count: the size of the user's buffer
  * @ppos: file position offset
  **/
-static ssize_t ixgbe_dbg_netdev_ops_read(struct file *filp,
-					 char __user *buffer,
+static ssize_t ixgbe_dbg_netdev_ops_read(struct file *filp, char __user *buffer,
 					 size_t count, loff_t *ppos)
 {
-	struct ixgbe_adapter *adapter = filp->private_data;
-	char *buf;
-	int len;
-
-	/* don't allow partial reads */
-	if (*ppos != 0)
-		return 0;
-
-	buf = kasprintf(GFP_KERNEL, "%s: %s\n",
-			adapter->netdev->name,
-			ixgbe_dbg_netdev_ops_buf);
-	if (!buf)
-		return -ENOMEM;
-
-	if (count < strlen(buf)) {
-		kfree(buf);
-		return -ENOSPC;
-	}
-
-	len = simple_read_from_buffer(buffer, count, ppos, buf, strlen(buf));
-
-	kfree(buf);
-	return len;
+	return ixgbe_dbg_common_ops_read(filp, buffer, count, ppos,
+					 ixgbe_dbg_netdev_ops_buf);
 }
 
 /**
-- 
2.7.0


