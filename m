Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A55C982E1
	for <intel-wired-lan@archiver.kernel.org>; Sun, 20 Sep 2026 11:35:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17E0A80F7B;
	Sun, 20 Sep 2026 11:35:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1a9352tiLfnh; Sun, 20 Sep 2026 11:35:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EC47680F62
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789904126;
	b=FRJFTzkM6awbg6wpVLw2KHNgrX2xuyeMr9ZUW3fHbW4gyUbUL8rFFM88DtyDL8UkhA8D
	 PP1CKDNlR8fm3c2hTMBq7NACvT+7JnXIGWWAkTHRRES+5tSlgNQNmjvh3L9yd0bx2/fl0
	 +HyiVJLwL2XFh+uM1eg70Rxsenc3fALsXk5iPmt2ZU16UxaTl78vVXr4b86dVZcdmgm4C
	 o6HDiIHniHL9JlmeHgZaZfcWoNHVZMeqwRpH6ymKWChPbpltzm9wWXHYMk+pd67/mhm14
	 JY+KBTFyN8QVUL19RLNLwEydiSnSlO/Ccs6W8r4kwmXiF18rZzcBquhw1y5A7ncP9TQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789904126;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ofPxsbkPzj4q8QPUzXRzMazx+NgkPiHe0ZmuPVrzdYE=;
	b=R2TnQFgh7qR1yetk19lKFCCzES6sWCKtnyiHrTxRdmuZgdY+90OESBEC7VhmlCYXAfFj
	 kbIXXCzLB5IXNjO2srHmutVjA2Z9kSBqeK0SpJPoo7JdsBVzt++nkzgJhHxrVDL2mWuUP
	 19x9m4DhD2pB+06YG9HRwDZdm0t1eLBiiiOGFc89a7pcPKogNjT+8nc/pPq515FaPfP1x
	 WO05q0Ux/5KUPAiKXokVr6doB6OUE8cqGiRNnt9TTSrkvHqFTSKe5+XWSFJovJhC4zrSv
	 VMFZqeHaec5cXkCeb1Wbkw4vWBNg1AVAHHyHf4OZm4qQykMhhOxzpxm/qmbywffBJzA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789904126;
	bh=ofPxsbkPzj4q8QPUzXRzMazx+NgkPiHe0ZmuPVrzdYE=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=yYBc75yxPT8SH7mZLZni0subD6FcXiytddSt6QVu3EAg640iFduIbEZg18XR0AoqW
	 UCZq2R2dC292FHxdDzuvdddTuFIRn0JH+lhzXKCcYh0NgWN/4ZgVyXUMUdNE8zorwk
	 1MkSugAUCnD+BB2dVCxSkSkkv4NIXKRbZjrzkvrGVETbxk3c4BrYCoHYxvytVLKLKE
	 sM+JlvZiFvRSNenH2NbslYw1Ey2F8movMH9U+UJha1Jq3JR4cXaMmHO9V4Sq+rywv3
	 M7/whsvCr0zlJNYpKehl+szWkYm8oXmBaBgRKywpgpGMD4JzrGlKA52T/Ysj1CWeNU
	 0X2ULmwHT9pzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC47680F62;
	Sun, 20 Sep 2026 11:35:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D422F13D
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 11:35:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C5B3840098
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 11:35:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dotxuNxBzcaR for <intel-wired-lan@lists.osuosl.org>;
 Sun, 20 Sep 2026 11:35:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 686F04005A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789904123;
 b=m7RlbQxHoq+3ts2o7fCk73boLTCx3QM73YoFq4c8WuUXxdjQrNQR6J2wOlXp8ZMMqJLV
 bIZEzsbblujyiomS2S6jO/ron2jx9jel62ksuf79313oBSZUmCA+raaIcTdA8iQntWZQh
 1t855NyTqJFFSdcRn0kSXZm0VqT1N1TxtSbCZWqfDePDXR1FmRU21TdSJB5xYjNyI+qRX
 fWwTUgbYCjJlqTqCE/93K3PlgDdTmFUEyxFG2CB0qphBR3wCS3LiuihfGyrgCB1sEeb9f
 PJkE0TZrg/n+KPLdRw58azX9xUxDFqgm7i3UU1SjGR3buMDLzDudKYD9LEDIoHKWExQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789904123;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=ofPxsbkPzj4q8QPUzXRzMazx+NgkPiHe0ZmuPVrzdYE=;
 b=BQBrkJUZE7qjsfLScee6o3yfB4aCSKXaz9luSs1WyEqhKw4FJqCfG85zE2WxsOvK0uLM
 qKPxD2nScGMOHUPukcFeP69ZvapAEFb/eLtkYWVc7bjdZXtsld09D+kPUiJKY0vqIrVKo
 g4iQwgsfYxKIm09xWTqjz6ShYCB5q6i2NaNDy7SNvAftWK3yNdxVcIufvplQAJFWcCIp8
 GNLxKQ4MmK/8SvdMGtQ3xwDTYnrUKcJfrOsJTNF0cq1tzfO9Crvnpl/bQiO3wtZmtMG2Y
 eyejic+cyOo+svL63WII0eHrLN/ndVEJJxmXsTmGhbpuzBS9WUb3fcMrByb9nzcgD8g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KO87gQw+; 
 arc=none smtp.remote-ip=192.198.163.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KO87gQw+
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 686F04005A
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 11:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789904123; x=1821440123; h=date:from:to:subject:message-id;
 bh=pTxUkqyl5nWuX2HGLAOcM5tMxoJjv5uxg+qZiU8/3DQ=;
 b=KO87gQw+9siHwB8ya8E8pnfT9MwL+2Wh+1K7cMKWL7PknVHDl9UnQhk5
 y99B7Q+wP6qDLZm1VDTE+qnRojiyWmaN9NFuTB1NpRm+wD+dM8xMDaxxt
 XDDe+36funyncVdKbGdVFqmbE1rqPzIGx2QppjaxiCzAZkbycJ7SI9aoO
 Xn+Z96lLCA4PPvR8K7HrslvHI/6XbZ+91MbvsZ93iSaiZRHzI2rrgaNSC
 GGAf2R1IbSndXVzy4tYo4hIaMz9xAlm8+SyJBYFly1NZtAQE2z/1B5MI8
 QPJo+p0qSC0Wib6aOrvbgGo7iEz1Wzgt8QaHP/kpLdqVsVIFg2+lgi/pC A==;
X-CSE-ConnectionGUID: Qf70qmlpR2CkHeksTebsfw==
X-CSE-MsgGUID: CMgmX9YMTV+LPIDsH1+D8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="89332798"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; d="scan'208";a="89332798"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2026 04:35:22 -0700
X-CSE-ConnectionGUID: XMgNkriCSJeIoau3J9jEDg==
X-CSE-MsgGUID: drzPmipQTvuy0gA37yRy6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="3579936"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by fmviesa013.fm.intel.com with ESMTP; 20 Sep 2026 04:35:21 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x8FpG-00000000CLh-3qbd;
 Sun, 20 Sep 2026 11:35:18 +0000
Date: Sun, 20 Sep 2026 19:34:56 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:dev-queue] BUILD SUCCESS
 65bedeef369a2143fbd06697e2167da5a67139e0
Message-ID: <202609201953.VduPSYlg-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
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
Errors-To: intel-wired-lan-bounces@osuosl.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 65bedeef369a2143fbd06697e2167da5a67139e0  ixd: use interrupt for mailbox communication

elapsed time: 1230m

configs tested: 163
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r1300-20260920    gcc-10.5.0 sparse
alpha                randconfig-r1307-20260920    gcc-8.5.0  sparse
arc                               allmodconfig    gcc-16.1.0
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20260920    gcc-8.5.0
arc                   randconfig-1001-20260920    gcc-8.5.0
arc                  randconfig-r1304-20260920    gcc-8.5.0  sparse
arm                                allnoconfig    clang-17
arm                               allyesconfig    gcc-16.1.0
arm                                  defconfig    clang-24
arm                             mps2_defconfig    clang-24
arm                   randconfig-1000-20260920    gcc-10.5.0
arm                   randconfig-1001-20260920    gcc-12.5.0
arm                   randconfig-1002-20260920    clang-20
arm                   randconfig-1003-20260920    gcc-16.1.0
arm                         shmobile_defconfig    gcc-16.1.0
arm                          vf610m4_defconfig    gcc-16.1.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260920    gcc-15.2.0
arm64                 randconfig-1001-20260920    clang-24
arm64                 randconfig-1002-20260920    gcc-8.5.0
arm64                 randconfig-1003-20260920    clang-24
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260920    gcc-12.5.0
csky                  randconfig-1001-20260920    gcc-14.3.0
hexagon                           allmodconfig    clang-24
hexagon                            allnoconfig    clang-24
hexagon                              defconfig    clang-24
hexagon               randconfig-1000-20260920    clang-17
hexagon               randconfig-1001-20260920    clang-19
i386                              allmodconfig    gcc-14
i386                               allnoconfig    gcc-14
i386        buildonly-randconfig-1000-20260920    clang-22
i386        buildonly-randconfig-1001-20260920    clang-22
i386        buildonly-randconfig-1002-20260920    clang-22
i386        buildonly-randconfig-1003-20260920    gcc-14
i386        buildonly-randconfig-1004-20260920    clang-22
i386        buildonly-randconfig-1005-20260920    clang-22
i386                                 defconfig    clang-22
i386                  randconfig-1000-20260920    clang-22
i386                  randconfig-1001-20260920    gcc-14
i386                  randconfig-1002-20260920    gcc-14
i386                  randconfig-1003-20260920    clang-22
i386                  randconfig-1004-20260920    gcc-14
i386                  randconfig-1005-20260920    gcc-14
i386                  randconfig-1006-20260920    clang-22
loongarch                         allmodconfig    clang-19
loongarch                          allnoconfig    clang-20
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260920    gcc-16.1.0
loongarch             randconfig-1001-20260920    gcc-16.1.0
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    gcc-16.1.0
m68k                                 defconfig    gcc-16.1.0
m68k                        m5275evb_defconfig    gcc-16.1.0
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    gcc-16.1.0
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                       maltaaprp_defconfig    clang-17
mips                         omega2p_defconfig    clang-17
nios2                             allmodconfig    gcc-11.5.0
nios2                              allnoconfig    gcc-11.5.0
nios2                                defconfig    gcc-11.5.0
nios2                 randconfig-1000-20260920    gcc-8.5.0
nios2                 randconfig-1001-20260920    gcc-8.5.0
openrisc                          allmodconfig    gcc-16.1.0
openrisc                           allnoconfig    gcc-16.1.0
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r1309-20260920    gcc-16.1.0 sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    gcc-16.1.0
parisc                            allyesconfig    gcc-16.1.0
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260920    gcc-14.3.0
parisc                randconfig-1001-20260920    gcc-8.5.0
parisc64                             defconfig    gcc-16.1.0
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    gcc-16.1.0
powerpc                      mpc512x_defconfig    clang-24
powerpc               randconfig-1000-20260920    gcc-8.5.0
powerpc               randconfig-1001-20260920    clang-24
powerpc64             randconfig-1000-20260920    clang-24
powerpc64             randconfig-1001-20260920    clang-22
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    gcc-16.1.0
riscv                             allyesconfig    clang-24
riscv                                defconfig    clang-24
riscv                 randconfig-1000-20260920    gcc-13.4.0
riscv                 randconfig-1001-20260920    gcc-15.2.0
riscv                randconfig-r1308-20260920    clang-24   sparse
s390                              allmodconfig    clang-24
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    clang-18
s390                  randconfig-1000-20260920    gcc-8.5.0
s390                  randconfig-1001-20260920    clang-20
s390                 randconfig-r1306-20260920    gcc-8.5.0  sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    gcc-16.1.0
sh                                allyesconfig    gcc-16.1.0
sh                                   defconfig    gcc-16.1.0
sh                    randconfig-1000-20260920    gcc-16.1.0
sh                    randconfig-1001-20260920    gcc-10.5.0
sh                         sh7785lcr_defconfig    gcc-16.1.0
sparc                              allnoconfig    gcc-16.1.0
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260919    gcc-11.5.0
sparc                 randconfig-1000-20260920    gcc-12.5.0
sparc                 randconfig-1001-20260919    gcc-16.1.0
sparc                 randconfig-1001-20260920    gcc-14.3.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    clang-24
sparc64               randconfig-1000-20260920    gcc-13.4.0
sparc64               randconfig-1001-20260920    clang-24
sparc64              randconfig-r1302-20260920    clang-24   sparse
sparc64              randconfig-r1305-20260920    gcc-13.4.0 sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-17
um                                allyesconfig    gcc-14
um                                   defconfig    clang-24
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260920    clang-21
um                    randconfig-1001-20260920    clang-17
um                            x86_64_defconfig    clang-24
x86_64                             allnoconfig    clang-22
x86_64      buildonly-randconfig-1000-20260920    gcc-14
x86_64      buildonly-randconfig-1001-20260920    gcc-14
x86_64      buildonly-randconfig-1002-20260920    gcc-14
x86_64      buildonly-randconfig-1003-20260920    clang-22
x86_64      buildonly-randconfig-1004-20260920    clang-22
x86_64      buildonly-randconfig-1005-20260920    gcc-14
x86_64                               defconfig    gcc-14
x86_64                randconfig-1000-20260920    clang-22
x86_64                randconfig-1001-20260920    gcc-14
x86_64                randconfig-1002-20260920    clang-22
x86_64                randconfig-1003-20260920    gcc-14
x86_64                randconfig-1004-20260920    gcc-14
x86_64                randconfig-1005-20260920    clang-22
x86_64                randconfig-1012-20260920    clang-22
x86_64                randconfig-1013-20260920    gcc-14
x86_64                randconfig-1014-20260920    gcc-14
x86_64                randconfig-1015-20260920    clang-22
x86_64                randconfig-1016-20260920    clang-22
x86_64                randconfig-1017-20260920    clang-22
x86_64               randconfig-r1303-20260920    gcc-14     sparse
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    gcc-16.1.0
xtensa                            allyesconfig    gcc-16.1.0
xtensa                randconfig-1000-20260920    gcc-10.5.0
xtensa                randconfig-1001-20260920    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
