Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DFCE75425
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Oct 2023 05:32:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EFA9841BE9;
	Tue,  3 Oct 2023 05:32:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EFA9841BE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1696311130;
	bh=TrIGDJRnjfHAtNcEtlgzPjI0J8/DAQqgle3V6njM8aI=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=RRptDJhAkHT7dt8S/6Fpi1D4FMRCmzXUS1EspTDe9g+skI8RQuwXOweHUfjSykjqy
	 L/1BRU2VzPzpw311vWceZwNeOjWRQCY4rVfrBw9oQQNecLksIuRdmfEb/TCOx7g/h+
	 PIc8KkZ98asengZ+3tvN+OQyzNBdJFnO+GCeTxbK/vTiJOyG/JxG1P0onbClzEwJ4+
	 bZXdrDbDmlYCenCs3BlOI2qTMcQEStYAnAsn61kNiPCaFOfoGsG5nAUUdlHjVY6GBY
	 3XzPGGa56swvG+dPT8uVQJ9s0k6k+czsBCbJetnHdAd+lvXzTj3bVf6ffqnyhvWxu2
	 Dmxv8FRYOgJFA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lLbal6eTxFDw; Tue,  3 Oct 2023 05:32:08 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9920D41BF8;
	Tue,  3 Oct 2023 05:32:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9920D41BF8
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 060C21BF94D
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Oct 2023 05:32:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D2A95417B3
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Oct 2023 05:32:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D2A95417B3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id coQalDrQ9Er3 for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Oct 2023 05:32:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3D89140140
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Oct 2023 05:32:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3D89140140
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="1385304"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="1385304"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2023 22:32:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="1081881159"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; d="scan'208";a="1081881159"
Received: from jbrandeb-spr1.jf.intel.com ([10.166.28.233])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2023 22:32:00 -0700
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Mon,  2 Oct 2023 22:31:10 -0700
Message-Id: <20231003053110.3872424-1-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1696311123; x=1727847123;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=nFMy4xx+Sj2GKtLX3a/Sf+EbgsqvUQF1nDj0BB8WZTA=;
 b=DcDYSaZhBZAcxDwXcNUdXOLQxHa+vMOiodJu7RvCOg3E8yYB+Oi1dsYc
 OE5gkulJzz32itLMG788mSixBM3GpNcDkzOWPO8uZzK9XRmcCszc60ki5
 RrdTMILuIU/T6cY0lRsPlyrM4rwm3cXF7N04rPZWrm0H4Qlh+Pww5gw80
 TkxxZKNwcJ9U3CZPRFJxH+kr1OQuUGtg2aYUH6MWn10wn5D5ApHnfgLVw
 JOZAmpEr0SkzzNMeWGnDQLa0vKCgIdT29vbJeZ+QDkW5LmlnTmMmfVtN4
 j+RoK7DLpd/OKQJCiN+lNX4+ngjh2pxzEBHkidm1P1iQCaridfvNScRWW
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=DcDYSaZh
Subject: [Intel-wired-lan] [PATCH iwl-net v1] ice: fix over-shifted variable
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
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 stable@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Since the introduction of the ice driver the code has been
double-shifting the RSS enabling field, because the define already has
shifts in it and can't have the regular pattern of "a << shiftval &
mask" applied.

Most places in the code got it right, but one line was still wrong. Fix
this one location for easy backports to stable. An in-progress patch
fixes the defines to "standard" and will be applied as part of the
regular -next process sometime after this one.

Fixes: d76a60ba7afb ("ice: Add support for VLANs and offloads")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: stable@vger.kernel.org
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 201570cd2e0b..0aac519cc298 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1201,8 +1201,7 @@ static void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
 
 	ctxt->info.q_opt_rss = ((lut_type << ICE_AQ_VSI_Q_OPT_RSS_LUT_S) &
 				ICE_AQ_VSI_Q_OPT_RSS_LUT_M) |
-				((hash_type << ICE_AQ_VSI_Q_OPT_RSS_HASH_S) &
-				 ICE_AQ_VSI_Q_OPT_RSS_HASH_M);
+				(hash_type & ICE_AQ_VSI_Q_OPT_RSS_HASH_M);
 }
 
 static void

base-commit: 6a70e5cbedaf8ad10528ac9ac114f3ec20f422df
-- 
2.39.3

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
