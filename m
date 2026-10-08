Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C8ACA6016
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 21:27:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB7D281407;
	Thu,  8 Oct 2026 21:27:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hbg1560xYntY; Thu,  8 Oct 2026 21:27:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 63F9C81416
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791494821;
	b=WMkiyo0y7J9HEMXn7TfjJABwmsGv8IekYF6yshhtcecSyVWQX/j0xo1uomQyDJWJEAV7
	 lwx/W8u3RmzQYMy45kUxRKDLL2rgAvC/S/AqoHJyxgWcQJxQEiW07YzPozrgUkhuM59pq
	 e4m+ek1TynCLIy5YW7WtRTHsoaK9CPkNXPgY/qjb0EaZNSNS7rb+a1QF9JP3NjX9OEaHi
	 DXGmUSuo4DyYgeiL2FGeLG4sPm2YiylxiUiOX/EdTU0lXwZldbjQ/13WZMI6Vux8yCqF+
	 Y8dAj2AuFgaEL/kMZnh370IwoAvf2cnJJM/pw2uTBGT3h8d8On7l7Lyr1VOofyO8ccA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791494821;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
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
	bh=mf5RbHD/kVe/BQX18MMgRyTgEuGKN7uTLoBsESsCvM0=;
	b=fWMWEvp6MDA2xAE/600IvsWYdFtGhCIiuwCEJFu8RgqoU8o/jj/pYt6tgjegvBOzKKnK
	 ccVUvScYGv2p0yDq6uZir+PNAYY+OJDHbsHc6rm9Omh/yt79VktBBKlHuNFumATE8b//f
	 zzVNmnVpmNxhI2D7ihpY5GT9r4Kvq2KAJsghPmTeVGmox6LNZiuFf+6uxEIviFHKwIiE4
	 qGY3RuG8mebUCCWBhUdsNd2R8X2W6ZRWeF0F5W8dPsnUa50444qs54n4bDJUUxGInvuYi
	 i0MaWDhZt/VJi/r+kmZWVAXCvwMZFMwHDGI+JSys81RT6aB4RTUl0d4lrGu5Rvp8HEg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791494821;
	bh=mf5RbHD/kVe/BQX18MMgRyTgEuGKN7uTLoBsESsCvM0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hd8YmUHyY1oqEhUaETuLCw2qI+m1nLthjIkGHq1j3f7MJ0x2rKcBYyuLyBSXE+zqi
	 cXilVPyAT4pQeC9zEc6M/mWPteo5RqGyh/CvE/J7lLraqSIkAZAWJymLldvjUIjrXc
	 GMuvyn94nLl7qfLDM+M4MfjaSO4RoKc9ScCDysf57dkTbvjVXpYh8WgEF1zejbBdDe
	 ZqZxTf+dynRIfAj0wYp9iMWEm5r1jYy7tT+W0w7RY0PlmBkXm9hHwXiG+kq0P05t4c
	 XajLWMNSqYLdA5HBWJHFgSCBV9jOjJItANpp7qz8Mrvi39pAlrlbHGUfE4sIh0O2CN
	 hYmlwAvPE2KdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 63F9C81416;
	Thu,  8 Oct 2026 21:27:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A6CBA2B2
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:26:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8C3D56082C
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:26:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T_casxurpqIK for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 21:26:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C5073607B2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791494819;
 b=dnF4tYcuY3CoHNDQTcKLLojN6mU7vUQqB7nh3NzzmugNQgvjXgEI8Phftkua/EdTBuX9
 f/eq9Z7YLbGdFPEnKEmZdNAFxSD2AbiAB60PZm04eM6fjKNSCt5zyQLxaumAPGAio80+C
 F6AfISu8ldbK8VdimEvz13bIfhkIcE8SGiQ8H7n9B8wu6YtJo1R/jZo9G9qTFLEPiE9AA
 CEZOSmqlt041tsJ56Z53u6D6zo7MVxp2HcTssmLOmLlzfKGGeiwv6/cIa7uB9JXMJUQL8
 6duTbkQw3C/WGe4KFzSe6dzQ6mPWocUDcpq90P3Wv1wxCcehvI5gGlomR2ncGcGDffg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791494819;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
 x-ms-exchange-antispam-relay:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=mf5RbHD/kVe/BQX18MMgRyTgEuGKN7uTLoBsESsCvM0=;
 b=O4SpqI2To8nXUxsGT6g6valrTPOw3kw9dsUPH7CyHaPtw7tmD/A14HfA04DvKPSfjb7Q
 IbppRc6QWMYgcE9AdL9Lcm+9IG0fBxQFMe85lnxZVyRKd0lMCdE61sCeTyB7tKLqCnVWX
 08Zqv2TC/FBGdAp1+o5/yZDK5A3aP8wQWE/ZrNmjkqRi9z1QaMHTIOJpGWtYf317fBlM9
 pzVm1njvqPTIh8HAjqPlLKZHkPdHhmniyJSayJoOKn/d1SoMIvvC281mtBBJ8xK3AVGtU
 DLG/bV+s6m9AGdmL1mWTEpV0Ms2l0+q7xkajrB5Upcch60tet21LpJvnEc+QZ6YV1Ng==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Szwhah9R; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=samuel.salin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Szwhah9R
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C5073607B2
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791494819; x=1823030819;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mf5RbHD/kVe/BQX18MMgRyTgEuGKN7uTLoBsESsCvM0=;
 b=Szwhah9RYk/DE/RnPgJ7TvHSqaz1qj1cWue2uaJ8ZatOgR0PCH5+gLyl
 vBQ1fIY12cV/XWiCK2FdOSHfPXBRb9TX2+TN3jKEB/mk+ToAnEtcqDiVl
 UcmH2f2RZksBURjuZd88WqgCjs5SqNHxjYvHoLGRn45ODWsGEIKyd85pR
 n8bNituzoQeiD72Kfk54TCOQ0n27vi/N5ESyHyLtSv0Q9NQXUpwqk2NL7
 8CfTvweYHQMR9upSOJBHT/d6dLuyyEyvztoRchhYFnud0TZiELMFOJkbQ
 VQoryjKhc9L96zqIMs7FIijAX55ESh3hPqjuNauTeFpU9SsMwhGUzo8dP w==;
X-CSE-ConnectionGUID: OXcKtmI3QU+Xrf/aDVL6bw==
X-CSE-MsgGUID: INU9FdRQSUOZApZ5zgsygw==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="316653"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="316653"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 14:26:58 -0700
X-CSE-ConnectionGUID: t793GzGyQYqYtmAEufT/yw==
X-CSE-MsgGUID: M1PQdSPCSxaK6anhJm55CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="597903"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 14:26:57 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 14:26:57 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 14:26:57 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.40) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 14:26:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s546g3ciNL29/7kCnC5kdzuNtlXK2/MQSoGcp2V2OfBxc8709GaXQzguyjys414LdQijGRaEWWZ0W/qR8Ooh4hBCpbPz48+45qV+/32h0GBvdTr1icKNqCd2FBUeVkZS+rRgmQm0irxxiDGiHIu9j7AU9aTDBYZ0MthH+hf7w5UcN/XpO0OIBjcHIW5DuL4kg9b1bDC92OdrWmir05XMuftCww43Q4fdZrK8RdkfVvKvjnqNB6H5GNKo4RwGCRDfSGwz8bWLLIH/O0LRj/sEmm8j68t6hqExQ7RAG48qGZrf5RgZBszkuY3nJ4OsDeE+Ppg6q7xrnD61/V1mM6j3Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mf5RbHD/kVe/BQX18MMgRyTgEuGKN7uTLoBsESsCvM0=;
 b=MsmTWN9j8yyypOVymjtCP4AFPSmvrZ7yTVnzukZngHgf06VTfasc/IvCkigsRrbuDik7R3r5dNU19mEHzLr8oSET8j54FPamNacsndu2LXWliv/OlGbiiUA+8++bEuS4rjF5PSKHKSRZfpN0X/fAkBnM7ulbDHxLJkNOoPGNYWND1YLg0rhlTp3zB/m0YpBYRlctdCko1szX8ZKfRqgUgpLVg6LdzuKHncTF4YnxArDzm02AmJzTHGMMCEduaVPGp9IAuxzu/qlR3dJ/qmCakW9VBLVvoKIT9NuE7DrSadnfwr5HNHtwl2WdANmunY4NRUfkb7pTHKVQn2Gdp9gUIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6422.namprd11.prod.outlook.com (2603:10b6:8:c6::21) by
 DS4PPF8ECAFAD61.namprd11.prod.outlook.com (2603:10b6:f:fc02::3a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 21:26:54 +0000
Received: from DS0PR11MB6422.namprd11.prod.outlook.com
 ([fe80::d257:46d9:13f4:adb7]) by DS0PR11MB6422.namprd11.prod.outlook.com
 ([fe80::d257:46d9:13f4:adb7%4]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 21:26:54 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH iwl-next v2 06/10] libie, idpf: move hardware irq info
 struct to libie
Thread-Topic: [PATCH iwl-next v2 06/10] libie, idpf: move hardware irq info
 struct to libie
Thread-Index: AQHdQfHcaRnDgWr+KkemqmgCllKPrbb0U2Rw
Date: Thu, 8 Oct 2026 21:26:54 +0000
Message-ID: <DS0PR11MB6422DE4C32495DE92B634DA49B932@DS0PR11MB6422.namprd11.prod.outlook.com>
References: <20260911124921.2881348-1-michal.swiatkowski@linux.intel.com>
 <20260911124921.2881348-7-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20260911124921.2881348-7-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6422:EE_|DS4PPF8ECAFAD61:EE_
x-ms-office365-filtering-correlation-id: 131ef5ea-740d-4c5f-8fc1-08df2582e02b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|10067099003|38070700021|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: 1l6HehlzL+Fwp6byg/wviMYDeJsqb4tTYtlc8GCv+0sGn15zZToLA8QgAUdqttWJ7VvNRXA08mwwS7QTebmU3BPCN+h4MbpKWbxn0v2fHCAkV1G4ho1aJwlFwRV2J256g1NEqK96CFC0ZkPiMnB84xr8WyH1HKUnAO7ixefLSLKw5Jp5iWr1ChydF9TlrSuivUFS1bU09qKBD1tgTquvMHdV2S0MMpROK21reENIXohFohJiS3DOKBHG7sgLcUmonInd/pLtRnXecPEtNO84A2nb9xjm/UWqIFCWWJcJ7Dn7KceUx4KeQXyBVYZXzK+HsAfMjYODlL8YHZNNw9U2h+tUG6zeyJVgdcCZPLu5fQGjJ6v7sz4N8HjyTl1BWZz+wml3mN4w9+zVs67444AABhoOPdGuOazD1ijiA1CMqtZvU7kLcfzNN6+2qZu9nMBiTGvtwGnaxGG8hvgM1tH4PtFXVFe7l9nde3ia6CPIidAPdEdVVtw5++uenRPA14RHNvU/O2o7uS1hoD4RZ5n4Z/ako2d9PRhF8wDkiiG8opeNePu9glKvTk7Nf8wzx6jx5MSx8tlMHje4MonN9z+jbQGCaxOklA1iXYkgKvKlFrtY+TiR80vPvzzive1p12615Cegk2ACqRjQiSdGfMhrXxRAQuMrbHjIq6boI3GoAIny0rhIoDCu8EAOmfvkLatwK3wUqLWS5R6xvixGsnqr2veKqfAAa7YQy6LGlkA9TdM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6422.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(10067099003)(38070700021)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Sgg6Ptj4Kc1T2Gdsf7wzjutEV1iGqGwI/BACwE0plMr3Y7NCSQvnqysdvD6e?=
 =?us-ascii?Q?UXOBf6Fq9+d4sOuYQKSlSIYv1VF1tZClvRF9v13GHBE7dRe2VQKzlrmESInU?=
 =?us-ascii?Q?5u+42d9QbB4FD0tApreJEi5Ct2roYN+bif2zlXZcer4TFxorBvX/gxzXUy1H?=
 =?us-ascii?Q?McrVbD275R/dXP8rS6dswBqQ12VCYHAY+n2/ML906m9flbLkmKZPfBlPVRU3?=
 =?us-ascii?Q?zyWMjULWuHm62ZjqrJzZTVxyP4vzwdcpoIAev6D4APZ12qGsiwAqvZy0EQ9F?=
 =?us-ascii?Q?CBM9ov7lUqXMR1Z2bJt+R3EMgHp4ah/bPDUE8/Eh1Q7ZHRw4ikp7NffQnl2H?=
 =?us-ascii?Q?a4lJA1xsM08FzyOfV68JAcT7kHZc4YGBXTGr56vT2jZUTVR2kulW1Cere6CO?=
 =?us-ascii?Q?5wpbrw38Z9kWC+dvuFbiW2x566HHkfMv+JsiW7K18wzUi8WqScmTLFhUmr3E?=
 =?us-ascii?Q?PY2fRti0UjCUIPmq8dMiquklW6B1ETiKb/jbumjfNA35HymKpPLfxba38DEJ?=
 =?us-ascii?Q?CO+i3VnHCaDYMsVUFFJldEbKbPMJfJbfnslaRftP0YsCW9zj+prnWg+qpN1d?=
 =?us-ascii?Q?nfc6nx+YVRLdn2TGj3HEe8O6fOtxpETkU4zkLKnLPehEGJzHLFU2j6mzqW1K?=
 =?us-ascii?Q?ofFiqGA5azi4Fk4ilKyhHpENLwK6q3qmZLh6Xfq4mrD2ykIQBlSnPZjX4uq6?=
 =?us-ascii?Q?/COG4eOPYRauFzK6BtRcKZvuSu+z7wiCCpGNyT8DHq29yr0E3lF1NThvTIym?=
 =?us-ascii?Q?iEwn25y5+2y5AASVd8a2AP4J7ETZQXjyK2Bzmhrur+qA5CWfIavRF/TX/R87?=
 =?us-ascii?Q?zWTTVFNLQ/1QiuJDDqr5CDlAwg0f/3UMpZGdP3LXU3kJdxwv1JqfZAF/Dmm6?=
 =?us-ascii?Q?BfXRqoXeokZe6IkPsQRDj1UZrbdfeHM2cAMdEBu2UuLAGxsLfkKBXBmIgsFR?=
 =?us-ascii?Q?zxl5uokBzjGA23KJOVyx6SvW5Wiwl4W6x15cbtmm5tCO7YAXsZNwpPH+BOzr?=
 =?us-ascii?Q?/CBxn4yUCTDXmczNJjz/zY1yeW1rc7HWLGW37lYKqQL+uXWG/jZJDAJ2Gi6m?=
 =?us-ascii?Q?ntxscZHRciI7tmjuth4/DjN9OlRRFBXD4ETGwO12Hm5ZhjHOesG/4F6hACXR?=
 =?us-ascii?Q?QQtXMxnqE9uZAhRjZxVCUNLzx4/LJC6X0iHzfI1Joq2F1u4qGB6J1b0ZSTqO?=
 =?us-ascii?Q?thoFD/6kImA6GzCIFsFQR7MQxhpPclf7ywMj7nOSNu2f4vai1Rwb5ar3F/LR?=
 =?us-ascii?Q?GLkYhrHeZPvUy/0ZvqDf6qa9omQ9SGjp/KiyGX338vROOIMZV3gSvWrLbWAY?=
 =?us-ascii?Q?9yeJvG2gCwS+PM/wYCmJGFIXetOs5RPmVv+7+2hO98AKkFbMy2yCIVk6BStU?=
 =?us-ascii?Q?STpHRiiQAGQ9BSv+CUxdXotko9bR0aF61jBl0v23HB0GSulP6yySsuHrYzHr?=
 =?us-ascii?Q?Kjyocg44+jsTEZPgcZ48WGuu3QNDCmQRKmK76Rq3XrSKTYnmpgzr4rZiuo8n?=
 =?us-ascii?Q?p7pQgpX2Ych+dkpuPYmnlFlyfGIXJPMVeZBnBF0Hs6PhaUTthjq44+1lb6NI?=
 =?us-ascii?Q?W+sb9btPjE6zyUn0gxYubwqvZqdpBiI+qcC+Zd0BCJLWctxcisC31HXXZReX?=
 =?us-ascii?Q?u2+2FfxF+T1K8WCo+VrkqrzAz8nQAo4F8CCooTL0sUUClbz7mGh4L0CJaRv5?=
 =?us-ascii?Q?diHO+SzRgNp+2wXRgBHvYTD+oGWv74rI6COmFHHyKPX7aZET?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZfoK5RhKjbqMtqhMFk1e8NTzI37Mz2xQr/+7IVN17wnmt6Gm9j1SNDDC3lPc/7MDPcIetUUQig9npLcbIxboj7dWaY0OUMaoipWZr17CiinWA6kbF+dtG/5N3uW4LX2KHMJVX2aCut5dlnIe70PsGu0oQvTEW+NQVvuTe9inu/EoQ4QW8SmnSo2cfsdSolf4yW3YLiIOFtSxJpJGL1BTyNaAsfflsU48rs1tM/OmWvZ2WTTAkNTf/urEgYHnylJCL4f2aet8BjL1zwO1ty3A3rh/Kv/AcVviXA2ahFLk/nPRXYdzn9+cB/THKNMJ9qXe81oFYjVZ1DCw2qPKfNBtGw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6422.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 131ef5ea-740d-4c5f-8fc1-08df2582e02b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 21:26:54.6238 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j38LA6Wkje5rkT6q12s99oQyY3qJwW6oZ6Ab6SyORbfS1jZvin6+8xpAqNkse5su6QuaRpXDRK6W4B2ZVxqWgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF8ECAFAD61
X-OriginatorOrg: intel.com
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
 <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Errors-To: intel-wired-lan-bounces@osuosl.org

> -----Original Message-----
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Sent: Friday, September 11, 2026 5:49 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>
> Subject: [PATCH iwl-next v2 06/10] libie, idpf: move hardware irq info st=
ruct
> to libie
>=20
> Manually move definition related to irq info from idpf to libie_irq.
> s/idpf_/libie_
>=20
> It will be used by idpf and ixd driver.
>=20
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
Tested-by: Samuel Salin <Samuel.salin@intel.com>
