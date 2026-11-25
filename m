Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A49606A32A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Nov 2026 10:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=EsSLHXz+;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HINjCJIw;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=j8YdDP3+
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D518680CA6;
	Wed, 25 Nov 2026 10:51:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J5FpaDqTwDY0; Wed, 25 Nov 2026 10:51:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A431680CAB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795603901;
	b=ViclR5lpegemu3y2IMZwZ82Hj49Ad1Ta/7JfiO2/wkdY8BUw1o+AofGTqwPmKDREIUF4
	 sq/jsysO2JaXkMlY9nJxIfV6LNRMBtaYA4Cp2NCc0qt3CnEwYzOxY10d8jjS18WTpo6Bk
	 MhOP/yZLFtqCdg2pnEm/+bXJCBjNG24T3uEkl56b9xwR3X5m+MEg9KxwM0OVdrZMXBSgD
	 Y82rzQHXKqtOEIokgLwaW6Jv8RFuI1GHLOpPOL/Gqo85SlcZN+Pv1InEb5kLGj4JUQWjn
	 mkVGiClKSGPxa9ns2U7Eq5yxgIJXWomWq9XRHkvujPBkByR3B3QEv/TTR9eblLnUsBg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795603901;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:References:
	 From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=72VtN+2xeR615hAsM5l0521pzcWN1yyeZMFu7TazXGU=;
	b=S1r+xUPpOXvl5iGmXKoPp3aw/fcT6CBbD3Bg4yNQI6J6iJ2Yemi0LKm4w/ERMQoc4u9e
	 RbrFvTNqgBW5q5dT1kqhi2ywLXWNDUAM9x5xk7vvuBiQO8M3+qkGS4Q5+hxyP2MiQkOHS
	 3Tcpv4B/BuKbzh7doCgpltk/5ZNTVEr6sII6rgvdjI28SgIhnMxawmMEG9xN7mzzQB560
	 NeLHZrJpL+0N5CIN+Tfp/h+iUKSMyoW8ZL6bmMxuk0LM0jvdWn86x6eRoJDjrqbCO63qA
	 VVoz/unACk8Gq5ILOjNoxQFi7u1UVrbuXXAYhccDZsmD5IimpwQbrz21yOohP/x5Oig==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HINjCJIw;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=j8YdDP3+;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795603901;
	bh=72VtN+2xeR615hAsM5l0521pzcWN1yyeZMFu7TazXGU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EsSLHXz+cso/Fc62TN+nmCGZfii7fN30rC//cMcpCrAhU+wZ6q6vJ22+BLyPCXCEn
	 7wQiircicXakqYkdig8KTWS7MwEi3Mz0rDIgE6pO9xYX350kYPpOGLSWZyza1qK1/2
	 romQ8rou/rrS4gh4hT+ov8i74b4RWy5z62wIxrcH+NkQc8Ng6Zc/2cHH7GG+m1n3no
	 k3uxJ60ekT6QbuFo1wRZRGeNbiAFNv8+5nGGWSzvd8bQWiSu6eQ//e16gAUnpMBAwl
	 7EzLnYY57uS38diZst901JEmjpK2NLwjqwM6g+78BjvzxK1JuFnANIAV0LUmjcViRD
	 AZ6SDWBdEMSFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A431680CAB;
	Wed, 25 Nov 2026 10:51:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B3FF81C9
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 10:51:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 99DDC80CA6
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 10:51:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yvihfC4CnHF1 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Nov 2026 10:51:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 04F0080CA4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=HINjCJIw; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=j8YdDP3+
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 04F0080CA4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 10:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795603899; x=1827139899;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mO+hu8rLZK2JVKrLBcBAJu6Esr6pNIbScG8aVS+Ky8o=;
 b=HINjCJIwYjRt+E0HvoJ4/NsA/iL0TLZKRNUCfoTbd7nkP33YgFhvYgss
 keUcmsKtE+pBwHyo2gp8GdssXt/cEEeRa70L0/9SMzWWb+Y2ifl6vap+X
 KV3+JfNXaAcAFEAnRYnHYoip+jgc9S2jSexCy8goD0ojmnVZQly/6hJA9
 REIqaDqAkutTcZHQ4wi2scLsJnWmzDf2Z2UGk98949ozk1YGQg51HrXl2
 njHtgsuDkyUB/rM3J6/l1gXcmwmon7gxm/WpWPcQE6f33vHwlSTot03PL
 aqYtadhE6PnzNbSePTmieAy1uDGJtmRknQ5WMQmkTdNq6sUlT4jDrVVkm Q==;
X-CSE-ConnectionGUID: RYlxTwsARYCasNujgHieRA==
X-CSE-MsgGUID: e13U7ba9S5+3pZ0xh3d+9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4481120"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4481120"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 02:51:37 -0800
X-CSE-ConnectionGUID: 6pCoGl3dQBK2mHfmJ6V5bA==
X-CSE-MsgGUID: bf+9vXXTS7G100ttOZiwsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; d="scan'208";a="11963084"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 02:51:38 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 02:51:36 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 02:51:36 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.18) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 02:51:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72VtN+2xeR615hAsM5l0521pzcWN1yyeZMFu7TazXGU=;
 b=j8YdDP3++bDv17MGGtbM3t7pDfapxbFA6Mc1Ozua68HlZdwm+9T1yUYG+uzfz0fgYBCw5IV0/ftZwxL+gS7UPcH17WDQfZKVTxjmMZ0H1fWgELWLiYnl6CPYt5mCbPD5Heow9nhB/UQ+UhCxMOeqG3Bm4Oq8Hb0T8CNqmbIspNs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8496.namprd11.prod.outlook.com (2603:10b6:610:1ba::22)
 by IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 10:51:28 +0000
Received: from CH3PR11MB8496.namprd11.prod.outlook.com
 ([fe80::5627:e3a5:cb26:b555]) by CH3PR11MB8496.namprd11.prod.outlook.com
 ([fe80::5627:e3a5:cb26:b555%4]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 10:51:27 +0000
Message-ID: <dfcfedd2-7232-4949-97c3-bc51d28c6131@intel.com>
Date: Wed, 25 Nov 2026 11:51:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2] ice: release IRQs and rings in ice_dis_vsi()
 when the VSI is already down
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
 <intel-wired-lan@lists.osuosl.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Larysa Zaremba
 <larysa.zaremba@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Jacob Keller <jacob.e.keller@intel.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Petr Oros <poros@redhat.com>
References: <20261124083506.14071-1-ionut.nechita@windriver.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20261124083506.14071-1-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0144.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::26) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8496:EE_|IA0PR11MB7185:EE_
X-MS-Office365-Filtering-Correlation-Id: e8af13d3-c700-4fd1-84ad-08df4ae203ba
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|376014|261022105027099003|261026121527099003|10067099003|261026140227099003|261022075727099003|261028144727099003|261021123027099003|261102123227099003|261021121427099003|261021135927099003|261009223027099003|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 138441awNYGD0KP6PQ81h62RzSO3UBjea0H4Az2cAtl4EjcuHNbEtm6mka6n17djQUo863J+qWrtjf3SZ/Rk9J5qhk/ev9CDjKtx5P75uUV7KKVgmQTATp7GHehMxNCt9lmynKPN9NqA5sAiwq3epYVFCKvok763te+R1sWwcEwNLuX1PjPOZ9cxbI0gNJW4hUlWlIeJmfflolQ3leHhAA5OancNLUKybGE8ZpjQ8meho9jzPfg/Z3zN82YE/XHynutNmbhXVN+JPfIJLBGaewfGWfcWW1dUJWhyiKgj0mYH9mymo2I5pDgAsvptgQLBXIOJEh3rXlzZx6z3eh+Sgja8XeBf7NFg2p0TA3F3KcSiCLMFThTMS8wGcHAzgJ5nY2Kn8HiN5y81sQTsMNehau8GN2OSok0QFUadSR0aBmT9JTPnMo4RQgUpPdOqKv22v0TSUagLLIeIIKgRWv8aBufgSlWIBavVQm+4+ScpWleQUvkaygPkZK1RXjdMyDwXXIRZ7Qyt9oSpbM2NnwqQRdse+FFUtL+TorDbkXoM4XAy8VMp8qxDLKo52NsRgYOy1YGWgcU0/2zuGpWcmNhjqIRvgmJ3o0C9M3tCrh2NeKwkrfLmGzmpfeNk7Sos5XWc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB8496.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(261022105027099003)(261026121527099003)(10067099003)(261026140227099003)(261022075727099003)(261028144727099003)(261021123027099003)(261102123227099003)(261021121427099003)(261021135927099003)(261009223027099003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rk9xdWlFZENpeXZVQXNOOUlKNzhLM0pVRkp5UlFwaXpWYVJza2JxRjhwVjFh?=
 =?utf-8?B?OFdTa1VRK2h3endhRFZnQ3pNRkoyZ25TWldlWTJBemN6VVVGZ2ZkNWErRmRP?=
 =?utf-8?B?NkxpZ0YxVFNJTUcwK3VGY04rRDloN3JnYkFsYjFZYmoxQlZyK05tMWJCc013?=
 =?utf-8?B?QWVGOFhJaWI0QUdyaTVvZk55d3dPVU5zOGdtSThqeTlQT2pGTkJ1aVNMT0ls?=
 =?utf-8?B?c0ZtSi8wV1N2RFc5Y2I2Ykh4UDZlZTd1SVhmVDR3VlVBbFNOZWUyclMyQzhF?=
 =?utf-8?B?TjkzY0I1eE9XVEFxMy9WenJscGJocGxWYlBIYzBwNTlBRmJmNzlJRVpJQzA3?=
 =?utf-8?B?MVVLVVh0akNWd3Z5VXZNVjZFcXIzN20zVG1LeVF2aE9mUEs2TzhOYzdNaHYv?=
 =?utf-8?B?MFFRVTNKM0lwR0VHNnZFQmlqdGZEcUNjMDRudWQ1OG5PV3FrS2VuRDBwenZ2?=
 =?utf-8?B?czR4NWdLMjlWSDJZa3h4dTJna3dEQVZkcjRkMGdzVko1dUxHeUJoOENxZG5h?=
 =?utf-8?B?M1VvYVJYMjJRZ3JKV0tYMHN2UlJUYUJpY1dpVnNVY3BheC9BWVlCWjIzeU5I?=
 =?utf-8?B?WXhHdG1aNUVPOVB6M3VDS3ozNUhHREhqVlFtbUZaQWRRQmc3eVA3SG9NdVVW?=
 =?utf-8?B?ZGY1YVc3SmVvV2swbUhiZFdhdVNMTzQ5ZmhybmNFQUpoUU01V0ttL2IvZlJS?=
 =?utf-8?B?ME9MSjRCd0lHbzEwa1NrV1lybFBaTHNhZVhqdnlmWUxzR001c2dEQ3FpS2pU?=
 =?utf-8?B?OWFYdkpOdmpCdXFqeFk0bnFqWlY4cTVLNTE4bjdWcUcrRzJxTlNhWVd5bHhL?=
 =?utf-8?B?Sm5lNkNDRjA5OWpRT2hZSVBNTm9rYWx6RTZubHhiUGRLemZqaFVHNngxTjZz?=
 =?utf-8?B?T05ndWIrN2xJWGNia20vN2M2SGI0R0NyclVmZElseEdlMVdaeDZhZXgwdzYx?=
 =?utf-8?B?eVV0WkF0aVozNDVFTjFJNnl1MVQzc2NNR2NtVStHWWZqemRKSU9lR2xLOU9T?=
 =?utf-8?B?NE1Lb1g5TGMzNCtscytLam5HZytHYWptSzlwTFRmMUtHMFg4OFhOQklOWFFY?=
 =?utf-8?B?Zkc2UlZoeUNYTGNVWDgyaHZJUkhpQ0M1TDk4Q2QydkZTWDAxTkcvZkxVQVNs?=
 =?utf-8?B?UTBDdXNCYmdNZ2JQTXZHSHdzVEpYcWo0N1VheUZ0eVFPZW43ZERFRVM1NUln?=
 =?utf-8?B?N0lmMEJsYm1GYi9vWGwzLzF1S1lsNzVOR2ZIRkZlV3ZTK0UxOTh5a3kxVE1t?=
 =?utf-8?B?T3ROdmpSREk0SEJYeldiMzBsNW9oQXBCeE5Ia21pS3hHU3J4QVY0bU9DY1BS?=
 =?utf-8?B?aE1lSi9Xai9LdXhLMmNEN1E3cFoybnI1MGhqVG45bjE1MTJFeU10cEhaY1di?=
 =?utf-8?B?ek5SU1BYaDRRQ1dYaVdIanlxVHczZDVsM210WHo5QXdhajNnRFBYU0NCWFBH?=
 =?utf-8?B?bG5rd2VNUEllQlR6elEvais0dG1KeE44eStTYTJNcjFUT1Z5OW9VM0lHU1Bw?=
 =?utf-8?B?ckN1RW5CWU9jNFpFeGh6M3BEVVJST2NndytpTk1JZ3V0UTlreEszNVNOcFlU?=
 =?utf-8?B?a1JyNkFnS05GTDlmSXhyRUhrODZtY3ZwalQwZERoNlRsSmNrMkVsM2JycjJt?=
 =?utf-8?B?dVl6TFpYRS9WdlNhTmFibCs3ZTZkaUdwRG5UNUtUeTVwczF2Y1FpT25Fdzk4?=
 =?utf-8?B?ZzlPSzd2WUtYd2ZZVjkydXF6THVsR0R6MVR5SzIrM084R2FuMnZGUmxPYlk5?=
 =?utf-8?B?WnNaMUdXNnh6TnkrL2paNFB5VGNzNUxGQ0JhMjdPUEx0U1dEcUZGVDM4MFhu?=
 =?utf-8?B?anFwa0ZsNktqR2FtWm1uUytnVXhKcDlkL3l3aTBoKzhJQTQwcjNwN2lpUFF2?=
 =?utf-8?B?UGNCSThOdnR0c2hjSEp6aHV0Y0Z6eDZySm1XNmpmak1aNkJjaWs2VG4rOVY0?=
 =?utf-8?B?RGpPQXM3Zk16Mm0xZEx3QVVyMmhqQ3JTTGJSMldjR3FXOVYvMU1XcWkxeEVH?=
 =?utf-8?B?alFjOGIvYnBwdUtjaXZVWFFrMTBJVHpPaitYa2tpZDZLTmpzaUgwdU5ndmFs?=
 =?utf-8?B?L3M3VEJtNWRZbTMrYzI2RnZwaDVRUGpwcyt4MmhtS3hlZnB5V3dzZVhsdWpK?=
 =?utf-8?B?RUJFeE5nQmFoeFN0T3dYb0VpNVdqRURCQ3B3K3Blc1BCME40RFVCOUxpN2d0?=
 =?utf-8?B?MjJlYVA5TFBaMERiN1RvR0l0Yko3NWRnNEtVWllnbkZTOHE4S2ltSjd6WmpL?=
 =?utf-8?B?bkw3aXJBZjgyMEZLSnRCTm50dlFGWXZyUnNLWEFCKzYvTGtwWnRjbkdyYzZY?=
 =?utf-8?B?UXZ3THFZT3pIVEdsREE1dVA1emVCQ2xwN1Q3ck02bEw5VEdYRFVjeUx3V2JH?=
 =?utf-8?Q?HlC2Gl+6A/QVCxe0=3D?=
X-Exchange-RoutingPolicyChecked: MLALFe5ah5v2hlnNyM3KpuiEVEGViYQYnakgdh/kSjxQAxImWZK76WmwcTXsnRp3sQa0Ygx2VGR35sAuL28sFL5OpOiktsIR6m57i8ZSIRM976Dj7lLfatJLNotwuMgZn0QHFbCW9fnFBOxgVR6A9FmUTJlYWEvmVqC4bpzE9CecLeWrpuAKRbTsvVdW6qblAKNR8DuBns794oytHJuYRPQjKBl/eGBcFgG1pbhUPv7jcKD5T/SaeE4ECgm8SzqBOIDzj51kuFZWEKmRkn5IqFS0v39cnXtKe9Y9Ka6AtSx+WsLMQr/TLiL1PZMNAt0gRdK8VXKhjoWSueO9t+GQyA==
X-MS-Exchange-CrossTenant-Network-Message-Id: e8af13d3-c700-4fd1-84ad-08df4ae203ba
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 10:51:27.6009 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4boZ6Pw+Xu/SQ32wskbJSapxIaCd2Sd+NM9FgdleGvSKo+vfgNS5u09BxARZTb/qsa85SITaTTxFRZDi2w2gf+RVeU55NjqwTTK030caL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7185
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/24/26 9:35 AM, Ionut Nechita (Wind River) wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>
> 
> Since commit d8c40b9d3a6c ("ice: check ICE_VSI_DOWN under rtnl_lock when
> preparing for reset"), ice_dis_vsi() sets ICE_VSI_NEEDS_RESTART
> unconditionally, but still skips ice_vsi_close() when ICE_VSI_DOWN is
> already set. For a running netdev, ice_ena_vsi() then calls
> ice_open_internal() -> ice_vsi_open(), which does a full open: it sets
> up the rings and requests the IRQs again.
> 
> A running netdev with ICE_VSI_DOWN set is not always a closed VSI.
> ice_down() only cleans the rings. It keeps the ring memory and the IRQs
> so that ice_up() can restart the VSI quickly. If the restart fails, the
> VSI stays in that state while the netdev is still running, for example:
> 
>    - ice_down_up(), when ice_down() or ice_up() fails (the latter also
>      via ice_change_mtu());
>    - ice_xdp_setup_prog(), when ice_down() fails.
> 
> If ice_dis_vsi()/ice_ena_vsi() are called on such a VSI without an
> ice_vsi_rebuild() in between, which is the case for the DCB
> reconfiguration in ice_pf_dcb_cfg() and
> ice_dcb_process_lldp_set_mib_change(), ice_vsi_open() runs on rings and
> IRQs that were never released:
> 
>    - ice_setup_tx_ring() hits WARN_ON(tx_ring->tx_buf) and overwrites
>      tx_buf and desc, leaking the previous arrays;
>    - ice_setup_rx_ring() overwrites desc, leaking the previous descriptor
>      memory;
>    - ice_vsi_req_irq_msix() requests the PF vectors again without
>      IRQF_SHARED and fails with -EBUSY, so the open fails and the
>      interface stays down until it is closed and opened again.
> 
> On the reset and mqprio paths, ice_vsi_rebuild() frees the ring
> structures in between, so there is no WARN, but the ring memory still
> held by them is not released until the device is unbound.
> 
> Call ice_vsi_close() unconditionally for a running netdev, under
> rtnl_lock. ice_vsi_close() already handles a VSI that is down: it only
> calls ice_down() if ICE_VSI_DOWN was not set, ice_vsi_free_irq() returns
> early when the IRQs are not requested, and ice_vsi_free_{tx,rx}_rings()
> only free rings that have a descriptor ring. This is also what
> ice_stop() does for a VSI in this state. The race fixed by the commit
> above does not come back: ICE_VSI_DOWN is still tested, by
> ice_vsi_close(), under rtnl_lock.
> 
> The non-running and ICE_VSI_CTRL branches are left as they are. In both
> cases ice_ena_vsi() either does not reopen the VSI or, for the control
> VSI, the only paths that set ICE_VSI_DOWN also release its rings and
> IRQs.
> 
> Fixes: d8c40b9d3a6c ("ice: check ICE_VSI_DOWN under rtnl_lock when preparing for reset")
> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
> ---
> v1 -> v2:
>    - Shorten the code comment to one line (Przemek)
>    - Drop the Assisted-by tag (Przemek, Jacob); an LLM (Claude) was
>      used to help with the code analysis and the changelog
> v1: https://lore.kernel.org/all/20261106171657.583713-1-ionut.nechita@windriver.com/

thank you
I've run your patch through our local sashiko instance, and it reports
that your patch adds new problems on edge cases. The same issues were
reported both on your patch just on top of netdev/main and
tony/dev-queue+some more fixes (meaning those problems are not "already
resolved elsewhere"). For the first issue (DCB) both my and Petr Oros
patches were applied (not yet on netdev main (aka -net)).

> 
> Found while chasing the same WARN_ON() in ice_setup_{rx,tx}_ring() with
> the out-of-tree ice driver on an E830 port without a module installed,
> where ice_vsi_cfg_lan() fails and ice_dis_vsi()/ice_ena_vsi() then
> reopen a VSI that ice_down() left with its rings allocated. The
> in-tree paths above were found by code reading.
> 
> Based on net (f66469d9905b, "Merge tag 'net-7.4-rc2'").
> Tested: build only (W=1, no new warnings).
> 
>   drivers/net/ethernet/intel/ice/ice_lib.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 7cd2dd066ef5e..92a086aa629d6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -2852,9 +2852,8 @@ void ice_dis_vsi(struct ice_vsi *vsi, bool locked)
>   		if (netif_running(vsi->netdev)) {
>   			if (!locked)
>   				rtnl_lock();
> -			already_down = test_bit(ICE_VSI_DOWN, vsi->state);
> -			if (!already_down)
> -				ice_vsi_close(vsi);
> +			/* ice_ena_vsi() reopens the VSI, release it even if down */
> +			ice_vsi_close(vsi);


[Severity: High]
[Finding: gpt-6-astra-7-20]
[Sources: gpt-6-astra, opus-5-5]
Can this free DMA memory that enabled hardware queues still own?

When ICE_VSI_DOWN is already set, ice_vsi_close() skips ice_down() but
still frees the rings:

     if (!test_and_set_bit(ICE_VSI_DOWN, vsi->state))
         ice_down(vsi);

     ice_vsi_clear_napi_queues(vsi);
     ice_vsi_free_irq(vsi);
     ice_vsi_free_tx_rings(vsi);
     ice_vsi_free_rx_rings(vsi);

So ice_vsi_dis_irq(), ice_vsi_stop_lan_tx_rings() and
ice_vsi_stop_all_rx_rings() never run.

A failed restart, which is the state this patch targets, can leave
queues enabled with ICE_VSI_DOWN set. In ice_up(), ice_vsi_cfg_lan() has
FW enable the Tx queues, and ice_vsi_cfg_rxqs() posts the Rx buffers.
Then ice_up_complete() does:

     err = ice_vsi_start_all_rx_rings(vsi);
     if (err)
         return err;

ice_vsi_ctrl_all_rx_rings() requests enable on every Rx queue before it
waits on any of them. It returns on the first queue that times out, with
no rollback. Failures in ice_down() (a Tx disable AQ error, or
QENA_STAT not clearing) can also leave queues enabled while DOWN is set.

After ice_down_up() or ice_change_mtu() fails like this, a DCB change
can reach:

ice_dcb_process_lldp_set_mib_change() or ice_pf_dcb_cfg()
   ice_dcb_ena_dis_vsi()
     ice_dis_vsi()
       ice_vsi_close()
         ice_vsi_free_rx_rings()
           ice_free_rx_ring()
             ice_clean_rx_ring()
             dmam_free_coherent(dev, size, rx_ring->desc, rx_ring->dma)

Could the NIC then DMA received packets into the freed pages, and write
back into the freed descriptor ring, until ice_ena_vsi() reprograms the
queues?

Before this patch the memory was leaked, but it stayed allocated and
mapped. The commit message cites ice_stop() as precedent, but ice_stop()
appears to have the same hazard.

[Severity: Medium]
[Finding: gpt-6-astra-3-9]
[Sources: gpt-6-astra, opus-5-5]
Can this now reach a NULL vsi->q_vectors?

ice_vsi_close() always calls ice_vsi_clear_napi_queues(), which has no
NULL check on q_vectors:

     ice_for_each_q_vector(vsi, v_idx) {
         struct ice_q_vector *q_vector = vsi->q_vectors[v_idx];

         netif_napi_set_irq(&q_vector->napi, -1);
     }

A failed ice_vsi_rebuild() can leave a running VSI with q_vectors ==
NULL and num_q_vectors > 0. ice_vsi_cfg_def()->ice_vsi_alloc_def()->
ice_vsi_set_num_qs() sets num_q_vectors.

A later failure in any of these unrolls through ice_vsi_free_arrays():

     ice_vsi_alloc_arrays()
     ice_vsi_alloc_stat_arrays()
     ice_vsi_get_qs()
     ice_vsi_init()
     ice_vsi_alloc_q_vectors()

ice_vsi_free_arrays() sets q_vectors to NULL. Only
ice_vsi_free_q_vectors() resets num_q_vectors to 0.

ice_setup_tc_mqprio_qdisc() returns with the netdev still running when
both rebuild attempts fail:

     if (ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT)) {
         dev_err(dev, "Rebuild of main VSI failed again\n");
         return ret;
     }

A later DCB reconfiguration, for example from an LLDP MIB change, would
then go through ice_dis_vsi()->ice_vsi_close()->
ice_vsi_clear_napi_queues() and dereference NULL. Before this patch, the
already_down check skipped ice_vsi_close() in this state.

The stale num_q_vectors is older, and ice_stop() can already hit it, but
this patch adds a new path to it. The commit message says "ice_vsi_close()
already handles a VSI that is down". That holds for the IRQs and rings,
but does it hold for a partially deconfigured VSI?

[Severity: Medium]
[Finding: gpt-6-astra-5-14]
[Sources: gpt-6-astra, opus-5-5]
Does removing the already_down check widen races with code that brings
the VSI down without rtnl_lock?

The reset path is ice_prepare_for_reset()->ice_pf_dis_all_vsi(pf, false)
->ice_dis_vsi(). It holds rtnl_lock but not the devlink lock. Before this
patch it skipped a VSI that another context had already marked
ICE_VSI_DOWN. Now it always tears the VSI down.

ice_sf_dev_remove() closes a running SF VSI holding only the devlink
lock:

     devl_lock(devlink);

     ice_vsi_close(vsi);

With a concurrent reset, can both threads pass the plain check in
ice_vsi_free_irq() before either clears it?

     if (!vsi->q_vectors || !vsi->irqs_ready)
         return;

     ice_vsi_release_msix(vsi);
     if (vsi->type == ICE_VSI_VF)
         return;

     vsi->irqs_ready = false;

The ring->desc checks in ice_vsi_free_tx_rings() and
ice_vsi_free_rx_rings() have the same shape. That could double
devm_free_irq() and double free the descriptor DMA and buffer memory.

ice_eswitch_setup_env() runs under the PF devlink lock without rtnl:

     if (if_running && !test_and_set_bit(ICE_VSI_DOWN, uplink_vsi->state))
         if (ice_down(uplink_vsi))
             return -ENODEV;
     ...
     if (if_running && ice_up(uplink_vsi))

If a reset lands between ice_down() and ice_up(), ice_dis_vsi() now
frees the IRQs, ring descriptors and Rx buffers. Would
ice_up()->ice_vsi_cfg_lan()->ice_vsi_cfg_rxqs() then refill and program
rings whose desc is NULL and whose buffers have been freed?

These races existed before in a narrower window, when the reset path
sampled DOWN before the other thread set it.

>   
>   			if (!locked)
>   				rtnl_unlock();

