Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73601606A325
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 07:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=gNaPCe1J;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eSFWv2ec;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=cKN+HBUT
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 534B34050E;
	Wed, 18 Nov 2026 07:09:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VzviJs0eeh47; Wed, 18 Nov 2026 07:09:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 563884051A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794985763;
	b=O3XWbCz3DM7i+L29ZZ0Ozcg8c4HjxfzT0A5g4yf+045+i5DDOtfXb26fAqUgyJLWKD/Z
	 FJ9SGytHy76akVOk9rS15JdHDUB0yV9fBifDdV22lyzFgvpBF0fwpLxkBlcRaZgY2TZAZ
	 wXFjuAbxArAnuJuG3vnTZGyd6E+dXGlkywcSvLfSYJ2g1KFTjAA+jdHViCq6zMqzwVghl
	 7pTih1yTT2/Yx3LUsa+w12xHGUkiumgsr2Cvm2l4txJyGmAFQXYOwu8+p1WbSd2J8Kkcd
	 AwggoFLXr78Xpx5/i3DndWQrmWg9N6qnv6rYoLQmimrbbHQT4LG/YgC17Mq+htDkLYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794985763;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
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
	bh=FuGSYKm1Psl1WqdDEw5xSkaBkWGUAITFOLJFmGFywCc=;
	b=NVdkg7+wMuPkdhthRV1/PJwkGGNxPXs1aktO5z3U0G0ULb3uL4D+OWi49kZnifbg7k15
	 iArUDwYyPqwzL4/g5hJhG/ptEpQ4sk8mNTrFa2YKPlFoY8I3n45GlOqtqBZG3RcmR/ud9
	 UgtyF4BoHHg/5N0yw4W3fu8YltiCp7WV34FRwImQkP4Z2sapltu9hSpIW2jdjOwABtnvd
	 7w2YUM7Ygni/NfRKxKKfhO6tee5YU4urUSILJh7hRhAmhgBWt1AgbHyu3upcJ4dne3tsX
	 7+iWtOfvP9Q1RlVz/qDnV1Gfeo43mz5HG7ZBDEVRKzm6PYZw8gRvc+GOn2eZ4DNbFow==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794985763;
	bh=FuGSYKm1Psl1WqdDEw5xSkaBkWGUAITFOLJFmGFywCc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gNaPCe1JFyZ1oV7ljJRRnz2x+l8aam7FEbRGqIjDTada337+hBQPhixh7pj7mcgQ6
	 qVNd/NZAMb6YtbUDAYKr1tnxJwBt5NQNrkmtCUvpRC+I8wj4p63WsOqL9gzfDmfcDg
	 BreonIEts4W5GM8QpwkwiuudqeGjR3eqfMrPTCNsVUHnvFSqzr7H0Gwr304SkmGHqJ
	 JVhafpwKPnzBXlIN1G9eoUu91Oek2seQKn3dyeu8VvXqYRg0CpoDaRJMtLbb08aXrF
	 hI0FVAtmnTisyw4V/IqPyc0xYEZh970bR/re26jPLvZXYH7+5ndA9boeP3GKhkmjd1
	 JilsRGf3D9G8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 563884051A;
	Wed, 18 Nov 2026 07:09:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DAE249B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 07:09:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 036024018E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 07:09:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L3MQFkKti2uh for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 07:09:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D2EC2400A7
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=dima.ruinskiy@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=eSFWv2ec; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=cKN+HBUT
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D2EC2400A7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 07:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794985761; x=1826521761;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jwVd7zw2PQi7SdX+5GWqBWIbGFKF/6YuR/M17Rrk8k8=;
 b=eSFWv2eca0+RWgk/THW2NfJOoiJ+JGZwZ2w16RATihTlhS6IPEAuzqBZ
 /hLF+IkB3/Iq4c9b5jFwgjrxFTDhF5Aqkmpql+PxAY2XwT7KVsrOuC+wS
 jdJVTKAtA4FVufpoEVzi6m0BiRvtyigVV8hEwkzlt41++m/LCF46qzF9S
 YK+XHfW7GShsz6R4lid4udIUupbnYOXlSbZ2RLiB+VRQbEXULj/PbQj9v
 I952W6Xu+gJMWBHGB4/EKmSLolWob0Mglsp6UDiQEkAERfYqf9RIstLLa
 7kCrqRSlzISN67v2mn271y0I5vxZ/9NAXVeubS3pkyIJtmTpeRW2PIE2L A==;
X-CSE-ConnectionGUID: Ia9Ofa6VShaA7XTUMejFSg==
X-CSE-MsgGUID: JNfkxOIlSzuVBAVLup/ghA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3808302"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3808302"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 23:09:20 -0800
X-CSE-ConnectionGUID: Uc2wL9pSSz6q1aLearV0jg==
X-CSE-MsgGUID: Hx6a/UbpTFOreEk8ozO/sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10450479"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 23:09:20 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 23:09:19 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 17 Nov 2026 23:09:19 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.31) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 23:09:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuGSYKm1Psl1WqdDEw5xSkaBkWGUAITFOLJFmGFywCc=;
 b=cKN+HBUTIUKm6vwGQHZG0Y0yYG2+xTS3PjgnIxENp14NH0ZoKnytHOybHh5Ho0jJra5OkSu69ZCfpopTsPV4+6qvAiLHopnwIfWTJrFKVBrVz/dQazuq9ESsMOaD8AG9r6zoC2iFhDwpiPtbXY/NxHrZUSd8OUhr4eBblkQjeCY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5630.namprd11.prod.outlook.com (2603:10b6:a03:3bb::6)
 by PH7PR11MB6675.namprd11.prod.outlook.com (2603:10b6:510:1ad::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 07:09:16 +0000
Received: from SJ0PR11MB5630.namprd11.prod.outlook.com
 ([fe80::79de:af84:3b43:84e3]) by SJ0PR11MB5630.namprd11.prod.outlook.com
 ([fe80::79de:af84:3b43:84e3%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 07:09:16 +0000
Message-ID: <a2284c4d-8c30-4d98-8886-9d9f90bb9b97@intel.com>
Date: Wed, 18 Nov 2026 09:09:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 2/2] igc: treat I226-LMvP as an I226 device
To: =?UTF-8?Q?Daniel_Via=C3=B1o?= <danividanivi@gmail.com>,
 <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
 <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20261111093035.513635-1-danividanivi@gmail.com>
 <20261111093035.513635-3-danividanivi@gmail.com>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <20261111093035.513635-3-danividanivi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::12) To SJ0PR11MB5630.namprd11.prod.outlook.com
 (2603:10b6:a03:3bb::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5630:EE_|PH7PR11MB6675:EE_
X-MS-Office365-Filtering-Correlation-Id: 863e8d2a-a5f4-4418-a15c-08df4542db32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|4143699003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|10067099003|261022075727099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0Ru+zrUrsm9INQFyjyUHIK9BgvaAkG+SN2ebXghWDB5Sbb437sWEMfOJ6bJQcpDTXoC4xfAPiPXeb0CIhuZGFMe9J6VaQJqxiK/E1X3lMt0wMmY18l/9TCRRiKlXGgpPhzsw4DJPNKv24p8iCcZI4pbh9g+XcAWS3a5o5bMpmH6Hbs0jfY+C8Kan24zD31kJUeAmegJhVyEEV0VCVX4+HdB63yOpYXR3XgiMo5t7V53HQXKFAheixAwybjsfCz19QJL1q2lJI38qBiW8JB6tSR4Ca993Jcp2lmQecHWW6+Dl+ZtgX1j0ONq6rpZ9r1RpduIo9S0Qwgg/rHSOKO4W7WtU7nE6H+kh5t8u/3r/Bncbhv2lWJWEOdR1d3aAatg7n6UPXNSnA19dzkjzlifXdNVamOVuR1XiCZag5Df6UunuyXmByd/nlwM0HR+H3QLiZhtpIi81SkxdojiTYLXmLp9hzGuisgF+VoEBjXUEGIdS/LxhlM/gWlSiqgq7Eu599ihbJNVxk0jea9TN79eSBstYbCEHrwT8OTFAXhyRhmFLp36oQEVdkZ7ijjDdnPNBeUe6aXtoQXCowX/k1Sfw7IvIg0nK7NOUIPL79UcxZo4/j3x9ywalBseCSunYdOPI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5630.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(4143699003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(261022075727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmExNDNPWURyV256Y3hkMUFBRjk1T2VYYzF6R3JRR21PYlJ1cXc3MXBXeWFm?=
 =?utf-8?B?cVBaWWtCem1rSVBqT3o5VWlwak5vTVhxcGsraGdmVDY3b1FLN3k4R2FoejNL?=
 =?utf-8?B?NU1PbkljeVdvU0NnRSs2WXRBVXh0UkRWcElMb2VpcnJtQmIxODhrckNoNVFU?=
 =?utf-8?B?UndoUk5lZnp6dzFkRW9CcUJ3TXV5b2k0T3p0RzFBS2RMOTlHdCt2YWhrbzdY?=
 =?utf-8?B?SGc5SDNmYmFaZ3hET3JjL3NBbTBlUkFTZURTM3FhSUVZMUhZNkpEeHk1Mytw?=
 =?utf-8?B?TWkyYzUxZDBjOHl4bG5rTU1TcCtZVVBIWW9WRzFQekF6VVJiTmFuTnJjSVBI?=
 =?utf-8?B?TEp6aHRKWEZad0NXbnk1VHZkR2psZG8wL1JmeEJRbEZtZjQ3M25RVWY5dFk3?=
 =?utf-8?B?eDVIajM0ZUpwOStFMDE5UklWd0t0cTNOK2tpMEI3WGNiNDA4cENBSTd1RUtI?=
 =?utf-8?B?d25PZXpLL2k5TjRZaEpaNG5HejdJejBYYXNKQnB2TFlhaUR3SVVTT3pzeUtZ?=
 =?utf-8?B?UmczTHpJNUxIT0FRNTMxblBHRTJ2ZWk2Y0NGcUlGL0xhaEQyNTJxWlozeHVX?=
 =?utf-8?B?NGxEbm5yaG9wTHpwUE9Xbys5cjk2blRjSmsxRjJVblprcGxHcE02RFZ1Y2Rw?=
 =?utf-8?B?WCtsN3ZpWTdwUlp4bVdkYW4rNkNyVUwwbnBPcTJ5akpLZ2g4VFVyb3p1R3F0?=
 =?utf-8?B?OWhpMmYwNE9tdnEya3pZMEhyZHE1SWNYRW1zeSswQjMxRllEQ2M3RWY3aDRt?=
 =?utf-8?B?OFYyd29GMTRHdXNIMTNDajhnT1h1NDJaYzZDV09iQnM3YVg5WWFPZXlwS09u?=
 =?utf-8?B?dU5XN3BGYkU1ZzlRZ2ZndXRkV1krbW12ajZLWDBBRFdNQy80Vzl6dm9RaEUw?=
 =?utf-8?B?NmtibmJ4SmFKa05vZTFiYXd3QXJKN053QWNaQTBRaVlNeDNTS2I1Q1E5L1VQ?=
 =?utf-8?B?eHllMWJzNTNOYWN2RThIalpqMHhMS0RvZUxFcjV1d3Q4aXhNUVphMDNMeGRX?=
 =?utf-8?B?UmdUTGxqaXBmck1ReFFhQXpDQi9kK1VRWGwzbCs5cExvdG5YRUQzNG9xMFFy?=
 =?utf-8?B?akpTd2JrellUbUdjTXZ1Q3NNaW1ZZE03MURJK09DSkg4TEl3TThZbjRrQ0Ix?=
 =?utf-8?B?U2tKZnJscFhvLzU3clV1VHM1WmtDM3hvV3VaTW5KdDdweE5EelZRYUQwVGd0?=
 =?utf-8?B?Z1FxV3g2NjZYYjVVcEFEVGMxMDZvN3IraVEwZVlDc3lFYWtUSEVKQWpNZFV5?=
 =?utf-8?B?cDdpUTc2MjBjbjJKZjV4ZW9BOWtRVFRvb0pKTWdSWUdFaTdTcExKTzVaMmhu?=
 =?utf-8?B?N0NRVjR2N1FGUWFXdkJYR1J0angvYVVYVUN0WW92OTJiblNqZjFCeS8rTFU4?=
 =?utf-8?B?OFpoVVo2VTc0N2RmS0N4WTB3RG9yQkUxT1ZjbWxGSVpIMWl0VnFibE9vU1BX?=
 =?utf-8?B?cnZJTVJqa2tCak8xbTZiMnBzakNmejM2WTJwNUpZaDhVUFFtMmJySUdMMVZo?=
 =?utf-8?B?bndVdzYva2hZTlIwT2dQU3hXdUJ2ZUowMGQ4UHZvcXNjV3NhUzN1bTZXalY1?=
 =?utf-8?B?MDRqc1BZOHJINml3M0IxM3pWZDNUSXliYTkzWXNhSzlOVldmV3lsYnFXY3Mw?=
 =?utf-8?B?Ty9jTjB4V1pLQnM2cXNzd2xuMm55S244UzYzVFZ1c3NMV1I4cnhZMzRoVmFp?=
 =?utf-8?B?aHREKzdzMjI0WVNSUHg3TjhPVzc2S05mNGEwY1VJbDYxb3djVzMxV0RiR21l?=
 =?utf-8?B?NWVMdDlmU3NUMHNDTEJGZ0FndjJmT3lyZjBzYlFjRU9YdklPNXRQVHo2YVdJ?=
 =?utf-8?B?RW9mdHYwZUVVV3p6VDB0TmE5eDVLbitVdXkvVXpzT3M3cmE0V3hWK0tERGlJ?=
 =?utf-8?B?Y0Y3dmpkRnNRaGVmdyt5M280NDVodGl4bjBQSEo3NURrUDVEYUdxYUU0di83?=
 =?utf-8?B?S2JWWlZmSFVSbzRGdGRTZ0VaN0J4Q04rdkVKL3RURmVyNlptZnVTRHljZjFx?=
 =?utf-8?B?QzFtL3ZoWmcvUmRZdmF1L1F1a2VYTDJDTU9LT2tETFBHUlQ2czdGUEdLdDRa?=
 =?utf-8?B?NjViemV5aVduWW9ZMVowZmw0RVNaQ1BkdUJTcHE5RzBhMVpnVmRXd1lZQ0lN?=
 =?utf-8?B?VUZJYXIzL2lyQ3NFRkpBM0IrTkhzR2ZqeXo3RDVoOFVYaUZpVXRCaGJtVjg2?=
 =?utf-8?B?YWJyRmVDZWw2dU5zZTVZRDRyL1BMa25VVWRoYlpLMjRuMmhOOWI1WXR5VUVE?=
 =?utf-8?B?VXNkUjRYdnBwSVhTNkEveGVUVUIwellucXlGNW9YZVlNVjlQdWxIaVkwOEZ1?=
 =?utf-8?B?UmxwejhoTEdxY3Q2QTBMWG5RZzlrQ0tYNnF0TEZ3WExobE15Y09zZz09?=
X-Exchange-RoutingPolicyChecked: pouRMW25okF8GhmivxTeU++euZZSgh0f8ni+NnmG7VBu/zPVGJWrj7ycqwYcBmPQWfjAF5gBIHD5ptev/EYTzfuWZO+TfbjI1Tt8Y9RqHuQy09SPCMdmIRg10jtiCKNXcNlmpNgVRY0tXJ9GQ9HFnbzVN6HgPPwg1JHBz5vD1n0fc8AQmSHRyS9BQehShkulBs9Eo7Y9GHMOXbx4YAAiE//KkJr9RA8UKO4zeSqkYpJiOMPoQLWoJGH+jDEwbfb4TlAFtX7sjNE5yBqmaFAuiRuF5vZGxnWJkhZIqmDN7lj0Gl3DmZ0XHijQuOXY8Qp9WAwxxI8Oy6E5azi8es7rfg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 863e8d2a-a5f4-4418-a15c-08df4542db32
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5630.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 07:09:16.0001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6tLpM3tk9YAzTU6PY1RYovopn5m5OWUNjCX7oYNLh72TXJAkZ8AAq/XyLHn7IwDIuXHEVQiBgD/HKb9OrGbtww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6675
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

On 11/11/2026 11:30, Daniel Viaño wrote:
> The I226-LMvP device ID (0x5503) was added by commit 8f20571db527
> ("igc: Add new device ID"), but when commit b8897dc54e3b ("igc: remove
> I226 Qbv BaseTime restriction") introduced igc_is_device_id_i226(), it
> was left out. As a result I226-LMvP is currently treated as neither an
> I225 nor an I226 part.
> 
> Add IGC_DEV_ID_I226_LMVP to igc_is_device_id_i226(). This changes the
> behaviour for I226-LMvP in the following places, all of which now
> match the other I226 parts:
> 
>   - igc_probe() and igc_io_slot_reset() disable ASPM L1.2, as done for
>     I226 since commit 0325143b59c6 ("igc: disable L1.2 PCI-E link
>     substate to avoid performance issue").
>   - igc_tsn_enable_offload() and igc_tsn_disable_offload() set and
>     restore the I226-specific RETX (Qbv full) thresholds.
>   - igc_tsn_enable_offload() handles the FutScdDis bit and the base
>     time as on I226.
> 
> Intel confirmed that the I226 TSN functionality introduced by commit
> b8897dc54e3b also applies to I226-LMvP.
> 
> Fixes: b8897dc54e3b ("igc: remove I226 Qbv BaseTime restriction")
> Link: https://lore.kernel.org/all/5d45a583-198c-467d-afbe-8f19398e82f3@intel.com/
> Signed-off-by: Daniel Viaño <danividanivi@gmail.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_base.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
> index ab9120a31..6865fef40 100644
> --- a/drivers/net/ethernet/intel/igc/igc_base.c
> +++ b/drivers/net/ethernet/intel/igc/igc_base.c
> @@ -447,6 +447,7 @@ bool igc_is_device_id_i226(struct igc_hw *hw)
>   	case IGC_DEV_ID_I226_V:
>   	case IGC_DEV_ID_I226_K:
>   	case IGC_DEV_ID_I226_IT:
> +	case IGC_DEV_ID_I226_LMVP:
>   		return true;
>   	default:
>   		return false;

Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
