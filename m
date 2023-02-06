Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244A5C636D3
	for <intel-wired-lan@archiver.kernel.org>; Mon,  6 Feb 2023 23:57:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5906408BC;
	Mon,  6 Feb 2023 23:57:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B5906408BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1675727828;
	bh=ZlBuco3wQo0CgmiSpWjmp/fOD1XD5vAJKK4nvAF13HM=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=FWhZLK6+tPo6azNpW5q7H0omDS4AgxfXOZQwBTG78lJJa6CFyIybvBYfUWVmGsSgP
	 5/bnVyR7frt2/8rCMKOlQneD7cAgF0wl5Blf24RsVIqxR8t/0uqTH/mXjv3tHsmFA2
	 LAlxHiRKUpG9XgNJxT1VwihsmAj4i1AxyMAKQ8kf5a7MHMwe3+jGx9aesDF4kbedGF
	 KrjSOzh0P491IaWBoqf4vuCVG69/QqQcoq9GrvPMc/7kg5hlBTG0yEhEzk6genWS77
	 /gjJzajAxd322k4fUrFq0544j/REseV+qSTz1GCnO7uIoTb9AgSDik53QyzktajF1i
	 SwOf5KRUFANQg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hJ1TpqZ3F0wy; Mon,  6 Feb 2023 23:57:07 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B1BE40905;
	Mon,  6 Feb 2023 23:57:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7B1BE40905
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 472421BF3C5
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Feb 2023 23:57:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1EDC140905
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Feb 2023 23:57:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1EDC140905
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SYjPxWx0K1uc for <intel-wired-lan@lists.osuosl.org>;
 Mon,  6 Feb 2023 23:57:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0673A408BC
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0673A408BC
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Feb 2023 23:57:03 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="327034370"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; d="scan'208";a="327034370"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2023 15:57:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="616606982"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; d="scan'208";a="616606982"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
 by orsmga003.jf.intel.com with ESMTP; 06 Feb 2023 15:57:01 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com
Date: Mon,  6 Feb 2023 15:56:35 -0800
Message-Id: <20230206235635.662263-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230206235635.662263-1-anthony.l.nguyen@intel.com>
References: <20230206235635.662263-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1675727824; x=1707263824;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PX6gOGQCKgkMTkVGOsvAFMU6mr14Coj7ILxTYQtpsO8=;
 b=XKxcC7nE2liTm1Lwrge2M7oUPuFONHZFxFilZCMqCDQ1qOBeQ56JG44H
 KQizdh+/o00i+/dUCiaaBR0/JW5FuvaXajgbFUPAn8WuFfP29QWAWH2On
 jFycxB68nEFmh9NwaebxSPnKCnwCEWh53yF4GDYkJBLc0YXTPl0307kE2
 K9/a6dFp+tqRGXxi0WYzFnArGvp+5//3f44+N/7SM4iTr1mRvNPpJJ7UK
 u0VaP7XUhfL7FlZI3qkE2/iMi0AODKbR8S/Sqxd6ubNJN6Ixk9LvilzCz
 EXr9iLplfyyF/LmH/veMHhBx9/hWx1uFWeK23vz8nbFpzhYLloQzXj6rc
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=XKxcC7nE
Subject: [Intel-wired-lan] [PATCH net-next 6/6] net/i40e: Replace 0-length
 array with flexible array
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 intel-wired-lan@lists.osuosl.org, Jiri Pirko <jiri@nvidia.com>,
 anthony.l.nguyen@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Kees Cook <keescook@chromium.org>

Zero-length arrays are deprecated[1]. Replace struct i40e_lump_tracking's
"list" 0-length array with a flexible array. Detected with GCC 13,
using -fstrict-flex-arrays=3:

In function 'i40e_put_lump',
    inlined from 'i40e_clear_interrupt_scheme' at drivers/net/ethernet/intel/i40e/i40e_main.c:5145:2:
drivers/net/ethernet/intel/i40e/i40e_main.c:278:27: warning: array subscript <unknown> is outside array bounds of 'u16[0]' {aka 'short unsigned int[]'} [-Warray-bounds=]
  278 |                 pile->list[i] = 0;
      |                 ~~~~~~~~~~^~~
drivers/net/ethernet/intel/i40e/i40e.h: In function 'i40e_clear_interrupt_scheme':
drivers/net/ethernet/intel/i40e/i40e.h:179:13: note: while referencing 'list'
  179 |         u16 list[0];
      |             ^~~~

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays

Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 40a2914ed0ba..be66dbc9c1d4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -177,7 +177,7 @@ enum i40e_interrupt_policy {
 
 struct i40e_lump_tracking {
 	u16 num_entries;
-	u16 list[0];
+	u16 list[];
 #define I40E_PILE_VALID_BIT  0x8000
 #define I40E_IWARP_IRQ_PILE_ID  (I40E_PILE_VALID_BIT - 2)
 };
-- 
2.38.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
