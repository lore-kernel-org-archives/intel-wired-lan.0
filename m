Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE392606A329
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Nov 2026 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=1McRsOCT;
	dkim=pass (2048-bit key, unprotected) header.d=muni.cz header.i=@muni.cz header.a=rsa-sha256 header.s=selector1 header.b=JXCLV8Hw
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D139760820;
	Thu,  5 Nov 2026 17:09:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jtFlhf0xQyyq; Thu,  5 Nov 2026 17:09:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A93F260833
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793898550;
	b=bzn96ikB7Y0wctd5BE0lmd0HlbcQ73nHXHWFqSFQGPMG8bPLnoyPZmNSa6DUEwogj2I4
	 BVcQZ955adMvsKyVpXRRGBAUayDngBfbvrUmIhiIRsS9RhwUkrobDnt7Cdof5GtKudeKH
	 S2mYVyLyMbT8GarLZtz407rBCwaphZzRACT58Eg5oRYr4rj4cdPyNteKdLkLM7Y0gqpp2
	 ipucyaHNlPtuyugTy4ucTd5mVawKnpq7Bwv+LHSil29DP4YmDiU6WM1Ov7oDLdQ5uXYh9
	 QopP/aThGLLddqH5BF9qhMtvg9iDZcHcA3HJvpfCgrkUowO97Tv0BBBI6+Ux/H1+A3w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793898550;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-muni-spam-whitelist-from:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Z40SmsAT3L6jA00KXvCezYo5KmjhghidouKvUoSfnbU=;
	b=qvQyw/Q5ctmUtVsiDeNQ3AuPS6veESHCbOnYtAgKrFQzQbx8U7+lTBqIcg47xBmQlQGY
	 IsZ7G/JjhD5XycZtR6NIsCbp9RcCck3DH9uPRHfdsSVtEtnC4FkyKlKk9wCljVweBNnhO
	 ZwDoVkSyKlhvwGSIpLXet5rfWIKAzLaGamimKMnKmHF5PmtF+dIxrNn4w3SkmPKX90mvd
	 L6A9358aqm0UQxctr42dv69gvym01yDOQWeHPvIJ2tyWaODY9F9hWcObf84OR4LrxL6gl
	 cjgg/axvz6vpyzAeXJ23EWKz3C8N8LoEL8MtjHA4c8t+sYj1Fw6Anf51X1MqH+rqPIQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=muni.cz;
	dkim=pass header.d=muni.cz header.i=@muni.cz header.a=rsa-sha256 header.s=selector1 header.b=JXCLV8Hw;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793898550;
	bh=Z40SmsAT3L6jA00KXvCezYo5KmjhghidouKvUoSfnbU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1McRsOCTXdeczxLCQRnlBU0PDjW5boUBO9JO3SRTTNCzjhZRH9X3f5d6OqSpbQitm
	 MD0+tePhl92J+yEt7tIuCoFDYKwkILRyQbF3siKr0QG6ZpSTzSiBCO5zcVGaZY5oiT
	 JwP2b2RP5UQhtW3DNWv3EZHXEA6DGCOHSv4ypQmStBWU06YqS0MWa5lKBWZrLViWDb
	 qoIrTLyff7qtsa6q9sGpTypPARCZlvDa0oxTlTxFbm7k936/AdYpmdFBt70OgWCqSf
	 xApMplLe7OD4faVXy+Uza0hxaolJenK/y1n9wEhgbZoj3cTsCuto0doJ4ROiLAarp3
	 GVecaQi+zYZnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A93F260833;
	Thu,  5 Nov 2026 17:09:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A9C4362
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 13:41:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4C1836080C
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 13:41:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x-0O94ARx4U4 for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Nov 2026 13:41:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 459AE60666
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=52.101.66.83
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=52.101.66.83;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=241000@muni.cz; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=muni.cz
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=muni.cz header.i=@muni.cz header.a=rsa-sha256
 header.s=selector1 header.b=JXCLV8Hw
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11022083.outbound.protection.outlook.com [52.101.66.83])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 459AE60666
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 13:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=muni.cz; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z40SmsAT3L6jA00KXvCezYo5KmjhghidouKvUoSfnbU=;
 b=JXCLV8Hwt4FKQckWZruLBdOLtEYv9UJHrXAmUcc5ciVJMikQC/XR7buWhlfGM7buzbZx7GfdqaqZzaII58u8jfiSD8VgfvNqywSBMg+kTkN9kwtXXS+lOahCi7Tu8lI6nmV8FBGBZQf0VA63sOhc2bphuH7IuZVLojzM31r8bBhTst6igKhCDsNXYM2haPevaAAfa1mRhcKHFfLC4OuyiLJ+vKK0LQwUTaZJnrWGQRs634qmYydcEIiMFYMw1sPM+UcNaoJU0xNZImN6go7COSU8xA042sQZd+5M1kVRsQU9MjO2ePq0VcsUq6+UeWmuqhlN2xOEZafmWaZWHqG0zQ==
Received: from DB7PR03MB4601.eurprd03.prod.outlook.com (2603:10a6:10:16::17)
 by MRWPR03MB11467.eurprd03.prod.outlook.com (2603:10a6:501:7f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 13:41:46 +0000
Received: from DB7PR03MB4601.eurprd03.prod.outlook.com
 ([fe80::424e:3796:8a90:ae43]) by DB7PR03MB4601.eurprd03.prod.outlook.com
 ([fe80::424e:3796:8a90:ae43%3]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 13:41:45 +0000
From: =?iso-8859-2?Q?Dominik_Dvo=F8=E1k?= <241000@muni.cz>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [BUG] ice: rx_bytes inflated by up to 4 GiB per XDP_DROP (buffer
 length read after libeth_xdp_return_buff())
Thread-Topic: [BUG] ice: rx_bytes inflated by up to 4 GiB per XDP_DROP (buffer
 length read after libeth_xdp_return_buff())
Thread-Index: Ad1tA8vFXhdI4PwrSAq5n4Z3HWy2FwAE8FWAAATVshw=
Date: Thu, 5 Nov 2026 13:41:45 +0000
Message-ID: <DB7PR03MB46019623B3417236ED8B13CFD5772@DB7PR03MB4601.eurprd03.prod.outlook.com>
References: <DB7PR03MB460158B90A64D025962670E0D5772@DB7PR03MB4601.eurprd03.prod.outlook.com>
 <auxmTcwi4J/k9Xb6@boxer>
In-Reply-To: <auxmTcwi4J/k9Xb6@boxer>
Accept-Language: en-US, cs-CZ
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=muni.cz;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR03MB4601:EE_|MRWPR03MB11467:EE_
x-ms-office365-filtering-correlation-id: 09f7997e-b4ba-4654-2047-08df3b42889b
x-muni-spam-whitelist-from: O365
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|786006|366016|1800799024|22082099003|10067099003|18002099003|38070700021|56012099006|11063799006|4143699003|261028144727099003|261026121527099003|261022105027099003|261026140227099003|261021135927099003|261009223027099003|261022075727099003;
x-microsoft-antispam-message-info: xBx/U4ij1IiAT6SlpXrS2czoj6I7YIMRGxUq4eszBG7dVUMLQVF4j+/57j7pNFB7Kj/DAFFlYEzcJz9/VCVtGG3PfoHE6rgFEwiepQzF++PzWJolwM6H41Qel/cc/Cl2ccsyED8PMtjgoVJw0EKhd6aub+5JdeHmepm9Vf2e8uqtXuNTQNgAOFoQP2rYgYQHvbBqfUZGcztfNzn6rii50ET1vk8D7PCYvF/4HSzx5CLts/HBEVflux/wZGAPjob7sOvrzLuvHlYEi9VVssl+vTnlkm11TtXAZyG68fjLmShjbJuKcphpe1du01LuZb0leE9DiflnLkADVwetXETOA/kHDu+MUDULJ94dN09mQAnZ0JmXf940TQc3gqVgPvM5gwhUB8TFFKTO10/VgoEipj0SUC3+TZYdwGzGiGmFGufZ09VIQ2h/aZRu5DsVdo+cdTJmPIKFN2BK8EoRn1ACB3FmuIbIIiuiQubjxQ6q0UmsEYQCVuxwTqFmieoCZ1oqbjo4uUQU1cPwper1KsjaBGHN2pmLKa+DqO5nYXK3OMt44n3jBeYtQj9vJDdJLdNn3Kaz94nQ9Po3gY/Hs552PlT0/m/vMxXgX6pUEktDBsicU7iRMdqif1K8QGf/P5TQZ+8pOwWPbr7ltIc98WaRGNQU2A4J2HGtsQANjV2DF2s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR03MB4601.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(786006)(366016)(1800799024)(22082099003)(10067099003)(18002099003)(38070700021)(56012099006)(11063799006)(4143699003)(261028144727099003)(261026121527099003)(261022105027099003)(261026140227099003)(261021135927099003)(261009223027099003)(261022075727099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?Upg5q3o8nU64Ft5WM1/zvUcZXXjzsjUCZSTHngZs7e7aU/Fjn1BJ2k/Ku4?=
 =?iso-8859-2?Q?/wzEOPhAHgTVyJrsupTeKZoernjO4ej+eLn2t3S2fp1iZEfjZVZ7nPuG65?=
 =?iso-8859-2?Q?YKlkie9EuxihLfeSJr+8x5KHpB9FCgQ80OlOUqQO4+STDJxRwN2Zs3tfh1?=
 =?iso-8859-2?Q?SnuFE+0PeqfJgEauGLosuPuSn1HoBlRupIJZ+P2ErtpRYtoKfd7a9DFSD4?=
 =?iso-8859-2?Q?yrCVnRxnP8znaYg3HLSW34Mp/s86H69OVOcxYaIUWWHrNhpUXZEjwDlAaV?=
 =?iso-8859-2?Q?CokCT02JEfXX8B1zdED6fRPPZqep0iO0GZ/y1dSMAOeZqof4RBaxGoI1mj?=
 =?iso-8859-2?Q?JpbSxpG2WK/hiXyP2H/e0cbeWktorGdgGaZybwHnwCZDXPuLDJGy6vuHFC?=
 =?iso-8859-2?Q?AUXuduMqQGGtoQlqxaU+RqqkfjvGoh2gfXvS8x9tX19xaBvOSSyHOlVi/m?=
 =?iso-8859-2?Q?E73W/n7VncK647XPO8+3Ed3/1sMR3qNr8J8OdA6oPuo3joMZcYIazQ9wEx?=
 =?iso-8859-2?Q?B05xjQCJaPEm2TMwlUa/9QdonN2QVS83ZTwDENavF3DfIYyITnC6RYXzmy?=
 =?iso-8859-2?Q?JH3Gzl9B5bXNYislS6pVD2iyURv9VRyLNa8XRe2fseCWP4sd1iqKlu2qGy?=
 =?iso-8859-2?Q?EoXPeCIYOOyjf25i3c+dpQNQKFg57QZFh9MwsIG0fn98zJfTG0rPibdhY0?=
 =?iso-8859-2?Q?GrFJl1Wy5iWU8glMVzx9aj+jnt/Mk1CZcJxeEqXDDAn4lTjhz+hrhKu+EG?=
 =?iso-8859-2?Q?EtVvbsgp1Lyn01eJzl7GRpGM5oiL3fBkjv5pk5SU7Vbr8bcHRxz/Ht6QOr?=
 =?iso-8859-2?Q?fOIAexigLtxYVTl3H/Cib0bvL24q/of7K3478d0QGrClWjE5ccOE15I0SE?=
 =?iso-8859-2?Q?P2BkY69nME7WSUY7e/09h0g56Sx2dCtQMTYWmjcejq88AoZKjcswz9J5x9?=
 =?iso-8859-2?Q?T6Wx+ewD423C1kWGI4VJoLInSDhf066bjIfvZhODxoTkS6SbJINTGZBHeB?=
 =?iso-8859-2?Q?wd1ntcYfRgHURcYU/0vuLP2ATMHhTFeDVol8EulGsySvdleU0hmAZiRwiZ?=
 =?iso-8859-2?Q?ynVVn7SaJO3vQXgJHWPN2WZ1kJPlROL7hWYhoo1QWxKT/SWzfAiKDA4WAb?=
 =?iso-8859-2?Q?c7+HJ6/6ow9qK9o63ZYnSKw4YutqKRH0F8jdtbyVlmxFX4n1wVbXGfozx7?=
 =?iso-8859-2?Q?A9odXYVPtA+3LRZv/nWii8OzHbxLJk6ErgrsW7dR18E/kkcAMqTLp+3LqB?=
 =?iso-8859-2?Q?lGlijyDrsOzBC3Bek5lOKJ99S75Oa+XuC5XSl3YLdMz1y6T4GGilQK+ZRU?=
 =?iso-8859-2?Q?+jTMyET8eZmiTussXevIdg25jcimHZGj6opyK96ccJwkVtvWYi/x2bOVoE?=
 =?iso-8859-2?Q?9eK2kwoiqKtzpWBRspJXruR1Vvp71FL9OjvN+GGz53qOpekW9ibVQIzbUB?=
 =?iso-8859-2?Q?aI7ypX8BaHujbRQRnWXpFOZd8Wc+7VmGmssoAUzutyV34RB9DOHHgQ5ljB?=
 =?iso-8859-2?Q?yWQZosVbL2qCQaRXqKUIF+WzdKE4zu461y6AlJVK79clhVHGrO1U24pRHj?=
 =?iso-8859-2?Q?hoMjCk/DzILPYgLG1uEsmB4iUDp/GXpT/JrLEHa/9SgWXBqTgRWo7G+CxR?=
 =?iso-8859-2?Q?/dZkSUrqusKHtPYFz35hODEl82BEzGI5tkEzLsDt+3q9wvbn+Tx/Q1Gmrk?=
 =?iso-8859-2?Q?wpuTxA9ko0wToaiHgSwRMN2ZpgDYTBSgceehRkI6UBVLCa/Od58emJIP3J?=
 =?iso-8859-2?Q?TQy0FBbri/68RyzSds7MWup3Y=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: muni.cz
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4601.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f7997e-b4ba-4654-2047-08df3b42889b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 13:41:45.5597 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 11904f23-f0db-4cdc-96f7-390bd55fcee8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3IYSXtJLhGHcjpWBD02I8sBBqTrX08m//DdfUfYLB+Fx7N95UodgYxRvNdgPNt8m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR03MB11467
X-Mailman-Approved-At: Thu, 05 Nov 2026 17:09:07 +0000
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

Thanks! Tested on the affected box and sent:=0A=
=0A=
https://lore.kernel.org/netdev/20261105-ice-xdp-rx-bytes-v1-1-63da7b5e3d76@=
econ.muni.cz/=0A=
=0A=
Dominik=0A=
________________________________________=0A=
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>=0A=
Sent: Thursday, November 5, 2026 12:19=0A=
To: Dominik Dvo=F8=E1k <241000@muni.cz>=0A=
Cc: intel-wired-lan@lists.osuosl.org <intel-wired-lan@lists.osuosl.org>; ne=
tdev@vger.kernel.org <netdev@vger.kernel.org>; Tony Nguyen <anthony.l.nguye=
n@intel.com>; Przemek Kitszel <przemyslaw.kitszel@intel.com>=0A=
Subject: Re: [BUG] ice: rx_bytes inflated by up to 4 GiB per XDP_DROP (buff=
er length read after libeth_xdp_return_buff())=0A=
=A0=0A=
[You don't often get email from maciej.fijalkowski@intel.com. Learn why thi=
s is important at https://aka.ms/LearnAboutSenderIdentification ]=0A=
=0A=
On Thu, Nov 05, 2026 at 09:05:19AM +0000, Dominik Dvo=F8=E1k wrote:=0A=
> Hello,=0A=
>=0A=
> after upgrading the kernel from 6.8 to 7.0 (Proxmox kernels=0A=
> 6.8.12-34-pve -> 7.0.14-26-pve), the software Rx byte counters of an E810=
=0A=
> started showing phantom jumps of hundreds of MB to several GB. Each jump=
=0A=
> is exactly one packet. The cause is a length read after the buffer has=0A=
> already been freed on the XDP_DROP path. The bug is still present in=0A=
> current master.=0A=
>=0A=
> Setup=0A=
> -----=0A=
> - Intel E810-XXV for SFP (rev 02), FW 4.30 0x8001b891,=0A=
>=A0=A0 DDP ICE OS Default Package 1.3.43.0=0A=
> - in-tree ice, kernel 7.0.14 (Proxmox build 7.0.14-26-pve)=0A=
> - 2 ports in an 802.3ad bond, native XDP program attached to the bond.=0A=
>=A0=A0 The program returns XDP_DROP for blocklisted source IPs and XDP_PAS=
S=0A=
>=A0=A0 for everything else.=0A=
> - 6.8 kernel with the same HW/FW and the same XDP program: not affected=
=0A=
>=0A=
> What we see=0A=
> -----------=0A=
> One sample, 1 s interval, ethtool -S plus netdev stats:=0A=
>=0A=
>=A0=A0 rx_queue_4_packets: 76843 -> 76844=A0=A0=A0=A0=A0=A0=A0 (+1)=0A=
>=A0=A0 rx_queue_4_bytes:=A0=A0 32920496416 -> 33701427810=A0 (+780931394)=
=0A=
>=A0=A0 rx_bytes.nic (HW) on the same port grew by 2222 bytes in that secon=
d=0A=
>=0A=
> Only the queues that receive the blocklisted flows are affected (3 of 16=
=0A=
> here). All other queues show normal bytes per packet. Every jump is=0A=
> smaller than 4 GiB. 780931394 is 0x2E8C1142, which looks like the low=0A=
> 32 bits of a kernel address.=0A=
>=0A=
> Root cause=0A=
> ----------=0A=
> In ice_clean_rx_irq() (drivers/net/ethernet/intel/ice/ice_txrx.c):=0A=
>=0A=
>=A0=A0=A0=A0 xdp_verdict =3D ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring,=
 rx_desc);=0A=
>=A0=A0=A0=A0 if (xdp_verdict =3D=3D ICE_XDP_PASS)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto construct_skb;=0A=
>=0A=
>=A0=A0=A0=A0 if (xdp_verdict & (ICE_XDP_TX | ICE_XDP_REDIR))=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 xdp_xmit |=3D xdp_verdict;=0A=
>=A0=A0=A0=A0 total_rx_bytes +=3D xdp_get_buff_len(&xdp->base);=0A=
>=0A=
> On XDP_DROP, XDP_ABORTED and a failed XDP_TX/XDP_REDIRECT, ice_run_xdp()=
=0A=
> has already called libeth_xdp_return_buff(xdp). That function frees the=
=0A=
> buffer and sets xdp->data =3D NULL. xdp_get_buff_len() then computes=0A=
> xdp->data_end - NULL, so the low 32 bits of a pointer get added to=0A=
> rx_bytes. For multi-buffer frames, xdp_get_shared_info_from_buff() would=
=0A=
> additionally read skb_shared_info from a page that has already been=0A=
> recycled.=0A=
>=0A=
> This looks to have come in with "ice: switch to Page Pool"=0A=
> (93f53db9f9dc). The old Rx path did not clear xdp->data on drop.=0A=
>=0A=
> Proposed fix (untested)=0A=
> -----------------------=0A=
> Take the length before running the program:=0A=
>=0A=
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c=0A=
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c=0A=
> @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int size;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int size, len;=0A=
> @@=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ice_is_non_eop(rx_ring, rx_=
desc) ||=0A=
> unlikely(!xdp->data))=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continu=
e;=0A=
>=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* ice_run_xdp() may free the buffe=
r and clear xdp->data */=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 len =3D xdp_get_buff_len(&xdp->base=
);=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 xdp_verdict =3D ice_run_xdp(rx_=
ring, xdp, xdp_prog, xdp_ring,=0A=
> rx_desc);=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (xdp_verdict =3D=3D ICE_XDP_=
PASS)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto co=
nstruct_skb;=0A=
>=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (xdp_verdict & (ICE_XDP_TX |=
 ICE_XDP_REDIR))=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 xdp_xmi=
t |=3D xdp_verdict;=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 total_rx_bytes +=3D xdp_get_buff_le=
n(&xdp->base);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 total_rx_bytes +=3D len;=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 total_rx_pkts++;=0A=
>=0A=
> With this change TX/REDIRECT count the length before any=0A=
> bpf_xdp_adjust_head/tail. If you would rather keep counting the=0A=
> post-program length, the same thing can be done inside ice_run_xdp(),=0A=
> before the buffer is returned.=0A=
>=0A=
> The root cause analysis and the proposed fix were done with the help of=
=0A=
> Claude Opus 5.5 (Anthropic). The symptoms and measurements come from our=
=0A=
> production firewall. I have checked the code paths described above=0A=
> against the v7.0 source.=0A=
>=0A=
> I can test a patch on the affected box. The issue reproduces reliably:=0A=
> each XDP_DROP produces one phantom jump.=0A=
=0A=
Please test and send a fix. You've done the root cause analysis so would=0A=
be nice if you get a credit for providing a fix to this issue.=0A=
=0A=
I can then test this on my setup and give you an ACK.=0A=
=0A=
Thanks!=0A=
=0A=
>=0A=
> Thanks,=0A=
> Dominik Dvo=F8=E1k=0A=
> Head of IT Services=0A=
>=0A=
> Masaryk University | Faculty of Economics and Administration=0A=
> IT Services=0A=
> A: Lipov=E1 507/41a | 602 00 Brno=0A=
> T: +420 549 493 183 | M: +420 739 487 807=0A=
> E: Dominik.Dvorak@econ.muni.cz=0A=
>=0A=
>=0A=
=0A=
