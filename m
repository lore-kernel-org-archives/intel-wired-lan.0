Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8D4FF885A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 28 Apr 2026 06:23:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B42E940A4A;
	Tue, 28 Apr 2026 06:23:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ac42CP0hTFcS; Tue, 28 Apr 2026 06:23:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 282E340A4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777357393;
	bh=EVoEvpinx7UrEYecHHIFKB8fKx60mrGwXkn35wH4hQA=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UqJtamT67TnNMd9Y6CECRUcujOwo3fSK+8DCIfSwkBGMbIwAo5EU0zxabXB7q3omr
	 s/Q5imCQGfybVxbHm6XF6a9pgcdVLQd0L8ugx0HV4XGygB0z9Ny5kRViTp7oDOtVPC
	 pNwEou0J54lBwqlWrDzD3BPjjntOIjYYZC9yARqE0tFNTm/p2gd9jjHH/e9iC8kzmL
	 x2Xn3U6ZUG2LCkGo+EhRsplJeIPRmmaxNsgFBMKlMlhAKfw4dlYMCWzNXAn/XgkYbW
	 jmndFlLCmpzybiMov8pe8I17kW9uADf7zq1dEjQUP5eNDNXwxMcXVDvwYlltT1lHo6
	 ilC1wL/fgh+7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 282E340A4C;
	Tue, 28 Apr 2026 06:23:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9085923D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 06:23:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7AEFE40A4E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 06:23:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2aT8Jl_nMYbr for <intel-wired-lan@lists.osuosl.org>;
 Tue, 28 Apr 2026 06:23:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=khai.wen.tan@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D62B540A4C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D62B540A4C
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D62B540A4C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 06:23:10 +0000 (UTC)
X-CSE-ConnectionGUID: RL3xWcNCQmOqCufE3JW9MA==
X-CSE-MsgGUID: IQVTZy0IST+vm7CFeGDp/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78366119"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="78366119"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2026 23:23:10 -0700
X-CSE-ConnectionGUID: 7PGtAfTESOi1tVLNFHwETg==
X-CSE-MsgGUID: lErCAqfdR8CQT9jWMbfbMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="232986893"
Received: from unknown (HELO localhost.png.intel.com) ([10.107.255.61])
 by orviesa010.jf.intel.com with ESMTP; 27 Apr 2026 23:23:07 -0700
From: KhaiWenTan <khai.wen.tan@linux.intel.com>
To: anthony.l.nguyen@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, faizal.abdul.rahim@intel.com,
 hong.aun.looi@intel.com, khai.wen.tan@intel.com,
 Faizal Rahim <faizal.abdul.rahim@linux.intel.com>, Looi,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 KhaiWenTan <khai.wen.tan@linux.intel.com>
Date: Tue, 28 Apr 2026 14:00:07 +0800
Message-ID: <20260428060009.311393-2-khai.wen.tan@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428060009.311393-1-khai.wen.tan@linux.intel.com>
References: <20260428060009.311393-1-khai.wen.tan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777357391; x=1808893391;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EfOOrxhNAc002gBQ2b94VR1M0iDD4MM8+CD2KGS9Miw=;
 b=TAVK2NVN2dBE3tr/RYhSbhgQ6kWUt+IHKNGcDYeziW7YcPsxOoR3BhU4
 CVG6EuCRw8FNkswRxR1xeHEqpU7SheWqWjgN9hXVAnMNc4gc/wYshwjUD
 XE/r0ZKTchh5ytnCpYmF8a32g9UMNw7XrwdcG+wIHGOIBZ7jc8Sot9cKl
 RTS5ajTPnvq0nuuDWlV9ygpNTZZfzgspnyvlhYgaBCBCnhjr5BGl8Cbj1
 p9iYSI3ymRAX20324HKVIqCLcEQb7ejfwTeebq/QbSblPplkUiyyQdTbR
 Nh7secQJLLPOETOPXpp0vCCp7APELkikBFtxAdAqSCr8JUe0tZ0j0JjE1
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=TAVK2NVN
Subject: [Intel-wired-lan] [PATCH iwl-next v4 1/3] igc: remove unused
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

