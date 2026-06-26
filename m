Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD798CDE011
	for <intel-wired-lan@archiver.kernel.org>; Fri, 26 Jun 2026 05:47:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8840182100;
	Fri, 26 Jun 2026 05:47:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8AKo_Y7cCrZE; Fri, 26 Jun 2026 05:47:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C91D4821AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1782452856;
	bh=YFyK9Oqgfq6kyY7eL0ZXTk+UzohKrWINlFygaLd7fhc=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r207ghv2vIJzurQrP4M12C+JnQ5rpHDrAelh6YdmjqDO0+J7qt3HNKMIPMQefnGnf
	 669zK66fLlywmtNy8ShUPdHO+yJdj2BARZ8wKPXKfSY1ukFeRLFTJFb7/lhuQEod8T
	 i+1zD5nVXy4fdLuZ7cILp4F5fF482JnHyQ5jO7dLPkGBPMMRddfOX9n2cKFtSTL7UT
	 1VPSmXRiAeBSuSbPty4jVdP54XSxEPTTf8aBJ2GTB7Xfi7PF81bRCDkKtFJ8VUtKoG
	 SCSwPRRjNlRXJyXOdiFOdIxopA4JuVw2Rck1e5rRi7xnS0sTBFGenXvnDQZLnB+gWs
	 4ris9kGmUCihQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C91D4821AE;
	Fri, 26 Jun 2026 05:47:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 972B2231
 for <intel-wired-lan@lists.osuosl.org>; Fri, 26 Jun 2026 05:47:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7D88840C7A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 26 Jun 2026 05:47:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 416h7ChpkwTs for <intel-wired-lan@lists.osuosl.org>;
 Fri, 26 Jun 2026 05:47:34 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org EFD3E40C93
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EFD3E40C93
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EFD3E40C93
 for <intel-wired-lan@lists.osuosl.org>; Fri, 26 Jun 2026 05:47:33 +0000 (UTC)
X-CSE-ConnectionGUID: QMcSALNzR2ygPI0AOgR2zg==
X-CSE-MsgGUID: 2IHcVTs3RJC8+t8Ch+wYeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="85798039"
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; d="scan'208";a="85798039"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 22:47:34 -0700
X-CSE-ConnectionGUID: 1Iufo/MCQwGW6d5Bmv24vg==
X-CSE-MsgGUID: VtXMiO4BQTuaap+E1ss4Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; d="scan'208";a="275485700"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa001.fm.intel.com with ESMTP; 25 Jun 2026 22:47:32 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Date: Fri, 26 Jun 2026 07:47:29 +0200
Message-ID: <20260626054730.1126969-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260626054730.1126969-1-aleksandr.loktionov@intel.com>
References: <20260626054730.1126969-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782452854; x=1813988854;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jcgu0G4yFwmZlw8w+NTRKbolWpD1J9LZq4Y9zKRM4Gc=;
 b=f4YAMgnhhp57RSnFsOr1vJQVZ97fO11NV+C1nTQbDZlPVRfAPrz3BinE
 jFraNA6OMpBSXnRc6M+4v3cLY+nKtrr6MPcQeKwY/shVaZqEyMC0QBt6w
 iwbWBJUvfb4H4SDmvunWNWVHO/sbNXMY/enUP8xItbzmpk9hxe6manA4w
 4XXS17uRv91/IZlOYcXzrSHC4PPhVeRkHLoix5KD2tUmRq8NpMTNAzWBP
 fjjfBT4wQVQgMmUers8JW86ngpzdCHjmRGu+Buwan6FuWZzxsDd0/8OkE
 J/CF0i1PfgeCh5/z++jwT6RH5jO0Ru2SYFcr9JCf7vl+LiXlLSviobZ61
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=f4YAMgnh
Subject: [Intel-wired-lan] [PATCH iwl-next v5 1/2] ethtool: treat
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
+	rxfh &= ~RXH_GTP_TEID;
+
 	sym = rxfh == (rxfh & (RXH_IP_SRC | RXH_IP_DST |
 			       RXH_L4_B_0_1 | RXH_L4_B_2_3));
 	sym &= !!(rxfh & RXH_IP_SRC)   == !!(rxfh & RXH_IP_DST);
-- 
2.52.0

