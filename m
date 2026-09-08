Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921F2C79F82
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 13:06:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B21840555;
	Tue,  8 Sep 2026 13:06:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HmD57BuSLdin; Tue,  8 Sep 2026 13:06:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AB8BE40562
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788872814;
	b=iBu8YLt4WoN5jO40U8WCLvs3LPfDFY/4Gf4Rd1E7eTVAHZCA6k50yjV9MooSyOrlApGF
	 9U8zHh7HuvBisvuHGX0hSGLDk4PQa1l0XbZdgJhVNxVJDlu6EY86KPCaOygXjuvCtEQu9
	 TYRGqD7zeRJJJEofBg3c4pgWXwXeHfQkacPmyLFf4r+jSdxsRMAGqho7TvSjnjgcb3s3m
	 vN2usgCqgJcXmhLDLxOJ2vpc125/U8Oi7JeZ6R82cvaGWTe0PPgtLo6geld1COGJvLBa3
	 IkP/VFkQ5fvXci2J6EGcYbhsqwXmXMm50xULFlHO/fiDwq+0t8a0pozeeFf9+KYE6Zg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788872814;
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
	bh=2+29w+Xp5dlmUPEc4G9xvuWp2Aq91WSgErAUU8ECbcg=;
	b=Bavpu6fEEDZ534bTkmlG3tvqBmbUMXsDym0mjIWk9koZEceYsr8MPiv/upk/KVPf7l6O
	 weG9St/Z4WRg/Q40rJYQhJ2Jk2YCYt1xAGeosTJlAQU0P0Ava6ixyfNOmsn3ft5CPn6Vt
	 QNLBYI0cGrWpdPp/k8ENpyCOmDVYlD/T4LvsHULOVbFCcgCN0QriZc9WZJ9+uMjygcj1g
	 aLnAtjhvdKdM5oZ4BBSxm8d63ppOUEFN3zqH0DnN75owNY8cpo7IUH0KTe8IvHYdlYvPf
	 mPRjYLtX890S2H3u8JWelw2aoMRBpUffconpQUyiBMuI3355Wa0HvAN0l8Wga6QlXIg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Xa0aVyGs;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788872814;
	bh=2+29w+Xp5dlmUPEc4G9xvuWp2Aq91WSgErAUU8ECbcg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m7eyBrmKjssnxQnhVvKZAEJ3LRGuuy+u3xlghIlD0VAJaSnIWTR68Nn6lvSqwHttV
	 EmuF7PUcpopQ3i9d60e97x2bAH3Kyo1QjrJozVvI2Kzam8uRVApfHpBTYRaTMUv8b4
	 QqVURKnTs923eLE4LZMBl0AuZjmhOUm7XoMfTMNQ+NQu3lVIOpUdR1IjLlKZWqBcRP
	 sfzh9gfS9fy72AnAcf6xmG8pA+7svLhzt4Klzw85S75iKcsV2sf/hxrfheZwB2NZCy
	 WFB3ApZdxKYuWUBx0+cRdpqOtWt3I35KSTS4LbThdZmAA1QFQjsD31rcRIkNv6wRII
	 gWzJ/m70Yxr2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB8BE40562;
	Tue,  8 Sep 2026 13:06:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E75A0372
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 13:06:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CD3B940562
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 13:06:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZWoqTRtdLZtQ for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 13:06:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F30E640555
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.16
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788872812;
 b=PSjNQQX0p0uUAu1y2tWRk+d4YmPoGLaO52LMjf8OtGGdzH9qAUligPN96ZxUn6n5ySOs
 10HvCke+crWX6rTT50P8L4qNhwfQIxH6INKEBmbIi8n5JgPP+iRHbjI83XUbMTEMO7By8
 YySTyMWX0fwGAkdzWcn5uPr2BJfIxhVR0wiw9mMQwVEnSzb1yZ8uu8ekO5CJ6EwdZFL7G
 ZaN+9AF4fHoTXwvEVZUXkRpYKEpvhdeJQPVZdHWoR+lhtLu29gd+hrps03gFdc/Dvz03X
 PNPKYUBGMpgu1JwxoECpVdRjfCM3SPumy3P7kiEoUZlQWq7yOEA7CkE9swsDJ+7bzCA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788872812;
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
 bh=2+29w+Xp5dlmUPEc4G9xvuWp2Aq91WSgErAUU8ECbcg=;
 b=UajVdaeaAJQr0tVa7VO/F6/vSfTb2Mb/vAhh7wXbhvBT5zpaWr1HC2J07MYnaXuslvi1
 h45MAk7eWlKdZ4I+rmEksKPWAaVTV2r4Sn29zY2DvU6AbmmQXarI1t8wqpgvESM8tuq8T
 GSazLeIx4xchIsYun67v5LnMBArqxaFkRNtOfRmpm4nw7uGek2JssTzkZHIwWVcRspqSM
 jo0n0vMcFSox7ftPeYOTUA9cZBrZ5hVSYFddDtk61fxz5TAtgOVR6jSy41n48mh21W25w
 46AeVmtTCRtPG02P4rhvEYc5wuEa05xxydkGNBCVh3wdK2Jz7++YOrs6EwxQU/klRZA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Xa0aVyGs; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Xa0aVyGs
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F30E640555
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 13:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788872813; x=1820408813;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BOGusANBKpJNd/yHySPYHqFAiyL4wRFtL/L3t4yGBd4=;
 b=Xa0aVyGsYmbXVLzJauCVST29vdsFGX0mE5PKEctW2Mhg/VOBAb/TLYtA
 mTzmK94jza/9cpZ7WNOuxHarPB0okZshjB6kwEplvuYHEKmdR3k4+G5o3
 Zz2O87p6KH6dHroLGWwaA6O+4DNN7Oa62o46dlLa6h0osp5kdELM/yGox
 Ol7ITRXRVNKemO+0x/kn3zxDSJSeOFgcLoSIngzySZa3caJIqcJ5wGV8r
 rawh1CqEUndfZORgz4zdeR3xuxblmtvGp7HaMt6diJdnCNN084WDj8HvG
 VrexHAVkms2XYj6EFSDRskEayiqd3o+6GVanL4/qfGEWRRFnuJoses5hf A==;
X-CSE-ConnectionGUID: xeaOfa+mQMiyOmJ/9UpTzw==
X-CSE-MsgGUID: iVvuAHfWRjukFOmaZqJlfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89477440"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="89477440"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 06:06:51 -0700
X-CSE-ConnectionGUID: 6EK4utzRTgCTwBJhNGbuNA==
X-CSE-MsgGUID: zVxU2Oh9SvGyLmwEIUXhpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="268421744"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 06:06:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:06:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 06:06:49 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.6) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:06:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTW9UU5SCdUuB1Z6RAqVH1163TzIlZEA8lSi9RQ5QzSimDr4OKpK+CNYKATNtZXF705b+ZD1oo9Cw0H5fye407tKCkrzF5iPoauRvhkGYIblAGG8KCVuZImcUphIECwcoDtpy/Z/8VGDD6ERVkkDT6KK+RceWI7VLDpL/EOoTyEASuE6vvJ9lZ1f1sNT23hBI9cni5yxJH9p9x/Krfq4ATHNv84uXAMtzpFVgb3ujMOLBg72jMeqt82A2g4IZHhoxF4tUCVu4km6Lx3p4AbMQkMokS/OF2qekCEWc7qpUmcfUwx8tTkmrkd1HJ/W6x7trUat0mpXYQ/coL8m+Eq4/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+29w+Xp5dlmUPEc4G9xvuWp2Aq91WSgErAUU8ECbcg=;
 b=ALt5csFM+Poqo3JayiJaOUmS4+9kFTmFVh0Zp6m1VV2pZHvPAbJr18qwy5OZsd7MlvcMUewBdGhc7OgbfvSktLYYx4no45DnJxUpDTHDByUAFNNdVjC2pHaI2mA37Eh++K2cjiFl2/akIgU0aQRYTltOtLOgxslCZ0o9GhjU6VYL7hH+DRIpVYBKdLGUFfHnk5qH/i8fFwHmKgou3btMieNoJueNu/SSskmsxkqJnuBA5Udz6fiHm+4lsb79a4qSvBu/4M6HPTlxFIzco9UjNKjA17NaYn1vigDPzLfh1ZwuKKjwBEmgAr7ZlwmVxs2CM2yitX4LgafGGm5lvk3Hgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH0PR11MB7658.namprd11.prod.outlook.com (2603:10b6:510:28d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 13:06:42 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 13:06:42 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Yury Norov <yury.norov@gmail.com>, Andrew Lunn <andrew@lunn.ch>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "Raju
 Rangoju" <Raju.Rangoju@amd.com>, Prashanth Kumar K R
 <PrashanthKumar.K.R@amd.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Jian Shen <shenjian15@huawei.com>, Jijie Shao
 <shaojijie@huawei.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "linux-usb@vger.kernel.org"
 <linux-usb@vger.kernel.org>
CC: Yury Norov <ynorov@nvidia.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [PATCH 5/9] net: phy: use linkmode_and() return value in
 genphy_c45_eee_is_active()
Thread-Topic: [PATCH 5/9] net: phy: use linkmode_and() return value in
 genphy_c45_eee_is_active()
Thread-Index: AQHdPxOOKP7awvuPKE+65LoRWVZ3MbbEp5Tg
Date: Tue, 8 Sep 2026 13:06:42 +0000
Message-ID: <IA3PR11MB898613F5D45F86B1170A224FE5B12@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260907215439.409858-1-ynorov@nvidia.com>
 <20260907215439.409858-6-ynorov@nvidia.com>
In-Reply-To: <20260907215439.409858-6-ynorov@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH0PR11MB7658:EE_
x-ms-office365-filtering-correlation-id: 2e2112bd-8f6a-411e-cad2-08df0daa0739
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|1800799024|921020|22082099003|18002099003|38070700021|56012099006|11063799006|4143699003|10067099003;
x-microsoft-antispam-message-info: 16cIJf9o6ONeGKHrZiJKa+h8JESFKQzGzsNgb8sqUWllVJUsKGMZHkavE44Mw6rMjC5iBHc20to8SsaYnJUW7BKOHqFbVLZwVH1RUZmLi0zEDfdDNb3xQyHDVo10U/iYcybF3zzZLos5nJnduzjjtIYY+l5W0myUVdQ2EE+qfMpr/vOqWKta/AXO7iXy399+OmA5fO8ZVSPCVAj7MlbmtlPkasuCo9xwvFuifQnO3qAUZdjWtkwnxW3HL1654CrlOcZLM040uUQwkiwcbW0ePQVs/vkhH6FcNvdnBPCfB93gl5S1yHDETi7TMfnUikKZKxaUViKphs4EB8XByY86F34cG6ixA53jbnVm+4yG5aSPF23zpSiXlU7KNSkB81Hibbwl+++nHhonbg2oW1D2gGNm3Jc+s2HaF2jvambO6YtwUfTLSOTvaTO9IcK2LXhaPgRMZkcxVvDoyAyDgg4ZU73G2efIyL4nn0K/f8cCUA5ZKEEeokN0QhrD579oPKwbPumYxCwjDW3Apvaq5aK1wBoDGbIGKktyoI16no9jvHUq8RnZ1P1FLHasRXtZTQhyeffST2zA9c/VeFlrQdG5vd0w72Jita7AR3rNA+bVnWvr6gQu1zAbiogBCZ1EUPm6AlC6ZTdJPflwSzgTnEKjbPn8yBR//Wxx7F/+hxHz3AmOlJvH4TvsCxT2OO5MApBJYgogAQIiqde2rKkmDMPPK4nktxUhHppL2jfve3wd2gk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(921020)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1Dvsl3XQ5FYRKYklrzeIVXswq/hbT9SDuH8Ti1/rTZ55MnEvH0qtlU0515xs?=
 =?us-ascii?Q?EeQHKIVP8DzBT/efASDRe9SOky3+/OwNeto48keNWufvKIQGB6g2sfXdtTwc?=
 =?us-ascii?Q?Tje2w3uj1CjjgTk7zx54lfwyS0nVUTD0E9gq0Hlx47xBZ4G334vgZh8mQXBq?=
 =?us-ascii?Q?Z3BoSeO/KOWhBRMjy2aU/+j2RyrRC0QLfeALq0JMnni7495gpIK4pgCsuCkm?=
 =?us-ascii?Q?HRyhgvAZH2WYnAKebAz9VzSs9jXV9pDhcPkUoIMXnUmdmRyR1oxVGVL6p8Hu?=
 =?us-ascii?Q?XjGT/MuHLb9b8T3FG5AL1eIDSyxT1jjkvoaVXNZwzT83x3YfXaReVms8iLyw?=
 =?us-ascii?Q?H0NTIRmcCvno3LoHZkIl59VfKgw4PszcAsOOs1KneNUaLfo5Pa8L1hetLKFL?=
 =?us-ascii?Q?ztt1cEXkcuuK/DZPAb4/w4xqdYuvuVHHzXp1FUh4Kz9IPos6PzWIjIs3rP1e?=
 =?us-ascii?Q?R4PXVmHKmTUJU+P0b5Redc4pSloJxtZ1qbeoYoOG0GgnGFCYZ/3hoZSMwN+b?=
 =?us-ascii?Q?q0gSbOv2ElHZWfiwSYAiR4T6HiHo+9w6HnqjX/4zGwmuyUKwJrC9ixlQz9U+?=
 =?us-ascii?Q?oAql9MSFflXGh61+oK0VBK6EhYdr0k1cbCG6MG1nEPLUyoBR+dQJC8oh2oCB?=
 =?us-ascii?Q?JAVhQSvMTXb+EEnZCYTgquUoxqF6nuyF4RfioTBJgxMgu90k+xrHk3q7lp0A?=
 =?us-ascii?Q?w4JsQfATyhVAfflRKMtLJsUBZcMpNKHHVEul/AkmRmenwXr+NbLI6Ks2JC5Q?=
 =?us-ascii?Q?BC6i0FGXNKP225J9JgnIVi1Y3NWXW1zRBFIi86wP5XiPpH8ZkNZfVSh2ngHW?=
 =?us-ascii?Q?KlFEvBjV3eIYUYUwI79L9T4+1HTycF21cGv33w7D95EWYjmYkAH0aQh5U2yv?=
 =?us-ascii?Q?P5+DLJa7YpnDWW+J42dKCVdDLPdozmklofyq3AB+4vzo8um+YutJNi8IbWL/?=
 =?us-ascii?Q?h3qhY4Rdq+9BWkx9WbdBlQNB6V3iEEdCUfDVEA4NIOP8DrDZdIzfoNZWyxWw?=
 =?us-ascii?Q?AV3Deh0aJWdbZaifMinFwxryQ8T6hljRk5TAli1eoMo0/ESMhv4UuX5g7POL?=
 =?us-ascii?Q?T1t4ElRrXYUUscdpU/RmWaK85RefmAC7m7qtrMIcaAdTuYtebmOhubLfXg32?=
 =?us-ascii?Q?XpOcj/Knlv9cdTISyHtS/uel2UrVCbOGQngr7jkdUFPDY3qQsUGSyw5h6edT?=
 =?us-ascii?Q?Eaup5e7mdFSktSN86Xi2ed3k196jAgXSAjsPUlc2vlcZBbKluedjfQBJO7F4?=
 =?us-ascii?Q?Tp/DsRWjoKmN3FnplrURIjYmxz7qJ7JE/2edD+jYp6tYJaWJo2W9Gg3jXdwk?=
 =?us-ascii?Q?xBzC0qF2zKa8FGQa4iHtEKnW+2gd+Wf7Cd84TUgqQGmyk9qvPWEN73AMDx58?=
 =?us-ascii?Q?g6fXMMfeW8DYDHtXIxSd5KLY6mw7PVWrhKI0Bh7TMFYz43NTGEKlgjRrR0Me?=
 =?us-ascii?Q?TSghxnLJL8TR4OQPbUgMTziXr+Gc78AmS5vsr5VjJrswSkCUnonf9s7l4hu1?=
 =?us-ascii?Q?vj9DCZ+N9LIENBHI/jlKYNVb5WLwO/2e7NPRnTtcejtucnBV7/nJcVCmPiZJ?=
 =?us-ascii?Q?lxNrpj8tt1B+FBVXZ8mxb1t9bgER9+icgTC5kAaaznT5jSF7CuqJqRZT/aVp?=
 =?us-ascii?Q?sSX9P8CDvhCPHJFIMF1m2At4hwQFhET3LqJfVup45I5AaSlJ4eJKT82jv6q0?=
 =?us-ascii?Q?BOBUA2cGwWrAdw3dN/w/MiM91XXALg9XxudCrj33GC10xKPD6E+yLMnAzYR+?=
 =?us-ascii?Q?QfoHRZoWtDoX7e4l6UV17i/JvbCju90=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NpL3j5amxyqN1OQgs1FOp+pilVrk93P6JLgfYi+DSTNvHT0lnc1V4olmRZOSVmgDSKwQTYuDlAp0cBIa2bYsUnxIPejaHSwXaqMjUK2zDrbkjTEnGf9UzMnDkhb+NdwfzKC174XvGNVM61i/F1g6TZ2qZcR2klxiszpSI2hkMHVymvKk31warKaOKYtjqH3t/uhu3j245s9dX2rsq1WxkMy9mGjTBDadiKB5a0DqEtffbbV0CZq5ffABoEy/E6sRXL6w7AtEQ/pJONqb7S2Id/VdM0lhKWIze1Y0JZj92dZgYXHlYw+HPMnltLJoxU+59f5g6Mi9zJL4YeiGKHiKDA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e2112bd-8f6a-411e-cad2-08df0daa0739
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 13:06:42.5920 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 57vPXO2nq6FbbDWskYov79VRBvSNw8KIpYnGS/+s3IU63itgUxjAseFMsvEOFakSWxiXb9MbcuIbCRXVpHZ5XV+tuKtygrxpvqWYuFNn5yQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7658
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
> From: Yury Norov <yury.norov@gmail.com>
> Sent: Monday, September 7, 2026 11:55 PM
> To: Andrew Lunn <andrew@lunn.ch>; Heiner Kallweit
> <hkallweit1@gmail.com>; Russell King <linux@armlinux.org.uk>; Raju
> Rangoju <Raju.Rangoju@amd.com>; Prashanth Kumar K R
> <PrashanthKumar.K.R@amd.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Jian Shen <shenjian15@huawei.com>;
> Jijie Shao <shaojijie@huawei.com>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; linux-
> kernel@vger.kernel.org; netdev@vger.kernel.org; intel-wired-
> lan@lists.osuosl.org; linux-usb@vger.kernel.org
> Cc: Yury Norov <ynorov@nvidia.com>; Yury Norov <yury.norov@gmail.com>;
> Rasmus Villemoes <linux@rasmusvillemoes.dk>; Andrew Morton
> <akpm@linux-foundation.org>
> Subject: [PATCH 5/9] net: phy: use linkmode_and() return value in
> genphy_c45_eee_is_active()
>=20
> Use the return value of linkmode_and() to detect an empty set of
> common EEE modes and get rid of a separate linkmode_empty() call.
>=20
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  drivers/net/phy/phy-c45.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
> index 870920311f9a..27da1b9ddbc5 100644
> --- a/drivers/net/phy/phy-c45.c
> +++ b/drivers/net/phy/phy-c45.c
> @@ -1623,8 +1623,7 @@ int genphy_c45_eee_is_active(struct phy_device
> *phydev, unsigned long *lp)
>  	if (lp)
>  		linkmode_copy(lp, tmp_lp);
>=20
> -	linkmode_and(common, phydev->advertising_eee, tmp_lp);
> -	if (linkmode_empty(common))
> +	if (!linkmode_and(common, phydev->advertising_eee, tmp_lp))
>  		return 0;
>=20
>  	return phy_check_valid(phydev->speed, phydev->duplex, common);
> --
> 2.53.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
