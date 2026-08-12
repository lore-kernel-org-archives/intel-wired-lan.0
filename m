Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 735D6C5AD5A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 12 Aug 2026 21:07:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1190280F7C;
	Wed, 12 Aug 2026 21:07:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jIOrUgXvUOYP; Wed, 12 Aug 2026 21:07:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E71F680F79
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786568868;
	bh=a6QHA9fcaiIdsC7ja7KLXHT+8iaEKLOp2dnZnBBAShE=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=Wh/UHZjWyBjWsG5jsWnz/aCVoZ4goon8Tv4+35I208JqepMFKkxJ752aQfJFZ8hnp
	 UBHzBE99VhNMusBRT1g7qm1QFa5rulsRUdn2QvytymKiVRI2IuchAKJCli/ZYn9PAz
	 tsTrOdQ6ZGXIgD6vPbfCpSr6tOe1I7fuh1cIEgl/Mx3lh3jl7M2Vl/HVMdU2TPTCia
	 bJKE6PS8Ae6vgintEKJ5moY88dwg7u7Mg4FeHOtdrtcN/QeDVM5XcszstsKfbKisQi
	 ynGiYuRJFHfNaY3qZjx5DG9P5RG89+O8DZ8H237QbWCBcKag+sFcLkA0m3NF8PxCiY
	 YRjdzxeMh3Wag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E71F680F79;
	Wed, 12 Aug 2026 21:07:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 074411AF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 21:07:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0510940219
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 21:07:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D5nCrSJpeEfK for <intel-wired-lan@lists.osuosl.org>;
 Wed, 12 Aug 2026 21:07:46 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3B1AC401F6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3B1AC401F6
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3B1AC401F6
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 21:07:45 +0000 (UTC)
X-CSE-ConnectionGUID: GHFxj75MTf2dli0q6GKj4w==
X-CSE-MsgGUID: QrZkxxz1TYe5XoFYMhqyqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="98652104"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; d="scan'208";a="98652104"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 14:07:44 -0700
X-CSE-ConnectionGUID: dY/6M27yTneLviTVy8Ko4Q==
X-CSE-MsgGUID: Y5MTH+XPQ2iGtzJTZrFSbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; d="scan'208";a="261985762"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orviesa006.jf.intel.com with ESMTP; 12 Aug 2026 14:07:41 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 77AA4332A4;
 Wed, 12 Aug 2026 22:07:40 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Date: Wed, 12 Aug 2026 22:18:04 +0200
Message-ID: <20260812204619.32253-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786568866; x=1818104866;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=GIMCHuDf0hSA7t84/iP8Kti6SO6m2OBoFJccYtnHjZQ=;
 b=nxsbS7pQ5Ex7IDfrstjRSqt2BJaj/J3FSw5y0WZQh/S77MWmDuijw4Ix
 R1xSBCTmRcC09Mmsb8onhjaUW9ZfTR3ERYMIiLgYX0m25l9fPPBPFdEWW
 7HbvmnscUxdo8wpE9b1SuGZmfvoKq+xu+563Jd7RZKYyRMNZ6W9oOfWbd
 /u4zks1i5uNpdup2MKkKD4exPUXCzEyw50NRvr4pz59/IQYaOfVdOG6GD
 8EhddD6jr9eGE5hKTuHh71EWbNAbKQGrKq8DApc49rh7hmloRfqMP3MvL
 RRyweeXp9urKejYBIiDXubWSC2c3rytqs51FK3E+nAEiRRh8/MURWRAH3
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=nxsbS7pQ
Subject: [Intel-wired-lan] [PATCH net 0/2][pull request] Intel Wired LAN
 Driver Updates 2026-08-12 (ice)
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
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

fix an issue on ice which increasing VF queue count causes
out-of-bounds access of the statistics arrays

Przemek Kitszel (2):
  ice: move ice_vsi_realloc_stat_arrays() up
  ice: fix stats array overflow via proper realloc

 drivers/net/ethernet/intel/ice/ice.h     |   2 +
 drivers/net/ethernet/intel/ice/ice_lib.c | 195 ++++++++++-------------
 2 files changed, 84 insertions(+), 113 deletions(-)

Previous revision of the fix was part of our last bundle [0],
but here I'm improving only my patches

[0] https://lore.kernel.org/netdev/20260804222205.1580328-1-anthony.l.nguyen@intel.com

changes:
 apply Sashiko feedback for edge cases, see the patch for details
 drop the rest of the patches for now - with the caveat that some
 could still be merged directly from [0] thread

-- 
2.54.0

