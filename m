Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2167C44501
	for <intel-wired-lan@archiver.kernel.org>; Wed, 15 Jul 2026 17:04:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 531716070B;
	Wed, 15 Jul 2026 17:04:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gY23b4sEuf96; Wed, 15 Jul 2026 17:04:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 93C62606FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784135069;
	bh=pKGGCJmIAy1KubGaFPxzC9DJbW9dKMsmYN80t0QvMUQ=;
	h=Date:To:CC:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DvUMxmjOk7jj2LgZuZHINoQPZi5XZj/G92UUR3zMxorDXyecsxSNVwdokR8uGQcoK
	 FgYY3zBykER5cj11FGD3bjhD/sgIogCCsnLJEpUu240su6EKZTzfc7px8y1BTvzZDa
	 0TvsIwOo9y/Mzi/ZBv0HqmvGXBwJKP2Glfzj1u6a0Sy0seaxxvYjt4/Pqh9M2TMxxj
	 dQpvBEJqN2NKYZM3trHA0YhKolL5PqrIhytPp4z9Mon4ZZI/40TBAB+yJ8tHp8wX2P
	 /XAKPrByx0s+0dmjxd+k+wvYBYHp3430+9ooqHsdHBVCzixyEN+xGeibdGA67estHC
	 IkE2BSndlOrQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 93C62606FF;
	Wed, 15 Jul 2026 17:04:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9247A499
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 17:04:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 78180406BC
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 17:04:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8ArSBkKAu2b0 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 15 Jul 2026 17:04:27 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=anthony.l.nguyen@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9017940693
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9017940693
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9017940693
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 17:04:26 +0000 (UTC)
X-CSE-ConnectionGUID: AzvhUi2lQIyvkrNIGprCvg==
X-CSE-MsgGUID: JW1U42aNRyispA8FfSV4MQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="83768120"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; d="scan'208";a="83768120"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2026 10:04:26 -0700
X-CSE-ConnectionGUID: ujpZAcGqSNms+oiuCB+cwA==
X-CSE-MsgGUID: c2xrstLYRk27TIE/EbCH2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; d="scan'208";a="256297464"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2026 10:04:26 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 10:04:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 10:04:25 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.52) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 10:04:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJc5xsJMGI5NoqW/JoyTaWYhHrZlJ7xpmIa1inhUnIkCKrrQh+mMp+0tsCvZkklR60uKNoOPkZ8AHyosTNQzuxyRE38RwtNvvQK4uhotT7DBArOJzGJRDWamVed12plrvbnMW2BvasG2/qnK/JT0WcXnh6mmIcEbujjoFyhGG+pULqC4OYmqFQLowhhdsChDUJFG8aoztqWTYFGnlIzFhsSM+B9ukTQeK8SKTh/31qfr/7BatqF/iEIQhEg99uJSBYyBm7TkPSqk2vfBVp2E88LVjmVpZ2PG5pSbb3koOWksYcpSIK64S2kWzWWBeAe/yVt0NFKw3DfKVmlRxk0MGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKGGCJmIAy1KubGaFPxzC9DJbW9dKMsmYN80t0QvMUQ=;
 b=B49pydnOH3CA9mGwSKS9mh0ILvRWMPVIGCbxAGxz6LdxjlwTtUcEuunNJMjktskns+aMRMGxpZxe9Wb+cveeriMFWgSjuWTxeRJtfnizPm5wtDhTZNEZo0gYi5gfqewJoDIPZY0xIRNqz+eGAsZ1lwfr5I9vo5tqzwDCm2jY0kmRwTGxgUjtbolTiKMANyEbl4n/XNMDEL2JGV945nsrUVmpDDIMfLRLViTot6imi3RBWDqVluuDQdfoL6W4zX1YnvktUOd8poDs5BJerDXO6KMbccWAa4dmq4hXX6Zi1oamPEEJ7JTCGKutDJlvU5KW+umELkRqBmGZfu+ydfsOOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by DS4PPFA08475C7D.namprd11.prod.outlook.com (2603:10b6:f:fc02::3f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.12; Wed, 15 Jul
 2026 17:04:22 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 17:04:21 +0000
Message-ID: <e8a4e549-c67f-4d20-8d33-fb50b4c44de9@intel.com>
Date: Wed, 15 Jul 2026 10:04:19 -0700
User-Agent: Mozilla Thunderbird
To: Robert Malz <robert.malz@canonical.com>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, "Jacob
 Keller" <jacob.e.keller@intel.com>, Jesse Brandeburg <jbrandeb@kernel.org>,
 <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
References: <20260703103245.374800-1-robert.malz@canonical.com>
 <bc89cccb-3f22-42c9-9f96-382586d12fcf@intel.com>
 <CADcc-bxLMg1NujF+jE2rOXGc38quv_XqZfv5K+yGQFfhc03avA@mail.gmail.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <CADcc-bxLMg1NujF+jE2rOXGc38quv_XqZfv5K+yGQFfhc03avA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0178.namprd04.prod.outlook.com
 (2603:10b6:303:85::33) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|DS4PPFA08475C7D:EE_
X-MS-Office365-Filtering-Correlation-Id: 356c12aa-c3cf-48f2-31c8-08dee2931d8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|7416014|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5NP5SIwVTw0dot7Iy87EWvpTcjy7/2munu5DRuEjFWjhVc6icD0Sz4s+8EFsCJSxeeAfK3fv7mbyc4Hg8H8D8bjXkqnmyO+QakgZqpXoPzCUv16pAOCDmG2XWUeAIzzx3lOqij7l+u09BUf4Zykh7KfQ3VEntx0W3AsIFY0aDPwq4m5Q+toaBnXHuxbrHG4WaykXbAbc9KuQeHY+ErPSM4/03HDGYUoPjpSBSNgtpbiHvJERMBeFYh53+DYj6WuiyL4goHmBfmYAJoQK2Sm4UYOafypMicsFdxMvywUHNWO45naToOu+OBV1h47GApBEDCWaUrlf+NFsqXfQVzhCvK65abE7T0N2S/0KoHVThuPaEMM0ltuPZxnwxZueP/GpENKmL8kWpSG3IqeiI5a45yoBLKv+nAMbuENODAob5aPntZT0LNktDcTcaxKqP377Xhs8Kau7l+I4xadO9xUnN+KiwG2z2PuCZMQBWt0oW2E6whro6z16nvUGhsAGdyAH7+4RUgq6XjgRzw2gOpHj8N48DyCeDnlzLVFUDI479ymg2JCht6yLcA/N/oRGGYW8SJSr1XmEzQuyCe8s9MxNSboGB/m+5uzUqfR3QWPyyPWVMv4sozZ0wVhmchVxfRYKnxMoKoOyKx/+dGFNzg/ABxKm6UnB8CwmybSnC5hYO9A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8230.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(7416014)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDBSYlBqN3poSUFwWFh2U255WVVPcnMwTGNwcmcwN3QydVptNGtTMDVNbXVD?=
 =?utf-8?B?czBYeGxveU5wRWhlZnBVUThQT3hyOTkwejUveFVWN01yVEJyUmVjZk93TDNt?=
 =?utf-8?B?NnViZi9aTFl1UDZQQ3hvYmt0TUlTSHpEN29TSXU3aVROblVJVmRFcklFREY4?=
 =?utf-8?B?MSt0ZUwvd1JncCs4bkVucXVJSE41NEwyMFBHRkpHWXRLZnhDL2JlMTBEcXUv?=
 =?utf-8?B?QmkzUTFDVktzMHBtTE5tTXVJZW1mZnpZMWo2RjI2RjVELzc5ZnhRcUJmOGR3?=
 =?utf-8?B?cHVmSWUydWpRdXpRY1dmQUFqMTJ2d2crMHFGNStOM3BzeXlMS0Y0T2dSaFU2?=
 =?utf-8?B?bjdaNkMrR2NRYmN6SWRrdzF0cVFIN3dyZUY5Q0s2Ui9IWkdSMk9pL01MMHFL?=
 =?utf-8?B?NFFBR01EZjZhT2htOEp0dkU0U3VqUzNGMnZROXFPL1JJeXpwRElpK252YVJk?=
 =?utf-8?B?dFFMZjJmVVhrR2NTenZWRkdSbFlnOEtnek1ZT1hZTEVSS2hac3VHTnRLaCtD?=
 =?utf-8?B?VGR0aUo4SFhwaVlJVEpWdmp3ejUyRFJrZmdXMlNlcDhXRlR3N3hDQkw0a2ZX?=
 =?utf-8?B?a3NpRCs1bm1VQk1Hczkyc1RjdTIyNnBJelJxU1grQ2owSlJjaGptalhvcXR5?=
 =?utf-8?B?K0d0a2xQV0wzaHBjdGMxUzZKRm1vcmQxMUQrYUowRmxrVzlOS01IS05GU2Fo?=
 =?utf-8?B?aEJ5NFViVG9TakFPM2tGUHM0VkdUb0lrY1J4dFFWczYxTEJGcHhQOXo5RU8z?=
 =?utf-8?B?YmkwQ09lV3luckcrQzVwUjFCNlVFL0Z2VU1MQWhGRHk2Q1A3TXd3dmp1cWRK?=
 =?utf-8?B?akY3MTJ2VlBkTTBSeE1ydGVHdXVESUFGS2I3c1pPS0F5L2E3STMrS002WG5I?=
 =?utf-8?B?alRwdDhwUVZWQ1JWSXJHeUlkclduM3ZNQVVFckhWdm5ROFZpdmxsK3Q3S0h6?=
 =?utf-8?B?NG9CUVh0VGxERGRWbm0rckZlZTdlcVEwQkwwY05OOVFtU3k5dThVa3hrU0Zx?=
 =?utf-8?B?WE1NQ3UzaEZ1UDc2cStLTEhwaFRrRnFZTDBFYlZseXd4aG1tYmFSUGJpR3U0?=
 =?utf-8?B?KzdpWWpqMjJTNmkwNkxnN0lzRWJka3dWZ3BRTWIvbU9QRldFWXFVSFpPdlhh?=
 =?utf-8?B?SEx3elQ1d1ZlbFN4bWtQTDdYN0VxbG4yLzVsa0dSL2xMMmEwU1lNWGtuMTlt?=
 =?utf-8?B?clV1UXIvbytrU3ovM3NkTWRsMEZCa3JGZUNhY1JSSGIrb0hraTNaSHgxVGM4?=
 =?utf-8?B?ekxGMlNaUy93OFN1WHo2VnlKeUU2QVg3Y04vWVZEa29Ga3BNMFlTSFZJUDhK?=
 =?utf-8?B?UWprTXZJUTlzSDgzd0p2ME43M0pmc3IyNHQrbU1kSHFDdHZ5ZjQ2KzZ6YVFF?=
 =?utf-8?B?ZEY1Mk43T1cwNTZwcXE4MmszRkZEV2lqbnE4dzhQd1BLYzNBQ3JSU01VRjQw?=
 =?utf-8?B?eWRhY0hCdlpSMTJUMG5mTTFwSjYxaWRrY3FNSGZzQ09SWWRORTZjMFdtOVBt?=
 =?utf-8?B?WVFYQUxUY2d2TDhtbEQ2YlZNT1lrTTVtV1I3UjA3Y3F2Q0ZQM09JbUtBa29p?=
 =?utf-8?B?UE11VmZwNUJqZkgyd084SkxGR3lvOGVKcFI1WEZuRURTODA4SWlJNGxGM3VK?=
 =?utf-8?B?WGxMdjZvRmhrRElTUzZyZEVrZlA0TmlzWVk5R2FRZkpCby9KZ0IydXEyL1gy?=
 =?utf-8?B?dE9OLzJzOGpzTGtrbTdoYUhjR2Vpby9hK1ZEN2djVlI1WTRZK3F0SGZoVWhE?=
 =?utf-8?B?Z21YM2l2S2liNCtrS1VxRUhMN2FWdXlDVFV2ZWdYQzhhSlN0RG9GRDBld0hK?=
 =?utf-8?B?TndLVmZNc1c4NjVFZmtTRWZ1UHNiZTN3RDhPbHFDSkFVVU5XbXUxMUlXQy9I?=
 =?utf-8?B?c1VTZ1ROQldMR0c3RW1LSVNuSitWaWdHMFBxb09ZMEJVdVRMYTFsTjBqc0dn?=
 =?utf-8?B?L3JKanBQTUVONkJKRHdiUXp2YXY0NWFiYTBsYVFtK1hyU2kxTTRmdTN1bnB6?=
 =?utf-8?B?WVlkVit5TC9RUThrRUJldHJFb3c3T2EwMWl5WGNQcERFdmo0Z0RyT2o4Tk5k?=
 =?utf-8?B?MTBsaGVhc1Z2L3ZYYUJZNVVQZ2IrSlJ3UEYyc3dWbVV3Mjgwc2laaEloeXl1?=
 =?utf-8?B?OWxKSU9EWGtqZjVWT3QrcHNRZjJ4T0kyTkJDQkhxRWpjSTNUL21VRm9waFh3?=
 =?utf-8?B?cW41dHFmMHJmbDZVdFhzSW5MNlgxTk9yS2pFLzdXcjNOQWprVFBQakl3b0Ur?=
 =?utf-8?B?ZHZkdENaUjVaWTVXc29UOEtBTTd4clFTL1l1SS9XWUdrR3kyN2hrbUFjRUlQ?=
 =?utf-8?B?ZDJUVzRkMTlFaXZUOWhTdmRhZElYK2hqZHhEWkxJdkdPeXJCR3hXWXFxdDM3?=
 =?utf-8?Q?yGIdZvOzlJXTSIL4=3D?=
X-Exchange-RoutingPolicyChecked: hBlhKKBsGB49laTDljXBT2Gx30D68ty5He+RH90VIWW72luYcHUZb02lgq85uIyx54of/R1oeHZyH0KUrh1EeNjAZREbHU6ZLUYYqNLbhFbkBrTWXumvAih/Js8zrNbgAc18cMTgTbnuGXNSdjtekVtlJ5n+5Lnh4niFQ8TIAnzVUrIDNd0InWav4aHWxhbfgT/eIKfxiK/KX3hYKzJXGbPR0jHy5sQgX7+hdBLuA1K+g/Nkql6Yk5KpfjN2r+g6k2ES7ZvBySfvORaVINboN9tVDDaQ6xqQkDO2Q30t+OxCBtyWA380LER0309oEkFyZTp0hegrQmaCWTJ5/taaAw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 356c12aa-c3cf-48f2-31c8-08dee2931d8c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 17:04:21.8585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYEUy9KPxJhJolMLRHuX2e+H+ZkUZTtuMb8Q8rYTOHeVotuEyhMYqdP7hC+kyFGV7/BD7eZvTB3mwORiO37tTvR61uHKttbdIy8P8g7xZEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFA08475C7D
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784135068; x=1815671068;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9P0l1wcCCtrOLeU04f1ME9KMGAYMo3cSS7/8tNy/YZM=;
 b=C5aro6OGXnvTKhf7Hc+yT08JFNyZGIcXG7SOMt7BIMCAamDSpPGw61JO
 UIKtKh7eDT2tqs1C/4eyJJEYxbv09RRD3gUO03ZQxMnhVj6oPStAQJ2pE
 OSpgnxvN2q1oW4iLxRbOKaMz/qECE8qb1YWPw6y9R3fOTxmFkMhBWQoVC
 kuWEFHyPi59edhgOW7x04vbs1wcvCru4MWNPWC1lnoK9j4hSDmtQFOpNF
 E8K7kjH35zfxERhoqtbwrwQOhYJKkpcEW93Z1UwMbT0L9RFfcX2MTUXVW
 0xfJwRwjo7I7psUjopxDsFUHV84hICbz5DGu5Ey6/0pkZo19zax4V1Q/I
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=C5aro6OG
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl] ice: acquire NVM lock around each
 flash read
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



On 7/15/2026 3:22 AM, Robert Malz wrote:

...

>>> -             if (status)
>>> +             if (status) {
>>> +                     /* ice_release_nvm() issues an AQ command that would
>>> +                      * overwrite sq_last_status, which some callers
>>> +                      * inspect after a failed read. Preserve the read's
>>> +                      * AQ error across the release.
>>> +                      */
>>> +                     aq_err = hw->adminq.sq_last_status;
>>> +
>>> +                     ice_release_nvm(hw);
>>> +                     hw->adminq.sq_last_status = aq_err;
>>
>> Does restoring hw->adminq.sq_last_status here without holding the Admin
>> Queue
>> lock risk overwriting the status of a concurrent AdminQ command?
>> If another thread acquires the lock and sends a command immediately after
>> ice_release_nvm(hw), this lockless write could corrupt its error status.
>>
>> [TN] I don't believe the AQ lock will work as desired we can't guarantee
>> that we will have the lock directly following the release in order to
>> restore the AQ error. Similar to the NVM lock issue, I think this is a
>> small window but wanted to bring this here in case others had
>> thoughts/comments on this.
> 
> [RM] Agree, this can cause issues. We can't drop sq_last_status as
> ice_discover_flash_size depends on it.
> Proposed fix: drop the save/restore sq_last_status and propagate the
> read AQ error through a real return path instead of the shared global.
> I could add optional enum libie_aq_err *read_aq_err out param to
> ice_read_flat_nvm(), capture sq_last_status before the
> ice_release_nvm, and have ice_discover_flash_size() test that instead.
> The log-only callers (devlink/ethtool) don't care about it.
> Let me know what you think about it.
This sounds good to me.

Thanks,
Tony
