Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B39C79FBF
	for <intel-wired-lan@archiver.kernel.org>; Thu, 10 Sep 2026 19:38:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B07B640AB6;
	Thu, 10 Sep 2026 19:38:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cilDd5z2nqVz; Thu, 10 Sep 2026 19:38:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0189C40AB9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789069114;
	b=ZfGATvhvKIUhvLk+2PElhnqBDEfruvlGnjCEmVI6lm2EZSLJLtkUqIv8g2tvTkQTCEPT
	 vTg5okuNRTQuCdLPvaIT5gOqIBMUV/yC/4XrG3BobjLBb5Gy5cIQKH5loIBlHn6K0fF0Z
	 pHlPQuhmJ4k6hAx09Afx3xlUEIy+my854wds7/gC3oTJHIHTrXeCQs4rAPIt4dTJRMFbd
	 CVL03SkqnLq9eCxpNkX5wIKYiwVOMGrKfFGLVAq93bdPRSw+1ZjABaR0tAK1RY1Wb21HF
	 75I8WYBgRvcI4MeDVPJiURBT0iUuRbLbRjDz/QAJgj0Uh6wqNOXCDOJavvbAeBuO/lA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789069114;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=i+jrb+MwJqH68LAdiqA4Zzq+DvUqgNbBz5HBHxlczL0=;
	b=aA0TW90ZV1sHb9zUqG7SLptjaV4BBuh+/vIPpzSf6LSAFn09mBY6JMIBihBFww90bGGS
	 xkfos2wOeirW9cZupZdOUIg08nkBsc9frvEcZ1KmmeJtvX/76n/R4hUhDbBPqJAkFQ3sA
	 KVYkyLj5s7LMXIjBsFLIRhxVvrFnN6+kJHS4ea/HdiF59ZW53KRZUYbuGc/H8wHaaZClT
	 +lG6mrV/WYLlgn3qiYxBNW8AnAdwm88uCkP8tCloN04LnC/iG7WF8+QzMFErQ8/6gjp8l
	 GDiWMMDKZycnoJ9R5OTxBF/hlvIRTtFcXGwRP7ABVOKOxLFVjwq9i0Ub/yUJcIxeV7Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789069114;
	bh=i+jrb+MwJqH68LAdiqA4Zzq+DvUqgNbBz5HBHxlczL0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=4QlbGNvZWRiYmL5gQFKIk3/EqPZxJSkDaskk2XPu3wKg7suwj3hI9+5q5SBthr7u+
	 Jw5M8F1YpwzQIf0phuMz4XjabTMiRCHs1NTd7eqoQ3B6ViFDhERw7E9E/Kfvk1evYw
	 qB3yvvdBSnHlshMfABolPvuF+5fzuaP3ysgnhjtgrdORC9JRPBnXzjfA1Zy3APSmQY
	 R7rwVbCk5zSgsUk0aCCLZRq98hHdmaoo7OBH0Q1qp9Nn1E70eA9oBBW1cqt0cF+Fn5
	 m7En4VGCx5qSPXdSdgNZjzQpywoE2evRVON3z6HoMSfcZabRfzrknNNbivEEskPL/K
	 ihdFrPCJM997Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0189C40AB9;
	Thu, 10 Sep 2026 19:38:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 66BA1769
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 19:38:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5859F80EEC
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 19:38:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vAU7nn_x7Ydd for <intel-wired-lan@lists.osuosl.org>;
 Thu, 10 Sep 2026 19:38:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 72D8B80EEB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789069111;
 b=UBKCQ6H72D9Escti7weXKx0LEu7vyIXPvxEhN5Kvc+VMSelujNycLQo9EqPqJF3q43Ox
 FO2y/Esf4oGE7ecQzPQxxDhO8FAqB+UYnM9+A8kO30iGaqIXyofBpWbjr+aWitbBEcBjV
 wMKsayplGYD8IS5l0b1LXRdMLXJMvAW7Qa56NRL2fP0rVeKPOpvnfac7idres6BJ9VGxG
 QBPHwc2H+S6lF5Nfkqzqs30qCBefkTeQpOLgrfIOBqxDdOiIdlQ4+6YkiNHN451jTgTXi
 yeLn1QuVV0SXi6USCPDZ2YIAp0kmWXiXzzNjhvfQmQvoKtMV5pRR2gEl0L2+1aaV2+g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789069111;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=i+jrb+MwJqH68LAdiqA4Zzq+DvUqgNbBz5HBHxlczL0=;
 b=L9NWE9mbIDfb5v0Kt4XA+J5YuMMjCJRpMYWx51ACbkX4msG54Bh5lizHTd9GE8ujZiW4
 1/xdTniph6pNQM3K3fF/BMfc8N4dGwrE8fyiMaGwCOJThEAizdWrQPGv2ptxTDf5FVypn
 NO8BwY3ciA2EQaHLYxxc8Rp21xa+3MU9yR/Cfz5MqG8N+R7AwxirgNHae80yYatFYb6Wo
 g2+fvPva8cukum2SYwO32G2/buF00xujqU1StLgKif5cFb0BYwxNocZkIw9W8Jj8B/+pM
 Xk0O3CWZEntIwCbmmwYlior9taZsfsGYsBoRUPc4AQUmU/xPaO8nNuurPS7Tattq6HQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=dSF6feBA; 
 arc=none smtp.remote-ip=192.198.163.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=dima.ruinskiy@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=dSF6feBA
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 72D8B80EEB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 19:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789069111; x=1820605111;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=URzbeGQg/NoPkNl6O/IEsc/Hyptre/noxPW2YTadU3Y=;
 b=dSF6feBACcD+MOD04T1mnvb8pLk8mJjsGWs+CicqjG1gvWotfb2hi5T1
 X6DLI412eFsNAggafqjLWvL7mr+lJamvJ2S4V3uGJnBiVn7eFZ/PfQQTD
 Rkmf/LWhIuPkNI1le0YpMdQddBQeL7+NST74oytWHmsUy2egmuUoAects
 29Vj/VWL4H5Tq6mGRuU4oNC9w9YYw5NjGaBn+cJErYYfcHOWxFXuyRunH
 veNJmn5Mgks3VDuLGUlOFrrfjzHVnJax+vzAhx3c05QW0WXHQbxE4r2bu
 eBin1fgxUUHnvLoj54BI+FaUk5oT1iFyTqunWWbWt1XS8S5yeDXKBa9lH A==;
X-CSE-ConnectionGUID: huoxjYPhSgyuwvxESb8sEg==
X-CSE-MsgGUID: NDEtgylNQAqgXO+L333HeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="93356305"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="93356305"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 12:38:30 -0700
X-CSE-ConnectionGUID: BwsTX6s9S/SbdZX7N3vWYQ==
X-CSE-MsgGUID: 6f6qYrRdRHyD8tTPUNsnhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; d="scan'208";a="271703423"
Received: from ccdlinuxdev11.iil.intel.com ([143.185.162.70])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 12:38:27 -0700
From: Dima Ruinskiy <dima.ruinskiy@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, dima.ruinskiy@intel.com,
 anthony.l.nguyen@intel.com, allen.lan@intel.com, acelan.kao@canonical.com,
 kuba@kernel.org
Subject: [PATCH iwl-next v4] igc: Support ACPI-based MAC passthrough
Date: Thu, 10 Sep 2026 22:38:24 +0300
Message-Id: <20260910193824.3257378-1-dima.ruinskiy@intel.com>
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

