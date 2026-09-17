Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D466EC982D0
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Sep 2026 23:11:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 89E7180DC5;
	Thu, 17 Sep 2026 23:11:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iC7aOaCfxXwg; Thu, 17 Sep 2026 23:11:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5CA34810F8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789686666;
	b=O2KceBsDBgf47NY3H/6KDcrkKdUJNl5+cNqNgAlwbI0z4O11YufbYWnQfdvWL7Tnap5F
	 pTyvqFxn2yBEoLECZQyY2Xm730Bqr1sAJV7EvomxaT36fRjYoJc+T57SdJ0xOCiIsS/Xv
	 I7nPCtZE79n28kC/Kz54dio6QTZEEo2WhDGkqqhYoJxr3MGequTxIWwW2tYOrLKRQX6tZ
	 luljXuzzN5dZEktlngwRwOYuqS75cmvzLTrerOJyhjc3WQzQJktBEgL4AEatOnOvWy9jB
	 ZL8VZhhGIog16FYs8zw00Bc+idlEgbcdKa49JxpUhzUDWmJfXG9bLW0D9zKNxbhyTYg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789686666;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=O2DZCCO7O+7HBXJLB+fVMrmRK9OMZ17FJhBRK1ZZtK8=;
	b=gIQ/QKTYOF8eal2/9deJYPHG26FabUokSBZNE6+RDdZCbQ6eIIj7kq7KJVIyywW4WIAG
	 2Lw/93IXRUymv+adzOtd4IPYTSBGoE0cC2vsEkbug8eyPDNBs0XYfedQSaoeP93IpDSSa
	 FazEP4H0hfoAPIFkGNDRUbzNLhTQTN82YZHtLq/jT51tTov43QO4BeL6Tr2YwJV1AX1NU
	 dDFUxW3/eD9Ai8FcrwTffLtevOEnyhPlZpgaJ6taXxu9Dwc97hpnyAWjcye8mJq7s0c5y
	 N8M8HID+zNyXbbGLJD012h3lL2mTqgryspB6KQ4zK3wJwd0zhC9Anhy1zUXQQi3uPuw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789686666;
	bh=O2DZCCO7O+7HBXJLB+fVMrmRK9OMZ17FJhBRK1ZZtK8=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZpEYCaKUj1nkq05Ofqjo8zQpf70Fd/d7zwalceT++4+zqCWdsK5do6+anSegjbFn8
	 W1y+ddyo/GmMMBFObYv46Ebwno4PP+XefUxlmuyKdBH7FoCbCuOT/iIlJJ+hNlQV9k
	 mimam/zCGgeu3VAIV8dkvYKnaO4PLlSizFQAaXIewDw3/VISlwL0JOWzRc2lKfl6oZ
	 In2B6l4/G3s0J0/hTR1ISUygaZnz+g4ijyXC/5T+/Q5BzxBHqMPYv0ZYUqoCi9UcDT
	 gmpgXLTtWArIPfHq58qt0DnVtqHBi6y+FHGShfLI4J74KK+hg0MuAFkHQFTjNdCHlv
	 JDKQWTP9RRf6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5CA34810F8;
	Thu, 17 Sep 2026 23:11:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 90DFD3B6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 23:11:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 76C116085C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 23:11:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SJ9sVrycS3sW for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Sep 2026 23:11:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 557F260659
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=192.198.163.5
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789686663;
 b=WqzxiDL3/I02UB+CG4R8uA/4lLe2MTWnS8zUgy4A9PTKESzImoJ6nhsU0eOG6FdVlazO
 OPC7Nr11+hfJAnBJW1dIpQjX7m7S75UgD/9Ymh5NSRahX+7ypRmOK3P2e5YqzmbU6rpAP
 9eQpHMbczEysgWnAT682NZkl1thmlzCyrrct9AaHQh8AlrAzcLMDzmEqRm2he0UQS1KQ3
 Hb0bwcX5UL1/9Sdz5sEx8PYHWmDG3Etn8tg8GhcYItjsZg1jutzVmi+f6bIkPz1ymZ5bp
 iR8i7xIAq8Gawn6Ts38SnsYQEvGulTtf03gDhjeBJDJxyi73jqj3nEOwCdN3Cqhu0BQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789686663;
 h=X-Greylist:Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-IronPort-AV:X-IronPort-AV:Received:
 X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:
 Received:Date:From:To:Subject:Message-ID:User-Agent;
 bh=O2DZCCO7O+7HBXJLB+fVMrmRK9OMZ17FJhBRK1ZZtK8=;
 b=nIgTqGckRAYfGwpJdrnTAXo4VQOI4+k2ZKajvd99A2OWfCWbHwVBO/EaWRCM2nzlG++U
 iyn4ch2SOmt0zqKz5svfT8phJlIsAttjC6Q6R5spgWXxwnZI+z/WtRW0TXlhJftUzOAYZ
 rVwgph34rQ1IeOuGkfrOWZM9F9fds8ULIC7dlVg19kDsNTg48GQjSgfdfHyfe69R/u8yx
 nl3T2hf/sIpV3iToGf0CKBJ0wX3wP/auGnqJt3v3ax4FOWmgJ6s646J9fk77A6Mqb+pxA
 Z+Hbzy89bZJm8FQ8Q6A1Q0khsdphSyQXogE5CFzAvnJUr/SF1+AEt5tw9vE9mcs4Rdg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ANa5enJx; 
 arc=none smtp.remote-ip=192.198.163.5
X-Greylist: delayed 64 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 17 Sep 2026 23:11:03 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ANa5enJx
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.5;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 557F260659
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 23:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789686664; x=1821222664; h=date:from:to:subject:message-id;
 bh=fhfaatl0hWFApoPIDjHNbCg9NVko3KYpudvL8bUp1LY=;
 b=ANa5enJxtv9Sa8BUvkeh170ZMfrS8acrHGp6C/tiAPw52rIlSt3ZQal8
 v4a4PCQEpk5Y83W2fFfWhSLqthTPubQ1sJ4zV1kp0ozju2UiRJfc5z3rQ
 5MI6k+JxYciztuiS3na4L8IWMuI5OS1l4twoE0m2LPL91p6nT0fIdOO1Y
 UDEaMDPe0wANp1oYC2DPYbtyNJuFXDLwqwL/bGjIxu8n+72kMzTrQg3hQ
 AWzXsdofW9gqUkI91Oel4OHXP7czu+OZ5k33obRC07zLW87dwQOQWsQOf
 dOmhdDsFYfT5+4ZC6g0Zrvo7m1gPpayHr8yVFeesEP+9R8pPBClDYvOVR w==;
X-CSE-ConnectionGUID: wBt0KZ/4S/it/22NeDq7Mw==
X-CSE-MsgGUID: pv4O7d8ATl+PUBrLP6jojg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="660886"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="660886"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 16:09:59 -0700
X-CSE-ConnectionGUID: DfzVySJDQzisPsTaezbvZQ==
X-CSE-MsgGUID: dIGHqnV3SN2VLPwssP+cQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="297550134"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by fmviesa002.fm.intel.com with ESMTP; 17 Sep 2026 16:09:57 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x7LEp-000000008gB-1y9H;
 Thu, 17 Sep 2026 23:09:55 +0000
Date: Fri, 18 Sep 2026 07:09:31 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:10GbE] BUILD SUCCESS
 b8e9e7d82e7eefd5d2d528469d94ec20e96b38c3
Message-ID: <202609180720.WAp8xdVb-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 10GbE
branch HEAD: b8e9e7d82e7eefd5d2d528469d94ec20e96b38c3  selftests: drv-net: devmem: set reuseaddr on the sender's source port

elapsed time: m

configs tested: 283
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             alldefconfig    gcc-16.1.0
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                 randconfig-r063-20260915    gcc-13.4.0
alpha                randconfig-r1304-20260917    clang-21   sparse
alpha                randconfig-r1306-20260917    clang-24   sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20260917    gcc-15.2.0
arc                   randconfig-1000-20260918    gcc-16.1.0
arc                   randconfig-1001-20260917    gcc-15.2.0
arc                   randconfig-1001-20260918    gcc-16.1.0
arc                  randconfig-r1302-20260917    gcc-8.5.0  sparse
arc                  randconfig-r1303-20260917    gcc-8.5.0  sparse
arc                  randconfig-r1305-20260917    gcc-8.5.0  sparse
arc                            tb10x_defconfig    gcc-16.1.0
arc                         vdk_hs38_defconfig    clang-24
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                        aspeed_g4_defconfig    gcc-16.1.0
arm                                  defconfig    gcc-16.1.0
arm                        imx_v6_v7_defconfig    gcc-16.1.0
arm                   randconfig-1000-20260917    gcc-15.2.0
arm                   randconfig-1000-20260918    gcc-16.1.0
arm                   randconfig-1001-20260917    gcc-15.2.0
arm                   randconfig-1001-20260918    gcc-16.1.0
arm                   randconfig-1002-20260917    gcc-15.2.0
arm                   randconfig-1002-20260918    gcc-16.1.0
arm                   randconfig-1003-20260917    gcc-15.2.0
arm                   randconfig-1003-20260918    gcc-16.1.0
arm                   randconfig-r071-20260916    clang-19
arm                   randconfig-r072-20260915    clang-17
arm                  randconfig-r1308-20260917    gcc-13.4.0 sparse
arm                          s5pv210_defconfig    clang-24
arm64                             alldefconfig    gcc-16.1.0
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260917    gcc-11.5.0
arm64                 randconfig-1001-20260917    gcc-11.5.0
arm64                 randconfig-1002-20260917    gcc-11.5.0
arm64                 randconfig-1003-20260917    gcc-11.5.0
arm64                 randconfig-r053-20260916    clang-24
arm64                randconfig-r1306-20260917    clang-18   sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260917    gcc-11.5.0
csky                  randconfig-1001-20260917    gcc-11.5.0
csky                  randconfig-r062-20260915    gcc-13.4.0
csky                 randconfig-r1308-20260917    clang-24   sparse
csky                 randconfig-r1309-20260917    clang-18   sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260917    clang-24
hexagon               randconfig-1001-20260917    clang-24
hexagon               randconfig-r052-20260916    clang-24
hexagon               randconfig-r054-20260915    clang-17
hexagon              randconfig-r1300-20260917    clang-21   sparse
hexagon              randconfig-r1301-20260917    gcc-8.5.0  sparse
hexagon              randconfig-r1304-20260917    gcc-8.5.0  sparse
hexagon              randconfig-r1307-20260917    clang-18   sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20260917    gcc-13
i386        buildonly-randconfig-1001-20260917    gcc-13
i386        buildonly-randconfig-1002-20260917    gcc-13
i386        buildonly-randconfig-1003-20260917    gcc-13
i386        buildonly-randconfig-1004-20260917    gcc-13
i386        buildonly-randconfig-1005-20260917    gcc-13
i386                                 defconfig    gcc-16.1.0
i386                   randconfig-051-20260915    clang-22
i386                   randconfig-051-20260916    gcc-14
i386                   randconfig-052-20260915    clang-22
i386                   randconfig-052-20260916    gcc-14
i386                   randconfig-053-20260915    clang-22
i386                   randconfig-053-20260916    gcc-14
i386                   randconfig-054-20260915    clang-22
i386                   randconfig-054-20260916    gcc-14
i386                  randconfig-1000-20260917    clang-22
i386                  randconfig-1001-20260917    clang-22
i386                  randconfig-1002-20260917    clang-22
i386                  randconfig-1003-20260917    clang-22
i386                  randconfig-1004-20260917    clang-22
i386                  randconfig-1005-20260917    clang-22
i386                  randconfig-1006-20260917    clang-22
i386                  randconfig-1007-20260917    clang-22
i386                  randconfig-1008-20260917    clang-22
i386                  randconfig-1009-20260917    clang-22
i386                  randconfig-1010-20260917    clang-22
i386                  randconfig-1011-20260917    clang-22
i386                  randconfig-1012-20260917    clang-22
i386                  randconfig-1013-20260917    clang-22
i386                  randconfig-1300-20260917    gcc-14     sparse
i386                  randconfig-1301-20260917    gcc-14     sparse
i386                  randconfig-1302-20260917    gcc-14     sparse
i386                   randconfig-141-20260915    clang-22
i386                   randconfig-141-20260916    gcc-14
i386                  randconfig-r051-20260915    clang-17
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260917    clang-24
loongarch             randconfig-1001-20260917    clang-24
loongarch            randconfig-r1307-20260917    clang-24   sparse
loongarch            randconfig-r1309-20260917    gcc-13.4.0 sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                          amcore_defconfig    gcc-16.1.0
m68k                          apollo_defconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                         m5272c3_defconfig    gcc-16.1.0
m68k                         mvme147_defconfig    gcc-16.1.0
m68k                  randconfig-r064-20260916    gcc-8.5.0
m68k                  randconfig-r072-20260916    gcc-14.3.0
m68k                           sun3x_defconfig    gcc-16.1.0
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze            randconfig-r054-20260916    clang-24
microblaze            randconfig-r073-20260915    gcc-8.5.0
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                   cavium_octeon_defconfig    gcc-16.1.0
mips                          cobalt_defconfig    gcc-16.1.0
mips                            gcw0_defconfig    clang-24
mips                            ip27_defconfig    gcc-16.1.0
mips                       malta_kvm_defconfig    gcc-16.1.0
mips                         omega2p_defconfig    clang-24
mips                 randconfig-r1309-20260917    clang-24   sparse
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20260917    clang-24
nios2                 randconfig-1001-20260917    clang-24
nios2                 randconfig-r053-20260915    clang-17
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r1300-20260917    gcc-8.5.0  sparse
openrisc             randconfig-r1308-20260917    clang-18   sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260917    gcc-11.5.0
parisc                randconfig-1000-20260918    gcc-8.5.0
parisc                randconfig-1001-20260917    gcc-11.5.0
parisc                randconfig-1001-20260918    gcc-8.5.0
parisc                randconfig-r052-20260915    clang-17
parisc                randconfig-r062-20260916    gcc-8.5.0
parisc               randconfig-r1302-20260917    clang-21   sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                        ebony_defconfig    clang-24
powerpc                       ep88xc_defconfig    gcc-16.1.0
powerpc                           g5_defconfig    clang-24
powerpc                      kmeter1_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20260917    gcc-11.5.0
powerpc               randconfig-1000-20260918    gcc-8.5.0
powerpc               randconfig-1001-20260917    gcc-11.5.0
powerpc               randconfig-1001-20260918    gcc-8.5.0
powerpc                   storcenter_defconfig    gcc-16.1.0
powerpc                         warp_defconfig    gcc-16.1.0
powerpc64             randconfig-1000-20260917    gcc-11.5.0
powerpc64             randconfig-1000-20260918    gcc-8.5.0
powerpc64             randconfig-1001-20260917    gcc-11.5.0
powerpc64             randconfig-1001-20260918    gcc-8.5.0
powerpc64             randconfig-r073-20260916    gcc-10.5.0
powerpc64            randconfig-r1305-20260917    clang-21   sparse
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv              nommu_k210_sdcard_defconfig    clang-24
riscv                 randconfig-1000-20260917    clang-17
riscv                 randconfig-1001-20260917    clang-17
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20260917    clang-17
s390                  randconfig-1001-20260917    clang-17
s390                  randconfig-r063-20260916    gcc-8.5.0
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                          ecovec24_defconfig    gcc-16.1.0
sh                    randconfig-1000-20260917    clang-17
sh                    randconfig-1001-20260917    clang-17
sh                    randconfig-r061-20260915    gcc-13.4.0
sh                            se7750_defconfig    clang-24
sh                             shmin_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260917    clang-17
sparc                 randconfig-1001-20260917    clang-17
sparc                 randconfig-r051-20260916    clang-24
sparc                randconfig-r1306-20260917    gcc-13.4.0 sparse
sparc                randconfig-r1307-20260917    gcc-13.4.0 sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260917    clang-17
sparc64               randconfig-1001-20260917    clang-17
sparc64              randconfig-r1301-20260917    clang-21   sparse
sparc64              randconfig-r1303-20260917    clang-21   sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260917    clang-17
um                    randconfig-1001-20260917    clang-17
um                    randconfig-r061-20260916    gcc-8.5.0
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20260917    gcc-14
x86_64      buildonly-randconfig-1001-20260917    gcc-14
x86_64      buildonly-randconfig-1002-20260917    gcc-14
x86_64      buildonly-randconfig-1003-20260917    gcc-14
x86_64      buildonly-randconfig-1004-20260917    gcc-14
x86_64      buildonly-randconfig-1005-20260917    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20260917    clang-22
x86_64                randconfig-1001-20260917    clang-22
x86_64                randconfig-1002-20260917    clang-22
x86_64                randconfig-1003-20260917    clang-22
x86_64                randconfig-1004-20260917    clang-22
x86_64                randconfig-1005-20260917    clang-22
x86_64                randconfig-1006-20260917    clang-22
x86_64                randconfig-1007-20260917    clang-22
x86_64                randconfig-1008-20260917    clang-22
x86_64                randconfig-1009-20260917    clang-22
x86_64                 randconfig-101-20260915    clang-22
x86_64                 randconfig-101-20260916    clang-22
x86_64                randconfig-1010-20260917    clang-22
x86_64                randconfig-1011-20260917    clang-22
x86_64                randconfig-1012-20260917    clang-22
x86_64                randconfig-1013-20260917    clang-22
x86_64                randconfig-1014-20260917    clang-22
x86_64                randconfig-1015-20260917    clang-22
x86_64                randconfig-1016-20260917    clang-22
x86_64                randconfig-1017-20260917    clang-22
x86_64                 randconfig-102-20260915    clang-22
x86_64                 randconfig-102-20260916    clang-22
x86_64                 randconfig-103-20260915    clang-22
x86_64                 randconfig-103-20260916    clang-22
x86_64                 randconfig-104-20260915    clang-22
x86_64                 randconfig-104-20260916    clang-22
x86_64                randconfig-1300-20260917    gcc-14     sparse
x86_64                randconfig-1301-20260917    gcc-14     sparse
x86_64                randconfig-1302-20260917    gcc-14     sparse
x86_64                 randconfig-161-20260915    clang-22
x86_64                 randconfig-161-20260916    gcc-14
x86_64                randconfig-r064-20260915    gcc-13.4.0
x86_64                randconfig-r071-20260915    clang-22
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    clang-22
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                            alldefconfig    gcc-16.1.0
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                   cadence_csp_defconfig    gcc-16.1.0
xtensa                           iss_defconfig    gcc-16.1.0
xtensa                randconfig-1000-20260917    clang-17
xtensa                randconfig-1001-20260917    clang-17

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
