Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09EE60A2623
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=1z0Fcg7D;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=WxwmS038
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D48FA60D86;
	Thu, 19 Nov 2026 14:04:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nO3jEgDHig1w; Thu, 19 Nov 2026 14:04:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BF74360D72
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795097069;
	b=KNaGBShoD18x0aJUvuUjZTfn3+EhDlBFFx6EnHUSzMvstppqMWky9bqr2Kjl/GLadCB2
	 DAeIEmmhb7GnM2Y5zzNPc3GdQGUECXA8o6+m5i9Mlq6tiymoAwFvq/rVuewPYjebMLv8D
	 oFRCuBIbmquoHt/nNqK9DxiIXvYW+dJmR/8nLCJC/m3JWQsU4x9q+3xFeJRHTc61kZOgq
	 m3i5k2A4ofnFRGCv0xfEmQg+P8WT19fY+WHImhpNaMHGyJe20vPHhCETBPhnzRioKnw64
	 MXQbBU3CNcU9Kklec3hxbyHqqfmXLAq4mEfIYCp2qveIJn6ukLd0InEHcJpvX/LCI6w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795097069;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=cQV2dz+JqnEVXO1O2PQAi/YzUkmEDMH8+rKBoeA+Dbk=;
	b=JcpoIYrvY1nMqb4gJIrdl92YI585QBDrLoQjGClbNS3mBpKHo9qEfPdzj/yHbFe1Ots2
	 4NoL5TPqkCDI2/TZXJ7QBxrXzpG7wq/6G8eb9Ofoop77UeR1SO+oJlhKsGjmLJkApaVQe
	 lUY8P6V2+eCvHsP91+6Tf2WmbigfDh2nOglrOqkj3yAjRAGjesk7axbDeouYSBsoVdMFX
	 QpDasM8Y8vkbCdulGvRD0rhIK7J8xT0uymiN++8rQwXG+ItwpfKTA3/Ra0vdjsLd7c4Mu
	 FD9gjYheJ+iCHqkoeJUw0WDZ0oXPXMHrxwXGG+HHrRi6x84+Dt1VrBtUpZqHLsA7m8g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795097069;
	bh=cQV2dz+JqnEVXO1O2PQAi/YzUkmEDMH8+rKBoeA+Dbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1z0Fcg7DBU2sGmUUVU94Bdf9rnf5QJ9wvlV4USW2XCcMKW6jZnSSV3Mb7JIQStht/
	 U/6ZW2lQOOANCL35czefc00caitO7FtXMFxKCHdliHhGSfr1sZi3qQzOXevzd37oxJ
	 oov4JQFnjcrUnNH79HX4IF0WYsipJwRjfoUmsbAwocO2sKp+UK0Q5Wtpgl5bBT97Hl
	 /P/zRoVrR+LnxqUzTEoHrekWdJ4LWRBYJgQ6POtN1PNuj5rLFS4nFl1p9Bo1OXIh6s
	 qDRaQFMCUiYP2/dQoAPLHHNfxt57sgjwAHldOk7ewwVuWMjXegOEOVhB/pDqY2zS/j
	 r/0LyGapaREqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF74360D72;
	Thu, 19 Nov 2026 14:04:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 662B01C9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:04:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 569C640555
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:04:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 50ANL6s-VLEL for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 14:04:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A688840577
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:102:465::107"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:102:465::107; helo=mout-b-107.mailbox.org;
 envelope-from=antonio@mandelbit.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mandelbit.com header.i=@mandelbit.com
 header.a=rsa-sha256 header.s=MBO0001 header.b=WxwmS038
Received: from mout-b-107.mailbox.org (mout-b-107.mailbox.org
 [IPv6:2001:67c:2050:102:465::107])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A688840577
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:04:24 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4jVgFJ5wZvz3y2s;
 Thu, 19 Nov 2026 15:04:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1795097060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cQV2dz+JqnEVXO1O2PQAi/YzUkmEDMH8+rKBoeA+Dbk=;
 b=WxwmS038grhWtcZHyl7KQIppDELHY2zZ8YLz9fankozZz9pmAKDDCMXLj/KiFZmvmaCdLm
 sSRh9Y0ixblAckBMHbIPmW5WPYPZKjxVDVIh/KJLNKZJaLTu5nU31vS485HsXSi9ebgser
 gVFgRJ4LsrHmDlJS/3dXqTrazIrivHxGC0QFuY67WhtW7k2vMlGbmJeKLa5h0VgXpDgvx+
 8qkQm6oJWt8eXnJ8MBxIAjhfYiN8sZqxqBq+6i0InqtJBiR/2CMx/9kUUMnjhhj6tMQUHs
 eeNyfTdOzlxbp4brbVcokzvFNxUp/DKi6gV0TEtwkgDG498zat7A1mL3a9aIuw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=antonio@mandelbit.com
From: Antonio Quartulli <antonio@mandelbit.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Antonio Quartulli <antonio@mandelbit.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Janis Edvarts Lacis <janislacis06@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH net v3 2/4] igb: fix RTNL assertion when resuming from runtime
 suspend
Date: Thu, 19 Nov 2026 15:04:08 +0100
Message-ID: <20261119140412.163202-3-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119140412.163202-1-antonio@mandelbit.com>
References: <20261119140412.163202-1-antonio@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jVgFJ5wZvz3y2s
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since commit ac8c58f5b535 ("igb: fix deadlock caused by taking RTNL in
RPM resume path") __igb_resume() doesn't take RTNL for runtime resume,
but __igb_open() still calls netif_set_real_num_{tx,rx}_queues(), which
require it. An asynchronous runtime resume (e.g. after the link comes
back) then triggers "RTNL: assertion failed".

Only set the real queue counts in __igb_open() when RTNL is held (open
and system sleep resume), and set them from a work item taking RTNL on
runtime resume. Until it runs, after a fallback to fewer queues on
resume (MSI-X to MSI), the stack can use queues the device doesn't
have: drop those packets in igb_xmit_frame() instead of mapping several
stack queues, each with its own xmit lock, onto the same ring. The
stack can't be kept off those queues instead, as __igb_open() and
netif_device_attach() start all of them and changing the count needs
RTNL.

Tested with the 82576 emulated by QEMU.

Fixes: ac8c58f5b535 ("igb: fix deadlock caused by taking RTNL in RPM resume path")
Cc: stable@vger.kernel.org
Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
v3:
- set the real queue counts when RTNL is held (open and system sleep
  resume), and from a work item on runtime resume, instead of not at all
  on resume (Janis, Sashiko)
- until then, drop packets for queues the device doesn't have
- stable: netif_set_real_num_queues() needs 5.15+ and
  dev_core_stats_tx_dropped_inc() 5.18+; older backports can use the
  separate tx/rx calls and netdev->stats.tx_dropped
v2:
- keep setting the queue counts in __igb_open() after igb_request_irq(),
  only skipping them on resume (Sashiko)
- drop the reference to igc

Note: igc has the same issue: it sets the real queue counts only in
igc_open(), before requesting the IRQs, and never on resume. A fix will
follow separately once it has been tested on igc hardware (Joe offered
to test).

 drivers/net/ethernet/intel/igb/igb.h      |  1 +
 drivers/net/ethernet/intel/igb/igb_main.c | 73 ++++++++++++++++-------
 2 files changed, 54 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 8c9b020..79d7fcc 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -586,6 +586,7 @@ struct igb_adapter {
 
 	struct work_struct reset_task;
 	struct work_struct watchdog_task;
+	struct work_struct rtnl_resume_task;
 	bool fc_autoneg;
 	u8  tx_timeout_factor;
 	struct timer_list blink_timer;
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index d4a897a..2f51edc 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -110,6 +110,7 @@ static void igb_init_queue_configuration(struct igb_adapter *adapter);
 static int igb_sw_init(struct igb_adapter *);
 int igb_open(struct net_device *);
 int igb_close(struct net_device *);
+static void igb_rtnl_resume_task(struct work_struct *);
 static void igb_configure(struct igb_adapter *);
 static void igb_configure_tx(struct igb_adapter *);
 static void igb_configure_rx(struct igb_adapter *);
@@ -3426,6 +3427,7 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	INIT_WORK(&adapter->reset_task, igb_reset_task);
 	INIT_WORK(&adapter->watchdog_task, igb_watchdog_task);
+	INIT_WORK(&adapter->rtnl_resume_task, igb_rtnl_resume_task);
 
 	/* Initialize link properties that are user-changeable */
 	adapter->fc_autoneg = true;
@@ -3889,6 +3891,7 @@ static void igb_remove(struct pci_dev *pdev)
 
 	cancel_work_sync(&adapter->reset_task);
 	cancel_work_sync(&adapter->watchdog_task);
+	cancel_work_sync(&adapter->rtnl_resume_task);
 
 #ifdef CONFIG_IGB_DCA
 	if (adapter->flags & IGB_FLAG_DCA_ENABLED) {
@@ -4123,10 +4126,31 @@ static int igb_sw_init(struct igb_adapter *adapter)
 	return 0;
 }
 
+/* Some settings need RTNL, which isn't held when resuming from runtime
+ * suspend: apply them from here instead, if the device is still up.
+ */
+static void igb_rtnl_resume_task(struct work_struct *work)
+{
+	struct igb_adapter *adapter = container_of(work, struct igb_adapter,
+						   rtnl_resume_task);
+
+	rtnl_lock();
+	if (!test_bit(__IGB_DOWN, &adapter->state) &&
+	    netif_running(adapter->netdev)) {
+		if (netif_set_real_num_queues(adapter->netdev,
+					      adapter->num_tx_queues,
+					      adapter->num_rx_queues))
+			netdev_err(adapter->netdev,
+				   "error setting real queue count\n");
+	}
+	rtnl_unlock();
+}
+
 /**
  *  __igb_open - Called when a network interface is made active
  *  @netdev: network interface device structure
  *  @resuming: indicates whether we are in a resume call
+ *  @rtnl_held: indicates whether RTNL is held
  *
  *  Returns 0 on success, negative value on failure
  *
@@ -4136,7 +4160,8 @@ static int igb_sw_init(struct igb_adapter *adapter)
  *  handler is registered with the OS, the watchdog timer is started,
  *  and the stack is notified that the interface is ready.
  **/
-static int __igb_open(struct net_device *netdev, bool resuming)
+static int __igb_open(struct net_device *netdev, bool resuming,
+		      bool rtnl_held)
 {
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	struct pci_dev *pdev = adapter->pdev;
@@ -4179,16 +4204,15 @@ static int __igb_open(struct net_device *netdev, bool resuming)
 	if (err)
 		goto err_req_irq;
 
-	/* Notify the stack of the actual queue counts. */
-	err = netif_set_real_num_tx_queues(adapter->netdev,
-					   adapter->num_tx_queues);
-	if (err)
-		goto err_set_queues;
-
-	err = netif_set_real_num_rx_queues(adapter->netdev,
-					   adapter->num_rx_queues);
-	if (err)
-		goto err_set_queues;
+	/* Notify the stack of the actual queue counts. This needs RTNL: on
+	 * runtime resume igb_rtnl_resume_task() does it.
+	 */
+	if (rtnl_held) {
+		err = netif_set_real_num_queues(netdev, adapter->num_tx_queues,
+						adapter->num_rx_queues);
+		if (err)
+			goto err_set_queues;
+	}
 
 	/* From here on the code is the same as igb_up() */
 	clear_bit(__IGB_DOWN, &adapter->state);
@@ -4242,7 +4266,7 @@ err_setup_tx:
 
 int igb_open(struct net_device *netdev)
 {
-	return __igb_open(netdev, false);
+	return __igb_open(netdev, false, true);
 }
 
 /**
@@ -6617,12 +6641,7 @@ cleanup_tx_tstamp:
 static inline struct igb_ring *igb_tx_queue_mapping(struct igb_adapter *adapter,
 						    struct sk_buff *skb)
 {
-	unsigned int r_idx = skb->queue_mapping;
-
-	if (r_idx >= adapter->num_tx_queues)
-		r_idx = r_idx % adapter->num_tx_queues;
-
-	return adapter->tx_ring[r_idx];
+	return adapter->tx_ring[skb->queue_mapping];
 }
 
 static netdev_tx_t igb_xmit_frame(struct sk_buff *skb,
@@ -6636,6 +6655,17 @@ static netdev_tx_t igb_xmit_frame(struct sk_buff *skb,
 	if (skb_put_padto(skb, 17))
 		return NETDEV_TX_OK;
 
+	/* After a fallback to fewer queues on runtime resume, the stack can
+	 * use more queues than the device has until igb_rtnl_resume_task()
+	 * updates it: drop those packets instead of sharing a ring between
+	 * queues, which aren't serialized with each other.
+	 */
+	if (unlikely(skb->queue_mapping >= adapter->num_tx_queues)) {
+		dev_kfree_skb_any(skb);
+		dev_core_stats_tx_dropped_inc(netdev);
+		return NETDEV_TX_OK;
+	}
+
 	return igb_xmit_frame_ring(skb, igb_tx_queue_mapping(adapter, skb));
 }
 
@@ -9639,8 +9669,11 @@ static int __igb_resume(struct device *dev, bool rpm)
 
 	if (!rpm)
 		rtnl_lock();
-	if (!err && netif_running(netdev))
-		err = __igb_open(netdev, true);
+	if (!err && netif_running(netdev)) {
+		err = __igb_open(netdev, true, !rpm);
+		if (!err && rpm)
+			schedule_work(&adapter->rtnl_resume_task);
+	}
 
 	if (!err)
 		netif_device_attach(netdev);
-- 
2.56.1

