Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FECDC98302
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 11:36:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E361F605F9;
	Tue, 22 Sep 2026 11:36:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GIQSb1SA1rrR; Tue, 22 Sep 2026 11:36:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1D31160762
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790076967;
	b=n4q+4tROK8//Gmiysguvf3AZ63U3uk4KB6EmyAxPSfGVbrJE7rFHzdycAt8W3WA0fxTh
	 1p0i4xLnS75mM6uWg7uVfMK4zlR/I0Z2zFlhm7J1mjSEli5mSM4+isPZBGGzJApN0o1ZX
	 RZSKErBddZ/osHDBLxjsOd7ty0rWwD+AdMqGpeTgb+5SRcbhFqjwzPGRKqAaLwhzPbWIY
	 6DH8uV/BcomLSlNiV6apZMHgPL4JnGNpXwIwqmXUoPxnX1repUigKo76w4fm+Xzy1xNWA
	 iZsKm9UMMI2qTNDKMUt9J2xtgXE6o1YdNvZhZOm8W2K76Li0UfPmMr5hC9Mx8kCH7cw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790076967;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YQGntyncCE6Ts827BbErJg68ZnMr2DBjecynMPRpXWY=;
	b=FIk61kaCLbkgaMk7sfUsSUzm/QA9IYLKUeEroeUJ11R3eINGMT5+vGfWOl0+jhVhoMMZ
	 ipi1GVDiO0VFZ2h3AbsL8oDZ8vpvV0g41O4pXqmbCi15aRgAgdbavpIjCLKnURWBSf7Nr
	 tG01SS51e7oaVGjqBp4lzi6m7MLF+s8acUo2Hw57RQnT78hCcrksK3MCWtjh0/lQB5zeZ
	 7q1aw6GP+yuc79bBxCe5Q1HbcV7plONYPmS42BtNv+MJ8Ms1cSDvGh8Z3mJl5Dtwi3siS
	 2GDMqBP/SEOgt1lPSgi3/Xwajthkmkb5Pue4wVBY6/VBMWPWAlxfhp1EPyzU2AfzhZg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790076967;
	bh=YQGntyncCE6Ts827BbErJg68ZnMr2DBjecynMPRpXWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h02HtPcy0Mr2zc3aGPWOxZ/aNFw59rLAdZNC0zCiE7StfS/HyQptc2bHxvOepNvPA
	 5WNG0XWVW98ER7nW5eL0W4HHpnuNs0a3tuZ30q0FgFj+2xa2z0FFZ9NIM9dBOiYXxL
	 r7ctVULPtaX2xwYNQndFX4tVFymo+GVSNoEr1a/h+/cTMS4FprHUUPIJPHKOv56wze
	 +s2iB3mOxjYlE0CG14d/33K1k1YX0lc6WybUWyJW5ixzrFcDsACFGHahU73nlzp3Ig
	 YpqxRYE0feCMeqpZScffaewSvWEmI+qBzYPls+hQNn/ggtqdCc53YjUb973/UYJwJQ
	 +1oc6Ss0ocN9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D31160762;
	Tue, 22 Sep 2026 11:36:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D40EBA20
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 11:36:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BA3F880C50
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 11:36:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4SjVxG_0h0sG for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 11:36:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0052680C4E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790076963;
 b=rEOmQjcy95L7tfGW0+1y3RC8G1CnWh6twUQVQk8FIHznRq0+NmIHR/9Dtyds21Wvvb9/
 SaccAocyTJQZ/qWJndWESR+S8CCHvs9mr7wDVQcaVv+sCNyNBBXf5E4R/ltRkcYB4t/p6
 nzIrKuAdOKe63tJwE6uVmHazuOb4cAMmdYpJBG4lxDqSGCCmJy49yHlNoeSpZMWTiGFOw
 QLWToVMqEF2bZC6FljeLQ8enOOPd9QcdwPcQ463uLO+NeiQp+PI980DGx3t2Wm52xvwjG
 rxh/NfmVQTpmTtVG6kp12SOwRbCB4vNs9HK/fN/BdYyLbr0VhwquAt1DuAVEPgcYfFw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790076963;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=YQGntyncCE6Ts827BbErJg68ZnMr2DBjecynMPRpXWY=;
 b=iuk3vQXzcS4ZcwxzLWmNW+tjileWEpoHaXb02Byc7svU4vxb9fulqTk6ZLDiEQMdsHTM
 YeLTgD/RNx+6c2b8mTgsoQ07qxgK0wFIo/DHKu6ZnZbzYFGIjZo4XujK3466G1wVcb48n
 kTBsViA0YX39ITFaKK4T4GqEAGt0od+kxV9AFLHLLXRjQxbN0AU9hqL6nJeIAGJrzUAx1
 9yLz/QnNkEEfAk0YhLdTB6lsHjuC4dywMElvky4moYpfObgpcg/hWOuCvAkTbcC+mxhYi
 zDX9nRUFwB6JvL/bPnS0djH6GGeDV3EXUJ986M50duz2VorsehTry9Ac5GJnWBDtQyA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=N4OK6YYd; 
 arc=none smtp.remote-ip=192.198.163.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=N4OK6YYd
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0052680C4E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 11:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790076963; x=1821612963;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0oxY2IqGDY/2V7icmio8r/7J85s/Evd99fGLb1HfZ/k=;
 b=N4OK6YYdFFTyu6qDTmBGFRx1W7TuIX0/vjro7vKXKcnUJqb6Q0jVPbck
 JNd5oBR1vxT1XZpFA2+QfKKQL1CoytwMZclptlQm0o5L0+yqQPLbJtGmy
 kNH2Wf7fHXZCic1DW0XrWk+zP5n5p6KBrSwbG22D+hRW4SmZvwYsUzd+R
 5k+xoEJ2TiZOL8YFzO67ETZPtq0QbxjmL0vdYbpge1N6n6e7RCBRJJ2S3
 4shX0+z1YWFie3ZwWgk5+OcZv/xcHrrzhHwAr3mYSB6rwVkR5zBRvSiqd
 ShoyCz45ugzsfMsECFSYJIz6bKKn5JIOsj+tdyqJuXRWersaj+WoiR+HI g==;
X-CSE-ConnectionGUID: b7cUrL7xQASqJFT+bT5tEQ==
X-CSE-MsgGUID: KyXJVEa4QSmL+nXJprOdaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90787337"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="90787337"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 04:36:02 -0700
X-CSE-ConnectionGUID: n76H0qB8S6asiwsFcamHDQ==
X-CSE-MsgGUID: 9X/MHD//TvuXvEuRHV/vsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="272591995"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by fmviesa007.fm.intel.com with ESMTP; 22 Sep 2026 04:36:02 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net v2 3/4] ixgbe: Restore previous XDP program on
 ixgbe_setup_tc() failure
Date: Tue, 22 Sep 2026 11:35:57 +0000
Message-ID: <20260922113558.2288111-4-sergey.temerkhanov@intel.com>
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

When enabling or disabling an XDP program requires a queue
reconfiguration, ixgbe_xdp_setup() swaps in the new program with
xchg() before calling ixgbe_setup_tc(). If ixgbe_setup_tc() fails,
the adapter was left pointing at the new program even though the
reconfiguration did not complete, leaking the reference to the old
program and leaving inconsistent state.

ixgbe_setup_tc() may have already reconfigured the queues for the new
program before failing. The XDP ring layout then no longer matches the
previous program, for example when removing a program has removed the
XDP TX rings. Restore the previous program and rebuild the queues for
it so adapter->xdp_prog remains consistent with the ring configuration.
Otherwise, a later open could run XDP without XDP TX rings and
dereference a NULL ring. ixgbe_setup_tc() handles the device having
been left down by the failed reconfiguration.

Fixes: 3fe1d0a48d21 ("ixgbe: XDP: fix checker warning from rcu pointer")
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 40 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 1f23a035a90b..6ef51b822a50 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7348,6 +7348,25 @@ static void ixgbe_free_all_rx_resources(struct ixgbe_adapter *adapter)
 			ixgbe_free_rx_resources(adapter->rx_ring[i]);
 }
 
+static bool ixgbe_ring_resources_allocated(struct ixgbe_adapter *adapter)
+{
+	int i;
+
+	for (i = 0; i < adapter->num_tx_queues; i++)
+		if (adapter->tx_ring[i] && adapter->tx_ring[i]->desc)
+			return true;
+
+	for (i = 0; i < adapter->num_xdp_queues; i++)
+		if (adapter->xdp_ring[i] && adapter->xdp_ring[i]->desc)
+			return true;
+
+	for (i = 0; i < adapter->num_rx_queues; i++)
+		if (adapter->rx_ring[i] && adapter->rx_ring[i]->desc)
+			return true;
+
+	return false;
+}
+
 /**
  * ixgbe_max_xdp_frame_size - returns the maximum allowed frame size for XDP
  * @adapter: device handle, pointer to adapter
@@ -9921,6 +9940,7 @@ int ixgbe_setup_tc(struct net_device *dev, u8 tc)
 {
 	struct ixgbe_adapter *adapter = ixgbe_from_netdev(dev);
 	struct ixgbe_hw *hw = &adapter->hw;
+	bool running;
 
 	/* Hardware supports up to 8 traffic classes */
 	if (tc > adapter->dcb_cfg.num_tcs.pg_tcs)
@@ -9933,7 +9953,17 @@ int ixgbe_setup_tc(struct net_device *dev, u8 tc)
 	 * match packet buffer alignment. Unfortunately, the
 	 * hardware is not flexible enough to do this dynamically.
 	 */
-	if (netif_running(dev))
+	if (!netif_device_present(dev))
+		return -ENETDOWN;
+
+	running = netif_running(dev);
+
+	/* If a previous ixgbe_open() failed, the netdev can still be
+	 * administratively up after IRQs and ring resources have already been
+	 * released. Skip ixgbe_close() only in that state; ixgbe_down() leaves
+	 * resources for ixgbe_close() to release.
+	 */
+	if (running && ixgbe_ring_resources_allocated(adapter))
 		ixgbe_close(dev);
 	else
 		ixgbe_reset(adapter);
@@ -10972,8 +11002,14 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
 			synchronize_rcu();
 		err = ixgbe_setup_tc(dev, adapter->hw_tcs);
 
-		if (err)
+		if (err) {
+			xchg(&adapter->xdp_prog, old_prog);
+			err = ixgbe_setup_tc(dev, adapter->hw_tcs);
+			/* An ndo_bpf error leaves old_prog attached in the core. */
+			if (err)
+				return err;
 			return -EINVAL;
+		}
 		if (!prog)
 			xdp_features_clear_redirect_target(dev);
 	} else {
-- 
2.53.0

