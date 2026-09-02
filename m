Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98EBAC61DD6
	for <intel-wired-lan@archiver.kernel.org>; Wed,  2 Sep 2026 23:49:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 490C3810A3;
	Wed,  2 Sep 2026 23:49:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6IDZgED8BWOX; Wed,  2 Sep 2026 23:49:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8160081007
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788392976;
	b=WlX1PMYaH7MoAI7CLFXxE4KqowFOauNt8ns9bNacm+X7PZjnAjnAicIEBUZ/KOQFYSbO
	 KS+0NcI0NYJ0RBYPLzHET7bef7ZTyRBv4dfmaMSlDG1+KrjBwFom+Io/kyprKg83sYW5T
	 v44Z9VK5BZYh1xq+waiPsMQHLzlKVFXWa3VOx11HZrPlB/PmDXfeVO9XL5l9gfECu3JBZ
	 zM3vZxbTZxw2aMDHsDBz/M1w86XZsABTsZdqwHU5sp7MaDqbd6/9M/d+2REUNim/ODXP3
	 h5vl5uWZtnkVloA+iXujoOT9vF04yxC0nJdByzeiJwCmdfZVTZBwtmpsyTPoC6BQ68g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788392976;
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
	bh=i7q7Ei8VfFHVuVOomXbUeQDwXqBX2IPtut7/ePXrOKk=;
	b=JtBlAffLaQCI2ItQXRy8bveqpMsgdeh7NZPs9M6n2ZqX/KLrW9DCMO8NRxS86n/URAh3
	 E/+pI5PKCGhBNkm+EkGeYzlGxXCimHetkEpKg5oaUC70RMjfooVbjgF4jJAQ9xNnCR4KF
	 NewUxMwYgOEpcD1itu1QZwBWlyytHPXDChCYalUvIjyvo605UGt7CeDALxaxiH9eDWJem
	 0lL4grvq5wHQCEJ6bW2Bh2+kMEaNo6C05bGs4KOxCBSwzI3b2PIS4eO4fWkyOPDZeVnd6
	 DPyB3VxdSpg6vAOyZW6rDlHjrPri1MDwG5sGMQ+WoRupj9+SmbsqAAbjA4nVGe5CD2w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ny4t9vfU;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788392976;
	bh=i7q7Ei8VfFHVuVOomXbUeQDwXqBX2IPtut7/ePXrOKk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=3em1qMnbHXJrNQm7i8JRxULawk8+z4W2dfv+LRZ7IljQo47SNEIlwtAWXjEDtFXKu
	 LaGkfDvKWyCJNRsWsP07fhfK8wAZOAkNPsN3OC0YHgUIimaUeJbn07xsD34sgPMYVi
	 eHSrAwWS038NnLP/HVTbLw6SLnUHh5/hXgnvEMkQijoaEWDAZw2JWrmvZ1jTo7REvE
	 I1UqWZ5On6IHVSiCUlUMGOsUaB2mjAu3w4jKkg+u9XXmxxPcx7jnH+fa88uTP3u0Dm
	 Iosd3DXaURUDwS2SlDS/9kJPoEaRIPVHAzLEZAGwbn07PscilZtaBdTKlAsVHof7Zt
	 wx1yPcSgnRyYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8160081007;
	Wed,  2 Sep 2026 23:49:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EC1E722F
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 23:49:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DD50A81007
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 23:49:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yj2QyUgQv_AM for <intel-wired-lan@lists.osuosl.org>;
 Wed,  2 Sep 2026 23:49:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2D58B81003
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.18
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788392975;
 b=s6SHwp7PbYo0DTN3mWO/4uMGOL3lbLPr9+txJKTlgcbnxtxWXo/yHtBTIYdp6W3gHrtx
 ZBXIiAhQgn90N3A5z/CeUEulHuVwKGHqeIH6+b7gvAARjJj/jFBXHDwkC3bFGGiUkCPbG
 dtL6FXyLf/Q+3SuNTUuIEyER0N1LiNIdq5q0/TW5xSZWpV3NF9hJ8SYKQ0hBTV34WxHLD
 LzWTB92+nFrvMDKPN5Me9K3NVxULp22RAwPYaV6Ok5cKxLxopcNmYraPopMsYA0xDIgGV
 ErK1ONZw5fA6ux2qEFpYsa2YRSTyXWTBK/BUnlYjE5Y4XutcpkDYYLTh9B0Myma0tng==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788392975;
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
 bh=i7q7Ei8VfFHVuVOomXbUeQDwXqBX2IPtut7/ePXrOKk=;
 b=mhbGP/I1/nFkl2w8L9GSEnNadla8aBMBe1qJAcng3xNJypIC1om2sIjxbV4w/SDhBG23
 y0XlZa/xza/AdD32nOBjw2p37SGwwc/HarjRnPbuucnEN0mzVPOkPS+IJywgg39zn9SG4
 Dm/llJruoKdEHtHjA2hafx45DS1yEDyLLAm5jG6hxg+29y2s69odQOzlnjonJSjTSZNBT
 Y8dzpIpUseDLqTI0aEKtrub6dxF2zMX2ZQ4i0JSzRtSqajnhDqsBoA9nx6UcmBvaFjeqP
 NzkMUh0AFRayzGPoJw62/9fdYkPqhbMUXnsVEXlJ4Fb1kH66YcZniK+r5tYVgY0hZgA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ny4t9vfU; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ny4t9vfU
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2D58B81003
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 23:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788392974; x=1819928974;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YphwSgpeyPTYPWsAyhYluEUhtzyRjssA/H7UOa0fmmo=;
 b=ny4t9vfUE16MPq3DI0oZvZ9vu2Jmq3zlZdusG+6BqEfILLACuEd6H9OG
 WDU/H9W7mLLoZA9AfgYoU6mB+y6s9qr3B7HXOtIf7M4XwA/veVANnbcgU
 Jcl6pdCnbUI+uLTTsK/KtWGe9UYjLHZoAtfsmrChOGoSOUeUTEYGpfDWi
 4vp0w6cLGP2XW/4gSkqL8FmkLJWAzZsZkaZHR5Xc44zvFESaKPRxjPpLT
 5JuvCrvx1eZHqDqfxZF6LACajqERxBrYY/X2rv+r1MgbXF9PLVN3p2U1i
 0KP4/23ClfNpy/rw7mYRb4DetxhK3MUqELuru6rXtZRtkCswfiTZbDtlY w==;
X-CSE-ConnectionGUID: 0J0fxCSVRhWWkPj3BpHhXA==
X-CSE-MsgGUID: QHJEKI40RQarnjKfh1IfbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88915604"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="88915604"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 16:49:31 -0700
X-CSE-ConnectionGUID: FsD1FSWWRw+z9eUPD3yN1Q==
X-CSE-MsgGUID: JjYL8DfXSGCd1QSE1VOS3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="274842514"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 16:49:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 16:49:30 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 16:49:30 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.11)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 16:49:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snLaBy5/TFy0YYSOOrIP+OtlSdhvKrDVvafHitu2gH+DtU3WicBLeDs+aZvy93zLoqSG1D+zOiJZergavE+0iu0AIB1utZX64ffsZL7hUpeaVc1mTYn3cqpnzM61YIHb2hvnymXOxFs6I6WOfBij1O1jaO1gWOAGr8goNojpHJZRCkVvVTCJzK13GjFmDOdH2nuI0AMz+VmEeibLh6PqOry325pDFKvoZ8cE6Q1zzerarkrwljzReAnQc3kEYy3gtro4lUO4wpuUWI8SXH+/hEONHpPBaD5wOzgb1Z1hoVSMB86xT62E7Ygvlo5MlSuwxrOUkXGVuPV1Hd1hFKMHUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7q7Ei8VfFHVuVOomXbUeQDwXqBX2IPtut7/ePXrOKk=;
 b=YkYCsfjA5oiOZl9jAMPB6QPxD7gZtYCrovZfOga6u1934w4zXdWqRZzAYJxG1+NxTh81KTbar61zfLCbKwIB6nPsf7Fe+0u4D/l7jkkm4K+SEnl5MJkzL1IEiXK53YVeMgQwepR5PqY+J4y9xR9jDKLd2GCtz82oxr2ooUETzDDLUt91eZEmmGKMBBIJT8fRmeDgXXWij0aRpwvUSmF6k1w2kPzN4EZ4cB5VGFaBuw4DAaTKDuBhzBq4Ml1YfobyD2iXAUqiG03JfcFhXvl/asube/z8wE7v4aaieqbFAKsWf9+jFFpLBaqkwSU0pqcDxCiriYhHkqG7qfxant0NOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by IA3PR11MB9302.namprd11.prod.outlook.com (2603:10b6:208:579::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 23:49:25 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 23:49:25 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "horms@kernel.org" <horms@kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "jbrandeb@kernel.org"
 <jbrandeb@kernel.org>, "Shelton, Benjamin H" <benjamin.h.shelton@intel.com>
Subject: RE: [PATCH iwl] eth: ice: don't dereference pointers from TP_printk()
Thread-Topic: [PATCH iwl] eth: ice: don't dereference pointers from TP_printk()
Thread-Index: AQHdMREdE5/OKWcu4Eqymg5X34haHba8COfA
Date: Wed, 2 Sep 2026 23:49:25 +0000
Message-ID: <LV1PR11MB87908829F6BF6F7A687BA93690B72@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260821020201.1337338-1-kuba@kernel.org>
In-Reply-To: <20260821020201.1337338-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|IA3PR11MB9302:EE_
x-ms-office365-filtering-correlation-id: 26415c89-b86e-4996-ad74-08df094cd1f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|38070700021|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info: LQ8oncH2SEcFP1tvCPp/f20ZwIE8hcrc0sgOiy4zNRVj/kOA99MLJhnBy/lZDS9rrFkDg/13Pi/1d0Vr2a4tduSEGtnUGm+dv2lRNl3ANclcYI1FP+SLOv5H99knmvKjfUKeh07t+bGufDHDSyYCvM+Fx/Jnj0KC5Tl/m6fjdH/BOiyuWOwNNveXJRbI6sMRH0hfRIdnqiRbW/cH2xUbtw4uPNkt0s2QzZrdL9QDq8bvoQ6zcx3C7k4qMPhRlWJ5OnapPyZ/JxGO2ksRXs5RDBILnnYm8zv6elCdoA8pzDL5Ex2tOeKGhoI2R9IBsSCXx8omu/92FsT2H3450natPhFbqr53CaqvyPhgNX8tXNNysYkorEHKJwUqmsmXG6tDcv2P/qr+c3PvLFAMuO9ojNUUqyXea4bLr4ZZnP8l9OgOLsy6tpgzN6OUzq+QVc6ExalKr13Sfq1+uTti6LZfE7D/sDpBue/qkDPb6nxaqeRUFwVKwsQVS6Su6FrPkAYe2mYXR3o9dkTJY4r3Q67hnf28KTXy9M3JwO8beDjK9r30QFuPJ8Wbs6JB8eqsVcGlqID4FEWCMFSE1w+cuaVJuapPHmpER5bHAQ7JO/SIWcLOOFLiTrczYQTJdnmeVfwu80VYfrLjynjU9vxCZlL3XviZA2yVjiobwwpyoEhN//sx5v6BsEvrCOehLuUKx7BwILt8bwn0RPB1pQSPgwXKc3vEsH1JiCMX2M77ifd4Q/U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(38070700021)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lS7XhG3sFdxSjDAz10YTEw6qorOen4eyQTkykYecsXRB2wSTvjeCy5KS5njw?=
 =?us-ascii?Q?022HyoYFjSxMM2ouVJLhsGxP0shS8une57rzMjl2gx82NjXQqbiy/nIQvazo?=
 =?us-ascii?Q?/7i9IQVFdYKN26PQGV9bPuJ9xJmuKIoENGjdWDTbyHomjIWOYUP6Hk7kEu5m?=
 =?us-ascii?Q?b5UwXTr7CJ/xDzpGKPS7aRJWhYQY0abYDDHU+NljnVNhi6n664UpbmnKfOfQ?=
 =?us-ascii?Q?GMVdE/oRBZfJLvV5H/qNLp4sXp/pV3NoOD0e/cA+VxwJSr7jurJ0fIA68mRP?=
 =?us-ascii?Q?MmnQXy4bW/k1mZzVoDCMUfJw4teN9S5BhdbX94a8oj4rugafFWJVHNyUdim+?=
 =?us-ascii?Q?o1tXuVaYdE23sftXRi+t2KOJi8ZCvUBgBdFMBn2ftG+4kRtm8BPzyonC0wuf?=
 =?us-ascii?Q?1+yxgJxabRsnGVkRgXVobq0gMTFcv8y8x36WemCD0sg+LbhIypNDpwHnpKCX?=
 =?us-ascii?Q?jOImo9zLW9NwPpScAK32OLhKpCeh7EkNJ6c6505PfURAIevTfx9GJC0LTcpE?=
 =?us-ascii?Q?XiMPbOelIIrNSl6XNE2AP0ABn3gkFyNkiAsu/289SHk2kZko2mcaSAx6BkDn?=
 =?us-ascii?Q?GTZhlMAS9iuv9v/AbbBU8eD2eaMTaVZ+tg9alGRD3erxBg0uqe8uAmDeu99F?=
 =?us-ascii?Q?eKsfzvjsEgEa3ifahm1raq0+Eii8PIDU0/Ejt/hp/V7M4NM1m2aIWRat+b5L?=
 =?us-ascii?Q?fJdo1KThpi/pLTuD8nnGfuCDTumrB3KNsVMxX65ah9LJIdOYpt6Id7YRMa9o?=
 =?us-ascii?Q?x2kJfcjqa5NRejybDFFAU5vzYXzGtWpa74VHH3UI4DqzZ4qWRIvlRncDLS+j?=
 =?us-ascii?Q?JF4fERHrbP4VxcK2qQEFp7/wd8jeW8wAD3i8F1QyVLfy1qedhWBSg0yHK+e6?=
 =?us-ascii?Q?hyOVX/HOgfIxRe6mpX3xfKcn4QGCEq7OQw1xHfhsrmPfc1yd99zEEVxNXcUg?=
 =?us-ascii?Q?h9DcCO0tZcCMaKWm/+eU1BJySA8FcIyMeHGtudet3s2VPtpmyTfuXz4xSfBS?=
 =?us-ascii?Q?Zi8/q4fL+5sV+bVaGEBRZ/kYlycTlhOBS/4y3LKakOhi2Mj+sO8hBVxDhJXh?=
 =?us-ascii?Q?V0rU50YFCXrmSL52KzkSCTHFhZJ6DGiyZtDUbuaL8rJRDENlnKPNh36C3AMG?=
 =?us-ascii?Q?0KlsXFnL+uIO5UIrsUPANpHjwldXiAmPwso0Lun7tGj5ZbzSTvgz+7cQqK3l?=
 =?us-ascii?Q?XNDGLo9fyXhKBdj6V+mBdYxfAZXDeUhOh7wxgFaWMB2asq0XqbmeV3uwOtco?=
 =?us-ascii?Q?fysWsHWDG5fjGf0Xn5Rr+hXoKhkrQELH7FZvWvj73jz6o5JPXKDZ1hToxXeq?=
 =?us-ascii?Q?TdYOwBSMiuPyf90k/KGSiCaViPTCjokr5wkfxx0XGQNGJx0R+Ew4Bpc3SOyK?=
 =?us-ascii?Q?e50Dw3f8uhaPvb+bBVtT1B8gItDFMRK4KdcaL3E5cxaBTnc97ABVN8AawMMl?=
 =?us-ascii?Q?GzMoJMAbHojmSOFuQ9d7OvYMg+vbZkXaKVQxwHymJOv5XEnfUJ0JT1UPJ357?=
 =?us-ascii?Q?LVw5thkmY0ykL6Yq6vRxAT1s1yVF4F2NA7RvX7m86G+NyON61cBwvS3Z7KSv?=
 =?us-ascii?Q?NV/qnjwzKPx40LasQb/TfSGez9ZZzPAuMoPwdt4rfjhh+KRm6kkBGIxf75J+?=
 =?us-ascii?Q?rD+cjJvLQDsq1yZmQFa3t6GmqmDfjsQbeaAMW86kJwB0VMU9wUryr7tw3NBU?=
 =?us-ascii?Q?PwXZU63dBg+XY1g/OqlvyV1wRTjCA0dHSZZRB2yUWDvA4oMEW/ukGL6ICaum?=
 =?us-ascii?Q?nszyPCzXqA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: seisdDxDLdzbcfz7pOa2Dlwc1WC4gpTIrPy+KcL0TOaqcQQZDBxJSju8VX8AO4h0if8yqQi2RlbVzDH8PfKTYn0jSl5CSxqL/+cV1eJ/Kq0bX+Yvm4rS+3mvJCk19am5uJpXJYKK+edvQrnSkjp/OSqICV8RQ39MOHR604ttUY/WEOBT2tAku4C16w4YWWz5oI9a/bc6HX8HakK1LPUQcMIp8JXe05GlCy9X+4hBp0s2adRPMXQUIp2gpaadGDBol48OcJAFPTiLErSXSDVxXwaiaKF4RlokmrOz+7Po5V47SOIQs+3ys430jigaB0usehLDwhIhEHVrEBTyXDQ/NA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26415c89-b86e-4996-ad74-08df094cd1f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 23:49:25.4406 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /PqzdwvPo461bDBmQI3DStTCzYSdHS5oNDfEGl0NIxP/agZxbfnY58niTUCjFIwwV8RQdGG+VM2h862eO/O2B7ZIkYqbX90ktZDjxZ1LfAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9302
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
> From: Jakub Kicinski <kuba@kernel.org>=20
> Sent: Thursday, August 20, 2026 7:02 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Cc: netdev@vger.kernel.org; davem@davemloft.net; edumazet@google.com; pab=
eni@redhat.com; andrew+netdev@lunn.ch; horms@kernel.org; intel-wired-lan@li=
sts.osuosl.org; Jakub Kicinski <kuba@kernel.org>; Kitszel, Przemyslaw <prze=
myslaw.kitszel@intel.com>; jbrandeb@kernel.org; Shelton, > Benjamin H <benj=
amin.h.shelton@intel.com>
> Subject: [PATCH iwl] eth: ice: don't dereference pointers from TP_printk(=
)
>=20
> After forwarding net-next during the v7.3 merge window we started
> seeing:
>=20
>   TRACE EVENT ERROR: Event ice_tx_dim_work has double dereference in TP_p=
rintk: REC->q_vector->tx.tx_ring->q_index
>   WARNING: kernel/trace/trace_events.c:420 at test_double_dereference.col=
d+0x39/0x4b
>=20
> this is due to extra checks added in tracing subsystem in commit b5cc230a=
f5e5 ("tracing: Warn when an > event dereferences a pointer in TP_printk()"=
).
>=20
> Printing happens long after the event was recorded, by which point the po=
inters may be invalid (the ring > or the dim instance).
> Copy the eight scalars into the event instead.
>=20
> Fixes: 3089cf6d3caa ("ice: add tracepoints")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: anthony.l.nguyen@intel.com
> CC: przemyslaw.kitszel@intel.com
> CC: jbrandeb@kernel.org
> CC: benjamin.h.shelton@intel.com
> ---
>  drivers/net/ethernet/intel/ice/ice_trace.h | 64 ++++++++++++++--------
>  1 file changed, 42 insertions(+), 22 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
