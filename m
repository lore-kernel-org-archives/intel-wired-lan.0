Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6697560A2629
	for <intel-wired-lan@archiver.kernel.org>; Wed, 21 Oct 2026 12:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=pAcZt/BB;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hc5R9DdP
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 408C880DAE;
	Wed, 21 Oct 2026 12:14:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8Aacjth6PdGR; Wed, 21 Oct 2026 12:14:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 83A5780DC8
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792584895;
	b=mSxvNgrLUQUI6YL7gyl5F1W1QGQJsggN6FqkBjN/Y1w8YZABQdRSlwkp2Rp1COMwFiMH
	 GLazIiSyFXseQH2NVb/wP4+ZC/8JNXFl+bJiav8WrvCveqyXKRJNC8+fy4IjvQio9RGZu
	 Ydp51hFJrDxGWJJnwYQT8GQiA4m2C8oYcGZJNxmgvHrs6P78fR9fDyx2Jm6DXvjuyvtEJ
	 vTrTyh9B6Nt4cdFiFW6iZBKohM+7bddGpobN3KkGZY1xD4NbLK/pksrd77OTV8y7Ni4Dn
	 l5mBrrwLYWZpTKUupqCLP9GBrIu1d3+o6JIHErJCVD671ijIEP1UIDTECgyEP1bBEmQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792584895;
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
	bh=5IM5csQqUdF0RSW/cu7rVoeH6wSRSoDgRnOPY/xALa4=;
	b=E7YXuyxTXO4h7lyY/I2iCPm/Wq+520dX30oEbW66HrwLmRFLA2JuTakH98MYRVxGzC+R
	 nm17JSy73r2yHAe1pNR+suH20TTBeaAv0DqtfFrEgTvHPJ7Pge2Eh6t8uUcA+yc8orlW7
	 me6YUynROU3c3+MNN6GA4pQurk7YfwxBN3IiNkXtM+cHoh8J2Q1PplvAHBgI5Pr/IC6ZK
	 sojXUlPTn6+mxJvJoAcXEEBYw7EThja+evwS/gA0ECUwRD47TzXaFZz9Ov+5hspaRQW6X
	 UMRgNTD4AFGXyU/ViERgjGjrO+Q1gWoeTLo/AgSJR66CXgn4HUDsVAJ7kVt0Y2FJ3Nw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hc5R9DdP;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792584895;
	bh=5IM5csQqUdF0RSW/cu7rVoeH6wSRSoDgRnOPY/xALa4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pAcZt/BBOQNNzPU2oWBaPW/r5ky08x87oZ9eInIq7unOjYGHeUiB8KImtP2WbkNsJ
	 YQKEFk4XeWUPj6DrdG8f8Pzpw7o+i8FUr5Or4NSrIJwh6TuzvcXCSbd+AJ37p/1bh8
	 QKkXGXy6PVzpU7aUyts0gKcJaIXBd+pMCYdVue+M5hMeMg4JYNm2zarBshubPdwkHC
	 BGnN6Pj/vSxjVUM7VkPqeeLfHdBQYnSxOiagmsYpHO58VDxvBYIBIQDYrkWlFphOeJ
	 wXTqJ4jnTkJgfPzCnmgLQd2yIoUvjDD+Xjg9TI2YW6hLmj/Frq8qh8nSTwqshTU5Wd
	 KDjFFFbWLJStw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 83A5780DC8;
	Wed, 21 Oct 2026 12:14:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A005B3AF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 12:14:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 91D4A80DC8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 12:14:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qWYpm59l6vh3 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 21 Oct 2026 12:14:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A63E880DAE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.20
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792584893;
 b=Lo0TXwFEx3jnHRddl9JnKESOokSMtwIt9H+ucmN0mW2sjiZuVUUl5057UK5wAazWKWvA
 X8WiYe31F95qlI0EcR/DJwiraIb8MdjDcEa5RZaNabbz+k2draBxbZQ/EmnKY2GFNZhhW
 0k/YhjkFb453MGGCAI2tVW0be1WLGnzizg/3EH/IZSq2FVC8uum1qCOvd8zdol5qhl00P
 b3dZvIsDEd6rfm+bxB2OFR7AsF5YkgTfZHROQWPi6wdQnECUpM+15PZ5vAwthljz9wSJp
 23xkVX9ORBAzpAjfHB+2MKwnqE7sKZMMwY1qo9dESTJ9L448Ob7C/9iNxUZzwWBjwEA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792584893;
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
 bh=5IM5csQqUdF0RSW/cu7rVoeH6wSRSoDgRnOPY/xALa4=;
 b=gqX8m3dJ6vgqVp9FyUpPzsbvMZGnlllutooeK1QGrGGh7OGd/r9whW7MVAXTfALk4CmH
 rAsf1FahmXpdHA9BossdKQ7DKKRQwWo8i8KWIE9Z9vPeB7OyRRuOS8FVEJuLCCl7jVldk
 oqmoYraudRJKt/aJYHHl4oWld40FVk1hYRqbdJ/ymgkzrFgnD3MzSZnF8iss1w/gEHSnU
 9H/8KTwV1kkz5VdleQVH4tDVsID+HnZY7JuavwzebZqyCtD41wnAb939sWYbOMQdRjnib
 RwCc2/LqHBn8/GxXowH5BzqmEi7jrmqN83VeQGdtnJPvvyt5cq1XJwjXKTbxcM8iwaA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Hc5R9DdP; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.20
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.20;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Hc5R9DdP
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A63E880DAE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 12:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792584894; x=1824120894;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tEMs4EgB4Re9QRvNDbmsgwhTg0X2WR52DKrcwPqcpN4=;
 b=Hc5R9DdPu8l2L0quaQfx2tU2g11P8Kro08XTT1viApZh/uxD2quzBee/
 ESu0it1E2e+GflTiJunShsGzBOzBDc225cmUrP48Sdr/X42o7ExjNsCvH
 KxowHA4IZadJ5KQ3wrrtIduC/ENCIRwrn2XR7cpnds7VtTeMd9qlHeMbd
 azrU/tx12WTaAVd1F9LCfibO/6qKDDhgjvtEezthtKnC62UAMaJ9fxIFj
 D3ehhu8bpVkGjSrTnWw4EQxP0xYKHq5ZCdUze/9VgdAFLVPU40x5y+1M9
 GLVoCIssxYXinYytZz8h3JIPZPwyxxcJVBEhYnCTfiyyin2gJogCA3sAK g==;
X-CSE-ConnectionGUID: 0vUH1KUySwSw5yoIKOZ1uQ==
X-CSE-MsgGUID: vpB/L/JhToGS833OfQZlNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1317186"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1317186"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 05:14:52 -0700
X-CSE-ConnectionGUID: MYsKCN1aScOu8PCmvHkw7w==
X-CSE-MsgGUID: O6jEB/GhSP6Up+hIKiU//w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3131550"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 05:14:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 05:14:51 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 05:14:51 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.33) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 05:14:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5CD6F2SqQ6k9gOZyD7cHbND8dPcvqaPaYN4wNhkpMTsHsUJ4SOxWa4UoR32/ZWciGU7AeK7akgrcWwQnnIHWXcJyGH9RhmQxj3i1nuwyufItGQ3NfkG7CFpEmiYixBObEtCvv4MUGbiwTVe3IEIkHFrn+DbIbNwAfIbW14zBscAaHZ2E1GfHlqx4+oeQc6EXSUyv4KgDhNbMLFVRqiB23wg32d87VuKhoMuuIgv3MOq1jzfM6OJS/+geJw/vSAS+9cUWSpIU0xWUxcYQ3eXe0Z/RDxTckeF3kEH+kL0q3v6us4c/Lczrdj2djw8bJfmmgP/qhr6PBaewOsWTS+K7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IM5csQqUdF0RSW/cu7rVoeH6wSRSoDgRnOPY/xALa4=;
 b=bK+MYDE7ap0CBdO1wyXJXuoPiH2ThTHapqHdr3niYpUo52XGsod89Wf8VoSsXQKt8h4GmHk5eNi+7ifKnRCTKF6camNNhBUqUH9HglNBrVUqqovKMg4p0LqvEfe8o8PYanNKJ2UkCNg/B4BHxTVIzMc/w+sYsSJzqxc94/q3Erm1/Qcg63WMO2BkaR3XRFYW/8vb1hUS7Z5EAXWL27ek/FEEC1XdnKVbkwc7H48IgZgnOGKMxhbMjCIrWHbnhhjTeLqv0M0UCF6Ccc+nW7FFAQp3Ol3Ym75br1D0nmvAp2leiX21oZ2gBRG9CmptV+4/22zLNCIWzF7c3SmArBWvTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by PH0PR11MB4805.namprd11.prod.outlook.com
 (2603:10b6:510:32::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 12:14:43 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 12:14:43 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Aaron Ma <aaron.ma@canonical.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, Richard Cochran
 <richardcochran@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
CC: Dan Nowlin <dan.nowlin@intel.com>, Brett Creeley
 <brett.creeley@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>
Subject: RE: [PATCH 5/5] ice: quiesce PTP periodic work before system suspend
Thread-Topic: [PATCH 5/5] ice: quiesce PTP periodic work before system suspend
Thread-Index: AQHdX7gV6rQRv2Nny0umlPWNKZBuvLcH6/sw
Date: Wed, 21 Oct 2026 12:14:42 +0000
Message-ID: <CH3PR11MB56689501C5B27D1510018C8219E5662@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261019105155.3793063-1-aaron.ma@canonical.com>
 <20261019105155.3793063-6-aaron.ma@canonical.com>
In-Reply-To: <20261019105155.3793063-6-aaron.ma@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|PH0PR11MB4805:EE_
x-ms-office365-filtering-correlation-id: d04b6e43-c95b-435b-ec65-08df2f6ce382
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|366016|38070700021|921020|4143699003|11063799006|56012099006|261009223027099003|10067099003|21046099003|22082099003|18002099003;
x-microsoft-antispam-message-info: tccMUfmmxew1YcrAcURzHM7lnNLXe2CjkIVeItDfdeOeUQ8KV/wo4irLLsSu1IXjrCW4rWG1UyqaDhefMIx+/MTtv6Z/uLUfZnBwz7OtIzmyOAemuV995bUw3K9yH+bLlmuCHq708R+FXdxV4DUfYw4yIsRcKq9Kh2pszjLYIbDPeN3Jq0RGnZpdKVXJMVpSBFSgyuA9MzEGGxsmrtLpso945IDjkdawgvSEe18t4RjhIrW22j4Gvw92ROarSR4pBkppHrR9xBcJB7GRr9oZ19pQtcRp31lOQXSurTdC/4IKuct6uMhjdzGN1pxG59VaSSSq5c5j9Sw25EV0iuqrQUvyRlJe+pYVoXLtkCkPNPrelMdFx2nS4eA2q9Mtp7NdYgFolg/tQjTr00lLSVNVqRILDElZ0RzJsmNpZUJw+MbAeL4hHrK9Iv0ifsVZD8WdLl6UckE6DlllQ0tMsEs3ZW6jCkKrCGn9Ew+QB5CDxGYx6QVy5H4VJKgEBHt0Dznrc3geSuI+S9Mg2bq4JKSXoDU9S7kxXm2dJxf3nzHoJv9NPJePJjU/qPiVQ03QsN5he6lrXm6SBDYdn2T2STHu2h9ggeXZQV4KL/VthXMyYzwcOX/24gjUo6q/zrOCQ8XH0Me3UzHR0DWduWHYbggGAItEhBNJMK0UBM3IHB5VIXeAs9QjsSfV3SU/0Y9QpexPtKaoD+dQcwtoxY6jBB+yb5g745bkWiJ9SmchWVOFBbTCXKBul5rMvUqFKh/5Khc0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB566895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(38070700021)(921020)(4143699003)(11063799006)(56012099006)(261009223027099003)(10067099003)(21046099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6N5DazLcWIy3imjjyksRPKCMPFfHydBET+GjsQ8ZGOFaJnH44xC/u1GS9T6h?=
 =?us-ascii?Q?fUojK9e0uaO1kFd61Nl/8xELABswYRkXbUBguBfFW1Fr4jgIauDQQZnC5usg?=
 =?us-ascii?Q?pTh1TT7ZLxBwHNmnq3fpPStz8YhjGLSFvLsPo5v/QX5S1NGCwx8VJy6Pyd88?=
 =?us-ascii?Q?YblKP2rZWXX+/JMpSFtPsvckhjKLDP4wZOPjOR6vomrPBA8MZ9USgp78e1za?=
 =?us-ascii?Q?GsE53edKBBMb7/zGK2qoMfgcb1E2Wlyif8nA+p8q9QqyLT/J/jikcb2vETMC?=
 =?us-ascii?Q?RBWJJzBLpeU5JDagM/IpGxvIyNYHOSP9r9hiTyCCWtXvTlxfpsF7AhfZezZI?=
 =?us-ascii?Q?wxCBwlXvpjaneMHkMMy7RIkfSR9h6X8ZBk7l4BtE16tPn+d3RL5IwOt3Ra93?=
 =?us-ascii?Q?zbok+8UuO4lHf/M7vId8KSNA+N1fvKcoihrXFaWwJNaOnGpv0w9FsU61Aq5/?=
 =?us-ascii?Q?9mMX6NLI9laUl8jeMkrSqrUbMzw++QSfQ4OKbgA/rj/2DMIV9AnVqOzd4I2F?=
 =?us-ascii?Q?CRofnbWH2Llnk556/kd9T/4j0erX184z3ujMpjWfGayhvWqKczyMw53MYGaH?=
 =?us-ascii?Q?NlRsS83bShUY3D5qeVxY8bEDu+heJnvnhB9J2iBKWCeqURybGs95ZLdLqLkb?=
 =?us-ascii?Q?lLQbAyu2ltDu1NBEbf168k8muRvTpabK370xYuuVSNV9o9DE5QG7490SgJ9e?=
 =?us-ascii?Q?4PTyecF2Ok6mCcuEdpRmwMJTgrgfdeaht0teJNPP+CgY0jGeyIOqsYpkju7v?=
 =?us-ascii?Q?mBbbRbPW4mNlg/Fio9GgHy2/JDwGvYAiCC8BVA/O2XFEctuqphuy3f9P8REY?=
 =?us-ascii?Q?XHyozHyyeDeg6jqNuBZv1hpQDqFtnV+68C+ELBatJrLejLFlPWjmupzAEamj?=
 =?us-ascii?Q?6xlGetRu+6PhM8aF7syQKhhoU3Jba29HVuWprolY7eCJHWAux2EU0rOQBjdR?=
 =?us-ascii?Q?CRQTd0mLgK10CRE5+YR8dIWH391V4lEqwjMyYrCcJ7yrR8CvwGlkXcp1/edi?=
 =?us-ascii?Q?7lY1oOkqx23NO6gIVEctJjsAJMG7mqwuwG0NShoWMZqFCPF5RdzviUK1Vgpl?=
 =?us-ascii?Q?ec+5ECBduVXjmJAnMD4BkTiWghcGbHUPHFm4XNx72Sn5SSYihpw6fihcjjlR?=
 =?us-ascii?Q?Yqn81OZi/sVbOnbAHyilsAVp65na5INy6RUIOpUpNLyknZ4iLnAgrB8CEhDh?=
 =?us-ascii?Q?7Z26/rJhqw48BhdRL1qrTrkNWM5zFRN/Y7hAhnytROGz+DNjK4X5ZksR7xDs?=
 =?us-ascii?Q?PKXrtVp0JBv3Ae0EJh+iqnrhitGlXxuIzwCKAAnK5zIjP89I19nqy7eFnBjP?=
 =?us-ascii?Q?b5/Nu+IKoeITTipqfRCN1fLVjRzpRjvrbMyganf2C3M6X+mtYu7ixfzAHVN0?=
 =?us-ascii?Q?dBn5Lj3eqr1ugjN4X3/HNUrdHZSyk0d9VLqePNA5FZotUb/l1Ww5M0nkk2dj?=
 =?us-ascii?Q?XDro9rgDexB7+dYlHKNXRrKoPQ9oRIv812ZgUsnR8f6lR25jPMbGITMb+PQQ?=
 =?us-ascii?Q?wX/3WBTR2YESQY+pp5hhsx5lPCJ4jVFCoCJxzJkIx+nPxLe7Drsqf9Ki8DgG?=
 =?us-ascii?Q?ZrBWZQjRXpFhdyuJpAc/wCc+s88xsaXEUeCCN2d4bdxUk2xVRDPNFml560nr?=
 =?us-ascii?Q?zw40rmAYUBHp9XHxqfdzpfoi4/oE1X71Y8vgF+8sgKsHiI70jehjQVKJ1YhR?=
 =?us-ascii?Q?RtvCdR72lGhDYMv1PX9swPvIBW1OEfIpoG7UoArH5etNfmM5/7tcQcJ2Q19I?=
 =?us-ascii?Q?/WHKPn6rJbCmiv+MnOyCaQGamr09brc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 0nLslNaR3kctYEsCOtFu5xxlSMWXpfDlp328FJEDMYrXb3xAl1rJbZgjwQWXzCG7Vn3xpN1z2qUfjRckxweOI16PFY7WQwfDFlZRi+1iM8WjQgGMAXZ0RtSFwkfjALCcbd4vv2aN6zovxpAufyMHVNVW4UfpesCzm6EsBRIk1LGKWKxYR/O7zWCTJqDL9QrGKj490reND7h67mVYWD2a+835zV0WF/6mGMskmxPjLAPNUPlRLcVdjtMNirVSKMzoT7VKvecI5c3DCY3Z2KsA+n3+vu7vokQCHDbRwjFF0So+79pI4jskwnerP3BkBZNC3e7cVc487YFesyQ8KcUxGQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d04b6e43-c95b-435b-ec65-08df2f6ce382
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 12:14:42.9713 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WiUpwHI1XyWs9qqjXAUpNxtFd/pmPTDUwFyO3Z6OB0a1VeWDtm0k29SHrn4cBT4hVHwcg2CLIl9P3OOX+MWGy57+npIYqXwjzfqkHtF8vIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4805
X-OriginatorOrg: intel.com
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> -----Original Message-----
> From: Aaron Ma <aaron.ma@canonical.com>
> Sent: Monday, October 19, 2026 12:52 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@kernel.org>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Lobakin, Aleksander <aleksander.lobakin@intel.com>;
> Richard Cochran <richardcochran@gmail.com>; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Cc: Dan Nowlin <dan.nowlin@intel.com>; Brett Creeley
> <brett.creeley@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;
> moderated list:INTEL ETHERNET DRIVERS <intel-wired-lan@lists.osuosl.org>
> Subject: [PATCH 5/5] ice: quiesce PTP periodic work before system
> suspend
>=20
> ice_suspend() stops the main service task but leaves PTP work active.
> The PTP kworker is not freezable, so it can continue issuing MMIO
> accesses after the PCI function has entered D3hot. Both the periodic
> work updating the cached PHC time and the E822 offset calibration work,
> which reschedules itself while calibration is pending, are affected.
>=20
> Synchronously cancel both works when PTP is ready, after disabling the
> VSIs and before shutting down the control queues.
>=20
> Fixes: 77a781155a65 ("ice: enable receive hardware timestamping")
> Fixes: a69f1cb62aec ("ice: exit bypass mode once hardware finishes
> timestamp calibration")
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index ddebb28b2454f..3962910759067 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5450,6 +5450,12 @@ static void ice_prepare_for_shutdown(struct
> ice_pf *pf)
>  	/* disable the VSIs and their queues that are not already DOWN */
>  	ice_pf_dis_all_vsi(pf, false);
>=20
> +	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags) &&
> +	    pf->ptp.state =3D=3D ICE_PTP_READY) {
> +		kthread_cancel_delayed_work_sync(&pf->ptp.work);
> +		kthread_cancel_delayed_work_sync(&pf->ptp.port.ov_work);
> +	}
> +
>  	ice_for_each_vsi(pf, v)
>  		if (pf->vsi[v])
>  			pf->vsi[v]->vsi_num =3D 0;
> --
> 2.53.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


