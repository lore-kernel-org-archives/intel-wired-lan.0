Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FE0606A326
	for <intel-wired-lan@archiver.kernel.org>; Sat,  7 Nov 2026 03:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=PonjuCHi;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gwABAzn/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB2C9606EB;
	Sat,  7 Nov 2026 03:36:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zG4Xw_ev5EPu; Sat,  7 Nov 2026 03:36:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 35D8C607AD
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794022575;
	b=VEDtTtwEnV5+z6EpIshaIRHIqvcJ3j8KzrwtRQsw/4iSqeGAh9oMCzlAXAevVx3Rsdc2
	 iQI0IbgR8DQ/xPdwQotElHDCxFUCvUXetK/53KG39SZIG/9W3xyTqAQehGS7KuNvzaLaF
	 m8S3Q5+AuTHMZFdH1q2jnkBVhlbBc4EqKJ3Yo82Bo5mUGdJIpRljZmqqNP/dBFCIlMFW/
	 w1LPwvK32J3MnUn3ojnhGPnbxWFHoihWEBuhGzzce+Bwm/OzeQb0TvK6cqiy+J3EDubs7
	 UevgiO/MU9nps1UXmzdpXYczJ4uWNIFQqPM7BBjf8RI5POtptrwDS7t1sZqAyu2prqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794022575;
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
	bh=2CpbTNRM1ZtGB/dG4Ye5Varhd41RPpMLPUnb3bS9DrE=;
	b=UzCfsMlJKwV92uFJd8XXBu8P5+UfHQQiqYhKuPoCAGG9JRDpIDNvJgwBn/6iVVtZhDf8
	 CyXJDkF79lE2tt5ig9DP2QmzCtDmJA+w0uLb0PqXeG834ZpDdTKOwu39FHqPwaGm5Hyij
	 Tj1G+Or6Mgc8oDIQhv7ggpDzxUXBxumOSK2a1vNG8jRcahMjWbVDoj3KiljaoRBP4+x9q
	 2ZvyfUV/ZNTr3NKPkXC/Ecx29CuWndT1E47ApqQMiR16/rbbxDFoE0K2kNfTOm0o7T06T
	 Pg2B7PjrpH2R16XbXNa01a1OstyXnadaJI+jXZVb6JdgyDk8RHUuM8hV0iKGDc078rQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794022575;
	bh=2CpbTNRM1ZtGB/dG4Ye5Varhd41RPpMLPUnb3bS9DrE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PonjuCHiqyX+JV56EEhHhGtwZGgDNM0B6iDX8CUnEFWJgmZhBUdaw6bqmX96K69Yl
	 znEAMyeDxJyug7Gmvm6UowCAYtRs65Vlq5GIaoXHp2hi2E6nCoOxKowzjIIbb1fW39
	 xEA4XVR76TxFIexx5tGhsopiz5qGCeFMSvhPZuEybWScs075kh8rNxuW+u3zAYgUx7
	 qYBpxFYad74WwrNPJSHVg1fKPdNJ8hwydqi1QXT6QM3fBi73VAolyH9ZV/hPW7BDMR
	 Z4fAfcsqE4z3ukhl3CcJcxIsZcebRFXLmbthSBhWiyXAwZfBXki998Uvm/CUf+xmTk
	 wcrvBGdfp3wfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35D8C607AD;
	Sat,  7 Nov 2026 03:36:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D7002AC
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 03:36:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7E7E64057D
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 03:36:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GD3RmxGG0vsk for <intel-wired-lan@lists.osuosl.org>;
 Sat,  7 Nov 2026 03:36:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C91D2404F9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=gwABAzn/
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C91D2404F9
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 03:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794022573; x=1825558573;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Ik4zZMOP3j80AROvClz0Ln76zfGp8Pme2ZgxnnLrIoI=;
 b=gwABAzn/XAHZZPoK9F0x2DOL9Co26HDCogCX4obCLGOYUGUKTurEAGzd
 YBJDb4ZS2vyDzte79ocm5oV5K3nmKyx4rsmaV5OFWcTcl+rUXy1/9XGAV
 o2LINbb+5hcWksQ3Gsyr6V7CbGtT2NQNNVrgffHhqrsCXY+VOlm6O11S7
 wfvPcVQGZEKFLGHRy4bcUD+avJGiD5lcXqODZz+YBkLdpZnzbqN+hOs/J
 Y4NMmYbhs8o8dIYLkCeaBmNpniJX0P2xqT5y1HFLk9y01WU76zTRZHtHn
 AqcgYdTLPiucrNrs5Hwlz57KjGjiPcQaObFFFXVucOw40aVisEV8crmHI A==;
X-CSE-ConnectionGUID: ydSdrwn6QcyrutefiurAHg==
X-CSE-MsgGUID: tW50svOdS2OLNE4/CZeW5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2828608"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2828608"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 19:36:11 -0800
X-CSE-ConnectionGUID: Ta4ImGlDRAKFjw1e2KEXQw==
X-CSE-MsgGUID: XSWdIRLnTuWYeHk0IFNzSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7869965"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 19:36:11 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 19:36:09 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 19:36:09 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.12) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 19:36:09 -0800
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by SA1PR11MB7039.namprd11.prod.outlook.com (2603:10b6:806:2b5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Sat, 7 Nov 2026
 03:36:00 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0592.007; Sat, 7 Nov 2026
 03:36:00 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>
CC: Simon Horman <horms@kernel.org>
Subject: RE: [PATCH iwl-next v2 3/4] ixgbe: limit ITR decrease in latency mode
 to prevent ACK overdrive
Thread-Topic: [PATCH iwl-next v2 3/4] ixgbe: limit ITR decrease in latency
 mode to prevent ACK overdrive
Thread-Index: AQHdVaDn3psJQbn5NkSSXl1eILDzNbciJtyQ
Date: Sat, 7 Nov 2026 03:35:59 +0000
Message-ID: <LV1PR11MB879057E92670DE2A6738389090752@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20261006144018.2885932-1-aleksandr.loktionov@intel.com>
 <20261006144018.2885932-4-aleksandr.loktionov@intel.com>
In-Reply-To: <20261006144018.2885932-4-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|SA1PR11MB7039:EE_
x-ms-office365-filtering-correlation-id: cb3c2a0d-1da4-4c28-7d82-08df3c803dc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|38070700021|261022075727099003|11063799006|56012099006|261026140227099003|261021121427099003|4143699003|261009223027099003|261026121527099003|261028144727099003|261022105027099003|261102123227099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: Y9+dQuhmr5POrgV6OxTzwcpYmF7OEYBz56RuP4UB+A5zQNLmUNFuIjhtTzKd95Bi2hQWJ5hxLYEDxgl1GQvFwW/un7T5tOLpu5rV/Rtr9Rp48Qcv+kw2/xutFxjToq4mSea97x3p9kxSW6VHEL0GUc27EXKp2FWDcvyMdU8ejKL7lH84L2Uanj0Sq04LACv52DFaiCse4PSaLPfn2lrJQ4T9dfzxa+o4jfUoj1YgJoR52qTZ63nejdgT30AkyWago2J+Y+lhCuSGC66r8kwKY7J8MXOCNq35zfrgk/ri7RiBY2AWZ8pOmTeYa5lCCxYzFZP6IX6uuuXBHvl4LGhdv/NEJqEvNZ2otiZ2MuZiyMWvwUiv/zyprHFX5wLgdPDeO7O9NIOgH5AVTJJbXuVvdUFkQYndgTDIZO3Mj+RLcmLhKmjbFhA3Fe+i7EmqWXAjwZSHmG5QIqKNn6isNCIEmo6iv381OFxjDBivMIKRKFrOd/s7oxhYKYIQzkQAYWzdl87LRrJ+C+dWNkSc3kYGO2d2tNZ5oIoyGmeOiGyqlmFr1dLdRfyyToKgZicBxbnXUO6S1Ca2oO0tdoznAhgDy6lftrEEvlJpnR67qW5Qc4DxfCQFkvYCZUOKl3ocS2VMLxIgIu4IRG7gVvO2TRfsCm2pj/9gTtiHYUtC+225Ev5PzpMOoifisbChOsDQ1A2NDWldh8W/jaHXR7Fzyf2xQyFwccegp1aXiEN6sAmD+3Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(261022075727099003)(11063799006)(56012099006)(261026140227099003)(261021121427099003)(4143699003)(261009223027099003)(261026121527099003)(261028144727099003)(261022105027099003)(261102123227099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Aijuf/52lG0QrA/IJ9Qi0AIBrUjhVde3Q1L9bvXqoOFmUhWBpykqbE0i/God?=
 =?us-ascii?Q?jPH1kgrLPaBQ5GwiQ/dNPQV68QPdOVmgQ4BSSRSCagDOZCnrxMJrNJVEq32V?=
 =?us-ascii?Q?Q20MooO+C9AvoM2Sv76hVAqwIUdXjZWLMUaiFnWJm0sdxAYe6dF+dxj2WwKC?=
 =?us-ascii?Q?HcHHRK/O41gvwgf8j01b18zHUIGIAu7e54cSSIpOlu7OEHBrGz9y8A2/Zrqa?=
 =?us-ascii?Q?ZEghwUova0rQ79XMObBqxBOfq6GZ6+ilwEzbJS1LLUDRjLtJbp8ECM8d2zMc?=
 =?us-ascii?Q?IpaK0c/7PVk9w/VfSvVVfYiaC/KbFR/A3MePmBK95cYMd980aMcx5zi/vWHC?=
 =?us-ascii?Q?riz1Gri/hiHG01EONtOlK1RbbSza5DuMX0x4Xc+MI3I6XhiSHdT/bxK3drNR?=
 =?us-ascii?Q?6rRb8008f0Ai4U1e4ihxcVXmkZYd+jEOZndeVpsu47LPC1xNPJIxWGG06EK/?=
 =?us-ascii?Q?xtlOLYZu/40aprDTA1AfeQfOnNXHRJO7BaOkSQnFLkBvzLmRaq1XNwmT3jvO?=
 =?us-ascii?Q?9Imc8t4v7+jZ5SdWOm40ADaZ9fKJIfeEZ+jmjo612062OAcpypQLazg7Vnet?=
 =?us-ascii?Q?5ZuXxv+9SHfbV3lfUY90YC2MgbYtehYC/udM8xgbZywyNPBw7mtAWuVSHayC?=
 =?us-ascii?Q?QIq6d8ANTmut584fC3TUHCUMEpvOENUx+YFoFmahPm0r55dZjVvnxW+ioPGE?=
 =?us-ascii?Q?iaOtvmYJqd+qweVmP+HsOtzyoj42RFX41oX1Z7llSYIj/chCd8jJbZglP1qN?=
 =?us-ascii?Q?7GNhQvt6vFC50OdwnWL+To2C2gx7KuUokGPLHJwILRtSjzFu7SFtL7NwVzDY?=
 =?us-ascii?Q?Nnj9u8sFbOoCitmEjTWi+0jyDxjLbZPWOEl1rFGx+CDuYkfKuyZoobTo0Hmm?=
 =?us-ascii?Q?mrDy4tf0fHG/gWxLQ1vOcHTlWhfXy4i2LuK2eE3Oy9H7JTs1J/lNKBerw6Yw?=
 =?us-ascii?Q?53MQ0leoW2D2DjoUBJPJoK+BcieYUhUNPO5CzfMFiL2Sy7WqX1W4tyL0PkAR?=
 =?us-ascii?Q?HdPGEBU5yDiSGT683PII6AxNXmzkbxar6YZdTo6SwcpDdsI8TFewNUofnrPQ?=
 =?us-ascii?Q?5xPeWGOKxpZNBWOnYaz6OjrA6B5rxWW3SAddN7G3npum+fuCpC5Gzv03t1Ff?=
 =?us-ascii?Q?P+8YTxssnkmjpMyzZX961OCMu8ZRI+8Lr3Wlr/qrgHy1lgyDDQtGL833XS3N?=
 =?us-ascii?Q?RPUqAZVDqNLZNv36d3GwfOW7oe7ibvs8N8ddoFG41X8vaxggWTf85KyEd211?=
 =?us-ascii?Q?ixCs6oKAdnavAm+2MQKtHkV0S3R0HRcudserFPsg/j0ci00UaIkVO1deosFq?=
 =?us-ascii?Q?qy86Bvmm8iBpwhfjeaUkJN8+74D88xysOGwcKmgkSLzKTGSrOI5YJd77a/4g?=
 =?us-ascii?Q?Nzl7leq757QAsUYxFq7+128x/b2GazB23Z4i1Temc3mr+MUwF84T1s58Zl4G?=
 =?us-ascii?Q?lptZfcWAo0LlmbVscbgrxVLvPjImJmEFAVfonCru5qVEwXngM9KHu90yJ7P5?=
 =?us-ascii?Q?48oTJqBBT4hJIgF/DT1W1sKDi3M+lWxQgFaG3vNoQm/6JVsO37RDcA3Vax6q?=
 =?us-ascii?Q?seLuW+tUKVQsJQhQBqkIqL/PXxaVJUZOu+dHKPn3cR83BWM5RtDQl63svPpd?=
 =?us-ascii?Q?CO4GMHY+Ody3YYROvDPkI7jY6flhSMUh5LX3sqkImALtEJy8txkM8jtFg+vJ?=
 =?us-ascii?Q?Q8p1urcvEXf1MynO4lsoESY5XvdzleV5bbwjKo6+CjnvGempb07zbDG/I+zG?=
 =?us-ascii?Q?j0VoaH6h5Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: l1GOtyL7HibZASY59D7txRa1QD0w6ptNGte5fVCCaoj88vonhUspDI9fB5EkDywiFKlN5fPdxG02BcUH9ToVCCw22eTjCoxGv7j1s+3XkulTJ4+4ecLikqcafNZH5VB/Xm3Jowb1MlToWIVHqHrWLFd8J8tkMXtjBVi4BirhZCFO8GqR0K8AF65Zu8TYYUMnLDZj8qARL9e+NUppYIY1wW7/IhDa3JI5mEdjfaNW9WInmbVZ9OT7MJHJefJ75+UDGjW791IoNkrC/E30FkWy6Us3mfAqq9TgNXJDK6TbpeRLp2NvujPA9YEXapFDdtuZ1fNd4t1FGybf+AzWJkQm0A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3c2a0d-1da4-4c28-7d82-08df3c803dc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2026 03:35:59.9890 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MOSNvXVglx3SXaTbiMth6tS5lkt8n3s6iMsAjpmxMcqIQtgmj+Q1Oq5Zi+RyuX+8nQb3VNuAt4a6TQaxpFFG+FgzeECnRRpN0yQedETcgQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7039
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> -----Original Message-----
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>=20
> Sent: Tuesday, October 6, 2026 7:40 AM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: Simon Horman <horms@kernel.org>
> Subject: [PATCH iwl-next v2 3/4] ixgbe: limit ITR decrease in latency mod=
e to prevent ACK overdrive
>=20
> From: Alexander Duyck <alexander.h.duyck@intel.com>
>=20
> When operating in latency mode and the computed ITR is lower than the cur=
rent setting, the algorithm can reduce the interrupt rate too aggressively =
in a single step.  For a TCP workload this means the ACK stream (a latency-=
sensitive, low-packet-rate workload) can drive the moderation down to very =
high interrupt rates, starving CPU time from the sender side.
>=20
> After the speed-based ITR calculation is complete, check whether the resu=
lt is in latency mode and would decrease below the current setting.
> If so, limit the decrease to at most IXGBE_ITR_ADAPTIVE_MIN_INC (2 us) pe=
r update.  This ensures the number of interrupts grows by no more than 2x p=
er adjustment step for latency-class workloads, dialling in > smoothly rath=
er than overshooting.
>=20
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
