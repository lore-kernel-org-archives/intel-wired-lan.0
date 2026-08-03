Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1CDC55175
	for <intel-wired-lan@archiver.kernel.org>; Mon,  3 Aug 2026 09:18:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D7F6380CB6;
	Mon,  3 Aug 2026 09:18:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sqpy6wrR_8BH; Mon,  3 Aug 2026 09:18:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 19B8F80CA8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785748693;
	bh=ulk/V5btxwZtrABJCFPtp34M9DhWLr2JqKEP4dSpjm0=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=43vydEO2YnDyyN8zBtXd41SrD7bMNpkACdY5u+bSuQX+mRiHZs73/JiuUuVguRDDS
	 wXiz3E7NyQeTw3v7qVOQms6pFeqzTQc8y8iY5Daul/U/f2uFQvTNuzzKJtk98OKzp6
	 IqwkcjVzLuMhAbGpDFPbLPZPvnm/xdq+ww7D8G9ytWvCIP1VyexkFuSiLXrKTWefk+
	 pEDhhjpZRcrn2Cg0bCftX1kOwlLWTplWdjd6dQX9y9jL4aC5FzvfNo4pWYbmnorP3/
	 VXPR8Y6RQkszukRekU5fbo0fUTfZ2LIRyjZyi0n45kn/85J2Hy36IeYX3vvMt5E1gs
	 Fbr23vO6EItvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19B8F80CA8;
	Mon,  3 Aug 2026 09:18:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 021A4350
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Aug 2026 09:18:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F295840077
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Aug 2026 09:18:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yokqwPDRwM-M for <intel-wired-lan@lists.osuosl.org>;
 Mon,  3 Aug 2026 09:18:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:41d0:1004:224b::b5; helo=out-181.mta0.migadu.com;
 envelope-from=chenguang.zhao@linux.dev; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 394F440024
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 394F440024
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 394F440024
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Aug 2026 09:18:08 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 chenguang.zhao@linux.dev, kerneljasonxing@gmail.com,
 Chenguang Zhao <zhaochenguang@kylinos.cn>,
 Mohsin Bashir <hmohsin@meta.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Date: Mon,  3 Aug 2026 17:17:50 +0800
Message-Id: <20260803091750.1084506-1-chenguang.zhao@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1785748680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ulk/V5btxwZtrABJCFPtp34M9DhWLr2JqKEP4dSpjm0=;
 b=Bg+6RgDijOkwXUJPp4GVGi70cGWLskShR3XreGCMRium3XJcWTtrE9nTjtnWh8q5UXSe2X
 r3ZHso5ZIU8N8VcscYibz9jBqrgzNLIY9W/YJNfOvVz3ePSrogEjlIKDscLrYTSa0gmu7r
 vNGocEPYiNoKzioXgoCaRjhjcR7dM6Q=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=Bg+6RgDi
Subject: [Intel-wired-lan] [PATCH net-next v4] i40e: xsk: use
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

Select PAGE_POOL in Kconfig, since xdp_build_skb_from_zc() returns
NULL when page pool support is disabled.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
Reviewed-by: Mohsin Bashir <hmohsin@meta.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
---
v4:
- As suggested by Mohsin:
  Select PAGE_POOL in I40E Kconfig so xdp_build_skb_from_zc() cannot
  return NULL due to CONFIG_PAGE_POOL=n and drop XDP_PASS packets.

v3:
 - https://lore.kernel.org/all/20260731020736.170485-1-chenguang.zhao@linux.dev/

v2:
 - https://lore.kernel.org/all/20260729054916.720750-1-chenguang.zhao@linux.dev/

v1:
 - https://lore.kernel.org/all/20260724020125.246333-1-chenguang.zhao@linux.dev/
---
 drivers/net/ethernet/intel/Kconfig            |  1 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 32 ++++++--
 .../ethernet/intel/i40e/i40e_txrx_common.h    |  2 +
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 79 ++-----------------
 4 files changed, 34 insertions(+), 80 deletions(-)

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 288fa8ce53af..75d1ad6e361d 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -234,6 +234,7 @@ config I40E
 	select LIBIE
 	select LIBIE_ADMINQ
 	select NET_DEVLINK
+	select PAGE_POOL
 	help
 	  This driver supports Intel(R) Ethernet Controller XL710 Family of
 	  devices.  For more information on how to identify your adapter, go
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

