Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FD0C982CC
	for <intel-wired-lan@archiver.kernel.org>; Sun, 20 Sep 2026 08:27:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E6C48100D;
	Sun, 20 Sep 2026 08:27:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OSQuk3XrN2UD; Sun, 20 Sep 2026 08:26:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CFDC680DC5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789892818;
	b=ePmp0cDV8AO3lkZMr84hLfW+v/bO5RONHOCuL9Uz4hwHluXyl8Bu57tpjUkEO7CJAToK
	 pJ6l/lpxMNd3PJlPaTpvkLikuQF39cOfXeLhRRLGcstoVaixJZbT4OXdxDs/K5Pt+PP2u
	 dElsh2YtCNpWakuYfXUp4kZHxEIxMk3qDiqrFPYVVc+SXS/KEd8pxHgayzcXGE8Fka1MQ
	 xbMJmsTLuplJZIfp1FGs3K31Zg+wo9WfO11vy6RmyrObPZGIcj5/G3PC9j9oNzZXS1s/+
	 zjHKSXAh5aAQU8+MheDDhfHcXtQApwMdbVbJHH6dcCOf0HMT/oTRNdBd1zpHd1rQG0g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789892818;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=o2Gb3bhE90nEalI7QhedNnvBzztJ+gqYaXikA5Om1pg=;
	b=oIzEBzAeB31BQlDkkA3ekWZcAJrwzIrE2wkBKlaCesVOiemEEFGTyZwbAlo4IFsAsGcm
	 IC8GVxGcFTJufbJ6seb1wpiepvLSGyf2h9+ut4qUNWAmfaPo+zZK5a7xxHjA2QYMnJKLR
	 N/ws/S+sZ1NigltHnH+85pl5t+E3O58U2Ui3QTXRVOg5jqFdyZc5wQxX/QxPba7Zju6EY
	 35cPFIoK0ivaEMbaS8n3dzHIL11zuGP1UNsASXgsMVQ9/ZCA878kXxsuq+NcV4M+4RedI
	 eJhAuUimkWhIXFWXjxEttiiU/lyi1iwTcyw4BW3OqEOTC1xdEdxRdvmBpCsQRv4Cp0w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789892818;
	bh=o2Gb3bhE90nEalI7QhedNnvBzztJ+gqYaXikA5Om1pg=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GZsTQ+9zy1qeLAXO3voSbbv1A70cM3AgAR/z79zaqMvc3BeDcVPOqIBYIS2HvgSqW
	 1XRXIpa1+WP27+cQhxV1fcD0Age/QODxjeLAy4rORLszqlFpcvMZcK89QS8KSBabVK
	 u1O7RNwuLLtDYMPRYzmrQIe/7ye2uWc+NS379y4WXcXnZNKter/BDSnsVs+EuedKYS
	 GwNAve0aN8Kf0/FAEdyqz1NZORiLgpskSATIS20BvX3/vlVpHV16T2JTaQBKAVUhdb
	 +VPrBwVleSdg0vngeWXEVHZuLSiXwP1czo0fWH2W74qSNOn0dBuviDfwwRQFvSvuBg
	 pTzZQ3OLOWEkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CFDC680DC5;
	Sun, 20 Sep 2026 08:26:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 39DB7224
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 08:26:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2BB0040800
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 08:26:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bT_auA13j4DP for <intel-wired-lan@lists.osuosl.org>;
 Sun, 20 Sep 2026 08:26:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8A674407BB
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789892815;
 b=VOlqzukNTmdnYryFm+K2/pC+t76Eht+5592xCliZAXX5XhB3Imec/+gDOKAa9ub69aZV
 3wpDTx+ExhtrU23/j2GebzDMMeFdMBI9aqZdYf5l3seDr0Y9nTvwrRYA7+6yg2bBrM8JE
 BdHi6spZUtQNAow5Gx8yg2pj0sX5Pjx2MiV9D9sqDyY83i9WXOLo4ULancZ3xpleCLLZ1
 P9Hzb+VLhkBVAZkFL6vifUx1Zvhkx7C7IyFx1ZSjS8iCCizYBG9IraBhP3IQB4WUAM93i
 KB2zckI4M+1rmbPkzRTghPblzVMf9W4ejFkSxks89gyFVjjxSQ2E0Hr+QyqjngQQ7gQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789892815;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=o2Gb3bhE90nEalI7QhedNnvBzztJ+gqYaXikA5Om1pg=;
 b=OgEtO5vSELkmzMltVMZl5hjXOVQ02R/DZuy0KN6AYySNhKkU7BMNVfL+VfGLLLGk4CuU
 lQ+EY+VG9yf+0IivYM541W9DSFmLnBKqNwMcJg/l0eAAgSahNLORghO3sXLrTV+ngVH3l
 2VHXmVdsoGIBWiIokbKDS0q8BfNUdXC6mEVC4XezSN5y9hYyA7fDw6cbrYFAcp6Mv1upw
 yDtNUrjkOhgNrdQhJV+JMsz/Mc9tuTO5tRBuJWcEAudukYSWl8jAXhJC8DTjTZ5LlME2e
 xI1Ttj+iGyoG2hypaF/DTkHG1VKqnDwAdieBMEtM3VWaRmxYfRpLU7k4GwWxO0oZojA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="M/veWUJ7"; 
 arc=none smtp.remote-ip=192.198.163.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=M/veWUJ7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8A674407BB
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 08:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789892815; x=1821428815; h=date:from:to:subject:message-id;
 bh=O3JOY2ph1dpSf/gywW7FbahTmb/dpudI+T7xhx77LyU=;
 b=M/veWUJ7MKCr9TqlBKf9iXINrd8Ty8POFSeWtldtFQ04AmkLX/tMFxO6
 WcG6jN3ko60usq/7e96kjLMQlYoFOJ6OpZW8tist98XBb17GRDcH6ojQW
 mJnY1VlmGl9yN0Z4sa82GLSSozUeSUejRzWJggJz90t16jyZgbebYarCg
 NB6bKVAS/skjv8yQqnmhiKVHz60WnG3mv66byekjaJkx1QSDGIaKNrHdJ
 WtpWGTEVcXQGxHTp1C9Z3bzLox+CxQY7LOrMNp1z6c+hYOs39y16Ruvj8
 6dK8kX7zNcghLFmEGjkPmplnp51KNU65gk+ElvrdpdoHAOhJ/8we0Ofa2 A==;
X-CSE-ConnectionGUID: 5M09FtIxRdGDY8X7682v1g==
X-CSE-MsgGUID: 3vwhZLKzQX+WoCSAJjMHIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="92904042"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; d="scan'208";a="92904042"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2026 01:26:54 -0700
X-CSE-ConnectionGUID: gaajK0vYQNeKnnavyY+20w==
X-CSE-MsgGUID: W0IYoXlaRuKIhIXsFVdP4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; d="scan'208";a="271712828"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by fmviesa007.fm.intel.com with ESMTP; 20 Sep 2026 01:26:53 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x8Cst-00000000CAl-0og0;
 Sun, 20 Sep 2026 08:26:51 +0000
Date: Sun, 20 Sep 2026 16:26:20 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:10GbE] BUILD SUCCESS
 4bb9710c6a68d35207f123aef55dcd50e7195ec5
Message-ID: <202609201617.jd6Ngxjf-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 10GbE
branch HEAD: 4bb9710c6a68d35207f123aef55dcd50e7195ec5  tipc: replace deprecated strcpy with strscpy in tipc_bearer_get_name()

elapsed time: 1042m

configs tested: 266
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r1305-20260920    gcc-12.5.0 sparse
alpha                randconfig-r2101-20260918    clang-22
arc                               allmodconfig    gcc-16.1.0
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    gcc-16.1.0
arc                       axs103_smp_defconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                  nsimosci_hs_smp_defconfig    gcc-16.1.0
arc                   randconfig-1000-20260920    gcc-8.5.0
arc                   randconfig-1001-20260920    gcc-8.5.0
arc                  randconfig-r2107-20260918    clang-24
arm                                allnoconfig    clang-17
arm                               allyesconfig    gcc-16.1.0
arm                      davinci_all_defconfig    clang-17
arm                                  defconfig    clang-24
arm                          lpc18xx_defconfig    clang-24
arm                   randconfig-1000-20260920    gcc-10.5.0
arm                   randconfig-1001-20260920    gcc-12.5.0
arm                   randconfig-1002-20260920    clang-20
arm                   randconfig-1003-20260920    gcc-16.1.0
arm                  randconfig-r1309-20260920    clang-24   sparse
arm                         shmobile_defconfig    gcc-16.1.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260920    gcc-15.2.0
arm64                 randconfig-1001-20260920    clang-24
arm64                 randconfig-1002-20260920    gcc-8.5.0
arm64                 randconfig-1003-20260920    clang-24
arm64                randconfig-r1309-20260920    clang-17   sparse
arm64                randconfig-r2202-20260919    clang-24
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260920    gcc-12.5.0
csky                  randconfig-1001-20260920    gcc-14.3.0
hexagon                           allmodconfig    clang-24
hexagon                            allnoconfig    clang-24
hexagon                              defconfig    clang-24
hexagon               randconfig-1000-20260920    clang-17
hexagon               randconfig-1001-20260920    clang-19
i386                               allnoconfig    gcc-14
i386        buildonly-randconfig-1000-20260920    clang-22
i386        buildonly-randconfig-1001-20260920    clang-22
i386        buildonly-randconfig-1002-20260920    clang-22
i386        buildonly-randconfig-1003-20260920    gcc-14
i386        buildonly-randconfig-1004-20260920    clang-22
i386        buildonly-randconfig-1005-20260920    clang-22
i386                                 defconfig    clang-22
i386                  randconfig-1000-20260920    clang-22
i386                  randconfig-1001-20260920    gcc-14
i386                  randconfig-1002-20260920    gcc-14
i386                  randconfig-1003-20260920    clang-22
i386                  randconfig-1004-20260920    gcc-14
i386                  randconfig-1005-20260920    gcc-14
i386                  randconfig-1006-20260920    clang-22
i386                  randconfig-1007-20260920    gcc-12
i386                  randconfig-1008-20260920    gcc-14
i386                  randconfig-1009-20260920    clang-22
i386                  randconfig-1010-20260920    clang-22
i386                  randconfig-1011-20260920    gcc-14
i386                  randconfig-1012-20260920    gcc-14
i386                  randconfig-1013-20260920    clang-22
i386                  randconfig-2100-20260918    clang-22
i386                  randconfig-2100-20260919    clang-22
i386                  randconfig-2101-20260918    clang-22
i386                  randconfig-2101-20260919    clang-22
i386                  randconfig-2102-20260918    clang-22
i386                  randconfig-2102-20260919    clang-22
i386                  randconfig-2103-20260918    clang-22
i386                  randconfig-2103-20260919    clang-22
i386                  randconfig-2200-20260918    clang-22
i386                 randconfig-r1308-20260920    gcc-14     sparse
loongarch                         allmodconfig    clang-19
loongarch                          allnoconfig    clang-20
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260919    clang-24
loongarch             randconfig-1000-20260920    gcc-16.1.0
loongarch             randconfig-1001-20260920    gcc-16.1.0
loongarch            randconfig-r1307-20260920    gcc-16.1.0 sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    gcc-16.1.0
m68k                           atari_defconfig    gcc-16.1.0
m68k                                 defconfig    gcc-16.1.0
m68k                         mvme16x_defconfig    gcc-16.1.0
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    gcc-16.1.0
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                      eyeq6lplus_defconfig    gcc-16.1.0
mips                       maltaaprp_defconfig    clang-17
mips                 randconfig-r2202-20260918    gcc-15.2.0
nios2                             allmodconfig    gcc-11.5.0
nios2                              allnoconfig    gcc-11.5.0
nios2                                defconfig    gcc-11.5.0
nios2                 randconfig-1000-20260920    gcc-8.5.0
nios2                 randconfig-1001-20260919    gcc-11.5.0
nios2                 randconfig-1001-20260920    gcc-8.5.0
nios2                randconfig-r1303-20260920    gcc-9.5.0  sparse
openrisc                          allmodconfig    gcc-16.1.0
openrisc                           allnoconfig    gcc-16.1.0
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r1308-20260920    gcc-13.4.0 sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    gcc-16.1.0
parisc                            allyesconfig    gcc-16.1.0
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260920    gcc-14.3.0
parisc                randconfig-1001-20260920    gcc-8.5.0
parisc64                             defconfig    gcc-16.1.0
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    gcc-16.1.0
powerpc                       arches_defconfig    gcc-16.1.0
powerpc                           g5_defconfig    gcc-16.1.0
powerpc                     gamecube_defconfig    clang-19
powerpc                   iss476-smp_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20260920    gcc-8.5.0
powerpc               randconfig-1001-20260920    clang-24
powerpc              randconfig-r1300-20260920    gcc-9.5.0  sparse
powerpc              randconfig-r2105-20260918    clang-24
powerpc                      stx_gp3_defconfig    gcc-16.1.0
powerpc                      tqm5200_defconfig    gcc-16.1.0
powerpc                      tqm8541_defconfig    clang-24
powerpc64             randconfig-1000-20260920    clang-24
powerpc64             randconfig-1001-20260920    clang-22
riscv                             alldefconfig    gcc-16.1.0
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    gcc-16.1.0
riscv                             allyesconfig    clang-24
riscv                                defconfig    clang-24
riscv                 randconfig-1000-20260919    clang-24
riscv                 randconfig-1000-20260920    gcc-13.4.0
riscv                 randconfig-1001-20260919    clang-17
riscv                 randconfig-1001-20260920    gcc-15.2.0
riscv                 randconfig-2000-20260918    gcc-13.4.0
riscv                 randconfig-2000-20260919    gcc-13.4.0
riscv                 randconfig-2001-20260918    gcc-13.4.0
riscv                 randconfig-2001-20260919    clang-24
riscv                randconfig-r1306-20260920    gcc-9.5.0  sparse
riscv                randconfig-r2102-20260918    clang-22
s390                              allmodconfig    clang-24
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    clang-18
s390                  randconfig-1000-20260919    clang-24
s390                  randconfig-1000-20260920    gcc-8.5.0
s390                  randconfig-1001-20260919    clang-19
s390                  randconfig-1001-20260920    clang-20
s390                  randconfig-2000-20260918    gcc-13.4.0
s390                  randconfig-2000-20260919    gcc-9.5.0
s390                  randconfig-2001-20260918    gcc-13.4.0
s390                  randconfig-2001-20260919    clang-17
s390                 randconfig-r1301-20260920    gcc-8.5.0  sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    gcc-16.1.0
sh                                allyesconfig    gcc-16.1.0
sh                                   defconfig    gcc-16.1.0
sh                      magicpanelr2_defconfig    gcc-16.1.0
sh                    randconfig-1000-20260919    gcc-15.2.0
sh                    randconfig-1000-20260920    gcc-16.1.0
sh                    randconfig-1001-20260919    gcc-9.5.0
sh                    randconfig-1001-20260920    gcc-10.5.0
sh                    randconfig-2000-20260918    gcc-13.4.0
sh                    randconfig-2000-20260919    gcc-16.1.0
sh                    randconfig-2001-20260918    gcc-13.4.0
sh                    randconfig-2001-20260919    gcc-14.3.0
sh                   randconfig-r1301-20260920    gcc-16.1.0 sparse
sh                   randconfig-r1304-20260920    gcc-14.3.0 sparse
sh                   randconfig-r1306-20260920    gcc-16.1.0 sparse
sh                   randconfig-r1307-20260920    gcc-12.5.0 sparse
sh                   randconfig-r2200-20260918    gcc-16.1.0
sh                       rts7751r2d1_defconfig    gcc-16.1.0
sh                            se7750_defconfig    gcc-16.1.0
sh                   sh7785lcr_32bit_defconfig    gcc-16.1.0
sparc                              allnoconfig    gcc-16.1.0
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260919    gcc-11.5.0
sparc                 randconfig-1000-20260920    gcc-12.5.0
sparc                 randconfig-1001-20260919    gcc-16.1.0
sparc                 randconfig-1001-20260920    gcc-14.3.0
sparc                 randconfig-2000-20260918    gcc-14
sparc                 randconfig-2000-20260918    gcc-8.5.0
sparc                 randconfig-2001-20260918    gcc-11.5.0
sparc                 randconfig-2001-20260918    gcc-14
sparc                randconfig-r1300-20260920    gcc-8.5.0  sparse
sparc                randconfig-r1302-20260920    gcc-8.5.0  sparse
sparc                randconfig-r2104-20260918    clang-24
sparc                randconfig-r2106-20260918    clang-24
sparc                randconfig-r2200-20260919    gcc-13.4.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    clang-24
sparc64               randconfig-1000-20260920    gcc-13.4.0
sparc64               randconfig-1001-20260920    clang-24
sparc64               randconfig-2000-20260918    gcc-14
sparc64               randconfig-2000-20260918    gcc-8.5.0
sparc64               randconfig-2001-20260918    clang-20
sparc64               randconfig-2001-20260918    gcc-14
sparc64              randconfig-r1305-20260920    gcc-13.4.0 sparse
sparc64              randconfig-r1307-20260920    gcc-13.4.0 sparse
sparc64              randconfig-r2103-20260918    clang-22
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-17
um                                allyesconfig    gcc-14
um                                   defconfig    clang-24
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260920    clang-21
um                    randconfig-1001-20260920    clang-17
um                    randconfig-2000-20260918    gcc-14
um                    randconfig-2001-20260918    gcc-14
um                   randconfig-r1303-20260920    gcc-14     sparse
um                   randconfig-r1304-20260920    gcc-12     sparse
um                   randconfig-r1306-20260920    gcc-14     sparse
um                            x86_64_defconfig    clang-24
x86_64                             allnoconfig    clang-22
x86_64      buildonly-randconfig-1000-20260920    gcc-14
x86_64      buildonly-randconfig-1001-20260920    gcc-14
x86_64      buildonly-randconfig-1002-20260920    gcc-14
x86_64      buildonly-randconfig-1003-20260920    clang-22
x86_64      buildonly-randconfig-1004-20260920    clang-22
x86_64      buildonly-randconfig-1005-20260920    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20260920    clang-22
x86_64                randconfig-1001-20260920    gcc-14
x86_64                randconfig-1002-20260920    clang-22
x86_64                randconfig-1003-20260920    gcc-14
x86_64                randconfig-1004-20260920    gcc-14
x86_64                randconfig-1005-20260920    clang-22
x86_64                randconfig-1012-20260920    clang-22
x86_64                randconfig-1013-20260920    gcc-14
x86_64                randconfig-1014-20260920    gcc-14
x86_64                randconfig-1015-20260920    clang-22
x86_64                randconfig-1016-20260920    clang-22
x86_64                randconfig-1017-20260920    clang-22
x86_64                randconfig-2100-20260918    clang-22
x86_64                randconfig-2101-20260918    clang-22
x86_64                randconfig-2102-20260918    clang-22
x86_64                randconfig-2103-20260918    clang-22
x86_64                randconfig-2200-20260918    gcc-14
x86_64                randconfig-2200-20260919    clang-22
x86_64               randconfig-r1309-20260920    gcc-14     sparse
x86_64               randconfig-r2100-20260918    clang-22
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                            rhel-9.4-ltp    clang-22
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    gcc-16.1.0
xtensa                            allyesconfig    gcc-16.1.0
xtensa                   cadence_csp_defconfig    gcc-16.1.0
xtensa                randconfig-1000-20260920    gcc-10.5.0
xtensa                randconfig-1001-20260920    gcc-8.5.0
xtensa                randconfig-2000-20260918    gcc-14
xtensa                randconfig-2000-20260918    gcc-8.5.0
xtensa                randconfig-2001-20260918    gcc-13.4.0
xtensa                randconfig-2001-20260918    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
