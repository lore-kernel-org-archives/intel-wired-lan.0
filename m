Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9038DC43334
	for <intel-wired-lan@archiver.kernel.org>; Thu, 21 Jul 2022 21:30:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3EC5540577;
	Thu, 21 Jul 2022 21:30:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3EC5540577
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1658439038;
	bh=0gYFBRp9Flrbn1FzY/1sMIpP6fczpSrylb9uGxXOmLE=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0WK/HmjewnLlI73HXXwRfTmkxMo2C89rwgZ4C19ojyWE9Ulnugrxys1SKmP37jJeN
	 ZNvPsvSw717CiGxOHVLXmXdpsw2LH/zSKBvH380ljhK01CtUMOmmbyQaEMUmeZTT8a
	 63Dt0Klx/+M87rexyR9U+fWdaaPKdeOBeqDFI6OzQQr4phSUJ9g5vOI+vCfs//gUIg
	 hE07biJkAMApQy1szcshtt/UMz141gB5eb+PPOBQJHTxfGB479/w3ypBq9TJ0HXjh6
	 rrXlKnO+PvLsR/Bc5arJeE+ALhBda+5yFAEpXp+h+tr1sGtGhniMDMQxBV67wTK1jW
	 IZ3vZDrJs5sQA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ohic8OVHZN7s; Thu, 21 Jul 2022 21:30:37 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 44FD04057F;
	Thu, 21 Jul 2022 21:30:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 44FD04057F
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id BFF981BF375
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Jul 2022 21:30:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C25C960B37
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Jul 2022 21:30:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C25C960B37
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hd9lhG9a5Fd9 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 21 Jul 2022 21:30:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1AF6760808
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1AF6760808
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Jul 2022 21:30:10 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="274029228"
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; d="scan'208";a="274029228"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2022 14:30:08 -0700
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; d="scan'208";a="740833143"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.7])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2022 14:30:08 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Date: Thu, 21 Jul 2022 14:29:56 -0700
Message-Id: <20220721213001.2483596-4-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.35.1.456.ga9c7032d4631
In-Reply-To: <20220721213001.2483596-1-jacob.e.keller@intel.com>
References: <20220721213001.2483596-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1658439010; x=1689975010;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=f1+SZkAxejuwMZYpidA1KgheG7gq8oGqHSnbS8D0sY4=;
 b=c6UeRHLR9EWIHQdhPmRDQcZ7CrsdXwche6X8YkviMhOj/qgO6s0GA274
 WwfnxJYuU49e7mGIYEsGOcWb6gRZsVn2NgCgsuvcMsTt6gcdAAr+ar8IN
 0oZKWtCZmrFVp01ddBsn5sesKrcR2ee1/3L9FwjX31XmvXcH5hwFEmkwF
 D5AyTLfSFNU/BXnmAwyTvI8GNxRsOBZgmHoLTetlxBwXYwdjbLkiQcG/m
 h/Bs8SbAiW3fBkKn6dMpdDjxqoaWPBWqZSvFtWu0Pmjle4jwwRDe754D1
 7SeCPfgd5eKpn1AoB+aazyUMgcQnmIxSsXmMVDnQwhKQsErMD/ny5cHkF
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=c6UeRHLR
Subject: [Intel-wired-lan] [net-next PATCH 2/7] e1000e: remove unnecessary
 range check in e1000e_phc_adjfreq
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The e1000e_phc_adjfreq function validates that the input delta is within
the maximum range. This is already handled by the core PTP code and this is
a duplicate and thus unnecessary check. It also complicates refactoring to
use the newer .adjfine implementation, where the input is no longer
specified in parts per billion. Remove the range validation check.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ptp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ptp.c b/drivers/net/ethernet/intel/e1000e/ptp.c
index eb5c014c02fb..432e04ce8c4e 100644
--- a/drivers/net/ethernet/intel/e1000e/ptp.c
+++ b/drivers/net/ethernet/intel/e1000e/ptp.c
@@ -33,9 +33,6 @@ static int e1000e_phc_adjfreq(struct ptp_clock_info *ptp, s32 delta)
 	u32 timinca, incvalue;
 	s32 ret_val;
 
-	if ((delta > ptp->max_adj) || (delta <= -1000000000))
-		return -EINVAL;
-
 	if (delta < 0) {
 		neg_adj = true;
 		delta = -delta;
-- 
2.35.1.456.ga9c7032d4631

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
