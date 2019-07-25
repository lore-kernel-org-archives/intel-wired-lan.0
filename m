From: Alice Michael <alice.michael@intel.com>
Date: Thu, 25 Jul 2019 05:47:43 -0400
Subject: [Intel-wired-lan] [next PATCH] iavf: allow permanent MAC address to
 change
Message-ID: <20190725094743.20861-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Allow the VF to override the "permanent" MAC address set by the host.
This allows bonding to work in the case where the administrator has set
the VF MAC.

Note that the VF must still be set to Trusted on the host if this change
is to be accepted by the PF driver.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h      | 1 -
 drivers/net/ethernet/intel/iavf/iavf_main.c | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 9fc635d816d2..29de3ae96ef2 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -253,7 +253,6 @@ struct iavf_adapter {
 #define IAVF_FLAG_RESET_PENDING		BIT(4)
 #define IAVF_FLAG_RESET_NEEDED		BIT(5)
 #define IAVF_FLAG_WB_ON_ITR_CAPABLE		BIT(6)
-#define IAVF_FLAG_ADDR_SET_BY_PF		BIT(8)
 #define IAVF_FLAG_SERVICE_CLIENT_REQUESTED	BIT(9)
 #define IAVF_FLAG_CLIENT_NEEDS_OPEN		BIT(10)
 #define IAVF_FLAG_CLIENT_NEEDS_CLOSE		BIT(11)
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 554aa619ff02..07f5541a0f01 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -790,9 +790,6 @@ static int iavf_set_mac(struct net_device *netdev, void *p)
 	if (ether_addr_equal(netdev->dev_addr, addr->sa_data))
 		return 0;
 
-	if (adapter->flags & IAVF_FLAG_ADDR_SET_BY_PF)
-		return -EPERM;
-
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
 
 	f = iavf_find_filter(adapter, hw->mac.addr);
@@ -1811,7 +1808,6 @@ static int iavf_init_get_resources(struct iavf_adapter *adapter)
 		eth_hw_addr_random(netdev);
 		ether_addr_copy(adapter->hw.mac.addr, netdev->dev_addr);
 	} else {
-		adapter->flags |= IAVF_FLAG_ADDR_SET_BY_PF;
 		ether_addr_copy(netdev->dev_addr, adapter->hw.mac.addr);
 		ether_addr_copy(netdev->perm_addr, adapter->hw.mac.addr);
 	}
-- 
2.21.0

