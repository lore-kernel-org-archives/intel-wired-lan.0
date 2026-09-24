Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC609C9831D
	for <intel-wired-lan@archiver.kernel.org>; Thu, 24 Sep 2026 12:59:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A4BC40CAA;
	Thu, 24 Sep 2026 12:59:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6loCQ95Z2q-A; Thu, 24 Sep 2026 12:59:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CC4CD40CD1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790254776;
	b=bDFBKApERLdUcMwqRamTidR1RvAL3nvNkyv49Vwd5LJ8qCXnQ+/3gNHStyTNMaQl8tzX
	 MCcG2Cgkl2A+T92Xj/JqDEbf+l3E9TCDImb8x6T/eEzNxhKLXB8lQc0n+hOuWtdK4qr6j
	 6DBuPbZ1rde/HSnRWITZHYA2E/4DTimwT3HdnfGTsV1j7rbxK5UxO2r9vmhb1TMBBT9ei
	 A9awwMwuBH9pzkKjZyhIlVY50Bq1Phfd5i5S/yNmbRrguqEKmOEIjFaaWWengVku+Sm0G
	 mBZmw6mfqmpSJeCs9aHr7AfRB0v+Qb14xWR2zeQAQwJjbNJGxE6wRrUJFl3x9/eeMDQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790254776;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=z/J+Kpr21I5RaBfN3Awgd1ygTosfYnt3RzYbtX61gek=;
	b=PkxWvTxmjVsj8Wers45C2BlAnD6GYT5XQBTtzSPoGp6hUEj/2Pa8s34zH4lsVD6MJQoC
	 ueVqN+9Sf+DkV9ccb0oUJ5o6yZ+6DEeuewUnSzXSI5BMzYVDkTtErUQNqhzQzKNDZ20ww
	 jJwkqI5DO/YL10C23PJfofu8DkSsPS+ubsHoGMfAidvZV4VLaARbUZjDVdG7ti00CO9Cj
	 VbP2u5bYIJLbvwb/ceJ8pEPC9Wkgsbz0K9ygIqhmfFmMKhM2e+M3DOjx0P/X4qYyG+oJi
	 FfS+zIrpqez5N7N8sAMPYkhdHdyBHm2/YWJivD/o5eLoiBn6STvjQRZSuFB00/AbqZg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790254776;
	bh=z/J+Kpr21I5RaBfN3Awgd1ygTosfYnt3RzYbtX61gek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6sk9r38h/sbsS4/7tgl1+7sFd5U/GsNvaTTB5Ua6H6oDp03ggy8ADKrzKjD6wPqPV
	 kEgwSQD/VXMZxzBMlY7F8XzaYktg4ipA5/chKMq6fLljyaQXgE168gXsYzXCclnreE
	 Ic2dSPXECBNwd4zw4Za4xZBVNX5p2hy4C8ZyXFrvvmyBhNLnokmuOJXAQMPm2+mpwi
	 02T8xhSDmGTZMHgtuV6o08ZT+Bzia+CO0PbwyTlF4vMzBjK8rPECpR4ej8bsMyFQld
	 Lszy0qVWE0QNAnK3eR+auwMe58qidT8fcnYAhYyXpU0jgi57Jv1GC2kCm6OTv84l0E
	 VpTWcFpoi32YQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC4CD40CD1;
	Thu, 24 Sep 2026 12:59:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CA039194
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 12:59:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BB95840473
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 12:59:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R2csf6fuMJ_4 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 24 Sep 2026 12:59:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org DBA0B400FB
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790254772;
 b=BRL6JCXJiy44QH9pHWOb5+TxhFuSa/WBiMKOErLb32KnLNRmvrDjxFUzx3qWlur4Vqth
 2UNUdfqE5wQI46wO5IDHWelpQmPKUFpW/9+GdMp42xASNF0ty0QrmJO6LJqH6ifhLy7Qo
 TOYb89/Nkvo4P3F57apsmIR0dkJi5M2ck4JPHbvFcNP5aMXEU1vIYJowRNTRuIn/HO9y6
 Ci0viLCNny38kZPFOTFi4a6OzYWoKb/UGZqlNIeXRpd+xAlL++bBaWASg3QzBywlqiCx6
 auz/xcQAwb/H3dS+bDFWHULeWTEv1BnDTmoxzHrrbE+sQqXWBzLKczszevMiu4+GBvA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790254772;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=z/J+Kpr21I5RaBfN3Awgd1ygTosfYnt3RzYbtX61gek=;
 b=d1Y46PtbDlqd+nJ0ldseznRvgEdmoY7VfhjXOSqLbgLKbEMo9w8Lmny7q9ubEa3Xg7Tl
 SZu9iVmsepPvzkuuemVeXJGkNn3pSMnqFMKQuKuKYsvanRCk47V00vC1yUYSuNskgHFhG
 iMX4CMw9I2vG1QqhaTbLRBwnBZK8FY60atSU6zCMBDBn5hc8TeGD0boDAR9NF6f8D9vXk
 9y4l2NvInU1fgUwSpkiR1qqcTlYnhM6MsOUa2ikql5ep4S4ISdfzeWo1dK46ytgyyM79b
 QRsC2ar9WoOA9C4nDw5Jry1Yvs7ixILV15yggIUsSCl3i770aR3As+tUYsxeNpNUjKQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=V0Lj31i9; 
 arc=none smtp.remote-ip=198.175.65.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=V0Lj31i9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DBA0B400FB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 12:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790254772; x=1821790772;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LZ9TrTcQM9inz6/eTHV49ReXqnEAzy1K1Bj4zEwKK5E=;
 b=V0Lj31i94x3PF6g9L/ZMDDfw65Rl7d0OtZMu7qiQr3fsJRcbn6dWPVsl
 si2IkoWt+C+SPPpmlZ97GwYTVkn6H3toxGXJYsmDitcqtT0zH/mfIqkeU
 +yrIKURA5i6vLoiSmXl/WziWhrnwIOtPtq+zEGypEvrib4R7NU+z7Sq3d
 tFsTk++K7QgvddVNfrTE3bkUF8BwaN7M0ihJ4ymtF+UvpIPwQueM0AYZ+
 h3+owg/q0kxu/vS21u7dM2aAArI2+Fikgp3ZmP5AznvHEls7XG28W6c3D
 dYxsBtrq6MHGt9qB55sYWwFLqCKwZc0aR6dbG/E2Bk37GFwKtckAz0D/c w==;
X-CSE-ConnectionGUID: wPqtQ789TAKpxk/Tm6cPhA==
X-CSE-MsgGUID: 7YzqrF4rSAWKNrw0x7NHcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="90249224"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="90249224"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 05:59:21 -0700
X-CSE-ConnectionGUID: h+oSSchvRamarbfU0jEiBw==
X-CSE-MsgGUID: 62oj8oixS3uo4IEQNG1g+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="311934425"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa001.jf.intel.com with ESMTP; 24 Sep 2026 05:59:20 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net v5 3/8] ice: Cache struct ice_hw pointer for split
 register reads
Date: Thu, 24 Sep 2026 12:59:11 +0000
Message-ID: <20260924125916.2796499-4-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924125916.2796499-1-sergey.temerkhanov@intel.com>
References: <20260924125916.2796499-1-sergey.temerkhanov@intel.com>
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
index 0e138390f8c8..38e90a68ba78 100644
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
@@ -2014,10 +2015,14 @@ static int ice_read_phy_and_phc_time_eth56g(struct ice_hw *hw, u8 port,
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
 
@@ -2187,12 +2192,16 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
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

