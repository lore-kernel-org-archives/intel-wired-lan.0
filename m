Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90426C77B60
	for <intel-wired-lan@archiver.kernel.org>; Sat, 29 Apr 2023 06:50:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1274B4157B;
	Sat, 29 Apr 2023 06:50:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1274B4157B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1682751002;
	bh=KtrqSLNUWT9F7OKHvBFm3QkRvsk/iAiA9ggjD1rxNVQ=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hFVxa5N/vK0PmGlO2VobQuRC0780ujzjfPnXSjlZXcEyzcmkf2Bwy7xLqxsbt4lcl
	 ba4EtmHivqtFMuDCyxAkKWyRUKrQIAbQ8xicHfceCFLY2bPSfscFZmQG3+pz8NH5hc
	 aIDYV9LUYPW/5LLU49dWiWxnGWx9HjsRaQTLZcGQpMt/Rx4rg+Jk2n/eagNbjrmTUm
	 Sv5vtSUF43ISJ8/jCn+v92H2TOHN/AKYAf5eifFfIhvr3iLMfg+91R12KRjQSFuyTO
	 Yt+bVAYeS0WG8L8eVYCi8BQm+G1jQS899G5sARxTJemMxFBjX62kebRdIusmRRx+r5
	 r/RLT6B4XiHQA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VAsbHepWRjOn; Sat, 29 Apr 2023 06:50:01 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB6C4415A4;
	Sat, 29 Apr 2023 06:50:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BB6C4415A4
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 4562A1BF2F2
 for <intel-wired-lan@lists.osuosl.org>; Sat, 29 Apr 2023 06:49:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 06E86401F1
 for <intel-wired-lan@lists.osuosl.org>; Sat, 29 Apr 2023 06:49:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 06E86401F1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id svle81b0dB9h for <intel-wired-lan@lists.osuosl.org>;
 Sat, 29 Apr 2023 06:49:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 081F640156
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 081F640156
 for <intel-wired-lan@lists.osuosl.org>; Sat, 29 Apr 2023 06:49:57 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="328256004"
X-IronPort-AV: E=Sophos;i="5.99,236,1677571200"; d="scan'208";a="328256004"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2023 23:49:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="764606762"
X-IronPort-AV: E=Sophos;i="5.99,236,1677571200"; d="scan'208";a="764606762"
Received: from lkp-server01.sh.intel.com (HELO 5bad9d2b7fcb) ([10.239.97.150])
 by fmsmga004.fm.intel.com with ESMTP; 28 Apr 2023 23:49:56 -0700
Received: from kbuild by 5bad9d2b7fcb with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1pseP5-0000xh-1b
 for intel-wired-lan@lists.osuosl.org; Sat, 29 Apr 2023 06:49:55 +0000
Date: Sat, 29 Apr 2023 14:49:44 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <20230429064944.K_xib%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1682750998; x=1714286998;
 h=date:from:to:subject:message-id;
 bh=9n+ByMwfztC14cdcs4aiuxNmEezFhg3m5bxeV2/yot8=;
 b=EYU5W0/2/ppRwe9s9PDoFvlYwZYkO55C+ftak3IHCVGjFjjkrb11P16f
 sOX6z8lKWF4hswAy+/lwue0eNMV2+KSiSAkMDvEAoQVMa1r7H+VO9CCX2
 LFlLkpfGgVBM48AiXPRhQ+9d6OV7Ql62TM1aY8n5jokx1WK0tEilD1e8Y
 GWDaNPUwkffOBEIw475+YN0Q1vxAQW3gh/mui9Esn6381esp1OT0WMhUc
 ZzXHM9PCIee10CSoWJftIGNXdiASLsMr+QO+ZcxRCf3AOkaoYERCGBsD8
 nES5kpoEAodmyFSkI6cV3oJvubYkF6bNS1qYQ1OoEdzOdvoosRTcasPHv
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=EYU5W0/2
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 65af37e39219ffc29b1738fc31a1b8dc470ee249
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
branch HEAD: 65af37e39219ffc29b1738fc31a1b8dc470ee249  ice: update PHY type to ethtool link mode mapping

elapsed time: 722m

configs tested: 98
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230428   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230428   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r016-20230428   clang
arm                  randconfig-r046-20230428   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r004-20230428   gcc  
hexagon              randconfig-r041-20230428   clang
hexagon              randconfig-r045-20230428   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r014-20230428   gcc  
ia64                 randconfig-r015-20230428   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r023-20230428   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r036-20230428   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r005-20230428   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230428   gcc  
openrisc     buildonly-randconfig-r001-20230428   gcc  
openrisc             randconfig-r006-20230428   gcc  
parisc       buildonly-randconfig-r006-20230428   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230428   gcc  
parisc               randconfig-r034-20230428   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r011-20230428   gcc  
powerpc              randconfig-r021-20230428   gcc  
powerpc              randconfig-r025-20230428   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r004-20230428   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r013-20230428   gcc  
riscv                randconfig-r042-20230428   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r003-20230428   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r005-20230428   clang
s390                 randconfig-r044-20230428   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r026-20230428   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r022-20230428   gcc  
sparc64              randconfig-r012-20230428   gcc  
sparc64              randconfig-r035-20230428   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
