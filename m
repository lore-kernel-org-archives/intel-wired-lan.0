Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54731C19F28
	for <intel-wired-lan@archiver.kernel.org>; Wed,  3 Aug 2022 04:29:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E309781314;
	Wed,  3 Aug 2022 04:28:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E309781314
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1659500939;
	bh=vrbCa4CIBfsv4R9aE+wR2WN9MSULJauFsgWtl+8tLhA=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lpHOi9rOKMRukjuj6PPpXZMVH+NFEU4ikL+st+moEu326zHGUbv0LVvo7cE9nztTm
	 Do+oIEGHyYT64F++6iG4PH7+KsasYe8HQ/aN2AVLGjsgIq6L+5QI2uHbv7IH387YKx
	 R0swFuInDS3T77MNpMwiTqCJgyONXmYuqF0vTmAPeNSQm32dxL1u/7AxC4HqsIt1eT
	 onJnQ+0PqHtIgIipDELaraOttM6f9pDTLFZbkrWPMGoGZR6st+EMUxVE3b/zFj6Olw
	 9pM5RNRvxeIvmsYevFx6tWS5s07fkNIl5mId5IYzWM6RhY2X1z2TwaTktJB54vkCq+
	 pLJ7s0jR3JyPA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lJjAPgGvCn15; Wed,  3 Aug 2022 04:28:59 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 065928131A;
	Wed,  3 Aug 2022 04:28:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 065928131A
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 97B071BF2C5
 for <intel-wired-lan@lists.osuosl.org>; Wed,  3 Aug 2022 04:28:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 694D4403C8
 for <intel-wired-lan@lists.osuosl.org>; Wed,  3 Aug 2022 04:28:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 694D4403C8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s3ubzt3EelST for <intel-wired-lan@lists.osuosl.org>;
 Wed,  3 Aug 2022 04:28:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2699E403C1
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2699E403C1
 for <intel-wired-lan@lists.osuosl.org>; Wed,  3 Aug 2022 04:28:55 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="287139760"
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; d="scan'208";a="287139760"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2022 21:28:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; d="scan'208";a="578487396"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
 by orsmga006.jf.intel.com with ESMTP; 02 Aug 2022 21:28:48 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1oJ600-000Gox-0k;
 Wed, 03 Aug 2022 04:28:48 +0000
Date: Wed, 03 Aug 2022 12:28:12 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <62e9f95c.W1S4NO+a/qNnCCdG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1659500936; x=1691036936;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=/vorI2nK2iTssOqYLric5A9IVizxMjUInv7551XJeEc=;
 b=KpRfNMa/VDTIJXqY3Van6u22t+2nRzkC9DSwSpCEGsuRujN+nQmJmzB+
 RGX4iHZGpP5lDBt4jRh3F1xRjwpLjL5poSXkKCtIf7EjfNWd3cSGuI0Ed
 vLYvUJEhYqxPJiesCdAdFI1ETeq6eG2Hr6yydcOx7PjIK6oBMZBfu0O9m
 ZS6aH6ZSRexpZYaMyINDkqCc9uhDQ4FZ556ettxflElXg6SmIh7YIED2f
 be2mUIwjGX5nMyAVFUdLXRHrXoIioENcOoh5+gBVQGsCHMFbE8ZMcmJml
 bgW/CPw0Leq31G8jdiQY1TXFQaLaAYr8AeH9pLSyLr/1e+lL6k30i2lAv
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=KpRfNMa/
Subject: [Intel-wired-lan] [tnguy-net-queue:master] BUILD SUCCESS
 8eaa1d110800fac050bab44001732747a1c39894
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git master
branch HEAD: 8eaa1d110800fac050bab44001732747a1c39894  net/mlx5e: xsk: Discard unaligned XSK frames on striding RQ

elapsed time: 863m

configs tested: 20
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20220801
s390                 randconfig-r044-20220801
riscv                randconfig-r042-20220801
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig

clang tested configs:
i386                 randconfig-a005-20220801
i386                 randconfig-a006-20220801
hexagon              randconfig-r045-20220801
hexagon              randconfig-r041-20220801

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
