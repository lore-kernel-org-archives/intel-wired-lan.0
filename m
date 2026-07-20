Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D48BC4452A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 20 Jul 2026 15:03:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0997E80D3D;
	Mon, 20 Jul 2026 15:03:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ajjTsELoBHys; Mon, 20 Jul 2026 15:03:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 39C2680CCD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784559820;
	bh=pd/LYxYqVKn7wFqwLclrc+xnpA/hRVb9HPsCKEPXbtE=;
	h=Date:To:CC:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WglSTgyF15l3ZUtVutesNlLN/CP5TdLtsNdZg1dRaU7vMJJf4fZkIWUxw3OXw5TxE
	 6fDSWSxxSNbK/YryL982673vUh8AKLCIXcFl86jquhbQmUT8gs6wd48Wufh6d4Qx3y
	 uYfyYZ+0eovFQRDSa9+8oFeUIMY8y7NmY+05Ors8jyl2dxN6wcvt1WP9MfPBeLhPDS
	 CWoiP/mayvBVfPzv+oEfgvKqNS41acgd/36nURZo1cCSppyth0Pl1eMe41iXElQxYK
	 BYoR9BHQbbm4rx+R6xQ3sPv3BAt1Gqjl/z2nELDc1t2tmTC5EX7XKEa5nT1LU80oaD
	 574LYMWTCG18w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 39C2680CCD;
	Mon, 20 Jul 2026 15:03:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C78B206
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 15:03:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0220E405F4
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 15:03:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bliz4Adg223P for <intel-wired-lan@lists.osuosl.org>;
 Mon, 20 Jul 2026 15:03:37 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=aleksander.lobakin@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 77811405E5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 77811405E5
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 77811405E5
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 15:03:37 +0000 (UTC)
X-CSE-ConnectionGUID: u86CIG2rT0igM5CEq9A6Kw==
X-CSE-MsgGUID: aWfeUZDbTtSXzzRepdfvvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85162636"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="85162636"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 08:03:37 -0700
X-CSE-ConnectionGUID: tIR20QL3TGG7blK4aTqv0w==
X-CSE-MsgGUID: bhVBZq5eQaq9jtFxhSyWwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="255702776"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 08:03:37 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 08:03:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 08:03:36 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.25)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 08:03:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGZAKrAcUWgrXGwv8rFld/z5bS+nSfGKaugRYp8mNeShyMx93CHUzYTySINwkpZLREfIGDva0P2nk0nguiheN62iWgEZidOuu4/dG3UZdk85PmNfXpiglDEV1JYOwupI2WhZx4zQ5M93JN4L+Fk0GZRnk+USn7C0VTE9DdDlMI+CUu2Glkr7yaKABXWdphutnPmUX/4DjM2J6jcdurK8mph8+Kcse5tbWwRpR4Rs81aKmwPdIMfv05UMCjgBfN8aHyyILwi3PC12mrVir4qja7t4jJc7yrp/HXtkSe3ZyCCEO3ALf6tNglYG6CubphPGsps+etr9X/KNFI4FYnVGKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pd/LYxYqVKn7wFqwLclrc+xnpA/hRVb9HPsCKEPXbtE=;
 b=c9pFps27DwNFFLp0Jl3udF63853UNmljre7A4L6E6c0iY3p8EU01IuqetSKcJCYNLIuMqwE0914er2jm5mtLW5vlFjbijR2S6j+tBtg9oC8Vs8WiURGQrFdUCap83sDc6wyLioYpSutidd39QoLDeJqXV2F1pdlDaWYkI0KQSlcHkasA+v75n/3n6JlrtUp7wax+EfWMOUoBKZclX5TkunLvVdehiSaxE9Y6OF2a9NiREhsr5YkXItlhdXHf4oFF4dbiwuZGt1wS5WBCIeW+40hOX7E5/wMyek/CCSVt9hujI+wosQ2uPx+JJ1ZxaF451IxxnIAW4NNmGN8EPvxZRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MN6PR11MB8196.namprd11.prod.outlook.com (2603:10b6:208:47b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 15:03:32 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 15:03:32 +0000
Message-ID: <eb4f3a70-533a-45e7-8213-4f286ddf5f85@intel.com>
Date: Mon, 20 Jul 2026 17:03:00 +0200
User-Agent: Mozilla Thunderbird
To: Chenguang Zhao <chenguang.zhao@linux.dev>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
 <netdev@vger.kernel.org>, Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260717012416.168107-1-chenguang.zhao@linux.dev>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20260717012416.168107-1-chenguang.zhao@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0020.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::7) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MN6PR11MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: c0e7dce3-cab3-4806-2f12-08dee670106e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 0Hx0aFhY705AB/7ZwLwO6AS2axE5yIiHd/IFAf0C50onZea5m9h0YJXUIFIP3S3COhb/SVrwe/XA6p2Bx2WMJoBj33M0fEBWY2hxGZXwZHOygx2Ij8mWRHikKxQGDWpkqn+MZZofOM/7vVylVIbTjE8jkK3B+LSIDTNojuP7sgzpVNzTmjQ3ILDVotM2Xjc69LPTvu/8BOe9pj1DFti3234RcxSjdDb78hs40lJ//tmeohITPUN6L3ll+JUVJyJJGrsN6WABpubG8vKmft7vPDmI02zImRvCOWQvKrxVcmTg6Tf0JWWdpyPsSpaIsp1jeupfHWDv0XIJ8Bn0KlJFdT9pCnxzKPUbLGPAtp2103tUAO4I3Z4ybMiI6lXgT3+VktrPVj2CDr4uch6ohkh5n+L0u1sqmzBkpZIvrdF7D2glzlNVa7eyuav3V4PdME9lN8iEOzb7FdxP87T0pR53jjv6N0egSjeHDx8gNpsuXDJQoHoZWpH3785Emx9W2exOPDyfojyinRC3uAOb9cT2iE4mH2NEgA/ewiXGJZW6JUup2tmQLfl0alL67kmb4w9QsxL6GQEikGEDVlYFLb/4PtTK9CSDbBa4oWkCOF+H3UUR15dd4MHDmh3xiJ2UA0AFo0MFoKXK7YgdaRJCqgOT3pQy9XjJ0gNRd2YNIgmhKuU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8718.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3dVUXYyeWdhbWd3Y01Na2IxTENJY0N6cVNyUlg2U28vNTF4amZJYU9pMTI5?=
 =?utf-8?B?bll4a3B5U3k2alNsYnBlR3d3T052ODhjZjM2cGhiSGtYaHlNN3B5UU90aE9u?=
 =?utf-8?B?b2NqRVRzMWlleUFxR1ZLVXZDMWI0QzczQ1lTNlJyU1R0d05WRzNPMWtnWlhi?=
 =?utf-8?B?ZDNuWU9wV2E5VHdmMUx3V0NwVkpLK3B1WVNFSjl2TXFIQ0toUDMwLzlhTVdT?=
 =?utf-8?B?NHF1UDNPb1NkNXk3VWZEdGJtRHlnaktYZnpMcHBJZzNwZGhNL3BNSjZOblI5?=
 =?utf-8?B?Smd3RkhYdXpIeTdHbEhKSE8xRnlQT3M5TEJDenE5dGRLeHN3M1BZM3VLbjJY?=
 =?utf-8?B?TGk4UWVkS0pUZVozRWtaNGFDZFhBaVlIZmVpNHZmS2ZidkZQNzF3S0RobmJJ?=
 =?utf-8?B?VXE1Ry9NMldDQmI4U0wzSlppeWNNb1ZjNGVKellQcE5iY29QYXVHbGRnZTNE?=
 =?utf-8?B?Wm14SlhnMFdwa3l2c0s0cVpHekxCQTVISVE1WlpjZ1BlUmFhY0RJczR6ZFlu?=
 =?utf-8?B?VVJ6NmQvcFZFSitLZzZrc2lKMzNmYTZES05iSXBJeUE2RGpPakZDb3hha2JH?=
 =?utf-8?B?T2xvMUNJcWQyQ0xaQUh6M2ZXVDIxN01ZU0hWd3plN1llbFFMVk9QbXl6eThK?=
 =?utf-8?B?TStpbTNuUjJJalp6R2JJVTg4WlcwTkMyeHJkU0x5bzZSMlp1TzAzNE1obkcw?=
 =?utf-8?B?RERxNXlkV09nMDdsT2duQ3RJM2lDTG9OQ1RGWm1zQloxUW9OOFFEVTludnpu?=
 =?utf-8?B?b1JKT0lPZlp1bUl1bEcvTVBZRVNTTGRMeHlTcFlrR0xzZk5IQXlxcmhHS21K?=
 =?utf-8?B?ZU91MFY2ZUVZZWQ2ekhFdDhZS0o4QTJUUXRiUDFzcHBtS3Uyd0FvK2FWZXVj?=
 =?utf-8?B?OVE3MzE5MEdEK3BzMHEvelhJM1c1TkhwT3l0c1ppZWo4bGx0VUpDcEJTckg0?=
 =?utf-8?B?QUJVenBVR1luaXE4VDFpbVB6bld1cHJXWXVyT01tazRIajFsQmxJeFA0UVN4?=
 =?utf-8?B?TCs4TVhXZ3lTamN6anE1VjZTazJVSVVHYU9tU25DM29FSkM5b0lSM3FyNVhD?=
 =?utf-8?B?RkFYUkJjaEZyTThKZDZSL3NmeVJidTBtM2ZTTlFiZHJvTlBENndqSnlhdDdj?=
 =?utf-8?B?MUhNMnNjQXJzaFN0LzJGcmhZdW1EcTlONnpMTlpzaVZ5dnFpenNSeGNuSFZk?=
 =?utf-8?B?ZTh5Q3Z6Qk90eDFsd0x6a2cyWG5JaEFDSnhtYXgxTXdZK2xYNHpBUG1UVzl2?=
 =?utf-8?B?cGtrUmpiK2d3SWpRZ3M2NmxETVh5QkwvZzl6ekZnWmIrN1BKN1ZJbFk0eGNK?=
 =?utf-8?B?dG9qdWdKcUc4QjY3YWZTQ3RSYkZYSXplTVFDb21YOHowRzc0L3dGekl6V1pS?=
 =?utf-8?B?RE0yaFFMNnRpbUN0Z3dtZDBFTWtVMHhweld0U3d5MW9aazZndWZ2c0hPVTU5?=
 =?utf-8?B?ZzBBcmxhVDlscFlIbGZ3Wk1Gb2hBVGM3UjdhaE1PcHd3TVFjUU1xalJUU0Ny?=
 =?utf-8?B?eWR2eHRWY0NGbHRvZTNFbzc3VDh2OG1odDYxUjk1MVAwMk1NM2ZCcnZ2Yzcx?=
 =?utf-8?B?NkZacnRHZVhoYmZmNVBZcGt1d2NKN0l1eG5nUHlnZDZBYmJFTFB3eU1qeTZV?=
 =?utf-8?B?SE5INCtRMURzYVorZUMvNkJLcU14c2p2a3pYSmpVTEJUcFRyR0xwUUx6R1RO?=
 =?utf-8?B?RWlVa051S1lFZ05OVklXbXYyT0Q5bXFKYjBPYng0WHBZUDQ0ck1mdEhDRWpQ?=
 =?utf-8?B?c1VSVENycmZZdnE2cUs0UC9lQzBEaERjMVRKUWpWd2lKbVYwWmhQSUl0dW8r?=
 =?utf-8?B?cDZodjREenJ1cGJrcyszSmtPL2x4TC83VW9lOGt0Z0xHd3RaNnFsMVRFZi9K?=
 =?utf-8?B?UGIrRUszbElmVWJaMkFFSFh2WUhzWU02TVA4OEwrb2Mza3ZMbFppYzc2elhD?=
 =?utf-8?B?TENrdU9CNEpKNkI1RlA3S0FDQlpVZTQvV2t2Q2UveWhFSkRiV2dQdTR1cDNT?=
 =?utf-8?B?TVNDTFhOYmlMSmN2Nm90L0hVN2c2aVNUOWdUbHNDSGJqQnZmMHpoeVI3VVZ2?=
 =?utf-8?B?Z3JMK2c3Qkh5bHp2Q1JOOWtnWVI3b0gwZm9Ib2Qxd3ZJcmlURUlOZWwyanNG?=
 =?utf-8?B?UTE1b05kM0ZqcURrYTBRT1BxK0NrRWZBdlBaRHFhUDB3VnhPbjg3VjN0dHBR?=
 =?utf-8?B?OGRoU1NxVEZPREozWVdlSTlCQ0lwd3h5UmR5OEozNkVabERTSWt0bWZjUWIx?=
 =?utf-8?B?NTBBQTBjMDZMcHVCWGxIdWhPNXRhYXZDSFExUWgwMGJORXhaOGRZdjFHSWVH?=
 =?utf-8?B?NUsreE1EVGs2NFE0cDk1WXR6VndDYUxkazhVQk82aGVlaVVIT2JYcGlyMGxG?=
 =?utf-8?Q?miTuNqT6XayjltNg=3D?=
X-Exchange-RoutingPolicyChecked: rj9nu2UqhnhTjdch4N7/db1nfqUtkOqEMdw8D9VpEr2pEIICJo2xqH6iQo5XiKTLXyYSqOKYXW/tv3puXPm/SXnFNzCj4SrSog1g34Zl/lbOF3FJibefnXHqcBmzPl6urhwl0U1HA7e/197OCT1oqV4xNL0YGhxGPjDuFSDwJJYWFOMj6njzdgUxkOYxj9oBgImUt1xGNK/6DSiZki4OHZfwxNlF5qDtCgTiDKXYBPCMIOShBKXqZc8L8TqsweEbHQOV5HvGUmwi//EMgAR+McM8UhJi/GIQOpCr5NRB/dkSF0DeUbl7AkNucUzqlKuc8JoKEuXXotY2ctzwkhNpiQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e7dce3-cab3-4806-2f12-08dee670106e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 15:03:32.2356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BqWx8xRHkTdH07H6grsUPFeR6u2lMvb7bU8bY7xqAV/wcV3yRYHW/CPveBod6I38NkGdqLrjkrYQizi/LCIXN0J4gg5Wg1E2U0mzhWmAfog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8196
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784559818; x=1816095818;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FT49RVkh3pQ8SU5rUTDkhA0wnMWf5kOypPS+mAsh8Gs=;
 b=f4OxRmcP0iU8EHHZ5mXgONJhaTnDbOntrLXy5V2Ugm+PaaQFBBxRnO4s
 jE1oYBA41CVFN62iFxU39fzSL1KENIGugCuNwg4JeGQHEc02sjvlTF36a
 niLbpMVkaHDeXfPZlWNzUvldHYYa+PjhZFWbh25bqE7VcZwgId2yQ1Z4u
 W3F+dMuKGCGCJUt7cyyAfpocbYHDx8H5JdviNzWMqRcBuEVDcx+KwMVma
 a7AFGq8yhE1w762euIcypWAczyJca54mj5q9CsKUqUTqqwvaYvvKjguR5
 qVwUNwBxNWZ1lArdd01QLZxKPVWSwJNW91xBnDECQydN+/vpPtbRZHkkS
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=f4OxRmcP
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH net v2] i40e: xsk: fix multi-buffer
 XDP_PASS skb construction
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

From: Chenguang Zhao <chenguang.zhao@linux.dev>
Date: Fri, 17 Jul 2026 09:24:16 +0800

> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> When AF_XDP ZC receives a multi-buffer frame and XDP returns XDP_PASS,
> i40e_construct_skb_zc() copied frags incorrectly: memcpy used
> skb_frag_page() (page metadata) and __skb_fill_page_desc_noacc() was
> given a virtual address instead of a struct page *.
> 
> Drop the custom helper and use xdp_build_skb_from_zc() instead. On
> failure, free the xdp buff in the caller. Push the Ethernet header
> back before eth_skb_pad()/i40e_process_skb_fields() because
> xdp_build_skb_from_zc() already called eth_type_trans().
> 
> Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

One nit below tho.

[...]

> @@ -372,14 +309,20 @@ static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
>  		 * BIT(I40E_RXD_QW1_ERROR_SHIFT). This is due to that
>  		 * SBP is *not* set in PRT_SBPVSI (default not set).
>  		 */
> -		skb = i40e_construct_skb_zc(rx_ring, xdp_buff);
> +		skb = xdp_build_skb_from_zc(xdp_buff);
>  		if (!skb) {
> +			xsk_buff_free(xdp_buff);
>  			rx_ring->rx_stats.alloc_buff_failed++;
>  			*rx_packets = 0;
>  			*rx_bytes = 0;
>  			return;
>  		}
>  
> +		/* xdp_build_skb_from_zc() already ran eth_type_trans();
> +		 * restore the header for eth_skb_pad()/process_skb_fields().
> +		 */

The netdev rules prefer generic comment style over what we used in the
past for some time already. I.e.

		/*
		 * xdp_build_skb_from_zc() ...
		 * restore ...
		 */

> +		__skb_push(skb, skb->data - skb_mac_header(skb));
> +
>  		if (eth_skb_pad(skb)) {
>  			*rx_packets = 0;
>  			*rx_bytes = 0;

Thanks,
Olek
