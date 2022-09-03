Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5305BECAAD5
	for <intel-wired-lan@archiver.kernel.org>; Sat,  3 Sep 2022 11:49:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDC93408DE;
	Sat,  3 Sep 2022 11:49:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DDC93408DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1662205773;
	bh=+MuBS5Kg9NNEqkkNQ+6qGaeJmuuggTkN8siXC//Mg0o=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DejCPmX9fI9R24RDz15OfHsC7beyNZmYjT/LVwXOOC7FhqEa7K0yDXVfXbw+2UTj6
	 MEruCyFOf40wJov9V+SnSi/MaAZnwGsMU5tQqOzHG6gSxH7HHxx/EkWaIirzdgCOSX
	 qfRe2ukN8fifT9jokwU5K0kH0qppp+/CLYheGQmbDo3Po5KKW4I0AJF6pKwGzogp71
	 K/S3eHnH4CIIWUNyF1BZxkWGfwNXBYKutCrupl0ViP2Ym3MetFSR5WGrNHQt+7u+wP
	 5c/2fs/S8RXWl8ETGpGlwRSkGFCHRW0irycByDpwunwQaSBn0oAuCP3y7XJzh5EQak
	 D8NxTDqL2Mluw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yyzNG504zlmp; Sat,  3 Sep 2022 11:49:33 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id B00DA40981;
	Sat,  3 Sep 2022 11:49:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B00DA40981
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 333F01BF2A7
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Sep 2022 11:49:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0B03340981
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Sep 2022 11:49:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0B03340981
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X-s4PeETaBHT for <intel-wired-lan@lists.osuosl.org>;
 Sat,  3 Sep 2022 11:49:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D523F408DE
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D523F408DE
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Sep 2022 11:49:29 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="357866857"
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; d="scan'208";a="357866857"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2022 04:49:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; d="scan'208";a="590375623"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
 by orsmga006.jf.intel.com with ESMTP; 03 Sep 2022 04:49:28 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1oUReR-0001an-2E;
 Sat, 03 Sep 2022 11:49:27 +0000
Date: Sat, 03 Sep 2022 19:48:41 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <63133f19.FvhP7dnbd1lAi1A2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1662205769; x=1693741769;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=etzH1uYuPaEH7OdnaKem0dzZ2e+40MmSrO8YfunVZ3U=;
 b=hHWPPN6QyqR/SVY4HFckuujB4O6aTqa//1jR9dTtOkiBS1a+PieGbcpi
 PYTidLIXft0ORuIMeBv8ydSXsONPmxmeHPXwnbinSgSKi0pKHOTh6O72b
 Tb+5LB355J8opnN46SJLyhvA3VAt3hhY1ksWfnlMBSAKQdLpP2Sn78K7P
 AzhgHQprhIs18UENgQvYSqZTcwhzSjNCdIhLHsF4TiffB/Zt5hkbg+4nJ
 Sp0iv64lQ/4475/3vcSPvVllnY1ga82XRhD3mEyDUBTLvq3tzva1I9AYN
 /vfpEUgBJ+XRK402UuY1oXJK9YCsDt3SCEyNcpexHwsgie63sIysCO+ut
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=hHWPPN6Q
Subject: [Intel-wired-lan] [tnguy-net-queue:40GbE] BUILD SUCCESS
 aa626da947e9cd30c4cf727493903e1adbb2c0a0
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 40GbE
branch HEAD: aa626da947e9cd30c4cf727493903e1adbb2c0a0  iavf: Detach device during reset task

elapsed time: 936m

configs tested: 24
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
mips                             allyesconfig
sh                               allmodconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
arc                              allyesconfig
alpha                            allyesconfig
x86_64                              defconfig
m68k                             allmodconfig
i386                                defconfig
m68k                             allyesconfig
x86_64                               rhel-8.3
i386                             allyesconfig
x86_64                           allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig
powerpc                          allmodconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
