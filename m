Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975F6CA5FED
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 10:05:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A5964043C;
	Tue,  6 Oct 2026 10:05:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hw4Z-7qTQneo; Tue,  6 Oct 2026 10:05:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 841AC4039C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791281156;
	b=j/Uak+Bjeqh5fkTU996AilAZ4qYHIYVtQIn0Tae22X8NpEhb+g0uZ6L1zgkMve9sfAiK
	 7YKPTuer3gF9W3ivWBEwCTh70EIzbFeS0+2dfVm3jOaahKKi5A4dF6KBjNwaJ1xkL9CX0
	 LlMGnyL8rqE9xLyQllTWl0CwZG1GYLWhZ0G6YjOxCOk+Qe72RlQq3aBq9HMIUYXKnOSZg
	 Pe1Lr1WZEOOc0DILnIRh/qOg89XUs3tFr6/KqV0lkVOh68wWNOXC44osCxG4KjkMc6m3A
	 9qu8lvtno7TPa6ufMMIQvS/LvENreKRmcuUNqKeT3iolLt2U0a8Ppn3LpYcMN83vvWg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791281156;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fP1nEGTj+LyqgEyvdM/Alvdjjqs5UvsHboPOtNnh0nY=;
	b=PITcPkOuUVdU9qGPC7lVba2jNL4necIawQ8+Xr1mVxsFnGBPoMfnt6Q9To60HnueN7j9
	 6kWgVr1nYNUHw7RZ/eRK9AwEtB5PbxctZrvMzytA34riq0egICyWGjmVqrE+LiBMScsTl
	 ne0DeoBMiD1a92YFV/cRmixUBCbECyTxaf2mtUXu3Sx+DcJGYPYoEC4Vrxvxvl1C56odu
	 lpkDqI1WRhXx13rTo2TiUg9BYKwwjnzD/6FyVLx5jPe7p2CRyqvFUHRg+Hc4BJ4EBLPdu
	 8w9ktluf9vJ6ejROSYVoMRLVDfe4jnj4DLwT3aTLAP/UT+NuYY+tksURrpfSS88VwdQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791281156;
	bh=fP1nEGTj+LyqgEyvdM/Alvdjjqs5UvsHboPOtNnh0nY=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I+7M/K0rET/yfWuudm0Wo4QeKGXbThEypEr5dnYZfBhrXej7qYjJ5b6/pJeN77BtH
	 WPzOXwE3KCRhV9OrJ/Uooi433z1wQujhRcdy07R93fjYfcbmk7D/G9vyjlXvxx3FoW
	 td/sULF1HgcqOEpLzqoH2CC/Vmjg8txCg8t/9B11pQtRZHHPeC8YTrZyaBL7/45mTy
	 g9ibVzJt7WzSddNHOphGNg7yIbT52aIaOtz9dZKB+HlH3qjcMT2dXYbY/v6ce4bnIx
	 zU03N4tPrJmk5EM5qABhsFffADIU6rQ70kdgCBaUv8tynu+6MZmPzdR0+Si8vMtPSr
	 jKAWznYRhqdVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 841AC4039C;
	Tue,  6 Oct 2026 10:05:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BBEF732F
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 09:45:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A19FB60740
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 09:45:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KjVDymKLK3Fz for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 09:45:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C9311605D8
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791279936;
 b=cmyob9jj3XYy1E3S39gWGs1Jy+5iBJ6EWR5FFfRBmHuTnmkj2p9zFaDBggeY6NLRlWH1
 zOL89GHHslYKr+U2D44VDgzU24A/ipMhLKdBffRK8EdmYCRh6rZQB9t44MVfmrvL8VWks
 iCR0hlFmcIAxz6JbP/IjaXJ2e7XLSiMa5nUayB6gvdXNgQS8FdFkm3DEciDjuX7Pluz88
 nb7M4gM9Xy/bAKzvpEAM0X/UtU07EAf6eu9hmcihqgCxzdPqAU3xU5Yt1QLUR0FLVKwl7
 anEsSbI7OnQGY61chzVJxlxeEWklzwHiHalKwUHq/beoPJVbwhFOayj+XGqQ4T0GXig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791279936;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=fP1nEGTj+LyqgEyvdM/Alvdjjqs5UvsHboPOtNnh0nY=;
 b=ntUBpM50f7aDIsfdc86V77eGChDPCqdjt9PeQICRyje+QHHpstiBYVRgC4VGLh/9fGr9
 bQIBbGHWVxvHbpvT6ChUWRiPzL0c4Nf9i0p4GIcolOCupUq23UPx8x73KCYn+w+oNZMu0
 wGmCRjLUtTvkANv0R7qLj3NO51996v2ylWBvbvPaCteSbJPGRM5fNi9C8G4DCFW7wQxv7
 qgfj+5t5KL3JFXNV58LUhXgJuUKJ86hNJq7ecCKYtleKsMMjE4zOVK5suGv9CRbWxdMN0
 LQx1V0u0KeegblsVwQmTiozjmlIKW2b1llQFvV8wBK/muukThc/sRzTeG/oh6bZ2CsQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="dS/xzKd1"; 
 arc=none smtp.remote-ip=192.198.163.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=dS/xzKd1
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C9311605D8
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 09:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791279937; x=1822815937;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=WuRv5x9pJAq2Tiug8Zxx4yV6SH93VbDDI4eNiBIBVAQ=;
 b=dS/xzKd1TwkWkyapW2ILrQD05GOUuCrYfsi3+fkr8WhrBkQL3ko385j5
 ayKhWMgOervLkxXzQL6oVfY1NMuV6yMiaSwHg15LR0vbVpiZzlmNEktpr
 tdNhqCdJTk5Zd44mWp820upJ7CO/rkxAs+9n+nhJUpORndKY0ePVNKqG0
 GudSZJX0A47OG82/H8v23k0hO/fGjS5kBTVMxyPSJlgPwsr+279aKoRpg
 hKxfiFR/2z1qN/bSuSgsStkN5QeH3upyaSlGqj29KVpvXXhXush/P+FrD
 O1ZXqJYD9GkRkTmk0RtoVp0MU1vp2XEkGX03eKVMQGUfjpI5JIlGmF0eA Q==;
X-CSE-ConnectionGUID: pSjpeB7nR/myDIohojkyLQ==
X-CSE-MsgGUID: pVsKCpRvQZOHI8QdwZ7NnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="3207"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="3207"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 02:45:36 -0700
X-CSE-ConnectionGUID: RCsOpd4sSRCdPTKsrjhfGQ==
X-CSE-MsgGUID: KtgDoKKXR+mbTsO0kvps6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="280350277"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa003.jf.intel.com with ESMTP; 06 Oct 2026 02:45:35 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Subject: [PATCH iwl-net v3 1/5] ixgbe: Refactor device operations to check
 whether netdev is available
Date: Tue,  6 Oct 2026 09:45:30 +0000
Message-ID: <20261006094534.418657-2-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006094534.418657-1-sergey.temerkhanov@intel.com>
References: <20261006094534.418657-1-sergey.temerkhanov@intel.com>
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
 .../net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c   | 13 +++++--
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 34 ++++++++++++-------
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  |  4 +--
 5 files changed, 40 insertions(+), 18 deletions(-)

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
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index a219590b3118..42d3594827f7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7395,7 +7395,7 @@ static int ixgbe_change_mtu(struct net_device *netdev, int new_mtu)
 	/* must set new MTU before calling down or up */
 	WRITE_ONCE(netdev->mtu, new_mtu);
 
-	if (netif_running(netdev))
+	if (ixgbe_netif_running(netdev))
 		ixgbe_reinit_locked(adapter);
 
 	return 0;
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

