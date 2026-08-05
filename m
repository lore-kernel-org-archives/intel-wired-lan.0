Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F29C55174
	for <intel-wired-lan@archiver.kernel.org>; Wed,  5 Aug 2026 06:58:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C2504072B;
	Wed,  5 Aug 2026 06:58:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PzlYPmguQ7nR; Wed,  5 Aug 2026 06:58:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 38A4B4067C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785913130;
	bh=pJB8I4mT/6RVCSNdvG8ug/nQxSFqGts4V2K/DAvG5QY=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HFyX1MryQ/RWJo6/QolQobxNX7kLQ8ivOYimi1rY5YOV2Gei+Eo82Hf7wYzxoz7OA
	 NdKqDpHAiQv5zQgPl9kMEAD8k9qtK/ZZayXlsvg/wdlkMCK7S0fbvtPxjWmk02xJeS
	 s1rIaXRZz7Qy3ua6M/UjmIloSQUx2UjyfU/Sg52B1oQ7pSxSzhEWSKhqCvN/C+yLCM
	 gmHdG6tCQc2o1DHPxrWyHMuSd57fgV55UBpwWcDDmQsbvZn0A3xDQtn/GamolmOco7
	 ohM3X4NdkKvd52KP4Ot3UfQ6WQGosbZR+bt0BMJDhqX8uUB3ry9yRwC8BIQy20VxT+
	 xfJOFaR9mSYgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38A4B4067C;
	Wed,  5 Aug 2026 06:58:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E72EB218
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 06:58:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D91B560718
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 06:58:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id La2GB-j3n420 for <intel-wired-lan@lists.osuosl.org>;
 Wed,  5 Aug 2026 06:58:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.174;
 helo=out-174.mta1.migadu.com; envelope-from=xuanqiang.luo@linux.dev;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 31ED3605FC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 31ED3605FC
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com
 [95.215.58.174])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 31ED3605FC
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 06:58:48 +0000 (UTC)
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
Date: Wed,  5 Aug 2026 14:51:31 +0800
Message-ID: <20260805065132.148625-5-xuanqiang.luo@linux.dev>
In-Reply-To: <20260805065132.148625-1-xuanqiang.luo@linux.dev>
References: <20260805065132.148625-1-xuanqiang.luo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1785912774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pJB8I4mT/6RVCSNdvG8ug/nQxSFqGts4V2K/DAvG5QY=;
 b=bsWU14PjrosZV0DY758SKnNeZWdkobizWYH5amkVz63OaOxRAQgxT+26C/ONSxFsLhiyEv
 WCjFcr/kFQMqjuLopex3jYaUc16FBm6Yshn3cp9Kj5WZRK1CxQw2R1VEKAqXLrCIDLC/F0
 YBsGUFRULn/AGMF9fycdUIHJw8gTHOg=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=bsWU14Pj
Subject: [Intel-wired-lan] [PATCH iwl-net v2 4/5] i40e: replace reset
 polling with wait-bit synchronization
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

i40e_remove() polls on RESET_RECOVERY_PENDING with a fixed sleep while
waiting for an existing reset owner. This adds teardown latency and does
not provide a wait queue for the reset owner to wake.

Use wait_on_bit_lock() so removal sleeps until the reset owner releases the
bit and then atomically claims it. Pair the reset release paths with
clear_and_wake_up_bit() to provide the required release and wakeup
semantics.

Fixes: 5b6d4a7f20b0 ("i40e: Fix crash during removing i40e driver")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 5922f83f324ae..c19d4c81d6532 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7,6 +7,7 @@
 #include <linux/if_bridge.h>
 #include <linux/if_macvlan.h>
 #include <linux/module.h>
+#include <linux/wait_bit.h>
 #include <net/pkt_cls.h>
 #include <net/xdp_sock_drv.h>
 
@@ -10822,7 +10823,8 @@ static int i40e_reset(struct i40e_pf *pf)
 	if (ret) {
 		dev_info(&pf->pdev->dev, "PF reset failed, %d\n", ret);
 		set_bit(__I40E_RESET_FAILED, pf->state);
-		clear_bit(__I40E_RESET_RECOVERY_PENDING, pf->state);
+		clear_and_wake_up_bit(__I40E_RESET_RECOVERY_PENDING,
+				      pf->state);
 	} else {
 		pf->pfr_count++;
 	}
@@ -11115,7 +11117,7 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 end_core_reset:
 	clear_bit(__I40E_RESET_FAILED, pf->state);
 clear_recovery:
-	clear_bit(__I40E_RESET_RECOVERY_PENDING, pf->state);
+	clear_and_wake_up_bit(__I40E_RESET_RECOVERY_PENDING, pf->state);
 	clear_bit(__I40E_TIMEOUT_RECOVERY_PENDING, pf->state);
 }
 
@@ -16169,8 +16171,8 @@ static void i40e_remove(struct pci_dev *pdev)
 		disable_work_sync(&pf->service_task);
 
 	/* Wait for any reset owner before tearing down device resources. */
-	while (test_and_set_bit(__I40E_RESET_RECOVERY_PENDING, pf->state))
-		usleep_range(1000, 2000);
+	wait_on_bit_lock(pf->state, __I40E_RESET_RECOVERY_PENDING,
+			 TASK_UNINTERRUPTIBLE);
 	set_bit(__I40E_IN_REMOVE, pf->state);
 
 	i40e_dbg_pf_exit(pf);
-- 
2.43.0

