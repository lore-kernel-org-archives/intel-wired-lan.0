Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21479606A31C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=WhK8oHxZ;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Qpoh+KqE;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=UZkVOulb
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E3C8A606A3;
	Wed, 18 Nov 2026 18:57:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8Pl0fJ2PjPg5; Wed, 18 Nov 2026 18:57:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5C99D606BA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795028220;
	b=P0KqbjwhvKb4+9BTOuyN5eITibaK6+JWhaHcKHfZYkrXA/Km8wULExhXZDfBiVXah5jb
	 DgLc4URmO2KkVnRpkeIH10+HH26REKnEWKMyzj3wmHX/XpMHLKKgbKanqYNJWVsdBqUjM
	 pPJHi3W5Hx1bQHF9bs/WKZ7wLGA5tkFaIg9ntJJlmwYkEVAa/+DeMcueQZqOFC/GJS1DN
	 hpVt5kxn6g95JgOL5xVyu/4GVZtpxx2QG57E54oZf0clQcGNzviQgB6JHJDbtysWd2PBx
	 Mu8ff0s0Vg1o745nQcqRVatChic3IFCuUV6BFmDbHIQVYFQR5yaJWCGCHkGEDYUE7Dw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795028220;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:From:To:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
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
	bh=oB1LiPdK3dIPWaqF+BoGyMYyafMOLHhPUcJK63tOIs0=;
	b=JtB9tHIOK3HYclP1YkhGCGYfGmgc2vldHymsl45RqHrlMccNNKQiHbXVYlTJbbnlGKqI
	 2ukl+o+PXHbUpOJMGOhM8Kjwg60XLUHjrJhY7LlqbVlzuFk0u+L0Eej2uUSMxCoIK4hMm
	 jRD3HN9fQ/t3VEXVCeg8B6z35cd8KtMYqWqGBHj7pEz9l2NPY5SFJlbjFRkecacad2Om7
	 K+oueZhUPw8kQoKi0eQ/6Nz0Ea/pHbDo9JED7s5xgBD3+s1x1pEGB77L1DCigMg30YFJq
	 ik6/LClR4pDdTsHrjVP63qBaxniFJTPi+LDaWX29DY6DVnz2MKgpNo3F239aqe6vN9Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795028220;
	bh=oB1LiPdK3dIPWaqF+BoGyMYyafMOLHhPUcJK63tOIs0=;
	h=From:To:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WhK8oHxZQ625PUkLWNxBJRQyMnBDxsCnTjToJoV1tg5oMgwEOpWst0zvaMhRa9ErW
	 g+Bp0adVedL/oRaqsIG208s7JryXTG9/c/K03Qbh7mRhKx8U0HblZvpJQrAawTnjML
	 afXiNdTH4sEQc1jlk1KE1+eUFmFuviYSs9+t5SOjrBA+W0pQ+I3taacdvoKdL2P2dx
	 sIAZk6i0FNqbFO/XOtc62WUyH58DrjFXGcLsooNEUYQCFqT1AofW6oQbGZnEjfSmMK
	 lz2IvGd3Npu0hXd/3/KTjFseifTjHjZzujbigwBeVvUQPLqn/fWTldmz+DzKgFj7ZT
	 whhX3aXZ5HIZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C99D606BA;
	Wed, 18 Nov 2026 18:57:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6899B977
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 18:56:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4EBD581117
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 18:56:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X_jJBHN3z6mA for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 18:56:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 939088108A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Qpoh+KqE; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=UZkVOulb
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 939088108A
 for <intel-wired-lan@osuosl.org>; Wed, 18 Nov 2026 18:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795028216; x=1826564216;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=cJ/yjIl/+5+GF7xyKX8qbkN+u7QiBaPR4x7pzrf/x7A=;
 b=Qpoh+KqEsohSVbcOYO+ZwIwGmxdouETlRTcQXVXkVEKiv6lMkj82rQ7e
 43Uo1B3xIaGe1bhVb+KSFkl9VE8nBDLG6T698ySzqfReLJYpSOZqK/8Az
 71we2orKXwMd23Gk7SDvZs6Gj+Z1pTTskEyBJa9/HXBzKBTNatjLLzBZm
 CAgC3BRyQmCzkrgBP+yhC7qAAmYfoeapnlc4HirDE5QIrobAzTQ1AQ/FZ
 8MFJEq9voj3UtZeSV2wCXGo1e/7wfwx7qCppt9hOEyVIwMIdPuDekC04K
 K4yR620G9a5SDtqWN7jtOTEuIrtitWDaSHD5UR/oXQqo3q7Y7x4pMsZJU w==;
X-CSE-ConnectionGUID: TUvJhM9fTE2Txb1ycFiWJQ==
X-CSE-MsgGUID: d75fgUX1QvuCEJhK1R79bQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3748607"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3748607"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 10:56:55 -0800
X-CSE-ConnectionGUID: gpxdUlG8S/WMQ/J/7fEeGw==
X-CSE-MsgGUID: 23CBv/+wR/eq55D5ANKxyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10491634"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 10:56:55 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 10:56:54 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 10:56:54 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.50) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 10:56:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oB1LiPdK3dIPWaqF+BoGyMYyafMOLHhPUcJK63tOIs0=;
 b=UZkVOulb8AIUtLYxLPpThyJsP71Y5C5CB6YiXRTUm64EUdqXB4EslSTRfMMpcWBGIVkGshhbngToE6+1otlMjltJJTSINRFPzniQT92r0HMmdRyfx8Ouuhv0hBOwnGcDo1uwrzevNaTODeZTj+n/C9m1SVlsQYti+kKM30eMR+A=
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by CH3PR11MB015790.namprd11.prod.outlook.com (2603:10b6:610:349::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 18:56:51 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 18:56:50 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
 "intel-wired-lan@osuosl.org" <intel-wired-lan@osuosl.org>
Subject: RE: [PATCH RESEND iwl-net v6 5/7] ice: Document control PF lock
 ordering
Thread-Topic: [PATCH RESEND iwl-net v6 5/7] ice: Document control PF lock
 ordering
Thread-Index: AQHdWvMWjE4mGdfUPku5DTSNV48Jmrc0ZyqA
Date: Wed, 18 Nov 2026 18:56:50 +0000
Message-ID: <LV1PR11MB8790EFC4C9D1BF9E44DED54A907A2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20261013091235.1423979-1-sergey.temerkhanov@intel.com>
 <20261013091235.1423979-6-sergey.temerkhanov@intel.com>
In-Reply-To: <20261013091235.1423979-6-sergey.temerkhanov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|CH3PR11MB015790:EE_
x-ms-office365-filtering-correlation-id: 8ff392cc-1dda-4569-d423-08df45a5b45c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|261009223027099003|3023799007|4143699003|56012099006|11063799006|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|38070700021|261021123027099003|10067099003;
x-microsoft-antispam-message-info: CQugPTfI0DyGOevqTyRIyN8u9x9BDwcxxewDQh0IA5Cuy2Va+cOEiPJfENVW2d+YF8ZKx492CIHv0Bgs9dFQBKJqPUqplV2WA2yt+Cg7yhOid2p66hIKZNqDwKMJkd3mEHDSn31uF/aWAV3H3ti+XLgsOIr4Rr0mLADs6WilTYfsYhjfnOI+VH0C4e7pYcZk3HS0o8UgI3ZK2wR4Av2hw+kxWT4cAEQ/giW2jTS7rE68lhF/UgDJSWW6CdBaPTNXZBdwby3JTgNK2h9u09uGfGzAihSlQBYFByoigV43gjnNkHYXzYn/HiG34SxYoamLLqi0U/PpZVu8zsroqK32m1YsKiqukEYwa+aYuocV9aJlNAHtSGlxxvhKvbdamM8vPJGWORf4DOKu1z+lId+2Vy66wRUbJTPP7X6UZ5lAdKSZodLS/GqEUgZaygsMVigYxaQhq56+8hVQyv3pcEyfzKjRmpcrdm8pJt4WuHf3UI/h6/MyZbxhwuai0eIep39ETx8OFgaYage6+xv+yp0oWzDl/U9GyvQuxlrn4JdaEyQrahMt6bk6gquOZkDmi81IeWBZC30ezzzFJqVJjj04gbz+wmxLSE294cEjDY8OE0swi8ukZTyAJUGppGMRuZXq6h8CsywYsggYO4Dhdi2yUC8/pLtgoCLZMqiiVbkvSTTysNK/oi5hp07HVKKQRGxni26dIBtMF4UVcHm1vQhJj/GetqQyXk/E58n6MXO1nG8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(3023799007)(4143699003)(56012099006)(11063799006)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(38070700021)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HdnIiJGqKcGYrAATCnySIrl0eVL2kUQ8wCqtDXMH3ujgFmUb89cyQ1mLVUJ6?=
 =?us-ascii?Q?L9BZKA4p+dW1NMZ8u3RIJaRECFiypqief8fg2cfhR8H6tABQPkrhAhbpoP/1?=
 =?us-ascii?Q?tOU0HcJNPf8QyQograxYKd9mvCm1zCnrNbQfG1oYZ7MxLvdFPSW6xK72iaO2?=
 =?us-ascii?Q?MQD10RWlUFU2YOeJVxCr1cFyXnngEO9qDrtNds+Ci6hEyR5inYwozmBp4ya0?=
 =?us-ascii?Q?YpgKbQNlZpfq0VHdNeO+5+ngKZ9b8uvBZKRf3KV2ZzOjBapduHlpOmM+ynwE?=
 =?us-ascii?Q?55lmVvXENRFvcilXBePghjUV603ECCOZZkfPrPIxBAEDulaKYSFAIQaYsrDX?=
 =?us-ascii?Q?OLvRW2foST1MNyduV52QCuwaTY0ICYsVZ0gevIlfZJxkbbvICArnHjwRtCOr?=
 =?us-ascii?Q?ARZRjnnYk85bkoMJ4Rd6ZSHpwN2YCpxwqkBk+hQY/ne47UchLft1/VeQirW4?=
 =?us-ascii?Q?pK0eQqoA7GqLi9tDnoPnDCiV6e9KFhug1PJhFJXm6fjftRCzXhFwzCD+sTEF?=
 =?us-ascii?Q?Scw6vggZ0Rq+JhfcozVjBjC3ODGrgG5ArUCdi8zfdWoxMbrizZNO6P9j3K33?=
 =?us-ascii?Q?z7lgeichEqOiTYay/zkdLyigoR0NfHxPcwfmeNjq5abgDCjnlvPDUjyGeXPa?=
 =?us-ascii?Q?fA7d2wzfg3dSE/6IJHBNVeY9jceE5Xjp8dqtqDWQRuwMjJ9U1R+4pJGTGcEY?=
 =?us-ascii?Q?04D7345CTl1wiAMcHtMZ2OAqhv0ZiO6fqdeCCs/8mb9pZtOKALlJjA55XYqD?=
 =?us-ascii?Q?amm3WDaTuMfLFzmdzDplQrKf219ykNglese3RZjgmQaiIthAxNnHrwm+XWd5?=
 =?us-ascii?Q?d090G2noYm+38OcGxwZS1/j3RDa7/glAh1Djrhfy+2KCMu3DuN1A4BNWrwnj?=
 =?us-ascii?Q?KeKYDSHS9AYUeXsWESg4k8q1Zvtvg6CPlGKyD700YnBkCNyFvliCrBAfBLMq?=
 =?us-ascii?Q?Vd6ZrRXRzR7CKqJ+rJsQTbWkMvK6MCpxCd0SQaSpkmOeafPgrP0nLIbYZ1Z5?=
 =?us-ascii?Q?T1+a0OC9gvY3J8k9eeq5pk/+9KDcbdLRrKFPDCjno08tXKUDIcAjgSXs90qr?=
 =?us-ascii?Q?Vcf2BR5fJZ0iGEleitTLgyIIeA8i4j52JPrCqC9qk+3zfdauEWvBjR6phN1Y?=
 =?us-ascii?Q?1A9SayglMvfWjH3Lhwlyu1ASyh5N6ey6coWUkYglvBlx/MGtTzb4aDTBoDNl?=
 =?us-ascii?Q?kkqZ9kZRcOBgJ9LOrfyctEKaW32tJz6v7HBoRzJeX497zMZ5n2RJ9QGbxRfc?=
 =?us-ascii?Q?/PDrIF4WboZZb6l9ABMF+qJ+WRPtzUh7MG3vh+e5V84aFRNELWI7wFLSxw9D?=
 =?us-ascii?Q?vkppELuLEGEs1J6/n4hKq0mn+FnxGza2i2ZIrlegrcQ6KA3TTma2vV86OEbB?=
 =?us-ascii?Q?UYsc8w5H/fOEZup6iXlvssTVBxv3YhWP7kuWRtWkjbmnmL6Sd8HrcRMqre37?=
 =?us-ascii?Q?71XsB+ca72PRZhmTM8FqGGNMokU6WEdayAGJQKtAk+kx2HxxVUQrmq4WSTH9?=
 =?us-ascii?Q?8Q454dW8j938foP8R+yL8aSft17Ffw2YOe4JO11/M/KZb79nWaBNZyyX219o?=
 =?us-ascii?Q?sZ3ghJh8i/uxvHoZoc6POyyDmoFBi9MG9Tkn4m2Lc4a9KtNdM51LlEovIcXG?=
 =?us-ascii?Q?VU0Qp+CaBoh+IFN9qczunKXe2wd9bsX3WmPlnA2D1HwCKOpyymkBbQ1mpPfh?=
 =?us-ascii?Q?1R2TvgHPbsE0CkFQQHLJfChF2ik4eF7iQRPPAAAQubqHxPNr9nM5adXgJIBI?=
 =?us-ascii?Q?BantaJJiAw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: L8/C3Gn8gZqp6Qez/EErt7Z/s6sPwPm/hBXIONs0dCsso4tNp2uWUa7yVoqoR2Y0rUZc0Myy75VIz6L/e2VCo4aMkUSqjns/u6/0jMnspSETLYNDZbPBlte2yCgtjEiG85G1ToMXDMTAs6asV+yT3Go9EtsV4gbmZXMtY9vsMS3EreKHeYTY2eK48C8v3MyyRBYCeIB0tPV0hRgPLjkS2+3V/l/vciEemDu7uPvrI5Fs7/QnDf5CsqUb9mwCcz0vua7w0DXu2jn0yG2woMwW9p9Dv5wuDtkchv8/dtyzPjuo4F2p5vis7BizKB7Pn8fRFJdT6ZPVgOqDKTHdbnIrQw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff392cc-1dda-4569-d423-08df45a5b45c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 18:56:50.6729 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AcVvqqz0ckEWaWMlj8eFwOnNrhfERARYTNY3sMRo4kihmRA7+AtcSwDk0n1Q77+xzxDxJBt0BRAeT2IspQt9GCKu+5XqZZvnlUWlsh6GL8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB015790
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
> From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>=20
> Sent: Tuesday, October 13, 2026 2:13 AM
> To: intel-wired-lan@osuosl.org
> Subject: [PATCH RESEND iwl-net v6 5/7] ice: Document control PF lock orde=
ring
>=20
> Document adapter->ctrl_pf_lock as the outer lifetime lock for TX clock st=
ate and PTP hardware semaphore operations. This makes the existing ordering=
 constraints visible to future callers and helps avoid nesting the rwsem be=
low a DPLL lock.
>=20
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.h | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
