From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 13 Apr 2016 14:31:21 -0700
Subject: [Intel-wired-lan] [PATCH v1 10/13] igbvf: use BIT() macro instead
	of shifts
In-Reply-To: <1460583084-16900-1-git-send-email-jacob.e.keller@intel.com>
References: <1460583084-16900-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1460583084-16900-11-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

To prevent signed bitshift issues, and improve code readability, use the
BIT() macro.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/igbvf/defines.h |  2 +-
 drivers/net/ethernet/intel/igbvf/ethtool.c |  2 +-
 drivers/net/ethernet/intel/igbvf/igbvf.h   |  4 ++--
 drivers/net/ethernet/intel/igbvf/netdev.c  | 10 +++++-----
 drivers/net/ethernet/intel/igbvf/vf.c      |  2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/igbvf/defines.h b/drivers/net/ethernet/intel/igbvf/defines.h
index ae3f28332fa0..ee1ef08d7fc4 100644
--- a/drivers/net/ethernet/intel/igbvf/defines.h
+++ b/drivers/net/ethernet/intel/igbvf/defines.h
@@ -113,7 +113,7 @@
 #define E1000_RXDCTL_QUEUE_ENABLE	0x02000000 /* Enable specific Rx Que */
 
 /* Direct Cache Access (DCA) definitions */
-#define E1000_DCA_TXCTRL_TX_WB_RO_EN	(1 << 11) /* Tx Desc writeback RO bit */
+#define E1000_DCA_TXCTRL_TX_WB_RO_EN	BIT(11) /* Tx Desc writeback RO bit */
 
 #define E1000_VF_INIT_TIMEOUT	200 /* Number of retries to clear RSTI */
 
diff --git a/drivers/net/ethernet/intel/igbvf/ethtool.c b/drivers/net/ethernet/intel/igbvf/ethtool.c
index b74ce53d7b52..77bdb5386e78 100644
--- a/drivers/net/ethernet/intel/igbvf/ethtool.c
+++ b/drivers/net/ethernet/intel/igbvf/ethtool.c
@@ -154,7 +154,7 @@ static void igbvf_get_regs(struct net_device *netdev,
 
 	memset(p, 0, IGBVF_REGS_LEN * sizeof(u32));
 
-	regs->version = (1 << 24) | (adapter->pdev->revision << 16) |
+	regs->version = BIT(24) | (adapter->pdev->revision << 16) |
 			adapter->pdev->device;
 
 	regs_buff[0] = er32(CTRL);
diff --git a/drivers/net/ethernet/intel/igbvf/igbvf.h b/drivers/net/ethernet/intel/igbvf/igbvf.h
index f166baab8d7e..6f4290d6dc9f 100644
--- a/drivers/net/ethernet/intel/igbvf/igbvf.h
+++ b/drivers/net/ethernet/intel/igbvf/igbvf.h
@@ -287,8 +287,8 @@ struct igbvf_info {
 };
 
 /* hardware capability, feature, and workaround flags */
-#define IGBVF_FLAG_RX_CSUM_DISABLED	(1 << 0)
-#define IGBVF_FLAG_RX_LB_VLAN_BSWAP	(1 << 1)
+#define IGBVF_FLAG_RX_CSUM_DISABLED	BIT(0)
+#define IGBVF_FLAG_RX_LB_VLAN_BSWAP	BIT(1)
 #define IGBVF_RX_DESC_ADV(R, i)     \
 	(&((((R).desc))[i].rx_desc))
 #define IGBVF_TX_DESC_ADV(R, i)     \
diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index 78af4c7716d3..c60717c8dc37 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -964,7 +964,7 @@ static void igbvf_assign_vector(struct igbvf_adapter *adapter, int rx_queue,
 			ivar = ivar & 0xFFFFFF00;
 			ivar |= msix_vector | E1000_IVAR_VALID;
 		}
-		adapter->rx_ring[rx_queue].eims_value = 1 << msix_vector;
+		adapter->rx_ring[rx_queue].eims_value = BIT(msix_vector);
 		array_ew32(IVAR0, index, ivar);
 	}
 	if (tx_queue > IGBVF_NO_QUEUE) {
@@ -979,7 +979,7 @@ static void igbvf_assign_vector(struct igbvf_adapter *adapter, int rx_queue,
 			ivar = ivar & 0xFFFF00FF;
 			ivar |= (msix_vector | E1000_IVAR_VALID) << 8;
 		}
-		adapter->tx_ring[tx_queue].eims_value = 1 << msix_vector;
+		adapter->tx_ring[tx_queue].eims_value = BIT(msix_vector);
 		array_ew32(IVAR0, index, ivar);
 	}
 }
@@ -1014,8 +1014,8 @@ static void igbvf_configure_msix(struct igbvf_adapter *adapter)
 
 	ew32(IVAR_MISC, tmp);
 
-	adapter->eims_enable_mask = (1 << (vector)) - 1;
-	adapter->eims_other = 1 << (vector - 1);
+	adapter->eims_enable_mask = BIT(vector) - 1;
+	adapter->eims_other = BIT(vector - 1);
 	e1e_flush();
 }
 
@@ -2089,7 +2089,7 @@ static int igbvf_maybe_stop_tx(struct net_device *netdev, int size)
 }
 
 #define IGBVF_MAX_TXD_PWR	16
-#define IGBVF_MAX_DATA_PER_TXD	(1 << IGBVF_MAX_TXD_PWR)
+#define IGBVF_MAX_DATA_PER_TXD	BIT(IGBVF_MAX_TXD_PWR)
 
 static inline int igbvf_tx_map_adv(struct igbvf_adapter *adapter,
 				   struct igbvf_ring *tx_ring,
diff --git a/drivers/net/ethernet/intel/igbvf/vf.c b/drivers/net/ethernet/intel/igbvf/vf.c
index a13baa90ae20..335ba6642145 100644
--- a/drivers/net/ethernet/intel/igbvf/vf.c
+++ b/drivers/net/ethernet/intel/igbvf/vf.c
@@ -266,7 +266,7 @@ static s32 e1000_set_vfta_vf(struct e1000_hw *hw, u16 vid, bool set)
 	msgbuf[1] = vid;
 	/* Setting the 8 bit field MSG INFO to true indicates "add" */
 	if (set)
-		msgbuf[0] |= 1 << E1000_VT_MSGINFO_SHIFT;
+		msgbuf[0] |= BIT(E1000_VT_MSGINFO_SHIFT);
 
 	mbx->ops.write_posted(hw, msgbuf, 2);
 
-- 
2.8.1.102.ga49ec4a

