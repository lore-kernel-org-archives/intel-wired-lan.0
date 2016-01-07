From: Alexander Duyck <aduyck@mirantis.com>
Date: Wed, 06 Jan 2016 22:48:50 -0800
Subject: [Intel-wired-lan] [next PATCH 2/2] ixgbe: Avoid adding VLAN 0 twice
	to VLVF and VFTA
In-Reply-To: <20160107064516.12239.98349.stgit@localhost.localdomain>
References: <20160107064516.12239.98349.stgit@localhost.localdomain>
Message-ID: <20160107064850.12239.83914.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We were adding VLAN 0 twice each time we restored the VLAN configuration.
Instead of doing it twice we can just start working through the active
VLANs from ID 1 on and skip the double write.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 1f2b039e71bd..77cdaed6de90 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -4169,11 +4169,11 @@ static void ixgbe_vlan_promisc_disable(struct ixgbe_adapter *adapter)
 
 static void ixgbe_restore_vlan(struct ixgbe_adapter *adapter)
 {
-	u16 vid;
+	u16 vid = 1;
 
 	ixgbe_vlan_rx_add_vid(adapter->netdev, htons(ETH_P_8021Q), 0);
 
-	for_each_set_bit(vid, adapter->active_vlans, VLAN_N_VID)
+	for_each_set_bit_from(vid, adapter->active_vlans, VLAN_N_VID)
 		ixgbe_vlan_rx_add_vid(adapter->netdev, htons(ETH_P_8021Q), vid);
 }
 

