Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EF8606A31C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Nov 2026 13:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=X8Yh15Xl;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eo6RxbtF;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Klqab17e
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D16F80FC6;
	Tue, 17 Nov 2026 13:46:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ujee2FMBCnHO; Tue, 17 Nov 2026 13:46:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 57FC481126
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794923169;
	b=V+u3ki7KbEnZdxtjCK3jb/07ly25aAKhs7CcTY0CZs+bbJ31IXS26F26zsbWqfw9kWsh
	 Mo7MoViOO67tC43ZRB9Tgrp/7WCViJ+GDxOF1iJkORz2gGt077qnSm0eBiiFTfF8hQ0lF
	 n6HC+3nNpg/eo7O5yzUxOLwirODMOSxH8hJeZlNT9jhfZbCNfDRWzpHA00Wxn0o7G91BM
	 G6wUrxVqOzeDK1/b74+QM1sRDi3CmiRpoDKck9/rNU9XfI6Yd9FjjGD5muTieJZHei0o5
	 iDh2mohjddMRab9MPhxWOt6wzlA4wG+XFLCTs2vL++ZWuHp38ArMyWxqbtbCbmcNcIg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794923169;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:Content-Type:Message-ID:Date:User-Agent:Subject:
	 References:Content-Language:From:To:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=T/u5NTotFm6WyXE5MhipvPVbLiOuqyiVLxJlP/8H7cg=;
	b=Ebh/W57xXYXPHGvQPFVO2wneF7gRdUqJHDDeHgzI5pt/fEhIat/ntAJEYke3HK0Npfzz
	 qR9ZOD6fJlqK1FNn608rVVroEWAhhMGzHcm2eHW2xHuQSzUiTnEciKLpQ2jnX3w4yJjpR
	 RdH7nbNeo/ismfA+CUNM4Mg73ucUFskfGqLpPEUVSw4IfPBJFvsJak4KM5SSwc5RbXaOD
	 iEv0ntfRFDTqfQFxFOMZkHa6UZR0kglVTaNFbCb3qBT4jfGXQXdreCtM2VjJNlKPdHG3g
	 pSsDYJQur4J14RnJ1W48yQPMsfOw9jzoI6zeUZSNzHdEerpBy6fnpNuRV1Le0vdeYlg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eo6RxbtF;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Klqab17e;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794923169;
	bh=T/u5NTotFm6WyXE5MhipvPVbLiOuqyiVLxJlP/8H7cg=;
	h=Date:Subject:References:From:To:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X8Yh15Xl1O7ucaOspLawf6w5kHjorhOg0XMJuZi3Ca2zu9oEnmK2QFEG+hYMGJ+pq
	 IG8lllizrcU8ShIyHYkmPQywlQe8lqK1DWaqAzYwiu9mHMO8Y4iCvl/0Kn1SwvBkZZ
	 6RNI7lAkTjZ0voYZ1TGAPCBmN/uc7pmtcL3i4x3BzIhKvwPhv26mI9zso03Gd0hkW6
	 NRtaBTyZBVwvLQYZZzbI0h4OYRzPH7qkheKrTimB2dLgvZ3Q+Cw/TyqsnTuvhLxWM/
	 7gQxSXYf7ly7lq9VX19sLr3Q4Lf4iZYXYlmhAG2yxL/0kG90cAgfUAN3gSyWonhQSZ
	 JdngoDzHr2x8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57FC481126;
	Tue, 17 Nov 2026 13:46:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 864EE1E7
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 13:46:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6C92280FC6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 13:46:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6w1aPzdAQ56x for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Nov 2026 13:46:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E407280F5C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=lukasz.czapnik@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=eo6RxbtF; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=Klqab17e
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E407280F5C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 13:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794923166; x=1826459166;
 h=message-id:date:subject:references:from:to:in-reply-to:
 mime-version; bh=HA/tiumdIyMRn+MPgso5nLTZYTkhoq4S2TsQDfr2Iws=;
 b=eo6RxbtF3Nn1QTuWfBeOFYgkbqaxA9cSD3I7RNV1zjRF6N7Kuggyck34
 +VX01YMMeNOJPgsd5WBtu5Z7LeZ1anys4D9sYtIouC4M+g5Kn2DkYhNN9
 /kDbpOhlVNi9Ak7uwIPFO4xDlKtglGq1O32nAinEfwAcy8X38BxpTPoDf
 PgQQEPvSMxZpcS2jpx5Hcv5wocuQH2dDHp3dxeIhDiL8d+2236ZXGl/1+
 y8rX9gSpaaO8ym1gtKUvF236z8STidLXDxcD7DMOzXQkJHzE+O8mXZ60K
 PDuW23VfjtCkbzmEufBLTkd2NqIbX4wxC0mUavJO2uGv8LngFSlkXXmUD w==;
X-CSE-ConnectionGUID: eJ9gTg1nQZG2lm8lOusbHw==
X-CSE-MsgGUID: 66F51QeESl2Y3hkLDNpxYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3682657"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; d="scan'208,217";a="3682657"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 05:46:05 -0800
X-CSE-ConnectionGUID: DFRFBgZpTFOxNoiC8mjxvw==
X-CSE-MsgGUID: 18rp8kj0Q/K3O0+GQZAROw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; d="scan'208,217";a="9625590"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 05:46:04 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 05:46:04 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 17 Nov 2026 05:46:04 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.47) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 05:46:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/u5NTotFm6WyXE5MhipvPVbLiOuqyiVLxJlP/8H7cg=;
 b=Klqab17eloRI6buwpWPopgi5jW/8k6yLh8Zni5fRlzNZF1XuYybj9ZkQZP27aZB0CT2xrOtW1b+XdsYBdQ8s2PgVeaTMGOMA0JWl/gbJ6x683wdQtBVyTs0QX8v+9AVgPpbZIp8NRDEINRPHccgqmxyR5y0Vft4Kb3U6C5npYeo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6295.namprd11.prod.outlook.com (2603:10b6:8:95::15) by
 IA0PR11MB8398.namprd11.prod.outlook.com (2603:10b6:208:487::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 13:46:01 +0000
Received: from DS7PR11MB6295.namprd11.prod.outlook.com
 ([fe80::aad1:8f92:965e:350c]) by DS7PR11MB6295.namprd11.prod.outlook.com
 ([fe80::aad1:8f92:965e:350c%3]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 13:46:00 +0000
Content-Type: multipart/alternative;
 boundary="------------Yk5vQynM2jpGHuGys7rvei62"
Message-ID: <bcab144d-79d2-4e0d-9e0d-34ca8758d46d@intel.com>
Date: Tue, 17 Nov 2026 14:45:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v3] ice: Fix "Unknown bps" during link events
References: <20261016111653.1196653-1-lukasz.czapnik@intel.com>
 <sashiko-outbox-174243@kernel.org>
Content-Language: en-US
From: Lukasz Czapnik <lukasz.czapnik@intel.com>
To: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
In-Reply-To: <sashiko-outbox-174243@kernel.org>
X-ClientProxiedBy: VIVP296CA0077.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:352::8) To DS7PR11MB6295.namprd11.prod.outlook.com
 (2603:10b6:8:95::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6295:EE_|IA0PR11MB8398:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c149ea6-6e55-4933-b2e8-08df44b11d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|6133799003|8096899003|11063799006|4143699003|56012099006|261022075727099003|261026121527099003|261028144727099003|261021121427099003|10067099003|261026140227099003|261009223027099003|261102123227099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: hXwwE3tTCN8cwmTbobKA7L9zhsj9MKCLQUe0/l9p+lN73Pr81HQ7jEVzcnqnLQhMyQ1mbynXT1mSMFyDoPJG+OgkIPdtXmxRvwZTGDkCag6Z6uYfRWX/u2393WaTYwgRAmlrHUYbeSSlslPJAtGwFBerJxFIf0C1s3hT8+365u+3dL/k4ZPIAF4x11MoPJF5Tut4OVrsxuKQAHuDmmNaJ1JYNSn353jKBZETggWt+4nZy4j3BkGMzLs8WEebBDs4WTOn/3UzG3n7mllT0SMqgPtF3Lp1ib0cDJTxPHXi/En3Qkt8aGNOkm3xkhqRTTcI19KcJMiuynBGxpy0eroyAwyzC+mFyT8JjTe2gHHhcEvgAkIGIVvcQOUoucDHDXTVwBGn/OOZSkQuuxcJy6BH9FaP8BEppyIOz4UsheLRuShOHANAmtR06Y6hi0wdA98J0xgBZ3hIUirFQ5fkMSmdmfQCcpvt/RVUouFkKVCFrIl6bQQwaiih5iUkn42GB5T4FTrl9SYrQRoZPOybn5+8lJ7tVNWOPLW7b5xae4JE5SrnreDH/Y//7c+klyTMRt7FHwrAjjb+JdDR8oDW4qCX7UeU0SlHC0n4+8r4UvObylmHmBPzPRoBd8VF1scGDzhfpEteuetrFlG0PxeJ1q1LRZpiQ/kFGWyA68YXGiT1y+s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB6295.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(8096899003)(11063799006)(4143699003)(56012099006)(261022075727099003)(261026121527099003)(261028144727099003)(261021121427099003)(10067099003)(261026140227099003)(261009223027099003)(261102123227099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXFOM3lJTlFDS2pWV1o1NU8ya29zazVJaFRQTVBjQ3JhSjRGWi96VHBmSFps?=
 =?utf-8?B?THVNUWpkZEVXWWdScDhKZkpzUU9SSDc0RDZHVmxlVWYySEVlY0ZkbDVuUndn?=
 =?utf-8?B?Tnc5WlpCcGtBdjR5NVQrYVpDRFkvdkllZUhSY0sxVk5INlBab2hGZFJ5TDRv?=
 =?utf-8?B?VFZIa3V5WmsxVVc3RmM4ejlHazB4S3FFS2JtREtDSVhKTmFiV1VDdkpNYWVO?=
 =?utf-8?B?ZEk4YmtBQjhBVnpyMkxWcmFmLzZHUC83aEs4djY5MCtvdXRFNmNranJsVURZ?=
 =?utf-8?B?Sm5mYkE5RmtJZGlFRzdCVHdVK2MxZk0waGw5OVNKNGYxNWNZaDJHTGRHa0lX?=
 =?utf-8?B?L0hCT3ppRUFzTmU0UGQwd1BlSEJIc3NlaXlkc2wycURQemFQY2Z3dzFkbGRw?=
 =?utf-8?B?NTFSNGNTZkM0S3VaOXRUY0NZV0xWV21rV0NWbm1TakpIamgvS0FGM2dVV0Ji?=
 =?utf-8?B?VEt0dGUrYlhPV1VPcDhyc0hjWmJvMm8xVXdLTktocDZDcGlOdk4raVBSL003?=
 =?utf-8?B?NjFLWlI1RW5ES2ZTRmtzdElybHgyTkhOWGFoR2UySjNVTEpSL0FUV2o2TzJm?=
 =?utf-8?B?MCt2WVFIeGhYOFN2TUpLU3IxaGJ2ZDJtOURYWi9Dck1ET3lMV25XY0p4a2Vs?=
 =?utf-8?B?Q0p0bVFEbEcxaHBPaWU1UG96dzZBMW82NEw3ekdZYWs2SktpVGt3d2RJeVRh?=
 =?utf-8?B?bER6a21vWHdhZE1CSUgwdnhyWkRIc2h6cVVxUStkK2lDZ2JZdFhNWnFrTjdW?=
 =?utf-8?B?MW50dG0vKy91dmpQL2JaamNGdWRvMnhEcmtxLzF4Y3pDS1pDdGxNdzRDVW05?=
 =?utf-8?B?d2o4RFlRUnNCMEt2WTlYNG5FUEhCbG9pWDNxMkhSdzMxcGdaaGJSaHRNbEkw?=
 =?utf-8?B?dVRHUjYrVjFBUWw3VDhCL1BnOE5JTEttazVzeEp4TVFMQVBWL0JzblJlOWxT?=
 =?utf-8?B?YlZRanA2MnJIWERGRXM2c3JiRXp5UkpyelNwUmljTHFuZ3I4Mk9ySFVydTNN?=
 =?utf-8?B?NndJTmVKanQ0R1lZdXMwRXdRZ2pBc2N4NTViRUlwV1Y2dU5xemFCNFNoT3Ba?=
 =?utf-8?B?bnFVSDJWU2JkRVRKUG1Na0VvWVFlL3ZmUGlSa2lMWmU0ZUhoc2ZlZG00UkNy?=
 =?utf-8?B?OGlwcisvV1FCb1BTc3FsZ3JSZHRSRlJaaTR5aVZDdElCdlJycUtwNVYvall5?=
 =?utf-8?B?VjA2WDR3dUhwQ3dpN1BrTDdmUkNTZEVxMG1oR0MxM1Z1NkJPeDJldXZDY0g5?=
 =?utf-8?B?UjFxS0RYRlArYzIwSjgzSmlMQ0lCV2ZPckU2WnJVdG96TC9oSGF0WlNIVGFh?=
 =?utf-8?B?SlpBZHpGekFURXFvY2NtMzBPblRoSWlKWDhCbEJ5Tit6RkI0elVpMzVnRnRS?=
 =?utf-8?B?dEdDZE1tRkI5aThnU0FrUmQxVnZSVGFXUys1K1BZcXF3WTJyMEZHaHhMMk1h?=
 =?utf-8?B?c0ZWbHVIbHBmNU1DTzFnMmxmSDRiU1Y3Q1lVdnV1YVI0VUxpTUNJNWxFbWM2?=
 =?utf-8?B?VTBVZHExZ3BPeUxUZ2FRWWdPR1ZYL0VtbThUbU0vVXNhNVhjODN4T3JLOTlh?=
 =?utf-8?B?UUFYZzVVZG5Sc2JUUWVSVzVMOTQwRUhWaDhabkZjZExrdTZteDNmQmtxem5Y?=
 =?utf-8?B?bUdmcmdvMkdHVjdjVUJ5WUd0Vk9yTHdESkdvY2RtOTFpUERIQnJSWjA3RWVN?=
 =?utf-8?B?TWh0SENzdm1uYjdOWTZVQ1VOY1hXLy9QK2FYaTE4YVBrSE84NFZCZTFHenBz?=
 =?utf-8?B?cWFXZmZ0clUrVjcyTUx2QjQ3TUhKVldXcE9OcklDb1lLZFBTSnVpSjJZL2k4?=
 =?utf-8?B?empUMTVWVFpZbmZtRFFvL2VVNnYzay96T0xNeHpvODZWNlZEMnJzQ2w2QkRT?=
 =?utf-8?B?OElJQkdCZE5NYTdZQVhaOVAzVlFuUU5FY1lTc3JCVGloLzhoUk1ZcHFMTXU2?=
 =?utf-8?B?NlBFc3VFUlBhc0FjZU4zV1FYRFhSb0hoRGF4SlpQQTB0cUVXOUtPVkZsMUlW?=
 =?utf-8?B?VVEwS25BNGVqeUwxQTl6cHFwb01EWEREU0V5bkFkNWN2VEllZC9nRi8rMVNK?=
 =?utf-8?B?SHNvUXFFVDF2MmE4NDI4cTEzRTg2OXZJd09mQ0h0eDJpY1I3OVV4UG0wcDk3?=
 =?utf-8?B?ZEtsSnhUZEJrL0NLMEdqRWRITHRRTWY5YjBxSi9aREVqelhSMS9rL2Y3U3BL?=
 =?utf-8?B?WFRlSzZSQm5iVE40d2xCdDZXOHhJbkFJZ21kVGVVZDQzb2Q1VVlHUnJDcDFx?=
 =?utf-8?B?V3RjVEFmbklnb0lGZU1WdUZzNE5sZnR4VHM2S0EzSEdvaEZ3NkRNTjFFU0hr?=
 =?utf-8?B?ek50QjhwTjFZVHJ6NU1hbDVWYWF3Wm5WclJvMXZjWmE3VzU1dDBHaGNRU0Mw?=
 =?utf-8?Q?mWgQqLliQpAHQXr0=3D?=
X-Exchange-RoutingPolicyChecked: sH+JXwAxoLV+mJ3exMNYt/83z1rLnipU/SVdNltbiimCv8h85Xa8eLIq1CJNQfuVBW7C0f/QcTUbEiDkXaXY4D5WFAlNFrjXEakA3g4Yfcv8p43k9/IfFXrFL8wmVh64WQKp5qNFVJ277YVEsPmjPiVuEdQhg4pDvrx3VtpoY2hbLYBfAlFvwVBboEJ0Q2tdtqOMiLri0EpHjqDAAt+l2R/uIwqAAl1t7LioHVFwjnGB8OPwYO1GvAK3mQ5WqJUQYPAgYNazXoWRF1JkrgOMCT7FiwBy/G7aKGV6gxbQy67Fc0vOIxIsutwRsURjKckSLhmvXWzFagVKBV4GnMeyQQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c149ea6-6e55-4933-b2e8-08df44b11d96
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6295.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 13:46:00.8523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8DYtDaHZyiA7w8ViFksiI09IpBvHC5KuhIw0Jx5mgLUyyk4WLAEEHIx5U8NzVBmhJGgocBeJMDmYEbKhEJyiiwqfBJWKheN2Ly9BjJarBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8398
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
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------Yk5vQynM2jpGHuGys7rvei62
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/16/2026 1:26 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] ice: data race on bitfields in struct ice_vsi causing state corruption
> - [Medium] ice: unsynchronized RMW of phy_info->link_info in ice_link_event()
> --
>
> commit 35fcfc2f1fd4d9de2d01f00551ed70ac2dd02bbf
> Author: Jakub Kaminski<jakub.kaminski@intel.com>
> Subject: ice: Fix "Unknown bps" during link events
>
> The commit refactors the link event flow in the ice driver to use refreshed
> link state rather than event values when the status read succeeds. It also
> safely caches event values on read failures, introduces ice_update_media_caps(),
> and updates ice_print_link_msg() to take the link speed as a parameter.
>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>> index c26cef0214552..ac0867ef812a0 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> @@ -844,8 +844,9 @@ static void ice_print_topo_conflict(struct ice_vsi *vsi)
>>    * ice_print_link_msg - print link up or down message
>>    * @vsi: the VSI whose link status is being queried
>>    * @isup: boolean for if the link is now up or down
>> + * @link_speed: current link speed value to display
>>    */
>> -void ice_print_link_msg(struct ice_vsi *vsi, bool isup)
>> +void ice_print_link_msg(struct ice_vsi *vsi, bool isup, u16 link_speed)
>>   {
> [Severity: High]
> Does this function trigger a data race on the bitfields in struct ice_vsi
> that can cause state corruption?
>
> The current_isup, irqs_ready, and stat_offsets_loaded bitfields share a
> single byte in struct ice_vsi:
>
> 	u8 irqs_ready:1;
> 	u8 current_isup:1;		 /* Sync 'link up' logging */
> 	u8 stat_offsets_loaded:1;
>
> Compilers implement assignments to these bitfields as non-atomic
> read-modify-write (RMW) operations on the shared byte. This function
> modifies current_isup locklessly from the ice_service_task workqueue.
>
> Concurrently, ice_vsi_req_irq_msix(), ice_vsi_free_irq(), and
> ice_up_complete() modify irqs_ready and stat_offsets_loaded from process
> context (e.g., ndo_open/ndo_stop) protected by the RTNL lock.
>
> A concurrent RMW by the service task can silently overwrite and revert
> changes to irqs_ready or stat_offsets_loaded. Reverting irqs_ready to true
> after it was set to false during interface teardown can lead to a double-free
> of IRQs on the next down operation, or missed interrupts if reverted to false.
>
> [ ... ]

The bitfield sharing comes from 0ab54c5f2fe89 ("ice: Use bitfields when possible").
This patch doesn't add a writer to that byte; it only changes where the printed
speed comes from, and the unlocked current_isup store in ice_print_link_msg() is
unchanged. The race also doesn't depend on ice_print_link_msg(): the service task
writes stat_offsets_loaded via ice_watchdog_subtask() -> ice_update_vsi_stats() ->
ice_update_eth_stats() without rtnl. It predates this patch and is outside the scope
of this fix.

>> @@ -1188,23 +1190,32 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
>>   	old_link = !!(phy_info->link_info_old.link_info & ICE_AQ_LINK_UP);
>>   	old_link_speed = phy_info->link_info_old.link_speed;
>>   
>> +	/* don't drop an event that the refreshed link info no longer shows */
>> +	changed = link_up != old_link || link_speed != old_link_speed;
>> +
>>   	/* update the link info structures and re-enable link events,
>>   	 * don't bail on failure due to other book keeping needed
>>   	 */
>> -	status = ice_update_link_info(pi);
>> -	if (status)
>> +	err = ice_aq_get_link_info(pi, true, NULL, NULL);
>> +	if (!err) {
>> +		link_up = phy_info->link_info.link_info & ICE_AQ_LINK_UP;
>> +		link_speed = phy_info->link_info.link_speed;
>> +		err = ice_update_media_caps(pi);
>> +	} else {
>> +		/* read failed, keep the cache in sync with the applied state */
>> +		if (link_up)
>> +			phy_info->link_info.link_info |= ICE_AQ_LINK_UP;
>> +		else
>> +			phy_info->link_info.link_info &= ~ICE_AQ_LINK_UP;
> [Severity: Medium]
> Does this code introduce an unprotected read-modify-write operation on the
> shared link_info member?
>
> The driver's service task handles link events via ice_link_event(). On this
> newly added failure path for ice_aq_get_link_info(), the code performs a
> read-modify-write (RMW) operation on a shared structure field:
> phy_info->link_info.link_info |= ICE_AQ_LINK_UP;
>
> Concurrently, other execution paths (e.g., ethtool callbacks like
> ice_set_link_ksettings() running under the RTNL lock) can trigger
> ice_aq_get_link_info(), which unconditionally updates the same
> pi->phy.link_info cache without holding any locks.
>
> While the commit message acknowledges that accesses to phy.link_info are not
> serialized between the service task and other contexts, adding a new bitwise
> RMW operation on the error path increases the risk of tearing the link_info
> byte or silently clobbering concurrent state updates.
>
The store only happens when this context's link status read failed. Losing
a concurrent update would need another context's read to succeed at the
same time and land its store between our load and store of that byte;
the worst case is a stale link_info byte until the next successful read.
The commit message already notes that phy.link_info updates are
not serialized against the service task, including the event state stored
on a failed read. Adding that serialization is a broader change,
outside the scope of this fix.

Both of those issues are problems preexisting before this patch.
I do not want to fix it in this series.

--------------Yk5vQynM2jpGHuGys7rvei62
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/16/2026 1:26 PM,
      <a class="moz-txt-link-abbreviated" href="mailto:sashiko-bot@kernel.org">sashiko-bot@kernel.org</a> wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:sashiko-outbox-174243@kernel.org">
      <pre wrap="" class="moz-quote-pre">Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
- [High] ice: data race on bitfields in struct ice_vsi causing state corruption
- [Medium] ice: unsynchronized RMW of phy_info-&gt;link_info in ice_link_event()
--

commit 35fcfc2f1fd4d9de2d01f00551ed70ac2dd02bbf
Author: Jakub Kaminski <a class="moz-txt-link-rfc2396E" href="mailto:jakub.kaminski@intel.com">&lt;jakub.kaminski@intel.com&gt;</a>
Subject: ice: Fix &quot;Unknown bps&quot; during link events

The commit refactors the link event flow in the ice driver to use refreshed
link state rather than event values when the status read succeeds. It also
safely caches event values on read failures, introduces ice_update_media_caps(),
and updates ice_print_link_msg() to take the link speed as a parameter.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c26cef0214552..ac0867ef812a0 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -844,8 +844,9 @@ static void ice_print_topo_conflict(struct ice_vsi *vsi)
  * ice_print_link_msg - print link up or down message
  * @vsi: the VSI whose link status is being queried
  * @isup: boolean for if the link is now up or down
+ * @link_speed: current link speed value to display
  */
-void ice_print_link_msg(struct ice_vsi *vsi, bool isup)
+void ice_print_link_msg(struct ice_vsi *vsi, bool isup, u16 link_speed)
 {
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
[Severity: High]
Does this function trigger a data race on the bitfields in struct ice_vsi
that can cause state corruption?

The current_isup, irqs_ready, and stat_offsets_loaded bitfields share a
single byte in struct ice_vsi:

	u8 irqs_ready:1;
	u8 current_isup:1;		 /* Sync 'link up' logging */
	u8 stat_offsets_loaded:1;

Compilers implement assignments to these bitfields as non-atomic
read-modify-write (RMW) operations on the shared byte. This function
modifies current_isup locklessly from the ice_service_task workqueue.

Concurrently, ice_vsi_req_irq_msix(), ice_vsi_free_irq(), and
ice_up_complete() modify irqs_ready and stat_offsets_loaded from process
context (e.g., ndo_open/ndo_stop) protected by the RTNL lock. 

A concurrent RMW by the service task can silently overwrite and revert
changes to irqs_ready or stat_offsets_loaded. Reverting irqs_ready to true
after it was set to false during interface teardown can lead to a double-free
of IRQs on the next down operation, or missed interrupts if reverted to false.

[ ... ]</pre>
    </blockquote>
    <pre>The bitfield sharing comes from 0ab54c5f2fe89 (&quot;ice: Use bitfields when possible&quot;).
This patch doesn't add a writer to that byte; it only changes where the printed
speed comes from, and the unlocked current_isup store in ice_print_link_msg() is
unchanged. The race also doesn't depend on ice_print_link_msg(): the service task
writes stat_offsets_loaded via ice_watchdog_subtask() -&gt; ice_update_vsi_stats() -&gt;
ice_update_eth_stats() without rtnl. It predates this patch and is outside the scope
of this fix.</pre>
    <blockquote type="cite" cite="mid:sashiko-outbox-174243@kernel.org">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">@@ -1188,23 +1190,32 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
 	old_link = !!(phy_info-&gt;link_info_old.link_info &amp; ICE_AQ_LINK_UP);
 	old_link_speed = phy_info-&gt;link_info_old.link_speed;
 
+	/* don't drop an event that the refreshed link info no longer shows */
+	changed = link_up != old_link || link_speed != old_link_speed;
+
 	/* update the link info structures and re-enable link events,
 	 * don't bail on failure due to other book keeping needed
 	 */
-	status = ice_update_link_info(pi);
-	if (status)
+	err = ice_aq_get_link_info(pi, true, NULL, NULL);
+	if (!err) {
+		link_up = phy_info-&gt;link_info.link_info &amp; ICE_AQ_LINK_UP;
+		link_speed = phy_info-&gt;link_info.link_speed;
+		err = ice_update_media_caps(pi);
+	} else {
+		/* read failed, keep the cache in sync with the applied state */
+		if (link_up)
+			phy_info-&gt;link_info.link_info |= ICE_AQ_LINK_UP;
+		else
+			phy_info-&gt;link_info.link_info &amp;= ~ICE_AQ_LINK_UP;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
[Severity: Medium]
Does this code introduce an unprotected read-modify-write operation on the
shared link_info member?

The driver's service task handles link events via ice_link_event(). On this
newly added failure path for ice_aq_get_link_info(), the code performs a
read-modify-write (RMW) operation on a shared structure field:
phy_info-&gt;link_info.link_info |= ICE_AQ_LINK_UP;

Concurrently, other execution paths (e.g., ethtool callbacks like
ice_set_link_ksettings() running under the RTNL lock) can trigger
ice_aq_get_link_info(), which unconditionally updates the same
pi-&gt;phy.link_info cache without holding any locks.

While the commit message acknowledges that accesses to phy.link_info are not
serialized between the service task and other contexts, adding a new bitwise
RMW operation on the error path increases the risk of tearing the link_info
byte or silently clobbering concurrent state updates.

</pre>
    </blockquote>
    <pre>The store only happens when this context's link status read failed. Losing
a concurrent update would need another context's read to succeed at the
same time and land its store between our load and store of that byte;
the worst case is a stale link_info byte until the next successful read.
The commit message already notes that phy.link_info updates are
not serialized against the service task, including the event state stored
on a failed read. Adding that serialization is a broader change,
outside the scope of this fix.</pre>
    <pre>
</pre>
    <pre>Both of those issues are problems preexisting before this patch.
I do not want to fix it in this series.

</pre>
  </body>
</html>

--------------Yk5vQynM2jpGHuGys7rvei62--
