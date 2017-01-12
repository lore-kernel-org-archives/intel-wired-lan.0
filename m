From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 12 Jan 2017 15:59:38 -0800
Subject: [Intel-wired-lan] [PATCH 1/5] fm10k: use a BITMAP for flags to
	avoid race conditions
Message-ID: <20170112235942.5767-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Replace bitwise operators and #defines with a BITMAP and enumeration
values. This is similar to how we handle the "state" values as well.

This has two distinct advantages over the old method. First, we ensure
correctness of operations which are currently problematic due to race
conditions. Suppose that two kernel threads are running, such as the
watchdog and an ethtool ioctl, and both modify flags. We'll say that the
watchdog is CPU A, and the ethtool ioctl is CPU B.

CPU A sets FLAG_1, which can be seen as
  CPU A read FLAGS
  CPU A write FLAGS | FLAG_1

CPU B sets FLAG_2, which can be seen as
  CPU B read FLAGS
  CPU A write FLAGS | FLAG_2

However, "|=" and "&=" operators are not actually atomic. So this could
be ordered like the following:

CPU A read FLAGS -> variable
CPU B read FLAGS -> variable
CPU A write FLAGS (variable | FLAG_1)
CPU B write FLAGS (variable | FLAG_2)

Notice how the 2nd write from CPU B could actually undo the write from
CPU A because it isn't guaranteed that the |= operation is atomic.

In practice the race windows for most flag writes is incredibly narrow
so it is not easy to isolate issues. However, the more flags we have,
the more likely they will cause problems. Additionally, if such
a problem were to arise, it would be incredibly difficult to track down.

Second, there is an additional advantage beyond code correctness. We can
now automatically size the BITMAP if more flags were added, so that we
do not need to remember that flags is u32 and thus if we added too many
flags we would over-run the variable. This is not a likely occurrence
for fm10k driver, but this patch can serve as an example for other
drivers which have many more flags.

This particular change does have a bit of trouble converting some of the
idioms previously used with the #defines for flags. Specifically, when
converting FM10K_FLAG_RSS_FIELD_IPV[46]_UDP flags. This whole operation
was actually quite problematic, because we actually stored flags
separately. This could more easily show the problem of the above
re-ordering issue.

This is really difficult to test whether atomics make a difference in
practical scenarios, but you can ensure that basic functionality remains
the same. This patch has a lot of code coverage, but most of it is
relatively simple.

While we are modifying these files, update their copyright year.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k.h         | 27 ++++++++---
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 62 ++++++++++++++++--------
 drivers/net/ethernet/intel/fm10k/fm10k_main.c    |  6 +--
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c  |  4 +-
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c     | 31 ++++++------
 5 files changed, 82 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h b/drivers/net/ethernet/intel/fm10k/fm10k.h
index 52b979443cde..d6db1c48d4dc 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
@@ -1,5 +1,5 @@
 /* Intel(R) Ethernet Switch Host Interface Driver
- * Copyright(c) 2013 - 2016 Intel Corporation.
+ * Copyright(c) 2013 - 2017 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -249,6 +249,23 @@ struct fm10k_udp_port {
 /* one work queue for entire driver */
 extern struct workqueue_struct *fm10k_workqueue;
 
+/* The following enumeration contains flags which indicate or enable modified
+ * driver behaviors. To avoid race conditions, the flags are stored in
+ * a BITMAP in the fm10k_intfc structure. The BITMAP should be accessed using
+ * atomic *_bit() operations.
+ */
+enum fm10k_flags_t {
+	FM10K_FLAG_RESET_REQUESTED,
+	FM10K_FLAG_RSS_FIELD_IPV4_UDP,
+	FM10K_FLAG_RSS_FIELD_IPV6_UDP,
+	FM10K_FLAG_SWPRI_CONFIG,
+	/* __FM10K_FLAGS_SIZE__ is used to calculate the size of
+	 * interface->flags and must be the last value in this
+	 * enumeration.
+	 */
+	__FM10K_FLAGS_SIZE__
+};
+
 struct fm10k_intfc {
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
 	struct net_device *netdev;
@@ -256,11 +273,9 @@ struct fm10k_intfc {
 	struct pci_dev *pdev;
 	unsigned long state;
 
-	u32 flags;
-#define FM10K_FLAG_RESET_REQUESTED		(u32)(BIT(0))
-#define FM10K_FLAG_RSS_FIELD_IPV4_UDP		(u32)(BIT(1))
-#define FM10K_FLAG_RSS_FIELD_IPV6_UDP		(u32)(BIT(2))
-#define FM10K_FLAG_SWPRI_CONFIG			(u32)(BIT(3))
+	/* Access flag values using atomic *_bit() operations */
+	DECLARE_BITMAP(flags, __FM10K_FLAGS_SIZE__);
+
 	int xcast_mode;
 
 	/* Tx fast path data */
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index 0c84fef750f4..557966749174 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -1,5 +1,5 @@
 /* Intel(R) Ethernet Switch Host Interface Driver
- * Copyright(c) 2013 - 2016 Intel Corporation.
+ * Copyright(c) 2013 - 2017 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -716,7 +716,8 @@ static int fm10k_get_rss_hash_opts(struct fm10k_intfc *interface,
 		cmd->data |= RXH_L4_B_0_1 | RXH_L4_B_2_3;
 		/* fall through */
 	case UDP_V4_FLOW:
-		if (interface->flags & FM10K_FLAG_RSS_FIELD_IPV4_UDP)
+		if (test_bit(FM10K_FLAG_RSS_FIELD_IPV4_UDP,
+			     interface->flags))
 			cmd->data |= RXH_L4_B_0_1 | RXH_L4_B_2_3;
 		/* fall through */
 	case SCTP_V4_FLOW:
@@ -732,7 +733,8 @@ static int fm10k_get_rss_hash_opts(struct fm10k_intfc *interface,
 		cmd->data |= RXH_IP_SRC | RXH_IP_DST;
 		break;
 	case UDP_V6_FLOW:
-		if (interface->flags & FM10K_FLAG_RSS_FIELD_IPV6_UDP)
+		if (test_bit(FM10K_FLAG_RSS_FIELD_IPV6_UDP,
+			     interface->flags))
 			cmd->data |= RXH_L4_B_0_1 | RXH_L4_B_2_3;
 		cmd->data |= RXH_IP_SRC | RXH_IP_DST;
 		break;
@@ -764,12 +766,13 @@ static int fm10k_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 	return ret;
 }
 
-#define UDP_RSS_FLAGS (FM10K_FLAG_RSS_FIELD_IPV4_UDP | \
-		       FM10K_FLAG_RSS_FIELD_IPV6_UDP)
 static int fm10k_set_rss_hash_opt(struct fm10k_intfc *interface,
 				  struct ethtool_rxnfc *nfc)
 {
-	u32 flags = interface->flags;
+	int rss_ipv4_udp = test_bit(FM10K_FLAG_RSS_FIELD_IPV4_UDP,
+				    interface->flags);
+	int rss_ipv6_udp = test_bit(FM10K_FLAG_RSS_FIELD_IPV6_UDP,
+				    interface->flags);
 
 	/* RSS does not support anything other than hashing
 	 * to queues on src and dst IPs and ports
@@ -793,10 +796,12 @@ static int fm10k_set_rss_hash_opt(struct fm10k_intfc *interface,
 			return -EINVAL;
 		switch (nfc->data & (RXH_L4_B_0_1 | RXH_L4_B_2_3)) {
 		case 0:
-			flags &= ~FM10K_FLAG_RSS_FIELD_IPV4_UDP;
+			clear_bit(FM10K_FLAG_RSS_FIELD_IPV4_UDP,
+				  interface->flags);
 			break;
 		case (RXH_L4_B_0_1 | RXH_L4_B_2_3):
-			flags |= FM10K_FLAG_RSS_FIELD_IPV4_UDP;
+			set_bit(FM10K_FLAG_RSS_FIELD_IPV4_UDP,
+				interface->flags);
 			break;
 		default:
 			return -EINVAL;
@@ -808,10 +813,12 @@ static int fm10k_set_rss_hash_opt(struct fm10k_intfc *interface,
 			return -EINVAL;
 		switch (nfc->data & (RXH_L4_B_0_1 | RXH_L4_B_2_3)) {
 		case 0:
-			flags &= ~FM10K_FLAG_RSS_FIELD_IPV6_UDP;
+			clear_bit(FM10K_FLAG_RSS_FIELD_IPV6_UDP,
+				  interface->flags);
 			break;
 		case (RXH_L4_B_0_1 | RXH_L4_B_2_3):
-			flags |= FM10K_FLAG_RSS_FIELD_IPV6_UDP;
+			set_bit(FM10K_FLAG_RSS_FIELD_IPV6_UDP,
+				interface->flags);
 			break;
 		default:
 			return -EINVAL;
@@ -835,28 +842,41 @@ static int fm10k_set_rss_hash_opt(struct fm10k_intfc *interface,
 		return -EINVAL;
 	}
 
-	/* if we changed something we need to update flags */
-	if (flags != interface->flags) {
+	/* If something changed we need to update the MRQC register. Note that
+	 * test_bit() is guaranteed to return strictly 0 or 1, so testing for
+	 * equality is safe.
+	 */
+	if ((rss_ipv4_udp != test_bit(FM10K_FLAG_RSS_FIELD_IPV4_UDP,
+				      interface->flags)) ||
+	    (rss_ipv6_udp != test_bit(FM10K_FLAG_RSS_FIELD_IPV6_UDP,
+				      interface->flags))) {
 		struct fm10k_hw *hw = &interface->hw;
+		bool warn = false;
 		u32 mrqc;
 
-		if ((flags & UDP_RSS_FLAGS) &&
-		    !(interface->flags & UDP_RSS_FLAGS))
-			netif_warn(interface, drv, interface->netdev,
-				   "enabling UDP RSS: fragmented packets may arrive out of order to the stack above\n");
-
-		interface->flags = flags;
-
 		/* Perform hash on these packet types */
 		mrqc = FM10K_MRQC_IPV4 |
 		       FM10K_MRQC_TCP_IPV4 |
 		       FM10K_MRQC_IPV6 |
 		       FM10K_MRQC_TCP_IPV6;
 
-		if (flags & FM10K_FLAG_RSS_FIELD_IPV4_UDP)
+		if (test_bit(FM10K_FLAG_RSS_FIELD_IPV4_UDP,
+			     interface->flags)) {
 			mrqc |= FM10K_MRQC_UDP_IPV4;
-		if (flags & FM10K_FLAG_RSS_FIELD_IPV6_UDP)
+			warn = true;
+		}
+		if (test_bit(FM10K_FLAG_RSS_FIELD_IPV6_UDP,
+			     interface->flags)) {
 			mrqc |= FM10K_MRQC_UDP_IPV6;
+			warn = true;
+		}
+
+		/* If we enable UDP RSS display a warning that this may cause
+		 * fragmented UDP packets to arrive out of order.
+		 */
+		if (warn)
+			netif_warn(interface, drv, interface->netdev,
+				   "enabling UDP RSS: fragmented packets may arrive out of order to the stack above\n");
 
 		fm10k_write_reg(hw, FM10K_MRQC(0), mrqc);
 	}
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 5bb233a9614c..f9612a6b8524 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -1,5 +1,5 @@
 /* Intel(R) Ethernet Switch Host Interface Driver
- * Copyright(c) 2013 - 2016 Intel Corporation.
+ * Copyright(c) 2013 - 2017 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -34,7 +34,7 @@ const char fm10k_driver_version[] = DRV_VERSION;
 char fm10k_driver_name[] = "fm10k";
 static const char fm10k_driver_string[] = DRV_SUMMARY;
 static const char fm10k_copyright[] =
-	"Copyright (c) 2013 - 2016 Intel Corporation.";
+	"Copyright(c) 2013 - 2017 Intel Corporation.";
 
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
 MODULE_DESCRIPTION(DRV_SUMMARY);
@@ -1193,7 +1193,7 @@ void fm10k_tx_timeout_reset(struct fm10k_intfc *interface)
 	/* Do the reset outside of interrupt context */
 	if (!test_bit(__FM10K_DOWN, &interface->state)) {
 		interface->tx_timeout_count++;
-		interface->flags |= FM10K_FLAG_RESET_REQUESTED;
+		set_bit(FM10K_FLAG_RESET_REQUESTED, interface->flags);
 		fm10k_service_event_schedule(interface);
 	}
 }
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index 01db688cf539..0d220f1ab5d0 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -1,5 +1,5 @@
 /* Intel(R) Ethernet Switch Host Interface Driver
- * Copyright(c) 2013 - 2016 Intel Corporation.
+ * Copyright(c) 2013 - 2017 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -1207,7 +1207,7 @@ int fm10k_setup_tc(struct net_device *dev, u8 tc)
 		goto err_open;
 
 	/* flag to indicate SWPRI has yet to be updated */
-	interface->flags |= FM10K_FLAG_SWPRI_CONFIG;
+	set_bit(FM10K_FLAG_SWPRI_CONFIG, interface->flags);
 
 	return 0;
 err_open:
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index e372a5823480..8fe4f861e195 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -1,5 +1,5 @@
 /* Intel(R) Ethernet Switch Host Interface Driver
- * Copyright(c) 2013 - 2016 Intel Corporation.
+ * Copyright(c) 2013 - 2017 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -136,7 +136,7 @@ static void fm10k_detach_subtask(struct fm10k_intfc *interface)
 	if (~value) {
 		interface->hw.hw_addr = interface->uc_addr;
 		netif_device_attach(netdev);
-		interface->flags |= FM10K_FLAG_RESET_REQUESTED;
+		set_bit(FM10K_FLAG_RESET_REQUESTED, interface->flags);
 		netdev_warn(netdev, "PCIe link restored, device now attached\n");
 		return;
 	}
@@ -272,11 +272,10 @@ static void fm10k_reinit(struct fm10k_intfc *interface)
 
 static void fm10k_reset_subtask(struct fm10k_intfc *interface)
 {
-	if (!(interface->flags & FM10K_FLAG_RESET_REQUESTED))
+	if (!test_and_clear_bit(FM10K_FLAG_RESET_REQUESTED,
+				interface->flags))
 		return;
 
-	interface->flags &= ~FM10K_FLAG_RESET_REQUESTED;
-
 	netdev_err(interface->netdev, "Reset interface\n");
 
 	fm10k_reinit(interface);
@@ -295,7 +294,7 @@ static void fm10k_configure_swpri_map(struct fm10k_intfc *interface)
 	int i;
 
 	/* clear flag indicating update is needed */
-	interface->flags &= ~FM10K_FLAG_SWPRI_CONFIG;
+	clear_bit(FM10K_FLAG_SWPRI_CONFIG, interface->flags);
 
 	/* these registers are only available on the PF */
 	if (hw->mac.type != fm10k_mac_pf)
@@ -323,7 +322,7 @@ static void fm10k_watchdog_update_host_state(struct fm10k_intfc *interface)
 		clear_bit(__FM10K_LINK_DOWN, &interface->state);
 	}
 
-	if (interface->flags & FM10K_FLAG_SWPRI_CONFIG) {
+	if (test_bit(FM10K_FLAG_SWPRI_CONFIG, interface->flags)) {
 		if (rtnl_trylock()) {
 			fm10k_configure_swpri_map(interface);
 			rtnl_unlock();
@@ -335,7 +334,7 @@ static void fm10k_watchdog_update_host_state(struct fm10k_intfc *interface)
 
 	err = hw->mac.ops.get_host_state(hw, &interface->host_ready);
 	if (err && time_is_before_jiffies(interface->last_reset))
-		interface->flags |= FM10K_FLAG_RESET_REQUESTED;
+		set_bit(FM10K_FLAG_RESET_REQUESTED, interface->flags);
 
 	/* free the lock */
 	fm10k_mbx_unlock(interface);
@@ -522,7 +521,7 @@ static void fm10k_watchdog_flush_tx(struct fm10k_intfc *interface)
 	 * controller to flush Tx.
 	 */
 	if (some_tx_pending)
-		interface->flags |= FM10K_FLAG_RESET_REQUESTED;
+		set_bit(FM10K_FLAG_RESET_REQUESTED, interface->flags);
 }
 
 /**
@@ -863,9 +862,9 @@ static void fm10k_configure_dglort(struct fm10k_intfc *interface)
 	       FM10K_MRQC_IPV6 |
 	       FM10K_MRQC_TCP_IPV6;
 
-	if (interface->flags & FM10K_FLAG_RSS_FIELD_IPV4_UDP)
+	if (test_bit(FM10K_FLAG_RSS_FIELD_IPV4_UDP, interface->flags))
 		mrqc |= FM10K_MRQC_UDP_IPV4;
-	if (interface->flags & FM10K_FLAG_RSS_FIELD_IPV6_UDP)
+	if (test_bit(FM10K_FLAG_RSS_FIELD_IPV6_UDP, interface->flags))
 		mrqc |= FM10K_MRQC_UDP_IPV6;
 
 	fm10k_write_reg(hw, FM10K_MRQC(0), mrqc);
@@ -1167,7 +1166,7 @@ static irqreturn_t fm10k_msix_mbx_pf(int __always_unused irq, void *data)
 	}
 
 	if (err == FM10K_ERR_RESET_REQUESTED)
-		interface->flags |= FM10K_FLAG_RESET_REQUESTED;
+		set_bit(FM10K_FLAG_RESET_REQUESTED, interface->flags);
 
 	/* if switch toggled state we should reset GLORTs */
 	if (eicr & FM10K_EICR_SWITCHNOTREADY) {
@@ -1246,12 +1245,12 @@ static s32 fm10k_mbx_mac_addr(struct fm10k_hw *hw, u32 **results,
 	/* MAC was changed so we need reset */
 	if (is_valid_ether_addr(hw->mac.perm_addr) &&
 	    !ether_addr_equal(hw->mac.perm_addr, hw->mac.addr))
-		interface->flags |= FM10K_FLAG_RESET_REQUESTED;
+		set_bit(FM10K_FLAG_RESET_REQUESTED, interface->flags);
 
 	/* VLAN override was changed, or default VLAN changed */
 	if ((vlan_override != hw->mac.vlan_override) ||
 	    (default_vid != hw->mac.default_vid))
-		interface->flags |= FM10K_FLAG_RESET_REQUESTED;
+		set_bit(FM10K_FLAG_RESET_REQUESTED, interface->flags);
 
 	return 0;
 }
@@ -1356,7 +1355,7 @@ static s32 fm10k_lport_map(struct fm10k_hw *hw, u32 **results,
 
 	/* we need to reset if port count was just updated */
 	if (dglort_map != hw->mac.dglort_map)
-		interface->flags |= FM10K_FLAG_RESET_REQUESTED;
+		set_bit(FM10K_FLAG_RESET_REQUESTED, interface->flags);
 
 	return 0;
 }
@@ -1395,7 +1394,7 @@ static s32 fm10k_update_pvid(struct fm10k_hw *hw, u32 **results,
 
 	/* we need to reset if default VLAN was just updated */
 	if (pvid != hw->mac.default_vid)
-		interface->flags |= FM10K_FLAG_RESET_REQUESTED;
+		set_bit(FM10K_FLAG_RESET_REQUESTED, interface->flags);
 
 	hw->mac.default_vid = pvid;
 
-- 
2.11.0.403.g196674b8396b

