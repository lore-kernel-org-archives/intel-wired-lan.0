Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8765BC79F80
	for <intel-wired-lan@archiver.kernel.org>; Fri,  4 Sep 2026 07:00:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D8AE40B2D;
	Fri,  4 Sep 2026 07:00:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a2BprMC6VqsD; Fri,  4 Sep 2026 07:00:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 687554086E
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788505209;
	b=AASkeQ0q0AcRjXGACL4/tLn2dswKZdvopzpR01sKH66TcvbouVI8PGkjP70ZLxvmO+GR
	 4bb1/1hrXf2YV8CJLeQMX/9hCOA9WXRniktP3btqJQoFdsSnPwTbJ1WasPGzL6jPkaA8j
	 MahQE1CjIdTLnilkUGf4vV3Z5sK9zwFLQ/IHfQh+Z4e/TBbkUGhZ75igelA7H7RVkxW96
	 mEeUlKnbA19cTe1BTZekhJgzbAI38cOdZM3to0i+Q+6KyLyce/r96Fb0Up5ioRvo9nOXn
	 X6rrLUgYvFAemVYQaLYBTdDwShRKiKNhJdlO/2JEmUf6GBrmGRkJfM4VnV5OLDWWUzg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788505209;
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
	bh=BBS+jgPt3oLPamYVbtCKsIO9ZXWBCxETD8VNmaRFah4=;
	b=KAf61H7SDzYmE6AYK+hO1uIuBPOOq4SltLFMaLNl4OWl6+ez2LX1wbh0uannKLY0PMEe
	 wL0vULNg8J793V6uxaiT6bcK7XtueSG8HuRVVrDIAkbshZfdXjhlNx7NdIcTWZWKqJd8I
	 HaWxRWfF682A/Vysv+Q2Hue5ooi0IrRZXg1BJCUmSbIwVKtM4BzpPGXwIxZ2+yWpS3QDN
	 /UzO1A+FmXwVoIarF1sndDIn1ZQOj795OGr3t5DI6xclPRmmIBDJfOeb5K51LjOKAE5ad
	 ASqe2EVCmbHaQXH+LVJ+oV8RNzBnRj6yVKDEFPfZi2IK0Y00QRjTVxSzOilVhs8EqYQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788505209;
	bh=BBS+jgPt3oLPamYVbtCKsIO9ZXWBCxETD8VNmaRFah4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dc/eAzVZ9kIJKCfHnBogSt4VWuE6a0SGq505bCWMjydbrPhmwyuBQWQOpdAXZsAnR
	 VYd+Ppj9RGD1J3vnJBHm7yv7H9PmIDnYxtjHcCQYCDT1AiByPl8+ygIhR2j4qiP0qm
	 FYC9FwH7RBNjMLGLOr4UeegdCXBkGS1+QE9bsEHdDwUD6A/LOVmJaK34X/IKtHEqMf
	 XB5sG9yQ9bBFxdfBaNqWj3FTrhFl43xdx1ZG7iI1xiX+PGTW564R8/GS3ozh1oRGmO
	 cc6mauZz84wP/SWl3Tg3iK4Kg8VR0ysGlnzAs8P6g7Ippf99WGPaWlRsmS37TuYtwE
	 YzU+UN9QLVJUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 687554086E;
	Fri,  4 Sep 2026 07:00:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9965B2FD
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 07:00:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7678A810E9
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 07:00:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id veI901tkoum3 for <intel-wired-lan@lists.osuosl.org>;
 Fri,  4 Sep 2026 07:00:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8A2FB810E8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.16
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788505206;
 b=kfEoj8qkhsQajnZy026bbFtZU0eJvJk8bRtUNKbK6NR7UuY78H7cCLF89foJvWdLuXB3
 4+uvnftd6GGP8F3VpceWKHW8toqMw5qSItMEDO0+zqVNJ+D9Erj1XndnatCOWYzWDf2FZ
 Zg+HIh+vogpzc/Sg1n6zHY8lyKJEhCSWEh7vtTtlX5DDXk8l1w9Lfu6d4u2rz41hploeK
 UJHrMMlcxzZdazZVY1+ZBcbFZX0RwvnqtMrd9gYiNYkwzStWff8G3+8sljKmYghMV8rQc
 DSevahNwGps8jD9sxcxotWaOtVQnL87flBGv2woj0D/PDbwSJmnhcELo5WCc86gSPvg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788505206;
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
 bh=BBS+jgPt3oLPamYVbtCKsIO9ZXWBCxETD8VNmaRFah4=;
 b=gZuIdGN83psRssp/cgPR4How64IzvUYFQDLFzvmSJ4h31+gtOauUtpfa+87m5PpvN/Sl
 BVZs92h9xf90ifaLOxaoMIQXd8/mE/FxCjjZn4VJ4xaitvk2gsdMwb+9qi5FkOx9IgHAn
 jHub4WoSvyFlw/gioT16Kz6qqM0+FxiJ2KdAf1XpyAVWhaOhlfBjCERisaWAKaqRpFdPq
 fiWymw6X3mku2+JPoYrOhec9N181wjwP4U2PEOPvgGXZOdro1r/UqS8eNHk/pLdomoZe+
 f1x8yyWaEjGlUVWanrkp86Zte6lEvAgbLm46td9qbSOlno2OHyy29wdvqabIldidxHw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="kcBWTt/A"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=sx.rinitha@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=kcBWTt/A
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8A2FB810E8
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 07:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788505207; x=1820041207;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+sJH6FotxTI4MzqijtEcQJ8HoHqfkAWbXtwiPmtXigc=;
 b=kcBWTt/A0yfEYEgYvE2Oa7e5NA4fL4f/lDYMVNbV0otUAAf3kehMHgCV
 TGrXbXdSIzFaSALepJqukxM/iS60o4aYRqlXrwRzdXsoaOKMRKi2Sk1pL
 ncafJRvTIOuXSki+Jny0cHl+RQe7jJoNHiRooCEYiCaCXsPs87VMqPOJd
 eoWUDnsFAcFpXzP0mSJpBMYumbFCV2Zaw6sirc8K463NkRQf9OLkTlCHu
 GzwcxD7lWlpsXFcIqc+GmkMrUDeIyPPlt1zWqaCWH7nu+3h6rPawaJuvs
 hWCeR9v7eTVk8GDaj6n+s8azWWuSKJo+yTwmLGJg0ndPc3ZjPb2R92Ccl A==;
X-CSE-ConnectionGUID: JbE+ZSwOTUOlYR3XGTDSDg==
X-CSE-MsgGUID: 1viKsq0ETlminrRp5o+Uaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="76556233"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="76556233"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 00:00:06 -0700
X-CSE-ConnectionGUID: 4LZRKpAgSlKLt6Y28FEj5w==
X-CSE-MsgGUID: AxMcu+HBTOCHHdMCZb3ZGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="265614179"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 00:00:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 00:00:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 00:00:04 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.41) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 00:00:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dYtsiNmVVhJkFpJcv27I8vDdOU4An00Yl5W40zWEMpcXEFlaxFvQ4wfM4Nro570bitZXjBgAHvyo1LYiGcEgpT7WcteO4BT+iimf33Iva95xqai9MKHnTnRte4UWs8cRxINuby3l49gAmbXGAm8J48GzPWsRJnwjvlDOSh6OnsRgf+cPeWIxm0XbY9kdORTqPM1hCl38wtX5bGZq/e3MQR7D4aS5M/ZXQpTT2KzRLOi8XEjVhQeexkeqeKdSeoC3//hPH3znZJ/75GM5iRC1/3iyRDgHGJUNdeYKGLjqrUrnuIeg0kXsSVeZd4knELfTKTNOusTiHB53OjOLbbo8fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBS+jgPt3oLPamYVbtCKsIO9ZXWBCxETD8VNmaRFah4=;
 b=jpCIH6jlJpNUlQey1FCCkUXcVfauEmp3yGkC410iWN4uROIKv+nIV6wxZ/OcLO5BoxQEc/k+SlLdTa7FQ/X9EjRKRj1CfSQnldnJfNwXkEqm9exloOiBFnItcS155Y3pOURvJkx0NOWump7hJbnMKy2ptSxrZGEcfqCKDyRYiMTi22nM11bF7hMxn5SE6FcqsiwNLrtNWMV4ZuUkidmdo3zbF49jKGhkxMTml7cLoP0JaWO0nliapGQPlm2IgKWCoZ3jXTiFjt4kO8eQI4S1a43fDljvyD8BQUIpbZCFUm6T9SeFj7VixbfuU4JS0F9E7+txVWwgaVtLscUCTLmSbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by DS7PR11MB7691.namprd11.prod.outlook.com (2603:10b6:8:e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 07:00:02 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:00:02 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Penigalapati, Sandeep"
 <sandeep.penigalapati@intel.com>, "S, Ananth" <ananth.s@intel.com>,
 "alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 01/12] ice: rename shared
 Flow Director functions and structs
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 01/12] ice: rename shared
 Flow Director functions and structs
Thread-Index: AQHdChZKg6Rwj4116kOFBvTjLeDHQ7a+MlpA
Date: Fri, 4 Sep 2026 07:00:02 +0000
Message-ID: <IA1PR11MB62412F58038EA6943477AF9F8BB52@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260702103007.97020-1-marcin.szycik@linux.intel.com>
 <20260702103007.97020-2-marcin.szycik@linux.intel.com>
In-Reply-To: <20260702103007.97020-2-marcin.szycik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|DS7PR11MB7691:EE_
x-ms-office365-filtering-correlation-id: 16c0b277-a028-4091-af68-08df0a522483
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|22082099003|18002099003|56012099006|38070700021|4143699003|11063799006|6133799003|10067099003;
x-microsoft-antispam-message-info: wuaDeGXFBfmWLLD1kb6Rf3FrXt/8EF69RsYjn1Im9MxcRE6wZTnEmZ5WkraRbhj17fwfs8c6CPW/2SeYKoTHB2VyER4DN55czWs/Y3oQXL3yHAxAML+cUEXPvehax47SrGzUcvRyVNwcAKy5uvgvSwM+Kelv22kXXT4v806/RvaOpnU1S7rEnTP8nMYiWhevkO9NudZhAC9dS6JlbTVZJE6LqjrV6UJRVHOOOsjYKzFAiqMLsiCGW0YC19yY7YNmxEH6Ud2S4g+qvBH6QDru8JDNCC6yBa6I2X6yuXlcpf7HNsbENfOtbogyGawDe2IDTTJ21YTE0K42d/F7s8XAlYA3DxgfwkvgS2KtscRkKY4sZxykp6FZeEZYvgYEki9+MloAz+eTe3CnEEFDy9+cwbjInKrxL9Y2ucD6Tn21ZFN/Z440Mp4SUpQf83zMYpRNDg7lQkqFQ+kAuKn9kMsv1GH01hDwpg+IfCIvHgFB4BWNX8kvN0O2IbgOU2L2DwVcOlsvb/bjc3zpTvECrCYdtT96ZGmsc1bS7V5yuxO/rsWIZb+5XAC9h+mYG0S4womG7pMQn6PsWRIFbT2e/mbiWKc0wDrUPMLqPIJaWiOLqFxE+Bp5lwhX6e5ewiHruTZqHPaGCQBDchelrJCFaBuTg8GMqUChcbKXtSknxuYNIUuzvj5R8nJO0hV7YbfoAdvquHoLFBmfiQDnPXNRoppg9y52XXI7nKe+LZZ6vU8EAMM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6241.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(22082099003)(18002099003)(56012099006)(38070700021)(4143699003)(11063799006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1T/d0jxq1eiJqqOBt68SLOMtN6grvJDZmLWKZ3MujLgXBIU4OmZyxWtNlTpm?=
 =?us-ascii?Q?DjAlPaN7yN2JPELXih4vgiBIX8Ju+vK/uie326TjsIjVi1l5QcSTkmvBDFxB?=
 =?us-ascii?Q?2p+f50N6O6hyPEksqdw4KD847nygiFFFwa7bLzrbAI++5bzoTodRLCZTYahk?=
 =?us-ascii?Q?yEPAQpZdoqliXWhJh9mZf5v9FZ8mfF8PFYasOl8ahvu7HoVj5Q69z4/ZtCuU?=
 =?us-ascii?Q?fnAFF0tIZ6TLpJ0GdyIQ8bZS1HtNQlZQPpZFOYBsJVUp0EwnLOf9/J6T8itk?=
 =?us-ascii?Q?a0ylo21yBwtPqxa932c9uItxZQKNq4Zb8gv/zm/C8blSHfFjYLNIR5rEUKxO?=
 =?us-ascii?Q?YeQ3Q6FYsuF5QlSGHtE1LDwARLjGJojTLlJHQ+e9W0N4VSM1hGkvqDVCav08?=
 =?us-ascii?Q?odI+ja5uB+ADkeX7mYmfjpKSIIuPdR9ha/cudpnzIKnlFfLeM4Tg6MLJRobF?=
 =?us-ascii?Q?SPOI3S1Ygw19/XUyqQj4XN/bcrMXHPCVeg+gqT1Sl/u5J+aj/NVnqrxyQCXF?=
 =?us-ascii?Q?9uMkXJ/OBrVe6W6URkolRo6NOEinvI+IcLDqQidRk/4ijZAYxQUZ6WxZ7yzz?=
 =?us-ascii?Q?wZMCsX9q+D53u6U0QjSzhYsu4SpUGZKzYGHngNKriz+SiDaL1aCKI2N/UzcO?=
 =?us-ascii?Q?PPu+Hd4lpQpJh5PHgUJhIszrcfeULqhdr5uslnaNbGq9ssBd8w0jRCBeEpAN?=
 =?us-ascii?Q?cOoeBmbcb5tVKoYt5w66CbI7bCZdXG7Bgwt/pK9lcaZn9FFHNM3NnuJBr1n1?=
 =?us-ascii?Q?3aNeuxisKmdf8Nu2soN9Ttb3itJxD4LHWRaLNoGJkdFf8ZlQxy+LF4m1telJ?=
 =?us-ascii?Q?64lxeX7oI++8ErgBvpL3tg66PenuZCElM32EpcnR5xeUT6cEtxd8PfOGLMoW?=
 =?us-ascii?Q?SJ2gza+zv22ClsI5eaBuWBGijSkfQoqQxwlW1gK5hYe7A/dt1NbzMAH82hHW?=
 =?us-ascii?Q?/AQyWz6+2dkqFnf6eygOi5wso5UZWHkfdXdn8MTass/gcCJRbISlN6VQlpdh?=
 =?us-ascii?Q?VfBJwAIT5FJPEzb8WUZEm4nsC5xd4GP5wT6GcuikuIQeYkn3tx4kSCAJBEPT?=
 =?us-ascii?Q?rduUfe6i3pUBQ2ZsfRFllWxQoAsF2qULU1P9R8bLjshf0UjLC1/fBglOY7A0?=
 =?us-ascii?Q?v33Ecd1WDQXwL08S6L7Fn/XKFJqlbZHj4NDoAJtdI6Cey07h9wPAmfI2BR/f?=
 =?us-ascii?Q?x9mjVgVhUNWIaN/5OVxUVajcEjUzhDYFnkS7v6LDDE2+xGACr7tVdPg/fGBZ?=
 =?us-ascii?Q?N92MnT9oLlDkJdI5+SzsCcNAVlCHAfTZrdKb+au9HkX1lAEImIFeeXJteoIC?=
 =?us-ascii?Q?IjF4sjMRGGVfr0ICLsC3p5xH6BqSka06Tp6SrfkFehRpD3pKievcGs/sXqrD?=
 =?us-ascii?Q?GSEK65WDHImtcNz2WYpW1thxwFhVn6bCmLgFnSXA76eigIOqM595ad5gyxbK?=
 =?us-ascii?Q?Ee4owyfELHuHOTl/SzimvEW5U2Yzd76BmB0K7xNW+vgVASnS0RNHwlaKzbmc?=
 =?us-ascii?Q?GEzmKtwvOfTzFag0U/eZGLnMpazj33DwFsn45BRKIGZetxQLQx7rcuFvaVqC?=
 =?us-ascii?Q?lSlgC33POCBrKarudhgZLk29xni0XMRQbX5i0RLlplt8jNaMOsROfRky/ngg?=
 =?us-ascii?Q?sJ6uTzafOAbeb6CjIEoRjqjSKbbDKc5vhbR7TKfWx+uWcuNAVlrowMR1RVDJ?=
 =?us-ascii?Q?D41VbmlC2EoIp/FmWIjaivequ0tNfrUCnvdkPRYA9fOuRBws?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: h5n7sl2X2Wub9bQLQXTFh4NCX+W6XVKy/YJ6Uom1hBflAl/3VUwnlmyIkDzNwauOVpDL2k8gt4HvwMclXSLqppj+aRmp8WVPicSjqlCdJl2Otj2U3X4N6OdXR+cyfZgGCPKFL79yOewj5pGkyKHCKlLbUneOriVrqTrI7SOLZY+mumTDzyMcjQa6wHUfGfySe31XRWHf2QTKcCxmk4To746utPCZ3bLrs+stSF0O4ZQeVQmjBaRB52VD+XCseY+eWkquT6Scz3wA8z2M34g6mJQeb+46Y1N2/m11ji9VTGyUs4l1bxBRxOfx7mjhVNn6xm13C25Ub5KZS1MTg1RWzA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c0b277-a028-4091-af68-08df0a522483
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 07:00:02.5573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hoI0e/ZtxEs4sGsMcTsVyYQaNmG2MGi9SiXewH97qqFf/IvLaoiBLsuUBDAF/It2zmIkOavDmCXIyFjoxrhDZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7691
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
arcin Szycik
> Sent: 02 July 2026 16:00
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Penigalapati, Sandeep <sandeep.penigalapati@i=
ntel.com>; S, Ananth <ananth.s@intel.com>; alexander.duyck@gmail.com; Nguye=
n, Anthony L <anthony.l.nguyen@intel.com>; Marcin Szycik <marcin.szycik@lin=
ux.intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 01/12] ice: rename shared F=
low Director functions and structs
>
> From: Tony Nguyen <anthony.l.nguyen@intel.com>
>
> Rename shared Flow Director functions and structs. These entities are cur=
rently used to add Flow Director filters, however, they will be expanded to=
 also add ACL filters. Rename the functions and struct, replacing 'fdir' to=
 'ntuple', to reflect that they are being used for ntuple filters and are n=
ot solely used for Flow Director.
>
> Rename the file to also reflect this change.
>
> Co-developed-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Co-developed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
> v5:
> * Also rename fdir_active_fltr to ntuple_active_fltr_cnt, as it will
>   track the sum of fdir and ACL filters in future patches
> * Also rename ice_fdir_update_cntrs() to ice_ntuple_update_cntrs(),
>   move it to ice_ethtool_ntuple.c, and make it static. In future patches
>   it will handle both fdir and ACL
> * ice_ntuple_update_cntrs(): join variable initialization and declaration
> v2:
> * Also rename struct ice_fdir_fltr and file
> ---
> drivers/net/ethernet/intel/ice/Makefile       |  2 +-
> drivers/net/ethernet/intel/ice/ice.h          |  6 +-
> drivers/net/ethernet/intel/ice/ice_arfs.h     |  2 +-
> drivers/net/ethernet/intel/ice/ice_fdir.h     | 14 ++-
> drivers/net/ethernet/intel/ice/ice_type.h     |  4 +-
> drivers/net/ethernet/intel/ice/ice_arfs.c     |  8 +-
> drivers/net/ethernet/intel/ice/ice_ethtool.c  |  9 +-  ...ce_ethtool_fdir=
.c =3D> ice_ethtool_ntuple.c} | 85 ++++++++++++-------
> drivers/net/ethernet/intel/ice/ice_fdir.c     | 38 ++-------
> drivers/net/ethernet/intel/ice/virt/fdir.c    | 28 +++---
> 10 files changed, 98 insertions(+), 98 deletions(-)  rename drivers/net/e=
thernet/intel/ice/{ice_ethtool_fdir.c =3D> ice_ethtool_ntuple.c} (95%)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
