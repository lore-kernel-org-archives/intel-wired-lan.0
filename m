Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41417C61DC4
	for <intel-wired-lan@archiver.kernel.org>; Wed, 26 Aug 2026 09:49:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0FD24802AE;
	Wed, 26 Aug 2026 09:49:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CGBdN-xBTEsL; Wed, 26 Aug 2026 09:49:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787737741;
	bh=ZX0o1iT+KwaXvCBh9QBRyhq/S97udIvgKJBNt44zY9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n3bKcSl2fTQyiLmq/O8GCxYh8hyx9uYoJyOfY4MpVp7vds7Zz0cCLvEpXpSQ0bxEy
	 FEJKtFjlof/ntnQ+jBYLOaYHRY/saQb73OMI7bRzrMYUjrwDpMQyPxsB4q1rCi9c9y
	 w6Uur8UO49Yf3tpcdDV48dJfYrWf67BPc4/FHeDNGy8XDKIwwWcqjK4n+MSHNwrG/C
	 EHsPa95BKHGCDf6Tcb4sI1gWV6oh1ljHcDnFK9AlhdnNiQfsfloO41x4+K1bExaWYJ
	 1LnHcH/d8iyk3mYbk8GSorDusuJ21rdmcmvV8PPYNZfpAelonOme9WSuHR/9EQReK2
	 t0n7yDe7bv1iA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EFD9780BCC;
	Wed, 26 Aug 2026 09:49:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E8AB9230
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 09:48:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CF3BF40575
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 09:48:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W4KwwIClQGQw for <intel-wired-lan@lists.osuosl.org>;
 Wed, 26 Aug 2026 09:48:58 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=CMK0CrVT
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C9EC340562
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 09:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787737738; x=1819273738;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=V4W7KOtsjsnY4yHHWe5hb+AdAGYAbZLZ7R/sQDp5ISc=;
 b=CMK0CrVTHNmVolwajotY0sGH6F7rgGOVTw+Rlvpx15+VhvtMDsif6VuU
 NdmJUj6LPPGJ8gXhiGr6t+Ax1sQ843zUfZAiHfW+qTeDr1zRm98DeuLZE
 dm/+bGI0+NB/SuM/8YPTHTHHq9dXcUl/nArTFZyhZTziXJkNC+oArBora
 4QbWUzIuKAZP0dXXWBtNxL03LEcvWj3k+gee4G4/PKibVTF+qjwS3xdJs
 IvEpFf8F9B4lGExD7voApMuhK3h3sngMpFmcd7Z7twoCvHVHJ2PPf5I+D
 LanaPNR78EmEECBwAZfQYmJ7nvPXvq5XLqGLwm3tUiDm3eOP9hro6nd1S A==;
X-CSE-ConnectionGUID: DKnI0GIoTfWRsIIuS0cEmw==
X-CSE-MsgGUID: zJShNpa8TlKZRLJDrZVOIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88232963"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="88232963"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2026 02:48:58 -0700
X-CSE-ConnectionGUID: 1UbTnaqoTvajhB2pLYJtzA==
X-CSE-MsgGUID: hQJ5GjLQRoCASmWnTVD8yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="261404824"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by fmviesa009.fm.intel.com with ESMTP; 26 Aug 2026 02:48:56 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v4 6/6] ice: dpll: Rework the SMA control logic to
 match the requirements
Date: Wed, 26 Aug 2026 09:48:49 +0000
Message-ID: <20260826094849.4112016-7-sergey.temerkhanov@intel.com>
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
index 6a51b2482a5b..1cea8ebbfd94 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -1345,28 +1345,37 @@ static int ice_dpll_sma_direction_set(struct ice_dpll_pin *p,
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
@@ -1378,7 +1387,7 @@ static int ice_dpll_sma_direction_set(struct ice_dpll_pin *p,
 						ICE_DPLL_PIN_TYPE_SOFTWARE,
 						extack);
 	if (ret)
-		return ret;
+		goto restore_sma;
 
 	/* When a direction change activates the paired U.FL pin, enable
 	 * its backing CGU pin so the pin reports as connected. Without
@@ -1389,27 +1398,44 @@ static int ice_dpll_sma_direction_set(struct ice_dpll_pin *p,
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
 
@@ -1667,11 +1693,15 @@ ice_dpll_sma_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
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
@@ -1679,6 +1709,10 @@ ice_dpll_sma_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
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
@@ -1687,6 +1721,10 @@ ice_dpll_sma_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
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
@@ -1722,13 +1760,95 @@ ice_dpll_sma_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
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

