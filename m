Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC85C55184
	for <intel-wired-lan@archiver.kernel.org>; Tue,  4 Aug 2026 15:39:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 323B180854;
	Tue,  4 Aug 2026 15:39:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RFJeKr43I-rU; Tue,  4 Aug 2026 15:39:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1F77980879
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785857969;
	bh=xPS5phEUT2OUpewBgvGI3VQi0ytEH7lv+iH8uwp3v4I=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uWgv0cTFy2Vr9+v3bJN+q+rPjNcg5vhlrhl5D5OGBhsYbwu6wimsPmk1z8ecqlXNl
	 LSONarjyw3Xiy/b4zxW+h7k9zmQ9vUmKsRfTPo2rj/SGPBXqjKCgBSw0SFCzDSd0P9
	 FwEc/KCEvF1NLU2wBAyiIjiI4QXrqP84yPorzJPhCDWMy237UygDbVY1QLq8ml+QJe
	 7epp5keV1siYdSofTPtkAH3YG53DDGrlmZ6BwF+CSnOuwUOPK/cP388EsXc7i/XnHO
	 QYGSsHFdIVQ30bfvi/yzQcU5fWzMhWJTHAmv8pNfjx5gJZ8fZGh//Ac93fgIoiOouJ
	 sJ7mrzUdk9u7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F77980879;
	Tue,  4 Aug 2026 15:39:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2FCFE296
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 15:39:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 21B8A60746
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 15:39:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WtesGKiidIkH for <intel-wired-lan@lists.osuosl.org>;
 Tue,  4 Aug 2026 15:39:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=tomasz.lichwala@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 995C56072D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 995C56072D
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 995C56072D
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 15:39:25 +0000 (UTC)
X-CSE-ConnectionGUID: 4cYyylCjTFG+phDtI/kfgw==
X-CSE-MsgGUID: H/JNAJYASiaSBnDfsNhcAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97918429"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="97918429"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 08:39:25 -0700
X-CSE-ConnectionGUID: sFCPPqpIT7+rnd0Is+CnXw==
X-CSE-MsgGUID: wE/uLWaSRGOiZ1MLhhNHXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="260960227"
Received: from os-delivery.igk.intel.com ([10.123.220.8])
 by orviesa008.jf.intel.com with ESMTP; 04 Aug 2026 08:39:23 -0700
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>,
 Marcin Szycik <marcin.szycik@linux.intel.com>
Date: Tue,  4 Aug 2026 17:39:22 +0200
Message-ID: <20260804153922.688462-1-tomasz.lichwala@linux.intel.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785857966; x=1817393966;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=GYI6taCX5pxJPHnsCev5Mw0U2Se5H+GYfTNsBRbl7Qg=;
 b=j0PT6/TZm9/Gv4KMyK/LFWdXwFkGkYGpoHrgVDgkqquhlQKBzgVtvcNn
 G5EuxbSJq1FiDosVNYjNqmqqWuUPJZmZczweAmjF6p+3hs8bEIGB0BvLB
 0Yffn6FHQ/8nt+IYclHKPiT+6+vitNyy0542w0jSCjnMaOKej+sRZAqz3
 76ZJaZPZqncPO+wadweCe30DpKBLSUDLU3HOLbt4Dz88PFTJP9OXiLPs9
 H1XdWIHGNuU0YXXQH3exZUWO0cxJPnabNc25CZ8cqSUdfwLmNHBbINYaD
 SLxVNMRNyLHvYYYsbavQcWccGpeTpaXTTiQE0tSztMqo3Mrbc6CKMkz/b
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=j0PT6/TZ
Subject: [Intel-wired-lan] [PATCH iwl-net v2] ixgbevf: fix link speed
 reporting for Hyper-V E610 VFs
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
 drivers/net/ethernet/intel/ixgbevf/vf.c | 79 ++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index f6df86d124b9..4c460ec62de3 100644
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
@@ -923,13 +961,30 @@ static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
 	if (!mbx->ops.check_for_rst(hw) || !mbx->timeout)
 		mac->get_link_status = true;
 
+	/* E610 VFs always read link status from emulated PCI config space
+	 * because VFLINKS does not carry valid speed for these devices.
+	 * Skip get_link_status caching since PCI config reads are cheap.
+	 */
+	if (mac->type == ixgbe_mac_e610_vf) {
+		if (ixgbevf_hv_read_links_e610(hw, &links_reg)) {
+			*link_up = false;
+			*speed = IXGBE_LINK_SPEED_UNKNOWN;
+			return 0;
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
@@ -941,8 +996,11 @@ static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
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
 
@@ -956,6 +1014,9 @@ static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
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

