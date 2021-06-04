From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  4 Jun 2021 09:53:29 -0700
Subject: [Intel-wired-lan] [PATCH net-next 09/15] iavf: Fix carrier on state
In-Reply-To: <20210604165335.33329-1-anthony.l.nguyen@intel.com>
References: <20210604165335.33329-1-anthony.l.nguyen@intel.com>
Message-ID: <20210604165335.33329-9-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Paul Greenwalt <paul.greenwalt@intel.com>

Carrier on is not set if the link up event (VIRTCHNL_EVENT_LINK_CHANGE)
occurs before the queues are enabled (VIRTCHNL_OP_ENABLE_QUEUES) since
setting carrier on during a link up event when queues are not enabled
can result in a Tx hang.

Therefore set carrier on when queues are enabled if link is up and carrier
is off.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 69e479eb5534..3c3fd604218e 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -1685,8 +1685,17 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		break;
 	case VIRTCHNL_OP_ENABLE_QUEUES:
 		/* enable transmits */
-		if (adapter->state == __IAVF_RUNNING)
+		if (adapter->state == __IAVF_RUNNING) {
 			iavf_irq_enable(adapter, true);
+
+			/* If queues not enabled when handling link event,
+			 * then set carrier on now
+			 */
+			if (adapter->link_up && !netif_carrier_ok(netdev)) {
+				netif_tx_start_all_queues(netdev);
+				netif_carrier_on(netdev);
+			}
+		}
 		adapter->flags &= ~IAVF_FLAG_QUEUES_DISABLED;
 		break;
 	case VIRTCHNL_OP_DISABLE_QUEUES:
-- 
2.20.1

