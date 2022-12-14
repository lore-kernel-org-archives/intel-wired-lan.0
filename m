Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A42C4332F
	for <intel-wired-lan@archiver.kernel.org>; Wed, 14 Dec 2022 13:24:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 61CA541696;
	Wed, 14 Dec 2022 13:24:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 61CA541696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1671024271;
	bh=Odc+2uPBK/V/mYbItZ1JaCPeOm3MX+2uIaFZCZyNKwc=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zxhOU+zgGvFws3figek1yYw/oLUpTEAvuqOf3zsFL6d8qeRt0WvRIFLhUhfYFpRVh
	 7S536TeypGt/g3Lw15udT+Am4s3+WZS0DjDwkNaI+nkpSroXp+AodAhPjCWjRXX+st
	 XfN9vb74ptk6rfT795rUbm8WrZwIYd6/DL0jzNE9etwGR0DGWUKiobjEZcst2lFhpz
	 gMw7Yi8yd4adEhR5GpMuPI0nh3qvtcMHMQo2DP2hmCjBfu9mCdM/PneCR2k40zf7+t
	 IWVpyJx1TDcWftSePxUrufLOzSn+vh2Q9hY759DKIWvSu5OhmImRLD1qdSD6Mv2fYM
	 Lpu/tnzeVMZ+A==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LZtNdTPHe6HI; Wed, 14 Dec 2022 13:24:30 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30A9F4169E;
	Wed, 14 Dec 2022 13:24:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 30A9F4169E
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id E4B6E1BF33F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Dec 2022 13:24:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BCE1E416AB
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Dec 2022 13:24:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BCE1E416AB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k3xfAESh4rrV for <intel-wired-lan@lists.osuosl.org>;
 Wed, 14 Dec 2022 13:24:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 558DD41696
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 558DD41696
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Dec 2022 13:24:27 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="301818019"
X-IronPort-AV: E=Sophos;i="5.96,244,1665471600"; d="scan'208";a="301818019"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2022 05:24:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="823255494"
X-IronPort-AV: E=Sophos;i="5.96,244,1665471600"; d="scan'208";a="823255494"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
 by orsmga005.jf.intel.com with ESMTP; 14 Dec 2022 05:23:59 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1p5Rjq-0005VB-1M;
 Wed, 14 Dec 2022 13:23:58 +0000
Date: Wed, 14 Dec 2022 21:23:47 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <6399ce63.V73tlr+Fg4a03YTa%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1671024267; x=1702560267;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=zn3jHjpzfkk/H1QJ0BR8h9YEtpmaC9zXiy18sxPBT00=;
 b=PxpiIvLKWKqXP+SJIZBRj0l7KMLy1bvgfiAgMCTpLMHzdXyAtTxKWpsq
 wDc2a9nKJ1x6LvdmvjDuCnSCBPoGqei174DZmumuM2smZ3pAJ9OcdnEOC
 18F9LL5UqPnmmA4dCCMsPQPKIe7OVoxqiF4gRolqVDO731KDFTmm7tUAp
 8PfKgRrQtcAHlgYOgHoWefRShItbvIxfdpcDJOYb6wFhtbY0xqzb+VmXI
 LFZ3VNkOXgt7scjN+tXpV4xlMI0tnIYkvIc7eh7B+JWOzokkHpEES9oWQ
 BBrNnvCIlSuqO96xUyT9WEJiQNMmzSpTLY+JOoKMq08H6fwnTInfTZHVE
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=PxpiIvLK
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 8698d61ffc76aae82dd98ddbca272f21802d34ae
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
branch HEAD: 8698d61ffc76aae82dd98ddbca272f21802d34ae  ice: use debugfs to output FW log data

elapsed time: 723m

configs tested: 61
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
powerpc                           allnoconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
arc                  randconfig-r043-20221213
arm                  randconfig-r046-20221213
s390                                defconfig
sh                               allmodconfig
i386                                defconfig
mips                             allyesconfig
x86_64                        randconfig-a002
powerpc                          allmodconfig
x86_64                        randconfig-a004
s390                             allyesconfig
x86_64                        randconfig-a006
ia64                             allmodconfig
x86_64                              defconfig
x86_64                          rhel-8.3-rust
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a001
i386                          randconfig-a003
i386                             allyesconfig
m68k                             allyesconfig
x86_64                        randconfig-a013
m68k                             allmodconfig
x86_64                        randconfig-a011
arc                              allyesconfig
x86_64                        randconfig-a015
alpha                            allyesconfig
i386                          randconfig-a005
arm                                 defconfig
x86_64                           rhel-8.3-bpf
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016

clang tested configs:
hexagon              randconfig-r041-20221213
hexagon              randconfig-r045-20221213
riscv                randconfig-r042-20221213
s390                 randconfig-r044-20221213
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
