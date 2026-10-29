Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97332606A31A
	for <intel-wired-lan@archiver.kernel.org>; Thu, 29 Oct 2026 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=fDN0Ayk+;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jXmxmiod
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 789C36071E;
	Thu, 29 Oct 2026 16:33:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SOst2c5wNc4H; Thu, 29 Oct 2026 16:33:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6AD0B60709
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793291632;
	b=VjsepJFvZoXC9438rcumyIDF2mCWUf/XjrEH1h5XwZmv8FkzC/qec3WDhULXdMz5dVsw
	 OIgfi5zRPYFXp7k+BIxOAbHTvEADGkkb7zFdXk+ITL7cnAFGO0G7LE9rI6gBI6K/3BJnh
	 CFvwBko4nluSM8e3za+5uWCPmGifmIA7rJTVQYH2ZwURhfJv5lvDoj8NM0jgE4OMyaUta
	 yOXewteadaeDR8GubkCMqjpqeabVJnoByAT5zeLHSFqCLXKRGo6KrnBzeEsyQ03Gfvs8k
	 tr1U6ICXeFqrtgrUHXVIOd/60kgg4CFFtLZ7qpWMm11WAXWrmr997VVZPet7C3r9GtA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793291632;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=O/kVY0cdyqq6+xJuU6ScFSJjHqcCV7VS3mzcdVU5DJs=;
	b=PDRgaRbdtSsBJ39b548VGlU3IIi5cXgMSM9la/VvxQph2bP6Ed2dOVYp1rSSY7GpopBz
	 hY9tbMiNJOE87MjvCc3T+LPge1BJWopKH8FJfPiAabtq62piAYHDzHR6uPX1MQwdvdAq/
	 u4eycZPEpPOzO1wKAP4Cqd2qmNb7hpwvNTryPhhC68K6L07s8DsDwlVZjD649LW+vcD1H
	 ymMx0mcLKkY/DY9Qt3xOB3M+S21ACQS1VuUyCYGW0XykL6NmR775fNEYX6cbcENTgz6FB
	 t5h/EChjVP47mPo96MMt385kpnz9g28EzQfqjKZ7jJd43AMnwQXkawUz+Y7NCFQ7HNA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793291632;
	bh=O/kVY0cdyqq6+xJuU6ScFSJjHqcCV7VS3mzcdVU5DJs=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fDN0Ayk+W8H1T0Eiccn05fxc38jgntGM2V9DRnL8kgK2R4hKtmpoD4zPupqQo6bDH
	 CkDR/6QBKnRItsjldpMSvrDjQjmZkMLv2BSAdXMTWoMGGH7eYZzVCUkp5tux1GOj5s
	 2Moy1AwO0uWLSNishHf0Jd7CjzkxKs6mBD496W4qncDMYMpp0PH7TV5NYsPX+9yhus
	 3AgefeQMssnV3m2SWpMq99FcqmP4rf3lu0GHVV3OERThUcu842eqQpW5+a/MRlGdmu
	 jHvHHdm9HheCq68bGpr/+bwBB1HFWZ5ygcqumy5zjBcykeJEJ5vm/jYJhvdaBt1/jE
	 yDQ9iFttup1Pw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6AD0B60709;
	Thu, 29 Oct 2026 16:33:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 22BBD2FE
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 16:33:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 08D7180FF9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 16:33:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eqgHmkDg8cnU for <intel-wired-lan@lists.osuosl.org>;
 Thu, 29 Oct 2026 16:33:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D93EC808AC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793291630;
 b=FzE5a3n+BHNkAnMOsuKKcEZYwKOxqKuqGFIRnG3wDI/K4Wdww5c+sKLt9qJ4uWyQt/pQ
 A+e5rMSETzORycBzhDzXBC5GMgoWfdBqu5i1FVNtUi1R+vvB0uNmiuSoWM1z5Wv/zQ72E
 eFdUatsRV0twwMUoZ4cf64DOd+/eHD7mKvi+vodnHFtl/1Xd7b4fB3butXBgasC7I4ieL
 ZPAbi2Kigv7Kobhz2J0teqlXEp3QDyONfkhzhhEp0EQVbBvjG/aA4oo7B0TkqCuOf0zaq
 B09FIT7HzidZcbabLDgD4rVJyseXIdyl4o8esjJSmlWhLlnct+oavCSBjgUzyczbtMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793291630;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=O/kVY0cdyqq6+xJuU6ScFSJjHqcCV7VS3mzcdVU5DJs=;
 b=BVadZ+G+IMI+9vQFaj1mRW7HrmV58g1ysJXS4HbkefwwDRlRgBx/a7wE/NGh8ly0m/kK
 n73eR/aHR2S1s3LSWW8+5GEGXjLvhOyiqy8fQKFTCvRdOZPDwhioiVhtjYgur6b9UQTau
 XzllgYiCoYS9+1OxWwMc6aQvohzIiNYcQrCm2nLGvWQGdaQU9OasZfU6ZyVJSekkkEBpF
 hJ1Yc7gG0epOz98guP9A9C/CjORzCP7aNBVaK5hzmPrpDCHC93FYJo+voeDPIPRsLJE5/
 ivJpQB90orGx4n4WI2qefSULQsgjgSpQQo/nFJlZWR8V/WiMiQ2k6aCga2TqTkjOQHg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=jXmxmiod; 
 arc=none smtp.remote-ip=198.175.65.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=jXmxmiod
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D93EC808AC
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793291630; x=1824827630; h=date:from:to:subject:message-id;
 bh=yFtgpJuHMdw76zgvkCzC3DGHoI6wz+R8SqT8Boyu45M=;
 b=jXmxmiodow8U2LoGIUzMGA7eFFgRXt+LlmMPqTiq8yKUZWR5sJn5h0ED
 o9WRNMreJEKQ6o+5mTZFY3t3XKZw/fPxDfsU1uz9BUJXIV9iP/vPTGArR
 SHoQymzBYWNH91Wqxes3O+STINRJej9YnWdAwliouWpMjqoB2OtcHGuym
 IBva/9qdykdzMFIEwdAcwGe4+GStQSKp0pJjlr+eailRdtiru/gwjnkAC
 m/ZLSLCnAcZ/pFDYITb3GLpZtFzp2OR3WpxPweIrl+BPWJj4gpXvyB1yh
 9ole9ImIHnBfqxFLO8lngP60tEobX7msXw2qab5rmjdZHrHfjclj4/vUo Q==;
X-CSE-ConnectionGUID: u8eJ4vYkRAuBNLMcPyqG4w==
X-CSE-MsgGUID: 3LW5mYeNRBe48BUe8ywrdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="1919564"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1919564"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 09:33:47 -0700
X-CSE-ConnectionGUID: Ryw/bYBATgyZk1lvR354PA==
X-CSE-MsgGUID: 6TXGTfJvSGq/J3Az94+IMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5117469"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa003.jf.intel.com with ESMTP; 29 Oct 2026 09:33:46 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xMT4R-00000000aP8-2FfT;
 Thu, 29 Oct 2026 16:33:43 +0000
Date: Fri, 30 Oct 2026 00:32:56 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:10GbE] BUILD SUCCESS
 2cffcf1aeabb187e4f08fe4f5363128a3c45d786
Message-ID: <202610300053.yznHc0eO-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 10GbE
branch HEAD: 2cffcf1aeabb187e4f08fe4f5363128a3c45d786  net: lan966x: do not warn on MAC entries that are not port destined

elapsed time: 2497m

configs tested: 327
configs skipped: 21

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-19
arc                               allyesconfig    clang-24
arc                               allyesconfig    gcc-16.2.0
arc                                  defconfig    gcc-16.2.0
arc                             hsdk_defconfig    clang-24
arc                      nsimosci_hs_defconfig    gcc-16.2.0
arc                   randconfig-1000-20261028    gcc-8.5.0
arc                   randconfig-1000-20261029    clang-24
arc                   randconfig-1001-20261028    gcc-8.5.0
arc                   randconfig-1001-20261029    clang-24
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                          assabet_defconfig    clang-24
arm                          axm55xx_defconfig    gcc-16.2.0
arm                                  defconfig    gcc-16.2.0
arm                       footbridge_defconfig    gcc-16.2.0
arm                            h3600_defconfig    clang-24
arm                        imx_v4_v5_defconfig    gcc-16.2.0
arm                            imxrt_defconfig    gcc-16.2.0
arm                    milbeaut_m10v_defconfig    gcc-16.2.0
arm                             mps2_defconfig    clang-24
arm                         multi_v5_defconfig    clang-24
arm                          nhk8815_defconfig    clang-24
arm                        omap2plus_defconfig    gcc-14
arm                   randconfig-1000-20261028    gcc-8.5.0
arm                   randconfig-1000-20261029    clang-24
arm                   randconfig-1001-20261028    gcc-8.5.0
arm                   randconfig-1001-20261029    clang-24
arm                   randconfig-1002-20261028    gcc-8.5.0
arm                   randconfig-1002-20261029    clang-24
arm                   randconfig-1003-20261028    gcc-8.5.0
arm                   randconfig-1003-20261029    clang-24
arm                          s3c6400_defconfig    gcc-16.2.0
arm                         spear3xx_defconfig    gcc-16.2.0
arm                     vt8500_v6_v7_defconfig    gcc-16.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261028    clang-22
arm64                 randconfig-1000-20261029    gcc-8.5.0
arm64                 randconfig-1001-20261028    clang-22
arm64                 randconfig-1001-20261029    gcc-8.5.0
arm64                 randconfig-1002-20261028    clang-22
arm64                 randconfig-1002-20261029    gcc-8.5.0
arm64                 randconfig-1003-20261028    clang-22
arm64                 randconfig-1003-20261029    gcc-8.5.0
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261028    clang-22
csky                  randconfig-1000-20261029    gcc-8.5.0
csky                  randconfig-1001-20261028    clang-22
csky                  randconfig-1001-20261029    gcc-8.5.0
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261028    clang-17
hexagon               randconfig-1000-20261029    clang-24
hexagon               randconfig-1001-20261028    clang-17
hexagon               randconfig-1001-20261029    clang-24
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261028    clang-22
i386        buildonly-randconfig-1000-20261029    gcc-14
i386        buildonly-randconfig-1001-20261028    clang-22
i386        buildonly-randconfig-1001-20261029    gcc-14
i386        buildonly-randconfig-1002-20261028    clang-22
i386        buildonly-randconfig-1002-20261029    gcc-14
i386        buildonly-randconfig-1003-20261028    clang-22
i386        buildonly-randconfig-1003-20261029    gcc-14
i386        buildonly-randconfig-1004-20261028    clang-22
i386        buildonly-randconfig-1004-20261029    gcc-14
i386        buildonly-randconfig-1005-20261028    clang-22
i386        buildonly-randconfig-1005-20261029    gcc-14
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261028    gcc-14
i386                  randconfig-1000-20261029    clang-22
i386                  randconfig-1001-20261028    gcc-14
i386                  randconfig-1001-20261029    clang-22
i386                  randconfig-1002-20261028    gcc-14
i386                  randconfig-1002-20261029    clang-22
i386                  randconfig-1003-20261028    gcc-14
i386                  randconfig-1003-20261029    clang-22
i386                  randconfig-1004-20261028    gcc-14
i386                  randconfig-1004-20261029    clang-22
i386                  randconfig-1005-20261028    gcc-14
i386                  randconfig-1005-20261029    clang-22
i386                  randconfig-1006-20261028    gcc-14
i386                  randconfig-1006-20261029    clang-22
i386                  randconfig-1007-20261028    clang-22
i386                  randconfig-1007-20261029    clang-22
i386                  randconfig-1008-20261028    clang-22
i386                  randconfig-1008-20261029    clang-22
i386                  randconfig-1009-20261028    clang-22
i386                  randconfig-1009-20261029    clang-22
i386                  randconfig-1010-20261028    clang-22
i386                  randconfig-1010-20261029    clang-22
i386                  randconfig-1011-20261028    clang-22
i386                  randconfig-1011-20261029    clang-22
i386                  randconfig-1012-20261028    clang-22
i386                  randconfig-1012-20261029    clang-22
i386                  randconfig-1013-20261028    clang-22
i386                  randconfig-1013-20261029    clang-22
loongarch                         allmodconfig    clang-19
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261028    clang-17
loongarch             randconfig-1000-20261029    clang-24
loongarch             randconfig-1001-20261028    clang-17
loongarch             randconfig-1001-20261029    clang-24
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                           amiga_defconfig    clang-22
m68k                        bvme6000_defconfig    gcc-16.2.0
m68k                                 defconfig    clang-24
m68k                         m5272c3_defconfig    clang-24
m68k                        m5275evb_defconfig    clang-22
m68k                        m5282evb_defconfig    clang-24
m68k                         stmark2_defconfig    clang-24
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                            ip32_defconfig    gcc-16.2.0
mips                        lemote2f_defconfig    clang-22
mips                       loongson1_defconfig    gcc-14
mips                       malta_kvm_defconfig    gcc-14
mips                         maltaup_defconfig    gcc-14
mips                            mtx1_defconfig    gcc-16.2.0
mips                           rm200_defconfig    clang-24
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261028    clang-17
nios2                 randconfig-1000-20261029    clang-24
nios2                 randconfig-1001-20261028    clang-17
nios2                 randconfig-1001-20261029    clang-24
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc          de0_nano_multicore_defconfig    gcc-16.2.0
openrisc                             defconfig    gcc-16.2.0
openrisc                     or1ksim_defconfig    clang-24
openrisc                        virt_defconfig    clang-24
parisc                            alldefconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261028    clang-19
parisc                randconfig-1000-20261029    clang-17
parisc                randconfig-1001-20261028    clang-19
parisc                randconfig-1001-20261029    clang-17
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                      asp8347_defconfig    clang-24
powerpc                       bamboo_defconfig    clang-24
powerpc                       bamboo_defconfig    gcc-16.2.0
powerpc                  canyonlands_defconfig    clang-22
powerpc                       cm5200_defconfig    clang-24
powerpc                      ep8248e_defconfig    clang-22
powerpc                         icon_defconfig    gcc-16.2.0
powerpc                   iss476-smp_defconfig    gcc-16.2.0
powerpc                    motionpro_defconfig    clang-24
powerpc                  mpc8315_rdb_defconfig    gcc-16.2.0
powerpc                  mpc834x_itx_defconfig    clang-24
powerpc                       pasemi_defconfig    clang-24
powerpc                       ppc44x_defconfig    clang-24
powerpc                       ppc64e_defconfig    clang-24
powerpc               randconfig-1000-20261028    clang-19
powerpc               randconfig-1000-20261029    clang-17
powerpc               randconfig-1001-20261028    clang-19
powerpc               randconfig-1001-20261029    clang-17
powerpc                     sam440ep_defconfig    clang-22
powerpc                     sam440ep_defconfig    clang-24
powerpc                     socrates_defconfig    gcc-16.2.0
powerpc                      stx_gp3_defconfig    gcc-14
powerpc                      tqm8548_defconfig    gcc-16.2.0
powerpc                         warp_defconfig    gcc-16.2.0
powerpc64             randconfig-1000-20261028    clang-19
powerpc64             randconfig-1000-20261029    clang-17
powerpc64             randconfig-1001-20261028    clang-19
powerpc64             randconfig-1001-20261029    clang-17
riscv                             alldefconfig    clang-24
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261028    gcc-11.5.0
riscv                 randconfig-1000-20261029    gcc-10.5.0
riscv                 randconfig-1001-20261028    gcc-11.5.0
riscv                 randconfig-1001-20261029    gcc-10.5.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261028    gcc-11.5.0
s390                  randconfig-1000-20261029    gcc-10.5.0
s390                  randconfig-1001-20261028    gcc-11.5.0
s390                  randconfig-1001-20261029    gcc-10.5.0
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                allyesconfig    gcc-16.2.0
sh                          ap325rxa_defconfig    gcc-16.2.0
sh                          apsh4a3a_defconfig    gcc-14
sh                                   defconfig    gcc-14
sh                         dreamcast_defconfig    clang-22
sh                  kfr2r09-romimage_defconfig    clang-24
sh                           polaris_defconfig    gcc-16.2.0
sh                    randconfig-1000-20261028    gcc-11.5.0
sh                    randconfig-1000-20261029    gcc-10.5.0
sh                    randconfig-1001-20261028    gcc-11.5.0
sh                    randconfig-1001-20261029    gcc-10.5.0
sh                           rsk7201_defconfig    clang-22
sh                            se7206_defconfig    gcc-16.2.0
sh                            se7619_defconfig    clang-24
sh                            se7721_defconfig    gcc-16.2.0
sh                            se7751_defconfig    gcc-16.2.0
sh                              sh03_defconfig    gcc-14
sh                    sh7724_generic_defconfig    gcc-16.2.0
sh                         sh7785lcr_defconfig    gcc-16.2.0
sh                             titan_defconfig    clang-24
sparc                             alldefconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261028    gcc-12
sparc                 randconfig-1000-20261029    clang-24
sparc                 randconfig-1001-20261028    gcc-12
sparc                 randconfig-1001-20261029    clang-24
sparc                        sparc64_defconfig    clang-24
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261028    gcc-12
sparc64               randconfig-1000-20261029    clang-24
sparc64               randconfig-1001-20261028    gcc-12
sparc64               randconfig-1001-20261029    clang-24
um                                alldefconfig    gcc-16.2.0
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261028    gcc-12
um                    randconfig-1000-20261029    clang-24
um                    randconfig-1001-20261028    gcc-12
um                    randconfig-1001-20261029    clang-24
um                            x86_64_defconfig    clang-24
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261028    clang-22
x86_64      buildonly-randconfig-1000-20261029    gcc-14
x86_64      buildonly-randconfig-1001-20261028    clang-22
x86_64      buildonly-randconfig-1001-20261029    gcc-14
x86_64      buildonly-randconfig-1002-20261028    clang-22
x86_64      buildonly-randconfig-1002-20261029    gcc-14
x86_64      buildonly-randconfig-1003-20261028    clang-22
x86_64      buildonly-randconfig-1003-20261029    gcc-14
x86_64      buildonly-randconfig-1004-20261028    clang-22
x86_64      buildonly-randconfig-1004-20261029    gcc-14
x86_64      buildonly-randconfig-1005-20261028    clang-22
x86_64      buildonly-randconfig-1005-20261029    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261028    clang-22
x86_64                randconfig-1000-20261029    clang-22
x86_64                randconfig-1001-20261028    clang-22
x86_64                randconfig-1001-20261029    clang-22
x86_64                randconfig-1002-20261028    clang-22
x86_64                randconfig-1002-20261029    clang-22
x86_64                randconfig-1003-20261028    clang-22
x86_64                randconfig-1003-20261029    clang-22
x86_64                randconfig-1004-20261028    clang-22
x86_64                randconfig-1004-20261029    clang-22
x86_64                randconfig-1005-20261028    clang-22
x86_64                randconfig-1005-20261029    clang-22
x86_64                randconfig-1006-20261028    gcc-14
x86_64                randconfig-1006-20261029    gcc-14
x86_64                randconfig-1007-20261028    gcc-14
x86_64                randconfig-1007-20261029    gcc-14
x86_64                randconfig-1008-20261028    gcc-14
x86_64                randconfig-1008-20261029    gcc-14
x86_64                randconfig-1009-20261028    gcc-14
x86_64                randconfig-1009-20261029    gcc-14
x86_64                randconfig-1010-20261028    gcc-14
x86_64                randconfig-1010-20261029    gcc-14
x86_64                randconfig-1011-20261028    gcc-14
x86_64                randconfig-1011-20261029    gcc-14
x86_64                randconfig-1012-20261028    gcc-12
x86_64                randconfig-1012-20261029    clang-22
x86_64                randconfig-1013-20261028    gcc-12
x86_64                randconfig-1013-20261029    clang-22
x86_64                randconfig-1014-20261028    gcc-12
x86_64                randconfig-1014-20261029    clang-22
x86_64                randconfig-1015-20261028    gcc-12
x86_64                randconfig-1015-20261029    clang-22
x86_64                randconfig-1016-20261028    gcc-12
x86_64                randconfig-1016-20261029    clang-22
x86_64                randconfig-1017-20261028    gcc-12
x86_64                randconfig-1017-20261029    clang-22
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                        common_defconfig    gcc-16.2.0
xtensa                randconfig-1000-20261028    gcc-12
xtensa                randconfig-1000-20261029    clang-24
xtensa                randconfig-1001-20261028    gcc-12
xtensa                randconfig-1001-20261029    clang-24

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
