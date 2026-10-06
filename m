Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16751CA5FF0
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 10:06:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA39480BC0;
	Tue,  6 Oct 2026 10:06:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MlViIoGUb5HB; Tue,  6 Oct 2026 10:06:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 01C2E80BB8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791281162;
	b=qcTkqNJy1F9LY6z5S+hhzGSRax/osf1InCD+RnVspxXQZBOF3TNPwhlsxsJ5KKwXmg4q
	 glYztLlkDNttB/zVND0rH/BYfKiHWpt9tQB6Pfh7mQ9SYDWZwDI7QQl7e9VMVHIihw0GR
	 mRbRJ726as1L1dn0Z9Vnah/5OfxDSFHbGnuZ8ElHZYJLkoAsXC4IBX7EPFCliwqQ7waWk
	 HDc2K6xl10/QFoJVNXcxBNIveyQF5Ps7eYhlJ7Lh1gIDfHxZPICdvBDz+uldtB+jCfe5J
	 pmK0vzdI/XoRaT8daHjZ90arz0m3WXJHMlGkdyTx22uwE96h8ghFjeXC3mzZ4cb2htA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791281162;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=j5GX7X7GWD1/E8XSh8YvaDllDeJuStSqW1F8xsmRXFY=;
	b=MuhBviUTx9w2/xCwp7l96NkvmetXP5UnlTrpYS5y1d7HeJXLraOpCTILBd7kCi5oL/qo
	 JNlytLrbcAbOtvpTtA5bjHnbqA7udhawdK/yjoNT7Ik7a7N3iBcgjebQ6uMgZXZ4JX8xp
	 KwM8It6ikpIMTFCbOfEJr2kGKDc2KFEvhnAMiPUQhrilO2AKz2UtRiuL7Pno9BqARJrC5
	 g6RxtoQoNu+Kv/0Ui7GaIW03jdL1wTQs+YGPu5+Js+F7+9dqLtbHSNi+lc/9dJlrNm+ho
	 7aYoJPicNCHcNHsdwd/h+xXeagW9V5amrw8Eydr1eLHr7gR2hFN4jAAqF1AEY55bIGA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791281162;
	bh=j5GX7X7GWD1/E8XSh8YvaDllDeJuStSqW1F8xsmRXFY=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r+C5czFCCBbTS7z4YItF5x8Z0Aolheou7EMh6flOgahMiRdcw7mQPuroXVsf7sXcR
	 /IATsytZoulw1/7JR5RkNoHhLxkH+7BgkErmdRwpfU+l4Vy73AO2oHebF5Oh6HJwDe
	 +WzJju9ApVuXADofWdFMLAzMB5sV3hwmdbrhNwH4Wh499WRmOdNPLPEK5TLx+WLNS5
	 GeR5+wLLq21JQcp2Vdw/xI37SqzojmRIpfBThxquQYkODudBmVcEzJIYxR6/E/QFKT
	 jpqi1LUSg1QBTmX7QOa7tMrieGNJApp8Jl+vm90p3D7ug7Cs8ahq0kR2DkZ1h3jMSJ
	 jmkLg1KRZ3Y9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 01C2E80BB8;
	Tue,  6 Oct 2026 10:06:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B41E432F
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 09:45:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A6587605D8
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 09:45:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xwYmvckObE17 for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 09:45:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C7CBF605CB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791279940;
 b=cPHnM6da986JoCLzxsxfvtPOIMkUJpm0v6oScgM8r8rzPku0Xr3XchGoN2OkVdhKP8R0
 pyYXpTB/7VOTfQjdCSDNiLuhReyUEgE4WGpqvacyKTPfugzZqJ395VQLltEoODmGM+NwR
 sMm1cpjgza7KPx62AKX2uOiqi/+f3J2xdgTuvPgXsh7ecsMBriY39oF8auD9ag7H0x9fo
 Zi41a4q6bEio8AVHCyVNSTuxI3cM8PsLZNLI3plORNH0KTSxyN+xw+Ch6Ir4Qj3oaYixi
 qO9lIt1xTCy15G9XRbIrERW/rcUHR4cp9TW6Md2w23iTnT8II7CgtZzvdGmgOAsOJDA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791279940;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=j5GX7X7GWD1/E8XSh8YvaDllDeJuStSqW1F8xsmRXFY=;
 b=h2hxdI1c70jH3M7LozlvJl3WYi9KwGUe30B/HJU8GmcBMJD9sel56AakEo6c08JJ8lVA
 Wo295Ja4914F8wcczn1Rge3myEjYGgE6jnCEaLEjxXUhvvSVrrGA0EnD7IcVemPwmKD0/
 Y3It8PkVTEBekd6zYDUkiTShvix8GxrFidAbUbpX3EApJY5VvUy//pORHkM+D16aTopkl
 2CQBk7j0qynn+LqRObfeFXkfNHkM1CG447z6i17e+rxbFgR+j6GvP+19svaH9ylknaHum
 xw0yt8Gsat7Ya6i4OPHMMEtQIHWfcKcaGpk4QYjjpilG+4dkOwhxpAn2nS5ec1wGbzg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Io9f5lv+; 
 arc=none smtp.remote-ip=192.198.163.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Io9f5lv+
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C7CBF605CB
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 09:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791279940; x=1822815940;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=eGviGMR220skdfCX0BHfizYMqNjwJSdmGwbtcj7g5nY=;
 b=Io9f5lv+wSnnz3pCBRgRNld7EKQ+IejgxWhgmce8S93TWcnz/Scv7gAc
 UVa4aNXFQf8VUaTQKUWTDYwoXFZL64V582Ceiz4lZfJPg5tIkecb2mXZX
 IDQ5dnOG+kxmJDieJR/FbnMdX0UFnfoILmXnaXuwA3XB3Hk+6a/jI0j66
 DuNaXwWu5C8RBx6JfZPcRSKNb+GcQaVYM+PYhsxW77gGsXRxjfVNLl8tv
 hrcN88ueHTU4bwLnPXnpYZ4gtDR/HdYiXyfobNIlZwneeC50f3vAB6ycZ
 vrK9nCaCohDVu72InBEz5KPCyaZAWpcEzaIno9Ume6AMOTP/0RFDVBuN7 Q==;
X-CSE-ConnectionGUID: /W3QvStLTz2NHogBAc/4zQ==
X-CSE-MsgGUID: L9FPJ2Z4TB+Vkw39UlCWyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="3213"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="3213"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 02:45:40 -0700
X-CSE-ConnectionGUID: tBCz2ApdQMGeJr6nIHwRjw==
X-CSE-MsgGUID: +sXVE/Q+SeSNwx4U0CwCyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="280350293"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa003.jf.intel.com with ESMTP; 06 Oct 2026 02:45:39 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Subject: [PATCH iwl-next v3 5/5] ixgbe: Implement PCI reset handler
Date: Tue,  6 Oct 2026 09:45:34 +0000
Message-ID: <20261006094534.418657-6-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006094534.418657-1-sergey.temerkhanov@intel.com>
References: <20261006094534.418657-1-sergey.temerkhanov@intel.com>
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

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
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

