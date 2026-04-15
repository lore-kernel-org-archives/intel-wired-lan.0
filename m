Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED066F41986
	for <intel-wired-lan@archiver.kernel.org>; Wed, 15 Apr 2026 10:23:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A046942F76;
	Wed, 15 Apr 2026 10:23:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v58BwINIUQVc; Wed, 15 Apr 2026 10:23:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A887942F60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776248635;
	bh=gEZVvpOWtAo3jOkOvMHkXrCHo+8eIDxkcflIrHSIS2A=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JUKwiOKSmh2ACa7yc9uhArNp8TZQDk97miJJNKjmk4P8wGJIr3XqM6f+vYgCR3192
	 KbAvQWOGhNSXEpR0fF9f4v6zREf58QkUcXmoHKqtqB0iKk5sDga8yawUoP4KtfUf94
	 rli+q6FZIbpGA7HUSIQ5ctua0Dkxs/Q+VnD92EEBj6gyZ9j1zq1UWS1rkWOB4JWv9b
	 TKNc5bw+pT84kyWVtGmpckncMW0yIguOptDcB8K4N+v2ikqReNjfn6K5EZ5lAA4P5G
	 QOVcYJoLQkJtdvHYx/mvr7hB9phNRonHQgvLu0/qSSGyntL/81FuGBaXhc59Sk09MC
	 VfR8kmALPMScQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A887942F60;
	Wed, 15 Apr 2026 10:23:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0ECDD283
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 10:23:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0C7C740384
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 10:23:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5VkLKxokmtDJ for <intel-wired-lan@lists.osuosl.org>;
 Wed, 15 Apr 2026 10:23:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=przemyslaw.korba@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5AF64400A1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5AF64400A1
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5AF64400A1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 10:23:53 +0000 (UTC)
X-CSE-ConnectionGUID: SpGv+dBWSvSH/Qz/oyqC8A==
X-CSE-MsgGUID: IYFZoxWBTFGxcr1ct1rzqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="76253155"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="76253155"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2026 03:23:53 -0700
X-CSE-ConnectionGUID: 34/ajm2JRGOTrYgteCUN6g==
X-CSE-MsgGUID: 7zUJ4OEwQZys7s3FOThcKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="227195533"
Received: from pae-d-dell-r7525-263.igk.intel.com ([172.28.191.240])
 by fmviesa007.fm.intel.com with ESMTP; 15 Apr 2026 03:23:51 -0700
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com,
 Przemyslaw Korba <przemyslaw.korba@intel.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Date: Wed, 15 Apr 2026 12:25:05 +0200
Message-ID: <20260415102511.1560665-1-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776248633; x=1807784633;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=RI7GZLwAPyKhQuIOqJMMLP8rUZ4YP6XPSWVDe77lQyM=;
 b=KbFqk5jQWPwZwoQCPQmOg0aZ4O/VN4QjYUzsMFwRSY/Zj/RxLZlEpuvw
 9SI1vtobDzwriTtsiWVW1F40WcrIg+HPujfXUdM8ByG/MhPdUoOo803Vn
 /N9SW8SNUE2uldAcf2tiTaWaq4gI5HPodHgqoFmucwrfleYbYtVQvjxV9
 EKd4bSfE2dtHgRMEcfXeDMU4cc4Dxld27QUb1D0RT5oiT4RKPJPSkDAhk
 3aSnNdAwd87jJMqwCxDlyABe2ran8AL08p04Gkhg4zC4MbrG3SvngApxq
 358q6KVmMs8XFKwy43FY3SmC+Bp0NLf8JiDo577Y7/lxFVZCoMcXUDl/d
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=KbFqk5jQ
Subject: [Intel-wired-lan] [PATCH iwl-net] i40e: set supported_extts_flags
 for rising edge
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

The i40e driver always supported only rising edge detection, so
advertise PTP_RISING_EDGE, and PTP_STRICT_FLAGS to ensure the
PTP core properly validates user requests.

Fixes: 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags to ptp_clock_info")
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ptp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 7d07c389bb23..c4525bfab09c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -1344,6 +1344,8 @@ static int i40e_init_pin_config(struct i40e_pf *pf)
 	pf->ptp_caps.n_ext_ts = 2;
 	pf->ptp_caps.pps = 1;
 	pf->ptp_caps.n_per_out = 2;
+	pf->ptp_caps.supported_extts_flags = PTP_RISING_EDGE |
+					     PTP_STRICT_FLAGS;
 
 	pf->ptp_caps.pin_config = kzalloc_objs(*pf->ptp_caps.pin_config,
 					       pf->ptp_caps.n_pins);

base-commit: d4999456017dd09ff5f7a34e236c471560d8f8e4
-- 
2.43.0

