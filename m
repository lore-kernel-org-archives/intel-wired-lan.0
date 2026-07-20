Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17BAC44515
	for <intel-wired-lan@archiver.kernel.org>; Mon, 20 Jul 2026 12:00:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F4CA405DE;
	Mon, 20 Jul 2026 12:00:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GCaAvLGaVK0G; Mon, 20 Jul 2026 12:00:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B7872405E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784548802;
	bh=Ex54XY14TPx68reyzWv1JLiqflhQ5Ex8Axi7YPWvPw0=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yn6fHgTpVSzwUWvY79Qk0f9cOZRKEvt17xYhUdHPOtPiCOHOYv2G1C5nC3VOGaPfK
	 gDAWeUE2WPaaP0E7UGn0qLSbW0kjZPqwhQMfDAsMiDPmJxskR1F8Vfr+FZP/xa4XuN
	 NNmoGEkwm2mcTlALvLESaVRD+BH67p1ET8mRoKj+sdT5WObrPLw+zbqSZP9tGZy1mM
	 RzHmY3Y8WSxGKxMhSaN/0A+Rgsz5aF3LcofTDp7MWLeZ+Lf8LTv0nuX2wkqIahmnRs
	 8FI9YspDWErO/PPLWY3jKrKwxmk+peF68g/hNF+pmyz2Kts/4LLpQWs+LMGQchF7GL
	 uzVbZyubDtTNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B7872405E9;
	Mon, 20 Jul 2026 12:00:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C1B5206
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 12:00:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0244F60667
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 12:00:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G-Sl07pOVqxQ for <intel-wired-lan@lists.osuosl.org>;
 Mon, 20 Jul 2026 12:00:00 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=przemyslaw.korba@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org F0A4660663
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F0A4660663
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F0A4660663
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 11:59:59 +0000 (UTC)
X-CSE-ConnectionGUID: 5rTjf8gcTrezR8Pj0V+0dQ==
X-CSE-MsgGUID: EUHMQvnSSa+6hzXPBWYwxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85328180"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="85328180"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 05:00:00 -0700
X-CSE-ConnectionGUID: 58Jrd2qnRZOccd38VEz6oA==
X-CSE-MsgGUID: sbcuDswiRFOWL/6GD8ghpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="258078406"
Received: from pae-d-dell-r7525-263.igk.intel.com ([172.28.191.240])
 by orviesa009.jf.intel.com with ESMTP; 20 Jul 2026 04:59:58 -0700
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, aleksandr.loktionov@intel.com,
 arkadiusz.kubalewski@intel.com, konstantin.ilichev@intel.com,
 Przemyslaw Korba <przemyslaw.korba@intel.com>
Date: Mon, 20 Jul 2026 14:01:31 +0200
Message-ID: <20260720120151.2675206-4-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720120151.2675206-1-przemyslaw.korba@intel.com>
References: <20260720120151.2675206-1-przemyslaw.korba@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784548800; x=1816084800;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ps/3r+DGIS5f0w6yq40Tm1HkyRmExGtUJeU3P2xhp6k=;
 b=RqsUr50GlUa9L0QEcL0RhqYPKpWwjFCGmxAurpP78b1H99qOQHPsxC8q
 qH4aHZcMsvRWh44U2/t3s5kTwGfepu6N2gPTrGzJBJ3/wTkalnYKlOKLK
 A92PRTV549+YhHCojb2xzWttr81/PhvC2yFlkXzrNZGuy8n5uJIBT1qaw
 G1FcywsFlj0Soin3M9pbjLEfIrAb0O5uYNfyQliTPsNmEMVhzsdu3Nrsp
 WAGkJl3ycvM1ba3roAny+t9cOnOk8GA3EP2a6NKcjB++uLcRDPOa+FpN4
 VFfEErEpY5Yf+Zx+4xmmVxdcDoSGT1vlOyOGAWNbMUIODQN0W/3728G2T
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=RqsUr50G
Subject: [Intel-wired-lan] [PATCH iwl-net 3/4] ice: cancel E82x offset
 verification work during reset preparation
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

From: Karol Kolacinski <karol.kolacinski@intel.com>

Cancel the offset verification delayed work (ov_work) during PTP reset
preparation to prevent it from running concurrently with the reset
sequence.

Without this, ice_ptp_wait_for_offsets() can execute during a reset,
find that ice_is_reset_in_progress() is true, and re-queue itself in a
tight loop. Meanwhile, the reset path in ice_ptp_rebuild_owner() calls
ice_ptp_port_phy_restart(), which starts a new ov_work. This results in
two ov_work instances running simultaneously, racing over the PHY offset
registers and the calibrating flag.

Cancel ov_work in ice_ptp_prepare_for_reset() alongside the existing
cancellation of the Tx tracker. The comment in the existing code already
documents that ov_work interference during reset is a concern but only
cancels it during ice_ptp_release().

Fixes: 4809671015a1 ("ice: Fix E810 PTP reset flow")
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 9d9d9958fe5c..e0be88024ac3 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3042,6 +3042,14 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	if (reset_type == ICE_RESET_PFR)
 		return;
 
+	/* Cancel the offset verification work for E82x before releasing the
+	 * Tx tracker. If ov_work is running during reset, it may issue
+	 * sideband queue commands that will fail or timeout, and may
+	 * reference state that is being torn down.
+	 */
+	if (hw->mac_type == ICE_MAC_GENERIC)
+		kthread_cancel_delayed_work_sync(&ptp->port.ov_work);
+
 	if (ice_pf_src_tmr_owned(pf) && hw->mac_type == ICE_MAC_GENERIC_3K_E825)
 		ice_ptp_prepare_rebuild_sec(pf, false, reset_type);
 
-- 
2.43.0

