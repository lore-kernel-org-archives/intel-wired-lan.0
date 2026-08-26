Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D17C61DC2
	for <intel-wired-lan@archiver.kernel.org>; Wed, 26 Aug 2026 09:49:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 23FE040563;
	Wed, 26 Aug 2026 09:49:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UQwk2mesFusF; Wed, 26 Aug 2026 09:49:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787737740;
	bh=YLnWBS4InlcRbA/xgWHpPNBiS/Ji/hfl9CnAOgS9I9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AJFEilzwaTEmUlzM1iOvAXQJKJoprXzMbNKYv9oomo3LI/+LYjIWPEv4uustDwfES
	 QZU6PELbmyb+ewJBZgOkLGNMCv4wV+ahOWHtqDplUJky4P/7MEZlyoiOy1/xcN/Cj7
	 YBElUEBQZo9XsrMrlnvvrksKBn9+gdYYlrpNUfl1yOTOJmlb/5YzMadFtKVdNgjzrT
	 EXYu5vh6GK+BsyEscKLrgjI3f4rA3UAyhVE1UjQb2oeyvQAzBUqjvGfXATxGK2eyTo
	 MdW3xxFWNotMpYGKzrsbCDh6qybhAbxcclXFT2++QMNn8Y7vaUxb39IakdPI/o6vk5
	 WGYA07gW5/MRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B31E40575;
	Wed, 26 Aug 2026 09:49:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B018B3C3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 09:48:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AE19640580
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 09:48:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AjghTcMfrABL for <intel-wired-lan@lists.osuosl.org>;
 Wed, 26 Aug 2026 09:48:56 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=HQi5smlR
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BCB1440562
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 09:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787737737; x=1819273737;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vVytYBkgUFEleVRg975aHOd00gO14rRA6ZJb4RsNaPQ=;
 b=HQi5smlR+A632vktl58MW145XWUjg+pHpPYgA0sMgqNVucohdpEe/U5N
 SOt9YkNKragxClPGV0PQQ167+O9yUiqfSklgnPbJ9tRguyptHUjkotksG
 bIajHsNkwwbfDReMdnchpPvK04PzJBoLG4NMxGVxB8ngeDmYExI6SGRvs
 xJsqDuKH/M8MyapNFmIqkOj7EOUUEsVOl2aOERQbFSNSuf7ETsq3KFt0D
 tvyBKUC1Bf6ef29r2AohUBSrYJCQqz7Hxj6X4GvtKHFWuCZyY+YYfUdZ6
 oRs6PARtqYM/DI1pS+8nsPF1s2TgKNWYRk5ewNUgj8zI5WNR4+h8Tt3gi g==;
X-CSE-ConnectionGUID: RQ0qY1fgRu+eAQxeqfEqYw==
X-CSE-MsgGUID: fs/fx8OcQtKBAMaLkfuJ9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88232961"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="88232961"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2026 02:48:56 -0700
X-CSE-ConnectionGUID: BI4pQt65TJCGJpPljyeEnw==
X-CSE-MsgGUID: 61z1OQFCQuetpaQs7UmpEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="261404820"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by fmviesa009.fm.intel.com with ESMTP; 26 Aug 2026 02:48:55 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v4 5/6] ice: dpll: Rework U.FL muxed pin (SMA) control
Date: Wed, 26 Aug 2026 09:48:48 +0000
Message-ID: <20260826094849.4112016-6-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826094849.4112016-1-sergey.temerkhanov@intel.com>
References: <20260826094849.4112016-1-sergey.temerkhanov@intel.com>
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

Rework multiplexed pin control to match the state change listed in
the design requirements.

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 191 +++++++++++++++++++++-
 1 file changed, 183 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index e80460aeac11..6a51b2482a5b 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -469,6 +469,40 @@ ice_dpll_sw_pin_frequency_get(const struct dpll_pin *pin, void *pin_priv,
 	return ret;
 }
 
+static int ice_dpll_get_fallback_idx(struct ice_dplls *d, struct ice_dpll_pin *target)
+{
+	if (d->pps.dpll_idx < ICE_DPLL_RCLK_NUM_MAX &&
+	    target->state[d->pps.dpll_idx] == DPLL_PIN_STATE_CONNECTED)
+		return d->pps.dpll_idx;
+
+	if (d->eec.dpll_idx < ICE_DPLL_RCLK_NUM_MAX &&
+	    target->state[d->eec.dpll_idx] == DPLL_PIN_STATE_CONNECTED)
+		return d->eec.dpll_idx;
+
+	return -EINVAL;
+}
+
+static void ice_dpll_get_peer_target(struct ice_dpll_pin *peer,
+				     struct ice_dpll_pin **peer_target,
+				     enum ice_dpll_pin_type *peer_type)
+{
+	*peer_target = NULL;
+	*peer_type = 0;
+
+	switch (peer->direction) {
+	case DPLL_PIN_DIRECTION_OUTPUT:
+		*peer_target = peer->output;
+		*peer_type = ICE_DPLL_PIN_TYPE_OUTPUT;
+		break;
+	case DPLL_PIN_DIRECTION_INPUT:
+		*peer_target = peer->input;
+		*peer_type = ICE_DPLL_PIN_TYPE_INPUT;
+		break;
+	default:
+		break;
+	}
+}
+
 /**
  * ice_dpll_pin_enable - enable a pin on dplls
  * @hw: board private hw structure
@@ -1211,6 +1245,87 @@ ice_dpll_input_state_get(const struct dpll_pin *pin, void *pin_priv,
 				      extack, ICE_DPLL_PIN_TYPE_INPUT);
 }
 
+struct ice_dpll_pin_config {
+	bool enabled;
+	u8 dpll_idx;
+};
+
+static int
+ice_dpll_pin_config_get(struct ice_pf *pf, struct ice_dpll_pin *target,
+			enum ice_dpll_pin_type type,
+			struct ice_dpll_pin_config *config,
+			struct netlink_ext_ack *extack)
+{
+	int ret;
+
+	ret = ice_dpll_pin_state_update(pf, target, type, extack);
+	if (ret)
+		return ret;
+
+	switch (type) {
+	case ICE_DPLL_PIN_TYPE_INPUT:
+		config->enabled = target->flags[0] &
+				  ICE_AQC_GET_CGU_IN_CFG_FLG2_INPUT_EN;
+		config->dpll_idx = 0;
+		return 0;
+	case ICE_DPLL_PIN_TYPE_OUTPUT:
+		config->enabled = target->flags[0] &
+				  ICE_AQC_GET_CGU_OUT_CFG_OUT_EN;
+		if (!config->enabled) {
+			config->dpll_idx = 0;
+			return 0;
+		}
+
+		ret = ice_dpll_get_fallback_idx(&pf->dplls, target);
+		if (ret < 0)
+			return ret;
+		config->dpll_idx = ret;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int
+ice_dpll_pin_config_restore(struct ice_pf *pf, struct ice_dpll_pin *target,
+			    enum ice_dpll_pin_type type,
+			    const struct ice_dpll_pin_config *config,
+			    struct netlink_ext_ack *extack, int init_err)
+{
+	int restore_err, update_err;
+
+	if (config->enabled)
+		restore_err = ice_dpll_pin_enable(&pf->hw, target,
+						  config->dpll_idx, type, extack);
+	else
+		restore_err = ice_dpll_pin_disable(&pf->hw, target, type, extack);
+	update_err = ice_dpll_pin_state_update(pf, target, type, extack);
+	if (restore_err || update_err) {
+		dev_warn(ice_pf_to_dev(pf),
+			 "Failed to rollback pin state: err %d, restore err %d, update err %d\n",
+			 init_err, restore_err, update_err);
+		return restore_err ? restore_err : update_err;
+	}
+
+	return 0;
+}
+
+static int ice_dpll_restore_sma_ctrl(struct ice_pf *pf, u8 old_data,
+				     int init_err)
+{
+	int restore_err;
+
+	restore_err = ice_write_sma_ctrl(&pf->hw, old_data);
+	if (!restore_err)
+		restore_err = ice_dpll_sw_pins_update(pf);
+	if (restore_err)
+		dev_warn(ice_pf_to_dev(pf),
+			 "Failed to restore SMA control: err %d, restore err %d\n",
+			 init_err, restore_err);
+
+	return restore_err;
+}
+
 /**
  * ice_dpll_sma_direction_set - set direction of SMA pin
  * @p: pointer to a pin
@@ -1276,6 +1391,7 @@ static int ice_dpll_sma_direction_set(struct ice_dpll_pin *p,
 	if (peer->active) {
 		struct ice_dpll_pin *target;
 		enum ice_dpll_pin_type type;
+		int peer_ret;
 
 		if (peer->output) {
 			target = peer->output;
@@ -1284,8 +1400,11 @@ static int ice_dpll_sma_direction_set(struct ice_dpll_pin *p,
 			target = peer->input;
 			type = ICE_DPLL_PIN_TYPE_INPUT;
 		}
-		ret = ice_dpll_pin_enable(&p->pf->hw, target,
-					  d->eec.dpll_idx, type, extack);
+		peer_ret = ice_dpll_get_fallback_idx(d, target);
+		if (peer_ret < 0)
+			peer_ret = d->eec.dpll_idx;
+		ret = ice_dpll_pin_enable(&p->pf->hw, target, peer_ret, type,
+					  extack);
 		if (!ret)
 			ret = ice_dpll_pin_state_update(p->pf, target,
 							type, extack);
@@ -1317,13 +1436,17 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 			   struct netlink_ext_ack *extack)
 {
 	struct ice_dpll_pin *p = pin_priv, *target;
+	struct ice_dpll_pin *peer_target = NULL;
 	struct ice_dpll *d = dpll_priv;
-	enum ice_dpll_pin_type type;
+	enum ice_dpll_pin_type peer_type = 0, type;
 	struct ice_pf *pf = p->pf;
+	struct ice_dpll_pin_config old_config;
+	struct ice_dpll_pin_config peer_config;
 	struct ice_hw *hw;
+	u8 old_data = 0;
 	bool enable;
 	u8 data;
-	int ret;
+	int peer_dpll_idx, restore_err, ret;
 
 	if (ice_dpll_is_reset(pf, extack))
 		return -EBUSY;
@@ -1333,6 +1456,7 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 	ret = ice_read_sma_ctrl(hw, &data);
 	if (ret)
 		goto unlock;
+	old_data = data;
 
 	ret = -EINVAL;
 	switch (p->idx) {
@@ -1392,18 +1516,69 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 
 	ret = ice_write_sma_ctrl(hw, data);
 	if (ret)
-		goto unlock;
+		goto restore_sma_ctrl;
 	ret = ice_dpll_pin_state_update(pf, p, ICE_DPLL_PIN_TYPE_SOFTWARE,
 					extack);
 	if (ret)
-		goto unlock;
+		goto restore_sma_ctrl;
+
+	ret = ice_dpll_pin_config_get(pf, target, type, &old_config, extack);
+	if (ret)
+		goto restore_sma_ctrl;
 
 	if (enable)
 		ret = ice_dpll_pin_enable(hw, target, d->dpll_idx, type, extack);
 	else
 		ret = ice_dpll_pin_disable(hw, target, type, extack);
-	if (!ret)
-		ret = ice_dpll_pin_state_update(pf, target, type, extack);
+	if (ret)
+		goto restore_target;
+	ret = ice_dpll_pin_state_update(pf, target, type, extack);
+	if (ret)
+		goto restore_target;
+
+	if (enable && p->muxed && p->muxed->active) {
+		ice_dpll_get_peer_target(p->muxed, &peer_target, &peer_type);
+		if (!peer_target) {
+			ret = -EINVAL;
+			goto restore_target;
+		}
+		ret = ice_dpll_pin_config_get(pf, peer_target, peer_type,
+					      &peer_config, extack);
+		if (ret)
+			goto restore_target;
+
+		peer_dpll_idx = ice_dpll_get_fallback_idx(&pf->dplls,
+							  peer_target);
+		if (peer_dpll_idx < 0)
+			peer_dpll_idx = d->dpll_idx;
+		ret = ice_dpll_pin_enable(&pf->hw, peer_target, peer_dpll_idx,
+					  peer_type, extack);
+		if (ret)
+			goto restore_peer;
+		ret = ice_dpll_pin_state_update(pf, peer_target, peer_type,
+						extack);
+		if (ret)
+			goto restore_peer;
+	}
+
+	goto unlock;
+
+restore_peer:
+	restore_err =
+		ice_dpll_pin_config_restore(pf, peer_target, peer_type,
+					    &peer_config, extack, ret);
+	if (restore_err)
+		ret = restore_err;
+restore_target:
+	restore_err =
+		ice_dpll_pin_config_restore(pf, target, type, &old_config,
+					    extack, ret);
+	if (restore_err)
+		ret = restore_err;
+restore_sma_ctrl:
+	restore_err = ice_dpll_restore_sma_ctrl(pf, old_data, ret);
+	if (restore_err)
+		ret = restore_err;
 
 unlock:
 	mutex_unlock(&pf->dplls.lock);
-- 
2.53.0

