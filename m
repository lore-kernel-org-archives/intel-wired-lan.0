Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D4EE99052
	for <intel-wired-lan@archiver.kernel.org>; Fri, 10 Apr 2026 07:49:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E2A860BA2;
	Fri, 10 Apr 2026 07:49:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wjA9CPQe0DAM; Fri, 10 Apr 2026 07:49:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BDC1860B5B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775807376;
	bh=iHitxJ6dSSx98dAfkYxaapfXLOvFwy1KxnI5+m1uClw=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PI2YKr0LG54/jEUz67ShpqhMjVTRMLAEqv+ZZup1MSsK27/4dxmTdhxYq8ITFO2nc
	 DdW9vuxjn38cL7tRjF2cWk8+40zBYgQrRo0RuCFNnyv54Y6SiAlZTvvO2aB4TukjYH
	 2jzQhzm5Bk8to3UoER4T0ujUrgqsLrSAdG/hEJkk1CBMxJFFwnO+VBu2Xld9qCJthm
	 hIkxegITUadVez1obpL04isxwrLkao8XPFf7rXOjfZisMFnewImwlC8MMzBJbaKNIr
	 GJtPcSMcH/ToTyeOzF069Peb9XAiD69Oh129ZwPEtotDZ/QO0v0IutPkDBJT3t5jVF
	 9h5zbGnTX08gg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BDC1860B5B;
	Fri, 10 Apr 2026 07:49:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DA05D1F6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 07:49:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C171C81A81
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 07:49:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Ayrqs_bf1FG for <intel-wired-lan@lists.osuosl.org>;
 Fri, 10 Apr 2026 07:49:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org AD504816EE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AD504816EE
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AD504816EE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 07:49:33 +0000 (UTC)
X-CSE-ConnectionGUID: MLQbCVh3SDKmDrYlLRjuxg==
X-CSE-MsgGUID: XEnMQsn4RMil9a8k+NGkAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="77007934"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="77007934"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 00:49:33 -0700
X-CSE-ConnectionGUID: /p17nqLyRya/B32oUl8oVQ==
X-CSE-MsgGUID: GMYz3NDBTcKgVXhjrmZZzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="228941886"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa008.jf.intel.com with ESMTP; 10 Apr 2026 00:49:32 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 10 Apr 2026 09:49:17 +0200
Message-ID: <20260410074921.1254213-7-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
References: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775807374; x=1807343374;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KyKKiZWFrU6bgfomlOok069woZZROnCpDRvRPVZwUBo=;
 b=OqlbWNmlz0LBpjSa50NXgSgyWoYnxWIueT4wGBRToOylwNF5kn+R7rhu
 MLAyFZnvVxqL/9DIy74ZGfg01VuVek5oWbeaiDRf3Oxvd3FZ/un44lxxD
 xxfQ31uCBe3734M5X7/Qa3aPRtqWkpo+cDW5GafJ3gMnWKHrzkAiSSjF3
 yKPZvsGLbRBMjVDFqWmBcFGw4DzXo7L6huujl4kwW4DoCotonwgKmZ4cH
 j5bHQadlqpMZ+DZ+/YpujSmFgqEUqJNkdzGPTZ6XaF/ypw7GRLqqi1FsD
 Cz61Y4q3Tvgxd/KJmCbjH1snt+ZJWz4DBNcFZWwczUpDFdSJ86JqWPmld
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=OqlbWNml
Subject: [Intel-wired-lan] [PATCH iwl-next 6/10] ice: increase OICR
 interrupt moderation rate to 20K interrupts/sec
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

The miscellaneous interrupt cause (OICR) is throttled to 8K
interrupts per second (124 us minimum spacing). This interrupt
handles VF mailbox messages and Tx timestamps, so the low rate
imposes a minimum latency floor on both use-cases.

Raise the rate to 20K interrupts per second (50 us minimum
spacing) to allow lower latency handling for Tx timestamp
bursts and high VF message rates.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 75a48e5..2921da4 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3501,7 +3501,7 @@ static int ice_req_irq_msix_misc(struct ice_pf *pf)
 		     ((pf->ll_ts_irq.index + pf_intr_start_offset) &
 		      PFINT_SB_CTL_MSIX_INDX_M) | PFINT_SB_CTL_CAUSE_ENA_M);
 	wr32(hw, GLINT_ITR(ICE_RX_ITR, pf->oicr_irq.index),
-	     ITR_REG_ALIGN(ICE_ITR_8K) >> ICE_ITR_GRAN_S);
+	     ITR_REG_ALIGN(ICE_ITR_20K) >> ICE_ITR_GRAN_S);
 
 	ice_flush(hw);
 	ice_irq_dynamic_ena(hw, NULL, NULL);
-- 
2.52.0

