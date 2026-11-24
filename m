Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F823606A333
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Nov 2026 23:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=pNPic1gN;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=o8lsIACM
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6300A80D02;
	Tue, 24 Nov 2026 23:57:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JDAmE0Lv1ubm; Tue, 24 Nov 2026 23:57:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 758D480D07
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795564666;
	b=c42MRVvQ7LYOuI5JYeaexJX6vP3CqIUiPDINBGD7G+hf5FNwI7cybsIOm/K0giuagpbw
	 iM9686mqf+by3pDPUJR39ybz/jWtqFvTnojGQ7DdhDbQFlvLjkRw0j1TI2zrrNBTxN54/
	 Mq8f1yx9XSg1/RyRIx+d8t9U6oT32Or+W4UioPeL8baZ83xU82ar3NACb0jPOvAOuTxSu
	 W9TnAWOfzVxgUVL4fT8SOA96z4vCxwUgEu6DdlCn3FXH25DrJogA0wll2I07pJojvWlqT
	 /zZ3xUmqYhbFSPGY5OMR4AqelTi3+gq7699DvF0OdzfxyNOFQ7lENUvXXB8dc+d/COA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795564666;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=NeH4msFzp7KNZlqjZxxwoBpRbytEX5mDF3Plc/IaGJs=;
	b=SrSxlp16T5iZbgN8K6YZ/QsD5JwKF4K1gcWm3ruMZmEQc3q+MtwVubxZt11TrqIwmci0
	 uYs1lPGkKT23+ysdtIWFMXxj0lIBtoaB2dTkIOi2w077LwmT6gIgObG1rB/5yelS1HdG6
	 ZRAg5QYEThWbp8Yx5xPuwmF6+eY0jZ1CtJmhBFR5iITCGf7Vxt4VYGEznvGitFb9eGflZ
	 reUTiR/Edxd/6XLTr7jOdEZoy60U4yb/ObE+BMBfWhfaKu29BP5IvoKDcmX02USjAGoDZ
	 nANLYBfobtMqYrEX39TG95JKUIckprUUOjmm9cPG14Oq2200rsztCBWfwvMfLeNibAQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795564666;
	bh=NeH4msFzp7KNZlqjZxxwoBpRbytEX5mDF3Plc/IaGJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pNPic1gNJnbyNJrGKXf5JM4VCWpkPl+WIZXbsq+2P2K5H3Ax8KbHj+XV76SGwlMUh
	 L8gpLuYixaNIVyvcMgqYXtEPtvqYpUXmnsLhudy8O6DQxAkJjLnxj41kM+L2Q5RHJG
	 Sq6xp08CLYcl7tvoP4LlCDXv2xDn4jXPeMS9bjFyuRKUcb/UAAqjTvWOHEDZaf1NDd
	 ghEXCIwyNUuR/ilY+ePA00Tsrn96DXwudWfwa2QywXZYkxk37RXlUiMQ7e1Lv2VdOc
	 oXD2ePsHs/c1tU8tzMwIkEEcaBF180tyOUPxCo6IkdHs8VoZfTWC0N6sAa0ZlV+QSS
	 T4ylYi1i91r1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 758D480D07;
	Tue, 24 Nov 2026 23:57:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 27C3A2F5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 23:57:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 19E9B40072
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 23:57:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a2zMr8rzIfec for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Nov 2026 23:57:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DF0F040071
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:102:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:102:465::201; helo=mout-b-201.mailbox.org;
 envelope-from=antonio@mandelbit.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mandelbit.com header.i=@mandelbit.com
 header.a=rsa-sha256 header.s=MBO0001 header.b=o8lsIACM
Received: from mout-b-201.mailbox.org (mout-b-201.mailbox.org
 [IPv6:2001:67c:2050:102:465::201])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DF0F040071
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 23:57:39 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4jZ09W6npszLmZY;
 Wed, 25 Nov 2026 00:57:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1795564656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NeH4msFzp7KNZlqjZxxwoBpRbytEX5mDF3Plc/IaGJs=;
 b=o8lsIACMTombAUPxA3EYNk+avIvK70iDEo9juR+U8nGUVhzzcRSoBFnvLL4EQWlmDgsaKU
 j0SyREf8W6EucBR98SuYpU/Lee0dq9Mo1Zp9EznP/6SJB6jHu8GPVldUlA0AC3XwRaD9D3
 y3hQ5ATjpSheYV4B6/3aedBwvrKFu+gkpKPVwRCYfC2r8WaQt4O/x+zRPuEHnLPXEjUf9z
 5zM5SpmFjSTT4IY3rE9JC3tqdtMp9OHdjDdF6Y9jWvBgsuHLM6X//GglDxtw2nY4n3kzhT
 66SmZqGxujzckuT8zJS3eOzutMjSpIMtfs/5lioUNxeZ+ms9B8UmyepdXxAMIw==
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
 Kurt Kanzenbach <kurt@linutronix.de>, Joe Damato <joe@dama.to>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH net v5 4/6] igb: link queues to NAPIs under RTNL after runtime
 resume
Date: Wed, 25 Nov 2026 00:57:19 +0100
Message-ID: <20261124235723.1135808-5-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124235723.1135808-1-antonio@mandelbit.com>
References: <20261124235723.1135808-1-antonio@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jZ09W6npszLmZY
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

Link them in __igb_open() only when RTNL is held, and from the work
item that sets the real queue counts on runtime resume. The links can't
be kept across a suspend, because __igb_shutdown() frees the q_vectors.
A suspend now cancels the work item before freeing them, so it only runs
after the resume that scheduled it allocated them, and it checks
__IGB_DOWN under RTNL for a close in the meantime.

Tested with the 82576 emulated by QEMU.

Fixes: b75a1dea500f ("igb: Link queues to NAPI instances")
Cc: stable@vger.kernel.org # 6.16+
Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
v5: cancel the work item before a suspend (Sashiko)
v4: no changes
v3: link the NAPIs from the work item added by the previous patch, and
in __igb_open() whenever RTNL is held (also on system sleep resume);
dropped Joe's Reviewed-by, as the patch changed
v2: no code changes; mention the tested hardware

Note: igc has the same issue: __igc_open() also links queues to NAPIs
(igc_set_queue_napi()) on the RTNL-less runtime resume path. A fix will
follow separately once it has been tested on igc hardware.

 drivers/net/ethernet/intel/igb/igb_main.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 6961646..acd9a33 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4146,8 +4146,19 @@ static int igb_set_real_num_queues(struct igb_adapter *adapter)
 	return netif_set_real_num_queues(netdev, adapter->num_tx_queues, rxq);
 }
 
+static void igb_link_queue_napis(struct igb_adapter *adapter)
+{
+	int i;
+
+	for (i = 0; i < adapter->num_q_vectors; i++)
+		igb_set_queue_napi(adapter, i, &adapter->q_vector[i]->napi);
+}
+
 /* Some settings need RTNL, which isn't held when resuming from runtime
- * suspend: apply them from here instead, if the device is still up.
+ * suspend: apply them from here instead, if the device is still up. A
+ * suspend cancels this work before freeing the q_vectors, so it only runs
+ * after the resume that scheduled it allocated them; checking __IGB_DOWN
+ * under RTNL covers a close in the meantime.
  */
 static void igb_rtnl_resume_task(struct work_struct *work)
 {
@@ -4160,6 +4171,7 @@ static void igb_rtnl_resume_task(struct work_struct *work)
 		if (igb_set_real_num_queues(adapter))
 			netdev_err(adapter->netdev,
 				   "error setting real queue count\n");
+		igb_link_queue_napis(adapter);
 	}
 	rtnl_unlock();
 }
@@ -4237,7 +4249,8 @@ static int __igb_open(struct net_device *netdev, bool resuming,
 	for (i = 0; i < adapter->num_q_vectors; i++) {
 		napi = &adapter->q_vector[i]->napi;
 		napi_enable(napi);
-		igb_set_queue_napi(adapter, i, napi);
+		if (rtnl_held)
+			igb_set_queue_napi(adapter, i, napi);
 	}
 
 	/* Clear any pending interrupts. */
@@ -9548,6 +9561,11 @@ static int __igb_shutdown(struct pci_dev *pdev, bool *enable_wake,
 	u32 wufc = runtime ? E1000_WUFC_LNKC : adapter->wol;
 	bool wake;
 
+	/* Don't let a work item queued by an earlier resume run once the
+	 * q_vectors are freed or reallocated
+	 */
+	cancel_work_sync(&adapter->rtnl_resume_task);
+
 	rtnl_lock();
 	netif_device_detach(netdev);
 
-- 
2.56.1

