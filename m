Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC47BC001B0
	for <intel-wired-lan@archiver.kernel.org>; Mon, 24 Jul 2023 10:20:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6365C60F37;
	Mon, 24 Jul 2023 10:20:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6365C60F37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1690194038;
	bh=9MeRSUXKMbxIWa7v0FJb+jCVTUxgYlCXXM0Nl0JERg0=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=DWkt46K5rKQeMGgvZG9auaDB+f/Nc7JR7sk39h0sTykXuhDFksBvG1fV6UgWi/d/i
	 M3IBmSyPWhNMorgWndTIohn6hLPX3kSHS5kjbi8vrchBHF5o/33tl6NF12oOc0VTVB
	 udG1oiWalHKL3EwrSejavLAN3cZglkSJViN+6+z4Fotxi/NhiREb7tG+k28dQ90p94
	 LBhQ7RyU01sS2dUU0JVFPARoTHmkWcBSoIQasaZhIAVFiysgeO5oOtr2iBnarTTl6m
	 H5Z1yNTs/ixkSOHy2iphj3NUDYEmZ85omGTkStaBuOL2yUw510u9UfEH6mrH17HPfr
	 Ukr9Q+OIjIgAQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AScZsM_nnpue; Mon, 24 Jul 2023 10:20:37 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34F6460F47;
	Mon, 24 Jul 2023 10:20:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 34F6460F47
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 50CC01BF45A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Jul 2023 10:20:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 297934149F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Jul 2023 10:20:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 297934149F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ySbLc5Wv9uHk for <intel-wired-lan@lists.osuosl.org>;
 Mon, 24 Jul 2023 10:20:32 +0000 (UTC)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 59B184146F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Jul 2023 10:20:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 59B184146F
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="367428275"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; d="scan'208";a="367428275"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2023 03:13:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="972206824"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; d="scan'208";a="972206824"
Received: from gk3153-or4-r750-36948.igk.intel.com ([10.102.19.252])
 by fmsmga006.fm.intel.com with ESMTP; 24 Jul 2023 03:13:26 -0700
From: Olga Zaborska <olga.zaborska@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Mon, 24 Jul 2023 12:06:23 +0200
Message-Id: <20230724100623.79886-4-olga.zaborska@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230724100623.79886-1-olga.zaborska@intel.com>
References: <20230724100623.79886-1-olga.zaborska@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690194032; x=1721730032;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HcL4zzHfwj1iR3tkq+w2VB/AIvJRwaRSbieolod+7eQ=;
 b=LudPb0T0ZL84iDcqpGgU7EdJbXnUd/0N83VTG0WTWDf+Wr4nHsw60SU9
 ZJfkJFGIzcei372U2lkCSDijlS0SdOYySTlP0VivXrMLrtYrqQPxKwzpf
 cFz0HqLDLGUMkTBrpK2CmzbGxN1niv9HCderVhf6+jSzUzHEJN2ts6yvR
 pjE2bloCT+1nirHRnLtzTbdlPyQbSYKX+JgyCjqcB27s4c2EF/qY2KyRZ
 ZBmSgljnvmiKTr+8qsIuTl+zSegADmdg5cT084e2wPbj2hVWSHdk3ola1
 dN8aPb2vImL9i2LdsWPaFk+ixCrb1H6k0kwPNaDOG4BZyVVYnCtNbgcvr
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=LudPb0T0
Subject: [Intel-wired-lan] [PATCH iwl-net v4 3/3] igb: Change IGB_MIN to
 allow set rx/tx value between 64 and 80 Change the minimum value of RX/TX
 descriptors to 64 to enable setting the rx/tx value between 64 and 80. All
 igb devices can use as low as 64 descriptors. This change will unify igb
 with other drivers. Based on commit 7b1be1987c1e ("e1000e: lower ring
 minimum size to 64")
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
Cc: Olga Zaborska <olga.zaborska@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Fixes: 9d5c824399de ("igb: PCI-Express 82575 Gigabit Ethernet driver")
Signed-off-by: Olga Zaborska <olga.zaborska@intel.com>
---
v1->v2 fixed commit title and message
v2->v3 fixed commit title and message, added changes for igb and igc
v3->v4 fixed commit message
---
 drivers/net/ethernet/intel/igb/igb.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 015b78144114..a2b759531cb7 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -34,11 +34,11 @@ struct igb_adapter;
 /* TX/RX descriptor defines */
 #define IGB_DEFAULT_TXD		256
 #define IGB_DEFAULT_TX_WORK	128
-#define IGB_MIN_TXD		80
+#define IGB_MIN_TXD		64
 #define IGB_MAX_TXD		4096
 
 #define IGB_DEFAULT_RXD		256
-#define IGB_MIN_RXD		80
+#define IGB_MIN_RXD		64
 #define IGB_MAX_RXD		4096
 
 #define IGB_DEFAULT_ITR		3 /* dynamic */
-- 
2.31.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
