Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1BD606A6BB
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Nov 2026 23:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=o3toKvSQ;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VybnGudq;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Q0K1QA/A
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 243D180E25;
	Fri, 20 Nov 2026 23:21:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wkjNNYzq576R; Fri, 20 Nov 2026 23:21:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 42918817AE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795216878;
	b=njs8xy6zdDJR3g1uzMEl4nB7x9O12FF0HVRrEKpO8gBbWJAqdvLBGY5tkpmwF20i5R8h
	 gotlLfjcFW77tL2WKvfQP+GhdOwjW3Nvo2thZ0skQB/HHPXc3Uz/jOyaOESe7WBNfq0a4
	 ZG8xkESP3+qvfFfdi5GovhG5ptyvpFU8HMYyHvA8bfjADteCI4g7ZYijogAPo8JIOei7q
	 pdrbiMr83XPGx5r1/UKCqTfwv32jKqHYvLEhNtXDSyLoXM3cvdUqCUNZ/P48o50wd+adi
	 ACTvqz+ZaNB1os0rCFX37/XWzIEB45Skh/2DOeuRO3Wu+ScGilfWzAnmDl6EdaMdT+g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795216878;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:To:CC:References:Subject:
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
	bh=7gwQCXm1cH557TA7fl1SjFTSEZoLxuivVr9yqnJMLpA=;
	b=bZKk1exZ5GKnOSAEIZsgKE97RzBCeYrqgjqF51REzZDyDTH605RWoacUkeSmtdDMPSiX
	 ZqYQTq1lzbi+5y4Xpen/eyvSy960chrO7KTLXrHQO5AT7hriakwx934wIh05b+253arek
	 ReRA45jJa4CWWNdbTy/ocXtrxzTcHGkwwV30JXvkNehnM+kEy3MSWFceDEpugh9v3pDOg
	 BMkO8wg+92+o0NUqj1x1Zw0mkUdCGXxTzDxTX8E82iCViOhm62NofftQyDGWN6aiIpUom
	 jVh984o5l0M20tur3/ywn20DxB/p9Sww3STENGOycn6YEaaaqOmig3x1VFyGyU53Kvg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VybnGudq;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b="Q0K1QA/A";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795216878;
	bh=7gwQCXm1cH557TA7fl1SjFTSEZoLxuivVr9yqnJMLpA=;
	h=Date:To:CC:References:Subject:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o3toKvSQoshDK68Z8dUiw4uUvuzd4fnltjJgIOsAjFwM0HoMWH4q9U6V+dVtyOML0
	 idDC3RGEMkM/pNbCBRIUbwxP7vytFHJJi2gvFySK78LlGwCo0BiyeHswiNZhN+1imf
	 qj4h7S8otCI4k9MZRDksL9HJMzylfmD1imDbzhEtCQ6oYY6jOElEkJCaCfWvN/yhRx
	 InHH1Py2Q/p0vo0xrgO1MxtPFRs5MN5EUxk355tkXoL7byL7Zay2D/S4LAk8dqFUQz
	 J0vEW6lhRqBhRQhtZFzZLplOduypSHLKDO9elKJlhT2E3zGGZUG/97wHMWE8Y/FM2K
	 XXC3zmu5raeJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 42918817AE;
	Fri, 20 Nov 2026 23:21:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A9CAE1C9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 23:21:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8F164817AE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 23:21:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nup0msKVYL8O for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Nov 2026 23:21:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1B81680E25
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=VybnGudq; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=Q0K1QA/A
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1B81680E25
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 23:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795216875; x=1826752875;
 h=message-id:date:to:cc:references:subject:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=G03BLhK9jJtvwgVBL9zwcBPU7g1JYs1dEG7r3Kj7wNY=;
 b=VybnGudq9rehWK01Z48t3R/e6AYtQR7PwrDJqfa9CJVNGtcyEyRqtx0m
 4fUkfgTKBAJA5pCSnVirCKpCRl7oAWn1tvJqHuBlRebauHgiqFKxorI+t
 HlJ13GyotEPDBY3xBfFbZndTJ0TxinbGbj7RBJpvCWUVtRqodYDvxtaUY
 4jP7UV+6zJFSnDKSmkbwM86/rzOuYnXNZYm2EcPx50iluV795tTsecOnU
 x+rneS85/+YW8NmnQcRfStrWE3GI8lkDDQpP5VDG794MV1o94dPDl7kSe
 f4HZwv1/lHXyERMvYbwgaeWUAToAgsS3of+G9frJlS6HE6FwVCOovqaK2 Q==;
X-CSE-ConnectionGUID: V6JwEup0Tmep3qWYguR5fQ==
X-CSE-MsgGUID: GtaKjRI7Q6KJSg+iUAPz5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4119153"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4119153"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 15:21:13 -0800
X-CSE-ConnectionGUID: aj9CqqRCRK+dLz/cx0jrtA==
X-CSE-MsgGUID: hNuyJOUhT0mc7QXKb3+gZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; d="scan'208";a="11227441"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 15:21:13 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 15:21:13 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 20 Nov 2026 15:21:13 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.47) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 15:21:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gwQCXm1cH557TA7fl1SjFTSEZoLxuivVr9yqnJMLpA=;
 b=Q0K1QA/AYTxib/Hw0uIQ+x7YYBGtMqpqh5MldhsWz7z8mGigltW0UQob15gca2UNzTgNK0NXGLxN2wNJ4UyIHmVzodTeEJ9uG1FXcnjK5+RqyvlgkGY5FVT/T2iqJQ5UJpoPu4F2mGVTOXUIUDR8yXGjY+DDg6TWM+lRjUnhJtw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8441.namprd11.prod.outlook.com (2603:10b6:610:1bc::12)
 by SJ0PR11MB6790.namprd11.prod.outlook.com (2603:10b6:a03:483::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 23:21:00 +0000
Received: from CH3PR11MB8441.namprd11.prod.outlook.com
 ([fe80::15d4:2e2f:50f5:75fd]) by CH3PR11MB8441.namprd11.prod.outlook.com
 ([fe80::15d4:2e2f:50f5:75fd%6]) with mapi id 15.21.0615.015; Fri, 20 Nov 2026
 23:21:00 +0000
Message-ID: <6fa3928e-90f2-42d3-86c6-ddc5492b51ea@intel.com>
Date: Fri, 20 Nov 2026 15:20:58 -0800
User-Agent: Mozilla Thunderbird
To: <przemyslaw.korba@intel.com>
CC: <aleksandr.loktionov@intel.com>, <anthony.l.nguyen@intel.com>,
 <arkadiusz.kubalewski@intel.com>, <intel-wired-lan@lists.osuosl.org>,
 <konstantin.ilichev@intel.com>, <milena.olech@intel.com>,
 <przemyslaw.kitszel@intel.com>
References: <20261112102301.342584-2-przemyslaw.korba@intel.com>
Subject: Re: [PATCH iwl-net] ice: fix stale cached PHC time after a time step
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20261112102301.342584-2-przemyslaw.korba@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0188.namprd13.prod.outlook.com
 (2603:10b6:208:2be::13) To CH3PR11MB8441.namprd11.prod.outlook.com
 (2603:10b6:610:1bc::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8441:EE_|SJ0PR11MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a24b766-b15f-478c-7eb4-08df475cf037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|261009223027099003|5023799004|11063799006|56012099006|261102123227099003|261026121527099003|261026140227099003|261021123027099003|261022075727099003|261021121427099003|261022105027099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info: N+SX1vu621i0l3PPuiVHED37xLRcJehOBhADqoAEqp6TVTE7LQKyuWqwftJ4iEbjz2K6pjgC//LtufTnOjCJPU5wmQHLpt9L85tm6zs0SUmw0KaNeKFhfh4HJEWmFyW5c1WQQhRS7NCU0gCAee9zfplTFnigD6Es7BKEfc/sa1whMMZEPLpHtGk527KugfZlQvsLNU3N5Pl+iVFnTdgzYAO5VoFV00YwFscofMPgMhC1y04Z+VG7d6FcwwZdNQCO0FnBh3CSjLX2bjzlQPfGoP1l5ykMswCSWM0rc0UQ1AX/b0OvtAbSGe1VduLBq065HKgF07DQ/bbb2LgiN4AwM0jW2BaX10jC8D8/wF11lq+8R1QrZoN62Zgwyr7hZWNl+UCWztwX178jT8rSRou7ANbUs/6z1tI7h+JgdsHtMYFRF/s//dj63JdAe3Sc1I5jbCRiuBXXcm8ffqr5oOq0cRBDLZraLWotOeKVRXSocjRu5ESQEKRaSGIagnfyn9s+0yQuiLPzN8VGPOpvLAVydf5a0poM/iGHxSkn9OTQESlWFHSHm3sLfqt7+s0sn/N2QafEB+aqxr64QJsgqIkFyBczukm9TBIiNP8NxjeuolvPiB73M90Q9LN8JDRc078FA8QgAXPMX6r+PB5dDvO4/4OaJHH2yGvvww9/VlpHZOw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB8441.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(261009223027099003)(5023799004)(11063799006)(56012099006)(261102123227099003)(261026121527099003)(261026140227099003)(261021123027099003)(261022075727099003)(261021121427099003)(261022105027099003)(261028144727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qy9CclErUFltUURkRFBaMmxMT2xJaGc2QkcySzl2YjNYaXNwVVJwS242bXZo?=
 =?utf-8?B?bFJOaUEwZWFkYmpRL2QzNGtndEVGdjZQem5UT2htSnJPcWFYN05OWVRsRDJX?=
 =?utf-8?B?SUFFdEduVlBKajdFckl2Y09udWRrTnhNM0xSaGlrUGc2T2NnZlV5UUp5VGlF?=
 =?utf-8?B?QXRFZ1BTTjk5ckZkQjI5TUhHL1RNc1dxUkVNNjk2T1pXczc4bkx4aGhmMUdO?=
 =?utf-8?B?TUw5djRhUUJ2YytMSnRSRU9YV2N5RDB2bGpJaEl1bkRpcXpUR1N3Vm1Ed3VU?=
 =?utf-8?B?bCs1LzJLemxITXB3UElkTDlGeEF6NlBBMXZhS01JRC9yQWpxa0tRNUJTaUZK?=
 =?utf-8?B?aWJNcUxKWUZNL3ZGdURRdWJ2ZXdzOUJPVFVoSk1CeDdTTnBCa28xY1ZFZGJ3?=
 =?utf-8?B?T0hNVEZSV3R5OUliMTA0YTFzTnRkWHhOM01GNlk2SDNOdW96dnFPM1Rya09w?=
 =?utf-8?B?c3Z0cUZLRlI0WVBuUEhNOG9WV2hPcVFHSWlaTEFEQTBDeWNUODNXVlFYbmlF?=
 =?utf-8?B?c25ELy9LV3hYYXpsZFp1cTVoa1hQMjQ5aE8vcS9ZSXhsa251ZU9QQmNiTGY0?=
 =?utf-8?B?TWJUQU1QWkEwdFkxZXMzNFJIdm80dndKUEl4NGFqNW1DeGVFZUxpRkhGQS9N?=
 =?utf-8?B?ZXRpWXVYRUVrMEZTdk94dnNnVzlqNUNKZWlzMjFMQkpOTUtaUjd2RjZlTmVl?=
 =?utf-8?B?RlhLbW41OWRzK1BrZng0RkhteUFrN1B3U25TM2RhTUNzMXAzVUoyZjhZUkZx?=
 =?utf-8?B?N0hjU2VEWGQ0VWptOTY3NlhhUFJLTzYxN2FjYkF2OEI0c3Ivc2hoSXdiWWtB?=
 =?utf-8?B?UUt5dzVMQ09hZW16SExYbzZ3MEtKUW4ycnpmelZ3SFMyODNXaW9RanV3Ti9Y?=
 =?utf-8?B?Y1VpaUNWQWlDYmFvQjg4bjRLUEYvMjZwU2NEcU9oaFdVLzNxM01PdzUrdzdJ?=
 =?utf-8?B?VnpCWVZLRmhUZFFqS2p2eGFqVWVGWGlVT1ZMbWpqQWtwRTRnV1hVd0JDd3NJ?=
 =?utf-8?B?SzVnWEtEcTRsMnlNQVh0SHcvM3QrK0lXOHR2Y0lXWUJGNU0xOVkwdGR2Ym95?=
 =?utf-8?B?eVpoNzdab2pRZEQ3RldVa2Jod04wQnA5aytOOTBGMm1kNExwOGVZR3BiVmRY?=
 =?utf-8?B?aC9CWnkvbGNOSkQyTkJ0S1ZUN3dpWVdjbDV4TjhuM080azhmd3A0MlplL25q?=
 =?utf-8?B?NzF0S2RIMnhrSENQOVFyMktqbmdGUGR4Ny9ubEYxSnYrblpiUDVCNnp6Ykty?=
 =?utf-8?B?SElOdG9La0FLRjIrTnNSb0xPazZPZGFncENGbVZhd3FNdkNFbEx0UFBCNnB1?=
 =?utf-8?B?MlJwM0hMdGJzZlF5cnJZQ21vWFp3Vy9UaG1JanRRcjJQb3hlYytLMTMrT1hv?=
 =?utf-8?B?N3g4U3VROXE4YStJSmY0MW9adllWaG9IMGFRUWxKelBGbEpKSmJxTHlCazlP?=
 =?utf-8?B?Z1BKa2p2d25tN3laNVZmL1p3SFpkMHJNYm02ZGRHVUR0OXRtZDB3dzBjSkpQ?=
 =?utf-8?B?ZHVtM3Qrd0ZtTW91NFVCZkpIU0N0Ni8rNlRMeHpaOVZ6Y2ptVnFvbkZjQUtv?=
 =?utf-8?B?aE1aMVFHdStBN1V1U0lFSWRManVUMk04UDEzcktUK0ZFWnBRN1dYT3pQaWpK?=
 =?utf-8?B?T3dqYStxb0tydEhjVFB5T05DTFp4UFlMR0w1eFlqY1crVGYyditFRUhQUzJt?=
 =?utf-8?B?RUZmLy9ZWUE2eTVmekxuQ3I0TXBYSE1Rclp0S094akdETVA3aUVUSEQ4eElI?=
 =?utf-8?B?ZzBMRHBBcnlmcGcvUHo4cGl2bTNTK2d0WHpYUmxVQzdPUUF1K21UdVJmVm5W?=
 =?utf-8?B?S0RuN2JRSlRoQnlBclNwVlFrRWJoUzVOTUt1UUtYUlpRbkZRSjJCNHVZeSt1?=
 =?utf-8?B?a0lJeStKb2NReStjcTRhcUlhVlJnN1U2QnFPKzRiVDNyUTFMUEtHNW1JZHl5?=
 =?utf-8?B?Y0I5NXE4OG1jV0V2SzJJYWpiclB1Y1d2MC9uY3dKOEZ1ZExyQmcyNEM2bE1U?=
 =?utf-8?B?SDhQODE4YTEwVmhOMTREZm9RMFY3RHBGMjViNGdrTSt4TElJVWllVGc2Q09m?=
 =?utf-8?B?TGJkVmgxSCttL1c3MlN4MWVkQTJ4NzBhUll5VGt0Ly9IREZhS2JHRGNGZHND?=
 =?utf-8?B?cGFFRm5FTGVuRGRITW5SaGJwWm03ckIzTnMrMHZzS015dFdmdHZaNG43R0wv?=
 =?utf-8?B?aU4yOWd2Tldwdkp5MkQ5bGI2RzRWNjdTc0VlQXEvdTJRQkRhZEkxWGJIYzBk?=
 =?utf-8?B?ZGRweGY5ZVZQWGQyQllIU2xFMElHVjVza1JBZ1lxcEZGdkQwekdmYTY5SWxK?=
 =?utf-8?B?Q1FDdTlEUFY2YWVxU0h4a1RHNlkremh0OFprZkk2c3A4N2V0cXRHZz09?=
X-Exchange-RoutingPolicyChecked: NxECCtG4/+lTY2eo5gdESCKvC7gWo1t0dRwXLDa3R363jF42GrCyFDDI/b8K5qvF9/Qd3dE8DlUoqBd92XLWFLNvNlt3JsBjWBJ98AapwVcUxfIU+Ucy74EA0FRVRvddzIsg2Z58mgs7pRm0kESearcgQv4E1mvdw2uy9LNNJObybFSs3jWeTyY1yuwSLcQ77Aks/MCNIaPoDaDHTU+Ak5zfUn9vJ+Q/vHz6vLFXTDg6IQaymn/3KIl8k5YDR6H9kwMjxZ/SsirzPN/MK2n+2dYaDEEEbncWEpNYafuSbDecJI9xXUr2OPQMCgEN77BbqpmZ6eFucsbhy7zxBnDf4Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a24b766-b15f-478c-7eb4-08df475cf037
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8441.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 23:21:00.4495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r02a8S0myEd3QQYcLCD4bZ/u5kSS3ctwoNtGxdCX36c/8Ve88nxUclSMfi3iDfbbT3NIr7YVXJWaQkTOZhXcHftpXAycTMwrd4McjigMOPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6790
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Przemyslaw Korba said:> ice_ptp_update_cached_phctime() reads the PHC
and then stores the value
> in the cached time that is used to extend Tx and Rx timestamps. It is
> called both from the periodic work and, after the PHC time is changed,
> from the settime/adjtime paths.
> 
> Nothing orders these refreshes. The periodic work can read the PHC just
> before software changes its time, be delayed, and then store its reading
> after the refresh that follows the change. The cache then holds the old
> time until the next periodic update, up to 500 ms later. Timestamps
> extended in that window keep the correct low 32 bits but take the upper
> bits from the old time, so they are off by a multiple of 2^32 ns. Two
> concurrent time changes can race in the same way.
> 
> For a follower that steps a large initial offset this makes ptp4l see
> the offset remain unchanged after the step, followed by a clockcheck
> failure and a second UNCALIBRATED transition:
> 
>   port 1: UNCALIBRATED to SLAVE on MASTER_CLOCK_SELECTED
>   clockcheck: clock jumped forward or running faster than expected!
>   port 1: SLAVE to UNCALIBRATED on SYNCHRONIZATION_FAULT
>   port 1: UNCALIBRATED to SLAVE on MASTER_CLOCK_SELECTED
> 
> In the failing case the offset after the step was exactly 5867 * 2^32 ns
> plus noise, i.e. only the low 32 bits of the time were right.
> 
> Hold a spinlock across both the PHC read and the store of the cached
> time. Whichever refresh reads the PHC last then also stores last, so an
> older reading can never overwrite a newer one. The lock is only held for
> the register read and is taken before the GLTSYN_TIME lock that
> ice_ptp_read_src_clk_reg() takes, which is never held while taking it.
> 
> Steps to reproduce:
> 1. Create QinQ (802.1ad outer, 802.1Q inner) VLANs on two directly
>    connected E810 ports.
> 2. Run a PTP leader on one side and ptp4l -s on the other, with the
>    follower PHC about 7 hours behind the leader, and run iperf3 on the
>    VLAN.
> 3. Restart the follower repeatedly.
> 
> This is not reliably reproducible, as it depends on the periodic work
> overlapping the step. With a 200 ms delay added between the PHC read and
> the store, 3 of 20 runs show the second UNCALIBRATED transition and
> SYNCHRONIZATION_FAULT without this change.
> 
> With a random delay of up to 100 ms added at the same place, and 4
> parallel "phc_ctl adj 1" loops running for 20 seconds, the stored value
> went backwards 579 times in 1509 stores without this change, and 0
> times in 399 stores with it.
> 
> Tested on E810-C.
> 
> Fixes: 77a781155a65 ("ice: enable receive hardware timestamping")
> Reviewed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_adapter.c | 1 +
>  drivers/net/ethernet/intel/ice/ice_adapter.h | 4 ++++
>  drivers/net/ethernet/intel/ice/ice_ptp.c     | 9 +++++++++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
> index 207e4fe97be7..9874380b642d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adapter.c
> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
> @@ -91,6 +91,7 @@ static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
>  	timecounter_init(&adapter->phc.tc, &adapter->phc.cc, 0);
>  
>  	seqlock_init(&adapter->phc.tc_lock);
> +	spin_lock_init(&adapter->phc.cache_lock);
>  

I think v4 of my timecounter series fixes this because each update is
protected by the phc->lock.

The periodic update takes that lock in ice_ptp_update_cached_phctime,
and readers get a consistent view because of the write_seqcount_latch.

The updates to the cached time only ever happen under the phc->lock
mutex and the read for the time to save also happens under lock. Thus, I
think this patch should not be needed with that timecounter series.

Do you agree?

>  	return adapter;
>  }
> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
> index d8da68e73177..45c82f8d7f43 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adapter.h
> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
> @@ -51,6 +51,8 @@ struct ice_port_list {
>   *
>   * Legacy timestamp extension fields:
>   * @cached_time: Cached copy of the PHC time for timestamp extension
> + * @cache_lock: Serializes reading the PHC and updating @cached_time, so that
> + *              an older reading can never overwrite a newer one
>   *
>   * struct timecounter fields:
>   * @tc: timecounter representing the current time
> @@ -64,6 +66,8 @@ struct ice_port_list {
>  struct ice_phc {
>  	/* Legacy timestamp extension fields */
>  	u64 cached_time;
> +	/* Protects reading the PHC for, and updating, cached_time */
> +	spinlock_t cache_lock;
>  
>  	/* struct timecounter fields */
>  	struct timecounter tc;
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 488db8298059..1486a6fc35f5 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -1079,6 +1079,15 @@ static void ice_ptp_update_cached_phctime(struct ice_pf *pf)
>  		u64 systime;
>  		int err;
>  
> +		/* The periodic work and the time set/adjust paths all refresh
> +		 * the cache. Hold the lock across both the PHC read and the
> +		 * store, so that whichever refresh reads the PHC last is also
> +		 * the one that stores last. Otherwise, a reading taken before
> +		 * a time change can overwrite a newer one and leave timestamps
> +		 * extended against the old time until the next update.
> +		 */
> +		guard(spinlock)(&phc->cache_lock);
> +
>  		err = ice_ptp_read_src_clk_reg(pf, NULL, &systime);
>  		if (err) {
>  			/* The source clock is gone, so the cache can no
> 
> base-commit: 34a70a40c954fb8044ecd124840a2c38cd3aa4cc
> -- 
> 2.43.0
> 
