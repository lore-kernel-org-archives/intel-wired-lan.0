Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EF3C4321E
	for <intel-wired-lan@archiver.kernel.org>; Fri,  2 Dec 2022 13:46:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 318CD41B8B;
	Fri,  2 Dec 2022 13:46:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 318CD41B8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1669988780;
	bh=yGGY1Blca6gtwCc32hDQ3h0iNWjO1TnpYSRiA0bsMz4=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=1A2AfIObIdup0zJ6cZn/r6/bCa7yw6EF/5SpEG5RIqO+KbWQ/BNWUegpPi4qKkK+I
	 OHDP3THHW66mLAt2RBPBtnd4MK57PW7OofJhu86rdZ16ekH1e6sJiPB5Qmo4GtPbYo
	 NtFLLEEX0Ni2d1ml8vS4GM2Avddl5Gp30oJh9AWVzuwQORKRv2paNmp00njW6jpiq6
	 guzCRtIK0l+94/4V4zzuq5wH5CpKe3F/4p13VrVgysDeA517egCHnRDfrvi2HtwuUf
	 6s//tqGPDdmEBO5nm8y7UkLviFWuuRd5Oi8oVohSUsLR/S+FpYycfXYBPP918Z+Tpz
	 0a/4Ww/rII42w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kK9bq2mwIZ7i; Fri,  2 Dec 2022 13:46:19 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9E8041B8D;
	Fri,  2 Dec 2022 13:46:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E9E8041B8D
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id CACF81BF293
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Dec 2022 13:46:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B1E6260F29
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Dec 2022 13:46:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B1E6260F29
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vivdARqic_YI for <intel-wired-lan@lists.osuosl.org>;
 Fri,  2 Dec 2022 13:46:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C345C60F20
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C345C60F20
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Dec 2022 13:46:16 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="296310772"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; d="scan'208";a="296310772"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2022 05:46:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="751267754"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; d="scan'208";a="751267754"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
 by fmsmga002.fm.intel.com with ESMTP; 02 Dec 2022 05:46:15 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1p16Mo-000Dht-2N;
 Fri, 02 Dec 2022 13:46:14 +0000
Date: Fri, 02 Dec 2022 21:46:10 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <638a01a2.mndELBdT3qS02k0I%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1669988776; x=1701524776;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=9hxo7uIfeGHbe/nCfWLT53t2m4wpDs2xtpy3LRh838c=;
 b=aLvxcMNvhC3Hw+EwM3l+zcoOVUU0uUDJTaV0H4UKkUrfi9PcidBzD7tu
 HVSP6c158NM7bhZPfhm5S9uG9W0JDFfIw2x1oPKcGfrL0CBIVDJiAlz4T
 o46HrOJXP+hE9bJ/7h1a5Bt4m3xXBajGplFrp8UN67Y4JLXxx0+pvNcT1
 6E9UpifNt0L65Zc9cMosR80GULhIHMABxXABWXzUu+LjTyoH2oK/3q2LE
 X9eimUQc1U+kbWB2NEbsQnsxltCog8Nkw0ykOCWQRpCtEUJf6FRLFCJVu
 o8INWNIMN6TTuLTMcHNATHttXQtF9I8x+vfn+Y8lPOYkai5jBWLXsODHH
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=aLvxcMNv
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 d76f0d37336193f6516791d03f7c3cb8205dca0f
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: d76f0d37336193f6516791d03f7c3cb8205dca0f  ice: Enable extended PTP support for E823L & E823C devices

elapsed time: 1256m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
powerpc                           allnoconfig
x86_64                    rhel-8.3-kselftests
sh                               allmodconfig
x86_64                          rhel-8.3-func
powerpc                          allmodconfig
mips                             allyesconfig
ia64                             allmodconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
arc                  randconfig-r043-20221201
s390                 randconfig-r044-20221201
riscv                randconfig-r042-20221201
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                                defconfig
i386                             allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r041-20221201
hexagon              randconfig-r045-20221201
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
