Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55908606A31C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Nov 2026 00:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Jcd75qOL;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mF7z3127;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=C2un4g7U
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C1B860825;
	Tue, 17 Nov 2026 00:35:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n3ocVpiC9HLc; Tue, 17 Nov 2026 00:35:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 397A760635
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794875711;
	b=aDmC32aLmNo6PliS8lCRsEmhdbpjtFau4sKBEp6n+tGWY/5+fr0rqSoARi0iu+b2TD/0
	 qvFMo6SYUHtGw7VhHy0YamPHZ5XNXDfMF1aXh+woAF+lyISgXeqabE+evW50QQGhYAqlC
	 3TdN7DWgsZJoac05+RCD4Rtg3NrWxJt1zPeH6l46k1H7+kSes+RHvelJxGROEFNmQL5PC
	 1wKxvXZxgf9OKvqZBompTcHfDy7z1ZTxtApdZql8idKjqemI/trsTEje0rBgjA4/IxfNK
	 I3LquDZAwqjafZUO6AEsXGxxQm62uKZk6JQMccQgL7bFBxPcWDyc0t37uJf6OWtIWUw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794875711;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:References:
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
	bh=QsfIX2B9HqqKy+oioSf2arR9bgOfC6jXkkODK4gAox8=;
	b=NTlyCurvJJ3R8EnrVzfgdg8krjQJ+deB+qZ8Q/ZE4S8hLHwIqQqKd85WKdyLTRAu567V
	 0+OW0XEfKWjkOyYiafRpmqPyvF5+fvmGiq+5mra7HQQskzQub1Nnf3TT0cmdO+Aw4aDN3
	 GXYlBGeCI8E7WXMrYF9nDQi/jxWrfG+OYCv+IQAWxf78LOfkwIyge0uJUKLqjrN7q+txK
	 Epjut0Kv/a2ihImzipHdBnlnTblQkQ/Y9gyKW3jVZ6t2GMgI+at/ImWJ4JnSbtdx4Z/hb
	 JxwEmCZjux9do1QhJybjQTGeViJS7B2kjYTrzwBvJLJzLdhZ+bAHH/StJpXyspkbTMw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794875711;
	bh=QsfIX2B9HqqKy+oioSf2arR9bgOfC6jXkkODK4gAox8=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jcd75qOLzceOWPYoYvYvV9xcENZs6e1X/JcgFTnf0+XuN13MeG1WtB6ZaVmxGyoXt
	 HQInnkpW3SXQ8K5ZylcGYe1BOnIyTtoaKaDluXQUazsOqZZ8uZbiqgkIqHJL+0hilG
	 73h3+UIpyw6yW1qECv9s+Cbd27+bTtg3G4QPzlBsKSpVc702Ee3fsbwmWj1/7Ft2XO
	 FGbhkb9LGshD8wbpT4aLlueNTvx/Z5eW+uvh5565WW0GbDi84jZb4dcvLhRkGIVWF3
	 NPfsFIscImYVL+KQJRayU4bCWH5Cig/oal8Vw785iHOyPZh8y+W+G/8Sus0+PDpNOl
	 9VixjzDtgkUiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 397A760635;
	Tue, 17 Nov 2026 00:35:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E00DA1E7
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 00:35:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BCF1F80AC4
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 00:35:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ADCou4tZsy2u for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Nov 2026 00:35:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 21C0580A83
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.20
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.20;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=mF7z3127; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=C2un4g7U
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 21C0580A83
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 00:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794875708; x=1826411708;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=zjtnefiNRJulUEhGerH5rH4SyOP5I9UBrSco98b/KmA=;
 b=mF7z3127w1Y8k76UxMJ48vGt3dKr0LuFqA1NDn7veBybXP+LcQk3NM/c
 HPr1da2BTxrO9SAQ2ZLNn7dcD5ia3wTsbUakIA2sWjEOqeofowNmqZ6P0
 9b8I0uBh73YyVyfxQ011rPH3Qd0LLj1dz8xReVjnRdacNUzbvI6mGt3d4
 vNrEVORiRvNQCtRWOD8+zZgjaXJLCZIvGKCcitXSknpYug+qUHwMNEBhy
 jXWL0JqNTCWBIxqmCT1XojQIBmE33124Ub8ZvKTyDSjtcvdDHZiau0Nmq
 g4YZEfN2MLoG3dPP7BDy3cBFoIT04lnbey/TEmJCIqrULCcy7YCOw3VF4 A==;
X-CSE-ConnectionGUID: b9dYaeQWSLa+WCEYZRElBQ==
X-CSE-MsgGUID: inaPFrhIRC6Xa4nrFzsx0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3666976"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3666976"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 16:35:07 -0800
X-CSE-ConnectionGUID: dyXVO4SPTy6wmpVFuGTjjQ==
X-CSE-MsgGUID: ckwoyx6GSyS3z/LOJoOp9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9582577"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 16:35:08 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 16:35:06 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 16 Nov 2026 16:35:06 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.35) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 16:35:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsfIX2B9HqqKy+oioSf2arR9bgOfC6jXkkODK4gAox8=;
 b=C2un4g7U/eLWoOmN8V52I2QGVXHTsRJc1Ea2ao4TAjd03fvkkx/tu3gQTpSlkXnbTLXn6/xdgteqNMeA1xYaYJ7SVNYo0OrfRjJXWudeAV0+vtvgs59Mzu1JCYmyJYgnYXsqumVPNdZyFPvVdfSGrSptuASgigLCIc0rif/ShqA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8451.namprd11.prod.outlook.com (2603:10b6:a03:56e::20)
 by DM3PPF99D0888FA.namprd11.prod.outlook.com (2603:10b6:f:fc00::f3d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 00:35:02 +0000
Received: from SJ2PR11MB8451.namprd11.prod.outlook.com
 ([fe80::7d5f:b2ba:92d4:5f3c]) by SJ2PR11MB8451.namprd11.prod.outlook.com
 ([fe80::7d5f:b2ba:92d4:5f3c%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 00:35:02 +0000
Message-ID: <531d951d-b412-401e-b016-a2c3efb172a1@intel.com>
Date: Mon, 16 Nov 2026 16:35:00 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 3/4] ice: store cached PHC time in ice_adapter
To: <sashiko-reviews@lists.linux.dev>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>
References: <20261113-jk-e825-e830-timecounter-v2-0-9c357a7ed349@intel.com>
 <20261113-jk-e825-e830-timecounter-v2-3-9c357a7ed349@intel.com>
 <sashiko-outbox-213880@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-213880@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::28) To SJ2PR11MB8451.namprd11.prod.outlook.com
 (2603:10b6:a03:56e::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8451:EE_|DM3PPF99D0888FA:EE_
X-MS-Office365-Filtering-Correlation-Id: 95a995d1-5133-4f73-312f-08df44429e08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|18002099003|22082099003|6133799003|11063799006|4143699003|56012099006|10067099003|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261026140227099003|261009223027099003|261102123227099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: VN8Sbb+A4+lUES+Z+dVVhaUDkrGZOeI13RuPFD6YONlUOB3o2pZvX73Xa1hy4LnQ1Pssppxe2r63JNIjBJMmweERLioNfelodnePZASXKtqW/AnUhTXDTQ8KYpKa/IxEdHG6QX39GTV2lMHM1FTYztech8fNI+4Id+0AxnA1lhj5ymhmy2soKleolPXgsr5fpxwqEnlWvm0Q9igxJPXM7LiF06yJPpwuqQvmCE+l974waCAJHXszgY4hwsE/w3cYBFuf9GIuhyNmV2pRZrngUm7BGWkTjDJcrgI4xqFhasPPkp1OUBuD3V3BfUw/9gZLEUva5hnsMHquv84w7otKyw3Ws/qFpXJdeXhHuCGpAdO6I/flPUuBvceb944g2YoZ3OfAPiNAgeJWYQqRoK+FOUCuMMvHDv3bwqI9bw0ecMC1fRZNQuKxDZmgyYaYhu44m8J9LspM/0WYQMDQdJ5U+xh2MgKOD7fJUsNLU7p3sR1mpxJjZ2cP494+Ar+qKQzaHKx0Qac6bbW40F3tUBUxSetHa1OUnJHVwQw1jAuLtMvgyZXKPM2TrkhDYqtUVK4lMGt6kdUYTwunxMim6TOL4loNnJ9x1BuOBJ4x0oiBPylPAgHYzUIjS7MtsRCEU8CcLsY+dz3dTR2c1Dkw5jiy83BGSaa5ob7DupCm6GA7jJA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR11MB8451.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(11063799006)(4143699003)(56012099006)(10067099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261026140227099003)(261009223027099003)(261102123227099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am9HdXJEbWtXbDkvTm1EUFdoZm1MMEtwdFpKN3h4Q3lmOWNrenZlaVdBQ0h4?=
 =?utf-8?B?L2ZFVHNtTTFxbnMrTDZBb1NaaUdaSENnY3FBS29VcG9tOWRtb0lOSmFTZEI1?=
 =?utf-8?B?ekovNUorL1ZvOS94UE01Y3hGKzhnVmlndzFHVkZ6WmVqalhoY2hBcTFuSWJX?=
 =?utf-8?B?MEwzUFZqNUt1TEhEbTI5Z1RVejZmTVpFdThjZGUrQkFROUJrSHpQZXNKVUo4?=
 =?utf-8?B?WXRRSFpGWXlTYzFPZ0xndzV3YXNBeWp2UmZxb0kzSlY5Z0krakkyWkFLNlgw?=
 =?utf-8?B?L2tGdDh0MDFKYVN0OGc0TE9YY0RPcTBhYVZnMmgzK1JDU0YweFltYzhONEhK?=
 =?utf-8?B?aDVoYjNkQ0RGZkI1bWNacElibVFSTVBVakY3cm5SaGRYNlJiRXNLNGYzQ2pw?=
 =?utf-8?B?ZjY5b1ZhbEhKb1R2TjJVbEdDd3V5cW1rM1ZyVlJmTFJzTmNSQUtQWE5XTFhW?=
 =?utf-8?B?WXdXQ0t2cndZZStYMUd2dldDS29OaHhLT1I2WjIvaFZkNnBOdnNQY0MxVmMr?=
 =?utf-8?B?VTBqMTlHbXVEY29yOEJlMnlwUVhock93SmJxdUl5UFpIOEMycERhRnhBWWVF?=
 =?utf-8?B?SDExb1BoYllaM1dIVjFpTmwvbnowNUR1SVd4QUVLeFpydDdZWlhlQnFCc2sz?=
 =?utf-8?B?ZXZoUVdhRXZLTTBZNjFqTHp0TEF5SmYrM0I2eUYvaCsrcFI4aTlDZnd6b3dr?=
 =?utf-8?B?UlIrRjh0SzJkTU5McUhsVEtGK25ZdTA4NEUzL2NHS0d1MnJGbis0c2c0cDdR?=
 =?utf-8?B?Q2o5eFEwYVRsVXpYWWhScWt3a0FLMTJmYjJ0THdCMk4wcVo2YzB0VE1SWUs0?=
 =?utf-8?B?MktrbnJmZkhJZGxxOUxiVkU2eG9kWEpVb2ROUm80bE92a01JdnVENlJlTDZv?=
 =?utf-8?B?QXRuRDcxdlpPSGhuVzFRNFVWVFJYYzhTMktWeGliQ0ptdjhYd0poMWVzWUZj?=
 =?utf-8?B?TXAzWVdFOHRKNkIzUWR6MHJtSlRXMGpyaW80ZDQzcEJlQUNHR0xoNFhVczFq?=
 =?utf-8?B?Tnp5dnF0RThNZVpTb2xFWUUyTUNYTUcxbC9nY3FzSGRUWDlXNjcrc3dHWGZo?=
 =?utf-8?B?OUlMUzZ3aGh2eEZOYllPUDNoZHZIWDZvT0xoOGdjRjRCb3ZEMEJzT0hGSDJO?=
 =?utf-8?B?d2hzRyt2VjRneXZIU05CK0N4WGNmeGYzcTRiVzR6VXVXODdYZERaTDZWL1I2?=
 =?utf-8?B?eXMvQm5yVGNHNTMyMysyaEh6KzFKaFBOdVIxTmUweHJRT1ZoZTl4UGdIS090?=
 =?utf-8?B?R09OUkNyclRaazl1VzYwNUoybCtMcXQyRlVwVmxyWi9GeHR6K1NsTWd4VGhU?=
 =?utf-8?B?anBZWGpKWWMvSDBheUZLUS9sWkdidXBNQVhjVXAwaU1ldzBWZTB2UzVXWU5h?=
 =?utf-8?B?b2ZGN204SVJHSGp5UzkwNVJFeVJVOGkySWVlcy9vRG5mWXpxWHowTWl2Qnoz?=
 =?utf-8?B?dXFhdjgzOFEwNjNHRmdQcnF4d0NhVW9SMWw1ZmdpeFpuUDc3TVhhN2dpNDVW?=
 =?utf-8?B?QnE5MSs0eTNxVVE3d0krc2VYYjRtVU96dTBMNGI2RnRMOFlPeUVqTW0rQjAr?=
 =?utf-8?B?WFd6eDhGcThuNGtpcEh0OGd2R0NPYkd5UngxV0EwMXV4STl2NkdIRXc3VFFk?=
 =?utf-8?B?ZStXN2hOWEgrTnZjd1B0ZWhXYkdjUWE2WTFrbTVVa0JBQlVMZ0x6VG42RlUz?=
 =?utf-8?B?MDdkL2dPb0NCVEdhTmxyS0Vjbmc2dGhEOEtkTVQ0L2hrSHF0UzVqVEZsSFBa?=
 =?utf-8?B?WWlvZzVNWW9GYzlXTVVlQWx2WncxaWRhekczRFFpb3RwT3JLM01sTFlNcTd3?=
 =?utf-8?B?aUZGbTVwUmhnUk9LUVE2WEJ5UWRPTUJkYnlBZzdpQ0p6U25jUkVsS3NBQmYx?=
 =?utf-8?B?ZGdSd1Y4T05kQW1GTWVMTWFpczV1ZVBscDJWcUszbTQybHhVVWdtcHUwQklD?=
 =?utf-8?B?RXRvNy90dFpZNWlsbi9IdTVhcjEyVmR5bDNRSkEwTkR0WHd3bWsyaG02dWY2?=
 =?utf-8?B?VUUrU3A3dnFoaUEvYjE4eHNqTVZ0WXpzVStYbm9pUjVNMFVkK2xIaXBGNjlq?=
 =?utf-8?B?UGNpSnFUWGtQNTl4N2ttaFp6SlllR2FzbUdEenJLbHdSL2p4ZzQzZVJDU3JN?=
 =?utf-8?B?bnlMVFRuRWJxK20xbHZWNEZLdE9uRUR1aGZhbVRsRW5FV2ZqanBDVnhUVWZH?=
 =?utf-8?B?OFhsU2xLVFlxS0w0YWtsWEVsQkVLbmtDMjNVYUROZHI4ZlpJYVB5QmpWQ2lp?=
 =?utf-8?B?NWluM3J6RGRlajdVNFpkc3NzbGFNQ1B1dzdER1NITGpDL2NyblI4OWpQeVZa?=
 =?utf-8?B?S3J6dHFmY3dDZU4zekd1MS93VEYzMVdnSTY3bmV5WC9yckpwNm5jdz09?=
X-Exchange-RoutingPolicyChecked: dGcbEzkQNlqlCMqlgNMUfByOSMBlK+nJzenhDBBhWFN4/nt7Y3Ki1ohxv40q48Uuj8Ea+aCY5ixMjILCroyeJw5mS2eRVyO93I5PHYCGQ3i+/+CxHETEf63sFa/ISWVpSyoczNY7d4Kt9dJt2P2V9r0u+zqgREW+Jg/4fNEvkyHpPa9C587Tumf6SczO58vfAzkDNEaK7dPvu3LAabd7LPVra1L3YMM71LiTMILsByQpQrwrSTGSP2eTVfhYiMfPYEdEbZ8KGiJSxS4acGecvnUAU+NMvd3i5UgpgJhzrZx22WWbfk2zdp/pcPonleV8SZMEEyNil/Dx0w7jUZ1GSg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a995d1-5133-4f73-312f-08df44429e08
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 00:35:02.3789 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6m3sJ5LbOb/PqfUiwU7/JGedpUEpyDyux9rbIEIp8Jy0iYyAeDKriV/FrOSljXPsBg15B8iXLlnoe6wkN7yxcIPlpWfaVIX2yxNA+AURH80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF99D0888FA
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_NONE,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/2026 3:52 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] ice: stale adapter->phc cache across reset in
>   ice_ptp_rebuild_owner()
> --
> 
> commit 3e2553cade32eeca4938b383704866bc53bd38ea
> Author: Jacob Keller <jacob.e.keller@intel.com>
> 
> ice: store cached PHC time in ice_adapter
> 
> This commit moves the cached PHC time and its update timestamp from the
> per-PF ice_ptp and Rx ring structures into a shared struct ice_phc embedded
> in ice_adapter, updated only by the clock owner PF.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index bf37c2a7ff863..a0451c1083a41 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> [ ... ]
>> @@ -3099,24 +3056,20 @@ static void ice_ptp_periodic_work(struct kthread_work *work)
>>  {
>>  	struct ice_ptp *ptp = container_of(work, struct ice_ptp, work.work);
>>  	struct ice_pf *pf = container_of(ptp, struct ice_pf, ptp);
>> -	int err;
>>  
>>  	if (pf->ptp.state != ICE_PTP_READY)
>>  		return;
>>  
>>  	ice_ptp_tspll_monitor(pf);
>>  
>> -	err = ice_ptp_update_cached_phctime(pf);
>> +	if (ice_pf_src_tmr_owned(pf))
>> +		ice_ptp_update_cached_phctime(pf);
>>  
>>  	ice_ptp_maybe_trigger_tx_interrupt(pf);
>>  
>> -	/* Run twice a second, or retry soon if another thread was busy
>> -	 * updating the Rx rings. Other errors, such as a missing control PF,
>> -	 * do not clear up on their own and must not turn the periodic worker
>> -	 * into a busy loop.
>> -	 */
>> +	/* Run twice a second */
>>  	kthread_queue_delayed_work(ptp->kworker, &ptp->work,
>> -				   msecs_to_jiffies(err == -EAGAIN ? 10 : 500));
>> +				   msecs_to_jiffies(500));
>>  }
>>  
>>  /**
>> @@ -3211,6 +3164,8 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
>>  
>>  	/* Acquire PHC and system timer to restore after reset */
>>  	ptp->reset_time = ktime_get_real_ns();
>> +	if (ice_ptp_read_src_clk_reg(pf, NULL, &ptp->phc_reset_time))
>> +		ptp->phc_reset_time = 0;
>>  }
>>  
>>  /**
>> @@ -3250,13 +3205,13 @@ static int ice_ptp_rebuild_owner(struct ice_pf *pf)
>>  	if (err)
>>  		goto err_unlock;
>>  
>> -	/* Write the initial Time value to PHY and LAN using the cached PHC
>> -	 * time before the reset and time difference between stopping and
>> -	 * starting the clock.
>> +	/* Write the initial Time value to PHY and LAN using the PHC time
>> +	 * before the reset and time difference between stopping and starting
>> +	 * the clock.
>>  	 */
>> -	if (ptp->cached_phc_time) {
>> +	if (ptp->phc_reset_time) {
>>  		time_diff = ktime_get_real_ns() - ptp->reset_time;
>> -		ts = ns_to_timespec64(ptp->cached_phc_time + time_diff);
>> +		ts = ns_to_timespec64(ptp->phc_reset_time + time_diff);
>>  	} else {
>>  		ts = ktime_to_timespec64(ktime_get_real());
>>  	}
> 
> [Severity: Medium]
> Does ice_ptp_rebuild_owner() leave a stale cached_time in pf->adapter->phc
> across a non-PFR reset?
> 
> When a reset such as EMPR zeroes GLTSYN_TIME before
> ice_ptp_prepare_for_reset() reads it, ptp->phc_reset_time is 0 and
> ice_ptp_rebuild_owner() reinitializes the hardware clock to
> ktime_get_real() (UTC) via ice_ptp_write_init(), which can differ from a
> pre-reset TAI PHC by 37 seconds.  Neither ice_ptp_prepare_for_reset() nor
> ice_ptp_rebuild_owner() invalidates or refreshes pf->adapter->phc after
> writing the new time, and non-owner PFs no longer update the cache in
> ice_ptp_periodic_work().
> 

Couple of notes: We have patches to convert the driver to use
ktime_get_tai() which we should probably include in the series.

Additionally, I'm not entirely sure how to resolve this since I don't
think checking against the cached_time is good (it could easily be up to
0.5 seconds out of date making our reset provide a bad time. I'm not
sure which is actually worse?

> If the reset and rebuild finish within 2000 ms of the last pre-reset
> update, ice_ptp_extend_32b_ts() still sees a fresh phc->update_jiffies and
> extends post-reset Rx and Tx hardware timestamps against the pre-reset
> phc->cached_time until the owner PF's kworker runs
> ice_ptp_periodic_work().
> 

I suppose we could try to disable timestamps explicitly when we reset at
the cost of timestamps potentially going missing? I guess resetting
stops queues anyways...

I am not sure how big a deal this is in practice.
