Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BC0FF8873
	for <intel-wired-lan@archiver.kernel.org>; Thu, 30 Apr 2026 12:26:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1EFD261C28;
	Thu, 30 Apr 2026 12:26:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ts6o3RkGK4qO; Thu, 30 Apr 2026 12:26:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 657F5617A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777551974;
	bh=jNGxF2l+R9CnVMp6l4YalRL/JZPvQonlHrBei6o9HUg=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kp95tewM1SUvLk0PIYkhUrziHtdZbixaw+egNku1OMXcAnsM1Gs0JkymNEASy3fDf
	 KFAJhyzINXyFzWp9kN53LFVa8VGeLp/n/2h6XjS42XMLaBgDQ3aictOwMGeGX2k4JK
	 OhwTwK5oNWNqmTHuqxNnvDzdqbxOBuIPeTfMGeiTdU6sx5Izn5IX3QhvkndK1jU23e
	 UVMGcXN95VZeVZgvpSdwDxrEMbEdKfUdmxbRnE/NnnAxKQJc3GOfXnTsaMssSHDHcY
	 Y0zkiDg3Mv6Oh3tSlbB+7MZe++TAQ0N9P6SjRg/q0NTYwvgEVmZOVkHmcBVs6/Ewsk
	 VnPlHUuR7XZ/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 657F5617A0;
	Thu, 30 Apr 2026 12:26:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C12E18F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Apr 2026 12:26:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 626264073C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Apr 2026 12:26:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CEcdafi22ykt for <intel-wired-lan@lists.osuosl.org>;
 Thu, 30 Apr 2026 12:26:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6D6FE403D6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6D6FE403D6
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6D6FE403D6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Apr 2026 12:26:12 +0000 (UTC)
X-CSE-ConnectionGUID: puUSZFeZQOWWbTYSRXoIRw==
X-CSE-MsgGUID: 6UQD1SonR1ybEWSq1SKa5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78689196"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="78689196"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 05:26:12 -0700
X-CSE-ConnectionGUID: W7cWY3E6TSePxZt18iY4cQ==
X-CSE-MsgGUID: tNm2NjxQQ021EbHCdHcCkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="233538439"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa006.jf.intel.com with ESMTP; 30 Apr 2026 05:26:11 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Date: Thu, 30 Apr 2026 14:26:02 +0200
Message-ID: <20260430122602.126722-6-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260430122602.126722-1-aleksandr.loktionov@intel.com>
References: <20260430122602.126722-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777551972; x=1809087972;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yPN+lmUC+V9SjMLQPhkRnt+TgdSTwYMAW5C7MIsny0I=;
 b=MJpume7lGMpHRDqaGA+vIeoYA0+ITGcGAlUhCmbv9pnE7qY0ZadmwskH
 tNPaGigR5kkMkzF1xSa4wHdlraOSxT/j509G39OcEhUBGBPJ4eHiHJ6N9
 uREdvrZrsgWn2fN8HzINQZbgQ00stBEXblWN7sjJ9cTpQNG+2EZEt+Rxo
 7BbLsC/uNEBohIk2+3samK6GNW/2hy3nSQqoTlXyzOFVE4VKiCcPtNDPM
 fSu2gf20uQ8GozYMNt8I+UBdk0lrHPF/7uTCWv2AYrHlwVWkZA/I4Zeub
 2BnOqoSLT0j6uPmeRxt/3f5oaKipwDSU5TnTHCfCuU6qJBuvBfzczPriK
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=MJpume7l
Subject: [Intel-wired-lan] [PATCH 5/5] ice: use element-by-element
 comparison for DCB config changes
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

Comparing two ice_dcbx_cfg structs with memcmp() is unreliable on
non-packed structs due to uninitialised padding bytes.  The HW DCB
path already has ice_dcb_need_recfg() that compares fields
individually; export it and use it in the SW DCB netlink setters
(setets, setpfc, setapp, cee_set_all) instead of the unsafe memcmp.

Remove the now-redundant memcmp check from ice_pf_dcb_cfg() so that
function always attempts the HW reconfiguration when called.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 13 ++-------
 drivers/net/ethernet/intel/ice/ice_dcb_lib.h |  2 ++
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c  | 30 ++++++++++++++++++--
 3 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index bd77f1c..2e85fae 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -353,15 +353,11 @@ int ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dcbx_cfg *new_cfg, bool locked)
 	struct ice_dcbx_cfg *old_cfg, *curr_cfg;
 	struct device *dev = ice_pf_to_dev(pf);
 	struct iidc_rdma_event *event;
-	int ret = ICE_DCB_NO_HW_CHG;
 	struct ice_vsi *pf_vsi;
+	int ret;
 
 	curr_cfg = &pf->hw.port_info->qos_cfg.local_dcbx_cfg;
 
-	/* FW does not care if change happened */
-	if (!pf->hw.port_info->qos_cfg.is_sw_lldp)
-		ret = ICE_DCB_HW_CHG_RST;
-
 	/* Enable DCB tagging only when more than one TC */
 	if (ice_dcb_get_num_tc(new_cfg) > 1) {
 		dev_dbg(dev, "DCB tagging enabled (num TC > 1)\n");
@@ -377,11 +373,6 @@ int ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dcbx_cfg *new_cfg, bool locked)
 		clear_bit(ICE_FLAG_DCB_ENA, pf->flags);
 	}
 
-	if (!memcmp(new_cfg, curr_cfg, sizeof(*new_cfg))) {
-		dev_dbg(dev, "No change in DCB config required\n");
-		return ret;
-	}
-
 	if (ice_dcb_bwchk(pf, new_cfg))
 		return -EINVAL;
 
@@ -481,7 +472,7 @@ static void ice_cfg_etsrec_defaults(struct ice_port_info *pi)
  * @old_cfg: current DCB config
  * @new_cfg: new DCB config
  */
-static bool
+bool
 ice_dcb_need_recfg(struct ice_pf *pf, struct ice_dcbx_cfg *old_cfg,
 		   struct ice_dcbx_cfg *new_cfg)
 {
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.h b/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
index da9ba81..a7eaa2f9 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
@@ -20,6 +20,8 @@ u8 ice_dcb_get_num_tc(struct ice_dcbx_cfg *dcbcfg);
 void ice_vsi_set_dcb_tc_cfg(struct ice_vsi *vsi);
 bool ice_is_pfc_causing_hung_q(struct ice_pf *pf, unsigned int txqueue);
 u8 ice_dcb_get_tc(struct ice_vsi *vsi, int queue_index);
+bool ice_dcb_need_recfg(struct ice_pf *pf, struct ice_dcbx_cfg *old_cfg,
+			struct ice_dcbx_cfg *new_cfg);
 int
 ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dcbx_cfg *new_cfg, bool locked);
 int ice_dcb_bwchk(struct ice_pf *pf, struct ice_dcbx_cfg *dcbcfg);
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
index a10c1c8d..13a52c1 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
@@ -108,11 +108,17 @@ static int ice_dcbnl_setets(struct net_device *netdev, struct ieee_ets *ets)
 	if (!bwrec)
 		new_cfg->etsrec.tcbwtable[0] = 100;
 
+	if (!ice_dcb_need_recfg(pf, &pf->hw.port_info->qos_cfg.local_dcbx_cfg,
+				new_cfg)) {
+		err = ICE_DCB_NO_HW_CHG;
+		goto ets_out;
+	}
+
 	err = ice_pf_dcb_cfg(pf, new_cfg, true);
 	/* return of zero indicates new cfg applied */
-	if (err == ICE_DCB_HW_CHG_RST)
+	if (!err)
 		ice_dcbnl_devreset(netdev);
-	if (err == ICE_DCB_NO_HW_CHG)
+	else if (err == ICE_DCB_NO_HW_CHG)
 		err = ICE_DCB_HW_CHG_RST;
 
 ets_out:
@@ -287,11 +293,18 @@ static int ice_dcbnl_setpfc(struct net_device *netdev, struct ieee_pfc *pfc)
 
 	new_cfg->pfc.pfcena = pfc->pfc_en;
 
+	if (!ice_dcb_need_recfg(pf, &pf->hw.port_info->qos_cfg.local_dcbx_cfg,
+				new_cfg)) {
+		err = ICE_DCB_NO_HW_CHG;
+		goto pfc_out;
+	}
+
 	err = ice_pf_dcb_cfg(pf, new_cfg, true);
 	if (err == ICE_DCB_HW_CHG_RST)
 		ice_dcbnl_devreset(netdev);
 	if (err == ICE_DCB_NO_HW_CHG)
 		err = ICE_DCB_HW_CHG_RST;
+pfc_out:
 	mutex_unlock(&pf->tc_mutex);
 	return err;
 }
@@ -845,6 +858,12 @@ static int ice_dcbnl_setapp(struct net_device *netdev, struct dcb_app *app)
 	new_cfg->dscp_map[app->protocol] = app->priority;
 	new_cfg->app[new_cfg->numapps++] = new_app;
 
+	if (!ice_dcb_need_recfg(pf, &pf->hw.port_info->qos_cfg.local_dcbx_cfg,
+				new_cfg)) {
+		ret = ICE_DCB_NO_HW_CHG;
+		goto setapp_out;
+	}
+
 	ret = ice_pf_dcb_cfg(pf, new_cfg, true);
 	/* return of zero indicates new cfg applied */
 	if (ret == ICE_DCB_HW_CHG_RST)
@@ -991,8 +1010,15 @@ static u8 ice_dcbnl_cee_set_all(struct net_device *netdev)
 
 	mutex_lock(&pf->tc_mutex);
 
+	if (!ice_dcb_need_recfg(pf, &pf->hw.port_info->qos_cfg.local_dcbx_cfg,
+				new_cfg)) {
+		err = ICE_DCB_NO_HW_CHG;
+		goto out;
+	}
+
 	err = ice_pf_dcb_cfg(pf, new_cfg, true);
 
+out:
 	mutex_unlock(&pf->tc_mutex);
 	return (err != ICE_DCB_HW_CHG_RST) ? ICE_DCB_NO_HW_CHG : err;
 }
-- 
2.52.0

