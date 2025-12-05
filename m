Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8DBD2CDF7
	for <intel-wired-lan@archiver.kernel.org>; Fri,  5 Dec 2025 01:04:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ABE4A80D1A;
	Fri,  5 Dec 2025 01:04:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8PY-wWEI3AkJ; Fri,  5 Dec 2025 01:04:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D999F80D53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1764896690;
	bh=vNP9+SMPPuDzvD8WwG5MoYONv6lJr53SvbRw72S4hrk=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FWcfED6ZWzr6t8xXTqCh/kXHnzxkvL9CcCHpMksia3ywOMB1Ufyn2gejD0DHj8o72
	 RVbxuvut1eFlXxLlnuc0QQTl2rpYePX3IU4E5VkiEh8SIV1iSdT35BgupctJNsSo6p
	 qsz+4hHTAOJQ6Z9cWswjydInVJIovl13wler3vxxqSnad0L2KWaAQXq2vS/3EDA7cz
	 if9N3X+3D+Ox9JINYtxRL/x8VcGUHsVAvDQzwOzrlvMbwu0nmUxHTF7QXkOuW0Zb9Q
	 JqHvSeUD9mueNkgyBF1lcd9rbryYcELuTH3zJJ6OqpTZxZ7nGZbotrnjT6YX3qlOis
	 l+oIuKRadyVcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D999F80D53;
	Fri,  5 Dec 2025 01:04:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 74F8F345
 for <intel-wired-lan@lists.osuosl.org>; Fri,  5 Dec 2025 01:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5B81660A66
 for <intel-wired-lan@lists.osuosl.org>; Fri,  5 Dec 2025 01:04:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sqe0HxnUAPJl for <intel-wired-lan@lists.osuosl.org>;
 Fri,  5 Dec 2025 01:04:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org BF5BA6090C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BF5BA6090C
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BF5BA6090C
 for <intel-wired-lan@lists.osuosl.org>; Fri,  5 Dec 2025 01:04:47 +0000 (UTC)
X-CSE-ConnectionGUID: rvt3pOJ/RfaSsOdtDL59Cw==
X-CSE-MsgGUID: ujsnLZacQ7Ovm+/kJiwy4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="66863955"
X-IronPort-AV: E=Sophos;i="6.20,250,1758610800"; d="scan'208";a="66863955"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2025 17:04:47 -0800
X-CSE-ConnectionGUID: kVKVZkZzTpeeAqQckvNe0Q==
X-CSE-MsgGUID: A6cEt0ANRr6ACk1NWQFA1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,250,1758610800"; d="scan'208";a="194799790"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
 by fmviesa007.fm.intel.com with ESMTP; 04 Dec 2025 17:04:46 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1vRKFX-00000000EQE-3esC
 for intel-wired-lan@lists.osuosl.org; Fri, 05 Dec 2025 01:04:43 +0000
Date: Fri, 05 Dec 2025 09:04:27 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202512050920.t3ULM4Mn-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764896688; x=1796432688;
 h=date:from:to:subject:message-id;
 bh=qiwrZD8lPX8PGmTP2l5VldTdbKpba50lUWPtgu4Wuwg=;
 b=djnnGRbsOWR6RbiyJthszmmwxm9BfNmcf0vxebAxYQFaJqu35nayNkqK
 zVA001yUPlsjT5omfYcFsqennoktzEartAq1HFHxqwRC5Aj4xzLhcq3eh
 wR8ViZoFJKx0rTAoMMAF30o/yWYcmJn+Oz5Zelp/MXA4vxhw6CBFrvtWL
 EkVUU1rWW9IOYmZ3oonA5CGOt0LcdwQyQmMpQFWCKERmzmhABYERsPUfc
 RMMtQi7GfevFIeAuVtaBL+LaXSuNfTbk/zdi+DQkXLoPKXVsBTep5gAWy
 af8Ivk4sMxuTDXDsatRoTO+V0WeQutUQV3MvfhbTrXZIpOHHuDuxIQvNq
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=djnnGRbs
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS WITH
 UNVERIFIED WARNING b8ceeacaba537294e383161a87e09b939ecd7d1d
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: b8ceeacaba537294e383161a87e09b939ecd7d1d  ice: stop counting UDP csum mismatch as rx_errors

Unverified Warning (likely false positive, kindly check if interested):

    drivers/net/ethernet/intel/idpf/idpf_ethtool.c:252 idpf_add_flow_steer() warn: missing error code 'err'

Warning ids grouped by kconfigs:

recent_errors
`-- s390-randconfig-r072-20251204
    `-- drivers-net-ethernet-intel-idpf-idpf_ethtool.c-idpf_add_flow_steer()-warn:missing-error-code-err

elapsed time: 1538m

configs tested: 105
configs skipped: 1

tested configs:
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                   randconfig-001-20251205    gcc-8.5.0
arc                   randconfig-002-20251205    gcc-9.5.0
arm                       aspeed_g4_defconfig    clang-22
arm                         lpc32xx_defconfig    clang-17
arm                   randconfig-001-20251205    gcc-8.5.0
arm                   randconfig-002-20251205    gcc-8.5.0
arm                   randconfig-003-20251205    gcc-13.4.0
arm                   randconfig-004-20251205    gcc-8.5.0
arm                         wpcm450_defconfig    gcc-15.1.0
arm64                 randconfig-001-20251205    clang-22
arm64                 randconfig-002-20251205    clang-22
arm64                 randconfig-003-20251205    gcc-8.5.0
arm64                 randconfig-004-20251205    clang-22
csky                  randconfig-001-20251205    gcc-15.1.0
csky                  randconfig-002-20251205    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon               randconfig-001-20251205    clang-22
hexagon               randconfig-002-20251205    clang-22
i386                             allmodconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251204    gcc-14
i386        buildonly-randconfig-002-20251204    clang-20
i386        buildonly-randconfig-003-20251204    clang-20
i386        buildonly-randconfig-004-20251204    gcc-14
i386        buildonly-randconfig-005-20251204    clang-20
i386        buildonly-randconfig-006-20251204    clang-20
i386                  randconfig-001-20251205    clang-20
i386                  randconfig-002-20251205    gcc-14
i386                  randconfig-003-20251205    clang-20
i386                  randconfig-004-20251205    clang-20
i386                  randconfig-005-20251205    gcc-14
i386                  randconfig-006-20251205    clang-20
i386                  randconfig-007-20251205    gcc-14
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251205    clang-22
loongarch             randconfig-002-20251205    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
microblaze                      mmu_defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
nios2                            alldefconfig    gcc-11.5.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251205    gcc-10.5.0
nios2                 randconfig-002-20251205    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251205    gcc-8.5.0
parisc                randconfig-002-20251205    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                  mpc866_ads_defconfig    clang-22
powerpc               randconfig-001-20251205    clang-18
powerpc               randconfig-002-20251205    clang-18
powerpc                    sam440ep_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251205    gcc-15.1.0
powerpc64             randconfig-002-20251205    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20251205    gcc-13.4.0
riscv                 randconfig-002-20251205    gcc-8.5.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20251205    gcc-11.5.0
s390                  randconfig-002-20251205    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251205    gcc-13.4.0
sh                    randconfig-002-20251205    gcc-12.5.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20251205    gcc-14.3.0
sparc                 randconfig-002-20251205    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251205    gcc-8.5.0
sparc64               randconfig-002-20251205    gcc-10.5.0
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                    randconfig-001-20251205    gcc-14
um                    randconfig-002-20251205    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251205    clang-20
x86_64      buildonly-randconfig-002-20251205    gcc-14
x86_64      buildonly-randconfig-003-20251205    gcc-12
x86_64      buildonly-randconfig-004-20251205    clang-20
x86_64      buildonly-randconfig-005-20251205    clang-20
x86_64      buildonly-randconfig-006-20251205    gcc-14
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                       common_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251205    gcc-10.5.0
xtensa                randconfig-002-20251205    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
