Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED009606A328
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Nov 2026 18:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=nIkCEhUL;
	dkim=temperror header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oJy+9vT0
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C3E2060859;
	Thu,  5 Nov 2026 18:08:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sDZI6l4LeHjs; Thu,  5 Nov 2026 18:08:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DA776607F7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793902106;
	b=ZJz9xdDGdHSkg7asQY/8Q0RjsM4xDEnH1qZ3qSRUmr7t5cgZFAuc3FriSSfrsiNVMThp
	 Z2YnHwc9LDO5+61n4AfooYaMrBHn+DejJ2rfp8/Cvmsol9O/kES9UMH6e5Rcfz265fF/D
	 niKA/2ILjhEl2OXPsSm3ljf+UKFh/Hte0QUP/zfChEbcsDiC9Nk6T5ln86FNnSkYSW4Tw
	 r/ZM50o6cZ/xtQVwaXhyQi2YYXzJZ5rng4dWEQ60l0fUWve0WYxiIMXYuCK3yi8YS3nQE
	 6ykFP3Nso6nK+MXgTcWeoCQrhQ8Ux/pQ4QptTIxUwjTmzf+jbuvhSAKIuQ5FjZ9GVkA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793902106;
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
	bh=oNeezkSjKwYCFqYLgDz+6bO63KxWRGqGLCbLGHkdtAo=;
	b=cZBwA6SREkeN/DkNFBPJP4H5bXp1Vdo4cEwSeoR35Ru4C78Pp/yyl6l4QCJqmvsTGB//
	 sOlLH9qmRQ0EUUK4HRfX2P9CHOK6+AT5lGLZJt/m7Z/vCLnlDdZ2JfABqeQzErztiPVAp
	 k8GKxYvl8qYqGpQBj0l82D/1J+x6BMB/ohzie5b+WsaI/1TY0zG+BYY8eOkxY21CeK+Ln
	 tLkOWd8W/243vUm+5lvOKtOdsHFHq01aTDQ9QxxK9o/7OgI8mbwYr0yNQ1t7q598PoTAP
	 AGN7CfR25wJzzTlI/e47ojry401Q5FGL6TgWWCsSWo/CjlnixHStrLSrdI6VTSzuP1w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793902106;
	bh=oNeezkSjKwYCFqYLgDz+6bO63KxWRGqGLCbLGHkdtAo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nIkCEhULnQtryBa730qfa3hsgi4XrHrIe/awm7xtJr3C2s3bWl95kOKwP7bkWjUAB
	 IuiD6uBdlR2noGSzLirXR9I2x+X7xdv4RXHqzy5AtP3qz6T7UtG6XclUgNryhLon5y
	 BcU7xHwc/M497GomTqy4uXbB3N+VSoKGptVRKGI6DTJq3KVhT+YcKZ14d8TNG2C8Te
	 8v1desFqJMib0x3HlmWVsGsNXqssTQONjBIq2/Yq6eJYzomIf41tfWrlfl78Srl+a6
	 G3mfqM4ybM36HQlMVz4S9NlKvVAKis6kNeDkHy80uSCINm5mPN2Vzjiz/vqlqX4xEN
	 oiLtonbHUEuYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA776607F7;
	Thu,  5 Nov 2026 18:08:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DB0492AC
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 18:08:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C0F2280C86
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 18:08:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HGq7bj3Froa8 for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Nov 2026 18:08:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BFBA0810A0
Authentication-Results: smtp1.osuosl.org;
 arc=fail smtp.remote-ip=192.198.163.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=aleksander.lobakin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=oJy+9vT0
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BFBA0810A0
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 18:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793902105; x=1825438105;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PTFUWWT+qs45hZQk7gKmXViVRWNiXf6dfpWeEN/WOZ4=;
 b=oJy+9vT0OhyLVHg6C1zjbiR6sSxLcC3Z4wID2ubobLhZkg0iEe3xXWki
 1ljKt9be0r+KqI5ohT/5yv8N3W2UaTDTyKAnk2wl9+Ugjsk7a0qjdoIdg
 UFlXbNdxKg9V3VJQZhVmSMNCG0b9yygjpt2XrIpfrI/9NI+ni+foIMpVk
 98YQrYvfEixmgzSSy8YQYETAxa9CjRqkdmOu2XXvfGWOL4WZoKIUGZIEl
 Tx/YubI8vKq95sRx7Esn/kcTaT3FbL46gCuSZ+2cee56PbhKQ3xeNTgeR
 7nf3R0qchrgn10zdmjrSSzxfkQkyBlkxOpAzQUcuXvBcbNBHlYlZAwjVU g==;
X-CSE-ConnectionGUID: LtPliMmGTAez7VtaM1wKmQ==
X-CSE-MsgGUID: T1c0MebBSJWlVDyLOItrkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2735777"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2735777"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 10:08:24 -0800
X-CSE-ConnectionGUID: XKjnxUCfQee4QURUvVS5vg==
X-CSE-MsgGUID: kv8aYLauR3qcB4wpQzPFqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7103320"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 10:08:24 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 10:08:22 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 10:08:22 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.41) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 10:08:20 -0800
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA0PR11MB7749.namprd11.prod.outlook.com (2603:10b6:208:442::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 18:08:18 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 18:08:18 +0000
Message-ID: <1cfe950e-50af-4120-87c8-375f67eb3e01@intel.com>
Date: Thu, 5 Nov 2026 19:08:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v3 0/2] libeth, idpf: use GFP_KERNEL for the
 initial Rx ring fill
To: Luigi Rizzo <lrizzo@google.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Tony Nguyen
 <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Luigi Rizzo
 <rizzo.unipi@gmail.com>, Brian Vazquez <brianvv@google.com>, Joshua Hay
 <joshua.a.hay@intel.com>, Larysa Zaremba <larysa.zaremba@intel.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20261103162326.3615979-1-lrizzo@google.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20261103162326.3615979-1-lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P250CA0017.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::20) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA0PR11MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: 657e6624-dddf-4230-b133-08df3b67c4ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|376014|1800799024|366016|261021121427099003|261022075727099003|11063799006|56012099006|261028144727099003|261022105027099003|261026140227099003|10067099003|261102123227099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: U1a6Dl2rYeXLUll87xbKzCeuu19KWaZF17mxAk78OF0ehcmm5NX4eS0JWZXYyA13dLX7VsoRuPrFds8qSZTdJvyTlfUjEBTwmkGZfbdyQcZDVFxjHhM+4B+fBrr8ZWPw1TORsU0sHvY5luTjO1I8Ed9kZaokuuOY6qgIixWh0NNEipvrXyUbiBzcBIE+kIgf2EvLRuEJSH3sGW5GaTKjhtkkOxqhppLesnhl5I8BzAUebo8IlPY7pAdGuizsc70UUUZw7L0sa4T6SGC/Qw8BY89y9BOeGdPPEAiM/1vE8wHhbTaZDKWlKViFcr61ztia0Gzx8Esw2BTNci8qGtomJBrdIOJZ+P2jXzdPPcdyZcR7XbjfEp83Mf6kJYQSC2Aa3NYeT/6DspAGnVvfkYuP3L7fBZ1fZuCZofzf5gYQxZ3JesdNHjSRapPYL4RkYM2prgd/ugLNgqXVxisRKAyaYJlvV9IOAtqGkDHfVgUcQE21l9b7MS0cZFR4fZmW21w1Rhb/nYDQgMVPHxq8sVuFMXXd0YHwDkdz6dSFL82jb/8Fo8r2oTz8qCCDfuphKY/7PspscbcaNUgJorGEuMms4dTmBKf9oNDDuDjX43zkH6g+kxrebf0v7sA7CMxeEglk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8718.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(261021121427099003)(261022075727099003)(11063799006)(56012099006)(261028144727099003)(261022105027099003)(261026140227099003)(10067099003)(261102123227099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmlNQjBIdFh2aXNvUVVVYjBiL1ZKUERYSkg2d2o1MnhPMDlkdWJqWWY0SGUz?=
 =?utf-8?B?THpSZzV3R0FhVE9PczFSK1AxK1o0cS9OOTVPVUREREE3MFU1QjJKaWJ3cXlR?=
 =?utf-8?B?MGZ6WlJrd3dDWWZOVis5WHZVTFJzVGV2a21selp6cjdjbnBWd1F0dHdsUU5P?=
 =?utf-8?B?SWNKZURPVkM1dlBGeVd2Z3RyUGlPYUw5TEU0elgwQkxUZEZobjJLRFlBK1A0?=
 =?utf-8?B?TEc2Q1JscjdOMDNUZnErYTVvZSt1K0xuOHUwbndwYnBneXR6Y3JvbVcrdE55?=
 =?utf-8?B?Z095VzRLTlpsMVp1R1ozM2JVMEZqSVNjK2kybnVCcnFEaWRIQUQ1RFJqRDBy?=
 =?utf-8?B?MUhNL0ZXUzBCMm1uSUpSakVnUEFpUkFnVkNCbzVXWEFFd0tFa1U4NFZqdks1?=
 =?utf-8?B?Wmcxa1ZTRTVMVG5BY2s4eXh3Qmp6dE8xaW1DWDNtdVU5QVpjaUxIWkxleGlq?=
 =?utf-8?B?MVZMNlNMTlVYNnUxNVFST05ubnRXTmoxbXNrVXhCSnd5RFFxZk9WbW93SS91?=
 =?utf-8?B?eDlTY0REVjVrNGpad3hNZGNHMnRLbERZMXUyMFVYZjVuTy8xQWhJUHhXQzQ1?=
 =?utf-8?B?dTd0UHltVU5MYk9QcTg5K1ZmRXhWVGx4WkpyRlMwbDdkRHF1T0o2cVF4QTFO?=
 =?utf-8?B?WVlPZzA4Z0dnSHJER3FKUXo2NHNDK3A1YXROZ3kwd3lWMVVmWFdGV0tFUTFE?=
 =?utf-8?B?SnpBQnpRaUZITzdEVWZXSzB2SGR1M3NCMmE5cXBYOFNFU0tlQ2kxNGxOZDlw?=
 =?utf-8?B?OVFaVjlmbGpwMk5SSHVsbHNlSkpGaDBEVVZQWGJYaDI4SXdhNkcvK3BwUlFU?=
 =?utf-8?B?RHFZWVpYWmRmY1NMK0l6dGh4T3lDaUcwYjBUU0hHaFUwRmhEZlZxWUUzdSt1?=
 =?utf-8?B?UlN4dUNGaklVTGY0bUlsR1REMDNGWjRicnBWTitsN05wRFVPbWRtTUhrREtN?=
 =?utf-8?B?NFFzL1hxS2piNWRBVktNQ1hGbENGOW9YU2UyRkxzbXU0M2YrQ1FRM2JYbGt5?=
 =?utf-8?B?ajg3M3VDQ25rQlM3S3k3dDN6K3hGRC9tYXk2REZCcWJTWlFhYkQyTENoUUhz?=
 =?utf-8?B?M3QzWURqRWN2MlZNaDdSc2tNTlovWFlWOE5NWExoR1FzUHp2MmZGMC90QlFs?=
 =?utf-8?B?WUNkaXYvZzBRSVJkTXpGR3ZxR1JJTVdVSFcvMFhmcmFnZHNhaUF5WXovTzVG?=
 =?utf-8?B?ekdzeEM2Rk0wMTcxcHpUcC9TcmY3VTJaL3QzQ04ycW5yY1NaZVJSU1h3VUNK?=
 =?utf-8?B?THg1RktNRlpPR2UrSlNNdnNCZzNJekNlSFh5MEVLL2FITk9tYXU1dG5qNjd4?=
 =?utf-8?B?R01EanFBcWFROFRaeVl3eGs2TFhPVzh2RTFmSVZZMXByUWtCSlViZ1BtbmxQ?=
 =?utf-8?B?MkRqcXJTNkFlcFcrZjljMjZwSVJlWUhKbDkxMDFOL1I1U0JJYW54ZTFKN1RC?=
 =?utf-8?B?SGVDeHZjTjNjS2JWRERhcnRXajNtM2ZDS3ZRaEpTMXdZYXZIOCtuYnRXZGdo?=
 =?utf-8?B?VWI3L3BCMjZCV245VUhIcnY1UjYwZVUrcnBUMTE2Q0ljOENIbnE1S0FpYi9T?=
 =?utf-8?B?NDFLMy9RZ3FJWkNpeDFmc3FzR1daWk14WGNEUTZCTGh6T29GbVpuYzdrQVZk?=
 =?utf-8?B?OU13L2RFbFNZSGtRQm9LbndkUnRuS1NpSEpxWE1teVphT3gvSDZiVG5TNzRo?=
 =?utf-8?B?SzB5MVBMSFJ3TFVsN0JvVVUxeCtFcjlnKzVnYy9SWG1FZE1zUmN2R1JvL0Rx?=
 =?utf-8?B?bzRmTWh3VzRwZlV6VUhMWUlWMDJlaVZZRVZCMURVUExmWHQ2RFByZlZRRnhV?=
 =?utf-8?B?eHd2MUw5ZTVoM2V5TEpwN1Rmak9xU2ZtSC9FQTkyUTlFVHhITTNyKzUwSEJ4?=
 =?utf-8?B?NkszODFFTU4zU0ZWaTBXdkVuQ0pQY0JSLzEvQVRBRGNkUDVQRWJVUnliQjZ0?=
 =?utf-8?B?bE9lL1Mwc3B1aEhBeUdhRXhCR2pzME9sWTBHaXJtc1FrNVphTkdMRGI1YnZG?=
 =?utf-8?B?QnA2Nkdxc2VrT2ZESFdaVHZvNHhaam1waGszRXV4M1Zwd2FwWG1BTnVSWGZQ?=
 =?utf-8?B?UGhxV1R0SVJDQmNaR09qZ0NwNjFZZTlFUHZPRUI3Uk5ncjJSeVB1b3k3Q0Y2?=
 =?utf-8?B?SGxPYnMrSlVhTWtMWXNoTFdKbkxUVXU3TVROMngweXhjUnlzUktYTTVHUHZq?=
 =?utf-8?B?U0lsWmNuU2FSK1oxYnB4SysxdVl6WnNXbzhjOFBvWFZuZTRVUUV2Ty9WYjZw?=
 =?utf-8?B?RWNRZkJzL0tqWHFSZEVtK2ZpemxpWTFQVFlYVFk2QUVsNHhrQWlDR0xxaXVO?=
 =?utf-8?B?cERxMnRkRzZkNUVYQ2s4WTYyeFl3ZWJYaDRKQWowaWR4L25VQm9jWjlpTkh0?=
 =?utf-8?Q?28OSfjJ1e6euzZyc=3D?=
X-Exchange-RoutingPolicyChecked: 2RQH6NkcpNGuBLYBrsy6a4KZCsdBnwtrh9dXKyT3tu0UbclUY1nWg+6o4Ng9Ycmp8K+KeOuFhr9uy3CBSbkTxUEgfTEVn+xaGhgCxgL0o0aKep+YV17ZKZuxP2/uJxismOpG7ENnm5aD5xqE4PrhVJphWnL8u966ZvXOK1RMT4zWmqtCzduNdehjqHpr+ozBzjcRIhZ+MNSHtzY2AuyfrDNwOcte+7s+D7ZYQgvTeObNapap9LErApywQ1iU0BHx99TI2Se/IpQQpDlirbqthk2BX8+7NYcMpxiDZSR6jm3Tf4JZ+BowcqjDuVdMAm8GY23RmIsFei1cdo4SGIT6eA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 657e6624-dddf-4230-b133-08df3b67c4ca
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 18:08:18.5187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZWqgjBK0K/Vwa+/xVrjHEJHhJ9zWd8gnvbXPbK1a+upBJLYkCBocaxYna6byyaOTELQXfunbTV4O9SOBLKVR6Hnt44IOxeP0JascbcjOp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7749
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Luigi Rizzo <lrizzo@google.com>
Date: Tue,  3 Nov 2026 16:23:23 +0000

> libeth_rx_alloc() always allocates with GFP_ATOMIC, including when a
> driver fills its Rx rings at open or on queue reconfiguration. That
> fill runs in process context, right after page_pool_create() and before
> the queues' NAPI is enabled, so it may sleep, and GFP_ATOMIC is
> needlessly restrictive there: it can neither reclaim nor compact, while
> the initial fill can allocate tens of thousands of buffers across all
> queues.
> 
> Patch 1 adds __libeth_rx_alloc() taking a gfp_t parameter and turns
> libeth_rx_alloc() into its GFP_ATOMIC wrapper.
> Patch 2 switches idpf's initial Rx ring fill (both splitq and singleq)
> to GFP_KERNEL.
> 
> v3:
>   - rename libeth_rx_alloc_gfp() to __libeth_rx_alloc() and put the gfp
>     argument on its own line in page_pool_alloc_netmem() (Alexander Lobakin)
> v2: https://lore.kernel.org/r/20261019210604.2433620-1-lrizzo@google.com/
>   - split into two patches (libeth helper and idpf consumer)
> v1: https://lore.kernel.org/r/20261016151835.2500807-1-lrizzo@google.com/
> 
> Luigi Rizzo (2):
>   libeth: add __libeth_rx_alloc() to specify allocation flags
>   idpf: use GFP_KERNEL for the initial Rx ring fill

For the series:

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks!
Olek
