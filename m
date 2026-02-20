Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9670AC53216
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Feb 2026 07:30:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4674660FB9;
	Fri, 20 Feb 2026 07:30:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MnHorPfe3CqD; Fri, 20 Feb 2026 07:30:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 59FEF60FB7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771572631;
	bh=37T5iZ1jh+7EHPJ60hl9uNUtygjyPXshG4j+pkNr+2M=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=4gbKRBaOgEb2hq8WrD35pPJUBr0L1Vo/X/UbFm3tNj87NGxNzAoE19aQrh/7e6xVb
	 xKV5DjZfhYRfYOsWawF0iiKH3A7jvqzTKpy3pjgf8l1N5luDfMjp0tOQ6aYQgz9yRK
	 LpU48H0jfy/0rp+/PHCIjIRPMHiy2twjSJvlitd70D7Yv6fTsz9x3x7Iq9ENALYYAk
	 eGmJeeOl/LBz7k5XhircQKC3vHj/KnoqEp6cmGTDBm3GFWkTWOvdM8bG0eQfwmqqli
	 rXwMbeVmpjc8sdhKDYdjvUjnaPWG6RJpSnxqDVX4pK9Zn7IDjE0KQgLz0G2rHyTmOU
	 KG879GzHo6gZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59FEF60FB7;
	Fri, 20 Feb 2026 07:30:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 57CA51CE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Feb 2026 07:30:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3D67B41823
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Feb 2026 07:30:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZgEAM_NFbAAo for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Feb 2026 07:30:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5DEA14181D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5DEA14181D
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5DEA14181D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Feb 2026 07:30:28 +0000 (UTC)
X-CSE-ConnectionGUID: XeVg/z14RAGoF7ZsDpD+uA==
X-CSE-MsgGUID: 3zpmbMKOTZqvuxWiAJQ06A==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="95286630"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="95286630"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 23:30:29 -0800
X-CSE-ConnectionGUID: S34A9OsoSzmWV9puGqNVmA==
X-CSE-MsgGUID: r4Sjk7xSQ+uXnwaujUPQQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="219289830"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa004.jf.intel.com with ESMTP; 19 Feb 2026 23:30:26 -0800
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com, horms@kernel.org,
 marcin.szycik@linux.intel.com
Date: Fri, 20 Feb 2026 08:30:23 +0100
Message-ID: <20260220073025.654391-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771572630; x=1803108630;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=lyp5Xhf9Uz/O9UFSOZCogRvPaliG7+luXfZB0IaqxBM=;
 b=PSySYh4Xd1IYqE6fjkvRVvUi2aLCghYrDUJFfwIBVIOI19kDfU3SNYil
 NtOqQESL18i1okcJ+x8xpiQadTFfaxlfxFoPpobMC6H2wiHWbakBMrxqG
 G9Z2zRZfLRjlqs93tiGWcIkvZvcd/97sYb4No0HVvTyYCahfsLi3ChsRQ
 zPnMZ5Ev0kXCmqTeNl7yzt5q/UozMibQJj03jM2Sc38/Mci4qXHaDhHUJ
 po1v4YgQIQPj5QHxDc4+m5Q/EovDPWuQ4pqo4fpLX03N0ra0AfU+9eElZ
 mJ07DyPUEh4ibMZrYu2vK7R4mleqa4FW3Ks/QLGK808eN78E3/np0Knnv
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=PSySYh4X
Subject: [Intel-wired-lan] [PATCH iwl-next v3 0/2] ice: implement symmetric
 RSS hash configuration
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

The ice driver has advertised symmetric RSS support via
supported_input_xfrm since the capability was added, but ice_set_rxfh()
ignored the input_xfrm parameter entirely, so enabling symmetric hashing
had no actual effect.

This series fixes that.  Patch 1 extends the ethtool core so that
drivers hashing GTP flows on TEID can report it honestly without
blocking symmetric-xor configuration.  Patch 2 wires up the ice driver.

The need for patch 1 surfaced because GTP flow profiles in ice always
include TEID in the hash.  ethtool_check_flow_types() calls
get_rxfh_fields() for every hashable flow type before allowing
symmetric-xor; ethtool_rxfh_config_is_sym() rejected any bitmap
containing RXH_GTP_TEID since it has no src/dst counterpart.  TEID
is the same value in both tunnel directions, so this rejection is
incorrect: including it does not break symmetry.

Rather than hiding TEID from the reported fields (which would silently
misrepresent hardware behaviour), patch 1 fixes the validator, and
patch 2 reports TEID honestly.

Tested with tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py
on an E810 card running kernel 6.19-rc8.

---
v2 -> v3:
 - Split into 2 patches: ethtool core fix separate from driver change
 - Drop the RXH_GTP_TEID stripping workaround from the driver; instead
   fix ethtool_rxfh_config_is_sym() to accept TEID as intrinsically
   symmetric (patch 1)
 - Fix ice_get_rxfh_fields(): the v2 unconditional assignment
   "nfc->data = ICE_RSS_ALLOWED_FIELDS" clobbered fields set earlier in
   the same function; replaced with pair-completion using |= so only
   the missing half of a partial pair is filled in
 - Remove ICE_RSS_ALLOWED_FIELDS define (no longer needed)
 - Report RXH_GTP_TEID honestly for GTP flow types

v1 -> v2:
 - Preserve valid symmetric RSS fields instead of overwriting nfc->data
   unconditionally

Aleksandr Loktionov (2):
  ethtool: treat RXH_GTP_TEID as intrinsically symmetric
  ice: implement symmetric RSS hash configuration

 drivers/net/ethernet/intel/ice/ice_ethtool.c | 48 +++++++++++++---
 drivers/net/ethernet/intel/ice/ice_lib.c     |  7 ++-
 drivers/net/ethernet/intel/ice/ice_lib.h     |  1 +
 net/ethtool/common.c                         |  3 +
 4 files changed, 47 insertions(+), 12 deletions(-)

-- 
2.43.0
