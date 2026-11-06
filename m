Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B415D606A33C
	for <intel-wired-lan@archiver.kernel.org>; Mon,  9 Nov 2026 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=WoXirdK+;
	dkim=pass (2048-bit key, unprotected) header.d=vecima.com header.i=@vecima.com header.a=rsa-sha256 header.s=selector1 header.b=NXccGR5t
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D5F8607C2;
	Mon,  9 Nov 2026 17:18:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MQW48xjo-tcG; Mon,  9 Nov 2026 17:18:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CDDB06069A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794244736;
	b=YqLSnrSyInp8TgrzceVWpTkhrbH3xU+zN/yqZPhYy4uoYmsiCazFcL4U8YM+YkmWuFjW
	 mxsnTKfHsPt3lotv2c2OY3oNJJ6xD5VLTcoLAlmUpXLxVhJ8VCGD6YbIMOvz7OsEfx6cJ
	 V6ujRZ/WNnAz1Obh2vZQ+UHlp7oo8egpMcv/jqnogDGGWEO/dFZJ7GDMOhNr7pWTrOITr
	 FtwtprFn/4+BCXUbVlpWFRT8WqkXOi3+NIjZaxwnV5quJraivs6QpZf460cmxLDFrN4hO
	 8224sNg7mzi7TJe+n4RwthY8dij3vSbK8RHgjXw6iZyBFnr1seclVdctmWLATCjiiiw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794244736;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZnGhPQ9TefnUEIVyE8DcS4BWDWXPArs5noqNJvSqDmw=;
	b=WX/KJTlvmjK6hZnGXMWqut4gcYaTHgKwcu29s/+8kGHwFMypCuD1c+u+suoj2E8Q3Ouo
	 hTTCPbNBF0j5CyydKVp0H5K7VOPOMpN+LutXUsSgaH+Ie5w55qCLMkk7uQ039k42VqbZl
	 +CH0n5dL/F5p9GC3kg/cCNCA93g9zjR4u01A/BwnBShzRI0OSCiEDYPaSE+8G3NUwDw/6
	 Lx0RBxB6Ut5AmtbdpoSaNW2lhqFCsnUtvChST4ls9quIMv3i1O7BK9UVp0TaV6NxvU33o
	 ZkGhuvnwY8H6sjeqraTQ7bHDLZP0psGaJEkNlaqh0hyaE8XvzC3ggnaiQtHAKp34yhA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=vecima.com;
	dkim=pass header.d=vecima.com header.i=@vecima.com header.a=rsa-sha256 header.s=selector1 header.b=NXccGR5t;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794244736;
	bh=ZnGhPQ9TefnUEIVyE8DcS4BWDWXPArs5noqNJvSqDmw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WoXirdK+IBMIwV1fueWcH9QQEBXryONOhTYCk7QH+KPkse45JPD0FsnSpFQKa7FJh
	 +N1dpR7GblNZkce0nmimWZbB8pgcw/GozAwhupNwWM9YYQxTxo3n3is2h4N2R6YzhN
	 LE6ssCkA/I3Iw7BzKS1B9Eb7ECcXw/PNJaHfBYvacixHxJYFfWkDls1xMWfcOKjlUX
	 IRlpJU8FnDfJS6C+3b8wnHw8iRO6v/b60yje8QRkkfy3Splb9T858TFUkFBE8q7qz1
	 0EOcA80rW30vitpXKp3ndkS1GID985VEWMseXfQVTBPdzJCujmE1o5RPI2zkOMzvmM
	 C+k49X9aJE1Iw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CDDB06069A;
	Mon,  9 Nov 2026 17:18:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 49EFF31F
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 12:33:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2FB266069B
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 12:33:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dKau0ARLmg_M for <intel-wired-lan@lists.osuosl.org>;
 Fri,  6 Nov 2026 12:33:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EEE026061F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=40.107.208.107
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.208.107;
 helo=ph0pr06cu001.outbound.protection.outlook.com;
 envelope-from=marcin.knap@vecima.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=vecima.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=vecima.com header.i=@vecima.com header.a=rsa-sha256
 header.s=selector1 header.b=NXccGR5t
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11021107.outbound.protection.outlook.com [40.107.208.107])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EEE026061F
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 12:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vecima.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnGhPQ9TefnUEIVyE8DcS4BWDWXPArs5noqNJvSqDmw=;
 b=NXccGR5tbcYZthImH6XqL4E5QbquSHggq2a5qyaRJVwp3yzyccdIPAwZExro9GMxJFrZ7FUFUhe9VOeIrf3vWsqcKdFhDGNuiGnvdcIqx5CQngv45C1wsF262Pw3KXxjxG11WHxytfQ9PcKXebFagp116oC7g/QpvES9nwKFEe2Hoxn9VkzAzv3atPgNlnP8TQuifT+n5M5U2L4NwuOcV+ZT3kE2XBPFZAZg2nkfPxWRcsWuc6E2rmG8qx74cc2hObvgqLuD8P2kqG4Mqic71q14wUhY5PP4duf6sbhPDvijSckUTIQE9eJ1XmdhV06SW6Z1Qez+m9Gn4kb9Cbs3JQ==
Received: from DS4PPFFD8A841C2.namprd18.prod.outlook.com
 (2603:10b6:f:fc00::ad2) by IA5PR18MB988653.namprd18.prod.outlook.com
 (2603:10b6:208:603::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 12:33:52 +0000
Received: from DS4PPFFD8A841C2.namprd18.prod.outlook.com
 ([fe80::9899:92e0:30cd:fe31]) by DS4PPFFD8A841C2.namprd18.prod.outlook.com
 ([fe80::9899:92e0:30cd:fe31%8]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 12:33:51 +0000
From: Marcin Knap <Marcin.Knap@vecima.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
 "przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@kernel.org" <edumazet@kernel.org>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
 "magnus.karlsson@intel.com" <magnus.karlsson@intel.com>,
 "maciej.fijalkowski@intel.com" <maciej.fijalkowski@intel.com>,
 "sdf@fomichev.me" <sdf@fomichev.me>, "horms@kernel.org" <horms@kernel.org>,
 "ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
 <daniel@iogearbox.net>, "hawk@kernel.org" <hawk@kernel.org>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>, "jtollet@cisco.com"
 <jtollet@cisco.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "bjorn@kernel.org" <bjorn@kernel.org>, "kerneljasonxing@gmail.com"
 <kerneljasonxing@gmail.com>, "nshettyj@marvell.com" <nshettyj@marvell.com>,
 "joshwash@google.com" <joshwash@google.com>, "hramamurthy@google.com"
 <hramamurthy@google.com>, "sgoutham@marvell.com" <sgoutham@marvell.com>,
 "gakula@marvell.com" <gakula@marvell.com>, "rkannoth@marvell.com"
 <rkannoth@marvell.com>, "sbhatta@marvell.com" <sbhatta@marvell.com>,
 "bbhushan2@marvell.com" <bbhushan2@marvell.com>
Subject: Re: [PATCH net v3] xsk: Do not free ZC Rx buffer when the Rx ring is
 full
Thread-Topic: [PATCH net v3] xsk: Do not free ZC Rx buffer when the Rx ring is
 full
Thread-Index: AQHdbDQpD7A/wAmXU0W414UyChcRK7cg5reAgAATIwY=
Date: Fri, 6 Nov 2026 12:33:51 +0000
Message-ID: <DS4PPFFD8A841C2427F94230A5DFF5D586180762@DS4PPFFD8A841C2.namprd18.prod.outlook.com>
References: <20261104-xsk-zc-rx-double-free-v3-1-11a0c7ef1973@vecima.com>
 <179396348511.994134.3480253108877320302@kernel.org>
In-Reply-To: <179396348511.994134.3480253108877320302@kernel.org>
Accept-Language: en-150, pl-PL, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_Enabled=True;
 MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_SiteId=9d639caa-2d40-486d-ac82-e59b0005382f;
 MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_SetDate=2026-11-06T12:33:51.137Z;
 MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_Name=General;
 MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_ContentBits=1;
 MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vecima.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFFD8A841C2:EE_|IA5PR18MB988653:EE_
x-ms-office365-filtering-correlation-id: 04f0b85c-62fb-4c87-8098-08df3c0236c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|7416014|1800799024|22082099003|18002099003|10067099003|38070700021|4143699003|11063799006|261102123227099003|261026140227099003|261028144727099003|261021135927099003|261022105027099003|261022075727099003|261021121427099003|56012099006|261009223027099003;
x-microsoft-antispam-message-info: 495VcyE4nbn/v0JBchhvtrDsyVelqXBQF4rS55+LJhGSPh2Vqgxr27Rge/Hthf/sSpj8KCjLwwWV+cWgoeSBff8uaiAj3i6yvibfM51Qa4E4NFhBFINFjxESmI+ykWNRepezPQlfWDsUNNSj1i3eXzRGiAhN48YlaCvKGV3eaXqk7aZrD9+VIQko9zSCTsS+PhQe8IyKJBLrgrZCwi5b9T/+cyvtBZwroy7oR2hDckIBlfEuPU+WY+B6kOwhC0x2WDAZ2bbY+wLCLB9raPozzTpDvNJaId9yLaOchgXsGyygmX+KbTZyRh+MiHZaVva7LTYE/bbP424R20dIuImHurQp6+pcSWsbEDxUrrxmRv4cubSoSow8o1dcwaSi6CzSjmzdklpxpiSHUc8VKpkhzkvE+SuCxeMHmfUPpptHeNYEDvr0jNAkFIsfO2e24HitndBPvrhO9HCkC6a1VlW5RMJBvtouWC1Jx4u1ptl10boWJAPLSr2UxsnAPseXMx4xV6ajgylz1aTHc1C03CKXLveXae78r6+mKAr6msr/0fWMrclwVI58zOObMh8eZy/6rLHCVnKfh9ZT9OYIZFy41ZfU1eazw4ykpfwwPxIrpE2q6kY3AqxjMPR6DPO9qbZZqpo0uLkgXv3mCZxJCubyo5HdGAzV6hocX/ZdaMuDG++TQOiGq8jLyMbja34qTVPBBKnbOJ8DxLFe9FruvtuGGeZyJOl6GZLEDxHVom+3xFc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPFFD8A841C2.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(22082099003)(18002099003)(10067099003)(38070700021)(4143699003)(11063799006)(261102123227099003)(261026140227099003)(261028144727099003)(261021135927099003)(261022105027099003)(261022075727099003)(261021121427099003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?tkCjXdxbEYe39AwHaWfqn8Hf/0PhVjQeN74GsBb0pLNqQ4Hvr/FLcYCU?=
 =?Windows-1252?Q?7PtE6y61PJxQnjo5+Aadl+LCYk2HmUAzN32zANQHJVO2HNjqGWU0D2Kz?=
 =?Windows-1252?Q?wnJimQEzvCMlAQh+mkgMGTYyg4/nDZX3N+/TIv3Yhemxca65bp5ID7Jj?=
 =?Windows-1252?Q?L8cgLt03IpiP0GdQeAAPC4JdLsq2xc6Q86rZJ4GZc7cCi0JPu1CqL3qF?=
 =?Windows-1252?Q?Swl87YILRB6aTaRKOf3mSjMmXE13YndyRGVBU0Crm0j/xBiI5N0VXiKx?=
 =?Windows-1252?Q?zmDuZkTHvzbQjbHRStNyO35CgBR0RP70Zj5286TsqTuC7AVaMSaFpy/6?=
 =?Windows-1252?Q?3LUZCsXj0M0nDYjqLlx9Wl73n/0kgXw2tF4z6w2S/TG4/cVCBhsjPlBL?=
 =?Windows-1252?Q?SCiTWoOGT96n4WvdItly1yCKpnz4XN3N8vBvGEMVJCiwL+jR4tykeulU?=
 =?Windows-1252?Q?DQWk/wBE8UNsh59MBAWaqt+ZtvbLWc64dhAA8yX+Qms6HtZi5xqYvg4V?=
 =?Windows-1252?Q?ciT29c+GfMRNA2LI896h+9IqYsCrHxzeZ1lVKcHBS+bUTuXoDCTSTgiX?=
 =?Windows-1252?Q?SunN55UpqenUA9DcPn/vO4CkChXCUKgPHK/ut7nlJMOErzBZp8sUdQyn?=
 =?Windows-1252?Q?7pLG9S7uVOdxTD/6YCfSIvwy7vhl1TlR6RRjPUcnQPQAMYbOoBWD9EyI?=
 =?Windows-1252?Q?yPs5AJjC1L19vANMMt+uSpbD8Wz43S4y7Y5SQBe043q02xYVWV05Ug7c?=
 =?Windows-1252?Q?U+As8I3r32MuHraCHKTgxayQjieONHaGl04F3xynZNx6p3sFj8MW51Z8?=
 =?Windows-1252?Q?ig1dsQjP6lplGmslKA2E2qu46s9LE8toPDM9UcSb0GRk7G4+ziUGUZ9W?=
 =?Windows-1252?Q?uQrD87E6T1i81DQdu2i8xWWsj76vcjOaBJrkr+QDI4XXMgQkXFq+mJLf?=
 =?Windows-1252?Q?yRK4Cj2WpnDxBfHxdb2OrCX43cHrxOBGOvCIhxI7CJfo1a48k++aP0PB?=
 =?Windows-1252?Q?17uSpfpZWZjvhMFQZLcieVxpKmhzxrANGGOsMgCyI3ybhD4SLSo/ZJx6?=
 =?Windows-1252?Q?FuydZG0fHvHfXiHukJFmJuLWMrjqY1KTwKyU9ltXYaG/dbACRRzQOfzs?=
 =?Windows-1252?Q?m36e/33mw90PvJZvloxJQLqhCS/UtfqeKZMMPCjiNgCIb8bqcfsD46Wf?=
 =?Windows-1252?Q?0WuppcVXRrI8Ss/w4rDXsFD6y9iBKbQl4RN66BSDB/BitngEdq9uXaFb?=
 =?Windows-1252?Q?btQbwLNydcQSr17xPiN5+kRPrmlfhX6upk90VNEVONpczgpl5BQaz7E4?=
 =?Windows-1252?Q?GrMiiHMqKfrISKleA4BPRfh6vnjE7EWsFjoZIQeXmHOV7KZSzFawBdQD?=
 =?Windows-1252?Q?1/VmlDH3Upoin9f72WxLSC6nNMo1eByF4xQsS07jvSchHh1XYhYjvMrW?=
 =?Windows-1252?Q?X0Km3hJS0cB5cOp2GDZx5/+GD53BhtC3pDRr3yq09SMKP2ncnY5yqFLv?=
 =?Windows-1252?Q?XyYVFpbDMm3GytGNk2x3omSqMNc8Doyz1xBELVikEGulLafRNVYKcu32?=
 =?Windows-1252?Q?aCBpyENTyu9CdQxFdFUqeSKtGrP5FmmK8v7T1wJJZIwMCSA4MyC8VxnN?=
 =?Windows-1252?Q?cM2d7AxWKoutzgeHA/RrYr2x2eoyNTSs9sULAKg1Cr3Njgaft3nsW/nf?=
 =?Windows-1252?Q?KORxZmf0OM9/t4YC2U7BTzVRsdl5VkGWz9TNMYDaucZoDYQ69wouSJ0J?=
 =?Windows-1252?Q?Cghdk2n+U10BEtO1VCrA//JmxuKvSeNuSOGjcC1b7ghCfva8kpfHqSiJ?=
 =?Windows-1252?Q?C5DE1tr/sRUBMmPW9KscQ4+GL1GJAHn7W4k1r4YamrdSi0HTHwBWIgT2?=
 =?Windows-1252?Q?vOflaxvywEuCVA=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vecima.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFFD8A841C2.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f0b85c-62fb-4c87-8098-08df3c0236c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 12:33:51.5398 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d639caa-2d40-486d-ac82-e59b0005382f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w11LF+zlWyor+60RNcp+jF061opgTwCMRpDqWYZGSZpO1fM4IznO3+oTRioiC8KhOEy+CDy4kPeIo5CTSsTdKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR18MB988653
X-Mailman-Approved-At: Mon, 09 Nov 2026 17:18:54 +0000
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=0A=
> - [Medium] After this patch, ixgbe's need_wakeup -ENOBUFS path keeps a=0A=
>   live buffer and runs XDP on it again, but with stale data pointers.=0A=
=0A=
This is pre-existing. ixgbe already ran XDP again on the same buffer=0A=
before this patch, and data and data_meta were not reset then either.=0A=
The only difference was that the buffer had already been freed by=0A=
xsk_rcv_zc() and could be on the pool free list. The stale pointers are=0A=
not introduced here. As discussed for v2, ixgbe is left for a follow-up.=0A=
=0A=
The review also points out that igb never returns IGB_XDP_EXIT=0A=
(out_failure falls through to XDP_DROP, which sets IGB_XDP_CONSUMED),=0A=
so v4 removes igb from that part of the commit message.=0A=
=0A=
> Pre-existing issues:=0A=
> - [High] The rule that the caller owns the buffer when redirect fails=0A=
>   still breaks when a zero-copy buffer is redirected to anything other=85=
=0A=
=0A=
Agreed, this is pre-existing. xdp_convert_zc_to_xdp_frame() frees the=0A=
ZC buffer before a non-XSKMAP redirect can still fail. It is separate=0A=
from the XSKMAP -ENOBUFS path fixed here; v4 says in the commit message=0A=
that the fix covers XSKMAP redirects.=0A=
=0A=
> - [High] In otx2_xdp_rcv_pkt_handler()=0A=
>   (drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c), the two=85=0A=
> - [High] In otx2_xdp_rcv_pkt_handler()=0A=
>   (drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c), the AF_XDP=85=
=0A=
=0A=
Both are pre-existing otx2 issues that are not related to the ZC Rx=0A=
ring full path, so they are not addressed by this patch.=0A=
=0A=
pw-bot: cr=
