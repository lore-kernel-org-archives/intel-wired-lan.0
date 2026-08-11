Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D6FC5B56A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 11 Aug 2026 14:53:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF70160824;
	Tue, 11 Aug 2026 14:53:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XwiNHgzMBgWv; Tue, 11 Aug 2026 14:53:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C9DE460807
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786460008;
	bh=5IXFa/urY0aZ5FRXNKSPrDyW6aDu/FgsQ1rVN2utnxY=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QhSbZBwHVp6TKiWxpm2R0uff51wvYcKNdjYC+QkRy5XkSY9Hd4n7PmhwQ8g81SYuN
	 fcQl9dcxhmCys+yHn4WB5ttY/N5xCXZosgMf8k8mdVcuxRCEbfhU8k+j0nhYiDSV2/
	 UyQiaTqLkA65Ynsq06rZ32uWFBP4m/SIz5DfJoElsBZQOmiOSKPZDviUjbhtGIsfoh
	 7EFCok0idJgX9yKOswB2jDnVrW+r9xv9z5GiyfT8prc/bl4mg5xu3xO46HyOiUb5fF
	 hFzkfEjUKGKdQS9vvIpXqOkoMrQ9Lxa7b/JFrMCjM39wlS+FhbcSgGgyicefVQWthj
	 nfJm3EPmSayoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9DE460807;
	Tue, 11 Aug 2026 14:53:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E508345
 for <intel-wired-lan@lists.osuosl.org>; Tue, 11 Aug 2026 14:53:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 50783401F3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 11 Aug 2026 14:53:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XkQJw4AzmRAY for <intel-wired-lan@lists.osuosl.org>;
 Tue, 11 Aug 2026 14:53:26 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=sx.rinitha@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7DF87401E3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7DF87401E3
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7DF87401E3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 11 Aug 2026 14:53:26 +0000 (UTC)
X-CSE-ConnectionGUID: u0D4DwztQ7KmOGK79WdSew==
X-CSE-MsgGUID: 65wuvZDuSw66XWtrEz12hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="90674902"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; d="scan'208";a="90674902"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 07:53:26 -0700
X-CSE-ConnectionGUID: D8aebQScTe2BnrGpJR77gg==
X-CSE-MsgGUID: F/G6fSbSSoKl3CtwvP85ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; d="scan'208";a="259094716"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 07:53:25 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 07:53:24 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 07:53:24 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.44) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 07:53:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/+xdlhN5xc4tmlyTitzgCzTaV2wLI/g5Kyt8EH1xj0irWqTbLAdK5PqasDxQGSpm7pDkTN6mCGi3GGoJYzz0Pz7jIxl89iRYim42IYBHPMTVy8inar9kzX52lgCOeXgtvzsv9J/yXamAqeMNubmr1+ySpks+kehi43wONYVLFWZTLvs9f54V+C7xVR0G6pMUB60PTko8/4CpiHBCDhEMK+tTPP4G4Pw5+PgcTUA3kvFXBvUQTpYe2KbIQN1b42/LWBOOC24NaH7pIHsn9pOB+opdxsWv6duAHqa2/HbR1h8I6rI2jpm22wMTib47fPTAZgHP6NtbB+ACWYu+03+QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IXFa/urY0aZ5FRXNKSPrDyW6aDu/FgsQ1rVN2utnxY=;
 b=k5xf6oKrGowscv7RD79bz7a4w7SnV3z+YWHRW7AEYB8foqovUcovlVqzTx4d+AVY2FLnp26gdJ/+mHwXt9tPWCursKhxm41NBt9ZsIOLTwTx7CslvrFTAzqx0w8kku30G1J82UskpMNyinwdgAkJbTcWhhcj6OZMm4Uzdup67SDCot1BAO9tG8OmLdYA6B6dNqqCRH3KHS+68QcewJSwGLXWv4COqyxLi0u+VV5NelSXbbCRgMInYrnV62OBoLyjcChNq9/wiSnYPeMG1Jtzeb1N3vADpK4W26TfdSAKchn7SrUZn/PdmxaZEtOaMa0Yxf/Ic3pgGAAVD2khN5L9eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by SA1PR11MB9850.namprd11.prod.outlook.com (2603:10b6:806:4d9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 14:53:16 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 14:53:16 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Robert Malz <robert.malz@canonical.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, Jesse Brandeburg
 <jbrandeb@kernel.org>, "Keller, Jacob E" <jacob.e.keller@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [Intel-wired-lan] [PATCH iwl v4] ice: acquire NVM lock around
 each flash read
Thread-Index: AQHdI+xHcH7Lw1kru0atCBR4gUQX17aYrobA
Date: Tue, 11 Aug 2026 14:53:16 +0000
Message-ID: <IA1PR11MB6241D87773ECFAE333D5EB408BDD2@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260804083537.3997889-1-robert.malz@canonical.com>
In-Reply-To: <20260804083537.3997889-1-robert.malz@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|SA1PR11MB9850:EE_
x-ms-office365-filtering-correlation-id: 6d91db96-addb-443d-19fc-08def7b846de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|23010399003|1800799024|18002099003|22082099003|921020|11063799006|10067099003|56012099006|38070700021|3023799007;
x-microsoft-antispam-message-info: vJcSuSK5QrPtjEnTgAJKcVmIKedIP/4dJaVJ/pS3aZ9l4uQfn7aLSgDL3HNsOpwJryOGIxDbVukRBJFKO4daDuZUeKWic2OUDTeGEm2UwXUlMjPRV3+njSeHUyzZXuuOYlO650vlhceBFQDMYroc+NdSZFc7E3CW+UGoe+QYXhBFOvzNP9vGGARuBj0LT2/Q92Ji6GR131Qa08BaZizFf7++qsaKg0FPrLu9ubXqGmdScohxflB6ZAne8E2FjbNAsMTQCyfNNfGephgtiKZsV7g+is1Gn9enPx9CLdh5X0PgOgQwTa+LvT0pRHVOykokD1qzzY52DYhcrLLdB17ZbkcrYEgZw7UIemo/rZWn3UHSr2anXMSejHqcWg4xqejgwuxGCzWeVgK+bzr5RBmds3+ViACybmcoXKvmwouQtZ1K3T69zEJodwEt+rktXYNYoGNZ018/le0bw4UCq08hLTHemjVfsLQHBRZoaPgBWKOTrbcY/q5yKu9rR2SyBtQk7ZRd7Uz0Pg6sVIz/yi84x3ctmPGCa3/wHRjbQUdZdj9alUZZitzbJgrfDCdpiVqIiloNcRTH8+rlT9nCsf/1GE9iS8Q0vGLx3Q+7XpsS8IASDIw0KPx+isCtUJWy9vWHjCGvxAk0ee9eAqNMarOv/22lBfcj1x17TRn7vNFCgJecDnKa/ejKSMBP/gV9HV6QjlDh8DicK6OWCFBe/US7/sLbCAL+fzqQxlaXmVv5Ewk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6241.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(18002099003)(22082099003)(921020)(11063799006)(10067099003)(56012099006)(38070700021)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M8ALVmw++4uXEddHrVjo/LDDERMqHfrY3ja3ajlLDwjMlHkCd0RgavjD1Z+l?=
 =?us-ascii?Q?53Rcc2Iv0PBFXdnqu/UzIy+NgWTiKOSp0O+9VMYt15aPWRjM4ZcB3uO2/hPI?=
 =?us-ascii?Q?D0hjUiOna5wZgLoFkXOcT+1YGu7t0GBBc6nHMkEb1jwpWRJC0drTsTwHdKyA?=
 =?us-ascii?Q?GyhyIyLumNmiQIW/VPmxLWPa4b3uvtKYQZfgcQ/YFWGa9jG8YXZlk2TUKrKP?=
 =?us-ascii?Q?nQ+3LzSNd+KMUcU7IxFKWsDcv+FvhM6Ye6QN9SubtwcW0ykDTt7hR8cpuUX+?=
 =?us-ascii?Q?HqhhihZ5VYugjbNYxugXfHzq6Gzr4wBZF0cuPYVEWlJpSLZUbrCu5x9dclm/?=
 =?us-ascii?Q?LnUfrVGUsz9b2k/VBKoe61134TW74+S5eTudqUwb1TcLVv2FVvd2f07HnJOS?=
 =?us-ascii?Q?27LLmfUUhrRCchbkO8w3j/QiCjqkr6/kL+H24yi5bHzG1tBEmhUvB2JGtDHP?=
 =?us-ascii?Q?/aSIrBlWq/39MdRo5IxXS95o+4N81R8EWKHAik/Trgk7wUdRPhV2uG6u2J72?=
 =?us-ascii?Q?tcM5AAnmxiN3pTl4xMMmHMJQ6igrrCCj79o2Gh/RtkP6UiCxlXnjsphYykMy?=
 =?us-ascii?Q?upt7acY3KNk8xtnNV7Sk15DQev9qKnjEZrVDg3ZuN5DdveFDrtjAK6AFIP4b?=
 =?us-ascii?Q?+XWl0zBaylGj5sMkfKZDiDY69npQCZTukJLUiC4ABB10L5w2k0iLqYbXW094?=
 =?us-ascii?Q?jNEIJ+J/BIvlQNK2ya37hS+r7Y7vTsEuYOI9f4Mbd7ShT2BQ+kwXsUGBsn0m?=
 =?us-ascii?Q?HtY0/Ra8VYKRYekkR2hF4ahuefEfs+6c+BGrUZ0ahdqqT1pPAswGSgUTr0Vt?=
 =?us-ascii?Q?wUi0vmTUkS+RBf53Flq4fiD+yoXmkALs97iLweYiV77iE+KkWHJWdSAkIlpx?=
 =?us-ascii?Q?41dyIBMzMXGgbU8h/dUdKbK8hrGKwf9KssXmx66qqFj0ehxioK5OFwSoKwJt?=
 =?us-ascii?Q?YTztDksxFaE4vpQ2f5PU+qyMk4kqZ9b5LznftjgtHJsB3OmTXwNYrxXO3nuw?=
 =?us-ascii?Q?gh1HpaTyUACmqBzuGzuvLURBhjbHGIcea+3j7tTH7YHeYX9AjffZzQM8BXP8?=
 =?us-ascii?Q?XF3CGo7S0/M6yM/4yuXDNhNL68WhI+WsdhI3ik8K0n8a0cePDKJ5KYWmP8EG?=
 =?us-ascii?Q?q3JwOhe8Izh/d4SEp4g2B6p5mrCNuH3ac5g5FwEJykxA3v5aOUh7yJmybhnK?=
 =?us-ascii?Q?SKWra9/NYdz8naBpmSfLr9M8ekESp4C/egKLImbvY8oj2jyennzRyEnxdybP?=
 =?us-ascii?Q?/FUOvnh9cVi5QSHLN03W4zUIOehZwXpFQtH2PY/3FC1rsBjLiobKB5Gc+KUM?=
 =?us-ascii?Q?r4AAgSy+UDC1mef+Ua7by/LGrABvwfsGvRAANY5zS9XzAF2zFWbWxpt7oX17?=
 =?us-ascii?Q?gcuv1+ht80uaqE9oVmjxeTzTkHAK3mRkOqQZRW9txHJ7iyRIxUPcNFnKLuLR?=
 =?us-ascii?Q?4Teh6q8ZlAiUZ5bDDOpFo6Mr1Wx6RxBianFf193VUkI9pBZYBTvD16umETIk?=
 =?us-ascii?Q?hxvRw4j7ZxPs2/e7DVrOkjkg6kuMOwomwAnj/YwNmBM8Z1L6g8Fvhw1ND/1k?=
 =?us-ascii?Q?esCG04lPTBS3VyB9r43UETNDbdiyEVzFX0lAFDXEwJIzOQkhKrRQBD8BMcdL?=
 =?us-ascii?Q?GeQnqxxeF0hHPjDrGoV/zEs6UzQQYknBVv0fo+WBTZw/GnCHTgLuDNlzsZYi?=
 =?us-ascii?Q?XBvxWuXzh0wV+UsoASE2Xa5ERDUNH5braAhAQwWxQ6pF4AS8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: W0kx6D3Ru3EexATbEk49JOyjnPKSylFvltPC2YCQTI9IaeXse6WPpgZYaEw5F57DIhrIFUuB4b9NEoq71mFwEUGxvitJezi6sNUcvyGkod8ERJXE3oGRrPwqNl36qZ06WiPZ62VY+eiLg+BOHIXM6SFQdOHAfP0V8dsu8hiYOixdKXmlvBSQwsCMAC8Bi0NO8mj5JkNmLKLmvXwtlFUIrFu6UXb0a14dGzTeXY14a37yA9c83XNCsOGlDrDaVrhAukHpnokj7kj7UiH7H7uISKGS9+nNGokDlLAhz8+pnPRvgp1Imu+cTIA2i0RHQUbtXLnzgfHJNlJrZe4jKWosOg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d91db96-addb-443d-19fc-08def7b846de
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 14:53:16.6953 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qnPSEXGyXbk4AIJ0pttRxG454XdDpHuEHzCmmIMDVy3YVjDGw8cthXQElbIns4TKEPiA5gJN0gGKk+Z/xW1ONg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9850
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786460007; x=1817996007;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CFSrIvMsTUwga/fSaAClgcBHy4jkOggLkbByUQvcUYI=;
 b=R+G/ncQwlUTWx95KcTJbIsb4E5GOdbIw/z7j83hgI4VXRmAjULeUS0Wb
 WuC0jZOoBkFBMgn4VxxY0nasVr2BcftIbbN0eh1s5Gog4uReBAGIFndB/
 aVyiFbsZz5TW3Xls1CMdDBA1MSFnS4CyWARnGJ7RjZR2l6IzBDJ85nZUi
 I159ZVUkH3po5xgMipuxF8tTOk/JRgmEAjWJdSEuE2dL+cDF+luYHpV76
 sn1XNOuNRibzznsmVIsaO50boyUy38NZkCbjbAcNbZfxBk89uikBJFjiW
 hidarokkOTRtiNvcbejaTycIcRBy/oRUD9ED05xrAK00sn4ILPFgX+Jkj
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=R+G/ncQw
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl v4] ice: acquire NVM lock around
 each flash read
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of R=
obert Malz via Intel-wired-lan
> Sent: 04 August 2026 14:06
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S=
. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub K=
icinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Lobakin, Aleksa=
nder <aleksander.lobakin@intel.com>; Jesse Brandeburg <jbrandeb@kernel.org>=
; Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: Robert Malz <robert.malz@canonical.com>; intel-wired-lan@lists.osuosl=
.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl v4] ice: acquire NVM lock around ea=
ch flash read
>
> FW caps the NVM read lock at a maximum of 3000ms regardless of the timeou=
t requested via ice_acquire_nvm(). ice_read_flat_nvm() splits a read into m=
ultiple ice_aq_read_nvm() commands, one per 4KB sector, all issued under a =
single lock taken by the caller. Reading a large region can exceed 3000ms, =
so FW reclaims the lock mid-read and the remaining commands might fail.
>
> Move the lock acquire/release into ice_read_flat_nvm() so it brackets eac=
h individual ice_aq_read_nvm() command, ensuring the lock is never held acr=
oss more than one FW read.
>
> ice_release_nvm() issues its own AQ command and overwrites
> hw->adminq.sq_last_status, which some callers inspect after a failed read=
.
> Add an optional read_aq_err output parameter to ice_read_flat_nvm() to ca=
pture the failing read's AQ error before the release; callers that need it =
(ice_discover_flash_size() and the ethtool/devlink log paths) use it instea=
d of sq_last_status, others pass NULL.
>
> Callers that previously took the lock around ice_read_flat_nvm(),
> ice_read_sr_word() or ice_read_flash_module() now call them without it.
> The now-redundant per-block locking in ice_devlink_nvm_snapshot() is drop=
ped. ice_read_sr_word() is now a thin wrapper, so ice_read_sr_word_aq() is =
folded into it.
>
> Fixes: e94509906d6b ("ice: create function to read a section of the NVM a=
nd Shadow RAM")
> Signed-off-by: Robert Malz <robert.malz@canonical.com>
> ---
> v4:
> - Fold ice_read_sr_word_aq() into ice_read_sr_word() now that the latter =
is
>   only a wrapper.
> - Reduce the scope of read_aq_err in ice_devlink_nvm_snapshot() to the re=
ad
>   loop.
> - Fix reverse christmas tree ordering of the added read_aq_err declaratio=
ns.
> v3:
> - Log the failure via ice_debug() when ice_acquire_nvm() fails inside
>   ice_read_flat_nvm(), rather than silently aborting the read.
> v2:
> - Replace the save/restore of sq_last_status across ice_release_nvm(),
>   which could race with a concurrent AdminQ command, with a new optional
>   read_aq_err output parameter.
> - Add missing "Return:" kdoc to ice_read_sr_word().
> ---
> .../net/ethernet/intel/ice/devlink/devlink.c  | 32 ++-----  drivers/net/e=
thernet/intel/ice/ice_ethtool.c  | 16 +---
> drivers/net/ethernet/intel/ice/ice_nvm.c      | 90 ++++++++++---------
> drivers/net/ethernet/intel/ice/ice_nvm.h      |  2 +-
> 4 files changed, 58 insertions(+), 82 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
