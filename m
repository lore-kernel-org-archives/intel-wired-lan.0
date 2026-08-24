Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799E1C5DF81
	for <intel-wired-lan@archiver.kernel.org>; Mon, 24 Aug 2026 11:08:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2536280B28;
	Mon, 24 Aug 2026 11:08:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wGZDFOW8ltL4; Mon, 24 Aug 2026 11:08:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787569721;
	bh=/kJVfubJ3xLg6sbSApg959Z8jiCya0v6g3Fh6uXuT6s=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=5hcXRX6vIITGwl7fmZgA6KKnQfiGJpCdo+VkE/6I/+eG9ZtE9M9jpz6TYHsSccYsX
	 UK6CrNZUC2tVg/cm7QT2X2TsXSvj5JX/t9r8sjYInVWXP6RkiIj+QYCyxfJcNxHDdP
	 ECEtuGqdFHaAcwGtoaw1oLQ4KOXRYSgfzMQLdjhYv8/6/ukdSWzeWCxfz0dBNy4tT2
	 nKW3ppBemjkQfcyu0+Z0WhotLzpTujIsZLRih/4z2NNQtEY4Zn4rrzqAOK/neqSwIQ
	 g8uqgHunDdxyVv1VQThkbPXje+ECfvKgx45akU+2KJNoSa/oBGpcB4bcoUFplDpueu
	 W6NMFOcnaEE0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 42E1580AF5;
	Mon, 24 Aug 2026 11:08:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1214A29B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 11:08:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ECD584067A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 11:08:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id so8iX2JybeOh for <intel-wired-lan@lists.osuosl.org>;
 Mon, 24 Aug 2026 11:08:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=tomasz.lichwala@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cYaeU5PY
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CDFF040639
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 11:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787569718; x=1819105718;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=lA+X1Ot4fcWYWjS0LfvO0PtshSw2LjPWXsggrfDer4M=;
 b=cYaeU5PYK8tgeoyOblO08Ezl+RkXW2FWu/qTaiSSC/gIj0SDr8TW4tsN
 Oz2ds2wofGVlo8KCFxCgQXF73NVszTntJnLOxqbaqZD+Hr4zaj0ECnXYV
 bwWA7SA9WLK2AYah1aj5d6KSYebAXujKEAZYhV5sS2m+hm7Ut4+U2G5xv
 plUSobVt7NnP5s3DDddiRW/PgcDGRjE76zWbqwh47YPpyUMSl+rvE6/7H
 xNaOqSaQsVl7XsuvmBA1i1JQbTAeFAzM1OYjXqMuHhBcIaBy+sZ+q36X8
 lkzWRucE1K8Rgrlv4LqfjinDSpXDlnG9NvUSS6BudabhQqG6I/hqP8UKr g==;
X-CSE-ConnectionGUID: Fb7bzCdCSFC8ykr7XcmufA==
X-CSE-MsgGUID: EnOk0RXoTm2e2Xix2b6JMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="87877502"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="87877502"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 04:08:37 -0700
X-CSE-ConnectionGUID: Xqq9QbCXR5us33s8r07w4g==
X-CSE-MsgGUID: ThmbwuijSAmh17OtH+AHhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="296869999"
Received: from os-delivery.igk.intel.com ([10.123.220.8])
 by orviesa002.jf.intel.com with ESMTP; 24 Aug 2026 04:08:36 -0700
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Tomasz Lichwala <tomasz.lichwala@linux.intel.com>,
 Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-net v4] ixgbevf: fix link speed reporting for Hyper-V E610
 VFs
Date: Mon, 24 Aug 2026 13:08:34 +0200
Message-ID: <20260824110834.2364407-1-tomasz.lichwala@linux.intel.com>
X-Mailer: git-send-email 2.54.0
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

When an E610 VF is running under Hyper-V, the VFLINKS register does not
carry valid link speed. The existing code reads speed from VFLINKS, which
does not reflect the actual negotiated speed. This results in ethtool
reporting a stale or incorrect link speed.

The Hyper-V synthetic NIC exposes the actual link status through
emulated PCI config space at offset 0x209 in VFLINKS register format.
Read and decode link status from there when checking link on E610 VFs.

To avoid generating unnecessary VMBus transactions on every watchdog
cycle, read the PCI config register on demand when ethtool or sysfs
queries link speed, rather than polling it periodically. The cached
value is used by the watchdog and link state notifications as before.

Guard the PCI config space read with IS_ENABLED(CONFIG_PCI_MMCONFIG),
since accessing offsets above 256 requires MMCONFIG support.

Fixes: 4c44b450c69b ("ixgbevf: Add support for Intel(R) E610 device")
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
---
v4:
 - Read link speed on demand from ethtool/sysfs query instead of polling
   every watchdog cycle to avoid unnecessary VMBus transactions (ethtool.c)
 - Restore get_link_status caching for E610 VFs in check_link
 - Add IS_ENABLED(CONFIG_PCI_MMCONFIG) guard for PCI config reads above
   offset 256
 - Add CC netdev@vger.kernel.org
v3:
 - Remove #if IS_ENABLED(CONFIG_PCI_MMCONFIG) preprocessor guard
 - Replace goto decode label with if/else control flow
 - Move get_link_status check into else branch (non-E610 path only)
 - Expand commit message with problem description
v2:
 - Simplify error path: return 0 with link_up=false instead of
   propagating PCI read error code
 - Fix alignment in macro definitions
 - Update comment describing Hyper-V PCI config offsets
 drivers/net/ethernet/intel/ixgbevf/ethtool.c | 12 ++++
 drivers/net/ethernet/intel/ixgbevf/vf.c      | 68 +++++++++++++++++---
 2 files changed, 72 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ethtool.c b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
index 537a60d5276f..2463fccffd4d 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
@@ -83,6 +83,18 @@ static int ixgbevf_get_link_ksettings(struct net_device *netdev,
 				      struct ethtool_link_ksettings *cmd)
 {
 	struct ixgbevf_adapter *adapter = netdev_priv(netdev);
+	struct ixgbe_hw *hw = &adapter->hw;
+
+	/* E610 Hyper-V VFs: read current link speed from PCI config space
+	 * on every link speed query.
+	 */
+	if (hw->mac.type == ixgbe_mac_e610_vf) {
+		spin_lock_bh(&adapter->mbx_lock);
+		hw->mac.get_link_status = true;
+		hw->mac.ops.check_link(hw, &adapter->link_speed,
+				       &adapter->link_up, false);
+		spin_unlock_bh(&adapter->mbx_lock);
+	}
 
 	ethtool_link_ksettings_zero_link_mode(cmd, supported);
 	ethtool_link_ksettings_add_link_mode(cmd, supported, 10000baseT_Full);
diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index f6df86d124b9..a84b62641e9b 100644
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
+	u8 data[IXGBE_HV_LINK_STATUS_SIZE];
+
+	if (!IS_ENABLED(CONFIG_PCI_MMCONFIG)) {
+		dev_err_once(&adapter->pdev->dev,
+			     "cannot read link status, PCI_MMCONFIG is required for Hyper-V\n");
+		return -EOPNOTSUPP;
+	}
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
@@ -926,8 +964,16 @@ static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
 	if (!mac->get_link_status)
 		goto out;
 
-	/* if link status is down no point in checking to see if pf is up */
-	links_reg = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
+	if (mac->type == ixgbe_mac_e610_vf) {
+		if (ixgbevf_hv_read_links_e610(hw, &links_reg)) {
+			*link_up = false;
+			*speed = IXGBE_LINK_SPEED_UNKNOWN;
+			return 0;
+		}
+	} else {
+		links_reg = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
+	}
+
 	if (!(links_reg & IXGBE_LINKS_UP))
 		goto out;
 
@@ -941,8 +987,11 @@ static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
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
 
@@ -956,6 +1005,9 @@ static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
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

