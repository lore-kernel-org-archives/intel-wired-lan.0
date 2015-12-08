From: Usha Ketineni <usha.k.ketineni@intel.com>
Date: Tue, 08 Dec 2015 04:01:18 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix to get FDMI HBA attributes
	information with X550
Message-ID: <20151208120118.17644.79053.stgit@ukketine.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Check whether the FCOE support is enabled for the devices to get the
 FDMI HBA attributes information instead of checking each device id.
Also, add Model string information for X550.

Signed-off-by: Usha Ketineni <usha.k.ketineni@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
index 5f98870..52a0378 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
@@ -996,8 +996,7 @@ int ixgbe_fcoe_get_hbainfo(struct net_device *netdev,
 		return -EINVAL;
 
 	/* Don't return information on unsupported devices */
-	if (hw->mac.type != ixgbe_mac_82599EB &&
-	    hw->mac.type != ixgbe_mac_X540)
+	if (!(adapter->flags & IXGBE_FLAG_FCOE_ENABLED))
 		return -EINVAL;
 
 	/* Manufacturer */
@@ -1043,6 +1042,10 @@ int ixgbe_fcoe_get_hbainfo(struct net_device *netdev,
 		snprintf(info->model,
 			 sizeof(info->model),
 			 "Intel 82599");
+	} else if (hw->mac.type == ixgbe_mac_X550) {
+		snprintf(info->model,
+			 sizeof(info->model),
+			 "Intel X550");
 	} else {
 		snprintf(info->model,
 			 sizeof(info->model),

