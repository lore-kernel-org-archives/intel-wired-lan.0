Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F58C00140
	for <intel-wired-lan@archiver.kernel.org>; Mon,  8 Aug 2022 08:04:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0BEFB40329;
	Mon,  8 Aug 2022 08:04:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0BEFB40329
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1659945866;
	bh=kOlu0ufDgo+dzMi9EdQ7kEhnnc/zx61+kCzxlUOSvaA=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=Hf9WxxnbvavDlmWD62THS+opMcJdoZRBcQvMU74XaFh5rBz/+zYuz3Rvj6aMVmWca
	 oC4KbO+DpGGl5tBmh+tbNEt4zG1xbzKd8b5xVoguYDlAGk2YbAR1YxtjqywbTP9B2O
	 RUQKQ2ruPiXsq67ugTB6Y/aso+geQldGCGHb8R1C/1YW0cYQxz6cNBjfIDCcpB5KBx
	 JiLidgzG//zoUcNWwdn5pd7JVoGHgp79QrKv8S+9TY0KkUCq+N85vcbzLn1hiPx0DZ
	 moyVMYLbxqYZEKUb8Ad79sxYBLJWeNdgNbh4nMJy6TIRhSjbJ00Y2jK8VvEKR8rwdf
	 cvyJMvDWS96YA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aKjEcaiToFtd; Mon,  8 Aug 2022 08:04:25 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id F1211404DF;
	Mon,  8 Aug 2022 08:04:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F1211404DF
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id A62551BF591
 for <intel-wired-lan@lists.osuosl.org>; Mon,  8 Aug 2022 08:04:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 892BC414C4
 for <intel-wired-lan@lists.osuosl.org>; Mon,  8 Aug 2022 08:04:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 892BC414C4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eQyQGz0J0BFB for <intel-wired-lan@lists.osuosl.org>;
 Mon,  8 Aug 2022 08:04:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 25D41414A2
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 25D41414A2
 for <intel-wired-lan@lists.osuosl.org>; Mon,  8 Aug 2022 08:04:20 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="290540595"
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; d="scan'208";a="290540595"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2022 01:04:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; d="scan'208";a="931954435"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
 by fmsmga005.fm.intel.com with ESMTP; 08 Aug 2022 01:04:18 -0700
Received: from kord.igk.intel.com (kord.igk.intel.com [10.123.220.9])
 by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id
 27884HQ8023298; Mon, 8 Aug 2022 09:04:18 +0100
From: Mikael Barsehyan <mikael.barsehyan@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Mon,  8 Aug 2022 10:04:30 +0200
Message-Id: <20220808080430.36199-1-mikael.barsehyan@intel.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1659945860; x=1691481860;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=WWMe2fLc0qUfnQdalfYRespia52ZyO34KdNKTSIuy70=;
 b=WvHDrNzVXMMz9TCmS/HC0uGMQQ0vnDEEntBvlBROCU7GOoAeN6NHoQmE
 C5mEOQJGdjOvmlmx2VUg0K5Z2zq7D2hUQT+Y6jBcVLwr8aPxEKzMja7Qv
 vUjz9gCQ+M2jjbsKHwDXvkLAiT6kx2NWCkKxLMxzwPNug4CMsOsok/RRY
 TIYKMdiUQQ3Z7ulZavQoACKudlsqto3fk3XqlqizSyh6rBAeACj/xXi62
 gnQN+ncyepAIj7HMPArsA0FgKEAOji2RVyT9rfYwPZs4z6l9GpPwFGc7k
 cSYgnT0Jm46i/w3kDF6kkx2rQ2SDgbWBzeTy0fzWg3KJ5L3W0UA9if9lW
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=WvHDrNzV
Subject: [Intel-wired-lan] [PATCH net-next v3] ice: remove non-inclusive
 language from codebase
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Mikael Barsehyan <mikael.barsehyan@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Remove non-inclusive language from the driver where
possible; replace "master" with "primary"

Signed-off-by: Mikael Barsehyan <mikael.barsehyan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 12 ++++++------
 drivers/net/ethernet/intel/ice/ice_lag.h |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index c9f7393b783d..417a72e79afc 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -61,13 +61,13 @@ static void ice_lag_set_backup(struct ice_lag *lag)
  */
 static void ice_display_lag_info(struct ice_lag *lag)
 {
-	const char *name, *peer, *upper, *role, *bonded, *master;
+	const char *name, *peer, *upper, *role, *bonded, *primary;
 	struct device *dev = &lag->pf->pdev->dev;
 
 	name = lag->netdev ? netdev_name(lag->netdev) : "unset";
 	peer = lag->peer_netdev ? netdev_name(lag->peer_netdev) : "unset";
 	upper = lag->upper_netdev ? netdev_name(lag->upper_netdev) : "unset";
-	master = lag->master ? "TRUE" : "FALSE";
+	primary = lag->primary ? "TRUE" : "FALSE";
 	bonded = lag->bonded ? "BONDED" : "UNBONDED";
 
 	switch (lag->role) {
@@ -87,8 +87,8 @@ static void ice_display_lag_info(struct ice_lag *lag)
 		role = "ERROR";
 	}
 
-	dev_dbg(dev, "%s %s, peer:%s, upper:%s, role:%s, master:%s\n", name,
-		bonded, peer, upper, role, master);
+	dev_dbg(dev, "%s %s, peer:%s, upper:%s, role:%s, primary:%s\n", name,
+		bonded, peer, upper, role, primary);
 }
 
 /**
@@ -164,8 +164,8 @@ ice_lag_link(struct ice_lag *lag, struct netdev_notifier_changeupper_info *info)
 	lag->bonded = true;
 	lag->role = ICE_LAG_UNSET;
 
-	/* if this is the first element in an LAG mark as master */
-	lag->master = !!(peers == 1);
+	/* if this is the first element in an LAG mark as primary */
+	lag->primary = !!(peers == 1);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_lag.h b/drivers/net/ethernet/intel/ice/ice_lag.h
index c2e3688dd8fd..51b5cf467ce2 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.h
+++ b/drivers/net/ethernet/intel/ice/ice_lag.h
@@ -24,7 +24,7 @@ struct ice_lag {
 	struct net_device *upper_netdev; /* upper bonding netdev */
 	struct notifier_block notif_block;
 	u8 bonded:1; /* currently bonded */
-	u8 master:1; /* this is a master */
+	u8 primary:1; /* this is primary */
 	u8 handler:1; /* did we register a rx_netdev_handler */
 	/* each thing blocking bonding will increment this value by one.
 	 * If this value is zero, then bonding is allowed.
-- 
2.35.3

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
