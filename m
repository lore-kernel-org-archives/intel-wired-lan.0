Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3CC606A333
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Nov 2026 13:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=393o+Cwg;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i6FMb22m
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5CC3F60666;
	Thu,  5 Nov 2026 13:42:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s7MCpRGxZUGc; Thu,  5 Nov 2026 13:42:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7720D6080C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793886169;
	b=iBq28VuLtx6XLEMUYVBsRwqYEhWeedGXU0GMkUzW8Qm15gjq9G/MdzE0GIyTm8Vb+gY9
	 2oMBL89m6n28ECywCXALuFv8ZqU73AikCPoQRbIIgZLhl3u0ia0GxlDPbS8imDE5Ld0Rp
	 4B84+Z1K0UxLhcyPiKUeOEPt2KDbgee9QuekLtAQ1Gp0x7ly3MdRE/xiDXdmDwEV/hPul
	 9R7zZQ1GrIVpncbnGJUZwx10450oz/x1FWpxIfstvZ3WHqwRHQsaZQVsUcVVXORm1fM1S
	 OhjjhueGdr/m6OlaLVLX5IShxLYwptxi9n4NF8uwj5E5le8vKUQLjgfbbPmu6m+ClQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793886169;
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
	bh=VThW3QDag265+3p9RysvcC0bjTLj33B0Jy/GwrxzoVA=;
	b=pzFLTtKTkHFS6tya2u2hdpqGJPsKffO9yMP4vfiTH5EL0wxntyncadu4EXBrjD0Wz97F
	 TRv9ozGg3lLbYkrXJeLwyx5XKlCLCX++ldsyHY8q9LqMBVf7uAWg5M6YCTEuRl2S3cfAA
	 Vg0rSZ5xT6kmetOpoQGO7w3TUDSVqpcoaDIMdbsstFTkGJGV1MNAcnqJHYUCVSVpDzCgN
	 ZC1iNqAdlT4R4hdIwK2JwXQm2evpPpGWkl/9M6xNWuIzeblb9pJHzQiXzLrnJ1sUJn2nA
	 wd023lg18ryV1vmAjWB5P4CuW4swy33mUZr+D5WetiBf+LZe442osP9PW6q8GUFJvbQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i6FMb22m;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793886169;
	bh=VThW3QDag265+3p9RysvcC0bjTLj33B0Jy/GwrxzoVA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=393o+CwgFt6Q8xD2fdXnhoVr2WV/zFOPS2/mdpn2F7n6vJrXZtbVCCCQq9lqGlXIZ
	 xnAOzmg7jyUgmEgYlg860bSPt3J9B8F/quhIRt+RR/s+VozfRdEJjfWnq1kS1+0zzk
	 20SLRY0DxwVNl5Wmkrv6rlk1rK5dcJS6X7Y39aHZQKjuBu4qYlwDdPxugXe8DxAvAH
	 mnXpemlgeuLPosOsfmpnvjyHJtGuF2AiM09BQvEH9h8zAOzyX3O2QGqCAWhx8wrysi
	 bfqWbI+jx9M45oc53pgm/eAAvvj/X/LU83naWeXkhnDtIieSgfP300+rfvyzteJ9ax
	 vnn83rtyKJVuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7720D6080C;
	Thu,  5 Nov 2026 13:42:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4CF71362
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 13:42:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3EEE26080C
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 13:42:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iukvNR1WuAqe for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Nov 2026 13:42:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D40F760666
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=198.175.65.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=i6FMb22m
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D40F760666
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 13:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793886167; x=1825422167;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=03NnAcxvlEW+hrLznacVloR7tHwXEPsJVOZciofxJxY=;
 b=i6FMb22m2U0XQNtHf7w6xvygE+NLGbvpv7aAy8JIVER46HGzmTfu0OKa
 m9cGVqD+0wZ/ar9f74lka/zmNc4CKlUb8lg50qCko475mMLQBs1db6hiS
 3LK1DdsG2znIzvkbPLFYMk/35d0O11mtgeQLkHWFfFMpgpG+X0mJ9vTXD
 tpzAhM3cKo25QkQmOqJMlxxFXO8ia/SD5Jmxcyc3IJEnc2g8kLwYMl7gZ
 ww1f++YVjPF5b83W3JBxnqfwDa2kTOvMx+D/T6Rx7DQ1Pebh0I2Y9AtGX
 SV/dHR1jXo61/uBWIoKYI0JNp47gGfRou6fELRy0Qa0vwy1fQ0cn2wqPj Q==;
X-CSE-ConnectionGUID: D513T0MeROuUadp+U8e00w==
X-CSE-MsgGUID: M7eF5F2cRxe7/qzR52KWoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2666153"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2666153"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 05:42:45 -0800
X-CSE-ConnectionGUID: ttxrB7IlTqOJLF5EXVwvbw==
X-CSE-MsgGUID: sVczVtDWQCajant0fa6TLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7176641"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 05:42:44 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 05:42:44 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 05:42:44 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.63) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 05:42:43 -0800
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by IA4PR11MB9277.namprd11.prod.outlook.com (2603:10b6:208:55d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 13:42:36 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 13:42:36 +0000
Message-ID: <a0d74537-a397-4e3e-b77b-38ef2b9cd194@intel.com>
Date: Thu, 5 Nov 2026 14:49:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next] ixgbe: make EEPROM init_params() return void
To: Ingyu Jang <ingyujang25@korea.ac.kr>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20261101234725.1414173-1-ingyujang25@korea.ac.kr>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20261101234725.1414173-1-ingyujang25@korea.ac.kr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::9)
 To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|IA4PR11MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: e6f83a57-7f2f-422b-3c2e-08df3b42a6a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|261021123027099003|261022105027099003|11063799006|56012099006|261009223027099003|261021121427099003|261026140227099003|261028144727099003|261102123227099003|261026121527099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 4+bLq4ktXcwinpxHMdfNt/zfLOWB4IbXPhNj2OWTiPD6t1dbTqdAVNH2NWg6jxOBLjWNup4CJHKaWWMsQi7bimfj633GvGsNI9SxHFzwAhwM+DN6Xc8pPCT89s3XffK9euYH3mDl65Wh+ER3XJHpFJJ20NKuOKQqUmKzrInoqDdCGbWS/9VJPhfE1dvZbqJixCyGiYtL1s+p9nFrdftk+Ztp2TiSbPepmhMyZOp6QUwY3LOPfLoWpXgz8l45QCrMgCwImOymrbRwrFOUjT2FWn9EEJXggSAiZzY/71Eqdpga3sbtymYf+DzjP05vMrDLyEy6giahMMCxkg3defEHmN+NLQ2S40eREeHul9yGhdBvk1sBXBoWJATz4dKavTnPVqkgI5X7+bVttrDN3PzywNN2tVBu3lzQIHwxv2/EoFklYod0812f5wtSgjgwsZArjzj4shGUW0ySpXPoOskcvvg6oFHr6vmJV8pO9hV2EViMtNn+SrGRsfBKpPOxjDIDnFIm6GDhxfye6HFkKHXAYOvgDonP/jNxOexOs93s0lUqjtI9f9V2GZmYCfPHnkxPAp9Xeph5HzmqkUIkMvM2Zk06nU5N9cQg5pXOT7dsBYZnKWWesivAzDhPxmIDrWQu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(261021123027099003)(261022105027099003)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(261026140227099003)(261028144727099003)(261102123227099003)(261026121527099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czhvSjNNaG5hdmlQVzNHTUtQSGNsMkpnZmlIYmtwRUpmMyt3d0xDelp0TGt3?=
 =?utf-8?B?Skd0R0dCV1NHeWtGQUhiaE5OWTRoTittMVgwNVBiaDE5SSs3TzV0UXZGVmJ4?=
 =?utf-8?B?MytXS2ZSd2hZbks1eGFYdDFLS09VTWJjUldCNW9taTQxVG4wRlVKOHhDMHdz?=
 =?utf-8?B?bkdrdEd1T3RHT21aOWJHQzVRVitwOXhtQzh0TUc1QzIzL1pMK01tZXp6bzJX?=
 =?utf-8?B?ZEdOTzdlK01CKzNqTVZRL1BUNlFkSjFQSXAyUU53aFNmSitMQldXUUVIWHN4?=
 =?utf-8?B?TTR2SURjWlRwNXYrdldwYys3MUJ6TC9NZGFVQUo3R2dzMktzTzBqOEMwOUJK?=
 =?utf-8?B?RzlGb3A2WTcxcG9JbHlGMksrZnpkOTFzT0VrSWtGK1BCV05KL0Ntdi9ORGxn?=
 =?utf-8?B?a21lMUExUnB3aTRlYmE5VFAwYTJ6RHphOVNtOWlqNUhvT2d2ZkU1VzBtL0t5?=
 =?utf-8?B?WkdTL1NGdU9qRUhWY09HbExYOTh4d1F3RkhWcGNhTWd6aFNjU1V0SHJUcVhN?=
 =?utf-8?B?alRkNVV3dWNuRVZJUlZnN0NMK2Z1eHBVY0lvM2xtc1RtU1FQZHBCaEhaV0Qw?=
 =?utf-8?B?UE9nQmlXVjVDS1puaFgwSHY2b3JwOGtYcWJGeFhidU5MTE9pNVRkSVYwN2gw?=
 =?utf-8?B?ejgwLytoYUpOSW1yOTBkNGwwd3hPRktiRWEzekdPSlFxemN5MDlRNHdRUGFv?=
 =?utf-8?B?cEQ1eGxWNnJQbi9sTi8vVVdlK2p3QURpVHBKYjVOQ3RkVjdsK2ljRVNUT0NP?=
 =?utf-8?B?UEdoekYwN1ZqaEJwQjUxZFVadU9XYktqL2sreTFTNzA2bzgyQXFEN1AxNWRK?=
 =?utf-8?B?dHdBQXZVRU43UEFqb0hDWVFQT2N0ck0vbmhkcjk3QzYwUnpTZ0prY2R5OTJK?=
 =?utf-8?B?UFJjNm9PaWZSUXB3MUgyNFhKb3Ezb0dTbnJDWWxUWUkzN3RMVElxN1dKeEdG?=
 =?utf-8?B?NmRJUG5sTGdsQmFkTi9xOUxGaDNPSGxJWXRWbC9xQWljOFB0QnBaTGxINC9q?=
 =?utf-8?B?YVpBUER1WTU1VnVidTk1Sm11R2RlYXBheXhiOWx0UmloL0tCRGlrRnFxdDVP?=
 =?utf-8?B?QWYxT0Mzc0ZDUEc4UklWWnpIL3NLaS9Wb0YrYjBKbHZvQUVxS09PTTZSSi8r?=
 =?utf-8?B?YnVoQ3A0SGpxK2M2NlRCalRKdkdUYW5mYkdjUVMzWWNpMXpFTzFVWFhwVjU3?=
 =?utf-8?B?NGRXOVpkRGhIbTV0Yk9ZOUs0bVlpa09DVEtqeVF6emp6bXdEeHViditGSUtI?=
 =?utf-8?B?S3FZS2hjYVVPdlQ2d3lIRytoUHFneldCZkc0VSszUCttRTdoUi9lRVRxY0hJ?=
 =?utf-8?B?anIxYmk2NUlid0w1a3hheFpRT1dXRWoxSUZlK1FVbGZFRHZNRlM4bjY2SWhs?=
 =?utf-8?B?WlE3WElnNzJkNk9ZczFCbTRwd0p0b1N1MGs2dW1FSk1VRFlsTU9qMTZ1M3hS?=
 =?utf-8?B?bkpFKy91Ymk3TGZrckU5d1RBY0xERE5EelptYnF2YU5JcW9jRU1CNWErdGFX?=
 =?utf-8?B?OXY3Z0FsV29yS3UzRzdxRkU0dGN2bE9hVUd4T2RnSHU5eE1uUFpuaEtWT1FX?=
 =?utf-8?B?cThuaklmM0h0RWlJNE1sU1l2VlFRR3RBWTBFMGgrWDRINUJuZlcvdjR0bkoz?=
 =?utf-8?B?V0VJL3RJa3NRM1lUZUE1b09Da0JkemlGclpYZVZCeFBKZC95UFU2Nng0SEdH?=
 =?utf-8?B?UmY5MEdQbmdrNmNueFp2SGZqc3NUc0VQOGNiTW8yRE9zNkMxaUtCT2dCazMw?=
 =?utf-8?B?WnBIek90akh5OFpLWUY2SllYaW8yM2ttR0U2V2drVWE2ZHZRWThYSGY3b2lU?=
 =?utf-8?B?bldsMjc4ZGt0TVd4WGlXZFU4enhVUTRwdUlWemhLUVA4dmtSNkNBOE5tVW80?=
 =?utf-8?B?bkxWeG1jNHFPVmdwNkFlRG1ROHdZK2UwOFdjWWpFa3ZHZm5DR0J2dmJWUVdW?=
 =?utf-8?B?U3RBVEtrdlJldkVPVGNtOFlUZVVjdlNGM2FkZjFjYkt3SlJIamxPK09vRy9s?=
 =?utf-8?B?eDRTMkI4UjBKVldhUjFjRyt4aUEycnl3RHpvZFJpZmROb2hxNlZZZkpWVGU5?=
 =?utf-8?B?S1hhZDJvanlrdmNIVkI1azRzS1E5Y3gvOHlCM2JoYWNpbmRHWmVQVGQxL2Ev?=
 =?utf-8?B?eS90aGlTZmlSN05QUmpxSHgrNHozekFSNWgwR2JUTzQ4dndqQ0t3VytJVmo5?=
 =?utf-8?B?R1FuSlg0VHJFaWs5TTBCeUx5Z2llNXN4VExxNVVBcUtIbTMrZWZYUXg5QmxD?=
 =?utf-8?B?VTVNdjhFZDYzMEJBMHRlTGpOR1Yzb3doUlVHNzF1WlNxbTZoZ3VSRW10NEUw?=
 =?utf-8?B?STFmK3VhaWxXUDBuQXBRa0J0b01sNnFzaWRtZDQ4L0hXRnFaeU5YQlBWbGxK?=
 =?utf-8?Q?1hviJX8s4bW00mb8=3D?=
X-Exchange-RoutingPolicyChecked: wIydZJrWyuvLNa+iASEhGFSACodjC0bSglJC2cNSYQjaNCATsMcIKSyKX4yfZhy1phC8do+HnKuX1vwrUNXkiSZwVgQ4ap3FQ42d5vR2AyW1Tv4M0IPu/GTG4kU8cc3x9qBOtdp988xaTd6b7s7VEu2JcoD/CZJwTIAMYT8YeCSdA97b812QAqVXnrPqNY/iKitpAYWWtoJcF4dJ1LF3qQy/Kt4ZwlVxuNh3R0agAOU+QQV4dXC5LVgq5v1WirvZDaWfel+JliMTSkfiLIKLWv9rxYebS0VvkV1slSCjB86o7BhuS0VEZF72YCLE+2Qd7KqerblD2dDDNlhn2LI9pA==
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f83a57-7f2f-422b-3c2e-08df3b42a6a6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 13:42:36.1873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XLdYOO+XYtvcUNLnXItc/eaIl++3HVdKxpTxsFjqiy+WHzKXr8BccjudOlq3TTP9aIRUURcP6NpGYqvAWyTSqdqylGCxPOFF3DYDzfuUlxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9277
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

On 11/2/26 12:47 AM, Ingyu Jang wrote:
> All implementations of the EEPROM init_params() operation always
> return 0, so the error checks on its return value in ixgbe_sw_init()
> and the E610 NVM helpers never trigger.
> 
> Make init_params() return void and remove the dead checks.
> 
> Link: https://lore.kernel.org/all/8524c812-b659-4670-b370-35682aba2d2f@intel.com
> Signed-off-by: Ingyu Jang <ingyujang25@korea.ac.kr>

thank you for reaching out,
in general we don't want trivial refactors unless as a part of bigger
contribution
https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#clean-up-patches

especially now, we are drowned in patches, so this particular one would
be on the very bottom of the priority list

> ---
>   .../net/ethernet/intel/ixgbe/ixgbe_common.c   |  4 +--
>   .../net/ethernet/intel/ixgbe/ixgbe_common.h   |  2 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 29 +++++--------------
>   drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |  2 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  5 +---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  2 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |  4 +--
>   drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h |  2 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |  4 +--
>   9 files changed, 16 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> index 3ea6765f9c5d8..ab2c0818f2417 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> @@ -857,7 +857,7 @@ int ixgbe_led_off_generic(struct ixgbe_hw *hw, u32 index)
>    *  Initializes the EEPROM parameters ixgbe_eeprom_info within the
>    *  ixgbe_hw struct in order to set up EEPROM access.
>    **/
> -int ixgbe_init_eeprom_params_generic(struct ixgbe_hw *hw)
> +void ixgbe_init_eeprom_params_generic(struct ixgbe_hw *hw)
>   {
>   	struct ixgbe_eeprom_info *eeprom = &hw->eeprom;
>   	u32 eec;
> @@ -895,8 +895,6 @@ int ixgbe_init_eeprom_params_generic(struct ixgbe_hw *hw)
>   		hw_dbg(hw, "Eeprom params: type = %d, size = %d, address bits: %d\n",
>   		       eeprom->type, eeprom->word_size, eeprom->address_bits);
>   	}
> -
> -	return 0;
>   }
>   

[...]
