From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon,  4 Dec 2017 21:35:11 -0800
Subject: [Intel-wired-lan] [next-queue 05/10] ixgbe: implement ipsec add and
 remove of offloaded SA
In-Reply-To: <1512452116-14795-1-git-send-email-shannon.nelson@oracle.com>
References: <1512452116-14795-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <1512452116-14795-6-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add the functions for setting up and removing offloaded SAs (Security
Associations) with the x540 hardware.  We set up the callback structure
but we don't yet set the hardware feature bit to be sure the XFRM service
won't actually try to use us for an offload yet.

The software tables are made up to mimic the hardware tables to make it
easier to track what's in the hardware, and the SA table index is used
for the XFRM offload handle.  However, there is a hashing field in the
Rx SA tracking that will be used to facilitate faster table searches in
the Rx fast path.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 377 +++++++++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |   6 +
 2 files changed, 383 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index 38a1a16..7b01d92 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -26,6 +26,8 @@
  ******************************************************************************/
 
 #include "ixgbe.h"
+#include <net/xfrm.h>
+#include <crypto/aead.h>
 
 /**
  * ixgbe_ipsec_set_tx_sa - set the Tx SA registers
@@ -128,6 +130,7 @@ static void ixgbe_ipsec_set_rx_ip(struct ixgbe_hw *hw, u16 idx, u32 addr[])
  **/
 void ixgbe_ipsec_clear_hw_tables(struct ixgbe_adapter *adapter)
 {
+	struct ixgbe_ipsec *ipsec = adapter->ipsec;
 	struct ixgbe_hw *hw = &adapter->hw;
 	u32 buf[4] = {0, 0, 0, 0};
 	u16 idx;
@@ -139,9 +142,11 @@ void ixgbe_ipsec_clear_hw_tables(struct ixgbe_adapter *adapter)
 	/* scrub the tables */
 	for (idx = 0; idx < IXGBE_IPSEC_MAX_SA_COUNT; idx++)
 		ixgbe_ipsec_set_tx_sa(hw, idx, buf, 0);
+	ipsec->num_tx_sa = 0;
 
 	for (idx = 0; idx < IXGBE_IPSEC_MAX_SA_COUNT; idx++)
 		ixgbe_ipsec_set_rx_sa(hw, idx, 0, buf, 0, 0, 0);
+	ipsec->num_rx_sa = 0;
 
 	for (idx = 0; idx < IXGBE_IPSEC_MAX_RX_IP_COUNT; idx++)
 		ixgbe_ipsec_set_rx_ip(hw, idx, buf);
@@ -287,11 +292,383 @@ static void ixgbe_ipsec_start_engine(struct ixgbe_adapter *adapter)
 }
 
 /**
+ * ixgbe_ipsec_find_empty_idx - find the first unused security parameter index
+ * @ipsec: pointer to ipsec struct
+ * @rxtable: true if we need to look in the Rx table
+ *
+ * Returns the first unused index in either the Rx or Tx SA table
+ **/
+static int ixgbe_ipsec_find_empty_idx(struct ixgbe_ipsec *ipsec, bool rxtable)
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
+		if (ipsec->num_rx_sa == IXGBE_IPSEC_MAX_SA_COUNT)
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
+ * ixgbe_ipsec_parse_proto_keys - find the key and salt based on the protocol
+ * @xs: pointer to xfrm_state struct
+ * @mykey: pointer to key array to populate
+ * @mysalt: pointer to salt value to populate
+ *
+ * This copies the protocol keys and salt to our own data tables.  The
+ * 82599 family only supports the one algorithm.
+ **/
+static int ixgbe_ipsec_parse_proto_keys(struct xfrm_state *xs,
+					u32 *mykey, u32 *mysalt)
+{
+	struct net_device *dev = xs->xso.dev;
+	unsigned char *key_data;
+	char *alg_name = NULL;
+	char *aes_gcm_name = "rfc4106(gcm(aes))";
+	int key_len;
+
+	if (xs->aead) {
+		key_data = &xs->aead->alg_key[0];
+		key_len = xs->aead->alg_key_len;
+		alg_name = xs->aead->alg_name;
+	} else {
+		netdev_err(dev, "Unsupported IPsec algorithm\n");
+		return -EINVAL;
+	}
+
+	if (strcmp(alg_name, aes_gcm_name)) {
+		netdev_err(dev, "Unsupported IPsec algorithm - please use %s\n",
+			   aes_gcm_name);
+		return -EINVAL;
+	}
+
+	/* 160 accounts for 16 byte key and 4 byte salt */
+	if (key_len == 128) {
+		netdev_info(dev, "IPsec hw offload parameters missing 32 bit salt value\n");
+	} else if (key_len != 160) {
+		netdev_err(dev, "IPsec hw offload only supports keys up to 128 bits with a 32 bit salt\n");
+		return -EINVAL;
+	}
+
+	/* The key bytes come down in a bigendian array of bytes, and
+	 * salt is always the last 4 bytes of the key array.
+	 * We don't need to do any byteswapping.
+	 */
+	memcpy(mykey, key_data, 16);
+	if (key_len == 160)
+		*mysalt = ((u32 *)key_data)[4];
+	else
+		*mysalt = 0;
+
+	return 0;
+}
+
+/**
+ * ixgbe_ipsec_add_sa - program device with a security association
+ * @xs: pointer to transformer state struct
+ **/
+static int ixgbe_ipsec_add_sa(struct xfrm_state *xs)
+{
+	struct net_device *dev = xs->xso.dev;
+	struct ixgbe_adapter *adapter = netdev_priv(dev);
+	struct ixgbe_ipsec *ipsec = adapter->ipsec;
+	struct ixgbe_hw *hw = &adapter->hw;
+	int checked, match, first;
+	u16 sa_idx;
+	int ret;
+	int i;
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
+		ret = ixgbe_ipsec_find_empty_idx(ipsec, true);
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
+		ret = ixgbe_ipsec_parse_proto_keys(xs, rsa.key, &rsa.salt);
+		if (ret) {
+			netdev_err(dev, "Failed to get key data for Rx SA table\n");
+			return ret;
+		}
+
+		/* get ip for rx sa table */
+		if (xs->xso.flags & XFRM_OFFLOAD_IPV6)
+			memcpy(rsa.ipaddr, &xs->id.daddr.a6, 16);
+		else
+			memcpy(&rsa.ipaddr[3], &xs->id.daddr.a4, 4);
+
+		/* The HW does not have a 1:1 mapping from keys to IP addrs, so
+		 * check for a matching IP addr entry in the table.  If the addr
+		 * already exists, use it; else find an unused slot and add the
+		 * addr.  If one does not exist and there are no unused table
+		 * entries, fail the request.
+		 */
+
+		/* Find an existing match or first not used, and stop looking
+		 * after we've checked all we know we have.
+		 */
+		checked = 0;
+		match = -1;
+		first = -1;
+		for (i = 0;
+		     i < IXGBE_IPSEC_MAX_RX_IP_COUNT &&
+		     (checked < ipsec->num_rx_sa || first < 0);
+		     i++) {
+			if (ipsec->ip_tbl[i].used) {
+				if (!memcmp(ipsec->ip_tbl[i].ipaddr,
+					    rsa.ipaddr, sizeof(rsa.ipaddr))) {
+					match = i;
+					break;
+				}
+				checked++;
+			} else if (first < 0) {
+				first = i;  /* track the first empty seen */
+			}
+		}
+
+		if (ipsec->num_rx_sa == 0)
+			first = 0;
+
+		if (match >= 0) {
+			/* addrs are the same, we should use this one */
+			rsa.iptbl_ind = match;
+			ipsec->ip_tbl[match].ref_cnt++;
+
+		} else if (first >= 0) {
+			/* no matches, but here's an empty slot */
+			rsa.iptbl_ind = first;
+
+			memcpy(ipsec->ip_tbl[first].ipaddr,
+			       rsa.ipaddr, sizeof(rsa.ipaddr));
+			ipsec->ip_tbl[first].ref_cnt = 1;
+			ipsec->ip_tbl[first].used = true;
+
+			ixgbe_ipsec_set_rx_ip(hw, rsa.iptbl_ind, rsa.ipaddr);
+
+		} else {
+			/* no match and no empty slot */
+			netdev_err(dev, "No space for SA in Rx IP SA table\n");
+			memset(&rsa, 0, sizeof(rsa));
+			return -ENOSPC;
+		}
+
+		rsa.mode = IXGBE_RXMOD_VALID;
+		if (rsa.xs->id.proto & IPPROTO_ESP)
+			rsa.mode |= IXGBE_RXMOD_PROTO_ESP;
+		if (rsa.decrypt)
+			rsa.mode |= IXGBE_RXMOD_DECRYPT;
+		if (rsa.xs->xso.flags & XFRM_OFFLOAD_IPV6)
+			rsa.mode |= IXGBE_RXMOD_IPV6;
+
+		/* the preparations worked, so save the info */
+		memcpy(&ipsec->rx_tbl[sa_idx], &rsa, sizeof(rsa));
+
+		ixgbe_ipsec_set_rx_sa(hw, sa_idx, rsa.xs->id.spi, rsa.key,
+				      rsa.salt, rsa.mode, rsa.iptbl_ind);
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
+		ret = ixgbe_ipsec_find_empty_idx(ipsec, false);
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
+		ret = ixgbe_ipsec_parse_proto_keys(xs, tsa.key, &tsa.salt);
+		if (ret) {
+			netdev_err(dev, "Failed to get key data for Tx SA table\n");
+			memset(&tsa, 0, sizeof(tsa));
+			return ret;
+		}
+
+		/* the preparations worked, so save the info */
+		memcpy(&ipsec->tx_tbl[sa_idx], &tsa, sizeof(tsa));
+
+		ixgbe_ipsec_set_tx_sa(hw, sa_idx, tsa.key, tsa.salt);
+
+		xs->xso.offload_handle = sa_idx + IXGBE_IPSEC_BASE_TX_INDEX;
+
+		ipsec->num_tx_sa++;
+	}
+
+	/* enable the engine if not already warmed up */
+	if (!(adapter->flags2 & IXGBE_FLAG2_IPSEC_ENABLED)) {
+		ixgbe_ipsec_start_engine(adapter);
+		adapter->flags2 |= IXGBE_FLAG2_IPSEC_ENABLED;
+	}
+
+	return 0;
+}
+
+/**
+ * ixgbe_ipsec_del_sa - clear out this specific SA
+ * @xs: pointer to transformer state struct
+ **/
+static void ixgbe_ipsec_del_sa(struct xfrm_state *xs)
+{
+	struct net_device *dev = xs->xso.dev;
+	struct ixgbe_adapter *adapter = netdev_priv(dev);
+	struct ixgbe_ipsec *ipsec = adapter->ipsec;
+	struct ixgbe_hw *hw = &adapter->hw;
+	u32 zerobuf[4] = {0, 0, 0, 0};
+	u16 sa_idx;
+
+	if (xs->xso.flags & XFRM_OFFLOAD_INBOUND) {
+		struct rx_sa *rsa;
+		u8 ipi;
+
+		sa_idx = xs->xso.offload_handle - IXGBE_IPSEC_BASE_RX_INDEX;
+		rsa = &ipsec->rx_tbl[sa_idx];
+
+		if (!rsa->used) {
+			netdev_err(dev, "Invalid Rx SA selected sa_idx=%d offload_handle=%lu\n",
+				   sa_idx, xs->xso.offload_handle);
+			return;
+		}
+
+		ixgbe_ipsec_set_rx_sa(hw, sa_idx, 0, zerobuf, 0, 0, 0);
+		hash_del_rcu(&rsa->hlist);
+
+		/* if the IP table entry is referenced by only this SA,
+		 * i.e. ref_cnt is only 1, clear the IP table entry as well
+		 */
+		ipi = rsa->iptbl_ind;
+		if (ipsec->ip_tbl[ipi].ref_cnt > 0) {
+			ipsec->ip_tbl[ipi].ref_cnt--;
+
+			if (!ipsec->ip_tbl[ipi].ref_cnt) {
+				memset(&ipsec->ip_tbl[ipi], 0,
+				       sizeof(struct rx_ip_sa));
+				ixgbe_ipsec_set_rx_ip(hw, ipi, zerobuf);
+			}
+		}
+
+		memset(rsa, 0, sizeof(struct rx_sa));
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
+		ixgbe_ipsec_set_tx_sa(hw, sa_idx, zerobuf, 0);
+		memset(&ipsec->tx_tbl[sa_idx], 0, sizeof(struct tx_sa));
+		ipsec->num_tx_sa--;
+	}
+
+	/* if there are no SAs left, stop the engine to save energy */
+	if (ipsec->num_rx_sa == 0 && ipsec->num_tx_sa == 0) {
+		adapter->flags2 &= ~IXGBE_FLAG2_IPSEC_ENABLED;
+		ixgbe_ipsec_stop_engine(adapter);
+	}
+}
+
+static const struct xfrmdev_ops ixgbe_xfrmdev_ops = {
+	.xdo_dev_state_add = ixgbe_ipsec_add_sa,
+	.xdo_dev_state_delete = ixgbe_ipsec_del_sa,
+};
+
+/**
  * ixgbe_init_ipsec_offload - initialize security registers for IPSec operation
  * @adapter: board private structure
  **/
 void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter)
 {
+	struct ixgbe_ipsec *ipsec;
+	size_t size;
+
+	ipsec = kzalloc(sizeof(*ipsec), GFP_KERNEL);
+	if (!ipsec)
+		goto err;
+	hash_init(ipsec->rx_sa_list);
+
+	size = sizeof(struct rx_sa) * IXGBE_IPSEC_MAX_SA_COUNT;
+	ipsec->rx_tbl = kzalloc(size, GFP_KERNEL);
+	if (!ipsec->rx_tbl)
+		goto err;
+
+	size = sizeof(struct tx_sa) * IXGBE_IPSEC_MAX_SA_COUNT;
+	ipsec->tx_tbl = kzalloc(size, GFP_KERNEL);
+	if (!ipsec->tx_tbl)
+		goto err;
+
+	size = sizeof(struct rx_ip_sa) * IXGBE_IPSEC_MAX_RX_IP_COUNT;
+	ipsec->ip_tbl = kzalloc(size, GFP_KERNEL);
+	if (!ipsec->ip_tbl)
+		goto err;
+
+	ipsec->num_rx_sa = 0;
+	ipsec->num_tx_sa = 0;
+
+	adapter->ipsec = ipsec;
 	ixgbe_ipsec_clear_hw_tables(adapter);
 	ixgbe_ipsec_stop_engine(adapter);
+
+	return;
+err:
+	if (ipsec) {
+		kfree(ipsec->ip_tbl);
+		kfree(ipsec->rx_tbl);
+		kfree(ipsec->tx_tbl);
+		kfree(adapter->ipsec);
+	}
+	netdev_err(adapter->netdev, "Unable to allocate memory for SA tables");
 }
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 51fb3cf..01fd89b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -10542,6 +10542,12 @@ static void ixgbe_remove(struct pci_dev *pdev)
 	set_bit(__IXGBE_REMOVING, &adapter->state);
 	cancel_work_sync(&adapter->service_task);
 
+#ifdef CONFIG_XFRM
+	kfree(adapter->ipsec->ip_tbl);
+	kfree(adapter->ipsec->rx_tbl);
+	kfree(adapter->ipsec->tx_tbl);
+	kfree(adapter->ipsec);
+#endif /* CONFIG_XFRM */
 
 #ifdef CONFIG_IXGBE_DCA
 	if (adapter->flags & IXGBE_FLAG_DCA_ENABLED) {
-- 
2.7.4

