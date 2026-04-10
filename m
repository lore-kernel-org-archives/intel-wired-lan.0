Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD62F459FC
	for <intel-wired-lan@archiver.kernel.org>; Fri, 10 Apr 2026 18:55:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFBF04069F;
	Fri, 10 Apr 2026 18:55:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c6JyNN6ibePb; Fri, 10 Apr 2026 18:55:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8E05F4065B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775847305;
	bh=qZVhyYyPgsym/f/nhA3ux+/+ZqigAIe5CzHkm+weIh0=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=D/wGasKVyVuh1zmK0BDcADAAZdMWRW6Zgx75cWG8bYXpRvtnfYB2s0VbN8HYk86Jl
	 RoXZjZxPmryWDfW9B8JSdRmSGuxUxivTyiGjkevWgEvlTSdd9k+00r0bZ/LP2/CJuF
	 gLNkZs+g6JWodfT2m8kit5moU+dZxN3Dd3RptZwoVPDPFqHUPavIBjw1UxSSN375iF
	 RNWUzkTfPVNF8xSgU0l74K0Z2i/A4LHq4D94aGLedWMpyd6YY6tUWeLbgEaQ3NuOl5
	 UpttgsW8jSuMytx8/1ensoHoziFekQs04VVhtUuxjr89pV0gzSZyHfKgVAOpjam1YG
	 MMC2ROmtWWp9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E05F4065B;
	Fri, 10 Apr 2026 18:55:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E73D8237
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 18:55:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E4DFC40906
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 18:55:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zgzE88HD8Zdc for <intel-wired-lan@lists.osuosl.org>;
 Fri, 10 Apr 2026 18:55:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org ECB7840144
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ECB7840144
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ECB7840144
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 18:55:03 +0000 (UTC)
X-CSE-ConnectionGUID: 7VR09620TF+muzbHgmrWuQ==
X-CSE-MsgGUID: Hq64cizqSmKCCVHFCe3Nsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="80736609"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; d="scan'208";a="80736609"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 11:55:04 -0700
X-CSE-ConnectionGUID: Jxh1tMhYSia3wKqzAr0a8w==
X-CSE-MsgGUID: QH9sLMzLQdGW33i2Sjqgeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; d="scan'208";a="228140716"
Received: from lkp-server01.sh.intel.com (HELO 3eaaf1a74b89) ([10.239.97.150])
 by orviesa006.jf.intel.com with ESMTP; 10 Apr 2026 11:55:03 -0700
Received: from kbuild by 3eaaf1a74b89 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wBH0O-0000000005I-07v4;
 Fri, 10 Apr 2026 18:55:00 +0000
Date: Sat, 11 Apr 2026 02:54:54 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202604110247.c2VICp4j-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775847304; x=1807383304;
 h=date:from:to:subject:message-id;
 bh=rpEdPW295monf01+KjU82mG4x/2UoZHNj/d1FKbxX+k=;
 b=NFz+K1a9c4didIZzNOIWRBvCEX4o3oY+8XYjQbWwO/0L+x8dX4KIdC4u
 188lHRAxfPJN8l83QMRN+/S83fKvj2PMKr1zj+8AMo8ZNBHrum93lerR8
 V6gkay7DgSvlKl2PW+tsyAlkd7Pwqd15hRlk3T6AsuJWqH9q6rVbB57Gb
 P8kSMQVyJLFGZhtc5dtYs7v7zGU60Wi/EqRQCakVny3PWoyJwUuptqVHJ
 X8t+Wg+gAgVI50rsL+Q8kF9qwx5lXVyzclj8G2jIh+dxccCO0r+df5DfB
 zbOok9ubIPgw5yNmLfM4rl+DTyVF3yuZeFKcxVpDLUpICKTKOXMYFYZ6O
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=NFz+K1a9
Subject: [Intel-wired-lan] [tnguy-next-queue:main] BUILD SUCCESS
 42f9b4c6ef19e71d2c7d9bfd3c5037d4fe434ad7
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git main
branch HEAD: 42f9b4c6ef19e71d2c7d9bfd3c5037d4fe434ad7  tools: ynl: tests: fix leading space on Makefile target

elapsed time: 777m

configs tested: 55
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-15.2.0
alpha        allyesconfig    gcc-15.2.0
arc          allmodconfig    gcc-15.2.0
arc           allnoconfig    gcc-15.2.0
arc          allyesconfig    gcc-15.2.0
arm           allnoconfig    clang-23
arm          allyesconfig    gcc-15.2.0
arm64        allmodconfig    clang-19
arm64         allnoconfig    gcc-15.2.0
csky         allmodconfig    gcc-15.2.0
csky          allnoconfig    gcc-15.2.0
hexagon      allmodconfig    clang-17
hexagon       allnoconfig    clang-23
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch     allnoconfig    clang-23
m68k         allmodconfig    gcc-15.2.0
m68k          allnoconfig    gcc-15.2.0
m68k         allyesconfig    gcc-15.2.0
microblaze    allnoconfig    gcc-15.2.0
microblaze   allyesconfig    gcc-15.2.0
mips         allmodconfig    gcc-15.2.0
mips          allnoconfig    gcc-15.2.0
mips         allyesconfig    gcc-15.2.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-15.2.0
openrisc      allnoconfig    gcc-15.2.0
parisc       allmodconfig    gcc-15.2.0
parisc        allnoconfig    gcc-15.2.0
parisc       allyesconfig    gcc-15.2.0
powerpc      allmodconfig    gcc-15.2.0
powerpc       allnoconfig    gcc-15.2.0
riscv        allmodconfig    clang-23
riscv         allnoconfig    gcc-15.2.0
riscv        allyesconfig    clang-16
s390         allmodconfig    clang-18
s390          allnoconfig    clang-23
s390         allyesconfig    gcc-15.2.0
sh           allmodconfig    gcc-15.2.0
sh            allnoconfig    gcc-15.2.0
sh           allyesconfig    gcc-15.2.0
sparc         allnoconfig    gcc-15.2.0
sparc64      allmodconfig    clang-23
um           allmodconfig    clang-19
um            allnoconfig    clang-23
um           allyesconfig    gcc-14
x86_64       allmodconfig    clang-20
x86_64        allnoconfig    clang-20
x86_64       allyesconfig    clang-20
x86_64      rhel-9.4-rust    clang-20
xtensa        allnoconfig    gcc-15.2.0
xtensa       allyesconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
