Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA93E606A338
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Nov 2026 06:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=wsAZo2wX;
	dkim=pass (2048-bit key, unprotected) header.d=aweta.nl header.i=@aweta.nl header.a=rsa-sha256 header.s=selector1 header.b=rIu740Vo
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E9684089E;
	Wed, 11 Nov 2026 06:46:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ms5nWnFT7HDK; Wed, 11 Nov 2026 06:46:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EB747405CE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794379585;
	b=Lle30L3JcIsAiFxDkPGL+UE1sNZACLWZzxS/OptYD2mMrKNhhZxiNpPAjGQzfoaFfvLi
	 yNRTu+p7wkLMGelKP1m+joeypg4awjyjV/kMD9Abmyw2TDZzh9TWryY0K/WZLIrWxPIgQ
	 MRXo8k1Qkb0zQ0GsLtg8OQH73B2Xv4n2BBg5DfImR0DpCx35KMVp7OA0xkOilpe4iZgKM
	 iZ7lMeeSeqVpFFTIhyV24qFjmsU0jKAog7zKrtd6V3RT9fAwE8BoEdPcRSlLVshfAdaKN
	 /vO5XfqZjriyHIL6By/Q1TIgZ38JeSmJI9593ao770Hw18fquLpUqb8FCTvK+6D7zTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794379585;
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
	bh=TzCUO3QhJa5k2QYl0Awnjro4woaaBs1luSOgWtMINqA=;
	b=FAmmjCpFwJGGupLTSJlvwKVA6Av2xYFwX0bjY5dFRF5Iddy3QtA67fgISBo4AU/wqHVa
	 HTt1OR9CzoCzNt1lNgnlZ9PSvqGXT1EodPGy+kUDccfeyN4m/Y0mFOXQD7trFYGguuRmC
	 fusPotJuXGnIWOTftl94ikyLxiINe30zSP0F8gsx5+/H45amwv6CT0iaPqILi4hVl1Nw3
	 qq1za8yC3oPwbgfMwv+MzleAbQkGIzR7hpNcBG6EKBgZ42cMwPa8Yy7rVol/HWfV8FN3h
	 raMS1m6Sz/hJunCBQ6mPcqTx5LHfmDZwtcq0RePR0JB83RopNgFhHkUdYzpYil4a4jQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794379585;
	bh=TzCUO3QhJa5k2QYl0Awnjro4woaaBs1luSOgWtMINqA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wsAZo2wX8W5rExew38y78jtn27Bmwo1NKBi/uR6KzL/4DkdMoQbmFtN542eDn8Fcz
	 tGMHkyiuMRsZAMSqYjhCcOXdm/x22axmr8JoylrrbiilgP9NADc93/QAQMjCdVEd9c
	 CEPpDtA5WhrHBiFgaZLXp1ZvgDS8KtEL736iuCcYdkKrc6vsZD0lZmVdHra267nXmh
	 N732jv8ClX8RduAjZoKvggv8JdBjUQlDi7m3EBKwY0b3GmqRVxP4tBcqqdNikcvLDy
	 u+Lz7SgMq2VtONjA6WhNDmEKxBbl3I80NpvgonfxObo+3rlTecHL3rNF06VWlSyZnI
	 JIkohwz0ZhK+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EB747405CE;
	Wed, 11 Nov 2026 06:46:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E09ADB4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 06:46:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3B04A81301
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 06:46:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OwJp1VyULmAF for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Nov 2026 06:46:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AED59812FF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=52.101.70.81
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=52.101.70.81;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=tkusters@aweta.nl; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=aweta.nl
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=aweta.nl header.i=@aweta.nl header.a=rsa-sha256
 header.s=selector1 header.b=rIu740Vo
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11021081.outbound.protection.outlook.com [52.101.70.81])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AED59812FF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 06:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aweta.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzCUO3QhJa5k2QYl0Awnjro4woaaBs1luSOgWtMINqA=;
 b=rIu740VoaprT7EYbZIQyM575h9RtqM4oAb9VTRjn/OmRxCwxkd8WyaFU6cvdA73+kNObJwKIRjfhCr5b0mzooFTcARQiHcPRrQV1+TRTd8BKxxQrXe2Jjui9L7R8pLg80Zh++hV/9GxWyTHFcZKwxBAwo58ByFvkbX3v/E3Ab8qIiYI0eaJHPMdBnIwrvLJtp+1X6LLuH0jbhPFBukCxjS6QdW8Ct1qOahRgLwbi9RWJ4I//MsfmIDa57qvbq/h6xM3ZpujZhNqwyKLZ/1fw5cjxsOScEEJDR2ZVzFiHIw8HwyRx0102exAGaljwo+lrAwyz8ez6AYUJvghoh3a8zA==
Received: from AS5PR05MB11020.eurprd05.prod.outlook.com
 (2603:10a6:20b:67d::13) by PAXPR05MB8112.eurprd05.prod.outlook.com
 (2603:10a6:102:de::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 06:46:18 +0000
Received: from AS5PR05MB11020.eurprd05.prod.outlook.com
 ([fe80::2dc4:6bec:d87e:3492]) by AS5PR05MB11020.eurprd05.prod.outlook.com
 ([fe80::2dc4:6bec:d87e:3492%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 06:46:18 +0000
From: Tjerk Kusters <tkusters@aweta.nl>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Sven Auhagen
 <sven.auhagen@voleatech.de>, Richard Cochran <richardcochran@gmail.com>, Kurt
 Kanzenbach <kurt@linutronix.de>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 Paul Moses <p@1g4.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net v5 3/4] igb: do not split AF_XDP zero-copy frames over
 several Rx buffers
Thread-Topic: [PATCH net v5 3/4] igb: do not split AF_XDP zero-copy frames
 over several Rx buffers
Thread-Index: AQHdbCdbBr9X87aFXEWAKMGPxXsLOrci1FyAgAWj4FA=
Date: Wed, 11 Nov 2026 06:46:18 +0000
Message-ID: <AS5PR05MB11020F41D1D54BA0D4AB080DEB9712@AS5PR05MB11020.eurprd05.prod.outlook.com>
References: <20261104-igb-rx-ts-fix-v5-0-bf4b4367129a@aweta.nl>
 <20261104-igb-rx-ts-fix-v5-3-bf4b4367129a@aweta.nl> <au9T4Y1rpxvuEuFv@boxer>
In-Reply-To: <au9T4Y1rpxvuEuFv@boxer>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aweta.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR05MB11020:EE_|PAXPR05MB8112:EE_
x-ms-office365-filtering-correlation-id: ad6609a6-1c1e-4cff-494c-08df3fbf7d9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|23010399003|38070700021|10067099003|4143699003|5023799004|261021135927099003|56012099006|261021121427099003|261102123227099003|18002099003|22082099003;
x-microsoft-antispam-message-info: bUKsNcNPgygbp9AEJ5oYUmFftW7BR8F/Wn2a/dv199C9507GC5l3nHibeDO8ivIAP+FgtKWn8A7th9z5q129bc0Jrnv5b6r7ugngnQsPB5vYQ4Xh1U/an+1qY4Q9T7mnLH5rau3P+usYZ1QpeYFTAunA9JycHVp/kAAq9jCAGWwinnnZ/6NYLCl9OUNxvktoHyLOJNRDeSVKxqk735Zek3OFoqQRifIw5O5rPhVeS59gUrsa/C8a3LQzbIf6Qwx+wwzyx9qPYMpBINItnoxxXwL3334KlPP6TGLQstLL5IdolLmEJHsn1iDX46AdNOaFo1JeDV7NIn/BqORoNaN5lF2yXs5ZTPy0H6Z74HcZ211krZPDvveDkFkiEiuU1w/e/XeiagfjDtl8HNKksC5pO16SR4oi/kDkFEz0LVNPacvM8Sf1N8NVRtSTMhq4EXQ8HMMG0NkbXYun/4UkztShzMWQwIqwGjiwQsS3C2P/FWt53p8LgiPEMAa2umr6ry3BPwzkfCLfVgpuVI4L+DnPQW5Hp2/QTPyPfx5TLOTloPWVgX3iKAM6tev5qMpUr4dFNhiErMxMk6HzKiHSeXhAGxO9SIrV7Io6CKJuJJUCteK3jhPLzUhTi6nOtfo+Ef4Onmbs8vFsvmvfgKVu0EhO5VaYTArGjfsJv+/7JGM6wep6deicOQSzdpAE5SGhrptB3w2+ZEU9N93YYJQtkR5qGiO6qYqIz0ggYsplUm1SGZo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR05MB11020.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(23010399003)(38070700021)(10067099003)(4143699003)(5023799004)(261021135927099003)(56012099006)(261021121427099003)(261102123227099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DHzVVm7gnYlVP60u76evDML++9z/3uqpf96pX8+WRlKVy48Mq6mXxknfuFGP?=
 =?us-ascii?Q?t+eBjubg9yj4dYw72Sz75LA1lxiEcSdpnbStDeMw/uEgb1qLnpD+B+ktx7UK?=
 =?us-ascii?Q?BZxnD4CEopz3/WI/ZqnskCsTC+vlzt/I0joQCyAngu3k1b8OvUYD/Gzef//R?=
 =?us-ascii?Q?h5p4+DgJlOf61LDBkO8R8bUb6P684sYrHif6RkKduH3T8/1fMNTDynwoxste?=
 =?us-ascii?Q?tWbl49+blD1ESLSDv3+djRkzHL7/9K+FBv+gCjdTtIM4/RM0pdOxK3FcyUdl?=
 =?us-ascii?Q?zh6eIWDDZnc2XWivn+xbud/VX14lv6BtQLbEJI7GMlWa0ISax/ByoaHQ54Rb?=
 =?us-ascii?Q?2y0dwsUjTOyj0Z3W9gWcEu5yr5LlVHHnwJ1sEIheLSB0B/oJls3W1kNlqOTa?=
 =?us-ascii?Q?iBYHWYAdBd684ohrrAdry00Vo61dwhjTxSA8oIN0F9I249MmivpLqvhm6qQH?=
 =?us-ascii?Q?kjW2Vkbq4+SNv9I3i2vbXVZr4yDI8rQIbLoOf+sCx9Ml2jLgJszj6Lo+Sq07?=
 =?us-ascii?Q?TUzVhrJ7nV43Vxp6/0ttLkQ70h/QZsMN8l4tIU1k+7zVf0d7cJl1Z0xoOUwW?=
 =?us-ascii?Q?KStZejgzjclmxfkmLruGZr+oRrQ0Z9udIKVdfDBxgSx6M1fTHLOiV/eob7x+?=
 =?us-ascii?Q?pLFXNgPM2wHETfFvm3Kkkg9ULetP5FwWqIkNEDx7BZ1t6+3IEKbEy/7kElbP?=
 =?us-ascii?Q?th9RHRywLlJD0K1N06wYfUGvNoI+ifzrlDH1j++IqTlUyBpxe8CwhVNeaOK1?=
 =?us-ascii?Q?ZkjMXMqEcc9f54bnRo4IXSZF3NAzerjJ7D1fD5nzWvzg6AdnUc0a6tCrKhLn?=
 =?us-ascii?Q?4JeyzRcE7UNzlo/NttD3WLhDyUrQYXEYZzjrVKHnwh2cMwESrGq2zth5Bbtx?=
 =?us-ascii?Q?rp8G7pImAdOSB+FDmoWuv3tvtjzYMWb9FOD+OaSz5u53A84i+SsbAde6L1Cr?=
 =?us-ascii?Q?dFjbasCrQ0J6ajXdYotjlLT1E779BwXDWocdXs98hZWZVsuYIcxchEKDKMg1?=
 =?us-ascii?Q?7HmHMIr9sm/l91yILxFQXCROAf8x1mLewbHoNrYO3umPv483Z23yE9bSbR89?=
 =?us-ascii?Q?6Km0Yp+2ixWJmIkILzo9/lIFDU8l4k4jjrCna7mVJug4XZVh4df6/NaUos42?=
 =?us-ascii?Q?hLOp+ScZlnqEmoBJTQXCp22fh7YF67m4QiAlnTRJUrVzDlwH1MGVfqW/6wrt?=
 =?us-ascii?Q?AooHP9lSzhEguzCWlBgBtF/nJKwyIi5QX0TtyOSwJE2RqsO9CE2Dbp5JAt46?=
 =?us-ascii?Q?gQGDrGMEzy+y3TJ3SE4Fp1/kPkm+VC7EVkL+ykZjGNqPGWSmS/phZUstcqzl?=
 =?us-ascii?Q?4yLO33/4b2CMtxm1sGwRzPHcSUb/0mBFTVwnkblCVZsp3KhiJ/N/YSYXxbTV?=
 =?us-ascii?Q?actEPJ4OMtNfCr/P+HQ1kZSBg5pkzN69YGwqedKwr/B6a0bgRcFMZfp/noBV?=
 =?us-ascii?Q?abCjycpglkzS28kQUR7lngEiUV0umhl9iUYTfQXU27SwMldhkLyyNWFXjH42?=
 =?us-ascii?Q?ACRG84OSYXdQK9bjJQ91BZ1T/rDNhqnLt1TqExezTnqe/WW3jLQM8qkun+R+?=
 =?us-ascii?Q?ZgxmdaHXipEfoORVlBOd2MzV2mlyLq/aNk+wX333wURRFWTPThzr2V7/A8pS?=
 =?us-ascii?Q?T9gIVpHOQN99LOXrtD9/wzwIkj8a5qYMZ3tfXNgZktaimFTcail4Cu+rdJGq?=
 =?us-ascii?Q?Sx6ZOHCNN3mSpDb1DLu9PCFosaouwkeabing5FZpu0vzG53E?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aweta.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS5PR05MB11020.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6609a6-1c1e-4cff-494c-08df3fbf7d9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 06:46:18.8314 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6546512a-ba20-41bf-9d8d-c076dcbf6fd9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mCduwrgkSw8RYGcUbLxtf17iRd2mnw1o2TrF1DYMdhyZYT+lZr+j8/ua2TMOS0gq5mJXfKA5luSTdR6Flc7SFw==
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> I would rather return -EBUSY when enabling VFs on queues with active
> xsk_pool. Seems igb sort of steal queues from PF?

Yes. With VFs allocated, the PF keeps a single Tx queue, and one Rx
queue on i350 or two on 82576, so a pool bound to a higher queue loses
its queue. In v6 the VF enable returns -EBUSY while an XSK pool is bound
to a queue the PF would lose, as the core refuses ethtool -L in the same
case. igb_xsk_pool() keeps its frame size check only for a queue that is
hidden in another way, such as after a fallback from MSI-X to MSI, so the
NIC cannot write past the XSK frame when that queue comes back.
