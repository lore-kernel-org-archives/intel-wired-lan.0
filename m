Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A909EDA68D
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Mar 2026 15:44:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 189BF608E7;
	Tue,  3 Mar 2026 15:44:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iNFb0dPg9yna; Tue,  3 Mar 2026 15:44:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 336E0610AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772552660;
	bh=aiRuXLKFh8NIHQf3RDer3vfPvlfda3ePkWo8rFXtc3U=;
	h=Date:To:CC:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AEXr9WNOX0eUPK0k42zx6Z2b4XGjhoxzM/JY3Nr35tjckuLBd8hCLyjzaiAy6p+1J
	 ypBB9sP8DkDqdq/L0HXOHi2j3D6rxS3GbtoCOGgnwogZ64ysAQSVsmR9iCGktEhVsk
	 CRRYh+rUm26d3V1enLQYHMm3rLWUhUUKufGt3JT5GPx/K9m3T4/3/+rGvqz/Lq7Cks
	 x6j+7jzwO6EBCsTw2hF6DNe4uo1EMDqoiHhdoyr0lu6mAUTUrOCmIHg//SQOVofpQL
	 zu/2Jmz/b25F/2VQb1UShSf7mQktuCwtbqpNCqLARqv774mHmCvlyvv6euQjRWK0+w
	 ASF+w7AJyuZhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 336E0610AB;
	Tue,  3 Mar 2026 15:44:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 502FF25B
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Mar 2026 15:44:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 30B4D828D1
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Mar 2026 15:44:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ivp5wwkM5Ifs for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Mar 2026 15:44:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=aleksander.lobakin@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2EBBC80EB3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2EBBC80EB3
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2EBBC80EB3
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Mar 2026 15:44:15 +0000 (UTC)
X-CSE-ConnectionGUID: PTS3oLoPQVCWHJi2LHcUPw==
X-CSE-MsgGUID: Usb2LuxIT1GOU8ewiuTQ2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="96204031"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; d="scan'208";a="96204031"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2026 07:44:13 -0800
X-CSE-ConnectionGUID: VFLjTnJgR4mGFQK4cKg2tQ==
X-CSE-MsgGUID: HRtlZONXRU6rmNQYN/8Duw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; d="scan'208";a="241045606"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2026 07:44:12 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 07:44:12 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 3 Mar 2026 07:44:12 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.20) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 07:44:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7+hyp5xBRnF5VTdV6AAafFyp+wFFH8hJDzo4dL80Ln75tKzZp+Myoi+bQWYMKuW8GAJyrQ2tzDHsg52eNt5nk0h+Uq1TwbB8rY401ZjTN3qpPWUtdelPXuAEQSmQ7wR/nMoRESTSer9klJPzvFwpY4qNWIRnCerPLr1QWgJPcf4hTSXkSU543eG9orpRzCSU8fh0NUCIEXW+qObGMXyOXm1A8boksVWfrkev6IMLZQqwbyOLFSwImZ6D2T3GiPaQgGZz1EWPu76+T0u8uOsQcqbV3QT58gzxK3ygopaAJsYIG7fIwTdJygHy0bPYITytZvRKUzyHDPCGm0e/9ttJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aiRuXLKFh8NIHQf3RDer3vfPvlfda3ePkWo8rFXtc3U=;
 b=EAIw1U1a1MuFVgh+3b/j2OQBqd8s3wcpRWfI3R1ik1L4nRvCNs0VRKTCefdphIgVw7ycr6PM561Ns9eegUlNFlhQWOySz9UzMkjlBCEfPLgtYPYQZ9PLzzF8MkFnMGh4AFoOePUPvZTfYPPLVRpXzMvcyhIKzS//z7tju37xCBJtMUHZDWCpFO1PNIostQ73ATVYCc/jYH8PP3RQlUSrhMhhW1TEM74dSjR2arRyXdhABy58lkzjYn85vb5R020aaN9O81vGovjcSy7qhaaK+D82fdLqDtoIEkL+Qw7NbBAQqgF6Yh+3ohJGj0HlbeH/6kjBz13Gykz8yn0EMhZ/Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ5PPF6E320AF71.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::833) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 3 Mar
 2026 15:44:04 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 15:44:04 +0000
Message-ID: <ef25723a-84c4-46af-9f54-81945b21e9f4@intel.com>
Date: Tue, 3 Mar 2026 16:42:48 +0100
User-Agent: Mozilla Thunderbird
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kohei Enju
 <kohei@enjuk.jp>, Jacob Keller <jacob.e.keller@intel.com>, "Aleksandr
 Loktionov" <aleksandr.loktionov@intel.com>,
 <nxne.cnse.osdt.itp.upstreaming@intel.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
References: <20260224174618.2780516-1-aleksander.lobakin@intel.com>
 <20260224174618.2780516-2-aleksander.lobakin@intel.com>
 <4dbf4f75-0474-4583-a2ca-77e4886c2dec@molgen.mpg.de>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <4dbf4f75-0474-4583-a2ca-77e4886c2dec@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL0P290CA0009.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::6)
 To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ5PPF6E320AF71:EE_
X-MS-Office365-Filtering-Correlation-Id: 329d213a-3f83-4d5c-fb31-08de793bb280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: lg1lMzhwPl63y6JnH8F5/coB1lDJXUGNVxhj+KNZSS1ad6woUGgwUOpCuxvGX3AUru+wz7C5knYh3TPksUeyjuooQamXgc81WEPmuoB+MuWtg0IPO36pWKQu/f1G/Gtt6Sl5iC+/x9HRgKq9IyS+OxLbOT7idj4ID7sfyUqOBNwYSEIn8blDj/rHcR/sde7FSncmLxZxIviClmLP63d/ld4E0Y9fnPvRVjOz5kAi9GoilZjiM1N2t98xvfPdDILiCVSfLpbiB42TDFxAvrF4+uUUhQuLZiGsF8Z4/incgS+/QSwv51r0ynuxs/3Avd18BbL70Rhyf9WzJL3aNDhpG7qxtK8Ip3PGnvZzYy5R6XHQ3mBlkMLct82LlkKrZvvrS4jxVYP0f6IMJsZ/gR0yuyIGALrsADBnfhD0RJL93l64v94D0Qrw2MPHBJBqfJndXcrDTEibZLPpSXGdGDr97oTVMSX/wS44xHhn6i44ssgGKZihBMvjKKK4aHjm9o6MGHtkDJGl3XkookC3XFgj7CYby5oCePDhi/2C9ztpX8qdeurJ2PcrJxwc0Ykk+ka+Om5k85IsjzYx/cdqyxmFR23K4zCveTe/TIP+vEILbPeZJJC+cxgA6ylmTCElQ+lrX2slJ3ju0Q3clXw2Y9QSm9Ia3H4HREb/OINCK3N8aV3xgj3b3n5Fsd3NLBFi97wgoTjIBrGKV5mlfCfxEfRN97VCNHX9LIQzgoV6QvzzyVo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8718.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am01czQxZU42UFcrTDAwZDlPcTJMSzV3QUE2eFJjVHg4WnYwMFpIZG5WbFhD?=
 =?utf-8?B?MWRFRkFaY1lraXErNUFWKzFqbHNhL1VWVlpPT2M5QUM5REpveW9USGxIN0ll?=
 =?utf-8?B?VnhyVVRrV1RsczRZZmphMHE4aFFUS1ZLTmhjc29KZXNWcHhlQnJNVDdIcjhP?=
 =?utf-8?B?alpqUjY5cWVHMDlTbkRxV2hjOEpmZHowNXI5RjZCODVHcVBwNHQ5dHBkbml1?=
 =?utf-8?B?NUc4STh6aUVoQWk4Y0FzS3dFeFdVZmNrTHVmRk9PNWdQYll0ck5ZYjZHNklZ?=
 =?utf-8?B?NnY5VFUrQzR3NGFVMnJqVHM0T3I4TXR4a1RCN2pMYUdOdllZcWczSHRoZENC?=
 =?utf-8?B?LzFwbXBON3ZpV3lQbnBiNFYrUGlRakNLUGZLZTlDYzBlRHhXL1hFazhFU1NZ?=
 =?utf-8?B?aDRqTmVoTDJaVTNvUjJnTVdESldyZndHRzRmdnBzUml4bXhBOFN5UDA2N2dp?=
 =?utf-8?B?a3VPZkg2TThYeXBPK292S0Z6YkZHNXlEcWNjbnFDSndsdWsvM3Y5NkdhR1c3?=
 =?utf-8?B?MjdZcitTYjVBSExPY21EendHeC9xL0FEb0dWd0tEVWtsMnBVaE1GaEwyQzJK?=
 =?utf-8?B?SmxQUXlaZkJhdGJrTGFlMGFmVkpOcnI4YUY2UCtNempoNWMweit0aXBaK0pO?=
 =?utf-8?B?NnNoTXJqVnNZN0RvYnVSV0ZOYzJCZncvdFg1WDl3Vk5EN1BtcDZVRFpPd0Z0?=
 =?utf-8?B?OW42aVgyaGMxcW02Z0J5QVUvanlGLzV0eEg1M05KUmtmZlBSenRZZFNWSURx?=
 =?utf-8?B?amxzS1N5dzMwUGVTT25IRXBsdHF6TlhNU3BKby8vRmU4VXlCcXpNWnU1S2dF?=
 =?utf-8?B?Z0ZwMGh1RFNkTVoyYXFkVHhyWVNqVWwzRkNLQnlyMzl2aWpnSnVuL0pGdUtM?=
 =?utf-8?B?WTViS0NVWjdQNFNNQVJkZ1pUbUx3MVBlblo4Qkxhd1Jka2ZxUjRqakY0VEo1?=
 =?utf-8?B?MWdiM21jTVVZbnZFRUxZbHM5WmU5bElBYkRkOEUvVkNXYkx6aDBRK1hLcWpF?=
 =?utf-8?B?NGJ2VzdZSkFEclV0Ry9tc2RDRSsxalBaMC9yMGgvM2pyVDhNalZnVUowdFBq?=
 =?utf-8?B?eUg0UURKYzljSzNYb0s0dCtTNFJVdk0zeHJqVDArZ20rRmprU1pGKzRsT1Ju?=
 =?utf-8?B?dmIrSEZna3RBM2NXNkI5VzZEZTRGSUpYY2VYOEZPUUJvNlArTDZ6cHRZeURt?=
 =?utf-8?B?V1RYQ2E2RHZ4MHdOa3U1L0lUbjdISlQ5b0xoY1A3RUVzL1o5UFo0NHJ5TnVq?=
 =?utf-8?B?WStmRVJVcVE0RWVadEJmaTZDRGNXdVpWVW5KTDZrYlpOYmZzaFRlWFRVNzN6?=
 =?utf-8?B?Q2t1NFV2VDcwSUV1d0N3ZlNZUXA5Q2I0bTVWM0cwaHBNOS9EM3JNbzNrMW1h?=
 =?utf-8?B?RlBoWGswQmdqSmhVbFBveEVZdCtNb0luaFppckFJTHMzR0FPYXlocUQvWXl4?=
 =?utf-8?B?SjFpT1RQN2Z1WjVOWVUyUnVqSzd4MjBFMkRqTTBwUS8vRlQ4WCtTT05YTWRZ?=
 =?utf-8?B?SnJURmtzVVFSOWpVZHBETnQ5VzR5Nk5uOWlpaUtoSWppclNkUDg2ZVNEc2Np?=
 =?utf-8?B?OHZaVGpHbUJVUDAxd0REY0gvQVh0ZTNCaEJ0NHN6RU8xVjhhR25OQ3RobFk3?=
 =?utf-8?B?MytLbGpFdjVka0VGRWFxb1BrNkRId1VlYTMweFdHUU1ka0p5ZFRabFlBbzB3?=
 =?utf-8?B?NENMbWY1bEFaWW03WjVmY3BBdU5RWVJ0RHFLVktza25mNGRuLzRDandnUENO?=
 =?utf-8?B?NlVrNE1TR2NOeHlXREV2MHJYOXd3K1AxZWZydHAydnhZdnQ1WDFKRVhYMEZv?=
 =?utf-8?B?REV4VktDU0diUnZYVk54QUo1UDRJMTBaQ0N6SXRCa1kxZjFxOHlBSFJBaHQz?=
 =?utf-8?B?c1RscEhjQkVhMmU2Z25UR2FyNVREVHpBVEJxWXlNblhuY1FtTEIvV25XclE0?=
 =?utf-8?B?aFZ2TXlVQXZOUTh0L2pvU0ppU0c2ZkZVUGJYUi9TOStvNzhwcWltb3JONlhP?=
 =?utf-8?B?c0U1UnJUY3E2TEtYMVVWMmI4cHBIZ2R1d24rTFJ0WmVrejh1WkRTNmZBc2dn?=
 =?utf-8?B?MlNCSFRWaTN0SFhrSUhLQ2xKN1M5SyttM0M1WUtnK1hzR0pmZElQVTh1YlpO?=
 =?utf-8?B?cUg3OHdrdFVsalpPb21oQnB3U3VxdldCY3Q4NS80V0hSYktSdTFwb084Z3VQ?=
 =?utf-8?B?aHVWVHVBZGJ5M1NXUUoxN2ZWckNrVE1QVndMZ00zSHdIUjJ2RWtvQzR2WkN1?=
 =?utf-8?B?ckRpSm10NmFEeDJFS05WWlRMVkEwTGVzdXNWTUVoTURnV1J3RnZDalF6NWht?=
 =?utf-8?B?Q0dWSXVmeTFBYnN1aStVSE5PUXplQnI3Nm9Qdk5hcHpkWmljamJWYWRDZ0NG?=
 =?utf-8?Q?8OiInlAEsrUSFg/I=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 329d213a-3f83-4d5c-fb31-08de793bb280
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 15:44:04.1164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9IcjmK0n1zIwIToVnq3LeN/qYFrf7gZ0tr2d/+C/lMWhkuRv4o9lzI6cVdBlvsXIIa93GYnraau0P6YdAZVP2sI7kAQtDZBUbkkqZHeeEco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6E320AF71
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772552659; x=1804088659;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QvfnA09Fzt2Sa5jzSgIA0A2KY17sww/kAWwOMnDiAxc=;
 b=FJRXGRXhHAqOdqyzWgUGVa57JNurc9iwPVkz2KwlY/CMTR4buvWFBukN
 a44AhXMv8ap1Rm3xUcfNJ2vCZld/LcMAycto8s7KpyvZb2v2ao3vOvihh
 xc1XdOx4rfOue7o15O1QXH4e1DjSV7hSKzWBYOrVpLTb1AuMfsguN0ldS
 3dbNddHkJylkvD0QPMom7K53IU+jApXlPS8lADaXW0IIsyRN0FLb8/Rot
 EnUPKIWNMPwC6wRaq8Lb/bJcQjWiIwRzfgYlVSGSRySDDhp+Kg7IAw8/b
 zRjlzD2s7M3FthNP/Kr5zmsrJ6qC1IBfs5L5lxR0zqwNlgGu2HSHiRxSB
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=FJRXGRXh
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3 1/5] libeth: pass Rx queue
 index to PP when creating a fill queue
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

From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 24 Feb 2026 19:53:11 +0100

> Dear Alexander,
> 
> 
> Thank you for your patch.
> 
> Am 24.02.26 um 18:46 schrieb Alexander Lobakin:
>> Since recently, page_pool_create() accepts optional stack index of
>> the Rx queue which the pool will be created for. It can then be
>> used on control path for stuff like memory providers.
>> Add the same field to libeth_fq and pass the index from all the
>> drivers using libeth for managing Rx to simplify implementing MP
>> support later.
>> idpf has one libeth_fq per buffer/fill queue and each Rx queue has
>> two fill queues, but since fill queues can never be shared, we can
>> store the corresponding Rx queue index there during the
>> initialization to pass it to libeth.
>>
>> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

[...]

>> diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h
>> index 5d991404845e..3b3d7acd13c9 100644
>> --- a/include/net/libeth/rx.h
>> +++ b/include/net/libeth/rx.h
>> @@ -71,6 +71,7 @@ enum libeth_fqe_type {
>>    * @xdp: flag indicating whether XDP is enabled
>>    * @buf_len: HW-writeable length per each buffer
>>    * @nid: ID of the closest NUMA node with memory
>> + * @idx: stack index of the corresponding Rx queue
>>    */
>>   struct libeth_fq {
>>       struct_group_tagged(libeth_fq_fp, fp,
>> @@ -88,6 +89,7 @@ struct libeth_fq {
>>         u32            buf_len;
>>       int            nid;
>> +    u32            idx;
> 
> The type above and here is different (u16 vs u32), despite the
> description being the same. Could you enlighten me why, and maybe add it
> to the commit message?

The idpf queue index can never exceed U16_MAX and a u16 field stacks
nicely with other fields there. libeth is more generic and I in general
prefer to use 4+ byte long fields, hence u32.
I don't think it's anyhow important.

> 
> 
> Kind regards,
> 
> Paul
Thanks,
Olek
