Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F936C53215
	for <intel-wired-lan@archiver.kernel.org>; Fri, 24 Jul 2026 12:14:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2EE140B0E;
	Fri, 24 Jul 2026 12:14:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hogOvhJIFcMM; Fri, 24 Jul 2026 12:14:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F3FDF40B1A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784895240;
	bh=UBFEgwtdF6LRjWqPkNnHZMoEr3ECb+sYxFXHha4UlHs=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=2ySZ3MZuJdjEJf2QdAmpnqO71ZXtccUOnXapdBx1H5psfVZlY2vH6iTatIFqoj+LT
	 5Egn/z18iJ/CTE2dFaOyhDPGfjfpQW/dxNb9WM71MPo+Ni/je4CjMu9EBcsrkBLrl9
	 sdeaOUKyDGpGo4Z6xgbccUGUDOS/NNSGZny5AZSaVUkufTKA7N64vnzkiXgmtfgkPa
	 NZHgnm9oLBredfmfpLm12F1pZNIQdFSM8ykYaLFl7hr71EOlBLdMH8N9qNQpmYZ8dN
	 tHmC03zVSRqfcIjP0wMA+3WYB9b2XDOCLfR7Sje/2OTlmOJ3MjABg/X7K9sWF4FzKc
	 uehnOxNwbr0fA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F3FDF40B1A;
	Fri, 24 Jul 2026 12:13:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D09BF429
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Jul 2026 12:13:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9AC9A40B06
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Jul 2026 12:13:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Un5C_oqiaDw0 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 24 Jul 2026 12:13:56 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9950B40AC1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9950B40AC1
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9950B40AC1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Jul 2026 12:13:56 +0000 (UTC)
X-CSE-ConnectionGUID: ZHi7/nIyRk6CNu9ZLR+XoA==
X-CSE-MsgGUID: EI/+ZVLgRE6lSH79NjSswg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="84686079"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; d="scan'208";a="84686079"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2026 05:13:57 -0700
X-CSE-ConnectionGUID: 3+QMDdrUSNu3vbOAkflRaA==
X-CSE-MsgGUID: IjKGqXiUQQCOR1kU6qAD3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; d="scan'208";a="252367707"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by fmviesa009.fm.intel.com with ESMTP; 24 Jul 2026 05:13:55 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Date: Fri, 24 Jul 2026 12:13:50 +0000
Message-ID: <20260724121350.1565330-5-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724121350.1565330-1-sergey.temerkhanov@intel.com>
References: <20260724121350.1565330-1-sergey.temerkhanov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784895237; x=1816431237;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=x81AropZ8wmafCaQqgumhWgAWlIX9ggQCy3dvBjj+pg=;
 b=mpwiVUnRuP/eVkSr2L72WQAUFqHWcs7UIhfzZuCuUZmSfTAk1pucN64P
 ouE9Vx/5XFGlnhwk43eSZP/9Lez3QuqLzQbcsOTBLXq38l53GBkucrUCB
 SJxG9p1PyZIJBN982x24CQ1gYMQLdoO3XNHFZHLfSUdbGOGnrHdOutStF
 QHOflilxIJToUqBzCwIqxWmo4jJaM3m0k4XVmxrfs8ycgcVhvi2ARGd/I
 I7jm94puATkVTvYTZgTjDEsQTRmLWzw6qH9DZjn8U1gSq7YTQeKZtxEQM
 W1CwoOkezUU7U0d7RrG4VkgkpTp9u+ugmrkKUn2HAzQRPYRt80Q+v5sP0
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=mpwiVUnR
Subject: [Intel-wired-lan] [PATCH iwl-next v2 4/4] ice: dpll: Rework the SMA
 control logic to match the requirements
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
 drivers/net/ethernet/intel/ice/ice_dpll.c | 138 ++++++++++++++++++++--
 1 file changed, 127 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index cf54a7f2f836..e663f13a2f11 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -698,10 +698,10 @@ ice_dpll_sw_pins_update(struct ice_pf *pf)
 	p = &d->sma[ICE_DPLL_PIN_SW_2_IDX];
 	p->active = true;
 	p->direction = DPLL_PIN_DIRECTION_INPUT;
+	if (data & ICE_SMA2_DIR_EN)
+		p->direction = DPLL_PIN_DIRECTION_OUTPUT;
 	if ((data & ICE_SMA2_INACTIVE_MASK) == ICE_SMA2_INACTIVE_MASK)
 		p->active = false;
-	else if (data & ICE_SMA2_DIR_EN)
-		p->direction = DPLL_PIN_DIRECTION_OUTPUT;
 
 	p = &d->ufl[ICE_DPLL_PIN_SW_1_IDX];
 	if (!(data & (ICE_SMA1_DIR_EN | ICE_SMA1_TX_EN)))
@@ -1224,17 +1224,21 @@ static int ice_dpll_sma_direction_set(struct ice_dpll_pin *p,
 
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
 		} else {
-			data &= ~(ICE_SMA2_TX_EN | ICE_SMA2_UFL2_RX_DIS);
 			data |= ICE_SMA2_DIR_EN;
+			data &= ~ICE_SMA2_UFL2_RX_DIS;
+			data &= ~ICE_SMA2_TX_EN;
 		}
 		break;
 	default:
@@ -1263,12 +1267,16 @@ static int ice_dpll_sma_direction_set(struct ice_dpll_pin *p,
 		if (peer->output) {
 			target = peer->output;
 			type = ICE_DPLL_PIN_TYPE_OUTPUT;
-		} else {
+		} else if (peer->input) {
 			target = peer->input;
 			type = ICE_DPLL_PIN_TYPE_INPUT;
+		} else {
+			return -EINVAL;
 		}
+
 		ret = ice_dpll_pin_enable(&p->pf->hw, target,
-					  d->pps.dpll_idx < ICE_DPLL_RCLK_NUM_MAX && target->state[d->pps.dpll_idx] == DPLL_PIN_STATE_CONNECTED ?
+                                         d->pps.dpll_idx < ICE_DPLL_RCLK_NUM_MAX &&
+                                          target->state[d->pps.dpll_idx] == DPLL_PIN_STATE_CONNECTED ?
 					  d->pps.dpll_idx : d->eec.dpll_idx, type, extack);
 		if (!ret)
 			ret = ice_dpll_pin_state_update(p->pf, target,
@@ -1552,6 +1560,7 @@ ice_dpll_sma_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 	struct ice_dpll *d = dpll_priv;
 	struct ice_pf *pf = sma->pf;
 	enum ice_dpll_pin_type type;
+	u8 old_data = 0;
 	bool enable;
 	int ret;
 
@@ -1603,13 +1612,120 @@ ice_dpll_sma_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
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
+			goto unlock;
+		ret = ice_dpll_sw_pins_update(pf);
+		if (ret)
+			goto restore_sma_ctrl;
+
 		ret = ice_dpll_pin_enable(&pf->hw, target, d->dpll_idx, type,
 					  extack);
-	else
+		if (ret)
+			goto restore_sma_ctrl;
+		/* refresh target state first so a peer-side error cannot leave it stale */
+		ret = ice_dpll_pin_state_update(pf, target, type, extack);
+		if (ret) {
+			ice_dpll_pin_disable(&pf->hw, target, type, extack);
+			goto restore_sma_ctrl;
+		}
+
+		if (sma->muxed && sma->muxed->active) {
+			struct ice_dpll_pin *peer = sma->muxed;
+			struct ice_dpll_pin *peer_target;
+			enum ice_dpll_pin_type peer_type;
+
+			switch (peer->direction) {
+			case DPLL_PIN_DIRECTION_OUTPUT:
+				peer_target = peer->output;
+				peer_type = ICE_DPLL_PIN_TYPE_OUTPUT;
+				break;
+			case DPLL_PIN_DIRECTION_INPUT:
+				peer_target = peer->input;
+				peer_type = ICE_DPLL_PIN_TYPE_INPUT;
+				break;
+			default:
+				ret = -EINVAL;
+				goto disable_pin;
+			}
+			if (!peer_target) {
+				ret = -EINVAL;
+				goto disable_pin;
+			}
+			ret = ice_dpll_pin_enable(&pf->hw, peer_target,
+						  pf->dplls.pps.dpll_idx < ICE_DPLL_RCLK_NUM_MAX &&
+						    peer_target->state[pf->dplls.pps.dpll_idx] == DPLL_PIN_STATE_CONNECTED ?
+						  pf->dplls.pps.dpll_idx : pf->dplls.eec.dpll_idx,
+						  peer_type, extack);
+			if (!ret)
+				ret = ice_dpll_pin_state_update(pf, peer_target,
+								peer_type, extack);
+			if (ret)
+				goto disable_pin;
+		}
+	} else {
 		ret = ice_dpll_pin_disable(&pf->hw, target, type, extack);
+		if (!ret)
+			ret = ice_dpll_pin_state_update(pf, target, type,
+							extack);
+	}
+	goto unlock;
+
+disable_pin:
 	if (!ret)
-		ret = ice_dpll_pin_state_update(pf, target, type, extack);
+		ret = -EINVAL;
+	ice_dpll_pin_disable(&pf->hw, target, type, extack);
+	if (sma->muxed && sma->muxed->active) {
+		struct ice_dpll_pin *peer = sma->muxed;
+		struct ice_dpll_pin *peer_target = NULL;
+		enum ice_dpll_pin_type peer_type = ICE_DPLL_PIN_TYPE_INPUT;
+
+		switch (peer->direction) {
+		case DPLL_PIN_DIRECTION_OUTPUT:
+			peer_target = peer->output;
+			peer_type = ICE_DPLL_PIN_TYPE_OUTPUT;
+			break;
+		case DPLL_PIN_DIRECTION_INPUT:
+			peer_target = peer->input;
+			peer_type = ICE_DPLL_PIN_TYPE_INPUT;
+			break;
+		default:
+			break;
+		}
+		if (peer_target)
+			ice_dpll_pin_disable(&pf->hw, peer_target, peer_type, extack);
+	}
+restore_sma_ctrl:
+	{
+		int restore_ret;
+
+		restore_ret = ice_write_sma_ctrl(&pf->hw, old_data);
+		if (!restore_ret)
+			restore_ret = ice_dpll_sw_pins_update(pf);
+		if (restore_ret)
+			dev_warn(ice_pf_to_dev(pf),
+				 "Failed to restore SMA control after pin state error %d, restore err %d\n",
+				 ret, restore_ret);
+	}
 
 unlock:
 	mutex_unlock(&pf->dplls.lock);
-- 
2.53.0

