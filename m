Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2A9C5B572
	for <intel-wired-lan@archiver.kernel.org>; Thu, 13 Aug 2026 19:22:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0222040CAE;
	Thu, 13 Aug 2026 19:22:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N_eJckLd9dZL; Thu, 13 Aug 2026 19:22:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A86D940CA8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786648945;
	bh=BBSp7RawNPN5r/EpoG2oNdqxi++c3wFLSalBHE6oUdU=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XBJogyQDibZi9EoHlRFd/WNLFTOQ3qHFLVCn5814qhhXj3/cG1kUqRTz0zQmR8K2p
	 N0kEQRyVY5SljjX+Ukwgm64pa7MMyBZQBD3uMjoGgIOuYH9wsWxYOvcinO7ZfT0Lhs
	 NG8JrxJxJsBKZaYCPEiv2hfd3B67ayzHVZuvdBgx0PVqrj6CeBEi/1ude7q9C26jiw
	 p936hc6cOjmkQ+R77nNpqx8MXcff/OD+y2KpEuk3mynBPP4z4lVrDb3Usw3eypkuuk
	 p5iICA6AwwJQMkPXGpbSJgL90gziY2Ijv+XlKJmVrtcNYqR8zqusyGj2bz1S6+d8Zi
	 aHQXGaJR+0S4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A86D940CA8;
	Thu, 13 Aug 2026 19:22:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DAC363DF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 19:22:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C5B50808D1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 19:22:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gFP3mYBnbOQ6 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 13 Aug 2026 19:22:23 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=patryk.holda@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A15CC8118C
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A15CC8118C
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=NYGFUiBb
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A15CC8118C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 19:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786648942; x=1818184942;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IzzXjAbWPbbhHgHUiMDQ2GYnrCj2VrpxAd4z2k6DTAk=;
 b=NYGFUiBbEvGqUbvDyzC3kdPpb6XKCBPvp1600zRulXydyUFmXqJ9Pa42
 xOpOnrS12jecf5Ho/YEW6YsuXmQX8PTVz/NToMhuyjPATl3CRzCN0DDFC
 iIEnqtgwtRUVBwWOOUkbutQZFbmOjBq0f/jsgIvyfWdaRvyu8GYqSa9zT
 eXaiiHjOub6y0ajMRYJdsWDPvY5V/J1se2PGr3tdoGEWrIaWMZS3SnKot
 UHU+B2wyNO7mCcprMS028+b4pSdPVZoTBAoKyF57rYwffP+J7yR0yegrD
 U8Voqpj1q+a1p99GbnM4wH3KwkNihz5EV8NnP5dvx+iZ+lbO1yymRDDBS A==;
X-CSE-ConnectionGUID: 5z1iMKmbTdCvWtidMuwolg==
X-CSE-MsgGUID: xvgXw33pR2yF/KJSDh6UXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="97580599"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="97580599"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 12:22:20 -0700
X-CSE-ConnectionGUID: Mr9qW1bjSKma78bRdGTjWw==
X-CSE-MsgGUID: lU8p6Ky9QVq1N85ceUIzow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="261385057"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 12:22:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 12:22:19 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 12:22:19 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.52) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 12:22:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrRRhIlQE6QxhakXWd2XOw4hj8XqaV4Nmausyswhr9qIDLOtF59RG7Kant34NE+PwU+dsWcKKaAr+6EFfaCgT3L5KQNEkjaAFGDKAdQj8D1icsGqfnpO/BWfYxhuIime42RFg8vbexVhvTFwkgEuytXIUZCL1hTBxCO4NThDWL+ub0eGD0mo8OB0kzgf6zTIw2H4ZhLmVa+d835slQgBNkUNWk/U/6skhlQtKHzlfw4Anq3/3WXV6zK5qiaM8ss/XM8wNIqwdtbhD3gcbhgO7/Vd+r+dXXw6lH3r3m4wFua94iQWS9jQSW7OIIiRJd2SGRb+U0mnSyvUCiRwIjlPAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBSp7RawNPN5r/EpoG2oNdqxi++c3wFLSalBHE6oUdU=;
 b=bxpR/tlNEYfTAvbgR951VMAFztsPcUW11U2di3qeB7fNFTuT6eoDdAPszBSVJQ9fYVnykWklL8U3x4pUVkZYPjSA9aHX0iD7uRaBxjvqR07XuKmq3kzQVx3JCe5/lvPCd22vvKQNMz528IApmfhM8hBL7oI1KE40fGW+Tu+Xlvst7fBTUj98CINa/RdWNNLxWbg2ysyddarraWZTOZ7MKBqHaLmY5JaV5xdJ/dM+no6QtHpcekLYb2ArdFg+15rEt+VaaXTlcaHvlmByuPKdhtcW62UpD453iGsrdajtRkm44OpxLBgY5SfvexfQvf14yunOP2BoXOcJzcSq4m0WWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9301.namprd11.prod.outlook.com (2603:10b6:208:573::20)
 by MN0PR11MB6134.namprd11.prod.outlook.com (2603:10b6:208:3ca::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 19:22:16 +0000
Received: from IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c]) by IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c%6]) with mapi id 15.21.0292.019; Thu, 13 Aug 2026
 19:22:15 +0000
From: "Holda, Patryk" <patryk.holda@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
CC: "Vecera, Ivan" <ivecera@redhat.com>, Martyna Szapar-Mudlaw
 <martyna.szapar-mudlaw@linux.intel.com>, Alice Michael
 <alice.michael@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Eric Dumazet <edumazet@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Loktionov,
 Aleksandr" <aleksandr.loktionov@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Marcin Szycik <marcin.szycik@linux.intel.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, Simon Horman
 <horms@kernel.org>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v4 2/2] ice: preserve uplink
 DFLT Rx rule on switchdev release
Thread-Index: AQHdDtmEGCpsSqOeIUeSBmcosplMe7aclFVw
Date: Thu, 13 Aug 2026 19:22:15 +0000
Message-ID: <IA3PR11MB930195835FBE12644A2B38808ADB2@IA3PR11MB9301.namprd11.prod.outlook.com>
References: <20260708125755.706263-1-poros@redhat.com>
 <20260708125755.706263-3-poros@redhat.com>
In-Reply-To: <20260708125755.706263-3-poros@redhat.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9301:EE_|MN0PR11MB6134:EE_
x-ms-office365-filtering-correlation-id: cac3a3db-25b7-42ee-14e0-08def9702f46
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|7416014|18002099003|22082099003|56012099006|6133799003|4143699003|11063799006|38070700021|10067099003;
x-microsoft-antispam-message-info: eNEZ+P3Vz8IlfUEISM7waVWS1bnUSJ/J85w5oRYE3JTJ5JVJjqkaAMJ579ZVEIx6volMCqTHbXxA7zycghbYIt2+5G5E+zDBmbEwem1IOoIkH4ugg3r7R2Omv3hBobWxsHvQJQel4IYYGh8f7ygI9TePNrW9oS1gOxZsiDpITBK+mev7vnz/t5BXzmRT2iHIxjiVQXPWcEADhJ3/qWPZJoRIte1GA3rkDF5Uagger9361XcxSmHgoHPSZj4vpyGX8bhnCdbsH0ZLwygZG4UhYJ7/0dw6owCjGynGkQukWUzzbisP9LOhwUOWsi8QfP9H880D1eyL0wvQh0TdjozB+h/Nisrvmkxz4NQc9+RdbSmU8wMY/blwcAz8Y4VKKiMO7VIsfZKB4K6IcZhSNAv7qtxXkQ+OjL08uIw7Mvw3+c8S7yyYoWiS1vG/EqQtA3D4XB2v8VfbfN420HwhfcGGCyq/mIWkViKZsusjaQmeXqRb9kROMs6XAjUvd/7v/6SkYYixuPMi+p2vTAN+6+7kdnBYWWW23FZpGmcQAlqd7XUY62TdK2IhTvjciwQSan+dYjgdieGwalJ91XazZ0YXnB2+GLmqkltG/EScQ01afNiZB0ybBuIa74/JazlQiX9WYpFKXdpuIODYtylONQquUl43rLfZn7oXwhrhjqym3Uz7Eyx+Tp0oKI5PxjB48+BEJcPjsxl0xW1WdN11+gKqaboxj8l+xJXL2mOpC/KN2S8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9301.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(18002099003)(22082099003)(56012099006)(6133799003)(4143699003)(11063799006)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Xs7FORo1GGwc52UlIZ0xCD4ed2njzCUB6kkwTTQkn3I+0pguklDf/uwVKn?=
 =?iso-8859-1?Q?MjtrlteAF+GxdfDsY/MASinJ9tdnZAAIZnZqtfm3bydYMth0NVnB8o9Q0J?=
 =?iso-8859-1?Q?YzvX17q59A34J1MCt51rlGYIeNZZI+cC5P//EkMjGKRAMT+2prtZlGowRS?=
 =?iso-8859-1?Q?SsJOjOMV2fxaaf1BCWKjmebgYZa7GPvk1GMCKRaziDd+Eql0KfLao11975?=
 =?iso-8859-1?Q?Xvkk73PXt5+B9Q5Mrzb036oX4XgQU1dnQwKcec4RyD/5MZ8C69ULP4Ei/o?=
 =?iso-8859-1?Q?Whyk8ELj61zSSuQUjInq+7zomPAcvRbG1YqFydNYQwvSowY+SrbTno+JOQ?=
 =?iso-8859-1?Q?iIjDZ9b7d0aM/UbLOLFYfiN1i9IZliFXtz1K4mCSulBRMoOpWGEQPdUZfb?=
 =?iso-8859-1?Q?FubesiO53D+RrHyCIBDhBmhUR9ewla87LGNqXs4t/rLmnd6j1gBRw7VX5r?=
 =?iso-8859-1?Q?vlv0CwWCO6FqLBSKUJVX7zxFUfHlaEa77S2vYgv6JI9XWT3Sp5SyRouTYb?=
 =?iso-8859-1?Q?8t5t9ic+HFLhmTgax4vkNZOheAD9KQG/RumoRrvJfgoI+KmegFr8X8PfZ0?=
 =?iso-8859-1?Q?7ya3efkca1+eLxx9sNEUPvn6zqvsJC2GsqM4OlvrxDHasPodXrqzaudF8P?=
 =?iso-8859-1?Q?NRd+o3msFax5C2d10sfRHjZS0Of3b7OMbxwjt6R7hheJ/rzId/1nBB0jpM?=
 =?iso-8859-1?Q?knpcaaYKB8GM3kgylNHznCvgQxZejiL2DEjqgbg1Z2ZK9ht7aaCUwTZq9u?=
 =?iso-8859-1?Q?6FetU+yvtNTbCrJ6Y9fswT/K7UhbSHDbsAOIdKAv3laVEuBMrRqG0UMf/2?=
 =?iso-8859-1?Q?3ILtTcqhADXzQSIoX1kPj2hBKTDVsO4HsJCoJlZl1wq/Vpipv9cVlqTtnj?=
 =?iso-8859-1?Q?+1BhPosHjeVjaets5/IM0tqerBmjamf3e8PlzbPXWqbrZgV2h2PsI2s5KE?=
 =?iso-8859-1?Q?DwoIwH0Z8pug/qIB0+ZkZCF3ruQFBplYHvih30jiSB7zGqlnKuwNPbDEvd?=
 =?iso-8859-1?Q?1ZK2P0nZw8VN2SYp463GKVRijj/NxxGNbw5DSXUzakRdSwow2Sik5Pf2eK?=
 =?iso-8859-1?Q?Ti7sb90fU+DUctIhXl44E+e09SpUfaD1d49GfOOcljdHmMdMjIkUG6Vw0J?=
 =?iso-8859-1?Q?OLyQ00937yN5P3IwUD3sOrOjWJSjqwPxUpQ1XVI6GXb9P15l1hQFaHqRJ3?=
 =?iso-8859-1?Q?GzvhDoGsr+APuhTH0Un8Iiw6CvbP5HATjAzCKE1x95XvKsayRSPfuJ6pfo?=
 =?iso-8859-1?Q?mTSCqazhRHbEQAVkMJy0B9kd64ckaLBTJ0e6yDmj1O9Lzn4fzWUi6gRY56?=
 =?iso-8859-1?Q?Jnx9ykvnAjKWKRbplLDh1pjJHUDNrpkkKCmy9w4GDUbujxXAlx0uV4SlZM?=
 =?iso-8859-1?Q?ozrLaKubxL92tOhD5N4J9OcqREGcewpR4ksujhDwE5MzE9KK3dVstsvqq+?=
 =?iso-8859-1?Q?zEGTzEnzONweHSz7kQGHKX7BLrq1VLYpXhYk0ygMltpwVgRAVgy69cOZT6?=
 =?iso-8859-1?Q?02nbFUmUinTDx2ye3dPV44V+vrxtfXyf1I/keHEn279WZDpchda/cZpghf?=
 =?iso-8859-1?Q?KknJwc/QHPdSjdZkaQUGWxhp3hQtjIzL9x6ghjCs4gJK6KycgSngpqqYEJ?=
 =?iso-8859-1?Q?tWbQJGxn0FUCgD8cI9cdsP4EcFDYCuDdqJUSQmfUYrk6J5+nvrChyuydoS?=
 =?iso-8859-1?Q?87Ib7fvfH4GUhHYBbt9TX5extvk3MQJG9LsU5ZAp+ZK8PUloPYgS1MGPQk?=
 =?iso-8859-1?Q?aacoMcVD0YoBmuKY4BM6mdV1kyDJ+Osmm241xGVo8DNVC1xoCP9T68fTzR?=
 =?iso-8859-1?Q?oJ1i1fNrng=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dnjvBj8UWBRQ0/RIO5BYq8rGVl5bZSKZDWL8oS8Ekc2h9Kd9Vsqi/fA4EFX93SKcAUizxJfb7fI9mANcL6h3bi+npmWNh0+Efj4RRkL+rfYFIslp5Jwtb+DTMMFrcYr9CzJ1cEMSVMTaUABKUn1TZ4dwSuP/avm9YiBj00JoYdvw4OFnDSPjhW+9JoULbGbdglNIRJ2QJVqAVpmA3y7XK0/kxO2mSkrPcRHlRUtRh9c0l0RsBJcUFVzIZpFzKqUBSpT/iYOy8siTPntCbBbvem4hv8NCTxDwyo6YZ8WGwRAZsC88/U6JuDeV+TnGLH1PT0KW6CiVi3upLmh309keXA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9301.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cac3a3db-25b7-42ee-14e0-08def9702f46
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 19:22:15.7769 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7NUclrhztblxGeUITXUsJ6Riung3kKyqM0T/MF3z2OwkJZ61M1gau6idRT5M+eKB0pGjXCqZYWYXN76VtkcRug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6134
X-OriginatorOrg: intel.com
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v4 2/2] ice: preserve uplink
 DFLT Rx rule on switchdev release
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Petr Oros
> Sent: Wednesday, July 8, 2026 2:58 PM
> To: netdev@vger.kernel.org
> Cc: Vecera, Ivan <ivecera@redhat.com>; Martyna Szapar-Mudlaw
> <martyna.szapar-mudlaw@linux.intel.com>; Alice Michael
> <alice.michael@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Eric Dumazet <edumazet@google.com>;
> linux-kernel@vger.kernel.org; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> Marcin Szycik <marcin.szycik@linux.intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Simon Horman <horms@kernel.org>; intel-
> wired-lan@lists.osuosl.org; Keller, Jacob E <jacob.e.keller@intel.com>; J=
akub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; David S.
> Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH iwl-net v4 2/2] ice: preserve uplink DF=
LT Rx
> rule on switchdev release
> Importance: High
>=20
> When the uplink PF is promiscuous, ice_vsi_sync_fltr() installs an
> ICE_SW_LKUP_DFLT catch-all Rx rule on the uplink VSI. Entering switchdev =
re-
> affirms it through the idempotent ice_set_dflt_vsi(), but
> ice_eswitch_release_env() removed both the Rx and Tx DFLT rules
> unconditionally on teardown. That clobbered a promisc-owned Rx rule: it
> disappeared while IFF_PROMISC was still set and the sync path was not
> retriggered, leaving the uplink without the catch-all the netdev requeste=
d.
>=20
> Skip the Rx DFLT removal when the uplink is promiscuous, both in
> ice_eswitch_release_env() and the err_def_tx unwind of
> ice_eswitch_setup_env(); the Tx leg, owned by switchdev, is still removed=
.
> Test the live netdev->flags, the same value ena_rx_filtering() ->
> ice_cfg_vlan_pruning() above already keys on, so the preserved rule and t=
he
> pruning state stay consistent, including for a promisc change made while
> switchdev ran (which never reached the gated filter sync).
>=20
> Fixes: 5c07be96d8b3 ("ice: Avoid setting default Rx VSI twice in switchde=
v
> setup")
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
> v4:
> - No code change, added Marcin's and Aleksandr's Reviewed-by.
>=20
> v3: https://lore.kernel.org/all/20260701133601.2118382-3-
> poros@redhat.com/
> v2: https://lore.kernel.org/all/20260622113428.2565255-3-
> poros@redhat.com/
> v1:
> https://lore.kernel.org/all/deef5756e534ef06c12d910c5305d3fd205d30a0.
> 1781786935.git.poros@redhat.com/
> ---
>  drivers/net/ethernet/intel/ice/ice_eswitch.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> index c30e27bbfe6e25..07e2016fb9481f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> @@ -66,8 +66,10 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
>  	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
>  			 ICE_FLTR_TX);
>  err_def_tx:
> -	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
> -			 ICE_FLTR_RX);
> +	/* keep the Rx DFLT rule if the uplink is promiscuous (see release_env)
> */
> +	if (!(uplink_vsi->netdev->flags & IFF_PROMISC))
> +		ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx,
> +				 false, ICE_FLTR_RX);
>  err_def_rx:
>  	ice_vsi_del_vlan_zero(uplink_vsi);
>  err_vlan_zero:
> @@ -276,8 +278,16 @@ static void ice_eswitch_release_env(struct ice_pf
> *pf)
>  	vlan_ops->ena_rx_filtering(uplink_vsi);
>  	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
>  			 ICE_FLTR_TX);
> -	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
> -			 ICE_FLTR_RX);
> +
> +	/* Keep the Rx DFLT rule if the uplink is promiscuous; it must outlive
> +	 * the session. Test the live netdev->flags, the same value
> +	 * ena_rx_filtering() -> ice_cfg_vlan_pruning() above keys its decision
> +	 * on, so the preserved DFLT rule and the pruning state stay consistent=
.
> +	 */
> +	if (!(uplink_vsi->netdev->flags & IFF_PROMISC))
> +		ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx,
> +				 false, ICE_FLTR_RX);
> +
>  	ice_fltr_add_mac_and_broadcast(uplink_vsi,
>  				       uplink_vsi->port_info->mac.perm_addr,
>  				       ICE_FWD_TO_VSI);
> --
> 2.54.0

Tested-by: Patryk Holda <patryk.holda@intel.com>=A0


