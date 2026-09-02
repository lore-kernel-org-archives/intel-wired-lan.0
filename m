Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC077C624D0
	for <intel-wired-lan@archiver.kernel.org>; Wed,  2 Sep 2026 08:44:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A17D80EF9;
	Wed,  2 Sep 2026 08:44:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ik1U4PX3-zoa; Wed,  2 Sep 2026 08:44:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788338681;
	bh=BSXnyV5NFoIqNQiD4+bGUMFA1mCVYw1D+7p7lkYWeTA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vjPAOsi36H//bh824PB3iAoPSInwcDkuU0IZK1Bm5Gzaa4y1KBw7rLsDPsn/YUAMV
	 dgx8NQGyCFnFDbElJmeQricDh84R2+EmhzQxKaLS/o3G8bO58jCI+C4oz5D9aANmjt
	 nndhxn2TzF57dkuLTyABvrm56fCD/XOu2McKqLeS4gjhQAVH60IzGB3iNShz/VlzIw
	 LVsloY6pZS0RdcitXHy8WlACApS5DmK+Tg5nv+R4OGjJX8KUAos7j6famZFT+wLmwa
	 ZUndMxluVfod6nwhLnHZ6lKcJa9ntcMIH4frUOEFJvpw23IymSvau96Iea9giCK7b1
	 YjHXrEFUBgRcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EAD8D80EF4;
	Wed,  2 Sep 2026 08:44:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0161E363
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 08:44:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DAD014031A
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 08:44:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3kMntWKFsxfh for <intel-wired-lan@lists.osuosl.org>;
 Wed,  2 Sep 2026 08:44:37 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=avigailx.dahan@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KDu+Tav4
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7EEFF40310
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 08:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788338678; x=1819874678;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:mime-version;
 bh=kJEw5it4UFIE6Y00AmFS7HlO7Y8mI+KojH/qk5OVTV0=;
 b=KDu+Tav4IcS5A7Wm3CTUivQNZouqP5ZnYdcM9iwe1Z4aIwg1h99CipUg
 Sjk30kQwcfYGRt6qDHIf+4ZvZEKjsWMMh5hc3426ViporO9uLqvf6s6uE
 8TthQPDrswtRIipvLeOuSiZ3Vp6gp36ARx8Hkin3opm1yam5KsGOsqJIY
 ey5puQIl5zsvSXlcdWuJq9GlCEfzDBY34QGmE4xETI4lDq6MNJwR4gtJ2
 bRZx8RIiE0xrK4oVhgYI0P1eOPvin8qA3/S1H7Y8SKCNqVOiMjRdwZ0pX
 BLKcB4YGZ9S582+fWPr+6BR7XKqRLVbx9Kn4gYLlHi2ccepr/sDX6oPMN w==;
X-CSE-ConnectionGUID: 5WbFjPrnTzyT7FLteSb1UA==
X-CSE-MsgGUID: 5Kja7e8JTzeJRewx1RoUnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="100144868"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
 d="scan'208,217";a="100144868"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 01:44:36 -0700
X-CSE-ConnectionGUID: cCWzvd+5RZ2HSiGDzVrCng==
X-CSE-MsgGUID: hk/gQVHVTA+Tnh5Crch18w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
 d="scan'208,217";a="299221921"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 01:44:34 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 01:44:35 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 01:44:35 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.28) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 01:44:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hidpCbPfwW5VQT6z3H1oTNvIY9Ib0YWG8vK+/wNn+l/KdHxVbx0saxbEI1zYCWmplAZeIZ42+C4U49y3GSUXunWhcDVDEwe4OVVgKVxEXLr/dNKlpqlAoJifMBy1T7v3WodxgNr3rS+oclrV0BKBCf21AzDMNP1debOI8pAUHeqoox/nvppRSfZUjQsw++XwYTk7RWAD2byx109YGvhXb64HPb+cNUDw3mBMPTyi/7HbfJE3H2xPr/Gqbc3pHYn9So3GfK+F6uFVShstuE8BzXwFw7GIpHxmRizFqYTNl6g+0Mv9DD++rAoorB1MJjRuOq/8hD5t+Hpce6lZl/6xvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwN4uPnVn5XsLo+GAkkR7FNpaZQBmegIb4AT44x/+WE=;
 b=hZPZgvGbqAoVHjFlVKb5iRS6Wvg9Xp2JSIcomUB5yi/7pBDHEnonjyRZSs7IhhsHCRCCa07m/7U6prss3Q1YvnsTa9t4R2SjYk1pOnBRTJzcl8AHsi2juOnwBMUGt1Zgv4LTKkE/QfD2OD8PUNxeWzpVS+gtK9faHzLcxACe/KQj7V2zklRl73bBVvh6Nts+2cc+wmqkj717XOzeZqTeuKCVq0boSxr+bOZwLzgd3ZnIiZI0tgRmVVkC0017AJye233MHGr07RKtLJYl+TgVdtatij3pVinBs92dJykZ8a65QTHtgT6vRVa/2mg4reOFAYXtWHJEeiHZgZeRcTH5Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8013.namprd11.prod.outlook.com (2603:10b6:510:239::8)
 by PH0PR11MB7634.namprd11.prod.outlook.com (2603:10b6:510:28d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 08:44:32 +0000
Received: from PH8PR11MB8013.namprd11.prod.outlook.com
 ([fe80::26a5:58f7:7e5d:5572]) by PH8PR11MB8013.namprd11.prod.outlook.com
 ([fe80::26a5:58f7:7e5d:5572%6]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 08:44:32 +0000
Content-Type: multipart/alternative;
 boundary="------------hhvocHrnXgQdmlFIXL1y3zVY"
Message-ID: <d5ac4129-fbb1-44af-be31-41859587f705@intel.com>
Date: Wed, 2 Sep 2026 11:44:25 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] igc: only strip RX timestamp header from first buffer
To: Paul Moses <p@1g4.org>, <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <maciej.fijalkowski@intel.com>,
 <andre.guedes@intel.com>, <vedang.patel@intel.com>, <jithu.joseph@intel.com>, 
 <richardcochran@gmail.com>, <tkusters@aweta.nl>, <stable@vger.kernel.org>
References: <20260825235530.3278670-1-p@1g4.org>
Content-Language: en-US
From: "Dahan, AvigailX" <avigailx.dahan@intel.com>
In-Reply-To: <20260825235530.3278670-1-p@1g4.org>
X-ClientProxiedBy: TL2P290CA0027.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::11) To PH8PR11MB8013.namprd11.prod.outlook.com
 (2603:10b6:510:239::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8013:EE_|PH0PR11MB7634:EE_
X-MS-Office365-Filtering-Correlation-Id: c25b1a37-bc37-4e52-9967-08df08ce68ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|6133799003|56012099006|11063799006|22082099003|8096899003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: opW6S5KxrcWIUWTTk+E2v9VP5GSA4ubgtb375nefMDlDSJquolT8dOqKBRscOcWa2hEdK6i6984goQ01frSvr3zoKDx8kdhuxcpUp0mGxiLQkFDTbwpqdTWCoKL9hpevPGc8aBc4UkYyrNxzMMF07pUrssdW5DktgdJKB05zaxqDtCto2MjfWgxvvTeAwFtJlXPQizC8S8aF3FxVx6yswRuSmmj4yaJPq2ZOuoqra6qLQ7wb43X5DRCLUd21OAOdJl7hmnlrim+DaGwH/81+5pHuNcIfEheGRqMukkSqTQHgNBa6gDYVg+KM18tBT76b6t/Cjn6ImFcfzFGtoed8Gbz6Q82TPASXrSg004GI+XXkxERq3YiwqG1Ofv+MGwFb07kCkziUeB4Vmpy9dkTeGquFGPQilSAuZ9sMW8sxsB/IsYWUD5jaWgdHg/y+vAoJIvr43FTsz5lPyyKFq98lMqqTGGS8pjMAdBtzaQLJtIBXekqwJO9rxGJ/DKZaEJeoWeIwug9ho6bw8YQ091CW6W/22NOnZbpzNnPKMSqA6+A06vbIYbbUKiLteV6ALM/GCj11ATNMks6cSOy5iTNB6344lTQGqGzIBvtI7RnU0EJVdBC1VItf7T7ZnM8ROdQv2Zf3ya3Nl+yicNoMcrqdMHRIqpK5grbxWMOu1LcsvFs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB8013.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(6133799003)(56012099006)(11063799006)(22082099003)(8096899003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QytLbFhUQStDNnVLNW1XeHAyeUdMTlVEUFluV1dxcU5mTkFTYUUyS0t3R1k1?=
 =?utf-8?B?VFQwbWRWdkRVYW1vcThMdUVzRjQ3WlUyQ0JJRVYrMy9BR1pXVzJlRzhCSzRa?=
 =?utf-8?B?bWdmdlpIL0pWT2NWRWJjbnJZQXA1NVJ2R1VHeGRtN2hBRzRQMm9XN2hCS2ZJ?=
 =?utf-8?B?Y3paaHp0dXZ3R1NVYURLV2RLSUZDQUJ2T2F1VGZ6VHovLzV1cllXcHVqd0FZ?=
 =?utf-8?B?SW9ub3hiekZnYVFpMUFhS1hGak1RdWN4ZFJrSW5ua3NuSkt6ZGVrem9qUnRE?=
 =?utf-8?B?SENKdGkrWjFad3BxQUl4VngrRzZXdStKWXRJMnU1Q2pBdGVmaW5tQVdCQVdv?=
 =?utf-8?B?ZUlOZDlDS3oyQ2lBZ09MOWV5UUF6S1lSS3lwd2xFRkRXTlJlRFFMeUE4OXlF?=
 =?utf-8?B?eDFxTkIzdUhUS1F1Z3hWVnhuTnRNaHMzdnJvM2NHQzZVeENkWFg5ZkxYNFdm?=
 =?utf-8?B?SDRQaGVobGc4WCtCY1RsM0IxQ1VDazJXb1l0dU5NTVNzanhjbXRCWVFsRzls?=
 =?utf-8?B?dlVDRkg1dUZ3dm82Q0MxNlYyNXA0RmVMMzNVbUgyOTFQbS9qV0JZUThLYTJp?=
 =?utf-8?B?YkpiWnE3bW82STEvaXJpNEFPWUs0dGdrZ2tjMTBUZmhlakJ4TVAwUWxWaEtB?=
 =?utf-8?B?b2xWS1BscVhWNFZ1SEhlMkRYQ1RDbHloamR3bGpxWHhEUWYveGR6SUEzMSts?=
 =?utf-8?B?dStFZHFsd3lQdXhTOTl1NE9Hb2FDQkd6aXJxRkxLVkxPV2xtNkxwak9WUm1D?=
 =?utf-8?B?bXdFdkRIUTROME5IZ2lHbmpXWlFyVTVicWZFK2hjWWFUR1h0OWRPZDh1ZEFq?=
 =?utf-8?B?VXRGTnhmSkZVeDhOa2kyNkd1U2lpbGpISCt4VzFyWnRuZ053Yno0bzdIUGxT?=
 =?utf-8?B?VVdBWE4wZ21teCt0S0Nkem1EbzBlYzJVWktGMVp6d095ZkUxRDJyZSszRVhE?=
 =?utf-8?B?RVBaeU5MOUMzZXJBNCs3S3FOSEh0b1dRREJEYkhpd1RLOFRRL09xV1lUcmZu?=
 =?utf-8?B?ZVdkbHlMc09RekZuaTZEdzFVaDNHNFcvNlBkY1RBMGJhWENtMjNGdnNUMkpV?=
 =?utf-8?B?bHZKOFVGSHdJK1dkRGU2UjVrN3RNSEQvbXpPVmZDVEZJV3hlTjl1U0xvR2tl?=
 =?utf-8?B?cWRxaWRJc3VBL0RLU1BUQTh3UWRRZXplQ1JUaDV0cXpnUDhBOGVsVVZacG1G?=
 =?utf-8?B?SHBtMjgweWJEVW5hS1FETk5qdVNOVDRJQlZVOUtrcDdiaGVTcG1OSEZBcklt?=
 =?utf-8?B?OWYwT1R4eG43V1hkWUt2YjhHVktPRzNvK2l0bXppNmwxTmR3T1JpUXFBNjRC?=
 =?utf-8?B?T1hBVms0Qkx5MElacGxaTmZHSUNtQmdUYm5UVE5tb0RTeVp1aFVJUjdTazBQ?=
 =?utf-8?B?dG1xd01ISXEwaWdSQi9ZYlQzTUt0d1FLd2l2U1NJUmNnUTljZ0o5NC9sOTVs?=
 =?utf-8?B?ak0vTTJIVHBmbGM4T1Qyc1VmbjRxZTRRdDU3ckhCVmt0RjFZOGJUU0FpZVp1?=
 =?utf-8?B?OTI2TGE1UTUyUGdjNzRXeUtCTDNlYksyMFVkZVMweElXS0xTM2o3NlhhUW5i?=
 =?utf-8?B?TndMNmJab2gwT21SQ0tkSE9RVEQvQXBJa2l1VEE4TVVvMXpqZXJYeEMyZTd5?=
 =?utf-8?B?TnRsRTh0YkdadU45cFVveXkwb2NiVlhwcnFla1BCcldibWFHeVAzZC9seDUw?=
 =?utf-8?B?YjRFWHFaMlhxNjRqRE1Ed0J6OSt3dFhYRzRTT0hnZU8rcnFXUXkxRWtLaEpP?=
 =?utf-8?B?RWJPUUVoVU1HUjBLd2ZGWS9GU3pMLzVFdDZSQjhGZTQ1WVhOdjc1VllGSEFo?=
 =?utf-8?B?ZFhQWnk3SHk0RkQwR0llN2hQM0xHUFoycmw2VU4zRGplV1RnN0xuMG84aThM?=
 =?utf-8?B?NWFIaEpnaFBQU0lOL3QrM0lqSFUxWEErZUNXZjVJWmZBOGlCdlRhRzBlMXBw?=
 =?utf-8?B?SUgzMHNFdEJZczN3d3FNOXE0UkVwbFFaWml1RGpySE5pNGthRSs4QXBzYkNZ?=
 =?utf-8?B?dStJb09pekxJa2VJSUpsMy9JSHBTZERRbitPL1R3TXc5OEpubk5FaE9HYXYz?=
 =?utf-8?B?dmYwMFJYTkUxU29CWUh6Q1A3aFRXREVOSllyRXc5N045NkRJRjA0T3NXZFUw?=
 =?utf-8?B?dTB4b0NxemVteFBnelpBeXlkS3N2cm5pQ1hhZ2hVb3FnRERSNHAzYy9kN1Zp?=
 =?utf-8?B?K3VRdjJtOEM1NFR0K3p6VjRRams5NkxDY01DZFE0NWhkelVKYzUxR0FvRFFQ?=
 =?utf-8?B?aVh3dnFjNWZOeE4zVExTZ1BlNjFKYWhSb3RQWXdFNzlGTU15NXducnZzZFRD?=
 =?utf-8?B?amI4bmxHVThDWHE3TUt4eXM3amJXclJTVkVsZlNmZWJyZnorQndDWHpuM04x?=
 =?utf-8?Q?u4fz7dhDZnAtULe8=3D?=
X-Exchange-RoutingPolicyChecked: Xgms0BfCrKcCJMq1YSPyqIEXKTJDC7tP2qUiecoobKmP+/CZkTeT+gq1Q3omOvmzxCyeqBObp+Ot5Y4jnzKTY4aZ2+HTZCmxvDjdNuyipKucHlMBz92H/+ajXn9YZnMZFSvVZoTAq5vqEXEAKIpO2ZZkHIYBsKQqeeWlykulkztUP5LQNxEQ3SnUuKQFQ50LZvU5q270TQ9uBVFCw0RJ/Ur8rBCBubIi3BBz0qQ5D0yR5w4ABAI42TgH++S76JOgO0oIPuuLUa3POSP+xxq9LBqaSlFYGMlcFCsknD+3RRCNRobV+6G3fv/bIcQVMqhcCVam9eZLbX7d6m6+4Btbxw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c25b1a37-bc37-4e52-9967-08df08ce68ae
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:44:32.5260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jY10e4cmQ6Phe6dMawTCo6LnuZjaT34Pd2wW3VGMdd5EGA8cdNDntBp4DFG+wjtpeikFIjf1k/6Lgkyv+b08CA+xv5voXOjmmSiUTKlv1RU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7634
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

--------------hhvocHrnXgQdmlFIXL1y3zVY
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit


On 26/08/2026 2:55, Paul Moses wrote:
> igc_clean_rx_irq() strips IGC_TS_HDR_LEN whenever a descriptor reports
> IGC_RXDADV_STAT_TSIP. For multi-buffer packets, continuation descriptors
> retain TSIP even though the inline timestamp is present only in the first
> RX buffer.
>
> Subtracting the header length from each continuation buffer truncates
> jumbo packets by 16 bytes per continuation and leaves the packet length
> larger than the received data.
>
> Only consume the timestamp header when skb is NULL, which identifies the
> first buffer of a new packet. An skb carried in rx_ring->skb remains
> non-NULL when packet assembly resumes in a later NAPI poll.
>
> Link:https://lore.kernel.org/all/20260625-igb-rx-ts-fix-v3-1-99b3efa08dca@aweta.nl/
> Fixes: e1ed4f92a625 ("igc: Refactor Rx timestamp handling")
> Cc:stable@vger.kernel.org
> Signed-off-by: Paul Moses<p@1g4.org>
> ---
> #
> # REPRO
> #
> # Receiver: igc / enp1s0 / 10.0.5.175
> # Sender:   RTL8125B / enP4p65s0 / 10.0.5.165
>
> # Both hosts
> sudo ip link set dev enp1s0 mtu 9000
> sudo ip link set dev enP4p65s0 mtu 9000
>
> # Baseline: RX timestamping off
> sudo hwstamp_ctl -i enp1s0 -t 0 -r 0
> ping -n -M do -c 5 -s 8972 10.0.5.175
> # 5/5 received
>
> # Enable RX timestamping only
> sudo hwstamp_ctl -i enp1s0 -t 0 -r 1
>
> # Receiver
> sudo timeout 20 tcpdump -ni enp1s0 -s 0 -w /tmp/igc-jumbo.pcap \
>    'icmp and host 10.0.5.165'
>
> # Sender
> ping -n -M do -c 5 -W 2 -s 8972 10.0.5.175
> # 0/5 received
>
> # Receiver
> sudo tcpdump -nn -e -vvv -r /tmp/igc-jumbo.pcap
> # length 8950
> # [total length 9000 > length 8936] (invalid)
> # wrong icmp cksum
>
> # Expected Ethernet length: 9014
> # Captured length:          8950
> # Loss:                       64 = 4 continuation buffers * 16 bytes
>
> # Disable RX timestamping again
> sudo hwstamp_ctl -i enp1s0 -t 0 -r 0
> ping -n -M do -c 5 -s 8972 10.0.5.175
> # 5/5 received
>
> ---
>
>   drivers/net/ethernet/intel/igc/igc_main.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>

--------------hhvocHrnXgQdmlFIXL1y3zVY
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 26/08/2026 2:55, Paul Moses wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260825235530.3278670-1-p@1g4.org">
      <pre wrap="" class="moz-quote-pre">igc_clean_rx_irq() strips IGC_TS_HDR_LEN whenever a descriptor reports
IGC_RXDADV_STAT_TSIP. For multi-buffer packets, continuation descriptors
retain TSIP even though the inline timestamp is present only in the first
RX buffer.

Subtracting the header length from each continuation buffer truncates
jumbo packets by 16 bytes per continuation and leaves the packet length
larger than the received data.

Only consume the timestamp header when skb is NULL, which identifies the
first buffer of a new packet. An skb carried in rx_ring-&gt;skb remains
non-NULL when packet assembly resumes in a later NAPI poll.

Link: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/all/20260625-igb-rx-ts-fix-v3-1-99b3efa08dca@aweta.nl/">https://lore.kernel.org/all/20260625-igb-rx-ts-fix-v3-1-99b3efa08dca@aweta.nl/</a>
Fixes: e1ed4f92a625 (&quot;igc: Refactor Rx timestamp handling&quot;)
Cc: <a class="moz-txt-link-abbreviated" href="mailto:stable@vger.kernel.org">stable@vger.kernel.org</a>
Signed-off-by: Paul Moses <a class="moz-txt-link-rfc2396E" href="mailto:p@1g4.org">&lt;p@1g4.org&gt;</a>
---
#
# REPRO
# 
# Receiver: igc / enp1s0 / 10.0.5.175
# Sender:   RTL8125B / enP4p65s0 / 10.0.5.165

# Both hosts
sudo ip link set dev enp1s0 mtu 9000
sudo ip link set dev enP4p65s0 mtu 9000

# Baseline: RX timestamping off
sudo hwstamp_ctl -i enp1s0 -t 0 -r 0
ping -n -M do -c 5 -s 8972 10.0.5.175
# 5/5 received

# Enable RX timestamping only
sudo hwstamp_ctl -i enp1s0 -t 0 -r 1

# Receiver
sudo timeout 20 tcpdump -ni enp1s0 -s 0 -w /tmp/igc-jumbo.pcap \
  'icmp and host 10.0.5.165'

# Sender
ping -n -M do -c 5 -W 2 -s 8972 10.0.5.175
# 0/5 received

# Receiver
sudo tcpdump -nn -e -vvv -r /tmp/igc-jumbo.pcap
# length 8950
# [total length 9000 &gt; length 8936] (invalid)
# wrong icmp cksum

# Expected Ethernet length: 9014
# Captured length:          8950
# Loss:                       64 = 4 continuation buffers * 16 bytes

# Disable RX timestamping again
sudo hwstamp_ctl -i enp1s0 -t 0 -r 0
ping -n -M do -c 5 -s 8972 10.0.5.175
# 5/5 received

---

 drivers/net/ethernet/intel/igc/igc_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

</pre>
    </blockquote>
    <p><span style="white-space: pre-wrap">
</span></p>
    <p><span data-teams="true"><span style="font-size: inherit;">Tested-by:
          Avigail Dahan <a class="moz-txt-link-rfc2396E" href="mailto:avigailx.dahan@intel.com">&lt;avigailx.dahan@intel.com&gt;</a></span></span><span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------hhvocHrnXgQdmlFIXL1y3zVY--
