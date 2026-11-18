Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD516606A31C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 16:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Uh3KKU/4;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L22H93BN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D4534071F;
	Wed, 18 Nov 2026 16:35:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8UEIgYdJz4lF; Wed, 18 Nov 2026 16:35:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D031E40790
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795019710;
	b=rEdJi6eZMTvToDFH8plEIh3MTsRj5Fq3RNmwTYg+2ZcTp7cmN4s5z3EGdZqH6lwSawgA
	 Zv3hpYTNsCUvBN2MZQAwwNYY0AsnasKhq5BjLBe9N3EvGVqYYtZ1x5nzr3HHpleS1qDEt
	 YSdHUSGp3EWZJqPbIrvoXF+KFDeReMfuS94SfWeIjf9KSsqHpErnMPvxuB0Pur2861sUl
	 qySJcM+oR22fSmDKm5T9d+EdSQf5OSyznePyw4WAPDW6IwT9VJ3EC/4ZwfTXd4Qr1X4Qs
	 gsEgw7c8GvbthVKAMECqvc6KGPUZUdmMFrE8fDozbZKqjQfVlut+/lw+kUlKUO5LpXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795019710;
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
	b=FLSh8IyJVbsxVoxFEKxi8jANBewqFF9KDMZdhJtPZveQjBN+OG3Y/Z5+0wy2faA7s1DM
	 UO8+DpHitcp5PgnLqK3BS4z/jX4qSMrXsx2V67pHexJWRQIeWdalfg04XGCKLKQEMYxrO
	 +MBTPO4l9fEwYWibd7AhZDrlVtDonjJY02iTAsWd5D6MHeE5NvWnMQn9OUfqYtLX+RHfS
	 rxeeDwiGKhmIeOmb0QFbr2I08thR1KTOgbD2nLVYYSXrRN69CXm5x/1SN9/OHzeDBemDW
	 Kde88Awfw++alo+ev2GkKLXHKtMQFsJutmC7+dhwuKuBLMbZkcJsJt9IwPFSVc3c8EA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795019710;
	bh=Xcfo6sPpqqv6qUxbffj2wX13XtDSrIO/6CY/phESgLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Uh3KKU/4uiq5y6YIwfj13QO6igv3oQpzp/9t7QtilKRXzfVZrZOUD9rsGI7rmiKaA
	 Gs4ZnmwvG6/pp3yAB5tHi2G2Gaz3hnn0rN0JCAR9Ar52qetcevDUYDRWdypZZOKqi9
	 3G+gFcxDBA4kTdCcqZq48Btl5bN8bzM52oIqlsCK5tTrLqlegwIiOuNuirhzsjmQRB
	 8snFFOeyCFLp6fB+yJnEJnhI1bR83aGZdSWp3eqgME0MXUb9FH6VEfZ+5sx82nFd/v
	 i3FUIMkeKy8zLmordWIq+mYmfhpQHTujkJsDjUE/6S5wF4tCTbT5T0ZlHdJhiMjuwi
	 uIAHno7JD7W/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D031E40790;
	Wed, 18 Nov 2026 16:35:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0EA049F8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 16:35:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E962C40199
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 16:35:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IWcYsPMZhho4 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 16:35:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0733D4049A
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=dima.ruinskiy@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=L22H93BN
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0733D4049A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 16:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795019708; x=1826555708;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jxFYDC0FVRfuJRhO3SfWBh/43ma4KApCieBMkuGDCYU=;
 b=L22H93BN8eTUL0S/CSNctn/1KkJJR1UXhHEBnFsFrfVmGK6KVsvVoRaF
 G0c3U5y0rD8i0gZxqvXOrHnwudBM0nzm6D3+G064TdJ+XwQEFjZzwIMJy
 v6PwsWx8J6UVhlgTDR3GI293IMZJbDsLTvHC2kpjWU9R4m0zgfoZMdHYm
 txf9MZuDWuRCo7FyWp0d/ynvHmfi/LK3hUKo66vxATZHPQIbnkUDddTe6
 2i3FA1FZcIVh3gtE5y9OVVvylhdU+XmvbCJASO5Pp+Wgbc+TIvSQh0NQs
 Dzv/He/Ae/tFoExbnaNyH3XQE49qRSjqaaNd95Bgb/51OB+AMdAG0M/t/ A==;
X-CSE-ConnectionGUID: 1Cjqi5k4SWmBLjKHOdS6jw==
X-CSE-MsgGUID: nZGsSLKFTcKcaIT+LEnSlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3855911"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3855911"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 08:35:04 -0800
X-CSE-ConnectionGUID: ITQK68rCQqi+NvG6tj9LcQ==
X-CSE-MsgGUID: 7m7x6+3+QsiqIBHCcY54Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10071909"
Received: from ccdlinuxdev13.iil.intel.com ([143.185.161.17])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 08:34:55 -0800
From: Dima Ruinskiy <dima.ruinskiy@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: dima.ruinskiy@intel.com,
	anthony.l.nguyen@intel.com
Subject: [PATCH iwl-net 1/2] e1000e: introduce new board type for Nova Lake PCH
Date: Wed, 18 Nov 2026 18:34:46 +0200
Message-Id: <20261118163447.1117617-2-dima.ruinskiy@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118163447.1117617-1-dima.ruinskiy@intel.com>
References: <20261118163447.1117617-1-dima.ruinskiy@intel.com>
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

