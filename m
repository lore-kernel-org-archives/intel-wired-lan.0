Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F58E6E811
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Feb 2026 11:21:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2383440995;
	Tue,  3 Feb 2026 11:21:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MYaEpbFUXXFY; Tue,  3 Feb 2026 11:21:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6273840A8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770117717;
	bh=pPmZGYuZnWQ1IfnA/NAkgV5/f1y3GEJoUzbWenaYx+8=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0fFdaMMvH3bYabRai7OTj0nDuPCWb4f/7bTbvG0wjMfRcvLVH6CgSXvM2Z6uVmJDf
	 MkY0PSSfcvHf7YTp4RWOTGlNBHUT0gcksDOrdUphya7arZqkVtcw6BTJ+cE1iC7fNT
	 vd+EonEUXoLU800Bb4PDSTcwgm9p6QnCgkM1ODrcAYQ2G0hP+GqY5+LsUon6vsx5bI
	 /zagAsg2IdtiqC1rX6J2RpXgbfKQtIcMHXZpSryjZPCN4AOhbp0xcEZnoQ/v4zzJK9
	 qzilF5oztMLpoN3wq13JONI7G5qsDpO7KGOJXeT4B4/SDqVJm1iiPokg1wk43r+RVm
	 PCmeyQfN0BY6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6273840A8B;
	Tue,  3 Feb 2026 11:21:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F532F4
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Feb 2026 11:21:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 08EF5407AC
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Feb 2026 11:21:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UMyyYUnyYj3O for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Feb 2026 11:21:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=larysa.zaremba@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org DFA3440995
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DFA3440995
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DFA3440995
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Feb 2026 11:21:54 +0000 (UTC)
X-CSE-ConnectionGUID: qjDRljIrSb2vyQWNrcexUQ==
X-CSE-MsgGUID: T+a4DfkRS62ZE+1XFJuLEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71185906"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; d="scan'208";a="71185906"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2026 03:21:55 -0800
X-CSE-ConnectionGUID: p/mtr53nRW6E40VGjLXJkw==
X-CSE-MsgGUID: UmtALSepRCmNsZNjjBRjJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; d="scan'208";a="209913265"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orviesa007.jf.intel.com with ESMTP; 03 Feb 2026 03:21:46 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 367042819A;
 Tue,  3 Feb 2026 11:21:43 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: bpf@vger.kernel.org
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
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
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Tushar Vyavahare <tushar.vyavahare@intel.com>,
 Jason Xing <kernelxing@tencent.com>,
 =?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
 Eelco Chaudron <echaudro@redhat.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Toke Hoiland-Jorgensen <toke@redhat.com>, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Date: Tue,  3 Feb 2026 11:53:32 +0100
Message-ID: <20260203105417.2302672-5-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203105417.2302672-1-larysa.zaremba@intel.com>
References: <20260203105417.2302672-1-larysa.zaremba@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770117716; x=1801653716;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=w2laI/1xWTN2MQd5zfvU/4r5OmrtUd+BSNajThb98Gs=;
 b=KRua5UrN4sBlMCEprESYiygEGZYkOKIqj49GmA687+ZdxPlYkPfqwHqL
 TbHcSL1Pic3Xw+E+6Po08VQzr8PYbEU/ofUScNOc3E+xl+cWlz/wOjE+H
 Yo0wvWQrxgsBs9k60dnQhI6EtSQNTkE7yr0vYx/gbH8t623XFPgIoy1x6
 bY1X0WJGJ/E9M29OiqZzoFROa6fTpW/Nbxh9+4p7p6kSIGDuiahypMpWJ
 u8YFEAkO/scezpw4RmNSL3pikj8SphnoOk2iXQudTsM8dNrYqt+ppjFLS
 IQiu4JBZnuYrTTC/fZhKWKuVnSoZ8ejlqbwNBWpDEUI6k70o9/qhMHJ4o
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=KRua5UrN
Subject: [Intel-wired-lan] [PATCH bpf 4/6] i40e: use truesize as XDP RxQ
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
bpf_xdp_frags_increase_tail(). It clearly expects truesize instead of DMA
write size. Different assumptions in i40e driver configuration lead to
negative tailroom.

Set frag_size to the same value as frame_sz.

Fixes: a045d2f2d03d ("i40e: set xdp_rxq_info::frag_size")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 0b1cc0481027..72a33aa3e1f3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3561,6 +3561,7 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 	struct i40e_vsi *vsi = ring->vsi;
 	u32 chain_len = vsi->back->hw.func_caps.rx_buf_chain_len;
 	u16 pf_q = vsi->base_queue + ring->queue_index;
+	u32 truesize = i40e_rx_pg_size(ring) / 2;
 	struct i40e_hw *hw = &vsi->back->hw;
 	struct i40e_hmc_obj_rxq rx_ctx;
 	int err = 0;
@@ -3581,7 +3582,7 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 		err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
 					 ring->queue_index,
 					 ring->q_vector->napi.napi_id,
-					 ring->rx_buf_len);
+					 truesize);
 		if (err)
 			return err;
 	}
@@ -3614,7 +3615,7 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 	}
 
 skip:
-	xdp_init_buff(&ring->xdp, i40e_rx_pg_size(ring) / 2, &ring->xdp_rxq);
+	xdp_init_buff(&ring->xdp, truesize, &ring->xdp_rxq);
 
 	rx_ctx.dbuff = DIV_ROUND_UP(ring->rx_buf_len,
 				    BIT_ULL(I40E_RXQ_CTX_DBUFF_SHIFT));
-- 
2.52.0

