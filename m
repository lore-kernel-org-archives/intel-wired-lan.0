Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CF1606A31C
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 20:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=hJMLSNMI;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oHGFHB+t
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3154740A12;
	Thu, 26 Nov 2026 20:37:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xvSrwNSpybZH; Thu, 26 Nov 2026 20:37:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 20FCA409EB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795725456;
	b=ldl2FFZktDR2qcm8i5fx49tZrISJdBbwGmVaD47Bfe4UBebV8UdZUCF/nrMCVmJXYkJ1
	 roCcIJr9lyh3thLsHrVmljl5kyg1X2gcR7RpwKNAGhdF22TIpTj2y+dapu6HOBIXtkry9
	 oQM0lZCyBN1MMpfT3VXbfir+QpCEq0+GJLlUZ1ti6xL3v7UK6OO53KHjf8NWBf7+7F6Q7
	 +B4fwXZHZdFxk0PDqbj3xN3Wan61TwM9glgu+xim4kFjY8CG3NC94A5Inuwo2i7M/Nd/T
	 T9KLHIbk4fq8TgG/AOMhxzrTPm0Ta2u5iVikFoP63AQ1eHyl0LbB/7nsAQQW7He01mQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795725456;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ZONo8ocLxqxRv8y4RYe63h0lIZlTV4IPdkjWoLjKBGA=;
	b=oMvtbPH1AVn6+OQA1mzp9CZW4acRzzLptdOw6fB5/E+/kd2Rg4yv2jKENC073NArvy79
	 0OWENn8K5RBJoGwvjqEXQ6UPHu6h8zvV4/PyMoJwKKjy715IWFOC27ip5+oA2Y97+Jqbd
	 wgbxZ1QZTvlPT/nghVWm0PwLKe5CgIwempZnXxpSsIxfNcc11OQZZiU+XioxWFP7Ox+D/
	 fSekP4wjbodwLZNPxP84rd0Lalk45eG9JnYsJ8VDOjfg2OArQ1P3EsUNDxDInCKLFyAqJ
	 KsCosFakwNJo+ymknODmDlwsyJSGmS060noJ3GzVy/Ca1mp0mxykjKwjEgB+Pntyh9Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795725456;
	bh=ZONo8ocLxqxRv8y4RYe63h0lIZlTV4IPdkjWoLjKBGA=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hJMLSNMIwyBVPRu9xW8mtfJiror8grJiVzxA0a7wKZLizYJO/2+LKEd5dzof3C1fN
	 AOOj1uDXfR9nt/Oax4Q5024Pe15fa3aW1h9e+mQLoBbsE+63F43MaKi/LS+ikwG/OU
	 MS2AFpp0MA9pbFpy0A4oa65QLzmIAfhbD22jLyJv3R74wQ3J2Q/L4qqpo5/+ecGF0I
	 /e1xEi0yGnoVaBvZPbyrm6kWpwp+1DOiLiSlEWoxs5NUp6T5lMHG2tmPT0b9teT+Zi
	 O5kj+hn6WxWSFb5yTBMi3Kk3S2knIwbcL+oUE2Q2xj96zu5kkXQYofMvfM8a8MMB9k
	 JpoYnjHip1aXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 20FCA409EB;
	Thu, 26 Nov 2026 20:37:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 970A81AB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:37:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 88475811B8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:37:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W6AuWzpoivPg for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 20:37:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1E63281181
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=oHGFHB+t
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E63281181
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795725453; x=1827261453; h=date:from:to:subject:message-id;
 bh=5HW6AnSuqQvGdexYbiRczc77pbmcGt3dHgXRXJi5Ozc=;
 b=oHGFHB+tiapXm5QColuV4a6XVbSV7I2bFkiNXrXioxVK1PWTFDb+JhCk
 GeOFZJzD4lvWfOjehJgsSRqtli5Pj4HLjjfIXH24Z/Bk5I/a9o8CWM+jm
 bwXxAdMxLGJ9uVtV33+tjkY4rANE9+V8o3vrn9BrgIQC+WtpUK/HmXWwu
 rnISKlTF/8LnSapDQ7M+r7IgF6R2FU43jglb62eNrTgw3pePBpIIvADas
 FxeMghI1OY2HDxUHnmReVF3X7NTjWh2E1fT4SZ2P25mG7NNokG1rKxD9s
 nYclueeVwUSUFBL3IcHpaICF2OoLhlfEaGL0s8nD0DEgh/KQ+g7rQeXqR g==;
X-CSE-ConnectionGUID: 3YF75sRuSBu/uiFlwcyuqQ==
X-CSE-MsgGUID: KmAb4A66TnyzV/m5x+ZeOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4648462"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4648462"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 12:37:32 -0800
X-CSE-ConnectionGUID: uAz8iDNwTO6xa1y5RN2xLQ==
X-CSE-MsgGUID: AkdIe4QhT9WB1VdJjVuBQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12161008"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa003.jf.intel.com with ESMTP; 26 Nov 2026 12:37:31 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xWgDg-00000001Upe-1wAK;
 Thu, 26 Nov 2026 20:37:28 +0000
Date: Fri, 27 Nov 2026 04:36:36 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:dev-queue] BUILD SUCCESS
 8453ebb79690647ad027670c9a779b81ef3bd6b5
Message-ID: <20261127043636.TP6ZBDsx-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 8453ebb79690647ad027670c9a779b81ef3bd6b5  ixgbe: allow loading XDP program on hosts with > 128 CPUs

elapsed time: 1288m

configs tested: 339
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                 randconfig-2000-20261126    gcc-13.5.0
alpha                 randconfig-2000-20261126    gcc-15.3.0
alpha                 randconfig-2001-20261126    gcc-13.5.0
alpha                 randconfig-2200-20261126    gcc-9.5.0  smatch
alpha                randconfig-r2310-20261126    gcc-10.5.0 sparse
arc                               allmodconfig    clang-24
arc                               allmodconfig    gcc-16.2.0
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-19
arc                               allyesconfig    clang-24
arc                       axs103_smp_defconfig    clang-17
arc                                  defconfig    gcc-16.2.0
arc                   randconfig-1000-20261126    gcc-16.2.0
arc                   randconfig-1001-20261126    gcc-16.2.0
arc                   randconfig-2000-20261126    gcc-11.5.0
arc                   randconfig-2001-20261126    gcc-8.5.0
arc                   randconfig-2002-20261126    gcc-8.5.0
arc                   randconfig-2003-20261126    gcc-9.5.0
arc                   randconfig-2004-20261126    gcc-15.3.0
arc                   randconfig-2005-20261126    gcc-9.5.0
arc                   randconfig-2200-20261126    gcc-8.5.0  smatch
arc                  randconfig-r2109-20261126    gcc-10.5.0 cocci
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                         mvebu_v5_defconfig    clang-24
arm                              mxs_defconfig    clang-17
arm                   randconfig-1000-20261126    gcc-16.2.0
arm                   randconfig-1001-20261126    gcc-16.2.0
arm                   randconfig-1002-20261126    gcc-16.2.0
arm                   randconfig-1003-20261126    gcc-16.2.0
arm                   randconfig-2000-20261126    gcc-8.5.0
arm                   randconfig-2001-20261126    gcc-11.5.0
arm                   randconfig-2002-20261126    gcc-13.5.0
arm                   randconfig-2200-20261126    gcc-8.5.0  smatch
arm                  randconfig-r2108-20261126    clang-24   cocci
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261126    gcc-8.5.0
arm64                 randconfig-1000-20261127    gcc-8.5.0
arm64                 randconfig-1001-20261126    gcc-8.5.0
arm64                 randconfig-1001-20261127    gcc-8.5.0
arm64                 randconfig-1002-20261126    gcc-8.5.0
arm64                 randconfig-1002-20261127    gcc-8.5.0
arm64                 randconfig-1003-20261126    gcc-8.5.0
arm64                 randconfig-1003-20261127    gcc-8.5.0
arm64                 randconfig-2000-20261126    clang-24
arm64                 randconfig-2001-20261126    clang-20
arm64                 randconfig-2002-20261126    clang-24
arm64                 randconfig-2200-20261126    clang-24   smatch
arm64                randconfig-r2100-20261126    clang-24   cocci
arm64                randconfig-r2107-20261126    gcc-10.5.0 cocci
arm64                randconfig-r2302-20261126    clang-24   sparse
arm64                randconfig-r2303-20261126    gcc-8.5.0  sparse
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    clang-24
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261126    gcc-8.5.0
csky                  randconfig-1000-20261127    gcc-8.5.0
csky                  randconfig-1001-20261126    gcc-8.5.0
csky                  randconfig-1001-20261127    gcc-8.5.0
csky                  randconfig-2000-20261126    gcc-16.2.0
csky                  randconfig-2001-20261126    gcc-13.5.0
csky                  randconfig-2200-20261126    gcc-13.5.0 smatch
hexagon                           alldefconfig    clang-17
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261126    gcc-11.5.0
hexagon               randconfig-1000-20261127    gcc-9.5.0
hexagon               randconfig-1001-20261126    gcc-11.5.0
hexagon               randconfig-1001-20261127    gcc-9.5.0
hexagon               randconfig-2000-20261126    clang-24
hexagon               randconfig-2001-20261126    clang-17
hexagon               randconfig-2200-20261126    clang-17   smatch
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261126    gcc-14
i386        buildonly-randconfig-1001-20261126    gcc-14
i386        buildonly-randconfig-1002-20261126    gcc-14
i386        buildonly-randconfig-1003-20261126    gcc-14
i386        buildonly-randconfig-1004-20261126    gcc-14
i386        buildonly-randconfig-1005-20261126    gcc-14
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261126    clang-22
i386                  randconfig-1001-20261126    clang-22
i386                  randconfig-1002-20261126    clang-22
i386                  randconfig-1003-20261126    clang-22
i386                  randconfig-1004-20261126    clang-22
i386                  randconfig-1005-20261126    clang-22
i386                  randconfig-1006-20261126    clang-22
i386                  randconfig-2000-20261126    clang-22
i386                  randconfig-2001-20261126    clang-22
i386                  randconfig-2002-20261126    clang-22
i386                  randconfig-2003-20261126    gcc-14
i386                  randconfig-2004-20261126    clang-22
i386                  randconfig-2005-20261126    clang-22
i386                  randconfig-2100-20261126    clang-22   cocci
i386                  randconfig-2101-20261126    clang-22   cocci
i386                  randconfig-2102-20261126    gcc-14     cocci
i386                  randconfig-2103-20261126    gcc-12     cocci
i386                  randconfig-2104-20261126    clang-22   cocci
i386                  randconfig-2105-20261126    gcc-14     cocci
i386                  randconfig-2200-20261126    gcc-14     smatch
i386                  randconfig-2300-20261126    gcc-14     sparse
i386                  randconfig-2301-20261126    clang-22   sparse
i386                  randconfig-2301-20261126    gcc-14     sparse
i386                  randconfig-2302-20261126    gcc-14     sparse
i386                 randconfig-r2101-20261126    clang-22   cocci
loongarch                         allmodconfig    clang-19
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261126    gcc-11.5.0
loongarch             randconfig-1000-20261127    gcc-9.5.0
loongarch             randconfig-1001-20261126    gcc-11.5.0
loongarch             randconfig-1001-20261127    gcc-9.5.0
loongarch             randconfig-2000-20261126    gcc-12.5.0
loongarch             randconfig-2001-20261126    clang-18
loongarch             randconfig-2200-20261126    gcc-14.4.0 smatch
loongarch            randconfig-r2307-20261126    gcc-10.5.0 sparse
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                              allyesconfig    gcc-16.2.0
m68k                                 defconfig    clang-24
m68k                       m54418evb_defconfig    clang-17
m68k                  randconfig-2000-20261126    gcc-13.5.0
m68k                  randconfig-2000-20261126    gcc-8.5.0
m68k                  randconfig-2001-20261126    gcc-13.5.0
m68k                  randconfig-2001-20261126    gcc-8.5.0
m68k                  randconfig-2200-20261126    gcc-8.5.0  smatch
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2000-20261126    gcc-13.5.0
microblaze            randconfig-2000-20261126    gcc-15.3.0
microblaze            randconfig-2001-20261126    gcc-13.5.0
microblaze            randconfig-2001-20261126    gcc-8.5.0
microblaze            randconfig-2200-20261126    gcc-9.5.0  smatch
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                   cavium_octeon_defconfig    clang-24
mips                      decstation_defconfig    clang-17
mips                  randconfig-2000-20261126    gcc-8.5.0
mips                  randconfig-2001-20261126    gcc-15.3.0
mips                  randconfig-2002-20261126    gcc-9.5.0
mips                  randconfig-2200-20261126    gcc-15.3.0 smatch
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261126    gcc-11.5.0
nios2                 randconfig-1000-20261127    gcc-9.5.0
nios2                 randconfig-1001-20261126    gcc-11.5.0
nios2                 randconfig-1001-20261127    gcc-9.5.0
nios2                 randconfig-2000-20261126    gcc-11.5.0
nios2                 randconfig-2001-20261126    gcc-9.5.0
nios2                 randconfig-2200-20261126    gcc-9.5.0  smatch
nios2                randconfig-r2111-20261126    gcc-8.5.0  cocci
nios2                randconfig-r2304-20261126    gcc-11.5.0 sparse
nios2                randconfig-r2308-20261126    gcc-10.5.0 sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc              randconfig-2000-20261126    gcc-16.2.0
openrisc              randconfig-2001-20261126    gcc-13.5.0
openrisc              randconfig-2002-20261126    gcc-16.2.0
openrisc              randconfig-2200-20261126    gcc-9.5.0  smatch
openrisc             randconfig-r2105-20261126    gcc-10.5.0 cocci
openrisc             randconfig-r2306-20261126    gcc-10.5.0 sparse
openrisc             randconfig-r2311-20261126    gcc-10.5.0 sparse
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261126    gcc-13.5.0
parisc                randconfig-1001-20261126    gcc-13.5.0
parisc                randconfig-2000-20261126    gcc-8.5.0
parisc                randconfig-2001-20261126    gcc-8.5.0
parisc                randconfig-2200-20261126    gcc-15.3.0 smatch
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                  mpc8313_rdb_defconfig    clang-24
powerpc                mpc834x_itxgp_defconfig    clang-17
powerpc                  mpc836x_rdk_defconfig    clang-24
powerpc               randconfig-1000-20261126    gcc-13.5.0
powerpc               randconfig-1001-20261126    gcc-13.5.0
powerpc               randconfig-2000-20261126    clang-24
powerpc               randconfig-2001-20261126    clang-17
powerpc               randconfig-2002-20261126    clang-24
powerpc               randconfig-2200-20261126    clang-24   smatch
powerpc              randconfig-r2110-20261126    clang-24   cocci
powerpc64             randconfig-1000-20261126    gcc-13.5.0
powerpc64             randconfig-1001-20261126    gcc-13.5.0
powerpc64             randconfig-2000-20261126    clang-17
powerpc64             randconfig-2001-20261126    gcc-10.5.0
powerpc64             randconfig-2002-20261126    clang-21
powerpc64             randconfig-2200-20261126    clang-24   smatch
powerpc64            randconfig-r2301-20261126    clang-19   sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261127    gcc-12.5.0
riscv                 randconfig-1001-20261126    clang-20
riscv                 randconfig-1001-20261127    gcc-12.5.0
riscv                 randconfig-2000-20261126    gcc-10.5.0
riscv                 randconfig-2001-20261126    gcc-10.5.0
riscv                 randconfig-2002-20261126    gcc-10.5.0
riscv                 randconfig-2003-20261126    gcc-10.5.0
riscv                 randconfig-2004-20261126    gcc-10.5.0
riscv                 randconfig-2005-20261126    gcc-10.5.0
riscv                 randconfig-2200-20261126    gcc-8.5.0  smatch
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261126    clang-20
s390                  randconfig-1000-20261127    gcc-12.5.0
s390                  randconfig-1001-20261126    clang-20
s390                  randconfig-1001-20261127    gcc-12.5.0
s390                  randconfig-2000-20261126    clang-18
s390                  randconfig-2001-20261126    gcc-8.5.0
s390                  randconfig-2002-20261126    clang-24
s390                  randconfig-2003-20261126    clang-18
s390                  randconfig-2004-20261126    gcc-10.5.0
s390                  randconfig-2005-20261126    clang-21
s390                  randconfig-2200-20261126    gcc-16.2.0 smatch
s390                 randconfig-r2104-20261126    clang-17   cocci
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20261126    clang-20
sh                    randconfig-1000-20261127    gcc-12.5.0
sh                    randconfig-1001-20261126    clang-20
sh                    randconfig-1001-20261127    gcc-12.5.0
sh                    randconfig-2000-20261126    gcc-9.5.0
sh                    randconfig-2001-20261126    gcc-9.5.0
sh                    randconfig-2002-20261126    gcc-9.5.0
sh                    randconfig-2003-20261126    gcc-9.5.0
sh                    randconfig-2004-20261126    gcc-9.5.0
sh                    randconfig-2005-20261126    gcc-9.5.0
sh                    randconfig-2200-20261126    gcc-16.2.0 smatch
sh                         sh7757lcr_defconfig    clang-24
sh                         sh7763rdp_defconfig    clang-17
sh                   sh7785lcr_32bit_defconfig    clang-24
sh                             shmin_defconfig    clang-17
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261126    clang-17
sparc                 randconfig-1001-20261126    clang-17
sparc                 randconfig-2000-20261126    gcc-8.5.0
sparc                 randconfig-2001-20261126    gcc-8.5.0
sparc                 randconfig-2200-20261126    gcc-13.5.0 smatch
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261126    clang-17
sparc64               randconfig-1001-20261126    clang-17
sparc64               randconfig-2000-20261126    gcc-8.5.0
sparc64               randconfig-2001-20261126    gcc-8.5.0
sparc64               randconfig-2200-20261126    gcc-12.5.0 smatch
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261126    clang-17
um                    randconfig-1001-20261126    clang-17
um                    randconfig-2000-20261126    gcc-8.5.0
um                    randconfig-2001-20261126    gcc-8.5.0
um                    randconfig-2200-20261126    gcc-12     smatch
um                   randconfig-r2102-20261126    clang-24   cocci
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261126    clang-22
x86_64      buildonly-randconfig-1001-20261126    clang-22
x86_64      buildonly-randconfig-1002-20261126    clang-22
x86_64      buildonly-randconfig-1003-20261126    clang-22
x86_64      buildonly-randconfig-1004-20261126    clang-22
x86_64      buildonly-randconfig-1005-20261126    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261126    clang-22
x86_64                randconfig-1001-20261126    clang-22
x86_64                randconfig-1002-20261126    clang-22
x86_64                randconfig-1003-20261126    clang-22
x86_64                randconfig-1004-20261126    clang-22
x86_64                randconfig-1005-20261126    clang-22
x86_64                randconfig-2000-20261126    clang-22
x86_64                randconfig-2001-20261126    gcc-14
x86_64                randconfig-2002-20261126    clang-22
x86_64                randconfig-2003-20261126    clang-22
x86_64                randconfig-2004-20261126    clang-22
x86_64                randconfig-2005-20261126    clang-22
x86_64                randconfig-2100-20261126    clang-22   cocci
x86_64                randconfig-2101-20261126    clang-22   cocci
x86_64                randconfig-2102-20261126    gcc-14     cocci
x86_64                randconfig-2103-20261126    clang-22   cocci
x86_64                randconfig-2104-20261126    gcc-14     cocci
x86_64                randconfig-2105-20261126    gcc-14     cocci
x86_64                randconfig-2200-20261126    clang-22   smatch
x86_64                randconfig-2300-20261126    gcc-12     sparse
x86_64                randconfig-2300-20261126    gcc-14     sparse
x86_64                randconfig-2301-20261126    gcc-14     sparse
x86_64                randconfig-2302-20261126    gcc-14     sparse
x86_64               randconfig-r2103-20261126    gcc-14     cocci
x86_64               randconfig-r2300-20261126    clang-22   sparse
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    clang-22
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                            alldefconfig    clang-24
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261126    clang-17
xtensa                randconfig-1001-20261126    clang-17
xtensa                randconfig-2000-20261126    gcc-13.5.0
xtensa                randconfig-2001-20261126    gcc-15.3.0
xtensa                randconfig-2200-20261126    gcc-11.5.0 smatch
xtensa               randconfig-r2106-20261126    gcc-12.5.0 cocci
xtensa               randconfig-r2309-20261126    gcc-10.5.0 sparse

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
