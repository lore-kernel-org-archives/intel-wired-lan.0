Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30C1F4368D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 17 Apr 2026 10:43:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7CF5540D74;
	Fri, 17 Apr 2026 10:43:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5ZIh0KlFSc-L; Fri, 17 Apr 2026 10:43:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ACDDE40D6E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776422618;
	bh=hD0iIOsekbFdjmMGxSyobIALwE1Jv4PwczLp6vbX8uA=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gt31Mv1Ukni47o0+CjJgeCseEW9WWm235+a28mWK5r8LPONz/mxCw1Q5Y7ChBQqAz
	 dESJ5bctY4EP4s+ZhEgkGJkh5K8q310WOW0AuJdg+pBFjDFu3qKf8YJz0bpGPG0msF
	 lsGBLXmYi9gFsGlg+UfLXVPVFX8FGLhGUI/BTj6jY41hvbG+GDNBUHPxW50ZEGhIob
	 uCd7rMF707YowTrVaEWDon8M1SdIw5U2jCkGT4WV9RUTpVKGkbXqCNXObf64QN+sWq
	 bZHM69txpaVJXrtt9GMm9H1apHIa9gKEJO4sGN7WWGPj12Y9hVr+kEYIsGI/yNqMz1
	 WjHj8DxTi1sAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ACDDE40D6E;
	Fri, 17 Apr 2026 10:43:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F30A5396
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Apr 2026 10:43:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E4B9460DA9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Apr 2026 10:43:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ehjFVB6wfhyf for <intel-wired-lan@lists.osuosl.org>;
 Fri, 17 Apr 2026 10:43:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=dima.ruinskiy@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B5DB660DA8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B5DB660DA8
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B5DB660DA8
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Apr 2026 10:43:36 +0000 (UTC)
X-CSE-ConnectionGUID: 5dhsaFAMSgOXsz7Z7UsmbQ==
X-CSE-MsgGUID: CQY/VmnWQcGy9LrAcmT1hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="77345070"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="77345070"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 03:43:35 -0700
X-CSE-ConnectionGUID: JNHpL6itSEOgZlmPjevUhA==
X-CSE-MsgGUID: OL4Xq2aNSqOG6IYxIuUVlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="232753130"
Received: from ccdlinuxdev11.iil.intel.com ([143.185.162.70])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 03:43:33 -0700
From: Dima Ruinskiy <dima.ruinskiy@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: dima.ruinskiy@intel.com, jacob.e.keller@intel.com,
 anthony.l.nguyen@intel.com
Date: Fri, 17 Apr 2026 13:43:30 +0300
Message-Id: <20260417104330.3031987-1-dima.ruinskiy@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776422616; x=1807958616;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=fRuQIXqhsbOQMTb42D8DXk6rSYHKKRtcebu0kZMZOkI=;
 b=dJYv7oIQ/BdT1WEalnrmcQo0cUAp15oj/RiKCiwPzr8fz7fZoslIQ4o+
 Q7DziaJ4IXSaY93urwyEl9hHposSJ4JIyqZcAtojVK7y/Rwgmg6Nb8vbg
 zv6xt5YIQMwgWrX318kGKt8R0ahYKB9PaP1BhoLoztDv0NLvQoXpHjeKZ
 IvyiMctvjKzU9vywodpNxmccPi1E8ChLMAih8LAQnE09BndCfCvwAmXEV
 4DIAZCS8nL8fJTeOG/KMVYO8urtXXJ8OOdKWn8uxR4kNuD/dg5lgT81uQ
 3s7AswQxiDnduH/5/uKhnwioIwInolbWZM36d/vKWAepi/NDocaZasA/x
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=dJYv7oIQ
Subject: [Intel-wired-lan] [PATCH iwl-net v3] e1000e: Reconfigure PLL clock
 gate timeout and re-enable K1 on Meteor Lake
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

Commit 3c7bf5af21960 ("e1000e: Introduce private flag to disable K1")
disabled K1 by default on Meteor Lake and newer systems due to packet
loss observed on various platforms. However, disabling K1 caused an
increase in power consumption.

To mitigate this, reconfigure the PLL clock gate value so that K1 can
remain enabled without incurring the additional power consumption.
Re-enable K1 by default, but keep the private flag to support disabling
it via ethtool. Additionally, introduce a DMI quirk table, so that K1 may
be disabled by default on known problematic systems. Currently, this
includes the Dell Pro 16 Plus, where the issue has been reported to persist
despite the changes to the PLL lock timeout.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=220954
Link: https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20250623/048860.html
Link: https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20260330/054059.html
Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Co-developed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Fixes: 3c7bf5af21960 ("e1000e: Introduce private flag to disable K1")
---
v3: add DMI quirk
v2: add comment for the PLL timeout value and revisit the commit message
v1: initial version
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c |  3 +++
 drivers/net/ethernet/intel/e1000e/netdev.c  | 15 ++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index dea208db1be5..aa90e0ce8aca 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1594,6 +1594,9 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
 			phy_reg &= ~I217_PLL_CLOCK_GATE_MASK;
 			if (speed == SPEED_100 || speed == SPEED_10)
 				phy_reg |= 0x3E8;
+			else if (hw->mac.type == e1000_pch_mtp ||
+				 hw->mac.type == e1000_pch_ptp)
+				phy_reg |= 0x1D5;
 			else
 				phy_reg |= 0xFA;
 			e1e_wphy_locked(hw, I217_PLL_CLOCK_GATE_REG, phy_reg);
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 4d553c6edd98..a7605e453382 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -25,6 +25,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/prefetch.h>
 #include <linux/suspend.h>
+#include <linux/dmi.h>
 
 #include "e1000.h"
 #define CREATE_TRACE_POINTS
@@ -58,6 +59,17 @@ static const struct e1000_info *e1000_info_tbl[] = {
 	[board_pch_ptp]		= &e1000_pch_ptp_info,
 };
 
+static const struct dmi_system_id disable_k1_list[] = {
+	{
+		.ident = "Dell Pro 16 Plus PB16250",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro 16 Plus PB16250"),
+		},
+	},
+	{}
+};
+
 struct e1000_reg_info {
 	u32 ofs;
 	char *name;
@@ -7748,7 +7760,8 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* init PTP hardware clock */
 	e1000e_ptp_init(adapter);
 
-	if (hw->mac.type >= e1000_pch_mtp)
+	/* disable K1 by default on known problematic systems */
+	if (hw->mac.type >= e1000_pch_mtp && dmi_check_system(disable_k1_list))
 		adapter->flags2 |= FLAG2_DISABLE_K1;
 
 	/* reset the hardware with the new settings */
-- 
2.34.1

