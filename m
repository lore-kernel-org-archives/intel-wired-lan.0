Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1554AC07545
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Oct 2023 11:35:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3F12401D3;
	Tue, 24 Oct 2023 11:35:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C3F12401D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1698147302;
	bh=WbZtMK01R3wMPUjQ1cwZokpNTmR+bKh/zIn3aM1A4Fs=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=8Cwl8JmVSgJ13RNaZPqCRwzJqu4hDStmy5nP4E0XIUbew/2DXl8K9OBKPIzuHAoet
	 Yjm3/fWoKD41ItvLMbDcaqp6O+/woXDLTThUUYNLYa96/oUGUSEWQ4XMvAO4YPJISD
	 95R3Nkvsy2+EUrD8K0yp6mhMaK0l9Y0gruxLZL9yYQu1n+DcKv2gIY3xY6efZ3jRAO
	 73jp40wIwLQGKQsn1PLzV5Jty5UCj0sGFWJqexMwdjeUHrdLKSYdwaoL9ULOrDTU4n
	 /fp+8IJ6jOABxuoiwx8O5IGYrl1RbrBhi+zoXDcnlu2jfpXRbcMe/fRM4eoQhEU25o
	 wohwiBrUtXSzw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YmVFPfhS57Yf; Tue, 24 Oct 2023 11:35:02 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id B97F3417A4;
	Tue, 24 Oct 2023 11:35:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B97F3417A4
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 7BB621BF311
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Oct 2023 11:34:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 51F4D42ECD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Oct 2023 11:34:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 51F4D42ECD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WDPPTqKap-tD for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Oct 2023 11:34:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 50D114054E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Oct 2023 11:34:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 50D114054E
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="5660536"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="5660536"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2023 04:34:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="6146004"
Received: from wasp.igk.intel.com ([10.102.20.192])
 by orviesa001.jf.intel.com with ESMTP; 24 Oct 2023 04:33:29 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue, 24 Oct 2023 13:09:18 +0200
Message-ID: <20231024110929.19423-5-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024110929.19423-1-michal.swiatkowski@linux.intel.com>
References: <20231024110929.19423-1-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698147289; x=1729683289;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JQWkstSUlgGY3Gc/QGH2k/VG3fCYrtBoeCE/haNRHMo=;
 b=SzvM+1pXWcLSSuUpZ1itOnp2Y2ZkcVy15vk5PF3DF5FaiSFYJdGn5rBJ
 FpPXSxNKB4Lj8xZu9UMCkvqvLRMRf1XzZnPN8nLRWEKMjTYwnPESZeQwY
 v95Uo02kJkIPGehhQelSTZRTGviAwmWNb9AvU/qUz3WApPgQIV70dqWvy
 t4Wg2N8B3McEY4133Usxayp1oSOBAwROdpW6jiYILLPEGMQLDm3tO9gaf
 vpIeduz0R5kkWy8Nh2UlItYNxnMkgvevac97qJNrW8iS98ZPQIiT+S3kX
 z8qqorl0PXhBqdqUxtwFm6vXVM+onEq4XQ+OdD8cUD1rbfWPLao72DgRB
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=SzvM+1pX
Subject: [Intel-wired-lan] [PATCH iwl-next v1 04/15] ice: track q_id in
 representor
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
Cc: wojciech.drewek@intel.com, marcin.szycik@intel.com, netdev@vger.kernel.org,
 jesse.brandeburg@intel.com, przemyslaw.kitszel@intel.com,
 jacob.e.keller@intel.com,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 piotr.raczynski@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Previously queue index of control plane VSI used by port representor was
always id of VF. If we want to allow adding port representors for
different devices we have to track queue index in the port representor
structure.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Piotr Raczynski <piotr.raczynski@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 2 +-
 drivers/net/ethernet/intel/ice/ice_repr.c    | 1 +
 drivers/net/ethernet/intel/ice/ice_repr.h    | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index a862681c0f64..119185564450 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -38,7 +38,7 @@ ice_eswitch_add_vf_sp_rule(struct ice_pf *pf, struct ice_vf *vf)
 	rule_info.sw_act.vsi_handle = ctrl_vsi->idx;
 	rule_info.sw_act.fltr_act = ICE_FWD_TO_Q;
 	rule_info.sw_act.fwd_id.q_id = hw->func_caps.common_cap.rxq_first_id +
-				       ctrl_vsi->rxq_map[vf->vf_id];
+				       ctrl_vsi->rxq_map[vf->repr->q_id];
 	rule_info.flags_info.act |= ICE_SINGLE_ACT_LB_ENABLE;
 	rule_info.flags_info.act_valid = true;
 	rule_info.tun_type = ICE_SW_TUN_AND_NON_TUN;
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index c686ac0935eb..a2dc216c964f 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -306,6 +306,7 @@ static int ice_repr_add(struct ice_vf *vf)
 
 	repr->src_vsi = vsi;
 	repr->vf = vf;
+	repr->q_id = vf->vf_id;
 	vf->repr = repr;
 	np = netdev_priv(repr->netdev);
 	np->repr = repr;
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.h b/drivers/net/ethernet/intel/ice/ice_repr.h
index e1ee2d2c1d2d..f350273b8874 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.h
+++ b/drivers/net/ethernet/intel/ice/ice_repr.h
@@ -13,6 +13,7 @@ struct ice_repr {
 	struct net_device *netdev;
 	struct metadata_dst *dst;
 	struct ice_esw_br_port *br_port;
+	int q_id;
 #ifdef CONFIG_ICE_SWITCHDEV
 	/* info about slow path rule */
 	struct ice_rule_query_data sp_rule;
-- 
2.41.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
