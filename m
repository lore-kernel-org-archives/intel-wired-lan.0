Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA83DE87822
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Feb 2026 12:55:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9818260896;
	Tue,  3 Feb 2026 12:55:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iVswsnF0xqKL; Tue,  3 Feb 2026 12:55:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D4F1D60893
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770123350;
	bh=W1p9ZU1anq8c3tA5/K3cU5JbzW1imGiGjezF2dcMG5o=;
	h=From:To:CC:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mRF4aJdgMqrk+FkuFJn0pS6C42PiRpSe1ok9b4gCkyokElYrd234wUCOU8kVcF0K6
	 o+lkvSi1O5GnL4/aTuhCqk+FlcgxBYc6HHzLSs3+Z04Lvakj1gS68Qsm+nji8/wMAT
	 BiUKvB5yjJhoteJVTCulgB5bvg9YK/z1RfY3bqueW0PSY7uq1RHHEWaeGB14/lZeJK
	 6/nrypDOSbszMy5l+whly4FcnGauLTmbySx+sTGtA8W+bUYIDff9UjoHntD6dqg9pg
	 0ach20PAhWpiGFszckPNjqMrtxCQE/aTQUkNvmP89kLYYeBpxzY2ocRWIR8PwGk1x8
	 yuVcAGodxFDAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D4F1D60893;
	Tue,  3 Feb 2026 12:55:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E9D73F5
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Feb 2026 12:55:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D797160873
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Feb 2026 12:55:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y-pIm2KgIXWa for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Feb 2026 12:55:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=44.246.68.102;
 helo=pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com;
 envelope-from=prvs=487b0b5b4=takkozu@amazon.co.jp; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E12E66086D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E12E66086D
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [44.246.68.102])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E12E66086D
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Feb 2026 12:55:48 +0000 (UTC)
X-CSE-ConnectionGUID: BA2TFj8aRWKimPNqD0okYg==
X-CSE-MsgGUID: yiaUqkMeT0i3/+jqQdUuRQ==
X-IronPort-AV: E=Sophos;i="6.21,270,1763424000"; d="scan'208";a="12190615"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 12:55:46 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:29351]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.158:2525]
 with esmtp (Farcaster)
 id bea7ed2c-7832-42d6-9b20-8c0bec80b03f; Tue, 3 Feb 2026 12:55:45 +0000 (UTC)
X-Farcaster-Flow-ID: bea7ed2c-7832-42d6-9b20-8c0bec80b03f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Tue, 3 Feb 2026 12:55:45 +0000
Received: from 603e5f7bc1fe.amazon.com (10.37.245.7) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Tue, 3 Feb 2026 12:55:43 +0000
From: Takashi Kozu <takkozu@amazon.com>
To: <horms@kernel.org>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
 <netdev@vger.kernel.org>, <aleksandr.loktionov@intel.com>,
 <pmenzel@molgen.mpg.de>, <piotr.kwapulinski@intel.com>, <enjuk@amazon.com>,
 Takashi Kozu <takkozu@amazon.com>
Date: Tue, 3 Feb 2026 21:54:13 +0900
Message-ID: <20260203125417.37285-8-takkozu@amazon.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260203125417.37285-5-takkozu@amazon.com>
References: <20260203125417.37285-5-takkozu@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.37.245.7]
X-ClientProxiedBy: EX19D044UWB003.ant.amazon.com (10.13.139.168) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1770123348; x=1801659348;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=W1p9ZU1anq8c3tA5/K3cU5JbzW1imGiGjezF2dcMG5o=;
 b=GfCt9Q1ec16i/HMExvGa8Q1esMz6M+SxKwPvyHyPmGBQC+Cc1z04lrKB
 oiZ1Vz0qSH80P5Y2818cANIGGsf7J+GLyug+GAm4QeyxpIzJ2D468FjC8
 tSbX7GgZCZZO0isOsuD4JmSFQn4+mGtri6l/KOCbeyO2k6E9i3DhHv+Qt
 qGHZ6GB8PXkw9nD6Wfv28m4dIT4wVfWepzi1ogDyyyg8QqU1lYfG5/ynt
 E+0+zaEwCAe48932Y0zv68fXqPgUQlHVRIC0smPq+5kixjeDWTWDHJ2W4
 jPoOSp7eFy2OQqiEjk5Kr4U8+RilF0ozuNj0Aw34pObAxwGqLYLlBgPbJ
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amazon.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256
 header.s=amazoncorp2 header.b=GfCt9Q1e
Subject: [Intel-wired-lan] [PATCH iwl-next v6 3/3] igb: allow configuring
 RSS key via ethtool set_rxfh
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

Change igb_set_rxfh() to accept and save a userspace-provided
RSS key. When a key is provided, store it in the adapter and write the
E1000 registers accordingly.

This can be tested using `ethtool -X <dev> hkey <key>`.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Takashi Kozu <takkozu@amazon.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 48 +++++++++++---------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index b387121f0ea7..b4eef14c09d5 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -3357,35 +3357,39 @@ static int igb_set_rxfh(struct net_device *netdev,
 	u32 num_queues;
 
 	/* We do not allow change in unsupported parameters */
-	if (rxfh->key ||
-	    (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
-	     rxfh->hfunc != ETH_RSS_HASH_TOP))
+	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
+	    rxfh->hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
-	if (!rxfh->indir)
-		return 0;
 
-	num_queues = adapter->rss_queues;
+	if (rxfh->indir) {
+		num_queues = adapter->rss_queues;
 
-	switch (hw->mac.type) {
-	case e1000_82576:
-		/* 82576 supports 2 RSS queues for SR-IOV */
-		if (adapter->vfs_allocated_count)
-			num_queues = 2;
-		break;
-	default:
-		break;
-	}
+		switch (hw->mac.type) {
+		case e1000_82576:
+			/* 82576 supports 2 RSS queues for SR-IOV */
+			if (adapter->vfs_allocated_count)
+				num_queues = 2;
+			break;
+		default:
+			break;
+		}
 
-	/* Verify user input. */
-	for (i = 0; i < IGB_RETA_SIZE; i++)
-		if (rxfh->indir[i] >= num_queues)
-			return -EINVAL;
+		/* Verify user input. */
+		for (i = 0; i < IGB_RETA_SIZE; i++)
+			if (rxfh->indir[i] >= num_queues)
+				return -EINVAL;
 
 
-	for (i = 0; i < IGB_RETA_SIZE; i++)
-		adapter->rss_indir_tbl[i] = rxfh->indir[i];
+		for (i = 0; i < IGB_RETA_SIZE; i++)
+			adapter->rss_indir_tbl[i] = rxfh->indir[i];
+
+		igb_write_rss_indir_tbl(adapter);
+	}
 
-	igb_write_rss_indir_tbl(adapter);
+	if (rxfh->key) {
+		memcpy(adapter->rss_key, rxfh->key, sizeof(adapter->rss_key));
+		igb_write_rss_key(adapter);
+	}
 
 	return 0;
 }
-- 
2.52.0

