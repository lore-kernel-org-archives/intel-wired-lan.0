Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8EBC35FFF
	for <intel-wired-lan@archiver.kernel.org>; Thu, 20 Mar 2025 13:19:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 68FA783EC1;
	Thu, 20 Mar 2025 13:19:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Zrp3_gH01Qf; Thu, 20 Mar 2025 13:19:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 51C8B8050D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1742476774;
	bh=Vi0xqQPzmH4/FhgbKdjhM+vqIXKUL/8tmoh5Gquo5wc=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=sAeumvFkedLuvr2cgiWmQpMinh6Kk10mvi0d5vKGaegjpagzKaf4FLR9CRwB0fUdX
	 OfVypOhHXQau3iYgL4PWF9a1u3/UtjUEHgin3noLHzGbulWJfWngotO73DjgebwSf5
	 3cx0jhsRDPO0cSABPxoqrt3AXLOI71X0LYpCJS7vRQ6NoBOSxEn9G9sODTupqYrte3
	 xKu+IS4pZfHR4thwY9rC57cp9RFOK9RXwZlLGdiKAozsTVauxPajQXAt5tzbuM1dF6
	 lg2n4jMMhPI9m0qFRMC/Fzn6Sh7IHSgPLpKFB1hE1XIHicSZWyCi18QWLG5W/RApKX
	 7wgQ9F811C8Sw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51C8B8050D;
	Thu, 20 Mar 2025 13:19:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 08C4A1A0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Mar 2025 13:19:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DF81C606C5
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Mar 2025 13:19:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H867f0V2u_zW for <intel-wired-lan@lists.osuosl.org>;
 Thu, 20 Mar 2025 13:19:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E61AF605D8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E61AF605D8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E61AF605D8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Mar 2025 13:19:31 +0000 (UTC)
X-CSE-ConnectionGUID: QcM9oND5T3urL59tDRC03w==
X-CSE-MsgGUID: 5QeVppL3Sbay9ctamwzyxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="55083733"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; d="scan'208";a="55083733"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2025 06:19:31 -0700
X-CSE-ConnectionGUID: KOJKTDjzQV2xkHAHfocs7A==
X-CSE-MsgGUID: 08z3xn/GS0uv/VR5PmleUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; d="scan'208";a="160311374"
Received: from gklab-003-001.igk.intel.com ([10.211.3.1])
 by orviesa001.jf.intel.com with ESMTP; 20 Mar 2025 06:19:30 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Thu, 20 Mar 2025 14:15:35 +0100
Message-Id: <20250320131538.712326-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742476772; x=1774012772;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8v2IlNO/kUlcnwT83q5ZXsTX+JsEa2epR2YhLXfU0YQ=;
 b=SD/aXfu+RP84XlGGsUrsMimX12JnO1P+h9mxWBZKdgzMyMLrt9VMutYm
 SzD6Rx1VB9vCBkb8iHbvcO/IGVJBhlVlYfgCUMdhnDfgBM1U2bZPEFROp
 +1ib3NkQ/5iY3ZCbVxB4m1tf7q7RyrgHiWRXduTr7WO/ucSvjbmRxUG6B
 PiSkFO8VlBzbPGw2Jqs9DRvAjeOgg/XwBFfLqsBRiJn0s5UMDThEpTEqy
 K4IZLV8RlJmw1pyjJEpASq1Q7qYyY6AROwgnDm1TP3b+0QYHIB31EUoFc
 PUY8KGwfbXcw42wB7L/RMXSIWnZWN9o8ds3sX58AerYCz46nhbn1GPXcu
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=SD/aXfu+
Subject: [Intel-wired-lan] [PATCH iwl-next v3 0/3] E825C timesync dual NAC
 support
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
Cc: netdev@vger.kernel.org, horms@kernel.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

This patch series adds full support for timesync operations for E8225C
devices which are configured in so called 2xNAC mode (Network
Acceleration Complex). 2xNAC mode is the mode in which IO die
is housing two complexes and each of them has its own PHY connected
to it. The complex which controls time transmitter is referred as
primary complex.

The series solves known configuration issues in dual config mode:
- side-band queue (SBQ) addressing when configuring the ports on the PHY
  on secondary NAC
- access to timesync config from the second NAC as only one PF in
  primary NAC controls time transmitter clock

v2->v3:
- update commit message (1/3) about regression risk after removing the
  workaround (no risk expected) 
 
v1->v2:
- fixed ice_pf_src_tmr_owned function doc
- fixed type for lane_num field in ice_hw struct 

Karol Kolacinski (3):
  ice: remove SW side band access workaround for E825
  ice: refactor ice_sbq_msg_dev enum
  ice: enable timesync operation on 2xNAC E825 devices

 drivers/net/ethernet/intel/ice/ice.h         | 60 +++++++++++++-
 drivers/net/ethernet/intel/ice/ice_common.c  |  8 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 49 +++++++++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  | 82 ++++++++++----------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h  |  5 --
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h | 11 +--
 drivers/net/ethernet/intel/ice/ice_type.h    |  1 +
 7 files changed, 149 insertions(+), 67 deletions(-)


base-commit: 410597c085b1ab697bd40cc8cd532eb337a5405e
-- 
2.39.3

