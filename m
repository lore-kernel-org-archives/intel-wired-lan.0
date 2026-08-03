Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D56DC55182
	for <intel-wired-lan@archiver.kernel.org>; Mon,  3 Aug 2026 16:44:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2061060639;
	Mon,  3 Aug 2026 16:44:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1o1XBjyErsYk; Mon,  3 Aug 2026 16:44:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4BD5B60621
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785775447;
	bh=iDG6ATWJNjAQtxuGu3QHp2OETZq8DnxEh/HhTPzDDPw=;
	h=Date:To:CC:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=2iYfq8BOf+mFGJJ8wmwKHGp3PgDc8cwhw4pNFnKkePojbVeIz0ZwqZIliuj21PHD8
	 2LR3FJP2nMPD7/LsYNc+fYu+YPBXhK7lE6wJ0k14zC+c4/QiqSz79OaHzF90FO/q/j
	 xwQPmD4rZ/f1pzqWsMyVCsyb94rdmpuHSPXOB8L/z4l+663AAVAE91X/l3y5bkNHk6
	 PKeTV9SvJUk3/ITwAxxYSFpo7fteKO8dL89rZxrRTMU7UoHUzJDr+yKqbHjqr+BlyJ
	 bBpHufpqlPBIQRixBToivNiw+xNCFHXFbOhFehYT2vhu2oIaan3e3ug46lIScLSsbr
	 5EnLV76iyPLWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BD5B60621;
	Mon,  3 Aug 2026 16:44:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9CE57282
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Aug 2026 16:44:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 826F8400A1
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Aug 2026 16:44:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sM0TJ4s1wJe0 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  3 Aug 2026 16:44:04 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=aleksander.lobakin@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 282064006A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 282064006A
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 282064006A
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Aug 2026 16:44:03 +0000 (UTC)
X-CSE-ConnectionGUID: ZYkoQW0JTnOSPfeVmzQXjA==
X-CSE-MsgGUID: T2A+jGy3Rs23bjQplgL+WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="96679783"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; d="scan'208";a="96679783"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 09:44:00 -0700
X-CSE-ConnectionGUID: ecyiN6lLRJCVCsuncWJPPQ==
X-CSE-MsgGUID: Llo2YzzxTsOkLkncIeqa2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; d="scan'208";a="285894472"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 09:43:59 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 09:43:58 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 3 Aug 2026 09:43:58 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.43) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 09:43:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBa+Zvl8BE3QPjSjSus6Wla2GYA8kRkkPPr5ADrrziNRXC+rnfPTI6x9ueC3V0P6wdsrzAqXEBOO+hPXDrglOSBUx29nsTqCLAF9x1OW6r/35vqBfQd73an4XI6LhZvr9T1iIvZTyWhO2Wqiv9RBUTTCE8zxmACcNFahKuqnlajzI3qCuv/LMthphbs7/0GgiwPiQ+57FJ/j8YqlFoChyxLRsa61R/KnM6ZaXaMlZv/6icM3MIxGcMFEeU/wFywvjtk3dBevRSE0NXG9iBjTjLOr6f0mwvqQdGvWFuRQhrwoyAIiGys6uWmaPeIEHuxNYplp4kPPWv1bK77mo7Usrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDG6ATWJNjAQtxuGu3QHp2OETZq8DnxEh/HhTPzDDPw=;
 b=rN6vJunhSHbLlPdp+NAyJIbaVqnKiD4hZla1tnuo618RlJfDIM2tikw+n84Z9VwaSFxrZXvOyzMTBL6+3nmM6fZFJwyKIIXl5fK0BR44DC81FbxkrUdtum2Zh+oaXt4yBR7NGbwBGaSyjd1mgue8q2VPugjUERDxXYmTHXmCGHowpeLLEFb74OaD7VZz40beLIont+jXRUmXAL/F8F1pSG4+eD6ij2kLtUsnErbxlWYWcjPOnmgx5CHXhrJosL9vf3qpuKUk2OaE1aGOLUzOHNv+rGN0fqprL1O8gJieD8VtWIwhVyUihcQ/TX824+iri+GJ0xcv9ToLrIi3lfP+fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 16:43:50 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 16:43:50 +0000
Message-ID: <057df130-7d7f-4d4c-8818-c494e4583afc@intel.com>
Date: Mon, 3 Aug 2026 18:41:27 +0200
User-Agent: Mozilla Thunderbird
To: Matt Vollrath <tactii@gmail.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Tony Nguyen
 <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>
References: <20260731124109.99065-1-tactii@gmail.com>
 <7e9a5228-d257-4adb-b472-b110f60e3618@intel.com>
 <e62e8603-a61d-489c-8df0-2c9ff98a1c02@gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <e62e8603-a61d-489c-8df0-2c9ff98a1c02@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB8P191CA0016.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::26) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: a55e7325-d80d-4084-8971-08def17e6554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|56012099006|11063799006|5023799004|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7s0OkxtDCk+nhaQdH9bxNw+7W4cUtfIuMYOVdsSwjJPY7pbBrJPGtIWxlGqofKbcj7Ru0ZHoeZcWBbdV7IvXIItTmDJ9b5llxhsBjMwF++UIhhOL2hVwLCY1EubjGWeZLOwAT9RQWAaI4vkekBvROx2dUlaYZDvzvLg+FjH+S1aiHsapeBfCQhUmk/s48xvHic8ZZ+kZszxYqe5z7/sBlKYTIIr08s05Xwx24U/4U97rdeYSpeLIMRTO+iYswhtakAAa3mE6vzH8+MVO1MqFpHTwi9Ggj14CS2VHJtE+Zj0eC6mFgTZBlzxvvR9M5w17VNwYjXT7nZ+oXMaid2fQGq+zCKZS7WsLak9f/UylCZKXCvI9Q6I9JRqcQVm0/ONTRmwnVrKB3w8V94jzKkuWZR9vnbBMgyAMepYVLzyNdkNeYUe0utm/NHPg95v8XJEolGdZ+77+tzqmoYvnIpWTOcoUKLOIjClQbcs7jVG2Id+0Jnwd435RBcv1zLu/aVpeWkbWjFDPJrnN40ZnCWjLBZBArYnB+su3wPzPy3fsnS4eZ9t+lJHvmhUJsy8NW9RJiT/NKSMAGrY72nwE1z9VZrm3fkcy7YXkHdkaidHpf9x4Dy6GHhRatBCg2d5ZbURPTjm0MjhOBUZcwEN4HRJrX6a0+a9+DXnRrG1O34FIsM4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8718.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(56012099006)(11063799006)(5023799004)(10067099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2kvUTZjeXdXVGEwQWhaV3VIbTYyY25mbjJrbU5udkRtS2h3akNueEV2THNT?=
 =?utf-8?B?dlZJRWx1aGdrTVc4cU1LMDBjSlZUOU5qeXVBQnUrWmRlODhBcXB4REJpTzQ0?=
 =?utf-8?B?Zmc3L2NSbnVveld6ZUZGSFZxVkNaOUFJM2laSjI2WWpibHRpeGduMFIrYUVj?=
 =?utf-8?B?NFJwT2NPNmdLZ2hYMzVKTGUwN1VWOEZRdkU2eDd5QWtXN3A2VWhkZTd1RFAz?=
 =?utf-8?B?QmQvOFM1akU1UVI2NmkzYjdIU3VLaFhmcGpnOUlIMmdLbzROMGJ6bjRUM25D?=
 =?utf-8?B?R3ZjV29IcVdObU9tTm1mMUFXSldsMHFwNUVrMmgxclFkN2M2aElhODQvOFox?=
 =?utf-8?B?T29DK29uM2dCbkdoa0JKVitYSVBuWi9jUVhKcHI0WkxZK05OaHhseGVKaThN?=
 =?utf-8?B?VTdoY2loVTM3d1ZHd2lYUkN0MS9rN21lWVlCVnBMRCtxT1JBVW45cnFyR0RM?=
 =?utf-8?B?VkRBQktDYkRWdHRZWVBEK3dnRGNIVVArRWVKRVdjemhXT24zNmM5TUc3bGRV?=
 =?utf-8?B?R0J1b01Vb3RUSnduSldpV3I5UDlxRWFRSFZFN0VQbURqWld1Uy9iU0trekVO?=
 =?utf-8?B?UGtobHJrUzc5Z2h1SUxJWU80QlBBbDl3NldIRUkwOExNd0UyS0hBMDNtZVBJ?=
 =?utf-8?B?d1RkdEI3L3lpbm5MMUhzYVg1ZmVpK2VaclM5Zkg3dlBldmV2TldhK0lGTzli?=
 =?utf-8?B?d0xLZGFEWmhVSGkxSXlCR1llU2tJOC9hK2VPUFEwVHg0Sk9IYXNFK2t1bEQw?=
 =?utf-8?B?cWtpbHJidG5vMmVBdXVMeW53TmhBRWE5dVdxdnR4R2ZQRVdlRWpST2JyWTVp?=
 =?utf-8?B?R3lqTGRCOFYrUTk4bnpKS2cyL0ExcTF5THFLT25scE1PSUN5SjhSNkl6QnRT?=
 =?utf-8?B?NXpZdEZTN2lJSTRsTkhqUkJoRTA1Ry8rWGNYNnlFa3JrL3RxbExmVldVbkNn?=
 =?utf-8?B?V1RPY3VNSXA1bDFyK0hzMXNiRFZxVGl2ZC9aZHBGQ2tzZjRRbTZiMldPYmVB?=
 =?utf-8?B?dE0yaEw0bERnb0JOK3RwS3hWd204U09PYndnUTBGYk94SUZxU1BOd3d0S1Zk?=
 =?utf-8?B?ejQwbCs4QmhuUXlMR0Z3TEJMcHNHZzdFNEVtWjZUc2pPZW1RUlJxdGYwWTVK?=
 =?utf-8?B?OENFSGFKOWV5dy90SVhmYUc3UVFQQzNQSkNEQ3F2R01XS2phREpXaDE0VTNK?=
 =?utf-8?B?V0tLZG01OTQwRCs5cWJZV0kzZFNaNDZPelRwK2JybWYvbnBPOTgzM1V6ZFdh?=
 =?utf-8?B?cWJQdU5SWnkwd1pkSWhENDdWc1BlSGFvV1daVGU5OEx3MHhLc2lqSkhkdm8w?=
 =?utf-8?B?MjVWL3dhcmUzZVdMeG9nWDZZNUJicDBlS2RLQUtEcVM3REFhRGhLM1ovSDRD?=
 =?utf-8?B?WkJkc1dvaVQ0T0R3M3NNaDJUWGpXVnFHcU5uVEM0ZmZDNy8wL2wvVG9oeHh4?=
 =?utf-8?B?OTB4MnNYYnZDcjB1M3JiV1lZa25VSWRjQjNqK2VGeXFueVhObmFiS1RFM01q?=
 =?utf-8?B?UDM2TlorVkd5RG1wTUpHSTJya2Z0Q1o3Y0F1OEtmTDh0S0lHZ2E3M3VlSUx2?=
 =?utf-8?B?SVRvNWZXOHlCdTdBQTl5djlERGszdFhiWHFSTlFyL1E0dkd4aFRuYmR2M0R5?=
 =?utf-8?B?Qlh5bUEzUUFpYlNqTno1clE3S1ZIQzRCUUhDWG5mQ3BUZ3dOa3hITlg1Mitl?=
 =?utf-8?B?aXBaTTJQTlBIS3gzb2dyL2J3REVXUkVxcEhUNVhFeWIrQnRjR01GcGh2RlhU?=
 =?utf-8?B?UVBmd0xWdXh0VVdEMk5DL0UrNGkyNG54dkU4U21EYlV5THlKM1Z4RVBtVTNy?=
 =?utf-8?B?c0VRY1o5UDhoUkNqYTMwL21rNGhkbFRnUThKd1ZTa3VOTWtjcVpOWVBSa2lP?=
 =?utf-8?B?bCtRZFI2WnRIblYrYTZMNUhYTm0zQWI3N0xPTkEvekhDckUxTXZ4Unk4V204?=
 =?utf-8?B?TXlXTXJkL0lnRHlrbUlCaW94YTlQRW5odERha2pqMDc4TUcwQVlaVTVLbnZ6?=
 =?utf-8?B?MVQ2OVpNYVN0SGhJTkNkdVJJcnczeGxTeXdjMmVJaUsrNkZicWlZYTRPMU1V?=
 =?utf-8?B?dXRDVzFGLzNTTzE0WWE5OFNaRmpodFExSHY3OHdOM1RvaWxYcnV2N2pMNytI?=
 =?utf-8?B?TFV1QmxKbnNPWE92YW9xUWw2VW44RncyL28zZ1FEeWxRSzV1YkU0SjZrSUVC?=
 =?utf-8?B?TWhucnBLbXJZWC9XSVZGQzg1RjVVanNENUFlVjMzSHlvYThLTWM1cmo2Nlp5?=
 =?utf-8?B?TFEzeEVFckFKM2o5NzlnZEdXUlc2aG9oSldqNkZEVTMxaEpDdGxOeXM0ODAx?=
 =?utf-8?B?YmphZmN4NEpkUk1zNWUvcjVNYklDZE1tV2VvcjdJQ01ZWktzT0tRQU1aRXVi?=
 =?utf-8?Q?G6sDYJbukl2rpoRo=3D?=
X-Exchange-RoutingPolicyChecked: ohmigxhfSQVEXncLL0nCDY5yo/kcu4jm01dy5h5pjKM+cL8FvESpEJFOLvWWnBvzIfDr6XhQ0JKAundXj9xr8UNETVQRK/KexwAik4ih2mU3sgxOtJlqRpGfx3YbtnANtMc0xGUEd2eJqIiZdZklbRqsVP8BJa2zATf1Qar4ugpU0OLBuSInlcaIrECVOKsv7Gk9hwfiDp9L2oO16YdbRjU4gLdQrtPV2fml1FEgTNNtMWiYWFFeQNnAuZAoVbvDxsy4/CMZPdZWA/LRVUUm7rpUmJPGViJP5xnJS+9Ok0PKoSJ8/K/BCOlvBMkupuICoTfm/jjfJol1jPA5Ldsv7g==
X-MS-Exchange-CrossTenant-Network-Message-Id: a55e7325-d80d-4084-8971-08def17e6554
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 16:43:50.3612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xetBwQTXtFElC7ZgBTkMk0Q8ie+L6d1vZ5MBhJilWYRcbmL0+f+0+GpFWP7kcjwRweuH4w/1wYVD9MmOuIzo2PBYSzJA6q16h/bZVdozqjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7605
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785775444; x=1817311444;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GBPYAWUEm7ZwCqliOuuBFN8uRPVIfP1gLzzQAplAoX8=;
 b=nk7Pl/nUkS/eXnTiOateV6oW0hc/oN96UIBC8MSHze4/IGOsKtRNBcKz
 ETrRv1kOtepABEzoGgO4WVA5Ltf7m9+vMXb+PMd7Iu/UOeWVGqHV9+xf8
 Cb7FFo/PCzIzIVgA9hn+Z6KTMun55P0cnSQoFdTLQ16YUOY0LdfJOAEmq
 Ja/7bS8sSvFMkk/32vHLxWOqx3EFX34bzmI52/apb8AlbPhCyc4FPtq2f
 96nDpylQoN2oqUZFFyJJCHRMd1KJjz54cwM1JgeFhNvIbrOQIkPH2teE2
 nAM9+0T1oW3jUz56LyVjJVjLpq/N+KpWF/MAsv05ViXZlA5rAlVjw9cfR
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=nk7Pl/nU
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 0/3] iavf: defer loading
 netmem_desc
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

From: Matt Vollrath <tactii@gmail.com>
Date: Fri, 31 Jul 2026 15:27:37 -0400

> On 7/31/26 11:13, Alexander Lobakin wrote:
>> From: Matt Vollrath <tactii@gmail.com>
>> Date: Fri, 31 Jul 2026 08:41:06 -0400
>>
>>> In a few places libeth and the iavf driver inspect which page pool is
>>> attached to a netmem_ref. This forces an immediate load of the
>>> netmem_desc struct for each buffer in the Rx loop.
>>>
>>> Defer or eliminate these loads of netmem_desc from the driver fast path
>>> by using the page_pool ref in the first cache line of iavf_ring instead.
>>
>> I was thinking of this when implementing the current design, but:
>>
>> Do you have any data to prove this actually helps performance?
> 
> The optimization was profile-driven, but not on an iavf. I was working on
> a libeth port of e1000e, because I'm an obsessive optimizer, and this quirk
> of the interface fell out. I'm working with a Xeon E3-1240 v3 and I218-V.
> 
> With a mirror of the changes in this patch series, on my platform, it's a
> net zero overall change in Rx performance. This is not surprising, because
> the cold read is just deferred until later. The time saved in
> eth_type_trans (where the payload is first read) is instead spent in
> skb_gro_receive and pool puts.
> 
> The additional thing that does make an improvement, which was omitted from
> this series, is prefetching netmem_desc early in the loop. This makes about
> 22 cycles/packet, 3% difference.
> 
> I left it where it is because I don't have hardware to perf this on, and
> didn't know if anyone would even be interested in looking at something that
> I can't produce data for on the actual hardware. For iavf the prefetch
> would be conditional, only when the EOP flag is set, because in this case
> netmem_desc will always be needed either for GRO merge or pool put.
> 
> I can't guarantee that this will be worth 3% on an iavf platform. In any
> case, it'll be a couple weeks before I can work on this again.

I asked because I was testing this approach on iavf and idpf when
developing the initial libeth code. But turned out that there was
[almost] no difference, while passing `struct page_pool *` to each
libeth Rx helper was very inconvenient and ugly. So I left it as it
is currently.

Moreover, most of libeth_xdp code couldn't take a separate PP pointer,
so it would make no sense at all since we're converting more and more
drivers to libeth_xdp helpers directly instead of raw libeth_rx. And
also, with XDP at least, the core either way accesses netmem_desc->pp.

So honestly I wouldn't make this change for some ghost benefit (the
current code is either way capable of handling 50-60 Mpps on XDP_DROP
despite that it reads netmem_desc->pp for each frame).

> 
>>
>>>
>>> There are only two paths out of the Rx loop where netmem_desc needs to
>>> be consumed:
>>> * The "very rare" case of libeth_rx_sync_for_cpu calling
>>>    libeth_rx_recycle_slow and indicating that there was no data. This
>>>    could be similarly factored out, but not by this series.
>>> * GRO merging a frame into an existing aggregate stream. In this case,
>>>    the cold load of netmem_desc may overlap the payload prefetch started
>>>    by iavf_build_skb, which is now no longer dependent on netmem_desc to
>>>    start.
> 
> I see now this isn't right, anything going to GRO will end up back in the
> pool in the same iteration, and netmem_desc will be loaded. It just
> happens later.

Thanks,
Olek
