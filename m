From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon, 13 Aug 2018 11:43:40 -0700
Subject: [Intel-wired-lan] [PATCH next-queue 3/8] ixgbe: add VF ipsec
 management
In-Reply-To: <1534185825-12451-1-git-send-email-shannon.nelson@oracle.com>
References: <1534185825-12451-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <1534185825-12451-4-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add functions to translate VF IPsec offload add and delete requests
into something the existing code can work with.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 256 ++++++++++++++++++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h |  13 ++
 2 files changed, 260 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index 3afb1fe..80108e1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -8,6 +8,8 @@
 #define IXGBE_IPSEC_KEY_BITS  160
 static const char aes_gcm_name[] = "rfc4106(gcm(aes))";
 
+static void ixgbe_ipsec_del_sa(struct xfrm_state *xs);
+
 /**
  * ixgbe_ipsec_set_tx_sa - set the Tx SA registers
  * @hw: hw specific details
@@ -289,6 +291,13 @@ static void ixgbe_ipsec_start_engine(struct ixgbe_adapter *adapter)
 /**
  * ixgbe_ipsec_restore - restore the ipsec HW settings after a reset
  * @adapter: board private structure
+ *
+ * Reload the HW tables from the SW tables after they've been bashed
+ * by a chip reset.
+ *
+ * Any VF entries are removed from the SW and HW tables since either
+ * (a) the VF also gets reset on PF reset and will ask again for the
+ * offloads, or (b) the VF has been removed by a change in the num_vfs.
  **/
 void ixgbe_ipsec_restore(struct ixgbe_adapter *adapter)
 {
@@ -306,16 +315,24 @@ void ixgbe_ipsec_restore(struct ixgbe_adapter *adapter)
 
 	/* reload the Rx and Tx keys */
 	for (i = 0; i < IXGBE_IPSEC_MAX_SA_COUNT; i++) {
-		struct rx_sa *rsa = &ipsec->rx_tbl[i];
-		struct tx_sa *tsa = &ipsec->tx_tbl[i];
-
-		if (rsa->used)
-			ixgbe_ipsec_set_rx_sa(hw, i, rsa->xs->id.spi,
-					      rsa->key, rsa->salt,
-					      rsa->mode, rsa->iptbl_ind);
+		struct rx_sa *r = &ipsec->rx_tbl[i];
+		struct tx_sa *t = &ipsec->tx_tbl[i];
+
+		if (r->used) {
+			if (r->mode & IXGBE_RXTXMOD_VF)
+				ixgbe_ipsec_del_sa(r->xs);
+			else
+				ixgbe_ipsec_set_rx_sa(hw, i, r->xs->id.spi,
+						      r->key, r->salt,
+						      r->mode, r->iptbl_ind);
+		}
 
-		if (tsa->used)
-			ixgbe_ipsec_set_tx_sa(hw, i, tsa->key, tsa->salt);
+		if (t->used) {
+			if (t->mode & IXGBE_RXTXMOD_VF)
+				ixgbe_ipsec_del_sa(t->xs);
+			else
+				ixgbe_ipsec_set_tx_sa(hw, i, t->key, t->salt);
+		}
 	}
 
 	/* reload the IP addrs */
@@ -381,6 +398,8 @@ static struct xfrm_state *ixgbe_ipsec_find_rx_state(struct ixgbe_ipsec *ipsec,
 	rcu_read_lock();
 	hash_for_each_possible_rcu(ipsec->rx_sa_list, rsa, hlist,
 				   (__force u32)spi) {
+		if (rsa->mode & IXGBE_RXTXMOD_VF)
+			continue;
 		if (spi == rsa->xs->id.spi &&
 		    ((ip4 && *daddr == rsa->xs->id.daddr.a4) ||
 		      (!ip4 && !memcmp(daddr, &rsa->xs->id.daddr.a6,
@@ -809,6 +828,225 @@ static const struct xfrmdev_ops ixgbe_xfrmdev_ops = {
 };
 
 /**
+ * ixgbe_ipsec_vf_clear - clear the tables of data for a VF
+ * @adapter: board private structure
+ * @vf: VF id to be removed
+ **/
+void ixgbe_ipsec_vf_clear(struct ixgbe_adapter *adapter, u32 vf)
+{
+	struct ixgbe_ipsec *ipsec = adapter->ipsec;
+	int i;
+
+	/* search rx sa table */
+	for (i = 0; i < IXGBE_IPSEC_MAX_SA_COUNT && ipsec->num_rx_sa; i++) {
+		if (!ipsec->rx_tbl[i].used)
+			continue;
+		if (ipsec->rx_tbl[i].mode & IXGBE_RXTXMOD_VF &&
+		    ipsec->rx_tbl[i].vf == vf)
+			ixgbe_ipsec_del_sa(ipsec->rx_tbl[i].xs);
+	}
+
+	/* search tx sa table */
+	for (i = 0; i < IXGBE_IPSEC_MAX_SA_COUNT && ipsec->num_tx_sa; i++) {
+		if (!ipsec->tx_tbl[i].used)
+			continue;
+		if (ipsec->tx_tbl[i].mode & IXGBE_RXTXMOD_VF &&
+		    ipsec->tx_tbl[i].vf == vf)
+			ixgbe_ipsec_del_sa(ipsec->tx_tbl[i].xs);
+	}
+}
+
+/**
+ * ixgbe_ipsec_vf_add_sa - translate VF request to SA add
+ * @adapter: board private structure
+ * @msgbuf: The message buffer
+ * @vf: the VF index
+ *
+ * Make up a new xs and algorithm info from the data sent by the VF.
+ * We only need to sketch in just enough to set up the HW offload.
+ * Put the resulting offload_handle into the return message to the VF.
+ *
+ * Returns 0 or error value
+ **/
+int ixgbe_ipsec_vf_add_sa(struct ixgbe_adapter *adapter, u32 *msgbuf, u32 vf)
+{
+	struct ixgbe_ipsec *ipsec = adapter->ipsec;
+	struct xfrm_algo_desc *algo;
+	struct sa_mbx_msg *sam;
+	struct xfrm_state *xs;
+	size_t aead_len;
+	u16 sa_idx;
+	u32 pfsa;
+	int err;
+
+	sam = (struct sa_mbx_msg *)(&msgbuf[1]);
+	if (!adapter->vfinfo[vf].trusted) {
+		e_warn(drv, "VF %d attempted to add an IPsec SA\n", vf);
+		err = -EACCES;
+		goto err_out;
+	}
+
+	/* Tx IPsec offload doesn't seem to work on this
+	 * device, so block these requests for now.
+	 */
+	if (!(sam->flags & XFRM_OFFLOAD_INBOUND)) {
+		err = -ENXIO;
+		goto err_out;
+	}
+
+	xs = kzalloc(sizeof(*xs), GFP_KERNEL);
+	if (unlikely(!xs)) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	xs->xso.flags = sam->flags;
+	xs->id.spi = sam->spi;
+	xs->id.proto = sam->proto;
+	xs->props.family = sam->family;
+	if (xs->props.family == AF_INET6)
+		memcpy(&xs->id.daddr.a6, sam->addr, sizeof(xs->id.daddr.a6));
+	else
+		memcpy(&xs->id.daddr.a4, sam->addr, sizeof(xs->id.daddr.a4));
+	xs->xso.dev = adapter->netdev;
+
+	algo = xfrm_aead_get_byname(aes_gcm_name, IXGBE_IPSEC_AUTH_BITS, 1);
+	if (unlikely(!algo)) {
+		err = -ENOENT;
+		goto err_xs;
+	}
+
+	aead_len = sizeof(*xs->aead) + IXGBE_IPSEC_KEY_BITS / 8;
+	xs->aead = kzalloc(aead_len, GFP_KERNEL);
+	if (unlikely(!xs->aead)) {
+		err = -ENOMEM;
+		goto err_xs;
+	}
+
+	xs->props.ealgo = algo->desc.sadb_alg_id;
+	xs->geniv = algo->uinfo.aead.geniv;
+	xs->aead->alg_icv_len = IXGBE_IPSEC_AUTH_BITS;
+	xs->aead->alg_key_len = IXGBE_IPSEC_KEY_BITS;
+	memcpy(xs->aead->alg_key, sam->key, sizeof(sam->key));
+	memcpy(xs->aead->alg_name, aes_gcm_name, sizeof(aes_gcm_name));
+
+	/* set up the HW offload */
+	err = ixgbe_ipsec_add_sa(xs);
+	if (err)
+		goto err_aead;
+
+	pfsa = xs->xso.offload_handle;
+	if (pfsa < IXGBE_IPSEC_BASE_TX_INDEX) {
+		sa_idx = pfsa - IXGBE_IPSEC_BASE_RX_INDEX;
+		ipsec->rx_tbl[sa_idx].vf = vf;
+		ipsec->rx_tbl[sa_idx].mode |= IXGBE_RXTXMOD_VF;
+	} else {
+		sa_idx = pfsa - IXGBE_IPSEC_BASE_TX_INDEX;
+		ipsec->tx_tbl[sa_idx].vf = vf;
+		ipsec->tx_tbl[sa_idx].mode |= IXGBE_RXTXMOD_VF;
+	}
+
+	msgbuf[1] = xs->xso.offload_handle;
+
+	return 0;
+
+err_aead:
+	memset(xs->aead, 0, sizeof(*xs->aead));
+	kfree(xs->aead);
+err_xs:
+	memset(xs, 0, sizeof(*xs));
+	kfree(xs);
+err_out:
+	msgbuf[1] = err;
+	return err;
+}
+
+/**
+ * ixgbe_ipsec_vf_del_sa - translate VF request to SA delete
+ * @adapter: board private structure
+ * @msgbuf: The message buffer
+ * @vf: the VF index
+ *
+ * Given the offload_handle sent by the VF, look for the related SA table
+ * entry and use its xs field to call for a delete of the SA.
+ *
+ * Note: We silently ignore requests to delete entries that are already
+ *       set to unused because when a VF is set to "DOWN", the PF first
+ *       gets a reset and clears all the VF's entries; then the VF's
+ *       XFRM stack sends individual deletes for each entry, which the
+ *       reset already removed.  In the future it might be good to try to
+ *       optimize this so not so many unnecessary delete messages are sent.
+ *
+ * Returns 0 or error value
+ **/
+int ixgbe_ipsec_vf_del_sa(struct ixgbe_adapter *adapter, u32 *msgbuf, u32 vf)
+{
+	struct ixgbe_ipsec *ipsec = adapter->ipsec;
+	struct xfrm_state *xs;
+	u32 pfsa = msgbuf[1];
+	u16 sa_idx;
+
+	if (!adapter->vfinfo[vf].trusted) {
+		e_err(drv, "vf %d attempted to delete an SA\n", vf);
+		return -EPERM;
+	}
+
+	if (pfsa < IXGBE_IPSEC_BASE_TX_INDEX) {
+		struct rx_sa *rsa;
+
+		sa_idx = pfsa - IXGBE_IPSEC_BASE_RX_INDEX;
+		if (sa_idx >= IXGBE_IPSEC_MAX_SA_COUNT) {
+			e_err(drv, "vf %d SA index %d out of range\n",
+			      vf, sa_idx);
+			return -EINVAL;
+		}
+
+		rsa = &ipsec->rx_tbl[sa_idx];
+
+		if (!rsa->used)
+			return 0;
+
+		if (!(rsa->mode & IXGBE_RXTXMOD_VF) ||
+		    rsa->vf != vf) {
+			e_err(drv, "vf %d bad Rx SA index %d\n", vf, sa_idx);
+			return -ENOENT;
+		}
+
+		xs = ipsec->rx_tbl[sa_idx].xs;
+	} else {
+		struct tx_sa *tsa;
+
+		sa_idx = pfsa - IXGBE_IPSEC_BASE_TX_INDEX;
+		if (sa_idx >= IXGBE_IPSEC_MAX_SA_COUNT) {
+			e_err(drv, "vf %d SA index %d out of range\n",
+			      vf, sa_idx);
+			return -EINVAL;
+		}
+
+		tsa = &ipsec->tx_tbl[sa_idx];
+
+		if (!tsa->used)
+			return 0;
+
+		if (!(tsa->mode & IXGBE_RXTXMOD_VF) ||
+		    tsa->vf != vf) {
+			e_err(drv, "vf %d bad Tx SA index %d\n", vf, sa_idx);
+			return -ENOENT;
+		}
+
+		xs = ipsec->tx_tbl[sa_idx].xs;
+	}
+
+	ixgbe_ipsec_del_sa(xs);
+
+	/* remove the xs that was made-up in the add request */
+	memset(xs, 0, sizeof(*xs));
+	kfree(xs);
+
+	return 0;
+}
+
+/**
  * ixgbe_ipsec_tx - setup Tx flags for ipsec offload
  * @tx_ring: outgoing context
  * @first: current data packet
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h
index 9ef7faa..d2b64ff 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h
@@ -26,6 +26,7 @@ enum ixgbe_ipsec_tbl_sel {
 #define IXGBE_RXMOD_PROTO_ESP		0x00000004
 #define IXGBE_RXMOD_DECRYPT		0x00000008
 #define IXGBE_RXMOD_IPV6		0x00000010
+#define IXGBE_RXTXMOD_VF		0x00000020
 
 struct rx_sa {
 	struct hlist_node hlist;
@@ -37,6 +38,7 @@ struct rx_sa {
 	u8  iptbl_ind;
 	bool used;
 	bool decrypt;
+	u32 vf;
 };
 
 struct rx_ip_sa {
@@ -49,8 +51,10 @@ struct tx_sa {
 	struct xfrm_state *xs;
 	u32 key[4];
 	u32 salt;
+	u32 mode;
 	bool encrypt;
 	bool used;
+	u32 vf;
 };
 
 struct ixgbe_ipsec_tx_data {
@@ -67,4 +71,13 @@ struct ixgbe_ipsec {
 	struct tx_sa *tx_tbl;
 	DECLARE_HASHTABLE(rx_sa_list, 10);
 };
+
+struct sa_mbx_msg {
+	__be32 spi;
+	u8 flags;
+	u8 proto;
+	u16 family;
+	__be32 addr[4];
+	u32 key[5];
+};
 #endif /* _IXGBE_IPSEC_H_ */
-- 
2.7.4

