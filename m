Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34918FD0048
	for <intel-wired-lan@archiver.kernel.org>; Sun,  1 Mar 2026 01:28:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C7E1684035;
	Sun,  1 Mar 2026 01:28:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aSQfZQjqQElc; Sun,  1 Mar 2026 01:28:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B3A5684034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772328514;
	bh=Qj9kZ8wRFt/8kE7AV7nFBJoS3Fhh4ZS6ddJEhtcB1Uo=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wpRWPQ/KZh0TLZjQs+WsVbEc8LO3t98qtFoMrToUqMhCBl2yFHXUmw0WmxE6Ad8cZ
	 /frtOz9+ZJ0x87a30zL5UfdUx63xxXIb9orOVXA24GH5xQ81LCiu/Tq3oO4CRHyNCZ
	 EG4l9TdIh5o36GiKJlhupDnwNyvTSNhuUkjK0h1RgMYE261UcttRku9rUeBRtLgYe0
	 kv9+wmfoBicjU6BFYRFeD9uEqfVB+mNEyO8CjWCI0qwlPbVqyMnRYOO5McCsj4UyGG
	 yIvdi0Ah62uUGxJTXI9pIzm3fOy+6y1bbSs04b/HkkYXLmU0eQhK4XCKVd/Z0a+dWt
	 FoO9hcT8Ig8ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B3A5684034;
	Sun,  1 Mar 2026 01:28:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 49FB624E
 for <intel-wired-lan@lists.osuosl.org>; Sun,  1 Mar 2026 01:28:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3BA7C40E76
 for <intel-wired-lan@lists.osuosl.org>; Sun,  1 Mar 2026 01:28:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C8eiaXfBWLTk for <intel-wired-lan@lists.osuosl.org>;
 Sun,  1 Mar 2026 01:28:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 522E1403D0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 522E1403D0
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 522E1403D0
 for <intel-wired-lan@lists.osuosl.org>; Sun,  1 Mar 2026 01:28:33 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A5E2460008;
 Sun,  1 Mar 2026 01:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A743C19421;
 Sun,  1 Mar 2026 01:28:30 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	enelsonmoore@gmail.com
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Date: Sat, 28 Feb 2026 20:28:29 -0500
Message-ID: <20260301012829.1686242-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1772328511;
 bh=Q5DiCW9on0G/BrAWD39bQXl0ueMsoCMGKvy2MK32ZI8=;
 h=From:To:Cc:Subject:Date:From;
 b=bvydk6QKBibZ1IeyOi1o/at42rVPsvpUDpmmZjzczeFPII1egbKENfVG21FUqq7mE
 5JtVxGBOFNCVTVfjdzCpPFPBeYwMpxMIeTOB5oRl4HqNm/VykugMTTcnq9cxZPAyuF
 xt6jxeWVXWhCXjb5ulIp7CWUA2MgTzsaFHQuwTTDwvqo8Qa1GNMSHp10Ah//gyjCOm
 PHp1E346hF8OmgMYZoWD9S9CqEPVoiQgIXmf0UfE9fMSNN2gNs+m95Iq0TE91jAq4I
 23KmNb2WJE2LTSxbbm1Un9k4+op0i8HZeQDHUp+p0E4fEoZGFsXOWxXMl3JNbqw9wh
 iWkxtXFeV6dgg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=bvydk6QK
Subject: [Intel-wired-lan] FAILED: Patch "net: intel: fix PCI device ID
 conflict between i40e and ipw2200" failed to apply to 6.12-stable tree
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d03e094473ecdeb68d853752ba467abe13e1de44 Mon Sep 17 00:00:00 2001
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 9 Feb 2026 18:12:34 -0800
Subject: [PATCH] net: intel: fix PCI device ID conflict between i40e and
 ipw2200

The ID 8086:104f is matched by both i40e and ipw2200. The same device
ID should not be in more than one driver, because in that case, which
driver is used is unpredictable. Fix this by taking advantage of the
fact that i40e devices use PCI_CLASS_NETWORK_ETHERNET and ipw2200
devices use PCI_CLASS_NETWORK_OTHER to differentiate the devices.

Fixes: 2e45d3f4677a ("i40e: Add support for X710 B/P & SFP+ cards")
Cc: stable@vger.kernel.org
Acked-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Link: https://patch.msgid.link/20260210021235.16315-1-enelsonmoore@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c  | 8 +++++++-
 drivers/net/wireless/intel/ipw2x00/ipw2200.c | 8 +++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d3bc3207054f9..02de186dcc8f5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -75,7 +75,13 @@ static const struct pci_device_id i40e_pci_tbl[] = {
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_BASE_T4), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_BASE_T_BC), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_SFP), 0},
-	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_B), 0},
+	/*
+	 * This ID conflicts with ipw2200, but the devices can be differentiated
+	 * because i40e devices use PCI_CLASS_NETWORK_ETHERNET and ipw2200
+	 * devices use PCI_CLASS_NETWORK_OTHER.
+	 */
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, I40E_DEV_ID_10G_B),
+		PCI_CLASS_NETWORK_ETHERNET << 8, 0xffff00, 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_KX_X722), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_QSFP_X722), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_SFP_X722), 0},
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
index 09035a77e775f..b0e769da94156 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
@@ -11387,7 +11387,13 @@ static const struct pci_device_id card_ids[] = {
 	{PCI_VENDOR_ID_INTEL, 0x1043, 0x8086, 0x2754, 0, 0, 0},
 	{PCI_VENDOR_ID_INTEL, 0x1043, 0x8086, 0x2761, 0, 0, 0},
 	{PCI_VENDOR_ID_INTEL, 0x1043, 0x8086, 0x2762, 0, 0, 0},
-	{PCI_VDEVICE(INTEL, 0x104f), 0},
+	/*
+	 * This ID conflicts with i40e, but the devices can be differentiated
+	 * because i40e devices use PCI_CLASS_NETWORK_ETHERNET and ipw2200
+	 * devices use PCI_CLASS_NETWORK_OTHER.
+	 */
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x104f),
+		PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, 0},
 	{PCI_VDEVICE(INTEL, 0x4220), 0},	/* BG */
 	{PCI_VDEVICE(INTEL, 0x4221), 0},	/* BG */
 	{PCI_VDEVICE(INTEL, 0x4223), 0},	/* ABG */
-- 
2.51.0




