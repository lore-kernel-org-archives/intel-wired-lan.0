Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A28606A328
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Nov 2026 23:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=qvoOEdcO;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=disztraN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5C7B40274;
	Wed,  4 Nov 2026 23:11:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eDkWc1pivxTY; Wed,  4 Nov 2026 23:11:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BA2C1403C7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793833867;
	b=E3fs3LbwnCg84mPEGWeq+9Ijp2hZQerAZYgDG5O6g5t12IUA0l3XYmMjV7PU8f6jw4hh
	 +HNZFYqL/0E6g497gyy65SAyUXBBsmqDF2k4+LGxu2sWBIEqGO+nTXxkW3HAAcEN1EA2R
	 Q+wpLPJGCBTNZcP2vrqOags4qd4rmE+QgrAqnKF+hOeMdAeWM6Yk5qP0iWKeSkWzmj+Xy
	 dKHai0TVHdjJPDicO5JmvIIzHJ673t3QBr2pIjWmEY0mPW2plF119gXDp8Va9OzVPyPP4
	 pa0r5MYg5/BFczM40SYxaFKvbd19DNvUgdSijbFozW4FuqcpL2wdG9cbEKBmkGuXsDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793833867;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:CC:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
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
	bh=PXwGsWfbzW2AuTDJWd9zRoeRJzTDU+WGD8TMRSsQDdE=;
	b=cxJ1KzlqOParNreXzfbkoSvbrowbBoivLruGkoa1HsYTcqTwXdWx7MYldtuyAur+L4z4
	 e+rWz+uAx/pub/N2B9S4foTjuY38LL+ulpCS2w7m/807XfgfDkio/eCgEvrEiCwoYAXnG
	 CQkrmQj6S4leya9aWQsoIz1Utviu3TewCOvKpUwPWzrRaz+lLpXNpdVmGcr2JLGmIBQjw
	 lKWjWo2HSiUMxPCwwHmudcs0XUbaqZRaL/1gVI7Lpw4zmO1moWz54+andjXWf6kAGC3mg
	 4XgAZDBU58Rf7pcNeYoKRoOW075iTRnvumSJV8YGCTCKBtgzQ3P0MerMXFOyqE9Vgkw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793833867;
	bh=PXwGsWfbzW2AuTDJWd9zRoeRJzTDU+WGD8TMRSsQDdE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qvoOEdcOisJAM2F/hXsqp0J8vVnvlX1olrYMSfQ5zOLNJQH2elLEUH/XaOawBUSpj
	 xc4KufrZQnkQ9nfrb9ZtOqhly9zKgZde1m4HabahJ92nA1hPCdFO384LEwVzfM9y93
	 3WaTDGs4qaHemS/weQRcKjd7P1VOxsrxwFiL+WoVhBvR1YcpsImnz3LsRI0fzdmWAh
	 pcKbwNKQTNJbOZzNchGE712bXe0U/Z55oT5/Bs10vogZ3hVWEDYxhUzdBTbv+aWHyC
	 J+tRkombBtbYf8laxEL9E8fbnVCDF+JeTPseTKd9VkPjsBUsGZKp9Qi3/kTqhmsXEF
	 WP3gePBTVqE3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA2C1403C7;
	Wed,  4 Nov 2026 23:11:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2277D31F
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 23:11:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 13BCF80EC7
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 23:11:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0X08EKmZuVug for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Nov 2026 23:11:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5A4B080E83
Authentication-Results: smtp1.osuosl.org;
 arc=fail smtp.remote-ip=192.198.163.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=disztraN
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5A4B080E83
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 23:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793833864; x=1825369864;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=l/gUE5FJlyuJ6f4R/fMe9Awpb2pYbtwwM4yLHIwUgBE=;
 b=disztraN+w4KC/s/V43iMbO+e/QjJdX4I6JauEqlWZAs9xKiq3q2caeo
 KNpbPLg1nnWb+J1qtpgzs2DrtKSeAeiy0vT5RhzrK+j4CvxIsfoyAJ5io
 kH7xIX+zZQbk4xvbPeBURIuuGxY2rB76YLn6nfzsaBWRYSIlNLwlUQ9L+
 83DXeVl1MTjFzGXM6y6Wu7YiHV4f0DONGidczPpH1miMxcwV0BfRVXoX3
 G+uH6qsd4JcPuWpDidaW0CazuhierPFSHSTHsqij5IjPBoaFftWsm/V/d
 z1hNB2wnSEaQdZZQ0ZYi6MsNgGfCXIOq7c9m2T2QHgtIiolbo0vxyqjut w==;
X-CSE-ConnectionGUID: kykVTdgmSImbwFrBkPXlHA==
X-CSE-MsgGUID: pwdUGk5UREiYJ2iXgzrfHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2600381"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2600381"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 15:11:03 -0800
X-CSE-ConnectionGUID: N7Y568e0RM2ekYGE+I3Y4A==
X-CSE-MsgGUID: Wurb2z3ST/WHNLS1NKS9Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="6968292"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 15:11:02 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 15:11:01 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 15:11:01 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.18) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 15:11:03 -0800
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by EAYPR11MB414413.namprd11.prod.outlook.com (2603:10b6:303:2fb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 23:10:58 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 23:10:58 +0000
Message-ID: <4b07e441-de15-44f8-a7ff-f67c9c442966@intel.com>
Date: Wed, 4 Nov 2026 15:10:55 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 0/5] ice: fix RTNL vs auxiliary device lock
 inversion
To: Petr Oros <poros@redhat.com>, <netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Dave Ertman
 <david.m.ertman@intel.com>, Mateusz Palczewski
 <mateusz.palczewski@intel.com>, Leon Romanovsky <leon@kernel.org>, "Rafal
 Rogalski" <rafalx.rogalski@intel.com>, Shiraz Saleem
 <shiraz.saleem@intel.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, <intel-wired-lan@lists.osuosl.org>,
 <linux-kernel@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>
References: <20261023070258.730168-1-poros@redhat.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20261023070258.730168-1-poros@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0099.namprd04.prod.outlook.com
 (2603:10b6:303:83::14) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|EAYPR11MB414413:EE_
X-MS-Office365-Filtering-Correlation-Id: d6516aa0-4348-4b74-de62-08df3ac8e2d9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|366016|261021121427099003|11063799006|56012099006|261021123027099003|261009223027099003|261028144727099003|261026121527099003|261022105027099003|261022075727099003|261102123227099003|261026140227099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: vsL8KyA5cCxjgXWcigtcAfJKKserWiBu/V4EWI7qr6aBUMwIs/vGYFXtciQ1NU2+XhpRBErEDpl5CF2YXRTUpe5QAEwPqrQOCW/L+F0RvofJL4hWF2e3HCOKsy8DAg088v7e2mWJUuNej+R/K2HCT94sZZUSFKAVqvgGSiuWu7o1fPMf1SexMTnQEz0oi4GNQlNEBemgpxt2jy6ca7ieF+7y80iS4gLjBWCSrUxOfF0fw+kMm17Tz45/wfnr1YXByh199Eu371fm8kYZju11nTLNYhaPXJkiuHn4PfTkkGZhOu7WDV7nHNWqB8fLew7lZHJrACUdIT38hE26n5vaL3Fhs7jM+d4o7jntMJTgaVscfwWFfG6896JMPgtCY7vXseXCE2imb4Z1CmGrOvJIr2RT/VEezr/O7V33vMcwyyMEngrZGEADfO7ZBBmvt2BiStO1qjaPoAM5MHkdLYJWl8rcLSnB7SptWYTBuqzjEoQnvMMWz1kbB397HKqcL0ypPlITZjVWKxsUNQFkU5tihbHovuDFpbsuManjXfOCrgl1Y/hENJYVVPgYu76Wp76qRuwTF/uvVbBL/sqtjeAKtk33QXskuUCQiXzhokGC1xZtNYZrQMM/b/1somWfJ1/c
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7381.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(261021121427099003)(11063799006)(56012099006)(261021123027099003)(261009223027099003)(261028144727099003)(261026121527099003)(261022105027099003)(261022075727099003)(261102123227099003)(261026140227099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVVCVk5uUlNjMjdhRjV2a3NjcXI3QThjQ3M5Zjg1b2pvY0hFTzlhUW5NSEFx?=
 =?utf-8?B?Umo3a3dqWDhzbDRxUnlNcWxTdzRzVjdPeFNUdG9MTlFIZGZUSHNBREJQYndX?=
 =?utf-8?B?dzRXbzVUY3RKN0s5ekluUEVkTllpQnlydndrdlJDYVh0N3krcDFLd0xSdGIw?=
 =?utf-8?B?V2o2dE9ZM3pRVmFCRjVtbVNvQngvaGUvRVAwdEswcEx1UWlBQnhpcGFpc0Y3?=
 =?utf-8?B?MGxvYnVNeGFicExFalpKSVAxaS9QOHYvQVh5TXY3ZGUrMVFWZlhHM2VsYStF?=
 =?utf-8?B?bER3VkRrc25qMXFyNVBaNnJUUGx3T3dPeUFTVk52ZlpvMHZtek13Q0U4WHNq?=
 =?utf-8?B?T01iWXhhYlh4UC9VVjh5WFNrMm5kWkNDU3l5Q3dwTCtpSmVsRkZJQ2FYdUVp?=
 =?utf-8?B?elFRRVpmbzA2bEViWlpvSlQ2d2w4MWVoVHpqS3B4c0Q3TVBFeXRZS24zK1NP?=
 =?utf-8?B?ZHBaVXMrK1RoM1dYckwwS2Y2d3NJdWkzWkhYVGtEUVc0QUtjQnJnc2l4NFMx?=
 =?utf-8?B?MWE5VUMvb0NJY1lFYVNsK2l0Q1F3YXZ5RENONkJ4V1NCNllhWlF4RGdqUTZn?=
 =?utf-8?B?aWM5V3NkV0RYcEw0MHNXQy92aEZJSUZZUnlobEp0M09PT0piL1I4LzJFTHk0?=
 =?utf-8?B?Vkk4b2FsaWk3TGRHVVVHUVIraGlDb1dlbURqUDNrby91Vkp2NG5FVUFDSmRz?=
 =?utf-8?B?SUFQdDhlMit4MGovV2YxVXYwN1FmUWo5RkVST3JxQmorQzllcUoza2xMREQ5?=
 =?utf-8?B?eEcwd1JPbWJzdHd5SVk4dEE5QnJOc0RDN3crczl6U1N2ZTNKcUF2WGgvMm5R?=
 =?utf-8?B?bmRWNFBjVldZLzNPNnRFenY2TlVQMzNXS0xMNGRESVlSSmlHNXQ5S3A4QXdx?=
 =?utf-8?B?aTRxUlByV054c2pXeU54N0pRSlRGdlJsMkNxR1RHOUlBK01aRDJMTjZMVTJp?=
 =?utf-8?B?Nk1jdGlIR28yNTJyUk9FRG1lS0dUUkRqNzc3MFZ1N3g2eFJqVWd4K0FiZ0J6?=
 =?utf-8?B?azVnMlNkYmZ2YTdENzVWc2N1ejRzWjRTRWhPNU9aRkNqUkZZaVhuYWZCSlJm?=
 =?utf-8?B?cjRjd20xeFNDUldkUHlSUnJ4Rk1WY3Vybk82dkNCV29LaG0vMFVtRTZPazhy?=
 =?utf-8?B?MngrM1VpR2JrcEFUbnMvVExxS0VubmNDRnRhbEpncGpNN3NNV0Fka3labThu?=
 =?utf-8?B?NVA1eU1ZcHZPaExjRkYxOEU0emlZcUk5bWw2S0ZaVExXWGVITVl5dTJjVThD?=
 =?utf-8?B?dXJiNGtaSFBuRktFd3BRNGM1WitNOWluNUZKY2ZpOXUvRS9kMFBwYzVIcU8v?=
 =?utf-8?B?em05c2RWNTRZdGtVaWxJZmhlWSt5YXN6U01BTDRNSjJQNDJpVVdMQnZEeTgz?=
 =?utf-8?B?NmFydHNhMjdHNDNFdzBidERNQXpkQi9PSXhUS21McHR1bzRCYVV4U0VYZjAy?=
 =?utf-8?B?NWNiMGgvNFJNb3JGcDJickdFUHhQN2N4TXhEQmlCUkJNa2hVMkpaa1JYMXpK?=
 =?utf-8?B?d3ZMUnluMFVlSmlWL3QrendXRFRraTJuTFFCcDEvWVEvZFhNaGMyL2VDSXlI?=
 =?utf-8?B?SXhPeDdLRE0wVThCWE01a2R4L2QrL09TUDdPNkZENnA1N3JHN1dLZGQwamJP?=
 =?utf-8?B?SlZtMDJGRWtSaS96bFpPbW5WeTdNb1BxNlhhRko3ekdhckYzMzdZSDkwaE1r?=
 =?utf-8?B?ZEthbWpkTWVaaGhXdUxhTjNxbFMwa0Y3R1BpdmcxWGI1YXUzNTNxWitIUGpx?=
 =?utf-8?B?eFNvUmNScEdpTTdYckUxSk1jVDdEOHFTZGxTTkpSV25NcVhkekdneDJSMjBz?=
 =?utf-8?B?TFdrU09Id1FtdHJIR1hUbkhzK2p6dnowZkk3UERUZFBaUDhvYnR6UkVjcG0v?=
 =?utf-8?B?blpVTSt6bmt1Um1wZ3pGSWJWbkIzRkF3NTJ4KzdPcUJjWFUydDBXVUFjNGQy?=
 =?utf-8?B?am1HZm5EVzBUMThXeXFidVh0RXhZUm5EcDB6ZUlQa3V0UGt0ZEx0Y1NZekYx?=
 =?utf-8?B?TXhTYXpPNTBoOFl1OXpqMXZiZnY2RFozTSt0TU9ZQW9DMlZHU2JGWVBJaVNm?=
 =?utf-8?B?UWRJaVBIaktSQkR3MC9Fa2syYUtPVEo3Y2ZDNm9KamJBSVR6YTlHUDE5dWw0?=
 =?utf-8?B?ZCszUGNrWWluczVDQzh2czBNMi8wNkJkdlUvc0M3Uk14QmFkWU92MExObHox?=
 =?utf-8?B?T2lyM2o5RVE1VTA4L2VSVDk2SS9iUmR4UzV0L0JkeHRyT0cyWEcxczNIVFNU?=
 =?utf-8?B?TjBrTGJvUCtYUWhTVlZTSkc3WDh1Ukx4aG51U1VUejA5dlh5c0hhSmJ5UWVn?=
 =?utf-8?B?S3I1V1RNMzdLYzNQYkFKcjlaeHM2UDdCMkRzUXpvMFdmbnhyei9xaitTQWxN?=
 =?utf-8?Q?u/9xz4ebnXvMZ6ww=3D?=
X-Exchange-RoutingPolicyChecked: RKjJr9hx62I8Thc9cmuX1EIEMVE/l5q4+8OJcIoQMBGj/j635DgZEJrY56hH3sV8MPnpug0SCFuxH1KbarMmVQaCe+T2UFDVKUPTp7OleMhogMMudHNXR3poqeIH4rkAFI/g1+yay7b2J44Vd1kf3wWEg/A1UdpXGuMtue9tg3iRN7Eca6iFWsC6BxX1Q0inQppApgMSxUGrMhosw6fohOMlxe1Qe+rlpiAn7iRhe+ejHIKIyAkOJ8SyuqzxEUJOWFUy99Ho4ftdxk1tamoOa2cT3N6lzolvzo26imvQUmjPskqZ22GuFEihBCFw87NxnG4l0I66f5heewCWHKdJ1w==
X-MS-Exchange-CrossTenant-Network-Message-Id: d6516aa0-4348-4b74-de62-08df3ac8e2d9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 23:10:58.6004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N7OHgaj1g+QqGIpLM0vEPh/ZNt3/1jx5/ufAYiNW/c6CspTeaffzesK9hv1yHr7eY2k1Mh+DzTHwfLnb39IkJgTGiuLEtPpYDwGvQTSKrNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR11MB414413
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_NONE,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/2026 12:02 AM, Petr Oros wrote:
> ice takes the auxiliary device lock of its RDMA auxiliary device from
> three places that run with the RTNL lock held. The RDMA auxiliary probe
> takes the two in the opposite order, because __driver_attach() holds the
> auxiliary device lock across ib_register_device(), which needs the RTNL
> lock. The result is a hard deadlock of everything that needs the RTNL
> lock, so the boot never completes:
> 

Sashiko has a couple of "high" complaints that look plausible to me.
Could you please confirm if you are working on a v3 or respond to the
reports and explain if any of these following issues are faulty reports
from the AI?

> - [High] ice: orphaned channel VSIs and memory leak when ice_setup_tc() fails teardown
> --
> - [High] ice: premature AFTER_TC_CHANGE and unlock before ice_dcb_noncontig_cfg()
> - [High] ice: inconsistent QoS and DCB state on error path in ice_pf_dcb_cfg()
> - [Medium] ice: unrolled state mutations when ice_pf_dcb_cfg() fails with -EBUSY
> --

I've left the series as "new" in the IWL patchwork until I heard one way
or another.

Thanks,
Jake

>   systemd-udevd   state:D
>     really_probe                  <- holds device_lock(&adev->dev)
>     icrdma_probe
>     irdma_ib_register_device
>     ib_register_device
>     setup_device
>     irdma_roce_port_immutable
>     ib_query_port
>     irdma_query_port
>     ib_get_eth_speed              <- blocks on rtnl_lock()
> 
>   lldpad          state:D
>     rtnetlink_rcv_msg             <- holds rtnl_lock()
>     dcb_doit
>     dcbnl_ieee_set
>     ice_dcbnl_setets
>     ice_pf_dcb_cfg
>     ice_send_event_to_aux         <- blocks on device_lock(&adev->dev)
> 
> Lockdep cannot flag it, because device_initialize() marks dev->mutex
> with lockdep_set_novalidate_class(). A PREEMPT_RT kernel with
> CONFIG_DEBUG_RT_MUTEXES reports "rtmutex deadlock detected" instead.
> 
> The probe side cannot be changed, so the three ice callers use
> device_trylock() and refuse the operation with -EBUSY when the driver
> core holds the lock. Patches 1 and 2 are new in v2 and fix two separate
> problems on the same sites, the auxiliary device pointer was tested
> before pf->adev_mutex was taken, and ndo_setup_tc() took pf->adev_mutex
> before pf->tc_mutex while the dcbnl handlers take them the other way
> round. Patch 3 keeps the locks across the whole DCB reconfiguration so
> that BEFORE_TC_CHANGE and AFTER_TC_CHANGE are either both delivered or
> the request is refused before anything changes, and re-arms the service
> task events. Patches 4 and 5 turn the remaining two locks into trylocks.
> 
> The proper fix is provider-owned registration as in i40e and mlx5, which
> makes the inversion impossible by construction. That is a net-next change
> across ice, irdma and iidc_rdma.h, this series is the backportable part.
> 
> Tested on an E810-XXV with two PFs, irdma bound to both auxiliary
> devices, on net tip commit 191aa41548b2d2 ("MAINTAINERS: add Bobby
> Eshleman as vsock reviewer") with and without this series. A reproducer
> binds the irdma auxiliary driver while driving one of the three RTNL
> held callers into the probe window:
> 
>                         without the series   with the series
>   ethtool set_channels  deadlock 10/10       0/10, window entered 300x
>   ndo_setup_tc mqprio   deadlock             0/10, window entered 50x
>   dcbnl ets set         deadlock             0/10, window entered 30x
> 
> A window entry is a contended device_trylock(), so each one used to
> close the cycle. 25 reboots on the patched kernel were clean.
> 
> Changes since v1:
> - new patch 1 for the auxiliary device pointer race
> - new patch 2 for the pf->tc_mutex order in ndo_setup_tc()
> - patch 3 holds the auxiliary device locks across the whole DCB
>   reconfiguration and sends AFTER_TC_CHANGE under them instead of
>   dropping it when the lock is contended, and takes the locks before it
>   consumes pf->oicr_err_reg in the service task
> - patch 5 warns instead of netdev_dbg(), the qdisc teardown ignores the
>   return value
> 
> Link to v1:
> https://lore.kernel.org/all/20261019065301.3983537-1-poros@redhat.com/
> 
> Petr Oros (5):
>   ice: check the auxiliary device pointer under adev_mutex
>   ice: take tc_mutex before the auxiliary device locks in ndo_setup_tc
>   ice: avoid RTNL deadlock when notifying the RDMA auxiliary driver
>   ice: do not block on the aux device lock in ethtool set_channels
>   ice: do not block on the aux device lock in ndo_setup_tc
> 
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 46 ++++++++++++++++---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 26 +++++++----
>  drivers/net/ethernet/intel/ice/ice_idc.c     | 48 ++++++++++++++++----
>  drivers/net/ethernet/intel/ice/ice_idc_int.h |  2 +
>  drivers/net/ethernet/intel/ice/ice_main.c    | 47 +++++++++++++------
>  5 files changed, 130 insertions(+), 39 deletions(-)
> 
> 
> base-commit: 07bd391eb9572e74f073c49acef327611234f9bb

