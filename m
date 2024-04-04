Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1170BCD1284
	for <intel-wired-lan@archiver.kernel.org>; Thu,  4 Apr 2024 16:17:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 934F941C27;
	Thu,  4 Apr 2024 16:17:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b-u-1qEtVj7x; Thu,  4 Apr 2024 16:17:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 871ED40480
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1712247428;
	bh=KRdSrv6V4g0rXwQ2e3FKtSsnsEL+JPDdnxuhgZ6Gjxg=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Krkzp1EL3bSnGaZX+3KQP35VJVr/gCl9+CD2JJ3h5xAtofyqe87rS+6st/hLARYzm
	 r98PZ02H/MwW/khU4sYLyY/OvayZw1n2Fw9tSoSRJO6EghHZ38FzRunTdQYVnxTpgm
	 /36BhcF0GZepQsiKyAs0Wqx/fvgO2r5qyKyAJC+zB8kH0F/EilCFtZarC448li4E4w
	 Qh8MyooRzE9O1/V8plC0elezp/lao9+GC8m2IssGjKSEyrtv2S4H2ZIjafFnsAgaWM
	 bdoKA8ql1YjEAhlP2sFxTvnByN65RRtgSpnREnGnWd8jlFnLTm/tfosZpuLWgYcNed
	 02XtxXurkh4Uw==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 871ED40480;
	Thu,  4 Apr 2024 16:17:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 7F3C81BF366
 for <intel-wired-lan@lists.osuosl.org>; Thu,  4 Apr 2024 16:17:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 68A8D61036
 for <intel-wired-lan@lists.osuosl.org>; Thu,  4 Apr 2024 16:17:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x14dKfCwH3xX for <intel-wired-lan@lists.osuosl.org>;
 Thu,  4 Apr 2024 16:17:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1A78860FFD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1A78860FFD
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1A78860FFD
 for <intel-wired-lan@lists.osuosl.org>; Thu,  4 Apr 2024 16:17:04 +0000 (UTC)
X-CSE-ConnectionGUID: k7pEa2KXTyGTNDlGpd0EIA==
X-CSE-MsgGUID: wlvwM6z1Soed19cIERisuA==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7734414"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7734414"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Apr 2024 09:16:59 -0700
X-CSE-ConnectionGUID: VnhkDOuaSLusct67cGxl5g==
X-CSE-MsgGUID: PoXg9zLQRxCn2GTGEbgZnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; d="scan'208";a="18937368"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
 by fmviesa007.fm.intel.com with ESMTP; 04 Apr 2024 09:16:59 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1rsPlo-0001G0-03
 for intel-wired-lan@lists.osuosl.org; Thu, 04 Apr 2024 16:16:56 +0000
Date: Fri, 05 Apr 2024 00:16:32 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202404050030.jZaVhgXa-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712247425; x=1743783425;
 h=date:from:to:subject:message-id;
 bh=aVOyGiauP67qHd2Fotfp0uwMBGRezvlAHYgSV92CZeg=;
 b=ZFRULESohm1zz2vO89WEIVX2mlAPmFoYl9QphqTTo02ISX6GcNe75MMa
 edFfPNy1V12rpV5f0R3TS0SiKlcL/ulFxhMiGdcs4sNimZw27CmdFq5lo
 OgtCHq5Rd1zKiuVotex9xVFcXxDqWzWCBpH8ddzdPIRqVLiCnipztW5OS
 f5Lv6B1KdUtbiBsfOCxfx3ajieNSys5DWmxuv+Jh54FCP27E/677TC3ux
 Sisk7f9ZVoP6RL4OrA44VTF3Eyt/sYwXC1Zzm3smppxWjDwTt0DHbeC0G
 7ef0JQfEeaJFPKk+e623E6CCZ9LDN09P9pSOtFZBOrfF6eTiPTdUPuqGO
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ZFRULESo
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 36adaac21a9d983bad967d089a7d66ac54f072ba
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
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 36adaac21a9d983bad967d089a7d66ac54f072ba  iavf: Fix TC config comparison with existing adapter TC config

elapsed time: 1109m

configs tested: 179
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240404   gcc  
arc                   randconfig-002-20240404   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                            mmp2_defconfig   gcc  
arm                   randconfig-001-20240404   gcc  
arm                   randconfig-002-20240404   gcc  
arm                   randconfig-003-20240404   clang
arm                   randconfig-004-20240404   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240404   gcc  
arm64                 randconfig-002-20240404   gcc  
arm64                 randconfig-003-20240404   clang
arm64                 randconfig-004-20240404   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240404   gcc  
csky                  randconfig-002-20240404   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240404   clang
hexagon               randconfig-002-20240404   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240404   gcc  
i386         buildonly-randconfig-002-20240404   clang
i386         buildonly-randconfig-003-20240404   clang
i386         buildonly-randconfig-004-20240404   gcc  
i386         buildonly-randconfig-005-20240404   clang
i386         buildonly-randconfig-006-20240404   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240404   gcc  
i386                  randconfig-002-20240404   clang
i386                  randconfig-003-20240404   clang
i386                  randconfig-004-20240404   gcc  
i386                  randconfig-005-20240404   clang
i386                  randconfig-006-20240404   clang
i386                  randconfig-011-20240404   gcc  
i386                  randconfig-012-20240404   clang
i386                  randconfig-013-20240404   gcc  
i386                  randconfig-014-20240404   clang
i386                  randconfig-015-20240404   gcc  
i386                  randconfig-016-20240404   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240404   gcc  
loongarch             randconfig-002-20240404   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1830-neo_defconfig   gcc  
nios2                         3c120_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240404   gcc  
nios2                 randconfig-002-20240404   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240404   gcc  
parisc                randconfig-002-20240404   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     kmeter1_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20240404   gcc  
powerpc               randconfig-002-20240404   gcc  
powerpc               randconfig-003-20240404   clang
powerpc                    socrates_defconfig   gcc  
powerpc64             randconfig-001-20240404   gcc  
powerpc64             randconfig-002-20240404   clang
powerpc64             randconfig-003-20240404   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240404   clang
riscv                 randconfig-002-20240404   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240404   gcc  
s390                  randconfig-002-20240404   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240404   gcc  
sh                    randconfig-002-20240404   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          rsk7264_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240404   gcc  
sparc64               randconfig-002-20240404   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240404   clang
um                    randconfig-002-20240404   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240404   gcc  
x86_64       buildonly-randconfig-002-20240404   gcc  
x86_64       buildonly-randconfig-003-20240404   gcc  
x86_64       buildonly-randconfig-004-20240404   clang
x86_64       buildonly-randconfig-005-20240404   clang
x86_64       buildonly-randconfig-006-20240404   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240404   clang
x86_64                randconfig-002-20240404   gcc  
x86_64                randconfig-003-20240404   clang
x86_64                randconfig-004-20240404   gcc  
x86_64                randconfig-005-20240404   gcc  
x86_64                randconfig-006-20240404   gcc  
x86_64                randconfig-011-20240404   clang
x86_64                randconfig-012-20240404   clang
x86_64                randconfig-013-20240404   clang
x86_64                randconfig-014-20240404   clang
x86_64                randconfig-015-20240404   gcc  
x86_64                randconfig-016-20240404   gcc  
x86_64                randconfig-071-20240404   gcc  
x86_64                randconfig-072-20240404   clang
x86_64                randconfig-073-20240404   clang
x86_64                randconfig-074-20240404   gcc  
x86_64                randconfig-075-20240404   clang
x86_64                randconfig-076-20240404   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                randconfig-001-20240404   gcc  
xtensa                randconfig-002-20240404   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
