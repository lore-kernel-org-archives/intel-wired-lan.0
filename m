Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A7FBC531FA
	for <intel-wired-lan@archiver.kernel.org>; Fri, 24 Jul 2026 09:36:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F4DF60B24;
	Fri, 24 Jul 2026 09:36:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5aSTbt9Ud8vh; Fri, 24 Jul 2026 09:36:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4D094608F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784885771;
	bh=Ivn5Gk6yE8DxTWuC/EZlIOFn8HhK0+HKO/FrtWqoBWA=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LV8FXfwoTM3JyruylqdV/qqABaUQwanoFXLP39uALyu13VMEW7Nnebp0NAowIhqe1
	 LtFEEdcHLNmDNQDd8PXfy2IN4YfeGJX2rwrO9mUIA1cn510NvHGb9yYPVb4YhRQehw
	 sNSSL/gPDYgV62Qas5qNptXzpKFesyy88A0Z2h8fr8xgOIQfIbmvc7b11A15rfA3E/
	 re+RjPkzAIpIC76lF9YA0dg1W6JKln2AQic9tMWPZATYJrleGvExwpwb2oS4E0++L4
	 I/5/fIrvd01r5U7aIwETBxD+KIJF+065tcjMx9yFT1grRG91L/veYC5FTwkr86sTNF
	 0MZaJt148Ccig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D094608F0;
	Fri, 24 Jul 2026 09:36:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 49F6A224
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Jul 2026 09:36:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2FEE581113
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Jul 2026 09:36:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mPvqGpmkaqdt for <intel-wired-lan@lists.osuosl.org>;
 Fri, 24 Jul 2026 09:36:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.186;
 helo=out-186.mta1.migadu.com; envelope-from=xuanqiang.luo@linux.dev;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C295381152
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C295381152
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com
 [95.215.58.186])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C295381152
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Jul 2026 09:36:08 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: xuanqiang.luo@linux.dev
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 richardcochran@gmail.com, piotr.kwapulinski@intel.com,
 arkadiusz.kubalewski@intel.com, aleksandr.loktionov@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Date: Fri, 24 Jul 2026 17:34:48 +0800
Message-ID: <20260724093448.63154-1-xuanqiang.luo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1784885765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ivn5Gk6yE8DxTWuC/EZlIOFn8HhK0+HKO/FrtWqoBWA=;
 b=O8AgvNUOx/WX+OWHPpXPAXxRf4p/GeXtHh8se90E6t4x/wZiFC9mh9OigkIjqtTW5kTBhw
 8t8G6M2S9xIX4wiNAA+MgrN0tgpga8Wkv0J732rpaqdbqnTwmgtgUzBKLTXgYVKStddKqC
 /A3EMcQJ7XaUTUiy39RO0Xkp/oW1JcQ=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=O8AgvNUO
Subject: [Intel-wired-lan] [PATCH iwl-net v1] i40e: fix races in PTP
 external timestamp work handling
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

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

The time sync interrupt queues ptp_extts0_work, which reads device
registers and reports events through pf->ptp_clock.

i40e_ptp_stop() unregisters the PHC without first disabling the event
source or draining the work. The worker can therefore access the clock or
PF after either has been freed, causing a use-after-free. Disable external
timestamp events and call disable_work_sync() before unregistering the PHC.
Disabling the work also prevents an interrupt already in progress from
queuing it after the drain.

INIT_WORK() is called from i40e_ptp_set_timestamp_mode(), which runs on
reset and whenever timestamping is reconfigured. Reinitializing pending or
running work can corrupt its workqueue state. Initialize the work once from
i40e_sw_init() instead.

Also exclude reset recovery before stopping PTP so a concurrent rebuild
cannot re-enable timestamp events or recreate the PHC during removal.

Fixes: 1050713026a0 ("i40e: add support for PTP external synchronization clock")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/ethernet/intel/i40e/i40e.h      |  1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c | 17 +++++++-------
 drivers/net/ethernet/intel/i40e/i40e_ptp.c  | 25 +++++++++++++++------
 3 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 83e780919ac97..e2ae61bc38786 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1315,6 +1315,7 @@ int i40e_ptp_hwtstamp_set(struct net_device *netdev,
 			  struct netlink_ext_ack *extack);
 void i40e_ptp_save_hw_time(struct i40e_pf *pf);
 void i40e_ptp_restore_hw_time(struct i40e_pf *pf);
+void i40e_ptp_init_work(struct i40e_pf *pf);
 void i40e_ptp_init(struct i40e_pf *pf);
 void i40e_ptp_stop(struct i40e_pf *pf);
 int i40e_ptp_alloc_pins(struct i40e_pf *pf);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a04683004a567..2909a58d57562 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -12819,6 +12819,7 @@ static int i40e_sw_init(struct i40e_pf *pf)
 			 "total-port-shutdown was enabled, link-down-on-close is forced on\n");
 	}
 	mutex_init(&pf->switch_mutex);
+	i40e_ptp_init_work(pf);
 
 sw_init_done:
 	return err;
@@ -16157,14 +16158,6 @@ static void i40e_remove(struct pci_dev *pdev)
 
 	i40e_devlink_unregister(pf);
 
-	i40e_dbg_pf_exit(pf);
-
-	i40e_ptp_stop(pf);
-
-	/* Disable RSS in hw */
-	i40e_write_rx_ctl(hw, I40E_PFQF_HENA(0), 0);
-	i40e_write_rx_ctl(hw, I40E_PFQF_HENA(1), 0);
-
 	/* Grab __I40E_RESET_RECOVERY_PENDING and set __I40E_IN_REMOVE
 	 * flags, once they are set, i40e_rebuild should not be called as
 	 * i40e_prep_for_reset always returns early.
@@ -16173,6 +16166,14 @@ static void i40e_remove(struct pci_dev *pdev)
 		usleep_range(1000, 2000);
 	set_bit(__I40E_IN_REMOVE, pf->state);
 
+	i40e_dbg_pf_exit(pf);
+
+	i40e_ptp_stop(pf);
+
+	/* Disable RSS in hw */
+	i40e_write_rx_ctl(hw, I40E_PFQF_HENA(0), 0);
+	i40e_write_rx_ctl(hw, I40E_PFQF_HENA(1), 0);
+
 	if (test_bit(I40E_FLAG_SRIOV_ENA, pf->flags)) {
 		set_bit(__I40E_VF_RESETS_DISABLED, pf->state);
 		i40e_free_vfs(pf);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index ff62b5f2c8150..fd51ab8c10c20 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -169,6 +169,17 @@ static void i40e_ptp_extts0_work(struct work_struct *work)
 	ptp_clock_event(pf->ptp_clock, &event);
 }
 
+/**
+ * i40e_ptp_init_work - Initialize PTP work for a PF
+ * @pf: Board private structure
+ *
+ * Initialize work which must remain valid for the lifetime of the PF.
+ */
+void i40e_ptp_init_work(struct i40e_pf *pf)
+{
+	INIT_WORK(&pf->ptp_extts0_work, i40e_ptp_extts0_work);
+}
+
 /**
  * i40e_is_ptp_pin_dev - check if device supports PTP pins
  * @hw: pointer to the hardware structure
@@ -1186,8 +1197,6 @@ static int i40e_ptp_set_timestamp_mode(struct i40e_pf *pf,
 	regval |= 1 << I40E_PRTTSYN_CTL0_EVENT_INT_ENA_SHIFT;
 	wr32(hw, I40E_PRTTSYN_CTL0, regval);
 
-	INIT_WORK(&pf->ptp_extts0_work, i40e_ptp_extts0_work);
-
 	switch (config->tx_type) {
 	case HWTSTAMP_TX_OFF:
 		pf->ptp_tx = false;
@@ -1541,6 +1550,13 @@ void i40e_ptp_stop(struct i40e_pf *pf)
 	struct i40e_hw *hw = &pf->hw;
 	u32 regval;
 
+	/* Stop external timestamp events before unregistering the clock. */
+	regval = rd32(hw, I40E_PRTTSYN_CTL0);
+	regval &= ~I40E_PRTTSYN_CTL0_EVENT_INT_ENA_MASK;
+	wr32(hw, I40E_PRTTSYN_CTL0, regval);
+
+	disable_work_sync(&pf->ptp_extts0_work);
+
 	clear_bit(I40E_FLAG_PTP_ENA, pf->flags);
 	pf->ptp_tx = false;
 	pf->ptp_rx = false;
@@ -1570,10 +1586,5 @@ void i40e_ptp_stop(struct i40e_pf *pf)
 	regval &= ~I40E_PRTTSYN_AUX_0_PTPFLAG_MASK;
 	wr32(hw, I40E_PRTTSYN_AUX_0(0), regval);
 
-	/* Disable interrupts */
-	regval = rd32(hw, I40E_PRTTSYN_CTL0);
-	regval &= ~I40E_PRTTSYN_CTL0_EVENT_INT_ENA_MASK;
-	wr32(hw, I40E_PRTTSYN_CTL0, regval);
-
 	i40e_ptp_free_pins(pf);
 }
-- 
2.43.0

