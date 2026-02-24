Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E4EE9B24D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Feb 2026 11:10:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ABD5060BF2;
	Tue, 24 Feb 2026 11:10:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wP5nqFFiP7d8; Tue, 24 Feb 2026 11:10:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DCDAD60BBD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771931454;
	bh=b7SGsY27CdpAkxE8fKkuv4hWvQA7HeB3SBHwOZJPlGQ=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HGTiOIDAx1ZT6b9JtEzW7+1rZivOLioTQQqW27lroqnCZEXI/QHCsRvQZQ60zTCJd
	 ZJ5tMTKlRVaiPP1NWYQlUQGE0Kvw+yt0av5VL4RJtl6GntrYex6qOle41OEbaIG9I4
	 ei3tLrJZmKngMS7sfs1YekbDYDSQjOiVZDMV5d4gFHXPEXlLyih/YPaLriSfmu6gTk
	 aWYpPUDFRkZVD2F+zqABnayO/P0w+aRXX3QFBS7YLFxdDW7jAwePA7N4qR7byCwezc
	 g3CC3QrHVOhoNfbmt04nUH7i0xr79l/jmNbcKGsemUWw1zO0mWtLRJOI+184R62Cwq
	 VxFJX4iq1mBkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DCDAD60BBD;
	Tue, 24 Feb 2026 11:10:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C6F6249
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Feb 2026 11:10:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 75A3641BEC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Feb 2026 11:10:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fq9YeWuPwaS6 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Feb 2026 11:10:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=mika.westerberg@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7B0C341BE9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7B0C341BE9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7B0C341BE9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Feb 2026 11:10:51 +0000 (UTC)
X-CSE-ConnectionGUID: 5IfbsP0iSxWm+f9iK11bDQ==
X-CSE-MsgGUID: 4cxwow8iQWG4oK050Jtygg==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="98404997"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="98404997"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 03:10:50 -0800
X-CSE-ConnectionGUID: YNqqA14XSzebFs1i1wvxyQ==
X-CSE-MsgGUID: lHEG7HAeTqm3HSQtwgxBow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="215892053"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa008.jf.intel.com with ESMTP; 24 Feb 2026 03:10:45 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
 id 1A74795; Tue, 24 Feb 2026 12:10:44 +0100 (CET)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-pci@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, Bjorn Helgaas <bhelgaas@google.com>,
 Lukas Wunner <lukas@wunner.de>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Vitaly Lifshits <vitaly.lifshits@intel.com>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Dima Ruinskiy <dima.ruinskiy@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Date: Tue, 24 Feb 2026 12:10:40 +0100
Message-ID: <20260224111044.3487873-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260224111044.3487873-1-mika.westerberg@linux.intel.com>
References: <20260224111044.3487873-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771931451; x=1803467451;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4GiY9KnO3IGfcB9TBZYZbeVvvhjJF6YhNoqrn+ZUS4o=;
 b=AyeahibwmjN9cXOkwyfnFoi8RlxqZwFRFmB0/Nw0tu50bbBR9GHnVUiH
 qTRQOQqgcTB6+8MN+fawyVDA/wZ//nfrI/m9j3wlI+rvytfEuRWIb/FAf
 umG8US3c5eDJbBYLx3VcRpFYUI09sLVu23OmBG8TU3IJls24UQ/9rczi6
 4rMyys+Fu/w/fn5/J9g8aRz8YS0NgTlwitshOYdZUDLKttg4lbY/x/Kfp
 UGSmpKrLfp8VixZp93mVEO0ZQheU8aEMx1g02OxYcz0hV7Z0ozM4weCD8
 fuTZnUKGENvZXpPWV+RpG1WSQHtFCyTZt8Bts/oRg9xlStGlHDLJgkBoQ
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Ayeahibw
Subject: [Intel-wired-lan] [PATCH 1/5] igc: Call netif_queue_set_napi() with
 rntl locked
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

When runtime resuming igc we get:

  [  516.161666] RTNL: assertion failed at ./include/net/netdev_lock.h (72)

Happens because commit 310ae9eb2617 ("net: designate queue -> napi
linking as "ops protected"") added check for this. For this reason drop
the special case for runtime PM from __igc_resume(). This makes it take
rtnl lock unconditionally.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 27e5c2109138..7ffd34bfa14e 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7518,7 +7518,7 @@ static void igc_deliver_wake_packet(struct net_device *netdev)
 	netif_rx(skb);
 }
 
-static int __igc_resume(struct device *dev, bool rpm)
+static int __igc_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct net_device *netdev = pci_get_drvdata(pdev);
@@ -7563,11 +7563,9 @@ static int __igc_resume(struct device *dev, bool rpm)
 	wr32(IGC_WUS, ~0);
 
 	if (netif_running(netdev)) {
-		if (!rpm)
-			rtnl_lock();
+		rtnl_lock();
 		err = __igc_open(netdev, true);
-		if (!rpm)
-			rtnl_unlock();
+		rtnl_unlock();
 		if (!err)
 			netif_device_attach(netdev);
 	}
@@ -7577,12 +7575,12 @@ static int __igc_resume(struct device *dev, bool rpm)
 
 static int igc_resume(struct device *dev)
 {
-	return __igc_resume(dev, false);
+	return __igc_resume(dev);
 }
 
 static int igc_runtime_resume(struct device *dev)
 {
-	return __igc_resume(dev, true);
+	return __igc_resume(dev);
 }
 
 static int igc_suspend(struct device *dev)
-- 
2.50.1

