Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A068ECAAD3
	for <intel-wired-lan@archiver.kernel.org>; Thu, 15 Sep 2022 06:41:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C6001418DE;
	Thu, 15 Sep 2022 06:41:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C6001418DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1663224107;
	bh=YkVWiYF7u/vQSQPsD9GbWSs0ywVGp5mZPj3cuDMdIWU=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pPvLYtlIpS0M5rV/hXpleLRO87a/xgNXPfxsubW2oI4XhwIbzy4bh0R/wzIgm/FUj
	 MeJ06ulXdIiEoHhOkGTix3lmLt8W8rn/yB+Dm/Xy8h0yDLVkuWvOa6OapRcZepf3bu
	 a/7rsSv7n7ZPBF+jXCFsSMfLJ3MS1sunlfzgtPKFoyD63taO2uOfSJ/jDzYKd6De2v
	 fGbgCbAMrhzIDrfAdrX3FAOvZVXZoZOJgt/Onxzve81MZenTu4iJDB2YKBXernzL9x
	 xquI9LtQSs8LQZK2loNFW+0P/4QeNR/pxoFVpiPk++OOpIIkuqSjbYqhdUrTUg5RNU
	 e26xBAirPgcgA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 37CLDWv3lOdE; Thu, 15 Sep 2022 06:41:46 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 79D32418E2;
	Thu, 15 Sep 2022 06:41:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 79D32418E2
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id D04F51BF873
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Sep 2022 06:41:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ABA0B60FAB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Sep 2022 06:41:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ABA0B60FAB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TYtq-B9aGa5h for <intel-wired-lan@lists.osuosl.org>;
 Thu, 15 Sep 2022 06:41:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B937760D63
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B937760D63
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Sep 2022 06:41:41 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="362589089"
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; d="scan'208";a="362589089"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2022 23:41:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; d="scan'208";a="720867510"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
 by fmsmga002.fm.intel.com with ESMTP; 14 Sep 2022 23:41:36 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1oYiZ5-00006B-1i;
 Thu, 15 Sep 2022 06:41:35 +0000
Date: Thu, 15 Sep 2022 14:41:09 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <6322c905.dODbrryZOCdRlE7W%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1663224101; x=1694760101;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=udRemVHKQ2IkPdcqhNLi0+PfAO7rBh683FzzGvKU0lQ=;
 b=egYCYQw/uP9TmhEjIv0GOnq8cjBqyvgcHAtEsMVB6bv1nx4haLLcY9Ia
 TVDIFYuOXbJJaBAIoHbPqK4tyhsCOJKiE4pYy8twWz3jsOGII/Vd3pVjP
 dOD2nJ69x7On1krVbLvbWbXqWhMBEr4Wv3aAFJHv1dzOS/Zr/Ep4jAl+t
 Q6mkd9kiL8wJ3bO9dIpgtYS/n/RbVTaMuPqb1as4tlCXRif4WKQIUpjPS
 oC7IRnodyX9Ae0VryZ56ZL7LEgWEfHOVUfIkoT+lLUiwMk6NnNQSMHIrU
 m5mNNTxe5e/iVLeFOuQqb7XOdcoSF6GV8+5hbW9+QEp2zpx1AqjF3arI4
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=egYCYQw/
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 92244d305881735443925334bc28f618feba8a6c
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
branch HEAD: 92244d305881735443925334bc28f618feba8a6c  iavf: Fix bad page state

elapsed time: 722m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
arc                                 defconfig
um                             i386_defconfig
alpha                               defconfig
i386                                defconfig
powerpc                           allnoconfig
alpha                            allyesconfig
x86_64                              defconfig
m68k                             allmodconfig
arc                              allyesconfig
m68k                             allyesconfig
x86_64                               rhel-8.3
s390                                defconfig
x86_64                           allyesconfig
s390                             allmodconfig
i386                             allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
s390                             allyesconfig
sh                               allmodconfig
arc                  randconfig-r043-20220914
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a004
i386                          randconfig-a001
x86_64                        randconfig-a002
x86_64                           rhel-8.3-kvm
i386                          randconfig-a003
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a006
i386                          randconfig-a014
i386                          randconfig-a005
i386                          randconfig-a012
i386                          randconfig-a016
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20220914
hexagon              randconfig-r045-20220914
riscv                randconfig-r042-20220914
x86_64                        randconfig-a012
s390                 randconfig-r044-20220914
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a001
i386                          randconfig-a013
i386                          randconfig-a002
x86_64                        randconfig-a003
i386                          randconfig-a004
i386                          randconfig-a011
i386                          randconfig-a006
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
