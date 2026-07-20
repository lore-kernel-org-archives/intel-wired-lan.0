Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0805FC44515
	for <intel-wired-lan@archiver.kernel.org>; Mon, 20 Jul 2026 12:00:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BAAB0606AF;
	Mon, 20 Jul 2026 12:00:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KAxw1TlrPEnO; Mon, 20 Jul 2026 12:00:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D9419606A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784548810;
	bh=kYxtJXqcbnyALE5IxjhIj2KVQ1zoFQJebt2eQDiq7eI=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qt99T4EOfLmfKx9nEdQu3XuSN66hf0OhBdH/jCq9f38DmOOja20T3k1dusP+qUowy
	 kCSdmPyRqOiXDM2lPTL2XDCvhidQJbBkJJlpViDVoVJFp9a5zDvMCEYTnlEwvclGGP
	 u0cbFI9ubQxhb8Llb6UUOQUzC5p9q5MakO9mavQNdkAHTdap5zi/SIiHKhg7MLGCpO
	 pBCyZrvFny5YMY94nmhmrtKlTwUgC+Vt6aywdI1Z2sTO2vobiSZVCV/3NG+quo7qtO
	 MTa0mFQpA8qXfPnlrqk2LA/NsNrJiruusJNClew4yeXiie+vvJfgHjR3LRcWex0qrh
	 tX+k0zi89CMvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9419606A2;
	Mon, 20 Jul 2026 12:00:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EFD271F6
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 12:00:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D5DA6606B0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 12:00:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9wJWRGEiTmbH for <intel-wired-lan@lists.osuosl.org>;
 Mon, 20 Jul 2026 12:00:03 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=przemyslaw.korba@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C1E6D60615
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C1E6D60615
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C1E6D60615
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 12:00:03 +0000 (UTC)
X-CSE-ConnectionGUID: lXppzmAERKu3eREivYRqPA==
X-CSE-MsgGUID: TsbN7w38Rwm0+oUhbme7BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85328189"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="85328189"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 05:00:03 -0700
X-CSE-ConnectionGUID: LgEQ3Vg/RmmkvvDoMkA82Q==
X-CSE-MsgGUID: 4Ics+//bQm6cueBvjqu1HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="258078470"
Received: from pae-d-dell-r7525-263.igk.intel.com ([172.28.191.240])
 by orviesa009.jf.intel.com with ESMTP; 20 Jul 2026 05:00:01 -0700
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, aleksandr.loktionov@intel.com,
 arkadiusz.kubalewski@intel.com, konstantin.ilichev@intel.com,
 Przemyslaw Korba <przemyslaw.korba@intel.com>
Date: Mon, 20 Jul 2026 14:01:32 +0200
Message-ID: <20260720120151.2675206-5-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720120151.2675206-1-przemyslaw.korba@intel.com>
References: <20260720120151.2675206-1-przemyslaw.korba@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784548804; x=1816084804;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Bm2bnkwbJy4SEVrbW0k0DUHwjJ9/HjuiKidzf198ddc=;
 b=eVhh+948sWxufK8RZAFh0sydd2u13bqjpvGUP+giaRbEXIdZ8fxni17X
 pw1QJ+dWDwc9f+1O7nB/6sk6CxsRk0zdzMwN3Qh7gT8Supg/NXUNn2u4D
 HTJSq2/5XY3ClQdzQdhuIXnlktdpAAW0uc7MY0CPnaJXZmkeBwSeOz6gX
 cGVkZXrHDUoPKsBaVy/EA8IJAyITc9MtizaZt+hqSXRyA+46NQnPsQ10g
 aBxa3m3YLYl/QSt5mGoFTZHPf1yeyVC1Zq0YnC0fBKmZ+JkN64xtWlCMm
 6HeaUksRiMy6s0VMdfz8e+wvGbwhPsFa0U/1VIPRRQp1mW9lOAebn7lDy
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=eVhh+948
Subject: [Intel-wired-lan] [PATCH iwl-net 4/4] ice: call PTP link change
 only from link events
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

From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Remove redundant ice_ptp_link_change() calls from ice_up_complete() and
ice_down(). These duplicate the call already made from
ice_handle_link_event(), creating three problems:

1. Double initialization on link-up: ice_handle_link_event() calls
   ice_ptp_link_change(true), then ice_up_complete() calls it again.
   The second call re-enters ice_ptp_port_phy_restart(), re-setting the
   calibrating flag and restarting the PHY timer while the first
   invocation's offset verification work (ov_work) may still be running.

2. Premature cleanup on administrative down: ice_down() calls
   ice_ptp_link_change(false) during ifconfig down or reset preparation,
   even when the physical link is still up. This clears timestamp state
   unnecessarily and can interfere with ongoing PTP operations.

3. Ordering dependency: ice_down()/ice_up_complete() are called during
   reset sequences where PTP may not be fully initialized, creating
   edge cases with partially configured state.

The link event handler is the correct and sufficient place to drive PTP
link state changes, as it reflects actual physical link transitions.

Add the link_up to be set within ice_ptp_init(..), it is required to
have actual state of link_up flag on driver load.

Fixes: 6b1ff5d39228 ("ice: always call ice_ptp_link_change and make it void")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c |  2 --
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 39 +++++++++++++++++++----
 2 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 231d533309cb..8c25c1604949 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6782,7 +6782,6 @@ static int ice_up_complete(struct ice_vsi *vsi)
 		ice_print_link_msg(vsi, true);
 		netif_tx_start_all_queues(vsi->netdev);
 		netif_carrier_on(vsi->netdev);
-		ice_ptp_link_change(pf, true);
 	}
 
 	/* Perform an initial read of the statistics registers now to
@@ -7310,7 +7309,6 @@ int ice_down(struct ice_vsi *vsi)
 
 	if (vsi->netdev) {
 		vlan_err = ice_vsi_del_vlan_zero(vsi);
-		ice_ptp_link_change(vsi->back, false);
 		netif_carrier_off(vsi->netdev);
 		netif_tx_disable(vsi->netdev);
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index e0be88024ac3..e1c8bc5fafc1 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3343,9 +3343,13 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
 }
 
 /**
- * ice_ptp_init_work - Initialize PTP work threads
+ * ice_ptp_init_work - Initialize the PTP kworker
  * @pf: Board private structure
  * @ptp: PF PTP structure
+ *
+ * Allocate the kworker and initialize the periodic work function. The
+ * periodic work is not queued here; the caller starts it once the PTP
+ * state is ICE_PTP_READY.
  */
 static int ice_ptp_init_work(struct ice_pf *pf, struct ice_ptp *ptp)
 {
@@ -3364,9 +3368,6 @@ static int ice_ptp_init_work(struct ice_pf *pf, struct ice_ptp *ptp)
 
 	ptp->kworker = kworker;
 
-	/* Start periodic work going */
-	kthread_queue_delayed_work(ptp->kworker, &ptp->work, 0);
-
 	return 0;
 }
 
@@ -3489,6 +3490,29 @@ void ice_ptp_init(struct ice_pf *pf)
 	if (err)
 		goto err_clean_pf;
 
+	/* Seed the cached PTP link state from the current PHY link status
+	 * before starting the PHY timestamping block. On a fresh load the
+	 * port structure is zeroed (link_up == false); if the link is
+	 * already up at probe (for example after a PXE boot) no link-change
+	 * edge will follow, and ice_ptp_link_change() is edge-driven, so the
+	 * flag would stay stale. Seeding it here also lets
+	 * ice_ptp_reset_phy_timestamping() make the correct start/stop
+	 * decision instead of stopping the PHY timer on an already-up link.
+	 */
+	if (pf->hw.port_info)
+		ptp->port.link_up =
+			!!(pf->hw.port_info->phy.link_info.link_info &
+			ICE_AQ_LINK_UP);
+
+	/* Create the PTP kworker before (re)starting the PHY, because the
+	 * E82x restart path queues offset verification work on it, and
+	 * before ICE_PTP_READY is set, so a concurrent link event cannot
+	 * reach ice_ptp_port_phy_restart() while the kworker is still NULL.
+	 */
+	err = ice_ptp_init_work(pf, ptp);
+	if (err)
+		goto err_exit;
+
 	/* Start the PHY timestamping block */
 	ice_ptp_reset_phy_timestamping(pf);
 
@@ -3497,9 +3521,10 @@ void ice_ptp_init(struct ice_pf *pf)
 
 	ptp->state = ICE_PTP_READY;
 
-	err = ice_ptp_init_work(pf, ptp);
-	if (err)
-		goto err_exit;
+	/* Start periodic work only after the state is READY; the worker
+	 * returns without rescheduling while the state is not READY.
+	 */
+	kthread_queue_delayed_work(ptp->kworker, &ptp->work, 0);
 
 	dev_info(ice_pf_to_dev(pf), "PTP init successful\n");
 	return;
-- 
2.43.0

