Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5EAC55167
	for <intel-wired-lan@archiver.kernel.org>; Fri, 31 Jul 2026 02:08:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E006B606E5;
	Fri, 31 Jul 2026 02:08:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RHY81yk877Tf; Fri, 31 Jul 2026 02:08:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 871B3606C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785463732;
	bh=hPnWLjsMEg0dSZw07EDvuDAjkz15ZqLKki4UKr/EC3k=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aMDhEmuekhK1LglzKQ48dNxwgEaD0Oo+Q72WTCAzmsvpI2r2RoWxfYrogMibGrKMt
	 n0BP0BFErvLYGhD5j+nbC5XqOB6CGt9oPzkvkQINg3/piOaNPrJaQA0AkcwW1MEq3d
	 qpYmdKyuBp4oyFH6ez+2g+zQZmV3tMe99t7Y/WC5TYq4880QRsvivRIAKqZnXJMByR
	 +hLdnAGoKamyMPSf/UnBZmg7wD3XlD3rzA+9CIohHQZ+Ujb46H+jHqgZ0U4LVVdPyZ
	 5tfOn8yA+anAjgdfz17eFQVOMrnVT6KA8mG5+S0+7tO0Wz7qYQTC4OaosjMZSu+vne
	 wUYIMYN13Z+lw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 871B3606C2;
	Fri, 31 Jul 2026 02:08:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 73F90197
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 02:08:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 718A94017B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 02:08:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id btePOhNVFk1V for <intel-wired-lan@lists.osuosl.org>;
 Fri, 31 Jul 2026 02:08:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:41d0:1004:224b::b1; helo=out-177.mta0.migadu.com;
 envelope-from=chenguang.zhao@linux.dev; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6F7654007B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6F7654007B
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6F7654007B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 02:08:48 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 chenguang.zhao@linux.dev, kerneljasonxing@gmail.com,
 Chenguang Zhao <zhaochenguang@kylinos.cn>
Date: Fri, 31 Jul 2026 10:07:36 +0800
Message-Id: <20260731020736.170485-1-chenguang.zhao@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1785463725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=hPnWLjsMEg0dSZw07EDvuDAjkz15ZqLKki4UKr/EC3k=;
 b=siIH7f4SWicOmKaSNHGclLiA8iQHGZfKz3uOlTpudHjavFjR4lAHafyS+h7x8xNvzDXf0d
 RP26QWdRQ7nFwz0qqtUZGeqZoNAy8It2b60eq5VKpHx9NL6dj1umcYxOjkVXDWlqD3ziKW
 2QJ6aCmsa2dVfKu3kk1Rll5optcDpZY=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=siIH7f4S
Subject: [Intel-wired-lan] [PATCH net-next v3] i40e: xsk: use
 xdp_build_skb_from_zc() for XDP_PASS
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
 <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

Replace the driver-local i40e_construct_skb_zc() with the common
helper xdp_build_skb_from_zc(). On failure, free the xdp buff in
the caller.

xdp_build_skb_from_zc() already calls skb_record_rx_queue() and
eth_type_trans(), so pull the remaining descriptor field setup into
__i40e_process_skb_fields() and use that on the XDP_PASS path.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
v3:
 As suggested by Larysa:
 - Drop eth_skb_pad() on the XDP_PASS path, along with the
   temporary __skb_push()/__skb_pull() around it. The stack
   handles short skbs and other vendors do not pad on Rx.

v2:
 - https://lore.kernel.org/all/20260729054916.720750-1-chenguang.zhao@linux.dev/

v1:
 - https://lore.kernel.org/all/20260724020125.246333-1-chenguang.zhao@linux.dev/
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 32 ++++++--
 .../ethernet/intel/i40e/i40e_txrx_common.h    |  2 +
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 79 ++-----------------
 3 files changed, 33 insertions(+), 80 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index ef5e657816f0..87553b14d34a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1833,17 +1833,17 @@ static inline void i40e_rx_hash(struct i40e_ring *ring,
 }
 
 /**
- * i40e_process_skb_fields - Populate skb header fields from Rx descriptor
+ * __i40e_process_skb_fields - Populate skb fields from Rx descriptor
  * @rx_ring: rx descriptor ring packet is being transacted on
  * @rx_desc: pointer to the EOP Rx descriptor
  * @skb: pointer to current skb being populated
  *
- * This function checks the ring, descriptor, and packet information in
- * order to populate the hash, checksum, VLAN, protocol, and
- * other fields within the skb.
+ * Populate hash, checksum, PTP timestamp and VLAN from @rx_desc. Does not
+ * call skb_record_rx_queue() or eth_type_trans(); callers that already got
+ * those from xdp_build_skb_from_zc() should use this helper.
  **/
-void i40e_process_skb_fields(struct i40e_ring *rx_ring,
-			     union i40e_rx_desc *rx_desc, struct sk_buff *skb)
+void __i40e_process_skb_fields(struct i40e_ring *rx_ring,
+			       union i40e_rx_desc *rx_desc, struct sk_buff *skb)
 {
 	u64 qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
 	u32 rx_status = FIELD_GET(I40E_RXD_QW1_STATUS_MASK, qword);
@@ -1858,14 +1858,30 @@ void i40e_process_skb_fields(struct i40e_ring *rx_ring,
 
 	i40e_rx_checksum(rx_ring->vsi, skb, rx_desc);
 
-	skb_record_rx_queue(skb, rx_ring->queue_index);
-
 	if (qword & BIT(I40E_RX_DESC_STATUS_L2TAG1P_SHIFT)) {
 		__le16 vlan_tag = rx_desc->wb.qword0.lo_dword.l2tag1;
 
 		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
 				       le16_to_cpu(vlan_tag));
 	}
+}
+
+/**
+ * i40e_process_skb_fields - Populate skb header fields from Rx descriptor
+ * @rx_ring: rx descriptor ring packet is being transacted on
+ * @rx_desc: pointer to the EOP Rx descriptor
+ * @skb: pointer to current skb being populated
+ *
+ * This function checks the ring, descriptor, and packet information in
+ * order to populate the hash, checksum, VLAN, protocol, and
+ * other fields within the skb.
+ **/
+void i40e_process_skb_fields(struct i40e_ring *rx_ring,
+			     union i40e_rx_desc *rx_desc, struct sk_buff *skb)
+{
+	__i40e_process_skb_fields(rx_ring, rx_desc, skb);
+
+	skb_record_rx_queue(skb, rx_ring->queue_index);
 
 	/* modifies the skb - consumes the enet header */
 	skb->protocol = eth_type_trans(skb, rx_ring->netdev);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
index e26807fd2123..3c52e0e60487 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
@@ -9,6 +9,8 @@
 int i40e_xmit_xdp_tx_ring(struct xdp_buff *xdp, struct i40e_ring *xdp_ring);
 void i40e_clean_programming_status(struct i40e_ring *rx_ring, u64 qword0_raw,
 				   u64 qword1);
+void __i40e_process_skb_fields(struct i40e_ring *rx_ring,
+			       union i40e_rx_desc *rx_desc, struct sk_buff *skb);
 void i40e_process_skb_fields(struct i40e_ring *rx_ring,
 			     union i40e_rx_desc *rx_desc, struct sk_buff *skb);
 void i40e_xdp_ring_update_tail(struct i40e_ring *xdp_ring);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 9f47388eaba5..dfa519c30a0d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -3,6 +3,7 @@
 
 #include <linux/bpf_trace.h>
 #include <linux/unroll.h>
+#include <net/xdp.h>
 #include <net/xdp_sock_drv.h>
 #include "i40e_txrx_common.h"
 #include "i40e_xsk.h"
@@ -277,70 +278,6 @@ bool i40e_alloc_rx_buffers_zc(struct i40e_ring *rx_ring, u16 count)
 	return count == nb_buffs;
 }
 
-/**
- * i40e_construct_skb_zc - Create skbuff from zero-copy Rx buffer
- * @rx_ring: Rx ring
- * @xdp: xdp_buff
- *
- * This functions allocates a new skb from a zero-copy Rx buffer.
- *
- * Returns the skb, or NULL on failure.
- **/
-static struct sk_buff *i40e_construct_skb_zc(struct i40e_ring *rx_ring,
-					     struct xdp_buff *xdp)
-{
-	unsigned int totalsize = xdp->data_end - xdp->data_meta;
-	unsigned int metasize = xdp->data - xdp->data_meta;
-	struct skb_shared_info *sinfo = NULL;
-	struct sk_buff *skb;
-	u32 nr_frags = 0;
-
-	if (unlikely(xdp_buff_has_frags(xdp))) {
-		sinfo = xdp_get_shared_info_from_buff(xdp);
-		nr_frags = sinfo->nr_frags;
-	}
-	net_prefetch(xdp->data_meta);
-
-	/* allocate a skb to store the frags */
-	skb = napi_alloc_skb(&rx_ring->q_vector->napi, totalsize);
-	if (unlikely(!skb))
-		goto out;
-
-	memcpy(__skb_put(skb, totalsize), xdp->data_meta,
-	       ALIGN(totalsize, sizeof(long)));
-
-	if (metasize) {
-		skb_metadata_set(skb, metasize);
-		__skb_pull(skb, metasize);
-	}
-
-	if (likely(!xdp_buff_has_frags(xdp)))
-		goto out;
-
-	for (int i = 0; i < nr_frags; i++) {
-		struct skb_shared_info *skinfo = skb_shinfo(skb);
-		skb_frag_t *frag = &sinfo->frags[i];
-		struct page *page;
-		void *addr;
-
-		page = dev_alloc_page();
-		if (!page) {
-			dev_kfree_skb(skb);
-			return NULL;
-		}
-		addr = page_to_virt(page);
-
-		memcpy(addr, skb_frag_page(frag), skb_frag_size(frag));
-
-		__skb_fill_page_desc_noacc(skinfo, skinfo->nr_frags++,
-					   addr, 0, skb_frag_size(frag));
-	}
-
-out:
-	xsk_buff_free(xdp);
-	return skb;
-}
-
 static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
 				      struct xdp_buff *xdp_buff,
 				      union i40e_rx_desc *rx_desc,
@@ -372,21 +309,19 @@ static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
 		 * BIT(I40E_RXD_QW1_ERROR_SHIFT). This is due to that
 		 * SBP is *not* set in PRT_SBPVSI (default not set).
 		 */
-		skb = i40e_construct_skb_zc(rx_ring, xdp_buff);
+		skb = xdp_build_skb_from_zc(xdp_buff);
 		if (!skb) {
+			xsk_buff_free(xdp_buff);
 			rx_ring->rx_stats.alloc_buff_failed++;
 			*rx_packets = 0;
 			*rx_bytes = 0;
 			return;
 		}
 
-		if (eth_skb_pad(skb)) {
-			*rx_packets = 0;
-			*rx_bytes = 0;
-			return;
-		}
-
-		i40e_process_skb_fields(rx_ring, rx_desc, skb);
+		/* xdp_build_skb_from_zc() already ran eth_type_trans() and
+		 * skb_record_rx_queue().
+		 */
+		__i40e_process_skb_fields(rx_ring, rx_desc, skb);
 		napi_gro_receive(&rx_ring->q_vector->napi, skb);
 		return;
 	}
-- 
2.25.1

