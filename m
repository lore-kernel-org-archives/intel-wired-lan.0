Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A46CA9EDE
	for <intel-wired-lan@archiver.kernel.org>; Mon, 12 Oct 2026 19:48:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7FB524052C;
	Mon, 12 Oct 2026 19:48:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ep-wJ624L3YD; Mon, 12 Oct 2026 19:48:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C8EA54052E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791834507;
	b=bSA1YxMaodP/NEjsU2ypa33p2E/ne0mm03WJ6R8yPWelWSfpL03C75vjCLGRoQRjD/lI
	 HWjZiTUIcm5MLYgtyCie9EMseLOXfxYUm7HJv9E03I7I4XM3rRRohIHku84WQlk9FFoIr
	 n7FbHZXyu6+2CSiVxDnzCtzrqCWVyrvZ2M0tDvhWZ1HmAXule9UtWsDaWFNaqrpNMuNaw
	 oIF4jgJFhkwC6/smnQbj8B9LpsMJVbeZtHyxXQP80SAqSlBWTHF3zSnFbknbs724j78YA
	 cgxaXu9MallCkopU6cBKIf47CaTtpE3bh2TeKCq5F4umw9xZhX+4qLK+CoQ4De+/w2g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791834507;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=O5kgUBmtQ3ZerZPN8vvqkKvCiMqUgBrDMncPLP6cSPo=;
	b=GEsx6ZKI7VscN4cDEqT41mvTwz9Ik6h91WAV2x6ALZvx1R60LoCkynxlCHLuMTZ+mgB7
	 4gX4Xk+iwgGO/r1sturN7qjQCqNK0gfjUvw4Z+F2JwxtCIkGnB6KfZhzj74ZN0a5VQN36
	 98Z+cZryf5wFyshh2D3AAg8HwXPU6BiOCZ8D9Zts+6GTF/KtBH9a4hzW1wNtRk1qR/Xyk
	 Q4xJg2JeLBE/ng063w2NAiYuDV+lg+2Q6ixELfz3NZvGQ0asa2kF7CQ94qWYklyK3K6hp
	 0lGHuVAK2OlbOPd59nzpxO3BF7EklQdmDnalK6veAovWkWrhKJ6O4rfJJ7gQ7k8yI2A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791834507;
	bh=O5kgUBmtQ3ZerZPN8vvqkKvCiMqUgBrDMncPLP6cSPo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=5vavO1uTjwsfSlGszT3p42rVFrqIIAAp1K3/RFTESMG1JQOh10ATRsObsWXxRMTGT
	 JPUidxROeQGKy0Hx4ZSksDj9NA1R+ZV1dPAcC+v+QCBhLLAC93sCDeiEQis5LuSbJi
	 Y323LYIHbaMu5A9525nPysaf2Gqmsy5k6ok3t9BEiHGZqRtLwsOPdRByT6vG0w5gy3
	 +0mxDnooHCsuN55hHvUWSkly582MR+RpMzWzoh1xuSUgUSc16x3jDbTGf2ydIyevAs
	 jWXEpfVSo36JzyV8LRBxLQUFA3ZASkYRaNqMCsy07PORS8tDryMEG2Maf4EO2hDQFh
	 DeYqeSqKL21xQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8EA54052E;
	Mon, 12 Oct 2026 19:48:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id F05C1105
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 19:48:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E20F6400D1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 19:48:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id laoiEVqyF8WX for <intel-wired-lan@lists.osuosl.org>;
 Mon, 12 Oct 2026 19:48:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B01754002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791834505;
 b=cTcCxUZtEZvoBsMtAvJDr+gJ0rkx9blwxfd6o7wL3TX4km0WZ35809+tysqHGepigbGE
 qmTDRmjlJhTlu7mkiAxxpnktJ5y2nFvWSvm9DTYcHvMHlYstnGAMkJ8YC9umCVYQpKwNC
 9WqyG+FZ0ooU30Fas7xcTpFrWBqHUlNZtoLandPoGK9hYWhKiGZ6u0UK7tLTq+tl5XHSQ
 d55Ff0QzzLm1vMBL7ZJEe7fWsUQr0zKwgdzPNsM5wF5SJRX9zcQW3dsbwFp7hfAksYveq
 z2/ZnTc/Y+IYq+e9a45UhloutoXQzt4moo8j1oCBj9WeKGQNPZcFIa9/7o09a8Hvl7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791834505;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=O5kgUBmtQ3ZerZPN8vvqkKvCiMqUgBrDMncPLP6cSPo=;
 b=cV81PC6SmrFzUhO/F3aNXgQzY+wjvbXISUxcWt0eoWYIMotJiTVRAw3R4ZN5YFX0YkWS
 Rnik4ydZsjxjHfGJQ3nejIMXskwm4P1pGbMs0gBZKZd/RFiXsxnL/X/RWUvkFxU2KrHs8
 9ySh/fq3qaGAB1aApOtaOE8Se8uqP/cUEIj5iXM87miYlHZF6wKVuWzNp9vPYBMZ1HT7G
 HHZJ5CvsUMXW6ozGdVcUqoFJ2Zjsyc2Jr+vnwRRjjJzxtyNpscPiUT+Q9qujYMOnUCfek
 CsnYhS3HISsBfoJWbijHwq94Uhy5PEnHJHAMFyTzjCjm1e/AbNU+sgXKdTATtcnJFpw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=a7dz7z3S; 
 arc=none smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=dima.ruinskiy@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=a7dz7z3S
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B01754002B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 19:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791834505; x=1823370505;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=u0kNLlOJ+sUjM3a5q0fYbcCvARDb2rpFJMvnXcKBeZU=;
 b=a7dz7z3SZ7+Qumysx2X6O7W5im+1zW8LOgppMg9qgDYur5bDpzWOYEU1
 a6qwI0gevvnrAlHIHWlWYkYbRjGVkyGpFjiBbEI12zrWtLWv0Mc8qVyLh
 5o0AbJPOf056j4aGtigQWyHqOWLv+0abY9iiAwXAoSVOqlH3coYjt6duz
 FmLDitmRuTVwpO+TqB3LDwGuH8lvqtD5XAfa6iGwDuJIb4k9EZTTMhBrm
 m0qIqmg5RBinNXp0cnjYj020nLlElwFLN67g3JlGyGIQ6ib09HYiT89et
 56b/dKZs4xqAeoNbeXSUKT8a2068x7+WoxmdAxeYK9IgNv3RA4+u0wOuT A==;
X-CSE-ConnectionGUID: BbW275IiRtmEiR6vTGFtiQ==
X-CSE-MsgGUID: SLbZ/PdhRHSaM6uOcWOq3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="454309"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="454309"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 12:48:23 -0700
X-CSE-ConnectionGUID: dSr4TtNBRKGpZSDkPVc0aw==
X-CSE-MsgGUID: gf2E+6AlRqq0sAo8zqv8/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="882102"
Received: from ccdlinuxdev13.iil.intel.com ([143.185.161.17])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 12:48:20 -0700
From: Dima Ruinskiy <dima.ruinskiy@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: dima.ruinskiy@intel.com, anthony.l.nguyen@intel.com, allen.lan@intel.com,
 acelan.kao@canonical.com, kuba@kernel.org, horms@kernel.org
Subject: [PATCH iwl-next v5] igc: Support ACPI-based MAC passthrough
Date: Mon, 12 Oct 2026 22:48:17 +0300
Message-Id: <20261012194817.10409-1-dima.ruinskiy@intel.com>
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
when enabled, is intended to override the permanent MAC address of the
any network controller attached via a docking station. The purpose is to
allow the host PC retain its network identity in a corporate environment,
regardless of the specific docking station it is connected to. The
expectation is that only one docking station is attached at a time, or
that only a single network controller is plugged in at a time.

Implement seamless passthrough of the system MAC address to the
I225/I226 network controller, by looking up the relevant ACPI object names
and using them to initialize the MAC address. Limit the lookup only to
controllers that are Thunderbolt-attached, as these are the only docking
stations that can pass through an I225/I226 controller to the host.

On systems where the feature is disabled or unsupported, the ACPI objects
do not exist or do not contain a valid Ethernet MAC, the default MAC
address of the device is used.

Assisted-by: GitHub-Copilot:claude-opus-4.7
Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
---
Change log
v4->v5:
	align MAC address to 2 bytes (required by helper functions)
v3->v4:
	use pci_is_thunderbolt_attached instead of device id check
	explicitly save permanent address when using passthrough mac
v2->v3:
	fix typo that introduced check reversal
v1->v2:
	limit scope to dock device ids
---
 drivers/net/ethernet/intel/igc/igc_main.c | 70 +++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index f6d1ee75627d..d51e9bcdfc3e 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c)  2018 Intel Corporation */
 
+#include <linux/acpi.h>
+#include <linux/hex.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/if_vlan.h>
@@ -7134,6 +7136,58 @@ static enum hrtimer_restart igc_qbv_scheduling_timer(struct hrtimer *timer)
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
+	u8 buf[ETH_ALEN] __aligned(2);
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
+		    obj->string.length != sources[i].length ||
+		    !obj->string.pointer)
+			goto free_obj;
+
+		if (strncmp(obj->string.pointer, "_AUXMAC_#", 9) ||
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
+		ACPI_FREE(obj);
+	}
+
+	return mac_found;
+}
+
 /**
  * igc_probe - Device Initialization Routine
  * @pdev: PCI device information struct
@@ -7300,6 +7354,22 @@ static int igc_probe(struct pci_dev *pdev,
 		/* copy the MAC address out of the NVM */
 		if (hw->mac.ops.read_mac_addr(hw))
 			dev_err(&pdev->dev, "NVM Read Error\n");
+
+		/* For devices behind a Thunderbolt/USB4 dock, look for a
+		 * system-provided MAC in the ACPI table
+		 */
+		if (pci_is_thunderbolt_attached(pdev) &&
+		    igc_get_acpi_mac_passthru(hw->mac.addr)) {
+			/* Set the permanent MAC address. Leave blank if invalid to
+			 * reflect there is something wrong with the NVM MAC.
+			 */
+			if (is_valid_ether_addr(hw->mac.perm_addr))
+				ether_addr_copy(netdev->perm_addr, hw->mac.perm_addr);
+			netdev->addr_assign_type = NET_ADDR_STOLEN;
+			dev_info(&pdev->dev,
+				 "Using ACPI pass-thru MAC addr %pM\n",
+				 hw->mac.addr);
+		}
 	}
 
 	eth_hw_addr_set(netdev, hw->mac.addr);
-- 
2.55.0

