Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A983DC61DC7
	for <intel-wired-lan@archiver.kernel.org>; Wed, 26 Aug 2026 09:49:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66F0480B6E;
	Wed, 26 Aug 2026 09:49:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7vDZwTyhbJz8; Wed, 26 Aug 2026 09:48:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787737739;
	bh=IrW2vHc0dQ7S5sZwzI8pwVHgf+sz/W2oeEHbHBb8Mn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s2OvVU0mktR+ZrZ32nn21AaPiTbWnDuAcBNocrDv+q0i8fatqO6FKmPrvxfit912x
	 3S0FkovtFfTHPXE8Q/FljBFQACcu494aKQSgozGDDuvBXqRujklIhiwV7VJEcS/6HJ
	 Uttz7BZFB1NbKNcy79QAbSDmNkmLYYrEf9KU6LETIKnA5WDNV5G1NMFqp1QhVKECAg
	 h9R0S6u/JcypYpcPFjp0aMI9S1aO4h32cykk/lbExjbGFWAtwzPXWiyhu3QEsTthp0
	 wXt8p/BKjbOjdLLE0fuztbSVxha3eZuaXpIdQ/pawCtxqKG6U7aX9A/ldEr7GO/FIR
	 EaumDcsqBtXJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B03D080962;
	Wed, 26 Aug 2026 09:48:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6FD463C3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 09:48:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5620940532
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 09:48:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lzGUP7DZf8xm for <intel-wired-lan@lists.osuosl.org>;
 Wed, 26 Aug 2026 09:48:55 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=eBITaaQ1
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 96A0640557
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 09:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787737736; x=1819273736;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+h3AlGKrgxCjxVVRZxD+Up7aWMC3JsD2ay1MaLwTx1c=;
 b=eBITaaQ1rCVfgvZP4YjIGgKJ3Fuhw1TspD73Y1T2hl05A9+DZfKjkwf8
 yet4dGKBNtt+pK4ld1JiYV23BfGXUnsSPhg/SHPwoVRce6wmrhj45QKrM
 gySq8D44Kr8AGYSiI9m9G5NtmVycK/552/alylCjjJAXv5ax4g9GSl5VJ
 ndWpVxlYG6pi8ZtaEQIhpIEKeUgFOrfRzGK0JLyTvVY5jl7vpP/Qa4qL8
 WQn8Ct1Hw9kata4HwvkOybuuzh7A98yE3/8c/z05lZRjq8eWeCeURfqhP
 B7HSe51zcVyuqtxDlzPiOxAH80KcURfNvigNP0Astv580VQm9KWu5GZef A==;
X-CSE-ConnectionGUID: F8eyBJqqQb6ho9Jake7rYw==
X-CSE-MsgGUID: yVaVJQ4PQL2mgjK7lNAUSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88232958"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="88232958"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2026 02:48:55 -0700
X-CSE-ConnectionGUID: wsnH4h7PT+yL4L0hqjElcQ==
X-CSE-MsgGUID: fBB5Kng5RLGRiYst/g/d4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="261404817"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by fmviesa009.fm.intel.com with ESMTP; 26 Aug 2026 02:48:54 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v4 4/6] ice: dpll: Check for bounds when updating the
 pin states
Date: Wed, 26 Aug 2026 09:48:47 +0000
Message-ID: <20260826094849.4112016-5-sergey.temerkhanov@intel.com>
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

Add bounds checking code so that any potential out-of-bound
array access is avoided

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 46 +++++++++++++----------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index f4d6c247e96e..e80460aeac11 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -758,6 +758,8 @@ ice_dpll_pin_state_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
 			  struct netlink_ext_ack *extack)
 {
 	u8 parent, port_num = ICE_AQC_SET_PHY_REC_CLK_OUT_CURR_PORT;
+	enum dpll_pin_state eec_state = DPLL_PIN_STATE_DISCONNECTED;
+	enum dpll_pin_state pps_state = DPLL_PIN_STATE_DISCONNECTED;
 	int ret;
 
 	switch (pin_type) {
@@ -769,26 +771,26 @@ ice_dpll_pin_state_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
 			goto err;
 		if (ICE_AQC_GET_CGU_IN_CFG_FLG2_INPUT_EN & pin->flags[0]) {
 			if (pin->pin) {
-				pin->state[pf->dplls.eec.dpll_idx] =
+				eec_state =
 					pin->pin == pf->dplls.eec.active_input ?
 					DPLL_PIN_STATE_CONNECTED :
 					DPLL_PIN_STATE_SELECTABLE;
-				pin->state[pf->dplls.pps.dpll_idx] =
+				pps_state =
 					pin->pin == pf->dplls.pps.active_input ?
 					DPLL_PIN_STATE_CONNECTED :
 					DPLL_PIN_STATE_SELECTABLE;
 			} else {
-				pin->state[pf->dplls.eec.dpll_idx] =
-					DPLL_PIN_STATE_SELECTABLE;
-				pin->state[pf->dplls.pps.dpll_idx] =
-					DPLL_PIN_STATE_SELECTABLE;
+				eec_state = DPLL_PIN_STATE_SELECTABLE;
+				pps_state = DPLL_PIN_STATE_SELECTABLE;
 			}
-		} else {
-			pin->state[pf->dplls.eec.dpll_idx] =
-				DPLL_PIN_STATE_DISCONNECTED;
-			pin->state[pf->dplls.pps.dpll_idx] =
-				DPLL_PIN_STATE_DISCONNECTED;
 		}
+		/* Commit only after a successful read so lockless readers never
+		 * observe a transient disconnected state.
+		 */
+		if (pf->dplls.eec.dpll_idx < ICE_DPLL_RCLK_NUM_MAX)
+			pin->state[pf->dplls.eec.dpll_idx] = eec_state;
+		if (pf->dplls.pps.dpll_idx < ICE_DPLL_RCLK_NUM_MAX)
+			pin->state[pf->dplls.pps.dpll_idx] = pps_state;
 		break;
 	case ICE_DPLL_PIN_TYPE_OUTPUT:
 		ret = ice_aq_get_output_pin_cfg(&pf->hw, pin->idx,
@@ -799,20 +801,17 @@ ice_dpll_pin_state_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
 
 		parent &= ICE_AQC_GET_CGU_OUT_CFG_DPLL_SRC_SEL;
 		if (ICE_AQC_GET_CGU_OUT_CFG_OUT_EN & pin->flags[0]) {
-			pin->state[pf->dplls.eec.dpll_idx] =
-				parent == pf->dplls.eec.dpll_idx ?
+			eec_state = parent == pf->dplls.eec.dpll_idx ?
 				DPLL_PIN_STATE_CONNECTED :
 				DPLL_PIN_STATE_DISCONNECTED;
-			pin->state[pf->dplls.pps.dpll_idx] =
-				parent == pf->dplls.pps.dpll_idx ?
+			pps_state = parent == pf->dplls.pps.dpll_idx ?
 				DPLL_PIN_STATE_CONNECTED :
 				DPLL_PIN_STATE_DISCONNECTED;
-		} else {
-			pin->state[pf->dplls.eec.dpll_idx] =
-				DPLL_PIN_STATE_DISCONNECTED;
-			pin->state[pf->dplls.pps.dpll_idx] =
-				DPLL_PIN_STATE_DISCONNECTED;
 		}
+		if (pf->dplls.eec.dpll_idx < ICE_DPLL_RCLK_NUM_MAX)
+			pin->state[pf->dplls.eec.dpll_idx] = eec_state;
+		if (pf->dplls.pps.dpll_idx < ICE_DPLL_RCLK_NUM_MAX)
+			pin->state[pf->dplls.pps.dpll_idx] = pps_state;
 		break;
 	case ICE_DPLL_PIN_TYPE_RCLK_INPUT:
 		if (pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825) {
@@ -5180,6 +5179,13 @@ static int ice_dpll_init_info(struct ice_pf *pf, bool cgu)
 
 	de->dpll_idx = abilities.eec_dpll_idx;
 	dp->dpll_idx = abilities.pps_dpll_idx;
+	if (de->dpll_idx >= ICE_DPLL_RCLK_NUM_MAX ||
+	    dp->dpll_idx >= ICE_DPLL_RCLK_NUM_MAX) {
+		dev_err(ice_pf_to_dev(pf),
+			"invalid dpll_idx in cgu abilities: eec=%u, pps=%u\n",
+			de->dpll_idx, dp->dpll_idx);
+		return -EINVAL;
+	}
 	d->num_inputs = abilities.num_inputs;
 	d->num_outputs = abilities.num_outputs;
 	d->input_phase_adj_max = le32_to_cpu(abilities.max_in_phase_adj) &
-- 
2.53.0

