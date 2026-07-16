Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCDDC44512
	for <intel-wired-lan@archiver.kernel.org>; Thu, 16 Jul 2026 18:16:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B73C810A6;
	Thu, 16 Jul 2026 18:16:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pWnlOVMQBabp; Thu, 16 Jul 2026 18:16:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7E2F180F9E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784225761;
	bh=auMCMiCAsuQwzfFkgpf94NvI0ZF6R0YKokA66pBd5sM=;
	h=Date:To:CC:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x3Gak+vWBvhcfM6899PKlgRdSjD6lx+btmUiVcAlfWTva9iTSDFpyWO5ByD4kmlxc
	 G1qwwDzdMUmF9uWTFReGl0go5nofoJmvqI8WMOOhOF1MMLxV52nClnrr969rdssOm6
	 M3CAuIFN8J3bw8otAsvRSi3miKhY9DzZ9Tecee3L57EcE6Ojt7MQYJPjHwtOt91rqC
	 hozTwkVWq1TYTjS+8aIGDq3mWNFZkGaE+VsaMYb6Zp0hvt3KH03re6ciqPqSEefvSK
	 FAu15zKbMYhCW/tnahEVcNh6kP9K/tSVXH9eMEvBgXhcUNYg0fI10nDB+jCtcJs6ri
	 5eneuSniFDEGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E2F180F9E;
	Thu, 16 Jul 2026 18:16:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1315A1F6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 18:16:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E47EB60A35
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 18:15:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nIX218DhEV1v for <intel-wired-lan@lists.osuosl.org>;
 Thu, 16 Jul 2026 18:15:59 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=anthony.l.nguyen@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B971B6063A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B971B6063A
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B971B6063A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 18:15:58 +0000 (UTC)
X-CSE-ConnectionGUID: rA/qGnPaRL+yS/LT9FOibg==
X-CSE-MsgGUID: KGrutP7+R3G8AL6DdnL0QA==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="96409667"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="96409667"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 11:15:58 -0700
X-CSE-ConnectionGUID: oKBIhKOyTKmb60uXj3nKJw==
X-CSE-MsgGUID: iNOumHijQsyPNtUKLgMAow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="261493099"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 11:15:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 11:15:56 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 16 Jul 2026 11:15:56 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.42) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 11:15:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CsQ5SUOTHCJkX6TSHP3pl53v0kNvBMsy3yFCAcz3HK5Xn5pjzJ/UgCcDXVvDtt6lKNKQzMlKCwM8JGBqD0OMRkXzUyVnjPOj5W5zUlgcs/WmefZ2cZsVZ/gq0bfBQy3ap6RpsopWhKRmSSJnK4/QMx8KyeO3QNg/EYGrcqAdNB0qze3Hao93DSJxkFu9xFoQ1OUTUPQlV4m888O2zwHtpNdy+YhiZWxujbndlaTZPWtUfrZynM8a0GhPVzS4FxqfY7dw9h5q3ySZ+MaMVCJCci59AwMRRkwwqKxCGbodO3EZBtCTjVIYcGAXQheAcY6L7SKehNLVZvWSonjUPNYpAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auMCMiCAsuQwzfFkgpf94NvI0ZF6R0YKokA66pBd5sM=;
 b=VuI0BIVAV5QJ4e4Xdi9k/6U8mW6+DGIfeySZIfd6h8jhAJz3IVffIcEdT205TTCW/CfRdbbCdazBFIHQbCxwG9EcTIygsC61xNU52rIcX0M4xpVTMcR+Pu2BQwdjAMUErz2gHJNsOtWqpcVgUEux9I7VCLogs6o7FWmrd8QCpguWWiZoAw/+x4f6DzRw1CdpC8kuod0A+CRnCMO6GzTZh4lKU4hunZxA0rtfkxhwg/LpkUdShBAbIXdRzFdfx/lOVfqSZ+brQx99MhRiQ3Di5Xw3ewBWxJ7n8X5odYlN5aIep6wDS2894e+WNWzkX2DXutN57HpGfea+WmS1B2I1ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by DM6PR11MB4578.namprd11.prod.outlook.com (2603:10b6:5:2a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 18:15:48 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%5]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 18:15:48 +0000
Message-ID: <cf4f79e7-412b-40b6-81a5-f32ef3522bc1@intel.com>
Date: Thu, 16 Jul 2026 11:15:45 -0700
User-Agent: Mozilla Thunderbird
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>
CC: Chenguang Zhao <chenguang.zhao@linux.dev>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Chenguang Zhao
 <zhaochenguang@kylinos.cn>
References: <20260714025112.284724-1-chenguang.zhao@linux.dev>
 <IA3PR11MB8986AD34DC026A4FB3946407E5F82@IA3PR11MB8986.namprd11.prod.outlook.com>
 <ald07ZVc7Z/NLXcm@boxer>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <ald07ZVc7Z/NLXcm@boxer>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0140.namprd04.prod.outlook.com
 (2603:10b6:303:84::25) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|DM6PR11MB4578:EE_
X-MS-Office365-Filtering-Correlation-Id: 537bfcdf-6097-41f2-ad18-08dee36642e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|11063799006|22082099003|18002099003|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: g0qm+IVkSxxfQjMmp2A7vscb6QZTt7hX6ZK7CWp+mOUB1NTsQ4NKsn/i201vkSCdaax9gUzE41KBEepQ0MaYe8KIAB4IpBugsbsRdBv/DmW8HLY5meNmdNswgHHR0gVcU/+f4LJD0T6TtdUhC6rKy7nKLoJWX4TSvFwRrgJRmv/M4qvCsqRDwW0BZxHKGjpnNR4oFjtn4GNejceht5YGAiX9WUUCRX0nr1ltLbxSi4vJr4AFsx++DIYKNZbKqXA6PqxG54r8hpZBajJCk4gi3dkqZDQ26C9gLgleVn8KS5JxQ9qIAzuRhwzuQttuAFjTgEkD3m+fKKh4d8GeqWaiFDYs2Kklj+BycRTrW7za4ztzXADKbMTMc0s2Jbq8WCTH/ccNuAHn59+7FErToBtganIhcECTLoRDrzcqj6kTeot1kFXL5UVel30YgGbR+fbPbAD5Lfp6/0HcV9HNCApnVob6+4hfXvttlylvLhUsHp6Mqs990rW97nsB8bvrfmBpQpWG9JyAo3eo0WHiX/Yr6wxYIkQOh2v5PT5RrlC/RvgKgK+DyY8IOB2fCOSgCEsHFE/n80/aujDJKIn3b6J3FWKjYC36aH4LgZzIxgoFvoSZOgYQERgcPaso7XOWQpZfSyKK++YYVMUCsmWj3tdPmiP04N7280SuThDrwqgEVck=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8230.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(22082099003)(18002099003)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTFKSkV2eTBNdDcyNkM2alhZeUVYcU41eXVGQkhIOERldjBpQ0RSRUd3cTJa?=
 =?utf-8?B?TllDNzRpMmU2K1diZlNKUERIc0NkelhkSWRmQ2xJK055clFWTlRPZkJudENn?=
 =?utf-8?B?Wm94SnUrUFBiWm5tbXZFLzRKTHc0K1ZjVFFXOWVLMHZXN09VVEhKNXNGeCtk?=
 =?utf-8?B?bCtydHlSY0NIUEttWTlUV3JFOWUwejRhRjNFODhUeDZQSytYdGZwclQ1NE9j?=
 =?utf-8?B?TncvVzZ6eDErTE1wVzBsaXQwNzE2MGV1ZlpQMldTaGhvdFRPa0hUc3E1aVd3?=
 =?utf-8?B?VlR5RjJWUFRtVDRzRm5VYUpYeWRxYVMrelR3NFQvY1BJM1FldlZjUUdoR3FY?=
 =?utf-8?B?eHFnWmhTVW5taDdnRGFnTURNWmRUS0hOMDB5QXZLTGI2NlhZMGlXdFZrdXFN?=
 =?utf-8?B?ZC9WNUVpOEpmTlV6a3FBOE5ia3haVWo5M2M0MFo5a0VnV2tTNi9wa1hSN21o?=
 =?utf-8?B?ZzJYVkZWdmxJSk9jQlB5SE1MVktyalI0SjYxNHJmcVZFVWxxeFgvR1M2QUFX?=
 =?utf-8?B?MmpGajhlQ1FqS0Zjemp0bHhZZGFTRUZIc1BtaFJtRHNmOTZvU05rQTN2VlZR?=
 =?utf-8?B?L29Kb01Wdm5XTkZLV1BoUXNZUzZwUlg4RzRVaUJzOEI3dU1tbjFxUzJNMm1U?=
 =?utf-8?B?dEsyaVd3RDQ3bGJza2ZPNXF1VWZJZDFjSXZLeWcrWG9md1h6ZXFuL09uaDcx?=
 =?utf-8?B?MkJ0dXhqeHZTTGVOT0I0Rk0veFpMU21iWHJ6ZTBZTFVmR1p6aWxacGcreVFu?=
 =?utf-8?B?YXRZMlBOV0pwTUh3MUg0YU9vUHdkMkFnb1BvYWRLTjAraUtydk5YNEpvSlpH?=
 =?utf-8?B?aWI0Tk83WHR6RUJkTTI1azlYNzdqN3lBUzdhei95cE5WQ0NUZ1dJUGl5SUlO?=
 =?utf-8?B?NEszSVF1UDRudU5jMUN4NmZ0VE1adTIzd3Nma3VhM1Izby96R0FCcC9YNTlU?=
 =?utf-8?B?T0Y2RFkvcmpEL1NwVTVOcTBIKy9xMGk5K2JPOERGQ2daalBvMWJwT3hjNm1R?=
 =?utf-8?B?NUxmcmdzaG9ZVzJQWUpaNWt0blVKVTBFL0UxVzArNU1jYVFjR3Jaaytsd1pZ?=
 =?utf-8?B?WldiUGUwVXdTSXRQRUdMMUlhY2M0VE1PSmVqV0JkTEY4OVJ2eEdjUHNQSE5T?=
 =?utf-8?B?M0lPdW1za0IrSUFwRnRKYkJVRGNzVUd5c0tXbVd3bzF2ajBUZzYvamNLTzRF?=
 =?utf-8?B?cGVORzVKaUFzOEdIR0p2LzZUVXZUVGUwQ3FSeDQ0YTZ0b21KblEwQTFSZENJ?=
 =?utf-8?B?dklHekRGclVZNlpjemVCL0xPdmxGaGN5d0tCS082RkozSVJBUjlDMEJCRENV?=
 =?utf-8?B?VWlkR1FJZzlaQ2JVbXY1bFFPVFFXWjJCbTFVN0F4YTFjYldjcXdNUlMvVHdG?=
 =?utf-8?B?QlV3UVgybjY3K0tVZUZqWVhqRlNIQjVqTitCTktsYUh4QUptWEFBWmgyOHBT?=
 =?utf-8?B?UHR1MEZkR2VsM3NUeXpQeFBUSEtmNTNvY2tQTE5LOW5NbzYzNUpJMWRKRTRs?=
 =?utf-8?B?MU5vb3dIQzBYTmJndGRNY045N3JDNkZ2djZWWU1oWnRRSU9meTBEeXRaWXFr?=
 =?utf-8?B?K3JGZjBvTmVYbUN1SnJ2V1BvdU4ydk1xWkg0QVh0ZEdMU2ZIdy81aENyVEor?=
 =?utf-8?B?dmI2RzNLUVcwd0hBeDZzOTRIVFZNc1BweldtbHB0U2pmckZUbVh2WXU4ZTVp?=
 =?utf-8?B?Z1EwRmdYM3NWUmE2cFJzSGZ5cURrcFNmN2JHSXJDVFRTajcydWh1b0FDRlQ0?=
 =?utf-8?B?VzZ3a2lSWjJmTkYvbnJHMEdUa0dIVWFHVVBWa0FkZDJMejZjMG9TMXlQMWMy?=
 =?utf-8?B?bEJ1MG1QR2lJTzRGQXBWZ2RlZEIwdGRJRmcwRzNJK0Urd1VLREQwbkdodTdw?=
 =?utf-8?B?QmhSUWRPVVdZOHNtei9USjR0ZlVPNjJYUzdIZE9FVEJoVE1FalV0YTF0Z0l4?=
 =?utf-8?B?eENYQ2NjMDQ2dGhiUGwyMUUvbmgzeDRsMUk0VGxDNVQ5MVArbmdDMHl0RUFE?=
 =?utf-8?B?T2t0bWorUDFDdlRKTUZhV2ZlMDhURXRRSDl2dEZWc3hxVGFETGN2eURncE5r?=
 =?utf-8?B?dUpVQVpaZGhKQ0lZcml0MFZML21CTTVEM2JYVDE3K1pJNktpNTUxLzVIb1Jv?=
 =?utf-8?B?emNJU01IWG9FQVFxaHdmaE1GZGxYaUM3bmo1RXVDL1l2bWVhNE1OREhRdEhQ?=
 =?utf-8?B?K3d0TWVmOURiSDJwSS9mT2dSc2JLckI5ejJFbnF1Q2tpcWZBRzFocnk0bW5P?=
 =?utf-8?B?L1RBOTNHRWtFTWRmdHJrWVhXS2RrSTgzeUVwNWVUc1Q0b2YzNExpRW9TWGEz?=
 =?utf-8?B?ZkNtM1RSQVd3bzFmanpJbWY2SUR5VTM2YTRvWlJEbjAwWHN1NHI3cElSZUZB?=
 =?utf-8?Q?DZsuW5ApdosEvTLU=3D?=
X-Exchange-RoutingPolicyChecked: QXEOA46iitQ7gqVydBfzqgB1xmO9G3xk+xUC+qqNsSy0bOTYDKyK7suq3aXOgMaw4pVeaYtk/hgOxv+HbF7KZNMB62rpvOf2fSjejqD6O+DQplmIKVqEE5L/i9ykBZjvf0cOAQ6jpYa4eglpO9C7lfDaW5Qm/F940Lrv+EryH+a1QzMwYFGcbkyL/zAg1HTSsFQugMOptdq/dpQmlNeyWGextiPD2SHiNs5Qtvsk8YgKWPAQV6HLfCQQ9nj0rnnMNb3xcQntDKnGsUJWiyKKIl2MghWIgZ8fEKPmxyGy8db3dxD1BZ4TJo2TmxZ3DXqwGdiMrWhY++pbN/QXCWf9qQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 537bfcdf-6097-41f2-ad18-08dee36642e7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 18:15:48.4610 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWU0cTTroxxZXAaYTHW2p0PSlwrz9D2S1jBTJflr/OIONIteVrwU3PlEHzE4pp1YPVnoSdJ/05dlQmpfVtpAiJ79gief2bUZPXMnqHaMZHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4578
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784225759; x=1815761759;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zE1hcelUwpmisU/xqfrIlN5DpKFGQScamgPyQ2l0XFY=;
 b=Lgp4eD0IRlido+rkAOdJaGDJEKljgpJInQJSPQXFsrwVYphs/i5HF1+a
 5a4hyCHiB0+WLP/erLjzL0oymSJFKD7/VFhqf3H994R2P+RILOlCuSSNN
 QkjdBUbTDUm6/ybIWb8PQKmHk0u/CMHGGnsQhu5nPLi2LR2IolNW5vKR6
 KBcxN4fkW0D7y/4RLSyDLobPzwcIUSyEv6I8FwuUL1g6jS/eGLCwrlxx0
 9xYyxYsn2aCyunLAkvjwMIfiy+AkoggE2OxicFQwcSxgwe4hh2bHbySik
 3jfKb+ydL2AOV94LRQED8h7rFSFHFSrZmhfdmCtqke1PJWWxT2V90f5pJ
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Lgp4eD0I
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH net] i40e: xsk: fix multi-buffer
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



On 7/15/2026 4:54 AM, Maciej Fijalkowski wrote:

...
> We could go with this as-is, right, but given we have a helper available
> to do exactly what this patch touches, I think we could kill two birds
> with one stone by removing home-grown code. However one might argue that
> such change is a -next material.

I agree with trying to utilize the helper here. I don't see a need to 
try and fix a home grown implementation when a working helper already 
exists.

Thanks,
Tony
