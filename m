Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CCA606A321
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Nov 2026 21:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=jDN0lrXR;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F4g44Ztl;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=RE1ttgPx
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B45C060725;
	Wed, 25 Nov 2026 21:21:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y2OSAny79q_8; Wed, 25 Nov 2026 21:21:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DD9F5606A0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795641697;
	b=ZNLCzU75rsbp1bdGI0VgPN5XFBVCwEkxh1BqOjLfAkXxLIi+ccTd/AoDvFlTz3O44WJ/
	 QrKyAE5HYUPQsBfThI4Aq0BwKBn1kprLeDXoLn3JLNSBE2/bFNweIiB8uIDE0LTJnTlQ/
	 VHPGmuPUicm5nTjIGOpgMOWhdpnHgRIeBIzMsItVB69wYjbK9LfLEJqsQZwgyPgWq+G9I
	 aSB1bGqGKAT4oEflBNZzO6+HKGIlncKobeVQDHqopPJCgrsBHsYByij+Q9rgvcSWhPV0g
	 ona6TSZYqa8i9ZtAOATsWQk4mJqMyJXgd0rlnvx7baUYQ0U5f+U2VSoQOtM1taewWRA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795641697;
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
	bh=ZToiJsPKJhcOdvM/yQOZeiFXthsr9f5kLuyfhNR4k+Q=;
	b=dCETx+VYIYIVdYxC3C6O1OWvHIoaOOzXk25fMWbwZkU2bJSnsFc+ANUG1gwsbzUgI5Vc
	 2Y15J1oI7kHXAXNtFppZNksaFhALvc/ZOxg+mzhVvLK6m12iM49uGiVdsML7f2d6nfIE3
	 DmAhGemkwt0Vxc/gXPev5p82wQIzxp8i2sbsQ7aRmwUdR/f9IdNdrwUI210X0d5zzPxiR
	 U4KklyYYzQAMB3j67FN6OkGnnb2+mib6KA2jH7aNn41hk97NlKy14OwU6jyOa2+TV4MKY
	 3v8q7seSi1mLm6Qw2DMCXlZpNBonKZnNY0bjvdq0GGympMR0ihXhUbL5IzBdC0qUd+w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795641696;
	bh=ZToiJsPKJhcOdvM/yQOZeiFXthsr9f5kLuyfhNR4k+Q=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jDN0lrXR0G614MKSGXe9oS5yDSCuH8bxugbjc7uYrY17GTkw5tbrK0UIbSYS/SBwm
	 N8luxyG8QQHI5mjqUOix1H+bqfLfOOXMDZpTExOpVUUpTPzw0ZLBmlsADEwv8oAAPd
	 2GgM7/inWzFJiVqcHMbfs3/gb94Biw8gaAH3pSxGmlADI8zw73L+Tixjsmwnv91Qwe
	 58GPiQFnuq5dxyjO1sz//7scwnZzuhs2cz93mrVwRJTKp4eed3vZNiy/PKSbNHka1l
	 fuTStbp23aiBcIPXNlKCQ37YMP/ALRxhE2Wp8684Dj8or7pTFJ0BcFWXeSXxAO9MOp
	 FKE4QyJhmPRMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD9F5606A0;
	Wed, 25 Nov 2026 21:21:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EDABE26D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 21:21:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D3E4980A9F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 21:21:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MGFKNVe-nB4c for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Nov 2026 21:21:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D54E880972
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.10;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=F4g44Ztl; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=RE1ttgPx
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D54E880972
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 21:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795641693; x=1827177693;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=e2Y5Xa608OmXUckf4kLoOrOXtWJ8XzavuUh9sg0gDPA=;
 b=F4g44ZtlObZ1FaVqsu+zsWhF6f8/RB9MMo9UQ2iLYZ0cZfiJHkMt9Chv
 Z4i5K9fgVnTMTM5qkgFyJBuh9ZtC/gsGM2uNHbFnI9Ji+6tQhodKi3s2a
 o78bGuBAbF8QQy6DTscOT22bMyb60h6twqUT92LneWnL2RaGndBHkVvWG
 2nZkpXBla32zXA+XipwFFuIn/gdjHwLzCHLNlF6spOX8dJqg6s2zTxsCH
 eSyG6iKeOS1s43ArEc5G1Z3nOKFZRwotnoU90MRv/EL3fYwDu/BmXNpY1
 CQmNb92kV2qpTPOpZ7l8MaWmZBcG3LTl8IuoxNrDB4FlgTIttopgb79m/ A==;
X-CSE-ConnectionGUID: V9+LIWvtRsauvy5qRK9eUQ==
X-CSE-MsgGUID: JvFlEVZRQW29/o995+C/8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4462043"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4462043"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 13:21:30 -0800
X-CSE-ConnectionGUID: E2nAgAt1T36EHqgkw/clyQ==
X-CSE-MsgGUID: 9wTAysjLR56K7bMfKIviiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; d="scan'208";a="11963653"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 13:21:30 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 13:21:29 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 13:21:29 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.16)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 13:21:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZToiJsPKJhcOdvM/yQOZeiFXthsr9f5kLuyfhNR4k+Q=;
 b=RE1ttgPxvw7tzLxxaB/N4UojZWFFYpjiTjyZVakIkTHhGkTwRYTHSLuKZpj5+P0p0OQIbtRVe5RbD5v7ztuL2E03wQUhwjy5w3Hw6W9x1KrggE2tAM5QoF59MbnTviniH6u1kVYoQq/TuJSzM7dmw+dyO3lZZ0Zx2ZNeTSng4pU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8451.namprd11.prod.outlook.com (2603:10b6:a03:56e::20)
 by CH9PR11MB9925.namprd11.prod.outlook.com (2603:10b6:610:345::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 21:21:24 +0000
Received: from SJ2PR11MB8451.namprd11.prod.outlook.com
 ([fe80::7d5f:b2ba:92d4:5f3c]) by SJ2PR11MB8451.namprd11.prod.outlook.com
 ([fe80::7d5f:b2ba:92d4:5f3c%4]) with mapi id 15.21.0639.011; Wed, 25 Nov 2026
 21:21:24 +0000
Message-ID: <5349b42b-5769-4d47-805f-4be82cc5ee59@intel.com>
Date: Wed, 25 Nov 2026 13:21:22 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2026-11-13 (ice)
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Petr Oros
 <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Magnus Karlsson <magnus.karlsson@gmail.com>
CC: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
 <edumazet@kernel.org>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
 <horms@kernel.org>, Marcin Szycik <marcin.szycik@linux.intel.com>, "Aleksandr
 Loktionov" <aleksandr.loktionov@intel.com>
References: <20261113231225.1864810-1-anthony.l.nguyen@intel.com>
 <20261118115915.116177-1-poros@redhat.com>
 <20261125124652.3843638-1-poros@redhat.com>
 <6ce9cb98-d615-4bf0-990b-35aa4b970503@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <6ce9cb98-d615-4bf0-990b-35aa4b970503@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0299.namprd03.prod.outlook.com
 (2603:10b6:303:b5::34) To SJ2PR11MB8451.namprd11.prod.outlook.com
 (2603:10b6:a03:56e::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8451:EE_|CH9PR11MB9925:EE_
X-MS-Office365-Filtering-Correlation-Id: 158cac10-f57e-49ab-c30b-08df4b3a0ede
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|1800799024|10067099003|56012099006|11063799006|261022105027099003|261026140227099003|261026121527099003|261028144727099003|261021123027099003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: MsKhZDqEeriiGFS978j/ArjK9WRmW4H98vOi1R33Juu2StNW3tEXzN4OTR7x007AgxXi+nM2fLR6K0pBYQ0A5cFCI0j3SogdXsKmcxqigFytZBFZByOMXrgWqIi5HhQBUcc++o2zOFkX8MfDkwTPdeTrf6Iy13kCftMT9FBfGLkDW1eOwSChmrbvGhH/pocrERmjhXYY/nMB2dofLABneP1nMtvzSPRd9wdrOXF4SEjQW8vfoTO3O1njKb817aoTrZwByYcwCqb52UvyltdUdX6FKhTyLsO9rJWwRus/FotWTA9AGejVpNfqd9bxTzCtkhSrBCv46p7tioUg2HlNZ8MrkfxXx11qYAFqLeeqGZkzPg/lc1PhfFqj62yogQEoq4GldQ3ZY7UwvYHZxuEJs9oHwxSk8oxnPRqncX6wwC3PXI1n+yu1vyJ301lSzxEcbNj23HhuFXyKEwTRwKSJnmAdWkOlYeXpxqqQRGU9eFkXowsgx25UNIZgNBWs9Mv/zGD76KOD7iK3bEbg2JfzzDC3pUjivhj03kuyleX3C5FzNKdkGWTBxC9Kfmqk2M8yXz8e6Fqku2KXmPF+Gp2Pd3wyLEkx50RICOSKp5FGuApF/9QDjaJ/aVPDw31CSbaB1zzJ2Wb8yMtV1RHlJlUI2oP18eXa3iFs3uRJ+iW30v4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR11MB8451.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(10067099003)(56012099006)(11063799006)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUljNUllZVhzSWtpMWcyeUNWUFBCczFvYmx1QzdGZG5Ock9xRFdqQlZONUNj?=
 =?utf-8?B?blhGbUkzYnMrSk95ZU9BS29xYXg2c0lYZmt0cGpSQTJldjBub01Nd1lLRGVx?=
 =?utf-8?B?bnZSdGxndXlkbHc4OGRweFVQcElDeHNhK1Frb05GWHNwdDJnQ0FoY0hCNGlu?=
 =?utf-8?B?dHNaMXRjcG9TZXRJM3NuV3ZTVmtqWDlCSW9qVysxZEhmTXpGYUxPRlUyUnc5?=
 =?utf-8?B?cmZ4Nm9FUzJwMTFNaVVBakF4ZnBWbnF3N0NuMzFwR3UvS0p3cHdZQUdqV1lF?=
 =?utf-8?B?ZzVrQm1jb2VvOEZaQk9IZXVBVHA5eDUvMzVFVmEydXU3cTdubWhaMmRnZEJa?=
 =?utf-8?B?ZldOeGl3RU1wQ3dwdVZiaUdnOUhUaVQxVnFQQ1BybCtad2U1U3lVTVVtME5h?=
 =?utf-8?B?RVd0c2xwVFFFVzE1RHJ5RExGY1orTVp1cmpObkk2RW13VnhIbHBSR2ppN0Nt?=
 =?utf-8?B?cllOemVPS0xCN05VbDdRN01FOHNpb0dJTTNQQ1FzSnV2a1A4blRBRXpOcllQ?=
 =?utf-8?B?YkMwbW5UcEpQZnliT0FxK0pNS2x1ZURFYmdkdlFhNmpOdVlaaXJSbWk4dkRp?=
 =?utf-8?B?bU9oTC95c0hhSVJZOUdSUXZRNXoySHpXeTdiR1JtamZQV3NkdTlOMmMwV29i?=
 =?utf-8?B?d0NvaEdmelBFeHkwTjRxS0xadSt1VnQrL3JhT3ByVDJzZHcxclV1cEJtd0ZX?=
 =?utf-8?B?NnlmSWNPUGJVWEFqM3hVeTI2Q3Z4dmJ2TE1Fb2hnRG8reW1pUFFrdk5Kc0s3?=
 =?utf-8?B?YTBtUjVNVFRKSmlKTUdaMzJSU3JEdjc0SEl0KzM2aXNFV2hzY2tROUEwc0d3?=
 =?utf-8?B?UUtVemxvQXp5b3dPQndBaFUrdVVZaGdGS1NkdnpEd3Bra0xFMTBScEhMejFJ?=
 =?utf-8?B?aWQ5b2txa0hRTS9hR0dzbHZKblArcTByOWsydFVNSVZwWEFoYVZ1cm1wVHpG?=
 =?utf-8?B?NDh4b0xWMTRqd21nZVVkSjRHZ0R3cHRuZ3pPNWIyUTlYNW5nLzhTQTNKWWZT?=
 =?utf-8?B?RzR5bTVyeEh6THAwd2pPdVltODNWNnFyNm41UXdoY2tVWHlSWnEyYytSUUhz?=
 =?utf-8?B?cnFLVkR1Wm9nZkxVZVA5VE5vVDZFTlFPNnlVMUZ5V1Q2elU3MW11MVZ0alNx?=
 =?utf-8?B?NkNZK0d5U2Y1SGpVSE9kZ3NJa0pIV1I5d1FIZDhHRGp6L01oSGk5M2owWk01?=
 =?utf-8?B?ay9MbUsxVGNIZmd5bGFvQjlFOGlpSXdpY3B3Z0JMRDNXYnUxeUFwN3V1SXNR?=
 =?utf-8?B?T2NtbWR6VjJtQjRyVHZjQ3gzbGlpWVEzMXhCa2JackxlaUp6NmJmNUZheWtr?=
 =?utf-8?B?aVY1bVpxWDVsRHN5aDZpMGJKRko1M3Q0cENzMkluSVVnRlEyYnd6MytDSXUz?=
 =?utf-8?B?WHlrSmdydzY0TGtyaHhKbEVsNEx4ZTZDRmRwd1pNYlQvN0YvSnNKc09CRnJs?=
 =?utf-8?B?bjIrS2FGREk1Qnc4SXFFdWRreHJibXZmRFNVOWlHZkc0NTRyUURhOHlaTmQr?=
 =?utf-8?B?b2tNR1VVaUVkR25qOEp2ZDVmWExuQXhibC9ld1VtdFpRemhJSEhUZFdOR2t0?=
 =?utf-8?B?VUgyR2s0cVJ5QXQxV1NvNk9zc2Ivd09mZGR4SnJYVVZYbk5JNGpncXA4SmRu?=
 =?utf-8?B?Y3hKYjlld1NXY0wxVFRoTjM0YWtNdFptb0gyU0phaGxyU29ZS01uRXFTd2Np?=
 =?utf-8?B?UEVJekE3Ymp5cWV1K3JRc3JkM0dtaWh3RlJBd0JnYlBpM3lSNEVCZW4reFZj?=
 =?utf-8?B?aEhnRGhNVXBLaWY3YmVENTZLVm1HSWJQb0d1NjZ5V2QzU1gwUmpsaWl6M3p5?=
 =?utf-8?B?YTFpYy9KV3YyRklTWUxPb1laNnF2dmlFMnI5aThBMXFtMy9CV2ZBV2lEN2lH?=
 =?utf-8?B?NnZ5UkJBMklrV3dwaW5KTGVBYmlsUFU2OGF5TnAzbWwrQUlzc05Qdk83TzNo?=
 =?utf-8?B?V3l4RlVWUjQ0S0xXNFFhd0ZzL0VrR0wvZE92ZG1RTW02YndLZ2ZiREZaZnE5?=
 =?utf-8?B?dThVRUtEMkFzRkNGcU93dDBuQlJCWEhRdmJiakYwTVRUZXZSbUpiZW0zMmlv?=
 =?utf-8?B?Y0ZOUytndURkSGR1UEFrM1hKZ2hDVnFVSFJxeDNFVmZ0QUFJN3NpYlBhU0t5?=
 =?utf-8?B?NkJNcmtKMkFJd3lGOE4vZnFoNitpbGlQQnNGbzRmc0RpM255M3lGY1lOSEJk?=
 =?utf-8?B?VFN3NDZ4T2dIOHFhS3N6VEI2UEgwYVZ5aHFHUGZGY1JUUW1tVEpaOUg1UWZw?=
 =?utf-8?B?dWpUQ2c5OGtTazR2WnJ1L1VqNGU1ZWpEb2s5Z211VDBlVmp4ekpTK0Q1OWtx?=
 =?utf-8?B?U0I1UTBkL2lsK1FPcFZiZ3hISzFnTmxXcEhjVVNsK0pGWkJGVmkydz09?=
X-Exchange-RoutingPolicyChecked: KTmUl5bJ5B1+WjgjacvsxVwY5Eyz9ShzvO43+16dfh/3af6i4Yhp8O5iEyEoYb5TK1YtuKG1BErObczIazNKT4bvKcNPi4IYiSBa7rcim3Atz4tMY/F6metTLC/kH8LWA/Dss2jAGcDyCBiEWoi9hCQFDZBpXEMnbLxEqtpUeOcdkJ2sELX4RlM2b8eajVWpkZ51+NbfN9dBywyxdqoFbGgvLOSvG5L5HxGyGeH6bMR1qqkmAboSR+CvKN9eBPaPWEc/Bf42fcpozOnaMElC3wlfO9l1u5HOHxjdpH9Qtv9gnmd6ZI4FMqzr+o081A9dPYH+PRWBbAqLGYJ6KXP0DA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 158cac10-f57e-49ab-c30b-08df4b3a0ede
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 21:21:24.2990 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ZTPEyuCNOF3GQVdMH/rjBsaDqsu/Ff4jE8+xRPBTQSChVx9sgob/ESXXMfXu0V81BA+Hf+aKYzN2UHysLDQBljUrSP7GxqO4+uNATTq4x0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR11MB9925
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

On 11/25/2026 6:30 AM, Przemek Kitszel wrote:
> On 11/25/26 1:46 PM, Petr Oros wrote:
>> Thanks everyone for the input. Jakub wrote that netdev is happy to take
>> the patches directly once a maintainer acks them there, and Przemek
>> that they will ack more on netdev. Building on that, here is a
>> suggestion for how it could look. It is only a proposal, for anyone to
>> comment on or change.
>>
>> 1. Fixes could go to netdev as [PATCH net] with intel-wired-lan in Cc
>>     and be acked there by a maintainer listed for the driver, so they
>>     would not need a separate round on iwl-net.
>> 2. Patches that are already queued could be sent again directly to net
>>     by the people who originally posted them, the same way.
> 
> but please not everyone at the same moment ;)
> on our side we will try to not only human-review the code, but also
> use local sashiko and to run the code
> 

Patched tagged as [net] should also get picked up by the netdev Sashiko,
and that has been pretty good at catching a lot of the corner case issues.

> the current time frame for that is ~3 days, after that in netdev
> patchwork series is marked as "awaiting upstream" (yeah, weird name for
> "awaiting intel" :)), another revision of course refreshes the timer,
> but it's not good to repost just for that
> 

As for "Tested-by", we will have this be a best effort case, so if our
testing team can't get to them in time we won't delay ack unless we have
a reason (i.e. low confidence in correctness, or other objection).

>> 3. Later, once this works for fixes, the same might be worth
>>     considering for net-next.
>>
>> It would also help if Intel updated the MAINTAINERS entry to match and
>> kept it up to date, so that it is clear who acks fixes for each driver.
>> Jakub mentioned adding maintainers or splitting the entry, and the
>> details would be for Intel to decide.
>>
>> Does anyone see a problem with this? And who can make the final call
>> on how to go on?
> 
> that's correct summary
> 
>>
>> Regards,
>> Petr
>>
> 

