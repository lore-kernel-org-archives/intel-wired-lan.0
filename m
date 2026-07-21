Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E11C4451C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 21 Jul 2026 10:36:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72CB66076D;
	Tue, 21 Jul 2026 10:36:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SSCJNqCWjq18; Tue, 21 Jul 2026 10:36:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1AEC9607DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784630211;
	bh=2zzTDGQly5AVxe/+9Ui/CdewjiD+JPqlP23irktRQUk=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=i//+EAcMMCr/8pF25GGLXRraB/bcGkrdmMO2jSncBLHVF2wUaD17+nbE4g3RtKOxf
	 i9+J+6HgKTCaPBM7EwsrSaJjFeDIoxFx1fBomrsMlXfwjIegrjyCiXJ3VjxiO4FLIY
	 FbaBudPSn3dnGw6M0d1dg7t65dVMigrcnfmJJbRxStnqAe7rRFrCtMPGuDr+tSZdS9
	 ZhJ6F/9Cj9ZLZMAGQBFgo2CTpYxa1gnTrNuimP21+j+P0ED9g9lDJwhEjdudi+dn59
	 5MTpDcW5lgI86urUH/i1dFhzBbh/8gfC5Mi7e2VHgOguxqPOISLbGzX7qlO+5MwFhM
	 1bPI3jvJTOxVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1AEC9607DE;
	Tue, 21 Jul 2026 10:36:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7CA0396C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jul 2026 10:36:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1649E400B1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jul 2026 10:36:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LTlsUgXu5Dpa for <intel-wired-lan@lists.osuosl.org>;
 Tue, 21 Jul 2026 10:36:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.180;
 helo=out-180.mta1.migadu.com; envelope-from=xuanqiang.luo@linux.dev;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8EC34400AD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8EC34400AD
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com
 [95.215.58.180])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8EC34400AD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jul 2026 10:36:46 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: xuanqiang.luo@linux.dev
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, tj@kernel.org, netdev@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>, stable@vger.kernel.org
Date: Tue, 21 Jul 2026 18:35:39 +0800
Message-ID: <20260721103539.57990-1-xuanqiang.luo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1784630204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2zzTDGQly5AVxe/+9Ui/CdewjiD+JPqlP23irktRQUk=;
 b=mDO9LErlNCxVEWXtC6Il3c80LAKdHR3u+x2Qpwq/fp6/IQRcOAwqLPd+50t7sS4GaVxGZy
 zZ2dy1OxoDrzjbksQnnOz2qJ39F1xbbgmVcMrSkEmAg0yI2mvBzDz8qfqQO/BEqypTOge9
 BvcjPay13/VHzZf2SE6FoNxeB/Kpcm8=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=mDO9LErl
Subject: [Intel-wired-lan] [PATCH iwl-net v1] igb/igbvf: disable work items
 before device removal
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

A watchdog work item that is already running can queue the reset work after
the remove path has canceled it. The netdev Tx timeout handler can also
queue the reset work until unregister_netdev() shuts the interface down.
In igb, device reset interrupts provide another enqueue path. The reset
work may then run after free_netdev(), resulting in access to the freed
adapter memory.

Although igb_reset_task() checks __IGB_DOWN, checking the bit already
dereferences the adapter and therefore cannot protect its lifetime.

Disable the watchdog work first and the reset work second in both drivers.
Disabling the work items also prevents racing attempts to queue them during
device removal.

Fixes: 760141a53e5d ("igb[v],ixgbe: don't use flush_scheduled_work()")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 4 ++--
 drivers/net/ethernet/intel/igbvf/netdev.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index a1e89a375744c..5ffc0ad318914 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3887,8 +3887,8 @@ static void igb_remove(struct pci_dev *pdev)
 	timer_delete_sync(&adapter->watchdog_timer);
 	timer_delete_sync(&adapter->phy_info_timer);
 
-	cancel_work_sync(&adapter->reset_task);
-	cancel_work_sync(&adapter->watchdog_task);
+	disable_work_sync(&adapter->watchdog_task);
+	disable_work_sync(&adapter->reset_task);
 
 #ifdef CONFIG_IGB_DCA
 	if (adapter->flags & IGB_FLAG_DCA_ENABLED) {
diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index ec308a5f5302a..c5ae15fcdca75 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -2906,8 +2906,8 @@ static void igbvf_remove(struct pci_dev *pdev)
 	set_bit(__IGBVF_DOWN, &adapter->state);
 	timer_delete_sync(&adapter->watchdog_timer);
 
-	cancel_work_sync(&adapter->reset_task);
-	cancel_work_sync(&adapter->watchdog_task);
+	disable_work_sync(&adapter->watchdog_task);
+	disable_work_sync(&adapter->reset_task);
 
 	unregister_netdev(netdev);
 
-- 
2.43.0

