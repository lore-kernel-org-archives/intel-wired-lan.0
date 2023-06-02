Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2CAC7EE24
	for <intel-wired-lan@archiver.kernel.org>; Fri,  2 Jun 2023 06:38:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 362C860C34;
	Fri,  2 Jun 2023 06:38:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 362C860C34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1685687901;
	bh=WCmeLT6y6TY7gWT9dLwqe10Db7BrKeKpxdfLrYBvcjM=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=03a8TSjFavIC6PncqU8GOALbOJ298pVX5MYHWhXxj+emmf3HTjpfGH0KqiFs1ccyM
	 CDW6EfLnzRfwMWJYPR/dKgp7+iqSwyNGVqg7UtRdoE5x2bzXhKPj3Bi9cXPUJ9bqzg
	 kH4qt2SU/Zy952PYQUPY1yF8QyCE65oXBywugnTEhgvU7CDY99lnOeSV4KMZ/DRsLS
	 hHmGPF7+ditEplerISTMcBfTtwrMkpqTPu9i/36ZrY63vgsFjj46XcuQoRWfiaxVle
	 uqIb1mFh49wXhBHtkQ2RVVuuRMz1nNPVVB0mVD4MMPxGQO2g2SZbGW1x9i64WgdO27
	 ohU3usRSBlFFQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jpCY55dg3l16; Fri,  2 Jun 2023 06:38:20 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4058960D89;
	Fri,  2 Jun 2023 06:38:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4058960D89
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 5CC661BF5A8
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Jun 2023 06:38:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4117560D89
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Jun 2023 06:38:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4117560D89
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H2BdIjx2F7gG for <intel-wired-lan@lists.osuosl.org>;
 Fri,  2 Jun 2023 06:38:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8A10960C34
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8A10960C34
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Jun 2023 06:38:17 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="340417373"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; d="scan'208";a="340417373"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2023 23:38:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="772759188"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; d="scan'208";a="772759188"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
 by fmsmga008.fm.intel.com with ESMTP; 01 Jun 2023 23:38:15 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1q4yQR-0000BY-0p
 for intel-wired-lan@lists.osuosl.org; Fri, 02 Jun 2023 06:38:15 +0000
Date: Fri, 02 Jun 2023 14:37:42 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <20230602063742.YBoKW%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685687898; x=1717223898;
 h=date:from:to:subject:message-id;
 bh=pOSUHzPWMLyQdbqo1+1NqHyQOCd8ggwlXDn6qLzJWkM=;
 b=fAYeUxcPPRfiYUxpZd5YSRURi399EPmnDWJUMsiIiScCV51iSra9eoSP
 5Qlqqv+ndyOE7DmshJqDBW1xvvoKgvw5R0Nr6/W6WIE+0V8NNniS5Fkxa
 fqDXHZNctQ29i/fTf0FXoceSboI8rhdNodAh4caVkgZRrx0YLCHLy/abO
 m2JZARTeGAszIlTPv6uy8MgZ9H9tv1N2JMUQvWx1WpQx9GZkJch4BTwb9
 JQswGGM4Fc1bOPxzhgHvfyh7KESxAdSQyU+y4uJlCh8282G3aLL+CgsOU
 C83Sp2n9vfaopuofmsovIaQc9ymclu/lgm+xFyJIlPKTrcqnAjHmhgq+K
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=fAYeUxcP
Subject: [Intel-wired-lan] [tnguy-next-queue:main] BUILD SUCCESS
 4ff3dfc91c8458f65366f283167d1cd6f16be06f
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git main
branch HEAD: 4ff3dfc91c8458f65366f283167d1cd6f16be06f  Merge branch 'splice-net-handle-msg_splice_pages-in-chelsio-tls'

elapsed time: 1013m

configs tested: 74
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r005-20230531   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r025-20230531   gcc  
arc                  randconfig-r034-20230531   gcc  
arc                  randconfig-r043-20230531   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r006-20230531   clang
arm                  randconfig-r046-20230531   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky         buildonly-randconfig-r002-20230531   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r012-20230601   gcc  
csky                 randconfig-r033-20230531   gcc  
hexagon              randconfig-r005-20230531   clang
hexagon              randconfig-r031-20230531   clang
hexagon              randconfig-r036-20230531   clang
hexagon              randconfig-r041-20230531   clang
hexagon              randconfig-r045-20230531   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r001-20230531   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-r004-20230531   gcc  
i386                 randconfig-r035-20230531   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r004-20230531   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r014-20230601   gcc  
microblaze           randconfig-r021-20230531   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r003-20230531   clang
nios2                               defconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r026-20230531   gcc  
parisc               randconfig-r032-20230531   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r011-20230601   gcc  
powerpc              randconfig-r022-20230531   clang
powerpc              randconfig-r023-20230531   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230531   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r002-20230531   gcc  
s390                 randconfig-r044-20230531   clang
sh                               allmodconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r016-20230601   gcc  
sparc64              randconfig-r013-20230601   gcc  
sparc64              randconfig-r024-20230531   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r003-20230531   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
