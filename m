Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCBA606A31D
	for <intel-wired-lan@archiver.kernel.org>; Thu, 29 Oct 2026 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=dZfhy/ie;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VlY10yq3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5ABBB40756;
	Thu, 29 Oct 2026 09:50:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BQYHfgAwLa7b; Thu, 29 Oct 2026 09:50:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 61020406E3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793267445;
	b=Tfj/T4MjbrFLeuSavQ8UyvUcnLTVGHfdj17LZ/L33osYlCJzafK7zGrnfnMH0ZYU9zdK
	 tQQ6KROZ3upxOaajpAU2LRBc/BqS2sVVLY5VlsjcEXanp7FxeNloLAQ1XEu8Q/u6z7E9S
	 CnDcymuR8SZ+gqkMhJIlWrt35nc2ImXTfTIu2UQ3cKHJBS4xE/2t25YK6s4tGvQAmedR4
	 PwkazRy14p1f1DytTXuMzSI9Qneb35savn5PEso1EzfGNb3T90xKWzxxZM0JORaITiCED
	 f2gAQ4uP7naCIcAEZerajxCt6CxkKyAPxVefEwStZWQO4UyCvghWN18j5N6CGvEruAQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793267445;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=1tUKHCmjq3tfavcCAYVyZ6dL2kwD8Afjq6ygkdUyJ08=;
	b=XXgWBVY8+thAr6hve20wEa+Xc1MsCtZn9oCIFJBRClkkzRLLmty7bWqjt24xIiwfDqj7
	 4sXYu/3eSXPBraQDWYfwxtaJbM1j+dVbWVTVWOJzT9jjfdYzSjY86fTNT15rxJ/zC/l2B
	 Jo7ICcvcbt6WalSn4RNBDJQ82NDANihhsIbeME5/JqAsqAy6aK8kiLW1AfU7bJMqaK9es
	 LRQ0rwYpvgGVWruvKEl3CkNkCWE/XU5/QfIKtXbfcErk7BZLF8JDMcBcxv4HUyvO4bnko
	 XJk+uDPjdlPQw9wi7OPZhYv0tCxVqq9kkV+HOL+KBtP3wXPwWBALHqg1hvwFU1uzfvg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VlY10yq3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793267445;
	bh=1tUKHCmjq3tfavcCAYVyZ6dL2kwD8Afjq6ygkdUyJ08=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dZfhy/iez13ZXxuaHxuqcOTAmv5jJnRtwmf7GbALsfo93/62PlmpKPsSZ19VH7qNN
	 +V6AIsmkehpOtx4nLiymOPDhalk0ULsqz5F0DepmnuSlM1tn0fb49PwL1i3M2wCY3P
	 j8VPJbkljo2GOgieHctLPlGwN9OsDGTE4iRdrzS4Avkoi5OGgy0IfkEaZOwgDtKyaU
	 Vk7WYirhDP2hg8JgPYOGR4bPPjb/EhSu2sFIhWf2F3wgorCkSkCMynHW/tGm04oTfu
	 cHDjcHpt6Odv9+tINT/ctWh6IO5wCtwEB9SLWSFzm4S57T28NiznekDkKi6YNK2Sr+
	 aZY3pNLOHuwYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 61020406E3;
	Thu, 29 Oct 2026 09:50:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 00361D22
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 09:50:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DA15A406E3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 09:50:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mlmmhtIrkLO8 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 29 Oct 2026 09:50:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EE152406AF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793267443;
 b=TQrJWxdk3wbcRqmPR0kB9TtTGs75FesaEqkrbBmx4wgX9nFd2lVMo6NIwop7V8GQe2RN
 gdRA6PyHRU897nBzTS9vID/0BZTesrq6g2piwDqVDaZTB/aCaqfCE1XRq0E7eOqCApRts
 EIIIelMT+DFwYPqsLsx92OSZQeLtg2cTdVr++s3iUBhlqxXYlxP0vLJTsmtWs45rGmkc0
 Jaodlw8zglIIp9djJ2ulyHNkE+NfAifzpTjiGrkgnF3+Oz8fhAFbOL0+Xlhg3g8H8ov1f
 ZtqhnvdEz6a9GzCprdAebVlnSnXZIR6QWSof4ECP1RXUIOp0iUe49ItHam8MJTJ2Bhw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793267443;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=1tUKHCmjq3tfavcCAYVyZ6dL2kwD8Afjq6ygkdUyJ08=;
 b=SaWYnLY3FPRZIQXn4IsUUhu+XqtKDjbrrP/DtwToYXCeyJbklb9driA0BZg/Rt96/wtk
 jCunDnzLt7zb67u4skFco4uiFBnu/bb+n33vHtD5SOiz08chjatf92ngWoOcIDWmM2Ped
 ufoLWkt1jRflZgQccwJPflOCWOxk+Z5EyDG2aAxpiP1g1YoMJuoQZ3BBW6Kg99Y6OVX4j
 6pyh8TJckmj3VtXCYAPBX7cxNWl30gOe2FEdP51tKMlLywRKIDJ72hk7D+cfr3nv3+3eS
 AHJOiKyWOttggmdqW/XG16rBB4YGfYf+5VjmoPR8iReDHZRO/R7EiYX+YqveDDYYUOw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=VlY10yq3; 
 arc=none smtp.remote-ip=198.175.65.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=VlY10yq3
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EE152406AF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 09:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793267443; x=1824803443; h=date:from:to:subject:message-id;
 bh=SkG/kUAtlz4DZnXGYSYlNwvoXgZvSQfMtYWxmswQNM8=;
 b=VlY10yq3huPvidGDt0SkYlw2k3SlGgP5l2xMhQUwwh3oG/n8iBOysEAI
 ACGwrR0Q0Y1UkQiuLFMmSFDyuV4SH8Mge07zE3zZmqT3l3kn2/NCTUJ8N
 n7q/Qz8WY61ooYQsJ0oPuiR/RDMmhjhlnnh1IGBFFWN21nYRFSk5K5HQ3
 zF9IGdJNDewO0q69ohoVlQkWvIgJxdmNdPK3tv0chPxyUdbjJB0WtiyZr
 na4DJJVD/K+gM407xmX1V4xYGF/sWECim04wjSeUWYCA7M7Alx9ByBUfY
 llY2q0Ot8f+zJgcQiwCrLEvCKunNMkg9G8gzooEcBmjfKBpJ7KLXHXQFa w==;
X-CSE-ConnectionGUID: 3c33jJYYSeu67F2zQD1Nog==
X-CSE-MsgGUID: itxIBj+rTbieBGUzYZ8S5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2016457"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2016457"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 02:50:42 -0700
X-CSE-ConnectionGUID: kEXQH4kkT9WzwpU7ECBfuA==
X-CSE-MsgGUID: 47yFzPs1T6Spt1aL9QDzTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5431168"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa008.fm.intel.com with ESMTP; 29 Oct 2026 02:50:41 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xMMmM-00000000ZvE-20aG;
 Thu, 29 Oct 2026 09:50:38 +0000
Date: Thu, 29 Oct 2026 17:50:17 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:dev-queue] BUILD SUCCESS
 44857ae0a6816509acfdf63e826cc9ec58802db2
Message-ID: <202610291713.f2db6DCo-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 44857ae0a6816509acfdf63e826cc9ec58802db2  ice: quiesce PTP periodic work before system suspend

elapsed time: 2093m

configs tested: 108
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                    allnoconfig    gcc-16.2.0
alpha                   allyesconfig    gcc-16.2.0
arc                     allmodconfig    gcc-16.2.0
arc                      allnoconfig    gcc-16.2.0
arc                     allyesconfig    gcc-16.2.0
arm                      allnoconfig    clang-17
arm                     allyesconfig    gcc-16.2.0
arm                  imxrt_defconfig    gcc-16.2.0
arm64                    allnoconfig    gcc-16.2.0
arm64       randconfig-1000-20261029    gcc-8.5.0
arm64       randconfig-1001-20261029    gcc-8.5.0
arm64       randconfig-1002-20261029    gcc-8.5.0
arm64       randconfig-1003-20261029    gcc-8.5.0
csky                    allmodconfig    gcc-16.2.0
csky                     allnoconfig    gcc-16.2.0
csky        randconfig-1000-20261029    gcc-8.5.0
csky        randconfig-1001-20261029    gcc-8.5.0
hexagon                 allmodconfig    clang-24
hexagon                  allnoconfig    clang-24
i386                    allmodconfig    gcc-14
i386                     allnoconfig    gcc-14
i386                    allyesconfig    gcc-14
i386        randconfig-1000-20261029    clang-22
i386        randconfig-1001-20261029    clang-22
i386        randconfig-1002-20261029    clang-22
i386        randconfig-1003-20261029    clang-22
i386        randconfig-1004-20261029    clang-22
i386        randconfig-1005-20261029    clang-22
i386        randconfig-1006-20261029    clang-22
loongarch                allnoconfig    clang-20
m68k                    allmodconfig    gcc-16.2.0
m68k                     allnoconfig    gcc-16.2.0
m68k                    allyesconfig    gcc-16.2.0
microblaze               allnoconfig    gcc-16.2.0
microblaze              allyesconfig    gcc-16.2.0
mips                    allmodconfig    gcc-16.2.0
mips                     allnoconfig    gcc-16.2.0
mips                    allyesconfig    gcc-16.2.0
mips                  ip32_defconfig    gcc-16.2.0
mips                  mtx1_defconfig    gcc-16.2.0
nios2                   allmodconfig    gcc-11.5.0
nios2                    allnoconfig    clang-24
nios2                    allnoconfig    gcc-11.5.0
openrisc                 allnoconfig    clang-24
openrisc                 allnoconfig    gcc-16.2.0
openrisc                   defconfig    gcc-16.2.0
parisc                  allmodconfig    gcc-16.2.0
parisc                   allnoconfig    clang-24
parisc                   allnoconfig    gcc-16.2.0
parisc                  allyesconfig    gcc-16.2.0
parisc                     defconfig    gcc-16.2.0
parisc      randconfig-1000-20261029    clang-17
parisc      randconfig-1001-20261029    clang-17
powerpc                 allmodconfig    gcc-16.2.0
powerpc                  allnoconfig    clang-24
powerpc                  allnoconfig    gcc-16.2.0
powerpc               icon_defconfig    gcc-16.2.0
powerpc         iss476-smp_defconfig    gcc-16.2.0
powerpc        mpc8315_rdb_defconfig    gcc-16.2.0
powerpc     randconfig-1000-20261029    clang-17
powerpc     randconfig-1001-20261029    clang-17
powerpc64   randconfig-1000-20261029    clang-17
powerpc64   randconfig-1001-20261029    clang-17
riscv                    allnoconfig    clang-24
riscv                    allnoconfig    gcc-16.2.0
riscv                   allyesconfig    clang-24
riscv                      defconfig    gcc-16.2.0
s390                     allnoconfig    clang-24
s390                    allyesconfig    gcc-16.2.0
s390                       defconfig    gcc-16.2.0
sh                      allmodconfig    gcc-16.2.0
sh                       allnoconfig    clang-24
sh                       allnoconfig    gcc-16.2.0
sh                      allyesconfig    gcc-16.2.0
sh                ap325rxa_defconfig    gcc-16.2.0
sh                         defconfig    gcc-14
sh          sh7724_generic_defconfig    gcc-16.2.0
sparc                    allnoconfig    clang-24
sparc                    allnoconfig    gcc-16.2.0
sparc                      defconfig    gcc-16.2.0
sparc       randconfig-1000-20261029    clang-24
sparc       randconfig-1001-20261029    clang-24
sparc64                    defconfig    gcc-14
sparc64     randconfig-1000-20261029    clang-24
sparc64     randconfig-1001-20261029    clang-24
um                       allnoconfig    clang-17
um                       allnoconfig    clang-24
um                      allyesconfig    gcc-14
um                         defconfig    gcc-14
um                    i386_defconfig    gcc-14
um          randconfig-1000-20261029    clang-24
um          randconfig-1001-20261029    clang-24
um                  x86_64_defconfig    gcc-14
x86_64                   allnoconfig    clang-22
x86_64                   allnoconfig    clang-24
x86_64                     defconfig    gcc-14
x86_64                         kexec    clang-22
x86_64                      rhel-9.4    clang-22
x86_64                  rhel-9.4-bpf    gcc-14
x86_64                 rhel-9.4-func    clang-22
x86_64           rhel-9.4-kselftests    clang-22
x86_64                rhel-9.4-kunit    gcc-14
x86_64                  rhel-9.4-ltp    gcc-14
x86_64                 rhel-9.4-rust    clang-22
xtensa                   allnoconfig    clang-24
xtensa                   allnoconfig    gcc-16.2.0
xtensa      randconfig-1000-20261029    clang-24
xtensa      randconfig-1001-20261029    clang-24

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
