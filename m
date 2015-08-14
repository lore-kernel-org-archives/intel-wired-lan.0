From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 13 Aug 2015 18:54:26 -0700
Subject: [Intel-wired-lan] [net-next PATCH 1/2] i40e: fix kbuild warnings
Message-ID: <20150814015426.3815.89257.stgit@jbrandeb-hsm1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The 0day build infrastructure found some issues in i40e, this
removes the warnings by adding a harmless cast to a dev_info.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
CC: kbuild-all at 01.org
---
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 3671611..1556c4e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -1497,7 +1497,7 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 		/* check the range on address */
 		if (address > (pf->ioremap_len - sizeof(u32))) {
 			dev_info(&pf->pdev->dev, "read reg address 0x%08x too large, max=0x%08lx\n",
-				 address, (pf->ioremap_len - sizeof(u32)));
+				 address, (long unsigned int)(pf->ioremap_len - sizeof(u32)));
 			goto command_write_done;
 		}
 
@@ -1516,7 +1516,7 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 		/* check the range on address */
 		if (address > (pf->ioremap_len - sizeof(u32))) {
 			dev_info(&pf->pdev->dev, "write reg address 0x%08x too large, max=0x%08lx\n",
-				 address, (pf->ioremap_len - sizeof(u32)));
+				 address, (long unsigned int)(pf->ioremap_len - sizeof(u32)));
 			goto command_write_done;
 		}
 		wr32(&pf->hw, address, value);

