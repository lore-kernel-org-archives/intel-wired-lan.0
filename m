Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90185CD342F
	for <intel-wired-lan@archiver.kernel.org>; Fri,  8 May 2026 03:49:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 621EC4076F;
	Fri,  8 May 2026 03:49:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uQuzzttMCLp2; Fri,  8 May 2026 03:49:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8F84040705
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778212143;
	bh=sXuqSCTKz7a0knryPYILfvGpwNPBOLPw8sIBBt5gfBQ=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sSLoSnpTWagA+S3TWAAFx7BlSU8yWAgG/ageS7cJ8NhoMCjBmVfC4qckZe/pDFXsz
	 W4ga4tM4CZgDshlkIEG3p2U5rgnaM+kUtiheliXg2JoDCpRq/ObLE/IIxyDedOvRsx
	 BvL5Jj8J7oIAH5vgvZnlFgUmazdhyh3z501PAQpO9rjL3Acx5iLu/1mYXEpqsOevOz
	 0Xxd66RmS5ftVX+x56bnyz8sV7Z++naRE558bs6LS5MyVv8ZhNQRyghTn922RfKa6l
	 TX4FbPQOY8qrsSmzgsXSyxR83tX31lG7ZzYLHUtMuAk4udqcAfataNI1nU1E2Rmkvl
	 hHKepiWTfCuOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F84040705;
	Fri,  8 May 2026 03:49:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 92686272
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 03:49:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 844D460B72
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 03:49:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kc8S-IkZzkNI for <intel-wired-lan@lists.osuosl.org>;
 Fri,  8 May 2026 03:49:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=khai.wen.tan@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9268460ABC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9268460ABC
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9268460ABC
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 03:49:00 +0000 (UTC)
X-CSE-ConnectionGUID: ub5cWh28R9KgjY4+OnO2Ow==
X-CSE-MsgGUID: yvGVq4u5RB6Gx6Gasg6XOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="90278904"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; d="scan'208";a="90278904"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 20:49:00 -0700
X-CSE-ConnectionGUID: tQz1KoGLSv6V5FnKrJZ9Kw==
X-CSE-MsgGUID: SJDb0zO8T0SRoBK3KiyUXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; d="scan'208";a="236767321"
Received: from unknown (HELO localhost.png.intel.com) ([10.107.255.61])
 by orviesa009.jf.intel.com with ESMTP; 07 May 2026 20:48:56 -0700
From: KhaiWenTan <khai.wen.tan@linux.intel.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, faizal.abdul.rahim@intel.com,
 hong.aun.looi@intel.com, hector.blanco.alcaine@intel.com,
 khai.wen.tan@intel.com, Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
 Khai Wen Tan <khai.wen.tan@linux.intel.com>
Date: Fri,  8 May 2026 05:47:05 +0800
Message-ID: <20260507214706.309984-4-khai.wen.tan@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507214706.309984-1-khai.wen.tan@linux.intel.com>
References: <20260507214706.309984-1-khai.wen.tan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778212141; x=1809748141;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NEze/O911ldqimOh6WbrfXYQde70TWMivjIbXg4pGRg=;
 b=Y7TME5/oLV7E8prgRReK9D35coR8FT9pvy+n7RkCUho0Iep+LbsbOHtl
 +bLNt08bLIAz0YfmFTLP8r7oUA9GnhzQvEXMof5OyKupFRwGodA2GygaD
 UlfENghhIU+0emNpojA/p7ZHytsoXwEM2uEaQEzdzeefh/8uxtt3a3ZEK
 APpWU/crhs9sPFZo0oLPT7ZJVj4y0X13zr3+cZPO0b7l0d51ECvi12P+n
 8G1335B7naIsZRr8q9/3v48FEoK9lJzoin8UbmshL/9ateWbRr4TllL0w
 5lSLe21V7ACbU0dwYwgNTO8ot1kRn53Wlfok/a5KVytWITBiZWnZqE2FW
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Y7TME5/o
Subject: [Intel-wired-lan] [PATCH iwl-next v5 3/4] igc: replace goto out
 with direct returns in igc_config_fc_after_link_up()
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

The out: label only returns ret_val with no cleanup. The kernel coding
style guide states: "If there is no cleanup needed then just return
directly." (Documentation/process/coding-style.rst, section 7).

This improves readability ahead of a subsequent patch that introduces a
new goto label in this function.

No functional change.

Reviewed-by: Looi Hong Aun <hong.aun.looi@intel.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Signed-off-by: Khai Wen Tan <khai.wen.tan@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_mac.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/ethernet/intel/igc/igc_mac.c
index 142beb9ae557..0a3d3f357505 100644
--- a/drivers/net/ethernet/intel/igc/igc_mac.c
+++ b/drivers/net/ethernet/intel/igc/igc_mac.c
@@ -458,15 +458,15 @@ s32 igc_config_fc_after_link_up(struct igc_hw *hw)
 	ret_val = hw->phy.ops.read_reg(hw, PHY_STATUS,
 				       &mii_status_reg);
 	if (ret_val)
-		goto out;
+		return ret_val;
 	ret_val = hw->phy.ops.read_reg(hw, PHY_STATUS,
 				       &mii_status_reg);
 	if (ret_val)
-		goto out;
+		return ret_val;
 
 	if (!(mii_status_reg & MII_SR_AUTONEG_COMPLETE)) {
 		hw_dbg("Copper PHY and Auto Neg has not completed.\n");
-		goto out;
+		return ret_val;
 	}
 
 	/* The AutoNeg process has completed, so we now need to
@@ -478,11 +478,11 @@ s32 igc_config_fc_after_link_up(struct igc_hw *hw)
 	ret_val = hw->phy.ops.read_reg(hw, PHY_AUTONEG_ADV,
 				       &mii_nway_adv_reg);
 	if (ret_val)
-		goto out;
+		return ret_val;
 	ret_val = hw->phy.ops.read_reg(hw, PHY_LP_ABILITY,
 				       &mii_nway_lp_ability_reg);
 	if (ret_val)
-		goto out;
+		return ret_val;
 	/* Two bits in the Auto Negotiation Advertisement Register
 	 * (Address 4) and two bits in the Auto Negotiation Base
 	 * Page Ability Register (Address 5) determine flow control
@@ -598,7 +598,7 @@ s32 igc_config_fc_after_link_up(struct igc_hw *hw)
 	ret_val = hw->mac.ops.get_speed_and_duplex(hw, &speed, &duplex);
 	if (ret_val) {
 		hw_dbg("Error getting link speed and duplex\n");
-		goto out;
+		return ret_val;
 	}
 
 	if (duplex == HALF_DUPLEX)
@@ -610,10 +610,9 @@ s32 igc_config_fc_after_link_up(struct igc_hw *hw)
 	ret_val = igc_force_mac_fc(hw);
 	if (ret_val) {
 		hw_dbg("Error forcing flow control settings\n");
-		goto out;
+		return ret_val;
 	}
 
-out:
 	return ret_val;
 }
 
-- 
2.43.0

