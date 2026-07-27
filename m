Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5154C531D0
	for <intel-wired-lan@archiver.kernel.org>; Mon, 27 Jul 2026 22:47:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5030B6079F;
	Mon, 27 Jul 2026 22:47:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3anf6HLVeZGX; Mon, 27 Jul 2026 22:47:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 42A1260797
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785192427;
	bh=TzWHPDlA9GvETvj7Xa6EvoraNBLD9PaKyldHLPWQnMM=;
	h=Date:To:CC:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wG2ipDe6nm3q7KzQhNVdzxb2pLbpSyFJ5Q56kKy6+OZzXdEAjzRX8jqWcg43DzCRn
	 RnVRM7hQGVuaUkbHVzwe94UYfubrnjE7i5kv1B2IvewjZaOJgkTkEWYPAhYFee7IsZ
	 AOsa1tVEYyvBpvmaNwddh0tTgmKXJ8hH0qj5VncS1+ypiJkNll4id9ahF99NTt/5wm
	 earYUuxqxyd1X6cvuRArDK2v6ZhZOlfUiWZO3cERtvqW6yVthD/naHgJ6VW88RdTZp
	 P9FiVRkLV40O1CqseLmn7i38iDd+2M59E7/ZlJ15SN4zb0LNlRQiY0bPAklZdR1wlG
	 diubQsuNSQqqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42A1260797;
	Mon, 27 Jul 2026 22:47:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C3AA33B1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 22:47:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B4C2B40098
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 22:47:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SAqvKV36vheD for <intel-wired-lan@lists.osuosl.org>;
 Mon, 27 Jul 2026 22:47:04 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BDA6C4005F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BDA6C4005F
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BDA6C4005F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 22:47:04 +0000 (UTC)
X-CSE-ConnectionGUID: cWl67l1GQeiOkKSQafwPwA==
X-CSE-MsgGUID: R13rm+2KS4y3eEd19AhvWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="111314655"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; d="scan'208";a="111314655"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2026 15:47:03 -0700
X-CSE-ConnectionGUID: qJAZnhC4SKOb9E5RawxbmA==
X-CSE-MsgGUID: gXPgY3tHSM2uYbN4Q9uDeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; d="scan'208";a="263323660"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2026 15:47:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 15:47:03 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 15:47:02 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.6) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 15:47:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PueMIzx76rQjf1edOJdgjYY/1E55gGA9kY7up6DKKniijPKrSzkKNeZu/rBO5cHjjCw4o//J45UAWlUMTeWwFbWGfbcnol9cVa1IvRLs3/94URdcLBtYlXXNyg1f37Sk9zx7zuKyOWyVdofv7RtiumovMDBytziubqcjb6XMQaCCQIPJ8QktTlspq37hbA8iOhLKKpSGHsBP8G2MV0Q3gLHhNRxNPueGiXF6SAbTbEvI9Sml545MTosz2kBF7ekseQgDrrXtwi2QOuGeRirdSZELbLzw3ZwuzBpPGSdPu5Kb8g3SjyBR4s+ExGzXk0gwnoAaZ2Y0gtag72egPlsfgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzWHPDlA9GvETvj7Xa6EvoraNBLD9PaKyldHLPWQnMM=;
 b=JeXFZxn9ldknsNZxnmq60i1M2jifv99HOCahFMw+NCa1opW5P4344zcFRs1Km9kbEmm5u8SYE0sy7HgMLj+jqdw9d7jlMOGDZu5yK43aQyhISipmf+dr6nzk0lT7jO+A9WJb5IdnibS9WXg8+wtCPRYNIO1jfRvmoSrFqsq/epgiV9XfjGIJE+X8Po+3JFA6YD3/lwQu6r6ddVTnmI04/dUqehOqUDyeAE6LXtUvZS4CYxdnudlgGLGGUmIQOikp1bOJ+QtyapMF/sMLFD4s43MoBxER7tDsPfsvYApvlziQhLj+sxKQ2daTzcvfkItTo4MTxC7ILnX7veeo+D1/HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by MW6PR11MB8391.namprd11.prod.outlook.com (2603:10b6:303:243::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 22:47:00 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 22:47:00 +0000
Message-ID: <b59ba5e0-6963-45f2-a449-33541333bee8@intel.com>
Date: Mon, 27 Jul 2026 15:46:56 -0700
User-Agent: Mozilla Thunderbird
To: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>, "Oros, Petr"
 <poros@redhat.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Ilichev, Konstantin"
 <konstantin.ilichev@intel.com>
References: <20260720120151.2675206-1-przemyslaw.korba@intel.com>
 <20260720120151.2675206-3-przemyslaw.korba@intel.com>
 <eea8692e-f8e9-4bae-beb8-e33f7508aa9b@redhat.com>
 <PH0PR11MB4904BCF668048B4C03282C3494C02@PH0PR11MB4904.namprd11.prod.outlook.com>
 <PH0PR11MB49044A0573D481C4588313AB94CC2@PH0PR11MB4904.namprd11.prod.outlook.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <PH0PR11MB49044A0573D481C4588313AB94CC2@PH0PR11MB4904.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:303:2b::26) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|MW6PR11MB8391:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f72b008-0ae8-4e37-a516-08deec30f820
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|6133799003|18002099003|22082099003|56012099006|4143699003|5023799004|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: /dN+WUtAw7MjK6yE/Wbg4jiO/z6ScWJ0Hku59bFffC+ZfRq+ZO7Pui7ghgwO3ohaJW2PFVFechRBynx3oTPOD5d7aj4CqGvwTNCSQQrVfDVZqKJ0HvzRqsMw6yy9uT8ty3Kug5WPjjWTnnzscVqTVZQUaVdrO41jNGWcthLkItgEORxc0dc0nI9U2oC5QKc4ucQyA9ngqSmd5gQLpvYl10VAVvyd+0Wan3ZPVzBQeV0kcOxdJ+xQ8MX5pt57c0g9MgPlBZkyQ4KvH8EIZhhDLtG/nMfpaFW0ZiwgxY6qEvpL0LNz0Im7uJRxyQSKa0IewcVFm5jswUEFf1bswL/1BdZb5tAdNh85iC7bylvyipsaQuYjIg/63vVq3EvN+HLsSh/hyfxnYaFLkYtHN+Cq9gFleu8VWMc/I0cpjJc5nG8MGhejFZvC9Dt7BeiNY+UnyqRXfQ/IvBn7G+1KZb9lGR3yJFLYpy+hj5whtJ0spTQac4K139zjEJvAv/+rJqj8eNEObih2XUCDlOdDeAh7SvYX+JXH6zXIyvWXQY5PrTH5Ulg0sAHVvKVe8LY71JnqyH2ptkqq/el/NCeGAbXBuGVQlZTdS6chpzs8gr80C2+3Zb/Q2aOJ+PAc890tAV6YdGD0mRHONyOWiSorFfsmjtWLLHNwWpa4y04mTAp14Os=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7381.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(5023799004)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dS9mcWozSVpkZEl4NFhmeHZ4SHcwVjVwUGV5SDEwK1BnYlMzeE5SKzZwbHZk?=
 =?utf-8?B?bFQ2SXBiMkhmZHpES2o3MjdLM3N2N2tlTjNVVnRKN0YrVlllL1VnWURTdFBi?=
 =?utf-8?B?OWh2OUN4cWNFTlMvSGVLK0luOGxsWnkzVXZybVhtM0hmWFcvM0xGN0YzTkc2?=
 =?utf-8?B?NlhoMWE5TTN3WEN0czlKQk5JQTNvaEppRXlqNk5EUEltNWgyRC9FRWdGMEVh?=
 =?utf-8?B?RDNaempwdUxhS0hrNnErdUpvRi9GUGhRWFdlY1d1NGNNVCtScDJaTGZRS1VW?=
 =?utf-8?B?MzR4Z3JtQlJmckRtSkhEQ0ZkZjNidG9qNzJhQUNwa0t5Tms2OEhNcllOMUxG?=
 =?utf-8?B?NHUvR0JCckhsRXdJUFkzWE1qa1E4U3B2RGhUb05yNlpnRlhBekVSVGdZL0pI?=
 =?utf-8?B?WnZ0MVlvSHFQbHhoL1pSL2FCUDhPd2hSSkREV3FoM3o2MjhLaDFjOXIrR3dP?=
 =?utf-8?B?enFsM1ZJMDhMSVozaWFCSzliWndTTjZZNkRRTmZKeGg2ckpSb0NNMWVtZTBT?=
 =?utf-8?B?bysyUUJFeXlVcW5OaDI0OWZIRmw4WFNkNm5peU9uWUFWZ0VmNmViWkMrbS9Y?=
 =?utf-8?B?dHZISkJmWXR2M1MxWFRxcC8ya0cxaWZXNzllZ0dueTFUczQrTFlNQ3NVcEI1?=
 =?utf-8?B?WVgrdTJPRGFzQjdwMXI3d2YzZjJoYVhLZ2trY2cwTlhFaHhrNzdhNEd0ckwz?=
 =?utf-8?B?Wlc4MG1haEVzWnhhZWwyZ2FMT1pIeU5RU2liN0c3RUU3T2pmTG9UNXA3dFJ3?=
 =?utf-8?B?anJHUlJHRm9uRHIvWUlMVUdxamZsY3FTMk5nVlhGc3dKcFZlM29nSGJ5d3gv?=
 =?utf-8?B?bitOZFh5TWVsbWEzTUJOUlhNSjBRZXd2MTFnWjJTenY1LzFvTWN3dExvck4x?=
 =?utf-8?B?YTFQVEl0Q3VlSDM5UDZXczJhSUFTbC9WMWcxcjY5MFdoRU9Sb29SVnAvSFhn?=
 =?utf-8?B?N2FzdFFSYTFzTHRuY1EyZVh4Qno3cjlidVU0S0VoVzI2Yk5QUnRNdGtvT3c4?=
 =?utf-8?B?UXZ4ZDJOL1VsS1IwNUs1V2FDcExjSkphUzBDaVUyTUtsYUk4UkFIT0VuUWtQ?=
 =?utf-8?B?bDlWc2JyWUJ0U0k3ZHVvUG5YdWFJRzJHVjErdUJrUWdycDBBKzRTK1RTT1Vi?=
 =?utf-8?B?S1g1ZGprU1pncWM4VCtlamI4YXEyVlVkV2FLYnZwNldYMlB3RGFIZ0VRZFA4?=
 =?utf-8?B?MWFIaUxVYXMwWXJmSzNhS2J6WTlYUzZrL2drK1RJRld1MWJsbUdDNGFpVElG?=
 =?utf-8?B?bzhZR3R0Rlo3M3F1b0xQOUZLSk9SOGJPeUFCOWEwNklKVGZ5eVd0aUtDMzUz?=
 =?utf-8?B?clp0T3pUempPckhnVkZ1UE1LRHJnTG5CalpvOUJ5Z2RoaUpQanZaajBjU1R5?=
 =?utf-8?B?MEZaRStkbWlES2tkOHF1SGcyakdkNS9GeS9xbERIT25sdGtZM0N6c09Ic2hT?=
 =?utf-8?B?SjdmSUZmcCtmRXk4VDV1enNQbHFhSFZMbDVLMDZpb3RHUlZueEhybS9hT01W?=
 =?utf-8?B?YVhMREZQV00zM0xlOGpRNTAxN1RRQlZxaktaaEkwRDlJRmhnNnNyc1BlWE5U?=
 =?utf-8?B?Q01uV3VqMEVlZHl4N2F3OVBsaGh2bzUxa1ZReHdES3VKeGlmM0VNeGdqczM2?=
 =?utf-8?B?bTN6VGxPVHNGVE1aOTg4N3NZV2tGeHMrcVg4bkxrbmVRdW0zaG9tQ1lSWVYv?=
 =?utf-8?B?Zld1ZVdreEVhbnBjazcyWHdJbzRTL2ZoUjBNNkNaTHdWVW9nWDRHRStlR1Uv?=
 =?utf-8?B?eXpVajhQUlRQT0IwQVd6RDYxMWpOQ0ZOYk15NXNuT3NGV2ZDM0t1RGZneFc1?=
 =?utf-8?B?Z3kvZzgraWRxWENYaGttd1crcnBLNWtjbkNzN0hYYm1XRWw0eUFoVzhxV3Vz?=
 =?utf-8?B?QXlRUzNBZ29uZ2RUWEplbktUSDF6eHM4c3ZjWWNQYVZIVmljRURKeFl2UDBE?=
 =?utf-8?B?N0doVHBTM3ZFWDM5K1ZiMVlXeDg5THhxYXVPZDA0SGlXaW1IeVVOejRibEo4?=
 =?utf-8?B?ZjV1SHVDdkg4YjE2TFZpV1lrRjNwMUQ3elMrT0cxTnBSbjg0WGRRUmFoK1lm?=
 =?utf-8?B?cmdMaDFtdnh4TEJzdEhzNHA5b0FJY0NBRGRBT05rYWdzcEI0T2c2N2lnWVBR?=
 =?utf-8?B?cHU3ZlptK3cyNkxhSTgrMnlYT2QwVnpzTlB4SkxZVzRiQWxxVFQ1T1F6VUho?=
 =?utf-8?B?YnZqckVVMStKUDltYWhrdzNCT0xrdVpvdVdRMGlIVksvSFhaUHcxTWM4VjdG?=
 =?utf-8?B?Zm8xMlIrZENVWWJ4NGxsYS9rWjdUekNoaVp2dytyK0RxZkZraFZieWpNNWZK?=
 =?utf-8?B?ek44Qk9qcG1mZ3hJcTFpS2lVcDlXc2hpeW9LQ0J1aVRobkk1ZzhsUT09?=
X-Exchange-RoutingPolicyChecked: iYKplijPcCXqSKxYUe6zsWXKr1u6j65qYS/fn+LI2fqIt40U1BkcAka8RTpXBBu8Iagm2inyKkB4sQV7Yu6cLISa8C0bA0VBQjaqBKpVTHi7Y1NhnSqrEL2G49cK3f/Il3tb05iYoc84XsTm6ooAbOV2IeM5GDNSCKB1h/tjwN4Ggxm6K3L2cwCdsnff22u5yHklBgaJ8tjts/X/fXhlfIuWalm1ZTaviHkptIkL3fL2+C9LnkNHn7h8JilfBewQr540y+5bZVm/Ryu64XV+7cRynJO+uHiR/njTt/z0wmTiGfJwlUSWoyNEr7SR4ROb11aGh4V4bY6SkxIAQqbLlA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f72b008-0ae8-4e37-a516-08deec30f820
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 22:47:00.0408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hivaNqXAuFuOFrzrSpkUQG+D7ryYDBLno8RGXrwYY6SxIFeCy/42q9cz/Ei6pZmxr66Qj1kmMej7Nc7fSYPlmkCi5P5eU/1yRz4TU4ufhQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8391
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785192425; x=1816728425;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=F/EL4Jc5KtZLYooPCPIlsrKj513ptlBel/96uu8ZcB4=;
 b=QiAuKyI7oQck4CZkqJw6u4/Iw1h5ZTm9JsMQ2sCoKLG6Q3GTPcfvOw+i
 W3sty52uvGE3yFhrGojxV+9co40DpB7QdCqJUDwzw5V3laRy0L4pFbTr4
 4GI6bRQSgRDI32k4wCngj8OhgSAZ114rlfqBZuK061Z2rkIsxj7NQPpH0
 m9+eA6vfZ747AKMpGOlieCUWfx1IL9IwZFMaCSifpT2iGVA76WS17w1/K
 2hgd7nOUTI4jILWQ/kREhYKfXerUFw7GLoExzEVePAJS8HsFu6ShrC35b
 34RNVFEtx6Cf/2N1y8ua/2iodbOQ+ICx4putNenAL/BnndWZ5y2ZQzjoo
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=QiAuKyI7
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 2/4] ice: clear unexpected Tx
 timestamp ready bits to prevent stuck PHY
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

On 7/27/2026 1:21 AM, Korba, Przemyslaw wrote:
> 
> 
> 
>> -----Original Message-----
>> From: Korba, Przemyslaw
>> Sent: Thursday, July 23, 2026 3:16 PM
>> To: 'Petr Oros' <poros@redhat.com>; intel-wired-lan@lists.osuosl.org
>> Cc: netdev@vger.kernel.org; Kubalewski, Arkadiusz <Arkadiusz.Kubalewski@intel.com>; Loktionov, Aleksandr
>> <Aleksandr.Loktionov@intel.com>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>;
>> Ilichev, Konstantin <konstantin.ilichev@intel.com>
>> Subject: RE: [Intel-wired-lan] [PATCH iwl-net 2/4] ice: clear unexpected Tx timestamp ready bits to prevent stuck PHY
>>
>>
>>
>>
>>> -----Original Message-----
>>> From: Petr Oros <poros@redhat.com>
>>> Sent: Thursday, July 23, 2026 10:27 AM
>>> To: Korba, Przemyslaw <przemyslaw.korba@intel.com>; intel-wired-lan@lists.osuosl.org
>>> Cc: netdev@vger.kernel.org; Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>; Loktionov, Aleksandr
>>> <aleksandr.loktionov@intel.com>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>;
>>> Ilichev, Konstantin <konstantin.ilichev@intel.com>
>>> Subject: Re: [Intel-wired-lan] [PATCH iwl-net 2/4] ice: clear unexpected Tx timestamp ready bits to prevent stuck PHY
>>>
>>>
>>> On 7/20/26 14:01, Przemyslaw Korba wrote:
>>>> From: Jacob Keller <jacob.e.keller@intel.com>
>>>>
>>>> Clear orphaned timestamp ready bits left in the PHY when a packet is
>>>> timestamped just as the link goes down. The driver clears its software
>>>> in_use bits during link-down cleanup, but the PHY has already latched
>>>> the timestamp, so on the next link-up a stale ready bit from the
>>>> previous link cycle remains set with no matching in_use entry.
>>>>
>>>> The PHY timestamp interrupt logic will not generate a new interrupt
>>>> until ALL outstanding ready bits have been read. ice_ptp_process_tx_
>>>> tstamp() only iterates slots set in the software in_use bitmap, so it
>>>> never reads these orphaned slots. The result is a permanent interrupt
>>>> deadlock:
>>>>
>>>> 1. The PHY has ready bits set for slots with no in_use tracker entry
>>>> 2. The driver never reads those slots because in_use is clear
>>>> 3. The PHY refuses to generate new timestamp interrupts
>>>> 4. All future Tx timestamps permanently fail
>>>> 5. Only a power-on reset can recover the device
>>>>
>>>> Clear these stale ready bits on link-up, in ice_ptp_link_change(),
>>>> before any new timestamp requests arrive, scoped to the affected port
>>>> only so timestamps still pending on other ports are left untouched. For
>>>> every affected MAC the clearing iterates the not-in_use slots with
>>>> for_each_clear_bit(), so a pending software request is never discarded
>>>> and tx->lock need not be held across the PHY access:
>>>>
>>>>    - E810 is skipped (guarded by tx->has_ready_bitmap) because
>>>>      ice_get_phy_tx_tstamp_ready_e810() returns an all-ones bitmap rather
>>>>      than a real ready status.
>>>>    - E830 and E825/eth56g read the real Tx timestamp ready bitmap and
>>>>      clear only the slots the PHY actually latched, via
>>>>      ice_clear_phy_tstamp(). If the ready bitmap cannot be read, the
>>>>      clear is skipped and a rate-limited warning is logged.
>>>>
>>>> On every MAC the ready bit is cleared by reading the slot's timestamp
>>>> memory; the orphaned bits linger only because the normal processing path
>>>> never reads those not-in_use slots. The link-up recovery clears them by
>>>> reading the timestamp memory via ice_clear_phy_tstamp():
>>>>
>>>>    - E830: add ice_clear_phy_tstamp_e830(), which reads the
>>>>      PRTTSYN_TXTIME_H/L registers to clear the entry, and add an
>>>>      ICE_MAC_E830 case to the ice_clear_phy_tstamp() dispatch.
>>>>    - eth56g: ice_clear_ptp_tstamp_eth56g() reads the timestamp memory
>>>>      location, which per the PHY spec is the operation that clears the
>>>>      entry's valid bit and its corresponding (read-only) ts_memory_status
>>>>      bit. The ts_memory_status registers cannot be written to clear a
>>>>      bit, so only reading the timestamp memory has any effect.
>>>>
>>>> The new for_each_clear_bit() loop runs from the service task via link
>>>> events. During device removal, tx->in_use is freed before the service
>>>> task is stopped. Fix by stopping the service task at the start of
>>>> ice_unload(), before ice_ptp_release() frees tx->in_use.
>>>>
>>>> Reviewed-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
>>>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>>>> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
>>>> ---
>>>>   drivers/net/ethernet/intel/ice/ice_main.c   |  1 +
>>>>   drivers/net/ethernet/intel/ice/ice_ptp.c    | 72 +++++++++++++++--
>>>>   drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 89 +++++++++++++++++----
>>>>   drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  1 +
>>>>   drivers/net/ethernet/intel/ice/ice_type.h   |  7 ++
>>>>   5 files changed, 149 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>>>> index e3d3810c791f..231d533309cb 100644
>>>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>>>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>>>> @@ -5169,6 +5169,7 @@ void ice_unload(struct ice_pf *pf)
>>>>
>>>>   	devl_assert_locked(priv_to_devlink(pf));
>>>>
>>>> +	ice_service_task_stop(pf);
>>>>   	ice_unplug_aux_dev(pf);
>>>>   	ice_deinit_rdma(pf);
>>>>   	ice_deinit_features(pf);
>>>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>>>> index 1aa440b0639f..9d9d9958fe5c 100644
>>>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>>>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>>>> @@ -1372,15 +1372,73 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
>>>>   	switch (hw->mac_type) {
>>>>   	case ICE_MAC_E810:
>>>>   	case ICE_MAC_E830:
>>>> -		/* Do not reconfigure E810 or E830 PHY */
>>>> +	case ICE_MAC_GENERIC_3K_E825:
>>>> +		/* Do not reconfigure E810 or E830 PHY, but on link-up clear
>>>> +		 * any stale timestamp ready bits left over from a previous
>>>> +		 * link cycle. The PHY may have latched timestamps for packets
>>>> +		 * in flight when the link went down; these must be cleared
>>>> +		 * before new timestamp requests arrive.
>>>> +		 *
>>>> +		 * E810 does not have a real ready bitmap
>>>> +		 * (ice_get_phy_tx_tstamp_ready_e810 returns all-ones), so
>>>> +		 * skip clearing on E810 to avoid unnecessary sideband queue
>>>> +		 * operations for every not-in-use slot on each link-up.
>>>> +		 */
>>>> +		if (linkup && ptp_port->tx.has_ready_bitmap) {
>>>> +			struct ice_ptp_tx *tx = &ptp_port->tx;
>>>> +			u64 tstamp_ready;
>>>> +			int i;
>>>> +
>>>> +			if (ice_get_phy_tx_tstamp_ready(hw, tx->block,
>>>> +							&tstamp_ready)) {
>>>> +				dev_warn_ratelimited(ice_pf_to_dev(pf),
>>>> +						     "PTP failed to read Tx timestamp ready bitmap on link-up; stale PHY timestamps may
>>> remain and stall Tx timestamping\n");
>>>> +			} else {
>>>> +				/* Only clear stale ready bits for slots that
>>>> +				 * have no in-flight software request. Iterating
>>>> +				 * the not-in-use slots skips any concurrent
>>>> +				 * ice_ptp_request_ts() allocation without
>>>> +				 * holding tx->lock across the PHY access. E830
>>>> +				 * and E825 reach this clear; E810 is filtered
>>>> +				 * out above by has_ready_bitmap.
>>>> +				 */
>>>> +				for_each_clear_bit(i, tx->in_use, tx->len) {
>>>> +					u8 phy_idx = i + tx->offset;
>>>> +
>>>> +					if (tstamp_ready & BIT_ULL(phy_idx))
>>>> +						ice_clear_phy_tstamp(hw,
>>>> +								     tx->block,
>>>> +								     phy_idx);
>>>> +				}
>>>> +			}
>>>> +		}
>>>> +
>>>> +		/* E810 and E830 need no further PHY reconfiguration */
>>>> +		if (hw->mac_type != ICE_MAC_GENERIC_3K_E825)
>>>> +			return;
>>>> +
>>>> +		/* E825 recovers its Tx path by soft resetting the PHY
>>>> +		 * timestamp block and restarting the port, but only on
>>>> +		 * link-up. The reset is a three-step register toggle; if it
>>>> +		 * fails partway through, the port can be left held in reset,
>>>> +		 * and programming a PHY that is stuck in reset via
>>>> +		 * ice_ptp_port_phy_restart() would leave Tx timestamping
>>>> +		 * permanently broken. So warn and skip the restart on
>>>> +		 * failure; the sequence is retried on the next link-up event.
>>>> +		 */
>>>> +		if (!linkup)
>>>> +			return;
>>>> +
>>>> +		if (ice_ptp_phy_soft_reset_eth56g(hw, ptp_port->port_num))
>>>> +			dev_warn(ice_pf_to_dev(pf),
>>>> +				 "PTP failed to soft reset PHY port %u on link-up; skipping restart, Tx timestamping may be stuck, try toggle a
>>> link to recover\n",
>>>> +				 ptp_port->port_num);
>>>> +		else
>>>> +			ice_ptp_port_phy_restart(ptp_port);
>>>
>>> We hit a regression from this hunk while testing the series on an
>>> E825 T-BC system: after the soft reset the port no longer signals
>>> latched Tx timestamps. Nothing re-enables the port interrupt
>>> configuration (PHY_REG_TS_INT_CONFIG) afterwards, the only writers
>>> are the clock owner init and rebuild paths via
>>> ice_ptp_cfg_phy_interrupt(), and ice_ptp_port_phy_restart() does not
>>> touch it. So the first link-up that takes this path leaves the port
>>> without Tx timestamp interrupts until the next reset of the clock
>>> owner PF or a driver reload.
>>>
>>> Regards,
>>>
>>> Petr
>>
>> Hi, thanks for letting me know. I will look into it.
> 
> Hi, 
> If I am not mistaken, Jake Keller sent you a patch fixing the issue with this patch regarding PHY reconfiguration.
> Did you have a chance to test this? If so, I will implement this fix in the new revision.
> 
We have a patch undergoing testing, but I am not confident it will fix
the issue. I believe we have a gap here where the ice_ptp_init and link
state can race such that the PTP state shows the link is down, but we
never follow up by calling ice_ptp_link_change on link going up.

I'm still trying to investigate the full path, but I think the patch in
this series which removes the call of ice_ptp_link_change from ice_down
and ice_up is possibly the root cause here.

I am not certain what a correct fix looks like yet, and Petr and I are
still working on reproducing and confirming the situation.

Thanks,
Jake
