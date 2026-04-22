Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03621F9EDC5
	for <intel-wired-lan@archiver.kernel.org>; Wed, 22 Apr 2026 12:36:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC577617AE;
	Wed, 22 Apr 2026 12:36:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ECKZLPMXGg72; Wed, 22 Apr 2026 12:36:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C3AD5617AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776861359;
	bh=dnZsxVsFr22d5OmToS2JmCiGmh3eHykezaEML6y2Zz8=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=40OJZ29BYl4cUaeE5r52gZ/Gcq+iJ6/CV8ik13tMh3HJT55kYwFduqJjU+MjMlG+U
	 nWLU4rGYGDdBA6/u8zXZSSDBgNg+ZFl3hsY//uF5cj6/4WbQ0EvhA1WlD8AeMIRV4i
	 E6rWTVBD49e++/m0PcBlXB8SWR2+9c+yTgdkerJcJZXAG66iFRipmgwEkxBfja73cG
	 JON+lrfMRE5uvv7l5ypdaVj8GqkQLzdJKuqGdd1q/RIrA06yZd8EmUnN1EFUHwGh6c
	 /+CK8e5FCelJaCwo3Flsi7FO+Vdh9utsvBYAitf9PyqqM360zRUBhD5HLG0CVsTg1J
	 Zpprk2KiPkOag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C3AD5617AC;
	Wed, 22 Apr 2026 12:35:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 41CEE24D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Apr 2026 12:35:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 33E378423C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Apr 2026 12:35:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BuIV0lZjDgxS for <intel-wired-lan@lists.osuosl.org>;
 Wed, 22 Apr 2026 12:35:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1E3A684222
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1E3A684222
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E3A684222
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Apr 2026 12:35:53 +0000 (UTC)
X-CSE-ConnectionGUID: yft8iJKNR1SpzYBn64IKMg==
X-CSE-MsgGUID: +WFCMoidSVWAEIOU2FO4BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77826166"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="77826166"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 05:35:54 -0700
X-CSE-ConnectionGUID: jnPp+D69RzWk8HTMMSZLhg==
X-CSE-MsgGUID: SIJp+xLLQbOKFjQTNtXCzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="229167437"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
 by fmviesa007.fm.intel.com with ESMTP; 22 Apr 2026 05:35:52 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Wed, 22 Apr 2026 14:31:44 +0200
Message-Id: <20260422123144.485930-3-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260422123144.485930-1-grzegorz.nitka@intel.com>
References: <20260422123144.485930-1-grzegorz.nitka@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776861354; x=1808397354;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wDLA3/GJGEO1IbM955Q5FElcfpvCOUEomPnwlKEBe7g=;
 b=XtRsKYsHLMMIOvBawBL7pVE0F3l7lPgw1J3Dd4mnjYZWONW7GkpKKe5Y
 /csQC2k2c2xQ7u1qLX5tshUe24HDkDEjcV/wn0azWzm400gLPEXymVQwY
 9li/0BgpcfDCQn7GQ2VsXQjt7LYDc2ywQ2Gh1nE7xLN3uJ5CgRqFNOica
 C6rrEcQFJ5ChTgCk3XF0GKnO0Nl90dXGU2+9SNgpo6vYDkNUyXCrYCi+T
 lET8sjunlJYCVxK7xd6vdikoRkPvISRABiun18orZ1zkKwuMxnaGm/rZJ
 UJR1S4MZWkEpT6aeO0L+y4MDQLAMGcRzV5pKPROGv60JPqpDar8Iz97lo
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=XtRsKYsH
Subject: [Intel-wired-lan] [PATCH iwl-net 2/2] ice: ptp: use primary NAC
 semaphore on E825
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
Cc: netdev@vger.kernel.org,
 Arkadiusz Kubalewski <Arkadiusz.kubalewski@intel.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

For E825 2xNAC configurations, PTP semaphore operations must hit the
primary NAC register block so both sides coordinate on the same lock.

Commit e2193f9f9ec9 ("ice: enable timesync operation on 2xNAC E825
devices") updated other primary-only PTP register accesses to
use the primary NAC on non-primary functions, but left ice_ptp_lock()
and ice_ptp_unlock() operating on the local NAC. As a result, secondary
NAC PTP paths can take a different semaphore than the primary side.

Select the primary hardware in ice_ptp_lock() and ice_ptp_unlock() when
the current function is not primary, keeping semaphore operations
symmetric and consistent with the rest of the 2xNAC PTP register access
path.

Fixes: e2193f9f9ec9 ("ice: enable timesync operation on 2xNAC E825 devices")
Reviewed-by: Arkadiusz Kubalewski <Arkadiusz.kubalewski@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 8bb94e785f2a..2c18e16fe053 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -5264,9 +5264,13 @@ static void ice_ptp_init_phy_e830(struct ice_ptp_hw *ptp)
  */
 bool ice_ptp_lock(struct ice_hw *hw)
 {
+	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
 	u32 hw_lock;
 	int i;
 
+	if (!ice_is_primary(hw))
+		hw = ice_get_primary_hw(pf);
+
 #define MAX_TRIES 15
 
 	for (i = 0; i < MAX_TRIES; i++) {
@@ -5293,6 +5297,11 @@ bool ice_ptp_lock(struct ice_hw *hw)
  */
 void ice_ptp_unlock(struct ice_hw *hw)
 {
+	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
+
+	if (!ice_is_primary(hw))
+		hw = ice_get_primary_hw(pf);
+
 	wr32(hw, PFTSYN_SEM + (PFTSYN_SEM_BYTES * hw->pf_id), 0);
 }
 
-- 
2.39.3

