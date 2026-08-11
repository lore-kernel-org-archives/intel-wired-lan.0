Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B5CC5CFC1
	for <intel-wired-lan@archiver.kernel.org>; Tue, 11 Aug 2026 23:11:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E1C060766;
	Tue, 11 Aug 2026 23:11:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LQqIhYcCi8ET; Tue, 11 Aug 2026 23:11:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1BB8260728
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786489871;
	bh=9rMFHFqcffoQQ9fJy49kh4LiQBiKhs4sRzbcAigzzlQ=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mEuF16X7MUkFuTvlYqfIodr5aRtExFbpGjBS27xEVCfoRrmWjs0VlfuHUzXIffLzT
	 ywKarRAdx60OluKQt55useP2WkQaaVlr0+aTxJ/gsaNIIMath/cfV1/zBkqO8mA4GK
	 +jdOA/bwoo8FEE6u5fBStPkbSkxrAUFOGrXbicOebcEf6z45PgWkG/PL48Bc5OuWow
	 e5eACkOKIMx/VsDNsbqFsubw53n3mwpoTJiYkf2WbCJzo5htE3KFYCjKhyc+0drhZa
	 2Nb+fw0V73NdK6o6YXVdH1KhnGzvhjW/rgDC+FxdbUDfIjhESdmgzWrLYaGmcGQiki
	 ccI7F5rKS9BqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1BB8260728;
	Tue, 11 Aug 2026 23:11:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1298B49B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 11 Aug 2026 23:11:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ED9DE4037E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 11 Aug 2026 23:11:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uvAd51oNQDQ4 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 11 Aug 2026 23:11:09 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=anthony.l.nguyen@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4E3A8400BC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4E3A8400BC
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4E3A8400BC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 11 Aug 2026 23:11:08 +0000 (UTC)
X-CSE-ConnectionGUID: fLC75qolSeaDBdX74zahlg==
X-CSE-MsgGUID: fWC7hdbUSICBCv4wsZlrjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="97626768"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; d="scan'208";a="97626768"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 16:11:08 -0700
X-CSE-ConnectionGUID: jvgS1nFXQCG89mNUgqdpXw==
X-CSE-MsgGUID: mPbTl7fjQ/K5Inv8TJgrsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; d="scan'208";a="293401722"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
 by orviesa002.jf.intel.com with ESMTP; 11 Aug 2026 16:11:08 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Maciek Machnikowski <maciej.machnikowski@intel.com>,
 netdev@vger.kernel.org, jacob.e.keller@intel.com,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue, 11 Aug 2026 16:10:56 -0700
Message-ID: <20260811231058.220370-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786489869; x=1818025869;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=YtQIHTEzC7RyWvUtVZaWiSAzCYcMdIK+HtzcnYnM1Yg=;
 b=IMl2I3XupUESE++X2J7YCdGrudiWghbFz2SIf6IVCJQg9dfoU97iJypS
 chn6gRNIguleJ0s19xXRoo12vk1ZxBr0uvEC4DCpT6XDonZjU36BgZ1/n
 S7eymkdTygNhTaco/GG8nqhhYYWNq5Tuwq0ppYYEySijcuFOKVFIpMGwO
 PmtsjLJsjpCLGQ/EWQCBbzfei/+2Yo3S4zjbuWvKga/fhUnAqYY7YjiO/
 ibGrdvv8gg+l3RFZtMkNVnsF6BrmdQaSPJuZTBNqoEVJLkUAwjrCVt4Rk
 X3PWtdSXeBYY29meQllM1/OXnBo6j+u9se27mGn7zrfCzlZZhI/6NXfZQ
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=IMl2I3Xu
Subject: [Intel-wired-lan] [PATCH iwl-net] ice: Recalibrate PHY after
 settime64 on E825-C
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

From: Maciek Machnikowski <maciej.machnikowski@intel.com>

The PHY on E825-C requires recalibration after large jumps of the
system time. Add missing PHY recalibration also on E825-C.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Signed-off-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 84b99cfc5675..bf625b9f4991 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1956,8 +1956,9 @@ ice_ptp_settime64(struct ptp_clock_info *info, const struct timespec64 *ts)
 	/* Reenable periodic outputs */
 	ice_ptp_enable_all_perout(pf);
 
-	/* Recalibrate and re-enable timestamp blocks for E822/E823 */
-	if (hw->mac_type == ICE_MAC_GENERIC)
+	/* Recalibrate and re-enable timestamp blocks for E822/E823/E825-C */
+	if (hw->mac_type == ICE_MAC_GENERIC ||
+	    hw->mac_type == ICE_MAC_GENERIC_3K_E825)
 		ice_ptp_restart_all_phy(pf);
 exit:
 	if (err) {
-- 
2.47.1

