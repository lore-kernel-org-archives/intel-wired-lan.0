Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F755C61DA4
	for <intel-wired-lan@archiver.kernel.org>; Tue, 14 Feb 2023 16:21:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B0D2C408F0;
	Tue, 14 Feb 2023 16:21:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B0D2C408F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1676391675;
	bh=QiBPxaQOxNkStYuj6OaJ7q9uOl9PG6CA7Q6NS3SSv7k=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Xd0Go0b5PgC+bNnBquCHDsuEcOWwzEMbT26A92cjaHRQ4vsScvATVsLiXMjBCIzcu
	 zGGA82x9OVUDtoSfhyYCQN94qwnwdeN8jT1PPF+kzKo58DKWKAGeX6Xmcb9EfnWsUS
	 J/jb0dpsMWTO5cNZJkRHvoQ5/jpatQnKvghnz2/RHrKsXvqj3Il2aFYXfDuf84wbqB
	 XMmnM/yQzq8ZfXQHsqdDhUK5JtKGz5Vs3P23fJA97YkEoymdzLSmTSL8P9T0CvL4EF
	 RPWwb3qwgmMpaCqTX7lz5R6N7mdzkjfvvQCuVaa8I02yXZKADO14SZptywJrfYju+n
	 0lObx4S97bq+Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yoQBcXTYHR76; Tue, 14 Feb 2023 16:21:14 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1508D40900;
	Tue, 14 Feb 2023 16:21:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1508D40900
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 689841BF3A6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Feb 2023 12:44:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4DF894091C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Feb 2023 12:44:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4DF894091C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SC1pm5M_BKi9 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 14 Feb 2023 12:44:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5C9D140929
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5C9D140929
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Feb 2023 12:44:46 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="417371195"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; d="scan'208";a="417371195"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Feb 2023 04:44:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="778308604"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; d="scan'208";a="778308604"
Received: from unknown (HELO paamrpdk12-S2600BPB.aw.intel.com)
 ([10.228.151.145])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Feb 2023 04:44:45 -0800
From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue, 14 Feb 2023 18:00:14 +0530
Message-Id: <20230214123018.54386-5-tirthendu.sarkar@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230214123018.54386-1-tirthendu.sarkar@intel.com>
References: <20230214123018.54386-1-tirthendu.sarkar@intel.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 14 Feb 2023 16:20:51 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1676378686; x=1707914686;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=P7FjsWu3MVGBk9JhbCvWu8kJATCkxSj6ISwNnsFzxxU=;
 b=EQeqMJTQAHy3ynkDgRaN/J3aYrgVpFBgP/3290u7iXaLRSk9nuGef2qi
 HXJmnHJpuV0S9jhThpkF6lyr9mz+4+RDTXH1Z8fjytylTLGqz8aOXeIAS
 h93thBc16MszU/5ffUCv9KDA1GTwNCPctkgfSDm6oyo6+3QC4b7NZ/hLC
 nC+Qg6JY4TkWKuuc76P21y41LXk8Xt+t5gTld+OjDBShhru6YDt9mtcHK
 OswVPSb0KxoHha93wmxucANU3e2Wu9aqKnMeahhZ1Jz8B+AHDPOIC/0CM
 iDOTVR689BAzr9RuoYoW/kVxPReslfOvMXBkWzX9i3rJSWnICkN2jTPhr
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=EQeqMJTQ
Subject: [Intel-wired-lan] [PATCH intel-next v3 4/8] i40e: Change size to
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
