Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E1A8CA5FA5
	for <intel-wired-lan@archiver.kernel.org>; Tue, 29 Sep 2026 20:59:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2AEC810E2;
	Tue, 29 Sep 2026 20:59:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CA6ZWd9ZnNmD; Tue, 29 Sep 2026 20:59:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 37364810D9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790715557;
	b=X7VF/M/hLYrLDOCGXymOrwmtOfR9eh6PDEfbwDC5NDdM60H0n2xalFuuNdG36QRZDkgP
	 wE/y19ObL1OZIjekmxXligwQ9GoYoWWbK4oiHv4pPeE81ABXmp17szMI7i8iFHUrVdx/M
	 g1YpZLp+E5HkApsxA6s1NRkSHEi070jT0GnT4pV3/nSIsvTPlIREpWXJndvY++BWb240R
	 JUdrhiUEwkuDbMozBUzo50lXS2C4H/Ggw55DrYqfW5LJllw/BJ6u870j+++C1uFb7FXtn
	 hgHop+HZ8/t/uoqP9XzqfgEuYCzuF56eIb2FcfVuYv26DN6eI1+1rxfpQtuwDskjasg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790715557;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 Received:Received:Date:From:To:Subject:Message-ID:User-Agent:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OJc9Vc1hCTM5PzjdSG+4He7BQpuxxrZrTS8Fg+VKG7o=;
	b=ciO9QnfOODm4uQM/843gy4TvyJB2OiQlNDTNlpfq+3nI/Oyfs470wuMS6urV0CuvAAq3
	 TwxL/g6JKPWmokrb/XKIXbCtxPbdzUxxAC5kkuFottmBChH8lhoxWgktTJlVw+ekz2+7F
	 q0sZ2f7o+WoUdfoXFIBUs5f2wHy9u8lTnPYwfJ6mmhgfpZDpbYtdXqi5/0YM5q+Jmtuvi
	 Hl2ZYEdKFEN+uozvzxMEwuuHByCgS8/qwnysEWyuhiUsV9t5y64r8RivgVYhi58OafrfE
	 RbFS4iQvhq9FSsz14H7NwXqewozxqfx7uDfv0rczx+ul2SFPd5hyiTZ8ZpleBJR+KuA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790715557;
	bh=OJc9Vc1hCTM5PzjdSG+4He7BQpuxxrZrTS8Fg+VKG7o=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zU82tRbqk4RvO8TCsFxvRz/GmWQZ4E4UUY/Oa4cj1MP0t+n3/IcuC4P16ssF28Rzy
	 +UWRDdKPEBYzf4aFiKaOatXTQVhDMrLHMpwGd1n2A2Ymfhw1JDEikZwoPj8uxoqeBk
	 SMjwYIx/tyy0HlOiOz7YzQlkBWS17sgFSb+GPqnXTb402q9voS51UFJl4V0ySPqt/g
	 dUrfqbd/w2JmblTpvkLiDrWyYzPGldd+uJe7SXimzkufHukFz/4GJ5Mj1pfaL2QvnR
	 wtfS3sZIv01o/wMpYlA0n/xFnVOqedcPeQEzhOvIRcW7IKGPU4OFExixt+k8FruOhF
	 MP5GTw09Bsczw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 37364810D9;
	Tue, 29 Sep 2026 20:59:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E9F53282
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 20:59:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CF7D840715
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 20:59:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gVpYYG58OX7i for <intel-wired-lan@lists.osuosl.org>;
 Tue, 29 Sep 2026 20:59:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 249534063A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790715554;
 b=hK7ylzNGZNP9UrvKfR07BAYzwrcJGwSnsAGcJO9q3Vtt96WE/ZCUoFlvRHBhJ3peNKGX
 Y2CLSPXXt1pJLet0Hf/vqb4fAT7ubDBQagrKIQzPwfT8AV4emXo2F6dZvQtafhuyA+bjx
 WUcKTZdwpud3vUXT78bE02/g5BYBozTt1SZ4C1ignOo2hCDJYJ0WtcNUVlb3ORWc2zVGl
 6of5gChwbByHYlCGaa1DhscHAGgJsE3drdXUa+T6IppCUosu+2hbYGydZDbavSngstEkb
 v00UhluLhg94J5WYyyeK7JePDdwckKk18L+ZJcQdDvAL1rREvf9CV+2Xw69PFy4nFyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790715554;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:Received:Received:Date:From:To:Subject:
 Message-ID:User-Agent;
 bh=OJc9Vc1hCTM5PzjdSG+4He7BQpuxxrZrTS8Fg+VKG7o=;
 b=mj1METOFkKSddKVE6ZeOtiBKb/EMkGX/T5oabR89jaBa9icQasO1H2MGEhGkIsr2t2IP
 jAXuOEF6+pcCgyBCOn6pFBQeXyrPUWy+U9A3yuAMkqoNu349QGEMTt2hvWaYKDxxJNE9k
 VoCkwp9tmBsKWBluAeqPzBm5vFVTzyh1QejFKYgpdjYqRCepUloTZpU90enUp+iNx/Zr0
 g23wgcwG9mGw7seM+9SfNaeUXHE/0VqloWm+XAgEoGmiUyK/CJ8p4RdDRPFmihMdsSg+W
 t5DfZx6vuvBuHI218eUFOOpfp8pgxvppEHzIikdxzdvQBrso5Y7oiIq8Fsop5fcpQZA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=GfjY036f; 
 arc=none smtp.remote-ip=198.175.65.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=GfjY036f
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 249534063A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 20:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790715554; x=1822251554; h=date:from:to:subject:message-id;
 bh=soBl7297AB4RiQ25ZJW6UbFTu6WGd3pilV2lM7rte1Y=;
 b=GfjY036fllyyFz5WP55pOIJvYHe55IMRZj7QsP8J81a8imfXuu0IM7bV
 /Xa3IvUXxKqv3knUyko8fy8ou5dpCMRyE5p+Y3g9Pz0Q/UcBj9ZmLxpR6
 bcxpSdYJ7nMcnHGKHIu2k+ml23i3ghRHnOChFwekIDV40yrKbsyb+uvvs
 vBXPCqI1iWzNKQF688zgYLym798Iwgu3QBF5gk4J/0B0tVRGGfZA4pg1A
 zcgTe5nzvtBOnE8pzi/fJZxvzJZ87Qz13pACydhffsegTxZuopIPzo2+P
 MpkWD11EweiACgq8ZBZ7J89zcgIRSNeGD4T1No2qx1Idjzm9tjvHSj1qL w==;
X-CSE-ConnectionGUID: VsaIAf82SIOLH50GgJdRxw==
X-CSE-MsgGUID: 8xTZ5+RTSvKI6P4Xhxl1/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90489511"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="90489511"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 13:59:13 -0700
X-CSE-ConnectionGUID: VGF+nPrASFSQLqu9z2icog==
X-CSE-MsgGUID: pCHr/V53RR+L+DysRwA0JA==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by fmviesa003.fm.intel.com with ESMTP; 29 Sep 2026 13:59:11 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xBeur-00000000Plo-1Ggx;
 Tue, 29 Sep 2026 20:59:09 +0000
Date: Wed, 30 Sep 2026 04:59:03 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:dev-queue] BUILD SUCCESS
 b5fa591df2d45bc267d23ef423adeb67cdf0f509
Message-ID: <202609300400.OoK3Px1N-lkp@intel.com>
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
branch HEAD: b5fa591df2d45bc267d23ef423adeb67cdf0f509  ice: describe generic DPLL pins from firmware pin classification

elapsed time: 1129m

configs tested: 273
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2101-20260929    gcc-12.5.0 cocci
alpha                randconfig-r2307-20260929    gcc-14.3.0 sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                         nsim_700_defconfig    gcc-16.1.0
arc                   randconfig-1000-20260929    clang-17
arc                   randconfig-1000-20260930    gcc-11.5.0
arc                   randconfig-1001-20260929    clang-17
arc                   randconfig-1001-20260930    gcc-11.5.0
arc                     vdk_hs38_smp_defconfig    gcc-16.1.0
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                          at91_dt_defconfig    gcc-16.1.0
arm                         clps711x_defconfig    gcc-16.1.0
arm                                  defconfig    gcc-16.1.0
arm                       footbridge_defconfig    gcc-16.1.0
arm                          lpc32xx_defconfig    clang-17
arm                              mxs_defconfig    gcc-16.1.0
arm                          orion5x_defconfig    gcc-16.1.0
arm                   randconfig-1000-20260929    clang-17
arm                   randconfig-1000-20260930    gcc-11.5.0
arm                   randconfig-1001-20260929    clang-17
arm                   randconfig-1001-20260930    gcc-11.5.0
arm                   randconfig-1002-20260929    clang-17
arm                   randconfig-1002-20260930    gcc-11.5.0
arm                   randconfig-1003-20260929    clang-17
arm                   randconfig-1003-20260930    gcc-11.5.0
arm                         spear6xx_defconfig    clang-17
arm                         spear6xx_defconfig    gcc-16.1.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260929    clang-24
arm64                 randconfig-1001-20260929    clang-24
arm64                 randconfig-1002-20260929    clang-24
arm64                 randconfig-1003-20260929    clang-24
arm64                randconfig-r2102-20260929    clang-24   cocci
arm64                randconfig-r2105-20260929    clang-17   cocci
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260929    clang-24
csky                  randconfig-1001-20260929    clang-24
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260929    gcc-8.5.0
hexagon               randconfig-1001-20260929    gcc-8.5.0
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20260929    clang-22
i386        buildonly-randconfig-1000-20260930    gcc-14
i386        buildonly-randconfig-1001-20260929    clang-22
i386        buildonly-randconfig-1001-20260930    gcc-14
i386        buildonly-randconfig-1002-20260929    clang-22
i386        buildonly-randconfig-1002-20260930    gcc-14
i386        buildonly-randconfig-1003-20260929    clang-22
i386        buildonly-randconfig-1003-20260930    gcc-14
i386        buildonly-randconfig-1004-20260929    clang-22
i386        buildonly-randconfig-1004-20260930    gcc-14
i386        buildonly-randconfig-1005-20260929    clang-22
i386        buildonly-randconfig-1005-20260930    gcc-14
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20260929    gcc-13
i386                  randconfig-1001-20260929    gcc-13
i386                  randconfig-1002-20260929    gcc-13
i386                  randconfig-1003-20260929    gcc-13
i386                  randconfig-1004-20260929    gcc-13
i386                  randconfig-1005-20260929    gcc-13
i386                  randconfig-1006-20260929    gcc-13
i386                  randconfig-1007-20260929    gcc-14
i386                  randconfig-1007-20260930    clang-22
i386                  randconfig-1008-20260929    gcc-14
i386                  randconfig-1008-20260930    clang-22
i386                  randconfig-1009-20260929    gcc-14
i386                  randconfig-1009-20260930    clang-22
i386                  randconfig-1010-20260929    gcc-14
i386                  randconfig-1010-20260930    clang-22
i386                  randconfig-1011-20260929    gcc-14
i386                  randconfig-1011-20260930    clang-22
i386                  randconfig-1012-20260929    gcc-14
i386                  randconfig-1012-20260930    clang-22
i386                  randconfig-1013-20260929    gcc-14
i386                  randconfig-1013-20260930    clang-22
i386                  randconfig-2100-20260929    gcc-13     cocci
i386                  randconfig-2101-20260929    clang-22   cocci
i386                  randconfig-2102-20260929    clang-22   cocci
i386                  randconfig-2103-20260929    clang-22   cocci
i386                  randconfig-2200-20260929    gcc-14     smatch
i386                  randconfig-2300-20260929    clang-22   sparse
i386                  randconfig-2301-20260929    gcc-14     sparse
i386                 randconfig-r2200-20260929    gcc-14     smatch
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch                 loongson64_defconfig    clang-17
loongarch             randconfig-1000-20260929    gcc-8.5.0
loongarch             randconfig-1001-20260929    gcc-8.5.0
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                        bvme6000_defconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                           hp300_defconfig    clang-17
m68k                             q40_defconfig    clang-17
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2201-20260929    gcc-13.4.0 smatch
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                             gpr_defconfig    gcc-16.1.0
mips                            ip30_defconfig    gcc-16.1.0
mips                 randconfig-r2107-20260929    gcc-11.5.0 cocci
mips                 randconfig-r2202-20260929    gcc-12.5.0 smatch
mips                 randconfig-r2309-20260929    gcc-13.4.0 sparse
nios2                          10m50_defconfig    gcc-16.1.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20260929    gcc-8.5.0
nios2                 randconfig-1001-20260929    gcc-8.5.0
openrisc                          alldefconfig    gcc-16.1.0
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260929    gcc-8.5.0
parisc                randconfig-1000-20260930    gcc-8.5.0
parisc                randconfig-1001-20260929    gcc-8.5.0
parisc                randconfig-1001-20260930    gcc-8.5.0
parisc               randconfig-r2306-20260929    gcc-8.5.0  sparse
parisc64                             defconfig    clang-24
powerpc                      akebono_defconfig    gcc-16.1.0
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                       chrp32_defconfig    gcc-16.1.0
powerpc                     gamecube_defconfig    gcc-16.1.0
powerpc                         icon_defconfig    gcc-16.1.0
powerpc                      ksi8560_defconfig    gcc-16.1.0
powerpc                    motionpro_defconfig    gcc-16.1.0
powerpc                  mpc837x_rdb_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20260929    gcc-8.5.0
powerpc               randconfig-1000-20260930    gcc-8.5.0
powerpc               randconfig-1001-20260929    gcc-8.5.0
powerpc               randconfig-1001-20260930    gcc-8.5.0
powerpc                      redwood_defconfig    clang-17
powerpc                     socrates_defconfig    gcc-16.1.0
powerpc64             randconfig-1000-20260929    gcc-8.5.0
powerpc64             randconfig-1000-20260930    gcc-8.5.0
powerpc64             randconfig-1001-20260929    gcc-8.5.0
powerpc64             randconfig-1001-20260930    gcc-8.5.0
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20260929    clang-24
riscv                 randconfig-1001-20260929    clang-24
riscv                 randconfig-2000-20260929    gcc-11.5.0
riscv                 randconfig-2001-20260929    gcc-9.5.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20260929    clang-24
s390                  randconfig-1001-20260929    clang-24
s390                  randconfig-2000-20260929    clang-24
s390                  randconfig-2001-20260929    gcc-8.5.0
s390                 randconfig-r2104-20260929    clang-24   cocci
s390                 randconfig-r2308-20260929    clang-24   sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                         dreamcast_defconfig    clang-17
sh                              espt_defconfig    gcc-16.1.0
sh                           kfr2r09_defconfig    gcc-16.1.0
sh                    randconfig-1000-20260929    clang-24
sh                    randconfig-1001-20260929    clang-24
sh                    randconfig-2000-20260929    gcc-14.3.0
sh                    randconfig-2001-20260929    gcc-16.1.0
sh                   randconfig-r2100-20260929    gcc-10.5.0 cocci
sh                            se7705_defconfig    gcc-16.1.0
sh                            se7721_defconfig    gcc-16.1.0
sh                            se7722_defconfig    gcc-16.1.0
sh                    secureedge5410_defconfig    gcc-16.1.0
sh                            sh2007_defconfig    gcc-16.1.0
sh                         sh7757lcr_defconfig    gcc-16.1.0
sh                              shx3_defconfig    gcc-16.1.0
sh                             titan_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260929    gcc-14
sparc                 randconfig-1001-20260929    gcc-14
sparc                 randconfig-2000-20260929    gcc-14.3.0
sparc                 randconfig-2001-20260929    gcc-12.5.0
sparc                randconfig-r2103-20260929    gcc-8.5.0  cocci
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260929    gcc-14
sparc64               randconfig-1001-20260929    gcc-14
sparc64               randconfig-2000-20260929    gcc-8.5.0
sparc64               randconfig-2001-20260929    clang-24
sparc64              randconfig-r2106-20260929    clang-24   cocci
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260929    gcc-14
um                    randconfig-1001-20260929    gcc-14
um                    randconfig-2000-20260929    clang-17
um                    randconfig-2001-20260929    gcc-14
um                            x86_64_defconfig    clang-17
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-24
x86_64      buildonly-randconfig-1000-20260929    clang-22
x86_64      buildonly-randconfig-1001-20260929    clang-22
x86_64      buildonly-randconfig-1002-20260929    clang-22
x86_64      buildonly-randconfig-1003-20260929    clang-22
x86_64      buildonly-randconfig-1004-20260929    clang-22
x86_64      buildonly-randconfig-1005-20260929    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20260929    clang-22
x86_64                randconfig-1001-20260929    clang-22
x86_64                randconfig-1002-20260929    clang-22
x86_64                randconfig-1003-20260929    clang-22
x86_64                randconfig-1004-20260929    clang-22
x86_64                randconfig-1005-20260929    clang-22
x86_64                randconfig-1006-20260929    gcc-13
x86_64                randconfig-1007-20260929    gcc-13
x86_64                randconfig-1008-20260929    gcc-13
x86_64                randconfig-1009-20260929    gcc-13
x86_64                randconfig-1010-20260929    gcc-13
x86_64                randconfig-1011-20260929    gcc-13
x86_64                randconfig-1012-20260929    clang-22
x86_64                randconfig-1013-20260929    clang-22
x86_64                randconfig-1014-20260929    clang-22
x86_64                randconfig-1015-20260929    clang-22
x86_64                randconfig-1016-20260929    clang-22
x86_64                randconfig-1017-20260929    clang-22
x86_64                randconfig-2100-20260929    clang-22   cocci
x86_64                randconfig-2101-20260929    gcc-14     cocci
x86_64                randconfig-2102-20260929    gcc-14     cocci
x86_64                randconfig-2103-20260929    clang-22   cocci
x86_64                randconfig-2200-20260929    clang-22   smatch
x86_64                randconfig-2300-20260929    clang-22   sparse
x86_64                randconfig-2301-20260929    clang-22   sparse
x86_64                randconfig-2302-20260929    clang-22   sparse
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20260929    gcc-14
xtensa                randconfig-1001-20260929    gcc-14
xtensa                randconfig-2000-20260929    gcc-16.1.0
xtensa                randconfig-2001-20260929    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
