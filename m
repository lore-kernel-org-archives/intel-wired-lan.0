Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FB6C982FA
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 11:36:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 507946077A;
	Tue, 22 Sep 2026 11:36:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Q3xlGVSYISC; Tue, 22 Sep 2026 11:36:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CCE3B6076F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790076964;
	b=D0MHeujRsMb169zCxT7ZujQ83PCvzCebr9WrsjX/hpGBIi49zYWoiFHaYnXcwxPMgxnc
	 FMfJoUe/fKj9SQ5DdkSB1rzqi2VV0fJo5l1uGC+T+04AKtbW9kmzd9UMbEhMq40XFj9Mp
	 dbSIiZCwKmMl2fLY0/+D7qefnnYzjU57UeOe+b5cQNaAXdvYY7fco3YNIyweKE0bOdWq6
	 P1CCa6h9NC0wuJ1CXlqmINr2F4YLvubG8bi2kjLSMbLgzp3Y9E1iawf0bhJ06bjqO3dB+
	 bp+I3ZGar+IAaC6boM5LSNRXFEP5U5OoB+fn0YrxasRhzvvP8z3Ul3QYrOACkbsonMw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790076964;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yWAgkfKSmqt545gitMXZ8a7jbtkEUIJ7ZnP73mjZcPk=;
	b=h01IjJtc+QT7b3V5882Cmq7x+OViBwAUFr5joyj4JMs5DfemXg7PdXTQGpUwc24+LsOA
	 iBvl7G9YJe8a8gPjZWGivAnKJ0yNSI4wAWHA+3n8795A85wLnNbLYciGHnLnEZ8BIU+my
	 VUpaLcBszXfGK23gWecbKn5Lip+lqQYsFDzvOlqsHLaJNMZxay+ZQ6Qy634uExyeYvjeN
	 Mj6g5SgK8t482DotORnNI8IM/VIaI2efzGe+m/L6qU5ojFHr3ap6XO9sTC0vFlw7or1eB
	 EqjYlHxW0nEuuE67fsMFK2ipKqWq3Veah8Yq7fk34IrRh9q3a6/YZRv4dazVJ7uARtQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790076964;
	bh=yWAgkfKSmqt545gitMXZ8a7jbtkEUIJ7ZnP73mjZcPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n2LXCn3SdNiSwBcdTSrPcG0MzqEjue6SfXJJxlSvfz/iZukK9g04YPgc+9DDkXksf
	 VO9BdkXZ4LwKWO0D08HxEGScOJB50J8H3l+/TmK7Nfj+dSgYRihhXYiWlaubtwCRYo
	 Ndf/wwoNLgs8DPCYRtGPQOClU7dNEDo7NKZqdaZivSq5ws2RR4J/q4mmOtRTFDrZzI
	 KYmba2MsDJjHGPplYEgcBnpsNQO1Tkl6cALHK8R6ohJVN631QyHhxTwCMhq8vn5R54
	 fdDGlQDUvYiKcIDeH/JKXr9G1qdabJ3GJV8osDibJkPVlyE6oC7nGwDT7aMsoARgr+
	 Q1xNsHXj8AOMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CCE3B6076F;
	Tue, 22 Sep 2026 11:36:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 52BF3A20
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 11:36:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4441C80C53
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 11:36:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UVYB_pMAIbWQ for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 11:36:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 23EB980C50
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790076961;
 b=Wco7vfOBng6ZoNAi+CrLQtMwAomdreDOZNjXY9rOC6vDoL3PrfA29XC7rXWT1xpDX3od
 /iLMTGHuTwgad0lpBiB8IH6s+FxLUhPOHp0E0g77BV4kibZvxezyVJEQKUQfeffE81IXf
 panA/iS+DOJi4fL/YEQ6HvVCPPiH0WfGK8Gpgo/7OctDcJS4ZmDiJhbjMdwon5kR2B/3G
 9qe1tvc7x0lbJuFGchFbcLwW8MGyxgZuJZ9iZR7w6mCGwE/35GyA1auKx2ougWmylBnlv
 EjhozlvT4WPyXldtjSKTQw9/LgpT/GCnUOlvj0X/to4O+dwrMu2jAB23B+Xn6USlxOg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790076961;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=yWAgkfKSmqt545gitMXZ8a7jbtkEUIJ7ZnP73mjZcPk=;
 b=NdLuk4+n5LERtCtB4ka7Ue5uDu9dY3FCRmp0Z+Y8IfiKJEm3km1nSJ9JaYohRs3D4NVM
 A2pMGY5s3JBiHJa+13BZURZC5w6Idh0cs8Wa4IjJ9b/UdxfCrNZvhdaCBpcCUOOEXJyss
 VA3s4mTKtyjnC5dyxT4dDdCL/WM0RckG71RoZK7jJqzRjomUehrMEzx0Nu/8iBYlD06e3
 I60QnBKYsarapQli9MsSMzF1kwfC+OLkHb6o8ro9UaQRizrKP5qVh2XXT3m16wJY/k5r6
 wtP26vqhx+8ye8AzWIc4DGMCkYs/b0r+wrGIGWbX2xX4Cis0/7LA089HBesKB8L0Jpw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=DmC1TmJv; 
 arc=none smtp.remote-ip=192.198.163.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=DmC1TmJv
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 23EB980C50
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 11:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790076961; x=1821612961;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YV8sRZ8xJN1n8liM5c8kSZBGA4H9ljZpQrKkF+6r8fc=;
 b=DmC1TmJv6RxrHsW4H5Eh1nIFqRHYcrmX6unUYoTJX+0mkCMNC3YKVWCk
 h0/EisKX9QR9sCU2aJSppAPDXAETuSLYtGnkFaxbIaK/gqtzxPGOriZbh
 MstkYAVok+44YFY99AyaaOgLj1SUMywNninI5K5fAfsuZwKrtp5h3pD92
 JKyWtVu526kcBInYLKfgh9paOCE/fvTEaNRldY+DwcjLa6FM0Zsgvyxnz
 MWC5pnrBrIV1ku0QQoLeoE3uc5rIzFTRzJ027fjDauAsURXpwW7FNyuX7
 ZgjJVJk/A1GgTHOaARPCgstD0lPP57AJdgLZcmqWjck+tFClojQfxIfuo g==;
X-CSE-ConnectionGUID: fNPHwegnRISjmbSjg7VKwA==
X-CSE-MsgGUID: E11U2k4aSYuSvBoU/6FvEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90787331"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="90787331"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 04:36:00 -0700
X-CSE-ConnectionGUID: +jcLnOB9RoGTJrGbT9cR8g==
X-CSE-MsgGUID: 28vyYbmsT4a3niy0kSLn4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="272591981"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by fmviesa007.fm.intel.com with ESMTP; 22 Sep 2026 04:36:00 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net v2 1/4] ixgbe: Refactor device operations to check
 whether netdev is available
Date: Tue, 22 Sep 2026 11:35:55 +0000
Message-ID: <20260922113558.2288111-2-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922113558.2288111-1-sergey.temerkhanov@intel.com>
References: <20260922113558.2288111-1-sergey.temerkhanov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Refactor several ixgbe driver operations to check whether the
netdev they operate on is enabled. This will allow the system
to get synchronized, for example, during the PCI resets.

Fixes: f7f37e7ff2b9 ("ixgbe: handle close/suspend race with netif_device_detach/present")
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  5 +++
 .../net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c   | 13 +++++-
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 34 +++++++++------
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c | 29 +++++++++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.h |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 42 +++++++++++++++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  |  4 +-
 7 files changed, 101 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index a5304390f975..bac3b85a1d63 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -955,6 +955,11 @@ extern char ixgbe_driver_name[];
 extern char ixgbe_default_device_descr[];
 #endif /* IXGBE_FCOE */
 
+static inline bool ixgbe_netif_running(struct net_device *netdev)
+{
+	return netif_running(netdev) && netif_device_present(netdev);
+}
+
 int ixgbe_open(struct net_device *netdev);
 int ixgbe_close(struct net_device *netdev);
 void ixgbe_up(struct ixgbe_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c
index 382d097e4b11..4420d3c32996 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c
@@ -277,17 +277,23 @@ static void ixgbe_dcbnl_get_pfc_cfg(struct net_device *netdev, int priority,
 static void ixgbe_dcbnl_devreset(struct net_device *dev)
 {
 	struct ixgbe_adapter *adapter = ixgbe_from_netdev(dev);
+	bool running;
+
+	if (!netif_device_present(dev))
+		return;
+
+	running = netif_running(dev);
 
 	while (test_and_set_bit(__IXGBE_RESETTING, &adapter->state))
 		usleep_range(1000, 2000);
 
-	if (netif_running(dev))
+	if (running)
 		dev->netdev_ops->ndo_stop(dev);
 
 	ixgbe_clear_interrupt_scheme(adapter);
 	ixgbe_init_interrupt_scheme(adapter);
 
-	if (netif_running(dev))
+	if (running)
 		dev->netdev_ops->ndo_open(dev);
 
 	clear_bit(__IXGBE_RESETTING, &adapter->state);
@@ -515,6 +521,9 @@ static int ixgbe_dcbnl_ieee_setets(struct net_device *dev,
 	if (!(adapter->dcbx_cap & DCB_CAP_DCBX_VER_IEEE))
 		return -EINVAL;
 
+	if (!netif_device_present(dev))
+		return -ENETDOWN;
+
 	if (!adapter->ixgbe_ieee_ets) {
 		adapter->ixgbe_ieee_ets = kmalloc_obj(struct ieee_ets);
 		if (!adapter->ixgbe_ieee_ets)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 1e1db8435506..f6258d1276e3 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -468,6 +468,9 @@ static int ixgbe_set_link_ksettings(struct net_device *netdev,
 	u32 advertised, old;
 	int err = 0;
 
+	if (!netif_device_present(netdev))
+		return -ENETDOWN;
+
 	if ((hw->phy.media_type == ixgbe_media_type_copper) ||
 	    (hw->phy.multispeed_fiber)) {
 		/*
@@ -578,9 +581,9 @@ static void ixgbe_set_pauseparam_finalize(struct net_device *netdev,
 	/* If the thing changed then we'll update and use new autoneg. */
 	if (memcmp(fc, &hw->fc, sizeof(*fc))) {
 		hw->fc = *fc;
-		if (netif_running(netdev))
+		if (ixgbe_netif_running(netdev))
 			ixgbe_reinit_locked(adapter);
-		else
+		else if (netif_device_present(netdev))
 			ixgbe_reset(adapter);
 	}
 }
@@ -1268,7 +1271,7 @@ static int ixgbe_set_ringparam(struct net_device *netdev,
 	while (test_and_set_bit(__IXGBE_RESETTING, &adapter->state))
 		usleep_range(1000, 2000);
 
-	if (!netif_running(adapter->netdev)) {
+	if (!ixgbe_netif_running(adapter->netdev)) {
 		for (i = 0; i < adapter->num_tx_queues; i++)
 			adapter->tx_ring[i]->count = new_tx_count;
 		for (i = 0; i < adapter->num_xdp_queues; i++)
@@ -2251,10 +2254,11 @@ static void ixgbe_diag_test(struct net_device *netdev,
 			    struct ethtool_test *eth_test, u64 *data)
 {
 	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
-	bool if_running = netif_running(netdev);
+	bool if_running = ixgbe_netif_running(netdev);
 
-	if (ixgbe_removed(adapter->hw.hw_addr)) {
-		e_err(hw, "Adapter removed - test blocked\n");
+	if (ixgbe_removed(adapter->hw.hw_addr) ||
+	    !netif_device_present(netdev)) {
+		e_err(hw, "Adapter removed or detached - test blocked\n");
 		data[0] = 1;
 		data[1] = 1;
 		data[2] = 1;
@@ -2468,7 +2472,7 @@ static int ixgbe_nway_reset(struct net_device *netdev)
 {
 	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
 
-	if (netif_running(netdev))
+	if (ixgbe_netif_running(netdev))
 		ixgbe_reinit_locked(adapter);
 
 	return 0;
@@ -2652,7 +2656,8 @@ static int ixgbe_set_coalesce(struct net_device *netdev,
 		else
 			/* rx only or mixed */
 			q_vector->itr = rx_itr_param;
-		ixgbe_write_eitr(q_vector);
+		if (netif_device_present(netdev))
+			ixgbe_write_eitr(q_vector);
 	}
 
 	/*
@@ -3696,6 +3701,9 @@ static int ixgbe_set_eee_e610(struct net_device *netdev,
 	    kedata->eee_enabled)
 		return -EOPNOTSUPP;
 
+	if (!netif_device_present(netdev))
+		return -ENETDOWN;
+
 	hw->phy.eee_speeds_advertised = kedata->eee_enabled ?
 					hw->phy.eee_speeds_supported : 0;
 
@@ -3711,9 +3719,9 @@ static int ixgbe_set_eee_e610(struct net_device *netdev,
 	else
 		adapter->flags2 &= ~IXGBE_FLAG2_EEE_ENABLED;
 
-	if (netif_running(netdev))
+	if (ixgbe_netif_running(netdev))
 		ixgbe_reinit_locked(adapter);
-	else
+	else if (netif_device_present(netdev))
 		ixgbe_reset(adapter);
 
 	return 0;
@@ -3795,9 +3803,9 @@ static int ixgbe_set_eee(struct net_device *netdev, struct ethtool_keee *edata)
 	}
 
 	/* reset link */
-	if (netif_running(netdev))
+	if (ixgbe_netif_running(netdev))
 		ixgbe_reinit_locked(adapter);
-	else
+	else if (netif_device_present(netdev))
 		ixgbe_reset(adapter);
 
 	return 0;
@@ -3879,7 +3887,7 @@ static int ixgbe_set_priv_flags(struct net_device *netdev, u32 priv_flags)
 		adapter->flags2 = flags2;
 
 		/* reset interface to repopulate queues */
-		if (netif_running(netdev))
+		if (ixgbe_netif_running(netdev))
 			ixgbe_reinit_locked(adapter);
 	}
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
index 011fda9c6193..54d8b079ada4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
@@ -830,27 +830,34 @@ static void ixgbe_fcoe_ddp_disable(struct ixgbe_adapter *adapter)
  *
  * Turns on FCoE offload feature in 82599.
  *
- * Returns : 0 indicates success or -EINVAL on failure
+ * Returns: 0 on success or a negative error code on failure
  */
 int ixgbe_fcoe_enable(struct net_device *netdev)
 {
 	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
 	struct ixgbe_fcoe *fcoe = &adapter->fcoe;
+	bool running;
 
+	/* libfcoe calls ndo_fcoe_disable() even when this callback fails. */
 	atomic_inc(&fcoe->refcnt);
 
+	if (!netif_device_present(netdev))
+		return -ENETDOWN;
+
 	if (!(adapter->flags & IXGBE_FLAG_FCOE_CAPABLE))
 		return -EINVAL;
 
 	if (adapter->flags & IXGBE_FLAG_FCOE_ENABLED)
 		return -EINVAL;
 
+	running = netif_running(netdev);
+
 	e_info(drv, "Enabling FCoE offload features.\n");
 
 	if (adapter->flags & IXGBE_FLAG_SRIOV_ENABLED)
 		e_warn(probe, "Enabling FCoE on PF will disable legacy VFs\n");
 
-	if (netif_running(netdev))
+	if (running)
 		netdev->netdev_ops->ndo_stop(netdev);
 
 	/* Allocate per CPU memory to track DDP pools */
@@ -864,8 +871,9 @@ int ixgbe_fcoe_enable(struct net_device *netdev)
 	/* release existing queues and reallocate them */
 	ixgbe_clear_interrupt_scheme(adapter);
 	ixgbe_init_interrupt_scheme(adapter);
+	adapter->fcoe.reinit_pending = false;
 
-	if (netif_running(netdev))
+	if (running)
 		netdev->netdev_ops->ndo_open(netdev);
 
 	return 0;
@@ -882,6 +890,7 @@ int ixgbe_fcoe_enable(struct net_device *netdev)
 int ixgbe_fcoe_disable(struct net_device *netdev)
 {
 	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
+	bool running;
 
 	if (!atomic_dec_and_test(&adapter->fcoe.refcnt))
 		return -EINVAL;
@@ -889,8 +898,10 @@ int ixgbe_fcoe_disable(struct net_device *netdev)
 	if (!(adapter->flags & IXGBE_FLAG_FCOE_ENABLED))
 		return -EINVAL;
 
+	running = ixgbe_netif_running(netdev);
+
 	e_info(drv, "Disabling FCoE offload features.\n");
-	if (netif_running(netdev))
+	if (running)
 		netdev->netdev_ops->ndo_stop(netdev);
 
 	/* Free per CPU memory to track DDP pools */
@@ -903,10 +914,14 @@ int ixgbe_fcoe_disable(struct net_device *netdev)
 	netdev_features_change(netdev);
 
 	/* release existing queues and reallocate them */
-	ixgbe_clear_interrupt_scheme(adapter);
-	ixgbe_init_interrupt_scheme(adapter);
+	if (netif_device_present(netdev)) {
+		ixgbe_clear_interrupt_scheme(adapter);
+		ixgbe_init_interrupt_scheme(adapter);
+	} else {
+		adapter->fcoe.reinit_pending = true;
+	}
 
-	if (netif_running(netdev))
+	if (running)
 		netdev->netdev_ops->ndo_open(netdev);
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.h
index 724f5382329f..81de590268cc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.h
@@ -58,6 +58,7 @@ struct ixgbe_fcoe {
 	dma_addr_t extra_ddp_buffer_dma;
 	unsigned long mode;
 	u8 up;
+	bool reinit_pending;
 };
 
 #endif /* _IXGBE_FCOE_H */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index a219590b3118..1f23a035a90b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -182,6 +182,7 @@ EXPORT_SYMBOL(ixgbe_xdp_locking_key);
 static struct workqueue_struct *ixgbe_wq;
 
 static bool ixgbe_check_cfg_remove(struct ixgbe_hw *hw, struct pci_dev *pdev);
+static int ixgbe_rebuild_fcoe_queues(struct ixgbe_adapter *adapter);
 static void ixgbe_watchdog_link_is_down(struct ixgbe_adapter *);
 static void ixgbe_watchdog_link_is_up(struct ixgbe_adapter *);
 static void ixgbe_watchdog_update_link(struct ixgbe_adapter *);
@@ -7395,7 +7396,7 @@ static int ixgbe_change_mtu(struct net_device *netdev, int new_mtu)
 	/* must set new MTU before calling down or up */
 	WRITE_ONCE(netdev->mtu, new_mtu);
 
-	if (netif_running(netdev))
+	if (ixgbe_netif_running(netdev))
 		ixgbe_reinit_locked(adapter);
 
 	return 0;
@@ -7423,6 +7424,10 @@ int ixgbe_open(struct net_device *netdev)
 	if (test_bit(__IXGBE_TESTING, &adapter->state))
 		return -EBUSY;
 
+	err = ixgbe_rebuild_fcoe_queues(adapter);
+	if (err)
+		return err;
+
 	netif_carrier_off(netdev);
 
 	/* allocate transmit descriptors */
@@ -12345,6 +12350,24 @@ static pci_ers_result_t ixgbe_io_slot_reset(struct pci_dev *pdev)
 	return result;
 }
 
+static int ixgbe_rebuild_fcoe_queues(struct ixgbe_adapter *adapter)
+{
+#ifdef IXGBE_FCOE
+	int err;
+
+	if (!adapter->fcoe.reinit_pending)
+		return 0;
+
+	ixgbe_clear_interrupt_scheme(adapter);
+	err = ixgbe_init_interrupt_scheme(adapter);
+	if (err)
+		return err;
+
+	adapter->fcoe.reinit_pending = false;
+#endif
+	return 0;
+}
+
 /**
  * ixgbe_io_resume - called when traffic can start flowing again.
  * @pdev: Pointer to PCI device
@@ -12356,6 +12379,8 @@ static void ixgbe_io_resume(struct pci_dev *pdev)
 {
 	struct ixgbe_adapter *adapter = pci_get_drvdata(pdev);
 	struct net_device *netdev = adapter->netdev;
+	bool running;
+	int err;
 
 #ifdef CONFIG_PCI_IOV
 	if (adapter->vferr_refcount) {
@@ -12366,8 +12391,19 @@ static void ixgbe_io_resume(struct pci_dev *pdev)
 
 #endif
 	rtnl_lock();
-	if (netif_running(netdev))
-		ixgbe_open(netdev);
+	running = netif_running(netdev);
+	err = ixgbe_rebuild_fcoe_queues(adapter);
+	if (err)
+		e_dev_err("Cannot rebuild queue layout after PCI error recovery: %d\n",
+			  err);
+	if (running && !err) {
+		err = ixgbe_open(netdev);
+		if (err)
+			e_dev_err("Cannot re-open netdev after PCI error recovery: %d\n",
+				  err);
+	}
+	if (err && running)
+		dev_close(netdev);
 
 	netif_device_attach(netdev);
 	rtnl_unlock();
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 89f96c463f02..02820982b202 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -39,7 +39,7 @@ static int ixgbe_xsk_pool_enable(struct ixgbe_adapter *adapter,
 	if (err)
 		return err;
 
-	if_running = netif_running(adapter->netdev) &&
+	if_running = ixgbe_netif_running(adapter->netdev) &&
 		     ixgbe_enabled_xdp_adapter(adapter);
 
 	if (if_running)
@@ -71,7 +71,7 @@ static int ixgbe_xsk_pool_disable(struct ixgbe_adapter *adapter, u16 qid)
 	if (!pool)
 		return -EINVAL;
 
-	if_running = netif_running(adapter->netdev) &&
+	if_running = ixgbe_netif_running(adapter->netdev) &&
 		     ixgbe_enabled_xdp_adapter(adapter);
 
 	if (if_running)
-- 
2.53.0

