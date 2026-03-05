Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BFBF3094A
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Mar 2026 11:45:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5185440B81;
	Thu,  5 Mar 2026 11:45:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QpqzmAMpIgmh; Thu,  5 Mar 2026 11:45:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7D92340B6E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772711104;
	bh=UtIkqEnSTlL0gjlMklo8aA2do1nqVq99Ux7DhgGvuHU=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m6sJKS1Gj7wMdvEJl/PgUIgEpKjhAIuMMMEnGEyv137F+FZ/5nQw1rSVtLisJQcUG
	 IAcUDtRa34cNPDmfVmjLTvdWP3g3/z69D/CURHwvB00ZH1l7IRR3/rYU6A+k1kAsuE
	 crgFDrLBxx99ItLrBaaGnIfNgqd3zeI3CyuLFGM0Y/eem9TsDytbWxiNLj5On5W/pb
	 WhVFwN6WZwLsbNrK4g5HAJ+T+Mo73fqVtVTs12kL6T6JBf7JbBVPNOy++32GvmtKCA
	 pG8ivAyORaVMArasfjQh6VsuO1h5Umni20D0g4dShD0oBvkxfVdPzxRC0ycthpsvVk
	 hohEzh85RKKIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D92340B6E;
	Thu,  5 Mar 2026 11:45:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 97235223
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Mar 2026 11:45:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7C8CE81EA4
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Mar 2026 11:45:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 72lX9aFwojck for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Mar 2026 11:45:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=larysa.zaremba@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6763381EA8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6763381EA8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6763381EA8
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Mar 2026 11:45:01 +0000 (UTC)
X-CSE-ConnectionGUID: siICxcoFQP2fe/RXO8oGVw==
X-CSE-MsgGUID: qAnrxixhT2m1MmNB1Bvo3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="84428658"
X-IronPort-AV: E=Sophos;i="6.23,102,1770624000"; d="scan'208";a="84428658"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 03:45:01 -0800
X-CSE-ConnectionGUID: rGCH3VLBS96icEb6cqeaUw==
X-CSE-MsgGUID: PZyYL9u8RqqWqJ8kjYALKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,102,1770624000"; d="scan'208";a="223345273"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa005.fm.intel.com with ESMTP; 05 Mar 2026 03:44:53 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 6C28D28774;
 Thu,  5 Mar 2026 11:44:49 +0000 (GMT)
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
Date: Thu,  5 Mar 2026 12:12:44 +0100
Message-ID: <20260305111253.2317394-4-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260305111253.2317394-1-larysa.zaremba@intel.com>
References: <20260305111253.2317394-1-larysa.zaremba@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772711102; x=1804247102;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9ngdCx40vxsMrJJLnXWXwwMm56SN5bIPZC2rmtF04OI=;
 b=b3ifUfIDzg5ar4BZmD+4pWZfr2+Zz1PQjkUJtjjrLIhYlCGrqvTzyiXL
 1tWcxwws21JFvHtVLyU908qtZouDHxdh7jmh0n2dq9F+1BPPJj2NNV5+y
 FBf7OrB7/WUGq21GgTMwjB7zkltfbfLMxazWNSBB4wC6xyPIog0eoIWeU
 SuqH9w/S6G73UGTOcQFKO5aBEOU6jz6mWGLDaAAJnHY2b+uk/pW6k/WSZ
 JmEATy8JnN0DKQZ9TpxXYTvor3U0mLaBrFHQq88gjhGgt0NnHs0CPOFBW
 eUC9MHsSa6JACkS2d9wR+kDgt8FW4I9RsL7s9NJfAtdo3lHG9KHXrMuvQ
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=b3ifUfID
Subject: [Intel-wired-lan] [PATCH net v5 3/9] ice: fix rxq info registering
 in mbuf packets
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

XDP RxQ info contains frag_size, which depends on the MTU. This makes the
old way of registering RxQ info before calculating new buffer sizes
invalid. Currently, it leads to frag_size being outdated, making it
sometimes impossible to grow tailroom in a mbuf packet. E.g. fragments are
actually 3K+, but frag size is still as if MTU was 1500.

Always register new XDP RxQ info after reconfiguring memory pools.

Fixes: 2fba7dc5157b ("ice: Add support for XDP multi-buffer on Rx side")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c    | 26 ++++++--------------
 drivers/net/ethernet/intel/ice/ice_ethtool.c |  1 +
 drivers/net/ethernet/intel/ice/ice_txrx.c    |  4 ++-
 drivers/net/ethernet/intel/ice/ice_xsk.c     |  3 +++
 4 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index d85b0a4baa37..165ef8afa8b0 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -666,23 +666,12 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 
 	if (ring->vsi->type == ICE_VSI_PF || ring->vsi->type == ICE_VSI_SF ||
 	    ring->vsi->type == ICE_VSI_LB) {
-		if (!xdp_rxq_info_is_reg(&ring->xdp_rxq)) {
-			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
-						 ring->q_index,
-						 ring->q_vector->napi.napi_id,
-						 ring->rx_buf_len);
-			if (err)
-				return err;
-		}
-
 		ice_rx_xsk_pool(ring);
 		err = ice_realloc_rx_xdp_bufs(ring, ring->xsk_pool);
 		if (err)
 			return err;
 
 		if (ring->xsk_pool) {
-			xdp_rxq_info_unreg(&ring->xdp_rxq);
-
 			rx_buf_len =
 				xsk_pool_get_rx_frame_size(ring->xsk_pool);
 			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
@@ -705,14 +694,13 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 			if (err)
 				return err;
 
-			if (!xdp_rxq_info_is_reg(&ring->xdp_rxq)) {
-				err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
-							 ring->q_index,
-							 ring->q_vector->napi.napi_id,
-							 ring->rx_buf_len);
-				if (err)
-					goto err_destroy_fq;
-			}
+			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
+						 ring->q_index,
+						 ring->q_vector->napi.napi_id,
+						 ring->rx_buf_len);
+			if (err)
+				goto err_destroy_fq;
+
 			xdp_rxq_info_attach_page_pool(&ring->xdp_rxq,
 						      ring->pp);
 		}
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index b9be10b58856..301947d53ede 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3342,6 +3342,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 		rx_rings[i].cached_phctime = pf->ptp.cached_phc_time;
 		rx_rings[i].desc = NULL;
 		rx_rings[i].xdp_buf = NULL;
+		rx_rings[i].xdp_rxq = (struct xdp_rxq_info){ };
 
 		/* this is to allow wr32 to have something to write to
 		 * during early allocation of Rx buffers
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index a5bbce68f76c..a2cd4cf37734 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -560,7 +560,9 @@ void ice_clean_rx_ring(struct ice_rx_ring *rx_ring)
 			i = 0;
 	}
 
-	if (rx_ring->vsi->type == ICE_VSI_PF &&
+	if ((rx_ring->vsi->type == ICE_VSI_PF ||
+	     rx_ring->vsi->type == ICE_VSI_SF ||
+	     rx_ring->vsi->type == ICE_VSI_LB) &&
 	    xdp_rxq_info_is_reg(&rx_ring->xdp_rxq)) {
 		xdp_rxq_info_detach_mem_model(&rx_ring->xdp_rxq);
 		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index c673094663a3..0643017541c3 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -899,6 +899,9 @@ void ice_xsk_clean_rx_ring(struct ice_rx_ring *rx_ring)
 	u16 ntc = rx_ring->next_to_clean;
 	u16 ntu = rx_ring->next_to_use;
 
+	if (xdp_rxq_info_is_reg(&rx_ring->xdp_rxq))
+		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
+
 	while (ntc != ntu) {
 		struct xdp_buff *xdp = *ice_xdp_buf(rx_ring, ntc);
 
-- 
2.52.0

