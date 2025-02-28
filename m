Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA3DC282C5
	for <intel-wired-lan@archiver.kernel.org>; Fri, 28 Feb 2025 08:51:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 99BC2821E4;
	Fri, 28 Feb 2025 08:51:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id biOCEDS4bdMT; Fri, 28 Feb 2025 08:51:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BE29E82157
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1740732699;
	bh=2yvKbNr6pqPtOP+HvWDPc9398chp0YCl+Y7oilS95uA=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IKpalIoz9CBF550NliFB38ssiyc6YcOHc7fP9xLO0R6UW/ni5CIyiJHcgSFoIgjNr
	 W4i4kTbit0cueFfqPSMepyfw+kQWKazofDXPrbRF/v3cs1w2ime+AwN0EXOdS+gBQN
	 aVHKHZPZtUYK2tc3Hczcc2pW8kxPfKH53w0FWKwcIwBxwJtzlSVnjZ6iO7I7G7BS7c
	 wSAkzpWx/G0CCv1l/aqd0QTt/0pfYoQ/jRTetvu0bEGBihbksg/ylA0JoujEhOq5dR
	 Hm9R4s9HX6RnqyKERsECVvWZ0EEbl/iudXaRRSYpV0sDVS9LW92gPMTHzSHGSYRnDJ
	 2Js0y0AQO0b8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE29E82157;
	Fri, 28 Feb 2025 08:51:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AA09268
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Feb 2025 08:51:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 91FC460699
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Feb 2025 08:51:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W4AfylSJb_z2 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 28 Feb 2025 08:51:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=jedrzej.jagielski@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 81518600CA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 81518600CA
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 81518600CA
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Feb 2025 08:51:37 +0000 (UTC)
X-CSE-ConnectionGUID: r272rrKFQF+OA5cXb9ZyKA==
X-CSE-MsgGUID: Lg6KRdo6QJORCX8TZzVraA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="40829549"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; d="scan'208";a="40829549"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2025 00:51:37 -0800
X-CSE-ConnectionGUID: De25rqMCTN6q7HhMsyWzHw==
X-CSE-MsgGUID: saWYRjPCTxCiGEuI4dJu2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; d="scan'208";a="121894631"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
 by fmviesa005.fm.intel.com with ESMTP; 28 Feb 2025 00:51:36 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Date: Fri, 28 Feb 2025 09:37:35 +0100
Message-Id: <20250228083739.209076-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740732697; x=1772268697;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wVyw+KquFWcpOW3Uw9GszurumyJapHNECVNJMeKHE+A=;
 b=WnzJH2vQsFKRrNVFYQNTgg+iXoiD7ituu/s2HE8tnxLLn7WCS0Q0rq4u
 Gcl2Fb8bqfZJSZeepp9QG1tcsZl8w1Gwu/jz5P2hry6fl1YQ4q1Ft4don
 utU7QNIbIBx01fGYP7nwKHtjp2lY4G5FfqHG26LbgwSs5zyMw4ZO/PiL5
 TW5nZs6E2VbOiWkz6YW1MZxh6jnyUmUQc5zu2GOT5rRrvaxkpFrJ0rcSU
 b9w+JdZVS1PI5j5j9yHTS5o12lHW02+hlc6G/46q7kwX5803dR0Hh/cBd
 CCz/AuHz1Yv3jgdOtRFsMqzDSlk2BpmuH1p2djN0wVmmKxhiuVEtBR6Rj
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=WnzJH2vQ
Subject: [Intel-wired-lan] [PATCH iwl-next v2 0/4] ixgbe: add ethtool
 support for E610
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

As E610 adapter introduce different approach to communicate with FW than
the previous adapters using the ixgbe driver, there is a need to adjust
some of them to the new pattern. Some of the features are now set using
Admin Command Interface (eg. controlling LEDs) which among the ixgbe
supported device is specific for E610 only. That means ethtool callbacks
related to these features need to be handled specifically in case of E610
adapter. E610 introduces also different rules (eg. setting FC, setting WoL)
for some of the features what also need to be adjusted.

This series is based on the series introducing initial E610 device
support:
https://lore.kernel.org/intel-wired-lan/20241205084450.4651-1-piotr.kwapulinski@intel.com/


Jedrzej Jagielski (4):
  ixgbe: create E610 specific ethtool_ops structure
  ixgbe: add support for ACPI WOL for E610
  ixgbe: add E610 .set_phys_id() callback implementation
  ixgbe: apply different rules for setting FC on E610

 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c |  29 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   1 +
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 171 +++++++++++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  10 +-
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    |  13 ++
 5 files changed, 211 insertions(+), 13 deletions(-)


base-commit: 35c698223836714535e5413753b5899ca2a05d0a
-- 
2.31.1

