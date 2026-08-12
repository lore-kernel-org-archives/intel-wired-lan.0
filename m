Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921F8C5B567
	for <intel-wired-lan@archiver.kernel.org>; Wed, 12 Aug 2026 04:21:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4190460896;
	Wed, 12 Aug 2026 04:21:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TbIT9M-eWlIp; Wed, 12 Aug 2026 04:21:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3CA9B60889
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786508490;
	bh=731Xdj/p/8IOHP+6K+PaX++rlfuY2LLznsELkY2vDwc=;
	h=Date:To:CC:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=82qpCfvnkd4on2xS/mmYu/YizHmxpX6jyxdjfu4856iV9KDY16zUEYqthGIIEeKVz
	 fBOs6sjY4p3BTivbbs4Sv6R4J5ryFycc0eRwiuQQkNuWja10koF4cO+vDc3rSLWw8F
	 lA9LbhqbdEGiOpRcOZEeFMvEHVFCmsAKG3SrGxO7aVMRbgllyi1yXCzMeM5oYMGmjy
	 cAJefk+rh/Hno6MQw/7AZDNkxgpyGzwr/LdHGzP4KFIQ+oeOsJtbocEsd4XsXRRkgg
	 7EDhPKEoKBjCpejVuNxMMISNL7TY+fPMmaC4ofC47+evxdiuP1eaHNqL1qukQOTEQG
	 rBSEKUC21awPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3CA9B60889;
	Wed, 12 Aug 2026 04:21:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 791581F46
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 04:21:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5EBBD81123
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 04:21:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g_8on-5z1O6c for <intel-wired-lan@lists.osuosl.org>;
 Wed, 12 Aug 2026 04:21:28 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2A94E81170
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2A94E81170
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2A94E81170
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 04:21:27 +0000 (UTC)
X-CSE-ConnectionGUID: g5Yn0scmTMm7l26hWvlsew==
X-CSE-MsgGUID: R8WSxOarTsinUREaBmouhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="86926551"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; d="scan'208";a="86926551"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 21:21:27 -0700
X-CSE-ConnectionGUID: g++4EllUQgGqKMrLnsvvNg==
X-CSE-MsgGUID: RaMEv/zCS3ui1o8joa0QFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; d="scan'208";a="301765174"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 21:21:27 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 21:21:26 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 21:21:26 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.17) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 21:21:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vC/tKVF9Woxaq4jMR0jHxL6oK9mJeEsxht7bDJg1qMHb6PhH1IzHxk3Ra2AwY6+W+ck0/NmGGnDJuD1Lzr43DH/fzJzc6CdByrlBJ5VZ+McCY5XooLc5cMHe+Chiz9R+5f9KeHGxT/lErtYgUiShwaFT0ygCcxY6DBqKNucztkwSzaE1qa10p4LV20DQNAseJK9EsO/kL27hg4IHHxVPCmAfC0ohBR0+GkVpVf2DGLf+cKGOid+eDFXsZcBI1+YzcsrFfOzmIsn/rsWCAvY/yfFesuIkc187V+htYRg1KgXsBJ0uVN8q7h+Tah6Z5uYjrYgN+8BqJL5nxLOgvGxgJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=731Xdj/p/8IOHP+6K+PaX++rlfuY2LLznsELkY2vDwc=;
 b=eciZ1HeejPyAwfaHo8wsuHXXxErRuYpYNh6yLAad4ITsMdO30uIaM/RJh3ZLGjVep+zlMO/bsCPaqnfbGdGf1DKVmVEExre6EieiIl0aMfcIR5qG0ToB7HiLU5RxGSsD3Z4SPtXrgi5wBG7kbuH1dZB2KDEVOWR1XdOt5AYiL7ukm9QN0+2Ow58l3MXwjscC37FqSD0xIBomcIE6HgjAKvsiw3W8i2w5VwXvP5HgEieXbSHTxOl0C4l4UGWCLBkUqKCahgeVKy3b/NUlEfTpUlFfYt53OZtAgS/xyjWg41/VR9YPORb9qFlSUi6V5pBP5HduUOf80tffpDTTawvADQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by CH3PR11MB7276.namprd11.prod.outlook.com (2603:10b6:610:14b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 04:21:19 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 04:21:19 +0000
Message-ID: <c282feb2-b9aa-40b9-828e-055586c4c2a8@intel.com>
Date: Wed, 12 Aug 2026 06:21:15 +0200
User-Agent: Mozilla Thunderbird
To: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>,
 <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>
References: <20260810075652.27915-1-tomasz.lichwala@linux.intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260810075652.27915-1-tomasz.lichwala@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0077.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::15) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|CH3PR11MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cea5eaf-ad3e-42e6-3049-08def8292895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: OlPMrBImYd4Z2iUEaraxFDT/lpgNXv3lu5cQQpHWbt943On0YcnUMEslLbM4AFxWt5SyLs1PC6kEqVAW2Bgca27GbelYuh36RSAbsqsIvLKK2/rbli9dX061c/MNpXYwI2+q+ph8vig8p61csoNRanJ52TRjNCa5JKRNlaf/Gu7knp8RyhfIJ5VK9FjYee4xsSS3qKvFtfbbmq/cy7gyMb43RZhSFVKx30COSUbzHyNuUu0Bcq4w9uV8XfCUBO0FFP5tU+un199lq+tSr0s9U8ZwxSYyygKJN6ZAmhzJiKZWmtPIQRWVUHIvlPerHVshqSHS9p4isBlMdO5pP5qbY10uxuZKo7CnKwj0q455KHQPnBNE59CkehoippsNIo0belWIjm0aE53V6YExO3J9mI+AfO/hjVVgDWwycQI+NwHuiVtNX7GDmq2oeZVHhLBchoE/xrxpqBPauuIlT5tM7Uy+hotl0EN4Wf7nsFn13VLgQoWYc8blM0e5Q+i7QOZ6i0akXC0M15TMgmIjoS6ObmDFEoXvL7rrRfbmELW/AOzpFfzGPFfHM+J3nhvU0tPLb38b4IqcP+uyMbiOJPvUsONWnTUWO2hmwKop+vrh0xaiZFNiHBFaqUs68RkzkFiwGBX26ef11yOAAxwmFvtAFvZaLqIHcnF5aVS56EMABpI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnJZbzNyM0h2SWJwTEFmRjdyeHdlVXkrelpTZXM4eDh6ek1qT3RzOUl0b09p?=
 =?utf-8?B?ZFJSL0E1SldhT1FtcEtnaXYvTnhvUjNYM3VMQ2d1VS82b1lWUGtQVDhTOFlL?=
 =?utf-8?B?TDM4dWpobTg1S0xJakVzRVpVbm91UWNRNTBXMXhUbEd0OWV6OTJsQUQ1Smpr?=
 =?utf-8?B?dXRpbFFFcXppZkdGYUp6VU5BQTErVURqVVg2K3VGc2dpMGYxdUNTejI1dHNp?=
 =?utf-8?B?Vis1c2YvVDFRYnd1WEhJZUt4MGM3QnFPcml3T215Y29tcEJYY2ZPK3ZlRGUy?=
 =?utf-8?B?Wk94N0V4TVEvWXN1OUdoV1lvTDZ2c1dvckwwTEhkWEhoNjhsZnVZOStHbnJy?=
 =?utf-8?B?WFVlOW01dlNUMmpCN2xPV08rNitORWZDNFBIRUtmMG40ZFYybXJhdXFEZGhI?=
 =?utf-8?B?dzZLT2dsUlVIVnM1TnBGMVdLSEY5d2lpV0dsdDFuemExZldNcVA0ZDcvakx6?=
 =?utf-8?B?OGlWSi9BTFk2ZGJwYzB3NjZYQWhUM2xkaCtSK1puWDJqTXFGeVVsNFd0UFVD?=
 =?utf-8?B?RS94bGFXUEZjS25kdkMvUExJTDQ2Yzl4cngzV2NBb0JoQWkrbklkbWlLQm1h?=
 =?utf-8?B?dWExQnpoRDI0U3V4OTVWeDRzSGZsYmc0UXVSR3F3aGpVVW9yMUxyYlM2Q05C?=
 =?utf-8?B?QUd1aXdSaXFpUzVlcDl3SXM0MWxCN2Y5dmlhQ0plNk5hQnFkMmZRQkREQUtl?=
 =?utf-8?B?ME1xVlVOZ0x3eDlLVEFtenVOeUhpd212cGNHeDVBTVp2a1FYQ241VldMOHh3?=
 =?utf-8?B?TXZHVHQ2YkJHNlROLzRCMXM5d3JPK1RPdHR3N2lYVE52bGJKRWlvbW9kVk15?=
 =?utf-8?B?YUV4VzArKzR1NGIyaTBpcTd5NnZLeENHN1BtSkhJeE1uejhwNGlpaldoTmtl?=
 =?utf-8?B?R3VqUThSaFNyb1NnSU83SjM4TGhXY0N3dTRWbitxZGcySFk0Y1F0bG9rdEFP?=
 =?utf-8?B?cUZlK1J4NlpVcmZLMi9pNk1abkpsVHlRRyswMmRxNk9RcHdvQ2V3Ry9lc0Y4?=
 =?utf-8?B?MmMvc0VmNjd4SklPTXN5N0IrMkFpMloyRitsRlJoV1ZnSGYxN1R2MXRMcDE0?=
 =?utf-8?B?L3VtYlFWN3d4WnlpZlNTdHJVZHo5MnBXWHArZlJtMU1BZjFmTWQ3UFBYWkps?=
 =?utf-8?B?T1NkMDlYRkZUV1B0dmJ0a2pYc2lVRUJPU25ZZnRjZkdpc1dSMGk4UXR1bWJm?=
 =?utf-8?B?czVxRFhxTkdaUVVvNElhVlhQcFU2ei9KVXJ0QnpTK2c4MTk5ZVVubkN5ZnE3?=
 =?utf-8?B?c0JhUWJFNHpGZmVQTnV3eWNjcVozU3Jzb0FIQUc1LzNzbi9DOVNhZ2xZVUpO?=
 =?utf-8?B?d0tRa1hOWWxxZnVHRmRXUGUxZXR6dmVUdnhLbEwxU0h6MUc5SVZUUlQ2ZDRl?=
 =?utf-8?B?TlV4YzNabGUyWFd0dTJ3RlY5RFBHN1R3L3ZrQW14eEZxL3BkNEZWTys1Q0Ji?=
 =?utf-8?B?L0FkS2ROaHI3cUJWeHZaK1ZWby9KN2hKTTRqaUdIaW9NQ1dZT3UrZkJUbUtP?=
 =?utf-8?B?TTdGRktPM2ZWSTcvNFpMdGczV1FNdXVvV2o3Z1A1dFdVZGdXWm5LbEFlOEtk?=
 =?utf-8?B?VTNmUUMvMUppcllIOTBLempOVElaNnd0d1l6OXJkT2lJeFlJbk1tM2g2WXY4?=
 =?utf-8?B?T096YUNCOGN2L3F6Y1k0Ly9LemQ4UUcvQ01KeXNYaXFUY2NDamFUSXdvcXZS?=
 =?utf-8?B?YTBuK3FGUTI5Q1JtVEc1Zm5OVDZBZnVMRnYwWGdJQXBMejdPMWU0bC8xR1BT?=
 =?utf-8?B?RGp6ZXBZSjRtMnZodFRIYVBQbDdTa2hMVXl2T2pNT1RCMG94MVlqSStKWXZB?=
 =?utf-8?B?bUJMVlJsVzNscnBJeUU3d2hUV1ZTN3REU3Nnd2Z2TFA1TnNzdlN0Wno3WXJ0?=
 =?utf-8?B?b09tT3VMUmY2RXRiZXhxTUhZMFU4OEo1Nk9LeHlwWXBnTUpSR0ZtMmx1Y0Jq?=
 =?utf-8?B?eXhwS1RRd2tiYmUzdVRUUDFGZU5vVFdMcXZ2VmVoMDMyeXJXdTgyQmE2cjNY?=
 =?utf-8?B?dW54RTN1TExLaUlrLzlPV0FXYzkvWDR4OG5nTW1RYTU3eFNJdDE5cjM0akFq?=
 =?utf-8?B?WU93ZzExUjRBOG00SWdXNkZ6YkRTdG45dzN2ZTl2S0tFUTYxRkt2Y0pQNnVS?=
 =?utf-8?B?cUZhNzZrQkdDYjBLanZaMXk1WFpVazBWMGNJaEhMY05nRUhXL0VISHdLM2hO?=
 =?utf-8?B?UlIyUnZ5SXdGcmhxYXdzS2NPVFN0MzE4K2lCbjZnSGNyU0R4UHJpaDhkRHl2?=
 =?utf-8?B?SGpodE91SyszWGZ4T0daM1ZyZEwrekZGSU0xR0xlaW1xQkdOYnYrczJaVXBj?=
 =?utf-8?B?d0Nsa0dGN1NqbGxtNDRmVlUvNHhWLzhaMWdFQ1hOYkVpYVFLZzRFc21KRjVu?=
 =?utf-8?Q?2AArnUc3aUA64izU=3D?=
X-Exchange-RoutingPolicyChecked: ewdKwsYuhUYJejAvqpIUfXTr3jhYzBM2WYKJN9MbPQOzdYsbGmTBpP3P+nPz5CH4WeibxYnecn9xvWAH1Mwu/guHWzmG6A/dlvREs2SKOwj01wE2UKT9A/M09oG8+9wAK8WVoxj84r8Hjte/DV0JweVphaRthcxWL+DYW5/RzhpM49IjjkOLuxzp18oN7PPiQG0TGZaIaRxQY2XgxWW5OvJJSh09ZDBnxrQuzTfuIpNsqrR/3/WAjSeO1O1o1JfCBBtWm6DLiUppBIBxL3VIPYXEHBahmD1vQ0Be7Oh1aL6wR7RCQ9HZbayqCYFe8mAAf8IKyfwX79g6U1/fFi4j0A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cea5eaf-ad3e-42e6-3049-08def8292895
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 04:21:19.3760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RpcKd1co5GjnK6uUNzMiMjEzRz7qptJFmyiBrCoOuJH0Im9PAwk72Tf+V/p/3dfoVv+8MO34jDbxtJNZzKa+Dsf4lC0NSGmDbJvCXcDDksY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7276
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786508488; x=1818044488;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=K/ZkKfoM4e1n+CNYLYIiRiycPxI2UENnVIThpf4kkKQ=;
 b=R3RRhhSQ0Oq8WFb8Yc/r2YKrex8m6IUDxMZhl5aSpOyt3/g2BauddwZQ
 35Q4hGfhEbREtlnFrqTQFt1AvZcEUBBAqmq/wAnmaiqEew5LY2Me0klkr
 6+57ZrISzhfOtcQIXszifPQJs7pdotbR/3VfX6Nkexrg4dBdRaJL88k2h
 fBu4Pw3Og69W02+oefzpniNk31THWXK3t1f7rLIVm8It64eMfaqo/FEKw
 COss3Yn+0TSSPhh7zAbpX3YxHqdghTKf/ySAmN6o7uaDKvwQc83HPqxBS
 +SOeg54xUZ2Hy2YhhJGj9GuvZMa4FCEwStB5Gsg2/Mw0IfwBv2zatZT1G
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=R3RRhhSQ
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [iwl-next] ixgbe: implement Total Port
 Shutdown for E610
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

On 8/10/26 09:56, Tomasz Lichwala wrote:
> Implement Total Port Shutdown (TPS) for E610. When TPS is provisioned
> in the NVM (by the platform firmware), the port's PHY is powered down
> whenever the interface is administratively down.
> 
> When the PORT_DIS bit is set in the Link Default Override TLV in
> the NVM PFA area, enable Total Port Shutdown (TPS). This forces the
> link-down-on-close private flag and prevents the user from changing
> it via ethtool, ensuring the PHY is powered down when the interface
> is brought down as provisioned in the NVM.
> 
> The Link Default Override TLV (0x134) is read from the NVM PFA during
> driver init. Each port has its own 10-word configuration block within
> the TLV. If the PORT_DIS bit is set in the port's link_options field,
> the driver sets both TOTAL_PORT_SHUTDOWN_ENA and LINK_DOWN_ON_CLOSE
> flags.
> 
> Signed-off-by: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  1 +
>   drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 38 +++++++++++++++++++
>   drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |  2 +
>   .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 13 +++++++
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 14 ++++++-
>   .../ethernet/intel/ixgbe/ixgbe_type_e610.h    | 13 +++++++
>   6 files changed, 80 insertions(+), 1 deletion(-)

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

---
Sashiko failed to apply, likely because it assumes base as
"net-next/main" instead of "tony/dev-queue", and the former has no yet
a dependency from Jedrzej.

I'm sure you have checked it against our local Sashiko and it was fine,
although the model used was different.
