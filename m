Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB5C606A31C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Nov 2026 06:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=HxJ3rrPp;
	dkim=pass (2048-bit key, unprotected) header.d=aweta.nl header.i=@aweta.nl header.a=rsa-sha256 header.s=selector1 header.b=VYJy3q0n
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C9E058130C;
	Wed, 11 Nov 2026 06:46:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UyVIp6rzJ4tM; Wed, 11 Nov 2026 06:46:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3260F81301
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794379614;
	b=eVn3Sp0RiOZU+hVUfc89cjwYrmEzmd3Z5Y7ct43OzwQo3fSQSzc/jE9fxk1mLuwFOfJw
	 BHazPTbun+n78Oxp09pK6Ec+Tl5wOEPHvuRE/GIVzhOD0nKpmy8FL9UsdAKXjdIwp2jtn
	 C/u/XbS4NQ1vVZ7yTDdntHSgNVxJpj4xVNmIgQNfEGdrALTJUyocMBA+g2dQ2c4XGNSRj
	 1gi4HxnDyJqq6PjetLS6vDaoG/lAjo0Q1WdGmFoDHguG6bqnSIHwNzGypnvn8m6b9MQqr
	 hRgCNbfUjBCoGA/O40H8bqjUaCR/bD1cADLK+MWx1ZLruu1/gG8a/H4wXvhNjdE7ZPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794379614;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8wwjlyjRXD+uENX3eNALtOcWveSShD7H3BZvgI0XoV4=;
	b=cs6qoUhSazYCiccp57C1MZFCwIjXAhJDzKxoQir/CmlugD6q298FiM6ETrC78RggB8/z
	 5QXUg95WxNoonZDMBRa0Y5qQP3lVvKC1E9xTD4rFytpHWCy+reurDcx0JsJGF6G963wRu
	 Yt3RNGbLlfNes/lYagxORaAtSCG9Up8lML5CamXnzMva0AIgI3uG69o10AmtdOrm+vean
	 HLN1+5paaS9DNW3nOblDqxSbWij7Q+HTO1iwFIWjInE3B6sq7JUdUzpXG0djyhf/Y1bE8
	 MXWNvu0ORg0fbLq0cQSlFY4RZHHmifpi/2EUIAcTbUwmfWLze2VLdwuL789AAyOsGSg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794379614;
	bh=8wwjlyjRXD+uENX3eNALtOcWveSShD7H3BZvgI0XoV4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HxJ3rrPpQD3Yk7xOl+WTm6qU7B+qjyI1RbcCnKkrCr2TvpY+cifCP52YtJe4I+PNP
	 QoUxXFJfORq4VsH2Omexrx9LPBwrO943oMRKeZhU38A31XA4cG2t/nomL571304aC7
	 nWKUuDBG7vDix8aJjG0+8JtxnVvQMMxGSrRjDRqJllI2euLlCHcvMcipg9thZ8EPa0
	 kGyw09l8lQDJtpJuPVpak7DTnhPJTRTzMD08TlFLrpUgbcwAtuReGGUrptnKHLMPX0
	 qeDkGU0tEAvYCg5T2Vnjg4QSPELjwmyp33Vb3meLAhrbJsvXJpcs+9ko3+4J3Mu58m
	 9BQl3i/Wr/oJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3260F81301;
	Wed, 11 Nov 2026 06:46:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C1B03731
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 06:46:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A701440318
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 06:46:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F4JOWRr-eWRj for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Nov 2026 06:46:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 00505400B0
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=52.101.65.117
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=52.101.65.117;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=tkusters@aweta.nl; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=aweta.nl
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=aweta.nl header.i=@aweta.nl header.a=rsa-sha256
 header.s=selector1 header.b=VYJy3q0n
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11021117.outbound.protection.outlook.com
 [52.101.65.117])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 00505400B0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 06:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aweta.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wwjlyjRXD+uENX3eNALtOcWveSShD7H3BZvgI0XoV4=;
 b=VYJy3q0ng4X+Q85CwQ5jNoUF0S8I23nYDezbPBc8aY5oG1n7W3X44JNvzCcbmEjyksBk2GDnILsZItUqdvGIJnS+Qp1UXAQCL7L/bI7xzkK31YEJWdRRBTWlzIRbKH1k4rAxKXFk666OYPFPzRlUXKkIC99i4kMTKBA1d1aZ7iEKb5X23IjKdjPWmRw72vp5HIMY7PA9+uBJ4UVsW8zYRkYnKTkQ89/NB0dWBgqkvOmHezEWYD0UCEB2oOM3g1ifLwoWMIAyFMxzgNwY3QCsXjgiAAAHFhPymwKIcK2zgu+1qkTriHAUa7gJKNyjGkEMR++45MexcLgk679d9tTToA==
Received: from AS5PR05MB11020.eurprd05.prod.outlook.com
 (2603:10a6:20b:67d::13) by PAXPR05MB8112.eurprd05.prod.outlook.com
 (2603:10a6:102:de::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 06:46:47 +0000
Received: from AS5PR05MB11020.eurprd05.prod.outlook.com
 ([fe80::2dc4:6bec:d87e:3492]) by AS5PR05MB11020.eurprd05.prod.outlook.com
 ([fe80::2dc4:6bec:d87e:3492%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 06:46:47 +0000
From: Tjerk Kusters <tkusters@aweta.nl>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
 "przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
 "ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
 <daniel@iogearbox.net>, "hawk@kernel.org" <hawk@kernel.org>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>, "sdf@fomichev.me"
 <sdf@fomichev.me>, "sven.auhagen@voleatech.de" <sven.auhagen@voleatech.de>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>, "kurt@linutronix.de"
 <kurt@linutronix.de>, "sriram.yagnaraman@ericsson.com"
 <sriram.yagnaraman@ericsson.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "maciej.fijalkowski@intel.com" <maciej.fijalkowski@intel.com>, "p@1g4.org"
 <p@1g4.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "piotr.kwapulinski@intel.com" <piotr.kwapulinski@intel.com>,
 "aleksandr.loktionov@intel.com" <aleksandr.loktionov@intel.com>,
 "alexander.nowlin@intel.com" <alexander.nowlin@intel.com>
Subject: RE: [PATCH net v5 1/4] igb: do not let XDP frames span more than one
 Rx buffer
Thread-Topic: [PATCH net v5 1/4] igb: do not let XDP frames span more than one
 Rx buffer
Thread-Index: AQHdbCdcWmiAvdSZkUiihjXYKarcRLcjymAAgASuFiA=
Date: Wed, 11 Nov 2026 06:46:47 +0000
Message-ID: <AS5PR05MB11020223B9C97436DE9D0A219B9712@AS5PR05MB11020.eurprd05.prod.outlook.com>
References: <20261104-igb-rx-ts-fix-v5-1-bf4b4367129a@aweta.nl>
 <179412230443.994134.1015628730237451247@kernel.org>
In-Reply-To: <179412230443.994134.1015628730237451247@kernel.org>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aweta.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR05MB11020:EE_|PAXPR05MB8112:EE_
x-ms-office365-filtering-correlation-id: 597b289f-2c41-4bfd-6d21-08df3fbf8e90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|23010399003|38070700021|261026140227099003|10067099003|4143699003|261022075727099003|56012099006|261009223027099003|261022113327099003|261022105027099003|261026121527099003|261028144727099003|18002099003|22082099003;
x-microsoft-antispam-message-info: OiloSkqXIO8fDJdgOXX+japh7mG7ap6G2ChplnqcZQ5GZR4O3jLXl2lJa2Q8IgmfAGEIdftC9RFrZg59gMTib50LE5xusH0pGjqeD7HWwT7o+fhXANtF0m0Pt/KrleJG8DKUf+WCaXWoxnMtLuMcULXPt2Db6apIQ716ISOzgooW3VUDPbHnJXtCqqKF/oKv+Hge1AFK7ontTqurUqMHV78xQzTnorrT9M2gUpnyVoSbPaif0yELC8S7/3hWfujP1Uw58WodG2NpQvovUry3Diqo+S7V/A1nEy9JqAkeyHRQo9jnlTLvdPyrcYkG/YmGIwMOldpCF3GiRYDp+KV2wSn2rf/X0b2tBAk6J77SelSUubqRecUjhfalAOzQeuIaSTC/2RAJww3vuH6+aK/WYNxZAnrRjhtxAAxs/YarftnMNeCxuduExs7KTTHROVTqeMDUIcqllje0E3Eg9/xcSv/GrNhQPLrwtyCCcpmNinpdQDZ2XjMKuqnyfoAQUQ6aXGF5lYf05cHUnqoJyalRYyTVCQ0xzBHBTLVTO69PEIQ8iDcrGsBBlImq6HA4nH7rr9Jy4AM3p6+arrCa7qzFD4ZoLMI6Rqvrci3S/U/DFr4s7nDBg6LcH8Y2FlqIP51FMeP2Ig+GW1k5EbNfi0wezMUWwosbw5j2zWaa3X0Ugd47UkWfKjhmultM8AZ7llkU/Eep9MzwMBDT7M94oQRtIa3jt7tDV4T2dqC/jXspAmE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR05MB11020.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(23010399003)(38070700021)(261026140227099003)(10067099003)(4143699003)(261022075727099003)(56012099006)(261009223027099003)(261022113327099003)(261022105027099003)(261026121527099003)(261028144727099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bU1qSVBXZzhrZFlIdDFzNiszbElYZUNWcG1pYnNaWkFPNjFOS3NuSkJOVXI0?=
 =?utf-8?B?QVVMTEhOUUJiVExUbEs0eU4rUDBrSmh4S2dsblUxM3JQUzUzVTJNeFlqOXZu?=
 =?utf-8?B?RkNReWxhWklUbFIxYzdsR2lQbW5HU2kyalJ0c1NROE9OVzNIb3l5N25XTStQ?=
 =?utf-8?B?N2tYMEJ2dFVaS0xWcmIzRklYMExUSGZrOFcwWUg3d3czMEJ6Skd5YjBVWWpL?=
 =?utf-8?B?dlhvcDU3Q21OM1pBNVB2S1hIOWhnRmVIdkVkSWF6eDJLa2RXTEtLWkVUZmRE?=
 =?utf-8?B?bGRtT3lVc0Y2MWowMHl0OVpmVC94VXZET2poVHhGTGcwc3NRL091bWtCTkRT?=
 =?utf-8?B?RTQrR3RhWUNNU0hIVlFjdWQxTVhZaUh5VHBBVnhNTmJYZWVpOStuRTdQUlZa?=
 =?utf-8?B?Ti9oaklQUjNsa0xqQ2ZPK3VjYXpQZWN6TE8xNjF4aHk0NzlQc3dsYVM2cmFo?=
 =?utf-8?B?N0tGSW9tWTUyWEVYZFVzMmR6aUhxUk9pVnFJZ01nS2t4dXFXVGhZRjFCL09T?=
 =?utf-8?B?YXZnRlZTKzNObC9VdnBVSXowNXdIQ2xJY3JjNWx4d003UGljd1M4RWM5ZDYr?=
 =?utf-8?B?S3pTYmR5VnB1eUlBRG1HNDBrbEFZZDdvUkE5Y0NydFAxNloyNFdqNjIzY0do?=
 =?utf-8?B?dng1NmRIblpjTUlFblVRTmdQMlFTQzdEY05keEZkRzVqa2ZQZUtFN1ZBTU9B?=
 =?utf-8?B?OGtLbWF2UG5PNlZTeCtwbXhXMXl0bEI5VEE4TklDVXdDZ1I0VXNTd1g0VDdU?=
 =?utf-8?B?VHJwd3hQdW1Vc2NTaXlBYXZGekI1YUlLdFYzOGUrUFJnc1JISmxiVkYxY0ds?=
 =?utf-8?B?azJReC83d1ZHMVNqQ2tFZS9TblpGZCtrL0hIM0lsMUFvb0xkdFNYa0VzaVNt?=
 =?utf-8?B?S0NtZVJmdW90S2FPRFhrY3VCM01KMi91aGNvbmRnam1UMU16YW9ua21zVnhD?=
 =?utf-8?B?Vk8wdVNLRndUSmdPbWlybU4vLzI5NUQvRUkvQm5rZ3VRZlBHS1hmU2pwMS9Q?=
 =?utf-8?B?YyszTDVodDlFaytkQ2xJTUpqd2hrRjJ5SGZ0SVpPVmhPcnhWRmlQUTNFQmFx?=
 =?utf-8?B?OFUyQjhoWmxZL25NZkNYZXZNdWZBQjBxaTNnTlBzcXYydk1mTGV3NzVVWlNk?=
 =?utf-8?B?dm5pU0lHTTU0cXJLUzAveUdjRndkbjJBektWSUtXRGlhSEJFMTZHWXFQQmNt?=
 =?utf-8?B?ZmtLSURlT25XN1ZKN1Qvakt0WXpuUzQ1dEU4anBSamZIUnhuNW03Mm92bVhW?=
 =?utf-8?B?VVZqdjRKdnlnNUYra3JUTmpWSGZqeFdtdnVRUFo0OGpCMitCMTlxMGFnalov?=
 =?utf-8?B?bzl0OS9NcUJnZkpsaHVmRlk1QXNWTUs4b1loSCtlNG91eG1yallPRGFsK2Jm?=
 =?utf-8?B?TzhndlFrVXRtTkxyWVZmY0VmSlVXY2dZM1ZSNys5aElzMmtrc2NSVDhDVHM5?=
 =?utf-8?B?aVRiZHgxd0VVSW0rTmZ6QlRLVWZENHFwclc5MmN3VkZ5MExIbHBCcElHNnBI?=
 =?utf-8?B?bEZRWHJpVE1ZbDQ4SFVDUEpaM290cS92MWs3ajVmNkIrQXAyOVY4TDVPRUl4?=
 =?utf-8?B?SXZnZnNidFU0YzdEelppNzFFUEg3enVsQVBtdmNSVThQc3JLRk5MTGIzZjRh?=
 =?utf-8?B?aDZIVWwvTGduQy9QTnVkaW5tTm5FclBKT1htNTBtSXEwamtCNVFyTW1OdFEr?=
 =?utf-8?B?R2pQeUF6cTFqbFJ1R0ZLd1NueXRVSUxOWWNCK0VyZEcwcHVOMlFnT3k5Sisv?=
 =?utf-8?B?NnpMRWl2OXc4cEF3bzZmNno5ZHlHM05meHgxNzBxRnpHc2U5SWtETDJ4aEU1?=
 =?utf-8?B?N2lYNlZZQVFNNGNXMHBKakVKdGhRb000aW1zdFVWODVydUMzODRiVldabTNB?=
 =?utf-8?B?T0hCMldMTHFPOUZOYS9lY3k2bEYzTDE3bWVqUWd1THFKdERSWEN5enBSOFpF?=
 =?utf-8?B?dlZWbWlsWW1vTjVQQUc5RDBmM09qR1VBYzc5NFlDT2dybTE0OEZBaWkrS01N?=
 =?utf-8?B?M3NHWnprNGdNK2JRN08wYWpJWmJWRXBIQitZVHVjYThMY3h0dExIWjd4dXFX?=
 =?utf-8?B?Q05BcHNTWFhSa3EraHJNU2NvcUQyOGVXUm5zc0w1MlliU2dHYXBVdFBXSTdp?=
 =?utf-8?B?Und3eWpTSzA3dU9hdmQyRVk0bzUyK1c1UGFYYUFDMWhmMjNjaW5jR1VQRDVu?=
 =?utf-8?B?Nk9yOWhrUWRyNEhxVk5FY2wxciszTnhKWGxLR29JNm9kTVBVZkFjbDhrTGQ5?=
 =?utf-8?B?UXowdlJHUFljaE92Y28xNDkyeVgvTHg4a0NTencwaVBLbHEwOGdPdXFWOCsw?=
 =?utf-8?Q?uO5DttbeFKg8R6bT8Y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aweta.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS5PR05MB11020.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 597b289f-2c41-4bfd-6d21-08df3fbf8e90
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 06:46:47.2857 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6546512a-ba20-41bf-9d8d-c076dcbf6fd9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IVYPaBJBYaRgb5kYE/rRM5X6xSzVtru6F0d/p6ySTU7qs72UKfjt6F0YF9ycwQgW1jbcEltKj+Nu2D0mBoSQUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR05MB8112
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiAtIFtIaWdoXSBPbiBpMzU0IHdpdGggVkZzIGFsbG9jYXRlZCwgaWdiX3NldF9ybHBtbCgpDQo+
ICAgKGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYi9pZ2JfbWFpbi5jKSBwcm9ncmFtcyBu
byByZWNlaXZlLWxlbmd0aOKApg0KDQpSaWdodDogaTM1NCBjYW4gaGF2ZSBWRnMsIGFuZCBpZ2Jf
c2V0X3JscG1sKCkgc2tpcHBlZCB0aGUgUEYgcG9vbCdzDQpWTU9MUiB0aGVyZSwgc28gbmVpdGhl
ciBSTFBNTCwgd2hpY2ggc3RheXMgYXQgOTcyOCB3aXRoIFZGcywgbm9yIFZNT0xSDQpsaW1pdGVk
IHRoZSBsZW5ndGggdG8gdGhlIGZyYW1lIHNpemUuIEluIHY2IHRoZSBQRiBwb29sIGxpbWl0IGlz
IGFsc28NCndyaXR0ZW4gb24gaTM1NCB3aGVuIFZGcyBhcmUgYWxsb2NhdGVkLiBUaGlzIGFsc28g
Y292ZXJzIHRoZSBzYW1lIHBvaW50DQppbiB0aGUgcmV2aWV3cyBvZiAzLzQgYW5kIDQvNC4gSSBo
YXZlIG5vIGkzNTQ7IEkgY2hlY2tlZCB0aGUgcmVnaXN0ZXINCnZhbHVlcyB3aXRoIGFuIEkzNTAg
Zm9yY2VkIG9udG8gdGhlIGkzNTQgVk1PTFIgYnJhbmNoZXMuDQoNClRoZSBjb21tZW50IGNvbmZs
aWN0IHJlcG9ydGVkIG9uIDMvNCBpcyBmaXhlZDogdGhlIGNvbW1lbnQgaW4NCmlnYl94c2tfcG9v
bF9lbmFibGUoKSBubyBsb25nZXIgc2F5cyB0aGF0IGlnYl9jaGFuZ2VfbXR1KCkga2VlcHMgdGhl
DQpmcmFtZSBzaXplIGNoZWNrIHRydWUsIGl0IHNheXMgdGhhdCB0aGUgc2l6ZSBpcyBjaGVja2Vk
IGFnYWluIG9uIE1UVQ0KY2hhbmdlcyBhbmQgd2hlbiB0aGUgcmluZyBpcyBzZXQgdXAuIFBhdGNo
IDQgaXMgZHJvcHBlZCBpbiB2Niwgc28gdGhlDQpwcmUtZXhpc3RpbmcgemVyby1jb3B5IHJlZmls
bCBpc3N1ZSByZXBvcnRlZCBvbiA0LzQgbm8gbG9uZ2VyIGludGVyYWN0cw0Kd2l0aCB0aGlzIHNl
cmllcy4gSXQgaXMgYSByZWFsIGlzc3VlIG9uIGl0cyBvd247IEkgbGlzdGVkIGl0IGluIHRoZSB2
Ng0KY292ZXIgbGV0dGVyIGFzIGEgc2VwYXJhdGUgemVyby1jb3B5IHByb2JsZW0uDQoNCnB3LWJv
dDogY3INCg==
