Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4C7CC6B0F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Oct 2026 09:12:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8716F4052E;
	Tue, 13 Oct 2026 09:12:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qxD_uCtXGq5n; Tue, 13 Oct 2026 09:12:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A76374051D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791882762;
	b=boDfBK4pCekWGKL5+ec5rABZFjQ7WqdWGTH6svUYAFZ7h+roFLT36ot5cESpKavc9FN1
	 FeiNd28Zj3XCcNixWk8pgrodRz3wlQjI/S3O6Vt9LXACVtr/hkU0q/FdnD9TI/aYdvXO0
	 kvByA1obG2meO/tL5SAKfo5JkrfodAVWUBhmvAW1Q8mPVVj33IqwVN9ybJtbJk5q3cGIp
	 ssrw+NyCWZ5nVwqjI9eSxOCcCHtqeQHgA51DQkDJ6lAu8jFnsJyNTGKe0mn1JSBsqiccG
	 bXZXsUSC7HRlsx6zjn6pqQZv3pk42JABwFsG9GPEpYukdZwX0U5/jclfo9purPpNZOA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791882762;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=422oYjDGCzZVXg3ZPS+1gHASmtlvGQ6hnKwhfUzjm/E=;
	b=nqtAQjvVRj29pAhci4fEQPguvdQaN66VWf3ydctPpedZu3kQbmOKiFUmmoxKHjllKrOR
	 PRxTkS/Yz8ze+rA12ouJIASJUaf3Cg3mxrMwfn/lCvUaZlEk3JsbdqjkUZrr8VIXGvy3n
	 ZdseoFS8FZOiSINHzhznkPSkm5JeKHR5O2VT6+pnoyQHfD1GXKOKOS74xhspBt+0Tisis
	 bdbwL3a2DXVBSlGaWQp38pYVO9z/P6iA1dlu7wWq9vSqFYbl+gB6ULkBD4kZEdoLS0RlN
	 XQ5XRWfkAATNUlMGv5qOuM4N4wY5DP+nni+BUUOuMeiDZ1g/tS5N3Klqip3ziMpsutA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791882762;
	bh=422oYjDGCzZVXg3ZPS+1gHASmtlvGQ6hnKwhfUzjm/E=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xwr+vrU7rw/is2S4kLu84Ndr8yc4QLF13TVhtJsutOOxzUg2I1htUC/LRtzmLxEYh
	 u08d0OXLbXXMpbm5DzAhs/AN5w+z8v2SsXK9pjWSobyEs+pJBikGkuvBnOc3xTtcjz
	 qmD2bGdxkpW4ENsvYcmOb1wqUuD+ZFKL2v0OFStgR2QCghdpV+kyBzknujLC3ta85N
	 v1r8T6FWT2vouradZuOig7C7PE/S1GScpxqlqE2Vjg6lntxgUWzZ4FHT8gASzgXGiY
	 hjborsxplAumrCCG0/QQ1gUcO5ZZAIC7L08DXKDNrieuAFtlmiicPAOF2BlyJY7Goe
	 2/XSnoKvMkl+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A76374051D;
	Tue, 13 Oct 2026 09:12:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AC22A235
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 09:12:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9E3FE4026F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 09:12:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cqzh8SVwge9X for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Oct 2026 09:12:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 001ED401EC
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791882760;
 b=lCm086PSAnD//mzlnjE5s6Lgean/4ZDGSum46pxjptBsqcqU3yFDaqvNVpngI3Fj2rOW
 /f6EFXUXzXnVagmNA6IzSiM8RM0994PYxf09Y07CITUdCOL2Hg7skc5ebQTRlF7SDklri
 ssFW4xO62qSygzhvvYRUNW7CaVKH5+r+sH8wgGSTxjx2a5TNRoGTG4T/UQbXLM6TxREk8
 ZfZ2CpnMJwKsbjLie6t6Vdd+us1Yc66VjwzqzUijR2wdMgIhLUmSVJsM13OzpitUbGQKb
 VrKOjptRTHLPJG1dvzCZpm3K+ruDbneQ7JYf9+s7+Hb50aY7kZGaOhquNP9ZQJeUwZg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791882760;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=422oYjDGCzZVXg3ZPS+1gHASmtlvGQ6hnKwhfUzjm/E=;
 b=BqARumlJ9P0BMLSQJuiLr654uH1SHtIVdALCjbrq4YCRQxhp7/elk98qj5AoKIU7oDfG
 1V78bJLkCHjvTInn55DdS3QLiFMWJUN7NB+B2E0HY8uFVhT9UPIndEZA2BV8b49m/rPdg
 KT/O306WKa5LvBcjzhLovoR6moPh3Z+AhNfAHx4Al8hjNg42GmpbfxOn0U9ty38TaXsQk
 zZRQOfhba2ZwVkVH4Bk3mrfr+iJ1t+kfSRfpbCi8SKV0geywIpUEQkmugC8nun7mzpPqT
 yb9M58JGq2djyH5+30oiLGZTG2FwLrL8n5GsPaLt59fIRFPfIS9WYyW+sZDMHLUcf5Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=D12kWEZa; 
 arc=none smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=D12kWEZa
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 001ED401EC
 for <intel-wired-lan@osuosl.org>; Tue, 13 Oct 2026 09:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791882760; x=1823418760;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=jqsem4FpMvgbCVUiBTi0Lgd5iIRbmxOxeVMM7A4N/ck=;
 b=D12kWEZaNSKp8VvR8AmMfcCc61HoYuiwZPDdZMOQAtGuRalm4exBKc9h
 XUuIrg0/Nw+tqrn3DHBDeLlI0d447LhybTDJEIQm5Lq5h6lTHEcOif3Fi
 aGWzL+olX+SkW5wGB+STcqFfc2G+5g4I3wfIWnQjphO4R2t252UV92/rm
 Jl8i7I81Yu7GrW9LnH6wG2H41eCfXjAbFyNmbTvkMD4+DA/ePoW0vH6oG
 Gp+IOPJrVZS2HYbz3Ua2STjyiQ8pvW+Beg8Mf4ZwlgiRGJDzep762RnUK
 9i5SZPIf7Zi5jCoXQtihY+TaEP2rWtXCVsm1mYhUtc8KljKVBsSkeCtqB Q==;
X-CSE-ConnectionGUID: o06y1tIqSj6qt/4f6q4fDA==
X-CSE-MsgGUID: siqtCEMlTgOyxeBnhTdFmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="481266"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="481266"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 02:12:40 -0700
X-CSE-ConnectionGUID: vTLC1gmIRoeyQEyWPHAp8A==
X-CSE-MsgGUID: lDhMvP85RdqC44c/SDDPUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1125345"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa004.jf.intel.com with ESMTP; 13 Oct 2026 02:12:39 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@osuosl.org
Subject: [PATCH RESEND iwl-net v6 2/7] ice: Cache struct ice_hw pointer for
 split register reads
Date: Tue, 13 Oct 2026 09:12:30 +0000
Message-ID: <20261013091235.1423979-3-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013091235.1423979-1-sergey.temerkhanov@intel.com>
References: <20261013091235.1423979-1-sergey.temerkhanov@intel.com>
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
index 0c4a48b015fb..cc28779fc0f6 100644
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
@@ -2017,10 +2018,14 @@ static int ice_read_phy_and_phc_time_eth56g(struct ice_hw *hw, u8 port,
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
 
@@ -2194,12 +2199,16 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
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

