Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053EAC561E6
	for <intel-wired-lan@archiver.kernel.org>; Thu,  6 Aug 2026 09:14:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3CE0606EA;
	Thu,  6 Aug 2026 09:14:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zavf7FkeN64q; Thu,  6 Aug 2026 09:14:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1CA0E606E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786007654;
	bh=NT5dmxgnPljusVri/XWfZEN0N/GkB2Mo8JFUnSCcvSs=;
	h=Date:To:References:From:CC:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vJswJAS5VpomkH+OfD9oLi99sC321R0ic1QD9IeVhFfftX4HSN18Uz1ny9P+LvIks
	 EV+TWuo//yJ7vCmv1fcm20NGUHL2MaSWxjyURdPvkKL/UPflu4uLhCzoyvdXR2ca45
	 s/7Bco5+qWkRuu5MZPdai2UadefSOhAUW9Ky3ZuohK88ihGsHwAulXobi/ze55Tnro
	 st5ZDvhGGakU6euikYsRlKjMI8dhdiJfehO3ZkW904NISzqxGjx9LVqLbxKdFMXug7
	 6CmlkplD3utZBWIZTwnnPxNGDs7gAgxZFtjxDEA+TndoYAIK7E/gwUqiQgZKyzhjFP
	 gbAsb4B1IdEfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1CA0E606E1;
	Thu,  6 Aug 2026 09:14:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D30B2194
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 09:14:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9C93A80D7A
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 09:14:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DJgjRfX4Pnl9 for <intel-wired-lan@lists.osuosl.org>;
 Thu,  6 Aug 2026 09:14:11 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9727280D77
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9727280D77
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9727280D77
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 09:14:11 +0000 (UTC)
X-CSE-ConnectionGUID: t5PbYKvzTWCZWoopdc99wg==
X-CSE-MsgGUID: JpReXf/lRuyzGoC5rTqT9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="104128340"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="104128340"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 02:14:10 -0700
X-CSE-ConnectionGUID: iLmyUzDDS2KKzsjPIG/tGQ==
X-CSE-MsgGUID: NrSFEQpFRVGA44nZZkS8HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="291960719"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 02:14:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 02:14:09 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 6 Aug 2026 02:14:09 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.67) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 02:14:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTAgjf9mXaakTAygtdpCcHKUyS/dyEBnN7xjTR+syhsHLZTgmBP40VO30fITMY9s8CJkN0JUHldR8QhnFz1uZU/DxXB+6FER37css58KSy7zJ0UMDGwFGOLnO7V1MiDwagedHUn7TvyIbxYpLSyJSTWnOrE6TWdLLcfPThQeMgLZVKNb2VSyv+cK/HxXHLMPyh+xNWDHLUGkwwj5GtI02ThHFW9KRzTwztpXDtEBSkFIgfdZMWiZPMOfXNMdhZSvQZEpnx/SOE18REFhU5sW0y8y3tL/MXXAd3ZqdgsDWRUP25YerrWel5/+BaP+LyfTBrNxv+9fhar8lX8Gm2JvbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NT5dmxgnPljusVri/XWfZEN0N/GkB2Mo8JFUnSCcvSs=;
 b=nIwFvJk7qPkT1OV3FepfiGq+oPLjOcABz/p1N65dEjdl4RQ+uiAgPh0bGszyf2BGjFOH57PivNvmJaHBZ+grZ3DPd2QoPLzVm5iPJFkwFWW9mBm1vLRdw1EmZgNQYJgcZg8EiyXSX1PlUfuY6+x/Sr0V+Ora7uUlt2sBFXCkYZcTMjon69z47o9LFmPgI8wNcRv9y0ctK4Q1I5Cn1jy1KO29GjzChWrobqm/eKIcG/nFeG04O1dywdkZsxPQM/nUaF2xh2hMeIifTTkKBWMklN/IjlejGAqrIVft+urx9GXWj0msmgIE4KnHCqPvt/AvRwSS8QA6E/zdMHUGW4hMuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by PH7PR11MB5793.namprd11.prod.outlook.com (2603:10b6:510:13a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 09:14:07 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0270.017; Thu, 6 Aug 2026
 09:14:06 +0000
Message-ID: <abc23ed3-f194-4546-bf99-7152464b93e2@intel.com>
Date: Thu, 6 Aug 2026 11:14:02 +0200
User-Agent: Mozilla Thunderbird
To: Viacheslav Tyryshkin <s@tyryshkin.me>, <intel-wired-lan@lists.osuosl.org>, 
 <netdev@vger.kernel.org>
References: <0551d6fd-9f86-463a-86b5-c8dc78db62cd@smtp-relay.sendinblue.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
CC: Jedrzej Jagielski <jedrzej.jagielski@intel.com>, Piotr Kwapulinski
 <piotr.kwapulinski@intel.com>
In-Reply-To: <0551d6fd-9f86-463a-86b5-c8dc78db62cd@smtp-relay.sendinblue.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0010.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::12) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|PH7PR11MB5793:EE_
X-MS-Office365-Filtering-Correlation-Id: e16b7d2f-f6c2-4f4d-1aec-08def39b111f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1/yZEx6yFGVICxgz3AjEP+uGzEQkvr9kFcicQdJ9uaXFjo6SAxPfLT/kGlGqRILJxQmtd083sa7LW6aDx5IYa+lKANm7sbR3/rDOXXCXfSivxetYpC1/7FXGY+TrHNqcz1oU75Bw3V3M/X4EhsJVILuSPbawmB0n7XMXYAcggv8igj0nVKCI8js0plFfA41e8DW0Fgr7FS48T9tyZj0uDMV/00LBTgEvxviiNvG+xCwiggag05PdDb9Ag3o2xsQ/X8L1eupFdkGDyy+3HRNR8tn+C28LU44Tx4tqzDUQ5dNxPqCt13ITRE6yX9tUFK9CBQoYg965QCSmoSjXUVB5jiD5s/fuTM4P2KkrT4eWzjbEBaf5LgKhsWmVLtQcqhZI04I3ZpOzc5KvK/KkFDJC2xaaehijUtWhdQZrweAxthDeD2IuRakCX4PnSoAJ+PJsWKr+7KxtGj/tXF4QgQqffyGFU7hgfje8rT5BEgj63TNP8MAp1oaN8SeYNDqQ9W0qtb5I+mydem5zB7Azv8eOXQrOFkThC85BmNfP2jLyql7XvtxwPa0eps/a0CiwW9wlro47hkSuhHkLHnz/dSjPeftqHjyQkLh+nJOwsbjvQdY1w1iE79zNTsd0fGLoLGrBurb7vo9diYWcxIapnfGSlCTSizwS/Kae0l9Nc/HBmNM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0d2R2VjSC9GbEloeUJRekU1RUNoNERXZkdEVkpaYmtwaWQ1S2hlbFR5VytB?=
 =?utf-8?B?NEI1eklMQ2xReWdCSmJGUUZSVUJVQkhDa0FjRVhlMmNoYTNMMXJLeFBORkVZ?=
 =?utf-8?B?Tng4dVJFOVR4U2lhUXd6VVVkdGhxdFZhK0dtWkJYQ1ZoVkgvUVZQTi8zWkMw?=
 =?utf-8?B?ZlFKNEE0dHE4czJvT2YwNC9CQjN3RHlCeERqL25oQ1haSS9RTDIvRWxGN3Ar?=
 =?utf-8?B?WklleWFRK29mRE1SMmY4ek16aE9FdElwRTJHRSttNEpac0laTE5zNDRwWEQ2?=
 =?utf-8?B?TXlDaFRKaTduL1hteVhQQVcvWkNkQ3RiVGFWNDNid00vb3VQQWNZcEtRbVJj?=
 =?utf-8?B?SlJOcjBiajd6dE1YODh1MzcxelVZbFZLRHE3YytVOEI5N0pOSlhiV05SbFpJ?=
 =?utf-8?B?Wk9QaGprd3RYaE5vUUE5NW9kUU5rb0VqSWFUbDkyaVR1S3EvbVBBNDBSM25T?=
 =?utf-8?B?RXM0Zytid2twZmxRaVladUcvR0R3bWFqM0hCM1F6cWVzT0p4ei92bzFBU0ti?=
 =?utf-8?B?QTlNUXBPNVFTZExDZzk0SStVRzBVRGJCRndyRWsxblpZbHB2c3JOdDk4dHhk?=
 =?utf-8?B?VGNkbnB1b3pHdzVsSldKSnVRZ0FESTJhcnlDeFBEZkpXQThCUy9IV3E1czFI?=
 =?utf-8?B?U2JPWk9lWXFXR29COHpNNkxxT0xySXZRTlhMeEtKaURLYXlVK3dWN1VsY0ZD?=
 =?utf-8?B?dHhlMnRPWjB3bDBUYzNHOWNLRGN3V01zTVIwYWpiUHBiMWk1OWVIWVdJd0sw?=
 =?utf-8?B?M2lXcWpsRFZBUXhXYWNzMG5WbkNwOTdVdHZSR00wSWhMQnFTc3NlZW9pbnpl?=
 =?utf-8?B?Vm5QRytEMmk5aUhZcndwcGRLaGRHamcwY3czNm1sTUlwOU1malBaakU1YnNJ?=
 =?utf-8?B?c0kybno4ZHYyOUNWUldhdUNTRmZGclpiWE1ZZW50QmZtd1RHdVNnYTludUJl?=
 =?utf-8?B?NE5ybVczK1pDcnR0eFVDYmk0YW5HY0QyZSt6dzZEeHlVVUtxYzZlZEt0Wm5Z?=
 =?utf-8?B?L2FBSUJmTDNvSWFtSGVxallPNXVueWxwZmduaURBWkZMMzd0WEdMZHVVNnhq?=
 =?utf-8?B?VWVzMWpEQmJlUGVkY1JEempwWnM3d1M1WU1TRVJVNEIvVlpubXR3MzczQ2tO?=
 =?utf-8?B?cDUrc2xoQWJtblJVeHg1bFRLTVVvdE1tYStMUmlNOGYrSTdGMkcycENyUmtJ?=
 =?utf-8?B?QlBVcTg1Mm40OXBNU0NjaFIwZ1FlTXBubVJkbWxMUjRIVzlua05UZGdpMG1t?=
 =?utf-8?B?K28rWk1mcGpJOFU0b1MzUXc0OVB5K250dW1rSkMwRXRMSWgrNW5wU2xzU3pi?=
 =?utf-8?B?QnNCSGZkam0wKzdXQUhVU2NLSjRvTHhmZGtpZS9qNGVVNzZ2RngxZFFFV3ZU?=
 =?utf-8?B?bGNEcm9vaDg5dnpDTnFvcWtDUDEzY3lpT1h1cFJwbFRoT0xpekF5YnRiQW50?=
 =?utf-8?B?L1NKVXJlSG5EVmVPMzZjcUQza2VvVWRuTkMyRld3bEUvclM3b2Q3T2d5S0Rm?=
 =?utf-8?B?b3p5RzNBbytEbGtnQ3ZkdzZrb0NURHFiL05yVnVHUGl3ODA3S0x6TGVTV3Fm?=
 =?utf-8?B?UUtMSWdEM0tQWk5yNTVCb0Y5c0JRNWRFV0xJOTFxRzhrNHRSU3BHVnRRY3Fz?=
 =?utf-8?B?REcvT0lzbjkxNVpyb3hKcGo1VDhGVDJRSENSVUxHTEFKZFA4UTRHWS9DWXZP?=
 =?utf-8?B?WnVacExSUGEwR3JkdFNrMUdndFU3MEJ2R3Zqd3lLVlRneXJ1SG9sQzJnRCsv?=
 =?utf-8?B?SE5hMkRHa21ZVmVRbHZvK09keXZzVTlEYXNOd2prWDBzc2FEUEw0b1FBR0FI?=
 =?utf-8?B?VVJQdksybjBSTXAwaURRN3d1YXh3Zy9sNm9XbFNoVk9kZk1xcjViclhwM1Zt?=
 =?utf-8?B?YTBpVk9ZMzlRMGF5eXVYNDJ0MWFMdytWS0FpNTRhbUt5OFFqTmcvRjNKM2M3?=
 =?utf-8?B?enliRW1XSFRTZXNPQXo2eEl3SFJMR3p1TDJJMmdEejFrUEJ2MWNCWHhYWFF4?=
 =?utf-8?B?SzRXRG95cUd1N0Z5WXhudWNhT2cvd1hha1JwUzRoZk5Hc2QyVXhvYTA2K0lI?=
 =?utf-8?B?Tnljcm5tUUttSnBrL3kxV2s3VnhUMkJ1alZldG1Cb1lLcWpoNmk1R2JSVVhu?=
 =?utf-8?B?Wjc0UW5YeTk5eC9Qc1BxRVBGT2hlckNINTcxTitPem1qTkZ6aEZjSG5qZ0FL?=
 =?utf-8?B?ci9BV1NHeGF1NVc3V0NMMnJySFdaRWgydGw0OWcvdjJ5WG1oQzZtS2hSNVNu?=
 =?utf-8?B?ejVLRm5SL01CZmdpZFkzU3FsL1F4WG5YY1BVNnRQQThQNXp2c1pHT1ZBTE5m?=
 =?utf-8?B?eXZRZHA1VWp6Y3FoNFFlNVVlMmlTaXJSczZ1RGQyU0wrcWVqNWw0ZTZ3NUJl?=
 =?utf-8?Q?uX/a17OmGTlXLXpY=3D?=
X-Exchange-RoutingPolicyChecked: ZBa1XDlvVCcq0p9Y+iuLCdcVCsWq9JE1w2LGWVrO3PmP3inZPrUM4T9WRcuxnxKpE3r8mYsOxOXal7YJ0Dw2/WsfhIjOKjS+Ck3cbkO299m316QAupPi7+ejdXYBo82bUtRA01eexyCn7NYNE4CrOin0vhDwuO+eGxhSwWxlXTJwLnztuAIbndDcQu9wJ+Bq/uBR7uRbR4RcpRWVqTtbQTQbcOn80wEAGQ1gwHizl4/BGAVlvM+rwMRbaHZIY0lWIllv/BMyKtmqbyczrGuAwWjPguUbSEMZLgnTaBqKiDwgiJ/3P29ngxHjRttWKWHwn322uOjDwXWBrkLYJk3lWA==
X-MS-Exchange-CrossTenant-Network-Message-Id: e16b7d2f-f6c2-4f4d-1aec-08def39b111f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 09:14:06.8101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o6giSb+5miOx7Skz79bAElx4wrS19QxrPh+6s10Om8Hqx/F+B29QKPO/GosivUNaiowsWQp9wX+U9xWZjzHD1P0/XvQlN8u+ztgxfMy3adU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5793
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786007652; x=1817543652;
 h=message-id:date:subject:to:references:from:cc:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=EYFD2GY6han8jqcvwQRfiM+6vZJpy6IKgBmPIdP3G7c=;
 b=Y98+9V00hC1umlizIdluKj5raNb2nOFkKSNpEhQTyRxpSsiLA9IBCAvv
 +GpM1C8aVxolapKFHvJ8VdOuklva0vVWSQI4i9FVDO/P9oQzLKIq1mCkB
 lkbNBUmnFSxnLqvr90aYstiiAe0S977oeB+/AVqDX5rqZdU1rWXKA6QX6
 EllQ2o3NMC4Xncw3W7JTK1vVhdqQ4P1DVxp9RbQGEZUXoTBZDTjgi3sYi
 OOz4yRkJhXmrw7KPNaVBIGQpVdisX3Oy50oEPe+JficcCZ4jXwdDIswxg
 Ehkusf0OUAUSi/1pTBJYQn+aFDRfD2bGNHjwTW69ncq/I8QrSGQpDpx5e
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Y98+9V00
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] ixgbe: NULL-pointer panic in
 ixgbe_check_mdd_event() when SR-IOV disabled (num_vfs=0)
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

On 8/3/26 16:47, Viacheslav Tyryshkin wrote:
> Hello
> I'm hitting the bug daily with Intel X550.
> please be informed, i may provide kernel dumps on request.
> 
> ## One-line
> On an Intel X550 with **no VFs configured** (`sriov_numvfs=0`), a
> spurious MDD interrupt reaches `ixgbe_check_mdd_event()`, which writes
> into `adapter->vfinfo[]` without guarding for `num_vfs==0` — and
> `vfinfo` is NULL when SR-IOV is off → kernel panic in interrupt context.
> Reproduces roughly once a day under normal operation.

by looking at the code this is weird

ixgbe_handle_mdd_x550() reads two registers into wqbr, and the combined
read must be not-zero to trigger what you are observing

A patch will be much welcomed, given all the work you did with hunting
it down.
(avoid html, target at current iwl-net tree)


