Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68426C55822
	for <intel-wired-lan@archiver.kernel.org>; Wed,  5 Aug 2026 06:53:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3763E6078B;
	Wed,  5 Aug 2026 06:53:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BjwrVNOLsfqf; Wed,  5 Aug 2026 06:53:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 306CC60770
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785912785;
	bh=+EQTtWgrsaKUEW5GmngOUgOvaosfIxELLzA0tSOpboA=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fvOPzr5CXHoQxgI0YkA6rRmKYnrQ969tDQGj/tEYIWJnIvNUcygmpEvgkThwrak9i
	 wMhYACKTrD3lLJas6FZe1EeBwVNYb5Almj85P/RXU8frzAQggeAUMcc0otgXeTODHT
	 vzpd+QGYnw2XkMkvpuu0ptTb4pUxuIu+sdGD8OP5WJAxnrhPBNnMmv3gRUsi7bPLPr
	 lmvrep573lRYkf6/E/SSSVs5eq5GFdqjqJYYfwVuM/TuGrob0r7/tq0OWVuW2vh7jK
	 J438e24BqEhjk4vWtCNE1qt3jVczTD274FYm15pWFpCJFnsnB9k+08EMAXRpci9ffH
	 burIgKLuQLnlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 306CC60770;
	Wed,  5 Aug 2026 06:53:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C11E7218
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 06:53:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B2FF480B3C
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 06:53:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pejSnO4A4EUA for <intel-wired-lan@lists.osuosl.org>;
 Wed,  5 Aug 2026 06:53:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.187;
 helo=out-187.mta1.migadu.com; envelope-from=xuanqiang.luo@linux.dev;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 02EE980AA1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 02EE980AA1
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com
 [95.215.58.187])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 02EE980AA1
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 06:53:01 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: xuanqiang.luo@linux.dev
To: intel-wired-lan@lists.osuosl.org,
	horms@kernel.org
Cc: vadim.fedorenko@linux.dev, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, piotr.kwapulinski@intel.com,
 arkadiusz.kubalewski@intel.com, aleksandr.loktionov@intel.com,
 netdev@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Date: Wed,  5 Aug 2026 14:51:32 +0800
Message-ID: <20260805065132.148625-6-xuanqiang.luo@linux.dev>
In-Reply-To: <20260805065132.148625-1-xuanqiang.luo@linux.dev>
References: <20260805065132.148625-1-xuanqiang.luo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1785912779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+EQTtWgrsaKUEW5GmngOUgOvaosfIxELLzA0tSOpboA=;
 b=X9gdgtbAHDOHcJD7LZ8khRbKH3lPNb/Hp6VX1wNFDxK74t3E1AN3u6lO9O1m7wBfphdgWe
 vyV8iTkAufGtZacL0w04rOEP6LVV8/lnutjO4SVEeyu+aT4RdpkyBF3iqHNpsN1ON/8pOR
 uEZ57ObN4QbwZpIX6s4+S9OfukQySv8=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=X9gdgtbA
Subject: [Intel-wired-lan] [PATCH iwl-net v2 5/5] i40e: fix races in PTP
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
registers and reports events through pf->ptp_clock. i40e_ptp_stop()
unregisters the PHC before disabling the event source or draining the
work. The worker can therefore use the clock or PF after either has been
freed.

Move the event-source shutdown before PHC unregister. i40e_ptp_stop()
first clears I40E_FLAG_PTP_ENA under ptp_config_lock, so timestamp
configuration cannot re-enable the source after the lock is released.
Then call disable_work_sync() to reject later queue attempts and drain
work already pending or running.

INIT_WORK() is currently called from i40e_ptp_set_timestamp_mode(), which
runs on reset and whenever timestamping is reconfigured. Reinitializing
pending or running work can corrupt its workqueue state. Initialize the
work once from i40e_sw_init() instead.

Fixes: 1050713026a0 ("i40e: add support for PTP external synchronization clock")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/ethernet/intel/i40e/i40e.h      |  1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c |  1 +
 drivers/net/ethernet/intel/i40e/i40e_ptp.c  | 25 +++++++++++++++------
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 84564d747d09a..18452f9aa74e1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1318,6 +1318,7 @@ int i40e_ptp_hwtstamp_set(struct net_device *netdev,
 			  struct netlink_ext_ack *extack);
 void i40e_ptp_save_hw_time(struct i40e_pf *pf);
 void i40e_ptp_restore_hw_time(struct i40e_pf *pf);
+void i40e_ptp_init_work(struct i40e_pf *pf);
 void i40e_ptp_init(struct i40e_pf *pf);
 void i40e_ptp_stop(struct i40e_pf *pf);
 int i40e_ptp_alloc_pins(struct i40e_pf *pf);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index c19d4c81d6532..48ba38a452d0b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -12822,6 +12822,7 @@ static int i40e_sw_init(struct i40e_pf *pf)
 	}
 	mutex_init(&pf->switch_mutex);
 	mutex_init(&pf->ptp_config_lock);
+	i40e_ptp_init_work(pf);
 	spin_lock_init(&pf->ptp_tx_lock);
 
 sw_init_done:
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index f194869947124..5f15a3d4a91ed 100644
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
@@ -1201,8 +1212,6 @@ static int i40e_ptp_set_timestamp_mode(struct i40e_pf *pf,
 	regval |= 1 << I40E_PRTTSYN_CTL0_EVENT_INT_ENA_SHIFT;
 	wr32(hw, I40E_PRTTSYN_CTL0, regval);
 
-	INIT_WORK(&pf->ptp_extts0_work, i40e_ptp_extts0_work);
-
 	switch (config->tx_type) {
 	case HWTSTAMP_TX_OFF:
 		pf->ptp_tx = false;
@@ -1576,6 +1585,13 @@ void i40e_ptp_stop(struct i40e_pf *pf)
 	pf->ptp_rx = false;
 	mutex_unlock(&pf->ptp_config_lock);
 
+	/* Stop external timestamp events before unregistering the clock. */
+	regval = rd32(hw, I40E_PRTTSYN_CTL0);
+	regval &= ~I40E_PRTTSYN_CTL0_EVENT_INT_ENA_MASK;
+	wr32(hw, I40E_PRTTSYN_CTL0, regval);
+
+	disable_work_sync(&pf->ptp_extts0_work);
+
 	if (skb)
 		dev_kfree_skb_any(skb);
 
@@ -1596,10 +1612,5 @@ void i40e_ptp_stop(struct i40e_pf *pf)
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

