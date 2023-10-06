Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7383BE92FF8
	for <intel-wired-lan@archiver.kernel.org>; Fri,  6 Oct 2023 08:37:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E86B283837;
	Fri,  6 Oct 2023 08:37:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E86B283837
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1696581427;
	bh=78MruOLHsDkKmEnvxKhNRYVLxnB88XVQchAMI95gwZY=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Q1fTDKmpaysPf7CrfISCYltBQE7eqIzzondqNMdmMDj+t+EAzJfhMpqjynfUT1o+e
	 CYQ/horGSPV6OOKa6Z+JcIZD2J/3nQgpUw1Ud4ChgYbVXmCJYcH1RyF6Ps8Ktrh7yr
	 AIxVnNmMglitCnR1KIcZ0rVimiv4P9RBhknhh8u7EovWvSUB0WywKrzCCAbk8unpu5
	 OFIjQs7k+O64/e8LNFrOtqUyE9/IFw3/ejN3ih6q6T26uMNhGp465MgEFQDaQ14FY7
	 77r4Ft9ZtHH2emB79m2DtgqdljnSBGD9mOlo/UsMQqSfxTa50UXmsyzPcOf159TAUr
	 A5J6mu1B4VGaQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6nMJk69LjCnL; Fri,  6 Oct 2023 08:37:07 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 006C78385D;
	Fri,  6 Oct 2023 08:37:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 006C78385D
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 353B31BF576
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Oct 2023 08:37:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0B1F142C66
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Oct 2023 08:37:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0B1F142C66
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tPFUkQZWI42r for <intel-wired-lan@lists.osuosl.org>;
 Fri,  6 Oct 2023 08:37:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 682D742C5D
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Oct 2023 08:37:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 682D742C5D
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="368782235"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; d="scan'208";a="368782235"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2023 01:36:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="868265599"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; d="scan'208";a="868265599"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
 by fmsmga002.fm.intel.com with ESMTP; 06 Oct 2023 01:36:56 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1qogKM-000MQU-2D
 for intel-wired-lan@lists.osuosl.org; Fri, 06 Oct 2023 08:36:54 +0000
Date: Fri, 06 Oct 2023 16:36:01 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202310061659.kpsBjfcc-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1696581423; x=1728117423;
 h=date:from:to:subject:message-id;
 bh=HFwYI7ih7tVLtMO36tpKhTMDv1UW2wlD8cfcV7tpIew=;
 b=Ho8y+089ub0b/oxXWrFl1oIPB1+NqeyUtqEnwADIfKi3BAdI0FoJRhIT
 jhnGq0JfO2Y7CHbC2aM3a2g1GX42IM+gzOfMa7bTcYYm9fN9Z8glADy8f
 vSZutATzs74ioLO0LuU0UudavWPHnjv0XqbhgASF5Ga1Z6fmWS6AyEMjb
 NlK5DBEmMKeWB2QgxU1ktqQbPiHpySaZuWKBnzrPVk8KAHBCd8+jmclvc
 qvdyQ5WPm0F3pWrg3o6N/OPT9MDMswwKTS6ziYmDpxKM+WNVW+ownyDKZ
 bIVVAIxwCL5libscn442o0GNcUix05Mrt7OzmOPfly6tVX6CJhMGshQEB
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Ho8y+089
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 d462a76d72369fd26d1a5ab7b66be365bb0dca9e
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: d462a76d72369fd26d1a5ab7b66be365bb0dca9e  intel: fix format warnings

elapsed time: 844m

configs tested: 113
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              alldefconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231006   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231006   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231006   gcc  
i386         buildonly-randconfig-002-20231006   gcc  
i386         buildonly-randconfig-003-20231006   gcc  
i386         buildonly-randconfig-004-20231006   gcc  
i386         buildonly-randconfig-005-20231006   gcc  
i386         buildonly-randconfig-006-20231006   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231006   gcc  
i386                  randconfig-002-20231006   gcc  
i386                  randconfig-003-20231006   gcc  
i386                  randconfig-004-20231006   gcc  
i386                  randconfig-005-20231006   gcc  
i386                  randconfig-006-20231006   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231006   gcc  
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
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                     kmeter1_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231006   gcc  
x86_64                randconfig-002-20231006   gcc  
x86_64                randconfig-003-20231006   gcc  
x86_64                randconfig-004-20231006   gcc  
x86_64                randconfig-005-20231006   gcc  
x86_64                randconfig-006-20231006   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
