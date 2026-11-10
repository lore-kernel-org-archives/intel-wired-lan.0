Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389A5606A325
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 06:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=zMbTMUJa;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CawsGDSs
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0FDD680FB5;
	Tue, 10 Nov 2026 06:26:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0vE2bfFme7em; Tue, 10 Nov 2026 06:26:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EB48580F5C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794291995;
	b=aHNRLGVqWOL5oNSFWOUpXIgn9ss5B6taMuyCoAcE9DcnKs8fbzQQZZnkXaA/KED3v5BE
	 uGAh/prSZ3HayhamBJ+cdEtzxZETkpnfgl5gENp2Ko4mV1rSrE43VyZD8/RBzlwKcAa3/
	 MXqRhSEtZVrFudmpsXyuGdEffJ4SRTjz1bKn88eRBsPX6JnD6MFmmmbk6dTPzdFYpWmxa
	 acCRPSvJ0UbuudozjDwHMwdJ/+lv0eWVODGruTDH5ktllUgYdsMJyvRQMdOI5USG+Q7Ik
	 +yxWgmfGKl5uE1c0bo8+tsrZxVWPIjT0rKUUS3Naowbk5dCqLEmqYksaEdSTwKZd7dA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794291995;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oKvhQdlmyU8cbBHUZLAQB3dkciqsGQQ8nvZbNqziVrc=;
	b=b6+L6FCZzlvOA0L8nDNvPIy/lh6eC1+mhMkqPxzyuM1Jn84TTxjNIhJnM/NIepCfI33v
	 Aybhb5TjxFAT38IRpXhxQSIV0K/C+dnsEiJWIXdueYhFrArBYiwrrditJm9/pDF02Tzmg
	 CjPZzqy9ecxSCLa6yjkBLu7SvgUkwtugRwZjZrlEXLwdXyDhL2/X3LBN8Vs0bVxqoBt2k
	 poA7Q2f0tP2a0xru2lF0CIFCwh7O1VcYgsDDtR5z2ObWybfYCcSATrUCQoUTc6xhRlspg
	 wJhBVIl7InEe5ussTTalHpwHxSxQ/5FoyDDfq9EOrChyBgt5kP38c81v+LOJ7h5GK2g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CawsGDSs;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794291995;
	bh=oKvhQdlmyU8cbBHUZLAQB3dkciqsGQQ8nvZbNqziVrc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zMbTMUJaA5c+gVEwp2KpqSda4RdcacK4ZySjXOnUTdTQ6vwRf1hS53vu9m1dAO2bD
	 VJrSvDo1u5JzNG0MUeOwDIGBQVvwqe8nveaMgsoAbMdtraiHFKBFaC3qXXWFAhFwOP
	 ZFXBicTaM7LMudRPKnzPiq3DtsLAuw03xYb05CZGVVa54Mow4gZ+uLTYCrYg3K/F+E
	 Rs6K1TtFIT32f9RxXdgW6jLK0WZ00LE++3J5Z7pC89YOC6vAIhCZOnAYosxy4sL0TP
	 L43GF5s+/ufX6zRVswOHv0DC9J92nSzbbL4RZbJ4hHVLa0zq9FGqsdaCfeRp3eWJzs
	 ZtMe4Cadoh1Ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB48580F5C;
	Tue, 10 Nov 2026 06:26:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 799C34B8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 06:26:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6AFD980F5C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 06:26:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8jNFC4ZTj1nZ for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 06:26:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 55B8C80F48
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=yifan2.li@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=CawsGDSs
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 55B8C80F48
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 06:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794291993; x=1825827993;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=WJ29dS6C9oitKWR92y4jzuIZaytkUqpFhiLPrPhz5kE=;
 b=CawsGDSsm7TBJ+ZQcFXBQtLNT7pB84is+KjxZorVuVBGjjch0yFq7fHJ
 IabC0II6EOdpcFC24E5bt0E+QP7+fBY/UB7NZp+/QjXC3AacIbBaeDJ8J
 GO8wWYzr9/EAE2SuMmtNsjiqVla+aObFp4T8dIRqxGIXnnYpUMcl762XL
 eLSveMSbHQTCJYoCgoi1YMJMzF8omI5SLXibMGQpDZR2mV5b1yz9z85Hh
 46T+qJfQoJZmNK5JemljS+4dVdBenjiTCAEGUl97D7nIZSb4ds0UdYrLQ
 R0Rw0o9dYgEft7u72V4e8JNbcK7FisSQzv/P87oxzFKju9qH0ZioR0vaw w==;
X-CSE-ConnectionGUID: Gu53UrVPTKS2fA94Qh1WOQ==
X-CSE-MsgGUID: 6X/uchHnR6yfq4SA5w+sAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2931883"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="2931883"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 22:26:31 -0800
X-CSE-ConnectionGUID: ktim06GRT6ScK9ed0WPx+Q==
X-CSE-MsgGUID: dCt1uj24TBKTFI/E+YO5EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8048139"
Received: from liyifan1-desk.bj.intel.com ([10.238.152.46])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 22:26:26 -0800
From: Li Yifan <yifan2.li@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Dima Ruinskiy <dima.ruinskiy@intel.com>, Li Lili <lili.li@intel.com>,
 Wang Jie <jie.wang@intel.com>
Subject: [PATCH iwl-net v2] igc: Disable PTM after the last device reset on
 remove
Date: Tue, 10 Nov 2026 14:20:51 +0800
Message-ID: <20261110062051.2730678-1-yifan2.li@intel.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

After a PTM dialog, I225/I226 can send a PTM Request at the next device
reset through the RST bit of the device-specific CTRL register
(CTRL.RST). The device sends it even when the PTM Enable bit in its PTM
Capability is clear. This is a hardware defect: a PTM Requester is
permitted to request PTM Master Time only when PTM is enabled (PCIe
r7.1 sec 6.21.3.1). The EN bit of the device-specific PTM_CTRL register
is also clear at that time, so the driver has no control that stops
the request.

The request is harmless while the upstream port has PTM enabled. Since
commit e1092d5e15e6 ("PCI/PTM: Do not enable PTM automatically for Root
and Switch Upstream Ports"), pci_disable_ptm() also disables PTM on the
upstream port when the last user goes away. igc_remove() calls
pci_disable_ptm() before unregister_netdev(). If the interface is up,
unregister_netdev() then resets the device through igc_close() ->
igc_down() -> igc_reset(). The upstream port now handles the PTM
Request as an Unsupported Request, as the spec requires (sec 6.21.3).
On an Intel Nova Lake-S system with an I226-LM, this triggers DPC on
"modprobe -r igc". Recovery fails because the driver is unbinding, and
the next probe fails:

  pcieport 0000:80:1d.0: DPC: containment event, status:0x1f01: unmasked uncorrectable error detected
  pcieport 0000:80:1d.0:    [20] UnsupReq               (First)
  pcieport 0000:80:1d.0: AER:   TLP Header: 0x34000000 0x81000052 0x00000000 0x00000000

Message code 0x52 in the TLP header is a PTM Request from 81:00.0.

Call pci_disable_ptm() after the last reset of the device, so that the
upstream port still has PTM enabled and responds to the request. If the
interface is down, unregister_netdev() does not reset the device, so
reset it explicitly. Skip this reset if error recovery is in progress
or has failed, as igc_down() does before igc_reset().

Tests on an I226-LM show that this reset also clears the state: the
device sends the request only at the first CTRL.RST after a PTM dialog,
so a later reset sends nothing unless a new dialog runs.

No new dialog runs after this reset. The PCIe spec makes the mechanism
that starts a PTM dialog implementation specific (sec 6.21.3.1), so a
device can start dialogs at any time while PTM is enabled. I225/I226
start a dialog only when PTM_CTRL.EN is set and the driver sets the
TRIG bit in PTM_CTRL (the "PTM trigger mode" in commit 8e404ad95d2c
("igc: fix PTM cycle trigger logic")), or in an automatic cycle mode
that igc does not use. The request at CTRL.RST is the only exception
that we know of. igc sets EN and TRIG only in the PTP code, and
igc_ptp_stop() runs before the reset:

  - igc_ptp_suspend() -> igc_ptm_stop() clears PTM_CTRL.EN.
  - ptp_clock_unregister() removes the PHC and waits for the
    igc_ptp_getcrosststamp() calls in progress, so no new TRIG comes.
  - IGC_PTP_ENABLED is cleared, so igc_ptp_reset() returns early in the
    reset path and does not set EN or TRIG again.

pci_clear_master() stays where it is, so PTM Enable is now cleared
after bus mastering is disabled. This keeps what commit c080fe262f9e
("igc: Fix possible system crash when loading module") needs: the
device starts no PTM dialog while bus mastering is disabled, because
PTM_CTRL.EN is already clear.

Fixes: e1092d5e15e6 ("PCI/PTM: Do not enable PTM automatically for Root and Switch Upstream Ports")
Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Co-developed-by: Li Lili <lili.li@intel.com>
Signed-off-by: Li Lili <lili.li@intel.com>
Signed-off-by: Li Yifan <yifan2.li@intel.com>
Tested-by: Wang Jie <jie.wang@intel.com>
---
v2:
- Call CTRL the device-specific CTRL register. Describe the defect as a
  PTM Request with PTM Enable clear, and remove Bus Master Enable from
  the description of the defect (Bjorn).
- Leave pci_clear_master() where it is and move only pci_disable_ptm()
  (Bjorn). Retested this order on the I226-LM (v7.2.7 with the same
  change): reload x20 with the
  interface up; unload with the interface down or never up, then a
  manual CTRL.RST (no PTM Request); S3 and s2idle; unbind/bind;
  remove/rescan; runtime suspend; reload in parallel with S3 for 10
  minutes. No DPC.
- Explain why no new PTM dialog starts after the reset, and that
  starting dialogs only on TRIG is device-specific (Bjorn).
- Add PCIe r7.1 references for the defect, the Unsupported Request at
  the upstream port, and the dialog trigger.
- Keep only the pci_channel_offline() check before the reset (Bjorn).
- Drop the pcie_ptm_enabled() check before pci_disable_ptm(). The PCI
  core fix [1] (applied to pci/ptm for v7.5) handles a failed
  pci_enable_ptm() for all drivers. Without [1], this is the same as
  the current code, which also calls pci_disable_ptm() without a check.
- No erratum covers the PTM Request at CTRL.RST yet. I reported it to
  the I225/I226 hardware team and waiting update now. I

[1] https://lore.kernel.org/r/20261104121457.2108515-1-yifan2.li@intel.com

v1: https://lore.kernel.org/r/20261031021928.1714612-1-yifan2.li@intel.com
---
 drivers/net/ethernet/intel/igc/igc_main.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 62a7c5178700..712b6db8e31b 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7428,7 +7428,6 @@ static void igc_remove(struct pci_dev *pdev)
 
 	igc_ptp_stop(adapter);
 
-	pci_disable_ptm(pdev);
 	pci_clear_master(pdev);
 
 	set_bit(__IGC_DOWN, &adapter->state);
@@ -7449,6 +7448,17 @@ static void igc_remove(struct pci_dev *pdev)
 	igc_release_hw_control(adapter);
 	unregister_netdev(netdev);
 
+	/* After a PTM dialog, I225/I226 can send a PTM Request at the next
+	 * CTRL.RST, even with PTM disabled on the device. Reset the device
+	 * while PTM is still enabled on the upstream port, so that the
+	 * request gets a response. unregister_netdev() resets the device
+	 * only if the interface was up. Then disable PTM.
+	 */
+	if (!pci_channel_offline(pdev))
+		adapter->hw.mac.ops.reset_hw(&adapter->hw);
+
+	pci_disable_ptm(pdev);
+
 	igc_clear_interrupt_scheme(adapter);
 	pci_iounmap(pdev, adapter->io_addr);
 	pci_release_mem_regions(pdev);

base-commit: ca719d9d18e87e63f672fe6f0bcd53ad68b9248a
-- 
2.43.0

