Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB17C0015E
	for <intel-wired-lan@archiver.kernel.org>; Wed,  9 Aug 2023 13:36:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CC50A40CBE;
	Wed,  9 Aug 2023 13:36:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CC50A40CBE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1691588178;
	bh=HTSNCBELZq2DiME8KnmNWtr864r9mPP9AF6wOdY2aR8=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MDqPCQOU/p27NrXx4pYtMIzOCz+H8jVAmb3CxSekl6dhqkwz/Npk//IAWgk91hNbm
	 /e26fhiwl9o7iQ67t0rX4/8idtwYOh3OjF1YBghG0i/xAAbY1uK9l3/aiCXZIBDbes
	 0vfZidwhBzHwuqj2G5iny/z3d6VYFk25oUdQtpd/Z/BRbLaNH0vTn2hUI8b0shID2E
	 jtdYOxCuzgs++yyxgd+AI3Iby1FWTUUg7fpN/Iw/DwylUoCo5wDj0h66NofvZznUZE
	 ghvc3lD8bweUrp1W9n972xsg2Fc0k+py8230WwYUieFY1CkL8smJXYIMqook6r3JaG
	 3pRiw+1lO30eQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ctQ5VBFAd-PG; Wed,  9 Aug 2023 13:36:18 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id D464941452;
	Wed,  9 Aug 2023 13:36:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D464941452
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 5C5361BF842
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Aug 2023 13:35:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 710C060EFF
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Aug 2023 13:35:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 710C060EFF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nD1zgB-MVSnI for <intel-wired-lan@lists.osuosl.org>;
 Wed,  9 Aug 2023 13:35:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D1C836118F
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Aug 2023 13:35:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D1C836118F
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="402086886"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; d="scan'208";a="402086886"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Aug 2023 06:35:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="725401530"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; d="scan'208";a="725401530"
Received: from s240.igk.intel.com (HELO DevelopmentVM.nql.local)
 ([10.102.18.202])
 by orsmga007.jf.intel.com with ESMTP; 09 Aug 2023 06:35:30 -0700
From: Jan Sokolowski <jan.sokolowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Wed,  9 Aug 2023 15:39:13 +0200
Message-Id: <20230809133913.2652736-8-jan.sokolowski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230809133913.2652736-1-jan.sokolowski@intel.com>
References: <20230809133913.2652736-1-jan.sokolowski@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691588147; x=1723124147;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UbDGn8ZV0T/4Lvatzl7njpswjKBy3uAsEqhF8iGOQDQ=;
 b=G+68lL8+q5s6ceZXjzp1MhHUj2Gqe/tTRoiesN7YVCASe50dxiYqZnuH
 y1gRY4ih/uFp1br379YjiuvcfDkhkKG66KmuVq8j4TlrFSOT/h6O8v/hi
 JGRga1IxCXzJOchKTP1ardZU27rCtSsdTrIObY/R3A5AtuF/5ZQKyEOJ8
 LTJnG+nEK/znmBYVgUozfwnCIFRgZS+noGsWDjiPH7ds/Z5P9oSHsZFXn
 e2m0xUUCUVuUS6KotloN60t27IKcjZOH6UQ0f2PDhFR5kKDRqyAUtMKeo
 CDWa3tbWgyDFeCNdnW8fGkkXcnGu9dWeGrOFIQ/BzJbyhGePBe/CcLo0J
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=G+68lL8+
Subject: [Intel-wired-lan] [PATCH iwl-next v3 7/7] ice: refactor
 ice_vsi_is_vlan_pruning_ena
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

As this method became static, and is already called
with check for vsi being non-null, an unnecessary check along
with superfluous parentheses is removed.

Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index d3fb2b7535e7..201570cd2e0b 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1235,10 +1235,7 @@ ice_chnl_vsi_setup_q_map(struct ice_vsi *vsi, struct ice_vsi_ctx *ctxt)
  */
 static bool ice_vsi_is_vlan_pruning_ena(struct ice_vsi *vsi)
 {
-	if (!vsi)
-		return false;
-
-	return (vsi->info.sw_flags2 & ICE_AQ_VSI_SW_FLAG_RX_VLAN_PRUNE_ENA);
+	return vsi->info.sw_flags2 & ICE_AQ_VSI_SW_FLAG_RX_VLAN_PRUNE_ENA;
 }
 
 /**
-- 
2.31.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
