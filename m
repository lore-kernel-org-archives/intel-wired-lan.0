Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C45C44501
	for <intel-wired-lan@archiver.kernel.org>; Thu, 16 Jul 2026 09:49:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E803960842;
	Thu, 16 Jul 2026 09:49:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LO08W2lszY03; Thu, 16 Jul 2026 09:49:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3806460859
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784195360;
	bh=02+lEFwWINluJu1Cn4aLxk5i7Ks5aL6dLdRTcxPbSg8=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=4kA+36jMwn0bDxpUS0M6xykCd8tLKvZlEAJEyjyOuxi+Z0LcSIRNMmCgbsHQsF/Gb
	 kLj8Eu9Ee8IylTBLy7RWHOLKCjUNv0zlMds6HWmkGKeW0vBeVPPBGY4CghpK0RS0sO
	 hVPr6GuL6thgh4pIhBZa0yxzEOwuwXdog+oZj5XF6rL3ZqMEyJPmujSM8sMk6j/8xO
	 Lzz4QJV4VwK5gBSb84Vd05m1o1Frfm27sjmTmNCvJJq7f9o1NH62JVUDdzYW84v4mF
	 lBWhklsaorsbJ9zb4gydVglJhSguaZWPPsoO9F6eBDUtWTf603u8fFKi07YtHLu547
	 163bDyY108bDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3806460859;
	Thu, 16 Jul 2026 09:49:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E6359426
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 09:49:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D81BB80E59
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 09:49:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IcSEiI6Ns_pp for <intel-wired-lan@lists.osuosl.org>;
 Thu, 16 Jul 2026 09:49:18 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E6C6B80E57
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E6C6B80E57
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E6C6B80E57
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 09:49:17 +0000 (UTC)
X-CSE-ConnectionGUID: hrU9yECxRpiwdv22OOV2Mg==
X-CSE-MsgGUID: 3lC/aChBTNW12PLbGsSfZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84963885"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="84963885"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 02:49:18 -0700
X-CSE-ConnectionGUID: Vkf9EZj5Txqkop5pOCdNKA==
X-CSE-MsgGUID: QDJVphzUTXC2x7IjK6LnKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="256501631"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa007.jf.intel.com with ESMTP; 16 Jul 2026 02:49:17 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Date: Thu, 16 Jul 2026 09:49:11 +0000
Message-ID: <20260716094912.1210865-5-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716094912.1210865-1-sergey.temerkhanov@intel.com>
References: <20260716094912.1210865-1-sergey.temerkhanov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784195358; x=1815731358;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TPTzoaH7iXUJJlNOdjQQNXyuCi3pEzwVvdsdYUEj+sA=;
 b=Z9giz3J8C6RKJC9e8DonuZBE7hEIuXArFCm+ZbxWLeZc4rBMQfsf40i/
 sIZOvcvEG/9IdMtjV/KiWh9Rv/tgepmcklm/2A0bQY6PUG+YyQwva5KM5
 B+tbKDUdkWC0a8R2R4x4KKd+QawPn48Dxbhtw1GX60ytF0PWgXKsy0Bvf
 MpdK0PbsnH8Utiw10XorVlrHyvEAJw1bSAacNT+uiMV7eP0zOrGnSQft1
 7Hu19ADMD13QMXB9iE3hpqShEBmluFnr7NcvIVjUfwM8mLr4DPtFlbVNw
 Y2tRjjBCkbxPBh+pkdHHZGdZQ3XyWLuQlSfWrUwBPP0tcN/8z51wi4jbe
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Z9giz3J8
Subject: [Intel-wired-lan] [PATCH iwl-next v1 4/4] ice: dpll: Rework the SMA
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
 drivers/net/ethernet/intel/ice/ice_dpll.c | 88 ++++++++++++++++++++---
 1 file changed, 78 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index cb14621b3aef..f11d90ed80f2 100644
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
@@ -1505,6 +1509,7 @@ ice_dpll_sma_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 	struct ice_dpll *d = dpll_priv;
 	struct ice_pf *pf = sma->pf;
 	enum ice_dpll_pin_type type;
+	u8 old_data = 0;
 	bool enable;
 	int ret;
 
@@ -1556,13 +1561,76 @@ ice_dpll_sma_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
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
+		if (sma->idx == ICE_DPLL_PIN_SW_1_IDX) {
+			data &= ~ICE_SMA1_TX_EN;
+		} else if (sma->idx == ICE_DPLL_PIN_SW_2_IDX) {
+			data &= ~ICE_SMA2_UFL2_RX_DIS;
+			data &= ~ICE_SMA2_TX_EN;
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
-		ret = ice_dpll_pin_disable(&pf->hw, target, type, extack);
-	if (!ret)
+		if (ret)
+			goto restore_sma_ctrl;
+		/* refresh target state first so a peer-side error cannot leave it stale */
 		ret = ice_dpll_pin_state_update(pf, target, type, extack);
+		if (ret)
+			goto restore_sma_ctrl;
+
+		if (sma->muxed->active) {
+			struct ice_dpll_pin *peer = sma->muxed;
+			struct ice_dpll_pin *peer_target;
+			enum ice_dpll_pin_type peer_type;
+
+			if (peer->direction == DPLL_PIN_DIRECTION_OUTPUT) {
+				peer_target = peer->output;
+				peer_type = ICE_DPLL_PIN_TYPE_OUTPUT;
+			} else {
+				peer_target = peer->input;
+				peer_type = ICE_DPLL_PIN_TYPE_INPUT;
+			}
+			ret = ice_dpll_pin_enable(&pf->hw, peer_target,
+						  d->dpll_idx,
+						  peer_type, extack);
+			if (!ret)
+				ret = ice_dpll_pin_state_update(pf, peer_target,
+								peer_type, extack);
+			if (ret)
+				goto restore_sma_ctrl;
+		}
+	} else {
+		ret = ice_dpll_pin_disable(&pf->hw, target, type, extack);
+		if (!ret)
+			ret = ice_dpll_pin_state_update(pf, target, type,
+							extack);
+	}
+	goto unlock;
+
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

