Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7BFC47BDF
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Jan 2026 10:22:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B756181317;
	Tue,  6 Jan 2026 10:22:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BuLnPLoLG23v; Tue,  6 Jan 2026 10:22:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B30CB812E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1767694924;
	bh=RcfwQVRAgdW7tI5OXgjpT69o7pvSVpaOV1mGAQ3KoIA=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fWCOmBB3vteSGIvykNoIoHJa2IrwLoKCfjueF8zWRTQkxQ6eRpEVXtwiWi74M/1De
	 FcsBeEj9qennnjJAFY+3Vp5hAOJfjPGg8NZkAc9n90yGKPQjzhNfIqM/MoB9q8h5R3
	 uONki8TUiiGy3nV04xLuLJyrxIqvbMnJopoyPrxd9Gt8x1KFxZwHgk84hv/S9gcwGo
	 hOihP7BlYWOxAMUuw9ebMvzrbLzbfT/0vQwH537nJqm2UsNwDfRXFn00obfWnwWhPi
	 Hg11K6SwDR7xUwl72Y+0u5AQGaYIFu4+cUzJRzrwPCappmtGYteWYVYqOLLiLyhSvh
	 vYD3ub10AW1MA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B30CB812E0;
	Tue,  6 Jan 2026 10:22:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B7B81E7
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Jan 2026 10:22:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AA0E160A52
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Jan 2026 10:22:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2pi8gb5fkqcy for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Jan 2026 10:22:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=vitaly.lifshits@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B108560782
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B108560782
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B108560782
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Jan 2026 10:22:02 +0000 (UTC)
X-CSE-ConnectionGUID: XxIjOE8/RkexDapcFIlx1g==
X-CSE-MsgGUID: c9LqENPJQQOH4YSMgFWWVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="68966584"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="68966584"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2026 02:22:02 -0800
X-CSE-ConnectionGUID: UrmAA2WNSnWul1Hh9/z0ZQ==
X-CSE-MsgGUID: OYMnTDqNQd6mZi+OzoU1OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="207175245"
Received: from ccdlinuxdev11.iil.intel.com ([143.185.162.70])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2026 02:22:02 -0800
From: Vitaly Lifshits <vitaly.lifshits@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Vitaly Lifshits <vitaly.lifshits@intel.com>
Date: Tue,  6 Jan 2026 12:21:53 +0200
Message-Id: <20260106102153.1577396-3-vitaly.lifshits@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260106102153.1577396-1-vitaly.lifshits@intel.com>
References: <20260106102153.1577396-1-vitaly.lifshits@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767694922; x=1799230922;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=egYdx9v0IHYUsQryfEIS34QQOYbZb2uivY8ypP1ig/4=;
 b=c5ithYXQmqmpmtkBhmcCPYJTrZr5hSvB9FMb42YGslQmK/ZFOTJH/1ct
 Ygo2+EMwVRKFwgvQZ0vKSWeU5K0MbhR+FxpRBuJ0pJeEyusw/IxfD9Mh+
 H3iNZ7Y2MuhgwyODGhBqWI80lIynRClXpLo04MZM8fOWw26djRsUoqD2Y
 ge6JJuAUQRuZrlV6TfJL3RDNdf7n0HjeZrVEzSemm0KMB0+rulxPVrPnf
 3nvMmdkxwfLKtWbW1mPbE0/e0cgwggpiuIUL7uMYziVib8OWTbYyCUbBU
 oEaMvvFI94rODTZIFPCd9XPfw4V4Rh12rKtTaj/zRgnE4XJv94qzqpTfK
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=c5ithYXQ
Subject: [Intel-wired-lan] [PATCH iwl-net v3 2/2] e1000e: clear DPG_EN after
 reset to avoid autonomous power-gating
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

Panther-lake systems introduced autonmous power gating feature for
supporting low power state in shutdown state. As part of it, the
reset value of DPG_EN bit was changed to 1. Therefore to avoid
errors such as Tx/Rx hangs, packet loss and packet corruption
clear this bit after performing hardware reset.

Fixes: 0c9183ce61bc ("e1000e: Add support for the next LOM generation")
Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
---
v3: rephrase a comment in the code
v2: fix a typo in a macro
v1: initial version
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index eead80bba6f4..9509157cadd6 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -4932,6 +4932,16 @@ static s32 e1000_reset_hw_ich8lan(struct e1000_hw *hw)
 	reg |= E1000_KABGTXD_BGSQLBIAS;
 	ew32(KABGTXD, reg);
 
+	/*
+	 * The hardware reset value of the DPG_EN bit is 1.
+	 * Clear DPG_EN to prevent unexpected autonomous power gating.
+	 */
+	if (hw->mac.type >= e1000_pch_ptp) {
+		reg = er32(CTRL_EXT);
+		reg &= ~E1000_CTRL_EXT;
+		ew32(CTRL_EXT, reg);
+	}
+
 	return 0;
 }
 
-- 
2.34.1

