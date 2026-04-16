Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DB3F433D8
	for <intel-wired-lan@archiver.kernel.org>; Thu, 16 Apr 2026 02:18:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE5CB80B3A;
	Thu, 16 Apr 2026 02:18:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I87vMpD_dMXa; Thu, 16 Apr 2026 02:18:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8BDF380B36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776305916;
	bh=ukYzGgxVpFjONpMipLHXCqFZic4ufSq7baYN3NeoLDA=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jiK+0I/ah/b+bhFMYg83XZOxAwFPjMeHtvulOSfziNcDcdKqEmymFdLkj3lqu7QRD
	 EE8loSE3fzxzkmithmsNGmcpc47kF+mnXy1w54Gcu2SZfyE530F4sHq/fPX0tKBnke
	 3KDAD8fIKv05vOo4lxt32OZAQzn7pEgzNJ5qWWoGi3NGpZ65nuDcwUQOvfnuyARuOa
	 OhZDowj5rujO9BcX8MH5IOU/1Anb3920VR703gILs1J6GcMDyWW8qANJX2TMx2JeW8
	 tWzF6DObl6GqcoBKnUkt/POLpEVLGpe7oyvedCwMZmfnx0bDKOuEnrvgw9FO9cVI2X
	 trnV2QW7B9B7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8BDF380B36;
	Thu, 16 Apr 2026 02:18:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6AEC9127
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Apr 2026 02:18:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 507DA80B30
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Apr 2026 02:18:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7fNcoQEf-9KW for <intel-wired-lan@lists.osuosl.org>;
 Thu, 16 Apr 2026 02:18:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=khai.wen.tan@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D4B8980B23
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D4B8980B23
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D4B8980B23
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Apr 2026 02:18:32 +0000 (UTC)
X-CSE-ConnectionGUID: vzoMmYVGSRuWwbGJlCCWtw==
X-CSE-MsgGUID: FdoCTATSRT6Zhm+m+1XSng==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="81168774"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; d="scan'208";a="81168774"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2026 19:18:31 -0700
X-CSE-ConnectionGUID: 3CyJPPd4TjKHQSu86COnsA==
X-CSE-MsgGUID: MDa1h4/FT0ShD6TrkLAXIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; d="scan'208";a="227442166"
Received: from unknown (HELO localhost.png.intel.com) ([10.107.255.61])
 by fmviesa007.fm.intel.com with ESMTP; 15 Apr 2026 19:18:05 -0700
From: KhaiWenTan <khai.wen.tan@linux.intel.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, faizal.abdul.rahim@intel.com,
 hong.aun.looi@intel.com, khai.wen.tan@intel.com,
 Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Date: Thu, 16 Apr 2026 09:55:17 +0800
Message-ID: <20260416015520.6090-1-khai.wen.tan@linux.intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776305912; x=1807841912;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Hd+1dN5IevHoWoTVdLczDqxYv7KnWEcwalHmW5qnm94=;
 b=Osu8rI3aZZX2Z8wdgdVaphn66pCUxOlzqlilA9mjTadnd4LOttDy8Dbx
 ca2p4GMuXDPhB/n2ArY7hV5HpopWID49hI8hbgwFRtdHfNaKH1Y7bFAq8
 53TrBNaBfgpF0o6vcZn092GHMjq0lzhOBJJqZO6jZU6rrtTGJ73AgUBaR
 wK+nj9FiRSTeNVM/k7PeSNJSsU0zawjNKiolmqmvz4bEwtQSx/0WfK3UR
 jfXfPgdKmm4ykxhfy0/N6jGxe5vgqmlgmnfUYD3CdN3J/kuoTGhd/+7SR
 9N2D03tS4+CBKF5qnt0cuMPDtDnhBsjFHFnvzRL0aAuhMDuqLay1pJ2f5
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Osu8rI3a
Subject: [Intel-wired-lan] [PATCH iwl-next v2 0/3] igc: add support for
 forcing link speed without autonegotiation
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

From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

This series adds support for forcing 10/100 Mb/s link speed via ethtool
when autonegotiation is disabled on the igc driver.

Changes in v2:
- Simon Horman's review comment: when forcing half-duplex, set
  hw->fc.requested_mode = igc_fc_none, since half-duplex cannot support
  flow control per IEEE 802.3.
- Split the original single patch into three patches for clarity:
  patches 1 and 2 are preparatory cleanups; patch 3 carries the
  functional change.

v1 at:
https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20260409072747.217836-1-khai.wen.tan@linux.intel.com/

Faizal Rahim (3):
  igc: remove unused autoneg_failed field
  igc: move autoneg-enabled settings into igc_handle_autoneg_enabled()
  igc: add support for forcing link speed without autonegotiation

 drivers/net/ethernet/intel/igc/igc_base.c    |  35 +++-
 drivers/net/ethernet/intel/igc/igc_defines.h |   9 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 203 +++++++++++++------
 drivers/net/ethernet/intel/igc/igc_hw.h      |  10 +-
 drivers/net/ethernet/intel/igc/igc_mac.c     |  16 +-
 drivers/net/ethernet/intel/igc/igc_main.c    |   2 +-
 drivers/net/ethernet/intel/igc/igc_phy.c     |  65 +++++-
 drivers/net/ethernet/intel/igc/igc_phy.h     |   1 +
 8 files changed, 251 insertions(+), 90 deletions(-)

--
2.43.0

