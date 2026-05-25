Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4142ECD5BD5
	for <intel-wired-lan@archiver.kernel.org>; Mon, 25 May 2026 14:31:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0FE8D83DB4;
	Mon, 25 May 2026 14:31:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HPIRhNrHMiBj; Mon, 25 May 2026 14:31:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7C06183DB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1779719468;
	bh=MPWLx6a7U3/VgYPQ57K84d85iPiKa8NXVXQpVwwS+lI=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G//C27tHtsdoCMI7IEH/6ls6o86aVA4qmhm74TufDprrEio9e8HniEurgzCm0GUBB
	 0ykwr3aMvRwCufOsnRFRkKsTn29kQWLkWfL+eBHGGGeMKoLac7ZjiA2bKmQegHmQu5
	 QbBApq9WoftMM6tOVe33NF+jVoLu6jCTIGVwBARl2nS6/7duFbjWcmAmGYLOpjxXcT
	 MWUYp7UJ8T+W/ccKvjv4aPRQ/SV//wx447ogx3SHcjaa8Veh/MWRr4uZkAGWymBTQs
	 IsJ/bXDOmTvNUFyLY4TzQYbDWqczSp5tONYDyr0MD4Cu+fZGMdcoNS4GJr3QtCNJ3C
	 sEmdiMfBGg+uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C06183DB5;
	Mon, 25 May 2026 14:31:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 10055265
 for <intel-wired-lan@lists.osuosl.org>; Mon, 25 May 2026 14:31:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CD42183506
 for <intel-wired-lan@lists.osuosl.org>; Mon, 25 May 2026 14:31:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aaD_1TmF8Tfp for <intel-wired-lan@lists.osuosl.org>;
 Mon, 25 May 2026 14:31:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 358B083D9D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 358B083D9D
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 358B083D9D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 25 May 2026 14:31:05 +0000 (UTC)
X-CSE-ConnectionGUID: RFfh9IbrQi2jDu5RgzPpEw==
X-CSE-MsgGUID: xHK831FURAKCIwktgwIviw==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="80596728"
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; d="scan'208";a="80596728"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 07:31:05 -0700
X-CSE-ConnectionGUID: hHs5wAhXRv+p9/mPvm0EBw==
X-CSE-MsgGUID: CKSAPFK2TKabet8uwMF9aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; d="scan'208";a="237189241"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by fmviesa006.fm.intel.com with ESMTP; 25 May 2026 07:31:04 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Date: Mon, 25 May 2026 14:31:00 +0000
Message-ID: <20260525143100.2758251-4-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260525143100.2758251-1-sergey.temerkhanov@intel.com>
References: <20260525143100.2758251-1-sergey.temerkhanov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779719465; x=1811255465;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Xa1s0agnNmenvv1ynBTH8x+Twf9QnOHXvqBbQZuJOAo=;
 b=eq47HiLIgffp3wbwvImrdrYjXcuzNi1iYIacvgRiRZZcgTMkb+LYpcBQ
 nuosM05QvYAXmMp39tGnzATQuAVB2vOzRrD2JBhWG+NSF5ei6lnCfJNfG
 HLIuSgTcBtt9JN8ddtPoF04ju/HxYAfFT6o62zty2WuXejJOxE30UNhKU
 fGaU8hksDIhbJtrABxzNshP4h+o3CcpaeUEslHZaL/YO3qdG5+V4ZnUKB
 Esfi58lMHTT/GhQeqqBiNXC3cLNJF6zDynLkWaTXItfD9Rk+BbxIuVPg/
 ImfOgxEdRTVTkWHNX4G7lwvY32DkWnPWXdmiBPzTxtK4gXN6L9WZW/k/g
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=eq47HiLI
Subject: [Intel-wired-lan] [RESEND PATCH iwl-net v2 3/3] ice: Cache struct
 ice_hw pointer for split register reads
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

Cache the primary ice_hw pointer to ensure consistency between
calls (both parts of a value will be read from the same NAC).
ice_get_primary_hw() will never return NULL, but during the
ctrl_pf cleanup there may be a case when one call will return
the pointer to the ctrl_pf->hw and the subsequent one - to the
pf->hw which generally are not the same.
Struct ice_hw is embedded in the struct ice_pf so it is protected
by the same critical section - no additional synchronization is
needed.

Fixes: e2193f9f9ec9 ("ice: enable timesync operation on 2xNAC E825 devices")

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Tested-by: Frederick Lawler <fred@cloudflare.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 3cb05879cb3f..2755e33f9203 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -4,6 +4,7 @@
 #include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/iopoll.h>
+#include "ice.h"
 #include "ice_common.h"
 #include "ice_ptp_hw.h"
 #include "ice_ptp_consts.h"
@@ -1943,10 +1944,14 @@ static int ice_read_phy_and_phc_time_eth56g(struct ice_hw *hw, u8 port,
 		zo = rd32(hw, GLTSYN_SHTIME_0(tmr_idx));
 		lo = rd32(hw, GLTSYN_SHTIME_L(tmr_idx));
 	} else {
+		struct ice_hw *pri_hw;
+
 		guard(rcu)();
 
-		zo = rd32(ice_get_primary_hw(pf), GLTSYN_SHTIME_0(tmr_idx));
-		lo = rd32(ice_get_primary_hw(pf), GLTSYN_SHTIME_L(tmr_idx));
+		pri_hw = ice_get_primary_hw(pf);
+
+		zo = rd32(pri_hw, GLTSYN_SHTIME_0(tmr_idx));
+		lo = rd32(pri_hw, GLTSYN_SHTIME_L(tmr_idx));
 	}
 	*phc_time = (u64)lo << 32 | zo;
 
@@ -2114,10 +2119,14 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 		lo = rd32(hw, GLTSYN_INCVAL_L(tmr_idx));
 		hi = rd32(hw, GLTSYN_INCVAL_H(tmr_idx));
 	} else {
+		struct ice_hw *pri_hw;
+
 		guard(rcu)();
 
-		lo = rd32(ice_get_primary_hw(pf), GLTSYN_INCVAL_L(tmr_idx));
-		hi = rd32(ice_get_primary_hw(pf), GLTSYN_INCVAL_H(tmr_idx));
+		pri_hw = ice_get_primary_hw(pf);
+
+		lo = rd32(pri_hw, GLTSYN_INCVAL_L(tmr_idx));
+		hi = rd32(pri_hw, GLTSYN_INCVAL_H(tmr_idx));
 	}
 	incval = (u64)hi << 32 | lo;
 
-- 
2.53.0

