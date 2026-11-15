Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9FA606A329
	for <intel-wired-lan@archiver.kernel.org>; Sun, 15 Nov 2026 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Q5pNyo2c;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GNkqAiUP;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=WSdZsLBT
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44BBE8108D;
	Sun, 15 Nov 2026 09:00:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HG4KGkUA2zF9; Sun, 15 Nov 2026 09:00:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 19E05810AC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794733209;
	b=aOBPDmx6QepCUti5hKC6zfloMIBWXHfvaU6RJsC32NJn5w3BppigKzjdrHS5Ekf9WLOc
	 8QyQRQAcbXnnmCwfWwi/iiGNkLvk4Hn6VCRV0g9z/ECmkWlUKDgipvFxHTSYK/D5EjJRA
	 VvfVs08yTTl/EnFSKNuAnionBNbGRryDgZZl6V0OHup2qbcedQT0SuQKts8+XVstMRoc0
	 M++q/u9ClGDDkCtE2QmFwLl/gkT/4sqbAS5bXhHDrjOWVCAvWJekuMOGwEg5BNdxuYAc6
	 u0fkZrRV9yPq/J3TUd1NnqcwTzFzanzhkDhrm9ZLQv4+h9ZcvM/bi9nUOJFVbfOByDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794733209;
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
	bh=+m7KSKNzpNN+VdGfwxaP6XTnoOD1HmuS7Vl45Wxs3Mk=;
	b=D8OSz7x6yMvXU71gHdJPoIIrquI5RdZL5JaNFaGFAvi8yMXd1bVfKxjaGhoQ9vk1YJTc
	 ROcqvCYJOQ5cF9HMJKMFQuXf90mVoUrVXk5+AnJmHGXJZe785AzQKQVR23NC3HWtkxslR
	 UuEi8LWYTHk/13BKc5aZ0V3l1U4z/9J7WPXIiCYuX/IzKJwY860cToBtzeO5JxJhHVbl+
	 9zrxr6quHDafD1lu+JVTouewWoeH46Q5DLJMFCnmpMyxFQMT8uUdUGAJ1Dtgv2YQJAgbs
	 rWFpOqslmfR7MFROUBY8rIQceaE5ajh7B++chXtsXxMd4We894fQH3TGR7KAGuaah4g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794733209;
	bh=+m7KSKNzpNN+VdGfwxaP6XTnoOD1HmuS7Vl45Wxs3Mk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q5pNyo2cfe+lpN3Mma1/U48XGxEuHt8/EehYqiIljD2/mc5C1m2ZNZzf0CPB0NqS+
	 NGmR25zk+jX7A+y29chU2s1cpt49UYYfuihM6um9BEOWnokDmtTuTNrxwQCEvi3xSn
	 vGhi5kEZWIK5UXAiJhDh6ODp6H+r+M6OzR1b/v+DGwY/bfyKK+bxwAPp7PeIsOMeVC
	 zqU/1QA3TKfchrDiNhGC+2t2TdH2Yv2kxLMI9pdgf9BlwD4qGzsTfn/LqZ1KfJDlhn
	 wXp3zuwpMDeH3LiZSQPJ6A+kmAR8ac4UkiNuL8rxo2AXJvciPZH6M875CNdZ6MUYWh
	 a+fp7V6nWLZPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19E05810AC;
	Sun, 15 Nov 2026 09:00:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6278972D
 for <intel-wired-lan@lists.osuosl.org>; Sun, 15 Nov 2026 09:00:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 48D336063E
 for <intel-wired-lan@lists.osuosl.org>; Sun, 15 Nov 2026 09:00:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9qyQd4pT0UBM for <intel-wired-lan@lists.osuosl.org>;
 Sun, 15 Nov 2026 09:00:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8D91C6071D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=dima.ruinskiy@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=GNkqAiUP; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=WSdZsLBT
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8D91C6071D
 for <intel-wired-lan@lists.osuosl.org>; Sun, 15 Nov 2026 09:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794733204; x=1826269204;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Bp5wp4X96BA7la5yYGUZxlJ2EnO4btgXwtjmnFEIlbA=;
 b=GNkqAiUPNOLLh27nN3MXIhfjc3Qe56iPVDx98ez7j48vnG5rNRrSjk3b
 EO1Zo5Gqmc1QromdyRtTzRVj57IbWA8r1xbWV3wXsJRLnuoPIOrlHOBY5
 mmE+LnhXZv445CPlxv8mQ2NKgXhjbSjkEEklXVX96Sqqrd+Yf1vzRxcAd
 8utT1hzxRAzBNcmUvilpBNpMu5Dv3T6QMpFvAwFwGUZhDOjz+8uQ4yyG4
 seG0eAMYHht/TZIv3xEwV+14IsoS3ntnJI+y7gYyWWNTPT9coD3XGJhxe
 SsGtN1Gxdnsm76yZrQ2rJY3q2pBulKBQD8kfQgESHmuJGz99ZgELjORAV A==;
X-CSE-ConnectionGUID: 7FqP/4J9TnSY3pu/xvCaCA==
X-CSE-MsgGUID: KZc5OtD3SvGLUDhfM5hBfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11966"; a="3496624"
X-IronPort-AV: E=Sophos;i="6.27,214,1787036400"; 
   d="scan'208";a="3496624"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2026 01:00:02 -0800
X-CSE-ConnectionGUID: IUfXnebtRjSTBYfIMNVN/A==
X-CSE-MsgGUID: jKIIxCNwS6GmNi+HJZx+5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,214,1787036400"; 
   d="scan'208";a="9170260"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2026 01:00:01 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 15 Nov 2026 01:00:01 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Sun, 15 Nov 2026 01:00:01 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.41) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 15 Nov 2026 01:00:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+m7KSKNzpNN+VdGfwxaP6XTnoOD1HmuS7Vl45Wxs3Mk=;
 b=WSdZsLBT6EXipYt+GN+Rc3965Idg5w6+eBNpz1SRSX+vxF/IQZIVArDIvtVF+k3GgK3IfC8vJTqsm3vDuK2kdcbYghZi6CQlh5FzqIEtiLtVEUOdSY5zk4DXZPUh6tSnllZ9vqxHHud16Pyj3onycu4tOXyu4fxyto4/uTmTD4k=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5630.namprd11.prod.outlook.com (2603:10b6:a03:3bb::6)
 by SJ0PR11MB5040.namprd11.prod.outlook.com (2603:10b6:a03:2d6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Sun, 15 Nov
 2026 08:59:59 +0000
Received: from SJ0PR11MB5630.namprd11.prod.outlook.com
 ([fe80::79de:af84:3b43:84e3]) by SJ0PR11MB5630.namprd11.prod.outlook.com
 ([fe80::79de:af84:3b43:84e3%4]) with mapi id 15.21.0615.012; Sun, 15 Nov 2026
 08:59:59 +0000
Message-ID: <e4b3ca77-4e70-4405-94a2-2cb4cb9889b4@intel.com>
Date: Sun, 15 Nov 2026 10:59:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] e1000e: Add additional systems to disable K1 list
To: Mark Pearson <mpearson@squebb.ca>, Paul Menzel <pmenzel@molgen.mpg.de>
CC: <anthony.l.nguyen@intel.com>, Christoph Groth <christoph@grothesque.org>, 
 <ghrafn@proton.me>, <intel-wired-lan@lists.osuosl.org>
References: <20261012214113.69770-1-dima.ruinskiy@intel.com>
 <eea9e99d-ef6f-4bd6-abb2-54fb9c53a7de@molgen.mpg.de>
 <5fbfadf9-fb27-429d-82d5-ac8dc87e9886@app.fastmail.com>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <5fbfadf9-fb27-429d-82d5-ac8dc87e9886@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0025.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::20) To SJ0PR11MB5630.namprd11.prod.outlook.com
 (2603:10b6:a03:3bb::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5630:EE_|SJ0PR11MB5040:EE_
X-MS-Office365-Filtering-Correlation-Id: c71ffa5e-e96d-45f8-4db9-08df42f6d377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|56012099006|11063799006|4143699003|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|4133799003;
X-Microsoft-Antispam-Message-Info: R8OjBkZ1aAd5NssdE+D2uvG5bgm19L5jPlvoOev3G8/r7aCkUpPb4WI50ht3pR1geJnVeZ5rmjzGHJRGiQoXhW8r3uwitRFeCZ8MK/4zD7qdRLdt8WfFSY8ZXMUnqhl+DUWd9TVBogIJ76uzQfbKlUduCeHg16oBe3yRgZ718WD7Tj4pdANX7yALz5m9Wf3Zj2mL1pOSijbUMkPLglAGFi5secfZA0H2Sl99Au4nIN9tmU3hi29G0nimXRh4XQVtuwjHqnJVCShptoV9RP/yq0GE/b+yLxs4XFL/js0oq5JcTcPtvJocpOZaYdygxFPaTxirzXagW+YPjOUjR710yHiStZqEieYC+ZNBhjyf3DxPezpMOn+HsJh0DVyDlufHe3Xx0tYXHguX8NsO01xtHLFezJKyIR+EQKP3x0iBncuStiXWpTnKVJLJz4nSxATaVnpaiT4WEYkqF9ANF9sJPLJCEj6KvWlfjc/2LeJfHhxxF7rYiovI5G6Cc76P+kpjDnkrd4WwqQjBPDPfaUT9qfZrgRPOsPaC67MN4w76OzNAH0ngXGoqZtmb+WxrBV669K8hTIEOungCVFWgkUg57MNitcTWoIb43KKCafw0WxWUJFidq02dNP4DKfIonpzo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5630.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(4133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmxHbHhoS2VQR25YZU1TalhseU1jSDhGK3ZEMEVlOUxodi9xTHVsUm9vQ2Fr?=
 =?utf-8?B?TDRYUkdLTC81T3BJdVgrSVp4M01sN281MVJpRHhVWEczallMVC9qY05tTzli?=
 =?utf-8?B?REJZS2tDditsZE45akxlaDF0VnM0ZUNpU1JVcDJ6Wmd4V3l0NUptMnBrKzZz?=
 =?utf-8?B?QXN5c2c1SFFFSnAvelNNRTUyb203MlJhZ1VZRnkyNDllVHV6K0RvSllMV2JY?=
 =?utf-8?B?aCs5c1FMSXBENFNxZnppMHBoVTUrU1JLVlF1Mmd5aU5vN0JCSGhCdGNML2ZH?=
 =?utf-8?B?OTdoOGpteWVSd2lhYTFMWGhEQWVaWVlmcUlwU3h3UllZWjJsU203V3Q4blRY?=
 =?utf-8?B?MzBLYnZlN1J6MWNFbHk0SHJYWG5lQjBjM2w4YnJ3RnkyRGtoenJVeHQ3YStB?=
 =?utf-8?B?d29uamRCbnFNZVAwMVV1NW1BK1ZhUmcvYm1KOU94UU5zVFZrL2VIZlEybVlv?=
 =?utf-8?B?RE9PT2d4eEhwOStPVEk5SVErLzE4dkQwb1kxZFlhM0lJMG9XczF6RXphUEh5?=
 =?utf-8?B?REdtSW5rS09iRmo1SFZVaDF6dTdaWTBWQkFwT1Uxb0ZtRk5pNldCSXVTSCtx?=
 =?utf-8?B?djVUYVEvOFkwdUZyUURYdm9WaWVPKzR6TERwNFlDb21rWGtrZ3ZUWERGQVNK?=
 =?utf-8?B?MDFEakRFem40ZzgrcXE3OTZZT2oydDh2ekdKYTQrbk9oaWc2NndsL0VXZkh1?=
 =?utf-8?B?ZHBTRFhoQURMWEliSlNaVXdSTW43UUtUNU1saXB1c1A1V3VaZ2grTnpaYTZw?=
 =?utf-8?B?TUVvUFBxOGNJSlRmOTI2OFhFem9RZm9MbjQzTmpVWWtBMXdpTVpSdG53eFkr?=
 =?utf-8?B?Q2k2NmJjUldhcktDZFRFdzdldTdTbEFEdkhxbk5pY2hCaU9aMkRyWnhOc3pG?=
 =?utf-8?B?R3pFK2EyVzFYKzc3YVBJdi81eXkvd1ZHZkNmanpQL29NZHZvK2U4eFlmNTRk?=
 =?utf-8?B?VlQ0K01RemZ6VGVETkhVT2N1WGJieUNSZzdBdlNLZEI3aTI3VmQ4akJSdGs0?=
 =?utf-8?B?ekRwRm8zUjJTVkpmdEFxTmFQUjYrYSt3NFdvMHdYZHV6TE9lanBxQm1pdHFa?=
 =?utf-8?B?RzNxbWhKZk1CSnc5eXdtYVBWZWt4N2VLVkwyb2piUGZ1eGx2ZUY0VUs5S3N6?=
 =?utf-8?B?UjQ1Zk90WmRMMmpEbkJoNWprM2ZmenBwOURLVXhrV1FBUWl1OXpFVUFmL2c4?=
 =?utf-8?B?ZHc4VnBnbnNtWU5nSnNhWEVlVkltNGFMckk1YSs1OVVBNnUxUEVOWDlFbkxs?=
 =?utf-8?B?NnVTQmVoK0pEZDJyVmRxL0FicG1ZMm5kTFFPWWFPZ0J5VUlNbW5jZ0x0QXZi?=
 =?utf-8?B?RFZBMWhkNWc5bWlZSU1FNkxON3YvQXV5TlY3VUhUZ3MyVTBRMUVUQ0Fqek9C?=
 =?utf-8?B?bnkvdnZybXZKTjZlY2s0RkdRQ1Z1K0JLSGtJckFEWVRQeVQwV2VoU0c3dHRU?=
 =?utf-8?B?Z0lZL3ZJMlg2S0YwT1FmTTcxc25XYTF5K2JuT2ZwVVU0aUxLM1BOWDVZS3Vr?=
 =?utf-8?B?RWxqNDdJVGZtNnp1NkhqcUlRdHArSUxpcVNzdWlvVlN6QTI3YTQvbW5KaElV?=
 =?utf-8?B?cnNTRWxZNnpiTUU1RmdyZkl4MXBPa056UUdrbWIxSUVDY3ZFQ1BzQWs4Wi82?=
 =?utf-8?B?VUR5MnRIMGQrNHZ6Q295Q1RJQkphYmdxTlhCdHQxOXF0aDBhZVFtenFrTnhh?=
 =?utf-8?B?NzVBc3FNbW1GVzYvMDJRWkRCQmZkYkRkcDRXSXgrSmk1L1dpV2lwNW5adlRp?=
 =?utf-8?B?YzFGME5ObFRVSnNoZ1FMK0g0eGxSWk1TckxMeG13YjQybUp2bzJocVVKa1RS?=
 =?utf-8?B?TzBrN2ZlZXNONmZIZTd0TVpHTHNHd2c0TUFYazl5aG94VFVZY2pvMmlUYWF6?=
 =?utf-8?B?MUdEbE1talU0NWdPVkVtODFJVWR0Q2NYUmV2azNjRS9UT3VWY3JCNGVFVCtU?=
 =?utf-8?B?cE5uS09aZ0xCQnVSaUl1N2k2bldtRmlKQlJlMExybVJMMmJxaHEwdVF5VmpD?=
 =?utf-8?B?T3dZeU9WU09zQTduZ3RReHEvVzduVXhkNGRFUVZmOHZCVGNLOExRUUxpdnF1?=
 =?utf-8?B?WUxuVWIyNzFvdEYzZ05BYVFVZTVaRHRUdU1mczBLSTk2NTlEZFRqWW5XS3Z3?=
 =?utf-8?B?WFVOREQwekdsbldETVpDYU9DcDdrTlVYOUcxaEp1VDEzazdHbFdHOFl3ODhZ?=
 =?utf-8?B?dm82L0JxR1FnTWpTRW02WDN6RDJxb01wQlNMSTBmcFExR3M4QXd2Z1UvODVL?=
 =?utf-8?B?WVJqUTdISGx2eEIrdXhaM3NPRHFrTTdwU3MzN0NyZzJ3eVNkVVUyQmw5NGU4?=
 =?utf-8?B?VXVFQ1lvNENjL0IwZVVCRi9tQTN1RnloNFV5NmJGRDFvWjMvSzJPQT09?=
X-Exchange-RoutingPolicyChecked: EEIhiLotaExBjhhfA00zo6BKE0V3QH51ZkC/U2QSCsV5Pww3yqRMs70zeverIjS0LEtS4e1FhJ2ZNrROTQ6IlTKlqr24v9t9chY+KAnd1i/7GPQ47GI+aeuqZ5Vs+0WIq5j8+07s1E5VTBM4pyk5DmyiHnc5JMPfXx/OO6i9d9Q+ZlX6tdAyo0W2kdufLwchUCm478udSeDFbCUlhad+u96xQ+VTHZ2oq7Jp0uknINqiQ8GLPSCpCdgi+e035ixRxuir/A5nclTNxV4fb8JARLHSU+JDyu6qbAamEWDEOEo6OYsUgKuG2hnw9mqdBz9AGI9+9ncslvnopPY2JeD8Wg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c71ffa5e-e96d-45f8-4db9-08df42f6d377
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5630.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 08:59:59.0251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUgo+pG3voHtNi37vyZ++3xPWo5hK+3DNmu7y4pQYmLNJ0eI4QyHsr7c7Hei6HmohF256dmAnF6UpRQkoTFCiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5040
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
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 13/10/2026 20:33, Mark Pearson wrote:
> 
> 
> On Tue, Oct 13, 2026, at 1:16 AM, Paul Menzel wrote:
>> [Cc: +Mark Pearson for Lenovo to maybe fix firmware to support K1]
>>
>> Dear Dima,
>>
>>
>> Thank you for your patch.
>>
>> Am 12.10.26 um 23:41 schrieb Dima Ruinskiy:
>>> On some Lenovo laptops performance issues were reported with K1 enabled.
>>
>> I’d make one commit per device, so the device can be mentioned in the
>> summary/title, and it can be reverted more easily. It also helps
>> reverting commits in case of problems for just one device. Should you
>> stay with one commit, please at least mention the devices in the commit
>> message.
>>
>> Commit messages should also be self-contained, so describing the
>> performance issue would be great. Having the firmware versions directly
>> in the commit message would also help me.
>>
>>> Add them to the list of systems where K1 is disabled by default.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 578294b8b60d ("e1000e: Reconfigure PLL clock gate timeout and re-enable K1 on Meteor Lake")
>>> Reported-by: Christoph Groth <christoph@grothesque.org>
>>> Link: https://lore.kernel.org/intel-wired-lan/87v77ial45.fsf@grothesque.org/
>>> Reported-by: ghrafn <ghrafn@proton.me>
>>> Link: https://lore.kernel.org/intel-wired-lan/_kB6DUeC6oOmJnK0FobVVJHADewewO3wzeFw_GrempgMu6s5CUwHpkT16Bwn8tXRq0k_CN4b2NY6API37M6mVciEpH6DKbTqK7f13KMpmgI=@proton.me/
>>> Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
>>> ---
>>>    drivers/net/ethernet/intel/e1000e/netdev.c | 14 ++++++++++++++
>>>    1 file changed, 14 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
>>> index 834a5b8883df..35c729368684 100644
>>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>>> @@ -74,6 +74,20 @@ static const struct dmi_system_id disable_k1_list[] = {
>>>    			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad P14s Gen 5"),
>>>    		},
>>>    	},
>>> +	{
>>> +		.ident = "Lenovo ThinkPad P14s Gen 6",
>>> +		.matches = {
>>> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>>> +			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad P14s Gen 6"),
>>> +		},
>>> +	},
>>> +	{
>>> +		.ident = "Lenovo ThinkPad T14 Gen 6",
>>> +		.matches = {
>>> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>>> +			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T14 Gen 6"),
>>> +		},
>>> +	},
>>>    	{}
>>>    };
>>
>> The diff looks good. With my comments addressed, please feel free to add:
>>
>> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>>
>>
>> Kind regards,
>>
>> Paul
>>
>>
>> PS: As far as I can see, it’s not logged, when K1 is disabled by the
>> quirk list.
> 
> Using the Product version is probably not a good idea as you'll be picking up both ARL and LNL versions of the T14 G6. Do you know if the LNL's are impacted? I'll see if I can reproduce on my system here.
> 
> I would recommend using the BOARD_NAME codes, as is done in thinkpad_acpi: https://github.com/torvalds/linux/blob/24a19b953e2a3d0ea5a8c4951a0ab8f32720c907/drivers/platform/x86/lenovo/thinkpad_acpi.c#L4244-L4245
> It's a bit more annoying as there are two codes per platform - but it's safer in scope (these codes are fixed and won't change):
> T14 G6 ARL: 21QC and 21QH
> P14s G6 ARL: 21QT and 21QU
> T14 G6 LNL: 21QD and 21QG
> 
> I've created internal ticket LO-4707 to get input from the FW team on if we can do a FW fix for this. I'm not sure how this passed our certification and QA with this issue. If you don't mind holding off a week or two while we investigate the patch might not be needed.
> 
> Mark

Hi Mark,
Have you had any feedback from the Lenovo FW team? Basically the two 
questions are - has it been seen on LNL systems, and can it be fixed in FW?

My gut feeling is to make the disable quirk broad rather than narrow. 
Hardware-wise - the issue may definitely impact LNL systems, and since 
previous generations have been affected as well (e.g., P14s Gen 5), it 
feels "safer". The power increase from K1 disabling in nominal operation 
would be less dramatic than users experiencing significant packet loss.

Thoughts?
--Dima

