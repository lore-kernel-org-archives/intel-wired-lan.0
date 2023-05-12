Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17197C77B7C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 12 May 2023 15:29:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C72A142CC8;
	Fri, 12 May 2023 15:29:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C72A142CC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1683905376;
	bh=gBxjwlReq7TndV7okD3eIdl3s2Zt++zJY1yPo0MdoFQ=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=eCQj6owP28lASPh4++y9iMOS7offedQrlR2v53A5Fk58c2wlpCLUoDp7wxP/pgwQR
	 xpZAcP1Y/jRsjqsrSWZWyKyCGceVjFKfSdFo/S8J6SCqgg1pom7l81K4IhdAPflUd9
	 NiXXBZcYpE+G11IMTIFcPkOzh8nhP6eAZ3VA1Qxx40ACGfTWbfc2KP+xEJJ3wvIdRn
	 2LFfyjiXTBDcHlwCXlESXZwxNU1DtaiTeWv56rUZol2riH1vhfLHuaPm06fxokh5Og
	 yU+bVdEp1hH2DVnLqWUd1GhDm5URdplm6nTfhOlwKQmSrcP1HCIzEzWhLdrTGkEmjp
	 LRn0JUVlRD+WQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r5d9-mMeGoXC; Fri, 12 May 2023 15:29:35 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 88AA042CC9;
	Fri, 12 May 2023 15:29:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 88AA042CC9
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id A415F1BF2CB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 12 May 2023 15:29:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8A10D6137C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 12 May 2023 15:29:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8A10D6137C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UcgptasS1WmW for <intel-wired-lan@lists.osuosl.org>;
 Fri, 12 May 2023 15:29:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DB94D60B42
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DB94D60B42
 for <intel-wired-lan@lists.osuosl.org>; Fri, 12 May 2023 15:29:07 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="437151076"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; d="scan'208";a="437151076"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2023 08:29:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="946665781"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; d="scan'208";a="946665781"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmsmga006.fm.intel.com with ESMTP; 12 May 2023 08:29:02 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id C259335FB7;
 Fri, 12 May 2023 16:29:00 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: bpf@vger.kernel.org
Date: Fri, 12 May 2023 17:26:05 +0200
Message-Id: <20230512152607.992209-14-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230512152607.992209-1-larysa.zaremba@intel.com>
References: <20230512152607.992209-1-larysa.zaremba@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1683905347; x=1715441347;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ju9PvqXqCCJFMNbWyzPaBdJfLC40q1RU30A9+HNOEsU=;
 b=IhS3ZL2awnnspfK2lAg70D0TMLZsmiGEOt8KQ8vRcPABweAdBjtcOCNL
 kW2ITWoeG5TzCwdZoDcj5Wrf7OxKBrbwCzy/4sJegwrQwDyDLv+W3BoMf
 nEOuSsIvvjYaIICV1OnENSQr+BjAWPFpS7qLrinbSkqAgx7ZBP3+lWif6
 ArHgC3SSye7/oHonYJxrMjnO1Dprttjf/hGZfHbPASdhfAJDSAGcIkkbx
 cqtJUiRbSSGUERz7fglueBK3u8cPCYrCpFeVk1ZMD5awmf5YvXrX/QbwM
 hVmhsESqtfU0MxxoRB/uKJXhwXmfqueuCKqgfLQZt+/cTeOB1m5NYvFCi
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=IhS3ZL2a
Subject: [Intel-wired-lan] [PATCH RESEND bpf-next 13/15] selftests/bpf:
 Allow VLAN packets in xdp_hw_metadata
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Anatoly Burakov <anatoly.burakov@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <song@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Stanislav Fomichev <sdf@google.com>, Maryam Tahhan <mtahhan@redhat.com>,
 xdp-hints@xdp-project.net, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 intel-wired-lan@lists.osuosl.org, Jesper Dangaard Brouer <brouer@redhat.com>,
 Yonghong Song <yhs@fb.com>, Larysa Zaremba <larysa.zaremba@intel.com>,
 KP Singh <kpsingh@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Make VLAN c-tag and s-tag XDP hint testing more convenient
by not skipping VLAN-ed packets.

Allow both 802.1ad and 802.1Q headers.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 tools/testing/selftests/bpf/progs/xdp_hw_metadata.c | 9 ++++++++-
 tools/testing/selftests/bpf/xdp_metadata.h          | 8 ++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
index b2dfd7066c6e..f95f82a8b449 100644
--- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
@@ -26,15 +26,22 @@ int rx(struct xdp_md *ctx)
 {
 	void *data, *data_meta, *data_end;
 	struct ipv6hdr *ip6h = NULL;
-	struct ethhdr *eth = NULL;
 	struct udphdr *udp = NULL;
 	struct iphdr *iph = NULL;
 	struct xdp_meta *meta;
+	struct ethhdr *eth;
 	int err;
 
 	data = (void *)(long)ctx->data;
 	data_end = (void *)(long)ctx->data_end;
 	eth = data;
+
+	if (eth + 1 < data_end && eth->h_proto == bpf_htons(ETH_P_8021AD))
+		eth = (void *)eth + sizeof(struct vlan_hdr);
+
+	if (eth + 1 < data_end && eth->h_proto == bpf_htons(ETH_P_8021Q))
+		eth = (void *)eth + sizeof(struct vlan_hdr);
+
 	if (eth + 1 < data_end) {
 		if (eth->h_proto == bpf_htons(ETH_P_IP)) {
 			iph = (void *)(eth + 1);
diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/selftests/bpf/xdp_metadata.h
index 938a729bd307..6664893c2c77 100644
--- a/tools/testing/selftests/bpf/xdp_metadata.h
+++ b/tools/testing/selftests/bpf/xdp_metadata.h
@@ -9,6 +9,14 @@
 #define ETH_P_IPV6 0x86DD
 #endif
 
+#ifndef ETH_P_8021Q
+#define ETH_P_8021Q 0x8100
+#endif
+
+#ifndef ETH_P_8021AD
+#define ETH_P_8021AD 0x88A8
+#endif
+
 struct xdp_meta {
 	__u64 rx_timestamp;
 	__u64 xdp_timestamp;
-- 
2.35.3

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
