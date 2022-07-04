Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A429C43334
	for <intel-wired-lan@archiver.kernel.org>; Mon,  4 Jul 2022 12:41:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B9AF64157A;
	Mon,  4 Jul 2022 12:41:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B9AF64157A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1656938491;
	bh=HvsPsy1BNDLupMgUc5U5GzjJb+V9cMSPFQspp+65HNU=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=kF6ouzgaCKCAFeMpJu+NnF6HSxKthJ2Dd2G8YKsV3id7aUmEqZl+GoHqV27WkMALn
	 s8iB/J9Qlw+x+YfoYISJlq+K1OC5YQSfG/e4VYWx5fVjMm+uoKbH4yhn2jNp5ytwX+
	 pl5HNxQNrzNtLgkrWPkhCBEOpqHDawkNZ5CpX7r4CW+LapAe65jb+s7LzVP9PvaYQF
	 HYGByeo7mX8lhyB9FGH0ZE8tx7ZU4EHlDXj5N2FhgVan117VsqpYfhGV9irTbMZFqt
	 oPjq4jSiZSbhmIvLgZFa4OWdyk0+GsQta6xXS/7E5Lj5ucybzX/D70wDZ2nUUoqMru
	 xk2RvfMXqmvoA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1J4TQZHGOky2; Mon,  4 Jul 2022 12:41:30 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5576A4158B;
	Mon,  4 Jul 2022 12:41:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5576A4158B
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 698C61BF368
 for <intel-wired-lan@lists.osuosl.org>; Mon,  4 Jul 2022 12:41:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 51CF981CA3
 for <intel-wired-lan@lists.osuosl.org>; Mon,  4 Jul 2022 12:41:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 51CF981CA3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DyHvAOE8waFW for <intel-wired-lan@lists.osuosl.org>;
 Mon,  4 Jul 2022 12:41:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A16FB81C67
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A16FB81C67
 for <intel-wired-lan@lists.osuosl.org>; Mon,  4 Jul 2022 12:41:28 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="263544213"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; d="scan'208";a="263544213"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2022 05:41:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; d="scan'208";a="542578045"
Received: from amlin-018-068.igk.intel.com (HELO localhost.igk.intel.com)
 ([10.102.18.68])
 by orsmga003.jf.intel.com with ESMTP; 04 Jul 2022 05:41:26 -0700
From: Mateusz Palczewski <mateusz.palczewski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Mon,  4 Jul 2022 14:41:12 +0200
Message-Id: <20220704124112.1339048-1-mateusz.palczewski@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656938488; x=1688474488;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=LYBSomNcfWBzYZ8cXDmRwJMUZh4rpv0kVmb4Zyfz7tw=;
 b=V/1q0r+rvqa5N/xCWT7JN02hJ08AJnyTy8N1W5TVVfNRN6eUDh7TBPCd
 jeKKYe2fEDY0keVSgb8g3C6wXXeSEvmlGCMdaWuDKhVPlwmfUQYKkkMiJ
 npIx06nBKaWoDYqYWiOUv6zUfGB/ioFPUPO+c8CpRsZFfFxNb5HH2npGO
 Qu4VBjt0uGwJ1ylhiMZrG14a13BMw2vQjuhfujTm7tgbCb3ForZrftIpf
 Xw2t0OYpPajtX3HB73hucsIDmz/KBuY58IwPNv00YD5UubJ41b5OKSHfW
 Swd4xOTfVK9Hg/AJuaM1azRH1E14+FlCPzbfWDh4wfyUEvyx17z2SiBNQ
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=V/1q0r+r
Subject: [Intel-wired-lan] [PATCH net v1 1/2] iavf: Fix shutdown pci
 callback to match the remove one
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: SlawomirX Laba <slawomirx.laba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: SlawomirX Laba <slawomirx.laba@intel.com>

Make the flow for pci shutdown be the same to the pci remove.

iavf_shutdown was implementing an incomplete version
of iavf_remove. It misses several calls  to the kernel like
iavf_free_misc_irq, iavf_reset_interrupt_capability, iounmap
that might break the system on reboot or hibernation.

Implement the call of iavf_remove directly in iavf_shutdown to
close this gap.

Fixes: 5eae00c57f5e ("i40evf: main driver core")
Signed-off-by: Slawomir Laba <slawomirx.laba@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 40 +++++++--------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index f3ecb3bca33d..74be5e3a09df 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -4545,34 +4545,6 @@ int iavf_process_config(struct iavf_adapter *adapter)
 	return 0;
 }
 
-/**
- * iavf_shutdown - Shutdown the device in preparation for a reboot
- * @pdev: pci device structure
- **/
-static void iavf_shutdown(struct pci_dev *pdev)
-{
-	struct iavf_adapter *adapter = iavf_pdev_to_adapter(pdev);
-	struct net_device *netdev = adapter->netdev;
-
-	netif_device_detach(netdev);
-
-	if (netif_running(netdev))
-		iavf_close(netdev);
-
-	if (iavf_lock_timeout(&adapter->crit_lock, 5000))
-		dev_warn(&adapter->pdev->dev, "failed to acquire crit_lock in %s\n", __FUNCTION__);
-	/* Prevent the watchdog from running. */
-	iavf_change_state(adapter, __IAVF_REMOVE);
-	adapter->aq_required = 0;
-	mutex_unlock(&adapter->crit_lock);
-
-#ifdef CONFIG_PM
-	pci_save_state(pdev);
-
-#endif
-	pci_disable_device(pdev);
-}
-
 /**
  * iavf_probe - Device Initialization Routine
  * @pdev: PCI device information struct
@@ -4909,6 +4881,18 @@ static void iavf_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
+/**
+ * iavf_shutdown - Shutdown the device in preparation for a reboot
+ * @pdev: pci device structure
+ **/
+static void iavf_shutdown(struct pci_dev *pdev)
+{
+	iavf_remove(pdev);
+
+	if (system_state == SYSTEM_POWER_OFF)
+		pci_set_power_state(pdev, PCI_D3hot);
+}
+
 static SIMPLE_DEV_PM_OPS(iavf_pm_ops, iavf_suspend, iavf_resume);
 
 static struct pci_driver iavf_driver = {
-- 
2.27.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
