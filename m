From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Thu, 14 Apr 2016 06:19:25 -0700
Subject: [Intel-wired-lan] [next PATCH S35 05/14] i40evf: Set netdev carrier
	properly
In-Reply-To: <1460639974-2556-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460639974-2556-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1460639974-2556-6-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

If the link status changes, a polite driver, a well-behaved driver, a
driver that does not want to DISAPPOINT its MOTHER, will notify the
network layer. Good drivers know not to cross their mommy.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-Id: I1df8ab55885b0c89e6fe08938af87bb910d19da6
---
Testing Hints : Toggle link state via cable and the
'ip' command and make sure ethtool reports correctly.

 drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
index 4c0ae43..e0ea64b 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -884,7 +884,10 @@ void i40evf_virtchnl_completion(struct i40evf_adapter *adapter,
 				adapter->link_up =
 					vpe->event_data.link_event.link_status;
 				i40evf_print_link_message(adapter);
-				netif_tx_stop_all_queues(netdev);
+				if (adapter->link_up)
+					netif_carrier_on(netdev);
+				else
+					netif_carrier_off(netdev);
 			}
 			break;
 		case I40E_VIRTCHNL_EVENT_RESET_IMPENDING:
-- 
2.4.3

