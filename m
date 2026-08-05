Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F12BC55174
	for <intel-wired-lan@archiver.kernel.org>; Wed,  5 Aug 2026 06:52:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA13C607A8;
	Wed,  5 Aug 2026 06:52:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AjlABZmWkHWn; Wed,  5 Aug 2026 06:52:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F3D556079D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785912767;
	bh=voVYWcFM1kEMQjXsalubElGlOKY9nudK4aM5HFKA5iM=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T9+H6UuN9YXfg0aRGqxLDzAwJkhBqpD7pm2g6/wp7ARdgDnN7niGVhoVLtqIlUG8K
	 ZjSTN4ZJfz2rlnCesdxRNVZqKqX6cYfYxqACpHbTIIfaVE39TP0SW613pB2WU5M09a
	 m6YfgPZ3+5m5y/dq0N7uqUA+A6a03rs1oXPzvQMAi3SKs+6C+hF9tr5n7kHReYq21Q
	 1wviMa8kSR1ztaujQm1e4OIviJrvqibzl4veujdcuIcK98KaLKC0BxyaLyeFKPnnj3
	 yVQyCu1jKRdsdWVmpiw2EgQ+YiZWbGs1qBWph/uHvo8o5+D/qkCx/UwS8kHaNZP2uJ
	 egLAe9etUcZ0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F3D556079D;
	Wed,  5 Aug 2026 06:52:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A2A7218
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 06:52:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 10F55607A8
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 06:52:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hovyXyVj8L7u for <intel-wired-lan@lists.osuosl.org>;
 Wed,  5 Aug 2026 06:52:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.174;
 helo=out-174.mta1.migadu.com; envelope-from=xuanqiang.luo@linux.dev;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0431E6079D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0431E6079D
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com
 [95.215.58.174])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0431E6079D
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 06:52:43 +0000 (UTC)
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
Date: Wed,  5 Aug 2026 14:51:29 +0800
Message-ID: <20260805065132.148625-3-xuanqiang.luo@linux.dev>
In-Reply-To: <20260805065132.148625-1-xuanqiang.luo@linux.dev>
References: <20260805065132.148625-1-xuanqiang.luo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1785912760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=voVYWcFM1kEMQjXsalubElGlOKY9nudK4aM5HFKA5iM=;
 b=XNPZ1m9fQUrcQUiI0/BXgOQFs6omQes+iELI7Xi5v4BwgUqwtpkYqXovgRZrFP9RvLDygH
 Y4/lNqdKAdfWDnpplPYpWMuWm1n9LH8f2n5w2wtRHlShiD3NUgMpbv6GEmiixDr+CwHACk
 1s27wItEiGORl4FLgdyXnwNMF2DyL0A=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=XNPZ1m9f
Subject: [Intel-wired-lan] [PATCH iwl-net v2 2/5] i40e: serialize timestamp
 configuration with PTP teardown
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

i40e_remove() can call i40e_ptp_stop() without the networking locks held.
A concurrent hardware timestamp request can observe I40E_FLAG_PTP_ENA
before teardown clears it, then program PRTTSYN_CTL0 after teardown has
disabled the event source. This can leave time sync interrupts enabled
during device removal.

Add ptp_config_lock to serialize the enable check and register programming
in i40e_ptp_hwtstamp_set() with the PTP state transition in
i40e_ptp_stop(). Requests which observe PTP enabled finish programming
before the state transition; later requests return -EOPNOTSUPP and cannot
re-enable the interrupt.

Fixes: 1050713026a0 ("i40e: add support for PTP external synchronization clock")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/ethernet/intel/i40e/i40e.h      |  2 ++
 drivers/net/ethernet/intel/i40e/i40e_main.c |  1 +
 drivers/net/ethernet/intel/i40e/i40e_ptp.c  | 17 +++++++++++++----
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 4c8bcaa9dd192..84564d747d09a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -668,6 +668,8 @@ struct i40e_pf {
 	struct timespec64 ptp_prev_hw_time;
 	struct work_struct ptp_extts0_work;
 	ktime_t ptp_reset_start;
+	/* Serializes timestamp configuration with PTP teardown. */
+	struct mutex ptp_config_lock;
 	struct mutex tmreg_lock; /* Used to protect the SYSTIME registers. */
 	u32 ptp_adj_mult;
 	u32 tx_hwtstamp_timeouts;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 0a259351c127e..8c28788ac634f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -12819,6 +12819,7 @@ static int i40e_sw_init(struct i40e_pf *pf)
 			 "total-port-shutdown was enabled, link-down-on-close is forced on\n");
 	}
 	mutex_init(&pf->switch_mutex);
+	mutex_init(&pf->ptp_config_lock);
 	spin_lock_init(&pf->ptp_tx_lock);
 
 sw_init_done:
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 224568a3af085..f194869947124 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -1328,17 +1328,23 @@ int i40e_ptp_hwtstamp_set(struct net_device *netdev,
 	struct i40e_pf *pf = np->vsi->back;
 	int err;
 
-	if (!test_bit(I40E_FLAG_PTP_ENA, pf->flags))
-		return -EOPNOTSUPP;
+	mutex_lock(&pf->ptp_config_lock);
+
+	if (!test_bit(I40E_FLAG_PTP_ENA, pf->flags)) {
+		err = -EOPNOTSUPP;
+		goto unlock;
+	}
 
 	err = i40e_ptp_set_timestamp_mode(pf, config);
 	if (err)
-		return err;
+		goto unlock;
 
 	/* save these settings for future reference */
 	pf->tstamp_config = *config;
 
-	return 0;
+unlock:
+	mutex_unlock(&pf->ptp_config_lock);
+	return err;
 }
 
 /**
@@ -1558,6 +1564,8 @@ void i40e_ptp_stop(struct i40e_pf *pf)
 	struct sk_buff *skb;
 	u32 regval;
 
+	mutex_lock(&pf->ptp_config_lock);
+
 	spin_lock_irqsave(&pf->ptp_tx_lock, flags);
 	clear_bit(I40E_FLAG_PTP_ENA, pf->flags);
 	pf->ptp_tx = false;
@@ -1566,6 +1574,7 @@ void i40e_ptp_stop(struct i40e_pf *pf)
 	spin_unlock_irqrestore(&pf->ptp_tx_lock, flags);
 
 	pf->ptp_rx = false;
+	mutex_unlock(&pf->ptp_config_lock);
 
 	if (skb)
 		dev_kfree_skb_any(skb);
-- 
2.43.0

