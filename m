Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E71606A32E
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 18:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=i55cbMij;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jAZKmpE5
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E77A760600;
	Mon, 23 Nov 2026 18:40:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vhz2q6kx8SwM; Mon, 23 Nov 2026 18:40:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3415060640
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795459216;
	b=pk8sPYVEMlqH+Wet327F5v7j4HJeloL4i58n9FY1RBYz3gCjx6Dzes0xqy+Ycu+gEShd
	 astBZ9ESkcubq9obHvULdfqiW0JWo6RJ3C8dP8A2ofc5SUupKNi5QXM9dZO/QgYfToNKo
	 APQnn0YR7QRQoi1QYtTUKauWOcN0NmzolmbFc97p2uabizRSNktex9sgRGC/CggnBxbCM
	 HH1AY0bT2RPviNk2CaD6DNxOHfl843QYFHhdzGhK2FkFZ1E7dDgsqCl4oayQ+Wl2FV0Yd
	 jqpypPcQfFHZX3/T9UFxOrzZaJjrSUMIjtHhQWsDFmjuBu3Ednrt29wMaAxlNxQMFAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795459216;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Xcfo6sPpqqv6qUxbffj2wX13XtDSrIO/6CY/phESgLs=;
	b=Ika8fQQxxx0MF1/44dvjAXdTLF+xcaP9GT9wmEAQruEHvm1hH+dqTz7mnbKwCtGBm0UC
	 qdsp03h6ZovdMVeOsVsD7x/OvMJdauRCMnDwd7xOFpKtuLrUrWnBkarI8zbwnv6OxGvNn
	 iYWN3woJRidBCuP1rX/+11sF37ybASZFE+2bN8hXggyNic8ckvEPMqbNEku42iBChjG4g
	 oH2+wwC1uNqI2b7itApZuX/5C9aujHnQgPvD3mmJll790+vZLciBOTMdzewW4hxY4hCN3
	 RIo/e+EvBgqT38fUigljM5tsHvoZ4oEsfPB2Tb26FcUAP6+t8MdGKOg3MIhMszpRN5Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795459216;
	bh=Xcfo6sPpqqv6qUxbffj2wX13XtDSrIO/6CY/phESgLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i55cbMij7BrgIBRNEXhCXvCBH7qWPxV2xUsEGFHXFTLvffBoSV4UT2bhhxvin0mV8
	 xWDc7qmlK4HiyR/O54sKobkpHcU6hNbx/CF0eoh4Bzo6LKY76dZpRONZPYE8VK9cip
	 mk8rAlpPTfnffniowbJHeMkjtK43Gw4jYEgMA8bQYJ7heXpveS/4OnbCk0YTZdeif6
	 fZV10o92U+uVydvOBeWPYSMT9Eb8RZqznx6lBqQMVFK9MQGDOg9aJZku5v95vFgSSl
	 h9tdA3CLY3YOgLvyqVYlfr8eCSxKN2G4u+QF17k92EMR017pgGu1DjKfaJ71KVEODs
	 blbhd4GVHgkMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3415060640;
	Mon, 23 Nov 2026 18:40:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id F0D1A499
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 18:40:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E31EE4021C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 18:40:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7h8P0__lN-dP for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 18:40:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8279F40093
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=dima.ruinskiy@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=jAZKmpE5
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8279F40093
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 18:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795459214; x=1826995214;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jxFYDC0FVRfuJRhO3SfWBh/43ma4KApCieBMkuGDCYU=;
 b=jAZKmpE5KGgFnqmfeM5EgPMR/eCTdSE02iNLzobeZ5xKPHJeXabwVCHO
 DwlbGX6dv4NpG1ykEd228d2rSt2NVBsDMIMEhA4vOjNkBisPsaM5z2nE9
 kEQLe9oax30VrjNVWjz7uunibj3f92p2tZq8V4WlFPVg0XtbLKTB1p8hk
 mr3B/SXTGLS3v5ecluqaouwnT8Vu2WyAn9iUphfps/bvfCQaiayDClsj+
 BCR/1u/6/giiKz62sm2Ze2abHeIE2e/hIUgfjk6Xq7h7LUbrZUOK9+exd
 GfZzZloGwI+ac1qNcVpYnrdXvEpQbt80kxd26U72P+LRxXjxHtWlxsXTQ w==;
X-CSE-ConnectionGUID: rFNHxb9yQ0yz5A8o6vbzBA==
X-CSE-MsgGUID: 2yeAyoCgREis7Uq7KBZR2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4157668"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4157668"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 10:40:14 -0800
X-CSE-ConnectionGUID: g5juaR0RQ4at0M18pB1Dog==
X-CSE-MsgGUID: bsUz8jUHQq+06FvwRm/1og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; d="scan'208";a="11245372"
Received: from ccdlinuxdev13.iil.intel.com ([143.185.161.17])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 10:40:13 -0800
From: Dima Ruinskiy <dima.ruinskiy@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: dima.ruinskiy@intel.com,
	anthony.l.nguyen@intel.com
Subject: [PATCH iwl-net v2 1/2] e1000e: introduce new board type for Nova Lake
 PCH
Date: Mon, 23 Nov 2026 20:39:55 +0200
Message-Id: <20261123183956.1177222-2-dima.ruinskiy@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261123183956.1177222-1-dima.ruinskiy@intel.com>
References: <20261123183956.1177222-1-dima.ruinskiy@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 1fe4f45ea461 ("e1000e: Add support for the next LOM generation")
introduced the e1000_pch_nvp MAC type and related device IDs. However,
without a new board type, the device IDs were not associated with the
correct MAC type.

Fix this by introducing a new board type, to distinguish between Nova Lake
and previous generations of LAN devices. This allows limiting specific
configuration flows to their respective device families. For example -
the PHY access retry workaround, the PLL clock gate timeout change and the
forced 38400KHz system clock (SYSCFI).

Additionally, remap device IDs 0x5510 and 0x5511 to the new board type.
These IDs were originally reserved to Lunar Lake LAN, but never used in
the field and reallocated to Nova Lake platforms.

Fixes: 1fe4f45ea461 ("e1000e: Add support for the next LOM generation")
Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
---
 drivers/net/ethernet/intel/e1000e/e1000.h   |  4 +++-
 drivers/net/ethernet/intel/e1000e/hw.h      |  4 ++--
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 20 ++++++++++++++++++++
 drivers/net/ethernet/intel/e1000e/netdev.c  | 17 +++++++++--------
 4 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index 704284188..b662ff2b7 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -118,7 +118,8 @@ enum e1000_boards {
 	board_pch_tgp,
 	board_pch_adp,
 	board_pch_mtp,
-	board_pch_ptp
+	board_pch_ptp,
+	board_pch_nvp
 };
 
 struct e1000_ps_page {
@@ -530,6 +531,7 @@ extern const struct e1000_info e1000_pch_tgp_info;
 extern const struct e1000_info e1000_pch_adp_info;
 extern const struct e1000_info e1000_pch_mtp_info;
 extern const struct e1000_info e1000_pch_ptp_info;
+extern const struct e1000_info e1000_pch_nvp_info;
 extern const struct e1000_info e1000_es2_info;
 
 void e1000e_ptp_init(struct e1000_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/e1000e/hw.h b/drivers/net/ethernet/intel/e1000e/hw.h
index c7ac599e5..259b5fb8d 100644
--- a/drivers/net/ethernet/intel/e1000e/hw.h
+++ b/drivers/net/ethernet/intel/e1000e/hw.h
@@ -112,14 +112,14 @@ struct e1000_hw;
 #define E1000_DEV_ID_PCH_ADP_I219_V19		0x550D
 #define E1000_DEV_ID_PCH_LNP_I219_LM20		0x550E
 #define E1000_DEV_ID_PCH_LNP_I219_V20		0x550F
-#define E1000_DEV_ID_PCH_LNP_I219_LM21		0x5510
-#define E1000_DEV_ID_PCH_LNP_I219_V21		0x5511
 #define E1000_DEV_ID_PCH_ARL_I219_LM24		0x57A0
 #define E1000_DEV_ID_PCH_ARL_I219_V24		0x57A1
 #define E1000_DEV_ID_PCH_PTP_I219_LM25		0x57B3
 #define E1000_DEV_ID_PCH_PTP_I219_V25		0x57B4
 #define E1000_DEV_ID_PCH_PTP_I219_LM27		0x57B7
 #define E1000_DEV_ID_PCH_PTP_I219_V27		0x57B8
+#define E1000_DEV_ID_PCH_NVL_I219_LM28		0x5510
+#define E1000_DEV_ID_PCH_NVL_I219_V28		0x5511
 #define E1000_DEV_ID_PCH_NVL_I219_LM29		0x57B9
 #define E1000_DEV_ID_PCH_NVL_I219_V29		0x57BA
 
diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 87cd1cdc6..a412475f5 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -6240,3 +6240,23 @@ const struct e1000_info e1000_pch_ptp_info = {
 	.phy_ops		= &ich8_phy_ops,
 	.nvm_ops		= &spt_nvm_ops,
 };
+
+const struct e1000_info e1000_pch_nvp_info = {
+	.mac			= e1000_pch_nvp,
+	.flags			= FLAG_IS_ICH
+				  | FLAG_HAS_WOL
+				  | FLAG_HAS_HW_TIMESTAMP
+				  | FLAG_HAS_CTRLEXT_ON_LOAD
+				  | FLAG_HAS_AMT
+				  | FLAG_HAS_FLASH
+				  | FLAG_HAS_JUMBO_FRAMES
+				  | FLAG_APME_IN_WUC,
+	.flags2			= FLAG2_HAS_PHY_STATS
+				  | FLAG2_HAS_EEE,
+	.pba			= 26,
+	.max_hw_frame_size	= 9022,
+	.get_variants		= e1000_get_variants_ich8lan,
+	.mac_ops		= &ich8_mac_ops,
+	.phy_ops		= &ich8_phy_ops,
+	.nvm_ops		= &spt_nvm_ops,
+};
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index c3e944ee4..13c26144f 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -57,6 +57,7 @@ static const struct e1000_info *e1000_info_tbl[] = {
 	[board_pch_adp]		= &e1000_pch_adp_info,
 	[board_pch_mtp]		= &e1000_pch_mtp_info,
 	[board_pch_ptp]		= &e1000_pch_ptp_info,
+	[board_pch_nvp]		= &e1000_pch_nvp_info,
 };
 
 static const struct dmi_system_id disable_k1_list[] = {
@@ -8196,12 +8197,6 @@ static const struct pci_device_id e1000_pci_tbl[] = {
 	}, {
 		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LNP_I219_V20),
 		.driver_data = board_pch_mtp,
-	}, {
-		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LNP_I219_LM21),
-		.driver_data = board_pch_mtp,
-	}, {
-		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LNP_I219_V21),
-		.driver_data = board_pch_mtp,
 	}, {
 		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ARL_I219_LM24),
 		.driver_data = board_pch_mtp,
@@ -8220,12 +8215,18 @@ static const struct pci_device_id e1000_pci_tbl[] = {
 	}, {
 		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_PTP_I219_V27),
 		.driver_data = board_pch_ptp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_NVL_I219_LM28),
+		.driver_data = board_pch_nvp,
+	}, {
+		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_NVL_I219_V28),
+		.driver_data = board_pch_nvp,
 	}, {
 		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_NVL_I219_LM29),
-		.driver_data = board_pch_ptp,
+		.driver_data = board_pch_nvp,
 	}, {
 		PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_NVL_I219_V29),
-		.driver_data = board_pch_ptp
+		.driver_data = board_pch_nvp
 	},
 
 	{ }	/* terminate list */
-- 
2.44.0

