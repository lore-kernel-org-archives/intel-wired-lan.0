Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011BC606A31C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Nov 2026 00:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=OrdnFhaD;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eTwHjcA3;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=ORmQo42d
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC2D860831;
	Tue, 17 Nov 2026 00:40:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 07axq3Ke0ExV; Tue, 17 Nov 2026 00:40:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DF88C6081F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794876005;
	b=Zt3FRfl4tfmWyff8uojchmT6VF6WdoGYuqNYI2BzY6/RWenTD5j9Yapiq3zrq82OsuQG
	 DEesqsdR7/dyal5XIu67mU80JXZxbHhiOmGt6gYWYilNx7uHD439Wqvb5KFTCynyZnX4q
	 g/Vg6NGyf6Ovlxr36oRHUoL01gET9ny26q5kNgNpTskuXoan9pBYHCypK8vEwrhfCB3G3
	 6SZKEYKN1C8thae8BUpfvUuiPLmpQ/AWZ541aZeDq9eAn57usgJr4OGWjq2Tt++WGmWfF
	 UQKHpxFYan/WRDqyFxiO82Cie8VlFFZBV50EpIzuHubqWkGUToUDN2VnEHPspOtH5yg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794876005;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:References:
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
	bh=i7juHAK3cvEQod054ao1+2nUnocxn/TIB4wX+zW0ENo=;
	b=q25q2F1LqbjfPYzZbF/MhIjS4Do05ZYVKiNVcNVB5MAUKdn76Zblbp7p1MK6ayn4X/q1
	 nXDV0qqetzRzDNyI/ZXCJQIR5qiYZcLXw/PjsrGRJS/OlzMUgpOyRDNdxR9dt6awU8xMA
	 lRvbnntBezbeKILCaaDWMicu9KuQ97U9v6bLRB7LOgC5TeBLXPkXsHNjG0+FtlkVghBx2
	 3IV6R50/6l9nigT1uArgtwWXOP7v1czlILoC6lrBpdIzUQmeZv+17CJswFjE640ax3koq
	 YaAZTVQ+bXClEnAWXZNjU+0/IMVaXW40mlB2Hj3D4NNtoIX8+4cGebbriFlsSitbL+A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794876004;
	bh=i7juHAK3cvEQod054ao1+2nUnocxn/TIB4wX+zW0ENo=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OrdnFhaDguLmKoHVK2KTASGvszrCdy+DKm7hj4XIvvulfw/bWgstDdVUymKxfYsnG
	 vG0aq/JUnl1isvxP9fpejzkP640EH+FQBVNkKDsfHFvJqJ0J5wB5vwXRhCvF2qJS7T
	 kd4bpOSVmr10LDnbehMBl/rU9+d1PkDoHniCvhwTwzXpksPw+UH77TDdvEDISO6XBV
	 mvVTgvQLv5rCmS4vtBNXcDZO6sdzISBNTgSuo+PA2yq5l0PHEKzp312BRGb0f8jGib
	 JiyxIIVm1Hvc5Urwi/2g5z+112EB7CKmMNslgqVm4yzkKxMIVdrQl1bOI+V6umE/jL
	 cUMkLxM/xHO6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF88C6081F;
	Tue, 17 Nov 2026 00:40:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E47A149B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 00:40:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CFF6540737
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 00:40:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ev7L2K0VKLp7 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Nov 2026 00:40:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6E0C540723
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=eTwHjcA3; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=ORmQo42d
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6E0C540723
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 00:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794876003; x=1826412003;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=qNC4mO22QBA4grWeBTt7qLfzuEvdaTi/Jo0nF6H/gF4=;
 b=eTwHjcA3Fl7QJpQK5llRPg0ZoRbqBvvt0RULOGbc311j3D8Th6zX/wo0
 TQwx6fm7vBf4vdKQQuyvCxHjCw7jWbptVKxjz9QxL+OGFX1kJFSBLoPcw
 bZHUWnC+wSBbgeTu3+naHkzvPLK5Ul7fchdtiNpCsDMN+00HIvkEce+oV
 0+Rf/Wo1IxH30xESyNQkm6h7mrOk6sSswTd2UOHOn9S0KlVO/Kcmj2GlX
 YVGu7vWdAcYQvfiXdURdrpnwuP5XPsXI3YLqQs4/WxZwJ8AtPLtQ4Y1oN
 g5EPDjHVQecBtR2bSIWkIJWi6EcCCCrJK2yj2FFs+k9TKy97pFP8sGnko Q==;
X-CSE-ConnectionGUID: t4KEavk9R064a6c+D/gRzA==
X-CSE-MsgGUID: H9025o3ZTJiJ2evA4xJmcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3533108"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3533108"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 16:40:01 -0800
X-CSE-ConnectionGUID: hdl5dybeRkCw+/oO+B1NMw==
X-CSE-MsgGUID: SRu96St8SUm+kr4+2YFutw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; d="scan'208";a="10016210"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 16:40:01 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 16:40:00 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 16 Nov 2026 16:40:00 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.67) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 16:40:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7juHAK3cvEQod054ao1+2nUnocxn/TIB4wX+zW0ENo=;
 b=ORmQo42daYsoVvBU2/SktYkQQSHhQE6fxLEROzBDUj+PczT9ks8sU4DiNQujePW6OTj0Q2fYOOUCh+vDIX2XYyWnXyKygbhQszxYMxOdcYrFrNjhqbZ8WW15Ms+xxbQ6rELQOd8y0RSzgsk3XZShEiFsyQ9uWPWSfs6Pk4KCDJs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8451.namprd11.prod.outlook.com (2603:10b6:a03:56e::20)
 by DM3PPF99D0888FA.namprd11.prod.outlook.com (2603:10b6:f:fc00::f3d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 00:39:58 +0000
Received: from SJ2PR11MB8451.namprd11.prod.outlook.com
 ([fe80::7d5f:b2ba:92d4:5f3c]) by SJ2PR11MB8451.namprd11.prod.outlook.com
 ([fe80::7d5f:b2ba:92d4:5f3c%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 00:39:58 +0000
Message-ID: <d7ca984f-e9ac-4299-88d9-5c9c48de1db6@intel.com>
Date: Mon, 16 Nov 2026 16:39:57 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 4/4] ice: use struct timecounter for E825 and
 E830
To: <sashiko-reviews@lists.linux.dev>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>
References: <20261113-jk-e825-e830-timecounter-v2-0-9c357a7ed349@intel.com>
 <20261113-jk-e825-e830-timecounter-v2-4-9c357a7ed349@intel.com>
 <sashiko-outbox-213873@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-213873@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::7) To SJ2PR11MB8451.namprd11.prod.outlook.com
 (2603:10b6:a03:56e::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8451:EE_|DM3PPF99D0888FA:EE_
X-MS-Office365-Filtering-Correlation-Id: b78892d8-628c-4f1b-64df-08df44434ec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|18002099003|22082099003|6133799003|3023799007|5023799004|11063799006|4143699003|56012099006|10067099003|261022075727099003|261026121527099003|261028144727099003|261021123027099003|261009221227099003|261021121427099003|261009223327099003|261009221727099003|261026140227099003|261009223027099003|261102123227099003|261009220027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: s2SN5zgVwDTzo44Qy/oOaFUviO1ASxjPP0cbbjassfS++V8ttJrTyqrHnu737pXcKfbQlCLmoyvkZKf7Wgxi+58Wk42CW1JCDQ+qgRwVqfrlr0YpqsbC34BZAQ8L53OgYhsVuDqLZdnXoatoS5Kmt3mQm4s+ffPpoopUIHz9kxnxi8UMZtTfAd/oiTX7NbpJSKdmxIZcmCY1lcWC8MFXf7IM6rdAcPQFquX6rG89Aoa+wmCXe2uDlXa38WIaIEk2t4s62eOs88KaOjBIr4f4D6f6AeOmhhzrCZaurnU54B3HMD0SbomedoaBSb7bKVLOvFl5Lk+85mJPZO4MhIw6uT+sOtL7J97a4Vk47SZ8czyxfUp3GWd/x+a2sGI69RST6+bO9SjV1zipGwRv1LNupC8FD3XfP412AeueCNmVc9N+YpBnVvmrDSqLor3mEuGai1QKQmwadnLs0xONuG4MULhiMUxeysuRG7iB9xLoV59Jd2ECPzJdYBEkAn4M+IVyyfdcUxr932fAh4R51qu0W7GZeD4O6/3/Fo2sTIiuKUN1sAXyKzrac9HTpGNrHVqfaypbJc9MoTCNQMRmGVzj7kPukFvfPOBM6+O7Hg+Fq/lGPiJPI0Lo3xNOMvCnG2FnwezO11AXDaLjo1ciuMJyO67sKed2pNBTYDqIML27hVk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR11MB8451.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(3023799007)(5023799004)(11063799006)(4143699003)(56012099006)(10067099003)(261022075727099003)(261026121527099003)(261028144727099003)(261021123027099003)(261009221227099003)(261021121427099003)(261009223327099003)(261009221727099003)(261026140227099003)(261009223027099003)(261102123227099003)(261009220027099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUF1emhhbGdNOHltTm1XL0lpaDBGeEpMQStRd3ZwMGJKNmdiMjJRWVpkMmI2?=
 =?utf-8?B?b2RJWFNaRDB1ekM1ZHl2YzdXbi9aZGtHeFBydXpPbnltS2VRaGZpRDZFejln?=
 =?utf-8?B?cDRNMzE1Zk5LQ1ZkN2k4R2ZNN20zcjBRWUo5eExta1FWUXp4eHNhbmNPZEFo?=
 =?utf-8?B?RXhSZDdrQ0JPdkVKK0ttdVQwcWp2QzdjZW5wQ2JzM2YyZXNUTXlUMDRxNGF0?=
 =?utf-8?B?L0pGZzNrV09YZkdnT01hVWFWdEx5TXpxVTBBQmRReEE2dEpCbCtyaUdZRVBS?=
 =?utf-8?B?WlRHTTFEUkFFQzB4WXlmRythUi9IbC9YUThzYkFFWHNTV0crd3h0aUFQKzRr?=
 =?utf-8?B?blRlZFNQczBhN1hnSDJnM0xkeCtTM0JKSktzUHJiVVVKS2NIRWlTVVdVckRZ?=
 =?utf-8?B?blNvT05jb1JlcnZvSWRPdGZWNDdvTkZxdERCMm4xdUIvZFd6YmR1SEcwazY3?=
 =?utf-8?B?WEtDUE9mMDQ3VWFIWjhzMkZnNXNwbUdaZTgyVmVEMWlxOVlwVmFMZnZydFls?=
 =?utf-8?B?aW1VYlM3V0RPUnUyenZBK2VBZkFVU1BoUDE4dEQvcVUvYkFGNFNtWkZOL0JE?=
 =?utf-8?B?ZitLUGM3U0JwOFdSRnlEUnk4WGVMRlZUQ0V0cWJWQThNY2JrKzd5eGQvd1hE?=
 =?utf-8?B?SDVjZEdpZ0xrVEJ4R3pqQW5TNG9nV1hJd0U0OFM4L2JvVXJ3Ylo5WUllRUc2?=
 =?utf-8?B?Tngyb0Z3MmF2RG1RMnFXUmFiNEFReHA5ODEwaFp5Nnk3SnVsdzRZcC94OElL?=
 =?utf-8?B?d1NKL3BXYXp1bDJEZFJ2OVpUczZMR0tzbEQ3Nlo2UUc1TmFPaWlIUnpKYkty?=
 =?utf-8?B?dHBMNzlITFhtcm5RTGtaWVE4YnVBWDNRTFFSd2hQSGFWRGloRTVxbGtNeVc0?=
 =?utf-8?B?RmFqQUFUNXozNnk4VDFKQkM1cC8zOER2OWpRUTNnemZCeHVSRFg1MnplMzRu?=
 =?utf-8?B?TWZoQjg0dW1BbGdOVFFJNEpqdTI3bFNzTkk5UWo2OWljM1k4ckEvWGl2MzdQ?=
 =?utf-8?B?clF1eXM0RWJuOEFXU0E2RE5XS2lOWjZnakdYVjNZYUV3U3J5Um1XUXAzTGI1?=
 =?utf-8?B?ampnUDNtUFJWTzkvTW92dlJJeURXYUZwQlRXRXBGS2pCTXhiTm4rNjIya2ZI?=
 =?utf-8?B?cjRha3VoNEN5N3FWcGxpdStmb1lZQ0hzRlhmTVVnUWJyMmg0WFhyaFFLc0hK?=
 =?utf-8?B?bUlFdlcxQnlWNis3a0ZvREsxZk8wbXRSeDk2aXZGS25OVGR2RUE5UG5Ib3g5?=
 =?utf-8?B?dVZUUlBiYUNGaW11WW1pU1M2aXdiYnZ0N2dMdGdJcGNqaHMrWWl6SWZjbDJa?=
 =?utf-8?B?UHFnMFlPRlpXaGgya21QR3Rka3c3UlQ0TWNRQ3dIU0gvdUJXeWdMTjBRK2sx?=
 =?utf-8?B?TStIRW5EWU5yYzdUY20yVURaeE00YUpsV0cxeGtmVkhiaEZNTEQyUzZjcjhw?=
 =?utf-8?B?eStZTmRpbWp5NG9EZEFaSkpCbVA4QnVydW5WdktUbjE3Q0l0YUpnUnZxR0hP?=
 =?utf-8?B?a0Z0eU5oMnBxWEhiRGpjSjg5cDJtYTJzQ2hORndma3lWVDlYcTdDV25GN2tG?=
 =?utf-8?B?cXBtdXArRmUvSFZLU0NCWEROUThFWjRSUGZuWEdOSnlkYWZBVU52emFhVnNq?=
 =?utf-8?B?UUZqbmlqV0ZMZDRkODRSYWRETDQ1aWxwcEJxcTU1Rmo3aCtwNk1uTjg1YkpL?=
 =?utf-8?B?Sk5PMDBKampDZGZXZC9rYUNaNnlTMmU0ekZuYnBINU5XZ09Wc0VUZlRkVFRN?=
 =?utf-8?B?eXpnNHR0TlMrNjBHR0xCM3B5T0lCNjUrZFU2ZzkrWEYwdlp5UXduclp3c2x2?=
 =?utf-8?B?dXg4Q1h2NTZxelMwc0kybEswMnYwSFhwcUpnY3pVaXRiWk5CUXAxamlzRkpJ?=
 =?utf-8?B?c21XZENYdk9oMzRiKzRDZStmS1g0WlB4WWppd1kyVDBYK0xUYks5SEVZU29l?=
 =?utf-8?B?Z3kxeHkvRDFJTERhNEYyNndhT0p3NGZUWndHRHhrbSszaExFK0hnVWZ4TjRO?=
 =?utf-8?B?VitpSmJsQ2FvQlBPMndyL0FpQXhnUHV0eFRBQjFzNUZvTHRMTXpmcklTamw5?=
 =?utf-8?B?UHVFOUVYaG5oZzFTNFQzbjZaMVh0VG9JNDN2UENCMUxoNjF5NUd4amxUd2Vj?=
 =?utf-8?B?MW5qaGtkSmNmYk8vRU5NZlFpNXQ0ZGpkVTlnNnp1MCtWTjhGZzNGV1MzRGh2?=
 =?utf-8?B?MHdjcnNTSnQxU29tYmhMVStsSnkrK1c3bkhrSUpzNEphTVByZ2JRam8vNE5D?=
 =?utf-8?B?V05IVmtBYXJMWTBzSUZnR1hJeFRjNmtmTzZTZGxGN0kzMkl1dGw5L0piMmVW?=
 =?utf-8?B?eHdhMWFQczd1MVVyb0hsTGZOTmJlNHpQMnVPU1BsVlAzdDE4RU44QT09?=
X-Exchange-RoutingPolicyChecked: p4tEspHTBIe3csfCmaxtEUCMfwpELNqo5SoEKN3kJ0ClBHkV+0zAJOp2L9QY0rXRppUPsM3kUzOfmqRgeW/FSssNc0neuz/sUyFonjA1mA18BKstc+Sm0De35Z+nCpFY+5BaY0MuIWGRGZ9vWpPSyl7uYN8K/qFa9Nia9JqK0CHj5aW8/znGIPCoRlZqcgPvhyNOC4u815cbxLktfRj/XTlQcg1n1BIK/g1Klhy029i1yu5PUAHIFtr8N1rUapf5l8g01zG32fMoEPf24b4k2b0dvL0Y+6dE+VgKpMxhJ8HlUP+P6ghKiUn1ChqK0Zjq1EKFgvLV7oR56iTr4yo7nA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b78892d8-628c-4f1b-64df-08df44434ec4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 00:39:58.6472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6x/dvkH4u/HqI8kzoLDvDG5NB+5AY5GlejhddQgAf8jZxDCwfikxWBxf9DjWu4jy3bZXmutIHwD+9FjYdfNT/8BSfdfmKc+7c4YVQQbOpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF99D0888FA
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

On 11/13/2026 3:46 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [Medium] ice: perout_rqs updated outside phc.lock in
>   ice_ptp_gpio_enable()
> - [Medium] ice: premature update_jiffies store in ice_ptp_read_cycles()
> --
> 
> commit 2dbce654e6813d30b319e71f8e68ca2b82a4b244
> Author: Jacob Keller <jacob.e.keller@intel.com>
> 
> ice: use struct timecounter for E825 and E830
> 
> This commit switches E825 and E830 devices from direct hardware PHC time
> adjustments and legacy 32-bit timestamp extension to a latched
> timecounter/cyclecounter stored in struct ice_phc.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index a0451c1083a41..b48d1bf3bbf59 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> @@ -272,6 +272,202 @@ int ice_ptp_read_src_clk_reg(struct ice_pf *pf,
>>  	return 0;
>>  }
>>  
>> +/**
>> + * ice_ptp_read_cycles - cyclecounter read() callback function
>> + * @cc: the hardware cycle counter structure
>> + *
>> + * Read the PHC time via ice_ptp_read_src_clk_reg() and report it for use
>> + * within timecounter_read() and timecounter_init().
>> + *
>> + * Although the cycle counter is masked to 32-bits for timestamp extension,
>> + * this still reports the full 64-bit time to enable determining the phase
>> + * difference between the PHC hardware value and the timecounter properly.
>> + *
>> + * Return: The current PHC timer value from the hardware on success.
>> + *         Since failure cannot be meaningfully reported, return the previous
>> + *         cycle_last value when unable to access the device.
>> + */
>> +u64 ice_ptp_read_cycles(struct cyclecounter *cc)
>> +{
>> +	struct ice_adapter *adapter;
>> +	struct ice_phc *phc;
>> +	struct ice_pf *pf;
>> +	u64 time;
>> +	int err;
>> +
>> +	phc = container_of(cc, struct ice_phc, cc);
>> +	adapter = container_of(phc, struct ice_adapter, phc);
>> +
>> +	scoped_guard(rcu) {
>> +		pf = rcu_dereference(adapter->ctrl_pf);
>> +		if (!pf)
>> +			return phc->tc[0].cycle_last;
>> +
>> +		err = ice_ptp_read_src_clk_reg(pf, NULL, &time);
>> +		if (err)
>> +			return phc->tc[0].cycle_last;
>> +
>> +		/* Paired with smp_load_acquire in ice_ptp_extend_32b_ts */
>> +		smp_store_release(&phc->update_jiffies, jiffies | 1);
>> +		return time;
>> +	}
>> +}
> 
> [ ... ]
> 
>> +static void ice_phc_refresh(struct ice_phc *phc)
>> +{
>> +	lockdep_assert_held(&phc->lock);
>> +
>> +	write_seqcount_latch_begin(&phc->seq);
>> +	(void)timecounter_read(&phc->tc[0]);
>> +	write_seqcount_latch(&phc->seq);
>> +	/* Update the secondary copy */
>> +	phc->tc[1].cycle_last = phc->tc[0].cycle_last;
>> +	phc->tc[1].nsec = phc->tc[0].nsec;
>> +	write_seqcount_latch_end(&phc->seq);
>> +}
>> +
>> +/**
>> + * ice_phc_init - Initialize PHC timecounter to new start value
>> + * @phc: pointer to the PHC structure
>> + * @init_tstamp: New initial value for the timecounter
>> + *
>> + * Initialize the PHC timecounter to a new offset. The latched sequence
>> + * counter is used to ensure readers get a consistent view of the timecounter
>> + * phase. We always pass the same cyclecounter structure, so the mask, frac,
>> + * and cc fields always remain the same, and only the cycle_last and nsec
>> + * fields must be propagated to the secondary structure.
>> + */
>> +static void ice_phc_init(struct ice_phc *phc, u64 init_tstamp)
>> +{
>> +	lockdep_assert_held(&phc->lock);
>> +
>> +	write_seqcount_latch_begin(&phc->seq);
>> +	timecounter_init(&phc->tc[0], &phc->cc, init_tstamp);
>> +	write_seqcount_latch(&phc->seq);
>> +	/* Update the secondary copy */
>> +	phc->tc[1].cycle_last = phc->tc[0].cycle_last;
>> +	phc->tc[1].nsec = phc->tc[0].nsec;
>> +	write_seqcount_latch_end(&phc->seq);
>> +}
> 
> [Severity: Medium]
> Does storing phc->update_jiffies inside ice_ptp_read_cycles() publish
> the timestamp before either phc->tc[] copy is updated?
> 
> timecounter_init() and timecounter_read() invoke cc->read() before
> writing tc[0].cycle_last and tc[0].nsec, while phc->seq is odd and
> directing readers to phc->tc[1]:
> 
> CPU0                                  CPU1
> ice_phc_init()
>   write_seqcount_latch_begin(&phc->seq)
>   timecounter_init(&phc->tc[0], ...)
>     ice_ptp_read_cycles()
>       smp_store_release(&phc->update_jiffies, ...)
>                                       ice_ptp_extend_32b_ts()
>                                         smp_load_acquire(&phc->update_jiffies)
>                                         ice_phc_cyc2time_with_trace()
>                                           seq = read_seqcount_latch(&phc->seq)
>                                           /* idx == 1 */
>                                           timecounter_cyc2time(&phc->tc[1], ...)
>                                             <-- uses uninitialized or stale tc[1]
>     tc[0].cycle_last = ...
>     tc[0].nsec = ...
>   write_seqcount_latch(&phc->seq)
>   phc->tc[1] = phc->tc[0]
>   write_seqcount_latch_end(&phc->seq)
> 
> During initial bringup or after a reset or delayed refresh (>2s), CPU1
> sees a fresh update_jiffies and extends a packet's 32-bit hardware
> timestamp against an uninitialized (zero) or stale phc->tc[1] snapshot
> instead of discarding it or using the updated timecounter.  Recording the
> new jiffies value and calling smp_store_release(&phc->update_jiffies, ...)
> after write_seqcount_latch(&phc->seq) (or write_seqcount_latch_end()) when
> cc->read() succeeded would ensure readers only see the fresh timestamp
> once an updated timecounter copy is active.
>

The problem here is that I do not have a way to check if read fails. I
suppose we could modify the timecounter API to support reporting a
failure from read? In practice this read should basically never fail
except in cases near a teardown that drops the ctrl_pf from the
adapter... I don't really want to try and add yet another variable to
the structure but that would be an alternative fix here...



> [ ... ]
> 
>> @@ -1974,7 +2202,10 @@ static int ice_ptp_gpio_enable(struct ptp_clock_info *info,
>>  		if (on && pf->ptp.state != ICE_PTP_READY)
>>  			return -EIO;
>>  
>> +		/* Serialize against concurrent timecounter updates */
>> +		mutex_lock(&pf->adapter->phc.lock);
>>  		err = ice_ptp_cfg_perout(pf, &rq->perout, on);
>> +		mutex_unlock(&pf->adapter->phc.lock);
>>  		if (!err) {
>>  			*cached = rq->perout;
>>  		} else {
> 
> [ ... ]
> 
>> @@ -2086,6 +2319,43 @@ ice_ptp_settime64(struct ptp_clock_info *info, const struct timespec64 *ts)
>> +static int ice_ptp_settime64_tc(struct ptp_clock_info *info,
>> +				const struct timespec64 *ts)
>> +{
>> +	struct ice_pf *pf = ptp_info_to_pf(info);
>> +	struct ice_phc *phc = &pf->adapter->phc;
>> +	u64 ns;
>> +
>> +	if (pf->ptp.state != ICE_PTP_READY)
>> +		return -EIO;
>> +
>> +	ns = timespec64_to_ns(ts);
>> +
>> +	mutex_lock(&phc->lock);
>> +
>> +	ice_ptp_disable_all_perout(pf);
>> +
>> +	ice_phc_init(phc, ns);
>> +
>> +	ice_ptp_mark_all_tx_tracker_stale(pf);\n+
>> +	/* Reenable periodic outputs */
>> +	ice_ptp_enable_all_perout(pf);
>> +
>> +	mutex_unlock(&phc->lock);
>> +
>> +	return 0;
>> +}
> 
> [Severity: Medium]
> Can releasing pf->adapter->phc.lock before updating *cached
> (pf->ptp.perout_rqs[rq->perout.index]) in ice_ptp_gpio_enable() race with
> ice_ptp_settime64_tc() or ice_ptp_adjtime_tc()?
> 
> The POSIX clock layer only holds down_read(&clk->rwsem) across ioctl,
> clock_settime, and clock_adjtime calls, so ice_ptp_gpio_enable() and
> ice_ptp_settime64_tc() can run concurrently:
> 


Its weird this was placed here, but ya, I think we do need to hold the
lock until after the report back from gpio_enable.

> CPU0                                  CPU1
> ice_ptp_gpio_enable()
>   mutex_lock(&pf->adapter->phc.lock)
>   ice_ptp_cfg_perout(pf, &rq->perout, 1)
>   mutex_unlock(&pf->adapter->phc.lock)
>                                       ice_ptp_settime64_tc()
>                                         mutex_lock(&phc->lock)
>                                         ice_ptp_disable_all_perout(pf)
>                                         ice_phc_init(phc, ns)
>                                         ice_ptp_enable_all_perout(pf)
>                                           /* cached->period is still 0 */
>                                         mutex_unlock(&phc->lock)
>   *cached = rq->perout;                 <-- HW keeps pre-settime phase
> 
> When enabling an output, ice_ptp_enable_all_perout() sees a zero period in
> perout_rqs[] and skips reprogramming GLTSYN_TGT for the new timecounter
> phase; when disabling an output, it sees the old non-zero period and
> re-enables the output in hardware right before *cached is cleared.
> Writing *cached without holding phc.lock also races with
> ice_ptp_disable_all_perout() and ice_ptp_enable_all_perout() reading the
> struct under phc.lock.  Holding pf->adapter->phc.lock across the *cached
> update in ice_ptp_gpio_enable() avoids the race.
> 

