Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38D9606A31A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Oct 2026 04:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=K8BicuEY;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MsYpjtxK
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C232C40569;
	Wed, 28 Oct 2026 04:34:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id naNwLuC2gFMs; Wed, 28 Oct 2026 04:34:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5242B4040E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793162062;
	b=XWhRl2wHZbMVIsrowiReT1bqIkDNYbr+vhnfh2L8cKKZ+2rZYwg9Ci1fa2iu2D9vEP+r
	 MKvpheCvEN0i4t/B8kvBQr4qbHYL6QtpxtIzPr9xszydCkKDtLgQz3PT5Um5x3MtsGhZg
	 Ozhg6/vNPVMyxbQOffNRE9dOL51Z0NW9QbX0zPEDk+BML1txUhiT/Lss8l/w+plCYfrDC
	 ecdGcMLLDZS0EED12BLw5qXRZyseL/rLnPo8UzsMdpWdBNjOO+7QXXlr8zdznsr9JEXNo
	 8qsbw795DCWJl3Ogfy/cpsIhxWAocJa8rUav84ZCm7gmpp0/Q/R+aMXm6qG/Siy9aCA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793162062;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Qe4wYRr/DqA5mdoRBuRx9uLEnaqDJQhKBkffFzcKe6s=;
	b=HZOopcvVQIEJnWZ0eoZK4a9LtUAYYuLHpjh+tHrzz0GO1NPJYQNTlXqmLNB5UjxEwq33
	 7TNTOSAQn1XUXXdfRsZ3anx1rqlNbqvAMZ03yzEZiPhWZz/HYi86OPVM6lfcYGM9hWVs0
	 m01c1jtWbDvK3is4CBCN8ow8iBy6rwIn0F4O3o4f3wF43Scqlez9lh0ywifsbNJl5epZi
	 xothLbQHykDHWSU1txTMKTMiF22ztvbAB+dQ0OVLXB/Yq1Hv0VfgY89J3NEmZ/FjsJ0Wy
	 tsBqi35qPYern2wc0eCjHKmk9bkXBptbuZdpBN+uoaXrGyXThqqti8Q9i4jGDc53nKw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793162062;
	bh=Qe4wYRr/DqA5mdoRBuRx9uLEnaqDJQhKBkffFzcKe6s=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=K8BicuEYRzjwD9doyNbeU+rwFpLDRFvgPylAAfUFz8+NVATn9Vp9e62OqoY0kDog1
	 fzyu1trHnhz7Z/IgldYY6EsEuFgPOrRBAR8XRW3P8dcOtb//G6nucMj9oysOa8LnRK
	 823rMcKtPJTl21aY9VW6hW7yzKaBqh2nUVt6o+LdSFq7ueN/FTY+zqQ6ZhkENaIscv
	 R1oc4ya1qy1v0I8X0+7WgfhQknPk0JzHuSTUYXXYq1UKncUh8J6cYUoXizvSoR3ElZ
	 6l3P2ElAb6OLAiUwSUPxaEosCk3pEO4+IJCPH3Efzv16zAndJST7hDVPSXI15UzDP5
	 NnLjR2gy5d/9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5242B4040E;
	Wed, 28 Oct 2026 04:34:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BC2F4473
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 04:34:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ADE444006F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 04:34:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3G8WXOZKZYzZ for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 Oct 2026 04:34:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 29E3E400F5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793162059;
 b=SHegwpDJos/dji4qZ+qsqtnJEg5HFrsoISrJjIvMpz8mq5ETT3Jwy730zuku4w/4o5GS
 ESRz9FZiyw9Ei3RkgmZVNbIaaS2UP5Pc059NCQ1BAld+54prpEt4RPyasyzMApise8KwQ
 aq9xpz6mqSb/HRwtUnzxW5VogTHq2FoM8r6HnNgI6GomfieGxp1cKVAfczw2Es2mPx3Dx
 JQw6R7e0+11Aopwd2De/ymNgEzDTxEFMaLY8fz3WnLJMfn4E2GxZ6HAgrAy6TCvwLoNLL
 AAKpvChuOT2LP/7MUh+NjIGGGvx7UkLZKYGhJ/MR1oCd26i9yipn3nnwDzZnswrUfpA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793162059;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=Qe4wYRr/DqA5mdoRBuRx9uLEnaqDJQhKBkffFzcKe6s=;
 b=hk+ljusDStHEY5scOLgegOueiYKJ1ZoajlohCLxziQpvS/Ig8kYBrtb423LsfAsFAQaC
 NQNRgO6fGjT0Ct4OwwH3J+cbo4AsKc281Q2p5iV+5y7GfQ6WnHcBkDDvJ86zJlt9tD6fW
 UNqI9i3L07Ov+CZbdtaGfj9A80LR4STrgyhOccg4Af7z2BDRsuNk3iAhiLXur5Gnuhf2j
 /R/ErxHQHz5V7nguFwI29sanrSujg4gsVs2qYenFX4w/nAlwXWMFL0oqxYTaJxsTrtaMg
 BvepoWGgBPba7pV4Vtn+Z5OfphrW/eWPkJZ/1JHO2m6TTy9s+U7sO3lgFSAPFQgHTYA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=MsYpjtxK; 
 arc=none smtp.remote-ip=192.198.163.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=MsYpjtxK
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 29E3E400F5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 04:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793162059; x=1824698059; h=date:from:to:subject:message-id;
 bh=ZHygTKQcWKa862CoR+qRjODp1Egcjj6N37+kysz2zA8=;
 b=MsYpjtxK+VJuF2zga+gB+MPgMEuc8myEYEfsuRy/NTuf8WMnssMEvXX7
 SbA1nW0/ILU3DRQJ1q2QMdELna2s7tDXr7gOim1CDixoAFmwf6/s+c7NL
 ZxgoWBfNaYBmoY32KxRkpVlo38wtUFHxU4ZWCZULvMvETC2xYNRrYkYKh
 WS9SWcSen9oPFMKXZ5fDAMWAQetjvCuiy8CWiGBZPSZHTQ+0LSHoJbYeu
 90WbxQtE3vcQubq8PTSxxnp0A53h9k01WyX3Z/RogJPF91S2rekYforLl
 grjFDyi5cxMpBbq49sQExai1YCouwo0buFzNJvFsg3nJqSVF/ZjY0gBUG w==;
X-CSE-ConnectionGUID: zns3U5AkSZKquj7br7x4QQ==
X-CSE-MsgGUID: 0dfBHikDQea2CkKZh7WLOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1904885"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1904885"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 21:34:18 -0700
X-CSE-ConnectionGUID: kW4r1IFZSEKpUkmUB+EImQ==
X-CSE-MsgGUID: agTXM/nCQ9mixSAZa2Lbhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4778296"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa009.jf.intel.com with ESMTP; 27 Oct 2026 21:34:17 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xLvMc-00000000YDO-3vPr;
 Wed, 28 Oct 2026 04:34:14 +0000
Date: Wed, 28 Oct 2026 12:33:15 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:main] BUILD SUCCESS
 7076f684d5132e6a6145e1da2fa74771ecd052e5
Message-ID: <202610281211.6Fyxc2Ti-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git main
branch HEAD: 7076f684d5132e6a6145e1da2fa74771ecd052e5  net/sched: etf: initialise the sock_exterr_skb before filling it

elapsed time: 5281m

configs tested: 518
configs skipped: 19

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
arc                               alldefconfig    clang-17
arc                               allmodconfig    clang-24
arc                               allmodconfig    gcc-16.2.0
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                               allyesconfig    gcc-16.2.0
arc                           axs101_defconfig    gcc-16.2.0
arc                       axs103_smp_defconfig    clang-17
arc                                  defconfig    gcc-16.2.0
arc                             hsdk_defconfig    clang-24
arc                   randconfig-1000-20261025    clang-24
arc                   randconfig-1000-20261026    clang-24
arc                   randconfig-1000-20261027    gcc-10.5.0
arc                   randconfig-1000-20261028    gcc-8.5.0
arc                   randconfig-1001-20261025    clang-24
arc                   randconfig-1001-20261026    clang-24
arc                   randconfig-1001-20261027    gcc-10.5.0
arc                   randconfig-1001-20261028    gcc-8.5.0
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                               allyesconfig    gcc-16.2.0
arm                      am200epdkit_defconfig    gcc-16.2.0
arm                        aspeed_g4_defconfig    gcc-16.2.0
arm                          assabet_defconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                           exynos_defconfig    gcc-16.2.0
arm                             hisi_defconfig    gcc-16.2.0
arm                        imx_v4_v5_defconfig    gcc-16.2.0
arm                             mmp2_defconfig    gcc-16.2.0
arm                        multi_v4t_defconfig    gcc-16.2.0
arm                         multi_v7_defconfig    gcc-16.2.0
arm                         mvebu_v7_defconfig    gcc-16.2.0
arm                              mxs_defconfig    clang-17
arm                          orion5x_defconfig    clang-17
arm                           pxa910_defconfig    gcc-16.2.0
arm                              pxa_defconfig    gcc-16.2.0
arm                   randconfig-1000-20261025    clang-24
arm                   randconfig-1000-20261026    clang-24
arm                   randconfig-1000-20261027    gcc-10.5.0
arm                   randconfig-1000-20261028    gcc-8.5.0
arm                   randconfig-1001-20261025    clang-24
arm                   randconfig-1001-20261026    clang-24
arm                   randconfig-1001-20261027    gcc-10.5.0
arm                   randconfig-1001-20261028    gcc-8.5.0
arm                   randconfig-1002-20261025    clang-24
arm                   randconfig-1002-20261026    clang-24
arm                   randconfig-1002-20261027    gcc-10.5.0
arm                   randconfig-1002-20261028    gcc-8.5.0
arm                   randconfig-1003-20261025    clang-24
arm                   randconfig-1003-20261026    clang-24
arm                   randconfig-1003-20261027    gcc-10.5.0
arm                   randconfig-1003-20261028    gcc-8.5.0
arm                          s5pv210_defconfig    clang-24
arm                            tegra_defconfig    clang-24
arm                        versatile_defconfig    clang-24
arm                     vt8500_v6_v7_defconfig    gcc-16.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261025    clang-24
arm64                 randconfig-1000-20261026    clang-24
arm64                 randconfig-1000-20261027    gcc-8.5.0
arm64                 randconfig-1000-20261028    clang-22
arm64                 randconfig-1001-20261025    clang-24
arm64                 randconfig-1001-20261026    clang-24
arm64                 randconfig-1001-20261027    gcc-8.5.0
arm64                 randconfig-1001-20261028    clang-22
arm64                 randconfig-1002-20261025    clang-24
arm64                 randconfig-1002-20261026    clang-24
arm64                 randconfig-1002-20261027    gcc-8.5.0
arm64                 randconfig-1002-20261028    clang-22
arm64                 randconfig-1003-20261025    clang-24
arm64                 randconfig-1003-20261026    clang-24
arm64                 randconfig-1003-20261027    gcc-8.5.0
arm64                 randconfig-1003-20261028    clang-22
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261025    clang-24
csky                  randconfig-1000-20261026    clang-24
csky                  randconfig-1000-20261027    gcc-8.5.0
csky                  randconfig-1000-20261028    clang-22
csky                  randconfig-1001-20261025    clang-24
csky                  randconfig-1001-20261026    clang-24
csky                  randconfig-1001-20261027    gcc-8.5.0
csky                  randconfig-1001-20261028    clang-22
hexagon                           alldefconfig    clang-17
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261025    clang-24
hexagon               randconfig-1000-20261026    clang-24
hexagon               randconfig-1000-20261027    clang-24
hexagon               randconfig-1000-20261028    clang-17
hexagon               randconfig-1001-20261025    clang-24
hexagon               randconfig-1001-20261026    clang-24
hexagon               randconfig-1001-20261027    clang-24
hexagon               randconfig-1001-20261028    clang-17
i386                              alldefconfig    clang-24
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261025    gcc-14
i386        buildonly-randconfig-1000-20261026    clang-22
i386        buildonly-randconfig-1000-20261027    clang-22
i386        buildonly-randconfig-1000-20261028    clang-22
i386        buildonly-randconfig-1001-20261025    gcc-14
i386        buildonly-randconfig-1001-20261026    clang-22
i386        buildonly-randconfig-1001-20261027    clang-22
i386        buildonly-randconfig-1001-20261028    clang-22
i386        buildonly-randconfig-1002-20261025    gcc-14
i386        buildonly-randconfig-1002-20261026    clang-22
i386        buildonly-randconfig-1002-20261027    clang-22
i386        buildonly-randconfig-1002-20261028    clang-22
i386        buildonly-randconfig-1003-20261025    gcc-14
i386        buildonly-randconfig-1003-20261026    clang-22
i386        buildonly-randconfig-1003-20261027    clang-22
i386        buildonly-randconfig-1003-20261028    clang-22
i386        buildonly-randconfig-1004-20261025    gcc-14
i386        buildonly-randconfig-1004-20261026    clang-22
i386        buildonly-randconfig-1004-20261027    clang-22
i386        buildonly-randconfig-1004-20261028    clang-22
i386        buildonly-randconfig-1005-20261025    gcc-14
i386        buildonly-randconfig-1005-20261026    clang-22
i386        buildonly-randconfig-1005-20261027    clang-22
i386        buildonly-randconfig-1005-20261028    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261025    clang-22
i386                  randconfig-1000-20261026    gcc-14
i386                  randconfig-1000-20261027    gcc-14
i386                  randconfig-1001-20261025    clang-22
i386                  randconfig-1001-20261026    gcc-14
i386                  randconfig-1001-20261027    gcc-14
i386                  randconfig-1002-20261025    clang-22
i386                  randconfig-1002-20261026    gcc-14
i386                  randconfig-1002-20261027    gcc-14
i386                  randconfig-1003-20261025    clang-22
i386                  randconfig-1003-20261026    gcc-14
i386                  randconfig-1003-20261027    gcc-14
i386                  randconfig-1004-20261025    clang-22
i386                  randconfig-1004-20261026    gcc-14
i386                  randconfig-1004-20261027    gcc-14
i386                  randconfig-1005-20261025    clang-22
i386                  randconfig-1005-20261026    gcc-14
i386                  randconfig-1005-20261027    gcc-14
i386                  randconfig-1006-20261025    clang-22
i386                  randconfig-1006-20261026    gcc-14
i386                  randconfig-1006-20261027    gcc-14
i386                  randconfig-1007-20261025    gcc-14
i386                  randconfig-1007-20261026    clang-22
i386                  randconfig-1007-20261027    gcc-14
i386                  randconfig-1008-20261025    gcc-14
i386                  randconfig-1008-20261026    clang-22
i386                  randconfig-1008-20261027    gcc-14
i386                  randconfig-1009-20261025    gcc-14
i386                  randconfig-1009-20261026    clang-22
i386                  randconfig-1009-20261027    gcc-14
i386                  randconfig-1010-20261025    gcc-14
i386                  randconfig-1010-20261026    clang-22
i386                  randconfig-1010-20261027    gcc-14
i386                  randconfig-1011-20261025    gcc-14
i386                  randconfig-1011-20261026    clang-22
i386                  randconfig-1011-20261027    gcc-14
i386                  randconfig-1012-20261025    gcc-14
i386                  randconfig-1012-20261026    clang-22
i386                  randconfig-1012-20261027    gcc-14
i386                  randconfig-1013-20261025    gcc-14
i386                  randconfig-1013-20261026    clang-22
i386                  randconfig-1013-20261027    gcc-14
loongarch                         alldefconfig    gcc-16.2.0
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch                 loongson64_defconfig    gcc-16.2.0
loongarch             randconfig-1000-20261025    clang-24
loongarch             randconfig-1000-20261026    clang-24
loongarch             randconfig-1000-20261027    clang-24
loongarch             randconfig-1000-20261028    clang-17
loongarch             randconfig-1001-20261025    clang-24
loongarch             randconfig-1001-20261026    clang-24
loongarch             randconfig-1001-20261027    clang-24
loongarch             randconfig-1001-20261028    clang-17
m68k                              alldefconfig    gcc-16.2.0
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                              allyesconfig    gcc-16.2.0
m68k                           amiga_defconfig    clang-17
m68k                           amiga_defconfig    gcc-16.2.0
m68k                          apollo_defconfig    clang-17
m68k                          apollo_defconfig    clang-24
m68k                        bvme6000_defconfig    gcc-16.2.0
m68k                                 defconfig    clang-24
m68k                         m5272c3_defconfig    gcc-16.2.0
m68k                        m5275evb_defconfig    clang-17
m68k                        m5275evb_defconfig    gcc-16.2.0
m68k                        m5329evb_defconfig    clang-17
m68k                        m5475evb_defconfig    clang-24
m68k                         mvme147_defconfig    clang-17
m68k                         mvme147_defconfig    gcc-16.2.0
m68k                          nettel_defconfig    gcc-16.2.0
microblaze                        alldefconfig    gcc-16.2.0
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                         bcm47xx_defconfig    clang-17
mips                            ci20_defconfig    clang-17
mips                          cobalt_defconfig    gcc-16.2.0
mips                   decstation_64_defconfig    gcc-16.2.0
mips                      decstation_defconfig    gcc-16.2.0
mips                  decstation_r4k_defconfig    gcc-16.2.0
mips                 econet_en751221_defconfig    gcc-16.2.0
mips                            gcw0_defconfig    clang-17
mips                            gcw0_defconfig    clang-24
mips                       loongson1_defconfig    gcc-16.2.0
mips                       maltaaprp_defconfig    clang-17
mips                     maltaup_xpa_defconfig    gcc-16.2.0
mips                            mtx1_defconfig    gcc-16.2.0
mips                         qi_lb60_defconfig    clang-17
mips                           rb532_defconfig    clang-24
mips                            xway_defconfig    gcc-16.2.0
nios2                          3c120_defconfig    clang-24
nios2                             allmodconfig    clang-20
nios2                             allmodconfig    gcc-11.5.0
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261025    clang-24
nios2                 randconfig-1000-20261026    clang-24
nios2                 randconfig-1000-20261027    clang-24
nios2                 randconfig-1000-20261028    clang-17
nios2                 randconfig-1001-20261025    clang-24
nios2                 randconfig-1001-20261026    clang-24
nios2                 randconfig-1001-20261027    clang-24
nios2                 randconfig-1001-20261028    clang-17
openrisc                          alldefconfig    gcc-16.2.0
openrisc                          allmodconfig    clang-20
openrisc                          allmodconfig    gcc-11.5.0
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc                     or1ksim_defconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261025    clang-24
parisc                randconfig-1000-20261026    gcc-14.4.0
parisc                randconfig-1000-20261027    clang-22
parisc                randconfig-1000-20261028    clang-19
parisc                randconfig-1001-20261025    clang-24
parisc                randconfig-1001-20261026    gcc-14.4.0
parisc                randconfig-1001-20261027    clang-22
parisc                randconfig-1001-20261028    clang-19
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                     amigaone_defconfig    gcc-16.2.0
powerpc                      asp8347_defconfig    clang-24
powerpc                       bamboo_defconfig    gcc-16.2.0
powerpc                    currituck_defconfig    clang-17
powerpc                    currituck_defconfig    gcc-16.2.0
powerpc                      ep8248e_defconfig    gcc-16.2.0
powerpc                      mpc5200_defconfig    clang-17
powerpc                      mpc5200_defconfig    clang-24
powerpc                  mpc8313_rdb_defconfig    clang-24
powerpc                mpc834x_itxgp_defconfig    gcc-16.2.0
powerpc                  mpc836x_rdk_defconfig    clang-17
powerpc                      mpc83xx_defconfig    gcc-16.2.0
powerpc                     mvme5100_defconfig    clang-24
powerpc                     mvme5100_defconfig    gcc-16.2.0
powerpc                      powernv_defconfig    gcc-16.2.0
powerpc                       ppc44x_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261025    clang-24
powerpc               randconfig-1000-20261026    gcc-14.4.0
powerpc               randconfig-1000-20261027    clang-22
powerpc               randconfig-1000-20261028    clang-19
powerpc               randconfig-1001-20261025    clang-24
powerpc               randconfig-1001-20261026    gcc-14.4.0
powerpc               randconfig-1001-20261027    clang-22
powerpc               randconfig-1001-20261028    clang-19
powerpc                     sam440ep_defconfig    clang-17
powerpc                      skiroot_defconfig    clang-24
powerpc                      stx_gp3_defconfig    clang-17
powerpc                      tqm8540_defconfig    gcc-16.2.0
powerpc                      tqm8548_defconfig    gcc-16.2.0
powerpc                      tqm8555_defconfig    clang-24
powerpc                      tqm8560_defconfig    clang-17
powerpc                         warp_defconfig    gcc-16.2.0
powerpc64             randconfig-1000-20261025    clang-24
powerpc64             randconfig-1000-20261026    gcc-14.4.0
powerpc64             randconfig-1000-20261027    clang-22
powerpc64             randconfig-1000-20261028    clang-19
powerpc64             randconfig-1001-20261025    clang-24
powerpc64             randconfig-1001-20261026    gcc-14.4.0
powerpc64             randconfig-1001-20261027    clang-22
powerpc64             randconfig-1001-20261028    clang-19
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                     nommu_virt_defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261025    gcc-10.5.0
riscv                 randconfig-1000-20261026    gcc-13.5.0
riscv                 randconfig-1000-20261027    gcc-16.2.0
riscv                 randconfig-1000-20261028    gcc-11.5.0
riscv                 randconfig-1001-20261025    gcc-10.5.0
riscv                 randconfig-1001-20261026    gcc-13.5.0
riscv                 randconfig-1001-20261027    gcc-16.2.0
riscv                 randconfig-1001-20261028    gcc-11.5.0
s390                              alldefconfig    gcc-16.2.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261025    gcc-10.5.0
s390                  randconfig-1000-20261026    gcc-13.5.0
s390                  randconfig-1000-20261027    gcc-16.2.0
s390                  randconfig-1000-20261028    gcc-11.5.0
s390                  randconfig-1001-20261025    gcc-10.5.0
s390                  randconfig-1001-20261026    gcc-13.5.0
s390                  randconfig-1001-20261027    gcc-16.2.0
s390                  randconfig-1001-20261028    gcc-11.5.0
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                          ap325rxa_defconfig    clang-24
sh                          apsh4a3a_defconfig    clang-24
sh                                   defconfig    gcc-14
sh                         dreamcast_defconfig    gcc-16.2.0
sh                         edosk7705_defconfig    gcc-16.2.0
sh                                j2_defconfig    gcc-16.2.0
sh                           r7780mp_defconfig    clang-17
sh                           r7780mp_defconfig    clang-24
sh                    randconfig-1000-20261025    gcc-10.5.0
sh                    randconfig-1000-20261026    gcc-13.5.0
sh                    randconfig-1000-20261027    gcc-16.2.0
sh                    randconfig-1000-20261028    gcc-11.5.0
sh                    randconfig-1001-20261025    gcc-10.5.0
sh                    randconfig-1001-20261026    gcc-13.5.0
sh                    randconfig-1001-20261027    gcc-16.2.0
sh                    randconfig-1001-20261028    gcc-11.5.0
sh                           rsk7201_defconfig    gcc-16.2.0
sh                           rsk7264_defconfig    gcc-16.2.0
sh                            se7343_defconfig    clang-24
sh                            se7712_defconfig    gcc-16.2.0
sh                            se7722_defconfig    gcc-16.2.0
sh                            se7780_defconfig    clang-24
sh                    secureedge5410_defconfig    clang-24
sh                             shmin_defconfig    gcc-16.2.0
sh                             titan_defconfig    gcc-16.2.0
sh                               ul2_defconfig    gcc-16.2.0
sh                           urquell_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261025    gcc-14
sparc                 randconfig-1000-20261026    gcc-14
sparc                 randconfig-1000-20261027    clang-20
sparc                 randconfig-1000-20261028    gcc-12
sparc                 randconfig-1001-20261025    gcc-14
sparc                 randconfig-1001-20261026    gcc-14
sparc                 randconfig-1001-20261027    clang-20
sparc                 randconfig-1001-20261028    gcc-12
sparc                        sparc32_defconfig    gcc-16.2.0
sparc                        sparc64_defconfig    gcc-16.2.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261025    gcc-14
sparc64               randconfig-1000-20261026    gcc-14
sparc64               randconfig-1000-20261027    clang-20
sparc64               randconfig-1000-20261028    gcc-12
sparc64               randconfig-1001-20261025    gcc-14
sparc64               randconfig-1001-20261026    gcc-14
sparc64               randconfig-1001-20261027    clang-20
sparc64               randconfig-1001-20261028    gcc-12
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261025    gcc-14
um                    randconfig-1000-20261026    gcc-14
um                    randconfig-1000-20261027    clang-20
um                    randconfig-1000-20261028    gcc-12
um                    randconfig-1001-20261025    gcc-14
um                    randconfig-1001-20261026    gcc-14
um                    randconfig-1001-20261027    clang-20
um                    randconfig-1001-20261028    gcc-12
um                            x86_64_defconfig    gcc-14
x86_64                            alldefconfig    clang-24
x86_64                            alldefconfig    gcc-16.2.0
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261025    gcc-14
x86_64      buildonly-randconfig-1000-20261026    clang-22
x86_64      buildonly-randconfig-1000-20261027    gcc-14
x86_64      buildonly-randconfig-1000-20261028    clang-22
x86_64      buildonly-randconfig-1001-20261025    gcc-14
x86_64      buildonly-randconfig-1001-20261026    clang-22
x86_64      buildonly-randconfig-1001-20261027    gcc-14
x86_64      buildonly-randconfig-1001-20261028    clang-22
x86_64      buildonly-randconfig-1002-20261025    gcc-14
x86_64      buildonly-randconfig-1002-20261026    clang-22
x86_64      buildonly-randconfig-1002-20261027    gcc-14
x86_64      buildonly-randconfig-1002-20261028    clang-22
x86_64      buildonly-randconfig-1003-20261025    gcc-14
x86_64      buildonly-randconfig-1003-20261026    clang-22
x86_64      buildonly-randconfig-1003-20261027    gcc-14
x86_64      buildonly-randconfig-1003-20261028    clang-22
x86_64      buildonly-randconfig-1004-20261025    gcc-14
x86_64      buildonly-randconfig-1004-20261026    clang-22
x86_64      buildonly-randconfig-1004-20261027    gcc-14
x86_64      buildonly-randconfig-1004-20261028    clang-22
x86_64      buildonly-randconfig-1005-20261025    gcc-14
x86_64      buildonly-randconfig-1005-20261026    clang-22
x86_64      buildonly-randconfig-1005-20261027    gcc-14
x86_64      buildonly-randconfig-1005-20261028    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261025    clang-22
x86_64                randconfig-1000-20261026    clang-22
x86_64                randconfig-1000-20261027    gcc-14
x86_64                randconfig-1000-20261028    clang-22
x86_64                randconfig-1001-20261025    clang-22
x86_64                randconfig-1001-20261026    clang-22
x86_64                randconfig-1001-20261027    gcc-14
x86_64                randconfig-1001-20261028    clang-22
x86_64                randconfig-1002-20261025    clang-22
x86_64                randconfig-1002-20261026    clang-22
x86_64                randconfig-1002-20261027    gcc-14
x86_64                randconfig-1002-20261028    clang-22
x86_64                randconfig-1003-20261025    clang-22
x86_64                randconfig-1003-20261026    clang-22
x86_64                randconfig-1003-20261027    gcc-14
x86_64                randconfig-1003-20261028    clang-22
x86_64                randconfig-1004-20261025    clang-22
x86_64                randconfig-1004-20261026    clang-22
x86_64                randconfig-1004-20261027    gcc-14
x86_64                randconfig-1004-20261028    clang-22
x86_64                randconfig-1005-20261025    clang-22
x86_64                randconfig-1005-20261026    clang-22
x86_64                randconfig-1005-20261027    gcc-14
x86_64                randconfig-1005-20261028    clang-22
x86_64                randconfig-1006-20261025    clang-22
x86_64                randconfig-1006-20261026    gcc-14
x86_64                randconfig-1006-20261027    clang-22
x86_64                randconfig-1006-20261028    gcc-14
x86_64                randconfig-1007-20261025    clang-22
x86_64                randconfig-1007-20261026    gcc-14
x86_64                randconfig-1007-20261027    clang-22
x86_64                randconfig-1007-20261028    gcc-14
x86_64                randconfig-1008-20261025    clang-22
x86_64                randconfig-1008-20261026    gcc-14
x86_64                randconfig-1008-20261027    clang-22
x86_64                randconfig-1008-20261028    gcc-14
x86_64                randconfig-1009-20261025    clang-22
x86_64                randconfig-1009-20261026    gcc-14
x86_64                randconfig-1009-20261027    clang-22
x86_64                randconfig-1009-20261028    gcc-14
x86_64                randconfig-1010-20261025    clang-22
x86_64                randconfig-1010-20261026    gcc-14
x86_64                randconfig-1010-20261027    clang-22
x86_64                randconfig-1010-20261028    gcc-14
x86_64                randconfig-1011-20261025    clang-22
x86_64                randconfig-1011-20261026    gcc-14
x86_64                randconfig-1011-20261027    clang-22
x86_64                randconfig-1011-20261028    gcc-14
x86_64                randconfig-1012-20261025    clang-22
x86_64                randconfig-1012-20261026    gcc-14
x86_64                randconfig-1012-20261027    clang-22
x86_64                randconfig-1012-20261028    gcc-12
x86_64                randconfig-1013-20261025    clang-22
x86_64                randconfig-1013-20261026    gcc-14
x86_64                randconfig-1013-20261027    clang-22
x86_64                randconfig-1013-20261028    gcc-12
x86_64                randconfig-1014-20261025    clang-22
x86_64                randconfig-1014-20261026    gcc-14
x86_64                randconfig-1014-20261027    clang-22
x86_64                randconfig-1014-20261028    gcc-12
x86_64                randconfig-1015-20261025    clang-22
x86_64                randconfig-1015-20261026    gcc-14
x86_64                randconfig-1015-20261027    clang-22
x86_64                randconfig-1015-20261028    gcc-12
x86_64                randconfig-1016-20261025    clang-22
x86_64                randconfig-1016-20261026    gcc-14
x86_64                randconfig-1016-20261027    clang-22
x86_64                randconfig-1016-20261028    gcc-12
x86_64                randconfig-1017-20261025    clang-22
x86_64                randconfig-1017-20261026    gcc-14
x86_64                randconfig-1017-20261027    clang-22
x86_64                randconfig-1017-20261028    gcc-12
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                   audio_kc705_defconfig    gcc-16.2.0
xtensa                 generic_kc705_defconfig    gcc-16.2.0
xtensa                randconfig-1000-20261025    gcc-14
xtensa                randconfig-1000-20261026    gcc-14
xtensa                randconfig-1000-20261027    clang-20
xtensa                randconfig-1000-20261028    gcc-12
xtensa                randconfig-1001-20261025    gcc-14
xtensa                randconfig-1001-20261026    gcc-14
xtensa                randconfig-1001-20261027    clang-20
xtensa                randconfig-1001-20261028    gcc-12
xtensa                          virt_defconfig    gcc-16.2.0
xtensa                     xip_kc705_defconfig    clang-17
xtensa                     xip_kc705_defconfig    gcc-16.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
