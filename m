Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEA8C61CE7
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Jun 2025 12:53:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5040F42038;
	Wed, 11 Jun 2025 12:53:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bRnAp0lXc782; Wed, 11 Jun 2025 12:53:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9C1E042096
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1749646382;
	bh=W+1qZnFIRYM45Zamdr2iPDX0osJGfhrsHr1ASxqz7CI=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rjVuXVtdvxOeYMt+EMkYdjiYRGDvmAOuerrRuVRcXuUHh9tT/TMacxbceAda9uQPO
	 a6yTn3MJQraN/VO1HC8mkr8891UmvsEkl/qPUygC7lDoVGwzzNsTOngoOZW5JKzxhf
	 2yWgUn1Sz4ad7wJ2MvO92lp8wSLhrSeZFEQukW7g0q5DD0DXl4dqYuiaEHhwGFeDRN
	 Paj2begkkhAIheGuIBmodjki5qJ1st0VjS5d5qFTNwIhQRQU5ROK1zkIsjZQgl9Nir
	 a5SCRfEW5zPd+ZxVaqdQkwRwQWKn31I6rWImyguXm0FKPwS9FMh2NX06hAS9KjYZ62
	 oczMQMEKtO3vw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C1E042096;
	Wed, 11 Jun 2025 12:53:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D599237
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Jun 2025 12:53:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8388F80D8A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Jun 2025 12:53:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EZmcSdIoeK8B for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Jun 2025 12:53:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=vitaly.lifshits@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7E39880DA0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7E39880DA0
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7E39880DA0
 for <intel-wired-lan@osuosl.org>; Wed, 11 Jun 2025 12:53:00 +0000 (UTC)
X-CSE-ConnectionGUID: NcD3+ndWTzCEiDPlL9YJXA==
X-CSE-MsgGUID: UmAFZ+L/Qdu8kW1dpRjWSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51651603"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; d="scan'208";a="51651603"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2025 05:52:59 -0700
X-CSE-ConnectionGUID: ugtYyrTBQ3i8s022TCti7A==
X-CSE-MsgGUID: 6zJ9qamiRcilvW58b1sgUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; d="scan'208";a="151973507"
Received: from ccdlinuxdev11.iil.intel.com ([143.185.162.51])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2025 05:52:59 -0700
From: Vitaly Lifshits <vitaly.lifshits@intel.com>
To: intel-wired-lan@osuosl.org
Cc: Vitaly Lifshits <vitaly.lifshits@intel.com>
Date: Wed, 11 Jun 2025 15:52:54 +0300
Message-Id: <20250611125254.3648822-1-vitaly.lifshits@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749646380; x=1781182380;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ZrENPsnFTQoZXfluWwt8R8ZSCrlmBRDZfrfRssD76AM=;
 b=K1KPezUMOxaQzqxgHDvR2zLjWnIa3Kq9UsIljn/h05BfIXxF9jVzeurg
 XqMqACSSOoqJ3KYxUxWkZFk3abSPY03vuctp/aJrmhyzH7Xm253BkpNVr
 evzbFC9nculFSRUwQi4PjjqQbgYrawk6T5e93QfcJGPUB9PSXVWkIORe9
 mEbHv7G6/Ekm7ue1tRY7b6qyNHsibOkQBbhBovmZu0/8CG/cATCPSMpYJ
 Z0TNsk9E5jUVuwyeLtzr5L32DCuLsqVB9XZlcHXP84JGcEhoiIHWM4/Pb
 NdCB9s6fM4cYQHK3K9ip3MFEaT5IHOgxytMGVvzadzDhzPpbIOHcWb8Yw
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=K1KPezUM
Subject: [Intel-wired-lan] [PATCH iwl-net v2 1/1] igc: disable L1.2 PCI-E
 link substate to avoid performance issue
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

I226 devices advertise support for the PCI-E link L1.2 substate. However,
due to a hardware limitation, the exit latency from this low-power state
is longer than the packet buffer can tolerate under high traffic
conditions. This can lead to packet loss and degraded performance.

To mitigate this, disable the L1.2 substate. The increased power draw
between L1.1 and L1.2 is insignificant.

Link: https://lore.kernel.org/intel-wired-lan/15248b4f-3271-42dd-8e35-02bfc92b25e1@intel.com
Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Fixes: 43546211738e ("igc: Add new device ID's")
---
 drivers/net/ethernet/intel/igc/igc_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 27575a1e1777..3ada48b85bd9 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7113,6 +7113,10 @@ static int igc_probe(struct pci_dev *pdev,
 	adapter->port_num = hw->bus.func;
 	adapter->msg_enable = netif_msg_init(debug, DEFAULT_MSG_ENABLE);
 
+	/* Disable ASPM L1.2 on I226 devices to avoid packet loss */
+	if (igc_is_device_id_i226(hw))
+		pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
+
 	err = pci_save_state(pdev);
 	if (err)
 		goto err_ioremap;
@@ -7498,6 +7502,9 @@ static int __igc_resume(struct device *dev, bool rpm)
 	pci_enable_wake(pdev, PCI_D3hot, 0);
 	pci_enable_wake(pdev, PCI_D3cold, 0);
 
+	if (igc_is_device_id_i226(hw))
+		pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
+
 	if (igc_init_interrupt_scheme(adapter, true)) {
 		netdev_err(netdev, "Unable to allocate memory for queues\n");
 		return -ENOMEM;
@@ -7623,6 +7630,9 @@ static pci_ers_result_t igc_io_slot_reset(struct pci_dev *pdev)
 		pci_enable_wake(pdev, PCI_D3hot, 0);
 		pci_enable_wake(pdev, PCI_D3cold, 0);
 
+		if (igc_is_device_id_i226(hw))
+			pci_disable_link_state_locked(pdev, PCIE_LINK_STATE_L1_2);
+
 		/* In case of PCI error, adapter loses its HW address
 		 * so we should re-assign it here.
 		 */
-- 
2.34.1

