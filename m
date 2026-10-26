Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38594606A31E
	for <intel-wired-lan@archiver.kernel.org>; Mon, 26 Oct 2026 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=T3Yj3JjT;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E1t1b3w+
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 147DA40511;
	Mon, 26 Oct 2026 09:04:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ptNQLKEgCR47; Mon, 26 Oct 2026 09:04:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1335440563
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793005449;
	b=pI500hktYzoqyULlnwRCfEPOTyuCDA9YbS3rY2gCRaa/nFIKirww63zfTIsmf5VJdD9L
	 jsFuoDoFbyP2dEqTH8LSjtGtTEQxh9vgplnqHv0OcKMaUsqLqZzi50afPBITaIWBby4+Q
	 M3sKhW+EXItbYNUqFh2pvpM7pVX0GE1XUzeVxW4WccMJxFxyBsWZ9dCgaaUVzqjAES4YS
	 e6bRuDSpga3TfqRWryRCtAjbG/OsbG0E94ED75Cd6oNGCuF6Za/UguzterMuoxLFQ4f2k
	 ny+1xFY7vIMmGmsLCodJceXM/Jngp7NLP1ds1XANHwCYocaZPCkFD5dGe11Ww+4bzpw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793005449;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:CC:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
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
	bh=wzI3no4mOQdCEky9Mx5Fiob8TAky87pjhb8yO9Lww/E=;
	b=o3kY8ekNKaLWBvKFeoD+SLiyh9bvqpIw+zq3MJS4NXpVkV/xRXjbfzZBXE32Ex+/cNI0
	 1EU1YTI4CeZ4XfxoJP/NTXmJo2k58x6SSjaUKtWC6PdCYqo0S23LGUJ7yhfU/h7mkTGlE
	 naOAewg7wdhptjbVIZz3J1V3UkbE4cO8UWd+OYEwN/AUikA9cib7AjMgQ++ZI9olRVRkE
	 CgrynkSolPVM8GhWGDQsyd+sKt9+/LtT3O0JXMGMW9c7Bd0uwYqUg6684zaqc2ID0JqWv
	 5EcOCC4R0gA/4saUp0qnoyPraT5oLz98qL1aq82z+mnz0fpDDnV7yiGG/VVlBOpGj+w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793005449;
	bh=wzI3no4mOQdCEky9Mx5Fiob8TAky87pjhb8yO9Lww/E=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T3Yj3JjT4KfdFUAAEuLVghUWS5eu6Qmhgab6RRHAiFnPDbeDi9uvbYI0avuNfmSns
	 +RC4aa3mLF/lyJj9JOpAIet9MjuwwUwWhvG3JuIyLOC5xnyjKAI7id+W9l6vKDx5gs
	 2fNasdkmKRGyFA/bDVv+GN7jtVzq0zfYztsUVx11Qfatwb9MoVFkG+DNsMjNSkuD7n
	 tFOmk7Xxl1OtJ0tszhmpxYUW9Qo6QmfkSgU25gbQWla9W639RP8DWbvK+VuWCJ2v5W
	 cE/4bhuxiC4zlaln8ZcLHKrVE+esM5JFrUUJsxCBOPEzYcbAjf/n5tkAfxCklBrdM/
	 IK0dCLBzPTOBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1335440563;
	Mon, 26 Oct 2026 09:04:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9CB363B6
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 09:04:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8EE3280C98
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 09:04:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fab-uTP7n10b for <intel-wired-lan@lists.osuosl.org>;
 Mon, 26 Oct 2026 09:04:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9788980C8B
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=198.175.65.17
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793005446;
 b=ciooXZaJHpfvu/he6QbnfLJtuwZldlRR/ZDICxXZXj/2jOiiBbrPhzQuw2Imdw/7j2PY
 e0JUA3roJN0CqJxnCrL8+DXXp5Gt3ow2Mi0//Yhz5l84wxNCJwZqvJWk64lO5O6dt3/5B
 S5bRKTat8lxBVIrRK+Mm8iTk1YLXRAxxdtmT0KAbMloWntJx7S1CivbiXCGkKjBxSzzUa
 fJI8J28NsHhM6lnIiquNiLig+3fBLzigHaI1isJl9u8Sm04TS677BYTfyyApAEn7q7cce
 cBWlaan5h+02X8WeqVBtnUAjHdzGO7d1rlsSfE8bJm+If4B4zeOJZEItf1BZaHLyrtQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793005446;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
 References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=wzI3no4mOQdCEky9Mx5Fiob8TAky87pjhb8yO9Lww/E=;
 b=aCaxwZpsBxkDGmlbY1QVirdSUG56KdUuzCwZlPfRibKoeT+nMRG6/B2HcGN6t2E/XUVI
 I77pdTCRq1dSP/3fQBFOJeCqIb872seXEh7LkegNCH5YhaeslZcYZ99ecUVRSc9Cv7mPh
 Xjvx/JQYQGa3fbgJ06fhHLRhsWUl6UkkkbdgqOPGQWMSXqQQ64SFWwKCG1EOJwSNREqWE
 tPblK7mHAqMHuziuKqQX7shuYdxlSJ8AWitOA60+ELZc+hf7IktzhRruAb/l75X8AwfuP
 6v7rNq1aFs9+pebPuFeDr/8qEBO3ZE4B4cYiAL+Fw311LwaCwyHvqI4pmEBtEOzNz4A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=E1t1b3w+; 
 arc=fail smtp.remote-ip=198.175.65.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=dima.ruinskiy@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=E1t1b3w+
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9788980C8B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 09:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793005447; x=1824541447;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RuF4FZs70S5bJ8vo6yvpK87OSzucU0qeH3p67LGnu/U=;
 b=E1t1b3w+AwR8m9uKhwU7qBAiYK4SywXsH22nC28O5PCiugBfindGcApk
 Gwcl1advVNJwBWB81E6qvdrKQQ25ZF7ynvjLYCYi5KhJxvragYUBjJFDM
 4AyiAVysU+/lEwXmBBZuXwcpk41nNs1vXGHn0CA7KE+FTW9AWyH3vf+hZ
 byxhU0TrFhEQgjyesdM5V/OzvlagpGYKWM42oL906lJVWHMzyavtZrlsm
 J0foBj+7TGt8K+k+kKQU3axJ2bNZtFQIEnrhSV450hvJxxc68Q1bhFbkK
 I904HHaDwtNsmOVZbqE8JdaEU34moX+V7q444XlcvP/nVAeK7SEfTfcf1 w==;
X-CSE-ConnectionGUID: DLD9o2nfTq2mmKC8zrQR6A==
X-CSE-MsgGUID: u3tJ1m1HQ3mGF/49Zt0QKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1678282"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1678282"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 02:04:05 -0700
X-CSE-ConnectionGUID: YXTAkqqGS+GOMPhgA06LBw==
X-CSE-MsgGUID: nIGpr1G1SWeVMqpRcwncVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4318125"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 02:04:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 02:04:04 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 02:04:04 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.62) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 02:04:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Svs3WUMZZ+10a3oZRhz6sael98pSjn8r/dx3cbJFKiRM2QabX4RCh7abYPHjXwkMikwmA3+qS/CHd008dVBJJwO/p6pbBqENq9IdI7qR9GLNrVlA7usrLl0KZVeof6uwq946Su/k1tKBqHfkIIUYpEdgcqlM9wBfkElMqqthAuUpk48c7aWPwJEN7pjDqHWBHnRg6nBROiMx5dgIa+mo/0mNNAunAhvvhv8i9HtDpt362SfOV9jgfIsRhA8cCH1m6a71KGfi+D+so2kNROiusbtpD8Wi46YvHFzW2dlRiFAOic+WDQtSE8ZIWkcuLPGzyehNrD9WXSzEtllIpkbbuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzI3no4mOQdCEky9Mx5Fiob8TAky87pjhb8yO9Lww/E=;
 b=JOmuJsiQizhMT28m0BcgUqQ1b0dUiqkAMSUUgbXX3qHle5NTVciryOLn37Mn75NuGBNce+W7EYZ6T/d6etjhfVtCrJMJJrCLXwawnKTLneosyY77WqUe5I//n04GOwnQe9P8640BGPMlyxdQY1tZJvB75kUMXIidssdeSsbxWIOOUC7ChXSeNm1GdKMYpOixnyb63V9up13zjzjRCfkHWICeCLxdwBIIqUhgud1d1rlVhtjaZ6z73cc3+pBbLlOLSiB0KZ9egRBAOWBJ4jUuQ7Q9spXjl/VN5KlZzNMzL5kICmf3SuolATPsSLHMUZ5XUGd8282ZTkYrUbj5kvTjtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5630.namprd11.prod.outlook.com (2603:10b6:a03:3bb::6)
 by MW4PR11MB7164.namprd11.prod.outlook.com (2603:10b6:303:212::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 09:04:02 +0000
Received: from SJ0PR11MB5630.namprd11.prod.outlook.com
 ([fe80::79de:af84:3b43:84e3]) by SJ0PR11MB5630.namprd11.prod.outlook.com
 ([fe80::79de:af84:3b43:84e3%4]) with mapi id 15.21.0546.017; Mon, 26 Oct 2026
 09:04:01 +0000
Message-ID: <e8669ef4-1b3e-4429-a6b2-db4c6a734f7f@intel.com>
Date: Mon, 26 Oct 2026 11:03:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 0/2] igc: Fix Tx hangs after NETDEV_TX_BUSY with
 TSO
To: Benoit DE RANCOURT <b2rancourt@gmail.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Vinicius Costa
 Gomes" <vinicius.gomes@intel.com>, Sasha Neftin <sasha.neftin@intel.com>,
 <linux-kernel@vger.kernel.org>
References: <20261004152840.61222-1-b2rancourt@gmail.com>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <20261004152840.61222-1-b2rancourt@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::17) To SJ0PR11MB5630.namprd11.prod.outlook.com
 (2603:10b6:a03:3bb::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5630:EE_|MW4PR11MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c556ee3-fb17-40ff-a515-08df334013fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|261009223027099003|261022075727099003|261021121427099003|261021123027099003|261022105027099003|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: np+kFJpAekBf/pXCJ5q29CvJVl+1GfuXen5PDHTyIOseFzPMpSdAwJnQwYi3Mu3wZcy1SSQcYNYSFzcBqZlYofEYjMk5yZmfw92Ruwcd/HxdI9pV3SKgrAouxmW4vEO79HXLTv3RoxkO7aVn2cB0/u0up570+o2iv+qB5IwTXZpVkbiOB7CMXxY7YZWE+jGzPFDHO2aPUniwRdgL0RQxDMfNDYD4KS8QJdKzTkKi9uicJrC5boPDbly+ZjpCFTQiQNmKqwfQaYw+eJRzcqlA3JfPpqoBdAsoxIWjOeiUtOuzhKcRjtWJLXEYOfQz3xl15za0xyBy8FW7jm1l/D2+d5CLOalLPnpWq7Fl3AVpensa7EW5PYUdhuJ4fbcjrxyHxoI84XGCcC9iir7V+ne2SjedNDuVbzyB1B2eHkKZ2x7Cgd3pDfbQoPInaWyM60mrChuDfpuHTIg8pjLNPugzBdxBw+SMcg2AihxuwUnFWlNRM9sfUuV0igRiB5ybzOsWLA0sgEaoP1CPDOyXzFFELb3+S79LZT7vwQFE/x8a3mTNbZi57Xcgh9OhMpu6d3DH8dltFseB0ZGbXX4EOSesa+8QNeSQrR42wmzPSoPqOmlTq7FQDk2AJUnvLVBNt/0k22EAlItsVUlUz10lOjgF6krTDc/MV6FahJigCGCeAW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5630.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(261009223027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261022105027099003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXJ6NUNIL3cxc0NCczJERXR2NUhLcnlkbm1VQkFBNzIxNXluS3EyRzRZUVhI?=
 =?utf-8?B?N2FQQnBuVFRXR0VyYXlKRDdVZG1zVnkzaHV0UnphSWFubk94R2RWd3BUUEVX?=
 =?utf-8?B?UC85bUZPR3pqaW9mS0VHS0RYemNUWFJXVUNzTjduYWpTNWlLeTJwaElFZmlh?=
 =?utf-8?B?d1ArQjg2dGZZbE4zb2JoeEhCamRESzBIUk51QjJlSzRvS0lEeVNtU2g0a3RU?=
 =?utf-8?B?c1diaFBnU0ZBdVRjZFlnSlJvMDZKTWZrVWpTZHBMcUpJaDZSL1VkTTZXTlk3?=
 =?utf-8?B?dnZCN2FkTzQ0dE9rZHhQaFU2N1djSWRoK3RjRnpzSERYUGQ2ZHFyL0VZWjdE?=
 =?utf-8?B?aGhZbmV0a21tMjZpRUlMM3JhK2hFc3JHRHpjeHJkYUNsV01RNGFiN0pnZlVI?=
 =?utf-8?B?Rk5vM3QrSDlRT1Jwam43YnYzTVc0aEpqVWpBdG5OL2ZpMnk4ck84MC9RTUJ2?=
 =?utf-8?B?c2VtZTNmd3o1cWxrcklOVUN3dVJmcWMxZHI0K0s1ZCtNT3J6akpoeVkvWnV3?=
 =?utf-8?B?TzhWNlU3Yzc5Qkgrc1ExY2x1UlFMeGJXTlc4eVpSQVk2VUdTZUx3a1VxQVdK?=
 =?utf-8?B?Wis4dE1aa1cxM2VKRWRKSEcySTRvc1BqNElYeU54NHQ5dkt4MnFtejhHL3NH?=
 =?utf-8?B?Y1FpR2JPRDBmZVF1dDQwNGhxNkFURGc0OE11MmpkWEZEVzk1OUxzNDh5WHRy?=
 =?utf-8?B?WHVnWVpNTzByWlhZSTlWOVNTMWhVUEpFeVFjR1h6OVd0b1BWdUN6TkZ4QmRX?=
 =?utf-8?B?M1NJUHlDcmF6aUkxV3BHeHFzZGI2OGQ5MG5QeFFEbm4vVXhOdGdPaVVFMERj?=
 =?utf-8?B?dWI1RXg4TEdRN2pFWVhOcWhVVkIyQnJHWlA4a0RhQ2lkNmdkRHdMRjJqejNO?=
 =?utf-8?B?aU9yaXQxTGt2RU82NlZRa2dpRG9qeHhYcXkwS09MVi9XcTV5dDhlUThXbkli?=
 =?utf-8?B?SVRlditPcnliTmxzcW1mOTIwMG1ML1ptUTNqYmNXK0RXTWdUN1k4VmdRakxz?=
 =?utf-8?B?NGVxNjB6NjdURElEUWlpWllJWlpNNEwwcGtLekVBMWFQbldkZFljSUxmTWJ1?=
 =?utf-8?B?OS9TQ0lYZ1lRWGpwZUU1a3FlOG5XLzFMK09kaVRhMWFTVFMzaDZkc3hhNDl0?=
 =?utf-8?B?RGNSdmZHLzByeWxnT1RoTU16bmRSSS9PSGF4cmI2QVB6UHhoNFY0M3pnOWNt?=
 =?utf-8?B?dHo5WE1WaEdSTzdQdnd4bFEvMHNwYlVabytqbzdUQU5pTHN5NGMzNkFTZ0Qz?=
 =?utf-8?B?aU9VVm9zU05QZWI5bEw3YlVyTFRZcUd5Q0VLZzdQSGZXekNqSlF3Mm5mRk9N?=
 =?utf-8?B?dVo0amFudkZ4TGZGQUxMNHVMQjkxdjNyZUpTSjNIdEdxY09nMVBaejNURHRz?=
 =?utf-8?B?eG81TnFaZEV2OElpOXRFRER3enZLRHl1ek0rRjdwUlhFMk9zNTkxVzFNREJF?=
 =?utf-8?B?Y0JvQXR0VDgyUTBreEU4QlczM2t4b094RzJkUFNaSlBhNnB5eE5jQ1hhZ0Fx?=
 =?utf-8?B?VEwzK1RYMlBhN0IxelhJbndXRVFOM2k4bHFVOEJsYjJiZWhiODJ5b2VEbDBM?=
 =?utf-8?B?NVBuZjdiVWNGTVZlZ2Y4cEtvNnVqU204WWVsV1pGVzBzQXQ0enNQcVlXZUh3?=
 =?utf-8?B?Zk9NWi9kZHEzWDdjTVVCRUVTTU5DK09FVktSb3FEVE5NRmlsRkNHVW10bGNm?=
 =?utf-8?B?cDhxbUhUblVNbExYRmlYcUdwQjIvY2dVbXg3am8wWWVVS0Jmd2hQYXRqVlRq?=
 =?utf-8?B?OXBOTzdrSFBBTnExOEhIVWtIN2Y2b3M2RXQzdFFMZGhLeFpVaGVQWkF5cktM?=
 =?utf-8?B?Q3VmZ1ZhUjJNVHBJZ2ZNMVdwdGVvaW9UZUltTmFrcGdKZWMwK2FPa0RqQmQ0?=
 =?utf-8?B?RWFhbkd5SFpxUGV3RThCVm9JTjRzNlZaZ0ovUzRXSW1TU0FvcCs0cUY0ckVl?=
 =?utf-8?B?bi9BSHRrR0Rhb3QvWXBycTQrejRmSUVtUjJTdUxYTnVVSk5iaFF0SU10RU9s?=
 =?utf-8?B?TStENDcxNExyZ1ZhSFRwcDNQaDV5eHRzaE9PN092MmllbFUrZE4weDJJUVRG?=
 =?utf-8?B?MkUwV3N0d2ViSlFVWjdEcTR3N2ZaclRQcGpXK3VRQW9kcW14SWs0b0J3b0Ni?=
 =?utf-8?B?c2ZRazVIT3lmdjNsLzZYdjV1em5XR3pwaUdQS1VMbTRLUFhENUVTRWczS1Zr?=
 =?utf-8?B?M2paK1pDTDNIeTZwbm9QMG0reDc3Z21rcnFJaTNrTXJla3k3TTFTNG5nU3h3?=
 =?utf-8?B?THlhWGNLUkxBRGpma2dPYXdPeitXWkRlWk4xbEgvdGNId3FWMTZqdndEdC9Z?=
 =?utf-8?B?ZVdvYWJucHdDdmx1TTdDaHhscE1RVFA2ZDNmZzlSQ2lqNEVHN212QT09?=
X-Exchange-RoutingPolicyChecked: NcvwoV8XLZbvxSIS8jLQdergPX+VZrFochVK/+hfL+wZ4/YMlyLQSGw1nC3fUjO2Upi6+TJMaCZfj5UXF0Q7osJ8K9LpLdD3FYFUqOmklyYNlNgZOgAkTEBbR7TL+OoLGP3xeDcl3koAwQpxWQTedf0CPfk20VdzapEGWhkltigV9fPbU8zRKpPvJLSNyzSkCud5ohyuRuQJu355Unectf0fBUdBLqXID9HKum9EquMpiUX6quXS7PUnwuOuwLfD3C2rSnia+xQKjUcCLFOmZeFOf/zhJ3P0A1SWtY9j1+GWM0AzSfCRDwm2yoBW0IlQ2EwlnAM/ZwNUMENxqtcGrQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c556ee3-fb17-40ff-a515-08df334013fb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5630.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 09:04:01.7108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMidUvyndSBQaEur+BZybRM6rVeO4dmJ97+W7qhnyGYPSXN/7awm38rhvUh5B6YJE4XToLU1btxASvCRClOgUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7164
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_NONE,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 04/10/2026 18:28, Benoit DE RANCOURT wrote:
> Since commit db0b124f02ba ("igc: Enhance Qbv scheduling by using first
> flag bit"), igc_xmit_frame_ring() requires count + 5 free descriptors,
> while the queue is only stopped in advance below DESC_NEEDED =
> MAX_SKB_FRAGS + 4. TSO skbs with 16 or 17 fragments then hit
> NETDEV_TX_BUSY. That return skips the tail write deferred by
> xmit_more, so the queue can stay stopped with descriptors the hardware
> never saw, until the Tx watchdog resets the adapter.
> 
> Patch 1 aligns DESC_NEEDED with the admission check. Patch 2 writes the
> tail before returning NETDEV_TX_BUSY, which remains reachable for skbs
> with buffers larger than IGC_MAX_DATA_PER_TXD. Each patch was tested
> alone; together they keep the queue stop logic consistent and the
> remaining busy path safe.
> 
> Setup: CWWK router, Pentium Gold 8505, six I226-V (8086:125c rev 04,
> NVM 2017:888d), 7.2.8, default MAX_SKB_FRAGS = 17. Load: CPU saturated
> with busy loops, a remote build routed through the port, two SSH bulk
> streams in each direction and short TCP bursts, 180 seconds of load
> per run observed during a 195-second probe window, TSO enabled on the
> egress port. bpftrace probes on igc_xmit_frame, __igc_maybe_stop_tx
> and igc_poll recorded NETDEV_TX_BUSY returns, the inferred last tail
> write and next_to_clean stalls.
> 
>                         runs  Tx timeouts  NETDEV_TX_BUSY  TX_OK returns
>    unpatched 7.2.8         3           25           10890       7.3M
>    patch 2 only            3            0           10751       9.5M
>    patch 1 only            3            0               0       8.8M
>    both patches            3            0               0       9.4M
>    unpatched, TSO off      1            0               0      21.5M
> 
> In all 25 timeout episodes, the stalled queue had pending descriptors
> after a NETDEV_TX_BUSY return. The probes inferred at least 214
> descriptors beyond the last tail write. For that queue, the hardware
> register dump showed TDH = TDT = the next_to_clean value recorded by
> the probe.
> 
> With both patches applied, no NETDEV_TX_BUSY occurred, so the flush
> path of patch 2 was not exercised in that run; its effect is shown by
> the patch 2 only runs.
> 
> TX_OK returns count igc_xmit_frame() calls returning NETDEV_TX_OK,
> excluding NETDEV_TX_BUSY retries. These are software call counts,
> not hardware packet counters; with TSO disabled, segmentation occurs
> before the driver.
> 
> Related code, not addressed in this series and not tested:
> 
> - bnxt: commit e8d8c5d80f5e ("bnxt: make sure xmit_more + errors does
>    not miss doorbells") rings a pending doorbell on the drop paths. It
>    leaves the busy path alone, reasoning that busy can only happen if
>    start_xmit races with completions that both enable the queue, in
>    which case no kick can be pending; the current code warns "ring busy
>    w/ flush pending!" if that assumption breaks. In igc, patch 1
>    restores that property for skbs whose buffers each fit in one
>    descriptor, and patch 2 covers the remaining case.
> 
> - igc drop paths (skb_put_padto() failure in igc_xmit_frame(), out_drop
>    in igc_xmit_frame_ring(), the DMA mapping error path of igc_tx_map())
>    also return without writing a pending tail, the case bnxt fixed in
>    e8d8c5d80f5e and 00eeab0c644a ("bnxt_en: Write doorbell when
>    linearizing skb fails"). The queue is not stopped there, so pending
>    descriptors are delayed until the next transmit on that queue rather
>    than stranded.
> 
> - igb, ixgbe, fm10k, i40e, iavf, ice, e1000e and e1000 also defer the
>    tail write with xmit_more and return NETDEV_TX_BUSY from their
>    admission check without writing it. Their stop thresholds match
>    their admission checks, so this should only be reachable for skbs
>    needing more descriptors than the stop threshold assumes.
> 
> Not done:
> - runtime test on a kernel built from this tree; the patches were
>    tested on 7.2.8, where the affected code is identical, and apply
>    cleanly here;
> - launch time (ETF/taprio) and XDP/AF_XDP traffic, which share the
>    ring and the wake threshold;
> - longer runs and other I226/I225 boards;
> - only the igc objects were built with W=1 under allmodconfig, not
>    the full tree.
> 
> The analysis and the patches were prepared with an LLM-based coding
> assistant, which also wrote the bpftrace probes; the results above come
> from those probes and the kernel log on real hardware.
> 
> Benoit DE RANCOURT (2):
>    igc: Fix Tx stop threshold to cover empty frame descriptors
>    igc: Flush pending Tx descriptors before returning NETDEV_TX_BUSY
> 
>   drivers/net/ethernet/intel/igc/igc.h      | 8 ++++++--
>   drivers/net/ethernet/intel/igc/igc_main.c | 6 +++++-
>   2 files changed, 11 insertions(+), 3 deletions(-)
> 
> 
> base-commit: a83267db14681b3be481e02a4d5a38177507006c

Hi Benoit,
Thank you for this fix. Much appreciated.

I wonder if we can go just with patch 1 for now. Reasons:
- As per the analysis, just Patch 1 resolves all the issues encountered 
(the corner case resolved by patch 2 is not reached anymore, although it 
remains theoretically possible)
- As explained in the cover letter, Patch 2 changes the behavior in a 
way that makes it inconsistent with what other drivers are doing. Maybe 
the new behavior is more correct in all cases, maybe not, but in general 
I prefer to avoid introducing inconsistencies, especially when I don't 
fully understand the effects.

Best,
Dima
