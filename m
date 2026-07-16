Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B25EC4450A
	for <intel-wired-lan@archiver.kernel.org>; Thu, 16 Jul 2026 09:49:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5E3B4078F;
	Thu, 16 Jul 2026 09:49:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id foeKEB_DTDtX; Thu, 16 Jul 2026 09:49:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 110B74076A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784195358;
	bh=Gn/AxoCcNKACd1cROnZENqmJ9AVZ241U+LPa/BLB7qU=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rO4QrttT2Dhw55TtaoWwsbQu2U/kZuZiju+md926GbtHotrIv6ZCgXThRP6BQFNQa
	 Jc+/VYrAuquiJePEvxIi1TXRAwYghs4V9usAjlrgc+/PJQCsD5m3hzLqc9tRvIfqly
	 QWhVkLrEmR80sAHMscA/62oVlROYsNHK2dNeUtAuVWscgFUVX6E5faTHYceAYICFmx
	 /aR87JxoKWZvwGY1Nt5DfqNG3527Ho04ONCkR25Jy3UyfAElmznbT9o73X3K3WSeHY
	 PzzHs0IpYJHlJtbk9/luK8J22n6LFfonkZ5yTmYbEmDI+VhYX96eihNTiZS5sK3xUh
	 Jp7HC0WTWE39Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 110B74076A;
	Thu, 16 Jul 2026 09:49:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 77E43426
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 09:49:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 69ADB80E59
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 09:49:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R3zU0yWWkWXQ for <intel-wired-lan@lists.osuosl.org>;
 Thu, 16 Jul 2026 09:49:15 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2052980E58
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2052980E58
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2052980E58
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 09:49:15 +0000 (UTC)
X-CSE-ConnectionGUID: cSkQrbQKTHSBwRvFahRwtA==
X-CSE-MsgGUID: wZ3E3k7qR7Wkq3ULmwvESw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84963876"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="84963876"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 02:49:15 -0700
X-CSE-ConnectionGUID: YykEGDFwS2Kt8cdkT04uqQ==
X-CSE-MsgGUID: IhT8kgY3QU6iJSOMLpmelA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="256501623"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa007.jf.intel.com with ESMTP; 16 Jul 2026 02:49:14 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Date: Thu, 16 Jul 2026 09:49:08 +0000
Message-ID: <20260716094912.1210865-2-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716094912.1210865-1-sergey.temerkhanov@intel.com>
References: <20260716094912.1210865-1-sergey.temerkhanov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784195355; x=1815731355;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=w0QiPrSSbSxJPJWdLNfgBVxrpdJJbxJ/8HRKxXozyGk=;
 b=F8fF4hqpxYFol8U5iGbhAGkB61rZowtBZVrwygGwwouvim0iSeftdUh6
 yyoRrfyJTF/1dGXcP+dcF0HjHCDZAuykOhOY5xvRHpz2mzK1xlhymotgM
 bX2k/WCyiziwOeSt5UbeaL7qetEd6pw6jzSgmF2idX6B31sAql8Ml+9//
 phrB3XWd3h/wW+wkRRvFWCzO6TeVrkSH/dEnOCrL6AoJwqrk4NQPUl9kn
 XWpmp3KbPEHTTMEQ++ix3W0TcI0XhhXteGHSnEdePvkneSicz3A2ISwGB
 PmmBDuSwTfS3mo+yFWHIjEym9d6a7CcHKGMvHrgyVuDgE8FQmhi4tLiFn
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=F8fF4hqp
Subject: [Intel-wired-lan] [PATCH iwl-next v1 1/4] ice: dpll: Rework
 multiplexed pin notifications
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

Use a pointer to the struct ice_dpll_pin to link multiplexed
pins. This allows to simplify the selection logic.

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 60 +++++++++++------------
 drivers/net/ethernet/intel/ice/ice_dpll.h |  1 +
 2 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 1ca137f67dd4..fed7c9fea953 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -544,6 +544,29 @@ ice_dpll_pin_disable(struct ice_hw *hw, struct ice_dpll_pin *pin,
 	return ret;
 }
 
+/**
+ * ice_dpll_sw_pin_notify_peer - notify the paired SW pin after a state change
+ * @changed: the SW pin that was explicitly changed (already notified by dpll core)
+ *
+ * SMA and U.FL pins share physical signal paths in pairs (SMA1/U.FL1 and
+ * SMA2/U.FL2).  When one pin's routing changes via the PCA9575 GPIO
+ * expander, the paired pin's state may also change.  Send a change
+ * notification for the peer pin so userspace consumers monitoring the
+ * peer via dpll netlink learn about the update.
+ *
+ * Context: Called from dpll_pin_ops callbacks after pf->dplls.lock is
+ *          released.  Uses __dpll_pin_change_ntf() because dpll_lock is
+ *          still held by the dpll netlink layer.
+ */
+static void ice_dpll_sw_pin_notify_peer(struct ice_dpll_pin *changed)
+{
+	struct ice_dpll_pin *peer;
+
+	peer = changed->muxed;
+	if (peer->pin)
+		__dpll_pin_change_ntf(peer->pin);
+}
+
 /**
  * ice_dpll_pin_store_state - updates the state of pin in SW bookkeeping
  * @pin: pointer to a pin
@@ -1171,32 +1194,6 @@ ice_dpll_input_state_get(const struct dpll_pin *pin, void *pin_priv,
 				      extack, ICE_DPLL_PIN_TYPE_INPUT);
 }
 
-/**
- * ice_dpll_sw_pin_notify_peer - notify the paired SW pin after a state change
- * @d: pointer to dplls struct
- * @changed: the SW pin that was explicitly changed (already notified by dpll core)
- *
- * SMA and U.FL pins share physical signal paths in pairs (SMA1/U.FL1 and
- * SMA2/U.FL2).  When one pin's routing changes via the PCA9575 GPIO
- * expander, the paired pin's state may also change.  Send a change
- * notification for the peer pin so userspace consumers monitoring the
- * peer via dpll netlink learn about the update.
- *
- * Context: Called from dpll_pin_ops callbacks after pf->dplls.lock is
- *          released.  Uses __dpll_pin_change_ntf() because dpll_lock is
- *          still held by the dpll netlink layer.
- */
-static void ice_dpll_sw_pin_notify_peer(struct ice_dplls *d,
-					struct ice_dpll_pin *changed)
-{
-	struct ice_dpll_pin *peer;
-
-	peer = (changed >= d->sma && changed < d->sma + ICE_DPLL_PIN_SW_NUM) ?
-		&d->ufl[changed->idx] : &d->sma[changed->idx];
-	if (peer->pin)
-		__dpll_pin_change_ntf(peer->pin);
-}
-
 /**
  * ice_dpll_sma_direction_set - set direction of SMA pin
  * @p: pointer to a pin
@@ -1258,7 +1255,7 @@ static int ice_dpll_sma_direction_set(struct ice_dpll_pin *p,
 	 * backing pin when U.FL becomes inactive because the SMA pin may
 	 * still be using it.
 	 */
-	peer = &d->ufl[p->idx];
+	peer = p->muxed;
 	if (peer->active) {
 		struct ice_dpll_pin *target;
 		enum ice_dpll_pin_type type;
@@ -1388,7 +1385,7 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 unlock:
 	mutex_unlock(&pf->dplls.lock);
 	if (!ret)
-		ice_dpll_sw_pin_notify_peer(&pf->dplls, p);
+		ice_dpll_sw_pin_notify_peer(p);
 
 	return ret;
 }
@@ -1508,7 +1505,7 @@ ice_dpll_sma_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 unlock:
 	mutex_unlock(&pf->dplls.lock);
 	if (!ret)
-		ice_dpll_sw_pin_notify_peer(&pf->dplls, sma);
+		ice_dpll_sw_pin_notify_peer(sma);
 
 	return ret;
 }
@@ -1705,7 +1702,7 @@ ice_dpll_pin_sma_direction_set(const struct dpll_pin *pin, void *pin_priv,
 	ret = ice_dpll_sma_direction_set(p, direction, extack);
 	mutex_unlock(&pf->dplls.lock);
 	if (!ret)
-		ice_dpll_sw_pin_notify_peer(&pf->dplls, p);
+		ice_dpll_sw_pin_notify_peer(p);
 
 	return ret;
 }
@@ -4623,6 +4620,8 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf *pf)
 		if (pin->input->ref_sync)
 			pin->ref_sync = pin->input->ref_sync - pin_abs_idx;
 		pin->output = &d->outputs[ICE_DPLL_PIN_SW_OUTPUT_ABS(i)];
+		pin->muxed = &d->ufl[i];
+
 		ice_dpll_phase_range_set(&pin->prop.phase_range, phase_adj_max);
 	}
 	for (i = 0; i < ICE_DPLL_PIN_SW_NUM; i++) {
@@ -4656,6 +4655,7 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf *pf)
 				(DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |
 				 caps);
 		}
+		pin->muxed = &d->sma[i];
 		ice_dpll_phase_range_set(&pin->prop.phase_range, phase_adj_max);
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
index c59d746a8567..c102ff2649d9 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
@@ -78,6 +78,7 @@ struct ice_dpll_pin {
 	s32 phase_adjust;
 	struct ice_dpll_pin *input;
 	struct ice_dpll_pin *output;
+	struct ice_dpll_pin *muxed;
 	enum dpll_pin_direction direction;
 	s64 phase_offset;
 	u8 status;
-- 
2.53.0

