Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EAB7C5516D
	for <intel-wired-lan@archiver.kernel.org>; Thu, 30 Jul 2026 20:13:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 11A3540CBA;
	Thu, 30 Jul 2026 20:13:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4aaJ8FRLLYfR; Thu, 30 Jul 2026 20:13:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AC5BE40C2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785442403;
	bh=4gfEiF6W83MsXcNXAhP3fDMs+/VVdyOpDJjeUVaDGsE=;
	h=Date:To:CC:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=2+EpRpuYlnUoixYqnQicLnEVF1KKWJyVJyYQmJDqQpMlS0IZnGhNJlFBGLrfSWi6D
	 VC2pEdjg6s2d5p7SsOoutlmIJAztRcfnHQLPtNhMs3/ZF9goQDk9PY/PJ0V0PzApe9
	 S+nU2Fdb4ZfEJK0lH5C3/IOALroc6LifzRB5WZqVXolpCT1CZs6rHNkGENrtr9S/pA
	 TpZJQySLXsmGuRCYbzZTI8AbptXWFazJq8Oi5QPzafW3oD8EPXiL4xbIND81bwiwU2
	 kxi42KDlq2W+SvGhnV1W6YaNZF8mYXlpDCYNJCmWE/UmrebO+zFuuCwzcl/og94hmR
	 DiwLHgVaylbFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC5BE40C2D;
	Thu, 30 Jul 2026 20:13:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C599C42A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 20:13:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B7DED60627
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 20:13:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eY0TmK2lrFTC for <intel-wired-lan@lists.osuosl.org>;
 Thu, 30 Jul 2026 20:13:21 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=anthony.l.nguyen@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org AC150605F5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AC150605F5
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AC150605F5
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 20:13:20 +0000 (UTC)
X-CSE-ConnectionGUID: QNs/y7inTWKFdKh2vucybA==
X-CSE-MsgGUID: 1JkoY2uNQQ+UN+Aawf1tCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="85943908"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; d="scan'208";a="85943908"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 13:13:20 -0700
X-CSE-ConnectionGUID: AIfwod9hRm68L87Aet2CiA==
X-CSE-MsgGUID: PRllHMoZTyG/FSAcn0EY+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; d="scan'208";a="256086200"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 13:13:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 13:13:19 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 13:13:19 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.7) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 13:13:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4UZT+m9BZT+8D6gnr5Qtc1snOI0ya7z7a8G15BmfWKDJ1LhLXFCHoN5AqjfyOQ58jlxiEKAqlBn/jBplige8tnudWgmxeFl+zHm98oRGuMtgWat6R06WhQyN5Bq3N7lkbG4n1JzwEf3Xh5sb1MFF1n74TAchWVL9u/nR8AbI7mGU85fXdxt1JM7WzEr+yUjHvZPe93yUXiHcQc/Rg/fhAwzJNuKchRyhbxFrCMI5LmwOSgBx7gWV8EypQXo26gJq+fctZXBD6SqxUDv9LVWmNhJiAP5y+/V6vwRhOiM2SiRO6RMOOxlVvY995PSBfuphlt4b+Z3d7PzaNLgPcaY4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gfEiF6W83MsXcNXAhP3fDMs+/VVdyOpDJjeUVaDGsE=;
 b=zPNjR/I4eBGf+jXds0Qv59dvOk7cFiGB/htKSZDyyAMjIIXsl4+5BOQGERLIWu94YqChjtSVveo+jNpdV8bpnvshdPXRMkEBvz8Q0emPeslpnjQ1Nk1wXSU7VKQKqT7nj4YpeoE2d/sE3BJADJLqwRb67/KEbfbiQdOb2OwhhaT3EJ/t+qSE8WB5eU3CpTyys8jIFx/N2rWZO9+h1czxr4rmImJ9lszzIhU392rYihEspdZfnya6Fs/F+/aGdQkJGL/yUwH1/ajiHzda44CcEPS6JULmYx4Mdi+ZgIwg5sL6hbSyBJG/O/E5HbYjoTvjE20wEVd6MVcTU028oQ4wsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN6PR11MB8241.namprd11.prod.outlook.com (2603:10b6:208:473::9)
 by LVXPR11MB9708.namprd11.prod.outlook.com (2603:10b6:408:388::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 20:13:17 +0000
Received: from MN6PR11MB8241.namprd11.prod.outlook.com
 ([fe80::cf79:ceec:e277:9d46]) by MN6PR11MB8241.namprd11.prod.outlook.com
 ([fe80::cf79:ceec:e277:9d46%7]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 20:13:16 +0000
Message-ID: <5f1456d9-a098-4459-8fe0-3a90c4db0ed3@intel.com>
Date: Thu, 30 Jul 2026 13:13:13 -0700
User-Agent: Mozilla Thunderbird
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
 "przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
 "aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Blair Steven
 <Blair.Steven@alliedtelesis.co.nz>, Carl Smith
 <Carl.Smith@alliedtelesis.co.nz>
References: <20260514003733.1718771-1-chris.packham@alliedtelesis.co.nz>
 <c2f3acdd-9985-4d8f-bfc4-5d83f520f4a9@alliedtelesis.co.nz>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <c2f3acdd-9985-4d8f-bfc4-5d83f520f4a9@alliedtelesis.co.nz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:303:8d::26) To MN6PR11MB8241.namprd11.prod.outlook.com
 (2603:10b6:208:473::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8241:EE_|LVXPR11MB9708:EE_
X-MS-Office365-Filtering-Correlation-Id: fbff5a38-cab2-4035-d7a2-08deee76fde6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3JQc3jtkrqc+UyGM6kZWj09R6J/neutAdq14RpWJn1za0qQpObxt4QytWrbG2tZNVhpwFeY0ozkL9bOSMGW6zRtRPtVjX71cexWzll51SRPxMamgPCFPJUtYSgjgrtL4n8mpIUu7jZEs/lwk71ct2HrsqJfd3jsbpJNnDRdTCdPPP2Xeg32WkCukFwSQz3S/rCZ1LH3wCXk/WaA49qDFy/Bm5veGyUK0s9Jtps465rpJZ/KSBLvJGSi9xgAWtdhKxxWlIWH8BziklEJAHi3RVA7pf6Vnt8BeeOf+22oEJvRSFK8cInkeJO9ox6f5wW3hTAp8k8PtZ3KinkKoayLzdRIWWqNWTaljajMj8igZJ5PmMClzmISsiMFAYa2R8rNJAxGOQXXe1Uc2A4/BjEqCtk//dhOxFZhadf738V+cKgHEeg8JUW6OUaBsceM/KZ0GAozUV7B5q90MEPwZtilKWpzux2TnoR/ua9nf4eOfgsqCpxXBiSNQbmVRAdBQvvHil256LLMpPxFdLT0nZSTZuHrsFTmjz3Qq1LqQeqGcD4TMgmvruHfhkPV0vicB/JExGJND4bnIYYwJGXgN8TpB+pd1g1PAw9SuXhG4yIRcSZiCetjdM++IqssOh3NqbII2dipalWOUOOYemYYMqpubhsAgXlTT3PDPRkov5uxo1dk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR11MB8241.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZW5hUFBBZHJqSXVHZ0lRRnZDRUdpOUFkQTBRcktvcHJnMjFZN1dsZjk1b0hi?=
 =?utf-8?B?b2lkNUZycmpPVTFTZUtMMjZ2VWhOdHh2SFVudVVYaVliclZnWUFrV3NxNE9S?=
 =?utf-8?B?TXQzaVBGdHhKOG5FSzgxYnZSZmlsYUVUMDFiSngvSkFuSm5YZWJnUHhIQmZV?=
 =?utf-8?B?QlBVTGgrZkVoUjI2OVc1UFRkU3N0dWFtWDJlWUxLdURVcUNsMnYwVGgwRzM4?=
 =?utf-8?B?ZjNRT1FwMUsxdG9tTkdjRUFpVWIzbmRyeXY5Y0NQOGdFcEthQlF6UXZDV2Nn?=
 =?utf-8?B?RzdwcmhKQWcvdHJ3N015UXU0NWI3WGtZUHU3U3hNZFBna1RPVWUwbDNOR2xr?=
 =?utf-8?B?UlVtaEVwWld1WnVBUW1kVWM4UUdIUHA0L0FRbENRR2ZJMU14RndjcHdFa1RM?=
 =?utf-8?B?SHJCZXd0ako1TG1oZ0UrN0tCaVVCUm4vVUx3K2gydEdmQXkzd0p2RUswSlVo?=
 =?utf-8?B?Y29HNnNuUjduTmw3bUxLZlJIdHNXeU9pQ2FVZ05UajZBbkpzV3NHZk9KQmtL?=
 =?utf-8?B?QWluckFtZWdTZkFMSEtacm1WVnpUTGN5NVB5MXNXTytWQnhrSFFhQTg0bmhu?=
 =?utf-8?B?TmhrcXkra1hoR0llSjZkZVRLamthWDJMaWd3M3JjZmxjSXhsKzZOV1NSRTZG?=
 =?utf-8?B?cDVmd2RJb01keG5zOTFkNXlzNUc0S3JPTmVSbU4vVWxMZGNIR1FldjExYk03?=
 =?utf-8?B?Z3N5S0xWcm4vZXJhUWVQYkdwVGhNMFhoWlhvUFJOY0VmODlpL290UzVneWhI?=
 =?utf-8?B?Ui90VFE5QWdBTkR4U3JnVzZLZ0FYT0JrQmRUUVZLQUM0N21TSWx2am5UK2tx?=
 =?utf-8?B?RFNDdllKWG1uelo2UmdoZzQzU1F1TkUrd1QvbFVDWUZ1VVN0RC90NzhKaFZC?=
 =?utf-8?B?UUkvQnBmN0xSRis3MXR1aGx4NUxDMTdXOTBYRjJucFJZYlY2dTJnT25GUUtV?=
 =?utf-8?B?emhLcjRvQkcyMjFCaS8xVlFhYTFNYkVUTytwVjJYNGU1SXliY0FNT3FSVWh0?=
 =?utf-8?B?TVNNenM0VlIxYnRGeFcvQ2pyMk9vVjEyYjFjbzVJS1ZjSkRvUDlrTXNQOXBz?=
 =?utf-8?B?VlVoZHgyeWZhWlhPUUNVRXdUQ25TZFRhbU93UktDTFFEbC8rMXZ4Z3hHOThO?=
 =?utf-8?B?YmZQaHliU2NHb0lSMnVlZW40ZjRVT0xJcHB2cUxkKzh5S1JSS0UxTlQ2bWdQ?=
 =?utf-8?B?T0ZEWU1UK0xyeDQ4SG5yVVBlYmxhcXBpQzBJOVRBTlhxK3JHYytHK2pEakNs?=
 =?utf-8?B?d0ozZ2JLeFFQcTR0dGdXREE5bENoaGc5Q21pMVdaZ0w4VHNxWjJ1UGxvQ0xE?=
 =?utf-8?B?MytIMXdNR2kwNytFQkU0d1c1V3VQcTlzSFFNa3N1RFhRUWViYzNlZy9sSHM0?=
 =?utf-8?B?MXcxdkx0Y2lhU3dRU25LMXpiVzJtUVU3QWluR3NtaVlkNFNVN3FaZ2JPOGtk?=
 =?utf-8?B?d0k2WXNkbTBqMEc1RjVNRUIzS1ZmbzljYm9ZNWQxNkRmOWl5N0w1SHRqWFJG?=
 =?utf-8?B?RFFQT25jOW1nblQvTVZNRnJ1VVhOd1JpQUIxY3ZQMHdmTlRkY3AxS0lkNE5Y?=
 =?utf-8?B?RWJ3Sk8yZkVMRnFNQXNNSFIyOGZBc3NvQi9TVXJrazBHR3VqcnM2K3hhOWly?=
 =?utf-8?B?SEt1SklrSjRzOGc0UDY5VWdYZDhCaE5KZDU3V3JvNmRLTHdVYlVGUS9uQm52?=
 =?utf-8?B?NlhhMGw3alFpZGNhRm5kR1RNaVJjWEVlM1dhMmFUM2x2dWNIdGVYZnR1cG9w?=
 =?utf-8?B?N0VBb2RmVCsyOHlGMkUrWkxGMG11MSs2dGFyc2tmR3FiNnk5elRtcDBqUnZo?=
 =?utf-8?B?K2ZrcXhjeExBdUtWelMxVGFPN0Y2cDljYWxRbjc0WVdBOFkzMDVDeFo2MFJy?=
 =?utf-8?B?WTg2VzMxOEliODFqYVYvKzRJeWhIMjJhbDVIUStzeGNEdFJYc2htT01BVnBk?=
 =?utf-8?B?MDVuVGNzeldzRWVzSTUzQ1I5YUlZOFRxTW5zOGQ1aXBZamN1S0sraS9VcWRl?=
 =?utf-8?B?R2NJMXE1R2ZwanJCNVZNMm5WNXordWNMeUo2VGFxQytVd0I3Qk95UkFSM09I?=
 =?utf-8?B?eTUxbExQQWd6Y2FvMkI2aWkwaWdIVEgrcFpWUVgvd2hKV1Y5ZFVuUlMwamp5?=
 =?utf-8?B?dEwxZ0p5UEN3RFd2NnhXcG9iVE5SMVFhVnFqRDV6MU9jbGVzbzlIbW1SWHA1?=
 =?utf-8?B?dDYvTjQ3TVBmUnFlck5yTkVUY21Va3Vqck0zNW85SWxBZG5ialBjZTBrSjNE?=
 =?utf-8?B?aFAwS045WE9sN3R4RU41Q1BYclVVTEZwUEVhTHpDaDVPSFg4Zk9nbEp3UUYx?=
 =?utf-8?B?SkdPVldwZ0RKMTJxTzM0eGJDMTQvUk1Nek1yQklmdlo3alVkRW9iSzVBTy84?=
 =?utf-8?Q?sWcM2zOxE7oqwrWI=3D?=
X-Exchange-RoutingPolicyChecked: mChDufQEXLxx3/E6Y843xYaoV9gMPQvEXqiwrUP3T3TVaP8JcZp5AEMv7jj8Oiu+solDALxWkH2VnNsR44E4XrBSfe19gxV0o8n1A+dRkQpcdWwpmTuhhzKnxYSRw0d7514R6cqcSOFRRntDwf3cPXNbKiGBRUHF+ewSTO4vEqt6XY2sC1PrSO0TAAEmSNeg2cvq2N8sGNR8YUXgOEiPGvw3xztqGLr5TYhGm8ICWZt+If7RksYwsX40hwZe723sdyeXt8ilC3ldNN1rSDEZYlTp7SE0uzfvSicpBI0+NgzspTdf7AI3XwWsmx2sxNWyPlQ8bmyfKTxJzfmFxHUwRA==
X-MS-Exchange-CrossTenant-Network-Message-Id: fbff5a38-cab2-4035-d7a2-08deee76fde6
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 20:13:16.8267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0nIDQnrdz/L9VsvbMjpmcmVyEanGxD7hVz2YPX44DafUsU3Rh34Kwgk/ROSbxNKaIAGBlKFazHg2PBv9EJYNYV9DiNL0pxRIa97kp/tMCYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR11MB9708
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785442400; x=1816978400;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ms+/XESfyKrYQPIs43uW/HeuwFjvdS4+0tO/aqJN6ks=;
 b=nu+pW7vYj468+k63J4el6usX0T6FMiJd/LxZ+y1X06Um5E+L+7Eu8HeR
 wlfc/oQKN4yJaRBZScEykG0QA/GQWImLSA2XdVGWe+QWay/93CX+L5n1R
 SknWcyeTpx/vRnqHYpp9Iq60VEAfgTPdw0zxUoS4JMxQy2JgTBLqTD1bX
 z8+9qu/BmArrcY0AI1hJmH7x4nvV9FMtpCUpP4VU6HoeEiHGOgjZBpgqz
 YZKpqJ6jYGQlBeIH8O0fdd1WLuBtSCiMyI7ZhQ+v8k9aXYtjWH3CeuEgU
 hpvP3ZCd1gMtUvOUkFTgi1aBvbgP89cT2HMfM57Wd0CiwHVXsFFTJNHrL
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=nu+pW7vY
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH net-next] i40e: Avoid repeating RX
 filter warning
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



On 7/29/2026 4:53 PM, Chris Packham wrote:
> Hi All,
> 
> On 14/05/2026 12:37, Chris Packham wrote:
>> When the i40e runs out of space for RX filters the driver switches to
>> promiscuous mode and warns that it has done so. In scenarios with a
>> large number of these filters this can generate a lot of warnings. For
>> example:
>>
>>     $ dmesg -c > /dev/null
>>     $ ip link add dev br0 type bridge vlan_filtering 1 vlan_default_pvid 1
>>     $ ip link set dev eth7 master br0
>>     $ bridge vlan add vid 1 dev eth7 pvid untagged self
>>     $ bridge vlan add vid 2-4094 dev eth7 tagged
>>     $ dmesg
>>     [   25.601705] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing overflow promiscuous on PF
>>     [   25.601833] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing overflow promiscuous on PF
>>     [   25.601961] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing overflow promiscuous on PF
>>     [   25.602088] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing overflow promiscuous on PF
>>     [   25.602216] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing overflow promiscuous on PF
>>     [   25.602344] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing overflow promiscuous on PF
>>     ...
>>
>> Use test_and_set_bit() so that the warning is only issued when the
>> driver enables promiscuous mode and not on the addition of subsequent RX
>> filters.
>>
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>> ---
>>
>> Resend with net-next tag
> 
> Has this fallen through the cracks? I've seen some Reviewed-bys but it
> doesn't seem to have been picked up.

Hi Chris,

I have it in my queue of patches to send out but I'm working my way to 
it. I do hope to have it sent on soon.

Thanks,
Tony

>>
>>    drivers/net/ethernet/intel/i40e/i40e_main.c | 18 ++++++++++--------
>>    1 file changed, 10 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
>> index 926d001b2150..8741990b5a5e 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
>> @@ -2408,10 +2408,11 @@ void i40e_aqc_add_filters(struct i40e_vsi *vsi, const char *vsi_name,
>>    
>>    	if (fcnt != num_add) {
>>    		if (vsi->type == I40E_VSI_MAIN) {
>> -			set_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state);
>> -			dev_warn(&vsi->back->pdev->dev,
>> -				 "Error %s adding RX filters on %s, promiscuous mode forced on\n",
>> -				 libie_aq_str(aq_status), vsi_name);
>> +			if (!test_and_set_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state)) {
>> +				dev_warn(&vsi->back->pdev->dev,
>> +					 "Error %s adding RX filters on %s, promiscuous mode forced on\n",
>> +					 libie_aq_str(aq_status), vsi_name);
>> +			}
>>    		} else if (vsi->type == I40E_VSI_SRIOV ||
>>    			   vsi->type == I40E_VSI_VMDQ1 ||
>>    			   vsi->type == I40E_VSI_VMDQ2) {
>> @@ -2461,10 +2462,11 @@ i40e_aqc_broadcast_filter(struct i40e_vsi *vsi, const char *vsi_name,
>>    	}
>>    
>>    	if (aq_ret) {
>> -		set_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state);
>> -		dev_warn(&vsi->back->pdev->dev,
>> -			 "Error %s, forcing overflow promiscuous on %s\n",
>> -			 libie_aq_str(hw->aq.asq_last_status), vsi_name);
>> +		if (!test_and_set_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state)) {
>> +			dev_warn(&vsi->back->pdev->dev,
>> +				 "Error %s, forcing overflow promiscuous on %s\n",
>> +				 libie_aq_str(hw->aq.asq_last_status), vsi_name);
>> +		}
>>    	}
>>    
>>    	return aq_ret;

