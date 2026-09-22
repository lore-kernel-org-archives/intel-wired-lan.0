Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2019CC98305
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 11:36:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE00A60762;
	Tue, 22 Sep 2026 11:36:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UHMcxiSAt-sn; Tue, 22 Sep 2026 11:36:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 242EE6077D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790076968;
	b=l8iZpx5T9RNCmXQ5Ea4pzQFlub946/xk+9kPhdGudJurv4xKhZoB/ao+OhQrc4HqSHzE
	 eNQ0BSAqJ++UygyGJDwZSv6DncY2zt512AjuUyeOiKtYsUkOMnTgMbbyS0ilHQ0gmqR50
	 UO7fsJa0dEcwcFP0FrnbxVJ3T875yyIaybhaRJdknHd411reR68rb3HC61/Jb3T8GrtGm
	 QMiGZ0FH2dIflUrpJBma/1p0Zc3yM1elscqT6qUsnGRRMgpk1aI12IwS2Nw3zYEPxHuh4
	 BzIDLry4RjstBX+9E1sr3XckyOfHpNFDKd9ahJWukj46Ky+6DmDgj+/2VpRIM937o5Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790076968;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=INdFd4OCYJfW/GGc2EnSpjoaIgPkwKHlZfRQetW2lSY=;
	b=jjxss42gnr6xAeYE/K6hrUbpqMRRJPrdyWBhUugP/twoQANwz7wBrnOIk1Wht5nRQSqu
	 6Xs+d+KfYd5cax8mNoXC8Ubr9LPxnSLPiszt2IVDRL367EiYxivNXR9uQwBEIuuCKrbxF
	 2xtVY6AcsyJBqOzgmT8+jfgBmAu8wh6u33yRobgLdiIBkdueiYb9vtkpaz4IEifZMozle
	 XrbQ8Q0rA8b8aIfG78Ex4LUpboLPgAjTNxaRHJHvwULn69f5kWXEpzE4uoR25aNHQUt/G
	 n4YyFAqbCxEzwJpp3AKXQ5IdrkHcAXJladX8wAOEU11SIZKDOgIVfza/Jc0xSza3k2A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790076968;
	bh=INdFd4OCYJfW/GGc2EnSpjoaIgPkwKHlZfRQetW2lSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LxhidI8kzkZ6ynqkAwyXubpMZdfueIIIJPP7RlKPhuofyBWvxxvF84sspqtl5yV9p
	 Wefivd8mbBhppGlNCaHhy3+/h3S+KQNMzhOI/cTNpl/q094uo1Yko2f+GAAfmLOwQ1
	 ZxTfFn31AdB5ZjVfccgsxAqmFu7ZUg4BT6q3UgROYLzC8NpwPQv08pgXz2TltMOKGE
	 kro6guf/elfnsBZYrAOEgjZfdh/zdn7njl/JDRMDhqDg3O5qAC79e3zer0O37UJdn2
	 ftn9BtGj2GN21vVNM6x5UORIiW8BQmWpRXrViAOedf4j66V092oM1tIbjHaJ2ojpu0
	 +qnAM7CmUXvTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 242EE6077D;
	Tue, 22 Sep 2026 11:36:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0ACED35A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 11:36:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E53C380C50
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 11:36:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6dhTywrFQwL6 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 11:36:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 01CB380C4E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790076964;
 b=Jfq0yAO0zf2HUvGIuA5ifophAXrnBIgtuC7IxuTkI3F8xLgL3eJlkNxkHx/+x+++z+Bd
 EtKvwPG+g/Yn3UGKyH0bf470KyjJj18KveWZVlzd6Wk44p/+sDkzMEH8dPvjBuaeYvGOl
 T4ygaqfRNATNUre45q9Yvad2xB6SnFsEeEyBb98b+HxBCAtxaXBOBrWlaVKw4GU9o9UVr
 Ou9/iNtlG/tSm4erq1WMr+NGURGKr+wkiEot/57dWJxDROmCQapFPd7no036CAW8/QEH0
 bTxnrhqVx93xUO00GAJulql39kqgbuhwOBWx2EUGDuA38O26UK7SeuXm22h6WFuu9CA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790076964;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=INdFd4OCYJfW/GGc2EnSpjoaIgPkwKHlZfRQetW2lSY=;
 b=Z9ToUHUEPqADdERt+8oKUpc9Is6SIbwoR2hMnslPW01SXLXVHdieixNeL/9MrJxwPqXZ
 EfhOXq2vgIRduWzv0Gg2/afjwsj/EbUHd98YveAoClYQMmt7k/Uvm9XEN0byS1S2Gl+NG
 rRpw0j6S2uEIyKx0L/XI+WKuIAzUxHxK504mvWkuZVjDdYBHgcE+pasUi68NwWN8C+yAB
 2nYHTMxdWoB9cJoRagrJmNNRCCYQtJo7lGVVAPND6y/BmgeMOZEcm7vXQUFpBV1FndH4x
 XQVCfPK61dRdPi4TRi8oSIunxQRg40DmX9/kdrr4gGoY/TMTTvpQxc7PjJp7MEimj7A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=EjnQodWO; 
 arc=none smtp.remote-ip=192.198.163.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=EjnQodWO
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 01CB380C4E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 11:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790076964; x=1821612964;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4QH1S2syL6mlFcY4Z5eC/lt5lGMSXXdYEQtpCVVQWfo=;
 b=EjnQodWOj18QaYJ9GS84qtG6E6C6WbJXTFti4++Yg+O3EbRR/i3ZWIZb
 Ui9hbz444bnzB8oLdSaT3JBsST7iOw+4zA7HeKPWcDevPpD4B8PvORE1t
 vB4GzyacI5NHuXtXl9nnEgY5Vblaa/12k3JjdQDcz5ryP+Fm7okmx5gnh
 Bj5TjpKnvnxmft6w9mlfsJkzSSqP1I9LOZC4CaZoCH21Kwmyaa69U2U1S
 cKPR5Wp10d7GAIqimDTqA8k08Qn//UezNIQ+1xGerF2ENZxs1pqUCu3fP
 72PWOqKqr3xgRHONIrkMSO6sa3Rzl1Xnko+rakNnk33LmY8WiQXNhOOnw Q==;
X-CSE-ConnectionGUID: xKuCPS7YTLqycfULK5/FEg==
X-CSE-MsgGUID: VX7ZCpINQneFsLlW/sMAZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90787339"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="90787339"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 04:36:03 -0700
X-CSE-ConnectionGUID: 16ei8HstTaG/F8VFLERuwA==
X-CSE-MsgGUID: 7sCUDdjdRAWIgR05RVZHEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="272592003"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by fmviesa007.fm.intel.com with ESMTP; 22 Sep 2026 04:36:03 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net  v2 4/4] ixgbe: Implement PCI reset handler
Date: Tue, 22 Sep 2026 11:35:58 +0000
Message-ID: <20260922113558.2288111-5-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922113558.2288111-1-sergey.temerkhanov@intel.com>
References: <20260922113558.2288111-1-sergey.temerkhanov@intel.com>
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

Implement PCI device reset handler to allow the network device to
get re-initialized and function after a PCI-level reset.

This is necessary for the adapter to avoid TX queue timeouts
occurring after the PCI reset is performed via sysfs during
its operation.

The reset codepath may trigger a number of dependencies in the
reset of the driver, so that it is necessary to check if
the netdev is present and running there.

Fixes: 711d57796f5c ("PCI: expose function reset capability in sysfs")
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 111 ++++++++++++++++++
 2 files changed, 112 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index bac3b85a1d63..88247e760bda 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -912,6 +912,7 @@ enum ixgbe_state_t {
 	__IXGBE_PTP_TX_IN_PROGRESS,
 	__IXGBE_RESET_REQUESTED,
 	__IXGBE_PHY_INIT_COMPLETE,
+	__IXGBE_PCI_RESET_PREPARED,
 };
 
 struct ixgbe_cb {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 6ef51b822a50..da26d1013f3e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -10537,6 +10537,9 @@ void ixgbe_do_reset(struct net_device *netdev)
 {
 	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
 
+	if (!netif_device_present(netdev))
+		return;
+
 	if (netif_running(netdev))
 		ixgbe_reinit_locked(adapter);
 	else
@@ -12396,6 +12399,7 @@ static int ixgbe_rebuild_fcoe_queues(struct ixgbe_adapter *adapter)
 
 	ixgbe_clear_interrupt_scheme(adapter);
 	err = ixgbe_init_interrupt_scheme(adapter);
+	/* Keep reinit_pending set so ixgbe_open() retries before using queues. */
 	if (err)
 		return err;
 
@@ -12404,6 +12408,110 @@ static int ixgbe_rebuild_fcoe_queues(struct ixgbe_adapter *adapter)
 	return 0;
 }
 
+/**
+ * ixgbe_pci_reset_prepare - called before the pci bus is reset.
+ * @pdev: Pointer to PCI device
+ *
+ * Quiesce the driver in preparation for a PCI function reset. Called from
+ * pci_dev_save_and_disable() before the core saves config state and writes
+ * PCI_COMMAND_INTX_DISABLE to clear bus mastering and MMIO decode, so MMIO
+ * access to the device is still valid here.
+ */
+static void ixgbe_pci_reset_prepare(struct pci_dev *pdev)
+{
+	struct ixgbe_adapter *adapter = pci_get_drvdata(pdev);
+	struct net_device *netdev;
+
+	if (!adapter)
+		return;
+
+	netdev = adapter->netdev;
+
+	rtnl_lock();
+	if (!netif_device_present(netdev)) {
+		rtnl_unlock();
+		return;
+	}
+
+	set_bit(__IXGBE_PCI_RESET_PREPARED, &adapter->state);
+	netif_device_detach(netdev);
+	if (netif_running(netdev))
+		ixgbe_close_suspend(adapter);
+	rtnl_unlock();
+
+	/* __IXGBE_RESETTING is intentionally not set here: it is spun on
+	 * while holding rtnl by ixgbe_reinit_locked(), ixgbe_dcbnl_devreset()
+	 * and the ethtool reset paths, so holding it across the rtnl drop
+	 * would deadlock those callers against ixgbe_pci_reset_done(), which
+	 * needs to re-acquire rtnl.  During the reset window concurrent
+	 * rtnl-holding paths must treat the netdev as detached, while teardown
+	 * paths also observe __IXGBE_DOWN set by ixgbe_down() via
+	 * ixgbe_close_suspend(), matching the existing ixgbe_io_error_detected()
+	 * flow.
+	 */
+
+	if (test_bit(__IXGBE_SERVICE_INITED, &adapter->state)) {
+		/* The service timer was already stopped by ixgbe_down() via
+		 * ixgbe_close_suspend(); if the netdev was not running, the
+		 * timer is not armed.  Only the currently queued service task
+		 * (if any) still needs to be flushed here.
+		 */
+		cancel_work_sync(&adapter->service_task);
+		clear_bit(__IXGBE_SERVICE_SCHED, &adapter->state);
+	}
+}
+
+/**
+ * ixgbe_pci_reset_done - called after the pci bus has been reset.
+ * @pdev: Pointer to PCI device
+ *
+ * Re-initialize the device after a PCI function reset. The PCI core has
+ * already called pci_restore_state() before invoking this callback, so the
+ * saved Command register (including bus mastering) is back in place.
+ */
+static void ixgbe_pci_reset_done(struct pci_dev *pdev)
+{
+	struct ixgbe_adapter *adapter = pci_get_drvdata(pdev);
+	struct net_device *netdev;
+	bool running;
+	int err = 0;
+
+	if (!adapter)
+		return;
+
+	netdev = adapter->netdev;
+
+	rtnl_lock();
+	if (!test_and_clear_bit(__IXGBE_PCI_RESET_PREPARED, &adapter->state)) {
+		rtnl_unlock();
+		return;
+	}
+
+	adapter->hw.hw_addr = adapter->io_addr;
+	ixgbe_reset(adapter);
+	IXGBE_WRITE_REG(&adapter->hw, IXGBE_WUS, ~0);
+	running = netif_running(netdev);
+
+	err = ixgbe_rebuild_fcoe_queues(adapter);
+	if (err)
+		e_dev_err("Cannot rebuild queue layout after PCI reset: %d\n",
+			  err);
+	if (running && !err) {
+		err = ixgbe_open(netdev);
+		if (err)
+			e_dev_err("Cannot re-open netdev after PCI reset: %d. A new reset is needed.\n",
+				  err);
+	}
+	if (err && running)
+		dev_close(netdev);
+	/* Restore presence so userspace can retry later. If recovery failed,
+	 * dev_close() cleared IFF_UP first so netif_device_attach() will not wake
+	 * Tx queues without a successful open.
+	 */
+	netif_device_attach(netdev);
+	rtnl_unlock();
+}
+
 /**
  * ixgbe_io_resume - called when traffic can start flowing again.
  * @pdev: Pointer to PCI device
@@ -12441,6 +12549,7 @@ static void ixgbe_io_resume(struct pci_dev *pdev)
 	if (err && running)
 		dev_close(netdev);
 
+	/* A failed running device is down; attach permits a later open retry. */
 	netif_device_attach(netdev);
 	rtnl_unlock();
 }
@@ -12449,6 +12558,8 @@ static const struct pci_error_handlers ixgbe_err_handler = {
 	.error_detected = ixgbe_io_error_detected,
 	.slot_reset = ixgbe_io_slot_reset,
 	.resume = ixgbe_io_resume,
+	.reset_prepare = ixgbe_pci_reset_prepare,
+	.reset_done = ixgbe_pci_reset_done,
 };
 
 static DEFINE_SIMPLE_DEV_PM_OPS(ixgbe_pm_ops, ixgbe_suspend, ixgbe_resume);
-- 
2.53.0

