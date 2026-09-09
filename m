Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18B8C79FB6
	for <intel-wired-lan@archiver.kernel.org>; Wed,  9 Sep 2026 20:48:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 528C1607FA;
	Wed,  9 Sep 2026 20:48:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BPYxCFNfxy9w; Wed,  9 Sep 2026 20:48:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9C48A607FF
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788986903;
	b=ow74YvlPsTvkWJkQx88+Ay4RHOa+jir93RkSWAFMB4IFA1cJI9hsOVNGSXlyNsWbZbYx
	 79gJVtQb5xUOlsauH+/PmHJVA5pVo5IRLcYzDPdn+YcGu2JHLNie1A5Y3snQe9eC4U5mf
	 +imCVER+Ijdtk2WDs2ssArRTQ1/R1LXuy15B5jC9qlIVEkxgNHjJsrs5tzXVruvnaOWRK
	 71JcY82qyMl2bexZf4+jeZ0q5SkW12m+ruPlJ9TfeQjPmYzzfT51r64j2qxm8PmO4gbO1
	 wWLFfuIkuIYnNSFULLce5GdxA7nUideuoDuYK98bC/u4wXCihnvFrkfJAf4ce5ZxXpQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788986903;
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
	bh=LK+XXQOOPIq3l7gFi26G0MfkLlHb9cHDZnlokgC+23I=;
	b=UqDqCcipBYpz7KM/h83/JvHPqdHl8zD6XO3lpaOWsTon8eS3stsQRGpY0gCcP1HIyPTb
	 BXW36pl8T0n0E1Ksv2K6/6B44dNS2VOm6O+3iSjSA2Ub3shULvt4Urdq0AVGDNFLE4ZAq
	 ZQlyZ80EXd+PiOMoD3U7REX9Zl5fdHK6N2Xfww1L7jVV2TWoUbZH171GSBdtFLK5BCHi+
	 Pl3wMvMVm4NTpvYfs4xxHyogm/K/37g6EXrVLXXv7hHq0bAoZqAA/pbYMUWq9tHlEtSRq
	 vSVn6wNQV89gxVgsERqxll+UgKCLGIDH2NkvqbmO0AhBrnsH/QAiSKQ586cWR6Zpbfw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788986903;
	bh=LK+XXQOOPIq3l7gFi26G0MfkLlHb9cHDZnlokgC+23I=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nNvfWJdToCQ5erPCw20T1zPQf9bGawxOsB9NBoq7aZUAThf7S/d8mYlPiQLoy13sb
	 nXjl6a6nAm6N3vRT2TCT/5RsHUWkCe1pC9OzfJx2vRnonRtXGXbZ8SpvNeChpjWIeC
	 M9hozZRjLyyFauLGGmDoIxZqvyi6Dk5p8SLBa/PwYzOS6aGyoP0bvrfXQNPHWN/YKN
	 lhKigdHDcnNwLs1xHK8bxg0oQng9TA6pJ92Sea4/GAldvycpxxZqyIyHi1G9ogZWPI
	 LGfUDQsGSr0ye84Yz5R3hvmQY+4WYCGyNpEQr0duUJpB18poLl7DdARbT1fqwUFLLU
	 N76og1FT4mABQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9C48A607FF;
	Wed,  9 Sep 2026 20:48:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0CC51724
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Sep 2026 20:48:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F134580E37
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Sep 2026 20:48:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OUL459rQ2Zya for <intel-wired-lan@lists.osuosl.org>;
 Wed,  9 Sep 2026 20:48:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E05A780E28
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=198.175.65.11
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788986901;
 b=B1Rs5OzizHxhL0IurEDSNDmGtb1AAjh/3sWaB0VgQSftxcxNDme/b5ojbFQWeuSWWKT0
 MLZ/i/Bu1CL0N3AfJ9CO6BPzrcf4wznWlmHs2XO5YPPllkgDFDVyXk8D69erNmSys5Scb
 3d87R1aKJccyyDfy2fR8y2ED0xw8dqr1AIDOMo509u38PX7PCk81TOtcdmmk06hzFuXj4
 05ExOy2lUp7VquWPsVr9iVRh/JVO06qmGmgAhoJk6u8pW4l6H2enu+wBqOA1xQ1h+x7kk
 LyowRGHpH/MqGwzNfgywNfQ2KF6ZXj5q4ozmaDTAVfb2ipu5sliuZyqUxSA6x42B0Ug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788986901;
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
 bh=LK+XXQOOPIq3l7gFi26G0MfkLlHb9cHDZnlokgC+23I=;
 b=hZqIXTLHhOUAnEZP9+StGLPjlpRJ2vnWJWmYvD5qrFr9h6i2RGAbnM/3D2Q5lvsA6SJ/
 hhIkLD9HC9hwUR+GHLnsdOU95HKR2SbEvJtaJRRdykZ0iJDFaPQdAcNXQ/M5ApAA9xkNW
 8a1rY9R7CZI0clCTqgK7EJwgXDGzh1nZpwa90BFeCQmRUhURR7TZXe70SL5yTqLbIds7g
 ij9n87kUZkHXtkZnhOeKbthEJh6B9qAP4IdakLOjOK+px1dg8t9zMbczwPDJxVO080Veu
 yQKsIcbfiBhUJYpI2A2xq2tVTFvumAebpB1L03RJKT1Ox/iSrJRgmMHpCF8k1JKBrTQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=T7S5ttKo; 
 arc=fail smtp.remote-ip=198.175.65.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=anthony.l.nguyen@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=T7S5ttKo
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E05A780E28
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Sep 2026 20:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788986901; x=1820522901;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pOhy+/gxlbivSaU+/OofkLrRHFcRP/mwuE4zikoaMfY=;
 b=T7S5ttKo6wC7GWQY3SbsfPqjddnO+DvNl0Y+20yxFKz/oNaYuZXeTnwd
 4RRQBtc7oulQMCT8XOgzodwmhL6Gyeb9uHcKVCzG2y7oFJKNKMRnVC6qH
 KBTZrA3HS1bVdZAUFPFJ0eM7/mY7z8RizML/446iyI8jzdEP0Sc4wybgr
 fNpP96sgyuV/2DXmSZ2wcPaG3WOoetX48OB3E/omtQI6kj/JsJS1h34gH
 KXVPOpgi60iS+oHVpzVhUxx70LAW3Yzo33Q4CX6+plJN7Thi+YXGJ/sYN
 7NEc32qwLVKzaAQe1C3wx3ZUBuX9TxVwo62WrBbvWmOtpSQF9dq/SsZqn Q==;
X-CSE-ConnectionGUID: xAiIP84yRteFIrP/FrfZVg==
X-CSE-MsgGUID: tw98VY3LSui2r2SKhIZbJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="99757029"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; d="scan'208";a="99757029"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 13:48:19 -0700
X-CSE-ConnectionGUID: 8S781K8LRB2g5vb8AOZybQ==
X-CSE-MsgGUID: nJwdLc8TRWipbXTArc0TdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; d="scan'208";a="274940322"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 13:48:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 13:48:18 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 9 Sep 2026 13:48:18 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.17) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 13:48:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awzd1i+S0WqgTuv6JxmAi4VmJtXN05YzzyZ0ZsXTspX4VplMJrs2ZGbM+kq6S04jb46k6Fp3Wj84NuFjxkTZUIifJLiT5pc73lFdT+020p574wZ+dtnYM70ElnTtFQIUFtjW48fldHjBGGXm85Jt3lH2Mzss47PPRukdiAGwMuKt8Y3BL43NO/Nd8m3Ja6yffLvpKYuDPw4v6uhYBHLcFDIN3eDbMa7rYvls4lWTm3cl8Rl13M47vqfjRZuyG1voFxuayEVI3jJ0s5J3dewnLq6NsDFne/p91SrrI0g1G1/dvt4JhhaBQoOsj2p8zqjaanztp3ovBJnrpqowE+4fHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LK+XXQOOPIq3l7gFi26G0MfkLlHb9cHDZnlokgC+23I=;
 b=rizb1tUefYRpkrzz1ypKN4BYjR8bw4a/yvoyIQxfBuoQXskeZE9byYvTU1nAG1kRgcbVpoRMXvkaXQ/0b2aH0YHD1uQQjUS8UhHiyx5walWeE4VoaHACVpy1EHMT1rgBi3Fl7V7kkXQqzhtjMmyNoeNe5pxGKMyJ0PGacrRy878FT9DpltCt2wiu4K3wBb7MMvx+XpYZbXfQQlVwqSwahWpGAe0Ov06As9wjiyauKSknnLLsad3J/p2nirUuzuM8tZKXEA72GmrBVYP+Ziylwez8I9pRUzCSULAnHanOBA6kDd0eWxMLs2lYTvyFAjuCXGIicMx+mOXUzld9mYjhow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by PH7PR11MB7606.namprd11.prod.outlook.com (2603:10b6:510:271::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 20:48:16 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%5]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 20:48:16 +0000
Message-ID: <cd12af33-ed01-4eca-88e3-703b59c05453@intel.com>
Date: Wed, 9 Sep 2026 13:48:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] igb: initialize PTP lock before registering PHC
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, Alessio Igor Bogani
 <alessio.bogani@elettra.eu>
CC: <przemyslaw.kitszel@intel.com>, <richardcochran@gmail.com>,
 <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <jianhao.xu@seu.edu.cn>,
 <stable@vger.kernel.org>
References: <20260830154912.2712900-1-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260830154912.2712900-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0005.namprd06.prod.outlook.com
 (2603:10b6:303:2a::10) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|PH7PR11MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: 666fdfa4-8802-4687-61f6-08df0eb3ac2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|6133799003|10067099003|11063799006|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZtUFysIHSuSlAR7SA4aokhRzeqYEGBizEDNDfQyCVaiX/CxtOdvaTP/vDtBjsmxIy64XivVX0COifwx27UL7xkA5yz2uy2TMckA3nAILv2mP/jgLAgdSNwfgIExqXszs9eUNTAnMRXTzl8If+FjbwNoLr/Bo/o+h5Y63xG1tK6iY3C8sN4+p1mm65DmF7ic5BF3XMeGb61lQ3YAQHvIAN68zv+YWw2lIcfsIVMW/Ey+QOUtgYqPt/6bsnkOTGoAYZ1xtf+pgSo+1VYmCQrU7/PcnNHIEIRudSaYzAteja75hC6tV/bSSHPPGvqBXRJNdrzzpuDPkLj60eRPqU7gmjGoDaSC5/x2lzHBhJ3Iy+b0T30D8u905Foe0iYSSpQjtqr0FdS/Y0/eNUDBGndUlt3dCN5kM+cPdjjY6fYMFFsj7bC/941khfdbsB6R2WbsDcnk4FncjPTtZ+2/mLJhfbL4mXG7vDtCjoRzESJt9Bg1LcPIKWXAAT4ysZMqgDyBJy2cp8uvi5zk/f4/X1vDPhYYThKNv5T5xWS7P+mUIRS2xUG2IHDmzamrFvmdfiyRseM0mWY7Sz5D5EjEp7u89LJjmbV3JIeOCw/lpbyYhvJvIOai/jHmXvJIkiCE2H5tkgMufUcYI504nALOYNE9OgO2utrxpj9mLRp2Wns0dZHk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8230.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(10067099003)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFFpNHN4VmhFYmZUUGtCYkx0SjViejFwSW4zK3pZclRoMFZPYjBXaVA1b21D?=
 =?utf-8?B?bTN4dGY2Wm4wN1o5QkhVczBTNHk2cVBqczZyYWk4NnFlclZUU3ZBaG44SFhv?=
 =?utf-8?B?bHNzMXdGY3prUFRSZktza29xYW8xWHBZbkNMeXBGQWkxYi82OUZWaWJDNG1E?=
 =?utf-8?B?L2JNUHFuK3FuOUgvN05zZzRQVWxHRmc5TjViV0ExRy82dHY5OFlESzNjZVdE?=
 =?utf-8?B?UDZldFlITHViTHFFMTc2NG1mNjZtclhtd0NCNUlGeHhPK2J4TWplRUhhN2Vy?=
 =?utf-8?B?d3ZYeXJaMUNER3FkdnlXMDgvSXVUaXlrSDlmWEJmM2hCM3VRK2ZNUlR2cSt0?=
 =?utf-8?B?eUFwbXpGMGdFT3JtTVhRUWlQOG9GYmhMZ1FBcFZtbVpTZElQME12NTJxZy83?=
 =?utf-8?B?aGwyQldzOFI0S24zZGlLR1hhcndaZnpyOTJNaCtvNkM0eHFnYWpaWUxBRzIz?=
 =?utf-8?B?NENmY0E0Q3I4VFpLbExpRnJlRk0xcnJNODNvV3RSU3ozQ3l5Y1RxOFF3aG9h?=
 =?utf-8?B?NTl4U2plQk45OHpjODF5ZlBIRGRGVlRnR1BTbklkL0l2L2lhWXFTamYrbjlt?=
 =?utf-8?B?RzdvbDhtQ0ZkaS9iZFlCNTZGMStRbTBPWk92NG5SKzVRQ2F4T0xFTTBoU05T?=
 =?utf-8?B?Qml1a3h4cmV5VkRmVkVaQnhqT3prZk93Y1RlSzc1NXlMeTB4S3pXMGRYTGVC?=
 =?utf-8?B?YWJTYXAvTTFiOTlBRXk3blNPNDc2Mmc4SVRmZGVVL3Z1dzRLRW9jd3pTaDVK?=
 =?utf-8?B?ZWFHajYvcTNmZnpRdEx6SmJBeDdjbEtaTHQ5cGQ4NnljdnRRdlVyOWNsWjdX?=
 =?utf-8?B?Z3N3eHlRNzBBTmIxc1d6RjEzMTZXZGM0SUVNejRzVENKRERuaGNrYVpPTXJh?=
 =?utf-8?B?VEhFd2N0c2RNcTVLaWNGMVg0YTJ6L0FrSGgvQVdEeG9LMXZDTzBJaFk0QVVk?=
 =?utf-8?B?Y0tkUUlPKzQ1VXhNL29uVk13Z1B3S3N2Vkd1NjVOMy9nMDRMZjZhclVtRC9Z?=
 =?utf-8?B?NkZqRnN6dGVtTHo2aTROdXZ5ckhpeU5FaUtJVmpUUWxOa21yYndDUTA0Sm8r?=
 =?utf-8?B?QVUxL25nTWlqalU3TUxUUE1IN3p6V2pITzFpelFaWmRRS0ZSMHpRcXkvbk55?=
 =?utf-8?B?SDRsZ01sU2NVZVExcFordmFXRTN3RGljYjA0RUwydHJld2M2QVhJUEs3WVAx?=
 =?utf-8?B?ejJ3ZVpHUDMxaDQ5bE4yTmNIMGZUQll6a3ZiSTEvTGZqUTRKM20zeTB2VWgz?=
 =?utf-8?B?S1gyelNEOUljeWkybUlBdjZmY0ZKcDVkQkZlcURnMFRISGNjN2JhWFJRT3lF?=
 =?utf-8?B?M3ZaUjNIWW5FOXBwMzFwUzBqSU9PNnBzYTg3c094RVJ1Y0g3aEdXTWptQm5B?=
 =?utf-8?B?UzNOTXpQVjFGVGVjVDZQQlY1M0VGSEN3VUJSTDJnWFRxTnhUdGQ1NmR3K1lY?=
 =?utf-8?B?QkhUNGE1U3FwMk82bUZVbnE0UG9TcGJtRVdQSE9LL1NNOENLOEVUM3NLYS8z?=
 =?utf-8?B?cmNsT3ZSNHcwdFNJN1A1NjlJcnBEVm01Q3VEOGJPeGpYcGwzT0NTRWZkODNX?=
 =?utf-8?B?Y3JWb0FZTGptZy9wYnU3akcwclVndXVrRFN6ZDYyM29FQXZGT3dISFlyZE43?=
 =?utf-8?B?dTFCZ2pWMmRia0NWWCttREZwUnRsQVhKNnpmRGRtSVphQ0prakRlVkN2VERM?=
 =?utf-8?B?bHVFWmFjWUxUK1hJSkVUM1JDZGtLYW1HVmNNdDFuUk5FeStqSTNLT25wOVBx?=
 =?utf-8?B?YVIrQkpGKzVlU3Rrd0tVTVFRNDZFU0E3cDlZK082MDd0Nmh6Mmk0a2RDVFZQ?=
 =?utf-8?B?Nmo4eGRrUFZyMXhkRUczSUM2ck5ML2JJajR3RlVrQ244eklWTStGQVBaTU5L?=
 =?utf-8?B?TTdHQk8vVDBNdWNoQWdlRStiSEdjcmlRNDVtTlJ5Y1ptMW5RcER3UGY4WmxH?=
 =?utf-8?B?TnFGd3lLd0UzNCtQYjVHUEJEaWtFUEY2S1pISXplbzI1VHlJcVQ1cnJIbzJV?=
 =?utf-8?B?U2JDd0NMNWFxaTd1cUVHK1BkcU0wQUI4eDFReWM1M3pPcStEVVhMSStZYkZy?=
 =?utf-8?B?K3N3NkJSUlhudTM5cUxhbmhsbGVtSmtSWDJ4SjlIZS84Zk9NN0NSNnVUQXY5?=
 =?utf-8?B?cXdjRUtJN3dsa041NktTR1pwbVVvOU53UE91dGg4NEtCNG1kanFZeTZ6cXN4?=
 =?utf-8?B?VStscFA4dFhWOTNvNEpxcDR0TW82R2YvRWw2UGoyKzhheFJkbE9yVFpLNW9Q?=
 =?utf-8?B?dXVlWjRzYmZRUWljaXFWb1FFaENKa3ZIRFpML2c5NzdpK0dDcGFVY3hRdllr?=
 =?utf-8?B?MjFxWlhOY2pjYjZLeG5iTlF5M3pveVlVRkZhbnFuajdJeUdHYmZYUE56KzB5?=
 =?utf-8?Q?84EcCvP+r8mfjSEg=3D?=
X-Exchange-RoutingPolicyChecked: PhBn4v60GSwRyLvMBwJSaAH5tWfieGs5yjz1Mc2aQzrzf26/PFpd6QRGK5kJG1iFxqCP+plw2NFqgB0lmrzKmFo/805IuH3OVHlm/7gGvm8RX0125FWkmoBtdmRTZA+RLrDMuouzlfYIxh6qIVldqCnQcSoxG822wxpaqI3CLwOK3PClu9Q0ZeaUYqp9qw98hHj8gQLJkkUmFzwsoh7Cji0AUhqRXpPC3b3SgPxeg9kYwQKE3pAQhG8cRWgK+dqkCn7HvD7EiR6cMM0rrdGl3FopSYv0YjYcsyepkt+Fz18rpYcGwVcxrXqnlLUH+antKlYAmw2HpRcDLynISA60Rw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 666fdfa4-8802-4687-61f6-08df0eb3ac2b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 20:48:16.2375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SG3r56wRZnbLxcqJPKnhb3S39vhvHyw9emc/aiJLdss86Nit9o3VYrkV9SGrYUTZO1eWxtFGl6DnYyKu4BKxNhZafQWQwJc5q/QIQsPEmSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7606
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

+ Alessio

On 8/30/2026 8:49 AM, Runyu Xiao wrote:
> igb_ptp_init() registers the PHC before initializing
> adapter->tmreg_lock.  ptp_clock_register() publishes the PHC device,
> so a userspace PTP operation can enter a callback and take the lock
> before it has been initialized.
> 
> Initialize tmreg_lock before registering the PHC so all published PTP
> callbacks see a valid lock.
> 
> Fixes: b888c510f7b3 ("igb: Avoid starting unnecessary workqueues")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:GPT-5
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>   drivers/net/ethernet/intel/igb/igb_ptp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
> index 638d8242b..2a4ea327a 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ptp.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
> @@ -1378,6 +1378,7 @@ void igb_ptp_init(struct igb_adapter *adapter)
>   		return;
>   	}
>   
> +	spin_lock_init(&adapter->tmreg_lock);
>   	adapter->ptp_clock = ptp_clock_register(&adapter->ptp_caps,
>   						&adapter->pdev->dev);

Sashiko says:
This isn't a bug introduced by this patch, but does this expose the PTP
character device to userspace before the timecounter is fully initialized?
If userspace immediately opens the device and issues the PTP_CLOCK_GETTIME
ioctl, callbacks like igb_ptp_gettimex_82576() are invoked. These callbacks
call timecounter_cyc2time() on adapter->tc. Because igb_ptp_reset() has not
yet executed at this point to initialize the timecounter, adapter->tc.cc is
NULL, which can cause a kernel panic due to a NULL pointer dereference.

>   	if (IS_ERR(adapter->ptp_clock)) {
> @@ -1388,7 +1389,6 @@ void igb_ptp_init(struct igb_adapter *adapter)
>   			 adapter->netdev->name);
>   		adapter->ptp_flags |= IGB_PTP_ENABLED;
>   
> -		spin_lock_init(&adapter->tmreg_lock);
>   		INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);

and:
This is a pre-existing issue, but does initializing this work struct here
leave a race window for list corruption?
Since register_netdev() is called in igb_probe() before igb_ptp_init()
executes, the network interface is already visible to userspace. If
userspace brings the interface up and transmits a packet with 
SO_TIMESTAMPING
requested, igb_xmit_frame_ring() can execute concurrently and call
schedule_work(&adapter->ptp_tx_work).
Because the work struct is uninitialized at that time, enqueuing it can
cause list corruption and a kernel panic. Should INIT_WORK() and other PTP
initializations be performed before register_netdev() in igb_probe()?

Tony:
Even though these report here as pre-existing, it seems these originate 
from the Fixes commit. Everything needs to be setup and ready to run 
before calling ptp_clock_register() so we can't defer starting these 
until after the PTP register. I think we need to back out the fixes 
commit and add a proper CONFIG_PTP check and unwind path for register fail.

Thanks,
Tony

>   
>   		if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)

