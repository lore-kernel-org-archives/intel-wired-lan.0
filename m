Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EACDC982D6
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Sep 2026 15:03:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A820860613;
	Thu, 17 Sep 2026 15:03:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 40MM1JIb6Rsu; Thu, 17 Sep 2026 15:03:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 275DE6064D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789657388;
	b=d8q70XXJanlVQs0bZ5j4qOX62uRZr7IMdlJiCELgSYqk/+qnDDJrDYKzYKxueDhdvsJ3
	 SbvDARxh7ESiX9IU/DPAhF7ubSiO9EWwtHIHUNyaC/4LE0jJjLUblyz5/Yc7TMfK3JyX8
	 QTVxOfmbar68u/mxifY9a/x0wh0OZYZBry8R5M+UOCEuekv4tClWa3qgFiGm9RU7u/79I
	 /PIW9qUcj9Fwh5WdinrMiZ43e4cNHNeXvFrVvrOXzMy26cBhIjwn+TJGVyasdA9yw+bSL
	 mIitcoNRMQ/VU45XqGgVFRQmQaS+DrC5jFOl+hBOM7fJcJ2XC+boJSiTFLuKXwe/VOw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789657388;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CVA/CWhw4JetoLTPs+u2MtnfUXnMQ1sROVyIw6FlqyI=;
	b=gzf45eoMgxUFXMqdLxRFDBX7MmamWVLHmtDySZ0cGs53wn4BUWa1qoJRmhOCzq+Bq0l5
	 6UH53vd89K02B7yE0lcwD9wXNNf1xc7j0wVrAmKD7Mig/4ulmlzDwhjFQxUA8Q+Y0dKfM
	 psiQdvJg9nCRTSaT4RVPJ98tQLujYwEUOdsj5E37OSQuEZprI0JuHMmTXQFBYZK1xPWEC
	 kG+JXKaua5CSSfA/zteD7rurJ1aD1NmHh31eWvzR8zfZBuE8fi3Up507eKYZbLnvP2mwl
	 iOJt1F6EcvSu9ZihWdbGSIOzXbf7NFgxjvGUQBP1u74RPLJ11KeHlW8PPVNDti04aFg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789657388;
	bh=CVA/CWhw4JetoLTPs+u2MtnfUXnMQ1sROVyIw6FlqyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=2+ak9+3guMlxLxSKf6IhqCkLl0ialYw8w+0v37Dqni85MXaCvn6Ybl4/CPqdS2iwy
	 DKZRT+CGq7ZGeY96t7UvQle2GqoiHu21p3jdeIO1LSabuAasNjoIARjlunsOCvotDS
	 xZiCa4gVDUsaTOcZIlCwahENiBOpK3kSsWKl+/eVa6Ps1KlqHtiIbfZaCw7vo7oR/H
	 eYzq7KDj7tds/lRotO9HA7tzY73HB6IAyfcqMeDuQ+BYPAMtfAzTtGrvVU3NUOXjlu
	 xJCcWxd70iQtUZOJy2p6jPTqDm+nIlo8JEHUqfu5gCW1H/lxMJ2cIcaS5VjMRipoI5
	 c081JJo+zFYug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 275DE6064D;
	Thu, 17 Sep 2026 15:03:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2998337A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 15:03:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0FB894036E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 15:03:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mYee26ZtUiPD for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Sep 2026 15:03:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 30B484007D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789657385;
 b=JtQ9pr1ew3anxDMWcdQ0ay+1PqzpN6wKIP775tjlvh5teSj0hyGv5Nr9IkyvqZ6PUjuE
 /xp+b7RAKDKv6GF7fKVbZBgH74SHgF/Ofa16xE81IPu//1tSV2c8uvbfioBvb9C5Nj+H2
 oYitU8U3XGbefdd9e1nDYeEWDo05oum8REl3Wpj94aWqyjIOsGkKTJAKxSmYyRo9bpzrY
 S7kMu6INMcLAoORasEJZWBUtauwnr1GIqRSLW7NoqNEaio2soYvzJJZqI3BKbXjEE5HFm
 cKIxfSaC3KD/ulLy7+wp4oIoC162L4EVTiTRQgolrPvYeMcID+QVjJvO8/K6hZJE2ig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789657385;
 h=Received-SPF:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
 bh=CVA/CWhw4JetoLTPs+u2MtnfUXnMQ1sROVyIw6FlqyI=;
 b=YnMKusq9iMd4ZojJtX9uvmnY/TciYJ/9vPyqWYpujbsgLYWGKIy9oD9yX5kMMIpeIOgX
 j01+ZE204IZiJt3Si46SrbdWm2LOxuPxnZRMTFz2FgM1CMjM+guD+k9GbH3deZXVjS/1S
 gr3zDyRHWa2K2uT1TyHV5P0R7rROpDDdHi/HMXquWHFIINtWk8UEGuE4Tre0GHQoMFrPh
 VdpSpHOC49miF4799kUjXm+aS8TJFl1VvgpwutAVXaoBi2NAkFNeS51iWVaViaJ90WqJx
 I511SS7o0h2JjPPSu4oe4dk9hZ6XDBzsJVXLQsaWU9eLY5egD4KqHdFReiWFX9r/DGw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=seu.edu.cn; 
 dkim=pass header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256
 header.s=default header.b=XzhyC205; 
 arc=none smtp.remote-ip=101.71.155.101
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=101.71.155.101;
 helo=mail-m155101.qiye.163.com; envelope-from=runyu.xiao@seu.edu.cn;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256
 header.s=default header.b=XzhyC205
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com
 [101.71.155.101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 30B484007D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 15:03:02 +0000 (UTC)
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4e2966651;
 Thu, 17 Sep 2026 23:02:56 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: anthony.l.nguyen@intel.com
Cc: alessio.bogani@elettra.eu, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 horms@kernel.org, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 runyu.xiao@seu.edu.cn, jianhao.xu@seu.edu.cn
Subject: [PATCH net v2] igb: initialize PTP state before registering PHC
Date: Thu, 17 Sep 2026 23:02:47 +0800
Message-Id: <20260917150247.2562991-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cd12af33-ed01-4eca-88e3-703b59c05453@intel.com>
References: <cd12af33-ed01-4eca-88e3-703b59c05453@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0afe464bc03a1kunmedc4fb9b36b0e0
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSh9DVhpDSB8YGB4YSB8YTFYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUJCSU
 5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
 b=XzhyC205B32Mf5pmI+JBcc79zrNKxHnWA4LYoiFwnF/aeRxZa8X/houtANseOcnJRLeobbzXLSdIv6cw6dfTyruIm1O542KeZIvzaykMYQVxbVuCY8CSZs6Ie3fG2sisR7QklGdmDbm7DVZ9fU7btJpwAmvUdql4uUJuae7Kl0w=;
 c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1; 
 bh=CVA/CWhw4JetoLTPs+u2MtnfUXnMQ1sROVyIw6FlqyI=;
 h=date:mime-version:subject:message-id:from;
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

igb_ptp_init() currently initializes the PTP lock, work items,
timestamp configuration, and timecounter after ptp_clock_register().
The PHC is published by that call, so PTP callbacks and timestamp
interrupts can run before those objects are ready.

Initialize the complete PTP state before registering the PHC. Skip the
setup when CONFIG_PTP_1588_CLOCK is disabled, since the PTP registration
helper is then a no-op. If PHC registration fails, cancel the work items
queued by igb_ptp_reset() or a timestamp interrupt before returning.

Fixes: b888c510f7b3 ("igb: Avoid starting unnecessary workqueues")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/netdev/20260830154912.2712900-1-runyu.xiao@seu.edu.cn/
Assisted-by: LLM
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

---
v2:
- Restore all PTP state initialization before PHC registration.
- Skip PTP setup when CONFIG_PTP_1588_CLOCK is disabled.
- Cancel both PTP work items when PHC registration fails.
---
 drivers/net/ethernet/intel/igb/igb_ptp.c | 31 +++++++++++++++---------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 638d8242b..1c5581451 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -1307,6 +1307,9 @@ void igb_ptp_init(struct igb_adapter *adapter)
 	struct e1000_hw *hw = &adapter->hw;
 	struct net_device *netdev = adapter->netdev;
 
+	if (!IS_ENABLED(CONFIG_PTP_1588_CLOCK))
+		return;
+
 	switch (hw->mac.type) {
 	case e1000_82576:
 		snprintf(adapter->ptp_caps.name, 16, "%pm", netdev->dev_addr);
@@ -1378,27 +1381,31 @@ void igb_ptp_init(struct igb_adapter *adapter)
 		return;
 	}
 
+	spin_lock_init(&adapter->tmreg_lock);
+	INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
+
+	if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
+		INIT_DELAYED_WORK(&adapter->ptp_overflow_work,
+				  igb_ptp_overflow_check);
+
+	adapter->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
+	adapter->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
+
+	igb_ptp_reset(adapter);
+
 	adapter->ptp_clock = ptp_clock_register(&adapter->ptp_caps,
 						&adapter->pdev->dev);
 	if (IS_ERR(adapter->ptp_clock)) {
+		if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
+			cancel_delayed_work_sync(&adapter->ptp_overflow_work);
+		cancel_work_sync(&adapter->ptp_tx_work);
+
 		adapter->ptp_clock = NULL;
 		dev_err(&adapter->pdev->dev, "ptp_clock_register failed\n");
 	} else if (adapter->ptp_clock) {
 		dev_info(&adapter->pdev->dev, "added PHC on %s\n",
 			 adapter->netdev->name);
 		adapter->ptp_flags |= IGB_PTP_ENABLED;
-
-		spin_lock_init(&adapter->tmreg_lock);
-		INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
-
-		if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
-			INIT_DELAYED_WORK(&adapter->ptp_overflow_work,
-					  igb_ptp_overflow_check);
-
-		adapter->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
-		adapter->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
-
-		igb_ptp_reset(adapter);
 	}
 }
 
-- 
2.34.1
