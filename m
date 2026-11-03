Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BCE606A32C
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=WZ4hAfCy;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=S/4fV7ta
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D52DA606C1;
	Tue,  3 Nov 2026 16:23:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2AGlaXdSfFsi; Tue,  3 Nov 2026 16:23:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1D8C1606C2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793723018;
	b=TWd1Dz7b7+hQ84257h7awARK4YvxZCnudHv2LoFPt6n82LY9/LDGEi0+8VXwTbeWv0UL
	 c5HMY5+/SzjEp0l/Ua0egYZNZYHkopgEGzVxT/+Y1Ekjyjxf6F81NS7Zc020G1COvOX4l
	 UNi/EaoenpOhPeYODf9hzk/Q2IDPeKSnKM6qXNHIimCNhHGmsShMVQjLIllhMxgJSJxxr
	 HdhYtH/Kl1lcoHDrv8bH2Rsme8rrOToyl+sraxh2gg42aKa72FIbLFZS6xJOC+SVMA+Wc
	 fsXrYwI53Vo2AhfRSYIVdeel1PRTGhCDr4V2J9/aPVG63H82ml066RstW2F3bag/Y7w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793723018;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 Date:In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:
	 From:To:Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wEvpZVnmD8tz2rAl92pJSmTNVQbWDPHgUyrWXimakhw=;
	b=XgFj+/eOQx1ac2HjV0nJ8z/C99vMwbVexIvYDKeECXDS7dudYID7tCPZ8nFlV6tmJp7Z
	 8xLO/I7WL4uV1vIQOUtyaf9CigfWtA8si1lKq7LoiToLIQ1rQQajEFRKUOGAyT74xIMRW
	 mYxJmfBMzcUe1as4JU3BURGMUxiELCmxLjivkgtQABdMQYPRt8FSaDB9AOB6+gRWLbJtf
	 sKr8lDmF9XxbBvZcvJoL8MifiLgwmTD+GYz1eRHHJkng4/DeIm+Vhp7dlKvCaAaBfoxr5
	 5LB05ohyc3WDHrg6IyQAp6QGcY/3BR3tMTC7P0Resbn+1D0ahWbElB9FuKGAIVx9ZuQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793723018;
	bh=wEvpZVnmD8tz2rAl92pJSmTNVQbWDPHgUyrWXimakhw=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WZ4hAfCy0VjRqQYpVTyUXp6bAGrZOYExmUvBStKuM3bPF7B3afFwxorruj8cUh8Pd
	 XRTHj3a7isgRuEyRmacO2QsyEEWpvWSNRITdcikCjREvMBMWUXYo2sSlkoiEJ5P+sJ
	 TnaLlUuBw11IUo+nApbMrnRPOTwDHul0bmBXPjfrlsufF5o4wIml+iPq3M9aVyLkhC
	 8UFStq3SsZaP5XjuoF1TOlCoKSb4NJadqC+oeP8Raukw49DyXYTUixNsiwb9Xovl5R
	 Y3WXFkKwfmzLTCh0ceRUzMkQyo9SQAURs1oi//jKkAXZafjulF384rNjiF89dOYhSR
	 ZO1zX1aOn5DLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D8C1606C2;
	Tue,  3 Nov 2026 16:23:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A50E235
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 16:23:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F2EE440718
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 16:23:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZXH4kL6KXVss for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 16:23:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DD84340704
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::648"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793723014;
 b=Wi6lcDtM2G9DL/3dvczOJmJRM9MvRfYHp3YjBXofVqt352UyN2P9sBTDGQO7z2GMaaba
 0FO76rrCWhJvj5jJWQUjfXcHGXJ/IvLZFsl9v6eteslBlCRw2dDxJXKkSeA6IBKwNLWwh
 o0keiLaUSpTgkYfu9ctRTg+3KaJ47RV661mEhIY38s5RbzUeqQqIB2da4IPOWBaf0YurN
 u2BiUWN3hycxKb4vtTD3wia0KRVc/wZ2gbxbv+Jr27E4kKBS2M+FyQjIpBY7bRDRbO5iU
 kOqAiBpXXZmsh2FoOodukFWkAG7Zd30YbPh7H1sOM1jIeokpujrmfh+w2vCArLge6+g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793723014;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
 bh=wEvpZVnmD8tz2rAl92pJSmTNVQbWDPHgUyrWXimakhw=;
 b=eMkNNq5nc3j4Ots9u8ptknCfg14RhcTkgHlOTlyyWmolqtOqBKbzYptzUDOOqR9MPYZv
 0XNYcMoPYRw0YrVrEV4HCGCiOdZiGa3vbyHKECAT+QvXjCMTv0gf/qvzUZqdkOb5DOc51
 dtxILTJXmnWToHQE/aXZxpELY6tm/SF6gWpfdciTJKsG3fo5xbbeNeEaM/T2vQ4SU4P3L
 KL0joGqbtVrGMWTNl8TejgrOJav4H0uhByMUUz9BiHOZ4FiOBanOL6xdIxrfPGTjeFQp8
 oi4gS6eYn03ah9OraMbww+PTrxWBAeiUx/HSL8QJX1+9L2cteRFSbLM/DBHPfRDCx1w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=google.com;
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20260707 header.b="S/4fV7ta"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::648"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::648; helo=mail-ej1-x648.google.com;
 envelope-from=3gwrqagykd54jpgxxmemmejc.amkglrcj-ugpcb-j8ljgqrq.mqsmqj.mpe@flex--lrizzo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20260707 header.b=S/4fV7ta
Received: from mail-ej1-x648.google.com (mail-ej1-x648.google.com
 [IPv6:2a00:1450:4864:20::648])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DD84340704
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 16:23:33 +0000 (UTC)
Received: by mail-ej1-x648.google.com with SMTP id
 a640c23a62f3a-c429d9d05f0so346745066b.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 03 Nov 2026 08:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793723011; x=1794327811; darn=lists.osuosl.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wEvpZVnmD8tz2rAl92pJSmTNVQbWDPHgUyrWXimakhw=;
 b=S/4fV7talMfRUfo1ztdY8Oa1KxHyu+Jeu1LcMTsa3k7y4e2zXSrUTPARp5RXtplT55
 t+T2Uulk/U0JWrGtMCdGSqNrpY8P+ch7s/Ne3neSb1DbBdAh5IXOgl7kG7mx4GDQpgeP
 E/lgX6z2rfKsYIws1EznAeI/1X4a9m4U7B7dLAT8aCrg2fjLqX7X2sXSl1up1wBmPqdN
 eZ4DE5+zMEF/hXRVbT9OGjldjma3Ba+5/uOgFrrbHLOhqkPtisTw4PfO8GARq/Mg9lM/
 +MRDXUIBQccv/xU0RNRH+GBRfxzr2KUUv3Mem7fdlCnRx15BkGAF+YedbDO1W9ec6nnR
 xsww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793723011; x=1794327811;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wEvpZVnmD8tz2rAl92pJSmTNVQbWDPHgUyrWXimakhw=;
 b=eDpD2LICZWTc9dzJng+QOyt/uUk3xCbHtIcnj7kjg4WOgBF1eRlQIvDOfiwQ5/AxAg
 WE2QxTOnukEoFIVZvGyzgEdovbNirBvwZ+/Dv5PnEtewu48h6WYZcgN+GgTwT+elMdlE
 KfHhwq3bi/viVRCqUeqXMnazwc/oZX2DWNj5W1zakrYfAh8rqxY6Lv+qwLwg5TPUOHu9
 wiqBlIykx0wVxooCsvkfzQWc7XYJ2G72jvt6Ing6m0+eMVzObsXH2ReYLM+Qtc/ZK+XF
 0s5gXyJBT59IL7jtYnLcD+LuEsZnYkAasvS1Nqw1BrV0Ej+UsFzn7OR3/lsopdmzUI8z
 JK4g==
X-Gm-Message-State: APuU4Z/k7yZCohPxL/ikdh5qQcbuRqDG7cLwj+1hTjhrlJGvLPynwfAD
 kg4qHbW1+IdkMljPfrUBcH081IzYpxsjuHJf3t+cEKKgTU+SwYqfRhZsoBN3pxFAFt9jKefcrx6
 6dJPb+OwH8bBuXjuEHQPKTsU7LYmrRHuap6+eZmIFOSd6c4qCb9GC2LNht8TCYdXGiWZgiDti41
 VRFVNtYvvEKJE7E46wkXYKrVHQBmEFfHq055MCKQiQD2eY6SIo8g==
X-Received: from ejbxj21.prod.google.com ([2002:a17:906:d335:b0:c31:9985:b124])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:7951:b0:c29:22cf:b0f5
 with SMTP id a640c23a62f3a-c4ca7ab1133mr1128153266b.33.1793723011159; Tue, 03
 Nov 2026 08:23:31 -0800 (PST)
Date: Tue,  3 Nov 2026 16:23:25 +0000
In-Reply-To: <20261103162326.3615979-1-lrizzo@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261103162326.3615979-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103162326.3615979-3-lrizzo@google.com>
Subject: [PATCH iwl-next v3 2/2] idpf: use GFP_KERNEL for the initial Rx ring
 fill
From: Luigi Rizzo <lrizzo@google.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Luigi Rizzo <rizzo.unipi@gmail.com>, Brian Vazquez <brianvv@google.com>, 
 Joshua Hay <joshua.a.hay@intel.com>, Larysa Zaremba <larysa.zaremba@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, 
 linux-kernel@vger.kernel.org, Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When idpf fills its Rx rings at open or on queue reconfiguration, the
allocation runs in process context, right after page_pool_create() and
before the queues' NAPI is enabled. Allocating tens of thousands of
buffers across all queues with GFP_ATOMIC is needlessly restrictive
when the caller may sleep.

In splitq mode, idpf_rx_post_buf_desc() is only used for this initial
fill, so switch its header and payload allocations to
__libeth_rx_alloc(..., GFP_KERNEL).

In singleq mode, add a gfp_t parameter to
idpf_rx_singleq_buf_hw_alloc_all() and pass GFP_KERNEL from
idpf_rx_buf_alloc_singleq() and GFP_ATOMIC from idpf_rx_singleq_clean().

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c | 7 ++++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c         | 9 ++++++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h         | 2 +-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index e3ddf18dcbf51..ab5a1e20a37ce 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -885,11 +885,12 @@ static void idpf_rx_buf_hw_update(struct idpf_rx_queue *rxq, u32 val)
  * idpf_rx_singleq_buf_hw_alloc_all - Replace used receive buffers
  * @rx_q: queue for which the hw buffers are allocated
  * @cleaned_count: number of buffers to replace
+ * @gfp: GFP_KERNEL for the initial fill, GFP_ATOMIC from NAPI
  *
  * Returns false if all allocations were successful, true if any fail
  */
 bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_rx_queue *rx_q,
-				      u16 cleaned_count)
+				      u16 cleaned_count, gfp_t gfp)
 {
 	struct virtchnl2_singleq_rx_buf_desc *desc;
 	const struct libeth_fq_fp fq = {
@@ -908,7 +909,7 @@ bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_rx_queue *rx_q,
 	do {
 		dma_addr_t addr;
 
-		addr = libeth_rx_alloc(&fq, nta);
+		addr = __libeth_rx_alloc(&fq, nta, gfp);
 		if (addr == DMA_MAPPING_ERROR)
 			break;
 
@@ -1095,7 +1096,7 @@ static int idpf_rx_singleq_clean(struct idpf_rx_queue *rx_q, int budget)
 
 	page_pool_nid_changed(rx_q->pp, numa_mem_id());
 	if (cleaned_count)
-		idpf_rx_singleq_buf_hw_alloc_all(rx_q, cleaned_count);
+		idpf_rx_singleq_buf_hw_alloc_all(rx_q, cleaned_count, GFP_ATOMIC);
 
 	u64_stats_update_begin(&rx_q->stats_sync);
 	u64_stats_add(&rx_q->q_stats.packets, rs.packets);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 885df6294ad94..0da095738d8d8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -599,6 +599,9 @@ static void idpf_post_buf_refill(struct idpf_sw_queue *refillq, u16 buf_id)
  * @bufq: buffer queue to post to
  * @buf_id: buffer id to post
  *
+ * Only used for the initial fill, from process context, so it allocates
+ * with GFP_KERNEL.
+ *
  * Return: %false if buffer could not be allocated, %true otherwise.
  */
 static bool idpf_rx_post_buf_desc(struct idpf_buf_queue *bufq, u16 buf_id)
@@ -617,7 +620,7 @@ static bool idpf_rx_post_buf_desc(struct idpf_buf_queue *bufq, u16 buf_id)
 		fq.fqes = bufq->hdr_buf;
 		fq.truesize = bufq->hdr_truesize;
 
-		addr = libeth_rx_alloc(&fq, buf_id);
+		addr = __libeth_rx_alloc(&fq, buf_id, GFP_KERNEL);
 		if (addr == DMA_MAPPING_ERROR)
 			return false;
 
@@ -628,7 +631,7 @@ static bool idpf_rx_post_buf_desc(struct idpf_buf_queue *bufq, u16 buf_id)
 	fq.fqes = bufq->buf;
 	fq.truesize = bufq->truesize;
 
-	addr = libeth_rx_alloc(&fq, buf_id);
+	addr = __libeth_rx_alloc(&fq, buf_id, GFP_KERNEL);
 	if (addr == DMA_MAPPING_ERROR)
 		return false;
 
@@ -674,7 +677,7 @@ static bool idpf_rx_post_init_bufs(struct idpf_buf_queue *bufq,
  */
 static int idpf_rx_buf_alloc_singleq(struct idpf_rx_queue *rxq)
 {
-	if (idpf_rx_singleq_buf_hw_alloc_all(rxq, rxq->desc_count - 1))
+	if (idpf_rx_singleq_buf_hw_alloc_all(rxq, rxq->desc_count - 1, GFP_KERNEL))
 		goto err;
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index fe0c913f9bb95..82f0a63f23c34 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -1129,7 +1129,7 @@ netdev_tx_t idpf_tx_singleq_frame(struct sk_buff *skb,
 				  struct idpf_tx_queue *tx_q);
 netdev_tx_t idpf_tx_start(struct sk_buff *skb, struct net_device *netdev);
 bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_rx_queue *rxq,
-				      u16 cleaned_count);
+				      u16 cleaned_count, gfp_t gfp);
 bool idpf_rx_process_skb_fields(struct sk_buff *skb,
 				const struct libeth_xdp_buff *xdp,
 				struct libeth_rq_napi_stats *rs);
-- 
2.56.0.385.gac671c819a-goog

