Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4B6C624C2
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Mar 2026 09:19:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 54F8341936;
	Mon,  2 Mar 2026 09:19:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ijMq3esEbJHK; Mon,  2 Mar 2026 09:19:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D6C1A41935
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772443147;
	bh=yoBTkaKvT8pdh0lE9Ol3eBIXMdU0m6Z5Fq3Ww5MtInw=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TXY42mgB5TjE6ahin3AXc7sZfMcpGt0dl+SarunWR613lQye/hzJlLD81l3+LANhc
	 mXEZ2RN9fWhMtC5mu2ycGpldiX6undvDnz+ONV5Da7I/RlqPhG5ZNimMLHXFQ2pJxG
	 8RCQ5XhWJ15y0YpD0LwIWjpNdffq+NwVLLEaJUnte9tXpNO1NjZCZRQQHwYCdSsVqU
	 sg6zddZmZsmCg+98gSb4H+4666VqtHTR2FXLgxB1Fg6etAfmUYCkq91uzk/yHhW8xM
	 vT90RB7UHwlgTfD0UAExmhpClC45VSoT4XUibOVpidvfLrSyKKBaGfV17gdbKKfN+n
	 iLTpCwcg3WzgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D6C1A41935;
	Mon,  2 Mar 2026 09:19:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E1F61EB
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Mar 2026 09:19:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0F34241935
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Mar 2026 09:19:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N9YF-sssHhAV for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Mar 2026 09:19:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7555741934
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7555741934
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7555741934
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Mar 2026 09:19:02 +0000 (UTC)
X-CSE-ConnectionGUID: 0AA3T3vGTJmbRVYTxEq0Hw==
X-CSE-MsgGUID: Fa7N/0iWQB2NIVDtpQBJ8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="72647454"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; d="scan'208";a="72647454"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2026 01:19:01 -0800
X-CSE-ConnectionGUID: 2ghGkbMwSH2TPOwL7mno6Q==
X-CSE-MsgGUID: EoY13vYkSg2GHvAEBPzpQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; d="scan'208";a="240613153"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa002.fm.intel.com with ESMTP; 02 Mar 2026 01:18:58 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
 id 5B91B95; Mon, 02 Mar 2026 10:18:57 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Date: Mon,  2 Mar 2026 10:18:31 +0100
Message-ID: <20260302091856.2222240-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772443143; x=1803979143;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1T5jU8BM8aGqH2YE4YCnDvTDBiGjYhdQnvpP2XUVzG4=;
 b=MUytdbGV5qtZSJhDE+dJjD3pwZh0obnSM37qgv1on6ciykj4hFuzdCCg
 RM/zGE91iDrFfNoIB6S3rmj3Wqo2uSJA+/DJzWuRpVeOKbMQrJbvyV1N4
 d0MAJ/rkl0BfL87Jfm1WCAFdv3xcNicUrH2Ql1nCOLOAAvHS34uTeG3eQ
 6y6VdOp4iB4d7Tdh765hGcZuV+VkIjTe1fezdnaDSa70praOJj20UhP+v
 0u/ObrkHe9TVjNQLrycEMDjr4E/n4+GxxxjEuSAcF4BTRU+sucS8ZUgfx
 SLnyCPq8olgxtpl9wmOiaJNZqdoOkIV85Nboy+Z19bCD5BoRQ9Lh4PUER
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=MUytdbGV
Subject: [Intel-wired-lan] [PATCH net-next v2 1/1] i40e: Add missing
 wordpart.h header
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

When cleaning up another header I have met this build error:

drivers/net/ethernet/intel/i40e/i40e_hmc.h:105:22: error: implicit declaration of function 'upper_32_bits' [-Wimplicit-function-declaration]
  105 |         val1 = (u32)(upper_32_bits(pa));                                \

This is due to missing header, add it to fix the possible issue.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: elaborated the header in the Subject (Paul), added tag (Paul)

 drivers/net/ethernet/intel/i40e/i40e_hmc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_hmc.h b/drivers/net/ethernet/intel/i40e/i40e_hmc.h
index 480e3a883cc7..967711405919 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_hmc.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_hmc.h
@@ -4,6 +4,8 @@
 #ifndef _I40E_HMC_H_
 #define _I40E_HMC_H_
 
+#include <linux/wordpart.h>
+
 #include "i40e_alloc.h"
 #include "i40e_io.h"
 #include "i40e_register.h"
-- 
2.50.1

