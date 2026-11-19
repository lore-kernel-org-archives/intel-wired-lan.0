Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AB7606A332
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 22:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=7Z73IEa+;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=gM/kRzJl
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 97E978153D;
	Thu, 19 Nov 2026 22:15:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w74iC7dgfjOo; Thu, 19 Nov 2026 22:15:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DCAAD81517
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795126558;
	b=DyMLItrvpxeXrd68cWCkvwTD/4fHZCRfiD5POD4t8kYxLozj5I+V5X2QtwGlDgqpbc9I
	 phxQV+6atFuQ3fEbr7GP+cK+tQGXv1JCvFQo+J9RUBlBzSTZKcT4KtyD4nSv9gbOLL2JU
	 MARirXzhb8mzg11Fz6qBatwdceGj3J8qsrN9jLTJ6sTWpcwBFzDXTAiNy82cE6VJ74lAf
	 blX/7/HcJfca99VCref6JlLHfqsJlDw4o91rl0GVAliiPNm5J2/uzx7F50DGTjPoOXsrj
	 s7sBlPI/RIIGmr6quAAGAQ2aZMZenJ1oKO13WRBH83Wh9rzSQXoB33HzvPGmWsj3jVw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795126558;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 Received:Received:X-Farcaster-Flow-ID:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=rG8ySpd1iW2MeECK/3VoVBb77o8GMUNj0ctIINg/L10=;
	b=CMhoFnR9WIKMMz0apQ+ykvNS1OqDa29NRu0WBk2GCP6qt0XvtzamOgVi7YkNzzCh2/mG
	 bqiZ+SpMqw5aRZkYZ8xXVFElkQnU3xRX642O8XTE6OYWGDAKd8kRZBNU773f5tTZYTAlR
	 VcUwbcGNodo5cmPOqj31hGxh/XBpxLd6L6NlFCHk1D5J9dMy+tFKdtyhtqZF6AtYJ2CUL
	 ARwXhebnBSOKL5JZ4fxiyQyIdsn6I3fa2EU0n1eMkiwiwkedx/DFF89+h65YnJBEm7XT7
	 jJu34tNltOt/m5/S2zmobgdFKTaVgP/asOfWH6I0BpSE/7YOQdYl1NgViYcp619bJ+Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b="gM/kRzJl";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795126557;
	bh=rG8ySpd1iW2MeECK/3VoVBb77o8GMUNj0ctIINg/L10=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=7Z73IEa+NO8pij2PfRMo4MONU6fbgc5ICofQ8/tt94JhFwdNUxbqzNpXVMpO4KyiN
	 s/uvxvGLCFiwnG46S/8OHoP69kAr8cD4dL01Zd50dOtp08UVKdjKz1WPZ1nXtwldx7
	 Z3m9PL+pkYKUSvkzKgRZwwJJmRf0TWIP5LXZ7jO1jcPl/YyBejWfir2O2wR2ZF9JBR
	 z+XrV/V3SDRi1vglyKnNi+XjmFgyCvFv7uRecfWMIYpX4+vFO0Be53ZKkMBHuahcWm
	 iPnfstkxHfwcHvuE2oPh5hvr+KGqFGn1x6hMskEjUNmty4jVvyyj8SoQbU+rIwAO56
	 u3j0gqE0Ie+KQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DCAAD81517;
	Thu, 19 Nov 2026 22:15:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 76A9579D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 22:15:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 685EF81517
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 22:15:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hywwqy6uXwxz for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 22:15:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 13DA181511
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=52.35.192.45
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=52.35.192.45;
 helo=pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com;
 envelope-from=prvs=77621aad0=hagan@amazon.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=amazon.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256
 header.s=amazoncorp2 header.b=gM/kRzJl
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 13DA181511
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 22:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1795126555; x=1826662555;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=rG8ySpd1iW2MeECK/3VoVBb77o8GMUNj0ctIINg/L10=;
 b=gM/kRzJl42wO5hXnT0m9O9ENu7wPGWiS0mAXF+FW/KMliaUU1BiMlfb6
 eGp6ld3/vgrikiXYq6zHaZEVJiJngHHyUj84LswZ5ucPLRb9hStN+uwVk
 i09bH+ZW/yleflb90pvO4Aub5nZaWHOD5/PuHrRR0bHRauMJlk4qyo/pU
 8QuI98m8hU/z7i6scoUU3W7BaxvnYL7sQ37SUABSIrhtugYrSEbWcGft8
 BNmocvFv1WnizxJoE+Eduxg1RgxHnFUIvSieuO0HuagSG5g8Q6aKEr1ru
 z/LWKnEAudcuGqQbnNT/tI5JGGMvRSFbn8/68+5EcMrg6cUH1JhnW54Tc w==;
X-CSE-ConnectionGUID: zr3KRbncQK+kEcd2VcYiNw==
X-CSE-MsgGUID: fFSXlcqnS2eFb3UN2TslBA==
X-IronPort-AV: E=Sophos;i="6.27,221,1787011200"; d="scan'208";a="34359087"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 22:15:53 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:16723]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.128:2525]
 with esmtp (Farcaster)
 id f584f67a-9e5d-41c7-b791-57426c59856d; Thu, 19 Nov 2026 22:15:53 +0000 (UTC)
X-Farcaster-Flow-ID: f584f67a-9e5d-41c7-b791-57426c59856d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 19 Nov 2026 22:15:52 +0000
Received: from dev-dsk-hagan-1f-c6b5e25f.us-east-1.amazon.com (172.19.159.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Thu, 19 Nov 2026 22:15:51 +0000
From: "Craig I. Hagan" <hagan@amazon.com>
To: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>, 
 <tactii@gmail.com>, <aleksandr.loktionov@intel.com>,
 <moriyax.kadosh@intel.com>, <vitaly.lifshits@intel.com>, <hagan@amazon.com>
Subject: [PATCH iwl-net] e1000e: fix link stuck at 10 Mb/s after DMoff exit
Date: Thu, 19 Nov 2026 22:15:48 +0000
Message-ID: <20261119221548.10466-1-hagan@amazon.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On an I219 (pch_spt+), a link outage of more than a few seconds (e.g. a
switch reboot) can bring the MAC back in DMoff, with the STATUS speed bits
reading 0. If DMoff has already ended by the time the watchdog runs, the
speed bits can still read 0. The watchdog decodes them as SPEED_10, and the
link stays at 10 Mb/s Full while the PHY is at 1000 Mb/s Full.
rx_crc_errors climb and jumbo traffic stalls until the interface is
manually reset. Seen on deployed machines and reproduced on an I219-LM
(8086:15b7).

The patch "e1000e: restore jumbo config after DMoff exit"
(https://lore.kernel.org/netdev/20260928210552.13266-1-hagan@amazon.com/)
handles DMoff that is still set when the watchdog runs. The watchdog
cannot detect the case above on its own, because STATUS then reads the
same as a real 10 Mb/s Full link.

Record DMoff (PCIM_STATE) in the link status interrupt, next to
mac.get_link_status, and have the watchdog's existing DMoff wait loop
start as if it had seen it, so it takes the same full-reset path.

This depends on that patch. Without it the loop ends in a bare PHY
reset, which clears the 10 Mb/s but not the jumbo configuration.

The unpatched driver stuck at 10 Mb/s on an I219-LM (8086:15b7) when
the switch port was shut for 90 s or the switch power cycled, behind a
Cisco C9200-48P and a TP-Link TL-SG108PE. Reproducing it needs no
kernel change. A debug build that logs STATUS was used to find the
cause, and the patch was tested on the same hardware and switches.

Fixes: def4ec6dce39 ("e1000e: PCIm function state support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Craig I. Hagan <hagan@amazon.com>
---
Please keep this patch and "e1000e: restore jumbo config after DMoff
exit" (queued in net-queue dev-queue) together, in that order, when
they go to net and to stable. Without it, this patch ends in a bare PHY
reset: the link no longer sticks at 10 Mb/s, but the jumbo
configuration is still not restored.

This was seen on deployed machines running the stock Ubuntu 5.4.0-117
driver behind Cisco C9200-48P switches, on both IOS-XE 16.12.3a and
17.9.4a. After a switch reboot, ethtool reported 10 Mb/s Full while
mii-tool showed the PHY at 1000 Full, and rx_crc_errors kept climbing.
One machine stayed in that state for about a week.

On the bench, the unpatched driver on 5.4.0-117 (HZ=250) was logged
across 16 link-ups, each after the switch port had been shut for 90 s.
All 16 read 0x40080003 in the link status interrupt, and in 2 of them
DMoff had already ended by the time the watchdog ran:

  link status interrupt   0x40080003  DMoff, link up, FD, speed bits 0
  watchdog, +14.6 ms      0x00080003  DMoff over, speed bits still 0
  about 100 ms later      0x00080083  1000 Mb/s Full

With the unpatched driver, the link stuck at 10 Mb/s in 2 of 10 outages
behind the Cisco and in 2 of 20 behind a TP-Link TL-SG108PE V3, both on
5.4.0-117 at HZ=250. On 6.17.0-19 and 7.0.0-14 rebuilt with only
CONFIG_HZ changed to 250 (the Kconfig default), it stuck in 2 of 10
outages on each. At HZ=1000 it did not stick: in the logged runs the
watchdog always found DMoff still set, so the existing DMoff handling
ran. The difference comes from HZ, not the kernel version.

Behind the Cisco, every outage that stuck at 10 Mb/s also dropped jumbo
traffic: 8972-byte pings were lost while small pings passed. On
7.4.0-rc2 built from the same dev-queue tree without this patch (HZ=250,
Cisco on 17.9.4a), 2 of 10 outages instead ended at 1000 Mb/s with jumbo
traffic dropped until "ethtool -r". Neither of those two got a full
reset before link-up, and the full reset is what restores the jumbo
configuration ("e1000e: restore jumbo config after DMoff exit"). With
this patch, all 26 trials there got the full reset and passed jumbo
traffic.

With this patch, every reset and link cycle ended at 1000 Mb/s Full
with 8972-byte pings passing. Each cycle cut power to the switch for 5 s
to 4 min, or shut the port for 90 s. The port-shut cycles behind the
Cisco also ran under 200 Mb/s of jumbo traffic.
That covered 50 cycles on 5.4, 129 on 6.17, 404 on 7.0 and 29 on
7.4.0-rc2 (40 each on 6.17 and 7.0 and all 29 on 7.4.0-rc2 at HZ=250),
behind both switches. The new path was taken 21 times at HZ=250, 5 each
on 6.17 and 7.0 and 4 on 7.4.0-rc2, and never at HZ=1000.

 drivers/net/ethernet/intel/e1000e/hw.h     | 1 +
 drivers/net/ethernet/intel/e1000e/netdev.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/hw.h b/drivers/net/ethernet/intel/e1000e/hw.h
index c7ac599e5..efb945590 100644
--- a/drivers/net/ethernet/intel/e1000e/hw.h
+++ b/drivers/net/ethernet/intel/e1000e/hw.h
@@ -604,6 +604,7 @@ struct e1000_mac_info {
 	bool autoneg;
 	bool autoneg_failed;
 	bool get_link_status;
+	bool dmoff_at_lsc;
 	bool in_ifs_mode;
 	bool serdes_has_link;
 	bool tx_pkt_filtering;
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index c3e944ee4..47a6964fa 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -1785,6 +1785,7 @@ static irqreturn_t e1000_intr_msi(int __always_unused irq, void *data)
 	/* read ICR disables interrupts using IAM */
 	if (icr & E1000_ICR_LSC) {
 		hw->mac.get_link_status = true;
+		hw->mac.dmoff_at_lsc = er32(STATUS) & E1000_STATUS_PCIM_STATE;
 		/* ICH8 workaround-- Call gig speed drop workaround on cable
 		 * disconnect (LSC) before accessing any PHY registers
 		 */
@@ -1864,6 +1865,7 @@ static irqreturn_t e1000_intr(int __always_unused irq, void *data)
 
 	if (icr & E1000_ICR_LSC) {
 		hw->mac.get_link_status = true;
+		hw->mac.dmoff_at_lsc = er32(STATUS) & E1000_STATUS_PCIM_STATE;
 		/* ICH8 workaround-- Call gig speed drop workaround on cable
 		 * disconnect (LSC) before accessing any PHY registers
 		 */
@@ -5302,6 +5304,9 @@ static void e1000_watchdog_task(struct work_struct *work)
 			/* Checking if MAC is in DMoff state*/
 			if (er32(FWSM) & E1000_ICH_FWSM_FW_VALID) {
 				pcim_state = er32(STATUS);
+				/* DMoff may have ended since the LSC */
+				if (mac->dmoff_at_lsc)
+					pcim_state |= E1000_STATUS_PCIM_STATE;
 				while (pcim_state & E1000_STATUS_PCIM_STATE) {
 					if (tries++ == dmoff_exit_timeout) {
 						e_dbg("Error in exiting dmoff\n");

base-commit: 6055ab4d82e42de89871db03045b568ed706ef50
-- 
2.47.3

