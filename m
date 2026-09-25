Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C4AC9832F
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 23:58:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F10260720;
	Fri, 25 Sep 2026 23:58:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EechT7etD6Ad; Fri, 25 Sep 2026 23:58:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 041AE60D8B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790380701;
	b=V8B4056QEZyzxsizgFdVo8Qz+imCWz3sz/mE+BiQWAr+4kd09k9k7oJGgQ61XpTqpX60
	 QY83qJACjQ/cezATYuJXIWor6Yd338rFBX5r5BFiU5MIpX5LPUv3jowf1vhw35JFJPN07
	 RZyQVkihkpxSjfr7BS/zBX9QHRdAcve2Y8GkYdVYuYlpSu1wIe+KTb3f4b5dTz1FudMit
	 /ZCffu8rlJCjWNerct7SzNQa1feiGrDK6gTcZ72gCulM5ipXezksDwWJRsasm8yS5udZn
	 dmDVMawtoENyK4ieMZGXwM28RwSdKLqgfmcdOA1ij/C/PAD6bs7ycW5yEJjfF2pIrwA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790380701;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eMHF+UWGZrCoVa6+e9LndjUWwvnLG6UQsLpY7th95sY=;
	b=Rv7Bdf5Ysg89I7oZJgo/mqKc05AU2KyyYgfhRN7I3X3K/u4xQ0xhamdOafFMX2ZnDl9C
	 J39sepDFknRdPfYcIPRpogjUw1DY3u6kHOQsUivk7pTkhA5PT0yIfmrLsH7ffDtYrmcqm
	 3fUl78hazpHdd6NKTfdqXHUrY3aloAYtH4KvLjkFjdLZcoG2+IgaLoWp41XFtu7S6+p3u
	 KFPCnBu+H2Hfg3QCAK0d9IdqjjRhy4njDEoeK7OT9SRZqXezfssXpX4wuZucZSTDk4O9T
	 nlDOhSw9cqeKRZEEBhjw9hMpxKNQHhry4CnIJnZsQu3uxX0KN1CuK7xxcy+/Dpc5Ccw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HQG49EpK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790380701;
	bh=eMHF+UWGZrCoVa6+e9LndjUWwvnLG6UQsLpY7th95sY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zga/zUAHmlJLqRNxfU2CJ5M7QpmV7y4Uh3RTkyJ7EYbV1+VWO7SiQuLbEhuxu5wZG
	 difVxToBxGKoUweSuWqUNEfZ4zz/vWtjYET2FoLN/40PoQrnozcwljOeg//S65JROx
	 +9XkpeNnZSZo5NYnXkatr/CDJHZf2nBzaNOw/vdLPIRJIBODSaRay+wasgdqqB3W/H
	 fnkUdoKRtdcwII8Z5IqZdscg0U9gE2aHx95kZ+mnkBZoYXopQkGptl1e4/8GITDWNI
	 p14VDRVKdIrbqw/IHMpT9Y4NGk67QPz/FSl9u7VtapF+EdpwsZZWCrPcUoLv2dGq58
	 KQtBHox1T9wqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 041AE60D8B;
	Fri, 25 Sep 2026 23:58:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DFC79194
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DD4D260720
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F2TXxYYagIYX for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 23:58:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9AB9460670
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790380685;
 b=bvcJ2FkHI2YxWUxRPwgEG9YJ2pdPrVBCsPkYBRWiIE7fgkWqU6L1ZJMZRVBHcrZyA97Y
 FCpUaXbgRd8lXY/hT+tQhkBxvuiAOCSOIfO8evU3A3Ydy1dkzRRuQuCC+8el13TZ+evtL
 YvCpCKx6ia0aXPVFqmxFIrZn4tj8owXJl/l66qwnHjXTM3om2LPGHpeOwpunWnu9ZGurI
 TtM3F0YsRJILR+BWVIez4aYubzFwt0Wu7eVi/gm29/JYU+O5DlOhvzmQ81+gRzkn8nNnn
 V/3qgxoO9WW5RxfEaRp/olq2bhZ+RqthFPzYq/E3jOcNrYUnafOCC/fze+3aWqp4fig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790380685;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=eMHF+UWGZrCoVa6+e9LndjUWwvnLG6UQsLpY7th95sY=;
 b=qGLkZFgnK2et8bcuFIWh0rOXTQgH6pOwtP2jtNM+l0/NNVx5WMw80FyccqJD5fbbNVaD
 JG1Y5tzLCdeGBPq7LxmLHhysyoqBwShcx8NVqTtFIvpYA47r51dv7FdaeU8oCNHCe9ipT
 mUGsgT9iBZpfVylTYrAYs88Kc9K9TMvtiB/gv8Mhdi13SUDVGB0za1WH2jrbYUZSdOXBX
 q0ryuVLH+k+Vn1tJ8Qz1xfV5CydvEgA7EXBJE7a6OSwK1/SjBARVADPgAy+yTbhFvaiVY
 eU4z3QqeVDU41mkdV05wh21MauEHfTYQTVQmJBrcEMoq+x5r4NZntrfz/XNRaC8VDCA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=HQG49EpK; 
 arc=none smtp.remote-ip=198.175.65.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=HQG49EpK
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9AB9460670
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790380686; x=1821916686;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=7Gd8mbAEBOHI0khATp+betvvG+D8UBm+CrmHdb0zQuI=;
 b=HQG49EpKJNt5XL0mi9DPFYSrzr5pbwd+76LFAVUI/mEC+WnrpROzJfmg
 ZtgdxiiExTlvf+Dc22l3SfCsKq7O4rREDkGJt46Liuri2cvyMfmSQKRxz
 J+KHUDrGBxU90iiZD4Ie1NzNt13mOMpPWaFT6rXsRpLRL001IxxWt4whT
 im6MllWpVkRvEMGjLz7zA2Zfz2PjX/84oc1sPmIvTiQurfZkNirZBazGa
 o2kDEFU8dy0NGmtem9TseI6HStDooez68qjshIKaEDaYftHQmXQmit10n
 m41d4A9+b978M3PiJktYxBk06HHpSXdotoNNPZ+280KPyNSvnBYEMUKyG g==;
X-CSE-ConnectionGUID: PkSPATPpRTyg4OFhENxSfA==
X-CSE-MsgGUID: Zx8WrlElR9a8ygg1ZxNqRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="90212805"
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="90212805"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 16:58:02 -0700
X-CSE-ConnectionGUID: GZHb0OoPRoiF7EJ7aXeDHA==
X-CSE-MsgGUID: zCeIFhk/Sf64mFYNvO4xTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="300731108"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 16:58:02 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 25 Sep 2026 16:56:35 -0700
Subject: [PATCH iwl-net v3 03/15] ice: fix PHY port restart serialization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-3-6532598e8da8@intel.com>
References: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
In-Reply-To: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=11326;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=7Gd8mbAEBOHI0khATp+betvvG+D8UBm+CrmHdb0zQuI=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqztXBXhkwT9pRNnL9R1TLLg/D9za5Ni50Y+TUe/osK2+
 VMvhyt3lLIwiHExyIopsig4hKy8bjwhTOuNsxzMHFYmkCEMXJwCMJHLExj+qYdsVpu0z7Eoof2V
 v+mnnoW20XufeXnrOlSv+bnN5KyIOcP/2DstiYfqiyvqBdcZT0vQON4n/eriHP5Th4seFFdc7Vv
 HAgA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
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

The ice_port_phy_restart() function is responsible for restarting a PHY
port, primarily after a link transition. PHY ports must also all be
restarted after a reset, and the E822 devices also restart the PHY after
the .settime64 operation.

If a PHY restart occurs concurrently with a link transition, it is possible
that the link state read could be re-ordered such that the link transition
would start the PHY but a concurrent restart (such as from .settime64)
could see the old link state and decide it must stop the PHY.

This occurs because the restart procedure depends on the link state value
but setting that value is not serialized with the per-port ps_lock. A
following fix for E825 is going to modify the .setttime64 to also correctly
restart the PHY timers, opening the E825 device to a race between
.settime64 and a concurrent link change.

To avoid this, we need to ensure that the port link_up field is set within
the same critical section as the restart procedure. This way we ensure that
the end result is the PHY programmed to the correct state.

Additionally note that the PHY restart procedure already cannot run
concurrently across two ports. The procedure requires executing timer
commands which in turn require the PTP hardware semaphore.

Thus, to simplify the locking behavior, convert the per-port ps_lock to a
single mutex in the ice_adapter. Acquire this in ice_ptp_restart_all_phy(),
and hold it while calling ice_ptp_port_phy_stop() and
ice_ptp_port_phy_restart().

The ice_ptp_link_change() function now acquires the port lock for the
entire change. This ensures that the link state is set under lock. Note the
function does also acquire the dplls.lock for E825 devices. This ordering
is safe because the other callers of dplls.lock do not acquire the
ps_lock.

The switch to a single lock for the adapter instead of one per port is
easier to reason about. It also could be a first step in a plan to replace
the PTP hardware semaphore completely, which is under investigation for the
future.

This fixes one of the issues reported by Sashiko during a previous review
of this series, linked here as the Closes tag.

Closes: https://lore.kernel.org/netdev/20260916011228.1632848-1-kuba@kernel.org/
Fixes: 3a7496234d17 ("ice: implement basic E822 PTP support")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adapter.h |  4 ++
 drivers/net/ethernet/intel/ice/ice_ptp.h     |  2 -
 drivers/net/ethernet/intel/ice/ice_adapter.c |  3 ++
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 58 ++++++++++++++--------------
 4 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index 0b01c7f5cf0d..5f39166795b6 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -40,6 +40,7 @@ struct ice_port_list {
  * @txq_ctx_lock: Spinlock protecting access to the GLCOMM_QTX_CNTX_CTL register
  * @cpi_phy_lock: Per-PHY mutex serializing CPI REQ/ACK transactions.
  *               Index 0 = PHY0, index 1 = PHY1. Used on E825C devices.
+ * @ps_lock: Mutex to serialize PHY port start/stop across adapter.
  * @ctrl_pf: Control PF of the adapter
  * @ports: Ports list
  * @index: 64-bit index cached for collision detection on 32bit systems
@@ -53,6 +54,9 @@ struct ice_adapter {
 	/* Serialize CPI REQ/ACK transactions per PHY (E825C only) */
 	struct mutex cpi_phy_lock[ICE_E825_MAX_PHYS];
 
+	/* For serializing PHY port start/stop sequences */
+	struct mutex ps_lock;
+
 	struct ice_pf *ctrl_pf;
 	struct ice_port_list ports;
 	u64 index;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index da2003ba3bb0..27ea502b7576 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -143,7 +143,6 @@ struct ice_ptp_tx {
  * @ref: reference counter for use with adapter ports list
  * @tx: Tx timestamp tracking for this port
  * @ov_work: delayed work task for tracking when PHY offset is valid
- * @ps_lock: mutex used to protect the overall PTP PHY start procedure
  * @link_up: indicates whether the link is up
  * @tx_fifo_busy_cnt: number of times the Tx FIFO was busy
  * @port_num: the port number this structure represents
@@ -155,7 +154,6 @@ struct ice_ptp_port {
 	struct kref ref;
 	struct ice_ptp_tx tx;
 	struct kthread_delayed_work ov_work;
-	struct mutex ps_lock; /* protects overall PTP PHY start procedure */
 	bool link_up;
 	u8 tx_fifo_busy_cnt;
 	u8 port_num;
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index 536923b6ae97..572862fcd247 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -77,6 +77,8 @@ static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
 	spin_lock_init(&adapter->ports.lock);
 	INIT_LIST_HEAD(&adapter->ports.list);
 
+	mutex_init(&adapter->ps_lock);
+
 	return adapter;
 }
 
@@ -87,6 +89,7 @@ static void ice_adapter_free(struct ice_adapter *adapter)
 		mutex_destroy(&adapter->cpi_phy_lock[i]);
 
 	cleanup_srcu_struct(&adapter->ports.srcu);
+	mutex_destroy(&adapter->ps_lock);
 
 	kfree(adapter);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 94a66e9d8c05..adc5308baefc 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1191,6 +1191,8 @@ static void ice_ptp_wait_for_offsets(struct kthread_work *work)
 /**
  * ice_ptp_port_phy_stop - Stop timestamping for a PHY port
  * @ptp_port: PTP port to stop
+ *
+ * Context: must hold the adapter ps_lock.
  */
 static int
 ice_ptp_port_phy_stop(struct ice_ptp_port *ptp_port)
@@ -1200,7 +1202,7 @@ ice_ptp_port_phy_stop(struct ice_ptp_port *ptp_port)
 	struct ice_hw *hw = &pf->hw;
 	int err;
 
-	mutex_lock(&ptp_port->ps_lock);
+	lockdep_assert_held(&pf->adapter->ps_lock);
 
 	switch (hw->mac_type) {
 	case ICE_MAC_E810:
@@ -1222,8 +1224,6 @@ ice_ptp_port_phy_stop(struct ice_ptp_port *ptp_port)
 		dev_err(ice_pf_to_dev(pf), "PTP failed to set PHY port %d down, err %d\n",
 			port, err);
 
-	mutex_unlock(&ptp_port->ps_lock);
-
 	return err;
 }
 
@@ -1234,6 +1234,8 @@ ice_ptp_port_phy_stop(struct ice_ptp_port *ptp_port)
  * Start the PHY timestamping block, and initiate Vernier timestamping
  * calibration. If timestamping cannot be calibrated (such as if link is down)
  * then disable the timestamping block instead.
+ *
+ * Context: must hold the adapter ps_lock.
  */
 static int
 ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
@@ -1244,11 +1246,11 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
 	unsigned long flags;
 	int err;
 
+	lockdep_assert_held(&pf->adapter->ps_lock);
+
 	if (!ptp_port->link_up)
 		return ice_ptp_port_phy_stop(ptp_port);
 
-	mutex_lock(&ptp_port->ps_lock);
-
 	switch (hw->mac_type) {
 	case ICE_MAC_E810:
 	case ICE_MAC_E830:
@@ -1290,8 +1292,6 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
 		dev_err(ice_pf_to_dev(pf), "PTP failed to set PHY port %d up, err %d\n",
 			port, err);
 
-	mutex_unlock(&ptp_port->ps_lock);
-
 	return err;
 }
 
@@ -1310,12 +1310,13 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 
 	ptp_port = &pf->ptp.port;
 
-	/* Update cached link status for this port immediately */
+	mutex_lock(&pf->adapter->ps_lock);
+
 	ptp_port->link_up = linkup;
 
 	/* Skip HW writes if reset is in progress */
 	if (pf->hw.reset_ongoing)
-		return;
+		goto out_unlock;
 
 	if (hw->mac_type == ICE_MAC_GENERIC_3K_E825 &&
 	    test_bit(ICE_FLAG_DPLL, pf->flags)) {
@@ -1358,17 +1359,20 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 	case ICE_MAC_E810:
 	case ICE_MAC_E830:
 		/* Do not reconfigure E810 or E830 PHY */
-		return;
+		break;
 	case ICE_MAC_GENERIC:
 		ice_ptp_port_phy_restart(ptp_port);
-		return;
+		break;
 	case ICE_MAC_GENERIC_3K_E825:
 		if (linkup)
 			ice_ptp_port_phy_restart(ptp_port);
-		return;
+		break;
 	default:
 		dev_warn(ice_pf_to_dev(pf), "%s: Unknown PHY type\n", __func__);
 	}
+
+out_unlock:
+	mutex_unlock(&pf->adapter->ps_lock);
 }
 
 /**
@@ -1434,18 +1438,11 @@ static int ice_ptp_cfg_phy_interrupt(struct ice_pf *pf, bool ena, u32 threshold)
 	}
 }
 
-/**
- * ice_ptp_reset_phy_timestamping - Reset PHY timestamping block
- * @pf: Board private structure
- */
-static void ice_ptp_reset_phy_timestamping(struct ice_pf *pf)
-{
-	ice_ptp_port_phy_restart(&pf->ptp.port);
-}
-
 /**
  * ice_ptp_restart_all_phy - Restart all PHYs to recalibrate timestamping
  * @pf: Board private structure
+ *
+ * Context: acquires the adapter ps_lock
  */
 static void ice_ptp_restart_all_phy(struct ice_pf *pf)
 {
@@ -1453,6 +1450,8 @@ static void ice_ptp_restart_all_phy(struct ice_pf *pf)
 	struct ice_ptp_port *port;
 	int srcu_idx;
 
+	mutex_lock(&pf->adapter->ps_lock);
+
 	srcu_idx = srcu_read_lock(&ports->srcu);
 	list_for_each_entry_srcu(port, &ports->list, list_node,
 				 srcu_read_lock_held(&ports->srcu)) {
@@ -1465,6 +1464,8 @@ static void ice_ptp_restart_all_phy(struct ice_pf *pf)
 		kref_put(&port->ref, ice_ptp_release_port_srcu);
 	}
 	srcu_read_unlock(&ports->srcu, srcu_idx);
+
+	mutex_unlock(&pf->adapter->ps_lock);
 }
 
 /**
@@ -3303,8 +3304,6 @@ static int ice_ptp_init_port(struct ice_pf *pf, struct ice_ptp_port *ptp_port)
 {
 	struct ice_hw *hw = &pf->hw;
 
-	mutex_init(&ptp_port->ps_lock);
-
 	switch (hw->mac_type) {
 	case ICE_MAC_E810:
 	case ICE_MAC_E830:
@@ -3404,14 +3403,16 @@ void ice_ptp_init(struct ice_pf *pf)
 
 	err = ice_ptp_init_port(pf, &ptp->port);
 	if (err)
-		goto err_destroy_ps_lock;
+		goto err_exit;
 
 	err = ice_ptp_setup_pf(pf);
 	if (err)
 		goto err_release_tx_tracker;
 
 	/* Start the PHY timestamping block */
-	ice_ptp_reset_phy_timestamping(pf);
+	mutex_lock(&pf->adapter->ps_lock);
+	ice_ptp_port_phy_restart(&ptp->port);
+	mutex_unlock(&pf->adapter->ps_lock);
 
 	/* Configure initial Tx interrupt settings */
 	ice_ptp_cfg_tx_interrupt(pf);
@@ -3429,8 +3430,6 @@ void ice_ptp_init(struct ice_pf *pf)
 	ice_ptp_cleanup_pf(pf);
 err_release_tx_tracker:
 	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
-err_destroy_ps_lock:
-	mutex_destroy(&ptp->port.ps_lock);
 err_exit:
 	/* If we registered a PTP clock, release it */
 	if (pf->ptp.clock) {
@@ -3470,7 +3469,6 @@ void ice_ptp_release(struct ice_pf *pf)
 		}
 		ice_ptp_cleanup_pf(pf);
 		ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
-		mutex_destroy(&pf->ptp.port.ps_lock);
 		return;
 	}
 
@@ -3487,8 +3485,10 @@ void ice_ptp_release(struct ice_pf *pf)
 
 	kthread_cancel_delayed_work_sync(&pf->ptp.work);
 
+	mutex_lock(&pf->adapter->ps_lock);
 	ice_ptp_port_phy_stop(&pf->ptp.port);
-	mutex_destroy(&pf->ptp.port.ps_lock);
+	mutex_unlock(&pf->adapter->ps_lock);
+
 	if (pf->ptp.kworker) {
 		kthread_destroy_worker(pf->ptp.kworker);
 		pf->ptp.kworker = NULL;

-- 
2.56.0.rc0.395.gd1f3524e15dc

