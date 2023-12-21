Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F127CC35274
	for <intel-wired-lan@archiver.kernel.org>; Thu, 21 Dec 2023 16:18:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B060E42238;
	Thu, 21 Dec 2023 16:18:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B060E42238
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1703175529;
	bh=IcNlJCiCMZH0JULC2I4nGMrY8ozFbOkr/1/QOjSaMBA=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=VicrqqWzrH/KnLiSEvHQRNtMG96VBTAhvxJopLXOdY/C6JMGJsR7xX3ZyCV1wAsNS
	 dZSfAKuOCeq1DfrnmNkmdLBsvgglg7wnESJQRUs2udpGGpn63rbqqFnGP8LBWh+rgP
	 FFdUOGvo60E19xQAzl0+H+PDcq2xMxOkDHptG/TpPZBiEqLG/1MVsgFp7XXoFrXz+s
	 BoJXcd9pvogekjW+d/+aB00fQu3trmhNXNzsGbZ0pS4UuVyfybZ3r6jr8bWAQCflO+
	 priUPQE2eGvIvnuy52crwV5K624J/O+37A5ps1YlbcHwG4pcRltrDGnh+FPegsk3Ki
	 PZeOrnXMarScg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sQbYlEhTEXjf; Thu, 21 Dec 2023 16:18:48 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A96A4223A;
	Thu, 21 Dec 2023 16:18:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9A96A4223A
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 202131BF3BF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Dec 2023 09:34:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E246241680
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Dec 2023 09:34:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E246241680
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IWHmUQ272Sgw for <intel-wired-lan@lists.osuosl.org>;
 Thu, 21 Dec 2023 09:34:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3A110415B5
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Dec 2023 09:34:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3A110415B5
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="3188663"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="3188663"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Dec 2023 01:34:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="810918264"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; d="scan'208";a="810918264"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
 by orsmga001.jf.intel.com with ESMTP; 21 Dec 2023 01:33:53 -0800
From: lakshmi.sowjanya.d@intel.com
To: tglx@linutronix.de, jstultz@google.com, giometti@enneenne.com,
 corbet@lwn.net, linux-kernel@vger.kernel.org
Date: Thu, 21 Dec 2023 15:02:53 +0530
Message-Id: <20231221093254.9599-10-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231221093254.9599-1-lakshmi.sowjanya.d@intel.com>
References: <20231221093254.9599-1-lakshmi.sowjanya.d@intel.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 21 Dec 2023 16:18:06 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703151241; x=1734687241;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=M7wCBVGLoY9FqwR8B4e75uBEBjNx5OX2ShepOLnPD5U=;
 b=Xc7qYxfpNj37rcoTl/bPAFjcbeyP/Vp0Af9j7XC7EnWuHqDC6sfhakmj
 8FwA0x//BXLubnqclnuL+dARmCstJXWp/5kjMQQTU7GFAmio3YiI78j5/
 NddQDOhkiE2EYdvKncA9aDWLyPVJiU5V4aOwejtm65tI1b7ryIeWN3UIo
 +WHPPLXPoa0RQqQPhW1+5FaP+z6W1SLPHBszByNB3dJ7rcPPg8RbT3fLA
 Jl7YsB/qFlHqtxoC645UuXCwn79ZJxTEqP7yqo//zkU+XewOoUnsM8R0S
 2hBBhV50GMvSHzgLL07X5J04dr98HoFBNSHS1nEDbgI+CQKumvnxn/u5U
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Xc7qYxfp
Subject: [Intel-wired-lan] [RFC PATCH v2 09/10] Documentation: driver-api:
 pps: Add Intel Timed I/O PPS generator
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
Cc: christopher.s.hall@intel.com, lakshmi.sowjanya.d@intel.com,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org, pandith.n@intel.com,
 x86@kernel.org, eddie.dong@intel.com, jesse.brandeburg@intel.com,
 linux-sound@vger.kernel.org, alexandre.torgue@foss.st.com,
 mallikarjunappa.sangannavar@intel.com, joabreu@synopsys.com,
 intel-wired-lan@lists.osuosl.org, mcoquelin.stm32@gmail.com,
 thejesh.reddy.t.r@intel.com, perex@perex.cz, anthony.l.nguyen@intel.com,
 andriy.shevchenko@linux.intel.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>

Add Intel Timed I/O PPS usage instructions.

Co-developed-by: Pandith N <pandith.n@intel.com>
Signed-off-by: Pandith N <pandith.n@intel.com>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/driver-api/pps.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/driver-api/pps.rst b/Documentation/driver-api/pps.rst
index 78dded03e5d8..cb1e4d814d37 100644
--- a/Documentation/driver-api/pps.rst
+++ b/Documentation/driver-api/pps.rst
@@ -246,3 +246,25 @@ delay between assert and clear edge as small as possible to reduce system
 latencies. But if it is too small slave won't be able to capture clear edge
 transition. The default of 30us should be good enough in most situations.
 The delay can be selected using 'delay' pps_gen_parport module parameter.
+
+
+Intel Timed I/O PPS signal generator
+------------------------------------
+
+Intel Timed I/O is a high precision device, present on 2019 and newer Intel
+CPUs, that can generate PPS signal.
+
+Timed I/O and system time are both driven by same hardware clock, The signal
+generated with a precision of ~20 nanoseconds. The generated PPS signal
+is used to synchronize an external device with system clock. For example,
+Share your clock with a device that receives PPS signal, generated by
+Timed I/O device. There are dedicated Timed I/O pins to deliver PPS signal
+to an external device.
+
+Usage of Intel Timed I/O as PPS generator:
+
+Start generating PPS signal::
+        $echo 1 > /sys/devices/platform/INTCxxxx\:00/enable
+
+Stop generating PPS signal::
+        $echo 0 > /sys/devices/platform/INTCxxxx\:00/enable
-- 
2.35.3

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
