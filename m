Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F469C77B7A
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Jun 2023 00:59:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E851260B6C;
	Thu,  8 Jun 2023 00:59:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E851260B6C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1686185952;
	bh=iQx8IdObnHKpOPxueR2l7wEB9bz5S/oJ3+tR+V0UKJI=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=G8CXlCx05R8RsUf2mRHcS3lrECTKmFaxlJkhpcGTqiE6BOcFE4PTnyfqfEtrrMez+
	 EwjuJpAHojQzl1wNOzhjEKDnbN3E7x+FkoHhh5gm7RKA0MolHUnopJ+oLunXRz9HIU
	 rVPp5lTJWw9rMs2HZ/10WiH+LNOPLazTdG8JYrocL+LvCNLCiyHGT2BFUG92AC96JA
	 YAgu7XYmdF8N122ymx1SPBHGqaDEnJQ3EQeB7NjY6afv1LuItzrNHGAy0IypeEjKgo
	 SA7+tRlodC3Um2qkRbSEb68Q80LW9kcujA95rSiCYKHfrgePHVhR0MeHrUxCBRMDH9
	 BDdXiL/1EdxqQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s8Ngfi9W0had; Thu,  8 Jun 2023 00:59:11 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1D0A60C20;
	Thu,  8 Jun 2023 00:59:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D1D0A60C20
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id A64E31BF292
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Jun 2023 00:59:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 74E4960C20
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Jun 2023 00:59:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 74E4960C20
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gnwEk2bIQAA3 for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Jun 2023 00:59:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6A54460B6C
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6A54460B6C
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Jun 2023 00:59:07 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="336782144"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; d="scan'208";a="336782144"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2023 17:59:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="799605076"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; d="scan'208";a="799605076"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
 by FMSMGA003.fm.intel.com with ESMTP; 07 Jun 2023 17:59:05 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1q73zV-00073z-0W;
 Thu, 08 Jun 2023 00:59:05 +0000
Date: Thu, 8 Jun 2023 08:58:33 +0800
From: kernel test robot <lkp@intel.com>
To: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>,
 intel-wired-lan@lists.osuosl.org
Message-ID: <202306080833.aw31Lseu-lkp@intel.com>
References: <20230607222443.119-3-paul.m.stillwell.jr@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230607222443.119-3-paul.m.stillwell.jr@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686185948; x=1717721948;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=iKT9SeYaa9aMV1hxaKdQBc+gTC22IMQ7/Sqhx6s+exc=;
 b=EMAcM4ZfEbr9fHLLrhMLU8DU+XFLvAQZomRjY2y8meFdPd7cotoh4EfN
 QD0t1+QLExnjmkzTnAlpKK/xeuHi5lmjSdrrJrTzFDn7KGio1Ki++3Iuw
 RnHW5CgBeagZ/cYADxioj/xuGQrP3Nwi61Tz49n0oOQvzXm5Jh077DU+4
 LqSJYCS1shSRwU1XqX60D+UwUDOGZlyzwBkn19933i+otCADWqBbN8HQ4
 rrtAfSs/ss4BaqkZIJwk8JHdLeKWyAtomBcMTijgrLh2Eb7JQNpRu2FCd
 0Ooe+pCcY29P6okIGAHxsNG93kVyDnkBO6jXgX7zzXT1st1w7Vv0VruWq
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=EMAcM4Zf
Subject: Re: [Intel-wired-lan] [PATCH net-next v12 2/4] ice: configure FW
 logging
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
Cc: oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hi Paul,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Paul-M-Stillwell-Jr/ice-remove-FW-logging-code/20230608-062658
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230607222443.119-3-paul.m.stillwell.jr%40intel.com
patch subject: [Intel-wired-lan] [PATCH net-next v12 2/4] ice: configure FW logging
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230608/202306080833.aw31Lseu-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build):
        git remote add net-next https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
        git fetch net-next main
        git checkout net-next/main
        b4 shazam https://lore.kernel.org/r/20230607222443.119-3-paul.m.stillwell.jr@intel.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/ethernet/intel/ice/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306080833.aw31Lseu-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/intel/ice/ice_debugfs.c:504:37: warning: 'ice_debugfs_enable_fops' defined but not used [-Wunused-const-variable=]
     504 | static const struct file_operations ice_debugfs_enable_fops = {
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~


vim +/ice_debugfs_enable_fops +504 drivers/net/ethernet/intel/ice/ice_debugfs.c

   503	
 > 504	static const struct file_operations ice_debugfs_enable_fops = {
   505		.owner = THIS_MODULE,
   506		.open  = simple_open,
   507		.read = ice_debugfs_enable_read,
   508		.write = ice_debugfs_enable_write,
   509	};
   510	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
