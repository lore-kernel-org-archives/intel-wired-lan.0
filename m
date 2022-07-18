Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B11C433EF
	for <intel-wired-lan@archiver.kernel.org>; Mon, 18 Jul 2022 09:50:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A6CD60AE5;
	Mon, 18 Jul 2022 09:50:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5A6CD60AE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1658137824;
	bh=8xJyMQz5XKckI7ec+RKLrvIVURW34AagRpEgZKyeFWo=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=93aQGuwWDT6JiWA8ri4ffWla00SJGCln7KEIIvvcGEl46/88BxKklSCk1pgDBhhug
	 Td/D6gpWuAFVjSSoOEyTS9CmelvoJGvgmhmauHNMWk0SO4y9MOf5ox/bT8RZEUJyev
	 UH+V9nWfcCXnNZLVzOk62X8jiXNn3XTqs5aNDiTTy7xbEis93HlHZtdudtlU0+0KB7
	 7/JYBOuVPCTlE0GcRxUaXH3sET7TkqjD2cAlH8uof6VjHtTt9KbcClU3c7I3QIRr9p
	 O/S3EPcn/YcxJRF/PM2lmK+p3h5tDXPWkNo+L3R38u1nAjjV0x4sJUbSwNjMqogpmO
	 Rsvtl/kJZl3Og==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lGRwJZeB1ZxY; Mon, 18 Jul 2022 09:50:23 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64BD760FB9;
	Mon, 18 Jul 2022 09:50:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 64BD760FB9
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 175951BF47D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 18 Jul 2022 09:50:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F1EBF825E6
 for <intel-wired-lan@lists.osuosl.org>; Mon, 18 Jul 2022 09:50:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F1EBF825E6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mvOVu4t0pqJe for <intel-wired-lan@lists.osuosl.org>;
 Mon, 18 Jul 2022 09:50:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5F14183313
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5F14183313
 for <intel-wired-lan@lists.osuosl.org>; Mon, 18 Jul 2022 09:50:20 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="283747391"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; d="scan'208";a="283747391"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2022 02:50:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; d="scan'208";a="843216582"
Received: from ccdlinuxdev11.iil.intel.com ([143.185.162.183])
 by fmsmga006.fm.intel.com with ESMTP; 18 Jul 2022 02:50:19 -0700
From: Sasha Neftin <sasha.neftin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Mon, 18 Jul 2022 12:50:15 +0300
Message-Id: <20220718095015.3243215-1-sasha.neftin@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1658137820; x=1689673820;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6Qu4rS3S0BiLs+rkNVqsdYXwzuGZuJ6amXitJbsdyqE=;
 b=QsPSsNIyC+UTHksqOcegTo4BQtGZKYK72AhflMvxwhR70R6ISxY+DmwB
 uUG3R8eEISsPRorgpIsA/LCbYsd2ygvi+Nzc6ITavZWKxDYH2LKwYg85M
 L16nnZ6PgeFu1XWvW7bxWsa/T/9N6Jh4Balm6Kc52oecdhe89UQHdNpkJ
 Ooe2iqyfy4Llk4VQbebDlc/V0nmM6bsqHt0npoQEvknUSrz8WRot+vx4y
 i3ZfJWtTBYsBJA6lZ8R8N0+P9sj7m4m2bP4VVJpGes3g0Apy1Ty7zx+Mw
 QnV5ca2SsHXA3K7sCjQpOyNLwBNoeg5x8fW/pCY+zZmGUngSL2fEGrjnJ
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=QsPSsNIy
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove forced_speed_duplex
 value
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

u8 forced_speed_duplex from value from igc_mac_info struct is not used.
This patch comes to tidy up the driver code.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_hw.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
index 360644f33d5f..88680e3d613d 100644
--- a/drivers/net/ethernet/intel/igc/igc_hw.h
+++ b/drivers/net/ethernet/intel/igc/igc_hw.h
@@ -89,8 +89,6 @@ struct igc_mac_info {
 	u32 mta_shadow[MAX_MTA_REG];
 	u16 rar_entry_count;
 
-	u8 forced_speed_duplex;
-
 	bool asf_firmware_present;
 	bool arc_subsystem_valid;
 
-- 
2.25.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
