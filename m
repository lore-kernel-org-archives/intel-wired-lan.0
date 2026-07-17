Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90743C44512
	for <intel-wired-lan@archiver.kernel.org>; Fri, 17 Jul 2026 01:31:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B80280E57;
	Fri, 17 Jul 2026 01:31:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qz7DugA1aEl9; Fri, 17 Jul 2026 01:31:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AEEB380E4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784251870;
	bh=sA7U4b+vFXSsH7TqJ+plYP0tiCCY2l8ez4Vr1KEL+Vk=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=8fFKA2GKz3ES8pggjMrs7DTHY4xnB3gF7O07IGbVWSjVIRkSJgbtOY8SJ2UNoNGJA
	 jD5a1Jz7QxpOrbIPtdqa5xG7be0oJTI8qHuakvBafXVoOODGEJD/MG0fzs6sVNHboq
	 +szzCisgLcuHlFQKuNFsPaKYBDqiR3MtPedZPnPYvyDsqVpUMvbe08Uj/eDXMTfUHU
	 no2ENyh6OjhoavUE2raQEdDN2YuNWUBbR4omlhDli03+8VVMaqDAYWZSDm1NmOJDhZ
	 q+O53ilF9R4fUia+P+dCIQE0coBN/5SIxGaXxjSwzGa8rTQUudd1ibA+8ymH9lqp1D
	 6VWioReP5x8/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AEEB380E4A;
	Fri, 17 Jul 2026 01:31:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 13B4C1F6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Jul 2026 01:31:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 05693403D0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Jul 2026 01:31:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x1l38oNvyyA8 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 17 Jul 2026 01:31:08 +0000 (UTC)
X-Greylist: delayed 385 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 17 Jul 2026 01:31:05 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6642740025
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6642740025
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.173;
 helo=out-173.mta1.migadu.com; envelope-from=chenguang.zhao@linux.dev;
 receiver=<UNKNOWN> 
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com
 [95.215.58.173])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6642740025
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Jul 2026 01:31:04 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 chenguang.zhao@linux.dev, Chenguang Zhao <zhaochenguang@kylinos.cn>
Date: Fri, 17 Jul 2026 09:24:16 +0800
Message-Id: <20260717012416.168107-1-chenguang.zhao@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1784251477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=sA7U4b+vFXSsH7TqJ+plYP0tiCCY2l8ez4Vr1KEL+Vk=;
 b=jSa32VAbYXdOgKnrETgjAy4RzGZYDl3WcdaJscwm+Q2TgEt2YpDS/3YwjOBoWwOiPeM0Wy
 tMsveK7SzogqqlPbRlEnt6nVrVVows7mWzz81mVhOtzADrwXKzTKT95atIAHp0CorT3Y0m
 F2mW5XC7dKN08DnQPGsgdYFZb+3HI7o=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=jSa32VAb
Subject: [Intel-wired-lan] [PATCH net v2] i40e: xsk: fix multi-buffer
 XDP_PASS skb construction
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

When AF_XDP ZC receives a multi-buffer frame and XDP returns XDP_PASS,
i40e_construct_skb_zc() copied frags incorrectly: memcpy used
skb_frag_page() (page metadata) and __skb_fill_page_desc_noacc() was
given a virtual address instead of a struct page *.

Drop the custom helper and use xdp_build_skb_from_zc() instead. On
failure, free the xdp buff in the caller. Push the Ethernet header
back before eth_skb_pad()/i40e_process_skb_fields() because
xdp_build_skb_from_zc() already called eth_type_trans().

Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
Revised as suggested by Maciej:
 - Replace i40e_construct_skb_zc() with xdp_build_skb_from_zc()

v1:
 https://lore.kernel.org/all/20260714025112.284724-1-chenguang.zhao@linux.dev/

 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 73 +++-------------------
 1 file changed, 8 insertions(+), 65 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 9f47388eaba5..1319a5c22625 100644
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
@@ -372,14 +309,20 @@ static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
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
 
+		/* xdp_build_skb_from_zc() already ran eth_type_trans();
+		 * restore the header for eth_skb_pad()/process_skb_fields().
+		 */
+		__skb_push(skb, skb->data - skb_mac_header(skb));
+
 		if (eth_skb_pad(skb)) {
 			*rx_packets = 0;
 			*rx_bytes = 0;
-- 
2.25.1

