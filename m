Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4286C0015E
	for <intel-wired-lan@archiver.kernel.org>; Sat, 29 Jul 2023 12:14:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 41F5881E15;
	Sat, 29 Jul 2023 12:14:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 41F5881E15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1690632856;
	bh=rgzu5he5zO6t3c/dyIQaBQ5LLnHL67FanBV5xfO3zLg=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=brgXvrlhhuIoWv1eCjMY3YBakJmIXirNO7ONAQrgxlNo5Yl9PNbi6kPAiPDbkEuFN
	 ejEEWTsvIEQNaroUcmYR/8pF5SyLT624XBqyfxmhLknNUDpHzSllKyKeTOe4QNnQKE
	 CNUDXqbqNTmRZCph9nleF9nmXY7DukmimLZbCn/0Eagb5Hhg1Ia4ZIHdt0UkkR3KrR
	 Z2iDXeS3csNtwkd56A2VMRrHATkfBBXlRluG4HTAiDWiqYSzDV1BVKD+fX7uhwZPNI
	 1wVI9CJI5K/5zW0+h3mcRVeRAlkiZ3JhG3N2ruLAtEB/DM120FAeaultUmQlFHvd4h
	 TQTIYAhq1nH+g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IwEaeNBuDVLO; Sat, 29 Jul 2023 12:14:15 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 39BD981E4E;
	Sat, 29 Jul 2023 12:14:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 39BD981E4E
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 52CAD1BF47D
 for <intel-wired-lan@lists.osuosl.org>; Sat, 29 Jul 2023 12:14:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 27DF8400C8
 for <intel-wired-lan@lists.osuosl.org>; Sat, 29 Jul 2023 12:14:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 27DF8400C8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xn50-NISljni for <intel-wired-lan@lists.osuosl.org>;
 Sat, 29 Jul 2023 12:14:12 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7A7924012A
 for <intel-wired-lan@lists.osuosl.org>; Sat, 29 Jul 2023 12:14:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7A7924012A
X-IronPort-AV: E=McAfee;i="6600,9927,10786"; a="366225112"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; d="scan'208";a="366225112"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2023 05:14:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10786"; a="817793832"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; d="scan'208";a="817793832"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
 by FMSMGA003.fm.intel.com with ESMTP; 29 Jul 2023 05:14:06 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1qPiph-00041Z-0V
 for intel-wired-lan@lists.osuosl.org; Sat, 29 Jul 2023 12:14:05 +0000
Date: Sat, 29 Jul 2023 20:13:56 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202307292054.HH98rNqr-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690632852; x=1722168852;
 h=date:from:to:subject:message-id;
 bh=Lg0fYXqxhNiToofOz1yfWDaUqMoWXStDBBbIqgjwMe8=;
 b=a7TIx3BiGkG26aPJ3hzUtb9KuN6K8BIof8hQ30vhGBrSl3085SHf6QB+
 y6A8hd8XJswkFQ11Qlr5+7a0UeFZWs5U3v6Xq4eBUz3XEZW4ZP5WA8mvI
 M3jvO3foadv3Ub81wL0vHjh9t4PkJio98diCJm2EMvfRIhabScHuBpEqn
 e2m4omYSSy01pBMUU3+5pgRuK/y0LC4RS70zOStreQloPeVibq5WMbNvH
 S0VPf5J7dG1wq92AW4HcR1kLpFZ6hFXBqak4kIt7VRnbjOMq8YCQUraTV
 BhN4GI3eogTPv5FgwU+BUQubB37qXg4ziE8aMB/LAapfcNf/9VdhGpbB2
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=a7TIx3Bi
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 f2f5830a5311f13058364f3e8818f231867796cb
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: f2f5830a5311f13058364f3e8818f231867796cb  i40e: fix livelocks in i40e_reset_subtask()

elapsed time: 827m

configs tested: 102
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r024-20230727   gcc  
arc                  randconfig-r043-20230728   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230728   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r004-20230728   gcc  
hexagon              randconfig-r041-20230728   clang
hexagon              randconfig-r045-20230728   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230728   gcc  
i386         buildonly-randconfig-r005-20230728   gcc  
i386         buildonly-randconfig-r006-20230728   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230728   gcc  
i386                 randconfig-i002-20230728   gcc  
i386                 randconfig-i003-20230728   gcc  
i386                 randconfig-i004-20230728   gcc  
i386                 randconfig-i005-20230728   gcc  
i386                 randconfig-i006-20230728   gcc  
i386                 randconfig-i011-20230728   clang
i386                 randconfig-i012-20230728   clang
i386                 randconfig-i013-20230728   clang
i386                 randconfig-i014-20230728   clang
i386                 randconfig-i015-20230728   clang
i386                 randconfig-i016-20230728   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r015-20230728   gcc  
microblaze           randconfig-r016-20230728   gcc  
microblaze           randconfig-r032-20230728   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r013-20230728   gcc  
mips                 randconfig-r033-20230728   clang
nios2                               defconfig   gcc  
nios2                randconfig-r022-20230727   gcc  
openrisc             randconfig-r036-20230728   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230728   gcc  
parisc               randconfig-r011-20230728   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r023-20230727   gcc  
riscv                randconfig-r042-20230728   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r014-20230728   clang
s390                 randconfig-r021-20230727   gcc  
s390                 randconfig-r044-20230728   clang
sh                               allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r006-20230728   clang
um                   randconfig-r035-20230728   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230728   gcc  
x86_64       buildonly-randconfig-r002-20230728   gcc  
x86_64       buildonly-randconfig-r003-20230728   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230728   clang
x86_64               randconfig-x002-20230728   clang
x86_64               randconfig-x003-20230728   clang
x86_64               randconfig-x004-20230728   clang
x86_64               randconfig-x005-20230728   clang
x86_64               randconfig-x006-20230728   clang
x86_64               randconfig-x011-20230728   gcc  
x86_64               randconfig-x012-20230728   gcc  
x86_64               randconfig-x013-20230728   gcc  
x86_64               randconfig-x014-20230728   gcc  
x86_64               randconfig-x015-20230728   gcc  
x86_64               randconfig-x016-20230728   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r031-20230728   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
