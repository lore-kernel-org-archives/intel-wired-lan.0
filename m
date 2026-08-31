Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCECC624A4
	for <intel-wired-lan@archiver.kernel.org>; Mon, 31 Aug 2026 14:50:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C5CB96065E;
	Mon, 31 Aug 2026 14:50:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D9aSWmEMW6my; Mon, 31 Aug 2026 14:50:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788187816;
	bh=zYtMdcuVd09fl7hF5Y+Xo2ui5BnP2mt8KG8fMQ2nlus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jj6TK5QJDdPmt1hzGtg4cfBhZD7BR6Tn+EXnhSXE03QUxqa5kdG1w0DsOD0CkY/Sb
	 qemghpa0lU8g5+zdgT6XNYLL6mXYXeX2mRJZg/sbPKgVQBCu11rG40xOKajXdIZ8lK
	 UFCw+tjvts28lPWVI3u8jPwyCFdYKuqLOV7Rx0JAGoMkmvyPlBSV7gXTONAEWx/V7O
	 700Nt2hItcB/Qpz2EK6xu2Jc93wx9ETazhkMqIyFsrb46QMdV2umwfJ4l+agKZwhhK
	 Js+SKvsEqh3itCPzfvTX7tQvJA54Gp2Bt/199LaiNe1o/N93LJRKvIz9lCaA/RjW12
	 aadz5WKAZQN6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0821C60627;
	Mon, 31 Aug 2026 14:50:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DBB382FD
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Aug 2026 14:50:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C1AA240573
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Aug 2026 14:50:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7ilLZiMSherw for <intel-wired-lan@lists.osuosl.org>;
 Mon, 31 Aug 2026 14:50:12 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=nJOLfmZQ
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D8A5F4054C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Aug 2026 14:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788187812; x=1819723812;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=43Dndlf/CDKqyjeAZwN2WFq2Ipncl1WyxMlxacvQ3i0=;
 b=nJOLfmZQn2rHSG0R828XWoT/JZSGx9h1Ysk6RumAezsdvlD4QeJYh2gB
 mcuUJ/zDVBZPCL6zL+GpvhiPtUeiKdKZMHCZ/Dv1m2VZvD0B9Z4Uui7aH
 bX86jlH4tLjLjUToqHipYNZaNYDOgsBBDihEGpl2z0xOuCGaUVUq2peK8
 ythPwUOJkmoeBCAoHAx3rGuo5+ckDi1cHps/gNr+pQAkcI1N80diiSxvb
 OiHypCUbFZU9iKoX+1K6BAzEE3PbVPoxZ++8CI1hNBakn5FyRYNDn0aWb
 Mkqn7X31xxXOeLsrtQAniEdO/omBAsaOhAd+uJBEWMX1KL9eSn4P+Alv9 w==;
X-CSE-ConnectionGUID: BQ3KC13rQfqTyLJNJX9W+g==
X-CSE-MsgGUID: zlaKjElFSNG3XQ8Zsu3qCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="76144534"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="76144534"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 07:50:12 -0700
X-CSE-ConnectionGUID: VfIfyqhIRlyeNO7Ii5/lKA==
X-CSE-MsgGUID: /YwqiRsURti3l9qmmUMb4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="273003707"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa005.jf.intel.com with ESMTP; 31 Aug 2026 07:50:11 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v5 4/6] ice: dpll: Check for bounds when updating the
 pin states
Date: Mon, 31 Aug 2026 14:50:03 +0000
Message-ID: <20260831145005.191040-5-sergey.temerkhanov@intel.com>
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

Add bounds checking code so that any potential out-of-bound
array access is avoided

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 46 +++++++++++++----------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 1c459a604acf..614e222327b3 100644
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

