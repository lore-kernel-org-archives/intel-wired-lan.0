Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D874CA5FCB
	for <intel-wired-lan@archiver.kernel.org>; Wed, 30 Sep 2026 15:08:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79F4181086;
	Wed, 30 Sep 2026 15:08:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KX_EEYfKmRLu; Wed, 30 Sep 2026 15:08:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F315381045
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790780936;
	b=FjGT7eIDtAFCDhIpzfT9Gw+u28MF033rQtcZZNwGWBDvt3DIDbpIyQV5iDGwVp++ha08
	 1UF8k1m7GbL/DPP8W9ZvVyupcPxROZzOBkt3Y5PFiLQDU1jv8NGvnuVimZF20qL3OMo+x
	 ax/uCXXfXRYiSahyvFi1/7VV/sqyi1DpD/RAB6aMQhxKlPnB19iwI1HkLMbvHmJAL4AZf
	 SMnPm+cmvrl04Sd78ciKAmn9SacIpgcXq9nEHrFIiN6yZomBkK1a+iBd07Tkagng88fml
	 5bdmQvjyxbBlRy6oC7ZPwiFbEF5hWaAnesTu6XHN9OM5+VJ7nhfkhMJPhTgMvM6Kw6w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790780936;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=tzuP8ZfbG+12fSNov5a92S0bj6iE0IQkRN9D4Td6AJw=;
	b=nhY+Jms2LAqR9T8aIA4yJoNtqSSesbEUxbnHwFlA/u8yK+VPIHCq3OOtZXSXfbPi5Ssy
	 aOONIs8+ysu+xdpq8ss1i9ov2CseR1PBK5wLa9jOV6w8idw/53FLv+0c3gO+P3Vr8JrkF
	 1CYhKu4VrD18e29/A9VVv8AGeQfopJfH+J2WwiV9cKlH63eD1Q2w/YGKNdJLUq4XK93za
	 dHKHvuW+kscb/wO88LmVPyLk2WdkIbU12scGD/7AVh6jDdTu4WdxmbseiY735kRcnRyuH
	 F4+ElEMCQrzc2ykqwRu/6R72GsVfOTaMi2g1cU64XJ0RKmpKqW6Qmeh4Z9F9XMplekg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790780936;
	bh=tzuP8ZfbG+12fSNov5a92S0bj6iE0IQkRN9D4Td6AJw=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nQbCCb103F471y7ybHRJ8q5ui9u6Y+lgRWEbXev/tsj8EUfg6qFURtdBXKdClEu8/
	 kpG4mvnDi3egIAXUFidoAZ+Xb03lcEUpBmuWvPofaaXQev7fJI3VRFg8hiAhRm5hqO
	 TdpJHfkFyvQwmsCQomTIzQgnW+BkmvsjKkNKKqUdlCTPo1lgcbPn+1eOxiTzJEViq2
	 CGcHDVZ6/paZWq4NEetkPxq7lcfkHhiIyCF/2awS+QYgIKRaZq8dZHg0DwbI9q0mM8
	 F3mCiDdtSOL24Rfk5ZnzdQDsoomFWTDgPn3VlUVqDTRX0e7ycsA8Yz1N8O6yO2TloK
	 jFFIvreUEWstA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F315381045;
	Wed, 30 Sep 2026 15:08:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C10B94C2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 15:08:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B2F3F40042
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 15:08:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uZggrjzHG4Zk for <intel-wired-lan@lists.osuosl.org>;
 Wed, 30 Sep 2026 15:08:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 533D44005E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790780932;
 b=VFpq2meK2Fc4xRfsVoLzZ1VzTpyVun6MXvVheZ5GtewqXGcjNnUX22plt7YZ3Tv1c1Od
 F7G90S5KmazUD1217ZLgdohiKFm6Fv0ucQr2MDFX4ml/uLkgycM+SK2uoVqqIFlKLMUm8
 wbgn/kpLLz8qcHEO9p6K7Xyb03kL7He9NeTu2zqyGFiidvfh7EhlN9XL4g8Tz/od3YAK7
 HVRiv/RFZzKgefK3QAaRaqi7uzvwzkFa9AsPkxx3dlbULd5CYjb9YGDx4D1xy8HcipjOC
 ZkeQrEElKZsoAhp8FREYJqbPsn0hencZ8x8KfWSimXHv0n3Xm1EE7R32JEYcjDQubxw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790780932;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=tzuP8ZfbG+12fSNov5a92S0bj6iE0IQkRN9D4Td6AJw=;
 b=EXpKAlgeFZ7Uv8/XccIWQ6GA7BRHY7luMhfZcZCDAeGxIr1R1LeQEOb5oGtc6NFFNH7F
 eS4aGfKsX6lCo+fyPcF6X751IHLcFc/zXqqX9dyLd2TUiIYh7N7qzZMi0dIqjFwhhe33j
 dIZ6XUAEbwoE2uyZoWXYyBSd/5B2zZJbjybJSKZ+wrRKT8P8ziS5x3747QHpLeuLtLZbT
 IpLdKBMNt6aFfeQ1tbD3cgzCaF9HSDVb1UPshOqJHMNw/ETZ9WEoVDXOJYFb324GkVBNv
 07hjiJlVV/Z5xnJtRwyYmk5+eiAm/uXDXKCOZJUMRiHoT0jiwgw4yMRdX4kUHXyKbYw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ML4GzV4m; 
 arc=none smtp.remote-ip=192.198.163.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ML4GzV4m
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 533D44005E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 15:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790780932; x=1822316932; h=date:from:to:subject:message-id;
 bh=6N2Bb8/NR7L+DCdcf1kk8vDrSO3eMqj6dEhM+KEev1k=;
 b=ML4GzV4m8DDFtwf+mpCzxArTDqvFFHFmxWyqyC4sylWUD+L7p21zOLPq
 yzxpSKdSsDUZhVcr8xAGYeFLJORJVnLV73CigTrghftO5ptaOwk3gXYck
 2pUpoo3lhN2UC04oB+qoHPrVCALW2J3UwmfvLxKx/R0oKJhjnDkc3VhMj
 60sf1qJLamk/PPHEC8y7uTqclWT1P+AJOdNUrWWhJ+Cd57onvk9Vq6JUB
 nOvEexgvZtIHj5KZtDDzi3cH7/zqt3xx/5LG/7MiUkJzkQeaxmQRUGmaq
 M6rFpRRMeMKrNOVoEW5RspWvsp6tFy1AJkMVxAG01Hrbqus8WIJKzyrfY Q==;
X-CSE-ConnectionGUID: NL7NvDLSSoKTWp+2ldEQHA==
X-CSE-MsgGUID: 6tGG+2WZT7SdmuOlAiDgwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="90421101"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="90421101"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 08:08:51 -0700
X-CSE-ConnectionGUID: ryfQDKGhSMyY1c0hvgBF6A==
X-CSE-MsgGUID: hYqJmfS5QZ26QdiyzcTz2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="272162429"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by fmviesa009.fm.intel.com with ESMTP; 30 Sep 2026 08:08:49 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xBvvL-00000000QmU-1IOn;
 Wed, 30 Sep 2026 15:08:47 +0000
Date: Wed, 30 Sep 2026 23:08:28 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:dev-queue] BUILD SUCCESS
 b5501d40ed7abb6d975d9cb0976326e1d42988b2
Message-ID: <202609302325.Kzq5nG6L-lkp@intel.com>
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
branch HEAD: b5501d40ed7abb6d975d9cb0976326e1d42988b2  ice: describe generic DPLL pins from firmware pin classification

elapsed time: 1053m

configs tested: 266
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2107-20260930    gcc-8.5.0  cocci
alpha                randconfig-r2300-20260930    gcc-8.5.0  sparse
alpha                randconfig-r2307-20260930    gcc-10.5.0 sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                         nsim_700_defconfig    gcc-16.1.0
arc                   randconfig-1000-20260930    gcc-11.5.0
arc                   randconfig-1001-20260930    gcc-11.5.0
arc                  randconfig-r2104-20260930    gcc-12     cocci
arc                  randconfig-r2301-20260930    clang-24   sparse
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                   randconfig-1000-20260930    gcc-11.5.0
arm                   randconfig-1001-20260930    gcc-11.5.0
arm                   randconfig-1002-20260930    gcc-11.5.0
arm                   randconfig-1003-20260930    gcc-11.5.0
arm                  randconfig-r2101-20260930    clang-24   cocci
arm                  randconfig-r2102-20260930    clang-24   cocci
arm                            sama5_defconfig    gcc-16.1.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260930    gcc-16.1.0
arm64                 randconfig-1001-20260930    gcc-16.1.0
arm64                 randconfig-1002-20260930    gcc-16.1.0
arm64                 randconfig-1003-20260930    gcc-16.1.0
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260930    gcc-16.1.0
csky                  randconfig-1001-20260930    gcc-16.1.0
csky                 randconfig-r2104-20260930    clang-24   cocci
csky                 randconfig-r2200-20260930    gcc-14.3.0 smatch
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260930    clang-24
hexagon               randconfig-1001-20260930    clang-24
hexagon              randconfig-r2106-20260930    clang-24   cocci
hexagon              randconfig-r2304-20260930    gcc-8.5.0  sparse
i386                              alldefconfig    gcc-16.1.0
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20260930    gcc-14
i386        buildonly-randconfig-1001-20260930    gcc-14
i386        buildonly-randconfig-1002-20260930    gcc-14
i386        buildonly-randconfig-1003-20260930    gcc-14
i386        buildonly-randconfig-1004-20260930    gcc-14
i386        buildonly-randconfig-1005-20260930    gcc-14
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20260930    gcc-14
i386                  randconfig-1001-20260930    gcc-14
i386                  randconfig-1002-20260930    gcc-14
i386                  randconfig-1003-20260930    gcc-14
i386                  randconfig-1004-20260930    gcc-14
i386                  randconfig-1005-20260930    gcc-14
i386                  randconfig-1006-20260930    gcc-14
i386                  randconfig-1007-20260930    clang-22
i386                  randconfig-1008-20260930    clang-22
i386                  randconfig-1009-20260930    clang-22
i386                  randconfig-1010-20260930    clang-22
i386                  randconfig-1011-20260930    clang-22
i386                  randconfig-1012-20260930    clang-22
i386                  randconfig-1013-20260930    clang-22
i386                  randconfig-2100-20260930    clang-22   cocci
i386                  randconfig-2101-20260930    clang-22   cocci
i386                  randconfig-2102-20260930    clang-22   cocci
i386                  randconfig-2103-20260930    clang-22   cocci
i386                  randconfig-2200-20260930    gcc-14     smatch
i386                  randconfig-2300-20260930    gcc-13     sparse
i386                  randconfig-2301-20260930    gcc-13     sparse
i386                  randconfig-2302-20260930    gcc-13     sparse
i386                 randconfig-r2100-20260930    clang-17   cocci
i386                 randconfig-r2105-20260930    gcc-12     cocci
i386                 randconfig-r2202-20260930    gcc-13     smatch
i386                 randconfig-r2303-20260930    clang-24   sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260930    clang-24
loongarch             randconfig-1001-20260930    clang-24
loongarch            randconfig-r2102-20260930    gcc-9.5.0  cocci
loongarch            randconfig-r2303-20260930    gcc-8.5.0  sparse
loongarch            randconfig-r2308-20260930    gcc-10.5.0 sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                           atari_defconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                 randconfig-r2106-20260930    gcc-8.5.0  cocci
m68k                 randconfig-r2202-20260930    gcc-15.2.0 smatch
m68k                 randconfig-r2307-20260930    gcc-12.5.0 sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2103-20260930    gcc-9.5.0  cocci
microblaze           randconfig-r2305-20260930    gcc-8.5.0  sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                       maltasmvp_defconfig    gcc-16.1.0
mips                 randconfig-r2102-20260930    clang-17   cocci
mips                 randconfig-r2103-20260930    clang-17   cocci
mips                 randconfig-r2309-20260930    gcc-10.5.0 sparse
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20260930    clang-24
nios2                 randconfig-1001-20260930    clang-24
nios2                randconfig-r2106-20260930    gcc-12     cocci
nios2                randconfig-r2200-20260930    gcc-10.5.0 smatch
nios2                randconfig-r2201-20260930    gcc-11.5.0 smatch
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2302-20260930    gcc-8.5.0  sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260930    gcc-8.5.0
parisc                randconfig-1001-20260930    gcc-8.5.0
parisc               randconfig-r2107-20260930    gcc-12     cocci
parisc               randconfig-r2300-20260930    gcc-8.5.0  sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                         fsp2_defconfig    gcc-16.1.0
powerpc                       ppc64e_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20260930    gcc-8.5.0
powerpc               randconfig-1001-20260930    gcc-8.5.0
powerpc              randconfig-r2101-20260930    clang-17   cocci
powerpc              randconfig-r2103-20260930    clang-24   cocci
powerpc              randconfig-r2305-20260930    gcc-8.5.0  sparse
powerpc              randconfig-r2306-20260930    gcc-10.5.0 sparse
powerpc              randconfig-r2306-20260930    gcc-12.5.0 sparse
powerpc64             randconfig-1000-20260930    gcc-8.5.0
powerpc64             randconfig-1001-20260930    gcc-8.5.0
powerpc64            randconfig-r2304-20260930    gcc-8.5.0  sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20260930    gcc-16.1.0
riscv                 randconfig-1001-20260930    gcc-16.1.0
riscv                 randconfig-2000-20260930    gcc-14.3.0
riscv                 randconfig-2001-20260930    gcc-14.3.0
riscv                randconfig-r2300-20260930    clang-24   sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20260930    gcc-16.1.0
s390                  randconfig-1001-20260930    gcc-16.1.0
s390                  randconfig-2000-20260930    gcc-14.3.0
s390                  randconfig-2001-20260930    gcc-14.3.0
s390                 randconfig-r2104-20260930    gcc-8.5.0  cocci
s390                 randconfig-r2105-20260930    clang-24   cocci
s390                 randconfig-r2107-20260930    clang-24   cocci
s390                 randconfig-r2305-20260930    clang-24   sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                             hp6xx_defconfig    gcc-16.1.0
sh                    randconfig-1000-20260930    gcc-16.1.0
sh                    randconfig-1001-20260930    gcc-16.1.0
sh                    randconfig-2000-20260930    gcc-14.3.0
sh                    randconfig-2001-20260930    gcc-14.3.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260930    clang-22
sparc                 randconfig-1001-20260930    clang-22
sparc                 randconfig-2000-20260930    gcc-10.5.0
sparc                 randconfig-2001-20260930    gcc-10.5.0
sparc                randconfig-r2301-20260930    gcc-8.5.0  sparse
sparc                randconfig-r2302-20260930    clang-24   sparse
sparc                randconfig-r2308-20260930    gcc-12.5.0 sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260930    clang-22
sparc64               randconfig-1001-20260930    clang-22
sparc64               randconfig-2000-20260930    gcc-10.5.0
sparc64               randconfig-2001-20260930    gcc-10.5.0
sparc64              randconfig-r2304-20260930    clang-24   sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260930    clang-22
um                    randconfig-1001-20260930    clang-22
um                    randconfig-2000-20260930    gcc-10.5.0
um                    randconfig-2001-20260930    gcc-10.5.0
um                   randconfig-r2100-20260930    clang-24   cocci
um                   randconfig-r2105-20260930    gcc-8.5.0  cocci
um                   randconfig-r2200-20260930    clang-24   smatch
um                   randconfig-r2201-20260930    clang-17   smatch
um                   randconfig-r2302-20260930    gcc-8.5.0  sparse
um                   randconfig-r2303-20260930    gcc-8.5.0  sparse
um                   randconfig-r2309-20260930    gcc-12.5.0 sparse
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-22   checkkconfigsymbols
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20260930    clang-22
x86_64      buildonly-randconfig-1001-20260930    clang-22
x86_64      buildonly-randconfig-1002-20260930    clang-22
x86_64      buildonly-randconfig-1003-20260930    clang-22
x86_64      buildonly-randconfig-1004-20260930    clang-22
x86_64      buildonly-randconfig-1005-20260930    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20260930    gcc-14
x86_64                randconfig-1001-20260930    gcc-14
x86_64                randconfig-1002-20260930    gcc-14
x86_64                randconfig-1003-20260930    gcc-14
x86_64                randconfig-1004-20260930    gcc-14
x86_64                randconfig-1005-20260930    gcc-14
x86_64                randconfig-1006-20260930    gcc-14
x86_64                randconfig-1007-20260930    gcc-14
x86_64                randconfig-1008-20260930    gcc-14
x86_64                randconfig-1009-20260930    gcc-14
x86_64                randconfig-1010-20260930    gcc-14
x86_64                randconfig-1011-20260930    gcc-14
x86_64                randconfig-1012-20260930    clang-22
x86_64                randconfig-1013-20260930    clang-22
x86_64                randconfig-1014-20260930    clang-22
x86_64                randconfig-1015-20260930    clang-22
x86_64                randconfig-1016-20260930    clang-22
x86_64                randconfig-1017-20260930    clang-22
x86_64                randconfig-2100-20260930    clang-22   cocci
x86_64                randconfig-2101-20260930    clang-22   cocci
x86_64                randconfig-2102-20260930    clang-22   cocci
x86_64                randconfig-2103-20260930    clang-22   cocci
x86_64                randconfig-2200-20260930    gcc-14     smatch
x86_64                randconfig-2300-20260930    gcc-13     sparse
x86_64                randconfig-2301-20260930    gcc-13     sparse
x86_64                randconfig-2302-20260930    gcc-13     sparse
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
xtensa                randconfig-1000-20260930    clang-22
xtensa                randconfig-1001-20260930    clang-22
xtensa                randconfig-2000-20260930    gcc-10.5.0
xtensa                randconfig-2001-20260930    gcc-10.5.0
xtensa               randconfig-r2100-20260930    gcc-9.5.0  cocci
xtensa               randconfig-r2101-20260930    gcc-9.5.0  cocci
xtensa               randconfig-r2201-20260930    gcc-10.5.0 smatch

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
