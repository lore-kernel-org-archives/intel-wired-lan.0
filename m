Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0599C5AD5A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 12 Aug 2026 09:44:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 744FA608A7;
	Wed, 12 Aug 2026 09:44:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pJh-0jAM4yJK; Wed, 12 Aug 2026 09:44:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9297C608AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786527859;
	bh=BjjC3b0FfCDs2JbEdl+10g1dJ6AGweGRByYC3j+OH9M=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HTLE1NDoYSY/eY9GgxKNh7cNj2JEpNkLe0DSnnfGg49K86jS4tZ57B/MCniDd15jM
	 jOFtQEhn65/wYKzDBy7biI07UXB7evzqlwLtiF/hsOnSfBkAXRw7voa/WTEbf8sV9k
	 BkulDn4nkVmFTQ84B2/eriwhPbqk9nGQd/zhx9Uog9AewWpdbRYpiDV1+MoX8i+ISH
	 XqLq2cag9kRKtBevSq8oK46i1cr4YbrD8uPniG1XCLWCDT9g6nQAyDGAvGB7Rkv8JG
	 Uo6TL62mnkzrJXG57JxvgS46AZlSKdQjkEcKD2OsgiDRbNJlsad6y8ildTJVIDcDjA
	 6QCI3uzp2k/ew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9297C608AD;
	Wed, 12 Aug 2026 09:44:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 59D141F41
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 09:44:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4BD5C403B5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 09:44:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rseCY7mZ9k7W for <intel-wired-lan@lists.osuosl.org>;
 Wed, 12 Aug 2026 09:44:17 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 428C94007E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 428C94007E
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 428C94007E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 09:44:17 +0000 (UTC)
X-CSE-ConnectionGUID: NnswOp1kShKSFx+FsIKB4A==
X-CSE-MsgGUID: TAsa81J9RFS30UtVrqaKEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="87097053"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="87097053"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 02:44:16 -0700
X-CSE-ConnectionGUID: wUIGUYCNREq0FNNn0yZdfA==
X-CSE-MsgGUID: ASEOOR2aTYaST65hpEwfHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="267093296"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 02:44:17 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 02:44:16 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 02:44:16 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.38)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 02:44:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SLqEAVgYu8IRw1PRkEibnpefn1S5ZqhDi1rKz02BjVGQSqdKr/3frI0LKW5nvSQ/SZmI5j5xNseuXslF8HjPv36FGQWZVdhq8WDpMVsn8sRw2UB5K6jpK9ql+AUf+guQbIHSHtvHshN9pD3uV9kPhqvtiVVQg2t1SoG3N70WPUdkUbwGRippyclZupI/pzIco72nH3KfIlZbuknp/Xvne6TEkzdMHCPmGgFl0NtAkWlXHdm2aBPzJe/ZFp+vK26K2ND0m0q7eXLE2ktd1rE5Nq6864ArrE48UgjQHbL976aer/W/l4T+MeNCf2fwKc8BRya83RTIYuBukYXylP/ZGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjjC3b0FfCDs2JbEdl+10g1dJ6AGweGRByYC3j+OH9M=;
 b=crXpt6uduNEzR0p4cCnWwcXmQSlsRbpIJSky1Csu88fJyEWMefJvhLVXdEt+uivk5ljA2pRaQ36+FmZSdyXW7UxzPUMr7Vni2n6yR9TZ3W4Ft03eINaAUi+7RAi5vMQkZLMwPsLLnPzmP0Pvk2UbJkKAok2SDWgByKM5q6exoBCR4Qlc5nOFO9QrFra2J90T7YysuPweak7FmX5o1Kc0tftoYXmahci1ldMaoipKBJwM9K9ndUSbIf9RG6XOzh1robZQ5zWPMNxUqZAdM0gCC3u8cUznOJF00HeJuJ7sEzDQ3Fpb2kzqVdRn0huasIylXY6FeWJqIf0HyEEcuvMaoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::31) by SA1PR11MB8596.namprd11.prod.outlook.com
 (2603:10b6:806:3b5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 09:44:08 +0000
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::675:8a:9680:ad3f]) by DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::675:8a:9680:ad3f%6]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 09:44:08 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Malathi <malathi.a2000@gmail.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
 "edumazet@google.com" <edumazet@google.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com"
 <syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com>
Thread-Topic: [Intel-wired-lan] [PATCH net-next v2] e100: fix
 shift-out-of-bounds in e100_eeprom_load()
Thread-Index: AQHdKU985YbQcsKYr0O7p6vxeeVBNraaK43Q
Date: Wed, 12 Aug 2026 09:44:08 +0000
Message-ID: <DS4PPF7551E655294090E40920DD86E03A7E5DC2@DS4PPF7551E6552.namprd11.prod.outlook.com>
References: <20260811050753.234931-1-malathi.a2000@gmail.com>
In-Reply-To: <20260811050753.234931-1-malathi.a2000@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF7551E6552:EE_|SA1PR11MB8596:EE_
x-ms-office365-filtering-correlation-id: 56228113-37ca-4ac4-e495-08def85641a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|7416014|376014|11063799006|56012099006|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: DqiuG5x1gdkxokOPz85TcwYX7PQePhfdSRgnyZN4B8VXmQRRk8eKtodxBQUOxQDM+EDIwkpXsK5qdKcbif5CW9q/0vJDPBH6jQa+CWBaQ6OkhFDBl96OfuI/bHAzgMHqJjA06QHgX7c7bGm7zK2PgpJJXRJj6LPKkZqCY5dMICaPLjG1nM5dnLkabCQgekH4MUGtBoAwJG12Lcfd+8664H8WnvQ13BBEkzsRDazs4kRFP9XKj/x56kdvQRMpSjLSpg6uPATfULUNn3q7fHc+08t2wmywUFfbbMfGNUnly/wVMBYC+MLv3PksW5tSF2uVzw4Ao2G8maC5Kb7OWABz5VOjeNRrZGW/og5FtOiR6q/Xvw0hFAoPM15bYfV9CfuDdcG5h4yfgAQoUxWHiBb/chlVCW/nHVBevbag/c5fnZPRICoqR9Jn2K9mIjy5W5M8BMY75c2Ho60ZWePLAOilejMmecJB/PtLifuN17gMiXtZ82y1IerW/lqPlXKTSeQbvIb7ZRELdr1Gsvwstu5TbS+2l/iQYO4C4g/8dyFUZhEFIgQrcSk0oV7AXpQ2z40JUvHtKUBE+tPlEMgJulj1LUO3LckMzUU9pHUkeV03nT/hElmUztVO7cYGUTouUarXYSrbjU83Dq5Vn10qs5kvDWvWJVTvLPf7sx5LIwpUWW8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF7551E6552.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nD+TUgDTVdo72GYVf7lvVPZiPj5kibpv3X0civHytf+BhScGe93d6lWLSgYa?=
 =?us-ascii?Q?5xxzmQNOWtxg4slgR/MdEfSREZXMPy6KiAgMWQMGRoB6TAdbbBX9UydqzBnX?=
 =?us-ascii?Q?810l09ThUql6Cuxzr82qMojfwHD9VFdHPssc7ChHaaN9Q99osF1VVzg29Gx0?=
 =?us-ascii?Q?bTn/sT4Jv0BVO21q0CsJISkLuPeOpgucyFHM3MUKrid5Vxg6iP54hUWcBABe?=
 =?us-ascii?Q?DzRyXPXFDACccjZS/0DrcyQynCTsajjoNok7d3u0/FHXP+XMYXJwWcjwKSgl?=
 =?us-ascii?Q?HtIVUPzTAE5Sn3ayPj6Ddt+VCy2bqfBy5aNCTL302s26DLuI7XUPiqhSOsI8?=
 =?us-ascii?Q?19bDUOrhVXJA2Rv4JXlSD5WgDbbwcoOI/CkwOIsnuioqTEs53dryPp4WnQ8a?=
 =?us-ascii?Q?s870dznRZDGFK51/iYTZOWocfiRhOlz1Fs5EfrKSZ2LdJ7W5YKfwVPGNE3Ps?=
 =?us-ascii?Q?xpgegqUrwQPeYeIzK3xDc+OE00fwltRUKYuVWik5IhUjvz8rGqJyszntjqn7?=
 =?us-ascii?Q?JNg7uZheSIrzpknR6dsMvCpvuCAEgPunQQNGYBMmgK+mmhQHZ8rQhQp2ZAlL?=
 =?us-ascii?Q?LCUcWEfWyrEG6u2imCSzg6J1oCWdtYI028iNZ5E+yosdvWB3bBWx17v36f+S?=
 =?us-ascii?Q?Ie8qdtVtsBZqXo8nOqIHkH+/oLj6zHABEh73ZGl9Fjcc/6JtgsCLPgH1Imr5?=
 =?us-ascii?Q?KCahplV8/zTU/OvpdUSYM8EJ+LyAnIw/JtWzsjW+G86e9Cn5RPIvz1uHDTf1?=
 =?us-ascii?Q?T7dC/6ohaVsFxQ/KR4M6H8GYgtOUHAf3x8hdlO0MHg5UEmHShNME2iecVdnQ?=
 =?us-ascii?Q?gqDRTaU4jh0ROkrx4vs41eSA2SBnGlyBR22QE91yAg6SO7abjlJ//MVn4qHp?=
 =?us-ascii?Q?H7YfOWLjsCkdmMNazX62r0PfOHMAdU8H1Mm9oqXJR10X2REQEUDgPp3YLwuJ?=
 =?us-ascii?Q?oEwniCq+hjXn8bjGY9wkCSIjKU7WIHQH8jC7ZlQ4CkM1DJo/yfT2uHBalW36?=
 =?us-ascii?Q?GIieS1cio9wwfSkkJg5A3b7I4oYLP1brwgbvQyeNBjeFzmXQtCbkdbP4kwLz?=
 =?us-ascii?Q?7f5XgXeQmMMZk56a9MYWG1siaM3gHaEHWGWR0ijmJw30jkk1Bf/NhJs8krv4?=
 =?us-ascii?Q?8OpMJw7Ggwo/j1qvfkTEoKjgPGHpk3jti8md6bd5THRkJllGn6v+dgcRsqEu?=
 =?us-ascii?Q?sm4GJxLGU9lZx0J9whxiupPa6wMvWJFM8JtjIrQw+o07ThYmiQQXFVpMegYk?=
 =?us-ascii?Q?yvx6F5BUy36yKoFprbk6fX2DpQavhgqp5U9066h6cFTskP0t4jKLKDqsIMIG?=
 =?us-ascii?Q?iIHXn060uCxR4SesuVwOhpXcvPp+pVbakK2V6v9x41+gGNq7EQlwpjDGgD6M?=
 =?us-ascii?Q?IFiS5h2m2qoS/d6USNBB/PcMI2sWyctGKaLVnVEX4I10H6G9RIVBclytNDbp?=
 =?us-ascii?Q?g/6JuSCsJhxqu8HYtlEJpqInEAnWGEh/cm9Qlyn+D+GNnKTJ2VIX1+F+nzEN?=
 =?us-ascii?Q?0Bl13K1dbdFW+VcQSnG30zPskIZgDWFZVHTP+MnhqDKXiVl+wtFdQM3XmfdP?=
 =?us-ascii?Q?iqF/8Ak6CXUCdsonyDf6OcJVCfnf6A+xAgZurS7LolxBfqQHim6hJaI5GZMz?=
 =?us-ascii?Q?KxspqK1OunjrADESLEEdggy71bWTsWVBRuzvfBkYgXfSRThyRJPBmI1kMBdh?=
 =?us-ascii?Q?v0yJq9MKvYdmTJ+xqTIuvPMySnzdUa7TOuGVIk1fdQnOjNPh3WBbhmzj7rik?=
 =?us-ascii?Q?Fr8HoZizfQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EN01rybwUGarxVxnTO0p4mYhiP4bgOdwWuMu75sKT3E9956VjnYJVIVSwYfKdHYJw9v8bP5ARxCGUQu9PbLpILAysO6xvsGKKT6F29Ds6bzuXKW0h3gB6lpJ7n8ytfk1Qim0qUowWkGWZr9/vFdh5Q+mBGLj9E0XPdHsD2wTtU38sXWEozIHdNGfbl7LWKJCwensV0r3AC/M/Jr9apUlkkudHCnm5ptnirG6SUBxxibB5ishI9qVdcjcOwXyZDyjsqCtNaarumPR4DTvFfA+a3rih84eSZp5yz8DrPocPOAUxCF2rkEuVdDGAwHiVFyCwoeRjwUuZIYqWn5IihQA+A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF7551E6552.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56228113-37ca-4ac4-e495-08def85641a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 09:44:08.4652 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tBSANZj0j+QRHGYFFuwKmt13n5T15BKWCQBogMt2Z+AYQPPGvXnlNwaZMTuVFXDpn4xLsRrlykiGR5/4Gfs6a+tYhKjo8KhOcNDJenSE0kM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8596
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786527857; x=1818063857;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ndpFxf91UpdPLjLVd51cw4Nnw726VWc1UVnskXxCqCw=;
 b=m7S/1FUoZejyxta0CeS2BbP+SFMFSQU1VXnvLfP4iY/kzDioTYS+ZIPK
 Pz4QK7ctfynuFUrj7JmhtP38ICVLBOx1sfzGP5fzTRI+nAgbkLNaPyx3k
 Mk+44+FDC++VEht0B2sUEbBqwD9XuCCMBreYJrQT6AhhpC9pmnlnXFdwx
 xY1qy/gidUmo4H76fsa33TR2UjuYpL39Wxb6LUK75BxxXob4ZJ+zwAIqH
 Qpao+1uegtIIOuFyRzRO+OXyVVWxcnaf7XFRKGzLrtqs48VWfROHYMsKF
 7cYzrZ2vTUk6vjHjEEZFP4xCMiT7gJu5vchBdlgN5RlYjNFZ0CSKo+xbY
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=m7S/1FUo
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH net-next v2] e100: fix
 shift-out-of-bounds in e100_eeprom_load()
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
> Of Malathi
> Sent: Tuesday, August 11, 2026 7:08 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>
> Cc: netdev@vger.kernel.org; intel-wired-lan@lists.osuosl.org;
> kuba@kernel.org; pabeni@redhat.com; edumazet@google.com;
> andrew+netdev@lunn.ch; davem@davemloft.net; linux-
> kernel@vger.kernel.org; Malathi <malathi.a2000@gmail.com>;
> syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
> Subject: [Intel-wired-lan] [PATCH net-next v2] e100: fix shift-out-of-
> bounds in e100_eeprom_load()
>=20
> e100_eeprom_load() and e100_eeprom_save() start with an address length
> of 8 and call e100_eeprom_read() to auto-detect the real EEPROM
> address length. e100_eeprom_read() adjusts the length with
>=20
> 	*addr_len -=3D (i - 16);
>=20
> based on when the EEPROM drives a dummy zero onto EEDO. A
> malfunctioning or emulated device that drives EEDO low too early makes
> (i - 16) exceed the current length, underflowing the u16 addr_len to a
> large value such as 65529.
>=20
> That value is then used as a shift count:
>=20
> 	nic->eeprom_wc =3D 1 << addr_len;
>=20
> which is undefined behaviour and additionally overflows the fixed-size
> nic->eeprom[256] cache.
>=20
>   UBSAN: shift-out-of-bounds in
> drivers/net/ethernet/intel/e100.c:768:21
>   shift exponent 65529 is too large for 32-bit type 'int'
>=20
> The same corrupted addr_len is also fed back into e100_eeprom_read()
> for every subsequent word, where it is used as a shift count again:
>=20
> 	cmd_addr_data =3D ((op_read << *addr_len) | addr) << 16;
>=20
> so validating the length only once at the caller is not enough.
>=20
> Clamp the length in e100_eeprom_read() so the subtraction can never
> underflow the u16, and reject a zero or out-of-range length in
> e100_eeprom_load() and e100_eeprom_save() before using it. The EEPROM
> cache holds at most 256 words, so a valid address length is in [1, 8].
>=20
> Reported-by: syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3De0abb1d45ac291ebebeb
> Signed-off-by: Malathi <malathi.a2000@gmail.com>
> ---
> v2:
>  - Drop the Fixes: tag and retarget to net-next; the underflow is only
>    reachable with malfunctioning or emulated hardware, so this is a
>    hardening change and not stable material.
>  - Clamp addr_len inside e100_eeprom_read() so the auto-detect
>    subtraction can never underflow the u16.  The corrupted length was
>    otherwise reused as a shift count for every subsequent word, so
>    validating it only once at the callers (as in v1) was not enough.
>  - Also reject a zero address length in e100_eeprom_load() and
>    e100_eeprom_save().
>=20
>  drivers/net/ethernet/intel/e100.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/e100.c
> b/drivers/net/ethernet/intel/e100.c
> index 29960762e64a..26a7c0aaa6e2 100644
> --- a/drivers/net/ethernet/intel/e100.c
> +++ b/drivers/net/ethernet/intel/e100.c
> @@ -744,7 +744,12 @@ static __le16 e100_eeprom_read(struct nic *nic,
> u16 *addr_len, u16 addr)
>  		 * complete address.  Use this to adjust addr_len. */
>  		ctrl =3D ioread8(&nic->csr->eeprom_ctrl_lo);
>  		if (!(ctrl & eedo) && i > 16) {
> -			*addr_len -=3D (i - 16);
> +			u16 len =3D i - 16;
> +
> +			if (len > *addr_len)
> +				*addr_len =3D 0;
> +			else
> +				*addr_len -=3D len;
>  			i =3D 17;
>  		}
>=20
> @@ -765,6 +770,11 @@ static int e100_eeprom_load(struct nic *nic)
>=20
>  	/* Try reading with an 8-bit addr len to discover actual addr
> len */
>  	e100_eeprom_read(nic, &addr_len, 0);
> +	if (!addr_len || addr_len > 8) {
> +		netif_err(nic, probe, nic->netdev,
> +			  "invalid EEPROM address length %u\n",
> addr_len);
> +		return -EINVAL;
> +	}
>  	nic->eeprom_wc =3D 1 << addr_len;
>=20
>  	for (addr =3D 0; addr < nic->eeprom_wc; addr++) { @@ -791,6
> +801,11 @@ static int e100_eeprom_save(struct nic *nic, u16 start, u16
> count)
>=20
>  	/* Try reading with an 8-bit addr len to discover actual addr
> len */
>  	e100_eeprom_read(nic, &addr_len, 0);
> +	if (!addr_len || addr_len > 8) {
> +		netif_err(nic, probe, nic->netdev,
> +			  "invalid EEPROM address length %u\n",
> addr_len);
> +		return -EINVAL;
> +	}
>  	nic->eeprom_wc =3D 1 << addr_len;
>=20
>  	if (start + count >=3D nic->eeprom_wc)
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
