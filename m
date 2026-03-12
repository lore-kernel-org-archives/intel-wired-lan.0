Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81480FED2F7
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Mar 2026 09:31:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3645084B24;
	Thu, 12 Mar 2026 09:31:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8czgVsCOQdgh; Thu, 12 Mar 2026 09:31:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3E70F84AD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773307868;
	bh=6Y0wu0m2S+xmvajj4wnruotNKsfdEgel5Qle4IIau5c=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hgyDzT4xfw4YHI/pp/mAV74t4QGozS/NF8Mw1OD5ZGziX3Abh9Y0uOUgHfSbkt7/m
	 d6QkmUunvQDs39ApjkjMe44TLzkikRfmz0XwLvTWNAE+lPsTBGTE3wRtibwEpg5rAR
	 YtBwTT11kjT6yK3YKPO9tkhVyFSR0VCZghyLQVnEek9LHfL2F5Y5pGipXhgqQNi8fo
	 pBKhvTZLgZbL9kC76sG9bDpXLjzO9GnuSvCI0FG13SUYyrC4BjCry4R2R519H3EAkH
	 dZ2Hu+yKwuJxFoLrItvmcjThfQnCLwL8dEZDPn/YP3yQLdsLAHuRWC3+y/+mI4nVz5
	 t8cq7+FpFPUZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E70F84AD5;
	Thu, 12 Mar 2026 09:31:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 22053201
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Mar 2026 09:31:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3E86484AB5
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Mar 2026 09:31:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sR6xKoUfLiFS for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Mar 2026 09:31:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9E0BB84AC9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9E0BB84AC9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9E0BB84AC9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Mar 2026 09:31:05 +0000 (UTC)
X-CSE-ConnectionGUID: ylaaagGnRaCEdV2A0aj+zg==
X-CSE-MsgGUID: +xyimjelRoGW5dVkR/vmSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="85868900"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; d="scan'208";a="85868900"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 02:31:06 -0700
X-CSE-ConnectionGUID: bDOwG0GwS7eeZpL6Ayssuw==
X-CSE-MsgGUID: hZVFNs2wTy2LXNCEk0H1ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; d="scan'208";a="223230606"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa004.fm.intel.com with ESMTP; 12 Mar 2026 02:31:04 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, aleksandr.loktionov@intel.com
Date: Thu, 12 Mar 2026 10:31:00 +0100
Message-ID: <20260312093101.1589970-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260312093101.1589970-1-aleksandr.loktionov@intel.com>
References: <20260312093101.1589970-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773307866; x=1804843866;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=t0chq214HkHrpgpq/8q/aGOsHgiMN8Wk/jEfJVeixCU=;
 b=EQq3DqKuBTFc3g4H6ytgaMSY6lXInuKwve2J+VzBi//CrsA/iC0FZWnP
 6vjbId3FFH3ospLc/T80uyf6lHLzBcZwofTxQhlNIYhq33z50cQ4+dqYs
 54R/Zor2lcPoNqShq7/Xtwmo04a2fI+z7Z6O6sv9eBFBdWsEFlnOY6PP9
 BC5vhzG34fgSAvxJu+94TWnaXoNiJEc/TYpgYDIiPBVAB9yaYO13zWyp5
 QGFAODsMkRT7szcnTDr5wLlXz0z7lTAWwZJQo73Pbt30S99Yn+LwysdLq
 TK9nrsirA0m96g3yrxHk1Hkk/wu8peB6WGIDDEMcht57Nv+lJFNiMVYHU
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=EQq3DqKu
Subject: [Intel-wired-lan] [PATCH iwl-next v4 1/2] ethtool: treat
 RXH_GTP_TEID as intrinsically symmetric
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

A GTP tunnel uses the same TEID value in both directions of a flow;
including TEID in the hash input does not break src/dst symmetry.

ethtool_rxfh_config_is_sym() currently rejects any hash field bitmap
that contains bits outside the four paired L3/L4 fields.  This causes
drivers that hash GTP flows on TEID to fail the kernel's preflight
validation in ethtool_check_flow_types(), making it impossible for
those drivers to support symmetric-xor transforms at all.

Strip RXH_GTP_TEID from the bitmap before the paired-field check so
that drivers may honestly report TEID hashing without blocking the
configuration of symmetric transforms.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 net/ethtool/common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 5fae329..9a3fd76 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -911,6 +911,9 @@ int ethtool_rxfh_config_is_sym(u64 rxfh)
 {
 	bool sym;
 
+	/* Strip TEID before checking - it carries no src/dst asymmetry */
+	rxfh &= ~(u64)RXH_GTP_TEID;
+
 	sym = rxfh == (rxfh & (RXH_IP_SRC | RXH_IP_DST |
 			       RXH_L4_B_0_1 | RXH_L4_B_2_3));
 	sym &= !!(rxfh & RXH_IP_SRC)   == !!(rxfh & RXH_IP_DST);
-- 
2.52.0

