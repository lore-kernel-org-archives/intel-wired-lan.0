Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20989C55ABA
	for <intel-wired-lan@archiver.kernel.org>; Wed,  5 Aug 2026 18:31:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C4FF580E1C;
	Wed,  5 Aug 2026 18:31:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eiKHJEErxurI; Wed,  5 Aug 2026 18:31:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4CA5B80E13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785954717;
	bh=eJ2t4sMm0kVfH1iR1L3IYNUeTq+Q1yHM8PIjEBZjITs=;
	h=From:To:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dFdiNrgNevwXIrY3A+gDIwe6UeotuVANk4WX0LTTgW3iymhG7ZdLjBsieBiHFVLRF
	 BZNXnyP2Wu1tiTQwDe//G/FGLzczuVX0g3D2/COfHf5my8mc1VuJ29eLwfd9bZnq94
	 4lL7sGc1UHc9ecmw1SJgm1yZqkw7cPSMyizs6UrLLe/kp9XGbVMK+9ARnNsti1gIsC
	 SrgXaW/mQid3bNUDh3ZKJ5qO4YeZlSihS5Cpbev0UGAuiQsPr8AH4yIT7fHoDj3Zo0
	 w4m6QCZHw2QOycElSKZ7H4CfnXx/skYdO/+oL0oulAOpWrNGMl5A70ZwoQxyGthCsZ
	 cG7ixQUhUn4IA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4CA5B80E13;
	Wed,  5 Aug 2026 18:31:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 542EE730
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 18:31:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 31F6260679
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 18:31:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UwNxYX7spGbq for <intel-wired-lan@lists.osuosl.org>;
 Wed,  5 Aug 2026 18:31:55 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=arpanax.arland@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 777F0605D9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 777F0605D9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 777F0605D9
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 18:31:55 +0000 (UTC)
X-CSE-ConnectionGUID: muTqjRs2SumZ1SniVUpN2w==
X-CSE-MsgGUID: OLvNxV05QI6BgxzW1w/zzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="112090291"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="112090291"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 11:31:54 -0700
X-CSE-ConnectionGUID: tfMeA7jAQqmHi2DzZMSdnA==
X-CSE-MsgGUID: LEjhj+KeRQqmDzPzZy3vKA==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 11:31:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 11:31:52 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 5 Aug 2026 11:31:52 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.0) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 11:31:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kDTTHu6c0IGKkMDF9+pXsR7yaUW0VRPF8mMCtqQPnTPiQpr403zs6silMynevUSPKh9wHhHfSelhcPog7GPAnutfRBefGt+wn6xerGbaFL4i72Bg5GO9Yn2eOkOLnHpj1XSbPa+sncRq99DSrjZ2wEtUX77lcbQw/7LkLUda4QU2bvhIP0I8qVxgV/wSIeDQ6VJogfYtXXCCo4/uqefG9w1jtittFk06uxmyClNtiPuquzqKHYaQ1aI8tlkyYdOR1+5EZbYToItbZ1gVZ2Xti9rW4Vj/3eaY9+c/sO5fSEfxiwzQmQ0E1ySFHM2hANE5c3//kXllGDWcAvDAlOxbzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJ2t4sMm0kVfH1iR1L3IYNUeTq+Q1yHM8PIjEBZjITs=;
 b=Fd+LJD8dp05RIvVYmhIgcdRPOvJSNZftR5qQdagor2x+LcE/uiVeWWydqRNPFBRq3Y0uLtP35lGRxtijeeGG6jCM0WmHSmQ4nEUhQBGR4penI8NFOfcFvytMMfkxBYuYopYJD+IXc57AfTD2ybJJ6cIL+7l7LbFe1nRx1n5jmSNS4to8V6Qx7oiB2pGL6G5U/qAlQEB61XW1GiKFmnKDVplDxx+k6UqUPCibIAL5H/faWFUscgl1gnZeozzAwQl1hyj1wd+3+U46aCH2PGVq8vAzU26L7mtlJk+9u9BwB6AWi1+e/0vfQ2xU1KhhLqu9thfGUFqauPqMvdBN53C7xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB7155.namprd11.prod.outlook.com (2603:10b6:a03:48d::6)
 by PH0PR11MB9612.namprd11.prod.outlook.com (2603:10b6:510:3b0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Wed, 5 Aug
 2026 18:31:45 +0000
Received: from SJ0PR11MB7155.namprd11.prod.outlook.com
 ([fe80::a279:5eee:c8d:31c9]) by SJ0PR11MB7155.namprd11.prod.outlook.com
 ([fe80::a279:5eee:c8d:31c9%3]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 18:31:44 +0000
From: "Arland, ArpanaX" <arpanax.arland@intel.com>
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [Intel-wired-lan] [PATCH net-next] ice: rephrase LLDP filter
 fallback message
Thread-Index: AQHdFclwL8YVEDFT2keZe7TrYw88WLaP5Oqw
Date: Wed, 5 Aug 2026 18:31:44 +0000
Message-ID: <SJ0PR11MB7155AD49375356611F25AC5080D32@SJ0PR11MB7155.namprd11.prod.outlook.com>
References: <20260717084453.9521-1-tbogendoerfer@suse.de>
In-Reply-To: <20260717084453.9521-1-tbogendoerfer@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB7155:EE_|PH0PR11MB9612:EE_
x-ms-office365-filtering-correlation-id: 0e10676d-98ee-4238-1207-08def31fcd73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|6133799003|10067099003|11063799006|56012099006|921020|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: jDEnvj2q4YYvA+WtOg6IvghFhXM6VvH7a4vNg8VKLk51v0ye4Y5NzOAw3+iwaoel3SdPfZ3Xd6gTECd/m7rSXOU8CNtL9ZOI8MVs80gCoPtUGsiiPYh8xr1ctMv6gVOU9kS7ZGB4ZUucbzRErs/QUYUcMjlwQpofKalMrFE5oNe/Z/I8Nvt6nydU9orgKGsJ5H5Td/2Cpilr2NTu4A8qVAGqNIZLZLsM9wV4fOt5XbGy1I7SZhwrSiVZ485I/WdNqh8EVhk6WDp59MB9r+ZsM1UwVbpkxY5VsGt2emFEXYkv/fNAfrgpdTTO+ZRceDEtqqo6CD2mqBOQHrEiTPaiRQ5v0jFI/f7N43sVRb5FbkSgYADvUQsLpq/nntHcsQPU5/Wgg70rR7KA+FHw6ir6/wm0Cvh+iqUvegAyIlQ9ffeD2+TF8A0J5+EvJ4Nzx/k0T/UKpTWHA0jytAwzCRqIioEYAT9mqSrfGuEZDi3saI0l/ifsnyc8VSo3lNrUBqHH1BTDR/jzhRhPE7HRI4v+YCJU/Io4+CvYcks6VegZnBt/ZRhzqE0rVw9Z+9HQv7FGXPjfNwhbLJLb0sYnqZRUbVrDSWsDk0HKSqH4t1lhbs6gFauvvFyPpXJfYJLVxdMM/gglZskyd8kp5ihpqpVFRpub4GddbazTpIDvmLnOW4HlZiv5iOmVM8POfHrWG7Y+OA7oUaF6Mky32143dw2hB4VwiA55pc1xSxU2KPcLdIQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB7155.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(921020)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sEYhBXgGX/li9kkNL8cRZSGzxrMLh5FRMzb/KjBM//6YUkj6FqJn09GcD5Uy?=
 =?us-ascii?Q?OiFlcfeffTkIMldBVUJ5MfMW3e8Kf/mk2+0q6ewMVmafF7oKpy8DlwEIXQev?=
 =?us-ascii?Q?CHOxsV2956+ilVUPyLbltMwjT7ul+oDHmyT3qNTHw9kWVJPqAWZPwU0wkPYx?=
 =?us-ascii?Q?AtL8DgC+aDRDexAn20X1sXTAQ3c/8/6aTou9Xeq/LaIWKCwbFdlnwEr8XXRF?=
 =?us-ascii?Q?suTJTWIA7EX3Qic1aGBGDsrx9a5pFKA7WhQ2IuY8EP7qAxeoZcV8TETVdW/p?=
 =?us-ascii?Q?8RQR5C/BnvCxHRTt/Yog+2KCnilJDOn8hP6OJ2K7Z7xLwwR3MWPgAL+5BJWC?=
 =?us-ascii?Q?zEKzko9yAIN3/gpXxTBfUjaFd8N7Lyllj/jVUyKVTKcK0HX7rhcMGXOk2oy+?=
 =?us-ascii?Q?ce+9JwrIU9COBMIcEDcEUHDjwnQXbnuoHd1+ooP+xK2E8KOovWUa0rQpgc6V?=
 =?us-ascii?Q?vocgJJXgSpIgVimr+L7V64JctY1Lmx8Xcy6NbzwE7vFSgAoo1upNTiQVpYAj?=
 =?us-ascii?Q?dXxjO2L4AFLPTggNlB6uOWc1AK2GqNubhAROkzEeo35IX1ZZW1px61xILpRb?=
 =?us-ascii?Q?z8P6a2bMQABNVYbLf+7JIWipPcODTyvgxdxUxF86FjhMkaQf4KqiZtYONcG1?=
 =?us-ascii?Q?7/dnBTJtkx3hPDV5MxRhyPoyfFkfX9EDqDMGuEiaOirNC8+dJmVutdAckZWn?=
 =?us-ascii?Q?Q1sSKC+ebLp9P6kV2EUuVvYjXBPmDf68tYaWTMl3zn0/PuVxVbHX0gvBQv7U?=
 =?us-ascii?Q?Wj/FxPCCu1uRbAEF3cItFYNM21mf4GiOruFztcb9MsUMQ3s7okSOEanpyyVT?=
 =?us-ascii?Q?dpm3qnVds/9HndJlEi+Ps+xw2ucoKBocx1Xm9keg6Pk6oGRX5L1kHkABJoW4?=
 =?us-ascii?Q?VeHmsZIXJvxLCRbBOvKVITARJOYRSV+OOS6XFrm5JSfJL8BXCPTVbbkqVyA+?=
 =?us-ascii?Q?zKCo1qKWOPOQlCHOXgjoPobWBsSyNuKPTzLn7SHV3dskEtzdD/GyyZ6/r9pl?=
 =?us-ascii?Q?rrXxdT1yqoWkMeOYB1yorZuUuFmMx+qS+bKR8g3hr59BVgb0qMSDMSUwrTaQ?=
 =?us-ascii?Q?xMvMOfC6cG3SP08o6+4cwfkkC+8M499F3YGZ9qOfSdznVuaSXZ4jbHFBJVhF?=
 =?us-ascii?Q?o6FxIJGbbkpcMgTCwAiVEyB2Dqbvf0ldqLo9/9fpK28zEReyh44mu1OdFgYL?=
 =?us-ascii?Q?vFdw3oKMTZolnrcrLp0Xgfqce59iyhP76WauwvWkJeweI+vDD32Gylw0egQI?=
 =?us-ascii?Q?RD02LDKCSUoea9sMXYFNKLAwh7uQMCoqMvYEPqCNNuYXrdm3jtpQZmuy5e5e?=
 =?us-ascii?Q?nDTjjEvKku3YV37hbALOzgfbZPMFm7CgqQ4DiJnxINw1LyFWG+h5yMJ/Rh5J?=
 =?us-ascii?Q?qG8G7uAFRlEylw6JXqjGsRnh2XeIrCQeUrHu9V3kCDuyl+biKYTpNQE6qhQB?=
 =?us-ascii?Q?ZEgbizbgWcjmzW/d9bDSy559dpoPe0dg9r66JLTxNsvAlOEG+G/P3g4NWtAl?=
 =?us-ascii?Q?y9L/VhoognM/cVvjhiwVK/MHCFIDsCocImbGwR/fe2zVs6oPxdUJXReDLiFJ?=
 =?us-ascii?Q?QYX6pLztdHETxMTpHeF7imNkEsIQgazcR1EkzpHq7nQtphik4RlSChnOsIyL?=
 =?us-ascii?Q?OlHoL+JJ9Rtuz3q0HYfgRIH65iy1kdEYTqV9Y8lFKiJoKBObtuQxBvJOwte9?=
 =?us-ascii?Q?mVquUeRstw2l357X6SkDzNuPNDzenTAWqvnp5rvtEVWwTm0Xq67sSrBAZtCe?=
 =?us-ascii?Q?VLesZDPb+w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dNkprAZZ4BargJACseruaVAaE6lu8O2edeWp7FrsLpqoCyCu0LJnSytc7CESADWLQhz6BHrTirWv5dwWWKGb/7F0n+wUfCaM/DId0aFDE7ktKAaZbSUppblHr+spX7/RBswvNrWdkppvdSBG9aYx1bOAFvqU1+JgbZ3ufZIjnhjIwuJGhG615K5E2/FaLsoYCDaLXapzYDQmpCnEYM/FbyUaNlkS0C5rdmf2SKywxXlS19Z4mk4kVLfa3j6rcPwQ7NeswQ/uW3CB6nftBvUSD1Rvt4uJkyYAyEn3TnEwOCvc8p50NKWWYldu9fvhFQ3QI9NN6565wWIaw6Kj0M4p4w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB7155.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e10676d-98ee-4238-1207-08def31fcd73
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 18:31:44.8923 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8TKRtCjHg5evXxz3dVzKzkZ1miPuVPItKFYF/B2OhlERjv/a+wRBouJoIrSPoSMngckXEBEpU2TS23v+EAZzb+c8u1jrgdwHJMoUxKvsAlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9612
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785954716; x=1817490716;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=dT0P02u+x8IdHtGy2ubrE2d5fXa7GzOTjGq7EPr/ulM=;
 b=EXfKCrsQ3ZkrirBxUPpfs1QPczQHtJu+4Ei7/H1Q41x4HU6S8iO0KvSb
 DgDdc9wJNcfz6ihm0NQwYG5tQV0i2xRoDbTp69VOPkGAqcjrtENo6+yTm
 HOetwfccDQ0M49GMal6Py0xmo1bsg/Hx0uxv2uT1XQR35DvkRNHzFv+EM
 8hOf6JLvctQ5j3sxAfQymL9oljAmtSRzKIK/I5wxGrx2fReuptXwCcikS
 fzbE/An36TewKIDAc/RehSIq5lqaTTaojdn7Ta9vp5Azxg21K/fZ7JB6j
 /FLyaLwnJ3VIJucCcj3MOHSVT1MApqX7aIn3ni1Mes4ZpvXacoVhmyrdp
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=EXfKCrsQ
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH net-next] ice: rephrase LLDP filter
 fallback message
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
 <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of T=
homas Bogendoerfer
> Sent: Friday, July 17, 2026 2:15 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S=
. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub K=
icinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; intel-wired-lan=
@lists.osuosl.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next] ice: rephrase LLDP filter fal=
lback message
>
> Seeing an error message in a logfile triggers scripts/admins thinking of =
problems. The LLDP fallback message itself is not an error, it just indicat=
es it's using a different filter mechanism. So rephrase to a less "scary" m=
essage.
>
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Tested-by: Arpana Arland <arpanax.arland@intel.com> (A Contingent worker at=
 Intel)
