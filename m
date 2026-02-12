Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD641EEA845
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Feb 2026 19:03:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F0CF40B29;
	Thu, 12 Feb 2026 19:03:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dziaSVo2OMEa; Thu, 12 Feb 2026 19:03:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AC88240B56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770923011;
	bh=y4YYl8jxarfI0mNXsBZw26zE/1ngdPvSR5ay4OBNxqE=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iW5pf9a+6M5ETQhzO5INIPHXTqhVAlX3pMd6Fihq1WI5j7FwSRTMxz9heiVaWa69T
	 nVQmFlVg8j2d4XsNrubiDz2/hajn+4/Djtu3DZqcXtWjKXPyWkinJ/898Lr3HGFztR
	 EdGllq54uaYeTUVv31EjUjorhVfiORRy3rUF+l2QhrdsTkSfI7yeVEAgTV48sTcl5o
	 r3Wcx16rkPBFCmAQUY0BWkNiEecskIANB5URdts0x7HVH6VkO/bu8O8XDnxHJxmrXu
	 zlg7EH9ZN0BCY/ngmtyXSDD1anEJccUUDOOF/qMeRgaadAdFbl/bOH1wcMRv8T5tea
	 9/XFZSnpi9dyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC88240B56;
	Thu, 12 Feb 2026 19:03:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CA1A8EC
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Feb 2026 19:03:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B852783FEC
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Feb 2026 19:03:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uX8BwiGGdfop for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Feb 2026 19:03:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=larysa.zaremba@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B5E4883FEA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B5E4883FEA
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B5E4883FEA
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Feb 2026 19:03:28 +0000 (UTC)
X-CSE-ConnectionGUID: AaLnSk28RAGxKF8KYJ5P8w==
X-CSE-MsgGUID: aFMLnK9ISLqs+ScHIK9Zrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="94746033"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; d="scan'208";a="94746033"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 11:03:28 -0800
X-CSE-ConnectionGUID: YCiwgCQ4TmGUPWUxmGdPHw==
X-CSE-MsgGUID: fHKWl1iOS2uNELrZbKjFzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; d="scan'208";a="211921998"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa010.fm.intel.com with ESMTP; 12 Feb 2026 11:03:21 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id D9BB932C94;
 Thu, 12 Feb 2026 19:03:17 +0000 (GMT)
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
Date: Thu, 12 Feb 2026 19:33:21 +0100
Message-ID: <20260212183328.1883148-8-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212183328.1883148-2-larysa.zaremba@intel.com>
References: <20260212183328.1883148-2-larysa.zaremba@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770923009; x=1802459009;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JE0C6b7Po6nb+SOJSwLm3q0OgKRucrNQZcdmHovdwT0=;
 b=Jm5m4xbwnQIFWtchVb9xOY/YZm2+aSY2/nHLpC9dZ5HtHznT851VtYUT
 P++ly18pUy5GzK3q2asslOPFhcSgs6GFS4VmHeScB2/8gD5ejFGImrE5G
 yEGZWhCkaYXMZmtL0k8E2QhIX4Qru71yB7lUlrBfoKLvL7t4XioMJXZCx
 vrF+Q2NQQujvrTTQN1elBLw74vkMYFiaGYTIKtIgOJKBmb169/H0HfBgt
 MX8xhFx4SCKl+r5PGzYAU+qD/vs9tE1L4xaL0t/7L3kAZnDNheiJX2RCp
 LQMCbV7Opq9hf1dLh+YkJRZteFSSKP+/bkA859ow1pf18ecBO6NkELbIr
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Jm5m4xbw
Subject: [Intel-wired-lan] [PATCH bpf v2 6/9] i40e: use xdp.frame_sz as XDP
 RxQ info frag_size
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
of DMA write size. Different assumptions in i40e driver configuration lead
to negative tailroom.

Set frag_size to the same value as frame_sz in shared pages mode, use new
helper to set frag_size when AF_XDP ZC is active.

Fixes: a045d2f2d03d ("i40e: set xdp_rxq_info::frag_size")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index eaa5b65e6daf..f91157774f1d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3563,6 +3563,7 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 	u16 pf_q = vsi->base_queue + ring->queue_index;
 	struct i40e_hw *hw = &vsi->back->hw;
 	struct i40e_hmc_obj_rxq rx_ctx;
+	u32 xdp_frame_sz = 0;
 	int err = 0;
 	bool ok;
 
@@ -3579,11 +3580,12 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 
 	ring->xsk_pool = i40e_xsk_pool(ring);
 	if (ring->xsk_pool) {
+		xdp_frame_sz = xsk_pool_get_rx_frag_step(ring->xsk_pool);
 		ring->rx_buf_len = xsk_pool_get_rx_frame_size(ring->xsk_pool);
 		err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
 					 ring->queue_index,
 					 ring->q_vector->napi.napi_id,
-					 ring->rx_buf_len);
+					 xdp_frame_sz);
 		if (err)
 			return err;
 		err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
@@ -3596,10 +3598,11 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 			 ring->queue_index);
 
 	} else {
+		xdp_frame_sz = i40e_rx_pg_size(ring) / 2;
 		err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
 					 ring->queue_index,
 					 ring->q_vector->napi.napi_id,
-					 ring->rx_buf_len);
+					 xdp_frame_sz);
 		if (err)
 			return err;
 		err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
@@ -3610,7 +3613,7 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 	}
 
 skip:
-	xdp_init_buff(&ring->xdp, i40e_rx_pg_size(ring) / 2, &ring->xdp_rxq);
+	xdp_init_buff(&ring->xdp, xdp_frame_sz, &ring->xdp_rxq);
 
 	rx_ctx.dbuff = DIV_ROUND_UP(ring->rx_buf_len,
 				    BIT_ULL(I40E_RXQ_CTX_DBUFF_SHIFT));
-- 
2.52.0

