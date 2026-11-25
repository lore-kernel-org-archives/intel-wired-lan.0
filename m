Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1B7606A323
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Nov 2026 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=0QEfan41;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hVc98I+E;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=gyuez+Hg
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B22C34076D;
	Wed, 25 Nov 2026 21:16:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id thProsRjfOfP; Wed, 25 Nov 2026 21:16:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 101404066D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795641416;
	b=IV+A5i3X8r//zxAccUVpHitlHCPD80WBw3l07LbFoRPFPohB4fbLn+CqayTLqO6AD9GJ
	 +o58JE1pYVDvBh8IKs0/YAd1PSMYFRh0MeegIfM6ow8PpKnlMrGN6EFGlmg6EDxNitbBN
	 wGAHEMBNQa1cXsxenhGDNaspW6UgHHeKj5EQJTEAnDLxKZX5clkEJ2PVi1pIepdnKVnAq
	 Owg9O2GDWr9iwjW51gDPGdhsKl3ehBgTtGrOte5cLrpHWhr5pbq3IvVcapzGSbluaQuuI
	 1Fj/LRmJDdsyWZ0gA+zAD8T8wmC0b/RX2Z89HAwcnDlLD/X9vbnQAQ+p6kmltDsRJbg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795641416;
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
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=uyHK80DiHkoFCoDf8b5uqLRo9MBFnGmnxsAjngQhmVs=;
	b=BMygfaY6r5h0dyGS5gIVPM7KS/SGkQfhx1/HlbR6dAdd2JsHN+6HLcdwSX1QPoI+N2FF
	 7ycnG5I4aDSHDYr8OmlrRiNsGVQhRZ7baORPI51LvU5qCkfzKFD8lS9H2tblBpak2cUr9
	 bUvHzDGb2YMIP7mjgwprq8okel6o9TA017j5EcqEfl6sCkhyuLYyrcKqfciMxi7pnZAYY
	 QqUWq3p8j95wBOj4fF4KKbXgZzqyl8X3K7bUzMw85M2f0E/EKcqL3DGl5h6oQOfFQxi/8
	 MdE4U/s2s8xVmO1WlIjexhbCXDeMb7seXPmY5rrxDWStGTmNYEUzjB+peowJBwsw8wA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795641416;
	bh=uyHK80DiHkoFCoDf8b5uqLRo9MBFnGmnxsAjngQhmVs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0QEfan41t5dFFnVe2m0/sI7Sk5+P1pX2Swxn8Q+zTErIR9Y9fW0hT7z/7Jmrj2IBE
	 bRZYoM04vtwWzxEFTIW9y5AKDyoHk1kPHSE0n78k0L2InREksBaD+m0zP9tarQhFfQ
	 73SNUurJ3/PGOmHmUGDEX1NiM49/cHYoaTNb2DD+ZTkvU0Z290g/EQCSw7pfyghY3m
	 jSvPt0jgoCfRkEBw/4A/e4Pd56ql4UeaK4494Ofav1hNoOW29MlzBHMrug3kJZc3Bb
	 2Be1w0mvTRHgWfQDu9rNQocgInil//hM/owcsbwP/4TZ8n/7Tucnz4xA8goBRC0W1v
	 g7W1Yul05uqIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 101404066D;
	Wed, 25 Nov 2026 21:16:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3902D22B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 21:16:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2AF9540087
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 21:16:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1M9op66afn_n for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Nov 2026 21:16:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 030F04004D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=hVc98I+E; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=gyuez+Hg
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 030F04004D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 21:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795641414; x=1827177414;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=X4E65Z57/LaP3ZBJ17K2IQ9qbnz77ollMgJFL0zzIBw=;
 b=hVc98I+Eg9b2Dlhjy4Ode6CRAb2CM55d0yTFn4cA8Kimfhy41EUTbEWS
 G0PEVRHQIjnmh+xf04FuBVpKQVFg6udsRQotf4HqzHFTfBIKbBbWN/SjO
 +BztUISwut7btiCX3xnZ7Pk3VaLrGfG2kkXKHOHHPvAcSUcYHeSPvq3Ie
 pIRoQhSHyiPGs11kKxnb8Afc8iDHq8MGLBy0yYH1PU6z+dBYeSj8GcCIJ
 pntY9PmJm/UmtAe35YzCdE2LFuvLe5GjQkbLUBu2z3E0WJDvO+8VpsAMO
 KP2/ViU/9K1ztxkai5jaVVODs4QydwFhXxNESoWjTFmwqsv5yVtCXcpLn w==;
X-CSE-ConnectionGUID: 4Sg3PZCLRFe+2jPelJvwRw==
X-CSE-MsgGUID: ZfXrHMEeT3u1aQ3A9MoyTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4439441"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4439441"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 13:16:53 -0800
X-CSE-ConnectionGUID: 8ZOCDnLEQ5eou8KtDxEE4Q==
X-CSE-MsgGUID: iIQNQ4pFRbGOZPjeO5dYiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; d="scan'208";a="14010242"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 13:16:52 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 13:16:52 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 13:16:52 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.61) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 13:16:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyHK80DiHkoFCoDf8b5uqLRo9MBFnGmnxsAjngQhmVs=;
 b=gyuez+HgBYsWvJJyMuVbit87+ADcDBXVqQycNDnySItTNT213QUn2mX6vS+IdHskGZXwlgCSv3dFg4yIQMA0FdG+m5druUuqr9Hef0Pmd4sabG09Kn6N4ifIZ6000jQuQ/2m4+NarJxdGIgYAPOGjYnwt+QYyM06OdsnQ4MtzLo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8451.namprd11.prod.outlook.com (2603:10b6:a03:56e::20)
 by PH0PR11MB5206.namprd11.prod.outlook.com (2603:10b6:510:3f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 21:16:47 +0000
Received: from SJ2PR11MB8451.namprd11.prod.outlook.com
 ([fe80::7d5f:b2ba:92d4:5f3c]) by SJ2PR11MB8451.namprd11.prod.outlook.com
 ([fe80::7d5f:b2ba:92d4:5f3c%4]) with mapi id 15.21.0639.011; Wed, 25 Nov 2026
 21:16:40 +0000
Message-ID: <933bb234-436d-456d-946d-acc465622ddf@intel.com>
Date: Wed, 25 Nov 2026 13:16:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2026-11-13 (ice)
To: Petr Oros <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Magnus Karlsson <magnus.karlsson@gmail.com>
CC: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
 <edumazet@kernel.org>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
 <horms@kernel.org>, Marcin Szycik <marcin.szycik@linux.intel.com>, "Aleksandr
 Loktionov" <aleksandr.loktionov@intel.com>
References: <20261113231225.1864810-1-anthony.l.nguyen@intel.com>
 <20261118115915.116177-1-poros@redhat.com>
 <20261125124652.3843638-1-poros@redhat.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20261125124652.3843638-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0298.namprd03.prod.outlook.com
 (2603:10b6:303:b5::33) To SJ2PR11MB8451.namprd11.prod.outlook.com
 (2603:10b6:a03:56e::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8451:EE_|PH0PR11MB5206:EE_
X-MS-Office365-Filtering-Correlation-Id: b6bbe6d0-bff8-4ffa-a2f8-08df4b39658f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|23010399003|1800799024|10067099003|11063799006|56012099006|261021135927099003|261022105027099003|261026121527099003|261026140227099003|261028144727099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rJYgRRy87AaaJKdJimVQkBG6/09Z/JfJxCNiNyDupOczFsezjvLywFdlUAPuruXN3Bfypsvx6jkH0zuTTuneEmmKaUdOkt2R7aUXNCsKj2zK9Z3/YuesqWjm5ln4MZeZlalm1OA6TJisoA2NpuacBhO/kPwPLQL8iw9V3rE2jnnQ4BO1nFl5md4UuC/zMxz2m6axAVsZNF5quI7SrJCOsZTTfODIaZJarj6jpdx79Ju0lGdIgFnbDjHZ4us7078VLE8QOYTzrwBBdgvPTDDmRYum5Bxr8lPOV2J62Kq0pj8k4eMolFeOHZ5bDesMwdrQJEplGITk5mHvhGss3AWuwfSDSK4SBzI3mM9aWi6PsBiLUQauEau2+0US9mDWxG49exaoPdcDgdTUu2Cf5+y1y3uL3wtTkUJP0B+uTt2efwrdIEmmQoCRuwL2uxIcDHVOUL1sxA6aSDEFdXS5MDmo45JmRxA1eEl8c2UqA+iw7wTkOl1Z51YNp9cH8tqmYV/1Jt4TGGtZFVSdl8RJmbPQgVHs0P0ls+JbJbP0lULCIgE4fXB45s2Qp6URRRCSFlejT2/sFTxVlX9Q8JwBLUgDohAbbrQ7VFIGeVeu6drC1UyTzKAXq2XcKEAHu65QYeyUVeA4PNrDUTfBa/WWWMWZxOaGbPSrgFhpFNOKsvp0z3w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR11MB8451.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(261021135927099003)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTg3eXZ1ODlpTTM1NkJiNnlIcWVObkxhQzAvVWFkUVRGS1lsVGtHdmUzQW1y?=
 =?utf-8?B?UkVOTlZTMDVmSUVOL3FCeG82YURMMnFodWs0SFprQUEzKys5QlFzbFBsQXYv?=
 =?utf-8?B?WkJwOVRWTkFLNUtJQmlTOEw1bGNyTVN1eHBSdWkxNjFJYjV1SEdIaDRMdExz?=
 =?utf-8?B?V2E1Yk1EU3B6dDl1VERnVTNWUURDbUdCVmExeGNQQlMxNEVIZnVJa202TTFH?=
 =?utf-8?B?VFpETTBqQUxKV3VHS21FaEVkSldUWk4yVWFoMDI5TVFHd21kdUI2SnNFS2k2?=
 =?utf-8?B?Y1JLZ1ZtcCtwa1BBVkJVOFhlK3Z1M1p1NnZETmY4QXVocUlTdUd2L3NYdVlv?=
 =?utf-8?B?NzFZeitVR2F1eGxMZzVrSTU1TGtrdGlMd2lQaS85cEVjeUNtTVM1Ni9zM3gw?=
 =?utf-8?B?YWlqVEhxdzAvbEkrRERVOE1ielU0SklsT2xKb1JkMnRteGtyOUtpaG0xMWlN?=
 =?utf-8?B?QzRmN0JoVjBNZGxwa3Fod0pocitUaTVhWnBOY2RocVZoSDBnV1oxbG90SlRM?=
 =?utf-8?B?RGhSUVJFd2FvNldJYm1pNDVrMmxQZk9nanlIbi8wckhzY1ErenQ4dWVGbFdY?=
 =?utf-8?B?OXRPcU1aUUk1c3ZKeHAwSm5wZm9LNTNhVFk1blpFNzg1VWNqeVpuOGR4ZGt5?=
 =?utf-8?B?anNGWWZPMHllemt5YnFxRzIycUNseXJrbTROT21VenlDRXZyQXp6dCtlMDFJ?=
 =?utf-8?B?WE8zdmExcDgrbmJucis2Y2phSDdCZDJkeFV6aWJyVEdXTksrSWtWKy9PK2FS?=
 =?utf-8?B?MVU4OUhteE9YRzJXUHJhNmx6ZTRTKzIzYWdLNU4yUUwrY1JNdS94a1B6cmpo?=
 =?utf-8?B?U3VWcEQwdVRyRHlqNzVVdGw2RXZFVGdvc0JFY05qT1I1S1g4d1JqalJzYm1s?=
 =?utf-8?B?cStwS3RuUXp0TXl6WFg3VnUyUTc3Y05SblhySFk2NXd4ZnlJei9DdFZOeVJC?=
 =?utf-8?B?UVcvanVLc01mMWlwYmJGNXVVUTI2d3RaSzRRYXluWVZxY2d1ditvOG4rZDI5?=
 =?utf-8?B?RFdyTXp5bjZmUXlrZnFNVTRIMitXNkNid0ZBb2JwOERSYThlMGU2cWsrditw?=
 =?utf-8?B?bW9nYy9lVWJoOThIUVpUYk5ic0poTUhMN2UzSExuME41VjJOdFVoM09YamJl?=
 =?utf-8?B?K3g3eU9iK0dNRERYblhaOXJlaEdtd3BoOVhGTDErK0hFZjJDZHlTbGdEOTRU?=
 =?utf-8?B?aUd4V1RNY3hxL1VCaFh5SW5qbDNSMUMyQ1BicXpnTFFQTkNHaEZLZmNrZzVY?=
 =?utf-8?B?dFB3VENKZGRnOVFSem13L1ZBSExFZWs4NHBpdWM4ZVk0Z2dKL0Q3NytlMmZM?=
 =?utf-8?B?TGdjVmQzMDRIVlJ4Vmd3QmxoTGYxNm4vSUg1eHRyOVBLYkFtKzB4RnFaNUcv?=
 =?utf-8?B?U2d1bHcxVlliNFlSK2NsMmtTOU1HMGpUaVZGaUV2VEFBQ2xhWGcyZ3prd1o0?=
 =?utf-8?B?c0lybDdsUWRIZHJkbWJFamx2Z1phTFBYeitSVjFIQUptK3NxMDQvL2dTNmwv?=
 =?utf-8?B?SDhXaTlnU2VCNTkyRFA1TzdZay9EUkFJcFlhZ0lZUkQ4OXgwQXZJb0t3Y1Rx?=
 =?utf-8?B?TExRTDR4cEhKQnYyS21WdTkwKzFtU2lkQlhvMXFtcThJY0p6eUQ4cUZEUEFF?=
 =?utf-8?B?eDlGTXpVd3JrcEltdkpxNHRMWTg3MlRKRzl5eE8yNjRkTTRjaElQRkF6dFVy?=
 =?utf-8?B?NmFrRDZWRC9MQmpYNVVsMWViZktIZnA0Nk1udWQrOWV0QTl4clgycjlrc0Er?=
 =?utf-8?B?b0pUL0owb0hWYVFsT1o1RmcvZ2FDeU15ZEhnRWg0amtmbzl0eVhYVE1jNVlq?=
 =?utf-8?B?ZC9PcnpmN3Bnd0tnN3BhVFBkMHNjUzVkRlhRQkVjMjZybzZ1bDBlQmdvbWpJ?=
 =?utf-8?B?ZG1adzhQS1FGeDBCSzhlaVVLeWN3R1VoTmdGeHlwZG85NFVnbTMzeGpoVW53?=
 =?utf-8?B?RWl4UmMvYWMyNjZmVCtrL1JaM0FrYUdZbkthOTM0L0tYS2FKNW81M1lmVnNl?=
 =?utf-8?B?MHpHNUFxTjROcnZKS1hGSEc4RFFKS2hxVHZocTJESnB5U0xtZGZ6WHdwUUlR?=
 =?utf-8?B?ZDdUNG9ja2FmaDY1WmJOTDdHSk5ack9mNWdzNktUTElVaExVQWY3ZGk1dm1I?=
 =?utf-8?B?VFJ4VGkvSkdBR1dtS3c1dkMwTElPdWMwcm90S243d2t1NnU5TmpQRXFMTzBZ?=
 =?utf-8?B?c3IwZXVuQlJOY1V2VC9BaTQ4OUlmK3NJNGhJMUpUdzhGeFhXRW0wMGJQTExw?=
 =?utf-8?B?UDN2R1dKYnA1Z1dIRXAwOVdjWm8vMTdIRzE0NUpPWEhTSFo0VU9LNnRXcUZO?=
 =?utf-8?B?dEhaUW4vOU9SbDJVeGV2R2xUTVY2aDZOQmxLLzB0VG9SaVpoVjVNUT09?=
X-Exchange-RoutingPolicyChecked: UWovcAmH779CjHGbH6UrWOyW6mCAsrvFqnKtEcbVF1ikSDYa3SbEm2l/rfWYEXq/gQPwIxB1yK10RgH2MtqEuBmRaZIMSXJ8xbksOnKS0yUFLzja+sS3kEBqbaYtt6Hv007Z6RleAmg0ZqcFtPLidmNk8LnceYX0rLOLz25PF73CA55KTCVQuMA039YWAEhMYeWhjqK8BPObzz7REXTAVPfWrunCAUhrVN6LDvLmh0PCnCHSbFS7IpSZffH7XP8GdyT/az0r8Hn3b9QcmZdLswaRUrDf0ESWQfkv+1BEqclB+QTs18Rvq9A3LAp+L/roPK4nhamrwhXeCaEQ1bpQtg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b6bbe6d0-bff8-4ffa-a2f8-08df4b39658f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 21:16:40.1010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n44mVbIX2YIIBtC5Buya9sPXzQu8PLbqUZMX0uc0a/6Swy2Nu76OzQurfIfPsx6ouG8HgCSjC67kgyRZEI1q1NQPLiBGlUJJPijl2fz60pI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5206
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

On 11/25/2026 4:46 AM, Petr Oros wrote:
> Thanks everyone for the input. Jakub wrote that netdev is happy to take
> the patches directly once a maintainer acks them there, and Przemek
> that they will ack more on netdev. Building on that, here is a
> suggestion for how it could look. It is only a proposal, for anyone to
> comment on or change.
> 
> 1. Fixes could go to netdev as [PATCH net] with intel-wired-lan in Cc
>    and be acked there by a maintainer listed for the driver, so they
>    would not need a separate round on iwl-net.

Just to clarify, we believe this plan should be a change for
contributions from outside our team. Jakub mentioned he doesn't plan to
increase the budget, and we plan to continue having our team submit
through Tony. (Basically, for those of us on the team: this isn't free
reign to send stuff directly and flood the list). Basically: we still
want to be coordinated and avoid flooding the list while avoiding the
current issue where contributions from outside are stalled for a long time.

To that end, we'll continue to keep our initial work from flooding the
list by not including the netdev cc (until Tony sends of course).

One open question we have is whether some of the contributors who happen
to be @intel.com but who aren't on our team are handled. We have a few
contributors from other teams, but I understand that its obviously
completely opaque and not clear to the community who is on what team.
The simplest answer is "if you're @intel.com then you should work with
us and send through dev-queue).

> 2. Patches that are already queued could be sent again directly to net
>    by the people who originally posted them, the same way.

Yep.

> 3. Later, once this works for fixes, the same might be worth
>    considering for net-next.
> 

Yep.

> It would also help if Intel updated the MAINTAINERS entry to match and
> kept it up to date, so that it is clear who acks fixes for each driver.
> Jakub mentioned adding maintainers or splitting the entry, and the
> details would be for Intel to decide.
> 

We're looking into this to make sure we get person for the Intel Client
drivers (igc, igb, e1000e) and for the IPU space (idpf, ixd) in addition
to Przemek for the FNIC drivers.

We'll try to get this updated soon.

> Does anyone see a problem with this? And who can make the final call
> on how to go on?
> 

This plan works for us, at least it fits what Tony and I had been
discussing yesterday.

> Regards,
> Petr
> 

