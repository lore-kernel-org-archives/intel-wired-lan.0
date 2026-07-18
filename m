Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA819C4451B
	for <intel-wired-lan@archiver.kernel.org>; Sat, 18 Jul 2026 08:27:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6BB7A811D8;
	Sat, 18 Jul 2026 08:27:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id STxY9AHqO1xM; Sat, 18 Jul 2026 08:27:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9FBC381008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784363254;
	bh=sKn+6XrSLkOA8D2G4fW6mxmB/O/8nVAftnXUy1y02UU=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JG2aWTxhVDks+NWfxUeeBK6Perv221TwVr488CdJ7fVLwh0BaGm4U7AwSsmLMC4qD
	 E4ZE/UutEVGlTF0S9sOGfoeUxnllf7EysMnr/Rm1WU87gO2vL2NO6lPaeI1QEI4fr2
	 IJSZ+SpJ7NayrmlBXpuVnGsjHGA8Vfmqe7ae3aUYKlZez6qW7uhrIFOS0VNLhKrq70
	 M/dSL2Xhm8E8HG23SYqDOTDmqmZR23EtF4jJBhGkAm8woxxuehAWEYHX4RrJ3fSGIn
	 JobAW269zKN6q7xeBoWEc/J9KLY/TIpYOzCWzc1bHzi80d83O4ex4lWJ+8AEI2jF7L
	 KT2ygD25HSYGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9FBC381008;
	Sat, 18 Jul 2026 08:27:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 545DF320
 for <intel-wired-lan@lists.osuosl.org>; Sat, 18 Jul 2026 08:27:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 497896078E
 for <intel-wired-lan@lists.osuosl.org>; Sat, 18 Jul 2026 08:27:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZSxjPKyv6Zt3 for <intel-wired-lan@lists.osuosl.org>;
 Sat, 18 Jul 2026 08:27:32 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 247F1606BA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 247F1606BA
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 247F1606BA
 for <intel-wired-lan@lists.osuosl.org>; Sat, 18 Jul 2026 08:27:31 +0000 (UTC)
X-CSE-ConnectionGUID: Pm27uv20SxSC1u3EmoJ8yg==
X-CSE-MsgGUID: 8UibEASFSOyeLoE8LUJmvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="84006460"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; d="scan'208";a="84006460"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2026 01:27:31 -0700
X-CSE-ConnectionGUID: puaU9ig0TlCglMiL0MN8PA==
X-CSE-MsgGUID: EAytlCGKT6qzMElkBMiO3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; d="scan'208";a="254355153"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
 by fmviesa008.fm.intel.com with ESMTP; 18 Jul 2026 01:27:31 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wl0OO-00000000Tav-1rQE;
 Sat, 18 Jul 2026 08:27:28 +0000
Date: Sat, 18 Jul 2026 16:27:09 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202607181658.5oXbMgQs-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784363252; x=1815899252;
 h=date:from:to:subject:message-id;
 bh=e+PYGHHLjnSL91IU5TjZjohRZabuXXHKgZR9PwJtVAE=;
 b=LP8sWgcecyCGnb8TQM129bqWMRnv03RwZOjhAK1LL0Plrf7iqN4jeY0n
 1lqn01EqoKjFUCdbPUdozZf58q8g48YSxrmnDulmiR0Pg60KiNAmO4hbp
 EFOL4/b0Z75Y0ZzvX/M1RGGjHttC8YIj8yCeF6qqf6Uolcf/cQDBGuqJc
 6eQw8AqrgMsUOIe0/RaqLHmyl3nCv77X3MCpW0vtaEHkSvwBYJAo8vGRu
 4N1D1+M7jpZ6IqNdal0jdQN7Uigek+l8CCatLDiA6dJF7QBY6Bx0EK1yc
 MQ+6B+pZAIuVoQlqjxH7MNi5TITVrCnvw438WWjh7S7HC92icA5JM08gM
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=LP8sWgce
Subject: [Intel-wired-lan] [tnguy-net-queue:100GbE] BUILD SUCCESS
 ea8a3d8edaf4f1c4477eaec1541a6536b8c1c6d3
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 100GbE
branch HEAD: ea8a3d8edaf4f1c4477eaec1541a6536b8c1c6d3  iavf: validate num_vsis in VIRTCHNL_OP_GET_VF_RESOURCES response

elapsed time: 773m

configs tested: 53
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                           randconfig-001    gcc-8.5.0
arc                  randconfig-001-20260718    gcc-12.5.0
arc                  randconfig-002-20260718    gcc-10.5.0
arm                  randconfig-001-20260718    clang-17
arm                  randconfig-002-20260718    clang-17
arm                  randconfig-003-20260718    gcc-10.5.0
arm                  randconfig-004-20260718    gcc-8.5.0
arm64                randconfig-001-20260718    clang-17
arm64                randconfig-002-20260718    clang-17
arm64                randconfig-003-20260718    clang-17
arm64                randconfig-004-20260718    clang-21
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260718    gcc-14.3.0
csky                 randconfig-002-20260718    gcc-16.1.0
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260718    gcc-14
i386       buildonly-randconfig-002-20260718    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260718    clang-18
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260718    gcc-11.5.0
nios2                randconfig-002-20260718    gcc-8.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260718    gcc-9.5.0
parisc               randconfig-002-20260718    gcc-11.5.0
powerpc                 mpc885_ads_defconfig    clang-24
powerpc              randconfig-001-20260718    clang-24
powerpc              randconfig-002-20260718    gcc-16.1.0
powerpc64            randconfig-002-20260718    clang-17
riscv                randconfig-001-20260718    gcc-16.1.0
riscv                randconfig-002-20260718    clang-24
s390                 randconfig-001-20260718    gcc-13.4.0
s390                 randconfig-002-20260718    gcc-15.2.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260718    gcc-16.1.0
sh                   randconfig-002-20260718    gcc-16.1.0
sparc                         randconfig-001    gcc-16.1.0
sparc                randconfig-001-20260718    gcc-11.5.0
sparc                randconfig-002-20260718    gcc-8.5.0
sparc64              randconfig-001-20260718    gcc-8.5.0
sparc64              randconfig-002-20260718    gcc-13.4.0
um                   randconfig-001-20260718    gcc-14
um                   randconfig-002-20260718    gcc-14
xtensa               randconfig-001-20260718    gcc-11.5.0
xtensa               randconfig-002-20260718    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
