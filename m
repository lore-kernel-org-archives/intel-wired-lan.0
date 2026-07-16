Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CEAC44514
	for <intel-wired-lan@archiver.kernel.org>; Thu, 16 Jul 2026 09:49:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27C3580E57;
	Thu, 16 Jul 2026 09:49:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V0EwNvxAkkVe; Thu, 16 Jul 2026 09:49:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9D25380E59
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784195359;
	bh=jXweELGXYxg+IHvmbYYs5xZ2sUMFDdufewypqFwzVh4=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FQiGOvBIxtLPcC8Nkcn3cgg+0D3Ghi25BFusrpp63PhYJr98Ql26P5HFJ3Yyb9DgS
	 cL9b68W6nxuoQ/bJeL+lwd6cz/ZW8VsVkmhbvv2VVAMAmH7Z+v5Puy4KtNv7VFjToG
	 8YgxbWoANpcmTz9PS96ZnoFm/dcUVjPky47H4+JE8d1Pc4zljP+9rfK7lFmUlhlDp9
	 M/aEDDaW6x+Me66yW2L61SQfFwiDfNaF/D4Dp60dNsdmAaoz4WQj3E/oRBroW2m20/
	 mCS/jhk3T63s6Vmix1cpLWyntS2PCnnuFB43N7FQ8Vai3UXpC/zdChmQ/zdgCtTuct
	 dBi7+0NQy+A0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D25380E59;
	Thu, 16 Jul 2026 09:49:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CDA84426
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 09:49:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B420680E57
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 09:49:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id af8Dqa5VU1uj for <intel-wired-lan@lists.osuosl.org>;
 Thu, 16 Jul 2026 09:49:16 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C72E880E58
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C72E880E58
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C72E880E58
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 09:49:16 +0000 (UTC)
X-CSE-ConnectionGUID: Dh6Hds11SGCssOyM5ttjaA==
X-CSE-MsgGUID: n2PyvWv6TkGMhy/J00RniA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84963882"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="84963882"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 02:49:17 -0700
X-CSE-ConnectionGUID: rTSjzYjkR++uQI6VWc7qdg==
X-CSE-MsgGUID: 4ZkwPuwEQ026n7b5ZXd+Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="256501630"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa007.jf.intel.com with ESMTP; 16 Jul 2026 02:49:16 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Date: Thu, 16 Jul 2026 09:49:10 +0000
Message-ID: <20260716094912.1210865-4-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716094912.1210865-1-sergey.temerkhanov@intel.com>
References: <20260716094912.1210865-1-sergey.temerkhanov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784195357; x=1815731357;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SksVPDM8MtMFs/A4NjrOmOmXL+uWqXN/8PvffGz9b+8=;
 b=do53zE/dgpbLagVDTJZEb1OFdUTHjSmGt8jMxBTIyHH+0apF1oWxyuFL
 lSDzuXiPwE4U7CIhGimWyEtczdgLNiqIRCIuabsoFj/BFJLsYYO3m2Pl9
 8LEWhpdtH0PzfsPCLaXbWUmWqNTq0q0XlWiPIIxlj/Q7opxIGAUZuAMcS
 TQooVwM373a6fNOoY0TL7z9YdZT6qAYs5t30Zb0S4lgqzIXCnGrg8Eze8
 cDm0sNn+kRVGZ+4ED2KhI7cmVW+WCX8Q2tf/5StFkEHJUISpMsxxfxG5f
 YkbMBs4mo5Ac/8qdrxy9dDxlr+45IFHiTCIINyHmyC1S3kL0Gmme1VSC6
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=do53zE/d
Subject: [Intel-wired-lan] [PATCH iwl-next v1 3/4] ice: dpll: Rework U.FL
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
 drivers/net/ethernet/intel/ice/ice_dpll.c | 35 ++++++++++++++++++++---
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 54958e17713b..cb14621b3aef 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -1381,12 +1381,39 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 	if (ret)
 		goto unlock;
 
-	if (enable)
+	if (enable) {
 		ret = ice_dpll_pin_enable(hw, target, d->dpll_idx, type, extack);
-	else
+		if (!ret)
+			ret = ice_dpll_pin_state_update(pf, target, type, extack);
+		if (!ret && p->muxed->active) {
+			struct ice_dpll_pin *peer = p->muxed;
+			struct ice_dpll_pin *peer_target;
+			enum ice_dpll_pin_type peer_type;
+			int peer_ret;
+
+			if (peer->direction == DPLL_PIN_DIRECTION_OUTPUT) {
+				peer_target = peer->output;
+				peer_type = ICE_DPLL_PIN_TYPE_OUTPUT;
+			} else {
+				peer_target = peer->input;
+				peer_type = ICE_DPLL_PIN_TYPE_INPUT;
+			}
+			peer_ret = ice_dpll_pin_enable(&pf->hw, peer_target,
+						       pf->dplls.eec.dpll_idx,
+						       peer_type, NULL);
+			if (!peer_ret)
+				peer_ret = ice_dpll_pin_state_update(pf, peer_target,
+							     peer_type, NULL);
+			if (peer_ret)
+				dev_warn(ice_pf_to_dev(pf),
+					 "Failed to sync peer pin %u after enabling U.FL pin %u, err %d\n",
+					 peer_target->idx, target->idx, peer_ret);
+		}
+	} else {
 		ret = ice_dpll_pin_disable(hw, target, type, extack);
-	if (!ret)
-		ret = ice_dpll_pin_state_update(pf, target, type, extack);
+		if (!ret)
+			ret = ice_dpll_pin_state_update(pf, target, type, extack);
+	}
 
 unlock:
 	mutex_unlock(&pf->dplls.lock);
-- 
2.53.0

