Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD17060A2600
	for <intel-wired-lan@archiver.kernel.org>; Fri, 23 Oct 2026 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=bK0WWIqC;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a3OYFQVf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8FAD7812DA;
	Fri, 23 Oct 2026 14:56:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2VxO8XnTGdL8; Fri, 23 Oct 2026 14:56:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BEDE5812F1
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792767367;
	b=tNaB6a6EZcMg76IdZ4kx11DIi5ZMFyyg52nOZzwS3Uxrx9HYg1KtmVtRzl0Vw67DC3Uj
	 AP02/oaw7iQg0uEgVOBdWCnwegEeWndhmoT5rKUagb3psCyBJhO36AVccOjv7bSLf3foo
	 L0gcoRVVgC2+VUQoMi3CS0+IOhjJqpo1neXg82PGbC1VDPHOzZSfLnrqB3rN3GKsCS4F6
	 zZ+78RwmVcWt7TuLhT4XtsVTMc+zEoR8cyOCokGA8hBXycxGT8nbWSpFOwCc9wIPxHbHm
	 kqyV2qLKH6+D1D3ibCYAEoBfydL+zP6hXquvPZcBWvTX7kKYs70H5zVPLF85wEMunYQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792767367;
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
	 x-ld-processed:x-ms-exchange-senderadcheck:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Id2OmN+57cw9Ogedd082qIAuj5N47AMPBJzJaTKNkcA=;
	b=k0bd639vemJbfhaevTsO2Fue1jjotdTZd2yMj1s11/L4IYXW1GMhZqLcQ5vUvrOtGPR8
	 4eFeXX51UIQGMJ9VUl7fNdPX/VvIKbz4c0UZ3uawMBTKBDMGzdZhC68IyFhfe4fdUDeBK
	 FFF/xcOIcdUYxL6rZL86aFzVMuNB+JFoYje0lVRS2BqFXPR7P88z6v5cNQAzqa+6OrtvM
	 BqmakJGDhvGOw3EQ72gna5vvVfG3ZaSM+nmEtWofv4vo+hpCXJ8QRvSfcG8sUmTRJGGq1
	 u46JbL7DR19rLidYasgEdCw6Enkplp9haqRvIQRBLb1s9SXrmOTU2EQeIlr/5vhXmwA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792767367;
	bh=Id2OmN+57cw9Ogedd082qIAuj5N47AMPBJzJaTKNkcA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bK0WWIqCAR/EV3NYMSQBVuxRZ6k5Ze3l0lstomcLsxkQ+QxUA/6UHGvW/zsPwOMz6
	 LQ39H/HMuBm/Hfui501ddNoufz1YTL1LoePEPiMJFdZEUXebiKNQ5dAtd7SM8OfYO3
	 Afc52XD+VoGiCCixX9FpDlevVGbKf14hSKEkBUCHs7Jq0VnbNmh/7maGKwC5ZwiIPS
	 neuJ38Bi21qEMRIUjimY3eUAw6wZ+c1FkBdH7rEUUASi9JpelhJKsL7MLSf8AoUq1f
	 7fI52HN4ligVGkXPxc0GI1nhHeaMboYDuLEvGL2JFguWH1E+485cYOOpfevfwTicGp
	 ICTclrFPxNvRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BEDE5812F1;
	Fri, 23 Oct 2026 14:56:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 225B93C1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 14:56:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 13B1C409C3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 14:56:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2nh7HiQQHm5A for <intel-wired-lan@lists.osuosl.org>;
 Fri, 23 Oct 2026 14:56:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2F9574096C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.17
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792767366;
 b=Lh4DXDMGeV9lQyBlyoFkqjZogVQ1OGneRkKwJn4hWZVvFBSRY9qqnruIRW/EQr1dVuOU
 UHaIUmq9g6rN47zLHKkApBJ/OU9Jpt8ze87vl0+7JI9v+G/xsD0D4bgNo6Krtk8+HNBDX
 gnhgm1ojpV8xMiMR1bPFncODbdmDB/z3sPjw0zObBpvW2klJ7KTmLd1j9HWx24OTZN8Sb
 1cLaZ7ak3QkJT0V2B3S+AegRJm1UYxWtEOtZy5wcUzT+a7k4qcRMX8NKrILbDtNI3BQB4
 SBcOZbYIzLj0+vswsr638J0ua3DnUTc+Ed8zBAwIFnsNhGVXT0hHtf9iVQy9HtITJ3g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792767366;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ld-processed:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=Id2OmN+57cw9Ogedd082qIAuj5N47AMPBJzJaTKNkcA=;
 b=ICuX1EHhiHPWSIRqjx+mV8V4oIhzUbFaUl0xneqW//5wluijC+Npq5dMYW2uI0Hl8Vsh
 ovAoy39ZxU0xI2g3F4+GDMXm0Lu796MO++AwPT81A/OCRcMQzXFmcULAmNhNxilDoBCZa
 o8kOsFFj1+G41EnWuPqNdBaSpQKnP45BJFZb+NRCitid7QuaZhQkdF2fOppHubLrJtrgp
 VEpE+BhkNhfOIPAsRaeJoQVVDUYbm5kSYjDwaWHazm/08+TWhNWlpMEYTp1zStglxukDf
 v6iUaKZ5W1mdGxa9puDtmZTATnxpGcoN/ZBh9ts2rif2wG46Iyx+FOEooc469S6SeQw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=a3OYFQVf; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=a3OYFQVf
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2F9574096C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 14:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792767366; x=1824303366;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RsglZdUhqDTBf4IIkQZO0FqKtfdGQzMgQzymLO4SxaY=;
 b=a3OYFQVf+bBRnZI+qLhqiNwgiQzHxSz1pTZ+33d0yIWBgoa5pM9x5AvS
 aUcZhPp0W/ZpE34044AZAAFnhoPRzYG+Zyofadnz4T1wzgmgH+FVFdGvh
 vbiMbAY/+Nr3d0VhdRCsXF55MDiT+WFpkkuUd2JVFPeWOQed8RTuC2S+A
 T80JXH8SbnYulaKlHjvDwHeyryJ88/VWUJr+yCndaPDK8UHfqbff2mLd6
 55Y0dbL6oRUbtum1bzCmyri8e97jPu9N2YdDv3CpAcTuNfqJ76iYhEa1g
 BfidS4x03cmEbII8XCY7VQyOcswwTrmXUKL8OxgbihHz4VSwS0WXoreGa Q==;
X-CSE-ConnectionGUID: 3ktdpUQVQFSGFUt09YTJgA==
X-CSE-MsgGUID: REyGErCCSQGucLmsSZvLNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1539936"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1539936"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 07:55:56 -0700
X-CSE-ConnectionGUID: x3yV5OxtSGyZRDk67pjvmg==
X-CSE-MsgGUID: o1d9wNt7SWmXeL1CXZ+4FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="4022254"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 07:55:55 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 07:55:54 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 23 Oct 2026 07:55:54 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.2) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 07:55:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RWz4PThNP0FClZ1HklmK2+qeEyo4xobdhOfJTEVXvhqyuWsEl/3xri2qK/CqcrCrcYy68p3cuGpKceArI4CBKi1gTYFSI6Ioz11JtRmei8qHVhMIHBNINtONH913Hd26DKNK3B3MgRmcEhBiVYGg71gnpMmYlaOLGyfhZYG+gqsesY/LX17jNbWjrkM+lGdYe8QayWlub3j1w46ANQPmoIP/+8ZMq2J5N6BHCzqC9YkqqGDB5KaQkrSXMNw2aNxxEVcuAOQexNh9lQjWDszx49yczLBTsYWplZQR/5KPisB3ytFxYKycLmXbP2WCxyxPlDouaWcHx4Z3x3DxQWCqTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Id2OmN+57cw9Ogedd082qIAuj5N47AMPBJzJaTKNkcA=;
 b=wNQYILS7kYC7GXK3jbNxwcgbw7dSB/7VaGUwg79nQikQngJrHA5/NcP/gyMjz2lKVKtcCLZitLwYjfVxJd8VFfqCgTsRLG4jopyCGngSDDzw4wEknXIAl2ttx8fPhguReIPCqOgV3PbsQmUoGyHY5MnUFa9V/xghYOqvq4Ivr7lCi6Xr/qWvk8u+XK3EatixAfRvmjbn/SvBvRF2qjw5fuzHixVUwB/CRBiJL7iN+2rgmN6wW2JUYN/1OXpVQsd15+SiSSXE5VkTJbFQe8Hnld3kugvoTnxEig5L+OHcPmq3fVruM7JiFf6zQ8roLrMzBLNCBQGmccAYOQjx/14eYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by CH3PR11MB7204.namprd11.prod.outlook.com
 (2603:10b6:610:146::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Fri, 23 Oct
 2026 14:55:49 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 14:55:49 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
CC: "Oros, Petr" <poros@redhat.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, "Ertman, David
 M" <david.m.ertman@intel.com>, Mateusz Palczewski
 <mateusz.palczewski@intel.com>, Leon Romanovsky <leon@kernel.org>, "Rafal
 Rogalski" <rafalx.rogalski@intel.com>, Shiraz Saleem
 <shiraz.saleem@intel.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-rt-devel@lists.linux.dev"
 <linux-rt-devel@lists.linux.dev>
Subject: RE: [PATCH iwl-net v2 1/5] ice: check the auxiliary device pointer
 under adev_mutex
Thread-Topic: [PATCH iwl-net v2 1/5] ice: check the auxiliary device pointer
 under adev_mutex
Thread-Index: AQHdYryhGgUqtMcfZUmpGPLsUhJ7r7cLN17w
Date: Fri, 23 Oct 2026 14:55:49 +0000
Message-ID: <CH3PR11MB5668958AB590CAC6CB2F53EEC6E5642@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261023070258.730168-1-poros@redhat.com>
 <20261023070258.730168-2-poros@redhat.com>
In-Reply-To: <20261023070258.730168-2-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|CH3PR11MB7204:EE_
x-ms-office365-filtering-correlation-id: d6a31065-f3fd-42f8-2b15-08df3115ba29
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|261021121427099003|4143699003|11063799006|38070700021|261009223027099003|10067099003|22082099003|18002099003|261021123027099003|261022105027099003|261022075727099003;
x-microsoft-antispam-message-info: 9+A42ixgbioEtjmk+k3MIpqAlHiPazztgtWq0ShrVI7nbpxM/dutfIGYcOf1btqd5k59RVmRn7JQNO3WKgxgxjOh8or30OB53eVwCPgk6dwFF6l8VoY8Mb4L51GFjL4D9zJ7fhxZ67utlQH/jbU0nRXUZviT7Jg3QhNNOQxzqm4OvBAMGvCtAuOAy3hc31YV7jVTU14bdFFxpxg/3Ukkki/DI6EMNa7oZLyNE9Un5tXA3cPC50ngKWWRhJalNe7gkOhFSKwL/ewDyh8lgNEek38Ksgnm0KqVwbKAtj4rS3aH0JUWyQsWfeNVvMw8yXKWkfM23D1l1pvdK7jH+DEd06bv4wlAktrGTv/yykxwQYtukgs0+gtTnDbsPpljuShLAA9kHH73ZXhFn82FRj5J3c6Yq9umnZTI2WxSiVsdqD8sesiHL+LgCEdu8bZoopM/qDl3HxFS0JBa3pkDJANTNSPWdlE8GhXZPizmQwb6fkY5EV/nDPERrZvQYNnPFCH3RCTlhQxokx3HgENdPnN+DqGphErlKfGA6AskcKWcRu8pEWMRh8IqZZ3ubRpD032mbYyb+XstgnxQ+rGlZNnA7tVQAbxiv09ZX9wQyDr+9LOvHRJ9JQW1DtNzlhlgCiMEP2a77cpWDxfUsyaZBS/XTRIJzjuq3yiwOpWP99TStLlGV+o9WTW67Vk0xP4Q/t7+r0zZcCKBcUfmkSN78Vwu1TxjWfxodC4YnVL/rb58XVk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB566895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(261021121427099003)(4143699003)(11063799006)(38070700021)(261009223027099003)(10067099003)(22082099003)(18002099003)(261021123027099003)(261022105027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5fqdWD8bkrDj8nB4gZ9RI0kKp0VAx2RCkcHgfh6kbiHY4d3u6g3v7x4NbGDM?=
 =?us-ascii?Q?VCq74cferrYOvUGEMFvxcPnq4w8cU0B7OaHeoXtf1YSU07+OgNi29CzQiDdz?=
 =?us-ascii?Q?Al2wt9NLieYToM0meNuMhF/kMaicSRPCdKPGiArNldp/BgXQrlslSMqVn5x3?=
 =?us-ascii?Q?SuAoYTXZd8B+ZFDNiEy1pU7/yhbKV9oFEjsUCzEsSyusiYhp6gXB75pGZe84?=
 =?us-ascii?Q?aflRIO/IPQW6Vncjg9ZnrrSZHOS2ECDQpxGCeNoucKcNWtsZrBZR9JXRaOqa?=
 =?us-ascii?Q?qFAj6TGFCtV0YgeDGHwClqSOb3FmsMbEEX7aLhJX0h8IZfy+o+m1+IyrK3g6?=
 =?us-ascii?Q?qHlyTnke5su1+ixbdeuLwZEuQSw699KmpI+sTF702JtFzmsWpbwPWV+hPBC0?=
 =?us-ascii?Q?ugN/6Gp56Ewl44WdS0AyfjXsWJJKH4EV4rRXBcf2zRArpOrhQoNnyiOgOKxR?=
 =?us-ascii?Q?k1v91iG25MJj/RwDSDZoGPZlXavmXrFqpMfF+sGRPMczTPc3KdOSrnkqrQPf?=
 =?us-ascii?Q?zKTnrpsB2OO7rCAuutGL+xrYTaU1wI1gp5A7d/bO//pG708aJWF1X3PP1WAA?=
 =?us-ascii?Q?myN2WsVh/AXhkwn6z1Y1coQ+QX0HKE48/DmsUj2i01LEZdLL76Kruf56vtpa?=
 =?us-ascii?Q?i/MlNKWtBjWy2Mf/qdJFwGy9y5J6jh9zHinhduQfzeBAtQwRexmntBcxzQZ8?=
 =?us-ascii?Q?Nyv/ha2Ne32EEyHueBXTcoWe9h0xVb4xuhjsK49PTL/i4labcf6oZaD4FArc?=
 =?us-ascii?Q?58Q4zDB3yTCONiaIt4Ssve1oeWUeIBpRQw9oGkXjntRe2uDgDvRtsWeRLGzT?=
 =?us-ascii?Q?wEeJbZAnmG0lT3J9gMmm6sNNYOs7qznTzNPJWBl4Z8/5KVrAd2O0YPLMHwBO?=
 =?us-ascii?Q?Rg89v51MwZRw3JVF8Z81PO+Tq/rOVMFzFA6Ic1i+v4GBWrhYNgXTyf9zDOWp?=
 =?us-ascii?Q?+hn+6Yqi14ZK1CaHK1+q+pEWz6XxAGYODLC3Xmr5UIyVcHv91o9assXfm/0c?=
 =?us-ascii?Q?ereAL9VGHIJa6ZvsI/UKOLCP0SvjmFrBSpreHk4V8xY/5D3Y7ARgQ5DXpHaB?=
 =?us-ascii?Q?QqJFJzlC5lDB5zqQtyqosyROv5DaZRJ5whIDI5DVpJ8hiegkJmzaHy4p0hVy?=
 =?us-ascii?Q?O+p6p88LEneCOCOX0uRgGm/95cOvO8TAdW9h5N+Gg8QOjD5Tcy8Y+rzjVKOb?=
 =?us-ascii?Q?DxsFMH/YUXPpA08BS7q60Qjlgs8NPmeDXRlfDM/N1tVfQDDQ3uRb6O3FpNi7?=
 =?us-ascii?Q?3sRI3slxh6ZGUwSUX9GqxZBX27xW4hxab/cmIy1rwGrnPpCotqsVzaAavxe5?=
 =?us-ascii?Q?yibjxnCSWgZUA5cMLBaVEYijGHlWG/r+ykSvUpi7ZfAoUzRKo2IDbz2NSHTV?=
 =?us-ascii?Q?FhNTfO09RoV0FuXM4W+hDXfwViUss1I75lT0E0dL0IM4khkEWrSch0ak5i17?=
 =?us-ascii?Q?MafL/D8ugnmeox5xDP1wC6boGm3/sI99nRze+gTLLxTucCk1plJ13DhqFIlY?=
 =?us-ascii?Q?9A2MpoIoD9U1ceTujqemeql2v/O6BxRiC0afOk6DokYLcAPH62g+0LmjSUfL?=
 =?us-ascii?Q?7OIA6HZKQ+hOWCQ0MW7vqIV+uHrr+8dxSwXEyLlpsIgORaopI+JtLQmi8BNA?=
 =?us-ascii?Q?tJWHKNsxvXCm5knJFSUS2d+f0NYJaWl4S3dzfXLciP9Olk7NLMDFHTZWwtAj?=
 =?us-ascii?Q?c5E/PYCYlmMbJyA4NjhBLr0cJwlhOXpDPOS3EZ/3YoCph/b6520/bNosZAn+?=
 =?us-ascii?Q?UKGw/sYLTLZSmKtk0erRhb1xOjerCQc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PKRv0hBCg40YA2hzh5CCQn4oyeBBQHDMoqEGKB5gmKQeD+drRkCuUHilWT1NI8lRQw4I0RfbDM1V1/9Ie/edIIActRBrM4peyrLQWZN4yX3xDi0mf3E59ZXLhitjl8lQTrIN53bjNReB/WQO0lHtttaeQleZ9idu4a+sw60JfD634sYhhE61zfDXg0k6PdXfHtqMr0Dy0z6sabtgIHhNifsF+8Lw2QLh+bbx/qaxpxOeLQnDaOtHsrZEhJy23zvlNuCYab0k925BE24i9c6G+f2w6y9tXF7K6NBoEIbw51bqrdTuPQmxTCpLaCsA7fUN7js2lx9e5koplO1iFzYZ7A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a31065-f3fd-42f8-2b15-08df3115ba29
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 14:55:49.6905 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KEVEWz+jMUOiCVOt2a/xK+V8CbL4IoZV26By9t7jGhKLPKH0mHc3cElWrWUJtWnkYskAWS7nSwVEX0KFzxsLVKLuakmxLdxUf9eu9Uliwc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7204
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> -----Original Message-----
> From: Petr Oros <poros@redhat.com>
> Sent: Friday, October 23, 2026 9:03 AM
> To: netdev@vger.kernel.org
> Cc: Oros, Petr <poros@redhat.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@kernel.org>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Sebastian Andrzej Siewior <bigeasy@linutronix.de>;
> Clark Williams <clrkwllms@kernel.org>; Steven Rostedt
> <rostedt@goodmis.org>; Ertman, David M <david.m.ertman@intel.com>;
> Mateusz Palczewski <mateusz.palczewski@intel.com>; Leon Romanovsky
> <leon@kernel.org>; Rafal Rogalski <rafalx.rogalski@intel.com>; Shiraz
> Saleem <shiraz.saleem@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; intel-wired-lan@lists.osuosl.org;
> linux-kernel@vger.kernel.org; linux-rt-devel@lists.linux.dev
> Subject: [PATCH iwl-net v2 1/5] ice: check the auxiliary device pointer
> under adev_mutex
>=20
> ice_set_channels() and the mqprio path of ice_setup_tc() test
> cdev->adev before taking pf->adev_mutex and dereference it afterwards.
> ice_unplug_aux_dev() clears the pointer under the mutex from the service
> task, from ice_prepare_for_reset() and from the devlink RoCE and iWARP
> parameter handlers, none of which hold the RTNL lock, so the pointer can
> go away between the test and the device_lock() call.
>=20
> Take pf->adev_mutex first and test the pointer under it. Without a
> device the mutex is released again and the rebuild runs unlocked as
> before.
>=20
> Fixes: a6a0974aae42 ("ice: Prevent set_channel from changing queues
> while RDMA active")
> Fixes: 4b31fd4d77ff ("ice: Fix RDMA VSI removal during queue rebuild")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
> v2:
> - new patch, the pointer test raced with ice_unplug_aux_dev()
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 22 +++++++++++++-------
>  drivers/net/ethernet/intel/ice/ice_main.c    | 22 +++++++++++++-------
>  2 files changed, 28 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index bf9a821c543b7f..5482a64c81c95a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -3888,6 +3888,7 @@ static int ice_vsi_set_dflt_rss_lut(struct ice_vsi
> *vsi, int req_rss_size)  static int ice_set_channels(struct net_device
> *dev, struct ethtool_channels *ch)  {
>  	struct ice_netdev_priv *np =3D netdev_priv(dev);
> +	struct auxiliary_device *adev =3D NULL;
>  	struct ice_vsi *vsi =3D np->vsi;
>  	struct ice_pf *pf =3D vsi->back;
>  	int new_rx =3D 0, new_tx =3D 0;
> @@ -3942,14 +3943,19 @@ static int ice_set_channels(struct net_device
> *dev, struct ethtool_channels *ch)
>  		return -EINVAL;
>  	}
>=20
> -	if (pf->cdev_info && pf->cdev_info->adev) {
> +	if (pf->cdev_info) {
>  		mutex_lock(&pf->adev_mutex);
> -		device_lock(&pf->cdev_info->adev->dev);
> -		locked =3D true;
> -		if (pf->cdev_info->adev->dev.driver) {
> -			netdev_err(dev, "Cannot change channels when RDMA
> is active\n");
> -			ret =3D -EBUSY;
> -			goto adev_unlock;
> +		adev =3D pf->cdev_info->adev;
> +		if (adev) {
> +			device_lock(&adev->dev);
> +			locked =3D true;
> +			if (adev->dev.driver) {
> +				netdev_err(dev, "Cannot change channels when
> RDMA is active\n");
> +				ret =3D -EBUSY;
> +				goto adev_unlock;
> +			}
> +		} else {
> +			mutex_unlock(&pf->adev_mutex);
>  		}
>  	}
>=20
> @@ -3965,7 +3971,7 @@ static int ice_set_channels(struct net_device
> *dev, struct ethtool_channels *ch)
>=20
>  adev_unlock:
>  	if (locked) {
> -		device_unlock(&pf->cdev_info->adev->dev);
> +		device_unlock(&adev->dev);
>  		mutex_unlock(&pf->adev_mutex);
>  	}
>  	return ret;
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index d88835482d3aac..984479f1e1f6d9 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -9406,6 +9406,7 @@ ice_setup_tc(struct net_device *netdev, enum
> tc_setup_type type,
>  	struct ice_netdev_priv *np =3D netdev_priv(netdev);
>  	enum flow_block_binder_type binder_type;
>  	struct iidc_rdma_core_dev_info *cdev;
> +	struct auxiliary_device *adev =3D NULL;
>  	struct ice_pf *pf =3D np->vsi->back;
>  	flow_setup_cb_t *flower_handler;
>  	bool locked =3D false;
> @@ -9438,14 +9439,19 @@ ice_setup_tc(struct net_device *netdev, enum
> tc_setup_type type,
>  		}
>=20
>  		cdev =3D pf->cdev_info;
> -		if (cdev && cdev->adev) {
> +		if (cdev) {
>  			mutex_lock(&pf->adev_mutex);
> -			device_lock(&cdev->adev->dev);
> -			locked =3D true;
> -			if (cdev->adev->dev.driver) {
> -				netdev_err(netdev, "Cannot change qdisc when
> RDMA is active\n");
> -				err =3D -EBUSY;
> -				goto adev_unlock;
> +			adev =3D cdev->adev;
> +			if (adev) {
> +				device_lock(&adev->dev);
> +				locked =3D true;
> +				if (adev->dev.driver) {
> +					netdev_err(netdev, "Cannot change
> qdisc when RDMA is active\n");
> +					err =3D -EBUSY;
> +					goto adev_unlock;
> +				}
> +			} else {
> +				mutex_unlock(&pf->adev_mutex);
>  			}
>  		}
>=20
> @@ -9456,7 +9462,7 @@ ice_setup_tc(struct net_device *netdev, enum
> tc_setup_type type,
>=20
>  adev_unlock:
>  		if (locked) {
> -			device_unlock(&cdev->adev->dev);
> +			device_unlock(&adev->dev);
>  			mutex_unlock(&pf->adev_mutex);
>  		}
>  		return err;
> --
> 2.56.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
