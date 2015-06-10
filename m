From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 10 Jun 2015 11:44:45 -0700
Subject: [Intel-wired-lan] [next-queue] ixgbe: TRIVIAL fix up double 'the'
	and comment style
Message-ID: <1433961885-7506-1-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 03336013a76c..7357108c4a5f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -248,8 +248,7 @@ static void ixgbe_check_minimum_link(struct ixgbe_adapter *adapter,
 	enum pcie_link_width width = PCIE_LNK_WIDTH_UNKNOWN;
 	struct pci_dev *pdev;
 
-	/* determine whether to use the the parent device
-	 */
+	/* determine whether to use the parent device */
 	if (ixgbe_pcie_from_parent(&adapter->hw))
 		pdev = adapter->pdev->bus->parent->self;
 	else
-- 
2.4.2

