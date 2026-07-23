Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4DBC531C7
	for <intel-wired-lan@archiver.kernel.org>; Thu, 23 Jul 2026 09:22:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 29634407D2;
	Thu, 23 Jul 2026 09:22:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RffDOgFqf3eg; Thu, 23 Jul 2026 09:22:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 40C36407F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784798542;
	bh=0YtqLI69dQ/8+bZMR4PvQlhh5lPujV8Qgx8LiBFyVIA=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oEuoaVZMfjxFBbXwSHiJbxQsBXkQwemtYzXXgnMFbOkwpMH6okQDpgaB9yjPiJCC/
	 KrNIdRSzoIR6+LHg9qNhn6F1lvP8Hm/0PrBXgxTtDP71rNPb79132bCc1PidISaiGn
	 b1wIxJMeQcqfhhtJvXQUX75cq76yOB1azraKEjxUT5iB6rPaJkiK6yg/oslIKlm0R0
	 qBAlkbnPueTSJo9dzwlX2IiaFAFRsn0BKVHZx93/vzxmWR7AFDODMl0ZW7uBzJXySd
	 XdxoNQqAn7R2E4xeueLt9Qx3QD8G5nLBRLGmXPO0Tdwe1XfxyDdAc4VZhTVRIYqETV
	 mzpVjBSVGJpKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40C36407F9;
	Thu, 23 Jul 2026 09:22:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C944347
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 09:22:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 69B7D80EBC
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 09:22:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uA1vz8ahfe1Z for <intel-wired-lan@lists.osuosl.org>;
 Thu, 23 Jul 2026 09:22:20 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6304080EB9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6304080EB9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6304080EB9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 09:22:20 +0000 (UTC)
X-CSE-ConnectionGUID: nVOwGXaVScSfK05VL+yOMQ==
X-CSE-MsgGUID: 7YIJcNV9T/S3ZclYrX/kMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="89342414"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="89342414"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 02:22:20 -0700
X-CSE-ConnectionGUID: llNKutXBSXqdJoc7W+jbIQ==
X-CSE-MsgGUID: RDYHdeAKTZG0cpIZ0cgCrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="262666755"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 02:22:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 02:22:19 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 02:22:19 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.41) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 02:22:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFNtmsuKexK/jkLvd1KeImWfDu3EQVcsRmI+LA58lFDNR90P5gT2OnqLL8cOKAIfN8X7KlA3n4KRKbVgRDY/z0+ncCtQmgoFjvt1ufUEnRfn7J+K3ZUsxkeXxZcjuazKsplJ+/txLaqjpyJBMGbdfjlCGPaZ/kN36bladXdZ4cCSVvTfS/V1JFQ1+Yr2PqA1xzySLvFdctNKhxQEl4jJRwmPoXvejLPETvzZAclzUfvxSVXTbKdVTo5UbqxrEFX2QsR9TAbP/5HXdXtq0tyku3Gc2DXv2+HvURgUHyAeY6TAuEq7WBGTMrr3epqJ/joChWuUjGXakIT389ifnYzq7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YtqLI69dQ/8+bZMR4PvQlhh5lPujV8Qgx8LiBFyVIA=;
 b=nYU2o138b63scPPTnaAlutb5ua73wInNP+y+JBA+3nSD/L8PhY7dXAWkIQUozHlUvgxBt2kXOwKUN8wnOqoBn8Do+DPfebB67pDktbDzQKjoVAFPaFEWdMT7rihHJcALyzZCowaQ/IX3CXrOT682VDrywuTaaujp0Y8CW/auTeBk8R7YK2psZFMU4RXFup8DDRV/Cl5vW3tKXeai+IZS1uZuCbNnWa/K68w+D/yt2x84+bU9yUzfFMO0YuT1MsY0/rRmxCkY7j71VrPpdjDIkrF0QDZUb67yO5WYRhqqIGYFSWvpEY3gA5nAHNep/Ilhvt4/uk45ujxr9kpXo1GIyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA3PR11MB7628.namprd11.prod.outlook.com (2603:10b6:806:312::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 09:22:16 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0223.017; Thu, 23 Jul 2026
 09:22:15 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Ilichev, Konstantin"
 <konstantin.ilichev@intel.com>, "Lobakin, Aleksander"
 <aleksander.lobakin@intel.com>, "Korba, Przemyslaw"
 <przemyslaw.korba@intel.com>
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v3] ice: fall back to SBQ when
 LL PHY timer interface times out
Thread-Index: AQHc9OOg276S5Jh3x0egaYhIwBnYCrZ7H6iw
Date: Thu, 23 Jul 2026 09:22:15 +0000
Message-ID: <IA3PR11MB89862E31E3D1617D6A52231CE5C02@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260605120734.1462847-1-przemyslaw.korba@intel.com>
In-Reply-To: <20260605120734.1462847-1-przemyslaw.korba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA3PR11MB7628:EE_
x-ms-office365-filtering-correlation-id: 22ea50b3-6e4a-49cf-f057-08dee89be2d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|38070700021|56012099006|11063799006|10067099003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: WZIyv8Zg0tKAMkPmnWxsOUi7oApKJ1XMqZb32jewJTOBSKT4X9eBx2d0QhsIDFvHwaYQnB3ik+GhL7BSbQduFp+DKFJTWvRDGGXhvFHUTl72UxdYdmyLemZzIBORpboaTKNMGDzjRODrcYzvVqhBRK19490az91sPKIXOt1pUiNnY1srBznfLRCkBZJGoRHLDJfuXHs6yEOb4oiK/Y28Gg0bGLRWn5c1mF2tF/t+AavGqe7sSQcSOggqDkgxgFjTMSsqJbFkiUwmP04qTS1ujkhYYpP6+rl4b2Hn+XfMXD1utEyu9jeWO6I9V5un9Hb86r8PY8BOvNY7ExOXVpH9Ihr0xmHEVYWfe7f0DUy2zW1kpNU3AvV3UtNk2NyXgEyJ3VAUC1znaO1gm5aSVE3zzD8iyZB39YPSgdpqpW/of7NJia9LsEX2x7SSoZZ5YPU6hG8U5XkTXSO6x6m9D6PkJf/y2NdQlLTjGKN3l2ZlTmixfGxjPmPsXPGL2u1I4HhWkH5ZH7XJayYSUHXviGeDRU+TWVkzbOKA77kSH6E35CBNcmYz8PAz0dWUCQXVoHKENO73VkNDYjJyp4AXvP041OGCe1Pm69WzrIGPipJtVfnuuMjKlzZ12eNcrBMvv2EP61DDUaPJFC0Km5OcEqFa9KVVzh37wOw/JntHp1ewr8fJ1kiiohvlFdyUe34cgb/24EF7WUpi0i2ZPNPje2dq/NtvxOxDgFSzSTEP9Dc11mY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iG3DCZi9JTnzoixVlxPOfp7J0NAJmn7608YWOvD1iTiOmn03YEEgcLRecP+O?=
 =?us-ascii?Q?hk2KJtZYibInd4gjQSGCc8K1xlAkDkO72Z/owIujEknyFp9dPNzLPccNEG1B?=
 =?us-ascii?Q?My2s7mq+TYTdQXMjNBmkDmoY3U3nksbDiyespFd5QEQV1LFV5NzuUj5K6v8W?=
 =?us-ascii?Q?d73Yh4Wd9In9eC5vvt79/6ghd0cadAcQuJOXrZmSKjJD501omhlaNv51Ms+m?=
 =?us-ascii?Q?3B/stA+KU55YWasVBeCK1LeEDZDjGdRbwzxUCo14FzkpLe4EidH71dIL8UCX?=
 =?us-ascii?Q?XOirJPl3wFMl+vAC5vhp/1GcNQfQvN+fAVwrD1Pij1aJJjhreyNo6gHZATfD?=
 =?us-ascii?Q?c2T91+g2z8wbOodHdewUyG5V9GXxtvfTXF5ISElnu3FLvp8YXJlNtzrdoFB3?=
 =?us-ascii?Q?MEMSyBbvMi2JUtpx4Gv8jfA5qewypzg7b804nDQ+sCwwAbvHEGrspZE+p71y?=
 =?us-ascii?Q?ipnZIXTBkiukpROW5/nwJ1wIxdjNkW/vXWjZ09mgwqU/4u45oT9aOL4dk0sR?=
 =?us-ascii?Q?9u58pxGB9WlYl/iBxkKz/S8tl66e/jJX/wlJ9MdaBb296beGOpGxDrlgtG6y?=
 =?us-ascii?Q?yPHb3KBupaiMXTXEDpadQ85/c2ruDVooE/cUVC4akdYD/pU5QWqBMPW0K9iT?=
 =?us-ascii?Q?3nn+euWM1gS/xjSL/AzfM1cn4Kp+bJjreqi5wDSzHHjTj2nid963FvkOVE5U?=
 =?us-ascii?Q?uhbLdK382zcezM1tczs+fh8EitwNbT/6fmWbUknrbEbPaBxxhspQLRXJ7xLV?=
 =?us-ascii?Q?C15rk6tKyRwMWcy7cyme+gALBOciUVHGQ8w3piNfHPq/1PuqCDrYovhgTCm1?=
 =?us-ascii?Q?wHGww23jNNuILYjXUTZ7UkNXxCCBJOXZDN/vyT6sXus0HCHpI94TfvGKHzrQ?=
 =?us-ascii?Q?m45jwTJ7lywAcA2OTJIavxjBJ5iBAU+bmG/+d6aoEAl5+0iH/+3J1BXqw+om?=
 =?us-ascii?Q?cnumy4EKYoLQEjhFp42LFQDrGXX42elZ8ZQHlu/aS4AODJGBJMS7ImCLNo5i?=
 =?us-ascii?Q?tGqPLRaQVPrEdjrTb6yJx5iD+MDCYP3WlzovWIWHgd+s434t6KFx5qTPFyIg?=
 =?us-ascii?Q?ey4hb9AcRlBLHHtbf2H/VoZJV74/gWhPjICuk39U1AHddb6tL50HIkL+PMKC?=
 =?us-ascii?Q?rN52/VKCQ6UnStlomY9eTH4DY6JKUT526Vd30w8Pz5cEAJQ0XhjqRML9lY2U?=
 =?us-ascii?Q?kxzAZP+87EqvvL+GkzpbrfYO+pIj8/uoC2XXyjH6N/01F3EY8+ggXsgvcVXE?=
 =?us-ascii?Q?25MPMSRM1cVVQAxVR7SvzkiEV1FJJGtIgq9vFKCX1saAuZTEMGCV1d7xzIYn?=
 =?us-ascii?Q?s6xKHALfoLrHNjgaU9FLBfZdi75PAvGopH14C3tG9wzzkXw/OLw823Jz93x7?=
 =?us-ascii?Q?3Aj7JOyT+1KwCGJO1aVvv5vh40o+kvXjiLWrYQYGvW6yednC/lffxCYMA2th?=
 =?us-ascii?Q?cddB4X7r/T8ifpvrImaOpW7bSEXQI+1BezKuMq9SpDK+aOXTsN0NyG64SmG2?=
 =?us-ascii?Q?mTXAGzfRENbWIYY/ESYeEZEd7U/Iy6bIyCHEYXYyQ9OLnOri+einYoLIUwSG?=
 =?us-ascii?Q?AWjs6rZpP4XB2IFnDHcmjY56ojoWrwb7tji0xK6H8sb+RiUQuf5Dx1XkWh/t?=
 =?us-ascii?Q?BWjsdt1RiCdbi+B+CdR1mf5GeymOrx+yGkKp1wEbliVGIsPLC9lppOOkpiMt?=
 =?us-ascii?Q?tdUYr53WoiTBk0UDp80/rIYUROAORQKuLUb2kBKXEkGC4BMLgoK1ff+3jqEx?=
 =?us-ascii?Q?T6ggIyIMGmWh8LG/iQgTv8KC6/eHDX8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UnNZRuH0WICuQqFLt2Lfv8V6+JiiNOwHqTxzNWfpeDqnKJXqw7xAU0DEIoUZ9AcXry5pHW99sjmHxTT1kBrqyJhNb3VaeLKX4/pg3D497iCE2CWBebAbZb3MfrvEIFYZvOtQQe45ad60dWkI+9LVRPMU1+ER0Z9if5mLkXDHppZj1fwgNg43SmYgYGoIDUqoMpiIDBtnQV/2n7j/uu60McL1P49LWj6rSpcNeA0Y35lkd7Qhghi0aNZbz4RAYmSkkautVRFAIjfdRPxB1tOPxngY79Suf0NNT9YL5mtC0DTTEPAAYtMiiPMY5HRnJwb8n32vZRmTYyca1t2trwLUxQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ea50b3-6e4a-49cf-f057-08dee89be2d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 09:22:15.5626 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HxecFMBHFjFYei4MjTyzeE7/ePfYiGoi01sW6JyPOzwH/xmwUdf1y1SchWMJZL1XeP2Scihnw7kspyy/XqVzTXnEdLstQhI0SI39feykGF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7628
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784798540; x=1816334540;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Z9xnw4TDBj8B/XeccFxWAfxCAn4zxrgNq6JdLw3SOr0=;
 b=E7x40QJiSaQO2l9NpRSz6xbXm1QlaxlN0PYv4TODRX/F/IjziVa1vS2I
 rYintkkdTTmDsXpUu9/6IpNVTQMGvh/rv4bBvqVpy8NY4W0LhFPzWBxhB
 6wZec580PRELTN69LCv4NMr1y6gBR6VPnijoPHx6356OeNUOzLh4YBJie
 zWrtruVa+rsmU+YtsfPQZBUP8xRWqfrd7+ZW0uVDaJEkJd6eN6p4+SvjU
 PnX5ZkL9ykyFaOkHXDIUcrHSjLMXujo0ZI9Nqyhl2hF6v2FGpbvl0CkkZ
 B1InnczZY2kHS81/kg2bvhMiYYvRcwt54mo9lmTiBKaAQbRJqxXvVrs7U
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=E7x40QJi
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v3] ice: fall back to SBQ when
 LL PHY timer interface times out
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
> Of Przemyslaw Korba
> Sent: Friday, June 5, 2026 2:06 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Ilichev, Konstantin
> <konstantin.ilichev@intel.com>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Korba, Przemyslaw
> <przemyslaw.korba@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net v3] ice: fall back to SBQ
> when LL PHY timer interface times out
>=20
> The low-latency (LL) PHY timer interface relies on a tight, atomic
> poll of the PF_SB_ATQBAL register with a 2ms timeout. After an NVM
> update / EMPR, FW may need significantly longer than 2ms to start
> responding to ATQBAL commands. The first PHY adjust or incval write
> issued by
> ice_ptp_rebuild_owner() fails with -ETIMEDOUT.
>=20
> Fix this by falling back to the existing SBQ-based PHY register write
> path when LL times out. This makes sure PTP is initialized when FW
> takes longer than expected to come back online.
>=20
> Steps to reproduce:
> ./nvmupdate64e -if devlink -f
> Update E810 card with nvmupdate64e, and observe dmesg errors:
>   Failed to write PHC increment value, status -110
>   PTP reset failed, error: -110 (-ETIMEDOUT)
>=20
> Fixes: ef9a64c07294 ("ice: implement low latency PHY timer updates")
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
> v3:
> * actually add TIMEDOUT check in ice_prep_phy_adj_e810 (did do it)
> v2:
> * add TIMEDOUT check in ice_prep_phy_adj_e810 (did not do it)
> https://lore.kernel.org/intel-wired-lan/20260603114904.1297713-1-
> przemyslaw.korba@intel.com/
> v1:
> https://lore.kernel.org/intel-wired-lan/20260511095830.1095984-1-
> przemyslaw.korba@intel.com/
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 38 +++++++++++---------
> -
>  1 file changed, 20 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index d47d5baf3281..e77c7f2b5575 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -4789,15 +4789,12 @@ static int ice_ptp_prep_phy_adj_ll_e810(struct
> ice_hw *hw, s32 adj)
>  				       !FIELD_GET(REG_LL_PROXY_H_EXEC,
> val),
>  				       10, REG_LL_PROXY_H_TIMEOUT_US,
> false, hw,
>  				       REG_LL_PROXY_H);
> -	if (err) {
> -		ice_debug(hw, ICE_DBG_PTP, "Failed to prepare PHY timer
> adjustment using low latency interface\n");
> -		spin_unlock_irq(&params->atqbal_wq.lock);
> -		return err;
> -	}
> -
>  	spin_unlock_irq(&params->atqbal_wq.lock);
>=20
> -	return 0;
> +	if (err)
> +		ice_debug(hw, ICE_DBG_PTP, "Failed to prepare PHY timer
> adjustment
> +using low latency interface\n");
> +
> +	return err;
>  }
>=20
>  /**
> @@ -4818,8 +4815,12 @@ static int ice_ptp_prep_phy_adj_e810(struct
> ice_hw *hw, s32 adj)
>  	u8 tmr_idx;
>  	int err;
>=20
> -	if (hw->dev_caps.ts_dev_info.ll_phy_tmr_update)
> -		return ice_ptp_prep_phy_adj_ll_e810(hw, adj);
> +	if (hw->dev_caps.ts_dev_info.ll_phy_tmr_update) {
> +		err =3D ice_ptp_prep_phy_adj_ll_e810(hw, adj);
> +		if (err !=3D -ETIMEDOUT)
> +			return err;
> +		ice_debug(hw, ICE_DBG_PTP, "LL adj timed out, falling
> back to SBQ\n");
> +	}
>=20
>  	tmr_idx =3D hw->func_caps.ts_func_info.tmr_index_owned;
>=20
> @@ -4882,15 +4883,12 @@ static int
> ice_ptp_prep_phy_incval_ll_e810(struct ice_hw *hw, u64 incval)
>  				       !FIELD_GET(REG_LL_PROXY_H_EXEC,
> val),
>  				       10, REG_LL_PROXY_H_TIMEOUT_US,
> false, hw,
>  				       REG_LL_PROXY_H);
> -	if (err) {
> -		ice_debug(hw, ICE_DBG_PTP, "Failed to prepare PHY timer
> increment using low latency interface\n");
> -		spin_unlock_irq(&params->atqbal_wq.lock);
> -		return err;
> -	}
> -
>  	spin_unlock_irq(&params->atqbal_wq.lock);
>=20
> -	return 0;
> +	if (err)
> +		ice_debug(hw, ICE_DBG_PTP, "Failed to prepare PHY timer
> increment
> +using low latency interface\n");
> +
> +	return err;
>  }
>=20
>  /**
> @@ -4908,8 +4906,12 @@ static int ice_ptp_prep_phy_incval_e810(struct
> ice_hw *hw, u64 incval)
>  	u8 tmr_idx;
>  	int err;
>=20
> -	if (hw->dev_caps.ts_dev_info.ll_phy_tmr_update)
> -		return ice_ptp_prep_phy_incval_ll_e810(hw, incval);
> +	if (hw->dev_caps.ts_dev_info.ll_phy_tmr_update) {
> +		err =3D ice_ptp_prep_phy_incval_ll_e810(hw, incval);
> +		if (err !=3D -ETIMEDOUT)
> +			return err;
> +		ice_debug(hw, ICE_DBG_PTP, "LL incval timed out, falling
> back to SBQ\n");
> +	}
>=20
>  	tmr_idx =3D hw->func_caps.ts_func_info.tmr_index_owned;
>  	low =3D lower_32_bits(incval);
>=20
> base-commit: 2d72c95ac8e2d1abccf671d95b94532a8b2abb24
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
