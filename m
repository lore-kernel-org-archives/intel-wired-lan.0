Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB47CECAAD3
	for <intel-wired-lan@archiver.kernel.org>; Thu, 15 Sep 2022 06:41:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D7C981D19;
	Thu, 15 Sep 2022 06:41:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4D7C981D19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1663224102;
	bh=nibnoRVCs7zgLzpcAvTUrmDLyYOqB1DWybL2Q48Eg8E=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=56ACOkqXTjcN8301kGB7XYxE7QVl8jXLGguYQyugWnqd2WpEGy5shJ7VJbj+p5XRH
	 yCzxS573K27tcESDrq2q1gVUg3Yu8x227MFXJE8uwQvH4AoQMZRWVWbQ1bz8GSX84J
	 /qD0splZW5J61RpoUXokSLLF9PSLCqEqFuJKsu03mf3/3tTNvdsQ6wPyW84ABrEGTR
	 8X5OfFXECarUPrmV/4XGGhww5lP4ClZJvds253hA73yC7dQVEJ69vgRrMVyNKaI4Rq
	 9DgoCvG2KVFfSpivTfAbJdKXekL9UXJH+dRQg59VohjXc3NpAMTWpZoqtCIHyxgSf2
	 WBKABNScSYUIA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eim-EXzEOgvf; Thu, 15 Sep 2022 06:41:41 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3083882C98;
	Thu, 15 Sep 2022 06:41:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3083882C98
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id D46BC1BF873
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Sep 2022 06:41:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A5A4F60FAB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Sep 2022 06:41:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A5A4F60FAB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IQI32t4jPh6P for <intel-wired-lan@lists.osuosl.org>;
 Thu, 15 Sep 2022 06:41:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 830CA60D63
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 830CA60D63
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Sep 2022 06:41:38 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="279013806"
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; d="scan'208";a="279013806"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2022 23:41:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; d="scan'208";a="612773014"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
 by orsmga007.jf.intel.com with ESMTP; 14 Sep 2022 23:41:36 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1oYiZ5-00006G-1r;
 Thu, 15 Sep 2022 06:41:35 +0000
Date: Thu, 15 Sep 2022 14:41:06 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <6322c902.YCTeBeq/fo8CHego%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1663224098; x=1694760098;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=mv6Yc+VWCsvGk+1HXtdBD4MpVzgEJ37yj+aHZmuN1Qk=;
 b=H//jArW3EUY+s7fLwdRM6gJ0CEsO3MSjAog5RKWrWv87p/14hglQRGkf
 c1j8MhoCZWuYtA+lPaw0v5oLFihNk5SvUUsqGU5bERqeJ28FYBTYD+ziB
 ZRhNhYlBu8R01XhA+VwYscCHO64K6u+qbo1lrB5db7AD/8S7kBKcwakIf
 904gCeizrKwNKmRblfsVpfYuWhTAM1DSzdL+vQkkHS/Qf3WianG2aql9p
 QH5mxmoD5QjPO6oqaixGI+16dmiDVTFV686mXjunYOEc+UXFvGKxey08I
 EE8M4+nPbj5/aJ/D/zDGPPw+fakeSQaCoza9UxkTCRe3+isj4svTl/C4n
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=H//jArW3
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 d29cebeb162b0fd829d9cd8f78ef66977c7f635c
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
branch HEAD: d29cebeb162b0fd829d9cd8f78ef66977c7f635c  ice: Add GPIO pin support for E823 products

elapsed time: 721m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
arc                  randconfig-r043-20220914
x86_64                              defconfig
i386                                defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
m68k                             allmodconfig
mips                             allyesconfig
i386                          randconfig-a001
powerpc                           allnoconfig
x86_64                        randconfig-a004
arc                              allyesconfig
i386                          randconfig-a003
powerpc                          allmodconfig
alpha                            allyesconfig
x86_64                        randconfig-a002
i386                             allyesconfig
x86_64                        randconfig-a006
arm                                 defconfig
i386                          randconfig-a005
m68k                             allyesconfig
sh                               allmodconfig
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
arc                                 defconfig
s390                             allmodconfig
arm64                            allyesconfig
alpha                               defconfig
arm                              allyesconfig
s390                                defconfig
i386                          randconfig-a014
i386                          randconfig-a012
s390                             allyesconfig
i386                          randconfig-a016
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20220914
hexagon              randconfig-r045-20220914
riscv                randconfig-r042-20220914
s390                 randconfig-r044-20220914
i386                          randconfig-a002
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a006
i386                          randconfig-a004
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
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
