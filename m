Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0631606A326
	for <intel-wired-lan@archiver.kernel.org>; Sat,  7 Nov 2026 03:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=l15fmWsd;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KdWW5CNp
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3CD74094E;
	Sat,  7 Nov 2026 03:35:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hfxxiadEXDIG; Sat,  7 Nov 2026 03:35:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EB24F40966
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794022544;
	b=dNHzSTnIvTTWhjbTPt3tIs6yeVdDVkKx5lWhY5WEUxgY+4CPS70LFSAG7wXvdU4jPTuS
	 8FESahpNatIf4jo/0g2GwJpHgbEHagrkXB5XbT3GXteEF4GRUKfMkchPt0o6upp1eGmy0
	 VpHVMuolwIOl0iqsU96SseTjWBBfbS2bULmcgLfRMCi5lFwPdg3Xgj5mnJ0PVxwv3tnmh
	 ahjMxXJfi4rCZAs27+UzTZNPo7XhoyYNS8loLcyFHM9aZj97A3Ryl2h6UOzb+iJSa4S1P
	 hGdqP6chu3MjPpQ6JJIYQ8ymcvQUCZdE8Yv+I/8wrmuZt8N3uo/o2/yK6sCn8qlyQmg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794022544;
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
	bh=khnHJMB2EHF1lAq5AksqFxuSzFGC5b6Tl5sQHNWNp5c=;
	b=qd0+j80tD9kGBYel7J5oyPwcZPshEmh8qgwLBSnra5dMBvG5CI4HvDuM0z0VLJsKRHOR
	 mOjv+WsgRSaSVLDqZ/rQ47FnWxRKZxC2oQqPfxr7tyaFqNgV+dZt+iUZkB7i5rnr86cQ4
	 9kmpvA+1zlmn0rkp4uKHhTRrO9wPvdqH6PLBXh6h1GGxH4Cw2rQ/CN1nBXmIJhBlAoWIz
	 LDXbvTCj7DqxJvB9OZIxcWVzCeAQcN1+R0LIo2qC+64ToJFeTiJaNIffOApWKMpSmn5OM
	 TfTVvnyiY7sLBKXcJtD32nL07hF9mQ7cKx4pf6Rcgs+Lj1EUzdS9UEKbaOj4Bql1BOg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KdWW5CNp;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794022544;
	bh=khnHJMB2EHF1lAq5AksqFxuSzFGC5b6Tl5sQHNWNp5c=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l15fmWsdzYz2vRLGLnsfUf+dBLpE84uaZL+Y95lL6P1Iq25a6S0LeQgsfW8ZJPvfU
	 10VIJGeOpLhNhNbwCZ0Whr1EqQG5R5WfM6+Sfpj1gtcF7Z9/UO2nfAmtJIAtQRkD3n
	 CBnt0+Y0t7GXSZN2/iVxRcg4NDWovVUZXcwrwMowSJv+MhEQ2z/a0kFth97g/Ye1GY
	 dPpxAbrgm8NaiGOiNUPLcUv40+kGS8lsCtxwLr8u71VHt0JMimySlxGtSjNYSJod1Z
	 vAso+IJQ8wSd1M2tydWnCf5IPjGXNLSA5Qjyu6seiGw+5pW06YsD7RNlR/s9otuvol
	 Khubtter/n4ew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EB24F40966;
	Sat,  7 Nov 2026 03:35:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 65DA534D
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 03:35:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 62F7040966
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 03:35:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DhIyKbnJh_AM for <intel-wired-lan@lists.osuosl.org>;
 Sat,  7 Nov 2026 03:35:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5D55E4094E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KdWW5CNp
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5D55E4094E
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 03:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794022539; x=1825558539;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rXmCPuqdAQ6GtXwNfnI9vR10+RFHpT+rwvlUHpVHb4c=;
 b=KdWW5CNpdQiUlEgpEHZf8FIqiouCaLZq8PGfWlePGBMaMJwHcU8iqY7w
 UxKegOvLjJOM4Ji3d+NF6B069EO3uRlKA4Qof8nTb7Od9zR8kMpJ+wpsZ
 RPzWZ9UL56baiEnZlptr8ek8lkgWlvUvSylkIbqrV78rJXwAeFSfXUMeR
 viAUQWxn80vg0e21w3pEOcxYr7FPz1VhZ2tS449PtbR8y/92vKyIk/Xdj
 7AWR214Qk4BZbFVY/H0gLEn2vflhaaetNcB53YowyAorMMYYSm6MlIEcp
 Qy+sPtNdIIXtgdpj5kggXNzkG5O++HYd7G7rt1yitQ8Ux1UKpctm8AR4K w==;
X-CSE-ConnectionGUID: QpRnUw1sS3GhsZiN6MI0YA==
X-CSE-MsgGUID: CJRCKUB0TvSiy9h9LXEYSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2738625"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2738625"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 19:35:38 -0800
X-CSE-ConnectionGUID: cQRI3oQFRZGz2/xw6o35KA==
X-CSE-MsgGUID: b5wUCHSkS4qLdQNtAs2XTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7254994"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 19:35:39 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 19:35:37 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 19:35:37 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.35) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 19:35:37 -0800
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by MW3PR11MB4746.namprd11.prod.outlook.com (2603:10b6:303:5f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 03:35:35 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0592.007; Sat, 7 Nov 2026
 03:35:35 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>
CC: Simon Horman <horms@kernel.org>
Subject: RE: [PATCH iwl-next v2 2/4] ixgbe: add ixgbe_container_is_rx() helper
 and refine RX adaptive ITR
Thread-Topic: [PATCH iwl-next v2 2/4] ixgbe: add ixgbe_container_is_rx()
 helper and refine RX adaptive ITR
Thread-Index: AQHdVaDkWQ0QhHDopkmxQng7sIsPY7ciJrNQ
Date: Sat, 7 Nov 2026 03:35:35 +0000
Message-ID: <LV1PR11MB87902B3C68686D07981B9E2090752@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20261006144018.2885932-1-aleksandr.loktionov@intel.com>
 <20261006144018.2885932-3-aleksandr.loktionov@intel.com>
In-Reply-To: <20261006144018.2885932-3-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|MW3PR11MB4746:EE_
x-ms-office365-filtering-correlation-id: 17d84cd1-d149-4adb-3837-08df3c802f18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|261021121427099003|261022075727099003|261028144727099003|261021123027099003|261022105027099003|261102123227099003|261009223027099003|261026140227099003|10067099003|4143699003|11063799006|18002099003|38070700021|22082099003|56012099006;
x-microsoft-antispam-message-info: kfKpxREpNvMFBWyFy2ZCttVSfSK77uWcLdU0FEtDoOvRjGh681e22IlygGVUzjPNv2BrxRLmCSF+sHM04M60UJFzo0+LT/thaBcHspkOeXyySj5q1NwcTg8Hm97l6T8orBS+B2lRk9ZqQoz5z5eQn0Cqp9besmdL56FECVvIRRoiDkAYyzcCYsCNYTtzPG+CHxH0iljeQ6xUCZoBMNMS8BbekUCcjIDTxqD3N+MdXzqfonpx9VKAJB1mSadwa/xhSR70z3y0JXkRsqeIgq9A/iuP7haVAQkBWsxXeXc0rh6C1x2Gz1I540Fa/U8Z0Fd1XLpUfuR0VBy1MWoaRLNwledQ2WFJ+kPa8IbPVRJtymivjt9DmzLALDrozjMpId5Z2w3BUFHFjsZWexPCYoeRuceLhLVTFvkekXm4MWkN5CnC8kMKOZTHxWjPx6MhUc9YQXLkgAqJoT7VnKaRKyARS7sqPsl3waeLitSgFaKtvSfdK+/x+wSg+AfcToZH0iNFtjCe7E0qp1/8MkL0rlkoPgJvr6BUSrUyCE7sMQXWzCTqixfUSP2kxsLtD6PM3nY5aLlv3zAu9eUZaD7UHToBZnu5z+t/FGR8CIkeORL69vG8GFMfG/TkAgwOgh+yPd1Vt+ZZtbo4w8C4H+OQ0q8gN70Le7Kp8rSZopYfj/4hLzsK7bT2bsDD4LvBY0KUa+UxbFfJ5cvXj28G4oxdj/PgPCnR7zdK3UzuHQ7HLYP7dwc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(261021121427099003)(261022075727099003)(261028144727099003)(261021123027099003)(261022105027099003)(261102123227099003)(261009223027099003)(261026140227099003)(10067099003)(4143699003)(11063799006)(18002099003)(38070700021)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zbhIScpUkJmXM69xt+lZ3jNxvIzR9JiIvzyiY+duNL58oteA2CKcRgzRm/bG?=
 =?us-ascii?Q?hUmSaJtDw8ZRTkRTs1ennWf2uajsfQzGOiiTY3ryHGCKwWs3JFohwuHIwIrB?=
 =?us-ascii?Q?2KRZ6PQWLYSIBxmqLViFAvW+9H//c+89rJ3NnYrHLz/Xgk63LXastfg69FnI?=
 =?us-ascii?Q?+0hYpkgtPKjXeOUyZaSfkPEkABwrpEYWy5bEaX687E2jDzYd7K2iVqh6Zno8?=
 =?us-ascii?Q?RAiGW/Y0v4byLXTBw1vVsY1JGTJFOasY/NkAH6p184mdX57WbfXAAQmYpDYN?=
 =?us-ascii?Q?1O6EZXDtZdnzYPkxDMyoCQcNgjwFeyzJYdn8XI5DeIioEnSVQxvuJPnUO249?=
 =?us-ascii?Q?GFfsb2NLua+yqj1zdQfHpEysUVdF9CFTbWXV2iRs8fZ6oBYAazDPYGrnupm+?=
 =?us-ascii?Q?sD0Bq+b3EGvzLjZotOgG3PmZ2PLqpRDZRxG3lKJ3dPE0ik1byTVdgqMpBtIC?=
 =?us-ascii?Q?4eQNitCYUNkQuKyUVlCcG6Kqy8GL+9VifzxBIsubiMgZ0AAZpa3JlPKSmQZl?=
 =?us-ascii?Q?CdGI5mf0TCzlm4gqiZfi/fRIph0m5PjbjuPFrLHUE/LqJIkbH+pv+WChCclI?=
 =?us-ascii?Q?O1HhJFfITGr5aoqSERCUEydDoU0+AXS0+sjpCSZgMnrw5tqn9F3cL8KJ/RUT?=
 =?us-ascii?Q?fP870yFmfl+mwMUGXJ8waVwCvSot6ZyXEU8mi3yNBsj5UJRB+8amgzX0yCAw?=
 =?us-ascii?Q?e8qUvBXed5AhDBJDH1pPTRM4eCDpv4ejOlYJbmO7usnskMEX75Le+hCpRQ/p?=
 =?us-ascii?Q?U3i64FKglIglRIuwZsSm55KiS1MsCsyN4U5nrWnHzcyFFPg8zoUBf1XMS0pj?=
 =?us-ascii?Q?D+MfHKDty9UAZIrhDlw1++Z32rkndegXe9lzOi3tMI95vfF2J0Lnjx35sU8l?=
 =?us-ascii?Q?KYN7dpgmx03zPtFGuni+F9r1xNGmmvL0crBDbkupLPqxWeQP0bDP2CN/IRKf?=
 =?us-ascii?Q?VFQgxlF1D1PUdglpSu+yxkVfDSRLb7tCB+5sjK40kuCHf0r72Qh10/Nc5LFY?=
 =?us-ascii?Q?qz0YmW+6B3VElydm7f6rEW5Z8aEroCoEduuqye4XbqCTqV73PH0M7/H4OrSz?=
 =?us-ascii?Q?Z8ZIoRD8jAmBokLsimL74EcCeVG8RMcu5i4eOErjHsBd6Da//W63qNnFYKDl?=
 =?us-ascii?Q?L7LjJW9pO4V8fXuvVx6idyUqJdPa9XGcBHN6ekUhXJOI/ldaPQrwwWX7wGPD?=
 =?us-ascii?Q?psYSPmQlQ9DY+EZzMfXu2q3bBQjVTXrUFHbvZ8JdBuLLJxjXKPKrXqmJGbJ7?=
 =?us-ascii?Q?00KyiMg3jLQQzhE9avr4azGWLhDVXhGOh0pkuhAN6n8twkeHhZsuqKzW4g9b?=
 =?us-ascii?Q?xIs6RDZwr/wQ3Wn3sJUj8hMJ0hM6RyZ4fpC7a9qT27HpVSOkIAiQuc6zVe2A?=
 =?us-ascii?Q?6th3+zXBxU5cvivweAxLHwJFuhit1RxYgbjBnDP3pOoKAjyjzoxaGuOuSNlu?=
 =?us-ascii?Q?BqDuAWriJEimlKkPiW7n6d34VHFVhnOGvFeWnEMgnULJ3osUg66belsw3V/Q?=
 =?us-ascii?Q?3ovDWmOU8IeH5cgiLiqXLdMBWRJis68YO9p7mfMUNT0ZCdU0b33JF5dMiSbp?=
 =?us-ascii?Q?8FR2G7xol0BFsSCBJFsLEdp5qeptiBOgn014qFzenucw2Chxtn7nBUCFdbAW?=
 =?us-ascii?Q?uV26sGQhAteXsb+BiMCoUTovtMcvTg+Y4yc772IsJdVfXIrGij+kgp/jK477?=
 =?us-ascii?Q?ehA/cGwsj+lUe/tgmgQQPX8GUoNkpihc/54hCV2yUlv0lwBE0bTx16O+5O74?=
 =?us-ascii?Q?CO8niPOmUA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: o9j0D5QnwXX4HoUoftx0nGV5ToprJ4aDq3l1uXrrdUnCfdCbucHvrKMSoFIrhmjLjIxcd/3htUj3kEjyRAL2r23V3TIqtK6WSYUvYCGiYm1Q+CXOn0idGtzRTGr4oTausyQsww3ICkylNM3DMpX3UbEw2APp7NWkRmlW1hap+MrOQWZ4GkMT0rNvHlnmBSGJuUdr/zgYpVjjT/VKjwCE5l8AfSGoPMjMBWCwhnvlgBPaj7RHj1Duo9sIByVEJ85GRLgK95sEV/M+azWa9rS4AcMn7l5KQP9dG9CV5wRchxhx01gAVxMUQuxSQCiosemDGtvuNK+ixsx1w1Ybx4oYHg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d84cd1-d149-4adb-3837-08df3c802f18
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2026 03:35:35.3444 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ul3HCtLY/2S772rm7tqfR2YHaSVTjq2FGJLjvbaDrW3It6t7Z3/H/NGcdhwUjjCknMSApnzhX+oLNfimIZ+dROrzS+Yvoxc8KKrEiN25ZSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4746
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> -----Original Message-----
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>=20
> Sent: Tuesday, October 6, 2026 7:40 AM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: Simon Horman <horms@kernel.org>
> Subject: [PATCH iwl-next v2 2/4] ixgbe: add ixgbe_container_is_rx() helpe=
r and refine RX adaptive ITR
>=20
> From: Alexander Duyck <alexander.h.duyck@intel.com>
>=20
> Add an ixgbe_container_is_rx() helper to cleanly distinguish RX from TX r=
ing containers inside ixgbe_update_itr().
>=20
> Refine the RX-specific latency-detection path:
>=20
>  - Replace the shared "packets < 4 or bytes < 9000" threshold with an
>    RX-specific check of "1..23 packets and bytes < 12112".  When that
>    condition holds, target 8x the observed byte count in the next
>    interval by computing avg_wire_size =3D (bytes + packets * 24) * 2,
>    clamped to [2560, 12800], and jumping directly to the speed-based
>    ITR calculation.  This provides finer-grained control over low-rate
>    RX latency workloads without affecting TX.
>=20
>  - Remove the separate "no packets" special-case block.  When packets
>    is 0 it falls into the "< 48" branch.  The mode-tracking logic in
>    that branch is extended: fewer than 8 packets forces latency mode;
>    8..47 packets preserves the current mode.  This replaces the old
>    unconditional "add LATENCY flag from ring_container->itr" carried
>    over from the removed block.
>=20
>  - Remove the adjust_by_size label and the associated "halve
>    avg_wire_size in latency mode" step.  The Rx latency path now
>    pre-calculates avg_wire_size independently and the bulk path no
>    longer needs the halving to compensate for incorrect thresholds.
>    Rename the jump target to adjust_for_speed to reflect its purpose.
>=20
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 67 ++++++++++---------
>  1 file changed, 35 insertions(+), 32 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
