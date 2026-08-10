Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BA4C5AD7B
	for <intel-wired-lan@archiver.kernel.org>; Mon, 10 Aug 2026 18:48:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F01654069C;
	Mon, 10 Aug 2026 18:47:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3NBYBXzcoEdv; Mon, 10 Aug 2026 18:47:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 26F594069F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786387679;
	bh=ReqxlOI3SPTob6ZQXa8L4cTAU26COQOXARq4XifK/Bw=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uw8QqTS7o3ByhAaaL2f3gA4EaVBw/GbIRjo8BBd2sqEMRgebgrI0MhQpxx0/xBY8L
	 3G9WIQH1iduWJtGhnRiaelPpdfVk+s9KI4euq0J+DT9Kpan7oxNjGbwwl6WBI4NUAj
	 sTZjbRPWu44fmnlivkhTN7dUl/Ut61l7Fk9BXWcNeadKU94AUnBuNzHX2mfmZ4A2IB
	 sTBOk9oAMvr6+rYG679UsHmv3EqtqACQloZ1p74pk0fQPEqYG4VGX4zm/u8FiWmSHY
	 UQsfgCPMi/oj89NfedS1kr9CaugfOVVeJeCBUbkhB7fC0G3DJtrQ/1TJVKT/V9gze6
	 jxMLesbsuO1GA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 26F594069F;
	Mon, 10 Aug 2026 18:47:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 120DD24E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 18:47:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC9D140174
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 18:47:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XDzr8u42CxXx for <intel-wired-lan@lists.osuosl.org>;
 Mon, 10 Aug 2026 18:47:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::3;
 helo=mail-pj2-x03.google.com; envelope-from=sdf.kernel@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2494B4016B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2494B4016B
Received: from mail-pj2-x03.google.com (mail-pj2-x03.google.com
 [IPv6:2607:f8b0:4864:39::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2494B4016B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 18:47:56 +0000 (UTC)
Received: by mail-pj2-x03.google.com with SMTP id
 d9443c01a7336-2ccb0e85312so14168935ad.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 11:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786387676; x=1786992476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ReqxlOI3SPTob6ZQXa8L4cTAU26COQOXARq4XifK/Bw=;
 b=JHcBVj/hNI97s//an5R1IjdxhhcgL+ONmLATX09oNHHjFuAaGU8Dlfv9jwq9KY8UQF
 MgdzDUPp5hPBY8yG4cnAz89YpyR/71Lyi+/oqNywQBYQGH3OQDdpt24DHsicbfuYf4Qx
 3pwq/61E0kgkMrBipwWgKPR65ALqY2m24XJ3teUfZrwk6/79S8MF61O4Nv/zDuEip3rl
 eiso0ydqgsXhg3vPY6QVvaDDvDoOcq5f/kFP7sKlCPX5tVP0wlHGV0QQu+1D95ogRm/M
 KkAupDz1vmUkhkOCwlTxBwPgPXqLrp9skYIvtlCWmDS+K2DnyRNUnoD/9kdcapHID5DZ
 2yIg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqPbrptUhOcxyTDAOhmhjnGSKjQlQh2U1+v6d/62gTjJbFFB5hiBG2EMHGmyr7GZmFkNLA4iFL6t56L3l1yZGo=@lists.osuosl.org
X-Gm-Message-State: AOJu0YwEUFWFGZKQzYoZdDEHsdaywhAzri/deaqfy6Ee3R0gqhWXVM71
 in+IywJrcpPwQ3jZ9tYGUnGtBpi7QYhccYeSksNRH6++PrxqZ/erDeDV
X-Gm-Gg: AR+sD118xhpxeNowmusw+ccBib+sQ8O4T6ClzqbnGbnuir3bLfiyfMt3wXIN0P5bJ0m
 jtrRuEuWpKjKp1uCwgvOVi1hTz82qfKCYQJXUo6Us0uVDZwjVhZU95oAgUNpTvjKbo0FHqfUXoR
 nhJU1wpKrX510mTsHxBCAomaVkj6X8K+OQNr8qU1YZCeFk2w5pd06dc5T7q+iDhvYx6lxSU0Quq
 A4NsqqvfQfjkHkuNC7Ofog+vXnK/fSbKg/Ez7toLiho+likmiEZSO+YyGDPjklzhOCLonRk/ZN+
 slHFkhlTdhrf8pgsfvAGZPtxeBWcKDFENr8ezGRRPDL43bkXRTlY3N64PpVsrGqaNySjuzIFIXL
 nx+x3oXQJCpvTY3XoZsYoxm76Ec22EheWaaPIf3zdBFabhhNKqp2laOXgO7w9ZGDA1mVQ/wOmjZ
 4On5X9LwHZ0xKMQM1ycYS+TV6rHvi9grelG12vUN3dfwNXLPLjdkl8PHgmIen61vM=
X-Received: by 2002:a17:903:4b28:b0:2d1:1a18:4d0a with SMTP id
 d9443c01a7336-2d2a8996f11mr253323075ad.9.1786387676319; 
 Mon, 10 Aug 2026 11:47:56 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:1::])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d16c4af2fcsm40115335ad.69.2026.08.10.11.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 11:47:55 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, maxime.chevallier@bootlin.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 aleksander.lobakin@intel.com, horms@kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 alice.kernel@fastmail.im, dtatulea@nvidia.com, witu@nvidia.com,
 martin.lau@kernel.org, yoong.siang.song@intel.com,
 rohan.g.thomas@intel.com, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, leon@kernel.org
Date: Mon, 10 Aug 2026 11:47:52 -0700
Message-ID: <20260810184753.135756-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810184753.135756-1-sdf@fomichev.me>
References: <20260810184753.135756-1-sdf@fomichev.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786387676; x=1786992476; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ReqxlOI3SPTob6ZQXa8L4cTAU26COQOXARq4XifK/Bw=;
 b=NHmhyRyg9p6QkbsIVT8pzDaEQ/j7TVE6Kw37vTCv43LpCkEQxZBjmLwWAF7eMUq2wI
 Lsqpe7RLeaTru6EhWsD+MpM1hVargBxmeK2EMZk1bIwOnjmr8Frno4zoUQxpkbTrWvkz
 u9uaH0Lonf3zPxt/JlkfluAkZTWlfreNKaYHtDppT+qi9Ltxw3+JOtGHMqu8r+tMBL18
 LFp2zW/r5qwnWFPahYqgrZP+J7OqfQA8V5Z80viux0kgBrJgQiF7yYFOXu7BstpGi2HT
 hb1RdOeM1a4fknH6kmJpZ40bbvka8e8yNyTnfL3MbWOtnJtVUdBfmMjGjvqmTSSxQTFl
 K92Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=NHmhyRyg
Subject: [Intel-wired-lan] [PATCH net-next 2/3] xsk: honor XDP_TX_METADATA
 in zero-copy path
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

The zero-copy path reads TX metadata whenever the UMEM has metadata space,
even if the descriptor does not set XDP_TX_METADATA. Pass descriptor
options through the metadata helpers and ignore metadata unless the option
is set.

This does not change the existing per-WQE metadata handling for mlx5
MPWQEs, where the descriptor that starts a session configures offload state
shared by the batch. Supporting mixed metadata states within one MPWQE
requires a separate fix.

Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload support")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/intel/igc/igc_main.c     |  3 ++-
 .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  3 ++-
 include/net/libeth/xsk.h                      |  2 +-
 include/net/xdp_sock_drv.h                    | 22 +++++++++++--------
 include/net/xsk_buff_pool.h                   |  3 ++-
 net/xdp/xsk_buff_pool.c                       |  7 ++++--
 7 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 8b9ce7cbfff9..1fb5f3cbe93c 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3071,7 +3071,8 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
 		olinfo_status = xdp_desc.len << IGC_ADVTXD_PAYLEN_SHIFT;
 
 		dma = xsk_buff_raw_get_dma(pool, xdp_desc.addr);
-		meta = xsk_buff_get_metadata(pool, xdp_desc.addr);
+		meta = xsk_buff_get_metadata(pool, xdp_desc.addr,
+					     xdp_desc.options);
 		xsk_buff_raw_dma_sync_for_device(pool, dma, xdp_desc.len);
 		bi = &ring->tx_buffer_info[ntu];
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
index 3d19dad8f868..d194eeddd7b5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
@@ -99,7 +99,7 @@ bool mlx5e_xsk_tx(struct mlx5e_xdpsq *sq, unsigned int budget)
 		xdptxd.dma_addr = xsk_buff_raw_get_dma(pool, desc.addr);
 		xdptxd.data = xsk_buff_raw_get_data(pool, desc.addr);
 		xdptxd.len = desc.len;
-		meta = xsk_buff_get_metadata(pool, desc.addr);
+		meta = xsk_buff_get_metadata(pool, desc.addr, desc.options);
 
 		xsk_buff_raw_dma_sync_for_device(pool, xdptxd.dma_addr, xdptxd.len);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b2b7d0242dd3..efa35cfecc4f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2723,7 +2723,8 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 
 		tx_desc = stmmac_get_tx_desc(priv, tx_q, entry);
 		dma_addr = xsk_buff_raw_get_dma(pool, xdp_desc.addr);
-		meta = xsk_buff_get_metadata(pool, xdp_desc.addr);
+		meta = xsk_buff_get_metadata(pool, xdp_desc.addr,
+					     xdp_desc.options);
 		xsk_buff_raw_dma_sync_for_device(pool, dma_addr, xdp_desc.len);
 
 		/* To return XDP buffer to XSK pool, we simple call
diff --git a/include/net/libeth/xsk.h b/include/net/libeth/xsk.h
index 5dcc0d7f65b7..a452b7828ce4 100644
--- a/include/net/libeth/xsk.h
+++ b/include/net/libeth/xsk.h
@@ -196,7 +196,7 @@ __libeth_xsk_xmit_fill_buf_md(const struct xdp_desc *xdesc,
 	struct libeth_xdp_tx_desc desc;
 	struct xdp_desc_ctx ctx;
 
-	ctx = xsk_buff_raw_get_ctx(sq->pool, xdesc->addr);
+	ctx = xsk_buff_raw_get_ctx(sq->pool, xdesc->addr, xdesc->options);
 	desc = (typeof(desc)){
 		.addr	= ctx.dma,
 		__libeth_xdp_tx_len(xdesc->len),
diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index b344789f5df8..d94aeb506379 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -240,6 +240,7 @@ static inline void *xsk_buff_raw_get_data(struct xsk_buff_pool *pool, u64 addr)
  * xsk_buff_raw_get_ctx - get &xdp_desc context
  * @pool: XSk buff pool desc address belongs to
  * @addr: desc address (from userspace)
+ * @options: desc options (from userspace)
  *
  * Wrapper for xp_raw_get_ctx() to be used in drivers, see its kdoc for
  * details.
@@ -248,9 +249,9 @@ static inline void *xsk_buff_raw_get_data(struct xsk_buff_pool *pool, u64 addr)
  * pointer, if it is present (initialized to %NULL otherwise).
  */
 static inline struct xdp_desc_ctx
-xsk_buff_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr)
+xsk_buff_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr, u32 options)
 {
-	return xp_raw_get_ctx(pool, addr);
+	return xp_raw_get_ctx(pool, addr, options);
 }
 
 #define XDP_TXMD_FLAGS_VALID ( \
@@ -318,18 +319,20 @@ xsk_tx_metadata_request(const struct xsk_buff_pool *pool,
 }
 
 static inline struct xsk_tx_metadata *
-__xsk_buff_get_metadata(const struct xsk_buff_pool *pool, void *data)
+__xsk_buff_get_metadata(const struct xsk_buff_pool *pool, void *data,
+			unsigned int options)
 {
-	if (!pool->tx_metadata_len)
+	if (!pool->tx_metadata_len || !(options & XDP_TX_METADATA))
 		return NULL;
 
 	return data - pool->tx_metadata_len;
 }
 
 static inline struct xsk_tx_metadata *
-xsk_buff_get_metadata(struct xsk_buff_pool *pool, u64 addr)
+xsk_buff_get_metadata(struct xsk_buff_pool *pool, u64 addr, u32 options)
 {
-	return __xsk_buff_get_metadata(pool, xp_raw_get_data(pool, addr));
+	return __xsk_buff_get_metadata(pool, xp_raw_get_data(pool, addr),
+				       options);
 }
 
 static inline void xsk_buff_dma_sync_for_cpu(struct xdp_buff *xdp)
@@ -510,7 +513,7 @@ static inline void *xsk_buff_raw_get_data(struct xsk_buff_pool *pool, u64 addr)
 }
 
 static inline struct xdp_desc_ctx
-xsk_buff_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr)
+xsk_buff_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr, u32 options)
 {
 	return (struct xdp_desc_ctx){ };
 }
@@ -530,13 +533,14 @@ xsk_tx_metadata_request(const struct xsk_buff_pool *pool,
 }
 
 static inline struct xsk_tx_metadata *
-__xsk_buff_get_metadata(const struct xsk_buff_pool *pool, void *data)
+__xsk_buff_get_metadata(const struct xsk_buff_pool *pool, void *data,
+			unsigned int options)
 {
 	return NULL;
 }
 
 static inline struct xsk_tx_metadata *
-xsk_buff_get_metadata(struct xsk_buff_pool *pool, u64 addr)
+xsk_buff_get_metadata(struct xsk_buff_pool *pool, u64 addr, u32 options)
 {
 	return NULL;
 }
diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index 2bb1d122b1bc..a7df573784fd 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -154,7 +154,8 @@ struct xdp_desc_ctx {
 	struct xsk_tx_metadata *meta;
 };
 
-struct xdp_desc_ctx xp_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr);
+struct xdp_desc_ctx xp_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr,
+				   u32 options);
 
 static inline dma_addr_t xp_get_dma(struct xdp_buff_xsk *xskb)
 {
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 78c14f106395..9d2d94f1fb75 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -763,6 +763,7 @@ EXPORT_SYMBOL(xp_raw_get_dma);
  * xp_raw_get_ctx - get &xdp_desc context
  * @pool: XSk buff pool desc address belongs to
  * @addr: desc address (from userspace)
+ * @options: desc options (from userspace)
  *
  * Helper for getting desc's DMA address and metadata pointer, if present.
  * Saves one call on hotpath and double calculation of the actual address.
@@ -771,14 +772,16 @@ EXPORT_SYMBOL(xp_raw_get_dma);
  * Return: new &xdp_desc_ctx struct containing desc's DMA address and metadata
  * pointer, if it is present (initialized to %NULL otherwise).
  */
-struct xdp_desc_ctx xp_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr)
+struct xdp_desc_ctx xp_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr,
+				   u32 options)
 {
 	struct xdp_desc_ctx ret;
 
 	addr = __xp_raw_get_addr(pool, addr);
 
 	ret.dma = __xp_raw_get_dma(pool, addr);
-	ret.meta = __xsk_buff_get_metadata(pool, __xp_raw_get_data(pool, addr));
+	ret.meta = __xsk_buff_get_metadata(pool, __xp_raw_get_data(pool, addr),
+					   options);
 
 	return ret;
 }
-- 
2.53.0-Meta

