Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910D4CDB474
	for <intel-wired-lan@archiver.kernel.org>; Sun, 22 Oct 2023 08:16:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00EC585202;
	Sun, 22 Oct 2023 08:16:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 00EC585202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1697962612;
	bh=x3Q3iCvuhhcVJmA8jZYLAEPcjhjpjNTuwVPm7+l6YnE=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ghq8X4SK1AVum1ei/lC9Nx2zb37Or41eP5aB5tklFYaorzqkTc7dTV8IcQAXZOE4V
	 ws93HTxoUkAgahV/1AJxwV8bYiXUXyB4FEgNZ7T2lJukTuv/4RhR1O237dzEnqO80o
	 vBFcQdUV0/wCsGa5274auVXehFeZ3YUvL2aHBRFkW21R1Bw9d//4NDeMo9GSmGZYh7
	 KIWYHSXk7JSRUZzP78I5cmdz5vhwcACGajmNdTQTk5bej0jAStOHjOv1YMkgXiYMK4
	 bl1I4THNwZ3YNp7sJgqGzgOXlC/vLcZ3qaH9wdHA5mURs+57HlD4mOkjyby1/AZn+d
	 GUHr9egLjCnXA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JWHAj4rNWZQK; Sun, 22 Oct 2023 08:16:51 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0D31851FC;
	Sun, 22 Oct 2023 08:16:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F0D31851FC
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id A89781BF29D
 for <intel-wired-lan@lists.osuosl.org>; Sun, 22 Oct 2023 08:16:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8BEC14F36E
 for <intel-wired-lan@lists.osuosl.org>; Sun, 22 Oct 2023 08:16:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8BEC14F36E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id boIv93Gg3GOs for <intel-wired-lan@lists.osuosl.org>;
 Sun, 22 Oct 2023 08:16:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5A3DC4F36D
 for <intel-wired-lan@lists.osuosl.org>; Sun, 22 Oct 2023 08:16:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5A3DC4F36D
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="383889365"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; d="scan'208";a="383889365"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2023 01:16:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="874363386"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; d="scan'208";a="874363386"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
 by fmsmga002.fm.intel.com with ESMTP; 22 Oct 2023 01:16:46 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1quTdc-0005iy-1m
 for intel-wired-lan@lists.osuosl.org; Sun, 22 Oct 2023 08:16:44 +0000
Date: Sun, 22 Oct 2023 16:16:14 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202310221612.VRSmwiE4-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697962608; x=1729498608;
 h=date:from:to:subject:message-id;
 bh=mOywzdLrhnsIOMkKdF++rr3cJm+8ZtAEafr839bbcR0=;
 b=A1ypV9FgfduMtvQ5ZrtbRudt0agqeiKU92RNvUrbAfPHMsEAwt8IufPq
 4bT+j9i/j/3j3nRcEc08ORJ8SEvcCtu9KOQv/Z6gtDTEsP/fsJFtoE1A6
 pyehJZtpYTivydGJpjIXK7LwGwbxzAivgxSDVokNzJvP/qJOjzTBbo0qk
 3xnbJd7YutfwT+kk5XzvBBNJX5hvGYY3m3OsZT7gSmbF8kOPbeIpmQwul
 CBw8zmi5z0zRyAVOHMXddZzCRHCanZaExkm/QDyU1Jz892Z2SYncZvzL9
 JC6gSUGKRZgl1I2wDKZGgqp/4sAGjKAXrX5f/QQNBRkYXBP16E6/HgFay
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=A1ypV9Fg
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 be7e33aeb956df663e655255b73ac97434398909
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
branch HEAD: be7e33aeb956df663e655255b73ac97434398909  i40e: Fix wrong check for I40E_TXR_FLAGS_WB_ON_ITR

elapsed time: 2282m

configs tested: 147
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
arc                                 defconfig   gcc  
arc                   randconfig-001-20231021   gcc  
arc                   randconfig-001-20231022   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   clang
arm                                 defconfig   gcc  
arm                   randconfig-001-20231022   gcc  
arm                         socfpga_defconfig   clang
arm                           tegra_defconfig   gcc  
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
i386         buildonly-randconfig-001-20231022   gcc  
i386         buildonly-randconfig-002-20231022   gcc  
i386         buildonly-randconfig-003-20231022   gcc  
i386         buildonly-randconfig-004-20231022   gcc  
i386         buildonly-randconfig-005-20231022   gcc  
i386         buildonly-randconfig-006-20231022   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231022   gcc  
i386                  randconfig-002-20231022   gcc  
i386                  randconfig-003-20231022   gcc  
i386                  randconfig-004-20231022   gcc  
i386                  randconfig-005-20231022   gcc  
i386                  randconfig-006-20231022   gcc  
i386                  randconfig-011-20231022   gcc  
i386                  randconfig-012-20231022   gcc  
i386                  randconfig-013-20231022   gcc  
i386                  randconfig-014-20231022   gcc  
i386                  randconfig-015-20231022   gcc  
i386                  randconfig-016-20231022   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231021   gcc  
loongarch             randconfig-001-20231022   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath25_defconfig   clang
mips                      fuloong2e_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   clang
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
powerpc                   lite5200b_defconfig   clang
powerpc                      mgcoge_defconfig   gcc  
powerpc                      obs600_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231022   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231022   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231022   gcc  
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
x86_64       buildonly-randconfig-001-20231022   gcc  
x86_64       buildonly-randconfig-002-20231022   gcc  
x86_64       buildonly-randconfig-003-20231022   gcc  
x86_64       buildonly-randconfig-004-20231022   gcc  
x86_64       buildonly-randconfig-005-20231022   gcc  
x86_64       buildonly-randconfig-006-20231022   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231022   gcc  
x86_64                randconfig-002-20231022   gcc  
x86_64                randconfig-003-20231022   gcc  
x86_64                randconfig-004-20231022   gcc  
x86_64                randconfig-005-20231022   gcc  
x86_64                randconfig-006-20231022   gcc  
x86_64                randconfig-011-20231022   gcc  
x86_64                randconfig-012-20231022   gcc  
x86_64                randconfig-013-20231022   gcc  
x86_64                randconfig-014-20231022   gcc  
x86_64                randconfig-015-20231022   gcc  
x86_64                randconfig-016-20231022   gcc  
x86_64                randconfig-071-20231022   gcc  
x86_64                randconfig-072-20231022   gcc  
x86_64                randconfig-073-20231022   gcc  
x86_64                randconfig-074-20231022   gcc  
x86_64                randconfig-075-20231022   gcc  
x86_64                randconfig-076-20231022   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
