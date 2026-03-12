Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E81FED2F9
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Mar 2026 09:31:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B88A41BDF;
	Thu, 12 Mar 2026 09:31:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j7UpEiJUN8MV; Thu, 12 Mar 2026 09:31:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AC9F241B47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773307867;
	bh=nlT6t7HOyCuDggAXB/Bg3P3kGEb7ouI0ssC3TydBU0c=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TlkA26yV+rIc45ljh7egq2LLl0/xHLaqKOTHbLvcsofHxgP41AUZF5vHv1tmuGqqY
	 qU2Tt46iApGxXAbeXqmojWOBZeNGakfZfEljPxqgVCZWCtwFM1LIRSEx+RnCSJsGBV
	 XBvddcXdFwOVnFcBHB4EIb1I0NsLuvlHrJj/mNzTlQ8sdGAr4fJHu4HPV7LHh98nJR
	 LrpOaZzbrvmj/5rNJtDjXqwnnB/yHrxecrFoRxpXbGfgi6purrAW/jG94ccnLeUPlY
	 fT+0VK9H9BfrliFVVMasz3/Jn73GV29CaC1/jMRUR5a6zLjks1Yunaz6qTSZSbpU6+
	 Ah+K88x2FaTjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC9F241B47;
	Thu, 12 Mar 2026 09:31:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B8FA201
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Mar 2026 09:31:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F192184AD5
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Mar 2026 09:31:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AHl11uJWxvuL for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Mar 2026 09:31:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0010984AB5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0010984AB5
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0010984AB5
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Mar 2026 09:31:04 +0000 (UTC)
X-CSE-ConnectionGUID: mtS2qtQ8TTqEtLMlg2pQpQ==
X-CSE-MsgGUID: OcQtW3J0TPaOtgdLEFaAgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="85868898"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; d="scan'208";a="85868898"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 02:31:05 -0700
X-CSE-ConnectionGUID: XsLQ2HiQTBuf5MbAeF2mhw==
X-CSE-MsgGUID: 8qUbxX55TUmCVBX4yOI6lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; d="scan'208";a="223230599"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa004.fm.intel.com with ESMTP; 12 Mar 2026 02:31:02 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, aleksandr.loktionov@intel.com
Date: Thu, 12 Mar 2026 10:30:59 +0100
Message-ID: <20260312093101.1589970-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773307865; x=1804843865;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4qJEPQL3k8uWe/F0JSIQRqf5CjPbIYGk3lkjHKeSYrg=;
 b=UeKszwvugYtxTZDNVk57jnv6J9VTbf5awV3rI1o0I65nZZeztY+DwI1c
 SxYEwjMhe2Cou2RMs03DNmdObkfa13yZggKwBL1DenngCkaJiloHcWR8g
 BA1LCarDvJI3SPziorYy3j0N1yPXsU/06LNRUoSjKb6xoq0LPTFFYpfAA
 +9jcaYYGvgGFfcHlsmGg0hGw6ilohuNGXmV0cxKLqQiOCvoLFA+1Kad24
 OIUj79PVj92vOtWSEGOq2ZT6Je6+QluQaCbg5Js1AHR16kx2c8116LURq
 OGhEQwl/9QBEu+ZID4sd8Qz8aUS0tBPvN/VlQNSanvX/Fx4NfY86stxqM
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=UeKszwvu
Subject: [Intel-wired-lan] [PATCH iwl-next v4 0/2] ice: implement symmetric
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
v3 -> v4:
 - Drop the ICE_HASH_INVALID fallback in ice_get_rxfh_fields() that
   fabricated default L3+L4 hash fields when no hardware RSS config
   exists for a flow type; returning zero fields is more honest and
   avoids misrepresenting hardware state
 - Drop the companion "if (!l3 && !l4)" special case in the
   pair-completion block; it was only necessary to cover the synthetic
   defaults added by the fallback, which is now gone
 - No functional change to ice_set_rxfh() or the ethtool core patch

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

 drivers/net/ethernet/intel/ice/ice_ethtool.c | 40 +++++++++++++---
 drivers/net/ethernet/intel/ice/ice_lib.c     |  7 ++--
 drivers/net/ethernet/intel/ice/ice_lib.h     |  1 +
 net/ethtool/common.c                         |  3 +++
 4 files changed, 40 insertions(+), 11 deletions(-)

-- 
2.43.0
