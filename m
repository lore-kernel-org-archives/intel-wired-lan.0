Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C98B606A88B
	for <intel-wired-lan@archiver.kernel.org>; Mon, 16 Nov 2026 15:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=niDcLVxW;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=yvBI2C02
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F37EC80F27;
	Mon, 16 Nov 2026 15:31:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FPdzaAuT4LKe; Mon, 16 Nov 2026 15:31:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2B47480EE0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794843060;
	b=NcIkaeHmb3A48JFfBPiR640CJsuwK0zX+zs1ew2JGi5WBjtrmXZBCklrj1ACi9+yORXf
	 HQ3QhFSh3wz/0oM2ovWZTZGSlJJgA33JtIJutrJCQAQymg3rcbX6RxbZ5AYlkKkn84oEL
	 tgMjyiJ3maDDLxtfNPONpYwAxuSpK4apQkZpcRfM5eawGVngbIsd28dr2AiHHjBS63v97
	 fDag8V/1CuuQhB7mwa7Y7yWL9Ol4y6ebGGrre155rU0hfiQXzuXoVWrLQk8NXDR0XkHdm
	 sy/dnYAIDa8zzVfrxeZ/Q6y1u3+F/bLKfDm/UQjflCYvPrdU6zwImhm5kZqmbWOi35A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794843060;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=izMnGSi5/C4Zjs+ze3xoS9LB92c3fP1+bt3Aegm0+Zk=;
	b=XiBkP+dSGuzp5mhdONdjjBKfi/ZbZQX5r/m7Unx3L/mhNR+7RJO97ccjF/NBEZTiEljU
	 UMen/GRc4IqL22nU44VaQpA1oKxAsHcT5P+n3xEG1KhEx0gxdj/sjYEtC6FBtyLwVb2iJ
	 Vr+06UmmK4zTm/oD2Ah5KJNmfQ646RQ0wQZulVfi2J8Kp8pO/J6ts1nBZsAtFlue6mka2
	 s7dOgFVfwgFTvkBJdmh8vhqB8Iy+HRhm6ag7CchDbxoXhKJpe1iC+09WMxmlU9x+4Qeuj
	 D95NlAUbWcP8J8/AHiE0a7ScxUUSMTs+Y/FDaL5OOuRu7XEmL6z823PSimOXePm4meA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794843060;
	bh=izMnGSi5/C4Zjs+ze3xoS9LB92c3fP1+bt3Aegm0+Zk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=niDcLVxWz7wgU/k5KXlUcQaqpBL9r6SMuDDFR+Oo1ugPScR8TKJVoRHX1D/Pr2YpO
	 w7rSVIzlWBHPamLAobVOCt+yGuSq/0lvUNhtXH+fddmgVyDItRCa1o+5lGyerIwobv
	 qwXj84QSOaUYDGgt+dF5CDh1dyTnwLgmxvqpON6LWoxzK3PkVVVa6jocoEEldqmwQa
	 YdPuvxSN1F+R8AtTxli6UNMEtyPAc+DG8tFVNXz3YqRJvQHABDgdXXXpN9pKPiY227
	 /rZzdyHapWgQ2+GIMBmfiajmTSA+bvYwomwqdTk5DzM2G2roCOyCmXNdvwmBGd92BM
	 6SvLJrYi2/EkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B47480EE0;
	Mon, 16 Nov 2026 15:31:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FA852FE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 15:30:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4224B6069A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 15:30:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1he-fkRF1Tw2 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 16 Nov 2026 15:30:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3081B607CE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=195.10.208.62
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.10.208.62;
 helo=mout-b-202.mailbox.org; envelope-from=antonio@mandelbit.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mandelbit.com header.i=@mandelbit.com
 header.a=rsa-sha256 header.s=MBO0001 header.b=yvBI2C02
Received: from mout-b-202.mailbox.org (mout-b-202.mailbox.org [195.10.208.62])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3081B607CE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 15:30:54 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4jSsJV67ntzKm6H;
 Mon, 16 Nov 2026 16:30:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794843050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=izMnGSi5/C4Zjs+ze3xoS9LB92c3fP1+bt3Aegm0+Zk=;
 b=yvBI2C02ZwFRuUGrao6VTZ+vHHaEgoU0fkE9KwDDWhJWCR3EEv2bTrmUCsBU+P2yLkVrv4
 XEJo7hEuXHrl1uY98K31N0VINK6Evzn8dHmts1HGIEHUukiIUXIDe0kThTN+QcKQ3SD977
 J+X0EIBZJ6vyjk0I9kcQ6flZRkD+3MmP1TzApAPuILY8MkOrdGeiluHAZoBcDnEMqVlIU6
 hoRe7HYaI5T23ITn8r1c14614oWwXAXMRytC8lAVSf2inl1ImkGdq0/Tu2dLLqECAZ7wLH
 /R5bmYU3Go8kCKkUfaW87aVTt0+l3pqFoPr9KHZBZm+9fWfTsGYZWsFA5MiGZg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=antonio@mandelbit.com
From: Antonio Quartulli <antonio@mandelbit.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Antonio Quartulli <antonio@mandelbit.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Kurt Kanzenbach <kurt@linutronix.de>,
 Joe Damato <joe@dama.to>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH net v2 2/3] igb: link queues to NAPIs under RTNL after runtime
 resume
Date: Mon, 16 Nov 2026 16:30:38 +0100
Message-ID: <20261116153041.3002666-3-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116153041.3002666-1-antonio@mandelbit.com>
References: <20261116153041.3002666-1-antonio@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jSsJV67ntzKm6H
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

__igb_open() links queues to NAPIs with netif_queue_set_napi(), which
requires RTNL, but RTNL isn't held when resuming from runtime suspend:
this triggers "RTNL: assertion failed".

Don't link them in __igb_open() when resuming: do it right away on
system resume (RTNL held) and from a work item taking RTNL on runtime
resume. The links can't be kept across a suspend, because
__igb_shutdown() frees the q_vectors. These are only freed under RTNL
with __IGB_DOWN set, so the work item checks __IGB_DOWN under RTNL.

Tested with the 82576 emulated by QEMU.

Fixes: b75a1dea500f ("igb: Link queues to NAPI instances")
Cc: stable@vger.kernel.org # 6.16+
Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
v2: no code changes; mention the tested hardware.

Note: igc may have the same issue: __igc_open() also links queues to NAPIs
(igc_set_queue_napi()) on the RTNL-less runtime resume path. We didn't
have igc hardware to test a fix with, so no igc patch is sent for now.

 drivers/net/ethernet/intel/igb/igb.h      |  1 +
 drivers/net/ethernet/intel/igb/igb_main.c | 38 +++++++++++++++++++++--
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 0fff1df..ea2d739 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -585,6 +585,7 @@ struct igb_adapter {
 
 	struct work_struct reset_task;
 	struct work_struct watchdog_task;
+	struct work_struct queue_napi_task;
 	bool fc_autoneg;
 	u8  tx_timeout_factor;
 	struct timer_list blink_timer;
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 4447546..894eedb 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2115,6 +2115,30 @@ void igb_set_queue_napi(struct igb_adapter *adapter, int vector,
 				     NETDEV_QUEUE_TYPE_TX, napi);
 }
 
+static void igb_link_queue_napis(struct igb_adapter *adapter)
+{
+	int i;
+
+	for (i = 0; i < adapter->num_q_vectors; i++)
+		igb_set_queue_napi(adapter, i, &adapter->q_vector[i]->napi);
+}
+
+/* Linking queues to NAPIs requires RTNL, which isn't held when resuming
+ * from runtime suspend: do it from here instead. The q_vectors are only
+ * freed under RTNL with __IGB_DOWN set, so checking it under RTNL is safe.
+ */
+static void igb_queue_napi_task(struct work_struct *work)
+{
+	struct igb_adapter *adapter = container_of(work, struct igb_adapter,
+						   queue_napi_task);
+
+	rtnl_lock();
+	if (!test_bit(__IGB_DOWN, &adapter->state) &&
+	    netif_running(adapter->netdev))
+		igb_link_queue_napis(adapter);
+	rtnl_unlock();
+}
+
 /**
  *  igb_up - Open the interface and prepare it to handle traffic
  *  @adapter: board private structure
@@ -3426,6 +3450,7 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	INIT_WORK(&adapter->reset_task, igb_reset_task);
 	INIT_WORK(&adapter->watchdog_task, igb_watchdog_task);
+	INIT_WORK(&adapter->queue_napi_task, igb_queue_napi_task);
 
 	/* Initialize link properties that are user-changeable */
 	adapter->fc_autoneg = true;
@@ -3890,6 +3915,7 @@ static void igb_remove(struct pci_dev *pdev)
 
 	cancel_work_sync(&adapter->reset_task);
 	cancel_work_sync(&adapter->watchdog_task);
+	cancel_work_sync(&adapter->queue_napi_task);
 
 #ifdef CONFIG_IGB_DCA
 	if (adapter->flags & IGB_FLAG_DCA_ENABLED) {
@@ -4199,7 +4225,8 @@ static int __igb_open(struct net_device *netdev, bool resuming)
 	for (i = 0; i < adapter->num_q_vectors; i++) {
 		napi = &adapter->q_vector[i]->napi;
 		napi_enable(napi);
-		igb_set_queue_napi(adapter, i, napi);
+		if (!resuming)
+			igb_set_queue_napi(adapter, i, napi);
 	}
 
 	/* Clear any pending interrupts. */
@@ -9637,8 +9664,15 @@ static int __igb_resume(struct device *dev, bool rpm)
 
 	if (!rpm)
 		rtnl_lock();
-	if (!err && netif_running(netdev))
+	if (!err && netif_running(netdev)) {
 		err = __igb_open(netdev, true);
+		if (!err) {
+			if (rpm)
+				schedule_work(&adapter->queue_napi_task);
+			else
+				igb_link_queue_napis(adapter);
+		}
+	}
 
 	if (!err)
 		netif_device_attach(netdev);
-- 
2.56.0

