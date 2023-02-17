Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D09C05027
	for <intel-wired-lan@archiver.kernel.org>; Fri, 17 Feb 2023 19:56:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 24CBA40AE2;
	Fri, 17 Feb 2023 19:56:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 24CBA40AE2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1676663766;
	bh=QiBPxaQOxNkStYuj6OaJ7q9uOl9PG6CA7Q6NS3SSv7k=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Dv/IUTF/xdvfrHo298txPgBkJ9gQfrxEewFDX+IkiS2P2VF/Iv4MXTWa6EEZ/cXEE
	 2jNKP4WbVQuHZ79kMJ1UyqhXLxu94z5vM00IMMSEnDe+54ilgvJF7aLsuqrk7R1eum
	 oFLRgbp/f9IsEPMDrTNae0vZ+cW27B9xoVpgGH2ejc+0nPU3xvmDY8EN5AtDQSDwZ8
	 BjohgN8K3tqUsR9bWj73XUP0sXyVwvn0gwSUPZUn8p4ECVI2zZjwPzXuZEimdouuna
	 ViOgrxwu1Z12kOa1ou+6sxeefTWGoLNa7cAdaB6FTxPz8VgPYbqujENcCunomZrEQg
	 VIGe03FDc2eKA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v_P_aou8_2FE; Fri, 17 Feb 2023 19:56:05 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id E530E40C85;
	Fri, 17 Feb 2023 19:56:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E530E40C85
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 563C61BF295
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Feb 2023 19:29:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 142C4401D2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Feb 2023 19:29:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 142C4401D2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XoJEgme2wUgk for <intel-wired-lan@lists.osuosl.org>;
 Fri, 17 Feb 2023 19:29:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4A58540AE2
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4A58540AE2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Feb 2023 19:29:50 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="394550057"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; d="scan'208";a="394550057"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2023 11:29:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="701013388"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; d="scan'208";a="701013388"
Received: from unknown (HELO paamrpdk12-S2600BPB.aw.intel.com)
 ([10.228.151.145])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2023 11:29:49 -0800
From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Sat, 18 Feb 2023 00:45:11 +0530
Message-Id: <20230217191515.166819-5-tirthendu.sarkar@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230217191515.166819-1-tirthendu.sarkar@intel.com>
References: <20230217191515.166819-1-tirthendu.sarkar@intel.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 17 Feb 2023 19:55:48 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1676662190; x=1708198190;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=P7FjsWu3MVGBk9JhbCvWu8kJATCkxSj6ISwNnsFzxxU=;
 b=hgZBKGLMdhJfqiyUHjRHSGsL+4/31vc+w6crN5C+TtOFnvYPfQ/o1GXv
 jdvc9sWew4A40mYyejFllgbi42fNv9/IQxTS3q5y8uTDA1FOqtzzoDx9R
 8/aA8AefwWZMZH02dVFv/Q5smzDO6FX8J12RNy02mj8KHPLRNg+uvuRKj
 CospDzVw2ObJaKFV1l0ctaO73RuCpb5LOBNi22/PAwSka6QzjzM8htr38
 gtBeXjcIbqKBYdLime8DL99uJDuLoXaIluSb+McZtyvDNvDER7sq9A1HF
 YVo4Cy8nNhy54q98FmQNHU0KaZtpAf3SC6N2/lqgxeOXgTiilnFBt0X0n
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=hgZBKGLM
Subject: [Intel-wired-lan] [PATCH intel-next v6 4/8] i40e: Change size to
 truesize when using i40e_rx_buffer_flip()
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: tirthendu.sarkar@intel.com, netdev@vger.kernel.org,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com, bpf@vger.kernel.org,
 magnus.karlsson@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Truesize is now passed directly to i40e_rx_buffer_flip() instead of size
so that it does not need to recalculate truesize from size using
i40e_rx_frame_truesize() before adjusting page offset.

With these change the function can now be used during skb building and
adding frags. In later patches it will also be easier for adjusting
page offsets for multi-buffers.

Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 54 ++++++++-------------
 1 file changed, 19 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index a7fba294a8f4..019abd7273a2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2018,6 +2018,21 @@ static bool i40e_can_reuse_rx_page(struct i40e_rx_buffer *rx_buffer,
 	return true;
 }
 
+/**
+ * i40e_rx_buffer_flip - adjusted rx_buffer to point to an unused region
+ * @rx_buffer: Rx buffer to adjust
+ * @size: Size of adjustment
+ **/
+static void i40e_rx_buffer_flip(struct i40e_rx_buffer *rx_buffer,
+				unsigned int truesize)
+{
+#if (PAGE_SIZE < 8192)
+	rx_buffer->page_offset ^= truesize;
+#else
+	rx_buffer->page_offset += truesize;
+#endif
+}
+
 /**
  * i40e_add_rx_frag - Add contents of Rx buffer to sk_buff
  * @rx_ring: rx descriptor ring to transact packets on
@@ -2045,11 +2060,7 @@ static void i40e_add_rx_frag(struct i40e_ring *rx_ring,
 			rx_buffer->page_offset, size, truesize);
 
 	/* page is being used so we must update the page offset */
-#if (PAGE_SIZE < 8192)
-	rx_buffer->page_offset ^= truesize;
-#else
-	rx_buffer->page_offset += truesize;
-#endif
+	i40e_rx_buffer_flip(rx_buffer, truesize);
 }
 
 /**
@@ -2154,11 +2165,7 @@ static struct sk_buff *i40e_construct_skb(struct i40e_ring *rx_ring,
 				size, truesize);
 
 		/* buffer is used by skb, update page_offset */
-#if (PAGE_SIZE < 8192)
-		rx_buffer->page_offset ^= truesize;
-#else
-		rx_buffer->page_offset += truesize;
-#endif
+		i40e_rx_buffer_flip(rx_buffer, truesize);
 	} else {
 		/* buffer is unused, reset bias back to rx_buffer */
 		rx_buffer->pagecnt_bias++;
@@ -2209,11 +2216,7 @@ static struct sk_buff *i40e_build_skb(struct i40e_ring *rx_ring,
 		skb_metadata_set(skb, metasize);
 
 	/* buffer is used by skb, update page_offset */
-#if (PAGE_SIZE < 8192)
-	rx_buffer->page_offset ^= truesize;
-#else
-	rx_buffer->page_offset += truesize;
-#endif
+	i40e_rx_buffer_flip(rx_buffer, truesize);
 
 	return skb;
 }
@@ -2326,25 +2329,6 @@ static int i40e_run_xdp(struct i40e_ring *rx_ring, struct xdp_buff *xdp, struct
 	return result;
 }
 
-/**
- * i40e_rx_buffer_flip - adjusted rx_buffer to point to an unused region
- * @rx_ring: Rx ring
- * @rx_buffer: Rx buffer to adjust
- * @size: Size of adjustment
- **/
-static void i40e_rx_buffer_flip(struct i40e_ring *rx_ring,
-				struct i40e_rx_buffer *rx_buffer,
-				unsigned int size)
-{
-	unsigned int truesize = i40e_rx_frame_truesize(rx_ring, size);
-
-#if (PAGE_SIZE < 8192)
-	rx_buffer->page_offset ^= truesize;
-#else
-	rx_buffer->page_offset += truesize;
-#endif
-}
-
 /**
  * i40e_xdp_ring_update_tail - Updates the XDP Tx ring tail register
  * @xdp_ring: XDP Tx ring
@@ -2513,7 +2497,7 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget,
 		if (xdp_res) {
 			if (xdp_res & (I40E_XDP_TX | I40E_XDP_REDIR)) {
 				xdp_xmit |= xdp_res;
-				i40e_rx_buffer_flip(rx_ring, rx_buffer, size);
+				i40e_rx_buffer_flip(rx_buffer, xdp.frame_sz);
 			} else {
 				rx_buffer->pagecnt_bias++;
 			}
-- 
2.34.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
