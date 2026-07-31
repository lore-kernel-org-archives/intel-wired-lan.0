Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95BEC5516F
	for <intel-wired-lan@archiver.kernel.org>; Fri, 31 Jul 2026 12:17:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7838A60B2E;
	Fri, 31 Jul 2026 12:17:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6d6A32BRc9PF; Fri, 31 Jul 2026 12:17:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C634460B3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785500259;
	bh=zlv0xaHtp5DUv7t9x+pa+96DfmJ009LBERJaiHhFru4=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=YBNQD+PwVFEXFaY4aWpqZg6Qw5m7wLWNvQRbjYGv3QZhsLRIwc+rMuq5XIQaYnTxz
	 qCz2u1923Qhy6Bn9bpKnc0AmY4YMuntBmFQX6iiPyuP3mJ0acFX33ExKIVHmv6UPUM
	 jpO2xlGnIOqwvnhpmS5JpsjsbJhHiRbb8UF4ygl3i4XHzeJTIJA8UraU/oFwxsK5Uz
	 5wdZi8FjZZwOwgdUCpJ9V8hfLHgY+SSERboZvAtnmlhqAme1jdUgn8Cd0spNA1yJqp
	 8+m81HPurPESPxc9K2GcYS3Jbg1YhuT40C8UCpwrXJbJ9yp8ed1/GLYoSkK0oHyOjn
	 6BHVGqUe+FqsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C634460B3E;
	Fri, 31 Jul 2026 12:17:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 599FA26E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 12:17:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3FDEF40471
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 12:17:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PbypC2V3CJH2 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 31 Jul 2026 12:17:36 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3409F40470
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3409F40470
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3409F40470
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 12:17:36 +0000 (UTC)
X-CSE-ConnectionGUID: PwTRTL0FSnarzEqFVCDYpA==
X-CSE-MsgGUID: wc9oZ2BlQFqLC4dnSXorEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="73662908"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; d="scan'208";a="73662908"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2026 05:17:36 -0700
X-CSE-ConnectionGUID: yOhh+XZ+S2uWzRYRv1OC5g==
X-CSE-MsgGUID: S2dVrox6RR+v+Iu9JFhcOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; d="scan'208";a="298766014"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
 by orviesa001.jf.intel.com with ESMTP; 31 Jul 2026 05:17:33 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Fri, 31 Jul 2026 14:12:16 +0200
Message-Id: <20260731121216.1841413-4-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260731121216.1841413-1-grzegorz.nitka@intel.com>
References: <20260731121216.1841413-1-grzegorz.nitka@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785500256; x=1817036256;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/iggnVjgpaFGwqI5cIkXo98VRyelZ/wU2wksNuzzt0Q=;
 b=TFtyw6sw0WpxIDccTo3UACGFsoGM3oD/WCVp+H10iYmP0cAQWsZE5gg1
 OLpvbm48CcN/1k6orAAGHrSnk8P7m3n4xOhifcLULUl+zZVgUrw2SOiVX
 cxA1Ccg3n6eca28RaFqTFkKSYGSojiJdy04U9pZd7bG+YT2HhJqys70Fg
 Nkg+RVDQ0ic7aZZYnd++M8obvewLeKLxNgMT3MKgpiWNanGLIENibNi1c
 H3mioxWAqe7zeEhPHd1BJ1o1Wy15w1rxp6HSqILHiApeKBSkJiZqy2JLK
 KuLc8Y40BwM4GzHsFiTB0PJ+0Ou2YaRpFXgWubQb1Dh+ZlGVKxEbnCxZb
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=TFtyw6sw
Subject: [Intel-wired-lan] [PATCH v2 iwl-next 3/3] ice: use per-interface
 clock_id for E825 generic DPLLs
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
Cc: przemyslaw.kitszel@intel.com, richardcochran@gmail.com,
 linux-kernel@vger.kernel.org, arkadiusz.kubalewski@intel.com,
 Przemyslaw Korba <przemyslaw.korba@intel.com>, andrew+netdev@lunn.ch,
 edumazet@google.com, anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On E825, the TX-CLK and TSPLL DPLL devices are registered as
DPLL_TYPE_GENERIC. Their clock_id was derived from the board-level
PCIe DSN, which is identical for all interfaces sharing the same
NAC/quad. As a result, userspace (e.g. 'dpll device show') reports
several DPLL devices with the same clock_id and no board or signal
label, making it impossible to unambiguously map a DPLL device to
the interface it belongs to.

Since these DPLLs are per-interface, use the permanent port MAC as
the clock_id basis for E825 generic DPLLs:

  * TX-CLK uses the plain MAC-derived value.
  * TSPLL on the source-timer owner PF uses the same MAC-derived
    value with a dedicated tag bit, so it stays distinct from
    TX-CLK while remaining stable per interface.

Other DPLL objects (EEC/PPS and non-E825 paths) keep the board
DSN-derived clock_id. When the permanent MAC is not yet valid, fall
back to the existing board-level clock_id to preserve init behavior.

Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 81 +++++++++++++++++++++--
 1 file changed, 76 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 21b8d3f797e1..ebe8b5a27134 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -3051,6 +3051,68 @@ static u64 ice_generate_clock_id(struct ice_pf *pf)
 	return pci_get_dsn(pf->pdev);
 }
 
+/**
+ * ice_generate_dpll_clock_id - generate clock_id for a specific dpll device
+ * @pf: board private structure
+ * @d: dpll device context
+ * @type: dpll type being registered
+ *
+ * For E825 generic DPLLs, use per-interface permanent MAC as the clock_id
+ * basis so userspace can unambiguously map DPLL devices to interfaces.
+ * TX-CLK keeps plain MAC-derived ID, while TSPLL uses the same basis with
+ * a dedicated tag bit to remain distinct on source-timer owner PFs.
+ * Other DPLL objects keep board-level DSN-derived clock_id.
+ *
+ * Return: generated clock id for a dpll device
+ */
+static u64 ice_generate_dpll_clock_id(struct ice_pf *pf, struct ice_dpll *d,
+				      enum dpll_type type)
+{
+	struct ice_hw *hw = &pf->hw;
+	u64 mac_clock_id;
+
+	if (hw->mac_type == ICE_MAC_GENERIC_3K_E825 &&
+	    type == DPLL_TYPE_GENERIC &&
+	    hw->port_info &&
+	    is_valid_ether_addr(hw->port_info->mac.perm_addr)) {
+		mac_clock_id = ether_addr_to_u64(hw->port_info->mac.perm_addr);
+
+		if (d->dpll_idx >= E825_DPLL_TXCLK_BASE_IDX)
+			return mac_clock_id;
+
+		if (d->dpll_idx == E825_DPLL_TSPLL_BASE_IDX)
+			return mac_clock_id | BIT_ULL(63);
+	}
+
+	return pf->dplls.clock_id;
+}
+
+/**
+ * ice_dpll_is_own_dpll_clock_id - check if clock_id belongs to this pf's DPLLs
+ * @pf: board private structure
+ * @clock_id: clock_id from a DPLL notification
+ *
+ * Match info->src_clock_id from a DPLL pin notification against any DPLL
+ * device this PF has registered. Used to suppress self-notifications
+ * generated as a side effect of our own dpll_pin_register() and
+ * dpll_pin_unregister() calls on the fwnode-backed SYNCE and TIME_REF pins,
+ * whose DPLLs (TXC and TSPLL) use MAC-derived clock_ids on E825.
+ *
+ * Return: true if clock_id matches one of this PF's registered DPLL devices.
+ */
+static bool ice_dpll_is_own_dpll_clock_id(struct ice_pf *pf, u64 clock_id)
+{
+	if (clock_id == pf->dplls.clock_id)
+		return true;
+	if (pf->hw.mac_type != ICE_MAC_GENERIC_3K_E825)
+		return false;
+	if (clock_id == ice_generate_dpll_clock_id(pf, &pf->dplls.txc,
+						   DPLL_TYPE_GENERIC))
+		return true;
+	return clock_id == ice_generate_dpll_clock_id(pf, &pf->dplls.tspll,
+						      DPLL_TYPE_GENERIC);
+}
+
 /**
  * ice_dpll_tspll_lock_status_get - derive TSPLL state for dpll subsystem
  * @pf: board private structure
@@ -3887,10 +3949,12 @@ static int ice_dpll_pin_notify(struct notifier_block *nb, unsigned long action,
 	if (pin->fwnode != info->fwnode)
 		return NOTIFY_DONE; /* Not this pin */
 
-	/* Ignore notification which are the outcome of internal pin
-	 * registration/unregistration calls - synce pin case.
+	/* Ignore notifications that are a side effect of internal pin
+	 * registration/unregistration calls. E825 uses per-device
+	 * MAC-derived clock_ids for the TXC and TSPLL generic DPLLs, so
+	 * info->src_clock_id may not equal pf->dplls.clock_id.
 	 */
-	if (info->src_clock_id == pin->pf->dplls.clock_id)
+	if (ice_dpll_is_own_dpll_clock_id(pin->pf, info->src_clock_id))
 		return NOTIFY_DONE;
 
 	work = kzalloc_obj(*work);
@@ -4247,10 +4311,17 @@ static int ice_dpll_init_txclk_pins(struct ice_pf *pf, int start_idx)
 {
 	struct ice_dpll_pin *ref_pin = pf->dplls.txclks;
 	struct ice_dpll *txc = &pf->dplls.txc;
+	u64 clock_id;
 	int ret;
 
+	/*
+	 * EXT_EREF0 is a non-fwnode pin; its clock_id must match the TX-CLK
+	 * DPLL device clock_id (see dpll_pin_register()).
+	 */
+	clock_id = ice_generate_dpll_clock_id(pf, txc, DPLL_TYPE_GENERIC);
+
 	/* Configure EXT_EREF0 pin */
-	ret = ice_dpll_get_pins(pf, ref_pin, start_idx, 1, pf->dplls.clock_id);
+	ret = ice_dpll_get_pins(pf, ref_pin, start_idx, 1, clock_id);
 	if (ret)
 		return ret;
 	ret = dpll_pin_register(txc->dpll, ref_pin->pin, &ice_dpll_txclk_ops,
@@ -4535,7 +4606,7 @@ static int
 ice_dpll_init_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu,
 		   enum dpll_type type)
 {
-	u64 clock_id = pf->dplls.clock_id;
+	u64 clock_id = ice_generate_dpll_clock_id(pf, d, type);
 	int ret;
 
 	d->dpll = dpll_device_get(clock_id, d->dpll_idx, THIS_MODULE,
-- 
2.39.3

