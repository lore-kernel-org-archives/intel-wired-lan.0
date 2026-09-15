Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C92C88E75
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 12:55:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0420E809CF;
	Tue, 15 Sep 2026 12:55:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ldGBAHyutIWp; Tue, 15 Sep 2026 12:55:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 58213809E7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789476929;
	b=RBFij2YN6o7EFYmRcwgQZJ99EITKJE5MzglqtfsVYMVDfwShd1rMqzu5+0umsP5EmRoS
	 1l2E5mZqNx+7HBz4zYQkEbI6W1340VxmkN/X8lV/LB4Sfwk2M2mKeEXqmoO0q4MXes0i1
	 yH9ugWPoh1hLVQUveU8JUi7UaYOUfokABHRoEcD+d3Vm73J0Kb08T7VHEpsOMNnw7g5Gx
	 2XMM/XHVttK5iuZMeymG12DAr+UkJ0GKA5XAqcNwpjM71z1f9oEpCmV/BM/U0ls8DVErH
	 gIUKVLNC/8JXZsjuvhxsJifa3m6ovdVM0HzlrEbAlD1JuMfpK8plfy51w6FRtVCRhcQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789476929;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tZklCXWfzc7ARf1tYKcevAXJiaJbZnvhZD59SqmLoCA=;
	b=kHOiwurdcK/tVUC1QjJgVh2idHwQ4mqSvTuDT6Vo4QjqArnsQwpS3H1TcvwBNvuDexDa
	 omfbq9yZndm23NCBas0e5kadoT3pO/VoHSL/zfD/v/tFQm8NB3W2yG5OqurMktelYRsfF
	 hWUWMZWQrR6WFrrx26IEDXP9va4dQ3Knpgd9qxQFFLrHAK+Ck2yh6O8/7Cpbw7dQj1akA
	 43NqIM0rUz0EumKyRgpaNQqpsZga78F75Oj1MDpRUEOtuzb5X0jF2ZVj90HCWYHCGMTXQ
	 lizKWyXM/0Jrd31xfD7FfQG0Y/CM8/yhB5bot1k4VQHvZyBolWAh8YTm6p7ik28hRbw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789476929;
	bh=tZklCXWfzc7ARf1tYKcevAXJiaJbZnvhZD59SqmLoCA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=1AW6qMgg+4BCQnavSW9zqUrQL/FYJ2FXbhG5jQqh+UGdMjPNwQGplw66kRuQLlTiE
	 bZhC7J7nwGim+y9Kfm6qzwk+0AWjuauJSfbWjoUOGDZrURm5KendmvnZ8s7EWw7dSe
	 w0qBflLwSo9BVjpGNWPhQRSWCVH/40gAsRlobeetcvalBHjiaflSXo7aE5hMZNrOx8
	 Y7DyZqOd06YRr/rsIwyNCeYgzKXxHHEhupXQXqkrq4vBJ4GA7YJ1pYglWwjonB7jkT
	 TIzXTlZ9GC6/14BHosBPJGdHQIWZaVvaafZNFcGKqAVopDPCjthLo9x5dA+w2SV2rp
	 7JhxRNoEQfhsw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58213809E7;
	Tue, 15 Sep 2026 12:55:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C886493
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3251A4009D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8l7ZNKOqX3lj for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 12:55:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 565B54002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789476927;
 b=bc6e9938Nui7zg8YJ8qkJOLNdP/nccEhQVai0q1Nk+d+4vCJXSELWbbcdfU69Y0w7SJm
 VLGXaCtHqn5UjtTOTR1M1+xW+h5xai2QNRSKXNJdWIqweYKAIfFk645EU6lAsSe15Dc0m
 GmedSpgQuMJzwQTCnZxGviowgNPfSv22Y+GaYJ7+1/urQQsK0kXrocwT00/niHHW4N+5D
 l9LIGasx4dEjs3VhVsFkMCuLdPTQXEKIoeNWuqrikBJFsCFMkrsA8GDZR3jTdlXJnnDKx
 40I2wrjV+FYConPquHjjv+yrjYJXcO9jLzFDqJbIfA5B3WY0LSsF9N+7lOdq01nPGsA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789476927;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=tZklCXWfzc7ARf1tYKcevAXJiaJbZnvhZD59SqmLoCA=;
 b=aVhVnQZ5sdB0NKQlTwCrt6Mr04yS2wfL0+CZtcwDbmdIrrqPQF0U0TlwE4at9poFDe8M
 e/cGiNbI1ID+2nD8LsiLx4b+FS24cWYantwSNHq1K0eZxp8txgGo9Beo0p7vsBFPWmbW6
 efamMXTQWZSQuap9cO9szgwG2u/MuKzumJD9kg5Bp0jNVqTMcITSinaiKWK4UdjP6q445
 Ok40VYf7GYpW7KvjbpR66wMMkhO6qM+2mAM84n2cUUGCT/6C/QvCSBEK12Nw3tIsRKUPY
 zqT88AgAGJ/twYdo2qPeICX6HK3GJ2gqIz/si66lfbsy/93RYMUrtIzWEEBPfCVJd7g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ZBGJEg+W; 
 arc=none smtp.remote-ip=192.198.163.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ZBGJEg+W
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 565B54002B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789476927; x=1821012927;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=BBm45xnOQGpHUeWgvwakjq8EmH+ZxJkt/gE/cG/QXwI=;
 b=ZBGJEg+WmTxDXE7zGrWThpAe9fTzHLHfpQxNfNmySGmAftmTMN90R85e
 +T04+IaW3lbZihjxhjDnajI+A+gA/J9YWOmJxW8ASO/kNV1EfpjeVUkgn
 mRi6RAZSrZaYdt6fYCWmm5aKro0U2weAlhGzbj+uJ5WizOmoJ0ijtAN/i
 qdy31nV/E0CKdl6SfuEHnosuXzD6qnYEbW/T6ZWPCzGXRJW+VZJGlGV7I
 ek3PgWv2GxY1LgzMKQM11vmSDrluq9u4JgfkwaFYTl6cOfF9VnX1JXiJ/
 pEiWo0dABWDbyE0W/tauqIQvDe9R+OjQxDaa5Uz6QRK6ud8oDxbue1g/m g==;
X-CSE-ConnectionGUID: BU5vyWt+TripG4M5edXQJg==
X-CSE-MsgGUID: DrippraNTRG+OCHdk3VxeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89853097"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89853097"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 05:55:27 -0700
X-CSE-ConnectionGUID: C0syPeD8RYeWbwf8MsSzHQ==
X-CSE-MsgGUID: Aahjy8jWRKK8nwekeb2K2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1225144"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa011.fm.intel.com with ESMTP; 15 Sep 2026 05:55:26 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net v2] ice: fix LLDP AQ filter fallback not working on
 E82x and E830 hardware
Date: Tue, 15 Sep 2026 14:55:25 +0200
Message-ID: <20260915125525.3975646-1-aleksandr.loktionov@intel.com>
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
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v1 -> v2: rewrite as a single combined patch using a switch on
hw->mac_type, instead of two separate patches (E82x fix, then a
follow-up E830 fix layered on top).

 drivers/net/ethernet/intel/ice/ice_common.c | 23 ++++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_type.h   |  7 ++++++-
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index ef1ce10..67467b5 100644
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
index d9a5c1a..797a383 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -1217,11 +1217,16 @@ struct ice_aq_get_set_rss_lut_params {
 
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

