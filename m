Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2857BC0015E
	for <intel-wired-lan@archiver.kernel.org>; Tue,  1 Aug 2023 11:49:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B109540278;
	Tue,  1 Aug 2023 11:49:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B109540278
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1690890566;
	bh=Jcl/plLkkUlztM8lQLKq1GzQMtRUnO5HIOKL2IghTNY=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=1M28Nv3fA8quPeV2g+QMm3XY/BSnlbVeSX9g3SblidC3SVm6Iun386Uiyuu5U1rI8
	 MBL+pPRQDOVNTOlaPbud39PsZNIu+dvKVoFpfdVtCu7JlJ1zazZgW71p6ZdbiQAQDE
	 CStaAKnwwR7b+/8N6siYAVINaC/w5VpNvmyhcOPeGVMiZalR86BxcnGSLvXvaimL4b
	 9Nek7Cpy9ySvY+vd8m6qu6xd83vKNVe4UbMucx0Hvk55PbW2+2D2nX67Z3C+64hOkQ
	 +ZSP5wVZX3Buw4WZUjWsM8zuyXfER1IF7JfEOShbt5KExvfeu1UI1DmUcbc4Do9ZwK
	 o5vjRyLv6vjkw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vYlSoT1JLKhG; Tue,  1 Aug 2023 11:49:26 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id B79224011A;
	Tue,  1 Aug 2023 11:49:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B79224011A
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 4592B1BF290
 for <intel-wired-lan@lists.osuosl.org>; Tue,  1 Aug 2023 11:49:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 553A54014B
 for <intel-wired-lan@lists.osuosl.org>; Tue,  1 Aug 2023 11:49:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 553A54014B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k6-vKxVn1T2W for <intel-wired-lan@lists.osuosl.org>;
 Tue,  1 Aug 2023 11:49:21 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A2F6E40194
 for <intel-wired-lan@lists.osuosl.org>; Tue,  1 Aug 2023 11:49:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A2F6E40194
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="433112508"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; d="scan'208";a="433112508"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Aug 2023 04:49:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="902528637"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; d="scan'208";a="902528637"
Received: from s240.igk.intel.com (HELO DevelopmentVM.nql.local)
 ([10.102.18.202])
 by orsmga005.jf.intel.com with ESMTP; 01 Aug 2023 04:49:19 -0700
From: Jan Sokolowski <jan.sokolowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue,  1 Aug 2023 13:53:03 +0200
Message-Id: <20230801115309.697331-1-jan.sokolowski@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690890561; x=1722426561;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/AokW+GZNa4KKOXx0Irzlxc2zAL0HmewCyB2z+1xXl4=;
 b=PTBuJDdNS1jc4++YMP+mSrswf0on/iHnFE01FDTDLo5vlpOSPVo6wRHK
 FjpJzNE21fNloStxvLOBagxAlHi0Vs4wlsiTiM3SPEkngwz22PGh8CokI
 9CjvlG4AYgOu/ylR6Fis4VIH99XQQX8Lxzjb7Ic5yf6MfFJ9X/x7oV7CG
 u4C0vgwULbMgGM2VWN3G/oC5eSugeYmNuhBo8AR/2s9X/C/MxARNu0s8C
 stP5DgPUDRlq4bwKH4XZfpLcROmeg28LpSp7kgRwc8BxEPoJ+20kAGJmp
 Beo2DlrgPnFkzCLmnGTXelW58gjHjq5SauI9KIfQhkgYPezenFQf5Pboe
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=PTBuJDdN
Subject: [Intel-wired-lan] [PATCH iwl-next v2 0/6] ice: staticization
 refactor
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

ice: refactor methods to make them static

This series of patches refactor some ice driver files
in order to make as many methods as possible static.

Also there's a minor cleanup of unused methods.

Jan Sokolowski (6):
  ice: remove unused methods
  ice: refactor ice_ddp to make functions static
  ice: refactor ice_lib to make functions static
  ice: refactor ice_vf_lib to make functions static
  ice: refactor ice_sched to make functions static
  ice: refactor ice_ptp_hw to make functions static

 drivers/net/ethernet/intel/ice/ice_ddp.c      | 117 ++---
 drivers/net/ethernet/intel/ice/ice_ddp.h      |  10 -
 drivers/net/ethernet/intel/ice/ice_lib.c      |  85 ++--
 drivers/net/ethernet/intel/ice/ice_lib.h      |   5 -
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  25 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   4 -
 drivers/net/ethernet/intel/ice/ice_sched.c    |   2 +-
 drivers/net/ethernet/intel/ice/ice_sched.h    |   4 -
 drivers/net/ethernet/intel/ice/ice_switch.c   |  48 --
 drivers/net/ethernet/intel/ice/ice_switch.h   |   1 -
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 468 +++++++++---------
 .../ethernet/intel/ice/ice_vf_lib_private.h   |   2 -
 12 files changed, 332 insertions(+), 439 deletions(-)

-- 
2.31.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
