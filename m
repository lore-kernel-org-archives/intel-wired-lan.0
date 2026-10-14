Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896D6CC6B2A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 14 Oct 2026 22:59:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A147407ED;
	Wed, 14 Oct 2026 22:59:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id whOoZBiYEyOJ; Wed, 14 Oct 2026 22:59:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 40E86407CA
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792018756;
	b=OAeRwTUEf8Kwmg4IVYaz3kkuhF6Yco905hmTdwysW3NrrSyIDjba0xvxOpgSl8EgNAi5
	 m8XXDHGuSAL9pryW1XT3GpuHbugXIQt/d3s18byPXkDwN3fYwFK018xJ4CsifHD/XXY6b
	 Yc6pUv5n/mE6ZYXwOKZLSuK8Zq7DCXNvrry7KFdnl/xFy84zYRDB87+DxirF2OXGVt7A4
	 dEeMa43EfrEyGuaVl+H9EM1Dnj5O4WUTxnHLL5BMVrW8+oJUahSghKtERdPUZi1c30/jj
	 nwRIlZVPE6C55OvqOJpfW/jCY8h6Mp9CClXaevA+IEz1fqeTu4bNhTuzOGhUgUHI+KA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792018756;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:References:From:
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
	bh=XBMV0htv2tJDRxh5b6oV5nizSRlI6vjHA+Vl2U1pugw=;
	b=ncsR1jnUnqiqngSe8scnoJQjDmaiks4kxJuttf3a69rFFzIGuTxsK6gdFr1gRi/E2Q2v
	 VMLWG7VhcSBL2MsA7kmKmcOqE87vX0SAAinP60QSNzaYGDIBMoW9OVr6YIdVSNyo2MZW/
	 8pw/6PQLVUP8vrcKxoGwp69TJjbq9Kg75H8y+3ujg0Tn/Kk4kNwuh+/9Hw7++LCjMSR6/
	 hjZae/SOZWPHFeRR7OI68L6L+QPmrKujemtogqr6kwEAV2sbChwmlHI6jO/HoR+6dPOLP
	 daSmi5/8OAeTWBvs43lY0Z1UXVwOPBSKeuGeMGzibpabi383mCYrRIm7PLUkKZ5BUwA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792018756;
	bh=XBMV0htv2tJDRxh5b6oV5nizSRlI6vjHA+Vl2U1pugw=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UgPik3bjcWwSrevRSFtPElzP2T7Zof5Yg3qz52lGpcqVmsEAdNzlTJN+RnbuSmYIc
	 TSrBTf5HJklYnOBbBw4W/OM1wQMygJJTQP+BBxrA4GMKX+uPh9gbnEhiUj54cVYEo0
	 4ElX7q3eSKbjvEnoyO41uiJaGcYaqRcaL1czRF5w2Ymj2txKe1TQ6V5cLUPg/sm1Z5
	 1uNQG6bHCNJz5DiNKZxqPi4kuqOiSdP2R/0R69wnqGeFzocasI5ViEy+9xT/6tzYeA
	 CQdkTRsQdz+LeAKoUZFf3desE1/I+ZKTr/7BlCS2RlQ2b2qRtNqVMogik6HAyOHojm
	 5p3ZwzVl5owSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40E86407CA;
	Wed, 14 Oct 2026 22:59:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 863ECE4D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 22:59:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 77D2B80F86
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 22:59:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Df4QHk_FwZad for <intel-wired-lan@lists.osuosl.org>;
 Wed, 14 Oct 2026 22:59:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5953680F59
Authentication-Results: smtp1.osuosl.org;
 arc=fail smtp.remote-ip=192.198.163.17
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792018753;
 b=sNEnuKJsn6dXY+WqDY0tS6h9bnlMpHGJTkDIRCbF4nbxc/3IBrKF2f8kFokWRguL3Kem
 vSw2687Fx9BRu3t9Yr7KSp2S2Tey4KT6fsGxvGXoqHpAFBUJ3mnHqjRH0D7W8taE2d9ZP
 EgzyTHrYBpVRfRXYSyWR3ht9c45TjASW6tcMfThhcAFdvM2XnmCZ7ZO9ob9ZiGwhBfBq0
 3WAGKyZvkYPXxxsLet2hzf2AomI5xd4axN881Tb8LnUbTyW5zKcQAQIUTYvGQUHPkdQpE
 jl/8TGenH6tdTfz1BYzXdt0bGSLWc6tCZAY+YAcjbHgCpKaHhVvBpJ7WJnEsolu9mDQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792018753;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:
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
 bh=XBMV0htv2tJDRxh5b6oV5nizSRlI6vjHA+Vl2U1pugw=;
 b=b5fjSF+FArs4a640stxw6EO8k2YG+bezwDlvrNbTTryRa6MaAEMd2lygwcLx13pCX+Yk
 bUYAWRB/IlR3NJ3LcoIvj88xOUWnydCUtD1ER6TEfqOYTt1YCvIutXO8CbxDl93NYbP/Q
 IkWD9nTpNVnboSVbBGEdsvfV39xhF/SYivJdJWhQqjw77Mt2b6LhbM0lo79YrUB5clSaW
 gPBuoIRr3cpFpi2tapkgeF+cEQMpFppHi4ekrt74wg15t7LANvo0a0FI8z93jXdvP6Jt4
 FmE9lUMLFTzcAuwn1OMb+QSMrGcnfafZZ/P5RvSZc2x59TvXctNV5BXqgMxPuSyQiEA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=HAechtpw; 
 arc=fail smtp.remote-ip=192.198.163.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=HAechtpw
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5953680F59
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 22:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792018754; x=1823554754;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=1SyxnrZvySED4pNIYBqlnQwKUDJgBH5T3J2kBTn9Ktw=;
 b=HAechtpwPGz6SklG52ByhlRpCKxcHxnPBA5W66BstxmykbZQXrsaLNZq
 UGemCXb1Iqp87rkK5Gb2PvQNA28AaOmnmkx0oUMAEr9AtGQRwTu6ajK28
 zW+UcOgvIfVyrPABnh8b4Dxah4Ts5Q8ew+G1hZL8ytGwDydfgHJ0aoajo
 FVz7zWvrfYJ8ZLXAQlk1QOtE79ljK2E5e738svnay06lSFAVoKnX+snHO
 x1W/TgDoLnlKqjVT9l+ENn4d9FeWFYiKy6Ezy72IyvyQHpkOU6kMNwc0m
 PYu0FE15izAxtJkh3p4iblVK/wMNgsdYTl4xLhfyI5JTmS6TLQSi7Rltu A==;
X-CSE-ConnectionGUID: 2dB/KV4rT/K1xwA7LorGZA==
X-CSE-MsgGUID: ItQnDglvQ4ClJmM0C+Fy3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="783796"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="783796"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 15:59:11 -0700
X-CSE-ConnectionGUID: /JAuuob2SZyfT3rcyX0Lgw==
X-CSE-MsgGUID: fF3nN7BYSpGO1rE1EU/+/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1648175"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 15:59:11 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 15:59:10 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 15:59:10 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.48) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 15:59:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5FCyAKEHMh4LQzHy+5KDrJCsfG6/IraslB6dII8uNjCregNdrDa4ZsutWaNW282qAmHwMY5E6WgqNFIxlN45N6ZIKiAFpd87kyxJydb8hoTmecqAQp42wivs8CtriWsZDv7WEDJnBaGdyfmz7887+ir8c4q23uWOED7kwrDDAHRdjlXer67ED9naQ3vMCQMP3Sto+PQlIh7jmXz5P/UC4sZESrvaWeH9mqkKtYWStRu4nhC+8+U2JoT3bhH4Hw+1VlsG+zlsU3NdqicUV0lm/XU8d7cv/AkqJjVKg+iKmg6itgOy3s61V0BliV8lg4tVfxmRrgWTQomg5upH40CGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBMV0htv2tJDRxh5b6oV5nizSRlI6vjHA+Vl2U1pugw=;
 b=M2R/TcBbbA5XU5+MS2zfiJZhyWLf/Oa6LP5uwIWMGa1FTzfjhfUOfDq3ZY3fLwVWvt4QlEs6FysSZSqMTw770c8wzl8TxHHOj9S0AqxTHT0fTXRXQGNjITXgCcfyhItL1e8I466aTBHzhDlfQQDOtYgJx1GeicRkXcpwDbiNW4CULPamfUvw2BFFd+A/cpH/5IX0mJs37e+yPZD/zj7tmfyqQcgdUmmDc3+ZRrOy3RZ+XvAa1gYokdVuFR+wffBKR7UFCDzVce2fk3zjxcoZjfg1piXCc7XW0iuhnDHD5vPRd6c3kifL4nipJ9HHU3lPFPJt9d6l+DBUl7KeQdmoEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by PH7PR11MB5959.namprd11.prod.outlook.com (2603:10b6:510:1e2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 14 Oct
 2026 22:59:08 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 22:59:08 +0000
Message-ID: <b912187d-43ce-40fb-ad65-edecac09ad73@intel.com>
Date: Thu, 15 Oct 2026 00:59:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 2/2] ice: reject partial NVM update on eRoT
 adapters
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 <intel-wired-lan@lists.osuosl.org>, <anthony.l.nguyen@intel.com>
References: <20261008141418.958066-1-aleksandr.loktionov@intel.com>
 <20261008141418.958066-3-aleksandr.loktionov@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20261008141418.958066-3-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P191CA0025.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::9) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|PH7PR11MB5959:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dc06c05-fbc8-45e6-a2aa-08df2a46c0c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|18002099003|10067099003|22082099003|3023799007|261009221227099003|11063799006|4143699003|261009223027099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: 0xBd9+Bt7gZZ7kcsZkO9mNUZb9OptZCq4nJWRpo0+NDM3+LmNRaca2yICkW08XmBT6u38ZY5EwJK33HJXOLAxU+efQ+4ZkV0ZlHeqlNTE0pJmURHGeXJ9L5+d67mgVxqQIrHEJyJLUZsFhUeBMWXj310RaofaTkQcKdSfwIAun0mnlRDgf2q9BJdaongm48VQB3DPgm2dcf6NZ4eOiuqbQ6EPSvungQXD2QxnrPZXo3lhKP8SbJ4oTCofeclwc6QICjJYSUVR8vlGM1rzOyFCVp21aWS6wycc4M5rg3vK4UoVzsNxeUK9JQMOF0kn/mSBJEN5RWUFVd2Q8Z6pjOmZv3NXBYuLZQs2JRXP8ylsZf8Jk4/24M9QiBmV6lQwnRRXDPrsUMkGsNNkdjBXf7Jto+Zd4PZwZ5m/fxL1/276AIhEFXIQmvXiMlFtSuvg+qDUUMSkxsu4G8wJS8vqivGlXkoVTcyzfgLj3jGInpSuUeBxs57jfcn3MOxsv9CgwMaR6owNuEfvi5WNotJ36mSK/IAQ5UeZr6uZd8YJcspvaH+h4CYHFjOIg4rRlW5TdI1P+ZInq2UmIqWdgmMDIpM6m3Rbcxcp5vYj3wsyZVSivE1rFBI6pvUlL3IUPnMSo1iUBj1KLoqrWVa7k3OXQVDjgfoJR1zbhNpLxcV9HQLYWM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(18002099003)(10067099003)(22082099003)(3023799007)(261009221227099003)(11063799006)(4143699003)(261009223027099003)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NC85U1N2dlYzVzlQOW9GUGNoYjVVczRtV1lpd1BRL0dDUmhzSW5ia25PR0lY?=
 =?utf-8?B?OEYvcTlTcXo4VXBrQXEvUWtaVk04bnJYa0pLMlZNVXhzOUM3OXZUNlg0WlNL?=
 =?utf-8?B?Z21aSHY5NERYbUhSMUtlZzZNNlhMOHVsdE83YXpDSVBHeHlidUtMNHpROVdZ?=
 =?utf-8?B?VjY3ZElRbnhza29FbXFtbHZpcmxzSUZjWUFFRG1Td1o4Znk4M3hjemhKR0N4?=
 =?utf-8?B?WjBxTzFuWmlEb3BRalpHTjNLMmg1M0dZam1ONkw2UTFwOUpRZFlNbFpONnBy?=
 =?utf-8?B?MEFhclhYSVl2N2xqTmFBQS9RUmh2U1BKRmVSZTdRdVo0Z0RkY1E0ZWRsa2hL?=
 =?utf-8?B?RVZRamlLUG8zWStHUWZtWWZqZTFTVFdqcUs0WUUydktSa0NDZ1Q3L3hjNUhV?=
 =?utf-8?B?MG10ZTlVcEJXMWdGYmZwK1ZpYmhYbW11L3EvV09GbTZVWUUyVThlNEtWeEhG?=
 =?utf-8?B?YWI1RDRQT1FjS1ZIQ1pzUzdmV2tHV2lHUFNOOXVOTnllWXBGYkk1T3RGVlhn?=
 =?utf-8?B?bVcyZ2l0YmNLMzdRY1Z2RnhzcFpzUm9pVXlhOGxRY216SFpXc2kvcEI4VHkv?=
 =?utf-8?B?UEhNc0dJckROZEtPTkN2dk1OckRkd2dtQnNtM0gzT2ozazZVcGRMUkFUVW1i?=
 =?utf-8?B?TnhJOFBaQmJkOThSTGprS0JYcjZJcHZ6NkxXWmdFNWZFSzlxNkJtR2IxNE9s?=
 =?utf-8?B?enZuQmgzTkhxdzVvVDA1NjFLRGJXeFBrdk5DSnBnZWEySFR2RzdZczB0eC91?=
 =?utf-8?B?aXl4c1dhd0xpRzNJM2VaenFCMmZSZEVOZS94bi9WalBzbGJQOEo0VmowRW42?=
 =?utf-8?B?SXhYVGpzWm9yeTlHb3VQS0lJdEQzWXBoc1VxSzloak1jejU1YXpScXRLRFUz?=
 =?utf-8?B?Vkx5T2UyNmlPb0JGUGJZaUYxZGV1b2grTUlsbUhuM1M5RW4wZ3IzM2NMNSs2?=
 =?utf-8?B?clNLYTFWVzNyeU8wYVdFSDl6T0FKRDlrM1F5UVluWlZqRmNFNEZva0ExK2JI?=
 =?utf-8?B?SGMyNXhFM3NCNlR3MWptOUhrdWJDUTZ1Y08wcVAwN3R5Tzh1RU5VWVJHemNq?=
 =?utf-8?B?Y0lraXZ2ZnVGMGdoTUtRU05pQyswQnJ3bDI3VWViOS9qMmgwWVUrbisxaERH?=
 =?utf-8?B?dGxtMVNHaUkrV3AvUWUxbisrb29rVjQyU01xcjdiRDFscVZHcG05b29qZEdK?=
 =?utf-8?B?MVpPM2RmWm0rWUVReVRJN2c0WHQzeDdGNEhwUmM3MlpJSU12SDNFU05rOUY4?=
 =?utf-8?B?bUc3alM5LzhZbFR1ZjdwSnlST1NnTHVTU3lIYUFPWXdnc1hmbGc1V3NrUjVp?=
 =?utf-8?B?bjRQanVkdDBISVFWcHd6dWZGTCt1RGN3ZnhiQ0UybmpGTkNuYXBTWitQWEJN?=
 =?utf-8?B?SnQ2ak1MMXFJZE1hKzVqQVZXZStOYUtma0d0NXhJTXFQM1ZjL1lTSzNwNTQr?=
 =?utf-8?B?NlQ2YTQxZlMvcTNIN016ZVl4Nk9CU0Z2Qy90K1JENzEwY043Rms4ZzVld3RR?=
 =?utf-8?B?SmtJNENOTHBjazJzQW5EQjUyK1U3LzNkYmZKcGxMbk5NeUhNRHZVOFJHZkNV?=
 =?utf-8?B?WSsvVHR5SS8zcmFYbXVvQlRGM1ZKRWduSnd5bDdaQ2VHdnowRzJQTmdQZ0ZX?=
 =?utf-8?B?OWRxL25RRFBreDcvRG54bUxPZnZDWTM2dzZTTHQwTlB4SlBlUzhyWEdSTmpl?=
 =?utf-8?B?SzFGbC8zeStUN24zYU9lYi9kbDZmZ1VXMjFyelZ4MWlsNk1acWw1cVZSTmFk?=
 =?utf-8?B?c3RGQ2kxWkhzVnJqdEdKNjNSUmtta2ZtbFl3aXlMY0xMMXMvT21wRUw3aXh6?=
 =?utf-8?B?M0x0eUNreHdxekIrTkxlL2hJaklwaEpPaFJsd09yNEg5QzJqWnJLMkRBak9O?=
 =?utf-8?B?WFIyc0txZ3dVckd3WEhUeVh2V0xhUDNubkxkNGUxZDhneG1Gell1bHZFckVy?=
 =?utf-8?B?SFdmVGQ3eEkwY1JvUHhJa3FWZ0hDVWdaZ2Voa3Evb0MxcWsxWXhQUkVJNkFn?=
 =?utf-8?B?a2FabjR5VjZRd3pJaG1iaHRnU0ZjVm9JcGhzZm1wbEpiMDd4VnM0NVlKcHJi?=
 =?utf-8?B?M05CQkhHTm5LMVo0MmgwMndpVUpBYkxIVS9vQ0pueG1ERUE5dUpWV3RvdlFl?=
 =?utf-8?B?Yjg3OThITXhleHN5TzRGMFVqQWk2bm9kZ3hVTkFJNzBSaFpRbXhzSTAwNS9u?=
 =?utf-8?B?WjVJS1pad05IVW9VZFNSRWNMRFBuQmxJcGIzb2tuSVBrbW5UVEhTZ3RGSGov?=
 =?utf-8?B?bzJnM3pTanlsM1FwVVYwUURlTllhbnpZZUJoV2tzaEhYd1p3R0FRR3hvaEhq?=
 =?utf-8?B?SHZNSVdtMVdLb2V5Nm1WUnNxaStpazZoOGpJUVZobG5oK0FQaFo4Q2UzSG5m?=
 =?utf-8?Q?+iQLUhtYLLYETUIE=3D?=
X-Exchange-RoutingPolicyChecked: IZH3WNv7okK+mqfQ+Q23XBCarKeeRpIEYQaUmRgbOoOVRT8W9rNQsiq5GkAjPpnd01+qoEp158JiDiDw008VDTYqqXFZXGbXpmEHYRhwm+apu2K9QqNlZa6xAEXT+XYHMJJtVaR9cd6QC6yQtE7JM2RoCTRCKhkpTD90V0LaG/Sypbt1AhuTyCmVsmUdFJNK5U9nQEpCkq6U5A40viaUTOIrhlwdU9XWwxM7UjF6A3oGq2jIv22BO28dKUd11DeBPCOoTNR5WrvXztx6QB7+F4j/hdf6xK5+GqFOXbPyDlEoHBCcczg8yK6OurCG6FZ9bybcdBS9l8k12kI4MkgVeQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc06c05-fbc8-45e6-a2aa-08df2a46c0c5
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 22:59:08.2341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ORsxMLoxnLG3lZmh7MYsoNRrOr16Zj5SIeB3WZjNYxRc5ahEMF1rBbz1c3KqUUeJa6mp6WmdLAwpT3IOqVS3x8hZy12RgghUa+HhFlIfbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5959
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

On 10/8/26 16:14, Aleksandr Loktionov wrote:
> Require NVM, OROM, NetList and Manifest together when firmware reports
> eRoT presence. Track the component IDs while sending the PLDM component
> tables and reject an incomplete set before erasing a bank. Reject
> duplicates only for eRoT updates, leaving ordinary duplicate handling
> unchanged.
> 
> Read fresh device capabilities for each flash attempt before canceling
> a pending update or acquiring the NVM write lock. Use the confirmed eRoT
> presence as a per-update snapshot for component selection and validation.
> This avoids depending on probe-time state after reset or in recovery,
> where normal hardware initialization is skipped. Use the same fresh
> query for the unified-update check, retaining its recovery bypass.
> 
> Treat an omitted capability as absent, retaining legacy full-image and
> fw.mgmt component updates. Enable eRoT-specific restrictions only when
> firmware explicitly reports presence. Older eRoT hardware whose firmware
> omits the capability is not protected by the early completeness checks.
> 
> Propagate discovery errors and reject explicitly reported values other
> than 0 or 1 before pending-update cancellation or the NVM write lock.
> Neither case reaches package transfer, erase, write or activation.
> Recovery mode does not bypass this check or require full hardware
> initialization. Pending-update cancellation already discovers device
> capabilities, so recovery flashing required that query before this series.
> 
> Reject single-component requests up front when eRoT presence is reported.
> Keep the completeness check independent of the PLDM END flag: component
> filtering can omit the component that would carry END. Also check before
> finalization, since an empty applicable component list skips the flash
> callback but still reaches bank activation.
> 
> Accept Manifest only with confirmed eRoT presence. Its activation flag
> is zero: the AQ activation-select mask has bits for NVM, OROM and NetList,
> but none for Manifest. This does not establish its activation timing.
> Define its bank pointer, without adding an unused bank-size constant.
> 
> Document the component rule and the capability-only policy in normal
> and recovery modes. These checks neither authenticate image contents
> nor make the update atomic.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

IMO this series have not changed that much from human reviewer
perspective to warrant dropping Reviewed-by tags. Just some more
LLM-driven hardening against LLM-reported edge cases.

[...]

> @@ -1013,12 +1067,37 @@ int ice_devlink_flash_update(struct devlink *devlink,
>   		return -EOPNOTSUPP;
>   	}
>   
> -	if (!hw->dev_caps.common_cap.nvm_unified_update && !ice_is_recovery_mode(hw)) {
> +	struct ice_hw_dev_caps *dev_caps __free(kfree) =
> +		kzalloc_obj(*dev_caps);

openly declaring variables mid-function is ugly, also
<insert the usual __free rambling />

> +	if (!dev_caps)
> +		return -ENOMEM;
> +
> +	err = ice_discover_dev_caps(hw, dev_caps);
> +	if (err) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Cannot determine eRoT state: unable to read firmware device capabilities");
> +		return err;
> +	}
> +
> +	if (dev_caps->common_cap.external_pqc_rot_invalid) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Invalid eRoT capability reported by firmware");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (!dev_caps->common_cap.nvm_unified_update && !ice_is_recovery_mode(hw)) {
>   		NL_SET_ERR_MSG_MOD(extack, "Current firmware does not support unified update");
>   		return -EOPNOTSUPP;
>   	}
>   
>   	memset(&priv, 0, sizeof(priv));
> +	priv.erot_present = dev_caps->common_cap.external_pqc_rot_present;
> +

nit: no blank line

> +	if (params->component && priv.erot_present) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "eRoT adapter does not support single component update");
> +		return -EOPNOTSUPP;
> +	}
>   
>   	if (params->component && strcmp(params->component, "fw.mgmt") == 0) {
>   		priv.context.mode = PLDMFW_UPDATE_MODE_SINGLE_COMPONENT;
> diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
> index 1fede0f..43f3208 100644
> --- a/drivers/net/ethernet/intel/ice/ice_type.h
> +++ b/drivers/net/ethernet/intel/ice/ice_type.h
> @@ -1151,6 +1151,7 @@ struct ice_aq_get_set_rss_lut_params {
>   #define ICE_SR_OROM_BANK_SIZE		0x45
>   #define ICE_SR_NETLIST_BANK_PTR		0x46
>   #define ICE_SR_NETLIST_BANK_SIZE	0x47
> +#define ICE_SR_PQC_MANIFEST_BANK_PTR	0x4E
>   #define ICE_SR_SECTOR_SIZE_IN_WORDS	0x800
>   
>   /* CSS Header words */

