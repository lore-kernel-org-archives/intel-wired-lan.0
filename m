Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451C9E909A4
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Feb 2026 14:01:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E5F208222B;
	Tue, 17 Feb 2026 14:01:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n7CLXGPcmbHS; Tue, 17 Feb 2026 14:01:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F279B82202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771336903;
	bh=V4mGl8Pd+La26gZ795rpOEDjuR4fs1GOIRInjic05Ww=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yLxbDqF6prXFQJXvGT/5mU8+dMIooo26kmvNa9lojbM7ZcmkEnaVe9X5sbvPrMst6
	 guZLNAn1872OgRkWE3AK1H4yX4hkJEISIwKnMkk3tocNPY3d84o6fzKe90TVveM2PA
	 eRIZCWXB1o5MNIWK/SkDF3rgUSa1zbYvk6R+b9ZgusZRNCkiNXQIaB6y+GD9Ee1WKL
	 TWBT++4woLMd0xO9qK7oifO39iJsu5lagbmcwjpyL/ql4TIkcdg81IeXeI+/HsHNtO
	 sfSpHnJPbSOuSOt34sUdXVr6KaXFmf4cO2renC/vXbzfJJqiy9puRtWTqUYbMg3MDe
	 PqQfClLRaEhig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F279B82202;
	Tue, 17 Feb 2026 14:01:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 39DC3206
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Feb 2026 14:01:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1C2EF40B72
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Feb 2026 14:01:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mpbgeZbvToRY for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Feb 2026 14:01:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=larysa.zaremba@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 237614094E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 237614094E
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 237614094E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Feb 2026 14:01:40 +0000 (UTC)
X-CSE-ConnectionGUID: XC9fR/3NRiqTw9khkc/8UA==
X-CSE-MsgGUID: hTUXtVnUQoixsY19VW02wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="72292084"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="72292084"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 05:54:35 -0800
X-CSE-ConnectionGUID: M0/7lVR3SV2gfOG2J3/CCQ==
X-CSE-MsgGUID: 5NsUMfFXQ9O3eOF8hloHpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="218421147"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa005.fm.intel.com with ESMTP; 17 Feb 2026 05:54:27 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id D88E328794;
 Tue, 17 Feb 2026 13:54:23 +0000 (GMT)
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
Date: Tue, 17 Feb 2026 14:24:39 +0100
Message-ID: <20260217132450.1936200-2-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260217132450.1936200-1-larysa.zaremba@intel.com>
References: <20260217132450.1936200-1-larysa.zaremba@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771336901; x=1802872901;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=B0kQDe2OjE89c7bJ4mHgExipwiqbMRAUVjBXVo37mn8=;
 b=UcE79uU8UtI0v+d9+sDloyfpX4Z7sfe0iMC+x8oBMsBsCVDxuG6cmXnL
 1DF9j3H8f5uZpX+APRxITjOCQheut2jAiPNmcVonuTIlkYql2guax/wIR
 3hhpZ6sA2/3YAwQjBDi0xMFHAyClFK79NVCBeC3J+1KWBlPJTpR59yRfB
 QoOyv0fNjYgTtUVVRFoI1ug8Nw56+QmkDHJz8iTqzMk0+mZH33LnulWj0
 GVfkmr1wln5gMWfOSeUD6FYvPsts/d8DZmuRVVdSZFWfagqsN6+Y7yRFA
 Oy/keRTgncPTUWUp8CkF+Y9JytfCbqSLMoFmepz2SvM0mm3y2KliDcPtB
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=UcE79uU8
Subject: [Intel-wired-lan] [PATCH bpf v3 1/9] xdp: use modulo operation to
 calculate XDP frag tailroom
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

The current formula for calculating XDP tailroom in mbuf packets works only
if each frag has its own page (if rxq->frag_size is PAGE_SIZE), this
defeats the purpose of the parameter overall and without any indication
leads to negative calculated tailroom on at least half of frags, if shared
pages are used.

There are not many drivers that set rxq->frag_size. Among them:
* i40e and enetc always split page uniformly between frags, use shared
  pages
* ice uses page_pool frags via libeth, those are power-of-2 and uniformly
  distributed across page
* idpf has variable frag_size with XDP on, so current API is not applicable
* mlx5, mtk and mvneta use PAGE_SIZE or 0 as frag_size for page_pool

As for AF_XDP ZC, only ice, i40e and idpf declare frag_size for it. Modulo
operation yields good results for aligned chunks, they are all power-of-2,
between 2K and PAGE_SIZE. Formula without modulo fails when chunk_size is
2K. Buffers in unaligned mode are not distributed uniformly, so modulo
operation would not work.

To accommodate unaligned buffers, we could define frag_size as
data + tailroom, and hence do not subtract offset when calculating
tailroom, but this would necessitate more changes in the drivers.

Define rxq->frag_size as an even portion of a page that fully belongs to a
single frag. When calculating tailroom, locate the data start within such
portion by performing a modulo operation on page offset.

Fixes: bf25146a5595 ("bpf: add frags support to the bpf_xdp_adjust_tail() API")
Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 net/core/filter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index ba019ded773d..5f5489665c58 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4156,7 +4156,8 @@ static int bpf_xdp_frags_increase_tail(struct xdp_buff *xdp, int offset)
 	if (!rxq->frag_size || rxq->frag_size > xdp->frame_sz)
 		return -EOPNOTSUPP;
 
-	tailroom = rxq->frag_size - skb_frag_size(frag) - skb_frag_off(frag);
+	tailroom = rxq->frag_size - skb_frag_size(frag) -
+		   skb_frag_off(frag) % rxq->frag_size;
 	if (unlikely(offset > tailroom))
 		return -EINVAL;
 
-- 
2.52.0

