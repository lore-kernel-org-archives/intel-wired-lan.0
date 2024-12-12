Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1E8E7717F
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Dec 2024 22:58:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B7B59613D3;
	Thu, 12 Dec 2024 22:58:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v-Iad23YzmbJ; Thu, 12 Dec 2024 22:58:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C894B61423
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1734044338;
	bh=+cUdjHhcafCL2kjMPah5s7J4ytmXBPfi+KUQIxkCBJg=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wtGJxyYUu1Uj3H/Que3DoUJdjPBXqaMzfnooljkPl/WDQ9k2hu9OeOxZpnCGu6SGy
	 WeujiO6gp5B1YivEAbBm8vCDphYSzJMlNbx9VgTpwmL47lWRXzw2TO/MhJs5Vn2CCN
	 JQCDN3NfT8FI2zH6VYYE+O6vrB7tU5VEzQh7mAX8Kx0pn4d3QJfQkVDlmeJzhjwFXd
	 3m3Z7OVuDPNgWYZmPwKZ+KfsfDq9zvxl9PHzfubbmoUgS6u/6k00OQaDg1kcgDM3eW
	 mAVb2kzkeoBlyoLp6yWNHRDN55lBNjDm3sQL0h3NpaSGgvL7BSnOmmKihAmTn8TJM0
	 cdWI6194h0vmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C894B61423;
	Thu, 12 Dec 2024 22:58:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 28AEB1146
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Dec 2024 22:58:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0953E401C2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Dec 2024 22:58:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dL2p57KgsD_D for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Dec 2024 22:58:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D1723401EF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D1723401EF
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D1723401EF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Dec 2024 22:58:56 +0000 (UTC)
X-CSE-ConnectionGUID: bRgjTFfkR7ObsWcCuN1sxw==
X-CSE-MsgGUID: rp05/nk7SuqCzvM6doAq3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="22075756"
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; d="scan'208";a="22075756"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 14:58:56 -0800
X-CSE-ConnectionGUID: EkIJHwq/T0qencPTkrepSw==
X-CSE-MsgGUID: WSSLpj2xT6SZ2EtWmqXUKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="133743921"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
 by orviesa001.jf.intel.com with ESMTP; 12 Dec 2024 14:58:55 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1tLs8y-000BSf-03
 for intel-wired-lan@lists.osuosl.org; Thu, 12 Dec 2024 22:58:52 +0000
Date: Fri, 13 Dec 2024 06:58:17 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202412130612.2zzOJUca-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734044337; x=1765580337;
 h=date:from:to:subject:message-id;
 bh=wHJsGUZaayATEYXEKZubuQSlen8/kks6ZS9//6VlO3c=;
 b=HoNswDveETyf3OuiMOiyWC0qqI0+NTRe3rsGI5mSEYRS29J+SM95xNUR
 9Nk4v63bBNDxPK4PNObS30Fot5nwQOcBILyRWPOeDr1aGlTW+EkaFEyH+
 cxsqS9y8j47bQq19qpv3R1eMhiv3yrDwqzGKStEQTVdzBKuPtfr4U/p6/
 yt5KwLQiFi4pa5zo1CjRw8WsNRKB9iFJ3sIX+UwIHp3yTgJo72Ic7dNoQ
 9+tYLB6pFfqXH9WMdWXivx88OsFrzLB0wHjy7L4goYce+j4UYBjWDVR1q
 wuwS7AvDqqVoR/kynfKxW0OtfK4t/QDDDpPB6Ug9G9FZN7wZuSdyequB1
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=HoNswDve
Subject: [Intel-wired-lan] [tnguy-next-queue:100GbE] BUILD SUCCESS
 8bbcbcf3ad1decb8c088c4b39ec3958000b90d31
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 100GbE
branch HEAD: 8bbcbcf3ad1decb8c088c4b39ec3958000b90d31  ice: Add MDD logging via devlink health

elapsed time: 1455m

configs tested: 41
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc        randconfig-001-20241212    gcc-13.2.0
arc        randconfig-002-20241212    gcc-13.2.0
arm        randconfig-001-20241212    gcc-14.2.0
arm        randconfig-002-20241212    clang-20
arm        randconfig-003-20241212    clang-19
arm        randconfig-004-20241212    clang-20
arm64      randconfig-001-20241212    clang-20
arm64      randconfig-002-20241212    clang-15
arm64      randconfig-003-20241212    clang-20
arm64      randconfig-004-20241212    gcc-14.2.0
csky       randconfig-001-20241212    gcc-14.2.0
csky       randconfig-002-20241212    gcc-14.2.0
hexagon    randconfig-001-20241212    clang-14
hexagon    randconfig-002-20241212    clang-16
loongarch  randconfig-001-20241212    gcc-14.2.0
loongarch  randconfig-002-20241212    gcc-14.2.0
nios2      randconfig-001-20241212    gcc-14.2.0
nios2      randconfig-002-20241212    gcc-14.2.0
parisc     randconfig-001-20241212    gcc-14.2.0
parisc     randconfig-002-20241212    gcc-14.2.0
powerpc    randconfig-001-20241212    gcc-14.2.0
powerpc    randconfig-002-20241212    clang-20
powerpc    randconfig-003-20241212    clang-15
powerpc64  randconfig-001-20241212    clang-20
powerpc64  randconfig-002-20241212    gcc-14.2.0
powerpc64  randconfig-003-20241212    gcc-14.2.0
riscv      randconfig-001-20241212    clang-17
riscv      randconfig-002-20241212    clang-20
s390       randconfig-001-20241212    clang-18
s390       randconfig-002-20241212    clang-20
sh                    allmodconfig    gcc-14.2.0
sh         randconfig-001-20241212    gcc-14.2.0
sh         randconfig-002-20241212    gcc-14.2.0
sparc      randconfig-001-20241212    gcc-14.2.0
sparc      randconfig-002-20241212    gcc-14.2.0
sparc64    randconfig-001-20241212    gcc-14.2.0
sparc64    randconfig-002-20241212    gcc-14.2.0
um         randconfig-001-20241212    gcc-12
um         randconfig-002-20241212    clang-20
xtensa     randconfig-001-20241212    gcc-14.2.0
xtensa     randconfig-002-20241212    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
