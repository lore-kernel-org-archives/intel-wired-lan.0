From: Stefan Assmann <sassmann@kpanic.de>
Date: Thu,  5 Sep 2019 08:34:22 +0200
Subject: [Intel-wired-lan] [PATCH] iavf: fix MAC address setting for VFs
 when filter is rejected
Message-ID: <20190905063422.28743-1-sassmann@kpanic.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Currently iavf unconditionally applies MAC address change requests. This
brings the VF in a state where it is no longer able to pass traffic if
the PF rejects a MAC filter change for the VF.
A typical scenario for a rejected MAC filter is for an untrusted VF to
request to change the MAC address when an administratively set MAC is
present.

To keep iavf working in this scenario the MAC filter handling in iavf
needs to act on the PF reply regarding the MAC filter change. In the
case of an ack the new MAC address gets set, whereas in the case of a
nack the previous MAC address needs to stay in place.

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c     | 1 -
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 7 +++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 39cc67cde89e..9e571a657fe7 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -826,7 +826,6 @@ static int iavf_set_mac(struct net_device *netdev, void *p)
 
 	if (f) {
 		ether_addr_copy(hw->mac.addr, addr->sa_data);
-		ether_addr_copy(netdev->dev_addr, adapter->hw.mac.addr);
 	}
 
 	return (f == NULL) ? -ENOMEM : 0;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index d49d58a6de80..c46770eba320 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -1252,6 +1252,8 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		case VIRTCHNL_OP_ADD_ETH_ADDR:
 			dev_err(&adapter->pdev->dev, "Failed to add MAC filter, error %s\n",
 				iavf_stat_str(&adapter->hw, v_retval));
+			/* restore administratively set MAC address */
+			ether_addr_copy(adapter->hw.mac.addr, netdev->dev_addr);
 			break;
 		case VIRTCHNL_OP_DEL_VLAN:
 			dev_err(&adapter->pdev->dev, "Failed to delete VLAN filter, error %s\n",
@@ -1319,6 +1321,11 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		}
 	}
 	switch (v_opcode) {
+	case VIRTCHNL_OP_ADD_ETH_ADDR: {
+		if (!ether_addr_equal(netdev->dev_addr, adapter->hw.mac.addr))
+			ether_addr_copy(netdev->dev_addr, adapter->hw.mac.addr);
+		}
+		break;
 	case VIRTCHNL_OP_GET_STATS: {
 		struct iavf_eth_stats *stats =
 			(struct iavf_eth_stats *)msg;
-- 
2.21.0

