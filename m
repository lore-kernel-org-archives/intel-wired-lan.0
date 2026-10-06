Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E733CA5FED
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 14:33:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C19B607DA;
	Tue,  6 Oct 2026 14:33:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2ySvVr8j-NcR; Tue,  6 Oct 2026 14:33:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3D793605D0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791297219;
	b=Q60/WhfEb2MbipooHHRnZJwNQQDyKeyxzEShJtUsoFblIQQFYIaBQlHeyNcJhMKAoIa5
	 LtIz90ViY9mWq4EYnQaoWvd5JgXGX9V0YvuMdvaGjGCzqAudIlsHgnckgwGxhX1krE7Zj
	 hTJM/YBSJGrAxyfREgK5h9htLu5bvKYZPAWfJGhwVWePUbypVZwJhSyaKi82J2uPorJCr
	 olORLqiF1/CzJW35+kSUK0BUSrNH3X7mlpQo6ZokqtK09TT0PuF1jlbW5OOUwACqC2GJc
	 vUHL32sS2Nsv21KSkh+8y2CJuqOTm9EtFAkX0TMeTXfc8hvLBrLUiw72I98872lHCgg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791297219;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=AWXjXPKi8yTgu+HqjE6fQU8J0v2fI5+S3l8dJ3q7pcA=;
	b=YIKbOaLEo/Wlf7nXLMZJa5ioXpi51yL/u7rW6thgX/I6cSZS1lCRWBRCPtPZlp4BBkQW
	 kxBESSdA1maugs1RzIOR86AowsJGqKqY6765+q9zRdVqR4OcvvbX24QNJfpHQe066N3bA
	 zl8DDki17cjceVQbzmtKWp4AMUMQSmUU+opmV4MRISYMSSdbM1iKFl/QegwOftoE2inIy
	 RnGdLOOZn7Xi/O+jgmsPhnihY98LyXfU6Kp0rJuf8+jMSctmHO2eH7O6u88sZ4x0Yd38K
	 5ovAGJZaRDf4F6Qy2ENlbLKiWEum8nYl10V4aGq6H0ZUfVJFXx0sbHU8dXLRnkSKJow==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791297219;
	bh=AWXjXPKi8yTgu+HqjE6fQU8J0v2fI5+S3l8dJ3q7pcA=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hovhrSwsT7Bt+H2jyLdBK2ck9myZwtv74tULnWe13euGzkPmaye4IPHFT+vMpXrfQ
	 WWs93vkD1aJaYqN0WP7MAL9wUVI4k7cVz7lwjZksgk/LHyw2x4Qdzy6AJdwmCBrXHG
	 eD7rYbwZ406crj37wfW73wDu+GAKZVhtIFAaAResvNd8PEQfR32PtzKhL6eWNtbLMB
	 dE3PwyQzyacVO6If1W0P/yq1GcdM4j/9OqmYq3EItuxXqTkzuXKv/TtUOV44vr3Zgq
	 8Ae/jAKTD3diLh2m66hXw7Xyh9al3d2m/QMpWJUAc7hYMRKrUaeGlwdPygUKlF7/dM
	 Ke6Z8bDM0Ne3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D793605D0;
	Tue,  6 Oct 2026 14:33:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 33356341
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:32:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1928C40268
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:32:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bh2atLrQDL3B for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 14:32:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C2EF440236
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791297142;
 b=C1fkamUYgLc7Y96OA1T7gWAogj4cxnRXUdLJQlSnjUt6gax6XwPyHDthWn67a+eeVttU
 CA3G6xh9Tfv+J9Cgp6jmdKb3Zt/LCjv7rFWlYBk5Eo/CgUy+BlsJPQlpLITmsGMM6VoS8
 F0DHtASERj9Z9qqsSa3Euek2nmRvxvzNnjwdbfUD+mO17fnChAm5W6RkKqr2rFioSnU5P
 KuIyzY5wK8z/b9K6yk/AL5h0E3ejlInnBpZ6P9efNbdpwVPijK4NFh5ehBds+HVAVBnqH
 fMXLcFosOF/9gTLir6p+kq6pX1k4NN26E/YgxUtBiK7Z0julEtkuAtUg/EwmieaXBGA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791297142;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=AWXjXPKi8yTgu+HqjE6fQU8J0v2fI5+S3l8dJ3q7pcA=;
 b=fdbGFgsUzXlVIQ8jG3e3ZGuaN8HJHa5IsjoEQNyGx6LStok2ZX2Pqkt2/sgPWR7q2Mm1
 oDrBJbbrTMBAqdkyVW2STzvNHTPjhV3xzKtf9yuksZrgyV75USmHe7JDR86IxdW+SdRM/
 319LROpwnAQfOe8Y3JIcj5ilUoVyafRSZx1PxKVT545bLptZebQiQ3vhiJtsnvaygQixP
 0dPOhL2CdPaSiJ6RJya+6xIAs5fmUO6rRhLRQ3dbM4KRnV8yT8YpXXUBdMm9HXRazKCfk
 f6IiO7H1yOMLIrotL6WtfLGVoS6y8clPvpIGY2+gIDlIXVFgZveITbZaK61AMXSnZkQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Bdsg6AUc; 
 arc=none smtp.remote-ip=192.198.163.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Bdsg6AUc
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C2EF440236
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791297142; x=1822833142;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=VzsG/OHtkhr9y+BULCAp86GmbP0zfRJ2vpqJcynLkzw=;
 b=Bdsg6AUcwhIwaeIA6Y5hHfXs+8zvSIgRHMr1WcNf9+wpBBIbxljA3il8
 QTLBWq3GnRIUXlqsWidsxVjvn4LYaDllBtsBzA/YqYQeMp8sUbAoD/Xi7
 dG6Fhmh7KG+HCoi+BkC2OtkeqfMXKtTk94Yp4G3SkgLsfLop5pI4Ld1E9
 SgcKpyuJsWkmduXhnX5qEkC+X3ujBTJtMdneKFTRz6HR/sjMNwBzi2tVZ
 BawmB6+d+wvHBQUVvP91ZqadINNtwPE0Pd1jLmyOtiA3CxCJPqguy/ZhB
 C95BV/ZancohRNP2OpyNG13BlG+L2fhwNTwgURKpXrijsV8E87jnxKvVe Q==;
X-CSE-ConnectionGUID: ZdMm/kQnQgefaf7e0UQfWQ==
X-CSE-MsgGUID: vBRHAGEyT0Kni92sKR2Bkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="40983"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="40983"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 07:32:21 -0700
X-CSE-ConnectionGUID: J014+doASLO+Oy1Pcb1OzA==
X-CSE-MsgGUID: TaqhHZ7MSVKlvF625Pnw+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="273535407"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa009.fm.intel.com with ESMTP; 06 Oct 2026 07:32:20 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Subject: [PATCH iwl-net v4] ice: fix LLDP AQ filter fallback not working on
 E82x and E830 hardware
Date: Tue,  6 Oct 2026 16:32:19 +0200
Message-ID: <20261006143219.2879362-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
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
v3 -> v4: Include ICE_MAC_GENERIC_3K_E825 in the standard API-version path.

 drivers/net/ethernet/intel/ice/ice_common.c | 24 ++++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_type.h   |  7 +++++-
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 2396ae6..77b51b6 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -6377,15 +6377,29 @@ ice_aq_set_lldp_mib(struct ice_hw *hw, u8 mib_type, void *buf, u16 buf_size,
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
+	case ICE_MAC_GENERIC_3K_E825:
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
index 702e119..e8c26c3 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -1229,11 +1229,16 @@ struct ice_aq_get_set_rss_lut_params {
 
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

