Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3BEC4451B
	for <intel-wired-lan@archiver.kernel.org>; Fri, 17 Jul 2026 20:21:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE73280E65;
	Fri, 17 Jul 2026 20:21:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1IU672t7Qqqd; Fri, 17 Jul 2026 20:21:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 12B0280E5A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784319700;
	bh=tu0WGqLnOmgBd3GjJmUPqAuATiz/N0vHYA3OUuKu0NQ=;
	h=Date:To:CC:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pDwO9CslKaiDFGY2W2RQ9xx7w7+FVfTUdC/hCmhB9z/Q1GGuIdKFRtlvMIOEyROh9
	 W7KvhvYeW9TlG+FQEwYsDKfKkCUJTmedksTJkh9aj1PvDMuZdukmhfTuBPtQhX8AXt
	 8y8D5N/go1Z5pH5hWT+fPUThpVFvfg0tjLS7J5iwN4RHJY+4D5a51ZXlITzh8PQJFx
	 ttmwKt2G6QFdyJq2IuNNKJtbFoty+TBFXPoSup6P794Fr5OowJsvku3jtXqUXiM1T2
	 Ussku5G9vnwyVIe25aYrF/YjZwL71+9nICPfOdkGuikyZwSsXKl0CP3+HEM8zS55yx
	 8GCAnRt6Z5FiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12B0280E5A;
	Fri, 17 Jul 2026 20:21:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A3411F6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Jul 2026 20:21:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8F9AF40672
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Jul 2026 20:21:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XWisdSz4cT05 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 17 Jul 2026 20:21:37 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=anthony.l.nguyen@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 611F94066C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 611F94066C
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 611F94066C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Jul 2026 20:21:36 +0000 (UTC)
X-CSE-ConnectionGUID: cNt1vNUnTumnipFTBuk2uw==
X-CSE-MsgGUID: xLsO2zJzQrKI3cl2GNOlnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="85113058"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; d="scan'208";a="85113058"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 13:21:36 -0700
X-CSE-ConnectionGUID: /pUzaoUxR46Qy97MJgSH3Q==
X-CSE-MsgGUID: G+inSJ8oScKF2KnDLaEGzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; d="scan'208";a="255704964"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 13:21:36 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 13:21:35 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 17 Jul 2026 13:21:35 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.69) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 13:21:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KaKHjlQr3JchVX+vyFz2zvXACJOQf4Xy2A9uqypP4NNraITBLIdkiEUV+mbV6GMBeNjfju1oioZA8EU5Zhmvm/qxBNUp3sqUxOsiYZ6rzA5xsZVIDN0AgQJd0Fi7BuoupWaypDedFyOtI3nmS+tm6AELlOqYJ95tDyLHHYaouXUonE+W4eXGbNENFDvIqRLuUeW2QIKPQG66h9oBTNbZkjVr40s/iDa74LXBoy+vPbPHf/AHtQ5lI5grpHKEUulqp9XQLwRnXSYLXSDj6EgNnXCWKIeYl2KJsbwG0Fk+0npFwKD3ozhtCYRNNK/P38TrIpQmYtuVChItzUl3aj1wzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tu0WGqLnOmgBd3GjJmUPqAuATiz/N0vHYA3OUuKu0NQ=;
 b=ZQjMv3ExCx4LWwW6v1XavELiyN1BBf9fJ1aSkYSkgG41AMQ+u9lgQmZAPAEbVzK5tkpQpqo9m7CYbGSXSMjEm7yOIKlamtuJ35mY4Tza4y10oFFvoO1unEGL3xSteOZ+Sr1NtBKiHKyiUtZ2rW/JJLXzrc//EVXjm8oOGG6gp2uDzbwPcU8Nrb962InJPYZ5Nu11UMSgQBiZfbhwkHSXXmo/yTXhr8mZBTX7l3NPPR69id2MoKenfJqz/W4PByCLCa5uPYd5xs8AZ4S4cq7GYSFjEnwS34EI8dAGRXf0DNkz7FNQ59JxEO5cbqsgNq5RAPqjlPDgJwIgH+u732QS/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by DS7PR11MB7930.namprd11.prod.outlook.com (2603:10b6:8:da::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.18; Fri, 17 Jul 2026 20:21:32 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%5]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 20:21:32 +0000
Message-ID: <37756e55-5feb-4f5c-9400-55a9762f9a77@intel.com>
Date: Fri, 17 Jul 2026 13:21:29 -0700
User-Agent: Mozilla Thunderbird
To: Myeonghun Pak <mhun512@gmail.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, <intel-wired-lan@lists.osuosl.org>
CC: Milena Olech <milena.olech@intel.com>, Emil Tantilov
 <emil.s.tantilov@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Ijae Kim
 <ae878000@gmail.com>
References: <20260715074342.49281-1-mhun512@gmail.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260715074342.49281-1-mhun512@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:303:2a::15) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|DS7PR11MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c00f8bf-a96b-4d9e-da60-08dee440fd9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|56012099006|6133799003|18002099003|22082099003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: iLi762HVQsWl6dPIVUQQse9xdSVmZhbR2JFzs1jozxAD1pk0jG1fCxXrRpkutjU2sNrxDxIZnGga0S0kaPB7XYRjp8FB59wnU6lX1PsE5kUTHQur1TRaESMWhJ36RBnUXA4wSx60HzePDrD/oT2MpgppwLSp+jdFGLuH5zn8NEN0VBfHsZFYm0qXJzqr1E3Y+HQWx9NQalbRGBtlVW60aUstOiYkeUtRLIjI7V+SrB5c+L7qyHStbtGkGVxBzoExXSdQI6R/J3AuuFxm8IvId1SugS78Sm0oPLaN98nElZNmqs/4bKWIO1KjwkERVD2vlpDXJa45UVtyKrdaf+vo3txIJG5729jDM2jPKs09S0w+G2K7H+3BIuSMMP57Q/f1TLX1eDahpF5mMxkiifmeF+h/DG1F0/Z0zDdeTNTu8YDriBK2SOUnXlPxxGyjmrzI8grh6pQYiquDUVw61n2O7QritXC1ky6QjgjD5qmPk4kpp7y2FrJ4eiJNRQVWf9yyDAnfyj7IEURPEHp8pqmblQ3R7fTnytjFPg5r6RNXAkAsjSaASp5y5FgJySiOXFsVm1d6KWOhA52J3EF3/p14PPwEcV6Qeu/guuVJE5TA3fRSEPiFl3gKMpaJo/66ujyj6If26Y6HzSK1mIncyPTQUq3CBQgpLzxj3kRHdjkaR/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8230.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzA0RU1xSTBxMnQvNldqQ0ZKNGw4TXdFSDBaOVNhY0ZmYzJyL0ZBYUhHTnNB?=
 =?utf-8?B?ZUJJVmR2QktIUTBpT21hUUdaVHNncitVK0Z6N2RHYmVvb3JBeXVnYmtDaDIx?=
 =?utf-8?B?M3RHUzZqRGd0WkRmcXd1alhRdms3NVMxNjBSOFJkZWhiSlMwZ2F4TDZPWUl6?=
 =?utf-8?B?Q3g1U3FJeXNkbXI3THZ2UFNNOVRzY1lOMndoeFpxSlk4K1JLZnpkbE1kOER4?=
 =?utf-8?B?WDY3VXRsVHBFVDhwZ1ByWGlLVVdhM25xRDhNZEVYc2FhQ3h5UzI1WXo0Vjd2?=
 =?utf-8?B?ajNYbDBNNkc0ZHByQytiMmRqb1k4Z1I2M3luTnJZckRFVlQwS21EcllIZmNH?=
 =?utf-8?B?RlVHNm5PSXlLUjVBbjJ0RkRxcVlnWkNoT2hyL3h5UWtGL1J5WXJMZ1g2VVZa?=
 =?utf-8?B?NGFLWVdEdllIL3FGVkZlQzQrOHNVTEtmTjkyVlppd1NjWXpDeEpkUmhXWnJC?=
 =?utf-8?B?elhJQTZLNkxSWStOMDhpNXBzSVE3eUh2eGYxOEZ6RTdlZmFCa0g2U3VtQktq?=
 =?utf-8?B?Mk1BdjlMa0xNTmhQVWxhVG5MMmpWOTErZS92VDM1MXNodk1DWEZHUDNqSjBI?=
 =?utf-8?B?dWdpUXMyV2lrcEQ1VmpteDNSSGlYSkcrV29ha1NqZENabHV2STZEdjR2eWh0?=
 =?utf-8?B?ZGVKem5uOEJ0a3psaXZ2aGlENzdKZzJwd25zMlZuZjc4TlpybGRJV1BOL2Z4?=
 =?utf-8?B?U0IzSUJkVDRMVGVTbFRDQ28zYVREdGVJRW5UZVFWUjd2ZEhMZDR6RVZpRlNj?=
 =?utf-8?B?d0Z4OW5WMC9FY1RhRjRVNXlEc2JpVWpsU2J3Nm1jVjFsVXJKa1FlMy9tdU1r?=
 =?utf-8?B?a1FQUnIvZDA2Z2hldUxjbFREM1FyRFFKZEpYZXRuM2V4Mmd0VWw2ZHZ6V2xH?=
 =?utf-8?B?bkJ3K24ycC9ZR1FML2FHSGhxdURNQ0dKNk54Wkl6U1dqc0p6Q202S2tpL1I1?=
 =?utf-8?B?dVFNdDJCWTh6cThOMTkya2grY0FNRStyeEJheWNFeVVFRjROTFBSbDFyRjBX?=
 =?utf-8?B?blQ3Yjd1TDVVT1FoOXV3R2R0cWpSRG5FOFpMNG1xYVgrK2pkK0VhUDlvMnRv?=
 =?utf-8?B?cGJIL2pXMEpFbno1VGxQQngrcXVpRVpoQkNMendmdnZzMEpEdEM1SStHblIx?=
 =?utf-8?B?dGtkSjRVQ0RlUXMxY2cxRjNzdWFPd2NiOHUwWUJPRTFXSGRFYm1TdDlqV2g2?=
 =?utf-8?B?KzNNUFFJajc0aWVnQS9nUS8vY3cwMlhsSnIxM2JvanNqckp2WjVWcXFWYnR0?=
 =?utf-8?B?d3h5eU9TRGpNQ3NMNTNFc1hsTHVlZ0ErR1l1V0dGTEp1ZmRLVTluMEhzUU9w?=
 =?utf-8?B?SFNITUptWmpGeGVVWmxqSlp0WUdJWjkyNUE4NHdvRFF0Z215R2lBMHFxZzJK?=
 =?utf-8?B?SklKWEVHdlVYdVZFM0NLZG1heGd4UEQydlkreitZalAyc0ZWU1QwbURPWGRY?=
 =?utf-8?B?aUhlcmVWWEp4VkNaVVZOWVo2TGpvS1FEMkxWNlJJcjJpWm1OckdYN0FTMDdX?=
 =?utf-8?B?bHhEZDR5dFJTY1pIZXpCaG5GUnR1RDNVK0x3OXZZaWdmaVRSRDdyUTU1RWla?=
 =?utf-8?B?b0FYdHNhcjV0MWd4WlFKTWlpYzZDUVBaZ3A4NnQ5L2dVaDg2S2FtRGRKc0Nn?=
 =?utf-8?B?Qm1WRUY5ZEhrR3dHcGJXSkc5Qll4djBramZTM2lVTHJtSzcwY1YwejRHM29M?=
 =?utf-8?B?WU9vKzVZdmlCZTQ0RGtjUkptQm9SaDRWU0R1a1Iwb2gwYzl3bk8ySVczVTAw?=
 =?utf-8?B?aG4ydE9VOHlPMXlMMmNXQ042NXFtcG0xWHduWW9zaFZURWQvSFdtby9TUFpl?=
 =?utf-8?B?Tldsek1wMDBzcXVaVjFVWnhBdDU1RHZ6UE5MZ1I1VjFTV0RqY1V1aFdvSmh0?=
 =?utf-8?B?bFRQYWVRQUdpSVJaelg4V1grWE4va2lyZkMyNlFIc0p5QzlQK3hpRFBrNWJI?=
 =?utf-8?B?dENGbkVTc252WVF1Yk1XMGIrMzNOaFVReUM2NFkrSkYwMmMxSlluWDBtVXhL?=
 =?utf-8?B?d21pWkVJcEh3eG0yU1JpUjU4UG4xVlRZa2lvLzNIMElYb2Y1ZW1KL3dBQ29C?=
 =?utf-8?B?bHpKN2h3N3hFeUhaZWNmTm10UzJmVGpNdStCNWRkOFZuUXZmYXl3NGNBT0VF?=
 =?utf-8?B?Vk5CRDR6T2I3dEM0UkpQT3VQbzgwUk43bGNiZC8zM1VvUk5CdE14ZnVZclQv?=
 =?utf-8?B?cWcwU0dwd2pFR2M2MDYvUkxqdGo0RGRRZ3l3QVdaQmp5UGRydTltdG4rV0RU?=
 =?utf-8?B?TDJ0b0xJajFBZ3dqYVVkeU14bmRYVG9jOVNmVnRteWRvQkVHdENJK3ZVMS8r?=
 =?utf-8?B?dTY0Skh5N21ZUHRNZ3F6eThxSjFJVjJvMlpkaEF0NStrOHZSZnh2Sms4aUV6?=
 =?utf-8?Q?KA5cBRZHYp1uoiQY=3D?=
X-Exchange-RoutingPolicyChecked: G47pESyY914Szm55PEqbOBwzZRj2Gu/yx8BBLme0+Sqwvn03tUdOz1fErG83pDcl3qThXNaL2b1wr6kf1J+pd8CTkTXRL8n52/wx1FzOBKB3PL1QNZpGy2/f8CumFSl5GUqzw80BFpeOW+AR8ZX3A+Pvmyp675prI82UAA++XDJu1bCdImK6fW3u6ItFdMwCmO6BIBP4lKYc+h+PjtRICRWRA6SPtOIH0rP2ddiTUD3/98kQ/eXqY5y1UE6SqVmomtepcmU12rHuYxvD/IM8yIx8EhJdWLBEnzq9H2yxaaK+1Y6HoLT7+HZ8t353cEpaQ2NCGFloC86uT3BDxXUUHA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c00f8bf-a96b-4d9e-da60-08dee440fd9c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 20:21:31.9150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KEECUzkACde34ZNI261dn2tR8NmHbsYusPbyZWjoNQfEBtX/eRqs6dVPPTeoGaO0WMmXznb6iZtBLhfU9k5CiekAGH+5nF61ljPbZht3X/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7930
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784319697; x=1815855697;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tvhMXeYtuh0LoARtT5iDjvYAU7JJio3gTSDxar6axWQ=;
 b=iCN1eMqV+pLMB/Tc7gj9YW70DYzIIylG4Rky0RhINgbBFGEVS1Q62gxN
 2VJC8rHYVcldzXEImazNcXe0gS934MaF3tzMekBHTqB1W5KDF9Vbvvl8V
 wvtgEe5SJ7vF1qH9iOm/iFYI/RMkFZk01AMejCGQHdCIFEh7MF+oQT+Zf
 +VABft1LRU75AcLnGRtxmYvT1FDWsv+/0FQ+l/3gqkWGsOOP2gHWYgUm0
 3n5VkRTYQT6B/6bhBD6jr0d+Bk0ovDGQNHt9HiVJNmuY0YKaThENk0Ac/
 F4n84YjaMK42Emx3XMf7RkI5DkeDXEVpib9RjyoGzp+CHcEi5+LEcaKOb
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=iCN1eMqV
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH v2] idpf: disable PCIe PTM on probe
 failure and removal
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



On 7/15/2026 12:43 AM, Myeonghun Pak wrote:
> idpf_probe() enables PCIe Precision Time Measurement with
> pci_enable_ptm(pdev, NULL), which programs the PTM control bits and sets
> pdev->ptm_enabled when the bus/controller supports it.
> 
> If a later probe step fails, the error path releases the allocated
> workqueues and adapter memory without disabling PTM.  The remove path has
> the same imbalance when a successfully probed device is detached.  In
> both cases, the PCI core's software PTM state and the device's PTM control
> bits remain set with no bound driver.
> 
> Add pci_disable_ptm() to the common probe unwind after the PTM enable and
> to idpf_remove().  pci_disable_ptm() is a no-op when PTM was not enabled,
> so the non-fatal pci_enable_ptm() failure remains safe.
> pcim_enable_device() only arranges for pci_disable_device() and does not
> undo the PTM enable.
> 
> Fixes: 8d5e12c5921c ("idpf: add initial PTP support")
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
> Changes in v2:
> - Disable PTM in the probe error path, as requested by Emil Tantilov.
> 
>   drivers/net/ethernet/intel/idpf/idpf_main.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
> index 0dd741dcfc..f08ce13c20 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_main.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
> @@ -159,6 +159,7 @@ static void idpf_remove(struct pci_dev *pdev)
>   	mutex_destroy(&adapter->queue_lock);
>   	mutex_destroy(&adapter->vc_buf_lock);
>   
> +	pci_disable_ptm(pdev);

Sashiko says:

If pci_enable_ptm() failed earlier during idpf_probe() because it was
unsupported by the bus or controller, does this unconditional call to
pci_disable_ptm() corrupt the upstream PTM enable counts?
Looking at pci_disable_ptm(), it does not check if the local device was
successfully enabled. It climbs the PCIe tree and erroneously decrements
atomic counters like ptm_enable_cnt on parent switches.
Could this eventually break PTM for other downstream devices sharing the 
same
switch if a parent's count is incorrectly decremented to -1?

>   	pci_set_drvdata(pdev, NULL);
>   	kfree(adapter);
>   }
> @@ -266,7 +267,7 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	if (err) {
>   		pci_err(pdev, "DMA configuration failed: %pe\n", ERR_PTR(err));
>   
> -		goto err_free;
> +		goto err_disable_ptm;
>   	}
>   
>   	pci_set_master(pdev);
> @@ -279,7 +280,7 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	if (!adapter->init_wq) {
>   		dev_err(dev, "Failed to allocate init workqueue\n");
>   		err = -ENOMEM;
> -		goto err_free;
> +		goto err_disable_ptm;
>   	}
>   
>   	adapter->serv_wq = alloc_workqueue("%s-%s-service",
> @@ -366,6 +367,8 @@ err_mbx_wq_alloc:
>   	destroy_workqueue(adapter->serv_wq);
>   err_serv_wq_alloc:
>   	destroy_workqueue(adapter->init_wq);
> +err_disable_ptm:
> +	pci_disable_ptm(pdev);

Like the issue in idpf_remove(), does this error path unconditionally 
disable
PTM even if the earlier enable attempt failed?
If a subsequent probe step fails (such as dma_set_mask_and_coherent or
workqueue allocation), this path is taken regardless of whether
pci_enable_ptm() succeeded.
Would it make sense to track the PTM state in the adapter struct, and only
call pci_disable_ptm() when it was successfully enabled?

>   err_free:
>   	kfree(adapter);
>   	return err;

