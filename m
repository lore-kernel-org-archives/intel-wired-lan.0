Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D88B606A333
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Nov 2026 14:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=rKy/G49a;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BDagBk/5
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E92D606AA;
	Thu,  5 Nov 2026 14:11:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FzMZ0GUKL28g; Thu,  5 Nov 2026 14:11:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9879360778
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793887915;
	b=FqPqqBvIYUP5mGtCUl5M4+Jp82jo5qEYW8oU6YjiuA+OnpE7P9UwV9G6CnRplecA36dl
	 htz3R+MIKk/pH5Q1CeSitpX0lVCNWgR7HB/T2akeoJIU+pGlskV/01sr/52GSC/dzmPaV
	 NW8s3drQ2vzQ0di1ZjYsFuthS8Lc0/YoG5+BEB00vpQChzJyFnWNzKqfpHoX6JxWiAiJ0
	 84ayn/LSMrI6o+XBITZsr8HcafBuYxVomoy7dmlRr3EXEbk6j5UAu56LWzNTgHq7qdmVw
	 BrdENzqg2hlldT57nUctiqnC5I/HhcqQDQMT1gAzD+Unl+8I/wuGCWZOM+ulYVwOZLg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793887915;
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
	bh=+EhZVSKo8vUuARQsfJnlnIDmSeARI1dhIbAqylQlIUk=;
	b=iRw05QtFRLfmH5MHUPeNcTGnNn/ZRMw2EbD/JhVeCnaLwYsyzQhXU5C2t6izXViA+6MJ
	 F47FupEcCx57M2z3Nsgd3a0WMBzRnfFJJ58v19EirzmP0jFF3nqmvCgNzRzkrVLqnFFzR
	 tF13JxMfumBn7SwG7gWNO92fT8fgS6pw4qpMzpcs+9KHyqLF4zhk5MTRN1CgOGzxWDr16
	 BLbTbnue9ZyllTULfyCYxa2YDV6R5Q3wBGFGUgDHe0fTpSnRxaR2STEKQq8Qb3dD4TTXX
	 X+9FbhIF2Ms9LFrT4of2WPLiK8BN9r0+KKa5Vf55TBHi9QTr6NG78xFOwb4F0Jy+RAg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793887915;
	bh=+EhZVSKo8vUuARQsfJnlnIDmSeARI1dhIbAqylQlIUk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rKy/G49aV+LB4kYsjL29aiGoA/YjDcBWnDt1VE+24mPVnNoxxJb5AU0yIoy+Ml/tS
	 f5FqYxOGEucDOeH92Ela3apAPAyTs3dSNyXksXaAgp2TlCU+lw0GumWjzSJf1rahtF
	 KSkn/lC7vsa5QV4IvxKpkquGVIAUoQFcBmQEEqUQpvYRLWyaQwa8loHDwOmbnMYB2a
	 O47VX4EWGaCSJHsXqBWxFOcZrWojsKsvhbtN+Jq3xAz+v9en+jliBROTwwW07kjFj4
	 cVoYdDxg3nZ9cOjrnyHee50rRbm79PvkLKqsg9y8FYiwrm5KZI7nypPfilxYpfjziR
	 +0dwBemjn/Fzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9879360778;
	Thu,  5 Nov 2026 14:11:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 935B8235
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 14:11:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 84ED34088E
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 14:11:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HsfoDFKJBJ1R for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Nov 2026 14:11:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D9DB040842
Authentication-Results: smtp4.osuosl.org;
 arc=fail smtp.remote-ip=192.198.163.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=BDagBk/5
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D9DB040842
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 14:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793887914; x=1825423914;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=098Vf6QAqEkTRBagjr5g8v5CfPbbboAiOakAJdEQ9C0=;
 b=BDagBk/5uy+Q4zhfnc563H+7M9TiyXZbtTuFCQZeObLShdAzx8i0i5C3
 kVkCCNN7ZUTKY7yN8rG2GY2tNsCADGSfFeoXb954nEckkRVgh/LL1IUFs
 REBSyDpQGB5L6GFCAWSNMPFPmzKcwR2UBcCYOA6BIAg0AcDIUxpTZCzBr
 tqBkqVloaVUtd95Cw1gjH/Ck1WFqnwwbOpao0s/2rg8hTHEgZ0uUFBKKk
 2U30yqwXzB0MrqG1pi1JyyYoTzJ7hxEWJXzUA5HDH1DMSQEf4DPbhHcg2
 wSSezUHEpOD6Kt1sJQj1cR65Q2b9ekQyA3cIVvHor/wdhY3JhL1S6Cqy7 A==;
X-CSE-ConnectionGUID: AEEhasfAQ5Cvl7W7u4ZlQA==
X-CSE-MsgGUID: 4w6ivW2ORpywq4E/c774TA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2681424"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2681424"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 06:11:53 -0800
X-CSE-ConnectionGUID: kmDOPOxuRtWrJ+x2bAYqMg==
X-CSE-MsgGUID: Qu729sf3QsyXChpNwMYHnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="8780587"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 06:11:52 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 06:11:51 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 06:11:51 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.7) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 06:11:51 -0800
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by CH3PR11MB8363.namprd11.prod.outlook.com (2603:10b6:610:177::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 14:11:49 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 14:11:49 +0000
Message-ID: <a0257569-faa7-4ecb-9488-077f674781df@intel.com>
Date: Thu, 5 Nov 2026 15:18:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v4 15/15] ice: support up to 256 VF queues
To: Petr Oros <poros@redhat.com>
CC: <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, <intel-wired-lan@lists.osuosl.org>, Simon Horman
 <horms@kernel.org>, Michal Schmidt <mschmidt@redhat.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, Jacob Keller
 <jacob.e.keller@intel.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Brett Creeley <brett.creeley@amd.com>,
 "Ahmed Zaki" <ahmed.zaki@intel.com>, Mateusz Polchlopek
 <mateusz.polchlopek@intel.com>
References: <20261103141646.303620-1-przemyslaw.kitszel@intel.com>
 <20261103141646.303620-16-przemyslaw.kitszel@intel.com>
 <20261105122558.1701877-1-poros@redhat.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20261105122558.1701877-1-poros@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0009.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::6)
 To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|CH3PR11MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: b91064e8-38c1-492e-3c6e-08df3b46bb6a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|56012099006|261028144727099003|4143699003|261022105027099003|261026121527099003|261026140227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: StWgQ1abbgDHZVqU5OZTBnBX6KU2KQZw+GP/s8dcV5KC1+Z6NK2ev/YmPMMZu4DHHnO64/zNQXD65/fLA1l0LglQLP22PjYoj3OE+0XNuHMW3Yb0uZIXVHxdbr1zN3+aHMOGZ1UyNIw0PbMbvjkYMpU5W0f9CecwIRsJWgnLLAoFplfZwwxQq+djhY0ZIirIjWu1S+KJCqvkD7Ed2cgVD49Qc6XJKwagslaRU5m5YHAtOAXM2d3llMe0REeZgqFXIw5jReYn2C5aT+E7qeceEIMks8ML6kqe1FC1I4nwt4dYlmPe6iOHQmXeWvjFiJVzbdD3dnE7wbyt9PcOnsGzMIaAUIj73t//yx46phtb7/98uQof1AqnA9k4ZQ9ZDolVFkYCfOUB7SP0QyVfF2R88RKSBR8Urx7lNH2imYq1VG/Bk6Y6Gf/bX/iqvhutbvOPUJ0BtGebK7xHjkgkDjuI2byMuE7Ttr9SKkXYCiNuVTs9vUb+fIgavTJaaA+t1drnwJa0vGGOlhoLsL90Ktoqa1S5E5vWqE4+wLxYNqLiyq4NWCdNHm3MSLhTu7kdNAga729c6sRSRABPNyt/u2eXnMH6ajGvtYPdykP43MMd2dAbqp68CeBdE6V2bswu+BF9+jmKjsXqU718bHCEKg9UMCS4EraXHYlCD133mnttfE4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(261028144727099003)(4143699003)(261022105027099003)(261026121527099003)(261026140227099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDJCeHpPM0Y1K3JQbVZKZ3UxMEFTUi9LYUE3bktzS3RXV1RXTk1SNkE0bGZw?=
 =?utf-8?B?emRFMzZQYklKZ0ppLzhwMTZieWJPaU9SWk13emcyWFVHQlVhYThnZlVSWGQ4?=
 =?utf-8?B?d3RsZklDOTFXSHZUTmNhZVpMOU13NWdDTGVnMmlZSVRCdys4NGg5cnhSc1ZK?=
 =?utf-8?B?T09WNVM5elBpRExTSU9mYjdxakZlTXBMZVVCMnVEV1BKRHJNRVJ2b0wzNWxz?=
 =?utf-8?B?bWZOWGxuMHo0dE9jT3Y3di9lN1JHYUFON3pnQmFqQi9XRE5jeTA0RTVaKytE?=
 =?utf-8?B?WHpKMkxNWVZDOFRJNlN5S3k2VVk4d0pSMHBEV1ZrYUJHU1MxeEhlSm1XTjRO?=
 =?utf-8?B?T3J5KzRNZ3FQbDZObFZSa1lsb2ZqckVGd3lvWk9SQzBvT2ljeDZIM05XNS9i?=
 =?utf-8?B?dXR5N3RSbUJjaHR6RENndnI5dHJJa0phb0gydEhhdlZmZ0R1blJrM3MwWW9N?=
 =?utf-8?B?eEh5SVVEMGZoUHBKeGpuVGxoWU1XS1RPVXpoQ1ZzMENmY0xuMWE1MmVtcmNr?=
 =?utf-8?B?VWM5Tko0eURLcldUd2RndWJqSlhFVmMyR2twR0JGRytWSGRBYXpMeXAzSjZu?=
 =?utf-8?B?Y2JVZDU2cy9UY2VqNitQNXJBbXZSQUFYUU5EOGNqOE56SEQrSnVxajZSTFNp?=
 =?utf-8?B?d3krRW5RMkV5YzFQejJCbCtLWEcycU1xOUxmM3c0VmdiNFp1cjhYaUpNbjNz?=
 =?utf-8?B?Q1NvbXkwY3BXNVc1Y0UvbVVWcEZIbis2VDBad3hBeGRIdnMwZTZSY21mbWEx?=
 =?utf-8?B?L1NvUEcwNTdGSGh2RlBzZCtOQkNwUk5HTE5PZlRhVlFqZGY1VWhiQ3pXVXcy?=
 =?utf-8?B?Qk1OM1B3c2hlREF3N2xwRWo0aEg4NmphdlZ3NEIwa2JVZlE2c1dCZE5qamFO?=
 =?utf-8?B?bW55d1JlU2hTME1wSmlnQlZEMU85UUU4NkNyeGxwcEJKV3JnZEU5ODFRRldo?=
 =?utf-8?B?aThPQitmalBKdmNsNWJnYzNGQkZmalFRcHJ3RnVYUGtDTTlxVVhBdUcrZ0Nu?=
 =?utf-8?B?WjhGWmZhMC9aQXIzSFJ4dkVnZHFYeTBJRzNKM3VLMytRWkNaRE5jQTE3Q3Fs?=
 =?utf-8?B?RlBUb3RnNnFTWmMraVk3OWwwSkJhNkpGVnJmREpoT0JvT0Y1YUdkOEFtWUdv?=
 =?utf-8?B?NFp1WmtVV0NiM0JsQVZPQzdKWEtYNWQzVm9HSEs3dkJvSWdkTTJReXBHaG1B?=
 =?utf-8?B?ZmRna0RnZFBNZG8xNkRGR2llVFdSM3VldjdjR0xCWDRKTk8zc2wvQzViMFhu?=
 =?utf-8?B?aDZROUdxdDZlK25kTEtHdWtDbGRTNHk4VmNYSHJBSFdXK0kzeU1ma3lkS0J1?=
 =?utf-8?B?RjJsNTRKenloNy9qSm5SZE0wbmZtcEJLQmFsdGNJQURuQmhYVmlBTWt3ZFhR?=
 =?utf-8?B?R0RKcEpHbTZESGk1d09maGYzOTJldFpyWEFVRW9KK0ZaSjlDZXJJTmFTN1ZE?=
 =?utf-8?B?WmsreStGODk2aFZtNysrQ21UUVFPd1lIajdyYSsxaStkeWUvaGpra0lHWXZ1?=
 =?utf-8?B?eXhkY29iN29nNU4rOGpGT1haOVlHVVhsRDhRWm5kM3ZxZnZnWUpLbFhrbE5y?=
 =?utf-8?B?a09mRFBseTdMeHc0S1dmVXJ4WGVkbG9jQUlNaUpNVy9RbFJqaTUwMTNjNUNX?=
 =?utf-8?B?bVZtNzVjTEZoSG5VazdUSENtYnkyZFV3QTY2SUpQR3JGWXkzbTl6N0JCZUxT?=
 =?utf-8?B?MDRXeXNoaGxxVXVLWHRMUzNNV1lnMENDMmczaCtrSGlxcE9MSFJJcm9rKzhE?=
 =?utf-8?B?akdudmxla2Nqa004Z0RhMCtUbFQ5V0tBbERkK2VPL2g2cnJyd2RQQjByNVg4?=
 =?utf-8?B?UTFWS08wS0hLQndPOEpwcVNCTUt4ZE1rNDFyWmJUM2dIWGJxbk83TEp1TndF?=
 =?utf-8?B?ZHlVNTJJVElMNkExM3ZxL0FWQ0xxZzA1VXFMSkdLdUpBWlhNQkVZK3JHZHVw?=
 =?utf-8?B?NVlnN1o1UWRYZ21kV1d6NVVFNjBPZ0VEbmF5M2R4dzd6clR6ajR0RUd0STlk?=
 =?utf-8?B?R3puWllaZ1l1L1NrQWFZaGxLZGJWVXhFYlZ2U1cvcFFsZU8zSDg0ZkZVRGV6?=
 =?utf-8?B?WGJ3NWVJeVNFdUFMeUxsc1E5cXNxbVFwMkM2N09UWnMwUVUrWDdpanU4T2g2?=
 =?utf-8?B?UGxGbUdzWXM2THNMUlVodEErVHRvcldyaW90Lzl3Zk9MY043b1BJbUl3M25t?=
 =?utf-8?B?VDhSYlIxUkpZMGh4Wk5udml1VXVIKzR3UU5pRHU1ellOQ0FUM2lQVFl1cEpI?=
 =?utf-8?B?SDBTYVlXQ05lc3EwNTYyNnRCR1JGWU1KYVRKUFBSRjRXcHpYend4ZnR5dzU3?=
 =?utf-8?B?SFg0NjFUME9YSzFRWFNvMEdqd2ZSQ0VsRDVrWlo5THh0QzZzNHFrZ0VIMTZy?=
 =?utf-8?Q?sdssffIYMzokyFik=3D?=
X-Exchange-RoutingPolicyChecked: kPG8fTTRXS8+TiBN7ANnZ/ljZbnUi7zgyiKDW7ZxF2571eOupKOmAZauuPe2OrGUJF9uVoyVE1W+yC1FYFaN4ogA7DkxXDVEAZiFZdAcWTqLxVsnOOCH8mbIrmixLLIIEkVYFtYP3LXqXuZdSURbrhukrvLt3mfztrtINA52MhXNoSsfeW4IEZIWAMN+dpAJ6ghek4utVdDaSIBjQe+F/VWBrO2bQdL1eVNslHHlUImJUua3ALgB7/w/p2LF6gtkIJnyt8OP5cJV9GbNNp3dW1w0f92/8NHQdg9897hxwdDHZD51oWFDQ3vzVln5GLr8wy+L8JMJUD8Apn2yuW13AA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b91064e8-38c1-492e-3c6e-08df3b46bb6a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 14:11:49.0211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4VczLIvxng6vnkFMdyVVmJ+T/VZ5NlB+nqiJxYZV2X1IVGvd9TfgJkz9Zj3iZKUXTiNTXusSlLs2063u2fpfg4iKMLHa+H2NKYXPILZvzZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8363
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

On 11/5/26 1:25 PM, Petr Oros wrote:
> On Tue, 3 Nov 2026 15:14:56 +0100, Przemek Kitszel wrote:
>> Add support for up to 256 VF queues. To enable more than usual 16, user
>> needs to assign GLOBAL LUT (devlink resource named "rss/lut_512") for 64
>> queues or PF LUT (name "rss/lut_2048") for maximum of 256 queues.
> 
> I ran the whole v4 on an E810-C for SFP (4 ports, 10G DAC between two
> of them, FW 8.1.1 with mgmt API 1.7.11, DDP COMMS 1.3.55.0) on top of
> net-next 7b6ab4dbc156 with lockdep, and again with KASAN. The
> documented flows work as described: PF and VF LUT assignment, 64 and
> 256 queues on a VF (also with 65 MSI-X), VF FLR, iavf unbind and bind,
> PFR, CORER and GLOBR restoring the default assignment, the ADQ
> exclusion in both directions, 16 VFs taking all 16 global LUTs, and
> teardown with LUTs still assigned. The two problems below come with
> this patch.

thank you a lot for trying this!
next revision will be needed
pw-bot: cr

