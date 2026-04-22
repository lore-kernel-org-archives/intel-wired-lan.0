Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EA8FA1FD1
	for <intel-wired-lan@archiver.kernel.org>; Wed, 22 Apr 2026 16:20:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 65EC261B89;
	Wed, 22 Apr 2026 16:20:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YiopVNYQAR3a; Wed, 22 Apr 2026 16:20:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C3DE760D94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776874822;
	bh=734I3G72OJbK4gdSy/3+p1wA+3ENKQbVirs04y2d5Vc=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xW4BxTh/z8QsqUSfHsC5FOQ3QMQi2aGeXgODMaBZu+IiGy9heXh7Gjt489U0kIbbk
	 rDKuYANvr0sVV5CJcDSGMyGSDojebiKKL3HpQIJOuKgEkBrLnpQJ/8ATvfcLRi8KR4
	 P5tHgwSdQ+tC4J+SFmpmSAhpLyDJNsKjcdg4nXgcE41/v/19ceZsKz3a1DBU2lEdoc
	 AQtYLQWj1rLQ+x8le2zNyBr7oQRVtKB9l10DylmMiWTRG4uXVfQ9LFfVbItPH0EID8
	 68uWCwRsMkCZ6tudM4ktthKQ9yEMWxsW5RGrKWQ7MpKvA6jD0B9nHM1iq/fxhtBff9
	 qonM9Ml0JIGJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C3DE760D94;
	Wed, 22 Apr 2026 16:20:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EA06E257
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Apr 2026 16:20:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC1A860C22
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Apr 2026 16:20:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pNpSh005Z1vA for <intel-wired-lan@lists.osuosl.org>;
 Wed, 22 Apr 2026 16:20:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=khai.wen.tan@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org DB22E60DBF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DB22E60DBF
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DB22E60DBF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Apr 2026 16:20:19 +0000 (UTC)
X-CSE-ConnectionGUID: v8IQqt7mSsi8oXoIwi95tg==
X-CSE-MsgGUID: lHqp/UuJSduZy+fMxBO5ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="88134492"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; d="scan'208";a="88134492"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 09:20:19 -0700
X-CSE-ConnectionGUID: yMP4YfLNTJSVIIjF5wcA8Q==
X-CSE-MsgGUID: 9rYquxjxS0KxfOb29LoFtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; d="scan'208";a="228052453"
Received: from unknown (HELO localhost.png.intel.com) ([10.107.255.61])
 by fmviesa010.fm.intel.com with ESMTP; 22 Apr 2026 09:20:15 -0700
From: KhaiWenTan <khai.wen.tan@linux.intel.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, faizal.abdul.rahim@intel.com,
 hong.aun.looi@intel.com, khai.wen.tan@intel.com,
 Faizal Rahim <faizal.abdul.rahim@linux.intel.com>, Looi,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 KhaiWenTan <khai.wen.tan@linux.intel.com>
Date: Wed, 22 Apr 2026 23:57:00 +0800
Message-ID: <20260422155701.7420-3-khai.wen.tan@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422155701.7420-1-khai.wen.tan@linux.intel.com>
References: <20260422155701.7420-1-khai.wen.tan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776874820; x=1808410820;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dLjvwNQGbgsihw8eMls+gO1zacDih/y1JKuhzvrV16g=;
 b=AAjw2YdUmUpcXV791tPdNSZzuKfqBDNEEuDsJx+BJcv7JRPrpNFGMmVw
 mrqqfSTIalcBG8t/6FqX6RdLZbJTAQpZvCW87CAYOepakGeyfvTVb7NpR
 JZlKR34TltJ0sVIbZmVl4k+wIb9+SWrk+bG6RK3WtlUWoU59HQelq0b6d
 CxjwTeJSPSZkg4AlrpCMD6jDIm+LjhwmSsTh6xlLVxePGX/v5ATIzX/M6
 q5kAia0J2gk2fmfV5kGsyMAMEJkNUyhlbc9TutTnloSgbBPL8b+O43npk
 /5RbmBCxNx4syn/4spL6W7ucSJv707KzUWxDMHQ+/G6PajA1zPh/IIXB9
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=AAjw2YdU
Subject: [Intel-wired-lan] [PATCH iwl-next v3 2/3] igc: move autoneg-enabled
 settings into igc_handle_autoneg_enabled()
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

From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

Move the advertised link modes and flow control configuration from
igc_ethtool_set_link_ksettings() into igc_handle_autoneg_enabled().

No functional change.

Reviewed-by: Looi, Hong Aun <hong.aun.looi@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 72 ++++++++++++--------
 1 file changed, 44 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 0122009bedd0..cfcbf2fdad6e 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -2000,6 +2000,49 @@ static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
 	return 0;
 }

+/**
+ * igc_handle_autoneg_enabled - Configure autonegotiation advertisement
+ * @adapter: private driver structure
+ * @cmd: ethtool link ksettings from user
+ *
+ * Records advertised speeds and flow control settings when autoneg
+ * is enabled.
+ */
+static void igc_handle_autoneg_enabled(struct igc_adapter *adapter,
+				       const struct ethtool_link_ksettings *cmd)
+{
+	struct igc_hw *hw = &adapter->hw;
+	u16 advertised = 0;
+
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  2500baseT_Full))
+		advertised |= ADVERTISE_2500_FULL;
+
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  1000baseT_Full))
+		advertised |= ADVERTISE_1000_FULL;
+
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  100baseT_Full))
+		advertised |= ADVERTISE_100_FULL;
+
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  100baseT_Half))
+		advertised |= ADVERTISE_100_HALF;
+
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  10baseT_Full))
+		advertised |= ADVERTISE_10_FULL;
+
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  10baseT_Half))
+		advertised |= ADVERTISE_10_HALF;
+
+	hw->phy.autoneg_advertised = advertised;
+	if (adapter->fc_autoneg)
+		hw->fc.requested_mode = igc_fc_default;
+}
+
 static int
 igc_ethtool_set_link_ksettings(struct net_device *netdev,
 			       const struct ethtool_link_ksettings *cmd)
@@ -2007,7 +2050,6 @@ igc_ethtool_set_link_ksettings(struct net_device *netdev,
 	struct igc_adapter *adapter = netdev_priv(netdev);
 	struct net_device *dev = adapter->netdev;
 	struct igc_hw *hw = &adapter->hw;
-	u16 advertised = 0;

 	/* When adapter in resetting mode, autoneg/speed/duplex
 	 * cannot be changed
@@ -2032,34 +2074,8 @@ igc_ethtool_set_link_ksettings(struct net_device *netdev,
 	while (test_and_set_bit(__IGC_RESETTING, &adapter->state))
 		usleep_range(1000, 2000);

-	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
-						  2500baseT_Full))
-		advertised |= ADVERTISE_2500_FULL;
-
-	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
-						  1000baseT_Full))
-		advertised |= ADVERTISE_1000_FULL;
-
-	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
-						  100baseT_Full))
-		advertised |= ADVERTISE_100_FULL;
-
-	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
-						  100baseT_Half))
-		advertised |= ADVERTISE_100_HALF;
-
-	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
-						  10baseT_Full))
-		advertised |= ADVERTISE_10_FULL;
-
-	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
-						  10baseT_Half))
-		advertised |= ADVERTISE_10_HALF;
-
 	if (cmd->base.autoneg == AUTONEG_ENABLE) {
-		hw->phy.autoneg_advertised = advertised;
-		if (adapter->fc_autoneg)
-			hw->fc.requested_mode = igc_fc_default;
+		igc_handle_autoneg_enabled(adapter, cmd);
 	} else {
 		netdev_info(dev, "Force mode currently not supported\n");
 	}
--
2.43.0

