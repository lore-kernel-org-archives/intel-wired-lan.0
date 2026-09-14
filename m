Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D04C88E64
	for <intel-wired-lan@archiver.kernel.org>; Mon, 14 Sep 2026 09:51:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A63E760684;
	Mon, 14 Sep 2026 09:51:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LfsKh_KyorGq; Mon, 14 Sep 2026 09:51:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0AE5A60689
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789379509;
	b=kl0MzQ4MLWPYiD0vePEmQOkPB8QUMaVJHp1iSp3yNlz83NK3PH8X1lUcBtDkBB+x41Us
	 kowM7pHyL0Xx5jDLB/GN8IyDfWj5gYupS5uhxo1ZwkiUGCy79iK9D2PL+DjCBeyBDsB1E
	 29MpubqnMW7akbjM7hhaTQOmdrIZm0Tczfmf58VP3jtojzgDKeB7Tx4IJNci9fHCQW1MK
	 FG193rkWTlMaErpGpBkBBrPaNIgcKc74Qo5DRRftmFnkrj1sRT7FUvyDvWJgIJe2dX7GO
	 SWy1pDE1FPGnligTsXi2zEaegRq7nLE1uT7S1psPjS5jf2NNTURy3bg7W/BSnf4sung==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789379509;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
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
	bh=NCi43l5//WBbs/pJ2vD5rXmheEvF/dQMUBPohGaRy/s=;
	b=mYEm1HFg2us/safJMiubNgv8fitp+lf2+I5JYDTEWLr9cJCERYWPLVFd9rEhl7gdzTTO
	 xW33bnDVsqD3AfZhhF+WhH93w3CFiqEWcrASRu8u5QOtSYFEEPy9Nl5y1+1sEKtJJ/4yg
	 tjwy9jA0aQp//Rhte9RlwtpOJc0jY4y9kNTeys4I1gtruut1PEQZkF2TTsqAVrube0MIO
	 7+vLo5E/ZQO61acMFO4LWgjBQrAgAMuqB9B13m91YIRzoETu42pYaLw9GoKvFBQ8Wzrtd
	 SunEnhxlOBiW/OB+cAb6podfcoESza3vcX523X9ypZ1FLQ239iijw5M22FKXhpxbYlA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789379509;
	bh=NCi43l5//WBbs/pJ2vD5rXmheEvF/dQMUBPohGaRy/s=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6JmqYHc/o/Q8Rd8vkYKAVrCba0JcifBHyOhG+SHcpBGGuVtPpPnvHOQRcGBpVFEn+
	 0LD2NiSWjtM30j4AX/Hu1YpFnxVp81bEdfdYwV5/0eRN+5vs9foZX21J0Pdyy0E+zu
	 SmEyolKq4PuR9U2FyBMfhig1rRVPmxlh7niZfAQuaBKyK9vRYQn9Fwwpo0rQSq4UBD
	 Zam0SQ5yDRSI4hldjD6Q5CT4YzGIHg2J93VxX5jg/xO27ysH1hDYOiZVgy7d6LEfUU
	 f7n6WT1N9PVswP/xGZhOTKvUKYCtxZk4BpbxVNLijqGbTWqM/FNDsDPPaeCnH4AoFn
	 9thw0hCEQNbPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0AE5A60689;
	Mon, 14 Sep 2026 09:51:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AC259465
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 09:51:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 92593405E2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 09:51:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XHuzQgFAoKD7 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 14 Sep 2026 09:51:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B09F7405DF
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=192.198.163.4
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789379506;
 b=i95tDL5TnJa1XWwR2/yNTnIKrvw+fVDZ6DTE3QK3FN7yGUCIBDw1ZkWBNvtlHIxIqANY
 B/79xpK2OZSYcBuv/nt13mFeG22tHcC+s+W4eHIe0z9PNdxIAavXg6WGvN1HGKoMxMr7Z
 qdvCGbKW7Qc1MM4OL+EhvPfZDVsbZjCEUFYIl2UafVpTrcPpHd2ufZUxQeOQMqbORqWtz
 f3bWTqW/VrYt2V2KSGXCnHoI/OJWkSjutGyWytoj2vkmyPp8OsTGjnCiO0ozoMCe/Fx23
 CCd66usbQER6ugVYeWzDkt71/cvwX8FoZ6lvbVB7WZZgfBC4ZKoB2eek3qSgz6zdYcA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789379506;
 h=X-Greylist:Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-IronPort-AV:X-IronPort-AV:Received:
 X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:
 Received:Received:Received:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:CC:References:From:Content-Language:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
 bh=NCi43l5//WBbs/pJ2vD5rXmheEvF/dQMUBPohGaRy/s=;
 b=N5g6Y5xWcQeuckyOt+9f0I1xXjnkYl4ZPBgLLi5RlzLbWhy2nowf150WHmkeRYHsPuE0
 NG4fciEWuto+rW361XfB6ZTkibbrEc5JFYWpQe/ru44EFYuuCAoVp+wJxL0AUGd3bbVIz
 /QTY4wJoogmK3sUXV+h7qeZwICVUwxEM059vgKXFdjNHY42lh71js/rLO7OJH/IS5rwgF
 bKqHUI+hV3H4FoJ8r57JcA/s80x9b92tFT/KwzawejLw5MlYidxpEDs3lFImUmzi+9rcm
 EckqSwLSUtaZEnzZHl4PFAmEMEVVu0So5iKTCM+nyRem5GOW5qD8BYv2gX1qV0Yzcjg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=U2tYwNAy; 
 arc=fail smtp.remote-ip=192.198.163.4
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 14 Sep 2026 09:51:46 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=U2tYwNAy
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.4;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B09F7405DF
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 09:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789379507; x=1820915507;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cKVNOXQl+zi6vhIPk9VYJ8gaRrsjcTSZ+mfeSHt34kU=;
 b=U2tYwNAymKLu2zgAYEggIsB9OxaMlwq8Rrudb6JlPOme1aFHoOB/gyfS
 gvLRjqomkJ/Et7ulNSllAzrUl5iEJsGMgDfrdpzoAwLh/B0fsImDCdguw
 D/pxcRa0Z2Ry3wPEcYYfrp0jLkeOURNsX3uGowTlUyiVoN1aAd8n5MqTx
 +8fJ7xhiLV1raqK2zLS+i1eEuIH45QN+h9DKpVRiQnfvq9gCL2j97NCB5
 vWIQnW/V6S44ZCZm87mDwQTDz6cHdF9tH5BU1wdaQmxJlRdVjQ/x4H9kT
 ehNqH8r1EEEUVb65lAj49Xs5sQw4POnTWauKP7HAsmpVor1v14skD6bcb A==;
X-CSE-ConnectionGUID: mPwnbpXgSRSFN+qt8TbODg==
X-CSE-MsgGUID: PSxbV9lVR6uFRYan/smUUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="239557"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="239557"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 02:50:43 -0700
X-CSE-ConnectionGUID: pbSkmvXtRFSYkDSxcxYy9w==
X-CSE-MsgGUID: MMlhsyowSBK4lb16FE04bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="268303372"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 02:50:42 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 02:50:42 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 02:50:42 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.2) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 02:50:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJj2uNTXKW+Zypxp+b3COwfX9h9HS9gFQLhZtbCzYtLoluCHzIj0Brj+LyYVDYaAStKPe2Wj9TtEciABVc+GHVjKttioe1Y8ZX99IoyYnVuToJ2m74aRQsSnB1tjgKJYGAy4sQXymKHniiKXrouUyLMxmkWAAnSS7ivqDa48G/fxMAJbtIUhLDOmjqXMbLv1mI13sBE4z8FIy4+pGeKY5BBml/ABKcJ5ycmNqqRUVS4gulITpIAT9cRjxsgRCJ/Afl47n4Us5iXEwVTb3z+E0/5mc1zRyslztVWnW+aHlpb5UM/GFX7CaEjoIkBZD3tNFfItNyDNhYFOOcCIZv2WDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCi43l5//WBbs/pJ2vD5rXmheEvF/dQMUBPohGaRy/s=;
 b=IeqySSeqLgwTBzSr9gYjMWyP7+rlZU92qq4t1KBGh3b/TPLDwXRWH3pWkHTQlaXgNlek1xFddIo7DHuuZkw/QgivksYpsOA3hyVo6qqNu+8ILibYeFk9L3VGZqCfoTk7gJBl5+qpi6e1H6KVPaFlHDAqezVe4KvOHXnUpnWwsJs4eVjCe248zdW4/GTlim+R6NVjsnON9tSjvHc79neIwUnJzD52JAcUav702UiSwsBhBzuLujJX23r5dZ0GtYKqbMem15je+VUGlR4XOzdupN+YGXxq0ME34ISinkv7F2VtRSIjlpEAMjyPu8IH/0biIoRuLq4xC5DmlufC2QU2tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by CYYPR11MB8408.namprd11.prod.outlook.com (2603:10b6:930:b9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Mon, 14 Sep
 2026 09:50:35 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 09:50:34 +0000
Message-ID: <4ad84736-f0cc-4ac6-aee2-8b21a5b8b8d1@intel.com>
Date: Mon, 14 Sep 2026 11:52:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ixgbe: fix incomplete ACI command buffer backup on retry
To: Linkui Xiao <xiaolinkui@126.com>, <anthony.l.nguyen@intel.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Linkui Xiao
 <xiaolinkui@kylinos.cn>
References: <20260912013403.2818191-1-xiaolinkui@126.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260912013403.2818191-1-xiaolinkui@126.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIXP296CA0009.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a9::14) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|CYYPR11MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: 9981f3d8-c6b9-456d-30d1-08df12459f1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|6133799003|10067099003|56012099006|11063799006|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info: 8RwZXICT5kSSWhnUbtJzEf+uTlKMQGi5y+R6NFZ9fJ7B5WA2raVfzysktEk4hRbTP2CkO5z+SVNTHWz7v/WSXiy5/s7YQKwkKTVWtH+aL38wrcW7kadBKIKR/8H6PURCuUIwknaQ8Qt9G0gFzrMNcJEPfnnETtlsnNglMRsEZOv0m5oZ0TmKCBoadpUXvjfdUq8QsEIQBgv+SpWophEdLvnZFLBzMNJUtS+T2K+S2AKxNdC04Tma0c+HuvuIRgJ1GAO28jTugKDRtH7svfqJY1KN+s9edmyhYNhJW0Y5NSAOWqaucHVnCkUEgyi7PhAAHqmR/gHpNPDtuEfedavyioWABJSkvpwGunfvoR88zo21wj1F4HNJhD8W/WsqBa6jvzbJdWk54pbULAZQwPZnhE9FAAI/i6pBljkn90a6JYTjgjLMMNNlHunAYxt4E1Lz4JZkinShfyI0l48o0QUe0HSvY7HzJtF0R3WczOlBE8U4jmOy7zxohuJmy6pwEqRahDE+uZyKt+YU3X3yanGqeXLKyzuvrQKEQjNtFOoNvfOMzz1KhoeI8re3748ILA9q7pqfavxBoY6LPP01QP8YRPi0MaBw5mMXL97k+0jFdAoRekppMRjR1s3YWaNQPbCiJwp9y5Iv8dvGx15glUupMAC/xqpm8YPb9jfpEiqffHU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(3023799007)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVpVR2JvaEhqOWVyQ2JtU21nTDJmQVlNVEFrZDg0ZXluNXZ5OFphd2xudEhW?=
 =?utf-8?B?a0VhWGhvSkx0NWpCOEpTREhwK1Y4aUxpdnBQQStyU01GVm1xQkZJZkJhZnk3?=
 =?utf-8?B?SnFhMzRvaUtMbWQwbVh4VWRKajFHVnpNR05HejM0NDdBTmxOMG5jaWJUU2Jj?=
 =?utf-8?B?STB1SW94ek5JTXVOL2RsQXJ1Z1JCKzEwTjdkenRZMUNXcldSaGRFMDBTRUVN?=
 =?utf-8?B?S3UxN0RrWDZtdFpSVU1SbFFrOW1jbXkwTFMxUHhpdm9VMy9OTzVWOTBReEtT?=
 =?utf-8?B?UDY3QTB6bXlqQm1hd1hVcTZEdVVYQUZzSUVEanpCeVEvOUFUcHVwTTNHTWdk?=
 =?utf-8?B?ZTlVRHNhdkpHVjdzZjRuaFVucnpZS3JjM0RwMytHQkh6a1hpeTlSdEwrQk1G?=
 =?utf-8?B?cEF2cFFiakNVUXp5ODBrMUQzYVRDbVJGVlB3NllVOFhxL1lWS281Qm16T0wv?=
 =?utf-8?B?clZlYk1vakNNV2FOU2JJME9CK1hvUXcvZVVpODl4U0w0RUlDUDZ5aXloOVEw?=
 =?utf-8?B?QS9uTlJVYUROaVRGT3RLeURKeU1ZZG5sa1FkblNML3FHYVd1Wm5YWDVzYzNs?=
 =?utf-8?B?ZXBUWHVlZ0hRUTc5YmRQT0d4bVRIL0NuVkd2bzJSTEJxSURoZmRIZzRLUHNB?=
 =?utf-8?B?N1ozdFVZZk1PbGJjZ1VaNjhNenNFN3FxU0pnejg4eC9VdStrUU54Y2N2Vjkx?=
 =?utf-8?B?NU5vVjloVkd4UmZFQlk2TEpId205Y3lLWlNtRkgyNm9ROHNhVTQrMFVyaG1u?=
 =?utf-8?B?RmNPV1VKZmdGMkp5S2FQWVRqQ1lvMkp0VnZXTzB6TE92S1N0M1IzblE5MEtD?=
 =?utf-8?B?SFBuZmd3YTU3MmtKK0FwRFE2Q05sdml3SXhacGYvUExYcVR3eWhMSEdxbVk5?=
 =?utf-8?B?MTREd0psaklHWlhZQkh3YWkvRUZLL1YzMnZiUU40WldLbHJDVzMwS3VCNmll?=
 =?utf-8?B?Ly9sNzRBS25CdmZYT3VIanZGWE1sY2czVmwrTXJLVG5mT0VMZUJpdU1US3U1?=
 =?utf-8?B?cUU4K2tGaEZSTlBkUGVKb29kR0tOc3g4aXQyaHRtam1VdC9VZVR5VUZLZTlh?=
 =?utf-8?B?SG81L1U0eHVaUlVqS0Eva0UyL25hOXNFMWh1dm1lem1vRzVZRUJtTDAwYjNt?=
 =?utf-8?B?dk1jVDBlZlZwRXFWd2t2aGVacVV5eVN5bWRKUjVTOUkwMiswQ2x5VlY4L1Bt?=
 =?utf-8?B?WnhLU2xWa1BOSjRLYzBvVWRZMnZZekY1aE1lMWgzb1lqcWNjK0pWa3BLbTkz?=
 =?utf-8?B?TnBOSlFiWXZzUnc3RUY2VHNza1hrRWtPM2J3bE9JU0IyT2RuRHZ4Nk9aUUJl?=
 =?utf-8?B?NmFjN3lid1Z4NFVvT3Rzb2QrV3lCU0t6WjJhdVRneU1mQzJ6ZlBmVkVsK0pw?=
 =?utf-8?B?VFRNc2hLU3pNdlNPZlVXckNtLzJGc0xYa2ZsN1F3S3hMZ1NuSkUvVmdhM2dJ?=
 =?utf-8?B?SE9wVTU2TU1ER1VhNk92THd0QVl4Wll4Yytnd3ZFSVpYL3E0RFpPbjViQnRk?=
 =?utf-8?B?d1hhZHJNNHBiYjkydUJyMldreVVTZGFUN0VSeWFUd3RjQTVqL3loYmhkY1Nk?=
 =?utf-8?B?TDhCL2Vta2lIeldEZWpRYkJKd2xadWlkemdWWmdWdDVQdXpwQnVJTlBrVzZT?=
 =?utf-8?B?R2F6Z1hzc3FjMXFXdFZFZmdaL2ZYSXFtREY0LytiZE9sVGFPTnBRRk0rVFN5?=
 =?utf-8?B?VUdKUEZ3R2FLaWlPRDZoaE5RMUtUVFlldUhQanJlQU5zZTRYeWFWSmJLZVZ4?=
 =?utf-8?B?WGQwUDBkclNVWG0yaUpqZUdBeUlCV2ErMW1nUitQdkJVZVRhL256enQvcWdl?=
 =?utf-8?B?YStocmtlVHJYSzk5U01tcUt2eVVUcUdTOXErdG1iekE1UlFVamJmMHA3TjZI?=
 =?utf-8?B?MUZmSy9zODZFOEFaQkpZTXUxZHYvK2xkOE1tcDdVMnhNcThiUm9JWFc5SWpK?=
 =?utf-8?B?T25sLzQ1TjJjZDVvMmZxNzZ5ZlIwMVRtM3A0WmtTNG13eG1mQVI4QVV6U3Fq?=
 =?utf-8?B?RlpXbDZacjBlbndLL20zR1dodlNPaW9kRVQ1WTVaa0p1MzhYbm9SMy9GWk9x?=
 =?utf-8?B?ajV5WFYxZG9BeXFqMCtoajhXS2wySDkvcmlhOWpyWENjODF1b2hlRlpwSkNy?=
 =?utf-8?B?YUpBU25vZHU0RDdwUWJTZkFpMGYzMEJjVUdpZkkzTGtJTHJqVmJ2NTJEakxR?=
 =?utf-8?B?ODNuZUcwaGRGeEw3UlNsdGNYSkNYUldONmFpWGxnelB6VjFWbDNHNUlNUWZE?=
 =?utf-8?B?aWNhUzNnMC9XeDdDU09lcEY5alhubytGUjdpdThYL1VUczQyTlRNVWY2THNS?=
 =?utf-8?B?MTQrWjAyWHNhNTVVUHQ2bEs2VTM3c0xYSEw0MDhReEVyYkJqenhsbEdzWnla?=
 =?utf-8?Q?VSNw619UuTFwIRpw=3D?=
X-Exchange-RoutingPolicyChecked: pN/ZEPSu63v7TEGSaD2Evx02QUazoegcLSbAgO0oQ6ZFDgQXgqO64Euzen2HVxWXBNffacs66AJcGTEP9PDla2DUC0rsVL2xRmAmN3Ax5uYAm8SWMjUn6GF1BNsABRYSAfBfMLO7adIjQcPkMbZuztvB3GjG+AVNVdcgsqFoBFjT3KsKeqygu3gUOXdzTdLNFKV90UuHhBbdabKpCjLeP3VjR64goBT6zg1uU6yW51yZIftRrt/TPuchZbDWtMMVorn/k7QHFVruWL/NXoT90Bu/6VX9MXwYPYQoGW0r95UlG3trXHRMgeV63t9d+GL275LRCDwz8KvqBVtu1u5AjA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9981f3d8-c6b9-456d-30d1-08df12459f1c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 09:50:34.3403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xnFAq1/NmmRVYCnm/rgdmRnD7SFEq5jxInJGYNNx8kJ7Je5FFPMHdrKqOJIiebiNRHxRevwv4HWPtQk7oN1kqr4WFxI6MKqiDf24oHBEWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8408
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

On 9/12/26 03:34, Linkui Xiao wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> ixgbe_aci_send_cmd() backs up the indirect command buffer so that it can
> be restored before an EBUSY retry, but the backup only copies the very
> first byte of it:
> 
>      buf_cpy = kmalloc(buf_size, GFP_KERNEL);
>      ...
>      *buf_cpy = *(u8 *)buf;
> 
> while the restore path copies the full buffer back out of it:
> 
>      if (buf)
>          memcpy(buf, buf_cpy, buf_size);
> 
> So every retry hands the firmware a buffer whose content, apart from the
> first byte, is uninitialized slab memory, and on a read command the
> caller's buffer is overwritten with that garbage when the retry finally
> gives up. The buffer of a read command is an output buffer, so the caller
> does not initialize it either.
> 
> Use kmemdup() to copy the whole buffer, exactly like the equivalent
> ice_sq_send_cmd() already does.
> 
> Also skip the backup when buf_size is 0. kmalloc(0) returns
> ZERO_SIZE_PTR and the single byte store above would write to it, and
> restore based on buf_cpy instead of buf so that this case never passes
> ZERO_SIZE_PTR to memcpy().
> 
> Fixes: 46761fd52a88 ("ixgbe: Add support for E610 FW Admin Command Interface")
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> index 4d8ae5b56145..5dd88ee7ea58 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> @@ -214,11 +214,10 @@ int ixgbe_aci_send_cmd(struct ixgbe_hw *hw, struct libie_aq_desc *desc,
>   
>   	is_cmd_for_retry = ixgbe_should_retry_aci_send_cmd_execute(opcode);
>   	if (is_cmd_for_retry) {
> -		if (buf) {
> -			buf_cpy = kmalloc(buf_size, GFP_KERNEL);
> +		if (buf && buf_size) {
> +			buf_cpy = kmemdup(buf, buf_size, GFP_KERNEL);
>   			if (!buf_cpy)
>   				return -ENOMEM;
> -			*buf_cpy = *(u8 *)buf;
>   		}
>   		desc_cpy = *desc;
>   	}
> @@ -234,7 +233,7 @@ int ixgbe_aci_send_cmd(struct ixgbe_hw *hw, struct libie_aq_desc *desc,
>   		    last_status != LIBIE_AQ_RC_EBUSY)
>   			break;
>   
> -		if (buf)
> +		if (buf_cpy)

ough ;F, thank your for the cleanup
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

>   			memcpy(buf, buf_cpy, buf_size);
>   		*desc = desc_cpy;
>   

