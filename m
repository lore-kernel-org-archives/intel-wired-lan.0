From: Alexander Duyck <aduyck@mirantis.com>
Date: Wed, 06 Jan 2016 23:11:43 -0800
Subject: [Intel-wired-lan] [next PATCH 11/11] igb: Add workaround for VLAN
 tag stripping on 82576
In-Reply-To: <20160107070850.13648.21033.stgit@localhost.localdomain>
References: <20160107070850.13648.21033.stgit@localhost.localdomain>
Message-ID: <20160107071143.13648.51160.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

There was a workaround partially implemented for the 82576 that is needed
in order for VLAN tag stripping to function correctly.  The original code
had side effects that would make it so the workaround was active on all
MACs.  I have updated the code so that the workaround is enabled, but
limited to the 82576, or activated if we exceed the available unicast
addresses.

The workaround has a side effect of mirroring all of the traffic outgoing
from the VFs back to the PF.  As such it is not recommended to use the
82576 in promiscuous mode as it will take a performance hit, though this is
now consistent with the performance as seen on the out-of-tree igb driver.

I also limited the scope of the UTA bits all being set to only when the
VMOLR register is enabled.  This should limit the effects of the UTA
register so that we don't pick up any excess traffic unless promiscuous mode
has been enabled on the PF, whereas before the PF would have ended up in
something equivalent to unicast promiscuous mode with VLAN filtering
otherwise.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/igb/e1000_82575.c |    2 ++
 drivers/net/ethernet/intel/igb/igb_main.c    |   26 ++++++++++++++------------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.c b/drivers/net/ethernet/intel/igb/e1000_82575.c
index fff50523b440..9a1a9c7b0748 100644
--- a/drivers/net/ethernet/intel/igb/e1000_82575.c
+++ b/drivers/net/ethernet/intel/igb/e1000_82575.c
@@ -425,6 +425,8 @@ static s32 igb_init_mac_params_82575(struct e1000_hw *hw)
 
 	/* Set mta register count */
 	mac->mta_reg_count = 128;
+	/* Set uta register count */
+	mac->uta_reg_count = (hw->mac.type == e1000_82575) ? 0 : 128;
 	/* Set rar entry count */
 	switch (mac->type) {
 	case e1000_82576:
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 06b8b1e0362b..ade8dee55fb8 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -141,7 +141,7 @@ static struct rtnl_link_stats64 *igb_get_stats64(struct net_device *dev,
 					  struct rtnl_link_stats64 *stats);
 static int igb_change_mtu(struct net_device *, int);
 static int igb_set_mac(struct net_device *, void *);
-static void igb_set_uta(struct igb_adapter *adapter);
+static void igb_set_uta(struct igb_adapter *adapter, bool set);
 static irqreturn_t igb_intr(int irq, void *);
 static irqreturn_t igb_intr_msi(int irq, void *);
 static irqreturn_t igb_msix_other(int irq, void *);
@@ -3790,9 +3790,6 @@ static void igb_configure_rx(struct igb_adapter *adapter)
 {
 	int i;
 
-	/* set UTA to appropriate mode */
-	igb_set_uta(adapter);
-
 	/* set the correct pool for the PF default MAC address in entry 0 */
 	igb_rar_set_qsel(adapter, adapter->hw.mac.addr, 0,
 			 adapter->vfs_allocated_count);
@@ -4258,7 +4255,11 @@ static void igb_set_rx_mode(struct net_device *netdev)
 	/* Check for Promiscuous and All Multicast modes */
 	if (netdev->flags & IFF_PROMISC) {
 		rctl |= E1000_RCTL_UPE | E1000_RCTL_MPE;
-		vmolr |= E1000_VMOLR_ROPE | E1000_VMOLR_MPME;
+		vmolr |= E1000_VMOLR_MPME;
+
+		/* enable use of UTA filter to force packets to default pool */
+		if (hw->mac.type == e1000_82576)
+			vmolr |= E1000_VMOLR_ROPE;
 	} else {
 		if (netdev->flags & IFF_ALLMULTI) {
 			rctl |= E1000_RCTL_MPE;
@@ -4314,6 +4315,9 @@ static void igb_set_rx_mode(struct net_device *netdev)
 	if ((hw->mac.type < e1000_82576) || (hw->mac.type > e1000_i350))
 		return;
 
+	/* set UTA to appropriate mode */
+	igb_set_uta(adapter, !!(vmolr & E1000_VMOLR_ROPE));
+
 	vmolr |= rd32(E1000_VMOLR(vfn)) &
 		 ~(E1000_VMOLR_ROPE | E1000_VMOLR_MPME | E1000_VMOLR_ROMPE);
 
@@ -6451,6 +6455,7 @@ static void igb_msg_task(struct igb_adapter *adapter)
 /**
  *  igb_set_uta - Set unicast filter table address
  *  @adapter: board private structure
+ *  @set: boolean indicating if we are setting or clearing bits
  *
  *  The unicast table address is a register array of 32-bit registers.
  *  The table is meant to be used in a way similar to how the MTA is used
@@ -6458,21 +6463,18 @@ static void igb_msg_task(struct igb_adapter *adapter)
  *  set all the hash bits to 1 and use the VMOLR ROPE bit as a promiscuous
  *  enable bit to allow vlan tag stripping when promiscuous mode is enabled
  **/
-static void igb_set_uta(struct igb_adapter *adapter)
+static void igb_set_uta(struct igb_adapter *adapter, bool set)
 {
 	struct e1000_hw *hw = &adapter->hw;
+	u32 uta = set ? ~0 : 0;
 	int i;
 
-	/* The UTA table only exists on 82576 hardware and newer */
-	if (hw->mac.type < e1000_82576)
-		return;
-
 	/* we only need to do this if VMDq is enabled */
 	if (!adapter->vfs_allocated_count)
 		return;
 
-	for (i = 0; i < hw->mac.uta_reg_count; i++)
-		array_wr32(E1000_UTA, i, ~0);
+	for (i = hw->mac.uta_reg_count; i--;)
+		array_wr32(E1000_UTA, i, uta);
 }
 
 /**

