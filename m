Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F34C88E75
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 12:55:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3524940642;
	Tue, 15 Sep 2026 12:55:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6pvWY0Pqy_tX; Tue, 15 Sep 2026 12:55:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 82E8C40656
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789476952;
	b=j9wv9GanmdT5nQeuMDMG3I6vwSPNMvJxnMHKQhUBU9nG2TkFUwfuAq4JHUD9w+8NVrwp
	 fOujWxCQZ0z3nj3d+7GoYM48uK7L9+kRiT2MM51YfGIyLg9RseoLLfnDY7NqcmAkacqe0
	 tsXvuCVpxNLoB+6nxNjwuWQtGu9Celo50AC83Q3pOfUuCR5yrBlCpgFw948XxMdPsn4E5
	 e6gTK74U1Zbn+1+Rn4NYeqhGYIn8HhqfYEOJhe1a5G7OBxNKXmP+drDEwnsRZcIa5ZJha
	 NBomV1mQf8CTmIcGepwV+mvDsBGTZKLvBF5ktpblq+3OxLtw7AahgQZaRC99D/PmG9A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789476952;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ynd74VaoML5Z6XxaL6U8qPg3TD/Yoc/jPK5zPPTKJyI=;
	b=sNKtRTmLe039qi5Kl+yG5UcrTDfc1bEqR0MD+mSMpvey6XT+0T4QU4Worb3i0RX6vMHq
	 x7VcsBUjX6OT3OYAThw+Ca7a6ZgW6U6BwP5KGbS8mIwyB7mV4csukVgoq78M+63Icirpi
	 RWA2Yquk69V9gBJ27WpGkt9mbl/Q/91pseGX2YUPWHENkOrxeKF+2yKJmMs18563CTCYG
	 GtaA1tcXnrdbsCGOAKoOKfXoq3BmoV4wlcTEys0KAgJHrrfBM9lEthOgaiDz4fwu7RtmN
	 RacQDfLehH8Ke6fPOPPusepWDPpK2dJqFpXuY2K6ZHjW2nw+njHjFUbb/YE9McT4wEw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LIdNlSF9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789476952;
	bh=ynd74VaoML5Z6XxaL6U8qPg3TD/Yoc/jPK5zPPTKJyI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zdPxA8zW4XsgwjNpnD2RHX7dp/pj8Xsv0pCX80sX9m1xpIFpCU7QQ4hP9y2Vmy6OS
	 CWuC958pJCCcpkWB3aFfyUPp5bUTP4Rit+ithMSsHC5EELYTB9BsARLabt1djxvAao
	 CuplJWsiMkARxadKeDPWowbyXoWJfb1Opl9+NnnjcnG9VPYmW23JWqnCAq7ZqE7Kkm
	 F/lkLnTGbdunxHZFfgDSU/tvUfLmS45sMoZeep0MOothU8G1mBOhHjv2TMTRi91w/V
	 5/TfgcMLU9HTNMu55x8HSkwGYvrZeDltP+g1jRkyY536PQHZqWv4KV2hMBIRaapEfr
	 xIXL6n6vUUAZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 82E8C40656;
	Tue, 15 Sep 2026 12:55:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 81A81259
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7F37F40656
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8v4TEFBwJT0i for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 12:55:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C618140642
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789476950;
 b=EL3ryD6jI3zgfmGy6RdJZUCeiygDtDAcNlqxo0HeoTENbnQ/PrglopOux/itzAAzp+4J
 fQp9CpFnb3PBDRHujrwkGBc8lNpxbE2u6ZpSSvMJufYehdGzmrJ/jYnyqBolm5c+bQHnc
 6ZltayIkhhLfPMSHySbSQaO2/8vJEcPwKaQOwO2JmW1/HT/ZRw/By0iUxGd/SemO5aQyI
 XNcV7MJ+QbIkCKVbgYqW5VCeD1D0umfJarMhYZijS8hiiiCFX+3Wil/7CpSnwxcxTDR6O
 GicDQGXn2VPc4o16/wpFIOL2AQ6/umqvx0aZC1mAPfTLutFw7Cx+0wnMy9E9zU2vUWg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789476950;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:Received:From:To:Cc:Subject:Date:Message-ID:
 X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=ynd74VaoML5Z6XxaL6U8qPg3TD/Yoc/jPK5zPPTKJyI=;
 b=GsTIqo5EBGf0j2OSxFD114boNdNF1cHbL4hl/dPNSWns1dtVeBOWj8v/DoeB+QxJ8pl+
 0TS5a25kxGRpXN3tTB2rDODSuUbo12mfuT1LnRXhl/eM1tjhnJR7zNcUhR8jn3VfiMaAn
 xu7gtPf+FJY2JBksjtEazIM2kRSNej93TfQSlWzTDWqivZgQWJbKLmvwP+Jl4FIwPuoAC
 p/6rS2j5PP6yKByHOYcTg4+/lmmgWnj5OV+m9Nx3/+vKzOdSbgAEHAuKTfVWNb/ffZJjd
 0YYZzBqoy6N3wusQzd4kJApImOXj+aGHLF3JWNaN34/FT53jJY8ZEvfgyZ3dMaC1HGQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=LIdNlSF9; 
 arc=none smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=LIdNlSF9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C618140642
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789476951; x=1821012951;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=rK6IW2BjueDdcIhIO7EvEeSjm2GmE/765EP6oWxFOAU=;
 b=LIdNlSF9UKcL/vONJT3iOe/qfyEFDgouZthK1YQO8XrcZcddbpc8xrfD
 jrd+6w3AA+n7rtamXZPCPpg6zSYGK9s6/Cf668ildBQ52MiQyUTXTkE4u
 IDn/zK4xXy9M6mYuER/emdDDdIzoaalQQPLUUoNBTw9HVKb5dtbVybl94
 24HIymWaOPRlE7cxNcyaN2vPlVLX2eULfECxWVTeEqaz3H7pCo+VfaDe8
 DzIusoFINNIl5XdDPaG32SeV78oPnjuSnwmoMc443/qQjG0Z8jJmTOSKZ
 /uDXcpaErrrvyHRWnPxpLnBZRD/LaZo49ap+DCQsB/W/j13e2Zxwn0dRq Q==;
X-CSE-ConnectionGUID: piRAneTRRCSEgDuL6YXIDA==
X-CSE-MsgGUID: NjUGzgMTSWOTSv9h1XxszQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112607054"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="112607054"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 05:55:50 -0700
X-CSE-ConnectionGUID: lzVVUaZjRu+Q88XlpnHlSQ==
X-CSE-MsgGUID: gItMP/fSQ3eQOgq1WniuZg==
X-ExtLoop1: 1
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa003.fm.intel.com with ESMTP; 15 Sep 2026 05:55:48 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next] ixgbe: remove ixgbe_ping_all_vfs() from link state
 change handlers
Date: Tue, 15 Sep 2026 14:55:47 +0200
Message-ID: <20260915125547.3975992-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
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

When multiple VFs are brought up simultaneously, a VF can receive a CTS
(Clear To Send) mailbox message instead of the expected RESET | (N)ACK
response, because the watchdog fires a gratuitous ping right as the VF
mailbox transaction is in progress.

Remove the ixgbe_ping_all_vfs() call from both ixgbe_watchdog_link_is_up()
and ixgbe_watchdog_link_is_down().  Both paths contain an identical call
with the same race window during VF initialization: link-state changes
(up or down) can arrive while VFs are mid-initialization, and the
gratuitous ping from either direction collides with the VF mailbox state
machine for the same reason.

Link-state changes are already communicated to VFs through the normal
mailbox protocol; these extra pings are redundant on both paths.

This removes the last two callers of ixgbe_ping_all_vfs(), so remove
the now-unused function and its declaration as well.

Suggested-by: Sebastian Basierski <sebastianx.basierski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  6 ------
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 14 --------------
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h |  1 -
 3 files changed, 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 8d3627c..d816aa1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8195,9 +8195,6 @@ static void ixgbe_watchdog_link_is_up(struct ixgbe_adapter *adapter)
 
 	/* update the default user priority for VFs */
 	ixgbe_update_default_up(adapter);
-
-	/* ping all the active vfs to let them know link has changed */
-	ixgbe_ping_all_vfs(adapter);
 }
 
 /**
@@ -8228,9 +8225,6 @@ static void ixgbe_watchdog_link_is_down(struct ixgbe_adapter *adapter)
 
 	e_info(drv, "NIC Link is Down\n");
 	netif_carrier_off(netdev);
-
-	/* ping all the active vfs to let them know link has changed */
-	ixgbe_ping_all_vfs(adapter);
 }
 
 static bool ixgbe_ring_tx_pending(struct ixgbe_adapter *adapter)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 431d77d..da641e9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -1515,20 +1515,6 @@ static inline void ixgbe_ping_vf(struct ixgbe_adapter *adapter, int vf)
 	ixgbe_write_mbx(hw, &ping, 1, vf);
 }
 
-void ixgbe_ping_all_vfs(struct ixgbe_adapter *adapter)
-{
-	struct ixgbe_hw *hw = &adapter->hw;
-	u32 ping;
-	int i;
-
-	for (i = 0 ; i < adapter->num_vfs; i++) {
-		ping = IXGBE_PF_CONTROL_MSG;
-		if (adapter->vfinfo[i].clear_to_send)
-			ping |= IXGBE_VT_MSGTYPE_CTS;
-		ixgbe_write_mbx(hw, &ping, 1, i);
-	}
-}
-
 /**
  * ixgbe_set_all_vfs - update vfs queues
  * @adapter: Pointer to adapter struct
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h
index bc4cab9..f755bfd 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h
@@ -18,7 +18,6 @@ void ixgbe_restore_vf_multicasts(struct ixgbe_adapter *adapter);
 bool ixgbe_check_mdd_event(struct ixgbe_adapter *adapter);
 void ixgbe_msg_task(struct ixgbe_adapter *adapter);
 int ixgbe_vf_configuration(struct pci_dev *pdev, unsigned int event_mask);
-void ixgbe_ping_all_vfs(struct ixgbe_adapter *adapter);
 void ixgbe_set_all_vfs(struct ixgbe_adapter *adapter);
 int ixgbe_ndo_set_vf_mac(struct net_device *netdev, int queue, u8 *mac);
 int ixgbe_ndo_set_vf_vlan(struct net_device *netdev, int queue, u16 vlan,
-- 
2.52.0

