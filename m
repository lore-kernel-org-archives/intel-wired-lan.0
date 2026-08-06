Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316ECC56208
	for <intel-wired-lan@archiver.kernel.org>; Thu,  6 Aug 2026 10:46:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C731980DB0;
	Thu,  6 Aug 2026 10:46:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FV6EPopqIOrd; Thu,  6 Aug 2026 10:46:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1074080D5E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786013186;
	bh=ukduvT1/zu02aQjOnW4sJFN5r4XgIon2Ay6FyYGs7t8=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NKxp+4JotoQ3k5s+Z50z80V04UkZjlCFJWw+3gCfN2OM4ctf9zLtugdIoygqpXdjN
	 pOlFdRC1uu7nhNLpBU0OomcqemlvZoB9097aVM/G1flbUvavSLpgG9K+/nMmil7GXo
	 eYY5N/fUiLVuAw+BtFKjJ7HrggOWOMhpNeNkL3EHmzmQpA5Iod5QSlbky4KM47ETQH
	 SrQWSau+T+A6CYiVhHfN0Pf7uP0AGJZ+UmqMv3JfVNQSUHt8+Zp3C8nV/ywUQReurV
	 b6gWMaYcbdo+WfQMBropjwKd5qmKqLaIb3yJSPgp9+tZceO+p+zdtXsoKNVkyP5SxX
	 cgV4cKMvRQXsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1074080D5E;
	Thu,  6 Aug 2026 10:46:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D562397
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 10:46:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0FF4380D5E
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 10:46:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k8aBGRiPY1PQ for <intel-wired-lan@lists.osuosl.org>;
 Thu,  6 Aug 2026 10:46:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=tomasz.lichwala@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org F256680D5B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F256680D5B
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F256680D5B
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 10:46:23 +0000 (UTC)
X-CSE-ConnectionGUID: jhmEeGbWSs+WnfhkkvOflg==
X-CSE-MsgGUID: JnPdzfYjQ3mUS8Czv0so7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="90485395"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="90485395"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 03:46:23 -0700
X-CSE-ConnectionGUID: bN/MvrOlSGu39befut6lfw==
X-CSE-MsgGUID: NpbdvsidSZ2HfsPFviQK0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="255810735"
Received: from os-delivery.igk.intel.com ([10.123.220.8])
 by fmviesa009.fm.intel.com with ESMTP; 06 Aug 2026 03:46:22 -0700
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>,
 Marcin Szycik <marcin.szycik@linux.intel.com>
Date: Thu,  6 Aug 2026 12:46:21 +0200
Message-ID: <20260806104621.700901-1-tomasz.lichwala@linux.intel.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786013184; x=1817549184;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=gO9/DWRk9A4o3wJTvdWiAGi/I3at8VMX0HtAhP3Ct+A=;
 b=ZbttbCEfTJHkDVtLiKodBNTtlaGvZxyo1lF9J7hIX+NkJky5kbT+1l5j
 DFa5d1OQkcXhzmJ/0crTQHyeNZWZsO19poTkeuVVoTvxcEW84akj/D8hh
 VzE/OtUY0xTdxb7J8EY8lldQpXL+l0AhjOxhJfbQXST/h+rekXBxKQ5Iy
 /mqbujtXjNe11g/M1OaQzD0ivvhdkXTB9+MFG5h0j3v4QtTjtiC6sZD++
 En4cwScQohL4dS8cC1E7elKjlL+kbEBOY+F6bj6tQwOvA2xxT0UMiyE7d
 jcKb0Q1c4Z342RAEJ5bzgfz6O0Cja4edOW1r/CBOxGbmQMjE8mF4qnYrE
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ZbttbCEf
Subject: [Intel-wired-lan] [PATCH iwl-net v3] ixgbevf: fix link speed
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

When an E610 VF is running under Hyper-V, the VFLINKS register does not
carry valid link speed. The existing code reads speed from VFLINKS, which
does not reflect the actual negotiated speed. This results in ethtool
reporting a stale or incorrect link speed.

The Hyper-V synthetic NIC exposes the actual link status through
emulated PCI config space at offset 0x209 in VFLINKS register format.
Read and decode link status from there when checking link on E610 VFs.

Fixes: 4c44b450c69b ("ixgbevf: Add support for Intel(R) E610 device")
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/vf.c | 77 +++++++++++++++++++++----
 1 file changed, 65 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index f6df86d124b9..8ad06e28b5de 100644
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
@@ -901,6 +904,34 @@ static s32 ixgbevf_check_mac_link_vf(struct ixgbe_hw *hw,
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
@@ -909,6 +940,7 @@ static s32 ixgbevf_check_mac_link_vf(struct ixgbe_hw *hw,
  * @autoneg_wait_to_complete: unused
  *
  * Hyper-V variant; there is no mailbox communication.
+ * For E610 VFs, link status is read from emulated PCI config space.
  */
 static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
 					ixgbe_link_speed *speed,
@@ -923,13 +955,28 @@ static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
 	if (!mbx->ops.check_for_rst(hw) || !mbx->timeout)
 		mac->get_link_status = true;
 
-	if (!mac->get_link_status)
-		goto out;
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
+	} else {
+		if (!mac->get_link_status)
+			goto out;
 
-	/* if link status is down no point in checking to see if pf is up */
-	links_reg = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
-	if (!(links_reg & IXGBE_LINKS_UP))
-		goto out;
+		links_reg = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
+	}
+
+	if (!(links_reg & IXGBE_LINKS_UP)) {
+		*link_up = false;
+		*speed = IXGBE_LINK_SPEED_UNKNOWN;
+		return 0;
+	}
 
 	/* for SFP+ modules and DA cables on 82599 it can take up to 500usecs
 	 * before the link status is correct
@@ -941,8 +988,11 @@ static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
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
 
@@ -956,6 +1006,9 @@ static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
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

