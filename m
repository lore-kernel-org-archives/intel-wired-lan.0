Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24BAC982C4
	for <intel-wired-lan@archiver.kernel.org>; Wed, 16 Sep 2026 06:04:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ADE5860757;
	Wed, 16 Sep 2026 06:04:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aLTfVOcmP5_4; Wed, 16 Sep 2026 06:04:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E9325607BC
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789538665;
	b=USFzOgyp7mfDhQhBkQoSuqaouWsd0BQW1oiLvneq7k70dCCwbz4sEdo7LDngpbPluNxV
	 LPAP6lQ8c9n6dsFJTnIUOd3j5qWsO3whvIfBY+MCCmeStseio40vB3V5jTcwlOHZb7jtJ
	 o45Snrv/iqj5/tVoWDMUAJiOizwc16usozBTOksqA5tx2W/x6hceNi9bLpGFRELcbyEgN
	 EzMMYggg99TJGRr0KKxlr/z1VykWDag4qP/Zn6ZYtT4jiRZlFZ8775/8Sep4KqjhceRMg
	 VUxQ+tkyfzx985y5T43czP4i/K/ss1LA32Nc/O+s0Pm2pLaETtrM5yB6KKRF7/DmT4w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789538665;
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
	bh=vEmPcP9TiEvZIaVyd10Sbnz3P5xZ8222/JZ9O9Rc20I=;
	b=OHCueNJqeEQBTA8mFViUd1hkWngyk7wjNsK39waFgD3afp/mnRUehEY3K77ObwajXZmz
	 t2FliA6pLp1kt9QqaFaC0XUQ+Q1TzzGZ/mKlJwM/3rPsmMGKuiqKV5tY6TE8GlDEGJg30
	 BAUt5acvOP/KOa5BpBcxBvDX9N+0hJAjb7UTEFB6rxriT+mrzaJdidV+K4ZgZ8pGYkNz9
	 TyZxZdG2ESlXS92TpGsHZBzUHy20nB4DI4qJ8pXOpuXaiK4e1P9alN+aoh347k7hST9M7
	 qBMzuoI+5m/Addro1Db1f3wB9108Axb02Gx5YuxL9YxzBPYTxv0tFisQDRcWSb6g9ew==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789538665;
	bh=vEmPcP9TiEvZIaVyd10Sbnz3P5xZ8222/JZ9O9Rc20I=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iJ3XnD9GHLTsiPnhJFD+gCs0ZgWrh5/8IscujJkVBV1HL3846KDotgTEUT9qi4cFK
	 Se4BkuGyJ+w1/FxhCBoe6n+a3YG7+FbLwRf7+Q386bo5x+Lt+MI411WZM2bavLJHRc
	 kfuIGhKp1QDzlr4Zk9ipZYHaLdfoaCMSaZF+yluAoyEegwhooYJtfzvdr1gPF67gvs
	 sGrYd6iMtUQFFY2a2cObH6v7SA47UKDpo2e6yNQF5socFbS2OQRMsMYZFguiOSjGym
	 MdEM3OmWMpUw/Dy+le+J31+73zMQ51kHedNVCUbf4uLtsxkhcI+fCRasJjy6UF+0Oq
	 NTJrFiOHDY79w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E9325607BC;
	Wed, 16 Sep 2026 06:04:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A75693AF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 06:04:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A4F384009C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 06:04:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id huyfmelyOYJb for <intel-wired-lan@lists.osuosl.org>;
 Wed, 16 Sep 2026 06:04:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org EDACB40076
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.11
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789538663;
 b=exXXC4H05LJdLOlZ3I3CnS5naMNice4rqHmhSsqOoD0EmKeDNdEddKvkJpQpMqQPA16N
 KZqclNTDCuM3H0dt5YBRj7kC4BT5L6+1JM5s6VgQqDVfEqwmK5tqxKu4eaer+ulCCeERU
 gOixAnj6nF5L/3/zYmrXft/yFQz4Qbbtdgy5Ay0SXxbZAYy0WdHVBcA5WymNwTXYYJi08
 S0jSZjj0JszJhi0NP6qDyIl9GwycICA8MiVOJPZvF4RKBh/JUf5lZstE+OOWP+Yy73HAF
 zILlWXv3i48nZTXgBD5D8N4iphd6qae2qD9AhIRX0wY/QVtg3Xh96mwb9O5HS02GGjQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789538663;
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
 bh=vEmPcP9TiEvZIaVyd10Sbnz3P5xZ8222/JZ9O9Rc20I=;
 b=ps2LmoF5IgfDiSFDi2DK3OsF0zd3LXiLPj17G5RbDwUThuH3f/2Bi9/PQ439tvLz5FkK
 SX3KzQdkScYysM9w9CDrKsZWyLi3FOhi2YNzLzuEhlWj5iIBBhQnd4r3sWqrW44EHFQH5
 yHgw2xC0yOY9w6NJqBLnOVSd67daUymyf818TVtWXFxGf3fvqdgWn9nBvHtzczERZO1cf
 oFC7MKW3C3D2V9u+vz2SUDpophf/ZIuWHsGeIYtOSAXD/tKdkvwkS76wwU0HqedhPbeh/
 EpUnXAE4zvIzWNIryR/OJHWmHnnbrCVhaqRJjf+aUJypu6OoZuCf2xKFRcGGxrtY3Pw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OsQmbxkb; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=OsQmbxkb
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EDACB40076
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 06:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789538663; x=1821074663;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7vCqa5nHaa+GjdQ4rUd+XlJXIE7mOTGYLecHUafhgkI=;
 b=OsQmbxkbjzu/fIMZ9hjJ/WkIkj1GkdXndyFkru7Agu2oyvvNIBBpFXJL
 6WsWaa0aFsCAh7gGhgeGlWqqlGuRDJlihb+VeCdXbMIqdGHYhVpx//1tq
 MQam0ox7qbr/5IjpyZQu7YBHvdx5RYLN6GkbxhvmfXvPzF4w5JQzo8xyV
 V8iEwvYZdAtr50MzVHvyt/n7GOejPCyHLyLjJPct0vxEOGFkbAtk55aFH
 8hbu8h1/LW8P7c5dmHyElJ94bToxMDHWgC8ZUjpp0BIYzL/iRioKGOFeM
 lmNsxbV+OtoHeOq/BfrLGwazjJxDBkSF6B9UWSGV2akn/N2+/IX05iHpO A==;
X-CSE-ConnectionGUID: 0BP78MsOSMKh//IsdXifMg==
X-CSE-MsgGUID: fTnk3AqxTXuvtl/0L7c3lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100233494"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="100233494"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 23:04:22 -0700
X-CSE-ConnectionGUID: d1L4kxLZRa6dFIGCRdvJMA==
X-CSE-MsgGUID: yYAdE6BcSfK1f+1j3q3QVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="273204288"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 23:04:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 23:04:22 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 23:04:22 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.45) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 23:04:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WtXHz/HYzaJbwyC5YNgMnUBMaT890KfTE1f74UoWatLzk0SxoAeYXfn9YAuw35QM9NAFw0111a/F4eoyjnI+FpsBAeaiiWw6KFGmv14q/RbQml3BSlp84q1r4Fe4q2nk5ZlHeJeQVW03UGLmlRKuuxGgPmjhUnCA0peiNBP/ckL88PpzxWJcD29mbzYat/w1/9e+AMKSSDpeeHE4/wsmSaqiLDt1wREw1sCREe/linXD/tHuCJXtLFZNRUxt67f4mQDFC0jIGPXLv+YxU3Z9RnUThEZrOnHXFk0mzV1tpfnEZfDbxGbLWIJBkYJVvQg/cvjGVdkdni3kDYCrVu83xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEmPcP9TiEvZIaVyd10Sbnz3P5xZ8222/JZ9O9Rc20I=;
 b=PRxSMf8a0ao0MLfm+M9nk9K6Ml3eSoqcdMiHm7lHyaWpvp+xcEJ8+RG6eKUW0sMpzqaudhzVsAoGO+hvGpKO64R38Iu+i+6eBbMxbOugQ9HqlF3ni2oNM5pudxBfGWCuj16m/mZ10WYAU+L7IcePgzGIBN+L9m+/klsvNR21VZiLYK+k/WtrvTuITNQsNNc7jdQsilOWxWmSZcFO2c6bSXurBIk5csT4hYxMOgyMLTkROpR6RzqFqj4HM2HoAGqQ3eXBfqHKwrG2Krfv7dmveR7WtKrr38iMcwMOCHh473QVizG1sqZ+hVR7npdFlmBMJQscwVqp+oeE85gumk+3/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY8PR11MB7948.namprd11.prod.outlook.com (2603:10b6:930:7f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 06:04:18 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 06:04:18 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Linkui Xiao <xiaolinkui@126.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linkui Xiao
 <xiaolinkui@kylinos.cn>
Subject: RE: [Intel-wired-lan] [PATCH] i40e: fix NULL pointer dereference in
 i40e_lan_del_device()
Thread-Topic: [Intel-wired-lan] [PATCH] i40e: fix NULL pointer dereference in
 i40e_lan_del_device()
Thread-Index: AQHdRQDP5WCebrtjFUG7Rd19ntyvtrbQuFtw
Date: Wed, 16 Sep 2026 06:04:17 +0000
Message-ID: <IA3PR11MB89869FA8496B0FAAC52BD47BE5B92@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260915105447.574951-1-xiaolinkui@126.com>
In-Reply-To: <20260915105447.574951-1-xiaolinkui@126.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY8PR11MB7948:EE_
x-ms-office365-filtering-correlation-id: 0b1d563a-bff3-49d3-00aa-08df13b857f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|18002099003|22082099003|921020|38070700021|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: 5GtSp3HcqRwV5MRxJdPpG6S/TTGJ+CgWgWWzS++8kyCuX+0x9tsivph+Qjt4U8hNFE2Hy0etG0HHjlh1saIgGh9PFC0ZpkPaxQUNtbY8s1A1UfgRuLYVHiaiFDijCBH4CmxWOJeL+leVTCoNP2aTIwk7Zv8N9qi+XHqdD2phtxJ6hvPh48PO9QbHj0L8Ybhz5566e3m6boFNGJN6FRVjSXaZkNooLeo+PtydFtiOsLCdl3V0F939BJLr84c/dfKXKUm6Hl1SIefFmIsYx+pHrI5OSCm4eSB5+BTjF2Pg5aWNs9HzZsVinoU1vjn3n5dSyaZfqVqvqk6lw4iJujB8ixSikRl3slSaXr4she+jWSkiQZMHScFYvI9lfsujEz9gLVyE8l+CMAkoECD8KpqbLu35x+N7sOMdObo6pc3uoqx8XYlZ1lDW3fKgfXBGkckMwQBnn+zjQLElQqsnmtNtkiyGHY/fxkGVUCOZ9Zz2IV+afnTYsCTblKCuzgXten9tgfKhITQuQ4oMy9ctMwjms54BJIHzUtrsnO5rAXh68H19sq90ZG8SwzcHwqOChcifRuhzXsYce8UoxNddBiL/m0uo82ZxfIXBgZBkbM7ni8kiN7pue1GDXFLEb+291d2PNUspKduhbXNAaDoR8OhC4nl38LmGxHA9v+rvOIUG+7Ta/ErH3Aa9vxo0jzTgX0z064Rhm/aQt1SnZU+gc9iNXMXI+wNVgqWBv32/LlTUdII=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(921020)(38070700021)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QbhFyM+WvLjdHRgEBXCPywUheuq5XXXd56fVUCRUHBBf6r8+HPWPZk9xdOl0?=
 =?us-ascii?Q?EWeoObLDswFVg3LzHZBqGLf/1AeX+3MMDqeO6g/bEzF0S+mRDsRZzj2v303L?=
 =?us-ascii?Q?Fu5bH1VJ0DNrfLeJsoytHQ8tUOl4aEM/uA1aNV280j6hwE6CMpTCDrbgQOkb?=
 =?us-ascii?Q?z/rIIGhASLB1AphL1wcqC1axOqDJUC+Akgm+hrRKa3WWVPYaGQoGyZRXbhUg?=
 =?us-ascii?Q?R1OSmdbZ3RWvaJoIJClYf7TboDTDlHj4TzFxuqPN3j6ccDzqJP3lBsfwAV48?=
 =?us-ascii?Q?CiZDgLIlygq44ulTxAyH5LmzlhS/UHy5U7fzxMPz/Z0kVUOP0801nvVjEpKC?=
 =?us-ascii?Q?ARk+e8Hc2qSnCy70jCnkZ1Sd6PtdtMx7JGaf37oRI2nX6Xe69WLSNqJVuRwj?=
 =?us-ascii?Q?/aOeGubRJ/xQDg2KKZFYOgYLXnCn/VuI3gDoapDUPv/Hqncf6PVMaX76GMbK?=
 =?us-ascii?Q?uGFc7uOhTeZD0rnngN7J2fVyOM+ybJsh0yZgGPL9aHKue+TULG9z35ZheVei?=
 =?us-ascii?Q?AjP4yTwzwHKgHyG/0EFf2yKvbxe3jttIYvMnJVNiK9Hh1m0N/+ZY+KRkVjcX?=
 =?us-ascii?Q?C96+zk+2ybZQUegPlcj+w/RBdATN2HGkOZpnWrX6/wmsxhdWDfeWBC+cJ0rz?=
 =?us-ascii?Q?Qrrc2TtMBaxJugnWSsiUgnjf4/OdMo+S78CXZKBCT/KDPf8kkBzsYC+BT+uB?=
 =?us-ascii?Q?6ICyuyK8pwrPBtI67d2X0JJo8hT5+KxYFKLAWYGQ9DAgrvB/YwnfI/xZZ5QP?=
 =?us-ascii?Q?Auv4pQoQ33wAW3jszd+3txn6fhofftdEEQ1PIzjV5LPlTIQFlRLceP8qaCfj?=
 =?us-ascii?Q?pL+Y1MKzpgMgq6FSgA5psQau73uRyyf0/+11k+aD0jCJ077HUNh9X0Pmks6B?=
 =?us-ascii?Q?5h/Zf2ianOpC/ygdVo3l3XcyVd9uHYE0b394nK5snNxjIqKWq4i7T7N0jGAd?=
 =?us-ascii?Q?tGfEOcrPMzrvFZWDbVJajY0hE8UyMpA9JmQxDKj+zGDSsivSBhR8mFm5Drvy?=
 =?us-ascii?Q?JLygPQli1UH09Isx2gbKiLc9EbSDFtN9jNUgKe1FAahEF7ubwKI+NJJRW854?=
 =?us-ascii?Q?OWqCrRxjD0C027bKRoc/uzdFx+74tJ6/WV9A9PWCWjF5U2DbiX0vAeyuWgUg?=
 =?us-ascii?Q?mK0CXngPTE5Wn+XFU53T/f03/4sVw7FkQeH4LAheK5SbP7mBVMUYCDbYwAs3?=
 =?us-ascii?Q?/RrO2Ud4WVMru2PfaGYETB3lr5ux4uO2va3ubmI1046raAraTxZYLjnsV+wJ?=
 =?us-ascii?Q?8GWfQVdSkBDA/XqhJKYUmLqtTRPARLNZiOIL7SUmaSE66oO2ZadLs/Ud3lTJ?=
 =?us-ascii?Q?HxXQ8+ytDo+p/x05v0EpfzzxzC+pg29hfszy7hoSw70b8LHD3+TVsHr58xr0?=
 =?us-ascii?Q?etCsFgo7880/zh8CDDTXJCbjzNAdvrt6qI+8mB8CiADEyE8g1V/neSkoZkq5?=
 =?us-ascii?Q?pKwGRSyjkOXseQM0TCKNFngB3amBXsk7V73cqa8Wf6tVNBX6i6diQ1EFmdEr?=
 =?us-ascii?Q?l4mX+hfa/kBUcLb4VczrW6R8KX7kFl8S0v0qVuevWkie0tf6vw4k8zc5eBvp?=
 =?us-ascii?Q?c8knIoyk9lad1pEqo9bz9jp12E3L/IrPrpcE6ELi9by4tEM+fraj7KQuXZXd?=
 =?us-ascii?Q?HUM710F8lto1O/lDSNhEx2HZp8TtxvYPCsqOOs9I9t91famfq4Hcw6YHDIl1?=
 =?us-ascii?Q?dxuFbvayttEgfBXSie9H/gRfcqYfQgPs5DE+wq5WzqiPA/1vWVHExnlMwsEK?=
 =?us-ascii?Q?AKyvxpMLmaXUGl9RPLAE1iw9VYsTHw8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: D/bd2w0qe6fR3lKEqQXhgQLyzZOFYYXIv+M/ZuRYIEut2XgckqiZs13kw6CC3MPGDkluuTIE4cwhKHNsMkPipdN/MelObAij0YZBd3aH0Oo6f3TSjMwZ05voqz3huEvU3ba+M5CDOncAdUAChlK1hEpmEVmvdl/s3R++ExL8Bj2JT694P6YMVqS1LI1lHz3VjdD43oXOjpXcNHePrg5iVJWdEaOL4oukpyo1JvA4wf+8GpQFCGDkM9d+iuSWBrVT6nWUZVQxs9FotKLGgXVA4M91At/o+LocYc+fd/lh1/TveC6CjFq0klDFYvXAc5dir88RnEr019rMfyEgKbFWVQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1d563a-bff3-49d3-00aa-08df13b857f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 06:04:18.0329 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iS0PF1Al6nB8P+UR2EvXULMUXdMceporDXKqp+kWmK/HBCwXyfX0VxaK4Y+lFewGyqAtW23yDMhU+sR/AsEIoUhWp2zU/zoeHGDyvdkZgDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7948
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
> From: Linkui Xiao <xiaolinkui@126.com>
> Sent: Tuesday, September 15, 2026 12:55 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Linkui Xiao <xiaolinkui@kylinos.cn>
> Subject: [Intel-wired-lan] [PATCH] i40e: fix NULL pointer dereference
> in i40e_lan_del_device()
>=20
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>=20
> i40e_lan_del_device() dereferences pf->cinst unconditionally. pf-
> >cinst is only assigned by i40e_client_add_instance(), which resets it
> to NULL whenever the i40e_client_instance allocation,
> i40e_client_get_params() or i40e_register_auxiliary_dev() fails, and
> it returns void so
> i40e_lan_add_device() cannot report any of that to its caller.
>=20
> i40e_lan_add_device() can also fail before it ever gets there, for
> example when the i40e_device allocation fails, and i40e_probe() only
> prints a message instead of clearing I40E_FLAG_IWARP_ENA.
> i40e_remove() therefore still calls i40e_lan_del_device() and
> dereferences a NULL
> pf->cinst.
>=20
> Only tear the auxiliary device down when an instance was actually
> created. Removing the PF from the i40e_devices list below does not
> depend on it.
>=20
> Fixes: f4370a85d62e ("i40e: Register auxiliary devices to provide
> RDMA")
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_client.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c
> b/drivers/net/ethernet/intel/i40e/i40e_client.c
> index 84a97ca8a6d8..9a4f50af5347 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_client.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
> @@ -496,15 +496,22 @@ int i40e_lan_add_device(struct i40e_pf *pf)
>   **/
>  int i40e_lan_del_device(struct i40e_pf *pf)  {
> -	struct auxiliary_device *aux_dev =3D pf->cinst->lan_info.aux_dev;
> +	struct auxiliary_device *aux_dev;
>  	struct i40e_device *ldev, *tmp;
>  	int ret =3D -ENODEV;
>=20
> -	auxiliary_device_delete(aux_dev);
> -	auxiliary_device_uninit(aux_dev);
> +	/* i40e_client_add_instance() leaves pf->cinst NULL when it
> fails,
> +	 * so there may be no auxiliary device to tear down here.
> +	 */
> +	if (pf->cinst) {
> +		aux_dev =3D pf->cinst->lan_info.aux_dev;
>=20
> -	/* First, remove any client instance. */
> -	i40e_client_del_instance(pf);
> +		auxiliary_device_delete(aux_dev);
> +		auxiliary_device_uninit(aux_dev);
> +
> +		/* First, remove any client instance. */
> +		i40e_client_del_instance(pf);
> +	}
>=20
>  	mutex_lock(&i40e_device_mutex);
>  	list_for_each_entry_safe(ldev, tmp, &i40e_devices, list) {
> --
> 2.25.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

