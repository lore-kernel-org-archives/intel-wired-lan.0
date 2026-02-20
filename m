Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FC3C54FCC
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Feb 2026 07:30:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1BA541828;
	Fri, 20 Feb 2026 07:30:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5-t8IxZITrCa; Fri, 20 Feb 2026 07:30:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3E20741821
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771572634;
	bh=6Y0wu0m2S+xmvajj4wnruotNKsfdEgel5Qle4IIau5c=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MymbB+hJR2mkm52NozhIfMg0yTQWy1ZdEfwlxT/+P9JtH2Ax+dWv42S7ceq2RkCde
	 nkQoSEoLbZnpMvZRsoqENcD9XqluhDF9/SF7bZLJ4luev9DajGGLIHNWtXR9L9yca9
	 8o0+Ci1oC4SFd2Nzt8H4WOCOd+8AMpkCX+Yz5roDzAcTy/3SFmHIjNn3Sn6/gqMpEg
	 MsqiqMMHHafrRGYdJ4Fhn05c2R/SdJc/bfB6j4qZMwxMsgaSPT8OVs+FDM46kSrQ5z
	 ayjGS4EBjpyfFFVXd6Za0i7f7ssVN+fUCYrrR2IXvXtuN0uuE06wS3iqud0M9/kQIl
	 bXWJmsJ1LYwLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E20741821;
	Fri, 20 Feb 2026 07:30:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C1E7183
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Feb 2026 07:30:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 65AAF4181D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Feb 2026 07:30:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J8LriNBSz2_K for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Feb 2026 07:30:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D7A7941821
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D7A7941821
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D7A7941821
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Feb 2026 07:30:29 +0000 (UTC)
X-CSE-ConnectionGUID: 57iR9/2aTeeIuFihoslSOg==
X-CSE-MsgGUID: jzBLR+amTSyP7RStJdKotQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="95286635"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="95286635"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 23:30:30 -0800
X-CSE-ConnectionGUID: WSwxpYZlRgm87c0AWpJaXw==
X-CSE-MsgGUID: sKGreoBqSgC8y2H7JQDauA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="219289839"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa004.jf.intel.com with ESMTP; 19 Feb 2026 23:30:28 -0800
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com, horms@kernel.org,
 marcin.szycik@linux.intel.com
Date: Fri, 20 Feb 2026 08:30:24 +0100
Message-ID: <20260220073025.654391-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220073025.654391-1-aleksandr.loktionov@intel.com>
References: <20260220073025.654391-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771572630; x=1803108630;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=t0chq214HkHrpgpq/8q/aGOsHgiMN8Wk/jEfJVeixCU=;
 b=aVaD2V9Q7xDzVPymJhzcK8Ixk2B4weY88Rw97qs/pTWIU0u725WFJyU/
 zk0Kc8oiTk3AmUx8pa/10zaSgP++/LaMrn/244LKgZ4j6xiV/ZfgFmuFC
 Vzp0lPpTZ/Qtlk8P1Ex3/fsIAYddNGEkmrQ5g7jFwalZJewqX1hmI6D6/
 AYpjO4+TnicCqCdGlRfUPUSKAjh6WgzDw6kDSNLAYtxHoEpGAfoVmPfhu
 8MEG9Xxs/RsWv3QEetWxJPrJIFKJlDRZQYb/UHYCHnlemJbXnwPtrtIb2
 zCJEU1BIXGbK1/haY7IQcFoRPsIAwb9hVhb1P8aC4P8xgieQj3rJEhiAz
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=aVaD2V9Q
Subject: [Intel-wired-lan] [PATCH iwl-next v3 1/2] ethtool: treat
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

