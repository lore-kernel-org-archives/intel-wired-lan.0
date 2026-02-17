Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EED8E909A5
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Feb 2026 13:55:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3DEB540A8B;
	Tue, 17 Feb 2026 13:55:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1HlfoA6UJxu4; Tue, 17 Feb 2026 13:54:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 30C0B40B08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771336498;
	bh=Yzr9oo4bfkDH5gmTM0Hzye/7ubeP4hPNYCRB1JOn808=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wcccb3DNKIk0+X/FCdh68GxRZVMNg2+3dJgy18CqjWNyjn51beutBCZ0xTSN30t8Z
	 8HAt6TyP1LVDTVH50K9kqoMBUYTa3hJjVjsga9OumA3uZpZms9rs5SUT5wkHBNZ3tL
	 YOhxHztUQjNqOU9q/sirGjxAK2iH8SpJ5DpRtaltgqizKRRwXxjgdCR9i1LPXIa2Pu
	 8A8Wf/LP+Urz4LWWQNO0z6nptqh9BefKRxkb6WyFWKO0YzRTj0mZPf4++9SmrTNN5J
	 Rol8GjSp0rrhwh0+/dm3QDW9rkmtsyff5SnHfhvk17e5dYgLsZdLHXM1l1vaZuF2KS
	 zmAQ37d52fmUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30C0B40B08;
	Tue, 17 Feb 2026 13:54:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A6DE81EB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Feb 2026 13:54:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8876780E65
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Feb 2026 13:54:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xIIDuC21icZ2 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Feb 2026 13:54:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=larysa.zaremba@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 94F61811D7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 94F61811D7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 94F61811D7
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Feb 2026 13:54:56 +0000 (UTC)
X-CSE-ConnectionGUID: F7XzLJmuSNilnhO5Bop2Gg==
X-CSE-MsgGUID: k1QJJB7OToa5wnWwj2qScw==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="72470507"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="72470507"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 05:54:56 -0800
X-CSE-ConnectionGUID: DcAtXpXOSXCSBXD8zcmS6g==
X-CSE-MsgGUID: 8QTap2nWTwK2/ES9dO5soA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="213904668"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orviesa008.jf.intel.com with ESMTP; 17 Feb 2026 05:54:48 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id E7C7828791;
 Tue, 17 Feb 2026 13:54:44 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: bpf@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>,
 Tushar Vyavahare <tushar.vyavahare@intel.com>,
 Jason Xing <kernelxing@tencent.com>,
 =?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
 Eelco Chaudron <echaudro@redhat.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Toke Hoiland-Jorgensen <toke@redhat.com>, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
Date: Tue, 17 Feb 2026 14:24:45 +0100
Message-ID: <20260217132450.1936200-8-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260217132450.1936200-1-larysa.zaremba@intel.com>
References: <20260217132450.1936200-1-larysa.zaremba@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771336497; x=1802872497;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0CKsXmjygWfgTfW6+ScFYR6A19xBLdaV5AkI9EKjkjI=;
 b=I8iCjyu0HcRQwSQ2QtjkfThiCqzKAy36x/XozUbD/S2BrVkmC/lPDVZD
 WuiatTgWrftsSumt4MriZmLW4UA2BzGrjaZ2m83gV9KE+vKBC49+ISgY+
 lKolFAUVdQv7L/xu0hBDP1QqxsyjHl+zX5LgSj0qxhBL73iufnXWokO1x
 QWt81RCN95HGGsSg8MxyDepEaJCdwfTRWQgEWrzvPK95Fl+VGbSfwONri
 x/QVNvdJF/3vVpZbocwfX/w8QKWoW3isaX8EExornfsmkqrk+LQrMLaE0
 3ZcDUcGPQLkn3qqOXdVA4FVGdRqSAX2eSERYKtRGvFyCv/ovA9w7TdiIo
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=I8iCjyu0
Subject: [Intel-wired-lan] [PATCH bpf v3 7/9] libeth,
 idpf: use truesize as XDP RxQ info frag_size
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

The only user of frag_size field in XDP RxQ info is
bpf_xdp_frags_increase_tail(). It clearly expects whole buffer size instead
of DMA write size. Different assumptions in idpf driver configuration lead
to negative tailroom.

To make it worse, buffer sizes are not actually uniform in idpf when
splitq is enabled, as there are several buffer queues, so rxq->rx_buf_size
is meaningless in this case.

Use truesize of the first bufq in AF_XDP ZC, as there is only one. Disable
growinf tail for regular splitq.

Fixes: ac8a861f632e ("idpf: prepare structures to support XDP")
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/idpf/xdp.c   | 6 +++++-
 drivers/net/ethernet/intel/idpf/xsk.c   | 1 +
 drivers/net/ethernet/intel/libeth/xsk.c | 1 +
 include/net/libeth/xsk.h                | 3 +++
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index 958d16f87424..7d91f21174de 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -46,11 +46,15 @@ static int __idpf_xdp_rxq_info_init(struct idpf_rx_queue *rxq, void *arg)
 {
 	const struct idpf_vport *vport = rxq->q_vector->vport;
 	bool split = idpf_is_queue_model_split(vport->rxq_model);
+	u32 frag_size = 0;
 	int err;
 
+	if (idpf_queue_has(XSK, rxq))
+		frag_size = rxq->bufq_sets[0].bufq.truesize;
+
 	err = __xdp_rxq_info_reg(&rxq->xdp_rxq, vport->netdev, rxq->idx,
 				 rxq->q_vector->napi.napi_id,
-				 rxq->rx_buf_size);
+				 frag_size);
 	if (err)
 		return err;
 
diff --git a/drivers/net/ethernet/intel/idpf/xsk.c b/drivers/net/ethernet/intel/idpf/xsk.c
index fd2cc43ab43c..95a665cb2f33 100644
--- a/drivers/net/ethernet/intel/idpf/xsk.c
+++ b/drivers/net/ethernet/intel/idpf/xsk.c
@@ -401,6 +401,7 @@ int idpf_xskfq_init(struct idpf_buf_queue *bufq)
 	bufq->pending = fq.pending;
 	bufq->thresh = fq.thresh;
 	bufq->rx_buf_size = fq.buf_len;
+	bufq->truesize = fq.truesize;
 
 	if (!idpf_xskfq_refill(bufq))
 		netdev_err(bufq->pool->netdev,
diff --git a/drivers/net/ethernet/intel/libeth/xsk.c b/drivers/net/ethernet/intel/libeth/xsk.c
index 846e902e31b6..4882951d5c9c 100644
--- a/drivers/net/ethernet/intel/libeth/xsk.c
+++ b/drivers/net/ethernet/intel/libeth/xsk.c
@@ -167,6 +167,7 @@ int libeth_xskfq_create(struct libeth_xskfq *fq)
 	fq->pending = fq->count;
 	fq->thresh = libeth_xdp_queue_threshold(fq->count);
 	fq->buf_len = xsk_pool_get_rx_frame_size(fq->pool);
+	fq->truesize = xsk_pool_get_rx_frag_step(fq->pool);
 
 	return 0;
 }
diff --git a/include/net/libeth/xsk.h b/include/net/libeth/xsk.h
index 481a7b28e6f2..82b5d21aae87 100644
--- a/include/net/libeth/xsk.h
+++ b/include/net/libeth/xsk.h
@@ -597,6 +597,7 @@ __libeth_xsk_run_pass(struct libeth_xdp_buff *xdp,
  * @pending: current number of XSkFQEs to refill
  * @thresh: threshold below which the queue is refilled
  * @buf_len: HW-writeable length per each buffer
+ * @truesize: step between consecutive buffers, 0 if none exists
  * @nid: ID of the closest NUMA node with memory
  */
 struct libeth_xskfq {
@@ -614,6 +615,8 @@ struct libeth_xskfq {
 	u32			thresh;
 
 	u32			buf_len;
+	u32			truesize;
+
 	int			nid;
 };
 
-- 
2.52.0

