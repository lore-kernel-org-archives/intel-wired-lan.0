Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53D7C624A5
	for <intel-wired-lan@archiver.kernel.org>; Mon, 31 Aug 2026 14:50:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7EDB180BBD;
	Mon, 31 Aug 2026 14:50:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jvzenOsd8EVs; Mon, 31 Aug 2026 14:50:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788187813;
	bh=iJggktwJAhPQvI/3YstZK694yCa65MIPF6QGa7HNaPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=8iI35SzTS6mzZ69iRtb1MNcw8Xs9SCLAbrJlmmjeV9tHvZtEXZq2ryN0UQuhoUSNy
	 9fjtgB/0J1uXxFMaFUDg1UMyS1Ug73O7AckBKrl1tS5c2zeSklfSqyzYn9HW8MZWyO
	 zcxmvu7nJiJHRuWOLg/DUFSq8UWLeWK2KhLLcVa5gIIroMGdoUBbxLFpg9LzlyAiaw
	 qXDi6xaE75FkF+dV12iB5nUEmz7TpYmd9cIsAfTnjwGCnSn3i0XSnajiYNmUTULqOi
	 zg7D9PiL5B4kOkRYWzuHCjaj3Ox9pZTz+6JOV2+pVDMyXnm/NBmYL3G4i0LbGOmwxf
	 7Qm7VdiFQRuCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC61880BF1;
	Mon, 31 Aug 2026 14:50:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CBA9A2FC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Aug 2026 14:50:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B21364054C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Aug 2026 14:50:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wIp3YYUESFCq for <intel-wired-lan@lists.osuosl.org>;
 Mon, 31 Aug 2026 14:50:10 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=V/yHwE6n
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BC8B640578
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Aug 2026 14:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788187811; x=1819723811;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZAybZuVwcDoGum5Ms2lssgsLXlQLiQTyVjGd/GvEhB8=;
 b=V/yHwE6n0YbPJCZUl5eKWuzrdZ/5tFzLfJJM6uJVABGz5Q5Xnw4NLkHx
 8APQB8BR29hNPLEL2nR+FFIJ3GqnuQVeOyJd9VHwBIY19EALe2lor0R4X
 YLRpzfme+4XCgGPXdM3PldVY3qUxXZJLafZCYC8YzQRHTHOR0ijP0sWwO
 dAUUFMVUDEf8+Ux2VYIe8enJ+HzuQVhDULuQGO2XHwBfOWL90QW1xKnUY
 qQfihjUvbTY7tJGDLxx83bift8mT0rWjWAJhHw9pm8r5dHTyicFQCSHGa
 lAUi7+RUMj4X4lJPprpkRod/YFg3Db2/AkvFqhpQ9FYg2CUc6911fpDBU Q==;
X-CSE-ConnectionGUID: 9pN2B70kTxWD0nZWIOAP8w==
X-CSE-MsgGUID: 9+ZsnDh1Qy2CT/S9EZDCoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="76144531"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="76144531"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 07:50:11 -0700
X-CSE-ConnectionGUID: p6wQqPYaSvCrPi1ypw+7tQ==
X-CSE-MsgGUID: jYg+gAqaRK2IOvZeMnACvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="273003701"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa005.jf.intel.com with ESMTP; 31 Aug 2026 07:50:10 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v5 3/6] ice: dpll: Use switch statements to handle
 pin states
Date: Mon, 31 Aug 2026 14:50:02 +0000
Message-ID: <20260831145005.191040-4-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831145005.191040-1-sergey.temerkhanov@intel.com>
References: <20260831145005.191040-1-sergey.temerkhanov@intel.com>
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
 drivers/net/ethernet/intel/ice/ice_dpll.c | 72 ++++++++++++++++++-----
 1 file changed, 57 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index ac1a034b7353..1c459a604acf 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -1338,10 +1338,12 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
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
@@ -1352,18 +1354,21 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
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
@@ -1375,7 +1380,8 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 			}
 			data |= ICE_SMA2_UFL2_RX_DIS;
 			enable = false;
-		} else {
+			break;
+		default:
 			goto unlock;
 		}
 		target = p->input;
@@ -1497,19 +1503,49 @@ ice_dpll_sma_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 		return -EBUSY;
 
 	mutex_lock(&pf->dplls.lock);
-	if (!sma->active) {
-		ret = ice_dpll_sma_direction_set(sma, sma->direction, extack);
-		if (ret)
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
 			goto unlock;
+		}
+		enable = true;
+		break;
+	case DPLL_PIN_STATE_DISCONNECTED:
+		enable = false;
+		break;
+	default:
+		ret = -EINVAL;
+		goto unlock;
 	}
-	if (sma->direction == DPLL_PIN_DIRECTION_INPUT) {
-		enable = state == DPLL_PIN_STATE_SELECTABLE;
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
+	}
+
+	if (!sma->active) {
+		ret = ice_dpll_sma_direction_set(sma, sma->direction, extack);
+		if (ret)
+			goto unlock;
 	}
 
 	if (enable)
@@ -4917,7 +4953,8 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf *pf)
 		pin->prop.capabilities = caps;
 		pin->pf = pf;
 		pin->prop.board_label = ice_dpll_sw_pin_ufl[i];
-		if (i == ICE_DPLL_PIN_SW_1_IDX) {
+		switch (i) {
+		case ICE_DPLL_PIN_SW_1_IDX:
 			pin->direction = DPLL_PIN_DIRECTION_OUTPUT;
 			pin_abs_idx = ICE_DPLL_PIN_SW_OUTPUT_ABS(i);
 			pin->prop.freq_supported =
@@ -4927,7 +4964,8 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf *pf)
 			pin->prop.freq_supported_num = freq_supp_num;
 			pin->input = NULL;
 			pin->output = &d->outputs[pin_abs_idx];
-		} else if (i == ICE_DPLL_PIN_SW_2_IDX) {
+			break;
+		case ICE_DPLL_PIN_SW_2_IDX:
 			pin->direction = DPLL_PIN_DIRECTION_INPUT;
 			pin_abs_idx = ICE_DPLL_PIN_SW_INPUT_ABS(i) +
 				      input_idx_offset;
@@ -4940,6 +4978,10 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf *pf)
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

