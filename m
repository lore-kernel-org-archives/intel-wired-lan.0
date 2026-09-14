Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A78C88E72
	for <intel-wired-lan@archiver.kernel.org>; Mon, 14 Sep 2026 17:40:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5832E80C97;
	Mon, 14 Sep 2026 17:40:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wk0jpJ4Rn4xL; Mon, 14 Sep 2026 17:40:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0BFAC80C6E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789407627;
	b=scEgqSSVdk5Puekv+8WsfsaNKv4TnlQObnrDvS1sgxQ4euy6rskbYC9C3vnAxBXBv+uH
	 chN6ecUX7wSJ9bQgfcxk/DSZ5tlqoIngc9KUwxUpQB2ctXA5D7NURXmhixEGl7g83rhqv
	 xNa2i+YWI0a/v1Ehj9FyFGtP50m8ZNelxUVENPXOg3QMRUMssxTjAwRClTY817uyZ6/kD
	 l+vVII45Mb1lk2jwVDIOUgRNggmKZEMFxteCIZmA4n0mL4Bpa0RVqvQiFN9jNpFbm/m7d
	 OTs/tDctNewKs0E5tLW4IQx+zjeuVgBUFXT4eXxLY6ZI1vf4DOoC3GlKoevm7WbVVtg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789407627;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=OjdNwZSsG5j51eQDa4kGJS0JudwsAKYFCmsOMm2TWjY=;
	b=n5ATzp/PY2x7UbI6krQvw9VsU6SNer1kVn6DOQ6SFLnvOIMrfW4bWq22kBzTQRfRinE7
	 Szo9tj/e3CCdeRn5x8HInD6QaygWo8U753YrPewmIr5fvhdWEtjTNq3HuiqZgCVaCw4vV
	 F1SLH0a6nKL8aW9/1NS08ie7P0WNcXMv/eVmQc+ERp7/81J5OVGFnOMlP263u2+hX9qX9
	 1YbiwUN3bqp8WWBVg2FX0pfuQmnXh1V+vwXB7iQolHc+P0E3o8UiAaCxEI3zAkHt+BYsY
	 nulo302JKV038SOVtRsuuZGInwvzDlFmqldzJSuiyYW8lVS/LiiakKZw6PcW/RjM26A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789407627;
	bh=OjdNwZSsG5j51eQDa4kGJS0JudwsAKYFCmsOMm2TWjY=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EBgen29PHayzc7WKzZOd79B0sdB8s0IJyJuz8OKJZesu2Yv4nFtVTFbAFLwmTKmy0
	 N+Iz/MRqLZKhY9LfuEtga9FpnzVgw+7P+YwvlmVSVqY7WsYb/t9qMrWQOBUZ7aYR72
	 WPCVzp9074ITFSOKNw1ANnJk4jv5VYU42ob72jgHRP8o6MOOzKNAnLxx2cxb6cq0BP
	 UgDHcNBNvR7D8dVZuSEpsDnMHiaYmtn/UuDzmPpXc94EAYDUSXUzy2W2n1g/DZ2MDu
	 GBpZWAkgZBqLL7Wm/O7dtZjUNoagS3fDlO1Y9x/ZO/88pwVsrMIeStyPzmnR5+tJjV
	 jCyy5P2nhZFWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0BFAC80C6E;
	Mon, 14 Sep 2026 17:40:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 06F15259
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 17:40:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ED1F6400EF
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 17:40:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eA10rJj2MY7N for <intel-wired-lan@lists.osuosl.org>;
 Mon, 14 Sep 2026 17:40:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D124A40055
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789407624;
 b=bA3MMWOvjJg/gWdZXZyw807iIT9aGKHX9lk1HK3K78Pte3Dzm/SM865tKce7JnO7XJ4w
 Cu8g15wgHJ086LinueAXCKW+M+3CiedoR8MpL6KDUXiaVdUmB81vykKb1p99Plm9pW9il
 fEsj5maaAEAfzrRE3TVMnmhmfbzFfnunD7LLgaxeScNcHw5Kc6FsOZQH9MEr+s6afdjmV
 v3px0GAY/slhXE/aahpImxzOFZr/+uL4WBKy4a1k3dvL3cPpTr+dGYrIFYsdl2nNcjdjj
 rtYiJHXHVsvRQWdBn++QE9UlsaJSJuWfisGVZP5HoAbTkGeB2iqu1tn+9UkuNpt4uIA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789407624;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=OjdNwZSsG5j51eQDa4kGJS0JudwsAKYFCmsOMm2TWjY=;
 b=gqmi0Dse3OjbEZ30AD7ILAKeGugO0t21aEO+SaqaJcFn9OyFz5sWrZ/vkHeNY5aqQS01
 ++H5+zgqtqiLsdL1YjU/ZP3SgWnoeUqW2LfGHXCKgLC6Ai5RgzZvZe3SdwfOOO3Vb1+Lj
 1/mD5Zvl+hElMtK0Gim3CX8rJ9xfBNqgPz7X4V5qfRWuSEvdAHvrfzWU+yuCXHPwxs3e+
 YGW9NJ+XAgi1yj/SSnN9Li/yYbfrnMzQeoYCdhk+ma47eSnlzQZkEFbiqcIeV09CdCluT
 QTgirEyeS+OEuNwcdzuaBrr78bSjM1EXl8y0DYGwHNmiTCIiy2A2M/MWOvJa69po04Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="e1YSr/jg"; 
 arc=none smtp.remote-ip=192.198.163.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=e1YSr/jg
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D124A40055
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 17:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789407624; x=1820943624; h=date:from:to:subject:message-id;
 bh=LD4Tg9IkrEytno8bvVpmGuREb9cMQL205N0osHImojE=;
 b=e1YSr/jgno7s9Ps92LxIQWq7kidLrDc0wYq8Y5P+bT7w2DC+fj43C2gT
 3EE5+Wzh1ZG101uml2x42KFiB8jDoIrU9QXgtkpUvRx1sj+8ZsV4gUoKE
 HoaV/zLo9XEpIRUXSbbkQ8Ea77pBAUb6TydSmZ3MaOAkUI7/nfu6cQTj1
 V/WRD7yClqLmGYyJXrGH20p0w0NO7Z+vOm149w6bxJvmEonDxilnD+k7h
 L6XkJpKegZxNbzzyUWAJREtwAM+n8mTz1pF31eS1yxRozSuQvqrfCMvTb
 maxyKYmgNgZpsp1OvKu5tFLS8UiFatwJHCarmK+Za1wqEIb5CdDjF0U99 A==;
X-CSE-ConnectionGUID: hHkBy+MQTB2fQvnDz9iW2A==
X-CSE-MsgGUID: VRR4WnmkTFeTonmGYDPm/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100359443"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="100359443"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 10:40:23 -0700
X-CSE-ConnectionGUID: rwsQ0ItTT2SLhURd4yAoRQ==
X-CSE-MsgGUID: lXdTJSKGQeG0VQ06C2l+Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="310970063"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by orviesa001.jf.intel.com with ESMTP; 14 Sep 2026 10:40:21 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x6AfD-000000003Cq-2DMb;
 Mon, 14 Sep 2026 17:40:19 +0000
Date: Tue, 15 Sep 2026 01:39:37 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:40GbE] BUILD SUCCESS
 b298db3bb1612faac12f496df9059f17b3dd952b
Message-ID: <202609150134.tIso4FuO-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 40GbE
branch HEAD: b298db3bb1612faac12f496df9059f17b3dd952b  i40e: xsk: fix multi-buffer XDP_PASS skb construction

elapsed time: 2603m

configs tested: 219
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-24
arc                               allnoconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                            hsdk_defconfig    gcc-16.1.0
arc                   randconfig-001-20260914    gcc-13.4.0
arc                   randconfig-002-20260914    gcc-13.4.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-24
arm                        clps711x_defconfig    clang-24
arm                                 defconfig    clang-24
arm                                 defconfig    gcc-16.1.0
arm                          ep93xx_defconfig    clang-24
arm                       imx_v6_v7_defconfig    clang-24
arm                        neponset_defconfig    gcc-16.1.0
arm                         orion5x_defconfig    clang-24
arm                   randconfig-001-20260914    gcc-13.4.0
arm                   randconfig-002-20260914    gcc-13.4.0
arm                   randconfig-003-20260914    gcc-13.4.0
arm                   randconfig-004-20260914    gcc-13.4.0
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260914    gcc-8.5.0
arm64                 randconfig-001-20260914    gcc-9.5.0
arm64                 randconfig-002-20260914    clang-24
arm64                 randconfig-002-20260914    gcc-9.5.0
arm64                 randconfig-003-20260914    gcc-8.5.0
arm64                 randconfig-003-20260914    gcc-9.5.0
arm64                 randconfig-004-20260914    clang-24
arm64                 randconfig-004-20260914    gcc-9.5.0
arm64                randconfig-r131-20260914    gcc-15.2.0 sparse
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260914    gcc-11.5.0
csky                  randconfig-001-20260914    gcc-9.5.0
csky                  randconfig-002-20260914    gcc-9.5.0
hexagon                          allmodconfig    clang-24
hexagon                           allnoconfig    clang-24
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    clang-24
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260914    gcc-13.4.0
hexagon               randconfig-002-20260914    gcc-13.4.0
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386        buildonly-randconfig-001-20260914    clang-22
i386        buildonly-randconfig-001-20260914    gcc-14
i386        buildonly-randconfig-002-20260914    gcc-14
i386        buildonly-randconfig-003-20260914    clang-22
i386        buildonly-randconfig-003-20260914    gcc-14
i386        buildonly-randconfig-004-20260914    gcc-14
i386        buildonly-randconfig-005-20260914    gcc-14
i386        buildonly-randconfig-006-20260914    gcc-14
i386                                defconfig    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260914    clang-22
i386                  randconfig-002-20260914    gcc-14
i386                  randconfig-003-20260914    clang-22
i386                  randconfig-004-20260914    clang-22
i386                  randconfig-005-20260914    gcc-14
i386                  randconfig-006-20260914    clang-22
i386                  randconfig-007-20260914    clang-22
i386                  randconfig-011-20260914    clang-22
i386                  randconfig-012-20260914    clang-22
i386                  randconfig-013-20260914    clang-22
i386                  randconfig-014-20260914    clang-22
i386                  randconfig-015-20260914    clang-22
i386                  randconfig-016-20260914    clang-22
i386                  randconfig-017-20260914    clang-22
i386                  randconfig-061-20260914    gcc-14 sparse
i386                  randconfig-062-20260914    gcc-14 sparse
i386                  randconfig-063-20260914    gcc-14 sparse
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-24
loongarch                loongson64_defconfig    clang-24
loongarch             randconfig-001-20260914    gcc-13.4.0
loongarch             randconfig-002-20260914    gcc-13.4.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-24
m68k                          amiga_defconfig    gcc-16.1.0
m68k                                defconfig    clang-24
m68k                                defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                          defconfig    clang-24
microblaze                          defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                           ip32_defconfig    clang-24
mips                         rt305x_defconfig    clang-24
nios2                             allnoconfig    clang-24
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-24
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260914    gcc-13.4.0
nios2                 randconfig-002-20260914    gcc-13.4.0
openrisc                          allnoconfig    clang-24
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-24
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260914    gcc-12.5.0
parisc                randconfig-002-20260914    gcc-14.3.0
parisc64                            defconfig    clang-24
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-24
powerpc                           allnoconfig    gcc-16.1.0
powerpc                     ep8248e_defconfig    clang-24
powerpc                      pasemi_defconfig    clang-24
powerpc               randconfig-001-20260914    clang-17
powerpc               randconfig-002-20260914    clang-24
powerpc                        warp_defconfig    gcc-16.1.0
powerpc64             randconfig-001-20260914    gcc-8.5.0
powerpc64             randconfig-002-20260914    gcc-15.2.0
riscv                             allnoconfig    clang-24
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-24
riscv                               defconfig    clang-24
riscv                               defconfig    gcc-16.1.0
riscv                    nommu_virt_defconfig    clang-24
riscv                 randconfig-001-20260914    clang-18
riscv                 randconfig-001-20260914    gcc-13.4.0
riscv                 randconfig-002-20260914    clang-24
riscv                 randconfig-002-20260914    gcc-13.4.0
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-24
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260914    clang-19
s390                  randconfig-001-20260914    gcc-13.4.0
s390                  randconfig-002-20260914    clang-24
s390                  randconfig-002-20260914    gcc-13.4.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-24
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-16.1.0
sh                    randconfig-001-20260914    gcc-11.5.0
sh                    randconfig-001-20260914    gcc-13.4.0
sh                    randconfig-002-20260914    gcc-13.4.0
sh                             shx3_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-24
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260914    gcc-16.1.0
sparc                 randconfig-002-20260914    gcc-16.1.0
sparc                randconfig-r133-20260914    gcc-15.2.0 sparse
sparc64                             defconfig    clang-24
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260914    gcc-16.1.0
sparc64               randconfig-002-20260914    gcc-16.1.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                                allnoconfig    clang-24
um                               allyesconfig    gcc-14
um                                  defconfig    clang-24
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260914    gcc-16.1.0
um                    randconfig-002-20260914    gcc-16.1.0
um                           x86_64_defconfig    clang-24
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-24
x86_64      buildonly-randconfig-001-20260914    gcc-14
x86_64      buildonly-randconfig-002-20260914    gcc-14
x86_64      buildonly-randconfig-003-20260914    gcc-14
x86_64      buildonly-randconfig-004-20260914    gcc-14
x86_64      buildonly-randconfig-005-20260914    gcc-14
x86_64      buildonly-randconfig-006-20260914    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260914    gcc-14
x86_64                randconfig-002-20260914    gcc-14
x86_64                randconfig-003-20260914    gcc-14
x86_64                randconfig-004-20260914    gcc-14
x86_64                randconfig-005-20260914    gcc-14
x86_64                randconfig-006-20260914    gcc-14
x86_64                randconfig-011-20260914    clang-22
x86_64                randconfig-012-20260914    clang-22
x86_64                randconfig-012-20260914    gcc-14
x86_64                randconfig-013-20260914    clang-22
x86_64                randconfig-013-20260914    gcc-14
x86_64                randconfig-014-20260914    clang-22
x86_64                randconfig-014-20260914    gcc-14
x86_64                randconfig-015-20260914    clang-22
x86_64                randconfig-016-20260914    clang-22
x86_64                randconfig-071-20260914    clang-22
x86_64                randconfig-072-20260914    clang-22
x86_64                randconfig-073-20260914    clang-22
x86_64                randconfig-074-20260914    clang-22
x86_64                randconfig-074-20260914    gcc-12
x86_64                randconfig-075-20260914    clang-22
x86_64                randconfig-076-20260914    clang-22
x86_64                randconfig-121-20260914    gcc-14 sparse
x86_64                randconfig-122-20260914    gcc-14 sparse
x86_64                randconfig-123-20260914    gcc-14 sparse
x86_64               randconfig-r134-20260914    gcc-15.2.0 sparse
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
xtensa                            allnoconfig    clang-24
xtensa                            allnoconfig    gcc-16.1.0
xtensa                randconfig-001-20260914    gcc-16.1.0
xtensa                randconfig-002-20260914    gcc-16.1.0
xtensa               randconfig-r132-20260914    gcc-15.2.0 sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
