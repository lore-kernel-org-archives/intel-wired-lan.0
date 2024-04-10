Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B9ECD11C2
	for <intel-wired-lan@archiver.kernel.org>; Wed, 10 Apr 2024 14:12:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A28EB415A8;
	Wed, 10 Apr 2024 14:12:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qluN6-4aFH-O; Wed, 10 Apr 2024 14:12:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3A36B4059D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1712758334;
	bh=MYI5cOJnBs78+zTSxpvcJndjAsInmew7GakNCZSkWo8=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kph/01uHA6cQnkQoaCwZKX2STcXOOEZh5vCtvz+Q76rDGMCp/VFmSX31PNzd1UGdt
	 3a9TiQGR1H+CF9plIDi3PoWXH1xhu9o5qi7UfKvrXILVXnFGgmzTpHPTSHm/pWSDJd
	 LhbIOBvkP6RCOV2+JMFd1ad0N3rUA3YErGviQJzVeZ4jQirY5iN6FmotddDbFmuoI9
	 OpuFKqO+bqnI3EPq6E88j3XIvOokl7JHAucOv09IphHka9N0UE2+O/d0BnMzTmm2+x
	 M6CdULSialoRIrRr58ZsfKwZf7Bd0EsWe9O9yZUOgg6VkRDmtpkqcvs24a0A41UONM
	 CaCRwacqcSeHA==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A36B4059D;
	Wed, 10 Apr 2024 14:12:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 1F2B31BF23B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 10 Apr 2024 14:12:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 08CC080F79
 for <intel-wired-lan@lists.osuosl.org>; Wed, 10 Apr 2024 14:12:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gOM-gMi1hchS for <intel-wired-lan@lists.osuosl.org>;
 Wed, 10 Apr 2024 14:12:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 93F8180F92
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 93F8180F92
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 93F8180F92
 for <intel-wired-lan@lists.osuosl.org>; Wed, 10 Apr 2024 14:12:11 +0000 (UTC)
X-CSE-ConnectionGUID: VbjFZIBlSD+2EJg6OFPZcA==
X-CSE-MsgGUID: CN89EBFIQ5esokPRZd66gA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11901664"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; d="scan'208";a="11901664"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2024 07:12:12 -0700
X-CSE-ConnectionGUID: hNP+zl38Rneci8JOfRfjqw==
X-CSE-MsgGUID: 3sZPcSJxThW/6nxURZRRng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; d="scan'208";a="25091156"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
 by fmviesa003.fm.intel.com with ESMTP; 10 Apr 2024 07:12:10 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1ruYgJ-0007Tm-2w
 for intel-wired-lan@lists.osuosl.org; Wed, 10 Apr 2024 14:12:07 +0000
Date: Wed, 10 Apr 2024 22:11:27 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202404102225.QipbNlyE-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712758333; x=1744294333;
 h=date:from:to:subject:message-id;
 bh=EHRH7wmERi9D8q49gADrVG7oYbxurpYSvZtG6o/I2hU=;
 b=ErI/wJvEwktSAHQphhLpU19ueACcIWmAi1dybAOEc4tjmDf0HJdbYlZu
 e0Il8CEG5eDXkjp8n1YqsQT0mdiGjUX9AfbxfJWn6nMQIY9W40+V2B4oQ
 noR63ZYoEvIjPKr9s5z3fLkMAwJ8HDgCiVKJM5zEo2GgkxuM8d3eRWgsx
 Ob1XLOqSIW0gNEPyugN3Y2FkeQGHNcHcXLQOStOVXZy9kS0NSYCica/VY
 PA9GxY4WGNfE+ALPM8Dc37+JydFgfnutVDwztnb/MGOUHAuCTIJozPagv
 Usv5NQLEky5vBtbylThrPzVoKqQP//HNo0xR5peaqXw4KmiJkxPd4Odgx
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ErI/wJvE
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 276bbd532696621286624cfbda79f9c841723863
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
branch HEAD: 276bbd532696621286624cfbda79f9c841723863  ice: fix LAG and VF lock dependency in ice_reset_vf()

elapsed time: 1238m

configs tested: 157
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
arc                   randconfig-001-20240410   gcc  
arc                   randconfig-002-20240410   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240410   gcc  
arm                   randconfig-002-20240410   clang
arm                   randconfig-003-20240410   gcc  
arm                   randconfig-004-20240410   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240410   clang
arm64                 randconfig-002-20240410   gcc  
arm64                 randconfig-003-20240410   gcc  
arm64                 randconfig-004-20240410   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240410   gcc  
csky                  randconfig-002-20240410   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240410   clang
hexagon               randconfig-002-20240410   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240410   gcc  
i386         buildonly-randconfig-002-20240410   clang
i386         buildonly-randconfig-003-20240410   clang
i386         buildonly-randconfig-004-20240410   clang
i386         buildonly-randconfig-005-20240410   gcc  
i386         buildonly-randconfig-006-20240410   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240410   clang
i386                  randconfig-002-20240410   clang
i386                  randconfig-003-20240410   gcc  
i386                  randconfig-004-20240410   gcc  
i386                  randconfig-005-20240410   gcc  
i386                  randconfig-006-20240410   clang
i386                  randconfig-011-20240410   clang
i386                  randconfig-012-20240410   clang
i386                  randconfig-013-20240410   gcc  
i386                  randconfig-014-20240410   clang
i386                  randconfig-015-20240410   gcc  
i386                  randconfig-016-20240410   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240410   gcc  
loongarch             randconfig-002-20240410   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240410   gcc  
nios2                 randconfig-002-20240410   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240410   gcc  
parisc                randconfig-002-20240410   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240410   gcc  
powerpc               randconfig-002-20240410   gcc  
powerpc               randconfig-003-20240410   gcc  
powerpc64             randconfig-001-20240410   gcc  
powerpc64             randconfig-002-20240410   gcc  
powerpc64             randconfig-003-20240410   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240410   gcc  
riscv                 randconfig-002-20240410   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240410   clang
s390                  randconfig-002-20240410   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240410   gcc  
sh                    randconfig-002-20240410   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240410   gcc  
sparc64               randconfig-002-20240410   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240410   clang
um                    randconfig-002-20240410   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240410   gcc  
x86_64       buildonly-randconfig-004-20240410   gcc  
x86_64       buildonly-randconfig-006-20240410   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-002-20240410   gcc  
x86_64                randconfig-005-20240410   gcc  
x86_64                randconfig-011-20240410   gcc  
x86_64                randconfig-012-20240410   gcc  
x86_64                randconfig-013-20240410   gcc  
x86_64                randconfig-015-20240410   gcc  
x86_64                randconfig-071-20240410   gcc  
x86_64                randconfig-073-20240410   gcc  
x86_64                randconfig-075-20240410   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240410   gcc  
xtensa                randconfig-002-20240410   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
