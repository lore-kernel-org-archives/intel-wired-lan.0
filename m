Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862A3CA5FFC
	for <intel-wired-lan@archiver.kernel.org>; Mon,  5 Oct 2026 19:43:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2AC0640595;
	Mon,  5 Oct 2026 19:43:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HPT07_jKXwVW; Mon,  5 Oct 2026 19:43:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8079640598
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791229397;
	b=r2+qAmiKwDdbDymd1GZMPMo8ckQpQpyg5zbWaOoSezgRizyyPMC8RlyaXYqQ94qa2AhD
	 UMAWJL2Yhy3aDr432ZuowklY9qjiPQZBa0WcWWU4AxKfR7LpIqGh4ZVR0BP7Hbgg/a5l7
	 0ikFsZgWtsspFp/ibLR6HF1JMspqiBYUCHZhcFWvR68HC+DZ8cOzN0nC2/TvK0JnofBKg
	 wFxF7OcYCbBFOUREBZ+68jJSnUEKu3YfTsWuxE2FDMAC3klEODFefQxxaEsR3DFkDVjLX
	 NmA/wq6os7xP52xIZyUeqsAGxteJNvYnge7xsjDb7/HecfXNA6mRmAWTz3w0gLPtcXg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791229397;
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
	bh=L+Wt2/8QjF6GKX6bqfHEApo9NoAXkzgnE4zMEQdryzE=;
	b=NQxOFSe76FMjRHuPjyYf8nOtq8WiS4/E+YIDiZYFs3LFyCr/ZVmUV5y+PxZBfH06Ga3B
	 njIcw9QJ3LNMYCLo0hcHR7zDBj6vqTyG0hPP+aKcxYa/pVGHgJo/aV5b+1ybO6SPye4cL
	 GyXeh1YgyaMm4mtavTTn6gqANBBysyBnFCehhkjZTXz9qzgUAXFJ+cMU0mmJhNtkzVedA
	 bdimZQ9eTZr8Le4NjKuRyf+CWdXB3lr2H3WAPCnzuBe0kQD63poBaebUKW2SfSioLzSDD
	 SC9AHNHHP6y4yt1kzvsM2tG6KesVE+400eY34G7DBYJ8+OhNC/jp+gRUpYdkS3xSFSg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bvrel3BR;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791229397;
	bh=L+Wt2/8QjF6GKX6bqfHEApo9NoAXkzgnE4zMEQdryzE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=4x6WF164cSuaW2UvjSENXGOwc5Rk7pnP94qXAZqBfvO543yzmKn/Q/oKu98kDX68M
	 D3xxkgGHKzflvb435JVA6WKES3yFTD0EXYqrF6e7ntwrMbXHovi67+BJPqnyyc92yL
	 y24pdAMLHw1sUvPSyXLfmF9fTy118SU20hsXWZyt34eMCvxBGB8p2wHO7hcWN7IPci
	 yfj7sE7CLnMfzIJzVpxtQY0XhLVRvBUd5u80UqEbT/M4F2HOYWN9ab4fgHu/fcNWgX
	 77wkMLgl+M1nhR86DaZeH1xiR0w/XCbm0g/UTsaW88GwUquqbVS7SDwVZ4H5KM5F4w
	 DeqY2mmq4JVOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8079640598;
	Mon,  5 Oct 2026 19:43:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 425F134E
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 19:40:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 27D7C40681
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 19:40:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vgVnx02fQLhh for <intel-wired-lan@lists.osuosl.org>;
 Mon,  5 Oct 2026 19:40:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 48EE940680
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791229202;
 b=qVlasbjCFPKxb2ZhdP2OqbiziLWPLPOZNfVNS5dxw1ABp6UHBn1tzEv0VpR3QbAZnRna
 NL7mYLJR5ucOv5uHXiM4zA4kZw6tyusELyz1giqyqAb+lwy+ff4ez+uTm0WZ+S39b1mgP
 ZgNxIuuJ7C3+nMMk3Z4SRaIJh+Duek2xnwf1kt1NQ/lotXW7caFrn+jOJAYBh+GvK0CPS
 fHLqR/kUZ01PBMaMc1eXHdrWohUsnhsIi0bpmwEmZajomZKjNe6OovqJ1ZK5+BrVbt1nY
 gZ8+Su5TRmSwr84DAo9tf9XS1jQreD7dr1j/E+YxjShTA3KLGRx4w4F2FjGK5345Tyg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791229202;
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
 bh=L+Wt2/8QjF6GKX6bqfHEApo9NoAXkzgnE4zMEQdryzE=;
 b=HSgWGZAbA1+B2Vfd7Sw2p94JzCITrdH0hAX4o8Kgdq5dVQMx7aacoYr8miYx3DZClebi
 FkbeZmW5fHSuMZ0+IbpwhIewoM4Y3LBILgaSpb6EpTnYu4YGy+9DW8zQMROdCU2vDYzFO
 JvwtSiQuRPovNGVs3acOwfW4eLUbPp6W6sicRqS253LDTms6ivNIEewY5G9wLaX0LFyEB
 u6MhF7GSzFPq1giwkw7YuoZdSgYeg2dutFmN4Doq2DiaZp5QEpVvKuI+e9Yocv7Wntxce
 Mr0TuRKyhE7raphgs2ee0ton3onB2DomLdpSIE8WiSzO6aTRVcdiluFGaS/UjjgFXCA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=bvrel3BR; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=bvrel3BR
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 48EE940680
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 19:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791229202; x=1822765202;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DHkkp097pSsu2ceQTUH6KoAY5g+jiw7n8QvQ9a0cktk=;
 b=bvrel3BRa+YsDmtTQzEHnIo0gURuAvRgByJsGTmyh4EtzSFdO2OH2r4I
 6Q/fzHky5VEx6ITSP7rUujjWydxZihR47j7EXoR1Iez+AVjdVQ40cPk1y
 DieQOSwLeGjA/s2Zv4DpPPdB8jW0itimCYokdHmnYueZzeq790LHgJroY
 H2+oKdXLxYIyyBMQolvZ5FjUBD/R1v0Ng+db8aak/gazdE0/iZpXbhqOS
 S5Uyxd0zvwS+4O4DSXIZg02YfsWxrdcefXYsI8cwAJYtosLkToIC0OMLH
 71lRC5hn8R7ctHk+V1aoS6p5/+TnU6u7AuPfX6zoU6rRqlcEOQJdz+Gdd Q==;
X-CSE-ConnectionGUID: IfkPNX2sSn6sZ+MDsQRGIw==
X-CSE-MsgGUID: leLjFNXYTTC8Vkgtf+3Xug==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="92020198"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="92020198"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 12:40:00 -0700
X-CSE-ConnectionGUID: 8Zfd+XXuQICaBGhuTwTTRg==
X-CSE-MsgGUID: aBEqX+49T/W1M7M7I2O6ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="280641260"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 12:39:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 12:39:59 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 12:39:59 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.57) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 12:39:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ot2bwmVaMHi2POP5lPBIzXP19dOMGb2xuYWlfFS/gljFo9/a69DXZwswY2jKjwKv2h5Yj268CmAtkCqB/n7j8HmsDnMloepBLu/I4SwHHqrL6i8VBZ5amlvTKVq2QHTG10uV2xynOLhiQaI/M8bDVuFCb1/3ZBzi4cm7MjghKE+6BoV9CVcfV7PN1LuYM8xSB26HPGokDd3Ge6EQ4pAM1b1ks/VEgxEcCp+0OaSw7rcZsq4lhVeoNOjmNr0FlNUUfHzm6X6WiQNC2hM2oTyhuL2tiPwVFg3PJSzi/CvpRt/pssPkRROe5fNmR7dcYyv9aQsCKRVBNQnG3Rj7bKMvOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+Wt2/8QjF6GKX6bqfHEApo9NoAXkzgnE4zMEQdryzE=;
 b=LsEsjq0hMl2WxLpOOu8pJW256LAWqe9JVf/jBzv3lYCtab+0wcx7AQpq52p5mAWVmfnvh8uR7ons0FdG/US8CG1Wwrlp/RssNqmSMCPs1n9rMPgSYl2COUdnWqd3hnEonotv8giolfJiGF2FE2f9KybagrmmZThhSNASuU4WP9ZH/ZMrME7a9QMDo9YMVUVsYuG7uKxhcLcPftCuvwkru7B4zaFnj4sC33eZZvxRCW3DBo8RD2Z9v4BPjfA+qj6Z5JD1RtOZt4U4unfIoMODiKSD530uuD84rZGkG0cNnw9ljRFLdVUmpaE6KQHgPeUxhRQIB9uywBlRc9rD5PkEyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 5 Oct
 2026 19:39:38 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 19:39:38 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: rivaldihormat-debug <rivaldihormat@gmail.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Loktionov, 
 Aleksandr" <aleksandr.loktionov@intel.com>
Subject: RE: [PATCH] i40e: fix integer overflow in i40e_dbg_command_write()
Thread-Topic: [PATCH] i40e: fix integer overflow in i40e_dbg_command_write()
Thread-Index: AQHdP6htoeoT3XPthU+6WJelXhDr07bvgwzA
Date: Mon, 5 Oct 2026 19:39:37 +0000
Message-ID: <LV1PR11MB8790E916B2F0478BA43F677390962@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260908153933.2417-1-rivaldihormat@gmail.com>
In-Reply-To: <20260908153933.2417-1-rivaldihormat@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|MN0PR11MB6206:EE_
x-ms-office365-filtering-correlation-id: 22119cb5-eaaf-4ca4-a1d0-08df23186466
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|6133799003|22082099003|18002099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: gj7XvnsT7oZMK9ZHQ4FMinU6RUX9Bu2ROwHWHDQDAxPB4RNrOgnYLvXAHU9kpKOtmRx8YJRcOOq3FyPo5KMYzohSz1ZZG+MY52LGI2CPw+YZfIPGabp8hsd6gIg1aFiQ06kd2pQYKbTXqTXGO4sspRKhzgwBsRA0OsnKh3P++hV4iPPzKFfpmswhS2CvB7PMmxP8akYN3+4ia0jzOgFNbR7GddCRHbuVof5SL6jTJ26LQd23X0bIvXQnC/fhVRBqcz2Y2C3gED890cyB4WqsthNF04+yJbO6/pFi/vJliIWfR/Ylyrtj5lLbVKz7d794b6NSDTe5SpaQjnzT7WEDluRFKm9RdzZ5e52bcnQBQ8xcmCwAh6guXhWFajQLXe6bZwFh6NXiHLYXVcWCY2qqUf4Ait9OF1CWzzGFudI9X8W3O3CxV4PAI3k69ylOx3C0vPjJoV4sJDArOxF9UpiWFbc33RIxSpwht2MEDv96QYg8/Lp7Z0JROU2qCdkdxYHkefWkouM0+f2qvab+Wpl3N5DmBxGIQRb8zCiWlJ3rZI1A2L/E05QUVjXptyCkGN9ZxfcxIuNedsSdFcFgzCZ/T9eD7DZXg44l6Xc0viwEugLU2SkQpm48FrCsWL+Kcs6Du7t+hi8vbJOET08SfBZaEhmxZhbDfNbSR2vC4kcJGPk7nqhpRv2vhLKu9zmsbr41F/nrEfFSck8dZIRTUciV7xlliAd4nOTYsM8DgoOuc5c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ERVHQFHBHxgbcz/ARBjNpQKF0fLsKoozz4i0LCqLnnvBVu77JliU+/u9dr+K?=
 =?us-ascii?Q?zmHg4hPijCC+IDG3X2ewOBAmLqFqZkxy/QPbohOWdyL+ZctwoHd/ZcaDzNFv?=
 =?us-ascii?Q?tu4586w4EufbAZ4yXJfQoWEr2DcxTbcgBJVNvas265DbJ+2ECV/Ku42F+xnc?=
 =?us-ascii?Q?iHKGTz6gCPZXdf0De4KfnUtIEOI2/sHKJNCmVB03GvkbBzpgm/Shu/4Q1pyG?=
 =?us-ascii?Q?SLOyDixIZ3vsmOCHUZzVHYPN2fArcoz0XFXS54IWRmpcTgJD9fcSY6n56yFR?=
 =?us-ascii?Q?mcz8F/cTrtI0yL7x5a+jOO0YqsOTHD1eqaospLpToqDLhgef/+CzZQ3OPsnp?=
 =?us-ascii?Q?Y7pgnLQ9JIbtVn315nwKIphM3mPE+J5bQtVFnZIY539MUJ4jCRfACvW7ssux?=
 =?us-ascii?Q?LldQrZza3rfCQjpua3K+RbeqF8O/2WVi2JDzTWIYX6gZOm0LC4P25Ms8q1zA?=
 =?us-ascii?Q?MXwEibytbUQ4hdLg0X4tThsztITY+fu1LQVbXBCctoptaB8PdoRzTIDcNQ8J?=
 =?us-ascii?Q?ZjslgnYff3v/8rkK1VWSW49X4EZtbT9lAHFUaP+1h1FBRoFZp2YQKfY1NwI+?=
 =?us-ascii?Q?W8ZU/K7tpWnvUARGt3AkKpFctE2DNgOwfEHaqGHg9Up+qnqrp8+nLcRcFA4R?=
 =?us-ascii?Q?LZGsglfEuQVJ4QBJW/Oyy28tMANWZY3+8NpJXM/VidJy/rfd732KZLejDbhB?=
 =?us-ascii?Q?0XRQY0V85E9y0xDUmoni2Qg0a6et5jAJT7cuhQvpRXAtFCRdGyc6ILO5qfD5?=
 =?us-ascii?Q?EcWdUJyNdzxT+WckL+hCLBAOcINJXk9LGD3ZszXmsDxJ6JzOc+XRSCIsCeOq?=
 =?us-ascii?Q?gwyDgscFTjvInnGASQW9Wmfi7dubP3exwxU8H7kMpq/E3IphbJ9Lkq2Vivss?=
 =?us-ascii?Q?45R2l+X5Mtt1/5CFeNb8mMlqShtT1RH4KmZz8yE3Uv2OncKrstuoE25ehyJA?=
 =?us-ascii?Q?BFBRAJCuO3Vz1rSEcnMlVjDf+vOZN/GGvlqT08WA14vc0DkqFkwkm/Z88tnh?=
 =?us-ascii?Q?bhmJOjbg+jKIrtoADP/NSNZCuERE7B4b8a0lOkRYQ2PKnIdVlqsiDanPk1M/?=
 =?us-ascii?Q?ezgfK9KGmDutSv+bd1hBbviFVkD/HzPQzMt/XeRQgMppN5+igvzym1W4CLD7?=
 =?us-ascii?Q?FdFCJetE30fFPITozg3Y7QYmeoCchNaWMlVBW6SYdwQ/AD/X8GLjfyx4Ezjs?=
 =?us-ascii?Q?epCQgiNrR6q4Hm8DRuRzDvLQIm6l4jWtYB88BAG1fhiAGGU68huP2mczkwkG?=
 =?us-ascii?Q?N3QmVEeNBXqHEhEVgaVf4CzuocT7OBJZetARxhy5n5ywW+Vb80D0Di3Vh9Su?=
 =?us-ascii?Q?gWg5l4i/pvnx28yZSM6x9hqIvld7d8/0l9bHD3jGB8FjZ3S4mkZl3zcENTcg?=
 =?us-ascii?Q?afW6fHiHGPABE3jnkT1I4PDEkjIoiLa/YP+C2JRaU67GASdq1CDh4VrpETh2?=
 =?us-ascii?Q?jsYcq4CZLqjFg3BIwoqNUxBJk6HYRj3ZsRwvvMmiyYumLZ3DZ/RrZeMXIyCG?=
 =?us-ascii?Q?WfHAbfn1smcRhopK6tprWJEEMs1bg2hWyALB4AbN7EKEJd29PeRVT8fNePTf?=
 =?us-ascii?Q?00StDCBDDTTrGrFEUJMgzCkocjEUMPL0IS0IBGwQ3LYWp8bWHTcmexJJjjEn?=
 =?us-ascii?Q?+VgBqAIghdVfg2jFxdMZAH+PxKRL+JNwZfh2WDYr3cmT265otq6Z/YSCZKwP?=
 =?us-ascii?Q?KWtkuEf5csZ/rkFhYUsFKSFsN6PUKBUA3mcw6+j20TPnyzAiZJyEpfaHQAnd?=
 =?us-ascii?Q?u9/UxVNZsg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BsmF8AIdXUZtvmQZJWGZWLx40yzOZKs9R/jwBdUJ62Q5GNGqs2sQAA2X13pGgKwmwa5WSwTRGy1/zjgR2Y8lLj3LL/BBM+0GQOF9B5AX3GM07opBQshNY/OauIshvZZaX9keKns1EoCQIZlIgaTWJd7dQV3cJRYAgmZRZP6NF11bIVaVtBWfD03WpxytGytIQuL1nQVfeZPQxgr1KI/wK6M8qf4A0e0B9cKj7E3shMZcM819Q7gUHPaQyxLTjorgFPycou6qiWrSeSWNWLF3zlr6G2FeK+WN9XJiTWcTLdV+jTbbzGfqPlsjkcZ8cf9e/D8Y9h9TrIbUAZ8JHQCTdw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22119cb5-eaaf-4ca4-a1d0-08df23186466
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 19:39:38.0204 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UEumPuMMMjgtH2OX9v2XbannqSTipN1SEXdxkR663GZ6TJt66cXznF2kc+gaYFZOcK4AnHb8wZ4yiv/FSPQKaFbAObiPyU/muPGeB9X6ljo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6206
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
> From: rivaldihormat-debug <rivaldihormat@gmail.com>=20
> Sent: Tuesday, September 8, 2026 8:40 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: linux-kernel@vger.kernel.org; Loktionov, Aleksandr <aleksandr.loktion=
ov@intel.com>; rivaldihormat-debug <rivaldihormat@gmail.com>
> Subject: [PATCH] i40e: fix integer overflow in i40e_dbg_command_write()
>=20
> The i40e_dbg_command_write() function uses 'count' from user space in kza=
lloc(count + 1) without validation. If count =3D 0xFFFFFFFF, integer overfl=
ow occurs.
>=20
> An attacker or local user could trigger a buffer overflow or integer over=
flow by writing large amounts of data to the debugfs file.
>=20
> Fix by adding validation:
> if (count =3D=3D 0 || count > PAGE_SIZE) return -EINVAL.
>=20
> PAGE_SIZE is chosen as a common limit for debugfs writes to prevent exces=
sive stack/heap allocation.
>=20
> Signed-off-by: Rifaldi Hormat <rivaldihormat@gmail.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 4 ++++
>  1 file changed, 4 insertions(+)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
