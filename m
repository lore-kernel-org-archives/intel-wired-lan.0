Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAB2C4167B
	for <intel-wired-lan@archiver.kernel.org>; Fri, 15 Dec 2023 11:03:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B83EA831BD;
	Fri, 15 Dec 2023 11:03:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B83EA831BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1702638228;
	bh=U4209t8e/fb6rgCqbLqCMuavtPXgQmWhVHw3AOuXcGM=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=Tj5a/TzHrWEz7jpvMiTEV4adDYSE0Dx0qx/zgx4oE4VVPHRZq3kM7RPAInuR7lQcz
	 cJorvf9suemRobbQ6JdsQa752y3R/mA/Sir4ApNYrbHm/gfg4NREcTCqAg9JL8JdZ9
	 wRyIsBDhsrfIT/cEFhoXtRPsSEMNTVlX8FHte4Ky5ymBVXf2a08QZW+ba2m3gCQPlw
	 beMveP2G2GH55Xu+xSnFmZg9kH7KYvP6iYcjH5wxGwtuSWToWrwMx7R1KS8USjmSsc
	 dtgmVTP7hAtZimP88sXtXvrjbMaHlBIM8OUauRdj5YTRErpdGNwGtSclEX50TPnAdK
	 LIumuw0ABULbA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OnKLi5SzP8aP; Fri, 15 Dec 2023 11:03:48 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id C16B683DA3;
	Fri, 15 Dec 2023 11:03:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C16B683DA3
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 0251F1BF83B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 Dec 2023 11:03:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D7A6E83AB2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 Dec 2023 11:03:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D7A6E83AB2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B2zMTZTLKzlY for <intel-wired-lan@lists.osuosl.org>;
 Fri, 15 Dec 2023 11:03:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0736381EDE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 Dec 2023 11:03:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0736381EDE
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="385679104"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; d="scan'208";a="385679104"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2023 03:03:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="918408307"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; d="scan'208";a="918408307"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmsmga001.fm.intel.com with ESMTP; 15 Dec 2023 03:03:42 -0800
Received: from rozewie.igk.intel.com (unknown [10.211.8.69])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 60C7B39C82;
 Fri, 15 Dec 2023 11:03:41 +0000 (GMT)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Fri, 15 Dec 2023 12:01:55 +0100
Message-Id: <20231215110157.296923-1-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702638224; x=1734174224;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ifBqiRbZSFJIDtKEP14esPwUo7A2NcTv92fXWwVO+E8=;
 b=LS/AVTEyk/foXkfrD7L0/tdInODoPXqwCokAsdPKr7kvGb1i6h38DhqM
 q/V3TkdOAvM1an2s3J/Os1n2ipOESMh1OybYJyra+0pKTxqa6NRHfF+nz
 AQiM3JFTnhC/vRVV5UD1Lm7ztA7RGaCBPRjfcA9Vi7i2Nx0vkJGJZFYj9
 rsVjXv24/O6JSpry5HPRO1RP+pjBeUF1xm7C7yG7SBzQldM13ecgFKCqi
 QSm/SJ3NTgRLqbf8/+8OGjD5FkGPZlkj9LZqUtGrk8IwCxrHxX1h18VQj
 rLyk+dwbuEF0ue/a2PiT4967ulrMzH1FhDziyf5zWECRtTRUAXscNUoPb
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=LS/AVTEy
Subject: [Intel-wired-lan] [PATCH iwl-net 0/2] Fixes for link-down-on-close
 flag
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
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Small series of fixes for link-down-on-close ethtool flag usecase.

Katarzyna Wieczerzycka (1):
  ice: Fix link_down_on_close message

Ngai-Mint Kwan (1):
  ice: Shut down VSI with "link-down-on-close" enabled

 drivers/net/ethernet/intel/ice/ice_main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
2.40.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
