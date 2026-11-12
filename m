Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7423606A88A
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Nov 2026 10:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=H4EXBY1l;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nEbKEJ1b;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=TXJfhZWk
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A7DE48114B;
	Thu, 12 Nov 2026 10:22:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T5QdhoSsxoQt; Thu, 12 Nov 2026 10:22:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EA75E81181
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794478975;
	b=KGI25nTnW/Ttb8W/wprhFjWfVUt5CDMAOUoxukxRwBBjz4W46csrGD+s8VaR8Yqxc/By
	 HmJKjeWcpiouCpVdfOBhQkDaQ1k01sFBg2nnJbGUPhJm+VuoEeEJef17bD5U3a/TDQoro
	 GUqkW3DzJYf/NNzsyhzcsPzViTHeq3ilHTN6g7fv7HWmJSyF8EjAgfOSvdkRFRvnM5DFs
	 4bhS0zaN0aD2JPeVPPPOyxNwrfeVYagstFVXCdKMuRrZdobjfFKRvVhPm2PIGz5TZ36t/
	 BBEn5Sgyg3bencHnq6jkYRYXs9olyWWOMZiO/sfmBRWbgCOmfPXHijMW6vulKpdaEgg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794478975;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:References:
	 From:Content-Language:In-Reply-To:Content-Type:
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
	bh=rOtvO6rEIRBMiwrSUVckgxceTSMvSqj/YwnXzhSHiO4=;
	b=agOyNKABD4DhTSfz5rlLyT0FjFSWfSjQzxQBMA1HIThG8BoBhNoT3L+S7cyz/QWr/5mQ
	 7hQtJLjsja5KG6FXVhBFqlxbjnwMPVuEO82nrZmmOCaVewSiHdnv5gCGO7sspqfCcRhWY
	 Cr2YuxORz58Clc+Um8JlytaOBHGC9cEISjccSfC9N0M8TI/I2aK/wVN4qGRtTJsmK/E0O
	 jDQApLY2QM6TvlJzWITyGUhELraJDq05cq6mIb31RZEF9omYiPGQ/jsFtoGoCYySjLa9X
	 AnGOirF5VuIw/Bce8wXjNv7l3T4djGGJurLzAcN2hx9TUsHusyplxbquvnEiA6cG7fQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nEbKEJ1b;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=TXJfhZWk;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794478975;
	bh=rOtvO6rEIRBMiwrSUVckgxceTSMvSqj/YwnXzhSHiO4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H4EXBY1lmFbmk03R0y2klA9Pt7P6D6Oi4a/nZjmVsu9cehZN+b3ktBrkHJwYt11th
	 i7N0m6qVZ3a/nrPQyC0jP2RV+sP9Xcogh7Gu9sL79GIhnm8+bcJ5U1BaGME4NWoQTP
	 8hgxUqHHnED0R5isn8vEaZsnW3LI3ITi69sPSJSdhFPCuNBdt/SHnddezNX1JUZdNG
	 8PoNlOhc3B1UkHfpBQykhQ+ekqp5pxzcAZOW3nBNI6V/rZd8I711hXarldPYNC4ITU
	 hx8VCXYzJ0vA66Udo2Zma0GAV5sQeyemWI7SxmMI7rY1qOWrtJ+OCIEhw30ow6xkKQ
	 sxgO0lBMqck+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA75E81181;
	Thu, 12 Nov 2026 10:22:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 24D10335
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 10:22:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 21E5D81181
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 10:22:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m6hWPe8at-MI for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Nov 2026 10:22:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 021398114B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=nEbKEJ1b; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=TXJfhZWk
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 021398114B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 10:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794478973; x=1826014973;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HY5waR1Tyvdpl8pasIy7v1O7d3VcXV3LdCvNHdxy44g=;
 b=nEbKEJ1bLJuGcVGUwzwtd3SXM6ULV40MvyP32pwhtioFBtGfkTLRBKRc
 LSlMXdz93o/1qmqlGLadzzFET2id7oeaAOQcP8jOomKMtyDZ9UJjIKFEv
 RUPIR+pjL8GmUKBzcgJrTKYKljOquuk6imwUuEWhOZoL4SE+BUc6B+E2b
 5Y2gvznJh8F3qDz3Pgbkt0OWF/g63spnkzc75BC/N+2d742ldCrMFzaHY
 hs6oH5/FZNEB/Mw9NKBRxZVMCPlvIZYxP/+/KbCKM50hChNT/E9kWQwA8
 Hj45cvAozv/zbPhRd6fD95zb8SJyVNLuaCLrHdhBRfRTXAoXqR4waeel0 w==;
X-CSE-ConnectionGUID: 6JJkrGXJRsGrZTCG2GqB/A==
X-CSE-MsgGUID: OSzNxy+6Rtix9rlOJneiCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3179902"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3179902"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 02:22:52 -0800
X-CSE-ConnectionGUID: oCReWnkRQ+SUuki/d8pk3Q==
X-CSE-MsgGUID: yq3c2tD0QlmjKVJyWF915g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8966493"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 02:22:52 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 02:22:51 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 12 Nov 2026 02:22:51 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.25) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 02:22:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOtvO6rEIRBMiwrSUVckgxceTSMvSqj/YwnXzhSHiO4=;
 b=TXJfhZWkI4eXyp8AnKNxbC6ujk9lO3wu4i0pGon7koFSF6VwjJut1/IUns+0VY4azhoWM+PwQJTcrqrrS4WPoNUHr864cl+czpHXoR6Tb3Q9x4/StjpuV3byfU84N9BukKm07nHLMfUXRraXzVN4g6SScjwhk/MPUPlPzE+Cxbc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by LV2PR11MB6046.namprd11.prod.outlook.com (2603:10b6:408:17a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 10:22:47 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 10:22:47 +0000
Message-ID: <2432bda7-8867-44ff-bd86-1897995d3acb@intel.com>
Date: Thu, 12 Nov 2026 11:30:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] idpf: select AUXILIARY_BUS to fix link failure
To: <darren.worrall@shopify.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <intel-wired-lan@lists.osuosl.org>, Eric Dumazet <edumazet@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Madhu Chittim
 <madhu.chittim@intel.com>, Joshua Hay <joshua.a.hay@intel.com>
References: <20261111-idpf-auxiliary-bus-v1-1-e76b940fc929@shopify.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20261111-idpf-auxiliary-bus-v1-1-e76b940fc929@shopify.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0162.eurprd09.prod.outlook.com
 (2603:10a6:800:120::16) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|LV2PR11MB6046:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c8dd34a-ef90-4b06-c81c-08df40a6e5c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|22082099003|18002099003|6133799003|261009223027099003|56012099006|11063799006|5023799004|261028144727099003|261021121427099003|261102123227099003|261026140227099003|261026121527099003|261022105027099003|261021135927099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: mDqhs2uZwybD9yAQyLds5vz475pnc90LAa2NEJAKYj45jwaiqurMFXOixJ3bxp2qX9n2Il3xJpaQuxyikUm7P8uCL/PkYL8hujOd6GDIdta8rnT9/VxHltW7ac4eJgMWo2nbVjh1mSrjWFYIZ0zCrJXSaLyjZvJtrByq1I+YeQPvr4/MAg9b1Q49qsC+ZJA/1HtCZkZFxHYcgauSmm7b+XwbaW3/cKGP3/J+U7nRCr9VlBK1z7ssjnM/C2zIq3XbNaJuDftGD0gayRzRjCifIY7HECmxxrDyFWBgosxb7gjhB9IffPzQgO1dIeKNmeYSPcfaUX1VA2VtTp6scWkXKqQfdpoF75ZfS+r0BpW2v89sauIKYL2zOMViG0L5BC2h1/uYfkdoktX/6rmaAJqynYC8k7mAy5x+l6vJ/Nx9uYyK53h3QuZ6bvG0574SHRmBsDZyzN70oZo1n4td9w/gmgsgeedEJevf5EFY224cGeH/IyRONN/PBvdKYQcE6rtMjr8fPhhX8w8rkBIDtNOzF+UUARZ8HhTIUlL9aaJjMTTyotuYqaFe+fFnWPzV7wFBXGbXhxl3slGvIqbqRqwVLd5zbR46m7dgB5GrRHjb4hQEI5K6MFVhJRWVDimgGB8Al7fN91l2IBniMwvPXdSqDY5woG0Y4yrrkPleKJ2rFuI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(22082099003)(18002099003)(6133799003)(261009223027099003)(56012099006)(11063799006)(5023799004)(261028144727099003)(261021121427099003)(261102123227099003)(261026140227099003)(261026121527099003)(261022105027099003)(261021135927099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aThkZElzUWtrNWEvUmV6ZTVOWGNZbmJpQnN5Kzl0NkZxTGZRRUVlYlk5UzR2?=
 =?utf-8?B?ZHpDTUNSeFJzcXlldWE3VXQ0S1hFem5zNStnZ3dtSko2dlRqaUN0Rjh3ZTZk?=
 =?utf-8?B?cm5lTUw5WHY3RzYrSjMxTGV4cmlvRHJ3YnZGTTNBYkhRY2FwcDNsOFhJeDBz?=
 =?utf-8?B?bzkyVlJLN3pJYkJHOWk2dDBtRXpGY2RzdFEyNDRyYUZ6eVI1VDladmR1L2Q0?=
 =?utf-8?B?M0xYdnpGVXQwcDlDOUhuYkpxWTI3anBLR3RBLzN3c2tEWVpUenpCblMzMTBs?=
 =?utf-8?B?WFUzS0hyR2RhRUQ3bkR6bDZRMjlHbHA1YW5TcDRLa25YUkhWOEw2MXJKWmRB?=
 =?utf-8?B?Rk9KeUxhWVlhNmRFQ2tCMktjZkNIZjRNSzJBQlA5MUMwR3AyZGtxZDI4SWNz?=
 =?utf-8?B?QTlteTNqbjlZcTZlOFljN0dRMFhZTG5sVE1hMkNLcDJGVjFmZ0dlU3VqcXBL?=
 =?utf-8?B?cUdrWm50WGttOVpFcFFyaDlNVDBlOFBBeEdsaE91QXFmcmk4UlRHOE9mL2ow?=
 =?utf-8?B?ZDBQcXR5UTRoQnJiVjYvWTJDUzhTek1sazI5UTl5TEg3TFV5Z0pjY1d3YnZ2?=
 =?utf-8?B?ak9MVEdCTTBGOVFOVktTWkptMDZIVnE4cVRlTHlOcStZVHdQTDVqcno1QXNB?=
 =?utf-8?B?UHFVd0llcnBLSW9LR2VIeUlmTkF2RWpHQ3hrVUpFVTl0U1Y2cHdaY3llMTlN?=
 =?utf-8?B?dDNmd3R5VGlhcTkwaElrUWtMUFRWVEh0MEQyMGdNVW55UFM5ZCtlbnRKcFpC?=
 =?utf-8?B?YmJtRXhzMHA0MGZCWkhiMUNrYjJkRHJ5bUwyMlk2dDJ5c3pkL0VPVWFyd1JX?=
 =?utf-8?B?SEdLRXF6cnVWeDJHMVR5WTQ1OG80dXo0VFM3SVRaWEpLUXozVm5ZTTlEanhE?=
 =?utf-8?B?Q1dPZHdYa1B1ZkhHTnJUWGorbytDMlVzREU2MFBBWkJMUVMvWnZrdGYvako3?=
 =?utf-8?B?b1UwaCs1UXBROHRGbkZldkJad2R1ZlJIYWVGazdKQ05rRjFoendDcFBVVUN5?=
 =?utf-8?B?WDh4ejRNSzczQzc0cmVnVHg2N1d2eHVrU1oyLzRWdUZIWmRtQm1lU2NaaS96?=
 =?utf-8?B?Tm5LWFVFTnIvT2ZpMjdXdHRvclJ2RjZqSHlNL1BraWdHNEt5Y0JoM2xBcnRN?=
 =?utf-8?B?c1dYaGpKTjkwV21qeUxIeUpON1pha01acXhrRE5LckZXNXR2WGFDMHErdTJx?=
 =?utf-8?B?UDlEQStzMnRLdytDdVNsZlZXVjFwY0w1YVNEaEVqZ0MwdXBWUUJkOHhQTEhP?=
 =?utf-8?B?bkJzeEpvOHpkUU5IdHJBbE56TUMyTlZzUi9jM21WeWNINTNYSWlKa0hoVXlw?=
 =?utf-8?B?Smc5RWViQm9pR3dwM3FRWnNaM3l1OUc0LzI0RzRiWEVuY2tmS29nRVE2R0dB?=
 =?utf-8?B?TnBNNVV1b01MMVlIOVZVNWsxYmhXa0UreFFFRGpIc08zZjIzSEVVTXRTNGJZ?=
 =?utf-8?B?OGZpMmVROG9Xd29DbTl4MVJYQSsyenJkRmlVK3pCd2dkRE5nK21ONGpWNUx1?=
 =?utf-8?B?c2RyVDZoM1ZUVzkxKzB3MEF4Vm9GYllXMVRGcGFVQ0VyL1pqRVcybXBZT1Qz?=
 =?utf-8?B?Q0lITTYwaGFES0ViUnQ5eWFoLysxTGs2MjRselVwMnZqOVVNNU5HdzdXMSt2?=
 =?utf-8?B?aEZWNGY2T0NmOGg1aGVIb2habGV6eUoyVEtTUVZIOTQzS29wdWx2RWo3Uk9k?=
 =?utf-8?B?OWNIbkM4cnJ1UkVOY3VPUjBKaHFCY3FQUHBRaURHMXNiOG9YZE1vdlhWSTJO?=
 =?utf-8?B?UVUxb3ZHbkZsL0hyd1ZnQUw2QkZRejU3dDBUcW5QZnpEM2ZTejhCZ1pzWDlm?=
 =?utf-8?B?UnZEQzI1emgyeGY5TmFzczB2ZkxIUDJ3Nlo4Z1JLZkRxcTQ3dTl3SFN3Rksz?=
 =?utf-8?B?cXg3d1A5THlZc1Q3cjVrN2xKRGFGdXIwdlNkRVFtaDkydE41RTdEZEhGVnMz?=
 =?utf-8?B?RUhrVlM3Wlh5NHBrb0hIT0ViQktOS0N2RWRJZ2dvc1BWMmh2Z3hTbkYxemVT?=
 =?utf-8?B?RkhEai8yelpNczAzNHhyckRzbXA3UG1lVTUvSG9keldpdHVOZVM2NTRzVWhy?=
 =?utf-8?B?VjREOTJ5ak8yTFU0eDZVblBnVHZGajBUekNxWkFBNFNBTk1yYm1NY3BqVVY4?=
 =?utf-8?B?eVg2RWxTRzhGRGswYktNbmJYME9ERGFHZmtvUVJ0bVJ4blEvSTRjTVdHK0VJ?=
 =?utf-8?B?Mkd6SkxmaStOUC8xUUdHek1UajZGajR2c3RWU3FOV01PV2MyR2llZDNzNkx2?=
 =?utf-8?B?VXgxWjRCUmg3S2N2N0krS0VwV3g2d2VmSGdqVnh6REw3eHJlY1l0eUkzVXU0?=
 =?utf-8?B?eFRXc1NLRmw0eFpBaUd5bGdUQTZUUnFxaEFQVDdTK1l2YzVkeVFkbyt6Y0d1?=
 =?utf-8?Q?szzlenO5g95ArvR8=3D?=
X-Exchange-RoutingPolicyChecked: MzCaQv7KjloYJuTyp+FiUCx8+WaMqpVEaQCm3trr6W9Owt8tyhTUW/RxoqAYq+b3hO9yOYe0Ngq1zla0SeH1mgkXVel3tvcxwHRFlzcDdlzRcwt+M2iyi0YE3/XHrvFcfgHwJohhgIBZFsvBDqVfXFN5yzdBd8zsp+s6J3u8AT52RipBm/QyiUcTS4FpayIeKvgJqVOWJFCrU0siTDzdOEbtCeFz71E/ztsg5cI4b9475+R7Wyeb34+9M4BskTZSRnX/KJzecjfj74wtGlj7SeGXS+vDzwYSaFxcQSP0cKP9R6RtdhTr8oVC1iNpf5q4sqYWeyWTW8rxc3y6joHNbQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8dd34a-ef90-4b06-c81c-08df40a6e5c2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 10:22:47.5558 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0wCgLupvkvWbWU9v6Yziu5XFh5pP+1S1KlK5imE1wtSgpWo+2GghvJbhMa83PPMwzsUi0QWKiXFV5Wn2+NrSBnHc9mqwUBFdFMagmx3VeFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6046
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/26 8:31 PM, Darren Worrall via B4 Relay wrote:
> From: Darren Worrall <darren.worrall@shopify.com>
> 
> The build can currently fail with
> 
>      ld: vmlinux.o: in function `idpf_plug_vport_aux_dev':
>      drivers/net/ethernet/intel/idpf/idpf_idc.c:82: undefined reference to `auxiliary_device_init'
>      ld: drivers/net/ethernet/intel/idpf/idpf_idc.c:86: undefined reference to `__auxiliary_device_add'
>      ld: vmlinux.o: in function `idpf_plug_core_aux_dev':
>      drivers/net/ethernet/intel/idpf/idpf_idc.c:223: undefined reference to `auxiliary_device_init'
>      ld: drivers/net/ethernet/intel/idpf/idpf_idc.c:227: undefined reference to `__auxiliary_device_add'
> 
> if IDPF is enabled but no other driver pulls in AUXILIARY_BUS. We hit
> this building a minimal kernel for hosts with IDPF NICs. It can be
> reproduced on x86_64 from allnoconfig by enabling PCI, PCI_MSI, NET,
> NETDEVICES, ETHERNET, NET_VENDOR_INTEL and IDPF.
> 
> Select AUXILIARY_BUS in IDPF, as ICE and I40E already do. The same
> link failure was fixed for BNGE in commit d7065436e8a0 ("net: bnge: add
> AUXILIARY_BUS to Kconfig dependencies").
> 
> Build-tested with that configuration on net-queue (dev-queue,
> 34a70a40c954) and on mainline (067c5c24cef2): vmlinux fails to link
> without this patch and links with it. Boot-tested on bare metal (AMD
> EPYC) with a Google Cloud IDPF NIC, using a 6.18.60 kernel carrying the
> same change and IDPF built in: idpf probes the NIC and its link comes
> up.
> 
> Fixes: f4312e6bfa2a ("idpf: implement core RDMA auxiliary dev create, init, and destroy")
> Cc: stable@vger.kernel.org # 6.17+
> Signed-off-by: Darren Worrall <darren.worrall@shopify.com>

Thank you!
Acked-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>


> ---
> The link failure was diagnosed, this patch drafted and the tests above
> run with the help of an AI coding assistant. I reviewed the patch and
> the test results.
> ---
>   drivers/net/ethernet/intel/idpf/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/Kconfig b/drivers/net/ethernet/intel/idpf/Kconfig
> index 586df3a4af..6b59173e0d 100644
> --- a/drivers/net/ethernet/intel/idpf/Kconfig
> +++ b/drivers/net/ethernet/intel/idpf/Kconfig
> @@ -5,6 +5,7 @@ config IDPF
>   	tristate "Intel(R) Infrastructure Data Path Function Support"
>   	depends on PCI_MSI
>   	depends on PTP_1588_CLOCK_OPTIONAL
> +	select AUXILIARY_BUS
>   	select DIMLIB
>   	select LIBIE_CP
>   	select LIBETH_XDP
> 
> ---
> base-commit: 34a70a40c954fb8044ecd124840a2c38cd3aa4cc
> change-id: 20261111-idpf-auxiliary-bus-c0058e27cd9d
> 
> Best regards,
> --
> Darren Worrall <darren.worrall@shopify.com>
> 
> 

