Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1D6C44539
	for <intel-wired-lan@archiver.kernel.org>; Wed, 22 Jul 2026 12:25:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CBD2380F0E;
	Wed, 22 Jul 2026 12:25:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XHrqfOyuQ6lm; Wed, 22 Jul 2026 12:25:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0C47B80EFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784723112;
	bh=E6TBPLWi/OXikWmpCVf5oWA5cfb2MkHuD3KjEkTtkYY=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tS7HpY35oqgScklxH7kLaJaI5KfvGCXAEeLCiH4kj0csMemCVOsmLbxnQFstH56f4
	 rk09QFRFKJqS7Ypifpo+AJ+pAtxCbxyqPyj7//iBO3fDkB2Wc2vnqg4D1jsWj5Smux
	 UjQuQ8N6naDUt0Ln8OuEu1XnPrn6n5C7aDfjSYON9vI4aGwPGWoxWe1+a7AddupOgZ
	 Q4d9Z8UsMBWdugDAIbWNDkGT936YDYHhF07o6EO3Snymbs0Ty4ysEJqod/Ub2q15ub
	 asybGdmw0VRWrdTxMxkQoCFnz6TGY3aMOp/c0nwt3j/7rxjnaC00SkvGkZmnx77XS4
	 8NLZ/jaLy3UNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C47B80EFE;
	Wed, 22 Jul 2026 12:25:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9483D224
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Jul 2026 12:25:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 83C43607C5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Jul 2026 12:25:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xGE0vVwCYwAa for <intel-wired-lan@lists.osuosl.org>;
 Wed, 22 Jul 2026 12:25:09 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=lukasz.czapnik@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8D094606A8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8D094606A8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8D094606A8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Jul 2026 12:25:09 +0000 (UTC)
X-CSE-ConnectionGUID: /m5honJERYm6Kn0sHKD78A==
X-CSE-MsgGUID: ktwMpxlFRo+alB2rgjMBRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="72899665"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; d="scan'208";a="72899665"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 05:25:09 -0700
X-CSE-ConnectionGUID: YisQHugUQfKRHitPKF1K+w==
X-CSE-MsgGUID: xPJzSEheTuiPyqiDI324CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; d="scan'208";a="253716935"
Received: from os-delivery.igk.intel.com ([10.123.220.24])
 by fmviesa006.fm.intel.com with ESMTP; 22 Jul 2026 05:25:08 -0700
From: Lukasz Czapnik <lukasz.czapnik@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Jakub Kaminski <jakub.kaminski@intel.com>,
 Lukasz Czapnik <lukasz.czapnik@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Tomasz Lichwala <tomasz.lichwala@intel.com>
Date: Wed, 22 Jul 2026 14:24:48 +0200
Message-ID: <20260722122448.2286008-1-lukasz.czapnik@intel.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784723109; x=1816259109;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=eUvzvKjnwhdV/VYZblJlJMHe8fUdWz5zwlhFuJdsWbk=;
 b=NiJQA7c3UhZOOL+sQtxFL44Rb7r8HjFI1OuIEtW3nT6DoIgMMec+QguL
 mVD1dYJrgctP40R5k2kaBjSgRI6etJ02K1yETfrOMCLWhuzgzoFMyLTjy
 Jwmuh4u7x5Vrgb2eRZrXkck/+rAngeWZVKNxPBU+1/9zFhsLaVWUQHz14
 oplA6e7bbN4Yv9RCodgKKcbcDKO3W3jaTG4rKhkQNG0TBecunoe00cON3
 Ce+h8/7w868VRUFsFyVYpLb7HiHCh5Z+OCgsgA6uP2NG1facbuhGLbtVj
 sfHmV+SNGFI77I+9OVnj4KJHElP9QlELvfpWDhZGMiIVUsoXQ+iw2LOuc
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=NiJQA7c3
Subject: [Intel-wired-lan] [PATCH iwl-net] ice: Fix "Unknown bps" during
 link events
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

From: Jakub Kaminski <jakub.kaminski@intel.com>

The driver may display "NIC Link is up Unknown bps" messages during
link state changes. This occurs when link status and link speed are
read from different points in time.

The driver processes link events by receiving an asynchronous ARQ event
from firmware containing link_up and link_speed values, then performing
a synchronous AQ query via ice_update_link_info() which overwrites the
phy.link_info structure, and finally calling ice_link_event() with a
link_speed parameter while ice_print_link_msg() read link_speed from
phy.link_info directly.

ice_print_link_msg() always read link_speed from the phy.link_info
structure. This caused link status from the ARQ event to be combined
with link_speed from the later AQ query, mixing information from two
different points in time. When firmware state changed between these
moments, inconsistent messages like "Link is up Unknown bps" appeared.

Add a link_speed parameter to ice_print_link_msg() to ensure link
status and speed are always taken from the same source and point in
time.

Fixes: c2a23e00613b ("ice: Refactor link event flow")
Signed-off-by: Jakub Kaminski <jakub.kaminski@intel.com>
Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Tomasz Lichwala <tomasz.lichwala@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |  2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_main.c    | 14 +++++++++-----
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index da679793b397..567058c28907 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -1006,7 +1006,7 @@ int ice_get_rss_key(struct ice_vsi *vsi, u8 *seed);
 int ice_set_rss_hfunc(struct ice_vsi *vsi, u8 hfunc);
 void ice_fill_rss_lut(u8 *lut, u16 rss_table_size, u16 rss_size);
 int ice_schedule_reset(struct ice_pf *pf, enum ice_reset_req reset);
-void ice_print_link_msg(struct ice_vsi *vsi, bool isup);
+void ice_print_link_msg(struct ice_vsi *vsi, bool isup, u16 link_speed);
 int ice_plug_aux_dev(struct ice_pf *pf);
 void ice_unplug_aux_dev(struct ice_pf *pf);
 void ice_rdma_finalize_setup(struct ice_pf *pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 9ddd7e82a300..c37b72763ce5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2814,7 +2814,7 @@ ice_set_link_ksettings(struct net_device *netdev,
 		/* Tell the OS link is going down, the link will go
 		 * back up when fw says it is ready asynchronously
 		 */
-		ice_print_link_msg(np->vsi, false);
+		ice_print_link_msg(np->vsi, false, 0);
 		netif_carrier_off(netdev);
 		netif_tx_stop_all_queues(netdev);
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 968a8e18d197..2ab5e2800c30 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -835,8 +835,9 @@ static void ice_print_topo_conflict(struct ice_vsi *vsi)
  * ice_print_link_msg - print link up or down message
  * @vsi: the VSI whose link status is being queried
  * @isup: boolean for if the link is now up or down
+ * @link_speed: current link speed value to display
  */
-void ice_print_link_msg(struct ice_vsi *vsi, bool isup)
+void ice_print_link_msg(struct ice_vsi *vsi, bool isup, u16 link_speed)
 {
 	struct ice_aqc_get_phy_caps_data *caps;
 	const char *an_advertised;
@@ -860,7 +861,7 @@ void ice_print_link_msg(struct ice_vsi *vsi, bool isup)
 		return;
 	}
 
-	switch (vsi->port_info->phy.link_info.link_speed) {
+	switch (link_speed) {
 	case ICE_AQ_LINK_SPEED_200GB:
 		speed = "200 G";
 		break;
@@ -1193,8 +1194,10 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
 	/* Check if the link state is up after updating link info, and treat
 	 * this event as an UP event since the link is actually UP now.
 	 */
-	if (phy_info->link_info.link_info & ICE_AQ_LINK_UP)
+	if (phy_info->link_info.link_info & ICE_AQ_LINK_UP) {
 		link_up = true;
+		link_speed = phy_info->link_info.link_speed;
+	}
 
 	vsi = ice_get_main_vsi(pf);
 	if (!vsi || !vsi->port_info)
@@ -1224,7 +1227,7 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
 			ice_set_dflt_mib(pf);
 	}
 	ice_vsi_link_event(vsi, link_up);
-	ice_print_link_msg(vsi, link_up);
+	ice_print_link_msg(vsi, link_up, link_speed);
 
 	ice_vc_notify_link_state(pf);
 
@@ -6922,7 +6925,8 @@ static int ice_up_complete(struct ice_vsi *vsi)
 	    (vsi->port_info->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
 	    ((vsi->netdev && (vsi->type == ICE_VSI_PF ||
 			      vsi->type == ICE_VSI_SF)))) {
-		ice_print_link_msg(vsi, true);
+		ice_print_link_msg(vsi, true,
+				   vsi->port_info->phy.link_info.link_speed);
 		netif_tx_start_all_queues(vsi->netdev);
 		netif_carrier_on(vsi->netdev);
 		ice_ptp_link_change(pf, true);
-- 
2.50.1

