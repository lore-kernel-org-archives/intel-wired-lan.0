Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CC8CA5FF0
	for <intel-wired-lan@archiver.kernel.org>; Mon,  5 Oct 2026 11:07:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 20CA8405DA;
	Mon,  5 Oct 2026 11:07:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id beT9oS-gSD0A; Mon,  5 Oct 2026 11:07:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 52FAA405DC
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791198433;
	b=fip1oKdBliN+f9PhPpvesJpKB2yXg9zUFgw/ZK2cn3j8Rj+Jw+elle/SvSfbkfMnvR15
	 qfFk3KJErpz1zrRFhKp5RjqWhhtq3WubbqTAaa4CA42OdYiBOH71Dn4sgYJHUzwnzNqWI
	 9ch3Xe1g6vroD+2qFpZ9a1xKvgJu0har/e8IHHvArJWTrbs6ffPAAGAIhZykS1y/WgA2z
	 mPBliFbXJkiVUqjOcii2e7R+T+XgzwSaLVk8W93nCrnYIFOf8l/d/LVOsGsmha8QfTct5
	 wwEbXP+7dk+Mjob1IHCaSBElMkrFKSnA0m4ipGQmyW9b7F8vW6mHuF50gnyL1/TB11A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791198433;
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
	 x-ld-processed:x-ms-exchange-senderadcheck:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sRvh8dty0vG3PA/Tm/W+MxtKpLRY6IFRg7NeURKj5xE=;
	b=T+7S0enxnGgLGBk1/ppiu3Jk0CjMYUFGEJdkjyBCQbUbx0MXtIMowR8ZX9k+XnW2WuZr
	 USFJY4qmfMNavtwnLcp/CGvbZJWgBKu/WY0EMiVYORNZIJuNKGKdSxQwnub1m246uq7CL
	 ef6iM+ZaiwOgKHKIsco3Dww5Pup9YcaGLm6lMQcS9IGUwQRP/oWBXH9m8BuzlPrAL8gd9
	 ptFYO8k+smAynI5H6DSZjsukfCw8EjHbij1I1Hzk3jUhtD5XrZxxfZbVRkvZAy3AdIjmL
	 RfMo4AjHVtvztl6qZNyh6ZFHrmZliok0udsSVMbAHsZ8yRraIM8hRjTZ2FyyQDUOOSw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791198433;
	bh=sRvh8dty0vG3PA/Tm/W+MxtKpLRY6IFRg7NeURKj5xE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l0qTh3iAw2ySqYUlTaxDIVDpkag+ln87fyBBNFjFEsL/6QRFB/C2ci2P76uJB2QH5
	 z1FGElsQNAErcqt7KJBvI3XrVbBxQKJn/fvjH+6xVKjyDucH8kQBVTym/3tl11TxR8
	 R19fYtyxbDz2dFchTtwr6oFtiYM9J5wg9aP6sXieSuWPGpCT6aefm1mv1dZUor3yE8
	 Yt1OQDumZB1hRAbCROJ4XDNQx+ftLhg4VNuDoAU3aFUswdOJ2E0ymH2F46KH9oVim9
	 Rm4SyKyLtDD/LJoVjJApmVJZH7GEY50JEoM56xnMKvKQIK4xc+sDImJ/UWsj8UAl0F
	 nxuVh0l5DIpEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52FAA405DC;
	Mon,  5 Oct 2026 11:07:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DB6151A6
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 11:01:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C1647400AA
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 11:01:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QT0obGTJnBUr for <intel-wired-lan@lists.osuosl.org>;
 Mon,  5 Oct 2026 11:01:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8942F4007E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791198069;
 b=loHWY9tMMywi0sFqzi9bjgZXId3di1W+76juEjlYf06uwZtm9JXiWIVnnzinTpshUuo2
 6lZY/b+jTHRkQ3OXvSu2KDYWX8ll44Y7YHRJ1Hglf4GNZZmta9nGyO3yrEtiGjLLzbdka
 GJgT0udgCoB/Q88DjtiiSVHKg2+J04/ESDahBxSUQgy0i9W24G6kiMu5fmxapqYnc8xje
 YrO2nK5RRpcGgySXmGX/gK80IrD6GZn3/9yQQPGza/ChdKfHZ+E6QkaDOwGYrzP3xrjAb
 uuCxtp7kuhh/7v2voknUqGUdq6JynBr4nJ6CgBh0abL5H18KtHuDYUG9N2izbeG+BKA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791198069;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ld-processed:
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
 bh=sRvh8dty0vG3PA/Tm/W+MxtKpLRY6IFRg7NeURKj5xE=;
 b=YnDbbZfpr+LxeMfJP0vXfOaTW1+xO7Qr9o3mc6iC/59ZOhQi5eXFLw2ONS1TbCL0K0ZW
 Q/3KFyicaP8/bDP6BWFcikJwQmrwMqfMKodRMa85+oQkynKxsPAKANegg6Zrw0tqCk8xM
 fn/uYoBGtytxG7/mu05IWpXd8yQ3BSutNLCMAc9vxZAQkGiPK5F2l2XLdYJWkDDFnqxnW
 cpDpDuEBQf/g4RXVYom2mgWj8olwS69G+iae/XQJ1glsuKBVZJNGbVtzC5O1gG9bJrEaL
 Z6uPHKD9JF8xFC0q9F4wbd2E+Zryq8GjgqkNacGdR0lii3RwEE1twHy3f0EOn5b3anA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=D6nftBeN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=D6nftBeN
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8942F4007E
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 11:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791198070; x=1822734070;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=sRvh8dty0vG3PA/Tm/W+MxtKpLRY6IFRg7NeURKj5xE=;
 b=D6nftBeN1/xOPqMiruAU/kk1VYZmLmVsrR7Yq42ofrOVBJ3+gMESSs8M
 ocQ3zPJd1dUowGgoA1o1P9moSV3WaPj4iBcLFzfLQMiqibAm3OX3Fnh+M
 EF/pZGdULqVAgs7NTbDLtlKNSOucUXycHChTUxPARSceIn8r8NehULrKU
 XjihRvlz1mSy6hv6k3iiGV0Hdvb+dnPIcZ7rlPWlRqwNZ9rx42tQobvbb
 kXwZql0RKgmaOdfX3itbwJ8JV1tmVt5vi2KbDj+mooeKn8Jb8tuq7BkAM
 LmmWHv9WvlsW4UgTiT9aphsoCEIesT9oLmohqQeAUNBJvUHh2r5HD4t+B A==;
X-CSE-ConnectionGUID: MbsR05ALQmWStcR6X2a80Q==
X-CSE-MsgGUID: VKuwQhy3Q9GQIqI6cAxakA==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="90814386"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="90814386"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 04:01:08 -0700
X-CSE-ConnectionGUID: ekkPawy9R+O3jHlqUWs5sg==
X-CSE-MsgGUID: 4InV+SOMRWSV1O12Gzjc1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="275909564"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 04:01:08 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 04:01:07 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 04:01:07 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.25) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 04:01:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgjEPyfMjgFzT8Z+q2EAIq66yQiSj9xsqsxYVnXjhWD1gadbbGB5w9ZoyhTNbkps2zqA1NDe5r47LLvFwd0VUKoZf3Qc4EhdOT4GYKd3Jtli5ecBtVoiNiHxsEHOdUoAjcw36vpG96uYAn6SljJs0d48GAqHFjRNrYjf4DovzwuYAPi11M6+u0ic39McW4vTkJKx/NLdO3r/F72hcbYeJ/2kpxlADnXK3AVg7rDZzpYt5yWjQHr1RT+S3AMQ0ao6fdxu0emjTJFsyYf4QA83XYVUykxXy7Xuk9pdtTA5lrhRccvXIxnfSHXQ9hJLezPkGQtXWAQ/ynz25xVlwCVcRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRvh8dty0vG3PA/Tm/W+MxtKpLRY6IFRg7NeURKj5xE=;
 b=KiE/cq1HX30Z3iH5ShNBa8jv9ReVaa5P0xb9QbzDJ1fZbVVwq0IVu4/K4PEgU28mC0cey1gWEgARedkjgp+wLIP05hnYKJjY9s9dfLxuutyxhH+g/uZOHO3JSLBe2/P87VqYrFOw+Ddq1jna7sGMD+9UZQcHaZBYMGSd6XPJlh2WycaEQhZefzps/7m0bvy+VbiUB1D00gutTQy9nvcfls2ylkEeuqyl/arUGmns2gmpOQIaxPBk4bNU9ODgXbFgAkvd3TLvKWWoICq5CEeoAsD5U3UsbOplqnIOwxhD0dLXhcNyEMHl6PdzjnwsU0zqTA/sS028r+Je0yaZmwgzyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS7PR11MB7784.namprd11.prod.outlook.com (2603:10b6:8:e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Mon, 5 Oct
 2026 11:01:04 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 11:01:02 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>, "Korba, Przemyslaw" <przemyslaw.korba@intel.com>, 
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Nitka, Grzegorz"
 <grzegorz.nitka@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Oros, Petr"
 <poros@redhat.com>, "Machnikowski, Maciej" <maciej.machnikowski@intel.com>
Subject: RE: [PATCH iwl-net v3 12/15] ice: keep Tx timestamp slots tracked
 until completion or timeout
Thread-Topic: [PATCH iwl-net v3 12/15] ice: keep Tx timestamp slots tracked
 until completion or timeout
Thread-Index: AQHdTUnGMIch6ciGNUGZmmytBbU0x7bu1mmw
Date: Mon, 5 Oct 2026 11:01:02 +0000
Message-ID: <IA3PR11MB89868054C7CD122B16060F46E5962@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
 <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-12-6532598e8da8@intel.com>
In-Reply-To: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-12-6532598e8da8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS7PR11MB7784:EE_
x-ms-office365-filtering-correlation-id: 8437106c-fc02-4f8f-415b-08df22cff1d9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|38070700021|4143699003|6133799003|10067099003|11063799006|56012099006|921020;
x-microsoft-antispam-message-info: 0xADYJT4y/YsG+9YRhcUppVNMHrDMTyXqJm8fRHeQHo14M6Ac9NoGx+k9WnIZ08AFl/k7i83Ymct80Ez5tAG2P+AtAjVfs3z4riYbSfw6L+Xp6o35WdQfCgrbtscWmrj9IyoYrlNVaPX0/Od3hRGSO/NSDGwegrt+RZNPS2NGpnX9IaOd6U5ZmEh/NSj5xQKru1oZzRbPBgFA9iz5LHJzxKVODviibLorDZmALfuQqDmV63jsD4DtEheZ4tszf4zGemuhI2/T9myZ48PaE5Ut0VwWAvcv9o1Oy0K0kezu8f+jAutp8NBoGBKlFrdyP7DBXlMlHCnlbLbaq4DHWbT2ExZ6tMJJh5nPFt7GImTNVPjzpK/v0KLd7mY0/XBdVag9RBg1iHHZMdo1P6b/kyvo0mkAsW412PmE/++Z+fL0I944+90UfYZ1Waowd99AajwAaUiai4qqaHmepge+iVflvGam2Nd4h3JIn/LiX1tSFVNLUQjwuEjL3qyxu2NPEuql+IgGz2XJy8vAvJL4WDukrvC+1GDYT/VBKMoYAHk4vBQhbHpOJ1QXetEE1QlPjybLG5s/yNqdti9nB6/LkP+PIalv6lzU1LbRc0eJ/UQFtimMw9Q/4cWwACK6pKK1vR04cr2mdX1z/MJboN/AsKB+SX52a/3BvRp2uIaQ6BVnrG9AM8I1C84ubRd9vR0yVZlPMrNX4voSPrBeXF1qkP6E0SwM64hQLTfB1Iaq6gJq8RI4wWtX6K2TBRPg4VbKhoG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(38070700021)(4143699003)(6133799003)(10067099003)(11063799006)(56012099006)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WW13WTBtM2Z2V2pNR29oVks4T3JwMTVUczc4U2QwSzdpL21hWkNXL0FIRUpH?=
 =?utf-8?B?RW1MbHo1TGw0RmlWK1BocVZNMGFMVGZETFhJZUJiRkp0ME5KcVQrUDIyWW9l?=
 =?utf-8?B?YVpRamw4bFk0RHhVNm84VWR4Zy96TDdJdjRKTWlHdGxLd0c5SmQybVkrNy8x?=
 =?utf-8?B?Qjl6bG1jQUtOQ0RpWlN0ZHNsRlptV2JoV21NbmVOcnlRTmQ5a0UrVktDSE5r?=
 =?utf-8?B?cFBvcFovNzRFZHpuKy9FMFlqTElFeHVMRHdoVk8zcE5seElTTGxuMW1OM3RX?=
 =?utf-8?B?dmRZek8yUVVOTi9ZRUZKWVU3Mnd4MTFrZHdJdHRybnBURHRHMEZWUGdDWVN3?=
 =?utf-8?B?NER3NnVFTXYrOU9hdG84ZEdoWFRJVXRuYzBlV1ptYUg2SXFLYWR2N1dKdkox?=
 =?utf-8?B?RnBsNFVTTVpRRGlQWGhyUFRpZVZaME5HVVFVWUpvT3ZoUFJIcDMvMUJON1l6?=
 =?utf-8?B?S2xsWkwyUTMxOXZLckZVeDFEVFpZanA3SU1uRkkwUnJZYkJqdjdqQWFTeHBp?=
 =?utf-8?B?VHR3b1d1QWpYTEZKQWdsMzkzT1VZZ2F5ZlhZaUJrRGljeDhHZ2VpSjVZc3Ru?=
 =?utf-8?B?cEFsUE5FTlFPSkdXWCtkeFVhbktFcmY5aDlWSFZQOXdtOE0xaDFtalZ0TWdO?=
 =?utf-8?B?QUg0RDFmT1F2cFd2ZHBtbXBOMWx4MGU1RXlsRkMvbVdRLzdYRmRWbm96NktD?=
 =?utf-8?B?c2V2U1ZUOUFMTlQ4cVRkVklLY3Z2dXR5OTlEaytsdjBrRjFITnNPSGJsektR?=
 =?utf-8?B?blVjb3hpdXBCY2NhVWJZME5sWExGM0tHRWNnb2NSOTJNODFsUjNDRmxqTnMr?=
 =?utf-8?B?cGVxY01HeDYvQmp5WCtacWp1RWZJd1p1YjlEV1RySjFTL3Rxc1d3WHI0amdL?=
 =?utf-8?B?bXZRZWlGek9Id2x0UFpPdEVtKzRMYktKUHEwU1ZoZEFzRWVlN1o2bWpGcmVR?=
 =?utf-8?B?QzFod3Y2OG1MUkNUa1ZLZEVqNVBSZCtOWjhLT0Fwa1pucDRyN05iYXpJYkc5?=
 =?utf-8?B?emVpN2Nxdm9VdGdFazBvaU1hSmprZXY4NjVaL2I5eTFybUh3SFV1bndHTkRK?=
 =?utf-8?B?VGMvQkNUdC9hallGRndpb1RjcC9VS3diWjhKSGhYR2tmQS85ZGlZMUFHQzdk?=
 =?utf-8?B?YmNWN3B2TWtITnRiWGZVQUt3Mi96cVZRbGFHYWpaMmNiL3ArZUpEZmxjdyt1?=
 =?utf-8?B?NXdNRVpzbUV6VHlJcWNtKzFVd2c4eGVyUVJMWmdybUlpb09PMytYNlR0aXg0?=
 =?utf-8?B?Q0h1aVl2NEJjYlVhMnhLODhRaGJ4b1BJKzFRUjhZNkxGd1NXdDhmQzRLOGdT?=
 =?utf-8?B?OFo1eWRNODMyOGtGWE8zVDRUZzJBUFg3aWFhUFo3VkJUWFBlWWp2ZnJ4SGla?=
 =?utf-8?B?NnRZaWpLelJhRU9NbFU4dkhUYnd0dnF3UUJScm43NHFFR3VDakRoTXFlSlRI?=
 =?utf-8?B?Slhpc2l2ajdTVE5STitqR0xvTytNaFVmTENZSFY3R0x6bURoOERjVUxtVUZD?=
 =?utf-8?B?eUh6TE96Q0w5MnlDOW5qVHIvalV5NEt3MjVXazFEZ2hLY0RQdnB5YVNQdUxQ?=
 =?utf-8?B?T1E4a0dTdWcxQXJLczhweUVjM3poUHBOZnRnMSszeS9kUVRTcWh6dTEzdmZx?=
 =?utf-8?B?TUFabUxBM043Z053VVhDa1JYMFl4MUhZcDMycXlMMldKb1hqTndhVzI5VTln?=
 =?utf-8?B?YmpNRDAyWmJHWlFzdVE3bHlSckk3eXlpcjU3Tnk1aWtIeS9UR2VFdkI3c2lK?=
 =?utf-8?B?SUs4MENISHZ5MzJLUVUzOXZZNEk4RC9QMzdLV1JkZG9XQzNzRjlVWWdLTjZk?=
 =?utf-8?B?aW15Ykt3YmQwN2hmVmw4TW9RcXZlTEdrYXR4RmpTbnhQL3pGamdMMWM3NFJY?=
 =?utf-8?B?VkRGbmw3alE5L0tEUFVzRXBWd2tocTlVbEZ1anQycFBDcjVJL2htSVE5eG8x?=
 =?utf-8?B?TzFSNjVmZDQrdC9HR2lKd3NzZHdlb0hTd0gzTGxnMVptY1hNc1BnMFZrZlhp?=
 =?utf-8?B?ZmFPdnVKMkJudk56OWFGMEhnTkwvQXZRZUNkRFRTTG5hYlVrSWtJVThJaWVl?=
 =?utf-8?B?VVl5S3Jla1Q5UVBXVk4rcGJYeEVNZkFPbStwNmZwUGRjWkNabFpQQUFmUXA4?=
 =?utf-8?B?elE2VGN6N0YzSXZ5VHdCcFpHT1lJV0owT2RZK0l2Y0JhNzc0WUUwVDdSVnl0?=
 =?utf-8?B?TnRtaUpPV0VrZytoUWludmF1K3diVkpGS2x3MFg1b1pqaTRZME1lMHl1Tzl0?=
 =?utf-8?B?Tkg2SXVyRDJIaWMzL2JRcGVCS0NXVndHSFJCRFdESVcwcjRNLzlsSldzV3Rz?=
 =?utf-8?B?Z1JXK1Q5UkRMaG5rc3VKdWNxYUVzR2FSRkI5bzl3dXpNc3FBa2VrRkJWNUQ1?=
 =?utf-8?Q?4P555M5k6FIZ2oLc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: be6AhAnN7Wc3no049+7Oe2YvI26vy4DApxU4eAWbZ4LoFRX8IyafoF7VGWKqPExnUVXl49zvYPHtrdSPADUr77kQGeTcaUaHiJTueQEpcV2MTvwI7D2D7C3sjqS1fqbWDU5SGE2P3mcf4uQb8x5RwlTjjgeclhmRThzSZSHxUBKCBV11RkIKn3RKcJnjM/EUpKDZptNaAXImabH3R4UnwvH5bargWWcb+H1Gxvr+VqWCNje3djVLqSXr0PRH7YeW3nCSEDUi9dRSxlmYxPw8ox07/5xRCAecpOhqrHgoUuAla4Ut0Cbd95W3/nIH+dbtYGu4+yXy/y96sKStXq8WHQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8437106c-fc02-4f8f-415b-08df22cff1d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 11:01:02.0980 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tBFfcvuaHRub+p94eYTCwDnNjLtW1HkHW/U88IpnuXL766FKnc4CqNQNNsae8MUOllG0ewTHCqZrC8YjcraYCFNWNBopDvURN2ugcYIdxrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7784
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFjb2IgS2VsbGVyIDxq
YWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBTZXB0ZW1iZXIgMjYs
IDIwMjYgMTo1NyBBTQ0KPiBUbzogSW50ZWwgV2lyZWQgTEFOIDxpbnRlbC13aXJlZC1sYW5AbGlz
dHMub3N1b3NsLm9yZz47IE1hY2huaWtvd3NraSwNCj4gTWFjaWVqIDxtYWNpZWoubWFjaG5pa293
c2tpQGludGVsLmNvbT47IEtlbGxlciwgSmFjb2IgRQ0KPiA8amFjb2IuZS5rZWxsZXJAaW50ZWwu
Y29tPjsgS29yYmEsIFByemVteXNsYXcNCj4gPHByemVteXNsYXcua29yYmFAaW50ZWwuY29tPjsg
Tmd1eWVuLCBBbnRob255IEwNCj4gPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgTml0a2Es
IEdyemVnb3J6DQo+IDxncnplZ29yei5uaXRrYUBpbnRlbC5jb20+OyBLdWJhbGV3c2tpLCBBcmth
ZGl1c3oNCj4gPGFya2FkaXVzei5rdWJhbGV3c2tpQGludGVsLmNvbT4NCj4gQ2M6IEtlbGxlciwg
SmFjb2IgRSA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPjsgT3JvcywgUGV0cg0KPiA8cG9yb3NA
cmVkaGF0LmNvbT47IE1hY2huaWtvd3NraSwgTWFjaWVqDQo+IDxtYWNpZWoubWFjaG5pa293c2tp
QGludGVsLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIGl3bC1uZXQgdjMgMTIvMTVdIGljZToga2Vl
cCBUeCB0aW1lc3RhbXAgc2xvdHMgdHJhY2tlZA0KPiB1bnRpbCBjb21wbGV0aW9uIG9yIHRpbWVv
dXQNCj4gDQo+IEZyb206IFBldHIgT3JvcyA8cG9yb3NAcmVkaGF0LmNvbT4NCj4gDQo+IFdoZW4g
dGhlIGxpbmsgZ29lcyBkb3duIHRoZSBwcm9jZXNzaW5nIGxvb3AgZHJvcHMgZXZlcnkgb3V0c3Rh
bmRpbmcNCj4gcmVxdWVzdCwgYW5kIGEgcmVxdWVzdCB3aG9zZSB0aW1lc3RhbXAgaXMgbm90IHJl
YWR5IHlldCBpcyBmcmVlZA0KPiB3aXRob3V0IHJlYWRpbmcgdGhlIFBIWSBzbG90LiBUaGUgaGFy
ZHdhcmUgY29tcGxldGVzIHRoZSBjYXB0dXJlIGENCj4gbW9tZW50IGxhdGVyLCB0aGUgb3JwaGFu
ZWQgcmVhZHkgYml0IGJsb2NrcyB0aGUgcG9ydCBpbnRlcnJ1cHQgdW50aWwNCj4gdGhlIG5leHQg
bGluay11cCBzd2VlcCwgYW5kIHRoZSBmcmVlZCBpbmRleCBjYW4gbWVhbndoaWxlIGJlIHJldXNl
ZCBieQ0KPiBhIG5ldyByZXF1ZXN0IHdob3NlIHNsb3QgdGhlIGhhcmR3YXJlIHRoZW4gb3Zlcndy
aXRlcy4gQ2FwdHVyZWQgb24gYQ0KPiByZXByb2R1Y2VyIGFzIHJlYWR5IGJpdHMgd2l0aCBubyBp
bl91c2Ugb3duZXIgcmlnaHQgYWZ0ZXIgYSBsaW5rDQo+IGJvdW5jZS4NCj4gDQo+IFN0b3AgZHJv
cHBpbmcgb24gbGluayBkb3duLiBNYXJrIHRoZSBvdXRzdGFuZGluZyByZXF1ZXN0cyBzdGFsZSBz
bw0KPiB0aGVpciBjb21wbGV0aW9ucyBhcmUgcmVhZCBhbmQgZGlzY2FyZGVkLCByZWplY3QgbmV3
IHJlcXVlc3RzIHdoaWxlDQo+IHRoZSBsaW5rIGlzIGRvd24sIGFuZCBmcmVlIGEgbm90IHlldCBy
ZWFkeSBzbG90IG9ubHkgYWZ0ZXIgdGhlIHR3bw0KPiBzZWNvbmQgdGltZW91dC4gVGhpcyB3YXkg
YW4gaW5kZXggaXMgbmV2ZXIgcmV1c2VkIHdoaWxlIHRoZSBoYXJkd2FyZQ0KPiBjYW4gc3RpbGwg
d3JpdGUgaXQgYW5kIG5ldmVyIGxlZnQgdW50cmFja2VkIHdoaWxlIGEgY29tcGxldGlvbiBjYW4N
Cj4gc3RpbGwgYXJyaXZlLg0KPiANCj4gU2luY2Ugd2UncmUgYWRkaW5nIGEgbmV3IGNhbGwgdG8g
aWNlX3B0cF9tYXJrX3R4X3RyYWNrZXIsIG5vdGljZSB0aGF0DQo+IHRoZSBmdW5jdGlvbiBwcmV2
aW91c2x5IGRpZCBub3QgY2hlY2sgdGhlIHRyYWNrZXIgaW5pdGlhbGl6YXRpb24NCj4gc3RhdGUu
IEZpeCB0aGlzIGJ5IG9ubHkgYWNjZXNzaW5nIHRoZSBiaXRtYXBzIGlmIHRoZSBpbml0IGZpZWxk
IGlzDQo+IHNldC4NCj4gDQo+IFRvIGF2b2lkIGNvbnRpbnVvdXNseSByZS10cmlnZ2VyaW5nIHRo
ZSBJUlEgYXQgdGhlIGVuZCBvZiBhIHByb2Nlc3NpbmcNCj4gbG9vcCB3aGVuIHdlIGhhdmUgYSBz
dGFsZSBwYWNrZXQgdGhhdCBpcyBub3QgdGltZXN0YW1wZWQsIG1vZGlmeQ0KPiBpY2VfcHRwX3R4
X3RzdGFtcHNfcGVuZGluZygpIHRvIGlnbm9yZSBzdGFsZSB0aW1lc3RhbXBzIHdoZW4gY2hlY2tp
bmcNCj4gZm9yIHdoZXRoZXIgdG8gcmUtYXJtIHRoZSBJUlEgZnJvbSB0aGUgbWlzY2VsbGFuZW91
cyB0aHJlYWQgZnVuY3Rpb24uDQo+IEluc3RlYWQsIG9ubHkgY291bnQgc3RhbGUgcGFja2V0cyBh
cyBwYXJ0IG9mIHRoZSBjaGVjayBpbiB0aGUNCj4gYXV4aWxpYXJ5IHdvcmsgdGhyZWFkLg0KPiBU
aGlzIHdheSB3ZSBkbyBub3Qga2VlcCBzcGFtbWluZyB0aGUgSVJRIHdoZW4gdGhlIHRpbWVzdGFt
cCB3b24ndCBiZQ0KPiByZXBvcnRlZCBhbnl3YXlzLg0KPiANCj4gVG8gZW5zdXJlIHRoYXQgZm9y
d2FyZCBwcm9ncmVzcyBpcyBtYWRlIG9uIGNsZWFyaW5nIHN0YWxlIHRpbWVzdGFtcHMsDQo+IGZp
eCB0aGUgY2hlY2sgZm9yIGljZV9wdHBfbWF5YmVfdHJpZ2dlcl90eF9pbnRlcnJ1cHQgdG8gcHJv
cGVybHkgYXBwbHkNCj4gZm9yIGRldmljZXMgdGhhdCBtYW5hZ2UgdGhlaXIgb3duIGludGVycnVw
dCwgaW5zdGVhZCBvZiBvbmx5IGNoZWNraW5nDQo+IG9uIHRoZSBjbG9jayBvd25lci4gSW4gdGhl
IGNhc2Ugb2YgYSB0aW1lc3RhbXAgd2hpY2ggbmV2ZXIgY29tcGxldGVzLA0KPiB0aGlzIGRvZXMg
cmVzdWx0IGluIG9uZSBleHRyYSBJUlEgZXZlcnkgNTAwIG1zZWMgdW50aWwgdGhlIHRpbWVvdXQu
IEluDQo+IHNvbWUgc2Vuc2UgdGhpcyBpcyBleHRyYSB3b3JrLCBidXQgd2UgbmVlZCB0byByZWNo
ZWNrIHRvIGVuc3VyZSB0aGF0DQo+IHRpbWVzdGFtcCBzbG90cyBkbyBub3QgcmVtYWluIGxvY2tl
ZCBmb3JldmVyLCBhbmQgdGhlIHNvZnR3YXJlIGNhbid0DQo+IHJlbGlhYmx5IGtub3cgd2hldGhl
ciBhIGdpdmVuIGluZGV4IHdpbGwgb3Igd29uJ3QgY29tcGxldGUuDQo+IA0KPiBOb3RlIHRoYXQg
RTgxMCBkb2VzIG5vdCBoYXZlIHRoZSByZWFkeSBiaXRtYXAgaW4gaXRzIGhhcmR3YXJlLiBJdCBp
cw0KPiBjdXJyZW50bHkgZXhjbHVkZWQgZnJvbSB0aGUgaWNlX3B0cF9tYXliZV90cmlnZ2VyX3R4
X2ludGVycnVwdCgpIGJ5IGENCj4gY2hlY2sgYWdhaW5zdCB0aGUgaGFzX3JlYWR5X2JpdG1hcCBm
aWVsZC4gVGhpcyBjb3VsZCBsZWFkIHRvIGFuDQo+IGludGVycnVwdCBzdGFsbCBpZiBldmVyeSBz
aW5nbGUgVHggdGltZXN0YW1wIGluZGV4IHNsb3QgYmVjb21lcyBzdGFsZS4NCj4gSG93ZXZlciwg
anVzdCByZW1vdmluZyB0aGUgY2hlY2sgYWdhaW5zdCBoYXNfcmVhZHlfYml0bWFwIHdvdWxkIGJl
DQo+IHByb2JsZW1hdGljIGZvciB0aGUgbG93IGxhdGVuY3kgcGF0aCB3aGljaCBjdXJyZW50bHkg
aXMgbm90IHByb3RlY3RlZA0KPiBhZ2FpbnN0IGFub3RoZXIgSVJRIGhhcHBlbmluZyB3aGlsZSBh
IHJlcXVlc3QgaXMgb3V0c3RhbmRpbmcuIFRoYXQgaXMNCj4gYSBwcmUtZXhpc3RpbmcgaXNzdWUs
IGJ1dCB3ZSBzaG91bGQgYXZvaWQgbWFraW5nIGl0IHdvcnNlIHVudGlsIHRoZQ0KPiBwYXRoIGNh
biBiZSBhZGRyZXNzZWQgYnkgYW5vdGhlciBmaXguIFRoZSBsb3cgbGF0ZW5jeSBwYXRoIGFsc28N
Cj4gY29tcGxldGVseSBieXBhc3NlcyB0aGUNCj4gaWNlX3B0cF9wcm9jZXNzX3R4X3RzdGFtcCgp
IGZsb3cuIEZvciBub3csIHNraXAgdGhlDQo+IGljZV9wdHBfbWF5YmVfdHJpZ2dlcl90eF9pbnRl
cnJ1cHQoKSB3aGVuIHRzX2xsX2ludF9yZWFkIGlzIHNldCBhbmQNCj4gdGhlIGxvdyBsYXRlbmN5
IHBhdGggaXMgaW4gdXNlLiBUaGUgcGF0aCBzdGlsbCBoYXMgcHJlZXhpc3RpbmcgaXNzdWVzDQo+
IGJ1dCB0aGlzIGF2b2lkcyBtYWtpbmcgaXQgd29yc2UuDQo+IA0KPiBUaGlzIGVmZmVjdGl2ZWx5
IHJldmVydHMgY29tbWl0IGZjYzJjZWYzN2ZlZCAoImljZS9wdHA6IGZpeCB0aGUgUFRQDQo+IHdv
cmtlciByZXRyeWluZyBpbmRlZmluaXRlbHkgaWYgdGhlIGxpbmsgd2VudCBkb3duIiksIHdoaWNo
IHRyaWVkIHRvDQo+IHJlbGVhc2UgYW4gaW5kZXggYmVmb3JlIHRoaXMgMiBzZWNvbmQgd2FpdCBw
ZXJpb2QuDQo+IA0KPiBGaXhlczogZmNjMmNlZjM3ZmVkICgiaWNlL3B0cDogZml4IHRoZSBQVFAg
d29ya2VyIHJldHJ5aW5nDQo+IGluZGVmaW5pdGVseSBpZiB0aGUgbGluayB3ZW50IGRvd24iKQ0K
PiBTdWdnZXN0ZWQtYnk6IEphY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBQZXRyIE9yb3MgPHBvcm9zQHJlZGhhdC5jb20+DQo+IFJldmlld2Vk
LWJ5OiBNYWNpZWsgTWFjaG5pa293c2tpIDxtYWNpZWoubWFjaG5pa293c2tpQGludGVsLmNvbT4N
Cj4gU2lnbmVkLW9mZi1ieTogSmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+
DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9wdHAuaCAgfCAg
OCArKystLQ0KPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX21haW4uYyB8ICAy
ICstDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwLmMgIHwgNTcgKysr
KysrKysrKysrKysrKy0tLS0tLS0NCj4gLS0tLS0tLS0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgMzcg
aW5zZXJ0aW9ucygrKSwgMzAgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9wdHAuaA0KPiBiL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2ludGVsL2ljZS9pY2VfcHRwLmgNCj4gaW5kZXggMDI5ZWU0NjEyZDc2Li43ODEwZmVmYzU0
NmUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRw
LmgNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9wdHAuaA0KPiBA
QCAtMTMyLDYgKzEzMiw5IEBAIHN0cnVjdCBpY2VfcHRwX3R4IHsNCj4gICNkZWZpbmUgSU5ERVhf
UEVSX1BPUlRfRTgyWAkJMTYNCj4gICNkZWZpbmUgSU5ERVhfUEVSX1BPUlQJCQk2NA0KPiANCg0K
Li4uDQoNCj4gPmxpbmtfdXApOw0KPiAgfQ0KPiANCj4gIC8qKg0KPiBAQCAtNTU0LDcgKzU1Nyw5
IEBAIHZvaWQgaWNlX3B0cF9jb21wbGV0ZV90eF9zaW5nbGVfdHN0YW1wKHN0cnVjdA0KPiBpY2Vf
cHRwX3R4ICp0eCkNCj4gICAqIGV4dHJlbWVseSB1bmxpa2VseSB0aGF0IGEgcGFja2V0IHdpbGwg
ZXZlciB0YWtlIHRoaXMgbG9uZyB0bw0KPiB0aW1lc3RhbXAuIElmDQo+ICAgKiB3ZSBkZXRlY3Qg
YSBUeCB0aW1lc3RhbXAgcmVxdWVzdCB0aGF0IGhhcyB3YWl0ZWQgZm9yIHRoaXMgbG9uZyB3ZQ0K
PiBhc3N1bWUNCj4gICAqIHRoZSBwYWNrZXQgd2lsbCBuZXZlciBiZSBzZW50IGJ5IGhhcmR3YXJl
IGFuZCBkaXNjYXJkIGl0IHdpdGhvdXQNCj4gcmVhZGluZw0KPiAtICogdGhlIHRpbWVzdGFtcCBy
ZWdpc3Rlci4NCj4gKyAqIHRoZSB0aW1lc3RhbXAgcmVnaXN0ZXIuIE5vdGUgdGhhdCBpbiB0aGUg
dW51c3VhbCBjYXNlIHdoZXJlIHRoZQ0KPiBQSFkNCj4gKyAqIGNvbnRpbnVvdXNseSBmYWlscyB0
byBjbGVhciB0aGUgcmVhZHkgYml0bWFwIGluZGV4LCB0aGUgc2xvdCBtYXkNCj4gKyByZW1haW5l
ZA0KTml0OiAnIG1heSByZW1haW5lZCcgLT4gJ21heSByZW1haW4gbG9ja2VkJw0KDQoNClJldmll
d2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNv
bT4NCg0KDQo+ICsgKiBsb2NrZWQgZm9yIG1vcmUgdGhhbiB0d28gc2Vjb25kcy4NCj4gICAqLw0K
PiAgc3RhdGljIHZvaWQgaWNlX3B0cF9wcm9jZXNzX3R4X3RzdGFtcChzdHJ1Y3QgaWNlX3B0cF90
eCAqdHgpICB7IEBAIC0NCj4gNTY0LDcgKzU2OSw2IEBAIHN0YXRpYyB2b2lkIGljZV9wdHBfcHJv
Y2Vzc190eF90c3RhbXAoc3RydWN0DQo+IGljZV9wdHBfdHggKnR4KQ0KPiAgCXN0cnVjdCBpY2Vf
cGYgKnBmOw0KPiAgCXN0cnVjdCBpY2VfaHcgKmh3Ow0KPiAgCXU2NCB0c3RhbXBfcmVhZHk7DQo+
IC0JYm9vbCBsaW5rX3VwOw0KPiAgCWludCBlcnI7DQo+ICAJdTggaWR4Ow0KPiANCj4gQEAgLTU4
MiwxNCArNTg2LDExIEBAIHN0YXRpYyB2b2lkIGljZV9wdHBfcHJvY2Vzc190eF90c3RhbXAoc3Ry
dWN0DQo+IGljZV9wdHBfdHggKnR4KQ0KPiAgCQkJcmV0dXJuOw0KPiAgCX0NCj4gDQoNCg0KLi4u
DQoNCj4gIAkJZGV2X2RiZyhkZXYsICJQVFAgcGVyaW9kaWMgdGFzayBkZXRlY3RlZCB3YWl0aW5n
DQo+IHRpbWVzdGFtcHMuIFRyaWdnZXJpbmcgVHggdGltZXN0YW1wIGludGVycnVwdCBub3cuXG4i
KTsNCj4gDQo+ICAJCXdyMzIoaHcsIFBGSU5UX09JQ1IsIFBGSU5UX09JQ1JfVFNZTl9UWF9NKTsN
Cj4gDQo+IC0tDQo+IDIuNTYuMC5yYzAuMzk1LmdkMWYzNTI0ZTE1ZGMNCg0K
