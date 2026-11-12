Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0722A606A337
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Nov 2026 01:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=0QsJDAYx;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iaAGtehy
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D076040A79;
	Thu, 12 Nov 2026 01:03:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DYihun5lgXXj; Thu, 12 Nov 2026 01:03:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D6E1F40A83
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794445395;
	b=J0h99D8ZpfUm+X8KkNrfR//td2AU+A43x8ymWx1xCbyn3BuTc3DQnhA7COlSH7dIFGuV
	 npYdZCTuwIMvfzFyg1gAOGh4ktlZ0KyGiNJJHWwelkSJ7uLUI3/zsEUEbRR4t3ilCjqcP
	 cYDIXgQHWdfFmyZw6yicPsV71KzegUpucBfo5wk8BLZArds48evvRL6FlXMWVkHQ1hAWd
	 Q2v+hkealOl7i/NM9P7bZEvSGUhMKmpDmOAiiBi2h+iWnM76UD9lApeCT7IiyorHgNI3m
	 cVMsfykyqKPoGYnKqR/ZDHXTKpQEcP+UCZBUfmvFeYnkIjm7FsPE7Z0dqSISvrphkgw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794445395;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=RQzjhtGqnJZwwjQViD8hQr/4HoAaPczCDeJZgm6UIqc=;
	b=GVf4AtaM/UZIZkcEbYl3PObzDmeJh34gJ53++qy6BAPGgg42CUjry8+A7i0O/W/9yaG4
	 KvYezETpCopA+fo5ZxFCthMyKkAEg7aQyQ8l1ta5VRI7zSo5M8S365QpXD/nL+5kYMSFq
	 MqIgW1/n7EhMS5mrovmmOosKHjFcZW31YpKhb9lb45Oc+rt3AJ6OomibOwbISGKdU3gK3
	 3Nsq75edQTPEMtNpKJUqTM0prpzRKZoGQFYJh8FwUrGVWji/uUgt3CCsuq3wc8+AIrNLz
	 61sY3qGeEMLBpF2YsjyoOrl6ZxlqbzaVsTe8do/nwbklWDnKsGitZnb85T2pvxGGW4w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794445395;
	bh=RQzjhtGqnJZwwjQViD8hQr/4HoAaPczCDeJZgm6UIqc=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0QsJDAYxERa0ohMUQvcgwwDzXwc65Fmvuhdko369fWP07pbuGRIKjiAS3kOolsj5p
	 bmeIP8sriRyquizsjDE4tJ5RrL0PcgiV3IXFLIlc+CCCp5+mNoVEANyn+m3+uCNAt0
	 s59esP5F134BDH7wAloqhX6OgIfb+m6xRQ6z1Ekirp6h1KzUgJpIM2PgoRg47ky/e2
	 Zl7GLw9QQ7szGx1ME8N3zw7ZADfXMFlaTD2LgT616xnjIRKSR1MmyQ5OFeCGO6hV1/
	 hra6jqFWdDDd7sNodedZlewv8xgTaNj/dneg2D+Y/0mTqelHuioB6Ty6tlj1KgSF6d
	 eoEHwmotc0lLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D6E1F40A83;
	Thu, 12 Nov 2026 01:03:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D10C2FE
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 01:03:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1EE8040217
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 01:03:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EdcR4S54-wGo for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Nov 2026 01:03:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0011F400A2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=iaAGtehy
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0011F400A2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 01:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794445395; x=1825981395; h=date:from:to:subject:message-id;
 bh=t4eweZVMjYQhg6R1pCb1UrrsCJyrrwmOSgNnQpbfHMo=;
 b=iaAGtehynE1as+85DJvJrEppkgvcoFPtpL2eWFK09OhuQMCC3mcBCTqo
 6ia7tgLwOUPy0URmm1+u7ho0vFXXbPiArjqVQvZBGCTQ2gc9ievWFgid4
 KlJBiseoZEazEyGoxrF0v/LOW+zD0WLnPQwMWWK+HIfcX/NmeWhf/6Bk8
 m53brQnOHq1SAXsI/o0qWdCk/r8cM3TX8mWxlC2Z0n0xdOAsEMYXqcLFS
 5bo2mYSVxdcqSjTKgEYR0bZoAerg8lC8iOqimcR3zk2w3cc08M1UTmJ85
 pXXsPoENZ25a9IfBNNUFBGc1LCFmVxqo81grSXQ/5Zv89r9O6PGtlHfY3 g==;
X-CSE-ConnectionGUID: CTiqrKD9QKORZCLDUraQGg==
X-CSE-MsgGUID: pPBgy9xPS2m/JdpRNFAT0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3223848"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3223848"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2026 17:03:13 -0800
X-CSE-ConnectionGUID: JkvJQxhYSXSe95+ZNoxBYQ==
X-CSE-MsgGUID: EfjQfj2uTcqXtqVOYOTSkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="8390540"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa005.jf.intel.com with ESMTP; 11 Nov 2026 17:03:11 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xRJDZ-0000000109L-00YZ;
 Thu, 12 Nov 2026 01:03:09 +0000
Date: Thu, 12 Nov 2026 09:03:02 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:dev-queue] BUILD SUCCESS
 34a70a40c954fb8044ecd124840a2c38cd3aa4cc
Message-ID: <20261112090302.1s8eiKog-lkp@intel.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 34a70a40c954fb8044ecd124840a2c38cd3aa4cc  ice: use struct timecounter for E825 and E830

elapsed time: 1525m

configs tested: 141
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                                  defconfig    gcc-16.2.0
arc                   randconfig-1000-20261111    gcc-15.3.0
arc                   randconfig-1000-20261112    clang-24
arc                   randconfig-1001-20261111    gcc-15.3.0
arc                   randconfig-1001-20261112    clang-24
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                      am200epdkit_defconfig    gcc-16.2.0
arm                                  defconfig    gcc-16.2.0
arm                             hisi_defconfig    gcc-16.2.0
arm                           pxa910_defconfig    gcc-16.2.0
arm                   randconfig-1000-20261111    gcc-15.3.0
arm                   randconfig-1000-20261112    clang-24
arm                   randconfig-1001-20261111    gcc-15.3.0
arm                   randconfig-1001-20261112    clang-24
arm                   randconfig-1002-20261111    gcc-15.3.0
arm                   randconfig-1002-20261112    clang-24
arm                   randconfig-1003-20261111    gcc-15.3.0
arm                   randconfig-1003-20261112    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261112    gcc-14.4.0
arm64                 randconfig-1001-20261112    gcc-14.4.0
arm64                 randconfig-1002-20261112    gcc-14.4.0
arm64                 randconfig-1003-20261112    gcc-14.4.0
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261112    gcc-14.4.0
csky                  randconfig-1001-20261112    gcc-14.4.0
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261112    clang-22
i386        buildonly-randconfig-1001-20261112    clang-22
i386        buildonly-randconfig-1002-20261112    clang-22
i386        buildonly-randconfig-1003-20261112    clang-22
i386        buildonly-randconfig-1004-20261112    clang-22
i386        buildonly-randconfig-1005-20261112    clang-22
i386                                 defconfig    gcc-16.2.0
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                         qi_lb60_defconfig    gcc-16.2.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261112    gcc-12.5.0
parisc                randconfig-1001-20261112    gcc-12.5.0
parisc64                             defconfig    clang-24
powerpc                            allnoconfig    clang-24
powerpc               randconfig-1000-20261112    gcc-12.5.0
powerpc               randconfig-1001-20261112    gcc-12.5.0
powerpc                       tqm8xx_defconfig    gcc-16.2.0
powerpc64             randconfig-1000-20261112    gcc-12.5.0
powerpc64             randconfig-1001-20261112    gcc-12.5.0
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261112    gcc-9.5.0
riscv                 randconfig-1001-20261112    gcc-9.5.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261112    gcc-9.5.0
s390                  randconfig-1001-20261112    gcc-9.5.0
s390                        zfcpdump_defconfig    gcc-16.2.0
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20261112    gcc-9.5.0
sh                    randconfig-1001-20261112    gcc-9.5.0
sh                            se7780_defconfig    gcc-16.2.0
sh                         sh7763rdp_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261111    gcc-16.2.0
sparc                 randconfig-1001-20261111    gcc-16.2.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261111    gcc-16.2.0
sparc64               randconfig-1001-20261111    gcc-16.2.0
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261111    gcc-16.2.0
um                    randconfig-1001-20261111    gcc-16.2.0
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261112    gcc-14
x86_64      buildonly-randconfig-1001-20261112    gcc-14
x86_64      buildonly-randconfig-1002-20261112    gcc-14
x86_64      buildonly-randconfig-1003-20261112    gcc-14
x86_64      buildonly-randconfig-1004-20261112    gcc-14
x86_64      buildonly-randconfig-1005-20261112    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1006-20261111    clang-22
x86_64                randconfig-1007-20261111    clang-22
x86_64                randconfig-1008-20261111    clang-22
x86_64                randconfig-1009-20261111    clang-22
x86_64                randconfig-1010-20261111    clang-22
x86_64                randconfig-1011-20261111    clang-22
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261111    gcc-16.2.0
xtensa                randconfig-1001-20261111    gcc-16.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
