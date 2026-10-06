Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20613CA5FFC
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 08:26:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9256D60724;
	Tue,  6 Oct 2026 08:26:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1O5ZLXHkNsGf; Tue,  6 Oct 2026 08:26:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BD0C460783
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791275166;
	b=NSa+BD84q6emYxATx1rUjlrPw5V/jocybwBoXp+ciKp3fqsCusb+AqOU4FDtls2m4X0v
	 7sk3cbDGAIu7EdIV8NzcPxyI+xrWMHiujIv3q6c5kdwzxi2X+FL/0DIRzoFHLP0K2ZK43
	 XVGXTkInN6OPMZLFe8NThLxx26oumy7xoik5E2v8SQQ89VdurA9IdbuFq60WMpdJ/9J3e
	 814HRvuszMnyNtHcYRjgXpKzbGek7z1aiTfz5Qs96Yfa/n3BtKFnfQcoc0U0jaGcydxQ1
	 JvzlEFYp41gVuQtL4R9TarXbWsLxAzZ4baHVd46nLFLe0cRCVkLFizoCt0t20/2TphQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791275166;
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
	bh=EzmATGRjgvcwu4ZJlvyyiEJEOuG9LOaSBqcDH2GdcNI=;
	b=YxQs5faXj/LMQBUEg85qWhxAR74jIFrdLztBq0VjEM+FWAxoUDdI/JGHJ1BOPQOYMT6N
	 sz7C4/Hbsgtr7F/IWdKQXUu0QlM3T99B9B4qKQ/e1HvutyMGvO4zANlnab1EOM0kgNtnq
	 5bIPz2pQ7K6yi0I/jkA2cE0Bss9PesKCiU71U+XZq9lHdUnM4unO6JP8/nw8czwBD29Fx
	 zBHBjBAs8IkhVzaYSkcAdWmaD1QPe51S7tlmsSPsxo+1X1sevHFi+Zt0+onIsC4YLGETk
	 fmqv8/G9HYv1ts3MO+GnbzYSYA4XD/3jmFxlKOet8nbpIIFw15rircE3XAfFgs+FKig==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791275166;
	bh=EzmATGRjgvcwu4ZJlvyyiEJEOuG9LOaSBqcDH2GdcNI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g93CB3R2ByfiFrFxzw1hBXqExztcK9Y0bdi+w9r/CL8+MY2+n9nNX01wrqnDpHGVG
	 lzgGyzuZtfdHzgVzfuKuo9FSttYdGy44I0ppuxCct68JJRoH99U6++xEtbu6P4XYMx
	 EWSRiFQostubF317/hzx8Xif3um9pA0ExgJr7bsZbqu9M2Oj3rVZqMzI7DHA8Fvjip
	 BbsF+AoEel4sx37cbHwGsG+AvK73HTX4H1z8RFQoUADevRmRAslUh5HHz9mG5aQTBa
	 BT6kTlkJjo0CsSOM2ZUkQ8S8cyYXhPZwhSMTRJMCNJ5u7lXFBZiePUtyAu1tX7OUX1
	 w6FfeVWPQHwfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD0C460783;
	Tue,  6 Oct 2026 08:26:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C2181D2
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 08:04:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 315F440553
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 08:04:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eAyk9-EmC8fD for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 08:04:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 480F140536
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791273855;
 b=HTODrJY9W2Ak+3CyVh9wu2CMCYDsKhO2s8oYp3NFxgdPXiIcO+k/AhXhrwf5tFIyfl4R
 jvj2BeQapf/tHRTwzKi5wb/nKSe2H17shpSh7BL0On7xwp+Bz4rPRuHHYmcVCZ9FraOW3
 0So7E6j6wdD8IpexIjlz9kGRfKxn3Ita1rkqP2rXE3YrAa/pxxXe1RZGMenbpdlCxpqaU
 fnf2yvU4vxmdUrnaFMaLOPsju8XgrjMUsz3aJj8Nz4UhN1W0rOxXNqbr6zG4KQxewmjFl
 to1MnCWYkA0rwWK42st3WEAPakp3KFlEqrsLxDs/YuLW6I0JmtfET39eBg2S2Q5sVOw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791273855;
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
 bh=EzmATGRjgvcwu4ZJlvyyiEJEOuG9LOaSBqcDH2GdcNI=;
 b=T5RAGS4aTEXyVHdM71DjimV9neN70h7GPP7M0HmeqTmNHWwcvBOxQzC4hNqmphWtFa0L
 VtCiDcPGhedUfsc9kWeCl52xOOvUWVC7SmBqk6Ud7M+hHFM8GxffYCTntvjKgEfOgoEA0
 QOzKtNxP1wb+DRZJYQmpxjKVTKezMrpx9LOK9s78Vs/hpP4BufHr/Wu47BEQG5TzZq9iV
 iWmlTbI+ZNwZ/YZq6sGy6ctjZ0KpUS0TK9Pgs6AEGz1CsMq13EvCH2cnnarsY098cHKK4
 rrbGYK5D9bMrGorcCqsyMs79xjvBGzi3g7L3nKYtAus7KP8fDV7IRkY84nsG2FPpEDA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=lMJABtfC; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=rafal.romanowski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=lMJABtfC
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 480F140536
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 08:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791273855; x=1822809855;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=EzmATGRjgvcwu4ZJlvyyiEJEOuG9LOaSBqcDH2GdcNI=;
 b=lMJABtfCPRlusWkxTd+sPQj1biYgN6mdzxPlWo15Vy+S/LP6j6WLQopV
 /aVHxstFoWXT8wZcN5UaRj6jiM0zXquHsMSLMXvF1FgixO/NOIP2UahIs
 Od+xOvUkXx83Qi+c+gcu8EQn7kXdqdOTOEwcg4IkqFiffH3rAuC6l53aG
 qC/64PkZXKv21xvLy/xOY1Paa5rNgMfOtPg4Ks63IWO8ZxLfzRw/nGwMV
 yCNk2EUV3jQdW5eqtXBvAAFQBmccKC2rHfUU2vnBUXRecdNGWbey6Ozh+
 TMNx8xWU30+hATKguiCBhZzClPToHCZWzwbVbrQFaMk6xrBcV1/+UPrKf A==;
X-CSE-ConnectionGUID: mrRt83xtSAy8ovymrlakdA==
X-CSE-MsgGUID: 9CpYkKYSQoqoL8Vm+XBjBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="113739955"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="113739955"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 01:04:13 -0700
X-CSE-ConnectionGUID: 8r/YBD1NQeO4orAOVDdJeA==
X-CSE-MsgGUID: 070o/1PXRjqL1BsBJxRICQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="275737167"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 01:04:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 01:04:12 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 01:04:12 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.68) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 01:04:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wPyuQSFSOKeIjfRQkg0BUtWAvGdsCbsdLCJIEpqSY3FxuQ4gUUF/aen8XB1JFiO20PN/ZeowBzFGn51gKDfObT62AtpD4X1d/AvofY6BA6X5HgLblEThK9kf7yxjovV+TQ58juS9DJx9B0Rq5KXSC9yizsLzLaNUGE5h68ugAMISBCBIyTszJgMreqOxIUgoFcNa3a1w+UTT0ABv/dGfwautpolWXxJ5GUdgGblfRzK/IVHNOyW7w5B5YEoEi0zxdLRHP8Jtn/4IQP9rSZg0RtIjJis+tl3HeXcOHjhzr7zmx/FCSS34ECv7Jrx9c/5nOaRSrBLbJI1faJRoiOAIrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzmATGRjgvcwu4ZJlvyyiEJEOuG9LOaSBqcDH2GdcNI=;
 b=jSchssOzsQubNY7Km4lwyv7j5L5in5fu7/gYBaSE1jtqPZHTODZ+BktMt8nL5k4pM6IhJP/qhmg1uQ/dZL4MitCZefEBWWauzBI3f1s0y6gA1dX6rf39mUmy+/XXh0UCnBTGiixmQH3MMxGga4SpwLrwhMF3TP7SDtDNq0RH7jBD7ZL5rMgmqKUE/2SawDeY3FXFOkBW+eEMhAy9JwPNyPpNp6GX3s4nzeBdtKxX16ymjQwao8DHv3xrvQ072iA+N3gVOphB4ILqfIBNKdEJT/62t4ifQgz2J+fxujNAUapO3096WGfxsIJI06rCe78qQz++FwhD7XposrZ/hkd5Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by DSM1PF8C3EF9610.namprd11.prod.outlook.com (2603:10b6:f:fc02::149)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 08:04:07 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 08:04:07 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Tian Run <15503232150@163.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S.Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] i40e: fix VF queue mapping collision with PF
 queue 0
Thread-Topic: [PATCH net-next] i40e: fix VF queue mapping collision with PF
 queue 0
Thread-Index: AQHdRTY7YFIeY3UvUka9yU+18ViYMrbwSAqw
Date: Tue, 6 Oct 2026 08:04:07 +0000
Message-ID: <IA3PR11MB8985CDF1C4A5E1E387D414D58F952@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <178946707899.849053.3626754711268331752@bigrain>
In-Reply-To: <178946707899.849053.3626754711268331752@bigrain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|DSM1PF8C3EF9610:EE_
x-ms-office365-filtering-correlation-id: 72b90254-29c2-4dfe-d21e-08df238065b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|38070700021|11063799006|260925021311599003|260925021911599003|260925022911599003|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 2XZcF9IRUwfxVCBxCfcSZTNq/fMRczonX/ge4i8EhUo0iCCdDQGWOx1Yh2FrAOnsnESQsY+ZLrKmtZNt/mR6+ya1qQ5l1MWXTdVVCTyk5riu1d9Afc3sfp2/0AWG/nE8I3i4enwerD4sKXVEo0nFg8VVeAtxICrOwl+vFpFEIzL96Mqzsz342Mk5o308/2/9OHfL7sPhaMVwAGM32t0JfC+E+9KbpfyPjn+R1nwOFtwjkVEi7KBSB01fWwftz4aIXBV7RpA/a4M7YqmrodMx5NszEbPM0csvbymVm8VNbys0Cn5YjUglKxZ5GN/Ui1o+xHMr2xhpV08YcjQTKPVX3GpHiQ846ip5feb4HQdlNH6deKVewdeOOgD0WFBAAMbz9iDhxpnCf3wHW/Ag4mOHdgui8vTHXjuHgYWo/1H/jXIpeamajWJtkOlGu72aPIGuPUGTB/jPDOLRTrYGGLUZjH6hgPqoEwWgaKcR5MREwfu3kKcCMEeLKE0hlfcxrjGdsuiGPbt5w2pBIMGnlAhD8l2zUiXN4OBTe7cIFkcm0Er8In+vFDFNCIdMQOFwS8MsdyFIsu89WuYPtCMrTHv3XqT7aOIo5lQ1y7gzPfv8oti2BPU+WTgJGITNaqjvGu9UEHl0pfpZ0cVyVG9zhl9Mr1xM0Aev8gjalnPUcD782bQWbbDQfASHiUYYz1SfQ7e8yvF7lV95hite6wUTojrwCiD9TzXPZQGstVIw4gCmfow=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8985.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(11063799006)(260925021311599003)(260925021911599003)(260925022911599003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjZUbk01amJIKzl4Ry8rY096K0R3QmdIQWJQek5BZWdkL3l3VEJCZ1Y2cDBZ?=
 =?utf-8?B?UWhhWnREdEQ0ckJmaStzcVBzUmRTNGdIek9wTDdMWkUwUS9VR3NzbG1uZVJr?=
 =?utf-8?B?ZDl1WHl3ZXk1V2dVOGQ2bWNYK09KQWsrMDduNWZ1ZGI5ODNQNUZZejZ1M0Nv?=
 =?utf-8?B?VEUxUVlNLy9BZ056citTZ3pNWXBJM29mVzd5VktJQmxob0lpUnM5QUFxbVhG?=
 =?utf-8?B?YTl4VHR6N2k5OFgzKzJGM2hRUEF2UVhIaG0wSEZsb1kwZXU3eE9sTTJDZ0Z0?=
 =?utf-8?B?QzgreFpoREtuVDY4eG5kT1dnRElFU0l0ZytmWWMvM3RYUTFqMzdwdzFpSnNk?=
 =?utf-8?B?d1o2MVkxdUt0MU9FSzY0MVAvWnFMdkcreXlVT1haaGVwQldrRm9udVhIbUN5?=
 =?utf-8?B?TVJPSmowbGdBcFJaWFRWWTVETDY4QlNlZWVuNGpkYzE4Y0hpS1NZMDJ3THdq?=
 =?utf-8?B?S3ZqdHhLbC9MVTNRK2tTcld3Wlh0L0lKcjZsb3ZRM1o5cHNGTnB1QW5xenlL?=
 =?utf-8?B?WDlDZ1IwQ3VlaWpyTWk3Y0hzdzVjTG02VlZ4SFRXZVNiK2V2bXVzNHFHbS9i?=
 =?utf-8?B?dkl6YjQ0Z3F6NklQdTBaUmNKWlhpbSswU21XclVHOS9lb3RHaUtOU3BVc0ZQ?=
 =?utf-8?B?aXQzYi82M3FkcjE1S2RWeU9YZ0xNMFdoc0NSQjcybEpJd1ZhY3JtVG10a014?=
 =?utf-8?B?SUdNZHFmbSt2T3BlVDFEMVRHWmNTYmpyU29aMGQxNm54QzlrOENWalNiOGg5?=
 =?utf-8?B?MzVjY0NDT3dSL2VLSjJvZklBdDZkakRrKzY5RUpmdVc5ZDl0Ym5XT3JMV0pj?=
 =?utf-8?B?cG4rS1BsR25lNVlJVlBQZXdhTVFMeVB1TXN2NWVLZnVNT1FlUzV6cyt5Q1R4?=
 =?utf-8?B?R05kUUVwcFZ2QXNadFhvdmx3cDdMZmovMnQ2QUNDR0l6T0pYZ1pkWDhhMUxa?=
 =?utf-8?B?MHQ4MTlGSllabGFSVm0xd01ER25DQ3ZHOEJ0Mk5mdDlseFowdG9OYlNIMXNv?=
 =?utf-8?B?NE9wZTIrRWlXODJyTkpDZzVCdTZyZGI4RW5RWGlINTRHV1A5aTJuNmtEYi9z?=
 =?utf-8?B?WStIT1gyVmFFRVozTVMzVVNRNUJtTU04ZzFYZDdpQlJjRmpDQUdKWWlRREV0?=
 =?utf-8?B?eWRNY0R2U2Q1c2ZLdnIxcWQ4QVpQZmJhZDQ3WWZDK3BCWFpRdTh2OXloekxB?=
 =?utf-8?B?ay9tS0VGTWNLTHVyTzZZbnZTSFc2ZitxUnozOENMT1Q0OEEzUERNOGNlSHlh?=
 =?utf-8?B?NGtZVUxDT21iZWpmcGRIZHh5VEszVVJMWTVoQTVuNnUwU1RCbmtvM1FJMk9N?=
 =?utf-8?B?N0JXMUtSWjYxQTJiR0NZdmxwRHppQ3pLSExXWXJ4NGp1Q1B1WWJzZnM5VHFS?=
 =?utf-8?B?eW9iSEN6NStuM3Y0VzhqTXBIVUNpTWVhYkdNSDFIWlpvL25nZTF0K09kY1lW?=
 =?utf-8?B?Sm80aUlUV1NTbktJazRGOVhWVS9uNkZYWWZYY0orbGJndWxnL1prRG5zUXAz?=
 =?utf-8?B?ekdnb0xoa000MDJRRWRROXFlZVU4M0YyQTh1SHNmZDFOZlFweVB4OUNHVUhw?=
 =?utf-8?B?UnR3OU5aSXJVR1ZPTDZDdHBDM0FUbTF0bHhicVpibWRLQmluUUx6UXh3MXp6?=
 =?utf-8?B?MGlzcTdDZEQvOGdaV0UybXRWQmx6T1pwT25aaldnV1ZNRVEyUS9IUEpIZkdE?=
 =?utf-8?B?Zm5EbzhuOGVXMmhOVkpQbE5PbW9uN2EwMC83WWY2N1hBMStPTmo1YlhtQXdo?=
 =?utf-8?B?M3J2Zi91a0VpazlZSHIyNDFyR0p3KzA4WUQrTnNiOTMzczZjaFNxbjBsQlRO?=
 =?utf-8?B?U0VvRzFuRDBnK20wUDNJaFVLaEs5SDM5dllPUmdYVnhGN2xUcExzVkNBc3A3?=
 =?utf-8?B?NjhJdGd1S0pJencrbnR2R3BJVmRKaysxV3lWcWtieWVCd1ZmdTMzU3RWV3Y3?=
 =?utf-8?B?aXBjeUJoYk96UWNtM2NCRStCTzhmbDE0VmxLUFM2K1ZWMk0zVzIrbWljVWhT?=
 =?utf-8?B?aFBTY3hhREN0RkRyVXp2c3NrSzhQUXlKSTFRN0pJWENPT3RsSnJGd25BMlN3?=
 =?utf-8?B?b01XVU54SUhHTkFGUHdPZnVUdkU4RUFESEVMcGpmZWVxM09mbHNVa0ZRM0Jh?=
 =?utf-8?B?TXNLdlRpTWlFYnB1dEdXZzQwSTJWb1FxT2VMZ3gvM0xtNnpWdGxXeURvZWZq?=
 =?utf-8?B?b2s1aGRRUFVvQlNYc2VyVEtnV05BTHM5bEsyTWpwc2c2bmpMSDROTGRSdzJC?=
 =?utf-8?B?cGNIMkhWc1JGWlV4Z0k1SjR5NlJTdk15UHo1REhJTWpVVlcwbVRLeHdrRk9N?=
 =?utf-8?B?MEVLVDg3SzdQL1hNN09hdUsyQXBmMjJYSmtGM0JHR24xQ29JcS9SZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YY75eBemt+J5sNA9UP76dpgVo5CniDPHJ6UHzP/YhRtQLL0Wffiy/PZBGRyTxdm2JBQyZ8fNSVeXA12KHTtzJ1Mr+xdsEkdK8fdC0LJtdMkKchSdzSyYCqzsxBES+LlZZewGIPP1AO2lzky6r6nWmSvnAhsyqGs0+rM2pUH+4UyPzcKyR7rdN+syvePI+rjygVQeCHIR3LPGjUNbeKgv/z8fa6womXQlK//VF0PTA2edNbWuo/rNT/eLKpQfLlURrcr/UD0GruMrMwVDieBhNrgJxmOnpDXeRbgUb1sfOL8Niu3X74q2QMyRXynxaavAzmtXjobjWAQVoMqINWMkoA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b90254-29c2-4dfe-d21e-08df238065b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 08:04:07.8603 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YGGdxRQvqno5SBy/nac9ueySkcGCI3xLi1gwdNmOHv/pcb+bojG24Pv24ONUJFpp/thiAnkLfiKvyxYxf1Cz/vzlTveXo4Y3dW83uXwmIzg=
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaWFuIFJ1biA8MTU1MDMyMzIx
NTBAMTYzLmNvbT4NCj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDE1LCAyMDI2IDEyOjExIFBN
DQo+IFRvOiBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsgbmV0ZGV2QHZnZXIua2Vy
bmVsLm9yZw0KPiBDYzogTmd1eWVuLCBBbnRob255IEwgPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwu
Y29tPjsgS2l0c3plbCwgUHJ6ZW15c2xhdw0KPiA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNv
bT47IEFuZHJldyBMdW5uIDxhbmRyZXcrbmV0ZGV2QGx1bm4uY2g+Ow0KPiBEYXZpZCBTLk1pbGxl
ciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNv
bT47DQo+IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaSA8cGFi
ZW5pQHJlZGhhdC5jb20+OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJq
ZWN0OiBbUEFUQ0ggbmV0LW5leHRdIGk0MGU6IGZpeCBWRiBxdWV1ZSBtYXBwaW5nIGNvbGxpc2lv
biB3aXRoIFBGIHF1ZXVlIDANCj4gDQo+IGk0MGVfdnNpX3NldHVwKCkgbGltaXRzIHRoZSBxdWV1
ZSBwYWlycyBvZiBhbiBTUklPViBWU0kgdG8NCj4gcGYtPm51bV9sYW5fbXNpeCBhbmQgZmlsbHMg
aW5mby5xdWV1ZV9tYXBwaW5nW10gb25seSBmb3IgdGhhdCBtYW55DQo+IGVudHJpZXMsIGxlYXZp
bmcgdGhlIHJlc3QgemVyb2VkLiBpNDBlX3ZjX2dldF9wZl9xdWV1ZV9pZCgpIHJlc29sdmVzIHN1
Y2ggYW4NCj4gZW50cnkgdG8gYWJzb2x1dGUgcXVldWUgMCwgd2hpY2ggYmVsb25ncyB0byB0aGUg
UEYgaXRzZWxmLg0KPiANCj4gaTQwZV9jb25maWdfdnNpX3R4X3F1ZXVlKCkgdGhlbiBvdmVyd3Jp
dGVzIHRoZSBQRidzIHF1ZXVlIDAgY29udGV4dCB3aXRoIHRoZQ0KPiBWRidzIHJpbmcgYW5kIHJl
LXByb2dyYW1zIFFUWF9DVEwoMCkgaW50byBWRiBtb2RlLiBUaGUgUEYncyBuZXh0IHRyYW5zbWl0
IG9uDQo+IHF1ZXVlIDAgd2VkZ2VzIHRoZSBxdWV1ZTogdGhlIGRldmljZSBzdG9wcyBpdCwgcmVw
b3J0cyBhIE1hbGljaW91cyBEcml2ZXINCj4gRGV0ZWN0aW9uIGV2ZW50IHdpdGhvdXQgYSB2YWxp
ZCBldmVudCBJRCwgc2V0cyBib3RoIFBGX01ERVRfVFggYW5kDQo+IFZQX01ERVRfVFggYW5kIHRo
ZSBQRiBlbnRlcnMgYSBORVRERVYgV0FUQ0hET0cgLyByZXNldCBsb29wLg0KPiANCj4gYWxsb2Nf
cXVldWVfcGFpcnMgaXMgc2V0IHRvIHBmLT5udW1fdmZfcXBzLCBzbyBHRVRfVkZfUkVTT1VSQ0VT
IGFkdmVydGlzZXMNCj4gdGhlIGZ1bGwgY291bnQgYW5kIGEgVkYgd2l0aCBtb3JlIG9ubGluZSBD
UFVzIHRoYW4gdGhlIFBGJ3MgbnVtX2xhbl9tc2l4IChlLmcuIGENCj4gNC1DUFUgZ3Vlc3Qgb24g
YSAzLUNQVSBob3N0KSBjb25maWd1cmVzIHRoZSBleHRyYSBxdWV1ZSBwYWlyIGFuZCBoaXRzIHRo
ZQ0KPiB1bnByb2dyYW1tZWQgbWFwcGluZyBlbnRyeS4NCj4gDQo+IENsYW1wIGFsbG9jX3F1ZXVl
X3BhaXJzIGJ5IG51bV9sYW5fbXNpeCBsaWtlIGk0MGVfdnNpX3NldHVwKCkgZG9lcywgc28gdGhl
IFZGDQo+IGlzIG9ubHkgb2ZmZXJlZCBxdWV1ZSBwYWlycyB3aG9zZSBtYXBwaW5nIHdhcyBwcm9n
cmFtbWVkLg0KPiANCj4gRml4ZXM6IDE1NjNmMmQyZTAxMiAoImk0MGU6IERvIG5vdCBhbGxvdyB1
c2UgbW9yZSBUQyBxdWV1ZSBwYWlycyB0aGFuIE1TSS1YDQo+IHZlY3RvcnMgZXhpc3QiKQ0KPiBT
aWduZWQtb2ZmLWJ5OiBUaWFuIFJ1biA8MTU1MDMyMzIxNTBAMTYzLmNvbT4NCj4gLS0tDQo+ICBk
cml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pNDBlL2k0MGVfbWFpbi5jIHwgNiArKysrKysNCj4g
IDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pNDBlL2k0MGVfbWFpbi5jDQo+IGIvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvaW50ZWwvaTQwZS9pNDBlX21haW4uYw0KPiBpbmRleCBhYmJjNzFlODEuLjI5MzQ4
NjJkYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaTQwZS9pNDBl
X21haW4uYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pNDBlL2k0MGVfbWFp
bi5jDQo+IEBAIC0xMTQ0Myw2ICsxMTQ0MywxMiBAQCBzdGF0aWMgaW50IGk0MGVfc2V0X251bV9y
aW5nc19pbl92c2koc3RydWN0DQo+IGk0MGVfdnNpICp2c2kpDQo+IA0KPiAgCWNhc2UgSTQwRV9W
U0lfU1JJT1Y6DQo+ICAJCXZzaS0+YWxsb2NfcXVldWVfcGFpcnMgPSBwZi0+bnVtX3ZmX3FwczsN
Cj4gKwkJLyogaTQwZV92c2lfc2V0dXAoKSBsaW1pdHMgcXVldWUgcGFpcnMgdG8gbnVtX2xhbl9t
c2l4Ow0KPiArCQkgKiBrZWVwIGFsbG9jX3F1ZXVlX3BhaXJzIGNvbnNpc3RlbnQgd2l0aCB0aGF0
IGxpbWl0Lg0KPiArCQkgKi8NCj4gKwkJaWYgKHRlc3RfYml0KEk0MEVfRkxBR19NU0lYX0VOQSwg
cGYtPmZsYWdzKSkNCj4gKwkJCXZzaS0+YWxsb2NfcXVldWVfcGFpcnMgPQ0KPiArCQkJCW1pbl90
KHUxNiwgcGYtPm51bV92Zl9xcHMsIHBmLQ0KPiA+bnVtX2xhbl9tc2l4KTsNCj4gIAkJaWYgKCF2
c2ktPm51bV90eF9kZXNjKQ0KPiAgCQkJdnNpLT5udW1fdHhfZGVzYyA9DQo+IEFMSUdOKEk0MEVf
REVGQVVMVF9OVU1fREVTQ1JJUFRPUlMsDQo+IA0KPiBJNDBFX1JFUV9ERVNDUklQVE9SX01VTFRJ
UExFKTsNCj4gLS0NCj4gMi40My4wDQoNCg0KVGVzdGVkLWJ5OiBSYWZhbCBSb21hbm93c2tpIDxy
YWZhbC5yb21hbm93c2tpQGludGVsLmNvbT4NCg0K
