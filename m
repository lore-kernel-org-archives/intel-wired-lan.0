Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E6CC6FA99
	for <intel-wired-lan@archiver.kernel.org>; Fri, 10 Mar 2023 06:21:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C4568204E;
	Fri, 10 Mar 2023 06:21:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3C4568204E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1678429262;
	bh=AiY88rahhfsVEYdN379kilW1df+ca1PTeSyTInGRzcw=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=U0fdtVzkD/0uHCc3zTj4xY/ksb6voOSJIzgGfsjrHlks5wPnhEIYrXE6a51cg7ZAo
	 qSaL6+unKRlP3iafiSeFiATozgbrCSPHpLeyShSkMKHxErbDr+ezqG9JxccGKwNZTw
	 HjOzbtf1tBOqHRX+LJ/rtnrvIEOkXTVxZ00K+Q6C9XOprgMiYlHeNdu43VkFUGm1/e
	 TjDUE4ZwMWcMhTk9roynOP6R5SwlKKbxYNNVFdVU6B3u28yFFteSV2mE5CmUSLspdH
	 R7pSZ9ChVcoWd7Cny+yoQvu6SOlzb/aFbJIjfZkDG49AMd63qmnj5a8wSHEdWSM/hJ
	 UingvWmFQBcQQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M14norqjOVWc; Fri, 10 Mar 2023 06:21:01 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C8FB820B3;
	Fri, 10 Mar 2023 06:21:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3C8FB820B3
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 750171BF45A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Mar 2023 06:20:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4C42241972
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Mar 2023 06:20:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4C42241972
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hVb34j4FGf5C for <intel-wired-lan@lists.osuosl.org>;
 Fri, 10 Mar 2023 06:20:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 26EA44196A
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 26EA44196A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Mar 2023 06:20:57 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="364312629"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; d="scan'208";a="364312629"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2023 22:20:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="851789320"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; d="scan'208";a="851789320"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
 by orsmga005.jf.intel.com with ESMTP; 09 Mar 2023 22:20:56 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1paW7b-0003ZR-1n;
 Fri, 10 Mar 2023 06:20:55 +0000
Date: Fri, 10 Mar 2023 14:20:14 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <640acc1e./g6iX4Z3YygBoblz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1678429258; x=1709965258;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=NnE+NYE9nHCR3OJ7PvIHGXAp03rFTwBhQnEb55lUt4E=;
 b=b7R/N069/L4AWi8VVqEOwrM2llkBSEG5cC/OAtuuqYenIdHv6EgrRkoE
 diM54O+dJ3lhd/W5mvmAfKV4q1g3FbkiS9r/Rgz7DPsfC/YnfG5Gbk8GW
 XhkZ2kma9YFHl+wj2L96CjyTJ96DmEvJEAiUi+ucpqLt7TusY/JQ4RlBO
 FSFXcHFGcUDwEEC0yrdsdsIB5rO+rLNhFb9DDC1HfRjtfZLkilLtZ89gb
 p37XlLqzaQQt6ZA668J+IQSJ2UEC2hiB8fjtYHv+LVDGZl6xqwAH6OxDh
 HZO9trxsbhhYGGtPgiAt+GDUKttzTvCuJD7CVFLzIV8OXPGTlUGGGYU86
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=b7R/N069
Subject: [Intel-wired-lan] [tnguy-net-queue:master] BUILD SUCCESS
 67eeadf2f95326f6344adacb70c880bf2ccff57b
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git master
branch HEAD: 67eeadf2f95326f6344adacb70c880bf2ccff57b  Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue

elapsed time: 1152m

configs tested: 65
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r023-20230308   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          ixp4xx_defconfig   clang
arm                  randconfig-r024-20230308   gcc  
arm                             rpc_defconfig   gcc  
arm                           sama5_defconfig   gcc  
arm                        spear6xx_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r026-20230308   clang
csky                                defconfig   gcc  
csky                 randconfig-r021-20230308   gcc  
i386                              allnoconfig   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                          tiger_defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r022-20230308   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r025-20230308   gcc  
microblaze           randconfig-r021-20230308   gcc  
microblaze           randconfig-r024-20230308   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
nios2                               defconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r026-20230308   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          g5_defconfig   clang
powerpc                  iss476-smp_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                          rsk7201_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r025-20230308   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r022-20230308   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
