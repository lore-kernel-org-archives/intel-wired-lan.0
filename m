Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28BEC61DC2
	for <intel-wired-lan@archiver.kernel.org>; Wed, 26 Aug 2026 09:48:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A53B4802AE;
	Wed, 26 Aug 2026 09:48:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wTWCJvCQBOlC; Wed, 26 Aug 2026 09:48:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787737735;
	bh=OMybOzOLGh/VfoufWjUW6TuJUrtPEMS8IX34AZuw2zU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ThdC0377hSLv5q8ymQXSwADrt/4Ew9AhTXrCKQjS65eCd9r655IIbvnBOmeMfa88j
	 qmNyhDxGOHId8OadEv539jYPp1wEoRkPvJjFsA3/4sNWDUXmfwWBk9eD3cLIvsmknR
	 0BRtmbYuNmFCX4tXuuc6DOgXrs9Jbr+rsjcQ3Mgs0+lwfs5kJbLYgjtYL/ytTzh0s5
	 3Nla9ePx34NTSIpxf2WIMLP9LXP02L1oxBDFqIjPhb2Q7bBOxW+zxul6WURNLd4CDU
	 uSSI6WCLlB99pMBESO1iCkmbFZKeHz4XIkJk23YlIOvAKPSDTTucsmxVOKP6EAyDgv
	 IU36le86mexPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17F04807AA;
	Wed, 26 Aug 2026 09:48:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B3363C3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 09:48:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EF1A240568
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 09:48:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DWZsTeJB_jGs for <intel-wired-lan@lists.osuosl.org>;
 Wed, 26 Aug 2026 09:48:53 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=d78T9tqi
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 40B0240562
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 09:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787737733; x=1819273733;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uS1Gk3FU8H9sDA2GM9EWDtq+Xlygp4KxaypBMwUQwy0=;
 b=d78T9tqiTDLFSjY4+oTVdtqbbmklZ3wB51APS1Po9RXeZiFQ0Qa4MyoS
 EwgJElufGChSS8NsuEurzXxpfHgo5+i/O9os4oZ1A8LBfULDUGogT+eOv
 d2mnUPyATCRG/g9pVvH2M+Lgip/qjtV87eiolrWo8s2chx8FbgHBaYjUr
 Ey3PnEK8GaZOEgq5LoIzPSf30PE5BVnuOwl8GXM9YJbdS9OgLg3fPVtiO
 gds5mi+yS3nKrtIB8Z2+SYXc5EPniUIkw/LvXkqa6KYIE36g+Rz8AL9ih
 5WROL2T3gkyqridaOC1jtiGhU9r4XG5aWFrSveWYbcBp2xpbqPq7j+H1N A==;
X-CSE-ConnectionGUID: Kt7y22DwRiKyS6DPWbcpxw==
X-CSE-MsgGUID: eHwmCeGuR+iifbx6/EYZ8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88232949"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="88232949"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2026 02:48:52 -0700
X-CSE-ConnectionGUID: 7B5au/OrT/C5AMFFQDelvg==
X-CSE-MsgGUID: /7CKX7J9SfO7GxMAVXRARA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="261404797"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by fmviesa009.fm.intel.com with ESMTP; 26 Aug 2026 02:48:51 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v4 1/6] ice: dpll: Add the MUX tables to the
 documentation
Date: Wed, 26 Aug 2026 09:48:44 +0000
Message-ID: <20260826094849.4112016-2-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826094849.4112016-1-sergey.temerkhanov@intel.com>
References: <20260826094849.4112016-1-sergey.temerkhanov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add the tables documenting the DPLL pin MUX states and behavior
to the driver.

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 382fbe98f2b0..9b3584fa43a9 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -92,6 +92,29 @@ static const struct dpll_pin_frequency ice_esync_range[] = {
 	DPLL_PIN_FREQUENCY_RANGE(0, DPLL_PIN_FREQUENCY_1_HZ),
 };
 
+/*
+ * SMA1/U.FL1 MUX table
+ *+----------------+-------------+------------+
+ *|                | SMA1_DIR_EN | SMA1_TX_EN |
+ *+----------------+-------------+------------+
+ *|SMA1 RX Enable  |       0     |      x     |
+ *|u.FL1 TX Enable |       0     |      0     |
+ *|SMA1 TX Enable  |       1     |      0     |
+ *|All Disable     |       1     |      1     |
+ *+----------------+-------------+------------+
+ *
+ * SMA2/U.FL2 MUX table
+ *+----------------+-------------+------------+------------+
+ *|                | SMA2_DIR_EN | SMA2_TX_EN | UFL2_RX_EN |
+ *+----------------+-------------+------------+------------+
+ *|SMA2 RX Enable  |       0     |      x     |     x      |
+ *|u.FL2 RX Enable |       1     |      x     |     0      |
+ *|SMA2 TX Enable  |       1     |      0     |     x      |
+ *|SMA2 Disable    |       1     |      1     |     x      |
+ *|All Disable     |       1     |      1     |     1      |
+ *+----------------+-------------+------------+------------+
+ */
+
 /**
  * ice_dpll_is_sw_pin - check if given pin shall be controlled by SW
  * @pf: private board structure
-- 
2.53.0

