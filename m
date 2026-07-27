Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746F0C531D0
	for <intel-wired-lan@archiver.kernel.org>; Mon, 27 Jul 2026 16:20:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4990980C10;
	Mon, 27 Jul 2026 16:20:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pDXVo8vqhAPS; Mon, 27 Jul 2026 16:20:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7E80C80E85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785169208;
	bh=4h2lDbuS6wgFYWmNXWGo5hdv7x4F0DvuiMCZt9z600A=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qrlv0CstIjYFe2eXSEs/LFZ9gaSKiRfvAi/ZC8QoZQ5Z+4pOSpl2DQcRTyR/VIL6N
	 Vak0Q3Z22YRS3vnyPUbGulXMbG4ool8j3uXazqvdedkOZB0uYnv1LvQwDx4+i2/Bw7
	 zmwpL0rg9Jj6B9ywZMsojpjMezDbvvnv0gf3jRj2zaa7itwS6dUD/sNiFmZXvu/OSt
	 D7unaYi2c9FgoJVT1FCmZ0j+NCyal0zxXTJCq7rEVFcaVqU9Tv81Eb1kThvtoUdyyf
	 26bq6cTDiPAdP5bG3F0YscAkQF5nr3bx+Ikn0OHbvB6PdtrxH4x26nzRKwTHj7aQdY
	 poJpqscAwXzAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E80C80E85;
	Mon, 27 Jul 2026 16:20:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E14CB3B1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 16:20:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C72EE4072F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 16:20:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OjTPyYublQzS for <intel-wired-lan@lists.osuosl.org>;
 Mon, 27 Jul 2026 16:20:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::4;
 helo=mail-pj2-x04.google.com; envelope-from=sdf.kernel@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0754F406FC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0754F406FC
Received: from mail-pj2-x04.google.com (mail-pj2-x04.google.com
 [IPv6:2607:f8b0:4864:39::4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0754F406FC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 16:20:04 +0000 (UTC)
Received: by mail-pj2-x04.google.com with SMTP id
 d9443c01a7336-2ccc2e84048so19436285ad.1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 09:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785169204; x=1785774004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4h2lDbuS6wgFYWmNXWGo5hdv7x4F0DvuiMCZt9z600A=;
 b=eRj2A9wrzfA56vujIR8x9GFKyrPJi95mKrgfdHrFEoiG25IWigrDtCY2cPorWlTWKD
 vmhGuloAd9SZ1gobX/9wfVA48IEZDt+XqOG5YUvbp/0TabCSxIEEBSjztRfpu4YUaLko
 Ae1SfQrlzx1vOmi/MadlNIX4QwphWE5tOojq4eQO5WfYoBRpMrX5UGcXh+GsRA9aHpF1
 0cFqNphIN01Um7piarGbmaQXgeJa1J1H1EXqcOAbApEO3p9XCoI2PQIv32kcXoMzhiw/
 U1M5kDxdn8t0U5zsSPYg+F1g++x7MGFV96GcN0T9hFb8u2NetFljVOOy1NyXoz8/Toar
 RF8A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr05Yq5JitAo/ds9vUmdLwZ5z1yjHYXzYe/aibyzMaLXxtcQvW56JAOd4o6cTam0/5zjnfGmk4ZMY2BbuxJfIU=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yz+Djard0o09Dctrx3K8pCW8jAE+jW+mwDOh6v1NiDG6SpzqsTN
 TvyLDG4OyVDCRjrkG5sk3rG0GZNE41N9SPh9nEzZZ2Jqp0y7xL6xWbxd
X-Gm-Gg: AR+sD11uc8RZU+g5UTRtuoQAZMDcWtNvaD72nSAf7NXm6I5YCyHm0IMGzxTYjv+eVRt
 aB7vZsOQEi9WDwGMo3SbD8r94G8e3rmORvsWXjhLCsBDoKG329zGbx4JRlxK5wMu8TP58GcRJqG
 zoNd8WkZ1Ic3VTGtOZtSvN0iAXfIS3EWCTJn0GLHswSx7fnGKJBE/svYzAhWWRLpypEN7Fcsjyg
 gmZPZAEsVu/4Y8lNtbxvqI2RH8N5kAxLZL6Q9xpOcSHliApDc8SZcq+U1myHO+MfOXPeAuY2Mtb
 PcdQkmr0S+rewDZGi3rGpD5glpr0nAgwOPF5qTlpOc1pAEbCQvEiL08RlhLlyhFelR8o9sq3qlA
 PAXb0WeEt6w+RMl9AMF7A2hZt7Lx1GR5D2nBaoPCSmjsvwNxLVK0xfOlvCrRsvtf8t1YQ+KTEmD
 nQ2LXn
X-Received: by 2002:a17:903:3b88:b0:2ce:ceef:661b with SMTP id
 d9443c01a7336-2cfde8473c9mr75552645ad.29.1785169204004; 
 Mon, 27 Jul 2026 09:20:04 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:1::])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde59b8cbsm37712705ad.11.2026.07.27.09.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 09:20:03 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, aleksander.lobakin@intel.com,
 horms@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 witu@nvidia.com, alice.kernel@fastmail.im, dtatulea@nvidia.com,
 yoong.siang.song@intel.com, martin.lau@kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, leon@kernel.org,
 "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Date: Mon, 27 Jul 2026 09:19:57 -0700
Message-ID: <20260727161959.885642-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727161959.885642-1-sdf@fomichev.me>
References: <20260727161959.885642-1-sdf@fomichev.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785169204; x=1785774004; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4h2lDbuS6wgFYWmNXWGo5hdv7x4F0DvuiMCZt9z600A=;
 b=D153cCqT/UHpMdOgOclnEV7zGbC+IY4CQNmegQ8QdeE8s7PaMBEVGzAfTUaQmOB/cD
 6aRp7SQGiDlkMLfFaui4N9PatSry3w/1Qh3csj7x2uKXubY3XTX0v+zx7kRn9+QSsw4H
 HzrkL+J2JqV98/Mb+L/MWbVj0O7q57vnT6t/QhILO+qblZQjgOA/PsBkTB//hkVzWLvw
 1f0tbn2+TpYsOsbW44U2kfQlV0EVsAkvXpmBG8VS2hDVEgz37TnE86D6wZPsuu5lG8Rb
 VhCntL7Rr2ecIxFVW0jIU2pMLxNo7HGINpqXTSUzKXXHLcDniJUkUjhau+RDzpvNNJtv
 VMlg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=D153cCqT
Subject: [Intel-wired-lan] [PATCH net 4/6] xsk: validate launch-time
 metadata size
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

Launch-time metadata extends beyond the first 16 bytes of struct
xsk_tx_metadata. Reject the request when the registered metadata area does
not contain the complete field.

Snapshot the validated flags for the generic transmit path and use that
snapshot for request and completion processing, avoiding inconsistent
decisions if user space changes the flags concurrently.

Note that only xsk_skb_metadata is properly using the flags,
__xsk_buff_get_metadata ignores them. Next commits address that.

Fixes: ca4419f15abd ("xsk: Add launch time hardware offload support to XDP Tx metadata")
Cc: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/net/xdp_sock_drv.h | 17 +++++++++++++----
 net/xdp/xsk.c              | 11 ++++++-----
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 46797645a0c2..68a787601357 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -260,21 +260,28 @@ xsk_buff_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr)
 	0)
 
 static inline bool
-xsk_buff_valid_tx_metadata(const struct xsk_tx_metadata *meta)
+xsk_buff_valid_tx_metadata(const struct xsk_buff_pool *pool,
+			   const struct xsk_tx_metadata *meta, u64 *flags)
 {
-	return !(meta->flags & ~XDP_TXMD_FLAGS_VALID);
+	*flags = READ_ONCE(meta->flags);
+	if (*flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
+		if (pool->tx_metadata_len <
+		    offsetofend(struct xsk_tx_metadata, request.launch_time))
+			return false;
+	return !(*flags & ~XDP_TXMD_FLAGS_VALID);
 }
 
 static inline struct xsk_tx_metadata *
 __xsk_buff_get_metadata(const struct xsk_buff_pool *pool, void *data)
 {
 	struct xsk_tx_metadata *meta;
+	u64 flags;
 
 	if (!pool->tx_metadata_len)
 		return NULL;
 
 	meta = data - pool->tx_metadata_len;
-	if (unlikely(!xsk_buff_valid_tx_metadata(meta)))
+	if (unlikely(!xsk_buff_valid_tx_metadata(pool, meta, &flags)))
 		return NULL; /* no way to signal the error to the user */
 
 	return meta;
@@ -469,7 +476,9 @@ xsk_buff_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr)
 	return (struct xdp_desc_ctx){ };
 }
 
-static inline bool xsk_buff_valid_tx_metadata(struct xsk_tx_metadata *meta)
+static inline bool
+xsk_buff_valid_tx_metadata(const struct xsk_buff_pool *pool,
+			   const struct xsk_tx_metadata *meta, u64 *flags)
 {
 	return false;
 }
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index fcc6f17f3576..7855ee09c4b6 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -967,15 +967,16 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 {
 	struct xsk_tx_metadata *meta = NULL;
 	u16 csum_start, csum_offset;
+	u64 flags;
 
 	if (unlikely(pool->tx_metadata_len == 0))
 		return -EINVAL;
 
 	meta = buffer - pool->tx_metadata_len;
-	if (unlikely(!xsk_buff_valid_tx_metadata(meta)))
+	if (unlikely(!xsk_buff_valid_tx_metadata(pool, meta, &flags)))
 		return -EINVAL;
 
-	if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
+	if (flags & XDP_TXMD_FLAGS_CHECKSUM) {
 		csum_start = READ_ONCE(meta->request.csum_start);
 		csum_offset = READ_ONCE(meta->request.csum_offset);
 
@@ -996,9 +997,9 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 		}
 	}
 
-	if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
-		skb->skb_mstamp_ns = meta->request.launch_time;
-	if (!(meta->flags & XDP_TXMD_FLAGS_TIMESTAMP))
+	if (flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
+		skb->skb_mstamp_ns = READ_ONCE(meta->request.launch_time);
+	if (!(flags & XDP_TXMD_FLAGS_TIMESTAMP))
 		meta = NULL;
 	xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
 
-- 
2.53.0-Meta

