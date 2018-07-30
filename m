From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 30 Jul 2018 15:52:48 -0700
Subject: [Intel-wired-lan] [PATCH v2] ixgbe: Prevent unsupported
 configurations with XDP
Message-ID: <20180730225248.42639-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

These changes address comments by Jakub Kicinski on
commit 38b7e7f8ae82 ("ixgbe: Do not allow LRO or MTU change with XDP").

Change the MTU check with XDP to allow any supported value and only
reject those outside of the range as opposed to rejecting any change
when XDP is active. In situations where MTU size is not supported,
return -EINVAL instead of -EPERM.

Add checks when enabling SRIOV, DCB, or adding L2FW offloaded device
as they are not supported with XDP.

CC: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
v2:
Added check for L2FW offload and updated description.

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  | 28 ++++++++++++++++++++++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |  5 +++++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 447098005490..4081e5a9ead3 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6620,8 +6620,18 @@ static int ixgbe_change_mtu(struct net_device *netdev, int new_mtu)
 	struct ixgbe_adapter *adapter = netdev_priv(netdev);
 
 	if (adapter->xdp_prog) {
-		e_warn(probe, "MTU cannot be changed while XDP program is loaded\n");
-		return -EPERM;
+		int new_frame_size = new_mtu + ETH_HLEN + ETH_FCS_LEN +
+				     VLAN_HLEN;
+		int i;
+
+		for (i = 0; i < adapter->num_rx_queues; i++) {
+			struct ixgbe_ring *ring = adapter->rx_ring[i];
+
+			if (new_frame_size > ixgbe_rx_bufsz(ring)) {
+				e_warn(probe, "Requested MTU size is not supported with XDP\n");
+				return -EINVAL;
+			}
+		}
 	}
 
 	/*
@@ -8983,6 +8993,15 @@ int ixgbe_setup_tc(struct net_device *dev, u8 tc)
 
 #ifdef CONFIG_IXGBE_DCB
 	if (tc) {
+		if (adapter->xdp_prog) {
+			e_warn(probe, "DCB is not supported with XDP\n");
+
+			ixgbe_init_interrupt_scheme(adapter);
+			if (netif_running(dev))
+				ixgbe_open(dev);
+			return -EINVAL;
+		}
+
 		netdev_set_num_tc(dev, tc);
 		ixgbe_set_prio_tc_map(adapter);
 
@@ -9936,6 +9955,11 @@ static void *ixgbe_fwd_add(struct net_device *pdev, struct net_device *vdev)
 	int tcs = adapter->hw_tcs ? : 1;
 	int pool, err;
 
+	if (adapter->xdp_prog) {
+		e_warn(probe, "L2FW offload is not supported with XDP\n");
+		return ERR_PTR(-EINVAL);
+	}
+
 	/* The hardware supported by ixgbe only filters on the destination MAC
 	 * address. In order to avoid issues we only support offloading modes
 	 * where the hardware can actually provide the functionality.
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 6f59933cdff7..9264a5f8a5d0 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -53,6 +53,11 @@ static int __ixgbe_enable_sriov(struct ixgbe_adapter *adapter,
 	struct ixgbe_hw *hw = &adapter->hw;
 	int i;
 
+	if (adapter->xdp_prog) {
+		e_warn(probe, "SRIOV is not supported with XDP\n");
+		return -EINVAL;
+	}
+
 	/* Enable VMDq flag so device will be set in VM mode */
 	adapter->flags |= IXGBE_FLAG_SRIOV_ENABLED |
 			  IXGBE_FLAG_VMDQ_ENABLED;
-- 
2.13.6

