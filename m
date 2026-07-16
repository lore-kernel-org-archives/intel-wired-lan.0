Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CC5C4450E
	for <intel-wired-lan@archiver.kernel.org>; Thu, 16 Jul 2026 09:49:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB8CE407BE;
	Thu, 16 Jul 2026 09:49:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2W47vwT73pCl; Thu, 16 Jul 2026 09:49:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F317407BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784195359;
	bh=zkxysaqNwZ2FhtLeQoc+14qy/XJSKIm9AXZ/PXZWebs=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QJIj922goj69wZa6aRgQfGUC/TfYrZt9itBx7e1wVcul9+i8Snt3/iIx8D/tXYt6M
	 AEYeQ6xinuI8E9uYqqnYZQI06llPbxYosMtdrIDac5Kvok5KRwY2boOvOfp1FKGzG6
	 Xn6xwcLtIPVF5xzRrJDLJ4AShdds/8yxQHgXMIK/waI2Fxbu94tm4A9BqxaZFDnfsK
	 p8hNEDkyyr9kzyfkVjZVkXKIik5G6KXNxmW/2I9uZbksTEodp/QmrRObJHymR+/pCG
	 Fl9L3L+g1bwfA4gvWHmm59G/H8GHX+udiqtaxMaVRwC6isTVh+ji69BKgA+NXmiTiQ
	 1/2TVt5pxALZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F317407BA;
	Thu, 16 Jul 2026 09:49:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 083A51F6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 09:49:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EEAE980E59
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 09:49:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mETDpFxSbIKw for <intel-wired-lan@lists.osuosl.org>;
 Thu, 16 Jul 2026 09:49:16 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 04FCC80E57
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 04FCC80E57
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 04FCC80E57
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 09:49:15 +0000 (UTC)
X-CSE-ConnectionGUID: Tiapz/f4SEymspVF8YDMZw==
X-CSE-MsgGUID: XJjR62gSTH+f9pbZ8UWDOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84963879"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="84963879"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 02:49:16 -0700
X-CSE-ConnectionGUID: bZ3Iz6MdQv6DLFWTy+WwTQ==
X-CSE-MsgGUID: 5CwZwszcQymarUbPFJwuIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="256501626"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa007.jf.intel.com with ESMTP; 16 Jul 2026 02:49:15 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Date: Thu, 16 Jul 2026 09:49:09 +0000
Message-ID: <20260716094912.1210865-3-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716094912.1210865-1-sergey.temerkhanov@intel.com>
References: <20260716094912.1210865-1-sergey.temerkhanov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784195356; x=1815731356;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=x0Y0oi6/jFtaDBYf9V64hgE8ooBJwU7IE0C8/sMtcWQ=;
 b=EAGlCw1UEKeAMFvx2u5lF1uxY7Z5nQoM0gCqtS0PlNRewHAI4vln70xj
 A8UoOhaRwpIGqwZy98w3xz7cvMjMIAs5nzXze5n3nNZLqQJNgEedRd36Y
 1IekAo4OmmAu+3x4X3NRUdi3lFUEpy8QB+JscZCV3yl9ophPcKGWibp3a
 TrHqDtHGZDMrBXq+wiKwjzCaFSqMYRipW1HmsTzZJLorRyd+2hjQZK1h3
 yYi0oLTKR3awiOp8FuLUOgPXEEZGzZ6qH21ksgMC2s5d5/UP7iUQaZtB7
 QqkSplliPYZRqZDVlA2yAV9IS/rdtx5P4f0pBoeWf0fhiZa4ydHCpCTKX
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=EAGlCw1U
Subject: [Intel-wired-lan] [PATCH iwl-next v1 2/4] ice: dpll: Use switch
 statements to handle pin states
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

Use switch statements to handle pin states to make the code more
readable. This also makes this code more future-proof, should any
new states appear.

This also changes how direction-mismatched state requests are handled in
ice_dpll_sma_pin_state_set(). Previously, requesting CONNECTED on an
INPUT-direction SMA pin or SELECTABLE on an OUTPUT-direction pin would
fall through to ice_dpll_pin_disable() and return success. After this
change those requests return -EINVAL without issuing a firmware command.
Because the DPLL netlink core does not filter pin states by direction
before calling the driver, this is a user-visible netlink API change.

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 65 ++++++++++++++++++-----
 1 file changed, 53 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index fed7c9fea953..54958e17713b 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -1320,10 +1320,12 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 	ret = -EINVAL;
 	switch (p->idx) {
 	case ICE_DPLL_PIN_SW_1_IDX:
-		if (state == DPLL_PIN_STATE_CONNECTED) {
+		switch (state) {
+		case DPLL_PIN_STATE_CONNECTED:
 			data &= ~ICE_SMA1_MASK;
 			enable = true;
-		} else if (state == DPLL_PIN_STATE_DISCONNECTED) {
+			break;
+		case DPLL_PIN_STATE_DISCONNECTED:
 			/* Skip if U.FL1 is not active, setting TX_EN
 			 * while DIR_EN is set would also deactivate
 			 * the paired SMA1 output.
@@ -1334,18 +1336,21 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 			}
 			data |= ICE_SMA1_TX_EN;
 			enable = false;
-		} else {
+			break;
+		default:
 			goto unlock;
 		}
 		target = p->output;
 		type = ICE_DPLL_PIN_TYPE_OUTPUT;
 		break;
 	case ICE_DPLL_PIN_SW_2_IDX:
-		if (state == DPLL_PIN_STATE_SELECTABLE) {
+		switch (state) {
+		case DPLL_PIN_STATE_SELECTABLE:
 			data |= ICE_SMA2_DIR_EN;
 			data &= ~ICE_SMA2_UFL2_RX_DIS;
 			enable = true;
-		} else if (state == DPLL_PIN_STATE_DISCONNECTED) {
+			break;
+		case DPLL_PIN_STATE_DISCONNECTED:
 			/* Skip if U.FL2 is not active, setting
 			 * UFL2_RX_DIS could also disable the paired
 			 * SMA2 input.
@@ -1357,7 +1362,8 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 			}
 			data |= ICE_SMA2_UFL2_RX_DIS;
 			enable = false;
-		} else {
+			break;
+		default:
 			goto unlock;
 		}
 		target = p->input;
@@ -1484,14 +1490,43 @@ ice_dpll_sma_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 		if (ret)
 			goto unlock;
 	}
-	if (sma->direction == DPLL_PIN_DIRECTION_INPUT) {
-		enable = state == DPLL_PIN_STATE_SELECTABLE;
+	switch (state) {
+	case DPLL_PIN_STATE_SELECTABLE:
+		if (sma->direction == DPLL_PIN_DIRECTION_OUTPUT) {
+			enable = false;
+			ret = -EINVAL;
+			goto unlock;
+		}
+		enable = true;
+		break;
+	case DPLL_PIN_STATE_CONNECTED:
+		if (sma->direction == DPLL_PIN_DIRECTION_INPUT) {
+			enable = false;
+			ret = -EINVAL;
+			goto unlock;
+		}
+		enable = true;
+		break;
+	case DPLL_PIN_STATE_DISCONNECTED:
+		enable = false;
+		break;
+	default:
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	switch (sma->direction) {
+	case DPLL_PIN_DIRECTION_INPUT:
 		target = sma->input;
 		type = ICE_DPLL_PIN_TYPE_INPUT;
-	} else {
-		enable = state == DPLL_PIN_STATE_CONNECTED;
+		break;
+	case DPLL_PIN_DIRECTION_OUTPUT:
 		target = sma->output;
 		type = ICE_DPLL_PIN_TYPE_OUTPUT;
+		break;
+	default:
+		ret = -EINVAL;
+		goto unlock;
 	}
 
 	if (enable)
@@ -4631,7 +4666,8 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf *pf)
 		pin->prop.capabilities = caps;
 		pin->pf = pf;
 		pin->prop.board_label = ice_dpll_sw_pin_ufl[i];
-		if (i == ICE_DPLL_PIN_SW_1_IDX) {
+		switch (i) {
+		case ICE_DPLL_PIN_SW_1_IDX:
 			pin->direction = DPLL_PIN_DIRECTION_OUTPUT;
 			pin_abs_idx = ICE_DPLL_PIN_SW_OUTPUT_ABS(i);
 			pin->prop.freq_supported =
@@ -4641,7 +4677,8 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf *pf)
 			pin->prop.freq_supported_num = freq_supp_num;
 			pin->input = NULL;
 			pin->output = &d->outputs[pin_abs_idx];
-		} else if (i == ICE_DPLL_PIN_SW_2_IDX) {
+			break;
+		case ICE_DPLL_PIN_SW_2_IDX:
 			pin->direction = DPLL_PIN_DIRECTION_INPUT;
 			pin_abs_idx = ICE_DPLL_PIN_SW_INPUT_ABS(i) +
 				      input_idx_offset;
@@ -4654,6 +4691,10 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf *pf)
 			pin->prop.capabilities =
 				(DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |
 				 caps);
+			break;
+		default:
+			dev_err(ice_pf_to_dev(pf), "Invalid U.FL pin index: %d\n", i);
+			return -EINVAL;
 		}
 		pin->muxed = &d->sma[i];
 		ice_dpll_phase_range_set(&pin->prop.phase_range, phase_adj_max);
-- 
2.53.0

