From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 27 Apr 2015 14:57:17 -0400
Subject: [Intel-wired-lan] [net-next S5 10/15] i40evf: add MAC address
	filter in open, not init
In-Reply-To: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
References: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1430161042-28494-11-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

During close, all of the MAC filters are cleared, so the driver would be
unable to receive unicast packets after being closed and reopened.

Add the adapter's "hardware" MAC address filter in open, not init. This
ensures that the correct filter is present each time.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I51a11e9c1200139dab6f66a5353bd38c7d26f875
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index a519c05..0f6ea56f 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1835,6 +1835,7 @@ static int i40evf_open(struct net_device *netdev)
 	if (err)
 		goto err_req_irq;
 
+	i40evf_add_filter(adapter, adapter->hw.mac.addr);
 	i40evf_configure(adapter);
 
 	err = i40evf_up_complete(adapter);
@@ -2015,7 +2016,6 @@ static void i40evf_init_task(struct work_struct *work)
 						      struct i40evf_adapter,
 						      init_task.work);
 	struct net_device *netdev = adapter->netdev;
-	struct i40evf_mac_filter *f;
 	struct i40e_hw *hw = &adapter->hw;
 	struct pci_dev *pdev = adapter->pdev;
 	int i, err, bufsz;
@@ -2149,16 +2149,6 @@ static void i40evf_init_task(struct work_struct *work)
 	ether_addr_copy(netdev->dev_addr, adapter->hw.mac.addr);
 	ether_addr_copy(netdev->perm_addr, adapter->hw.mac.addr);
 
-	f = kzalloc(sizeof(*f), GFP_ATOMIC);
-	if (!f)
-		goto err_sw_init;
-
-	ether_addr_copy(f->macaddr, adapter->hw.mac.addr);
-	f->add = true;
-	adapter->aq_required |= I40EVF_FLAG_AQ_ADD_MAC_FILTER;
-
-	list_add(&f->list, &adapter->mac_filter_list);
-
 	init_timer(&adapter->watchdog_timer);
 	adapter->watchdog_timer.function = &i40evf_watchdog_timer;
 	adapter->watchdog_timer.data = (unsigned long)adapter;
-- 
1.9.3

