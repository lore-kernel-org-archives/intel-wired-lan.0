Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777DC606A31C
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 05:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=YM8cXSTw;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mCsh00RF;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=ORc/6S2n
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5155B40801;
	Thu, 26 Nov 2026 05:10:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yWJrFCvmsym7; Thu, 26 Nov 2026 05:10:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 40A3240597
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795669814;
	b=ZLN26qD2EeAtoQ8u2NjoARIfw3Ed7YMg/yVu1gc4J4B8WWOuCzVY2AL1SkvkKfWo6KLb
	 G47D8XoFBochk7o5zaMyzfzfVC6SDZMjKjb6eAH3oqHHGmjCyzwFqcKENU4rth08LL0Yt
	 tIm0lceZVIW2K6BxziptOwvECctGKo4Zol5tfH7YV3AA5mLjHa5eT40T68xm8PYidZD/l
	 X9W8+J9kjvj0L3rbdLANxQCUv0sud2D174VtejacvRoLv7fgdm7m8PCHbVNhaVNWFiqtD
	 QpItIbsm+rg9btqQIqwTQnVQT8y4kYTL2vtbzUEJNx3XYqfbB7jrl3/KXQrLskNPGDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795669814;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zTXZb8Ozq6uNk7yeHjPskHVYLK10sEGHMP9JfRN/PQw=;
	b=dFgmTlmLnvW9u7V0yeGpHbH8D11arrFrbhYWrir8EMeXT3KjEBlNVrI5MAGcqv05FLrV
	 BxCnBhzqFs+RblTGjaji/YHtHuC7C6f999qAUJVQbTPRsqvj/51+2eu3yOItx5W9eF12L
	 rtinLBiaAxfM4pfAVqvhC5au9YkKYGYJQr9BFM/4p7DAt4W6uqfAZ/hJ9Znes/MMfgFSH
	 94Ck/xcYTuFHecrQrCLfidG9rgUleqOPX+lqsBrErHm4I4n4Fp9dqHH6cxl+ADmokTlqy
	 8RYgvWXGKVoMbb3elCjKxODD0KCO8nx1k2UBaI5y5pZJEoV1W0yFrHhlDADv/rQUxAg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795669814;
	bh=zTXZb8Ozq6uNk7yeHjPskHVYLK10sEGHMP9JfRN/PQw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YM8cXSTwJxE9uzok2/IHP0XWSctSXKUClyUs5BGKrjVZzrVpt+tMMmvdyq/T20lUi
	 Gq8U5EMUdjrZ8PnXmi1W0JWG16354Ov6l1fJTXKg+UGinqGOmDUxkjHBb9vTfPuxj0
	 qTwcBBRiIQS/sGpYqCwippUEI5BHxLXtmXqhhlyu/RWsykarN37bthJg/G8x8GjLoC
	 wxh8jftXE+y3sgk4VjCIlwUEthduq+NyD57KWJxO8gPvXmynrV4xYOa9Chtn83YZb/
	 iOiezLURFQVJ+vjA+dJhPoTm+PppmcjwDwpHsSVb1B8zvN16yWM8R2qfSNaW4il7vl
	 1UwffN9oGPz3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40A3240597;
	Thu, 26 Nov 2026 05:10:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 16A0E1C9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 05:10:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F0400606D9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 05:10:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UkVOLyD4V3sE for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 05:10:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0FC5A606A0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=mCsh00RF; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=ORc/6S2n
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0FC5A606A0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 05:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795669811; x=1827205811;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=A8UsEr8U1cIVbGXEPNaEAWCPeYkAm056sfpZK23wcY0=;
 b=mCsh00RFHeP/J+sa0UgHuQHsH4cCAgI3lNrySvjp5L3Q9b+8Atr3Ah3X
 BsjpLf/H/yvDwNv0IWRDaWHijPigrKK5Oh6UjMqAZof7EC++hEAt1LDCT
 JlLOcNI5xFItMvL05P7VkQiIJ+cmF2IHQjiJ9uUO1kYIisWSrF1GBda2I
 +iPAKXSGOUIhNPgA39vGDkzp7i353I9txDSNsTkCALaVkFLmcbFsVMLCZ
 qb9GputcADk3sufK/2AogTPcNHBdOb87vzDGBr1vZeQrx+zrS7cARS9Oe
 Km6lZUXK2JlrmBh19Y2JKoUZJ0XafHdMfqM26A1K9FElpcyb3/SGfoHb3 A==;
X-CSE-ConnectionGUID: 36Xs8hnaTOGMvLIsRgi7wQ==
X-CSE-MsgGUID: jBJNjBEbTxKxN/n30fStUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4469611"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4469611"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 21:10:05 -0800
X-CSE-ConnectionGUID: MXjUQsx2SRuwkd7lUwQBSA==
X-CSE-MsgGUID: RAf23Ro+T9CHBBqtqrcnoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; d="scan'208";a="13847546"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 21:10:05 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 21:10:03 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 21:10:03 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.14) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 21:10:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTXZb8Ozq6uNk7yeHjPskHVYLK10sEGHMP9JfRN/PQw=;
 b=ORc/6S2nuhkRjRK4BhxjgNwKF8iep1IkgMGNFzC+7kZzP3+gpCdExpQOOFE0m94TxetUJaKx3B7ydtLsT/i2SsaivhSCpHDd6ss3JwI3P1eCUHG5gaBAHrUMf3L5rMZGf5nzXi9GfSfZ3ZrMA+r0pg9TkZ64xDjte9qX0zwXmIA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by SAVPR11MB9573.namprd11.prod.outlook.com (2603:10b6:806:4e6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 05:10:01 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 05:10:00 +0000
Message-ID: <6f89986d-f72a-448b-8909-90bbcddd2974@intel.com>
Date: Thu, 26 Nov 2026 06:09:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] idpf: fix vport_id used as array index in MAC filter
 async handler
To: guohongyu <guohongyu@cmss.chinamobile.com>,
 <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
CC: <anthony.l.nguyen@intel.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <13057616121@163.com>
References: <20261126020854.233971-1-guohongyu@cmss.chinamobile.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20261126020854.233971-1-guohongyu@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P191CA0009.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::13) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|SAVPR11MB9573:EE_
X-MS-Office365-Filtering-Correlation-Id: d69b4f1e-2e7d-4fa7-36fa-08df4b7b85a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|3023799007|56012099006|11063799006|261026121527099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: OlkeAqdgMpTVyvf4zgB85ElFjFeMLt4bYvaqh5DYoIcTiCWglL9YH0JF2Kiqp59wEVLMF3Ji8elTMi3esvUzaI2D74hRTx2aMC/94mTDJK7hs51O62XMnX5nq08YhfwU6A/xgVa0GjkahUFIgtg/CX2sUmapGqXFA7etU0O60BHNWtZBJ25er7CqbSm0NS4MaVOpI0UQ71If+1e9P1HiNtsMzleuQ5nRZbXnlon8Cj1mGZyeC8VLdibEuNZCnfPIz4OVx6AQnDTUozV10YyN4pbV/KNNy4yJQvI2X0PQVIQvt1eugn9oc3bCYnw19ln0sDydgobYowwGMzztAn+14LQpEil/Nk7KrgHdN+q/HiOgMBJnyPm+I1WTGXK4WD1aO6OEL+DklkshmHqNiHHWWCAiKS2gNp9+Mn6fVL9rDCOpE/yhXL5SUKMg2KbEQoa/wSCA79n+v0/iC9s15C16e95y99zXxm6mTUcy0WJ4kYtrziLrHntRi8/zIX1QnAROuLDlLck82CJc0N7OXv1rKYd560nTqPzuc24d2uAlhDDxyo1vE/+dwS/EPV+AEsWfgPQeBPT2P9oslgMNcb+AHl/FySsr+GQuMqrzRXCtrRc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(261026121527099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R01ydVlTSWtqSWNvdlpudmhrYTFhRW9ranZtenF4VVhMSTlXeDFLdExxZkw2?=
 =?utf-8?B?UUdpT1YxcmpHS205RUl1eUFCbzB2TlNRTGM2Ry9QQXlPcXF4bEQrOW9DcjlR?=
 =?utf-8?B?RVBoUk5WSmNTaW9qVlZ3aVhiOWlqclN1b1p6eU9LK1ZhSlpadVVocFMvQUtn?=
 =?utf-8?B?TDVuN01HZG1qWStPa3o4dWw2ckZyNVgyc0IvdjNBRXBiaWhRUzRma0JCR3Mz?=
 =?utf-8?B?WDFGcXVQcGpnS3B5QzhJUll1Z3VBaHpmNytQT1dmVmM0emJwK2JPRUZST1VT?=
 =?utf-8?B?dC9GUjFCWlRuSzRVREc1SEkrZnFlK2t1TkN4bmlvbVUxWHRQR2VPdGIrZFhF?=
 =?utf-8?B?VHIrdjNzdkNjTEpqYm9yU1M0ajhDRHZCdVhjZEtOY0QzdnZPVk5wV1BYZ0pZ?=
 =?utf-8?B?WkZ2MmRvN0V5S1hZc3Fyd2d1STNyamcyVHhjaTlKUElYV2R3YWhyNXZZeUdp?=
 =?utf-8?B?aHM2QTRmVUhuZXNjYkJKOFBjdEU5R0FiMnRTbyt5VkFCbGR1U2pwZUc3d2t0?=
 =?utf-8?B?dTRtNFVDTVRuQUFVeUp3akxNVkJrS095bzBmTGpldWxjbExZQ1ZLbmppLzRS?=
 =?utf-8?B?VjJVTy85dnUyVFVFd0ZRU0M3dFZsR05oZFkxd0Vnb3JRdkw1eTROYW9XcXVJ?=
 =?utf-8?B?QWFXT3ZESFRkY05lcjJCeFRJN2pCWjZEVm9ROGs0ZUdmNytNcXh1TkkxOExV?=
 =?utf-8?B?Y1ZlWjZVZG5jR2xEU0VFUlo0THByc1U0VnA4N294Vk5lQ2hxYWdiOU1DTUdl?=
 =?utf-8?B?blZwbmxCbWlPNzFBelBMblA1b3pwc3h4ZllYNkxnTlBIdzR5OGtVRWpRMkVM?=
 =?utf-8?B?bnpHSkQxbzc0djJwNXZnTXp3dkFobjBFRXlFTlJKT0Q3QlIvdTV4d2tZejVC?=
 =?utf-8?B?blljc0FuRmVHRmVUVHpLQmQ5TXZhM3lNcGFvbk5HSHRETnkwZHNwZWg4S2I2?=
 =?utf-8?B?WjhUYnRLM0Z5TG1lb3RwTENHdXV1MnZBWFFaVjgySDdNSTZxdmFSdmRsYlVh?=
 =?utf-8?B?emVXdVFPZE9meG5MYzVzU0t4YVRFRXdMTTFwYWlnK3hzcUZ6bU5UTnU0ZGFL?=
 =?utf-8?B?YU9UY3NHajhvQkp2aE1TWVh5NjJCMHdSdERQMGRGeHUwaWR6bklGejRSdnA5?=
 =?utf-8?B?eVhQbWV6UnJ2SGlqeE13VXZaN0htcG9mTkQzUGEzRlgvU2hJdEZ5a1dseWlp?=
 =?utf-8?B?NkV4QTdiNnJHWXJ5eU9rbUZFWG9QbjMrVkdGYmtYTlhtNzhlZmQ0Yk5kNzdW?=
 =?utf-8?B?clhBSmZ5THFPTnpKSE44NmNzR1d3SEhzOThnSWVGNzhjaFZIQzcwU01oZ0ZE?=
 =?utf-8?B?NVpCL1MwazNBVmJENDZ2aG1qRVg5dzRRU1VmSWdyWDl2bG94RVlHd3FYYWxT?=
 =?utf-8?B?aVJCTGpsS0hObDZKazdLMjRKcHd6TGxpWS9LanplUzQxT3pQalByNDZWNDBI?=
 =?utf-8?B?ejAzWTcrYVM5OTR5djZQaGRoUG0xQTJvY3dtOGF0cmdYOXZKWmswWE8yem03?=
 =?utf-8?B?TzFTUkNzWHc5dW0wZFpqb2o5UE5TOEhRcysxeERzdDJDN0xOdlcvaHo5YVFh?=
 =?utf-8?B?YkllRlpDRW43QjFrbkVxUUdIZWpDL29lang5M0dVSHgvTnpQbWRvb3ZJNWl4?=
 =?utf-8?B?MzRsbi9aNzh3bVpFYmdmVXdFVFo3RUNQcjlHa1VJTG41bjNtQ1NZTUE5SWhU?=
 =?utf-8?B?SmNuSHNqRzYvVHluaG80M0JNbTJ2d2tibENGakJHV3AyN2xiVVZjRWVHZ1Bx?=
 =?utf-8?B?b1Q2L2tJNGh0U0FzeGtHejRablNCZFVKcEVTdnNlTkNjYTdlSklhOEQ2Wmhm?=
 =?utf-8?B?T2I5a1lxNElNL0tGU0daMzZNYkM3NXl5RkNVR3lPVDBNZEJiMkhtS21VM2lU?=
 =?utf-8?B?ckE5MmllNFNWa0ZrK0RYQnd1YTRnODVlamEzM3ltTnVmMll6UUFHVEx2cUVY?=
 =?utf-8?B?R1pGR3NXQ0NpWHFUQkdZU3V4RDM1bDNNbXBZUDN1UGE5VDZQNktOampnZldo?=
 =?utf-8?B?dVFaUy9pa2JLL3NTeGhHamZRbXZqT0Z5Z2kyZGtmV1JGWmtqYmdLem13SFRP?=
 =?utf-8?B?aWEwNW15RUE1QTQyU3NCN1VtaGhyS25CdmtFN210RzZrK0QrUlJzcmdScndT?=
 =?utf-8?B?c2tIcE1iUnRpZmR0TkRCbVB3V3FZQk9JZGhqMHovWnBPTlEyYi9rNmZYU1lG?=
 =?utf-8?B?MzFzbEZqcWZCWXhjMkh4OWpPODVyNDRRbFJxdkhsRFdwTTdMeU0rT1ZOeHBk?=
 =?utf-8?B?NzRQd2dVV2dyWk5qeTJwbnMxaXJWZnlYeHVOVUE2NzRZTUZCbnhNOHkvcTNy?=
 =?utf-8?B?QmZMdCtieXUveDdiSk9ZWDlIR1p4cDlBK2RXQlpucER0bEFobThyakx1MzNK?=
 =?utf-8?Q?B3Ov/XizPb5tDXIY=3D?=
X-Exchange-RoutingPolicyChecked: hRYgb+IuClQFrpjX0Em/TpxKhrLr7hdTMeWjwU5sqo7S/QcUiN12Kfznyk5oG+q/4hNNfcHXDEbprEQdze69Gy0xWCmWIsVGnqYZmQSsH5O0bOQUwBSHlhGQXGeDLwHXMgHBWeMW05y3Og20sbrhMt+W0JUhb4mlKXa/O38RROgRzI4zM65BGib2Lg7eGvOZgKwP+BwzaihOllkNoDObTk2v0Sf3823C6JhJ30hO4xlPtYKu57nhwhDpSVohTS8jvICTjIDyNyQGhZS1LocgNYqozA7hCHd4O5N3c7uIOHKKb1xWXIQR8dFzrjaGrS1DKbOllv/Xn9psssRYT6qKAg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d69b4f1e-2e7d-4fa7-36fa-08df4b7b85a6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 05:10:00.7791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7A7QAVdKl6O/+Fu38h34pH3zkIntqyxNz4FgMXEtF3QxYcloqUSnmg7Cp7MHhj+Bb99g/gObd6B0/GkOdQfq4cvrNSt8r0VU4WXODKHwTEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR11MB9573
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

On 11/26/26 3:08 AM, guohongyu wrote:
> idpf_mac_filter_async_handler() resolves the vport for an incoming
> ADD/DEL_MAC_ADDR async response with idpf_vid_to_vport(), but then
> ignores the resolved vport and indexes adapter->vport_config[]
> directly with the raw 32-bit vport_id from the virtchnl message.
> vport_config[] has num_max_vports entries and vport_id is an opaque
> device-side identifier that the protocol does not bound by it, so
> a vport id not smaller than num_max_vports makes the handler read
> past the end of the array and use the garbage result as a
> struct idpf_vport_config (spinlock taken, filter list walked,
> entries list_del()'ed through out-of-bounds pointers).
> 
> Fix this by using the software index of the already-resolved vport,
> adapter->vport_config[vport->idx], as every other call site in the
> driver already does.  The index comes from the vport allocation
> slot and is always in range.
> 
> Fixes: 41252855df77 ("idpf: add async_handler for MAC filter messages")
> Cc: stable@vger.kernel.org
> Signed-off-by: guohongyu <guohongyu@cmss.chinamobile.com>

Thank you for the patch.

For kernel contributions there is expectation to use Firstname Surname
format, could you please update?

Regarding the code, at first glance it's indeed good direction, but
as this is async handler, all kinds of ugly problems could pop up,
as reported by sashiko. Basically, it races with driver removal:
https://sashiko.dev/#/patchset/20261126020854.233971-1-guohongyu%40cmss.chinamobile.com


> ---
>   drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index 1caf52706973..e72877242612 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -3794,7 +3794,7 @@ static void idpf_mac_filter_async_handler(void *ctx,
>   	if (!vport)
>   		goto invalid_payload;
>   
> -	vport_config = adapter->vport_config[le32_to_cpu(ma_list->vport_id)];
> +	vport_config = adapter->vport_config[vport->idx];
>   	ma_list_head = &vport_config->user_config.mac_filter_list;
>   
>   	/* We can't do much to reconcile bad filters at this point, however we

