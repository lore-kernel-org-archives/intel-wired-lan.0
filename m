Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F94C54FDF
	for <intel-wired-lan@archiver.kernel.org>; Thu, 30 Jul 2026 07:10:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA8EB6073C;
	Thu, 30 Jul 2026 07:10:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jp2mbxBplT1D; Thu, 30 Jul 2026 07:10:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D98126078B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785395405;
	bh=1AMamnrWsUdPLi1/ajDW8bLzIyHdC5Hh/PruZRlbCLU=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jSeg5jc+1eJLvGY1Oo7Ed5ZAahLbI9VLQBj0lldr59GYuVdYFfxsx9OHasl3GDpHi
	 LPjJWqHuxQubchN8vcG0mSuGFnx57MYVWG2jxPu2gC9B9xMbhtC2/xAlvYn5Sa1ASI
	 1AtltNJiz0JJmYoeYIiwO4mgtzFNjNNj5nKxN6sqgOlkj4KRFMxLD9kkSfmY0/O1/I
	 hFXFU7dGQmMUQcjjr7FlhkuDBEtCFlHGh7ZF1G6LSkGlGanhgFMTkkWSUzxds8g/m6
	 hnHKxFlmD30Mbk11mrckfE60rGMu4lfAACqilTfpiWo9llWLNdL7H7AITdb/7CrQoR
	 u0KBOxByfTj6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D98126078B;
	Thu, 30 Jul 2026 07:10:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 29865194
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 07:10:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1BB1640768
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 07:10:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fj9SY5vbzg9M for <intel-wired-lan@lists.osuosl.org>;
 Thu, 30 Jul 2026 07:10:04 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=rafal.romanowski@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CD3D3407EC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CD3D3407EC
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CD3D3407EC
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 07:10:03 +0000 (UTC)
X-CSE-ConnectionGUID: WuShH5VzRpCuwglY9cR2IA==
X-CSE-MsgGUID: ly1DtvRnRuewJ3TU7UYo/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86085722"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="86085722"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 00:10:02 -0700
X-CSE-ConnectionGUID: /ITkwJ3pTaiYwacmbsKFJg==
X-CSE-MsgGUID: v4lZAGgBT9urRcjZzWvHNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="265279382"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 00:09:58 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 00:09:58 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 00:09:58 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.5) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 00:09:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0B3lgDqUAdAAvnbfUd/aGqFg4OATVShJiL0OyEcHRALwpgTIcoikh5CbI9w/Odinp55mJUjTc9aYXdaTNgdHqUQh8UvuMXQWBw4ipa6HWRi8mPCyVoaisbWfdy3mW5tyxVz1gUq+Qmc+efxjef+KZ0Wj36R3hpWB64SpzoTPHPOOH+CSABach0aFVGNBcgXK2gj58hGPaDnlglR98qqZq++h/zlzA0Scxd5INApaSiyg+sPkrQtMB+3Vrdx6VWZU0/lmttWJrj/SX4Ykkks8BHTDVxKRCr0G6FXLj01zZ+eMCIJlYC9sta5ZvCqRXHCuHBUtuF1XpJGLltPg2Ez5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AMamnrWsUdPLi1/ajDW8bLzIyHdC5Hh/PruZRlbCLU=;
 b=EazKq1HYaO+3TS7fg9FPkyrwqulWUQ+ey8o3M3xirB7ZoHarWNfSbQp54pHuVWzENkAftP3nF/Evn85/bvUV1jdqnFdTZiRx/EZq/yICzszJv0TEKP7VBQOx1K9gmgTiCbVkdC7eDvQOaec+xPE5bVkKVZuu5wXmgJaJMSG8c84+ZG5mUn2tWZ50U5maCBNWoci16XF2n19MFegG+UnkcxVQphK4IydGi8RJsmiZmpni7Uwox9pD2pdXTHjR2KyMYgfX14tjauAh+U3kqRmf4iyQ1woN9+NeF0Wv0z9nYYNB685ZeXAeaykWDfgRkSnv2ySdacQW+TLtbRD5fDpK/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by SJ0PR11MB4848.namprd11.prod.outlook.com (2603:10b6:a03:2af::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Thu, 30 Jul
 2026 07:09:50 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%3]) with mapi id 15.21.0270.009; Thu, 30 Jul 2026
 07:09:48 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>, "horms@kernel.org" <horms@kernel.org>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Thread-Topic: [Intel-wired-lan] [PATCH net v7 4/4] ice: skip unnecessary VF
 reset when setting trust
Thread-Index: AQHdAvnFxUKtcgHeCE2cMytCGAqZ+7aF3seQ
Date: Thu, 30 Jul 2026 07:09:48 +0000
Message-ID: <IA3PR11MB89856B526E0F6417B566DB788FC92@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20260623101800.991293-1-jtornosm@redhat.com>
 <20260623101800.991293-5-jtornosm@redhat.com>
In-Reply-To: <20260623101800.991293-5-jtornosm@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|SJ0PR11MB4848:EE_
x-ms-office365-filtering-correlation-id: 99d95155-417f-4941-6acd-08deee098b06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|11063799006|4143699003|10067099003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: SsVKVMxyv4IjTb4HzqciiC7neUnE8X0jnCH818nIX3TtdSI8nCzhgew8nfl3QPhn3yuuif2mj7MVsZ7AnygQgovIvsh6H76rIIT2Z24cslQ6RPxyyVyKVFqCb5zbyIjo7w7CgrhN2UbROeP5wDbrOQdsD+Kn7IjZ4ZLucZt4u83rLtYEYoFgzh5vWqm9DF0TIOKnZlXXhAevJGiwZQNTO7GGGIdEytyHK3dt6XqDlpiym0m8G2s/EOP1uw19c85zAUO1dn2/p00fPnQKcW4z7BwhyQMzTpFszY0TdVjQb5t05M16EoVw7G2kqvmMgjo1FUn4Y/+21aNHX5vPQZSJ/QUtK8CK3QyBjeUEHKO4Wg2U/Pq7OW5ZEbjJxlSp2eSgdOnbGqUO/aaV6UEBYYrvGzovk+nhLei/ZoSiLKltZJGiHb8e4FBlcW86OFHS4kvTdaSsOqyuMFHVZkBWZtlGBiBuTu9Im9UneDDYikgv5tuWZAIEoK/QAhix8n8DsADUYvX+k/5j9rq3roPvMsaAzy2fpqBJpZycQtSukFTdP3cK6Y7O7ePR+D2oWGdwsTi16hj9V5D66rRDjPlFZ5vs4N6N6l5y5wWKJwK+KZqefqDmJM7yRQPNoB9ArE2JIQ/Wm02EZIy5wN3Lv1VCdJ2h9W4wqO0s1F2v65zHvsdPDtKTwWu/vHaSKSM2QGILc8frz5SBXP4k3cNwfc/rHXyN/uOuHxG+7cluVa3awTZdJLE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8985.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(11063799006)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c2caA74V0MNPLOeZvcExIpqgXqlhmxWuqTPMMOmYPLQ01svoN+wdoVHXhV5t?=
 =?us-ascii?Q?fhigkZhZZB8R1qzGH0I+ysFmkDyVRfKmELvK9zhVOidqaPTJUH50l1zk5/Dj?=
 =?us-ascii?Q?iFS4HraboOO8dQUonQZ9dBc4l1LjndcoICe4+RRfg7IuO0y5Fl9l+BZg5sYd?=
 =?us-ascii?Q?Hyo8iEyjMrYjHZa4lrprRjyvyFOihktX1xT2yNk3TRBGGuQcxBio+l4qsN/0?=
 =?us-ascii?Q?uagahVe7qry8q0Dpci1ogKbOb1xypilnRMW1e8PAho97iEmZawUD929volSc?=
 =?us-ascii?Q?oSHh3MCMytVumUGrJnsVjkCjQLQkq2JRAyEZ4R/ZM36mDXU+GP6vcCP1WzJu?=
 =?us-ascii?Q?FIO2KJm8m792zp878f1bOo5ZoqCabV1hHSRyjJX4cZRs2D7wx5b+EbaRL/um?=
 =?us-ascii?Q?PNwmmX3a3gRbqs7cgPMZvtMKrHvBpN4ugtuH5TnINxo+zUJqxwtLwxSxkaQ7?=
 =?us-ascii?Q?PzVc7V8yQoSBcOoXCedYn+F9kTfn2hMyWGlj1d+kZVT1KZsmHEWC/yM13MvS?=
 =?us-ascii?Q?25nnMITo3TLVAIG8gWbka1FXuWe9TgfRmT8vYsJSqYmU43kw2VfaztSwD+6b?=
 =?us-ascii?Q?8MdWUJ+9PrTzVbuyegPYDENGlKo3XTLpY1qn/s8Av9Yv0ZVaqXkfIIzKOCIa?=
 =?us-ascii?Q?Ds4BbfSojU38/lYuGp5gmGdHDfK4a9Vuft82e3LkTPXBA2oghrEAoNhFUGvA?=
 =?us-ascii?Q?4Qvq2c4onW3z0m7vyu18uRxsYMMhF+H98Uc1T8SgG5cHdD/eQU2M0gKhE8/l?=
 =?us-ascii?Q?iBFKw+OaA6JANdSEfUBOMX1KP3fAiOoxQ/X4QsD85yXcvqGQrjCpPpryICnm?=
 =?us-ascii?Q?v6XaTDYv0CEZoW6ZbGsLMPZO9misFntwvMUEnVDzo5zHLizWV73xNhGttY17?=
 =?us-ascii?Q?YwRfV6H8rIXvFQCkZMM/MrZZhv3EhYAaHK0aOpQRrZT4TC+YtaA2Hfzp9Z1C?=
 =?us-ascii?Q?dlmAcAff96ygojmAE8F5skuefU3fr8qYaeucwDImRkmepofsoT84Qpz7ozBU?=
 =?us-ascii?Q?v+KtYN7W9xX+FXNa5CL/HPFzgLTmzV0NMDxXf2376zKnbAU6ELQv5AQioaQR?=
 =?us-ascii?Q?BevXtknSQw+IMRQBXQZ6orowBuW8Za3unP6FGZB/r/OSy27IO/f8HViywxcs?=
 =?us-ascii?Q?+EuSdhtI6mH7eATP0aasx0J2IJsxYi7xZHPZORKP/eHu3rf4i9uAZqjrYHBn?=
 =?us-ascii?Q?H/k6io7IZf30O+5E+nVqwKGJwflr7UlDNurjcoXg83Yf+39A7sgrOYwPdVjm?=
 =?us-ascii?Q?k9R9iXTYEFZXJ44klCGtUetUhUp6CTOW1vVguFIPcHTkOcJe8DWsc6Kr+vrF?=
 =?us-ascii?Q?9xaTToqy3kZPMxQq6Yr2leQXUAoM5ObYUwaHiF3+ds4WOT4JuC/UO9OVclEH?=
 =?us-ascii?Q?/S06DYJmJkuVVicD1UUaPaWwnhfc/w6CIPKmz6iINS/rtPnsJrXmAeymokFL?=
 =?us-ascii?Q?tivJCrZMOVymqMLusWZAc+ki4BrXQxEXUnf6W4WE1gAeOrD1VIv8vuVVdQYg?=
 =?us-ascii?Q?dLhDBVmrBgA/+mG1nwu5BS81jIGe0vWdq+qyrmemgDvPkrP354PRGGkbsK6X?=
 =?us-ascii?Q?e1MxzGxhYnEL+WlJldsUkPqR9XvZuJT5rIgXvWlH9UB8McGNv/LLbE78PWTa?=
 =?us-ascii?Q?mHrDTHKUNEG+sKxQDHr4nzTfH5bBqSQueB0Tq3FetmMoLi4EAoIZ2jnZMjpT?=
 =?us-ascii?Q?wpYYsXXOgG65f+jgf+70m+phxU1gOqewvwIhIVM6uCqVhYXJtsOyg8wArEbT?=
 =?us-ascii?Q?EMpmv5QVzg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dl8mwNlD1Ttj8rEqHzkEJYPLD0p/Z0nShqK++G9zg3tREmFm2HLKyXQ04D4/HiMu9K5ax8Aq1Zwn1s31nHzd5AqUVqj+je9/I3SpSRNpzIuBPQaJk8p3+eGwR1w/d9Ycjua1H5y/lpzakhGeTpaFiiLqQob9aejRQNlrll6AjV0HoF3Cjjq/s6dS39Sa2AbVmvInkIjhSG+CPzPon/Br7XD0n1XTiBxsdYtr2fQmKz2FupmluOvNWX9Ux+GIvAXxempZxJ5wrmCZyNqciImDMdt6baowMGQI+mz01XEpRPLxo8zmCVGlVXNsi3ubM8JoVJ+Z+v3xO4v5vhXPHmCCmg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d95155-417f-4941-6acd-08deee098b06
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 07:09:48.7297 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8w3b1+tmcA4aO9DtdLMNMkCE5a0UgY7kS4jxwxj71K0n2A43DbUVqgPLMV87QM4q1zk0cSBo8nBNBTakIYrB7M1wyCSTuM+0kEuMl5+xR14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4848
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785395404; x=1816931404;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5ab1En0b0HCP5gCIjfSppd9u3/W00JFByF88HqoUJTs=;
 b=LUA0KBpK3JivzzMpnVgRKQUWasIBK0V6MWMDvEPqqgToSXM/XKv/Oern
 pMxhnD7UsaYWh7Cw2BFa2KN7TT3orO0MG1PqKC9sacAsXuko5G5yOYNWQ
 uZ8O0LqcJgdqGuREqFyYOyIA45KjPMBHxYT9H5XT4aXNZVEYu3Xe+GWvQ
 XKS4cxyE53AO4bXnPvzkOW9RiE2gRecMQHCACBXXZLG5dijSRndpNPFjr
 us9GpiYPJ2B28qY7XHNdYg+Lf9hd0zvukV8+PpkXIpl0f2lhjNdr9PvMF
 ix1u/550QRacnJNxo58LztKx5/hh3dQXpwctPgTGXrUIXwetBPkFw9k4U
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=LUA0KBpK
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH net v7 4/4] ice: skip unnecessary VF
 reset when setting trust
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
ose
> Ignacio Tornos Martinez
> Sent: Tuesday, June 23, 2026 12:18 PM
> To: netdev@vger.kernel.org
> Cc: intel-wired-lan@lists.osuosl.org; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Keller, Jacob E <jacob.e.keller@intel.co=
m>;
> horms@kernel.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> Subject: [Intel-wired-lan] [PATCH net v7 4/4] ice: skip unnecessary VF re=
set when
> setting trust
>=20
> Similar to the i40e fix, ice_set_vf_trust() unconditionally calls
> ice_reset_vf() when the trust setting changes. While the delay is smaller=
 than
> i40e, this reset is still unnecessary in most cases.
>=20
> When granting trust, no reset is needed - we can just set the capability =
flag to
> allow privileged operations.
>=20
> When revoking trust, we only need to reset (conservative approach) if the=
 VF has
> actually configured advanced features that require cleanup (MAC LLDP filt=
ers,
> promiscuous mode). For VFs in a clean state, we can safely change the tru=
st
> setting without the disruptive reset.
>=20
> When we do reset, we maintain the original ice pattern that has been reli=
able in
> production: cleanup LLDP filters first, then set vf->trusted, then reset.=
 This
> ensures the privilege capability bit is handled correctly during reset re=
build.
>=20
> When we don't reset, we manually handle the capability flag via helper fu=
nction,
> eliminating the delay.
>=20
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v7: Rebase on current net tree (no code changes from v6)
> v6: https://lore.kernel.org/all/20260619061321.8554-5-jtornosm@redhat.com=
/
>=20
>  drivers/net/ethernet/intel/ice/ice_sriov.c | 33 +++++++++++++++++++---
>  1 file changed, 29 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
> b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index 7e00e091756d..XXXXXXXXXXXXXXXX 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -1364,6 +1364,23 @@ int ice_set_vf_mac(struct net_device *netdev, int

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>

