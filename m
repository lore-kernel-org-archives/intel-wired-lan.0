Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC57E60A2636
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Nov 2026 11:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=tCs7r5sT;
	dkim=pass (2048-bit key, unprotected) header.d=aweta.nl header.i=@aweta.nl header.a=rsa-sha256 header.s=selector1 header.b=kGRZGNXA
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5C2C40DE7;
	Fri, 20 Nov 2026 11:07:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9sK59UnuCMMN; Fri, 20 Nov 2026 11:07:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9986340DE8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795172831;
	b=Bk5Q6meF82pKVmqISuSrri7WHlPERwFnSMdWSCeFQPzgJUgPDUS9b4KGtMB3eLQtAguR
	 gvLsZw/ZgTyFNa2r8N2FkZ+9ddHBNZXKXDxHrbWV8GMuU0k50WOUfM4plcdSfzVf7zL4C
	 QbqqoaVNm7mxD1u9g0ZoAdWyPTCTz7foJbdR++3sXqZCCWB4ZTT6MVesF2UAmjkFI5S90
	 Dt4QG92LjBqEgCoPfcR3CehKqprALcqL+E+tOeTvr1L1mf327soQOgDRgEIAXvBT93/Bi
	 +A8okSpfgs0bMgPHzWb/7dwBbCzvg0Gf31H5q9p7yf8QZ1SKujlwtGPOx9Lp8v7t7tg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795172831;
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
	bh=sLifkeMnIp10/gO0G42O8cgqX5MEPqoE19Io7oemOIo=;
	b=DkTpulubO34w76OCtha2V+PSGB4iCwaYookG/dqnBCnGRDWvojFEIxWbqcWQEh0Ya17g
	 7T/qofR0iBV02ZNeZ0hyjEtfd9BIad8TVwKeXVHT2T2bZWth7JWmOyvBl0fydb9U9hpS4
	 wOx2/n2Umjucf+AwPmhOjzbUuuJgteWteMumqbfqpVfP8gVQdkIgWiZxK299L/0aeURbO
	 q1tBY4UJj2f9FHIJLaqCQzd07ZbiztUvWQtsYX2IC8W1WqXxGjgTxXIHMa31s/Kw453Q6
	 J1alDX1QzBL8nNB8UBUX+jxG6spLI2MGlmINxB76TOy0fKTPm5Kg0lL2cNJr8fUl0nw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795172831;
	bh=sLifkeMnIp10/gO0G42O8cgqX5MEPqoE19Io7oemOIo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tCs7r5sTLYh+IL/+HkfahSe2VLhSvbioCNdOHg9okzQolSdOpPIqRKMu8pISc+LIB
	 Pqr19hZe7oAhNmv6YxfgMikVaBpCbp39HRCki9isW7ZbbqOpJv1/u4VhVGAwGKqnuW
	 DhCLhIH4NPKvAeVS6V0eshdzH/cM4/jth4gF3zuILbJ6lhsw0mUuE8gxXynLU2UVUK
	 PYwDQ53oTx/fja6qaMQGo3OHSNe/awkAXOlGsIcDPABG3PJXymbEo4s2xhEI32r+br
	 0kq4/QZMZx0xj+zO+xY6O7eXSqEULvu4TwdtgOhkrwVTAGoK545+7PJwxiaj8Gx891
	 T+pP/ghV7/3iQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9986340DE8;
	Fri, 20 Nov 2026 11:07:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3CF7970B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 11:07:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2DC946072E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 11:07:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pLiwg5DRzM5R for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Nov 2026 11:07:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A77B2606F2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=52.101.65.136
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=52.101.65.136;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=tkusters@aweta.nl; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=aweta.nl
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=aweta.nl header.i=@aweta.nl header.a=rsa-sha256
 header.s=selector1 header.b=kGRZGNXA
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11021136.outbound.protection.outlook.com
 [52.101.65.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A77B2606F2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 11:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aweta.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLifkeMnIp10/gO0G42O8cgqX5MEPqoE19Io7oemOIo=;
 b=kGRZGNXAQ9nsLeLNma5boaidyDc8dOL9pa9RBxCHuTeF+KEcMbdDOttcXBkBfoXWn61o4kZJ66bWysy+Cg6I4Zm4W4N3k1JDqlK5Rcvf6BaAfFR+v75KSkc1OMe4gydiFAvzkc2P7a30sVMAt+wYXUqsnTL6OgJapf12KLftnWYmMLwsW6+k4jGlG5lZ6tuqUG4o61xBu/PCLjPieDw7NEa6nzlMYcJyM54J+1gh9w7pVFCmOO6ByXTL2IM4ZtxT/7NocW/1JxbazWseF8jleOSYWRz1VAqeKWEW2fui6rk9p/Abc+JxDImkkDuteEfG4HW9nDMbYzhOQpm+5TtBrg==
Received: from AS5PR05MB11020.eurprd05.prod.outlook.com
 (2603:10a6:20b:67d::13) by MIWPR05MB401878.eurprd05.prod.outlook.com
 (2603:10a6:290:d9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 11:07:05 +0000
Received: from AS5PR05MB11020.eurprd05.prod.outlook.com
 ([fe80::2dc4:6bec:d87e:3492]) by AS5PR05MB11020.eurprd05.prod.outlook.com
 ([fe80::2dc4:6bec:d87e:3492%4]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 11:07:05 +0000
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
 <p@1g4.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net v6 1/3] igb: do not let XDP frames span more than one
 Rx buffer
Thread-Topic: [PATCH net v6 1/3] igb: do not let XDP frames span more than one
 Rx buffer
Thread-Index: AQHdcakNcmyK0Xj4XE6oHWfwUJ/SSrcu5x8AgAfzqWA=
Date: Fri, 20 Nov 2026 11:07:05 +0000
Message-ID: <AS5PR05MB110208F3B0AC6A7EFA9594A6AB9782@AS5PR05MB11020.eurprd05.prod.outlook.com>
References: <20261111-igb-rx-ts-fix-v6-1-ba5b9903859c@aweta.nl>
 <179473557433.2199510.15562599161772023793@kernel.org>
In-Reply-To: <179473557433.2199510.15562599161772023793@kernel.org>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aweta.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR05MB11020:EE_|MIWPR05MB401878:EE_
x-ms-office365-filtering-correlation-id: 3687880f-3e54-45ad-6fd9-08df46f66986
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|18002099003|22082099003|4143699003|56012099006|261026140227099003|261102123227099003|261026121527099003|10067099003|261028144727099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|38070700021;
x-microsoft-antispam-message-info: ecLoU4i6QLbS9mQtrvx0lgkuoe9/KvJ/sJAl7jLnj/+lf+7ZbbzINm7iG6QMvX+qBpsbeQhvwxHzS0tuzBbTN5O8QTzeqNZqFAzsoqcCI3p/CPfONBCcU2i+b1vA1vXCz5BHF7h9n0G7CjC8M3LUHXW/hQr6suUDIsLtYKsFUI8HgzcA8z7ciJzwXx127JwWaP8Mm5WE/xih4ojyEEVRqBBo7aO5ZwSHmgKiM50WA1DOY89VWoZD9o/LBeOHbzypMx6oDV4eRxcDU+V5EbMTX4RNuH4yo2VmTiVZNhE0E2KoatIs9B7yTcaC8hKYEbb8czfArCBj8d1o5MTdCEmJUyUqW9HAT3kqOBJvoq7mLWzeRbxkORgOcj/iLD2e5XsyTrl41KDHl1iI5A7ju7xgWwMb1ke6sv9uhBr3Gk4o9PTyc9HLZEOtC4tqLm4HKj4ULBZiCJP/bh18FIJmajOK0is5n6g2VpOXB+6XtnXpn6EZ1fZJoOoRQU4lYw0mTMC6AeT8CX40hy7neQhckZenpiW6+TGV4fizWCpUebEZQLA6vgedPVYOKeQSoM+ACEoYP0Q1itaqP4Cq9jxRDf5AdvYVovurFfwgb82M5PpolFbgW0k5K6OY1iW5NnwORy+RhBBEuu5iuKm6v1unJqtTl61+qSBmCUmZDusFbGkDkB8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR05MB11020.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(261026140227099003)(261102123227099003)(261026121527099003)(10067099003)(261028144727099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHFvbXFqdVVhancxOGJ0dTlBYUk0em1SOHdhMHN4b1FUZmhqVTU3RXl2Ung1?=
 =?utf-8?B?NzNsWnQxVnJSV2J2RTlDeHpWbDJxb0xlRUVlc0dLK2RUa2R0UGhyTFNWaWQ4?=
 =?utf-8?B?Tyt0TGVBUjZhSmpXSTdIanZhcXFOSnBOaklxK2o3cGtlamE0dFB2QjVQbklF?=
 =?utf-8?B?bDl4QnVqRUp2TmM0L3pnN055dzBTaUhtcmpuL0NQRlRPYkFZd1Erc3dSVEpU?=
 =?utf-8?B?VjI5VTI0cTdJYUV4T1RYSld4YW9aKzJrOWN4ODJ3WnhMWWtMNllXZWw5Vlpm?=
 =?utf-8?B?M0YwNXVjeU5Rb0lPYXQxWFNSVWNENXh1aVUrL3hPcGhVVVVHTEpoVEtYTFlD?=
 =?utf-8?B?QkZHaU5SZ0xPby9JOHRDSGhTRENibXhhZzZoKzlaRHFybjB2QzE1UGxuSTl4?=
 =?utf-8?B?TDA4bGw1YUdNTWdJL3FtQjJlZFd5VTdxN1NwUXpWRGNjWCtFbHRrbkRXUXZk?=
 =?utf-8?B?eXduclhKdmZpVmsrOHZrVmdOMGZTK29DWnBNeGI3QW5rc1NhekVwZnRQb05p?=
 =?utf-8?B?U0NPSTM1NGZqeWNJUUM3ZHdWRldaajJwREZMWTRxQ3piWVZ2eUgvdnpOYkpq?=
 =?utf-8?B?ejhzYVlSV1h6V0dXNWJ6dm00a2lxU1UzUXFET3BhalZQMU5EQzd3VkpxRW1E?=
 =?utf-8?B?bHNQLy9pTDY5VGtlaUhTd0JWTEdjdXVJU3VlUU5nTWpZMzRnY0UxUm82VjRj?=
 =?utf-8?B?WEowRTdVaXNLTEdRUmp1cko3aUlXY1lkUWNYSGVkNmEyTFN1UmNaUnZwNEVy?=
 =?utf-8?B?YzV4WXZVZGwzR3FQdHZkODFFVk1EbHpHWlNybExEVjFkZVg3MFJjaEdBb0VE?=
 =?utf-8?B?N3VTRW5Yei90a3VERlg3TDU1bG5GTWtTT1hJSmpHT21SWkV0UFRSUDlzeHNi?=
 =?utf-8?B?V2dHMU1MVGFMWWRUaUVWWHQ5TlorcWFiUWd3UWhOZ1hlSGhXTlU1NWxqNEJB?=
 =?utf-8?B?SHJNdTBYclhGc1ZELy9YQ2hvZWRZcXMrWjdJejdJcElBQzdnNW9mb2pFcE8r?=
 =?utf-8?B?eXdQcy9xSG5HdFVDUktPQW1kU3NPbkpxd2pwUXU5U0thZUNyNDMwS01jS24w?=
 =?utf-8?B?OTFlSG5NaHVlVjByM0xBMExYRnZ5ekVBS3Jrd2E1V1BMekdWVDloU0lxNmlh?=
 =?utf-8?B?aVJ4bDBRR3dEYk1BU1J1dXpWcUh2MU1oY0NYekFTV01jSnJzMmhSbW1VRkZp?=
 =?utf-8?B?bEhNTGwyemdmWGhYZHFZMDRFTjZzOGtHN1ZraUk4c2xyQzZSbjhTRHptL1RG?=
 =?utf-8?B?RENLSU1DSGNrME9MTHMrMEo4SE44TzdONzFYWGVmdnZNNFBMbzNZaWJtTUdu?=
 =?utf-8?B?eE9mb1hJdjdKV01FY3pFL2VGekZJNjFQNHMzWUJzK0d5NTE2akUwTlgvNzhE?=
 =?utf-8?B?ZDlXUEFvNWpjMkpQa3MwanZHVjY5cHJ4NXl3blFCbTRmbk92TGRuOWpEc29q?=
 =?utf-8?B?ZW9IU09VazYwN2hORG92cXlhUU0yYmhGL0Vpd1pMMGVRRDlBNTUrMEp2MDgy?=
 =?utf-8?B?TlhNMXNIUmptakpXK2h5Ty8rdmRqc1VEVlJjUURGdll1YWp0QVlhdGVwVzBS?=
 =?utf-8?B?UVI1VjN2YmhGd1N2L1NzQ25EYkowd09RQ3pVaHRPK29EYi9ncWpicE1rZGNM?=
 =?utf-8?B?M0VhTFNqU0RySnRZYW0xR3djYkFndXBnMHNlSVBZRjduVmVVSkF6ZlFwRHBa?=
 =?utf-8?B?QmdQRE1sdzdWSHMwZnFnVWFOUFpmclYwZHZmRTFka3ZNc0dGbVpXckFwVUlH?=
 =?utf-8?B?b3FjN0kycGpmaFpRMmNSSWdnSVBSVmdPVWxmMkt5WFRJaExFZi9XcnlHQlg1?=
 =?utf-8?B?UHRqVEZ5Z2Y5RWxhME1WMXJPdkEwZ0c1NnVPdzVZWFIvanQ5YkpkSXduSWI1?=
 =?utf-8?B?WHBvRzYrc0QvSkZCZFdMQlhjOCtNM1dibmVnbHZTei9aL01vUVY0YTVSdXNU?=
 =?utf-8?B?WkQ5aXVSM1lMdHhZRzRwZ0hKdUhsRzcrbzFUWHEvSDRoYk5SNTdZMDNMMmVl?=
 =?utf-8?B?YWNOdVlwS1ZKRG1yMUk1anNldU0vMnJWRnlETWY4QXZzMU1EN0pTNXh2d1U2?=
 =?utf-8?B?SG9qb2xXMWVRbHYvdnQ2TVpnd2lkR25RamRQWU5pWGpUSURHcWxxNXExajJL?=
 =?utf-8?B?WHRXc3dVVHg0ZzhQZnowR2RwZytOOWFjU2xiRUlFczNEeDFVRW9sVlRWRUt0?=
 =?utf-8?B?SHhzVTNvZENFYThIN2dvODV0OFNFekNHQnJ2eFducjZXcWlzMC9hK3VrQWtk?=
 =?utf-8?B?ZVNTbm1BVVRBY0xOeTFuVDUwbWx1YmRIcVpHeUc1K1d0Zy94OTVXT2lwNUt5?=
 =?utf-8?Q?y2NrjYUdOhbADYKA5v?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aweta.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS5PR05MB11020.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3687880f-3e54-45ad-6fd9-08df46f66986
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 11:07:05.5770 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6546512a-ba20-41bf-9d8d-c076dcbf6fd9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Bl1x1fjj7FsGEWtJEkOFnYvFYqeUabuyokhl1pH8O4u6TH/EzCN8y/SY0SYchb1GDv9lPNCC8GXdu0MUcA5Dg==
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

PiAtIFtNZWRpdW1dIGlnYl94ZHBfc2V0dXAoKSBub3cgY2FsbHMgbmV0ZGV2X3VwZGF0ZV9mZWF0
dXJlcyhkZXYpIHdpdGhvdXQNCj4gICBmaXJzdCBjaGVja2luZyB0aGF0IHRoZSBkZXZpY2UgaXMg
cnVubmluZyBvciBhd2FrZS4NCg0KUmlnaHQuIEluIHY3LCBpZ2JfeGRwX3NldHVwKCkgcmVzdW1l
cyBhIHJ1bnRpbWUtc3VzcGVuZGVkIGRldmljZSBiZWZvcmUNCml0IHR1cm5zIHJ4LWFsbCBiYWNr
IG9uLCBhcyBldGh0b29sIGRvZXMgYmVmb3JlIGl0IGNoYW5nZXMgZmVhdHVyZXMsIGFuZA0KbGVh
dmVzIHRoZSBmZWF0dXJlcyBhcyB0aGV5IGFyZSBpZiB0aGUgcmVzdW1lIGZhaWxzLiBUZXN0ZWQg
b24gYW4gSTM1MDoNCndpdGggdGhlIGludGVyZmFjZSBkb3duIGFuZCBydW50aW1lIHN1c3BlbmRl
ZCwgcmVtb3ZpbmcgWERQIHdpdGggcngtYWxsDQpyZXF1ZXN0ZWQgcmVzdW1lcyB0aGUgZGV2aWNl
IGFuZCB0dXJucyByeC1hbGwgb24sIGFuZCB0aGUgbGluayBjb21lcyB1cA0Kbm9ybWFsbHkgYWZ0
ZXJ3YXJkcy4NCg0KPiAtIFtNZWRpdW1dIGlnYl94ZHBfc2V0dXAoKSBpZ25vcmVzIHRoZSByZXR1
cm4gdmFsdWUgb2YgaWdiX29wZW4oKSBhbmQNCj4gICB0aGVuIGNhbGxzIHRoZSBuZXcgbmV0ZGV2
X3VwZGF0ZV9mZWF0dXJlcyhkZXYpIHVuY29uZGl0aW9uYWxseS4NCg0KUmlnaHQuIEluIHY3IHJ4
LWFsbCBpcyBub3QgdHVybmVkIGJhY2sgb24gd2hlbiBpZ2Jfb3BlbigpIGZhaWxlZC4gVGhlDQpy
ZXR1cm4gdmFsdWUgb2YgaWdiX3hkcF9zZXR1cCgpIHN0YXlzIDAgYXMgYmVmb3JlOiB0aGUgcHJv
Z3JhbSBpcw0KYWxyZWFkeSByZW1vdmVkIGF0IHRoYXQgcG9pbnQsIGFuZCByZXR1cm5pbmcgYW4g
ZXJyb3Igd291bGQgbWFrZSB0aGUNCmNvcmUncyBYRFAgc3RhdGUgZGlzYWdyZWUgd2l0aCB0aGUg
ZHJpdmVyJ3M6IGRldl94ZHBfaW5zdGFsbCgpIHdvdWxkDQprZWVwIHRoZSBvbGQgcHJvZ3JhbSBp
biBpdHMgc3RhdGUsIGFuZCBkZXZfeGRwX2RldGFjaF9saW5rKCkgYW5kDQpkZXZfeGRwX3VuaW5z
dGFsbCgpIHdhcm4gb24gYW4gZXJyb3IuDQoNCj4gLSBbSGlnaF0gVGhpcyBwcm9ibGVtIHdhc24n
dCBpbnRyb2R1Y2VkIGJ5IHRoaXMgcGF0Y2gsIGJ1dA0KPiAgIGlnYl9zZXRfcnhfbW9kZSgpIHJ1
bnMgd2l0aG91dCBuZXRpZl9hZGRyX2xvY2tfYmgoKSBmcm9tIHNldmVyYWwgcGF0aHPigKYNCg0K
VGhhdCBpcyBvbGRlciB0aGFuIHRoaXMgc2VyaWVzLiBUaGlzIHBhdGNoIG9ubHkgc3RvcHMgaWdi
X3NldF9yeF9tb2RlKCkNCmZyb20gd3JpdGluZyB0aGUgcmVjZWl2ZSBsZW5ndGggbGltaXQuIEkg
bGlzdGVkIGl0IGluIHRoZSB2NyBjb3Zlcg0KbGV0dGVyIGFzIGFuIG9sZGVyIGlzc3VlLg0KDQo+
IC0gW0hpZ2hdIFRoaXMgcHJvYmxlbSB3YXNuJ3QgaW50cm9kdWNlZCBieSB0aGlzIHBhdGNoLCBi
dXQNCj4gICBpZ2Jfc2V0X3ZmX3JscG1sKCkgdGFrZXMgdGhlIFZGLXN1cHBsaWVkIG1zZ2J1Zlsx
XSAodTMyKSBpbnRvICdpbnTigKYNCg0KRml4ZWQgc2VwYXJhdGVseToNCmh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2FsbC8yMDI2MTEwNC1pZ2ItdmYtcmxwbWwtdjEtMS03Mjk2MjFiNjBlZWVAYXdl
dGEubmwvDQoNCj4gLSBbSGlnaF0gVGhpcyBwcm9ibGVtIHdhc24ndCBpbnRyb2R1Y2VkIGJ5IHRo
aXMgcGF0Y2gsIGJ1dCBvbiAyIEtpQg0KPiAgIGJ1aWxkX3NrYiBSeCByaW5ncyAoUEFHRV9TSVpF
IDwgODE5MiwgbGVnYWN5LXJ4IG9mZizigKYNCg0KVGhhdCBpcyB0aGUgZmlyc3Qgb2xkZXIgaXNz
dWUgaW4gdGhlIGNvdmVyIGxldHRlci4gSXQgZGF0ZXMgZnJvbSB0aGUNClhEUCBzdXBwb3J0IGFu
ZCBuZWVkcyBhIGNoYW5nZSBvZiB0aGUgYnVpbGRfc2tiIGJ1ZmZlciBsYXlvdXQsIHdoaWNoDQph
ZmZlY3RzIGFsbCBpZ2IgdXNlcnMsIHNvIEkgbGVmdCBpdCBvdXQgb2YgdGhpcyBzZXJpZXMuDQoN
CnB3LWJvdDogY3INCg==
