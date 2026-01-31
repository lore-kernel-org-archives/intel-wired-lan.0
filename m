Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566A3D7977D
	for <intel-wired-lan@archiver.kernel.org>; Sat, 31 Jan 2026 16:31:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CF0760B66;
	Sat, 31 Jan 2026 16:31:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f1RY-7kBOnPN; Sat, 31 Jan 2026 16:31:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 611AF60B64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769877104;
	bh=XkB0UJdSADANAbmF+JgfoF3mhihZYqHI6IAIOSB6NXo=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mjEVkX+InkGSwWYaX4X+SHBTpe5hds9bE7l8VfHwisxDuI01ItByW/g1uGPfNTEfW
	 U+8Uf4KJM9WnvUNtfqZ/l/vnUVdNvAAwXWskaujlFdSUH5ru1lMiU5PrmVzRNwYBzh
	 w7TikJpIz21/H55J7Dt2V49P5OXPciabh+WBfmPdO/4zsSLWWhokN4NzgL4+D8liDS
	 SZIJptIeZDJIo5zWJSJXDF+mo9qVG5i9HSOeoFU7I98uCKEyHPP3vPIUW/8J99xHWm
	 GgTS3al7mHRS4rcFtFUT5+qlLoF4KuAG3xRTJcBN+Zg+HNuIXqQOAnc+4zwzln+I7A
	 PJyCv5pUjV7jQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 611AF60B64;
	Sat, 31 Jan 2026 16:31:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C13031E0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 31 Jan 2026 16:31:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AFABC8349A
 for <intel-wired-lan@lists.osuosl.org>; Sat, 31 Jan 2026 16:31:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aupp0WilhTjH for <intel-wired-lan@lists.osuosl.org>;
 Sat, 31 Jan 2026 16:31:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=49.212.198.91;
 helo=www2881.sakura.ne.jp; envelope-from=kohei@enjuk.jp; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7501083443
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7501083443
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7501083443
 for <intel-wired-lan@lists.osuosl.org>; Sat, 31 Jan 2026 16:31:42 +0000 (UTC)
Received: from ms-a2 (248.212.13.160.dy.iij4u.or.jp [160.13.212.248])
 (authenticated bits=0)
 by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60VGVPea039683
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 1 Feb 2026 01:31:25 +0900 (JST) (envelope-from kohei@enjuk.jp)
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Vitaly Lifshits <vitaly.lifshits@intel.com>,
 Simon Horman <horms@kernel.org>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 kohei.enju@gmail.com, Kohei Enju <kohei@enjuk.jp>
Date: Sat, 31 Jan 2026 16:29:38 +0000
Message-ID: <20260131163037.88108-4-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260131163037.88108-1-kohei@enjuk.jp>
References: <20260131163037.88108-1-kohei@enjuk.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 bh=XkB0UJdSADANAbmF+JgfoF3mhihZYqHI6IAIOSB6NXo=; 
 c=relaxed/relaxed; d=enjuk.jp;
 h=From:To:Subject:Date:Message-ID;
 s=rs20251215; t=1769877085; v=1;
 b=R0gNYgPwNDX86udfeD4kz63cQh1NW/Bf0EwiikmwKatkqDpH0mWANdGGduDG4I3h
 RskNGMdY3m6EvldWEiTDjOMJAkq1zNpkPB+obVQIYn8cMkXjw8fws3F7JuoKJyWb
 G1mvULGGIg0iGbfJuXKeP/2XviLmlwGcYUeCIsOcpMygsQrDundLGcQ5WzO/M0dF
 FKy7y4cQEylE5Mmi0FqXlZ0g+u815aYW9hMJ36WKriHEZktqmhH4JVFyqUUcA6rA
 +CQQLiL5KqzPVVJgUrbDKF2OgKQWH9rawpf6/Hw2BJPuIwZV7qlqihLS7RAK3lG/
 LNkYIYscEgo66BtahAj8rA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=enjuk.jp
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=enjuk.jp header.i=@enjuk.jp header.a=rsa-sha256
 header.s=rs20251215 header.b=R0gNYgPw
Subject: [Intel-wired-lan] [PATCH v2 iwl-next 3/3] igc: allow configuring
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

Change igc_ethtool_set_rxfh() to accept and save a userspace-provided
RSS key. When a key is provided, store it in the adapter and write the
RSSRK registers accordingly.

This can be tested using `ethtool -X <dev> hkey <key>`.

Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 30 +++++++++++---------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 661b044073ca..eb5b146f6f10 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1539,24 +1539,28 @@ static int igc_ethtool_set_rxfh(struct net_device *netdev,
 	int i;
 
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
 
-	/* Verify user input. */
-	for (i = 0; i < IGC_RETA_SIZE; i++)
-		if (rxfh->indir[i] >= num_queues)
-			return -EINVAL;
+		/* Verify user input. */
+		for (i = 0; i < IGC_RETA_SIZE; i++)
+			if (rxfh->indir[i] >= num_queues)
+				return -EINVAL;
 
-	for (i = 0; i < IGC_RETA_SIZE; i++)
-		adapter->rss_indir_tbl[i] = rxfh->indir[i];
+		for (i = 0; i < IGC_RETA_SIZE; i++)
+			adapter->rss_indir_tbl[i] = rxfh->indir[i];
 
-	igc_write_rss_indir_tbl(adapter);
+		igc_write_rss_indir_tbl(adapter);
+	}
+
+	if (rxfh->key) {
+		memcpy(adapter->rss_key, rxfh->key, sizeof(adapter->rss_key));
+		igc_write_rss_key(adapter);
+	}
 
 	return 0;
 }
-- 
2.51.0

