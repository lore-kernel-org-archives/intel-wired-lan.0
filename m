Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AB4FA1FD1
	for <intel-wired-lan@archiver.kernel.org>; Wed, 22 Apr 2026 16:20:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D1EE34052A;
	Wed, 22 Apr 2026 16:20:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HKLxXt7rNhgG; Wed, 22 Apr 2026 16:20:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 432374047B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776874817;
	bh=EVoEvpinx7UrEYecHHIFKB8fKx60mrGwXkn35wH4hQA=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yKKZFurCcriIAVL/zRdSFraYdVynoXvLcYtMQ06jGOYAOP3CJsRhcSYSvi7iu8C++
	 5Ug2VN9U5dht20Ytu0/TL54FUMCjpQw1nJH0YSb13WrMKE9glAOqROX8dEHoAw2u2C
	 e0DQIILb7lJKsHq6vA2OFSjTwXVAid7JlO4bkqDcX5SyYJShgxqpekIrVRCImrfLXJ
	 6D4WxkDn51A/ziBQ6K4Jwep0fLJE6P9huuDUCrlk6S/HzhAVKS5lNDCezp2I2R14NA
	 RnurL5YnULJfmuD/jtIjUW2nWWXDTv9LtORhKqx+rVdM/OQG4661ENwl4pHD9BaBUm
	 4lBVUj2bmtawA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 432374047B;
	Wed, 22 Apr 2026 16:20:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E24B257
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Apr 2026 16:20:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2FCA760E27
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Apr 2026 16:20:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ErScL7i57ADh for <intel-wired-lan@lists.osuosl.org>;
 Wed, 22 Apr 2026 16:20:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=khai.wen.tan@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1F1E560DBF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1F1E560DBF
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1F1E560DBF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Apr 2026 16:20:14 +0000 (UTC)
X-CSE-ConnectionGUID: I2PN88N6Q9Ko9qbJCKP7jA==
X-CSE-MsgGUID: 5q7Vkd+5TmWNgMwMe49xzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="88134468"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; d="scan'208";a="88134468"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 09:20:14 -0700
X-CSE-ConnectionGUID: IDh7d9TfQ/O9w1f1XGKR/Q==
X-CSE-MsgGUID: Xg1hl9e7TBusYlz7eQlmxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; d="scan'208";a="228052438"
Received: from unknown (HELO localhost.png.intel.com) ([10.107.255.61])
 by fmviesa010.fm.intel.com with ESMTP; 22 Apr 2026 09:20:10 -0700
From: KhaiWenTan <khai.wen.tan@linux.intel.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, faizal.abdul.rahim@intel.com,
 hong.aun.looi@intel.com, khai.wen.tan@intel.com,
 Faizal Rahim <faizal.abdul.rahim@linux.intel.com>, Looi,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 KhaiWenTan <khai.wen.tan@linux.intel.com>
Date: Wed, 22 Apr 2026 23:56:59 +0800
Message-ID: <20260422155701.7420-2-khai.wen.tan@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422155701.7420-1-khai.wen.tan@linux.intel.com>
References: <20260422155701.7420-1-khai.wen.tan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776874815; x=1808410815;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EfOOrxhNAc002gBQ2b94VR1M0iDD4MM8+CD2KGS9Miw=;
 b=B7V3RDjRKV2edYDTsf6XW0f0Sptd7jKvr3xzcEsCFFZ1PWT6/1OnJdL6
 T+P4uh0QfsVFLL07CTCUvkRlujAGsD/1SNpvC3Y9JJI+X6oMtj0tX+C8v
 lqrQShjUD01Ub/WEmS9tCfLJyrq0f6p5TZ1Ex0f3hi/58AcmqDdXNJk7Q
 wj3N5iXiLKDpIyGMCdZgmIabh+Hi0Lvi5KjlW4FqhKCiPRCYUIv1XQID2
 W24425Qm2g+R3tELV6W+C4rI59yraN9enLu6RJF1LJCV44uz8W1ZJyzws
 PJ/uwoeiexul+qq5WqdBFZDAbPBZQYDH4cH0lJRrlBbvaAZVueADotXh+
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=B7V3RDjR
Subject: [Intel-wired-lan] [PATCH iwl-next v3 1/3] igc: remove unused
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
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
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

