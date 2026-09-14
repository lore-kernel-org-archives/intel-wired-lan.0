Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D8EC88E72
	for <intel-wired-lan@archiver.kernel.org>; Mon, 14 Sep 2026 18:09:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69FA780BCD;
	Mon, 14 Sep 2026 18:09:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4BwUuWGyNaId; Mon, 14 Sep 2026 18:09:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3EF8E80BDD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789409376;
	b=rhYbZ/msM8xMI1y2der8y7AdYxnI92Owzh5Q7sWoMg/85VSQ2KrRYxHdNieIqCedJVEi
	 h3C4upRtXa5DpPfOdo9gTbn1ji4pUmG/8ymlpXesmIURYsTGZyT2t0d1vk7mSWawJEx45
	 nZhCiokPV0rEkjWDCL+PzP9R5jglrbsUVasJJuVwMMirFYA3fl7GvTlKAZe0w+58aoLAC
	 8kstFBDqY1GCxDOCxHjmNbbMKZDu0+vuY+qNFQaX0KFHuTCxNhmsvm6BaxTZyxg4wYyit
	 H7yIQU2jGsCTu3KhTDHAYDlxn0PozwRTq09Z5zBw3JeEK9jNaUaReFFXbjHdNnIyy3Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789409376;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 Received:Received:Date:From:To:Subject:Message-ID:User-Agent:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xoCx+ky9XBN2VSP9CstOIahLma6xnHZMrtcywKXv32E=;
	b=RE9euPS10iwuEGeLwUuOEmgRqgVjda40ISU3bFSPimrMEQLXfw78rZCf8WGR4tnVsN/g
	 giNyOECdkmjoQwK/KwwQY+FqD4DkIJBg11Qf/jTbgQUET3M/FY7h89tQaEBRO59Re1Fzp
	 114m2GbIhisfaqwj+DBRm+881Bn406XmYFamNAdy3dUuVqeyUsfJFhMn2X2m/b97VfJr5
	 Itxe9SPWfA4Iehh1yoeQNe8CwciSE+d5zxpgX3gFabnYkB8KfU9bzbXtYVtRo0CKIuWwZ
	 1vGlytSXTnnnWHUDyq8keLun0+tqEFLjxQPvsdU0yedyczdAcyzRBvUu4dylaLTgU+g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789409376;
	bh=xoCx+ky9XBN2VSP9CstOIahLma6xnHZMrtcywKXv32E=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=v+P68U7lK9VE0oZq8t/KXTIfi+dmk+6CdPAlw6asmUGz3jivRHenyuhXQv85IcSme
	 trc9fm5J9jGoRYDXERjWKSlfQULeZt+IOOe0ADygtpGagkL6533MPo6hZC5ZaPtWkD
	 PlQ9kGPzmGmaF7K/lGIWiGAwaA1AsFDZ3vgJBGhDFsmNukmzZ/zH90ED7IwFjaZKs1
	 /tr52mQofnJoZPnlUx/fg7WA1OGlOMKCu74IYgSSngjLAFdqt8AyG6S5EMdMsZKmbV
	 E5dTdgyv9ST8bq/4L/5bNVovdz4eG6gIZjnY/1/i1KJxx4ufQOmnpOv4imQdKnWpbg
	 RSbWLqZnS1b8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3EF8E80BDD;
	Mon, 14 Sep 2026 18:09:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 84761465
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 18:09:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6A36D6061E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 18:09:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Epoupjappc2 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 14 Sep 2026 18:09:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2A561605E7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789409373;
 b=JCtWu8bTgukdpUiG3osz/tTt5vdCZcw1SQvih922ybbELxA+CZsNaFIDE8sJ8pVJ1QRv
 hMTTaY0SQuxmyeK4AbL//SGLwktRqsOFG98BMUflCp2fvRyPaKS479lXHOZXHBzXsFDQj
 laxTewoZWZra6y2S9Ck5CFMlDEJ16PYyXxCG8YMorllsGrLcQnPlEfGEZnZn+M0wA9WEI
 kyL64tpRGfDAoyaNqk23oWKfvuhrehgS1nr4j3L3oZBsMmrySnqgDJc2hzCq6VLpcDFwn
 bibylFWGVmwfgfpmPQTddFUlb8Ihi2HtlbI7SvYoETZSx+gpNNuVu2J6572P3GY/Usg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789409373;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:Received:Received:Date:From:To:Subject:
 Message-ID:User-Agent;
 bh=xoCx+ky9XBN2VSP9CstOIahLma6xnHZMrtcywKXv32E=;
 b=PKcT1OjnqExPQ5O45Fuh0zv23eLIBrF/Q+IjiwDQOgKGuL+jJAsBXn9Jdi/nxhfbGzmT
 spvxVMFCMlR0ZFrW0zPLOGU/rLJ5bK4NpfVShtH9mxBX4YHz4iybaeboSkzFvzOheV7tq
 wpdrew+LVyIk5cDnfi4X1oBFW185/rsDi2R4AytMWVFE94oeDsxyeHNh5xt+TVYUHMy3G
 o67D6RVeJXcDaj6M2HHv2+Ao9nZSWutFxHfo9Wdk05nm6Igcvx6a0dbiXGzKncB6SH3nK
 HQH31KJc8EDsbGAazf8kRoJkXm4lfZ3mjCONZn0k9ZvhQoISK5iY/FJTtzGPFGnqsSA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=QNWjburi; 
 arc=none smtp.remote-ip=198.175.65.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=QNWjburi
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2A561605E7
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 18:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789409374; x=1820945374; h=date:from:to:subject:message-id;
 bh=TUTIyksH0i2uw5/UZaLwEEdLeCHH6SzrCG3Td7XIJ3Y=;
 b=QNWjburiCJcDektpS1yma7d29ha2Rj0QBce5BLU8UsIJn1xIzCsIvW90
 oEB6eYNH6a+ltic9hrSneh60VIhOHOc0PAQ1UvOIToXS0iWpJ9AVbDRT/
 6iEVjZX4aPImQskwUGE5UhXLl4mBjOqW2U93lMluyM0RM8jZkRMkH437x
 Nm7529GWowtxyzRtPPMwGsK9oIcVd264ayzKBrbZUClXLc8Qs3nh6mAvX
 55D/fBOMi4tYgLs7cJxSHhyvJMDLz+QRUyIMhoIN9TqWqFM/ICy3gTjqt
 T3ixB1ubnWib3KBwt2YdyXxr9WtDl4AQ5dR9OIkva/xsfc4DG9V/wm8vJ Q==;
X-CSE-ConnectionGUID: HwQawjIqRXOBpHhTeVrj3A==
X-CSE-MsgGUID: 2omfyaF9T++oVZEnu2Tokw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101284879"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="101284879"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 11:09:30 -0700
X-CSE-ConnectionGUID: eRMeNUuWR/qYFFNtBdlhTg==
X-CSE-MsgGUID: 9TYdPVXiScqmEw1abco33Q==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by fmviesa003.fm.intel.com with ESMTP; 14 Sep 2026 11:09:26 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x6B7M-000000003IQ-2W9Y;
 Mon, 14 Sep 2026 18:09:24 +0000
Date: Tue, 15 Sep 2026 02:09:21 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:dev-queue] BUILD SUCCESS
 ccaf79d94f2116e6566e1aa25376ae9d22080dea
Message-ID: <202609150218.zfK3vHo4-lkp@intel.com>
User-Agent: s-nail v14.9.25
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: ccaf79d94f2116e6566e1aa25376ae9d22080dea  ice: drop pf == NULL check in ice_pf_state_is_nominal()

elapsed time: 2630m

configs tested: 298
configs skipped: 22

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
alpha                randconfig-r121-20260914    gcc-12.5.0 sparse
alpha                randconfig-r123-20260914    gcc-8.5.0 sparse
alpha                randconfig-r132-20260914    gcc-12.5.0 sparse
arc                              alldefconfig    gcc-16.1.0
arc                              allmodconfig    clang-24
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-24
arc                          axs103_defconfig    clang-17
arc                                 defconfig    gcc-16.1.0
arc                         haps_hs_defconfig    clang-24
arc                     haps_hs_smp_defconfig    gcc-16.1.0
arc                        nsim_700_defconfig    clang-17
arc                     nsimosci_hs_defconfig    gcc-16.1.0
arc                   randconfig-001-20260914    gcc-13.4.0
arc                   randconfig-002-20260914    gcc-13.4.0
arc                  randconfig-r113-20260914    gcc-8.5.0 sparse
arc                  randconfig-r121-20260914    gcc-8.5.0 sparse
arc                  randconfig-r123-20260914    clang-17 sparse
arc                  randconfig-r132-20260914    gcc-8.5.0 sparse
arc                           tb10x_defconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-24
arm                                 defconfig    gcc-16.1.0
arm                          exynos_defconfig    gcc-16.1.0
arm                      footbridge_defconfig    gcc-16.1.0
arm                          gemini_defconfig    gcc-16.1.0
arm                            hisi_defconfig    gcc-16.1.0
arm                         lpc18xx_defconfig    clang-24
arm                         lpc18xx_defconfig    gcc-16.1.0
arm                        mvebu_v7_defconfig    clang-17
arm                       omap2plus_defconfig    clang-17
arm                             pxa_defconfig    gcc-16.1.0
arm                   randconfig-001-20260914    gcc-13.4.0
arm                   randconfig-002-20260914    gcc-13.4.0
arm                   randconfig-003-20260914    gcc-13.4.0
arm                   randconfig-004-20260914    gcc-13.4.0
arm                  randconfig-r112-20260914    gcc-8.5.0 sparse
arm                  randconfig-r113-20260914    gcc-11.5.0 sparse
arm                  randconfig-r122-20260914    clang-17 sparse
arm                  randconfig-r133-20260914    gcc-8.5.0 sparse
arm                  randconfig-r134-20260914    clang-22 sparse
arm                  randconfig-r134-20260914    gcc-8.5.0 sparse
arm                         socfpga_defconfig    gcc-16.1.0
arm                    vt8500_v6_v7_defconfig    gcc-14
arm64                            allmodconfig    clang-24
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260914    gcc-9.5.0
arm64                 randconfig-002-20260914    gcc-9.5.0
arm64                 randconfig-003-20260914    gcc-9.5.0
arm64                 randconfig-004-20260914    gcc-9.5.0
arm64                randconfig-r112-20260914    gcc-8.5.0 sparse
arm64                randconfig-r121-20260914    gcc-11.5.0 sparse
arm64                randconfig-r122-20260914    gcc-8.5.0 sparse
arm64                randconfig-r131-20260914    gcc-16.1.0 sparse
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260914    gcc-9.5.0
csky                  randconfig-002-20260914    gcc-9.5.0
csky                 randconfig-r111-20260914    gcc-8.5.0 sparse
csky                 randconfig-r122-20260914    gcc-12.5.0 sparse
csky                 randconfig-r123-20260914    gcc-8.5.0 sparse
csky                 randconfig-r131-20260914    gcc-13.4.0 sparse
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260914    gcc-13.4.0
hexagon               randconfig-002-20260914    gcc-13.4.0
hexagon              randconfig-r133-20260914    gcc-12.5.0 sparse
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386        buildonly-randconfig-001-20260914    gcc-14
i386        buildonly-randconfig-002-20260914    gcc-14
i386        buildonly-randconfig-003-20260914    gcc-14
i386        buildonly-randconfig-004-20260914    gcc-14
i386        buildonly-randconfig-005-20260914    gcc-14
i386        buildonly-randconfig-006-20260914    gcc-14
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260914    clang-22
i386                  randconfig-002-20260914    clang-22
i386                  randconfig-003-20260914    clang-22
i386                  randconfig-004-20260914    clang-22
i386                  randconfig-005-20260914    clang-22
i386                  randconfig-006-20260914    clang-22
i386                  randconfig-007-20260914    clang-22
i386                  randconfig-011-20260914    clang-22
i386                  randconfig-012-20260914    clang-22
i386                  randconfig-013-20260914    clang-22
i386                  randconfig-014-20260914    clang-22
i386                  randconfig-015-20260914    clang-22
i386                  randconfig-016-20260914    clang-22
i386                  randconfig-017-20260914    clang-22
i386                  randconfig-061-20260914    gcc-14 sparse
i386                  randconfig-062-20260914    gcc-14 sparse
i386                  randconfig-063-20260914    gcc-14 sparse
i386                 randconfig-r111-20260914    clang-17 sparse
i386                 randconfig-r132-20260914    gcc-13.4.0 sparse
i386                 randconfig-r134-20260914    clang-22 sparse
loongarch                        allmodconfig    clang-24
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-24
loongarch             randconfig-001-20260914    gcc-13.4.0
loongarch             randconfig-002-20260914    gcc-13.4.0
loongarch            randconfig-r111-20260914    gcc-11.5.0 sparse
loongarch            randconfig-r113-20260914    clang-17 sparse
loongarch            randconfig-r131-20260914    gcc-12.5.0 sparse
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-24
m68k                         amcore_defconfig    gcc-16.1.0
m68k                          amiga_defconfig    gcc-16.1.0
m68k                                defconfig    clang-24
m68k                       m5235evb_defconfig    clang-17
m68k                        m5407c3_defconfig    clang-17
m68k                        mvme16x_defconfig    gcc-14
m68k                 randconfig-r111-20260914    gcc-12.5.0 sparse
m68k                 randconfig-r113-20260914    gcc-12.5.0 sparse
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-24
microblaze           randconfig-r123-20260914    gcc-12.5.0 sparse
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                        bcm47xx_defconfig    clang-24
mips                         bigsur_defconfig    clang-17
mips                       bmips_be_defconfig    gcc-16.1.0
mips                      bmips_stb_defconfig    clang-17
mips                         db1xxx_defconfig    gcc-16.1.0
mips                           ip32_defconfig    gcc-14
mips                 randconfig-r132-20260914    gcc-16.1.0 sparse
mips                 randconfig-r133-20260914    clang-22 sparse
mips                 randconfig-r134-20260914    gcc-13.4.0 sparse
mips                         rt305x_defconfig    clang-17
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-24
nios2                             allnoconfig    gcc-16.1.0
nios2                               defconfig    clang-24
nios2                 randconfig-001-20260914    gcc-13.4.0
nios2                 randconfig-002-20260914    gcc-13.4.0
nios2                randconfig-r131-20260914    gcc-8.5.0 sparse
nios2                randconfig-r133-20260914    clang-22 sparse
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-24
openrisc                          allnoconfig    gcc-16.1.0
openrisc                   de0_nano_defconfig    clang-24
openrisc                   de0_nano_defconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
openrisc             randconfig-r112-20260914    gcc-12.5.0 sparse
openrisc             randconfig-r121-20260914    clang-17 sparse
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-24
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                generic-64bit_defconfig    gcc-16.1.0
parisc                randconfig-001-20260914    gcc-8.5.0
parisc                randconfig-001-20260915    gcc-8.5.0
parisc                randconfig-002-20260914    gcc-8.5.0
parisc                randconfig-002-20260915    gcc-8.5.0
parisc               randconfig-r133-20260914    gcc-13.4.0 sparse
parisc64                            defconfig    clang-24
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-24
powerpc                           allnoconfig    gcc-16.1.0
powerpc                    ge_imp3a_defconfig    gcc-14
powerpc                 linkstation_defconfig    gcc-16.1.0
powerpc                   motionpro_defconfig    clang-17
powerpc                 mpc836x_rdk_defconfig    clang-24
powerpc                     mpc83xx_defconfig    gcc-16.1.0
powerpc                  mpc866_ads_defconfig    clang-17
powerpc                  mpc866_ads_defconfig    clang-24
powerpc                      pasemi_defconfig    clang-24
powerpc                         ps3_defconfig    clang-17
powerpc               randconfig-001-20260914    gcc-8.5.0
powerpc               randconfig-001-20260915    gcc-8.5.0
powerpc               randconfig-002-20260914    gcc-8.5.0
powerpc               randconfig-002-20260915    gcc-8.5.0
powerpc              randconfig-r122-20260914    gcc-8.5.0 sparse
powerpc              randconfig-r134-20260914    gcc-16.1.0 sparse
powerpc                    socrates_defconfig    clang-24
powerpc                 xes_mpc85xx_defconfig    gcc-16.1.0
powerpc64             randconfig-001-20260914    gcc-8.5.0
powerpc64             randconfig-001-20260915    gcc-8.5.0
powerpc64             randconfig-002-20260914    gcc-8.5.0
powerpc64             randconfig-002-20260915    gcc-8.5.0
powerpc64            randconfig-r133-20260914    gcc-8.5.0 sparse
riscv                            allmodconfig    clang-24
riscv                             allnoconfig    clang-24
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-24
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260914    gcc-13.4.0
riscv                 randconfig-002-20260914    gcc-13.4.0
riscv                randconfig-r113-20260914    gcc-8.5.0 sparse
riscv                randconfig-r132-20260914    gcc-8.5.0 sparse
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-24
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260914    gcc-13.4.0
s390                  randconfig-002-20260914    gcc-13.4.0
s390                 randconfig-r122-20260914    gcc-11.5.0 sparse
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-24
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                                  defconfig    gcc-14
sh                               j2_defconfig    gcc-16.1.0
sh                          kfr2r09_defconfig    clang-17
sh                          r7780mp_defconfig    clang-24
sh                    randconfig-001-20260914    gcc-13.4.0
sh                    randconfig-002-20260914    gcc-13.4.0
sh                          rsk7269_defconfig    gcc-16.1.0
sh                      rts7751r2d1_defconfig    gcc-16.1.0
sh                           se7705_defconfig    gcc-14
sparc                             allnoconfig    clang-24
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260914    gcc-16.1.0
sparc                 randconfig-002-20260914    gcc-16.1.0
sparc                randconfig-r112-20260914    clang-17 sparse
sparc                randconfig-r123-20260914    gcc-11.5.0 sparse
sparc                randconfig-r131-20260914    clang-22 sparse
sparc64                          alldefconfig    clang-17
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260914    gcc-16.1.0
sparc64               randconfig-002-20260914    gcc-16.1.0
sparc64              randconfig-r112-20260914    gcc-11.5.0 sparse
sparc64              randconfig-r121-20260914    gcc-8.5.0 sparse
sparc64              randconfig-r131-20260914    clang-22 sparse
sparc64              randconfig-r134-20260914    gcc-12.5.0 sparse
sparc64              randconfig-r134-20260914    gcc-8.5.0 sparse
um                               allmodconfig    clang-17
um                                allnoconfig    clang-24
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             i386_defconfig    gcc-16.1.0
um                    randconfig-001-20260914    gcc-16.1.0
um                    randconfig-002-20260914    gcc-16.1.0
um                   randconfig-r111-20260914    gcc-8.5.0 sparse
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-24
x86_64                            allnoconfig    gcc-16.1.0
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260914    gcc-14
x86_64      buildonly-randconfig-002-20260914    gcc-14
x86_64      buildonly-randconfig-003-20260914    gcc-14
x86_64      buildonly-randconfig-004-20260914    gcc-14
x86_64      buildonly-randconfig-005-20260914    gcc-14
x86_64      buildonly-randconfig-006-20260914    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260914    gcc-14
x86_64                randconfig-002-20260914    gcc-14
x86_64                randconfig-003-20260914    gcc-14
x86_64                randconfig-004-20260914    gcc-14
x86_64                randconfig-005-20260914    gcc-14
x86_64                randconfig-006-20260914    gcc-14
x86_64                randconfig-011-20260914    clang-22
x86_64                randconfig-012-20260914    clang-22
x86_64                randconfig-013-20260914    clang-22
x86_64                randconfig-014-20260914    clang-22
x86_64                randconfig-015-20260914    clang-22
x86_64                randconfig-016-20260914    clang-22
x86_64                randconfig-071-20260914    clang-22
x86_64                randconfig-072-20260914    clang-22
x86_64                randconfig-073-20260914    clang-22
x86_64                randconfig-074-20260914    clang-22
x86_64                randconfig-075-20260914    clang-22
x86_64                randconfig-076-20260914    clang-22
x86_64                randconfig-121-20260914    gcc-14 sparse
x86_64                randconfig-122-20260914    gcc-14 sparse
x86_64                randconfig-123-20260914    gcc-14 sparse
x86_64               randconfig-r132-20260914    clang-22 sparse
x86_64               randconfig-r133-20260914    gcc-16.1.0 sparse
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                           alldefconfig    clang-24
xtensa                            allnoconfig    clang-24
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260914    gcc-16.1.0
xtensa                randconfig-002-20260914    gcc-16.1.0
xtensa                         virt_defconfig    clang-17

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
