Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C901C624A5
	for <intel-wired-lan@archiver.kernel.org>; Mon, 31 Aug 2026 15:19:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C4C080B6B;
	Mon, 31 Aug 2026 15:19:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BB9uhfeCYVfB; Mon, 31 Aug 2026 15:18:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788189538;
	bh=f1gzZMaQn/1LyNKQ9BDeU2sp9XpnY13ijo2O/3Sv6sg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=q6EMD7kL06ttrQe2tsPobaf3gQPzvI8WFwDFuMfthOUETMEfdKTuKiMRv51lLY6Wo
	 FU/kZ9EZQi1OrvYAS8mUwZ7beAK9qdqvKMhjl89qnRjTAspY11Xi+Z644AwbPTCWmQ
	 9BXv+ESnZs83iETK03bpji4AkYis0kei7GLUxaXay0gVryLu3ZLp4R3nsR2iIm+5ur
	 oLvKSdmTSx3s9KD1j3SZyidLR+TWEuUfgFBQ3AhazuK+f5D86uB9D6xPQVXfGfPh/o
	 Cdg3QuWLwZUApTpocbxVw76nAfb6IqR++wbR/7lfcfZ7B1tozgA9kpzVx+2x5m/Srx
	 zxfAy3bAPpV0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DCC2E80AAD;
	Mon, 31 Aug 2026 15:18:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1221B23E
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 15:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EFBD540082
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 15:54:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0gapvtk9KU1n for <intel-wired-lan@lists.osuosl.org>;
 Sun, 30 Aug 2026 15:54:33 +0000 (UTC)
X-Greylist: delayed 304 seconds by postgrey-1.37 at util1.osuosl.org;
 Sun, 30 Aug 2026 15:54:31 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256
 header.s=default header.b=X4nyemi6
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.254.49.198;
 helo=mail-m49198.qiye.163.com; envelope-from=runyu.xiao@seu.edu.cn;
 receiver=<UNKNOWN> 
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com
 [45.254.49.198])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 63A9E40077
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 15:54:30 +0000 (UTC)
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4bd7a2105;
 Sun, 30 Aug 2026 23:49:20 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: anthony.l.nguyen@intel.com
Cc: przemyslaw.kitszel@intel.com, richardcochran@gmail.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, runyu.xiao@seu.edu.cn, jianhao.xu@seu.edu.cn,
 stable@vger.kernel.org
Subject: [PATCH net] igb: initialize PTP lock before registering PHC
Date: Sun, 30 Aug 2026 23:49:12 +0800
Message-Id: <20260830154912.2712900-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0535c69c303a1kunm233e997d10627a
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaQxkfVkpCGk5CSUJCT09CGlYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
 xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=X4nyemi6vu4tmw1fy1QRs7Noc2eW3bgUHCE3J2Hs95OvYpBt94IemQkqthL4A6mgBbZKFWOrsQlrQNx6mgJDVwsU2sneMp9t9s6vl3DtGjhmQCDSon3tD4OjmmsJi3ZezoQ295OAjbcXhEnRl2hw/2KRsUKjO/GC0J6pXRxguS8=;
 s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1; 
 bh=f1gzZMaQn/1LyNKQ9BDeU2sp9XpnY13ijo2O/3Sv6sg=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Approved-At: Mon, 31 Aug 2026 15:18:57 +0000
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

igb_ptp_init() registers the PHC before initializing
adapter->tmreg_lock.  ptp_clock_register() publishes the PHC device,
so a userspace PTP operation can enter a callback and take the lock
before it has been initialized.

Initialize tmreg_lock before registering the PHC so all published PTP
callbacks see a valid lock.

Fixes: b888c510f7b3 ("igb: Avoid starting unnecessary workqueues")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/net/ethernet/intel/igb/igb_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 638d8242b..2a4ea327a 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -1378,6 +1378,7 @@ void igb_ptp_init(struct igb_adapter *adapter)
 		return;
 	}
 
+	spin_lock_init(&adapter->tmreg_lock);
 	adapter->ptp_clock = ptp_clock_register(&adapter->ptp_caps,
 						&adapter->pdev->dev);
 	if (IS_ERR(adapter->ptp_clock)) {
@@ -1388,7 +1389,6 @@ void igb_ptp_init(struct igb_adapter *adapter)
 			 adapter->netdev->name);
 		adapter->ptp_flags |= IGB_PTP_ENABLED;
 
-		spin_lock_init(&adapter->tmreg_lock);
 		INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
 
 		if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
-- 
2.34.1

