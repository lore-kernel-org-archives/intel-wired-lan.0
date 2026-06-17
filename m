Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F36CCD98EE
	for <intel-wired-lan@archiver.kernel.org>; Wed, 17 Jun 2026 08:43:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D18C6F715;
	Wed, 17 Jun 2026 08:43:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BZHjqekXVTd9; Wed, 17 Jun 2026 08:43:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CD2106F714
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1781685814;
	bh=XhZaAUwzS8fX4SHnNBqYQypcNnmMHjFbg2XBH0YpVaE=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GnEYTl06xQPpADQcqZthmYH8lZo4E8g6gQjMterR16LoVMeXUxuzV6HeEmt4Q3jhk
	 tVKI/lRZUqgmLoijMreMrsJqhU0mwqlIF/4wHgOeBiS8OmbH5DrSLA8Am9yLKvL6Ty
	 VeQUITvW3bTBvr37sbQpkic4FldcvctFaQsW9R6NRnYs4U3PzaJ5oaYlF8lGtYbHdj
	 I2MJpfA5bOt+Bh6/KLjhTZ6sflwAwkJ/vE9heMjq8laGYTRHzUXDlPHKBlrU9Hpg4n
	 MjMWKnXoR4MPJc4bdw82tLcpferSYrFOpeXxomBP2KLNlrBHFcDhBaCFXg/gS0Lb+0
	 3wk3Caq8iISrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD2106F714;
	Wed, 17 Jun 2026 08:43:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E3A30D8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 17 Jun 2026 08:43:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D52576F714
 for <intel-wired-lan@lists.osuosl.org>; Wed, 17 Jun 2026 08:43:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nqtgPWak5Pyq for <intel-wired-lan@lists.osuosl.org>;
 Wed, 17 Jun 2026 08:43:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2B3086F713
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2B3086F713
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2B3086F713
 for <intel-wired-lan@lists.osuosl.org>; Wed, 17 Jun 2026 08:43:31 +0000 (UTC)
X-CSE-ConnectionGUID: jP49NYpMSma7x8a4NuWf4Q==
X-CSE-MsgGUID: smrf4LkjS4ODPbIo8bxoDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="107943268"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="107943268"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 01:43:31 -0700
X-CSE-ConnectionGUID: kVtvwnhAT7W98MA0btWbOg==
X-CSE-MsgGUID: Curnho7OSn+PQ5NWgpk/pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="251914883"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa003.jf.intel.com with ESMTP; 17 Jun 2026 01:43:31 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Date: Wed, 17 Jun 2026 08:43:29 +0000
Message-ID: <20260617084329.199110-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781685812; x=1813221812;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=y6TAMVlRy7PqX/OQ7to6WoMTdCQN7VJj0eBU7zauT9Q=;
 b=XtAp6LqHdtPFLH92t2xPW/mm7agCHiiBBU1AlMMVAdVPBr3JmK9kOX0R
 I0zazBWjjoHAfVn48lvYV3FEk9u5GfZbIureajr/h6ebMCsY5SIv8aS7T
 3IFB5HzDnlHxcMhxib6mrcZMc7kAh2taexuvJMOyV0+cWStWGVvTWCb5z
 l7PZ3GiRM1cBd73bPn3hVmGdYF6DGAPEI3MroUrxdZ2Eqtp8bJF4dkNjc
 U/9oTpCf+W1zDyybHf1b2b2wsxQU1r5Z78/SbmJzpTieb54IT/cYKvWt0
 go4DeVOEuz9CR1EsWBgAAw+GPE/MRU5U17SXCzxbFYSwV2jDrmdAqnrnw
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=XtAp6LqH
Subject: [Intel-wired-lan] [PATCH iwl-next v1] ixgbe: Implement PCI reset
 handler
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

Implement PCI device reset handler to allow the network device to
get re-initialized and function after a PCI-level reset.

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 72 +++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 594ccb28da20..c4b0c5bb89c6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -912,6 +912,7 @@ enum ixgbe_state_t {
 	__IXGBE_PTP_TX_IN_PROGRESS,
 	__IXGBE_RESET_REQUESTED,
 	__IXGBE_PHY_INIT_COMPLETE,
+	__IXGBE_PCIE_RESET_IN_PROGRESS,
 };
 
 struct ixgbe_cb {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 2ac274c73d61..a61ee5fff7be 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -12352,6 +12352,76 @@ static pci_ers_result_t ixgbe_io_slot_reset(struct pci_dev *pdev)
 	return result;
 }
 
+#define IXGBE_PCIE_RESET_RETRIES 1000
+
+/**
+ * ixgbe_reset_prep - called before the pci bus is reset.
+ * @pdev: Pointer to PCI device
+ *
+ * Prepare the card for a reset, preventing the service task from running.
+ */
+static void ixgbe_reset_prep(struct pci_dev *pdev)
+{
+	struct ixgbe_adapter *adapter = pci_get_drvdata(pdev);
+	unsigned int timeout = IXGBE_PCIE_RESET_RETRIES;
+
+	if (!adapter)
+		return;
+
+	/* Prevent the service task from being requeued in the timer callback
+	 * while we're resetting.
+	 */
+	if (test_bit(__IXGBE_SERVICE_INITED, &adapter->state)) {
+		timer_delete_sync(&adapter->service_timer);
+		/* Prevent the service task from running while we're resetting. */
+		cancel_work_sync(&adapter->service_task);
+	}
+
+	pci_clear_master(pdev);
+
+	while (test_and_set_bit(__IXGBE_RESETTING, &adapter->state) && --timeout)
+		usleep_range(1000, 2000);
+
+	if (!timeout) {
+		e_err(drv, "Timed out waiting for __IXGBE_RESETTING to be released. Reset is needed\n");
+		pci_set_master(pdev);
+		return;
+	}
+
+	set_bit(__IXGBE_PCIE_RESET_IN_PROGRESS, &adapter->state);
+	smp_mb__after_atomic();
+}
+
+/**
+ * ixgbe_reset_done - called after the pci bus has been reset.
+ * @pdev: Pointer to PCI device
+ *
+ * Allow the service task to run and schedule re-initialization.
+ */
+static void ixgbe_reset_done(struct pci_dev *pdev)
+{
+	struct ixgbe_adapter *adapter = pci_get_drvdata(pdev);
+
+	smp_mb__before_atomic();
+	if (!test_and_clear_bit(__IXGBE_PCIE_RESET_IN_PROGRESS, &adapter->state)) {
+		e_err(drv, "Reset done called without PCIe reset in progress\n");
+		return;
+	}
+
+	/* Allow the service task to run */
+	if (!test_bit(__IXGBE_REMOVING, &adapter->state)) {
+		clear_bit(__IXGBE_RESETTING, &adapter->state);
+		smp_mb__after_atomic();
+	}
+
+	/* Schedule re-initialization */
+	if (!test_bit(__IXGBE_DOWN, &adapter->state)) {
+		set_bit(__IXGBE_RESET_REQUESTED, &adapter->state);
+		if (test_bit(__IXGBE_SERVICE_INITED, &adapter->state))
+			mod_timer(&adapter->service_timer, jiffies + 1);
+	}
+}
+
 /**
  * ixgbe_io_resume - called when traffic can start flowing again.
  * @pdev: Pointer to PCI device
@@ -12384,6 +12454,8 @@ static const struct pci_error_handlers ixgbe_err_handler = {
 	.error_detected = ixgbe_io_error_detected,
 	.slot_reset = ixgbe_io_slot_reset,
 	.resume = ixgbe_io_resume,
+	.reset_prepare = ixgbe_reset_prep,
+	.reset_done = ixgbe_reset_done,
 };
 
 static DEFINE_SIMPLE_DEV_PM_OPS(ixgbe_pm_ops, ixgbe_suspend, ixgbe_resume);

base-commit: c50bfa9768ff3a5163746c6362a8a910a0b4dca0
-- 
2.53.0

