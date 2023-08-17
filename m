Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAF7C2FC06
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Aug 2023 00:01:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 510C541776;
	Thu, 17 Aug 2023 00:01:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 510C541776
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692230493;
	bh=cC0g0ObCygPfd00aHmhsfuM9T9RMss7awGgvFU1ENOI=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=1GWLME36tYAXbCZ5Ssij+r6a4/j5hXrSFpHZYb1dzYIWhYaXRw098zk3i6Zqfhu0e
	 ictQfHnii5HHXt8UAmh+HqXKe9LbgiZ2SErFlX29K8hgJWpBM+gM261XikUF1ztPuE
	 K7rnRl+wAQ067RjFvFtMKih23mmrkiXDCoorswPD1YLpJK6CzIqG+9jzqVMbH4zw+M
	 sAVLp8wqDs0ZDUfxFSovnxMnCl0so4T0p3foXeaaLyTFfUyHYnp+4mI2xzo/dErhbB
	 vgpvaQiL5cDgqvhUA447ToMaes/J3oQ6xHj67bDFADo8MdCIqPfVDEr+YtOHGhVakl
	 0Ld9Uy6N+np1A==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gyjqjfP67BzV; Thu, 17 Aug 2023 00:01:32 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5A3A64177D;
	Thu, 17 Aug 2023 00:01:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5A3A64177D
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 2FFBF1BF2AF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Aug 2023 00:01:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F2BAD83B70
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Aug 2023 00:01:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F2BAD83B70
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ot9_AZaVdIYl for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Aug 2023 00:01:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4BCEF83B74
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Aug 2023 00:01:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4BCEF83B74
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="403649711"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; d="scan'208";a="403649711"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2023 17:01:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="799805046"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; d="scan'208";a="799805046"
Received: from jekeller-desk.amr.corp.intel.com (HELO
 jekeller-desk.jekeller.internal) ([10.166.241.1])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2023 17:01:04 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Date: Wed, 16 Aug 2023 17:00:56 -0700
Message-ID: <20230817000058.2433236-4-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0.1.g9857a21e0017.dirty
In-Reply-To: <20230817000058.2433236-1-jacob.e.keller@intel.com>
References: <20230817000058.2433236-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692230466; x=1723766466;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HaqUrhutqdein3hut0dDCBqXN7S/rLgX3FZw/fgcQp4=;
 b=UCeCOa3eEwrx+rBaibcF4jAvUXeptH3k2+RUu1A9beIJwl00X/FAM5yO
 poZYs65hZlkNRU11D43xhky3CzKV7SC8XQnM1x5DssHzECxGoe9YTwZ2O
 ZIyIB5BtfCH4T5wYonac1CJwm56PsyIr9q8lwYLP+nKq9Mj8jWo34CST5
 VDA1sNv4V3bmk6OjSzEYqA/qGIoD4m3LqCM2hp3fJuM3f1yk2iXwdJCvg
 0buAxSvGk31lR0/rbsjWphuadnvBsuD2klkjmYuEVfyGc84J3EsibOJjS
 uTUtx1E7D73ln7znLgw7+/1du8QuQidVxN7UGs/oY/GhGXMFEFWZLMYAT
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=UCeCOa3e
Subject: [Intel-wired-lan] [PATCH iwl-next v2 3/5] ice: don't enable PTP
 related capabilities on non-owner PFs
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
 Anthony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The ice driver currently sets feature flags for certain PTP related
capabilities based on whether the device has support for the feature. Avoid
enabling these capabilities except on the ports which own the timer. This
ensures that the driver never attempts to access the features except on the
ports designated as controlling the main timer functionality.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
No changes in v2.

 drivers/net/ethernet/intel/ice/ice_lib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 5dfcb824f817..f29ff54383b5 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3986,6 +3986,9 @@ void ice_init_feature_support(struct ice_pf *pf)
 	case ICE_DEV_ID_E810C_QSFP:
 	case ICE_DEV_ID_E810C_SFP:
 		ice_set_feature_support(pf, ICE_F_DSCP);
+		/* If we don't own the timer - don't enable other caps */
+		if (!ice_pf_src_tmr_owned(pf))
+			break;
 		if (ice_is_e810t(&pf->hw)) {
 			ice_set_feature_support(pf, ICE_F_SMA_CTRL);
 			if (ice_gnss_is_gps_present(&pf->hw))
-- 
2.41.0.1.g9857a21e0017.dirty

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
