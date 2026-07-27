Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D914C53209
	for <intel-wired-lan@archiver.kernel.org>; Mon, 27 Jul 2026 16:20:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D4A34072F;
	Mon, 27 Jul 2026 16:20:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uCYnvxeE0X0S; Mon, 27 Jul 2026 16:20:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D053840738
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785169205;
	bh=c9LHDNlHqE6dohf7NQwt3shVRUrKsU4ONudBOweUDy0=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uKkw0MTGaf+VndjqBTLJxvOb52IW/FjEazdtfW8SY+spkzoLYRuwx9DdhGfuAb9YU
	 RRzafHVFAbIv+oKnqxA0J5jHS9Xm+K5T650p3PifvTcuIOWhvNpRRV0QA8hbXirPtR
	 mjJsjSyT8kbK9ODNVnvhyZ9CJQI9TUiwhhndGB5Dp7P/qzYe0WxxoeSwbl/4r/oSOy
	 A+OGpFq4lb/qn63EFoF0+V/CbG/+WPGqd+HyklOqjJA7eGhIAuW+T9zxJVPKi6M4PO
	 bVjKMoknH5nwW6dUCG4o1tnXqFCXeHb45K32a2x0hsLqQQKIrisdHRZmInYV+S28TH
	 2VwYxnDZ0raOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D053840738;
	Mon, 27 Jul 2026 16:20:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B3F13B1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 16:20:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F149C4016A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 16:20:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TLci8Z6OWyD9 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 27 Jul 2026 16:20:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::a;
 helo=mail-pj2-x0a.google.com; envelope-from=sdf.kernel@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2B94840153
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2B94840153
Received: from mail-pj2-x0a.google.com (mail-pj2-x0a.google.com
 [IPv6:2607:f8b0:4864:39::a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2B94840153
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 16:20:02 +0000 (UTC)
Received: by mail-pj2-x0a.google.com with SMTP id
 98e67ed59e1d1-38dc4f9462cso1166344a91.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 09:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785169202; x=1785774002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=c9LHDNlHqE6dohf7NQwt3shVRUrKsU4ONudBOweUDy0=;
 b=gQyH9P3DaA00ozfV3jlV/0QYOEH52s71k5S+2YoXnonXZJRDwhUbmvcBnpIYvzLE3o
 MWLc6u62dpozKvyGMxxOT6cBiTVoRBrX5Ie9WviXf9aMmoJo5IAp6uiwL7FFeDq8muyj
 9T56rTdYAF1c1zzFtq+YVJBuJuyt7L0oUAhzb9lp40al8jsLbt3TgWTHW6e+7JTAzCGk
 V9cwV+BQbkIY0P/r8GvF+rdqvHfY45uDnkC+3fAs1dwh78j418cxVNvXlsJMXu322F5t
 Cc/tAr7P2nOG3Gstq12/Q/kX8GZ5EAHEsBzFJhK5d97IOJwpx8ZMYtu3Hu9/2ye7fPPT
 YqvQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoevJxpBWwr5WeMwbc8CwTx36UQEoRfZ6rKuz6mpuum2oMTXN3zLdtu5ByW+wNcqUTAMNnc2SgPaLNg/CZk9Dw=@lists.osuosl.org
X-Gm-Message-State: AOJu0YxOT4/GU3hkZk2npnoydKM5/nu22e7BaIVFqUqxJhZWFMDInZJc
 ulATIvufmWUM3EZI46n5jJpyS5ulxyl4mtctP7ega5oO8q97SNjmosnD
X-Gm-Gg: AR+sD11u8G0oGZYfa2WWOoDHD0AUlxVlrWUF4myCO9U9vVXqAuDCgkuww7gkxzlYtpR
 CJKzUY06ho6mG5+nxuBhOxKs5lVwlMs1RCy7CH3R+6CovZYMn4iNSZwPHCigiuBwjN8IUcfWOjs
 oGITF+hBH9eLsdpekTMdAPWXjfY4V5/qdRtTQN9ZmPSepsakj6ooZd2ebhva8idseJESapCkIaR
 9m5Oh7EefdNsuAecY331L0e/oQ0wrH+KHwJdnD3z0+XpZT0itGfxNvqvLkB9NGk6BpTgS1LAwmo
 PROHdEKhvrum+0MoFIvYnbHRQLzk9QlJc4/fzP/I3sGVoYK0ggRfXGz3HKNb7CuYgrCZiYLD7jn
 3fp0sNQuZ7JkEKAPcNdxqgqaV0/x1WSfau4Ll6Nk7DTuNobYj1uxnroRO2Q+vCFw6uno=
X-Received: by 2002:a17:90a:e7c2:b0:36a:c4b:76cf with SMTP id
 98e67ed59e1d1-38f295bd06fmr8359252a91.23.1785169202185; 
 Mon, 27 Jul 2026 09:20:02 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff::]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f6411189bsm74325a91.3.2026.07.27.09.20.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 09:20:01 -0700 (PDT)
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
Date: Mon, 27 Jul 2026 09:19:55 -0700
Message-ID: <20260727161959.885642-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727161959.885642-1-sdf@fomichev.me>
References: <20260727161959.885642-1-sdf@fomichev.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785169202; x=1785774002; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c9LHDNlHqE6dohf7NQwt3shVRUrKsU4ONudBOweUDy0=;
 b=RLQH8S9gp/WCXtWQ43tpDCaqZVFnHGeyvEq/YrI/eRMWTut7ZCizuG76z1orkCWBLX
 /aMRSD9fbMxpbfYoenk1bMMLcDiRdRiRacni0n7j5hxluUK7WeMV4mH9muaMmQUAtt7q
 S6MzKgXSs0fLGl8qYRo4NEwWBPRVUMHj8ZsjnZKukKTsx7LyWHAkKdH3IjyZf2X2NTan
 dxDMVeqPl40F3P4CCpOzqp0jJyhIF/EPFtpC82K4jr3SToh8uY9l0GwTCecBXHCCzMbH
 ecnTLoD/6igCUQYw7CMATg8j2s9+QQilr/WQTstdxhbb1Zw9HDczOkTDpfF8y/xPybSP
 wBTg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=RLQH8S9g
Subject: [Intel-wired-lan] [PATCH net 2/6] xsk: pass TX metadata pointer by
 reference
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

Completion handling needs to know whether a timestamp was requested when
the metadata was processed. Let xsk_tx_metadata_request() update the
caller's metadata pointer so that decision can be carried forward without
rereading user-controlled flags.

This only changes the interface; behavior remains unchanged.

Fixes: ca4419f15abd ("xsk: Add launch time hardware offload support to XDP Tx metadata")
Cc: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/intel/igc/igc_main.c          |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   | 14 +++++++++-----
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h   |  4 ++--
 .../net/ethernet/mellanox/mlx5/core/en/xsk/tx.c    |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  2 +-
 include/net/libeth/xsk.h                           |  2 +-
 include/net/xdp_sock.h                             |  8 +++++---
 8 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 2c9e2dfd8499..5a18d00deb4f 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3082,7 +3082,7 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
 		meta_req.tx_buffer = bi;
 		meta_req.meta = meta;
 		meta_req.used_desc = 0;
-		xsk_tx_metadata_request(meta, &igc_xsk_tx_metadata_ops,
+		xsk_tx_metadata_request(&meta, &igc_xsk_tx_metadata_ops,
 					&meta_req);
 
 		/* xsk_tx_metadata_request() may have updated next_to_use */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index d507289096c2..e12cb41c4b97 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -483,7 +483,7 @@ typedef int (*mlx5e_fp_xmit_xdp_frame_check)(struct mlx5e_xdpsq *);
 typedef bool (*mlx5e_fp_xmit_xdp_frame)(struct mlx5e_xdpsq *,
 					struct mlx5e_xmit_data *,
 					int,
-					struct xsk_tx_metadata *);
+					struct xsk_tx_metadata **);
 
 struct mlx5e_xdpsq {
 	/* data path */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index d8c7cb8837d7..dac5e9d4c8bd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -452,11 +452,11 @@ INDIRECT_CALLABLE_SCOPE int mlx5e_xmit_xdp_frame_check_mpwqe(struct mlx5e_xdpsq
 
 INDIRECT_CALLABLE_SCOPE bool
 mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
-		     int check_result, struct xsk_tx_metadata *meta);
+		     int check_result, struct xsk_tx_metadata **meta);
 
 INDIRECT_CALLABLE_SCOPE bool
 mlx5e_xmit_xdp_frame_mpwqe(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
-			   int check_result, struct xsk_tx_metadata *meta)
+			   int check_result, struct xsk_tx_metadata **meta)
 {
 	struct mlx5e_tx_mpwqe *session = &sq->mpwqe;
 	struct mlx5e_xdpsq_stats *stats = sq->stats;
@@ -504,7 +504,10 @@ mlx5e_xmit_xdp_frame_mpwqe(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptx
 		 * and it's safe to complete it at any time.
 		 */
 		mlx5e_xdp_mpwqe_session_start(sq);
-		xsk_tx_metadata_request(meta, &mlx5e_xsk_tx_metadata_ops, &session->wqe->eth);
+		if (meta)
+			xsk_tx_metadata_request(meta,
+						&mlx5e_xsk_tx_metadata_ops,
+						&session->wqe->eth);
 	}
 
 	mlx5e_xdp_mpwqe_add_dseg(sq, p, stats);
@@ -535,7 +538,7 @@ INDIRECT_CALLABLE_SCOPE int mlx5e_xmit_xdp_frame_check(struct mlx5e_xdpsq *sq)
 
 INDIRECT_CALLABLE_SCOPE bool
 mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
-		     int check_result, struct xsk_tx_metadata *meta)
+		     int check_result, struct xsk_tx_metadata **meta)
 {
 	struct mlx5e_xmit_data_frags *xdptxdf =
 		container_of(xdptxd, struct mlx5e_xmit_data_frags, xd);
@@ -649,7 +652,8 @@ mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
 
 	sq->pc += num_wqebbs;
 
-	xsk_tx_metadata_request(meta, &mlx5e_xsk_tx_metadata_ops, eseg);
+	if (meta)
+		xsk_tx_metadata_request(meta, &mlx5e_xsk_tx_metadata_ops, eseg);
 
 	sq->doorbell_cseg = cseg;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
index 3c54f8962664..5b8f4094d553 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
@@ -114,11 +114,11 @@ extern const struct xsk_tx_metadata_ops mlx5e_xsk_tx_metadata_ops;
 INDIRECT_CALLABLE_DECLARE(bool mlx5e_xmit_xdp_frame_mpwqe(struct mlx5e_xdpsq *sq,
 							  struct mlx5e_xmit_data *xdptxd,
 							  int check_result,
-							  struct xsk_tx_metadata *meta));
+							  struct xsk_tx_metadata **meta));
 INDIRECT_CALLABLE_DECLARE(bool mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq,
 						    struct mlx5e_xmit_data *xdptxd,
 						    int check_result,
-						    struct xsk_tx_metadata *meta));
+						    struct xsk_tx_metadata **meta));
 INDIRECT_CALLABLE_DECLARE(int mlx5e_xmit_xdp_frame_check_mpwqe(struct mlx5e_xdpsq *sq));
 INDIRECT_CALLABLE_DECLARE(int mlx5e_xmit_xdp_frame_check(struct mlx5e_xdpsq *sq));
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
index 8aeab4b21035..3d19dad8f868 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
@@ -105,7 +105,7 @@ bool mlx5e_xsk_tx(struct mlx5e_xdpsq *sq, unsigned int budget)
 
 		ret = INDIRECT_CALL_2(sq->xmit_xdp_frame, mlx5e_xmit_xdp_frame_mpwqe,
 				      mlx5e_xmit_xdp_frame, sq, &xdptxd,
-				      check_result, meta);
+				      check_result, &meta);
 		if (unlikely(!ret)) {
 			if (sq->mpwqe.wqe)
 				mlx5e_xdp_mpwqe_complete(sq);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 151c77713025..3f5111969c41 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2747,7 +2747,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		meta_req.set_ic = &set_ic;
 		meta_req.tbs = tx_q->tbs;
 		meta_req.edesc = &tx_q->dma_entx[entry];
-		xsk_tx_metadata_request(meta, &stmmac_xsk_tx_metadata_ops,
+		xsk_tx_metadata_request(&meta, &stmmac_xsk_tx_metadata_ops,
 					&meta_req);
 		if (set_ic) {
 			tx_q->tx_count_frames = 0;
diff --git a/include/net/libeth/xsk.h b/include/net/libeth/xsk.h
index 82b5d21aae87..e2fa6bf6b1b3 100644
--- a/include/net/libeth/xsk.h
+++ b/include/net/libeth/xsk.h
@@ -205,7 +205,7 @@ __libeth_xsk_xmit_fill_buf_md(const struct xdp_desc *xdesc,
 	BUILD_BUG_ON(!__builtin_constant_p(tmo == libeth_xsktmo));
 	tmo = tmo == libeth_xsktmo ? &__libeth_xsktmo : tmo;
 
-	xsk_tx_metadata_request(ctx.meta, tmo, &desc);
+	xsk_tx_metadata_request(&ctx.meta, tmo, &desc);
 
 	return desc;
 }
diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 8b51876efbed..06c081feff42 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -153,17 +153,19 @@ static inline void xsk_tx_metadata_to_compl(struct xsk_tx_metadata *meta,
 /**
  *  xsk_tx_metadata_request - Evaluate AF_XDP TX metadata at submission
  *  and call appropriate xsk_tx_metadata_ops operation.
- *  @meta: pointer to AF_XDP metadata area
+ *  @pmeta: pointer to pointer to AF_XDP metadata area
  *  @ops: pointer to struct xsk_tx_metadata_ops
  *  @priv: pointer to driver-private aread
  *
  *  This function should be called by the networking device when
  *  it prepares AF_XDP egress packet.
  */
-static inline void xsk_tx_metadata_request(const struct xsk_tx_metadata *meta,
+static inline void xsk_tx_metadata_request(struct xsk_tx_metadata **pmeta,
 					   const struct xsk_tx_metadata_ops *ops,
 					   void *priv)
 {
+	const struct xsk_tx_metadata *meta = *pmeta;
+
 	if (!meta)
 		return;
 
@@ -231,7 +233,7 @@ static inline void xsk_tx_metadata_to_compl(struct xsk_tx_metadata *meta,
 {
 }
 
-static inline void xsk_tx_metadata_request(struct xsk_tx_metadata *meta,
+static inline void xsk_tx_metadata_request(struct xsk_tx_metadata **pmeta,
 					   const struct xsk_tx_metadata_ops *ops,
 					   void *priv)
 {
-- 
2.53.0-Meta

