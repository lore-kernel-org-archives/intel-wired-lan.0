Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B551C0502A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 31 Aug 2022 04:30:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 91E2D60B13;
	Wed, 31 Aug 2022 04:30:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 91E2D60B13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1661920258;
	bh=5m8fMbU4ZoOM5bIyr0mZQa3LRZChco8G8xCtEiNRuKw=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jpfF3gPgh8aa3ay7jHv2hEF+L8iCBkGicxD2eTxNvspFipyYJuQudiCJ3RQUBpBSb
	 ckmuGIXu7BUDlW6REfDimH9eNgVl9IsgTkKXHkJtXRv6SkUVDftKrlIG+i0bOY5EEB
	 rDCR76BQzhp2NJUgy3D/a7UympuDeKLeg6NPt/CJeWHKJnBUPQEC6/5w+acIzukM6C
	 6Kx/CfqUmAxAYXOM7oEGq8Hsa+jMSpo8n7eJFBaUAwsRabxit8kET+EQE+yIEKtpDf
	 UgS3vFm0KVKPdJXuA1h//6jL9ykSGAuqt4r2eCXD6qTzO4UiELi5GERQfDHhvmabIl
	 G3NBYS2mt+svg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zXaqSPc79pdQ; Wed, 31 Aug 2022 04:30:57 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E79B60E89;
	Wed, 31 Aug 2022 04:30:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9E79B60E89
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 346CE1BF951
 for <intel-wired-lan@lists.osuosl.org>; Wed, 31 Aug 2022 04:30:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 07C37824B4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 31 Aug 2022 04:30:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 07C37824B4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hfd8nzhJjm-5 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 31 Aug 2022 04:30:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9CC2482410
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9CC2482410
 for <intel-wired-lan@lists.osuosl.org>; Wed, 31 Aug 2022 04:30:54 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="278386485"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; d="scan'208";a="278386485"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2022 21:30:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; d="scan'208";a="645105403"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
 by orsmga001.jf.intel.com with ESMTP; 30 Aug 2022 21:30:53 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1oTFNM-0000zq-1J;
 Wed, 31 Aug 2022 04:30:52 +0000
Date: Wed, 31 Aug 2022 12:30:25 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <630ee3e1.Vx2wcRmu5C9AQYOv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1661920254; x=1693456254;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=RR3rD/iqhER05uwaUivlyS1H8LPmkMg73xgMpLC0JP4=;
 b=Tnx/ImY4NTsxNcpLti+YjJKBh1HxIkf5CHqyf3xkVcHK/1CBGMo18ylv
 3bWF0g/ZN+NbWhpglFjvASq2vRvPhBuHoPRSs8/mWHk9WoX8oo4ApBAtj
 qqmeRKqX5tEHG19k6cccSijOMkvZD5NfZwAVIkaHfPzBG6UAbq3GoIwXB
 GT5kivdWtLxpK6X3ObQ05PDQsnrmMFKOHY4P4ANPliQHbTH6JxMX90zIJ
 Qp4zIEkpT9m0dkIAbM41PIt1sHyBasbtmDR9BSx8cEW549vqtK8LD+YYk
 693IUd6TV+j+2m0LmMZM96yPZHNZ/tFS8tjTD4nLLyz6FMmtTX2bL6+CA
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Tnx/ImY4
Subject: [Intel-wired-lan] [tnguy-next-queue:master] BUILD SUCCESS
 146ecbac1d327e7ed2153cfb3ef880166dc2b312
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
branch HEAD: 146ecbac1d327e7ed2153cfb3ef880166dc2b312  net: devlink: stub port params cmds for they are unused internally

elapsed time: 879m

configs tested: 44
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                  randconfig-r043-20220830
um                           x86_64_defconfig
um                             i386_defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
ia64                             allmodconfig
arm                                 defconfig
i386                                defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
arm64                            allyesconfig
arm                              allyesconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                             allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016

clang tested configs:
hexagon              randconfig-r045-20220830
hexagon              randconfig-r041-20220830
s390                 randconfig-r044-20220830
riscv                randconfig-r042-20220830
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
