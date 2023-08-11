Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE60EB64DD
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Aug 2023 05:45:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A7C6341D9C;
	Fri, 11 Aug 2023 05:45:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A7C6341D9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1691732745;
	bh=6NyMKuZgGStb90i4VnJeYR7MqK+fGJ1DlNOa1nVGu4c=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=khCX++xtOmmZ34OYatpZMkwHpv2MUUnmaADt83rNafL08o+hR/PdFRYqDUzb1r4XB
	 JrgMkiL8gX3PJxa9r/n73YnWxC52qVK34urwN5KlH6c7foev8WjQZaxMkW9fNyQKkk
	 JD8y0356GUP6GGVYcLNbM9a/b9CdlMnCIBxeenSkLz2sW5YPiUgVl45gkNLg8E/jYh
	 eoxopMr8l+UqOo+pIzhEADAvLcqzwQbO3t6qXYHFqXpF20Jkmnen2zuIy2c8pp3Yuy
	 0CyKm7fVWFVG67E84fLJg/DpYu9dZ0oPtIjkCQRf8x/KDQsoyNekiU4u4tSl+85YPU
	 kp5WemI13zFeQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8O8n9XcpEVFI; Fri, 11 Aug 2023 05:45:44 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 777F841D9E;
	Fri, 11 Aug 2023 05:45:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 777F841D9E
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 2D9B41BF410
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Aug 2023 05:45:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 038C041D9E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Aug 2023 05:45:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 038C041D9E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rsi92fLKWHDM for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Aug 2023 05:45:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 942C241D9C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Aug 2023 05:45:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 942C241D9C
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="356566934"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; d="scan'208";a="356566934"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2023 22:45:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="1063198828"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; d="scan'208";a="1063198828"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
 by fmsmga005.fm.intel.com with ESMTP; 10 Aug 2023 22:45:31 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1qUKxm-0007Xl-39
 for intel-wired-lan@lists.osuosl.org; Fri, 11 Aug 2023 05:45:30 +0000
Date: Fri, 11 Aug 2023 13:45:23 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202308111321.FFYVly5R-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691732741; x=1723268741;
 h=date:from:to:subject:message-id;
 bh=uTnrG7rq6qPC/A4IKYJJXI7udVz4ubZYqgsFC8m7q0c=;
 b=IUnLGwbmmxPfQri4XU4tAgJa6SL6kQqhgfqH24vW7Px57q8vA/jcyFt+
 tGXoWsrTmwvZbheTwNnNpdZpcQo+QEIpcSdRu8IZlNaezR7l0LCDdLYgU
 so44BOm/3FOglnnz/8alpJsjSBK/Opzf0RjGR8cV+kW+nGBXHTunJ3kxb
 1e2sMpbf1Hoh8L6Q2bhaV6AFL8kjPAIPY4Kv/lBJ4xm36GFanv6hAmV7Z
 xzJgdlGbpyOgCQpSnV+uwRuzBjKf/rR5NUw0vsCkSzrr25gV7UOrXtYTv
 zhizWFxxkisr8R3CbPyiBOcL76WT8A9m8sC5Ug660Oy9JnTmmXMoHxEnh
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=IUnLGwbm
Subject: [Intel-wired-lan] [tnguy-net-queue:40GbE] BUILD SUCCESS
 bfdaaff75b83723394c0036cab6574b0dfc16130
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 40GbE
branch HEAD: bfdaaff75b83723394c0036cab6574b0dfc16130  i40e: fix misleading debug logs

elapsed time: 722m

configs tested: 49
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
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
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
