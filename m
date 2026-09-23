Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BE5C982FA
	for <intel-wired-lan@archiver.kernel.org>; Wed, 23 Sep 2026 03:15:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F298080D89;
	Wed, 23 Sep 2026 03:15:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xO_hKk4MMmiL; Wed, 23 Sep 2026 03:15:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 039B180D48
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790133304;
	b=JyIsRh50AxXCy3Lt8CyIPGo9ZcYjfs6a/sMolffvLzSx2F/Ycs8hxuyX8gY3BJZzQF8G
	 SNaDkx0l4CMvwtQvMJ5EVQkCeLnzhesk8WDUjpoX4jV8F8yFEnnh8v0bj1WKtnY9optP2
	 GQ4Kljdzy7i930og95JkqN2MaN7EnDEFaR0ad44WG+qfM7F7w+ARoyBfmOV7kmkzEAsh2
	 0x1HEOhY4CtExBiW1LtbLhRyGUANdP2VdubI5a6gjaBmC63zzcmTzPScaiaw6/yxkOL2C
	 67CBJC6U/m/kGkm9oji6nNNdtucO+eslGf9a3Xpz47yy5687qBXgEFtJQqfGgymEawg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790133304;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=YZxhsqaZK+n9BG6JBfxlrF5FA9cveTxfVyduH1R2fPY=;
	b=CVe0MqLzA5XdJoUK2Q6z8SKYe1hwS+cXYj0q9E9za7nG5iNa76iAmKLYtT536Yh+PQZT
	 0m3+P5k+kpwsUfofk5mEgC/7XicIiKb324RBdibj/piAAgFVs/EM3CO3ud0pKtjKNLLHr
	 KcGKXKZt/CExYxmvlMW8jSySikPV8SltoiAk2e6Fv7jI+wJiQv7vZr6NtNlZ1ybvjap7k
	 lN7e7OxCgvLJ0eLBZcItXr/tYRULHRvjieH8zELCTzau9ObWUWOdKO9UariuK+Xf6YilV
	 LUHdCyhpjNuojdD+LuEp3+lXH+xVF2AT2OsI2IXUQAVz0e4P3tiUF4wx6aMXgFliKkA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790133304;
	bh=YZxhsqaZK+n9BG6JBfxlrF5FA9cveTxfVyduH1R2fPY=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BAInFm5NlEC2AxxiNXXR49DRjKb+4PBm0fYw9VTDQiI5kZQffWYraHVYbd4Cc9NFu
	 HhZwQxm3EbJv5aTCje/14nNPyHVq9+kDud4eJMj3TaKhLopBaunciFa/4PVpEXUhRO
	 GC1JQR0IWc1MMTm03zpDybVSDJFy92eCwp8bqVsnlYNhmibAJXIPiPKYuharQo79Re
	 nY+g7F4+sjQ4utkRscwT/n0YsGeJudpGmw4Zxb6gZg/vfAnwMj4R/8SXlskKj/I2pj
	 7TflLFeasX6CEoytI0FCth9sjrLIdU1vh3suc0XccgH/nsSTrJJWZKRpmww+bqsnO4
	 7jZkSKt02v/vA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 039B180D48;
	Wed, 23 Sep 2026 03:15:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EB5113A9
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Sep 2026 03:15:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E8AFB40317
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Sep 2026 03:15:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d0-2vlqMd-I2 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 23 Sep 2026 03:15:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8CA6B4031F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790133300;
 b=o2UiiPuOQm69/8QOhE+seEvPY06z95zWqGVbe3r2nKbs+NAHHD9U+kMBbdTCYwmnS7IY
 gZtUXMo6LexdNkTHHSfz1KOWh3Oc/AcRFGiAprBrYhPeKcFraIQ2J7871rblbXdCtBVyn
 koAqAMMGWo9ZzGCzAXCzsuaOv1W9i5B4jzxlW4buqqypyEpM+O0Ng1ZLCVDhG8MS+9Qha
 jwKA/gIEnGgPkptAVvBWaoIeruT/Mxl3QFp8VXuZK8jdPmB2kvRok+XHS57b1iEYfKbB8
 gGEJW6d21hvSt6aZUAMkPQdKI1U0lZZEGSNTA3OIva0wlVUcIAJefRY+OoB4vofiKwA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790133300;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=YZxhsqaZK+n9BG6JBfxlrF5FA9cveTxfVyduH1R2fPY=;
 b=ivYLeAaURr/kPknbueY71AlTxrO88QWeXxNxjjUOYWX6wk4wJkORyqYOR7ygpAQO/2ch
 RuP2Oig/8jZxPsIwwLPluGEp7oXXqOhwDdfz7810DiUx9xDxCli6RQdj0QRqD7ogOEFj+
 grJftZTd1V51svG4eou9jFirOpN6kG25CmVxmr4IRqW2EQJv+SCuOenysaPPZZ7+O4nrg
 hEuLLW0e9cNPlmmOU+4FLi0e/IZ+aEgysw3wRX3cyAdwA/quW6B0wH/uwOK/vgCh2AbkR
 HFa/WyEJSdXlvkYnRvaNXqN9odhw/l6g45PHZuPjrNrQDAY9aAT8GFRVInQZl96CqXg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=K8yUV1Vv; 
 arc=none smtp.remote-ip=192.198.163.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=K8yUV1Vv
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8CA6B4031F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Sep 2026 03:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790133300; x=1821669300; h=date:from:to:subject:message-id;
 bh=bCF5+U8COG3NJnVFLYJLo8j0DMQVG0u7UIQqdoZpgJA=;
 b=K8yUV1Vv9vBKuT/y0MbPOvpo2+PMaK86p+UjJzzumr+4pkxTKhNe1ZZI
 6DUTjYF1gFM6mJ4bf9Z1sIQzlex6vmf/p9p+hVGt8PcxWdibhaHldL9GZ
 LbWobhipral8w4efObI4HNpLDEzCv/91bhzuiFNAHRFnW3woWfXuD9Rls
 nwQdKdssGQ7gpTmtNhHCknScw4ZY/RbyRy6OsEtGZbsav0TgX3ngPdPZC
 3ZVZRDptj0lD2qpadsJJjdnOCPi3+yA5uE+aH3Y8C56/Ca6COcoglBTvw
 a0zdovKmD7cpcAQgOWWiFiAyoV0f3i1qGUEGYWjmAtA4azCBjAbLi0QMO g==;
X-CSE-ConnectionGUID: mlZSlXU4RzGUqx4mX3PKMg==
X-CSE-MsgGUID: zVRR1Cm2SCWmjvAsHurEyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="89711094"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; d="scan'208";a="89711094"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 20:14:58 -0700
X-CSE-ConnectionGUID: 8UVL/Az9SdSrq2zrRsi4og==
X-CSE-MsgGUID: dFsDcoMRSgKCu9RNKH9P0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; d="scan'208";a="273594181"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by fmviesa008.fm.intel.com with ESMTP; 22 Sep 2026 20:14:56 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x9DRd-00000000GSv-04h1;
 Wed, 23 Sep 2026 03:14:53 +0000
Date: Wed, 23 Sep 2026 11:14:36 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:40GbE] BUILD SUCCESS
 405b7cacf541aa5f4dc0c2e98e212c4c3027ff1e
Message-ID: <202609231134.1HhmERnU-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 40GbE
branch HEAD: 405b7cacf541aa5f4dc0c2e98e212c4c3027ff1e  i40e: trigger PF reset when re-enabling ATR via ethtool

elapsed time: 5050m

configs tested: 188
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
arc                               allmodconfig    gcc-16.1.0
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20260920    gcc-8.5.0
arc                   randconfig-1001-20260920    gcc-8.5.0
arc                  randconfig-r1305-20260920    gcc-11.5.0 sparse
arm                                allnoconfig    clang-17
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    gcc-16.1.0
arm                                  defconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                   randconfig-1000-20260920    gcc-10.5.0
arm                   randconfig-1001-20260920    gcc-12.5.0
arm                   randconfig-1002-20260920    clang-20
arm                   randconfig-1003-20260920    gcc-16.1.0
arm                           sp7021_defconfig    gcc-16.1.0
arm                        versatile_defconfig    gcc-16.1.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260920    gcc-15.2.0
arm64                 randconfig-1001-20260920    clang-24
arm64                 randconfig-1002-20260920    gcc-8.5.0
arm64                 randconfig-1003-20260920    clang-24
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260920    gcc-12.5.0
csky                  randconfig-1001-20260920    gcc-14.3.0
hexagon                           allmodconfig    clang-24
hexagon                            allnoconfig    clang-24
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    clang-24
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260920    clang-17
hexagon               randconfig-1001-20260920    clang-19
i386                               allnoconfig    gcc-14
i386                               allnoconfig    gcc-16.1.0
i386                                 defconfig    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20260920    clang-22
i386                  randconfig-1001-20260920    gcc-14
i386                  randconfig-1002-20260920    gcc-14
i386                  randconfig-1003-20260920    clang-22
i386                  randconfig-1004-20260920    gcc-14
i386                  randconfig-1005-20260920    gcc-14
i386                  randconfig-1006-20260920    clang-22
i386                 randconfig-r1306-20260920    gcc-14     sparse
loongarch                         allmodconfig    clang-19
loongarch                          allnoconfig    clang-20
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260920    gcc-16.1.0
loongarch             randconfig-1001-20260920    gcc-16.1.0
loongarch            randconfig-r1306-20260919    gcc-16.1.0 sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                                 defconfig    gcc-16.1.0
m68k                 randconfig-r1304-20260920    gcc-14.3.0 sparse
m68k                 randconfig-r1309-20260919    gcc-15.2.0 sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze                           defconfig    gcc-16.1.0
microblaze           randconfig-r1307-20260920    gcc-16.1.0 sparse
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                            rs90_defconfig    gcc-16.1.0
nios2                             allmodconfig    gcc-11.5.0
nios2                              allnoconfig    clang-24
nios2                              allnoconfig    gcc-11.5.0
nios2                                defconfig    clang-24
nios2                                defconfig    gcc-11.5.0
nios2                 randconfig-1000-20260920    gcc-8.5.0
nios2                 randconfig-1001-20260920    gcc-8.5.0
openrisc                          allmodconfig    gcc-16.1.0
openrisc                           allnoconfig    clang-24
openrisc                           allnoconfig    gcc-16.1.0
openrisc                             defconfig    gcc-16.1.0
openrisc                  simple_smp_defconfig    gcc-16.1.0
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                             allnoconfig    gcc-16.1.0
parisc                            allyesconfig    gcc-16.1.0
parisc                               defconfig    gcc-16.1.0
parisc                 generic-64bit_defconfig    gcc-16.1.0
parisc                randconfig-1000-20260920    gcc-14.3.0
parisc                randconfig-1001-20260920    gcc-8.5.0
parisc64                             defconfig    clang-24
parisc64                             defconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                            allnoconfig    gcc-16.1.0
powerpc                     ge_imp3a_defconfig    gcc-16.1.0
powerpc                  mpc837x_rdb_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20260920    gcc-8.5.0
powerpc               randconfig-1001-20260920    clang-24
powerpc              randconfig-r1301-20260920    clang-24   sparse
powerpc              randconfig-r1309-20260920    gcc-8.5.0  sparse
powerpc64             randconfig-1000-20260920    clang-24
powerpc64             randconfig-1001-20260920    clang-22
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                              allnoconfig    gcc-16.1.0
riscv                             allyesconfig    clang-24
riscv                                defconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20260920    gcc-13.4.0
riscv                 randconfig-1001-20260920    gcc-15.2.0
s390                              allmodconfig    clang-24
s390                               allnoconfig    clang-24
s390                                 defconfig    clang-18
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20260920    gcc-8.5.0
s390                  randconfig-1001-20260920    clang-20
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                 allnoconfig    gcc-16.1.0
sh                                allyesconfig    gcc-16.1.0
sh                         apsh4ad0a_defconfig    gcc-16.1.0
sh                                   defconfig    gcc-14
sh                                   defconfig    gcc-16.1.0
sh                    randconfig-1000-20260919    gcc-15.2.0
sh                    randconfig-1000-20260920    gcc-16.1.0
sh                    randconfig-1001-20260919    gcc-9.5.0
sh                    randconfig-1001-20260920    gcc-10.5.0
sh                   randconfig-r1303-20260920    gcc-16.1.0 sparse
sh                   randconfig-r1308-20260920    gcc-10.5.0 sparse
sparc                              allnoconfig    clang-24
sparc                              allnoconfig    gcc-16.1.0
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260919    gcc-11.5.0
sparc                 randconfig-1001-20260919    gcc-16.1.0
sparc                randconfig-r1302-20260920    gcc-8.5.0  sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    clang-24
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260919    clang-20
sparc64               randconfig-1001-20260919    clang-22
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-14
um                                   defconfig    clang-24
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260919    clang-24
um                    randconfig-1001-20260919    gcc-12
um                   randconfig-r1300-20260920    clang-19   sparse
um                            x86_64_defconfig    clang-24
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64      buildonly-randconfig-1000-20260920    gcc-14
x86_64      buildonly-randconfig-1001-20260920    gcc-14
x86_64      buildonly-randconfig-1002-20260920    gcc-14
x86_64      buildonly-randconfig-1003-20260920    clang-22
x86_64      buildonly-randconfig-1004-20260920    clang-22
x86_64      buildonly-randconfig-1005-20260920    gcc-14
x86_64                               defconfig    gcc-14
x86_64                randconfig-1000-20260920    clang-22
x86_64                randconfig-1001-20260920    gcc-14
x86_64                randconfig-1002-20260920    clang-22
x86_64                randconfig-1003-20260920    gcc-14
x86_64                randconfig-1004-20260920    gcc-14
x86_64                randconfig-1005-20260920    clang-22
x86_64                randconfig-1006-20260919    clang-22
x86_64                randconfig-1007-20260919    clang-22
x86_64                randconfig-1008-20260919    clang-22
x86_64                randconfig-1009-20260919    gcc-14
x86_64                randconfig-1010-20260919    clang-22
x86_64                randconfig-1011-20260919    clang-22
x86_64                randconfig-1012-20260920    clang-22
x86_64                randconfig-1013-20260920    gcc-14
x86_64                randconfig-1014-20260920    gcc-14
x86_64                randconfig-1015-20260920    clang-22
x86_64                randconfig-1016-20260920    clang-22
x86_64                randconfig-1017-20260920    clang-22
xtensa                             allnoconfig    clang-24
xtensa                             allnoconfig    gcc-16.1.0
xtensa                            allyesconfig    gcc-16.1.0
xtensa                randconfig-1000-20260919    gcc-13.4.0
xtensa                randconfig-1001-20260919    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
