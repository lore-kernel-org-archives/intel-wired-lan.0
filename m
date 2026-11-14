Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109E6606A323
	for <intel-wired-lan@archiver.kernel.org>; Sat, 14 Nov 2026 21:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=W7A6Kpmr;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UmObXcqn
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D173740778;
	Sat, 14 Nov 2026 21:28:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9rDfyMGACA91; Sat, 14 Nov 2026 21:28:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D8F68407C5
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794691698;
	b=KjWGIrVw1JToDu3Nos6ObAZGkIjFGRvh+GBta+GSor1vfB/BTbyAJzXbZOxaP6V3c+Od
	 IxuhxsfipzFTPZnWT12aJRqXKffuNa+mssdcLR8Hz6WsHHTC9nwNYZRljrQgFMPT45bZ5
	 947OSOhbRJ1ybi3Y82KXs7q7EBhn1x4+TWeBCPbdcidJUiVdcFl80+TgMUY5/IqkIeLmX
	 7wI8lHoU1P+HXLr/tKKDUqv3I8f95SRnSMhroJIpKV/qatYxwX/FD9LMo2oNbJzH5UNcw
	 REblD7cfBsoBPaip46PLXAMGLNgoLwnS3cBgdXZO8xI7wlZcniDITa4BuxCzznOeT2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794691698;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=w75fWzLKWSPnIVpt9Z870/IbjjI4y3vkUPhBg6iLLCc=;
	b=DkQtlm9nDSwphpLmJzvmGmunK7mIr82Eim8AGklIIADfCTq8XTldxwnT6miGvxx3LCBD
	 dKRUQc3IflaWKVEEqygYzK1qEnYIMxKDcfgY2E9tLnvwWxUul0VEoWGWR5lLNN67aLSPK
	 nI8DhsmKmEnLF9sYXDfBH1UIS3uwH3BfwYmDtTjgDC9U8/HBGaRkRam6uKm6AqsgPEYKo
	 fwdlO5Losl5QalIQeYWqZlx2zF1LBYSsTYblcNxaTbyEXntCWOVe07g8J23hgRPPLnxeT
	 W3v4b2dPDXMrOiki/xMYb2jT9zEz9B3IOF3Y3JxHPLwpr+KQ4C5GYfbpjWROgWm/7iA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794691698;
	bh=w75fWzLKWSPnIVpt9Z870/IbjjI4y3vkUPhBg6iLLCc=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=W7A6Kpmrnvqwml3Dp2SyLDly6xZmlAtNGY2Wi8f/zXS/fDF2Va62zMfttpjCnuBV7
	 p34oZmG2pWcf94FgTFEqo0KjZmQP6Ep/PUVC9mD4yAi2x43Gh5+PCmWsa8bw+5+gtM
	 JPLFnZGJI4BVdterWJ0aTB9jDy2aOLR9DLAieLbGMmryKiEpdeMk2ooewRJ7R3lDBu
	 yk5iNU6H7zFavFD+EmrVsaFbds89ysZ81CRueMyHyJ67nnyR0sup/e46BN2UPakyGD
	 sAugkFv6b0FXmd626TwfZesNi9MZAivahf9VGoHy3B6+F5IS81vGNCf2LghuN6i9Uo
	 BFAgXH0iZQpIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D8F68407C5;
	Sat, 14 Nov 2026 21:28:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D187328C
 for <intel-wired-lan@lists.osuosl.org>; Sat, 14 Nov 2026 21:28:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B768140095
 for <intel-wired-lan@lists.osuosl.org>; Sat, 14 Nov 2026 21:28:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A7aBFAWNkHhM for <intel-wired-lan@lists.osuosl.org>;
 Sat, 14 Nov 2026 21:28:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2545B40063
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=UmObXcqn
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2545B40063
 for <intel-wired-lan@lists.osuosl.org>; Sat, 14 Nov 2026 21:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794691695; x=1826227695; h=date:from:to:subject:message-id;
 bh=1/0Zv8E1WbJVX1NVo4ce7Di1sZYdfxAA76/kIR/9oSQ=;
 b=UmObXcqnf2Fn6bvJWpHNSCeHtxmu0KDXk/dco7OKl2hDd3mUDvl4G5h5
 sr5leJW78qZRhlV8DtGY/prUuwmEte1xK8ZKkEmVPXGZCEDCfrz4cU16V
 0m/p0rjUxAeHY6RgJRNXT4p3mXfsvCHcXivN1+ATNwbX78Df3Q4M3azdd
 3rW6QERC5LQ1/tSRKU4hmT2RDfnRyYk9vVtp82KS/kpb5O54srCEWJZ74
 cWKSeiHHHDAZf5rZtvwz5eiorjfGJ5n5gI3AtMYkgqdtl7c70RpRkqm6W
 aZQUdOvhBK9kFmU1nrOETgvnnlg0fFlNQfE9KDkrIWi15PRyCoYsmwrfN Q==;
X-CSE-ConnectionGUID: PMgqfFnsR2KdkpEIhZA9aA==
X-CSE-MsgGUID: 9csZ+5H+RkKJ4EhQSYFc9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11966"; a="3365400"
X-IronPort-AV: E=Sophos;i="6.27,214,1787036400"; 
   d="scan'208";a="3365400"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2026 13:28:13 -0800
X-CSE-ConnectionGUID: cUpZE9YvSgmBAfi5cfvO+w==
X-CSE-MsgGUID: qWOJD/WTTv61KwUD6bhJhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,214,1787036400"; 
   d="scan'208";a="9528852"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa006.fm.intel.com with ESMTP; 14 Nov 2026 13:28:12 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xSLI9-0000000161O-3dly;
 Sat, 14 Nov 2026 21:28:09 +0000
Date: Sun, 15 Nov 2026 05:27:40 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:100GbE] BUILD SUCCESS
 d1f4b7c6b997c29de67ad7178ababac2328cb1b4
Message-ID: <20261115052740.um5CJoyq-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 100GbE
branch HEAD: d1f4b7c6b997c29de67ad7178ababac2328cb1b4  Merge branch 'eth-mpnic-checksum-and-segmentation-offloads'

elapsed time: 798m

configs tested: 646
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                 randconfig-2000-20261113    gcc-8.5.0
alpha                 randconfig-2000-20261114    gcc-12.5.0
alpha                 randconfig-2001-20261113    gcc-8.5.0
alpha                 randconfig-2001-20261114    gcc-12.5.0
alpha                 randconfig-2200-20261113    gcc-8.5.0  smatch
alpha                 randconfig-2200-20261114    gcc-9.5.0  smatch
alpha                randconfig-r2100-20261114    gcc-15.3.0 cocci
alpha                randconfig-r2101-20261114    clang-17   cocci
alpha                randconfig-r2302-20261114    gcc-16.2.0 sparse
alpha                randconfig-r2304-20261113    gcc-14.4.0 sparse
alpha                randconfig-r2305-20261114    gcc-8.5.0  sparse
alpha                randconfig-r2306-20261113    gcc-10.5.0 sparse
alpha                randconfig-r2308-20261114    gcc-8.5.0  sparse
alpha                randconfig-r2309-20261113    clang-24   sparse
alpha                randconfig-r2309-20261114    clang-19   sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                   randconfig-1000-20261114    clang-24
arc                   randconfig-1000-20261115    gcc-11.5.0
arc                   randconfig-1001-20261114    clang-24
arc                   randconfig-1001-20261115    gcc-11.5.0
arc                   randconfig-2000-20261113    gcc-16.2.0
arc                   randconfig-2000-20261114    gcc-11.5.0
arc                   randconfig-2001-20261113    gcc-16.2.0
arc                   randconfig-2001-20261114    gcc-11.5.0
arc                   randconfig-2002-20261113    gcc-16.2.0
arc                   randconfig-2002-20261114    gcc-11.5.0
arc                   randconfig-2003-20261113    gcc-16.2.0
arc                   randconfig-2003-20261114    gcc-11.5.0
arc                   randconfig-2004-20261113    gcc-16.2.0
arc                   randconfig-2004-20261114    gcc-11.5.0
arc                   randconfig-2005-20261113    gcc-16.2.0
arc                   randconfig-2005-20261114    gcc-11.5.0
arc                   randconfig-2200-20261113    gcc-14.4.0 smatch
arc                   randconfig-2200-20261114    gcc-8.5.0  smatch
arc                  randconfig-r2100-20261113    gcc-8.5.0  cocci
arc                  randconfig-r2100-20261114    gcc-12.5.0 cocci
arc                  randconfig-r2101-20261114    gcc-10.5.0 cocci
arc                  randconfig-r2105-20261113    gcc-8.5.0  cocci
arc                  randconfig-r2106-20261114    gcc-10.5.0 cocci
arc                  randconfig-r2107-20261114    clang-24   cocci
arc                  randconfig-r2108-20261113    gcc-11.5.0 cocci
arc                  randconfig-r2108-20261114    clang-24   cocci
arc                  randconfig-r2301-20261114    gcc-16.2.0 sparse
arc                  randconfig-r2304-20261113    gcc-13.5.0 sparse
arc                  randconfig-r2305-20261114    gcc-12.5.0 sparse
arc                  randconfig-r2306-20261114    gcc-8.5.0  sparse
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                            omap1_defconfig    clang-24
arm                   randconfig-1000-20261114    clang-24
arm                   randconfig-1000-20261115    gcc-11.5.0
arm                   randconfig-1001-20261114    clang-24
arm                   randconfig-1001-20261115    gcc-11.5.0
arm                   randconfig-1002-20261114    clang-24
arm                   randconfig-1002-20261115    gcc-11.5.0
arm                   randconfig-1003-20261114    clang-24
arm                   randconfig-1003-20261115    gcc-11.5.0
arm                   randconfig-2000-20261113    gcc-14.4.0
arm                   randconfig-2000-20261114    gcc-10.5.0
arm                   randconfig-2001-20261113    gcc-14.4.0
arm                   randconfig-2001-20261114    gcc-10.5.0
arm                   randconfig-2002-20261113    gcc-14.4.0
arm                   randconfig-2002-20261114    gcc-10.5.0
arm                   randconfig-2200-20261113    clang-24   smatch
arm                   randconfig-2200-20261114    clang-17   smatch
arm                  randconfig-r2100-20261113    gcc-9.5.0  cocci
arm                  randconfig-r2101-20261114    gcc-15.3.0 cocci
arm                  randconfig-r2102-20261113    gcc-8.5.0  cocci
arm                  randconfig-r2102-20261114    gcc-14     cocci
arm                  randconfig-r2105-20261114    gcc-8.5.0  cocci
arm                  randconfig-r2106-20261114    clang-24   cocci
arm                  randconfig-r2110-20261114    clang-24   cocci
arm                  randconfig-r2111-20261114    clang-24   cocci
arm                  randconfig-r2300-20261113    gcc-14.4.0 sparse
arm                  randconfig-r2302-20261114    gcc-14.4.0 sparse
arm                  randconfig-r2309-20261114    clang-24   sparse
arm                  randconfig-r2311-20261114    gcc-8.5.0  sparse
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261114    gcc-16.2.0
arm64                 randconfig-1001-20261114    gcc-16.2.0
arm64                 randconfig-1002-20261114    gcc-16.2.0
arm64                 randconfig-1003-20261114    gcc-16.2.0
arm64                 randconfig-2000-20261113    gcc-14.4.0
arm64                 randconfig-2000-20261114    gcc-10.5.0
arm64                 randconfig-2001-20261113    gcc-14.4.0
arm64                 randconfig-2001-20261114    gcc-10.5.0
arm64                 randconfig-2002-20261113    gcc-14.4.0
arm64                 randconfig-2002-20261114    gcc-10.5.0
arm64                 randconfig-2200-20261113    gcc-8.5.0  smatch
arm64                 randconfig-2200-20261114    clang-17   smatch
arm64                randconfig-r2101-20261114    gcc-14     cocci
arm64                randconfig-r2102-20261114    clang-17   cocci
arm64                randconfig-r2102-20261114    gcc-15.3.0 cocci
arm64                randconfig-r2103-20261113    gcc-9.5.0  cocci
arm64                randconfig-r2103-20261114    clang-17   cocci
arm64                randconfig-r2104-20261114    clang-17   cocci
arm64                randconfig-r2107-20261113    clang-24   cocci
arm64                randconfig-r2303-20261113    gcc-14.4.0 sparse
arm64                randconfig-r2310-20261114    clang-19   sparse
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261114    gcc-16.2.0
csky                  randconfig-1001-20261114    gcc-16.2.0
csky                  randconfig-2000-20261113    gcc-12.5.0
csky                  randconfig-2000-20261114    gcc-16.2.0
csky                  randconfig-2001-20261113    gcc-12.5.0
csky                  randconfig-2001-20261114    gcc-16.2.0
csky                  randconfig-2200-20261113    gcc-10.5.0 smatch
csky                  randconfig-2200-20261114    gcc-16.2.0 smatch
csky                 randconfig-r2101-20261113    gcc-15.3.0 cocci
csky                 randconfig-r2302-20261114    gcc-16.2.0 sparse
csky                 randconfig-r2306-20261114    clang-22   sparse
csky                 randconfig-r2307-20261114    clang-24   sparse
csky                 randconfig-r2310-20261114    clang-22   sparse
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261114    clang-24
hexagon               randconfig-1000-20261115    clang-24
hexagon               randconfig-1001-20261114    clang-24
hexagon               randconfig-1001-20261115    clang-24
hexagon               randconfig-2000-20261113    gcc-12.5.0
hexagon               randconfig-2000-20261114    gcc-16.2.0
hexagon               randconfig-2001-20261113    gcc-12.5.0
hexagon               randconfig-2001-20261114    gcc-16.2.0
hexagon               randconfig-2200-20261113    clang-17   smatch
hexagon               randconfig-2200-20261114    clang-24   smatch
hexagon              randconfig-r2101-20261113    gcc-8.5.0  cocci
hexagon              randconfig-r2102-20261114    gcc-8.5.0  cocci
hexagon              randconfig-r2104-20261113    gcc-9.5.0  cocci
hexagon              randconfig-r2104-20261114    gcc-15.3.0 cocci
hexagon              randconfig-r2108-20261114    clang-22   cocci
hexagon              randconfig-r2109-20261114    clang-22   cocci
hexagon              randconfig-r2111-20261114    clang-17   cocci
hexagon              randconfig-r2306-20261113    clang-24   sparse
hexagon              randconfig-r2306-20261114    gcc-11.5.0 sparse
hexagon              randconfig-r2311-20261114    clang-19   sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261114    gcc-14
i386        buildonly-randconfig-1001-20261114    gcc-14
i386        buildonly-randconfig-1002-20261114    gcc-14
i386        buildonly-randconfig-1003-20261114    gcc-14
i386        buildonly-randconfig-1004-20261114    gcc-14
i386        buildonly-randconfig-1005-20261114    gcc-14
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261114    gcc-12
i386                  randconfig-1000-20261115    clang-22
i386                  randconfig-1001-20261114    gcc-12
i386                  randconfig-1001-20261115    clang-22
i386                  randconfig-1002-20261114    gcc-12
i386                  randconfig-1002-20261115    clang-22
i386                  randconfig-1003-20261114    gcc-12
i386                  randconfig-1003-20261115    clang-22
i386                  randconfig-1004-20261114    gcc-12
i386                  randconfig-1004-20261115    clang-22
i386                  randconfig-1005-20261114    gcc-12
i386                  randconfig-1005-20261115    clang-22
i386                  randconfig-1006-20261114    gcc-12
i386                  randconfig-1006-20261115    clang-22
i386                  randconfig-1007-20261114    clang-22
i386                  randconfig-1008-20261114    clang-22
i386                  randconfig-1009-20261114    clang-22
i386                  randconfig-1010-20261114    clang-22
i386                  randconfig-1011-20261114    clang-22
i386                  randconfig-1012-20261114    clang-22
i386                  randconfig-1013-20261114    clang-22
i386                  randconfig-2000-20261113    gcc-12
i386                  randconfig-2000-20261114    clang-22
i386                  randconfig-2001-20261113    gcc-12
i386                  randconfig-2001-20261114    clang-22
i386                  randconfig-2002-20261113    gcc-12
i386                  randconfig-2002-20261114    clang-22
i386                  randconfig-2003-20261113    gcc-12
i386                  randconfig-2003-20261114    clang-22
i386                  randconfig-2004-20261113    gcc-12
i386                  randconfig-2004-20261114    clang-22
i386                  randconfig-2005-20261113    gcc-12
i386                  randconfig-2005-20261114    clang-22
i386                  randconfig-2100-20261113    gcc-14     cocci
i386                  randconfig-2100-20261114    gcc-14     cocci
i386                  randconfig-2101-20261113    gcc-14     cocci
i386                  randconfig-2101-20261114    gcc-14     cocci
i386                  randconfig-2102-20261113    gcc-14     cocci
i386                  randconfig-2102-20261114    gcc-14     cocci
i386                  randconfig-2103-20261113    gcc-14     cocci
i386                  randconfig-2103-20261114    gcc-14     cocci
i386                  randconfig-2104-20261113    gcc-14     cocci
i386                  randconfig-2104-20261114    gcc-14     cocci
i386                  randconfig-2105-20261113    gcc-14     cocci
i386                  randconfig-2105-20261114    gcc-14     cocci
i386                  randconfig-2200-20261113    clang-22   smatch
i386                  randconfig-2200-20261114    gcc-14     smatch
i386                  randconfig-2300-20261113    gcc-14     sparse
i386                  randconfig-2300-20261114    clang-22   sparse
i386                  randconfig-2301-20261113    gcc-14     sparse
i386                  randconfig-2301-20261114    clang-22   sparse
i386                  randconfig-2302-20261113    gcc-14     sparse
i386                  randconfig-2302-20261114    clang-22   sparse
i386                 randconfig-r2100-20261114    gcc-14     cocci
i386                 randconfig-r2101-20261114    gcc-12.5.0 cocci
i386                 randconfig-r2106-20261114    clang-22   cocci
i386                 randconfig-r2106-20261114    clang-24   cocci
i386                 randconfig-r2108-20261114    gcc-8.5.0  cocci
i386                 randconfig-r2110-20261113    clang-24   cocci
i386                 randconfig-r2111-20261114    clang-24   cocci
i386                 randconfig-r2305-20261113    gcc-13.5.0 sparse
i386                 randconfig-r2306-20261114    clang-22   sparse
i386                 randconfig-r2309-20261113    gcc-10.5.0 sparse
i386                 randconfig-r2309-20261114    clang-22   sparse
i386                 randconfig-r2310-20261114    clang-22   sparse
i386                 randconfig-r2311-20261114    clang-22   sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261114    clang-24
loongarch             randconfig-1000-20261115    clang-24
loongarch             randconfig-1001-20261114    clang-24
loongarch             randconfig-1001-20261115    clang-24
loongarch             randconfig-2000-20261113    gcc-8.5.0
loongarch             randconfig-2000-20261114    gcc-11.5.0
loongarch             randconfig-2001-20261113    gcc-8.5.0
loongarch             randconfig-2001-20261114    gcc-11.5.0
loongarch             randconfig-2200-20261113    gcc-16.2.0 smatch
loongarch             randconfig-2200-20261114    clang-18   smatch
loongarch            randconfig-r2100-20261114    clang-17   cocci
loongarch            randconfig-r2105-20261114    gcc-14     cocci
loongarch            randconfig-r2109-20261114    clang-17   cocci
loongarch            randconfig-r2300-20261114    gcc-16.2.0 sparse
loongarch            randconfig-r2303-20261113    gcc-13.5.0 sparse
loongarch            randconfig-r2303-20261114    gcc-8.5.0  sparse
loongarch            randconfig-r2305-20261114    gcc-14.4.0 sparse
loongarch            randconfig-r2309-20261114    clang-22   sparse
loongarch            randconfig-r2309-20261114    gcc-8.5.0  sparse
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                  randconfig-2000-20261113    gcc-8.5.0
m68k                  randconfig-2000-20261114    gcc-12.5.0
m68k                  randconfig-2001-20261113    gcc-8.5.0
m68k                  randconfig-2001-20261114    gcc-12.5.0
m68k                  randconfig-2200-20261114    gcc-16.2.0 smatch
m68k                 randconfig-r2104-20261114    gcc-11.5.0 cocci
m68k                 randconfig-r2107-20261114    clang-17   cocci
m68k                 randconfig-r2110-20261114    clang-17   cocci
m68k                 randconfig-r2303-20261114    gcc-14.4.0 sparse
m68k                 randconfig-r2307-20261113    clang-24   sparse
m68k                 randconfig-r2310-20261113    clang-24   sparse
m68k                 randconfig-r2310-20261114    gcc-8.5.0  sparse
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2000-20261113    gcc-8.5.0
microblaze            randconfig-2000-20261114    gcc-12.5.0
microblaze            randconfig-2001-20261113    gcc-8.5.0
microblaze            randconfig-2001-20261114    gcc-12.5.0
microblaze            randconfig-2200-20261113    gcc-8.5.0  smatch
microblaze            randconfig-2200-20261114    gcc-9.5.0  smatch
microblaze           randconfig-r2109-20261114    clang-24   cocci
microblaze           randconfig-r2109-20261114    gcc-8.5.0  cocci
microblaze           randconfig-r2111-20261114    clang-22   cocci
microblaze           randconfig-r2302-20261114    gcc-8.5.0  sparse
microblaze           randconfig-r2304-20261114    gcc-8.5.0  sparse
microblaze           randconfig-r2311-20261113    clang-24   sparse
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                            jazz_defconfig    clang-24
mips                         omega2p_defconfig    clang-24
mips                  randconfig-2000-20261113    gcc-16.2.0
mips                  randconfig-2000-20261114    gcc-16.2.0
mips                  randconfig-2001-20261113    gcc-16.2.0
mips                  randconfig-2001-20261114    gcc-16.2.0
mips                  randconfig-2002-20261113    gcc-16.2.0
mips                  randconfig-2002-20261114    gcc-16.2.0
mips                  randconfig-2200-20261113    clang-24   smatch
mips                  randconfig-2200-20261114    gcc-15.3.0 smatch
mips                 randconfig-r2100-20261113    gcc-15.3.0 cocci
mips                 randconfig-r2105-20261114    gcc-11.5.0 cocci
mips                 randconfig-r2106-20261113    clang-24   cocci
mips                 randconfig-r2106-20261114    clang-17   cocci
mips                 randconfig-r2108-20261114    clang-17   cocci
mips                 randconfig-r2111-20261114    gcc-10.5.0 cocci
mips                 randconfig-r2301-20261114    gcc-16.2.0 sparse
mips                 randconfig-r2303-20261114    gcc-12.5.0 sparse
mips                 randconfig-r2308-20261114    clang-19   sparse
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261114    clang-24
nios2                 randconfig-1000-20261115    clang-24
nios2                 randconfig-1001-20261114    clang-24
nios2                 randconfig-1001-20261115    clang-24
nios2                 randconfig-2000-20261113    gcc-8.5.0
nios2                 randconfig-2000-20261114    gcc-11.5.0
nios2                 randconfig-2001-20261113    gcc-8.5.0
nios2                 randconfig-2001-20261114    gcc-11.5.0
nios2                 randconfig-2200-20261113    gcc-10.5.0 smatch
nios2                 randconfig-2200-20261114    gcc-11.5.0 smatch
nios2                randconfig-r2105-20261113    gcc-9.5.0  cocci
nios2                randconfig-r2108-20261114    gcc-10.5.0 cocci
nios2                randconfig-r2300-20261114    gcc-16.2.0 sparse
nios2                randconfig-r2304-20261114    gcc-12.5.0 sparse
nios2                randconfig-r2306-20261114    clang-24   sparse
nios2                randconfig-r2307-20261113    clang-24   sparse
nios2                randconfig-r2307-20261114    clang-22   sparse
nios2                randconfig-r2310-20261114    gcc-11.5.0 sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc              randconfig-2000-20261113    gcc-16.2.0
openrisc              randconfig-2000-20261114    gcc-16.2.0
openrisc              randconfig-2001-20261113    gcc-16.2.0
openrisc              randconfig-2001-20261114    gcc-16.2.0
openrisc              randconfig-2002-20261113    gcc-16.2.0
openrisc              randconfig-2002-20261114    gcc-16.2.0
openrisc              randconfig-2200-20261113    gcc-14.4.0 smatch
openrisc              randconfig-2200-20261114    gcc-16.2.0 smatch
openrisc             randconfig-r2103-20261113    gcc-8.5.0  cocci
openrisc             randconfig-r2104-20261113    gcc-8.5.0  cocci
openrisc             randconfig-r2104-20261114    gcc-10.5.0 cocci
openrisc             randconfig-r2110-20261114    clang-24   cocci
openrisc             randconfig-r2300-20261113    gcc-13.5.0 sparse
openrisc             randconfig-r2301-20261113    gcc-14.4.0 sparse
openrisc             randconfig-r2307-20261114    clang-19   sparse
openrisc             randconfig-r2307-20261114    gcc-11.5.0 sparse
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                randconfig-2000-20261113    gcc-8.5.0
parisc                randconfig-2000-20261114    gcc-11.5.0
parisc                randconfig-2001-20261113    gcc-8.5.0
parisc                randconfig-2001-20261114    gcc-11.5.0
parisc                randconfig-2200-20261113    gcc-16.2.0 smatch
parisc                randconfig-2200-20261114    gcc-8.5.0  smatch
parisc               randconfig-r2100-20261114    gcc-10.5.0 cocci
parisc               randconfig-r2103-20261114    gcc-15.3.0 cocci
parisc               randconfig-r2103-20261114    gcc-8.5.0  cocci
parisc               randconfig-r2106-20261113    gcc-11.5.0 cocci
parisc               randconfig-r2304-20261114    gcc-16.2.0 sparse
parisc               randconfig-r2310-20261114    clang-24   sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                    motionpro_defconfig    clang-24
powerpc                      mpc5200_defconfig    clang-24
powerpc                  mpc837x_rdb_defconfig    clang-24
powerpc               randconfig-2000-20261113    clang-24
powerpc               randconfig-2000-20261114    gcc-8.5.0
powerpc               randconfig-2001-20261113    clang-24
powerpc               randconfig-2001-20261114    gcc-8.5.0
powerpc               randconfig-2002-20261113    clang-24
powerpc               randconfig-2002-20261114    gcc-8.5.0
powerpc               randconfig-2200-20261113    clang-24   smatch
powerpc               randconfig-2200-20261114    clang-24   smatch
powerpc              randconfig-r2100-20261114    gcc-8.5.0  cocci
powerpc              randconfig-r2101-20261114    gcc-11.5.0 cocci
powerpc              randconfig-r2105-20261114    gcc-10.5.0 cocci
powerpc              randconfig-r2107-20261114    clang-22   cocci
powerpc              randconfig-r2109-20261113    clang-24   cocci
powerpc              randconfig-r2110-20261114    gcc-10.5.0 cocci
powerpc              randconfig-r2111-20261113    clang-24   cocci
powerpc              randconfig-r2301-20261114    gcc-8.5.0  sparse
powerpc              randconfig-r2308-20261114    clang-22   sparse
powerpc              randconfig-r2308-20261114    gcc-11.5.0 sparse
powerpc64             randconfig-2000-20261113    clang-24
powerpc64             randconfig-2000-20261114    gcc-8.5.0
powerpc64             randconfig-2001-20261113    clang-24
powerpc64             randconfig-2001-20261114    gcc-8.5.0
powerpc64             randconfig-2002-20261113    clang-24
powerpc64             randconfig-2002-20261114    gcc-8.5.0
powerpc64             randconfig-2200-20261113    gcc-10.5.0 smatch
powerpc64             randconfig-2200-20261114    clang-17   smatch
powerpc64            randconfig-r2102-20261114    gcc-12.5.0 cocci
powerpc64            randconfig-r2103-20261114    gcc-10.5.0 cocci
powerpc64            randconfig-r2103-20261114    gcc-11.5.0 cocci
powerpc64            randconfig-r2104-20261114    gcc-12.5.0 cocci
powerpc64            randconfig-r2108-20261113    clang-24   cocci
powerpc64            randconfig-r2108-20261114    clang-24   cocci
powerpc64            randconfig-r2109-20261114    clang-24   cocci
powerpc64            randconfig-r2300-20261114    gcc-12.5.0 sparse
powerpc64            randconfig-r2300-20261114    gcc-14.4.0 sparse
powerpc64            randconfig-r2305-20261113    gcc-14.4.0 sparse
powerpc64            randconfig-r2305-20261114    gcc-16.2.0 sparse
powerpc64            randconfig-r2306-20261113    clang-24   sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                 randconfig-1000-20261114    gcc-15.3.0
riscv                 randconfig-1001-20261114    gcc-15.3.0
riscv                 randconfig-2000-20261113    gcc-11.5.0
riscv                 randconfig-2000-20261114    gcc-12.5.0
riscv                 randconfig-2001-20261113    gcc-11.5.0
riscv                 randconfig-2001-20261114    gcc-12.5.0
riscv                 randconfig-2002-20261113    gcc-11.5.0
riscv                 randconfig-2002-20261114    gcc-12.5.0
riscv                 randconfig-2003-20261113    gcc-11.5.0
riscv                 randconfig-2003-20261114    gcc-12.5.0
riscv                 randconfig-2004-20261113    gcc-11.5.0
riscv                 randconfig-2004-20261114    gcc-12.5.0
riscv                 randconfig-2005-20261113    gcc-11.5.0
riscv                 randconfig-2005-20261114    gcc-12.5.0
riscv                 randconfig-2200-20261113    clang-17   smatch
riscv                 randconfig-2200-20261114    clang-24   smatch
riscv                randconfig-r2102-20261113    gcc-9.5.0  cocci
riscv                randconfig-r2111-20261113    gcc-11.5.0 cocci
riscv                randconfig-r2309-20261114    gcc-11.5.0 sparse
riscv                randconfig-r2310-20261113    clang-24   sparse
riscv                randconfig-r2311-20261114    clang-22   sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                  randconfig-1000-20261114    gcc-15.3.0
s390                  randconfig-1001-20261114    gcc-15.3.0
s390                  randconfig-2000-20261113    gcc-11.5.0
s390                  randconfig-2000-20261114    clang-24
s390                  randconfig-2001-20261113    gcc-11.5.0
s390                  randconfig-2001-20261114    clang-24
s390                  randconfig-2002-20261113    gcc-11.5.0
s390                  randconfig-2002-20261114    clang-24
s390                  randconfig-2003-20261113    gcc-11.5.0
s390                  randconfig-2003-20261114    clang-24
s390                  randconfig-2004-20261113    gcc-11.5.0
s390                  randconfig-2004-20261114    clang-24
s390                  randconfig-2005-20261113    gcc-11.5.0
s390                  randconfig-2005-20261114    clang-24
s390                  randconfig-2200-20261113    clang-24   smatch
s390                  randconfig-2200-20261114    clang-24   smatch
s390                 randconfig-r2103-20261114    gcc-12.5.0 cocci
s390                 randconfig-r2107-20261114    gcc-10.5.0 cocci
s390                 randconfig-r2107-20261114    gcc-8.5.0  cocci
s390                 randconfig-r2306-20261114    clang-19   sparse
s390                 randconfig-r2311-20261114    gcc-11.5.0 sparse
s390                 randconfig-r2311-20261114    gcc-8.5.0  sparse
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                          ecovec24_defconfig    clang-24
sh                    randconfig-1000-20261114    gcc-15.3.0
sh                    randconfig-1001-20261114    gcc-15.3.0
sh                    randconfig-2000-20261113    gcc-14.4.0
sh                    randconfig-2000-20261114    gcc-13.5.0
sh                    randconfig-2001-20261113    gcc-14.4.0
sh                    randconfig-2001-20261114    gcc-13.5.0
sh                    randconfig-2002-20261113    gcc-14.4.0
sh                    randconfig-2002-20261114    gcc-13.5.0
sh                    randconfig-2003-20261113    gcc-14.4.0
sh                    randconfig-2003-20261114    gcc-13.5.0
sh                    randconfig-2004-20261113    gcc-14.4.0
sh                    randconfig-2004-20261114    gcc-13.5.0
sh                    randconfig-2005-20261113    gcc-14.4.0
sh                    randconfig-2005-20261114    gcc-13.5.0
sh                    randconfig-2200-20261113    gcc-14.4.0 smatch
sh                    randconfig-2200-20261114    gcc-9.5.0  smatch
sh                   randconfig-r2102-20261114    gcc-11.5.0 cocci
sh                   randconfig-r2105-20261114    gcc-12.5.0 cocci
sh                   randconfig-r2109-20261114    gcc-10.5.0 cocci
sh                   randconfig-r2110-20261114    clang-22   cocci
sh                   randconfig-r2302-20261114    gcc-12.5.0 sparse
sh                   randconfig-r2303-20261114    gcc-16.2.0 sparse
sh                   randconfig-r2304-20261114    gcc-14.4.0 sparse
sh                   randconfig-r2307-20261114    gcc-8.5.0  sparse
sh                            se7751_defconfig    clang-24
sparc                              allnoconfig    clang-24
sparc                 randconfig-1000-20261114    gcc-12.5.0
sparc                 randconfig-1001-20261114    gcc-12.5.0
sparc                 randconfig-2000-20261113    clang-24
sparc                 randconfig-2000-20261114    clang-21
sparc                 randconfig-2001-20261113    clang-24
sparc                 randconfig-2001-20261114    clang-21
sparc                 randconfig-2200-20261113    gcc-14.4.0 smatch
sparc                 randconfig-2200-20261114    gcc-8.5.0  smatch
sparc                randconfig-r2100-20261114    gcc-11.5.0 cocci
sparc                randconfig-r2101-20261113    gcc-9.5.0  cocci
sparc                randconfig-r2303-20261114    gcc-16.2.0 sparse
sparc                randconfig-r2304-20261114    gcc-16.2.0 sparse
sparc                randconfig-r2307-20261114    gcc-8.5.0  sparse
sparc                randconfig-r2309-20261114    gcc-8.5.0  sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261114    gcc-12.5.0
sparc64               randconfig-1001-20261114    gcc-12.5.0
sparc64               randconfig-2000-20261113    clang-24
sparc64               randconfig-2000-20261114    clang-21
sparc64               randconfig-2001-20261113    clang-24
sparc64               randconfig-2001-20261114    clang-21
sparc64               randconfig-2200-20261113    gcc-15.3.0 smatch
sparc64               randconfig-2200-20261114    gcc-16.2.0 smatch
sparc64              randconfig-r2102-20261114    gcc-10.5.0 cocci
sparc64              randconfig-r2104-20261113    gcc-15.3.0 cocci
sparc64              randconfig-r2104-20261114    gcc-14     cocci
sparc64              randconfig-r2308-20261113    clang-24   sparse
sparc64              randconfig-r2308-20261114    clang-22   sparse
sparc64              randconfig-r2310-20261113    gcc-10.5.0 sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261114    gcc-12.5.0
um                    randconfig-1001-20261114    gcc-12.5.0
um                    randconfig-2000-20261113    clang-24
um                    randconfig-2000-20261114    clang-21
um                    randconfig-2001-20261113    clang-24
um                    randconfig-2001-20261114    clang-21
um                    randconfig-2200-20261113    clang-24   smatch
um                    randconfig-2200-20261114    gcc-14     smatch
um                   randconfig-r2102-20261113    gcc-15.3.0 cocci
um                   randconfig-r2103-20261113    gcc-15.3.0 cocci
um                   randconfig-r2104-20261114    gcc-8.5.0  cocci
um                   randconfig-r2107-20261113    gcc-11.5.0 cocci
um                   randconfig-r2109-20261113    gcc-11.5.0 cocci
um                   randconfig-r2110-20261114    gcc-8.5.0  cocci
um                   randconfig-r2111-20261114    gcc-8.5.0  cocci
um                   randconfig-r2301-20261113    gcc-13.5.0 sparse
um                   randconfig-r2301-20261114    gcc-14.4.0 sparse
um                   randconfig-r2302-20261113    gcc-13.5.0 sparse
um                   randconfig-r2308-20261114    clang-24   sparse
um                   randconfig-r2309-20261113    clang-24   sparse
um                   randconfig-r2311-20261113    gcc-10.5.0 sparse
um                   randconfig-r2311-20261114    clang-24   sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261114    gcc-14
x86_64      buildonly-randconfig-1001-20261114    gcc-14
x86_64      buildonly-randconfig-1002-20261114    gcc-14
x86_64      buildonly-randconfig-1003-20261114    gcc-14
x86_64      buildonly-randconfig-1004-20261114    gcc-14
x86_64      buildonly-randconfig-1005-20261114    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261114    gcc-14
x86_64                randconfig-1000-20261115    gcc-14
x86_64                randconfig-1001-20261114    gcc-14
x86_64                randconfig-1001-20261115    gcc-14
x86_64                randconfig-1002-20261114    gcc-14
x86_64                randconfig-1002-20261115    gcc-14
x86_64                randconfig-1003-20261114    gcc-14
x86_64                randconfig-1003-20261115    gcc-14
x86_64                randconfig-1004-20261114    gcc-14
x86_64                randconfig-1004-20261115    gcc-14
x86_64                randconfig-1005-20261114    gcc-14
x86_64                randconfig-1005-20261115    gcc-14
x86_64                randconfig-1006-20261114    gcc-14
x86_64                randconfig-1007-20261114    gcc-14
x86_64                randconfig-1008-20261114    gcc-14
x86_64                randconfig-1009-20261114    gcc-14
x86_64                randconfig-1010-20261114    gcc-14
x86_64                randconfig-1011-20261114    gcc-14
x86_64                randconfig-1012-20261114    clang-22
x86_64                randconfig-1012-20261115    gcc-14
x86_64                randconfig-1013-20261114    clang-22
x86_64                randconfig-1013-20261115    gcc-14
x86_64                randconfig-1014-20261114    clang-22
x86_64                randconfig-1014-20261115    gcc-14
x86_64                randconfig-1015-20261114    clang-22
x86_64                randconfig-1015-20261115    gcc-14
x86_64                randconfig-1016-20261114    clang-22
x86_64                randconfig-1016-20261115    gcc-14
x86_64                randconfig-1017-20261114    clang-22
x86_64                randconfig-1017-20261115    gcc-14
x86_64                randconfig-2000-20261113    gcc-14
x86_64                randconfig-2000-20261114    gcc-14
x86_64                randconfig-2001-20261113    gcc-14
x86_64                randconfig-2001-20261114    gcc-14
x86_64                randconfig-2002-20261113    gcc-14
x86_64                randconfig-2002-20261114    gcc-14
x86_64                randconfig-2003-20261113    gcc-14
x86_64                randconfig-2003-20261114    gcc-14
x86_64                randconfig-2004-20261113    gcc-14
x86_64                randconfig-2004-20261114    gcc-14
x86_64                randconfig-2005-20261113    gcc-14
x86_64                randconfig-2005-20261114    gcc-14
x86_64                randconfig-2100-20261113    clang-22   cocci
x86_64                randconfig-2100-20261114    gcc-14     cocci
x86_64                randconfig-2101-20261113    clang-22   cocci
x86_64                randconfig-2101-20261114    gcc-14     cocci
x86_64                randconfig-2102-20261113    clang-22   cocci
x86_64                randconfig-2102-20261114    gcc-14     cocci
x86_64                randconfig-2103-20261113    clang-22   cocci
x86_64                randconfig-2103-20261114    gcc-14     cocci
x86_64                randconfig-2104-20261113    clang-22   cocci
x86_64                randconfig-2104-20261114    gcc-14     cocci
x86_64                randconfig-2105-20261113    clang-22   cocci
x86_64                randconfig-2105-20261114    gcc-14     cocci
x86_64                randconfig-2200-20261113    clang-22   smatch
x86_64                randconfig-2200-20261114    gcc-14     smatch
x86_64                randconfig-2300-20261113    gcc-14     sparse
x86_64                randconfig-2300-20261114    clang-22   sparse
x86_64                randconfig-2301-20261113    gcc-14     sparse
x86_64                randconfig-2301-20261114    clang-22   sparse
x86_64                randconfig-2302-20261113    gcc-14     sparse
x86_64                randconfig-2302-20261114    clang-22   sparse
x86_64               randconfig-r2101-20261114    gcc-8.5.0  cocci
x86_64               randconfig-r2103-20261114    gcc-14     cocci
x86_64               randconfig-r2105-20261113    gcc-15.3.0 cocci
x86_64               randconfig-r2105-20261114    clang-17   cocci
x86_64               randconfig-r2105-20261114    gcc-15.3.0 cocci
x86_64               randconfig-r2300-20261114    gcc-8.5.0  sparse
x86_64               randconfig-r2306-20261114    gcc-8.5.0  sparse
x86_64               randconfig-r2307-20261114    clang-22   sparse
x86_64               randconfig-r2308-20261113    clang-24   sparse
x86_64               randconfig-r2308-20261113    gcc-10.5.0 sparse
x86_64               randconfig-r2310-20261114    gcc-8.5.0  sparse
x86_64               randconfig-r2311-20261113    clang-24   sparse
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    clang-22
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261114    gcc-12.5.0
xtensa                randconfig-1001-20261114    gcc-12.5.0
xtensa                randconfig-2000-20261113    gcc-12.5.0
xtensa                randconfig-2000-20261114    gcc-16.2.0
xtensa                randconfig-2001-20261113    gcc-12.5.0
xtensa                randconfig-2001-20261114    gcc-16.2.0
xtensa                randconfig-2200-20261113    gcc-12.5.0 smatch
xtensa               randconfig-r2106-20261114    gcc-8.5.0  cocci
xtensa               randconfig-r2107-20261114    clang-24   cocci
xtensa               randconfig-r2110-20261113    gcc-11.5.0 cocci
xtensa               randconfig-r2301-20261114    gcc-12.5.0 sparse
xtensa               randconfig-r2302-20261113    gcc-14.4.0 sparse
xtensa               randconfig-r2305-20261114    gcc-16.2.0 sparse
xtensa               randconfig-r2307-20261113    gcc-10.5.0 sparse

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
