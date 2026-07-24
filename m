Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B0AC53200
	for <intel-wired-lan@archiver.kernel.org>; Fri, 24 Jul 2026 12:13:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C7D340A90;
	Fri, 24 Jul 2026 12:13:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RnFjZAnxfxam; Fri, 24 Jul 2026 12:13:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 35DBA40A92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784895236;
	bh=Gn/AxoCcNKACd1cROnZENqmJ9AVZ241U+LPa/BLB7qU=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=83jMBtx7uHDu/P7ElhrH6vf48pySafxjyH9dqJnH6rmfkYae5W3Lcsj9UMbYV8rYm
	 ngxTBsi/5VR/3GRdFxJGHls9WLdYwYt+NuxhY/3xCEJF5mmtTCWOU/51NKx9SNKePl
	 09IOzTYB5n3Z3/iJnIwpPnJrcGQgMd/9ZugMcnJ084jq+RDTLC2O1RYlh51o9Jh/13
	 8L6BJa0vO8gNZ7CoOI47CUlbDq4wkzLG+xYdi+v89YKqLC1fFlnEz0Qu39aLAFfF/G
	 7jex8zyIt0O7WfQqoG+gIOUUAmb9uKMpoPNh6gYoJ/P2973CBH5K0Wusw2Zbu7URn8
	 JSMm1t8CXhI1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35DBA40A92;
	Fri, 24 Jul 2026 12:13:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B62043B0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Jul 2026 12:13:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9C799607B3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Jul 2026 12:13:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8wh7cawDnXJO for <intel-wired-lan@lists.osuosl.org>;
 Fri, 24 Jul 2026 12:13:53 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8BFF86061D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8BFF86061D
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8BFF86061D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Jul 2026 12:13:53 +0000 (UTC)
X-CSE-ConnectionGUID: E70n40dpQpqUHqB+AFm8zQ==
X-CSE-MsgGUID: SNSaSCDZTQ+rrHDSuiiY3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="84686072"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; d="scan'208";a="84686072"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2026 05:13:53 -0700
X-CSE-ConnectionGUID: mpTg/a8SSYes7IoypRx/UA==
X-CSE-MsgGUID: RBRDjfIASvSwtnUAtkhhhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; d="scan'208";a="252367702"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by fmviesa009.fm.intel.com with ESMTP; 24 Jul 2026 05:13:52 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Date: Fri, 24 Jul 2026 12:13:47 +0000
Message-ID: <20260724121350.1565330-2-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724121350.1565330-1-sergey.temerkhanov@intel.com>
References: <20260724121350.1565330-1-sergey.temerkhanov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784895234; x=1816431234;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=w0QiPrSSbSxJPJWdLNfgBVxrpdJJbxJ/8HRKxXozyGk=;
 b=SfCEWmrg19zdqw1ZdNg6A2FJVysKBlURLO2XWG3gyRFMTGYGmKOVZjXE
 92BH98l5DFKOcQgxG9EwLyCHZIMNxRp3c4DocJ4yreZGnBseGW6jHn2k8
 ZsD4EyItQoWXWWf1uSr/NRkfnNDdBaMm6BVjtwMNIqUCQCVjBVaG4i7WM
 U4xPYxMfdpnQGZxvl81oB1NbeLGbAPh62sY81olV50Ol/fkxRGMw5xPYg
 FRTSQj33PJ0Wm8v8TJk8seEiXn1OhUp4wrBNOyexf3DfUlHWm3vZscquX
 jfLvCqdACLq/e/U+ozRt5kZIn1bt/Qs1++6Y2flpg1IlFTQTn/jQ811Nn
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=SfCEWmrg
Subject: [Intel-wired-lan] [PATCH iwl-next v2 1/4] ice: dpll: Rework
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

