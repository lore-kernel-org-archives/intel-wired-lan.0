Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BB3C982DA
	for <intel-wired-lan@archiver.kernel.org>; Sun, 20 Sep 2026 18:22:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D4BA780E73;
	Sun, 20 Sep 2026 18:22:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BaZ9_D24Sk4e; Sun, 20 Sep 2026 18:21:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1AD7180E6B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789928519;
	b=s/lAnex3JiW159xJodzU7nXGauW++YVVioghY2wCXJJ7hmBjO4/2wO79fBudA+5Czh0J
	 eTlAQaRzKVk8WKjfqhWQ8Jq4s8AAOAMh/drX35PtFAeU1J2ggRjhrVztLhBtuliobZmiw
	 6CpN9fpZDDo2Lp93HdeEQIsVUoLWCTfKGKNBJMnFws6XzZWzLxCsL6UwvwQGc7eKnw8f0
	 86z8AK7at2IIDyWPEJLKg32EyoCN1i5GK5+93o+KzBS1MrhVORE+TT166L4eBXgTMlr+C
	 MIydboB7R8vswCFGescNtegVyi+mxTx/VcO3VgLeJWqqXbvkYTx82lHJJzhbqPaOM0g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789928519;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=VmPb8TF+bPdoD48RpveL64aHUOKVL7jZYFinv76ty1Y=;
	b=Ya/Oiuo45SlR4uwBfsL+T8QdqcXa46kC3QerMyWtE3HCp72ke4oBxZ4iTaOVvMhKeZBc
	 ULyHyGXA8GY9N1GB+K2KbYMFpz1ofZLsyrfDsoO95nLLjn7cDXJ4X/CkTT5iDARLE18Pe
	 zaxJ8z/aqcR+s011pJYiY/F/9r5efVUIQssDB5/Ek45vELjXw7KSdQ7OCTrH4ayJlV5IT
	 2wpnPxwsjkzP7Pse7j+iDhV190KMqxv8l3REH9CoRHNG6ImQArx+ML0z8N2fKPCjbtZ1G
	 K0cA2c1OsllYjcd/8Kbh3jn0H5tvW8eBM2E8y2gm0otUS9oi42HtEQWgS9BqtzxYM/w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789928519;
	bh=VmPb8TF+bPdoD48RpveL64aHUOKVL7jZYFinv76ty1Y=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BalObrIQ9rENnYluHRLvdeVAg6xxAJSd0KvX7RLcDqDiE8623Mo0dRIG5gYppB5yl
	 KeSxHbv6s7m3p1rpID12Tez2v0A1cr56gFfQ8WbJjeCK9wJRZAHLz146gpGkHzHhYA
	 p4ndKNPcSMUgeZcq/SluneVIhBa54JSOPce57V7a0xtYWjBtbWhTD3rSLlColclxOx
	 x1jkKLck2VigeIFsp0uAqLheaRHjRHrYxdLP4pSGqggxr00PLlByqQY0ZBSVPWC+Oa
	 o3CSneP+dUl79r03bXpqdmeQMoTz+LJBo9XARfhovF9yp/Ed23AxmEJ1yzmWlZ24lT
	 5EO6k9Bo+wJZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1AD7180E6B;
	Sun, 20 Sep 2026 18:21:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F02AA224
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 18:21:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D659640DE7
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 18:21:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5uOb0p5K6R6D for <intel-wired-lan@lists.osuosl.org>;
 Sun, 20 Sep 2026 18:21:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 38DC540DE5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789928516;
 b=BBzICyXy3nl6SK72gDDzLAQZXEihzcZEqQofVFO3GXkOVWuQ3gHoLwn8+1LSMtnSlydk
 bt9eDmATXb1p6jHMEBc1goUwiHjFAgd+LhTdgVo2ytmiW5XUY47+r5xQVU+IwxUP1ZUpV
 OQUVxDLXsA2xRR71BaeZGx2/IM7k1ri5xiUGbIiR1Pzroo6piVCKaG+vbWdwkQmdJY/eb
 xJh0/Pkh/87IAl9wollkEYzB2F3gf9vXlGGg2vGATg0OoOhhHi7qer7bJSnX8dZfs+aXQ
 jX0udWVn0EXavsvJkR0iXslr6Ra6huFhJcpjKJiY7umAvc4FPEjekz++hdUMVMpMXUw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789928516;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=VmPb8TF+bPdoD48RpveL64aHUOKVL7jZYFinv76ty1Y=;
 b=W6m9wLt1vEYelj+//VrZCvUjQKdJ3e6XpQAZwHtbSlDa42VKiuomOkca/6jmakRISDe1
 t6ucXgnnmPvcCBQz0P/rUju4YRTQ6OHg0Xb/9hGv6nfRmhH3mh0vVfxpJi8BfMzMKM3AQ
 kO4fGD5RMIP+kqZifFGo2BhqLI1EehhGlXegDPudHckcZXIKeWWjeNz0zVA6d/hy//KJI
 Df3FMBITwnuKNVidkQ933qyGD7opvlDUlwCwffoT8o5szIIWsDchn+diW8TIVS3JwkftU
 b/cKuoWtgEsxu/+fhHAs8c8oaI8eyCrkxbDhikoHqnUp3X9+t1yMGHohGEZVFySCQOQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=e8DVJ5wq; 
 arc=none smtp.remote-ip=192.198.163.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=e8DVJ5wq
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 38DC540DE5
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 18:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789928516; x=1821464516; h=date:from:to:subject:message-id;
 bh=vGKtalYVgu1NLckvJJsP5INt89Q/N0v399lL4vJtfqc=;
 b=e8DVJ5wqjNN4LtOtaaXIvUZisxhxsEpFcIUYV6afe2ZyxEnp8P1mfCn+
 spp8354OLIzhu5UF9HBazoA0IC8+Qw84QHPKC/BBp9X6H9Q9TBUv9FFDg
 k1xnjAcjYuE6RkKR3dWlE+Eo/5Dp8uqVUwivbEiciNuBLTYKJFojcEADF
 DOXfDP+5LXPkD2wtVwhgoahwjnRA0bpRa+uN/61ttCldCli7lFyHvGUim
 SbwrrwhmZA3hfVhvaMDSZvUP5qqqiuBn2FDdtyWImCJGlpH9vm2t1/BMx
 ZFAOJsk4Gm187mAookNLqijj0CjDkdQVXqcnPgQ77MVqkrkguy7d08bkW A==;
X-CSE-ConnectionGUID: XYZeBY7wQ4ivRaXyCxHepA==
X-CSE-MsgGUID: 7+rCUVgITWClw7J+JlLhLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="94251825"
X-IronPort-AV: E=Sophos;i="6.27,112,1787036400"; d="scan'208";a="94251825"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2026 11:21:55 -0700
X-CSE-ConnectionGUID: iuXcr1WzTa2Z9bHnpxjgoA==
X-CSE-MsgGUID: WhRb36CiSw6NW4sqGf1vSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,112,1787036400"; 
   d="scan'208";a="3371238"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by fmviesa012.fm.intel.com with ESMTP; 20 Sep 2026 11:21:53 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x8MAh-00000000Chl-2VHf;
 Sun, 20 Sep 2026 18:21:51 +0000
Date: Mon, 21 Sep 2026 02:20:56 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:main] BUILD SUCCESS
 46bc52d13594848023e681860df8700c8db14354
Message-ID: <202609210253.rPFACtt2-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git main
branch HEAD: 46bc52d13594848023e681860df8700c8db14354  ipv4: fib: fix data-race and stale genid check around nh->nh_saddr

elapsed time: 1636m

configs tested: 238
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r1305-20260920    gcc-12.5.0 sparse
alpha                randconfig-r2101-20260918    clang-22
arc                               allmodconfig    gcc-16.1.0
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20260920    gcc-8.5.0
arc                   randconfig-1001-20260920    gcc-8.5.0
arc                  randconfig-r2107-20260918    clang-24
arm                                allnoconfig    clang-17
arm                               allyesconfig    gcc-16.1.0
arm                      am200epdkit_defconfig    gcc-16.1.0
arm                          assabet_defconfig    clang-22
arm                                  defconfig    clang-24
arm                           exynos_defconfig    clang-17
arm                             mmp2_defconfig    gcc-16.1.0
arm                           pxa910_defconfig    gcc-16.1.0
arm                   randconfig-1000-20260920    gcc-10.5.0
arm                   randconfig-1001-20260920    gcc-12.5.0
arm                   randconfig-1002-20260920    clang-20
arm                   randconfig-1003-20260920    gcc-16.1.0
arm                        versatile_defconfig    gcc-16.1.0
arm                     vt8500_v6_v7_defconfig    gcc-16.1.0
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
csky                 randconfig-r1300-20260920    gcc-11.5.0 sparse
csky                 randconfig-r1301-20260920    gcc-9.5.0  sparse
hexagon                           allmodconfig    clang-24
hexagon                            allnoconfig    clang-24
hexagon                              defconfig    clang-24
hexagon               randconfig-1000-20260920    clang-17
hexagon               randconfig-1001-20260920    clang-19
i386                              allmodconfig    gcc-14
i386                               allnoconfig    gcc-14
i386                              allyesconfig    gcc-14
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
i386                  randconfig-2101-20260918    clang-22
i386                  randconfig-2102-20260918    clang-22
i386                  randconfig-2103-20260918    clang-22
i386                  randconfig-2200-20260918    clang-22
loongarch                         allmodconfig    clang-19
loongarch                          allnoconfig    clang-20
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260920    gcc-16.1.0
loongarch             randconfig-1001-20260920    gcc-16.1.0
loongarch            randconfig-r1306-20260920    clang-24   sparse
loongarch            randconfig-r1308-20260920    clang-24   sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    gcc-16.1.0
m68k                                 defconfig    gcc-16.1.0
m68k                           multi_defconfig    gcc-16.1.0
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    gcc-16.1.0
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                            mtx1_defconfig    clang-19
mips                         qi_lb60_defconfig    clang-17
mips                 randconfig-r2202-20260918    gcc-15.2.0
nios2                             allmodconfig    gcc-11.5.0
nios2                              allnoconfig    gcc-11.5.0
nios2                                defconfig    gcc-11.5.0
nios2                 randconfig-1000-20260920    gcc-8.5.0
nios2                 randconfig-1001-20260920    gcc-8.5.0
nios2                randconfig-r1304-20260920    gcc-11.5.0 sparse
nios2                randconfig-r1307-20260920    gcc-8.5.0  sparse
openrisc                          allmodconfig    gcc-16.1.0
openrisc                           allnoconfig    gcc-16.1.0
openrisc                             defconfig    gcc-16.1.0
openrisc                     or1ksim_defconfig    gcc-16.1.0
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    gcc-16.1.0
parisc                            allyesconfig    gcc-16.1.0
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260920    gcc-14.3.0
parisc                randconfig-1000-20260921    gcc-8.5.0
parisc                randconfig-1001-20260920    gcc-8.5.0
parisc                randconfig-1001-20260921    gcc-13.4.0
parisc               randconfig-r1308-20260920    gcc-8.5.0  sparse
parisc64                             defconfig    gcc-16.1.0
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    gcc-16.1.0
powerpc               randconfig-1000-20260920    gcc-8.5.0
powerpc               randconfig-1000-20260921    clang-17
powerpc               randconfig-1001-20260920    clang-24
powerpc               randconfig-1001-20260921    clang-24
powerpc              randconfig-r1302-20260920    gcc-9.5.0  sparse
powerpc              randconfig-r1302-20260921    clang-24   sparse
powerpc              randconfig-r1303-20260920    gcc-8.5.0  sparse
powerpc              randconfig-r2105-20260918    clang-24
powerpc                      stx_gp3_defconfig    gcc-16.1.0
powerpc                      tqm8540_defconfig    gcc-16.1.0
powerpc64             randconfig-1000-20260920    clang-24
powerpc64             randconfig-1000-20260921    gcc-10.5.0
powerpc64             randconfig-1001-20260920    clang-22
powerpc64             randconfig-1001-20260921    gcc-8.5.0
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    gcc-16.1.0
riscv                             allyesconfig    clang-24
riscv                                defconfig    clang-24
riscv                 randconfig-1000-20260920    gcc-13.4.0
riscv                 randconfig-1001-20260920    gcc-15.2.0
riscv                 randconfig-2000-20260918    gcc-13.4.0
riscv                 randconfig-2001-20260918    gcc-13.4.0
riscv                randconfig-r2102-20260918    clang-22
s390                              allmodconfig    clang-24
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    clang-18
s390                  randconfig-1000-20260920    gcc-8.5.0
s390                  randconfig-1001-20260920    clang-20
s390                  randconfig-2000-20260918    gcc-13.4.0
s390                  randconfig-2001-20260918    gcc-13.4.0
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    gcc-16.1.0
sh                                allyesconfig    gcc-16.1.0
sh                          apsh4a3a_defconfig    gcc-16.1.0
sh                                   defconfig    gcc-16.1.0
sh                    randconfig-1000-20260920    gcc-16.1.0
sh                    randconfig-1001-20260920    gcc-10.5.0
sh                    randconfig-2000-20260918    gcc-13.4.0
sh                    randconfig-2001-20260918    gcc-13.4.0
sh                   randconfig-r2200-20260918    gcc-16.1.0
sh                            se7705_defconfig    gcc-16.1.0
sparc                              allnoconfig    gcc-16.1.0
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260920    gcc-12.5.0
sparc                 randconfig-1001-20260920    gcc-14.3.0
sparc                 randconfig-2000-20260918    gcc-14
sparc                 randconfig-2001-20260918    gcc-14
sparc                randconfig-r1309-20260920    gcc-8.5.0  sparse
sparc                randconfig-r2104-20260918    clang-24
sparc                randconfig-r2106-20260918    clang-24
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    clang-24
sparc64               randconfig-1000-20260920    gcc-13.4.0
sparc64               randconfig-1001-20260920    clang-24
sparc64               randconfig-2000-20260918    gcc-14
sparc64               randconfig-2001-20260918    gcc-14
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
um                   randconfig-r1307-20260920    gcc-12     sparse
um                            x86_64_defconfig    clang-24
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-22
x86_64                            allyesconfig    clang-22
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
x86_64                randconfig-1006-20260920    gcc-14
x86_64                randconfig-1007-20260920    gcc-14
x86_64                randconfig-1008-20260920    gcc-14
x86_64                randconfig-1009-20260920    gcc-14
x86_64                randconfig-1010-20260920    gcc-14
x86_64                randconfig-1011-20260920    gcc-14
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
xtensa                            alldefconfig    gcc-16.1.0
xtensa                             allnoconfig    gcc-16.1.0
xtensa                            allyesconfig    gcc-16.1.0
xtensa                randconfig-1000-20260920    gcc-10.5.0
xtensa                randconfig-1001-20260920    gcc-8.5.0
xtensa                randconfig-2000-20260918    gcc-14
xtensa                randconfig-2001-20260918    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
