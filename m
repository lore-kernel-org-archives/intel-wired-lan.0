Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3234109316E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Mar 2026 05:10:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B2F6441C64;
	Fri, 20 Mar 2026 05:10:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ORevZZfygCts; Fri, 20 Mar 2026 05:10:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E897E41C61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773983440;
	bh=Q4YZ77oFPtMSn3vu86EQb5yAFgSiVuzgK2al9ZPKO9Q=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XISQl1MXSZyA/lvLAKcpy/mIJx/T5iw13HHBk2GNLGwPSB2QM6bNPfUmciizo2opY
	 Zi1ckEA7bmyaMmGKCdliyNu6ObXUHAigxfrNBwDVaFVrytkWEXxr2FVLbnqVDLFUey
	 FqkZgfEKskA0pSA2dYpVnF3tDv/MErZNjzW38H0zFb6XM9goBqWpk4qtkb7GSy8YgG
	 iiNS3X+nfQeqrRhkf8zEx6Pk7duSPP27mr+pSyBpDgEsODn+bR7eUzM24PXG7Zxc49
	 lJ7pdfq0aFBDlYBfAsf6uN0y9dpmdPR2qYUMi8yxsODHCM8MDO63/eloo/+0ly7ckM
	 U0WzSLUcgR3cg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E897E41C61;
	Fri, 20 Mar 2026 05:10:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E7BF1B6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 05:10:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 543894062A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 05:10:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wa1BgMxU6T8c for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Mar 2026 05:10:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.20;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5435440176
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5435440176
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5435440176
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 05:10:37 +0000 (UTC)
X-CSE-ConnectionGUID: ibq4Rr7XT+W8rZR96D0MZw==
X-CSE-MsgGUID: WWLIKOD0QkiIXm1tERw/qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74768355"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="74768355"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 22:10:37 -0700
X-CSE-ConnectionGUID: nCdl/dMvR1iQdNZR947FQw==
X-CSE-MsgGUID: 68WIwvocTteh9O2OkhjPIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="223203575"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa008.jf.intel.com with ESMTP; 19 Mar 2026 22:10:36 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Date: Fri, 20 Mar 2026 06:10:34 +0100
Message-ID: <20260320051034.425089-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773983437; x=1805519437;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=mUlw4KKtOe5/k/P2JJKYxdQldfA6ieZg8A8WlRsueFw=;
 b=Q+gHXPIIsP25KNEJ/wAzrMpuaEeKFVM9Fci5ee27XSVFengYUiHGDCwH
 Iby/tripDMNfaU7muLHwXrMSwMoSYs18gDS1GyeXv1WRDMIg/4Rj4XUN4
 Y73ZhUoXJVRSeibB7pToRVSjtn5MpRczaG3a78qa6yIj50q66l/2gDynP
 xmrU77s6UGUizkYL3VIgq6AMBB9/XD+bQmVMeWi+L1sJZ4joU+w1dReZw
 SHdMlbqdgQpFCLV2VleefIFP132d5opycXIqkG3rNi4sUqUjKXuyLyihh
 DNqLO1AwnLt36Pa0EzXBtO/mKQRMWdG2LQzZxSQpE6r+XOf5YhgFro0RT
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Q+gHXPII
Subject: [Intel-wired-lan] [PATCH net v1] ice: fix LLDP AQ filter fallback
 not working on E82x and E830 hardware
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

Commit 4d5a1c4e6d49 ("ice: do not add LLDP-specific filter if not
necessary") restructured ice_vsi_cfg_sw_lldp() to first attempt a
generic ethernet Rx filter and, on failure, fall back to the specialized
LLDP filter control AQ command (0x0A0A) via ice_lldp_fltr_add_remove().
This fallback is gated by ice_fw_supports_lldp_fltr_ctrl(), which only
accepted E810, causing two distinct omissions.

E82x (ICE_MAC_GENERIC, e.g. E822/E823) support the same LLDP filter
control AQ command with the same minimum firmware API version as E810
(>= 1.7.1). On E82x systems where the generic ethernet LLDP Rx filter
cannot be added, the AQ fallback silently returns -EOPNOTSUPP and the
port is left with no LLDP Rx filter.

E830 has been supported since kernel 6.9 and implements the same AQ
command but requires a higher minimum API version (>= 1.7.11). Starting
with NVM 1.2 / FW 7.9.1, the generic ethernet LLDP Rx filter path is
blocked on E830, making the AQ fallback the only viable option. With
ice_fw_supports_lldp_fltr_ctrl() returning false for E830, no LLDP Rx
filter is installed after a firmware-update-triggered reset (e.g. NVM
1.1->1.2 on an E830-CC in HPE DL380 Gen11), and the interface stays
link-down with complete loss of network connectivity.

Replace the single-type if-chain with a switch on hw->mac_type so each
family's version requirement is explicit. E810 and E82x share the 1.7.1
constants; E830 gets its own 1.7.11 constants. The default branch returns
false, covering any future MAC type that does not implement the command.

Fixes: 4d5a1c4e6d49 ("ice: do not add LLDP-specific filter if not necessary")
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 23 ++++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_type.h   |  7 ++++++-
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index ce11fea..78a075c 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -6372,15 +6372,28 @@ ice_aq_set_lldp_mib(struct ice_hw *hw, u8 mib_type, void *buf, u16 buf_size,
 /**
  * ice_fw_supports_lldp_fltr_ctrl - check NVM version supports lldp_fltr_ctrl
  * @hw: pointer to HW struct
+ *
+ * Check if firmware supports the LLDP filter control feature (AQ command
+ * 0x0A0A). Different hardware families require different minimum firmware
+ * API versions:
+ * - E810 and E82x: API version >= 1.7.1
+ * - E830: API version >= 1.7.11
  */
 bool ice_fw_supports_lldp_fltr_ctrl(struct ice_hw *hw)
 {
-	if (hw->mac_type != ICE_MAC_E810)
+	switch (hw->mac_type) {
+	case ICE_MAC_E830:
+		return ice_is_fw_api_min_ver(hw, ICE_FW_API_LLDP_FLTR_MAJ_E830,
+					     ICE_FW_API_LLDP_FLTR_MIN_E830,
+					     ICE_FW_API_LLDP_FLTR_PATCH_E830);
+	case ICE_MAC_E810:
+	case ICE_MAC_GENERIC:
+		return ice_is_fw_api_min_ver(hw, ICE_FW_API_LLDP_FLTR_MAJ,
+					     ICE_FW_API_LLDP_FLTR_MIN,
+					     ICE_FW_API_LLDP_FLTR_PATCH);
+	default:
 		return false;
-
-	return ice_is_fw_api_min_ver(hw, ICE_FW_API_LLDP_FLTR_MAJ,
-				     ICE_FW_API_LLDP_FLTR_MIN,
-				     ICE_FW_API_LLDP_FLTR_PATCH);
+	}
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 1e82f4c..03de54f 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -1215,11 +1215,16 @@ struct ice_aq_get_set_rss_lut_params {
 
 #define ICE_SR_WORDS_IN_1KB		512
 
-/* AQ API version for LLDP_FILTER_CONTROL */
+/* AQ API version for LLDP_FILTER_CONTROL - E810 and E82x */
 #define ICE_FW_API_LLDP_FLTR_MAJ	1
 #define ICE_FW_API_LLDP_FLTR_MIN	7
 #define ICE_FW_API_LLDP_FLTR_PATCH	1
 
+/* AQ API version for LLDP_FILTER_CONTROL - E830 */
+#define ICE_FW_API_LLDP_FLTR_MAJ_E830		1
+#define ICE_FW_API_LLDP_FLTR_MIN_E830		7
+#define ICE_FW_API_LLDP_FLTR_PATCH_E830	11
+
 /* AQ API version for report default configuration */
 #define ICE_FW_API_REPORT_DFLT_CFG_MAJ		1
 #define ICE_FW_API_REPORT_DFLT_CFG_MIN		7
-- 
2.52.0

