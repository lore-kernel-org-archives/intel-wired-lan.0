Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0ECDCCF2CC
	for <intel-wired-lan@archiver.kernel.org>; Sat, 17 Oct 2026 21:54:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9566F4058B;
	Sat, 17 Oct 2026 21:54:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1fqTozJKRGxJ; Sat, 17 Oct 2026 21:54:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5D404405F3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792274046;
	b=M9A6b9rK4fJLiavQUtA+3RbjAO7XaGTEHIZyhGpzXQeZA1s7RlyCaiQ3SMQK3+fqpArW
	 97RVVwtm5W5xkWZyAlSyB4idzXImvgaBHlIeeF9K1A8vY0qotFNjILRoNyYq8BtHF1og7
	 WAzHBIihu0RbQsHLjqlJFvV7jxaNW7kV8mYQkJ1+/JckYMJAvKiVhY8AtON6B8bZ+8gDx
	 trpEB36wzbwC6AcH3oEjLIcKqOYMJw+cP5GrAPaefc+SKC3/WoSwZ5oZ5ntE9poc7q6wG
	 39NMGqFYJ0m6hmlKO1cTPiWfR8wD0kbF4SBmQLyAA4w678W970MeV4/3KMb5KUdSxzQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792274046;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=bal45jzEP9rdRetyOSMkvWXfTCZwAXDm7u6BvYZz5FY=;
	b=NKzMNJDc+5PLas6jzbJlBoRRHuAzoUOizoLh5KDK/wY2/m7GoywqsfJYH8o5thxPw7Ee
	 fAXE57ZmQGlu/3/HYFvr4ox4BPoC/rkA587biUEb8h4hE+6NCOmCWFYA5Pljc/9sBXXWp
	 8GRrol6EiOSwY2PBkooqxpj6B70/YhFkY1F6HCbnVzMTvsJOb18sXv3dpT3oGXvouEhn6
	 9HWOSv+jnfE22TUw7oIlM9oz2Qva+WStjQ4p6XpgbP0diLoxMHWk9ko1r4dqxXcLlq1ZB
	 MtoaK7pr+TGKK+HXNoO4fGVtrFxTx5VvCcXeUZ5ES8DIUWZl3dH8Ochq2j21wyXGSog==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lGouhEsR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792274046;
	bh=bal45jzEP9rdRetyOSMkvWXfTCZwAXDm7u6BvYZz5FY=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=34BgNtgxwn2SGL7RnF9n7WokEXs1saex+2bEETkFRg+2Ny8QN5Kbx5fYkef7NYlq1
	 X/g57MtcI3QiIpWrr2b2NQvjqnnxCev5tKnG5UPP2CCletsqMDQL2iJBG6JFgcha1F
	 sl3dIo6OGRKo8fRCgHEvV4Ez7udXxJeuuum6b3w2+v49p08IGy4Sc7Fsiz2KfxH2Hf
	 f8tTD6BvbeRbLD8Meg3qeB/wN8u3d0rUpseO8ZyytF4F3/GnwwnqsGq5ohvejMdHyL
	 NzuIZD4xv6C32LVS+kbdDb+6P89AXEFxzPLPX6Y1fUewa5kScmvpef51B/Tun1nftm
	 xPYrWJO99c/Mg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D404405F3;
	Sat, 17 Oct 2026 21:54:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D2B34977
 for <intel-wired-lan@lists.osuosl.org>; Sat, 17 Oct 2026 21:54:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C4BD7405F3
 for <intel-wired-lan@lists.osuosl.org>; Sat, 17 Oct 2026 21:54:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z0ose1kBx0ur for <intel-wired-lan@lists.osuosl.org>;
 Sat, 17 Oct 2026 21:54:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3DCCC4058B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792274043;
 b=lceBW0TgNyD9gPwGtOS1jUz+wug3iIv627R7aSk1yUAGIiD5PZvVn2NsnDNpEPgytegC
 JI83jEy3+/Y8VCJf0HsD/PPkEnVt4kHO2eNZ1nRdO3eVP0Q2LHFhSr1bAsXf93vofDjfe
 l6JdoKdfoTBmcNhLk6aNocYbAWvtquUi+z0vXDS8SMpIONkizwGPCAQsEeHmgKN6zW7/L
 VqMVMLzNkHMzgLZQx9G9Qxr1Ybgy1fX9nYLEXyW7BRLNkkBISX39dP8N9yZOnl5PTnYqz
 2M//c7MrZOTsfw9kXrTU0QXUI0ojd2/EjSslltPGu00Z3/AwPNPSYD26f29R0k2lCcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792274043;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=bal45jzEP9rdRetyOSMkvWXfTCZwAXDm7u6BvYZz5FY=;
 b=R8GtqxCaRzOwriT6b4Qd2QLZwoQgLxgjqKZiu/4W+ggLRTpQJWb5UaALUTAyol+El12d
 O4Eb77KFaliEY6PuLpSQlNOrv6D9vPthSH2AttaI0CvTCGptY4divtcjVqyoBEfHZmIOA
 CeKuJqLieh1tJGcl+x+mP3zfWgh1zXWbI/TO+jWoGAaN6T8vAoEEmPDCClj3IIy3YpPht
 TfHActBOBZ2VRxxgtGMnI49mXbyRSlxsnOm9j0ZCnhJqbUqGRfbC0wIgAhA8aWf64xHny
 q0BtaUPQqZDIg+38MG50GTesocIrnx227d8E2BduRfICv14dNSvjtHjytWDxugwTy0w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=lGouhEsR; 
 arc=none smtp.remote-ip=198.175.65.21
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=lGouhEsR
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3DCCC4058B
 for <intel-wired-lan@lists.osuosl.org>; Sat, 17 Oct 2026 21:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792274043; x=1823810043; h=date:from:to:subject:message-id;
 bh=oTQCRGococWfeaMjxl/tt/DEVAkhX0yirL0AaSvjvKQ=;
 b=lGouhEsR3LezU4Mx3LQEiXvbNjWp8f9kCbg6X6lFgDkaJ6/is9fnjZ4t
 mxy2sAajc2mlYMMLpLfzPZmSSD3sWD6VN/e/q5t4YPC8SacMTkOLd1RM4
 nBHUX3+fvJsnZh57rjiCR+Q00YDjmGdtu8Ob3MBIDOrS/QUJ8TYdN5iLw
 mCPJ1xoya8QKF4gnZ8Q3Ws5uemBjJ7gcYcNnEtKhaYIvdfH6OBPLyyI3Q
 Z8/bvP74vPa3qy7AXirBAZXUejIqHMlHBwRakMIllgnbLv/sVNuur6O4Q
 DZoL2kjNx6p+f8v/SNY48iw1o2hF6rNFm+HFXeB5ZmyCAU6V7fCtMbT4m A==;
X-CSE-ConnectionGUID: dxmdrvmtRcqMs4ZI9Gk3cQ==
X-CSE-MsgGUID: L6V1UAF6QMO59sASBtno1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11938"; a="1117019"
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="1117019"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2026 14:54:00 -0700
X-CSE-ConnectionGUID: L2RJ5TCpSOG4GPJB9vZ53A==
X-CSE-MsgGUID: 12xplIjKSOS/Q7S9YOk8cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="2208547"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa002.jf.intel.com with ESMTP; 17 Oct 2026 14:53:59 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xICLl-00000000Jmq-2GUe;
 Sat, 17 Oct 2026 21:53:57 +0000
Date: Sun, 18 Oct 2026 05:53:37 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:dev-queue] BUILD SUCCESS
 5226f73e730ba58942d16073189f653c6f8dcd50
Message-ID: <202610180535.REBWRCnS-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 5226f73e730ba58942d16073189f653c6f8dcd50  i40e: add devlink parameter for Flow Director ATR sample rate

elapsed time: 1944m

configs tested: 304
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2304-20261016    gcc-11.5.0 sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20261017    gcc-10.5.0
arc                   randconfig-1000-20261018    gcc-8.5.0
arc                   randconfig-1001-20261017    gcc-10.5.0
arc                   randconfig-1001-20261018    gcc-8.5.0
arc                   randconfig-2000-20261016    gcc-8.5.0
arc                   randconfig-2001-20261016    gcc-8.5.0
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                        aspeed_g4_defconfig    gcc-16.1.0
arm                                  defconfig    gcc-16.1.0
arm                         multi_v5_defconfig    clang-24
arm                        netwinder_defconfig    gcc-16.1.0
arm                   randconfig-1000-20261017    gcc-10.5.0
arm                   randconfig-1000-20261018    gcc-8.5.0
arm                   randconfig-1001-20261017    gcc-10.5.0
arm                   randconfig-1001-20261018    gcc-8.5.0
arm                   randconfig-1002-20261017    gcc-10.5.0
arm                   randconfig-1002-20261018    gcc-8.5.0
arm                   randconfig-1003-20261017    gcc-10.5.0
arm                   randconfig-1003-20261018    gcc-8.5.0
arm                   randconfig-2000-20261016    gcc-8.5.0
arm                   randconfig-2001-20261016    gcc-8.5.0
arm                  randconfig-r2110-20261016    gcc-8.5.0  cocci
arm                  randconfig-r2305-20261016    gcc-11.5.0 sparse
arm                          socfpga_defconfig    clang-24
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261017    clang-24
arm64                 randconfig-1000-20261018    gcc-14.3.0
arm64                 randconfig-1001-20261017    clang-24
arm64                 randconfig-1001-20261018    gcc-14.3.0
arm64                 randconfig-1002-20261017    clang-24
arm64                 randconfig-1002-20261018    gcc-14.3.0
arm64                 randconfig-1003-20261017    clang-24
arm64                 randconfig-1003-20261018    gcc-14.3.0
arm64                 randconfig-2000-20261016    gcc-12.5.0
arm64                 randconfig-2001-20261016    gcc-12.5.0
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261017    clang-24
csky                  randconfig-1000-20261018    gcc-14.3.0
csky                  randconfig-1001-20261017    clang-24
csky                  randconfig-1001-20261018    gcc-14.3.0
csky                  randconfig-2000-20261016    gcc-12.5.0
csky                  randconfig-2001-20261016    gcc-12.5.0
csky                 randconfig-r2103-20261016    gcc-16.1.0 cocci
csky                 randconfig-r2108-20261016    gcc-16.1.0 cocci
csky                 randconfig-r2109-20261016    gcc-16.1.0 cocci
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261017    clang-21
hexagon               randconfig-1000-20261018    clang-21
hexagon               randconfig-1001-20261017    clang-21
hexagon               randconfig-1001-20261018    clang-21
hexagon               randconfig-2000-20261016    gcc-12.5.0
hexagon               randconfig-2001-20261016    gcc-12.5.0
hexagon              randconfig-r2106-20261016    gcc-8.5.0  cocci
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261017    gcc-14
i386        buildonly-randconfig-1001-20261017    gcc-14
i386        buildonly-randconfig-1002-20261017    gcc-14
i386        buildonly-randconfig-1003-20261017    gcc-14
i386        buildonly-randconfig-1004-20261017    gcc-14
i386        buildonly-randconfig-1005-20261017    gcc-14
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261017    clang-22
i386                  randconfig-1001-20261017    clang-22
i386                  randconfig-1002-20261017    clang-22
i386                  randconfig-1003-20261017    clang-22
i386                  randconfig-1004-20261017    clang-22
i386                  randconfig-1005-20261017    clang-22
i386                  randconfig-1006-20261017    clang-22
i386                  randconfig-1007-20261017    clang-22
i386                  randconfig-1008-20261017    clang-22
i386                  randconfig-1009-20261017    clang-22
i386                  randconfig-1010-20261017    clang-22
i386                  randconfig-1011-20261017    clang-22
i386                  randconfig-1012-20261017    clang-22
i386                  randconfig-1013-20261017    clang-22
i386                  randconfig-2000-20261016    gcc-8.5.0
i386                  randconfig-2001-20261016    gcc-8.5.0
i386                  randconfig-2100-20261016    clang-22   cocci
i386                  randconfig-2101-20261016    clang-22   cocci
i386                  randconfig-2102-20261016    clang-22   cocci
i386                  randconfig-2103-20261016    clang-22   cocci
i386                  randconfig-2104-20261016    clang-22   cocci
i386                  randconfig-2105-20261016    clang-22   cocci
i386                  randconfig-2200-20261016    clang-22   smatch
i386                  randconfig-2300-20261016    clang-22   sparse
i386                  randconfig-2301-20261016    clang-22   sparse
i386                  randconfig-2302-20261016    clang-22   sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261017    clang-21
loongarch             randconfig-1000-20261018    clang-21
loongarch             randconfig-1001-20261017    clang-21
loongarch             randconfig-1001-20261018    clang-21
loongarch             randconfig-2000-20261016    gcc-11.5.0
loongarch             randconfig-2001-20261016    gcc-11.5.0
loongarch            randconfig-r2301-20261016    gcc-11.5.0 sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                   cavium_octeon_defconfig    clang-24
mips                   cavium_octeon_defconfig    gcc-16.1.0
mips                      loongson2k_defconfig    clang-24
mips                 randconfig-r2200-20261016    clang-24   smatch
mips                    sb1250_swarm_defconfig    clang-24
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261017    clang-21
nios2                 randconfig-1000-20261018    clang-21
nios2                 randconfig-1001-20261017    clang-21
nios2                 randconfig-1001-20261018    clang-21
nios2                 randconfig-2000-20261016    gcc-11.5.0
nios2                 randconfig-2001-20261016    gcc-11.5.0
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2100-20261016    gcc-16.1.0 cocci
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20261017    gcc-15.2.0
parisc                randconfig-1000-20261018    clang-24
parisc                randconfig-1001-20261017    gcc-15.2.0
parisc                randconfig-1001-20261018    clang-24
parisc                randconfig-2000-20261016    gcc-11.5.0
parisc                randconfig-2001-20261016    gcc-11.5.0
parisc               randconfig-r2202-20261016    gcc-8.5.0  smatch
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                       ep88xc_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20261017    gcc-15.2.0
powerpc               randconfig-1000-20261018    clang-24
powerpc               randconfig-1001-20261017    gcc-15.2.0
powerpc               randconfig-1001-20261018    clang-24
powerpc              randconfig-r2105-20261016    gcc-8.5.0  cocci
powerpc              randconfig-r2111-20261016    gcc-8.5.0  cocci
powerpc                     socrates_defconfig    gcc-16.1.0
powerpc                      tqm8548_defconfig    clang-24
powerpc64             randconfig-1000-20261017    gcc-15.2.0
powerpc64             randconfig-1000-20261018    clang-24
powerpc64             randconfig-1001-20261017    gcc-15.2.0
powerpc64             randconfig-1001-20261018    clang-24
powerpc64            randconfig-r2101-20261016    gcc-16.1.0 cocci
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261017    clang-19
riscv                 randconfig-1000-20261018    clang-17
riscv                 randconfig-1001-20261017    clang-19
riscv                 randconfig-1001-20261018    clang-17
riscv                 randconfig-2000-20261016    gcc-16.1.0
riscv                 randconfig-2001-20261016    gcc-16.1.0
riscv                randconfig-r2300-20261016    gcc-11.5.0 sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261017    clang-19
s390                  randconfig-1000-20261018    clang-17
s390                  randconfig-1001-20261017    clang-19
s390                  randconfig-1001-20261018    clang-17
s390                  randconfig-2000-20261016    gcc-16.1.0
s390                  randconfig-2001-20261016    gcc-16.1.0
sh                                alldefconfig    gcc-16.1.0
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                             migor_defconfig    gcc-16.1.0
sh                    randconfig-1000-20261017    clang-19
sh                    randconfig-1000-20261018    clang-17
sh                    randconfig-1001-20261017    clang-19
sh                    randconfig-1001-20261018    clang-17
sh                    randconfig-2000-20261016    gcc-16.1.0
sh                    randconfig-2001-20261016    gcc-16.1.0
sh                           rsk7264_defconfig    gcc-16.1.0
sh                           rsk7269_defconfig    clang-24
sh                            sh2007_defconfig    clang-24
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261017    gcc-15.2.0
sparc                 randconfig-1000-20261018    clang-24
sparc                 randconfig-1001-20261017    gcc-15.2.0
sparc                 randconfig-1001-20261018    clang-24
sparc                 randconfig-2000-20261016    gcc-12.5.0
sparc                 randconfig-2001-20261016    gcc-12.5.0
sparc                randconfig-r2102-20261016    gcc-16.1.0 cocci
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261017    gcc-15.2.0
sparc64               randconfig-1000-20261018    clang-24
sparc64               randconfig-1001-20261017    gcc-15.2.0
sparc64               randconfig-1001-20261018    clang-24
sparc64               randconfig-2000-20261016    gcc-12.5.0
sparc64               randconfig-2001-20261016    gcc-12.5.0
sparc64              randconfig-r2104-20261016    gcc-8.5.0  cocci
sparc64              randconfig-r2201-20261016    gcc-12.5.0 smatch
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261017    gcc-15.2.0
um                    randconfig-1000-20261018    clang-24
um                    randconfig-1001-20261017    gcc-15.2.0
um                    randconfig-1001-20261018    clang-24
um                    randconfig-2000-20261016    gcc-12.5.0
um                    randconfig-2001-20261016    gcc-12.5.0
um                   randconfig-r2107-20261016    gcc-8.5.0  cocci
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261017    gcc-14
x86_64      buildonly-randconfig-1000-20261018    clang-22
x86_64      buildonly-randconfig-1001-20261017    gcc-14
x86_64      buildonly-randconfig-1001-20261018    clang-22
x86_64      buildonly-randconfig-1002-20261017    gcc-14
x86_64      buildonly-randconfig-1002-20261018    clang-22
x86_64      buildonly-randconfig-1003-20261017    gcc-14
x86_64      buildonly-randconfig-1003-20261018    clang-22
x86_64      buildonly-randconfig-1004-20261017    gcc-14
x86_64      buildonly-randconfig-1004-20261018    clang-22
x86_64      buildonly-randconfig-1005-20261017    gcc-14
x86_64      buildonly-randconfig-1005-20261018    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261017    gcc-14
x86_64                randconfig-1001-20261017    gcc-14
x86_64                randconfig-1002-20261017    gcc-14
x86_64                randconfig-1003-20261017    gcc-14
x86_64                randconfig-1004-20261017    gcc-14
x86_64                randconfig-1005-20261017    gcc-14
x86_64                randconfig-1006-20261017    clang-22
x86_64                randconfig-1007-20261017    clang-22
x86_64                randconfig-1008-20261017    clang-22
x86_64                randconfig-1009-20261017    clang-22
x86_64                randconfig-1010-20261017    clang-22
x86_64                randconfig-1011-20261017    clang-22
x86_64                randconfig-1012-20261017    clang-22
x86_64                randconfig-1013-20261017    clang-22
x86_64                randconfig-1014-20261017    clang-22
x86_64                randconfig-1015-20261017    clang-22
x86_64                randconfig-1016-20261017    clang-22
x86_64                randconfig-1017-20261017    clang-22
x86_64                randconfig-2100-20261016    clang-22   cocci
x86_64                randconfig-2101-20261016    clang-22   cocci
x86_64                randconfig-2102-20261016    clang-22   cocci
x86_64                randconfig-2103-20261016    clang-22   cocci
x86_64                randconfig-2104-20261016    clang-22   cocci
x86_64                randconfig-2105-20261016    clang-22   cocci
x86_64                randconfig-2200-20261016    gcc-14     smatch
x86_64                randconfig-2300-20261016    clang-22   sparse
x86_64                randconfig-2301-20261016    clang-22   sparse
x86_64                randconfig-2302-20261016    clang-22   sparse
x86_64               randconfig-r2303-20261016    gcc-11.5.0 sparse
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
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261017    gcc-15.2.0
xtensa                randconfig-1000-20261018    clang-24
xtensa                randconfig-1001-20261017    gcc-15.2.0
xtensa                randconfig-1001-20261018    clang-24
xtensa                randconfig-2000-20261016    gcc-12.5.0
xtensa                randconfig-2001-20261016    gcc-12.5.0
xtensa               randconfig-r2302-20261016    gcc-11.5.0 sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
