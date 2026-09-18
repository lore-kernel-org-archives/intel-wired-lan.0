Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D663FC982D8
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Sep 2026 13:34:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7FA3360E36;
	Fri, 18 Sep 2026 13:34:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KcU4PiCiPMoA; Fri, 18 Sep 2026 13:34:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D047D60E5F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789738495;
	b=CFqUq307PPAJabvwUY+8i0lnuT0JG0YLnnYtn4O31ZPorQybwurOaVqALHSHXd8hwwz8
	 Ytige/siXWQdeJ5+uGZpaDD57LBwI2Ql165cLSZjIsSVao5qdE7guhrs/QXqMKGIbEzlu
	 z3B6KlGIt83PB7pPloXpCmLG506DDrQbkOhE0uWxClCpG5OWDmqcM9NYEyMpuBF7b4Vc4
	 hnGLXg4eKGopYB4xZO/6hMbhUy8CnVXwZ75K+Z2iCqPbPKanKoY5iqNMhe7gGxPbce4gN
	 C3ExemAWWW1XpF5dRPAVOrZXjYQgrcUqlzU+KqaHMzg5bvW8xtKsQcrKFjF4jR+PxeA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789738495;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nDx7OrtSKls+8BEJaj8obBFGGjeWv730PiUSYwuc1Dc=;
	b=fZ+nq2rS8/1gm9EuhYn2CHRntLQXUpziB7Wc6zlOoHe8zlLRbH/CLis+KBKl1FL0+2wT
	 Pr8XVsKHSem2bSVmBLd0XXvMFwePGqq8kvA3ubB3TThU9CgCy3HSdm1DOeNVITc3f5vpE
	 8U3TQXHFSZPvJzjckAe7yBdM71VhFIDXVpIRBdGCKKlSarZtp6AvFb419KWeH0lO5Y/Sd
	 Pf5GLdW5flkfbOYVEOds8+aPw8Ku5gBvtpmFtPz7aEAUYrNOXtpW/eBSGrbOa5QuNop/R
	 dn0SHEhONVB13oF7TAcnnD4xA+bhAg/9ui6+U9JBvuAfjyR5aVVsI3EUjBo8XKSFlQg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789738495;
	bh=nDx7OrtSKls+8BEJaj8obBFGGjeWv730PiUSYwuc1Dc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aLdMLQE5G4pg5gRrL4Nwc6EBk393DfpCl9aGUnUB5DBl/DJ/OQfQ4iNu2H4FCgVaq
	 9zeO6Mo1WMF+yTenfZgvCUOOb5tfmM1NCnnNqto+XiYjDlBLiLZKfjwW40AWbGqlDR
	 2JaTBF9QhLS6wZSUEQOyqR1lHQlEq1xpy7Wu1LUsBi2Ddh61ThUQWj6lW64q7m8BFo
	 0t4Y8kaCalHyUWQqgb3GratpVz0a6SAJLakxV3weWsFjxD0S1pkk4Cca2BQKMFj5mO
	 FMXgpHPXhEf4O8SWKSbPfk9K4kjagw3rRSmnVH9MqjwOcO2k5x8JKxnNhsfvniqZJ2
	 wQuBUdXnZwNCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D047D60E5F;
	Fri, 18 Sep 2026 13:34:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B824279
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:34:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3934E40D59
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:34:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WQPqyb66hSku for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Sep 2026 13:34:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 84F1840D43
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=192.198.163.5
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789738493;
 b=BNAVkdbi7KnQdskJx4Z2OwWI5J3Gg2xO1Q6X7rakyfqit4623gsQOLVDx8bkC+olVsTw
 VwvVmCOtdxn0UOyfDTIgZUqf41kdln2omgKc6tq3sJJzc+MvE/TTK0tGsrHaaMRMkONrZ
 3bzY4KC+bQdjRibT1eu4fMmAMRL8nfruiUsHBBtadJCiBKC3foOJIBeE8qrcNXMNNPb7F
 XKelBs5U9yRhiClQM5N721qdNpvnu2d1Ll/VgUmcuGiSPNRTgeIKQOG4J/2/iAMkYh+no
 26V6VglxYjjcDKj4e+mSBVCn6FPTwZOicxj/6TxKxzx4xJXhyBZieuO8qVLg7f9WI0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789738493;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=nDx7OrtSKls+8BEJaj8obBFGGjeWv730PiUSYwuc1Dc=;
 b=QN5DeiEGNUo/9Wc9m+dZ8Uxv6NEQ8CJhEAPt54LiA6R9aE/bnbUS7bkLvyP5agjcgD5r
 4bMPj2zFw5Z5tBxT2UN8iFYt5nkZZ6MybEULNuFJ7zxGHeI0o2xWkehWD+nGDrCdPzunH
 yFNyOnYvmrvRST4/BDqzrplNybNBous9U7FcJNH7JwgMgRIIsnXXotXPzcKZgwNa9jGIa
 i9ND6jR8DvmbOLYcmUjB5VnTFPt7mHw5dllc41B2kKfLEFU8YAZ9DGaCNskFE90r5z7rX
 LQNB394obKpoPjIdACWZuMaXOILH6bohupOAMhhEm12ZZoXl5tyq3mF1OoUOfVt6iFA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=jyzswVPN; 
 arc=none smtp.remote-ip=192.198.163.5
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.5;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=jyzswVPN
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 84F1840D43
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789738493; x=1821274493;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=alPd3jIpdS35on6zf2c81Y02DU9c1ZRoSXkBLUj8oEs=;
 b=jyzswVPN7EldigBsfFqrAJUZoWHjLe2/Z+qaAcEpKij9ZPQ3Bw4PyF2x
 7LvigYoCo1707ieaBofCY2zjxwdhKL1mZUEAHM5H2+juNUcrjM6gu38wd
 gonOj9utSL7x5ac8FOdZuK1ZsaoGeAh5myLYTlZYpCEmof/rBf4WHw7+G
 ESEXAgmnhzhbbVtjkOMl9rnuciUeawVah7m10ev0lnrCyg0Wt8ZN2AzFi
 nTy4i+Ooa0g7F9esQRV7P5dshKWpoZCOiTMqnU9K4RGf0N0M+fUi4esLf
 FBJFqk2M5acX5CqTGYY10UgdUxcaCLoKKRXaWxDWn1DVpENYR1IdmRlcq Q==;
X-CSE-ConnectionGUID: CghsUxHxRdqxuvej+XXO5w==
X-CSE-MsgGUID: eH5w6uGJRI6hn5PJ7B4p5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="744159"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="744159"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 06:34:53 -0700
X-CSE-ConnectionGUID: ZnUoGYpdRJiMkT+yZZOcag==
X-CSE-MsgGUID: xEebdWUVSQKoVfaV1sak/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="299513973"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa001.fm.intel.com with ESMTP; 18 Sep 2026 06:33:33 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next v2] ixgbe: remove ixgbe_ping_all_vfs() from link
 state change handlers
Date: Fri, 18 Sep 2026 15:33:27 +0200
Message-ID: <20260918133327.4170034-1-aleksandr.loktionov@intel.com>
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
Reviewed-by: Simon Horman <horms@kernel.org>
---
v1 -> v2: no code changes, resending to pick up Reviewed-by
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  6 ------
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 14 --------------
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h |  1 -
 3 files changed, 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index f918564..365acf8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8181,9 +8181,6 @@ static void ixgbe_watchdog_link_is_up(struct ixgbe_adapter *adapter)
 
 	/* update the default user priority for VFs */
 	ixgbe_update_default_up(adapter);
-
-	/* ping all the active vfs to let them know link has changed */
-	ixgbe_ping_all_vfs(adapter);
 }
 
 /**
@@ -8214,9 +8211,6 @@ static void ixgbe_watchdog_link_is_down(struct ixgbe_adapter *adapter)
 
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

