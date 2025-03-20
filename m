Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79D8C35FFF
	for <intel-wired-lan@archiver.kernel.org>; Thu, 20 Mar 2025 13:19:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 582A783EC4;
	Thu, 20 Mar 2025 13:19:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VtKH3swV5ybr; Thu, 20 Mar 2025 13:19:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9C3FA83EC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1742476776;
	bh=NgYUnpAjU/PhVyFap7/2VI/YdDRNkl8boaA/tjkNA9Y=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=8ox4oJWeLgNKR8S/w/rlfhA+rIZlzWCKRr/QTkPZJCSumL9LM/hsFmdjxg+u1flrT
	 5uoCZVEWErn54+Mxbi5eFr0+3XGP/Kon2aRM5H761wUuePL0rK8I2Aoz2XmVOWFWee
	 PimcyOu8LaXU3ky40r8JxlHNrWkUBx7Z2xVXdo0aBT1L7KE4G1PIBAUva1lvC8yjvl
	 9QPKRuHmxOvePXhzZXJZU4OvM9wM9QxA472lipZ52OYAcO9GNfRxJxhmBJV4TYmBLJ
	 Vp4NeR56sXN+3jIRa8F1KaMxSk9IVpG2I/UBXEXQgdkl1HcjfNQrUbWHXOSGFUGdbN
	 PxRwwLKt+7SXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C3FA83EC9;
	Thu, 20 Mar 2025 13:19:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E0A012F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Mar 2025 13:19:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 799AC60757
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Mar 2025 13:19:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PHGOc7qu_b_2 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 20 Mar 2025 13:19:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B9629605D8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B9629605D8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B9629605D8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Mar 2025 13:19:34 +0000 (UTC)
X-CSE-ConnectionGUID: s3a78yIoTs22oKI/wwvyfQ==
X-CSE-MsgGUID: ADUbq9w8TxqRUKoQmXs8qQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="55083741"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; d="scan'208";a="55083741"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2025 06:19:35 -0700
X-CSE-ConnectionGUID: SOq9uumESCW21bdsvJBPRA==
X-CSE-MsgGUID: 8x1O74Y0RJ6vUI0hkLXJRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; d="scan'208";a="160311385"
Received: from gklab-003-001.igk.intel.com ([10.211.3.1])
 by orviesa001.jf.intel.com with ESMTP; 20 Mar 2025 06:19:32 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Thu, 20 Mar 2025 14:15:36 +0100
Message-Id: <20250320131538.712326-2-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250320131538.712326-1-grzegorz.nitka@intel.com>
References: <20250320131538.712326-1-grzegorz.nitka@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742476775; x=1774012775;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+rKFdjeP+Hy9a/CmOyXaoOJBvGS+eLADxwEBQxqhnI8=;
 b=cjF+BOYtJalSflLZE2WQMscSHS28r2Sno5M8mmOAvwZPltMU5zfwN/12
 Z0xYvdEBRiuu5NqBQd5lMFe8bdvmXMz/9uaW0PFImq7ier51z0mklCpDH
 iC8UZAqmzXzZUDdXcKTS8JDDzeuQGaZQ9DzAwOdEIlDP+OFSVsodHlDur
 ZmV/WNbI14tWF5vXzaILIEgAH1ckRq5k6I1RcVeQ+WOKQV5+fO3zQyEpv
 iU2v8QeI5t1NrUn8QIKOGCdn4NLy9erb9ENIN/dTeOVrdCQOw++SxtH5q
 BvFIhDbayi1zl6/DvQE2jO3+v5XwNtaDPn4SnAyVzbCra6Ysu03Kx8E72
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=cjF+BOYt
Subject: [Intel-wired-lan] [PATCH iwl-next v3 1/3] ice: remove SW side band
 access workaround for E825
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
Cc: netdev@vger.kernel.org, Karol Kolacinski <karol.kolacinski@intel.com>,
 horms@kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Karol Kolacinski <karol.kolacinski@intel.com>

Due to the bug in FW/NVM autoload mechanism (wrong default
SB_REM_DEV_CTL register settings), the access to peer PHY and CGU
clients was disabled by default.

As the workaround solution, the register value was overwritten by the
driver at the probe or reset handling.
Remove workaround as it's not needed anymore. The fix in autoload
procedure has been provided with NVM 3.80 version.

NOTE: at the time the fix was provided in NVM, the E825C product was
not officially available on the market, so it's not expected this change
will cause regression when running with older driver/kernel versions.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 23 ---------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 89bb8461284a..a5df081ffc19 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2630,25 +2630,6 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 	return 0;
 }
 
-/**
- * ice_sb_access_ena_eth56g - Enable SB devices (PHY and others) access
- * @hw: pointer to HW struct
- * @enable: Enable or disable access
- *
- * Enable sideband devices (PHY and others) access.
- */
-static void ice_sb_access_ena_eth56g(struct ice_hw *hw, bool enable)
-{
-	u32 val = rd32(hw, PF_SB_REM_DEV_CTL);
-
-	if (enable)
-		val |= BIT(eth56g_phy_0) | BIT(cgu) | BIT(eth56g_phy_1);
-	else
-		val &= ~(BIT(eth56g_phy_0) | BIT(cgu) | BIT(eth56g_phy_1));
-
-	wr32(hw, PF_SB_REM_DEV_CTL, val);
-}
-
 /**
  * ice_ptp_init_phc_e825 - Perform E825 specific PHC initialization
  * @hw: pointer to HW struct
@@ -2659,8 +2640,6 @@ static void ice_sb_access_ena_eth56g(struct ice_hw *hw, bool enable)
  */
 static int ice_ptp_init_phc_e825(struct ice_hw *hw)
 {
-	ice_sb_access_ena_eth56g(hw, true);
-
 	/* Initialize the Clock Generation Unit */
 	return ice_init_cgu_e82x(hw);
 }
@@ -2747,8 +2726,6 @@ static void ice_ptp_init_phy_e825(struct ice_hw *hw)
 	params->num_phys = 2;
 	ptp->ports_per_phy = 4;
 	ptp->num_lports = params->num_phys * ptp->ports_per_phy;
-
-	ice_sb_access_ena_eth56g(hw, true);
 }
 
 /* E822 family functions
-- 
2.39.3

