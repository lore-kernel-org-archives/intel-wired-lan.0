Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306A5C433EF
	for <intel-wired-lan@archiver.kernel.org>; Wed, 20 Jul 2022 11:25:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B6E764148F;
	Wed, 20 Jul 2022 11:25:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B6E764148F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1658316341;
	bh=M71z5KEBOlT6uN6FN/s08irTcxI08TLv5anrOz7Onew=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EfHZf+QIf8hD7BMimSc/OOOul6w+o6n95TVzYUA5vb48skWUBiBZoWjaVJ5+tUb/7
	 qOFXgS6xe6gjQxSWzcX8VCb9bI3QCvXCLg/oZPiqIO7Pu92aJnCXomCQ1VzbrkwGJb
	 1wLuW+k15KJYpF46butlE4/kXqyFn+ROrFIP32ukcJw3FETPiz0mZhNaKxE4mzzoia
	 daiLtQiIiK0VZIF0ERb3flz7wl4tvkjAigOZ/qAvN2dMOoWU7aQHzkpi1R4GYvb1a/
	 KQxyafTC+IGXcHHvlAPN/lLGRbDKl/XDfY++LcOWEmUU8BDi6GahMYpycfE3Q0Q6iH
	 kdeEQFqf7JLNA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Cw2HUduzaVz; Wed, 20 Jul 2022 11:25:40 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 63CAD418BC;
	Wed, 20 Jul 2022 11:25:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 63CAD418BC
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 073461BF85D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 20 Jul 2022 11:25:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DB5D160E31
 for <intel-wired-lan@lists.osuosl.org>; Wed, 20 Jul 2022 11:25:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DB5D160E31
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T3xmJBgfgeqD for <intel-wired-lan@lists.osuosl.org>;
 Wed, 20 Jul 2022 11:25:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 666CD60B49
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 666CD60B49
 for <intel-wired-lan@lists.osuosl.org>; Wed, 20 Jul 2022 11:25:37 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="284311950"
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; d="scan'208";a="284311950"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2022 04:25:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; d="scan'208";a="925196163"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
 by fmsmga005.fm.intel.com with ESMTP; 20 Jul 2022 04:25:35 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1oE7pe-0000Rt-U4;
 Wed, 20 Jul 2022 11:25:34 +0000
Date: Wed, 20 Jul 2022 19:24:52 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <62d7e604.yJC5XD7TICz29xF+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1658316337; x=1689852337;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=pZqKE108EQ3ZbVnKSddBHIElInarWpTAcCPKm6+RBxk=;
 b=QGTp4EWnjq2Zp44FvebwbjIF9zfT6v+fJxnrK0Mva3OQmn6hYQu6LRWr
 zGWBmThHVf042IScyWDrxhqFlwSeOKQ9nO5wHTaZE/zciiKdS86KxkkGU
 n83OX0R9FnbLNK0Nqjvaij23wO2GA48ri8tV9xIiGPk2EEWD6DaZaEZtp
 sxBiTxnla197umnXZcs+rWZRar8dFaXdFn0ocK2+gvlvIxb5YC29hpLVT
 NOowD3dwH42rlB1LVxcLf5SbVhH5D1DvptGBn5PtksPQNEy/QvOEbO3IN
 vX8fZdR1VfA57sbCu2NdeIgxuY5q0sEavwbNmW2V5lh1GTjIkTfaUeKbp
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=QGTp4EWn
Subject: [Intel-wired-lan] [tnguy-next-queue:master] BUILD SUCCESS
 1f17708b47a99ca5bcad594a6f8d14cb016edfd2
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git master
branch HEAD: 1f17708b47a99ca5bcad594a6f8d14cb016edfd2  sfc: update MCDI protocol headers

elapsed time: 802m

configs tested: 97
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arm                        realview_defconfig
arm                             rpc_defconfig
powerpc                     sequoia_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                    sam440ep_defconfig
xtensa                    smp_lx200_defconfig
arm                          pxa3xx_defconfig
powerpc                       maple_defconfig
m68k                        m5307c3_defconfig
powerpc                      ep88xc_defconfig
arm                      footbridge_defconfig
x86_64                              defconfig
sh                        sh7757lcr_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
loongarch                           defconfig
loongarch                         allnoconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64               randconfig-a014-20220718
x86_64               randconfig-a016-20220718
x86_64               randconfig-a012-20220718
x86_64               randconfig-a013-20220718
x86_64               randconfig-a015-20220718
x86_64               randconfig-a011-20220718
i386                 randconfig-a015-20220718
i386                 randconfig-a011-20220718
i386                 randconfig-a012-20220718
i386                 randconfig-a014-20220718
i386                 randconfig-a016-20220718
i386                 randconfig-a013-20220718
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
s390                 randconfig-r044-20220718
riscv                randconfig-r042-20220718
arc                  randconfig-r043-20220718
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           allyesconfig
x86_64                               rhel-8.3

clang tested configs:
arm                     am200epdkit_defconfig
riscv                            alldefconfig
arm                        magician_defconfig
mips                          malta_defconfig
hexagon                          alldefconfig
mips                          ath25_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a004-20220718
i386                 randconfig-a001-20220718
i386                 randconfig-a005-20220718
i386                 randconfig-a002-20220718
i386                 randconfig-a006-20220718
i386                 randconfig-a003-20220718
x86_64               randconfig-a001-20220718
x86_64               randconfig-a005-20220718
x86_64               randconfig-a003-20220718
x86_64               randconfig-a002-20220718
x86_64               randconfig-a006-20220718
x86_64               randconfig-a004-20220718
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220718
hexagon              randconfig-r045-20220718

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
