Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21C3C5AD5A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 12 Aug 2026 04:24:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 988C6608A1;
	Wed, 12 Aug 2026 04:24:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qzcP2yA-Y6BM; Wed, 12 Aug 2026 04:24:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 132D960873
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786508656;
	bh=GoFlwz0jbnD7Ve3XTCjoNHMlovUwF5aACOA7AHPyzT8=;
	h=Date:To:CC:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XIaiSh61uaYNtcJ4UOzFAtn3beJCDJ9k0dHv3/+eqq6rcJ1cMQxZ8oY67okKbglBz
	 jfV8eX+OJ3/4V7kLA3BWafNG8xYA2p48OlzCrbfjhaGTwNxrIWL9bfzqW8WVFBbXuj
	 nVI5XGIog2r8rD3ffdiF5HaDSyZ5tArx1izniXFWv82ccemCXy0RsG5yYd6O2mGUva
	 LPPScrzTQ6jZFBtVId4HLbgUQFZDaIVPcOr9qPiK0ORSariBaXgUqXDMWz+81+N7Wz
	 O7jG+yEVSIx7+GbTu6Z490lOfN2rHFT3JCOnCUe/EVLMW2oFLZY2u9PEW0m1iABOQj
	 yIj37aBGTsDKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 132D960873;
	Wed, 12 Aug 2026 04:24:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CAAB1259
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 04:24:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A556B407F8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 04:24:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AozE276-pFiY for <intel-wired-lan@lists.osuosl.org>;
 Wed, 12 Aug 2026 04:24:10 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7939540798
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7939540798
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7939540798
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 04:24:10 +0000 (UTC)
X-CSE-ConnectionGUID: F5hyvjGiT7u29AQvNN0CTQ==
X-CSE-MsgGUID: Jp6inbAHR1SOSoViU7Paew==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="87124963"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; d="scan'208";a="87124963"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 21:24:09 -0700
X-CSE-ConnectionGUID: R6JHaqTpQLKHUEt8EyP+mw==
X-CSE-MsgGUID: JnROVsPUR4C6n8zBP9bgsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; d="scan'208";a="264108728"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 21:24:10 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 21:24:08 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 21:24:08 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.42) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 21:24:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SmBtjp7MnJ56LiZcp00Y0qtV5YZe1hTQ28cXDxO/kgzkZY5kXWWfhltYBX1C/5q7DOPSS1Kcr8498pq//IKtTYhEVbvwSf46lOCReU5sDNQwkxOWHx/SPs+2E9fTBUa0EpxBOKnpy3zGPQDItLE/ZWI4eRgi7bRJvjlV4wKxDUP/cTPtz5BLmEOLvQTzwnoHj53SeGsET4nomlr5Y5V3y4BbzUWMMTUBGAp6ulJ6zb+vovoVfyLrzcBmvqk5KXpF+l/P0UaGCDvJ2FSZs2FrwUzTZ3rN9WVkGFtmMDQJwZJKJS3JXu51swQwGL54FWjrR9IVy7l04plNy2bTMzLgcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoFlwz0jbnD7Ve3XTCjoNHMlovUwF5aACOA7AHPyzT8=;
 b=VzI/qw/AYMoByExK9Eiu2kQWoGoXNVdBKO8NvmBvKj76eyIpzn7UkCY30NATcEdurO39c6FC1ujNm7TEkaX+QgI7rLNm609mbHVBJYJYYMCiqg43DXYImGVIzaIVilfiW+ASD7bwOV7Td41rvsgIl7LXhQNkcd9gJJxICqg200Y3mXc3peBLOMc56+M+BSVrQtnS4cITFUrHN1fV95MLrzZH6GrUx8LoNYMxS0cwi7NP1c6wlOkdZlbul7v089RyN6ZNcc2Q8tSeuzIW7gjulZYswSEmtzyyijNLCiaDNOXdoetesYcdq4DNjW5bALpEI3QBpS4pi2ElZHCAsz0tlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by IA0PR11MB7401.namprd11.prod.outlook.com (2603:10b6:208:433::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 04:24:06 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 04:24:06 +0000
Message-ID: <1593197b-db89-4aee-ba63-1733456f7888@intel.com>
Date: Wed, 12 Aug 2026 06:24:02 +0200
User-Agent: Mozilla Thunderbird
To: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>,
 <intel-wired-lan@lists.osuosl.org>
CC: Marcin Szycik <marcin.szycik@linux.intel.com>, Paul Menzel
 <pmenzel@molgen.mpg.de>
References: <20260806104621.700901-1-tomasz.lichwala@linux.intel.com>
 <a1abe12d-fa5e-4f53-af12-45793d8f8e1a@intel.com>
 <539e7fa9-2443-4577-88e3-da024c992036@linux.intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <539e7fa9-2443-4577-88e3-da024c992036@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0272.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::12) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|IA0PR11MB7401:EE_
X-MS-Office365-Filtering-Correlation-Id: 8044cf39-7d6b-4641-60a4-08def8298c1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|4143699003|5023799004|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: msP1wi4JJ6VI1xMFEHx/o8En0vg2nm3kVS6zcF2zZ7yNYMVV+EbQYC9XvB6cBQAXZ2WW5I6uFerGCNfk1J/RjABoZJvMmcUjthw9vuDt28XDvSewkbo6AKJLUcW/iO1lacA9jIVFiVW4q74Z7LyV+aPVu0EYQDOhwcJzr33dPvMYZBryfNbDmUVqCQmk+m9P7zGtYUGcrOePukSVMuZVf0oBvRpNUEWBDH2S6G1nRLU6Q+eK7xvqlZhMVsYQErtWaqDlQmbLya8fz6TXwFGFcMDOPuSWAoVPjyLl9IszkuWH6N+218kRdumeDs5H5M9WGleO8jduvmqzfJ0HP7q7jBIwh+HnntjCGjBZ95b5hdo5ImInMIdQ0qWIeIVVzDJ9SJ0iuu1LXu8uS8jojgfIiCuDZQDBsgtdVqHPjkekDWEKXsl015lSnueN6w91lgZdx4cgFzJAVcKIRW9Ws4jrRzMjfY1ZLQdIHQ8TvSY7ycsmwL3MgnAOEBBPcMm6LQ+8taXzN+Efg/0DzeaiSbjoREMRlekNRCH457L+ctWxRbMBH9frl8/KEOcJ+uMWShM6j/iSHMy0HZcTQWBlI7DCRAcbPWDSxMs8uLG+00s066P6FZt30REj/Jyl66iIFthUcSS8qCFdNe9INYjcHbcuQqph0vKqkbHo8fZa3Rz+E1A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(4143699003)(5023799004)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1lZZDdwbVFXcFdnaWc5emhXL3kzVjkxUTFISXZVNWVkcHo2RnJFeTIyNkN6?=
 =?utf-8?B?V3gwSVIrVlBWVkU0byswbmJhbWY2R2hLRXBYTnRqYldneUszNlBYaHROanlY?=
 =?utf-8?B?clB6dGhsNUt5U3NnV1NwS0JCTGt0RnMwV1NUTFVDYzJjTHFzNFpxQ3ZQK1Vr?=
 =?utf-8?B?aUxzcDV6b0VvbzNzaUpQaElGVDJQOEJjUlhVQ0ZYL3QzNWVFejNhUS93UmpF?=
 =?utf-8?B?TXM2UHBwelQ1UnE0czZhbTdJTXBaZmFqTVAyOElmUDQ5eldUTy95VThpRXp4?=
 =?utf-8?B?eFkyQkMyOU5rVFNBQXBBSnNxOHpjQkZ6YkpqZzQzVkErM3AxdUU5QnVwVytk?=
 =?utf-8?B?YmNOQjh0bytUcUFTTmYycUV5S1BSaWVlVzJSY1hJNDhpQ3NzMWhFZXYwZjJ5?=
 =?utf-8?B?N3laS0FDMENmaW5oRDhXOGpvY0VicjcxUXFoTVhMNy9pbTNmQ1ZmQTRVTmpQ?=
 =?utf-8?B?ZHVIdUs3UWllMklmaC9OQ0FJQ3p6REliSUVCT08rblJnbVVtT3RRa3BJM2tG?=
 =?utf-8?B?QkxQZUdVaU54VmxtSXBub2RJdVJ3amxsWHdtaDRxS0x0VEtEMXhadXdFRDlI?=
 =?utf-8?B?K0tpSGh5M2hZcE1NNHZ4V0RsZGVzRHo5YStFcjVtMmtGRUJCZ0N0MXl6Vndr?=
 =?utf-8?B?NFlaR1hXdWc3citoWVcwbjJIRzNsaTlMNGdmQ2FGNkZWandLb3Uwa1VSTmZG?=
 =?utf-8?B?NXJIQ1A2ZEZiWTVvSUY4ZDZNaWlmZHNVTkwrYkVwMkRtYVRGSWtmR3QwalVY?=
 =?utf-8?B?c0VrT1MrUm82cWp0dGJzN2loSFRFK3Z0V0pwMHZoNEtFOE9PSERndHZCOE93?=
 =?utf-8?B?c0pTY1hjQjl1WTdlQ2t5blNzYStMNjZEN2hTdENZM2FCUy84M1RFMlhqbkVT?=
 =?utf-8?B?enEzOW1KRWtSb0hmZGl1OXRJZlVDSzVieTMvVXluWEx5YW8yVG1Kcm9LdDli?=
 =?utf-8?B?NVRDc3VML054YXEvbG5TSTNmaVFSTjQ1eFpGV0dwbmdDdXFiZzBjRHlGdHZQ?=
 =?utf-8?B?VG50OHJpSGtTd25KdzJwT1JkTXp5ZXlaTFprMXJWRkYzSDBmODZkaTE0UlJx?=
 =?utf-8?B?TUwvRXJWaHdlRS90Z2pkQjMyVy9FRkltL0Y4N0EvUHpyQUxHdlVFcjJaaVpG?=
 =?utf-8?B?V3RzdG12QU10RVRaVTJCM21uTVJFUFVTSXR3Z2l4VTNzUmhvNEJWUUxub2xL?=
 =?utf-8?B?NVRLZm94NXpKeE5rWXFYbU5zR0tQdDhHcWt0bWxoVlVGRGFuNnA5ZDRmOUVU?=
 =?utf-8?B?M1p2UXphM1h4WXB3T1NBT292ME5ocHdmbEFzRFQ1QTlOWU9HZDZGRnp1TWNr?=
 =?utf-8?B?ZHRaQ2hseWlIT2FkeWFubDFqOWUzUTFoMW1DSTg1NXZVSWdNeC9OVjE1Zzlj?=
 =?utf-8?B?WU5pVmdVUUp6Z01YcFl1RXVsbFpDcVhId281TXY3VWpuOW85dC9DeGNBTHBk?=
 =?utf-8?B?V3ZQcTBkcUtkQVhJSnpGZVdKM1VycHJxaEhpRzRmcElhYmdwOFVtclg2TTg0?=
 =?utf-8?B?bzJ5MjcyZzZ5ZEFaQ3dtdWhVRjc5QlMyRnQ5K3RhRzQxZHFoaTQ3cDIxRy8x?=
 =?utf-8?B?Mm1xMU9rN21TSWhoOXRvZVBrZDV4OXcwUXR6YnlwanFsUk9IYjVFeVk0dkZE?=
 =?utf-8?B?RytvbnZ0dVJGY2UySW9ZS1ZoQk50OVJRS0FOSTlWZlNQajF4UTlRbmhLZUQy?=
 =?utf-8?B?Yzh0U3RkQVBJZmtSWHorMEFrZVVqQ3RHRHJaWDYvNXJaNTJ0TDRkZzVGc3g1?=
 =?utf-8?B?Q2lvRVh6OGk5VityejRQTHZVcEdlOUxNZlEvR3dORmtsbnNtMWVVckJ2aFI0?=
 =?utf-8?B?NE54bEpDT1ZRVDdncEdpMFpCemZtdks1SnhwOU1JWDhxdEdLZituaGxCdDdm?=
 =?utf-8?B?UndsdXRKb2JLOE41blNBaGZnZEVYRysvdU5VbFJXMHZ6ZkRFVFg2QTh4cUJW?=
 =?utf-8?B?MmlEczV6WFRRZGhEcTlua1cyWTFGZEs5REs2QW8zeVB0enBJM29HZmc5dTkz?=
 =?utf-8?B?ZVN1dXAwQjlKYW9sc2wzTkZlaVN4bmVTSnNLQjR6N2ZsK2VrQjh0dVdSL1FI?=
 =?utf-8?B?dUhjVWRPalkrWVlmaEkyMWdjdGw3dkpHbTB5QWxiVG16TWNCWHExaFlFbWYy?=
 =?utf-8?B?a1BkNWJUWFlucGw0MWJHV1RvYTBxQTV3M2o3N3ZHemdMY3loKzQ2c0JOazVE?=
 =?utf-8?B?T2hxcEhTZFR1Uzk3VFBManJjc2pxN3VTcW5NQnN2K0VLbVN3RjdjcS8xaVVp?=
 =?utf-8?B?MWVNSndkcVhscmxpT1lpS29MQTFEZzNXL0tiSzFKSnZsWHlHODBKamVJZGJl?=
 =?utf-8?B?UFhPKzdrQVh1QTFIUnBhaVlzUmExWmZsbTBsTWdPTnV2emZIdkZ0enJGSmIw?=
 =?utf-8?Q?jInkYIcPeOtj9B4E=3D?=
X-Exchange-RoutingPolicyChecked: shkT/cDEE7B2RRye5eu4tWGcqCVr6WeMu7CbwegatjrwnRqvs92QrXNY2ftUYpS0RD2NkJjVl9ay6OInJFoIH9PN0BCjQjfmsWSK1+QXdCzfvYS1BSgjxeeFU2RHOY5VX5c4QOALAZMahDiYY1AYEO3FSioDG/vt0MPii28AiLgrwmQOvIYzJgCk5bZ/kzYNvOBIw8VMqBiuDwARHlMWSpwWXz4bpvZGl6UQ7VfOYH+bdGxGXxRvuLJcQ5XEPxZV4DqkYKkTpvTxoS+FRc2KwwSflB0kwBhNXo1/YPrpXoPGbyYvuMs1OdMDTVZegl43aGxwDV0LrZDLIf+4O8JOIw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8044cf39-7d6b-4641-60a4-08def8298c1f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 04:24:06.2273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HpaQMN+hn8jyL0GMdkXSDSGJvbm7hQjNYBVfPQuUzSeFK5ElKM1ujfoikZ1So3xEFBA3FYGaHKAy0jfNWrqqmtXnmCvP0j+pWnGkJrGXnw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7401
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786508650; x=1818044650;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0PEu+rMKzjJXrmjAopBWN+jaI0OCQUivYGJ56WfH2Bk=;
 b=V2T2ZnO27UL9yjNshwW1ik7a+dCkGu5UwiPB4WXqNoRyAk7HgLymytt3
 xE77cJh21PzgqEHGgQ3BWpTuLJ4QZAwDPFF4e73+/cp83h3eyryThfY2B
 UqR5U0Tep1XAyiPY1bRSGMPSr/TNmnrELH49/0Pt8vtR6tG+PKeBDVzb3
 9f/SEXQirrRdzkuTYFO2HmaiIrQ9Q6Q1xcOf6sejwIBf25PKN/Bsp1m56
 +DZmirJUoZvvegWY2PMXyoYpuulCYeMe3GE0i3pli+3bJPwCl2MPTtQWR
 3FNYa/CQed2hH7re5c2Py7Af8rGnMl/RkZQBYw4EUH0zqeNP10rJavw9o
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=V2T2ZnO2
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v3] ixgbevf: fix link speed
 reporting for Hyper-V E610 VFs
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

On 8/6/26 15:19, Tomasz Lichwala wrote:
> 
> 
> On 6.08.2026 15:04, Przemek Kitszel wrote:
>> On 8/6/26 12:46, Tomasz Lichwala wrote:
>>> When an E610 VF is running under Hyper-V, the VFLINKS register does not
>>> carry valid link speed. The existing code reads speed from VFLINKS, which
>>> does not reflect the actual negotiated speed. This results in ethtool
>>> reporting a stale or incorrect link speed.
>>>
>>> The Hyper-V synthetic NIC exposes the actual link status through
>>> emulated PCI config space at offset 0x209 in VFLINKS register format.
>>> Read and decode link status from there when checking link on E610 VFs.
>>>
>>> Fixes: 4c44b450c69b ("ixgbevf: Add support for Intel(R) E610 device")
>>> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>>> Signed-off-by: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
>>> ---
>>
>> next time please provide changelog section here
>>
> 
> Noted, will include changelog in subsequent versions.
> 
>>>    drivers/net/ethernet/intel/ixgbevf/vf.c | 77 +++++++++++++++++++++----
>>>    1 file changed, 65 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
>>> index f6df86d124b9..8ad06e28b5de 100644
>>> --- a/drivers/net/ethernet/intel/ixgbevf/vf.c
>>> +++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
>>> @@ -1,14 +1,17 @@
>>>    // SPDX-License-Identifier: GPL-2.0
>>>    /* Copyright(c) 1999 - 2024 Intel Corporation. */
>>>    +#include <linux/unaligned.h>
>>> +
>>>    #include "vf.h"
>>>    #include "ixgbevf.h"
>>>    
>>
>> [..]
>>
>>> +static s32 ixgbevf_hv_read_links_e610(struct ixgbe_hw *hw, u32 *links_reg)
>>> +{
>>> +    struct ixgbevf_adapter *adapter = hw->back;
>>> +    u8 data[IXGBE_HV_LINK_STATUS_SIZE];
>>
>> following Paul's suggestion, you could add:
>>      if (IS_ENABLED(CONFIG_PCI_MMCONFIG)) {
>>          dev_err_once(&adapter->pdev->dev, "cannot read link status, PCI_MMCONFIG is required for Hyper-V\n");
>>          return -EOPNOTSUPP;
>>      }
>>
>> and this will give user more information
>>
>> IS_ENABLED() is really nice macro :)
>>
> 
> I think you meant !IS_ENABLED() here. 

oh yea

Without MMCONFIG, pci_read_config_byte() at offset 0x209 (extended 
config space) will return a PCIBIOS error anyway, and the caller handles 
that gracefully by reporting link down. I could add the explicit 
IS_ENABLED check for a friendlier diagnostic message, but the behavior 
is correct either way. Let me know if you'd prefer I add it in a v4.

yes, please do v4

> 
>>> +
>>> +    for (int i = 0; i < IXGBE_HV_LINK_STATUS_SIZE; i++) {
>>> +        int ret = pci_read_config_byte(adapter->pdev,
>>> +                           IXGBE_HV_LINK_STATUS_OFFSET + i,
>>> +                           &data[i]);
>>> +        if (ret)
>>> +            return pcibios_err_to_errno(ret);
>>> +    }
>>> +
>>> +    *links_reg = get_unaligned_le32(data);
>>> +    return 0;
>>> +}
>>> +
> 
> Thanks,
> Tomasz
> 

