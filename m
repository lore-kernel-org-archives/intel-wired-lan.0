Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76636606A31E
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Nov 2026 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=9C8QozAM;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ai+DkOLw;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Y9egLyrF
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 50C23808D8;
	Wed, 25 Nov 2026 11:28:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VWC5s-0kzGJo; Wed, 25 Nov 2026 11:28:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 976AC80935
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795606116;
	b=RxoTEP2za/y1txXnOt5Ct4GNuv+uVMy/dNv/QirIpuSAN5F6UYiiA16vqqSgDCRWYuyP
	 mGkF9ooaeqoQKng1eAnDrhQA5vaCdsuGBQfPpl98ugvqZiA+ze3XYdzipll0k1uSyX6Tj
	 AVyyfTSFy1WN6JlmhOnWXV7dcLrJZKyyzEWa/hW0Jo24B8Lmt5wU9fMzJ4lBQw9RBRubJ
	 /pKWAV0+MdAtyF5JWREOf08IkW+wHlPki5W/zCUWadz+jrpU9ovBFiTD2YLJWhKF7Swkx
	 u0o5XmywmF5OiocIklg38ml+l+h/lxm/8CDYyaThDMaEaDsSWvLGviqGSz8sJ7mzYkw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795606116;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:References:
	 From:Content-Language:CC:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vo6AuV2qSGanSMsVUOX1JNNn1tB1Xv+yJ8lxBwC9Pn8=;
	b=JPe2dj2alfUcL4KeCy+QCs9ZBOEkWgWSUdVInHcqQkCTOv1NN8os/ULc8WyyN/SHo4VK
	 Hfb17IrCe5MnPHGuj3xuBHQLEYY2tRCHAZ4qDiE16s3J40pVRKN4KOL1kDJxor5szKCue
	 QYID1XsfGHEYyy5V2df22aR0lIXYCzp+3s9d+WHfpRkz89Gv3e8eLleWNGZrT1dZwLjBf
	 F5TFe54E9ejJi7WQV9PCdc7gQ++CxbxsCwtlJ7BPE9XcB1FVcT8yAHuYVnAHgjo33EYbi
	 KUA3lYbyCG+w06CA8pEBcRHZpZ3atU4Ch+z6KD/UeLJKRZ4evLfLadyieOfjU91x/Nw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795606116;
	bh=vo6AuV2qSGanSMsVUOX1JNNn1tB1Xv+yJ8lxBwC9Pn8=;
	h=Date:Subject:To:References:From:CC:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=9C8QozAMe1sceWuEhu6QDm69zPAMqumLXGENrotKPtLflP6Cb93nEXOvInGXchpqZ
	 Br2f87tgD+X+NGNp6gTc5wPl/QruaJ6YgPKzOeYI9bGE4X4i7X021iiWPE8RWHxdpD
	 WSe1uxYAHOJ3aCsOjuPVHrAUCQ7q1mtyvVhCvFW3H16tQMSaC6hMOTpH5q+qBwB5Oe
	 OlCxBIj3GyXFRQXHdsK4cI+0D0YxVcK1jGZiKRQs/EEfrSAxSTeHLUYchqTkhvUQv4
	 tT2UPyE7So/50fwh7RshxRjbw4VXYvpWMULrbsbtzdEXngQt9hc7XLUkJ5Dk9IygEO
	 m2UxO3mDhoBrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 976AC80935;
	Wed, 25 Nov 2026 11:28:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 46B8532D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 11:28:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2CCD1401FE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 11:28:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NczgFa5xvx3Z for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Nov 2026 11:28:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6F3E5401E7
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=aleksander.lobakin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ai+DkOLw; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=Y9egLyrF
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6F3E5401E7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 11:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795606115; x=1827142115;
 h=message-id:date:subject:to:references:from:cc:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=M2KDIDx7qMJ7uZIggtLemB6YgTVAcQr0eXds3RUq+N0=;
 b=ai+DkOLwqqW9Kh0D5PApp0ycjo+1Qkg/1+34JWLPHP0hVTzcvHSYS7ZJ
 1CdA5DtfjYKdQofFUKkpp0Mzvz7laKzF0Af/JaYs4/T66M8hSpO1L27bQ
 I4xdR9o/jwA7Zt5r2mIMnaVXwC1DI5ToKea1A7QNeqUWB0E3+N4yBc2B0
 ezoWX4XeTBfwtiq5hczXDRy/Y3f/xhynuwu6hqutDufit8GGw6+CsXxal
 CWA8GNK6NgrrdMbVEsDez2E8uk5DyMHUI2gNpRjlaL/hUc1YoiOLrv35a
 3wPx3qFutib8JrsVSQeP12Wt1GS/0IyEddENEuT+3Im1VRhRC7x1fdBxG g==;
X-CSE-ConnectionGUID: 5hVOkEj1RaKP1X3+lCOIRQ==
X-CSE-MsgGUID: glBHWOwBTDS1GN+EwI64hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4393114"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4393114"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 03:28:34 -0800
X-CSE-ConnectionGUID: +LKDgUq+SsqMN+sFC24eUw==
X-CSE-MsgGUID: VD/rzLclRiyKGEaKAas2Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; d="scan'208";a="12436576"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 03:28:33 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 03:28:32 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 03:28:32 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.1) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 03:28:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vo6AuV2qSGanSMsVUOX1JNNn1tB1Xv+yJ8lxBwC9Pn8=;
 b=Y9egLyrF0gDpSLe1SaTL3HBfBuSB/+hR04zHBrxoQRhGRb0QpMnRHLIUNsEsoGAUBrA93VOkZuAXcQ8wGEzbcsc5czPvLRWuZM4qRIMyh/YZ61mQ43WlAJgaamhI982SSEWPk1gqG5r2p71wTURdmEjZ0Q4QofTZkSt0zaZ/kxw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 11:28:28 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 11:28:28 +0000
Message-ID: <a6c9ce05-42c4-49fc-89aa-ad154c946c68@intel.com>
Date: Wed, 25 Nov 2026 12:26:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v3 3/3] idpf: add flow-based XDP fallback for FWs
 without Tx FIFO support
To: <sashiko-reviews@lists.linux.dev>
References: <20261119140938.1363722-1-aleksander.lobakin@intel.com>
 <20261119140938.1363722-4-aleksander.lobakin@intel.com>
 <sashiko-outbox-223336@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
CC: <intel-wired-lan@lists.osuosl.org>
In-Reply-To: <sashiko-outbox-223336@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0121.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::11) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM4PR11MB5262:EE_
X-MS-Office365-Filtering-Correlation-Id: 17fe2390-72f3-4be6-9e75-08df4ae739fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|4143699003|56012099006|11063799006|261022075727099003|261022105027099003|261026140227099003|261028144727099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: FGRDEhGf27wowm729+vl1dZuqHjgmUugcPOEnmUdKfX41wknL/IOJxgjZZauDI16B45y2fHAYwmmyO/5//K4x8S09DOUSeyTgnIxuxrEdXO2MlDeUPJZN821VqOsGis450/pMkG6O50oG0y3C1/Dj5pUc52EgPV8iDT9DuEjSUSgbtjfHGOJpsaC4fR47xO8LbW+b021Cwy3ZpRW/kmd2ob28TKZVJtuoZRNIEVAn/9rddGZJl/R2gMJhNNa0XnXBml8qh3ZHN5tS6iP6PWM4mlCytW3KHtuMxhAXFU8a1Rnkrcd1Q94dk8Q82xrTLyo9T0gZHJrdyT0wG9V9tHwyd6VL3cKA8Tqi1JDzjfSxMkQavk1aBri+ai/QFNx2IKjQFp/2poiuTKF+Tre8EQxglr4Uqhr3sZOSHOrF81tGRjQi1lrhswoVwmoD4oY8WfQW+EmltfQNMblBbW5e/AtQTe/fScKgu7gKMn65CAXZImEAkqdYmL7DLG5V2lVkoSTH/p/bxIAaZrkmxuCCZKMrysIoXvKY1pbWh0Qf4h4tO/uePKHJQVkv5zUBoAr/d/7u1gIplZTpSqPpYdMCDlBeBIFALI2HejE5VtV+I3XASzPeaTWj2UQebSgZe7VXoF39snEfc0DRQnShL64xATky9OXST2ENUMUGASphqsZeug=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8718.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(4143699003)(56012099006)(11063799006)(261022075727099003)(261022105027099003)(261026140227099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVZnK0xsZm5yNHg0blprUVM2VjVvR0ROaVF6NGllejQwUkc3NHBIZWtmQXNG?=
 =?utf-8?B?L28xZDVBenU2RnFhR3VDb0JNZk5vblExUDA2QnVtbFVMcjhHNTQvOFFmdUJw?=
 =?utf-8?B?aDU1d082dC9rcVlxd205elIvNmxnZGdnb2NhanVwV1JrQ2MzMHM2WnUvZWg1?=
 =?utf-8?B?R3lpM2NvVm1nOXByTzc0Y3JmMTZuS0toQXZtQW84dHhMdEhzYzR1NEJFTnFO?=
 =?utf-8?B?ZWdoUjc2bk1rTFpoM1grR2VEZ0JhbGV2WW92bnR6Z1psNkF0R3JtZGRTS1RM?=
 =?utf-8?B?bzN3aG55UmZUdTdkSVF6dGNid2gxbXpVaW9qNkdvK05abmc1d0ozRGV6REQ2?=
 =?utf-8?B?bExrK2d5Q3NGN0RUeC8xenRIUEVzMmM2NUtGTmxVbWJUSFBuTjZQS2diakIz?=
 =?utf-8?B?ZnN5cUhSYXMyZGtySWVCMytTbTZxMStETTk5NHNYUUhBSVR3SFg3OURDVE1q?=
 =?utf-8?B?dlpPN3BqMkpKbzhVSm05UFdqSkxSaEhQYjNERFhMWXJXMXFORy95ME9VT3V0?=
 =?utf-8?B?cXNhSmtVU1h1MlNRZGtUdzc3d0lBWmdRTTNGY1pVdCs2cGp1L3FIbEtGYTN2?=
 =?utf-8?B?K1JKRllIK3k3Q09jU3lMd3lyK1hDYXN0RkFuS0tVSHd6NHdBV2lkZWZ0TlN3?=
 =?utf-8?B?eHNFZ1ZrWTZ0SThrS3l6YzZPUzJiRFlGeCtKWGFmU0tuZWMrNGlPV0MvNk5z?=
 =?utf-8?B?ZE4xM3J6ZDIzZTc3ZFhFY09IWW8wRFpiVEVKMW0wZWUvbHEyTnFVMDBYVXc5?=
 =?utf-8?B?TFR4R01SWVBMK0JrQkpIc0xzeTlPcjRuRE5pcU9nRXhST3A2aHpEYWVXQWcw?=
 =?utf-8?B?Y0x0WjlyNVRWRE5SV2xJaU9TTGJCVkJxTnBwMjJRS0VxOW03U3Y5M3dQelhl?=
 =?utf-8?B?cUdYck1tRlJTazZxV1pHNUJNMnpoZHBqSEJCdHJlSGhpK2pYMUVYbXdBYWRE?=
 =?utf-8?B?TjZpRllFbTN0cmZPYWt5a2lOSzBaVjRDa0VSZ05qQTNLSWJlS0w4Qzg2aTJm?=
 =?utf-8?B?ZFhtcnZieTFDSEVvdFkxLzIzYWp1bXl1M3J0MDhUdUlvck5kYmovbVF3YmhU?=
 =?utf-8?B?YTVTRDBQenlaUm5rbE9xVTd3aG4ydWhxK2lxeVI2UFh2cCt6QnlCcHgwOWta?=
 =?utf-8?B?UTlWRVB3VkF5ZFNHMGd1bGxnZUtQOGZob0hYTm9uMkxqMHdUYkpUTUs2RFBV?=
 =?utf-8?B?V0ZaOHkyN1dGMG50N2xpanU2R0VXaks4a05Mdm5selZFbm1qSlpMU05NWUgr?=
 =?utf-8?B?TmtWbE1rY3dMcnJuSThsdEl4ZTMyUmxFWllON2pGS3RueTNtR01MOW13T2VW?=
 =?utf-8?B?RW9BMzcyRnZqZC8rQ2Z1TGY2SGlNa25raFpwbU9ndHNNLzVSdVZBakdXdHlZ?=
 =?utf-8?B?TURzN0Jra1Nhdk1OUGcwVnRmQkUxeXZONm1SeVVkNmpvVnVwS0ZUMlhPVFVC?=
 =?utf-8?B?d3U1c2dtdW5vU0kxR1UvNlJudHNRbVlkV0pvQmZBV2lLaUM5ZFUzZFllM2Z5?=
 =?utf-8?B?UmN0c1lXaHNMSHV0VFp6UWhTUytFeHQyMDR0cUZjQ014U2FUeEpQSWwrUDcz?=
 =?utf-8?B?anNFTUlHQjA0MUhiZDVSOGpzSmlDY2Z1MWJ5WjNTQ3RGNGV6anNDYU9ySVh2?=
 =?utf-8?B?WXF5dC90Wkw0NTR1RFVTOU9mMXpMVTdEY1NOU0pzYVcxdEh5bGJWVEIzOVNJ?=
 =?utf-8?B?bmtSWHJOMDR3SVBkR2tHQmM2VzVHRkdtK0lGU0RYOEFEVHZucmhjTWF4WDMz?=
 =?utf-8?B?Y0ZDYVZnRk5uYW9abkJMSGtLZmJtYXBubWR5RERnSXFRZVRuVUtobHFZNEJz?=
 =?utf-8?B?bHhTbk40L0NOeHFpejhNZ0pyOHo3aFYxWnpJb0hrQnJMbldCWHdUamFmbk5K?=
 =?utf-8?B?QU1Tc21PYU95dGdKdjYyTk56dWVCUzRkbWVyQTdQYkJUTzFXZnIvT3Bsdm5K?=
 =?utf-8?B?UFluakUyY3BpcGdQZE8vaTZwMzh6QUVCL3NrekpBb1ZiSEtUWTIybkRIZklS?=
 =?utf-8?B?eVRIVTdLWThTa0doaFRveXU1KzN1aUlvWHQxeUJCcHo5N0kybWhpYTE0ckw0?=
 =?utf-8?B?Y01qbXkrSyt3SFNJMUJ3WmNnN3FlV3VlcHB4QnhoMFM2bStFeXhJZm9zM2tu?=
 =?utf-8?B?aE9ZRzlLTlZ2aXRkeG54NEpaY3pSTmp3U1pSSW02MGVsSG05UGxOa1M2OUd4?=
 =?utf-8?B?TjV3Y2dxQXU5Z25ZVndpRnl4ZngweTFYa1FiSllkRFVocUZEdGVwTmdjdko4?=
 =?utf-8?B?clVzM1Vsajg5TDAyOXZRWFR1YzhEbnVQVWhFNW83aGtENXQ4UHUrdDZaV2lv?=
 =?utf-8?B?eEpWMCtkQzdQbGhWemlVdEtoZEduQjgrOXVZVUQ5dTdhdjBEWkJXSnVhWDdj?=
 =?utf-8?Q?QB3TViGGShVSknfo=3D?=
X-Exchange-RoutingPolicyChecked: YQnfGLVBIp4L0lVBuWOFiwSI+5LFur/4c9sDKonxiwtLr/GqxL91lCeCIUSQ7j87Z0vgVYz/ynvBH+2DkEcGjHAII98DmEMwNp0JxlRHcBf9Hfdd+tnpoDNT4KjvsN+i7uTsoXcKHtXlDGJfn3aKU+NLbeLFULhmauO6LDJCa104nRkzkeHKd/yfGSIYzW0e1ktZvcCGQcIDu6/BKfeWW4vp6h+w/p8u5BGcy/X40s7OqsROGKwT4rV6kmQMPhg5YmkJQKY6BIKyBI0nGGv6wkQKrg4BouywYV4GhcnEBZaVd5bzAlLDthmebc0HPorSB9ux5ZBsifY1cXHvwKNj3Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 17fe2390-72f3-4be6-9e75-08df4ae739fd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 11:28:28.2806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxBXVzim7ieszCeB7yvcWd03JbYvUhqGogeGBs/Fc2Eq/OByKIMU1YORslk57lRWEj68ZszuvKE4q2pjbG+ny4tNV30ncX+QUF/Xa0dCiLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5262
X-OriginatorOrg: intel.com
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_NONE,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sashiko-Bot <sashiko-bot@kernel.org>
Date: Thu, 19 Nov 2026 15:02:28 +0000

> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [High] idpf: unchecked cpu_to_mem() for i >= nr_cpu_ids in
>   idpf_xdpsqs_get()
> - [Medium] idpf: premature CQE poll exit on out-of-order CQEs in
>   idpf_xdpsq_poll_fb()
> --
> 
> commit 6119bbbc742528036710b0619a594398135c70b2
> Author: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> idpf: add flow-based XDP fallback for FWs without Tx FIFO support
> 
> This commit introduces a flow-based Tx scheduling fallback for XDP and
> AF_XDP on firmware that lacks queue-based (FIFO) Tx scheduling support,
> using a per-queue bitmap to serialize out-of-order per-packet completion
> tags into contiguous descriptor ranges.
> 
>> diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
>> index 48320ea004dfb..0b4ead7fbcaf6 100644
>> --- a/drivers/net/ethernet/intel/idpf/xdp.c
>> +++ b/drivers/net/ethernet/intel/idpf/xdp.c
> 
> [ ... ]
> 
>> @@ -169,13 +173,42 @@ int idpf_xdpsqs_get(const struct idpf_vport *vport)
>>  			for (int j = i - 1; j >= 0; j--)
>>  				kfree(timers[j]);
>>  
>> -			return -ENOMEM;
>> +			goto err_timers;
>>  		}
>>  	}
>>  
>>  	dev = vport->netdev;
>>  	sqs = vport->dflt_qv_rsrc.xdp_txq_offset;
>>  
>> +	fb = !idpf_is_cap_ena(vport->adapter, IDPF_OTHER_CAPS,
>> +			      VIRTCHNL2_CAP_SPLITQ_QSCHED);
>> +	if (!fb)
>> +		goto setup;
>> +
>> +	masks = kvzalloc_objs(*masks, vport->num_xdp_txq);
>> +	if (!masks)
>> +		goto err_masks;
>> +
>> +	for (u32 i = 0; i < vport->num_xdp_txq; i++) {
>> +		masks[i] = bitmap_zalloc_node(vport->txqs[sqs + i]->desc_count,
>> +					      GFP_KERNEL, cpu_to_mem(i));
> 
> [Severity: High]
> Can cpu_to_mem(i) index past nr_cpu_ids when vport->num_xdp_txq exceeds
> the number of CPUs?

Oops, correct. I mean it's possible in theory since usually the maximum
number of RQs is usually pretty low (like 16), but it's possible.

I'll fix this in v4.

[...]
> [Severity: Medium]
> Can idpf_xdpsq_poll_fb() return 0 after consuming out-of-order CQEs if
> the descriptor at xdpsq->next_to_clean has not completed yet?

That's the point that we linearize completions and report only
contiguous chunks starting from next_to_clean.

Thanks,
Olek
