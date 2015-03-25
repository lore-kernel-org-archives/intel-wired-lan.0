From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 24 Mar 2015 21:04:47 -0700
Subject: [Intel-wired-lan] [next-queue S1 3/6] i40evf: resequence close
	operations
In-Reply-To: <1427256290-24231-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1427256290-24231-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1427256290-24231-3-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Call the netdev carrier off and TX disable functions first, before other
shutdown operations. This stops the stack from hitting us with
transmits while we're shutting down. Additionally, disable NAPI before
disabling interrupts, or the interrupt might get re-enabled
inappropriately. Finally, remove the call to netif_tx_stop_all_queues,
as it is redundant - the call to netif_tx_disable already did the same
thing.

Change-ID: I8b2dd25231b82817746cc256234a5eeeb4abaccc
Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index da901f4..b08efaf 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -971,8 +971,10 @@ void i40evf_down(struct i40evf_adapter *adapter)
 				&adapter->crit_section))
 		usleep_range(500, 1000);
 
-	i40evf_irq_disable(adapter);
+	netif_carrier_off(netdev);
+	netif_tx_disable(netdev);
 	i40evf_napi_disable_all(adapter);
+	i40evf_irq_disable(adapter);
 
 	/* remove all MAC filters */
 	list_for_each_entry(f, &adapter->mac_filter_list, list) {
@@ -995,13 +997,7 @@ void i40evf_down(struct i40evf_adapter *adapter)
 		adapter->aq_required |= I40EVF_FLAG_AQ_DEL_VLAN_FILTER;
 		adapter->aq_required |= I40EVF_FLAG_AQ_DISABLE_QUEUES;
 	}
-	netif_tx_disable(netdev);
 
-	netif_tx_stop_all_queues(netdev);
-
-	msleep(20);
-
-	netif_carrier_off(netdev);
 	clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
 }
 
-- 
1.9.3

