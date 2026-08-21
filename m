Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9821C5DF94
	for <intel-wired-lan@archiver.kernel.org>; Fri, 21 Aug 2026 15:25:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 78D9E8154C;
	Fri, 21 Aug 2026 15:25:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RfiD75Ih_61l; Fri, 21 Aug 2026 15:25:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787325905;
	bh=LrI1xZ2wsgNbAdUjqFv2tk5hEUF0UBqRZoUGygKMrLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T4osV1pvrqi4aD2PLs8+d/qteRQX+linhT460F8CXc4Wo3mXNcjP5INbvTtzMGmTh
	 KIqGs7ZOh8KWwPg5u5vWxaEKzZzSmLt4YO6Mj4Zo536GySp1hhrs+hm/1KcS+xGv+1
	 lVIRZUiHscQctSZSBmnNZ8wCGkFtgDpkil61Rsz81l5AFmxiXWdLbmmic0K4ow6KvC
	 1hDAZWHhsXl9tRMvN+4VqTL5IEtAV1sx1gxbKE0qYiiCIleTWzsZ+3zGKBa2flYs1Q
	 HKhQXHhIRgww4pm/D1jSem3RQmGn3q9T8Rbf+kYnCPcYhdUMQAFu0Fj7GDJuLO/e/l
	 NGe/h6hrmKkUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B2D0581351;
	Fri, 21 Aug 2026 15:25:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B482A3A4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 15:25:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A6BE781346
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 15:25:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jzEGHUdtGu1d for <intel-wired-lan@lists.osuosl.org>;
 Fri, 21 Aug 2026 15:25:02 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=NXk/IayL
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A20958138C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 15:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787325903; x=1818861903;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FK27Me50DfS5nXjO5Gv14h1qOMEXBLLc469hrldiMVo=;
 b=NXk/IayLj7JjFPLB8As5DqffAXLrWTRpjWVcv0XVMSslWMR3S5wiyPew
 2THYQZ9ElmJm76vL9OUscmW/KqFxfcBXedvA4Hri5M6Xsgdj5Du9nC6ux
 Xv2FfWy3jADj5s+Cw9cX8vp4mWcU6bgCUfgqxncIbuxF2aL31RXILgRTd
 oddNvKXk7h47TapeDEsiLrBjygGQlhlhfJpVt4ArQpP8oUIiqRNvwNI9I
 aSDT/yv3NiRbwOH/GtvNxTJubUHKGY2Lx6KPRzaxjLosysly3vpHh9yeW
 +yt97NBYxXPq20oq2HVogF9JHJKzDroxKkMIBiE6j6oM1GbZT+xsWgDsE Q==;
X-CSE-ConnectionGUID: 6o5p9d+xRTuRT+lE9+NX9g==
X-CSE-MsgGUID: olHQArRNSUKNANRUnK2zrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="91553211"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; d="scan'208";a="91553211"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 08:25:02 -0700
X-CSE-ConnectionGUID: GY7rI1Y7Rt6+T7X7cokoLg==
X-CSE-MsgGUID: BRsHS9/GRZKORD4mTXhy1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; d="scan'208";a="270602196"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa005.jf.intel.com with ESMTP; 21 Aug 2026 08:25:00 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v3 6/6] ice: dpll: Rework the SMA control logic to
 match the requirements
Date: Fri, 21 Aug 2026 15:24:54 +0000
Message-ID: <20260821152454.3703979-7-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821152454.3703979-1-sergey.temerkhanov@intel.com>
References: <20260821152454.3703979-1-sergey.temerkhanov@intel.com>
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

Make the SMA control logic match the requirements:

Setting SMA1 as Rx automatically enables U.FL1 as Tx if U.FL1 is
disconnected.
Setting SMA1 as Tx automatically changes U.FL1 state to disconnected.

Setting SMA2 as Tx automatically enables U.FL2 as Rx if U.FL2 is
disconnected.
Setting SMA2 as Rx automatically changes U.FL2 state to disconnected.

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 172 ++++++++++++++++++----
 1 file changed, 146 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 0081544b769c..9e3e69e523c9 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -1359,28 +1359,37 @@ static int ice_dpll_sma_direction_set(struct ice_dpll_pin *p,
 {
 	struct ice_dplls *d = &p->pf->dplls;
 	struct ice_dpll_pin *peer;
-	u8 data;
-	int ret;
+	struct ice_dpll_pin *target = NULL;
+	struct ice_dpll_pin_config peer_config;
+	enum ice_dpll_pin_type type = 0;
+	u8 data, old_data = 0;
+	int peer_dpll_idx, restore_err, ret;
 
 	if (p->direction == direction && p->active)
 		return 0;
 	ret = ice_read_sma_ctrl(&p->pf->hw, &data);
 	if (ret)
 		return ret;
+	old_data = data;
 
 	switch (p->idx) {
 	case ICE_DPLL_PIN_SW_1_IDX:
-		data &= ~ICE_SMA1_MASK;
-		if (direction == DPLL_PIN_DIRECTION_OUTPUT)
+		if (direction == DPLL_PIN_DIRECTION_OUTPUT) {
+			data &= ~ICE_SMA1_TX_EN;
 			data |= ICE_SMA1_DIR_EN;
+		} else {
+			data &= ~ICE_SMA1_DIR_EN;
+			data &= ~ICE_SMA1_TX_EN;
+		}
 		break;
 	case ICE_DPLL_PIN_SW_2_IDX:
 		if (direction == DPLL_PIN_DIRECTION_INPUT) {
 			data &= ~ICE_SMA2_DIR_EN;
-			data |= ICE_SMA2_UFL2_RX_DIS;
+			data &= ~ICE_SMA2_TX_EN;
 		} else {
-			data &= ~(ICE_SMA2_TX_EN | ICE_SMA2_UFL2_RX_DIS);
 			data |= ICE_SMA2_DIR_EN;
+			data &= ~ICE_SMA2_UFL2_RX_DIS;
+			data &= ~ICE_SMA2_TX_EN;
 		}
 		break;
 	default:
@@ -1392,7 +1401,7 @@ static int ice_dpll_sma_direction_set(struct ice_dpll_pin *p,
 						ICE_DPLL_PIN_TYPE_SOFTWARE,
 						extack);
 	if (ret)
-		return ret;
+		goto restore_sma;
 
 	/* When a direction change activates the paired U.FL pin, enable
 	 * its backing CGU pin so the pin reports as connected. Without
@@ -1403,27 +1412,44 @@ static int ice_dpll_sma_direction_set(struct ice_dpll_pin *p,
 	 */
 	peer = p->muxed;
 	if (peer->active) {
-		struct ice_dpll_pin *target;
-		enum ice_dpll_pin_type type;
-		int peer_ret;
-
 		if (peer->output) {
 			target = peer->output;
 			type = ICE_DPLL_PIN_TYPE_OUTPUT;
-		} else {
+		} else if (peer->input) {
 			target = peer->input;
 			type = ICE_DPLL_PIN_TYPE_INPUT;
+		} else {
+			ret = -EINVAL;
+			goto restore_sma;
 		}
-		peer_ret = ice_dpll_get_fallback_idx(d, target);
-		if (peer_ret < 0)
-			peer_ret = d->eec.dpll_idx;
-		ret = ice_dpll_pin_enable(&p->pf->hw, target, peer_ret, type,
-					  extack);
-		if (!ret)
-			ret = ice_dpll_pin_state_update(p->pf, target,
-							type, extack);
+
+		ret = ice_dpll_pin_config_get(p->pf, target, type,
+					      &peer_config, extack);
+		if (ret)
+			goto restore_sma;
+
+		peer_dpll_idx = ice_dpll_get_fallback_idx(d, target);
+		if (peer_dpll_idx < 0)
+			peer_dpll_idx = d->eec.dpll_idx;
+		ret = ice_dpll_pin_enable(&p->pf->hw, target, peer_dpll_idx,
+					  type, extack);
+		if (ret)
+			goto restore_peer;
+		ret = ice_dpll_pin_state_update(p->pf, target, type, extack);
+		if (ret)
+			goto restore_peer;
 	}
 
+	return 0;
+
+restore_peer:
+	restore_err =
+		ice_dpll_pin_config_restore(p->pf, target, type, &peer_config,
+					    extack, ret);
+	if (restore_err)
+		ret = restore_err;
+restore_sma:
+	ice_dpll_restore_sma_ctrl(p->pf, old_data, ret);
 	return ret;
 }
 
@@ -1681,11 +1707,15 @@ ice_dpll_sma_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 			   struct netlink_ext_ack *extack)
 {
 	struct ice_dpll_pin *sma = pin_priv, *target;
+	struct ice_dpll_pin *peer_target = NULL;
 	struct ice_dpll *d = dpll_priv;
 	struct ice_pf *pf = sma->pf;
-	enum ice_dpll_pin_type type;
+	enum ice_dpll_pin_type peer_type = 0, type;
+	struct ice_dpll_pin_config old_config;
+	struct ice_dpll_pin_config peer_config;
+	u8 old_data = 0;
 	bool enable;
-	int ret;
+	int peer_dpll_idx, restore_err, ret = -EINVAL;
 
 	if (ice_dpll_is_reset(pf, extack))
 		return -EBUSY;
@@ -1693,6 +1723,10 @@ ice_dpll_sma_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 	mutex_lock(&pf->dplls.lock);
 	switch (state) {
 	case DPLL_PIN_STATE_SELECTABLE:
+		/* Reject direction-mismatched requests: SELECTABLE + OUTPUT
+		 * is an invalid combination, return -EINVAL in this case
+		 * immediately instead of disabling the pin.
+		 */
 		if (sma->direction == DPLL_PIN_DIRECTION_OUTPUT) {
 			enable = false;
 			ret = -EINVAL;
@@ -1701,6 +1735,10 @@ ice_dpll_sma_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 		enable = true;
 		break;
 	case DPLL_PIN_STATE_CONNECTED:
+		/* Reject direction-mismatched requests: CONNECTED + INPUT
+		 * is an invalid combination, return -EINVAL in this case
+		 * immediately instead of disabling the pin.
+		 */
 		if (sma->direction == DPLL_PIN_DIRECTION_INPUT) {
 			enable = false;
 			ret = -EINVAL;
@@ -1736,13 +1774,95 @@ ice_dpll_sma_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 			goto unlock;
 	}
 
-	if (enable)
+	if (enable) {
+		u8 data;
+
+		ret = ice_read_sma_ctrl(&pf->hw, &data);
+		if (ret)
+			goto unlock;
+		old_data = data;
+		switch (sma->idx) {
+		case ICE_DPLL_PIN_SW_1_IDX:
+			data &= ~ICE_SMA1_TX_EN;
+			break;
+		case ICE_DPLL_PIN_SW_2_IDX:
+			data &= ~ICE_SMA2_UFL2_RX_DIS;
+			data &= ~ICE_SMA2_TX_EN;
+			break;
+		default:
+			ret = -EINVAL;
+			goto unlock;
+		}
+		ret = ice_write_sma_ctrl(&pf->hw, data);
+		if (ret)
+			goto restore_sma_ctrl;
+		ret = ice_dpll_sw_pins_update(pf);
+		if (ret)
+			goto restore_sma_ctrl;
+
+		ret = ice_dpll_pin_config_get(pf, target, type, &old_config,
+					      extack);
+		if (ret)
+			goto restore_sma_ctrl;
 		ret = ice_dpll_pin_enable(&pf->hw, target, d->dpll_idx, type,
 					  extack);
-	else
-		ret = ice_dpll_pin_disable(&pf->hw, target, type, extack);
-	if (!ret)
+		if (ret)
+			goto restore_target;
+		/* Refresh target state before peer-side operations. */
 		ret = ice_dpll_pin_state_update(pf, target, type, extack);
+		if (ret)
+			goto restore_target;
+
+		if (sma->muxed && sma->muxed->active) {
+			ice_dpll_get_peer_target(sma->muxed, &peer_target,
+						 &peer_type);
+			if (!peer_target) {
+				ret = -EINVAL;
+				goto restore_target;
+			}
+
+			ret = ice_dpll_pin_config_get(pf, peer_target, peer_type,
+						      &peer_config, extack);
+			if (ret)
+				goto restore_target;
+
+			peer_dpll_idx =
+				ice_dpll_get_fallback_idx(&pf->dplls, peer_target);
+			if (peer_dpll_idx < 0)
+				peer_dpll_idx = d->dpll_idx;
+			ret = ice_dpll_pin_enable(&pf->hw, peer_target,
+						  peer_dpll_idx, peer_type, extack);
+			if (ret)
+				goto restore_peer;
+			ret = ice_dpll_pin_state_update(pf, peer_target, peer_type,
+							extack);
+			if (ret)
+				goto restore_peer;
+		}
+	} else {
+		ret = ice_dpll_pin_disable(&pf->hw, target, type, extack);
+		if (!ret)
+			ret = ice_dpll_pin_state_update(pf, target, type,
+							extack);
+	}
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

