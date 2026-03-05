Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAB9F3093A
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Mar 2026 11:45:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5483481776;
	Thu,  5 Mar 2026 11:45:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W3SI0gmKpEXp; Thu,  5 Mar 2026 11:45:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 51D2F81EAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772711115;
	bh=VxNYITa+b7W0YT4VM1CqtAl2T71AGFXKYRIv1H8f6Ok=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YXqvP0+VZxZWLeMGTiHHPihSZu6VNR9XNWwCm+nuL6dsMBx/mgUTzabMVqvS02XVF
	 OIQX5RxzkoGiPYvnGg4U4VQ46EYk7QT97FgzBu8rPk/oyX/6Aa/f7iZMsppmI11d9g
	 IRzdEN20BWRG4fcDmct85RyYhr9zoD+MRg5ZUYJEL+CLuofHtxxOx8CgpstOmBCAGU
	 4mQnIjwcYHRXmHg7NRTZBeZRDFu33TGRtV6cX91+SU0TdAosXcr3SDHPV0sTzFPsl4
	 0lQgSPbJ0SrKT618lrnYVLUOAKhZzlsa5Zku/Ajm3CyNB99y9OY9EToutGLCLgwspC
	 cNe4ZvdJtJcJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51D2F81EAC;
	Thu,  5 Mar 2026 11:45:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 79BEF25B
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Mar 2026 11:45:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5F8C081EB2
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Mar 2026 11:45:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 47rJnHRK762f for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Mar 2026 11:45:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=larysa.zaremba@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5B63081EAC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5B63081EAC
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5B63081EAC
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Mar 2026 11:45:13 +0000 (UTC)
X-CSE-ConnectionGUID: PcuXftuSRXq88SROMlzLvA==
X-CSE-MsgGUID: q46j2GtwQ66gJryAs5YKkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="84428742"
X-IronPort-AV: E=Sophos;i="6.23,102,1770624000"; d="scan'208";a="84428742"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 03:45:13 -0800
X-CSE-ConnectionGUID: bEG5wXzUTZOzLNsiD4UD2A==
X-CSE-MsgGUID: khhh8KZYTwO0y7595bpD5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,102,1770624000"; d="scan'208";a="223345396"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa005.fm.intel.com with ESMTP; 05 Mar 2026 03:45:05 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 4F54F28778;
 Thu,  5 Mar 2026 11:45:02 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
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
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-kselftest@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Dragos Tatulea <dtatulea@nvidia.com>,
 Magnus Karlsson <magnus.karlsson@intel.com>
Date: Thu,  5 Mar 2026 12:12:48 +0100
Message-ID: <20260305111253.2317394-8-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260305111253.2317394-1-larysa.zaremba@intel.com>
References: <20260305111253.2317394-1-larysa.zaremba@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772711113; x=1804247113;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TZEXOfIR3nqd7pS9W9oFFIwS02GXdOuLJMeGp51CQyU=;
 b=W9zE7JL8UyYeRrFktDH73uJjNJSPq6iNJvfz3r9Ge27Q4jgpv7ArJcG3
 oI4sUH2a0QWYs3/IRSJIqMbzQhFCaDHvm35LUl7WObHUBMTsBqPRtTZQs
 q5REixhWJr7GcheKnZGJpUG0O0rXMDBYf5nI4+g8oUXX5m4MQhnCjDKEC
 EmMv7y6K9ZT+2VqcVGWb/DTjquJLNukCSOo/X/y8L9Lb6CCHU2h6rlaOh
 1TieetGui+FX+8aKDvM5DBp7IuZVhZoAJyly6O80kPpimtfTtlZcwBrkS
 LrZfN3LQkWOjMMSE9RbJSX/Vj/dUyZS5oNFxbB45sHc9vKRoThWXIPXuy
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=W9zE7JL8
Subject: [Intel-wired-lan] [PATCH net v5 7/9] libeth,
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
growing tail for regular splitq.

Fixes: ac8a861f632e ("idpf: prepare structures to support XDP")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/idpf/xdp.c   | 6 +++++-
 drivers/net/ethernet/intel/idpf/xsk.c   | 1 +
 drivers/net/ethernet/intel/libeth/xsk.c | 1 +
 include/net/libeth/xsk.h                | 3 +++
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index 6ac9c6624c2a..cbccd4546768 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -47,12 +47,16 @@ static int __idpf_xdp_rxq_info_init(struct idpf_rx_queue *rxq, void *arg)
 {
 	const struct idpf_vport *vport = rxq->q_vector->vport;
 	const struct idpf_q_vec_rsrc *rsrc;
+	u32 frag_size = 0;
 	bool split;
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
index 676cbd80774d..d95d3efdfd36 100644
--- a/drivers/net/ethernet/intel/idpf/xsk.c
+++ b/drivers/net/ethernet/intel/idpf/xsk.c
@@ -403,6 +403,7 @@ int idpf_xskfq_init(struct idpf_buf_queue *bufq)
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

