Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A22E6E812
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Feb 2026 11:22:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B95983C97;
	Tue,  3 Feb 2026 11:22:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T6MiT7yiS4Ii; Tue,  3 Feb 2026 11:22:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3553583C63
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770117722;
	bh=TTGEwZ18gYUGlp6FhIk5YO2Z/T5aWVKrxn+3g5hCPuQ=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DqU7u6YGO8eopZVOdonqFX8zaIAiNuZpIxta30dgAVdDtBOD/XEecuwJlRj4EFKBu
	 ZAu26F0ZGskyzqsmd4ysGIUodRdONGLZz6lJGI/sa0RNjniiF8j3mdnHrFgWwQ1BOJ
	 JSSJg6j0YcCS8FlrChZnTRGFjlbFvlGgTsY4NDrQQqcfQiNxdwCpHt5FWsXARjRAMA
	 k4+HjafWvKEl13kIEnMFao4dvV/BgsqpeYhS15bcZOYLFILZbQ35YIa4dJckDpYNW2
	 b3haSSpTM/NYR15dL9p2JaartJBR4ayR7G/TJijEyYexH/xNIm3CfjLTZzDuMP+cco
	 14GagYIt10Xqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3553583C63;
	Tue,  3 Feb 2026 11:22:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A8F161A6
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Feb 2026 11:22:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8712E40A7B
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Feb 2026 11:22:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d9a_N1sylFu2 for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Feb 2026 11:21:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=larysa.zaremba@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8844640A8B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8844640A8B
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8844640A8B
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Feb 2026 11:21:59 +0000 (UTC)
X-CSE-ConnectionGUID: sV9bufwdTZecbLvsLro05g==
X-CSE-MsgGUID: jfLKZZpIQjif+gkrcgsIYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71185945"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; d="scan'208";a="71185945"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2026 03:22:00 -0800
X-CSE-ConnectionGUID: DM+ZiF5ZTyS1qURgMAkgVw==
X-CSE-MsgGUID: otFw1S5dQteqm3gH1/y13Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; d="scan'208";a="209913299"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orviesa007.jf.intel.com with ESMTP; 03 Feb 2026 03:21:51 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id DC38E28196;
 Tue,  3 Feb 2026 11:21:47 +0000 (GMT)
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
Date: Tue,  3 Feb 2026 11:53:34 +0100
Message-ID: <20260203105417.2302672-7-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203105417.2302672-1-larysa.zaremba@intel.com>
References: <20260203105417.2302672-1-larysa.zaremba@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770117720; x=1801653720;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=I/ds7VPivI7MC56xPmzXpkEugesnbH4oVfiwGT7GqoU=;
 b=BrVl0dLD4kqwsgvqpoZz3qYb4hv2yG+JNIPmh/I/7dZIsQ4B7zryN709
 2pJ6lsVPiBjTQ67GTmw7GKFE084c+0KyvG7eWeJbDhq7J10AWgYtIB6/E
 1sAFNxWjSMJh71zSjoJOHyX+3ENlwHXB6hnM04STndIES+F14py34DZSj
 6O2HvCgu28ozEDF/6dFgM4EQ1lhAl4IYB+rx5+KxnEuMr0m6QeqkhjFfU
 6B9Hmd100GtDFSU1FC9g9zi4R0mRZz3oPe7aYzOifsQKDhti0a8Fxcsk9
 Zh//dGFOwObFLvjorrN5kpknDGFtRd6ndsBItyIhvY5Qj1W3PAZJqxl2U
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=BrVl0dLD
Subject: [Intel-wired-lan] [PATCH bpf 6/6] net: enetc: use truesize as XDP
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
bpf_xdp_frags_increase_tail(). It clearly expects truesize instead of DMA
write size. Different assumptions in enetc driver configuration lead to
negative tailroom.

Set frag_size to the same value as frame_sz.

Fixes: 2768b2e2f7d2 ("net: enetc: register XDP RX queues with frag_size")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 53b26cece16a..389331571d9e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -3465,7 +3465,7 @@ static int enetc_int_vector_init(struct enetc_ndev_priv *priv, int i,
 	priv->rx_ring[i] = bdr;
 
 	err = __xdp_rxq_info_reg(&bdr->xdp.rxq, priv->ndev, i, 0,
-				 ENETC_RXB_DMA_SIZE_XDP);
+				 ENETC_RXB_TRUESIZE);
 	if (err)
 		goto free_vector;
 
-- 
2.52.0

