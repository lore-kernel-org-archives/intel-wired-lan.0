Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526A8F9EDC5
	for <intel-wired-lan@archiver.kernel.org>; Wed, 22 Apr 2026 12:36:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 113E76179C;
	Wed, 22 Apr 2026 12:36:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zgmorEFZnmNE; Wed, 22 Apr 2026 12:35:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1CDCA617A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776861357;
	bh=AYylWayqaQ5q7uaQcXpISp9j+vUIt2FvcgSsJt9L9Z8=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=ymR2pBHhOB0VQMAcRtnu90JHLmYyd0+5qWdIZ51FVy9jpIXpWCI82hL7Oz/bjJN/b
	 PbzU1wo1LmluKYMARRh8SZU9DukKPhmGmLwj8zuUnK7YXNU2hmki4ZMWX1L76rIid8
	 cHbzVjHaUwcVMx/Dk9EO6wlGxOzi59uMU7SgOeuL/HxsD0Ojku0yiwr7shwCdF7Xvf
	 mTl07JRgsdDfM32xtgpApDCVxCQmlEsekI+oVcjZLds4B+de9IQgMiNdfMu4QVYyY3
	 1FbI6cz5iOIg84JrJc2qfL8LCDy2Ip6wzzod+nrbxp9/zUJlQx+zJQ/+q1Snh2XH+4
	 2YO5lSOoL2Odw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1CDCA617A0;
	Wed, 22 Apr 2026 12:35:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 235B9183
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Apr 2026 12:35:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0996F84236
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Apr 2026 12:35:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uz6baUr-3eyk for <intel-wired-lan@lists.osuosl.org>;
 Wed, 22 Apr 2026 12:35:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7F4AE8421E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F4AE8421E
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7F4AE8421E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Apr 2026 12:35:51 +0000 (UTC)
X-CSE-ConnectionGUID: Z1uSC+xIR42LDqunX+2DqQ==
X-CSE-MsgGUID: Ig0cSxGuQ3uKU8jJM8BHUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77826161"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="77826161"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 05:35:51 -0700
X-CSE-ConnectionGUID: 8BLrhsojRN2Vwhg1bkaKJQ==
X-CSE-MsgGUID: eEEtCP66TeS8G38XyhnfBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="229167432"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
 by fmviesa007.fm.intel.com with ESMTP; 22 Apr 2026 05:35:50 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Wed, 22 Apr 2026 14:31:43 +0200
Message-Id: <20260422123144.485930-2-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260422123144.485930-1-grzegorz.nitka@intel.com>
References: <20260422123144.485930-1-grzegorz.nitka@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776861352; x=1808397352;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dfDAicP/XUpFlFpPbHueZb36ts8STy9ge9syiUh7sgQ=;
 b=NeXoUpljaegDh2td3nhjLgbXvo0KppNtTvJ5bebdK46YxSuhlybzL4SQ
 9mrsI7bQqnqmwG8iPmBEjZu7vz2zWgtKyIKz3jQqvCx06Gr22QXaSNekq
 VAi+Qs/JjnOKLpWmR3Wz8OWMjn1aD/sMF8KnGcYDh79YMWq3WM0yyIsT3
 7sod6Y2ENkiTfUxmjD/Z8DyCIXDcFhFVRdE6//hr1T9vnwVtilRvfqWYd
 Xb/vw0UNCZqbU/kxDRWweKi1kiz4rVjCRGM6ioJ86LkjvKHeQMAfkSsK7
 s9Hr6APd0yJy2vfAGiurRRSwEMfRCN6Ju0Qeq4SMrM295+LJrfapJgXew
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=NeXoUplj
Subject: [Intel-wired-lan] [PATCH iwl-net 1/2] ice: ptp: serialize E825 PHY
 timer start with PTP lock
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

ice_start_phy_timer_eth56g() programs TIMETUS registers and issues
INIT_INCVAL without holding the global PTP semaphore.

This allows concurrent PTP command paths to interleave with PHY timer
start, which can make the sequence fail and leave timer initialization
inconsistent.

Take the PTP lock around TIMETUS registers programming and INIT_INCVAL
command execution, and make sure the lock is released on all error paths.

Keep the subsequent sync step outside of this critical section, since
ice_sync_phy_timer_eth56g() takes the same semaphore internally.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Reviewed-by: Arkadiusz Kubalewski <Arkadiusz.kubalewski@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 672218e5d1f9..8bb94e785f2a 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2141,16 +2141,23 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 	}
 	incval = (u64)hi << 32 | lo;
 
+	if (!ice_ptp_lock(hw)) {
+		dev_err(ice_hw_to_dev(hw), "Failed to acquire PTP semaphore\n");
+		return -EBUSY;
+	}
+
 	err = ice_write_40b_ptp_reg_eth56g(hw, port, PHY_REG_TIMETUS_L, incval);
 	if (err)
-		return err;
+		goto err_ptp_unlock;
 
 	err = ice_ptp_one_port_cmd(hw, port, ICE_PTP_INIT_INCVAL);
 	if (err)
-		return err;
+		goto err_ptp_unlock;
 
 	ice_ptp_exec_tmr_cmd(hw);
 
+	ice_ptp_unlock(hw);
+
 	err = ice_sync_phy_timer_eth56g(hw, port);
 	if (err)
 		return err;
@@ -2166,6 +2173,10 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 	ice_debug(hw, ICE_DBG_PTP, "Enabled clock on PHY port %u\n", port);
 
 	return 0;
+
+err_ptp_unlock:
+	ice_ptp_unlock(hw);
+	return err;
 }
 
 /**
-- 
2.39.3

