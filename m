From: =?unknown-8bit?q?J=C4=99drzej?= Jagielski <jedrzej.jagielski@intel.com>
Date: Wed,  2 Jun 2021 00:47:03 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix queue-to-TC mapping on tx
Message-ID: <20210602004703.392981-1-jedrzej.jagielski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In SD DCB mode the packets sent receive incorrect UP tags. They are
constructed correctly and put into tx_ring, but UP is later remapped by
HW on the basis of TCTUPR register contents according to tx queue
selected, and BW used is consistent with the new UP values. This is
caused by tx queue selection in kernel not taking into account DCB
configuration. This patch fixes the issue by implementing the
ndo_select_queue NDO callback for all suitable kernel versions.

Fixes: fd0a05ce74ef ("i40e: transmit, receive, and NAPI")
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

---
 drivers/net/ethernet/intel/i40e/i40e_main.c |  1 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 50 +++++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_txrx.h |  2 +
 3 files changed, 53 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 9a52414a9..d0c880e65 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13344,6 +13344,7 @@ static const struct net_device_ops i40e_netdev_ops = {
 	.ndo_poll_controller	= i40e_netpoll,
 #endif
 	.ndo_setup_tc		= __i40e_setup_tc,
+	.ndo_select_queue	= i40e_lan_select_queue,
 	.ndo_set_features	= i40e_set_features,
 	.ndo_set_vf_mac		= i40e_ndo_set_vf_mac,
 	.ndo_set_vf_vlan	= i40e_ndo_set_vf_port_vlan,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index b883ab809..c7b7b1cc9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -3633,6 +3633,56 @@ dma_error:
 	return -1;
 }
 
+static u16 i40e_swdcb_skb_tx_hash(struct net_device *dev,
+				  const struct sk_buff *skb,
+				  u16 num_tx_queues)
+{
+	u32 jhash_initval_salt = 0xd631614b; /* same as in COMPAT */
+	u32 hash;
+
+	if (skb->sk && skb->sk->sk_hash)
+		hash = skb->sk->sk_hash;
+	else
+		hash = (__force u16)skb->protocol ^ skb->hash;
+
+	hash = jhash_1word(hash, jhash_initval_salt);
+
+	return (u16)(((u64)hash * num_tx_queues) >> 32);
+}
+
+u16 i40e_lan_select_queue(struct net_device *netdev,
+			  struct sk_buff *skb,
+			  struct net_device __always_unused *sb_dev)
+{
+	struct i40e_netdev_priv *np = netdev_priv(netdev);
+	struct i40e_vsi *vsi = np->vsi;
+	struct i40e_hw *hw;
+	u16 qoffset;
+	u16 qcount;
+	u8 tclass;
+	u16 hash;
+	u8 prio;
+
+	/* is DCB enabled at all? */
+	if (vsi->tc_config.numtc == 1)
+		return i40e_swdcb_skb_tx_hash(netdev, skb,
+					      netdev->real_num_tx_queues);
+
+	prio = skb->priority;
+	hw = &vsi->back->hw;
+	tclass = hw->local_dcbx_config.etscfg.prioritytable[prio];
+	/* sanity check */
+	if (unlikely(!(vsi->tc_config.enabled_tc & BIT(tclass))))
+		tclass = 0;
+
+	/* select a queue assigned for the given TC */
+	qcount = vsi->tc_config.tc_info[tclass].qcount;
+	hash = i40e_swdcb_skb_tx_hash(netdev, skb, qcount);
+
+	qoffset = vsi->tc_config.tc_info[tclass].qoffset;
+	return qoffset + hash;
+}
+
 /**
  * i40e_xmit_xdp_ring - transmits an XDP buffer to an XDP Tx ring
  * @xdpf: data to transmit
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index 86fed05b4..bfc2845c9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -451,6 +451,8 @@ static inline unsigned int i40e_rx_pg_order(struct i40e_ring *ring)
 
 bool i40e_alloc_rx_buffers(struct i40e_ring *rxr, u16 cleaned_count);
 netdev_tx_t i40e_lan_xmit_frame(struct sk_buff *skb, struct net_device *netdev);
+u16 i40e_lan_select_queue(struct net_device *netdev, struct sk_buff *skb,
+			  struct net_device *sb_dev);
 void i40e_clean_tx_ring(struct i40e_ring *tx_ring);
 void i40e_clean_rx_ring(struct i40e_ring *rx_ring);
 int i40e_setup_tx_descriptors(struct i40e_ring *tx_ring);
-- 
2.27.0

Intel Technology Poland sp. z o.o.
ul. Sowackiego 173 | 80-298 Gdask | Sd Rejonowy Gdask Pnoc | VII Wydzia Gospodarczy Krajowego Rejestru Sdowego - KRS 101882 | NIP 957-07-52-316 | Kapita zakadowy 200.000 PLN.
Ta wiadomo wraz z zacznikami jest przeznaczona dla okrelonego adresata i moe zawiera informacje poufne. W razie przypadkowego otrzymania tej wiadomoci, prosimy o powiadomienie nadawcy oraz trwae jej usunicie; jakiekolwiek przegldanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

