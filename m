Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71AE4CCA46C
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Oct 2026 03:24:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 139D660603;
	Mon, 19 Oct 2026 03:24:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RHvBimIajWoe; Mon, 19 Oct 2026 03:24:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1256060606
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792380252;
	b=coEIcbW7P/wkzJnyk+QoZK1Wvsv+8dLPYBssiosEccq2Qeev2pQAahkQi6Eoce/0VnSO
	 a+7ekxSYOGpmU0tFJi+Dar9LMP8nTy5PDKXOsOgClDZdA8wwHRM8jc9MOX6O+TcGrQm7S
	 hEgCEUyJGqJ2A86VkS7vjDJbVRH52FmN1bdNkGQY1iJCmvZK19kTOougZiQrqGs6JmE1Z
	 wOdAcHv9j+dWUQi1JgN/i5ZKLZ+ixXQKoESPo5qvZeLyqWhPqeYoeGowd2BHzXsr3mASJ
	 o8ANETi1+druOPEucQRGELTbTWlJHt4xLPvD8n5aSvtO//4D8DxppHdkuAQVXfVXHag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792380252;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=uXh+UN2lr8HvJJATBwJN8kHUnmE0tSQQmyozfWYUOO0=;
	b=hmfJZGFEdolLR6VptDCDagXJ3DFCtW5f3N0So508nslFgwbYiuQ3BtiF9EkHc9hUDuHY
	 YwK5St5vVqEfh4WdrlI98QVFWKyAdeVfAayYzgeHc4piUZc33ZwkBr6lotMYI/oE7dt71
	 1Eos+30OvG1DXHT8n5LKZqC5fgUpgBaQetY6D5EabS7nhFnYBB+hVUCDikaJg/3Zq7GyY
	 BZvKm3DkFbiHGST0FnWyJ3ugFH9wa3/LI1mnLVb4HazN3AMAISXgKoT+qQ9JoceHhuMcB
	 bp1rfOBAqwTrrkCTuEicZr186HIW9cx2Cbf6BfK6CgWGuaI9M7zDRMNCefik1ix/cbg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792380252;
	bh=uXh+UN2lr8HvJJATBwJN8kHUnmE0tSQQmyozfWYUOO0=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rTJn+PKzAOz6qlAPDGAIs4nj8YHzMCk2wqqvgLoV4hfXmlKypNpty3ZKbiSnBDjzU
	 KNTNYB0q1mPOQu2AEsmzoUj8jQ1wWH24MajKM8+C9zBq7Og9cAWLVqYLx9ljtUKXXy
	 KK6EFwGzyqyASWRhAg0Uq/C0oTNzFqb/2j/kWsHHHt0GED0WNDAT3adgegt83FRXgj
	 6zb36pIkz5zADAb9RZQfKkXaaBojpCQPcbA8k2940bsuGTs18cnMOT1WodnJwNDYG9
	 6YXZdmhmg37CKNV/3tOASFZzB79CC3d4GZ/N4qugq/llmIdLVcaT9+S77XaPJ1CiQ5
	 oG4Ijbg30PIAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1256060606;
	Mon, 19 Oct 2026 03:24:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E98D92A8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 03:24:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CF9944056C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 03:24:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VncJas3Td6oU for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Oct 2026 03:24:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A83264056B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792380249;
 b=hiS7pWKVSwjR8KYiALw4XgKZw0VUZt5w5icraSYL/YUqt6QwYlcYGOJWDFwweuyH4SZb
 lfZeDJJmALc0FlAjrCUgtRdpYYhnASMfk53mYIR5MC4kzrjzbdCU+tM2d0em0kRa8yoCS
 NE23CVWIYdiO4qNHlp/MfqTFI91d5WZq8Gw4bBxNUbdVE3fE1p4Lw6TKLhn215zjwJ8Sx
 qDkF0BgdUTyOYJWGSU13XXrQ9+Ky2g3MP8nJHNAbN9pNnypeREf6VVf6mHeXXRg6bsm3U
 RQuOuUkaZniVH4d+cC77dnEFOLFFIbhN18Bxra1vsOOxiWDwVHUXqGTMD9luRheK/iA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792380249;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=uXh+UN2lr8HvJJATBwJN8kHUnmE0tSQQmyozfWYUOO0=;
 b=ql8lsyd6oOpNeXelEj+cCmEWtH4F3W19A3TMRHTYnU/SF4QrBbnHbpAR/o5WGTNP+ekX
 iX8iYj6/KwOE+8bQ8hcTLnOB+37NKd36SHXUpH3QFJpbRU6olCYmnLM3OsnbaRNwzhvCB
 FnFnC/T69kFJjTUozu8QsHoblVyW3BAAjb/CHwWj43HDG360yeBhMb2oSHsgK1L7pCJ/J
 DBx9RIYn3lTCxnc+sUSKN5FgSGcoWgAjzm7kM9zY9QyUwXLp4H2W2VJKHJls6P7CXzsHL
 wgMdbfYIJQq77jVaEQmc5rTcEf+fpPx0nY4PCtx3twP2PfDmWAN8znrp4BvSyTWZOBQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=UZxr7yl0; 
 arc=none smtp.remote-ip=198.175.65.21
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=UZxr7yl0
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A83264056B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 03:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792380250; x=1823916250; h=date:from:to:subject:message-id;
 bh=iMsEHehA7hdAv/88A/rZpWu9J2UUa9gHesCA/PeOIvY=;
 b=UZxr7yl0bvPFfdwjHfJggxqxv+LW5jceNXlrRj/WsMOmSsAzG+tXkOn6
 Nqw+2C5aHYMPZr6PerUIxzOH+0T6TYfpA1L2JK8FwTZRYeNOTZJMvZbKT
 9cz20CRkvnFb+wgd8m3sM5nzRNCRELWuSNP9TdmOZ2NM3e0sqxBK4NoPq
 gSUy12n6F8aN+PTpGWYEmhohzj1AszjgU5YNDyDg6EHCh5j58dhHYeJAq
 2rbdk9LY2wb9qcQbKR56cAL/78jZB0FtukoDhiQFhUsxiRY7np9OFCGAK
 N6gRCh0K/AjqET+3hkxcpDQl06aiX/CObw0YvkZxa/W10ZcXztfa3cZp7 A==;
X-CSE-ConnectionGUID: Rb3DKE7fQmutRXo0iop/+A==
X-CSE-MsgGUID: IKFMQIBiQEmyq0UdKHboiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1160602"
X-IronPort-AV: E=Sophos;i="6.27,166,1787036400"; 
   d="scan'208";a="1160602"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2026 20:24:09 -0700
X-CSE-ConnectionGUID: dKu8o39uQKqGY//0wNWqfA==
X-CSE-MsgGUID: 3fCzvbZvSqW1SVCB2CmmoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,166,1787036400"; 
   d="scan'208";a="4177316"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa012.fm.intel.com with ESMTP; 18 Oct 2026 20:24:07 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xIdym-00000000LC2-23Sk;
 Mon, 19 Oct 2026 03:24:04 +0000
Date: Mon, 19 Oct 2026 11:23:20 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:100GbE] BUILD SUCCESS
 95a5c641fc7becab441bf244baa73b0b0f8b7dea
Message-ID: <202610191118.WzpfmNUm-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 100GbE
branch HEAD: 95a5c641fc7becab441bf244baa73b0b0f8b7dea  usbnet: fix smp_processor_id() use in preemptible context

elapsed time: 1296m

configs tested: 174
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                   randconfig-1000-20261019    clang-21
arc                   randconfig-1001-20261019    clang-21
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                       integrator_defconfig    gcc-16.2.0
arm                           pxa3xx_defconfig    gcc-16.2.0
arm                   randconfig-1000-20261019    clang-21
arm                   randconfig-1001-20261019    clang-21
arm                   randconfig-1002-20261019    clang-21
arm                   randconfig-1003-20261019    clang-21
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261019    clang-24
arm64                 randconfig-1001-20261019    clang-24
arm64                 randconfig-1002-20261019    clang-24
arm64                 randconfig-1003-20261019    clang-24
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261019    clang-24
csky                  randconfig-1001-20261019    clang-24
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261019    clang-24
hexagon               randconfig-1001-20261019    clang-24
i386                               allnoconfig    gcc-16.2.0
i386        buildonly-randconfig-1000-20261018    clang-22
i386        buildonly-randconfig-1001-20261018    clang-22
i386        buildonly-randconfig-1002-20261018    clang-22
i386        buildonly-randconfig-1003-20261018    clang-22
i386        buildonly-randconfig-1004-20261018    clang-22
i386        buildonly-randconfig-1005-20261018    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261019    clang-22
i386                  randconfig-1001-20261019    clang-22
i386                  randconfig-1002-20261019    clang-22
i386                  randconfig-1003-20261019    clang-22
i386                  randconfig-1004-20261019    clang-22
i386                  randconfig-1005-20261019    clang-22
i386                  randconfig-1006-20261019    clang-22
i386                  randconfig-1007-20261018    gcc-14
i386                  randconfig-1008-20261018    gcc-14
i386                  randconfig-1009-20261018    gcc-14
i386                  randconfig-1010-20261018    gcc-14
i386                  randconfig-1011-20261018    gcc-14
i386                  randconfig-1012-20261018    gcc-14
i386                  randconfig-1013-20261018    gcc-14
i386                  randconfig-2200-20261018    gcc-14     smatch
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261019    clang-24
loongarch             randconfig-1001-20261019    clang-24
loongarch             randconfig-2001-20261018    clang-24
loongarch            randconfig-r2202-20261018    clang-24   smatch
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                             mac_defconfig    gcc-16.2.0
m68k                 randconfig-r2301-20261018    gcc-8.5.0  sparse
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                        rbtx49xx_defconfig    gcc-16.2.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261019    clang-24
nios2                 randconfig-1001-20261019    clang-24
nios2                randconfig-r2305-20261018    gcc-9.5.0  sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261018    clang-24
parisc                randconfig-1001-20261018    clang-24
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc               randconfig-1000-20261018    clang-24
powerpc               randconfig-1001-20261018    clang-24
powerpc64             randconfig-1000-20261018    clang-24
powerpc64             randconfig-1001-20261018    clang-24
powerpc64            randconfig-r2200-20261018    gcc-8.5.0  smatch
powerpc64            randconfig-r2300-20261018    clang-18   sparse
powerpc64            randconfig-r2303-20261018    clang-24   sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261018    clang-17
riscv                 randconfig-1001-20261018    clang-17
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261018    clang-17
s390                  randconfig-1001-20261018    clang-17
s390                 randconfig-r2304-20261018    gcc-15.2.0 sparse
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20261018    clang-17
sh                    randconfig-1001-20261018    clang-17
sh                   randconfig-r2302-20261018    gcc-14.3.0 sparse
sh                           rsk7264_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261019    clang-20
sparc                 randconfig-1001-20261019    clang-20
sparc                        sparc64_defconfig    gcc-16.2.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261019    clang-20
sparc64               randconfig-1001-20261019    clang-20
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261019    clang-20
um                    randconfig-1001-20261019    clang-20
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-24
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261018    clang-22
x86_64                randconfig-1001-20261018    clang-22
x86_64                randconfig-1002-20261018    clang-22
x86_64                randconfig-1003-20261018    clang-22
x86_64                randconfig-1004-20261018    clang-22
x86_64                randconfig-1005-20261018    clang-22
x86_64                randconfig-1006-20261018    clang-22
x86_64                randconfig-1007-20261018    clang-22
x86_64                randconfig-1008-20261018    clang-22
x86_64                randconfig-1009-20261018    clang-22
x86_64                randconfig-1010-20261018    clang-22
x86_64                randconfig-1011-20261018    clang-22
x86_64                randconfig-1012-20261019    gcc-14
x86_64                randconfig-1013-20261019    gcc-14
x86_64                randconfig-1014-20261019    gcc-14
x86_64                randconfig-1015-20261019    gcc-14
x86_64                randconfig-1016-20261019    gcc-14
x86_64                randconfig-1017-20261019    gcc-14
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261019    clang-20
xtensa                randconfig-1001-20261019    clang-20
xtensa                          virt_defconfig    gcc-16.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
