Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6DCC5DF81
	for <intel-wired-lan@archiver.kernel.org>; Thu, 20 Aug 2026 09:21:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1D21401DE;
	Thu, 20 Aug 2026 09:21:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0oKENvbWj6cA; Thu, 20 Aug 2026 09:21:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787217706;
	bh=yGM8/26gW53hFNA+QmXK1afgYF/JWOaYIxVM0Jn73eY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=g5TvnO6eD49Sm3xcgFlnE880ASfOQgeszUUt+MLBubje9+PFjhU4rZzCewvdfkFp5
	 20DfwV/ZFl2WTyBJQ9TMbMaVsFJcKpq14N8u3TlcFxmGqyHX0PU4ruSDoArdSElhp2
	 /MX/d+tSCAiP8FvFSkz4FOjDGJPCtMvS8qJX6lum2f2PK9qmaGdSHWnHnHddsO4N82
	 pt//z6peqFNSt2b4bfXLKdONVh2uUB78KxR2Gplw+/NzWY59jLXfLsLcLOuG1Z7niR
	 j90uvVJRkOodi/HEPJR0xxkqsU25BVrflSmdCz21X3ENe2FI47MqYOYHbEfZMlynnH
	 Q+WiMh14cxDoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4407D4027B;
	Thu, 20 Aug 2026 09:21:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D52139E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Aug 2026 09:21:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2AC7F40525
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Aug 2026 09:21:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YgJIJ8yzO-XU for <intel-wired-lan@lists.osuosl.org>;
 Thu, 20 Aug 2026 09:21:43 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=dima.ruinskiy@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ZAI0QvUV
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6CB3A40523
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Aug 2026 09:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787217703; x=1818753703;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=LvJ/qUaizwJhlogkbvoqvddNzWe9GDc7q575tH3s8Vo=;
 b=ZAI0QvUV8D7tB8YTVNKMSvr69GQE20axW7yTpsfiGqtYHEw0rMN82ZlK
 JjLJVbHZ3OlFBTHWV440mBdJJcya34eqrtJyzQFAcIcIUeLwU7ZPTFEPd
 9jv+8qI1eLUQoR0HFmBPT+LrHvYjboxLbkhSccWoMiQWIoGhUhAKDKvKB
 8K5kk8qq9U2vtiK0hh4x3HrjXYSEjKWMq7JJonGaKUHAinZJxE9Z3tCVb
 eadckmpRYfIrxpDSxfr6K16GftwkE5aYq9Ipr1z+74oNYTzCvWSQZfqVv
 fa60eriy1ViZnGa+WIdrJ0QWxVxig17gCeUeh7bQXqIAGFoD3OwT/7KxR A==;
X-CSE-ConnectionGUID: jhM5qyF1SuCTAVQe4p0fJw==
X-CSE-MsgGUID: IVymtohTS2qAA1z168pEQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="87604722"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; d="scan'208";a="87604722"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 02:21:42 -0700
X-CSE-ConnectionGUID: nAZrSOCiSpee3o7FnGPtwA==
X-CSE-MsgGUID: lMQG3RnERZuUfZiT+H3/8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; d="scan'208";a="264165394"
Received: from ccdlinuxdev11.iil.intel.com ([143.185.162.70])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 02:21:40 -0700
From: Dima Ruinskiy <dima.ruinskiy@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, dima.ruinskiy@intel.com,
 anthony.l.nguyen@intel.com, allen.lan@intel.com, acelan.kao@canonical.com,
 kuba@kernel.org
Subject: [PATCH iwl-next v2] igc: Support ACPI-based MAC passthrough
Date: Thu, 20 Aug 2026 12:21:37 +0300
Message-Id: <20260820092137.1835887-1-dima.ruinskiy@intel.com>
X-Mailer: git-send-email 2.34.1
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

Some systems implement a system MAC address object in the ACPI table,
using either \\_SB.AMAC or \\MACA object names. This system MAC address,
when enabled, is intended to override the permanent MAC address of a
network controller in a docking station connected to the system.

Implement lookup of the relevant ACPI object names and use them to
initialize the MAC address. Limit the scope to I225/I226 device IDs used
in docking stations, to avoid interfering with onboard I225/I226 NICs.

On systems where the feature is disabled or unsupported, the ACPI objects
do not exist or do not contain a valid Ethernet MAC, causing a fallback
to the existing MAC address initialization path.

Assisted-by: GitHub-Copilot:claude-opus-4.7
Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
---
v2: limit scope to dock device ids
v1: initial version
---
 drivers/net/ethernet/intel/igc/igc.h      |  1 +
 drivers/net/ethernet/intel/igc/igc_base.c |  8 +++
 drivers/net/ethernet/intel/igc/igc_hw.h   |  2 +
 drivers/net/ethernet/intel/igc/igc_main.c | 69 +++++++++++++++++++++--
 4 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 88291f775c22..05affaa04aa4 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -567,6 +567,7 @@ enum igc_tx_flags {
 
 enum igc_boards {
 	board_base,
+	board_dock,
 };
 
 /* The largest size we can write to the descriptor is 65535.  In order to
diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
index ab9120a3127f..c9067cc79b69 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.c
+++ b/drivers/net/ethernet/intel/igc/igc_base.c
@@ -474,4 +474,12 @@ const struct igc_info igc_base_info = {
 	.get_invariants		= igc_get_invariants_base,
 	.mac_ops		= &igc_mac_ops_base,
 	.phy_ops		= &igc_phy_ops_base,
+	.is_dock		= false,
+};
+
+const struct igc_info igc_dock_info = {
+	.get_invariants		= igc_get_invariants_base,
+	.mac_ops		= &igc_mac_ops_base,
+	.phy_ops		= &igc_phy_ops_base,
+	.is_dock		= true,
 };
diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
index 62aaee55668a..d14b7666b5d7 100644
--- a/drivers/net/ethernet/intel/igc/igc_hw.h
+++ b/drivers/net/ethernet/intel/igc/igc_hw.h
@@ -69,9 +69,11 @@ struct igc_info {
 	struct igc_mac_operations *mac_ops;
 	const struct igc_phy_operations *phy_ops;
 	struct igc_nvm_operations *nvm_ops;
+	bool is_dock;
 };
 
 extern const struct igc_info igc_base_info;
+extern const struct igc_info igc_dock_info;
 
 enum igc_forced_speed_duplex {
 	IGC_FORCED_10H,
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 82800a4a6d6c..15d0815a2110 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -11,6 +11,8 @@
 #include <net/pkt_sched.h>
 #include <linux/bpf_trace.h>
 #include <net/xdp_sock_drv.h>
+#include <linux/acpi.h>
+#include <linux/hex.h>
 #include <linux/pci.h>
 #include <linux/mdio.h>
 
@@ -44,6 +46,7 @@ static const char igc_copyright[] =
 
 static const struct igc_info *igc_info_tbl[] = {
 	[board_base] = &igc_base_info,
+	[board_dock] = &igc_dock_info,
 };
 
 static const struct pci_device_id igc_pci_tbl[] = {
@@ -54,8 +57,8 @@ static const struct pci_device_id igc_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_K), .driver_data = board_base },
 	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_K2), .driver_data = board_base },
 	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_K), .driver_data = board_base },
-	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_LMVP), .driver_data = board_base },
-	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_LMVP), .driver_data = board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_LMVP), .driver_data = board_dock },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_LMVP), .driver_data = board_dock },
 	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_IT), .driver_data = board_base },
 	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_LM), .driver_data = board_base },
 	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_V), .driver_data = board_base },
@@ -7116,6 +7119,57 @@ static enum hrtimer_restart igc_qbv_scheduling_timer(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
+static bool igc_get_acpi_mac_passthru(u8 *mac)
+{
+	static const struct {
+		const char *name;
+		acpi_object_type type;
+		u32 length;
+	} sources[] = {
+		{ "\\_SB.AMAC", ACPI_TYPE_BUFFER, 23 },
+		{ "\\MACA",     ACPI_TYPE_STRING, 22 },
+	};
+	struct acpi_buffer buffer;
+	union acpi_object *obj;
+	bool mac_found = false;
+	acpi_status status;
+	u8 buf[ETH_ALEN];
+	int i;
+
+	if (!IS_ENABLED(CONFIG_ACPI))
+		return false;
+
+	for (i = 0; i < ARRAY_SIZE(sources) && !mac_found; i++) {
+		buffer.length = ACPI_ALLOCATE_BUFFER;
+		buffer.pointer = NULL;
+
+		status = acpi_evaluate_object(NULL, (char *)sources[i].name,
+					      NULL, &buffer);
+		if (ACPI_FAILURE(status))
+			continue;
+
+		obj = buffer.pointer;
+		if (!obj || obj->type != sources[i].type ||
+		    obj->string.length != sources[i].length)
+			goto free_obj;
+
+		if (!strncmp(obj->string.pointer, "_AUXMAC_#", 9) ||
+		    obj->string.pointer[21] != '#')
+			goto free_obj;
+
+		if (hex2bin(buf, obj->string.pointer + 9, ETH_ALEN) ||
+		    !is_valid_ether_addr(buf))
+			goto free_obj;
+
+		ether_addr_copy(mac, buf);
+		mac_found = true;
+free_obj:
+		kfree(obj);
+	}
+
+	return mac_found;
+}
+
 /**
  * igc_probe - Device Initialization Routine
  * @pdev: PCI device information struct
@@ -7279,9 +7333,16 @@ static int igc_probe(struct pci_dev *pdev,
 	}
 
 	if (eth_platform_get_mac_address(&pdev->dev, hw->mac.addr)) {
-		/* copy the MAC address out of the NVM */
-		if (hw->mac.ops.read_mac_addr(hw))
+		/* Look for a system-provided MAC in the ACPI table before
+		 * falling back to reading the address from the NVM.
+		 */
+		if (ei->is_dock && igc_get_acpi_mac_passthru(hw->mac.addr)) {
+			netdev->addr_assign_type = NET_ADDR_STOLEN;
+			dev_info(&pdev->dev, "Using ACPI pass-thru MAC addr %pM\n",
+				 hw->mac.addr);
+		} else if (hw->mac.ops.read_mac_addr(hw)) {
 			dev_err(&pdev->dev, "NVM Read Error\n");
+		}
 	}
 
 	eth_hw_addr_set(netdev, hw->mac.addr);
-- 
2.43.7

