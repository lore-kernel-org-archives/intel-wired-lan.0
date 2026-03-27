Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B18310BA431
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Mar 2026 07:23:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9DC7383C6A;
	Fri, 27 Mar 2026 07:23:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2WD4iHjYzYxB; Fri, 27 Mar 2026 07:23:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D4A6183C3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774596227;
	bh=hfr/V0XeCghX3MYEj6NQq5W5AxnsTramHk9v4WbpJzY=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=urT1t829MaNNLqAKk45x+O2suWXioBNSWOGrPOhxdHRTtDTEtHxBQyZKUeCVuUwZ5
	 El0KJtvr1AOfRew48TS4a8UKnLH3XFBuqi3Kd3kls2/hCCH7qy+Ybz5E+0KJ5K5uyW
	 2K2itxPu/TayvQM6xSYH93bj799vIiH7T99sjcprp8tqlMqkvsdTgJ7wz5lvbMR/3h
	 fBaMBsmJvc2jkngvsvGJVBqiheaPPA0jQeo21fpKQ/nT604bmKZOrda6zWQ1SXuosO
	 cnek+cW1TAa34r7RHcinTxWPAxEAld+xhw3sKCPd0TGPUMLr+jWHeKrUBzKTgmkSfj
	 exfK0HCuVYgcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D4A6183C3B;
	Fri, 27 Mar 2026 07:23:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 259ED249
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:23:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1809C415FA
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:23:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MKfMlWrI868b for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Mar 2026 07:23:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2A66741574
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2A66741574
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2A66741574
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:23:45 +0000 (UTC)
X-CSE-ConnectionGUID: NY/j+PlJT/KjY5mxqEL8lA==
X-CSE-MsgGUID: nBDXwrIZT3e8Q+duaFa90Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75733978"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="75733978"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 00:23:45 -0700
X-CSE-ConnectionGUID: gtJv4Gg8SM+0/j4xItdRpg==
X-CSE-MsgGUID: cfCkn3ZyQHWEJAepH4flog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="255739111"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa002.jf.intel.com with ESMTP; 27 Mar 2026 00:23:43 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Date: Fri, 27 Mar 2026 08:23:30 +0100
Message-ID: <20260327072332.130320-7-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
References: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774596225; x=1806132225;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LBFE63JaCQqSofulUu3xv89vB3PFNkSXDiss19Iht1Q=;
 b=Oj7y0drJRI/wzHhphg9DRQUsn9Qepclcj4LjHlGh54EA/qiKBsBRu63i
 VkVIAyvL8iiq57qHeEWuE2ASzL1sWS4eUzU6talIUOQAgEslAcvJxWXAZ
 ki/DnrGN85fK5gnEdP1chgba3F7ZMSwkv8knfeO3wfe1VEK4i6VaYIr3R
 +D8u8zxukhcIAg7CJDp2vGhOe2Rt0tVfRnKQruENVNjuW5LZaXDj3IHrr
 5k0Yc0x5PeaIh82GPsBus+z0EY6DuoZ3BZp5LuZY00326EsjU4sd13rgn
 RR8S/H39F+NwtnnNzZaC2u3utqD7cvfmWeN8Ym9aYJcYjZWP8i7b2+P1o
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Oj7y0drJ
Subject: [Intel-wired-lan] [PATCH net] ice: fix netdev bring-up and
 bring-down in self-test
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
Cc: netdev@vger.kernel.org, Konstantin Ilichev <konstantin.ilichev@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Konstantin Ilichev <konstantin.ilichev@intel.com>

When an offline self-test is initiated with ethtool -t, any ongoing
traffic could get stuck because ice_stop() and ice_open() are called
without letting the OS know about state transitions.  In most cases
a write() system call would block.

Fix this by calling dev_change_flags() to bring the netdev up and
down, which ensures ndo_open()/ndo_stop() are called and all watchers
are notified correctly.

Fixes: 0e674aeb0b77 ("ice: Add handler for ethtool selftest")
Cc: stable@vger.kernel.org
Co-developed-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Signed-off-by: Konstantin Ilichev <konstantin.ilichev@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---

 drivers/net/ethernet/intel/ice/ice_ethtool.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 96d95af..2a4f06f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1416,7 +1416,7 @@ ice_self_test(struct net_device *netdev, struct ethtool_test *eth_test,
 		/* If the device is online then take it offline */
 		if (if_running)
 			/* indicate we're in test mode */
-			ice_stop(netdev);
+			dev_change_flags(netdev, netdev->flags & ~IFF_UP, NULL);
 
 		data[ICE_ETH_TEST_LINK] = ice_link_test(netdev);
 		data[ICE_ETH_TEST_EEPROM] = ice_eeprom_test(netdev);
@@ -1434,10 +1434,12 @@ ice_self_test(struct net_device *netdev, struct ethtool_test *eth_test,
 		clear_bit(ICE_TESTING, pf->state);
 
 		if (if_running) {
-			int status = ice_open(netdev);
+			int status = dev_change_flags(netdev,
+						      netdev->flags | IFF_UP,
+						      NULL);
 
 			if (status) {
-				dev_err(dev, "Could not open device %s, err %d\n",
+				dev_err(dev, "Could not bring up device %s, err %d\n",
 					pf->int_name, status);
 			}
 		}
-- 
2.52.0

