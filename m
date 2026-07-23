Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B014C531C7
	for <intel-wired-lan@archiver.kernel.org>; Thu, 23 Jul 2026 09:21:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5CF0440798;
	Thu, 23 Jul 2026 09:21:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J1khs38DXu8c; Thu, 23 Jul 2026 09:21:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2730C405A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784798473;
	bh=PwgtSXaAt7PpVPPEU73ElKT1WjSG5DaIyLNnqWiqK2k=;
	h=From:To:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lNnp6IKnupTzAcp170/4ZYmhE0L7vQwodH/P3jsCxZxwcnnAYz4qmk6olflMmpwUb
	 wJYlnvefaGDlfoSzBMMml6KxelsvUO8rOgcIs1FJuvyNPtnR/MrZKHfO9GgROX/Nga
	 Yb4yfJX5+zWnZxB0DA5h8FdQyKKxYdqkFd6XFDpmbMvOAFp/4Cy8Qr3RgEGkPUaQ+l
	 UyGZEz8BacEYnQVrSvx/4H7pz1N0Ah8tQ/YE2nct+yu7r3dSuhX5CRj2XEQRW6Hwgp
	 kup6SfMllZet77leMkCH145jc+29drfPfIQFrnZ1ojQRNqJC1Ti75s8SFeTHYal7AE
	 x9ey4rAc8MdKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2730C405A6;
	Thu, 23 Jul 2026 09:21:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3AFE83B1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 09:21:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2C5426077B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 09:21:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id esrJIlL306FR for <intel-wired-lan@lists.osuosl.org>;
 Thu, 23 Jul 2026 09:21:11 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1B9146075B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1B9146075B
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1B9146075B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 09:21:10 +0000 (UTC)
X-CSE-ConnectionGUID: O39g2ERgRUK3yDg8ig2e9A==
X-CSE-MsgGUID: mFqibTOGRbuDfHgEwBsTuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="84575794"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="84575794"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 02:21:10 -0700
X-CSE-ConnectionGUID: GR8pG/+iSA6XBboxqb3MNg==
X-CSE-MsgGUID: Kwru3xN7TEKu0Pm6HZos+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="256558676"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 02:21:10 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 02:21:09 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 02:21:09 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.18) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 02:21:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmIhDppwvrDAtSQStQTOCtEPDV6pnDYWs6G9qeFRLcwR2qSiUWgK+xhSptFsHsp/8yT7ihkd8+v3lG4ue9paFF2tQ9NUBq9c0OtDP7HdKRnfJd8fKNzKoV/gd8vEmVO+U5eEPRUzC105+Yv63JWrCnQdMDJnAZGyIXx40ux633uQ7DwBucM4FrrZMBgOlHxzm08mNY64MRtpnSP3LffsNgBDiHB5t3nB1MFq5U9XY5qOkig7RBxTunOUDdt7mPo2bMtfbkNpnM16eb7nIKYk0jlKxJsWp4dR9dVILt9l0+Sz+QyKAghiXyPN4plyubMEKtGIko/unl0sVJRN05QuZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwgtSXaAt7PpVPPEU73ElKT1WjSG5DaIyLNnqWiqK2k=;
 b=GNup79k/4c8wpaZoTgOAEn/OVKapDY/JQ+uR/jCHtEFr46VhF4S/I/a0Dd870WrwEybm+mNyQ6oayTmthbZjTFrhsLqBl32rrNMSKRPT1LbVBj/YOCnsq8BsiODYI9OWPaqMz7tILxEH+4chilSh5oNjkXTT21G9OywfLdU7LwUaPDJivcWPEzB1QNP+J5mz82xh0Mpq7fq/oailD5ZKFQDGyZwV5b3MYtqRBbfDrJEqrM4zg34MJXkkGTOqq/ea22++ivy8VpfFEm+/DznTfDPQgWdvK/86uqOH7xTMh13BXMackm+e2DBQjOCuigOKvujSa6TN3QTd7OEEOF/uzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA1PR11MB9633.namprd11.prod.outlook.com (2603:10b6:806:4dc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 09:21:07 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0223.017; Thu, 23 Jul 2026
 09:21:07 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [Intel-wired-lan] [PATCH net-next] ice: rephrase LLDP filter
 fallback message
Thread-Index: AQHdFclwAwFU7GpxXEqgiBWWeRmU5bZ63Y/Q
Date: Thu, 23 Jul 2026 09:21:07 +0000
Message-ID: <IA3PR11MB8986E19198FCD1756A9B90D5E5C02@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260717084453.9521-1-tbogendoerfer@suse.de>
In-Reply-To: <20260717084453.9521-1-tbogendoerfer@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA1PR11MB9633:EE_
x-ms-office365-filtering-correlation-id: 3e13d22d-0d56-41ed-0094-08dee89bba31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|11063799006|6133799003|56012099006|18002099003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info: Gqdy2JP99fODQFnCiRYla5Oi8q/JKlqtYNqWI+fZNfcccT9pqv9Tz9s55GpdTY230oh+jem43wRRNNQfhzUoA3618vTp7MeeRgzpFeCWBO2baj94elXTzNsS2zt55k5Svj1AMieqaUHynWdUWHRuViGPvoz6pZdRDu93bnflAs9NKqNSZz6/n/t+atg5BTJpv8Yt1o6YiAtUwmzXb++iW8DvNQxZ+84PGtE4ZQqMNc8Xs7AH3QazsxY7oQrtcDh6177N8bLkAJqyd9ceD1RJkYAirfbl9U42XlCm5VRpSgh7U2oUcngl49Quf38+j0Bsl/qfjDhp6uTvA3ed47ZaFte16GY1b/xT5VSrGEHNcbTdOKAhZVUxdHoqyVIFujniHfbCriLF0pcDAJ5xjli46AnAhRnryKmyAlaYL2rKAV1LFUC4D4tuht3EOM/YJarc63cFS7AaCjKHZQ6UJzxKZMCQjlig6+MWAA+VockDr72zgQOxbn7FzefpynluLMAfUN3Dab5mXL02K8tLTbCJ2AFPDZ/cPmPnBhrHgxiOoMArW1Rs8prTcdrGkJY66rnq1Flp4M2NBE+Jn3ZUWp2iYfjB+O7vx9LIvzK889SVyYlQsV/EaIODYpdP56xpxtpNhUF49l7eOIKqwSq/IHQAVGjBjkAIw3qdAbQJ97nyWYmndbPl8Xzxm5+DI2cpMeV4Z6UPsvmmja+9d5m+QcGZwIYS9xk3Rp/KwuaVBmaNcxx7DhhBRoybvVxaoFDynh0C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003)(38070700021)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BOhJuR0xSjAIy3UWrBELneGBb+bbBxqBgEepHn0YIqW6gN22FuLSYPjlzOok?=
 =?us-ascii?Q?TBNIl7rSVXEZh6jhrduR3nbwFhdQ5s1jzqNzcQ+CtOg/oQG0McNVAA2B74ot?=
 =?us-ascii?Q?j5IRrmjKbcGZ5qSSj+Uw+f8abbA0WykYIoSImM3PQfF4P0XwZ2FJ2ZBOTlmD?=
 =?us-ascii?Q?9r7I3RzFwwA+pS1z98gPSLtk9CXgziPB3qUg5JMolbjivf8POp1kGC5mZLN2?=
 =?us-ascii?Q?WO49xl26j35D8wYfvhGEbNhgqgX4cqBV5sI4GcXVx86LqkJzZzA6/pZc755p?=
 =?us-ascii?Q?wiZev8Y10Vx2YJ0JZuz93nvRQabIEd8pg0D3BEbIrSmKyEndlt52nlpzBviD?=
 =?us-ascii?Q?yo7IuPaITmCRCg8DqAxQPlLsdbtATgUcvPidbXjT+KUXFMNVzwdF/MpIPOQ/?=
 =?us-ascii?Q?PjG2x0Tmt4LHGs+dNBJ9fnFOopSDWsLTLFm3XkzeNau86TVPRjw2tMAQPpLz?=
 =?us-ascii?Q?8tRnNp7FV9mo+Nz63FbEHZrBoFB/rIevIFLB4bOGAEUA4tXIY/Aaa/pZ9Wji?=
 =?us-ascii?Q?E0SPpKT6TpLOrNJfQod2zqbA3APY5jhR8HzYiU0SgMeo4xXNuN/EKnC2/QMO?=
 =?us-ascii?Q?FTupY+KD4hjY/BwGWz6mObGMm7YgU4xsnsbJMAKWHATyXLl86coR+gvtdJwe?=
 =?us-ascii?Q?WYgEvq/Qa2Msp9hPNjJUlYgvUdDhdFC7ScjsMjtwDCB8E5U4NrVhEzDLCCwi?=
 =?us-ascii?Q?7TUrnBwTD1956YGGzsMSs0gMoULbhbUMlua1jzVpK9a0Vnq0T9mHngQv01QB?=
 =?us-ascii?Q?QcOXBwqQb1lkwecV4bj2cWaLy4RPJj+zj4XvVbmeM8WSSaR/mPNtARpF05Xk?=
 =?us-ascii?Q?Rek3gTT3xj8iVge/pbKUTpXILqtYNe4NzQ378UDblOZTCZparx+x5xKUz1su?=
 =?us-ascii?Q?zYFs1xT4HKB3Fy74zpAg42b1Iub3qWl2D0tPK2/Y2ImgA/WCO/XtvTFdx07F?=
 =?us-ascii?Q?n85UivwLhQaXvj7oeXQJixMVPV0yHvZMNLpRvDY9yjEcV/5b51iGgKc6VmxS?=
 =?us-ascii?Q?2tY1/uWJP85aZNkgIMXKGkke0o3qfF9IMQfnvjt4QzjmGLnloLiAUn1Z8YfC?=
 =?us-ascii?Q?UFpayYi8qTb3pcyhV75gk3yV5t3yun0m6HSaoyFKe4f0UxSWT9eiihPiqM+c?=
 =?us-ascii?Q?ubYzEEDHNhuPsb1dIlI4mda8jtNvz4hItgxTcIiQs0LwXNaqJ78juF+6Y+04?=
 =?us-ascii?Q?22sV53qYwCrs4kHfnTAwdxYfgUcBvDGT5qV4i1a/VYjplUXDsY1ibvDdeV15?=
 =?us-ascii?Q?MbiYBf5aZUUz+mQ0Nh0xR56UTJZgLaAGWyoOs10Og0fb2RNrNeGCEMrC6XNG?=
 =?us-ascii?Q?zXOH4R3uv9KNZpHV2AUJPMVaBXe9r8jergMBFNBYNh3Fyf5PXJJxtPJqtxIz?=
 =?us-ascii?Q?3rQrm6H+Zbexv8sR1pV6tNq1rYI0sQhxZq+GZ7RsldmHgOzoDq4ZgBr4zuNZ?=
 =?us-ascii?Q?mUxQvBuA9JgAG8Ge6b8NKBKekZAec0Cuq4WoTMCx1z7kcfU97+Io0MxG5Pl1?=
 =?us-ascii?Q?nfkSTVZ5IhPnUUUK01+5gXxTB2/0bwZ88tbtKcUipmz6nrwU/ZbBwsfloJ5H?=
 =?us-ascii?Q?DqL51fEmwpOks85RxPs1i1PL8YoAJahvOQhenHop6UID/ZkeJigCJ6x+CPXx?=
 =?us-ascii?Q?mT6YziFm5qtjlbqV7632qrMFUEHkUSQnjKb8o2uV8cmRf8tgr1JaRAf6EjEy?=
 =?us-ascii?Q?aN6DWhh2JQFHt2ol447RPyReHFbEEMLGdgnTw5xpP12oP0eLoIdPyDh7xy74?=
 =?us-ascii?Q?BBsxHFqouk1HZJcIMMl0vr8WWShRwKo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pHzuSpncpOGRdpKvBtiH1TyUOkJeRbTwfOBwiVXTCN1taJ/IgkHQNAN9t21PYGlVgGqNJScYd6XPs6lO4e7gaO6+sCLOS9dSsEjLN+XqzZZ8fwyvkFnAobOo10rA4PL5nJwfHbTH3dJG5SI4vR0qnzlt7FIjwA2JOBdmcYthaLuhbaVvWAxyTh3jXjOtOWe6rbji+Dtngrfnq2UD8EmTzFJ0ysQke0rCaImSgAhw5QPVkp6xe1lpGhCMdM+cekOSfcCiD/5Lk6YLlE/15MW29bwVwVNrmuAQ3KLimFNF25d1N/VGcJzenCG6P1f095f4y3QDTpj/+qrGruXlAGRjHw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e13d22d-0d56-41ed-0094-08dee89bba31
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 09:21:07.4402 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: flzS9FqErW93Ie9NQXpxP4bXr0Z2MkJXugSPXzBIomfSs2X8i+nWKRnaKwcSUds+YCQoysCjN/90tbdtr4fdUrf6xp+YYhovoBDehfQU6K0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9633
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784798471; x=1816334471;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=UwhZOHv1TMXwZpSc3XtvYXL+OIn/rh6fw8S8y3zB4No=;
 b=DbDVUiQa2XRblXVpDzZ03jx408ut1QZWXyGu3VwT8x/8wNEqVeExA2DU
 j0/mBeVpOI60ZEkXnp2Snp9+AYnsh7LxOrqCsV5/hEvCBw14Pncc83Xcf
 agQVWIZLylJkwHNqRjXoBzuxv9mm82T5f9zIN7fnpH7nmgmS5WzI0f99O
 +oD3gqttPbURA70RJdjxWwVdptbU+A5sLNxQ3XCl/3zXKJ4Zkg42v8hT0
 HGvOmlrOQtCbCZX4O1aRpZ/Ec8T00Jl9kLkU698dqSQ1WdpuRO7eoBtDp
 pV9lrXkr4/IRM/W1pSA+4D0M7ABTmj5J4QSlQucDPKd1CDUKhsILLioNy
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=DbDVUiQa
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH net-next] ice: rephrase LLDP filter
 fallback message
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Thomas Bogendoerfer
> Sent: Friday, July 17, 2026 10:45 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next] ice: rephrase LLDP filter
> fallback message
>=20
> Seeing an error message in a logfile triggers scripts/admins thinking
> of problems. The LLDP fallback message itself is not an error, it just
> indicates it's using a different filter mechanism. So rephrase to a
> less "scary" message.
>=20
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c
> b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 8cdc4fda89e9..59341b5a0c05 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -2097,7 +2097,7 @@ void ice_vsi_cfg_sw_lldp(struct ice_vsi *vsi,
> bool tx, bool create)
>  				goto report;
>=20
>  			dev_info(dev,
> -				 "Failed to add generic LLDP Rx filter on
> VSI %i error: %d, falling back to specialized AQ control\n",
> +				 "Using generic LLDP Rx filter on VSI %i is
> not possible (%d),
> +falling back to specialized AQ control\n",
>  				 vsi->vsi_num, status);
>  		}
>=20
> --
> 2.51.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
