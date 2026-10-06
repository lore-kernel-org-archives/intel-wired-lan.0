Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F21BCA5FED
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 11:23:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CCB98404E9;
	Tue,  6 Oct 2026 11:23:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7wIMhGkM-66h; Tue,  6 Oct 2026 11:23:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9B91B404C0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791285793;
	b=G0w/cy5Dj1lLM1V7iNfB9aGi1V3VQ0Avcf2dqXr0groRntGoFJMBs9ptW0rdpxXPVASR
	 OY4DRK2TPYays4yNgPvLruzIEQXtwpF8bmzG3kw55FVp6lg17VfPhWYoVY+dd1/tFs2iP
	 yqgFbNDlbwZ/0aSaUzm1VFG+G1kSi1bbp1MvLxXY9CgJ8X+hZ4FiLEuxBxWmYNOvw2FKQ
	 Yrfz/urQC2xkXXRVerPjhcy43b4SCw67rSGRUbvtQ4Jxi+OkmjhlVyUnm9BmRs9PigF+y
	 zuMKdJGKSOuaRjSZEGELbJ3ctMTRnkt01vz7Bqh+MsOz6QmVtaOhJWXQM3QiZkBe2JA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791285793;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Uh+YwoEHIQoTfjOmXTP1iBYuenrSZ/8LKLfN3DRSlL0=;
	b=Daaag449J4L6O0yZcuyFJQXXcv+08/nfgA4JVSRoGfrYT1foaAtbuVYKOFB2iDHRLQCx
	 wbqvzWro5RaVUOm5q9rQPkGIPpQbeGlFIueqsnhqg+jL9cSKrNXSdLv8aCCR9jUIRWn6J
	 wYUQxPbCHzYXx6tC3N9vwJpM3rP140c9e2dzoY/3HhKrQNee0NRxC7F+YIghXbBDbNYou
	 9Cl3yQasBRFTJaFzLejJtOYvk94xnKGchP42meOvAxxhys8nQpOXB9yX6HwGYp7nu6KF/
	 PJP6ZtNoSjpD4LE2LGQZPDx2oXqma8yMUyg6eSXVt/DcOMwvoDDI81mkS4WPaHGTXfQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791285793;
	bh=Uh+YwoEHIQoTfjOmXTP1iBYuenrSZ/8LKLfN3DRSlL0=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DT0Z1fOaqhj3rFVLL0OBe/RD32hIIUOmgYpCB0NBsQGioLbwAMAligoANvxpSiqaH
	 cwAqJ7Dr65Bf3Z0wfkWgHP/Pm67eXVWojBXTROFLyM/NHltxbRi87/hcfLnmGXwO0g
	 us4r/Gv8AsauB1xUYiLwYHWUD9YtPkrvVOvL0V5n6LvFb9yMx1tCSQ5Rb8K8SqBO+6
	 jQE8g3MhZs3hYLAgXTjNE/dfL1y9TKWGkCMKbCnZDwNBoymEJxLbzCG0ytVhwaL9yt
	 LqVOjpusQTR3RyIUT1Tuuw9zHSSqRrabLXG0fxs5oMA78hJVVlILrBjHBRmB3+3Dci
	 weC3AWQ+/8nQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B91B404C0;
	Tue,  6 Oct 2026 11:23:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E7B1275
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 11:16:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D97AE80BBD
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 11:16:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RJZKi6vAaLHm for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 11:16:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A3B2280AD5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791285381;
 b=QybiS0S/WO+xyT89Xbd9iPVd+0ctAJy7O0oMhT/8W+flrjmeJOa0wfMzcCDJBLLNeIuD
 1lBtb0owzs7qlktlfaqjtN40dxP+mGqZjyrHI02YbEz50/6bIY3C+Wsa5O3GjMqxGNEq+
 4OX9/Iw0uY3oWstyShwpi1JDM86X01VJ7Du5nM5fF4hQPoHNcwxbVIXZccIu+h+bY2XGy
 PDBsSNpAH9sLpBRycmENssmRn8uoaPiXxNHlSmwf3e1yyW7rnyeWcibFp6DOhuEHpnPhd
 N1LNmfUPkRInmxXZWOrWal3Q+jRHwWjVYyss+84FpgidUMMc7o41oyQmufjUZcfQFSw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791285381;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=Uh+YwoEHIQoTfjOmXTP1iBYuenrSZ/8LKLfN3DRSlL0=;
 b=nwsX3nY/Iz6gLLToeO8PdT9ssWFu3h6geYrTH66z+nswUgIJXRu5ceSRLwtZWvuzM1N5
 Pw+gjbXL3U0LpSVV4npSAv3Nv71FXtXr936MqPDhHtn1BKZnWvGCgArUOYgBEQqb9v5QR
 o/oGBFVz0Q6vK2vqC/CPErlMh6ebxNx+jgIHVUgJ8V2zLnFszE18/YollOB+7AP2G/Mmw
 QDeJLnZpSsoRKjlSC6T8HHEkm8MbbJS829+wSGTf7NtJNPTkm30mTN0zqH7wJks4UmjQ7
 zlo/wcYBtpTEqjsiI8IsATLN5G0+1KlDwtXeFvm78x9ySy9pdsOiUgEV9ealDMMmt+Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=HQZw8lKp; 
 arc=none smtp.remote-ip=192.198.163.8
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=HQZw8lKp
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A3B2280AD5
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 11:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791285381; x=1822821381; h=date:from:to:subject:message-id;
 bh=+Vdfk7XfBwk6XrguFs3PtucGqmbn4i28lX3fmlGJLg0=;
 b=HQZw8lKpXvOwBbyGj2OUPsfAZL1VuNYsRAbGXBA4A4//NVmh5eYLSFJI
 Y7y7MCcqZa5PaMlCNUtrmC/qmka6hLq2juZuxl1/U4q1BDS9i5OknrsUz
 BlKpWNpUMqXws9H+UW7DK95O4o6sLXeHHXN1eHU7dDjoF8FDB39A9hd3Y
 E/RA6FKhpaK39AfKuszIv3OWxf2EZRzo8BFj2XR7G92GkiZzpupXJ/tq7
 nfERqBTlvDIR8x9g8SVEQV0HGvUdB5Q4/Qq9I1phYJ5iKN11Ih0FK4+GR
 40Fk7JmyjTJGKyQH4rOeMW/DCrciepkf+Nu1oICXfoMsvxxUWO52mdQc3 A==;
X-CSE-ConnectionGUID: mH6pVkFCQlqjCZiFiCIMlg==
X-CSE-MsgGUID: F1y+KapDS6Ow6Nsj9J/jSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="109461615"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="109461615"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 04:16:20 -0700
X-CSE-ConnectionGUID: fo/OL2HrSNSuWDruIXBGLA==
X-CSE-MsgGUID: AqWMlVqIQhO4tKPBxxuXGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="285228803"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa005.fm.intel.com with ESMTP; 06 Oct 2026 04:16:19 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xE39d-000000001Wu-1JgF;
 Tue, 06 Oct 2026 11:16:17 +0000
Date: Tue, 06 Oct 2026 19:15:46 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:dev-queue] BUILD SUCCESS
 3a063b7d2b9db3c19f6b02303f01aa9c5b4bb31f
Message-ID: <202610061943.0G4VSXtr-lkp@intel.com>
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
branch HEAD: 3a063b7d2b9db3c19f6b02303f01aa9c5b4bb31f  igc: Group frame size macros in igc_tsn.h

elapsed time: 1112m

configs tested: 282
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    clang-24
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2103-20261005    gcc-14.3.0 cocci
alpha                randconfig-r2103-20261006    gcc-8.5.0  cocci
alpha                randconfig-r2200-20261005    gcc-9.5.0  smatch
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                      haps_hs_smp_defconfig    clang-24
arc                   randconfig-1000-20261006    clang-24
arc                   randconfig-1001-20261006    clang-24
arc                  randconfig-r2100-20261005    gcc-11.5.0 cocci
arc                  randconfig-r2106-20261006    clang-24   cocci
arc                  randconfig-r2202-20261005    gcc-14.3.0 smatch
arc                  randconfig-r2307-20261006    gcc-10.5.0 sparse
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                         mvebu_v7_defconfig    clang-24
arm                           pxa3xx_defconfig    clang-24
arm                   randconfig-1000-20261006    clang-24
arm                   randconfig-1001-20261006    clang-24
arm                   randconfig-1002-20261006    clang-24
arm                   randconfig-1003-20261006    clang-24
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261006    gcc-16.1.0
arm64                 randconfig-1001-20261006    gcc-16.1.0
arm64                 randconfig-1002-20261006    gcc-16.1.0
arm64                 randconfig-1003-20261006    gcc-16.1.0
arm64                randconfig-r2101-20261005    gcc-14.3.0 cocci
arm64                randconfig-r2105-20261006    clang-24   cocci
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261006    gcc-16.1.0
csky                  randconfig-1001-20261006    gcc-16.1.0
csky                 randconfig-r2106-20261006    gcc-8.5.0  cocci
csky                 randconfig-r2201-20261006    gcc-9.5.0  smatch
csky                 randconfig-r2302-20261005    gcc-9.5.0  sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261006    gcc-13.4.0
hexagon               randconfig-1001-20261006    gcc-13.4.0
hexagon              randconfig-r2100-20261006    gcc-8.5.0  cocci
hexagon              randconfig-r2301-20261005    gcc-9.5.0  sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261006    gcc-14
i386        buildonly-randconfig-1001-20261006    gcc-14
i386        buildonly-randconfig-1002-20261006    gcc-14
i386        buildonly-randconfig-1003-20261006    gcc-14
i386        buildonly-randconfig-1004-20261006    gcc-14
i386        buildonly-randconfig-1005-20261006    gcc-14
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261006    gcc-14
i386                  randconfig-1001-20261006    gcc-14
i386                  randconfig-1002-20261006    gcc-14
i386                  randconfig-1003-20261006    gcc-14
i386                  randconfig-1004-20261006    gcc-14
i386                  randconfig-1005-20261006    gcc-14
i386                  randconfig-1006-20261006    gcc-14
i386                  randconfig-1007-20261006    gcc-14
i386                  randconfig-1008-20261006    gcc-14
i386                  randconfig-1009-20261006    gcc-14
i386                  randconfig-1010-20261006    gcc-14
i386                  randconfig-1011-20261006    gcc-14
i386                  randconfig-1012-20261006    gcc-14
i386                  randconfig-1013-20261006    gcc-14
i386                  randconfig-2100-20261005    gcc-14     cocci
i386                  randconfig-2100-20261006    clang-22   cocci
i386                  randconfig-2101-20261005    gcc-14     cocci
i386                  randconfig-2101-20261006    clang-22   cocci
i386                  randconfig-2102-20261005    gcc-14     cocci
i386                  randconfig-2102-20261006    clang-22   cocci
i386                  randconfig-2103-20261005    gcc-14     cocci
i386                  randconfig-2103-20261006    clang-22   cocci
i386                  randconfig-2200-20261005    gcc-14     smatch
i386                  randconfig-2200-20261006    gcc-13     smatch
i386                  randconfig-2300-20261005    clang-22   sparse
i386                  randconfig-2301-20261005    clang-22   sparse
i386                  randconfig-2302-20261005    clang-22   sparse
i386                 randconfig-r2100-20261005    gcc-14.3.0 cocci
i386                 randconfig-r2101-20261005    gcc-11.5.0 cocci
i386                 randconfig-r2107-20261005    gcc-8.5.0  cocci
i386                 randconfig-r2300-20261005    gcc-9.5.0  sparse
i386                 randconfig-r2306-20261005    gcc-12.5.0 sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261006    gcc-13.4.0
loongarch             randconfig-1001-20261006    gcc-13.4.0
loongarch            randconfig-r2104-20261006    gcc-8.5.0  cocci
loongarch            randconfig-r2305-20261006    clang-24   sparse
loongarch            randconfig-r2307-20261006    gcc-14.3.0 sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                           amiga_defconfig    clang-24
m68k                                 defconfig    clang-24
m68k                 randconfig-r2107-20261006    gcc-8.5.0  cocci
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2304-20261005    gcc-9.5.0  sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                 randconfig-r2107-20261006    clang-24   cocci
mips                 randconfig-r2302-20261006    clang-24   sparse
mips                 randconfig-r2309-20261006    gcc-10.5.0 sparse
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261006    gcc-13.4.0
nios2                 randconfig-1001-20261006    gcc-13.4.0
nios2                randconfig-r2105-20261005    gcc-8.5.0  cocci
nios2                randconfig-r2303-20261005    gcc-9.5.0  sparse
nios2                randconfig-r2304-20261006    clang-24   sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2103-20261005    gcc-11.5.0 cocci
openrisc             randconfig-r2308-20261006    gcc-10.5.0 sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20261006    gcc-14.3.0
parisc                randconfig-1001-20261006    gcc-14.3.0
parisc               randconfig-r2101-20261006    gcc-8.5.0  cocci
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                  mpc836x_rdk_defconfig    clang-24
powerpc               randconfig-1000-20261006    gcc-14.3.0
powerpc               randconfig-1001-20261006    gcc-14.3.0
powerpc64             randconfig-1000-20261006    gcc-14.3.0
powerpc64             randconfig-1001-20261006    gcc-14.3.0
powerpc64            randconfig-r2104-20261005    gcc-8.5.0  cocci
powerpc64            randconfig-r2201-20261005    clang-24   smatch
powerpc64            randconfig-r2202-20261005    gcc-12.5.0 smatch
powerpc64            randconfig-r2303-20261006    clang-24   sparse
powerpc64            randconfig-r2305-20261005    gcc-9.5.0  sparse
powerpc64            randconfig-r2309-20261006    gcc-14.3.0 sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                     nommu_virt_defconfig    clang-24
riscv                 randconfig-1000-20261006    clang-24
riscv                 randconfig-1001-20261006    clang-24
riscv                 randconfig-2000-20261005    gcc-16.1.0
riscv                 randconfig-2000-20261006    gcc-16.1.0
riscv                 randconfig-2001-20261005    gcc-16.1.0
riscv                 randconfig-2001-20261006    gcc-16.1.0
riscv                randconfig-r2308-20261006    gcc-14.3.0 sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261006    clang-24
s390                  randconfig-1001-20261006    clang-24
s390                  randconfig-2000-20261005    gcc-16.1.0
s390                  randconfig-2000-20261006    gcc-16.1.0
s390                  randconfig-2001-20261005    gcc-16.1.0
s390                  randconfig-2001-20261006    gcc-16.1.0
s390                 randconfig-r2102-20261005    gcc-14.3.0 cocci
s390                 randconfig-r2102-20261006    gcc-8.5.0  cocci
s390                 randconfig-r2201-20261005    clang-22   smatch
s390                 randconfig-r2306-20261006    gcc-10.5.0 sparse
s390                 randconfig-r2308-20261005    gcc-12.5.0 sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20261006    clang-24
sh                    randconfig-1001-20261006    clang-24
sh                    randconfig-2000-20261005    gcc-16.1.0
sh                    randconfig-2000-20261006    gcc-16.1.0
sh                    randconfig-2001-20261005    gcc-16.1.0
sh                    randconfig-2001-20261006    gcc-16.1.0
sh                   randconfig-r2102-20261005    gcc-11.5.0 cocci
sh                   randconfig-r2200-20261006    gcc-16.1.0 smatch
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261006    gcc-14
sparc                 randconfig-1001-20261006    gcc-14
sparc                 randconfig-2000-20261005    clang-17
sparc                 randconfig-2001-20261005    clang-17
sparc                randconfig-r2106-20261005    gcc-8.5.0  cocci
sparc                randconfig-r2300-20261006    clang-24   sparse
sparc                randconfig-r2307-20261005    gcc-12.5.0 sparse
sparc                randconfig-r2309-20261005    gcc-12.5.0 sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261006    gcc-14
sparc64               randconfig-1001-20261006    gcc-14
sparc64               randconfig-2000-20261005    clang-17
sparc64               randconfig-2001-20261005    clang-17
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261006    gcc-14
um                    randconfig-1001-20261006    gcc-14
um                    randconfig-2000-20261005    clang-17
um                    randconfig-2001-20261005    clang-17
um                   randconfig-r2104-20261006    clang-24   cocci
um                   randconfig-r2105-20261006    gcc-8.5.0  cocci
um                   randconfig-r2301-20261006    clang-24   sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261006    gcc-14
x86_64      buildonly-randconfig-1001-20261006    gcc-14
x86_64      buildonly-randconfig-1002-20261006    gcc-14
x86_64      buildonly-randconfig-1003-20261006    gcc-14
x86_64      buildonly-randconfig-1004-20261006    gcc-14
x86_64      buildonly-randconfig-1005-20261006    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261006    gcc-14
x86_64                randconfig-1001-20261006    gcc-14
x86_64                randconfig-1002-20261006    gcc-14
x86_64                randconfig-1003-20261006    gcc-14
x86_64                randconfig-1004-20261006    gcc-14
x86_64                randconfig-1005-20261006    gcc-14
x86_64                randconfig-1006-20261006    gcc-14
x86_64                randconfig-1007-20261006    gcc-14
x86_64                randconfig-1008-20261006    gcc-14
x86_64                randconfig-1009-20261006    gcc-14
x86_64                randconfig-1010-20261006    gcc-14
x86_64                randconfig-1011-20261006    gcc-14
x86_64                randconfig-1012-20261006    gcc-14
x86_64                randconfig-1013-20261006    gcc-14
x86_64                randconfig-1014-20261006    gcc-14
x86_64                randconfig-1015-20261006    gcc-14
x86_64                randconfig-1016-20261006    gcc-14
x86_64                randconfig-1017-20261006    gcc-14
x86_64                randconfig-2100-20261005    clang-22   cocci
x86_64                randconfig-2100-20261006    clang-22   cocci
x86_64                randconfig-2101-20261005    clang-22   cocci
x86_64                randconfig-2101-20261006    clang-22   cocci
x86_64                randconfig-2102-20261005    clang-22   cocci
x86_64                randconfig-2102-20261006    clang-22   cocci
x86_64                randconfig-2103-20261005    clang-22   cocci
x86_64                randconfig-2103-20261006    clang-22   cocci
x86_64                randconfig-2200-20261005    clang-22   smatch
x86_64                randconfig-2200-20261006    clang-22   smatch
x86_64                randconfig-2300-20261005    clang-22   sparse
x86_64                randconfig-2301-20261005    clang-22   sparse
x86_64                randconfig-2302-20261005    clang-22   sparse
x86_64               randconfig-r2200-20261006    clang-22   smatch
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
xtensa                randconfig-1000-20261006    gcc-14
xtensa                randconfig-1001-20261006    gcc-14
xtensa                randconfig-2000-20261005    clang-17
xtensa                randconfig-2001-20261005    clang-17
xtensa               randconfig-r2200-20261005    gcc-14.3.0 smatch
xtensa               randconfig-r2202-20261006    gcc-9.5.0  smatch
xtensa               randconfig-r2306-20261006    gcc-14.3.0 sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
