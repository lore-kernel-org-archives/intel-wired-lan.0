From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Fri, 26 Aug 2016 00:58:42 +0200
Subject: [Intel-wired-lan] [dev-queue PATCH] i40evf: Fix link state event
	handling.
Message-ID: <1472165922-60629-1-git-send-email-sridhar.samudrala@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Currently disabling the link state from PF via
	ip link set enp5s0f0 vf 0 state disable
doesnt' disable the CARRIER on the VF.

This patch updates the carrier and starts/stops the tx queues based on the
link state notification from PF.

  PF: enp5s0f0, VF: enp5s2
  #modprobe i40e
  #echo 2 > /sys/class/net/enp5s0f0/device/sriov_numvfs
  #ip link set enp5s2 up
  #ip -d link show enp5s2
  175: enp5s2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
      link/ether ea:4d:60:bc:6f:85 brd ff:ff:ff:ff:ff:ff promiscuity 0 addrgenmode eui64
  #ip link set enp5s0f0 vf 0 state disable
  #ip -d link show enp5s0f0
  171: enp5s0f0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
      link/ether 68:05:ca:2e:72:68 brd ff:ff:ff:ff:ff:ff promiscuity 0 addrgenmode eui64 numtxqueues 72 numrxqueues 72 portid 6805ca2e7268
      vf 0 MAC 00:00:00:00:00:00, spoof checking on, link-state disable, trust off
      vf 1 MAC 00:00:00:00:00:00, spoof checking on, link-state auto, trust off
  #ip -d link show enp5s2
  175: enp5s2: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN mode DEFAULT group default qlen 1000
       link/ether ea:4d:60:bc:6f:85 brd ff:ff:ff:ff:ff:ff promiscuity 0 addrgenmode eui64 numtxqueues 16 numrxqueues 16

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
index cc6cb30..ddf478d 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -898,8 +898,14 @@ void i40evf_virtchnl_completion(struct i40evf_adapter *adapter,
 			    vpe->event_data.link_event.link_status) {
 				adapter->link_up =
 					vpe->event_data.link_event.link_status;
+				if (adapter->link_up) {
+					netif_tx_start_all_queues(netdev);
+					netif_carrier_on(netdev);
+				} else {
+					netif_tx_stop_all_queues(netdev);
+					netif_carrier_off(netdev);
+				}
 				i40evf_print_link_message(adapter);
-				netif_tx_stop_all_queues(netdev);
 			}
 			break;
 		case I40E_VIRTCHNL_EVENT_RESET_IMPENDING:
@@ -974,8 +980,6 @@ void i40evf_virtchnl_completion(struct i40evf_adapter *adapter,
 	case I40E_VIRTCHNL_OP_ENABLE_QUEUES:
 		/* enable transmits */
 		i40evf_irq_enable(adapter, true);
-		netif_tx_start_all_queues(adapter->netdev);
-		netif_carrier_on(adapter->netdev);
 		break;
 	case I40E_VIRTCHNL_OP_DISABLE_QUEUES:
 		i40evf_free_all_tx_resources(adapter);
-- 
2.5.5

