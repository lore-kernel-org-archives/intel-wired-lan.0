Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D62C3DA6E
	for <intel-wired-lan@archiver.kernel.org>; Thu, 28 Dec 2023 17:33:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 563CB40533;
	Thu, 28 Dec 2023 17:33:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 563CB40533
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1703784804;
	bh=eBJcD86ewr0KYqg5zXP9Q41nCVAB9NCqhf8RzxYbGrg=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=8GP0IiSib18B3ZBhXIiQmRP/YMJObkFt8UTEaXDXMYCBRxjQDACiHtQE7iVzbWPqa
	 Sy2XLNaEt7feysT8Hj2vCGGbf65+PxbhLtg8lfzigbZm0kBUEuA2r0CkzVTHovlArm
	 FDISHkgxJetXU+IcyXOj5ordbzBvEg1p5PvwqDmcZEw1uDw/dxfh6Akn351GaYoGi4
	 zWlO3xg+TGMsmyZWOqmVwTnvmcoe3+qTgHmN3b79ZHo/jMUEGnffhY+6LxELM4vPzB
	 +TxoibP72thg8KjRuTqG4NI+cGs1BtuMFrxx35ihHr7/AmefbBk7B2dYQlWGraIU7K
	 Zw3HTmaLRC0eA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XLIpqqBYUFAw; Thu, 28 Dec 2023 17:33:23 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id C01E4405D2;
	Thu, 28 Dec 2023 17:33:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C01E4405D2
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id CA5A81BF31A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 28 Dec 2023 17:33:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A1F1160F02
 for <intel-wired-lan@lists.osuosl.org>; Thu, 28 Dec 2023 17:33:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A1F1160F02
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MtTgdLCUpmuS for <intel-wired-lan@lists.osuosl.org>;
 Thu, 28 Dec 2023 17:33:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5B76660BC9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 28 Dec 2023 17:33:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5B76660BC9
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="460892196"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; d="scan'208";a="460892196"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Dec 2023 09:33:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; d="scan'208";a="20624428"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
 by fmviesa001.fm.intel.com with ESMTP; 28 Dec 2023 09:33:03 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1rIuFf-000GgQ-1F
 for intel-wired-lan@lists.osuosl.org; Thu, 28 Dec 2023 17:32:59 +0000
Date: Fri, 29 Dec 2023 01:31:28 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202312290125.EO5tfJcr-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703784800; x=1735320800;
 h=date:from:to:subject:message-id;
 bh=8yyOq/DBogVGM9Jb2/P7rs0AN9+HriaQo0GaFLjVy7Y=;
 b=RzSo2G7t6F10l7Tp3luwJut8fGd+tnrpP/AtCRTwqX/TN4ivDxlCd+2Z
 Jp6XbQTaaljAFuZ0aaAVlAJoJXx4IwSWXq7RjRIQvdtLeY52EowZDd08D
 v+jT9k/GJnNJqoVzcBNq3+Z4of/VztP6CC3KpRF2hQKWm0Z7SzKspCacs
 lpmMW4eDKCcfMAavP+s5b64sFiffGiWZ2wATG3JDwGt1cE2jh/My/AQ5b
 c0L4OGOxz/dqqwaD1q0l7W7nhe5ao/cUz7r8TlbbyzSbZX3ZZUVymnBd7
 xOR72dZqbIE+UeYTTvFUAZAS9BEwwqkVUZ8DhUszozhR+0VA3InApfQYR
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=RzSo2G7t
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 6008cff94c0fd287f94e6d9f83616aaa5368029b
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 6008cff94c0fd287f94e6d9f83616aaa5368029b  ice: fix Get link status data length

elapsed time: 1448m

configs tested: 170
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231228   gcc  
arc                   randconfig-002-20231228   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                                 defconfig   clang
arm                       imx_v6_v7_defconfig   gcc  
arm                        mvebu_v7_defconfig   gcc  
arm                   randconfig-001-20231228   gcc  
arm                   randconfig-002-20231228   gcc  
arm                   randconfig-003-20231228   gcc  
arm                   randconfig-004-20231228   gcc  
arm                           sama5_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231228   gcc  
arm64                 randconfig-002-20231228   gcc  
arm64                 randconfig-003-20231228   gcc  
arm64                 randconfig-004-20231228   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231228   gcc  
csky                  randconfig-002-20231228   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231228   clang
hexagon               randconfig-002-20231228   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                                defconfig   gcc  
i386                  randconfig-011-20231228   clang
i386                  randconfig-012-20231228   clang
i386                  randconfig-013-20231228   clang
i386                  randconfig-014-20231228   clang
i386                  randconfig-015-20231228   clang
i386                  randconfig-016-20231228   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231228   gcc  
loongarch             randconfig-002-20231228   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                           ip27_defconfig   gcc  
mips                   sb1250_swarm_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231228   gcc  
nios2                 randconfig-002-20231228   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231228   gcc  
parisc                randconfig-002-20231228   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      ppc6xx_defconfig   gcc  
powerpc               randconfig-001-20231228   gcc  
powerpc               randconfig-002-20231228   gcc  
powerpc               randconfig-003-20231228   gcc  
powerpc                     sequoia_defconfig   gcc  
powerpc                     taishan_defconfig   gcc  
powerpc64             randconfig-001-20231228   gcc  
powerpc64             randconfig-002-20231228   gcc  
powerpc64             randconfig-003-20231228   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231228   gcc  
riscv                 randconfig-002-20231228   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231228   clang
s390                  randconfig-002-20231228   clang
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                    randconfig-001-20231228   gcc  
sh                    randconfig-002-20231228   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231228   gcc  
sparc64               randconfig-002-20231228   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231228   gcc  
um                    randconfig-002-20231228   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231228   gcc  
x86_64       buildonly-randconfig-002-20231228   gcc  
x86_64       buildonly-randconfig-003-20231228   gcc  
x86_64       buildonly-randconfig-004-20231228   gcc  
x86_64       buildonly-randconfig-005-20231228   gcc  
x86_64       buildonly-randconfig-006-20231228   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231228   clang
x86_64                randconfig-002-20231228   clang
x86_64                randconfig-003-20231228   clang
x86_64                randconfig-004-20231228   clang
x86_64                randconfig-005-20231228   clang
x86_64                randconfig-006-20231228   clang
x86_64                randconfig-011-20231228   gcc  
x86_64                randconfig-012-20231228   gcc  
x86_64                randconfig-013-20231228   gcc  
x86_64                randconfig-014-20231228   gcc  
x86_64                randconfig-015-20231228   gcc  
x86_64                randconfig-016-20231228   gcc  
x86_64                randconfig-071-20231228   gcc  
x86_64                randconfig-072-20231228   gcc  
x86_64                randconfig-073-20231228   gcc  
x86_64                randconfig-074-20231228   gcc  
x86_64                randconfig-075-20231228   gcc  
x86_64                randconfig-076-20231228   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20231228   gcc  
xtensa                randconfig-002-20231228   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
