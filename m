Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E292CC43334
	for <intel-wired-lan@archiver.kernel.org>; Thu, 30 Jun 2022 04:49:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72076417C1;
	Thu, 30 Jun 2022 04:49:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 72076417C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1656564577;
	bh=eMdjozrhvq+V3qXEhMaUpRHF2lE9DCJN5NtirZesafo=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XgUvOE4RjrN1Ghh4vK0XKeZEGuOSgiWlPfhmc9vb9mSPYR3skxFdV125ifbRk0q+o
	 IyZIGmNjR1WQ7yCLGl1E+XPd+7sI80H4rTiFvBQ2u0JUWMHrpBIbSwKKoS0ojdWROw
	 JC935ClSMZ0MF9mQP4bYFDFC92/60gNmPZNzlencG4k4TkxkPtbyPZlDyCmAf9wPbB
	 rpWIi5aVZH4/DjOyeHGgzF/HbVvxwuBQsuK6nFX12ZU6YzaT/4N4nYeXsNxrkWMST/
	 efQqoAyILCPUWAbw1zTyKEngMQLTh2DL3kXKCoSGXpMG5sD5r6v0ORrqzKjaFyVuHF
	 Xc9H30IfGWSlQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MgRDb1pEvPW6; Thu, 30 Jun 2022 04:49:36 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 04F06417C7;
	Thu, 30 Jun 2022 04:49:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 04F06417C7
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 045EA1BF299
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jun 2022 04:49:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CB2848412A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jun 2022 04:49:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CB2848412A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KDp3gVYjtgnP for <intel-wired-lan@lists.osuosl.org>;
 Thu, 30 Jun 2022 04:49:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9E691840D2
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9E691840D2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jun 2022 04:49:30 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="282976991"
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; d="scan'208";a="282976991"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2022 21:49:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; d="scan'208";a="595535678"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
 by fmsmga007.fm.intel.com with ESMTP; 29 Jun 2022 21:49:28 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1o6m7L-000CF0-UD;
 Thu, 30 Jun 2022 04:49:27 +0000
Date: Thu, 30 Jun 2022 12:49:00 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <62bd2b3c.TcStPMh8uLZKcvWb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656564570; x=1688100570;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=nEhvbz2dYcJu0LRiCC/tyxK35L42H8utm0e/YyeOMqQ=;
 b=HV7mfYhadFyrKOsUgfw3KymbXHY+SuwCCUiKESVIimdh7vwgK99Y5d+x
 LYuyQ2GApUNlleYRLmNw7wdrT/c6VBmlkhEewqlrBdTn5lVPgvlrP+n38
 NPjkUwxqs+iOmyvnUJpdfQ5kFS/ucEm4O/Itvfg1k/F4WH8zAbjDf7E5K
 ONFwuSbUqupEn2nTnWH1UgaiqDkXtGijNpijK4kiWnCiYgOu2oFT3clw4
 YbaFv9VoL5plXAg96Tah/Lb5wEUh8Ug/3TUa1Ga1DBob80QhIH8cXsmYF
 oXKYCIeTwyC9Z6HEmP+LroOmWLQ0mH9RYT46A/li0wao4t6ISukmVgaYa
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=HV7mfYha
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 a3f37717b0b479dffa856f737bc067df359b0684
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
branch HEAD: a3f37717b0b479dffa856f737bc067df359b0684  ping: fix ipv6 ping socket flow labels

elapsed time: 728m

configs tested: 46
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a012
i386                          randconfig-a014
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
arc                  randconfig-r043-20220629
s390                 randconfig-r044-20220629
riscv                randconfig-r042-20220629
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
hexagon              randconfig-r045-20220629
hexagon              randconfig-r041-20220629

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
