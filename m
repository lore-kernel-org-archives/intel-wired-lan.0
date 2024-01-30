Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AEFC47DB3
	for <intel-wired-lan@archiver.kernel.org>; Tue, 30 Jan 2024 03:04:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA4DA414C8;
	Tue, 30 Jan 2024 03:04:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CA4DA414C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1706583841;
	bh=hvVNlWiFD6Pon6omx4RdLB72TqQ+ishm6CfEeobRBJI=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=63oOLwSm/q8gCjP1KhWRoGMSIW0i0WHnxUg1iwV0ccgftkIfSkK8QGHrmdGNAZS6g
	 SV0LoPql6uVKeLuSckD+uuKpGNDSgeHuKpTrUgjyP6W9oTqD9CMLrO9uUz8E3OIMel
	 sWUpPt1rJzpMuTrYOBBrpZ3C1WEoNp8ZaXDle3ocPDdjh0+/BO28XIRDvL2A0CpB92
	 5ItDsl5h3lXNVIg82YG06jGvRTdvD/rFgMKOrTsl6seLVZ6M2rEZd268ZAoZrsKYrG
	 kuBFXi49gwIc5V9wtAKeXUqTxpZSp9/yghVaFce6U/iPFORK0/bYZQfP+2vr/eOAde
	 QJilYsHxMBH/A==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PpKcNjjRfMaH; Tue, 30 Jan 2024 03:04:01 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id E4E45415BB;
	Tue, 30 Jan 2024 03:04:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E4E45415BB
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 8C9961BF2A7
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jan 2024 03:03:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5331C4064A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jan 2024 03:03:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5331C4064A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VbgAuH4dKtD8 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 30 Jan 2024 03:03:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 65123402BC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jan 2024 03:03:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 65123402BC
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="9892438"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="9892438"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2024 19:03:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3521609"
Received: from wp3.sh.intel.com ([10.240.108.102])
 by orviesa005.jf.intel.com with ESMTP; 29 Jan 2024 19:03:52 -0800
From: Steven Zou <steven.zou@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue, 30 Jan 2024 10:51:44 +0800
Message-Id: <20240130025146.30265-1-steven.zou@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706583836; x=1738119836;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=lzFLBAut8yM5tB+UhaTZSmCibKMmV25eq3SsNLBe5hs=;
 b=a1D+Mfu5342DchJV4WvSYWFuv+43qCVjmmuLZuFlIyAUzYV5CKKotSBt
 jpJ6UnV8QfhZN0KQnGjZx4jxY7D9KRNqxVAzcgGmOpa6yZIKIrFKurt4i
 LZG5ZSC503hCPsZ2neg6Cw5W+36qdYI9WOdaYfGRZVwaUn3MBwZdH+cxY
 Q0p/SW/PohrPBiSRHtg0UAIIlr2QKwTt8QiPrhk5hZ6DaaiZitPnqBt8j
 0pGFLU3x5ros1VNGghIjFNgTh1wdZNKNqGIGcWAuksIPFKKPeIZoAciDT
 3F9HV+s3YCl3QRWtrH7pcnsJPul7oq3LSQDrDwUbEvvks4pwMj9/n6KVc
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=a1D+Mfu5
Subject: [Intel-wired-lan] [PATCH RESEND iwl-next 0/2] ice: Introduce switch
 recipe reusing
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
Cc: jan.sokolowski@intel.com, netdev@vger.kernel.org, steven.zou@intel.com,
 andrii.staikov@intel.com, aleksander.lobakin@intel.com,
 przemyslaw.kitszel@intel.com, andriy.shevchenko@linux.intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

This patch series firstly fix the bitmap casting issue in getting/mapping
recipe to profile association that is used in both legacy and recipe
reusing mode, then introduce switch recipe reusing feature as new E810
firmware supports the corresponding functionality. 

Steven Zou (2):
  ice: Refactor FW data type and fix bitmap casting issue
  ice: Add switch recipe reusing feature

 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   5 +-
 drivers/net/ethernet/intel/ice/ice_common.c   |   2 +
 drivers/net/ethernet/intel/ice/ice_lag.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_switch.c   | 211 +++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_switch.h   |   5 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   2 +
 6 files changed, 197 insertions(+), 32 deletions(-)


base-commit: f2aae2089368d8e5abb4ec01542c31bc4d011a74
-- 
2.31.1

