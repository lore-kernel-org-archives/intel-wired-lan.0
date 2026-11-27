Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720A2606A31C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Nov 2026 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=CGbkrH5a;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Siowcb4M
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 45FE3811E3;
	Fri, 27 Nov 2026 15:49:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O9gum3eLc2Fw; Fri, 27 Nov 2026 15:49:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B892A811AB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795794586;
	b=Q93R9f8ZFf2NIXv82+PJtEhizD91gihxg8RrqKQVduqKOlzs2C54fPaokJaGI2wCOubn
	 d+snQ+2s5HrmnRLcNGlSVcQxsW2i0Y2RczFw1xePFP+GHSlksX2vja6mNlr26g70RGAXQ
	 YJA9ocOtlgAo9Ng1BBGNm9Lx0/POLreMAXaHclq/JlDyCaqJI5tNcer5/g2avoRmUz4hg
	 TT88a58FErmxIZjw3blNn7xKvxs01YOZWE8Cd2ygR5NsCGP9mM1vWvFVfZDms8GRbhu7w
	 ToVUMUQs9s4421977DooE+tou/t8cvBF51kFFt90NQGJUkEByU5FuCVMRyLjQz1NnjQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795794586;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MK3FeUwe+4ajkJpyWp+UrFpr8iQf77Aov7cMvruCFlk=;
	b=oqnuYiB4aGvNdgZCZkwUMKEggNfnp6WmnwbjgQy0/ige4D00dif4g9XafT1oaj+F3Zt3
	 FKWl5/VFU70ohm8yalIMG4tRA8tAO0Treq1Uq/XRtjWKrFjHHxEWhqU4OPrbBEBcIE7YR
	 wJMN8MZ4n+ZytcmLY2yTEEm93WSaWtSyvg2NRym8tzTDGwsTrs1RkRpBuyzUTpSTWKTg4
	 dnQ0t5DLeHpx1aII5JnF+yw6UvWOTzW71ivdaCu6Xe/5H7sqQXhrgO7WPibYapombYqUB
	 dDZz+twKebuXTa/P2jnzDrbtULap6ukx1/75b7JuWflqOzm1fhkYyJJWDSbCQicb5Yw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795794586;
	bh=MK3FeUwe+4ajkJpyWp+UrFpr8iQf77Aov7cMvruCFlk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CGbkrH5aiLaiuiKnsDaYBP0m60oxaZwPqt9XQGGFOhmYSvtknh6TfIp4CnBvqLxPz
	 zlnmbxVxaEZ1MoyeBRICOQcLHOYV0ucLHlwb3ukF1SmyYZCpM+6ztW0gTvhhlTs4Tj
	 rO/55qX87fXnRo3kw+ouTngz1pd1AvXDpqbgTMsP8lbcFdyya9c+B33iES/5pVArnw
	 R/EZk5aK41+IZ45WCH4rSz9LECSrQDFt0KcdDMOnujeMMuhZOMb/Zq2Gb++hucB9AZ
	 /cffiyPXx+eD0k0Za1NEI13c+JZoS0qMiwgk3tg2NzQeThIJAHiNzetuI8BcXXFD+f
	 5zkQnc4Grv3tA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B892A811AB;
	Fri, 27 Nov 2026 15:49:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C579826D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 15:49:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AB6B54052C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 15:49:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G_7iDwLqsfQJ for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Nov 2026 15:49:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C50EA40511
Authentication-Results: smtp4.osuosl.org;
 arc=fail smtp.remote-ip=192.198.163.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=maciej.fijalkowski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Siowcb4M
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C50EA40511
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 15:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795794585; x=1827330585;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=GoNKTHQUYTmUsSc6yyAk4DQTkNraJXpwn99cOCL3rpc=;
 b=Siowcb4MgacmThvfMG+HDtUoysiBGbe6Strn8akru7lIHo4qx/22IXv2
 cyA/pvXQuQbQL1pMQznhxZVQkctQeAfV91S68Y5H4GxqAIsyqmqnhWaed
 33QGDyE/80Hm729CJu061PvJY2mSil3vaechYvOZSUwrBfuRKPuZ60Kco
 SXIowTfbWLoD2X7WE5uLfPGZpT/AekkFjgGuleRHtvngCvw0KMa65PJ9R
 CJKQidOhR/o6QYiiC5ELJSdbPzXUa2pBsVKJAOHiqztuDvoQ1rYnpFB0r
 XsLT2p0R1S5HVSvG+BO34/RQ7PFTSGdJvIJ0pdYqCXJ3lVxjhdxN1i/A7 Q==;
X-CSE-ConnectionGUID: lqqpsPdQReqIFUsjpFceeA==
X-CSE-MsgGUID: ALeURbo3Ry+RqxQQzhcNmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4727873"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4727873"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 07:49:42 -0800
X-CSE-ConnectionGUID: e7604/dYRXqQA3mEM5vZxQ==
X-CSE-MsgGUID: Ycrv5VaTTdG+Igd0F/18Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; d="scan'208";a="14186790"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 07:49:42 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 07:49:41 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Fri, 27 Nov 2026 07:49:41 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.47) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 07:49:41 -0800
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by CH3PR11MB976373.namprd11.prod.outlook.com
 (2603:10b6:610:364::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 15:49:38 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 15:49:38 +0000
Date: Fri, 27 Nov 2026 16:49:30 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
CC: Magnus Karlsson <magnus.karlsson@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn
 <willemb@google.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan
 <shuah@kernel.org>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, "Simon
 Horman" <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Larysa Zaremba <larysa.zaremba@intel.com>, Tushar Vyavahare
 <tushar.vyavahare@intel.com>, Jason Xing <kerneljasonxing@gmail.com>,
 "Bastien Curutchet" <bastien.curutchet@bootlin.com>, Colin Ian King
 <colin.i.king@gmail.com>, <intel-wired-lan@lists.osuosl.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net 3/3] selftests/bpf: Drop the zero-copy tailroom from
 the xsk tests
Message-ID: <awmmhuuailYkTtLu@boxer>
References: <20261127142131.3527737-1-bjorn@kernel.org>
 <20261127142131.3527737-4-bjorn@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261127142131.3527737-4-bjorn@kernel.org>
X-ClientProxiedBy: DB9PR02CA0007.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::12) To LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|CH3PR11MB976373:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a13797f-3c7b-43fb-0ef3-08df4c9e0b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|23010399003|10067099003|56012099006|261102123227099003|261026140227099003|261026121527099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261009221227099003|261009223027099003|17002099007|22082099003|18002099003|6133799003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: OghzbOwp5Bm4ZOb2ruKX+NVyvSxTKR6MMyNu2GW6/YsMajsT7c8L8jz/v3fN7PanXbrz1vpWjFIECRo037caqa1G4EqSMaqglZrXmkMhDrZvZ1JRhWxiaaYbGp5pPUY91VAoBgCddJBeL750IGGRfIOLET46SrRV+dFCPNSZnEFyf2RuUvb7enZepUHhv1s6oOJhvCht+R6IbYHX3jH17yNm3m21n/OZHqoV85rGTxB3XZxRLqoUCB7yJ4RN6Ztv+PrZt/tnusnHoh14hNFt87rdleezHq2MqAVdguql61QhlMtcJ6KmG9a81egR8euz1ek3IU1gQ707QN4y5VL2RaPv5bDnmnot4gGpXvNS/AONEXPm+jXZqd2mnIKRLVQjjBRiJRzhk95M8goxw0v7D1Upy9n6gBQVc9twL1p1t8kKEEdRLm8t3rOmBO2ale/vPw2EGba/8svTspw6+G4cDcujAkpO/mweI8RCELvbOllTJFi9IFUEHGfuHHro7UzkbZnN8yWmhv0kDJZ5AVyGLGmbFfVGYyg7flcrmAbKnUEuhUVQmgIGCFPTCQ856sj7UcovPhWe67a/FTPLOMS8tgv1WDOc7zcde90am2RDAhILe9R+SPaVU6lR0l+J1uBRYtYhiBSABMo9xqTJg5Ga8n0w0m3Aqy0Dk1kXT1v8Wjw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB868673.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(23010399003)(10067099003)(56012099006)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009221227099003)(261009223027099003)(17002099007)(22082099003)(18002099003)(6133799003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?CZp3uPec1LePFog0hbHNJL76VeYaPDzFRzBQTIb93or7/sh4oYR4hYgS1J?=
 =?iso-8859-1?Q?3B+kKUX5HqiRXJFcs+u0Ifo472fNDwTQBYvOsvGmzC1eyd260LzX+RX7Rw?=
 =?iso-8859-1?Q?0ZUTlCkD5ripjAwgDy6Q4SQXIc3sZn2iRzCs8JWvrz3o6zsI9koK8SocGd?=
 =?iso-8859-1?Q?ckJlLg2TWgiFe2oRc9q3uyAR0D3C2NNdXRhKDSzLrLV6bS9cHEaaP9kFVg?=
 =?iso-8859-1?Q?Zr7h/5CaGeh4VJc/MT01kIiPFMyZ0yuik30f7Dr0MVDZUGJksMq2UCs/BF?=
 =?iso-8859-1?Q?qMA07jQzqLuJ0zZnPcV/j1hfebSgVWckvzmPSIpC65536NQHc5SBdsVvGJ?=
 =?iso-8859-1?Q?rYAgjtlj7Nc9+5OhoMW08E+gAoj4G8ZKL00iWsaApgBjCM+x5NXcknWdRD?=
 =?iso-8859-1?Q?KYgo/CWI6icLdMPgoy935nlC+wAHUU9DHsA2Q+5i7eVS3ZMH0Y4i4ofG5O?=
 =?iso-8859-1?Q?7SMkfx3Jt4Y43LknkQoNQlYPJ2F5MHpFB4Mew6A/7ME2d5qfKBx+G6F3Tc?=
 =?iso-8859-1?Q?PS2vxRZJaYW18DMTyj3nMa1tE+LDXU2xJNcE/4Qbgsrkhmhfb9YqJzrSGT?=
 =?iso-8859-1?Q?DAbV6lMcrk/UuPUfL9idBm5WWWpnElFljB1LUDCxKML+gtYavnHLRxms4F?=
 =?iso-8859-1?Q?cNagPUF4M1SHWbG5iQcYUAiK7DFnF36g+3UnMwKvIqVY9FS+E9YdJjKN/i?=
 =?iso-8859-1?Q?SR8901gHUE3wkRMAvq3HvHiIFwb7DzbZzEoBL0xj1dwSohw6q8saeQqcNQ?=
 =?iso-8859-1?Q?3ZDhJJLHs+K3kp6wCZ+kVjfevtr6y0pvKtVYTLJsujVxL/OmNBP2d4EfDo?=
 =?iso-8859-1?Q?m8Z2Rfx769X6NvhdHa45U9hJu2dfl31e8+YC4y9e4+XKt6SUBey6PzZWeg?=
 =?iso-8859-1?Q?xsXc3GkUe3yEkCWilJwAoOnOkj8LIXGPdAsQwvhCLMcQIVxz0Vn9MtHjxF?=
 =?iso-8859-1?Q?EYAk9R/87C9tVVdtCxlT7G0m8zJ0HcCCe39rhIjH3Ml6UPjf6BllLxmUuE?=
 =?iso-8859-1?Q?nNAQ/HCvuaOkEIz51CxpzMpXBpqddXYIFMPNfdExCIE0phCpedSo8lFYE5?=
 =?iso-8859-1?Q?MVAX8RYWZHkVnw8OcnLlPpoU20lRQTSuEertGoJ3b/ZV162jL2LFpTJ+TR?=
 =?iso-8859-1?Q?fOggl+nJU69rKxWxOxIibeERwxggenBaPnNsbu2eG095p1vgEqtix0sErs?=
 =?iso-8859-1?Q?LyeL62EywwGXlo8EiE//G5PgVyyYUImIGZNvGaonRlSjkT19mOL0757s4c?=
 =?iso-8859-1?Q?mzC36sQMrbaAfKS7EU4rpwDD77AtLzTaXj4JVyAaf0ewfDb8i/bvmpWNhi?=
 =?iso-8859-1?Q?oiYjlF3YN8N5HD5t8QMn7l02a3nRjCrppXHWNrfmmV/RxAVG2SfgiR/D93?=
 =?iso-8859-1?Q?b8f0j7fn2kC3vCW33ThwLP1lxB7Pv2XDEDj3d1UgqE6jiI3GPMtUAHlHj0?=
 =?iso-8859-1?Q?5vnFoWNs6Tt+0hf6auwBIHOZl8fAyD+UH6L0y0ZW2fT/iYvEpFQL70QoAY?=
 =?iso-8859-1?Q?kRtfRzC9O6tiQeJaOm6ei2OPcrwDW2Ev+BdnnUFnrz1HS2fZH39iKE7tDq?=
 =?iso-8859-1?Q?j0QJFSmpuj106zhsQXhQXGoewgRVJMw1+JQsK3XhUGxWqcnV/cyM49bzDi?=
 =?iso-8859-1?Q?DQoarn1yK9AhogD1WNi3A65N1UbB2fViV4ff6+2jBGDFYc5GFVoAqfjAQQ?=
 =?iso-8859-1?Q?ggiWFbC+GiXqFfttCmzW5vhZfEF87MufAWlwFETsjqfuzc6eSxIhnjONTJ?=
 =?iso-8859-1?Q?FJeMytTFt+EtQK9ctRZ8g5Bfg5mqloCAunxfN2GKxs72R7Vv5XtdQ80kzJ?=
 =?iso-8859-1?Q?mW+IvBI1ydfJPMadxRwjqSdlxwRG/FA=3D?=
X-Exchange-RoutingPolicyChecked: JdtkCx3/NtRv8/MTBf3RXEL2PKhX/Tkz0+fAGfik3ZcTdC2tpKWRv3w1oc/ZvN5e5hih4qiscXbZ4KHO0kWKRj7ks4l1nHKbkryQQCSt1jW+4cuTpOQnaerXe8vvhLzCLaRgOFPjdErofYJUrZb3EwjlO11HkqNIae2tPEUym80WcjmkGaO4XOuIlcydG4skFCl4yVxAnqkCZFwzros139f+pf2I8YcxqbtwiCIUnk6/ELcxCEqcJqmkKgQ8TxzQhrTuOvweprXVT5Opfy2bq3MmByoagiWxplVL9KKPVDOMXVsEj2lAqHIVnNKmrw5bB0DYictJxAyKNNNx5tf3GA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a13797f-3c7b-43fb-0ef3-08df4c9e0b47
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 15:49:38.8539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e28Ny8DgTGhU3whzST1GktzaIklrLX1Ifat6TQt89V3MyxDEb/idBJlwbTZeMjwMAyPS6lkRfMjP9+6ymiiKR4XVZb2hoBdg6VLCVE5tGWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB976373
X-OriginatorOrg: intel.com
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 27, 2026 at 03:21:29PM +0100, Björn Töpel wrote:
> The xsk tests take the size of the shared info off the UMEM headroom
> of RX_DROPPED and off the growth of XDP_ADJUST_TAIL_GROW_MULTI_BUFF,
> as zero-copy multi-buffer pools kept it at the end of each chunk.
> 
> The previous patch moves the shared info into the buffer pool, so the
> UMEM headroom limit and the frame size no longer leave room for it.
> Drop it from both tests.
> 
> Signed-off-by: Björn Töpel <bjorn@kernel.org>
> ---
>  tools/testing/selftests/bpf/prog_tests/test_xsk.c | 10 ++++------
>  tools/testing/selftests/bpf/prog_tests/test_xsk.h |  2 --
>  tools/testing/selftests/bpf/prog_tests/xsk.c      | 13 +------------
>  tools/testing/selftests/bpf/xskxceiver.c          | 15 +--------------

This is based on old xskxceiver location, would it be better to have this
one send to -next out of this set? I assume the move might not have been
back-propagated yet...so seems we would have to double the effort?

>  4 files changed, 6 insertions(+), 34 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> index 4549358cc8c2..7145a36e6ea2 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> @@ -1984,17 +1984,16 @@ int testapp_headroom(struct test_spec *test)
>  int testapp_stats_rx_dropped(struct test_spec *test)
>  {
>  	struct xsk_umem_info *umem = test->ifobj_rx->xsk->umem;
> -	u32 umem_tr = test->ifobj_tx->umem_tailroom;
>  
>  	if (test->mode == TEST_MODE_ZC) {
>  		ksft_print_msg("Can not run RX_DROPPED test for ZC mode\n");
>  		return TEST_SKIP;
>  	}
>  
> -	if (pkt_stream_replace_half(test, (MIN_PKT_SIZE * 3) + umem_tr, 0))
> +	if (pkt_stream_replace_half(test, MIN_PKT_SIZE * 4, 0))
>  		return TEST_FAILURE;
>  	umem->frame_headroom = umem->frame_size -
> -		XDP_PACKET_HEADROOM - (MIN_PKT_SIZE * 2) - umem_tr;
> +		XDP_PACKET_HEADROOM - MIN_PKT_SIZE * 3;
>  	if (pkt_stream_receive_half(test))
>  		return TEST_FAILURE;
>  	test->ifobj_rx->validation_func = validate_rx_dropped;
> @@ -2592,12 +2591,11 @@ int testapp_adjust_tail_grow_mb(struct test_spec *test)
>  	 * pkt_len, expect that it will be broken down to 2 descs each
>  	 * with 3k payload;
>  	 *
> -	 * 4k is truesize, 3k payload, 256 HR, 320 TR;
> +	 * 4k is truesize, 3k payload, 256 HR;
>  	 */
>  	grow_size = XSK_UMEM__MAX_FRAME_SIZE -
>  		    XSK_UMEM__LARGE_FRAME_SIZE -
> -		    XDP_PACKET_HEADROOM -
> -		    test->ifobj_tx->umem_tailroom;
> +		    XDP_PACKET_HEADROOM;
>  	test->mtu = MAX_ETH_JUMBO_SIZE;
>  
>  	return testapp_adjust_tail(test, grow_size, XSK_UMEM__LARGE_FRAME_SIZE * 2);
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.h b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
> index 03753ddc5dcd..1b816226597b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.h
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
> @@ -32,7 +32,6 @@
>  #define USLEEP_MAX			10000
>  
>  #define MAX_SKB_FRAGS_PATH "/proc/sys/net/core/max_skb_frags"
> -#define SMP_CACHE_BYTES_PATH "/sys/devices/system/cpu/cpu0/cache/index0/coherency_line_size"
>  
>  extern bool opt_verbose;
>  #define print_verbose(x...) do { if (opt_verbose) ksft_print_msg(x); } while (0)
> @@ -137,7 +136,6 @@ struct ifobject {
>  	int mtu;
>  	u32 bind_flags;
>  	u32 xdp_zc_max_segs;
> -	u32 umem_tailroom;
>  	u32 max_skb_frags;
>  	bool tx_on;
>  	bool rx_on;
> diff --git a/tools/testing/selftests/bpf/prog_tests/xsk.c b/tools/testing/selftests/bpf/prog_tests/xsk.c
> index 772f3dd7ce64..b3758b9bf2ec 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xsk.c
> @@ -62,7 +62,7 @@ int configure_ifobj(struct ifobject *tx, struct ifobject *rx)
>  
>  static void test_xsk(const struct test_spec *test_to_run, enum test_mode mode)
>  {
> -	u32 max_frags, umem_tailroom, cache_line_size;
> +	u32 max_frags;
>  	struct ifobject *ifobj_tx, *ifobj_rx;
>  	struct test_spec test;
>  	int ret;
> @@ -85,10 +85,6 @@ static void test_xsk(const struct test_spec *test_to_run, enum test_mode mode)
>  		ifobj_tx->set_ring.default_rx = ifobj_tx->ring.rx_pending;
>  	}
>  
> -	cache_line_size = read_procfs_val(SMP_CACHE_BYTES_PATH);
> -	if (!cache_line_size)
> -		cache_line_size = 64;
> -
>  	max_frags = read_procfs_val(MAX_SKB_FRAGS_PATH);
>  	if (!max_frags)
>  		max_frags = 17;
> @@ -96,13 +92,6 @@ static void test_xsk(const struct test_spec *test_to_run, enum test_mode mode)
>  	ifobj_tx->max_skb_frags = max_frags;
>  	ifobj_rx->max_skb_frags = max_frags;
>  
> -	/* 48 bytes is a part of skb_shared_info w/o frags array;
> -	 * 16 bytes is sizeof(skb_frag_t)
> -	 */
> -	umem_tailroom = ALIGN(48 + (max_frags * 16), cache_line_size);
> -	ifobj_tx->umem_tailroom = umem_tailroom;
> -	ifobj_rx->umem_tailroom = umem_tailroom;
> -
>  	if (!ASSERT_OK(init_iface(ifobj_rx, worker_testapp_validate_rx), "init RX"))
>  		goto delete_rx;
>  	if (!ASSERT_OK(init_iface(ifobj_tx, worker_testapp_validate_tx), "init TX"))
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index 7dad8556a722..a385464cfaf8 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -334,7 +334,7 @@ static void print_tests(void)
>  int main(int argc, char **argv)
>  {
>  	const size_t total_tests = ARRAY_SIZE(tests) + ARRAY_SIZE(ci_skip_tests);
> -	u32 cache_line_size, max_frags, umem_tailroom;
> +	u32 max_frags;
>  	struct pkt_stream *rx_pkt_stream_default;
>  	struct pkt_stream *tx_pkt_stream_default;
>  	struct ifobject *ifobj_tx, *ifobj_rx;
> @@ -356,12 +356,6 @@ int main(int argc, char **argv)
>  
>  	setlocale(LC_ALL, "");
>  
> -	cache_line_size = read_procfs_val(SMP_CACHE_BYTES_PATH);
> -	if (!cache_line_size) {
> -		ksft_print_msg("Can't get SMP_CACHE_BYTES from system, using default (64)\n");
> -		cache_line_size = 64;
> -	}
> -
>  	max_frags = read_procfs_val(MAX_SKB_FRAGS_PATH);
>  	if (!max_frags) {
>  		ksft_print_msg("Can't get MAX_SKB_FRAGS from system, using default (17)\n");
> @@ -370,13 +364,6 @@ int main(int argc, char **argv)
>  	ifobj_tx->max_skb_frags = max_frags;
>  	ifobj_rx->max_skb_frags = max_frags;
>  
> -	/* 48 bytes is a part of skb_shared_info w/o frags array;
> -	 * 16 bytes is sizeof(skb_frag_t)
> -	 */
> -	umem_tailroom = ALIGN(48 + (max_frags * 16), cache_line_size);
> -	ifobj_tx->umem_tailroom = umem_tailroom;
> -	ifobj_rx->umem_tailroom = umem_tailroom;
> -
>  	parse_command_line(ifobj_tx, ifobj_rx, argc, argv);
>  
>  	if (opt_print_tests) {
> -- 
> 2.56.1
> 
