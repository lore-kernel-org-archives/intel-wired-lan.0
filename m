Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51749C5AC7A
	for <intel-wired-lan@archiver.kernel.org>; Fri,  7 Aug 2026 10:24:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 02A43608ED;
	Fri,  7 Aug 2026 10:24:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1gyW64xWjhsa; Fri,  7 Aug 2026 10:23:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6AB24608EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786098239;
	bh=L43IJ5Fmp7XRg5gQpOH/X2pbYPnv/zQaRFLKxCcn6JM=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=yKU2bb3FtSdTxTdX/e0qElqFcJYNlSvQemjekgT0jfoIjbEKZuYLasw+1LAaqdbvc
	 sZZEWbwQlfQhICKzAlbZrAixMx2qxwn6O3kUBsYviVlRNv2RWHyW4YuHhYuB5w29uI
	 VIOnyALH9j216pIMt30QwMGVGgq+b266RGJznETWT88MOU0lIWxAwoLy/3tjqK5SKM
	 xuSCPnH+xUHt8H2Wj1TaPl7e/i5gw+bzClAsE2JcMhbLicyhgFx/NRZceVlv611RiB
	 kj6/O6Rg4rSks6u6Q09ULVt2jrJQUUROsq5nV23yzW1SmEdLVK4unnxwATVmxlcWsD
	 8oZz0T5DUqBfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6AB24608EE;
	Fri,  7 Aug 2026 10:23:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C007210E
 for <intel-wired-lan@lists.osuosl.org>; Fri,  7 Aug 2026 10:23:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9CE6F608EE
 for <intel-wired-lan@lists.osuosl.org>; Fri,  7 Aug 2026 10:23:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tcT10VrU2bTz for <intel-wired-lan@lists.osuosl.org>;
 Fri,  7 Aug 2026 10:23:57 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=jedrzej.jagielski@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7431B608ED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7431B608ED
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7431B608ED
 for <intel-wired-lan@lists.osuosl.org>; Fri,  7 Aug 2026 10:23:55 +0000 (UTC)
X-CSE-ConnectionGUID: zpqC6tgdS6ymyzJ+cq8UhQ==
X-CSE-MsgGUID: PBzV+N84TjedW52+ncmmEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="90381234"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="90381234"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2026 03:23:53 -0700
X-CSE-ConnectionGUID: baiEERPRRHm0GOb6ZwJ49g==
X-CSE-MsgGUID: WG5fssa3SCGkU8OuGXMnSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="265835216"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
 by orviesa003.jf.intel.com with ESMTP; 07 Aug 2026 03:23:51 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 kuba@kernel.org, jhs@mojatatu.com, jiri@resnulli.us, edumazet@google.com,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>, stable@vger.kernel.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Marcin Szycik <marcin.szycik@linux.intel.com>
Date: Fri,  7 Aug 2026 12:03:56 +0200
Message-Id: <20260807100356.1083774-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786098236; x=1817634236;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=KUpgVbn5nB2+AyKuxa3JNzzXGLajWAIhacWJDPIenwM=;
 b=bxBl/7SB31aIAoR/QiE26lOSRerVI4FQffJUGNa8n6xDjVVdOSLgGAHx
 A7ycEQnRpdno+cfmI0fyydgaKFsDhHWyzV/MylPbRk1wAdZYVIZqFg3cR
 hGb3Ci0+U4zjiiZVCyvcsOgCZOGG21T7LOWvVbI3jLYp2WMyr07axxtUF
 tx51Vkmo4mksOlZ3A1wQxkytTLagzBZfarfAn2S7+f5Q5eHd+CMl7fZjD
 5POiVdBg+AUA1ybwDTxDmeYUdHo1fnNGPvagYpDQyFONkTsUtfoIfHINt
 fLrjFGZF4vlhzUVwojmKALlr2507b9meb+5n6UVPKBC8FZOE8/6E174NN
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=bxBl/7SB
Subject: [Intel-wired-lan] [PATCH net v1] net/sched: cls_u32: feed
 u32_replace_hw_knode() with correct set of flags
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

Fix u32_change() to pass proper variable to u32_replace_hw_knode().

When trying to offload u32 cmd by adding skip_sw attributes it gets
ignored and it cannot be correctly processed by HW and tc_cls_u32_offload
struct which is then passed to driver lacks skip_sw var enabled.

u32_replace_hw_knode is fed with the TCA_ACT_* flags (bits 16+)
instead of TCA_CLS_* flags (bits 0-4) which actually stores the flags
parsed by tc, so tc_skip_sw() always returns false. This leads to
ignoring some of the attibutes which are meant to be configured on filter
setup.

None of the TCA_ACT_FLAGS_* is actually used within
u32_replace_hw_knode(), so there is no point in passing them.

Looks like commit 695176bfe5de ("net_sched: refactor TC action init API")
shadowed the local flags variable which used to be set with
nla_get_u32(tb[TCA_U32_FLAGS]) with the flags as the new function param
while not replacing for none of the u32_replace_hw_knode() calls.

Fixes: 695176bfe5de ("net_sched: refactor TC action init API")
Cc: <stable@vger.kernel.org>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 net/sched/cls_u32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 8f30cc82181d..dc6e455e64ec 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -935,7 +935,7 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 
 		u32_bind_filter(tp, new, base, tb);
 
-		err = u32_replace_hw_knode(tp, new, flags, extack);
+		err = u32_replace_hw_knode(tp, new, userflags, extack);
 		if (err) {
 			u32_unbind_filter(tp, new, tb);
 
@@ -1161,7 +1161,7 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		struct tc_u_knode __rcu **ins;
 		struct tc_u_knode *pins;
 
-		err = u32_replace_hw_knode(tp, n, flags, extack);
+		err = u32_replace_hw_knode(tp, n, userflags, extack);
 		if (err)
 			goto errunbind;
 
-- 
2.31.1

