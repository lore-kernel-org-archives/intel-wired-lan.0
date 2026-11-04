Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39913606A328
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Nov 2026 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=xRhKSlop;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aI9UWV3t
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 126FD4086E;
	Wed,  4 Nov 2026 18:31:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cXzKVTADunwk; Wed,  4 Nov 2026 18:31:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5FC9940A11
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793817095;
	b=WBp7zXUEi+o0N8v6mqblfp+gxAUyhkaveu/Vw6ikj3fRjMTW+Rb3xDegT729Oa+nvyLY
	 6ObtAto4y9EiUfjkF/q7zmTfEOj5a6ZtX9AL4YVZ1tmnHYrBwyJdVl2UajfjjfH6XbA/w
	 NvpeT5iAA8OoA8yKvqlzprqlBmBD/Hv2Oj3kY0UMw5MrYXZJ5hwYhbUxPoWQS1xEFO8Ga
	 dUP8shv+yJDixfmEL4hR6Db32Ql8BDmrESrJnF77h9V+gTwvJ2qZn0F+XYJOjZJdogMiB
	 W5GG3mPVjyaPyIITILlu1hh20bcnCSXleauL25S/UW423gOFdNaWUJ57EY8IeX13x0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793817095;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hrtlgueJdYURRHyPV15NiuzSW0QDPSNI/Ajz8pHR9c8=;
	b=CiuqAI06rV926ag6kNkGN2Hn6qpi5BQqIG99icnpCOUPA0osHDEdWYdtZwutSdipPSj4
	 qkPZ8wQqJmRwvpvs/kkFYyqjEWZDH52NUxZn8aFDmZlB2Ps24zf99t9mGsLlImQXVbmRJ
	 5EsdXrY2YGUVH5uCHqtQxEaxi4eHts3wOmCQiGqN/MxjTSUi/WH+soJ0xp05CFN5RWc0k
	 td+zX6qZNirDvbFFg0UxtzI9ElTgfGd1MjbMMuz3bGiZnhfbx/xbJt4JmB0W9mSo3S/rB
	 WoH/z5RPuws0KZlWtgKqSJFQL9GV2Fbg0+rldwsApCIe66SQ9DG/vKSAZdqaaLHt3cw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aI9UWV3t;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793817095;
	bh=hrtlgueJdYURRHyPV15NiuzSW0QDPSNI/Ajz8pHR9c8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xRhKSlopBT8c4InZayJ1tdo9ouUvfo34flkz4YAxMWwztiChKFaSpRF6Fg879LmIX
	 W2JKqlV2nx94XuDngfvWDRIfU9v8hBUBZS0LkJsPSQppukGQJotlyJ4zx/jowLIRs7
	 CvDtFFDQnfGi2Kg15q8p1NWP/fA18kiKGSh252tMrkY8igudRUcFyEdmxNhxXMjrHW
	 VWtj7VQ4uMCVvKjjuioRmu5u9jyXjthqMtPecyCa2UAJAIHzTdGBBbk09CtEaAttIA
	 BfSyjLLdXmIrcvdaMl28iPDI/P2MZUPNF3no5Y9jRt5cQMN2onqz3u2Na9LEEBp2te
	 Un69anVpG418g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5FC9940A11;
	Wed,  4 Nov 2026 18:31:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 60822177E
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 18:31:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4DFDA40A11
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 18:31:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fbi9mTwrzYDk for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Nov 2026 18:31:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5608B4086E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=aI9UWV3t
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5608B4086E
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 18:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793817093; x=1825353093;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BH7MBD2eONFOGE+SKMngU6JjOgP8gyAGVfdS8py2pHw=;
 b=aI9UWV3tfw+Bpd1EGGaFX7RAbhTp5fGSUrRhUrSw5sXZ3V+RJ6hnHX0/
 ObDvTthLndyYui3NF5yGb2CwZVymXGWDzC78aQL/tWFAneUADVHXM8D3T
 fHUC7RGWvQYqREEIRHdPCgkhXVB+fv8qQFgh1yjJLu2mmL7dXuRFnrXF6
 ezCDHshzCF5Z1Hv/kPuWrmGpXQWp11UsGHqBTM3K/NDSe8N7sbd6sPUsW
 FVgmivQ18XpEMc0IbB1pL20Fwqr6tSprfIhYFQqSRt+3y0YObTwg0VVXB
 e7vf21ReWERB3gWsQAcFAb9O+2WfcluboM9mz+kP0SyPIXi6MjaAQlZrg A==;
X-CSE-ConnectionGUID: P+kxWKEkTPC+2Yn8MVaHGA==
X-CSE-MsgGUID: hmMDxeyPQf2BqiW8ftdaDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2613371"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2613371"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 10:31:29 -0800
X-CSE-ConnectionGUID: ThTV7Hm8TraFRxjO6G3Qhw==
X-CSE-MsgGUID: xOs4UVbSTWOV9sgTYtNxOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7128543"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 10:31:29 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 10:31:28 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 10:31:28 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.24) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 10:31:28 -0800
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by PH3PPF179F31853.namprd11.prod.outlook.com
 (2603:10b6:518:1::d0b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 18:31:25 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 18:31:25 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Tantilov, Emil S" <emil.s.tantilov@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Burra, Phani R" <phani.r.burra@intel.com>, "Zaremba, Larysa"
 <larysa.zaremba@intel.com>, "Hay, Joshua A" <joshua.a.hay@intel.com>,
 "horms@kernel.org" <horms@kernel.org>, "brianvv@google.com"
 <brianvv@google.com>, "decot@google.com" <decot@google.com>
Subject: RE: [PATCH iwl-net v3 1/2] idpf: fix possible race on remove during a
 reset
Thread-Topic: [PATCH iwl-net v3 1/2] idpf: fix possible race on remove during
 a reset
Thread-Index: AQHda/E13RV8D6Y4d0iYaCOtGE/xt7cePV7Q
Date: Wed, 4 Nov 2026 18:31:25 +0000
Message-ID: <CH3PR11MB566895F5A5F05574B7DE1C879CE5682@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261103235354.1063721-1-emil.s.tantilov@intel.com>
 <20261103235354.1063721-2-emil.s.tantilov@intel.com>
In-Reply-To: <20261103235354.1063721-2-emil.s.tantilov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|PH3PPF179F31853:EE_
x-ms-office365-filtering-correlation-id: f9caa150-b2ea-486c-052a-08df3aa1d53c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|38070700021|4143699003|11063799006|56012099006|261022075727099003|261021123027099003|261009223027099003|261009221227099003|261009221727099003|261009220027099003|261009223327099003|261021121427099003|261022105027099003|261102123227099003|261026121527099003|261028144727099003|261026140227099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: mwn0po+x1De06F6YYq6H1V6xR3Cik2Gs0XGcrXlKmep0OUYB+4r/3azzoU/YCWfg5jYVZtS913aJnPafvaWQi45zxMhNeCO7YLJjPzy3Q0kLUlKO859C11k5SRc4qccWleKFpikFGXH48F9IrTC1l+kv9DQiM8qFz5DCtPwkFCQNdMNAwtjwhodKuvxD5xwO2x0PW+Q2VZS1RWtnQkokRn2CmK6R+hjRIyUwNDYWFhff5kM4kWVTVWUVx6r2Gt0wrCJekSTYGWKdu4D6G0cevOS5Dhe7OqJuuOQmXdCKGAVj11QH1cs9BTJIcPmzSqOKT9JItOIt3i3QzryXnCVqB/hrkKsBPLYlQO3W7C6mu+i949kCHS2a1LRhJ7zEJLOhCnmrG5TfNqW5NMXZx46M2qZKPXjrK71cmywiTv8Xi7Bv9JPBspANWWUamPCw0m2v3zUxAGIfhHOZZI6wHthTYKKdWSkOswFtG685Y6ezx9q2jmS9fimim+q2p72cADcApYgZ8iamkSgbmcVILEN8e59e3XN8TvEF/WTtOf1hdw2rDSCQvfrNOTcn9Qt++2Koi6b5/5ChMIGy0VoiqROweSOfeShAMI7rPHF/W+o2NGDCCA9cIh6kSzqCCq4xyo8l/k/nbRXhUbSei6aGMxF+iy0sh1MHsKDBt0TFpeMMcFEXdQt+3Ktc5zSAtaLfmh1XwUp/kB3Ob/yKn/yyq/ihQyEeDFI5AY66QrHfvAuKTog=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB566895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(4143699003)(11063799006)(56012099006)(261022075727099003)(261021123027099003)(261009223027099003)(261009221227099003)(261009221727099003)(261009220027099003)(261009223327099003)(261021121427099003)(261022105027099003)(261102123227099003)(261026121527099003)(261028144727099003)(261026140227099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JBSKl1r3SX50OmH/3c0WICa4dFT4RAvEkH/S2CZQFdnV3TJtVBxfD86XiYK7?=
 =?us-ascii?Q?XQP5gsao8XC/weglP9fWqeYorAEJKP+9l/I+0sjEBgs0IVlYHRnCMOrjZQ8N?=
 =?us-ascii?Q?DKHgOYdhkkFgTiv0r1giC0TwHhnZHqi7WYsvJekp478OiW5uNzIGmuxDfyZX?=
 =?us-ascii?Q?wiKKxKvMqG/6blsyzKHqnfuaX/AKRT8Yh5Gcz/HHgMUBlYWA8o49HKvJ93AK?=
 =?us-ascii?Q?qAowolVApW21cDnM7uYXpTEKGfha1aU/WdHWS1KKZ8MKM6ckFqE4od+xtGyv?=
 =?us-ascii?Q?kquCKCw3kVOdrpvm68w7W+Yu5ei32R+R+8qrr4cBg0t6mobQRdVMBQCBACDl?=
 =?us-ascii?Q?7KSi9BIRYi2hCRr0UXNMdrIUdoSyXTKCx2zkNjiteDWIc5Kn1UHB53hLlrHE?=
 =?us-ascii?Q?dNzi4sy3T6DY/KmVtQwuk5guAhaNyFPWqFpjNpFFIUe24Z8GI28YfKMAbOyx?=
 =?us-ascii?Q?g8nWPUdSh7SLrb0w5bqzyphVYiy32yUqJ9F5xfie9sP/kLPAdxdpsIbWBPts?=
 =?us-ascii?Q?MREho2Up3DQZJ4h5O8KzfzGvvA6jzpeGakyA2Yxiz9W6ymCY0ntCrHzolPzg?=
 =?us-ascii?Q?kur7m+Hz4KnZqTdxDbO22mBNZzY2jznAsfK5d56n0VZDwhuTUYfWS1EEQPYV?=
 =?us-ascii?Q?Dm4Y3yf87VLZJED0Pmb7RGtdOEKW39pd1Q6Kl6QGz30ZICi4npFoV7WmqlOY?=
 =?us-ascii?Q?CvUtTQlQgHo9HFTjGUQyC2fp+dkbuFrzu1l8eqPesLUDkrQ87GyYCWJ3s6oj?=
 =?us-ascii?Q?/Kz2HXKURGmEHqCAnsMiWlbmkvWI2Gu7FqH4YgZ3YVIyXIz53qASdaBIOhv8?=
 =?us-ascii?Q?vQxYybuIEBRy6YKlM508w3pAlX4D6Lg/flecekg5cp7YiF+S/Eu88VGwbRO4?=
 =?us-ascii?Q?/xR9MKrk0JrBH4i61byYEPuI2YD5CdMS6YjC164n2ysObcE0PGGAC32HlDOq?=
 =?us-ascii?Q?YQPatnzEAq4QXDGXwnnRPJO2RyelJRa0rusAeOKfeHbEShBKGbaADi/eByBq?=
 =?us-ascii?Q?K5pFSa0TFsJkfI8H/X7k7INRz3t2dQuoDCUmTLlJN+pMa1H1C5B9oV+wU+4P?=
 =?us-ascii?Q?5KaK1232LHO7rb+GNqyfCXLZEERgVeGj6apMv1VtxWj4wcnIfcHFYarUnhpU?=
 =?us-ascii?Q?159qigSbqJydvqLtyUmFno7zFwGxOmk48pl8ULoAfGq+F20rDuVMPfhNTutH?=
 =?us-ascii?Q?3MduHe1SeHG/suZPvH1gdtH1fC929eZSDtdEId3hogGtnJZkPVH3tl1PzWgW?=
 =?us-ascii?Q?1cBNescg2/4u3P5cJE5XsqWKFjNfcwRBrm97pto3xNyod5XF+aoiEe9q+hHn?=
 =?us-ascii?Q?Ttwyww3QvaG8hudWS+M7VofCBULpY43AC+sbdzaP3m+vbIvU8MnOzOt52JFG?=
 =?us-ascii?Q?nwF8rPNYE4VANTR55t7b4pVwEwveHjQukt1iegFhlwPa3Azi+VO8LSQPN4Hv?=
 =?us-ascii?Q?1Je+2uP4MAWSSB0h5uANsOMjG5zMXK9LEOwVcYw5fYdAvkCzBGpC5sthzeQw?=
 =?us-ascii?Q?6msVPqkRsQZXRjKdSCDB7M8K9aBpH8T25R/Dum5vB/gbUhcjVfkSlfvywl8h?=
 =?us-ascii?Q?FyCYcKABxw1SEHIj/BllZkK+Kf8cCKEFpUm56mOWePKO/bGVVQsY2BtJJLMo?=
 =?us-ascii?Q?+/VAhgNKI9jFBzWRNRNtEw4xW/IwFue9lUiq1cqelBXaCxGw78EvIBjOL46Q?=
 =?us-ascii?Q?AZSkreRVufeOqIJJHP/2qJeCH+s93dZ2IliHolwD6UZ6pDbA4GwuMGTpTaEV?=
 =?us-ascii?Q?h3ZuM95KTu2kE8obqMlYE5dJw6qGLzw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 2FQMeHaCfR/kmLDhnI9t+bcyZ0huF/ZAzl0Anz6eRm7BV/ZnFUASywkB06geVGRifl32HPu9Q2ut9rGBVzKIA9uTlXbvdY4T5UTxEVApz+AbN0ryfo0ZLWv/Uokr0eJySv0jZxn/iXUzkX5UE9yNoK/F3u7vgcmwGkIxwoECExHJrtEAWOcM7i+Y/t9zBmL12Tik4U7WMv9punOuAD3dZW6spVuzSfybE9IAAdsQjNjG3LHB64T+eV0VkTmk6J+XRJuSWs1KIQazXcj081cQq35tgFLSEfH8o+cVTWO+/9QBF86eZ1dWU1rpWKmrG9kHIGN/kjTV2YDOqBeYQhCV8g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9caa150-b2ea-486c-052a-08df3aa1d53c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 18:31:25.0828 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wJSI/bFkVxu+EdRk2YJuThzuiZ4RPcndu6OWqX2DJEmx9VTNXyg2a/zo6mIREGkr+uwBlEBgmYruHiDm+Ln+aPOM2pzANVK1nuSI3p+d2kU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF179F31853
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> -----Original Message-----
> From: Emil Tantilov <emil.s.tantilov@intel.com>
> Sent: Wednesday, November 4, 2026 12:54 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Burra, Phani R <phani.r.burra@intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Hay, Joshua A <joshua.a.hay@intel.com>;
> horms@kernel.org; brianvv@google.com; decot@google.com
> Subject: [PATCH iwl-net v3 1/2] idpf: fix possible race on remove during
> a reset
>=20
> Reset and remove can race, leaving NAPI registered and enabled:
>=20
> modprobe idpf& sleep 1; ip link set eth0 up& rmmod idpf
>=20
>   WARNING: net/core/dev.c:7699 at __netif_napi_del_locked+0x11a/0x130,
> CPU#30: rmmod/22393
>   ...
>   RIP: 0010:__netif_napi_del_locked+0x11a/0x130
>   ...
>   Call Trace:
>   <TASK>
>   free_netdev+0x110/0x2a0
>   idpf_vport_dealloc+0x452/0x460 [idpf]
>   idpf_deinit_task+0x51/0x70 [idpf]
>   idpf_vc_core_deinit+0x32/0x170 [idpf]
>   idpf_remove+0x40/0x200 [idpf]
>   pci_device_remove+0x40/0xa0
>   device_release_driver_internal+0x1a9/0x210
>   driver_detach+0x4b/0x90
>   bus_remove_driver+0x70/0x100
>   pci_unregister_driver+0x2e/0xb0
>   __do_sys_delete_module.constprop.0+0x190/0x2e0
>   do_syscall_64+0xc8/0x6b0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   RIP: 0033:0x7fe628130beb
>=20
> Make sure to call idpf_vport_stop() in idpf_stop(), irrespective of the
> IDPF_REMOVE_IN_PROG state, to allow a reset racing with remove to tear
> down NAPI in idpf_detach_and_close(), which runs under RTNL lock.
>=20
> IDPF_VPORT_UP is modified under RTNL as idpf_vport_stop() and
> idpf_up_complete() either take the lock themselves or are reached from
> callbacks that do. Move the test inside the RTNL section so the test and
> the teardown are atomic with respect to a racing close, and assert the
> lock is held to keep the invariant documented and enforced.
>=20
> Fixes: 2e281e1155fc ("idpf: detach and close netdevs while handling a
> reset")
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_lib.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> index 2130bbef0c17..791ebff98507 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -1005,12 +1005,14 @@ static void idpf_vport_stop(struct idpf_vport
> *vport, bool rtnl)
>  	struct idpf_queue_id_reg_info *chunks;
>  	u32 vport_id =3D vport->vport_id;
>=20
> -	if (!test_bit(IDPF_VPORT_UP, np->state))
> -		return;
> -
>  	if (rtnl)
>  		rtnl_lock();
>=20
> +	/* IDPF_VPORT_UP should only be changed under RTNL */
> +	ASSERT_RTNL();
> +	if (!test_bit(IDPF_VPORT_UP, np->state))
> +		goto unlock;
> +
>  	netif_carrier_off(vport->netdev);
>  	netif_tx_disable(vport->netdev);
>=20
> @@ -1036,6 +1038,7 @@ static void idpf_vport_stop(struct idpf_vport
> *vport, bool rtnl)
>  	idpf_vport_intr_rel(rsrc);
>  	clear_bit(IDPF_VPORT_UP, np->state);
>=20
> +unlock:
>  	if (rtnl)
>  		rtnl_unlock();
>  }
> @@ -1052,12 +1055,8 @@ static void idpf_vport_stop(struct idpf_vport
> *vport, bool rtnl)
>   */
>  static int idpf_stop(struct net_device *netdev)  {
> -	struct idpf_netdev_priv *np =3D netdev_priv(netdev);
>  	struct idpf_vport *vport;
>=20
> -	if (test_bit(IDPF_REMOVE_IN_PROG, np->adapter->flags))
> -		return 0;
> -
>  	idpf_vport_ctrl_lock(netdev);
>  	vport =3D idpf_netdev_to_vport(netdev);
>=20
> --
> 2.37.3

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
