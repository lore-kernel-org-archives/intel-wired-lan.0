Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102D5C982D7
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Sep 2026 18:24:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C375060DBF;
	Fri, 18 Sep 2026 18:24:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uS8P9aaA45_h; Fri, 18 Sep 2026 18:24:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F2B3D60DAA
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789755860;
	b=BelNAzaglHN3uKRBwr4GfqqPUn3A8MVIIycrpic8HskYOyRciU/eyTF9MWTKgkZPgSZN
	 uv/YzL/AFjnZRIAzoQuAVE0kvCOMa3QDPjuEV8uxwT11a/x2OM5LDKEN6e8+mmmM1h3SA
	 SlvYxVw/7CGwhbn5syUpobGXEtG2Wj5ebvk0eBTP2OxlxfJcL7r6PzDmYm7YjCt4gDu/u
	 1Lc8yFN54NDBCv0/GurslP2wVFK41l3Th9T8me+GnZY7vkNBv+U/N+24VXAN0m95RO+QP
	 +cI2MhGXav+MCCpNUsnjc97YaTlBs6ViuqtAmuEXDfTIxD4jyTy4mp99UEV0SchUJdg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789755860;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 From:To:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
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
	bh=mxMfBs02+S8sGGUqxRgq3LUw+W+74UKiqCAICR0EyLc=;
	b=KWQopagvEFQY7q70ZjmnaXtFU1UzNmCQnKbnz0yPE8YX3/pwvFwOXYaQwI6lrhs7sanH
	 BRsYx4rYVtFkOcLWSCJgelaC1DdGUNPH3UKOgV+fYvYtYGr3k5ChQ7RgohH+uwC8I/0T/
	 lQGGpakCp1TrQx9AY2HTqGHmFM4R9oudQJIwmBKWXAUCjF8VMRMQKbxSjatQDZ8odekuz
	 wcT/M7aIAN5S171/2p/1eKOslplCy9noQdAPXQTA/8i73RnGJRuNOuFCqC8hXXbDzDZi1
	 mfI/V6RVUhu9RF37qKZjJZQjpjfB5/pd2q+4Vl+Fr6zlZ/C64hw4k4M3ODjNMdQaK2Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R3WMvGPJ;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789755860;
	bh=mxMfBs02+S8sGGUqxRgq3LUw+W+74UKiqCAICR0EyLc=;
	h=From:To:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vXHcVl5PC2ZFmLN116Bj2ozgG1cgbwhJ1LqX7GmJvqYW4PgphtK9CPjy6cFzXm2mb
	 eo0CS+2KwsTnx8ymUx7mauEUac4o/BRN7hUgX0In7y/n2sYDh/OGWg221fgu24+RdR
	 EpzQHYaASw3FfC01YDKGBqygabXpXiRgYz1Ro/dgmv83xQjt60gGUQnBJGEmqAYQJt
	 GjukJZJ6ieGUfoxORlDL9MT+16dcSr4rtF4X3YD16wdV7QSbDA4HlWh+7xjdEiJ5Ao
	 Ztb6gWGCbCRTp/Wl9dJb/kRTkCxs9nUd6dyDdBLkFX1HdB87ZOoaMzROCAEp8NZrtI
	 Afp1EOhuqQuQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F2B3D60DAA;
	Fri, 18 Sep 2026 18:24:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 278A53B9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 18:24:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 082D560DAA
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 18:24:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yr_5c64BWDXY for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Sep 2026 18:24:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org ABE526083B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789755856;
 b=L+kM9mci4+Z9flJlS91B4+zLhvSR+T5ca6ybYzQlAD6YEDs89tCqVR3gfw2xlUB3/t4c
 pnDFBGHN8WafkJX/lwHrbF7KtZPf05s0Lmj4gdFPJhEQ/fOC+p3qHsbJRARHj1Ms1Css/
 yjcNrm147q4SIXdCiX0Gpvro5uKeh99QLfolPQ+FL5soB+GL8i0HzdDMslz2DOy6llsE8
 0sgYxaQNjD0ozVzQIKPkZb+ruxLHCEyw3a9+y7DswKwzkT1slAqfJtKK+/CwY83FzkvMW
 eE5H3HIa9GMvvsUGCTQw82O37h03xA9qagbk2kAWDq7EuYv4H2yu1HAV247gNsB/Gew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789755856;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:From:To:Subject:Thread-Topic:Thread-Index:
 Date:Message-ID:References:In-Reply-To:Accept-Language:
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
 bh=mxMfBs02+S8sGGUqxRgq3LUw+W+74UKiqCAICR0EyLc=;
 b=Ee6/oIK4rZnvRHuBT8bSFUZT5PQJ/FGIcb4HC/65MWz29UBj0yAwhjUz1gX4pWikBfXy
 2Ha6+Q5pwNZVrchdxAFHoKj81TKOBVL9KZtTll5+enNYuB2Dz+qjjyfSPfKQuvKEGnkhj
 ANkIBFthrN8GV5S/QnypyRHjAfCcEfVPb3TR+BcqcaH008M6Sr1eJzyzQ7y459kXzI7ji
 N3tV2GsOMDrCelWNOFHjHabcv1kupXkqsj1ahFXf5vYVhoVyaB3L6s02fZtx04BYpR436
 6VEyNh2Q2utIHaUOt90nnGaJERrNLQfSzBr07EVXDSIdRt0ayR4mXLXs1sbCsADb+6A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=R3WMvGPJ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=R3WMvGPJ
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ABE526083B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 18:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789755856; x=1821291856;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=mxMfBs02+S8sGGUqxRgq3LUw+W+74UKiqCAICR0EyLc=;
 b=R3WMvGPJABk+uiehl/VYKry69rz4h0/Goex7svOZuJo0dkDOI2KTN6eb
 Z4NBwn5oLKpPLSShxCnVL3a5t3Uw84VPMFNzr0A5MM3pDaJMYImaPk8l2
 /WV+wkcyYgl75gpxC+JZ5BFSQ1kFSV4GrighfZ6QM4IErgBbjg2qi8Lnk
 9JS2ewsE1O1Q+T7JYDxkIbcS+1dC43Xwm93lDc6DB6fZEeVlc8c9y6V6B
 7tY37LZg6jJulsEn1C118T54nrzq9uUmG0HsszsqCGxpxLsUNhc/ADAih
 hhBmspQt2YBFWDib9wf1BkIutdvMStGBFskcGHk8XKd1+XX9BaxgdUUxq w==;
X-CSE-ConnectionGUID: oxzSjyYrQ6mSruL7EZ3IJg==
X-CSE-MsgGUID: Kt5dU11cTvOZdx/7uwD0mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="92789873"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="92789873"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 11:24:11 -0700
X-CSE-ConnectionGUID: XG41QjisRUq7tvD1lBRAFw==
X-CSE-MsgGUID: dwMJkuAmQHWmOp68MUUJlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="270226818"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 11:24:11 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 11:23:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 11:23:59 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.37) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 11:23:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GgKWi194GWo9CRqRPQGhWBurMunlYyuAH9mlHPIpfl9JcAZZHfXtkwj6HdzeOSm30o7MKdy6VSTzfYWR/lPGxIh1qEqBKQYuAmRnjKiFJjGCEImmsPqkOydiCckzPr2Sx2KqMdzTTaY7vKRGN4A+xFxK4ZqDtJPIunB7effB9HZPYxcskBKwqOA2RizlQ8nJ/9ZRTGSCgHihvosMr81lN+Fpw/mpDP3K65loXlKtuvO48yEylFI4tSFFjrqDzJ2M+rcDgQEgX7KUSeZXiTICWCWJvZmgkAPmqau2jEaM1hR5aCSIDJWJ9+62KTWx1gZGNgsdrX4YZrQzDKmlXedBAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxMfBs02+S8sGGUqxRgq3LUw+W+74UKiqCAICR0EyLc=;
 b=Y4unWwrxrhXD5++qMKBsu87G4QhltqN0laYpLBkQPCTAtBHVTqEEzuy7us0nfqqrrjraDX5OkwQUf8uf9AssnqZVNNyyXKTXGEagHbBqO4Ix9zYxFGBnrjZKw4JtN2WEkmE+DRPUSHikXx55tDQ9O965hue9G6yEfJTBAv7C1m9nigJIXt4Y4Wulk7bbjDWofePtHjV5/QhZ5YCLCIQI6STjessMIwmPQrsR9vFJ/VWrcbR2F/LYp9Roxl0OX3Dj6Us5GvZhjTIHQeRz2iy45p6iOyjzwiidgn+bMBpesSKtS/TcNPB75Q5Cbm13yn9SEaaSYUXjgI0vv5Q+muuyAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by SJ5PPF0F15BC42D.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 18:21:47 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 18:21:47 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, Takeru Hayasaka
 <hayatake396@gmail.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, Marcin Szycik
 <marcin.szycik@linux.intel.com>, "Czapnik, Lukasz" <lukasz.czapnik@intel.com>
Subject: RE: Patch "ice: fix empty PTYPE set for GTP RSS profiles" has been
 added to net-queue tree
Thread-Topic: Patch "ice: fix empty PTYPE set for GTP RSS profiles" has been
 added to net-queue tree
Thread-Index: AQHdRkHkT8xF/ZdKkkSh/TJZ+6dfDbbTFvgAgAGOXhA=
Date: Fri, 18 Sep 2026 18:21:46 +0000
Message-ID: <LV1PR11MB87904135610E206A937033D890872@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260727225659.Cz3qz%anthony.l.nguyen@intel.com>
 <CADFiAcLvxVh=E9Esjh1fQBVqtu-t_=8hyTCW0_dfb2VTKiJ6=A@mail.gmail.com>
 <a1a0545e-730e-40bd-9935-8f5e3fc5dfb9@intel.com>
In-Reply-To: <a1a0545e-730e-40bd-9935-8f5e3fc5dfb9@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|SJ5PPF0F15BC42D:EE_
x-ms-office365-filtering-correlation-id: 6d4e888b-50fc-4fa0-4209-08df15b1b33c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|4143699003|18002099003|22082099003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info: o8IoItR0C9Goouj6QYSNg5leKcyJseuDhPE+IgL9y/Kkg7yeE3ofjx0dIscZWotan8yL0f2hNx0FYGIQDhm2mp/d+eH1ZkTJxiLc6uMxuK3rRto3qUxqy7jRY1lF170hzwU5LbdIB5cVnfFxHyiC7W8UkSPhA6PMxol05MtvH7C71mhi2h7DBuq5hAyYrST0DK3jez/4wYux8vDa9kveqpLeOCdWXObLos2/bAQu/CGuKy8BdDsTiEB+n/qNW8Q3m0DhdjDIyt5CuG9uka0wGPBEFWjC77ea56TJTLkPOaJfEOTjFQdRzTt5E4Qv95LDH9f3SZDJDZMPrL7uwwY5SFGbl7tgjts03kXTkdy3+yUsO+Dp8J349OezPEOALN+jZoAGaY0gNLgUtI5+M9RPdRVTsNxX9Hlfu+UcqyCJ37UASLL/dU1tAqz34RrbkzfM9xwavG3wVHOZ3BJN77VXc3V4HtD3B1ksFb1IR0T1CyPf4kBzOarh2/XrF5QdNU6ZMFBSjqfr/8lkJR+3DbO0eJeIwZY9Wus3Etj6zs0ANKkcG3N8Rr8L+Y7uaBl75cdCac0vl9iu/Pbsd/BP/MJl6GId59DUa5t8D06q+ZCnwLBhQFdpV1sJD5WBamK4uesDh7Wp1RwKvpsjbWkn+rb6WF1Nf7kAyDmBxoYevSeUcFi3vHrimzMSw1oMY2vbghL2/Ci5mf48nG6FbgFkCipS5o6SF0AiPGw1CdoPSh3VBIE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(4143699003)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emJ3ZEF4am9kb3hVeTZuMHd5WFNZNkNPMXJRQlZxKzlpVWJGUEdmUXRyeVFy?=
 =?utf-8?B?UW13czFTaStidFRlYktBUW9TdGNzMVEvVEFOQTRBUm1laVBvQXMwTUxGU2tt?=
 =?utf-8?B?NE1HOC9NclMvQ254TEYxRHpSUXRCSGhLSEpUZmNZaVJMaGtyM2tCVzB2VitR?=
 =?utf-8?B?L0Ezb0VySXhRN0lqWGl3T20rYkpRcWdBVU9DVEZLR0NuRVF2RVFpd3JwOXFk?=
 =?utf-8?B?WlJLWVc0b0tLL0RQUUN2ckwwWHFWOFFnUGRlUzIzdnRHODJIckg3MGpvS0Vj?=
 =?utf-8?B?YVA5WUoxY21naUV0TU9WdzJVN3NXN1BvVzlpVm5DYzhBRXQ2WGN6NXZLUmM3?=
 =?utf-8?B?RnhGLzdpMTM3aFJPTzdxdTY3aHdaUnFSR08yV09zbTVnbEFKOWlQQUJiWGMy?=
 =?utf-8?B?R2k2UlpaSVNmQStXempndmM5RXdvNHR6NFlNRVorc09Lb0M4YTRTek9DRTNh?=
 =?utf-8?B?dER1b0tnYkt1T2xrVmFiblRkenZoTENuZTU0ZERhRHlBTnpnVFVVT2hZNmNn?=
 =?utf-8?B?MDZTTWNLU2dwM0JWVXNGREpnUkQ1YlREeHdPUmJVbVZEZFFqK1c5SHNxeHJ3?=
 =?utf-8?B?V1pHUDBzUkg0UWVIYVdJV3plYmlZQUl2UlA3Y2MyeS9NQlR1RWtVVHdlRTdY?=
 =?utf-8?B?a24zaTViOHYzMXpBOU10ZTArUCtlSjM3clp5Z01pWjUxbmFEUlBBaElEbVcv?=
 =?utf-8?B?V3Zkd3RWNFJFbFpJdmR5RmNHZXR2QTVBS3hSM2hpQWJRZkNWZGFqdjN2TzBX?=
 =?utf-8?B?ZlBDWVpmS2RpNTJQdzgyYW9NMEF0Q25Dc0hLZGgyNkFSay9xMVBZaWNFOSs5?=
 =?utf-8?B?STNXMlpabWYvZzM2WEhlbEVjamZMQVJLNmF3S0RySmlrM3F2S0xtay90NmxL?=
 =?utf-8?B?WmYvWTcrTkhkUUl4eXZHdjZnQktPbW4vQTRHK1RQVS9zejBJb3ZJMVZZVGxs?=
 =?utf-8?B?TmNtcjJyNWZZMXoyeFBER3ZmalpiaitCbUFidjl4OEdzNWFPeEQ4eTl6eTdj?=
 =?utf-8?B?MGZDMFhWMzhBVmxYY3Z6OHM1ZEVpMTRyTjg2bTFzSzBSckxEM2hhT3JLYTc0?=
 =?utf-8?B?Qzl5V2ZvbDBZb3hQd0h6Z2NwVzdUcExvcTVxUkg1cmJCN1VjVmdRVnFYRXgx?=
 =?utf-8?B?NmJPR0p4Skt3emJpTVdoR3pKZHhNWjFvQ2RuanpWcWxPQ3ZBRWIyZlBaejIv?=
 =?utf-8?B?akxsS016blQzd3lUL0l5VEh6TzJWRUl1ZFp2dlh1TGtCUmREbkh5am9rWWZR?=
 =?utf-8?B?VzNXTVhqVFV2Y2xVTjBYSFltZ3pTRlhLWUZiWlhIMzgvZG5hZzNBb05MakMr?=
 =?utf-8?B?NVJ0SmFHN0NVVDNsK2ZwRG15TWFjSlJ2ajNoVHVqMUtkbmRmdUtZdFIwRmRF?=
 =?utf-8?B?TC9HOGRxQzZndnV1SE81LzJWVXpGYVEvUlJwK2JlNW11Sno4TGU5YkNERFRZ?=
 =?utf-8?B?MGg4aE10NWM0QmJGOUZKeFNtN0pJcmQrZGRPMm9JU04xMkhPUjNhSjRCWmti?=
 =?utf-8?B?SURJbmI0dVpmYW9NTk8zMGpxYXFCUU5sUVRWTWZHeWZIdlpNZVlEMmhyRUV1?=
 =?utf-8?B?SDBZemcxRUlBaTZaWW9GdWlUK0tSaDJ5a2FMM0F2MEpuUU5ZbmpobWFFSzUx?=
 =?utf-8?B?Zk1CVWIxdlcwazhEbGloUG93aWFoa3FzUVVLeXFQRitUVnF0dlZEb1lXUmJv?=
 =?utf-8?B?QlFWcSt3S2tIRi82R1FFWlZzVEZqbE50Z2RJRG1Ma1FsZTlTM00yeElEYnNv?=
 =?utf-8?B?ZGdLcnpGUm9NU01ORFJJZXlSVi9UWmtmMXJXbVJZTWp5WEtndENmeXBNc1lQ?=
 =?utf-8?B?cnJNbi9PM1J0WXhSR2l0ODNsaWxWSkZudWZBTVRFYzJ1Uk1BOS9KQ1pGcGdN?=
 =?utf-8?B?cmJ1SWVQTVdLNG9MeENRcWoyTE92RktIWWhCZnE4ZllFOW5rMFJYWElpaEZD?=
 =?utf-8?B?REZOd2YyTklVN2ljakM2eVFjWFZMT05MLzZFWmNkS04zM294Ylpkb3RTbitV?=
 =?utf-8?B?aXRSRDE3ZGo3bW14Vjl2U2FFaXF6U2dxYzFJQ3pMZW1vWmwyeHlob2hRUTFR?=
 =?utf-8?B?aHFuTHBTbW1ReUpydlZzTFRpMnNMS3lQVThidG9MNjJMWUVBbDZ4VS9yaEVr?=
 =?utf-8?B?am1tb044WWRaWUJ2V2NsTTdSaGJlNVpaMW1BVi8xQUw0NGZzTit0bG1SRFlS?=
 =?utf-8?B?Um5rNnBCKzFHUDFqQXp1T3d3MDhNa0hWV1h3YTgrRzEyUjhlWWZVdGdyaFJ5?=
 =?utf-8?B?bjd0N200Y2ZyU28yRnRvUDMrTFhwNFhZaHU5dFRRcjRrNUdiQlhPeVZhSVZK?=
 =?utf-8?B?QnlneUZpQUxKMkVtNXNoN1lGM1VJNnVOV0Z6bVFOZlFRN05GNU8wQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: boHhzFfKE9G66DcYAvM6xjVJUEfW7PzvJD9yIyDeor5jrTklr4tYOclTn6eSKBTF83ixw2Jll9VD1UYh+P3pjaa3NHaQmDqkL00TDWoHj+87XeEuAMo19qmxWcXouUW1sgbf7Q38xvjAmtNDZg7LHHmw3FdyIdym1VyqiCHQcVHu9HNXenTAJSUQS3uRKwqjhoPpbcXAQ2ib1gY2qejOMoqsPu+Rc7qj4pnY1G+UBJUR0gKREz0/CS9m278JlgPFEtW/x8oWYvBq5nZTw6CW9nMxsZj0s4x1WKV1sSZWtHEI0eNPXznnarYNFKLVp4BPURqPOVi1++HEBdCl1i1Qfg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4e888b-50fc-4fa0-4209-08df15b1b33c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 18:21:47.0030 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bkLfZx/L1jbRAel1hctNA9b7GRZi9BoDUe8NnMDIks8+Uu7ukXTt5FzWFyGed2k18QRQnrPsvcAeaOlDE2IQV5kJs0X0c6u/oIac/7brvlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0F15BC42D
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

T24gOS8xNi8yMDI2IDY6MTMgUE0sIFRha2VydSBIYXlhc2FrYSB3cm90ZToNCj4gPiBIaSBhbGws
DQo+ID4gDQo+ID4gR2VudGxlIHBpbmcgb24gdGhpcyBzZXJpZXMsIHBvc3RlZCBhYm91dCBhIDIg
bW9udGggYWdvOg0KPiA+IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9pbnRl
bC13aXJlZC1sYW4vbGlzdC8/c2VyaWVzPTUxMzcNCj4gPiA2NA0KPiA+IA0KPiA+IFBsZWFzZSBs
ZXQgbWUga25vdyBpZiBhbnl0aGluZyBpcyBuZWVkZWQgZnJvbSBteSBzaWRlLg0KPiANCj4gSGkg
VGFrZXJ1LA0KPiANCj4gT3VyIHZhbGlkYXRpb24gY2FtZSBhY3Jvc3MgYW4gaXNzdWUgd2hpbGUg
dGVzdGluZyB0aGlzIGFuZCB3ZSdyZSBzdGlsbCB3b3JraW5nIG9uIGdldHRpbmcgdGhlIHNjb3Bl
IG9mIHRoZSA+IHByb2JsZW0uIFRoZSBkaXNwbGF5IChldGh0b29sIC1uKSBpcyBub3Qgc2hvd2lu
ZyB0aGUgZXhwZWN0ZWQgZmllbGRzOyB3ZSdyZSB3b3JraW5nIHRvIHNlZSBpZiBpdCdzIGp1c3Qg
dGhlID4gZGlzcGxheSBvciB3aGV0aGVyIGl0IGlzIG5vdCBwcm9ncmFtbWluZyBpdCBjb3JyZWN0
bHkgYXMgd2VsbC4NCg0KSGkgVGFrZXJ1LA0KIA0KV2UgaGF2ZSBmaW5pc2hlZCB0aGUgdmFsaWRh
dGlvbiB0aGF0IFRvbnkgaGFkIG1lbnRpb25lZCBpbiB0aGUgcHJldmlvdXMgcmVzcG9uc2UuIA0K
IA0KQmFzZWQgb24gb3VyIHRlc3RpbmcgdGhlIHVuZGVybHlpbmcgZnVuY3Rpb25hbGl0eSBvZiB0
aGUgcGF0Y2ggaXMgd29ya2luZywgYXMgd2UgY29uZmlybWVkIHRoYXQgdHJhZmZpYyBpcyByb3V0
ZWQgdG8gbXVsdGlwbGUgcXVldWVzIGFzIGV4cGVjdGVkLiBUaGVyZWZvcmUsIHRoZSBvbmx5IGlz
c3VlIHdpdGggdGhlIHBhdGNoIGlzIHRoZSBldGh0b29sIC1uIGRpc3BsYXkgbm90IGxpc3Rpbmcg
dGhlIGV4cGVjdGVkIGZpZWxkczsgd2l0aG91dCB0aGlzIHBhdGNoIGFwcGxpZWQgdGhlIEdUUCBm
aWVsZHMgYXJlIGRpc3BsYXllZCBhcyBleHBlY3RlZC4NCiANClRoYW5rIHlvdSwNCkFsZXhhbmRl
cg0KDQo+IFRoYW5rcywNCj4gVG9ueQ0KPiANCj4gPiBUaGFua3MsDQo+ID4gVGFrZXJ1DQoNCg==
