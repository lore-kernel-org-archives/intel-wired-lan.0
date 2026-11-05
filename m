Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A607606A31B
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Nov 2026 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=HcAYNO8+;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=he/uYQlb
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE8B6406DE;
	Thu,  5 Nov 2026 18:28:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qw3GL83ABNjd; Thu,  5 Nov 2026 18:28:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 52B364076D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793903297;
	b=p3x5T8btRIQGiyP6PS6M5a/t1a5btruA7lj7Ye6xPrBsYe+pyevAYN8ZHPztqkTZlnMa
	 bQ9ZUVawAyf/tcjjU5nWT+8MZVwRfNtAU9RPMQ9Gt2t5FF5BF+BaY8eFXhC68TxSeYxTt
	 /eIFb/rYIT62RrwN57jHQ88AKDvImJmiisZXBW4KtExPXGdmuOU2YQeDn2RHH8mTbSX/c
	 QIsnICJo++qPmIgOhZ2ZDuvllYssetY0AMwH9A5NVU3BHlqnC40vrf3c23Gmd3TaNPp2n
	 6JkSBRFzvxiTB4k7V2cjD5jOrU45wKzj7lUZ9m7kG5Qdq01Tju4FIVEHWFqrEbZQr1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793903297;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:CC:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
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
	bh=mCEN03ffbgMv7inepuS6ToKtQLOiv+Np7/KuErrq1Hw=;
	b=nMn5q30qTNqlXiMKAWMeXN+wSNaPDuWa3II7wHKBTuANYhtLg6EG8+ssG4reI4og2JwW
	 RTHKSodQbPV/TOA4nAbdRN15FEItLuqVsgyQwiUyPZrPzkiPI5e9LblzKRPOOAA4Z7eHA
	 pSkoHEoNpje60VpTHIm06ltuDI9sOBW/ZC/2stFLsTMWl+2JN+5iaJ4JaJf7/4KvZJh1Y
	 0EZsBJw5e1A9yx0pJy+p2+UJ/z5gax8rQa7qUUhkehrZiO1Wxp1VyE4m0xNUfeQk6wtjh
	 VbSlpNgdE7legaRmCZ2gVIwxyTgr4JUa+p+jqJxzXzDJHdBq69eF549D4TOFBuq3lDQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793903297;
	bh=mCEN03ffbgMv7inepuS6ToKtQLOiv+Np7/KuErrq1Hw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HcAYNO8+G4XYwvCYoT417vIwygWc4aG8RU+BV0iiFVuwwWdjnN/EPQEEtU3JQrhji
	 LHVzWiIDoWe46XJKzo1tO1eQWv5Nn4yvzb3OI1ceSLvdgHUTnsGxjcCjZhodZXo9DF
	 5VShbC0gi6RJkgH6JjaQlDV/Vv9h6siq6Hj+UYziicsDOyN5RsBeRCja1S1NNpVPzW
	 fade5kFpjYh3hZmEjPaTCL5gisd3tXceOijCx3FAfsgzQHtPJT6MzNwYMsdrj8GG+H
	 lJxrKsNwl/9KRbTi9rDXmAHheWKIjpZvJrpFwwngMH4Unf4rP/dUCdevfKIhW94Z/O
	 2HAvfvmNSfp0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52B364076D;
	Thu,  5 Nov 2026 18:28:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7B71952B
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 18:28:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 559F4400FF
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 18:28:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 95TYEog3xMQ8 for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Nov 2026 18:28:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 95E1640012
Authentication-Results: smtp2.osuosl.org; arc=fail smtp.remote-ip=198.175.65.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=he/uYQlb
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 95E1640012
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 18:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793903295; x=1825439295;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mdPeA5XTjk/eQDtzEIYDjha2NRis1acqXEL10DpVNNE=;
 b=he/uYQlbHhKLxmj4XGCDq6g4bzMvRRxMasqtFLuL+jZaqoOr4QLCwnj4
 kx/FdJJKALkNE4Zp7glz+lzleiIcKcnvkBCCN8J01qKiT+ZwIWIn9VIHM
 2KAGdje4MmKei3K2eRTYqe3KY6TphcMnMWOG6wKLwOcH7NSkCH0ExMvVq
 MOxmIdnC3R9SXQ0xN6pQYcwGpfXIAUapF+XzStBQltX0DGala928A3vKN
 DkklaBPOYY1S9ckWou5cwafW33I0LffnYFB1T29rG6YcPDof+DzegeZ6c
 d2CGRWlMLBYtODEkoo++PJAn6bIMm46K/REYpeaaaPkXLhOiN9/IC3ubx g==;
X-CSE-ConnectionGUID: 8eyPrg3tS4SUVwkHKoID7w==
X-CSE-MsgGUID: KDCs5RL8T1GzOcuXgRCiNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2731807"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2731807"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 10:28:14 -0800
X-CSE-ConnectionGUID: 12TpHrFnRXGuMMaJsWttrQ==
X-CSE-MsgGUID: e56VR+fQQHOpOIt/4EAfvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7399726"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 10:28:13 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 10:28:12 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 10:28:12 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.0) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 10:28:12 -0800
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by LV0PR11MB945601.namprd11.prod.outlook.com (2603:10b6:408:606::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 18:27:52 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0569.011; Thu, 5 Nov 2026
 18:27:51 +0000
Message-ID: <052ebb43-40af-4b34-a2eb-9e04822f4526@intel.com>
Date: Thu, 5 Nov 2026 10:27:50 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v4 15/15] ice: support up to 256 VF queues
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Petr Oros
 <poros@redhat.com>
CC: <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, <intel-wired-lan@lists.osuosl.org>, Simon Horman
 <horms@kernel.org>, Michal Schmidt <mschmidt@redhat.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Brett Creeley <brett.creeley@amd.com>,
 "Ahmed Zaki" <ahmed.zaki@intel.com>, Mateusz Polchlopek
 <mateusz.polchlopek@intel.com>
References: <20261103141646.303620-1-przemyslaw.kitszel@intel.com>
 <20261103141646.303620-16-przemyslaw.kitszel@intel.com>
 <20261105122558.1701877-1-poros@redhat.com>
 <a0257569-faa7-4ecb-9488-077f674781df@intel.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <a0257569-faa7-4ecb-9488-077f674781df@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0285.namprd04.prod.outlook.com
 (2603:10b6:303:89::20) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|LV0PR11MB945601:EE_
X-MS-Office365-Filtering-Correlation-Id: 4875c83f-0539-465c-829c-08df3b6a8040
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|11063799006|261022105027099003|56012099006|4143699003|261026140227099003|261028144727099003|261026121527099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Wk/Ic7L2wsmIMOrV+LMzN8rUn5csPXxgPOq56q5BWsrA0s/JD42DG2sBfJrmZWiIfQdnaW9RkLkW91Jnu2q0U/Ind+W5tsuyFTUxUOFCGE8WJE2I6dNtix3gyVibrUSmNtSXRxXVPH1VgXYAkI46rQa5JsJmT9TiJ6fuuGetqEmmoxLB9LSmR1yYf7fOMYCY0XePmulx1r/NjVxz0MpQAbjmJMkHIuyPt47oS2fhAmP35sB5q8ClYYXl0TuK0EQlKaKD7eW+6s07zsI6WiJzoThQd38dZQhE3PqOGi30tvSMa4+jaEP+2eQWtpwT3IP4RS6r11FXJl7Jb8JnMISvsKpXJ5/oLFYtUzHSOKapUlh5QJ1kUCeGFEKbnyp4TgbmRXGJPrBzBpBiyqjuxXFRw29NrqAjQELh9Eu8jXPHz4wkRDnVIbzxeg0jzJLP3xneVl0XsPkWs5GDsfYMg8H6hlNx2kigpuEHSwoNGIivA0V+MPZ2qStsZT4xSz0+Awz0GhfqzSpGkFJv4oQeKffiHyf3caj0yy6n2Xp0iJJ2v21sV2XnxU42vTXGVqY0aqlSf1EUU2XOs6vKBlFtjvm3zN8RGLkfjtDGFLJsQLfxhnjL+el+uSNRlxj2NZe9QnQy2AWuKvdApHAacXhE1I5d8aiQlVABaMxSWc4ffirRhx4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7381.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(11063799006)(261022105027099003)(56012099006)(4143699003)(261026140227099003)(261028144727099003)(261026121527099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlFFNXVna1Z0RWtTMXgxR0hMOXZVdE90REZIVGxEUndCUTJrdVNVN00zamdR?=
 =?utf-8?B?NDRBK2V3K3p3SHByeXN0N25iTCtiRjk1NWVUeElUaU1MbnJpVGw2Z20zMk1h?=
 =?utf-8?B?dDZaQ3puV0FwK0dPTUg4SFZIRGZ0SFhZengvOGszTXJabkVsZFJZOSs2U200?=
 =?utf-8?B?RHFlQVlNUWE2Vk1ydzRBbW1sZ0RNYm94ZmdBUzRONHZaS2VFZ2diZXdKUitM?=
 =?utf-8?B?dXROcjhRUXNxOEhEaFZTYVpDOVJYYXE3NDYvWjlJc1FNL252NmpsUFEvZUhD?=
 =?utf-8?B?VnBoTFpyUWlIVnlRUW0yVzdRODhDcVFHWnp1bzRjNm1DbEJqcjc4cHVIbDBa?=
 =?utf-8?B?aXV0V0lWbzU5Tjk4N3A2K29BQi9DdWk5Sm94RnhJdkNDbFgyL0ZXRjBTNDl6?=
 =?utf-8?B?Tyt3K3RnNUoyaG1ZQmtkem1YdFppay9HVTJycHlMRTFNUkVVdGlpMEY1ZWNO?=
 =?utf-8?B?QVpGeXBvVXkwVWx2cGFQQ1NUbTMxL2JkRVZkRzNsVUpFZ1RYS0k0b3gzS0FF?=
 =?utf-8?B?U1lRMjVySkRIT0NTaTBFdUFkbjh6ZndYVzllOC9DR2pKc0tzVUhXaWhNZG5Y?=
 =?utf-8?B?YlF3cWp1R25TUlMwWUZoZXhFV3N3b1B1SEtyTklWVHQyZ1p5QlJNejc5bjV5?=
 =?utf-8?B?WWx4RHByVEVVbzFwUXMxUG9mYXJyUnBYVEVDOVE5MFJ2eWJiYVBkeWZlRFIw?=
 =?utf-8?B?TkxSQU1oT0hVZVUxQjBCR2NjS1praEo0QmNkTXJMRkJIT2NRQ1dBakthU1ZX?=
 =?utf-8?B?aHlRYmE4eHF4aEh1dXNnalFzMTh0ZG9uVTJINDhKd3NJTDREd3JCNEpKc0w3?=
 =?utf-8?B?QVdrVi9IQ2JkU0JET0dDTFpaMStDdW1Qb2ZyQ1dheTVJdE9kQTMwdnF4Zk51?=
 =?utf-8?B?eU1TTGN2THVFN0xqOG80K2dZbTRDak40L0pGYUlveGNMS3FJZmZoOHdRY242?=
 =?utf-8?B?Sk5HWUYxWHQ0ZHJxcTZ0NlIwbG5HUlNkZmhxZ1FTYzV1ZzM4ZkprMVY5aGFR?=
 =?utf-8?B?dnlLNkZCbmZsbmJuTFkvdDdDamdXT2p1WGtoa3VZZEVUb3ZRdmdIaTJBaVZp?=
 =?utf-8?B?RmwvVDJZbW03QmhvOFdJWjcrRHRnV3V1WGEyaXZZbnR6VzA0UUtidGJmRUVs?=
 =?utf-8?B?cUhJWWxPNGxNWlY4UGU3cTBJWGpubTVoRnF3TElickdReWpqZlV4MWRYYWNG?=
 =?utf-8?B?MUpCRVVHMDZCdWxDeVNSMExJYlNkK0hBMWFGeVJuZ3FGMXV6djg2Q2RhWDFG?=
 =?utf-8?B?c2kyYVNjeHhOakZnVzZDK0FWR0xrakVRMnBwTGUzVi9qdENrMHY3SWNyUnlL?=
 =?utf-8?B?eS82dmJxaUxvbWs3LzNCdTdhdFRBb2tqOGhiMXBHUDllNGpnMWN2QWtIcTlR?=
 =?utf-8?B?VFV4emo3dWZqQ1k1V0JLOW5YdDZDUU5CZDlHV3Z5eXluMkdYM3JjZlh5OEYr?=
 =?utf-8?B?LzVBR3lzSGU0bGJ2ck15VXpHc1BTNHNrc0c3eHRjZmtkSUlOLy9XejhIUzFU?=
 =?utf-8?B?K3E2NEh4OWd4MXdZaHJucUJsT01mMzM2OVRzcVRld2k4Tm5ENGRYOGhrc2NI?=
 =?utf-8?B?QlpUUzh3bVplMDBSejlLd0p5Kzg4Z3cxM3JOQndOeWVQWS91a05pSlRQMXFy?=
 =?utf-8?B?SDRYRndzVmRKQTloaEIrTkF0Y1Z3US90RFlSMW5WekJ0R25KQnpzYm02MXZJ?=
 =?utf-8?B?QkFma1dwdnYxRXByT0tnQTZ4M3g3aUx4Nlg3Sll1eGtHaVpydTVrQ2hTckVV?=
 =?utf-8?B?bmh2SzhJMkdqbXk0TzluZDIrSURraE5LWDRXZktTelRWMzdEMm1VTDdqYmRG?=
 =?utf-8?B?alROVUNxREZBQnlMMkJKdXBNTUVtTzNKQWN5QnBHRHBLNG0yQ3k1bm1ZOHUw?=
 =?utf-8?B?bTg3OUxjQVR3cHJhZ2hqSjNPbXlPZ2lKdStQMHhkU3hHeUhSbE5MTGxlRzIv?=
 =?utf-8?B?ZlplZ1NGWlJrNmJKYWFPVUdXRnhIc1VzS25vVUdxejJxV0ZlczRNRHpORGJU?=
 =?utf-8?B?R0kvSUxhV2I0MXFvTW1rRzVDWnQ0RXVuc2R6QWxSVmhnMkJsY05WSXdUangx?=
 =?utf-8?B?SWFQRmRjUXZEVG9ya2JvOFcvTXMzdEN1ZVlmVUljWTVZVG9yK2tTU2VzM0J1?=
 =?utf-8?B?STEwbWhLN3cwcGNONWx3bnU3b0NNRlpYRmkxL0JZMTFhNkhtSm9JdEs1N2VI?=
 =?utf-8?B?Syt0VUhkQzBRWkQ0czVwVEp1WU9YTk45M0lSTlNKV0tIaW9pZ2hlaEVlb3Jt?=
 =?utf-8?B?c1Rub1RzNEJuQ2hBY3lrbndJKzBvNmlrbTlXNnZ4Vzl3ai9nYVErbDVNdE1E?=
 =?utf-8?B?SWp2WVo3cDR5RjlCV05SQmNRZjd0M1VEVjgzY3NhNXBnZnZLbXB5dnhrOUdw?=
 =?utf-8?Q?0aAfHA8xKOJnjH3o=3D?=
X-Exchange-RoutingPolicyChecked: fhcVbgypOvN3RBC46+XEHyD2FnnkQ9lvk2fnihk2LefrKevDgHlST96qVFmDIDQFZEYrtyQooOUPMwNUFyZ1W1IJx3lFwbEU1Wi9VJvTDLEVVJZBXDUWpw0mFnm0lAsJqT5tHnLc/HNtvXfjdOFKD6Mh5gbYbYBMSmJ527jD806d9K4BpAvliRBMVBcfy++p1JswmZFtkI08RtmtAPElMU+06AvXoXjla50H5Ds/EzJyt0/WR8R9Nmae39i4YmJaf5e4XcoeimWwffD1eH0ir+OPSw8cyks0fHZAyCnKbTQi7Av1ALV+K1SlIFFmafox8yhWj0HgO86yxXz2c+pCLg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4875c83f-0539-465c-829c-08df3b6a8040
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 18:27:51.5781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ncvJSaIHnNH9/6+s/RFLjOH5WrDoUGFCs8WGi1rJJ36bdHOH+a2LUqBg/K6lHVttAqEVJeO/zRsYU0iRg8nLZ5f9huS0tYy4O4XVS/IvVlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR11MB945601
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/2026 6:18 AM, Przemek Kitszel wrote:
> On 11/5/26 1:25 PM, Petr Oros wrote:
>> On Tue, 3 Nov 2026 15:14:56 +0100, Przemek Kitszel wrote:
>>> Add support for up to 256 VF queues. To enable more than usual 16, user
>>> needs to assign GLOBAL LUT (devlink resource named "rss/lut_512") for 64
>>> queues or PF LUT (name "rss/lut_2048") for maximum of 256 queues.
>>
>> I ran the whole v4 on an E810-C for SFP (4 ports, 10G DAC between two
>> of them, FW 8.1.1 with mgmt API 1.7.11, DDP COMMS 1.3.55.0) on top of
>> net-next 7b6ab4dbc156 with lockdep, and again with KASAN. The
>> documented flows work as described: PF and VF LUT assignment, 64 and
>> 256 queues on a VF (also with 65 MSI-X), VF FLR, iavf unbind and bind,
>> PFR, CORER and GLOBR restoring the default assignment, the ADQ
>> exclusion in both directions, 16 VFs taking all 16 global LUTs, and
>> teardown with LUTs still assigned. The two problems below come with
>> this patch.
> 
> thank you a lot for trying this!
> next revision will be needed
> pw-bot: cr
> 

I'm not sure our Intel Wired LAN patchwork yet supports pw-bot, but I've
made a note to ask Tony about investigating what would be required to
add support.

I've updated the IWL patchwork to mark these as changes-requested. Thanks!
