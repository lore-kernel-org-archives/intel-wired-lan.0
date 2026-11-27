Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8C9606A31C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Nov 2026 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=K795v7gx;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IuijssLC
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CEF0240A9E;
	Fri, 27 Nov 2026 14:50:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g-3dSVjIdPEp; Fri, 27 Nov 2026 14:50:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5C99E40A70
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795791056;
	b=Mz/Th3AB15YKFeG3534jizyG7uq3WTMPoGiixVnWL9pccdlxfoo69M156bc6dbudz26p
	 GNVjju6CxEyXHby0SbDepEMVOzdUfbA981SmwjwzZCTgy7V1WX7kJLnL+Pwe/WHz4fEHE
	 /oyzf6fy+3MIMRPJJ8sCQfiBAIoDcDUc8HKFP17bNwiPteWIlarRO9HA95H1ifY5qhku6
	 YGByIaEUK91fW06uu1CqEPvrRjjm+z8t5WGM/8Osga32MsxdKpNa045KNGeurh2oFgPnI
	 xaStbbJ6j8607seL9HLnM04Si10PTsrq4VlHDx+EFqvFMdxl/lVQcMGVmuy9LQJ5OYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795791056;
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
	bh=aUd3T02Gc74duTmodEL7iM50DPzhk1ccT05XBht+77M=;
	b=Pyg641/UNiudgFq36cB0CCHB0ORjgnmNdqiP/HCXMMOnlQ0lpJrZ4XGAsnCRQjeihKYC
	 B8VA7uoxAGQHfFFMGJhswm7zag8W+2hvlUhjyIqSS93HhITon2mnDC7IVe0ZtpVQE0JgQ
	 M1pCvHctgQ4mRXnNllOyhXOwYrFlc56isW9nG3BLYHkJAFvFjT+HJu6HvbXrU0xMLjUno
	 gnPdbE2x2ipukBtmhqxvoqx4D2ueFQOompFFnonmxdIqJVF8AYZDm57iv4czMQh1y3Ibo
	 or2ZMyPyYsXn56LRqbAuqFzncLjCqLwOT0zwuB9X4btjNEi8ERVfgMVJnkMITxZ7Fsw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795791056;
	bh=aUd3T02Gc74duTmodEL7iM50DPzhk1ccT05XBht+77M=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K795v7gxk2eF4yqWTHioLXBCb4Lw3rClUQymr56xoDtMn0RHHGlQr0TQQOZAHBNei
	 3ukB0tPSujWLXJDBb4nptq3d1KHHIor5TCs+EP7OTgRgm/IOUMNaPdSOGbz+E0h5DB
	 N898ahCcyeEMF/r5b+o1jX7nbHuPTcBmZ69tEZJ+HlV5lTNV9oxVRlS4uWtzyPrvru
	 wR1inFRd/5qkHKyGPOI2kP8R/8Jrx/l9ghlwskGOK3jsKPNwrfVnglNisYBNlm2GH1
	 x+D488ZMSiziFqcLd57PUtmXsj6JvpjuxRZYYVBEymlVxjqVLW9Ea5694iVeyHnF4L
	 cq6tmp3xMRpSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C99E40A70;
	Fri, 27 Nov 2026 14:50:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AA726373
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 14:50:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8FED460A54
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 14:50:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jJ0sgQTNKwOn for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Nov 2026 14:50:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9BE0A60A51
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=IuijssLC
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9BE0A60A51
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 14:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795791054; x=1827327054;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fnSC2nvMGZ7fvY3oROjbD97/wxW30z9c9EF/yrrlcwE=;
 b=IuijssLCROJJ8Pq60aZrtcKDR5SteWOFOZi0urLSHGXchHNs3Yo72LEf
 VbwUfDLhJgD9kf72CWeG68+33etQz8QfDvxQ92qDrzsl04/RqQh9raren
 5nmF7Fc9r6VsybefD2K/k4xMgHxy8lshtPUASGjVsEYp/IbbWvh7Iw36R
 FRZQUum+vH/3FhOdhS8ieRVup+iP1oWuOjJ2PT0x7Pu1jbGcOAdIUtBDT
 60HBD+DAXbgTpADYv0V0pIxbLLpCzhn5yAG/VfnR2my8K5kKcrPvVWz2n
 S2s53YxgjlTTCU3eRqcBoPY7YHNHj0ZH1jWVH6lGa9NcbGEcdml+4AjSz A==;
X-CSE-ConnectionGUID: zSKJjACeQq27y5YWlx6vGA==
X-CSE-MsgGUID: MXboMnz8RLeRUUUN7FAHOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4614988"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4614988"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 06:50:52 -0800
X-CSE-ConnectionGUID: ykY4GW1VSjGp/4wSDKvgZw==
X-CSE-MsgGUID: Nd8Tk76KTPCJ5W6PeWrP/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; d="scan'208";a="12445261"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 06:50:52 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 06:50:51 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Fri, 27 Nov 2026 06:50:51 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 06:50:51 -0800
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by SJ0PR11MB4941.namprd11.prod.outlook.com (2603:10b6:a03:2d2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 14:50:47 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 14:50:46 +0000
Message-ID: <c0b3a1c9-29ac-4833-84b8-59e5776b0726@intel.com>
Date: Fri, 27 Nov 2026 15:50:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 1/4] ice: stop the service task before the PF is
 unloaded
To: Petr Oros <poros@redhat.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, <netdev@vger.kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Simon Horman <horms@kernel.org>, "Michal
 Swiatkowski" <michal.swiatkowski@linux.intel.com>, Grzegorz Nitka
 <grzegorz.nitka@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>, "Wojciech
 Drewek" <wojciech.drewek@intel.com>, Marcin Szycik
 <marcin.szycik@linux.intel.com>, Martyna Szapar-Mudlaw
 <martyna.szapar-mudlaw@linux.intel.com>, Ivan Vecera <ivecera@redhat.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Jesse Brandeburg
 <jbrandeb@kernel.org>, Rinitha S <sx.rinitha@intel.com>, Aaron Ma
 <aaron.ma@canonical.com>, <intel-wired-lan@lists.osuosl.org>,
 <linux-kernel@vger.kernel.org>
References: <20261127085714.1207361-1-poros@redhat.com>
 <20261127085714.1207361-2-poros@redhat.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20261127085714.1207361-2-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0314.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::19) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|SJ0PR11MB4941:EE_
X-MS-Office365-Filtering-Correlation-Id: 37bc416e-02f8-4651-7224-08df4c95d1ac
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|23010399003|261022105027099003|10067099003|11063799006|56012099006|5023799004|261021123027099003|261026121527099003|261028144727099003|261022075727099003|261021121427099003|261026140227099003|261102123227099003|261009223027099003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: TlbOhaclP0OaDErBqE3gkN1El8k+NSfonSs/3VwKDLHaKYrNVWNgBnh8EJkuKhQbcjDWtxoXh+PsBC77MSQIwpAnf9BFyqo3i80uKqXnO7e911ZltD+VcGLtXvwezZSZnwxbBJOE4DMR4AjjadQ12MnwnZAsGKniyByTzyps1dVtI47tw/WCx0bWNpbgISnu6yJFkU+inIyDwmS09GSa7zirfjDoR3KnolZRBS18vckzaIXH/gXKzAhwB8Eg5745dlaksLCBN8vMAXrJpqTLLj21agN+wl4pP0k/0TKeYysZMNGF9p77cvacG6101wX05KfPud4XfdfMPp7I67dprwCTlIKugod594jTZL1TTbgqWJUEbpuoOfp0+q9bla+Z9MnqBWtQNCN3JKzcEux8G1FITj3nPjo2oM+3SAjAweqIyRudU6ZMPNU76LAkBOhwbDRVrYGUHjTz8tv1U5I4SBt0T7cEScvTkKCvBRm9imJ2yUc0sy7gYwXexiBmiylKafkqEFPADnf9mSuJlOlV04lkhYXqF2BXf3vWwdaHyqsdv795kODFZX5waYfVtEnBEghtBSH4bGlPGj56bQDCqDEoCSEhQVTrb5+Ni7a+p+76IoQCynuZyzLX3iFOFmC/v04eED57LwnqA2izaYAfcuHXcsczOIFuRStzULyH9HA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(261022105027099003)(10067099003)(11063799006)(56012099006)(5023799004)(261021123027099003)(261026121527099003)(261028144727099003)(261022075727099003)(261021121427099003)(261026140227099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUJra2VEdU1mVmFMcFdrS0xhVnpNaFI5dzQwTzV5OVBRcjhBeHhOVlVkb0U2?=
 =?utf-8?B?ajQ4cllkbHlTTDhMK3hyUjluZXJaTExHL1c1VzdQUW5KRW9PWTkyNnYrMWFX?=
 =?utf-8?B?QXdOVU5vQTBuS3UzL3pqam51ZWtmTFl0MXJvamErQ2FsbENZQkFBQXlrRkt2?=
 =?utf-8?B?YlVtbUhER3IyUFY3VTBzR25OSTBQdXpEOXlZb21kekttdGJZVDFFeVZGbEdO?=
 =?utf-8?B?d0xLbHVqb3ZQNVkvVlpici9aN2luRzhHWkdtOVB0NHhZazBHeXVINmx1dkdv?=
 =?utf-8?B?Um1LUm9mRUx6a3V5Wk5VSjdWTXpEc3lyWTdFdHhmR0NjVStuUzM1cVFLNGwz?=
 =?utf-8?B?UGRuQmg2aUkvK2h2SndvbXJSL3lEaWdrKzEvNVlLR01wVFh5UkRnV1ZiaWdu?=
 =?utf-8?B?SU1yVGhudUdkRFdoN1czMjFVbDZUZzlXRVhGY0p3Rmw4a05xVCtZNDV2SXpJ?=
 =?utf-8?B?dEF6cGNsM0pVeDVVc0dENTEvS3hNOFdZZVUrUFp1cU4zL0xCaUdibW02WkZi?=
 =?utf-8?B?cmxTZ2w3a0NvcnhJYVh2am1jMGxNS3lkaFo5UEthdHNjeDBwUUZmQTdRd0Mv?=
 =?utf-8?B?K1ZIU2tTdEtyR2YyZTJZSWEwYnlrSlByVXhLLzZmai8zd1diWXpLOXl0VXYy?=
 =?utf-8?B?UVJsQVhQaFYxSHZCdlp3NHAwdGxHSThYUHFNY3ZSVU9selhzeVVWeFhCOElD?=
 =?utf-8?B?Y1draGxHZFRCdmJsQnlKMXI1TXY0M01BdnR4N1NZdUVaOVFwUTRVVlAxTkRm?=
 =?utf-8?B?UHZLV2ZydFhUZFlCa0xWOTFWNm9tTmR5c2krMzhFWmo4WENOQ0paZjYzc0hu?=
 =?utf-8?B?TVRCV014TGU3S1BHSWhvSks5MmpYL1hCaGpxV1hkTy96bEN6SEV0S3dqb1hp?=
 =?utf-8?B?Z0dJcERvc01wUzN1MWxVS21zeWRwRWNtYmRaL3RvQ1ZBcGJ0QUJrSitnVnpT?=
 =?utf-8?B?V0JqeXJaQi9YSWVFNjJwSXpheG9DQlg1VnFQdWw2NVBGMHRSYkNkNm5UMjlk?=
 =?utf-8?B?MjVOU09NSExpSlREY1B5cnhZTFJCbDNibUVsVTNZdDVoUDZBaEs1TUpuU0hl?=
 =?utf-8?B?MElsamJtT3V1OUN2cTdxOWZSZ2JLOVF3dnZNc1c5czJWeWlnVWZHZXlKUXZ0?=
 =?utf-8?B?UmdBZlVJTUtIWklRbE5GQU01YVVpRisrNHNOQldPbjZyYTRja24xcEFRbTlm?=
 =?utf-8?B?K3ZyaUFhYTB5U25xUyt1b04xYjZzSktLN05xNFNOaDNQeHg1NU80RTZJcjZk?=
 =?utf-8?B?Rm1QdUtIc21mOUpQWUlWUjg0VWFDaUljOWg3RjV0OGtKM2g3d2wzbm9zSy9y?=
 =?utf-8?B?cHdDcDdpeXBDeXdLZG9abzFKV3VQOXpZdFV2SVhwSE5Td0Q4aEdob3FiWTJD?=
 =?utf-8?B?UjZiYm05RTJXYlRHRm5KcDI3dkppbDhlTndGRFl5dWdCekZiU1R2RmFMbHFi?=
 =?utf-8?B?TkJmSWFqRi9wLzVoUFBYcGdrUUdicWxoOG40VjQzNUlyMmdaazluRjd2eVNo?=
 =?utf-8?B?TFdTQ2JOZ1BkekhiYWg1aTRMNWZHTFlTdXd6dWkyeDd0N1RDcnkvaGY2TjlP?=
 =?utf-8?B?NXBtOStrNUNzN2pmU0JtcVNMR0YxdlJyVDRDR3UybWtyTEphb0EyVmRCbjNi?=
 =?utf-8?B?cmlEaWxMNXBSUE1XSG1tZUl6bk51QTB4eVJHUEFMSDlWbU9NNExtaHJ0YVcz?=
 =?utf-8?B?bU02WVNjcUdtcEEwQm1VbE8zemFRdldGUGJEaEwxUWxnVHpwc3hIZVV0dlQ2?=
 =?utf-8?B?RGlHR1hlQkZHajFBeE1qQS9WOHY5VTdRbGovWXBmbDZhQUJ2NFQwdVJPdmcy?=
 =?utf-8?B?cGZSZmtEdFlUMzQwTkRDbm80eVBmYmY4cU9kS3hDWFB2RU5BL0NJdUJPWkhJ?=
 =?utf-8?B?UUhyN1JrSzUyL3prdmR6NGdLOE9XRFZDaitkZjBxWkdUdGlNMGpFOW9Pa3Bn?=
 =?utf-8?B?emFRYzl6czAzNzV3aHEwK1R6TGxoRlJBZXR1RU1EOWZ5ZnNMTW5DWFJqWjV5?=
 =?utf-8?B?VmtvTTdzajIzTlViNnVVcXo5YlVORll3Y2FBUWxNYkZQVGpMbWgxcVczRXFV?=
 =?utf-8?B?TXBDSXdRS2VSOE5HVzZjZ3hMdjN4T1JMUUsxVVNCbDhtLzVKUVhpMU80TFVT?=
 =?utf-8?B?V2cyL2Y0QkhrV2w2UW1sS2NxbzhNUDBPalJNQU42ZEZScUVFQ1VOS3NFSFk0?=
 =?utf-8?B?SmVZMmdFUWNwSjg2R1ZnQ1BGREw5L3huVGVJUkI3cjlVU01Ga1RKUm0xQU5D?=
 =?utf-8?B?UzdBK0FkZ3hTVkFDc2lod0FHUk1EdzF1cnZtSmJaWkFHWGFLaW9Ib1VTRitG?=
 =?utf-8?B?OFhDOXlhZzJVUnhsVXIvOU1weVBEVHRVeis5T09uWHNEakEwOEpicmlxZEo5?=
 =?utf-8?Q?lXAybNCBOEEJqI/c=3D?=
X-Exchange-RoutingPolicyChecked: cXidooGmfFCCslk7VMkl2G+6M2gKlsJ8GUTfSbkWFNf7dWQUB1g1t7neIsLK3Z6px+Vbl2oQAwMDkeEkveo89OUfDWnJkFdhn55tPzpTByhkR+jk73pUyCvhAlWVjmDpr9LlbNH8oGI0pMoIGofiYPDJ/G15ws44qjJHRJsxrZi9Tv8n0W6W2rvDwxk+sqlKYlS4hZZWOJrcJOAp//rGuAFLZcVGsOvclOzKFHQMGxNCUewQQa1cViDJrjkbm2iA8AF0e9MtJNmgWmvRiowqgQ4+Oh1KPkjx2Jb33ZWL+rdK6BWWmZcfni2774lIgpi8rwfgqtCII253T7vGgG4OTw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 37bc416e-02f8-4651-7224-08df4c95d1ac
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 14:50:46.3095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0AFsXK20ArYD+SJ84Fx/Xut2xAl+fvVyUU/HnqjQNmO+GlK3OTnB0Bz464TNKzkoPicvmnsfh5MJ5Xmszic0tT0RKwZ0sDjxBRITWFnwNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4941
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

On 11/27/26 9:57 AM, Petr Oros wrote:
> Commit 8a37f9e2ff40 ("ice: move ice_deinit_dev() to the end of deinit
> paths") moved the service task stop and the cancel of the AdminQ event
> waiters from after ice_free_vfs() to the end of ice_remove(). Since then
> a queued or running service task can still walk pf->vsi[] while
> ice_remove_arfs(), ice_unload() and ice_deinit() free the aRFS filters,
> the netdev, the LAG and the VSIs. A last run that takes longer than a
> timer period also arms the service timer again after the stop at the
> end has deleted it, and the timer then fires after the PF is freed.
> 
> Stop the service task and cancel the waiters after ice_free_vfs() again.
> The stop in ice_deinit_dev() stays and deletes a timer armed by the last
> run. As before that commit, a devlink flash that is still running when
> the driver is removed fails, at the latest when its next AdminQ wait
> times out.
> 
> Found by AI code review. Validated on an E810-C (FW 8.1.1, ICE COMMS
> package 1.3.55.0) with a test-only 12 s delay in ice_sync_fltr_subtask()
> after it took the VSI pointer, armed right before a promisc change and
> rmmod ice. Without this patch KASAN reports a slab-use-after-free in
> ice_vsi_fltr_changed() on the freed main VSI, and the kernel then faults
> in call_timer_fn() on the timer function of the unloaded module. With it
> rmmod waits for the run and nothing is reported. Also tested by removing
> the driver during switchdev sessions and with four VFs bound to iavf. No
> kernel selftests cover this.
> 
> Fixes: 8a37f9e2ff40 ("ice: move ice_deinit_dev() to the end of deinit paths")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
> v5:
> - New patch. The uplink resync in patch 3 queues a filter sync when a
>    switchdev session ends, and a session that still runs when the driver
>    is removed ends in ice_remove().
> ---
>   drivers/net/ethernet/intel/ice/ice_main.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 47c6798c97e8f1..6dede87b78944f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5387,6 +5387,9 @@ static void ice_remove(struct pci_dev *pdev)
>   		ice_free_vfs(pf);
>   	}
>   
> +	ice_service_task_stop(pf);
> +	ice_aq_cancel_waiting_tasks(pf);
> +

makes sense, thank you!
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
(would be fine for me to pick this particular patch directly to netdev
too, have not read the rest of the series through)

>   	if (!ice_is_safe_mode(pf))
>   		ice_remove_arfs(pf);
>   
> @@ -5407,7 +5410,6 @@ static void ice_remove(struct pci_dev *pdev)
>   	ice_deinit_hw(&pf->hw);
>   
>   	ice_deinit_dev(pf);
> -	ice_aq_cancel_waiting_tasks(pf);
>   	set_bit(ICE_DOWN, pf->state);
>   }
>   

