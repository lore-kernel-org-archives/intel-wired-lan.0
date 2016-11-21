From: Stephen Hemminger <stephen@networkplumber.org>
Date: Mon, 21 Nov 2016 09:52:40 -0800
Subject: [Intel-wired-lan] [PATCH net-next] ixgbe: prefix Data Center Bridge
	ops struct
Message-ID: <20161121095240.529ed49d@samsung9>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Stephen Hemminger <sthemmin@microsoft.com>

Since dcbnl_ops is global, it should be prefixed by ixgbe_

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h        | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index ef81c3d..af8c43d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -871,7 +871,7 @@ extern const struct ixgbe_info ixgbe_X550_info;
 extern const struct ixgbe_info ixgbe_X550EM_x_info;
 extern const struct ixgbe_info ixgbe_x550em_a_info;
 #ifdef CONFIG_IXGBE_DCB
-extern const struct dcbnl_rtnl_ops dcbnl_ops;
+extern const struct dcbnl_rtnl_ops ixgbe_dcbnl_ops;
 #endif
 
 extern char ixgbe_driver_name[];
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c
index b8fc3cf..78c5237 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c
@@ -777,7 +777,7 @@ static u8 ixgbe_dcbnl_setdcbx(struct net_device *dev, u8 mode)
 	return err ? 1 : 0;
 }
 
-const struct dcbnl_rtnl_ops dcbnl_ops = {
+const struct dcbnl_rtnl_ops ixgbe_dcbnl_ops = {
 	.ieee_getets	= ixgbe_dcbnl_ieee_getets,
 	.ieee_setets	= ixgbe_dcbnl_ieee_setets,
 	.ieee_getpfc	= ixgbe_dcbnl_ieee_getpfc,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 2436984..a3dd790 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9669,7 +9669,7 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 #ifdef CONFIG_IXGBE_DCB
 	if (adapter->flags & IXGBE_FLAG_DCB_CAPABLE)
-		netdev->dcbnl_ops = &dcbnl_ops;
+		netdev->dcbnl_ops = &ixgbe_dcbnl_ops;
 #endif
 
 #ifdef IXGBE_FCOE
-- 
2.7.4

