Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44534C98311
	for <intel-wired-lan@archiver.kernel.org>; Thu, 24 Sep 2026 00:36:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EACC88136A;
	Thu, 24 Sep 2026 00:36:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uCkuyasbaUMt; Thu, 24 Sep 2026 00:36:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A3C7881E05
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790210195;
	b=jvAcRfE/OtL8O6TA7YkuU1oh2Ncq7jYAFvz2VM2OGRcbyzo8eBJvWkH5lJ0nDy8Q78s6
	 L4KVysHCHCRKi2hvAUfcqXjTB62cLCz1EbBsUXUAlI6MAVy/VJ9H4hcP8fNdf/WTZWcdn
	 PtRcp1lu4A7h7eq5COzS9LjbpqksHBCgL+6vEohOiRYS5lQ5yR0wRTPeIVidxLukeRPHE
	 LVPbTXeodMRkwhQG5zcVCqFm9oXrei2SwtJ8YqE+Se5HEY0egxo5cSjoXC9rXGk/E3FbG
	 P86NlWiwcGCHhKcCcR+X2OfOK4Ir7TYbms0qhpBJ/NP/5BG+6Wf6J5VWFvyoLIsiFbw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790210195;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 Received:Received:X-Farcaster-Flow-ID:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=B7RBGF5D+3ue1bmia1p4Q+3QlHImTns1+iDejVI5ZF4=;
	b=NpH/3cxbN9MHmpIGnjT0rjxI8x15gF8+XUJW4uh03hKr2ISH2xmVIYlEPv1Qzekzw/2E
	 uTO3iMoP9nh8pvHwU47cMmjppnZYSBeQmVquJ+rcFSXupQOiVkTO9SbioLM7who1+EV40
	 +iv/+/9VYg1MAclCqZ87axHaz5GEgwE9s/77ylOiqpSlhWf3SdP4h443QIQPwrAPgYV66
	 Jbxz4Js2mRxCUf9Td7dJ9syxKRPaP4VzJXS94kfY9wJ8YCZgxoSq77Qvr78wWlDJrYW0o
	 UIC/8/gKDNW9SJgkkOuTu5Ii7wX27Uc2rFvPO7xUpR2bkn2ejrXBDEZZA/0ObSoPeWw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790210195;
	bh=B7RBGF5D+3ue1bmia1p4Q+3QlHImTns1+iDejVI5ZF4=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SI4HtNZaTm1fIf/FOhEhxf2ChBDpLbFq2yTOIq3pdBSpJLS1hmwfD3tanT7IxeHMC
	 S53bcbY+tv8fYArTnE8ChYI5dXVKA+rHC/lFIJweRBY1Kolq3lJyBUuNSd+QeninPC
	 /Qo8Nt2F3JStf7GKpwuPtWCAaKttLx/efrJPHwKGm7n+Tlin6Zuk8R0AMELBk4dArS
	 f+syzljTyHPMyqqCQktbd6fTztxgb5vrRM/eA4eDGwRdmvzT23JYnVHWrLSbCrPZkb
	 oS46xOe0xlkDbnO3W+JuIYTb012UtCWv+ge10WMvbQfzay2Quvrx46F0mEv99avyQE
	 ni0n8RT4PBWUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A3C7881E05;
	Thu, 24 Sep 2026 00:36:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E4C893B7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Sep 2026 23:58:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CA9EE410E7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Sep 2026 23:58:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eyc7qi2Wab3s for <intel-wired-lan@lists.osuosl.org>;
 Wed, 23 Sep 2026 23:58:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 28911410E6
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=50.112.246.219
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790207920;
 b=gzDG9Ua/OBfT0Lbx70gHG524XDMsXjDMXKGUFRzZYhBml9WxS6Ao2EqIwnMkyRagl275
 aUpW3fItq3JgySaN5nN5+BFiaQYJJ4hDIZhl32LmlwhaqWY6cJTFaIpihOAN1bPfA0ZF6
 uz5hx7Wc1kUipMxCx3RG1P1FoFVM5dBD4aOV22GCZrk5BklubcJI0BMBKe67HYqosCLA/
 oXSVbnImdFpRYPIZ6N1wnaECL+2OxfhGz66QWS3BCM7PiaP/6JMvFILaxgiQGRzUGrcgo
 SI8h2EN21MTjFVid0eHX848OJp9nEygF2X/P/eXTKnjNEx4VPA0Z3mS3Jk79KrYYU6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790207920;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
 X-ClientProxiedBy;
 bh=B7RBGF5D+3ue1bmia1p4Q+3QlHImTns1+iDejVI5ZF4=;
 b=OvkCykZPEjh0xffhucfeO5uSJ1e+YYZifl8wxGEclw82UK8Bm2BisnCVwUGxelUGa++/
 JT+qBTGQpuGOU/Q3qQ4lZ+5NXuAuPWzV69VGgsDJhKr8oGGIYOmw6oo3Q9ZY3Fwg9bGtL
 5x3rvglyCWibIawSs/rrXBi9yKRN5xiuEX3RbXqRl/uZgTHyMnRaLGpj8N5AM80HlKIq6
 fVyiZNTZVb7l7bZmQeg0b6+qEZ9V/MQxQxTgNwmTNrbbgzMG1ytnd7wbCBuWc+b18bEze
 DjFpc15IzslN1s9HD6OwbN62hdsC0gO5jrbCdAsjPjwUIOertyYrVO4/CWmLkcpjykA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=amazon.com; 
 dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256
 header.s=amazoncorp2 header.b=QYhZz+vh; 
 arc=none smtp.remote-ip=50.112.246.219
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=50.112.246.219;
 helo=pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com;
 envelope-from=prvs=7191e218d=hagan@amazon.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=amazon.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256
 header.s=amazoncorp2 header.b=QYhZz+vh
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [50.112.246.219])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 28911410E6
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Sep 2026 23:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1790207920; x=1821743920;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=B7RBGF5D+3ue1bmia1p4Q+3QlHImTns1+iDejVI5ZF4=;
 b=QYhZz+vhlfBDM1YmuXwvpQzkk7fgaMcq+yNN7szDL7OKYsu96gYpn5UR
 MnZV997z4O2prhkHAW3re0LYdj7mI/USG5BSUFNZAC7kKVQg4etyHefD/
 6TGQvRdqMgTtWcncKNY3NGBFmiUWdJarM75HHZZ2jS6PLe46giaxkprAr
 LWmMjHx6k5xR8ZM+fU/seWvTOuP1SGZ9W44E0tVRQXwqZ5xJzXMv3zaC7
 C2EysOC1gck0SyeI2ZhXRqLw7B/pwA4eNiFMGpNkXcJg9GArzZwLqgK0/
 6hevEItlXi8qWJCG6NgWaZkr1klBLgFGHIMkTKYV6yStMIUvKo3khUd1W g==;
X-CSE-ConnectionGUID: vMIXa8SnRtOon/OV3C8JuA==
X-CSE-MsgGUID: GHlwm5gQRAqHnjcxn5KkBg==
X-IronPort-AV: E=Sophos;i="6.27,119,1787011200"; d="scan'208";a="29268731"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 23:58:38 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:24117]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.1:2525] with
 esmtp (Farcaster)
 id 1d62da73-e1e6-463e-a90d-d5bd8a507b09; Wed, 23 Sep 2026 23:58:38 +0000 (UTC)
X-Farcaster-Flow-ID: 1d62da73-e1e6-463e-a90d-d5bd8a507b09
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 23 Sep 2026 23:58:37 +0000
Received: from dev-dsk-hagan-1f-c6b5e25f.us-east-1.amazon.com (172.19.159.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 23 Sep 2026 23:58:36 +0000
From: "Craig I. Hagan" <hagan@amazon.com>
To: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>, 
 <hagan@amazon.com>
Subject: [PATCH iwl-net] e1000e: fix flow control stuck off after link partner
 reset
Date: Wed, 23 Sep 2026 23:58:32 +0000
Message-ID: <20260923235832.473-1-hagan@amazon.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.159.5]
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Mailman-Approved-At: Thu, 24 Sep 2026 00:36:33 +0000
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

On an I219 (pch_spt+) copper with jumbo MTU enabled, a link partner
reset (e.g. a switch reboot) can leave the PHY's pause advertisement
bits dropped. Nothing re-asserts them on link-up, so every renegotiation
resolves flow control to none. rx_crc_errors climb and traffic stalls until
the interface is manually reset. Observed on I219-LM (8086:15b7) at
MTU 9000 behind a switch that was power-cycled.

In the watchdog, detect a completed autonegotiation that resolved
to no flow control despite pause being requested and the pause bits
missing from the advertisement, and schedule reset_task to rebuild
the advertisement (as ethtool -r does). Remediation is limited to three
attempts, 30s apart, until the next link down.

Remediate via the existing reset path rather than re-asserting the
advertisement on link-up; a root-cause rework can follow in net-next.

Fixes: 79849ebc0e06 ("e1000e: initial support for i219")
Cc: stable@vger.kernel.org
Link: https://github.com/systemd/systemd/issues/25925
Assisted-by: LLM
Signed-off-by: Craig I. Hagan <hagan@amazon.com>
---
 drivers/net/ethernet/intel/e1000e/e1000.h  |  11 ++
 drivers/net/ethernet/intel/e1000e/netdev.c | 132 +++++++++++++++++++++
 2 files changed, 143 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index 63ebe0037..4353519d4 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -210,6 +210,17 @@ struct e1000_adapter {
 	/* track device up/down/testing state */
 	unsigned long state;
 
+	/* Flow-control advertisement-latch auto-recovery.
+	 * These MUST persist across the reinit that remediation triggers
+	 * (the reinit generates its own carrier-up), so they are NOT reset
+	 * on link-up. The holdoff and per-episode attempt budget prevent a
+	 * reset/flap storm against a partner that is still booting or that
+	 * genuinely never advertises pause.
+	 */
+	unsigned long fclatch_last_fix;	/* jiffies of last remediation, 0=none */
+	u8 fclatch_attempts;		/* attempts in the current link episode */
+	bool fclatch_gave_up;		/* terminal for episode; re-armed on link-down */
+
 	/* Interrupt Throttle Rate */
 	u32 itr;
 	u32 itr_setting;
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 844f31ab3..28bd33335 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -38,6 +38,15 @@ static int debug = -1;
 module_param(debug, int, 0);
 MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 
+/* Flow-control advertisement-latch auto-recovery tunables. Fixed constants
+ * rather than user knobs: the values only need to be safe, not tunable.
+ *   MAX_ATTEMPTS : autoneg-restart attempts per link episode before giving up
+ *   HOLDOFF      : minimum spacing between attempts; longer than a switch's
+ *                  autoneg settle so we do not fight a still-booting partner
+ */
+#define E1000E_FCLATCH_MAX_ATTEMPTS	3	/* autoneg-restarts per link episode */
+#define E1000E_FCLATCH_HOLDOFF		(30 * HZ)	/* min spacing between attempts */
+
 static const struct e1000_info *e1000_info_tbl[] = {
 	[board_82571]		= &e1000_82571_info,
 	[board_82572]		= &e1000_82572_info,
@@ -5217,6 +5226,113 @@ static void e1000_watchdog(struct timer_list *t)
 	/* TODO: make this use queue_delayed_work() */
 }
 
+/**
+ * e1000e_check_fc_latch - re-assert a dropped pause advertisement
+ * @adapter: board private structure
+ *
+ * On the I219/PCH family at jumbo MTU, an upstream switch reboot can bring the
+ * link back with the PHY's pause-advertisement bits dropped and flow control
+ * resolved to none, even when a pause mode was requested. The driver does not
+ * re-assert the advertisement on a plain link-up (e1000_phy_setup_autoneg()
+ * runs only during a full setup pass), so every later renegotiation resolves
+ * to none and the link does not recover on its own.
+ *
+ * Detect that state from a fresh PHY read and schedule a full reconfigure (the
+ * reset_task path, as ethtool -r uses) to rebuild the advertisement. reset_task
+ * bounces the link and re-enters this check, so the attempt count is kept
+ * across the bounce rather than reset on link-up. Remediation stops after three
+ * tries per link episode; the give-up state is re-armed only on a real
+ * link-down (peer/cable change), so a partner that never advertises pause is
+ * reset three times and then left alone until the link is re-established --
+ * it cannot flap indefinitely.
+ */
+static void e1000e_check_fc_latch(struct e1000_adapter *adapter)
+{
+	struct e1000_hw *hw = &adapter->hw;
+	struct net_device *netdev = adapter->netdev;
+	u16 bmsr = 0, adv = 0, expected;
+	unsigned long now;
+	int rv;
+
+	/* Skip while down/resetting or with a reset already pending. */
+	if (!netif_carrier_ok(netdev) ||
+	    test_bit(__E1000_DOWN, &adapter->state) ||
+	    test_bit(__E1000_RESETTING, &adapter->state) ||
+	    (adapter->flags & FLAG_RESTART_NOW))
+		return;
+
+	/* Limited to I219/PCH copper at jumbo MTU, where the behavior is seen
+	 * and the RX-side impact matters. Act only when a pause mode was
+	 * requested but autoneg resolved none. Pause is only meaningful on a
+	 * full-duplex link, so a half-duplex result legitimately carries no
+	 * pause bits and must not be treated as the fault.
+	 */
+	if (hw->phy.media_type != e1000_media_type_copper ||
+	    hw->mac.type < e1000_pch_spt ||		/* pch_spt+ (I219 and later) */
+	    netdev->mtu <= ETH_DATA_LEN ||		/* jumbo only */
+	    adapter->link_duplex != FULL_DUPLEX ||
+	    !hw->mac.autoneg || !adapter->fc_autoneg ||
+	    hw->fc.current_mode != e1000_fc_none)
+		return;
+	if (hw->fc.requested_mode != e1000_fc_full &&
+	    hw->fc.requested_mode != e1000_fc_rx_pause &&
+	    hw->fc.requested_mode != e1000_fc_tx_pause)
+		return;
+
+	/* Fresh, self-contained reads; act only on a good, autoneg-complete read. */
+	rv = e1e_rphy(hw, MII_BMSR, &bmsr);
+	if (!rv)
+		rv = e1e_rphy(hw, MII_ADVERTISE, &adv);
+	if (rv || !(bmsr & BMSR_ANEGCOMPLETE))
+		return;
+
+	/* Pause bits we should be advertising for the requested mode (mirrors
+	 * e1000_phy_setup_autoneg): full/rx use CAP|ASYM, tx uses ASYM only.
+	 */
+	if (hw->fc.requested_mode == e1000_fc_tx_pause)
+		expected = ADVERTISE_PAUSE_ASYM;
+	else
+		expected = ADVERTISE_PAUSE_CAP | ADVERTISE_PAUSE_ASYM;
+
+	/* The advertisement should carry these bits; missing them while a pause
+	 * mode was requested is the failure this recovers from.
+	 */
+	if ((adv & expected) == expected)
+		return;
+
+	now = jiffies;
+
+	/* Give-up is terminal for this link episode; it is re-armed only on a
+	 * real link-down (see the watchdog link-down path), i.e. when the peer
+	 * or cabling actually changes -- not on a timer, which cannot tell a
+	 * recovered switch from the same never-pause partner 60s later.
+	 */
+	if (adapter->fclatch_gave_up)
+		return;
+	if (adapter->fclatch_last_fix &&
+	    time_before(now, adapter->fclatch_last_fix + E1000E_FCLATCH_HOLDOFF))
+		return;				/* within holdoff */
+
+	if (adapter->fclatch_attempts >= E1000E_FCLATCH_MAX_ATTEMPTS) {
+		adapter->fclatch_gave_up = true;
+		e_warn("flow-control advertisement latch persists after %u autoneg-restart attempts (adv=0x%04x, requested fc=%u); giving up until the link goes down and back up\n",
+		       adapter->fclatch_attempts, adv, hw->fc.requested_mode);
+		return;
+	}
+
+	adapter->fclatch_attempts++;
+	adapter->fclatch_last_fix = now;
+	e_warn("flow-control advertisement latch detected (adv=0x%04x missing pause for requested fc=%u); forcing autoneg restart (attempt %u/%d)\n",
+	       adv, hw->fc.requested_mode, adapter->fclatch_attempts,
+	       E1000E_FCLATCH_MAX_ATTEMPTS);
+	/* Request the reset via FLAG_RESTART_NOW; the watchdog schedules
+	 * reset_task on this flag just below the call site. The flag also
+	 * tells reset_task this is intentional, suppressing its "Reset
+	 * adapter unexpectedly" warning + register dump.
+	 */
+	adapter->flags |= FLAG_RESTART_NOW;
+}
+
 static void e1000_watchdog_task(struct work_struct *work)
 {
 	struct e1000_adapter *adapter = container_of(work,
@@ -5353,6 +5469,17 @@ static void e1000_watchdog_task(struct work_struct *work)
 			netdev_info(netdev, "NIC Link is Down\n");
 			netif_carrier_off(netdev);
 			netif_stop_queue(netdev);
+
+			/* A real link-down ends the current fc-latch episode:
+			 * re-arm remediation so the next link-up (e.g. the
+			 * switch finishing its reboot) gets a fresh set of
+			 * attempts. Our own reset_task bounce does not reach
+			 * here (it goes through __E1000_DOWN/RESETTING), so
+			 * this does not defeat the per-episode attempt cap.
+			 */
+			adapter->fclatch_attempts = 0;
+			adapter->fclatch_gave_up = false;
+			adapter->fclatch_last_fix = 0;
 			if (!test_bit(__E1000_DOWN, &adapter->state))
 				mod_timer(&adapter->phy_info_timer,
 					  round_jiffies(jiffies + 2 * HZ));
@@ -5384,6 +5511,11 @@ static void e1000_watchdog_task(struct work_struct *work)
 	adapter->gotc_old = adapter->stats.gotc;
 	spin_unlock(&adapter->stats64_lock);
 
+	/* Auto-recover from a latched pause advertisement (I219/PCH,
+	 * jumbo) after an upstream switch reboot; see e1000e_check_fc_latch().
+	 */
+	e1000e_check_fc_latch(adapter);
+
 	/* If the link is lost the controller stops DMA, but
 	 * if there is queued Tx work it cannot be done.  So
 	 * reset the controller to flush the Tx packet buffers.
-- 
2.47.3

