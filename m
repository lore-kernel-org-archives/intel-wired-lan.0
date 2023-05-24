Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F1DC77B73
	for <intel-wired-lan@archiver.kernel.org>; Wed, 24 May 2023 12:22:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98572611BD;
	Wed, 24 May 2023 12:22:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 98572611BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1684930975;
	bh=Ti1MjV5Y1episrUsnbiCM1IPtsPPPl6rYubEbftApSU=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=tyLE8tO5r+grUMK4vcRcLYl/KnfwmVWsfUMRULGjNTzJWeQJLPPMCFjImTybP/Z6d
	 4ijPPaDy9VVSQ7YRJ5badMcpEUXfMU6Byb2G3fMEz7KoV8S/Hl7d6JWK6Gy6m5rpjm
	 yTgu24Aph9YJSh26furrbkmD0WWmMgrx7G04/Bau5XTDRRI6yRZ+hO1HTxYi+RsJRJ
	 Vc6cn8GCLZOf/Skp7QXKLeSaKc2o3lbM77TSZxocfhLyGXWZj9dO9wWu6GKtTqa9hc
	 2BMxWIrUwzYJTE+ivoDrxMZnvWYMfq2l+xXhEgU4B4uyt/Ly0GQBqVB+NTEnb3vkbn
	 kGHkesO4oT+mA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y_o554vhIYQh; Wed, 24 May 2023 12:22:54 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73EF1611C0;
	Wed, 24 May 2023 12:22:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 73EF1611C0
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 075C11BF354
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 May 2023 12:22:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D51A841CFE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 May 2023 12:22:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D51A841CFE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mp2cifuslFIf for <intel-wired-lan@lists.osuosl.org>;
 Wed, 24 May 2023 12:22:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3781241CDE
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3781241CDE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 May 2023 12:22:38 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="417005100"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; d="scan'208";a="417005100"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2023 05:22:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="794168560"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; d="scan'208";a="794168560"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by FMSMGA003.fm.intel.com with ESMTP; 24 May 2023 05:22:35 -0700
Received: from rozewie.igk.intel.com (rozewie.igk.intel.com [10.211.8.69])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 914D93740F;
 Wed, 24 May 2023 13:22:34 +0100 (IST)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Wed, 24 May 2023 14:21:12 +0200
Message-Id: <20230524122121.15012-5-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230524122121.15012-1-wojciech.drewek@intel.com>
References: <20230524122121.15012-1-wojciech.drewek@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684930958; x=1716466958;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bi/aIplFURz3X/DSGfO6sFy6qP5TrHzx1KmxgPo49oc=;
 b=Q2cgkuZ6mmVGWJcALGM3EQl15K+YegRWoI26f66ZBdZwA8/S1hmvraUE
 rd+5uXhwXTepefH/cR5w9oLlgauYwkZJy7wlp9pNQVyqa58e8r9LasL5p
 qbQXKNujtP+GvOhp70cZyPsn1MvmYrn/gzY0ZAGu+uuxU5gUjoUAEILda
 SA+dfOJ95KzrStbg4Mjq5h/tvHe7kDctaKQ2TXEF42yAOQSZ7i32wGcme
 S1c9a1WCZciaLRenxBesdkg/J19GfDU21aWVB0S9AWX7cLMLrCrUCFCeo
 sqcv9UFNpjLkfPln1hM9IJPvHeAnD5EPpq4j8xUY6o9ft6qeD5PJ/0RCj
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Q2cgkuZ6
Subject: [Intel-wired-lan] [PATCH iwl-next v4 04/13] ice: Disable vlan
 pruning for uplink VSI
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: pmenzel@molgen.mpg.de, netdev@vger.kernel.org, simon.horman@corigine.com,
 dan.carpenter@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

In switchdev mode, uplink VSI is configured to be default
VSI which means it will receive all unmatched packets.
In order to receive vlan packets we need to disable vlan pruning
as well. This is done by dis_rx_filtering vlan op.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 15a4c148c28b..bfd003135fc8 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -103,6 +103,10 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
 		rule_added = true;
 	}
 
+	vlan_ops = ice_get_compat_vsi_vlan_ops(uplink_vsi);
+	if (vlan_ops->dis_rx_filtering(uplink_vsi))
+		goto err_dis_rx;
+
 	if (ice_vsi_update_security(uplink_vsi, ice_vsi_ctx_set_allow_override))
 		goto err_override_uplink;
 
@@ -114,6 +118,8 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
 err_override_control:
 	ice_vsi_update_security(uplink_vsi, ice_vsi_ctx_clear_allow_override);
 err_override_uplink:
+	vlan_ops->ena_rx_filtering(uplink_vsi);
+err_dis_rx:
 	if (rule_added)
 		ice_clear_dflt_vsi(uplink_vsi);
 err_def_rx:
@@ -381,9 +387,13 @@ static void ice_eswitch_release_env(struct ice_pf *pf)
 {
 	struct ice_vsi *uplink_vsi = pf->switchdev.uplink_vsi;
 	struct ice_vsi *ctrl_vsi = pf->switchdev.control_vsi;
+	struct ice_vsi_vlan_ops *vlan_ops;
+
+	vlan_ops = ice_get_compat_vsi_vlan_ops(uplink_vsi);
 
 	ice_vsi_update_security(ctrl_vsi, ice_vsi_ctx_clear_allow_override);
 	ice_vsi_update_security(uplink_vsi, ice_vsi_ctx_clear_allow_override);
+	vlan_ops->ena_rx_filtering(uplink_vsi);
 	ice_clear_dflt_vsi(uplink_vsi);
 	ice_fltr_add_mac_and_broadcast(uplink_vsi,
 				       uplink_vsi->port_info->mac.perm_addr,
-- 
2.40.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
