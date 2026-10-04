Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0070BCA5FCE
	for <intel-wired-lan@archiver.kernel.org>; Sun,  4 Oct 2026 06:22:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A857C80E1A;
	Sun,  4 Oct 2026 06:22:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mFPb0qGIuoQM; Sun,  4 Oct 2026 06:22:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8FBEE80E27
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791094978;
	b=BrazLx1xDVgJimmGqQM7Umg0MtU4OK2rTQVn7triGXRblHW0TAGD1HGKCHReB+6p4phh
	 l6edsx0YKjB+7LcPMLrW/HygNkeTTno2C84nFvYEna+dz8qpTqNONWUDn6vnztnlX4F1S
	 2C+o5+NlNuIzWKDhXciRESBnOp+doMyCpCaIlE+YTf+Dve8Wi0FE7Gjlwy/mYPmK9dDvk
	 yNqYxfO/UB5zhC0ahdnyrW6IJ/aSkSnpab+HgYvnxr9KGzKzAXYM389+qxr7v24KXNFrf
	 eZL4th5Wu5symLo8vZfzzjqiLh2M9KRAuJHWikRFjiYiOudzIaBDIN5V7cD814ytFQA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791094978;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=6/8BDuudMRNoTUSsYWTq61cdlleqPKS32EIL4zy3TFU=;
	b=YwsNKyS/gNRjZ1H72fI0uG5OITKzYqM4YuZd3Im/37Gtn3YfXp2wpVyj3PdPtDwYVv5/
	 mQAnPcjkHabSGy2VMfxiKm3MS0MM+V3Nygh9lArdU3YCDoGPF56NVSaBNhqAVdAj9916M
	 DKX4If77jFxMspUjHPGrWtyY1+U2XpTXwpXbIKJybg95bNYugw3T5JnOd0Ee+JEKHAR6T
	 CyKatuURykP+wWOHaNmDkCyCBt363cs/1Iibdiq3ECexFEbMI8GZsJS5CbfdDg2m0SGjk
	 qjD9cHfMJeM2RHDc7xxpO3zmH96mdWtahvtbDCDez8cyM+2Buo3qYi10ycj711cTq1g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CdcMtIl1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791094978;
	bh=6/8BDuudMRNoTUSsYWTq61cdlleqPKS32EIL4zy3TFU=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zCQhDwXFwFTpTgmlm4Zv9osiyjPCxm6I9kazcaHHEHzUdKVpTeiecdB+3oefaF3S+
	 Nr52gK8DFLo/oHoqzjgOggaYi6vgCUN+HYjNRgnK79PIRu+ra+p0XG2hw6MOoAUSVh
	 +lFk29a1uKDj0iUjJ/06j6zHfVPFYUb7vmgokqn5KT+Rmis3Eb5V+n8shR7PxU8s5y
	 Q3cGc6BQlerDC+50jMeaOPQpdlHqLkXU/obn8PYMprSxnYVkmdLwPsZTG9ITkSBp1i
	 lEuLY+Pqu9db1wkkhv/4uMCBAtaBJ+mY/Wx2E7sddO/8e7RatHW6HaJHFecCvwGvz8
	 Cfai9tHaek/Ng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8FBEE80E27;
	Sun,  4 Oct 2026 06:22:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CDB791A6
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 06:22:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BF9FD80E27
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 06:22:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4D11vHMRHQ4J for <intel-wired-lan@lists.osuosl.org>;
 Sun,  4 Oct 2026 06:22:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 518C980E1A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791094976;
 b=GgMSwwA6mwsRBrOwJWHmJH5szConoQ7LJ4zz8truqc5fxldBhUJTnNAVmEsaFfW3wqTM
 pNVAYGU0k7GxjGtGvXKOYRq0u0Fpnwf9c7i151AabteCx1u9OpWRGGj9M5Qv+iAi2Jk9P
 N6mlzTFtqagjSTiOs6un7ZDrLkxD3zE9Vu25vDUAUIRMYvqWW9pyJpF6Z6ngkTrbYx7QT
 oCdpND6n3heoQq6JPJG8zhL1zFRp+G0etdrZN78AVX6fTBzXWYl56rGqHpW2uLF8vCHOk
 Rv3YcmmSWqSPGjT8q/hZgPFrYid/GT/B7K33wthSB1M25ko6C08oODoS4XnQNOQIuuA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791094976;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=6/8BDuudMRNoTUSsYWTq61cdlleqPKS32EIL4zy3TFU=;
 b=HjyIehqWUGdugWr9urzw2XZYyGwjQHs3ngo3l5Ljnc5FOdpwQ+TdtwS8Bpwc04XpbRFY
 OCdFvKWRz+5BiAwf8pdI5Ei/6M17EW6BEMKTGejNdmGIPu8Axknxr8UiFPnIs5D7jXq0Z
 tZ9cUASiI6A3bDzHbv5hsEmmc0GxyYKptwXg+YfsosGltJzrrsn9IVp8FeIa0wTfz2UuE
 RNKfULkpp4NIvHPUFc4YGLoCj2/+AdUZvcVwHT6FszQBwnDUTgd0xJlwQ209t2pCfhrYx
 TcJP4Q8mZmOIPElP7A1/7Wct3sHR+Kyest3AqOhqjhZcUPeISWANYtnVtdrYDTrdYbA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CdcMtIl1; 
 arc=none smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CdcMtIl1
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 518C980E1A
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 06:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791094976; x=1822630976; h=date:from:to:subject:message-id;
 bh=JTxtmmFtuNKDuTtcAfqZUyDTeLrOtNU8ER1grZuGLDU=;
 b=CdcMtIl18aNtQoecBzMxNQ/OQIy3/+C/CXloITjIHu8bHJi8FrcQsnG0
 2cVX8VxGRf116Ww3k+sOJzmCVYpvHmjRa8fzc2xZxiZTVei9TcCLwgobs
 ZfctMZ4jhpaLAZuEQaT5v04hDft8jIhlB/A6xiH1uHn2D1Wf7zK+v7Pxv
 FVdm4Qk0wyQvwZ2YhTQ/U8wkyawTLmOtVdCBmf6BFCKWMfFulQMWG5fgY
 H+Ue82yOklIrawMuiNKdbGerDNlqPOBYMjTTyJchJ2Tk1bt2TbSdJrMvq
 Nqe2D0aWy2B/qukp90t3iBgA8uaH/+PjiXBdJWL1il+Nk5ejC5bt5/Qrt g==;
X-CSE-ConnectionGUID: lPWFjh3/S/G0C0oeNEN9nw==
X-CSE-MsgGUID: aMmoQ6PeSji0wd7te9/Hqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11924"; a="117320765"
X-IronPort-AV: E=Sophos;i="6.27,139,1787036400"; d="scan'208";a="117320765"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2026 23:22:55 -0700
X-CSE-ConnectionGUID: YGdCcYLgR9uRAaOPWMyyZw==
X-CSE-MsgGUID: o2edxgR4SA2bIEmOdb8lNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,139,1787036400"; d="scan'208";a="274354360"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by orviesa006.jf.intel.com with ESMTP; 03 Oct 2026 23:22:54 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xDFcZ-00000000UXp-2zcK;
 Sun, 04 Oct 2026 06:22:51 +0000
Date: Sun, 04 Oct 2026 14:22:10 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:dev-queue] BUILD SUCCESS
 1f36fe17921d233ec46f13d4127f7fa4af6f1162
Message-ID: <202610041407.zh7QAFo8-lkp@intel.com>
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
branch HEAD: 1f36fe17921d233ec46f13d4127f7fa4af6f1162  igc: Group frame size macros in igc_tsn.h

elapsed time: 1485m

configs tested: 255
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2305-20261002    gcc-15.2.0 sparse
alpha                randconfig-r2305-20261002    gcc-16.1.0 sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                  nsimosci_hs_smp_defconfig    gcc-16.1.0
arc                   randconfig-1000-20261004    clang-22
arc                   randconfig-1001-20261004    clang-22
arc                  randconfig-r2304-20261002    gcc-10.5.0 sparse
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                             qcom_defconfig    gcc-16.1.0
arm                   randconfig-1000-20261004    clang-22
arm                   randconfig-1001-20261004    clang-22
arm                   randconfig-1002-20261004    clang-22
arm                   randconfig-1003-20261004    clang-22
arm                  randconfig-r2106-20261002    clang-17   cocci
arm                  randconfig-r2200-20261002    gcc-8.5.0  smatch
arm                  randconfig-r2202-20261002    clang-24   smatch
arm                          s3c6400_defconfig    gcc-16.1.0
arm                     vt8500_v6_v7_defconfig    gcc-16.1.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261004    gcc-16.1.0
arm64                 randconfig-1001-20261004    gcc-16.1.0
arm64                 randconfig-1002-20261004    gcc-16.1.0
arm64                 randconfig-1003-20261004    gcc-16.1.0
arm64                randconfig-r2104-20261002    clang-17   cocci
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261004    gcc-16.1.0
csky                  randconfig-1001-20261004    gcc-16.1.0
csky                 randconfig-r2307-20261002    gcc-14.3.0 sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261004    gcc-16.1.0
hexagon               randconfig-1001-20261004    gcc-16.1.0
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261004    clang-22
i386        buildonly-randconfig-1001-20261004    clang-22
i386        buildonly-randconfig-1002-20261004    clang-22
i386        buildonly-randconfig-1003-20261004    clang-22
i386        buildonly-randconfig-1004-20261004    clang-22
i386        buildonly-randconfig-1005-20261004    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261004    gcc-14
i386                  randconfig-1001-20261004    gcc-14
i386                  randconfig-1002-20261004    gcc-14
i386                  randconfig-1003-20261004    gcc-14
i386                  randconfig-1004-20261004    gcc-14
i386                  randconfig-1005-20261004    gcc-14
i386                  randconfig-1006-20261004    gcc-14
i386                  randconfig-1007-20261004    clang-22
i386                  randconfig-1008-20261004    clang-22
i386                  randconfig-1009-20261004    clang-22
i386                  randconfig-1010-20261004    clang-22
i386                  randconfig-1011-20261004    clang-22
i386                  randconfig-1012-20261004    clang-22
i386                  randconfig-1013-20261004    clang-22
i386                  randconfig-2100-20261002    gcc-14     cocci
i386                  randconfig-2101-20261002    gcc-14     cocci
i386                  randconfig-2102-20261002    gcc-14     cocci
i386                  randconfig-2103-20261002    gcc-14     cocci
i386                  randconfig-2200-20261002    gcc-14     smatch
i386                  randconfig-2300-20261002    clang-22   sparse
i386                  randconfig-2300-20261002    gcc-12     sparse
i386                  randconfig-2301-20261002    gcc-12     sparse
i386                  randconfig-2301-20261002    gcc-14     sparse
i386                  randconfig-2302-20261002    gcc-12     sparse
i386                  randconfig-2302-20261002    gcc-14     sparse
i386                 randconfig-r2308-20261002    gcc-12.5.0 sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261004    gcc-16.1.0
loongarch             randconfig-1001-20261004    gcc-16.1.0
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                          apollo_defconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                 randconfig-r2302-20261002    gcc-16.1.0 sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2102-20261002    clang-22   cocci
microblaze           randconfig-r2303-20261002    gcc-16.1.0 sparse
microblaze           randconfig-r2306-20261002    gcc-12.5.0 sparse
microblaze           randconfig-r2306-20261002    gcc-8.5.0  sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                           eyeq6_defconfig    gcc-16.1.0
mips                            ip32_defconfig    gcc-16.1.0
mips                 malta_qemu_32r6_defconfig    gcc-16.1.0
mips                 randconfig-r2105-20261002    clang-17   cocci
mips                 randconfig-r2201-20261002    gcc-15.2.0 smatch
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261004    gcc-16.1.0
nios2                 randconfig-1001-20261004    gcc-16.1.0
nios2                randconfig-r2302-20261002    gcc-11.5.0 sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                 generic-32bit_defconfig    gcc-16.1.0
parisc                randconfig-1000-20261004    gcc-12.5.0
parisc                randconfig-1001-20261004    gcc-12.5.0
parisc               randconfig-r2304-20261002    gcc-16.1.0 sparse
parisc64                          alldefconfig    gcc-16.1.0
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                      kmeter1_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20261004    gcc-12.5.0
powerpc               randconfig-1001-20261004    gcc-12.5.0
powerpc              randconfig-r2301-20261002    gcc-16.1.0 sparse
powerpc              randconfig-r2309-20261002    gcc-16.1.0 sparse
powerpc64             randconfig-1000-20261004    gcc-12.5.0
powerpc64             randconfig-1001-20261004    gcc-12.5.0
powerpc64            randconfig-r2100-20261002    clang-22   cocci
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261004    gcc-11.5.0
riscv                 randconfig-1001-20261004    gcc-11.5.0
riscv                 randconfig-2000-20261002    gcc-9.5.0
riscv                 randconfig-2001-20261002    gcc-9.5.0
riscv                randconfig-r2103-20261002    clang-22   cocci
riscv                randconfig-r2300-20261002    gcc-16.1.0 sparse
riscv                randconfig-r2303-20261002    clang-24   sparse
riscv                randconfig-r2309-20261002    gcc-12.5.0 sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261004    gcc-11.5.0
s390                  randconfig-1001-20261004    gcc-11.5.0
s390                  randconfig-2000-20261002    gcc-9.5.0
s390                  randconfig-2001-20261002    gcc-9.5.0
s390                 randconfig-r2101-20261002    clang-22   cocci
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20261004    gcc-11.5.0
sh                    randconfig-1001-20261004    gcc-11.5.0
sh                    randconfig-2000-20261002    gcc-9.5.0
sh                    randconfig-2001-20261002    gcc-9.5.0
sh                   randconfig-r2107-20261002    clang-17   cocci
sh                   randconfig-r2202-20261002    gcc-10.5.0 smatch
sh                   randconfig-r2307-20261002    gcc-12.5.0 sparse
sh                            se7724_defconfig    gcc-16.1.0
sh                      sh7710voipgw_defconfig    gcc-16.1.0
sh                         sh7785lcr_defconfig    gcc-16.1.0
sparc                             alldefconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261004    gcc-14
sparc                 randconfig-1001-20261004    gcc-14
sparc                 randconfig-2000-20261002    clang-24
sparc                 randconfig-2001-20261002    clang-24
sparc                randconfig-r2201-20261002    gcc-8.5.0  smatch
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261004    gcc-14
sparc64               randconfig-1001-20261004    gcc-14
sparc64               randconfig-2000-20261002    clang-24
sparc64               randconfig-2001-20261002    clang-24
sparc64              randconfig-r2300-20261002    gcc-12.5.0 sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261004    gcc-14
um                    randconfig-1001-20261004    gcc-14
um                    randconfig-2000-20261002    clang-24
um                    randconfig-2001-20261002    clang-24
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261004    gcc-14
x86_64      buildonly-randconfig-1001-20261004    gcc-14
x86_64      buildonly-randconfig-1002-20261004    gcc-14
x86_64      buildonly-randconfig-1003-20261004    gcc-14
x86_64      buildonly-randconfig-1004-20261004    gcc-14
x86_64      buildonly-randconfig-1005-20261004    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261004    gcc-14
x86_64                randconfig-1001-20261004    gcc-14
x86_64                randconfig-1002-20261004    gcc-14
x86_64                randconfig-1003-20261004    gcc-14
x86_64                randconfig-1004-20261004    gcc-14
x86_64                randconfig-1005-20261004    gcc-14
x86_64                randconfig-1006-20261004    clang-22
x86_64                randconfig-1007-20261004    clang-22
x86_64                randconfig-1008-20261004    clang-22
x86_64                randconfig-1009-20261004    clang-22
x86_64                randconfig-1010-20261004    clang-22
x86_64                randconfig-1011-20261004    clang-22
x86_64                randconfig-1012-20261004    gcc-13
x86_64                randconfig-1013-20261004    gcc-13
x86_64                randconfig-1014-20261004    gcc-13
x86_64                randconfig-1015-20261004    gcc-13
x86_64                randconfig-1016-20261004    gcc-13
x86_64                randconfig-1017-20261004    gcc-13
x86_64                randconfig-2100-20261002    gcc-14     cocci
x86_64                randconfig-2101-20261002    gcc-14     cocci
x86_64                randconfig-2102-20261002    gcc-14     cocci
x86_64                randconfig-2103-20261002    gcc-14     cocci
x86_64                randconfig-2200-20261002    clang-22   smatch
x86_64                randconfig-2300-20261002    gcc-12     sparse
x86_64                randconfig-2300-20261002    gcc-14     sparse
x86_64                randconfig-2301-20261002    gcc-12     sparse
x86_64                randconfig-2301-20261002    gcc-14     sparse
x86_64                randconfig-2302-20261002    gcc-12     sparse
x86_64               randconfig-r2301-20261002    gcc-16.1.0 sparse
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
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261004    gcc-14
xtensa                randconfig-1001-20261004    gcc-14
xtensa                randconfig-2000-20261002    clang-24
xtensa                randconfig-2001-20261002    clang-24
xtensa               randconfig-r2308-20261002    gcc-8.5.0  sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
