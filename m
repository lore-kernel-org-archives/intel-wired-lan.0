From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 30 May 2018 16:14:23 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Do not allow LRO or MTU change
 with XDP
Message-ID: <20180530231423.28864-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

XDP does not support jumbo frames or LRO.  These checks are being made
outside the driver when an XDP program is loaded, however, there is
nothing preventing these from changing after an XDP program is loaded.
Add the checks so that while an XDP program is loaded, do not allow MTU
to be changed or LRO to be enabled.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index b47a19de22e8..0a0822de2ab7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6453,6 +6453,11 @@ static int ixgbe_change_mtu(struct net_device *netdev, int new_mtu)
 {
 	struct ixgbe_adapter *adapter = netdev_priv(netdev);
 
+	if (adapter->xdp_prog) {
+		e_warn(probe, "MTU cannot be changed while XDP program is loaded\n");
+		return -EPERM;
+	}
+
 	/*
 	 * For 82599EB we cannot allow legacy VFs to enable their receive
 	 * paths when MTU greater than 1500 is configured.  So display a
@@ -9396,6 +9401,11 @@ static netdev_features_t ixgbe_fix_features(struct net_device *netdev,
 	if (!(adapter->flags2 & IXGBE_FLAG2_RSC_CAPABLE))
 		features &= ~NETIF_F_LRO;
 
+	if (adapter->xdp_prog && (features & NETIF_F_LRO)) {
+		e_dev_err("LRO is not supported with XDP\n");
+		features &= ~NETIF_F_LRO;
+	}
+
 	return features;
 }
 
-- 
2.13.6

