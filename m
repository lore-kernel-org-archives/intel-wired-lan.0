Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4DAD730A7
	for <intel-wired-lan@archiver.kernel.org>; Fri,  3 Apr 2026 05:59:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5865040DA6;
	Fri,  3 Apr 2026 05:59:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mr0gf66lDzHP; Fri,  3 Apr 2026 05:59:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C716B40E0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775195949;
	bh=tJmZQn4lwZZ2ESdbtMM0xOs761nklvQXY4o2WVIu1P0=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zUmn3vbmv8b6soU/P6bKC8SHSE5nfPGOSKHI9uQLowB/9xNnkqjgIniXD3seccgnu
	 bdHjq0Qy9HXO/EcuaxJyuivlRlgZWjdi1X1xuus4E1NkL+hMtXxkLEbSaj7xdiIw/C
	 qlqYsVNI2a9PMA7MRcPlFl6n4FUaCdGAVqe2qQ3Iw7j5rD/+nlGXfgD5gWZsqJ7551
	 Vqow4iehkfEyHGVpN7PB5RMEZhgao2JOANCpytGNj22gSLQUDqKqEleYKU166w7YQI
	 V4INNEPVILOHtgnfNWkaPd0uy85g0w2HWJVXgAQM+1wzY+QGTyGRR9L9gSHfGviNz+
	 DgWkyINJRcAgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C716B40E0C;
	Fri,  3 Apr 2026 05:59:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D98F41F3
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 05:59:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B97F940E0C
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 05:59:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xNMBdodC-Jwp for <intel-wired-lan@lists.osuosl.org>;
 Fri,  3 Apr 2026 05:59:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C42B340DA6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C42B340DA6
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C42B340DA6
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 05:59:07 +0000 (UTC)
X-CSE-ConnectionGUID: Rn01+92LSKGpGV+ILW9pWg==
X-CSE-MsgGUID: S7lFV9xsQt2rPFREpua8jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="86964800"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="86964800"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 22:59:06 -0700
X-CSE-ConnectionGUID: 59TdPBPNQkGF9nI7N6QLsA==
X-CSE-MsgGUID: y+8mW7HARyW9Tog33RWInw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="250252556"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa002.fm.intel.com with ESMTP; 02 Apr 2026 22:59:05 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Anton Loktion <aloktion@cisco.com>
Date: Fri,  3 Apr 2026 07:59:04 +0200
Message-ID: <20260403055904.3800150-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775195948; x=1806731948;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=DRP+DtgotH+uHkIjI5tTy7Oo1rAFm5KnpRPZroqjVLs=;
 b=S18LUnFJZJKiJXEYRR7ceVt9+zO9LHHw74mQiZz58Rr1LMsnsplW2zSX
 OFuZBQAkqyE0c0S70wVkSa8VPdFI6rmekIXA3jb0MLLBkP0TyEn8sndtS
 TV/k0IBgkng+iWGaBkWk6UDI/lGLmjAcgN7TuL70gcU8xneIYSAgTLUzz
 kXqTCuJLFsMn8mCdfHdzeMo9Teo1+jLk/JTbrOkRpALSqsSGNRnAnS1SZ
 U143bMryZ3lNpA5YKkPwyhy3C7zvqZQ9DF2U85XijlHwBteEkEdliHyJU
 M3TzVoaX+tYdGmT4v5A5ZeHO9xW+XdsjN4N2sDZv2a8p8LhEWMvUL1L0b
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=S18LUnFJ
Subject: [Intel-wired-lan] [PATCH iwl-net] ice: fix netdev allocation with
 max queues instead of default
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

From: Anton Loktion <aloktion@cisco.com>

Commit ee13aa1a2c5a ("ice: use netif_get_num_default_rss_queues()")
changed the default queue count from num_online_cpus() to
netif_get_num_default_rss_queues() which returns roughly half the CPU
count.  ice_cfg_netdev() passes vsi->alloc_txq and vsi->alloc_rxq to
alloc_etherdev_mqs(), so after that commit the netdevice is created with
only ~half the CPU count of Tx/Rx queues (dev->num_tx_queues).  However
ice_get_channels() still reports the old maximum (num_online_cpus()),
and ice_set_channels() accepts requests up to that limit.  When ethtool
 -L sets combined to the maximum, rings are assigned q_index values up to
num_online_cpus()-1, which exceed dev->num_tx_queues:

  # ethtool -L eth0 combined 96

  ice 0000:18:00.0: Failed to allocate 96 q_vectors for VSI 12, new value 49
  WARNING: CPU: 25 PID: 4484 at net/core/dev.c:2853 __netif_set_xps_queue+0x835/0x9a0
  [...]
  Call Trace:
   <TASK>
   netif_set_xps_queue+0x82/0xc0
   ice_vsi_cfg_txq+0x124/0x440 [ice]
   ice_vsi_cfg_lan_txqs+0x53/0x90 [ice]
   ice_vsi_cfg_lan+0x40/0x190 [ice]
   ice_vsi_open+0x2b/0x120 [ice]
   ice_vsi_recfg_qs+0x94/0x120 [ice]
   ice_set_channels+0x261/0x370 [ice]
   [...]

SUT: Intel S2600WFT, 96 CPUs (Xeon Platinum 8260), E810-C for QSFP

Reproduce:
  ethtool -L <iface> combined $(nproc)

Use min(num_online_cpus(), hw queue cap) for alloc_etherdev_mqs() to
size the netdevice for the actual maximum queue count, matching what
ice_get_channels() reports through ethtool.

Fixes: ee13aa1a2c5a ("ice: use netif_get_num_default_rss_queues()")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 4da37ca..5c21c2a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4699,8 +4699,11 @@ static int ice_cfg_netdev(struct ice_vsi *vsi)
 	struct net_device *netdev;
 	u8 mac_addr[ETH_ALEN];
 
-	netdev = alloc_etherdev_mqs(sizeof(*np), vsi->alloc_txq,
-				    vsi->alloc_rxq);
+	netdev = alloc_etherdev_mqs(sizeof(*np),
+				    min_t(int, num_online_cpus(),
+					   vsi->back->hw.func_caps.common_cap.num_txq),
+				    min_t(int, num_online_cpus(),
+					   vsi->back->hw.func_caps.common_cap.num_rxq));
 	if (!netdev)
 		return -ENOMEM;
 
-- 
2.43.0
