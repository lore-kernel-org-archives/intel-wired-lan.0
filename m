Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB5CEEA845
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Feb 2026 19:03:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4FD0660AEC;
	Thu, 12 Feb 2026 19:03:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6a0E_Ju6VZpH; Thu, 12 Feb 2026 19:03:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 41A0660738
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770923015;
	bh=fQ4NBNKPgDHecTbGwaFNccE7bfLWi5URgc1y9NJPpqU=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rL4Oj8MGVs9h9bH/T6Adm7Oc5P/kh7w0Uikedv66rZyGS2Fl95Eqe2OZWRxE1vwhJ
	 BkAbRDj/7uuYFiTySkLrwBvFw3yBv2+8sMutMzXaA+0CMj8hZjrIlC+47T6hV4Ev4d
	 Y767ba50PePIy8FxuWw5l1qtbXUVUvHghO2+XSRzK1Cklu6DrtFWkR7aLmHAELA2a1
	 imQ8ZPtMITYaByKcNu6IkHk3FEKxwVfXZECCNQiDCQtgwuacLmWAKVEoUK8kvLzST9
	 YhCyQa2F8Wtcj9vxek6jU6JSlRz4i97zObyYMF+PmOVU3Xtatp9EnehjkxkDgP3oi5
	 w9IqVg5gOGAVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 41A0660738;
	Thu, 12 Feb 2026 19:03:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E723B1CA
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Feb 2026 19:03:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D855E4118D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Feb 2026 19:03:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WSlcwzEKW0yE for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Feb 2026 19:03:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=larysa.zaremba@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 00E0A40D6C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 00E0A40D6C
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 00E0A40D6C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Feb 2026 19:03:32 +0000 (UTC)
X-CSE-ConnectionGUID: lA2PTAePRL2I23U+49/f9A==
X-CSE-MsgGUID: Jqh/IgteQDG1zrULsopn8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72288687"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; d="scan'208";a="72288687"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 11:03:32 -0800
X-CSE-ConnectionGUID: 8/48eMQHTjK7DjeHHwgYWw==
X-CSE-MsgGUID: CVL8VXh6R7m5ZgQDetdyWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; d="scan'208";a="216886782"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa004.fm.intel.com with ESMTP; 12 Feb 2026 11:03:23 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id F143732C91;
 Thu, 12 Feb 2026 19:03:20 +0000 (GMT)
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
Date: Thu, 12 Feb 2026 19:33:22 +0100
Message-ID: <20260212183328.1883148-9-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212183328.1883148-2-larysa.zaremba@intel.com>
References: <20260212183328.1883148-2-larysa.zaremba@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770923013; x=1802459013;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GFXnOAyxtKR5V8VpPrssQCdBfk+tR0Ts3zMSPvStYnw=;
 b=SbfRkmz+xlTHIK9QdVfBSD5gphvhvkBvfktK7tyc5dRTwGVlvUfuURIs
 sFli40xoFQWLzQwVO00Wg3u//TRiFaO3IGdzTg89oi3YxSoSrBPrkOTSk
 tjApWDEP5Tc543qUabVxnWtt27z1KTXuBDPBTMYDb205zzL1MmydUyi88
 coRWosOUHtnWGhNPoAndANylQSBaGq5g0n7qOYCeNwLfyshaER6bhUruD
 +iQpE/nyxxMBNXBTkRoRA3T04T9Rd0CFzpwJw1TNcJX4gg2giZE6FzxsJ
 bJkuFPNqkwZb2ydaQX8Vd3MOVW8GV3WUNrjBqkNG+EY2LuJ00OMl+/CnZ
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=SbfRkmz+
Subject: [Intel-wired-lan] [PATCH bpf v2 7/9] idpf: use truesize as XDP RxQ
 info frag_size
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

Use rxq->truesize as a frag_size for singleq and truesize of the first bufq
in AF_XDP ZC, as there is only one. Disable growinf tail for regular
splitq.

Fixes: ac8a861f632e ("idpf: prepare structures to support XDP")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/idpf/xdp.c | 8 +++++++-
 drivers/net/ethernet/intel/idpf/xsk.c | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index 958d16f87424..a152c9a26976 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -46,11 +46,17 @@ static int __idpf_xdp_rxq_info_init(struct idpf_rx_queue *rxq, void *arg)
 {
 	const struct idpf_vport *vport = rxq->q_vector->vport;
 	bool split = idpf_is_queue_model_split(vport->rxq_model);
+	u32 frag_size = 0;
 	int err;
 
+	if (idpf_queue_has(XSK, rxq) && split)
+		frag_size = rxq->bufq_sets[0].bufq.truesize;
+	else if (!split)
+		frag_size = rxq->truesize;
+
 	err = __xdp_rxq_info_reg(&rxq->xdp_rxq, vport->netdev, rxq->idx,
 				 rxq->q_vector->napi.napi_id,
-				 rxq->rx_buf_size);
+				 frag_size);
 	if (err)
 		return err;
 
diff --git a/drivers/net/ethernet/intel/idpf/xsk.c b/drivers/net/ethernet/intel/idpf/xsk.c
index fd2cc43ab43c..febe1073b9b4 100644
--- a/drivers/net/ethernet/intel/idpf/xsk.c
+++ b/drivers/net/ethernet/intel/idpf/xsk.c
@@ -401,6 +401,7 @@ int idpf_xskfq_init(struct idpf_buf_queue *bufq)
 	bufq->pending = fq.pending;
 	bufq->thresh = fq.thresh;
 	bufq->rx_buf_size = fq.buf_len;
+	bufq->truesize = xsk_pool_get_rx_frag_step(fq.pool);
 
 	if (!idpf_xskfq_refill(bufq))
 		netdev_err(bufq->pool->netdev,
-- 
2.52.0

