Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AAB60A2639
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Nov 2026 11:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=b9Zoyzyh;
	dkim=pass (2048-bit key, unprotected) header.d=aweta.nl header.i=@aweta.nl header.a=rsa-sha256 header.s=selector1 header.b=MBzhQIGQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 34B95815FA;
	Fri, 20 Nov 2026 11:07:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8q8xra0yk5BF; Fri, 20 Nov 2026 11:07:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8D2618168B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795172823;
	b=SNj53DEekHnzwIiu5kE9ZnQo+LgXARKyLzuiPmi1JF5fnDfp7CDDMVd9Yj7xZ1Ol850K
	 w2MrVg5vsGFScaDq0SNV+4rxiqhdJvdw7Pi2M3+8W6GH/V6wjCMo5CTT8PaAWf/q4L6hr
	 341aXfpcfjO9XsxZzl6YU2EXZM8HGww3+4k05jkHYPY6MY7QfjeiIhO7e1ZNG9bzpuxdR
	 juHyITbnfpg+Hu5YfU/cGO0jHrMWg7XF5PsYPwL6qG4eAMJjQlUBmBKi9rlJof7uC4elh
	 SPor/MzxHo74Cs7VkjT/CJKaWpgJ7FhxxtTLCTc5ahrmNw9HlpGX5l4k/anEIXbxc6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795172823;
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
	bh=57nGriXOSsNQ48dyorxma+Q+6GWFLrNYbzWx1CN/V4s=;
	b=ImjymD23sEQ7k0ZjMI6ot6VOVVtjt2UaDUGy8n1T+xoOI3XSX5d9HaIzIOykEe8SfsFt
	 AmQeEizIy5BfoP3PMCSmJx8BQ0X/iqauASLJYTq7uTk9537AeEyUtx4q8hg4m+BVAgfgX
	 RznCY+jmW0QUjsVzM6p4z1v/oLzhqQOz93exu77Ha6NlsFxjGGTfFctDviz6a13Ag0Yjs
	 wr233ZpKCyaGNzXiOfhlzFksN2P8/eY+JzcGKlVG1EazgyZ8cAG42rTew1VDpy6FeHfOs
	 st5tZWSCEH2nrqp1eae+n3rJC8BHud5VjdnAkfCrFS7FWTbq7bmI2+cFNQQr/jg9svQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=aweta.nl;
	dkim=pass header.d=aweta.nl header.i=@aweta.nl header.a=rsa-sha256 header.s=selector1 header.b=MBzhQIGQ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795172823;
	bh=57nGriXOSsNQ48dyorxma+Q+6GWFLrNYbzWx1CN/V4s=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b9ZoyzyhFbAzRAnCSPKH9GVINEUPKM5rbSyYA10X0Y0qjZnKxaJkDou7gCeZe0Qc7
	 CAoTUn0JQAKcG1/rzq1TRP2woTo1ybkAY/Yzj+WQcuRDIAOvr+G4IeyV4N28JYVtoL
	 uDswsuGlEv6KuF4YDjBzP1s01gu66IENBYxYFCH+7sDAnrmXaVXATRiYeYG4h8zyKR
	 J3dT7AHQNv60FZo9qryBSG3rkRDQsw+j/9jAcjbir+RIXFzN20W1WnyPFsYhb1SnGx
	 z3ZA34WjjF0WleBjr47v/b31l+PmM1pAZl4UrZdp6lzj3rs/xe5YQW45ScFKS6UUni
	 UkogVtkB9ZHkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D2618168B;
	Fri, 20 Nov 2026 11:07:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 925391C9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 11:07:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 83F1A8168B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 11:07:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 67jE9lChIvo1 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Nov 2026 11:07:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9CB0C815FA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=52.101.84.140
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=52.101.84.140;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=tkusters@aweta.nl; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=aweta.nl
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=aweta.nl header.i=@aweta.nl header.a=rsa-sha256
 header.s=selector1 header.b=MBzhQIGQ
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11020140.outbound.protection.outlook.com
 [52.101.84.140])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9CB0C815FA
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 11:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aweta.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57nGriXOSsNQ48dyorxma+Q+6GWFLrNYbzWx1CN/V4s=;
 b=MBzhQIGQgAFEuhntfUEhm06aaNaZG5XM8bB1TVVeWkf6Wg16T4d8Src05jk4wDAh0iF8P1BPPNydFSqOzKWcB3SsO/joza84K7BJgOpIpE2+Q0Z7V6Apu82XTkLTb4O6rAsfRlE5ke9CXRNh7UMXbpTQcDtHhcoiWniJiPRRPwlPpG24cUZI/EJdMtFHFteNfkyaSzXTu2ZkTpUSLdndDSIjCu2HdyCYnC3kKBQDJ34jws9owNN0VevjCz9pUC3c/lDuyR+AFoCQ2trty9YVgLThvDyncppeGEWMS9bLl0BqOBvvZlbHTn3pJU2mZPPPYJdYW8eYadTh02aGhns9pQ==
Received: from AS5PR05MB11020.eurprd05.prod.outlook.com
 (2603:10a6:20b:67d::13) by MIWPR05MB401878.eurprd05.prod.outlook.com
 (2603:10a6:290:d9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 11:06:55 +0000
Received: from AS5PR05MB11020.eurprd05.prod.outlook.com
 ([fe80::2dc4:6bec:d87e:3492]) by AS5PR05MB11020.eurprd05.prod.outlook.com
 ([fe80::2dc4:6bec:d87e:3492%4]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 11:06:54 +0000
From: Tjerk Kusters <tkusters@aweta.nl>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH net v6 3/3] igb: do not split AF_XDP zero-copy frames over
 several Rx buffers
Thread-Topic: [PATCH net v6 3/3] igb: do not split AF_XDP zero-copy frames
 over several Rx buffers
Thread-Index: AQHdcakNwPgs9FTQsEys1XYyFZRXXrcqAR6AgAzZNdA=
Date: Fri, 20 Nov 2026 11:06:54 +0000
Message-ID: <AS5PR05MB11020F54567712787EE6FF1ACB9782@AS5PR05MB11020.eurprd05.prod.outlook.com>
References: <20261111-igb-rx-ts-fix-v6-0-ba5b9903859c@aweta.nl>
 <20261111-igb-rx-ts-fix-v6-3-ba5b9903859c@aweta.nl>
 <sashiko-outbox-210542@kernel.org>
In-Reply-To: <sashiko-outbox-210542@kernel.org>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aweta.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR05MB11020:EE_|MIWPR05MB401878:EE_
x-ms-office365-filtering-correlation-id: 834067fa-5029-4358-b4c3-08df46f66309
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|6133799003|18002099003|22082099003|4143699003|5023799004|56012099006|261026140227099003|261102123227099003|261026121527099003|10067099003|261028144727099003|261021121427099003|261022105027099003|261022075727099003|38070700021;
x-microsoft-antispam-message-info: ye/OqLYUyPmzb2/3PTthFLSViIV0k9cjUZQtteKL9UNWRy/LKaeN8nvKwt7Izc6A/udfyWdgVvGl7eHe8Sxv+NDHp+F2UTl0XGtyfzCNYJkRPMjDTO5IFC0XOwerIEgC0nIdVojkkF7rJC1hJ/ahgqbtfGUN3NA7jAtjcm/WDXhgakqJvh9cgdzev9NbVbYOhYhC4bgH9725RzYVnV3/Jy/rtsYVD3EqpaXwtmxoTAcyqos5SVBBwfQwjxKWCtrMt8FQ8SGUMyVj27lc4/qHdpCnR4sltsmLhPBK5aG2KpzC0Zm1gqtnEs3X8XdHUy55zuznOJU/p0UFxkXL4toErS2Dqt4LIPyNzkTh/KKGxK+uNR1Jo3ugTALidiGknhm4Zy4qx6C3beF5GJUxe9EfTB0ntGheH6EgUXlpIj+R2mKaZxtiEbGk9/iT9pidBjkX6sc+H86fWEWHXZSPE2ew+MPTLYFcCCHciBpYEnbzOuSt5fuqFmyjYq0Yp3k2UjRY2cI9xpqvURDyR1O7/ckaw+n9nyREWEZqQdtddWImrQb74oPxRfkNiFG8AtIgAFJ4djRTJIzm+J7Z8s+24Oiv/kygC0znwf/FZjlozGkrGoBdgIh1dZGNWAPeIhsi5MPwgVSD8oQH0jk6Y/CKBPCM7HpAuy37FAvX6ECOmlmGBmy0bQZXqZ6XM99EICltqhAbTLFLeKkJSSbqqEnHOxZbtQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR05MB11020.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(4143699003)(5023799004)(56012099006)(261026140227099003)(261102123227099003)(261026121527099003)(10067099003)(261028144727099003)(261021121427099003)(261022105027099003)(261022075727099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXhzT2x6TVR3b0pyZkJwejVsb29ONHplVUZiV1Niazl5ZzNtYkZWSDA3T1pW?=
 =?utf-8?B?cDlQTDR5c0R4YUtLVlpLbnNuZ0dWaHFROVJvT3I3SXFkamxsL1FsZW5ycnR3?=
 =?utf-8?B?ang2YzEwcSttU3I1Z3dJOWhrODZ2SUlmRDYzZWFXRkFmZkRhMTMxb3dUN1A0?=
 =?utf-8?B?YWtaZ3pOSEE0NjBhcGw2dndUbEpnQ1FZMkc2NmJPRlZuRTN3ZzNvRzZ3SkJz?=
 =?utf-8?B?WVN5VzhiaStYRGwvMHRCRURuRU5FQWlsQXRWbzU1Szlmcll6ZE95R1hTa2lz?=
 =?utf-8?B?ZkxZaUdkQjBwdTg1VUo0V1ZrN1RrS2VHNjVycXh6bEVaY29WdE5WSklaSUtq?=
 =?utf-8?B?cDJUMENBZit3NENxNnNRczd5MHVqdk9PZ1cwTmtEakQxVTBUYmJ3NDZiQjVP?=
 =?utf-8?B?eHc1MHMxMTA3aTVuY0RaV0M1dmhwaThpYm83YlA1TjJ3S3Q4RHFMWVZlWHYy?=
 =?utf-8?B?dWJPd2lmSDFBcXpRV2NyMmN2UDdSZmhCWGhsSU5SZlNOZnlZdXQzTGdjSXhB?=
 =?utf-8?B?cWdQdUp1eWNzNlg4SURJTmo4OFAwYXZjYzBlSGluYXgrY3lRTWMvYi8yZzBD?=
 =?utf-8?B?M0RtaVpPQy84OW4xYm9BbzVMUW5wTkwxMlNSMnRuVWI2Uis2UzhYOFJST0dQ?=
 =?utf-8?B?a0dueFI3b2dqeTFlUklpbDltYndzVDhJLzFoY3JXbnJwemdrQy9teWczTnZo?=
 =?utf-8?B?M3hYVnlKbUV4SWdtSk1IUGdzYVl6ekR3Ym1Fd0pMT2xVSm1oU3djbGZvcThr?=
 =?utf-8?B?cXhoOHF5cy9iRTFqOFlOb29LNGh6aEd3aXVGSk9aTzFsa1VFYXQxcU1iM3lM?=
 =?utf-8?B?a0NCZjVqT3h0akxVQ2pycUhaLzhCMnhGdEF3MWx0cml4ZHN0a3V4SWNPN1B3?=
 =?utf-8?B?RlpzWmNVajJ1WElka3RKTTVDM0tQeVdzZC94OVdFNWhPTVNqVFMrcmxFeGFD?=
 =?utf-8?B?cktqWEhnVXZnUlByTEUrWUdCcEdoR0FwYlZvZWFlMzJncGtPekR6TG9ZMHo3?=
 =?utf-8?B?b1oydGVJR3VURFFzMnA5ekp2eGtJT1FlT05WbWVEQ1hLTTBZdWIxbXV4eWFp?=
 =?utf-8?B?ZkE2THlrc1lBOXh0WEt3eGpDWXVveTk5a2FsM1crOFhLeHF5cVRpbkZwdThE?=
 =?utf-8?B?WFBpMUpXL2hxeGZTMUFiY0dJbEIyRURHT1F4ZkFkc1pGUTlCMEZQelZpZU5X?=
 =?utf-8?B?SDhBSHB4U0JEUWRhbXZ2SC9xV2pNL0NGZmZGdGJTRmtaeFBkcEQ0WWJjby9v?=
 =?utf-8?B?L0xUaHBPa1ordUdhc3RBV1REdllZMzVJSkRvS3dwWk1FN2o0NTdyWkhVR01N?=
 =?utf-8?B?WVNqNlU4dElIRERKeGFySElOajB1cHoySGFYaXZQNnQ3RU9OVEY2MzFIbEVl?=
 =?utf-8?B?V3RkOVJHb2VCL0hZK3g2dlczQXA5SGQ3c0l1a2ZjRTgxREJxMDU0b3RGQVAw?=
 =?utf-8?B?NDZ1UXZmS2paeWhkOEZ0cGsrU2crRTQyMjA3UGxidHZqNlFlbWNua2dFUDB6?=
 =?utf-8?B?RDBKSlA0UmZKTzhMWkxMbnZqSmRzTkYrNHBJRHhHVDZvRjczWTQ2Um1xWWNr?=
 =?utf-8?B?RXpWRnFCMFNIaFV6TW9oQ0VKQXloSVFBRzJacE9uTitZZ0xGUEp2QlVDYko1?=
 =?utf-8?B?S0d0UlBlRWFpR2syNjh4VlBFTUtsN05KajJXZkdNd3lWY3FQaXFxdjlOWWtv?=
 =?utf-8?B?ZG81NzNmY2p6R2l3MHFjSVdNWVZoWTg4UVQzQkphdTN3Ymdtc1ErekphV3Zo?=
 =?utf-8?B?ZkFNdjlqV2hzakQ1RkZwTmZsUzRjQzlSWHBMTmFxNjlNelk4NnZzUDZPcy9s?=
 =?utf-8?B?bTR2eDhiWmFPTUQ0SUxXeUhDckM4Zmc3NWozbDIwU3lPMFZqQzVVcVVORVBw?=
 =?utf-8?B?QXYyVnlQSUM3Rk90RE5qb1NQTUxlNEgxUHp2djg3dTB4KzJCem1HVkx4UG1s?=
 =?utf-8?B?SVNUNmFCd3cvWlNvNlZ6SkJSZE8yMloxbVBnZGkyREhVY0lXeE9MQmhoeWNJ?=
 =?utf-8?B?T2hxYlpVVU9OUmlEM25IenQ1UldrancwRHBpUWlqS1I5L1creXdxZWx2dG50?=
 =?utf-8?B?Nno5eldnbmtLZ3Jya2hGUEUrc0w5TFNULzdERzFIbnNDQ3Nob1IrdGhwaHI4?=
 =?utf-8?B?QmI4ZTQwTEs4N3BsTWNmOFNmQWFtUlZ4MHNETk1IRyswbWtxS1VtTklybW5F?=
 =?utf-8?B?V2JtcFowRGtRUVI0RHRHLy9vRmM3TUZQWGNkZE5CVVEwNUx4VXpWODRPb0Jz?=
 =?utf-8?B?MFp0MGo5QUltbzdtR094VU9VTTVIMHhaTkdHd3h4SktjWm1uRFVVU0N6YS91?=
 =?utf-8?Q?ZyaWuORejxTuyDOphY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aweta.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS5PR05MB11020.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 834067fa-5029-4358-b4c3-08df46f66309
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 11:06:54.6958 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6546512a-ba20-41bf-9d8d-c076dcbf6fd9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UduvjLjlzJD3D1yjt5RJUKBto+5oK0Yb7wmzMlqj421vytkh/Sh0DzqJDj6ON/EZadbTxgnlQwrYvg44FtkNbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR05MB401878
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

PiAtIFtNZWRpdW1dIGlnYjogUEYgTUFDIGZpbHRlciBjbG9iYmVyIGluIGlnYl9lbmFibGVfc3Jp
b3YoKSBiZWZvcmUgWFNLDQo+ICAgcXVldWUgY2hlY2sNCg0KUmlnaHQuIGlnYl92Zl9jb25maWd1
cmUoKSB3cml0ZXMgdGhlIFZGcycgZW1wdHkgTUFDIGFkZHJlc3NlcyBpbnRvIHRoZQ0KdG9wIHJl
Y2VpdmUgYWRkcmVzcyByZWdpc3RlcnMgYmVmb3JlIHRoZSBjaGVjaywgYW5kIHRoZSAtRUJVU1kg
cmV0dXJuDQp0aGVuIHNraXBzIHRoZSByZXNldCB0aGF0IHdvdWxkIHJlc3RvcmUgdGhlIFBGIGZp
bHRlcnMgdGhlcmUuIFdpdGggMzENCm1hY3ZsYW5zIG9uIGFuIEkzNTAgUEYsIHR3byBvZiB0aGVt
IHN0YXllZCBpbnZhbGlkIGFmdGVyIHRoZSByZWZ1c2VkIFZGDQplbmFibGUuIEluIHY3IGlnYl9l
bmFibGVfc3Jpb3YoKSBjaGVja3MgZm9yIGJvdW5kIFhTSyBwb29scyBiZWZvcmUgaXQNCnNldHMg
dXAgYW55IFZGIHN0YXRlLCBzbyBub3RoaW5nIGhhcyB0byBiZSB1bmRvbmUgb24gdGhhdCBlcnJv
cjsgaW4gdGhlDQpzYW1lIHRlc3QgYWxsIDMxIGFkZHJlc3NlcyBzdGF5IHZhbGlkLg0KDQo+IC0g
W01lZGl1bV0gaWdiOiBza2lwcGVkIFBGIHJlaW5pdCBpbiBpZ2JfZGlzYWJsZV9zcmlvdigpIHdo
ZW4NCj4gICBpZ2Jfc3Jpb3ZfcmVpbml0KCkgZmFpbHMNCg0KUmlnaHQuIEluIHY3IHRoZSBjaGVj
ayBvbmx5IHJ1bnMgd2hlbiBWRnMgYXJlIGVuYWJsZWQsIHNvIGRpc2FibGluZyBWRnMNCmlzIG5v
dCByZWZ1c2VkLg0KDQo+IC0gW01lZGl1bV0gaWdiOiB1bmxvY2tlZCBWRiBzdGF0ZSBhbmQgZmxh
ZyByb2xsYmFjayBpbg0KPiAgIGlnYl9lbmFibGVfc3Jpb3YoKSBvbiBlcnJvcg0KDQpSaWdodC4g
V2l0aCB0aGUgY2hlY2sgZmlyc3QsIHRoZSAtRUJVU1kgcGF0aCBkb2VzIG5vdCB0b3VjaCB2Zl9k
YXRhIG9yDQp0aGUgRE1BIGNvYWxlc2NpbmcgZmxhZywgYW5kIHRoZSBzYXZlIGFuZCByZXN0b3Jl
IG9mIHRoYXQgZmxhZyBpcyBnb25lLg0KUlROTCBpcyBub3cgaGVsZCBmcm9tIHRoZSBjaGVjayB1
bnRpbCB0aGUgUEYgcXVldWVzIGFyZSBzZXQgdXAgYWdhaW4sDQpzbyBubyBwb29sIGNhbiBiZSBi
b3VuZCBpbiBiZXR3ZWVuLiBUaGUgb3RoZXIgZXJyb3IgcGF0aHMsIGFsbG9jYXRpb24NCmZhaWx1
cmVzIGFuZCBwY2lfZW5hYmxlX3NyaW92KCksIGFyZSB1bmNoYW5nZWQgYW5kIG9sZGVyIHRoYW4g
dGhpcw0Kc2VyaWVzLg0KDQo+IC0gW01lZGl1bV0gaWdiOiBzdGFsZSByZWFsIHF1ZXVlIGNvdW50
cyBpbiBfX2lnYl9vcGVuKCkgYnJlYWsNCj4gICBpZ2JfeHNrX3Bvb2woKSBjaGVjaw0KDQpUaGF0
IGlzIG9sZGVyIHRoYW4gdGhpcyBzZXJpZXM6IF9faWdiX29wZW4oKSBoYXMgYWx3YXlzIHNldCB1
cCB0aGUgcmluZ3MNCmJlZm9yZSBpdCB1cGRhdGVzIHRoZSByZWFsIHF1ZXVlIGNvdW50cywgYW5k
IGlnYl94c2tfcG9vbCgpIHVzZWQNCnhza19nZXRfcG9vbF9mcm9tX3FpZCgpIGJlZm9yZSBhcyB3
ZWxsLiBJdCBkb2VzIG5vdCBicmVhayB0aGUgY2hlY2s6DQppZ2JfeHNrX3Bvb2woKSBvbmx5IHJl
dHVybnMgYSBwb29sIGFmdGVyIHRoZSBmcmFtZSBzaXplIGNoZWNrLCBzbyBhIHJpbmcNCm5ldmVy
IGdldHMgYSBwb29sIHdob3NlIGZyYW1lIGlzIHRvbyBzbWFsbC4gQSBxdWV1ZSB0aGF0IGNvbWVz
IGJhY2sgaXMNCnVzZWQgaW4gemVyby1jb3B5IG1vZGUgYWdhaW4gZnJvbSB0aGUgbmV4dCByZWNv
bmZpZ3VyYXRpb24uIENoYW5naW5nIHRoZQ0Kb3JkZXIgaW4gX19pZ2Jfb3BlbigpIHdvdWxkIGJl
IGEgc2VwYXJhdGUgY2hhbmdlLg0K
