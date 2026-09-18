Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BA3C982DA
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Sep 2026 13:32:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 62C5160DD9;
	Fri, 18 Sep 2026 13:32:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FhdJWvQ0ihre; Fri, 18 Sep 2026 13:32:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AA22760DF1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789738372;
	b=rkf8dC81sFNDGZ3EaTaqX5fCz1vmokVBUVNwWlclgDttMyuwT9Ql2Tcmh1M0FvQTrejU
	 5pIpR1zCnrFj32s2uIJ5JycTpcGIir8gMYVbOS+bLFZ7aPM3Q6nD7ohURXASMEh12bvFG
	 irIdmzjQYbjHWJPdPxdOF4mKGbZqcE1Vcg6YDgE1ARYgXMJ3eoqCn9i3Ki7e9OMgiztvc
	 UV5tJHqWWdLeT1P4VxOgTO+sEuJxcttMD72fbjevmOUduZquVWlLyVTtVV+zRoc3LNOQJ
	 7hsimvZp/CqeUfls1aCtQau9RusIuxti7RHKSrbn/VDVxshRR+D5/irSf2byzvzRdtg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789738372;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LaLsRlQuyQ/J23Q9iDFSFQ8Qys3U+WHe2uQTqZrzBxQ=;
	b=iToNSrYiq6dmD5OXWG4pj30Mh0bARs9vQ6G2/gtgJMV1qQgXNwUekKMDAhUpHfYEy5Se
	 va6ZlFubIwP1MwcT/AM8vqdkRSsZnz1uKgiiLYfouR3J2iwe+zi3A4D0rfMfnUfkNYD/b
	 9ScQWJQwyG+3mZZPr6AZTn8WDU56K2uc8vqfdY5MBC42//EE6WK+wEZiw+MsGgKGvRn49
	 cR348GqH1bTu3DEauR6lS7MmiDsK79bLn437h+IaxuONB7lFhRwRdmWjFPmufYKtJMTxg
	 kaERA+R5Fx7XWESxE3YbnX5IciDPiv8CYbJt9I6PyjxKgQo3WE2kUqWry6zWLdB0vWA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=esxlML+B;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789738372;
	bh=LaLsRlQuyQ/J23Q9iDFSFQ8Qys3U+WHe2uQTqZrzBxQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=p5h3Ll57OXRZoo0UZDZyYqQtZV8PpedIRPLGiQoYaNlYNFk67DeRzbLjayRwbp9u1
	 X6QIqyHJHc1krQca7o1FcplFmonc0lNG04aMf4upgVcsiGm+f6GK8qWcJefmqQAC8z
	 Yob/DDYDuj2ED0IG4xK46a5XbSW8YLqwN6iY9rQY9ncvUf5IOzMS5e3cHRzeoGIBIa
	 bwetasOyrU/ZXH1ncuufREcfn5+RS/3aRcZ9e6GLzKNIpLzcIYNM2GGLur1wS8xrwb
	 Qv8PdVvnNrRtxLSprfJR/WSCP85yHN2E4K26PVpGeH//zWmmgvqrr93ZjmHiS6ZKJK
	 SDx3EySCDsYsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA22760DF1;
	Fri, 18 Sep 2026 13:32:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F224224
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:32:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 148DE60DD9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:32:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CdOX7K-3m_1s for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Sep 2026 13:32:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4FC7B60E04
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789738370;
 b=K789GAi0kz9vgoXc3sltsxRKenOYaY3d7ECQoOzXh0pxynwi2Q9RLE0ckP/6F5kFzE1i
 UjaoUSmpiFz/E3bPzYu5zYQ222gVJDr4Oq9jNJ0cJPIssSFS6GheAdsrdu8w2aNdBvrCI
 LzN6tIMCKt0E2eneom7P8hPcGAWA+zM4UUeZdW1F7nJoSC5lc3bsGBx98IBmIX+V3pdhY
 q1Jd8WD/GZKGCwSxGukvNlhxnXekKcfnC63rNuhjxqyGq8l8FyrvLJATKJmkNpBN7bg99
 +7qUvp8i6QD3SNCnIlcbFGirU/wy336X68LJFPP+XMnmVfZaVbhKoItWcIZR2TPHu4A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789738370;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=LaLsRlQuyQ/J23Q9iDFSFQ8Qys3U+WHe2uQTqZrzBxQ=;
 b=H4Sb58FYJZMv46L1y0n5rVz8sVBDixdlpxX4iehubyjEaOtCOtFKrFWWt8L/xjG7WoNo
 jPQNQmnCD7JLLl2uvrDJ5l4/EwfO/rzZb0Eof2NiU6y4nm/mZYAoRh8Nz1XbACY0LXD2V
 uS5GEQxB6QHw0nTwr1JL/Fx+ayhv6qEsDgXlqkb3xMzNRT025cIdp/+PEdYyRZr+LFMmU
 xgR11cmVBEBo2f0f0ds1iuIMQhT7KQPIulz+cyL6oLHfTeiAKpxkvvQ9Bcu0irrYoGa5l
 2EqPgNFjJLuad/Gv1SUEbZR6A9zfO3FbcyuXFpSvJ2epbZGgFSnGUb7om7LRD050NfQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=esxlML+B; 
 arc=none smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=esxlML+B
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4FC7B60E04
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789738370; x=1821274370;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=x4NN7MqcCe8oyBka/LerpVZGbLjWhhj/Cd4ZI48E7O0=;
 b=esxlML+BTTvaMrTe7MZL6g7H7ZybR5X7YBYCTN1Y7sTv8qQeG87+9Lsv
 mO3E40NerOXbtimM2/TqbbyXN3Lti8yMvnPOj+79MTQTki46y/zl4ZWem
 Rb0euEmPeCMriNBVF3h+DZ1TeIxT0u2WMXkGxruivV+FExIo4eWjgBysm
 heosPWgTpUz4dIjVs0wvVlufDGAHAhOzZ6VmKIFPfv7KQGUjAnETRepBh
 V9TIy2JEmk6s48eW7xl/JWDXKq0Ppmfo9toKptQOurhzDMBYNwVyUhwH7
 c3AstQzS0hN/hlXqwM7bOnQpZS8feLMWTVUP7x7pSoFcDc0VoohuB3cco g==;
X-CSE-ConnectionGUID: FQM4tApLQrOdP5rHcBblmg==
X-CSE-MsgGUID: 5y0GsUtFQkqBq5eGOedeWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="115776436"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="115776436"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 06:32:50 -0700
X-CSE-ConnectionGUID: Pu9sPPbAQfCkDA012+GsgA==
X-CSE-MsgGUID: BOd6jJeZS7isXwJZFSknJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="2835268"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa013.fm.intel.com with ESMTP; 18 Sep 2026 06:32:48 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-net v3] ice: fix LLDP AQ filter fallback not working on
 E82x and E830 hardware
Date: Fri, 18 Sep 2026 15:32:43 +0200
Message-ID: <20260918133243.4169311-1-aleksandr.loktionov@intel.com>
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
Reviewed-by: Simon Horman <horms@kernel.org>
---
v1 -> v2: rewrite as a single combined patch using a switch on
hw->mac_type, instead of two separate patches (E82x fix, then a
follow-up E830 fix layered on top).
v2 -> v3: no code changes, resending to pick up Reviewed-by.
---
 drivers/net/ethernet/intel/ice/ice_common.c | 23 ++++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_type.h   |  7 ++++++-
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 0463310..b31be52 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -6375,15 +6375,28 @@ ice_aq_set_lldp_mib(struct ice_hw *hw, u8 mib_type, void *buf, u16 buf_size,
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
index cf147a2..710c519 100644
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

