Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213C9C77B60
	for <intel-wired-lan@archiver.kernel.org>; Thu, 30 Mar 2023 15:09:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 984E2605EA;
	Thu, 30 Mar 2023 15:09:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 984E2605EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1680188947;
	bh=4kvHk/RBF2te2/OXuPz9bwER7sLTm9AvjriYkzW7HuI=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=qi4xL57Oak0mdMWRJcY32ADtkbcWfRHD7XunROHCsso0tN7e4UVEZAFmKIvLrjg3X
	 oOiGmvAQQUE5virTZwVmXj+1wmDgRtpIUbARFxmKdC5f5S6HeS2xuxvfY8jJowNmBe
	 VYPuc9mlzYkqRhPfa3h8VsPb42PXuS9mTa5wJA8wRqwYwJ0d+cOETrb1vZAfAvSvHR
	 lONGzbfBX1dS1RgHUEovUl99oyjIWvBrjZNnPvpnWIWP4tj0yNxBxqCI5gnr32kAUj
	 0e+LhW1qxWPCzUn8rRQfDjqrociaKiLKjEFRtJoufeozR9bfzJ+XSu5E9p/9qTxx7P
	 RMYKWLJOECDqg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a176LvBnTTzT; Thu, 30 Mar 2023 15:09:01 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id A291961632;
	Thu, 30 Mar 2023 15:09:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A291961632
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id B20D61BF2CD
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Mar 2023 15:09:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 97EF38123F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Mar 2023 15:09:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 97EF38123F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ihnF5qm05aF9 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 30 Mar 2023 15:08:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 654B8842F8
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 654B8842F8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Mar 2023 15:08:56 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="406183948"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; d="scan'208";a="406183948"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2023 08:06:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="717343222"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; d="scan'208";a="717343222"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
 by orsmga001.jf.intel.com with ESMTP; 30 Mar 2023 08:05:58 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1phtqf-000Kw0-1g;
 Thu, 30 Mar 2023 15:05:57 +0000
Date: Thu, 30 Mar 2023 23:05:13 +0800
From: kernel test robot <lkp@intel.com>
To: Joshua Hay <joshua.a.hay@intel.com>
Message-ID: <202303302334.b3zIhN9j-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1680188936; x=1711724936;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=9X5RJ4c+ptuUM1bme3S23XjEv8J3KsKmGwReVeUc16w=;
 b=bdVvmipz9u42D9Lt67KQvRjSY9ic0ibPH1htg4Q/nAhNHhFqmQ3YStjD
 GkxwF0W+6WANSpxo/qbSwn1Au6q8btwIdR5px1fUVigiXd+5lzAWPw+qe
 2UWVzHosdJK7Pt0hgMYx2zEz8F5IvDaTBDCeSIvdtyVgH0n86Dty1d3tj
 6Nb1Wup1iI1xenO4k+BCikWgdYLnZQwaX1jqkEUh6memggPOniJljlpVK
 jimOEW6hjazs021iw9hE0slfyWCIhx/l5KTsIU9NI54vAZVKdqc7v0cot
 nvB05AFi167gch3v4Ov0xBlibWpK65+5MsB3XtGA8QsEcike78GoqUj8G
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=bdVvmipz
Subject: [Intel-wired-lan] [tnguy-next-queue:10GbE 15/15] htmldocs:
 Documentation/networking/device_drivers/ethernet/intel/idpf.rst: WARNING:
 document isn't included in any toctree
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
Cc: Pavan Kumar Linga <pavan.kumar.linga@intel.com>, linux-doc@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>, oe-kbuild-all@lists.linux.dev,
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
 Phani Burra <phani.r.burra@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 10GbE
head:   e8a488d38e0a75704e37e952fedd329e977df362
commit: e8a488d38e0a75704e37e952fedd329e977df362 [15/15] idpf: configure SRIOV and add other ndo_ops
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git/commit/?id=e8a488d38e0a75704e37e952fedd329e977df362
        git remote add tnguy-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
        git fetch --no-tags tnguy-next-queue 10GbE
        git checkout e8a488d38e0a75704e37e952fedd329e977df362
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303302334.b3zIhN9j-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/networking/device_drivers/ethernet/intel/idpf.rst: WARNING: document isn't included in any toctree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
