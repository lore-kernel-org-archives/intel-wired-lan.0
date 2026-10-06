Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7540CA5FF0
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 10:05:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F8504039C;
	Tue,  6 Oct 2026 10:05:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HksOTRs46qBK; Tue,  6 Oct 2026 10:05:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8887840549
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791281157;
	b=pQY8Mi4V2yHrNgXy/m7NFY7WCfD13dvx84nQzib1tPVggG8XtK85GudJ158sX2sN7aqF
	 8HNlMSlVgCDGVA1bxaQH1Cq3gcu4M9fi0xfp2YxYzJo+x/tnk0xyU4KvZYTM/vggbzsWx
	 TD31msWw/c6pmLhsWOvPbEKVkK2joqGifZlXJ/CBR+l+L0lb+NGINoWuat255B7foyFEd
	 lS9pY3bw3bkVputS65vFCZ/ryx0CgAW2cUoOe8XomtHdHS8EsRf5K7/Zbg3fImcLWBJfw
	 hDQDu5CCBVuU29u1QEpk6V4zq8e8GCMPlUUHtC1P5qRwirb6bfWkTmliGNrJzT+Pkvw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791281157;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xcWTNeZXnamV9FDIopLPps+B9L/b+8SL6Ze9q5O/3Pk=;
	b=r3GKTLaP+oLjrRvAL5mqUHBcwSXWIgAAQKrv+cbhezqXJinJCzWrvN0FbPK1k4mWkpxj
	 TVD+KepyC+5nbU9OPSwLk3xQqM185gc/EnR+CJ6Pb/tjVWHg6T88FMrxfmaYV4c3rUH1T
	 qpC5NT94SiP0BgvCTTbT1Z0dh759q/XSFKFzt+xMTZp/h0y73gqql0f3gOGIhfEbrHBGM
	 zI4B+ofv7Xzvd0815IoRzY08eX0h0MZhnAdwEyBVF4e/mCFDIB2LdwJBfB0+h0VtldRRn
	 Naa4RhlolC26lfgiugiy2Vcoh5wVAbbm8EDKxhJg7v9CUss/KrgibZX09m0c3fXqFSA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791281157;
	bh=xcWTNeZXnamV9FDIopLPps+B9L/b+8SL6Ze9q5O/3Pk=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=inmxqd2ktUqL+kT5XmZUl1gTWGA9udlmxCcHPbke21gZYWKl+UCfN/D80xHqJHHiO
	 RK2mFzZs7drXp1vRH9s7QtNv0FPoPiFdTNMGfqkZ4ilLLMW8rx8QEF8lb+jtJOu8Ib
	 vt7QqBovG+yZJIGdtg6O4CHedW1x05Gu0LLIoraQ4D75KRwwBAKp8nWku5fg372I3M
	 q25Ai0U/7sQurbgQvTJYintudu/WePXqbaCQOOyuk3o2r0Jnfp1LAFDGVxi903Vc8k
	 H5A98SRht/0ZPGYyz8TQvH1LkO3RQ4jAwDH3kqofPVbmLl549G5kkzX6AhhtwWxjiK
	 LsagIylxblpRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8887840549;
	Tue,  6 Oct 2026 10:05:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 36817282
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 09:45:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 28D4C60773
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 09:45:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SQWX_qmN80C1 for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 09:45:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4FC8760735
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791279937;
 b=bvps+L6SHrb10d91TrEj12GpD+FBDyl8PRYf3FwzjiN2yA7up2Kl6cMWAJsaNl5t9FWS
 zKqxgbaXLaHvysIpH8tp05XmLpBOth06jhYDRSHLGzAZwXIcFflSk1f7AZMiOwU81lPuG
 FptD8Y8pILwG7vbqt8v6Cj5Chpskpsty3iypR9znKKnoc5TTnEIauHjYew71VppTQtqOH
 Nxv7ZZX+7z0wmn3bva7nW37shiezGQghdbPDvJSrm2oam3ebgZIm7ve9X+IypQ9rA01Zw
 inDZsM7yoYRu7iHSbjQ84BSOICMgpw6F5mVTHg2/wAHlSCqrjrMhP5FLtGm/+cAydcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791279937;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=xcWTNeZXnamV9FDIopLPps+B9L/b+8SL6Ze9q5O/3Pk=;
 b=UfTFSLBSVqgz2/+CAj0RSssKWGNZWwCTozYjSALxzQmdzglLJyMjje9d8VzsN4rLDF/y
 IQjmQLHR1f8f2veMsMqcyH3bCiIlZx+eHJJNpveeLTXaK9sSZofdVMcZ/2wUSoNxDezeL
 xiADX5WcAZsUnO05BU5m+gg9b7ABnpxL1uJ55aB5AaBJj8Sx5kSoSJ008C/vNwXnqGbhu
 XZ8oQuh8DNTC5WcpL0WfkGf+3SFwNAozOwDhH9El1NDJTqbTRHeXA/7mDbzPXbpVW1BiT
 FpzxK7a+w+4glOOubo1u+1zDCTlW7XMJo5n0nGI2hRttspNfYjqBGwyXOnVzZolwgjg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=azAJyprD; 
 arc=none smtp.remote-ip=192.198.163.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=azAJyprD
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4FC8760735
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 09:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791279937; x=1822815937;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Y8cHEkY80d7UU202EJphugn/c3ZHKa161xvQZB+i7rk=;
 b=azAJyprDjlgONVr9yLp8mSi9957BANDiIXtuvwjd+b1/YuaoN0W5rlVW
 26Hg3QpWJiD7yh52TllAV7zi7r91iEnFdrbTFsTriEUcxG9uzwfyatAnt
 RsKHCRdavtbGMJHm88A/r6lXqYwJ+sJhr/qBXzQXS7p49R440t/TIp0AF
 Bs5syTLzEt3VDGsOs+Oq58reJCyUoW/ZFIaT2WPW/pebM7sNeSkDvNa0r
 +gkzOQXGHrMIHVp4xcfapLTWp9Y5RKIm3cnnzPBbgkiGjlqlhpvA5eN+h
 vsDsCT5lKIZsEr2b7lLyS/oRCFWR+5E7whJQaNJVk4HykraPbPFw93hrf g==;
X-CSE-ConnectionGUID: txiEXbMSQuqcugzUKIsjdQ==
X-CSE-MsgGUID: tNCzEnpxS1uyAGw6dvE9Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="3209"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="3209"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 02:45:37 -0700
X-CSE-ConnectionGUID: 0QlSrFAFTkeSm+awKwtF8w==
X-CSE-MsgGUID: czw8QjifS0m9Mo+yuFW0PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="280350281"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa003.jf.intel.com with ESMTP; 06 Oct 2026 02:45:36 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Subject: [PATCH iwl-net v3 2/5] ixgbe: Defer FCoE queue rebuild while netdev
 is unavailable
Date: Tue,  6 Oct 2026 09:45:31 +0000
Message-ID: <20261006094534.418657-3-sergey.temerkhanov@intel.com>
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

When the network device is detached, defer rebuilding the FCoE queue layout
until it is opened or resumed after PCI error recovery.

Fixes: f7f37e7ff2b9 ("ixgbe: handle close/suspend race with netif_device_detach/present")
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c | 29 ++++++++++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.h |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 40 ++++++++++++++++++-
 3 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
index 011fda9c6193..54d8b079ada4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
@@ -830,27 +830,34 @@ static void ixgbe_fcoe_ddp_disable(struct ixgbe_adapter *adapter)
  *
  * Turns on FCoE offload feature in 82599.
  *
- * Returns : 0 indicates success or -EINVAL on failure
+ * Returns: 0 on success or a negative error code on failure
  */
 int ixgbe_fcoe_enable(struct net_device *netdev)
 {
 	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
 	struct ixgbe_fcoe *fcoe = &adapter->fcoe;
+	bool running;
 
+	/* libfcoe calls ndo_fcoe_disable() even when this callback fails. */
 	atomic_inc(&fcoe->refcnt);
 
+	if (!netif_device_present(netdev))
+		return -ENETDOWN;
+
 	if (!(adapter->flags & IXGBE_FLAG_FCOE_CAPABLE))
 		return -EINVAL;
 
 	if (adapter->flags & IXGBE_FLAG_FCOE_ENABLED)
 		return -EINVAL;
 
+	running = netif_running(netdev);
+
 	e_info(drv, "Enabling FCoE offload features.\n");
 
 	if (adapter->flags & IXGBE_FLAG_SRIOV_ENABLED)
 		e_warn(probe, "Enabling FCoE on PF will disable legacy VFs\n");
 
-	if (netif_running(netdev))
+	if (running)
 		netdev->netdev_ops->ndo_stop(netdev);
 
 	/* Allocate per CPU memory to track DDP pools */
@@ -864,8 +871,9 @@ int ixgbe_fcoe_enable(struct net_device *netdev)
 	/* release existing queues and reallocate them */
 	ixgbe_clear_interrupt_scheme(adapter);
 	ixgbe_init_interrupt_scheme(adapter);
+	adapter->fcoe.reinit_pending = false;
 
-	if (netif_running(netdev))
+	if (running)
 		netdev->netdev_ops->ndo_open(netdev);
 
 	return 0;
@@ -882,6 +890,7 @@ int ixgbe_fcoe_enable(struct net_device *netdev)
 int ixgbe_fcoe_disable(struct net_device *netdev)
 {
 	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
+	bool running;
 
 	if (!atomic_dec_and_test(&adapter->fcoe.refcnt))
 		return -EINVAL;
@@ -889,8 +898,10 @@ int ixgbe_fcoe_disable(struct net_device *netdev)
 	if (!(adapter->flags & IXGBE_FLAG_FCOE_ENABLED))
 		return -EINVAL;
 
+	running = ixgbe_netif_running(netdev);
+
 	e_info(drv, "Disabling FCoE offload features.\n");
-	if (netif_running(netdev))
+	if (running)
 		netdev->netdev_ops->ndo_stop(netdev);
 
 	/* Free per CPU memory to track DDP pools */
@@ -903,10 +914,14 @@ int ixgbe_fcoe_disable(struct net_device *netdev)
 	netdev_features_change(netdev);
 
 	/* release existing queues and reallocate them */
-	ixgbe_clear_interrupt_scheme(adapter);
-	ixgbe_init_interrupt_scheme(adapter);
+	if (netif_device_present(netdev)) {
+		ixgbe_clear_interrupt_scheme(adapter);
+		ixgbe_init_interrupt_scheme(adapter);
+	} else {
+		adapter->fcoe.reinit_pending = true;
+	}
 
-	if (netif_running(netdev))
+	if (running)
 		netdev->netdev_ops->ndo_open(netdev);
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.h
index 724f5382329f..81de590268cc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.h
@@ -58,6 +58,7 @@ struct ixgbe_fcoe {
 	dma_addr_t extra_ddp_buffer_dma;
 	unsigned long mode;
 	u8 up;
+	bool reinit_pending;
 };
 
 #endif /* _IXGBE_FCOE_H */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 42d3594827f7..1f23a035a90b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -182,6 +182,7 @@ EXPORT_SYMBOL(ixgbe_xdp_locking_key);
 static struct workqueue_struct *ixgbe_wq;
 
 static bool ixgbe_check_cfg_remove(struct ixgbe_hw *hw, struct pci_dev *pdev);
+static int ixgbe_rebuild_fcoe_queues(struct ixgbe_adapter *adapter);
 static void ixgbe_watchdog_link_is_down(struct ixgbe_adapter *);
 static void ixgbe_watchdog_link_is_up(struct ixgbe_adapter *);
 static void ixgbe_watchdog_update_link(struct ixgbe_adapter *);
@@ -7423,6 +7424,10 @@ int ixgbe_open(struct net_device *netdev)
 	if (test_bit(__IXGBE_TESTING, &adapter->state))
 		return -EBUSY;
 
+	err = ixgbe_rebuild_fcoe_queues(adapter);
+	if (err)
+		return err;
+
 	netif_carrier_off(netdev);
 
 	/* allocate transmit descriptors */
@@ -12345,6 +12350,24 @@ static pci_ers_result_t ixgbe_io_slot_reset(struct pci_dev *pdev)
 	return result;
 }
 
+static int ixgbe_rebuild_fcoe_queues(struct ixgbe_adapter *adapter)
+{
+#ifdef IXGBE_FCOE
+	int err;
+
+	if (!adapter->fcoe.reinit_pending)
+		return 0;
+
+	ixgbe_clear_interrupt_scheme(adapter);
+	err = ixgbe_init_interrupt_scheme(adapter);
+	if (err)
+		return err;
+
+	adapter->fcoe.reinit_pending = false;
+#endif
+	return 0;
+}
+
 /**
  * ixgbe_io_resume - called when traffic can start flowing again.
  * @pdev: Pointer to PCI device
@@ -12356,6 +12379,8 @@ static void ixgbe_io_resume(struct pci_dev *pdev)
 {
 	struct ixgbe_adapter *adapter = pci_get_drvdata(pdev);
 	struct net_device *netdev = adapter->netdev;
+	bool running;
+	int err;
 
 #ifdef CONFIG_PCI_IOV
 	if (adapter->vferr_refcount) {
@@ -12366,8 +12391,19 @@ static void ixgbe_io_resume(struct pci_dev *pdev)
 
 #endif
 	rtnl_lock();
-	if (netif_running(netdev))
-		ixgbe_open(netdev);
+	running = netif_running(netdev);
+	err = ixgbe_rebuild_fcoe_queues(adapter);
+	if (err)
+		e_dev_err("Cannot rebuild queue layout after PCI error recovery: %d\n",
+			  err);
+	if (running && !err) {
+		err = ixgbe_open(netdev);
+		if (err)
+			e_dev_err("Cannot re-open netdev after PCI error recovery: %d\n",
+				  err);
+	}
+	if (err && running)
+		dev_close(netdev);
 
 	netif_device_attach(netdev);
 	rtnl_unlock();
-- 
2.53.0

