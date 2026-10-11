Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D47FCA9EC7
	for <intel-wired-lan@archiver.kernel.org>; Sun, 11 Oct 2026 14:17:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2DBDC40631;
	Sun, 11 Oct 2026 14:17:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nDvis4-CI-On; Sun, 11 Oct 2026 14:17:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5B5EA40603
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791728257;
	b=HX4x/8EVQftA+mBmyNFKF3tmPRwpzVtRZz/6VEkcayBnic6hsPTz3q3/vxUozzWYMPVC
	 2nwdh5+Leu32BR+Y4penxj5xSEz4gXispbs0+irOstDizO29eFQ/BWGBskFo9wYTGznJS
	 XzXjPCigO7YYp6MaOK+Hh+8n62h23ZwKNwaLuZJ/YzsrHCNJN4N3/ZUcmKgs2GxjMBI0r
	 lUWBu/g87vF4Lo+hxcPgpmMPyhrs8VUPUJNd5t0fz8PvN/HUrzIVcC8geVZxuvouK8iLU
	 9MBfksd0GkM9EIQTL1YuuJtqkWP3htrkV2ZVk3vo2oJSYJSgXA0+HG552nNoTrblU/A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791728257;
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
	 x-ld-processed:x-ms-exchange-senderadcheck:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=f5UN5Ifa+uwvctWzMnF37+8BJtWZZwS9izXZjxLIj1I=;
	b=HYlnEQ7+hzQXSreGh3+4nIayb7/EJdz4C+REEac9z8+R7Y37snA53oinfmQfCdYIMWSi
	 qSoYEeHOvaNC2SjgWA5/4+Eq/A6yMeL5bm6E16TU3uLRvqHGn5aGA+NiN/S1tgHpGmAdf
	 oT3uEmqYGZ50nboEudyXI6fPHuoz/09zfMeM/7UtzGH6Dutw5aZRe01fuHycG8pW122bK
	 3tFV+zlATkCogzuEXXehiIHCPaP1sIAA4kq5f6dMKakDKL+TAB+CT+bVIuLDJS76mDczi
	 8N0U9nEPm6ed7PyhBmaxLSRPmOFsPtJVUnbw6oULzq9WfQUeHfejSI/7jHE0h+TXdfA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791728257;
	bh=f5UN5Ifa+uwvctWzMnF37+8BJtWZZwS9izXZjxLIj1I=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jVrefCmDKEqQ36cTFK0xggDVR6wrME0jd6M3gxWqjJ7RewySd4kHWpXqTqStT6F0p
	 PR7yf6dJuESBjAfdMIeZIiMimA8H+xEXCE2Inx35AB+xoX1OFgdcStANSf8jQk2Kig
	 sdP1BWXKW3drdagb2fy48DgBy9wqlT81qnrn1S805WKT4YMg3vZeoLU3QLkb25D2fs
	 Gz2+sL8sKBpD29RXdbdMN7XQjBWqqazZGPqj18+I3SF/goGU8by0IL5u6sCCzBlWxC
	 JLMtBwB8JImTWq3tMUNGwm+Xra7Lfm2AAsQ5YYJ6UkMaVdz7Uosa/R/3M6jwvyIIPM
	 BNOMvxjvp9u/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B5EA40603;
	Sun, 11 Oct 2026 14:17:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 84C9A2E0
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 14:17:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 769376060C
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 14:17:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JkJjvDhDzBS8 for <intel-wired-lan@lists.osuosl.org>;
 Sun, 11 Oct 2026 14:17:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B5F3C605F0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.18
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791728254;
 b=MYxzOTtx0uQBedXtTM5htFgkr+uSfdASnPo3edxbcN0fZYiO45Li67nBMmJCuzHPwzQZ
 yz5Bez41UqoEUHud/K+Xu+gJupR2d/PYrFWt+YZbUB2s86GzTSdz/kZ+aFvAuJfVmcsXb
 aFNiUSnneWQlUQpblUTsQ7MOM7X3+MlON37s8p+DR5lTJXOS0cFXiDgGBkqr7+chT+UWu
 A/2BT7WDksjCtyewUNoWzhkhvT/eUY+Ma8nMlFiQWMJ2fpM8eqSKQoxVwgVvGvJ6jHv/I
 HSONdxI7fc/bDP7sD8SgHw4NrVoqHOQXdrq1w5YGRssDTPf7Tyd2zZf95zpbfP47zRw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791728254;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ld-processed:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=f5UN5Ifa+uwvctWzMnF37+8BJtWZZwS9izXZjxLIj1I=;
 b=Fh4zJAzluuz4mY6hY/yQbG47vNJ0pXeMl6AHRlz5GLSLDezTo35XwRvD9neSq9fAophp
 EJmYlqwJ68M/Q5zyUOx4pEzurkFIV/5r51zf7M40ZaXRNb846/XEcn4cP39Ltz9X/tVOh
 jXCAZ3UB92x18XU1jdR4FxSKx8w6gKH1gwyLeQP8wXnUYwx38MZgc/s4I+hC6pWcpRB9K
 baFUYAneYgCpoyhcNLEcsIexISedtDXwHvdbmB0qjMWI+2f085uYYBfGzGGuJQArH2s4z
 KPnS5ZjQFZf/rNAFXjI8NPJaaLAaTl2Pq16fNhA0cz3DGZZY6OLGStXxaX0s7j8rOSQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=AdAMgcNQ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=AdAMgcNQ
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B5F3C605F0
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 14:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791728255; x=1823264255;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qvJD7zV0eMnqhtckei/KFS3nsNZNSY0C5mJVeXP6Wuk=;
 b=AdAMgcNQ64+hShMARageNKxxuUGViTOG/XJ1LgtZVvoGa5xoYv1EbbOT
 1x7+mH4hqAuF5yjE0p0yaV6qScxXMcFsZUkTaMNy4rwkuu33mFBnX/YUE
 N8mtY2USSZsl430CEqGIUpAOjvjbSP3S8eBlksV0W1B6plhsLFzoWLcYg
 Hxfld7Eyf1nCcTTrlf2EfaCfqUG6jCzMjlIrAkRwUadZ8FWVW4707c/y2
 6EavZfB0AM/hcjmV2EA4ebCqzFkiTNUCb0lwHNSRGf7CfRsYmBFuxZpOT
 sPn74gbD7Ii2aF8KItPKmyRuXzGR+kfu1Po1fqkDjuWB7IMtNho8zwlxT Q==;
X-CSE-ConnectionGUID: 9wfqGAaYRZ2orGBxcOvf4w==
X-CSE-MsgGUID: YfxsueQgTriNGrHi8xy3mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="469550"
X-IronPort-AV: E=Sophos;i="6.27,151,1787036400"; 
   d="scan'208";a="469550"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 07:17:34 -0700
X-CSE-ConnectionGUID: ybBLtQNcQWOO4Rtu2KeAcQ==
X-CSE-MsgGUID: BFiR0ripTAy4afMoFa2ezw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,151,1787036400"; 
   d="scan'208";a="2493598"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 07:17:34 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 11 Oct 2026 07:17:33 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sun, 11 Oct 2026 07:17:33 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.52) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 11 Oct 2026 07:17:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ccsp23/C/m7M36J5RjcFwojvgWWm8cpf01uzMCT8vKHlpIM+DBI12jTlWui9cmdNrW5qIXVfEBDVVJ/vHtxidvwQ0jPhbLATJp6XMFYJ1rVXJISolhGEIh9XjktYnj2kFmAGxuJCx8IdmU4TWHUfPwgcnf0+4pXTXKOCLlhd2puM6kDalscGnQc2wYggHf1taUam32U1FRvdU+xLmJ6pQuVdLu3McKhwCnGVhDa3nORKFxMnu5zglQYlS9V+vum/6A/YgOhwtRNAp3l25j2RXhL+atm38Th6ssTvAnIqJlRnFVT5Q7xcgO5Ypn0WWP70xK0csGJNtLqRk4LuC6luGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5UN5Ifa+uwvctWzMnF37+8BJtWZZwS9izXZjxLIj1I=;
 b=YpuEDdu131xpL9vwE5ZnhSLl/iGa9mMelQjNcHH0ZE6uMoRpgPlntDAwBYK1mT6AmsSo96ywsQY5N8z1nluhf/l8hhvU0B5I9/9Y5A5Q+84gGK7+0GWXTkf6hGzPSMtNxxlhwua+FTnpITKZlLdfSxMXkTS5Fi+3SFsYGqxDv/ShIpt92wMAfq4oU5mcSE97xLBPc2ZQEP7EE+QuzODgiNE2vymC8WZW/m1lzpNI580KuoG8JmQ6i6N7tNXJ6YqmC7I7x/JCIMIT1OxWCNitALbP6P5Wx7bf6/nJIvzc8tpwTlt8HZbuD3Q7bX0fg9yTcfsLYpSIHQ7pBIxdYBYO7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by DS7PR11MB7691.namprd11.prod.outlook.com (2603:10b6:8:e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 14:17:30 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0496.015; Sun, 11 Oct 2026
 14:17:30 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
CC: "Oros, Petr" <poros@redhat.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>, 
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH iwl-net 2/2] ice: skip the SW pin description on boards
 with generic DPLL pins
Thread-Topic: [PATCH iwl-net 2/2] ice: skip the SW pin description on boards
 with generic DPLL pins
Thread-Index: AQHdRtdNwwRej3UuSkqLn91p3WtmJ7b4iJzA
Date: Sun, 11 Oct 2026 14:17:30 +0000
Message-ID: <LV1PR11MB8790ACAC249D900E65ECF28C90902@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260917190258.3239282-1-poros@redhat.com>
 <20260917190258.3239282-3-poros@redhat.com>
In-Reply-To: <20260917190258.3239282-3-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|DS7PR11MB7691:EE_
x-ms-office365-filtering-correlation-id: 5e9bf946-108e-4c27-baa1-08df27a262d3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|22082099003|18002099003|10067099003|3023799007|38070700021|261009223027099003|4143699003|11063799006|5023799004|56012099006;
x-microsoft-antispam-message-info: 01RJxo4wTmChfFNdLwBtjkm4LmXrchaFOfCMIPeU6VdciSKYULULYxNy4EU7zBP2OSGiZL6D7ExaCSagBANH+Mh6938d6Y2h913LV1WjPrYh/VQOJv+TMtqXt8IUvElpBIn+ZDme/rJb0QinBPRu2BFQguwtJYFZUhYzWFpJyBwjJryYehm6UlZUfc03TcNJpD3d5ES5ahynWF+2kkj/1vWLOseTN4E/aSIf+fg08bIB8SynvHRUn7+/tR4G8LDKKd1kVHob3Ncln2CqtJ2FFqN8p6X2qvEMEpdpfPgsUJAc4Y6ueMdYBGspTovTT9b5rXN+051KX5YpCz+pP0+d5tcqPXDaYtQfzm4xajBopqPaUzusW6vdmvSUjy+Rc8pc67joBt83qrn+VNPoZaA0ihJ4i1+MoQVJ+swYarid7sClk3mcLgu4lsb/2O2JlncNdxiiW05Hlf3mB6wGFgSPhDc9FTu6Gvv3Cxe1KRo8RhG9m4q67R0i3hBVZhkQbzhxHkPETNhtrswP99o2rXRGBrpq+NXJDVJ/kZ+3GhfkP+Y2eA0oXYobn37K79EHSsf/iuShlGecM8xee+/rKoRV82zbxt/Q3QeqR0af3PhR84UA1hBibJJMQ5aaaX4gdqxLN+afNoNpjW33E40DciSi8FSVf6ELQjsc3EfWPs3S8gE9910W437nBmQdGpPKZAoihwdwavuigJavqBFgOUX6hBNNiRb3lZWxmzo+57Xp/2A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(3023799007)(38070700021)(261009223027099003)(4143699003)(11063799006)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RusAgUbwYecNjbdyRvATsvdN6eRwO4laWGhwW8R8lXPQvStWpmbvQKd5gm9s?=
 =?us-ascii?Q?dXZ/v7KcADSVDyBkVG47c//tQttLuDw3hO325WmCVX3kSpNkgvXgFb8xbY0T?=
 =?us-ascii?Q?RcEylefLo8SJO1TlvS1qxgrSLZfRZZD0Udpw7si256wHXMSDlUpZN4MVfpYk?=
 =?us-ascii?Q?O4cuiFoymuIn+8V+SUie7L56stGQsdi3Gh90M8uQ3ZSNfKfw7yCxjbOcvu58?=
 =?us-ascii?Q?ZRyuMnv/xS9plcHDb4QVlRaQf/rm6boRx1psLj3hHj/BJGCx9iJtx/Pxm9pw?=
 =?us-ascii?Q?+HDZPeUKnREw7dUnAbPI2YJnmumvsCIMB2Erkaw/z/5yKiejOc7IoMB0PgCs?=
 =?us-ascii?Q?KK43/g8g0QYlRLLQTU3ziX+jiQZZxawHpEEJ4y7wMIkz/65v7nMZBgXwnied?=
 =?us-ascii?Q?uOMjrNo6fPrdMzb0Fip0VDHw5cXxbv6eDqlrCGX/BDJvz0GXlakSkUjKqFhd?=
 =?us-ascii?Q?+41LKJgG6XzFUEZ0jbs9ZEhJ5J8Io4UgojuFi3C1RtIqbtV+ZErPee8iHjdx?=
 =?us-ascii?Q?eRmdU6GeEAhDOnafIisZDas4YDhNQ3wzYkdnRqtbiOwHP4r6V9p/2ujdiF0O?=
 =?us-ascii?Q?8LIskpMlTGuMFY5ZeliQcASwcCfVfcz1OSQkAYIvHRwVYjM82s9bKehzygPD?=
 =?us-ascii?Q?4DBYltfWUp0YDlO10m8ReAWNQIAfyWiBx5negqjs2pFZIm2VZRQFhXzY4Jla?=
 =?us-ascii?Q?VVQEF5KGCbkCXiiBkfCHAMriLLPbgPiU81AGDOWbezYb7bZyJSn/GaIPdVEU?=
 =?us-ascii?Q?lM1wFlAL55+UVLtk30f1Kg7wOLXQfh+WpYALpIhn6+6zQxDnxeUIX4t29erP?=
 =?us-ascii?Q?gX6ptMZMoT355wtToYbI+nQ6ackAm5r4NdE5iK1/pnOzIgdvL1Z0U8+ZW3v7?=
 =?us-ascii?Q?up25cRB5PMG9qIzSWP9y9GiS9nIfMbTwEUaQzoCls+SQ9kTKfZWTSxEy3S7x?=
 =?us-ascii?Q?oF8ZPfAxAkFPO8tDdPi9z2riWeKgq7dYcfNGV8Ewgwan9/3HU7El99cVsFLY?=
 =?us-ascii?Q?yuVEaHrkIvl49YxYSuvOqCE2psvANJNmSmqCV2Mjr0APbefex/xopfA/elIS?=
 =?us-ascii?Q?mZWikf53Z71MowZ95r4bSnG5h9yqaHnxqzibK4OuLz8jTFSRfRSsNPq0D0gU?=
 =?us-ascii?Q?2Jg2rgH7g/HklBCIs9cDorlRDPJ53L+QCYS3ZvTcfDFpFunkinMKjwUdbHaK?=
 =?us-ascii?Q?w9zb7BviO6STm4vlrxi/gRt1Dba64Iur3E8kUBjfAyXbzLU76gdVBmeFYwkK?=
 =?us-ascii?Q?2sqdHF1WLy8vturFOQqXbHgNHjyGl0iLgFXA4LP3j8E8L4Vg8xOs9d7fIjaK?=
 =?us-ascii?Q?TURILoUkbbqGyVxILZXqlIXfAqKC1Zkt6dPNKpeLujVUiau2rbY//GeN6RMz?=
 =?us-ascii?Q?IF3bd7VJ9Z+YvIta24lXUX5Ix6KzoyZ7Rg9GQ9IrOZpnVJtgpNRqdsEm3Vyn?=
 =?us-ascii?Q?80HAbiEXQPJINqoFUkZ1F2FSuvikruFCfpr9cc5q8gYnHymr0bterQcVRcMN?=
 =?us-ascii?Q?zVdPKR0PS6QH5ANMWJOreAtxAWtnHAI39/NE6DXCwaNtwZh4DJMJr5N9Is6r?=
 =?us-ascii?Q?u1dwWAs26BOucC2pBFqIuwVI46O+DippMTHyoUULYdk/ckgonfsoIMRSjfun?=
 =?us-ascii?Q?s6CDxxBGihpu7Fg06J0qRgRBc7ay1UtyFFngR78ibtWCLzbOBwruKSsRczGm?=
 =?us-ascii?Q?3f7SmZPqORHVLzUFofjDASmaQT2wgZfdimJsnvcwd7OSVdfF43teJZ1E962V?=
 =?us-ascii?Q?7Mw49+Suxg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OTlLbhgX2KpzHtleChcdoWgL2XRkwiVS65rCn55sbI1vUuo1AB3mISHtEOW8Kq4eVE/JcNxU1/cOriDSb+9JaXkppYvocr6ix/f5s7ufhd+XiSvBTbC3NtiODGrsy8APvIvFc+CQBqd131lnns/rYhogBeope/l1u8wUvzXr9lZKITGmkj+d2/JvxnX5kJyrLSzhIhSsjVdLV8zerPNd44HPElF2xp+tyYBU/Pk/dB72Z6un7DJxuD7tvOv9G3GHYocFKrRB/gVl6tROS62D9hKkpx0Nb/FH4bgS6i05R0k/88hV77iXiQ9LZCidy3VBEy7NZ8+puebU1jglNlLGEA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e9bf946-108e-4c27-baa1-08df27a262d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2026 14:17:30.5906 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hFnBKvyCFRQqqUo27+UrVV647QmFfq2dcrgq9Wf5+6VIMT6AS2ol2F+SUuf9A3PtN5siIPhkiaXRuSxHMnHq5zG77kosnhmmf9pxFff2cwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7691
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
> From: Petr Oros <poros@redhat.com>=20
> Sent: Thursday, September 17, 2026 12:03 PM
> To: netdev@vger.kernel.org
> Cc: Oros, Petr <poros@redhat.com>; Nguyen, Anthony L <anthony.l.nguyen@in=
tel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn <=
andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric Dumazet=
 <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabe=
ni@redhat.com>; Simon Horman <horms@kernel.org>; Kubalewski, Arkadiusz <ark=
adiusz.kubalewski@intel.com>; intel-wired-lan@lists.osuosl.org; linux-kerne=
l@vger.kernel.org
> Subject: [PATCH iwl-net 2/2] ice: skip the SW pin description on boards w=
ith generic DPLL pins
>=20
> ice_dpll_init_info_sw_pins() describes the SMA and U.FL wrappers by point=
ing them at fixed positions of the input and output arrays, inputs
> 4 and 5 and outputs 0 and 1 on an E810-C SFP, and reads the ref-sync part=
ner of the input it picked. The arrays are sized by the pin counts firmware=
 reports. On a board that does not match the Intel reference layout the dri=
ver has already fallen back to generic pins, and when such a board reports =
fewer pins than the reference the reads run past the end of the arrays.
>=20
> The wrappers are never registered on a generic board, but
> ice_dpll_init_pins() still calls ice_dpll_pin_ref_sync_register() on them=
, so a stray nonzero partner from the out of bounds read would pair NULL pi=
ns.
>=20
> Describe the wrappers only when the static pin table is in use and keep t=
heir ref-sync registration under the same condition. The default programmin=
g of the PCA9575 clock mux stays on the generic path, a board that has the =
mux still needs its SMA connectors switched to inputs.
>=20
> Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
=20
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
