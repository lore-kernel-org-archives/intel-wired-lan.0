Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB773C531D4
	for <intel-wired-lan@archiver.kernel.org>; Thu, 23 Jul 2026 14:51:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7DBC660A48;
	Thu, 23 Jul 2026 14:51:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NL8kmp46eyE4; Thu, 23 Jul 2026 14:51:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B87A260A46
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784818303;
	bh=BbJtUuzozwfX09CsFwcZOw4nls2L4UV8hqA4lHMM5Gs=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=9VY40wm45pkJvcx3dJo5Br3PlV85wdqOExHgKuqv+tXsTwi/KhOtuXkz1Y0LvO8jo
	 KsD8UIEZtCSMLp5qOaJDslickWe0DPz+V513HNcSXvz20aUiTQVBb+U7IlDNbqqUML
	 5RHiz3t7rNsxt20DcMT2RAehw0x1r7wOp/63p5jh7sAlWhuWEmukxC6U+CthZzHvTX
	 RcQnGMpC7Kv+2GXMPyTWOacQwzowCGRt3YK0F5hQsk3h/l8ddyimYJ1UbxAPRHNMiQ
	 zOTBcTfiFZSDnszMnVGqi6uLY/5y+L9s2bLxYi6fvVu336HzSeVLcxhokuGf5qoTwH
	 JiEUDBC+ZTcFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B87A260A46;
	Thu, 23 Jul 2026 14:51:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4CC78390
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 14:51:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 31E778108D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 14:51:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZpfcvbINldkX for <intel-wired-lan@lists.osuosl.org>;
 Thu, 23 Jul 2026 14:51:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=tomasz.lichwala@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1BCB381082
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1BCB381082
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1BCB381082
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 14:51:40 +0000 (UTC)
X-CSE-ConnectionGUID: md65o9MJTTiE4G0qkqD4gw==
X-CSE-MsgGUID: NlMv9mIfQN2GAEkmyCW55w==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85348159"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="85348159"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 07:51:40 -0700
X-CSE-ConnectionGUID: 62eQpB28QHiasLKW/H5xmw==
X-CSE-MsgGUID: oqYmd6nHR8KTW7Gu+Y1JdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="296643413"
Received: from os-delivery.igk.intel.com ([10.123.220.8])
 by orviesa001.jf.intel.com with ESMTP; 23 Jul 2026 07:51:39 -0700
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>,
 Marcin Szycik <marcin.szycik@linux.intel.com>
Date: Thu, 23 Jul 2026 16:51:37 +0200
Message-ID: <20260723145137.644693-1-tomasz.lichwala@linux.intel.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784818301; x=1816354301;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=9y+l5OYsFTuFSxJuB0Tm4LONWubIJxxPixlLJDvfRM8=;
 b=KCU0md+KPYvdJigJ739pdax/QFOovyJ4lootkWNYiUolLR6NdN38cQbE
 Sx/5G2sMva4karzP+G5jq4JTDXRHFSdxhEFYUOOdZsIrDB2IJVZgeZNlH
 5Dq1bkdUqr4s2BSXlaIdpy2C1w67MMM3lbxApk7Ag64vm6cNJO2B+vccj
 xT7EgWkMaHw29Q7+CHC1/iGUjhbqw8toieORdMFUqeVNGbDxMqISUna4v
 YY0PsmiEacVOYa6iL70V282wIPT3MIyXU/zDGF+KVvb8sp2OrDb8su5wR
 GVImHuWU8h70c1p1ZqcIEwWU4Nit2VITFvRtkagbRRq9iDHGRYzTDcLnX
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=KCU0md+K
Subject: [Intel-wired-lan] [PATCH iwl-net] ixgbevf: fix link speed reporting
 for Hyper-V E610 VFs
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

On Hyper-V E610 VFs the VFLINKS register does not carry valid link speed.
Instead, link status is exposed through emulated PCI config space at offset
0x209 in VFLINKS register format. Read and decode it when checking link on
E610 VFs.

Fixes: 4c44b450c69b ("ixgbevf: Add support for Intel(R) E610 device")
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/vf.c | 81 ++++++++++++++++++++++---
 1 file changed, 72 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index f6df86d124b9..61ca2cc1ecc6 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -1,14 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 1999 - 2024 Intel Corporation. */
 
+#include <linux/unaligned.h>
+
 #include "vf.h"
 #include "ixgbevf.h"
 
-/* On Hyper-V, to reset, we need to read from this offset
- * from the PCI config space. This is the mechanism used on
- * Hyper-V to support PF/VF communication.
+/* On Hyper-V the PF/VF communication is through emulated PCI config
+ * space. The reset and link status are exposed at the offsets below.
  */
-#define IXGBE_HV_RESET_OFFSET           0x201
+#define IXGBE_HV_RESET_OFFSET		0x201
+#define IXGBE_HV_LINK_STATUS_OFFSET	0x209
+#define IXGBE_HV_LINK_STATUS_SIZE	4
 
 static inline s32 ixgbevf_write_msg_read_ack(struct ixgbe_hw *hw, u32 *msg,
 					     u32 *retmsg, u16 size)
@@ -901,6 +904,40 @@ static s32 ixgbevf_check_mac_link_vf(struct ixgbe_hw *hw,
 	return ret_val;
 }
 
+/**
+ * ixgbevf_hv_read_links_e610 - read link status from PCI config space
+ * @hw: pointer to hardware structure
+ * @links_reg: pointer to store read value
+ *
+ * On Hyper-V E610 VFs the VFLINKS register does not carry valid link speed.
+ * Instead, link status is exposed through emulated PCI config space at offset
+ * 0x209 in VFLINKS register format.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static s32 ixgbevf_hv_read_links_e610(struct ixgbe_hw *hw, u32 *links_reg)
+{
+	struct ixgbevf_adapter *adapter = hw->back;
+
+#if IS_ENABLED(CONFIG_PCI_MMCONFIG)
+	u8 data[IXGBE_HV_LINK_STATUS_SIZE];
+
+	for (int i = 0; i < IXGBE_HV_LINK_STATUS_SIZE; i++) {
+		int ret = pci_read_config_byte(adapter->pdev,
+					       IXGBE_HV_LINK_STATUS_OFFSET + i,
+					       &data[i]);
+		if (ret)
+			return pcibios_err_to_errno(ret);
+	}
+
+	*links_reg = get_unaligned_le32(data);
+	return 0;
+#else
+	dev_err_once(&adapter->pdev->dev, "cannot read link status, PCI_MMCONFIG is required for Hyper-V\n");
+	return -EOPNOTSUPP;
+#endif
+}
+
 /**
  * ixgbevf_hv_check_mac_link_vf - check link
  * @hw: pointer to private hardware struct
@@ -909,6 +946,7 @@ static s32 ixgbevf_check_mac_link_vf(struct ixgbe_hw *hw,
  * @autoneg_wait_to_complete: unused
  *
  * Hyper-V variant; there is no mailbox communication.
+ * For E610 VFs, link status is read from emulated PCI config space.
  */
 static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
 					ixgbe_link_speed *speed,
@@ -923,13 +961,32 @@ static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
 	if (!mbx->ops.check_for_rst(hw) || !mbx->timeout)
 		mac->get_link_status = true;
 
+	/* E610 VFs always read link status from emulated PCI config space
+	 * because VFLINKS does not carry valid speed for these devices.
+	 * Skip get_link_status caching since PCI config reads are cheap.
+	 */
+	if (mac->type == ixgbe_mac_e610_vf) {
+		s32 ret = ixgbevf_hv_read_links_e610(hw, &links_reg);
+
+		if (ret) {
+			*link_up = false;
+			*speed = IXGBE_LINK_SPEED_UNKNOWN;
+			return ret;
+		}
+		goto decode;
+	}
+
 	if (!mac->get_link_status)
 		goto out;
 
-	/* if link status is down no point in checking to see if pf is up */
 	links_reg = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
-	if (!(links_reg & IXGBE_LINKS_UP))
-		goto out;
+
+decode:
+	if (!(links_reg & IXGBE_LINKS_UP)) {
+		*link_up = false;
+		*speed = IXGBE_LINK_SPEED_UNKNOWN;
+		return 0;
+	}
 
 	/* for SFP+ modules and DA cables on 82599 it can take up to 500usecs
 	 * before the link status is correct
@@ -941,8 +998,11 @@ static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
 			udelay(100);
 			links_reg = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
 
-			if (!(links_reg & IXGBE_LINKS_UP))
-				goto out;
+			if (!(links_reg & IXGBE_LINKS_UP)) {
+				*link_up = false;
+				*speed = IXGBE_LINK_SPEED_UNKNOWN;
+				return 0;
+			}
 		}
 	}
 
@@ -956,6 +1016,9 @@ static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
 	case IXGBE_LINKS_SPEED_100_82599:
 		*speed = IXGBE_LINK_SPEED_100_FULL;
 		break;
+	default:
+		*speed = IXGBE_LINK_SPEED_UNKNOWN;
+		break;
 	}
 
 	/* if we passed all the tests above then the link is up and we no
-- 
2.54.0

