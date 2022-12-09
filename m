Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7028BC4332F
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Dec 2022 04:18:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC4C582004;
	Fri,  9 Dec 2022 04:18:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EC4C582004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1670559489;
	bh=FpvKSNqdxW9Z3HXbrXaxy+aRgVqvZ2UKLfbbi30d+KQ=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=5QlQSuo0mmS1oVMGcHIxFa1Jd748C/UtDbTJmfqVVg8Gkz1JRR9Q+dDrW1jW2Weo8
	 XE1oC32GPFEwwCnlxnbljjNDWWfN6vCf22PpueisZmot2pz/C/fynrl4PQ3lcZ3hbq
	 0EVHRM5ckU8aihZpIBwyR42giS530LUaslF8n4G0f/LW+So8YWuu4xksudtG1qhuZt
	 QpKVmUMP+puP/xwJ2vkR91Bitf5RUG1DtctWcmtsih8DDS/VgcLObjGt/j1CpGrBBz
	 9WTnyuiB3sf4CHCQwzcqBuaIprmy9qi6PjwqTs46Sp5pxOpCDKWiGd0YzbeXW9gCMo
	 Lxh0atSjU14xg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HTYPgxtMKDHr; Fri,  9 Dec 2022 04:18:08 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 08C3C81FF6;
	Fri,  9 Dec 2022 04:18:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 08C3C81FF6
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id E8D681BF3A9
 for <intel-wired-lan@osuosl.org>; Fri,  9 Dec 2022 04:18:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B344981FDB
 for <intel-wired-lan@osuosl.org>; Fri,  9 Dec 2022 04:18:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B344981FDB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7j3Cfnm6Ex9W for <intel-wired-lan@osuosl.org>;
 Fri,  9 Dec 2022 04:18:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 57F0C81F9C
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 57F0C81F9C
 for <intel-wired-lan@osuosl.org>; Fri,  9 Dec 2022 04:18:04 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="300796317"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; d="scan'208";a="300796317"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2022 20:18:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="649427510"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; d="scan'208";a="649427510"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.82])
 by fmsmga007.fm.intel.com with ESMTP; 08 Dec 2022 20:18:02 -0800
From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
To: intel-wired-lan@osuosl.org,
	vinicius.gomes@intel.com
Date: Fri,  9 Dec 2022 12:15:16 +0800
Message-Id: <20221209041522.30153-1-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1670559485; x=1702095485;
 h=from:to:cc:subject:date:message-id;
 bh=LbezhMLjQGsvElS/FnXRf72YbpuU4/B2af0FSaaxUAU=;
 b=A59hhXJjhKJQ7ihB40EbkBpqdnmD9yeEryI6sv83SdwCAvm1y0baT7iM
 leBdiYYHTlyL9jEs/vnjySAqs2VYvjdFOnGxM4YBRPBUoar4TuIPIwaBL
 aRZ45OeJaPZE5FwvJmNzQOyVmDEZTU9CDPBu/1DJXC/fWXaiMxdklV4je
 qzUnwPJj581MfEJBXWsbUULeeGyfL2/+XBYOUN7AaiFwQI0tSlMZfJstA
 qLiLShtDngMHhkrnMF7SEpwpqS9p3nlKa0WbhlYhjbmPXw7kAwXQGBAqA
 iFTP6Ix6U3yjd7jISO2xbUJHCnHEHBJ50lHz8ATZIOMYKerWbh1UpkF5N
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=A59hhXJj
Subject: [Intel-wired-lan] [PATCH net v1 0/6] igc: Fix for Qbv features
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
Cc: muhammad.husaini.zulkifli@intel.com, anthony.l.nguyen@intel.com,
 tee.min.tan@linux.intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hello!

This patch series fixed the bugs for the Time-Sensitive Networking(TSN)
Qbv Scheduling features.

An overview of each patch series is given below:

Patch 1: Using a first flag bit to schedule a packet to the next cycle if
packet cannot fit in current Qbv cycle.
Patch 2: Enable strict cycle for Qbv scheduling.
Patch 3: Prevent user to set basetime less than zero during tc config.
Patch 4: Allow the basetime enrollment with zero value.
Patch 5: Calculate the new end time value to exclude the time interval that
exceed the cycle time as user can specify the cycle time in tc config.
Patch 6: Resolve the HW bugs where the gate is not fully closed.

Muhammad Husaini Zulkifli (1):
  igc: Add checking for basetime less than zero

Tan Tee Min (3):
  igc: allow BaseTime 0 enrollment for Qbv
  igc: recalculate Qbv end_time by considering cycle time
  igc: Set Qbv start_time and end_time to end_time if not being
    configured in GCL

Vinicius Costa Gomes (2):
  igc: Enhance Qbv scheduling by using first flag bit
  igc: Use strict cycles for Qbv scheduling

 drivers/net/ethernet/intel/igc/igc.h         |   3 +
 drivers/net/ethernet/intel/igc/igc_defines.h |   2 +
 drivers/net/ethernet/intel/igc/igc_main.c    | 210 ++++++++++++++++---
 drivers/net/ethernet/intel/igc/igc_tsn.c     |  13 +-
 4 files changed, 188 insertions(+), 40 deletions(-)

--
2.17.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
