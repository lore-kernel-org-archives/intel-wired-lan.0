Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E22CA600C
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 18:38:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0651C81104;
	Thu,  8 Oct 2026 18:38:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dyRtp6Hg9MzR; Thu,  8 Oct 2026 18:38:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 23036813DB
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791484714;
	b=OoFqB071Y1w0kTmXNqcdO8jlFUl3GrcLw3x/bnq7y5AHITkhKpzwUH6y7/yNWfAIoFcx
	 Omh8gBUQ8BJ9nW0VwXRCGdcdmLgs8xuQkv0/22TvpVr0gWYOkcWpNpHoPkan1Z31dEzK5
	 sh8No8vHHqROkW1Co3uAjY2sGtDfefPA8gE75P5x1nJEGkRogJOeF70xxz27Fc0ZjZEGI
	 Y1xJiK40TJKODeVaDLHwortQKH4qUJO8eDaQhqJHV2dlv1jwozI85MIaDnqPGFUoqmZ1U
	 jMODwiv74NskAfkBJUYb3aJxszkd9X5ub73mOLmPGdF6OeocZCG9Ky0C1gn0k50AQDQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791484714;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DyeuqCKJADpKtmnoGLak/yVX2WRt8mQV0SkViTvfMqc=;
	b=maWE6GJY02pBAvR7poeh740yYM4Vj54G8wFehqhrphZWJsoZyqPzrS3GAxKN0QluFPdJ
	 D2r3OkuKd62bqHhgZZKb6HtXv/mY0H4dHGMy3ilzWsY0pKrlGXuEqCCio903EihiT8HOK
	 ZHyeEGORGEhJtpJSfAQSdDRXEE+ms0ncAlESt36tqWOksI7avuHaL+5MMhvPEA2xtcCnV
	 UFGRgykinnpATQvhlnSRGLYtOIu/zk4dBz5i0Z6cwcO2Q3VZWzEj07LoE759EHmkgJvdv
	 uUwysCqPJCKNjoATmRQHP0+wLsSgr0+B3+IuRfOiAvtAWFZ3UO42fknODAMtpN8D/Zg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791484714;
	bh=DyeuqCKJADpKtmnoGLak/yVX2WRt8mQV0SkViTvfMqc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZsHytu46e0QmFAx23og5LjCJD/jb+9O//cmllwB4iEMog4jLbjTliFan3TjbooA4C
	 jZP4AwvfSt/c680ozjIsXYFpY6NaWxnx1KEf1sguLTmlBEdwV7j/rpYJPQB+qa1ByC
	 4uWiv7CGWUwV/r0gvJvlAP4JJ6QtZc1dJLv6VdMyOUuN/DSCpN8CPKGX5h1meOX+kW
	 6ISU53zY0/nC+r70oaA/jL7AStKzwGy3Y8bWbIxGvFN6jqGkqdzlWovqG/LXdGn5bq
	 b8tHoX/u7r1GSHepP5rFEp5Hx8OH780TwQF4LvFdIDI78oBj0h69I3yMkLwzpsVAd4
	 Cs2HogdNZJ1hw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 23036813DB;
	Thu,  8 Oct 2026 18:38:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BD50134E
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 18:38:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AECFF403E7
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 18:38:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iQsjgSMmTxqB for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 18:38:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E4E80403EC
Authentication-Results: smtp2.osuosl.org; arc=fail smtp.remote-ip=198.175.65.10
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791484711;
 b=Ll+VJ+D2QauCK+X6ck+OtpKoS87McJtEPkbirC/Y1MV4/4o3L6L/yW6R3d/VV80cRL59
 F+JhcVAGeXG/UqFE5L5/nmQWFiJ0G6nFAKP1CEIPSCrPhAwYH76x5q5L3KDflyceOEcZD
 vrgycD15hFZXs2XfAB9Ky2pwz5vlMLAR2fgRdMbsypbRrIR2jQtEzobSrwXogKb5Hw5g/
 aMnV4JMRr6gekMNB3FWixj3ttcws9J0rvV3Q0DGteWzu/beDFyhwzwc1o1J/FLL81sjJ3
 yxuBSKwnZHuT8iM3xWD71uIpGJYznSuEADVSyMSuoMreAvB6cQYLrbPep7Lnjg5h3Xw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791484711;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
 References:Content-Type:Content-Disposition:In-Reply-To:
 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=DyeuqCKJADpKtmnoGLak/yVX2WRt8mQV0SkViTvfMqc=;
 b=O6epfmw8DrglTfEda+HRTiQAT+dPyz+/xGofSkuC0jyBJWV1xr1zlFFTeepfEXvo752D
 rrfeJ3IuTRcGeGEoeVCly/QK0Htkcc4BhhQjbWP7v5e+BVb7FB8q82NrsHt58j3sihz6I
 fxreTwVyQOvmizztzXIdKC1lD4jCq4VhOLxWdZnyaqYUGZDWt6tRzMOnGpWSC1uEBwUv0
 oOcn4FzOyeZlFm9/K0j3K5+cxVAzV5wzK398IYOqQadyEAb1xyIGy83qgOIidBXCctGW9
 Qu9MdFE43SpbYFdF1i2c0JXNN7gBTIr7bMmt/k9/SvXXEhbS0VcQ7aH/5vamvyxHOkA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ZQqflhiK; 
 arc=fail smtp.remote-ip=198.175.65.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.10;
 helo=mgamail.intel.com; envelope-from=maciej.fijalkowski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ZQqflhiK
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E4E80403EC
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 18:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791484711; x=1823020711;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=hH96RgC7cdLzKfoXLYA98AbocGuivC/gINu1OcI3h0g=;
 b=ZQqflhiKQbiB2SjK3KMzVDAdu9SiIUBP+wGUT0YflSEG6IYdETcN9NRs
 pWAhMndXIzZXd0ygQn3CN64z5xVC6kjfVt/NAJq8PqRkRT/5JfWX0bKsH
 CanRP3Q5Kxw/04ruaDiYmVn6oQJIMMkxjYCY62k43rxk2+gDFewR2GDAl
 Px3EtOcamUEGL8lgwnSM8QERSbo/KQII5uVRP5MxX8chaQeL+p1YKf+/m
 JE+EcehdJVltvfdL/vuksE+3DgP8oZoLd9T2MLZd2MQGja9goHWl1fWe7
 2sN7ef0r5f+R4sqzdS4aPcFDIgy3m8zssP/qEKa0Ia3/hLae/JJzFlxq7 Q==;
X-CSE-ConnectionGUID: DXfpPkJTSC6tnUmsRVCmCg==
X-CSE-MsgGUID: dOy2VRZNTqyJL+TAk1U4Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="161984"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="161984"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 11:38:29 -0700
X-CSE-ConnectionGUID: IErGYWn5QJyOxTmK/1lYIw==
X-CSE-MsgGUID: N87q79KjQKCFPfObZGfPrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="1872788"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 11:38:30 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 11:38:29 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 11:38:29 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.17) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 11:38:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPvc+CL++qHEyNTWhPWWDUIgsJmYLnjFM9p2QNev4why+mdFNWvioS4Dwt96wB1OHi4AyGm0G95dJ0JJw5nNDqZzb2Foy1W7uVk1QghYFCSYsODhAqpEmi075iv1jH0gcEVkf1W4Wr+oJXL+kiA+vCDUmskA8+Q1VsYUgut87P9WQwSWnVCqnkn1fr2t9Q9v1HWI7gIzStib/Qwzs2Pc++QQMxFWV3nSyQT4+eWVliaen1ZPisZ7sDK/K74/v+Xlu7GOQr/WSPjOUKeJnHfMf/lt/wLDlBuKnn4xsdcEZXLowqXcnJxBWXipjdrMKbao5BzQ/lFA41zv4laJ+CBbzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyeuqCKJADpKtmnoGLak/yVX2WRt8mQV0SkViTvfMqc=;
 b=UGvfVyhVBRGkSMIf4AnR63otSGN+7Z1CpeVzsAYnqZgKnhgo0BYvnIlT7yIX6XFv0265Sjg1lD8Wvr3bZcW907ClnfKzjqRmn2C8Z9NaK7zYyzgbSlTLtZzDQBH9rj8hq27aBz5wBmh4O/VWeOi8HqBbIzRguScOgJ36NVjFOIsLG3jp0PWhaZLn8ed1vICpKhGXPpaRMFWUW4gkYb3Hbp6qUNXydyDOv0XNQoaRWKCyoBvZ85Vz73Krpvbe/BRMoSKtpvecdArFXTVj6f69ou3NNNzva9TKsRIPaBe54f2LBRIUFsCbr5pTsCOq+m6XNkv2nQL/QGsU2jlQrn4iCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CH3PR11MB7914.namprd11.prod.outlook.com (2603:10b6:610:12c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 18:38:26 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 18:38:26 +0000
Date: Thu, 8 Oct 2026 20:38:19 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <magnus.karlsson@intel.com>, <pabeni@redhat.com>, <horms@kernel.org>,
 <przemyslaw.kitszel@intel.com>, <jacob.e.keller@intel.com>
Subject: Re: [PATCH iwl-net] ice: keep the RSS hash function on
 indirection-only updates
Message-ID: <asfjGzjV7scRJpis@boxer>
References: <20261007200311.730443-1-maciej.fijalkowski@intel.com>
 <20261008083412.23481894@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261008083412.23481894@kernel.org>
X-ClientProxiedBy: VIVP296CA0106.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:355::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CH3PR11MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: 050e69cc-71f7-435e-f2cb-08df256b5697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: OpWWA/kLBTwEG91jP57K5PSEwFUU3IhALJh6Jxca+hXhNqim5pyFMBYOsKPhLEGpHn99njrILtssgnbZTl2RO+W1CNh3mwW+dQpLje9SIhlbi455O9icC224XSxD/+YI1Qx0WpUHeUvjhludczqZjWE3ciuUv2cx/jBYMdnKYVL0Mfes4pH1PNB0ZKaK9kRSV1pKWtDa6P/if9LeyKanHtgkfaJHLVJulmMpIgwHu4wKLQ/DxRNTlDXrpyEPBmm2c4LEP0Xl7peMy53BR1I3r7LT0cnJKRvlGBClP5bziY1sYJ2ZltD/UPQooH0P8wQ9UEH1mTjCsr9ruEhDK2O/GlynQ5B3CEIiD+hfcY8sd+lXNXwMYyUEi2bXBk534rAvE1r+q4VOElaZbz10eW+VofF13UM8iZ4tDjAqGyXSu2CYmWeYMCpLGzIyN8vXLkxT6u1A6TWPKHDPtqjhMBQLnfMcWRcE1QOEfB5Th5NsPCJMuX1Vd6tIuOLCqjmrkhdL414OX1BStsEtvmKb7uMA+73rmFFrg+hfYxH4sV1tyY4XGYRU2cPAcwBbmy1FRALHRkBDrQRGuRrKP2tInwUvmjhrr5hI9thuli4DUkPmfAhb38y2G38/N02DAiDNiegX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6117.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C+e9XVoqrzGd3JwBGoo7E/sqlZEZVwwIhiIMgFko8UeiY8AaV4b3gvX0D9mW?=
 =?us-ascii?Q?bx/xhoKTxoKAB5ybKlB5a4/dMeq+kb0yRc+AEc9b1q+jK/oOo4p9mZCzPfXu?=
 =?us-ascii?Q?68ubRkapeGLk07dl0lVhc/2sFb+vKh7uX7DzjbsYASr7y2Rxtb3rBb0Bt368?=
 =?us-ascii?Q?DlMB3s23rlcQcju7QqFM0Q9z5gd9BHoszwor9tapLHHcyC3092cGr6Kqw49V?=
 =?us-ascii?Q?t/9mYFmHSD6uECfjlbXjbZGltyTyXrDxtfopCKAZAibL0/4Tt6CIaxtrHQiP?=
 =?us-ascii?Q?joBX5dspgaa8u08aTtaidGF3eOVlqqxUm2ah+rHJ1oL5XBuBEIUYxvESZtGX?=
 =?us-ascii?Q?ZUqWS5PJVhuLi3F+296+6Q4xHbL3JOIO9rSunlmQ9PF779lehqSVhOlitbKm?=
 =?us-ascii?Q?+Cf+ooTuaQ2YNBHiUTc/7AmxWDQpe4R2OzNkef1/9uKaUn49FkaXxOxOWHSJ?=
 =?us-ascii?Q?fdc6gmWz15+8yFufJ3nGD9c8cJk+7T1vaXqyfWhUe7UufvpsomX0UY7szv0Z?=
 =?us-ascii?Q?tan71SGF+wtCZPSVd6HSUZpm2bfOJ2xeobkxkdSLFp29l2TLdRKc7ob0PvG4?=
 =?us-ascii?Q?9v7ma0Ko7I6Rb33xxfa5bzWtiAKjAHuwY4oivzkzn5odb9fIEvyAE5p8WOcV?=
 =?us-ascii?Q?BLlBuI3dk56FrW5szLh2fXm68OVOTkTOQ2xN4FBDry+W3t3I1jizJ9PRcfZE?=
 =?us-ascii?Q?ajnc7RoUvmFqw8omUhP29J7rtBDfH+jiFvqzZJCxEby5L6CE/zNpexxs5rZm?=
 =?us-ascii?Q?vwAcdU9kKCSHPhmWUP52a+svAlx0o7DjlN7EpXpe1mX+Ym/uCfUqrm+Ks2Cw?=
 =?us-ascii?Q?nKlsx9w/hnlzkQi1/tmZPVvybOh+VJYteLxa0XXn8ssJ2fW5r0infM+QzNOf?=
 =?us-ascii?Q?JhG2S3yJR6bKbeB1/8EpvZuNKBlY8t+jlmtI2k/pOmhCW/l9kghU+injBlK3?=
 =?us-ascii?Q?G2BhHqFI1SpwVNWZiOgEP77gDziOYaUzTItHhh0uN2O2wpwElfHFLT12wRCx?=
 =?us-ascii?Q?7i8nmt1kBHTRSXK95RgiaCsTIL1mWWtLJLVkHNL3gtskku9mANo4mTIH435L?=
 =?us-ascii?Q?dgjgtgT22gvstMlMR5P5o7aW9J9427lW68kX5NnBvn0TVwVvwQ5UdztmWUOy?=
 =?us-ascii?Q?FHS+/nPdNhCIAjKblEr+aGJLL4FFKvkWvtQ6i74Lp8QME4IGYDe2oxL1X7gS?=
 =?us-ascii?Q?Q0NWXemTM4+ffIlspj2rlCTUqVe2UEIGdGWA64WR+BoQao+XSEfReoAodMF2?=
 =?us-ascii?Q?QaIzeI7CBH3MI7K563JRvB9PvE++czCjhe8mjN1JCdTfKP2g4gWqOjCOQqDe?=
 =?us-ascii?Q?n5y6WUlOpmOqKo0Y7ASoEf5BcenFZZN07/lRWGXBtj8gX+eQaKk+Xyu0Nxrq?=
 =?us-ascii?Q?MQ0G6B3WZyrvwUO4xVeT1w31O+w1QO9Mrxtg5jPsQ1asGgzQ2FhBmAvSNCMo?=
 =?us-ascii?Q?2N3Yk2rtHsAHGGw1Cdiu9463XFGCpy2ORG1GV8MODcLzN11I90Zt4qBJo0Tm?=
 =?us-ascii?Q?qdP5xDGIpQadleKsl9B0k1JaoNCyeT+PaVNe4E8AXqBuPV1f263DWrsyTSCI?=
 =?us-ascii?Q?xnezOL679R0PeCA8IrWWwntlcIn7y2QCf4A6TbObmHoGewvk+P+T6HgckfNY?=
 =?us-ascii?Q?zPtFFiY5fBwxABxdH3/07IBbBujU8z2IMizCJxW5XZfjtWD/MGnJeYG/x+h8?=
 =?us-ascii?Q?AfS1JiMAIsHRK5Mhv3rmAQy5ykmKhDEpo+75OxXLWLR/hQZ+jPFZqkPISe4l?=
 =?us-ascii?Q?OwApECwWHSZoSJ+bgWShrxXuC1nxdE8=3D?=
X-Exchange-RoutingPolicyChecked: 0ZcmS6jprVnqUa6DxOHCqjD7Uxl+JKqDm1ZSQvAVJBaOcc4iJJxqLLc2TKF3XVJaigbd5SjJcIFa8iOXEtZdzqXpNmWyLczUjn+hoR19fiaGhnKYo8qWGR/pdWAO6DyiTF6n+/1MEL0zuGIptZ9m5TjoUMSF74zb8QQdNJGC8S2W9G/o/+e8XjihqAYVSLlnOoN8j16qk9nmabEZBlKcESYORv29X2nG1wuFNpc9XaRYMbI59CebBXdhvS09fttV21vuYXMtlDQe4Qj8m3IQY9AYhv+ICLhXbUBrwQ1G9ZmeGwMmrrzX5cQbfO0QuHXKvMpAk3Y9hSXym/xSGjGq8Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 050e69cc-71f7-435e-f2cb-08df256b5697
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 18:38:25.8169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGriigASWm1hZpK2wngGVQ3H9J1X6UwJC8mF47e0OAqD/KxpfZp907TNtIXeYj6gtnOzviUcKGaFD0X5gXDFXq4c0TAnGepDiwW7jZk3G08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7914
X-OriginatorOrg: intel.com
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

On Thu, Oct 08, 2026 at 08:34:12AM -0700, Jakub Kicinski wrote:
> On Wed,  7 Oct 2026 22:03:11 +0200 Maciej Fijalkowski wrote:
> > The ethtool core passes RXH_XFRM_NO_CHANGE (0xff) in input_xfrm when a
> > request does not touch the input transformation, e.g. when it only
> > rewrites the RSS indirection table. ice_set_rxfh() tests input_xfrm only
> > for RXH_XFRM_SYM_XOR, which 0xff has set, so such an update switches the
> > VSI to symmetric Toeplitz hashing behind the user's back.
> > 
> > Once symmetric-xor is reported, the core requires all hashed flow types
> > to be symmetric for any following RSS set. The GTP flow types hash on
> > the TEID, so every later netlink RSS update fails with "hash field config
> > is not symmetric", including the one that would put the indirection
> > table back.
> > 
> > Keep the current hash function when input_xfrm is RXH_XFRM_NO_CHANGE.
> > ice_set_rss_hfunc() then returns early and leaves the VSI as it is.
> > 
> > This has been encountered while trying to run xskxceiver within drv-net
> > tests where one of the setup steps was queue pull out of RSS indirection
> > table.
> > 
> > Fixes: 352e9bf23813 ("ice: enable symmetric-xor RSS for Toeplitz hash function")
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> Hm, not seeing it on the list now but I thought I submitted this 
> a while back:

Hi! This comes from your response where you asked Aleksandr to pull out
this fix out of -next changes and send to -net separately:

https://lore.kernel.org/netdev/20260626152636.1e48330f@kernel.org/

> 
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -3681,10 +3681,10 @@ ice_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
>              struct netlink_ext_ack *extack)
>  {
>         struct ice_netdev_priv *np = netdev_priv(netdev);
> -       u8 hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
>         struct ice_vsi *vsi = np->vsi;
>         struct ice_pf *pf = vsi->back;
>         struct device *dev;
> +       u8 hfunc;
>         int err;
>  
>         dev = ice_pf_to_dev(pf);
> @@ -3703,9 +3703,12 @@ ice_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
>                 return -EOPNOTSUPP;
>         }
>  
> -       /* Update the VSI's hash function */
> -       if (rxfh->input_xfrm & RXH_XFRM_SYM_XOR)
> +       if (rxfh->input_xfrm == RXH_XFRM_NO_CHANGE)
> +               hfunc = vsi->rss_hfunc;
> +       else if (rxfh->input_xfrm & RXH_XFRM_SYM_XOR)
>                 hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_SYM_TPLZ;
> +       else /* input_xfrm == 0; core rejects any other value */
> +               hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
>  
>         err = ice_set_rss_hfunc(vsi, hfunc);
>         if (err)
> 
> Could you double check if we need the trailing else as well? 
> Not 100% sure now if I added it just in case or it mattered :S

else part seems to be just a move from hfunc being initialized to
ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ.

