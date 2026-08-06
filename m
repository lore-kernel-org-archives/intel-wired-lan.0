Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EAEC56207
	for <intel-wired-lan@archiver.kernel.org>; Thu,  6 Aug 2026 14:34:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C0DD80BEC;
	Thu,  6 Aug 2026 14:34:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EP48KzrS6LX6; Thu,  6 Aug 2026 14:34:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0410C80C48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786026858;
	bh=eZ7SQqf3t6hZ+FkEqV2oBD1LqLIv1EEZNLPQefaf3jU=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Pz4V8TyWo69ix/JKVM55MkzgSm2buWto7+YdXNGyIDpi98nEAuVQV4XZ8mplzMbxr
	 GAvcfEVDPl9YqRB485xphvGYvo67/Ig2mD9nljtu6V8p3qYPzUL1logLjCQUOQuxyA
	 PnXd1UGlSb7G5N3akzYBAeXdmCWujwmo/LOp3SWX9JesJHSVoUQuCmeXji3ftPp8OA
	 yCK9K6FfB7Cpx742Y0HVFZ6WAlIMr8HBIZrYMMdZnPq112DBSKjOpNhAF5SYUuNAWU
	 WCk5Ti/ffAvyWS6+TbMYaxcuGsrxxYMuvKf7xweOdxtTb8YDPewNIcfukKBzyMfpEF
	 0QIkgbX989maw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0410C80C48;
	Thu,  6 Aug 2026 14:34:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DA6AB2B6
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 14:34:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D7BFA80C48
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 14:34:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 77KeZo9Z1qBL for <intel-wired-lan@lists.osuosl.org>;
 Thu,  6 Aug 2026 14:34:16 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C311480BEC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C311480BEC
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C311480BEC
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 14:34:15 +0000 (UTC)
X-CSE-ConnectionGUID: 1xNdUk3RS8SiyveBjVjIKQ==
X-CSE-MsgGUID: DhZcG4A3SyO7JVnh+Or9VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86565439"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="86565439"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 07:34:15 -0700
X-CSE-ConnectionGUID: iQPkkF35Ttu5/LVy/CNkPw==
X-CSE-MsgGUID: OTJEUcgxSuCjHhtBJyIJow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="261591126"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by orviesa008.jf.intel.com with ESMTP; 06 Aug 2026 07:34:13 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wrzAh-00000000FLk-2B5Y;
 Thu, 06 Aug 2026 14:34:11 +0000
Date: Thu, 06 Aug 2026 22:33:26 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202608062215.aVNtbMA1-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786026856; x=1817562856;
 h=date:from:to:subject:message-id;
 bh=XD4jUsaifqeF5coI4emdCKzw10t+mS1+W/QN2T0cBLs=;
 b=keCmvXBKFRd+lfai8E8+n0G0n3uBfsjy2ZV0YUGUCxoNn9hl43VCYXOe
 h6POcMTVRJySdVhK62fUjFic5/PzcSkOPBo1JlragD5OCcVbeDHUOZSKb
 xHw/9c00lMaS8RGnUmf5ix9g0AeRCKQ5BbjWrWhdkXoT+qgpXdO4QAuog
 fn6NGxSo1LAazvxpz5oSYognyLmTFbQGY4HgkPKohTrv8+DjaLrWU8Qef
 f9wkASHMAY8GXL7+Mz2d7f659Q/Cgc2v81FMuluiQHOu47buPgIQgKxTL
 pWWORPyTBJOLx86aybz+56DCF9/33bf74VAyBt9IOTB7tJhmeouEiod9L
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=keCmvXBK
Subject: [Intel-wired-lan] [tnguy-net-queue:40GbE] BUILD SUCCESS
 1e945a8131e44bcdfb7a5fd6866c97d7ae75bf9c
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 40GbE
branch HEAD: 1e945a8131e44bcdfb7a5fd6866c97d7ae75bf9c  igc: fix netdev not re-attached after resume if interface is down

elapsed time: 1581m

configs tested: 147
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                           randconfig-001    gcc-8.5.0
arc                  randconfig-001-20260805    gcc-8.5.0
arc                  randconfig-001-20260806    gcc-11.5.0
arc                  randconfig-002-20260805    gcc-12.5.0
arc                  randconfig-002-20260806    gcc-11.5.0
arm                  randconfig-001-20260805    clang-24
arm                  randconfig-001-20260806    gcc-11.5.0
arm                  randconfig-002-20260805    clang-24
arm                  randconfig-002-20260806    gcc-11.5.0
arm                  randconfig-003-20260805    gcc-16.1.0
arm                  randconfig-003-20260806    gcc-11.5.0
arm                  randconfig-004-20260805    clang-24
arm                  randconfig-004-20260806    gcc-11.5.0
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260805    clang-24
arm64                randconfig-001-20260806    gcc-13.4.0
arm64                randconfig-002-20260805    gcc-8.5.0
arm64                randconfig-002-20260806    gcc-13.4.0
arm64                randconfig-003-20260805    clang-24
arm64                randconfig-003-20260806    gcc-13.4.0
arm64                randconfig-004-20260805    clang-24
arm64                randconfig-004-20260806    gcc-13.4.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260805    gcc-16.1.0
csky                 randconfig-001-20260806    gcc-13.4.0
csky                 randconfig-002-20260805    gcc-10.5.0
csky                 randconfig-002-20260806    gcc-13.4.0
hexagon                       randconfig-001    clang-17
hexagon              randconfig-001-20260805    clang-17
hexagon              randconfig-001-20260806    clang-24
hexagon              randconfig-002-20260805    clang-19
hexagon              randconfig-002-20260806    clang-24
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260806    gcc-14
i386       buildonly-randconfig-002-20260806    gcc-14
i386       buildonly-randconfig-003-20260806    gcc-14
i386       buildonly-randconfig-004-20260806    gcc-14
i386       buildonly-randconfig-005-20260806    gcc-14
i386       buildonly-randconfig-006-20260806    gcc-14
i386                          randconfig-001    clang-22
i386                 randconfig-001-20260805    clang-22
i386                 randconfig-001-20260806    clang-22
i386                 randconfig-002-20260805    clang-22
i386                 randconfig-002-20260806    clang-22
i386                 randconfig-003-20260805    gcc-14
i386                 randconfig-003-20260806    clang-22
i386                 randconfig-004-20260805    clang-22
i386                 randconfig-004-20260806    clang-22
i386                 randconfig-005-20260805    gcc-14
i386                 randconfig-005-20260806    clang-22
i386                 randconfig-006-20260805    gcc-13
i386                 randconfig-006-20260806    clang-22
i386                 randconfig-007-20260805    gcc-14
i386                 randconfig-007-20260806    clang-22
i386                 randconfig-011-20260806    clang-22
i386                 randconfig-012-20260806    clang-22
i386                 randconfig-013-20260806    clang-22
i386                 randconfig-014-20260806    clang-22
i386                 randconfig-015-20260806    clang-22
i386                 randconfig-016-20260806    clang-22
i386                 randconfig-017-20260806    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260805    clang-18
loongarch            randconfig-001-20260806    clang-24
loongarch            randconfig-002-20260805    clang-18
loongarch            randconfig-002-20260806    clang-24
m68k                      m5208evb_defconfig    gcc-16.1.0
mips                          ip28_defconfig    gcc-16.1.0
mips                          xway_defconfig    clang-19
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260805    gcc-10.5.0
nios2                randconfig-001-20260806    clang-24
nios2                randconfig-002-20260805    gcc-11.5.0
nios2                randconfig-002-20260806    clang-24
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260806    gcc-8.5.0
parisc               randconfig-002-20260806    gcc-8.5.0
powerpc              randconfig-001-20260806    gcc-8.5.0
powerpc              randconfig-002-20260806    gcc-8.5.0
powerpc64            randconfig-001-20260806    gcc-8.5.0
powerpc64            randconfig-002-20260806    gcc-8.5.0
riscv                         randconfig-001    gcc-13.4.0
riscv                randconfig-001-20260806    gcc-13.4.0
riscv                randconfig-002-20260806    gcc-13.4.0
s390                 randconfig-001-20260806    gcc-13.4.0
s390                 randconfig-002-20260806    gcc-13.4.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260806    gcc-13.4.0
sh                   randconfig-002-20260806    gcc-13.4.0
sparc                         randconfig-001    gcc-8.5.0
sparc                randconfig-001-20260805    gcc-16.1.0
sparc                randconfig-001-20260806    gcc-8.5.0
sparc                randconfig-002-20260805    gcc-11.5.0
sparc                randconfig-002-20260806    gcc-8.5.0
sparc64              randconfig-001-20260805    gcc-9.5.0
sparc64              randconfig-001-20260806    gcc-8.5.0
sparc64              randconfig-002-20260805    gcc-8.5.0
sparc64              randconfig-002-20260806    gcc-8.5.0
um                   randconfig-001-20260805    gcc-14
um                   randconfig-001-20260806    gcc-8.5.0
um                   randconfig-002-20260805    gcc-14
um                   randconfig-002-20260806    gcc-8.5.0
x86_64              buildonly-randconfig-001    clang-22
x86_64     buildonly-randconfig-001-20260806    clang-22
x86_64     buildonly-randconfig-002-20260806    clang-22
x86_64     buildonly-randconfig-003-20260806    clang-22
x86_64     buildonly-randconfig-004-20260806    clang-22
x86_64     buildonly-randconfig-005-20260806    clang-22
x86_64     buildonly-randconfig-006-20260806    clang-22
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260806    clang-22
x86_64               randconfig-002-20260806    clang-22
x86_64               randconfig-003-20260806    clang-22
x86_64               randconfig-004-20260806    clang-22
x86_64               randconfig-005-20260806    clang-22
x86_64               randconfig-006-20260806    clang-22
x86_64                        randconfig-011    clang-22
x86_64               randconfig-011-20260806    clang-22
x86_64               randconfig-012-20260806    clang-22
x86_64               randconfig-013-20260806    clang-22
x86_64               randconfig-014-20260806    clang-22
x86_64               randconfig-015-20260806    clang-22
x86_64               randconfig-016-20260806    clang-22
x86_64               randconfig-071-20260805    clang-22
x86_64               randconfig-071-20260806    gcc-14
x86_64               randconfig-072-20260805    gcc-14
x86_64               randconfig-072-20260806    gcc-14
x86_64               randconfig-073-20260805    gcc-13
x86_64               randconfig-073-20260806    gcc-14
x86_64               randconfig-074-20260805    clang-22
x86_64               randconfig-074-20260806    gcc-14
x86_64               randconfig-075-20260805    clang-22
x86_64               randconfig-075-20260806    gcc-14
x86_64               randconfig-076-20260805    clang-22
x86_64               randconfig-076-20260806    gcc-14
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260805    gcc-13.4.0
xtensa               randconfig-001-20260806    gcc-8.5.0
xtensa               randconfig-002-20260806    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
