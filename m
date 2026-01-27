Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A919DCA6C92
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Jan 2026 08:57:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7415B60F38;
	Tue, 27 Jan 2026 08:57:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pl8E1IgOuCp8; Tue, 27 Jan 2026 08:57:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CBFB860F2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769504222;
	bh=Hpm3tzHmLebq8eIS8qDAzoE8I3X/7qHvO8PMgK5y+KM=;
	h=From:To:CC:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=somSR+Cjgmtq/xlbuns8DJz4OM5tLS70olF7rgG5flJpF1nwcLxYgmOoc152Qr7+6
	 dI+NPmFUuv9qx5sIwPMJrid78/Z3fWvjhwsncECEEqGKp++3u8ULi2NcujCW6xE4IW
	 tJfihkUeM+vEC9AqDyy35J9hAxVYzkI3EyP9EiO0lWChnIv2bXXJZHyFjJ3OxBIVVt
	 N+z5FGETTUBmr7p8L0WTCIn3QnQFzXsRO0/tcy7X4WzMfXOLoUpVBKRB46MMK85SBJ
	 Baa/Y+95j95MpN2zbOXCnutUhBaJLkAxIe1J7kTJXbZzJzBHYuRWGavYnLP7ER2ida
	 BRk0thIdFRduQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CBFB860F2D;
	Tue, 27 Jan 2026 08:57:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D7AE02F4
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Jan 2026 08:57:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BC83F409DD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Jan 2026 08:57:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ax07aNNStjKG for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Jan 2026 08:57:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=44.245.243.92;
 helo=pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com;
 envelope-from=prvs=4803e00d0=takkozu@amazon.co.jp; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D8943404F1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D8943404F1
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [44.245.243.92])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D8943404F1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Jan 2026 08:57:00 +0000 (UTC)
X-CSE-ConnectionGUID: PCqPgmyxTsqX5IPybaFVKA==
X-CSE-MsgGUID: XXDa8TXbRuydT3HlY2gr/g==
X-IronPort-AV: E=Sophos;i="6.21,256,1763424000"; d="scan'208";a="11205858"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 08:56:58 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:27460]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.218:2525]
 with esmtp (Farcaster)
 id 2d422e7d-f6de-45cd-9d73-b8f9930c4032; Tue, 27 Jan 2026 08:56:57 +0000 (UTC)
X-Farcaster-Flow-ID: 2d422e7d-f6de-45cd-9d73-b8f9930c4032
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Tue, 27 Jan 2026 08:56:57 +0000
Received: from 603e5f7bc1fe.amazon.com (10.37.245.7) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Tue, 27 Jan 2026 08:56:55 +0000
From: Takashi Kozu <takkozu@amazon.com>
To: <anthony.l.nguyen@intel.com>
CC: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
 <netdev@vger.kernel.org>, <aleksandr.loktionov@intel.com>,
 <pmenzel@molgen.mpg.de>, <piotr.kwapulinski@intel.com>, <enjuk@amazon.com>,
 Takashi Kozu <takkozu@amazon.com>
Date: Tue, 27 Jan 2026 17:54:09 +0900
Message-ID: <20260127085410.79645-7-takkozu@amazon.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260127085410.79645-5-takkozu@amazon.com>
References: <20260127085410.79645-5-takkozu@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.37.245.7]
X-ClientProxiedBy: EX19D032UWB004.ant.amazon.com (10.13.139.136) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1769504220; x=1801040220;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Hpm3tzHmLebq8eIS8qDAzoE8I3X/7qHvO8PMgK5y+KM=;
 b=JUebszPbD/WTGQgK0tzbyDbuiO746wfUzH7TgIKObJnVdFoRJU5lkMne
 959ZD5sdm0UXKCqnX14oo8FFohxAoHBbYzYjPL/ZgpNqgB9JAvXhCTrqO
 TAmhSzq0zp1YxPFvYkm0Vrg838GXM8owBcQ1NA8jlLFcF8IOCfZNGsYv2
 hkaSsWB3ZqE1azLybkAtDBwlVC480PG4lpWjB0MC4ke4rTQTYexgCbFRJ
 /4fojbRV3FMHz25vdbOXgimGAsK4v2pwlFOF9SNH5jonGF2OabmMXZpJV
 vkJ03hZtG1bvMsfeVd7FKKm0nAWw6q0q9ifaM6nNd0WpLmtL7HLGlI1rY
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amazon.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256
 header.s=amazoncorp2 header.b=JUebszPb
Subject: [Intel-wired-lan] [PATCH iwl-next v5 2/3] igb: expose RSS key via
 ethtool get_rxfh
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

Implement igb_get_rxfh_key_size() and extend
igb_get_rxfh() to return the RSS key to userspace.

This can be tested using `ethtool -x <dev>`.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Takashi Kozu <takkozu@amazon.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index a93069b761a6..b387121f0ea7 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -3297,10 +3297,12 @@ static int igb_get_rxfh(struct net_device *netdev,
 	int i;
 
 	rxfh->hfunc = ETH_RSS_HASH_TOP;
-	if (!rxfh->indir)
-		return 0;
-	for (i = 0; i < IGB_RETA_SIZE; i++)
-		rxfh->indir[i] = adapter->rss_indir_tbl[i];
+	if (rxfh->indir)
+		for (i = 0; i < IGB_RETA_SIZE; i++)
+			rxfh->indir[i] = adapter->rss_indir_tbl[i];
+
+	if (rxfh->key)
+		memcpy(rxfh->key, adapter->rss_key, sizeof(adapter->rss_key));
 
 	return 0;
 }
@@ -3340,6 +3342,11 @@ void igb_write_rss_indir_tbl(struct igb_adapter *adapter)
 	}
 }
 
+static u32 igb_get_rxfh_key_size(struct net_device *netdev)
+{
+	return IGB_RSS_KEY_SIZE;
+}
+
 static int igb_set_rxfh(struct net_device *netdev,
 			struct ethtool_rxfh_param *rxfh,
 			struct netlink_ext_ack *extack)
@@ -3504,6 +3511,7 @@ static const struct ethtool_ops igb_ethtool_ops = {
 	.get_module_eeprom	= igb_get_module_eeprom,
 	.get_rxfh_indir_size	= igb_get_rxfh_indir_size,
 	.get_rxfh		= igb_get_rxfh,
+	.get_rxfh_key_size	= igb_get_rxfh_key_size,
 	.set_rxfh		= igb_set_rxfh,
 	.get_rxfh_fields	= igb_get_rxfh_fields,
 	.set_rxfh_fields	= igb_set_rxfh_fields,
-- 
2.52.0

