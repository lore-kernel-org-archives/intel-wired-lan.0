Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5134C77B60
	for <intel-wired-lan@archiver.kernel.org>; Fri, 31 Mar 2023 18:24:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5364084603;
	Fri, 31 Mar 2023 18:24:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5364084603
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1680287042;
	bh=PQEGDueiN3dX7hYyGX1icxxssUJqqVCsSJNqBCzLNXU=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=zT0g30h+P9HEPfA2GztGY1H9E5JNO70+W1fcFyKOZ4jEIz9v7JgwpbwTPObcctiQA
	 xBelcTjUivygfb/QrHchPzdx2tqH1EZYxeeOp0i3PBUxTfCk8HQhx8xwNJEClRoLhW
	 1Dl/DFgqhNzDH4xcOwW3qVEEPI26x9Wmg1MBRr4o6IhVupazzwRhw3RqRJdUndwcCk
	 wotuN6uLm9bSXouOufBW6G8F8G6Pnr6oIOrcj0mAl9op7goRI/D1kFIMBcxsEO2cgq
	 DMv3rwh9gjoMNP8p16+FIBH9C5oPW7rVnTtQtdhz4y436xdtRc6Q2JZWIzIxGgNJOq
	 xheNJmc1AnEZA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eh45iyX9VvJi; Fri, 31 Mar 2023 18:24:01 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52294845F4;
	Fri, 31 Mar 2023 18:24:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 52294845F4
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 6C8101BF3D4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Mar 2023 18:24:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 431954186A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Mar 2023 18:24:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 431954186A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id izTYQhVttFZo for <intel-wired-lan@lists.osuosl.org>;
 Fri, 31 Mar 2023 18:23:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8930A417EA
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8930A417EA
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Mar 2023 18:23:58 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="406551723"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; d="scan'208";a="406551723"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2023 11:23:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="717827064"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; d="scan'208";a="717827064"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
 by orsmga001.jf.intel.com with ESMTP; 31 Mar 2023 11:23:50 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1piJPh-000M2G-1G;
 Fri, 31 Mar 2023 18:23:49 +0000
Date: Sat, 1 Apr 2023 02:23:03 +0800
From: kernel test robot <lkp@intel.com>
To: Jesper Dangaard Brouer <brouer@redhat.com>, bpf@vger.kernel.org,
 Stanislav Fomichev <sdf@google.com>,
 Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Message-ID: <202304010239.Jw6bKkWC-lkp@intel.com>
References: <168027498690.3941176.99100635661990098.stgit@firesoul>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <168027498690.3941176.99100635661990098.stgit@firesoul>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1680287037; x=1711823037;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=RfULin+IQkEIXF2U8/tMLOvTdsd0rNfXguvY06ABEEY=;
 b=SzKZrMMg1tet+P/nflM5Y9vcpYQ/OYC+mdzq0wB4c9B3XYmWbzBjbzNs
 TxWem+ebaZSqEiOhuiF9wGTR6FQF1uNpb4nxfTJ4VdJ4Ri+0NX6K75kdZ
 at5U/xASqkNB768bqXr2jQRAWR2REmFVgj4Bww0APMgF+TPEAxcM17uP6
 qu6OGragHww2NUaWKulKcQgXB+fE1Rt7zdoQyIayb0XwDS7AAgAWE5Jse
 f0Coe6b7C/+TZ1q8jtPkmCRtStUnSwRnxRAZNZt78EIcoClU+VbeBTN0p
 vYFB4VBoG6hl6AoHhpE0ou1mgJXM6QyzBgque4oDjb23S7BwV8tY2TU0t
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=SzKZrMMg
Subject: Re: [Intel-wired-lan] [PATCH bpf V4 1/5] xdp: rss hash types
 representation
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
Cc: ast@kernel.org, edumazet@google.com, anthony.l.nguyen@intel.com,
 boon.leong.ong@intel.com, hawk@kernel.org, xdp-hints@xdp-project.net,
 daniel@iogearbox.net, john.fastabend@gmail.com, jesse.brandeburg@intel.com,
 intel-wired-lan@lists.osuosl.org, Jesper Dangaard Brouer <brouer@redhat.com>,
 kuba@kernel.org, pabeni@redhat.com, martin.lau@kernel.org,
 larysa.zaremba@intel.com, oe-kbuild-all@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, tariqt@nvidia.com,
 yoong.siang.song@intel.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hi Jesper,

I love your patch! Yet something to improve:

[auto build test ERROR on bpf/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Jesper-Dangaard-Brouer/xdp-rss-hash-types-representation/20230331-230552
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
patch link:    https://lore.kernel.org/r/168027498690.3941176.99100635661990098.stgit%40firesoul
patch subject: [PATCH bpf V4 1/5] xdp: rss hash types representation
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20230401/202304010239.Jw6bKkWC-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9fcbbefa76e6e88a86426d13ed79ea24aacffe76
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jesper-Dangaard-Brouer/xdp-rss-hash-types-representation/20230331-230552
        git checkout 9fcbbefa76e6e88a86426d13ed79ea24aacffe76
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304010239.Jw6bKkWC-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/veth.c:1685:43: error: initialization of 'int (*)(const struct xdp_md *, u32 *, enum xdp_rss_hash_type *)' {aka 'int (*)(const struct xdp_md *, unsigned int *, enum xdp_rss_hash_type *)'} from incompatible pointer type 'int (*)(const struct xdp_md *, u32 *)' {aka 'int (*)(const struct xdp_md *, unsigned int *)'} [-Werror=incompatible-pointer-types]
    1685 |         .xmo_rx_hash                    = veth_xdp_rx_hash,
         |                                           ^~~~~~~~~~~~~~~~
   drivers/net/veth.c:1685:43: note: (near initialization for 'veth_xdp_metadata_ops.xmo_rx_hash')
   cc1: some warnings being treated as errors


vim +1685 drivers/net/veth.c

4456e7bdf74c9f Stephen Hemminger  2008-11-19  1682  
306531f0249f4e Stanislav Fomichev 2023-01-19  1683  static const struct xdp_metadata_ops veth_xdp_metadata_ops = {
306531f0249f4e Stanislav Fomichev 2023-01-19  1684  	.xmo_rx_timestamp		= veth_xdp_rx_timestamp,
306531f0249f4e Stanislav Fomichev 2023-01-19 @1685  	.xmo_rx_hash			= veth_xdp_rx_hash,
306531f0249f4e Stanislav Fomichev 2023-01-19  1686  };
306531f0249f4e Stanislav Fomichev 2023-01-19  1687  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
