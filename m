Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B300C606A31E
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=rVbZ3k27;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Zra6DcCk;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=lHCGV4Jv
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90AF64060E;
	Mon, 23 Nov 2026 18:31:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n6IK5aVWqOWJ; Mon, 23 Nov 2026 18:31:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C5F804064A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795458675;
	b=paKnVqRYBlsdxASvlE+S4BqsAoL+KRXJ8F3RbZDak8dWPqddAn49ncXx3b0y2yyEcFdn
	 5FGPTKVngWcms8HgzQ4Ngnuyt7hAiooiuqt5g7vRXVYkeTqDMPPmGf3kF5rxgnP8WHkRC
	 FMkq/urksnUd0FGWVeeFk46MPq1Gj/X/D0h5HPEghoUGfEYx60m3YUDIsNwkUx4Wny4ny
	 2Ejmw4PXqw879nfmBqM/Wb0Ddh7+Rks3Q5p0K06hiLyVw+TZjPzBwleuQMHR0CExhEYDS
	 gkONanQZQrJfTO/so2guGlOwoh0f0ABNr1kngMbcdNeWs+kg+lKuH/BYdJnK0MkAyEA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795458675;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
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
	bh=Ptdt8T+a2JbDf7hh85QTtp0CeyiCUs2Vvxr7v5Zyn3k=;
	b=UP2ZR8YrRchFKYouV6QWzUT4ICfBQ07u1DujK4IYMVts3HIlCHaxwQuPFeLJq5pMJa4o
	 FAcwr97DrNmWJLEPYppbnbixx46PKBZ0fi2rT0T98+e+/HhQSu73HLy8AZ9699TGeSoQB
	 qvgmGkmDiZ4Gz+Z4PsmPuqlEAz2pbJXKc0JRO+Ax/rS+su+SAttzaBUMbkWHNoOO5nZVX
	 i2XlXZGQYOthg9+UImiA6dI4Yvrfl1Zo378jsshJVdW9LapqPXBYT2mUX7vOU1XWHGOAD
	 Dn3Gqcisx5VLCktMwqph58244EiDsh2Ojs3NHsnOrneEQjCY3J9bhZ7A11UpsrLmEqg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795458675;
	bh=Ptdt8T+a2JbDf7hh85QTtp0CeyiCUs2Vvxr7v5Zyn3k=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rVbZ3k273OIR1WUu+tJoyD6KTHwNY3i5N/l/WPha5jRZ/rVPg8epvu/XDrsjKlJbT
	 VfvgZJGIuds4qCEgb5o4zA2xDPCGNHXsNpdpvbCe29Nwk9ZFe8LU14DDYfzldJH6I/
	 /EtMl7l8cuQwh4FQRPcVc3yg6KSJk58Hv42US2skBa0XplYLTb61iwIcURJYykSD9F
	 /BfpqZOjccPLqWRhdvwbnVVY5psulTkEYyAZV14s8mY6H9EBJ9IpVIJdoTzNUUbkaw
	 wMGF18BvsOHBBlWeFqyySkijTSotBN21y9wqTmYoy2qosXhC04zyheJ06UEhsdEeDP
	 raY1EO7RDlzzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5F804064A;
	Mon, 23 Nov 2026 18:31:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 61071371
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 18:31:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 46F4460640
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 18:31:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IbeResMJKj2R for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 18:31:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E4FC260661
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=samuel.salin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Zra6DcCk; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=lHCGV4Jv
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E4FC260661
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 18:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795458673; x=1826994673;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Ptdt8T+a2JbDf7hh85QTtp0CeyiCUs2Vvxr7v5Zyn3k=;
 b=Zra6DcCkM6DSvm6xuhESs8rt53JVXwjDaZ5dDFxY3huKJR0l8FhlQHxK
 h/y9Ud0l5BPBzXn7luioFk3AHfbOp+NdGrG7HKx4qn7XC0TvTuiEdmRk8
 k1ujwP1n4HcTVFBykXjRAj2wPDL54rEVflxJjQqf08gI2kaK+vwbMlmcH
 EQfB8jI6K0zzUQBePjNVr3EeZQkY0Yo4129Xr/pfoanfcS3XMrEcc5du1
 eCrRGz6ce2ZCFVrwzi8sAtfOMoRc1UIpqwzr6yMdyj0pjLy+kiosNxiK5
 418qajXFQ6ex/JFDao28Y9e3v+1A0UT3j1RgfrF9RW5Bpa7yJfROj9xv3 A==;
X-CSE-ConnectionGUID: R+HEOnzvTiucYe/Jdk9iIQ==
X-CSE-MsgGUID: deaPlohcSOyOWRpzmgQZuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4314891"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4314891"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 10:31:11 -0800
X-CSE-ConnectionGUID: SmBsd4FMS6+hEq2FXooOmQ==
X-CSE-MsgGUID: ea3pN+0/RDua+tYqtwVu/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; d="scan'208";a="11571902"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 10:31:11 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 10:31:10 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 10:31:10 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.35) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 10:31:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ptdt8T+a2JbDf7hh85QTtp0CeyiCUs2Vvxr7v5Zyn3k=;
 b=lHCGV4Jv5juHHxFwMdlzDp+7NjkG5ZtGmHXsLijp1fugDDmk31+b8nFtJdNt+3fvdByFCXO8Vxn70n9fNLDhoVcgI30RwZwcfLpnMOb6xeCl+tVz7Z4jJoJaaV5sxH6cblYNHByg256b2j7AWPVP+wb8JfSr1tRx1zb1u2skg0U=
Received: from IA3PR11MB824491.namprd11.prod.outlook.com
 (2603:10b6:208:626::16) by DS0PR11MB7650.namprd11.prod.outlook.com
 (2603:10b6:8:151::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 18:30:47 +0000
Received: from IA3PR11MB824491.namprd11.prod.outlook.com
 ([fe80::c2b7:5964:96e1:8ffd]) by IA3PR11MB824491.namprd11.prod.outlook.com
 ([fe80::c2b7:5964:96e1:8ffd%5]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 18:30:47 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Tantilov, Emil S" <emil.s.tantilov@intel.com>, Tian Xun Ng
 <luckilystar08@gmail.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Lobakin, Aleksander"
 <aleksander.lobakin@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>, "decot@google.com" <decot@google.com>,
 "Olech, Milena" <milena.olech@intel.com>, "Hay, Joshua A"
 <joshua.a.hay@intel.com>, "alan.brady@intel.com" <alan.brady@intel.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
 Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: RE: [PATCH iwl-net v5 1/3] idpf: ignore Tx timestamp replies once
 removal has started
Thread-Topic: [PATCH iwl-net v5 1/3] idpf: ignore Tx timestamp replies once
 removal has started
Thread-Index: AQHdWwwxTaheaM3eHUiJ0dzi8sTSwLb7qRiAgECSLqA=
Date: Mon, 23 Nov 2026 18:30:47 +0000
Message-ID: <IA3PR11MB82449153C243F4244B706015E79B452@IA3PR11MB824491.namprd11.prod.outlook.com>
References: <20261013121224.84482-1-luckilystar08@gmail.com>
 <20261013121224.84482-2-luckilystar08@gmail.com>
 <e060d9c7-f80b-4eb7-bbc2-c0f1e26c4fff@intel.com>
In-Reply-To: <e060d9c7-f80b-4eb7-bbc2-c0f1e26c4fff@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB824491:EE_|DS0PR11MB7650:EE_
x-ms-office365-filtering-correlation-id: 365f9d8f-fda6-4b56-5821-08df498fe47d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|38070700021|10067099003|4143699003|11063799006|56012099006|261021121427099003|261022105027099003|261009221727099003|261009223027099003|261009220027099003|261021123027099003|261009223327099003|261022075727099003|261028144727099003|261026121527099003|261026140227099003|261102123227099003|261009221227099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: Vs1XtLfYTqVbtDKT3ixRj++LtQTWC0+82Wih765hCLsE1bxYmgHjrZgrQLOelg2/de0cbAtId3gNOOq+aqU9xXq6Elgz15gEujhoiP8/e+5lnipskxz5/Eiz9um4bLKgCrez7c26X1yUSCg7/wcMiv3AErhBvyNmMGyUqVkansmpMomc5LbGa9wvYZVFAjq7x1UOpcOCE78Bcxz5cJcca2ctGm6c/N1lz6FgMZCHix+LPJ8RG0lJX/Txlzvehghs3N65mzG1pqs1mpP07blYS/dPA3GN6A6pwsTiLEmVVTxG/uN7/TSE3DGBd6x1eRWxPSvPV49p8OEbbTw+dkJZSQZkWkDC8uBTqT/IILUQ7bJf5AUPNeEzVczq176lRuU3UOQReEw1a62JWgS19urrJRhRhVQ9NKed82TbaQ36KMHHWtkLi+9Pi+1TD/575j673OntYD83W2pDQGdSJEJfcSotaEWpXhpZMvknaCZrZWMyEsUT8xMx9odjzUXRrt1lOCfj9O7Atz2qqRl7HwBKPSCn7+rF2SL0SB8MdDMA/rHK/AEUuD0iy8AUgCLAH/z0O6Nm0X/C6f1hRnJD4ZG37YgseyUOwhwiwq+TKm19LRFmGi0UEhNpZYOb7tBwisxiolBiy68hhLdlyTtG2OFlmE/5wBovKln1Y7k+zGXqmVM1HOjdHs2rHDxptZ/xLmMu/2w9EY2ljl6yqFsEsOeQ60yvO2aUo3DlhZUrPsvmD5s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB824491.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(38070700021)(10067099003)(4143699003)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261009221727099003)(261009223027099003)(261009220027099003)(261021123027099003)(261009223327099003)(261022075727099003)(261028144727099003)(261026121527099003)(261026140227099003)(261102123227099003)(261009221227099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlBYWCtuTitXRjZmakozVzE0WVQxK3d1SnpadmRzNlFOYVdpdDl6UG51YkhB?=
 =?utf-8?B?ZURTRkNXNm1tbi9oekF6YytNSzFOVEl1NW15TTh1NEJFN1BNZ1ZSRTlJMVp5?=
 =?utf-8?B?cmxKTURyNHplL2MzcXhXMXdqS1F6QklDcyt5SUFRTlhwS2M2VVZYUXdjUG10?=
 =?utf-8?B?TkZpUm50VFBKUXRUamY4VmFUMngrY3MxRS9VOGlEYWxHa09TOVMwR09yK3Fw?=
 =?utf-8?B?Z2N2ZjI2Tk51WjN1VWxxOUtMMDVrMkNqYjd1SHZxUVUwWEVpV0RGQTJPd1Yv?=
 =?utf-8?B?K0srOXdBMDRSYnlzRlB0S2p6bzhRQTFvQ1RzWGVZWHdJaWwzRGRZQUdDRCs3?=
 =?utf-8?B?bDlsV2FESGFCelZVclZ0cWxXL0NmYW5tRVFndGtkcitmTkozVjE2SWRoVWtG?=
 =?utf-8?B?anFxYXZMTi82RGVDa21yQlk3V3NGRVVqNkRhLzdSUUV3SyszMVN0Q2xrWGlQ?=
 =?utf-8?B?VVEzM3hYVkR2bWdTR0tXa2FLMkZKbFA3emE4cnVMdHc0M0NvSTBkSmdWTGMw?=
 =?utf-8?B?ZnFVTWE3WEhzbGc0WCtMYm5na2VhVGFxdUZGY2hOM3BsS213WGN4TGp6RUtk?=
 =?utf-8?B?dkFSZUQrOHF1aTVGYldnem0wc2xQTFlwYTBPL2plT0xzMytVSlBBODFWU0dZ?=
 =?utf-8?B?djlIa053QlAzcTIzMURYaGdsbkFlZU5QVy9wZmlqN2tvUHpLVnp4R2dmK1VN?=
 =?utf-8?B?enZFWFF2bGtRanhyZHlSSTRVYzM2dTJqOGs2ZXRxODM2NlFRVWdjZUtRM3ZM?=
 =?utf-8?B?cnhqWlJ5cEVBZHRRWkpRMngyNlF6c3BTeGpTL3piZnJ3T1hYa1NhTWV2M0Fu?=
 =?utf-8?B?ck85aUxOd2N5NDVSb1EwWnNORG0rSmlqVEpBVGVub1pMRlQrdnVOclpDS0pu?=
 =?utf-8?B?bUNmc2hudUsrc3dFeitWVXhNMjNzTmRjeDFPeUJqZ3M1WWMyaUFCajVyQWFJ?=
 =?utf-8?B?M0EwUUVPZEd2bkliamZrZUFwMlRkOEpRUXN1VmsraFdGMnppbEE4dDlzRlJV?=
 =?utf-8?B?aFFhRlFvUFRUQ1g5YjhnTTk2YXN4dWkzWU5uZUpGeFhlQkhRTnNKUVkyR0Fp?=
 =?utf-8?B?VzdHMCtJQU1YYjZwMGxXY1FQR2tES0YzcmZOc2srMHErbWp0ams5OGIwZmta?=
 =?utf-8?B?ZHdtUVpIWHg3ZmprRWhMRUFFVktqMDNHdE1MTWdOWUpCdEpDWk8vN0ljTGJa?=
 =?utf-8?B?TTRaR0ZKeTdzM0VBVDRLOEZKS1pieitEUkFXN0V1MzN1UjRyam1WZ3JtRVV6?=
 =?utf-8?B?eFZ0aldpNkRLU1JFRzRSVEpiNWprVE5HY0FTS2lpdm9xeEd4L1lGeXJkVkQ1?=
 =?utf-8?B?amZ4TTE1d1Y2VWlJcWtxTUJYdHhuMEVwTm5INkU4OFlWY2xzQTFPek1nQkxp?=
 =?utf-8?B?RVh6dGhRalZRZUVIYkVEeURaSThtemlhVFZZeWhEQUpSY0ZXRFhFUENqYkc4?=
 =?utf-8?B?c0ZKekRyVlRrZWRqTHpMOXV5dmowNGhoVHlSOERoKzdDY3V4ZFV4L013eG9X?=
 =?utf-8?B?YzN6bDdwcGFzY3JVOUNNSzF3clFWdUJmWk1CZUR4RzF4dG8reFZnTHhzTnpz?=
 =?utf-8?B?aVU4U3RYKzdYZGcrNytyZVkva1cxakhOcjhhdlBERmhMVmJxMUlKVWtEWHpC?=
 =?utf-8?B?aGtqVjR0bS9CV24zWStCSEFVaWxTL2VaYUdDNlk4UDZma2tmcE5SczJGVFFo?=
 =?utf-8?B?Mk4rSitGTlJIU0NqNUVwbnpuWmM3RHIzSGpyTkJjRnV4SnQvQXJhYStKUlNH?=
 =?utf-8?B?MlRPS3htcU1BT05WZWorSDFnTTI0K1paaHdZSmNxV1hPOVR2S1l2TzhqNUVa?=
 =?utf-8?B?Unh1bE1MVjFIUUZyQUpJeHNkM2JrRUFaQ1JQSjg4djFRVVIybHZuQkFNUllz?=
 =?utf-8?B?bi8xZzlMYlpHLzlRV3k3Mm83SnliTklkMWNYcmEyN3BFVFNJamR5ZkVhRTY2?=
 =?utf-8?B?TlNqQ0FPWGE2ZEd2SWZ3RW83bHdvKzZUMTluYi9tczQxQXBLVWlaY2JvcU9X?=
 =?utf-8?B?UHNLZXU2M3lkRWg5dUZiU2xXTEVHT1lHcEFwN1VocmJhUnl0TFlBWURuZEdi?=
 =?utf-8?B?RkF2L1R6UmZlbHNNRW5kYkdnbWV6VVhtNmNScHZ3Sm5zS3l4VWRaWHQ1cEVi?=
 =?utf-8?B?VXg3MGZxWktCZmhON2dUVXY5ajMzaHd4dEp6d2lpaFR0UU9TZGtrYXoxUkZQ?=
 =?utf-8?B?cmhHYmRxOUNqWmRnS2lqYWwxRGVxQlNQaWdjL2E3a0ZoTExacVdUejUyT1hm?=
 =?utf-8?B?SjJtdTBDTjJ4ZnlnSFk4Y1BzL1BWdGVNNUliNExmRHRLUi92RFp4dE5jMkN0?=
 =?utf-8?Q?MsxjJ2NezHUev1dPls?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mSxxF+X19Qof3kLTZkWcRfUU0ibVxtTDMg9/QFDzI7YlE88ZsGTDWGj6n/j5eB4fOYo765P6tRuEpRRKwlGBSmvc3774I451M9hNyQyr5mnHQxHMo3Va8G/BBTB7SQHO0BAc0ttmR+G8oiCMRWpeJxsnG1gO0n07CYBY2eut4nTHXI5WavHGn1DvgxXy1prBm/LPmAS4A5zdbItvSqdS9HI9WFbvNzlqBSHnmRuu18k25yzF/udOLoFitYP7e9zQ/NDXs70i+9mJMzw4rOGnf493s+a6+aS7+nf6K7nKoJPuxXNb9WSf5t/anF8RQjgYH/6H00XROKdKyYVMoXYsCw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB824491.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 365f9d8f-fda6-4b56-5821-08df498fe47d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 18:30:47.2262 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aa6VhWIA9+LRDcx9FoHmq4vOfyKmTLEasVPfYH4Y6il5ZnFtVGOksluWzDYcF8AQNkRkAFDocciwyLxf9zDaOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7650
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUYW50aWxvdiwgRW1pbCBTIDxl
bWlsLnMudGFudGlsb3ZAaW50ZWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDEzLCAy
MDI2IDk6MjYgQU0NCj4gVG86IFRpYW4gWHVuIE5nIDxsdWNraWx5c3RhcjA4QGdtYWlsLmNvbT47
IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnDQo+IENjOiBuZXRkZXZAdmdlci5rZXJu
ZWwub3JnOyBOZ3V5ZW4sIEFudGhvbnkgTA0KPiA8YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+
OyBLaXRzemVsLCBQcnplbXlzbGF3DQo+IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPjsg
TG9iYWtpbiwgQWxla3NhbmRlcg0KPiA8YWxla3NhbmRlci5sb2Jha2luQGludGVsLmNvbT47IExv
a3Rpb25vdiwgQWxla3NhbmRyDQo+IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT47IGRl
Y290QGdvb2dsZS5jb207IE9sZWNoLCBNaWxlbmENCj4gPG1pbGVuYS5vbGVjaEBpbnRlbC5jb20+
OyBIYXksIEpvc2h1YSBBIDxqb3NodWEuYS5oYXlAaW50ZWwuY29tPjsNCj4gYWxhbi5icmFkeUBp
bnRlbC5jb207IGFuZHJldytuZXRkZXZAbHVubi5jaDsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsNCj4g
ZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNvbTsg
VGlhbiBYdW4gTmcNCj4gPHRpYW54dW4ubmdAYnl0ZWRhbmNlLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCBpd2wtbmV0IHY1IDEvM10gaWRwZjogaWdub3JlIFR4IHRpbWVzdGFtcCByZXBsaWVz
IG9uY2UNCj4gcmVtb3ZhbCBoYXMgc3RhcnRlZA0KPiANCj4gDQo+IA0KPiBPbiAxMC8xMy8yMDI2
IDU6MTIgQU0sIFRpYW4gWHVuIE5nIHdyb3RlOg0KPiA+IEZyb206IFRpYW4gWHVuIE5nIDx0aWFu
eHVuLm5nQGJ5dGVkYW5jZS5jb20+DQo+ID4NCj4gPiBPbiByZW1vdmUsIGlkcGZfdmNfY29yZV9k
ZWluaXQoKSBrZWVwcyB0aGUgdmlydGNobmwgdHJhbnNhY3Rpb24NCj4gPiBtYW5hZ2VyIHVwIHVu
dGlsIHRoZSB2cG9ydHMgaGF2ZSBiZWVuIHRvcm4gZG93biwgc28gbWJ4X3Rhc2sga2VlcHMNCj4g
PiBwcm9jZXNzaW5nIHJlcGxpZXMgd2hpbGUgaWRwZl9wdHBfcmVsZWFzZSgpIGZyZWVzIHRoZSBU
eCB0aW1lc3RhbXANCj4gPiB0cmFja2Vycy4gQW4gYXN5bmMgVklSVENITkwyX09QX1BUUF9HRVRf
VlBPUlRfVFhfVFNUQU1QIHJlcGx5DQo+IGhhbmRsZWQNCj4gPiBpbiB0aGF0IHdpbmRvdyByZWFj
aGVzIGlkcGZfcHRwX2dldF90eF90c3RhbXBfYXN5bmNfaGFuZGxlcigpLCB3aGljaA0KPiA+IHJl
YWRzDQo+ID4gdnBvcnQtPnR4X3RzdGFtcF9jYXBzIGFuZCB0YWtlcyBpdHMgbG9jayBhZnRlcg0K
PiA+IGlkcGZfcHRwX3JlbGVhc2VfdnBvcnRfdHN0YW1wKCkgbWF5IGFscmVhZHkgaGF2ZSBmcmVl
ZCBpdC4NCj4gPg0KPiA+IE9uY2UgSURQRl9SRU1PVkVfSU5fUFJPRyBpcyBzZXQsIHdhaXQgZm9y
IGEgbWFpbGJveCB0YXNrIHRoYXQgbWF5IGJlDQo+ID4gcnVubmluZyBhIGNhbGxiYWNrIGJlZm9y
ZSByZWxlYXNpbmcgYW55dGhpbmcsIGFuZCBtYWtlIHRoZSBUeA0KPiA+IHRpbWVzdGFtcCBjYWxs
YmFjayByZXR1cm4gd2hlbiB0aGUgYml0IGlzIHNldC4gTWF0Y2hlZCByZXBsaWVzIHRvDQo+ID4g
c3luY2hyb25vdXMgdHJhbnNhY3Rpb25zIGFyZSBub3QgYWZmZWN0ZWQsIHNvIHRoZSB2cG9ydCB0
ZWFyZG93biBzdGlsbA0KPiA+IHJlY2VpdmVzIHRoZW07IG1ieF90YXNrIGlzIHJlcXVldWVkIHN0
cmFpZ2h0IGF3YXkgZm9yIHRoYXQuDQo+ID4NCj4gPiBUaGUgbGFzdCBwYXRjaCBvZiB0aGlzIHNl
cmllcyBzZXRzIElEUEZfUkVNT1ZFX0lOX1BST0cgb24gc2h1dGRvd24NCj4gPiB0b28sIHdoaWNo
IHdvdWxkIG90aGVyd2lzZSBleHBvc2Ugc2h1dGRvd24gdG8gdGhlIHNhbWUgd2luZG93Lg0KPiA+
DQo+ID4gRml4ZXM6IDFhNDljZjgxNGZlMSAoImlkcGY6IGFkZCBUeCB0aW1lc3RhbXAgZmxvd3Mi
KQ0KPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gQXNzaXN0ZWQtYnk6IExMTQ0K
PiA+IFNpZ25lZC1vZmYtYnk6IFRpYW4gWHVuIE5nIDx0aWFueHVuLm5nQGJ5dGVkYW5jZS5jb20+
DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZHBmL2lkcGZfdmly
dGNobmwuYyAgICAgfCAxMiArKysrKysrKysrKy0NCj4gPiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0
L2ludGVsL2lkcGYvaWRwZl92aXJ0Y2hubF9wdHAuYyB8ICAzICsrLQ0KPiA+ICAgMiBmaWxlcyBj
aGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lkcGYvaWRwZl92aXJ0Y2hubC5jDQo+
ID4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZHBmL2lkcGZfdmlydGNobmwuYw0KPiA+
IGluZGV4IDFjYWY1MjcwNi4uZDBkYjYwNjQ3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0
L2V0aGVybmV0L2ludGVsL2lkcGYvaWRwZl92aXJ0Y2hubC5jDQo+ID4gKysrIGIvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi9pZHBmX3ZpcnRjaG5sLmMNCj4gPiBAQCAtMzIwNCw4ICsz
MjA0LDE4IEBAIHZvaWQgaWRwZl92Y19jb3JlX2RlaW5pdChzdHJ1Y3QgaWRwZl9hZGFwdGVyDQo+
ID4gKmFkYXB0ZXIpDQo+ID4NCj4gPiAgIAkvKiBBdm9pZCB0cmFuc2FjdGlvbiB0aW1lb3V0cyB3
aGVuIGNhbGxlZCBkdXJpbmcgcmVzZXQgKi8NCj4gPiAgIAlyZW1vdmVfaW5fcHJvZyA9IHRlc3Rf
Yml0KElEUEZfUkVNT1ZFX0lOX1BST0csIGFkYXB0ZXItPmZsYWdzKTsNCj4gPiAtCWlmICghcmVt
b3ZlX2luX3Byb2cpDQo+ID4gKwlpZiAoIXJlbW92ZV9pbl9wcm9nKSB7DQo+ID4gICAJCWxpYmll
X2N0bHFfeG5fc2h1dGRvd24oYWRhcHRlci0+eG5tKTsNCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJ
LyogVGhlIHRyYW5zYWN0aW9uIG1hbmFnZXIgc3RheXMgdXAgZm9yIHRoZSB0ZWFyZG93biBiZWxv
dywNCj4gc28NCj4gPiArCQkgKiBhc3luYyByZXBsaWVzIGNhbiBzdGlsbCBhcnJpdmUuIFdhaXQg
Zm9yIGEgbWFpbGJveCB0YXNrIHRoYXQNCj4gPiArCQkgKiBtYXkgYmUgcnVubmluZyBhbiBhc3lu
YyBjYWxsYmFjazsgY2FsbGJhY2tzIHRoYXQgcnVuIGxhdGVyDQo+ID4gKwkJICogc2VlIElEUEZf
UkVNT1ZFX0lOX1BST0cgYW5kIGxlYXZlIHRoZSBzdGF0ZSByZWxlYXNlZA0KPiBiZWxvdw0KPiA+
ICsJCSAqIGFsb25lLg0KPiA+ICsJCSAqLw0KPiA+ICsJCWNhbmNlbF9kZWxheWVkX3dvcmtfc3lu
YygmYWRhcHRlci0+bWJ4X3Rhc2spOw0KPiA+ICsJCXF1ZXVlX2RlbGF5ZWRfd29yayhhZGFwdGVy
LT5tYnhfd3EsICZhZGFwdGVyLQ0KPiA+bWJ4X3Rhc2ssIDApOw0KPiA+ICsJfQ0KPiA+DQo+ID4g
ICAJaWRwZl9wdHBfcmVsZWFzZShhZGFwdGVyKTsNCj4gPiAgIAlpZHBmX2RlaW5pdF90YXNrKGFk
YXB0ZXIpOw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZHBm
L2lkcGZfdmlydGNobmxfcHRwLmMNCj4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lk
cGYvaWRwZl92aXJ0Y2hubF9wdHAuYw0KPiA+IGluZGV4IDE0ZGJhNDBhOS4uMTQyMmIzMGQwIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lkcGYvaWRwZl92aXJ0
Y2hubF9wdHAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lkcGYvaWRw
Zl92aXJ0Y2hubF9wdHAuYw0KPiA+IEBAIC01NTAsNyArNTUwLDggQEAgaWRwZl9wdHBfZ2V0X3R4
X3RzdGFtcF9hc3luY19oYW5kbGVyKHZvaWQgKmN0eCwNCj4gc3RydWN0IGt2ZWMgKm1lbSwgaW50
IHN0YXR1cykNCj4gPiAgIAl1MTYgbnVtX2xhdGNoZXM7DQo+ID4gICAJdTMyIHZwb3J0X2lkOw0K
PiA+DQo+ID4gLQlpZiAoc3RhdHVzKQ0KPiA+ICsJLyogVGhlIFR4IHRpbWVzdGFtcCB0cmFja2Vy
cyBhcmUgcmVsZWFzZWQgb24gcmVtb3ZlIGFuZCBzaHV0ZG93biAqLw0KPiA+ICsJaWYgKHN0YXR1
cyB8fCB0ZXN0X2JpdChJRFBGX1JFTU9WRV9JTl9QUk9HLCBhZGFwdGVyLT5mbGFncykpDQo+ID4g
ICAJCXJldHVybjsNCj4gPg0KPiA+ICAgCXJlY3ZfdHhfdHN0YW1wX21zZyA9IG1lbS0+aW92X2Jh
c2U7DQo+IA0KPiBSZXZpZXdlZC1ieTogRW1pbCBUYW50aWxvdiA8ZW1pbC5zLnRhbnRpbG92QGlu
dGVsLmNvbT4NCg0KVGVzdGVkLWJ5OiBTYW11ZWwgU2FsaW4gPFNhbXVlbC5zYWxpbkBpbnRlbC5j
b20+DQo=
