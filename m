Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D437FF8875
	for <intel-wired-lan@archiver.kernel.org>; Thu, 30 Apr 2026 12:26:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 32078617A0;
	Thu, 30 Apr 2026 12:26:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fN8s2OY5EE0x; Thu, 30 Apr 2026 12:26:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A687B6152C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777551968;
	bh=cG2dGev00flescZ6y5TU3H+rWJSgP4T65oPPI9TVdvg=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=7oNCcAdQn0aZJDRVyNDbiwKeMOAL/IvWoak3DtvMElTfsQFfRFIyVGAp9ysH8GKBX
	 FKhJXKjOONfQACoBDEbB3zEDTL2S7ojZyq8+F7UWHMj5G1YsHP1K7Rk+2ZAyhHIrPJ
	 BKLvd8YPykcz4MlscffCmLb88gZbs+vRvKpwmAmgB67rQ9v4DkQNL+k3lrWqppSM0G
	 +AQApz/8YVsKpLpVQDLYWEio16aOhB1C43VF3MXUVeWD9F/h/r5cic7gZXoAkYZo82
	 LK7GaKBDMmNQGcul9xKvhpy2pK7N8Mj8mJe+wyopOlnT58EDYLqbiUtyx1x/DNVc6M
	 RPR/VGc5h6tsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A687B6152C;
	Thu, 30 Apr 2026 12:26:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2031218F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Apr 2026 12:26:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1E683403D6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Apr 2026 12:26:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a-z9Q_nAm-sQ for <intel-wired-lan@lists.osuosl.org>;
 Thu, 30 Apr 2026 12:26:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7899E4073C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7899E4073C
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7899E4073C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Apr 2026 12:26:06 +0000 (UTC)
X-CSE-ConnectionGUID: kGXpTR/xSvy4p0xwmZql6A==
X-CSE-MsgGUID: fUyURqiDQHqhYFt33DiczQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78689182"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="78689182"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 05:26:06 -0700
X-CSE-ConnectionGUID: iGpTe9cgTJqrJcYaeqGlxw==
X-CSE-MsgGUID: Mfr2tqbKTTGcHSYViPM7Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="233538423"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa006.jf.intel.com with ESMTP; 30 Apr 2026 05:26:05 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Date: Thu, 30 Apr 2026 14:25:58 +0200
Message-ID: <20260430122602.126722-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260430122602.126722-1-aleksandr.loktionov@intel.com>
References: <20260430122602.126722-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777551966; x=1809087966;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Y1C501JONhNNAVfQFgCHZpYKC+oUFWqSXemVKft+MIg=;
 b=nayGQg+B7Gc3uO0EQzfKR2gd4XkSwxZtx96EgQCioFfJp16MBZv+LZOo
 r+m/PQbFpz/MSPForFF6Ns7tVckUDn/zRFkoBQPGG8GEhXr52zzM+lS/N
 z1Vj6d6vaYjBDJI2kVsvA7cTPYsDk7ELMOgjUmxcjvBkvit8OrrBx0Xgn
 Nsdo4ul5eWsyKabbr5lsrhk/pMpbqZH+McdC/UkbARZqWDuU4pVaINW6J
 uuQkHPab9CSY8oxp4mHtd+F5wl//0s2/bDFvdmcL4zTp/iBICKqCZvCMz
 iKtjyKcmN2Z2TzV3CBZuI/06R0a6/JkKRuL6k1HM/kTOkX5luyvE1Ze2X
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=nayGQg+B
Subject: [Intel-wired-lan] [PATCH 1/5] ice: fix ETH56G Rx offset type
 description in kernel-doc comment
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

From: Karol Kolacinski <karol.kolacinski@intel.com>

The ETH56G MAC register configuration Rx offset field stores a signed
integer, not an unsigned one. Correct the struct comment that incorrectly
described it as '11 bit unsigned int'. Also update 'unsigned ints' to
'unsigned integers' for consistency.

Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 9bfd3e7..c1aa408 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -144,9 +144,9 @@ struct ice_vernier_info_e82x {
  * @tx_offset: total Tx offset, fixed point
  * @rx_offset: total Rx offset, contains value for bitslip/deskew, fixed point
  *
- * All fixed point registers except Rx offset are 23 bit unsigned ints with
+ * All fixed point registers except Rx offset are 23 bit unsigned integers with
  * a 9 bit fractional.
- * Rx offset is 11 bit unsigned int with a 9 bit fractional.
+ * Rx offset is 11 bit signed integer with a 9 bit fractional.
  */
 struct ice_eth56g_mac_reg_cfg {
 	struct {
-- 
2.52.0

