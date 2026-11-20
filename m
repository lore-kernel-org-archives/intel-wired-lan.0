Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C90760A5BE0
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Nov 2026 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=2Yjn6DKQ;
	dkim=pass (2048-bit key, unprotected) header.d=aweta.nl header.i=@aweta.nl header.a=rsa-sha256 header.s=selector1 header.b=KS8f4ciO
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 267BC40DF9;
	Fri, 20 Nov 2026 11:07:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wExH64N838u5; Fri, 20 Nov 2026 11:07:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 80BC140DFF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795172843;
	b=nP+02XoI6rR36OuE3QqawiCbl8b8jg4pVm+WGYy0ASmxvxAf+3kSjelwwhA3rhh5EwVK
	 e36NMS98w7UVR2VqHjzYdY/tdDiVMUi+cQF3SR83Iav06mfXD7nH4OC0Y0oJxT9M8VJTu
	 LDHEalQyYkl7vIyVYccpFRCsFdZpFCipwSrBPxBoNOVe360HcmFy8r6LeLZEnRlLoIvbO
	 zwYlqNn93Rad+JL91sq2X+BBvOA+XX2OrEc0tq0q+ZkCJYEY/ZJWD/Ft22j9SNsOvRG9V
	 tWl5hJIXBrfzor8a1ShJ+laQW6dO0KA98Kgk/2gHMXeqw+ao3USacYAQ8WsCLyc9NMw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795172843;
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
	bh=KEQvRAcTyZLYEL61AXeUCCmn4XJnvv3DwjzprrKl8sI=;
	b=q39o31YPov1WQQ4040WyTuKE9gL3Nl6QwB0VeEdJQkt9VkUIG7AmZwLqGkO0hFaD4f1y
	 eoBN7WmL3o31ThRSGU8dZUrq84F6lpLNeEKnxJIySDNGMMrkIvVmP9zL1J7YVBMvTOkV/
	 UYR+B4VE1S82dnDm2pn50rvgBlxOAcBGu6QqJtiFAc/U0Gw0pxm3hzsO/5GvPp9vky0jo
	 3JtTJ+1UCZ0Qj36ze3yXYvMBzYIxA6MtkhVxYyK+WfzPeoHlGQNxoTTxajlPtV0B1MLnk
	 8y2X5Vu5d5liAOCbBbkqU9Tinx/sGMJT34SMtWrdcPBVMU5r3IGFHe4J/PP+w1noL4g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795172843;
	bh=KEQvRAcTyZLYEL61AXeUCCmn4XJnvv3DwjzprrKl8sI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=2Yjn6DKQ8nTB6jSXb58v0ciNm7fDzIYcn5mD8gzPH6vjQcnhTIzrtucIGzOqB5TgX
	 iAbTLJfcBaNSyeIqVQTDhYMA4vcn1kYbxMW3driXT+/vSAmnxaRLWEYOPJAcNkgYeK
	 B1cP1DT0r1vzIBTODSf+v/gyV7p/Pvw61615Cs5xfXRFV5JNnyKmdx/C+LuoRerLem
	 u8lSoeTLSddlu5N822qVzy5aQ1z/G0HueuVB1KTMDdPur1DnrOboM7HcrSzp1rhSxy
	 jw48teustw6uFULZlLvmOWvZ1y6eaW4JC5UirqrVXrjttYPweRD72Ge7w9y/+ZaBt3
	 ZB+wzn8aVZIrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80BC140DFF;
	Fri, 20 Nov 2026 11:07:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3027D1C9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 11:07:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 15E7C8168B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 11:07:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BcayOukRLJiy for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Nov 2026 11:07:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A5322815FA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=52.101.84.119
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=52.101.84.119;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=tkusters@aweta.nl; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=aweta.nl
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=aweta.nl header.i=@aweta.nl header.a=rsa-sha256
 header.s=selector1 header.b=KS8f4ciO
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11020119.outbound.protection.outlook.com
 [52.101.84.119])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A5322815FA
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 11:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aweta.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEQvRAcTyZLYEL61AXeUCCmn4XJnvv3DwjzprrKl8sI=;
 b=KS8f4ciO+VjhZ4Nl3nQtNAx8voB9xAtyBpwltHH2CszbfB78mJtukHKQ+4S41PHpMEFBFtx6Y6p/oZil2lkDLKlx5+meMOdx2OLKOH5JPjRJq4s5dWjzufZZz2K6maxoeNv1F6WXO//MSqnKBAdkbvY2HiLWJfJMJge2xeAMnlTEkqq3+9qrLzbW7pJGtun71AF2peAvTCKJeP+8oIp1AxOIn7tC7w21ggapVW0TXVfmE0NMWxRGJVs1Gr0i9Ey7XFQbQNaee6pZDfKeSUN2/MKJFkigKRZd76CTRGHK7AOYojjKFdH+Nb+5CeJPS1351zVtBeDiBX5iTgfumYS4wA==
Received: from AS5PR05MB11020.eurprd05.prod.outlook.com
 (2603:10a6:20b:67d::13) by MIWPR05MB401878.eurprd05.prod.outlook.com
 (2603:10a6:290:d9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 11:07:17 +0000
Received: from AS5PR05MB11020.eurprd05.prod.outlook.com
 ([fe80::2dc4:6bec:d87e:3492]) by AS5PR05MB11020.eurprd05.prod.outlook.com
 ([fe80::2dc4:6bec:d87e:3492%4]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 11:07:17 +0000
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
Subject: RE: [PATCH net v6 3/3] igb: do not split AF_XDP zero-copy frames over
 several Rx buffers
Thread-Topic: [PATCH net v6 3/3] igb: do not split AF_XDP zero-copy frames
 over several Rx buffers
Thread-Index: AQHdcakNwPgs9FTQsEys1XYyFZRXXrcu5yEAgAfzaTA=
Date: Fri, 20 Nov 2026 11:07:17 +0000
Message-ID: <AS5PR05MB11020A6B850A86A21A2B5E1C4B9782@AS5PR05MB11020.eurprd05.prod.outlook.com>
References: <20261111-igb-rx-ts-fix-v6-3-ba5b9903859c@aweta.nl>
 <179473557614.2199510.972066447270237709@kernel.org>
In-Reply-To: <179473557614.2199510.972066447270237709@kernel.org>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aweta.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR05MB11020:EE_|MIWPR05MB401878:EE_
x-ms-office365-filtering-correlation-id: 1a6b3540-dac1-4a87-5a9a-08df46f670c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|18002099003|22082099003|4143699003|56012099006|261026140227099003|261026121527099003|10067099003|261028144727099003|261022105027099003|261022075727099003|261009223027099003|38070700021;
x-microsoft-antispam-message-info: D3v69QyPfvlLwXWts2NQ12FNkIO/HmQczISqrDVuRceTBPifO2s+LVGCqjZh1xmYmDRojAcCGYAoh8mjHk7nVfRoT9yzQ11xxh0ULR4faw1enBYCzS2HNV89WSVcnOEcu8WD28QRiS9W5CHj0UQfBFlWW1OqWu91JdqIi7rOalCnGFZsO3dzCpSEZHS1ZjHSaXaL9c/EsdMptWmWgNlS6r7sNh8Hz7JG/Pf4tc9jHia7OMfFvWxZvzO67Yu9qSJP6CO/pSmP8OkOVY73mtZSxCjOOceaDozhFlhBNfF1Cc9vv++AJaaP6j0Fq9M/UAMXQ5wK4c2+t+SeFBfX0THqJk/haSj/V0aL1o9kn6A1RS1GHrnHmlvMSrDj/uRu7QPXd9ZAilO3Z8A6o2SZiRRCeFUaYtz9FEL+k3QpLbh1D0Rpc2TKisxV3MFKwUR9voAHQcfSCBYzpU8DMkjjxNZXw/+Ej4JR8a7oF850VI2mdoIPIURuPfzd1LDV31IdSrBiyluzgJxCFNyDvTuUMFb8/S/qESAF8qAZKzbaXnaaicdIt37lXEBsJzmvxsQsiVuKwL1cglqDU9tmnYugwqDFsD4ET94ecNPyiU1hpaQctCIGWDfZIbZY79QKor9LbBFBU6Jm7dx+da/9WXJ4sfSjqeGuZ8rZZGqyG7VQ++fl5HsrDkWS2jM1bxILGXD33UqaR/ZlIFs/TwlkpIL8VjsaM1K+LDovO9D24JfvBGl2th0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR05MB11020.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(261026140227099003)(261026121527099003)(10067099003)(261028144727099003)(261022105027099003)(261022075727099003)(261009223027099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGt0WVBDVk1sYVhxc2NUbk9GeWxqMFRkMzVjNXptMGNpSUVBQ21ZOTNmRjhi?=
 =?utf-8?B?ZzF1MmFRV1BsWTRMMURQcUQ5eEw0Q3Q2enhDUjc1YkQrRVQyVkdzVE1aNnZy?=
 =?utf-8?B?OEcyQ2hUQmJMbEZLTENLTEgxb0VqTFZnKzljZTdrQXJGcEd1NnhEemc3UUs5?=
 =?utf-8?B?K2lmN2h4eEY5N3N0LzQ4WWRORzh0NXNlY3Q2QXJMcGpXYStvUHZuNVZRNy9u?=
 =?utf-8?B?Y3A0aDVtOG1VaEVkNkF5UGV1KzU0ZUxHTG5BaytoRDZFV2RvbXpvVlMrSzdH?=
 =?utf-8?B?YW56M09KOHh6Y2FCdWRrRjZUSjhiYWhSUFNGUWd6WXB5ZXV0V0RPSWl5TE52?=
 =?utf-8?B?WVN5K1NEMUI3RGpzR3hramhGdFQwRm5aOU15YzdKeDZNU2ZqZUNxMlFYd1Bv?=
 =?utf-8?B?dVYvUnc0UVdESWR0cENGM0dLRHhZK2ZxeWlqZk9sRHMzZ09HaHA0cGFkcVo3?=
 =?utf-8?B?T09mVmI0ZVhjTU5oVmcreE5nTkE3MWxVUlN2c0t1S1dXbUcrTFlTSHdPeHNZ?=
 =?utf-8?B?emMzQUxoZm9tbldybnZXNko4SzZwQlRwa1o1a2gyV2ptQ0M3TmZ2NGN0U29q?=
 =?utf-8?B?bEQxOFVlYVo5TDlmUHNLbyt0UnVWVExncDJJUDlIeVlNSWlDbmQyaFhSVkNw?=
 =?utf-8?B?M0ZIQ3oyU2lSTnNUQWJkVGlTQ2FOVTZEdUlKQmx5bzN2Z082U1AyWnIzUUlR?=
 =?utf-8?B?ejBibDlkUEhxZG1YR3hCRkdRcUc5ZW9UN01XTlhiRE9heVRYSm5DQ2VGOUw5?=
 =?utf-8?B?SUZSMTRvcnJDeDlWRUh0Wjd3Qm9pRXE4K2tiK2VjZlNqV0dab1pTOXVMRDdL?=
 =?utf-8?B?TnVybGtyb1k3bFhyRmlZNWxETG85NjJCWE5DeHRFVUhpYTFEdDAxSW5ZQWRi?=
 =?utf-8?B?NkpIcVRrZFA5TUNzSnZCNElPblY0TTNyZk9WZExSZDV4WHp6UHB3YzJvck9L?=
 =?utf-8?B?cUY4aGFxU3BSVkFiRVd3RnVDc1JlL01jUlUzMWw3aGFIU1ZMZEVhUUZBWEgv?=
 =?utf-8?B?UDdoQTY1NUVtM3k2ekVsUlhRalV3OXFwRTZwSXQzR3hLNjZ1dkhvVUNNK3VB?=
 =?utf-8?B?alBHWlhCRWp0ZVpLbFBGQ29MR2FEMmtudTBJaUhjQnhFT0tua2RvRFM5Ui93?=
 =?utf-8?B?SjlmOXVwbFRRRGpqZE9TVUhTTGpMeTl3a3lDVzZwUVppVnJud0hlSUFFZGlS?=
 =?utf-8?B?eDdXN2ppSUVJTUxYQWJhOUlmWW9LT3hleE90K3pPdlNNY2xZd0VZcjBRM2Zi?=
 =?utf-8?B?SzFmY0dJV01mdWFweFFsN2NyYnBlTnpvcmMxaU0wTVJGQ2VzSWdtamxxUGRl?=
 =?utf-8?B?TGo3UkkvTkgvV2U1SWdaWVVzcFNEcXdNekVSNGRKR2daV01nS1FTckxKZzFp?=
 =?utf-8?B?KzQ4WTAzbGVTQ014aDRiWmEwU1ZWUmVCaitJTXVtUXRvRVFPUDJkUnpGTzhJ?=
 =?utf-8?B?YStIWS9IU2hvZXVXaHlSYVRCbmY5ZnZ4aWM1TnZodE1iaHNEeFhJL21mUXVH?=
 =?utf-8?B?TExQdVgzendRL3hMUzIxd0FFazN3UjhkUmxkU0d6YUV6Yy9pOVlwVFRRN3Iw?=
 =?utf-8?B?dFlmaVYxS0RGQk1Zc0dKQWNsK0NVRnA0d2tDWUlpanBVRityczdFT2ZTaEhG?=
 =?utf-8?B?S2U1czcvT3N6clIxM1NaUWw3ZHI5NHpNVlJFcFBqZjBqeXRoREZIblNlSXBD?=
 =?utf-8?B?aTI5S2lBKzNKd3ROeUZKbTA0K09ybHRnenZNSWQ0Zms2T0RsVmVKWTFlS2VC?=
 =?utf-8?B?WHhYdjNFV0JPd0dRTWp3eHR4WmtYYmY3VEdlMTdYY1BTbTF3N0VUUHRFWm5J?=
 =?utf-8?B?QkVQam9YbGtFam9hTDVuWmdkN2NYQ1VTT0ZQSGFxVm5laVQrS3FUTU5nZ293?=
 =?utf-8?B?Q2lyUFdveDJhL2YyUFB2ZDNEalBuVm5nTjRTWDJsa3k3T2RWVFRTTXRVL2hT?=
 =?utf-8?B?NHRDeERCWHExcG1nTWc5NkpJcEY2VkQrcEMzV3BqckFLc1R2ZHVyUVVTS1VL?=
 =?utf-8?B?ektrblZmNXV5elZFSkVJSHdoMWljYno5ck1kR3pwd25ySFlMQVZWWU5NQ3Bt?=
 =?utf-8?B?Qmw4KzRxZ0hja21DUUxKUTlENDNLUGhYYisrVEF6L21TK1EwenBnYmpSbDY3?=
 =?utf-8?B?NDBZeUdaako2V3pSeWtvMkV0QjNtZnhqY1ZGWXlQdW1OcVMxSzVEM1k5NHJ2?=
 =?utf-8?B?L1JsN0E1UDhESXlRblRBQ3lWaURSa3dyb0lXWElVNGtidVdWaEY3YmRCcEgy?=
 =?utf-8?B?azE1SFpvbUFVMkFJc3VtZ2FMeU5XQm1LV1dSOURXUVV2L0VIQmgyQ3RGdjdV?=
 =?utf-8?Q?HPiLOlpF3bmYB+8dyl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aweta.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS5PR05MB11020.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6b3540-dac1-4a87-5a9a-08df46f670c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 11:07:17.7238 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6546512a-ba20-41bf-9d8d-c076dcbf6fd9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GaS+aPKK59df2yod57my7T6j3TKTLYDAH1/si8g8m++V9L0RLw9XQVVUhuqOdzxTrq+xzoVYVQp0cCmMLaQYjA==
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiAtIFtIaWdoXSBUaGUgbmV3IFhTSyBxdWV1ZSBjaGVjayBzaXRzIGluIGlnYl9zcmlvdl9yZWlu
aXQoKSwgYW5kIHRoYXQNCj4gICBmdW5jdGlvbiBpcyBzaGFyZWQgYnkgdGhlIFNSLUlPViBlbmFi
bGUgYW5kIGRpc2FibGUgcGF0aHMuDQoNClJpZ2h0LiBJbiB2NyB0aGUgY2hlY2sgaXMgYXQgdGhl
IHN0YXJ0IG9mIGlnYl9lbmFibGVfc3Jpb3YoKSwgYmVmb3JlIGFueQ0KVkYgc3RhdGUgaXMgc2V0
IHVwLCBhbmQgZG9lcyBub3QgcnVuIHdoZW4gVkZzIGFyZSBkaXNhYmxlZC4NCg0KPiAtIFtNZWRp
dW1dIFRoZSBuZXcgLUVCVVNZIHJldHVybiBmcm9tIGlnYl9zcmlvdl9yZWluaXQoKSBnaXZlcyB1
c2Vyc3BhY2UNCj4gICBhIGRldGVybWluaXN0aWMgd2F5IGludG8gaWdiX2VuYWJsZV9zcmlvdigp
J3MgZXJyX291dCBwYXRoIHdoaWxlIHRoZeKApg0KDQpSaWdodC4gSW4gdjcgdGhlIC1FQlVTWSBy
ZXR1cm4gY29tZXMgYmVmb3JlIHZmc19hbGxvY2F0ZWRfY291bnQgYW5kDQp2Zl9kYXRhIGFyZSBz
ZXQsIHNvIGl0IGRvZXMgbm90IGdvIHRocm91Z2ggZXJyX291dC4gVGhlIE1BQyBmaWx0ZXINCmxl
YWsgYW5kIHRoZSByZXN0b3JlIG9mIHRoZSBETUEgY29hbGVzY2luZyBmbGFnIGFyZSBnb25lIHdp
dGggaXQuDQoNCj4gLSBbTG93XSBUaGlzIHBhdGNoIHJhaXNlcyB0aGUgWFNLIHJpbmcgaGFyZHdh
cmUgYnVmZmVyIGluDQo+ICAgaWdiX3NldHVwX3NycmN0bCgpIHRvIDIgS2lCIG9yIDMgS2lCLCB3
aGlsZSB0aGUgWFNLIGZyYW1lIGNhbiBiZSBhc+KApg0KDQpQYXRjaCAxIGlzIG1hcmtlZCBmb3Ig
c3RhYmxlIGFzIHdlbGwsIGFuZA0KRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N0YWJsZS1rZXJuZWwt
cnVsZXMucnN0IHNheXMgdGhhdCBwYXRjaGVzIGluIHRoZQ0Kc2FtZSBzZXJpZXMgZG8gbm90IG5l
ZWQgdG8gYmUgbGlzdGVkIGFzIHByZXJlcXVpc2l0ZXMgdGhlbi4gUGF0Y2ggMSdzDQpGaXhlczog
Y29tbWl0IGlzIG9sZGVyIHRoYW4gcGF0Y2ggMydzLCBzbyBldmVyeSB0cmVlIHRoYXQgdGFrZXMg
cGF0Y2ggMw0KY2FuIGFsc28gdGFrZSBwYXRjaCAxLiBUaGUgY29tbWl0IG1lc3NhZ2UgbmFtZXMg
dGhlIGRlcGVuZGVuY3kuDQoNCj4gLSBbSGlnaF0gVGhpcyBwcm9ibGVtIHdhc24ndCBpbnRyb2R1
Y2VkIGJ5IHRoaXMgcGF0Y2gsIGJ1dCBpdCBzaXRzIGluDQo+ICAgaWdiX3hza19wb29sKCksIHdo
aWNoIHRoZSBwYXRjaCBlZGl0cy4NCg0KUmlnaHQsIGFuZCBvbGRlciB0aGFuIHRoaXMgc2VyaWVz
OiB0aGUgZXRodG9vbCBvZmZsaW5lIHNlbGYtdGVzdCBzZXRzDQp1cCBpdHMgdGVzdCByaW5ncyB3
aXRoIHF1ZXVlIGluZGV4IDAsIHNvIGlnYl94c2tfcG9vbCgpIGdpdmVzIHRoZW0gdGhlDQpwb29s
IGJvdW5kIHRvIHF1ZXVlIDAuIEl0IG5lZWRzIGl0cyBvd24gZml4LCBzZXBhcmF0ZSBmcm9tIHRo
aXMgc2VyaWVzLA0Kc28gSSBsaXN0ZWQgaXQgaW4gdGhlIHY3IGNvdmVyIGxldHRlciBhcyBhbiBv
bGRlciBpc3N1ZS4NCg0KPiAtIFtNZWRpdW1dIFRoaXMgcHJvYmxlbSB3YXNuJ3QgaW50cm9kdWNl
ZCBieSB0aGlzIHBhdGNoLg0KDQpUaGF0IGlzIHRoZSBmYWlsZWQgcGNpX2VuYWJsZV9zcmlvdigp
IHBhdGgsIHdoaWNoIGtlZXBzIHRoZSBWRiBxdWV1ZQ0KbGF5b3V0LiBJdCBpcyBvbGRlciB0aGFu
IHRoaXMgc2VyaWVzIGFuZCB1bmNoYW5nZWQ7IEkgbGlzdGVkIGl0IGluIHRoZQ0KdjcgY292ZXIg
bGV0dGVyLiBUaGUgbmV3IC1FQlVTWSByZXR1cm4gaW4gdjcgZG9lcyBub3QgZ28gdGhyb3VnaCBp
dC4NCg==
