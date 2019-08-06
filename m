From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue,  6 Aug 2019 18:11:26 +0200
Subject: [Intel-wired-lan] [PATCH 15/17] i40e: no need to check return value
 of debugfs_create functions
In-Reply-To: <20190806161128.31232-1-gregkh@linuxfoundation.org>
References: <20190806161128.31232-1-gregkh@linuxfoundation.org>
Message-ID: <20190806161128.31232-16-gregkh@linuxfoundation.org>
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
 .../net/ethernet/intel/i40e/i40e_debugfs.c    | 21 ++++---------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 55d20acfcf70..0df9454b3315 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -1732,29 +1732,16 @@ static const struct file_operations i40e_dbg_netdev_ops_fops = {
  **/
 void i40e_dbg_pf_init(struct i40e_pf *pf)
 {
-	struct dentry *pfile;
 	const char *name = pci_name(pf->pdev);
 	const struct device *dev = &pf->pdev->dev;
 
 	pf->i40e_dbg_pf = debugfs_create_dir(name, i40e_dbg_root);
-	if (!pf->i40e_dbg_pf)
-		return;
-
-	pfile = debugfs_create_file("command", 0600, pf->i40e_dbg_pf, pf,
-				    &i40e_dbg_command_fops);
-	if (!pfile)
-		goto create_failed;
 
-	pfile = debugfs_create_file("netdev_ops", 0600, pf->i40e_dbg_pf, pf,
-				    &i40e_dbg_netdev_ops_fops);
-	if (!pfile)
-		goto create_failed;
+	debugfs_create_file("command", 0600, pf->i40e_dbg_pf, pf,
+			    &i40e_dbg_command_fops);
 
-	return;
-
-create_failed:
-	dev_info(dev, "debugfs dir/file for %s failed\n", name);
-	debugfs_remove_recursive(pf->i40e_dbg_pf);
+	debugfs_create_file("netdev_ops", 0600, pf->i40e_dbg_pf, pf,
+			    &i40e_dbg_netdev_ops_fops);
 }
 
 /**
-- 
2.22.0

