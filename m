Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFACEB64DC
	for <intel-wired-lan@archiver.kernel.org>; Tue, 18 Jul 2023 14:10:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88FE060FBB;
	Tue, 18 Jul 2023 14:10:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 88FE060FBB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1689689414;
	bh=tK5bcEwVxR9C9/D2afYy8DwMPiInymvhW/kyIZarD3s=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=vJq8YQ884e4FdXr+mfUfuGaSEeYL1k2z+frCAg1tdHpraMPnVd6W5O+ESAEy3s9jA
	 0d/XmjFwRGzHAPz3l4ue5PQy9uVfBsm5H2ZuxvCR1HBC8PERmB4Z6O/qm20xm01bYH
	 W9VXLaGmmaIf8IUZgjMYXJotFdTeETnmQzt1unG2paUL/aTuoplTDYmWnHfXBxuNw4
	 Q1kFSlhZa77DGq48JpTI/DdEohCrZWYomtDo5lg8hza3Eo/ktse9gkglZ0s4VsQwpW
	 qmZ1Ad1T90xNSncdw0bloMtfv5yLrtiWqU2D+zKNrsfPvLwws6sRaj5BhP6RVwoNFz
	 7gz6CCk9Jcrnw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B0diMNwJv8Re; Tue, 18 Jul 2023 14:10:13 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8894260FBC;
	Tue, 18 Jul 2023 14:10:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8894260FBC
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 263FB1BF831
 for <intel-wired-lan@osuosl.org>; Tue, 18 Jul 2023 14:10:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 021BB8138E
 for <intel-wired-lan@osuosl.org>; Tue, 18 Jul 2023 14:10:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 021BB8138E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RIt9oSnkr0by for <intel-wired-lan@osuosl.org>;
 Tue, 18 Jul 2023 14:10:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4963F81382
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4963F81382
 for <intel-wired-lan@osuosl.org>; Tue, 18 Jul 2023 14:10:11 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="365093014"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; d="scan'208";a="365093014"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2023 07:10:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; d="scan'208";a="867086576"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.82])
 by fmsmga001.fm.intel.com with ESMTP; 18 Jul 2023 07:10:09 -0700
From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
To: intel-wired-lan@osuosl.org
Date: Tue, 18 Jul 2023 22:08:44 +0800
Message-Id: <20230718140844.24379-1-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689689411; x=1721225411;
 h=from:to:cc:subject:date:message-id;
 bh=xwyZpvEXEUqeeu62QUAl+s/YGL2K8VTonjnSbivpHbM=;
 b=TjrHjTG9/XYE3bN+708DuPHY8Xen/QnGyMqgXBvJ5ljE7AkGyFg55NhT
 vvtMBTK3gJTLpkuIwK68UP5nd8yg5WRyqZl8cVU4memMMoHNBPHaelKLX
 HjmfvtjsSvy7JfYsKRIm9VpSxKZ/i9mqn18CsZkADsRaWAuBm2Wj36kq5
 f6+sUIUb5HWJj8p1um065Por0jkNVJaFqij3gUFuyLHwGUX6Aqd2ilXOx
 PKIAKbcTSohDK2NW4TG7hIFUuRps4q5+2RwyzGhAbCqVUiPGKFN288lW+
 L4FbaKcg4stYLsQVaZjorVR0K5Qenyt5rFuFF6mVfpevw0X2c8tPn3nHJ
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=TjrHjTG9
Subject: [Intel-wired-lan] [PATCH iwl-net v2] igc: Add lock to safeguard
 global Qbv variables
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
Cc: leon@kernel.org, anthony.l.nguyen@intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Access to shared variables through hrtimer requires locking in order
to protect the variables because actions to write into these variables
(oper_gate_closed, admin_gate_closed, and qbv_transition) might potentially
occur simultaneously. This patch provides a locking mechanisms to avoid
such scenarios.

Fixes: 175c241288c0 ("igc: Fix TX Hang issue when QBV Gate is closed")
Suggested-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
---
V1 -> V2: Add locks to location that used the variables as suggested by
Leon. Improved the readibility of code in igc_tsn_clear_schedule() by
separating the qbv portion into a different function.
---
 drivers/net/ethernet/intel/igc/igc.h      |  4 +++
 drivers/net/ethernet/intel/igc/igc_main.c | 34 +++++++++++++++++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 9db384f66a8e..38901d2a4680 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -195,6 +195,10 @@ struct igc_adapter {
 	u32 qbv_config_change_errors;
 	bool qbv_transition;
 	unsigned int qbv_count;
+	/* Access to oper_gate_closed, admin_gate_closed and qbv_transition
+	 * are protected by the qbv_tx_lock.
+	 */
+	spinlock_t qbv_tx_lock;
 
 	/* OS defined structs */
 	struct pci_dev *pdev;
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index bdeb36790d77..6f557e843e49 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -4801,6 +4801,7 @@ static int igc_sw_init(struct igc_adapter *adapter)
 	adapter->nfc_rule_count = 0;
 
 	spin_lock_init(&adapter->stats64_lock);
+	spin_lock_init(&adapter->qbv_tx_lock);
 	/* Assume MSI-X interrupts, will be checked during IRQ allocation */
 	adapter->flags |= IGC_FLAG_HAS_MSIX;
 
@@ -6119,15 +6120,15 @@ static int igc_tsn_enable_launchtime(struct igc_adapter *adapter,
 	return igc_tsn_offload_apply(adapter);
 }
 
-static int igc_tsn_clear_schedule(struct igc_adapter *adapter)
+static int igc_qbv_clear_schedule(struct igc_adapter *adapter)
 {
+	unsigned long flags;
 	int i;
 
 	adapter->base_time = 0;
 	adapter->cycle_time = NSEC_PER_SEC;
 	adapter->taprio_offload_enable = false;
 	adapter->qbv_config_change_errors = 0;
-	adapter->qbv_transition = false;
 	adapter->qbv_count = 0;
 
 	for (i = 0; i < adapter->num_tx_queues; i++) {
@@ -6136,10 +6137,28 @@ static int igc_tsn_clear_schedule(struct igc_adapter *adapter)
 		ring->start_time = 0;
 		ring->end_time = NSEC_PER_SEC;
 		ring->max_sdu = 0;
+	}
+
+	spin_lock_irqsave(&adapter->qbv_tx_lock, flags);
+
+	adapter->qbv_transition = false;
+
+	for (i = 0; i < adapter->num_tx_queues; i++) {
+		struct igc_ring *ring = adapter->tx_ring[i];
+
 		ring->oper_gate_closed = false;
 		ring->admin_gate_closed = false;
 	}
 
+	spin_unlock_irqrestore(&adapter->qbv_tx_lock, flags);
+
+	return 0;
+}
+
+static int igc_tsn_clear_schedule(struct igc_adapter *adapter)
+{
+	igc_qbv_clear_schedule(adapter);
+
 	return 0;
 }
 
@@ -6150,6 +6169,7 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 	struct igc_hw *hw = &adapter->hw;
 	u32 start_time = 0, end_time = 0;
 	struct timespec64 now;
+	unsigned long flags;
 	size_t n;
 	int i;
 
@@ -6217,6 +6237,8 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 		start_time += e->interval;
 	}
 
+	spin_lock_irqsave(&adapter->qbv_tx_lock, flags);
+
 	/* Check whether a queue gets configured.
 	 * If not, set the start and end time to be end time.
 	 */
@@ -6241,6 +6263,8 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 		}
 	}
 
+	spin_unlock_irqrestore(&adapter->qbv_tx_lock, flags);
+
 	for (i = 0; i < adapter->num_tx_queues; i++) {
 		struct igc_ring *ring = adapter->tx_ring[i];
 		struct net_device *dev = adapter->netdev;
@@ -6619,8 +6643,11 @@ static enum hrtimer_restart igc_qbv_scheduling_timer(struct hrtimer *timer)
 {
 	struct igc_adapter *adapter = container_of(timer, struct igc_adapter,
 						   hrtimer);
+	unsigned long flags;
 	unsigned int i;
 
+	spin_lock_irqsave(&adapter->qbv_tx_lock, flags);
+
 	adapter->qbv_transition = true;
 	for (i = 0; i < adapter->num_tx_queues; i++) {
 		struct igc_ring *tx_ring = adapter->tx_ring[i];
@@ -6633,6 +6660,9 @@ static enum hrtimer_restart igc_qbv_scheduling_timer(struct hrtimer *timer)
 		}
 	}
 	adapter->qbv_transition = false;
+
+	spin_unlock_irqrestore(&adapter->qbv_tx_lock, flags);
+
 	return HRTIMER_NORESTART;
 }
 
-- 
2.17.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
