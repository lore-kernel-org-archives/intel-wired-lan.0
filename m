Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3032C19F28
	for <intel-wired-lan@archiver.kernel.org>; Wed,  3 Aug 2022 11:57:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 887C341BEB;
	Wed,  3 Aug 2022 11:57:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 887C341BEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1659527832;
	bh=hvXxS/lPeplaqcmVZM54SjNlWxXDlCVsZPIMDaIPlj8=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GFLEZOSnuYpu2BkUJP44xlBGhZa7cZi+dY29gObQXf7NOGxSMnDvxRLEU4a8DYH4m
	 6GpDR4lYhma7W55LH4RIq+bctQnJuzgeVggCjUwh2E8FAaHXGLHUluxU5fi5U8QUGj
	 NLG9NmqjAxY723hlSxkiHtqvfffApqjwqOhaeFN3s9c2dh/RZu9sHH6po5+7U5NSlX
	 0umWk49zpn9vJTYorHvhnVI/H/uRcv4iKvh1FCOFEzAoJvrYEbxmsYSofN7q5FzHqc
	 jCwHHn6Qh7Z+ShYVmmV5ep0KoGZl1qURQnbTCG0UNoIcZpfBAooGwxl+srXAqSvXH3
	 j598SOeWxaa0g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 58bBR667ls6I; Wed,  3 Aug 2022 11:57:11 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 790BC40D24;
	Wed,  3 Aug 2022 11:57:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 790BC40D24
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 96C841BF369
 for <intel-wired-lan@lists.osuosl.org>; Wed,  3 Aug 2022 11:57:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 70C8582457
 for <intel-wired-lan@lists.osuosl.org>; Wed,  3 Aug 2022 11:57:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 70C8582457
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P942b5VSrBcx for <intel-wired-lan@lists.osuosl.org>;
 Wed,  3 Aug 2022 11:57:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ABCF182512
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ABCF182512
 for <intel-wired-lan@lists.osuosl.org>; Wed,  3 Aug 2022 11:57:05 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="288408818"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; d="scan'208";a="288408818"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2022 04:57:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; d="scan'208";a="662053086"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
 by fmsmga008.fm.intel.com with ESMTP; 03 Aug 2022 04:57:04 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1oJCzn-000HE5-1j;
 Wed, 03 Aug 2022 11:57:03 +0000
Date: Wed, 03 Aug 2022 19:56:21 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <62ea6265.+Bz1YP40pMllqEuo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1659527825; x=1691063825;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=GeOzI+fy9fANuI95LD3zLLf63qq4iiodel4rMSkQNbg=;
 b=S0a3g6SyOCjRxW7Jc6B6ZQVnboSc31Kcr63uFRqMizhZC8XiTZsRlWXD
 fON1K8T/Mo2ZAAqe2KNa0AJ5ENQR5Sj9D6pPm9/NFUHnotsHn71FqS8Cn
 y7h0PybpFZAsOGZ/HKRfOr6L6eF4BcWgicuLyTlDptbeTHft1++g43HmY
 Zoih0Jifye5nZ3h5P5yOz46PZ8Vhb7o0YjXKXLGC4nXJrsAM24pRiOp9g
 VX+EgYgFVNPBINUo88eUn1r1aBDOpvzlo6ZZBnEt9N+PLMUVsCYm2F9UL
 LUwZXBBOZw4XeMP0WrHvWSv5fwZv6NpMXcR2DiHOOb6vTZgdY9+gjSRv1
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=S0a3g6Sy
Subject: [Intel-wired-lan] [tnguy-next-queue:master] BUILD SUCCESS
 9017462f006c4b686cb1e1e1a3a52ea8363076e6
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
branch HEAD: 9017462f006c4b686cb1e1e1a3a52ea8363076e6  Merge branch 'wireguard-patches-for-5-20-rc1'

elapsed time: 790m

configs tested: 47
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20220802
i386                 randconfig-a015-20220801
i386                 randconfig-a016-20220801
sh                               allmodconfig
x86_64                           rhel-8.3-syz
x86_64                              defconfig
powerpc                          allmodconfig
x86_64                               rhel-8.3
mips                             allyesconfig
powerpc                           allnoconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                           allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
arc                              allyesconfig
alpha                            allyesconfig
i386                             allyesconfig
i386                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig

clang tested configs:
x86_64               randconfig-a004-20220801
x86_64               randconfig-a005-20220801
x86_64               randconfig-a006-20220801
hexagon              randconfig-r041-20220802
s390                 randconfig-r044-20220802
riscv                randconfig-r042-20220802
hexagon              randconfig-r045-20220802
hexagon              randconfig-r045-20220803
hexagon              randconfig-r041-20220803
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
