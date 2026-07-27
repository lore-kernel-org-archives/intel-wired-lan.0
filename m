Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749F2C53209
	for <intel-wired-lan@archiver.kernel.org>; Mon, 27 Jul 2026 16:20:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4ABFC40729;
	Mon, 27 Jul 2026 16:20:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e4AnaQ9bYfuJ; Mon, 27 Jul 2026 16:20:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8F0AA40761
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785169210;
	bh=7nQzsLqBl8zE6x57DDhN2FKu5g/8XVApDzbXi1A1P1w=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=9uMYLH8CG6Q3lD7sk2UoQX/ZwJZGl0spKg/iw28EgOnNMFl3GEEEmmpO7VIqIfbr5
	 yIO5RhfomxC9m6OOVqPZicbQowUXCABO35bQqeTtbMjaIBCu8TTrltmT+nbg3VPJkN
	 WkwseCWx2455Tzmhd75/3KDKBfSj/81tkLfHvQXFa2Gn0wr/LCe7RNMECzcC5RTfu+
	 YlzVcpcsNMuXZxQXxGoMWx4v/SjTUeeLBbCO4+8yid2JJw0qZB4U2pgx7dW2LisZ9q
	 xZ+1bvI1eTC2F+VvQjYLHEne3a9lqgYVR7PU17WSrqxLBQQ3zR5WmxAB6hwvAd9IOD
	 Avg0SoNAmEDIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F0AA40761;
	Mon, 27 Jul 2026 16:20:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F02503B1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 16:20:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D62CB60725
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 16:20:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pvPIUV8HQBcT for <intel-wired-lan@lists.osuosl.org>;
 Mon, 27 Jul 2026 16:20:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:3b::;
 helo=mail-pz2-x00.google.com; envelope-from=sdf.kernel@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 08B9960632
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 08B9960632
Received: from mail-pz2-x00.google.com (mail-pz2-x00.google.com
 [IPv6:2607:f8b0:4864:3b::])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 08B9960632
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 16:20:06 +0000 (UTC)
Received: by mail-pz2-x00.google.com with SMTP id
 41be03b00d2f7-c888c001628so1740920a12.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 09:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785169206; x=1785774006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7nQzsLqBl8zE6x57DDhN2FKu5g/8XVApDzbXi1A1P1w=;
 b=iL4yjlEokqGvgshOzuB9ZxJCBuR6WcF6O0D94Ch3wlZ3cl0B0PKevXWjkWEKcKafo6
 bNxDjVwyxx5WdZuHuRuqLbVbO68ktbgbCrIFg16tM2/kuq5e0Du+8t6hwsGOmbdHPbeb
 H0cI6UIAY91cpOy4Q12OuFmLCdgFJZpeRrVPyApFqQCx8x5vAeCYps325TLVQG78S9lT
 LvmCKGM2f5cws+aUkzzu106ju5mBvNREHeNHxCAlAwDPi75ANGyO2PZmfal2OA3GWPQo
 C45lp6+5RQWTrFVzJAJeIVOSu7MJyzwta4CxDG0OCQKPu05ZazfB6jnj7BsN7N97MstB
 TJhg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqXa8dTBgmRcOqrbA04UilHjZZIO/C3cIX+mnOWa839subg+XhrLf1o4gR90vya5or1bTjCuc/+qHbSzel+XpI=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yy/AyfTT0dTIXa4m9Vq+zSRqECwU44/fAQ2nMhBfhsRwkeIK0UK
 /e9ZSfQFtcVFRZ6zxvl3Tq0PTyy6mu2uprRIYbhHXIOjxW/1DQ5gdfeo
X-Gm-Gg: AR+sD11kIGjdGx1avO65fWLxHG/YA+Z/SPfrMb6kHLYSKQt1c7W6pXu0GufwfXIICKX
 dcZ1qaf83/W1KbbZjP5GVYr4MCQWmwcvxrbKFS1+8BxjEHtNWzZNuKNTI4eeipqoi6jzxo+x6Qz
 vu9ZNEzfCaCzNygaIkOe1Lu8YYXuras1j6xZcgcoOiyamjDTLlyhXko+LHYOVBopZC7lL1gXB6O
 EoQ9MaGy/Fd+amOL88hDK5nrUcXsD1bN9pjVxlu/J5eD4t0mQkW8mLutJh1bYvL80FqXLE6rB//
 Ji2GuXxJBUeNbJIas78TJgfksQViaQ7biI0Z/FsWmsI3F5z6P31lPDxxWRAPe6q9XR60KAqAnxy
 kysNZumia/D5MTQZGfSgKb9hjN31f681rKlRZUaLn48N5yzgbsO5hGZEaiok+ySo2w6ah3Yg=
X-Received: by 2002:a05:6a00:340b:b0:845:d286:1fa2 with SMTP id
 d2e1a72fcca58-84e5955e7c8mr7301859b3a.49.1785169206009; 
 Mon, 27 Jul 2026 09:20:06 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e532acee2sm3273714b3a.27.2026.07.27.09.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 09:20:05 -0700 (PDT)
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
Date: Mon, 27 Jul 2026 09:19:59 -0700
Message-ID: <20260727161959.885642-7-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727161959.885642-1-sdf@fomichev.me>
References: <20260727161959.885642-1-sdf@fomichev.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785169206; x=1785774006; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7nQzsLqBl8zE6x57DDhN2FKu5g/8XVApDzbXi1A1P1w=;
 b=LL7b0O2kCRDvvROVH/bPWBkjDdw7PCk/jJoehZQBXkfLlZDBgVKbt0ubLOun6JLLxX
 I8s6sjKYNMnjqYVLhKyfP3rtZAWeJl9Q+TWUSEiizcIiXtM4ssV16gsbYsXHS62v+hlw
 bmgozmXkVtfnA4h6+JGv+ci6OPuui6CYCK3FGjDYQ6d2tBsOI4B76YcTAyGubrntTQ+E
 FuvxmogonXGHckqOnyX7C5HK8G+fSl7jRRZ6jlmlS6MQslkUUQ3SqTgvN1OMN4pI3TTO
 wpicP2GVz/WxRAWNKciF79AUAf1hXNYcREBu0Sh0kmJJd2qiHXZotE471/kPAfETwm2z
 KsJg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=LL7b0O2k
Subject: [Intel-wired-lan] [PATCH net 6/6] xsk: validate metadata when
 processing requests
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

The zero-copy path validates TX metadata while obtaining the descriptor
context, then reads it again later when preparing the hardware request.
User space can change the metadata between those operations and bypass the
original validation.

Validate the metadata in xsk_tx_metadata_request() and use the resulting
flags snapshot for every feature check. Read request fields once so all
zero-copy drivers process only values observed after successful
validation.

Fixes: ca4419f15abd ("xsk: Add launch time hardware offload support to XDP Tx metadata")
Cc: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/intel/igc/igc_main.c     |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  5 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  4 +-
 include/net/libeth/xsk.h                      |  2 +-
 include/net/xdp_sock_drv.h                    | 51 ++++++++++---------
 net/xdp/xsk_buff_pool.c                       |  6 +--
 6 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 5a18d00deb4f..7b6cdc037c00 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3082,7 +3082,7 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
 		meta_req.tx_buffer = bi;
 		meta_req.meta = meta;
 		meta_req.used_desc = 0;
-		xsk_tx_metadata_request(&meta, &igc_xsk_tx_metadata_ops,
+		xsk_tx_metadata_request(pool, &meta, &igc_xsk_tx_metadata_ops,
 					&meta_req);
 
 		/* xsk_tx_metadata_request() may have updated next_to_use */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index dac5e9d4c8bd..77ea51bfbaae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -505,7 +505,7 @@ mlx5e_xmit_xdp_frame_mpwqe(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptx
 		 */
 		mlx5e_xdp_mpwqe_session_start(sq);
 		if (meta)
-			xsk_tx_metadata_request(meta,
+			xsk_tx_metadata_request(sq->xsk_pool, meta,
 						&mlx5e_xsk_tx_metadata_ops,
 						&session->wqe->eth);
 	}
@@ -653,7 +653,8 @@ mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
 	sq->pc += num_wqebbs;
 
 	if (meta)
-		xsk_tx_metadata_request(meta, &mlx5e_xsk_tx_metadata_ops, eseg);
+		xsk_tx_metadata_request(sq->xsk_pool, meta,
+					&mlx5e_xsk_tx_metadata_ops, eseg);
 
 	sq->doorbell_cseg = cseg;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3f5111969c41..eb666b0bcdd2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2747,8 +2747,8 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		meta_req.set_ic = &set_ic;
 		meta_req.tbs = tx_q->tbs;
 		meta_req.edesc = &tx_q->dma_entx[entry];
-		xsk_tx_metadata_request(&meta, &stmmac_xsk_tx_metadata_ops,
-					&meta_req);
+		xsk_tx_metadata_request(pool, &meta,
+					&stmmac_xsk_tx_metadata_ops, &meta_req);
 		if (set_ic) {
 			tx_q->tx_count_frames = 0;
 			stmmac_set_tx_ic(priv, tx_desc);
diff --git a/include/net/libeth/xsk.h b/include/net/libeth/xsk.h
index e2fa6bf6b1b3..5dcc0d7f65b7 100644
--- a/include/net/libeth/xsk.h
+++ b/include/net/libeth/xsk.h
@@ -205,7 +205,7 @@ __libeth_xsk_xmit_fill_buf_md(const struct xdp_desc *xdesc,
 	BUILD_BUG_ON(!__builtin_constant_p(tmo == libeth_xsktmo));
 	tmo = tmo == libeth_xsktmo ? &__libeth_xsktmo : tmo;
 
-	xsk_tx_metadata_request(&ctx.meta, tmo, &desc);
+	xsk_tx_metadata_request(sq->pool, &ctx.meta, tmo, &desc);
 
 	return desc;
 }
diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index f87c4215673e..b344789f5df8 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -245,7 +245,7 @@ static inline void *xsk_buff_raw_get_data(struct xsk_buff_pool *pool, u64 addr)
  * details.
  *
  * Return: new &xdp_desc_ctx struct containing desc's DMA address and metadata
- * pointer, if it is present and valid (initialized to %NULL otherwise).
+ * pointer, if it is present (initialized to %NULL otherwise).
  */
 static inline struct xdp_desc_ctx
 xsk_buff_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr)
@@ -274,54 +274,56 @@ xsk_buff_valid_tx_metadata(const struct xsk_buff_pool *pool,
 /**
  *  xsk_tx_metadata_request - Evaluate AF_XDP TX metadata at submission
  *  and call appropriate xsk_tx_metadata_ops operation.
+ *  @pool: pointer to AF_XDP buffer pool, used to validate the metadata
  *  @pmeta: pointer to pointer to AF_XDP metadata area
  *  @ops: pointer to struct xsk_tx_metadata_ops
- *  @priv: pointer to driver-private aread
+ *  @priv: pointer to driver-private area
  *
  *  This function should be called by the networking device when
  *  it prepares AF_XDP egress packet.
  */
-static inline void xsk_tx_metadata_request(struct xsk_tx_metadata **pmeta,
-					   const struct xsk_tx_metadata_ops *ops,
-					   void *priv)
+static inline void
+xsk_tx_metadata_request(const struct xsk_buff_pool *pool,
+			struct xsk_tx_metadata **pmeta,
+			const struct xsk_tx_metadata_ops *ops, void *priv)
 {
 	const struct xsk_tx_metadata *meta = *pmeta;
+	u64 flags;
 
 	if (!meta)
 		return;
 
+	if (unlikely(!xsk_buff_valid_tx_metadata(pool, meta, &flags))) {
+		*pmeta = NULL;
+		return; /* no way to signal the error to the user */
+	}
+
 	if (ops->tmo_request_launch_time)
-		if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
-			ops->tmo_request_launch_time(meta->request.launch_time,
-						     priv);
+		if (flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
+			ops->tmo_request_launch_time(
+				READ_ONCE(meta->request.launch_time), priv);
 
 	if (ops->tmo_request_timestamp)
-		if (meta->flags & XDP_TXMD_FLAGS_TIMESTAMP)
+		if (flags & XDP_TXMD_FLAGS_TIMESTAMP)
 			ops->tmo_request_timestamp(priv);
 
 	if (ops->tmo_request_checksum)
-		if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM)
-			ops->tmo_request_checksum(meta->request.csum_start,
-						  meta->request.csum_offset, priv);
+		if (flags & XDP_TXMD_FLAGS_CHECKSUM)
+			ops->tmo_request_checksum(
+				READ_ONCE(meta->request.csum_start),
+				READ_ONCE(meta->request.csum_offset), priv);
 
-	if (!(meta->flags & XDP_TXMD_FLAGS_TIMESTAMP))
+	if (!(flags & XDP_TXMD_FLAGS_TIMESTAMP))
 		*pmeta = NULL;
 }
 
 static inline struct xsk_tx_metadata *
 __xsk_buff_get_metadata(const struct xsk_buff_pool *pool, void *data)
 {
-	struct xsk_tx_metadata *meta;
-	u64 flags;
-
 	if (!pool->tx_metadata_len)
 		return NULL;
 
-	meta = data - pool->tx_metadata_len;
-	if (unlikely(!xsk_buff_valid_tx_metadata(pool, meta, &flags)))
-		return NULL; /* no way to signal the error to the user */
-
-	return meta;
+	return data - pool->tx_metadata_len;
 }
 
 static inline struct xsk_tx_metadata *
@@ -520,9 +522,10 @@ xsk_buff_valid_tx_metadata(const struct xsk_buff_pool *pool,
 	return false;
 }
 
-static inline void xsk_tx_metadata_request(struct xsk_tx_metadata **pmeta,
-					   const struct xsk_tx_metadata_ops *ops,
-					   void *priv)
+static inline void
+xsk_tx_metadata_request(const struct xsk_buff_pool *pool,
+			struct xsk_tx_metadata **pmeta,
+			const struct xsk_tx_metadata_ops *ops, void *priv)
 {
 }
 
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index a4089480b22b..78c14f106395 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -765,11 +765,11 @@ EXPORT_SYMBOL(xp_raw_get_dma);
  * @addr: desc address (from userspace)
  *
  * Helper for getting desc's DMA address and metadata pointer, if present.
- * Saves one call on hotpath, double calculation of the actual address,
- * and inline checks for metadata presence and sanity.
+ * Saves one call on hotpath and double calculation of the actual address.
+ * Metadata is validated later by xsk_tx_metadata_request().
  *
  * Return: new &xdp_desc_ctx struct containing desc's DMA address and metadata
- * pointer, if it is present and valid (initialized to %NULL otherwise).
+ * pointer, if it is present (initialized to %NULL otherwise).
  */
 struct xdp_desc_ctx xp_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr)
 {
-- 
2.53.0-Meta

