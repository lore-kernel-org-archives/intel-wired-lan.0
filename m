Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9DACA5FCE
	for <intel-wired-lan@archiver.kernel.org>; Mon,  5 Oct 2026 10:24:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CBF504062D;
	Mon,  5 Oct 2026 10:24:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UNzdFribYZom; Mon,  5 Oct 2026 10:24:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EC6674063A
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791195895;
	b=EagqbyTdt7jdgPEVT5EEZtyNIsbjSepZv/lO9beNnsoEsUGQKvuHCBhjHmgCOoV4UaqQ
	 ZywOYWjHRYEPIaJ8R1dxZeWqLC4SZJJrrbUu3wIEnC+iYgfDZPBLFNTMRggfeIrCKgpqi
	 9cojEV6fJsc/kYPXhImVUHlZ47eYk98gHkb1sLJWVAG01PXCCyRG41LKhVIMY1ec9Bp/f
	 E8guZYrUzAYo9Tk08FNFWcBtYizWr6/Dd5dgKCxgYu3E1cb4WS3AJHdFRHFQ2uf1FJo+y
	 K6ON2cCyu41g3TzmVIfc6lFPdLBaHO3IvAWCfyAEshqDVUdRO8A4MUAzytjFfH3/f7g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791195895;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hYzCyqt2gB3OxbnQFZpZZPb1fQywTcUHcK+5gqHulNs=;
	b=aYMbqYD77GC6uL9sLeI7heeym13F3z5Hwz2xX5hfw0KRzbWSQklRcqPTFbYiwWyMnNZK
	 QkOzcjdRamIySCeNUOhtI4y2Afkuf2D5stGN0BCvBQYecHxK4EsTDwwPD0PAFbwKRKudX
	 ATUUjEnG9F03LEWfkHpGuZUJRlpRd/HUHYwhkm59U4Pz5cxSyKR7IwVtoccpcruC8xTyi
	 gjqvmHhh/aO3bC6kfm0KE2DsTGzwqy8eBOCH5NEgm0mHDfWKS3PWYFbGKC3ZgjqHgYMjB
	 8izt8H1w1mxfaGUlgeLmFFJv6Kqx83QUsFOlJ5PRj/Z5lcEpJbI1Pl5iB+7wmJXE4yg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791195895;
	bh=hYzCyqt2gB3OxbnQFZpZZPb1fQywTcUHcK+5gqHulNs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=3n2aLi+Xg0ObhDUiFDVpASRgcGwtZDXi70A7GyRAh4dq0GGkEv8ZzmAOVF4qLKBG9
	 noiodtVsv3PLQy27khmJLcshmr1iUNSyuDDyfVvAlLz5cVJVJNL075FDVBbVfU2IXV
	 NBEbnFQ1gcsYZ4GUw5nXGFM8yO3vgaw+q86I6odZVo0qi0QJIx2fCVjRt6aLnLqFma
	 ZIEx01nBzIisbHGaie+fVMiSca0tiKzXyE2qLVKLuDsBJT3k+KOezphi8PAzqG1z0w
	 pJlscHaO3psRsSIVHIEEvaVTHMjHdrJ+lYKdW5YBw2kA0RQeq5aMokBxk3V0IdbprH
	 O+cpKlZnteD3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC6674063A;
	Mon,  5 Oct 2026 10:24:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E32A52E0
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 10:22:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D4C37806C7
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 10:22:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MB2tV2Si_INU for <intel-wired-lan@lists.osuosl.org>;
 Mon,  5 Oct 2026 10:22:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D38E8806C6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.14
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791195754;
 b=IcD7etnfUjCsSPm0+0xL4W65i7IJA+gsrEg1qhIzwZ9Ah1uX8VOfw5ntmayN7jqwJy+k
 c+vlDik0/Dm1ONQ0IqE7zYdLEvqdhPQbRblJi8r9ohm7lsbo7hwC16Odq//gEVY1n03Of
 8S6MHRXDBL/2xq21+zryNoOWsmjxKq2aF6o1hCcHWi7S/CVIcHZVMe6z9K9YndPfTYVc9
 Na8rXb8A+xYyknvTtLLypJ91aqfVC/P2bAH0C/9viTP2LiloLV3HkKO1WJaBMbBOx/so6
 C+SNmO7R7GV94dKthr8PoRMwl368lO/cxBG7dPE5w/puyboOSJWtgHOGJtVPrSJvxQg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791195754;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=hYzCyqt2gB3OxbnQFZpZZPb1fQywTcUHcK+5gqHulNs=;
 b=PEfYQKFveiVFgihVhtWQhlNSqHKX7qQ/fwLkF91KhkeBXF0P3eaG2syWTUFWLM0VHEge
 kLceRgFUlbO/XgKRJsyn1DKK/Uq9H0tSHoIFNyWrdWt/+zpYDjn42gwwRA74JA/Bg4YX6
 kesezX2xvalZ7+TsT8MWh/F/FNheYZLCmQvWCnyYpUpFNWnC8OFqvk2iwgTmBxO4X6BHs
 yg80VToqdsCI+WYiTV6D0tY3Qwx1J3TvwLtZE6QX6aI60d8mg7GK6Xtam96f+YJIbnFJP
 q3yMU1WsnCtE6KZjCuyDIOu6VEMKcFTAYJvEHr2tGNLUchKPvEfYC5kzYS40oDlLBSg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Uh6TrJgV; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Uh6TrJgV
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D38E8806C6
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 10:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791195754; x=1822731754;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vA3aW/MSduTnzExx3nGCtvBGVVbI/54ubUjjAXJ7vds=;
 b=Uh6TrJgVzXdIj/ZuWtE0h1O6yxiPVGibk81/8dJYHcXInb65DV+qwfLW
 XjDk1IKHzJlf+He/sVpaDbqlMOa7/yJHarOEU8dj/FYaniQ7TBSefd9yA
 Pfxjnwbm3PbzSuw+e007fEOniwDBoC/qKZdZphUmIzOVW3HDi7doMwJLo
 a3bvyayJfESR0Y6CJMPZ2K3lbczeEPpdpozr9S2Ro+/h09eDuIgSMtFeF
 xXJSpnKT2PhZLeyOsYQvRw5ccDi7J4wFQwMT8hWjcIk9d4W66AJ1UgU+t
 hIyN/JNFUk5eYrPIdJhDwWrYCKVeQdIv9j4Z8m/RDZE+tXOH5ZfTkanE+ A==;
X-CSE-ConnectionGUID: Kg+W6k96QC6HJWryz6FBEQ==
X-CSE-MsgGUID: FM2XRgmgQ2Wmt+/8P/y1Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="94736703"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="94736703"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 03:22:33 -0700
X-CSE-ConnectionGUID: RTZJQq+CQny2OZWXriBb3w==
X-CSE-MsgGUID: H7OLpCEKRYG/aX+YWDGIEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="274586193"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 03:22:33 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 03:22:32 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 03:22:32 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.52)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 03:22:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZVHuczgkPurg03cSYDL9oe7cH8Wz3mNM8VOLsF3s/+tt6yhtL4qLvzRE+PB4lhxTOw+3L1+m3lvzzqTs5tyYf9ZF+tXQvSVWbW7nhDea+b8sxuRLqk1uPhpjleSWZ5/zLX3+745ppStY4234cM6pt6ygFoFC1MW+r0zwLKZOOZ6IMl4+0aV9oVSuP5rg6ZMQMpbu5VWI0CHkDoEMAbhEBLA5v0liYBeOOG0vEmcFZkkZRplUZxg5EXONlH/JxHKyOxmGQhsmqwUGVIe6TgLq36fwu9wthXEpMBBGFQ8G4oMQDe3BXcyIp6QZkSye+0m+bBvWTMjFPu3xS5CCZZRaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYzCyqt2gB3OxbnQFZpZZPb1fQywTcUHcK+5gqHulNs=;
 b=FVZ1O0oto0xbyR/l5Zh+YBp5t9CcQkEB+3rYXOZVjLk4wpLU6HYVjbaeWiM+OnrnCjYXkROyHZ1nc2VI7Iz910HUvu+p2Hsxf3OUDloSn54jPv/FxvWVmvXMcKWY6tuBIqpAWsX0DIs/q+d+BlQTUKQr/rtwDjdaGVapi4d0Tl89rt2fbn5whfiEPdJ+P0iD/9MOLVY40FJTLnObnOerd7F0VJ/aeLu9qwsVztVfIkIIZeCXfWL01Dppsv06GIjIGo9zUaBQjLxjGcPLk++CU58fxFFleO4GG77sHsXsKseMcA01YamLYzxMQmOdVjssjyrxp8ff19HtvDi/3afAGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MN6PR11MB8220.namprd11.prod.outlook.com (2603:10b6:208:478::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Mon, 5 Oct
 2026 10:22:29 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 10:22:28 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Benoit DE RANCOURT <b2rancourt@gmail.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "Gomes, Vinicius" <vinicius.gomes@intel.com>, "Sasha
 Neftin" <sasha.neftin@intel.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH iwl-net 1/2] igc: Fix Tx stop threshold to cover empty
 frame descriptors
Thread-Topic: [PATCH iwl-net 1/2] igc: Fix Tx stop threshold to cover empty
 frame descriptors
Thread-Index: AQHdVBUlWeLcIlEgzkOR+mAvJhszuLbuvp8w
Date: Mon, 5 Oct 2026 10:22:28 +0000
Message-ID: <IA3PR11MB8986BCCFE3F96262762B5B9EE5962@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20261004152840.61222-1-b2rancourt@gmail.com>
 <20261004152840.61222-2-b2rancourt@gmail.com>
In-Reply-To: <20261004152840.61222-2-b2rancourt@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MN6PR11MB8220:EE_
x-ms-office365-filtering-correlation-id: bdb719da-9bda-49ae-af94-08df22ca8f17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|38070700021|56012099006|11063799006|10067099003|18002099003|22082099003|4143699003;
x-microsoft-antispam-message-info: ywZwNGM0J3RJs5FmkSKeB38mWRmB/SLDV+taAjABe1ltvgtcpLdNmc4bwhmYv4VmsVUOq9uDC8IQGFzcCsjEAdHzp9kGfAVvPT61/ofY6kAMmvRF5J5z7rJ6v+YJo6FieQCR2nMg5MmzHvjNG6fzRCvw2beCYFZw9IikbY+cX3+lgwag1HC0jCR056tQiHGm6hPXo/ueQRYxnPArYkjWL1nPYblYpLP//X43QOpXwijhhgTF6m69ec58R5z1ghHDWVWtZsrn5rO1hdmKuIjeM5sgd2UK1YdSKDjtJtP7brucQr4sWdXAB6F2dqIW1CN0edAfkJmDDqnlAI3W9vIlT2nlQ9XpdEjjksVZv6041sGsdLZiniW/C2ur2NMKqo4fjpWu7oP5epxsvMorqXpxC4JNKd8yx+KAPEuj4JWPC8CAEsULzCP7Hy14VwJFCBurOHT/QaAwWIv4MZIAK4P2QE3EcZ8Nss81VRJVWKHaJhaxZGWLkHnJwCWFQk/B8RYrNb8bb6YSHQjIoAOcaVM6lV7Gq3m1gWRpcyPhwP9hXI3cSPrY9IV/0VhJrXn3cDJLYlb+bR+UcGxfN07Qij/GdAkfSNHfQPDmNYMGRmdWnOn2TltUct+yF+IFZM9/7IE8G8ZGHGe1VDdo5p2MrSoZolLEEYzp6PnZGUU8JO96bmStI8Xk9tASO6sDadoeHQTrWhzSPG0aw+pzijouERUs1hWmPLXtLOz/mMHpxPMQXgQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pDM62IOd+gDzjAO7BG14eYLwyTORgDM9ycdbpqX6XH8JBkbliKU7ZfQVJyrS?=
 =?us-ascii?Q?+CVUm2SZUi+tUcEvbpaRlzu+E2dXbzmpWocpvWsgsexjt0ovV75Ht5Cp6uAG?=
 =?us-ascii?Q?LSmsvmTb731CQZKMRPyp3vZwU/vdYmWt9W3gMiElBlUexmojbzo5PYozpRWH?=
 =?us-ascii?Q?2pPP03J4rw6VJ9RO3rh7KMgd93uNvMCBNwrWXIHIQMPS0FR98mMtoBeX94Vj?=
 =?us-ascii?Q?gaNjZotvzrJ/BrcSbPYQd2QI5EbwOwO4GA4QDoQoI6IR1eiQulLDXGe18Zim?=
 =?us-ascii?Q?ta3TXpg/6k9WjXA5yYTDNIz09mfqwl5zw68HhF8CkiKyhhv3R497uxrzX2LA?=
 =?us-ascii?Q?kH3Cr9igOowcmMyFKcr1IHKRjIlSeQiGDv38sQMiSBw6cTu07uTcHJfCZlwk?=
 =?us-ascii?Q?PnIWDYLmS9tUrYfN96cvEHGovvvM3H/kZBy13IQ8b5vw+bN+TqKNGsvHZvnU?=
 =?us-ascii?Q?GKQKqyWtOQ1ZjpSz7qxy72gNb8n4G+KQDM7CWOiYoDUqzPIlf84eoUbduaLz?=
 =?us-ascii?Q?qZ5AqC2vLoDOjdYb+ADdhmqDXdLrBKMKlRyOL6psKAIHdkBCKqI0uxrMRfBH?=
 =?us-ascii?Q?PlnOWDgkSFqK6udkd9Dr2MqTicC0Aio7/2zIIEfQinRGR86suX8t1oNVY77Y?=
 =?us-ascii?Q?qELemZ3A9+IZABm/iguujoD1ErC3X0fzdltCHvDe+9aB/7aPiUmhAbuySozH?=
 =?us-ascii?Q?1nLYZJxTs5DaOz+OoLQ32lWLhaBrn4w/Qo3P4uloiQKIZ4qXcJKFg5c8m5Hs?=
 =?us-ascii?Q?jt2FLrPY1cEoWIbcSslGI6E7PAKf3wuPFPHx19bBZQq/JAAAF5WGAfiYt2V9?=
 =?us-ascii?Q?ai1E2xF+kkQw/k0xvGKD7SHwUOjjatiSM3+JPqpuam+dHzd9X6CJBqOr48zV?=
 =?us-ascii?Q?rOz5/It2oJF6KS/bw4DzjMSG/LprxLYcKF4w7RQdnrDYdh1laZUIgqZPBBaX?=
 =?us-ascii?Q?oN2MysXtqmvl7Nw2rYZnfDWlLmzMdu/cLi65ZwmRMao9t79MH5iOrTt7hW91?=
 =?us-ascii?Q?hEW0sTAPL/cM8woaO5pQAd1ELdB47LcT9BtVDld2UJUsdQcdnMHNQTKcw1Nf?=
 =?us-ascii?Q?h7s+8At6Bm4XFP8CdAJk3f4gl092b+tpj0AOavHCkiymSy7VXFOOBBMHmne9?=
 =?us-ascii?Q?ziED8wRtFvyGlr2tehLAowZWkshSSS1//7T2V24pBGkbIDUen5XwtI/ijK6h?=
 =?us-ascii?Q?4EcOTauWKIz4bXJtaMLIRFELKrHv3sM5QeOuIUql2vSPsyzTljWS1XtAAoM2?=
 =?us-ascii?Q?ydeqvzwa1uK+6WdZzKCmQq8Slyz0CTHd49f1haK1pl9k7ODp2GJrB29uo5Dk?=
 =?us-ascii?Q?ytA1LNr5Tw4zXeHZ1EytJkAGBFj3+uHvGfkvenzfT3z5yhMS+uY7JMe066Si?=
 =?us-ascii?Q?mLIpfbCo7uhVdcc6bvLCaAJ1VAA2+aeSFHLDkGbajp5i2/DSAoI9z1Sf4/OR?=
 =?us-ascii?Q?aHAZz8/CZnlEoCkMRso6Qi5V9BZxEgk4FlgJ7Qnaah2d8eLEQxOxT6whE6Gp?=
 =?us-ascii?Q?lrBcVjHV4RJOeSBGcduyDSRIhBxTBtxJvT/UzHSWwdM6bUcuktpUU45dLaJg?=
 =?us-ascii?Q?tx5IqapwjrfzfYE5eitq8ykFKn94mVm/f7n3ysO/gzzIInliZM5QTOGJatnh?=
 =?us-ascii?Q?jxuqewYQGok5GKSLGh45M+/qsaCMec20J6XiZI+GBkLKHUNEAXhvp2ovPpLf?=
 =?us-ascii?Q?cvcwsgJ9MgVqTnqkHyGnEGEYLcFHTbfIbS6+CvOz6Q6FGbEy7/S1C5UDF9hk?=
 =?us-ascii?Q?yOsFMTZeFv/XdBr14TtkLcfcLL2UatM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dOmDBAW8rEQVLQ+Tr8UOYNZ1jP/OmktjhIX++cscHJbvhNLTQKN7SOH7tdQtvOiT2DqhBwlKXuW7uwn4q2d5+LNK3FpeQ/hm96Qqn+1XYXylPd5gthD4iBOBfK4wshUHi0fZUDQ5PQA6TxAVed0kMOgA/7Ms6dwAoPBWHUD2mN0PG/jiqCGsGfVbW0pVe2a1PDUiwVMnLc+pyaZAvk8YokvUHsWtIJr/wtFvRAz+wj2ead7MQcMfcjaR8xAI33G8uIDqf9kUT6zFNrUwQU/hTqCQV+XZv2wt8yfk6QhmfnlX7bfCK2z6WZXA1wYK0jDIIfQvekz4/cuR4wr+D1F1LQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb719da-9bda-49ae-af94-08df22ca8f17
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 10:22:28.8887 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KqC3xLhi6Tu96g5jPLhqoBavPO9vJADshLip17wyl8faKCyw2di4ydQglpoIPu+WfO5mLC9ybfyRQvRoHNqZ/wdGeB0YL4l9nAtReGsBO+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8220
X-OriginatorOrg: intel.com
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



> -----Original Message-----
> From: Benoit DE RANCOURT <b2rancourt@gmail.com>
> Sent: Sunday, October 4, 2026 5:29 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; intel-wired-
> lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Andrew Lunn <andrew+netdev@lunn.ch>; David
> S. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@kernel.org>;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> Gomes, Vinicius <vinicius.gomes@intel.com>; Sasha Neftin
> <sasha.neftin@intel.com>; linux-kernel@vger.kernel.org; Benoit DE
> RANCOURT <b2rancourt@gmail.com>
> Subject: [PATCH iwl-net 1/2] igc: Fix Tx stop threshold to cover empty
> frame descriptors
>=20
> Commit db0b124f02ba ("igc: Enhance Qbv scheduling by using first flag
> bit") raised the number of free descriptors that igc_xmit_frame_ring()
> requires before mapping a packet from count + 3 to count + 5, to leave
> room for the empty frame (one context and one data descriptor) that
> may be inserted ahead of a launch time packet. DESC_NEEDED was left at
> MAX_SKB_FRAGS + 4. igc_tx_map() uses it to stop the queue in advance,
> and TX_WAKE_THRESHOLD is derived from it.
>=20
> A queue left running after a transmit therefore only guarantees
> MAX_SKB_FRAGS + 4 free descriptors, while the next skb with a linear
> part and MAX_SKB_FRAGS fragments, each fitting in one data descriptor,
> requires MAX_SKB_FRAGS + 6. igc_xmit_frame_ring() then returns
> NETDEV_TX_BUSY, which the queue stop logic is meant to prevent.
>=20
> With TSO this happens routinely. On an I226-V (8086:125c) running
> 7.2.8 with MAX_SKB_FRAGS =3D 17, routed and locally generated TCP
> traffic on a CPU-saturated router produced 10890 NETDEV_TX_BUSY
> returns in three runs of 180 seconds, all for TSO skbs with 16 or 17
> fragments, with
> 21 or 22 free descriptors in all but 5 cases. Together with deferred
> tail writes (xmit_more), these returns led to 25 Tx timeouts and
> adapter resets in the same runs:
>=20
>   igc 0000:08:00.0 terra: NETDEV WATCHDOG: CPU: 1: transmit queue 2
> timed out 5353 ms
>   igc 0000:08:00.0 terra: Reset adapter
>=20
> The following patch addresses the lost tail write itself.
>=20
> Raise DESC_NEEDED to MAX_SKB_FRAGS + 6 to match the admission check.
> The additional reservation is currently unconditional, including when
> launch time is disabled; match that existing admission policy in the
> proactive stop threshold. With MAX_SKB_FRAGS =3D 17, the queue is now
> stopped below 23 free descriptors instead of 21. This also raises the
> completion-based wake threshold from 42 to 46 free descriptors,
> preserving the existing two-times-stop-threshold policy. Throughput
> and latency effects were not measured.
>=20
> With this change alone, three runs of the same test on 7.2.8 produced
> no NETDEV_TX_BUSY and no Tx timeout over 8.8M NETDEV_TX_OK returns,
> including 613k TSO skbs with 17 fragments.
>=20
> As before commit db0b124f02ba, an skb whose linear part or fragments
> exceed IGC_MAX_DATA_PER_TXD may still need more descriptors than
> DESC_NEEDED accounts for.
>=20
> Fixes: db0b124f02ba ("igc: Enhance Qbv scheduling by using first flag
> bit")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM bpftrace
> Signed-off-by: Benoit DE RANCOURT <b2rancourt@gmail.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igc/igc.h
> b/drivers/net/ethernet/intel/igc/igc.h
> index 17f213cc93e4..f1efadbd9f74 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -575,9 +575,13 @@ enum igc_boards {
>  #define IGC_MAX_TXD_PWR		15
>  #define IGC_MAX_DATA_PER_TXD	BIT(IGC_MAX_TXD_PWR)
>=20
> -/* Tx Descriptors needed, worst case */
>  #define TXD_USE_COUNT(S)	DIV_ROUND_UP((S), IGC_MAX_DATA_PER_TXD)
> -#define DESC_NEEDED	(MAX_SKB_FRAGS + 4)
> +
> +/* Tx descriptor budget for a head and MAX_SKB_FRAGS fragments,
> + * each fitting in one data descriptor: one context descriptor,
> + * two descriptors for an optional empty frame, and two spare
> entries.
> + */
> +#define DESC_NEEDED	(MAX_SKB_FRAGS + 6)
>=20
>  struct igc_rx_buffer {
>  	union {
>=20
> base-commit: a83267db14681b3be481e02a4d5a38177507006c
> --
> 2.55.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

