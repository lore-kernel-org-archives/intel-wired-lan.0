Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE3B606A329
	for <intel-wired-lan@archiver.kernel.org>; Sat, 14 Nov 2026 02:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=fJ4WuRZQ;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lI3XUHzD
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C2A4606D0;
	Sat, 14 Nov 2026 02:59:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1oWnWVW_Rmdk; Sat, 14 Nov 2026 02:59:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F0F90606EA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794625140;
	b=W3zcg4ztbN0debrI9iB54xbmPtVFmDx/niJWhD41Uhi1U5PIHMpl6VmYgN/Zu7G8puIv
	 eq3TNI9d5odEB9Q8ZeoUXqnd3JDAkYbiDQZ5eIxCkzgD2IXYmOy90heIhUn2noiIY1QYu
	 dE1GjzFuV/2nw74YNdAYRc63R1HYUWi1JYVqvDHkubJ+3OzxTRzxsg4MSbB+gfA61ZLf+
	 fWqoH4NvdLEG9OeHkHLqcPU+jgSRpWt+v7YbJvtMHLekn5ecpijU7SdwCbEHG3S3jOW+j
	 PfShEecRUEZfnSyMmEZkHvN5z1Th6STJNxb8SvNjqfvFcK57b/tGy7Elz22WvJLK6yw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794625140;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=T/wDWd0FikjbMsJXKHrhc2xwlbSQOCiKdXw+Vnuytcg=;
	b=dD7Vj6zbAjjTzCk3zCOd9IU1TIqqnIpE8jUumVN25A7tE8SJJWZ+e4yHbJn9X+DprdrX
	 VAHwpeB9NuDlF8T6+07lX4ijXCvnjCnquN1Bsz27jVaaR7TdMZhAU+U+Q0s4cLk07hdCH
	 I73KXYeXnVhEaoVkkbe2V+30lbTqH7y56TAW5mQ650IXIp9x2ffwrJUwE32OCbQdf54Fc
	 XqCZMV3LglrdLO0xI786LhFT5xCR4WLZ8y9Vls2/s7B9w/P4u13Lf3WFvgTOJweZwnHKj
	 vsoDlqcNYRu6+n3UCPPtuvmnkkaOLxQfDvgyv2HtYJoM3ToyBioMenRXLtw9XRUIfPg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794625140;
	bh=T/wDWd0FikjbMsJXKHrhc2xwlbSQOCiKdXw+Vnuytcg=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fJ4WuRZQMdzM/qSSoxYNxdCvJW+0CPsD38Jz1CfkxGUVF9XOhtScYyPKYcmYZ+K5a
	 ZqbXdwA1bRLSzD9dzFjMXqLtlX6kaYaSrgDYmxSN8RM6eUEiTSdy5raUvF5zjMF49k
	 Y8WNeanA1v1+xjjH0XsEQixfQkEqydL60LnN7vSPMSiGS57G0AUouE3mjYzAEvyNKP
	 32tGRpr4jWs4qdwLX7L5Y+uUw9oxJeNeRiREFXgjwSrQaqzkqoVqY70xi07ofbLZct
	 Qp7fgAVHuc5YZ+IiV0qACQXxOJmTGeRAtoUQNA1WdJRCDOq/PlhITf09U3w8kzCF0t
	 plVF+S5wcbAiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F0F90606EA;
	Sat, 14 Nov 2026 02:58:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id ABF08150
 for <intel-wired-lan@lists.osuosl.org>; Sat, 14 Nov 2026 02:58:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 920F740EC2
 for <intel-wired-lan@lists.osuosl.org>; Sat, 14 Nov 2026 02:58:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l_JMZoUikefi for <intel-wired-lan@lists.osuosl.org>;
 Sat, 14 Nov 2026 02:58:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 11A2D40EBA
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.21
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=lI3XUHzD
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 11A2D40EBA
 for <intel-wired-lan@lists.osuosl.org>; Sat, 14 Nov 2026 02:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794625136; x=1826161136; h=date:from:to:subject:message-id;
 bh=zGo/sDpW9R5/KagRBk2ktdsShJ4OOQCt8klRf/ZoXkw=;
 b=lI3XUHzD2/P+AX9AoRUxIIvLffQkFR1X5UgKaxHj9641erUYE5rp+fc0
 oQtpKxSHppGfAcjSK0wP9tbtyzLDNSQ5zttYwLKNkvvrWVP0Uj3wb3mW2
 ZEPOoWflQy+3d2lAqtuzUkxo5YRHuB4MdmumBdSbPk5+qNOhs8k4d+WmH
 Ka/DtzKWexbUkWfpAGSXfFvI08uNBTkY7PczvkAK6c7X6sZBwbbOxcmpN
 QVSc/S0Pl9LoXAB3AMHUtD+4onIk4f7Aq6jvDT1itbZdkhyYFbnBc/Vbj
 1QKZ1nqvdU0S9moZMa6lcxtCbC5WzuCyd6z15QY2sJzT5QlgqQ0UAfBBp w==;
X-CSE-ConnectionGUID: qKHuuq/jQFqwbMzDPVr42w==
X-CSE-MsgGUID: 3C86yVOHRN2OPMp/9tUWcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3517797"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3517797"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 18:58:53 -0800
X-CSE-ConnectionGUID: F3DdovG/TROVjM9wK7c5+w==
X-CSE-MsgGUID: L8izcbDfSoGqr5A67vq68A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9079777"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa006.jf.intel.com with ESMTP; 13 Nov 2026 18:58:52 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xS3yb-000000014n7-3kuM;
 Sat, 14 Nov 2026 02:58:49 +0000
Date: Sat, 14 Nov 2026 10:58:25 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:40GbE] BUILD SUCCESS
 e54d3ad91558e0f929531cf20e32551ef695a93b
Message-ID: <20261114105825.zdcXQOKk-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 40GbE
branch HEAD: e54d3ad91558e0f929531cf20e32551ef695a93b  iavf: add missing PTP adjustment callbacks

elapsed time: 1203m

configs tested: 287
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
arc                               allmodconfig    clang-24
arc                               allmodconfig    gcc-16.2.0
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                             hsdk_defconfig    clang-24
arc                   randconfig-1000-20261113    gcc-10.5.0
arc                   randconfig-1000-20261114    clang-24
arc                   randconfig-1001-20261113    gcc-10.5.0
arc                   randconfig-1001-20261114    clang-24
arc                         vdk_hs38_defconfig    gcc-16.2.0
arm                               alldefconfig    clang-24
arm                               alldefconfig    gcc-16.2.0
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                               allyesconfig    gcc-16.2.0
arm                      am200epdkit_defconfig    gcc-16.2.0
arm                        aspeed_g5_defconfig    clang-24
arm                          assabet_defconfig    gcc-16.2.0
arm                          bcm2835_defconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                           moxart_defconfig    clang-24
arm                             mps2_defconfig    clang-24
arm                         multi_v5_defconfig    clang-24
arm                          mv78xx0_defconfig    gcc-16.2.0
arm                   randconfig-1000-20261113    gcc-10.5.0
arm                   randconfig-1000-20261114    clang-24
arm                   randconfig-1001-20261113    gcc-10.5.0
arm                   randconfig-1001-20261114    clang-24
arm                   randconfig-1002-20261113    gcc-10.5.0
arm                   randconfig-1002-20261114    clang-24
arm                   randconfig-1003-20261113    gcc-10.5.0
arm                   randconfig-1003-20261114    clang-24
arm                            sama7_defconfig    gcc-16.2.0
arm                            stm32_defconfig    gcc-16.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261113    gcc-15.3.0
arm64                 randconfig-1000-20261114    gcc-16.2.0
arm64                 randconfig-1001-20261113    gcc-15.3.0
arm64                 randconfig-1001-20261114    gcc-16.2.0
arm64                 randconfig-1002-20261113    gcc-15.3.0
arm64                 randconfig-1002-20261114    gcc-16.2.0
arm64                 randconfig-1003-20261113    gcc-15.3.0
arm64                 randconfig-1003-20261114    gcc-16.2.0
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261113    gcc-15.3.0
csky                  randconfig-1000-20261114    gcc-16.2.0
csky                  randconfig-1001-20261113    gcc-15.3.0
csky                  randconfig-1001-20261114    gcc-16.2.0
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261114    clang-24
hexagon               randconfig-1001-20261114    clang-24
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261114    gcc-14
i386        buildonly-randconfig-1001-20261114    gcc-14
i386        buildonly-randconfig-1002-20261114    gcc-14
i386        buildonly-randconfig-1003-20261114    gcc-14
i386        buildonly-randconfig-1004-20261114    gcc-14
i386        buildonly-randconfig-1005-20261114    gcc-14
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261113    clang-22
i386                  randconfig-1000-20261114    gcc-12
i386                  randconfig-1001-20261113    clang-22
i386                  randconfig-1001-20261114    gcc-12
i386                  randconfig-1002-20261113    clang-22
i386                  randconfig-1002-20261114    gcc-12
i386                  randconfig-1003-20261113    clang-22
i386                  randconfig-1003-20261114    gcc-12
i386                  randconfig-1004-20261113    clang-22
i386                  randconfig-1004-20261114    gcc-12
i386                  randconfig-1005-20261113    clang-22
i386                  randconfig-1005-20261114    gcc-12
i386                  randconfig-1006-20261113    clang-22
i386                  randconfig-1006-20261114    gcc-12
i386                  randconfig-1007-20261113    clang-22
i386                  randconfig-1007-20261114    clang-22
i386                  randconfig-1008-20261113    clang-22
i386                  randconfig-1008-20261114    clang-22
i386                  randconfig-1009-20261113    clang-22
i386                  randconfig-1009-20261114    clang-22
i386                  randconfig-1010-20261113    clang-22
i386                  randconfig-1010-20261114    clang-22
i386                  randconfig-1011-20261113    clang-22
i386                  randconfig-1011-20261114    clang-22
i386                  randconfig-1012-20261113    clang-22
i386                  randconfig-1012-20261114    clang-22
i386                  randconfig-1013-20261113    clang-22
i386                  randconfig-1013-20261114    clang-22
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261114    clang-24
loongarch             randconfig-1001-20261114    clang-24
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                              allyesconfig    gcc-16.2.0
m68k                          amcore_defconfig    clang-24
m68k                          amcore_defconfig    gcc-16.2.0
m68k                                 defconfig    clang-24
m68k                         m5407c3_defconfig    clang-24
m68k                        m5475evb_defconfig    gcc-16.2.0
m68k                          nettel_defconfig    gcc-16.2.0
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                           ath79_defconfig    gcc-16.2.0
mips                         bcm63xx_defconfig    gcc-16.2.0
mips                   decstation_64_defconfig    gcc-16.2.0
mips                            gcw0_defconfig    clang-24
mips                            ip27_defconfig    gcc-16.2.0
mips                            jazz_defconfig    clang-24
mips                       malta_kvm_defconfig    gcc-16.2.0
mips                       pic32mzda_defconfig    gcc-16.2.0
mips                         qi_lb60_defconfig    gcc-16.2.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261114    clang-24
nios2                 randconfig-1001-20261114    clang-24
openrisc                          alldefconfig    gcc-16.2.0
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc                   or1klitex_defconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261113    gcc-13.5.0
parisc                randconfig-1000-20261114    gcc-8.5.0
parisc                randconfig-1001-20261113    gcc-13.5.0
parisc                randconfig-1001-20261114    gcc-8.5.0
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                  canyonlands_defconfig    clang-24
powerpc                       cm5200_defconfig    clang-24
powerpc                        eiger_defconfig    gcc-16.2.0
powerpc                       ep88xc_defconfig    gcc-16.2.0
powerpc                   iss476-smp_defconfig    clang-24
powerpc                      mpc5200_defconfig    clang-24
powerpc                  mpc8313_rdb_defconfig    gcc-16.2.0
powerpc                     mvme5100_defconfig    clang-24
powerpc                       pcm030_defconfig    gcc-16.2.0
powerpc                       ppc6xx_defconfig    clang-24
powerpc               randconfig-1000-20261113    gcc-13.5.0
powerpc               randconfig-1000-20261114    gcc-8.5.0
powerpc               randconfig-1001-20261113    gcc-13.5.0
powerpc               randconfig-1001-20261114    gcc-8.5.0
powerpc                   storcenter_defconfig    clang-24
powerpc                   storcenter_defconfig    gcc-16.2.0
powerpc                      stx_gp3_defconfig    gcc-16.2.0
powerpc                       tqm8xx_defconfig    gcc-16.2.0
powerpc                  xes_mpc85xx_defconfig    gcc-16.2.0
powerpc64             randconfig-1000-20261113    gcc-13.5.0
powerpc64             randconfig-1000-20261114    gcc-8.5.0
powerpc64             randconfig-1001-20261113    gcc-13.5.0
powerpc64             randconfig-1001-20261114    gcc-8.5.0
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261113    gcc-12.5.0
riscv                 randconfig-1000-20261114    gcc-15.3.0
riscv                 randconfig-1001-20261113    gcc-12.5.0
riscv                 randconfig-1001-20261114    gcc-15.3.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261113    gcc-12.5.0
s390                  randconfig-1000-20261114    gcc-15.3.0
s390                  randconfig-1001-20261113    gcc-12.5.0
s390                  randconfig-1001-20261114    gcc-15.3.0
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                         edosk7705_defconfig    gcc-16.2.0
sh                                j2_defconfig    clang-24
sh                      magicpanelr2_defconfig    clang-24
sh                           r7780mp_defconfig    gcc-16.2.0
sh                    randconfig-1000-20261113    gcc-12.5.0
sh                    randconfig-1000-20261114    gcc-15.3.0
sh                    randconfig-1001-20261113    gcc-12.5.0
sh                    randconfig-1001-20261114    gcc-15.3.0
sh                    rts7751r2dplus_defconfig    gcc-16.2.0
sh                            se7619_defconfig    gcc-16.2.0
sparc                             alldefconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261113    gcc-8.5.0
sparc                 randconfig-1000-20261114    gcc-12.5.0
sparc                 randconfig-1001-20261113    gcc-8.5.0
sparc                 randconfig-1001-20261114    gcc-12.5.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261113    gcc-8.5.0
sparc64               randconfig-1000-20261114    gcc-12.5.0
sparc64               randconfig-1001-20261113    gcc-8.5.0
sparc64               randconfig-1001-20261114    gcc-12.5.0
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261113    gcc-8.5.0
um                    randconfig-1000-20261114    gcc-12.5.0
um                    randconfig-1001-20261113    gcc-8.5.0
um                    randconfig-1001-20261114    gcc-12.5.0
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261114    gcc-14
x86_64      buildonly-randconfig-1001-20261114    gcc-14
x86_64      buildonly-randconfig-1002-20261114    gcc-14
x86_64      buildonly-randconfig-1003-20261114    gcc-14
x86_64      buildonly-randconfig-1004-20261114    gcc-14
x86_64      buildonly-randconfig-1005-20261114    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261113    clang-22
x86_64                randconfig-1000-20261114    gcc-14
x86_64                randconfig-1001-20261113    clang-22
x86_64                randconfig-1001-20261114    gcc-14
x86_64                randconfig-1002-20261113    clang-22
x86_64                randconfig-1002-20261114    gcc-14
x86_64                randconfig-1003-20261113    clang-22
x86_64                randconfig-1003-20261114    gcc-14
x86_64                randconfig-1004-20261113    clang-22
x86_64                randconfig-1004-20261114    gcc-14
x86_64                randconfig-1005-20261113    clang-22
x86_64                randconfig-1005-20261114    gcc-14
x86_64                randconfig-1006-20261113    clang-22
x86_64                randconfig-1006-20261114    gcc-14
x86_64                randconfig-1007-20261113    clang-22
x86_64                randconfig-1007-20261114    gcc-14
x86_64                randconfig-1008-20261113    clang-22
x86_64                randconfig-1008-20261114    gcc-14
x86_64                randconfig-1009-20261113    clang-22
x86_64                randconfig-1009-20261114    gcc-14
x86_64                randconfig-1010-20261113    clang-22
x86_64                randconfig-1010-20261114    gcc-14
x86_64                randconfig-1011-20261113    clang-22
x86_64                randconfig-1011-20261114    gcc-14
x86_64                randconfig-1012-20261113    gcc-14
x86_64                randconfig-1012-20261114    clang-22
x86_64                randconfig-1013-20261113    gcc-14
x86_64                randconfig-1013-20261114    clang-22
x86_64                randconfig-1014-20261113    gcc-14
x86_64                randconfig-1014-20261114    clang-22
x86_64                randconfig-1015-20261113    gcc-14
x86_64                randconfig-1015-20261114    clang-22
x86_64                randconfig-1016-20261113    gcc-14
x86_64                randconfig-1016-20261114    clang-22
x86_64                randconfig-1017-20261113    gcc-14
x86_64                randconfig-1017-20261114    clang-22
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                           iss_defconfig    clang-24
xtensa                randconfig-1000-20261113    gcc-8.5.0
xtensa                randconfig-1000-20261114    gcc-12.5.0
xtensa                randconfig-1001-20261113    gcc-8.5.0
xtensa                randconfig-1001-20261114    gcc-12.5.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
