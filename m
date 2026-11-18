Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86839606A31C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 23:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=nSZG+acs;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d6naZCMx;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=FndjxGAf
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C1E140981;
	Wed, 18 Nov 2026 23:01:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6NAvQHn0iloC; Wed, 18 Nov 2026 23:01:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 54D4B407FA
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795042878;
	b=cG+MQgDa8DYga7T2KHqqJn5ZAE0sW285iw6WEW1nR/Dt4NxYnxFQ8h/IMOnxtbO6ReCk
	 v5twrwALS8UVpWKKoRplu/YxtYtGpyhqJ50AJYjtoLvUIN7gbhYeSjTdnoDcDtuY1PSan
	 YXoXGctW3rbg501OPisY9TtxDdwglOg0BSi8yFZIbGPPUexVMLcXvuanhQ4GbOTgPEfd/
	 4rCbqWP9jBu6gDSVu9OsjXFXDaTZvlyX/QBMaHa+rY0qOFNlM/r2V4JdmUzN8kUMSYvO/
	 QRdr+YaDGl32QC8fArV1bv7Lkrndnay6uc8YrK6qoIw0xpI9Ly0X6sHt9NuBK6z9E1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795042878;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:References:
	 From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
	bh=wN7WHSxL8BiOsH7tnvpm1uYBvuNEZmRLz/3ulweqfBo=;
	b=pha/R+rGkp/5vQqr8LpP05HaPNuYq1UvROMJIsYsHK3DfhCvvfnxrhUxJQvvr/8FwAMU
	 g7lpFJc49kp0itmeWPojIaOeltXibMC+XwBf+Lcg9C1izcHJScFAlpK9XRhMKvfCpvmE9
	 mWNJJC9z/h4z1EBFsP476GwcQhO/8CXVB674Ea89wy+LvL8yH5GykWDHuw9VRa3J+o82t
	 Sxon+lRKFIkzM42IgMy9KOIeVxxqDWlcFiusm6BLBxrygjLttPR/2PoggxOIccaRqTzd6
	 gHDCqGOg8X318CG+vfM1Jebg2vuCf/xJRmdid0lxCUHd+kM48D87z01KGP8l7jeBUMg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d6naZCMx;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=FndjxGAf;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795042878;
	bh=wN7WHSxL8BiOsH7tnvpm1uYBvuNEZmRLz/3ulweqfBo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nSZG+acsyemPk/+wKjtv/d+2EmyfzNRNdjp/BrEeeaqV0uevXoWKNThizvn7ZD660
	 Z2lFAQfdDWxJlPnAAO8jVmpyXuPuhEkmPl3eWILL4ap5tWnWwMF7Db8QW8p9EsHOm7
	 3s1hW4e78Y9jwC/hN5gMMOB7Q3JAW4wFaFKzl3afFvhANTRGIuoZWPfDUAXfOFT0x3
	 IcJkR2p4C3FE2/biu/YB0IoVbMji7ATHP4rhMhQVUbTejTENgtozPSKAOAhnriT/k2
	 h980P7ytXHOTPj/rGy4BqW4dcIrsu8DSvpsAoNdo/1cAHrLdLS/gglVlg5PcDDNXeA
	 6ApiF17LJcTqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 54D4B407FA;
	Wed, 18 Nov 2026 23:01:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 845E4798
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 23:01:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 69C9B407FA
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 23:01:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JMNU0-A166UY for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 23:01:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 624CE406A5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=d6naZCMx; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=FndjxGAf
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 624CE406A5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 23:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795042876; x=1826578876;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WqWJ/cv7vodA5O+dcmMFWEL34bl5RigWaCJ7qeEXAXI=;
 b=d6naZCMxnsMviAFX6S+QdXA6htxeYmH1qtwpJkgrvP5nIe2xOFkz0sEB
 HSWOZsaIGvEYz3RdI74MGhidJiKBlzVpv9SbhvqAEc2xnGllTVafSyZWJ
 Bzoi9mdJa1EnsOMkrKI9wRrXTkS1I3By1gjEIkDphf6+6oDoeC8XS1CfW
 ltWte1YrIJJVZfMIIoRpMXxjnQCBFO9jKkGdCtg0w6lykiz8H3LIKNA03
 P6dhn89LkUmktbK1I+1aQcVTRqIafP5/b5C53Zf5oBaabUT78DanF0eIN
 HoWPOB/qmmc0FA7/ttyCCF5qUEF7hzYUjBfNHMHx7rZm9P3xHNKgyRqfy A==;
X-CSE-ConnectionGUID: nuysv0NMRAGJ/QDl9sjciQ==
X-CSE-MsgGUID: wU2TQcB2QC24FzDlTyJNcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3922784"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3922784"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 15:01:07 -0800
X-CSE-ConnectionGUID: Q7ugPWM/SQ6My1uPTuKKxw==
X-CSE-MsgGUID: GTIuF3qVQuuYUeIlGm+m1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10628386"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 15:01:05 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 15:01:05 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 15:01:05 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.45) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 15:01:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wN7WHSxL8BiOsH7tnvpm1uYBvuNEZmRLz/3ulweqfBo=;
 b=FndjxGAfk2a3DQpfYW4arZSw49om3xgsgtsBM5RUr96y0x4pH8P73yLi7qXrE8LynIGImlhNJbDaZ7TzVFzYwvKGoCYuSZ4fJbDrCXRdVSf2S1t/+D3I0sAyXns++y6luH6BJAHEXyxJ27SsgQsYjOPVNz6hYtuWl/7kQdPHvk8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8451.namprd11.prod.outlook.com (2603:10b6:a03:56e::20)
 by PHXPR11MB9686.namprd11.prod.outlook.com (2603:10b6:510:3ca::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 23:01:00 +0000
Received: from SJ2PR11MB8451.namprd11.prod.outlook.com
 ([fe80::7d5f:b2ba:92d4:5f3c]) by SJ2PR11MB8451.namprd11.prod.outlook.com
 ([fe80::7d5f:b2ba:92d4:5f3c%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 23:01:00 +0000
Message-ID: <0bb65ff3-2e27-4f2e-aaa3-2b8eb7cda356@intel.com>
Date: Wed, 18 Nov 2026 15:00:58 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2026-11-13 (ice)
To: Petr Oros <poros@redhat.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Magnus Karlsson <magnus.karlsson@gmail.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 <edumazet@kernel.org>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
 <horms@kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, "Marcin
 Szycik" <marcin.szycik@linux.intel.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, <intel-wired-lan@lists.osuosl.org>
References: <20261113231225.1864810-1-anthony.l.nguyen@intel.com>
 <20261118115915.116177-1-poros@redhat.com>
 <CAJ8uoz0MMUx68rMZWoZs-JwjodpRixwQSrgpyta1NsanGPn=dg@mail.gmail.com>
 <av2syi6lE/Vp86QW@boxer> <f7f1ae2d-a623-4eb7-a178-c618316beaf5@redhat.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <f7f1ae2d-a623-4eb7-a178-c618316beaf5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0082.namprd04.prod.outlook.com
 (2603:10b6:303:6b::27) To SJ2PR11MB8451.namprd11.prod.outlook.com
 (2603:10b6:a03:56e::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8451:EE_|PHXPR11MB9686:EE_
X-MS-Office365-Filtering-Correlation-Id: 30453b77-8a58-4091-d842-08df45c7cfd1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|7416014|376014|366016|22082099003|261009223027099003|18002099003|11063799006|4143699003|56012099006|261026121527099003|261102123227099003|261028144727099003|261022115727099003|261026140227099003|261021121427099003|261022105027099003|261021135927099003|261022113327099003|261021123027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: Dn6U5Sqa1njatxaUk88u/ueCQFbFuICivkHb5T7JWfPvF8/mZpj5m31WFtb35O948xHeANFTIeWH37ryLoEnKRxLrmDe7PXBk50LZIa1jcsdK1Dg37Z/0wwdSsrVth2ToMDySlu+8R/SgVFvRH1lR8sD6rKbDxz0t8wxTvrbsatsQU2u2Yxa6i1+lofnsxk850K9ay26FYut3poZOsZk8bGzToWuLemllBNHFIIK5u8BGD1jbMIlkYwyWVz+b8Viy0twlpLlSGUoiLuGHXW49MfuQCpbIdl+YbrWbwXvxrvy1093eCynU3/gSu9e2KMUschOafqS0Mqez7iT6g+29IpPxnOyyaWYhHyL7Nwl4tlvn43bvcwLfqK8K4KZmzoiThfKZx2DP/Ap85xO/QGpb0envbvuOgFkkxNuxXgmlR6Wxmqey+DsbHbvFknzkMbIrHk7Cb3W4sUQscSMz8GTTLNCC4qu50SqSfQVOFwrI43hWYs1lN595aosQ9tKf9+7Yqd2XE2lfKbvAa/oi+HoLSyNiV3hGTUfbd5ASus1Q/LpfTZmmvUknlAq6F05nSzYtRFqj4Rv91QUb9MOjXxX2P/0XkFqY5aVD0Jtkexuswyxy3HqfSM6dfiMzGup13+o
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR11MB8451.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(22082099003)(261009223027099003)(18002099003)(11063799006)(4143699003)(56012099006)(261026121527099003)(261102123227099003)(261028144727099003)(261022115727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261021135927099003)(261022113327099003)(261021123027099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWVVeGF1VWxmbGY4VUI1cUpCQlQ4RjN5bjlleWQyNjljaHpqcHdKbVhWakRy?=
 =?utf-8?B?elFYeE1nbmN5bFV1NHVSWHBGdDNmR3YvTXJVSktrbUIyN1Ntd0U4cGl0Qkdo?=
 =?utf-8?B?MVo4ZFB3VEozWVNRK2VhTjZQaGY3TVluTDVFSi83bmJuZzd0aDZpcm1jNThz?=
 =?utf-8?B?bFhGY0Nrd093by9NNk02YTgwWER5RXgySzE5bnJUS2xSM24xR0NVTDhNLzhz?=
 =?utf-8?B?UW14YWlTZHdDanA1QjJ2eEpmeFB0b3BKaDVHQWRmZjd4NkZmZnFWZDBUSGdr?=
 =?utf-8?B?RWhVbE5uWHpTUThRbklJdjB0UlRkbmhlamh0YWR0TE9PNG54NFcyenZvbnVS?=
 =?utf-8?B?V1JGVnl4UmY5YTFDMXd2SzdzWGdXdVJWYnJ2N2Fzbm5Td3VDS2dSUzNNV3Jk?=
 =?utf-8?B?dWRHdWErcHB4eWY2bDlMQjYwb0gzMFd3ZjVjRTNoMVRvZDVTMWlKeVV6cTQ1?=
 =?utf-8?B?ZUo3VkRKRUoybldsbHA4M3ZXY0E4QWR2bGpCUEZTc3pSRFZ3bit0QUFrTHNr?=
 =?utf-8?B?TTg1ZThZd2Z6ZFRwUGRUUkg1UjBQT2pkTUxUMjFTN2ZsMEt4ZFBsMjNsTmpK?=
 =?utf-8?B?MVljSEFybldIbmpPNlo4SzRRblkyWDV6TE0yQTlpYTN2b3J0SmVjamxnNkJS?=
 =?utf-8?B?SkdZcWRtNG1Ob0ZSU2tZQWxiM0ZSbllxSW40ZzFoTE41aEJnUThZalVaWjJn?=
 =?utf-8?B?OTlsRkJQUko1NHhYTHFGUkRXaGt2NmVmM1F4SnlnWm5Yc3NWZzBMaFh4Qmgv?=
 =?utf-8?B?MHNZMm5PQWxIN2lMdEVsbzlpTWRnK1dBc1U1WldEY0lmR0QxVCs0TG1iVTdX?=
 =?utf-8?B?T0NMMFNKM1M2TGpmWmEvYWw5aU5FeFU5Y09wUUdVQjJvdTg4NVl0Sk5ic25x?=
 =?utf-8?B?TjFFT0VxdTU3Zy9vR2w2SjlwT2VmcTlRN3FzUWpJMTVxQTNKa1cyNk1wOExl?=
 =?utf-8?B?VWhBMmxQSWUyUjdQWmx4N1Jta2g4TUJmNEM0NENERGRrbTlSU25BYXBIOUZY?=
 =?utf-8?B?MmZGQUxJZTlsZnE2Ynhzc1Vqeittb3hHRFArR3U2UFExeUQ3eldGbmw5MTJt?=
 =?utf-8?B?T3VuZDNkQ1VNK3MxUWRiUkFpSGwxeWtWbHRxeCtxQ0EvUFdtbXc0MkIzbEY2?=
 =?utf-8?B?THNoQkN6cXNoMGZPRC94TVd6ZXNiUkg3RE5iYzZYVnY3VTFGQmE5dlRFOGo2?=
 =?utf-8?B?ZlBYTkcxVEErRUlPN2szZ212SnFKcnNMdE4xc0h5L0J4N2c1Q3dnS0o0bjVx?=
 =?utf-8?B?MHVyU2YweHV4MDJBVmR6d0ZJN2hySkZSSzJ5Z0tOWHN0S0xhU1hVK2VCVlpI?=
 =?utf-8?B?Ump3eFh6YjN4czdjZVBwY2dEUys4d3NmR3JLNE1TZmNodDd3bWxPWUpIbEZW?=
 =?utf-8?B?SXF5L2FMVkN1OHlmVDB4MCsrTGZmV0tVdzhQLzQ2WnB4RUkxMnFVOUZUZllY?=
 =?utf-8?B?eXRoaThmNWE3OStXRHkrMFZvSjE1cDg4MFIzS0JtWGJVS0lkZDlMejBvemg1?=
 =?utf-8?B?YVFNN1A1c2w0RWtTVXRuOHhhdkZjMWR0MXhEYmk3ZGVkdy9iT2F5VU9LQThC?=
 =?utf-8?B?MEd5TWtBaUF6M3pZc3IzWkdwWUcwdFQzcE82MG1xWUJVNFMxNlltSld0aVNW?=
 =?utf-8?B?dFFQWVhpY3ZnaHAzSnZtRG5WbzhoWTg3bEg1K3AvaXU0bmxkRlZGMUpSTC9p?=
 =?utf-8?B?azd5bUU3Q0hxdlptbHRpWE9HZ0R0VTRKamQ4cFNOVTNRakZYLzlOQVZYUUJN?=
 =?utf-8?B?SzhhK2xvSU9iSERrZzJCZFVLUmZJd0RYV3hOaVZ1WTlOZTZ0VDJsdmE3RzV2?=
 =?utf-8?B?SUZFa2szY0F4ZVdLVURjdjliK3JHbWYyYzArMFdMN0NaR0tVYllLWGd3dFVH?=
 =?utf-8?B?NUlrZnYwcEh0aC92QndrZ3FNTlZveGplV2s0amJPeE4yWFAyTXBMU3pPKysw?=
 =?utf-8?B?VjNxbkRmZ2xOd1dmOENYNGRtWU0zNWhtd00vQUNkTUtpNG9CdEtxYVBzcnRK?=
 =?utf-8?B?dzJYT28wZkI5TENvcTlWNE15WnZ3TERSajdhZ1Q3eXFNL2pxb0QxekZ5a0xV?=
 =?utf-8?B?WjU3YkMvRG5UVTN3akc1STVXMzNZUUJ2b1gvbllzSUZjYmxHa2hqL2ZEbUNa?=
 =?utf-8?B?a3ozbHprVUpXV3lJYzJ6QXptN05JT29KY24yK0hZZUNlUDNVdTZvZk5qSE9C?=
 =?utf-8?B?VHd1aExWTnJtQUxTcmdIYy9XWDdweTZhU3RVYThvNVZ5U3kwcEdwem5SLzNa?=
 =?utf-8?B?Z0RjUE1KU0c5cGx1RFMzUUF3TlA1ZE5EK2lSY1hYNU5SUUh3RnFTMHcveVFm?=
 =?utf-8?B?ekk4SC9oT1N1VnNyOGxGaVl2Z3BlbjZZNTR1eSsrVXRSMUhYcEhwcUtOMUJw?=
 =?utf-8?Q?QrZD9aduirvd5DUo=3D?=
X-Exchange-RoutingPolicyChecked: by+bEeJXE10r1bOwuYW4cxGRMuNQYYWrLQXY5qn0EI3t8n3XdhogmUdwVLUj/dAdAbZJObircTQ/h6bh4ZF9WBhC4HfcZyEMvZLQHodp2nDCgAWVTaIJy0FZaMGuQrEODlaEliJo8TFqsdMqe+FwNLV6LN15lvolYVxLNaLDEdm4sEUnvtD/vVd1pgJJBUVeyCJz2E3oqAP3hNhlMDHqYejW9idGg1UU0FM61hYwsMtBtprGzB70Yt5Gn65AlPW+kw6SDcg6uGxJJ8DA6ZJnh+7QrdBwS3Z8RWZn0FoGEis6SPCenguWqQ1P/bUXAgZzDOamDbt+cT8PJtYHiIB7mg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 30453b77-8a58-4091-d842-08df45c7cfd1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 23:00:59.9783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GnVCOqP9udLN/2OTFXufG/1valj2C1b+TEQb0T20VGDGvhlzxoLo8acqUyDqB2S3Gw3DP5D57NEo7CMMLIpeIPeTXYJbguq13EKicu7eI84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR11MB9686
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/2026 5:51 AM, Petr Oros wrote:
> 
> 
> On 11/18/26 2:48 PM, Maciej Fijalkowski wrote:
>> On Wed, Nov 18, 2026 at 02:37:06PM +0100, Magnus Karlsson wrote:
>>> On Wed, 18 Nov 2026 at 13:00, Petr Oros <poros@redhat.com> wrote:
>>>>
>>>> I think this pull is a good moment to ask how fixes for Intel drivers
>>>> should flow, because it is not the first time a fix spent months on
>>>> intel-wired-lan and then hit a wall on net.
>>>>
>>>> My patches 2/6 and 3/6 have been on intel-wired-lan since June, v4 on
>>>> July 8 [1]. They were reviewed and tested by Intel validation there,
>>>> and four months later Sashiko found real problems in them on this
>>>> pull. I have a v5 and will send it once it is tested.
>>>>
>>>> Jake's E82x timestamp fixes went through three pulls before a part of
>>>> them was applied [2], and Maciej described the same loop on the i40e
>>>> pull in September [3].
>>>>

Part of this is that local Sashiko runs do not seem to mimic the same
results as netdev Sashiko does. Partly this is due to lack of access to
models, and possibly differences from the version netdev runs. I am
still trying to figure out how to get our local setup working within the
netdev fork, but haven't had good success yet.

My series ultimately blocked Tony (and myself while I was covering for
him) from submitting anything else for *months*, due to its size and
scope. This is the result of the 15 patch limit of outstanding
submissions. Because only Tony "officially" submits work to netdev, all
of the Intel drivers are limited to effectively 15 patches per week at
best (assuming 48 hrs to resubmit a new revision after feedback and
needing at least one revision before being accepted, which seems to be
the case these days, if not worse). This is across multiple supported
drivers including ixgbe, i40e, ice, idpf, now ixd, and the client
drivers like igc and e1000e.

>>>> I know Intel patches go through iwl and are not applied to net
>>>> directly [4]. But for fixes it means that the review which decides
>>>> happens on netdev months after the iwl review and validation, and every
>>>> respin goes through both again. And if iwl stops cross-posting to
>>>> netdev, as Jakub suggested [5], Sashiko will see Intel fixes only in
>>>> the pull.
>>>>

Yep. Right now we get reports from Sashiko.dev for Intel Wired LAN but
these only seem to report a *fraction* of what netdev does, and my own
attempts at internal reproduction also fail to reproduce the same
problems while consuming a large part of my allotted token budget. Using
the larger models sometimes helps but rapidly burns my available budget.

>>>> So does the iwl round still make sense for fixes? Would it be better to
>>>> send fixes straight to net with iwl in Cc, and have Tony's ack and the
>>>> Tested-by from Intel validation on netdev?
>>>
>>> Glad you brought this up. IMO, it makes no sense for fixes to go
>>> through iwl and it makes contributing fixes (or new
>>> features/optimizations) a lot more painful. Sometimes even to the
>>> point that you just stop contributing something. I am not in the NIC
>>> team at Intel, but sometimes I have to do network core work that also
>>> touches our drivers. In this case, that patch set goes straight to
>>> net-next (as iwl cannot and should not take core patches), but any
>>> driver fix that I find on the way needs to go to iwl-net so that it
>>> can go to net and be backported. So the fixes that my patch set are
>>> dependent on and that should go in first are instead sent to a
>>> slow-path (i.e. iwl-net) and after X weeks/months appear in net and
>>> then net-next. But my patch set in net-next is dependent on these
>>> fixes so I have to either wait or just cross my fingers that my new
>>> feature is stable enough even without those fixes. Not optimal in my
>>> opinion.
>>>
>>> So anything that could be done to speed up this process would be very
>>> welcome. Sending fixes straight to net would be great. The validation
>>> team could pick those patches up from the list and run the regression
>>> tests against them, or would that take too long?
>>
>> Regarding providing Tested-by tags, could we lift the policy where only
>> Intel validation is allowed to bless the patch? Nowadays with AI regular
>> dev can spin up a nice pile of tests by themselves.
>>
>> So if you send a fix and you can find a peer that will test and review it
>> for you, I don't think we have to wait for validation folks taking
>> care of
>> it if they are swamped.
>>
>> I also don't think it would backfire on us and we would introduce some
>> bloody regressions, given we have {s,cl}ashikos in the pipeline.
> 
> BIG +1
> 

This is really a question for the maintainers. I suspect that they may
not want to increase the number of submissions. Checking now, the
netdevbpf patchwork is already at nearly 1200 patches waiting, with the
oldest being only from the 4th. By contrast, Intel Wired LAN has ~300ish
patches in the queue with the oldest being from March 27th.

Personally, I'd be happy with anything that increases our velocity of
getting fixes out. Frankly, I'm very frustrated by the run around with
Sashiko AI reviews. I do find that the end result has been for a higher
quality, but the delays and difficulties are straining. Its completely
understandable that many other contributors have pulled back as the
burden increase.

Part of the problem is our own mistakes and legacy of poor driver code.
As a result, we're accumulating more fixes than we can submit with the
15 patch limit, and this doesn't seem to be slowing. The rate of
acceptance is certainly not going up. Plus pretty much every bug fix
I've worked on in the last year has come with 2 to 3 other "side quests"
reported by Sashiko that need investigation and development.

I'm not sure what compromise the netdev maintainers would accept, given
they have already repeatedly stated that they're flooded with work.
However, I think Intel Wired LAN is nearly at a breaking point given how
long fixes sit in the queue, blocked while waiting on other priorities.

>>
>>>
>>> Anyway, good initiative. I am sure there is a solution to this that we
>>> will all like.
>>>
>>> /Magnus
>>>
>>>> [1] https://lore.kernel.org/all/20260708125755.706263-1-
>>>> poros@redhat.com/
>>>> [2] https://lore.kernel.org/all/20261021-jk-e825c-timestamp-
>>>> processing-logic-fixes-srcu-v5-0-72289a4ac8eb@intel.com/
>>>> [3] https://lore.kernel.org/all/are4rBUJO3mzrkO8@boxer/
>>>> [4] https://lore.kernel.org/all/20260721174642.7749143e@kernel.org/
>>>> [5] https://lore.kernel.org/all/20260922112216.41e6f8cf@kernel.org/
>>>>
>>>> Regards,
>>>> Petr
>>>>
>>>>
>>
> 

