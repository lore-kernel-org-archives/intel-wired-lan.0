Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10BBCA5FA1
	for <intel-wired-lan@archiver.kernel.org>; Tue, 29 Sep 2026 07:08:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9016C60606;
	Tue, 29 Sep 2026 07:08:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M_1zqVdBjjUA; Tue, 29 Sep 2026 07:08:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C9AC3606F5
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790665693;
	b=gpiHG7DIqRT3Y2rXy2K0UBjQQECMIk7Q1mnmFOgEllc/ufwnaa0JCcf3cApvTNRBEo+N
	 XK9ukedamnoYhBgwafAEFc4sJPOl/s5X8ZLzv7/Vh0wa7qSxz4Kqbnizttj5dJsqZJr39
	 gXpN3zeut6B+nTS16qhL/NvwKM7NNvUf0hGdHZAw/FQctIcv1CsonMifzkh2nrkrnmkTd
	 uDuSBG/9SkMty+B+BHdROzrPOKyv0eKvUboxximJDtQqZGq8l2ognqi047dk+bC3g1LaJ
	 /9U0bfZScY/Fu9J/+c4ALpKHlcjark9VI+CC7fhDZ0YTFYoQNKmA0/fP7TKLgayZ+dw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790665693;
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
	bh=0bL0RX9E1XrlsSgQFrKJ3BXF6DMxdV7P/hZ5dT83+2M=;
	b=XIkE2qKd2RFzRllCBeJZte2W/qVvgCV6F7lP4MGfFVJgIs3C8bvISKU7mDnE8suGa7vV
	 DLMyUcwHZ1/jYv6fQfbQbN99ssN0yu4KODcFzT3oto4bbe+DAC5LlVo6eIBEmEed019Te
	 aq5hEFV3UpCPfPkhnCUoIDnPCE4MTYSJJo/gtgXsg4g4yki4oIc5pNYuPS6qlqUpan0WM
	 ClcKuEsjZ2FmwLyXx2eO+sBl1GC1PEvxO5D+wwp55dpmhGgyowERYE4fkF5jDQ0X28XrH
	 wbYao2XVLVBKo7jPhcMHidURdo+zniUMapgceYUzw17vF9iGxzRvt4ip08wycU7LDLA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790665693;
	bh=0bL0RX9E1XrlsSgQFrKJ3BXF6DMxdV7P/hZ5dT83+2M=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bQ4f0k5QJ/Y8w2fQrGwHYN/GpWsYZ3ZFHHSJG0qHjzy68t9HVMjoEoAuqO1J3d2KT
	 AEEVohonjcMX94jww87KF0QXXRpwCNbAcps8JF7mQK8ceIKe+513E3FIoichTENvrn
	 MJGCCfKiPDt4hIZp6zVnCZkOQ9k7y75lyMqSEkNP4LE4MsYYfh4I3A5JrVgVws+pNa
	 yFN6TUQpgmL+jYCvMA7R96Wk2cMZS41DAOjjfviis92jgMb8pVfwH3+xiGTodswab5
	 x26GKX8+x+VQMIcxBv2vLBX7x4wnSrWZeMq0BBdMqtaOhCSgmO5Ueeuta3G2CXT3+R
	 9RXthkFvYlWyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9AC3606F5;
	Tue, 29 Sep 2026 07:08:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C839B417
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 07:08:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AD8E580984
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 07:08:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gHbo_NgXX_7w for <intel-wired-lan@lists.osuosl.org>;
 Tue, 29 Sep 2026 07:08:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org ACAED80981
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.13
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790665691;
 b=MyNLN8IwImNHfZG9ij/p7URTO6FjNF84TwZ3CfGqVDcVZgI72/yAr1TZlIDnAPSOPw7+
 9cmetleKK+MRxwLcF8+7bkS/TZ64Hm8PEr/SZDBBemTHx3Xu1BPmDimKNSCUkGRBRzluX
 YoEfTZbw1uAGQlj1fAN3HfFsdoI9BerIOaPTEHYvNkFRxqn8Z/7aC18Bxpzs4S2yaAl9B
 YDviz+q97crdchuNRATaWH51yfcGN6iLWpEs7R9AvguaR0bzTNaKu8uLbiIKhdzQu1Y+4
 SlRlYYHrMt0QM0PstltmoPnBMDg1I8ZK9PHaoDPtBsYQdVGpH67lFsv+/n6bimkj6Tw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790665691;
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
 bh=0bL0RX9E1XrlsSgQFrKJ3BXF6DMxdV7P/hZ5dT83+2M=;
 b=JXh+c07z2mI0ReddezM+0QjwFAVyS/BUCrobcmk6EPiT/ubpC6Ot/710brHNJqRhXPxg
 kiaN8Cr0LjZdDZ71GZUGFKLEwF6lpSMrfs2VGynWwejFDqK6gjlUUYzAb/F/6RLBR19sk
 TDfC+36S5/bj+V3zaRkwWB3wJ0PuVWkyEiyayZKVH+G7PFwSRwYvKhH/k4tcm7TH2isBl
 6gTEoIBbA7cARkVx8255CFO2zXC5McaXI9ZRo3S0k+U3p2xpafafOSmf0qz3Brzy0vQUO
 Ce8LZ4Yh9V+7xk0AYjxLOWdX3XOfnIsQQgbz06UybyZxUwZaguEz39jAp1LqBcBmlKg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=BKgwQt3F; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=BKgwQt3F
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ACAED80981
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 07:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790665692; x=1822201692;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rPP6mmCHnA9/vGm5ZRqPBYbmjf89j2RwHuknlGYoBrc=;
 b=BKgwQt3FQ3XbwsPR5qF83iXp5fH8r8/MRJ0z8bj9x8M3Gh2sSJykVNof
 VUNYrNRI0U8KEO2nFrBMRVXWrIy7xA9f5gBA6BIh1zCcGZcpXrdoedwFc
 cmYDnsLoNdThygC/SpHVRVsA7UK9738ndDSRTRgyR+a52bcTaIHkDiGia
 AZ7th3whRthc38kyHdtWr/S5cxWrs+k4salIIxmWGeLVyyFvi6jO03eo8
 cn34TQjEoVO8eJR8DDYncDAf8gYklfezKepC5cMfWX3kmqxPXdU20Gx9u
 u/QAFZvYzslWGLLk1CsBulQTvK35gwhr5d1Az4xOxS8KapzovLrHUH+F8 w==;
X-CSE-ConnectionGUID: ixmtviQ3T4SPgp9JuRI5sQ==
X-CSE-MsgGUID: lr5xRHJLSum3FrsiO1PSoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="101542402"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="101542402"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 00:08:09 -0700
X-CSE-ConnectionGUID: be+PZ8pLQfyjHHKT0xbtyA==
X-CSE-MsgGUID: ttiK9VMxRTeyILqf/5/2Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="271771784"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 00:08:08 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 00:08:08 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 00:08:07 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.30) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 00:08:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ef1OxdfPTLfPjLoy37riOrPYynXwTq8ZN7Tie93LV78NqIzHZ1qlcHB9JyL1rbvZmK3F3b1xSduW5Vg2xM0MZknBFFnZWv1qMMyQNInMdvKmffFQsGrmDF/TR7RMJRKxdtsbUtAA4x6HEvHGFY4txrwEBu1veHDF3XAJ+K1CYO3GKo7VQhD/dlwF2kVZnT5JI4TP9Y5PKUwG8jZKGDn9Y4zdFJPyf+MLDIsHFqX4SMGZQJipjM/aMUKxIKaiAvtPUDEGXE27bM7FK2l11bDKQ3s5G+jEbcB3jY+VYUjL4RB1r2YNEoN1TPA+cFwBJMPCms4CS4E4BSwo//9/4AuVaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bL0RX9E1XrlsSgQFrKJ3BXF6DMxdV7P/hZ5dT83+2M=;
 b=LINQi7dEUUyI2Ub+jHASFhaOzkapfbh6Yv50Gd2iAkiENmm3FQX4P9cFpNGrVks47XrytxisnUaQvOYuRqKJO+hi/PCimliV3/tlJSQ2CxTmb85lzFTQQldI7rI1AZxuS8EWxZz0aZr9fghHanaSi91gBJ0Sgktf90fyoOKngqcNsEv1hHxkn8vyDYu2J5Kh0ZNFoXrX/jZB4DSWd1UZJ5iVoMAa7Ql34nKTwQeT6LkQbJyBIQW80ZkPTZK9tDF+s909da6snBhgAyD6rGsoywj8PH4SPf7KeU46eKAiokt4nQXvKp2KRNCqMgnpaju125fMIXjmO11PId+NW6Kg3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV8PR11MB8511.namprd11.prod.outlook.com (2603:10b6:408:1ed::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 07:07:41 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 07:07:41 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Hongyan Xu <getshell@seu.edu.cn>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@kernel.org" <edumazet@kernel.org>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jianhao.xu@seu.edu.cn" <jianhao.xu@seu.edu.cn>
Subject: RE: [PATCH net] net: e100: cancel timeout work during removal
Thread-Topic: [PATCH net] net: e100: cancel timeout work during removal
Thread-Index: AQHdT08Lu9l88thpV0KuKLwQXrVYOLblI8HA
Date: Tue, 29 Sep 2026 07:07:41 +0000
Message-ID: <IA3PR11MB898623140BD84D12FE2234D2E58C2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260928134121.826-1-getshell@seu.edu.cn>
In-Reply-To: <20260928134121.826-1-getshell@seu.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV8PR11MB8511:EE_
x-ms-office365-filtering-correlation-id: 918e446f-952e-4dd2-7cb2-08df1df85a22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|23010399003|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: x8Q3stj5Z/K7psQji+pp19o4jn2wvMij9buwewfY/6P7ZLJoEC3IZhjahLiPqhiAUPTZnc94SY2pdQZJ3aPBaSfVsaCG1fluLcglgr+FBDDv/SCxb8vy/vQ9yj1ZfYw9rAZmtGdYVJ9B7DFh38x9I9lhcrsJyVQSla8u+3hminQroxwjBSBQRAbNX2V9lxDZwcA7fCwA/EPzLySuM/umgLs+RCzMZW/0qnrr1qv32W3O50O3cLmuYQyW3fc5aMnongP8ObbVLAY7DB9molcGxc+egpgLiDGvkSysfx/fB+67EABdIHnAkdVDI9c7DeOMmBCx8r39i5JklOhWdqHwFIgvVC00UB173RScuhjn1S/T5wyWil7xiOB/Eid5pYKq0FoEVjvM5KugSVlXGdD/95wznF//zrHlGzZTioxuEkWfSJNvw0xeJk6tKXGcAee10NgsxpXiLM5iey8QdkFEpcrjfUOPlcQ9rjLNMD1aq1tlE+KS9uUx+aQjiEWlSj7KrnIVSZiosgAjkNFKX/T+lsormt0AWjz/He9M57Xz6EcLN3YuPzHLrblWoPNUpdyahgFnsiHJNYP5x+IqM81eQOxbmsrwu8XpmnGapOT5F2HCHB5XkEo5de2s01wKknF6fbTFinb+zEUgfrnDahQkovKvDi4/oyOzvKlypaD8SFQM/7vdDYmM1FBkhZb3leDk42TcyouXRY28qxdENfq9c8Zk8JV50EWPjyB+xhD/A7Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YZKApI8EQRgpnWuo5NL9yzjLGT2hzJTozHZKqJUK8Xli4b0m6uSgxMO93s/9?=
 =?us-ascii?Q?DDdrp+WRxb/EyjOMJz2Rdho9YF5aMqucAVKT634SWEYfoHeT+o1btyr3f0QB?=
 =?us-ascii?Q?cyRVmmXsoXDE3uIZ2w4p7SSYVgO2V2ArAfPu2vu6pAyKfPiZJ7Tatx0Yr18n?=
 =?us-ascii?Q?Oub893nRKrEj+KdUbcI+O6jBQdyouNHACHSVKRdVgletwApBeAERPPq9wDfD?=
 =?us-ascii?Q?M1HSi0vmlz3bllVTMnf1Fu0EgeQzvO65sOoC89jxbBkbSuciyzLFL5XMap8T?=
 =?us-ascii?Q?kwRv1x1ABTHTGMleJdOkUpn1QPo5A4lu6mxHjS1F5/yOfKcb4c8bXeihm5tg?=
 =?us-ascii?Q?x9yUk9Nfm9RwoK9iSMd0SDaSDL4lbHwGMuWUesihqj3JL/WPTG7Sk9AUKpC3?=
 =?us-ascii?Q?Jnl4yDQXBmvuG6hSMxOq+D6bClotHmhrURJu8JLeS98NymxKOhkefDkLijKn?=
 =?us-ascii?Q?SXLL1yCF3BHv7g6Bkicvylkog6CW7avQo/WcqRLL7ka5m8L4xRUPRVMzIsjS?=
 =?us-ascii?Q?KTJDtCOHpAFS2ctBUbc+m1wGhMoIEhFCCKeapBbiJiEqTIsffdlD+CYxF5OR?=
 =?us-ascii?Q?FggOWgmPl2CjPgFYvR1JW4b7kpE+ER/YcHHk2fUI6bx22n9MsG9ATy0J0EGd?=
 =?us-ascii?Q?ZUIRgCDouDUUqwSfZJuATA9okY9qqRK88eIKFvUd6+62CPtPJ++hfpJm/K1H?=
 =?us-ascii?Q?cgmdoaUL3XENXt86b5FjWMKhOT40DnHZFQwCMPjzd0HG5P3SukiRvnJ/KyAO?=
 =?us-ascii?Q?WAIML3H+ncbIFKEkVd5sn6sFAgE2BJyLuE8zrW6lV+xMzJalYNzsey8gnc6k?=
 =?us-ascii?Q?g1+6r/4kjFcC2rDUQbBK8EYgTzStrItEGYSgtBy+YoWF/Fd6pgUtsSjoK4mh?=
 =?us-ascii?Q?BKz1RGDiTn/QSbba2E+BkYKKz2gwFsR97W0yu7cHwoNprO9Km2IrfYOERzS0?=
 =?us-ascii?Q?DKnxiawGf4yTJIO3ekvjAGGDGPVYysAZNqrmzhwrifQ5Pyrmk2xCg9hujdFA?=
 =?us-ascii?Q?wgPo5bBN6R0Rd46A1WJLInCJjf4+wJRjg0EOK0k9nCkEaka60e//jtilYf7e?=
 =?us-ascii?Q?IYM1fMtp+3xhgDIjQCuPZvVv58CpavwI2MK6CsP1+sAKnZwzFrVHCvEvbMEv?=
 =?us-ascii?Q?2X+kwy/rF+neWeKAsK3fHbcE0P1A9jiEa69sLPzNyMPCCKAYuXAdPwSyXtzO?=
 =?us-ascii?Q?20JUe8GXrjmaaHxa5+4eYM+7Y2+Gy24/IvNOCX6b7SD044iiVrRgICsDa0yT?=
 =?us-ascii?Q?MnUuhR6KSQQP2SovPvJH0jB78JfDDvoKJVsUtuotg3s8wv6NjzpshDOyMmVc?=
 =?us-ascii?Q?1etomDcdYvxKaX/7QylPWAy4UBXMhDQWyYKj2i2RFXYvv4DT8qtR/A1cz3dq?=
 =?us-ascii?Q?Ce5c0252t8Yq4qbo7BVpJh24CcNHNIQqc7D13p4InAmCiNKA/3V2iQTHR4pr?=
 =?us-ascii?Q?Urh6J79loyWmfKXf9TTXq2nQok6UX0M3gbcDLHJhF9UTyDRe0+fQ1EdsFtsY?=
 =?us-ascii?Q?CpNCViN1gVVuG/26ITJ+sJV3e7Cjf+q+SLbskivd2x7/88Bt34o0h6PiITMZ?=
 =?us-ascii?Q?30Mln7vs2Fmr74/yhHb/aaOlfDIIZryPkreU1+pYCx3Rm07i1Al2x7vyfDRk?=
 =?us-ascii?Q?p6i/iz7nkWEZ62TBChs2r3kRUhzvFdgaJdcgR/yCKd9+MDeoi91jeU6z0RoC?=
 =?us-ascii?Q?xM0Yr2MJKuMFehT24jr2RzeX2AC90K7RqSc7N1S7zxo3YzPo0DSZFrEgRYRC?=
 =?us-ascii?Q?jNOBaf2JSLNNsVFWJ9NcaIB6GHa00VM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 3SbubgZO/ztQD6RGPpakmlcYwHSOW4uLdF1xBWkSW8pDPB0SmtkrPdTC6Q346utOuHZPIhUhXQ7GZk7R111Kb7spm/6oNbbIspOOglf+Lcx3wKRDA/+O6Qe3pDPPtJtoO9Ksa3LteZA+k42t0cLHBC6ic+9OgtXSh0rbYvk/Ebdau/hx3TyyJhdpO8Qpc0qLqWltJxjJRgLQ2j2LjkirPQ8GgKb1Nnh3UdLO0c8IDoGDPviVFEFR0ikiLjjTVCW/3YElWHQHV/Hu0G4onO5TwdLD6RMlRKqq6ork5fjJ51RVMW1KhLwwpxMEfJq6VLxA1NFId3ctKsKQmAp68X/XBg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 918e446f-952e-4dd2-7cb2-08df1df85a22
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 07:07:41.1155 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EKQoNMkJXyMlWTRJfrXzqkP0Kp+47tkx9Pn/c2cpHwg8xp8xXlVidU7jaxKXdrz1wzAman0iUg2Ibv4iKEVfP/UpOxl7zVwNPfC9S7LLMpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8511
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
> From: Hongyan Xu <getshell@seu.edu.cn>
> Sent: Monday, September 28, 2026 3:41 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>
> Cc: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@kernel.org;
> kuba@kernel.org; pabeni@redhat.com; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> jianhao.xu@seu.edu.cn; Hongyan Xu <getshell@seu.edu.cn>
> Subject: [PATCH net] net: e100: cancel timeout work during removal
>=20
> Transmit timeout and command submission paths can queue
> tx_timeout_task.
> The worker accesses the MMIO mapping and netdev private state, but
> device removal releases both without draining a pending instance.
>=20
> Cancel the work after unregister_netdev(), when the network stack can
> no longer publish it and after any RTNL serialization used by the
> worker has completed.
>=20
> Fixes: 2acdb1e05c1a ("[PATCH] e100: Execute tx_timeout task outside
> interrupt context")
> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
> ---
>  drivers/net/ethernet/intel/e100.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/ethernet/intel/e100.c
> b/drivers/net/ethernet/intel/e100.c
> index 29960762e64a..710c2c30d9ed 100644
> --- a/drivers/net/ethernet/intel/e100.c
> +++ b/drivers/net/ethernet/intel/e100.c
> @@ -2988,6 +2988,7 @@ static void e100_remove(struct pci_dev *pdev)
>  	if (netdev) {
>  		struct nic *nic =3D netdev_priv(netdev);
>  		unregister_netdev(netdev);
> +		cancel_work_sync(&nic->tx_timeout_task);
>  		e100_free(nic);
>  		pci_iounmap(pdev, nic->csr);
>  		dma_pool_destroy(nic->cbs_pool);
> --
> 2.50.1.windows.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

