Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E607C001B0
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Aug 2023 22:36:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C298A611D2;
	Tue, 15 Aug 2023 22:36:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C298A611D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692138965;
	bh=cpqhdMGsNB1L1ZxbToZxvoZi3ddRoh+UPI6uNit+NvA=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=TAq+zzXH44SlsMAnKugNluDl4Y+XBSe1nOcQ5wwgaeNtYQFwSAB+4l07gS2SKOO2K
	 8UUYNOb9FnM9y/uOXy6j8oy2oIvJHh23UIhrP8gVjBRkCiPpgk/DSFyH37ajTC6N0T
	 tFm/+qw2TelRxOWY5blqTugiD3y2dxyVYajKuoaA/DksVWBgG/bVa7OEqQjyZcPlPo
	 lHe+y0/JTCAiTzlryx+msy9zNy/NpFBRwtUPm+X9h7sXjLtWrmt2v2e9QOuqawE5wy
	 Gnva+MqgkjMVmyGundxpMbA2JusNmDUJOXeE22iRdkVDp5/7RIgTfv7igyqbQPEn8w
	 6Teq5Dxig+6iA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3P4KpMwwAx3Y; Tue, 15 Aug 2023 22:36:05 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id B79CF611CB;
	Tue, 15 Aug 2023 22:36:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B79CF611CB
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 1E21A1BF47F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Aug 2023 22:35:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7A737414A4
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Aug 2023 22:35:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7A737414A4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q2kSIkUJay8R for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Aug 2023 22:35:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BFBD64149A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Aug 2023 22:35:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BFBD64149A
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="352718849"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; d="scan'208";a="352718849"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2023 15:35:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="710905980"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; d="scan'208";a="710905980"
Received: from jekeller-desk.amr.corp.intel.com (HELO
 jekeller-desk.jekeller.internal) ([10.166.241.1])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2023 15:35:56 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Date: Tue, 15 Aug 2023 15:35:43 -0700
Message-ID: <20230815223551.1238091-2-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0.1.g9857a21e0017.dirty
In-Reply-To: <20230815223551.1238091-1-jacob.e.keller@intel.com>
References: <20230815223551.1238091-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692138957; x=1723674957;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=syVLLL2YIkCivctCpVnmrNaHUSbAWALFm6l4frRtSFI=;
 b=c5GHmiBhMTHfMvkk7BtvxJUv12zp1YQ+x8Q9/FseWMdKDZbfBv6PNMze
 oNteW8uBb4Fd2lfToqFGeaepEMvX6egUZ/eWt7eWyF8gO1zJFur40ZSxK
 L8xy4mfFyPW/2m6/fB44exTsB3NtJm4DoHsj8YkB4qwffGN1EipyWVzuJ
 la1hW/lVLQenYtpLoZxGBfjRMrHc9Wd+EiEF84I47DWmoMQPPzsZTD2/p
 3SfkGMgsigdqONsZAzEvWVw4hoMNg+MxfCnDQIRfnyw1rR92TfAmyVWBp
 AHGgpFbxldTVJNq9AwCHD+72BosU089Dhvc3pfurhyXXHEESdERpVQg3t
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=c5GHmiBh
Subject: [Intel-wired-lan] [PATCH iwl-next 1/4] ice: remove ICE_F_PTP_EXTTS
 feature flag
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
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The ICE_F_PTP_EXTTS feature flag is ostensibly intended to support checking
whether the device supports external timestamp pins. It is only checked in
E810-specific code flows, and is enabled for all E810-based devices. E822
and E823 flows unconditionally enable external timestamp support.

This makes the feature flag meaningless, as it is always enabled. Just
unconditionally enable support for external timestamp pins and remove this
unnecessary flag.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h     | 1 -
 drivers/net/ethernet/intel/ice/ice_lib.c | 1 -
 drivers/net/ethernet/intel/ice/ice_ptp.c | 4 +---
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 5d307bacf7c6..013ea8970fbc 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -199,7 +199,6 @@
 
 enum ice_feature {
 	ICE_F_DSCP,
-	ICE_F_PTP_EXTTS,
 	ICE_F_SMA_CTRL,
 	ICE_F_GNSS,
 	ICE_F_ROCE_LAG,
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 201570cd2e0b..5dfcb824f817 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3986,7 +3986,6 @@ void ice_init_feature_support(struct ice_pf *pf)
 	case ICE_DEV_ID_E810C_QSFP:
 	case ICE_DEV_ID_E810C_SFP:
 		ice_set_feature_support(pf, ICE_F_DSCP);
-		ice_set_feature_support(pf, ICE_F_PTP_EXTTS);
 		if (ice_is_e810t(&pf->hw)) {
 			ice_set_feature_support(pf, ICE_F_SMA_CTRL);
 			if (ice_gnss_is_gps_present(&pf->hw))
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 97b8581ae931..9524fcea9ae9 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2205,9 +2205,7 @@ static void
 ice_ptp_setup_pins_e810(struct ice_pf *pf, struct ptp_clock_info *info)
 {
 	info->n_per_out = N_PER_OUT_E810;
-
-	if (ice_is_feature_supported(pf, ICE_F_PTP_EXTTS))
-		info->n_ext_ts = N_EXT_TS_E810;
+	info->n_ext_ts = N_EXT_TS_E810;
 
 	if (ice_is_feature_supported(pf, ICE_F_SMA_CTRL)) {
 		info->n_ext_ts = N_EXT_TS_E810;
-- 
2.41.0.1.g9857a21e0017.dirty

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
