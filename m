Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2AECA6004
	for <intel-wired-lan@archiver.kernel.org>; Wed,  7 Oct 2026 13:17:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 832BE607B6;
	Wed,  7 Oct 2026 13:17:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ElEDhdtkgqie; Wed,  7 Oct 2026 13:17:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BF0B460706
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791379025;
	b=UzGeZbw8JovFbAmyGU+vfpfA6sOJWyw817nGPzekVoHGmM3i9XwITeFaRtdu8rXDZrfn
	 GbzcKu6cfnhwkJzWLiDn/fVfibTs1v6FjVOSGMMvrZADEtzSiulFHpvkZ+xNOa6ytmktQ
	 dNWjIItX5ZCoB56ylb2GbMQygBI/30wDeIaPrKHL5Aa6oisn/g3/hqzuaG0jHh7EvXTQb
	 dD7P4mCsAMAFFhlytkwFgSo7O3g8/LCyiZ5NHLKL9yusk9+NXZPI3TR09me9Zg9rtLZ5B
	 i6VfxKf3H4n8iwRuRTxws3TxXkTvXHgPqDx2JkLlEoj6VEubi85hDoJ5jOyRT03x01g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791379025;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bJPzqnRtfWZpGU0DFteSipWF40z2u3A61/ErLEIaTy8=;
	b=o4cKR9CD+CJxL+0+oEdi6HjB4bpnMf+giCv71QOoKxPLYiddc4wg6Ryp4rkbVUhX7jFX
	 rxVlGQSalSYZzvIFnE+lO68LVVYYm/euj/0QRPXGfTjBlxhVZLTFAg5stx3q3PUM04y6H
	 N8rGgRGTHHxytGLpHV7h8jJX5Wt0WQ6Ie7gHHFGcdG01Ms3mX+TxbTETPCauvXxcKjmWV
	 wspSdbDxGTDRfTfe9jJQWwwl/3415fluBCs58XSI3LIqp+2WCRVoMrCcHvUm4s8lJXbMq
	 2VM8dpjqRrJl1OJK9wgugUgFdd9531NkegUHzwkNsrgv5a4yx2QbToktrAzcKCKaukg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791379025;
	bh=bJPzqnRtfWZpGU0DFteSipWF40z2u3A61/ErLEIaTy8=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=3M6v9/kHpgHT8SVtcb2+SFF8u4CzayqK8cx+p86JfcrOSJFfN7gbpM1Rfw3lcwVef
	 VPFxnK5VxhYoGUXuFomx41VAUG70Iaacfy7a3QneolJD/cB7PiLkdK7tlpr8qBiD4w
	 hIIlbou/U61pXvZ6IBrDGIk4Gbm33O+4xO1CQy09FoyBf8lDKHME+We9oFv83r8fBt
	 Lk8VipBgcufF65aLbTz2bUa/SwtG1Pssqkpif4hDDccNc7PtLjRXbGRVUJ0wKOuE8p
	 iWXkwQiE48UIxMyYaF2EhMV0y30Gh4jCXxU2xxpmtz4ooil1wKLELDjceUi0N3Xqv+
	 OQqoa1IVfqW7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF0B460706;
	Wed,  7 Oct 2026 13:17:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BFC9C22B
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 12:48:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A54ED80EDA
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 12:48:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DbgsarQ_oRan for <intel-wired-lan@lists.osuosl.org>;
 Wed,  7 Oct 2026 12:48:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DCBEB80EDF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791377303;
 b=ASUWVBey8aL5mHJqh5uM019OkC1c2M6cpBnHLlf/hdxpRJ8KzazHuGiOUk9yfFNJz1tN
 01eEOHfXYY8YMwOgBcDEOPrI+VX6TDJEBjNkgdQB5OFxoZm/OpN0jXLCVHi9ygEXd6jOB
 yIn0FdW8PYa1oHZZeE8nH4n98uAao1h0MtytxO8gVIeK+mG3wK70EhE7M4vry5SUw2uwD
 GamMyl/+yvWBeAa7wLzDHzJQ5Ra76OxGOiZjS0EByk723MV0hDrO/o/DfsRZAPJF0Y9uw
 RLID5NufxLNT6rEQJrlALAhfnIcZAXDkn9RCNb5P1ajjqmKAAs9V87g8ucYEEaqm2sg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791377303;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=bJPzqnRtfWZpGU0DFteSipWF40z2u3A61/ErLEIaTy8=;
 b=pKiCwn2xKVDEKMoIn9ni7C4Es47enwJEY7MPSVw6x2wVS0XC3C80ek8b9zklcW/h0WzZ
 ghRM1+7beokGXndZkr3tfRxo+bzgrUjly2lXx2SWgl5wxD59gex9EtMCOhDDMLlieTC8Y
 QE+Bc/CuQ5on2lABty1jaeue9Y8opAqcmLlk424SvD10yHBV/rglItmmX90wA+Njsz6Xa
 96dQUrRZdbJr9z1J4qIuuJ73x9ph/9MnTo5l2ebf5AI48wICFEm2ZFQBNsHG0wNDs3NAt
 JzFKLcN2fnSKZrnfnIEm6GiLE8ezagTv4DHOsve8M/QQNfJxZZX+/v/XMQR/ubopW7A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=XBtib1Oh; 
 arc=none smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=XBtib1Oh
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DCBEB80EDF
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 12:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791377303; x=1822913303;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=XH9yV1ZmrvoczLGzkWVf3MNDPy7eTyU3s1e1fgYxQ7I=;
 b=XBtib1OhNrOnrRMgh51PZmhBL1ZOsB+qmYZOI5o2gy6pGDVMKGpzi8CX
 2R4y7I3J2jR0gbpjr0zfYHc8+4ssOQWs9d/WO9hpYwi/Vbu2COsDn3mpd
 WMPOOzEasVoD5S8gdMrL7B+/ZVVUhzYQnwMDw/GgI/YgvTaNn8n4AJFKf
 5hZe5IYQ+zcKLdcbUZWMW8frlXSO+qCR3HbINmw+OAu472eqKC0x++qCN
 NrK/KfyRpcgoslKK7vDW1Rm7MxqLxxRfIvGiP4ACowNSB9cnnrrpTKixD
 QQIJK6ppB9yLj+23hoOxKeQ3/4PVJ5zTir/U6Gz6FiPEN/mzE1C93fnmZ w==;
X-CSE-ConnectionGUID: vgU5QHp/R1+aZ43Sm66sFg==
X-CSE-MsgGUID: bRTM+XseSgCQLLMtF9kvZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="31578"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="31578"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 05:48:23 -0700
X-CSE-ConnectionGUID: DyXxRxGKQvqFBqRjJ980CA==
X-CSE-MsgGUID: admcZ+9ZQxinsfNVse3FyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208";a="281191698"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa005.jf.intel.com with ESMTP; 07 Oct 2026 05:48:22 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Subject: [PATCH iwl-net v6 2/7] ice: Cache struct ice_hw pointer for split
 register reads
Date: Wed,  7 Oct 2026 12:48:14 +0000
Message-ID: <20261007124819.1074675-3-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007124819.1074675-1-sergey.temerkhanov@intel.com>
References: <20261007124819.1074675-1-sergey.temerkhanov@intel.com>
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

Cache the primary ice_hw pointer to ensure consistency between
calls (both parts of a value will be read from the same NAC).
ice_get_primary_hw() falls back to the caller's own hw while
adapter->ctrl_pf is still NULL, so a secondary PF sitting between the
two reads can have one of them resolve to pf->hw and the next one to
ctrl_pf->hw once the control PF publishes the pointer in
ice_ptp_setup_adapter(). These generally are not the same.
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
index c84e37584fa4..c84adc096027 100644
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
@@ -2033,10 +2034,14 @@ static int ice_read_phy_and_phc_time_eth56g(struct ice_hw *hw, u8 port,
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
 
@@ -2210,12 +2215,16 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 		lo = rd32(hw, GLTSYN_INCVAL_L(tmr_idx));
 		hi = rd32(hw, GLTSYN_INCVAL_H(tmr_idx));
 	} else {
+		struct ice_hw *pri_hw;
+
 		/* cleanup.h advises against mixing goto with scoped helpers,
 		 * and this function unwinds the PTP semaphore with goto below.
 		 */
 		rcu_read_lock();
-		lo = rd32(ice_get_primary_hw(pf), GLTSYN_INCVAL_L(tmr_idx));
-		hi = rd32(ice_get_primary_hw(pf), GLTSYN_INCVAL_H(tmr_idx));
+		pri_hw = ice_get_primary_hw(pf);
+
+		lo = rd32(pri_hw, GLTSYN_INCVAL_L(tmr_idx));
+		hi = rd32(pri_hw, GLTSYN_INCVAL_H(tmr_idx));
 		rcu_read_unlock();
 	}
 	incval = (u64)hi << 32 | lo;
-- 
2.53.0

