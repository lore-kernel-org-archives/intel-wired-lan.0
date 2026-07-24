Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B86FC53200
	for <intel-wired-lan@archiver.kernel.org>; Fri, 24 Jul 2026 12:14:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51FDE40B1C;
	Fri, 24 Jul 2026 12:14:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7eU_x5RppuFt; Fri, 24 Jul 2026 12:13:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 62ADC40AC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784895239;
	bh=zkxysaqNwZ2FhtLeQoc+14qy/XJSKIm9AXZ/PXZWebs=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ToTBwS95Ld/dEyCilU5vX1+B3Mi5xmtkr9Y6t6OhxZVIdR/YN2xbzTpNNxaANaHuS
	 EXTd8nEc4arfxzgkItHRx5FqgjJrYN+stjdSLrn+VS2guC54lYTNE67xqWAcyTWDwr
	 IZ+6q1pm22TYTcqrG9CsC51TsOiseelFdzSUPAS5HvfqL/c91/SRhS1/v4j1JNg+uh
	 JmY5eDwqc//xK9gg/+Z23ph/MM6grX1IvTRSgMaPlEHGElRlIhrOwfUMNV1kR5QaRd
	 6cxowNcwwv1+Hr1dSLLIv4B8VLLGarYeE5Ya8sjnVkysfmmTql74kms2FTJvUIzoJr
	 VEo9z2co90tpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62ADC40AC1;
	Fri, 24 Jul 2026 12:13:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BA86D3B0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Jul 2026 12:13:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AC07A40396
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Jul 2026 12:13:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bPl366IGDqn2 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 24 Jul 2026 12:13:56 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D1619404CA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D1619404CA
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D1619404CA
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Jul 2026 12:13:54 +0000 (UTC)
X-CSE-ConnectionGUID: B68ArIIcQnqnQ0LQWZFg2g==
X-CSE-MsgGUID: PGWgEU6+R7uBobgXDuVqHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="84686074"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; d="scan'208";a="84686074"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2026 05:13:54 -0700
X-CSE-ConnectionGUID: 8E/Vb+mERQ+DRZqLEZyjlQ==
X-CSE-MsgGUID: 7o0ElYf/RHKpIaIVADQOtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; d="scan'208";a="252367703"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by fmviesa009.fm.intel.com with ESMTP; 24 Jul 2026 05:13:53 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Date: Fri, 24 Jul 2026 12:13:48 +0000
Message-ID: <20260724121350.1565330-3-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724121350.1565330-1-sergey.temerkhanov@intel.com>
References: <20260724121350.1565330-1-sergey.temerkhanov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784895236; x=1816431236;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=x0Y0oi6/jFtaDBYf9V64hgE8ooBJwU7IE0C8/sMtcWQ=;
 b=BHi3/BpQbe2Cm3IftKDrMPCfJWfDCdb6PLYKEp9CW6TuWLP2jChRLaVx
 Whjo/Ueqtnpkwu8mTQTfaK1WRbCaQm6CM88ZTJKlA/okY/52rv87s0OBA
 FVrZRX7UgAuePyg5UDUHo1Q49zVXePCkJ8DoYRlYnQgly9pGZrY+Xt6iO
 cXYxeQdQUjiDhWDuVeDfCbkry+YN/pQS4YIhrLzcB915PKf60P8TE/Z5s
 RnzHHpERzpUSmTbaiLG19MfX36CGLBaDJHjBk2tIhpI9fMwghFZICbc8P
 w3DmD4AzkiSPjXextzPZVeEtctieOYiCl3fYAG7iTsZMCjHBngHWDpDPA
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=BHi3/BpQ
Subject: [Intel-wired-lan] [PATCH iwl-next v2 2/4] ice: dpll: Use switch
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

