Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B001C4332F
	for <intel-wired-lan@archiver.kernel.org>; Sat,  5 Nov 2022 08:53:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 056C84038B;
	Sat,  5 Nov 2022 08:53:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 056C84038B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1667638412;
	bh=2e9DhXmaQDm2E5/irpm7MrgmSO72zf5PAOzem+Y1MM8=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=8EmmAOoG4smqpSacJii4t4CqlqrA0pkr5oLVx8rDNAHCsekJWcJFclzppJKtO1hVC
	 ry/fbojbr5J8CQdiQAM7BPTv7QP56xPA+k12vwd6b5qFoSu4BKyIge6vwU2wNxCjkH
	 3hcwR+LodbA38Ne+SZIThq+nE6nDYAarFgo9x5QhKfmJmyeH2yJIn8qZqoIuBzbcXy
	 eIyo16uKUZVnA0lVlJYvAtU2JJ09Mr+o71/44AkGRRIujmn4LYCamhleuyI7uq+gAp
	 0XBG//Fmx/Mu3c9kwxWR818GmDRfw5x1hjQGDKUL0Flyr+ya1umLdwAfo3G6ins2v4
	 EsJfTInwqo6uQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wLiP6VNiLI1k; Sat,  5 Nov 2022 08:53:31 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id E3CDD4023B;
	Sat,  5 Nov 2022 08:53:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E3CDD4023B
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id C871B1BF870
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Nov 2022 08:53:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A258041A40
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Nov 2022 08:53:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A258041A40
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FKyEisdIQ9FV for <intel-wired-lan@lists.osuosl.org>;
 Sat,  5 Nov 2022 08:53:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2B01F41A3C
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2B01F41A3C
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Nov 2022 08:53:23 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="289868693"
X-IronPort-AV: E=Sophos;i="5.96,140,1665471600"; d="scan'208";a="289868693"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2022 01:53:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="698923271"
X-IronPort-AV: E=Sophos;i="5.96,140,1665471600"; d="scan'208";a="698923271"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
 by fmsmga008.fm.intel.com with ESMTP; 05 Nov 2022 01:53:21 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1orEvZ-000HpV-0A;
 Sat, 05 Nov 2022 08:53:21 +0000
Date: Sat, 05 Nov 2022 16:53:15 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <6366247b.QFa+RIV8TsUBr7Hu%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1667638403; x=1699174403;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=jn6vQtff0yI3h2ZYb8hl2I+fK40I7OIPeEwbIXp1xHk=;
 b=NU/DIold18kVZe0q7ImSacVnrrZkmXJ16JOpU7aFbsyvvajVswBEjsWr
 gLqh1iqdTXm7atgsStGzRQQkh5h1MfsiSOXr5O5eH5ZC9TLgxv7wHrx3M
 xcHQMOmKVRAMRbOcsIG6Wb7UslNiJbFU+5a1wl+rRpjmEyTixL5tslsU0
 bNHXICNNw9ywmiHqSXy4LcXOxNwp3fOxVYngbAx7xajCyBQNBi/J9VfFN
 /VOxF4J+VB2l0OZ0CsldZjhHf8/93a3tw9f+ig210u+dEv8cxmiXlnapd
 Yu3Cl2eR+aEjsmQwVjrMZ//7khUv40OwC42CQaImqb4gCImKdtG2nlUzH
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=NU/DIold
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 1af9c7f81ffbd409ce60f9ebf095770286c8c62b
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 1af9c7f81ffbd409ce60f9ebf095770286c8c62b  ice: fix handling of burst Tx timestamps

elapsed time: 720m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
i386                                defconfig
ia64                             allmodconfig
arc                                 defconfig
alpha                               defconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
arm                                 defconfig
s390                                defconfig
s390                             allmodconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                              defconfig
i386                          randconfig-a001
sh                               allmodconfig
i386                          randconfig-a003
i386                             allyesconfig
s390                             allyesconfig
mips                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                          randconfig-a005
arc                  randconfig-r043-20221104
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a002
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                           allyesconfig
m68k                             allmodconfig
x86_64                          rhel-8.3-func
riscv                randconfig-r042-20221104
x86_64                           rhel-8.3-kvm
s390                 randconfig-r044-20221104
arc                              allyesconfig
x86_64                        randconfig-a006
alpha                            allyesconfig
x86_64                        randconfig-a004
m68k                             allyesconfig
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
m68k                       m5208evb_defconfig
sh                   sh7724_generic_defconfig
powerpc                   currituck_defconfig
m68k                           sun3_defconfig
csky                                defconfig
nios2                         10m50_defconfig
m68k                       m5249evb_defconfig
ia64                         bigsur_defconfig
arm                            qcom_defconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r045-20221104
hexagon              randconfig-r041-20221104
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
mips                        bcm63xx_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
