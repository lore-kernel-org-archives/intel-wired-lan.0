Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C58C43334
	for <intel-wired-lan@archiver.kernel.org>; Fri,  1 Jul 2022 09:39:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6698860BAD;
	Fri,  1 Jul 2022 09:39:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6698860BAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1656668386;
	bh=znyuJSrn7kfLm6DiXwBg3iZRM2XVC9mNJ2cbv2duDyk=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fOrM69mJxI0IEOGyDXi0EIEtnYX4ZfUTKsd9CxSKHAmkrvNgdgvBDVflG/PbHV+iM
	 lSk9hXWVPIrAA/HcNjpsMaNUigZEd3+0pEpbNviewlzvT4i7sl7boUajy8Hs0mEwip
	 iGbzN/UNeeZUj9+NuAkWvU29m3kj0TLHVgL01eSs59jgjSw5puKAJFq5Wst2r396vS
	 jVso2qVFgj9VQmny4gvOdKtEJhTL6uLTA0IG/teDPLfAReTQLvNxINvqkJ+1eJe00M
	 hW6db8dDD+asc7oknW5Tt89Cl5unGTo8IQ/ylqY5upGZ4JkXObFmpzqIdKCxI0pDDy
	 vztJnHA+TPhQg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YHzwIKgMHVkm; Fri,  1 Jul 2022 09:39:45 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 75C3260BC4;
	Fri,  1 Jul 2022 09:39:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 75C3260BC4
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 6D0511BF291
 for <intel-wired-lan@lists.osuosl.org>; Fri,  1 Jul 2022 09:39:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5001483459
 for <intel-wired-lan@lists.osuosl.org>; Fri,  1 Jul 2022 09:39:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5001483459
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4Sq8uuwCIB6J for <intel-wired-lan@lists.osuosl.org>;
 Fri,  1 Jul 2022 09:39:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6162283380
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6162283380
 for <intel-wired-lan@lists.osuosl.org>; Fri,  1 Jul 2022 09:39:42 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="265641428"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; d="scan'208";a="265641428"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2022 02:39:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; d="scan'208";a="541679868"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
 by orsmga003.jf.intel.com with ESMTP; 01 Jul 2022 02:39:36 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1o7D7g-000DnY-70;
 Fri, 01 Jul 2022 09:39:36 +0000
Date: Fri, 01 Jul 2022 17:38:47 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <62bec0a7.InUb0ahPG2WjeEM7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656668382; x=1688204382;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=SV5h6H+TG76hOPigVu4x4cYbcphjiWQl+F6U1DpRlYU=;
 b=Nh1ddg8UcwVYaTaY8WJk32ZKTZb8JJR4Vv5kZmMpsAwFATXFGE1+Tf8i
 8fu3CbOmrKTyV41ULZIwxhQvzcIl2qf3a2Qx4zEG+dYUnyYdffmeSOG2N
 bKIUbKac/8yQ6kGzPvR+2Dx/IrIOETz1oCu186T2u9uM0QJ3E8RKmADF1
 LzKn1rLWDaMbFKnCDn1aNmlaRT0oBy9RPKU5WRK1eh7ePTo6iNJcBEhY+
 mAzhPDqXZyvQ+ZCn95EwTHHJLgabiAqX5Ypc0gZJQTQwDyP3SaFiUqAP2
 6EHABotTdIYKbOmYwKQ2rsO/x4O6+hQhlsVak24a6i4LGWcJ2Wt+SfX6z
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Nh1ddg8U
Subject: [Intel-wired-lan] [tnguy-next-queue:1GbE] BUILD SUCCESS
 173e468c717c4f422e3785d6bc95a85c456faece
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 1GbE
branch HEAD: 173e468c717c4f422e3785d6bc95a85c456faece  intel/ice:fix repeated words in comments

elapsed time: 724m

configs tested: 50
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
ia64                             allmodconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a004
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220629
riscv                randconfig-r042-20220629
s390                 randconfig-r044-20220629
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220629
hexagon              randconfig-r041-20220629

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
