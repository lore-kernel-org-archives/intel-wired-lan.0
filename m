Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9928CCE7D0F
	for <intel-wired-lan@archiver.kernel.org>; Tue,  1 Oct 2024 10:40:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F513812AB;
	Tue,  1 Oct 2024 10:40:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 05J-AQEhJ6Jw; Tue,  1 Oct 2024 10:40:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B1CDB812CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1727779243;
	bh=06bJqhbx2MYKJAU9GtMapS/KL1xieeo7qiYUKi/cM6w=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=ypeFxGVWFV8f9wBOn1c0w5zb0tkYnj97rM2Y66+XZweINYFhK7wL1VftAESxKZmKo
	 HwggmIkeG9nVroz/mKgVfqKtnPs3ztXddmSeAfU/4HBjuangG9uhDXUauVJHiGdvhr
	 c3L8GIzzKw1jQgiLbNcmS5LEaUo9f1jXw3NgRnBDbMBXQ8rkXqbfaJI4TOPeqaHZBg
	 T5sAzflm2qS+KegGlTnJ25QO/9xhsgTFZo08QRnJ+KCCgFr//AxcxAHlJGfU68NwEW
	 1cMTGo6Tv4nKrnqZ2omUuabJNaODOJhdIUVw03fQVv/24qEBrEAU9WFrvKBAAObGgR
	 8VEwQEdgbEWAw==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1CDB812CE;
	Tue,  1 Oct 2024 10:40:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 00CF41BF955
 for <intel-wired-lan@lists.osuosl.org>; Tue,  1 Oct 2024 10:40:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E36D4812CD
 for <intel-wired-lan@lists.osuosl.org>; Tue,  1 Oct 2024 10:40:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KP1tYUPC4xS0 for <intel-wired-lan@lists.osuosl.org>;
 Tue,  1 Oct 2024 10:40:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=mateusz.polchlopek@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 06E09812AB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 06E09812AB
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 06E09812AB
 for <intel-wired-lan@lists.osuosl.org>; Tue,  1 Oct 2024 10:40:40 +0000 (UTC)
X-CSE-ConnectionGUID: NbOSfI0JQMilkxsCT7X40g==
X-CSE-MsgGUID: 22cH0VciRZedhOZEWWVgow==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="44433906"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; d="scan'208";a="44433906"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2024 03:40:39 -0700
X-CSE-ConnectionGUID: GoZVddivRa+m88kEZ4WDNQ==
X-CSE-MsgGUID: CMWetsxARrujVleCRsVC9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; d="scan'208";a="104447751"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orviesa002.jf.intel.com with ESMTP; 01 Oct 2024 03:40:38 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 9F0A527BC4;
 Tue,  1 Oct 2024 11:40:36 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue,  1 Oct 2024 06:26:03 -0400
Message-Id: <20241001102605.4526-1-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727779241; x=1759315241;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=AC4nt/hIi7YclL0fsOm041GyvxgfORC0BiVRrckpBzg=;
 b=Fok1wNuU0sPolGk848auZmwRUkBMRVtyc/1z++n4ado9pi7e19Mx/EvP
 7sWUuJH0dx1XYB0mzSREhLB5GTdki4Z+RjlqWu2AWh4t8u/ir8yR/Cqrv
 XO2/jtq6aQJXIrXHCKAxlJpSXKYOoTtUhDgGMVrNdzzYJpt0SV8kHmYzM
 e0zEDIiDU/6v9q6Eurm8h4eSuXdv3BxTofwLjMH4aM4mPcG5unzSW1Q23
 ZTGwrDpzbXqPBPwqtWMpzRerHlJz2D6rMZsaGKD4WACl9BR0z+H86hUm/
 4ddEP0sXXSC8WOzu4hAw0Hw2QHHqYkMEpZaCm3Tir4Rv/bDaW7v1bwrSN
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Fok1wNuU
Subject: [Intel-wired-lan] [PATCH iwl-next 0/2] Extend the dump serdes
 equalizer values feature
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
Cc: netdev@vger.kernel.org, Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Extend the work done in commit 70838938e89c ("ice: Implement driver
functionality to dump serdes equalizer values") by refactor the
ice_get_tx_rx_equa() function, shorten struct fields names and add
new Rx registers that can be read using command:
 $ ethtool -d interface_name.

Mateusz Polchlopek (2):
  ice: rework of dump serdes equalizer values feature
  ice: extend dump serdes equalizer values feature

 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  17 +++
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 110 +++++++-----------
 drivers/net/ethernet/intel/ice/ice_ethtool.h  |  39 +++++--
 3 files changed, 89 insertions(+), 77 deletions(-)


base-commit: 3b26fcd8529dc446af79c6023a1850260ceeaba7
-- 
2.38.1

