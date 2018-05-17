From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 17 May 2018 11:22:49 -0700
Subject: [Intel-wired-lan] [RFC PATCH 5/6] ixgbevf: add VF ipsec offload code
In-Reply-To: <1526581370-30307-1-git-send-email-shannon.nelson@oracle.com>
References: <1526581370-30307-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <1526581370-30307-6-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add the ipsec offload support code.  This is based off of the similar
code in ixgbe, but instead of writing the SA registers, the VF asks
the PF to setup the offload by sending the offload information to the
PF via the standard mailbox.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbevf/Makefile  |   1 +
 drivers/net/ethernet/intel/ixgbevf/ipsec.c   | 623 +++++++++++++++++++++++++++
 drivers/net/ethernet/intel/ixgbevf/ipsec.h   |  66 +++
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h |   8 +
 4 files changed, 698 insertions(+)
 create mode 100644 drivers/net/ethernet/intel/ixgbevf/ipsec.c
 create mode 100644 drivers/net/ethernet/intel/ixgbevf/ipsec.h

diff --git a/drivers/net/ethernet/intel/ixgbevf/Makefile b/drivers/net/ethernet/intel/ixgbevf/Makefile
index bb47814..505f226 100644
--- a/drivers/net/ethernet/intel/ixgbevf/Makefile
+++ b/drivers/net/ethernet/intel/ixgbevf/Makefile
@@ -36,4 +36,5 @@ ixgbevf-objs := vf.o \
                 mbx.o \
                 ethtool.o \
                 ixgbevf_main.o
+ixgbevf-$(CONFIG_XFRM_OFFLOAD) += ipsec.o
 
diff --git a/drivers/net/ethernet/intel/ixgbevf/ipsec.c b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
new file mode 100644
index 0000000..761d2fb
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
@@ -0,0 +1,623 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2018 Oracle and/or its affiliates. All rights reserved. */
+
+#include "ixgbevf.h"
+#include <net/xfrm.h>
+#include <crypto/aead.h>
+
+#define IXGBE_IPSEC_KEY_BITS  160
+const char aes_gcm_name[] = "rfc4106(gcm(aes))";
+
+/**
+ * ixgbevf_ipsec_set_pf_sa - ask the PF to set up an SA
+ * @hw: hw specific details
+ * @xs: xfrm info to be sent to the PF
+ *
+ * Returns: positive offload handle from the PF, or negative error code
+ **/
+static int ixgbevf_ipsec_set_pf_sa(struct ixgbe_hw *hw, struct xfrm_state *xs)
+{
+	u32 msgbuf[IXGBE_VFMAILBOX_SIZE] = { 0 };
+	struct sa_mbx_msg *sam;
+	u16 msglen;
+	int ret;
+
+	/* send the important bits to the PF */
+	sam = (struct sa_mbx_msg *)(&msgbuf[1]);
+	sam->flags = xs->xso.flags;
+	sam->spi = xs->id.spi;
+	sam->proto = xs->id.proto;
+	sam->family = xs->props.family;
+
+	if (xs->props.family == AF_INET6)
+		memcpy(sam->addr, &xs->id.daddr.a6, sizeof(xs->id.daddr.a6));
+	else
+		memcpy(sam->addr, &xs->id.daddr.a4, sizeof(xs->id.daddr.a4));
+	memcpy(sam->key, xs->aead->alg_key, sizeof(sam->key));
+
+	msgbuf[0] = IXGBE_VF_IPSEC_ADD;
+	msglen = sizeof(*sam) + sizeof(msgbuf[0]);
+	ret = hw->mbx.ops.write_posted(hw, msgbuf, msglen);
+	if (ret)
+		return ret;
+
+	msglen = sizeof(msgbuf[0]) * 2;
+	ret = hw->mbx.ops.read_posted(hw, msgbuf, msglen);
+	if (ret)
+		return ret;
+
+	ret = (int)msgbuf[1];
+	if (msgbuf[0] & IXGBE_VT_MSGTYPE_NACK && ret >= 0)
+		ret = -1;
+
+	return ret;
+}
+
+/**
+ * ixgbevf_ipsec_del_pf_sa - ask the PF to delete an SA
+ * @hw: hw specific details
+ * @pfsa: sa index returned from PF when created, -1 for all
+ *
+ * Returns: 0 on success, or negative error code
+ **/
+static int ixgbevf_ipsec_del_pf_sa(struct ixgbe_hw *hw, int pfsa)
+{
+	int err;
+	u32 msgbuf[2];
+
+	memset(msgbuf, 0, sizeof(msgbuf));
+	msgbuf[0] = IXGBE_VF_IPSEC_DEL;
+	msgbuf[1] = (u32)pfsa;
+
+	err = hw->mbx.ops.write_posted(hw, msgbuf, sizeof(msgbuf));
+	if (err)
+		return err;
+
+	err = hw->mbx.ops.read_posted(hw, msgbuf, sizeof(msgbuf));
+	if (err)
+		return err;
+
+	return 0;
+}
+
+/**
+ * ixgbevf_ipsec_find_empty_idx - find the first unused security parameter index
+ * @ipsec: pointer to ipsec struct
+ * @rxtable: true if we need to look in the Rx table
+ *
+ * Returns the first unused index in either the Rx or Tx SA table
+ **/
+static
+int ixgbevf_ipsec_find_empty_idx(struct ixgbevf_ipsec *ipsec, bool rxtable)
+{
+	u32 i;
+
+	if (rxtable) {
+		if (ipsec->num_rx_sa == IXGBE_IPSEC_MAX_SA_COUNT)
+			return -ENOSPC;
+
+		/* search rx sa table */
+		for (i = 0; i < IXGBE_IPSEC_MAX_SA_COUNT; i++) {
+			if (!ipsec->rx_tbl[i].used)
+				return i;
+		}
+	} else {
+		if (ipsec->num_tx_sa == IXGBE_IPSEC_MAX_SA_COUNT)
+			return -ENOSPC;
+
+		/* search tx sa table */
+		for (i = 0; i < IXGBE_IPSEC_MAX_SA_COUNT; i++) {
+			if (!ipsec->tx_tbl[i].used)
+				return i;
+		}
+	}
+
+	return -ENOSPC;
+}
+
+/**
+ * ixgbevf_ipsec_find_rx_state - find the state that matches
+ * @ipsec: pointer to ipsec struct
+ * @daddr: inbound address to match
+ * @proto: protocol to match
+ * @spi: SPI to match
+ * @ip4: true if using an ipv4 address
+ *
+ * Returns a pointer to the matching SA state information
+ **/
+static
+struct xfrm_state *ixgbevf_ipsec_find_rx_state(struct ixgbevf_ipsec *ipsec,
+					       __be32 *daddr, u8 proto,
+					       __be32 spi, bool ip4)
+{
+	struct xfrm_state *ret = NULL;
+	struct rx_sa *rsa;
+
+	rcu_read_lock();
+	hash_for_each_possible_rcu(ipsec->rx_sa_list, rsa, hlist, spi)
+		if (spi == rsa->xs->id.spi &&
+		    ((ip4 && *daddr == rsa->xs->id.daddr.a4) ||
+		      (!ip4 && !memcmp(daddr, &rsa->xs->id.daddr.a6,
+				       sizeof(rsa->xs->id.daddr.a6)))) &&
+		    proto == rsa->xs->id.proto) {
+			ret = rsa->xs;
+			xfrm_state_hold(ret);
+			break;
+		}
+	rcu_read_unlock();
+	return ret;
+}
+
+/**
+ * ixgbevf_ipsec_parse_proto_keys - find the key and salt based on the protocol
+ * @xs: pointer to xfrm_state struct
+ * @mykey: pointer to key array to populate
+ * @mysalt: pointer to salt value to populate
+ *
+ * This copies the protocol keys and salt to our own data tables.  The
+ * 82599 family only supports the one algorithm.
+ **/
+static int ixgbevf_ipsec_parse_proto_keys(struct xfrm_state *xs,
+					  u32 *mykey, u32 *mysalt)
+{
+	struct net_device *dev = xs->xso.dev;
+	unsigned char *key_data;
+	char *alg_name = NULL;
+	int key_len;
+
+	if (!xs->aead) {
+		netdev_err(dev, "Unsupported IPsec algorithm\n");
+		return -EINVAL;
+	}
+
+	if (xs->aead->alg_icv_len != IXGBE_IPSEC_AUTH_BITS) {
+		netdev_err(dev, "IPsec offload requires %d bit authentication\n",
+			   IXGBE_IPSEC_AUTH_BITS);
+		return -EINVAL;
+	}
+
+	key_data = &xs->aead->alg_key[0];
+	key_len = xs->aead->alg_key_len;
+	alg_name = xs->aead->alg_name;
+
+	if (strcmp(alg_name, aes_gcm_name)) {
+		netdev_err(dev, "Unsupported IPsec algorithm - please use %s\n",
+			   aes_gcm_name);
+		return -EINVAL;
+	}
+
+	/* The key bytes come down in a bigendian array of bytes, so
+	 * we don't need to do any byteswapping.
+	 * 160 accounts for 16 byte key and 4 byte salt
+	 */
+	if (key_len == IXGBE_IPSEC_KEY_BITS) {
+		*mysalt = ((u32 *)key_data)[4];
+	} else if (key_len != (IXGBE_IPSEC_KEY_BITS - (sizeof(*mysalt) * 8))) {
+		netdev_err(dev, "IPsec hw offload only supports keys up to 128 bits with a 32 bit salt\n");
+		return -EINVAL;
+	} else {
+		netdev_info(dev, "IPsec hw offload parameters missing 32 bit salt value\n");
+		*mysalt = 0;
+	}
+	memcpy(mykey, key_data, 16);
+
+	return 0;
+}
+
+/**
+ * ixgbevf_ipsec_add_sa - program device with a security association
+ * @xs: pointer to transformer state struct
+ **/
+static int ixgbevf_ipsec_add_sa(struct xfrm_state *xs)
+{
+	struct net_device *dev = xs->xso.dev;
+	struct ixgbevf_adapter *adapter = netdev_priv(dev);
+	struct ixgbevf_ipsec *ipsec = adapter->ipsec;
+	struct ixgbe_hw *hw = &adapter->hw;
+	u16 sa_idx;
+	int ret;
+
+	if (xs->id.proto != IPPROTO_ESP && xs->id.proto != IPPROTO_AH) {
+		netdev_err(dev, "Unsupported protocol 0x%04x for ipsec offload\n",
+			   xs->id.proto);
+		return -EINVAL;
+	}
+
+	if (xs->xso.flags & XFRM_OFFLOAD_INBOUND) {
+		struct rx_sa rsa;
+
+		if (xs->calg) {
+			netdev_err(dev, "Compression offload not supported\n");
+			return -EINVAL;
+		}
+
+		/* find the first unused index */
+		ret = ixgbevf_ipsec_find_empty_idx(ipsec, true);
+		if (ret < 0) {
+			netdev_err(dev, "No space for SA in Rx table!\n");
+			return ret;
+		}
+		sa_idx = (u16)ret;
+
+		memset(&rsa, 0, sizeof(rsa));
+		rsa.used = true;
+		rsa.xs = xs;
+
+		if (rsa.xs->id.proto & IPPROTO_ESP)
+			rsa.decrypt = xs->ealg || xs->aead;
+
+		/* get the key and salt */
+		ret = ixgbevf_ipsec_parse_proto_keys(xs, rsa.key, &rsa.salt);
+		if (ret) {
+			netdev_err(dev, "Failed to get key data for Rx SA table\n");
+			return ret;
+		}
+
+		/* get ip for rx sa table */
+		if (xs->props.family == AF_INET6)
+			memcpy(rsa.ipaddr, &xs->id.daddr.a6, 16);
+		else
+			memcpy(&rsa.ipaddr[3], &xs->id.daddr.a4, 4);
+
+		rsa.mode = IXGBE_RXMOD_VALID;
+		if (rsa.xs->id.proto & IPPROTO_ESP)
+			rsa.mode |= IXGBE_RXMOD_PROTO_ESP;
+		if (rsa.decrypt)
+			rsa.mode |= IXGBE_RXMOD_DECRYPT;
+		if (rsa.xs->props.family == AF_INET6)
+			rsa.mode |= IXGBE_RXMOD_IPV6;
+
+		ret = ixgbevf_ipsec_set_pf_sa(hw, xs);
+		if (ret < 0)
+			return ret;
+		rsa.pfsa = ret;
+
+		/* the preparations worked, so save the info */
+		memcpy(&ipsec->rx_tbl[sa_idx], &rsa, sizeof(rsa));
+
+		xs->xso.offload_handle = sa_idx + IXGBE_IPSEC_BASE_RX_INDEX;
+
+		ipsec->num_rx_sa++;
+
+		/* hash the new entry for faster search in Rx path */
+		hash_add_rcu(ipsec->rx_sa_list, &ipsec->rx_tbl[sa_idx].hlist,
+			     rsa.xs->id.spi);
+	} else {
+		struct tx_sa tsa;
+
+		/* find the first unused index */
+		ret = ixgbevf_ipsec_find_empty_idx(ipsec, false);
+		if (ret < 0) {
+			netdev_err(dev, "No space for SA in Tx table\n");
+			return ret;
+		}
+		sa_idx = (u16)ret;
+
+		memset(&tsa, 0, sizeof(tsa));
+		tsa.used = true;
+		tsa.xs = xs;
+
+		if (xs->id.proto & IPPROTO_ESP)
+			tsa.encrypt = xs->ealg || xs->aead;
+
+		ret = ixgbevf_ipsec_parse_proto_keys(xs, tsa.key, &tsa.salt);
+		if (ret) {
+			netdev_err(dev, "Failed to get key data for Tx SA table\n");
+			memset(&tsa, 0, sizeof(tsa));
+			return ret;
+		}
+
+		ret = ixgbevf_ipsec_set_pf_sa(hw, xs);
+		if (ret < 0)
+			return ret;
+		tsa.pfsa = ret;
+
+		/* the preparations worked, so save the info */
+		memcpy(&ipsec->tx_tbl[sa_idx], &tsa, sizeof(tsa));
+
+		xs->xso.offload_handle = sa_idx + IXGBE_IPSEC_BASE_TX_INDEX;
+
+		ipsec->num_tx_sa++;
+	}
+
+	return 0;
+}
+
+/**
+ * ixgbevf_ipsec_del_sa - clear out this specific SA
+ * @xs: pointer to transformer state struct
+ **/
+static void ixgbevf_ipsec_del_sa(struct xfrm_state *xs)
+{
+	struct net_device *dev = xs->xso.dev;
+	struct ixgbevf_adapter *adapter = netdev_priv(dev);
+	struct ixgbevf_ipsec *ipsec = adapter->ipsec;
+	struct ixgbe_hw *hw = &adapter->hw;
+	u16 sa_idx;
+
+	if (xs->xso.flags & XFRM_OFFLOAD_INBOUND) {
+		sa_idx = xs->xso.offload_handle - IXGBE_IPSEC_BASE_RX_INDEX;
+
+		if (!ipsec->rx_tbl[sa_idx].used) {
+			netdev_err(dev, "Invalid Rx SA selected sa_idx=%d offload_handle=%lu\n",
+				   sa_idx, xs->xso.offload_handle);
+			return;
+		}
+
+		ixgbevf_ipsec_del_pf_sa(hw, ipsec->rx_tbl[sa_idx].pfsa);
+		hash_del_rcu(&ipsec->rx_tbl[sa_idx].hlist);
+		memset(&ipsec->rx_tbl[sa_idx], 0, sizeof(struct rx_sa));
+		ipsec->num_rx_sa--;
+	} else {
+		sa_idx = xs->xso.offload_handle - IXGBE_IPSEC_BASE_TX_INDEX;
+
+		if (!ipsec->tx_tbl[sa_idx].used) {
+			netdev_err(dev, "Invalid Tx SA selected sa_idx=%d offload_handle=%lu\n",
+				   sa_idx, xs->xso.offload_handle);
+			return;
+		}
+
+		ixgbevf_ipsec_del_pf_sa(hw, ipsec->tx_tbl[sa_idx].pfsa);
+		memset(&ipsec->tx_tbl[sa_idx], 0, sizeof(struct tx_sa));
+		ipsec->num_tx_sa--;
+	}
+}
+
+/**
+ * ixgbevf_ipsec_offload_ok - can this packet use the xfrm hw offload
+ * @skb: current data packet
+ * @xs: pointer to transformer state struct
+ **/
+static bool ixgbevf_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
+{
+	if (xs->props.family == AF_INET) {
+		/* Offload with IPv4 options is not supported yet */
+		if (ip_hdr(skb)->ihl != 5)
+			return false;
+	} else {
+		/* Offload with IPv6 extension headers is not support yet */
+		if (ipv6_ext_hdr(ipv6_hdr(skb)->nexthdr))
+			return false;
+	}
+
+	return true;
+}
+
+static const struct xfrmdev_ops ixgbevf_xfrmdev_ops = {
+	.xdo_dev_state_add = ixgbevf_ipsec_add_sa,
+	.xdo_dev_state_delete = ixgbevf_ipsec_del_sa,
+	.xdo_dev_offload_ok = ixgbevf_ipsec_offload_ok,
+};
+
+/**
+ * ixgbevf_ipsec_tx - setup Tx flags for ipsec offload
+ * @tx_ring: outgoing context
+ * @first: current data packet
+ * @itd: ipsec Tx data for later use in building context descriptor
+ **/
+int ixgbevf_ipsec_tx(struct ixgbevf_ring *tx_ring,
+		     struct ixgbevf_tx_buffer *first,
+		     struct ixgbevf_ipsec_tx_data *itd)
+{
+	struct ixgbevf_adapter *adapter = netdev_priv(tx_ring->netdev);
+	struct ixgbevf_ipsec *ipsec = adapter->ipsec;
+	struct xfrm_state *xs;
+	struct tx_sa *tsa;
+	u16 sa_idx;
+
+	if (unlikely(!first->skb->sp->len)) {
+		netdev_err(tx_ring->netdev, "%s: no xfrm state len = %d\n",
+			   __func__, first->skb->sp->len);
+		return 0;
+	}
+
+	xs = xfrm_input_state(first->skb);
+	if (unlikely(!xs)) {
+		netdev_err(tx_ring->netdev, "%s: no xfrm_input_state() xs = %p\n",
+			   __func__, xs);
+		return 0;
+	}
+
+	sa_idx = xs->xso.offload_handle - IXGBE_IPSEC_BASE_TX_INDEX;
+	if (unlikely(sa_idx > IXGBE_IPSEC_MAX_SA_COUNT)) {
+		netdev_err(tx_ring->netdev, "%s: bad sa_idx=%d handle=%lu\n",
+			   __func__, sa_idx, xs->xso.offload_handle);
+		return 0;
+	}
+
+	tsa = &ipsec->tx_tbl[sa_idx];
+	if (unlikely(!tsa->used)) {
+		netdev_err(tx_ring->netdev, "%s: unused sa_idx=%d\n",
+			   __func__, sa_idx);
+		return 0;
+	}
+
+	itd->pfsa = tsa->pfsa - IXGBE_IPSEC_BASE_TX_INDEX;
+
+	first->tx_flags |= IXGBE_TX_FLAGS_IPSEC | IXGBE_TX_FLAGS_CSUM;
+
+	if (xs->id.proto == IPPROTO_ESP) {
+
+		itd->flags |= IXGBE_ADVTXD_TUCMD_IPSEC_TYPE_ESP |
+			      IXGBE_ADVTXD_TUCMD_L4T_TCP;
+		if (first->protocol == htons(ETH_P_IP))
+			itd->flags |= IXGBE_ADVTXD_TUCMD_IPV4;
+
+		/* The actual trailer length is authlen (16 bytes) plus
+		 * 2 bytes for the proto and the padlen values, plus
+		 * padlen bytes of padding.  This ends up not the same
+		 * as the static value found in xs->props.trailer_len (21).
+		 *
+		 * ... but if we're doing GSO, don't bother as the stack
+		 * doesn't add a trailer for those.
+		 */
+		if (!skb_is_gso(first->skb)) {
+			/* The "correct" way to get the auth length would be
+			 * to use
+			 *    authlen = crypto_aead_authsize(xs->data);
+			 * but since we know we only have one size to worry
+			 * about * we can let the compiler use the constant
+			 * and save us a few CPU cycles.
+			 */
+			const int authlen = IXGBE_IPSEC_AUTH_BITS / 8;
+			struct sk_buff *skb = first->skb;
+			u8 padlen;
+			int ret;
+
+			ret = skb_copy_bits(skb, skb->len - (authlen + 2),
+					    &padlen, 1);
+			if (unlikely(ret))
+				return 0;
+			itd->trailer_len = authlen + 2 + padlen;
+		}
+	}
+	if (tsa->encrypt)
+		itd->flags |= IXGBE_ADVTXD_TUCMD_IPSEC_ENCRYPT_EN;
+
+	return 1;
+}
+
+/**
+ * ixgbevf_ipsec_rx - decode ipsec bits from Rx descriptor
+ * @rx_ring: receiving ring
+ * @rx_desc: receive data descriptor
+ * @skb: current data packet
+ *
+ * Determine if there was an ipsec encapsulation noticed, and if so set up
+ * the resulting status for later in the receive stack.
+ **/
+void ixgbevf_ipsec_rx(struct ixgbevf_ring *rx_ring,
+		      union ixgbe_adv_rx_desc *rx_desc,
+		      struct sk_buff *skb)
+{
+	struct ixgbevf_adapter *adapter = netdev_priv(rx_ring->netdev);
+	__le16 pkt_info = rx_desc->wb.lower.lo_dword.hs_rss.pkt_info;
+	__le16 ipsec_pkt_types = cpu_to_le16(IXGBE_RXDADV_PKTTYPE_IPSEC_AH |
+					     IXGBE_RXDADV_PKTTYPE_IPSEC_ESP);
+	struct ixgbevf_ipsec *ipsec = adapter->ipsec;
+	struct xfrm_offload *xo = NULL;
+	struct xfrm_state *xs = NULL;
+	struct ipv6hdr *ip6 = NULL;
+	struct iphdr *ip4 = NULL;
+	void *daddr;
+	__be32 spi;
+	u8 *c_hdr;
+	u8 proto;
+
+	/* Find the ip and crypto headers in the data.
+	 * We can assume no vlan header in the way, b/c the
+	 * hw won't recognize the IPsec packet and anyway the
+	 * currently vlan device doesn't support xfrm offload.
+	 */
+	if (pkt_info & cpu_to_le16(IXGBE_RXDADV_PKTTYPE_IPV4)) {
+		ip4 = (struct iphdr *)(skb->data + ETH_HLEN);
+		daddr = &ip4->daddr;
+		c_hdr = (u8 *)ip4 + ip4->ihl * 4;
+	} else if (pkt_info & cpu_to_le16(IXGBE_RXDADV_PKTTYPE_IPV6)) {
+		ip6 = (struct ipv6hdr *)(skb->data + ETH_HLEN);
+		daddr = &ip6->daddr;
+		c_hdr = (u8 *)ip6 + sizeof(struct ipv6hdr);
+	} else {
+		return;
+	}
+
+	switch (pkt_info & ipsec_pkt_types) {
+	case cpu_to_le16(IXGBE_RXDADV_PKTTYPE_IPSEC_AH):
+		spi = ((struct ip_auth_hdr *)c_hdr)->spi;
+		proto = IPPROTO_AH;
+		break;
+	case cpu_to_le16(IXGBE_RXDADV_PKTTYPE_IPSEC_ESP):
+		spi = ((struct ip_esp_hdr *)c_hdr)->spi;
+		proto = IPPROTO_ESP;
+		break;
+	default:
+		return;
+	}
+
+	xs = ixgbevf_ipsec_find_rx_state(ipsec, daddr, proto, spi, !!ip4);
+	if (unlikely(!xs))
+		return;
+
+	skb->sp = secpath_dup(skb->sp);
+	if (unlikely(!skb->sp))
+		return;
+
+	skb->sp->xvec[skb->sp->len++] = xs;
+	skb->sp->olen++;
+	xo = xfrm_offload(skb);
+	xo->flags = CRYPTO_DONE;
+	xo->status = CRYPTO_SUCCESS;
+
+	adapter->rx_ipsec++;
+}
+
+/**
+ * ixgbevf_init_ipsec_offload - initialize registers for IPSec operation
+ * @adapter: board private structure
+ **/
+void ixgbevf_init_ipsec_offload(struct ixgbevf_adapter *adapter)
+{
+	struct ixgbevf_ipsec *ipsec;
+	size_t size;
+
+	switch (adapter->hw.api_version) {
+	case ixgbe_mbox_api_14:
+		break;
+	default:
+		return;
+	}
+
+	ipsec = kzalloc(sizeof(*ipsec), GFP_KERNEL);
+	if (!ipsec)
+		goto err1;
+	hash_init(ipsec->rx_sa_list);
+
+	size = sizeof(struct rx_sa) * IXGBE_IPSEC_MAX_SA_COUNT;
+	ipsec->rx_tbl = kzalloc(size, GFP_KERNEL);
+	if (!ipsec->rx_tbl)
+		goto err2;
+
+	size = sizeof(struct tx_sa) * IXGBE_IPSEC_MAX_SA_COUNT;
+	ipsec->tx_tbl = kzalloc(size, GFP_KERNEL);
+	if (!ipsec->tx_tbl)
+		goto err2;
+
+	ipsec->num_rx_sa = 0;
+	ipsec->num_tx_sa = 0;
+
+	adapter->ipsec = ipsec;
+
+	adapter->netdev->xfrmdev_ops = &ixgbevf_xfrmdev_ops;
+
+#define IXGBE_ESP_FEATURES	(NETIF_F_HW_ESP | \
+				 NETIF_F_HW_ESP_TX_CSUM | \
+				 NETIF_F_GSO_ESP)
+
+	adapter->netdev->features |= IXGBE_ESP_FEATURES;
+	adapter->netdev->hw_enc_features |= IXGBE_ESP_FEATURES;
+
+	return;
+
+err2:
+	kfree(ipsec->rx_tbl);
+	kfree(ipsec->tx_tbl);
+	kfree(ipsec);
+err1:
+	netdev_err(adapter->netdev, "Unable to allocate memory for SA tables");
+}
+
+/**
+ * ixgbevf_stop_ipsec_offload - tear down the ipsec offload
+ * @adapter: board private structure
+ **/
+void ixgbevf_stop_ipsec_offload(struct ixgbevf_adapter *adapter)
+{
+	struct ixgbevf_ipsec *ipsec = adapter->ipsec;
+
+	adapter->ipsec = NULL;
+	if (ipsec) {
+		kfree(ipsec->rx_tbl);
+		kfree(ipsec->tx_tbl);
+		kfree(ipsec);
+	}
+}
diff --git a/drivers/net/ethernet/intel/ixgbevf/ipsec.h b/drivers/net/ethernet/intel/ixgbevf/ipsec.h
new file mode 100644
index 0000000..3740725
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixgbevf/ipsec.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2018 Oracle and/or its affiliates. All rights reserved. */
+
+#ifndef _IXGBEVF_IPSEC_H_
+#define _IXGBEVF_IPSEC_H_
+
+#define IXGBE_IPSEC_MAX_SA_COUNT	1024
+#define IXGBE_IPSEC_BASE_RX_INDEX	0
+#define IXGBE_IPSEC_BASE_TX_INDEX	IXGBE_IPSEC_MAX_SA_COUNT
+#define IXGBE_IPSEC_AUTH_BITS		128
+
+#define IXGBE_RXMOD_VALID		0x00000001
+#define IXGBE_RXMOD_PROTO_ESP		0x00000004
+#define IXGBE_RXMOD_DECRYPT		0x00000008
+#define IXGBE_RXMOD_IPV6		0x00000010
+
+struct rx_sa {
+	struct hlist_node hlist;
+	struct xfrm_state *xs;
+	__be32 ipaddr[4];
+	u32 key[4];
+	u32 salt;
+	u32 mode;
+	u32 pfsa;
+	bool used;
+	bool decrypt;
+};
+
+struct rx_ip_sa {
+	__be32 ipaddr[4];
+	u32 ref_cnt;
+	bool used;
+};
+
+struct tx_sa {
+	struct xfrm_state *xs;
+	u32 key[4];
+	u32 salt;
+	u32 pfsa;
+	bool encrypt;
+	bool used;
+};
+
+struct ixgbevf_ipsec_tx_data {
+	u32 flags;
+	u16 trailer_len;
+	u16 pfsa;
+};
+
+struct ixgbevf_ipsec {
+	u16 num_rx_sa;
+	u16 num_tx_sa;
+	struct rx_sa *rx_tbl;
+	struct tx_sa *tx_tbl;
+	DECLARE_HASHTABLE(rx_sa_list, 10);
+};
+
+struct sa_mbx_msg {
+	__be32 spi;
+	u8 flags;
+	u8 proto;
+	u16 family;
+	__be32 addr[4];
+	u32 key[5];
+};
+#endif /* _IXGBEVF_IPSEC_H_ */
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index 447ce1d..7a3329e 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -38,6 +38,7 @@
 #include <net/xdp.h>
 
 #include "vf.h"
+#include "ipsec.h"
 
 #define IXGBE_MAX_TXD_PWR	14
 #define IXGBE_MAX_DATA_PER_TXD	BIT(IXGBE_MAX_TXD_PWR)
@@ -186,6 +187,7 @@ struct ixgbevf_ring {
 #define IXGBE_TX_FLAGS_VLAN		BIT(1)
 #define IXGBE_TX_FLAGS_TSO		BIT(2)
 #define IXGBE_TX_FLAGS_IPV4		BIT(3)
+#define IXGBE_TX_FLAGS_IPSEC		BIT(4)
 #define IXGBE_TX_FLAGS_VLAN_MASK	0xffff0000
 #define IXGBE_TX_FLAGS_VLAN_PRIO_MASK	0x0000e000
 #define IXGBE_TX_FLAGS_VLAN_SHIFT	16
@@ -361,6 +363,7 @@ struct ixgbevf_adapter {
 	struct ixgbevf_ring *tx_ring[MAX_TX_QUEUES]; /* One per active queue */
 	u64 restart_queue;
 	u32 tx_timeout_count;
+	u64 tx_ipsec;
 
 	/* RX */
 	int num_rx_queues;
@@ -371,6 +374,7 @@ struct ixgbevf_adapter {
 	u64 alloc_rx_page_failed;
 	u64 alloc_rx_buff_failed;
 	u64 alloc_rx_page;
+	u64 rx_ipsec;
 
 	struct msix_entry *msix_entries;
 
@@ -407,6 +411,10 @@ struct ixgbevf_adapter {
 	u8 rss_indir_tbl[IXGBEVF_X550_VFRETA_SIZE];
 	u32 flags;
 #define IXGBEVF_FLAGS_LEGACY_RX		BIT(1)
+
+#ifdef CONFIG_XFRM
+	struct ixgbevf_ipsec *ipsec;
+#endif /* CONFIG_XFRM */
 };
 
 enum ixbgevf_state_t {
-- 
2.7.4

