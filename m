Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D477FC77B73
	for <intel-wired-lan@archiver.kernel.org>; Mon,  5 Jun 2023 04:48:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 76CBB40148;
	Mon,  5 Jun 2023 04:48:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 76CBB40148
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1685940529;
	bh=4aHSg/XnlbdUczwszUGzRsMcmy2TGo/4v0e8ltDV2RY=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Av45INY7dhPKPGILF4ATgQlslGWAv9cDcKkOUs5yPKydd0YtYReT+n7fJV0R1t+CJ
	 FVtjDtZSoVz7j4S5Cy/ME8s9wipuJ1z8qdUaQ3EeqQTaw75/cOuv8HaLQO9PSB58RD
	 Qsm5dQ5NGYiX6599PuXdetNZjUe0S8CaD1P/gfXSFBpTVCziMoPdUxCc7nHXLmyMhA
	 uugi69y2frFl7Nlgt7amHrlzSr0qbKPDfd5mPDUarcO/kSIpHm6fefFucvRPeMe0CS
	 Q3GpisKGkDWMNOkNRiQ0ULPejf2IO34GF3UtcUHc4BRecO1aYFBeoobVXztz2Qokws
	 LoEgZRVAvN9Ow==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V6iYBwZvMUPJ; Mon,  5 Jun 2023 04:48:48 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 44D67402A7;
	Mon,  5 Jun 2023 04:48:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 44D67402A7
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id A09DD1BF423
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Jun 2023 04:48:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 84196410DE
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Jun 2023 04:48:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 84196410DE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oGKSdzMe3ELH for <intel-wired-lan@lists.osuosl.org>;
 Mon,  5 Jun 2023 04:48:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DC94B40A00
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DC94B40A00
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Jun 2023 04:48:44 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="345873285"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; d="scan'208";a="345873285"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2023 21:48:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="778401622"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; d="scan'208";a="778401622"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
 by fmsmga004.fm.intel.com with ESMTP; 04 Jun 2023 21:48:42 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1q6293-0003qp-28;
 Mon, 05 Jun 2023 04:48:41 +0000
Date: Mon, 5 Jun 2023 12:47:52 +0800
From: kernel test robot <lkp@intel.com>
To: Junfeng Guo <junfeng.guo@intel.com>, intel-wired-lan@lists.osuosl.org
Message-ID: <202306051246.jce5ySQm-lkp@intel.com>
References: <20230605022920.2361266-13-junfeng.guo@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230605022920.2361266-13-junfeng.guo@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685940524; x=1717476524;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=98pdvSINUbawiUjSHJxYJ8bhrHjFVnYyicb+/FJ4k8c=;
 b=ksDVGQLKkdgXic1fX3BSw8Ku331YRa5Xk5a/OtVaVIepwAdrdcctRxtm
 zUk0v3mHTHig6KMPCcJY3a0puEzXUL94ODL05Vpoozmwm5QcQMqKHkE+F
 WHXC/o0sKYQA1Se5bhC5o1mUM3sxGHDlhTQTKjGVoeyh9eeh5vwG8lDKc
 7zUI/9b36/TAB65lOMILBBE+uN1cljZbedZoitW7WJ6H/lbjIqDxgpZSj
 00ez+kGOn8oX66Ye4+rYpUfzhqECnQyXRezFj0dfLNeOKzGql8hHGdV3f
 O/YKqSP/LeyALm5rCfsjpSDyrB/KmE650ZhSfCut78qLLAgfUeQFsd4M2
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ksDVGQLK
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 12/15] ice: add parser
 execution main loop
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
Cc: qi.z.zhang@intel.com, oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hi Junfeng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tnguy-next-queue/dev-queue]

url:    https://github.com/intel-lab-lkp/linux/commits/Junfeng-Guo/ice-add-parser-create-and-destroy-skeleton/20230605-103239
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
patch link:    https://lore.kernel.org/r/20230605022920.2361266-13-junfeng.guo%40intel.com
patch subject: [Intel-wired-lan] [PATCH iwl-next 12/15] ice: add parser execution main loop
config: i386-debian-10.3 (https://download.01.org/0day-ci/archive/20230605/202306051246.jce5ySQm-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/fae2352266c3690faee3dbf4ba724c8d28a0873d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Junfeng-Guo/ice-add-parser-create-and-destroy-skeleton/20230605-103239
        git checkout fae2352266c3690faee3dbf4ba724c8d28a0873d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/ethernet/intel/ice/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306051246.jce5ySQm-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/ice/ice_parser.c: In function 'ice_parser_sect_item_get':
>> drivers/net/ethernet/intel/ice/ice_parser.c:98:25: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      98 |         return (void *)((u64)section + data_off + index * size);
         |                         ^
>> drivers/net/ethernet/intel/ice/ice_parser.c:98:16: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
      98 |         return (void *)((u64)section + data_off + index * size);
         |                ^
   drivers/net/ethernet/intel/ice/ice_parser.c: In function 'ice_parser_create_table':
   drivers/net/ethernet/intel/ice/ice_parser.c:149:45: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     149 |                                    (void *)((u64)table + idx * item_size),
         |                                             ^
   drivers/net/ethernet/intel/ice/ice_parser.c:149:36: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     149 |                                    (void *)((u64)table + idx * item_size),
         |                                    ^


vim +98 drivers/net/ethernet/intel/ice/ice_parser.c

6f877e25596c20 Junfeng Guo 2023-06-05   34  
6f877e25596c20 Junfeng Guo 2023-06-05   35  /**
6f877e25596c20 Junfeng Guo 2023-06-05   36   * ice_parser_sect_item_get - parse a item from a section
6f877e25596c20 Junfeng Guo 2023-06-05   37   * @sect_type: section type
6f877e25596c20 Junfeng Guo 2023-06-05   38   * @section: section object
6f877e25596c20 Junfeng Guo 2023-06-05   39   * @index: index of the item to get
6f877e25596c20 Junfeng Guo 2023-06-05   40   * @offset: dummy as prototype of ice_pkg_enum_entry's last parameter
6f877e25596c20 Junfeng Guo 2023-06-05   41   */
6f877e25596c20 Junfeng Guo 2023-06-05   42  void *ice_parser_sect_item_get(u32 sect_type, void *section,
6f877e25596c20 Junfeng Guo 2023-06-05   43  			       u32 index, u32 *offset)
6f877e25596c20 Junfeng Guo 2023-06-05   44  {
6f877e25596c20 Junfeng Guo 2023-06-05   45  	struct ice_pkg_sect_hdr *hdr;
6f877e25596c20 Junfeng Guo 2023-06-05   46  	int data_off = ICE_SEC_DATA_OFFSET;
6f877e25596c20 Junfeng Guo 2023-06-05   47  	int size;
6f877e25596c20 Junfeng Guo 2023-06-05   48  
6f877e25596c20 Junfeng Guo 2023-06-05   49  	if (!section)
6f877e25596c20 Junfeng Guo 2023-06-05   50  		return NULL;
6f877e25596c20 Junfeng Guo 2023-06-05   51  
6f877e25596c20 Junfeng Guo 2023-06-05   52  	switch (sect_type) {
6f877e25596c20 Junfeng Guo 2023-06-05   53  	case ICE_SID_RXPARSER_IMEM:
6f877e25596c20 Junfeng Guo 2023-06-05   54  		size = ICE_SID_RXPARSER_IMEM_ENTRY_SIZE;
6f877e25596c20 Junfeng Guo 2023-06-05   55  		break;
5457ae16bc58a7 Junfeng Guo 2023-06-05   56  	case ICE_SID_RXPARSER_METADATA_INIT:
5457ae16bc58a7 Junfeng Guo 2023-06-05   57  		size = ICE_SID_RXPARSER_METADATA_INIT_ENTRY_SIZE;
5457ae16bc58a7 Junfeng Guo 2023-06-05   58  		break;
6f3e94c8184aa1 Junfeng Guo 2023-06-05   59  	case ICE_SID_RXPARSER_CAM:
6f3e94c8184aa1 Junfeng Guo 2023-06-05   60  		size = ICE_SID_RXPARSER_CAM_ENTRY_SIZE;
6f3e94c8184aa1 Junfeng Guo 2023-06-05   61  		break;
6f3e94c8184aa1 Junfeng Guo 2023-06-05   62  	case ICE_SID_RXPARSER_PG_SPILL:
6f3e94c8184aa1 Junfeng Guo 2023-06-05   63  		size = ICE_SID_RXPARSER_PG_SPILL_ENTRY_SIZE;
6f3e94c8184aa1 Junfeng Guo 2023-06-05   64  		break;
6f3e94c8184aa1 Junfeng Guo 2023-06-05   65  	case ICE_SID_RXPARSER_NOMATCH_CAM:
6f3e94c8184aa1 Junfeng Guo 2023-06-05   66  		size = ICE_SID_RXPARSER_NOMATCH_CAM_ENTRY_SIZE;
6f3e94c8184aa1 Junfeng Guo 2023-06-05   67  		break;
6f3e94c8184aa1 Junfeng Guo 2023-06-05   68  	case ICE_SID_RXPARSER_NOMATCH_SPILL:
6f3e94c8184aa1 Junfeng Guo 2023-06-05   69  		size = ICE_SID_RXPARSER_NOMATCH_SPILL_ENTRY_SIZE;
6f3e94c8184aa1 Junfeng Guo 2023-06-05   70  		break;
017f2b17c37285 Junfeng Guo 2023-06-05   71  	case ICE_SID_RXPARSER_BOOST_TCAM:
017f2b17c37285 Junfeng Guo 2023-06-05   72  		size = ICE_SID_RXPARSER_BOOST_TCAM_ENTRY_SIZE;
017f2b17c37285 Junfeng Guo 2023-06-05   73  		break;
017f2b17c37285 Junfeng Guo 2023-06-05   74  	case ICE_SID_LBL_RXPARSER_TMEM:
017f2b17c37285 Junfeng Guo 2023-06-05   75  		data_off = ICE_SEC_LBL_DATA_OFFSET;
017f2b17c37285 Junfeng Guo 2023-06-05   76  		size = ICE_SID_LBL_ENTRY_SIZE;
017f2b17c37285 Junfeng Guo 2023-06-05   77  		break;
661125652a34c2 Junfeng Guo 2023-06-05   78  	case ICE_SID_RXPARSER_MARKER_PTYPE:
661125652a34c2 Junfeng Guo 2023-06-05   79  		size = ICE_SID_RXPARSER_MARKER_TYPE_ENTRY_SIZE;
661125652a34c2 Junfeng Guo 2023-06-05   80  		break;
7245e027d57290 Junfeng Guo 2023-06-05   81  	case ICE_SID_RXPARSER_MARKER_GRP:
7245e027d57290 Junfeng Guo 2023-06-05   82  		size = ICE_SID_RXPARSER_MARKER_GRP_ENTRY_SIZE;
7245e027d57290 Junfeng Guo 2023-06-05   83  		break;
7245e027d57290 Junfeng Guo 2023-06-05   84  	case ICE_SID_RXPARSER_PROTO_GRP:
7245e027d57290 Junfeng Guo 2023-06-05   85  		size = ICE_SID_RXPARSER_PROTO_GRP_ENTRY_SIZE;
7245e027d57290 Junfeng Guo 2023-06-05   86  		break;
a4e7ee58c72b52 Junfeng Guo 2023-06-05   87  	case ICE_SID_RXPARSER_FLAG_REDIR:
a4e7ee58c72b52 Junfeng Guo 2023-06-05   88  		size = ICE_SID_RXPARSER_FLAG_REDIR_ENTRY_SIZE;
a4e7ee58c72b52 Junfeng Guo 2023-06-05   89  		break;
6f877e25596c20 Junfeng Guo 2023-06-05   90  	default:
6f877e25596c20 Junfeng Guo 2023-06-05   91  		return NULL;
6f877e25596c20 Junfeng Guo 2023-06-05   92  	}
6f877e25596c20 Junfeng Guo 2023-06-05   93  
6f877e25596c20 Junfeng Guo 2023-06-05   94  	hdr = section;
6f877e25596c20 Junfeng Guo 2023-06-05   95  	if (index >= le16_to_cpu(hdr->count))
6f877e25596c20 Junfeng Guo 2023-06-05   96  		return NULL;
6f877e25596c20 Junfeng Guo 2023-06-05   97  
6f877e25596c20 Junfeng Guo 2023-06-05  @98  	return (void *)((u64)section + data_off + index * size);
6f877e25596c20 Junfeng Guo 2023-06-05   99  }
6f877e25596c20 Junfeng Guo 2023-06-05  100  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
