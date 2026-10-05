Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4CCCA5FFC
	for <intel-wired-lan@archiver.kernel.org>; Mon,  5 Oct 2026 16:09:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 76A3540675;
	Mon,  5 Oct 2026 16:09:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d_B9ZkGHMfRQ; Mon,  5 Oct 2026 16:09:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BF75E4061A
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791216572;
	b=JxqgiA9Bv7IQc9DqzKaxyPXU7N2mcOvjhsye+TWeiGT8aO/U8qU5pLs9Ftx7dOj6On4J
	 bgiszVoMyLeEJ9XD5FvYr9gM4EAUrRdzj//pCHF9i1U87+XmG7ij6P9QzDBfgwWQKaw5F
	 rhMQLXUAkvjdB7iwYzu54LBmfwSLz9P6qWT37CZxjevm1YAS9Kcx3xMcS1OLVKqCYQ98u
	 tg+gW2O8DbzTCOMTzhl1o3qTUrXR9w25MA15AZzshgGUcSzEo/AsCfToJ1qpMVCh2RYPN
	 rgaNVvvbulpr9gvWMWtgSUBWvW4VvM9cWjQEZ7WJV+c/snONKKVRUgzmBB2sCndhL3w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791216572;
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
	bh=xONCGOyXtEaoZ9AWvLTQtxMGMTG6eRx0BAlxPqVogSA=;
	b=dddJKR7d97WX6rL5XGX5jkgAIM17uzXdR7GMOuE78ENbAOgaphwoUUOFeNfCybfBQM5h
	 exIS89TZLj/Sk0BGmMo8K7FaHdbNt1JIjp6g8YpsoLqZdeZmz0fvQa1dpVb6je7eU7zfu
	 oaJBc4Wo4vcjZ84uVtTVwNRegaVZCUj+y++9hs6uyDoN5aZVfq2bllVLXZ1QVU9TsNZAN
	 DtE7AwVR6OdRupRNuD7jOzMjAfF3uhGMPMjLt19oW4tVEXqZUAU8SdT3ML29fu/drDBKj
	 5QnW6tX5pIda187VBHMY8A2j7VCEb+YNcV25pgs1KDefe+jY1gr2m8l48rC2SeHJlVw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791216572;
	bh=xONCGOyXtEaoZ9AWvLTQtxMGMTG6eRx0BAlxPqVogSA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m75l6rLJ/u7SvlAi53tzdIOkCCBsdjjwiwb+82PLHz3sBDfwr3ljZYnuo51V50mDd
	 2Rzuy+ioT7IlocktiIyPCv2PAzs4mEgWFXtScrfT0RUDp5X//2tbyf0Zbfqq8RJpw2
	 44YEROFmgFaNpibmvgUpgKbqwXT+z1mik1A3FJgycyOSxp/RtBvireg2nDimFKcHD0
	 8JjhUgLCIVkJT2ldTObPLkX7Ev+3P2Dg3w0zyduKBXwlKmUny4yQ8XmpEst960jNZC
	 FOlUTYUvm4l2CI+6c4QwG50tKy0pwvYNDwEgJWruTPdfOm1ZvgDd3hROnLuMmbglOK
	 6T1ogMG6w6TiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF75E4061A;
	Mon,  5 Oct 2026 16:09:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 885DB34E
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 15:55:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6E0D040202
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 15:55:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1-iOyGp7Lbik for <intel-wired-lan@lists.osuosl.org>;
 Mon,  5 Oct 2026 15:55:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5E40E401EC
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.18
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791215720;
 b=M4Z9CDRtpAYOKc5GuOxA6EU49Wtq5rEDla48yUo8N7rFbYcp8TdzsghJHrV1j/VucECO
 UX9OxmZfjq8y9Bz30FPtINR4YeAwwENvS1ZZYv7/z/IsmQUIcuJ7ZKEOFDAdz1p7ape65
 ISvm1qMHlq5uVa483Eoqii2JEmfoYK4eMFd4hARvPzMlPVundkESqNLEtjAYUv9fROCUx
 M/0lDOH8Z/RdAiRT+pM7CqAbT3x9ILcP3G480oGgRhlmmaXdHCvQ5pZiOLlGX4+ak2m4N
 Anx0pgRv0YD9G0sTAoJ5lmG5j6Jqv98GaGsEEVchlKtu86fi11trRh9Eod1JKzvrDRA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791215720;
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
 bh=xONCGOyXtEaoZ9AWvLTQtxMGMTG6eRx0BAlxPqVogSA=;
 b=DL2EPB58QaWDYD4wYvXetsOc5B+Ly/uJBdtfBWHgqo0JMn8R20HDS6hJgtCoYH4RKwDe
 YYHbFQV1PSbHkk1dDLeF48HyYxYCvcyNbgEAhKCVFAL+aZJ1BUcajK5vjvdYqLrKIhWoX
 1MKqUinQWcJ1uisT8i0lD6sNM7OlnG0Ehif9bH4KW4E5iOfoej6pWwbQye/o9i7vK/0JS
 D0/USYhM98ha+J61RXYq0POuYd3/ypIfCVLy0TVt8zTxwqKfAAVvkEAYUVyeRek91QepN
 JtHe9frWHvRmXk8Z3pzPho+eojpBlCMq1z7iL7tWak45DTi1DUNFVosRv6yY0PulxzQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=LKlFf1AB; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=LKlFf1AB
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5E40E401EC
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 15:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791215720; x=1822751720;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=heCQLTOIt9NroSGvfpgod4nORyLGs6/lworQCdmz9ZM=;
 b=LKlFf1ABO9apfB9ycc0TqniOP7qCT41HHiWQdtZpR6gOgLOp9HQZZgvY
 DVMNPqybOZoXNp9wAN28hCGxGK6UMpd+W5I+duCDlMqqQbaJOijEXntgq
 2At9XDm/WKxIk0IiV1tBD97KKaOMuCBVD6uZB+iGzfqwz8BfcM603whZq
 VqLj088TFn7Fprtf06RcZYou4H8Vj3lvY5/ReJff/4Ip/X6DhQ7+X2P3U
 GA/xlHbznfuC/3rHN/3HaMaYFIzOjHTPzuyhY2/FARJaTybuNiGWcOdnG
 58ZBWduJ9H+YEQJfrRgUSQ7CvmX7ds8U+rZ1WSF2CCAQUcCmntSL4GzDg g==;
X-CSE-ConnectionGUID: pDNCNZ+QTXOlorEfL4e8vQ==
X-CSE-MsgGUID: 2uKEn+GRTuWVHNjfC6WYFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="91021757"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="91021757"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 08:55:19 -0700
X-CSE-ConnectionGUID: pwJAjyDVS7C90o8frUYoGg==
X-CSE-MsgGUID: 81/tWKVtSjaBj7BrO72gYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="276974197"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 08:55:19 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 08:55:18 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 08:55:18 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.54) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 08:55:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WtdITJk8lGXAs7+FP6/Z/Q6e0Yv5cziwwK2IJsmTKGytJcV7b3TTOzBzkURKkepD/tZjzWwpeiigJ6m+2EUWH5p3s0A8+tLmfWiBXLhWfk6qZ4RRgz2JRVYmiV8iE9YEH4yfSKxX/JTsDgVwKZ8W2c13mUOKJToMhmzxgqH0gwxcbCCbp1Gei4rgO/65FojR82MpC9jw2MXYF5gEKjZleRLIqSrFkWfpIsDUySLsLPUTvKfMTHoPjvNy3020qSpv7FQNfa5VtbJntDLNas7YmKDk0CEcCICi4cReRk0M6o1OMAvUB6tkSguKhcWM/Uec+nAyjv8Q6axfLGYAhDUoEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xONCGOyXtEaoZ9AWvLTQtxMGMTG6eRx0BAlxPqVogSA=;
 b=iLKQBSCar1bimppws/noJg+a6wF3t/qoOjbNQjzlRA5w4Etn9F3gAkBwYYi3ru1dEwO1DBl3CwjyxlMihUgeZqdloGZaPeiSnHDnlsXUxk9KM1h77f9VAtd9fE5M1kv3H6sKIei/zCVz4+lrfPsprmL294splZh67ea6AhzdtHdCdS5OqN3JiZ2qm5UEceS8m3+4SdvZ0XcTJCf8U2Cstqznd2tBe+tId2m8grr5G14UgAPl9Qd/Du8ogfUXFkCxtV/ZlJt8WxxicV+oXIAS0HbdKrFt+ZeuqO1ld5A9rg1rA7P3x4bCzMBYzEoqKtfv7SUq85DG2pf+IAbFyA/jIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by PH0PR11MB5030.namprd11.prod.outlook.com (2603:10b6:510:41::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 15:55:09 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 15:55:09 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>
CC: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
 "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>, Karol Kolacinski
 <karol.kolacinski@intel.com>, "Temerkhanov, Sergey"
 <sergey.temerkhanov@intel.com>, Michal Michalik <michal.michalik@intel.com>,
 Simon Horman <horms@kernel.org>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v3] ice: propagate ETH56G deskew
 poll failures
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v3] ice: propagate ETH56G
 deskew poll failures
Thread-Index: AQHdLL8mQ3fW0RMwGE6pSCDwK/ytXbbvafnQ
Date: Mon, 5 Oct 2026 15:55:09 +0000
Message-ID: <LV1PR11MB8790AF560BB04950DCE020DD90962@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260815135700.54202-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260815135700.54202-1-pengpeng@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|PH0PR11MB5030:EE_
x-ms-office365-filtering-correlation-id: 94109ca7-c7f4-4168-73f9-08df22f90880
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|11063799006|10067099003|56012099006|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: JXEd5LOiXpMgCzTn7hj7gUN/Cu+NG5xyh225qdGlCyaq77WQMuY9WEODOcBtF1fUgv8sHliRJ95Toiuo3da7B5pwjntM6YQg7W540UAUSLjQ46l2NzL/oMuKIR4PzhSW4/rF5YuTwT4BjHt3HVP8LE18SYGiSBPLefo7BnJarG9o7iyF2Rtd56kyjSYlfA5pSkq8PjD0SbOvVdaJ22+LWLwhkhmbi9rCL6d8CgxOGJmQ2Bzj5Nl8oGCha/BuGwN4dIHp1sMBV3ct0d2C3eeZA/vq30u+occeFrDn+Z78sI3co7qufv17adXMP74rEmMTiWF5om5rg3u8yc5vedjwO/1D4ooTHQd2jIwkDqxOVPDQZUTxoNjalOsif9P+znjBNi3xZehHshFbcz8ak3sZ2TUXFJLICBBIoY0/aOt4wLzPni/tvUZ7JIdv5BkiAFXSLwhAQeuIZD8xFyn+2eKd20PB/BAayR0TV1PRiYeNDyHAkpr4QnHi0/eyZMNul9780iRUolwNEr2N0v3G+8tdKGkbjbAj3oWOzaYOoP3BQgLMoM/8Rpjgipk2mNtzBskH1bf2Dwi0vy9+lnE2kyU9zVsGgqS4Dfr9AP7RE4yImyYXp9yRgCAFw/52FQO1999nBXHk2tOoiKJwT87wI38k9VtYThZVr1eYdzV277pXvQxPiEyq2R106bxxi4758OhgS0ylLOyTXrcPC016MQFIVXQPWgyiYFTINMq95cyF8V4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LpWESCK8psD+kMVAfjEG6WRsdXPPiPxSd8HGl90rlg9hB1K3VpZVfXMT6uhT?=
 =?us-ascii?Q?9EzRG5Kqhb8n0wGoTGq/7a0RIhZYpClb+NezxDSiCrBLoW2pG2RMJ3qv+Z4L?=
 =?us-ascii?Q?DiIpui6LmcK7Sj/xe1mmJ+pqsEZrlQiy6VJl+UapfGE0C0hLbni6K6lS2Y1s?=
 =?us-ascii?Q?Uy0iVw4VW5brt/srSeIV76Cxiic2dUmEmE/sfms/imvsDPWbqpqu1gbTN8+t?=
 =?us-ascii?Q?Kjt4uoMSYAH7xImnsIVKq4tht3hV3i8TnaKSrzkp0/fuc4/2EIvYs9gXrB02?=
 =?us-ascii?Q?jPoTeDRvKpXFSXURup2HD/zVq2AXd1ljtKeIwDYDhsj/V7vtYH4+bandxpq7?=
 =?us-ascii?Q?chykSw9xtwK4OYPOJZLjW91H+GXagvCsaI1bYCMTggs7CKR+FUuX8BqlNjDf?=
 =?us-ascii?Q?wTKEggyx15+rmpGk8s9KlbaLeHwnJqWoNwEmBr0HXKElHLNflRmc6mElJH95?=
 =?us-ascii?Q?C4N2Vw/NHu2TXf/JtcynMhIKMKU4IXDqZgM8+hII/To3In4ky39c2hXjuDmA?=
 =?us-ascii?Q?PmykszrNOjnuiTHhMtv7h+euXuyBs89OxZcak/Redh1FeJSJ9gkfreZgSfNj?=
 =?us-ascii?Q?LqdeuDJuNitIi0Y0SvtaEVfUn6xVBeygAqUDY1Xve7XNGRe1sEcDapYdLsPb?=
 =?us-ascii?Q?19Y4oXgJzdjHXelREl4PPpTwM3TcGUHKYFYbeL4tWLkrN7LlH9YAEnVAFgER?=
 =?us-ascii?Q?vKteTyI5MvR+fyoncx+kq2ywm1W8/1yZWUTVJEN/5ZhHezXrFh9RhSTgX+RD?=
 =?us-ascii?Q?kjRdO8T2mMSF3Tz4nClBTGw5F27zJrsy7pKqlulJcyPawJzWZQLL+nHjUSCU?=
 =?us-ascii?Q?uuL4if17NO/4picLSPaxPFXlMo0kqiv5qvTlXrYU+TGZq6wqlwyce9ADYAEK?=
 =?us-ascii?Q?sJtJpZJSGH0AHicWs4yNuSWmezPCPF5PnDNDRpq/OtRV+4lJbLJhsly5Oxxm?=
 =?us-ascii?Q?+B76czqWWPznVnVbaEp3/68pvK7pYiS3rC1l4EBJ8LQkaEUvU0a5bop1By6M?=
 =?us-ascii?Q?/paILljdCsXbAUDmvJtMCJBmypaqIIHniy5XzJj4OSQiHpvto3Cuy9JpLG8d?=
 =?us-ascii?Q?Ipu/fUrcKTyHkdSUkPqXrGdVkvpX68mVO2LLNbATPJZOwde8qKpQhc3OXuP6?=
 =?us-ascii?Q?lMsYkNwzMMhi0xmH1CcYaS7skZi/3Az6SeZd0p7ZrIUl7nb0ftrd74ukOzIA?=
 =?us-ascii?Q?JEoF8zDhcGPCGXecARJsP0EIywDHG6GzYdx0o/BOr6VM5pd9/y+ThMOgF0PQ?=
 =?us-ascii?Q?yFfGgaEC23rkI6MFeWXu4dmOawP8nhVpmWZxFrTiHlJkdoTbti1zVlAWk3d6?=
 =?us-ascii?Q?pnxx1QZKxaV+298JkK0cIXCh0OBZad/rAX9UDdEbgG9g3ZZdJ3unvqMGtFuz?=
 =?us-ascii?Q?7ED83aYOfiVjT8veoz0On23TBKVWOVLexPAWJd3h5Bc68JwwZvk1msosNrFM?=
 =?us-ascii?Q?lXM2376dqNF0dpTHCyLWne4TxmLFoNH5PFbr2FkebI5BiLl+b0GkIX59fYcc?=
 =?us-ascii?Q?qKFxg0/50b6UkuKNBY0zjxdoNZzIkrcq9c5xiStsUJZPsWpILFPj6Cn5Kfxk?=
 =?us-ascii?Q?BdF1T64gI6njeXoyvAHyCVJHHAEAcH1oi+EfC3D+YwQJu9o93sk51SA5dDOO?=
 =?us-ascii?Q?+wLNoeSJ9XrfFuKRYzcae7H1ScE8+k6QusOwW2p4Zibmkp8lN80wi51954hH?=
 =?us-ascii?Q?MRDA624BrW3AZpJSup1xvuF2WHTz8alQ6Li9e1i88wsVYnIjWCBNlxwSASVO?=
 =?us-ascii?Q?+7MPfBcX2g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 3TurUdAeXwSi6sGLx9ho29spkg/FcnvvfEDz+B9ij8fa2+kt62exIZxlRlYU8yWo9F88gkThp26e8hiXPGSx8xYJVADpsQc3MkEEU0fI7AeR0vwRI1yfkkPjAnJLMc18m2XvrWeQhSo4jC83zjL+44hyZAidt24HaFqYWC1MpcEHhXiBHHXrwvKpzp+LlGmN1TLQhFNigUT1HD2n8J5DwpYqEPk4wCJQWTxak/xjpW+PRgnNV3eKRHXjGaq6kVG1h7sQEkL7Z4BHtmpdg8PoQrJtB90QIh0j/W3+f7ZUEmr9IPYhaTR9Pbu/HFnmOp+zrfowghqa27B3CDxNa8FCdw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94109ca7-c7f4-4168-73f9-08df22f90880
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 15:55:09.4406 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o+pZ3JiI1VIbRDvcGY/nLSUiVfusRxNhdNtsQa7ts5+v0IEsqHx2+eA9CnIG+2Dks5nF1/keV2YfUUVszeZdvgumrAMXubz7aJm6ct2G5Q4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5030
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
engpeng Hou
> Sent: Saturday, August 15, 2026 6:57 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>
> Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>; Jagielski, Jedrzej <jedrzej.jagi=
elski@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; And=
rew Lunn <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Er=
ic Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo A=
beni <pabeni@redhat.com>; Richard Cochran <richardcochran@gmail.com>; Kelle=
r, Jacob E <jacob.e.keller@intel.com>; Kubalewski, Arkadiusz <arkadiusz.kub=
alewski@intel.com>; Karol Kolacinski <karol.kolacinski@intel.com>; Temerkha=
nov, Sergey <sergey.temerkhanov@intel.com>; Michal Michalik <michal.michali=
k@intel.com>; Simon Horman <horms@kernel.org>; intel-wired-lan@lists.osuosl=
.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-net v3] ice: propagate ETH56G deske=
w poll failures
>=20
> ice_ptp_calc_deskew_eth56g() ignores the return value of read_poll_timeou=
t(). If register reads succeed but the DESKEW valid bit never appears, the =
timeout is treated as success. If a register read fails, the poll condition=
 can also inspect deskew_i before a successful read and continue polling in=
stead of stopping on the hard error. The function then returns an int error=
 through its u32 deskew return type.
>=20
> Return the deskew value through an output parameter. Stop polling when ei=
ther the read fails or the valid bit appears, then propagate the register e=
rror or the poll timeout separately before calculating and applying the des=
kew value.
>=20
> Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products"=
)
>=20
> Assisted-by: Codex:gpt-5
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
> Changes since v2: https://lore.kernel.org/all/20260706144325.91320-1-peng=
peng@iscas.ac.cn/
> - capture and propagate the read_poll_timeout() result
> - stop the poll immediately on a register read error
> - initialize deskew_i before it is used by the poll condition
> - do not carry the v2 Reviewed-by because the poll logic changed
>=20
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 42 ++++++++++++++++++-----=
-----
>  1 file changed, 28 insertions(+), 14 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
