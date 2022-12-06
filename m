Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6501BC3A5A7
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Dec 2022 06:28:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C27DA408EE;
	Tue,  6 Dec 2022 06:28:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C27DA408EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1670308134;
	bh=tEQBJcROkb3FKh/dxujGr9MuHto7We+SlMqfKjxCUaY=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KZB8aIgb3g8qS0+hwLJvrFJQ2AF0ULKAs0Cc5tIkFvXgEV7+zCqXyXBM26+DtLmpx
	 jIgK/Lc9uZj05jUdhctPkcV9AXSV3OiJf4JZCBaQRbvVtCtICmwICxn/CB804/zJk4
	 CoqCs9s7nsI/y3jgjYBSa9yGniYyDOGBxsYTgXp4q4R/BqC8OpgrGkbxKHBBRUcew/
	 HuWwzQpLgfAU2s0MKA87hiWP6mUnMCm4iCgctHZdfVyMhv8NfLsOvdncFy5dX/opEJ
	 mSoikS2ReIZSD1rY7iQXe62SD8/UkhV3BKqNaYDOeLGn+irdUFBddgnDllKVwTDJ21
	 o3X91ATVNAITQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8kkna5i1xvQm; Tue,  6 Dec 2022 06:28:53 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 793CE408F0;
	Tue,  6 Dec 2022 06:28:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 793CE408F0
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id D1AC21BF30D
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Dec 2022 06:28:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9F4AE81452
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Dec 2022 06:28:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9F4AE81452
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e64fxlhEjKtK for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Dec 2022 06:28:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4A42481451
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4A42481451
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Dec 2022 06:28:49 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="402820099"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; d="scan'208";a="402820099"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2022 22:28:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="646103025"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; d="scan'208";a="646103025"
Received: from lkp-server01.sh.intel.com (HELO b3c45e08cbc1) ([10.239.97.150])
 by orsmga002.jf.intel.com with ESMTP; 05 Dec 2022 22:28:48 -0800
Received: from kbuild by b3c45e08cbc1 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1p2RRf-0000f7-1G;
 Tue, 06 Dec 2022 06:28:47 +0000
Date: Tue, 06 Dec 2022 14:28:44 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <638ee11c.IlNSvCWr45NKgHYm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1670308130; x=1701844130;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=drTqWEw7pWpndYK5JVStvQh5GTIa/0491bgrCwO0NBk=;
 b=Y75SGLD1FsR0w1t8QC/LD+jQsCLRYkqLFjyTtTGw83EFuVm+crYyDfhL
 c1dXPrv8axFDiinDqScD9TbwwXqoC/7QUpUjvcFK4cE6PKCsoibVcNf9f
 hYR1dt6zzUvHTEqqS0Ynj8EKqEYKQi362DxGenjzoKGjhz0vAEdDJ78vM
 VQY8tz2Zbzd+T4H/PsNc/ZSaKxRjCk9B/udqZYnQdNs0us4HIr5m5qOri
 hmCsH9Ws0P/X5OwbHzRWfRmy7QjYYa9BaBpmnUgeP4DEsI21u84zV4MaN
 EqsLWBvsn6D63Sx5YYp0uVuIeJTAW+6twIJ1WlprbVc1u+NE0IkdxqyYg
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Y75SGLD1
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 1cf25bf43b15a92238b12bf87942e6cbe24e14d2
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
branch HEAD: 1cf25bf43b15a92238b12bf87942e6cbe24e14d2  igbvf: Regard vf reset nack as success

elapsed time: 772m

configs tested: 59
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
i386                                defconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
um                             i386_defconfig
mips                             allyesconfig
um                           x86_64_defconfig
ia64                             allmodconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
sh                               allmodconfig
i386                             allyesconfig
x86_64                              defconfig
arc                  randconfig-r043-20221205
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
s390                 randconfig-r044-20221205
riscv                randconfig-r042-20221205
alpha                            allyesconfig
arc                              allyesconfig
arm                                 defconfig
m68k                             allyesconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64               randconfig-a011-20221205
x86_64               randconfig-a012-20221205
x86_64               randconfig-a013-20221205
x86_64               randconfig-a014-20221205
x86_64               randconfig-a015-20221205
x86_64               randconfig-a016-20221205
i386                 randconfig-a014-20221205
i386                 randconfig-a013-20221205
i386                 randconfig-a012-20221205
arm64                            allyesconfig
arm                              allyesconfig
i386                 randconfig-a015-20221205
i386                 randconfig-a011-20221205
i386                 randconfig-a016-20221205
m68k                             allmodconfig

clang tested configs:
x86_64               randconfig-a003-20221205
x86_64               randconfig-a004-20221205
x86_64               randconfig-a005-20221205
x86_64               randconfig-a001-20221205
x86_64               randconfig-a002-20221205
x86_64               randconfig-a006-20221205
hexagon              randconfig-r045-20221205
arm                  randconfig-r046-20221205
hexagon              randconfig-r041-20221205
i386                 randconfig-a001-20221205
i386                 randconfig-a002-20221205
i386                 randconfig-a004-20221205
i386                 randconfig-a005-20221205
i386                 randconfig-a006-20221205
i386                 randconfig-a003-20221205

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
