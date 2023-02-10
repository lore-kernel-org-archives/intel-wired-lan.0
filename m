Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F20AC05027
	for <intel-wired-lan@archiver.kernel.org>; Fri, 10 Feb 2023 19:11:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 21A30400CC;
	Fri, 10 Feb 2023 19:11:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 21A30400CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1676056271;
	bh=p1EbMW3yZ5827yo82lYSoHIfailndZ2oV6+OPgBFcOE=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mM0zcCpu88Aog6EKYhw111NFOGdk9H1GkHfQVL/AmGSbvVGpMpLDFXJpikTMw9qdA
	 /dbooiozc7qiedgllRlAF1onJz7wAQBvdSNRyZj+MMqlkB4iPKX8fXGqTWIdS33Toc
	 LKBDRadvEdahTZUhvE3uxJtoBjaMQ8frW9QNiLddRRr84bcC3EuZUCV8/S6gSqqlg3
	 Gp/Fw0cZJv/PyLJ7dzkTmRGkv2MGDeNmCtEOI1kOhbuK6ISuXF6B9tFYtuKUdYvIz+
	 SChSUKjsu+U1ZP+wjmywKRVW6R3oHRjGH26F+Z5pLEL2o+ILF++eVm0xRuOMnu95Hy
	 FQkHOFUeO5hkA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XITILj0miyGw; Fri, 10 Feb 2023 19:11:10 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 18F1E40125;
	Fri, 10 Feb 2023 19:11:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 18F1E40125
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id C98F61BF297
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Feb 2023 19:11:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AF5118212A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Feb 2023 19:11:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AF5118212A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id brK_XAEh_iQ7 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 10 Feb 2023 19:11:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 73B2D8211D
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 73B2D8211D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Feb 2023 19:11:03 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="392908318"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; d="scan'208";a="392908318"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2023 11:10:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="810929376"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; d="scan'208";a="810929376"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
 by fmsmga001.fm.intel.com with ESMTP; 10 Feb 2023 11:10:45 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1pQYnE-000609-09;
 Fri, 10 Feb 2023 19:10:44 +0000
Date: Sat, 11 Feb 2023 03:10:01 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <63e69689.MFDhztEKXU2C6Qtd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1676056263; x=1707592263;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=u4zfZmRn3VIKh+gsQPPMs5hD0KdaWES+Rukyq93/4ZA=;
 b=ib8Rl6trBbG1KNnE4xk9vIMnrDkBc0hjHNvNQHBKu/4mFEniQANGr38a
 UrjdeI4he0KIsuShb11SeOQfitv/OiBfPnG5oOdMGGM7rXSuQd2TE7pR7
 e7pDuTxO/7UEKgaCbfhAEJU7htz04TNc69MWjiB+V1zX3kLC+KtFJt70i
 s5DvoRa7W14yazUCjfXdQo64NpmYrnJsXlbhYJ612wXbFZmubAxJdxQHg
 tPoNrxTHzPzr430FtE78yqVEY3bna4FzTa9px44/pHxxYk/by7McfXd7J
 Tq6a1jC15/9/odkTB43IcESspUdzQEqW4Jc+7SPvEehKag11S2GmWB+UH
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ib8Rl6tr
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 fe48d853421c3fb994a6bbac3b28f843fe4c5f7a
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
branch HEAD: fe48d853421c3fb994a6bbac3b28f843fe4c5f7a  ixgbe: add double of VLAN header when computing the max MTU

elapsed time: 1060m

configs tested: 42
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                            allyesconfig
alpha                               defconfig
arc                              allyesconfig
arc                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
csky                                defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                                defconfig
ia64                             allmodconfig
ia64                                defconfig
loongarch                        allmodconfig
loongarch                         allnoconfig
loongarch                           defconfig
m68k                             allmodconfig
m68k                                defconfig
mips                             allmodconfig
mips                             allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
s390                             allmodconfig
s390                             allyesconfig
s390                                defconfig
sh                               allmodconfig
sparc                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
