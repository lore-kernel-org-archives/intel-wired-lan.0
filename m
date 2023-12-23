Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B9FC46CD4
	for <intel-wired-lan@archiver.kernel.org>; Sat, 23 Dec 2023 02:58:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C77742D23;
	Sat, 23 Dec 2023 02:58:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9C77742D23
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1703300339;
	bh=tJVNGgCGonBS7IE4QqWhjdQo6q8Ywi/3Hdz8bK+WZb8=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=HDZfacsbiEU8MQNUrU3KL/4qsdwyTJqvQipUu9rVJitNiCdMCR1l+3l1uFAft4uPo
	 FNQ6WYXu52JIgBfbAo0DKfsq9IA/nm9Zz3zvob1gLUicRddDu06HAuw8FAZe4kML54
	 tIhVyiqw8HczWHpuNHLGFpDykxih3t+/kSAqGRUCO9ywZWg7gFo+2hrbW0r5qxkCPK
	 +Ndx6K/myxGx2FaampIMtHnCrybctmW1MpQK/S2gTHdlEphOXrHOqKxX4VlWwnN5kO
	 8ThXvwisdSqS+YIp1bI7OGMbXHxDqHahpXjKiCQuw+JbGRea8n/lDtKFrVyOhtP3+J
	 odfCnpFCAaQBQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jM8_h3Y_wV1K; Sat, 23 Dec 2023 02:58:58 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8351D42D2C;
	Sat, 23 Dec 2023 02:58:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8351D42D2C
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 3B1C11BF3EC
 for <intel-wired-lan@lists.osuosl.org>; Sat, 23 Dec 2023 02:58:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 12FE660AFB
 for <intel-wired-lan@lists.osuosl.org>; Sat, 23 Dec 2023 02:58:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 12FE660AFB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WJMeqSqcN5zX for <intel-wired-lan@lists.osuosl.org>;
 Sat, 23 Dec 2023 02:58:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4D6F960634
 for <intel-wired-lan@lists.osuosl.org>; Sat, 23 Dec 2023 02:58:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4D6F960634
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="386610851"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; d="scan'208";a="386610851"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2023 18:58:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; d="scan'208";a="25537480"
Received: from newjersey.igk.intel.com ([10.102.20.203])
 by orviesa001.jf.intel.com with ESMTP; 22 Dec 2023 18:58:39 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Date: Sat, 23 Dec 2023 03:55:30 +0100
Message-ID: <20231223025554.2316836-11-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231223025554.2316836-1-aleksander.lobakin@intel.com>
References: <20231223025554.2316836-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703300323; x=1734836323;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XDKZ7I8YXkzL6jtWwhlWlUnbadwUogykSHePFi5AJXo=;
 b=FzYVt7fYs4AIhFeOmCHkDLB7PPeHpZbK86k0pIJdeZHUNXRGd0EA/gjs
 lESqUWvAYe0PNXZhdWfOci7KdN/ewLMRRbq8NXdIhVwg0+5irZhWw4m8D
 VqKpWMpLPNwq/piX0hekRbgmYoFkluI2zOXcFdwmgrEAGlAFHA/O86vDq
 nJvWgLF9PeAWClUGJgtym2Cw5QMbyBXbXhSloaOilui6vziw/PXsRvQCW
 wa11rCCGtClwsh4iVqVyOszTISH4MzcRKf8VBxK0lrjJk491TU1O8J7RI
 G35MGyWqhMpMMs9ipUEeYn7OGSwiWFaMx7rANpCl67pQzmyhGItJFHLoJ
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=FzYVt7fY
Subject: [Intel-wired-lan] [PATCH RFC net-next 10/34] xdp: constify
 read-only arguments of some static inline helpers
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
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Larysa Zaremba <larysa.zaremba@intel.com>, netdev@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Michal Kubiak <michal.kubiak@intel.com>, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Lots of read-only helpers for &xdp_buff and &xdp_frame, such as getting
the frame length, skb_shared_info etc., don't have their arguments
marked with `const` for no reason. Add the missing annotations to leave
less place for mistakes and more for optimization.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/xdp.h | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index e6770dd40c91..197808df1ee1 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -88,7 +88,7 @@ struct xdp_buff {
 	u32 flags; /* supported values defined in xdp_buff_flags */
 };
 
-static __always_inline bool xdp_buff_has_frags(struct xdp_buff *xdp)
+static __always_inline bool xdp_buff_has_frags(const struct xdp_buff *xdp)
 {
 	return !!(xdp->flags & XDP_FLAGS_HAS_FRAGS);
 }
@@ -103,7 +103,8 @@ static __always_inline void xdp_buff_clear_frags_flag(struct xdp_buff *xdp)
 	xdp->flags &= ~XDP_FLAGS_HAS_FRAGS;
 }
 
-static __always_inline bool xdp_buff_is_frag_pfmemalloc(struct xdp_buff *xdp)
+static __always_inline bool
+xdp_buff_is_frag_pfmemalloc(const struct xdp_buff *xdp)
 {
 	return !!(xdp->flags & XDP_FLAGS_FRAGS_PF_MEMALLOC);
 }
@@ -144,15 +145,16 @@ xdp_prepare_buff(struct xdp_buff *xdp, unsigned char *hard_start,
 	 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
 
 static inline struct skb_shared_info *
-xdp_get_shared_info_from_buff(struct xdp_buff *xdp)
+xdp_get_shared_info_from_buff(const struct xdp_buff *xdp)
 {
 	return (struct skb_shared_info *)xdp_data_hard_end(xdp);
 }
 
-static __always_inline unsigned int xdp_get_buff_len(struct xdp_buff *xdp)
+static __always_inline unsigned int
+xdp_get_buff_len(const struct xdp_buff *xdp)
 {
 	unsigned int len = xdp->data_end - xdp->data;
-	struct skb_shared_info *sinfo;
+	const struct skb_shared_info *sinfo;
 
 	if (likely(!xdp_buff_has_frags(xdp)))
 		goto out;
@@ -177,12 +179,13 @@ struct xdp_frame {
 	u32 flags; /* supported values defined in xdp_buff_flags */
 };
 
-static __always_inline bool xdp_frame_has_frags(struct xdp_frame *frame)
+static __always_inline bool xdp_frame_has_frags(const struct xdp_frame *frame)
 {
 	return !!(frame->flags & XDP_FLAGS_HAS_FRAGS);
 }
 
-static __always_inline bool xdp_frame_is_frag_pfmemalloc(struct xdp_frame *frame)
+static __always_inline bool
+xdp_frame_is_frag_pfmemalloc(const struct xdp_frame *frame)
 {
 	return !!(frame->flags & XDP_FLAGS_FRAGS_PF_MEMALLOC);
 }
@@ -201,7 +204,7 @@ static __always_inline void xdp_frame_bulk_init(struct xdp_frame_bulk *bq)
 }
 
 static inline struct skb_shared_info *
-xdp_get_shared_info_from_frame(struct xdp_frame *frame)
+xdp_get_shared_info_from_frame(const struct xdp_frame *frame)
 {
 	void *data_hard_start = frame->data - frame->headroom - sizeof(*frame);
 
@@ -249,7 +252,8 @@ int xdp_alloc_skb_bulk(void **skbs, int n_skb, gfp_t gfp);
 struct xdp_frame *xdpf_clone(struct xdp_frame *xdpf);
 
 static inline
-void xdp_convert_frame_to_buff(struct xdp_frame *frame, struct xdp_buff *xdp)
+void xdp_convert_frame_to_buff(const struct xdp_frame *frame,
+			       struct xdp_buff *xdp)
 {
 	xdp->data_hard_start = frame->data - frame->headroom - sizeof(*frame);
 	xdp->data = frame->data;
@@ -260,7 +264,7 @@ void xdp_convert_frame_to_buff(struct xdp_frame *frame, struct xdp_buff *xdp)
 }
 
 static inline
-int xdp_update_frame_from_buff(struct xdp_buff *xdp,
+int xdp_update_frame_from_buff(const struct xdp_buff *xdp,
 			       struct xdp_frame *xdp_frame)
 {
 	int metasize, headroom;
@@ -317,9 +321,10 @@ void xdp_flush_frame_bulk(struct xdp_frame_bulk *bq);
 void xdp_return_frame_bulk(struct xdp_frame *xdpf,
 			   struct xdp_frame_bulk *bq);
 
-static __always_inline unsigned int xdp_get_frame_len(struct xdp_frame *xdpf)
+static __always_inline unsigned int
+xdp_get_frame_len(const struct xdp_frame *xdpf)
 {
-	struct skb_shared_info *sinfo;
+	const struct skb_shared_info *sinfo;
 	unsigned int len = xdpf->len;
 
 	if (likely(!xdp_frame_has_frags(xdpf)))
-- 
2.43.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
