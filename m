Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCB6C531F9
	for <intel-wired-lan@archiver.kernel.org>; Fri, 24 Jul 2026 12:13:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3BEA40B10;
	Fri, 24 Jul 2026 12:13:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id he67jb91XiS1; Fri, 24 Jul 2026 12:13:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D29D340B06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784895237;
	bh=0J18l/UFLc95AYpsSzHBvWyhLlKS4LfIq0SgWE03fEU=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=atyFxwy+QmIfMFNXAAL8X3rScy+lXtvr8YehPYBZKNIhwW1C1bmENWMOup5ad2dlu
	 qrjzM+vvJz+CC9yDV4dqxLuE6Ud4LeDmR6GlY/8NQ8yvyhy7VBnqUlBbnUFamapH7k
	 KorJllFkUArgjvu87384vW9XkqZ1wmbTJWsLuzeLoGVqchOPNbPq0nBOOuHCmMVb8+
	 BmDGE59Q4JRIRPDiLcL4efsnPpk37k42LdcaqV+dC0JAt5+zvpGOlgUNh+pc+MxJ9l
	 6r7ZFjD7jjetmItd2HWtuiYYZrSb5Sou0uYNqspLZzTPp/AslAjeCNGv1ABjM0edAS
	 3tJd6QrZuNNDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D29D340B06;
	Fri, 24 Jul 2026 12:13:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E8CE83B0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Jul 2026 12:13:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CF72A404CE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Jul 2026 12:13:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cW_DHuvCoUF9 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 24 Jul 2026 12:13:56 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9457240396
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9457240396
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9457240396
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Jul 2026 12:13:55 +0000 (UTC)
X-CSE-ConnectionGUID: HHZ7/5u6QV+/ophvMTvAMA==
X-CSE-MsgGUID: s1nPVhVFQiWEh8Ro+Rmg9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="84686077"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; d="scan'208";a="84686077"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2026 05:13:55 -0700
X-CSE-ConnectionGUID: koCgI1vyTl+kpVD12YZndg==
X-CSE-MsgGUID: iWSifpX/QPGq+you6SdqcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; d="scan'208";a="252367705"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by fmviesa009.fm.intel.com with ESMTP; 24 Jul 2026 05:13:54 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Date: Fri, 24 Jul 2026 12:13:49 +0000
Message-ID: <20260724121350.1565330-4-sergey.temerkhanov@intel.com>
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
 bh=fW4um8qozIDoVKGhh05w0Iwe35alS3ohczF4Q21jOiM=;
 b=OFKqEMxRCvnALyrMa68gTNPk9HldpN4+mP+Pyg+v9wTxrbZqEyaJFO8l
 VIbeoT5xX0oACe1w3TYAbwwL7QKkxLVAJ56wenuwKqS23QPtIcfRWYEJk
 y5j3FKHJVYXlW8kmFvmNwPu4QOA/QwN44JeCU3cmbSeuzUnu+IJtm1eRw
 tZAj2LPsCuuvihK5n88wCwtlbAROllyeuRbNG7OQp2an1XtQeMdnC8Dp+
 /P+6UDPwJEomUO/7twkGZwI4qB+B7JvxB8SmPyz+JMOb/Sj4iGdkQ6Sdz
 OAAQYk0ZAEg8Y/Vpek5X8TAcJUgKo7LcaRe/XUGX8YME48tXTrcwpFRKv
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OFKqEMxR
Subject: [Intel-wired-lan] [PATCH iwl-next v2 3/4] ice: dpll: Rework U.FL
 muxed pin (SMA) control
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

Rework multiplexed pin control to match the state change listed in
the design requirements.

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 86 +++++++++++++++++++++--
 1 file changed, 80 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 54958e17713b..cf54a7f2f836 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -1268,7 +1268,8 @@ static int ice_dpll_sma_direction_set(struct ice_dpll_pin *p,
 			type = ICE_DPLL_PIN_TYPE_INPUT;
 		}
 		ret = ice_dpll_pin_enable(&p->pf->hw, target,
-					  d->eec.dpll_idx, type, extack);
+					  d->pps.dpll_idx < ICE_DPLL_RCLK_NUM_MAX && target->state[d->pps.dpll_idx] == DPLL_PIN_STATE_CONNECTED ?
+					  d->pps.dpll_idx : d->eec.dpll_idx, type, extack);
 		if (!ret)
 			ret = ice_dpll_pin_state_update(p->pf, target,
 							type, extack);
@@ -1304,6 +1305,7 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 	enum ice_dpll_pin_type type;
 	struct ice_pf *pf = p->pf;
 	struct ice_hw *hw;
+	u8 old_data = 0;
 	bool enable;
 	u8 data;
 	int ret;
@@ -1316,6 +1318,7 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 	ret = ice_read_sma_ctrl(hw, &data);
 	if (ret)
 		goto unlock;
+	old_data = data;
 
 	ret = -EINVAL;
 	switch (p->idx) {
@@ -1379,14 +1382,85 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 	ret = ice_dpll_pin_state_update(pf, p, ICE_DPLL_PIN_TYPE_SOFTWARE,
 					extack);
 	if (ret)
-		goto unlock;
+		goto restore_sma_ctrl;
 
-	if (enable)
+	if (enable) {
 		ret = ice_dpll_pin_enable(hw, target, d->dpll_idx, type, extack);
-	else
+		if (!ret)
+			ret = ice_dpll_pin_state_update(pf, target, type, extack);
+		if (!ret && p->muxed && p->muxed->active) {
+			struct ice_dpll_pin *peer = p->muxed;
+			struct ice_dpll_pin *peer_target;
+			enum ice_dpll_pin_type peer_type;
+			int peer_ret;
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
+			peer_ret = ice_dpll_pin_enable(&pf->hw, peer_target,
+					       pf->dplls.pps.dpll_idx < ICE_DPLL_RCLK_NUM_MAX &&
+					       peer_target->state[pf->dplls.pps.dpll_idx] == DPLL_PIN_STATE_CONNECTED ?
+					       pf->dplls.pps.dpll_idx : pf->dplls.eec.dpll_idx,
+						       peer_type, NULL);
+			if (!peer_ret)
+				peer_ret = ice_dpll_pin_state_update(pf, peer_target,
+							     peer_type, NULL);
+			if (peer_ret) {
+				ret = peer_ret;
+				goto disable_pin;
+			}
+		}
+	} else {
 		ret = ice_dpll_pin_disable(hw, target, type, extack);
-	if (!ret)
-		ret = ice_dpll_pin_state_update(pf, target, type, extack);
+		if (!ret)
+			ret = ice_dpll_pin_state_update(pf, target, type, extack);
+	}
+
+	goto unlock;
+
+disable_pin:
+	ice_dpll_pin_disable(hw, target, type, extack);
+	if (p->muxed && p->muxed->active) {
+		struct ice_dpll_pin *peer = p->muxed;
+		struct ice_dpll_pin *peer_target = NULL;
+		enum ice_dpll_pin_type peer_type;
+
+		if (peer->direction == DPLL_PIN_DIRECTION_OUTPUT) {
+			peer_target = peer->output;
+			peer_type = ICE_DPLL_PIN_TYPE_OUTPUT;
+		} else if (peer->direction == DPLL_PIN_DIRECTION_INPUT) {
+			peer_target = peer->input;
+			peer_type = ICE_DPLL_PIN_TYPE_INPUT;
+		}
+		if (peer_target)
+			ice_dpll_pin_disable(&pf->hw, peer_target, peer_type, extack);
+	}
+restore_sma_ctrl:
+	{
+		int restore_ret;
+
+		restore_ret = ice_write_sma_ctrl(hw, old_data);
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

