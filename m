Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183BCC5CFDB
	for <intel-wired-lan@archiver.kernel.org>; Thu, 13 Aug 2026 19:08:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D515640C78;
	Thu, 13 Aug 2026 19:08:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NGqfTKFtHAN0; Thu, 13 Aug 2026 19:08:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 01C6A40C98
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786648088;
	bh=knHPZ2hqDlF6r7lICpyiSankCSnQUl1ZecmnK0yjr1w=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RRYvzxy8qe++jge9NDFgfwVtXOlxK14U4MhupAFPTF41z8OFx7DO2ZrwQPZnwmAtR
	 kQtT0pa4PE4SoxRW9dfEc++c5w3BHqRRwxfkg9hIwkOD08K+hvnNo4FyRxlH5zcgPq
	 t55dFIAwExAger/Ckswkc/658ZcnH0+Lx5CwuMui/GtQsO1wG1j2E3DMNrSNwIkNq1
	 JtZci886gmv2QWsDsITc8VrDRE/cv4OwFsYe/OcwZapzVJh8kArK2QSQu4m0ZY4g6P
	 b/2UlK+kCqOOp2tHRMh21ZOU5mYL5i+CswJsYspVbj/QcELWhoWqLFL4QN03AL4FBD
	 K6UJk9s4vGRvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 01C6A40C98;
	Thu, 13 Aug 2026 19:08:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A18FC1394
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 19:08:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9376760805
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 19:08:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sBi8DdAA4vd7 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 13 Aug 2026 19:08:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::b;
 helo=mail-pj2-x0b.google.com; envelope-from=sdf.kernel@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 953D660DC9
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 953D660DC9
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Nztumvsj
Received: from mail-pj2-x0b.google.com (mail-pj2-x0b.google.com
 [IPv6:2607:f8b0:4864:39::b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 953D660DC9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 19:08:04 +0000 (UTC)
Received: by mail-pj2-x0b.google.com with SMTP id
 98e67ed59e1d1-38dbe53179bso67801a91.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 12:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786648084; x=1787252884; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=knHPZ2hqDlF6r7lICpyiSankCSnQUl1ZecmnK0yjr1w=;
 b=Nztumvsj+vw3zSDm/fN4dHUCgaflHKxLpfZ7JsRvDLL/oyMhh57SLxdOQ5Amfbg+H1
 47qIBpQOfxAwJg83GoYxiD5Tijk3qt6KpGzhgU30dg6u7gu5037E91f3gsL6Qp8YG8HI
 QVCvnER+psc6PrLditxIPjeD6Ouescs0aclfcB46UnrZywnYsg/pcUp8PiuevunAh1ph
 1FCAJbX0ejw707FXUwQ9OuMdPE23scdldtMIIVwxha9eWh/qtCNfhX1oieXz2xPYexts
 LMo55McKwZyFXuwRkwzyhcuVvtvp0bEb/jDkE5DDkX0pcmr7DAceme9sqoVvvqah+QyD
 SbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786648084; x=1787252884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=knHPZ2hqDlF6r7lICpyiSankCSnQUl1ZecmnK0yjr1w=;
 b=U7jaKFLlFvAf6yMVxnhb0DnORO//EJJYgXVdSDrEPRpPd/iB1JvE9O0S7MZcu+IO/5
 lFa76buZJ+fwK4fuOEWZek+I7O7z+ropDhxUU4kC795A92Wv5kX6L+NnX9C79TsSoyTU
 YYxsxtmJ0yps4BhiN9OAfgowzuRSqboPnUD1YLbdhBa5d9++4Bg3evUDeMZM+uWoEPGb
 iyrI5kiY1D2o1KwxkI+kgDm4cco+1PJWsVlK3WgsMXjZWs8MYpm0wE6K5cIC9mFuExHj
 AKngf1fqi/nqkjUuMV/L78cPD8meS7ujLimAR46tVDaA1iUl4v0WSYzKFSXHgbV3XPwb
 gFVQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqgP3VCTNFwyH/Pdk1UUuoyw5lXb9vdGpiRconSL/Wc3zu9bPtr0zUTYR7hhZ71WVFqeEj6Ki8y7hIMYX6Hgd0=@lists.osuosl.org
X-Gm-Message-State: AOJu0YwthsspPMiOYJMy6Mw9gOhfXsE4id9x5+XlAbsjW0HIgjYr+Rcd
 H8ba9lgSSBYWlp34B+jk2/0gE1CwcAJkYmH6GCFx/y2CbrvMFmoW8vhl
X-Gm-Gg: AR+sD12g/878RD3COFUF3CQrf54tAF7nvrVWbSziKsbcOiZ7NfxMfhDai4MU3R31ebn
 IqQoJwVTXNhjyXXZIU2ngF3uWjWMJmIQU0RCmFQq4wg1UGLJrWLE4qzaBC7apq2FIRI4koFgT1d
 nCBrBYwTwW2CfUX0ELIVVKUJUqjLez6QVgS3c3OrtOsKHLSZs2fSGiUZJW6JCJLF7vRAguydWXS
 OQVjHdNhVwTjG71BdwSf2cf4zA71RoQHubP9HZ8k5GyJUzOUZAHPjGdC+oqTasPpbEx6x2yix8y
 m9kUdDanrWPTsKWAxjF46UF3UvM2pSBssI1DlQfQdkU5UUZKZc8cUBof8KzowipYkPVB9abFS7C
 VA+Cru2fKh0viktggV/6q8tHIsSNAjpB3VK0FYQ1s0ZTKN7RGG0/u2tjEU0Yy2kTV5eO6c8+vCT
 0ekHVV9OWaTZBXpmOz9+h0QZD/UHehSPFbKtpgK9WddIN+uCzxY5kv8A==
X-Received: by 2002:a17:90a:da8f:b0:380:21b7:e727 with SMTP id
 98e67ed59e1d1-3933b95e327mr167852a91.14.1786648083852; 
 Thu, 13 Aug 2026 12:08:03 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4c::])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931cf25e5dsm4535692a91.17.2026.08.13.12.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 12:08:03 -0700 (PDT)
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
 witu@nvidia.com, martin.lau@kernel.org, yoong.siang.song@intel.com,
 rohan.g.thomas@intel.com, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, leon@kernel.org
Date: Thu, 13 Aug 2026 12:07:59 -0700
Message-ID: <20260813190800.222527-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813190800.222527-1-sdf@fomichev.me>
References: <20260813190800.222527-1-sdf@fomichev.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Intel-wired-lan] [PATCH net v2 2/3] xsk: honor XDP_TX_METADATA in
 zero-copy path
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

This does not fix the existing per-WQE metadata handling for mlx5 MPWQEs.
Only the descriptor that starts a session passes through
xsk_tx_metadata_request() and configures offload state shared by the batch.
Metadata on descriptors joining an open session is therefore not validated
and does not configure its requested offloads. In addition, a non-NULL
metadata pointer from such a descriptor is treated as a timestamp
completion request even when XDP_TXMD_FLAGS_TIMESTAMP is not set, so its
metadata union can be overwritten with an unrequested timestamp. Fixing
mixed metadata states within one MPWQE requires a separate change.

Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload support")
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
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
index 39043d8ca1bf..59067939a586 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3074,7 +3074,8 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
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
index a71f0df26378..62de03e65a90 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2719,7 +2719,8 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 
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

