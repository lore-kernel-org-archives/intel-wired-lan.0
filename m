Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E704C79FA1
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 14:36:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4547880AE3;
	Tue,  8 Sep 2026 14:36:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5gbW59Am42wi; Tue,  8 Sep 2026 14:35:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AD24980AC5
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788878159;
	b=Sr72boA+wunyjyNhkDDcdW0D0yNwgjJ/Rd6CGiR6SAztuBpLWRs3J3ZrJDpjSls5w+Mf
	 yp9kVszYyiIWueHjMsGxITi9RGK6rf/TT/lmXFKjl8kdUN3f2ZMK4H5MmWp42ea5nCTZV
	 s18LwFkxe+LKFpFeTdGHZcAfLN04GzdX8pB55gY63DF9oSfSbAREWaFkki5/kPdXU8WmI
	 uIBjEZityf8rrwLEZn4EJDc8z3u9USYduQEnqni3MerIwJQcgnvIspYQ4lVevaQAyQ3VZ
	 +Sjrz/q9Y1Ykl5SETc9KeIt+bckK2ZoZgA0eAtI6liUeOU+ZT2ldIj9xRSBBch4DO5Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788878159;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 Received:Received:Received:Received:Received:Received:From:To:CC:
	 Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-ms-publictraffictype:
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
	bh=sY4Uz89NV27VkHB8lbwLEwcWSRCNWfi0pK9zDSHiQLw=;
	b=V1kHwUBZXab075fIOFucaNAqPFavXeMMqvPl9PMANZJwewzrAhbwPNKQPUvc3tML50H3
	 FFSXQFW3xt/yXCH6aOxgsw5NkEcLb3r9eok1BiaFf8Ze+tJAZ0q+yiFXegE1x8xUX24TJ
	 rV95TpD/6/xTF58ny5OAO1MqW00/U+kmFvIR6QA6kLLHfvJmnmdK/ucU8uW2G0yOntPfr
	 F+5dZeR/114e0mwOYjuBLcZeBAqGuhbjqRuvHFFg0HNwXycPxuxz5HYwU5Jwsc6CjSpyA
	 teoXU33AnKyBadtNmCdQXvLXBtxAB7RYeqj9yy+fTqtcIIkGNCwH6pz6JseDzn6EXGw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788878159;
	bh=sY4Uz89NV27VkHB8lbwLEwcWSRCNWfi0pK9zDSHiQLw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B2ZGw6XbIaEK4LZE0yRsFx3cgsc3GQHus9xlOE3RARk0eaavc2Rvt5lvbphf/w4yw
	 NGHSeGXCVY5YL8d2/F3R95GHinypRXtZIH8XUBitDM3oOoRzi5FLZ+ZaI2FsO1F1QI
	 mdC5AQzhHbvSKKTVX1375jZbpSSkBfKQK+27K5bNPNAf0fvCm8MaS4lUiwGaZMG0SZ
	 9zz/SSQe1/dFEh7gF78jTyeHWTZcjBqiq2APBXqU5hqFlXi84oUgc/zlR31pWQY+zz
	 1Xtsr7QN5RcRbJhcjp8jEk/I4YFp0oRQPyVtqHFzqahtAIdWYl1hsBtGR3v58IGBf+
	 jPRV1feZ/JkEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD24980AC5;
	Tue,  8 Sep 2026 14:35:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 53B68372
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 14:35:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3A06C40160
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 14:35:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1vswHMPS5x3r for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 14:35:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 07A5540079
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.20
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788878158;
 b=mylUXF+dxGk632naNrbMJgfO+rYJDhfbY8dO44OnJOmsp4ppS4mGadhOrgMGkPs0Pyyd
 rWp3ewYng4fZ+3M2KH9XOdclfnvU7GWwAJXk5IXv1gLZM0FBXJxTYXcIcsTcSRj2Sa2W1
 +mVIrCZPkw9vknAWn9nFb+dY4QnJqdONa2A4pim67EoSBEt3kC40XBmbKDz97c7WM8myb
 Lvn4oEi3FmWXjSwKYFWDarodH/zBoV2FcWEFB3UHAG3Lui2qZ6GZ3PVR3742tm4Qv2Uru
 Xe+ZUwwW2vSVK9UGq87gHs4jWCPfoX3OIve+pyaEQbnN0QteZTXdnzPJUvdnlMX+pBg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788878158;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:Received:Received:Received:Received:Received:
 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=sY4Uz89NV27VkHB8lbwLEwcWSRCNWfi0pK9zDSHiQLw=;
 b=azqGP5M/U1A6AwiQ8ZtKt1Ks7TZxzeuGLZaW0NxrnP7UU/hPPAPej/cG6wY0UDFsUtkV
 AHMeQjBvm8rJX0FC+0ALhv6m1DtcPoFHWBrZ/9gQvWo6l0ZnF2S1x1emLntfb3JFQXejv
 D8fn0ggFkiFAH6TDDza6CQ1Pw1l16kWtp5v67X0haPKnyhc6u0+j00mgMr4DiyXDucQ6c
 3Cm/z7m3jZZUkiQD9EvPaWejpNCidmZlkadk4x8fxbcMBCLRr2zPSBlXO3cn/ZQugiR4V
 bQcFqIW62jFAyHoVUF6GqKAe5n9q7gHiBAEvQa0Bn39A4Ir5pDPKVJYDhZkdsHnlkvw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cd9iDClB; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.20
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.20;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cd9iDClB
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 07A5540079
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 14:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788878158; x=1820414158;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=L/pYwpJ9yKiYqQbj9p3yl7jNxlbDnw1aUj7yijnb+gI=;
 b=cd9iDClBQ2v8DVWQgtQu10MVjOkplaVs0hYyGMHG+MF9DZ8QiWVnqlhe
 qheaAyo5VFRNDK5DNaXyy41cSeJvAhqCRy2eqo4JmTBaWSf4oMzr9RNWx
 pENgAJowARipaFxKkaTGsFaoiGSzZX7UfutDq6sJtGjyB4N3sQPVPpGvm
 x+br70WI2mCzfU/C+5bPFI2FzG9t05l/1tz05Tm/rJXy04++RA64jrRqL
 KqT5SJPYInsobJd7EwSAhvDS7P4d1Hnk91cOpAe7nLcFyd6evF6Zz5qAl
 VJBsbP+sW87iJowLkze7JZz9Mw6KOraN4Nn3yqQ+v5D/vveJsUKKW3czt g==;
X-CSE-ConnectionGUID: xHuVxWV4QFCK8SJns2wwGQ==
X-CSE-MsgGUID: rA9bfOOZRreusVtQwQNEng==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89039981"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208";a="89039981"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 07:35:55 -0700
X-CSE-ConnectionGUID: OgFZAlQtRNOh/UbLvy4UNg==
X-CSE-MsgGUID: lmAZNNKYSxem8SoLbqEvGA==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 07:35:55 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 07:35:54 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 07:35:54 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.40) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 07:35:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gosYrJomSL9TyBGhmxm5au6myWS37JP3I+79JOJ2s3163DVGkuQfULAw1q/LJ6EnNwLfRX4//8mzYmsh86ZJ33H7/BFfAKWAs+GbfDugSpDhzIpIKDLkPV0V4IoRIj5bJUGIStn5tS+sVoNYBDV2S5spzaCajbVSVeL/kXQ1fFPFbMv4gmYhwYWR/lF/wgw8WvBHmaStHXxPOzODP6yphICYGY8ymH2s61D/HsRMSDebMpXWlba7tqGuUPoofyavLvTADZgkIIUAf8VILFLWCZ5WozBWMmeTgblHCYicM2/6Ko/VDfZITaofMH1w+PVOp8xXecp/dmr89aJVJz89nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sY4Uz89NV27VkHB8lbwLEwcWSRCNWfi0pK9zDSHiQLw=;
 b=ylEzLFuWcqb+e/hn7QH8IX7H65ogeHQJZnzaxoBjcpp4g0mRYxfX54cNgtqGQeet/30aGzLRNjVIhufNRPjcauVk4SsAbogbLyf52mEllwiXs4eAjyv8lQoUW+8pTtdPs/Fkpvh46daUkJEgsvonS7n3GR34Q/NbwO1uiYyxi7/nhHTKfCxl66YNHpGYA9riKEtlpZCu2toASg9ShIApScr7BaumQ10EZ5XMIbRHWXdhODddwt/TB2ercyvvtb6UBjd6DTTb9QICzL87uVmiyyOdj6bgYxhPLx3taxwQ/KsMvyj10Jq2IgBwEscXLzKYaRsMcVDSauUfUhVyRn4qXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS6PR11MB851541.namprd11.prod.outlook.com (2603:10b6:8:4c8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 14:35:52 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 14:35:52 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: rivaldihormat-debug <rivaldihormat@gmail.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] i40e: fix integer overflow in i40e_dbg_command_write()
Thread-Topic: [PATCH] i40e: fix integer overflow in i40e_dbg_command_write()
Thread-Index: AQHdPVQeyUfvsqB/TUWdlBJSAxnD8rbEw7UQ
Date: Tue, 8 Sep 2026 14:35:52 +0000
Message-ID: <IA3PR11MB8986B28E945AAA687B05BB36E5B12@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260905163144.17069-1-rivaldihormat@gmail.com>
In-Reply-To: <20260905163144.17069-1-rivaldihormat@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS6PR11MB851541:EE_
x-ms-office365-filtering-correlation-id: 95fc7787-fc20-47c8-e6da-08df0db67bd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|38070700021|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: VKCsr+NiHzJqx7K6QFHksRuqLR/LlcW2mfoqTwoS3cT5HOZQriHDKOHexvYEDakutvixW8/Br/MXjDY1F9ECSxOGuYHDzPO44NYi1z7t9buIz1wepPmlUJx+TWAhnrjXcAex89Bg54nqmZrHs4HOGOF3OLD7qMJ2/fS0HTW2O29zudRPcfgUNR+VOJ2XpLd9u3RtVT54DiSKxN4A2I4DvHGzHSaKh7cGibwAzs1fFmRsKqu8RvOKWoHKHLIsA5F+APUkaACSgzecJSmVBZB2ttwpXxHyy56fEGljvN8i/VbhuhKYmHku7eXxn3voje/BFGiL6ihdtl6v6JHT5BaNkHkxQuCjSvx+8HGeIxbf8qOR+KWbXwifvFH0mN8ad2H6nkgghn1SNdDWwfwE+DMbwD2TKv7oYjIrmCWGBCFVTOsGeGWXMCloWqkmtm6hQh10ii0fjSBBN98HmF9cgsWpJEv65gop7UHKVImLTlJTvGcngY+P0eMf36Hr4E/oUn85raOAHaUGndWLflH+RhDHvHFGziTAtsfCzMiMSINMC88FUkiP9CBegBVJJduZTFU+vI+ftRv4QNeZIa21WoBG0rJc4tOCEmxTX5Luitgl3dpEK2tYXFgrJNe4aChW+ozZScyPnNnAQKfuJwi7oBw+OKxOWTnpEJlmXPcz40eQPTuwjRbOMdhap7NYCBm5vGeOvEynKZLCO4EvlTlO3aO1IG99zyfFoWyQKi3t3ij/bOo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vWLd3LIlexl8/zr2KSct+a5QisZ8HAUsgLYNuXxaYGc83TJAAo+uRWXxcq3L?=
 =?us-ascii?Q?FOvoTjNbo0knC7A6fczMQTGscVn9sKATMxOQD1BXgFyMtEfa5dFCgxWZpz+R?=
 =?us-ascii?Q?8CdAsEq9HQmUjV8Hok8XmBxJkaVG4+XhdjN7O9cqigkn/TO9mh0JI+QNMJ9I?=
 =?us-ascii?Q?DxhdvHAV1+MHUpqvhCoSeNV8RQsOU5r7SzaaRKTk9C1F3Mm5c2kRN1Db8i+H?=
 =?us-ascii?Q?TV79QUqcSS7ZnemFNjBPs9f2Pzfy1ZmdS8nicojD1U89gr865xW/ngIbxBdt?=
 =?us-ascii?Q?UTsgG/IG1PLnrQ3PsJmEzcwO67K0JDRUTHM3jtkUUC5zMsM+YWQ5XQ5HCBvE?=
 =?us-ascii?Q?9TKFsiAh2cyvJSShI7AwY36LngbTY6qniz9htv43X4eVwF5uzuiNB/xnbeUH?=
 =?us-ascii?Q?73+x9dWJ4Lt5GKtCD03lsEUIEBp6+TkaN6BeJOer1/4QRrI/f1atceJXlAef?=
 =?us-ascii?Q?aqR8k+Pncw33xC0i22Gmst4ONeSkk/DREKhCYazf2LU7EJEzQjh3LGy2A6d1?=
 =?us-ascii?Q?GfamoiJu+jNTIKHJatd7U/zEKtAzKXSjCY9lT5AO+OPtFP9/i59+r9S6Bvdf?=
 =?us-ascii?Q?JTgLCeIQgQYE0e+Qr+2Txuhed0wHNEnB6RmAC8vhlBefJulI1IkJe0SWDF52?=
 =?us-ascii?Q?HUnWq2vVmib8A1xIyqmF8U18B/qq956cvqbbUstf+jv3TT2N0mpO3nt828Ra?=
 =?us-ascii?Q?hF2749EEXcGenojwBi39gPrjZoXo6n4mxdJzSeomkGY2TPTFdWzOkl5XlOpq?=
 =?us-ascii?Q?XnQ/Ot56qnT8YTZSwomNLY+MK4yvaErpionNhzNmw6BFEt4drPRUv3V51Fa0?=
 =?us-ascii?Q?IQjojawcDUkL0vqWM7a1kLurjzMlrVORZ7Af2jqfhEsjq3wFuIFf7dzsLvMF?=
 =?us-ascii?Q?62feu237nM57kNpex6S4SywZjZjIHwKjwHqzZ0OPE9XlA3hzmf1iPKZtmmU3?=
 =?us-ascii?Q?cNlXCmhsBXOJm+8gj5vpdLh83iaSD1qkJ3KOU64mWIFUhGjKwtf5CFFkljvv?=
 =?us-ascii?Q?QFQZyJDvW983ADrpM3pVuLLKTObnXelJmxMXQMFHktAVmZly2+NDL8hkSEXY?=
 =?us-ascii?Q?B6UySr1AKk1enrDJaZNsF6dWegk4HgkjUy+Zs/zsfRUK1NzMneVweCRjQDZH?=
 =?us-ascii?Q?hgP1SszSUbPpvtkCsqnORmrXAeGssKGX27PBHkPwOLeKYSPIt8I0PRV8a/Ip?=
 =?us-ascii?Q?SoHia6ZV1mm1fVSQoraUlKAU6qdsHJm3Zh/4BlNhNNENsK8gh/DOijzE2vvu?=
 =?us-ascii?Q?9C8C/89dMdfI4PNsUii7yym0cWV7MwG2MBrYBsmjtaqL8/quq/nn2OVm1w0I?=
 =?us-ascii?Q?C9ADE+kT0csJdeysUAAo6B4UZ4funYkC+A/J3grvKhPY5VZNxeW6HjYKzZid?=
 =?us-ascii?Q?plul1zddkYzLASFRSINzAthosF7p+jvVHxusff1k8Nx2Lin7EQWuuf4h+FdO?=
 =?us-ascii?Q?hdhU/bSbefik5oK58NyBSRCdC0YkD/wRxXSnIA4CbQN8ni2OwU3KcYDWMWJO?=
 =?us-ascii?Q?krBKGl8WAf9eKeZj93p43s+6/1QmH5/d5hpOI0SI9OZxR2oibwXDB1J5FB3o?=
 =?us-ascii?Q?O9M5vg77oHvemVn/PCMuhqbxjd91TKrs0M+BcGUKNK+MxcFXmCAS9sxk5bJD?=
 =?us-ascii?Q?02a0Rw8rJcaTNjHTqW9JZEvBc887IXiZfaL1PueETDrqV0543hGTh7ZIpb/y?=
 =?us-ascii?Q?PyjmjmhEoPPwci+MOoBG7eD45S8AeDS0pFweQq6brYn6DoYxNS87vU8P7MXz?=
 =?us-ascii?Q?RuBZxkkblPXJbco91K1MhMRSHl5OdEQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mph8UzERmsC3zT/4xgqFWMEhQDjX9Xc5cavxUI7J4/xh/1AqC1RyZXcRbVh5daqM9/JnhJcxWiI2ZrIcCC1AMtkWACuWZbwEWWzd+dVpFDqW7ISBpu+tSlt7TaZReHz+xIqtHLnV8oBkVfTXqpTLcu/gV5973Dcek9jONGAdQRf/1Dh7Ygh6idPumdQxQ9L28RZFnb/63CMRi2PawhCFqUxOtf2IoVHZn8Ns9u5wmj7AI5Sc2XYbD0SbiUtZK4Lw3W9eun+DzbNDAbSpMIFP9gQVtVVvSC9RnsYggxnrrIR79jYDSLUbaYnOFAEiHxihub25TaEi9vHFWXoM+zdGmw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95fc7787-fc20-47c8-e6da-08df0db67bd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 14:35:52.1952 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vf8ZGfKHYkksrw4y7ItVNh6aSknJcmTMHPY5foCo0YPxH8mKifC2QpvnMmpnU7C1AhcbQtQmry3MyrqYWspsBF+JWCmD7l9EWeYTpI8R1To=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB851541
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
> From: rivaldihormat-debug <rivaldihormat@gmail.com>
> Sent: Saturday, September 5, 2026 6:32 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: linux-kernel@vger.kernel.org; Rifaldi Hormat
> <rivaldihormat@gmail.com>
> Subject: [PATCH] i40e: fix integer overflow in
> i40e_dbg_command_write()
>=20
> From: Rifaldi Hormat <rivaldihormat@gmail.com>
>=20

Dear Rifaldi,

Thank you for the patch to fix the integer overflow in i40e_dbg_command_wri=
te().
The fix is sensible. However, please ensure your commit message clearly sta=
tes:

- The bug: An attacker or local user could trigger a buffer overflow or int=
eger overflow by writing large amounts of data to the debugfs file.
- The fix: Limiting the write size to PAGE_SIZE.
- Why PAGE_SIZE: It is a common limit for debugfs writes to prevent excessi=
ve stack/heap allocation.

With the best regards
Alex

> Signed-off-by: Rifaldi Hormat <rivaldihormat@gmail.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> index 0b52509cb14c..74e75504fdda 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> @@ -722,6 +722,8 @@ static ssize_t i40e_dbg_command_write(struct file
> *filp,
>  	int cnt;
>=20
>  	/* don't allow partial writes */
> +	if (count =3D=3D 0 || count > PAGE_SIZE)
> +		return -EINVAL;
>  	if (*ppos !=3D 0)
>  		return 0;
>=20
> @@ -1605,6 +1607,8 @@ static ssize_t i40e_dbg_netdev_ops_write(struct
> file *filp,
>  	int i, cnt;
>=20
>  	/* don't allow partial writes */
> +	if (count =3D=3D 0 || count > PAGE_SIZE)
> +		return -EINVAL;
>  	if (*ppos !=3D 0)
>  		return 0;
>=20
> --
> 2.53.0

