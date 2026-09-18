Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4363DC982D7
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Sep 2026 09:18:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF69D60C1D;
	Fri, 18 Sep 2026 09:18:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4EL7DCaIBnDX; Fri, 18 Sep 2026 09:18:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BE2B960860
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789723101;
	b=sGIB7Z12pcdNd/it2JW56ea/cxKlYQpBi2JLSuOsrRyQ3a1ZfZOa7WxLtgL7yesBjgFb
	 uuz3JdmFvSW0DS1YtCLrwcoxWO5Qlo/axR/Y+XjiYg9MvTC+4C3kUjzGjvK5is2/+8zaT
	 41NM2RKW4in8wq82mhxz4Z26KUM3Dqxnsq3/D0e97ls0PorAghmyyOFcWCONDNeaQGhSt
	 Ck1JjlH2tzJpvmeD/9utf9Qj6nMpINPUBbaItCuimD5poy6U3eEeItaokYLxUqm5wH/PO
	 CLef6/eO82fVPt+mJaecr1a4njMUiwcYbuQsZiwcj1IHZatxlkKqRc5Q/Ts7yqJ6bLA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789723101;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=q1ToO140KcwAgnxg/Xjw0U/R1ot6XN3V0tFUyMDYG4s=;
	b=KfLcgO+1BlkyHvi+DeIwW/IHGg0rmh6nK3TCEK9YJHLmlPsMl7JkjxeMSSbnXx9Hp3xA
	 I58XU7I+snnuAezjr3fZJv/aSn1Ulpf/v6dmJVWRwKnvLFxzpNa0y9gT9wQwcJe+HDka4
	 JhSmSME1KXt85y3QdlLFM/iDg4VMXFaXhj/+neYtMZJb9lPAZvOS0r9zPCkB0CXldUkx8
	 D7qRg2CpFc3+ZYzaWwHNGVgOJ/O1Kniq8hNNpOEYfUEUABYVXKSEnDUeFR6lAlASsboU0
	 6vWrTKtsUtlx8JUvRkShIXLoAL/s1fWZz83LK/j+6l3o8RcfNM2Mw/em26NxMzWai2A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789723101;
	bh=q1ToO140KcwAgnxg/Xjw0U/R1ot6XN3V0tFUyMDYG4s=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OWbuduB3ZgE4aWFBNVUz+PbE+Otq4u03+2xO+YKNxYiQbyMRpNH8NhVdKWJvzUvLi
	 yocefUT+EvAFXeDioeuI7ROlBRErmXceeZf4NIMWrwSlc6w7SqkCGo5T+BCNUBB5bN
	 ENKt9FE+w2JmuQYn7nDmBQtagBeaR2Yn623hqJFsMLsL2HMIdH6XTy0veQv1Vqg5Wu
	 KgSqq8jjV+6PjiJpze8+rh5JGUQzcTf+a/J3JAv/EiUwIhhhDUjc042iDug8vaJb12
	 vIFS4VPlvRyWOD+0sQmktSO/G6Gj7FX3sWbe+emcfC8pLNe7xO1Xw/w5I9Fr2koFJR
	 VK3Zb5syJDQ1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE2B960860;
	Fri, 18 Sep 2026 09:18:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 39BF73B6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 09:18:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3740A40AFB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 09:18:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bxsnc8FhLPjr for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Sep 2026 09:18:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AAA1C40712
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789723100;
 b=FqcAcIBLAT7d99IS2XwqAE2QaOLmysF9jd2dKipwgV4a+7siR2Mmtj7DxvSxxgWsqEkY
 EmGKhfluMLP1uSFtZlcEUivlNNa/1Drli50Dsarmk80xM1kD3ouUdrXb0EJ9AVXwXJS8u
 9TE5wo+qBPYX5P0kIQeQzlbW3IpStQrA7FUrXVE9CoSA6Wa65lOdI8VfU28oxSng1oIwj
 Wg2UwVrSQtZeVOLhwcfgA35SO8MgJtK1ftpcQH6eRWvIkDS/Qws86Us61hvpfQz1fRqPk
 uKNbx69mG0cQbDh99LinhSpPDBKlvw4pP5s2RCXVz9XErP+5ltj61mmxmkS7G+1RK+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789723100;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=q1ToO140KcwAgnxg/Xjw0U/R1ot6XN3V0tFUyMDYG4s=;
 b=IB99i/3wsbclWUKK4HNCvj6jDfTZ67SisH01Wji6n0elC/EFowWAkllFRQYgAJ21Z+/c
 1uejFf/37N0pgXidl7V8s3K8d1ZQV9KC720TjzbRU76lFmsoWbfqztymcVubkyk8wbdgT
 6tHTi/a/PWkm4krodMdY/HtJou8xI2n/BbrCXGYdYDWlsVXyXnK8Q97SBoJDtvp9OWc33
 sNK8Hv/cn/qb7Z7Sipjgdgl6oe7gTDK5KtGFWoxgXWBHlXLdoafgaV0NX1C9s6gH3VAQI
 j9r3GVdC86FYtFFRDm4PWPc5aVddBvHCxp3vJ4Ejs8d0ir8RK2Xq7zoxleUI5I9QYkQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Gsxjf4oJ; 
 arc=none smtp.remote-ip=192.198.163.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Gsxjf4oJ
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AAA1C40712
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 09:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789723099; x=1821259099; h=date:from:to:subject:message-id;
 bh=lxPaOAtMNjvY2ZdZ3AUC4DfgnpX6Q6apB4N4HSVhkiQ=;
 b=Gsxjf4oJgkgqf96VkdRdiGJbl9m9oR5hRW9eU4g9nWkygp5Da1uGHZtl
 dOinIWWqkc+US4l/iMPgzF+H8gC+9tg5xuMRN1WWK2lNLYC6cFTJRgV/2
 E4QM5zjfVnOEJkzV+uI4lNCuCl2f0UME0QVf3BNrM7X8tlkhOCxVW6xok
 7nB3ge0prfMaIMbrDqRMJLZciHNsuZT3A64bZjS3Fx6BRdtGyN5iwqgy9
 ouVHUwuK0NPHFBv8bFzHSSZxJ7xFnFlo3Xy0eK8S9ceRbxZqHdlmLJxhY
 wW+jwhEVx0AQb1mlNJ8aDhDJbBuGHmn7u6Ng/ePNFXRiGA7iEZIQLAk8C Q==;
X-CSE-ConnectionGUID: nih53nfwRPmws7BPNaDJXA==
X-CSE-MsgGUID: 4lrklD9YR7Oi94zFriD57w==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="94049245"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="94049245"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 02:18:18 -0700
X-CSE-ConnectionGUID: Rr40u3kGTt+a4wEVm3F9nQ==
X-CSE-MsgGUID: c089PV0tSj6UVNneTKJoCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2533057"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by fmviesa011.fm.intel.com with ESMTP; 18 Sep 2026 02:18:17 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x7UjX-000000009Uz-0bvP;
 Fri, 18 Sep 2026 09:18:15 +0000
Date: Fri, 18 Sep 2026 17:17:53 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:dev-queue] BUILD SUCCESS
 a98bd9f12dc5ed64029d00a8192a28685a54a587
Message-ID: <202609181750.Uj4prKXC-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: a98bd9f12dc5ed64029d00a8192a28685a54a587  igb: Quiesce the receive path before enabling i210 Rx timestamping

elapsed time: m

configs tested: 188
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20260918    gcc-16.1.0
arc                   randconfig-1001-20260918    gcc-16.1.0
arc                  randconfig-r1300-20260918    gcc-14     sparse
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                   randconfig-1000-20260918    gcc-16.1.0
arm                   randconfig-1001-20260918    gcc-16.1.0
arm                   randconfig-1002-20260918    gcc-16.1.0
arm                   randconfig-1003-20260918    gcc-16.1.0
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260918    gcc-16.1.0
arm64                 randconfig-1001-20260918    gcc-16.1.0
arm64                 randconfig-1002-20260918    gcc-16.1.0
arm64                 randconfig-1003-20260918    gcc-16.1.0
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260918    gcc-16.1.0
csky                  randconfig-1001-20260918    gcc-16.1.0
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260918    gcc-16.1.0
hexagon               randconfig-1001-20260918    gcc-16.1.0
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20260918    gcc-14
i386        buildonly-randconfig-1001-20260918    gcc-14
i386        buildonly-randconfig-1002-20260918    gcc-14
i386        buildonly-randconfig-1003-20260918    gcc-14
i386        buildonly-randconfig-1004-20260918    gcc-14
i386        buildonly-randconfig-1005-20260918    gcc-14
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20260918    gcc-12
i386                  randconfig-1001-20260918    gcc-12
i386                  randconfig-1002-20260918    gcc-12
i386                  randconfig-1003-20260918    gcc-12
i386                  randconfig-1004-20260918    gcc-12
i386                  randconfig-1005-20260918    gcc-12
i386                  randconfig-1006-20260918    gcc-12
i386                  randconfig-1007-20260918    clang-22
i386                  randconfig-1008-20260918    clang-22
i386                  randconfig-1009-20260918    clang-22
i386                  randconfig-1010-20260918    clang-22
i386                  randconfig-1011-20260918    clang-22
i386                  randconfig-1012-20260918    clang-22
i386                  randconfig-1013-20260918    clang-22
i386                  randconfig-1300-20260918    clang-22   sparse
i386                  randconfig-1301-20260918    clang-22   sparse
i386                  randconfig-1302-20260918    clang-22   sparse
i386                 randconfig-r1301-20260918    gcc-14     sparse
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260918    gcc-16.1.0
loongarch             randconfig-1001-20260918    gcc-16.1.0
loongarch            randconfig-r1302-20260918    gcc-14     sparse
loongarch            randconfig-r1308-20260918    gcc-8.5.0  sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                          amcore_defconfig    gcc-16.1.0
m68k                          apollo_defconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                         m5272c3_defconfig    gcc-16.1.0
m68k                         mvme147_defconfig    gcc-16.1.0
m68k                 randconfig-r1309-20260918    gcc-8.5.0  sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20260918    gcc-16.1.0
nios2                 randconfig-1001-20260918    gcc-16.1.0
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260918    gcc-8.5.0
parisc                randconfig-1001-20260918    gcc-8.5.0
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                       ep88xc_defconfig    gcc-16.1.0
powerpc                      kmeter1_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20260918    gcc-8.5.0
powerpc               randconfig-1001-20260918    gcc-8.5.0
powerpc                   storcenter_defconfig    gcc-16.1.0
powerpc64             randconfig-1000-20260918    gcc-8.5.0
powerpc64             randconfig-1001-20260918    gcc-8.5.0
powerpc64            randconfig-r1304-20260918    gcc-14     sparse
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20260918    clang-24
riscv                 randconfig-1001-20260918    clang-24
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20260918    clang-24
s390                  randconfig-1001-20260918    clang-24
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20260918    clang-24
sh                    randconfig-1001-20260918    clang-24
sh                   randconfig-r1307-20260918    gcc-8.5.0  sparse
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260918    gcc-14
sparc                 randconfig-1001-20260918    gcc-14
sparc                randconfig-r1306-20260918    gcc-8.5.0  sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260918    gcc-14
sparc64               randconfig-1001-20260918    gcc-14
sparc64              randconfig-r1305-20260918    gcc-14     sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260918    gcc-14
um                    randconfig-1001-20260918    gcc-14
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20260918    clang-22
x86_64      buildonly-randconfig-1001-20260918    clang-22
x86_64      buildonly-randconfig-1002-20260918    clang-22
x86_64      buildonly-randconfig-1003-20260918    clang-22
x86_64      buildonly-randconfig-1004-20260918    clang-22
x86_64      buildonly-randconfig-1005-20260918    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20260918    clang-22
x86_64                randconfig-1001-20260918    clang-22
x86_64                randconfig-1002-20260918    clang-22
x86_64                randconfig-1003-20260918    clang-22
x86_64                randconfig-1004-20260918    clang-22
x86_64                randconfig-1005-20260918    clang-22
x86_64                randconfig-1006-20260918    gcc-14
x86_64                randconfig-1007-20260918    gcc-14
x86_64                randconfig-1008-20260918    gcc-14
x86_64                randconfig-1009-20260918    gcc-14
x86_64                randconfig-1010-20260918    gcc-14
x86_64                randconfig-1011-20260918    gcc-14
x86_64                randconfig-1012-20260918    clang-22
x86_64                randconfig-1013-20260918    clang-22
x86_64                randconfig-1014-20260918    clang-22
x86_64                randconfig-1015-20260918    clang-22
x86_64                randconfig-1016-20260918    clang-22
x86_64                randconfig-1017-20260918    clang-22
x86_64                randconfig-1300-20260918    clang-22   sparse
x86_64                randconfig-1301-20260918    clang-22   sparse
x86_64                randconfig-1302-20260918    clang-22   sparse
x86_64               randconfig-r1303-20260918    gcc-14     sparse
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                            alldefconfig    gcc-16.1.0
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20260918    gcc-14
xtensa                randconfig-1001-20260918    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
