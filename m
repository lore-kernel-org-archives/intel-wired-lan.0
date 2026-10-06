Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27F1CA5FFC
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 08:26:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0EAE80AB5;
	Tue,  6 Oct 2026 08:26:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id euEz4QD5NPOo; Tue,  6 Oct 2026 08:26:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 55B4D80AF5
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791275171;
	b=m0J4x+edTLM4jt+5DcjYjuOhRRHCOvQNzhsVEywwDUOprotaqk67lAypA5wzp4QGLzre
	 iIPjMtW5fGQdKytGJhYT447VIZXXNbpBX8B7jrF7b2r8pWh4DDlHa046vowBm2sx2YygH
	 eiYtwrPDtWC3RQ98f2tBbPd9HNSkrC/d7vzoB+e3RaAqNFN9WSdM6MW2KyzVyAQoU0IqT
	 +rEUld3F7pyIXbEbdlMmluNESx0m6uxtcUkD2hkQBP9SLj3D7KQ3qUaXF636eEq+BN2uf
	 IGyJZCl/t2Iw8jWsqPrHU5jGIeniefcgfqwfcL14q8O+rStjnPetCeSVYmJNE6Be4AA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791275171;
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
	bh=+cc93ndqoLtgTp8u6+ZT167PEK/KSudyX8R4maJESJo=;
	b=mxqWjkZffaX3x6EmSWhdBazQUQoMiqmT3rwsV2DkwSquUz2ecY1vY8t+wXzCHTZlrrLM
	 DKsiS3X9gHwudpx5ewrh33la2TxAE/GXKMGwYLw14NVTBPZzZReKZH54EQ1/Lsz/Do+bS
	 CMRf12JhaN8uG/RzKjTi41O5uph+iwPeTL7rmYuK0kpIbd5Xja/AxDxk4SI8PXlfnFqz8
	 dTP5bGvS1v34W31ut0A+R2NmXpDsFPl6/zN4jQpf504g4Jog19vP6gZbo1glHqN8BFY5L
	 7WzPwE7E9MRelVWmYOI/Kp6FNZMhFxFsp2kk3lJdRlw3iW4VhfYMwltUBII50yl5Xfw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791275171;
	bh=+cc93ndqoLtgTp8u6+ZT167PEK/KSudyX8R4maJESJo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iduQYml7MV3NAnd6+8VwqU3o+NZLUvvHxK928x9Som/Vcu3/ibgkL7MX5x3UBQ/PT
	 uCGW/fNJ7zj3705sIvuNIPpdinRZZODtxHE8+zv3J2EYuhefvvOEG80/ILodblXZ0U
	 /43EgEGwP92Hbj8Dn3BxsrYWxAGRuezJ9kfeiNCeFJOIrjCZrZ7nzqjOF8hvJtkHRS
	 IYqV9T2sFOQPUBgwN1b6/0DoOVOUxECQn8fwu2SHqnj4bIPjf1ne26kXI+LQpxHROG
	 pT56gQqeiRj2z4g+nkv1UMR8hUHqCK6UkRJzJZ67Hbnu16pGBNqVEDxW4QrWMUdq+I
	 /gdm42ixxmlcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55B4D80AF5;
	Tue,  6 Oct 2026 08:26:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9BC96338
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 08:07:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 817794056C
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 08:07:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NvMu5NplhhCD for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 08:07:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4D51840563
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.20
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791274025;
 b=EQbPHbNUZzZyOH0iCA88cjhoD3AEJnWA/xTZnHVkFMEQf6VkGLU/bDJ7qyGmg8v5VvTn
 shFKFMoU6RrRsPv7JFIV1IY8Y3b9zQddyBFI1ARc9ccwB6AEdvI5xzX9yHi5XlWqbW+V4
 Dt9LMwNztmCRliWoPWcKuYeLizwTY5bcMSZF811zboIJ3zTqUwik0hbiR4SQ+3X6BSQ4g
 E602ekmAjNhiU7wPMlPYGnIjUoZlwbyMxq0Q7CDMW3IJzzfYjAbIqEBmtRMtb0kecrztb
 2OOVmkVxlibgw2CcZxnQyBV/tljJgGfdBt3+wbW7vXHtbaieM7/zHwHCOYUz9N9TKjg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791274025;
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
 bh=+cc93ndqoLtgTp8u6+ZT167PEK/KSudyX8R4maJESJo=;
 b=KC7jr8Cb1pANQYK86bwvpUAYhUuQFSnYUc0tiMSk65rDLuMIPsNBmArV908reuLpW1iY
 3PsxmvIXToKqNOY5E2/DqGl/q07xskZXf4rCH+CMoC9C20Ui05FRA0/u5EoOBgV0yZmzM
 3Ca5yh93SigBhqzyq8FSuE6XwUmhabR0GwoGcWmPpF90XIAEcC/1aYOu6a/ahfZ2QEg06
 SI0dkWeU7MxNE7ruuFXaxE/Eq3Df43rjn9KdrCUzK4Z/iJAYgKi4cY6OVKnwlOFcxiWau
 WpbeESlGBNeokkmFfAZgnNC5X6wavLzVeRO3nA+diFSsiFd4KD/Ib7kXGkaZOR/pvhg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ar9PrMq+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.20
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.20;
 helo=mgamail.intel.com; envelope-from=rafal.romanowski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ar9PrMq+
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4D51840563
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 08:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791274025; x=1822810025;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nSbCR753fHn9pBE3oFOxw8LrufEWpKILBZlydk/hF0g=;
 b=ar9PrMq+CiNpExCjrxoXu0g9w/7AEchGW9w3yK+1taZJqdrnji042260
 KqRBMgUttOevHiKT7aeLjMa+3sHaW6eRsypscEOZxORvoPNpTG7/11R9I
 kdoMpzSMFdkxuhsW49u55xAcVSe/ILhQLENMcZY43DKTb+8kivheTHnEe
 p/TcwW9qdDlSNBmAqvC+543TngVNxgBa+mQbjfWvW6KBaGQ5TaEnmRWaU
 LPslonc/C3faLDict1vmNiqpceBDquuaE8HkYjxyQwgYpDglvn2oSLKhZ
 LbPcnXhafLf3r2KPMQaixOFXydd/MscWOvBK13/MQemDFZTUdNZwrFcLQ A==;
X-CSE-ConnectionGUID: 8D+AqZYZSHq5TYMZ9eYzOA==
X-CSE-MsgGUID: 02pm0mX1RfudIlIhTXbThA==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="10494"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="10494"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 01:06:52 -0700
X-CSE-ConnectionGUID: 6Uo4iXc9TYC5YJ3FQ+lMKA==
X-CSE-MsgGUID: sDd4fAyfSiySotuw30Ugvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="281864615"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 01:06:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 01:06:50 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 01:06:50 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.32) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 01:06:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMQMSz6qWtcWHZX7DvB1m4zU1nKHISOySBaIi4Anv/Q7Yf1C9n3W5oKoMah2sqTpD83gG5ubiT80CgyHqRFA90U0zCiEg15yKtpjgegXa0IlKsCiyBCQvpYI+yDbsE1oqmFlqzLejUinwIwsr0B12TqY6Dmg1TnLLLWXwaJSKFH4FNQ4p5FIVvywmlJ467iHFt4PwI4F/I79wBktSYnm/UeDgIAWqTRwbQNZzf+YPs5IUBVra77Yo14EaJvGHdP7+UE0isnwrJDIMYsiA3+nhrWzfQz50SFdeS5H6qbqSdnxb0AJFR7U7ShKV2kizTq+p/qQqZViAd19mfqUBgrbhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cc93ndqoLtgTp8u6+ZT167PEK/KSudyX8R4maJESJo=;
 b=eTT5MOmkKFU72hlap9Dp789MWReseHqzwoqkq/YhvTS/H/wK3QivhBGwgrAepEbnSS/DDzyI9zHqRUphGlLe7+HxxUxN3nQeiAelLvtmdBvhMqzUaDVjVqwlWRpMAafm41AQcQTStFP4rGRXkp6yNBnStEOavklsryCkx2sFjSOsFR6jdAV7L21X8XOEevJNaHv14nheUJ5/P5Ij2oil2P9Wiri3mxnobs0wSNpGG7sopGdyjBXCw+yFuhBmH3+A48x75kUHS1PG8QxZ38yM4df/u/z+nIiM4H+7a+bN3NxyWYNdv/S60GuB+H/m0iEE+wKCUDF9CMy/3gXYA8iHzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by DSM1PF8C3EF9610.namprd11.prod.outlook.com (2603:10b6:f:fc02::149)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 08:06:49 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 08:06:48 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Wentao Liang
 <vulab@iscas.ac.cn>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "kuba@kernel.org" <kuba@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "sln@onemain.com"
 <sln@onemain.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] ixgbevf: fix xfrm_state reference leak in
 ixgbevf_ipsec_rx()
Thread-Topic: [PATCH] ixgbevf: fix xfrm_state reference leak in
 ixgbevf_ipsec_rx()
Thread-Index: AQHdRpXAvvswkXsWq0yPUwugayVj17bZLtOAgBcXOdA=
Date: Tue, 6 Oct 2026 08:06:48 +0000
Message-ID: <IA3PR11MB898522C99DB5C8045AE30E818F952@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20260917111418.2148632-1-vulab@iscas.ac.cn>
 <IA3PR11MB8986651065381146E88621E4E5842@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB8986651065381146E88621E4E5842@IA3PR11MB8986.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|DSM1PF8C3EF9610:EE_
x-ms-office365-filtering-correlation-id: e9f6327a-eda3-4c9d-b6e2-08df2380c58e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|38070700021|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: wBQUhos01ot4U2ioUYx16Dpojkg32MJz4P0pgl4MvOKs4zM8nWQB4IpYk3CkXuKsI0qdmogIx22wOCzscWz0KtmdqJStaYNDN8XBkGFdhQhi0LE3cZSeb5rrpL72d/44VZgiO279DuSbXm598dlV+9V2kKTcYDJOQoifeKVTrC2aKrK1oLrLxO3C/iWDn/QOHPVvxe6jAyL6fA73dmKgxiFMblag67D7VvqWt8cLN2p/isa8UREE5DVlGFyfQ+cEEC282yW0iLsltOKxemOB0hEnLu1lT6KwHiqdgAg0xkexlgFlQjOFPfHZH8TfccddEIM7wWnDdu2ojIA4Y+hLuUXzRO0adGt5bGGPdgavE7ptASwm3te4KJ2EvlLeXJGS0895Br5kjJbi9FiPOcDBoiL/XL/dVDzZiYuS8zg8YjlqznLHK7sUYH3v2nWLPAkr9hnL5qOWn5ezYTWTLqsxWWP3rgxv5QXd7/4h6UZKL9y+m/7y3ErTbSvbbn4ox3plzXygO3xLeWnRcGa17j2dQXtaVOyeWbG6JBNuKoX+PR+yf6W1kwEp0EHIsFKg3aTIQTUIzo7qhcKj4jUIADKGmWu1k8FXtS80sPJXrhdCTX5sBJyh1ZE8mi6Ok1Qj4XfCCmQ0zozvjiLxBEVDcgAkkN6/1drA9rMBswOSzqbkTktZP6eU5afLW16D3wYaXMSAbLX3ruX2BD/feDD8I7Br6BwuNRO+8lncFkxTHY1CRbQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8985.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(38070700021)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KheCHQoRpVhVPRAVuuEKw9jxyVced3/7X8tlH95irzniCJb6BmyQvR1ymMDs?=
 =?us-ascii?Q?93BHrXO5r/tC9Kh6hy95et3HuS/kRtbRvV7CgtYper0qrdof+BLwS6ELpET6?=
 =?us-ascii?Q?LhBzx9cR96eh9TTvyVCpx/bHnyn5GvQt+mwmcZP4lgd0e3sCSdXjRTL6pzm8?=
 =?us-ascii?Q?+j0rlgN3AfkmxXGxC5BZqTqLI2LLWtfnUzc+k9PH+Dz/Muy50kjPGldaM7uU?=
 =?us-ascii?Q?4+Q9c/08Runbm5MeQb3rBNaQg3RO5VBot2fQ5LaTilDy2cMol73oqR9pXT1Z?=
 =?us-ascii?Q?8PKgGxvviMF9UzAiSbblrA5CsZL+d4KU19va38zuWwO5zCVDtWXwf3ILJ9qV?=
 =?us-ascii?Q?Mkn7FpMzJCqCTC7DX1SDOp5actGzG9DYJERyj3UySFDS/kVqKLcbFNKCfpv6?=
 =?us-ascii?Q?0xAY8GM6mm0TajNk7snEsNczDCgur8leJn1T4erFQpaxVTMCBP9DlUZuSQ80?=
 =?us-ascii?Q?oiV/HzgdxDCzs5UGQ2V1MbJ43dEvsZVZEgChZb64BRxSEhYZVEHHd1q7TTw9?=
 =?us-ascii?Q?GeMt9kr4/91Y+FLyDIu+JcDWna8QBHArNb9qzLDFo3EOPzTVXy4tfU9ZQaZz?=
 =?us-ascii?Q?FNevOiJwIbDX0GOM+LAtEU3qGxrtmMJdSWDJZeQJfE0EiZKYAZ/1Xi9ptmnw?=
 =?us-ascii?Q?xfFWb8ONSqSvAHk/OC/bueXJ12KTVG6ODx3dfudpGwy05PrdaOnaygelQ4hw?=
 =?us-ascii?Q?M53JNuX9Y3pn0W3FDW0uKvAmnUdf2mLPRVafD01haH8ib6XH9PQiGiYPUEoo?=
 =?us-ascii?Q?DEZspqq3OOn//NIi2p/4Ij2KKrnJ4LuZ8xaFaT7jO45Lq8acAhJvaQZNbwbL?=
 =?us-ascii?Q?V4t+5PPXZjuTqMDB/DcGD4VLA9GFPBrMniBbf30cJgISluxu9ccytaWYCPBW?=
 =?us-ascii?Q?H2LeVWWKdSaVZcwcFqpdbzfpWkSxjuYn0FvcIo9rSvuVsDjWzqqnDqGj6RNH?=
 =?us-ascii?Q?93knIWHuOHjTAVE0YYN+hk+MHPycp7/yDK0S7GAI505JmE16At0C6aOtZqP6?=
 =?us-ascii?Q?AJgIxtivZa1/ezFrsL2RppfQM15BIuLaoqFy+hQDa1Rg+8qjdD3e/KpUx6EL?=
 =?us-ascii?Q?yUZHmo6gkebP5usST8SineWNElqN/xFOcMxsDsgoDkvNOlDSIyLHYuMpgjOv?=
 =?us-ascii?Q?25re5xxHUBTYgvV80QXIwAef/Qty9bv333RQhSqfk7NV0fRHLhX/LuIbSZWf?=
 =?us-ascii?Q?9wEe47aEIIwDggPy5lz+hJvB4C4UX70+pLQefElPS6+mfxpOiO2wgVDX4Fl6?=
 =?us-ascii?Q?F/3Fm01Ea4YhCJAQ0VRUdX2+WLvo+LRiv3B0bmEloDyaBzeeAhDWJ3seUVxv?=
 =?us-ascii?Q?aCwDL01KDCE8j9CBKWnE7WM1TxbrMtUzOQFoEvmr8hiJxo/EYByW1BmQteOZ?=
 =?us-ascii?Q?o/2+uVyeBZYlc671u4uu7iw1xVVnaepCwy1kraSrwL2mVzZysNvXr6CcD8bf?=
 =?us-ascii?Q?FJmwapPjvb7b2J8/PSnoapA7U5+zPD3hmAk+5bO0CXt0rilxGz29wCw7MNPs?=
 =?us-ascii?Q?7QwkZg5jd8sQf/QQvCUKinPxpwIvg4DlN9WPV4TT+i57RRoqvgmSnMKxSntJ?=
 =?us-ascii?Q?jy84aPkhdxCijPCMGqFZkLCaGATot9L8+TOYW1YPYQcPQ/AwMSk+xABsXZka?=
 =?us-ascii?Q?wQUJ9oHkd9/BvF7J7RydWo+DzoDWAEVLMyAg0se9g6qRXCJ4ZEW2o2e2AMzy?=
 =?us-ascii?Q?8cnhXMrmDun2MjsZ107DbcU9xJuQKOqILc7jRCcOLQKjD7ODrIc75uKs4DTm?=
 =?us-ascii?Q?RJlKh4DtWw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hn4kj32uRXxcFF48uNUe2gven1ChYctINkAUsI3nvFH3mYC3e7t2Q0uC8prGs7IuXYq3rkEzWHEB0Kdp4G9pDAluywRAx+/at7CVg7ebOXsejCKqiF3SiJGRbpIrXPI6YzuW/QBrLB7CvNnva5Q8Pi1hUxjOlAvIFG2KZOw1mAgZuB5IVPKNJrXfntNWbqTwJnCnSLzqo3smNExx/shpmJKun+6DUYf1ZfRnqI4t5mEo9UN/C8lvlf7eAhfFCP4ZoKxw1ST8JUHJEqv3raxGYMWTsyYMIsXvR5FyRZzNgOZsZHA7Yd11hgvEV2H+gQavYKSXAfPgvG7bsi9WOoMydA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f6327a-eda3-4c9d-b6e2-08df2380c58e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 08:06:48.7111 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZqSxq6Kdp9n8QtjwPEzHEMUmhRL8KgrJAa+35pdb8Z+u7DTCf5KLqYGJM9EugMPJO93oXQNpzrNUuiVZKerPztIfBdQ24jy2jFWUNwbFkGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSM1PF8C3EF9610
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
> From: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Sent: Monday, September 21, 2026 5:30 PM
> To: Wentao Liang <vulab@iscas.ac.cn>; andrew+netdev@lunn.ch
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; davem@davemloft.net;
> edumazet@google.com; intel-wired-lan@lists.osuosl.org; kuba@kernel.org;
> linux-kernel@vger.kernel.org; netdev@vger.kernel.org; pabeni@redhat.com;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; sln@onemain.com;
> stable@vger.kernel.org
> Subject: RE: [PATCH] ixgbevf: fix xfrm_state reference leak in ixgbevf_ip=
sec_rx()
>=20
>=20
>=20
> > -----Original Message-----
> > From: Wentao Liang <vulab@iscas.ac.cn>
> > Sent: Thursday, September 17, 2026 1:14 PM
> > To: andrew+netdev@lunn.ch
> > Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> > davem@davemloft.net; edumazet@google.com; intel-wired-
> > lan@lists.osuosl.org; kuba@kernel.org; linux-kernel@vger.kernel.org;
> > netdev@vger.kernel.org; pabeni@redhat.com; Kitszel, Przemyslaw
> > <przemyslaw.kitszel@intel.com>; sln@onemain.com; Wentao Liang
> > <vulab@iscas.ac.cn>; stable@vger.kernel.org
> > Subject: [PATCH] ixgbevf: fix xfrm_state reference leak in
> > ixgbevf_ipsec_rx()
> >
> > ixgbevf_ipsec_find_rx_state() returns the state with an extra
> > reference, which is handed over to the secpath on the success path.
> > When
> > secpath_set() fails, the state has not been stored anywhere yet and
> > the reference is dropped on the floor.
> >
> > Release it before returning.
> >
> > Fixes: 0062e7cc955e0 ("ixgbevf: add VF IPsec offload code")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> > ---
> >  drivers/net/ethernet/intel/ixgbevf/ipsec.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ixgbevf/ipsec.c
> > b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
> > index 076fd0a24858..bf3fcab3bd57 100644
> > --- a/drivers/net/ethernet/intel/ixgbevf/ipsec.c
> > +++ b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
> > @@ -596,8 +596,10 @@ void ixgbevf_ipsec_rx(struct ixgbevf_ring
> > *rx_ring,
> >  		return;
> >
> >  	sp =3D secpath_set(skb);
> > -	if (unlikely(!sp))
> > +	if (unlikely(!sp)) {
> > +		xfrm_state_put(xs);
> >  		return;
> > +	}
> >
> >  	sp->xvec[sp->len++] =3D xs;
> >  	sp->olen++;
> > --
> > 2.34.1
>=20
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>

