Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E412C5518E
	for <intel-wired-lan@archiver.kernel.org>; Mon,  3 Aug 2026 09:43:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC8E8405C9;
	Mon,  3 Aug 2026 09:43:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B1FG0zin5rHg; Mon,  3 Aug 2026 09:43:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1A1DA4057A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785750218;
	bh=WJNce2c83ivd+3dKJacaxw4Rd7SHUVjLhoai2cBOfa8=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZJBlMn17HqnthmzIxlVwmQeyGrnvnCZ3AW4OU0GUWfmjOXCAG+7Txp17LKOf4+C3K
	 /PSD10usRnCd9LfnV2zerXC2m/1pO5jtGx8oltH1/9gw9SACRPW7gJWmn7ECz9l0Cr
	 5yLzTrZT0sMruNUx1YAkGuYVbyukSJxteeHnTHR84Q17m7xBpdcOZjsftAUjtfz5SV
	 zOasu7kfqkgUJ3Jb9YYntfWtajuDq76xo0T97UC6UXwEC5UVNhg8I/i7DFU4ATUZAw
	 etJyPXBr7IQ5FgsLEwg1C82iddplOyDVv8q2O4s3nS0pA1yWZL0bwUwfzxoeY6cdDT
	 ACfBPVFY++Aiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A1DA4057A;
	Mon,  3 Aug 2026 09:43:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2533F350
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Aug 2026 09:43:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0BA1860648
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Aug 2026 09:43:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cPEnwLIwJw42 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  3 Aug 2026 09:43:36 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CE7D860625
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CE7D860625
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CE7D860625
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Aug 2026 09:43:35 +0000 (UTC)
X-CSE-ConnectionGUID: 4BXQDsGnRwWyVoJ9D0+W5g==
X-CSE-MsgGUID: oISwSNLMQmyDE9B6ujxeFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="97655843"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; d="scan'208";a="97655843"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 02:43:35 -0700
X-CSE-ConnectionGUID: neOQ3JurR/uU8bQilD9wig==
X-CSE-MsgGUID: 3uuPguFwRxe+F+Qa+0oHdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; d="scan'208";a="256849957"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 02:43:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 02:43:34 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 3 Aug 2026 02:43:34 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.19)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 02:43:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHwRx7GmdcqWCuDPC3JAbwiw4CS3088O1a69WNQFa2YxELE8kN7qmCe+kjZOUpQRPudUcNhkbcsW2GkHwpC2FzOWGFWraCGEUeUQ05uz3DideKz4SWD+MJIfPEoFiiq8O9RnqKnaYm5jDAN272kOU/+QtX6vlPLxtFVygT6gvlrAgvQKJTsfme3syHFTw/bE/3s8hAd9QI9ZZBkwTztHXM/Izdn8H/RYZMQIw9hkzJA5lhE1Ax9FDlerndr1eupt35XPmXyj4aJmxEAt0TXirMnQQWrWJfxIDSL2IgTyfyGyCNMRM0LNFPeUCFZLRJVxrAxvBLY8AshgpElw1mEYVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJNce2c83ivd+3dKJacaxw4Rd7SHUVjLhoai2cBOfa8=;
 b=PORL1zsIz0zLJoNPHBlK2gq9yvyjh5IikTdjz71nkGS5Zry+n41Stwv0CHByoZmwiiH7n0eOBEod9PNlkBDRJU2tgHfl75Tgw38C32gPp0cRPRgsC5wWiUtz8d5D+kw9thP/ffkMaaHw2StbtagZcWDCDywNh1+9uBIi3SCz5JnIdG7T+3udgtEqc5yKV6gxUnR3vacW76PXfM4vJGyz96Z/o3NY3Pjl0xhyNt4y4KI9znt8+2c6kBmueLEn9clKh94ZcjhYi9J8814FwuHvCzUF6JndUzBWTBOLRoY3oWe5cUlGlpZoVBFnX2zticbYNCYW0plk3r1eTgeihLO4kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6219.namprd11.prod.outlook.com (2603:10b6:208:3e9::15)
 by SA0PR11MB4574.namprd11.prod.outlook.com (2603:10b6:806:71::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Mon, 3 Aug
 2026 09:43:26 +0000
Received: from IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31]) by IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31%4]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 09:43:25 +0000
From: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>
To: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, "Korba,
 Przemyslaw" <przemyslaw.korba@intel.com>
Thread-Topic: [PATCH v2 iwl-next 2/3] ice: add TSPLL DPLL device and TIME_REF
 pin for E825
Thread-Index: AQHdIOaWfeIpF3RIw0uifaBgnWGBjraMFImg
Date: Mon, 3 Aug 2026 09:43:25 +0000
Message-ID: <IA1PR11MB6219D6278D446431875B4AE092D52@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20260731121216.1841413-1-grzegorz.nitka@intel.com>
 <20260731121216.1841413-3-grzegorz.nitka@intel.com>
In-Reply-To: <20260731121216.1841413-3-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6219:EE_|SA0PR11MB4574:EE_
x-ms-office365-filtering-correlation-id: 160bd766-f7d6-43c6-1ea4-08def143aa75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|10067099003|56012099006|6133799003|11063799006|5023799004|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: WYh3wEqx4KNJyhSreUH3SY0SAey+axwPtOYpMct+c8WhWqn4L4QGuBU4WJacfi7pFJq1R/LJA8zhUIqJsqwlbUeQ2DUEwKprRxKt5rs15QnaqzFlplwdCoSH1i1I1SFRSY9f81R1a/f1RfsG/KIdWI8/9j7PW//HUL9pqtIcf3gBISpYELBXx5FG3/fPenbx/Ux+g3N1mqunoxMQ8agfJKwtw1wo7f+JqQvYjM2QSHwbBtf8eQT87xzHq3ZMTXINDh7ViFdrfOLIPJbrfoc6syEvyaJL7Wgg2iFYZ+Sbz0BGGKNj9bMZG8Mtr7SsFyelvb7P9u2vNz9tBUXhxT6GQ16yG1ULWtJix8bZcN1mhDOxBWh8zaL2YmvfKaEzKKeAXchEAxVkzyXOM/4qSWczPvrQvYyCkIGVqezTfV9xuwB3g5j8ww/8hzIKarfmlcKj4oQ144iQHf1CfpoNNhhhoCPy4Pkz50UN1sa0OeXinj9NUrNA3nZXmSHdrfhHZFv1+zf6rHVLd996EZtKplDAVUf6HZM/8kyv43Hyihh7PNK3T5/6kGktZ4/oE7RFm7X4mh2fBC/34pme93Zu6qSes6suRB8UyaBPjeeoasYb0q/yC6Bn5Pqni9GB28Hp5cElM9t0Ly+KKOe9V6rro1HHH0P68ZI9soVBNF0UE3s63DywJB3w8Do4K731z2+lvhWRIQhYv8PGhWeVpOyakN0LGepa+b4/iMUHZ2WH3I+i1UE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6219.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(10067099003)(56012099006)(6133799003)(11063799006)(5023799004)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MfM22NyeGg3+sDuhmiVVVfsPtpn6UeHqyqBzrbV3DGj8We1iJxn929Uxu6Oq?=
 =?us-ascii?Q?LMav64S6QFJY8XVotybJns0+dZqC2D2vhZIXuc/z2A/uGG78lLjONhnrgTFl?=
 =?us-ascii?Q?Z2ivWhH3r5O7eGuH272h47esU18px6ZXuAsroNS9tjfyIprf3FPzgxsMbYRT?=
 =?us-ascii?Q?9cqGwtHk0F/X98gTizUYzajiQuhJ5p3U1ZU+1oR5UXNsIUiMZOTwzC+vMZtF?=
 =?us-ascii?Q?xFT0rbde1OrT6JmIgOLnX+wzjMoIqkGxgIDT8Hu0ehH1fbdttFarSMeXnvmk?=
 =?us-ascii?Q?OivGwOPreHJPb5NBGH/3VyglWLjNZADN5Rg+xOipna8PTCzkzkbnWM9NnXYR?=
 =?us-ascii?Q?d5GbslDkLRDpOqqJB81Q8nT6Tczk7hlDZPu1KfbkIonxkqXBS88cGcrlL+JL?=
 =?us-ascii?Q?BnDrIWZnDjhfvusZSGIJsRz4a1Bwv3JlB+if752FVrr1yLBKluOBsGetDUXL?=
 =?us-ascii?Q?RwaSo3ilciXf9fy6k9F6TlvfNkkEpy+eE8el1snuhnSqLlqIzN4TwKg74gUg?=
 =?us-ascii?Q?wnif8twO70S94tL4pi2/7mH2rDVBVsARua45pfNdekGFY7qAnEiPRhFvKLah?=
 =?us-ascii?Q?0LxygX8PsSH7Qz+SCUo8jomCuV9QvA1jtobApfKT6atFT7WUYq/zeI62t55v?=
 =?us-ascii?Q?r54aTf3lL1tqYBIbX0Chw/ct58jjX/QQdXd4wEkY3MSlgrDvpejGXRuclCr1?=
 =?us-ascii?Q?QhAely10InlvYWii62u9SJNlyUFLZH15VdTL9KUdbI+Gv6BRoVWbKwpzq4S1?=
 =?us-ascii?Q?O3RtREekyYY9TdJZ4GmCUaksJ3tRiMiIV1H0rw4yYe8UROsRSx7Dsn6dzVjw?=
 =?us-ascii?Q?XfIxQlaO1z3hnUzRPITbSP8gptKiL+dDDuAKJDh46YH9kXAR3emq3ruiGkrY?=
 =?us-ascii?Q?JLrKA5r1YJRPKstWqSEK1xtcjZ/O/UleCH9wrezavFux5lUoPXOBI5HAcOB4?=
 =?us-ascii?Q?xi58+P2Z73iklVhGES1TVehSj0oTYbhb6BnEtArSsRxL5hgg+tFXRpMMxJuu?=
 =?us-ascii?Q?TSHpkGsBbSdzpP3kw+2BK+tyk7XQ6QOlLu8/8BosDDQ/rQmgcWx+sAV36SrT?=
 =?us-ascii?Q?DV4Y6oMrgxmvUWZx36Ox6ohZfj1fuWSLerBj3CnzcqSgppQbXv7LeLx3oXOA?=
 =?us-ascii?Q?MyCAB2VEXEHwGCh/8sKGV1VP6zPnEXX0ETvJOC/tNl3oKtUOOoY93on+82Hi?=
 =?us-ascii?Q?z2sXG5x/FitbVFJQjo02oZSqBQ6eLYI9TiY4u5QzUhqe/urbUXqntSOiQ+jw?=
 =?us-ascii?Q?ZLZCwmNtkdjTiO6HIPSXqaF78gzFKUQ4YjgMtDM74+Z081/lOhma58qVUj9Q?=
 =?us-ascii?Q?2znRQd9qMQqJAtxZ7eShgpnRqO3nl22YfBLQUvRE//M2pNM70VBbXteFBtE9?=
 =?us-ascii?Q?7D/6QuOZ70b37wsFwIiGKIfwwjPxZOcaq4ML5MceW2nHN9/s6oqVxxAfRuli?=
 =?us-ascii?Q?O6A7abUYNA0k7H6+ITSbFrHK0TMDz5oErF3L64bpTj+Qt0z08orKNRBRQN4H?=
 =?us-ascii?Q?S6eaakrSWmI3e3O+3hj2WO+WkhJKzFYJTWmlBlZ/f1zGnWQwxzaPiiTmqW2v?=
 =?us-ascii?Q?d7YyAYJu6Ru0hhONtgp3edt2rJv6ZEESBCvVWMwcHJNuNhFS9vnMpoWrpXIZ?=
 =?us-ascii?Q?frlUQCdyv0h4fBdOUf7KFBWEWmW2OxZr5V+/yavKBGJkd8wOGQ2CaywNiYql?=
 =?us-ascii?Q?2yM7HU9aaqBaze+Ux0Sd8X+c+n8UloucKAxGatgOmODu9tqJgLtjrchQMKKT?=
 =?us-ascii?Q?cKG/8+Niuw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ofHoEkHj/yrDofiM4732+pkDXfdOGuS9OQC4pOocV1/xqbgyYeD/e8q139LLEq2lR7PBj5GJQHPuS74NfVsjybQJ3rr8iIPoitxdhgdjVEWQobGgcD1ZUdugGYt2I1v7tsL/XIVGVEcOGh6xwSSmLlHN9qXkgV8fNwYox4ZRI35HaIoghqVIX/CJjfs/5GmWc6BfYbVi+7BUkClBtMlORtD7nfB56gVV6GmuG+mBxmT8+mXe+H4gW0Te1soB2LqfIEenMVRsw1SQFgAcJNnt+JRwQvvzZTBRUdcF8mDnMCjMBt7b/WCtJ/bTScHaZrUvtx9Wcl8kNCAVWlje5nT70g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6219.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 160bd766-f7d6-43c6-1ea4-08def143aa75
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2026 09:43:25.7942 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0OfLbG2KVgbnrMsahuO73dNoteDKvzcj2YBrAn+SrbnmeM7wcPoWHLV/EVj1dflzu2I8jT+fY7ohXnIGhQpGWd4YXvZAppBZ1Ao7YGEEyxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4574
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785750216; x=1817286216;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RNR7XesRPR/WJVWkPIVVdfKkqeFuEkNxo6jXgqPn+eA=;
 b=mtFbUGPs2LXu8jjlwDSgCqbT9AeVuqtNK1Q1+IBseU6gOcpcYmCSqKfW
 Zzttv4lHDXcOgMrgbBjTA5okVX6+XL+GQWOtyJESlhhe7BwFqZTbqhZeM
 Pd1nnhPZ1wn1Sd2C6NptkasTKG3TT0F+oAm1GmZ0fRbhjWz9ysYzUd6w4
 XmIr88N08th0N/uLVhdXgPscx9fk2lzq1ferayFfNI+iHrlI3rPu9BICZ
 Uvftizd1WwmidLNg/m2XbyJd4T4dvtwcrYzSLSzHa6kYhkqr0i7UAFc9e
 xfEuQcBxz8RU8RtHFJBUZOgfl9rsQU1czRodPKMPtJwveXhLJXIeRDd6M
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=mtFbUGPs
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH v2 iwl-next 2/3] ice: add TSPLL DPLL
 device and TIME_REF pin for E825
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
> From: Nitka, Grzegorz <grzegorz.nitka@intel.com>
> Sent: Friday, July 31, 2026 2:12 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> richardcochran@gmail.com; andrew+netdev@lunn.ch; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>; pabeni@redhat.com; kuba@kernel.org;
> davem@davemloft.net; edumazet@google.com; Nitka, Grzegorz
> <grzegorz.nitka@intel.com>; Korba, Przemyslaw
> <przemyslaw.korba@intel.com>
> Subject: [PATCH v2 iwl-next 2/3] ice: add TSPLL DPLL device and TIME_REF =
pin
> for E825
>=20
> This extends the E825 advanced sync-timing support introduced by the
> tx-clk series, which added the TXC DPLL device for TX reference clock
> control. The TSPLL, the source timer PLL, is now also exposed through
> the dpll subsystem so that its lock status and clock source selection
> are visible and controllable from userspace.
>=20
> On E825 devices the TSPLL is the source timer PLL, distinct from the
> EEC and PPS DPLLs used on E810. Register it as a DPLL_TYPE_GENERIC
> device for owner PFs.
>=20
> Add struct ice_dplls::tspll_in, a fwnode-backed input pin named
> "time_ref". The state_on_dpll_get callback queries ICE_CGU_R23 via
> ice_tspll_get_clk_src() and returns CONNECTED when TIME_REF is
> selected as clock source, DISCONNECTED otherwise. The state_on_dpll_set
> callback switches the source between TIME_REF and TCXO via the new
> ice_tspll_set_cfg() helper. Registration is deferred via the dpll
> notifier path if the pin is not yet visible in the subsystem at probe
> time.
>=20
> Initialize TSPLL DPLL state from direct clock-source/lock reads so the
> first published state reflects hardware and prev_dpll_state matches.
> During periodic polling, the DPLL worker consumes
> READ_ONCE(pf->ptp.tspll_locked), maintained and recovered by the PTP
> periodic worker. When the TSPLL clock source is TCXO (TIME_REF pin not
> selected), UNLOCKED is reported unconditionally to reflect the
> free-running state of the oscillator regardless of the raw lock bit.
> To avoid stale lock-status reads after synchronous source changes, the
> set callback now refreshes tspll.dpll_state immediately and emits a DPLL
> change notification when the cached state changed.
>=20
> If a TSPLL reconfiguration is applied but the PLL has not yet
> re-acquired lock, treat the internal -EAGAIN result as success so the
> PTP periodic worker can complete recovery, while real -EBUSY failures
> from reset/SBQ paths still propagate to userspace.
>=20
> The TSPLL userspace reconfiguration path (state_on_dpll_set) and the
> PTP periodic worker's TSPLL restart on lost lock both access CGU
> registers, so serialize them with pf->dplls.lock. The mutex lifetime
> is lifted to PF-features scope (initialized in ice_init_features()
> before ice_ptp_init(), destroyed in ice_deinit_features() after
> ice_ptp_release()) so the PTP monitor can take it unconditionally
> regardless of DPLL init state.
>=20
> Extend ice_dpll_deinit_txclk_pins() with a "flush" parameter so the
> E825 init error path for the TSPLL fwnode pin can tear down TXCLK
> pins without flushing pf->dplls.wq. If the flush ran here, notifier
> work items queued during earlier init steps would be blocked on
> pf->dplls.dpll_init, which is only completed at the unregister_pins
> label reached after this teardown. destroy_workqueue() at that label
> drains the queued items safely. Existing full-teardown callers pass
> flush=3Dtrue and keep current behavior.
>=20
> Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c  | 416 ++++++++++++++++++---
>  drivers/net/ethernet/intel/ice/ice_dpll.h  |   4 +
>  drivers/net/ethernet/intel/ice/ice_main.c  |   9 +
>  drivers/net/ethernet/intel/ice/ice_ptp.c   |   9 +
>  drivers/net/ethernet/intel/ice/ice_tspll.c |  34 +-
>  drivers/net/ethernet/intel/ice/ice_tspll.h |   2 +
>  6 files changed, 419 insertions(+), 55 deletions(-)
>=20

Sashiko says:
> @@ -2891,6 +3000,43 @@ static int
> +ice_dpll_tspll_state_on_dpll_set(const struct dpll_pin *pin, void *pin_p=
riv,
> +				 const struct dpll_device *dpll,
> +				 void *dpll_priv, enum dpll_pin_state state,
> +				 struct netlink_ext_ack *extack)
> +{
[ ... ]
> +	/* Serialize multi-register TSPLL reconfiguration with restart path. */
> +	mutex_lock(&pf->dplls.lock);
> +	ret =3D ice_tspll_set_cfg(&pf->hw, ICE_TSPLL_FREQ_156_250, clk_src);
> +	if (!ret || ret =3D=3D -EAGAIN) {
> +		enum dpll_lock_status new_state;
> +
> +		/* Reconfiguration can transiently drop lock; clear cached lock
> +		 * before PTP monitor refresh to avoid spurious LOCKED reports.
> +		 */
> +		WRITE_ONCE(pf->ptp.tspll_locked, false);
Will unconditionally invalidating the cached state cause spurious flapping =
if
the lock is successfully acquired synchronously?
If ice_tspll_set_cfg() returns 0, the lock has been acquired and new_state
will be DPLL_LOCK_STATUS_LOCKED. However, we still set tspll_locked to fals=
e.
When ice_dpll_periodic_work_e825() runs next, it will read this false value
and report the state as unlocked to userspace, until the PTP monitor runs a=
nd
corrects it.
> +
> +		new_state =3D ice_dpll_tspll_lock_status_get(pf, false);
> +		if (tp->prev_dpll_state !=3D new_state) {
> +			tp->dpll_state =3D new_state;
> +			tp->prev_dpll_state =3D new_state;
> +			changed =3D true;
> +		}
> +	}
> +	mutex_unlock(&pf->dplls.lock);

It's a valid concern. To be fixed in v3.

Sashiko says:
> @@ -4093,8 +4367,25 @@ static int ice_dpll_init_pins_e825(struct ice_pf *=
pf)
>  		goto unregister_pins;
> =20
>  	ret =3D ice_dpll_init_txclk_pins(pf, 0);
> -	if (ret)
> +	if (ret) {
>  		ice_dpll_deinit_rclk_pin(pf);
> +		goto unregister_pins;
> +	}
> +
> +	if (ice_pf_src_tmr_owned(pf) &&
> +	    test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags)) {
> +		ret =3D ice_dpll_init_tspll_pins(pf);
> +		if (ret) {
> +			/*
> +			 * Avoid flushing pf->dplls.wq here: notifier work
> +			 * items block on pf->dplls.dpll_init which is
> +			 * completed by the unregister_pins path below.
> +			 * destroy_workqueue() there drains queued items.
> +			 */
This is a pre-existing issue, but does this error path lead to a deadlock
during driver initialization?
The comment here mentions that notifier work items are blocked on
pf->dplls.dpll_init, and expects the completion to happen in the
unregister_pins path before destroy_workqueue() is called.
However, if an error occurs and we jump to unregister_pins, we call
ice_dpll_deinit_fwnode_pins(), which calls destroy_workqueue(pf->dplls.wq).
Because complete_all(&pf->dplls.dpll_init) is never called on this error
path, destroy_workqueue() will wait forever for the blocked workers to
finish.
> +			ice_dpll_deinit_txclk_pins(pf, false);
> +			ice_dpll_deinit_rclk_pin(pf);
> +		}
> +	}

This isn't a deadlock - complete_all(&pf->dplls.dpll_init) is called at
the unregister_pins: label immediately before ice_dpll_deinit_fwnode_pins()=
,
which is what wakes the blocked notifier workers so destroy_workqueue()
(invoked at the tail of ice_dpll_deinit_fwnode_pins()) can drain them.

The flush=3Dfalse argument to ice_dpll_deinit_txclk_pins() is precisely to =
avoid
flushing before the completion is signalled; deferring the flush to the sha=
red
flush_workqueue() inside ice_dpll_deinit_fwnode_pins() - which runs after
complete_all() - drains all queued notifier work safely.

Sashiko says:
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -2917,7 +2917,16 @@ static void ice_ptp_tspll_monitor(struct ice_pf *p=
f)
>  		if (!(pf->ptp.tspll_lock_retries % ICE_TSPLL_LOG_INTERVAL))
>  			dev_warn(ice_pf_to_dev(pf),
>  				 "TimeSync PLL lock lost. Retrying to acquire lock.\n");
> +		/* Serialize R23 restart against TSPLL userspace reconfig
> +		 * (ice_dpll_tspll_state_on_dpll_set()). pf->dplls.lock is
> +		 * initialized in ice_init_features() before the PTP kworker
> +		 * starts and destroyed in ice_deinit_features() only after
> +		 * ice_ptp_release() has drained the kworker, so it is always
> +		 * valid to take here regardless of DPLL init state.
> +		 */
> +		mutex_lock(&pf->dplls.lock);
Is there a race condition here between the PTP monitor and the DPLL set
callback?
Looking at ice_ptp_tspll_monitor(), the hardware lock status is checked
without holding pf->dplls.lock:
	err =3D ice_tspll_lost_lock_e825c(&pf->hw, &lock_lost);
If this thread is preempted after reading a false (no loss of lock) status,
and userspace concurrently requests a DPLL state change via
ice_dpll_tspll_state_on_dpll_set(), the DPLL callback writes false to
pf->ptp.tspll_locked while holding the lock.
Once the DPLL callback finishes, if this thread resumes in the else branch,
it will unconditionally write true to pf->ptp.tspll_locked:
	} else {
		...
		WRITE_ONCE(pf->ptp.tspll_locked, true);
	}
Could this overwrite the accurately-set unlocked state and cause the
periodic worker to report a spurious locked state to userspace?
>  		err =3D ice_tspll_restart_e825c(&pf->hw);
> +		mutex_unlock(&pf->dplls.lock);
>  		if (err)
>  			dev_err_ratelimited(ice_pf_to_dev(pf),
>  					    "Failed to restart TimeSync PLL (err: %d).\n",

It's a valid concern. To be fixed in v3.
> --
> 2.39.3

