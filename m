Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7A7606A686
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 22:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=JHhAdQSr;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SSXk8GZM;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=PNjatB6a
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5E2D1605ED;
	Mon, 23 Nov 2026 22:47:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iQl4GbwKeIXH; Mon, 23 Nov 2026 22:47:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8CA6E605F3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795474038;
	b=bt6otlCElufXDbdYbrs7mJ6voN15vvjK8opMx8b1JUQb3Th4gVPfJv5xMfarjWeXOL6+
	 GmkAfO84OhPlpINuAgiEgHaT2lEzPrgDYrZKcB25dSDHtJF59VrH6DfBE6+Q4nxWwVnNy
	 tAd0jGQKHVUmIB0uJM9++k9hLyC2jEnMxISv1REym2QZj6znDYWip8RXh1pijN2C32+aN
	 KuurNxoPZVh1/q/3y/55kWgwQ4vH0nSL7HJxjoFQOHZOAHIdAtEZ7U4D6Ap9Jgt/JU6WC
	 w8xuciGNCb2/eqJ9Ib0Rgfv78ZApf96hQGvrsTxjMo9u4D0eswggJkvDPUIsGQG89tQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795474038;
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
	bh=NALa9Wr6VpbSvo/LtWdyyrY35Lk7zNRaxr4wcyvQ/lo=;
	b=aTgOQDtSKda2r5IRRYCthLCljflaoQLQKW2gn4N1oIv1v1s6zSnN6VS48o+1/NzpJ6nW
	 GC9y0sdEEhpnD9xXwzp79AMB+Y4W8xhG3X8ChwgNL3EFyL/ZnxLqOpo/L+Cvz8yWKBzeC
	 MUH+WPZlmptLbijlwwAeVMusd/QxrrMsYCMeZI/jBXNwgofZWReqxlj5qPmKWYEltcn/K
	 3zgKFfpzlrUajh6Dh/R/69ckfKD4WGZcCtYpOjX1qF2kkdOqUoLVq/dVpdLaOgL1uag5D
	 81CFODLHu8qhRMJCnObtQ8AmeYyCYPZ/86ihteTLpAb2xef+zavTQKR5047zloh8l+A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795474038;
	bh=NALa9Wr6VpbSvo/LtWdyyrY35Lk7zNRaxr4wcyvQ/lo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JHhAdQSrcDw/waaAOI4ixsVxs/uXVdFOWfzkjk3+OhDKw57OaZPplScTTSs96S6t4
	 MmVTsje234vGy5QwwmTs8S+5eBbxLi6qzwDHLzzlNplhjFtLnKW+IJdEuhza16eYXF
	 qymK6jLv6n48VUWgyvpxL23h62g/J1LwnP5qofamxghFX3/7Ss2TfDxTlO3syvZFz0
	 klcJv5g4PHQ9Ni1oi8feeqG9NGHDy5bblS0mJHn7j7jM+hhzLI10gJxEi00rTfpyZA
	 ZPUTXIFU8hZ3aRXVZ8XWDdfQQGNvMbFQNrvEhC/CmuZ7zOn6uC3/Fv7WlgO+Wyu0KN
	 yVmPFQa0Y5pUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8CA6E605F3;
	Mon, 23 Nov 2026 22:47:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 926A1260
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 22:47:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 83AE7405ED
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 22:47:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZwuvlwEXa_96 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 22:47:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 32166405DE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=anthony.l.nguyen@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=SSXk8GZM; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=PNjatB6a
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 32166405DE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 22:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795474035; x=1827010035;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ptubGmvaDfCxHnnv4o824iUuB9IERiCwTiR7I2vmtHU=;
 b=SSXk8GZM0NjRQYQS9W8939cK+uT/C9cYhizcR36Nac23qZygGxGoYtNA
 FqGzTm96P7yQnOxirxmD0qyUJMk2H0I/IzlNwusxrefooCyQtBBw4f1ly
 QDq/0Qyt11OSvBQ2tGN8OfqQs4kRBe5S/vp75/6Ui0UOIJz5xrA57v4wN
 oZ0vsU3MlnkJM58SNQcWzrQTwXkSBFB/s6iKINusX4+qEHL423pwJ0j0x
 dXvM2TUBNy9qYVuZz5xEEYpZwXLGdrIwH+1bO+5mUUf1IxnZQw0D/ksm1
 8FvPRBmD9+cqKDnQ3plXCx62py+kFbz2sWmxtbvq7+16MBw8MwjgfGH4s g==;
X-CSE-ConnectionGUID: bAa7eXVXS4G29BtmUu2pxw==
X-CSE-MsgGUID: A9DzLYrgTASd7GDuMjTdTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4284744"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4284744"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 14:47:09 -0800
X-CSE-ConnectionGUID: eBQ59PQIQ9yOIeAetKDXHQ==
X-CSE-MsgGUID: AErYV5zFRfuWUrD13+mDLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; d="scan'208";a="11723311"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 14:47:05 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 14:47:05 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 14:47:05 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.27) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 14:47:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NALa9Wr6VpbSvo/LtWdyyrY35Lk7zNRaxr4wcyvQ/lo=;
 b=PNjatB6a6kuNjBuYw/Wxl4YQyvwOgDQeVDg9sdYdgX0d2qTcAb+C3HqRZ6RY+ODMzYXYvTV43g8Cpce53GncMtxkkShjfFbhu2M9nz/qh8zvHobR5P1IJXgaXwH9Ct3+YiWp5oIGW3TYqn8iplxbWjCHEBS9FW4RR1060Gq1muI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7710.namprd11.prod.outlook.com (2603:10b6:510:298::9)
 by IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 22:46:55 +0000
Received: from PH0PR11MB7710.namprd11.prod.outlook.com
 ([fe80::dc6:ac78:d884:137b]) by PH0PR11MB7710.namprd11.prod.outlook.com
 ([fe80::dc6:ac78:d884:137b%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 22:46:55 +0000
Message-ID: <a4e78445-d0b0-4347-85c3-acf0184ff66c@intel.com>
Date: Mon, 23 Nov 2026 14:46:50 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] eth: intel: fix unintentional symmetric RSS
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <ahmed.zaki@intel.com>,
 <jacob.e.keller@intel.com>, <intel-wired-lan@lists.osuosl.org>,
 <przemyslaw.kitszel@intel.com>
References: <20261123205600.1794292-1-kuba@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20261123205600.1794292-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0329.namprd03.prod.outlook.com
 (2603:10b6:303:dd::34) To PH0PR11MB7710.namprd11.prod.outlook.com
 (2603:10b6:510:298::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7710:EE_|IA3PR11MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: 92fd666f-c02e-4d2a-b2d7-08df49b3ac9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|261102123227099003|11063799006|56012099006|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261009223027099003|261026121527099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: OZwACUjiDwtUY9YfKesKQspjB9pSlBTw2zCZQ6Ldmw9xYo6s1kJvtYjR1vdG9/Ty0Aj4EViZ9yOpNZlK4mXCOMDKoHLxkiJpzVtjM7k/m/QZVZjKkMus4GSxemWZcMLhaaJ5QcXOjT3SfhxYRNtw0REYBVSehEMC/LoooGWh0TOuEV+9yndfAELGNYHBI4zkXvMG9tsmmFO6zKzN4dsA5YmxcHx/bPHIJct4YtVBQIq6M/qyG/xuOBFypmfTVGC/kkI/JVCOXrDY1w8IUvB1NTA6tLzMF/BzrNPG5RP7cuvrPHbr7oT8vJn5Fp/Ck6LgRcBde4S8OcBwPEIS8qnWv3qTmPR7XHaztPDpJau2HbRS1dOaGIBYnetopwxuGUm+8CzkbGIRNiUXDA/7DHmJCyJXxd/cDTTkmfpS4gxCPJ/plorKIT14uuVFlgjNYzlLgRIv32z9Dcnbre2b8u5k+AJtcXHdvH3tgpBIfomwX9AyyA8JbDAaZXgzIOaajyYX4X+sIMijuJKcDosuk60UtK2h2gTR2tgt3n1QBdFmoskE6NHJ6+AogosTr2cvOY7ZnHdC7Xxta+9IH1q9qfFqT+Ji87cVexPY2VIAsoYLiTnXA0UZMmaDhLA4X/dYPjSN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7710.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(261102123227099003)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261009223027099003)(261026121527099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHYvaGs4azR1SkZWbC80Q05RNGl0aGd6b1FHYUFubFY3ZytvUU03UUFQYkpW?=
 =?utf-8?B?YmIrQUkrSHJidHRVTDBSTTB4YkpWVkZFZ0dpMkJIRitYWTZDU3JwRC9ORklz?=
 =?utf-8?B?djgySXRxb1ZvL2RtRkgzcFlydnBjdG9HS3ZlbHN2NlFKNGM4WStyNGpqS3M4?=
 =?utf-8?B?L0I0ZHB3NFhtbGllU01HNFJBMWJGNVU1WUd1b1RxdGttZHpjd3hxT00vcFRC?=
 =?utf-8?B?SGhQKytJRmRvNlg2TkQ3VlB4SnZJK2pQUWF5UGZUNkNWVFB2QVBUelNRdWJM?=
 =?utf-8?B?bEg0QU5ZeHh4Um5xQTFZMXJVeXdERmZRaFZjelRJQ0hpVlFmOHVjZk5hMjZZ?=
 =?utf-8?B?WitOUExIN21iMll6UElyL0MvaDZNUWFiVjFsckhRM29RWmRHcUg5a0N4NDJv?=
 =?utf-8?B?Vm1EM0IyOWJ1c1NnTVFzVlUrdnZLOGRibUdlTEl0TVAwdW9xK1hxamJnaUYy?=
 =?utf-8?B?TlR4dEdFcEVTSjdMRlV2S2YydEtiZnJSeDA3VjN2a2lrL2oxWDZ4MzI3S2Zo?=
 =?utf-8?B?cDNHcUV2RitscHRzb0FlWDNWMGlVenZJSklsK0hib2V2OHY4b21jbnh3Ukpr?=
 =?utf-8?B?NVFUWnZPS0Q4YTNYTmlER1NuTWVhc2hyZ2hwQmRFdEs1TkplNW1XZGdyQ2Nq?=
 =?utf-8?B?cS9SZXhZN1dGa05oSHM5RjQyU3Z4ZkxyL3lzQW81UGRZdFI1OGVwYjJOd0xo?=
 =?utf-8?B?elVOS2ZDWFBOUG93U3lGenVqVTZwSnNqLzhTYUJ1d2tzUlRmK1lTSG1NZDY0?=
 =?utf-8?B?MldIcVVWWG41VGJWeTRzN3o2c1pNREVHTVdpUldoeXVnWFJyblNVSVBwMmQ2?=
 =?utf-8?B?VlZ2d05UZlJXWU1YTzBQckhvNk0ybXNTdGRzUjRPQWwzejFYUytyQ3ViTTU4?=
 =?utf-8?B?VXp5TnlSK092RWMxaFd1NTlUcGhJYTd0L2E2MUg4NmNhVFI2cmxhYTdIT3hT?=
 =?utf-8?B?U1lMVkkxQk5YdFV6dkVEb1Arc09CV2RKY3NIbUdSNzJnT1NhMXVtTG5ySFkr?=
 =?utf-8?B?eFdaRC81N2x5K3pVTE1lTkdpVnQxRXIvRTczVkFwQWhjMktjTTNZenNpcSsv?=
 =?utf-8?B?QkE5Q2VFQnpiMDBSUk9Ka1NUSHF0K25FTkVHODdMOXBySVZVUVZZclgwV1VC?=
 =?utf-8?B?b3A3SGRHcTRtM1NWUlBDZ2tXdjlGVDRrbzVFMzBRblR3NUI5akNHdDBFV3Z0?=
 =?utf-8?B?aEd4WXhGb2dGQU4zcENQa3ZwS0V4SnBFYWdNMS80czhIdnA1cXNUWllybDBr?=
 =?utf-8?B?WVNoMkVFTXpsQXd1VUx6azdnaW1yRFUrblozVHVFa3U3Rnh1a1Q1NS8wWmpP?=
 =?utf-8?B?dC9YU1U3cjkvczRCRkxnTk1BZ0xiMVBmZ1BUMTR0dDI5c21IbkNnQmRPandx?=
 =?utf-8?B?RGRvY1REL2tPYy9RS3gySVpaS0xYN1plNFh6TDdkdGhSbDJhNGk1bUlLd3BP?=
 =?utf-8?B?aGUzY29ieDMzUG8xL2t1eTAraXBoNUxneHJsaStxaHhCRFczRjVjWDcwSjRh?=
 =?utf-8?B?RmhVakI4UFREb0sxamRQK0JVMmFpUmE0RmpUMG1tajFCdEpGdm9ZbngxT3lm?=
 =?utf-8?B?RFpVYTNzV1kwdktENURvbmt6azR3Q3Ywa3NlOUpFNGdaMVd4b0NqNXRQajMx?=
 =?utf-8?B?WW1oS3UvNUpzL0pnM2x6MFJoWm4wR0pid0t3SWZVeStVNjlUczU0Mlg1TEcy?=
 =?utf-8?B?eHNVVEwyd0tjcTBqNXE1ZHJmdEwxSjF5QjlIVWVXNWwvaXlPMlZQY29jT3NE?=
 =?utf-8?B?VjJWdTdvckVpVjhpN09Ca09sMlZzSlhsUGdFejNrdkRlYkxyOEl5KzNCOTdD?=
 =?utf-8?B?U0hmREsvbC9NWUsrYUVGZ2dkWVlZMmxXN2FxaGJUTzNFUG50Z2dlYUpaNnlp?=
 =?utf-8?B?U2RveGcreTI2MlFUU3VsN3UzUXFLVGhwR2RFN1BIUUxiWFJZQUNWbCtTNXYv?=
 =?utf-8?B?c2VIRHBQZk9wSzM0Q2xpK2RkM0RnQ1F2TzhGZytvOEhXQnZxMmszMndOUEhv?=
 =?utf-8?B?Y1RQNzNjYzRoNXNFcXowbXkwNEJzOVRuWVNCU0xGa1NRTzgrTDdkV3VxOGYy?=
 =?utf-8?B?WTNOU2w1UjZYeDIydmIrakVJcW1FMnA0TTNTY1E0akNscmRyMm1VSE9LMm45?=
 =?utf-8?B?V0hubDY3RVh1TXd5N0hrNXErS0FhdGM1UklDMlJhWjFxbGtnNlcwQTB0Yk1a?=
 =?utf-8?B?aTBtd1QvMFlFQ0Z2ZXBDdGtpaHEzaW9WaGd6VmdHZG9YTXFYNG1yTnd3KzRo?=
 =?utf-8?B?Q2MzS1REYmVEODQyZC95d0tRSzBraGQ4TTNLZGNaaDNQOS9qbHJSUzVETUM5?=
 =?utf-8?B?U2pMQ2g4U1k1RFh6d2luWWJ2RTc4bmpaOWo1aXJHaE1kZXlkOGpiN2hXaEp4?=
 =?utf-8?Q?YCLIsdLb9ss0265E=3D?=
X-Exchange-RoutingPolicyChecked: YZJ+zx7WcRu6HkbILQEGTVceU8tM3BVTIsBbnoNeFASsj5pbw6865dNYxNgRPBKSXrnpMrG3Zu3ylO8m766EG7vHdy00iTfB3E3/zpRs0sgrlhR3JYWUVe0yvnKkNB0Xes412MlwPZ7RULT6gG1VcwMicNG286KVOtB3A1JADuyz/JWZr/tvVr7biXbqxUvNCYzpJfo6mNeHEK5/3M2xct77DR1PBsaSVz8lMflcn/it15ZynbzydStnutZG2ADUoJwEp9YhQidr8xHZ2J7cm5RqfaoY3mNmgg4keQoMvR9RtqI/S6laoFQzxIvrgqL9y6XlJ2z+sQCZk+G6tvz+ug==
X-MS-Exchange-CrossTenant-Network-Message-Id: 92fd666f-c02e-4d2a-b2d7-08df49b3ac9c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7710.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 22:46:55.5489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCkjnG34EOD94WgD8aYeU+QrjtKTKJ+aoXT5a2ufPVa1u6tS33LXnf20XeA2rKgdTipY9gvmSjMQ2FKMFSW8BQ/rBoe93P8/969DZ5Ni0pA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9136
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



On 11/23/2026 12:55 PM, Jakub Kicinski wrote:
> Fix Intel drivers not handling RXH_XFRM_NO_CHANGE.
> 
> I had an urge to "fix this in the core" and hide RXH_XFRM_NO_CHANGE
> from the drivers, by fetching the current config instead.
> But "NO_CHANGE" values are already part of the driver facing API
> (hfunc has ETH_RSS_HASH_NO_CHANGE). Besides we can't _completely_
> hide RXH_XFRM_NO_CHANGE from the drivers, since we want the drivers
> to be able to populate the defaults for new RSS contexts.
> We need a "user didn't say" value there.
> 
> ---
> 
> Matt pointed out that the upcoming RSS sizing series breaks
> NIPA tests, this is because the fix we shared in June:
>    https://lore.kernel.org/20260626152636.1e48330f@kernel.org
> or Maciej's version:
>    https://lore.kernel.org/20261007200311.730443-1-maciej.fijalkowski@intel.com
> is still not upstream!?
> 
> Recent discussions suggest that Intel maintainers may be willing
> to ack patches on netdev directly. Let's put that to tests.
> 
> Note that I think this is a major bug likely to bother real
> users so I'm targetting net. Przemek's series will have to
> wait for net->net-next merge.

For the series:

Acked-by: Tony Nguyen <anthony.l.nguyen@intel.com>

> Jakub Kicinski (2):
>    ice: don't unintentionally switch to symmetric RSS hash
>    iavf: don't unintentionally switch to symmetric RSS hash
> 
>   drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 3 ++-
>   drivers/net/ethernet/intel/ice/ice_ethtool.c   | 9 ++++++---
>   2 files changed, 8 insertions(+), 4 deletions(-)
> 

