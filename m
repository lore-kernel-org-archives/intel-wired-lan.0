Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E678C4332F
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Dec 2022 12:07:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 04F3D4020B;
	Fri,  9 Dec 2022 12:07:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 04F3D4020B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1670587650;
	bh=9/qmhq5V2RFETOvgcogvdL2IO2Ys6IL8iEdUmJ+7YH8=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hpAH64BuOysLVi5vrAysjycNWnArUG1n1AcDwRJSfjWHSho4f2xqqd+FemFkTW+Mz
	 DEz3ht79tDfOCcF/rC/lTfUNQSAacy3WWzM5j5cP0um84v1Vl7sqC6L9+K6Q85gWVH
	 cMGZURhvlxSSbxXWqbCxYQjmMiRQvwWv1tMku9Cx9XybxixrhZ+CsyRGb6QBA5IcCW
	 LgOeNHypErsuP5hC8EHH0IAzOIgZy5EmBV8ml+0NHchbbNa69kpSLneqTDt/z0dZ/g
	 XO6n1WC/vxWpAMM04v7845QvwDCvO8u/sfS1s/2XoQcVh4IMMEivV3U3w2Xn2+7Uc6
	 fVNSMuYaBLTGA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1v0IXhQpwYMT; Fri,  9 Dec 2022 12:07:29 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 098BA40CC8;
	Fri,  9 Dec 2022 12:07:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 098BA40CC8
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 324AB1BF333
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Dec 2022 12:07:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0070381E93
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Dec 2022 12:07:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0070381E93
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nOe3zHUNC8uy for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Dec 2022 12:07:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2944C81EC2
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2944C81EC2
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Dec 2022 12:07:14 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="381751956"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; d="scan'208";a="381751956"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2022 04:07:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="647383476"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; d="scan'208";a="647383476"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
 by orsmga002.jf.intel.com with ESMTP; 09 Dec 2022 04:07:11 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1p3c9n-0001p7-0T;
 Fri, 09 Dec 2022 12:07:11 +0000
Date: Fri, 09 Dec 2022 20:06:37 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <639324cd.REwSgfrZ+rMsoY90%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1670587634; x=1702123634;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=+DhMFIGWbs4bkTMyAE/u8agq36Obr8kNTIooe9VXCIs=;
 b=S7WOTMiduarweyg3+n/DjruqM+WRSWCs0C1sutzujyfvVLDHpE/gwkiy
 d3EHShKzfdFxLJJOf1x+4NYE2nGY99Tx4CbaIBgW6f7TiwvTN2HRO2Oh8
 KtXadyMljPyNrxfpAF1R2P2irvxYQsmdBr94JAnK6C5t2YlIPNY9ewKlY
 Tg1UZFoThJF0fcvCuxRgeaHQzPXX8MHvw3+AzfZLIA4Ec2IefO53rH9m6
 IaFfmu4sYYDOBBLoo7NqTQZ9PXw2z7jsHdFeTn+DyFwh1Loz7kVKfFfKl
 kf85WeR7KXr7rOLiQRvaY3u0GNfaWkos7XtGP1o1B3o2hUlyMWoeKa/7Y
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=S7WOTMid
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 f96b5b34deeddf406978e3b03dd0636e45d3ae57
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
branch HEAD: f96b5b34deeddf406978e3b03dd0636e45d3ae57  i40e: Fix the inability to attach XDP program on downed interface

elapsed time: 721m

configs tested: 60
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                             allyesconfig
arc                  randconfig-r043-20221207
riscv                randconfig-r042-20221207
s390                 randconfig-r044-20221207
ia64                             allmodconfig
x86_64                          rhel-8.3-rust
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                          rhel-8.3-func
alpha                            allyesconfig
x86_64                        randconfig-a015
m68k                             allmodconfig
arm                                 defconfig
arc                              allyesconfig
m68k                             allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
i386                          randconfig-a014
i386                          randconfig-a001
i386                          randconfig-a012
i386                          randconfig-a003
i386                          randconfig-a005
i386                          randconfig-a016
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                           rhel-8.3-syz
i386                                defconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                             allyesconfig

clang tested configs:
arm                  randconfig-r046-20221207
hexagon              randconfig-r041-20221207
hexagon              randconfig-r045-20221207
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a015
i386                          randconfig-a006
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
