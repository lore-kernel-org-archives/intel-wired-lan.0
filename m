Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52400C77B7C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 31 May 2023 09:55:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E182541CDC;
	Wed, 31 May 2023 09:55:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E182541CDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1685526924;
	bh=qqv5G8Gwv4oFhKzzzJZ72Ysmh9Y+dIZWhKHHCVRRo9E=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kYqIjAK0Kpj1I823TbOOWAuBkcLsT0hUM2YLp2KJbJq4nBSzga3esjSoL2LA00si1
	 XChaaTtsFmhCPJugtzcwrQbwBJNv5f750j0R4c+A3h1NUM94XiSxHQ7x8mjZ1v7gFO
	 yx9etT8TY/uICk7QSp1tITYyc1/ofM3A1xurARjGx3o7AOKj6tAgNHdrCdDUHXY/Oz
	 qliT8G1+eWdRqi7uiBFJx/Ap0cEf1f3ajTRikEi8R1L40/93nhRTXXy3cLenrpUwpf
	 KD5uzp1LyLZh2SczUDeW2W/Tw4oILcydCZw92rjDe7ys2qkA1MA7hBHfLn95bb1o/D
	 W3jT70/MXYfgw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L5dF8jZQLU2o; Wed, 31 May 2023 09:55:24 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id D9E68404D3;
	Wed, 31 May 2023 09:55:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D9E68404D3
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 6FF241BF97A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 31 May 2023 09:55:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 494F460B6E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 31 May 2023 09:55:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 494F460B6E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YyzJqXa1NACm for <intel-wired-lan@lists.osuosl.org>;
 Wed, 31 May 2023 09:55:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 104A860807
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 104A860807
 for <intel-wired-lan@lists.osuosl.org>; Wed, 31 May 2023 09:55:16 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="420956328"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; d="scan'208";a="420956328"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2023 02:55:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="771934608"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; d="scan'208";a="771934608"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
 by fmsmga008.fm.intel.com with ESMTP; 31 May 2023 02:55:14 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1q4IXy-0001FV-1C
 for intel-wired-lan@lists.osuosl.org; Wed, 31 May 2023 09:55:14 +0000
Date: Wed, 31 May 2023 17:55:09 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <20230531095509.SyFMq%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685526917; x=1717062917;
 h=date:from:to:subject:message-id;
 bh=9AI87s3qBoHRmjUtuS6atymnQlTocX67beJNT3C1PgQ=;
 b=FdeI52g62Zj+ntU/zJYiZUMyMvV5JPFH4/5o4fFEzVBFde2ZyzkmurbN
 IBpdjhiZtQ9tQvFAM1hyrR0R4RywOgKAjJRfcs6WuSaT7c4V1Bc+O1Hlj
 sT4e47tNkDltlRsWQkue86Uf280Nb9c9pzErlRZauXl6LzxGRkfJO2KwQ
 Redq9YBM+cqH1Y3wWEN9qZ8NY8OTMBfQ/9QFNmYnXusPWwR2EapqdTOVx
 1k9VacjmIlYgvzv0IWLKo+ooN8gQNyVN0+jid3x8G0RSNVR0dEX0WB9iB
 m9HW7XoBXpysEnIq4iumGBBw84I47pfQrUePxNcz2PhzmOJxWyRe6sMP9
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=FdeI52g6
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 7497316dffc64eaf1a624b2255e166b595ce715e
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 7497316dffc64eaf1a624b2255e166b595ce715e  ice: Don't dereference NULL in ice_gns_read error path

elapsed time: 722m

configs tested: 42
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r006-20230531   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r005-20230531   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
