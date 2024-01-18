Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B91C4707B
	for <intel-wired-lan@archiver.kernel.org>; Thu, 18 Jan 2024 13:53:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5ABFA60BA0;
	Thu, 18 Jan 2024 13:53:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5ABFA60BA0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1705586025;
	bh=xBovxmXJs6qE5NoMinNfYJh2juRBNBcaIPfPAp3z0zw=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=R05qIWKBDwNfYrJeNu5CtwMIGTquYibxfGIhqcanMhZs/UsatE99IEaJ98zdhoMWz
	 QvxZzf84xZJLP5h3E/BcZYiOayqdMIrJRAz611ZU9324FWyrOtqTaoNEbRgyb9pfsd
	 zMEbujDHiZls+bIS10lQryf3HrGWeUIbrBtgZjchkxBtBXQ09yY4PErSaLMdrDh5Z8
	 Se4juzZptTaOFRDJh/1MKa2xOknUivuyJ+j1Mbs0UhqNg6SimvepMDGPf6HZI7SaNR
	 Vjcg9EjeUgF03FoI6Fz3/QtfqmGg0D4Sn9x51Zwx7dErE8PvL463eUuFlYcX6ClYh+
	 cA9mvlA+jYzpA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qyMaBsB2ID-B; Thu, 18 Jan 2024 13:53:44 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 61C906F541;
	Thu, 18 Jan 2024 13:53:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 61C906F541
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 126471BF429
 for <intel-wired-lan@lists.osuosl.org>; Thu, 18 Jan 2024 13:53:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EBBCF6F539
 for <intel-wired-lan@lists.osuosl.org>; Thu, 18 Jan 2024 13:53:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EBBCF6F539
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T8QNPVnZ9GIH for <intel-wired-lan@lists.osuosl.org>;
 Thu, 18 Jan 2024 13:53:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0B4B66F531
 for <intel-wired-lan@lists.osuosl.org>; Thu, 18 Jan 2024 13:53:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0B4B66F531
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="431606969"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; d="scan'208";a="431606969"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2024 05:53:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="784802303"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; d="scan'208";a="784802303"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
 by orsmga002.jf.intel.com with ESMTP; 18 Jan 2024 05:53:39 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Thu, 18 Jan 2024 14:43:31 +0100
Message-Id: <20240118134332.470907-2-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240118134332.470907-1-jedrzej.jagielski@intel.com>
References: <20240118134332.470907-1-jedrzej.jagielski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705586022; x=1737122022;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Uq6X1ljwAynQGrEWAvH3NSQV1vY1NlFyZK4w5KxomRs=;
 b=ZH88iaxD7JomU7EFowcVQBQfD9QF7TCF18r9CiTTHGX5PSLnFCadOsBm
 ZzX3mHBklMMNcGEMmdsT4nT1ZlbWFqI6AcwIVMmPdh/enDi//iNzQV6FR
 V68G4NyFbHwTDKRUqWAucVl+UKBZsYsa7g3WTGD77qqUMMMeUNj3C78oy
 a96XC0B/yTTbeXBENM7Sk3nWz0URxIQwXTrIJ/nVULagikvWmaz/f0lfl
 6J5etf68LErqfiBH8mif/aQWR5mgT8zj/o/zTqrRafe1yJYMcQIkldy3r
 SwU1E/y1zmras3EeQbdoi+QAlaId6EodO4iXhjwnu5LsgpBNvkueYJbzS
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ZH88iaxD
Subject: [Intel-wired-lan] [PATCH iwl-next v3 2/3] ixgbe: Fix smatch
 warnings after type convertion
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Converting s32 functions to regular int in the patch 8035560dbfaf caused
trigerring smatch warnings about missing error code. The bug predates
the mentioned patch.

New smatch warnings:
drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:2884 ixgbe_get_lcd_t_x550em() warn: missing error code? 'status'
drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:3130 ixgbe_enter_lplu_t_x550em() warn: missing error code? 'status'

Old smatch warnings:
drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:2890 ixgbe_get_lcd_t_x550em() warn: missing error code? 'status'

Fix it by clearly stating returning error code as 0.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202401041701.6QKTsZmx-lkp@intel.com/
Fixes: 6ac743945960 ("ixgbe: Add support for entering low power link up state")
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 70a58bf3d563..56bc1ba184b5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -2883,17 +2883,17 @@ static int ixgbe_get_lcd_t_x550em(struct ixgbe_hw *hw,
 	/* If link partner advertised 1G, return 1G */
 	if (an_lp_status & IXGBE_AUTO_NEG_LP_1000BASE_CAP) {
 		*lcd_speed = IXGBE_LINK_SPEED_1GB_FULL;
-		return status;
+		return 0;
 	}
 
 	/* If 10G disabled for LPLU via NVM D10GMP, then return no valid LCD */
 	if ((hw->bus.lan_id && (word & NVM_INIT_CTRL_3_D10GMP_PORT1)) ||
 	    (word & NVM_INIT_CTRL_3_D10GMP_PORT0))
-		return status;
+		return 0;
 
 	/* Link partner not capable of lower speeds, return 10G */
 	*lcd_speed = IXGBE_LINK_SPEED_10GB_FULL;
-	return status;
+	return 0;
 }
 
 /**
@@ -3129,7 +3129,7 @@ static int ixgbe_enter_lplu_t_x550em(struct ixgbe_hw *hw)
 	     (lcd_speed == IXGBE_LINK_SPEED_1GB_FULL)) ||
 	    ((speed == IXGBE_MDIO_AUTO_NEG_VENDOR_STATUS_10GB) &&
 	     (lcd_speed == IXGBE_LINK_SPEED_10GB_FULL)))
-		return status;
+		return 0;
 
 	/* Clear AN completed indication */
 	status = hw->phy.ops.read_reg(hw, IXGBE_MDIO_AUTO_NEG_VENDOR_TX_ALARM,
-- 
2.31.1

