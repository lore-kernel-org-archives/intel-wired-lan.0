Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75570C44501
	for <intel-wired-lan@archiver.kernel.org>; Fri, 10 Jul 2026 10:54:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22D2E606A7;
	Fri, 10 Jul 2026 10:54:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vUqHKdXtlMEq; Fri, 10 Jul 2026 10:54:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9B7D5606B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1783680848;
	bh=Uf8k50VB4apc7LAhUiwHodgR59Rc4OFSNOWvmEb/KLo=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Fv/fR+zlF+81qhJrvRQ0eOGlShwhEXNjntQbl7AYEC0i3taIxnzd9dE2YycUJ3B39
	 gCswZveC1Y4Da23MmSFFdZI8zdgibC1qHK+EkYYOpVkb/P5QQa/sn5QpDXwO+aa/4x
	 aDHl2+sTPuArJmhftTgnAQDCjyNBBEqeITrqMcjIfJdO0da0VuAJ472flxyT9X1e/A
	 SwkK9oXbr8Lff1zK+JHqI4dLWe1wcaTfP2vCHIWcrlw6wz8KwIMvId45UMF7wyN29z
	 hVKNjcgvtsAYBwu6IcHO7bEXDEawteRSesXrsRmORRSlNrmsCJHJVvgui9NNOBmdQu
	 HbnTlSStv6YwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B7D5606B4;
	Fri, 10 Jul 2026 10:54:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D514F2FE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Jul 2026 10:54:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BD9F1409D3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Jul 2026 10:54:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Y4-E4nmgKRY for <intel-wired-lan@lists.osuosl.org>;
 Fri, 10 Jul 2026 10:54:06 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C7AFD409CE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C7AFD409CE
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C7AFD409CE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Jul 2026 10:54:05 +0000 (UTC)
X-CSE-ConnectionGUID: WFJfl4SrTsaCByROdiMfIw==
X-CSE-MsgGUID: bDjMpyqsSxmupV6w4/uz9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="86920266"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="86920266"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 03:54:05 -0700
X-CSE-ConnectionGUID: NNZh9D0wTEuxLzFA86UMMg==
X-CSE-MsgGUID: 4sHwm16ZS5yC4ATfrqmazw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="259750952"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by fmviesa005.fm.intel.com with ESMTP; 10 Jul 2026 03:54:04 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Date: Fri, 10 Jul 2026 10:54:01 +0000
Message-ID: <20260710105403.1050025-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783680846; x=1815216846;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=xGzgHIEvWioMJ3fkiFs2XDNJ3kJUshkAsCOMvGfBvAg=;
 b=GpTgqZ/Kf5WlicHLkkmpsaH/UBv7Lmu48mZSfnhPcjj8xduHC6YIZnOl
 UFBufqB/tX9BikQBD9GfSCRCI7mheVLnpvjzEQ+brNaY1DTNlCrcmbWJc
 w0xZ3hy4EkR1UIsXoN5Lx+dHrF17+wQb/q9IWTQb5sVyOnemd4h/FiaRt
 WYfi6fYfE86914ckuoF6h+wZ1+VvnjJAU+ZsN1C7eP3UUvGetVEoVdqL5
 ss9ofy+dvwPCAExHZCHDH0lTlG3hqPfJwjd41FZacQubgQ6N8BEYDMWHY
 jbwHaLPPynDWr9/WJUF4llZDmqH3hESMR30v/+YP89nBqLWTG/od70277
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=GpTgqZ/K
Subject: [Intel-wired-lan] [PATCH iwl-next v1 0/2] Implement ixgbe PCI reset
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

This series adds an ability to properly perform PCI level reset
via sysfs to the ixgbe driver.

To achieve this, several operation handlers are refactored to
check whether the netdev is available during the invocation, and
the actual reset handlers are implemented which prepare the device
for the reset and re-initialize it afterwards.

Sergey Temerkhanov (2):
  ixgbe: Refactor device operations to check whether netdev is available
  ixgbe: Implement PCI reset handler

 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   5 +
 .../net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c   |  13 +-
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  34 ++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c |  20 +++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 112 ++++++++++++++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  |   4 +-
 6 files changed, 159 insertions(+), 29 deletions(-)

-- 
2.53.0

