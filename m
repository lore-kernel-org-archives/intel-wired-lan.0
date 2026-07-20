Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC78C44515
	for <intel-wired-lan@archiver.kernel.org>; Mon, 20 Jul 2026 08:13:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 03B1280BE8;
	Mon, 20 Jul 2026 08:13:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m8sptY-UgAET; Mon, 20 Jul 2026 08:13:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 125ED80BDF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784535203;
	bh=a5/0yKA5eRQd6obFnYAzxMXqs27lwdfUYTm2vjSHH5c=;
	h=Date:To:CC:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SAFPwr4EjR0x0PsW838QUdVs/NTEOOHSO1ec2cp6NCdnwg0wLBG1wLfMBkoNK9BTO
	 vFsT4QyLOIcMATWN+SbmL1LGuQHcKuj7p9H66198CLlDFXJAhlCqzR6MfKv7Jdsvgk
	 8ftRSN0sr0YfjW5EvjgTXkYIODq7TJhilG5hSYnSfPx/TS1Yjb/IFD0Izoy6Q5DQRB
	 yV2ALibJgNKoY6GG4SPXOQQJwpaxJDeiIbTw97/gJATn9kxKH4q0fNS2B+mIp6rK5f
	 D2q5CZNI4uJ6BphTUky380mrNOCHag31ApYGZpUdhjZvBMLTyLxG0pB65FVtqCykTD
	 hpZKd7rmSwl1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 125ED80BDF;
	Mon, 20 Jul 2026 08:13:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 28DE7282
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 08:13:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A9BF40500
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 08:13:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8P4CiVWRR17a for <intel-wired-lan@lists.osuosl.org>;
 Mon, 20 Jul 2026 08:13:21 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=moriyax.kadosh@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4DDC2404EC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4DDC2404EC
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4DDC2404EC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 08:13:21 +0000 (UTC)
X-CSE-ConnectionGUID: ADgUlMWRSvyxVt3/9hdVog==
X-CSE-MsgGUID: 6NeHRY7XRwGHRlYy3ivScA==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="72645607"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="72645607"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 01:13:20 -0700
X-CSE-ConnectionGUID: cp/PxkKUQFKdxIXKAua4/g==
X-CSE-MsgGUID: Ldpub406QMmPJBFAr1w9CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="253021540"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 01:13:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 01:13:20 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 01:13:20 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.34) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 01:13:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7MxepK9nGxui+9CtNxfj9rvqOt6PCLLuO+bC7v1TlVnfgDvJjW95dlnACOviZnLu1fxdNjt9B+pslGM1C+RHnK8iHEn2grb+OD4V3Jn1OZaO0aYEJI89j6WYlEVOw3RGvtVFc0AcwtUob5uvzuivxNRCOPxIcBrmE0utEDKiR6b7nDX5Ijo0GBjanHyU9Lim7uUfvl9cpJ8I1c66cvr/H/oaI97El2WGwglmm5mr0B0raIVpYG/B0vBX3gBYT3a5Mku7TMcP0/AKjQQd2M+4f3pzaAzrcTi2K0PX4IECUvBlxJSfjrLsJ9+tZKoDX6AlLrvNpzLSWYfIwnOzgTakA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5/0yKA5eRQd6obFnYAzxMXqs27lwdfUYTm2vjSHH5c=;
 b=fyNGpxYSyiq9ltMRy8xQ6qFk56LHKT1mEVi6wWnNl+L50a6hyGcus0OiO1xwpwkyBU3oCgzDL9KLvikO95dmpqf3vSq/Ts278IGm4/TpLJ9ez9XYXnGfCkeUKBV2y668kmR6MNOD1c6YVhW922P7JponGUCupGE/b+nH9L57QZ6hmuQ5FPJMGfTx/7+urIXlWGASYY4USEmTG0xesttsgb9A3gGuf6EeghnsMJwezjTPgodf/+y+qIB1lJTCzrs9LyB+sndq1GdVOvCHm4WOWKvWLOE+Fvw9P7GdNRAzv2yc+3S10RmcTAmu9xLSw7/h+lv4PQpFzuXDJAePdNDtGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB8448.namprd11.prod.outlook.com (2603:10b6:806:3a3::17)
 by SA0PR11MB4623.namprd11.prod.outlook.com (2603:10b6:806:95::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 08:13:16 +0000
Received: from SA1PR11MB8448.namprd11.prod.outlook.com
 ([fe80::38f:6a4:ce6b:d5b8]) by SA1PR11MB8448.namprd11.prod.outlook.com
 ([fe80::38f:6a4:ce6b:d5b8%6]) with mapi id 15.21.0223.011; Mon, 20 Jul 2026
 08:13:16 +0000
Message-ID: <2f288130-0d79-4038-b7e8-8580c249c386@intel.com>
Date: Mon, 20 Jul 2026 11:13:05 +0300
User-Agent: Mozilla Thunderbird
To: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, David Carlier <devnexen@gmail.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
 <aleksandr.loktionov@intel.com>, <advoretsky@gmail.com>,
 <stable@vger.kernel.org>
References: <20260712132242.223254-1-devnexen@gmail.com>
 <alSzCokS7scCoza7@boxer> <c477f099-c365-496a-bb5c-ae8d27d7916f@intel.com>
Content-Language: en-US
From: "Kadosh, MoriyaX" <moriyax.kadosh@intel.com>
Organization: Intel Israel (74) Limited
In-Reply-To: <c477f099-c365-496a-bb5c-ae8d27d7916f@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::9)
 To SA1PR11MB8448.namprd11.prod.outlook.com
 (2603:10b6:806:3a3::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8448:EE_|SA0PR11MB4623:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b742f4-9e20-4439-0dde-08dee636c011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: XKOe9+taLA5A4L2SWuGy53e3jATdMRlNjFgBTqQ/45jSjBpXlhgHZ5tyamqORD1lNdUlHgh4xP5Vb2Ir/QeVBvJVhyEvjebrz63DxwI1LN/uqz1//5FLeBooVKsfBv5sOjIz/OfoDuD0QHKLHGmL9v5RKpro2poUUAb3rQNPf1wN9EfjxUxGbW6wEWKqMcMfnL4ercXz8q8egkMt2FukBykq7IWC5cwIC+HaY78sUXJbEGl9mcDBjDVF9D/u1YcAfEQT5MQj0APIKF/Cn0WajIx07q3UhClAAWo64UhuLrt3Gvxoujta1sztgML0Geg45QzJ3+219R9jzgMefj0lEbdHjwa4MUes/Jm6dVwwEcSfsUgVLa4chFNel9SB5d26zb13nJKgEP0BVlB+DX6Ye0kK7TO4sq6ElwV60kUY/EFbxlORWnP1EeTPPYa5iHlzyGDbQBHAFLq+WsUgmCnpWdyUujbu3/XHZDi6vT/l1c1QeA7oxPVrMnoJ6D8vjxYqtR1u22LJhQT6WMNzqV92PjzQ716CaSqlcI2FDAfA5I7WmdlfELo73lGH0T9c6Zvrvyd4nmTkBqA8bKiz7T2nzxhwwk/1Ydtw5sVCxHzZLsmi4DB9+xmEjKlgnjN2Q9Frm57Zkak9LUCrV+9aiitW3ypV30Tp8Dy5iwiufy+mo2k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB8448.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnhTY2ovSlY0eEVpVW00UDZIR0hSaVpwRVZXOUNTa05obW9ycmtHSWh5ZnZD?=
 =?utf-8?B?em5JQ2d3Zy9XZE5XaVFFRlpDWFEvTDBVbklDT3JqSXgwL2JwR0FxKzZmN0p2?=
 =?utf-8?B?YlRKQWlLT0F4U2poWGRoZDA0WWpRLzJ1V3dTbjNEM1l3ejdVVS9FbTdmQnND?=
 =?utf-8?B?YWZOMHYySnExSGU3eXo5UGFWekVsS0tQSWRSRWREcXR1OWxWbHNLbEQzc25E?=
 =?utf-8?B?NHp1SFZRRzhOR1NndTJoOWVYNSttYzZiemFaWHlTaGltN0swMlBWalFpdHVF?=
 =?utf-8?B?TmVMSWgwc3F5b0FVN09BdEgrY3FKaHZnbGZTM1ZBOUN2VzgwRzgySDh0UjMr?=
 =?utf-8?B?eFgzMzNNRVlueHRMNUJicjBWeXZJVEZPRE9mc3VxODZLKzEwRXI2RGE4V1BP?=
 =?utf-8?B?U1BBWk9FRGZXR3VDQlRZTDlxMS9oc3AxOGdmOHoxS2FBamZMMVNSMEhmeXkx?=
 =?utf-8?B?YzMwYjFWenFaYXhBVkdyVWxZZWxLUEovT0NJc2hKWTZSenVITlgxV2pvRmJk?=
 =?utf-8?B?K0FWWVhQZWtxL1NpaUR4ajFQTnJ6Rmw1bnYxVmZoU204TzVNZk5Vc3dLYkZM?=
 =?utf-8?B?dzBNWmYrelRnTFVsRzRCWGhWQWpVMUhoNWg2cSt6ZTBGalRpSHRiQ0hLT21E?=
 =?utf-8?B?UDEyNEZrY2VVUUxzUU9UY2VvaVBvVVoyUnpXZ25KeU9JYldhanl0MnlOMzZs?=
 =?utf-8?B?dFZWdm5VbnYzTW40OUJqRFdKakVNVUxHSlA0d0pxWHNpUHQrWWNWVTM2NUpV?=
 =?utf-8?B?ZzlJNGRzUmVrZlZBN1FDL0ZNTlhRZ2VpWjdSQ2xHU3hTT3VHUk9wQWtjRUF2?=
 =?utf-8?B?NnNMYVZVZGFXaWZzSFdRSXY1ZmZwT1Nsc2JNUzR5Q01mdEFEcmhZbzMvdUFW?=
 =?utf-8?B?N3gzbGpFc2pIVmRpYlYrMEE2ajY5bk5SLzhJbTJReVR6Qm45RWZ5SzBobzI1?=
 =?utf-8?B?WEd5TFhxekNxOEV6M3h5MjVtWmFxbkllVjBwR1JZWThacEFUdTNnWVB4QVBx?=
 =?utf-8?B?UGNaeWh3V3B4cW55NHZNdUhvbVBiZy9PeGJPWDd4cmkyK1ZjSUFpVEREdHJn?=
 =?utf-8?B?bGp1bE5GaERDZzVoc2NYVUFCMkFyWmpoNk01c2JtRUVHaXQwQmpXVkpvN0Z4?=
 =?utf-8?B?T2ZGbHF0ZG1aMTVNUWdSSjFPYVR2bUtpQm1rNjgxalNNR2w1SkNvek14RjRE?=
 =?utf-8?B?T3R5OTNkWTAvb2pjejdKZ1RSTjNqLzl4d2hkWnk4WTI4RHE3NmxEUG8xSEh4?=
 =?utf-8?B?d1VKUDl0ZDZTbWpFaTdTeUcrZXpMRjN2d0hHNHhabkVRaTZhb2pDck4vdkdG?=
 =?utf-8?B?WTJnRHV5b3M3L2huWEdyMVY5SWZHVjNFVE4vQ3lYcHBHYUx6WW04U0JybHJa?=
 =?utf-8?B?M0UrZldrVFVEMEw1VkZQYWhDeEhsbWlxajRkZUt2clg0dXJaT2JUL3FPR1RP?=
 =?utf-8?B?Smd5TEtSWjNoWjJOMEFLNnJncTgraS9uQzRWeS9sM2ZJeklqWEVhNnhqYUJE?=
 =?utf-8?B?b2VrdS9HNlpLSnVXeEhuczVLMWVpU09EZlY4T0diVnlwb3VzKzJWZWJCUVM4?=
 =?utf-8?B?d2doUkUrRlo5V0dEN05VR0cxQ1FoVkNBUTlqSzYzQ1lNRHNDQVVGUnNHbUJH?=
 =?utf-8?B?QU42MVM0dVhwTFp1QjNTQkpJR2JMeXJpdHlpK3diQUdhaFdPV2dINE1qbmlE?=
 =?utf-8?B?NVR3TkpLNVF2bUpGS3Bnb0E1c3FtMmNIVksxQ05yYXBuMmFQbHJzcDk4ZTlj?=
 =?utf-8?B?dzE0OG9KZERVUW93TzRUVEtObnYwRTlGQTFhM29UemNVZitHM2gzN25TT2tW?=
 =?utf-8?B?bHpCWVNxSk1aRE9DV0xSeEtDczUyOFEzNVMreVo5NVdiTkFPSGV5UTNoN1ZN?=
 =?utf-8?B?MXVjOFJGZFZwZG0ycXJ6ekt0dnNGUlJNVllLeTFJZkdHVDA0dEtmNTcwOFhs?=
 =?utf-8?B?S05hRENMWndobitFdUlyQ2c4dUh2eGZ2SEdWUFVXRUhUZmQ5b2dleGU1WUs4?=
 =?utf-8?B?dnFTWE5PaTdUYy9NUGZWNS9UbTJrQzgwZGNzZ21ubEhyVFJrNVc1L0NFSGlW?=
 =?utf-8?B?MkhsNzlpQlJSb1U3Y0taZ2x1U2Zwdm9zRXZtcllYZ0pTeExvR0Iwb0lrTGRP?=
 =?utf-8?B?RGNscTJ0LzBDZDJGcGhQeGloWkpoZmF6aEFYV1NUcm9ubkJ1aW1RdklVYnNa?=
 =?utf-8?B?N2piTE1VR2tmLzNveWYrZEsxWnBNdlJmM0d3OVJUeUgvS3hIenVOaXYyQk1x?=
 =?utf-8?B?VGI2T1BZR0svQS8xYVZEdzFPY1NYQWtuZHVXUWFwMm9aQmFvVzVaSmVJNk9V?=
 =?utf-8?B?U2JUWGl6N25nYVlSZExxL0I4Sk55YWVQb2F5VE1aTjE1ZzAxdjVXVXhSK0RZ?=
 =?utf-8?Q?hSFDG8X+kV7WUXVQ=3D?=
X-Exchange-RoutingPolicyChecked: R1n/JwCljTEp9f5mmEjDAumuMHXdSyroeDiyAuihJKcG3vdybEsIBJH5FVmoEaIyzBEddSR2VmLt7bG9c181fwf0nLrBxcZrc6UoMW1ANRhSR0Rhg3NojEac83CzEVvTKaLc8bnOFDgoISH0e8Q3Folzp0xq6CLWFYkyPerykNp2ZLRIH4VX1HHztBO2yDEnG7XoJWcNYosjU7gUf3z+unvBKQFES31bZtvM+C/WTBbOJo2eOUIVxg2V03gs72ufucd7sDfIKYLDy/krSZDI5Gk8x9jsQP6uFFOzEhNnjm0rpoDvFbfbOSKxuMYFXSdu89KQ6WPjQN41mBqmu9bJhQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b742f4-9e20-4439-0dde-08dee636c011
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 08:13:16.2310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VbYZKyGJrjjEv8wQufmbhOu9YtR8ldB0Tdh99BY3++CM9iXzRS0pV3tORkgCYFVKm9q1j741vpuMi5Z0FgI9kpywjBbGlgNpI3SorE5t4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4623
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784535201; x=1816071201;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TdC1qghKwjCEcmNRIiwzVar9Nqj0d56OQXKjGLibDT4=;
 b=KXyOIAlOGPe5z9zqWuBJVdyXUrFek/v4yr7/LrgPSvDsXuRYfL0Qk9GU
 HgsFhQywlNRMl/DXB+BiFDTVwCTnvrwxW17V9Q5ZAPCzTttX/6FaPzyws
 RPrfUA0zdEG56TxuSAroo5K8SKMQyc9frAOF3wcuKcffb33SpXXf6lH2Y
 B+rUWVfeOcMjoNciACJY6re3YSlJoV62NQERJcXM/nUJD/C/LgakeVV/q
 KcJxNr6h6mOdnOHTZCdLUb6K84cD2cke2BMUwWqifVn8x9i9VzPIzZIgo
 LN4RUuNBHjPJoQdjMLjBfT8okRUl+1NE6RemElTkr72kjyi6X3wTJ9gy7
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KXyOIAlO
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH net] igc: remove napi_synchronize() in
 igc_down()
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



On 20/07/2026 10:39, Ruinskiy, Dima wrote:
> On 13/07/2026 12:42, Maciej Fijalkowski wrote:
>> On Sun, Jul 12, 2026 at 02:22:42PM +0100, David Carlier wrote:
>>> When an AF_XDP zero-copy application is killed abruptly, the XSK pool is
>>> torn down but NAPI keeps polling. igc_clean_rx_irq_zc() then returns the
>>> full budget on every poll, so napi_complete_done() never clears
>>> NAPI_STATE_SCHED.
>>>
>>> igc_down() calls napi_synchronize() before napi_disable(), so it spins
>>> forever waiting for that bit and the interface never goes down. Drop the
>>> napi_synchronize() and let napi_disable() do the job -- it sets
>>> NAPI_STATE_DISABLE, which forces the stuck poll to complete. Reorder it
>>> ahead of igc_set_queue_napi() so the NAPI mapping is cleared only after
>>> polling has stopped, matching the recent igb fix b1e067240379.
>>>
>>> Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
>>> Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: David Carlier <devnexen@gmail.com>
>>
>> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>>
>> This is a mirror of what Alex Dvoretsky did on igb, correct? Did you
>> reproduce the same issue on your side or is it a blind shot at this
>> driver?
>>
>> Regardless, I think it's a correct thing to do, but some clarification
>> would be nice.
>>
>>> ---
>>>   drivers/net/ethernet/intel/igc/igc_main.c | 3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ 
>>> ethernet/intel/igc/igc_main.c
>>> index 2c9e2dfd8499..b3883a5a7d7a 100644
>>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>>> @@ -5352,9 +5352,8 @@ void igc_down(struct igc_adapter *adapter)
>>>       for (i = 0; i < adapter->num_q_vectors; i++) {
>>>           if (adapter->q_vector[i]) {
>>> -            napi_synchronize(&adapter->q_vector[i]->napi);
>>> -            igc_set_queue_napi(adapter, i, NULL);
>>>               napi_disable(&adapter->q_vector[i]->napi);
>>> +            igc_set_queue_napi(adapter, i, NULL);
>>>           }
>>>       }
>>> -- 
>>> 2.53.0
>>>
> Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Tested-by: Moriya Kadosh <moriyax.kadosh@intel.com>
