Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72337606A31C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Nov 2026 06:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=uRvQ3+HT;
	dkim=pass (2048-bit key, unprotected) header.d=aweta.nl header.i=@aweta.nl header.a=rsa-sha256 header.s=selector1 header.b=wtWj+/1E
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34911605B1;
	Wed, 11 Nov 2026 06:45:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zi1Dv2XPv_lr; Wed, 11 Nov 2026 06:45:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A30AF607A8
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794379546;
	b=F76f2bx/RV/M80ftOC3q0+CHdu4geFyDj7PsB/lC4afRMU2QvNAbJBc1ixnAGZHaoGja
	 OJNPCrznwKfJo2K0VuFaSFW/rZl/MtQbWMBnSj2Tsv5DbCvQh3QHIrhGXQl+BX71bpdP+
	 GipLl0mDGxQzPvkhIIwziaHwlU1U7Cu6fP3wg4FRZpH9u2Mx9s10z8y6gbNlFvFdbZ4ZD
	 sLxHC/GoJFrVSKFqwUwO4Q1kUgxifEewV4RHGpTPj73I9DtcYpNYHloO68JYo007dcBJ2
	 3mN/a4QoSr0y+0ZRjTFs/pNr3tcol5G43C6n3igtXP8AO0m0Gs+yUA1nnVorWfzSBfw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794379546;
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
	bh=JaGqQPxitmXKkHk57xhuWKtzD67cqSWyTVoKkGU2hoM=;
	b=p0JERx4+YBwSd80dXwpbj7/ONXip7YtBd6sVlBx7PKMr8hIE2OrvEXdc56umS8e56zSj
	 GYLDGuh9+LgtJeC+klt1wcWf6qlDXzym4TwU+6Ne4qBBxlwPx4K0IHgQZEsIUu0mIYHMY
	 Khozcn2FQvB57Z+963OtPIHDCRmFZGVNIWBeXo3UBxG9kJ5UhOqYE9N28zpdEY35Ei9Uy
	 1/mCdZ/0GaltyhTGNjFuFRYoK2MS+y89+BJ5sGbFLY/Qcc1ejciZ7LZQJReafLf80uBgM
	 GNGLv8iTbF4xEuLgteY7Fy+8c987bzru8bWCooA9Mto3YzrsW+tZcaY3FpM+dCmHKgA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=aweta.nl;
	dkim=pass header.d=aweta.nl header.i=@aweta.nl header.a=rsa-sha256 header.s=selector1 header.b="wtWj+/1E";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794379546;
	bh=JaGqQPxitmXKkHk57xhuWKtzD67cqSWyTVoKkGU2hoM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uRvQ3+HTclSasCcCUpSGPZwYRTwD2gNarmZbeQFKBzf78RGxbligytX1HfLFWRXCp
	 3Mj0+Rb2zubBSNog9/gywJHBGV91vMHldu1fd8cDbazO4zbX6vPEv9zSrAQDSasNEz
	 c3ztb8ZLuxrKsVL0jzDmkCj+u4C2Sy7Ao9ZTQwaMWinxEC7qwOqYzSFoUiVAa7vcDF
	 wi4BzU83+NwPh2qAGO/cr8SxAoPYzudMjUt/4DCjn8/WfpsTcjRHp7rANJiZR+Tb2Z
	 VHmS855lsyDMXEeFiXb1vfURfdwoQ/e+w4LqbCTmAgl/c8DqzwDBrbF02JVqcFFujD
	 4hSl2agAu5suA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A30AF607A8;
	Wed, 11 Nov 2026 06:45:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E70D731
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 06:45:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6F571605B1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 06:45:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2p5PXSc7viQi for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Nov 2026 06:45:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 81BAA607A8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=52.101.66.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=52.101.66.116;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=tkusters@aweta.nl; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=aweta.nl
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=aweta.nl header.i=@aweta.nl header.a=rsa-sha256
 header.s=selector1 header.b=wtWj+/1E
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11022116.outbound.protection.outlook.com
 [52.101.66.116])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 81BAA607A8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 06:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aweta.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaGqQPxitmXKkHk57xhuWKtzD67cqSWyTVoKkGU2hoM=;
 b=wtWj+/1EPQtPQRkngPbcWa46emcBePlubQTVZSHmQhHAfgVzkFqtGH+8ZSQcxXuffKlR1+Ey+1LjZflhB8rjzf/JbP/mWbJwvHLPAVjNXvklvqjBDsUD3E4jn+Ol7GXkzZqnPSJGv7QF/KOOj37exQCyp6QXpuV1E+jZv0ABxXRmVIgZLxpGk6ELr7+OJPF+SvpJ8gYnZyWpIpFRMoPHjdl5G3jkS7M0uU8iJQdPmbq3qW+1QsdZIUi9asOq9wVEuZAslLRgQhoghnXPsVUwIbFpYS04fPNspPsabh3SF3r0pAgNOnqEE1jHuL3apwfeUlpCtSX2ybkdQiBy5uhdUA==
Received: from AS5PR05MB11020.eurprd05.prod.outlook.com
 (2603:10a6:20b:67d::13) by PAXPR05MB8112.eurprd05.prod.outlook.com
 (2603:10a6:102:de::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 06:45:37 +0000
Received: from AS5PR05MB11020.eurprd05.prod.outlook.com
 ([fe80::2dc4:6bec:d87e:3492]) by AS5PR05MB11020.eurprd05.prod.outlook.com
 ([fe80::2dc4:6bec:d87e:3492%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 06:45:37 +0000
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
Subject: RE: [PATCH net v5 4/4] igb: drop AF_XDP zero-copy frames that span
 several Rx buffers
Thread-Topic: [PATCH net v5 4/4] igb: drop AF_XDP zero-copy frames that span
 several Rx buffers
Thread-Index: AQHdbCdZYmGgPwiFSEG43WKkhRY4RLciygAAgAWt9QA=
Date: Wed, 11 Nov 2026 06:45:37 +0000
Message-ID: <AS5PR05MB1102099EEF867597B2F442293B9712@AS5PR05MB11020.eurprd05.prod.outlook.com>
References: <20261104-igb-rx-ts-fix-v5-0-bf4b4367129a@aweta.nl>
 <20261104-igb-rx-ts-fix-v5-4-bf4b4367129a@aweta.nl> <au9LMP75WIgIQnub@boxer>
In-Reply-To: <au9LMP75WIgIQnub@boxer>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aweta.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR05MB11020:EE_|PAXPR05MB8112:EE_
x-ms-office365-filtering-correlation-id: f9115827-d00b-4193-94c2-08df3fbf64cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|23010399003|38070700021|10067099003|4143699003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: q/3vkY305w7D+veUFMkKkDtKzkxai+MJ8vZ7qigLzMwLhuCbouSnAtMb+7fK2jxHMvCUkcN7vkHJZKrsuaYOue7ZdywUVfzigWt1lMBTKP2iWGH6bxBqpmQUi5fQiGjJE2Uty4+f2nMDr5q08cmLrM+5/hv6E15r4HBOXe/pvywN7Ajs7oyday6lrTri35XPX5GwFhTA6/srXq3vybwO9yrABXhUmQx2u4NltYqm7N7UqMZYOVnxPipAAO/r88bULo9xeRsQ1hLcOT6e09U4m94SuNVjUbDDqet/joNcrUz4Wsi/VS8vI4dVMY3jmIaMbAQICmIVM+5AAC5rqsJuRQLi+Fr2evDP3SlMRp39xMoOK76wIZbYKgg+d5ARxEZjqt8R3giAp6w0FvP0wvbz7AQjgeSWZ1/Z5LBSYg4kGOHinANhh4aKhBeK7eeDzg8UMMvD/aRuKpu+FhL+Vo7cDG9t/Qjp+M3ZkZetXuCMDVK8oCNizz/GAeOftsbLtqkAYmj9QA7Xm0EdDEL0lXMw1qXNbfIdHYqnim4GJb+zok5aYa6KZxl2luNa4SyEETcOOJ//2tGvKEGXBER9kGoVl9qGlbCBMVv1ZYNuj3gBHM7pSF1+7SmvJE0dL6Ia2+iXlbsOki3ZnPTuFSUiahVO4ySoS8cwQjlTEV+hD3CBbZd78j+KEPe0lemBRmo5eyG5KLvpiWjtmFQiWh6qswQIVg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR05MB11020.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(23010399003)(38070700021)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tHGh4f7LgJ07vrafOVTOpv/UHOyMYJ0cKx7qGvdQgPS6Yl1CQ2pn83oNwqDn?=
 =?us-ascii?Q?k0qBTPbmrkHQTnXbPMxZoNp7ZAANOQA4HBi5MB5nRPxPPOudRTD5pYOYZc+b?=
 =?us-ascii?Q?0QygTjuqn3pnloEnqXwmwVWuZ5+LiVpbJ1Vl4s36mSixLS58NePZh0PG4DeF?=
 =?us-ascii?Q?kg46V2aEIFRJKdmZbzLcV0QJ7tR/2aRCT39oOnh3db43sJwQcte1JrEJkcFD?=
 =?us-ascii?Q?XgTPfcoV9ucEuwjttIdTBo9z08aF2CyJ1+60V1HMl41v0vFW2NawKTt57n66?=
 =?us-ascii?Q?wNPcoMqx8QUNTCXmpaugufsGdNnrA2uKL6kGRZaoQNQqMyz4jA4E4eYhOCEs?=
 =?us-ascii?Q?DQWfWnf0582L+XnIbkCuD2SmmF7Xwn7zwR6RF6NjBEPe3LS+sXzp2RnWzhYM?=
 =?us-ascii?Q?dtGfWfkG5H6ptQREIXFKpVtpiXTWQpHLwbWMjX9979v7RFvGOKw+jUlcERLk?=
 =?us-ascii?Q?2Fp5xO5WJ5trd1aYqfg/P9cUs2NvXB/zPUQ3s2ugo2eUDmJBoaZ8XvGcbhFG?=
 =?us-ascii?Q?71qmoFrA4LClg5hvTjDvZcYZIH1E6O/LfF+CvcguWsV+rHFiIvwB4NNISfbC?=
 =?us-ascii?Q?fhtpbzRCHP4wp1Vy5MAxxBJjv0qTM7aM0AAzQSFflTLpAESMS2pob5ZhgSyS?=
 =?us-ascii?Q?QG4tlqdR6npDaYVNxm55efM95XjBtiPyQpRKcaPU+r7CU1gOfkqkZbKdL5WZ?=
 =?us-ascii?Q?FWe5cUT1yYtOlJ12BgWD8xyGVFQ9YNP3mHzzZrq/F6necaHmPlQuMyjPX5xt?=
 =?us-ascii?Q?dxqhenO5HLwxpfizrJ9h1mBajmJKwBdA+HcG9UNrWBZu2AxlCkE77zri8TEQ?=
 =?us-ascii?Q?eKX2HUF2CSHNBUai5p0xCZcv6suwXMXN48QHj83oYRIrGx9h9SuXVYY+V77M?=
 =?us-ascii?Q?m+qiriLIVpdF6oUQXIzHk11FqURE5J8imUVNt6wv9YpzFG0dtswUF07jlJLK?=
 =?us-ascii?Q?E+NN0c8TR9rCjbeFCDZhwxn3AjJz678OgD0HV2xON8Fv8DTHkmeg37mKVNMA?=
 =?us-ascii?Q?0q7vFMeRmW/Vs9JqzzAvf2oDOgO11TfhYmZfEewZ+kbdd8q0KHC/U6pSmS8X?=
 =?us-ascii?Q?5LJ8NtXk2GeHVIrN2QJuQ4xE1r4wWDaExDr+aRqXjBWtX2nNkGaElY8hF9ly?=
 =?us-ascii?Q?iR22+BE1TBP18NfvqqtSFdyH/hxWKKX9gpbPDkdOAwsC5rZLo866vwBY2gI4?=
 =?us-ascii?Q?66aG+FFzwXMg3dn3FwvfW8ivl3nFIhb8nibyf+juQWuoNS2IN31gS0pfq9E7?=
 =?us-ascii?Q?WDpU+GwujKZR0AArq/TFxWq8fVtE/7fo7f0SyzvCHqffQq2zFcD66yvwdUSU?=
 =?us-ascii?Q?HwaQtK9Jh52uPz1XEhgeaWXj50Gi4ogCTlGJyVnrfFbOw+FekpL4OCICwKg0?=
 =?us-ascii?Q?0nI80rTZ5Bu64bVhB2JSJq+/fhsHpENIDAmtdlZm9bL+q89tsMiszbmwIHEP?=
 =?us-ascii?Q?x42w2gCfwUXNwnHzxTtpNjg36MeWFTrBABGy8GyOBNSJR+W0RNG3TuIZZZVP?=
 =?us-ascii?Q?PBAnaviX2Yn/dK4olKFeD2oiMI6g3AFN7bObTcSVJ9Q2HyDp7HScUxO7DEKj?=
 =?us-ascii?Q?WnHpvKEDTrVdRP/xgtP9AQ57dFAVegDrfq+iPPSnfmfC2D8OTuL/meolLmdp?=
 =?us-ascii?Q?mCNtlVhv8uHz/0kfWndgecvMx3qWFgztJdiwEMID8XYLSOhABn7vwn+1Aql4?=
 =?us-ascii?Q?RJmwpY8SCXThJCRyXVE/dkbJeBYpAUKLkJCoMWyhq4wwWgWS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aweta.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS5PR05MB11020.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9115827-d00b-4193-94c2-08df3fbf64cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 06:45:37.1784 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6546512a-ba20-41bf-9d8d-c076dcbf6fd9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1kQnyfDJjeA0NXpQNyTQUV09ihrLGJJz6R0RKdkn3qqvJGJDJ0uPfCnDB1wkd3usInrziQo9En2pS/cQ68fFqA==
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

> I am missing the point of this patch then. Are you adding a dead code to
> hot path?

You are right. With patch 3 the hardware no longer splits frames in
zero-copy mode, so this patch only guards a case that should not happen.
Thanks for the background on ixgbe. I will drop it in v6.


