Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D689C5AC67
	for <intel-wired-lan@archiver.kernel.org>; Tue, 11 Aug 2026 21:09:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C028406CF;
	Tue, 11 Aug 2026 21:09:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id thrgyAGv9eeY; Tue, 11 Aug 2026 21:09:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 09625406C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786482544;
	bh=lnTML3P5tA9B45SI2F+YlwvL9u29QRzaaEyFLzfrEfg=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QPboKmupdw5astSO2qzI8Dmcm6VUXYOEclHXJeHP2xanTqh0T1P9NXQ9YtsfaxQBf
	 nKtX+ID5DtXqXrn2WGMEordL04Q8dMEpnXG4IX1tOTLkxLpCET7USn+tC4LbErMIh5
	 Ev9fWOL1TrMeVFoVug58eYTCUej/69aSo10acIUZHHFPsjV0jbwv0vEWiK4/wZqDhW
	 m918oDrQ+douW3sBTJZsAVkwJZJKzlSaGLNA+fY7J9yPk/zvGnAqAEXa2wq89yshE5
	 WbmxvfJXG2EeFB14rS60f0VvuWxeQfdJ8qnbSVD2EPlSTr9oAjp5wA2db2yGNf6bwa
	 EH4izCfU+i8NA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 09625406C0;
	Tue, 11 Aug 2026 21:09:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EEF0F1B8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 11 Aug 2026 21:09:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D51C540251
 for <intel-wired-lan@lists.osuosl.org>; Tue, 11 Aug 2026 21:09:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h5UjGeahhlw8 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 11 Aug 2026 21:09:02 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=david.m.ertman@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1B2C74024D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1B2C74024D
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1B2C74024D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 11 Aug 2026 21:09:01 +0000 (UTC)
X-CSE-ConnectionGUID: 3wy8F6OQR/6qpr3/LHPb5Q==
X-CSE-MsgGUID: iLuYgVsvSTarITr6rvZN5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="98542017"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; d="scan'208";a="98542017"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 14:09:01 -0700
X-CSE-ConnectionGUID: nQR5LLpWTXmpD+COpJt7OQ==
X-CSE-MsgGUID: 54rR1qTtS8CARYNUnCZzqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; d="scan'208";a="268594453"
Received: from dmert-dev.jf.intel.com ([10.166.241.33])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 14:09:00 -0700
From: Dave Ertman <david.m.ertman@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Date: Tue, 11 Aug 2026 14:11:27 -0400
Message-ID: <20260811181127.1142095-1-david.m.ertman@intel.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786482542; x=1818018542;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=aVi0oTxKil65uBY1E9T3MK7XfbJsxmnfyI56zDaj6Co=;
 b=Em+9NVTve6nSqP9REHzr+kAOXx1CYAOBGYcdP4nBSUoEgjp50HPgaXZf
 VB65OE6hvXXQKq1X6CkK34ilAyUXvGlmYrFlPS0KAz1zXURyEivpme3fk
 PCjeCuzjzf6H0Z02Cl9CEgC4sWxiYcVgJRvsXYecM+3lyiN4sEH/hjZ38
 Sf07WghLNwwa+QPQhqbLFFdCECp7Z7gBPq5wHsuhw6TtyZUrDzwiCnpq4
 yMMZv/EEFKONL9WQADbFp3YYYF+uoOtgkYnfoezDVTLXMtU+Xj1oHqcot
 EVFwJ4LeD6sNL0WkejVbHNB98nUyDNJrOafBsLPup1CLkWfIbGR08bpsH
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Em+9NVTv
Subject: [Intel-wired-lan] [PATCH iwl-net v2] ice: Fix incorrect LLDP filter
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

Also remove the obsolete state flag from the PF struct.

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

