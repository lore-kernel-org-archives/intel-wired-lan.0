Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635E1C27C50
	for <intel-wired-lan@archiver.kernel.org>; Tue,  4 Jun 2024 22:13:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 029B5842B3;
	Tue,  4 Jun 2024 22:13:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AiDNoBJ3BeS5; Tue,  4 Jun 2024 22:13:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DC3B281EE2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1717539220;
	bh=T8iTS9VNGWeXlbpjIVQ5LBMD2zVU4gQ7acu1uF4UTA0=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=SuMyDPfGA6OLhGLdL5UvxoHiMzLiR9NzZrzMAf3hpWrPlO9bY7EcLW7fwEOC1HMN0
	 5YqKq5kFZnJwnj7EqCw3CSaHH6AoYgPSD/fV0vA5fXMV0u5AfrQ0nOiZtAuxcrVTyP
	 rirCjJpVBZTRvY47XdVWDFApnvU45lEtwPSIYvF3mWtwmIJtcDrIWuk/D1cb28FzDk
	 UbuBtrEmVOCtDFrsQF5mAd0G/Go6CNyysd0Ls8n7zzd6jJv9tr2EzcGOXEGh419mGs
	 ZYdCo7Mzc4OsnnfQLEKj3H3CzhPHv0fPfQHwVJc3oEkIcZMomBPNUd+Ctn6SAYEI+L
	 w5eZiZyYmOgng==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC3B281EE2;
	Tue,  4 Jun 2024 22:13:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 937811BF409
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Jun 2024 22:13:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F358140301
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Jun 2024 22:13:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9NtuTXz514cT for <intel-wired-lan@lists.osuosl.org>;
 Tue,  4 Jun 2024 22:13:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=jesse.brandeburg@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 24FE940296
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 24FE940296
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 24FE940296
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Jun 2024 22:13:37 +0000 (UTC)
X-CSE-ConnectionGUID: O2vbJdOFRgSmun0QVoBl5w==
X-CSE-MsgGUID: Bg2sW5z6QTGgqqn5oeMB/w==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="36635253"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; d="scan'208";a="36635253"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2024 15:13:32 -0700
X-CSE-ConnectionGUID: HUrSsUqJQ4uAziSvgyQk3Q==
X-CSE-MsgGUID: 40zCo2b0SmaBZ0U8LGqFPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; d="scan'208";a="37503232"
Received: from jbrandeb-spr1.jf.intel.com ([10.166.28.233])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2024 15:13:32 -0700
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Date: Tue,  4 Jun 2024 15:13:20 -0700
Message-ID: <20240604221327.299184-1-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717539217; x=1749075217;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=llZfe2oGQU8w8nwBOAhiV/pkSNZCGmsZAAeCESgAvu8=;
 b=R6CyfMbVtGvx2rgENZmNgaFqhq5USX7dUuRUssVd/LBnLX0oKG8utibb
 RDzHUbkSuxSTlzpezynPLSU58v+RdLrz2UFtWC6ND+3Q96oAYQqnNealb
 iI57uRhy0UuSO+rcN44eGR3mufqsMRsVqC8uHXAMdTFudwMym2gpk1z7F
 uhlLIYMjppzhkPB2wl/lXwjQLkiDt0lfkfO5+5iq2lpvd8zlv3vV6NADu
 o9TgSsRNP6sOPL8hTvyrDXioBauGXZYtJMpHqjKjQdZpuQvw14paH0HGA
 TDMwlCV4KMqyl8sy/O/92bNnZCQdh3TvfoQcrugLuSIoOkRnZlz0IZAFq
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=R6CyfMbV
Subject: [Intel-wired-lan] [PATCH iwl-next v1 0/5] ice: add standard stats
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
Cc: linux-doc@vger.kernel.org, corbet@lwn.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The main point of this series is to implement the standard stats for the
ice driver, but also add a related documentation fix and finish the
series off with a cleanup that removes a bunch of code.

Jesse Brandeburg (5):
  net: docs: add missing features that can have stats
  ice: implement ethtool standard stats
  ice: add tracking of good transmit timestamps
  ice: implement transmit hardware timestamp statistics
  ice: refactor to use helpers

 Documentation/networking/statistics.rst       |   4 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 138 ++++++++++++++----
 .../net/ethernet/intel/ice/ice_flex_pipe.c    |   8 +-
 drivers/net/ethernet/intel/ice/ice_lag.c      |   5 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  10 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |   9 ++
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   1 +
 drivers/net/ethernet/intel/ice/ice_sriov.c    |   3 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 9 files changed, 132 insertions(+), 47 deletions(-)


base-commit: 95cd03f32a1680f693b291da920ab5d3f9d8c5c1
-- 
2.43.0

