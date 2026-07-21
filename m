Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B832FC4451C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 21 Jul 2026 09:25:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73AAB4087B;
	Tue, 21 Jul 2026 09:25:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zJzdfhvOkYmq; Tue, 21 Jul 2026 09:25:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 28C4D40840
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784625900;
	bh=2FQXDCxrT8tPYV+NgHQ01O/7Lq/+d5KF/3y46YmuZSI=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Q7/8uf2mIWFewA1oN39HXy3QMcqM79IiyWahC+e4II/+ZtlXBYUlQ73Nd3FX4ooBq
	 rlxUrHwXwXd/UIXEeyJkOueyXOYDcOcKB1Re4ITyg8edFIYWMyZPSCmIUb80h7VCxI
	 JX1xdZuzzDRx0CPqSZE6XHy21PSmmkOH2zdeLS3W8VAknFHTBJ+wAbmrV+5D2Xf4a4
	 RSO0t2jFJ5nMB8kn/yr8vMKibhRTxnP5Pl+JnO124vuc1wAOHnfBoobx1A5X5sFCum
	 aDBQImVxBr6WDncJjPaNFfUiZTezCGy8upH5QqKeMrmMgQWPcWW+hIgRCSpzdp2vy+
	 v5vtQhIHU7fUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 28C4D40840;
	Tue, 21 Jul 2026 09:25:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 74110224
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jul 2026 09:24:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6992340840
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jul 2026 09:24:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1rqaRaRHHZc9 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 21 Jul 2026 09:24:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:41d0:1004:224b::b3; helo=out-179.mta0.migadu.com;
 envelope-from=xuanqiang.luo@linux.dev; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 64F9E407D1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 64F9E407D1
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 64F9E407D1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jul 2026 09:24:57 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: xuanqiang.luo@linux.dev
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, roel.kluin@gmail.com, tactii@gmail.com,
 netdev@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
 stable@vger.kernel.org
Date: Tue, 21 Jul 2026 17:23:23 +0800
Message-ID: <20260721092323.39372-1-xuanqiang.luo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1784625893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2FQXDCxrT8tPYV+NgHQ01O/7Lq/+d5KF/3y46YmuZSI=;
 b=AWYax0qiizAfZB7H7rUqAhJ/kXN26xzpuRUQmNnSQorVoaI5kU8WaPXQKBsEfNC9NMd2xF
 BXYL+4sdJ2tVjWOZLoF8WCWgow1A4bbA0uss3W8LqVUqG3JJklidcNWwkxO0N+bjll+xz8
 7zLjyWoNcryk5UdJ2ttVIJ5+RiWFvjU=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=AWYax0qi
Subject: [Intel-wired-lan] [PATCH iwl-net v1] igbvf: fix DMA mapping leak on
 Tx error
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

When mapping a fragmented skb fails, count already matches the number of
successful mappings that must be undone. Decrementing it before the cleanup
loop leaves one mapping active. Reusing the descriptor then overwrites its
DMA address and loses the mapping.

Remove the extra decrement so the error path unmaps every successful
mapping.

Fixes: c1fa347f20f1 ("e1000/e1000e/igb/igbvf/ixgb/ixgbe: Fix tests of unsigned in *_tx_map()")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/ethernet/intel/igbvf/netdev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index c5ae15fcdca75..3d2aba5c3f126 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -2190,8 +2190,6 @@ static inline int igbvf_tx_map_adv(struct igbvf_adapter *adapter,
 	buffer_info->time_stamp = 0;
 	buffer_info->length = 0;
 	buffer_info->mapped_as_page = false;
-	if (count)
-		count--;
 
 	/* clear timestamp and dma mappings for remaining portion of packet */
 	while (count--) {
-- 
2.43.0

