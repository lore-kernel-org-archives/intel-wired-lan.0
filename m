From: Alexander Duyck <aduyck@mirantis.com>
Date: Wed, 06 Jan 2016 23:10:54 -0800
Subject: [Intel-wired-lan] [next PATCH 05/11] igb: Always enable VLAN 0 even
 if 8021q is not loaded
In-Reply-To: <20160107070850.13648.21033.stgit@localhost.localdomain>
References: <20160107070850.13648.21033.stgit@localhost.localdomain>
Message-ID: <20160107071054.13648.88041.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch makes it so that we always add VLAN 0.  This is important as we
need to guarantee the PF can receive untagged frames in the case of SR-IOV
being enabled but VLAN filtering not being enabled in the kernel.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index fd1ddc170a72..ccc622383552 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -7313,11 +7313,12 @@ static int igb_vlan_rx_kill_vid(struct net_device *netdev,
 
 static void igb_restore_vlan(struct igb_adapter *adapter)
 {
-	u16 vid;
+	u16 vid = 1;
 
 	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
+	igb_vlan_rx_add_vid(adapter->netdev, htons(ETH_P_8021Q), 0);
 
-	for_each_set_bit(vid, adapter->active_vlans, VLAN_N_VID)
+	for_each_set_bit_from(vid, adapter->active_vlans, VLAN_N_VID)
 		igb_vlan_rx_add_vid(adapter->netdev, htons(ETH_P_8021Q), vid);
 }
 

