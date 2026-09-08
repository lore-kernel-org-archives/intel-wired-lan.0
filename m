Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE80C79F99
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 13:14:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 69815405BD;
	Tue,  8 Sep 2026 13:14:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 88QqvDwK9XmW; Tue,  8 Sep 2026 13:14:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A394140587
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788873247;
	b=dNDE6V6d6rMV6RiuJ1ATvycyc1/fIQ4jIIVeQgRrgxl8e0a1GA9oBIHVgOeC3Fg+xZDQ
	 /4YBJc8Q05Po5GAf6OsijhyrY1TsuKfmd7XzHgfZWPPKJyWrOs7QRO08mMjqf+SqwLoVO
	 ri1MU8+jyZBnou/Q8Ew/KqthfIvixBaNfryzVuuVWTpNp/RDUz2av4BVQRJIqTATMDbQa
	 3SpLPC+KQ9ElXsZeL0eqg033OUdPAy4GJgFiUBfx31xjqnlv10AL0+SdD1V8u45tyiTyl
	 CFh0DvqNilGAaTHnAm9IjwGXHLvxQDxuU0yOzXe/MJgcbsc6EmF6ioksbliwfbMXOAw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788873247;
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
	bh=S3K4O/aV+zeUG+Poe4jyMfql6XN9p9NLgBNA9b6LD+w=;
	b=MbzYvk3PI92sU6C1+5Xc6fHxxwwcPBWEDfH4ivl/q3gtuua7VEdkuJ7k2/xEjFCH9jW1
	 +aCtJC16OXYA9W3IMqBA6U+EspYjnE03iQkqtoZZZGKOLSoBBZeItT3nGRDh/m2kaNnmF
	 eXI9+M5KOrjxDiQJt4q6gKKPFMaJ3zY3+EuRTsGOf2SfRQ7nCflhInzczbcsfyNdyL7Ri
	 AD/E7rkWAGdX5lDhgqpp5iwTR4KPTNmFXP3vFRRrpEoRUnIKqMSrc+kgCCezX0q1piumY
	 oz3lT6f/3ErdIvNY6/Di/m1WvtNzAilyAvudyl/V1mDADe1Chp4rFzGWgrdifSv88xQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B0FEacYD;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788873247;
	bh=S3K4O/aV+zeUG+Poe4jyMfql6XN9p9NLgBNA9b6LD+w=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h8Fbgw3iTbzVppUvIBEv9etd/7t9z5r+JHDfqzeROnOWv2c9ORAdaKO3eByfXOq3i
	 M8e8Ze52DchIkVbY3zrJL82QRJPxEKdWgG4dvhL2zNqfXkOLa2Wv52s0RYAYSAKmkw
	 d5XJdurBcDAv3U1kB/d7TEpYhKNj+cIF8OqxWqTNmn45rt5Ijw2QNOPbp1fA2LGMmb
	 jF91kwFS+96qIahLZWzxtl9uRRJsGCbgI6l/jH+7Khj6xfyU6Tkxo8UOEj5Sq6ZGpR
	 0N2qjLI3KJ+XyIlUboDDqJTCIw530GAwVi85PM4fIUzmkoJNXu2eosvZ6xfKlXgd34
	 GbJz7vWBhYUgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A394140587;
	Tue,  8 Sep 2026 13:14:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AD3AB372
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 13:14:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AAC2D40587
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 13:14:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ppxcfiMQszsK for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 13:14:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DC52A40582
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.16
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788873245;
 b=aFpSlm5NgZNoNknxeQeDEpW973m0gO6ON/tU+hL7vm8ozP0DHY6ZVhxqjGkOL6JVQntP
 K6cgco3xMBGuPMwPeGKTumq2ZHWchoOXCDNIAlmboXZ+FKr3s3EIoKYLwg0T9q+GMo5/Y
 eks/uZOjzIMt7i04Ha+wbiGbQ0sYr4Lpl/uZdm20hJlGh65ZqKv7RxDWASgIc6fk4E79s
 RxjxSMl7W0Y7LrJOLrXvNZqGfT6NaEIgv3cAI20vuwMe+Fwv/llTq7aWKVMmaePYfn60h
 NDUDs1XJqLthTJv6RMXpRZg8OXHNRDk7+80tHz/cg4nEHeN37YTU4L/wRPqmbtuW4Qg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788873245;
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
 bh=S3K4O/aV+zeUG+Poe4jyMfql6XN9p9NLgBNA9b6LD+w=;
 b=SnitD7hKljEoXlXIebk0q0t42aDF/lbEja+CE4glo2n7Lo11KStp7Q4EEBVG2YVzPAlK
 cYKxh9GWy+OEG8KHK0Sxe+IT884V5Gl8VOJ8UJS+wJFPTYO3R6XQ4Rk9qekoMQ0mCu4VV
 7ze6pzV0piCR3C0FhTkMKghbS/+yIpdjKjCbb2VlYXqgPydhy0pECrn7bmYGuglRHgMak
 NdZgNFkTeJ4gsbxRClWA6cwAYKxSJT1hoP89r7B2Cqsfw6wHz3Ri7rT0KEtHIQyeswzPi
 WsfDPu0LfRqQsOvKmSO8GxFNJv0PpcVUQGt5ny3Ew8Y/Hnm2XvEi1WFddWNejeIIjsQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=B0FEacYD; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=B0FEacYD
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DC52A40582
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 13:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788873245; x=1820409245;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FLNwgGANxBtkxHwyeXGRwPEJbZsIjV6CNbCnsG2WSb4=;
 b=B0FEacYDE79gEm3ZD4vVuXQrXMMUNzBnW6uAx0jo8Taqm/V8Fdm3fuKz
 b7PwjFlxUdF2abbk8iMy14pF76XUhscfJi0MuBYqCCEDwA0xw2LFgD2Rt
 ZlhVRH5AtCFWyW9Fm+35M97a+eRs+hTlH1Sb/dFiyZdO41s7aaPwAp90C
 OUCpdKzPLdq7vKILFkB1Izmolf6K+IaSAywcMzyjzcpBxb/LvmC8vqn3a
 GqN1lQOpSyecciA0ujrDvuoKG6kbah2ZA6qrRau/5RuTVtgZ2YgRYyTGM
 1mkk7z5d0XJfyncomBacD6K9pJXQRGREazovJej35c4jxISis+kyg+N+F g==;
X-CSE-ConnectionGUID: XB57HIrzReSfSy5c24yPmA==
X-CSE-MsgGUID: IC5ppO+IQqS+iwgHNezfcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="76834534"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="76834534"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 06:14:04 -0700
X-CSE-ConnectionGUID: eKKLM+xzQja/fNi8VvTuaQ==
X-CSE-MsgGUID: TSPVP0aSQZaO0SwOapNT0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="264801487"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 06:14:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:14:03 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 06:14:03 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.62) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:14:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgCiRT5vGz+kfFnJ+BmunCj9MZ3GCrs71YD87cAkcbh3/wiPsHS/f3TCxmWkLDK1wE2VucWCply3MsaFxo6tXDEOFAEugqeBr/7jBXtgZ4rO5T9aDwwFjKrehZzwGLXyRrVR9ScohcKVWzQPQ010LHRky+6IVxDYa4fMzNGW9NhQxTz2WzcswFj2R/vd5fvztC3ObyWkVlEEPXStvacYMP6FMZY2dejC3UoQYHWT/apAcsXW4Lv4kNoeb20LJSsxxBQmFUtqnsuNCQHwV1CupdIpJORLaNbbgxQsipNsq20m/E8rcr97vufOC1O3Wj+X9MD5ZCsDxONWkdFH0oFf/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3K4O/aV+zeUG+Poe4jyMfql6XN9p9NLgBNA9b6LD+w=;
 b=ZrXa7xBXieWhLCr+TsmWNYVV3+GEzllOtZ3XpRScrb5StRdy5fADtmCm1gLlpBTkarmcSqn3JJDdGTj/NVzPtA8Sb5U28lUyUDEzM5PqCq7coTz6wBO1a9kk4Ar29h47HIoOhVp1OZmubGYNQ2Y4oBud5d8jO1Gh3qhrWm6xw797upqW4z5SdMHiGt97oOLpAvD+r512gm6YJLT3YZ0t8DNckTEXWj73f6WjGHMfiBEwe9quJ5/HGScZTJrLT8g2WMHQY5+gidrEjzLh3ItiyD4keDb/UqehKfQRRQaqXL3sc/pvXhU0AZRRu0Pqtx1QXKLbuuPd4DHMvSTiXpr+VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY8PR11MB7748.namprd11.prod.outlook.com (2603:10b6:930:87::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 13:13:58 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 13:13:57 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Aaron Ma <aaron.ma@canonical.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Henry Tieman <henry.w.tieman@intel.com>, "moderated list:INTEL ETHERNET
 DRIVERS" <intel-wired-lan@lists.osuosl.org>
Subject: RE: [PATCH v2 2/2] ice: clear Flow Director entries before reset
 cleanup
Thread-Topic: [PATCH v2 2/2] ice: clear Flow Director entries before reset
 cleanup
Thread-Index: AQHdPr98g1RfQ4eTL0C5c1rNvRca57bEqkVg
Date: Tue, 8 Sep 2026 13:13:57 +0000
Message-ID: <IA3PR11MB8986D2E1B01AC889ADD35448E5B12@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260907115221.926007-1-aaron.ma@canonical.com>
 <20260907115221.926007-2-aaron.ma@canonical.com>
In-Reply-To: <20260907115221.926007-2-aaron.ma@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY8PR11MB7748:EE_
x-ms-office365-filtering-correlation-id: 0d34ffae-3395-4f0b-ff98-08df0dab0a9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|921020|18002099003|22082099003|38070700021|4143699003|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info: OgFIQg8GSDxc/Z0lDT5up/EsA6MTMPfeGjMfDPyB3D+XKrRcMjeci6VZTG3vpMfSnGsKwWm50aNbXQU5U1XCt0hoBXaNzspbpbJMf9d9qq3TGT4uDKmEjfuY9KPHqjSyk7jn9cZXi/y0bauLr3QW1ExlSdd25OumMTGJrhX36DhTh9l03XXi681WmR2QcoZtHV9x5EykHLPNM4lWYAyMSlNiykAO95THY5PvRN8vDGLORVF4zeOmQZksmPhOju2PNySGyxvRNUXNx8w3FcShM9DfKrCNPagiOINS08jWgJbw+8sxSGR+ELp78UEOdBFKhCvDa0AJRBjeL6kYf8JmqY4jYIHuzaShAU5YKNH8c8HExTDgq2S1vpoPh5vTQbNB39ceIJEELe7EyisyniYtzFH2SZaj7KKpmN/qws6hCNkzflejsuct9eM/SP9NicDtsKmW7kF4Hw6PEgxwutFlBPsa1HYidbgpNnsXiipuMuEHegxqnf04p5DiI6y5Pma0eXoLp01vk2qw/nhaNNSJtNbEnfK+0emJ9vv/GUBVrjMuy0I/FHD/TAO013/s3/g9smjU0rIYeORP3rCiWnhaQyIrLFgkyTOG8emVl7rZJyX8eU9PbZr8L7KfDb9Za8dqQybHca0es8p98zDwLGMt7n3lud8FpDE0S3gX0z1v1Fs1RprtPrb0uGS1i93jHKKUUxzLv6o97S2PSn6Q38xt3C+8slDpJaDED9VtG2bMXiRj+tXUiU62qvDe341wLao7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(921020)(18002099003)(22082099003)(38070700021)(4143699003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?27M6JKkpT9xg1J09QiqlNxl5Bvq+ZTv3Bhe6vIU2U9Nn0dh37Cp7INzxmK8U?=
 =?us-ascii?Q?eSCeehB53ukc9CjT3j8jMhXsxSggLCRmnyBMN5RkpFxSaWuzrFr0WRZnr+t+?=
 =?us-ascii?Q?ZfgEG3JRLbO+Sm1dzmtDe49af5eX/s4RhIOZF7CL9n1oWrqbGSvzLDBES0+s?=
 =?us-ascii?Q?ziF0NhRE434U5ZcsRue7yw0jkDa8ElnxJSN3WONULhzxxO3t0E69zr9jxyrb?=
 =?us-ascii?Q?4qD2yobUbxbSJfThtdeml5O0rvK1Vd7PUDL+bQKtljwPwdbjZlY+Cjc+gyJl?=
 =?us-ascii?Q?yF6RgbA662sKnZ1NpnGUoxgJYmEXJtcuzUMUhr7WwQOYU5BRq2jVa4DaOpjL?=
 =?us-ascii?Q?BVerSP7Swz9OAhPiLerzXbIg1N1ghAJQLxBXNpYFgBzcyfT2CYjDssQJ6OIf?=
 =?us-ascii?Q?/2AROz6Ng0GMiUENFvqu6uo+2T438xMvqwNIxKVn5l5gBySuBTEBg2vDPOY8?=
 =?us-ascii?Q?QSxhVLizis3N0gVQkQU+qadyeqXJsAPq4hhOIa+zyTivJqIip3Nbq3qUGmYh?=
 =?us-ascii?Q?W0HX1aw23aZR1pCHmbr1yLbYWq5GsB7YaPD0xRl+FEiazxTY0VYORO36FIqM?=
 =?us-ascii?Q?XVGNKFu+RX9YBBJaJRoGE3vbjabs3sYdZonbT/50q/QHDFWRMZ4JEFEXmqib?=
 =?us-ascii?Q?JSZRNri3W0q7SxPC6Xru09LFBFtS42bgsP/bP/TeYswbvfuDqsl2buU/hV3s?=
 =?us-ascii?Q?ZDSfUwEBnRd30IBx9Nnvirk1NquEIWhti49P+UkGOsHJ1H+dNsLtmbBHES76?=
 =?us-ascii?Q?q7TqmwgaRjeX8RuonL6r3pnoun/3IZEEIaO1nDWy8Jf3Rmhz995dIpn8t/IP?=
 =?us-ascii?Q?aixRT2b3yJAt5hQxq1C3G8koeoKP5rfJxomD59TPHi+FLSRbAv6oK6o9kUCD?=
 =?us-ascii?Q?dXAmrI+Oafe44xfEOO9zhUjxCl9cdmFJwiz0xQRyD5q9nFkGQdI2HX5te8sq?=
 =?us-ascii?Q?RLZYYvPqM+kebBlHTudByxSjRhK9JG+2MkiK97w/BQahDUAsLePvs5QD4Mhx?=
 =?us-ascii?Q?iqoi/3/6U9ogEbSIkXjHA3bHNZOqg8mduG/56iX1d5lWWV4bjHvsJnLLTIE5?=
 =?us-ascii?Q?yAMQNckJdGHth6PM1d9FVxtwJSzcpIPX6HSJg1a0biX8MDziI2NQYAZqhI4p?=
 =?us-ascii?Q?sUq0r8l7fBQuNdke7l7ekKmJypyM4FRVETHnnZ8CLGH2YvbrlwiG0+CYxnTz?=
 =?us-ascii?Q?Mr46ljR7JgR58txsRAW48MaO8S2f3swyVKe4dA5TIQyKWc7SFcXyYLLFzmQr?=
 =?us-ascii?Q?+DjrF/HoCnYTws4UcNIB9V9K5RDBIaWWC2mbFWWfLIWO5S5CMe3x9glWDxsp?=
 =?us-ascii?Q?bAdFskUXNK18TZVLlga48J67KSGDYyrUQrZkZF63socyZbEbSLfGfMal10JH?=
 =?us-ascii?Q?rTDmGfD9/UqLDDdRnQr1iVlEORgzujnV9hqwvQqmOCT3exHxLCwwdw+d/XEd?=
 =?us-ascii?Q?eLQIXq+yEKbbA397zBj9FJtMrtY9s8v9KwAtINhjor4Abg6MiwDCMtNtHCjH?=
 =?us-ascii?Q?szhGOgUMqy0m4UblXSYUwpLmJUR8CLC66EfcZJaUid2mdmvgol5XNOPQ8u6p?=
 =?us-ascii?Q?bL6GR2g3C8NHtVCZXWNx6QCh2Xu9bdwppdkLJ4/Wi7WO5HZxmWLQ2Xtb6TMG?=
 =?us-ascii?Q?mXbiaS+IaAQ28ndpxYionId/6Lnrl6NhDvSJLcPDziVq1sMxZ3BDuHAEu8vF?=
 =?us-ascii?Q?Ox9ZyFVbBX4S4kfwHecjtJWPQ+rN4jvRqmoZw8BLnBlUXs3l7xQxsUxn6CfA?=
 =?us-ascii?Q?bQyUrYmM7SO7OsZmUhHaRXe7qal3Clw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UcdJXYZxkQXboIFFTwTYlHA8Z+ZUrdXTOsRuk+Wsx7KXgGYxNIfXbkc9Q0BJ4XVwkyTmsPMV58mEW2RvqFVsPQ/2LE6qVi3z/yiSRTQr7ER85QMDV9wZgROiTMe4wbbEGJs2g3YjvmlKLZui7UR39J8//fq9WI+ec3kzE3fXqOxQPXet8aGqtlmsv7+GVzl7BVnNFQwIJDj57AQnUQ9x521aI0ILJMVz3jJNERH5zbXL/xlJ206Rq95GnYX5tMJZr16nFJ2EeA7zRJE9rMmrV05wAh5+UejkpM3wukQoJ/YhzSI+4rKFHxrYdQNr9iyfmS92ImPyk862do1a3wPJOw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d34ffae-3395-4f0b-ff98-08df0dab0a9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 13:13:57.7987 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GFvWUeMWS7XuD6ShsAXwKWazRyabOJadkJhDj2KIHCWnGKD0haTcENyvR7R+c8OYgw87+UXDH3fQJiDK8St+llcE4kvI7xf5dHYMIOUBsGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7748
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
> From: Aaron Ma <aaron.ma@canonical.com>
> Sent: Monday, September 7, 2026 1:52 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Henry Tieman <henry.w.tieman@intel.com>; moderated list:INTEL
> ETHERNET DRIVERS <intel-wired-lan@lists.osuosl.org>
> Subject: [PATCH v2 2/2] ice: clear Flow Director entries before reset
> cleanup
>=20
> Flow Director profiles retain handles to generic flow entries. Reset
> calls
> ice_clear_hw_tbls() to free those entries, but leaves the Flow
> Director handles unchanged until replay replaces them.
>=20
> If rebuild fails before replay completes, later driver removal follows
> a stale handle and dereferences a freed flow entry in
> ice_flow_rem_entry().
> KASAN reports a wild access to list poison from
> ice_fdir_erase_flow_from_hw().
>=20
> The failure is reported as:
>=20
>   KASAN: maybe wild-memory-access in range [0xdead000000000108-...]
>   RIP: ice_flow_rem_entry+0xaf/0x170 [ice]
>   ice_fdir_erase_flow_from_hw+0x1ee/0x420 [ice]
>=20
> Clear the Flow Director handles while holding hw->fdir_fltr_lock
> before the hardware tables free their entries. A successful replay
> installs new handles, while a failed rebuild leaves them invalid for
> later cleanup.
>=20
> Fixes: 148beb612031 ("ice: Initialize Flow Director resources")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
> v1 -> v2:
> - Acquire hw->fdir_fltr_lock in ice_fdir_clear_flow_handles() to
>   synchronize with concurrent ethtool filter add/del.
>=20
>  drivers/net/ethernet/intel/ice/ice.h          |  1 +
>  .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 26
> +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_main.c     |  2 ++
>  3 files changed, 29 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice.h
> b/drivers/net/ethernet/intel/ice/ice.h
> index db3c7015c56c4..4739ff882b9ec 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -1029,6 +1029,7 @@ ice_get_fdir_fltr_ids(struct ice_hw *hw, struct
> ethtool_rxnfc *cmd,
>  		      u32 *rule_locs);
>  void ice_fdir_rem_adq_chnl(struct ice_hw *hw, u16 vsi_idx);  void
> ice_fdir_release_flows(struct ice_hw *hw);
> +void ice_fdir_clear_flow_handles(struct ice_hw *hw);
>  void ice_fdir_replay_flows(struct ice_hw *hw);  void
> ice_fdir_replay_fltrs(struct ice_pf *pf);  int
> ice_fdir_create_dflt_rules(struct ice_pf *pf); diff --git
> a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> index aceec184e89b2..04510b36aa56b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> @@ -428,6 +428,32 @@ void ice_fdir_release_flows(struct ice_hw *hw)
>  		ice_fdir_erase_flow_from_hw(hw, ICE_BLK_FD, flow);  }
>=20
> +/**
> + * ice_fdir_clear_flow_handles - clear handles freed during reset
> + * @hw: pointer to HW instance
> + */
> +void ice_fdir_clear_flow_handles(struct ice_hw *hw) {
> +	int flow;
> +
> +	if (!hw->fdir_prof)
> +		return;
> +
> +	mutex_lock(&hw->fdir_fltr_lock);
> +	for (flow =3D 0; flow < ICE_FLTR_PTYPE_MAX; flow++) {
> +		struct ice_fd_hw_prof *prof =3D hw->fdir_prof[flow];
> +		int tun, i;
> +
> +		if (!prof)
> +			continue;
> +
> +		for (tun =3D 0; tun < ICE_FD_HW_SEG_MAX; tun++)
> +			for (i =3D 0; i < prof->cnt; i++)
> +				prof->entry_h[i][tun] =3D 0;
> +	}
> +	mutex_unlock(&hw->fdir_fltr_lock);
> +}
> +
>  /**
>   * ice_fdir_replay_flows - replay HW Flow Director filter info
>   * @hw: pointer to HW instance
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index abb6e850ec09f..164428ba116a0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -601,6 +601,8 @@ ice_prepare_for_reset(struct ice_pf *pf, enum
> ice_reset_req reset_type)
>  		netif_device_detach(vsi->netdev);
>  skip:
>=20
> +	if (hw->fdir_prof)
> +		ice_fdir_clear_flow_handles(hw);
>  	/* clear SW filtering DB */
>  	ice_clear_hw_tbls(hw);
>  	/* disable the VSIs and their queues that are not already DOWN
> */
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
