Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F6610BA431
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Mar 2026 07:30:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05509827B1;
	Fri, 27 Mar 2026 07:30:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fYPJK-U_JSx4; Fri, 27 Mar 2026 07:30:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EC74B82768
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774596651;
	bh=Wmgpj8r8xR89YCT8vlwL0zO6nMemSkqfLvBIkg9km6c=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=w7R2ScjFP7brvJMQJOhBXo787SYCuIJvGmNOHzrF5+aejQ8nwHgp8WUfuUA4PeS68
	 WnASf2oEStsRrZzO/m3LkMA+p6C770mjNY2xstqUldRUbH137AAayH4hIb/psDenax
	 iXyYbKaDbUM7OG41KrfgWuRfv2JjsMWsSfLM8jpNRbOahqR7npA+tDy/qOR5T9Dl1f
	 die+sbgcp6s0whfShNHIAWXkpJIkKDDLbg6Ubxf52YX/3EzEOZnFcUqx7cx6yy0EKC
	 9qDCHceqqG2GUSckiVwIDNl5uCNy8qYtwV8CJ7stusmP0ToqkIWfqxh8oBY26a4mLX
	 fMVNI/mYbbmCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC74B82768;
	Fri, 27 Mar 2026 07:30:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 91674249
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:30:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8F758415BB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:30:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gMdLxJfOLwGk for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Mar 2026 07:30:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org EFA5F41598
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EFA5F41598
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EFA5F41598
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:30:48 +0000 (UTC)
X-CSE-ConnectionGUID: QQh3Wt/7Ty+vY0DxjDss1Q==
X-CSE-MsgGUID: 6l2IqkM1S9qfe46K2YBO1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75734288"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="75734288"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 00:30:48 -0700
X-CSE-ConnectionGUID: fqc43ug9TaevUIPZzxbrag==
X-CSE-MsgGUID: y5p4STNPQKqDAxKNgsIYeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="255740352"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa002.jf.intel.com with ESMTP; 27 Mar 2026 00:30:47 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Date: Fri, 27 Mar 2026 08:30:35 +0100
Message-ID: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774596649; x=1806132649;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ki0l4dqtFjyaxid0mH51xS6ucoI4QPhIHBRummsYWnc=;
 b=Ts6nx9xeRmXRsTArgX7tfLlcliT9kEYrnmNGrpbBO/4naEMw70Mlvymy
 uhFgdLxCPHgKLj10NFFW8EaV3Ji27cl7uv9/fRmQs6GryHxkntzW7rTgC
 0fmiZ+sDUfhXSszOXZDvrfE2HRzHzX028OIiTXfoLUOIlztWHAEt7W8KE
 ZTJoVI5DOq+f/T8dkp1k8bREvNHdC7jQCChLGwx+lN2TrZLpXvSMb+qrk
 swJFaMSehHgw+J1l1+7JwDmwgWTX0ElFPmAkQ/H+tNhq6v+N3ErhyvRAv
 tPD95QTcx5omknLmcAsOgqU/2gEdjPv5XDhwDvzo6vuvh5FJqlZps/xMi
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Ts6nx9xe
Subject: [Intel-wired-lan] [PATCH iwl-next] ixgbe: increase SWFW semaphore
 timeout for X550 FW updates
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

From: Soumen Karmakar <soumen.karmakar@intel.com>

According to FW documentation, the most time-consuming part of continuous
FW activity is Shadow RAM (SR) dump which takes up to 3.2 seconds.  For
X550 devices, the module-update FW command can take over 4.5 s.  Increase
the max Software/Firmware (SW/FW) semaphore wait time from the default
200 ms to 5 s for X550 to avoid spurious semaphore timeout failures
during FW update operations.

Signed-off-by: Soumen Karmakar <soumen.karmakar@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
index e67e2fe..85047ef 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
@@ -577,6 +577,9 @@ int ixgbe_acquire_swfw_sync_X540(struct ixgbe_hw *hw, u32 mask)
 
 	swmask |= swi2c_mask;
 	fwmask |= swi2c_mask << 2;
+	if (hw->mac.type == ixgbe_mac_X550)
+		timeout = 1000;
+
 	for (i = 0; i < timeout; i++) {
 		/* SW NVM semaphore bit is used for access to all
 		 * SW_FW_SYNC bits (not just NVM)
-- 
2.52.0

