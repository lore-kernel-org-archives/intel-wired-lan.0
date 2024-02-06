Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1429C4828D
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Feb 2024 16:41:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4FB7C6068B;
	Tue,  6 Feb 2024 16:41:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4FB7C6068B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1707237661;
	bh=CdFaqHcDoOkX43EmeJgRSmRXDYjhMSm9Aby7Dx9hD4U=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=gO9XzrjJ1ca9GchjcYJMZ/3TUn4KDYRcGGh8m3LfRYYefrbEGKCw5CB1bmrLXilNZ
	 Hy5hXyaWPaDti9fUQpEnpYVKRfkUaz7B0U07YpQhLR3oq7jJQG2sB8rmncBsTqwtLm
	 P20jPlYDNdXtARioswd4F30pK3UjNuY641mex3DQQi+Pk1gzVu0WG3NRd88KNWPAYn
	 rHkMTdnS6E35A7iwELf0LJXMwk8qBdVMfrrRwV3J/yfPVYUh8CYTv9tsFCUOaKMzFC
	 /pMWPXjA7CaCRfm84PxIL1GenOcbyTWSujzWe5hxuYkpbwYj7gm3oSMfaZ4Qx9wVD1
	 etBh/7EvhEUxg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eSAhEg5-VaCo; Tue,  6 Feb 2024 16:41:00 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id A00C961042;
	Tue,  6 Feb 2024 16:41:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A00C961042
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id D16E21BF311
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Feb 2024 16:40:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BCBB682248
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Feb 2024 16:40:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yel5wthHRkHv for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Feb 2024 16:40:58 +0000 (UTC)
X-Greylist: delayed 427 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 06 Feb 2024 16:40:58 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4073F8216E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4073F8216E
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.20;
 helo=mgamail.intel.com; envelope-from=lukasz.plachno@intel.com;
 receiver=<UNKNOWN> 
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4073F8216E
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Feb 2024 16:40:58 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="684430"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="684430"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2024 08:33:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; d="scan'208";a="24307812"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa002.fm.intel.com with ESMTP; 06 Feb 2024 08:33:47 -0800
Received: from lplachno-mobl.ger.corp.intel.com
 (lplachno-mobl.ger.corp.intel.com [10.246.2.62])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 1E6FB27BBB;
 Tue,  6 Feb 2024 16:33:42 +0000 (GMT)
From: Lukasz Plachno <lukasz.plachno@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue,  6 Feb 2024 17:33:35 +0100
Message-Id: <20240206163337.11415-1-lukasz.plachno@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1707237659; x=1738773659;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=iZRaDyxGOUkspylNPZ2qIjk46reMpuOuyAsS/xaTqI4=;
 b=NA2mw0eINpQEYQi5IDv65HUGqx+w4rlXKeYO+zlnnT6ffqfnd5jHIVMT
 CDrfLC18MxYQblUts6XzsmpewkVDWd+UBm6AJz21hZ+nD7+ljvNGdVfLP
 cNHHYNn0z6eJeJs8euJgJ8xn0et51KU+Cz+hNnVQNBkgzjg2gBFxVCnvK
 tgZlryyG894uD0aWi6SFkqrqeSrF+zWoxvVazWCd2wy5BFG/bz3rra29u
 oJ6/Dmu3AEC5LkqWIiRSDvUeG5jQgjNISekJjBEr+fHZPqudcUQQ81kzH
 ZKU7t9oUBwwkS78+2LbTyMZce7Z3HfmrNnNrH/wvyBRn7aOk3BYafSoZf
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=NA2mw0eI
Subject: [Intel-wired-lan] [PATCH iwl-next v5 0/2] ice: Support flow
 director ether type filters
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
Cc: netdev@vger.kernel.org, Lukasz Plachno <lukasz.plachno@intel.com>,
 brett.creeley@amd.com, horms@kernel.org, pmenzel@molgen.mpg.de
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Ethtool allows creating rules with type=ether, add support for such
filters in ice driver.
Patch 1 allows extending ice_fdir_comp_rules() with handling additional
type of filters.

v5: added missing documentation for parameter introduced in V4,
    extended commit message for patch adding flow-type ether rules support
v4: added warning explaining that masks other than broadcast and unicast
    are not supported, added check for empty filters
v3: fixed possible use of uninitialized variable "perfect_filter"
v2: fixed compilation warning by moving default: case between commits
Jakub Buchocki (1):
  ice: Implement 'flow-type ether' rules

Lukasz Plachno (1):
  ice: Remove unnecessary argument from ice_fdir_comp_rules()

 .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 141 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_fdir.c     | 112 ++++++++------
 drivers/net/ethernet/intel/ice/ice_fdir.h     |  11 ++
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 4 files changed, 218 insertions(+), 47 deletions(-)

-- 
2.34.1

