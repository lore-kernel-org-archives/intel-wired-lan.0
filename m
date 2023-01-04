Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A417BC4332F
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Jan 2023 11:37:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 56435404DA;
	Wed,  4 Jan 2023 11:37:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 56435404DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1672832278;
	bh=9WnThFuWev3xxopbb/oxWqkppeP6qoOizl7Uw/YxVQM=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=T8392z5wWvjQ0scVD8IfR1FLEbCIsr7xVgvpSKqvRunW7hrNPmuiPi0ijdFzfUOxi
	 QZtfLTi9lY/H7gAJ1sqqVxyRHlnT9Cl8k8zzlJRmlb4N8Uom4LrL3aDIU/BJk9FPT7
	 z7OWEHyfWygZ+Sa0wE2SuFnwCVT7ne8Z8n/B85bGGBF9agixWiO1tscq8yQLO3Q0QH
	 Sa/577WgQkPvSCiEEOZs//96TPBvGpaknsBmOWvFx1VN/5FrLYJn+iEzI/cKvqR1eG
	 4hxx+iy9d0Wl/mftSbw+IvE1tYUbDj5U0HiR4nyFnCGXoDn6lAQNdgI65E3/iA9AwT
	 +roc6VrcW+Qww==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xvNiCXT4Ht2L; Wed,  4 Jan 2023 11:37:57 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 413F740574;
	Wed,  4 Jan 2023 11:37:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 413F740574
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id A03DB1BF2F9
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Jan 2023 11:37:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7B0E6403F9
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Jan 2023 11:37:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7B0E6403F9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SXidTQLcAieQ for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Jan 2023 11:37:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1E9524035D
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1E9524035D
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Jan 2023 11:37:50 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="321981873"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; d="scan'208";a="321981873"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jan 2023 03:37:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="687499374"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; d="scan'208";a="687499374"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
 by orsmga001.jf.intel.com with ESMTP; 04 Jan 2023 03:37:47 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1pD25a-0000JA-32;
 Wed, 04 Jan 2023 11:37:46 +0000
Date: Wed, 04 Jan 2023 19:37:25 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <63b564f5.Vo+fTfGMHmYiHAMP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1672832270; x=1704368270;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=EZaN/lbfLzJqhu8jRbq9LH9V7Hqtvo4Jwd7uotYdjPE=;
 b=LNko3zFuG0Icrx49BYHxzjY6YXIaNCoNYz046qbj9fQNxA7xe/cy16Lz
 0o2uB4lYTL4E4LOxrWOugV6Aw3e2S/yDIZ0+NG0P7AN8i6RQz0fjIbpXB
 SwYQBiBuNs48+Std2tHiNNnLWhjTgK4ff9whEY28/hreStd3OUc5v9quA
 Q0KM9p483zic1jN+ucrZZDZp816fFTU3e+gLsOJpj1U8BePfw31VqgbLP
 oypAy1vmrxUdLyXx/g8IEmgngDXjbuvJzmEm7hDn7xuKtdQmteHEFfbMz
 JLwt9zMTBYN444c/jbgjeJjEUnWsM3sMDeNTVZVj4vMCuOzhB6tODCQtb
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=LNko3zFu
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 edbe763071ad7a17f299ea0a4c0e73a1cd55ab9f
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
branch HEAD: edbe763071ad7a17f299ea0a4c0e73a1cd55ab9f  ice: Remove excess space

elapsed time: 723m

configs tested: 67
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                              defconfig
arc                                 defconfig
x86_64                               rhel-8.3
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
um                             i386_defconfig
powerpc                           allnoconfig
um                           x86_64_defconfig
i386                 randconfig-a004-20230102
x86_64                           allyesconfig
x86_64               randconfig-a003-20230102
i386                 randconfig-a003-20230102
arm                                 defconfig
x86_64               randconfig-a001-20230102
i386                 randconfig-a001-20230102
x86_64               randconfig-a004-20230102
i386                 randconfig-a002-20230102
x86_64               randconfig-a002-20230102
i386                 randconfig-a005-20230102
i386                 randconfig-a006-20230102
x86_64               randconfig-a006-20230102
i386                                defconfig
x86_64               randconfig-a005-20230102
sh                               allmodconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
mips                             allyesconfig
alpha                            allyesconfig
ia64                             allmodconfig
powerpc                          allmodconfig
arc                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arm64                            allyesconfig
arm                              allyesconfig
riscv                randconfig-r042-20230101
x86_64                          rhel-8.3-func
s390                 randconfig-r044-20230101
x86_64                    rhel-8.3-kselftests
i386                             allyesconfig
arc                  randconfig-r043-20230102
arm                  randconfig-r046-20230102
arc                  randconfig-r043-20230101

clang tested configs:
i386                 randconfig-a012-20230102
i386                 randconfig-a011-20230102
i386                 randconfig-a014-20230102
i386                 randconfig-a013-20230102
x86_64               randconfig-a011-20230102
i386                 randconfig-a016-20230102
i386                 randconfig-a015-20230102
x86_64               randconfig-a014-20230102
x86_64               randconfig-a012-20230102
x86_64               randconfig-a013-20230102
x86_64               randconfig-a015-20230102
x86_64               randconfig-a016-20230102
x86_64                          rhel-8.3-rust
hexagon              randconfig-r041-20230102
s390                 randconfig-r044-20230102
hexagon              randconfig-r045-20230101
hexagon              randconfig-r045-20230102
arm                  randconfig-r046-20230101
riscv                randconfig-r042-20230102
hexagon              randconfig-r041-20230101

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
