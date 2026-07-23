Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24234C531CD
	for <intel-wired-lan@archiver.kernel.org>; Thu, 23 Jul 2026 09:18:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E276D60704;
	Thu, 23 Jul 2026 09:17:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sITeFCyTwhSe; Thu, 23 Jul 2026 09:17:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 37EFD6071E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784798278;
	bh=q7JYpC1cu/pp0vmiOPnBHmvoTB7ZJscBA/NaKYQiaiU=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1gG95Dp58jWshUMLvsmYG8wZkq7+Eb42MV+rmGcj/KgX/bBZd0m3doGhmmQ4XgKEn
	 EQkWNQNiZxn+m7ybGKBMBVj5A+UopTuv7chmwN99Wc4byKWCh6FfnTiYtc36kbofrk
	 8DXfP408rOY1eurUUp2+TGWTNfUJP0/9ndjC+sCxd0iBA3u/Z6veyDPzjpvom513BU
	 254AklVOOGUIi0pplM8fI58zNFM3E2EJq3mVPyXIABZEgp6p1TLgVkJLaX5lXmZVQd
	 Zh6ghGkB9j9xw6KndDCVSFldtHoYgm9I2FPXXP8KKUM4LnaKXA0bLjQAi7U6zdc/UD
	 hJg62NCXPeXCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37EFD6071E;
	Thu, 23 Jul 2026 09:17:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 54FC73B1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 09:17:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3B18840243
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 09:17:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7u7-Nqvzthsj for <intel-wired-lan@lists.osuosl.org>;
 Thu, 23 Jul 2026 09:17:56 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 64F7540026
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 64F7540026
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 64F7540026
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 09:17:56 +0000 (UTC)
X-CSE-ConnectionGUID: ncUH81ulQEOd8+yqDgLsFg==
X-CSE-MsgGUID: reXFbuA9QIGhaO26dfcaOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="84575397"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="84575397"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 02:17:55 -0700
X-CSE-ConnectionGUID: wHHS72oYTF6nMvU9GgGYoQ==
X-CSE-MsgGUID: DIQkO//yQfGI596ejaBpJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="256557604"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 02:17:55 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 02:17:54 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 02:17:54 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.11)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 02:17:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8F63GyiykJw7bvZRi+FRp5RTepxhSghNNjJnDmnYwuqv8tVSwSpl5/m4bw/sY4YFuqbOyjlcMKc+m3bbdJJqhp2UCqDwOEyAsL9VZIIxxdaRIUwFyu0DmVOh3Mf8pUyAvAL3js29z+Nj6oQWG1EKMAF2hkJ3lNm6p6PqD3Yqt7wqb1oQq26yTbHp2B76sspY2Kgt5YiVK+xDyQiqLKNva3fiKww49R283H3abpnp3/iKyBlbhUUjz2+PWYyp/wZBpU7FdeK/s47hy6ulQBFCHpFNg2nNmxH+uNTOMurMG0CVWcbQnVMlBIx7IsN9ANuIYTyoj/gqW3MDGsCF/m4GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7JYpC1cu/pp0vmiOPnBHmvoTB7ZJscBA/NaKYQiaiU=;
 b=Oss4o4sqHjddu2m9W3Ebu5hSteQgzoNWSg4kqPBRw/EnVekwTPxsx1iGLW8MPThGfBMAwVkbvqp12ACLJ7awJyvm99pe27BqJAAqPEr/1yDm+eaVpoaLBSy5IxlSqmV1xK2ZrOyc134OzwedPhw32/eIylPA+LvNTXl0YnV4PXUqjbAUueJn5r7TybBIUuhcINxgyrkBYMFbuYVkhYXvUlL8XyOlZava3jxnalKwQhSaQZiC+PNgnAgJmWbJq0vDuWS//Jld0N7S3TGXYbUGWMPONKcDq9Efr7eebm4nMD4beGb91K9OvfL7SRsOdBHnWjxBNFvBV3ea51Yyuozg1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA1PR11MB9633.namprd11.prod.outlook.com (2603:10b6:806:4dc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 09:17:52 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0223.017; Thu, 23 Jul 2026
 09:17:52 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Myeonghun Pak <mhun512@gmail.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>
CC: "Olech, Milena" <milena.olech@intel.com>, "Tantilov, Emil S"
 <emil.s.tantilov@intel.com>, Mina Almasry <almasrymina@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Ijae Kim <ae878000@gmail.com>
Thread-Topic: [Intel-wired-lan] [PATCH v3 net] idpf: disable PTM on probe
 failure and on remove
Thread-Index: AQHdGFUo82Q5g1f+FEWNcwA3GK5R5rZ614ug
Date: Thu, 23 Jul 2026 09:17:52 +0000
Message-ID: <IA3PR11MB8986986280690863E016ACA0E5C02@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260720143511.43408-1-mhun512@gmail.com>
In-Reply-To: <20260720143511.43408-1-mhun512@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA1PR11MB9633:EE_
x-ms-office365-filtering-correlation-id: 4ed7ed38-ffda-483b-2e1f-08dee89b45f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|10067099003|11063799006|5023799004|6133799003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: j0fg79l7yTl/oEaFj5F76zWRL8YdF3bM+prEnjnlcTrCNXEtuIQ2448mRqVbNr3Xjd//FAdP2IzOzEVTHYdD3v4GF3iBePgKme/DScxuq+DgwLpR3cNQa3JDtq4Ndu4vUnoOx0iGTP3H6cMzki93Ebc2tZt+P9/hOc0ZhwB7yrJTDDDrLQ3a1ubjrpT7jTz95Jty+1oeq9+k4PXYj3kSVj9ncTX/ooS7ChzCqa8vnJTX7JXfj4zttxkBplNZVEMpH+UfXe3P8POdvleGKg0RK04bHS+S94nLZbpwbzr9MWQeZZ7zP9rGShaS4cs63epDCMLsdVVaacMTDuLNC2nJwIHKxtSwJmQe0tl3QgBkHMFtkrglkzQVj4zEZV6paMuT5y7LIPaPvCeJsLZ91xseQKcslC07y/CFW3t8K7m1HWvf6DAZiy5FgJKdR00vQg/vpsNwcM2f6EIFhxpJY4LAiEya+X8Q8f0XEoUU1nJHe7d/df9ftZGAhDd5j0v3V0tOmK/gvTmqPJ4qUVsJUEiEqWQ+ilVwBeWH6DTq1nDOlNN6FbF1LULpAwMqxYA48/jegAXKwCLLs7SN7VyhLZnb7WgUJL7VqFZyKCqAvojUUd/IdjP2IZp8gIAfhiAQBvwXSSHFLSKkIUHLXI/AfYFtCSi6ikmCO/MA0uOJ4A5623EPKnRFcEGGyNHpJtFPXuewTw+5K5kV56lKNxFH7hsYeNaYfzXqdYKNGF8darssZFA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(10067099003)(11063799006)(5023799004)(6133799003)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wm9Rg0MqtIWxHvlUjhUK8l0wjIRDzch+Iqe4cVPnkMbE62soUJ/DV6HLyChD?=
 =?us-ascii?Q?YA4BWmDPzVRKRO5/Yv8k0klHPdhocawFyRxe/OqLeHCGAHAwN1FSnKcsYVlC?=
 =?us-ascii?Q?RDiA/Il4OfbPLg5JzA5k0fsfNhqG4iGykjym9mwPhzr3/63wErXH0IrlBEQF?=
 =?us-ascii?Q?jNpMTi+AdJLHBPEZvwf31hZSPSB0UU3NcIDXQxoB3ngwK6+Qk9zL2k6/qpby?=
 =?us-ascii?Q?MPaP7D/iczxAUlm7R85tLY42c3NEjg5EbNQXtGvVL/a4dxY99RJIPME/IMIe?=
 =?us-ascii?Q?xLCLOkjUm5+kVYwW30j9bhNnon/qIN6JqgJPAGiLiYkclkBFNflMEpSXnZy/?=
 =?us-ascii?Q?VMADNIY52wc4hMUTTAM7cqFsM4iutU6igx81r8eYO1iccSrfLy3Q1b46RqSY?=
 =?us-ascii?Q?NKxG6YEBI3aT8X4fmYEvdgsMAb+JioCn90rcSXGoJQyj6M2BqIQ3/6a1nlWU?=
 =?us-ascii?Q?++Qo8VMzW5amPrTM3L3h8Fm9fXGQpJ1yZA5ndJ5pptGvhdr+VOuM8jxBEZcP?=
 =?us-ascii?Q?gHF7RdfCSZsUczpVzIvklgKX+fy0tONW9cBbahOZOnW1ncbM2ZPFW5/zjkj7?=
 =?us-ascii?Q?laMJrFJxKgPMycOxiaJy4T1yt3y340C4nJWsOXF9ToSL7xXGBFsTrnReKLn+?=
 =?us-ascii?Q?gEiFw8RByaSeSPpYAdhDJf45+QkpNDFcN9Fd6t5yAHt4m2090Rh2jSHaSkiV?=
 =?us-ascii?Q?mTrkIJ9yItiyQgJVdijdxo7jmLUP/cR+TkW2St2IZcXBIdkH51p/Iy6/OdB/?=
 =?us-ascii?Q?VGjtMsptnxcyU6p2krBTIb5Q1cHCFvr09LSAtAZGjwFQLoJeU/G05E460IMl?=
 =?us-ascii?Q?jXo152xepJmiEab6Kt33f4UIqdtCXDVIcj+qYyUtDigjOtHPznecla4b52C7?=
 =?us-ascii?Q?2SsLWVMhGtfG5ZpgYaZjAtQBbC4y2LL3MioTvkyah0RA1osjgkbMks1mcKXJ?=
 =?us-ascii?Q?dQyP8YVGmMnDXbywX+rF4MclQwZbiq9/kvtN7FVYWmUJMXBfoofjpXI0UyNi?=
 =?us-ascii?Q?q0JD682MVCEbzSs8StRezg2tvAPdUu6S39SvOScIWKU7++W79femxJE7jmrY?=
 =?us-ascii?Q?Jwh7AQ10AGd0ZelfaLXt3tAscdhkdiQ/+g3bYRRY/qIqKBOPf3ezhtwkETCu?=
 =?us-ascii?Q?cxrWEbpoKntnqkfrQHvLUdR/Ox9vg5PYY2+hOd69qBM3zjHR6Q+of99r4ycy?=
 =?us-ascii?Q?LpQTJCwEf0xFYvcCowMwmgN7cRILAOILdIT99NwRA19pu5yeZWHjpZUiimnj?=
 =?us-ascii?Q?myoSFbdBklQHhRZ1ofrL2A9OSJcciDFUl6xv1cTeGoqZWjGPiM14Ige32wsB?=
 =?us-ascii?Q?O4myPB6cFzFB3RFKrjH0ridCTiZ/DqJNOioS7IhjvXS+lPmWsbkdsuesSW/J?=
 =?us-ascii?Q?BNzuKUe1kDUeYs3pgRgr6x+z4U10BFfJOnMLd16t21dDsg4rfmZuBUKNM/9x?=
 =?us-ascii?Q?eg5ApFFIIqNw6KsP5TJzQ8sJrX61Jpg7zyw0WcK7SNMpjkhymYOMe49VUZUL?=
 =?us-ascii?Q?Y+XEvriY++U9U7RgdfqdRzxqZWVN3rx2SbiFsIXK9niCgTJ1+luahG6SW1n/?=
 =?us-ascii?Q?VtljDwMkDFr54D7rpO1DJic1Dva7kLL3ObfVkO+EXZ+qR/2yT/SvJ3SiYLZm?=
 =?us-ascii?Q?ZLOr72SiVEefLlQqz5KhmfvmEPtFUWrg+dHuiVNG8CrY8+ZNM4wkw/fndzJR?=
 =?us-ascii?Q?AP6eK6DefYe2AeKlIQOnUUk9dGyf3wl0c5mDeAfdy3SeckOms9anaBp/n8Wn?=
 =?us-ascii?Q?t6K73zt1MdGOIbRWu3+nLXDkmXN3y3k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: G2ccyzY1oRS1Ogf8lofJoRYhHkPr17uctz8nytvzEQz5ga0mHRxnGQBHirk98M1qWrQJi99R/a8pBTHNpDmbCPFY51MXYF1PgvBFppHfR+vzj8VI2Kt8kVmuuWlVU6AruggsVZ+QLECC7495inR/GXqRCOtAt1tXdmHcluo+Q3R5rawfmqKzTTn7eEpWtCNv8FWOJmvOFoAYnFKggleRZg/pBSFR7CX9BxRH6gmM2dv8AUyzyP/gS1n33NP0fN9iFm6ZBW7cLSKUXJHzdIACsJDQ/1sB3EkKgQJ4JsrnDk1L3AER0DdGzVY/X2ZZBS7s759RryLnbjVHLGlGJQbtkQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed7ed38-ffda-483b-2e1f-08dee89b45f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 09:17:52.3835 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Obil8s/UHYcW2HtYmpxEjbGeGZBkqqcerjIMyV1ikFqFSF89Z+zg3gYW/iUeQuqQtSs2LoRP+WB60IC0lXCZGoXk4+WjKGcBOBDrRSo2Sn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9633
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784798276; x=1816334276;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=n1fWsRTPm4Mhb4cImE4lMNm5/anyrm63/0W7KHyh38I=;
 b=TQ0Wjo+d5iGecfqKAzfMIjEaA7ulefffsPk6BHrBFaulLxJEtukF5zmi
 uIzlTfyxoHd4Dt03rmLjdRYvEpRsdxEcg4QQ8ciFp4K10ifiTRbCxQcRE
 CEC5O2HHMRKXfrejHiNRemqf9jA2+gPAp0OTIn2V0H67v+jwafv1/sVQw
 yHUlr04myUPq0Y0JHaDNquQ0zE9G0oUYnzrbUGb2fdfq+2on3EBJX/gAB
 cZycpt9VweM9ZNhBb3EzoZuAfEMAjW5/AoQJpby7aygkCtkYxYyd3lu9D
 PAgMdX3TF1947v4GoIaYThfnnX/xOGp8icPh2W08xyRVodle0zMgrx1NV
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=TQ0Wjo+d
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH v3 net] idpf: disable PTM on probe
 failure and on remove
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
> Of Myeonghun Pak
> Sent: Monday, July 20, 2026 4:35 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; intel-wired-
> lan@lists.osuosl.org
> Cc: Olech, Milena <milena.olech@intel.com>; Tantilov, Emil S
> <emil.s.tantilov@intel.com>; Mina Almasry <almasrymina@google.com>;
> Andrew Lunn <andrew+netdev@lunn.ch>; David S . Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Myeonghun Pak
> <mhun512@gmail.com>; Ijae Kim <ae878000@gmail.com>
> Subject: [Intel-wired-lan] [PATCH v3 net] idpf: disable PTM on probe
> failure and on remove
>=20
> idpf_probe() enables PCIe Precision Time Measurement with
> pci_enable_ptm(), which takes a reference on the device and on every
> PTM-capable device up the path to the PTM Root.
>=20
> Neither the probe error path nor idpf_remove() drops that reference,
> so the PTM enable counts of this device and of its upstream path stay
> elevated with no bound driver, and the device's PTM control bits
> remain set.  pcim_enable_device() only arranges for
> pci_disable_device() and does not undo the PTM enable.
>=20
> Add the matching pci_disable_ptm() to the common probe unwind and to
> idpf_remove().  pci_enable_ptm() failure is not fatal here, so guard
> both calls with pcie_ptm_enabled(): pci_disable_ptm() decrements
> dev->ptm_enable_cnt unconditionally and then recurses upstream, so
> calling it after a failed enable would drive this device's count
> negative and wrongly decrement parents shared with other endpoints.
>=20
> This issue was identified during our ongoing static-analysis research
> while reviewing kernel code.
>=20
> Fixes: 8d5e12c5921c ("idpf: add initial PTP support")
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
> Changes in v3:
> - Rebased; aa8671af0c38 ("PCI/PTM: Drop pci_enable_ptm() granularity
>   parameter") changed the call signature, so v2 no longer applied.
> - Guard both pci_disable_ptm() calls with pcie_ptm_enabled(), as
>   pci_disable_ptm() is refcounted and recurses upstream since
>   e1092d5e15e6 ("PCI/PTM: Do not enable PTM automatically for Root and
>   Switch Upstream Ports").  Raised by Tony Nguyen.
> - Dropped the v2 claim that pci_disable_ptm() is a no-op when PTM was
> not
>   enabled; that is no longer true.
>=20
> Changes in v2:
> - Disable PTM in the probe error path, as requested by Emil Tantilov.
>=20
>  drivers/net/ethernet/intel/idpf/idpf_main.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c
> b/drivers/net/ethernet/intel/idpf/idpf_main.c
> index ab3c409..97bafeb 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_main.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
> @@ -159,6 +159,8 @@ destroy_wqs:
>  	mutex_destroy(&adapter->queue_lock);
>  	mutex_destroy(&adapter->vc_buf_lock);
>=20
> +	if (pcie_ptm_enabled(pdev))
> +		pci_disable_ptm(pdev);
>  	pci_set_drvdata(pdev, NULL);
>  	kfree(adapter);
>  }
> @@ -266,7 +268,7 @@ static int idpf_probe(struct pci_dev *pdev, const
> struct pci_device_id *ent)
>  	if (err) {
>  		pci_err(pdev, "DMA configuration failed: %pe\n",
> ERR_PTR(err));
>=20
> -		goto err_free;
> +		goto err_disable_ptm;
>  	}
>=20
>  	pci_set_master(pdev);
> @@ -279,7 +281,7 @@ static int idpf_probe(struct pci_dev *pdev, const
> struct pci_device_id *ent)
>  	if (!adapter->init_wq) {
>  		dev_err(dev, "Failed to allocate init workqueue\n");
>  		err =3D -ENOMEM;
> -		goto err_free;
> +		goto err_disable_ptm;
>  	}
>=20
>  	adapter->serv_wq =3D alloc_workqueue("%s-%s-service", @@ -366,6
> +368,9 @@ err_mbx_wq_alloc:
>  	destroy_workqueue(adapter->serv_wq);
>  err_serv_wq_alloc:
>  	destroy_workqueue(adapter->init_wq);
> +err_disable_ptm:
> +	if (pcie_ptm_enabled(pdev))
> +		pci_disable_ptm(pdev);
>  err_free:
>  	kfree(adapter);
>  	return err;
> --
> 2.47.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
