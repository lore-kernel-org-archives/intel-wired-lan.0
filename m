Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F782606A326
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 21:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=PfAEhABX;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cm8oUs74
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31A336077A;
	Mon,  2 Nov 2026 21:05:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uq5_FQ9BSu7t; Mon,  2 Nov 2026 21:05:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B6041606BE
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793653503;
	b=OFMkuDimaY7XhwlsVAqsr4no0z1Fi2TdbnmKZ0ZvgqE+7GdeVtUiXCB2Qm6RLHXw4jAl
	 29EvX2wH7eBo75+hcdX0VF8CVycpKqv7D599GRzi+lhbN4Yi3hyOthzVwbPjfLGYFd8Xw
	 wkR/xL+GcsGWerkPNpS0KXdNoKaD2bNGb+r62pM07P35K45IdWLOLJGh9+EoH8SLHVV/B
	 ocm4Kj9+9TkkPB+Xsk8YfIEYRe0Jg6w5QTnRIXSLLAVATJDVhCAGE0y8AVCr3ceI2jFpj
	 e3qJ3+NQzJuQc58T6Cg+cnojvuX3j8+LBFT8aUktvGLI5f+cR9ltJ0nTeADIgLa7ihw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793653503;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:CC:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
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
	bh=NgUsB7BbYmgVO0VyeWqH8XXNRkTSFQKv5oCQkctiZtc=;
	b=V49VPAK9d59HjieJan+GwBzYK+y5EiA57YigUQoENaN0AaLIHe2fiyqit+XOvy4PhMCr
	 XEl8bgOPYEFx/1StzuzTc4/7S/u3j3yRj4cqhfKVJVM8XuHATXEoRm/Wc17pVCGSv01Bv
	 e71ADF1QQpuQFAaPsWgiAPwd6UBBVFGgUGFvRbzarN+YiNFqhuZvi11ybzftVVdsBTtsm
	 2qzNxEjfFyfpW6bBQzTM4qj0lqFbVPsy5JucAZvqo4Oe4z/QeSJ8oiKWo6AbZTV71fraQ
	 D9Vz5laaRbf06fuTcTjIGgo1cc/mk6pvd+EZWHYhHN2eJup1v+QwWTCu7RvdoBLdUPg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793653503;
	bh=NgUsB7BbYmgVO0VyeWqH8XXNRkTSFQKv5oCQkctiZtc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PfAEhABXG9MVadSMiN5ZCWJqSveH7fAszMDPzEfstfvUzZT2WnPBAhnLm0un9dw1U
	 ekCnVA9iPdFmhzHqWLBcSaAVzCITND46SgMmO9/to2hsi+jz7q2Z5Fg0mEgw0y1iwJ
	 Vh/PlT7xtMwjN6ZPsP+XiE7Xm146AI1RR86kTJY9iyFrwOMg3VHiDVarbk7r9qc++8
	 RjgG9S5Qu7vae21Bn40KJmJMRXHpSbfKWfZrjOqDxhgQECEUtosb2fu5l+rVTprzDl
	 tg6lfgfW6RRBtRUJglmKEE75IB5qHlhxnU6ma2T1B1p35Kfl9P8VczT/OFszaVE4Ws
	 U1lsT+GJpqUyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B6041606BE;
	Mon,  2 Nov 2026 21:05:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 98CF84BC
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 21:05:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8A5D7400BE
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 21:05:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XZ38XgCzodaZ for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Nov 2026 21:05:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6D83240098
Authentication-Results: smtp2.osuosl.org; arc=fail smtp.remote-ip=198.175.65.12
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793653500;
 b=e5Y2HK8PlZ847G/IsuQrY+cUfkbhWmV9mcghl3YZjiUoB4Pj1dMJ+q8wX0x0Ib8vFAtS
 2gschu9O21nRYPQn11qmdm6lzQSLgGKrHQiV8szEF2pV/4aws+TQ0HzF5UTsrXTrug9p0
 tVekjRoc76qnMXwRnbmtv2ySeouPoj0BrVbccPJNTcLk/iBjtbyWklGdLKTuKHo4n3U9U
 JPOJ4GwD3OdzP8OWFxmh5QIQUePK/diEsnnRbCrPUoUZdN/O2ItqCOqQ1SYV2QvQ+JTPC
 EFoJJ2a4vYjyVOPEiKpXtw5GhiNwwo/iTD6P3VfNJxsiNqCaT5rscxqjtSDnTFnrkBw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793653500;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
 References:From:Content-Language:In-Reply-To:Content-Type:
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
 bh=NgUsB7BbYmgVO0VyeWqH8XXNRkTSFQKv5oCQkctiZtc=;
 b=VDov/LLANh3HevQSfMXmzFMFKG6n59RFCnuyVmTOsA+9rPVcPgzdDmGqL5mwGWp1DBWI
 bfrE8BVzSCS4e7ctAh+rt+KDfvbozn1zedDaq+hOtQ9wWvGu6+07p+QN9fwQ6NH/5eFAQ
 z8v9NkCCZFKi+Dw2X+ZO/uuCn8FtDAUrXYS7nnIWFFgPh2rdaF7wWiCZvjZR4dCLf9dI3
 4KQrrnE8UXz/miCjaqNV9wYlAWWGpnQXmobOmY1jaV1zINx+ouCKXdjV7/w9KndmVtCwa
 DALR8rgUtbaSoPsrtlXZba63BoMglso4WKudT+1C0qPT2L5e3bidIiC/28HUamoDbKg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cm8oUs74; 
 arc=fail smtp.remote-ip=198.175.65.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cm8oUs74
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6D83240098
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 21:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793653501; x=1825189501;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=T0LDwbGgA2Vy4qI50sb8RBGzkdIGzr6pGgVAwtLFd1Y=;
 b=cm8oUs742agtzqTzLAaDjbYdqUtj3yTkV46JUk91hmCUqa5e1X6Bo6/F
 Jkg1ysidmVuAjerBB4RAqcMCCiouVkQlLVeYmGH3DyGHH0eiSWfxfV2o9
 vgID7csMrH0bVqGTODv5BbP4mcn8S2G/eA1+o2LMPHSHvVltSNKnh4Sq0
 s/KwxQGFS8XB0SRXvEHjSKQmCiKORT7n1nSu7gAJjXQ2DLliQVrQnQDRz
 UOw1F0Xl+VKho4ItDM6vImSWSH9kmJebhJdDqWb/Vq33D4eVFylDOzeBU
 BiTOOz7uQWFMHcPbTy12iwqV43nqwtEf0htjNK6JLQ0WLwH/bG3N1OvGN w==;
X-CSE-ConnectionGUID: Sh2K06sTQaeTKR3LTChToA==
X-CSE-MsgGUID: YKA5A4OmQW6ogp4X6yme4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2242501"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2242501"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 13:04:59 -0800
X-CSE-ConnectionGUID: e/qUvv1oQRas8g04nSehGQ==
X-CSE-MsgGUID: pr2VD4K/Rf+KhICsrO4AEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6101985"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 13:04:59 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 13:04:58 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 13:04:58 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.68) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 13:04:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xl262ZjYO913Mm9I7Yni/ZTlCzL4zThDbDn/EnauekNOqRlsJcdlX6D+EyzK2tyuZkz/p4D3g66u3TfRsxKDoFwDY/EhUXvRI6orDDDeyuBFV4R8I+lb5hUgOz9eLHkoMA80GKu7ST84KlImNu3LE89eptrvSE3Qpinsl4T1PV+vrYjKeHDgQmltLLKR5AALQXbafbINJU7n7RB6y6B7A0VglGMGy5O0GpfacF7gL5+86amQet4NwcIj7awKSu5crzSnMkPb5+E4PaVy+wfmeEWDE8mj+8jECihKAqYFdcyPHb/PlzwSZjd2nXrzyK5I6ZU1StmU9oCGlo1U1m1XLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgUsB7BbYmgVO0VyeWqH8XXNRkTSFQKv5oCQkctiZtc=;
 b=PYkX+HrFLHltFtp0hdH9vWpstelItJtFmndPS+CaSMt8mQU4zrr9vlNdsCS7gmTuJmzTt0mR+6Ody7D4uWxC924vxD5llZtIx72WbGEr6euE8hgSdN3QrhlI1numaXnw/BVJCjgua04ZUTs+7ycT54uwFxgJXPhfcaWUtL9Y+8VaHAnIyZLUacqghJdKFCyLqQRPSZw27+l0XdA0VfOX1kSDb6dJrinL4CFyBmjwijPteCmPAqW9/QhyaAvQBEQ3TPwSdJP3Vt6DU1zbQ98yH7K4JsRhFQskun03G2sbcwTknBkSl5o0xotKlVMmyX0jAW8DH7TF2Ve3dXulLRHKLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SJ2PR11MB7454.namprd11.prod.outlook.com (2603:10b6:a03:4cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Mon, 2 Nov
 2026 21:04:54 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 21:04:53 +0000
Message-ID: <e15404d6-5a4e-45d9-bdb4-c94b5a575ff9@intel.com>
Date: Mon, 2 Nov 2026 13:04:51 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] i40e: Lock VF cloud filter list operations
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Binbin Deng
 <18983559317@163.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20261020025856.519623-1-18983559317@163.com>
 <CH3PR11MB566895DDC2FD235E47AB496E9DE56E2@CH3PR11MB566895.namprd11.prod.outlook.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <CH3PR11MB566895DDC2FD235E47AB496E9DE56E2@CH3PR11MB566895.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::13) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SJ2PR11MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 0af76e42-261f-4dd3-828d-08df3924f0f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|921020|261026140227099003|4143699003|11063799006|261028144727099003|56012099006|261022075727099003|261102123227099003|261026121527099003|261021135927099003|261009223327099003|261009221727099003|261009220027099003|261009221227099003|261022105027099003|261021121427099003|261009223027099003|260925021311599003|260925022911599003|10067099003|260925021911599003|261021123027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: R/iP5GaT4p1CPWCc4f924RsyXnKRrXxrTd3wz1QRRq1Mb1M2BLNVFJ0DZjLP18Q9QukphiO1Mn+XkOqScLsMKT0cSf1/VUsl4GylYUwZB+veDTdyV9EUXt2NmN8A7LObXP2lxSqcqG0Q+B/fQYrdmheU1J/0suym24Y+PhciXTza/0NdasSoAoAIVRsXAVzAK4PAIDckL7uC+iqr++ZHjH00AaUbC4OpIelTmPJXTXq36pAT84DlnsOWtsuRHP1X+KNiClByJPeFV9IdKi+/cLwluUqJo97kDqR6kmqJBIKaKpOrEtX5OkJSg8orb+wAP3CZk9qfUE8bi/6lZfI/85kCjpX2nrFSyrEbzilyAQOUL2ktp+cSRv+GNo4h/2kmj1IwahSTReUqvFpn874hcADUWklpStfkbhctRhQmLbCiKK3DC0TmKIXDl50RVbE6OzAMGiRtaZgsHVKvKTSRHMB5U6IH087HeQ73LoYgd8Nq3Fe1+Uexi1vqiD0q6LhwKSDs6e/tO1jQGG1ZkjrP2vP7oWuzPtx1m1HjpKK1xt5iIcpMh9pIz0/q6ccZGvFh7vEIYQhVO2lhPqdjza8EnA9S8xcJome4M5o5DB7xVx+fh0vY9N4HLmKwswY2VZPaRaBJi3CaxJZGs2olNmYGMOMWsUtwSDPG5tRybKGHjH8zbN2g/QPgtAmNw4FhZ4O2+uv3yGr/qHOVuufssJw8hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7381.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(921020)(261026140227099003)(4143699003)(11063799006)(261028144727099003)(56012099006)(261022075727099003)(261102123227099003)(261026121527099003)(261021135927099003)(261009223327099003)(261009221727099003)(261009220027099003)(261009221227099003)(261022105027099003)(261021121427099003)(261009223027099003)(260925021311599003)(260925022911599003)(10067099003)(260925021911599003)(261021123027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L242UlcyV0VQUGljN1JaR1FocFZOY1ZDcW9VL0tRVmNiaE9TeVRPTzI1TERU?=
 =?utf-8?B?UzA4V21qbTROa3NRMTNUUXd5VlQ4ZXpEVXVucjFmbFMyUWhLZHliK3U1akpL?=
 =?utf-8?B?MGZ1NDJyVG1TNEJ6Z2NqWE0xTGJuTHdpNDY1S0hnK3BlK3kvT3FJSnRUVUUy?=
 =?utf-8?B?MUo4RW9sTm5ra1NaL244VXdheWNaVndrblN4M2tKdVFnY0Q2QnBOdmlocXFB?=
 =?utf-8?B?T2VZb1NZdGduM2RXWmN6UGJENFYzYkJtY2dITzd2SEtDa1VEVm1kY08vNiti?=
 =?utf-8?B?WGd6a2V3dkxjYWYzdGxDYXk2M29NYUdnQTd2Uk8xcnN1NjkxaXNaMXZBVFhO?=
 =?utf-8?B?RzJ1cHBROUFHT1ZTTUxtZHBDVjVGd2RwcVR6U1dOeXA1TUR2NjltZUw5NUta?=
 =?utf-8?B?TEV2QnZEYjJ6ZVZpb1U5OEFzWXZObEYzZjcvUUV3ZVlPQkZGb0VMdTJJRlB0?=
 =?utf-8?B?TjZvTWlEWStjRWJmWStnTW1sS3NhVklzVzlaemdFckFaeW13K2UvN1I0TGs5?=
 =?utf-8?B?eDdoTzNDdjlFM2tVR3F4MmZTbWJ6ZHJybW1XMnpJTHFYckJ0b0NFUjcyT3VM?=
 =?utf-8?B?c2k5MjVIYXNpQjBiWUhWaVpQZGU5Mnh1QUJEcHhXaW5SeDMwcmIxbUFIb0RH?=
 =?utf-8?B?VlF4a3E1TWN4TFBRZ0ZaMVRrRXkycDVFdTdZUkk4c2M4ZDRRZkdtSjJ3bElV?=
 =?utf-8?B?RlpkelN2Ym1BM0lYZ0g1bVE2Vk5nS3NUNDczNEpMUzdtRk4vcEhmdGRiK29D?=
 =?utf-8?B?MzkrU2hiSjZxSjlQZ3d6bmYwbUdlUzlNczR6U2lBdW56ZnVTd011MmtPeHhv?=
 =?utf-8?B?VUhjOGkvNDdKK2ZUUHdzekZkK2c1M2tQMnlaclpQNloxeW80SFNVVGNPbHNt?=
 =?utf-8?B?RVlhYTI3cldFelJ0WDhTZjBiakF0Mi9yYTVIajlaOFJmVytQd0V1eTRZalpj?=
 =?utf-8?B?dWNnK2ZibDRNc0FYWTI1ZmNGVFZkVTdUNW05SkZsVDI2WVNPVnJsY0N3VEZN?=
 =?utf-8?B?QTZBeEUxREd5V0I1enBzeUdJM2dyL3pzNlRBRzB3MVVmQ3VDdnFOLzZPZFhN?=
 =?utf-8?B?STFHQ3NOKzNkRUx4RUxsRXBReHZwQTJDYXoyVmNVUjYvK0ZBZ21KNFkxdTBu?=
 =?utf-8?B?T1hJWWNPUDdqakMvQ0lSN0lTa1E3aFZjWDkvMkIzRlBOSjBkQVNHeGg1bGw0?=
 =?utf-8?B?VEpWdktNSlYweDJ3OW05aXVqNDJ4bnhEbUxRakJsdFNHb2FrbEdhc3ZsemtR?=
 =?utf-8?B?czQvL2RkS3hlS3g0ckE3Nmc1WHBsVFpaMVFLVVkyWUZ5SGtoRG81S1AyMGZH?=
 =?utf-8?B?Wko2NzhmVHVMNWRHdDRoY0VFclIwblE0TkRUQWc2WDVHMzkyVDM3OXBTNlNn?=
 =?utf-8?B?MzJUaXd1TXBHS2FlOURSUDlyOEJBalZIS0l0cHFLMUFUdjVDdjlWR3hONFI1?=
 =?utf-8?B?MzEwQVdFZFlPdVlhMUQ5NkhVMWhUUy9TMkt3Ykg1R2xLK3VHczlwS3RoRW5p?=
 =?utf-8?B?T1p6SW1UZlBXdVNOWDBOMzVVZXVBQm85dFdxZ3hsQUh4YTRkLzdrREg5SzZj?=
 =?utf-8?B?anNDN2NtK3RyUER6SVNleWpueW9JT015SktMajMrSlUzbWpzUU9NY0tyUkow?=
 =?utf-8?B?R1ZiQUFTWjJuOU9BaUFQb2hoTWJJK3Z6bk9hL3gzQ2RRQ1BOL3pib0lBN3p0?=
 =?utf-8?B?TXlMRDRHUVhhWUNkMVJ2blJFUlNvZHpkaHhOQmJteVgyaVJoNU1ZMjR2RGN4?=
 =?utf-8?B?WlRId3pIaExuR1lkWjVLSm9PVDBGS1dUeVJ6dFBZQy9vUHczWWZYSWFXNDBK?=
 =?utf-8?B?czJVdXp5bjZhemNabTk5UXJ4WkFKUVF5cG1FWmNXL1NzSFJha3lQWHMzZ2Ro?=
 =?utf-8?B?RlpQOUV2UTNKTWxNYnR3R0ZWbGVDTzNMTUZCV3I0aXhCZEkrY3ZNdHUwSnIr?=
 =?utf-8?B?MW9BMmdUb0lUMC8rME1jMHZ5UGMvc000eDBUWGg4NDVoRjhCVU1MNnZnS3FD?=
 =?utf-8?B?WCsvZ1RGL1NwQk9adzE5VDg2T01OemVQV0tWOCt3YVBXdEo4azZlZ0p6U0Q5?=
 =?utf-8?B?NVBDaC9KcVBvYnBzdjdNOEozWWJidDZsUDVmMktHLzVJZlhQbC8yN0lSY1BY?=
 =?utf-8?B?TjRWQWxlNmNSTmdVL01FNGE0YjA3Zy9SODFOK1JuOXFJU1R6bXVleUVzY1lV?=
 =?utf-8?B?V2ZwckMrVllkQjlhY0s0NkppYmpYWW4ybmd3ajdFMnNaY2FBeS9oYXVIclAy?=
 =?utf-8?B?eVNEb091MnR5NEtOcGRMbWZYQ0o5R0JtK3VoM3RER3k5NkxRcFNsNmdqd2hr?=
 =?utf-8?B?M3EwN1MrSVdwZktmQlZVWTVuUTRkTlRnQ1QxOWpNdmZHeUY3ajExZz09?=
X-Exchange-RoutingPolicyChecked: NKRNxbzSGjy4grGR455FIKAf6Fis8NrfqLlpNAHv7ev6MArEzjYbWQeKF+m/y6uXB1WPFD5LW3kIy90NJF8s5evhscO4Uv8ZcJQWydP5hf0TT6WyL72AllyPfUnjjWMu7QRJVzpdKlH87jt5mjWcGZpubqvLyimJvTbDPbO7+UgMnT4Qkz2rxBEOnzXyhMJIfMuT7rJ26bmrNhr9Hz4GbLNDrcyC8q5yrLhLNAWb7QPaYtiFeDtCkvpY622E7I7XHsCv+xQ9sFAMUgtWGtlowwVxdl9yyCQJ7r1EwzE8HH/WfCuIDeu8WJ0+ioz2l8s9wk7xlKGtnz4EpdLESpmBFA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af76e42-261f-4dd3-828d-08df3924f0f0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 21:04:53.6157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldHeST16dzDOW9WQ0xt/t3yknTMxHJcFc6TUPLR/5JLOIDdwQ8QvMk0KspVmZaqGKPh8+GycyrQKCakYmpTTcr/DQLKTlXRnzH47ev8QiNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7454
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/2026 1:01 AM, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Binbin Deng <18983559317@163.com>
>> Sent: Tuesday, October 20, 2026 4:59 AM
>> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
>> <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
>> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
>> pabeni@redhat.com
>> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Binbin Deng <18983559317@163.com>
>> Subject: [PATCH v1] i40e: Lock VF cloud filter list operations
>>
>> A VF's cloud-filter hlist is modified by the virtchnl add and delete
>> handlers and by i40e_del_all_cloud_filters(), which runs when ADq is
>> disabled or when the VF loses trusted status.  These paths do not share
>> a lock.  In particular, the PF's async VF-message handler can process
>> VIRTCHNL_OP_DEL_CLOUD_FILTER while host-side ndo_set_vf_trust() removes
>> every cloud filter for that VF.
>>
>> The race is reachable from a guest by issuing cloud-filter virtchnl
>> requests while the host revokes VF trust or disables ADq.  The VF-
>> message handler can traverse nodes that the bulk-delete path has already
>> freed, or both paths can remove the same node.  The result can be a
>> KASAN use-after-free, hlist corruption, incorrect filter accounting, or
>> a panic.
>> The virtchnl operation-pending bit does not serialize this host-side
>> trust path.
>>
>> Serialize cloud-filter control operations with a mutex.  Hold it across
>> the firmware add or delete, hlist update, and free, so bulk deletion and
>> individual add/delete operations cannot observe a partially removed
>> list.
>> The lock is file-local and slow-path only.
>>
>> Found during a static-analysis-assisted audit: candidate sites were
>> surfaced by a Coccinelle rule, and the reader/writer paths were
>> confirmed by LLM-assisted (GLM-5.3) code inspection. Due to a lack of
>> hardware infrastructureThe issue was not observed at runtime.
>> It is identified by code inspection only.
>>
>> Fixes: e284fc280473 ("i40e: Add and delete cloud filter")
>> Assisted-by: GLM-5.3 coccinelle
>> Signed-off-by: Binbin Deng <18983559317@163.com>
>> ---
>>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
>> b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
>> index a26c3d47ec15..f73a710f42f1 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
>> @@ -3740,6 +3740,8 @@ static struct i40e_vsi
>> *i40e_find_vsi_from_seid(struct i40e_vf *vf, u16 seid)
>>   *
>>   * This function deletes all cloud filters
>>   **/
>> +static DEFINE_MUTEX(i40e_vf_cloud_filter_lock);
>> +
>>  static void i40e_del_all_cloud_filters(struct i40e_vf *vf)  {
>>  	struct i40e_cloud_filter *cfilter = NULL; @@ -3748,6 +3750,7 @@
>> static void i40e_del_all_cloud_filters(struct i40e_vf *vf)
>>  	struct hlist_node *node;
>>  	int ret;
>>
>> +	mutex_lock(&i40e_vf_cloud_filter_lock);
>>  	hlist_for_each_entry_safe(cfilter, node,
>>  				  &vf->cloud_filter_list, cloud_node) {
>>  		vsi = i40e_find_vsi_from_seid(vf, cfilter->seid); @@ -
>> 3773,6 +3776,7 @@ static void i40e_del_all_cloud_filters(struct i40e_vf
>> *vf)
>>  		kfree(cfilter);
>>  		vf->num_cloud_filters--;
>>  	}
>> +	mutex_unlock(&i40e_vf_cloud_filter_lock);
>>  }
>>
>>  /**
>> @@ -3856,6 +3860,7 @@ static int i40e_vc_del_cloud_filter(struct i40e_vf
>> *vf, u8 *msg)
>>  	}
>>
>>  	/* get the vsi to which the tc belongs to */
>> +	mutex_lock(&i40e_vf_cloud_filter_lock);
>>  	vsi = pf->vsi[vf->ch[vcf->action_meta].vsi_idx];
>>  	cfilter.seid = vsi->seid;
>>  	cfilter.flags = vcf->field_flags;
>> @@ -3870,6 +3875,7 @@ static int i40e_vc_del_cloud_filter(struct i40e_vf
>> *vf, u8 *msg)
>>  			"VF %d: Failed to delete cloud filter, err %pe
>> aq_err %s\n",
>>  			vf->vf_id, ERR_PTR(ret),
>>  			libie_aq_str(pf->hw.aq.asq_last_status));
>> +		mutex_unlock(&i40e_vf_cloud_filter_lock);
>>  		goto err;
>>  	}
>>
>> @@ -3901,6 +3907,7 @@ static int i40e_vc_del_cloud_filter(struct i40e_vf
>> *vf, u8 *msg)
>>  		kfree(cf);
>>  		vf->num_cloud_filters--;
>>  	}
>> +	mutex_unlock(&i40e_vf_cloud_filter_lock);
>>
>>  err:
>>  	return i40e_vc_send_resp_to_vf(vf, VIRTCHNL_OP_DEL_CLOUD_FILTER,
>> @@ -4002,6 +4009,7 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf
>> *vf, u8 *msg)
>>  	}
>>
>>  	/* get the VSI to which the TC belongs to */
>> +	mutex_lock(&i40e_vf_cloud_filter_lock);
>>  	vsi = pf->vsi[vf->ch[vcf->action_meta].vsi_idx];
>>  	cfilter->seid = vsi->seid;
>>  	cfilter->flags = vcf->field_flags;
>> @@ -4016,6 +4024,7 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf
>> *vf, u8 *msg)
>>  			"VF %d: Failed to add cloud filter, err %pe aq_err
>> %s\n",
>>  			vf->vf_id, ERR_PTR(aq_ret),
>>  			libie_aq_str(pf->hw.aq.asq_last_status));
>> +		mutex_unlock(&i40e_vf_cloud_filter_lock);
>>  		goto err_free;
>>  	}
>>
>> @@ -4024,6 +4033,7 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf
>> *vf, u8 *msg)
>>  	/* release the pointer passing it to the collection */
>>  	cfilter = NULL;
>>  	vf->num_cloud_filters++;
>> +	mutex_unlock(&i40e_vf_cloud_filter_lock);
>>  err_free:
>>  	kfree(cfilter);
>>  err_out:
>> --
>> 2.43.0
> 
> I'm afraid one more global lock shared among all cards on server will make things worse.
> @Jakub Kicinski can you comment?

Agreed. Even if the race is real (it hasn't been confirmed on actual
hardware), this is not the right fix. The driver should maintain a lock
on the relevant data structure and this is clearly a hack of a fix.

I'm going to reject this from IWL patchwork. Can someone from the FNIC
team make a note about this potential issue so we can investigate and
develop a proper fix?

Thanks,
Jake
