Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD459606A334
	for <intel-wired-lan@archiver.kernel.org>; Sat,  7 Nov 2026 03:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=KfRGOsMZ;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Mni7ONoI
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B4BBC608A5;
	Sat,  7 Nov 2026 03:35:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1HuMTyIdS8D6; Sat,  7 Nov 2026 03:35:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 18492607AD
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794022509;
	b=Yu4sCNYH80e9TLn5v4YBJK5OljvzQqvX+QwOKyGcnNzyvXrqhsu+laYow6cX4nehnuUW
	 TWwxKID6WGH0VMeSAfBwyDD57hbdXyJHkLVhc53h0kQs2WnAopXJnX294cYsqU2JoNh3d
	 oRhMJXRFx95Kgolsj9vDieNi2xNQfl1JeBeJk4N+ncY2flPuDADCiuf8Fx78TDZbBg9mK
	 jkHjiLV2UPuobluGYwGKQ5oKx8p+M++5JNVkm0n8T+I17yNyrKcPU9llp1RjY/BnK6m2V
	 aXWjHLuhnYCMd0GDuonfxHhw+zQTFhV0u4WELaoi62WBci6gqjQmeu0fBBVSc80PqPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794022509;
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
	bh=fRr1ge59r9tuy4T/+ODEnrMD+kPQIciNNaN3IAKbTCA=;
	b=UMQU6zHuVw82ZeibCNrKwvKKr2paURY7u5kbNwhiR/qK+geEOXjUJuReEDAfQPYcl8b5
	 c5m3wY0rchCn+OdOto5yiZmiE/nL2MoJswiMSaJfd2F1/0YO3bmt/uMOa/tmUg5ili7vk
	 vSwS3VEvk6N/cWW41hAE87eZplz+sQrbpJlSKuUN5steffz8h1jp4Y7tm8/tVak9Xd39T
	 R86Iwx0KeaI2koznAEBIL8D1/xZ9Q9QPmDSWnKpp8QCAUpLJxMmUeEpK6UmxwTwOF1pGa
	 l+0nyyDYGomH6BPSoMfwZH2AydG4+BEtyHj60tDmeDLK6LmYNv7GXYX21466bJtXP/g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Mni7ONoI;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794022509;
	bh=fRr1ge59r9tuy4T/+ODEnrMD+kPQIciNNaN3IAKbTCA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KfRGOsMZKH5W4uv4ceC/JDb1lR0AvPJimi2TefqP5NaP7g3WTRRbHKEgtXxlFpDl/
	 eyLar2yWmqsxVRaSPZijjuZhpNPAk4KNU9cJyYaPN4qRHQllyNn0j2Ok94W55321iC
	 5jTtnsnatSSpgga1T2rNV2IOeuw/1IduI2PPlbEKUwwBvLuvYjmksLKijDdjWCQ2ut
	 tn3VM5Q/Q0ROSC7bInDjCNaFNvvlTB6EOF8gYWfXSgVUAYBPXmof6MtspRLlFnYxJW
	 mBaf9W17fbWhV+IdjHFIy8wtx1gJ6cjNBSyH+F46T78kPODerjuz67te5fq8QvSJBL
	 ZhwRbxBlQoFRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18492607AD;
	Sat,  7 Nov 2026 03:35:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8217734D
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 03:35:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 67AD7607AD
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 03:35:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id We713KsvTOU3 for <intel-wired-lan@lists.osuosl.org>;
 Sat,  7 Nov 2026 03:35:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7D714606EB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Mni7ONoI
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7D714606EB
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 03:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794022506; x=1825558506;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1SVxEKrDNaIM6cJZiJGNlQVQQji+YAl7+pgEM5vkEh4=;
 b=Mni7ONoIz7eHveqeW+nSNqft6rOxSsLDYmFBW++T1TrgCXF6vZ+ZCeR8
 NlNObK39NfjxIAvHp2lfzB4/rzxPaKgvwqs8XDn4RANv5lV/pC0yGr741
 4fNBowuEtb3PnynFyYoS1TXP3JhcuPn6JOQxGh+grKQlS+5NgBUri7cG2
 Gp1DesOUN3X1lfuDbwaH5xZkBmOBO81qby0RjvBqnN1MoHbesm8hzgFjC
 /3TJEkvkugeUh1MPKYwPSuBjP+KAjtjQPXxNoSNNW/cNLAMof9jCkRG9h
 cICssqVMS2x1SiF8/xg+SvtqJqAL2AUG8aHI0N3Ztct9zaE8JVjajYp3l A==;
X-CSE-ConnectionGUID: AOA/80xZSaOyRgn0ksRb5Q==
X-CSE-MsgGUID: sQXnjAwoTEu6ELTSGuwBPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2828586"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2828586"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 19:35:05 -0800
X-CSE-ConnectionGUID: 2bq96DrMR7SnFX79z1Pgbg==
X-CSE-MsgGUID: yIw42QIHS4+vKuCvS02bsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7776744"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 19:35:06 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 19:35:05 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 19:35:05 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.18) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 19:35:04 -0800
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by MW3PR11MB4746.namprd11.prod.outlook.com (2603:10b6:303:5f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 03:35:01 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0592.007; Sat, 7 Nov 2026
 03:35:01 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>
CC: Simon Horman <horms@kernel.org>
Subject: RE: [PATCH iwl-next v2 1/4] ixgbe: lower IXGBE_ITR_ADAPTIVE_MAX_USECS
 to prevent RX starvation
Thread-Topic: [PATCH iwl-next v2 1/4] ixgbe: lower
 IXGBE_ITR_ADAPTIVE_MAX_USECS to prevent RX starvation
Thread-Index: AQHdVaDlb0ltNEZBo0em0+h2Qa5FsrciJo7g
Date: Sat, 7 Nov 2026 03:35:01 +0000
Message-ID: <LV1PR11MB87902D02EC1D3565635B21C890752@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20261006144018.2885932-1-aleksandr.loktionov@intel.com>
 <20261006144018.2885932-2-aleksandr.loktionov@intel.com>
In-Reply-To: <20261006144018.2885932-2-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|MW3PR11MB4746:EE_
x-ms-office365-filtering-correlation-id: ebd3c4b5-6b5a-4c83-2b2f-08df3c801acf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|261021121427099003|261022075727099003|261028144727099003|261021123027099003|261022105027099003|261102123227099003|261009223027099003|261026140227099003|10067099003|4143699003|11063799006|18002099003|38070700021|22082099003|56012099006;
x-microsoft-antispam-message-info: KiaV3PG2D7MD2ukRAQDGlTDa7JDnqGlM86q/rR5L3XmUmY0UlgB8g3EHzqVK48fXnuRoGVCGCX7Ln6DKEGDrTAlOcSoYcNJ6sujfzxq608Ewh+Wlk/HfDubAdp0XEHC6LvT2DBu+U38l+X8lctBn7zUsxbbkssnCuuJEtvvsqzqAYE23VS4glkGs1RdpqsIPg7nbF5FrU+28dBeD5AaOmn6G2+0/BPo1FyjuLbfJ8Y/wFdU3ouGrFvT0Wz2VwIj7zZnpH8HGw7QimrdTyoA4iRLha6WzvtM2f6QQtgEhFr+MNtsslrIa9xcpvL05MV6aLtf97LV0Ay9xJum5hgngjrVFvG4u8VWsOa5Hql337ZpaqCfYw3dc9o2QSCQGpVbpL6deLeSM0jYCVW5KKszYOGzEjVkcKWsy8gAGkSHDUrBRVSXrotbApRyONS0jACD4fPdpdcqEikkP4uWDbrK9H9Qs3wdF2p3urMDUSk28QKHw5op5rIu2djJoXerO2sGL5oieY+r0Hre0N48qWddXUVYPfPqQfRyMxw529ch0loNpLs5EZW6sZBy8nUQtz0b3WT5BdrKTDbjRJhV9TgC/UDUlsuKJBWsY3XrPp61r0Mbz/zXJQIMnyAJx6PT4NJ5ifACb/xhp7ezniEAka/3qdiu2d5sBrrApbp89KW2AEfSi66qZS+2nBwa9OWyVtqPQns5JpXqwE3Kz4H7DM7N4NRZ5I+vGW9VihHFuqQwYbl8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(261021121427099003)(261022075727099003)(261028144727099003)(261021123027099003)(261022105027099003)(261102123227099003)(261009223027099003)(261026140227099003)(10067099003)(4143699003)(11063799006)(18002099003)(38070700021)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HuBA+RqFmHck/WrIloMKvdQurig43m7Onyn9utklL3E2mls6k3toy4sDYwym?=
 =?us-ascii?Q?Vgf2bQEcMMhfFHh7R9hgHCntd5c+hcfNN14K1FwRI/U6Nkb8Yfpwlf9SOCfi?=
 =?us-ascii?Q?ALpjGlC0eycGOQCzELMmC7caue+X+YwouYUMcjEg5PebXqWMNGQuoK0/OVju?=
 =?us-ascii?Q?R/U0yD7q/aem0R/JczBWTDWXEKEOTZzfCWes/QhkY+pBkAV824z706xfOIsS?=
 =?us-ascii?Q?LopoLMAJLcdmNTRc7VJafl+xGsAKhZtiWI9w1hacv0B/CXBsUv5feeKiVTw1?=
 =?us-ascii?Q?uTx5HMiHEno6CiRxEhGswYQxJp6tLbUAtKIFE/T5Smoi0AQElHtRJOjG5vmE?=
 =?us-ascii?Q?oVktBIU9aWMwqa5M4ZCSe6JMr9AwLkkPDib4C2u8BIp2tuJtJI4YZ3+hKaTl?=
 =?us-ascii?Q?zyjGktz3jwJ5cFZgnrcDpjrb9/+8D7UDPogpBOH7cdrYaURNKcGVGcHS0+gr?=
 =?us-ascii?Q?RIMe7ddFeLa8CCodaL7j1Nci2u7ChU+QJ9502FOIMKfwQhdinV2lbExZZSXu?=
 =?us-ascii?Q?vCbWYPAzR9yZ7ltM87HU9QS1Yi/CXLI6hZKpH3vGvbmgN/zpUw3KzzklXo0p?=
 =?us-ascii?Q?1x/VWt7WKXUs30pHOrTslFQPsh8xLFq8VFONX4v5nBAXGKErYzw/J53oFNJv?=
 =?us-ascii?Q?FVbrCX4iGkNtv8cLHcT9eSbOfTIoGNS3fsjyKHCFjwRSlmU8g8gFXmXTOq0S?=
 =?us-ascii?Q?CoAdSmsYlH58yTPbuf/RKmQkVOZcQp5xQHItldMOWHwEVFS5QyAlqkkUZRVC?=
 =?us-ascii?Q?gHQ62aULqebqxm3CB2CI0V+uoPp82L5EaCVF0xGVhWrc7ZuM2jPSF2imo+fa?=
 =?us-ascii?Q?QDZT3Dve+EjazdEdYMeKtEwrHmsYVK3KHHswyR30Hm7jTUWzq5tZUQHEucgy?=
 =?us-ascii?Q?QD9mqt40pXS8fROZ3IxmQ4KoT2ktTeLEQbfSd121vcVzyID7U053kHooaTuB?=
 =?us-ascii?Q?Yr2LGt99YJhAhU4AkgDcVtS0Ncg4inDvu9L6GXC5h1rq1kfTzkWkHa+BNQUP?=
 =?us-ascii?Q?bA+EYwngFs0K/RaFwDsaBwCJWS9HKPeGqMOyMHpyM4ggN/C8DCMqLPPB+CwO?=
 =?us-ascii?Q?0sD4vdisTi5cyxc9T1zpTJTIrktmgekbCNdceRFHsYjsqid6/ExE3ZlDHqkt?=
 =?us-ascii?Q?HhfcExFbalPZQ+GoJIjW6eMN7tNescJWkUX/cb0e24dfJm+lcbT6RSIUdPjk?=
 =?us-ascii?Q?WBRG16CFMctfzyuBI5/7uuyPcs1OwCaV6uWXlIujdP2qv98oH6yp/CMO4QtG?=
 =?us-ascii?Q?u6Q+37T5J6fCKosOJ6aTIGI1d95CDcuFYBkudEzepS2z9OLdZndlHTdHA7Ti?=
 =?us-ascii?Q?JnfdqhnYs7Sw7vmahI7UocpQJCc1E7Okujheo7xVShO8/1OEDzVj2lknr6PO?=
 =?us-ascii?Q?nAiyQrXtdWkuPgTfFlHeSB5cgf33mOm29tcIxcAmz3fx8UkTgRebJUKtsQSD?=
 =?us-ascii?Q?y9Tg6cBPgSxYcNYvqB/iRQMduinK3uWkpfc63Kk/7ERnilKdSfYTyewE9O+e?=
 =?us-ascii?Q?12y1V0lb0M9JOn2tAHZNxZ01VTVAev7D7vMuWHIWHdyJJKv8QIywOXqY9RRp?=
 =?us-ascii?Q?Xj/Ew77xivQYiv/rf4tRBSWI7ICsHlTGKWFziZeHpRXIOqiQ849fUYJ92b31?=
 =?us-ascii?Q?Zmr3/M7igEJU7Sk1QwO1ppJmB5l57KuZ1to3zGPun1zJMpD6jdxklwHAjuDo?=
 =?us-ascii?Q?SFMRSM4xZ+zITgM01xkYOOHC0orp813kxSbDQKJ39XDEQOVmS43iEI+U/Xji?=
 =?us-ascii?Q?noKavY+dJQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: m23QVTo9Fbc1W9mD/HgVjtKROJPh33Ze6cSvZPHG5/Xv1p+yPlbY8JRLLiPmx8V9bboVesmJmv8M52XOCrXIVv6Meq1wobHCxc9boyc4MV0qGuvBGKKNLHeZIi7NgiEUf675wGkTJZJirlbN1saFrjh6iseeYiwAifYnACFThNr5XpntM0GsijmXbgFU9jRcrIYPA0xqjVEVfCCSE3zF7dsHU58tS2dhXLtAf92n6ngSFvo/cqxTbocvzpV/tJ+y8irTyP6hB1fjZHCwQ/diz7LUg1S7LfkVWsJLbWBfo4aPSsMY1nSrSTo4jBsjIlsAn8W/U0tzYXIq/T1LyTnyvw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd3c4b5-6b5a-4c83-2b2f-08df3c801acf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2026 03:35:01.2578 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: apgoAAVcuGvALndRLkKBmOWl77h2TVn3xCgvRHAa/P/1YVlt+UiMcECyWTS7O5shbdaViEpZRnMusfb7mb+ft/2LjQ5OLqVlHkz8hI7aZ5Y=
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
> Subject: [PATCH iwl-next v2 1/4] ixgbe: lower IXGBE_ITR_ADAPTIVE_MAX_USEC=
S to prevent RX starvation
>=20
> From: Alexander Duyck <alexander.h.duyck@intel.com>
>=20
> At the current maximum of 126 us the minimum bulk-mode interrupt rate is =
~7936 interrupts/s.  Under sustained full-line-rate bulk RX traffic this is=
 low enough that descriptor ring starvation can occur before the next inter=
rupt fires.
>=20
> Lower IXGBE_ITR_ADAPTIVE_MAX_USECS from 126 to 84 us.  This raises the mi=
nimum rate to ~11905 interrupts/s (~12K ints/s), providing enough headroom =
to drain the ring before it wraps.
>=20
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
