Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4C1CA5FFE
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 08:26:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5399E6076F;
	Tue,  6 Oct 2026 08:26:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A1G1G5uArbxL; Tue,  6 Oct 2026 08:26:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8694A60782
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791275164;
	b=Awn7afF+pQlncXwAVTPfkyWEt/exjFBScDNQLnk0PxTX6OMmSGnQ+cAqRk46VeVLQowH
	 9U7FEDDAdLeCLzg7JqHMQRNa5AJ6zONxjT5RNLB0jkP3beGGr3XnMIWJO3X7QYlPrTuSY
	 zsa2vqX2PwnWEqOkkmYOLXOcsgi7Ju+uZe1/HmM4YPjEdLbKvJw4T5V0cHyzGxtpJjMCV
	 RFm2FNstn3HW0LtkgC12T/RfbKHApKBCBbqjJkziHPcNKJrgQf5c6pZO1miQAlW/rgTJo
	 ak5garH62QJop2eHTObicvuEP8Wx4wBEMoNscCltxd0K/3am1xuNvirtQuHql6dB9lA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791275164;
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
	bh=OgZveKb6fwUUzGFWM/+uIt+7QVq1cgxZhRUWX/1+Q6E=;
	b=dhHnmaI7nHLbi8l/uZR3lk7vUE/etQjTi/ZhdiUz4gT1gXIcXUsEWNirSCn3h3MJt2y8
	 M5xVppWwA+nXrEMRN5UrkIQt8hfjSQbQABzmxix8qC6/nDx6QcZ6ZIKMFZx9UMcVQeSkw
	 KJgsr3VHoqsO8bsodZ5sFsXBN3mp2NwKewtlUmMC5GtQqI8C127oqKtfJifbwzfNQvC5k
	 fpdMmDpKruW6jJGAoH/3eKhyleRbBbftE+V3SDqgTGs6XCsg/rWPi8nHeJtp0lqkJlS1h
	 5srAtTDQiJOOcNbwIIVD2kdF4V+GCDPfM6TbhC+yyoKw/RKqg0sUkZxEHqMFs0urfDw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791275164;
	bh=OgZveKb6fwUUzGFWM/+uIt+7QVq1cgxZhRUWX/1+Q6E=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zh+8VioYYeq4hCYduzmkgHeqOmx5jmjkBizDKZlgEDMGfI/j0nX3drnHkUeU6RSX/
	 GIn5iF8d5MAgMs6Sdj6LQ31x33YK4hkPxk3FRqinBBQ8OVhx3RWBHDaPLm2UmzqlOu
	 IeAbzTlzA4ZYTOfd4imVXncexgHFNgECJ3XsWKjl52mPQuT+lyduURVdzHhiIcBM4C
	 H2/ml2o3njksAremZDTjKLZPdqEU1Z7NpQ2cxNgZcgxLbdkxyRzqRMeO1poywUt9om
	 wOLXSmCjkffJ6oMpY5+q3eSJbAUgKcfdHwxrDJ0goTw5d02HgrduqBmwBm2jv5B3jz
	 zG8k7T0XpIVNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8694A60782;
	Tue,  6 Oct 2026 08:26:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 08EB5338
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 08:02:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E2D8540225
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 08:02:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F9Y-F2-7BYml for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 08:02:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 2AFF24021E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.20
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791273749;
 b=HsR0vW6YpYiL4XkfNNtVB8g0VKiu6LpWznvmKRg4dK7OkPpyjr7KTMDkvdjnmIK7+e5e
 KM/XIHXCBdfXOm0mw6Ridp71nH/AJNF/A5/tDbTRJ6CIG2DmGnWbwzJJL2F4uPPTHCpZ9
 DnE6JXPv0dLVTUhRHhaA0VsRu6V0fTBTeTI34ziL9c6jtBH0QDzj+Nj+9m0uyBp/ylR2h
 dkmuIRDe06ItLcEqk2Hhj7E1qvnNgFPShRKuv6wYdb+DJApjiMRER25+DsOWP1psN19Jb
 tuNB129Wguqz7zPZpUkSUl8diAJCKFahXfQ2tF+4A1/7HQFYxlOUnbL/Qg8GoqoCSPQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791273749;
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
 bh=OgZveKb6fwUUzGFWM/+uIt+7QVq1cgxZhRUWX/1+Q6E=;
 b=kN/51G0sECw00WJYLd+xOZ+7mfcqIo0/61PmibfMPG0yfqDd7+SgHp4YKb9p62e2cq3w
 QEJY/A0pwFXVWUI1KC0cMXaPsXCNJwefKDmSt45qdI1pjtM7vWCKhq8UtXOOvvM/jb2yQ
 t3FFHWzkbhnTngAsSSmU2joirtvjVn3lgu5m7HlHG2/qwaK40CxT+PvIUb0Z/mQl6yk6M
 Ovvh0QXJ+ljLtOnC1intjuwywxceD+aoSso0QDoiqp73qmL32O+GCYlNc5aKcGaYAqcKM
 Z1iSyOWGJ8wVL40vkrDSHwDyezWxfl7pz0QCASNAgM1TG8ChRGrendUw7Wbhtagqb0w==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=UXe0gnAP; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.20
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.20;
 helo=mgamail.intel.com; envelope-from=rafal.romanowski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=UXe0gnAP
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2AFF24021E
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 08:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791273749; x=1822809749;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iShV5OAPd/i0VfDDAQvb9G2T8SUe8z6gr0LCbO59iF0=;
 b=UXe0gnAPKm8Kz2PZpjkQNV/fYRzgp/6LIkEXxA2gk4lHmnbjyeP9imqJ
 Vn8iF6+3klinPsfkplVnXNyOB2FXHDcjRHgiO1yw4VrNERiq/pvq86izu
 gu8ik1181RfXe8XweWw9yXVXspc4XAIIn/r8iKUq6FmLrWQVrJO7tFhz1
 IB86uH8CRRd5xnvp/dm9OfE0f+y6yAuGsswl1+37+V+5UEsD4RmT6zGW9
 MwXpcIQezr6gtrFkq1Sf/dmi2sM6CdCqnhJcmE7AgeeFroMXpprYjqubO
 W1Lq21HriqvwXidGcE5I/AQGxVJvfjnnb28sVtPgEid00HMfT9CA3GYgt A==;
X-CSE-ConnectionGUID: IZIH7HsfTJeV5Cegofv1Kg==
X-CSE-MsgGUID: ow3ipdiMQXi+gy7j5h0pPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="9770"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="9770"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 01:02:28 -0700
X-CSE-ConnectionGUID: GV/bJ036Q1+d753hPT46Eg==
X-CSE-MsgGUID: 6am69iYST8eWxC/xNj+aZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="281863313"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 01:02:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 01:02:27 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 01:02:27 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.30) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 01:02:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bXVdppuL4h8Bu8xlM9DeLUyV9D4mYwDpSyGXZiMNoBJ1nbpz5c6qjMwKow54fY4AiLRcjD4PWLxZkp6v6/7Vdna+r4/As0FTUp0seEZR91bjrwwL4Ntlwjj6tXJvNsq9AiheFeRPNGjwGIoKAbBjfPxbNm7mO89CTE5URBiKkvkr2jmRtPA9LlRfKkdEfezM4ZsOKWVR0AgZSa2lPNV9aWlBN1P4Ra2uQgzDtGYkG8hKPYifnrqdIFAPVlfyaPk4qJ8j/wmlACwAZTVWJqiapqV3YwRf/llSscgt9upxv5bk47UAy1mI6gnj9O3RKsncT1k+WDmkWOCnj/Xh8rWzqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgZveKb6fwUUzGFWM/+uIt+7QVq1cgxZhRUWX/1+Q6E=;
 b=C1sVTX2kMzHF/xHqOUit8COJ7dk7f0fNhuLxHU/r9nDnGXDJKP5iZkEcp7Rl8NVrypVeTvi5OMHQSp+q8LPcIr9FFoBxxLEL19i1PS6vD6vURJ8KALcTQlb2GEDZVHiP5N3UHUOmg3fV3Z3/MB8VgVJWWY4QKxd8lSEZdpzlFfCYQgo5/DFgOQaQWXPg+JkSdE4x9XICqm+OSQMDPiiohpPF2mv4ikLb+A3tCMKTpICHkvn/ou61rueIo6Sj7J5Rhwq7ZG/Omc2uM8eYST5jwh+hhraPYKtERLmtbK6jIGmBU0RaXdwYTqT0csQHZcvTgg4ZrCci3gFMHzcLXhCzlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by DSM1PF8C3EF9610.namprd11.prod.outlook.com (2603:10b6:f:fc02::149)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 08:02:25 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 08:02:25 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Joe Damato <joe@dama.to>, Wentao Liang <vulab@iscas.ac.cn>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "kuba@kernel.org" <kuba@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "sln@onemain.com"
 <sln@onemain.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] ixgbevf: fix xfrm_state reference leak in
 ixgbevf_ipsec_rx()
Thread-Topic: [PATCH] ixgbevf: fix xfrm_state reference leak in
 ixgbevf_ipsec_rx()
Thread-Index: AQHdRpXAvvswkXsWq0yPUwugayVj17bmXXwAgAnnV8A=
Date: Tue, 6 Oct 2026 08:02:25 +0000
Message-ID: <IA3PR11MB89855391A93351D625E893378F952@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20260917111418.2148632-1-vulab@iscas.ac.cn>
 <arxcOtu89COHAncp@devvm20253.cco0.facebook.com>
In-Reply-To: <arxcOtu89COHAncp@devvm20253.cco0.facebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|DSM1PF8C3EF9610:EE_
x-ms-office365-filtering-correlation-id: 7268d8ec-cbd3-42ab-b248-08df23802871
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|38070700021|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: t0QlzkeuUYU39KU0SlpXsrQNJAXykYo/XucEv/H9oU0UpLTY82xfIB1gsbjOYZd8UoFaR+VUBwXEvkVlM9cHwP5KDXwFsjA+QX7lJcYpru9JufYS+5lW1W6Wu5BVBfk8sYl5cKZ9ELrNNFd1Q0Frtoapwm0nK5XyebTCdDrFpN/6Tkm0y/hUbQn8OrDORcPAg0gE+9/6LQQXm60XUs6NkAS7MXtWu9dEetmAWDUza4LAHu6NNhxt1NCYvO+VdK3hlg9jEHUSBO/CCt4CM+XQpzxq0juVoDj9ytcy+idVID7AxGuGwCHA+5Mjs5NQ8g8K0a+W1VzQhNhHbgXr0ccBGpTWtXQi70W6MQaPbNIX4xA3q6ogaSaEVipyUCbOPghOTIL8mJX4f1Ta0v0+LrsZpIAdjyNKrqS7BGpVlRYC5GLAaz/00Xj8QKekUDtPhJuhe4ugu7hJ8oziHL1VIHLdHK5lqaL+4DtqhLxScq0RNORDXSjrMUIz+9erT769ciSlrWcbOYtRSGbF3hwxSO79enjkcJywgL5MwTMGzB1JNb38wxmd7pS2wCJiNdWln5CQHdzQgYsS4A/IrmOZLLSQqHJtCwHXfGj3Boe170l89awq2ZFGVucJ4TUFCVlUXYqyIPaAoe1+sOoxRMGew96+UWclXaFrAPft+xfdoGmjiP2SNSD6gUBgsOw5RqEqXE5xNmAUqSpNAa+2ibqoP3rzt85LXJK8+hYfxOp1q/wnnLw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8985.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(38070700021)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0HzzxcEwykBFcnsiG3i1ODZVzXNzCHMBR9b4wgaPFoeZ9yugb9rbyan41WTt?=
 =?us-ascii?Q?/gKEN8/xa8uXzNTIOiCD4uQx7iEKsKwHgZFOWFzlGi0GJxsl90jChaii+aoh?=
 =?us-ascii?Q?vhPos90sweUWrGmc7YKH21HJMp/58hWiK0ryTUuNqrX8A4Pu1lI2XOR7EbW7?=
 =?us-ascii?Q?T07+5WmRN+2DVrttghsWW7QBul8bkTve3FKqydUPWbcIr7S0JI3MPpg+5Rkz?=
 =?us-ascii?Q?92Qu9oDlc7/mmR7viwA6S1QdRIsA1pdi1T1lr54SPXPoqAx4nyzlzRGNofrP?=
 =?us-ascii?Q?KBboJX9AepoanB60Cbe1UTKdsB+wxA40+82xUk8idJjbfiUIfLDvcc32Eirf?=
 =?us-ascii?Q?5rMCLMIUrGIO+K5f0M2rwkFrvUSZvK8MZRW3/Wr4MH67U39lGKqYR+3Yl8O8?=
 =?us-ascii?Q?tTWJ2F1OR6wwBm6PMwc12uYsKMBFQ7dnDIpF82MROP80T73lL+MfZW2w+3vD?=
 =?us-ascii?Q?M6SW4lemmY/9Lz1NPk/RyDs7NCAB9Pl+HNf5KhSfn5ltpF7TLV3vPKilx4rM?=
 =?us-ascii?Q?g41yDmnuVcMX4Sedz+JZ8wag8hH97+AGhQvTeMhR6rkmUZIPSWVLM+Sq/Zwg?=
 =?us-ascii?Q?lcxckXKuvwmm+3w+F0nEbtosKN1h0HmjhcK+kInows0dgCicVaWmIaKDYLyK?=
 =?us-ascii?Q?ZcpqeYER0qc3LCB49RwdTJtGoPkaY8zMLRgP9tJA/e9TwQnkgZ0Y25gytI6n?=
 =?us-ascii?Q?Uph4DNyXX7A0hukTq8+tOqKzJ7XBTEZTnBvP2xKTX4kt/qTZCBNQ9Uc570j8?=
 =?us-ascii?Q?MKCIOCv9/B2nTpmDJSLJ0ikrsfa7oJAQImuo/zrkVerLQQCOxNyZr/JxYac+?=
 =?us-ascii?Q?OfZF9Niqj82opkawHtwveon/hDtbTxS4rgYXSmRtpzgXOwC13xYZLViGycS1?=
 =?us-ascii?Q?Qo3FrVQj7b9PN+Ho2anHmZZ8d1cVHQCHPtC3R+bTAUmm6Zi12jL7KV+noUwz?=
 =?us-ascii?Q?XGEFwf5UucG+fgC3yS7zF6uaruo9NRZIZ6AnRQLcU/0bxOnVCvkykLawZy1H?=
 =?us-ascii?Q?jFXn5e2EDIGcstFFC3x0Mip0JSMyhqdh6N/e0YXQdDjtkyyP4lrZutYGJb96?=
 =?us-ascii?Q?iefHsyAogHI65P43OHvjwowPOtlQl6a2degutb6by95FNyWfD+h1vcyILRDS?=
 =?us-ascii?Q?lEHj7oAUDt923krtwztjpnnrKHBDgEJhyWFnZSMJrXIygZCmOEtP+Zat3nV0?=
 =?us-ascii?Q?jR2rk8u4EiXDAMZHo4wKqBdHoydXH+8l8NNYAp6ZWGW6g7PILM6A86XAK0O3?=
 =?us-ascii?Q?ki6l6+gzu9mvA9uiNbWCeyz2BusSD/tYB5iGIYDeL+AgHFKV5cmfLV7c9xz5?=
 =?us-ascii?Q?bdWneetYURaRwRX1AqyS9lw8QgK3PXLpXZO5q0zj3TKon76jqrPE1BPIhjEj?=
 =?us-ascii?Q?KVwThV5opj4RtiBZahOP85GMMsfF691ilNa2xXAsxYf0Sr1bjYBZEQSiy1xR?=
 =?us-ascii?Q?0XdJlhwtwNYciTas+5kI6ob1l5UgP+PvMIp/7LlSE0cwQilsVTbXt8cqwY4/?=
 =?us-ascii?Q?MERLnKBw6bk1pXalLFb8tkA7BRirVq1BzeY7xcr3Xql6N0WgzgbXBXAKZf3q?=
 =?us-ascii?Q?e6ehpFvukZTpMLFGDz8rDAolkibJqVa4Nn4ISKewntQODfCGu8qZZ1Pg7q7c?=
 =?us-ascii?Q?cUg/MQio9eFcogVXwi0wK9fimMa6nMfuhkui+mJ02a+6VjH8mtDjxfvvYOHv?=
 =?us-ascii?Q?L/q9lQofbKEkq6YsLQHQcn7F3Rspn4i0HDX5vRXsE9fnt4KhMT5EUp2Xkeyi?=
 =?us-ascii?Q?cXAv0Yg3vQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pkDXXOOMpXQxiiRcGeIMCoB96OIFQmjvNU6OuRib48BQgfA9ug0ptUacSUack/Oj711B56C3UnNXgCrurKTez4v/J/ezWGTMAOnaDNv026r8wKcIh3BP0z55v8mS2KanY28n0DAvi3HxBf8JzBElmD99+Z8mpePODC9XTp1ocPAWmhaQqQjVaPpOXwUwApZlorfSam32GUVMWdX2ctzmxnJraO2U0Tcqu7uRF/CtGuHhucokvSq5itYsidV7lXZf3h35g/zO2d5DC9Wz9M/jj9y6rb3vtKTGcWLYy51cM505axe7DIgdGeQuaztxpxeClaAcaMLERZLdMiYjbmmVZA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7268d8ec-cbd3-42ab-b248-08df23802871
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 08:02:25.0712 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4J8RuYhu4HJP7xOPCOS+r/MLnA8V6K53at20Y3ZAog80X3qZvvsGLy0YfS6wHob19SNS1/3Q2YeiBzbCvJchiTW5CMlp5LtKjwEYGthZ/VI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSM1PF8C3EF9610
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
> From: Joe Damato <joe@dama.to>
> Sent: Wednesday, September 30, 2026 2:48 AM
> To: Wentao Liang <vulab@iscas.ac.cn>
> Cc: andrew+netdev@lunn.ch; Nguyen, Anthony L <anthony.l.nguyen@intel.com>=
;
> davem@davemloft.net; edumazet@google.com; intel-wired-lan@lists.osuosl.or=
g;
> kuba@kernel.org; linux-kernel@vger.kernel.org; netdev@vger.kernel.org;
> pabeni@redhat.com; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>;
> sln@onemain.com; stable@vger.kernel.org
> Subject: Re: [PATCH] ixgbevf: fix xfrm_state reference leak in ixgbevf_ip=
sec_rx()
>=20
> On Thu, Sep 17, 2026 at 11:14:18AM +0000, Wentao Liang wrote:
> > ixgbevf_ipsec_find_rx_state() returns the state with an extra
> > reference, which is handed over to the secpath on the success path.
> > When
> > secpath_set() fails, the state has not been stored anywhere yet and
> > the reference is dropped on the floor.
> >
> > Release it before returning.
> >
> > Fixes: 0062e7cc955e0 ("ixgbevf: add VF IPsec offload code")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> > ---
> >  drivers/net/ethernet/intel/ixgbevf/ipsec.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
>=20
> Reviewed-by: Joe Damato <joe@dama.to>


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>

