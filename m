Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A421C25B74
	for <intel-wired-lan@archiver.kernel.org>; Fri, 24 May 2024 14:56:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 214B940998;
	Fri, 24 May 2024 14:56:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jzgRwjsdlPHU; Fri, 24 May 2024 14:56:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1115540988
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1716562563;
	bh=u5z/e8MlJsO27tQGpdKRmdguU0OmqsNH5EQ/CdYnqB0=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=TWJMgNUXBZhcVZRmLAdyuBSpg4cZzrJBYTrc3+QZ8934vrLDKAgaGDxh2ocOdSK3N
	 6DeOLqWbl0T30Ng1D9Swa3uScHdyWkqN+VFW0WUo8XkvBOF6hxQrgU1Fnltgc2jexP
	 ZXlouiQgXv/IlTQllssJSxXDNnVwSNkUU6u6aShA6EUy57BaTxqjmKBkjJku6R1I20
	 ysJ9Wlhlvg4tjZIFHHY8q0Sm+qul1Y/LYmVAXoJKMLENkCHOzEbvauIwRgwooCiwDn
	 kDU8VaGg276fdpTSa+yvJPFgYEilFGoUueLiEJr2Fr/AoitxHcDeAeKI6xdIfKzueV
	 W7gfQM/+40TQw==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1115540988;
	Fri, 24 May 2024 14:56:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 4AAF61BF31B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 May 2024 14:56:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 346A640988
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 May 2024 14:56:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VygVJfU97H4i for <intel-wired-lan@lists.osuosl.org>;
 Fri, 24 May 2024 14:56:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=piotr.kwapulinski@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1521640969
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1521640969
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1521640969
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 May 2024 14:55:59 +0000 (UTC)
X-CSE-ConnectionGUID: u3qcITvuSqShp6SFJF1FzQ==
X-CSE-MsgGUID: dRiAHtpTTbekFlNvTBUZpw==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="24070366"
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; d="scan'208";a="24070366"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2024 07:56:00 -0700
X-CSE-ConnectionGUID: yHEWC3Q6QxaR5iqWHDubaQ==
X-CSE-MsgGUID: pP9nWGpRSeyjY+TNx+xF6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; d="scan'208";a="33946047"
Received: from amlin-018-251.igk.intel.com (HELO localhost.localdomain)
 ([10.102.18.251])
 by orviesa010.jf.intel.com with ESMTP; 24 May 2024 07:55:57 -0700
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Fri, 24 May 2024 17:13:04 +0200
Message-Id: <20240524151311.78939-1-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716562561; x=1748098561;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=AewH8JA9HIUsgxrnXtqykExha6GUv7XIEJDRz2IYeDM=;
 b=K4TX5gbIWXLeWGZJTiyvDDckCRuJga7W2GMygGId20yDQpjgyaI0YA/7
 eihc+kCvsi4SpRewAxEgmvS7v+dArz1mr+Uuc6PdfgW8CrVOUvQvBVnVV
 fAqR83MIp0qtCiv/eCcD5bW9LXrzxHlM13Gr3XuDOG7RHWBMIabmhBplq
 oV62ocEWkFpmAvQyVvjDnuQvheQ2aoF+EZWORQwQLTooe6IZAyu/vWU3p
 WyJ5PWuDGexicJrQ2Av/xkV8uHEYV1ql6VSIMuifSgnbutliDmeIx3xbj
 2Z0+nROQLMJrimeULMx6qUaZc/IcKfACDNk18ykHt6JPTdU5dBIcfGFmQ
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=K4TX5gbI
Subject: [Intel-wired-lan] [PATCH iwl-next v6 0/7] ixgbe: Add support for
 Intel(R) E610 device
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
Cc: Piotr Kwapulinski <piotr.kwapulinski@intel.com>, netdev@vger.kernel.org,
 pmenzel@molgen.mpg.de
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Add initial support for Intel(R) E610 Series of network devices. The E610
is based on X550 but adds firmware managed link, enhanced security
capabilities and support for updated server manageability.

This patch series adds low level support for the following features and
enables link management.

Piotr Kwapulinski (7):
  ixgbe: Add support for E610 FW Admin Command Interface
  ixgbe: Add support for E610 device capabilities detection
  ixgbe: Add link management support for E610 device
  ixgbe: Add support for NVM handling in E610 device
  ixgbe: Add ixgbe_x540 multiple header inclusion protection
  ixgbe: Clean up the E610 link management related code
  ixgbe: Enable link management in E610 device

 drivers/net/ethernet/intel/ixgbe/Makefile     |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   14 +-
 .../net/ethernet/intel/ixgbe/ixgbe_82599.c    |    3 +-
 .../net/ethernet/intel/ixgbe/ixgbe_common.c   |   19 +-
 .../net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c   |    3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 2545 +++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   75 +
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |    6 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |    3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  430 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c  |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |    5 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |   71 +-
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    | 1062 +++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |   12 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h |    7 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   29 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h |   20 +
 18 files changed, 4265 insertions(+), 47 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h

-- 
V1 -> V2:
  - fix for no previous prototypes for ixgbe_set_fw_drv_ver_x550,
    ixgbe_set_ethertype_anti_spoofing_x550 and
    ixgbe_set_source_address_pruning_x550
  - fix variable type mismatch: u16, u32, u64
  - fix inaccurate doc for ixgbe_aci_desc
  - remove extra buffer allocation in ixgbe_aci_send_cmd_execute
  - replace custom loops with generic fls64 in ixgbe_get_media_type_e610
  - add buffer caching and optimization in ixgbe_aci_send_cmd
V2 -> V3:
  - revert ixgbe_set_eee_capable inlining
  - update copyright date
V3 -> V4:
  - cleanup local variables in ixgbe_get_num_per_func
  - remove redundant casting in ixgbe_aci_disable_rxen
V4 -> V5:
  - remove unnecessary structure members initialization
  - remove unnecessary casting
  - fix comments
V5 -> V6:
  - create dedicated patch for ixgbe_x540 multiple header inclusion protection
  - extend debug messages
  - add descriptive constant for Receive Address Registers
  - remove unrelated changes
  - create dedicated patch for code cleanup
  - remove and cleanup of some conditions
  - spelling fixes
  
Eventually I decided not to create a dedicated patch for ixgbe_schedule_fw_event(). In order it makes sense it would require to extract some extra event code as well. This extra code is explicitly dedicated to link management i.e. to what the specific patch implements.

2.31.1

