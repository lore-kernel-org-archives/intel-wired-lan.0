Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13D9C5B572
	for <intel-wired-lan@archiver.kernel.org>; Thu, 13 Aug 2026 19:13:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 503A760DD2;
	Thu, 13 Aug 2026 19:13:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3uRFykdtCtyZ; Thu, 13 Aug 2026 19:13:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8325360DE0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786648388;
	bh=HgQ8g9iYQlXrVgJq9vO0IiFFz6gWOEY5iwSd5jQYvNc=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=3o96bYytRCFm6juiIesHOabXG7R7mvTCxZnoEcldETiCOTKw7bdg2MmQC99HyNAb3
	 tNtl3lPDsuddOgeeZvA3CHroKbpYY1bKjtwE4UsaA0/4vBEK3yyx+vCMN8h/wjm4xJ
	 wy3tcrJHcxTTveXzsfv0rHTiPZwT63X3ZdS6UKMDwwrQipbeFRbtaN2yCcLJb69DTa
	 Su2r9ClcD6Na/FyLSkBijwwARHBrHePTa362Ckxbg+aiVNXoQsbc26EiSGdA9pcftD
	 TsDTSdDRIDQLTDxximr2H1GonA7OIzP05nGwSSy7tZDu+bb5/uHEDcEjgyVPdcD7mS
	 xi8ChBd3J68Cw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8325360DE0;
	Thu, 13 Aug 2026 19:13:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E88FC194
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 19:13:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CC05840C84
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 19:13:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8EJoeaLSmAyk for <intel-wired-lan@lists.osuosl.org>;
 Thu, 13 Aug 2026 19:13:07 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CCB7540C9D
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CCB7540C9D
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=U1UH/Uj2
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CCB7540C9D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 19:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786648387; x=1818184387; h=date:from:to:subject:message-id;
 bh=M/CKhOaaivbPg3euQ2k+6KZixAIytSNjfbnhXmhskiw=;
 b=U1UH/Uj2/pGsJso1afxBFq2nNPyXmpRqL8jdJl+Kq2klkrlGhjG1AC9y
 LXf5BLLjiK7qOm44oTnY3WP0X9VX5xSj1kCZXmqOsanPgF5FUeaHWtUBQ
 9cIFq1wQeoL9ZLvgDrrxXW3TypkEFH7cCUfRcYG3yR/AcPJ+5C0iXYpdk
 ruH+0VCd7pOOH0kiZDCQw15tbYtdz3PFUB3qqxL6giQCQqCPk0LKu/2sV
 xXHDIrvwwN6P5Qt8o+00yp8xM6/+uOPvuD0eIum/roqJxZ33ONwXBHBcU
 Pd4FvsMi13gMHIf7aATSt5FMal2g3W3F8OHPRR20EpXvJ+RmGFWYfmnZ6 Q==;
X-CSE-ConnectionGUID: ynwo55qjQuW82ZLl04Po/Q==
X-CSE-MsgGUID: uhJOdOa6SNShHdzs7N6J+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87448545"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="87448545"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 12:13:06 -0700
X-CSE-ConnectionGUID: wovrO5pNR/GTjDtyU9NiMA==
X-CSE-MsgGUID: qZktrAxvSVO1iBGQnNu0zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="267518408"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by orviesa003.jf.intel.com with ESMTP; 13 Aug 2026 12:13:06 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wuarP-00000000WIy-2RSA;
 Thu, 13 Aug 2026 19:13:03 +0000
Date: Fri, 14 Aug 2026 03:12:26 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202608140313.yLy6pdT6-lkp@intel.com>
User-Agent: s-nail v14.9.25
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 6ff543fa0ee2e9ac263b5f9b56afb847ab8df06a
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 6ff543fa0ee2e9ac263b5f9b56afb847ab8df06a  e1000e: fix incorrect modified flag check in e1000_read_nvm_spt()

elapsed time: 741m

configs tested: 15
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha              allnoconfig    gcc-16.1.0
alpha             allyesconfig    gcc-16.1.0
alpha                defconfig    gcc-16.1.0
arc               allmodconfig    gcc-16.1.0
arc               allyesconfig    gcc-16.1.0
arm        netwinder_defconfig    gcc-16.1.0
csky              allmodconfig    gcc-16.1.0
i386              allmodconfig    gcc-14
loongarch            defconfig    clang-24
nios2             allmodconfig    gcc-11.5.0
nios2              allnoconfig    gcc-11.5.0
parisc            allmodconfig    gcc-16.1.0
parisc            allyesconfig    gcc-16.1.0
parisc               defconfig    gcc-16.1.0
sh                   defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
