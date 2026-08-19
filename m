Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97B1C5B572
	for <intel-wired-lan@archiver.kernel.org>; Wed, 19 Aug 2026 23:58:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4796B80C4E;
	Wed, 19 Aug 2026 23:58:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u26iA046UvQB; Wed, 19 Aug 2026 23:58:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787183885;
	bh=eX/L4fITRrdgRXcVNmjqlPFqeC9Nhz/tpW88R31XBWs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PjUT8l07sO45b2tyymc7lMZYK8Trql/onLtWR4EgtoIwHWu5mRBdwCW+KVzZ03JKG
	 tALC8nFVnHjUYrG20ddCGJ/FKeu4VtQoXjzhlPM9ZNEwcE4RliMEGggQjm/8pmjHpR
	 fznRBJ24kyIanNB6Grcf7HAXnm9upFIHlVDHmqEGLNDdlFVxwcw21DtQo2sgvzsN07
	 Fn750e+XLdczdYgCU+5I/5Z9lqx3PQ/QkiqQKugtWsY+i117QJpsjYZu6MhOfLgbc4
	 ujWQnT8Nj+tLLLQaXftABvL9EU3aj15UI/ayhdBqoMQAaM2KfnnRDQek+acbAgxEWg
	 l99RuuszhHGKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80B0C80C45;
	Wed, 19 Aug 2026 23:58:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B1D4A2FD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 23:58:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 97C3860671
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 23:58:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BBsc8nGrV-ka for <intel-wired-lan@lists.osuosl.org>;
 Wed, 19 Aug 2026 23:58:03 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=anthony.l.nguyen@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=JDAziv8v
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 740F360604
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 23:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787183884; x=1818719884;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MgURTAa6bCuFXQv+GxnvsW2Bi/aKAy189XkxW3G6TxA=;
 b=JDAziv8vZAEZtc8F3k2Gbfb95oUflVkrvf+cdZG0Pcl87WNLtKtjBBgW
 BVnQF2CIA9rhT9dnqQNpALSZiuwL+d5Qt1ME+JJR8YB/yq5MceIp2ZhB1
 wEYuRhG673ZWILmTShP9EeUuxYUWXIKOFGd6buq6k575U3m0zA1OQNveX
 PejlS8lK5o5EFwgFtExEotVUDlood9h/qHX0oXWPUgGn9gLg1A//JiduG
 7yTvR9whUtoCbPVulQ1L9qZ/+o49AyM2WFqW1bb7Rnv1nx5e4UmYShRWd
 Ardpu3mS5OhIpCDgCuGUolaIDYvPokHpSCdqns/aAnLngthD+Q5dVL7UE g==;
X-CSE-ConnectionGUID: BvS3UVGNRXKfUChB2rC1bg==
X-CSE-MsgGUID: wOj1CMN/StqaEGKqtLujtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="113252912"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; d="scan'208";a="113252912"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 16:57:58 -0700
X-CSE-ConnectionGUID: x+RRPgpbSWafi7aTswiCcg==
X-CSE-MsgGUID: W/tVuUVyTImn75R03e5XWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; d="scan'208";a="289224170"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 16:57:57 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 16:57:56 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 19 Aug 2026 16:57:56 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.39) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 16:57:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWcedmDMeaOjPe8jjvY984K9rxEnAAY5GWZLSc/oYYH1kH+C0CY/0MWucV5u5mLEcTCs13JFgzo/2bnyxQPfVKnQftHXs74FY1zppCrko10391KQ/v9VSZbNt9TjoSY8jDa4phl5gCO53Ra+oPrVMSAtFUEDQ19hJ1lhJt+dFDknnMYQiWYhrLP1l5RVPnKES84Brho4Cw1/KTMCljQ0Dyt8W/xiUdkqe3bOOvPAJNG4ojrRcmY8tmicD3jaczK5qLLnJa1A6khXZhHHYJxHnyfvXR9G7yqgCzpEUwYhJjvz1y2X03rc4wirJGdcOmlObJtjKB8Fo5T0i0P9JlDSXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eX/L4fITRrdgRXcVNmjqlPFqeC9Nhz/tpW88R31XBWs=;
 b=bFCOabMzR96NaGn+qMkpdngAhp0VtqDlBRNp5FvH4vpJQN/iWZYD1fvq2RxIefPRuxFjyzgRc3Ym2dKltSFZ4S+2Of8LuNsfalQnWRemDIuF+8A/S4NgRd2+dVjU/xmLbvqhSR1HMEHxLG5V9ZW7rXPW/MRhN9yc3yadZyRKqgr3Xpz7KwxxnqW6PPigKGWil19R5L6sxVG/nXm4oxDnW3pun6jPY84mW7YbL9IAVTwjyIX0p8st5t+Zc+Rq9t/amZxy0PmTCwlLs6dT6kf6JqxvljI/5Nl81dk6+QuoKh7qtCg3hqaxC2rB+qwTQBJTYmTmYOEtxexcv0Ddb1tZZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by PH7PR11MB8598.namprd11.prod.outlook.com (2603:10b6:510:2fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 23:57:47 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%5]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 23:57:47 +0000
Message-ID: <b7ca66c7-88a1-440a-af39-5c710577294a@intel.com>
Date: Wed, 19 Aug 2026 16:57:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] e100: prevent shift-out-of-bounds in EEPROM access
To: <pavankumaryalagada@gmail.com>, <przemyslaw.kitszel@intel.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <skhan@linuxfoundation.org>,
 <syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com>, <kohei@enjuk.jp>,
 <aleksandr.loktionov@intel.com>
References: <20260816113754.22900-1-pavankumaryalagada@gmail.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260816113754.22900-1-pavankumaryalagada@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0182.namprd04.prod.outlook.com
 (2603:10b6:303:86::7) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|PH7PR11MB8598:EE_
X-MS-Office365-Filtering-Correlation-Id: e3d8bddb-3bf8-48d0-fa5e-08defe4dab60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|376014|56012099006|10067099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: K/mZWc/ySX5OJinQgAebqFiF1S4l7vP8BWnNKLfSZYpzaa/zANnEe9KU07UxIV+H0luzPa6NnwYd2kRzkg+Xmqb4AsOoy3esab14eaW+xyFhZ/ec/rjN23NhGF9oN+QZWKgs1I9LneVXE7Gmd+h7C9a5FaBCYAGQUIaEv5f0BtagVhZ4BiVDElBzsS6s+fK3pAEdwO3bxQqEiU/Nb/SuWttPcxDorfIVWgSaMbFqdC9XaHyw1oOlShSzxKd8wscxVurKsq4Ez5AtyAZwRhT9K55G5BiP4VwNVOwnnGI2VUeSzTY/Hi0AZsBy5vwcNzoz6L0IhwlZ+6cSSaszWO6ryx+/osgGLHOLjoKVz00YcQVIZrXMOT4Hh98RPs0MmSig6CZBjN+r4/pXOXOLfCIV5Q6UoSZVFkKxembKJX1xLoSbN+hHg5QS235ntyL+e8ruErsYqqXjA2KkghQjzqS3h6Meq2Ds7+s9vaHZMcn4fg1RwXO2ixniQd23WLkfyxkmH3JkvcjXBLsPIpxHcQ5XWTKeS3MCqRgN9nIhSSnXziP18AN6GhE1nxpBRVfCHNcS+yi3Q9DnlsXBbcXB/hZverJdBrRcqUnWzJD7pLoOtpE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8230.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1I3a2h1MTRJQ3c2KzB5SC8wN2RPd2RmV0dqTWlKU2o2bnRPb1NCaFczd0FJ?=
 =?utf-8?B?S3ExWkJWR25PeTB3VFM3SDYrZjhRTG9nTGhnaEhEVDlyT0hvNVUvSnA1RlBl?=
 =?utf-8?B?MVJhcUdLQ0Urc1hFV0lvSXAvVmdjVVRHdFFJR0E1amZHcnpNcU1pU0VMK2Q4?=
 =?utf-8?B?R3RYeE9Md1VEWEdGcllRbHBORVluOVRyZk9wMUJ4Q0trL1M1ZzNjNkpvbllP?=
 =?utf-8?B?M2FYNkdoOXQzYWtmNDYycC9HczdKWWhzcHRvTjBrekUxYU9JaHVSc0VxbEQr?=
 =?utf-8?B?UG01b0JwcGl1ajZwMlQvQjhxWFlPVWYxdExYMkJTT2NJeGRxdHU1WXdUbDI0?=
 =?utf-8?B?N1FSNldmTnNDOGhKbktLb2lSQ0FmRGs0Q0tCdE9nU0tSTkNGZythV3ZDemFD?=
 =?utf-8?B?bmZzd3pjeTM4Y1BhMmNRb2NLVVZQbFd2QkMxaC9rZWFKdGtqUER6NlZWZWwv?=
 =?utf-8?B?bjJKZVByMlhGZ1NiSDFHUmh0dU9zemt2bU1LUW1Uck1nQjdtcEdocGJsL1JE?=
 =?utf-8?B?c2FKSTFON1hVUnRoRDBwR08rRS9BS01GSHEyQTVOa2pLSDVJTXJHME1mUFkx?=
 =?utf-8?B?cUJndUlCcjVPdVFjRVEvM0JWMm9EMmpKeWlJR2w0UHg0NlNaVTQyZitkam5X?=
 =?utf-8?B?c2RodE4zY0RtNW56Z2xqSHhMZmhXWTRiQndFQ2VGenBscWZ3RWRZOXhpS0g3?=
 =?utf-8?B?ZkpLaXEvUGR2SDBkM3JjVWRZbjU3Qk5oNTZmUWllVDJ6N0s5RUYwTGYrR2Vy?=
 =?utf-8?B?WnVzR0ZIdHQ2RitNTTJxaGFNWW1oYTlvRFJDVndWaktqLzZqdVRGYWxWYjd5?=
 =?utf-8?B?alRqU0V1eFJ6bWJveHJaTnpZblFWWW5JSkprZzNhZkNYYUdLR29wa1liMlpa?=
 =?utf-8?B?TTYwSDhlVWN5NUF2elBLQ3BYcUhVOWJLNmRXVGFIeXl3OHlnQm5hYll5RkVj?=
 =?utf-8?B?WGhSMms2ek10bFJMVEg1elUxdW8xLzh6d0phWTZlMDZsNkRucWdMMk9sRVV1?=
 =?utf-8?B?Z090cnk2cVpxYlhqeDdpWk5XWVJqeDFqZEgxcTNEeWVhRW9qc3kyeXAwKzU3?=
 =?utf-8?B?c0tOWExldFpycmozK0MzajlnQkttdGFlclNMY3pHOENTWFNIMlpWOFQrejNS?=
 =?utf-8?B?Sk4xbEkzSVlUaWVmTENzckpRWXk2b1Z4ZUJHeTkyTEdnM05UcXdLbk5VeUpD?=
 =?utf-8?B?RkJXY3czZDZzbVZmc1dUNzVaM0VUZXIyZGcrYlVkanF2UytzSHEzbmg5RXVL?=
 =?utf-8?B?cXRKNXJ1a3dvYjZqTE9Ec0hsUW1rNkJBQ25xTUFoZmdxaHFZTWxsV1VFVzhh?=
 =?utf-8?B?UjJVWjVOZVNNd2lRQjJKVU1odkFvZ2I4WCt1ZDJlREo3dXBXMnRKVS9pdVhQ?=
 =?utf-8?B?dVdremdwcGF5d2RNQlJlUlZKa083emF0QnhRYlg0N3FRWGNBNUN1RjRaQm9l?=
 =?utf-8?B?ak5PR0VMUzUxUjYyWXV0SFlSS0dHRDFoeVpwZFhGOVVoY3FYSmFKZVNzcllC?=
 =?utf-8?B?VVRZWkJ2QlAxU2ViQ2g0dG9FR2lzMzZpL3NMRks3eVp3WEtEVDlEenhOL3lm?=
 =?utf-8?B?MTVQbkxUdi8wT09kUWM4WGg3djhkVHRtTmdEMVBlcFFtdkgxV1pEUXlyaDVl?=
 =?utf-8?B?b0FuVGJ3N1NaU0ZaMzdkR3pOc1h2K0kwb25SZXJEY2d6aVJ6bFpiT3MyU3RJ?=
 =?utf-8?B?UWV1RzV0Y3BmcjVEc3BIOENQQXVManRzL0J5aDhoc21hdkpYYXZXUnF0SGM0?=
 =?utf-8?B?WHRueS9rSzcrNVM3TWpCOTkwVG02VUU0ZFdueTlkc3lib2RuaUpxRU9BRDlI?=
 =?utf-8?B?Y3laemVSd0sydnRCZGw3UlE5M3l0d0dMZlQ3RVZNb3lGdnNXMVZCUnFlT2o2?=
 =?utf-8?B?UXFjUVltWS9PTnVuOUFkcE53eXpSNUdZL012akp6UmxVRWgxYWVmT0k5b0JU?=
 =?utf-8?B?K2RxL2ZQb0hpMktqQi91elNYVFhtZS8rVE1VOEIyNlJnZVNDdy9CdmVqbmI1?=
 =?utf-8?B?eEU5WGdFWTUxcDNYVEVKM0R5N01ZbVpFUFJYdVpYRFFrTmNWSXg2VXRqcHdu?=
 =?utf-8?B?YXAvTm9CenRzaUhMeXdOS2gwV09Ka250V2wxK0VveE1ka3k2TWllTTdSR094?=
 =?utf-8?B?ejlOMlo2bjZGc1ZIamJXQjR5WlA3QW5BS21QTmZGUU92cVRZZ3MyRzBnL1ZO?=
 =?utf-8?B?QnNEWkJmTTU2SHFZWFRwQzhHQkw5ckRXS1Nsb1lOZUUyaXJ6SkxlbHU2TFJ1?=
 =?utf-8?B?UGlveFpWZ0s4OXhER1M3NEEySDRZTUhGN2ljS3hJVzI0cHUwK0RDZlVHMHps?=
 =?utf-8?B?ZlJyNVVUcHFaZTdVMThybzI1cFNlVGVxOTJsQzRkNGYzTUlxRHh3QWVlNUx1?=
 =?utf-8?Q?h6PhmHJ2TiJGohO0=3D?=
X-Exchange-RoutingPolicyChecked: ifP3sXfjcD7IKP5wKToXIyZYnjZtMX9/+NxxN8AVAfnC+0/sNLQCnMS9t16UUt6Pbv386hGXGybq/O/FAk0G8Vpd8kbTg+deTzPjsvaZfTUXd90B3eRC0Jb9C5ygfq9Bv5RV9uQ0UatgTQMuCTVCcgXCChw0LYWexMchJIuDC5ngI2heJUgA+mFoT2a4lzBE7pjWK+zA61xSC86kpLN0FWG7PT0F4ci8oGexE5jrjxdu/zqSLEoFh6dWcJbWVg6F0laSE+QRC5Sr07+Yn9rL4YwcuO+nA+4KiDLX1IL1AXwySURsWMBtiVv1nyK0SE90q5GmlFoGUBzBxfi0TbZqXQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d8bddb-3bf8-48d0-fa5e-08defe4dab60
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 23:57:47.6750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQv6UIw6Otx4PNza+LYsz8k56UQSK2uUHre8IyjjnB18OUmNkmhRNBiV9M8gNUfny6hbSa9YxzzsP7FQJBfpntPnesaDw7UARegcIIJ1Tvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8598
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



On 8/16/2026 4:37 AM, pavankumaryalagada@gmail.com wrote:
> From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
> 
> When reading the EEPROM address length, e100_eeprom_read() can return
> an invalid length. This value is then used as a shift count when
> calculating eeprom_wc, resulting in a shift-out-of-bounds UBSAN warning.
> 
> Stop EEPROM address probing if the detected address length exceeds
> the initial address length to prevent addr_len from underflowing.
> 
> Validate addr_len after reading it from the EEPROM in both
> e100_eeprom_load() and e100_eeprom_save(), and return -EIO
> if the value is zero or greater than 8.
> 
> Reported-by: syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e0abb1d45ac291ebebeb
> Signed-off-by: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
> ---
> v3:
>   - Prevent addr_len underflow during EEPROM probing.
>   - Use BIT() and explicitly cast the result to u16 when assigning eeprom_wc.
>   - Update the commit message and subject to reflect the scope of the fix.
>   - verify the UBSAN failure with syzkaller reproducer before the fix
>     and its absence after the fix.
> 
> v2: https://lore.kernel.org/all/20260810083355.21631-1-pavankumaryalagada@gmail.com/
>   - Return -EIO instead of -EINVAL for an invalid EEPROM address length.
>   - Validate addr_len in e100_eeprom_save() as well.
>   - Drop the unnecessary 1U change in the shift.
>   - Update the commit message.
> 
> v1: https://lore.kernel.org/all/20260807145626.52692-1-pavankumaryalagada@gmail.com/
> ---
>   drivers/net/ethernet/intel/e100.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
> index 464dc2d6cdb5..5165f1d3c98f 100644
> --- a/drivers/net/ethernet/intel/e100.c
> +++ b/drivers/net/ethernet/intel/e100.c
> @@ -746,10 +746,12 @@ static __le16 e100_eeprom_read(struct nic *nic, u16 *addr_len, u16 addr)
>   		if (!(ctrl & eedo) && i > 16) {
>   			u16 len = i - 16;
>   
> -			if (len > *addr_len)
> +			if (len > *addr_len) {
>   				*addr_len = 0;
> -			else
> -				*addr_len -= len;
> +				break;
> +			}
> +
> +			*addr_len -= len;
>   			i = 17;

It seems each version you are sending is change on top of the previous 
version. Please send all the changes in a single patch so that it can be 
reviewed, and applied, standalone.

Also, Andrew had requested on the other patch that this go via *-next 
since the issue is a theoretical one. Can you target this to iwl-next?

Thanks,
Tony

>   		}
>   
