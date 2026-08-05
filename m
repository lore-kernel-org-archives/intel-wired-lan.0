Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA69FC55ABA
	for <intel-wired-lan@archiver.kernel.org>; Wed,  5 Aug 2026 19:47:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9DFAC40585;
	Wed,  5 Aug 2026 19:47:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tvPaj3g7P6_x; Wed,  5 Aug 2026 19:47:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 63A9F40573
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785959239;
	bh=tU9G7CjZaTdQJW6Wh7c2pEjP3YUnMI3iDJ6Ttu+3TK4=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ezjo70uwGhH0IoV4pao4Cu+D7Cq106aGN44eRV6jSR+UaXGlaWQL8XbPjIueq4aEo
	 H0Km3BpkL0NRraIE3JWaNBKYVRoSGTizvvFyondlP/uUBq1M8ODtV8DklywOcrFynd
	 XgM25mTKHX8f+s8hqsofB1Y3A3xPuC+rAd6r3i9/tixwlcoA/r6FUjLc/dgrmD8A/f
	 dfuxWXWbeZwSI9/xOJJGyz0zGwXlwhVDCMER1lSiJlhLBXHkycgDK7276KcMkhmjDx
	 hIjHLEvDALhXmkBymN/u5PnQZPybkosyFdAfZhjje2kccRBOrB/miUslocRWVLyLm2
	 TKXQ7sCYB0KQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 63A9F40573;
	Wed,  5 Aug 2026 19:47:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2EC71730
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 19:47:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 20BB5809BF
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 19:47:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ytNwoIEoxBDy for <intel-wired-lan@lists.osuosl.org>;
 Wed,  5 Aug 2026 19:47:17 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=david.m.ertman@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 71753809B0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 71753809B0
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 71753809B0
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 19:47:17 +0000 (UTC)
X-CSE-ConnectionGUID: mc764o2LQ0udyPJvxp4qpg==
X-CSE-MsgGUID: cRpZDw4/TuyIU7vrASKRcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="74080648"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; d="scan'208";a="74080648"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 12:47:17 -0700
X-CSE-ConnectionGUID: AlsPnLOwTwu2GQwqk+WdIQ==
X-CSE-MsgGUID: RmdhUzqOTGum9vGlJ+Sarg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; d="scan'208";a="258558571"
Received: from dmert-dev.jf.intel.com ([10.166.241.33])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 12:47:17 -0700
From: Dave Ertman <david.m.ertman@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Date: Wed,  5 Aug 2026 12:49:35 -0400
Message-ID: <20260805164935.625304-1-david.m.ertman@intel.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785959237; x=1817495237;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=h3cyVBiUKNadQMSRxZ2x/6ygQjnCi7iDufhZWSSXAOc=;
 b=jEAg7cx24cxyjgtzb5PLv0PCWquSKx7SKxrwTC6iilNIcLns5c3bcQ0V
 +SiYXmlGWJQFRmNaSlRsUmBD2Fkn6HltapPNTDVXWJX/CN6QUgO8GJk4c
 H042GmiDANv2NFhmXENi/v5WzZ7ESdyM1pkja/onyiPS1Bpf4chM2P0q2
 rfPhUbofuMgCW1MuEpzfZBGGhPiXBTKCqCR+t6/jDgw4Vtgsw+upkmG/r
 cqp/0S9nCdEJ0ZpjKMsxg2QEvVKzl7dKvebO9bykVaIM354hp8J9oXH6Z
 gDgczVdsgU5h8JwIMqcjAOMUWB708SIvIJHAr0+9m5LunaqJNL2uUjoUw
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=jEAg7cx2
Subject: [Intel-wired-lan] [PATCH iwl-net] ice: Fix incorrect LLDP filter
 assumptions
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

In commit 4d5a1c4e6d49 ("ice: do not add LLDP-specific filter if not
necessary"), it was assumed that llpd_fltr_ctrl was a unique application
of a filter instance and the other command in the flow was generic.
This is an incorrect assumption, they are both meant to add a filter to
handle LLDP packets and only varied in the actual AQ call made.  The
newer AQ call was created to handle a special case in some NVM images
where a LLDP filter was already existent and the old AQ command would
generate an error if a new filter was attempted to be added. The newer
AQ command would detect this case and instead would add the current
target to the existing filter rule.

Fix the flow so that the newer command is always used if available and
only fall back to the older command when that is the only solution.

Fixes: 4d5a1c4e6d49 ("ice: do not add LLDP-specific filter if not necessary")
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h     |  1 -
 drivers/net/ethernet/intel/ice/ice_lib.c | 18 +++++-------------
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index fc91b6665f90..7eaa3d1e78a5 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -522,7 +522,6 @@ enum ice_pf_flags {
 	ICE_FLAG_MTU_CHANGED,
 	ICE_FLAG_GNSS,			/* GNSS successfully initialized */
 	ICE_FLAG_DPLL,			/* SyncE/PTP dplls initialized */
-	ICE_FLAG_LLDP_AQ_FLTR,
 	ICE_PF_FLAGS_NBITS		/* must be last */
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 8cdc4fda89e9..2fe91ff8119f 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2090,24 +2090,16 @@ void ice_vsi_cfg_sw_lldp(struct ice_vsi *vsi, bool tx, bool create)
 		status = eth_fltr(vsi, ETH_P_LLDP, ICE_FLTR_TX,
 				  ICE_DROP_PACKET);
 	} else {
-		if (!test_bit(ICE_FLAG_LLDP_AQ_FLTR, pf->flags)) {
+		status = ice_lldp_fltr_add_remove(&pf->hw, vsi, create);
+		if (status == -EOPNOTSUPP) {
+			/* If fltr_ctrl not supported, use legacy
+			 * add/remove command
+			 */
 			status = eth_fltr(vsi, ETH_P_LLDP, ICE_FLTR_RX,
 					  ICE_FWD_TO_VSI);
-			if (!status || !create)
-				goto report;
-
-			dev_info(dev,
-				 "Failed to add generic LLDP Rx filter on VSI %i error: %d, falling back to specialized AQ control\n",
-				 vsi->vsi_num, status);
 		}
-
-		status = ice_lldp_fltr_add_remove(&pf->hw, vsi, create);
-		if (!status)
-			set_bit(ICE_FLAG_LLDP_AQ_FLTR, pf->flags);
-
 	}
 
-report:
 	if (status)
 		dev_warn(dev, "Failed to %s %s LLDP rule on VSI %i error: %d\n",
 			 create ? "add" : "remove", tx ? "Tx" : "Rx",
-- 
2.55.0

