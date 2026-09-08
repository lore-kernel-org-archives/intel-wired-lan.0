Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 412D1C79FA0
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 06:19:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E673760650;
	Tue,  8 Sep 2026 06:19:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UYARtnueg2Zr; Tue,  8 Sep 2026 06:19:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 189F86067B
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788848351;
	b=tVzcyF0nFrC7vcQ5Ge4TZ5WDO4FRPj6lw7p5vIUnLtNGjWfewwENhGx183S5g21WT3EB
	 jQc0mIFuTxxMWYqL6uj7cN/SQlVloHhF5KY5nLIDNkMDMUhdC8d8+b2jsylVoz1/08hKQ
	 S8VLTWOXNwOXL8zDRM1/mF5EzOMp1dy4zlmFmp4czpDkWr8iOYqVGSXhMxObjaInf8HJl
	 lGXdMJekIe53fbKW9j9VQknyHS1dZPrYTK/hoNj3s2/KHcpNo1Rt9zY1Pp3xFooAIdgX5
	 pkuIp00k90drSuWp44v8QS6Edfys2UZsSms0Sol6CC5s/stNJwk9RQsJMMzEx/UBehA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788848351;
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
	bh=42JGsF7zo2VR7F6rfk3zrCa/rsgLEBVxrxJNPjQ9hpw=;
	b=UkWcwYrtj1PhoTV0QtElcY9jQkolluhLWNTCtWoeRDF/JmCGcfNqVIyg+k0mSwP9Mtmy
	 XV1EwrKHo/x+5NfPTuI5x11dJq0e2pFWm+f9VLjA1eZScXwePtm+S5579xZNX8BfDUjU9
	 5TIP99O5SxKzT2FEK050tQpSviMcBf3gqJaAQcH/R1Vyq65tFDpAIobusPxEk2CgsmHTK
	 JzYOMXWPWDyqS6JnaFobdYEYirtWYS8v6J+jSOcG9X+I3XXlUbAVnPVf9+HD5eOuwbYY8
	 I4Zlp4wR8Ycn+KOMIgG2UwpBT/o+VV6gLhPgCCm2+Y75dwbnJoZOX7ODo8kL9YYMVNQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788848351;
	bh=42JGsF7zo2VR7F6rfk3zrCa/rsgLEBVxrxJNPjQ9hpw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0HjVDoDFBjS8GQ/s+GY2YJ5MoWDRsvV2QQFiSAr/pTb075iz+DOrFLFZSeQHZXjht
	 h1NnYH00DZBmdsXCHc/CtHGkN69Qa/8VEgouC6EPO5mVdu/RF/+JlV4q+hGSmIQgXl
	 pq4FM2TG2JdeiesQ9gpXEBwGovaJCxlq4ky5+i3pqmeMuIKETGOLo1Ag6DXZFceOKy
	 NMXtsPGKUj0eUgsFwSVf2rwrW4b1AiaXGRmvrB24u3j3QDYHQ+u9EhXKXrdwgAdZXs
	 eyqMkQiIxv6WOdMJM/nlhEG86jGTb8tyw3sUhVdR5miNSTTyThpv9tpBbDhw7V+YtQ
	 RGdoM0wi0MUfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 189F86067B;
	Tue,  8 Sep 2026 06:19:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 50414A48
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 06:19:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 423EE400AB
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 06:19:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ULkHHkAMo6fy for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 06:19:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org DDFCB4005A
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.18
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788848349;
 b=dhJsZ9Em0QvulOGUQqBHN25w3/k7oOhvbsPT+7y0HMT6w3fhyzL5NPAm7bDgjCVpVKwm
 IrXjn/4jB0dKTejzj06yAUIc+fTsFJK3KrTW3dSseoVpPTO1VXY1TPmSu6leWxbwk8Sbc
 DaW3pvRvFGPmsTjBj1l44rQMEKmyUgaP51L/Ha7G6SJ5wW24nTIxiSgR7wKwnCOLzvX0I
 B3Rq5VattBROtC0EoNl0Z6F7i3m8ZaZi3hblBChvxl6nI7V90n0C9j/Pk80YesPbRGn/a
 GEA1o2kCfwgM459X5+8J08YXsqPuVrGDQCNkNfbferib5CL+eoVKCO/5wwOhmzvxglw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788848349;
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
 bh=42JGsF7zo2VR7F6rfk3zrCa/rsgLEBVxrxJNPjQ9hpw=;
 b=fL0faOEKqbR995mWB2tg6w+FrzggWaW1avCNlBGSRc6SyOsxhm2UA3mg1d2nxkALxjIE
 Kj6OQifx/Rd/0UTuPIlfhrtN/Pj0+VyIxA4m5uPMiDpXMEy5hXaUl0m8IHVGJyywgiQQL
 Nqcjc+mPoJCDE2soIF3Pc6kQ7KlJhixxQTTMZV4jaqHFd5NPA8CjT1B3hwhCDmJOx9Jow
 AzV6BYgRSjiSy/On6nwFpnWgF8y6AAqryC0VWnnKDwBSNX/MXD1HIi0L7Y9r3J9CFFq0d
 EoLxi0n0MM+WU3u+Wp6GghtK4Bs35VPbR3vlukjtFZ2JoybMGiNLMoN4KWAEHg4ydgw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=kO3M3AYr; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=sunithax.d.mekala@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=kO3M3AYr
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DDFCB4005A
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 06:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788848349; x=1820384349;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=K3fHzuTxMkZ5057Wq+XyiS7bGyVTvnUp2DKXrETGhbM=;
 b=kO3M3AYr+jvFRv4eb84I7Rfrdr1FYf8RUuaLhnfWLhPCa3Ny+yChdZZ9
 TsunbW8QhN0Iu4G6Pt2LeAQiM1V/+tXEQso4len4DSr4y4VsR66zTceq1
 xFXfHySOBTsFAgbl02NuxMhSWVdh5s+UV8AuqS34MBgvEUoHRxPCWcbar
 YsK4vNNF8CFG2FopVzcEsdEYQ+DbedlrYxPNSydJrf0wtdH78u57hc6Kc
 XjTbrYZd7NYP1Js4IbVrxJ3S9tNMqLOkW/pKQhImwv8AyH/xIuNMq2+8U
 4Ia7agqPaRPOeCoFwMFbEWuI1/rXwayfZWCi+oQYfABtQrSLW3BxjjNvU w==;
X-CSE-ConnectionGUID: 0qjgYtDVQ+WYIrStEI0TFw==
X-CSE-MsgGUID: l6vInk3fSgKKgd3RvzpK4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89284753"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="89284753"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 23:19:09 -0700
X-CSE-ConnectionGUID: KIUvftEdQwefGvapF7X8Ug==
X-CSE-MsgGUID: yPjUSqW0Q9aehqNeocgs/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="274413486"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 23:19:08 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:19:07 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 7 Sep 2026 23:19:07 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.20) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:19:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvy/hj9YmwphjeyaSd8tpurH+5cNMSwTsgtt1LcmYwsfL3IE1vfUDEyYK7O4Eb9iyY7hSQD4S21wpUwVYVoRNGAULFJIv2yOV/6E5X/Y1VGhaJzxp0t0qvOd6V5RlkjhxQtUiKYmuyDOPLATtzdvzsAU+JqtgbErpciSbsiYobIkBUMLrUoGv8fPCWUWLRUEjnCV6q+ZiSewQMf/++e4Ppl2/IpUIg9N9Elbasl86m4Ef1jO0idRumSdqRAmOTKp8VjxFH6nuLIr4W+a0vlnCXa2iHFmgklse57qWZqY8pOMBEWx48uur/bjCpmiSlQSuGUPjOHmNIJqY0snnFQz3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42JGsF7zo2VR7F6rfk3zrCa/rsgLEBVxrxJNPjQ9hpw=;
 b=U3kkgTb9r1xbRg+vB7kx4lv/injuf9e0ohmMWDiAtYIC1WN+s9yyI05T4bqx2/ttJCz/12Ig+6xt0PbgHfpFc7mq9TfP0Vcluad/vca5L96IzH+giX4Bj/MMsK7PJfiN6jnEb56jKWgKyzU82W4n+8wIwxpit3G0dsC84Ft5S6h3+VdNQX7LrkhiOpoqLDUGlhBMbbLGDH5hADgAIWT6mksNFbfjay8co+jK7BqW5vYJvLWPKAsuI0GLDlGPYtdaVCB92vUvxAHCV6ACR/TvaphJ7yNFQJtuhaASHdD24HiMzq/b0OK+L5gYpcR4OkgpX7BIh9xgL8f9ryUlBm8eBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8)
 by LV2PR11MB5999.namprd11.prod.outlook.com (2603:10b6:408:17d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 06:19:04 +0000
Received: from PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3]) by PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3%2]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 06:19:04 +0000
From: "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Karlsson, Magnus"
 <magnus.karlsson@intel.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
 <horms@kernel.org>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>, "Fijalkowski, Maciej"
 <maciej.fijalkowski@intel.com>, Sashiko AI Review <sashiko-bot@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH v5 net 2/7] i40e: avoid null ptr
 dereference in i40e_ptp_stop()
Thread-Topic: [Intel-wired-lan] [PATCH v5 net 2/7] i40e: avoid null ptr
 dereference in i40e_ptp_stop()
Thread-Index: AQHdCVeVKUw2KcjjkEWOQXhVfjlzW7bEnGVQ
Date: Tue, 8 Sep 2026 06:19:04 +0000
Message-ID: <PH0PR11MB7522DCE22E4541AEC9FCD29CA0B12@PH0PR11MB7522.namprd11.prod.outlook.com>
References: <20260701124524.13644-1-maciej.fijalkowski@intel.com>
 <20260701124524.13644-3-maciej.fijalkowski@intel.com>
In-Reply-To: <20260701124524.13644-3-maciej.fijalkowski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7522:EE_|LV2PR11MB5999:EE_
x-ms-office365-filtering-correlation-id: bb74b30c-5fd2-4132-11ac-08df0d71150f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|38070700021|4143699003|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info: tWHB1d47SA/IvNapNs++g1qK6GUd8ssWxN+ePxCoCRf3ZY85fqvYZLlrVWt0qzKK/7cHWEQBknDI8/8H781j8/NerNEEpUY3JU1xI8OfTL/ZVhWkHO0wahgd2fap/I4rGQsA+fvKRjSor9oIT59w4VxhlQhmwCfuub3RbvJxdPyuOeFPWOgb5sMRvkCuSWPSDY/FOFGJ49J1bm3uII2MaxsSzyXVLJicRqS1OXywkAExV0opnrT2ON3BbRLsPrvRjTeCAvS52BdNH5h5MVPJVQc66Q3v8Ah8fCs1Zl7RlYmODOhysvueYFmJcEbXud6b9H9mIjg60KBotCgfpTURh29ElMUe7iCvcYETRAnsK6ytWo3HbQjcBE8VB5JmRWrg3wefu+4hXo83eun86uSfajHyPOpj2fnU0+moTR8tRmOAp6YHUz/TZan8sjIDfA3qMAMVN9uXKnQW0HeEHFgH8+WYjhZcJwSgU7nmu4XVjk8IcFkJP5GTqApyF5VWrjV+NBG2YYwYdpNXRjSJyPRsu3vwrKTlzXehY3qG/zE9xzHzi8Op4S6PsFme4tWPGxYVxp+5cjhI9HE6Bs2kMPNUyAJb8YJ5tM1SIHpGeHhpw1Z5ePGySiITAKgz9kIY1zT/HcuDaASnLOc+VxtynIeXdAutLGkHKb1P2tNOSlfQLkPbhDysDMyg6G+AT+57tczbNYIfAMyQ7bt+sM+fIsPUtkV73eP1vnrOzsZQrebUfxA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(4143699003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zupvLdSS8K5l7EipSOW+pIT4srujW6mY64Wldz/9U7MMqrigElqo6Gudf7vJ?=
 =?us-ascii?Q?o8NxImU1W0zK4o57h3e4E04IShLPqvbpvc7yj5qE4B8Y0pgn6koVp7RzqYBR?=
 =?us-ascii?Q?Fx0SZyNAcUqErg+eOHXEGlYwbVIgNDPOdY6J+KytAzs0clMy6D1xtX/j0JWm?=
 =?us-ascii?Q?1GeRgA6oFe99EGttKQd0f8+f/BzCR3lU4iZHlG0zBz9VXpC4+5Y4/JTy+DBq?=
 =?us-ascii?Q?2NlV+seGfRTruGD12u+FmepogBLLHIFeFlUq0RqYwylb8X1BnMjR/p3/PD/n?=
 =?us-ascii?Q?xTtHtjUEfr5GjMTSc31YB/e+vWIgsutp2vFI4la4MK9U+3ZqYxVWjind8vKp?=
 =?us-ascii?Q?Wn5/gtF3+RNiOV94wG0856xPxLAJwh33CIS+OMvRh7qhKjcW4OQdoBLsypPf?=
 =?us-ascii?Q?W6BRnvp60K7NTjK80YkgkuJ1op89UgkelzduUn9uyLorh3tKJkcd7+c+Bu4s?=
 =?us-ascii?Q?afOaHLzp0aeyZBnTUkc8cv01addPPzd8zr19hGDds8BT+z5J9bGBl9jK2aNl?=
 =?us-ascii?Q?QdAg75CTI/5In6NfVI7YOnAoave4ajLbs908fOBfLeEqZz2AAHrsLHIpqhn7?=
 =?us-ascii?Q?5FnP042FSQxRdQNnfrPnpXFQYf/Kx8A0m4/VJidxxZwYPOaW9FrUYpb1iRS2?=
 =?us-ascii?Q?IRCyG2aLqMQe6EXgkAQNLP7CIF1mGq37mph03xhmW9+yRtwkavlWS+ijUrKw?=
 =?us-ascii?Q?q649d/JD3yv0suEFYFAovgCTGxTTriHOubMRHTG6/bZLJ9yBeqGmWLEpOvUD?=
 =?us-ascii?Q?/ZORn2z5/emeAbe36lkpZWAD5izQzDyUrszoiE7Mbkg6g58Nql4YrYx+akNN?=
 =?us-ascii?Q?BcxtBCly4Ub5RbLDYSUY4FVrJM3XMMjkeOQdie2W8MGj0t8ueccVG5XAteYh?=
 =?us-ascii?Q?G/nk3Fo/4wev9gReuTN08nC7Kf8MD6k2tCGpdOx8gGZEJsD50w34v7UQF93W?=
 =?us-ascii?Q?+y0JPpr98MlGyiXvnJ7wwYorXwbd85Q9G5ozzJAQz/PXR+v/bsx6F8DvmpOQ?=
 =?us-ascii?Q?QYmnQyejFYyyHkoosQz4amXJxVKZEW6WSFTue/ZBAu914gkTqXrr2CfFUh8i?=
 =?us-ascii?Q?A88F/gqO7OSm7ny2Omxtbv90ljcyByFoM4laJspUzGH6XxAE80BgVQZA+sYp?=
 =?us-ascii?Q?W8kwfrIFjYPzEVk+XOadD0YdU0lO+fK6H6QVVvy0jvqgG1fnAT97Ax3xMERp?=
 =?us-ascii?Q?14PgxucID05/lo43iKoBnmUpPWd6LBE1PSh9rCzb6Rtf3q48Qbcws21fQaaE?=
 =?us-ascii?Q?Lord5HA5c7sPNu3KqcRYOU0CjzC66pxnlCUFjL6xmjjXWgJDUnFm3LY2k0V3?=
 =?us-ascii?Q?sbBIIVZz8Bo/lXCAcQWtrSP3UIR9xR32OYwFArAQZqqwCz4zwTIk+/pp85ki?=
 =?us-ascii?Q?GPJdFSL8U1VPKORMXnIToKyR+8b0eXw+fWMq5bpx4KWSvYMb/HjgFDHeahJC?=
 =?us-ascii?Q?LxujRCUIWJkMuH9bPguPEsmpmhDSgpUiHVNmfZUQUujl+24FoT+XzZcIKgNV?=
 =?us-ascii?Q?HK8Ce0Kh5QK5iRxazyZTFzZS11iWVrT4i8tHqWYBddXslpSY7UZFFDj91vCv?=
 =?us-ascii?Q?/vOLEr1iIm05WiohIr1eojMEUiEa+2AYH5yWMoiKL2kWsa/5dsv+uVjBd2T8?=
 =?us-ascii?Q?ehbjREnLa6DeIk921y9NJkB/xx7R0998Vc88Na62hKWeOr5Cl0L3MTIWBu4B?=
 =?us-ascii?Q?NrkTHiB/wtU4UctmM6Sqre6JqXTdQJMRlC4qtJIWDQH5C8LKf1E9Iu5MqML3?=
 =?us-ascii?Q?DvxWgUvaIg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: zqim43Kj8z1lVTspi60D8wF0diwPapFlSNJzKK9X/caEiGZHQStQ8+Gf1yVxFRFYK5lA3WcNPNpMhrXc+w5XZIyzY0BrgdLcf+23tUPhfkRMMYBXJtA7g+URJ2di4HRv0XlvG8rdBtiCMAU1anubbx9hJKDnCP1h5A8ArIdVfMat9jqrIS9/TcmOU4S/fkzRGlJELyvJiNygw6RpWMLaDGY6LJBhNMADQjZE4E+vU4bBnOT/JnQyr99fmXogFmsFlEjYf6IvsDNC/Y0wxrBqRqi8x8i83XGAgWAWlrdZgCo8IH8M63HWAD2cSYOdIMpI1hyzvMu9pSAc1LEkMM47zQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb74b30c-5fd2-4132-11ac-08df0d71150f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 06:19:04.5652 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l7KoLJpZDqqlwNJneBoWCJb9DODPAQeMYU04NJmBT9ho8+8LTQ30wVhI+nEMImpkGnxyHWZYa/FIWlM0Gvitbk92rcLokOVzpGdKezC904I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5999
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
aciej Fijalkowski
> Sent: Wednesday, July 1, 2026 5:45 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Karlsson, Magnus <magnus.karlsson@intel.com>;=
 kuba@kernel.org; pabeni@redhat.com; horms@kernel.org; Kitszel, Przemyslaw =
<przemyslaw.kitszel@intel.com>; Keller, Jacob E >  <jacob.e.keller@intel.co=
m>; Fijalkowski, Maciej <maciej.fijalkowski@intel.com>; Sashiko AI Review <=
sashiko-bot@kernel.org>
> Subject: [Intel-wired-lan] [PATCH v5 net 2/7] i40e: avoid null ptr derefe=
rence in i40e_ptp_stop()
>
> Sashiko reports:
> ***
> If an allocation fails here during i40e_rebuild(), i40e_vsi_clear()
> frees the
> main VSI and sets pf->vsi[vsi->idx] =3D NULL, and the rebuild will abort
> without
> stopping the PTP clock.
> Later, if the device is removed or unbound, i40e_remove()
> unconditionally
> calls i40e_ptp_stop(), which does:
> drivers/net/ethernet/intel/i40e/i40e_ptp.c:i40e_ptp_stop() {
>     ...
>	struct i40e_vsi *main_vsi =3D i40e_pf_get_main_vsi(pf);
>     ...
>	dev_info(&pf->pdev->dev, "%s: removed PHC on %s\n", __func__,
>		 main_vsi->netdev->name);
>     ...
> }
> Would this cause a NULL pointer dereference since main_vsi is now NULL?
> ***
>
> Check if main_vsi is not null before calling dev_info().
>
> Fixes: beb0dff1251d ("i40e: enable PTP")
> Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worke=
r at Intel)
