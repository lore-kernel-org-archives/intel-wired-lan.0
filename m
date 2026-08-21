Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73EBC5DF7D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 21 Aug 2026 15:25:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B7A7E819BC;
	Fri, 21 Aug 2026 15:25:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wxWA3C58i_1i; Fri, 21 Aug 2026 15:25:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787325904;
	bh=nqVvuA1Qf3IhGpRpout0XlPni2DJDVK3XK0jvnacZIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ny4WlcNMSrTVMmE+GG16iyVDsGrRBQvbgD3XiFn3vvbsO9yb2PJ5n0H3jmnPxxLOg
	 lPLSpVIuqbnAXQWMtxowJhSRAj4dtV0erwGe6FHyGNsLariUyBTFpus+Wtl0lpe5BM
	 gdVMaM+V19MVRMHR2/XZ2fr2rnS4pm8NYzWMJcJc4ZE026wEFFJQk4RmatnlJB0f2W
	 10V+Ic9QWnfIAyzP7MBrriesNxFjai9XrLYI3/8k7Lli0BCWen5C6AQ/YthFI6iXLi
	 n+lbzGo87PeniC3Sug2u+u1knz6r3z5psSlWMVE2lmVos1OG0PxD3PgvObDF2kixaH
	 uDLrB7lMVORHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E91618133E;
	Fri, 21 Aug 2026 15:25:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BDB03A4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 15:25:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 71C62606A6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 15:25:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bPvHqDum4M_g for <intel-wired-lan@lists.osuosl.org>;
 Fri, 21 Aug 2026 15:25:00 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=JHdHBUlf
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 876A0605D3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 15:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787325900; x=1818861900;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5hxnhXlA5Xb/ihW/XSDFjdHywkbHy7X5nAnOsvgQnDk=;
 b=JHdHBUlfCMcpDV2oUrJXPssJ3D0NZ6sZldL0ejblKjdNudpbglbhZN7z
 qoQteD7Cj+eju8bkH4ITkHFOIiyZ03cvd7pTNzPqQsKy4Grpgo1Ti+ZuL
 RMnHFrLwcooQU9UPug6jym0OweC13WNCY3k+ukL+3r6t+wES+1Hju2p9x
 6HBdjAvbKg7Y9MZgpCkqCp/Rv2NqrY/zZoYAw0m/Zvg648VjrOWXF0bJn
 Qpj078MzHEfSUx8/8zLSKvHt3yiQxj1ZfKqDzdW42cLKs3o7XGquKKYxR
 8xGR5SzFjf/G+nK2vjtcfNszL3bflLbfD4MKIfB5mwcLBDCstTqYI79e7 w==;
X-CSE-ConnectionGUID: 0XUBqONDSgqVElYr/UhApQ==
X-CSE-MsgGUID: 787QDZO/SrOCH+BsFaVxsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="91553206"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; d="scan'208";a="91553206"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 08:24:59 -0700
X-CSE-ConnectionGUID: jki8o265TRmCNeX4bVD4wQ==
X-CSE-MsgGUID: PcxvA5+LTGC09KsTzn/n1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; d="scan'208";a="270602193"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa005.jf.intel.com with ESMTP; 21 Aug 2026 08:24:58 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v3 4/6] ice: dpll: Check for bounds when updating the
 pin states
Date: Fri, 21 Aug 2026 15:24:52 +0000
Message-ID: <20260821152454.3703979-5-sergey.temerkhanov@intel.com>
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

Add bounds checking code so that any potential out-of-bound
array access is avoided

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 76 ++++++++++++++---------
 1 file changed, 48 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index f4d6c247e96e..d0225097cd10 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -760,6 +760,9 @@ ice_dpll_pin_state_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
 	u8 parent, port_num = ICE_AQC_SET_PHY_REC_CLK_OUT_CURR_PORT;
 	int ret;
 
+	for (int i = 0; i < ICE_DPLL_RCLK_NUM_MAX; i++)
+		pin->state[i] = DPLL_PIN_STATE_DISCONNECTED;
+
 	switch (pin_type) {
 	case ICE_DPLL_PIN_TYPE_INPUT:
 		ret = ice_aq_get_input_pin_cfg(&pf->hw, pin->idx, &pin->status,
@@ -769,25 +772,31 @@ ice_dpll_pin_state_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
 			goto err;
 		if (ICE_AQC_GET_CGU_IN_CFG_FLG2_INPUT_EN & pin->flags[0]) {
 			if (pin->pin) {
-				pin->state[pf->dplls.eec.dpll_idx] =
-					pin->pin == pf->dplls.eec.active_input ?
-					DPLL_PIN_STATE_CONNECTED :
-					DPLL_PIN_STATE_SELECTABLE;
-				pin->state[pf->dplls.pps.dpll_idx] =
-					pin->pin == pf->dplls.pps.active_input ?
-					DPLL_PIN_STATE_CONNECTED :
-					DPLL_PIN_STATE_SELECTABLE;
+				if (pf->dplls.eec.dpll_idx < ICE_DPLL_RCLK_NUM_MAX)
+					pin->state[pf->dplls.eec.dpll_idx] =
+						pin->pin == pf->dplls.eec.active_input ?
+						DPLL_PIN_STATE_CONNECTED :
+						DPLL_PIN_STATE_SELECTABLE;
+				if (pf->dplls.pps.dpll_idx < ICE_DPLL_RCLK_NUM_MAX)
+					pin->state[pf->dplls.pps.dpll_idx] =
+						pin->pin == pf->dplls.pps.active_input ?
+						DPLL_PIN_STATE_CONNECTED :
+						DPLL_PIN_STATE_SELECTABLE;
 			} else {
-				pin->state[pf->dplls.eec.dpll_idx] =
-					DPLL_PIN_STATE_SELECTABLE;
-				pin->state[pf->dplls.pps.dpll_idx] =
-					DPLL_PIN_STATE_SELECTABLE;
+				if (pf->dplls.eec.dpll_idx < ICE_DPLL_RCLK_NUM_MAX)
+					pin->state[pf->dplls.eec.dpll_idx] =
+						DPLL_PIN_STATE_SELECTABLE;
+				if (pf->dplls.pps.dpll_idx < ICE_DPLL_RCLK_NUM_MAX)
+					pin->state[pf->dplls.pps.dpll_idx] =
+						DPLL_PIN_STATE_SELECTABLE;
 			}
 		} else {
-			pin->state[pf->dplls.eec.dpll_idx] =
-				DPLL_PIN_STATE_DISCONNECTED;
-			pin->state[pf->dplls.pps.dpll_idx] =
-				DPLL_PIN_STATE_DISCONNECTED;
+			if (pf->dplls.eec.dpll_idx < ICE_DPLL_RCLK_NUM_MAX)
+				pin->state[pf->dplls.eec.dpll_idx] =
+					DPLL_PIN_STATE_DISCONNECTED;
+			if (pf->dplls.pps.dpll_idx < ICE_DPLL_RCLK_NUM_MAX)
+				pin->state[pf->dplls.pps.dpll_idx] =
+					DPLL_PIN_STATE_DISCONNECTED;
 		}
 		break;
 	case ICE_DPLL_PIN_TYPE_OUTPUT:
@@ -799,19 +808,23 @@ ice_dpll_pin_state_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
 
 		parent &= ICE_AQC_GET_CGU_OUT_CFG_DPLL_SRC_SEL;
 		if (ICE_AQC_GET_CGU_OUT_CFG_OUT_EN & pin->flags[0]) {
-			pin->state[pf->dplls.eec.dpll_idx] =
-				parent == pf->dplls.eec.dpll_idx ?
-				DPLL_PIN_STATE_CONNECTED :
-				DPLL_PIN_STATE_DISCONNECTED;
-			pin->state[pf->dplls.pps.dpll_idx] =
-				parent == pf->dplls.pps.dpll_idx ?
-				DPLL_PIN_STATE_CONNECTED :
-				DPLL_PIN_STATE_DISCONNECTED;
+			if (pf->dplls.eec.dpll_idx < ICE_DPLL_RCLK_NUM_MAX)
+				pin->state[pf->dplls.eec.dpll_idx] =
+					parent == pf->dplls.eec.dpll_idx ?
+					DPLL_PIN_STATE_CONNECTED :
+					DPLL_PIN_STATE_DISCONNECTED;
+			if (pf->dplls.pps.dpll_idx < ICE_DPLL_RCLK_NUM_MAX)
+				pin->state[pf->dplls.pps.dpll_idx] =
+					parent == pf->dplls.pps.dpll_idx ?
+					DPLL_PIN_STATE_CONNECTED :
+					DPLL_PIN_STATE_DISCONNECTED;
 		} else {
-			pin->state[pf->dplls.eec.dpll_idx] =
-				DPLL_PIN_STATE_DISCONNECTED;
-			pin->state[pf->dplls.pps.dpll_idx] =
-				DPLL_PIN_STATE_DISCONNECTED;
+			if (pf->dplls.eec.dpll_idx < ICE_DPLL_RCLK_NUM_MAX)
+				pin->state[pf->dplls.eec.dpll_idx] =
+					DPLL_PIN_STATE_DISCONNECTED;
+			if (pf->dplls.pps.dpll_idx < ICE_DPLL_RCLK_NUM_MAX)
+				pin->state[pf->dplls.pps.dpll_idx] =
+					DPLL_PIN_STATE_DISCONNECTED;
 		}
 		break;
 	case ICE_DPLL_PIN_TYPE_RCLK_INPUT:
@@ -5180,6 +5193,13 @@ static int ice_dpll_init_info(struct ice_pf *pf, bool cgu)
 
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

