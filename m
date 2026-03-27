Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E287A10BA437
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Mar 2026 07:30:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B558C83C29;
	Fri, 27 Mar 2026 07:30:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jo0ZYOvduATJ; Fri, 27 Mar 2026 07:30:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 35D3582768
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774596658;
	bh=CHDEV9SJVAr/scFmg/+f7kg8oyI0u2IH8Rh7If+V4QQ=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ASAivqtO8225dAdBgwTuGWbAOmkp0OQzTdul20bnMTQUzeaCRsfQUjb4dsfsOfONc
	 Gd3+Y2QAv5p7ICXx52iBFII7JqFOXetet1Rf5e7x+CxzDtEcPoV6gHiyoac8UpZ7qN
	 zonf2wrv0Ph3twRgeLI2QVvKpxueWxvvLLF0SHt1jnQLhz/TJq8G6O6LaiOenLGBYO
	 VCkAYBJ/yo6fNrotsQ2US8daSlXzNty/k8F379VjygW7JRjcbtG/J7PhiOoOJmKy17
	 61RIpq+X/6OmGk0S3UJScKClHv7wc++LdDQRE/M/assh8zAD+IbWD9NnZ70tInyb/Z
	 WslYIahnmqbCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 35D3582768;
	Fri, 27 Mar 2026 07:30:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B85D249
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:30:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5DDCE415BB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:30:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iqDUJHB-U70r for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Mar 2026 07:30:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5AC4141598
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5AC4141598
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5AC4141598
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:30:56 +0000 (UTC)
X-CSE-ConnectionGUID: Kas4GE1gTvuO2d4NvGz0Pg==
X-CSE-MsgGUID: ISSX0OCsQPi18N4W2C0z9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75734320"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="75734320"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 00:30:56 -0700
X-CSE-ConnectionGUID: NfVt3QrVR9SQ3aRWJamXHQ==
X-CSE-MsgGUID: IDICe1k5S/m3D9QIyM3DWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="255740381"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa002.jf.intel.com with ESMTP; 27 Mar 2026 00:30:55 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Date: Fri, 27 Mar 2026 08:30:40 +0100
Message-ID: <20260327073046.134085-6-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774596656; x=1806132656;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Hilwd6wmLhVdcH05Km0NTcg0JGgAPDArrIlWyELkXNU=;
 b=H6I9hmHguorRX4yXqNHLEks3FQWTAh55ZxoUKf1tdOo3QOOFe4e4gQMs
 2XpmkeLqLzTUA1bkwgx5hPL5kVjLKZlscMFTI/Qb0LY832oshRtV2N8Sf
 xqM7qSDd9BJ5ySjTTz/vnxPTWcFQiyPnHltvEGV8C+X1nYW4qkQSc4VJ6
 662LdbRZBxG5ZxVYBQDuJnaDW2IlnIz/t6dt7NScK0RqSTjRBd4j09a3p
 wj4J4zf+Y2LesQLxiffWHygci8e9E5BMqgXkA25lQldshpdocEPZEwlRp
 0h2bYzp9yBfqClCOfeiXCno0+XWB02FywGFQuEVKIYWZfg4Hac0Wd6nQx
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=H6I9hmHg
Subject: [Intel-wired-lan] [PATCH iwl-next] ixgbe: call ixgbe_setup_fc()
 before fc_enable() after NVM update
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

From: Radoslaw Tyl <radoslawx.tyl@intel.com>

During an NVM update the PHY reset clears the Technology Ability Field
(IEEE 802.3 clause 37 register 7.10) back to hardware defaults.  When
the driver subsequently calls only hw->mac.ops.fc_enable() the SRRCTL
register is recalculated from the stale autonegotiated capability bits,
which the MDD (Malicious Driver Detect) logic treats as an invalid
change and halts traffic on the PF.

Fix by calling ixgbe_setup_fc() immediately before fc_enable() in
ixgbe_watchdog_update_link() so that flow-control autoneg and the
PHY registers are re-programmed in the correct order after any reset.

Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 52f0cdc..db954e9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8041,6 +8041,12 @@ static void ixgbe_watchdog_update_link(struct ixgbe_adapter *adapter)
 		pfc_en |= !!(adapter->ixgbe_ieee_pfc->pfc_en);
 
 	if (link_up && !((adapter->flags & IXGBE_FLAG_DCB_ENABLED) && pfc_en)) {
+		if (hw->mac.ops.setup_fc) {
+			int err = hw->mac.ops.setup_fc(hw);
+
+			if (err)
+				e_warn(drv, "setup_fc failed: %d\n", err);
+		}
 		hw->mac.ops.fc_enable(hw);
 		ixgbe_set_rx_drop_en(adapter);
 	}
-- 
2.52.0

