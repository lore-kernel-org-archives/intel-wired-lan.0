Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEC5C7EE23
	for <intel-wired-lan@archiver.kernel.org>; Wed, 31 May 2023 12:26:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D63A460BDE;
	Wed, 31 May 2023 12:26:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D63A460BDE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1685535985;
	bh=Xor1W43kaDnBtbipvjAZwDcUCrTmgjpJkXxCe93xnXQ=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UzGD2TOBoG0p0uFOKGVMnc8JFM5sr6lnbsb/tbM4GLfgc8zBYWdEgu7xCqRX74pCC
	 elS4tj86ACjA2nWJWTQ6cMgxGecZu1+xpzmvAPNQY5FVL7sdj/RMx3Vd93ewRg/mbj
	 CaO3fz1s6dDI6Z8iptJSKLZThcxCGllROy7LW6KoyaE7Fv+Xoc8ZHeeKxdUL34clJG
	 5QO8uiOi6oY3adtV9F+8MZBUeFpSq+NNBxIuoOukF1XolHE4FQ7Q/fH6dELPBJrKwm
	 xfzplsEJtVcSVZOeovijewPlavm3/viZR/qkHvS3VbCmMXcr4O6lgjZQvAsWS/+uRt
	 zSE1+UDZ1ozcA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jCOlOX7WuHW9; Wed, 31 May 2023 12:26:25 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 091D860BE8;
	Wed, 31 May 2023 12:26:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 091D860BE8
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 5CF6E1BF5AA
 for <intel-wired-lan@lists.osuosl.org>; Wed, 31 May 2023 12:26:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3431560BE8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 31 May 2023 12:26:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3431560BE8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O8-bWRnBocAr for <intel-wired-lan@lists.osuosl.org>;
 Wed, 31 May 2023 12:26:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0C8DB60BDE
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0C8DB60BDE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 31 May 2023 12:26:20 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="344731929"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; d="scan'208";a="344731929"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2023 05:26:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="657315288"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; d="scan'208";a="657315288"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
 by orsmga003.jf.intel.com with ESMTP; 31 May 2023 05:26:19 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1q4KuA-0001KL-2D
 for intel-wired-lan@lists.osuosl.org; Wed, 31 May 2023 12:26:18 +0000
Date: Wed, 31 May 2023 20:26:06 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <20230531122606.njEym%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685535981; x=1717071981;
 h=date:from:to:subject:message-id;
 bh=GWieqPXl2+JhjJ05kgcrKZvk2g3Oi/5X4eDt4q2rt30=;
 b=ao9S3WlRSGB5sRgvxX4GJP55DVZIOtSY/+u9zXO//MF8nZFLXUxipG9u
 Ij59c/qTG8+rg3xCjgWq9rgK5Z242A+dceQtVztP87uaHC1x6UdkaCCzB
 5I7a9rQJGZ0yiShQc4vt3Wi1IQ7x0GnUCxCLk/dUbO3aNwovY9JRAKqV6
 8tcTvLGvx8bU8LO1LbzjBl9qSs/UNK2+OoO/VO1CrbKgaJEYLbvn7roTd
 3OBLDuJy6/iI88RiEde9axWrgvPyQ79gqU3/adaKo3j4jod/RxkfIwR4l
 JTnWJKBMeHpYgpmCjBuZy1qee2y9n1WmV5ge5VDl5y/hOPrFDYMq316pD
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ao9S3WlR
Subject: [Intel-wired-lan] [tnguy-next-queue:200GbE] BUILD SUCCESS
 77bfd7546e8501ccd29cc85d6df7e513fcecf2de
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 200GbE
branch HEAD: 77bfd7546e8501ccd29cc85d6df7e513fcecf2de  idpf: configure SRIOV and add other ndo_ops

elapsed time: 724m

configs tested: 46
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r014-20230531   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r016-20230531   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r011-20230531   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r013-20230531   gcc  
nios2                               defconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r015-20230531   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r012-20230531   gcc  
sparc                               defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
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
