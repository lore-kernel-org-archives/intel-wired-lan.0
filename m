Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F0AECC6B1A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 14 Oct 2026 10:43:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A54BA80CBD;
	Wed, 14 Oct 2026 10:43:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I3OciqIIea6y; Wed, 14 Oct 2026 10:43:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AC26F80C72
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791974598;
	b=bs1lFZrgxFC6zprrKqw4RhyJM9pOTO0AcBL+l4iEpRPMSyeuiR2TynQR4nulELxXRf4A
	 tK3Z8q7cryn+mMtsJEVQLuEW9EQ5/rTvZmFJQZzVyQ5/dPAhvP8oBK9l4X5RFM9fvlL8X
	 bNn2Ejlr1QevWidVM2DsjEDmae4A9SF0SH9//l0iym13CWx75CG78AIiqqdZJqNRP9kV5
	 6tb+cn/NhES+bIA92HBx3WJH8X2Ne41ImCji4rhorewzmZIRPigwsCTyDqQhN5Lcz73ym
	 HH2bwb8+EcTVF7jGgUELcaNWlkeTB2ynO4NFH1d2JUq3WRX2anlqTPCkrDVbGmnM2ZQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791974598;
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
	bh=Olhu+cf4cV+MjrDBWXBDnaM2q2O7HC1s7miKMOpAQHY=;
	b=OxTpAbGHFE5xGonkwafxKqXUnbbL90x31w01Kys1421Xa726yWehVOVkNoK3NcdsMIuk
	 vScK5wIggWaQ5+J1/9unR+0L3Btf4Dz22iwZBlAbOakYbUTeRAgaD1tj1c+JFcmuhv598
	 AAQVY424d9MCjeyI6Sxs4r08gxTQXYOImZ3eEgpLyIxTSZxTcDm8aLYNb1nmWCcsK59mF
	 7IGeYxQ/cn9ssnAMxWv4jBu6xluL6eQjYMvjOx0gNJY2QrUVvH99JomKziDQkicwOTXFk
	 JuuVCRGbLDMSXCKgqiCftNL/M94Umi4pGLjoIgAwa46rE6dhRlDy32hwsQaUcJm4Ycw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791974598;
	bh=Olhu+cf4cV+MjrDBWXBDnaM2q2O7HC1s7miKMOpAQHY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=frK05ejQHp5jN4F+jhWmeWtJIYQrYeYPJyx6P7tDf8Pq1bFcEFjfN6J3VomFpQHIO
	 qeS4AunWV6kaN8PVXIMYs23/+hEygdgu4bsKIiw8dAfuO94TV0w3Ep3bDlefgCUid+
	 sgMAymnJ2WpXrYXAfypoMntmk8fmZo2PpNC88+sioy/780SMzMO8FGuCZj4Afpdyoc
	 pucCscVqUFfrqvUUqNHVZ9rvJEnF2vinFT39vyJyVF96KkzCsuW9ck/JwPywsGn0Zs
	 k7XbFkpulibQjq7ZT2BWkZyXMMbT9eriJrnWTryDjhRly+R17qiKG2LzYQ0ez8iJKM
	 3dkD6vF+uBBvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC26F80C72;
	Wed, 14 Oct 2026 10:43:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4BCDC1E9
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 10:43:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3D624400E5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 10:43:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fNlNuel6JzXz for <intel-wired-lan@lists.osuosl.org>;
 Wed, 14 Oct 2026 10:43:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C141E400AA
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.14
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791974596;
 b=fzayfcSlCy3Uvbq2bbjHHEASeIqTLOgpPCNkSEW2s74Dwhhq7K3Zo1qlDk5c+Aumrq+R
 2TfVyCDDrFSPdOaCLdvvqwtopzKQHC8yy3k4ClpIVQaZUrsIdyHSzve1eInR2/8KSl0dm
 FtPGgUw6odhFSWt6tqgHjK82m5z7flSF/6O7/oUE4sojISRZjH1te+lg3+n6YwheHE/+1
 ISaWP3aBiRPflaS1ATtYmjP5Az+8YgxNwcFHb84IOLjElTPu0PoDoEG4mrAp93wESpIKf
 sLO5n3TZcUCyDUylg7j8Fpt2uDI/gvnpPIR74hOZNlZKhZPiyjxwIue8PQTES/U6++A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791974596;
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
 bh=Olhu+cf4cV+MjrDBWXBDnaM2q2O7HC1s7miKMOpAQHY=;
 b=r9YUNvbm36GJOaxuhASWeZL/lY1MNJ0GGu63hgNfTy4x/p57XywHuGzih4Bd5N6lQ1K0
 XhzhiQ813vPKIjviNUgh3kux31ryqiO50WpFyJLIRZp0dFBl15UnQlw0PEJeBeZHPdqJ/
 DrG92ab7oQE/BHJOMAKyjaPuaPUwVx2B7nKszCT+XXWnV8mES4V8+EBz5x2RJubVtgXA2
 Sxown0vEAY+LWkNc29He2pXxP4goE26fURuxXoPjj7JBNH/t/9uxxZfYSYRTK1ivomjeP
 Y67jL4ChjxZvANEv4XmCoUOZiOVJDx/TaqyiSdi1lmEyZ6t4aJ1zN9V4Ig8YXOpo8EA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CmHM0rfq; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CmHM0rfq
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C141E400AA
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 10:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791974596; x=1823510596;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2KZxssquXyr7a+7esWYBnjI6gp+b7InscUoZoB1izVc=;
 b=CmHM0rfq56CHAIrQxirymWc3sM8e+Nu2kdQIB2fyu+R98OXPgCvSx1eE
 Zgu3ydpLawUPw8wj64IYuYn6F6X0Us2/rzSGvxkj941yTcVLtJYh5bVJh
 wAV0WeojReMQVStDOXifmZwnD1WQOw+RlRxSjDlKOUe5Ld2PDbwlw/cyZ
 0PSXFE4Qyxn3UGmb5ztHye75ZktSS7NV848gJ1fxL/oc7lsHb+Z+k2Hl9
 i98aQKLpBi+3Lh1wnP4jNU207Wpzx2zCtzHF2+azgivoq+IdqQxy1CpNE
 kICMRGIyujwB4tHe9aFoi1KPRwvpH2uQuzJvKdRJmxWxQ82NkCKEBC4zh g==;
X-CSE-ConnectionGUID: GtkzVZKTTfKxmTIHL2sb7g==
X-CSE-MsgGUID: pE6r2q5sQEmej+2FxBWSgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="726945"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="726945"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 03:43:14 -0700
X-CSE-ConnectionGUID: WVAjTP1TQCmVo0aTAFR2QA==
X-CSE-MsgGUID: ZXmz2cC0Q4Ku2KbVE8LHXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1296646"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 03:43:15 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 03:43:13 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 03:43:13 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.3) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 03:43:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lge7XmNNKCU+6I/4vMnzDY2xfa6B2qTYFnzhvuIUZoZ3GsDnGUYdNx2DL4IvoRNhF7AM6EK6typwEkDVg7AFKQwKv/5NdKoLX1QHi7m6FZPm+eXCGElAUrj2KpShUxkkHxwlIumkIogab/raIzqFu4Vk+WjoWXIM7AoauBcfPmdrNqjjg/BOaFQff6qMr7WTQPjj/YXbE48Y2NqQ9cV2Ubhn90OsY5oUQzG2/4QSVqTsRChmHDh/DGgOx/GdYIhA4FGpliZ+TWE9CTqkCIl2dx2YfkDFVLo84w6d4haVxd9kotovBnCsjTL+e+zJs+hVtgzIqo0rrlKDTR/hwLBqmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Olhu+cf4cV+MjrDBWXBDnaM2q2O7HC1s7miKMOpAQHY=;
 b=MkeLUpQgi+rh6xqKcCjh5qrRSUvanX2IG3eO+y+/gtQNuoUVRegzX4xawdEABNXfzF2HseT+MT2ze/DMm8hMiv2AvH0AmB46GazhdEPqnXK2CPBY+jNsMhX9/3Mh9AlJhQg0hJbhVI+cZQ2hzooLcAoYhQp9NwBiipZWQlPyiLNgMibmEXthH/4GougNDVfoFh0aVNFkXxFoaOVlENgsYC2FcNcciZR9ompfdWTusQzwEp4CkL1masTJw22gsO+BKy2+6gtpGG27o8n4FQexIbUaEII6ex0V1KbNlRerMD1TXvLNK5aBk0gTH7HvctaByY4IJcsZY4WFzco+RLgDJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::31) by CY8PR11MB7363.namprd11.prod.outlook.com
 (2603:10b6:930:86::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 14 Oct
 2026 10:43:10 +0000
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::ac6c:1d96:c766:799f]) by DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::ac6c:1d96:c766:799f%5]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 10:43:10 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Linkui Xiao <xiaolinkui@126.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linkui Xiao
 <xiaolinkui@kylinos.cn>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH iwl-net v3 2/3] ice: detach the VF representor when
 ice_start_vfs() fails
Thread-Topic: [PATCH iwl-net v3 2/3] ice: detach the VF representor when
 ice_start_vfs() fails
Thread-Index: AQHdVyTMKWVHAgltJEyJqXS+rmtjJrb84yJg
Date: Wed, 14 Oct 2026 10:43:10 +0000
Message-ID: <DS4PPF7551E6552CD723DB1584045181831E59D2@DS4PPF7551E6552.namprd11.prod.outlook.com>
References: <20261008125754.3520773-1-xiaolinkui@126.com>
 <20261008125754.3520773-3-xiaolinkui@126.com>
In-Reply-To: <20261008125754.3520773-3-xiaolinkui@126.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF7551E6552:EE_|CY8PR11MB7363:EE_
x-ms-office365-filtering-correlation-id: 1c527136-bfc3-4362-92f8-08df29dff0f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|23010399003|6133799003|22082099003|10067099003|38070700021|56012099006|18002099003|921020|261009223027099003|11063799006|4143699003|5023799004;
x-microsoft-antispam-message-info: HN09RtZikTqY7qU974BF667/Y4eydG3tATPapATNA42CBCEKleZSyrZOmIDHo9RydiUMCQL02FWHyBnyf74QRynRdyMw9AwNfQvKkmp1qhQP/OOkYgTCjpHzdnhrkOff7OH45XNG31yJx8exSCzKOBVi5m0P3XuCphyw5hx9Sne42j4kMNw0ZPZ73iusFVjkMcZHtqF3ft5fkZv2WvxB8HFnCPb/3+AgJvZL0D0xIY745L9YhdXgs+LqdncILRBf8FRcZMMfjSGX7VqCXsq2Hfb9KNUMR0viaJzdc4vqHsF/YhOpCYkEwEekHrclyyhATqCvpzEOHDlZNCvTIB5EFroAW1YnyHstfbUjLZSWp2SrShkh4Ec19iKX60UWF9PiErxQnE+PKWksSLLzzIzcvKota4QZW41qjtrDzbpkPabiGVC7t/sQP8QuyWNABsxDsnrPIeLXGj5UAWloqmh391hHockrExUQ95BffWRwNkjYLyrdrow1fg8x/7EwNf3kdfn85H5bJzwEotLFsfSqot0Nao7XcH5OLpYhAmtc2iYdiV/9AOFL0BNvDjMGmF+wuKqGsH9fJNpxmudTFyFMVIgjlGFkhuYq61wTPOSNayTVIswowkjG9jxEMRceT3kEFeZr72xiql+evke4O4P6QGyvVx+zHZOmonSw3qt0U8ZwOYP4f5k5x6TMiZkAoSmTNLDsXNFAx7NoYNDIkdddcOvFs41YbpRriErultDdTPTWI4lQYyVim/aHl0Gv8JcH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF7551E6552.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(6133799003)(22082099003)(10067099003)(38070700021)(56012099006)(18002099003)(921020)(261009223027099003)(11063799006)(4143699003)(5023799004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?juj0t8/YkeqVhkhk24xJAREb/oA4DiQqmggN4iuFOd2ar5ALtSMi+zGl9sue?=
 =?us-ascii?Q?r4PazNpzKZCsDWYNa9s2QIScFI9ffnHerhlK20u3LTU8Smi/1Kmg7RAO7Yzm?=
 =?us-ascii?Q?hviSyVMaMMyhfYT3SqQmFiQszcnoHkH8I+yl2mHNEY0sf2A75vqrgq3SGpS3?=
 =?us-ascii?Q?FNrW4Gw2yWzixilY/jF62P85rWfyGl33D4l3L+mWyug/FPkkz0v0Ve8PGz8o?=
 =?us-ascii?Q?KeXlWD5DbRweOitxc9YqKXdLcQnq0OKVnv01ecWFwkj9uhE0zCt58FI1+eS+?=
 =?us-ascii?Q?HpyRBPy04qIuzU9m/oER0OgbpHbePY84toxxlCe/mk9qMyh8BVwZAAXIkA3l?=
 =?us-ascii?Q?1pOqLstBBPSHoAHiXNwjO6rkNoKTVN4FJiFsZDa8u9QrqqW9rQdrb2Tfbi7d?=
 =?us-ascii?Q?XXhpDDA2CBMGQ8VqDT4XiSOaOoniZiEj2FdmAlYcnSsEjCY03YoZjvzhoSx1?=
 =?us-ascii?Q?Jx5OS/3JLcMyFSHmD3aWBm9mgI6hD/0zwLd6yCARdrL6ItTD+zZyIuguqYLC?=
 =?us-ascii?Q?fHwiBCBQHmpt0BWsOUGHbPg0h4KwCcAqWj2o9CXWu2i13K/P4sQlRoie5iCQ?=
 =?us-ascii?Q?v3g/dRpT1TSV4JNf0w9OCnxuArdpQcX1DHX9rRNEO4JjG4ZFp908H6fHY7z6?=
 =?us-ascii?Q?yiXJAV1b8dk8eE9bQHkh+s1iE+QthqU7AUuKNPr0MwsY2Aws7eKcy5mQ7/6o?=
 =?us-ascii?Q?pFttA6QOXM+G4jFcXqtgqe/F7uA19m03EbIsvqdOzzjPm6sqerkFJ09NNw0A?=
 =?us-ascii?Q?dBK1kRmof3GCuUaTHy7/NHGeHYHD5k3UQPVY86580C8Y59Fk9mJFYn/0gc7n?=
 =?us-ascii?Q?KEBuwRTwGNuRD12j7EFpXGCgfcDIF/UCUikSwPFGL2jgNPTXB4bq8bRskci6?=
 =?us-ascii?Q?CFdon+VfWR8a+uxqL9Rjlxv7Vc3aVopd+ntbXFcipaAIrmsOgtqBE77PKSRS?=
 =?us-ascii?Q?70xdhPVzRIbd/tIqizFQJan6rXwojcDUE3lYGIpsoAOE7jddWK6yH0OsoTXa?=
 =?us-ascii?Q?/01ibzrPv6nk+EpO3pU4l7D9YccessvrxWKkasXFQnu6hp7MpGT9oBRumQ8r?=
 =?us-ascii?Q?8j8aZooilhcb0qy1ECUShDVDaqHB1ak3ZO5WpjyUxdGLpkUYkPym2KFFIL8L?=
 =?us-ascii?Q?rermhrXJRpQ6Y8PZGqv5X5L4thrM+bIs4xVAmT+5K5E/W+xACLvBowrYfD+A?=
 =?us-ascii?Q?K4370EgFUtYS18/CYKfDXX09Y2eWErpbzUD7sBa68D441NXy5/X/JsRnTWde?=
 =?us-ascii?Q?VAX7POCn8Ms2WJMQwnyM3Vb+OYJQLa5F0eCX13n2kZk131Vlpw7Iix9l6Nsa?=
 =?us-ascii?Q?BLJIDxkW9AgojhjjnStF+QrrMw+9Cxfk+46cua58Az2/ys9/r1aMNcYzVkSF?=
 =?us-ascii?Q?U89kU5m+Rqfe1thFPI/ZtH0lIBLKgpkhDay7Pxv974+ms3sHAvB1Ye+V9Uui?=
 =?us-ascii?Q?pXtflyHLM1c8DhhFGO/LqyPgJzu9wDZzIGrqOxvYC5yB2VuIE8Iv53X9Daq+?=
 =?us-ascii?Q?ylpn3c+QNtPxHbyBe+EDNby9OYKyt9XZH2nfK2YWDKa7cAKbaQaP6/c4mS4C?=
 =?us-ascii?Q?pb+yACFxzH33AtsEkZlbz/tmZdcoo0lwRpp0PFZ91m7PprOnGklhwPwpDUsp?=
 =?us-ascii?Q?lCGfU48ho0XeAHjFbRKCmq8QwI9vdDF4oBbi1S1BiyJOS1ewsM+NiI3mUBGU?=
 =?us-ascii?Q?9qA3NV6WuXzDhwt6dncEcB2z3p/h8EC38qbTb8h1S9iK9PnnujdzB4chC6tw?=
 =?us-ascii?Q?A95yAtG7IHEFhNXVX2FiRac/AS/z0JQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mvtEoPJOObdkYtKr7kr9Pi7faXT6HH3jlPoh8RQ/4qL0+cv1oiZ5LXhCkw3SwRiofS8Tf9pJPmgKEr/pz97IqEUX8KiSigWToMBG5pJrv9PzV8yzVugMMGz9SfDIHJjXlavL66tze+3IMPK8IezsdsNtdjdOTf1KFzJcutxEuuDXcDB3hENHJbaNsL6LMQdlgsVYYjKLVjDjLVKosuQ+kmdwPUD16UESf4ateEmZKOlVLJqWhToKDJsOSQpCy00i1B40et5cYOjpPmKmQPIDA62Xs76jCj0O+9iukQ+GKhNlQCDXiXvdiIc6yzKwrdRiwCmeyk/FhRmunVREQqRobA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF7551E6552.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c527136-bfc3-4362-92f8-08df29dff0f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 10:43:10.6659 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R49i5tWul4JUD2LqmG+OJ6iR6D5uG8UqJP1dFlDxf0hqLgOEc7u6BuCOO9icLC1VlkIqMLS93CzbiyRwA6e2sDvv4JNuWtlaKHKoM0ZDRUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7363
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
> From: Linkui Xiao <xiaolinkui@126.com>
> Sent: Thursday, October 8, 2026 2:58 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Linkui Xiao <xiaolinkui@kylinos.cn>;
> stable@vger.kernel.org
> Subject: [PATCH iwl-net v3 2/3] ice: detach the VF representor when
> ice_start_vfs() fails
>=20
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>=20
> ice_start_vfs() attaches every VF it brings up to the eswitch with
> ice_eswitch_attach_vf(), but the teardown path only undoes the queue
> mappings and the VF VSI. Nothing calls ice_eswitch_detach_vf() for the
> VFs that were attached before the failure, and the caller,
> ice_ena_vfs(), goes straight to ice_free_vf_entries(), which drops the
> last reference on every VF.
>=20
> The port representors created for those VFs therefore outlive the failed
> VF creation:
>=20
>   - the representor netdev stays registered and its devlink port stays
>     allocated, so both leak;
>=20
>   - repr->vf keeps pointing at the struct ice_vf that ice_put_vf() has
>     just freed through ice_sriov_free_vf(), and repr->src_vsi keeps
>     pointing at the VF VSI that ice_vf_vsi_release() tore down, so any
>     later use of a leftover netdev, for example
>     ice_eswitch_stop_all_tx_queues() walking pf->eswitch.reprs during a
>     PF reset, dereferences freed memory;
>=20
>   - the virtchnl ops of that VF, which ice_repr_add_vf() replaced with
>     ice_virtchnl_set_repr_ops(), are never handed back to
>     ice_virtchnl_set_dflt_ops();
>=20
>   - pf->eswitch.reprs never becomes empty, so ice_eswitch_detach()
>     never calls ice_eswitch_disable_switchdev().
>     pf->eswitch.is_running stays true with the bridge offloads and the
>     devlink rate topology still up, and ice_eswitch_release_env() is
>     skipped, leaving the uplink VSI in the switchdev configuration that
>     ice_eswitch_setup_env() gave it: local loopback enabled, Rx
>     filtering disabled and the default VSI steering removed.
>=20
> Detach the representor in the teardown loop the way ice_free_vfs() does,
> ahead of ice_vf_vsi_release(), because ice_repr_rem_vf() and
> ice_eswitch_release_repr() both need repr->src_vsi to still be valid.
> Every VF the teardown loop walks completed ice_eswitch_attach_vf()
> successfully, and ice_eswitch_detach_vf() already returns early for a VF
> without a representor, so no extra condition is needed.
>=20
> The detach runs outside of vf->cfg_lock, the way the previous patch
> leaves it in ice_free_vfs() and ice_reset_all_vfs(): taking the devlink
> instance lock and then RTNL under cfg_lock is the wrong way round
> against the ndo_set_vf_mac(), ndo_set_vf_vlan() and representor ethtool
> reset paths. The rest of the loop body still runs under cfg_lock, as in
> ice_free_vfs().
>=20
> The VF is marked disabled first, because nothing else keeps a reset away
> here. ICE_VF_DIS in pf->state is only set once ice_ena_vfs() succeeds,
> and ice_sriov_configure() runs under the PCI device lock rather than
> RTNL, so ICE_VF_STATE_DIS is what makes
> ice_check_vf_ready_for_cfg() reject __ice_set_vf_mac() and
> ice_set_vf_port_vlan(). Setting it under cfg_lock also waits out an
> ice_reset_vf() that is already running, which would otherwise reach
> ice_eswitch_update_repr() on a destroyed representor.
> ice_vc_process_vf_msg() tests the same bit before it reads
> vf->virtchnl_ops, which ice_repr_rem_vf() restores.
>=20
> Found by code inspection of the VF setup and teardown error paths. It
> was not triggered and no stack trace or error message was observed.
> Compile-tested only, not run on hardware.
>=20
> Fixes: fff292b47ac1 ("ice: add VF representors one by one")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
> Changes in v3:
> - Detach the representor outside vf->cfg_lock instead of under it, as
> Przemek
>   suggested, and mark the VF disabled under cfg_lock before the detach
> so that
>   an ice_reset_vf() that is already past its own readiness check cannot
> reach
>   ice_eswitch_update_repr() while the representor goes away.
>   (Przemek Kitszel, Sashiko AI review)
> - Include how the issue was found, that it has not been triggered, and
> that the
>   change is compile tested only, as netdev-bot asked for.
> - Not carrying over the Reviewed-by tags from Tomasz Lichwala and
>   Aleksandr Loktionov, as the code changed after their reviews.
>  drivers/net/ethernet/intel/ice/ice_sriov.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
> b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index 471c1e29a865..470aec8849b6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -520,8 +520,27 @@ static int ice_start_vfs(struct ice_pf *pf)
>  		if (it_cnt =3D=3D 0)
>  			break;
>=20
> +		/* Mark the VF disabled before its representor and its VSI
> go
> +		 * away, the way ice_free_vfs() does, and take cfg_lock
> +		 * around it to wait out an ice_reset_vf() already in
> +		 * progress. pf->state has no ICE_VF_DIS on this path and
> the
> +		 * loop leaves ICE_VF_STATE_INIT set, so without the bit a
> +		 * concurrent ice_reset_vf() would pass
> ice_is_vf_disabled()
> +		 * and reach ice_eswitch_update_repr() on a destroyed
> +		 * representor, or trip WARN_ON(!vsi) in
> ice_dis_vf_mappings().
> +		 */
> +		mutex_lock(&vf->cfg_lock);
> +		set_bit(ICE_VF_STATE_DIS, vf->vf_states);
> +		mutex_unlock(&vf->cfg_lock);
> +
> +		/* detach outside of cfg_lock, see ice_free_vfs() */
> +		ice_eswitch_detach_vf(pf, vf);
> +
> +		mutex_lock(&vf->cfg_lock);
>  		ice_dis_vf_mappings(vf);
>  		ice_vf_vsi_release(vf);
> +		mutex_unlock(&vf->cfg_lock);
> +
>  		it_cnt--;
>  	}
>=20
> --
> 2.25.1


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

