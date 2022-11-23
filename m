Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645BDC4332F
	for <intel-wired-lan@archiver.kernel.org>; Wed, 23 Nov 2022 16:32:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A8DF41960;
	Wed, 23 Nov 2022 16:32:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0A8DF41960
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1669221145;
	bh=LEjHR3mzljSTE8lYaCvgvL62sdGWYDrDiaYBCSytuw4=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=U1Jj02jbQNluzpSKbdu+y8lQGHPh9fUSC3yRZh5fcYAQ0097SZ+SgFUFTHtXYOZPX
	 5Onv/tDiSA16jBi5IducKrvpONYQgANcR45Rn+6abwCclQlvdgtDFFuog76Bx5qzf2
	 wu7v+hMi6+9zuGu8OTUun0iBSjH7EfC4k+QLYmKgo9XLmNE2L3eqP+gr5UqnHlFkVC
	 /Om1gZkD7ZnbdSxKM/An8T1HCLxlXMSORhULsEC4uJGNkwb/FClmehcBrYfy+v6Mrm
	 +fBKlBhUhanN2duqsp5qivlQ3fk3iqZS2h5UWRZB5RF243Vf/8mO4gYR+wNqp8A7FX
	 3DJIt8oFm/yMQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rPsMHyXIBk8E; Wed, 23 Nov 2022 16:32:24 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id C67944196F;
	Wed, 23 Nov 2022 16:32:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C67944196F
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 25CC71BF5AA
 for <intel-wired-lan@osuosl.org>; Wed, 23 Nov 2022 16:05:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0CC29416E7
 for <intel-wired-lan@osuosl.org>; Wed, 23 Nov 2022 16:05:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0CC29416E7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ySna4E4Oxu-q for <intel-wired-lan@osuosl.org>;
 Wed, 23 Nov 2022 16:05:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 13F4441550
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 13F4441550
 for <intel-wired-lan@osuosl.org>; Wed, 23 Nov 2022 16:05:36 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="378356788"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; d="scan'208";a="378356788"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2022 08:05:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="674769570"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; d="scan'208";a="674769570"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
 by orsmga001.jf.intel.com with ESMTP; 23 Nov 2022 08:05:34 -0800
Received: from vecna.. (vecna.igk.intel.com [10.123.220.17])
 by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id
 2ANG5SoT003509; Wed, 23 Nov 2022 16:05:34 GMT
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@osuosl.org
Date: Wed, 23 Nov 2022 16:55:44 +0100
Message-Id: <20221123155544.1660952-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221123155544.1660952-1-przemyslaw.kitszel@intel.com>
References: <20221123155544.1660952-1-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 23 Nov 2022 16:32:15 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1669219537; x=1700755537;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sX26KpCopBQUO4dIDe2S8U6mw9YjALtAR83X0y2IZ7I=;
 b=YmuRMhutYwzZpbhth4rCPT0u8T7Rl7aTE7ZpHVRgiqCzTYJLeYEcm+iT
 XiC8nGzj4BRZ3bM6Czu8kWgBp7M5k4kz9ji98DC6Kq/XLvW70LG6/gIbL
 GmhWC0JuZa2thaBiLHk9mLo9ysqbJ41KDbkV+Xn8/oGlTYmHieKRrtit7
 GDQYQRUJnBPYHrnQ/G5JBD/9gxe0cUhwruZXAgdOL3jorAEMQKV3rppyF
 zR219q6t0GvZyUEPLveZl2S/L/IcahBsblCkjstOF1ESa0HC5exqOMJJu
 Qf1JPtyfubLDU1Oo91mYgYXZut+K80TGDorgV2rzwGmnjWhONj2nay+Zs
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=YmuRMhut
Subject: [Intel-wired-lan] [PATCH net-next 2/2] ice: combine cases in
 ice_ksettings_find_adv_link_speed()
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
Cc: netdev@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Combine if statements setting the same link speed together.

Suggested-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 417efc401001..626480677cc1 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2260,17 +2260,15 @@ ice_ksettings_find_adv_link_speed(const struct ethtool_link_ksettings *ks)
 						  100baseT_Full))
 		adv_link_speed |= ICE_AQ_LINK_SPEED_100MB;
 	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  1000baseX_Full))
-		adv_link_speed |= ICE_AQ_LINK_SPEED_1000MB;
-	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
+						  1000baseX_Full) ||
+	    ethtool_link_ksettings_test_link_mode(ks, advertising,
 						  1000baseT_Full) ||
 	    ethtool_link_ksettings_test_link_mode(ks, advertising,
 						  1000baseKX_Full))
 		adv_link_speed |= ICE_AQ_LINK_SPEED_1000MB;
 	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  2500baseT_Full))
-		adv_link_speed |= ICE_AQ_LINK_SPEED_2500MB;
-	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
+						  2500baseT_Full) ||
+	    ethtool_link_ksettings_test_link_mode(ks, advertising,
 						  2500baseX_Full))
 		adv_link_speed |= ICE_AQ_LINK_SPEED_2500MB;
 	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
@@ -2279,9 +2277,8 @@ ice_ksettings_find_adv_link_speed(const struct ethtool_link_ksettings *ks)
 	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
 						  10000baseT_Full) ||
 	    ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  10000baseKR_Full))
-		adv_link_speed |= ICE_AQ_LINK_SPEED_10GB;
-	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
+						  10000baseKR_Full) ||
+	    ethtool_link_ksettings_test_link_mode(ks, advertising,
 						  10000baseSR_Full) ||
 	    ethtool_link_ksettings_test_link_mode(ks, advertising,
 						  10000baseLR_Full))
@@ -2305,9 +2302,8 @@ ice_ksettings_find_adv_link_speed(const struct ethtool_link_ksettings *ks)
 	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
 						  50000baseCR2_Full) ||
 	    ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  50000baseKR2_Full))
-		adv_link_speed |= ICE_AQ_LINK_SPEED_50GB;
-	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
+						  50000baseKR2_Full) ||
+	    ethtool_link_ksettings_test_link_mode(ks, advertising,
 						  50000baseSR2_Full))
 		adv_link_speed |= ICE_AQ_LINK_SPEED_50GB;
 	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
-- 
2.34.3

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
