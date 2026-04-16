Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7B2F433D7
	for <intel-wired-lan@archiver.kernel.org>; Thu, 16 Apr 2026 02:18:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0696D606B6;
	Thu, 16 Apr 2026 02:18:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lf1vTb1j8Djc; Thu, 16 Apr 2026 02:18:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3228B606B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776305919;
	bh=V2Ab4UYJaE9SmzIHVi5i8hY2v1mIT8vrFkY5w5BZU8o=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GYHJGHs6jdwiYyHFNshO8dTfS6G/VsfuBTpb/KHG3bSwT96XF+pkXP8DzgyYIcfXZ
	 R6J/WUXPWmmrMqxlEnnTRsR3ReRu/BhkwQU8a43C8Rk2jFo1NKLFgxU7GsdO4pK6ZH
	 09A5Afng1HZy/EMhFbCvLyELAq6yyqa2sNXTnjy4wy0a5hBQ4sCiXVoJchjUaw60L1
	 JKFevBIWhMcnf+e4WT4d5EQ/yFBfdNDVD8xiiVSG1MsX8p97VBnpGKNLhYc1FJQKVA
	 Afst2bRQsVTWSlaiEsqVoLRIbdfLpeRHnxOt8InUKd3phDnjJv4jTUHvfB8PTSalKv
	 xbSjafFYAoefg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3228B606B0;
	Thu, 16 Apr 2026 02:18:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A39222CF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Apr 2026 02:18:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BB71680B30
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Apr 2026 02:18:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hz81MvcZvKhX for <intel-wired-lan@lists.osuosl.org>;
 Thu, 16 Apr 2026 02:18:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=khai.wen.tan@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9605680B19
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9605680B19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9605680B19
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Apr 2026 02:18:33 +0000 (UTC)
X-CSE-ConnectionGUID: WoikAMpaTzenBlUUDsEAOg==
X-CSE-MsgGUID: vIZcEh9XRqW9C9PK+lQUMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="81168786"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; d="scan'208";a="81168786"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2026 19:18:31 -0700
X-CSE-ConnectionGUID: ogkBqb77Tx6Yp4YuXiAr8g==
X-CSE-MsgGUID: I/l2S9ZVSOGuSTcdkfquig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; d="scan'208";a="227442170"
Received: from unknown (HELO localhost.png.intel.com) ([10.107.255.61])
 by fmviesa007.fm.intel.com with ESMTP; 15 Apr 2026 19:18:27 -0700
From: KhaiWenTan <khai.wen.tan@linux.intel.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, faizal.abdul.rahim@intel.com,
 hong.aun.looi@intel.com, khai.wen.tan@intel.com,
 Faizal Rahim <faizal.abdul.rahim@linux.intel.com>, Looi,
 KhaiWenTan <khai.wen.tan@linux.intel.com>
Date: Thu, 16 Apr 2026 09:55:18 +0800
Message-ID: <20260416015520.6090-2-khai.wen.tan@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416015520.6090-1-khai.wen.tan@linux.intel.com>
References: <20260416015520.6090-1-khai.wen.tan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776305913; x=1807841913;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=c24xY4k2Ax9/vCwMkRqzVcK6y2+W/l1sJdoufcjIGA0=;
 b=Vj6G+HHsf7Q9Iile0AzwOw1eQbud9phYINs1z2lEbQPvJtbtbwYk+vHp
 cxsDUlB8OEuCdCGNJCLigEhOVbsUC3abJv6yAeouBtdWR2K4Wkehn1DV6
 wC39pWFv6MvaBLytAMoREGva7LZUXXN9DBwQg9Y5E7s6kcaNBbnc3rZE+
 Ccub0QOt/wx2on+P+FTl9QyAdAnQKNB5qf2DuwAG7cVOyGPev3wZX/12s
 q3XZgwo9qessvJKSQ2xjhp9GqtXHadDLproRMMvu54/xofdhF1efed7gD
 OJSyxqeMqT9Y5c9HdmsdZR6w50o46KXKPYUJa2CfMG91RadwTBAo4zP3y
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Vj6G+HHs
Subject: [Intel-wired-lan] [PATCH iwl-next v2 1/3] igc: remove unused
 autoneg_failed field
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

From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

autoneg_failed in struct igc_mac_info is never set in the igc driver.
Remove the field and the dead code checking it in
igc_config_fc_after_link_up().

Reviewed-by: Looi, Hong Aun <hong.aun.looi@intel.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_hw.h  |  1 -
 drivers/net/ethernet/intel/igc/igc_mac.c | 16 +---------------
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
index be8a49a86d09..86ab8f566f44 100644
--- a/drivers/net/ethernet/intel/igc/igc_hw.h
+++ b/drivers/net/ethernet/intel/igc/igc_hw.h
@@ -92,7 +92,6 @@ struct igc_mac_info {
 	bool asf_firmware_present;
 	bool arc_subsystem_valid;

-	bool autoneg_failed;
 	bool get_link_status;
 };

diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/ethernet/intel/igc/igc_mac.c
index 7ac6637f8db7..142beb9ae557 100644
--- a/drivers/net/ethernet/intel/igc/igc_mac.c
+++ b/drivers/net/ethernet/intel/igc/igc_mac.c
@@ -438,28 +438,14 @@ void igc_config_collision_dist(struct igc_hw *hw)
  * Checks the status of auto-negotiation after link up to ensure that the
  * speed and duplex were not forced.  If the link needed to be forced, then
  * flow control needs to be forced also.  If auto-negotiation is enabled
- * and did not fail, then we configure flow control based on our link
- * partner.
+ * then we configure flow control based on our link partner.
  */
 s32 igc_config_fc_after_link_up(struct igc_hw *hw)
 {
 	u16 mii_status_reg, mii_nway_adv_reg, mii_nway_lp_ability_reg;
-	struct igc_mac_info *mac = &hw->mac;
 	u16 speed, duplex;
 	s32 ret_val = 0;

-	/* Check for the case where we have fiber media and auto-neg failed
-	 * so we had to force link.  In this case, we need to force the
-	 * configuration of the MAC to match the "fc" parameter.
-	 */
-	if (mac->autoneg_failed)
-		ret_val = igc_force_mac_fc(hw);
-
-	if (ret_val) {
-		hw_dbg("Error forcing flow control settings\n");
-		goto out;
-	}
-
 	/* In auto-neg, we need to check and see if Auto-Neg has completed,
 	 * and if so, how the PHY and link partner has flow control
 	 * configured.
--
2.43.0

