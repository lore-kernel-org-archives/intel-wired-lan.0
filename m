Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A967C61CE0
	for <intel-wired-lan@archiver.kernel.org>; Sat, 22 Aug 2026 00:15:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37FCB40C94;
	Sat, 22 Aug 2026 00:15:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3b9yc3ssvZyG; Sat, 22 Aug 2026 00:15:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787357705;
	bh=xrhVP44M0uu9o9WcGV1L9wK57OBhIncVGvv82xgdV3Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QVREew9Qz3F2VXVE0do6qET8lw4DEkuNXMSsflKjYXrEDS9kwUdoWaHLgJF8JSPX9
	 l4AJr2TuDvxNAqX4cZm/rR4u1ZuEHvtsqFogtQLO/JIED/Say+AdBFRcElrmnlLPuh
	 n6aD3w6YecR7MPegApTxbI8B+96Mwjd6UOPw/JEWioyLv4aT4ooRe44uO0YBcFiDGb
	 oSNKUWADC8y3uOvodemNy1ZrPp6hCVhlmLFf6QY/D74sqQG7t1sRKsXf3v2z3HXcG5
	 WTdGhbCGQuPdwxViGdau3HPm1p50x6oQBFQGp6Y2eaS4BXqzi2DMmGZL/yNTcl97Ac
	 3auk3BidawXyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 829A4409AD;
	Sat, 22 Aug 2026 00:15:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2BB9493F
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 00:15:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1219140A15
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 00:15:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 35nnZFyCoM1O for <intel-wired-lan@lists.osuosl.org>;
 Sat, 22 Aug 2026 00:14:59 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=BaeasbKG
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 64E11409D4
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 00:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787357699; x=1818893699;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=vWu93L1aH9mRZpG4WlKRxDjnhWyZBrPm4y8f8ZlKZRo=;
 b=BaeasbKGus0jQ8FSSsri04jYDQt65N0nwgaYFgmML64Me+WgfWDwDAgc
 S9BEGoXRcizMMgR7BB2vdu9mOvNI3dyXBBYSrSPoJKFh2MgjPuThjG/xW
 w+uIVCkyMc/SsxAtIiGo/ECyQAui5bEMm0a+QD7sr5+PYtFIiWNZHI9FL
 Q34iwW4rM1PwCAQLjXWQU3ejm9xKEyZIBrEN+pKuWmdfMm6+IZjLyU7Wm
 blMViASjIjIXeWbQpZa1kajmwXS2Aj76fF5gcpBIaeRstt3zGYMyRjx/T
 4TyQBheMAorM+16FmGGDB1zZgb4f7QnuuqkwcvJ3NI0PB5H7odbZpuKn7 w==;
X-CSE-ConnectionGUID: H/PUYy83TR+G5UEGg0bFug==
X-CSE-MsgGUID: RB6ygo16TZKadLWSu93iSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="91584760"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="91584760"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 17:14:57 -0700
X-CSE-ConnectionGUID: GxzQ9OUwTHihfokhp46Ccw==
X-CSE-MsgGUID: EyHP+bTwTVOpOUZFAo+Nag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="263836465"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 17:14:57 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 21 Aug 2026 17:13:08 -0700
Subject: [PATCH iwl-net 03/12] ice: E822: cancel offset verification work
 during reset preparation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-jk-e825c-minimized-fixes-v1-3-9d0731eb4858@intel.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: netdev@vger.kernel.org, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>, 
 alexander.nowlin@intel.com, kevin.bross@intel.com, ranjit.cavatur@intel.com, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Karol Kolacinski <karol.kolacinski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-75809
X-Developer-Signature: v=1; a=openpgp-sha256; l=2204;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=Q2gnlL9WCKEzu7czMr+gDV5QOyocVetwd2FMVaQsfKM=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqyOlz8nyB6oOM142tqSUYyZ79WNhGO6mbf2XtQQSJuvM
 PPIFdZ1HaUsDGJcDLJiiiwKDiErrxtPCNN64ywHM4eVCWQIAxenAExkynWGf5YuIl+E1/vohnb8
 9lCpWT9V/jVri2n3RG1XhUe7V+RsesDIsJ611DHGw7aKf/2371lB3CtamqTfzr2Var0oZ1nEI/d
 4LgA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
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
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 9d99cbb42463..b8647a39db6d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2994,6 +2994,14 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
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
2.55.0.814.gc42f45431d0f

