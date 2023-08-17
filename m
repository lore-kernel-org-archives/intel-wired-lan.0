Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5D6C2FC39
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Aug 2023 14:18:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 54D8483F4C;
	Thu, 17 Aug 2023 14:18:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 54D8483F4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692281902;
	bh=1h49chmu5B9ooTGp+kUdNH0d72A4e57m5rn389jFKqU=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=qR0oBriR2ui663Ji5Yv52S6qilFAOAYBB59OQbtBVuwxH+d4T0yJuYdHBRdVu+DQL
	 a5TpqfBv7GzgQQjMwdnZlOtiv+arwjqgT25jBHyhR0AMLOONqCoiwCOTd0KvAKa2+1
	 Yv7kqnujye4v5RnVGHEKRHV2te+Gwv8cqKHokL2BwLb4I7iUQROBMb/Zr3GVI5aIiF
	 yU8WujY2TThPzXDl674DFnz2BfjevFyQe0QGej/CAOYIZyVa+o+GQtg9DqWTrRxgA0
	 LO5hM6Gp/zZaK7QSbRjQ3DmzndnEuTVX9i4KVEagpipnC+It5g9qyYVKKoV5DHFjyb
	 u9FFUGoIQJKOw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2-eDLLRnWN4B; Thu, 17 Aug 2023 14:18:21 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A6AA83F45;
	Thu, 17 Aug 2023 14:18:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4A6AA83F45
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 258C01BF3BC
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Aug 2023 14:18:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F34D883F3F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Aug 2023 14:18:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F34D883F3F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5wUhor55iQ86 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Aug 2023 14:18:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5CCBB82348
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Aug 2023 14:18:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5CCBB82348
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="403804193"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; d="scan'208";a="403804193"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2023 07:18:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="981189668"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; d="scan'208";a="981189668"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
 by fmsmga006.fm.intel.com with ESMTP; 17 Aug 2023 07:18:13 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Thu, 17 Aug 2023 16:17:38 +0200
Message-Id: <20230817141746.18726-2-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230817141746.18726-1-karol.kolacinski@intel.com>
References: <20230817141746.18726-1-karol.kolacinski@intel.com>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692281896; x=1723817896;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tigtovoxJ2ym3wDfkrnlqPh0llOAfxHW66RA5eLSXgw=;
 b=bwXRDkHnmsopiVDioka2r0QvwkUwpJUf6C8Jx+s5K1q7pMW8u7dNerMl
 vv6MywNA1RmZMzWjviRXxSlraesrkfdLTOlS+NDVtEDIBuytpo7zrCiqa
 c8bN2xQuXkB4W1rwlQ5svk+dtHdKcbv6bdMPMp+A73vPSRilicD6aOu0p
 LzaSrolPR33XcEaHfCCh49owBQfVzsy4CcotBLU5btvgzLzuQqX/3bopC
 2oh/j7xtZPSTUXif3Umvkf1ujmMdr6ij8+DDaXcBQHz/a+ePeD00Pq7oJ
 NXWDR6SlDsjJ/J2oIn/C/J5ozR12O70Ggpk1hXwjlXpcLkeoQRUw+hVGJ
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=bwXRDkHn
Subject: [Intel-wired-lan] [PATCH v2 iwl-next 1/9] ice: use
 ice_pf_src_tmr_owned where available
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
Cc: netdev@vger.kernel.org, Karol Kolacinski <karol.kolacinski@intel.com>,
 anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The ice_pf_src_tmr_owned() macro exists to check the function capability
bit indicating if the current function owns the PTP hardware clock.

This is slightly shorter than the more verbose access via
hw.func_caps.ts_func_info.src_tmr_owned. Be consistent and use this
where possible rather than open coding its equivalent.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index a6dd336d2500..b6858f04152c 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3185,7 +3185,7 @@ static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
 
 		ena_mask &= ~PFINT_OICR_TSYN_EVNT_M;
 
-		if (hw->func_caps.ts_func_info.src_tmr_owned) {
+		if (ice_pf_src_tmr_owned(pf)) {
 			/* Save EVENTs from GLTSYN register */
 			pf->ptp.ext_ts_irq |= gltsyn_stat &
 					      (GLTSYN_STAT_EVENT0_M |
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 97b8581ae931..0669ca905c46 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2447,7 +2447,7 @@ void ice_ptp_reset(struct ice_pf *pf)
 	if (test_bit(ICE_PFR_REQ, pf->state))
 		goto pfr;
 
-	if (!hw->func_caps.ts_func_info.src_tmr_owned)
+	if (!ice_pf_src_tmr_owned(pf))
 		goto reset_ts;
 
 	err = ice_ptp_init_phc(hw);
-- 
2.39.2

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
