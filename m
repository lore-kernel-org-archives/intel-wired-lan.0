From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Sat, 10 Aug 2019 12:17:31 +0200
Subject: [Intel-wired-lan] [PATCH v3 16/17] ixgbe: no need to check return
 value of debugfs_create functions
In-Reply-To: <20190810101732.26612-1-gregkh@linuxfoundation.org>
References: <20190810101732.26612-1-gregkh@linuxfoundation.org>
Message-ID: <20190810101732.26612-17-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: intel-wired-lan at lists.osuosl.org
Cc: netdev at vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../net/ethernet/intel/ixgbe/ixgbe_debugfs.c  | 22 +++++--------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c
index 50dfb02fa34c..171cdc552961 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c
@@ -190,22 +190,12 @@ static const struct file_operations ixgbe_dbg_netdev_ops_fops = {
 void ixgbe_dbg_adapter_init(struct ixgbe_adapter *adapter)
 {
 	const char *name = pci_name(adapter->pdev);
-	struct dentry *pfile;
+
 	adapter->ixgbe_dbg_adapter = debugfs_create_dir(name, ixgbe_dbg_root);
-	if (adapter->ixgbe_dbg_adapter) {
-		pfile = debugfs_create_file("reg_ops", 0600,
-					    adapter->ixgbe_dbg_adapter, adapter,
-					    &ixgbe_dbg_reg_ops_fops);
-		if (!pfile)
-			e_dev_err("debugfs reg_ops for %s failed\n", name);
-		pfile = debugfs_create_file("netdev_ops", 0600,
-					    adapter->ixgbe_dbg_adapter, adapter,
-					    &ixgbe_dbg_netdev_ops_fops);
-		if (!pfile)
-			e_dev_err("debugfs netdev_ops for %s failed\n", name);
-	} else {
-		e_dev_err("debugfs entry for %s failed\n", name);
-	}
+	debugfs_create_file("reg_ops", 0600, adapter->ixgbe_dbg_adapter,
+			    adapter, &ixgbe_dbg_reg_ops_fops);
+	debugfs_create_file("netdev_ops", 0600, adapter->ixgbe_dbg_adapter,
+			    adapter, &ixgbe_dbg_netdev_ops_fops);
 }
 
 /**
@@ -224,8 +214,6 @@ void ixgbe_dbg_adapter_exit(struct ixgbe_adapter *adapter)
 void ixgbe_dbg_init(void)
 {
 	ixgbe_dbg_root = debugfs_create_dir(ixgbe_driver_name, NULL);
-	if (ixgbe_dbg_root == NULL)
-		pr_err("init of debugfs failed\n");
 }
 
 /**
-- 
2.22.0

