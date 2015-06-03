From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  3 Jun 2015 16:30:58 -0700
Subject: [Intel-wired-lan] [rc2 01/15] fm10k: ignore invalid multicast
	address entries
In-Reply-To: <1433374272-6684-1-git-send-email-jacob.e.keller@intel.com>
References: <1433374272-6684-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1433374272-6684-2-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This change fixes an issue with adding an invalid multicast address
using the iproute2 tool (ip maddr add <MADDR> dev <dev>). The iproute2
tool and the kernel do not validate or filter the multicast addresses
when adding them to the multicast list. Thus, when synchronizing this
list with an invalid entry, the action will be aborted with an error
since the fm10k driver currently validates the list. Consequently,
multicast entries beyond the invalid one will not be processed and
communicated with the switch via the mailbox. This change makes it so
that invalid addresses will simply be skipped and allows synchronizing
the full list to proceed.

Signed-off-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index 2f4f41b7eae7..4c6b51111566 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -923,18 +923,12 @@ static int __fm10k_mc_sync(struct net_device *dev,
 	struct fm10k_intfc *interface = netdev_priv(dev);
 	struct fm10k_hw *hw = &interface->hw;
 	u16 vid, glort = interface->glort;
-	s32 err;
-
-	if (!is_multicast_ether_addr(addr))
-		return -EADDRNOTAVAIL;
 
 	/* update table with current entries */
 	for (vid = hw->mac.default_vid ? fm10k_find_next_vlan(interface, 0) : 0;
 	     vid < VLAN_N_VID;
 	     vid = fm10k_find_next_vlan(interface, vid)) {
-		err = hw->mac.ops.update_mc_addr(hw, glort, addr, vid, sync);
-		if (err)
-			return err;
+		hw->mac.ops.update_mc_addr(hw, glort, addr, vid, sync);
 	}
 
 	return 0;
-- 
2.1.0

