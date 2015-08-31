From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 31 Aug 2015 19:54:44 -0400
Subject: [Intel-wired-lan] [next PATCH S14 04/15] i40evf: properly handle
	ndo_set_mac_address calls
In-Reply-To: <1441065295-234333-1-git-send-email-catherine.sullivan@intel.com>
References: <1441065295-234333-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1441065295-234333-5-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

The driver was not correctly handling calls to its ndo_set_mac_address
method. It did not properly check to see if the override would be
allowed by the PF driver, and never removed the old address from its
filter list.

Add a new flag to the adapter struct which is set if the MAC address is
assigned by the PF. Check this flag and don't allow the MAC address to
be changed if it is set. Search for and properly remove the filter
for the old MAC address when the new one is set.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I817bf620c869c5a80e6a7eab65c9cbad1dc89799
---
 drivers/net/ethernet/intel/i40evf/i40evf.h      |  1 +
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 18 +++++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf.h b/drivers/net/ethernet/intel/i40evf/i40evf.h
index e7a223e..132f03a 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf.h
+++ b/drivers/net/ethernet/intel/i40evf/i40evf.h
@@ -220,6 +220,7 @@ struct i40evf_adapter {
 #define I40EVF_FLAG_RESET_NEEDED                 BIT(10)
 #define I40EVF_FLAG_WB_ON_ITR_CAPABLE		BIT(11)
 #define I40EVF_FLAG_OUTER_UDP_CSUM_CAPABLE	BIT(12)
+#define I40EVF_FLAG_ADDR_SET_BY_PF               BIT(13)
 /* duplicates for common code */
 #define I40E_FLAG_FDIR_ATR_ENABLED		 0
 #define I40E_FLAG_DCB_ENABLED			 0
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index c00e495..7ea7d2e 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -841,6 +841,15 @@ static int i40evf_set_mac(struct net_device *netdev, void *p)
 	if (ether_addr_equal(netdev->dev_addr, addr->sa_data))
 		return 0;
 
+	if (adapter->flags & I40EVF_FLAG_ADDR_SET_BY_PF)
+		return -EPERM;
+
+	f = i40evf_find_filter(adapter, hw->mac.addr);
+	if (f) {
+		f->remove = true;
+		adapter->aq_required |= I40EVF_FLAG_AQ_DEL_MAC_FILTER;
+	}
+
 	f = i40evf_add_filter(adapter, addr->sa_data);
 	if (f) {
 		ether_addr_copy(hw->mac.addr, addr->sa_data);
@@ -2244,10 +2253,13 @@ static void i40evf_init_task(struct work_struct *work)
 	if (!is_valid_ether_addr(adapter->hw.mac.addr)) {
 		dev_info(&pdev->dev, "Invalid MAC address %pM, using random\n",
 			 adapter->hw.mac.addr);
-		random_ether_addr(adapter->hw.mac.addr);
+		eth_hw_addr_random(netdev);
+		ether_addr_copy(adapter->hw.mac.addr, netdev->dev_addr);
+	} else {
+		adapter->flags |= I40EVF_FLAG_ADDR_SET_BY_PF;
+		ether_addr_copy(netdev->dev_addr, adapter->hw.mac.addr);
+		ether_addr_copy(netdev->perm_addr, adapter->hw.mac.addr);
 	}
-	ether_addr_copy(netdev->dev_addr, adapter->hw.mac.addr);
-	ether_addr_copy(netdev->perm_addr, adapter->hw.mac.addr);
 
 	init_timer(&adapter->watchdog_timer);
 	adapter->watchdog_timer.function = &i40evf_watchdog_timer;
-- 
1.9.3

