Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97F4CA5FC4
	for <intel-wired-lan@archiver.kernel.org>; Fri,  2 Oct 2026 08:54:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 96F3181150;
	Fri,  2 Oct 2026 08:54:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LNfPIidDusbd; Fri,  2 Oct 2026 08:54:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F190681108
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790931289;
	b=WGpaatmIze2ert3vdZenS/kDXMqRCfSAaucF2XUlwNpV5Lnv1MPGBEF/3zZCTYWajPyG
	 Gp88BzDTeDOQOJpExLbRRIBQBKx+r8nrA6Zd9eGMK3wznZygjd3zLsqw1IWP3KDaOBTu+
	 AlV7MTiU1ElNSEXq6Q68xvcs09hv1Weg+zOsk17DA0GoEJrofNIrmsMxUmuZ22vEXNQrK
	 FN/suqMJ55SEmRL2s5g7vH3oOoBTt9WC6axe/eAoHVIjunzGxK7Ynargd//vihDphyHxK
	 rIH/YGaK6+NJ7+ZHZuvGt4/FRhOj2ySTPH+EYGgRPzc9EeSunvyrOLGBu3sz/UHpucA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790931289;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=hXdM4WPvA3egKAkMN7SY2nmzcw3+COrOSmyarDib65A=;
	b=O+8QV5Po+301oGYw2aGZ6FdBNMiXKE8cUFROeqXhIx2NQN/iR3l0SZ4aT1vAZpmfM+U1
	 6Vt1wzZ2/+bQyeHkvnMpsDKO2QlvZ0xhmdbrDR451ljRg5BDKQRzrivrg+PzG9U0Kleyz
	 sLLsnR0ZbTH4vLzeYVoJ3nzjbAZbBo96EDA/BsMPXMtr/JLXxtjy7ARWpDjH4SHk06g9b
	 uGvEM8kwsjYRv8rcPIGqSQA/huWn2fZCseafEbEzwnXqeNiidpAOdeoqDTC0s91sqGB5I
	 KS4tUjYPEYllH9R7eoQnHUnbR84Swr9JSvBj7KC2vJksfQriwg7btmHYyF+kVT9nCQQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790931289;
	bh=hXdM4WPvA3egKAkMN7SY2nmzcw3+COrOSmyarDib65A=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=z4KXjxJNb5S5SFXEeo1+51Aj5RTHfK0R4JHTGofiJcXcafM5bbpCYNkzMZyXfhrK2
	 PVLomL6lgboGMvbMU+RYD6HyXpcUD4LlLpXFOS0EGC0vIaskjvC9ZYogJKcC5wA4jV
	 CQXYTAQ9/zJPCmefKprjIHEUsyHIswBmJ4QfjOE9mu52d4+pyv4Z/zG7kdJPtchhSE
	 Hsyzp8iRVzTOh54G6ffWSk7H9/b1OUDIGoyUHFNubd9GUV+Sh1WbpmL8XLNFc3o8lL
	 3nRcmkry0hYsL4A0qwN/26GVzEsNP+UiuuvMEVtuOs0/nvQh/hwa17XEOJtVw1PiBA
	 8e7Z97LBkuvDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F190681108;
	Fri,  2 Oct 2026 08:54:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A295522B
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 08:54:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 65C5440AC4
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 08:54:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O3QS-veli23Z for <intel-wired-lan@lists.osuosl.org>;
 Fri,  2 Oct 2026 08:54:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E1AF640ABB
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790931284;
 b=i+Vt8qJNtpFDVSuqtIsJxcVTGHoBkk0Wjhu0ClEiDSDV8n8xmp8IJgHHxkWGTGo0RcGE
 i9PtBBKvnZzck6FN9ib7WJ7E7juqwJZrsHY77bTOmVRPGOUB0Z32pAcl35yiIyUPmABeU
 72Wm1iVTtoNL7cyYMPNhyaM23ZyD5vyORUVue1J/nKOwKjHGpWfCq4zl4iBgN8P6U+P3y
 SznrsY1Prkna+bqwNnhqmbNnn+6l13weEs9EtY0izYVQ1qxe5UzCVGXDYvGtzbZfv+KE9
 kvKf6XUvrLcYkECTunsHToItH5i00/vOvHK7UUWWjCih6HMtuBexin/PAR6SJElen8w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790931284;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=hXdM4WPvA3egKAkMN7SY2nmzcw3+COrOSmyarDib65A=;
 b=OWo02lO8mODys9u0ekKRgRvaFBDhin9ycJjRfTaYG/kvZ2i3/u3LvFhhRYLhoRXPJGVu
 NCtST1lzsfw6LpAorFoKskX45DkL1TMM0iYFfm2WxU0Cwibtgc6H7g7t9qkCAu62Glv9P
 eVtw4nq1DruD12az9m+BU73JKoTEmniVptnB0Fb5qGT8NfCuTTQcIMzfXI+cJMhUSXHvz
 nNq2D0wlZWHeiiR5MnQcRvV5/5SNGWTqY36OlGSEsW7kER/LyWaxEH6EPojXMmYmwBDoY
 8Hz31u1MnMLjStLeik5g85Dh7Jaanb4eJVuNtLoAF456reaLsrFy5ZGT5DkQEZgRrQw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=kf0aQRGP; 
 arc=none smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=kf0aQRGP
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E1AF640ABB
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 08:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790931284; x=1822467284; h=date:from:to:subject:message-id;
 bh=Wv/bg5wuvit1HKF2PGR0PmKDRFcwoPlFTcZiMtZkgzc=;
 b=kf0aQRGP0unHaxw0Ub9Lh1ow1dQ6P4WwQzLTcG3D89OA+ulzxID72Rh5
 ExWGdyLQo0y+dJEcYjgMj2K87L7B8YVBXAq8jwjXvp5mi8g/9V/xibWKW
 kkfWZKwIkmhTbwTQNGnPg+mVNIFn+ZLoNS46kzPopbCn36mbDbrnjGC1R
 +ZE/dnh5sfOvQ0KsM2iQd8hesvdwglEVIsNuSEG6c1Vh9sBhSsCZn0oeT
 Y2Wou85Vv6L+toX/VeqlQJRYlmeKOT5/f7TSn4ggzpkk6cBj5mLo3I0er
 hcMHrLtXdOpvBDskihvOcUX3ktMbdmVyxramD+kSs3n/5OYJr7SjpTRla Q==;
X-CSE-ConnectionGUID: 5uqFvQV1RC23nrVxRZixWQ==
X-CSE-MsgGUID: ppAUlDugSD+vtdfl/5tB/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="103070548"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="103070548"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 01:54:43 -0700
X-CSE-ConnectionGUID: vDgRHr29SSmnsiDXh8aC8w==
X-CSE-MsgGUID: VJALiSBnTb+uhcqSsUuWfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="275757440"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by orviesa007.jf.intel.com with ESMTP; 02 Oct 2026 01:54:42 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xCZ2N-00000000SpQ-2G0o;
 Fri, 02 Oct 2026 08:54:39 +0000
Date: Fri, 02 Oct 2026 16:53:52 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:10GbE] BUILD SUCCESS
 5642b1648d5c4561d8ed7a410d0a7017f706604d
Message-ID: <202610021648.xKEJrg2Z-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 10GbE
branch HEAD: 5642b1648d5c4561d8ed7a410d0a7017f706604d  net: sparx5: make ports inherit the switch base mac address type

elapsed time: 1071m

configs tested: 259
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2104-20261001    gcc-8.5.0  cocci
alpha                randconfig-r2305-20261001    gcc-12.5.0 sparse
alpha                randconfig-r2309-20261001    gcc-16.1.0 sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20261002    clang-17
arc                   randconfig-1001-20261002    clang-17
arc                  randconfig-r2103-20261001    gcc-9.5.0  cocci
arc                  randconfig-r2105-20261001    gcc-8.5.0  cocci
arc                  randconfig-r2201-20261001    gcc-12.5.0 smatch
arc                  randconfig-r2300-20261001    gcc-8.5.0  sparse
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                             dove_defconfig    gcc-16.1.0
arm                       integrator_defconfig    gcc-16.1.0
arm                         mvebu_v7_defconfig    gcc-16.1.0
arm                   randconfig-1000-20261002    clang-17
arm                   randconfig-1001-20261002    clang-17
arm                   randconfig-1002-20261002    clang-17
arm                   randconfig-1003-20261002    clang-17
arm                  randconfig-r2103-20261001    gcc-8.5.0  cocci
arm                  randconfig-r2307-20261001    gcc-15.2.0 sparse
arm                          s3c6400_defconfig    gcc-16.1.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261002    gcc-12.5.0
arm64                 randconfig-1001-20261002    gcc-12.5.0
arm64                 randconfig-1002-20261002    gcc-12.5.0
arm64                 randconfig-1003-20261002    gcc-12.5.0
arm64                randconfig-r2106-20261001    clang-24   cocci
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261002    gcc-12.5.0
csky                  randconfig-1001-20261002    gcc-12.5.0
csky                 randconfig-r2100-20261001    gcc-13.4.0 cocci
csky                 randconfig-r2301-20261001    gcc-9.5.0  sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261002    gcc-13.4.0
hexagon               randconfig-1001-20261002    gcc-13.4.0
hexagon              randconfig-r2306-20261001    clang-24   sparse
hexagon              randconfig-r2307-20261001    clang-24   sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261002    clang-22
i386        buildonly-randconfig-1001-20261002    clang-22
i386        buildonly-randconfig-1002-20261002    clang-22
i386        buildonly-randconfig-1003-20261002    clang-22
i386        buildonly-randconfig-1004-20261002    clang-22
i386        buildonly-randconfig-1005-20261002    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261002    gcc-14
i386                  randconfig-1001-20261002    gcc-14
i386                  randconfig-1002-20261002    gcc-14
i386                  randconfig-1003-20261002    gcc-14
i386                  randconfig-1004-20261002    gcc-14
i386                  randconfig-1005-20261002    gcc-14
i386                  randconfig-1006-20261002    gcc-14
i386                  randconfig-1007-20261002    clang-22
i386                  randconfig-1008-20261002    clang-22
i386                  randconfig-1009-20261002    clang-22
i386                  randconfig-1010-20261002    clang-22
i386                  randconfig-1011-20261002    clang-22
i386                  randconfig-1012-20261002    clang-22
i386                  randconfig-1013-20261002    clang-22
i386                  randconfig-2100-20261001    gcc-14     cocci
i386                  randconfig-2101-20261001    gcc-14     cocci
i386                  randconfig-2102-20261001    clang-22   cocci
i386                  randconfig-2103-20261001    gcc-13     cocci
i386                  randconfig-2200-20261001    clang-22   smatch
i386                  randconfig-2300-20261001    clang-22   sparse
i386                  randconfig-2301-20261001    gcc-14     sparse
i386                  randconfig-2302-20261001    gcc-14     sparse
i386                 randconfig-r2105-20261001    gcc-14     cocci
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261002    gcc-13.4.0
loongarch             randconfig-1001-20261002    gcc-13.4.0
loongarch            randconfig-r2201-20261001    clang-18   smatch
loongarch            randconfig-r2202-20261001    clang-21   smatch
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                         m5272c3_defconfig    gcc-16.1.0
m68k                        m5275evb_defconfig    gcc-16.1.0
m68k                       m54418evb_defconfig    gcc-16.1.0
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2101-20261001    gcc-10.5.0 cocci
microblaze           randconfig-r2104-20261001    gcc-8.5.0  cocci
microblaze           randconfig-r2200-20261001    gcc-9.5.0  smatch
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                            ip27_defconfig    gcc-16.1.0
mips                            ip28_defconfig    gcc-16.1.0
mips                         maltaup_defconfig    gcc-16.1.0
mips                     maltaup_xpa_defconfig    gcc-16.1.0
mips                            mtx1_defconfig    gcc-16.1.0
mips                 randconfig-r2107-20261001    clang-24   cocci
mips                 randconfig-r2303-20261001    clang-17   sparse
nios2                          3c120_defconfig    gcc-16.1.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261002    gcc-13.4.0
nios2                 randconfig-1001-20261002    gcc-13.4.0
nios2                randconfig-r2305-20261001    gcc-9.5.0  sparse
openrisc                          alldefconfig    gcc-16.1.0
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20261002    gcc-14.3.0
parisc                randconfig-1001-20261002    gcc-14.3.0
parisc               randconfig-r2202-20261001    gcc-8.5.0  smatch
parisc64                             defconfig    clang-24
powerpc                            allnoconfig    clang-24
powerpc                       arches_defconfig    gcc-16.1.0
powerpc                       katmai_defconfig    gcc-16.1.0
powerpc                       pcm030_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20261002    gcc-14.3.0
powerpc               randconfig-1001-20261002    gcc-14.3.0
powerpc              randconfig-r2101-20261001    gcc-9.5.0  cocci
powerpc64             randconfig-1000-20261002    gcc-14.3.0
powerpc64             randconfig-1001-20261002    gcc-14.3.0
powerpc64            randconfig-r2304-20261001    gcc-8.5.0  sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv              nommu_k210_sdcard_defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261002    clang-24
riscv                 randconfig-1001-20261002    clang-24
riscv                 randconfig-2000-20261001    gcc-9.5.0
riscv                 randconfig-2001-20261001    gcc-8.5.0
riscv                randconfig-r2302-20261001    clang-18   sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261002    clang-24
s390                  randconfig-1001-20261002    clang-24
s390                  randconfig-2000-20261001    gcc-9.5.0
s390                  randconfig-2001-20261001    clang-17
s390                 randconfig-r2100-20261001    gcc-13.4.0 cocci
s390                 randconfig-r2102-20261001    clang-24   cocci
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                          apsh4a3a_defconfig    gcc-16.1.0
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20261002    clang-24
sh                    randconfig-1001-20261002    clang-24
sh                    randconfig-2000-20261001    gcc-16.1.0
sh                    randconfig-2001-20261001    gcc-10.5.0
sh                   randconfig-r2100-20261001    gcc-16.1.0 cocci
sh                   randconfig-r2102-20261001    gcc-16.1.0 cocci
sh                   randconfig-r2106-20261001    gcc-16.1.0 cocci
sh                           sdk7780_defconfig    gcc-16.1.0
sh                            se7780_defconfig    gcc-16.1.0
sh                             shmin_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261002    clang-24
sparc                 randconfig-1001-20261002    clang-24
sparc                 randconfig-2000-20261001    gcc-12.5.0
sparc                 randconfig-2001-20261001    gcc-14.3.0
sparc                randconfig-r2106-20261001    gcc-8.5.0  cocci
sparc                randconfig-r2300-20261001    gcc-14.3.0 sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261002    clang-24
sparc64               randconfig-1001-20261002    clang-24
sparc64               randconfig-2000-20261001    clang-24
sparc64               randconfig-2001-20261001    gcc-8.5.0
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261002    clang-24
um                    randconfig-1001-20261002    clang-24
um                    randconfig-2000-20261001    clang-17
um                    randconfig-2001-20261001    clang-24
um                   randconfig-r2200-20261001    clang-24   smatch
um                   randconfig-r2306-20261001    gcc-14     sparse
um                   randconfig-r2308-20261001    gcc-14     sparse
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-22   checkkconfigsymbols
x86_64                             allnoconfig    clang-24
x86_64      buildonly-randconfig-1000-20261002    gcc-14
x86_64      buildonly-randconfig-1001-20261002    gcc-14
x86_64      buildonly-randconfig-1002-20261002    gcc-14
x86_64      buildonly-randconfig-1003-20261002    gcc-14
x86_64      buildonly-randconfig-1004-20261002    gcc-14
x86_64      buildonly-randconfig-1005-20261002    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261002    gcc-14
x86_64                randconfig-1001-20261002    gcc-14
x86_64                randconfig-1002-20261002    gcc-14
x86_64                randconfig-1003-20261002    gcc-14
x86_64                randconfig-1004-20261002    gcc-14
x86_64                randconfig-1005-20261002    gcc-14
x86_64                randconfig-1006-20261002    clang-22
x86_64                randconfig-1007-20261002    clang-22
x86_64                randconfig-1008-20261002    clang-22
x86_64                randconfig-1009-20261002    clang-22
x86_64                randconfig-1010-20261002    clang-22
x86_64                randconfig-1011-20261002    clang-22
x86_64                randconfig-1012-20261002    clang-22
x86_64                randconfig-1013-20261002    clang-22
x86_64                randconfig-1014-20261002    clang-22
x86_64                randconfig-1015-20261002    clang-22
x86_64                randconfig-1016-20261002    clang-22
x86_64                randconfig-1017-20261002    clang-22
x86_64                randconfig-2100-20261001    gcc-14     cocci
x86_64                randconfig-2101-20261001    gcc-13     cocci
x86_64                randconfig-2102-20261001    clang-22   cocci
x86_64                randconfig-2103-20261001    clang-22   cocci
x86_64                randconfig-2200-20261001    clang-22   smatch
x86_64                randconfig-2300-20261001    clang-22   sparse
x86_64                randconfig-2301-20261001    clang-22   sparse
x86_64                randconfig-2302-20261001    gcc-14     sparse
x86_64               randconfig-r2107-20261001    clang-22   cocci
x86_64               randconfig-r2304-20261001    gcc-14     sparse
x86_64               randconfig-r2308-20261001    clang-22   sparse
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261002    clang-24
xtensa                randconfig-1001-20261002    clang-24
xtensa                randconfig-2000-20261001    gcc-10.5.0
xtensa                randconfig-2001-20261001    gcc-8.5.0
xtensa               randconfig-r2302-20261001    gcc-8.5.0  sparse
xtensa               randconfig-r2303-20261001    gcc-15.2.0 sparse
xtensa               randconfig-r2309-20261001    gcc-8.5.0  sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
