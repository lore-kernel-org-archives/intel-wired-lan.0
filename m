Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A694606A880
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Nov 2026 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=j13MqkVe;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=CLOkfTMX
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A8652409EB;
	Fri, 13 Nov 2026 17:00:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LLqW_8pnOFDL; Fri, 13 Nov 2026 17:00:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 14F23409E6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794589247;
	b=byzsPwVYqrbDYxQOsqiqNMN7MAZWXLBA/S95VqwFBZXWeUGwttWJFm8/JzqP3QSgJK8P
	 prFlUsxufN1m1MD+3bbzrad9Lq8cMxINh/sEVk4KrXMfMJMtuo+QLNaYLAsya6Jtx2Xcc
	 ZnHDYm96jW+30F0l2Y6kS4JL4AMJApUeZhHjH1Al3ed8pb5lbQLsE9CiHWOTQteKVgl3c
	 vYJvUf15EJxOBS02vO4pZQ6fe1XdpusQhr35Jy5cYjuo/wlduMWPBECBupVSib+u+ZwXb
	 ESwmGK8dcwwRYoTvdScIgZ2WbhVzMImIp44dFlNa3v/HWT41WfRLui/JwRkyPfRisYg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794589247;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eABLV8g008jJr2G6ZeA0fIMhAhB4uWtAjm7pWUKqD20=;
	b=Cg+RcIaj7B6sjQU4CuacN+PfQtPfftS3hG7DJ+ewI60HGtigWGcFUoXr0w7VLbZmVN8i
	 KPemEpE6Ta32/U8Oqhu7CAHNfHd2HtbN7byx+VkLo64moJ1ZGGY5nqi6GFpCP5Rl2Ka8R
	 MwEJ/2N98hGrDWg6285ys3eHzCBME2j2VQqExNctIHJZmOHu/a6lgQRBFK4bqyK0z2RwI
	 lB/Amt4lgkJNR0r++tt8/qhYm1KglfmYzlqvauX+5TyNQ5bV8oQrWCpi1m08omuaiJX0a
	 ckC5x/byU/6xxOrtbYxczZUWcm3N0vD3yfEGtgE9SRjUmIFAcan9ZD+B65AGfmK99dg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=none header.from=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=CLOkfTMX;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794589247;
	bh=eABLV8g008jJr2G6ZeA0fIMhAhB4uWtAjm7pWUKqD20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j13MqkVe6O1WSuiqD3jzWy9NeewZTNHKVqUZ8sCySsntKbpFbXZ+qnjN3LBKXHGNq
	 ir7lLG1GWkN1JCpLigl82X6NO0xJWtb0ubATA3/3xWdRyQ0KT4DjNJb16/nX/6gH9Y
	 OrsvEp+1HcuVIPV89I3yLG1igzd+oMitvFSCuZ/WKoG5rKocvsG8C6acxhfwWTcfW0
	 A8q9YcMS7sp/3LsQHG1AkA75YdsrY8Do45X4B3RKlL31lbrieGc+LHWFukPjVL2LJ9
	 KczXE+LZUcupma/5eI/vNnJjAYXKI+WCVieh4JkSYEIpwbmrZ74lpM6RSjQca02Ub4
	 otq8KtLdqsxQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14F23409E6;
	Fri, 13 Nov 2026 17:00:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 759AF28C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 11:08:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 72F9C40D9C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 11:08:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U3UjzE6kMrn2 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Nov 2026 11:08:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 96A7640DEC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:102:465::107"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:102:465::107; helo=mout-b-107.mailbox.org;
 envelope-from=antonio@mandelbit.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mandelbit.com header.i=@mandelbit.com
 header.a=rsa-sha256 header.s=MBO0001 header.b=CLOkfTMX
Received: from mout-b-107.mailbox.org (mout-b-107.mailbox.org
 [IPv6:2001:67c:2050:102:465::107])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 96A7640DEC
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 11:08:29 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4jQvPx32Lrz3yZH;
 Fri, 13 Nov 2026 11:58:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794567525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eABLV8g008jJr2G6ZeA0fIMhAhB4uWtAjm7pWUKqD20=;
 b=CLOkfTMXA1U+ukSdTBtzQH0garR1WQlsXjPQbBIi2CIgiSpbb4M4vhZSMbXWfJY77Rx1sT
 JgpF2zn7VN6f8Q2OSQllZlBEgF4WwPQMYhO54stm8S2msxkxi1VblrtmgaalCtGxq/DRE3
 Zntmof/qXFsu/lkiBLoscIwOJ6Ks0Xen5/WDSNHO7Y//iMP8NpBKUtHQMBBIO94LYjfrGL
 Us6HuCiY22lP2j+G7dNaLwr4TdGbuymYZQa4uQojPrb1cwgu6lF+9gFmvxHWpa26TR5OF+
 89QBNUwZfb7nc64y7rgS5tGfeuR5G5svoJkq1as8wv7HSw2OZucfemburVmnjg==
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
Subject: [PATCH net 2/3] igb: link queues to NAPIs under RTNL after runtime
 resume
Date: Fri, 13 Nov 2026 11:58:32 +0100
Message-ID: <20261113105835.3821433-2-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113105835.3821433-1-antonio@mandelbit.com>
References: <20261113105835.3821433-1-antonio@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jQvPx32Lrz3yZH
X-Mailman-Approved-At: Fri, 13 Nov 2026 17:00:43 +0000
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
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

Fixes: b75a1dea500f ("igb: Link queues to NAPI instances")
Cc: stable@vger.kernel.org # 6.16+
Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
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
index bd1185d..4d97399 100644
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
@@ -4184,7 +4210,8 @@ static int __igb_open(struct net_device *netdev, bool resuming)
 	for (i = 0; i < adapter->num_q_vectors; i++) {
 		napi = &adapter->q_vector[i]->napi;
 		napi_enable(napi);
-		igb_set_queue_napi(adapter, i, napi);
+		if (!resuming)
+			igb_set_queue_napi(adapter, i, napi);
 	}
 
 	/* Clear any pending interrupts. */
@@ -9631,8 +9658,15 @@ static int __igb_resume(struct device *dev, bool rpm)
 
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

