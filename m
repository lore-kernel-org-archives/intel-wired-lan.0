Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5984E606A32F
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Nov 2026 08:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=5zO7Lhhp;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SvJpmIlS;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=gfdd1/zP
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A17E811A2;
	Fri, 27 Nov 2026 08:45:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t5plTUqAq-D4; Fri, 27 Nov 2026 08:45:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 92A66811F0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795769113;
	b=swfD/ulenY92KADz7FxKUw2owTtAEf3OKirmNrTam+b0Bj5cZAb5ym338wc11AsOzXb3
	 Q83W1DRiC4fYq9DKFauOUq21mDQ5QHIlYVDbNyKDy/ZgnA+oZBuL4Llh6l4qTl/0Cc6vB
	 pkpwneoK9ssutEghpsn1UyuYX3sO5J2c57XLKO2b44KiH97lGqI/Pc7Aan04HQm5ryCKB
	 6wEH3BU0eGSL+yQRd0S3xBHw5axuVF/yJV+TOPPWrrK5lV//+s/8ebxaTpxwrNT8BYewx
	 F0V4ph8+I9kcr6M5CmzYK8j/YIcZoSUms2pPJZYCACTPKaOWCUXelAdKzYsidZSKapA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795769113;
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
	bh=dWIOjOKBxZgLpZEqwFlhm9JfTP/8AAEyS4G2cGr/AKo=;
	b=n7moOYapISOX9sClvRheliABDA8FnCusdr2Podu3XTmS2DUOOzdRGK866w/LCY7b9/OC
	 CRQsD9ovzzMvNE4nsZVhE7Hqx5ewxjiycsYIQEJ0fo/m4Q38U8rMUJUtfa1FTzRGwMJqa
	 GyPBl9T23ndUEdY/PG4+nw6yru1yDC2QYlGX9beXp9bEU+zBiN/G2jRr2B38W89kwRfAo
	 KmZey+ZA1hP+3TDCg/TZiB468iNdsiVzFDVJ3JsS0AU42Vkq1HEm95l6/STIbJR28ZcSH
	 we8QBR1EBVkHjw5FfAZ5Q9tvEP5pI7n12LwE5cX15Lkcreu3YwrjI+1Ao2W31S4A3qg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SvJpmIlS;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b="gfdd1/zP";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795769113;
	bh=dWIOjOKBxZgLpZEqwFlhm9JfTP/8AAEyS4G2cGr/AKo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=5zO7LhhpOesUhrR274xogSN4GBSywI2g9AJ65COK6w28h+rQZxC/qciNM6XHiGxOb
	 OhtAw6Jaq61k2zxtUv17PSw8YgriJyCH6FSvNw14Bj2P9tHQOe1/rrVU8+JY1i4gHy
	 W9r3/7sRqgIfzdt1OllP3pfUCqkVqqhESdv9kuvQL1HzBLLMRjLYW6vOlQ05XDWLh8
	 yeiptmzmHKdP96+hf+J4yJkKTH8XRXxyEa/IlyPk8cC8WTUfUu7qKW+SqNR9lfJ7rh
	 lyu8aiJK04cTE+0kEfXeeMmyBfSYJV+zIVlAQSQ9AahduAmvGdmYN0qXDC1PE+isee
	 +RvrisWVFOVXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92A66811F0;
	Fri, 27 Nov 2026 08:45:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0AF3D3C0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 08:45:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E3EFA811F0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 08:45:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nG1oJoerfsG0 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Nov 2026 08:45:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 78E5481184
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=SvJpmIlS; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=gfdd1/zP
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 78E5481184
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 08:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795769110; x=1827305110;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ceI2I2nTZG6lvwJGxFEOYF9+eqsprYFyzQIBTOGXvMM=;
 b=SvJpmIlSg+I+Z34DNUIXw0PP1RYrjGrjUFCAbbcBL9f4MhOlsBz0/P39
 VZlHDKMtBMU62nsNk5tMkvCsawvXbweIhbq2YR3N4kjOZUc/gcQAqE+42
 TWfkn73yzXtCbwQOJMr5FWVj/KC+KZIjJ7lS1EjYxbYhZqoYZPvMjxdne
 4msGLJSQw93lnGJ0ArIHfdLws+db4g/jNzERLOpUPB5SZUrfo/E5+XSLq
 wq1Ie3x/ntB5qsuhS6kfcy+oFH160SomEQs44r0hkKmmxjOw1e+/41qbU
 LdKI53dquMImdL9wyaoBmXv8QXPBNBDZdQCXEqNr+3MEgPvr3c+63XCE9 g==;
X-CSE-ConnectionGUID: LaR3ZxG7SX2UWxrYvrwvuA==
X-CSE-MsgGUID: POBM0CQ1TAanIIuPLqgWgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4565228"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4565228"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 00:45:08 -0800
X-CSE-ConnectionGUID: /QHvTakESWaSdvcHfPo8zg==
X-CSE-MsgGUID: caCgdDNBQnqtvEbQhn1Smg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; d="scan'208";a="12654984"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 00:45:08 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 00:45:07 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Fri, 27 Nov 2026 00:45:07 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.54) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 00:45:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWIOjOKBxZgLpZEqwFlhm9JfTP/8AAEyS4G2cGr/AKo=;
 b=gfdd1/zP52DGxBxzLFD2gVcxk6vpweFERlQ2tJ8mU+slUEGwaNZBMgz6gmAJzAUbNQZW+pwzyugvrOas62Zhy1CqEUtjLUggcnfnZcgGBapxsNUcGfv3frJSASO6nBdp/k6vzQMaoTPUhYYkUpYZt5QPfatiHyAdkmXSRMIOgvw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by CY5PR11MB6164.namprd11.prod.outlook.com (2603:10b6:930:27::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 08:44:58 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 08:44:58 +0000
Message-ID: <43e42e0e-d099-47f0-a4ab-965b6e936a75@intel.com>
Date: Fri, 27 Nov 2026 09:44:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] idpf: fix vport_id used as array index in MAC filter
 async handler
To: Hongyu Guo <guohongyu@cmss.chinamobile.com>, <netdev@vger.kernel.org>,
 <pabeni@redhat.com>
CC: <anthony.l.nguyen@intel.com>, <andrew+netdev@lunn.ch>,
 <intel-wired-lan@lists.osuosl.org>, <davem@davemloft.net>,
 <edumazet@kernel.org>, <kuba@kernel.org>, <stable@vger.kernel.org>,
 <13057616121@163.com>
References: <20261126020854.233971-1-guohongyu@cmss.chinamobile.com>
 <20261126092627.255454-1-guohongyu@cmss.chinamobile.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20261126092627.255454-1-guohongyu@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0199.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::24) To CH3PR11MB8496.namprd11.prod.outlook.com
 (2603:10b6:610:1ba::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|CY5PR11MB6164:EE_
X-MS-Office365-Filtering-Correlation-Id: 1902e526-8b58-4dde-4fdd-08df4c62b768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|376014|366016|261028144727099003|261022105027099003|10067099003|261022113327099003|4143699003|11063799006|56012099006|261022075727099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|261026121527099003|261026140227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9DbvcXDARLIalaCGLuAmYi2bWoYTJEG8WD9wjafg+v3Sf0CRsddPVmlaFBltFqZhzzcMsXi7haKYAn3aaMh/SC9g+sc7hAKBCNt9r56NtgN1jphrMAnranGzfngRIrAFGdMdV7GrpPPNvmeUbGcifXaw3HhFEwNotTD4ev2UW8HBrSJUqE09zYfCxN7+FaP6rEN4MZJXyGv0FAuBvvSvJRL2Ab/8u6Ngn6Ha9lG40orgtgZ2xJlYpFK85ySOvEZhClkTzm5yXqa1aJ+UjKqH2NGDcHsvuyrtEc+sf+CeDlAsVXhnhYtGUtqPu4r8pnRBQlaCCBIwQRe6LWomTmFtIKDGx8p3nDHpRosm1VYsFRIcuj4lZ2kdGXLY6UmDEzEpVoZENGEwi+XkSfLaq4T+lPxsd4SFsWs6NhNCsP9dBhgIHnAFbdJFz2ppMaj6PTaDtQ8XgBqbzBO8aFZZUAiWe1UbHz9GMwIzsep3118+gZbPkSMOKn+jN02lEq2kR4u7dlBaBKXhXVjUsHRUkK/wqyBdIdynSHbVZe+X+WNUsAJhzQIybbQMEKadR/Wbjc6VqX5NV19acd5Z2SnpOBXEVsbb9Ik/n+2kCthnfKsvZjT/NKW7Tbqww2AaKBNgBedFk7CHhV9Em+RC+ze4yy/pmPhPfxmHtY5CLKcMNuEnS8k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(261028144727099003)(261022105027099003)(10067099003)(261022113327099003)(4143699003)(11063799006)(56012099006)(261022075727099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(261026121527099003)(261026140227099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDJMZDhGMHlValpBWkRCZEZpc09KeXZRM1Rvc0l2eFh6MlAzOHh0RG5MbVZu?=
 =?utf-8?B?c0NnaWtpT1JzUFpTMWYyQUZHR1JYc2pjZENCY1pwdXRXNW5uTUR4WGx5Vm51?=
 =?utf-8?B?ZkNkSUFkWXhZVjdqeCtPN2pwWU1POW9TR3REMDcrNGJEdCtTdm1PUTRIc2VY?=
 =?utf-8?B?anUzNjJGcUhqZUE3dU5IVUxpRUR5NStnZXYxak1WbHRoQUlTMi9TL0tqb0lE?=
 =?utf-8?B?Sno5WGc3QWJ3Nm1Ec0tWR1pYSWR2RStlSkhCSW05UGxpZ2NvbnRSdWdnTUs5?=
 =?utf-8?B?N2Y1WGNHNFd4dE1UbDJUUU1mekVjMTBpSEdRTit0R2JtK0dBSjd1Z1FVWWxz?=
 =?utf-8?B?VUxDd2FRWENmU2NROWFhZlpkNC8wZ2pWUkROM1lDUnU3d1FKR3pmU3g1Wnlw?=
 =?utf-8?B?Z1ByeWpOM0RFUTZ5dGdvbUdraEFrTENxeEY4bThhSVBBcHo4MTIzLzI5WG15?=
 =?utf-8?B?aWVXdTlHRGdaTW9oQ3M5dDhQb1dtMGFma1V2VDN4VUlSQlptSEhPWXl3Q2s5?=
 =?utf-8?B?b3FxdlRXSzg5M1ZKWXRsbmxOUDNJbGZ0Z3pJcWRDUFh3NnFlempHL0FpS0xT?=
 =?utf-8?B?NGVvVlNTbnZaeTBZN2FVdVlGTHZXL0tVTlR0b25OZklidmRJUm5vWlphTFc5?=
 =?utf-8?B?VkZMSkVETWd1YkJKSXNpR2diYUtKYnUzOS8zWVQ1UERmek1JZnpFaDNxREdm?=
 =?utf-8?B?VlhVVXU0cE85eElsT09oSm9LeG5ibm01VXkwclBkc0Rmait1ZEl2ZnlKV1FK?=
 =?utf-8?B?NnlOR1NtWnBSbzVER3ZRaVIxR095Q3hvV29XTEIwc3VGOE1zWUJzeUdoTk43?=
 =?utf-8?B?eUpJcFFyTmFHNnZxeWtYaWlackxYRlBhdWdXWkpIUnRRaWMrakF5UUFnR2xh?=
 =?utf-8?B?a2JQbEY0cTl3RU4vc0ZERHNjMEhkNVJoL3hDdnRzQnpsL2R6WVlHNzZIVlZh?=
 =?utf-8?B?Smx3NGZrYllOQnd4Sy9ib2NoNklwMkdmRE9WS2RiODBtL2xXemhucFRHTy8y?=
 =?utf-8?B?aHZyMjdKUTNOcmNJY3FiQTViSU1sb1VsNVN3bWIyTlZnYVNKZGV6NXR2WTds?=
 =?utf-8?B?dlFtMHZ4a0UyMEFHQ0FMZlBhTDN4SEY1MzZVOWlHaC94OXdQMyszTTUxZVFl?=
 =?utf-8?B?dGYwWjVxSHRhZk1IVHQzck9oUkY2dk4yYUw4ejYrcWFnelZuYlBWOGhnYloy?=
 =?utf-8?B?UjF2ekpkRlU5K29wYUFHUWk4OFo1Z0luUFIvMDdGVk1Sbk1tSzNhYlFPZjNt?=
 =?utf-8?B?cTNCTEZ0WmR0aDF0Z2Z5bzRieXBSNk5NcEZPb1R2a3JSdlQzQnZIRm5QUllS?=
 =?utf-8?B?cFZ3QkJuK08zSkFGV0twZnF1UFc2Z2x3MFBjVzZZaHVQU25vREovUStPaUV2?=
 =?utf-8?B?aERGNlc5SDkweHJnc0hCQTREazh5TDRKM253cDhNOGdrZmZlMFkzbW11dDM0?=
 =?utf-8?B?dVFBcmpub3BCQUZTdDdrMFBRZVlXeThnbndraTZrZDN1WmwvK3BOVWRNRkM3?=
 =?utf-8?B?YllBcnpNa0RxV0JXaFJKOUdGeStzTHZORmc3Y0VSMEYwajQzUldVTEZZZ0Za?=
 =?utf-8?B?YVI3NUtTS0pqTDNGaXFNL0gxMmhzSENpZFBOSFo4cFhBa1hFb2hGY3VrNGRH?=
 =?utf-8?B?djNBMW0zZ09Lclcvandrc01mbmplRzZxSG91dTUxMUhRdTBIS3dQY0UxOEZw?=
 =?utf-8?B?aWYyaTZYMG1yQU1FY3BmUHViOE85SFJEd2xZck93MnJPZ2MxUFpCYmwzOFpm?=
 =?utf-8?B?ak9obmMwQ1k4bHJBUjdVcUxoeERoSjdqWXJwZU9KdkhDOTcvZ2xBU1hkRUFZ?=
 =?utf-8?B?QmJMSEV1L0ljdTY3U2srYkVVbDF3VkxxanZFN1VvbWNNeHZMOGRhNmZUOVY0?=
 =?utf-8?B?NmZmNkRFZ1lROTczU3BiSXFtQ3FIMGRIUFpZcDZhRlRyR3BzckZoclpkeFQw?=
 =?utf-8?B?aXdGOXhlTVYzT292Ym55cWlJUmxMTmkrUS9nSDRWUnVPbVlJbUt6ank0L2Y0?=
 =?utf-8?B?bTE4YlduZGgvcysyd3R5U3JhMEZKc1U3TU1BSUxocXArbDN6Q0s5dTBmT2Ix?=
 =?utf-8?B?Wml3SmVzMFMyY0dNRmtoVjFkaExvY0llMGZmTElXZEdqWHRaTDZjRUN5Q0hV?=
 =?utf-8?B?a3d0dHJLUGRidGtSd0NNVzFwWUFuOHlBcDYrZUZYcWZkMDZaaXg4Nm5MOUY1?=
 =?utf-8?B?OXpFRmpPRGhYSld3NHMva1RENTRsOS9DZ3hXMGlUQnNvakxmc1dFb2FVcmpO?=
 =?utf-8?B?M2wycStRWUJ5cXFkb2xxMGh0d2hKSmN4TlJ6WkRVazV0Q2RBV0xWQTV3SUVM?=
 =?utf-8?B?S3crcnFrdkdjNVVaNUN6SVhaSTFEdC9JYjJDVE1XZ21KUFdvU0loeVE1bHR3?=
 =?utf-8?Q?vWE+raMRzdwOL6f4=3D?=
X-Exchange-RoutingPolicyChecked: Tpp8i0x25JjxDk6CM5RwKDL3CD/kdj0wEqvMYgT5GyYzbj/9XLjRkYu/sYoTBiXf3d5jbgcS3dMCdfpxvRVL8wHMhAwiJ7nHKOcV84vJTZUTzTKcVmjY97p425xK3UhYUq6ZypHdOZvSEIR2Ci8zrkPorQhAomwMO4Mkq1UsArb/ZYeCReO68rovdVKz5HOHUDa6a7W4Yqwkq/FVtdhNPHrzC4vhqFMaDf60nzglyEjhyR0aNBugUqPseMr+3M3h7nlHjdf9l7idxPs3lylOWgSL4ti4HIe2IEa2TIgXAdKn0JnSFG6rSIDOedZe/+/kvxijd3Xwz1uMfBsOm2OI9Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1902e526-8b58-4dde-4fdd-08df4c62b768
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8496.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 08:44:58.5072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +kC9nIcZlgKaBRrhofo3FCYZcXW4NrB9BQOjEh+SNMRGv/eLZBCElFiRF2TWdD0AruSNgLI1hsNYGhGFxxDDbdCMkQBKmmmquCcF7uRLb1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6164
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

On 11/26/26 10:26 AM, Hongyu Guo wrote:
> idpf_mac_filter_async_handler() looks up the vport with
> idpf_vid_to_vport(), but then indexes adapter->vport_config[] with
> the raw vport_id from the message instead of using the vport it
> just found.  vport_id is a device-assigned 32-bit number and is
> not limited to num_max_vports, so vport_config[vport_id] can read
> past the end of the array.  Use vport->idx, the array index the
> rest of the driver uses.
> 
> During driver removal the vports are freed before the mailbox
> work is cancelled, so this handler can still run while a vport it
> looks up is being freed.  Return early if IDPF_REMOVE_IN_PROG is
> set.
> 
> The filter removal loop in the same handler also leaks: it does
> list_del() without kfree(), and if the response lists the same MAC
> more than once it deletes the same entry twice.  Free the filter
> and break out of the inner loop once it is removed.
> 
> Fixes: 41252855df77 ("idpf: add async_handler for MAC filter messages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongyu Guo <guohongyu@cmss.chinamobile.com>

thank you for v2, next time please post as a new thread, instead of
in-reply-to v1

here would be also good place to put changelog/link to v1
(under additional "---")

no need to repost for any of that (as long as Paolo will merge this :))
Acked-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> ---
>   drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index 1caf52706973..ff43a3d34eac 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -3779,6 +3779,10 @@ static void idpf_mac_filter_async_handler(void *ctx,
>   	if (!status || status == -ETIMEDOUT)
>   		return;
>   
> +	/* vports are freed during removal, before this work is cancelled */
> +	if (test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
> +		return;
> +
>   	ma_list = buff->iov_base;
>   	/* make sure at least struct is there */
>   	if (buff->iov_len < sizeof(*ma_list))
> @@ -3794,7 +3798,7 @@ static void idpf_mac_filter_async_handler(void *ctx,
>   	if (!vport)
>   		goto invalid_payload;
>   
> -	vport_config = adapter->vport_config[le32_to_cpu(ma_list->vport_id)];
> +	vport_config = adapter->vport_config[vport->idx];
>   	ma_list_head = &vport_config->user_config.mac_filter_list;
>   
>   	/* We can't do much to reconcile bad filters at this point, however we
> @@ -3804,8 +3808,11 @@ static void idpf_mac_filter_async_handler(void *ctx,
>   	spin_lock_bh(&vport_config->mac_filter_list_lock);
>   	list_for_each_entry_safe(f, tmp, ma_list_head, list)
>   		for (i = 0; i < num_entries; i++)
> -			if (ether_addr_equal(mac_addr[i].addr, f->macaddr))
> +			if (ether_addr_equal(mac_addr[i].addr, f->macaddr)) {
>   				list_del(&f->list);
> +				kfree(f);
> +				break;
> +			}
>   	spin_unlock_bh(&vport_config->mac_filter_list_lock);
>   	dev_err_ratelimited(&adapter->pdev->dev, "Received error %d on sending MAC filter request\n",
>   			    status);

