From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  4 Jun 2021 09:53:26 -0700
Subject: [Intel-wired-lan] [PATCH net-next 06/15] iavf: disable interrupts
 before disabling napi
In-Reply-To: <20210604165335.33329-1-anthony.l.nguyen@intel.com>
References: <20210604165335.33329-1-anthony.l.nguyen@intel.com>
Message-ID: <20210604165335.33329-6-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Nicholas Nunley <nicholas.d.nunley@intel.com>

Interrupts should be turned off first before disabling napi, not the other
way around, since the interrupt handler can schedule napi.

Signed-off-by: Nicholas Nunley <nicholas.d.nunley@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index eda8ebb8e7b8..1904000943dc 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -970,8 +970,8 @@ void iavf_down(struct iavf_adapter *adapter)
 	netif_carrier_off(netdev);
 	netif_tx_disable(netdev);
 	adapter->link_up = false;
-	iavf_napi_disable_all(adapter);
 	iavf_irq_disable(adapter);
+	iavf_napi_disable_all(adapter);
 
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
 
@@ -2040,8 +2040,8 @@ static void iavf_disable_vf(struct iavf_adapter *adapter)
 		netif_carrier_off(adapter->netdev);
 		netif_tx_disable(adapter->netdev);
 		adapter->link_up = false;
-		iavf_napi_disable_all(adapter);
 		iavf_irq_disable(adapter);
+		iavf_napi_disable_all(adapter);
 		iavf_free_traffic_irqs(adapter);
 		iavf_free_all_tx_resources(adapter);
 		iavf_free_all_rx_resources(adapter);
@@ -2171,6 +2171,8 @@ static void iavf_reset_task(struct work_struct *work)
 	}
 
 continue_reset:
+	iavf_irq_disable(adapter);
+
 	/* We don't use netif_running() because it may be true prior to
 	 * ndo_open() returning, so we can't assume it means all our open
 	 * tasks have finished, since we're not holding the rtnl_lock here.
@@ -2182,7 +2184,6 @@ static void iavf_reset_task(struct work_struct *work)
 		adapter->link_up = false;
 		iavf_napi_disable_all(adapter);
 	}
-	iavf_irq_disable(adapter);
 
 	adapter->state = __IAVF_RESETTING;
 	adapter->flags &= ~IAVF_FLAG_RESET_PENDING;
-- 
2.20.1

