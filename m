Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3709ACA5FAD
	for <intel-wired-lan@archiver.kernel.org>; Wed, 30 Sep 2026 01:22:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 090766081D;
	Wed, 30 Sep 2026 01:22:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dh-0GONnSiMp; Wed, 30 Sep 2026 01:22:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 63A5F6082D
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790731354;
	b=ZXx/FBwcK5SAIU/kL6UTC8FtakI0Dg7YSdiGCYi9nJPYoLI9NNC4OwvtB8G/r6Ca9LrD
	 w+uJc/zdaQ3EO0odPIqakkC0/jX2NhQ6iPa5CWeRUdVGsvvzTHXCG5InR//iGddcNZJmQ
	 M1X7HXv7XSCOE+L/q1RYI3GcnYmwtqH/4AlkE/wIJ8JMvj3YOOWyKvgfAv88GeuScwln5
	 F2Pfusz87KlGAmVCyJXL8WAGyUSBptxWrAkvltFTub4v9PGLdUzvNiK+JtjlU2s5sdnyU
	 NX35woR6ONuph1x3e8KUWd5jvqvjCo18jmIzKJTei0kcMulaA7J7JAVu8hO6CNWByXA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790731354;
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
	bh=aFrkeY29yiCgHxDFrunK8FHxforhVLdZaeQIbVMbcbs=;
	b=GoLzGhR7X/FbfoA/CGA53xxCmRXg31fJZ/Z3d+pnGWcbcRcXQAla+GCxQmnkFTkqNE81
	 Lk6ClFTb/TUwXibK71pP9gFP43vDOvZXOd/ITjirr0wjk9G+M7fgVyzZZruJwBtOgZBiu
	 krHhtUFhf8oi02jqybqXlyEqnig39JzI9AcDBQVRSBJgXkPVTa8yX5U9ZccC+xL4sfCCh
	 6kILTy1jak0pMwkK6c4C4RtV+zYpyc/2WWtOmyXNvYg7/e568x3SIzhvlzv7CXgvDs/h3
	 m3gGOnXLIDAr8xZADS9qNlcWpqsAgy9bplrj8RqFtB5zRKYSllQc07UBPlWihpRf9HQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790731354;
	bh=aFrkeY29yiCgHxDFrunK8FHxforhVLdZaeQIbVMbcbs=;
	h=From:To:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=evq6H2fHrKMbkrJeUy/241KnVwW0lwUuO7wowdcIbCotasmx01h3SnhCDpeZbWF3a
	 OpMw5gcoe/Fnu18ZoamWCVx0aq4ybE00NoPjjgOx17tAkHEiRgirThxnYQM20IYeXi
	 rIXVT1olF6jAFa6Z7UAeSNINrKuCwjeWYkii1j4BQsYtC+hLjwaBYT6cDEDzKg9Xio
	 HlwZv7+RJk2zHgMQ2yoM4OxCUnxE4bkscDALnoSR2eI3zBoLAtwA7uxX4zA+Y/HTAa
	 Ux6AYaFQjPqcDDSsClOGJWABJjuba/1iWbHC7AL/PMl//ATTkTqOGXDiH5jtpvvBCn
	 5Nc7xckbeVuyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 63A5F6082D;
	Wed, 30 Sep 2026 01:22:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 461CF282
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 01:22:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3723180E75
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 01:22:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id smGa_OYMfNik for <intel-wired-lan@lists.osuosl.org>;
 Wed, 30 Sep 2026 01:22:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7A26180E53
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.8
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790731351;
 b=JjocAQ5tkeKRC4LaukWvQ40HDbmVvMCh/uTUZcmWhzOUEUZ5HZqVVmvgDV5LGNUBed24
 Muy0a3rW3YoGvQwujOFJ2nP4Fq32OI60uOE3hqcTNXXkSoLWZqAGxJ+vPoqNdPtNIqxqp
 vvnK5rrN2eQ39Wqw+a624+Cp26IhV4MXr1PGvdL39mruIVYTyGbInm6wKbiKuYb/T9Ipj
 PCX2A4n1a5+rDR/+QuqjmrLPGm8BQm3BQUjdyGNkLM5MqZINay06cX3p/1WVbAcoKb0J4
 c7h06vebnO6bellY8QnzO+pMsiAN84DcgAn2f3DLXDaB0A011N5ixHPj3UoN4B6VnlQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790731351;
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
 bh=aFrkeY29yiCgHxDFrunK8FHxforhVLdZaeQIbVMbcbs=;
 b=eBFL0V2O+prHqGVLbpbzuJongYa0gQygUTJssy2E2cB96fHJuOSrBx92HF7B9YeUNS2B
 Q8CmItJsZlIrDmwL0OdfshYGYdg2suopxvpUnpWDhhp7577VZK0oPyhfODaNqj49Yxx58
 Q5ig28KBxkBJBBPa+9/jHSUMBVODnv1GtC3xXSHvcCud5Nr3GryoBOrwC3PPnffnGEWNm
 6tXeza+dXgGf8t6cxvLjkFIKwFl2ShkcUaJ3nXv4cLB4IQvlGHlLHXf2ObQR5an2Oalkl
 MOVwV7HQFzM+Bcf3Sku4vdxAv4Cq3rTqaf4BcaRJDZdnjRf+zu9D8+mUKMcuAw0ie6g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CGTHw86z; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.8
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=CGTHw86z
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7A26180E53
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 01:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790731351; x=1822267351;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=trTry3xkH6rWUuqPhgeoz2K2rnysfF5oDlF5vUjm2xg=;
 b=CGTHw86z7AdtKMWhyKrW3OY8CnFRJIeDYQTBaFmgF0TSakGLy6bnqK6q
 KaC9k+ZjKBLdCXgVr5Su2s6U3jLBGxPy+7JGLZ8qnkm2WkyQFbPQ4+a9g
 k/ZSeU4k1XX1pghiioneOjZSL3LopNiig4RLirfT+YQegCdNLVHBz56wG
 Llv91grYK5mjUPgw5tjlHW1QIiGpZVodUhOgvRkTsr4IcDInH6gqsqshb
 Y8zXH/LatFZcyiAtewmasTeIcVc2TVF2BKI7tleowLoQX9jULnjUCHIgT
 n2DjjpdEZvQSdpBVGdaZEoaJ0yms82pE08NCfR0dHyaqqF7oP+8xtGuyM A==;
X-CSE-ConnectionGUID: 000zWx6MTi2iRMB82YfxpQ==
X-CSE-MsgGUID: wYpjC7pXT4y7taskfD2V+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="108949183"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="108949183"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 18:22:30 -0700
X-CSE-ConnectionGUID: rGZs86EyQjC1uwCf+T0rKQ==
X-CSE-MsgGUID: eW5wklo2QkORm133yLi7uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="273315211"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 18:22:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 18:22:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 18:22:29 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.55) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 18:22:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzj7A2cun0B4jKLeMBND639UnI3PjdwjkwKS0K4LjdzSVMcd1jzq5lIS0RjwHf2UzvcPnMSOBeCU176B87DG5xnnS5gMTyZ4w9XeODvYgFyjLS2yzWTK3qqztWAUVBOUVz6Z/z5jR5tifGtkmc9Y7uGGf5hVSeyc0r4hFNZ3/pMkSGMIgeEbVoOMcImzNTEwtNaHPP4ksSdKhsIIWmQooiGO30rsC1THp0UDzNP53aWVYFTlWZduPPqdiI7r0w5NyK0pjv0RkvHdi+X5hipbYnNjF2oGsxEWbJw65zAFXHUi+Ty9opJkOOoghVnWHzskTz2z55bK22V68SBEg/yVYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFrkeY29yiCgHxDFrunK8FHxforhVLdZaeQIbVMbcbs=;
 b=RUDkysHNQK+KxkwaASpw8azRR2D42a7jRCHVzL5yjlttERu5OUu9YMnhHM6Y9eXyRKsaBSIr1hy9J4MAyU/MLHZwf0etiPSy9RGEXvfgL+9RZT5YyiPmUYfwrR2YgetkctMSD13hU6WLJ8zSWHAOnKQI//M/YJxE3MTc5C+qtOMPwizzP6GiiHSLD55ZOCuSjI7slySwpuKxsLbMq5SzC/mi90c7bmn6wYmdekK13QZxsNhZadNnIqtfvdDSdRQyQAFgvFA7SVMDllf6jSfi4MeYYOAYpd6rFymO50DrJSxlOl3MXK7i2S5C3kHrVlSKSFXSYCQVC/PDjUTgyKyyPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by MW4PR11MB8291.namprd11.prod.outlook.com (2603:10b6:303:20d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 01:22:27 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 01:22:27 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: Yury Norov <ynorov@nvidia.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] ice: simplify ice_pf_state_is_nominal()
Thread-Topic: [PATCH 1/2] ice: simplify ice_pf_state_is_nominal()
Thread-Index: AQHdO6ctIcOeK1LhK0GuPDylj5C+QbbmfN8g
Date: Wed, 30 Sep 2026 01:22:26 +0000
Message-ID: <LV1PR11MB879010209DCC2C3D2793C09A908B2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260903132037.81346-1-ynorov@nvidia.com>
 <20260903132037.81346-2-ynorov@nvidia.com>
In-Reply-To: <20260903132037.81346-2-ynorov@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|MW4PR11MB8291:EE_
x-ms-office365-filtering-correlation-id: c9ebcc53-6455-4349-5509-08df1e914a04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|921020|38070700021|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: +u6gOSuQhoV48ERY8SnMBRCH7n3hEx/+3zeUCW8yhzcvXVNpYLHEwVA0VhQvyJuXjobyzqkdCHOmFaGB5qw7vgRhRsHoFWIxOwgydaiJ3aZ+E7tPJ9b7ZYzvCRLQ/ktHYUL6lcVu7zXQABXzqG9FAKZQYDNmfNYYLzN/ahyjMDcHE8ZRxPMuJ4YPRfBtQ3uhfUvArRf8TlNklqDWqJny5JJPVg0GkPKiy8rw1PRjvWdf/b0VpTqX9+EWXky3ozE8ked324IP/TW/K8RynTLKAbgI0tKrKK5cY8bokJh+5OcmTZ9l4AgSfzj+L7p8kuETrZiPJFAMQGUcYlqW71R7rQeQn84lL1nBSNGh7hmvS1D/G7U8uLJvvNO4FH3dcVYjqrGZ05u12Hy2xhxHseRwP4o4r8yKemFG7k2V4s0N3HUB73C1IoWRK/nx+LuYoKgqrPnaKvOC3JlTYJzN+k9fFn1FKXMHuPnduIJYTY87S1sEUdLbHCk55LT1zyHzIVGDlu0zErpUu45D9V7pT+ZM1hTHd5Nph//FkjE2JFSCae6IiVjQ0cVLwpDgxgrCU5hJD2X+jB+ifN2WYRv4+miWF2TUSg9HrSRPZEZAicxnBpDNnwVkm/ti1o1O011tKx/KxBVx4ckYrFpEvpHfJLa9YsWkc9Z6tcwH/49JTRUFebptdro0uo0B5siVGezNVoY4s/5eU6UmuDd28uj9Jzx/Ul1n5shFMLltP+HfFTwEVFE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(921020)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VvwGQcaXzMvBpsVmfG7v5p+T+vSvgbD8kooF57nG8xdcf8xLYhqlarELqXwz?=
 =?us-ascii?Q?VX32loRsU6+q3f6yUM/s+swp3bY8HbnUs1tH2JgQajXRZyAAoxs6R3wWp0Ba?=
 =?us-ascii?Q?a8+LzZHHlGxeeL7onZvFzabwDYdTGdqAV9APrJ5BTitRxAdhvCMBHTdsAJOD?=
 =?us-ascii?Q?nM0H1BeE77N870A238fuVK+OB1XhX9FsYNNkKuvqv4Kub+zy9SKyohJ2BBas?=
 =?us-ascii?Q?paGRBS6hVMlxBFE1rGmtbgpTwPlstu1HUf8+QGvtIBethr42vc4F+h3zzn6w?=
 =?us-ascii?Q?LSj4WDQhAOBRERAgvewsEZttr5dc6V15F1spNr/+lwQQiFDj3xEq+LSpsW5d?=
 =?us-ascii?Q?PiMKZEpIIkmYf2OvOCGjEA3yGhnppJlM17VlmHZLhPzdTbQ3Dn7SyBhKRJss?=
 =?us-ascii?Q?br5V3GvDdpq8VVSZVO/RLQ8orW5VE9/I+zzMApWEyy/qZTIZuGM+nQIdimln?=
 =?us-ascii?Q?4p9yLmZdWQCNf6pb7sjb6zWY539Kpo6fbA1uAByxRv+wQAxH1yCK3Kg2lzjK?=
 =?us-ascii?Q?cISTuMg5jpgEdH/7s4mSzsrAuBH1HciPUZPbRbn9DOpEIsfcvVE3zTH8GJ91?=
 =?us-ascii?Q?Pe964cfJa3hcYDy12ty+ub8osKxgOcDCJzM4fKe9gLDazn/b9kYoLJbJdKPN?=
 =?us-ascii?Q?DLBZkSZd4uWQkxq06LTT98d+BivR/4EHBxUU89O0bzI+ZYfZlTTsSc5e6XRw?=
 =?us-ascii?Q?8qFStqoKJ51+A9J1jq/48MLQeu42O2UTPfZbGS/XK1rA64HTOS13DjXssQcO?=
 =?us-ascii?Q?gUA9zMcLfKhaeVkBWITMGv9TYhukYOmFcmrbrI9HXH8xf/3pRQPSrKsdbCw6?=
 =?us-ascii?Q?M77IYkglEJZdePC9ExnklvjwXdPQjecFKB2QzKOgoQk6VuHUa/Ng08YWuDRB?=
 =?us-ascii?Q?9aOqhuaXZKI3XqhMhZq/n925oZRl6RQrD6xx2nNxmmyR3ld12dzISE3Gd6kM?=
 =?us-ascii?Q?mKdyP3g1ZTk5iQPueiE+1f0cl6NuojQVNtW38w/OsIxgxYeRQRYOD1933/gl?=
 =?us-ascii?Q?3/QIr9lxjc9XqeTD6crdvLOLZ9+As9+2V6XBH+HDeNNvKLsKgJ1xSptjnwcR?=
 =?us-ascii?Q?dqMHElBPKt1mZKNNC38zOumMCGUOOa9TTAxNW2OJ4VsNjTZfiNTh7Ymf+hXI?=
 =?us-ascii?Q?LTRXLtjjAubGArsezxU232c7cFZZ1F5B8rX6k0hoXCUr55ileJFqcYQn0Jsw?=
 =?us-ascii?Q?YjHpkD7Ei9FHrjZF447r7+vkwLZy/hDph8jH8jlYSmDnd7Q5IY3F/KILFHAL?=
 =?us-ascii?Q?2r/2wiCPwOxY+ujexMJ2nMF728S5YK41OdRB5WzljZeSK+llMDE1N8OhJk8i?=
 =?us-ascii?Q?0GxGfvMkAvtIx3NkUDDw8sCMLp5LFrNb4tcOUIbCH5vV2k8g1ZIRd8+BXxmk?=
 =?us-ascii?Q?k/mdDgdmOWWDf1YzVuLyrb80VVK0JBRdI3bTCTzm62xc/gHspxWfEUAku5bV?=
 =?us-ascii?Q?K7Y5yKOKjbX3Cau7OUuVgFQYynMJRUBLMkRRpmvE24w5mCnGw9GC9UN39unw?=
 =?us-ascii?Q?+QQHqX6Apx5qwx2q7zEzLVT+sTFnYvHAqNDOh87jxz1//rJVyXtudPkbfqcl?=
 =?us-ascii?Q?mfb0KbNXYvIeuOJFF5QHkvrl2BnaoWEmpuqRViDRYuC9F9xaYqD81zV8JuxP?=
 =?us-ascii?Q?wl5l83s0Set4N8dyMP+u/qA4XmmxJK25toa0G3EqCiewvWXFclaJzbG+Ektn?=
 =?us-ascii?Q?tQN6GSFFRiv9ePfKwm2RIYqf2sBxOErIcnori3MzhMiib4Ygldp6l2+NPxEu?=
 =?us-ascii?Q?A/1kVEyvAA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HSf/dPVHf5uLguakR7sb0Xdn1dp5X4aPsyrSYMHhiwakI1fsO/n0YyUPun6EC9lTexXP+Z3T+M2+a5xX4YjVPB2iBFeUovHimTstlb/Y7nmMppPgBnhbt8JVFhr6iQJdyduejq/9iXdafX+KUeW9GMP2PGhYtqVfEjNyMoSHWr+hhcFRXVbUyJHq/RokC7Cd9UZNumvcLYB/JfaU06pVuMfqBaxO/kq6u6NAxgnTr1HCYIcpkVAWT2W1qr2Okybcg15QL7ImwObpQGzww/u4UEqlBITMb4kONZhQzgrehGZAb9cMoe9zescZOUWLhCOW5fA9zTPJKaY+OOQbJuuKNQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ebcc53-6455-4349-5509-08df1e914a04
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 01:22:27.0215 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DOK7+/xVdowTnZAx3b6fjDocbMjbMcLuesdVQ3SUwM6O7j2a4iIkDYtzVjr5LGlhi8OiQe00VEWp7W/iGqcOdcRhHhQCeG9ZkeoNqyvcp1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8291
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
> From: Yury Norov <ynorov@nvidia.com>=20
> Sent: Thursday, September 3, 2026 6:21 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S=
. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub K=
icinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; intel-wired-lan=
@lists.osuosl.org; netdev@vger.kernel.org; open list <linux-kernel@vger.ker=
nel.org>
> Cc: Yury Norov <ynorov@nvidia.com>
> Subject: [PATCH 1/2] ice: simplify ice_pf_state_is_nominal()
>=20
> The function creates a temporary mask on stack just to check that first I=
CE_STATE_NOMINAL_CHECK_BITS is empty. Simplify it by using the ice_pf_state=
_is_nominal().
>=20
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
=20
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
