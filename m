Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CF0E6E807
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Feb 2026 11:22:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A39B83C80;
	Tue,  3 Feb 2026 11:22:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 02CebWUaChDd; Tue,  3 Feb 2026 11:21:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 277B683C63
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770117719;
	bh=TayuPgzQ+qJ5M3O8xU4Ul0xYpIJ8Biwa5uskWOxqLBk=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ajW8lrAywfXlaHCoEz29294nexf5DC7FZNrIytwF8TknFtzkDEFimzhhlLE7rhi5M
	 nk9dmtpmt223lUGDwhJHsDERO56pzX3VKyXK9AqE/mIfFbKKqeF8PCBms/Ojv6LxSD
	 Vn3X+z4yhmQnSEosuPAI1ukvzgA58NQUHPgm50LRZL5TatboDCE2JSCdzGyeFzJonv
	 emB3sUoXVGom9mLGyWsf2E4hAVtFgeBpruF7NL/WkOdIBpRAZnzSYWTru4wTLC+N/Z
	 mm/6mVaDnGPc5oVBXJBk9E7VxXFQFHp2uughIg5+rl+SSWVzgSgMONtIHKFxnfW283
	 MoankMTnazGvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 277B683C63;
	Tue,  3 Feb 2026 11:21:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 62F671A6
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Feb 2026 11:21:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 405AC40995
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Feb 2026 11:21:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yGUpIrU-FqBK for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Feb 2026 11:21:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=larysa.zaremba@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3BA8D407AC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3BA8D407AC
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3BA8D407AC
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Feb 2026 11:21:56 +0000 (UTC)
X-CSE-ConnectionGUID: YiuxVn/FQsKcT6VcDhx9EA==
X-CSE-MsgGUID: HnG/6DX+RtenRclQV1hEMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71185922"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; d="scan'208";a="71185922"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2026 03:21:56 -0800
X-CSE-ConnectionGUID: 3yTk6wtERLeQgOP2czKlHQ==
X-CSE-MsgGUID: rT4JS999TziPmYsvVWtavQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; d="scan'208";a="209913269"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orviesa007.jf.intel.com with ESMTP; 03 Feb 2026 03:21:49 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 8CEB928195;
 Tue,  3 Feb 2026 11:21:45 +0000 (GMT)
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
Date: Tue,  3 Feb 2026 11:53:33 +0100
Message-ID: <20260203105417.2302672-6-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203105417.2302672-1-larysa.zaremba@intel.com>
References: <20260203105417.2302672-1-larysa.zaremba@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770117717; x=1801653717;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DoEHOpDkte0lq2Qu38Srj0S/5EmbLjXyklYvoIStbGQ=;
 b=ZRh+78elKePw+G4EkVYjTeNhhGeFw1GcHE+grgsmfTOa9qnjLuESx9Eo
 rQCvbHlXtF2u43S+kMQ7UEM5AUsew5iynKOJooFpZINRHsNydst5dpx+t
 VlNKfynzyGIAg6VGriOtXHkrUwbO/lnE0Q+A+ZbFGfvMu/Ii7mtZzyCdI
 Y91lMauCOuc/14a2pRNmTF1nogm/FxFhEvmRhUpLajB/IW4oF4pcYZnf3
 ZMk9xy2+tfZB22S8YhFgBoSpMO8qG4QH1oBCjn2mt0oVqismL0+kHrf4P
 AEphz5t4sQ6rJgBDrJ3r/IdMYqJNvWXFsTWIoKv+dxlYqo1aJsolOYZP1
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ZRh+78el
Subject: [Intel-wired-lan] [PATCH bpf 5/6] idpf: use truesize as XDP RxQ
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
write size. Different assumptions in idpf driver configuration lead to
negative tailroom.

Set frag_size to the same value as frame_sz.

Fixes: ac8a861f632e ("idpf: prepare structures to support XDP")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/idpf/xdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index 958d16f87424..4966376a9785 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -50,7 +50,7 @@ static int __idpf_xdp_rxq_info_init(struct idpf_rx_queue *rxq, void *arg)
 
 	err = __xdp_rxq_info_reg(&rxq->xdp_rxq, vport->netdev, rxq->idx,
 				 rxq->q_vector->napi.napi_id,
-				 rxq->rx_buf_size);
+				 rxq->truesize);
 	if (err)
 		return err;
 
-- 
2.52.0

