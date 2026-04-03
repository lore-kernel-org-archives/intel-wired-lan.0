Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC692EEB577
	for <intel-wired-lan@archiver.kernel.org>; Fri,  3 Apr 2026 20:56:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D2E440F36;
	Fri,  3 Apr 2026 20:56:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iAF0qt8pJhdJ; Fri,  3 Apr 2026 20:56:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B9ED140F1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775249769;
	bh=9IcggvIw51VXQc5kmpojwMuyOGDxk9GgVUzRIcVqTNs=;
	h=Date:To:CC:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pOJ1ap7GjYx+ok6XnrYFO+1mvLd5vZuLqL4ftdifiz0EGiVwQQgkwFGBq0K/py5dA
	 B/KOrF6B/UHfrJqksMpDTLNb6Uj1nOEc48bNWym3BYd6GQ3Ys7uXAsOr9U8gfNUtQ2
	 yrp13j83cvryyZFqCHcTvQ+gkLtLH9njY7EWOXezU51Ozqc5hkg3tvmFM6gZtjMuYo
	 56LFVlmQmNP8Mpxo7vSuGe0GnMSvvMyj8iXORPF06+f6VBwXZSmVJ4zYWpNGhDe8bl
	 SUr5ONeuKddf50EVinC/Kr6VfOYtMl6Bm0qpld/t0NqezO56G3BUlV/OEccRsdUde6
	 G0QobJhKj7How==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B9ED140F1B;
	Fri,  3 Apr 2026 20:56:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 01B3CA48
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 20:56:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E6BB46070F
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 20:56:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Crh-RZZnSb2C for <intel-wired-lan@lists.osuosl.org>;
 Fri,  3 Apr 2026 20:56:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=anthony.l.nguyen@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org AC27960707
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AC27960707
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AC27960707
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 20:56:05 +0000 (UTC)
X-CSE-ConnectionGUID: xIrV772CS0aqYFGsjP3V4A==
X-CSE-MsgGUID: 7J3bJ67GQziDFr586vX9/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="98929753"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; d="scan'208";a="98929753"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 13:56:06 -0700
X-CSE-ConnectionGUID: LaV+Y+AyQ9aERIzBC26Gbg==
X-CSE-MsgGUID: yrv8hGj8QxevCU8VQJ5Eww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; d="scan'208";a="227593179"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 13:56:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 13:56:04 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 13:56:04 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 13:56:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ig2sT6lu+N6wIXe91NayEwLvxl/54OamFM5ay/D23U1T3woo4x96UGHi71xqdO2vYk5NnoRJwAdOVYHxzkr7MclJWnZcFnqcx1rIQtn5GHG+GbQqTpJaKXYwV1MWnH1v8EbaZQ9pYMpMgT5fsJU6ixRbOlvhiSQavIieGR+jHT7PV2J/Vfssko+pl0Cp0bJWbWa/lmXeMF8jcpmDcoEnXPtQAZENHlvgIuptZONGkipcxxO/X296siDV4p9GynG2r4zioXAgMBDxpzukMKQXV8UqkkpU0I/lP/cI6f8KcihBS86HiyxRsqncudVcUDr09IOfKATjTjU+JkwXv4A4Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IcggvIw51VXQc5kmpojwMuyOGDxk9GgVUzRIcVqTNs=;
 b=TBnKx3UTYSOLfddhRaOSK097Wvhh92ufGnCfU3G1zEa7iS2Ik1qMz71lsO5KIvaYwwsmZ5Neln9qEeiMHIiZxNEU21vJJPY+ox+78AT1wr1KFL392oMoJXUMCbkWkMUkG8W7Vs7AtD4MzE/X/BO0YT+ylnsEiaJzkQ4ZLrYvGUOvsbRu5rIFtqV0dedEnAPlaBbf5cjJwQDlMsqGU6g0hzcFdg+LMALotHtkJgsiIC0XnJ2cvRJxjkD4K06ZBARYRlWkGmaQSEXGXDI6/o1VH40x64DvRus9g/wVlDPYf3DXAuOmi6sBXpN8lfDs1NxvQfolQCQv5XPYLd2m57DsIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Fri, 3 Apr
 2026 20:56:02 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%4]) with mapi id 15.20.9769.016; Fri, 3 Apr 2026
 20:56:01 +0000
Message-ID: <32168654-edbb-4fab-9d3f-025aa1666513@intel.com>
Date: Fri, 3 Apr 2026 13:55:59 -0700
User-Agent: Mozilla Thunderbird
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
 <20260327073046.134085-12-aleksandr.loktionov@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260327073046.134085-12-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0376.namprd04.prod.outlook.com
 (2603:10b6:303:81::21) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|MN0PR11MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: 13e5f597-7949-4884-7275-08de91c369ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: q3rCOPjPI2n4IZHuay5oHxl4WNQVnRMSoMOqGrP/4G6sfQJeEBLYMHBy7ssTZc0um+ft+YL/Xk4QFStZJvxZ0oa9t28hBmWtD9sOXBEYlD2ZV4pp5RUG5kuqJjzhKSgt8aHRoC7aquUjieP2uzikhGQg6rn7oF1ZYcmUwafeli7SK181Xsvol9KAqRHwJhZBAFu5ZJLDfLlrJ6fZuqYxAVe42tWrkZvxYS1Prg3I6cLqzyGYJQr/AmDpWZ77vjOHAHhLd7k7YAfkGABb3UDmI0f4FrzdMMY2sekzmVLVWOKLwMDVcpE1fz714u8IckN6NtW8Uty07c/+Ez+GK7hvt1YAanGVAFSPZnTSSh4ur3NXtdUsQMaIcEisqh4TQjdjAzdMKZ85ISGGLyueyHwNBncZBigNQ94KJv3aazxR9++mRAp7KoLjJzZTyiIgfGXv3CQPWOY8oGk2ARzJXeD3W1DcoahzPHcE8urCWs7H7bazzIj1Xyx0R1zErTJUOArLc+ODFMHWtPG77Bp4bOe3ARpa7NKgioFFnzrvQWQ/LqP52oWEt4KwS7aZpxEsfuY2H3ACmKgTA5kB+ynMz2SZnJLUp1bmrK4mXoGP1aTVAV+9aFUAeLHtBWxDOE0nDwqbOUJWK02ZQnzhl3XCt64aXObZgHpogeDFF2WF2mdGcim+eJoAl6VQFdpFVDlVHBrZPU9eCnwiKjOeOW/Xt0grLGrjix3VJZb+ebtsKp1a+Ts=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8230.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0NYN25sakdSYlJ1SFNjM01SS21UUlJMVzN4SWJZUVl1SEtvcnpuK0F0RGFG?=
 =?utf-8?B?VG4yMW1WVHFhVGtqQVl6azhDdFNXd1l3ejdxVGNRZzZLczZXdjcyaFdtT2Z0?=
 =?utf-8?B?VHZkSy91WGgvWmlJbTEreHJJeFFOWUhQYjYrOVdGT3VLUXZDWStNVW5rSEhT?=
 =?utf-8?B?L3k2UUtsNWdzekZNazN1Nm54enUzY2NzQStkSE1pMHE1RkMrLzZxcEk3RVZQ?=
 =?utf-8?B?d2prMXExU2hSOFZ4a04yaHVvYmNrTEV0aEZVMDlVWjloQ0FJQTVRSURZVjd3?=
 =?utf-8?B?aDJVTUtkSjFmNVM3cW5PamRYS1B4YllCQ2lkQlBCSldENmNOamMyNnA0MGgy?=
 =?utf-8?B?SXZYMEJIMGxLR1dGUENRYldubTBma1VJZW1Lc3FEMVVmamRRR1d1ZE1pMWFp?=
 =?utf-8?B?ZW5PdlZvdHF6cEZqTW1KcEFUR3RBdm02Z0xKdHNlazJYV1lHRndQdlY2WGw0?=
 =?utf-8?B?Y2RkUnppcjQ0MEgxemU2U2o0UCtUQUE2QXNUYWUreUlKcC9teUN5c3pyZUVQ?=
 =?utf-8?B?bTVtSTRYcjJoQnNhRjROUnJJTjJDYWRXWlhkL0E5d3BITys2MmFyejdjTnVU?=
 =?utf-8?B?TXAwWko0S0Z4RzQxSmdmL211NTdIcXM4bnBXUmR0L0ZKNmNJYUhTWUQ0RXRW?=
 =?utf-8?B?YjhZRDJxVnQwZTFtOFFFMFBlc1lLdCsvWFprbkZldU1mVWh1ZW1WWjZ5N2tm?=
 =?utf-8?B?RWI5WVNuRVFlWFpPb3U1c2VFZE1zQzd2NWsvenNjTEdaRUIxRExpWjR1QUVG?=
 =?utf-8?B?WUcrVGU1L2txUHlJcFN6d2ZtNW5TU2gyc240dTJuUW1qbm9qYldPQmN3dlJP?=
 =?utf-8?B?QUt1ZmR1ZEhPTDJuWCszSFlwOXp2OHlOa1lGVkNqVFl4bmtPN3VwR0xiRUlo?=
 =?utf-8?B?U3Z0ZStOZ0VJbVFqMDQrK3dOY0lXWjBtWXA4c1Joekc3T2pHNSt2QUJzZmtW?=
 =?utf-8?B?VFpZdHRBOGVXd2pXc1d3WWxOMjh0cWtpNDRSbENpamw0RDRUb25nLzlVS3Rh?=
 =?utf-8?B?WGorQlhFd2pOUldQOWU0ZEdtY04xZUNIZzZhUTQxajlJWmlhcG9zZXgxVzBu?=
 =?utf-8?B?NWlQQnVXSDdEUFVQMU84MldkNkZhV2xDcWthc3Z6MEZZZ2NkRkRvejlTeCsr?=
 =?utf-8?B?ZE96V084Tm1LaTRDNC9pZHdLM3pJTnBXRTlLbTRWbDNrRTNCNEM0SHNwVnph?=
 =?utf-8?B?eitvQ2pqU3Vyd0pGNEtFRUYrMEo1dUFqM1pMN0ZEWUFoeFRJNDlpN1FvZ0Ev?=
 =?utf-8?B?NStjR2labEdhb2Q1eDJKcG5DWiszSHJ6Q2FCSk1FazVEZmFoYTFQNFJZZEE3?=
 =?utf-8?B?cVM5NWZNVzArclA2OXVkdUU4RENleHAzWmJnYnZsbjRZT3E2eXVNWUsrK2I5?=
 =?utf-8?B?ekF3N3pGQ2NwRlJvbkNXSzR0MTVkaHBnRE9SbGZqdmxqc1kxUU1yTjlIYXBq?=
 =?utf-8?B?a1B2R0N0YWN0T1B2Z1cwbkMwY1VkcGNmTHFSaXdHWWJwTGV4dFYyWVhMYzRt?=
 =?utf-8?B?Nk4zL2NGdERzVy9OT0MyOVQwRVJjbnFXRExRZEdQbUt1c1ozSDNoVjR5L3VQ?=
 =?utf-8?B?a3dwbzM2cDYza2hMSG9ad2tNclRkbDhoeUlVNTlBTGRXUkx3ck1zTzZQWC8w?=
 =?utf-8?B?NHJ1UGlFc1J2NWo0WGY4cEZlR2ljNVVyT1BXSzJrdDB4bERoR1dDMHk2eFZ1?=
 =?utf-8?B?Qm8zU1Y1T0ZaSDVtS0ZCSnd0RGFBTGE3VitlNnhKUGw3a0xLRGNMK3BnTDU2?=
 =?utf-8?B?Z0Qva2xpbU5GZC83WFNCQ3ZBKzNocktueDVORVpRd2N3ZVRDd1NFS0RsZVdR?=
 =?utf-8?B?ZWFtZW9YOU4zSzgwcVhEMHpGb2lrQ3QrSlI4Vno5R1RUam5jZXY3MVJ1MUs5?=
 =?utf-8?B?RkJYK1dFaXR6clZ2d3NHa0ozaWNldG4vcllaQlhDOUxhbXNOaEtkYW84a3dF?=
 =?utf-8?B?VWkxeU9xajg3dXM5eUZDNHh0WVg1eEwzYmhHKytuVVRtWk5XQTdNeWVHWVpJ?=
 =?utf-8?B?VHI4ellJMEw5SVcyQVA4eEdmWjRaTzdIZ0dvazNvL1RNM0Z3bmdyVmtQSGJW?=
 =?utf-8?B?S3JxeFJPZ3dCWngxV1pEVFVKRlMxbXFiamZsSTRyUmkzTDNvWS9rYWFyNzVo?=
 =?utf-8?B?LytqWkFzQ0ViNlJwTWRJWjlwTllEMkNHMC9iZGNucGdDU282TmlLY3dLYkJS?=
 =?utf-8?B?Tm1iZ1pta0g3VGppdERDMlhDNmZPYXFFNStGNWJSUW12WGRYdHBKR1RmZktl?=
 =?utf-8?B?VlNrVU5mWkZjY1hqRWJuNWtzNGgvRzlpVWFvMnRrcUdLZUFKTDNuS3ZtRkxZ?=
 =?utf-8?B?Z3FhSk9XLzB3dThwNXFBVTRTQ25MaFR6ZUNSYVZCSmkraGlMa3FFN2lNam1Q?=
 =?utf-8?Q?qIilxbgh0YfqjqBI=3D?=
X-Exchange-RoutingPolicyChecked: eOMznTJlDQzQ/aC8dOar+kLQqdeqCkBvDiBO8O9ZnwjPyHDannIgM0If8CGs+t1KxHX7ls5o8D9cHzk/5vsGfYnRd3LdS/oZCTLwidAdT/uLcHkOClbeiZAHJ3At9LtHO9aUZ/zbm89IhSlzmxJoJZSr+UKJaguGuVE1YuIsvGSNcJx42Lg9FUpL2qdZCv4XOlCRj3xoFmjyUnZJ6s/XEOR20PcazZNBnrvou9R9/tnzMmIxJBDPP3O0YIq4kXLeXBfX35Okc5u7HAlgBNTFiMfrmcmFvq4sAon1Y2LbyTqwhEmhXalx7SSWsxZ67Er+Fc3JvBRbKpNxMqCvZOESKg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e5f597-7949-4884-7275-08de91c369ec
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 20:56:01.6032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9LG0WylQmBVlsQ8VLomCfgUdcqs8aFak+k/zcnmQ+e59etxoZidISf6CTjbGWOmZTSJHVA8bUOuYFcA57HcjZrP3lG4nVqwYveDta1XpzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5987
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775249767; x=1806785767;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bgFYCOb5paAYh25KYWW8X0XRLO1fxx+4ebBwPSlPzqw=;
 b=HDOkTdbV6AvQpWlDeLIsNN1QScU1stw+GOOuaaMJi6u/VlWRsS8i/gsy
 c+BTeeB1cPLuAxRootmKXVEfjGIrOv7ZbDcRvbgyJj6yrBq1nPc3y3dcp
 5mevD9y64oKHyYwwK1Omg7WxWjnpSLbebOJgi25tzhCDg5z5Cbwt4feqY
 buFyeBNXLkoTi5zl3dsTqs6UzKWTRx9cBMbidpxATHHCzX8zVqkyzYqRU
 40QVHft0RVjXa1BPGcu4kEWZHKSdwW3KcIrCkYFL0pwtlJlJ1/fzdkAfJ
 o1Sern/zsOIKWsRpT5MLCYG4S839aQV5OBK9UHEObYgz7AXfLFlmg42vW
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=HDOkTdbV
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ixgbe: extend 5 s SWFW
 semaphore timeout to all X550EM variants
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



On 3/27/2026 12:30 AM, Aleksandr Loktionov wrote:
> From: Marta Plantykow <marta.a.plantykow@intel.com>
> 
> The 5-second SWFW semaphore timeout added for X550 (ixgbe_mac_X550)
> also applies to X550EM devices (e.g. X550EM_a, X550EM_x) since they
> share the same FW and the same SR-dump-driven worst-case latency of
> ~3.2 s / module-update latency of ~4.5 s.  Change the mac-type
> comparison from '== ixgbe_mac_X550' to a range check that covers
> all three X550-family enum values (ixgbe_mac_X550, ixgbe_mac_X550EM_x,
> ixgbe_mac_x550em_a) without inadvertently capturing later entries such
> as ixgbe_mac_e610 which share the same swfw-sync function but have
> not been validated against this exact timing requirement.
> 
> Signed-off-by: Marta Plantykow <marta.a.plantykow@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
> index 85047ef..298958d 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
> @@ -577,7 +577,8 @@ int ixgbe_acquire_swfw_sync_X540(struct ixgbe_hw *hw, u32 mask)
>   
>   	swmask |= swi2c_mask;
>   	fwmask |= swi2c_mask << 2;
> -	if (hw->mac.type == ixgbe_mac_X550)
> +	if (hw->mac.type >= ixgbe_mac_X550 &&
> +	    hw->mac.type <= ixgbe_mac_x550em_a)

Seems like this can be squashed with this patch?
https://lore.kernel.org/intel-wired-lan/20260327073046.134085-1-aleksandr.loktionov@intel.com/

Also, since the X550 range is 3 MAC types, I think it'd be clearer to 
use each MAC type rather than the range. It's only 1 more line and much 
more explicit on what qualifies.

Thanks,
Tony

>   		timeout = 1000;
>   
>   	for (i = 0; i < timeout; i++) {

