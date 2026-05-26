Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEED3CD5BD0
	for <intel-wired-lan@archiver.kernel.org>; Tue, 26 May 2026 22:10:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5102820B7;
	Tue, 26 May 2026 22:10:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id br8zNmOKHedp; Tue, 26 May 2026 22:10:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DE03582086
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1779833442;
	bh=KrdlxH+Axk9KBdzB552Ac3RhKu9lErNaQMeVG1TmSLA=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E2hSAktI2sqTJvsGVXj5OyDKdgB5o3ZNP4t4ZPzllI4uRUhg6wqal84gGnTTEe1Af
	 i10cGnQCe+iqXoLBAVe3pou/Ll5d9rG6E9JlUUYbiC3/5EyW+CvO5lHjfk8xPkdGpc
	 o2Aqd0RXSoinjOjb8FXl6iWlfA4Jz+5kxcnL+20gpqc+QMN8uY9bGKDth6oBTmbsrd
	 auUca4dfgFVoAPP6v51XLMcnlLVgadF0OJGs4uR18RUwhbkjfYeBDkrKqzZGE3hkSM
	 5kqaWP7NE4V54u+h+jQPLl5s2oG3xxFCP2BGOyyxN0z+BYQ3Fa6RLy1/wQRmta9Hm1
	 qKq85QbSHKpKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DE03582086;
	Tue, 26 May 2026 22:10:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D12B297
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 May 2026 22:10:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4CE9882086
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 May 2026 22:10:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WbgRxrtsaqGp for <intel-wired-lan@lists.osuosl.org>;
 Tue, 26 May 2026 22:10:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9D62181FED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9D62181FED
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9D62181FED
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 May 2026 22:10:40 +0000 (UTC)
X-CSE-ConnectionGUID: q1z/MekOSbOrT+41ndztPw==
X-CSE-MsgGUID: /7NyEDbBRA+r8naYgaR/6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="80847237"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="80847237"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 15:10:40 -0700
X-CSE-ConnectionGUID: wOZoY/seQbe5G9TJTSvyug==
X-CSE-MsgGUID: 3o7z3ji6QducBgq51l6kjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="246079040"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 15:10:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 15:10:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 15:10:39 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.21) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 15:10:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYe60MPF2AYJTBAQX/x6dfq+l7g94CAjdsc3RCFC4H/veaRf3jW+zFcDOoAbZaEexfBISL58TK3LN0scZmNdUAyGDfPWS+JjHCg/LRvjLIR2iXMzxVAJmsOdo7mEj6Wu4QUMsIHx8ex2wKHtfCCiGpy6EVBuP7hdWLPdjUCLFPNJPqlzrNZwhX8osTYURDgWGTMEkHsOG8CqvYIWULs0yGwMLpKADkxy/jKAhQ+I4AotH0W8dustnvaVnBkV/1Z/AIj2p3Cxl7MzStF97RDS5jx6cI29CJ794J+mIJMYMKWnw8Vx9oxPWLTNp8y3CR6AMJiE7XT+O9OP9AoqnG2b5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrdlxH+Axk9KBdzB552Ac3RhKu9lErNaQMeVG1TmSLA=;
 b=hX5SdGIrBWUOFdvNXiMvJyLC3tay3eAJYfbPZ1GCjbGUJqPsuAoAZrbNuMmq2ptIDnXOwrKbxaRB2MAApN5lYaLqzeHKYf0CIFMSdRFdtFC2Vtqg1x0vkTLRj1TohQukJ/6BGtIYyT7l+GbNmAa1jw0TAjTEg2897Y+0EBLCgcc2m5JrIki5kOTfVJu/bvxccGPqC5M7DGLbz6abZHkyfUd5IEFLv4sXCpnDicQ2W4c9ususahhMAYqHOsw/fQ9y+6YO7UlqM+SAQDVfscr8j1tNJNe/yqkz7I1eKcqPRirpChue9m/hHCAIWY70z0aSNhtsD7C4rHe/UB9bzb62YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by PH7PR11MB6859.namprd11.prod.outlook.com (2603:10b6:510:1ef::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 22:10:29 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%4]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 22:10:29 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jramaseu@redhat.com"
 <jramaseu@redhat.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v1 2/2] ice: use
 NETIF_F_HW_CSUM instead of IP/IPV6
Thread-Index: AQHc1uN6eu4sDK832EaYZMGx3sbuiLYhCvJw
Date: Tue, 26 May 2026 22:10:29 +0000
Message-ID: <LV1PR11MB8790ECDE53A6B760F8C6691A900B2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260428070647.777141-1-michal.swiatkowski@linux.intel.com>
 <20260428070647.777141-3-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20260428070647.777141-3-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|PH7PR11MB6859:EE_
x-ms-office365-filtering-correlation-id: b7b5ad62-8c15-4ee0-2d02-08debb739917
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|38070700021|56012099006|11063799006|5023799004|4143699003;
x-microsoft-antispam-message-info: lt6gRLj4Cfy5FixhdAe4TDO/4fLd6/VnPGWG/NOO1MvLfRUcjYAhz7mEbab2sZ2GONvP3mEz2sQbXXD5tz1/mHEV7eDWF8H7Q+i/HdIlUeFK8b6APVBX28V74Utjnegk2Dpt5JoUgwz0PaG6u52jIZEFCMK3jKhZoqw02D7VRgClDJk9tAwz1rWHHq48RkZoVthL8yfUC4SV7EUlDN4JXfDcsk6Cd9I4Ecrxw5lsa3vNV7h9Rs3gOUnpQU6dSNQWWbPd4G1i2oo8bVL/RCIryk70vT6oKRgsdaMFpkQZ55/8IX5CgiyoqsMIj83T7K+NdYC2byfbRVkz6AOqiE9pXeajSq3vPheqIbyCAQU5IMqIpegDPzPYRs5CFdujZZqo8Sjl489sZrMzhTxXdRJ3vvcJwalDdZFVMAgrYgInddmlGSVP5tcGgCXoWfUs6POOh9FYsYIT742GlAhoDVD17qnyOUqO2fPQA/6c2Ww8M1OLA7wZEhFfZvLAaDHBAtBtAoMVV0nkpTey/uvPhSE7PbXwVcWxPiLPCQmboPsieoU224L6R62fvqJdE5QRmzBuq4spqTFXjHQ5Iu6rpRltkkvIdZbglkBw1+ERSIgMvkT1zVpoHcor3m1k5W/Xo7qGPxpBiO6qvxkRoqm4bSP1ISfBjjFDHs+gjhvxi5tDgRVddjUT1G0BGvnYGRNbPA8J6iVIjel0Vqon4OgN1ODxYLodDWSJrKVEsPZoe3bglwfV+dn1pi+/hJQNWcieKBDB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(5023799004)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0V3FxYSRKrDhx6McchQyy3+8q3U+4tSYUNG7xLyD4V+7D4u45kHmpDeOJGOM?=
 =?us-ascii?Q?Lh2v0kcBb9L5UvPtzPb4LmnZaeO2JW8RqWrnzTfno87xzdLHbTHLoFlqv35J?=
 =?us-ascii?Q?XqrM1aD1TYmzQ6uJy4tlMyOLmGawIVNk4nj/EO8Wa2agqGlG/IUew30In2Fn?=
 =?us-ascii?Q?BkuiW8e4OMK0kpLxf7jka7gsKohnx0r+efqdGYI8kuvyBiuc4lVHy4H2T9VV?=
 =?us-ascii?Q?HIMQcZaM5Yj6kM81P9iq4F/OlhDhozBm8fhgvGrtDVGMcw43Uab9WCsvqcpk?=
 =?us-ascii?Q?XHoZ4td3k+iTJKykPdGY0SJuc9JyrKmUa3GCMCPstW4/aW0OhJmQXxbwDwpU?=
 =?us-ascii?Q?8Jh/mEp7tb7ZCXLZsVcMbPkflr0Ox9rZCVQjLBAtosGt1b/whdtTYTgmoS3N?=
 =?us-ascii?Q?l5/qNdSDnw8irbX5klrkjklrkOQ9tDUJUce4rlxthyDCTPz15hEcGeCndcTg?=
 =?us-ascii?Q?VpX+4j3N7HFR/rXUgIdt+sdk/bEBE9lA/P3fq2n77xuNJu1hP+OUnJ/IzhfF?=
 =?us-ascii?Q?XHoi3418ITe/aaxv4/5B4dFi3+rt92O7FDwTlFonREsgBSJek8vJ4KTtEE3M?=
 =?us-ascii?Q?+voNSCaTw+B/d0d33n44DXY78i8fjVxu3YQyBnhL7T1q4KoSzkj95osIdOCg?=
 =?us-ascii?Q?Ro7CGWh1IrHz8aMV1Ol1yPcbhFtCQAHtQqc2sjjXDAjf53i7gQASCgdUs+TH?=
 =?us-ascii?Q?8nf+x+jAQO4wQ0JievLaY/Lnaad58ZZRsRjIiBND2HpWzdbQr1F+KRcGg/Dm?=
 =?us-ascii?Q?oStkQrXy6bHR3YvYbJ3ZnqxyYdnqTVy7RS/vVep7toQqw4up55rhKRjtEkkJ?=
 =?us-ascii?Q?ShrFI617Hq1KefG13xi8GmT0q8VxAzfTVEl3R/TjxlNZxaT7em/Ve6CYw4DQ?=
 =?us-ascii?Q?lpp1ifj4Aw4lP1G/mneXMuCcHxSqItSYvlbIqmKNg1GO3Z+wESiapp22iMNH?=
 =?us-ascii?Q?8zDXTbnVPfnHpNytyGDInRZsBEqJpVGAZ5hi74lAN9ZuNK+xx4Si/Ung9KJw?=
 =?us-ascii?Q?LLoFm+DT6kFaA5a3koBIkoC5JWKu9NPPvlxMlX1P+m8Alk61CIsafdsgNpYQ?=
 =?us-ascii?Q?eUSlVpwNCtiFsFk9qUy50EjA8fTvhmYs+0vStHLiXs+4rQgYqxtyL1qlIOPa?=
 =?us-ascii?Q?vdC/kUF3kKZIJ5gaigot+bvBKaWNahRXQQYCPpdWutclLwCazt97r3kjcdmS?=
 =?us-ascii?Q?kaka20vDYE+5ZIbV/6JeAHvzPwX4y7W3gsQBKA3RPOgj4szZMCNsnto0D2h3?=
 =?us-ascii?Q?Rbe6nAJLKIZCUBwieyYP/IGJuwVnXMPrXnO7iF2tSZtpUOU5HDwEVAhKX53k?=
 =?us-ascii?Q?ZxNhqopix8nDJRL2HVWYQvUy8mkMKNA/GUBxAlmiWr+vBIqRBBo088m/7rcp?=
 =?us-ascii?Q?KZX9AvTpLweK7sZOlplTsIkdEngXQfJy/1akoP/K65IARnnHQWkC0ihUJSXv?=
 =?us-ascii?Q?qOBEeohV7nlWPOurb+SB6gctskzyAQu1Hc+ZJdZRQX+HsNtPnYq0i4r6lzCx?=
 =?us-ascii?Q?K4VeJXyDdfEKVt5911yixTu8RLMXvlecLeb/oYTm/soIME1tz3asdnVDKn2J?=
 =?us-ascii?Q?WXGk68vPlY2qZK4eN9fdTFbPpbYpQYmqtmekIVR5nCQQ5qtjJoVxo9Yqg9iA?=
 =?us-ascii?Q?Kfu6Ky2dIdVJStBa5Uk5KQBtcV/eb0eU6J+shGTnB/8f36q7Kqi7zCVHPcRM?=
 =?us-ascii?Q?wZZ4qJf1Rjjhy+F+hQL3zkol69dTuaezhlqIdH0nzOqZspYvHNGQpoD56kea?=
 =?us-ascii?Q?yyCLG7RcGQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aNgLOsv9ykqrtJru6nRj7nPlqzswcAx6JQlK0O0PQd2Ed6XAVO+i+7hoaboHEx9iTWE28aet5PSr0YOHbNYd+PXqKTJ6tL30qZy2RINgEtTVDh1FveDWUAxWgkJa7AdEKrUePHhSrBCyykVNlonkaSDCkUL7QQDVERhPOCct5ARRTwubVIO/mk9Jnx5FHLilaCIijmWPl3vfYD6gw8lkPq6t5V5rKIcjxukWYAom0flpYNtakVU532kMpro77/ccdT3zy5EQjzAy9STulLxJcOroHYyH/BJ9mtC/25iTwRTbQ49bxTw74gkURXUX5gKnTHWWez725QvhLHNFaq7L6w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b5ad62-8c15-4ee0-2d02-08debb739917
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 22:10:29.6709 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QVNSz8jAF+auLDbFx9TOLR75k+ZrS4CV8GyX+6l36NWzAlufXqtqVNHq5LjOKOY3DQrR+qTxWr3jMUGYb11y0ZK5w+GI6vPlRNVE7hsLKjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6859
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779833440; x=1811369440;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RaYXf2fKHH6HWAbEQmQspEEzkn2UvZyS6jYr7feLrxA=;
 b=fqj1UWhC+cDWaro5GBDSYoldWDSR3w5x8Nw+MgNixvp2MBm9okFSDlKW
 iF2nBWdxtuMwzB3n5IHBMg5Gs5z7zZMBtLADFce0vJ+JPfnDn/FRDPlkP
 fYwknktykUcq380Hxg+u4x/0UzREVsyLMTMwXpOXIj1R+yVHVKeBYeFrE
 GAp3ea/YuC8PJo2t5dWbbEuM/G0N+o32O1c7eb2ABZiAtfy4D3nS26xR7
 PKYA2ZSK4x1fmoVJe6OY/axLIf9+ki2AjsoUvyqz5h7NdXMmuINhacuCk
 alMGpnbIKec3QORIQTgis9dTxx1JFUxLc8iYow9ff6B5cWvicrFDU0ZeZ
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=fqj1UWhC
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1 2/2] ice: use
 NETIF_F_HW_CSUM instead of IP/IPV6
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
ichal Swiatkowski
> Sent: Tuesday, April 28, 2026 12:07 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; jramaseu@redhat.com; Nguyen, Anthony L=20
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@int=
el.com>; Loktionov,=20
> Aleksandr <aleksandr.loktionov@intel.com>; Michal Swiatkowski <michal.swi=
atkowski@linux.intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net v1 2/2] ice: use NETIF_F_HW_CSU=
M instead of IP/IPV6
>=20
> The hardware is capable of calculating checksum for IPV6 packets with ext=
ension header. To not drop=20
> such packets switch from IP/IPV6 checksum to HW_CSUM.
>=20
> HW_CSUM is also used in previous generation (i40e).
>=20
> Previously HW_CSUM was used to indicate that hardware supports general ch=
ecksum. Drop it assuming=20
> that if the hardware supports it, it is used.
>=20
> Disabling offload for E830 in case of TSO isn't needed anymore as the che=
ck for TSO is done in Tx path=20
> just before preparation of the special GCS descriptor.
>=20
> The commit from Fixes didn't introduce a bug, it just shown that the driv=
er is doing sth wrong with the=20
> checksum features.
>=20
> Suggested-by: Jakub Ramaseuski <jramaseu@redhat.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Fixes: 04c20a9356f2 ("net: skip offload for NETIF_F_IPV6_CSUM if ipv6 hea=
der contains extension")
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 21 +--------------------
>  1 file changed, 1 insertion(+), 20 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
