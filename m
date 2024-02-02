Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6DBC4828F
	for <intel-wired-lan@archiver.kernel.org>; Fri,  2 Feb 2024 14:55:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1649743760;
	Fri,  2 Feb 2024 14:55:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1649743760
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1706885757;
	bh=Ucd+HuoZ8Ehpf5SuwxwBoyBv1EHOHRoL+aYs1fAXwvg=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=yE7r8ObjffCfhczmtyaoyrnaXtc1Wyq/iEjzBnLTO/qcdHjBKGML8cBxOv6B2gBqa
	 6KK48PVN8/Mede3nEfcwF2rezjSN5NaOFA1vvMs29Q28meX0cx/l1At+aETJrab2GT
	 BRcQjC4eWEl+hFnOr4bPXGnmMJyGFyagmibiNt5kCuuFsJw+SkZdVcV0AR5iegrhwS
	 diZ/W8tIg9ioPW3H0sFJAnJiIkYc52vferrGYwweEbfk0dHRNeBW1qgNXGQvdR5ZHe
	 xpvnRmLUSSN5sbUqJxtwk4ZGcc+vuY9KD4u907V51lJU5QOjbPotv/2Eetf0n4Pw3j
	 Sho5MY+oLOwaA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9Cq69hh6y8P3; Fri,  2 Feb 2024 14:55:56 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 35B0743776;
	Fri,  2 Feb 2024 14:55:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 35B0743776
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 4CE7F1BF423
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Feb 2024 14:55:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D67EF42084
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Feb 2024 14:55:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D67EF42084
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WpaEJsSukiSB for <intel-wired-lan@lists.osuosl.org>;
 Fri,  2 Feb 2024 14:55:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2B9C8426DA
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Feb 2024 14:55:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2B9C8426DA
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="10823030"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; d="scan'208";a="10823030"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2024 06:55:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="98428"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com)
 ([10.102.20.192])
 by orviesa009.jf.intel.com with ESMTP; 02 Feb 2024 06:55:28 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Fri,  2 Feb 2024 15:59:24 +0100
Message-ID: <20240202145929.12444-5-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240202145929.12444-1-michal.swiatkowski@linux.intel.com>
References: <20240202145929.12444-1-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706885739; x=1738421739;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FL8Fvjd5+R/y+eL0z0R6v3wNh8OLN4CCL99WoAERxn0=;
 b=feBRFtWyFIyshsGBddeB6j2VjwAC23k0/+ZnTFEhgnKN6FrwMLTyhAQ3
 /sjXVxalKsF3ryeFUta2PerRwkT9Qv1EdUg+vIQLhwWbxU4P9XdcGmK4V
 9z+/tdiWBBu0whGQI1+IgQyXgOEuos11P13kOkV76F2gBCQTCl+qgT+f6
 kGi4XkBC554SrREzpHwKNL9uP8FXQHKItwCUiKZOVWoAF7niR8rIOCMAl
 P21lm/YYLbt37qBl0rwWo5XizP7S+eUTA4/PSCdf4Ggb2+tKEeFSwKn38
 PRB+MznkZdO8VUgHUBjy6p2IoTrPLRx+obDPXxb1j46EZ8KmK42EkfboH
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=feBRFtWy
Subject: [Intel-wired-lan] [iwl-next v2 4/8] ice: control default Tx rule in
 lag
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
Cc: wojciech.drewek@intel.com, marcin.szycik@intel.com,
 Marcin Szycik <marcin.szycik@linux.intel.com>, przemyslaw.kitszel@intel.com,
 sridhar.samudrala@intel.com, horms@kernel.org, netdev@vger.kernel.org,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Tx rule in switchdev was changed to use PF instead of additional control
plane VSI. Because of that during lag we should control it. Control
means to add and remove the default Tx rule during lag active/inactive
switching.

It can be done the same way as default Rx rule.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 42 +++++++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_lag.h |  3 +-
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index a7a342809935..d04e8534fde9 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -202,11 +202,12 @@ static struct ice_lag *ice_lag_find_primary(struct ice_lag *lag)
  * @act: rule action
  * @recipe_id: recipe id for the new rule
  * @rule_idx: pointer to rule index
+ * @direction: ICE_FLTR_RX or ICE_FLTR_TX
  * @add: boolean on whether we are adding filters
  */
 static int
 ice_lag_cfg_fltr(struct ice_lag *lag, u32 act, u16 recipe_id, u16 *rule_idx,
-		 bool add)
+		 u8 direction, bool add)
 {
 	struct ice_sw_rule_lkup_rx_tx *s_rule;
 	u16 s_rule_sz, vsi_num;
@@ -231,9 +232,16 @@ ice_lag_cfg_fltr(struct ice_lag *lag, u32 act, u16 recipe_id, u16 *rule_idx,
 
 		act |= FIELD_PREP(ICE_SINGLE_ACT_VSI_ID_M, vsi_num);
 
-		s_rule->hdr.type = cpu_to_le16(ICE_AQC_SW_RULES_T_LKUP_RX);
 		s_rule->recipe_id = cpu_to_le16(recipe_id);
-		s_rule->src = cpu_to_le16(hw->port_info->lport);
+		if (direction == ICE_FLTR_RX) {
+			s_rule->hdr.type =
+				cpu_to_le16(ICE_AQC_SW_RULES_T_LKUP_RX);
+			s_rule->src = cpu_to_le16(hw->port_info->lport);
+		} else {
+			s_rule->hdr.type =
+				cpu_to_le16(ICE_AQC_SW_RULES_T_LKUP_TX);
+			s_rule->src = cpu_to_le16(vsi_num);
+		}
 		s_rule->act = cpu_to_le32(act);
 		s_rule->hdr_len = cpu_to_le16(DUMMY_ETH_HDR_LEN);
 		opc = ice_aqc_opc_add_sw_rules;
@@ -266,9 +274,25 @@ ice_lag_cfg_dflt_fltr(struct ice_lag *lag, bool add)
 {
 	u32 act = ICE_SINGLE_ACT_VSI_FORWARDING |
 		ICE_SINGLE_ACT_VALID_BIT | ICE_SINGLE_ACT_LAN_ENABLE;
+	int err;
+
+	err = ice_lag_cfg_fltr(lag, act, lag->pf_recipe, &lag->pf_rx_rule_id,
+			       ICE_FLTR_RX, add);
+	if (err)
+		goto err_rx;
 
-	return ice_lag_cfg_fltr(lag, act, lag->pf_recipe,
-				&lag->pf_rule_id, add);
+	err = ice_lag_cfg_fltr(lag, act, lag->pf_recipe, &lag->pf_tx_rule_id,
+			       ICE_FLTR_TX, add);
+	if (err)
+		goto err_tx;
+
+	return 0;
+
+err_tx:
+	ice_lag_cfg_fltr(lag, act, lag->pf_recipe, &lag->pf_rx_rule_id,
+			 ICE_FLTR_RX, !add);
+err_rx:
+	return err;
 }
 
 /**
@@ -284,7 +308,7 @@ ice_lag_cfg_drop_fltr(struct ice_lag *lag, bool add)
 		  ICE_SINGLE_ACT_DROP;
 
 	return ice_lag_cfg_fltr(lag, act, lag->lport_recipe,
-				&lag->lport_rule_idx, add);
+				&lag->lport_rule_idx, ICE_FLTR_RX, add);
 }
 
 /**
@@ -310,7 +334,7 @@ ice_lag_cfg_pf_fltrs(struct ice_lag *lag, void *ptr)
 	dev = ice_pf_to_dev(lag->pf);
 
 	/* interface not active - remove old default VSI rule */
-	if (bonding_info->slave.state && lag->pf_rule_id) {
+	if (bonding_info->slave.state && lag->pf_rx_rule_id) {
 		if (ice_lag_cfg_dflt_fltr(lag, false))
 			dev_err(dev, "Error removing old default VSI filter\n");
 		if (ice_lag_cfg_drop_fltr(lag, true))
@@ -319,7 +343,7 @@ ice_lag_cfg_pf_fltrs(struct ice_lag *lag, void *ptr)
 	}
 
 	/* interface becoming active - add new default VSI rule */
-	if (!bonding_info->slave.state && !lag->pf_rule_id) {
+	if (!bonding_info->slave.state && !lag->pf_rx_rule_id) {
 		if (ice_lag_cfg_dflt_fltr(lag, true))
 			dev_err(dev, "Error adding new default VSI filter\n");
 		if (lag->lport_rule_idx && ice_lag_cfg_drop_fltr(lag, false))
@@ -2149,7 +2173,7 @@ void ice_lag_rebuild(struct ice_pf *pf)
 
 	ice_lag_cfg_cp_fltr(lag, true);
 
-	if (lag->pf_rule_id)
+	if (lag->pf_rx_rule_id)
 		if (ice_lag_cfg_dflt_fltr(lag, true))
 			dev_err(ice_pf_to_dev(pf), "Error adding default VSI rule in rebuild\n");
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lag.h b/drivers/net/ethernet/intel/ice/ice_lag.h
index 183b38792ef2..bab2c83142a1 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.h
+++ b/drivers/net/ethernet/intel/ice/ice_lag.h
@@ -43,7 +43,8 @@ struct ice_lag {
 	u8 primary:1; /* this is primary */
 	u16 pf_recipe;
 	u16 lport_recipe;
-	u16 pf_rule_id;
+	u16 pf_rx_rule_id;
+	u16 pf_tx_rule_id;
 	u16 cp_rule_idx;
 	u16 lport_rule_idx;
 	u8 role;
-- 
2.42.0

