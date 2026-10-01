Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EC1CA5FCE
	for <intel-wired-lan@archiver.kernel.org>; Thu,  1 Oct 2026 18:51:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD32840C9E;
	Thu,  1 Oct 2026 18:51:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7KLodTMm_Aet; Thu,  1 Oct 2026 18:51:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9A58940B9D
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790880663;
	b=PSM0v+eoB2bLJKtGVUpfeHhtozDv6ldoONY0aBjXDRicfa1DqgYNZqIM/+l41+IDafao
	 h7UsXxwvDKNmIcVKaFCPfn2ToWqBdAvfNJFftqu3AiA318LNQNiivVQ/1hzh5kW3XVx0W
	 qlpk381hiwpe1KWjgc84U6MXp0PqvqGRYWvORBmJdiiTgEzNO2asCDtni1xRId+AUXoeV
	 6XN24bmgPq+q9ZfqyzvZkJmy18ndQkimm5ah/om2wRK3X4RtuwRn2wViBFOZs456nCwOc
	 LBlHt6WHjyTEDmHh5ITlH5FQWMa7qiRRvXsEzGpyVOgDNCZK1zzsn8SNfvu0bCNscyA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790880663;
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
	bh=D4eXFklihnvlW/sGTX0iGeG/TsRLCYye9dI2xYrLuyc=;
	b=dJUGw4nDtPL/qrwMh1wbMXWHMtPcpGSMAFdS/EQhxTXf/eLkpk2kfGblEk6jUojOBPpN
	 TvwI3nzdWQK4s69cVPOH2OFqcWEMW+6fKgrYMLxdeFc0jFbTMlGI0cfg5+Fo78cQVGEKM
	 wjVHLEMn/dEbdsL8amNONiBPIqIsgSukMLRHavRXWD0bhAcReA+wEwPOY3bx4TWJsZ4Dy
	 elrtc+1oH0qQICgenuZTatixj6PG5mnamQhcLDTvuq1kg/rFhUB7beb9SO4wEtD2YX9zk
	 NFH2B1ttdd+vHc8nXdTukbhEcCkWJ1aFc/TsHR92vaZ2P7O/IOpmrLSO0cWIuEBqBTw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AfDBXp4v;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790880663;
	bh=D4eXFklihnvlW/sGTX0iGeG/TsRLCYye9dI2xYrLuyc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ntEAPf8ATKxyOLQQtvOlBkUEKED+oXpIM58knxdKEp+H81CgrSTPhN3UxxDf0XJOd
	 I8aAhezDB/389Yo+GIyH6a+EvvDPUek7T2fN9X7UM03jp6Q0k5xSgd0FWSb5VE53Xo
	 7p0j6yJF/XPhGqiVJEvaHLMhMgpv46Q5ojQ5kxUhdzm0MU9ATH5P7+drNZEXw/Ph88
	 m3Q9mI2ekfZjBfiRgDdUvfliBWzxG/rprM35fnxz1RmQJ7oP48gT2moiFDqwiZPXoj
	 PEOXwWz6Zu1WRZrvYRMupmxl5BUFGkgPYo7LLHOcWLNjjxgs+fcjkWO67rEJTCSu/h
	 MnbfOk4/KoEgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A58940B9D;
	Thu,  1 Oct 2026 18:51:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BC5D133B
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Oct 2026 18:51:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ADBA040B9D
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Oct 2026 18:51:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uP6wqmGalEna for <intel-wired-lan@lists.osuosl.org>;
 Thu,  1 Oct 2026 18:51:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A717440B99
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=192.198.163.8
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790880660;
 b=UthwUK6GMr42GkuBA9yFUP2Nz3ozozii32t9i3zf/MGeWCMUQK7bLS5t3FHQ96SlMPUn
 r5VIA1q8TBnDpe63K8ApJA35XM6nwHFGkJzhQYpmuOhYDgLfMGjwNiN2dmR/6pMynipMb
 w4Xi4W1D4hCFs67HtzGzKxcZ/2rAAavUTNZuEim/sKr6ufBVa+tEjWb1DiJFfS+DcCqL8
 Zr79LWZ/em+IlWnwhVLqbFxAaGC56KfjtP6w57bmjQU27hvM1bh+R4QQWpDoz9pLs/Hnv
 W3/elZdcdC64H3Rw6+pmc7VPy53DQxmlDCcQ9/e5WerCBfsj51LLq7KwLuT4Y4+Auag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790880660;
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
 bh=D4eXFklihnvlW/sGTX0iGeG/TsRLCYye9dI2xYrLuyc=;
 b=gp77cWABn9QcRTOLtWIHrGwQW9948ldJgLwGGbxfFSKeJOETrBFXEetj7G/aIayoDa/5
 J3PmMCBZpukQOUMlTpQJjnBNnmWErK1N7RjVq2AyIccfEZ5VeJIyKfBjqo1QcrJwuahVQ
 K/4uHOwnEOvH5Ipp+kU+I3fhBSDBR8S/ezRDOma27KYBV261wZyWIgz+KTzA8Ey7lad2+
 nq4+rI34CydDE2VjjMIqN3BT5rClMg3uF8YoWNl2xjaV47JaamyBsZp6/pV0E5/2LwU2T
 9hTnc4DdMN9iEEstM8Sahahu3T6n75zjFnGa397O2dF3S5ydK1/qQV6GvjkcrokgmiQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=AfDBXp4v; 
 arc=fail smtp.remote-ip=192.198.163.8
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=anthony.l.nguyen@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=AfDBXp4v
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A717440B99
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Oct 2026 18:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790880660; x=1822416660;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ylhh8VCTID5c3jVXvdfr5atO1AkpCp5fD+LgoAHk6dk=;
 b=AfDBXp4vnk9O3Iwo2/3VVBYJrrh4lAKLnwyF+W0JGy8jgNjH9FzNCt5c
 m6ojN+szm/iGXX4U25Fqh4n1GBCUPNUpG0+VH3m8L/dHu7uVK88ARXyR8
 oeExeNgdG2eCFU02oIh7VNNSwzw4JiwLtx8uTc3RTpDYrl+HX6atR40x9
 uwJOkTG/326YDhzAChEyRcv3IRaklW11M+rftmnZ4P/tMILnfOPOsBoKi
 tBF3hU4hp/NMFT9VpiOe9ZCFuZJbs/DaEcDc+JqkdQx1lmH7JoWmEFJ+x
 vSAxUNo5pcYTB6R2zntjYSxsQE7bFrgbPnTrIGsYtbbLeUPxKuOBYBuUJ A==;
X-CSE-ConnectionGUID: /2jp06M6S7CNR/JBrJ0mFw==
X-CSE-MsgGUID: yN9kypPYQLScdswQRPVbGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="109134433"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="109134433"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 11:50:57 -0700
X-CSE-ConnectionGUID: izxVvyQbQ/GoFJvi557Sjw==
X-CSE-MsgGUID: LFQ9mXRkR7uuSks87yS+ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="284124209"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 11:50:57 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 11:50:57 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 11:50:57 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.70) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 11:50:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJ96pCaT6glVQEh6NEoc81Xf8OImJDvNlw0bdB9QO5s/jp3xzk29NOEdiPdbsO90uIa8lVsbvlt1Rc9lzfm9oygxiKFJTRW3K+7No2DXrUhlSSxlthBVHpDsdP3RTRXcP302/D3bb+Y7O2sf9EUidxyrR3B3Idpq7aand9geKoEs1CCIN+iW3wuowz1riKwjqZqUjOYD5E7WZFAk05GtypbBSoAgzZ8dh09FX9cXh1t/AZfePfoE90FZrwRT3urXJO9SzRhfqy1SMJ3ZPE8byr6scz1bXjaNEs/6BBIqVc6Dz3itKBLhHw5ZQnD6NZr/xmp4hYJYanm1Q49zd5tomA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4eXFklihnvlW/sGTX0iGeG/TsRLCYye9dI2xYrLuyc=;
 b=puLjzXA/fZSyPIpzYt2aI2tgS/WHXLeG4fZgMD4uTER9Yxotz9cIy3AO76EA6phvEyfQIyjkQdp1d844bcHXDRpyVpns+cV3O6QPsCk7DW/KCd1dma/ynmPFDq1wzYUmr1H5UHFiuZtyRmUZdb4EVlyxiPBs2Ju4VmHUbnt7eGk0FFzHNKBLt4vPVK3vlbojPkMXRbNE4dm+ZXhLDX7WmSHpPRe8Ko+0tXfHJP/xc1uJYoskPwR+zt8WVjXENU7hmXsdAI7lbUrmcNCVpfkhfqGEeetiKHcNcqq405LS12qk5xpUUf0aDG3RV6nkcpk2HzcJ8pwrpxfVQYeCdQKO3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8241.namprd11.prod.outlook.com (2603:10b6:208:473::9)
 by PH3PPF310D5CFFC.namprd11.prod.outlook.com (2603:10b6:518:1::d14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 1 Oct
 2026 18:50:51 +0000
Received: from MN6PR11MB8241.namprd11.prod.outlook.com
 ([fe80::cf79:ceec:e277:9d46]) by MN6PR11MB8241.namprd11.prod.outlook.com
 ([fe80::cf79:ceec:e277:9d46%6]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 18:50:50 +0000
Message-ID: <d1cbce22-1009-4b72-b1ce-a07b3e23c7b9@intel.com>
Date: Thu, 1 Oct 2026 11:50:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v3] ice: fix LLDP AQ filter fallback not working
 on E82x and E830 hardware
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 <intel-wired-lan@lists.osuosl.org>
CC: Simon Horman <horms@kernel.org>
References: <20260918133243.4169311-1-aleksandr.loktionov@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260918133243.4169311-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0127.namprd04.prod.outlook.com
 (2603:10b6:303:84::12) To MN6PR11MB8241.namprd11.prod.outlook.com
 (2603:10b6:208:473::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8241:EE_|PH3PPF310D5CFFC:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c631ecc-e1ac-4454-8678-08df1fece9d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6SDTWMi9SS8WOZ9gRDKWUZdU+wtTCC7vpHFF/9Xi+LY4sM1zuCrgHwEB2gSu8nJ6wFm41eg8vMezTE/mYsT8cf5+lEfMncJkggGdMb20MPvK+CmbNjNlMlHNEZ6fwuGcrgKM+1y8L8KkQBkxfseqws9sof1uatBdwNu2ZPC63NhacKGQWNHQS5qeFKTD2jJmOclUIZ0Dl1YNE0XiBtKqi7uvGOhDzuteupfLucFazjeIoM0jzuy1hQpQWudR1SEw0dfMW37yZijj7a68r8wm+0SQxcjkuuiRY1ZGu63P9A3Pu5OvWGf3ZXhVLDMf2XTiYWmVa9rVSGVKYxlBUUHugCln9zo5lpxY24iwjqgRPIuZVj5ZKxY7hvcg0CGWTpPBCty4Je1ax7y9M4WEV1O2VLHhDWTyyycbDTNgAiSo+setzqhrotcuv8lL5XKjWkUJPKzoxbL1WWNxhT/ziWyUY2baThJ2PgYgKW8NycWvdz/rBaYrERPDsMpeoEkNVURF4zF/Jjejr6I0hbwPO80UaMI8TfMPzsKhDgJvKM2zYtW/jJdBJwzuuyuJzXEWvudRQL/3yO/q48BS5vG5xKSbyvLtB9RXQ1SRPQoRiQctM/6cdGP25biC/2Yy4nP9oU6S69Oq80rsHqa/ufzrGtJqb2QASB0oUP8bFNWF4RltqhY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR11MB8241.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDBPVUVnRDcrS1AyN1F3Z2VSbmg3Qk4wcjYyWmZPd0tPK0lWSWRuNGFrVVcx?=
 =?utf-8?B?UjdFa1JDVWJwbHQwUmxnUFhjV0RpK05Od2ZsWUtKdTBvT3gvSklRSFVpWnFU?=
 =?utf-8?B?N25YTis2R0NEeXR0Y0FSalpMVUZRWTlXcmxSRFM0WmxMVE5XMmlnVmN5eWZV?=
 =?utf-8?B?c29mT2RpZmh5OHlWMk5Ka29icU1WQXFxQ1hFVEdZVFFwRCtwSmtCR2JEN0RU?=
 =?utf-8?B?V3hhekpHNm10Q3FTNkhqWldlbTRyMCszblhYVDNXSFFXQjlmdldVb3FieEJy?=
 =?utf-8?B?SEN0SWF3YkZXZE4wU0lwSjdPL3dITXJPZzRqZFNBOXhWNHE2YmZRUlZSbWhs?=
 =?utf-8?B?RVk3V0hxNXdHY01xV252SnZOU1lZWmNXWGZaa2RBZ1FxYXlPalNZbmZnNTJ4?=
 =?utf-8?B?QjJPTmhyU2U2WnFad0JDL295YU9wd2Q1MnRrQ1I2TWVDY1dIYUtYUzk5WW81?=
 =?utf-8?B?Q3N6RTgweUxSSlFzQ00yaUFHVWgrQUlseDBieUpHem9WWkF0S1lrOUpWdFJT?=
 =?utf-8?B?SnBBMzFiRi9VRzdqQXI1KzJLSzFVM0EzWHlrYVQ4dDcvU2tkZGJCRjg3L1Rm?=
 =?utf-8?B?alJZcWhVYnNranpjQ3dadDg5ekNGS3dSTnRmdEMvZ3p3QVRtd2ltQXNvV2dI?=
 =?utf-8?B?UlB6WVRnaThNK2xkSDhZcEdCRWR4NUlsbWRjVHJrdWNRbDJLRDdacU9saUts?=
 =?utf-8?B?dGZSOEtTMkQzR0tUOTFRa1o3WDBRK3ZOUlVrNEJiRStrblo3MFUwMkswMFIv?=
 =?utf-8?B?blhla09VaGxHOEIyZndtZHFMUSsxMUlzSDZkdXpUdmtNZjhOS3pHVUVxRC9G?=
 =?utf-8?B?QWVyZ2NQUlVPaG5WRWt1dUY0M2w0bk9RZnBHSXZ6a0ZwSmhFaHMxSUFZYkZv?=
 =?utf-8?B?ZXdjRDU1SHlybk9XN0FIdVhKUW1lT1N6NVNVTFdvZjhDazZrSUtHaUptZ2dU?=
 =?utf-8?B?OHo5ZmdZYWNDK1B2YUxOckZ1OUVONHByeXlFUkdUT1hldzhlSm1WYXJwMkw2?=
 =?utf-8?B?anFkajd2VDI2UW53NzgyRDlXWVRNMnAxN01kL0U1dk1DcUJjMmo5RDlvYjYw?=
 =?utf-8?B?RGFEU0dFQ2M2R1FDbHZtdlpjVTViY1BPVkpIZldIOFB2VkpsNStUdXcrd2ll?=
 =?utf-8?B?OC9DaVlMYjNIc2hwKzdoZGZCSCtwRkNhWERseDd2c29uMFRyZGM2QmxxbXQv?=
 =?utf-8?B?Z3NTZGxleGpvZ2U2SUg3TzJLMnl0UWVUdThRR3l4d1VYNm1VOUZIL2FJckRT?=
 =?utf-8?B?ZTc2RkJJa0NWYkJmTkZHNzZreUhWYlJqOUlZVVdtWnVVamc1d1JPVHAxSXFF?=
 =?utf-8?B?dlo2OTlKeVdwekJJMFhwQ0Fva1NzU3MyZFpOZFprL25ZdzdETFFjeHlzRkxP?=
 =?utf-8?B?MEkvK0hmUHJYdmlKWHJoR0UrYVJIUndOanN6SEwrdDVGMS9PMlVPa1k4bDR3?=
 =?utf-8?B?RHU0dysxR3gvd1dOazNKdGtFTTlmL1hNOWVqdkNCd0Rxa1FBbE5rSHNCZE1i?=
 =?utf-8?B?TXdYNW1mNVlQeDY2V2VicXAwYzBxbjFjaFJaSE42bmNPV3BodkVKbkpqQTh6?=
 =?utf-8?B?NzFrNkxGQmFUc2o3T3Y0RS9pMjVBNkNmK0xZeG13MTk1a2xuemlnaE51UHZl?=
 =?utf-8?B?R0haRzdQR3NMZTN6Q1dlaW53R2FxdmFXTjRvUlJkaGVzZy9sQTNlZTRiVWov?=
 =?utf-8?B?RGFIRGR1dFNnNzlRR3JrYU5PQk5ONXhDQ3BPMGlkVGhWakZmWk9RSmxMMFJY?=
 =?utf-8?B?RUpwTU40TVk0UHdZQ0JhRG4yeXRGMktrL0diWWYrTWREeEVHRUlVbCtIdHJP?=
 =?utf-8?B?MEZnK05qdzdGM1JLcXA2eFZ4ZVZXQkNjamxTcTZSOW9lQUNzKzgwc0RFRTg5?=
 =?utf-8?B?bHhmbXNBUThzTDc1YVd1TUNJeXVkdFY3aWZyRytkTlVjN1Nra0xoaHVjeERq?=
 =?utf-8?B?K1AyWjJOcGxXQ1kxais0aS9Zek8rbFJlTmh2ZUc3WjJlN3FXQjJ0cVFjSWtu?=
 =?utf-8?B?a2dYOXNwdHl2ZUtwK2ErUUwzRHVJSDN6RVVNOXA4ZnlyNVpXS1RRZE9TVUNT?=
 =?utf-8?B?NStUU29WenJ6NVU4dzRLVGxpaDlJcS84bWxtWUgzYllXOStNdEdsa0Vzd0pn?=
 =?utf-8?B?VDBUV1NYSTdqdkd1MjRtMEx1RGo4c05LaVoxSlZNMUhyTStUZmNwZHlWcUoy?=
 =?utf-8?B?cUZiM1lZc0lrbklFNXk4Szd2R1l2TEcwaGJ4cEd4Uk01SGhHcEV3M25Rd1Fi?=
 =?utf-8?B?QytjQ0dRSExZQ3YzUWFmcmdGODJFQ2laNzhjWG9CT2xYd2NRYk5sNjh4a2pV?=
 =?utf-8?B?dDJhMmpGaTczSGhmSW5LYmk2RHBHTnB2d3N0L1k2ZUlETnpTVG1jekx3R2xm?=
 =?utf-8?Q?JoynWj76Rew7E2l0=3D?=
X-Exchange-RoutingPolicyChecked: 1IzzFGMomDw5pLiK6kV1kuSRpfYcor9rp1sQmtzBRVWdnNlBSWqfGl+nb1CId5KLwzH6wDyUvoZOrFFIzFOuespxquwQrP+mefZFeo3IeM/a7u7qDfEorRIB5tzbILmk/A9jQ84IaXL1gUMSgcWyAnQnBayAGgqs1Ly3fEdVhZqC2DOt7DShDO3AO0PXyx+smgqS+JLdnVAALbYYbMlbMhb3Y3tHOKlIpQda1LS7QOk7CbtBQtrJceShwsGmcRG3Yicf1dtHXzCxWKdNSDDjIxz4IArJTrRlz+AOM2pKaJpT8Lg7kmUz8WK7XO+K2zU6YGktiRrd6dzNPO/dfgY7CQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c631ecc-e1ac-4454-8678-08df1fece9d9
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 18:50:50.8656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6nK2nfmliekDewMseYwLaD6yEfy1rWBybwNk7xK0oZNnbEMjJbbzpTN1+KdPxWXwtA0wKbPjLMiS3fT+wSeUZVRXxE9kuFB5cfla5xqsJ5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF310D5CFFC
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



On 9/18/2026 6:32 AM, Aleksandr Loktionov wrote:

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index 0463310..b31be52 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -6375,15 +6375,28 @@ ice_aq_set_lldp_mib(struct ice_hw *hw, u8 mib_type, void *buf, u16 buf_size,
>   /**
>    * ice_fw_supports_lldp_fltr_ctrl - check NVM version supports lldp_fltr_ctrl
>    * @hw: pointer to HW struct
> + *
> + * Check if firmware supports the LLDP filter control feature (AQ command
> + * 0x0A0A). Different hardware families require different minimum firmware
> + * API versions:
> + * - E810 and E82x: API version >= 1.7.1
> + * - E830: API version >= 1.7.11
>    */
>   bool ice_fw_supports_lldp_fltr_ctrl(struct ice_hw *hw)
>   {
> -	if (hw->mac_type != ICE_MAC_E810)
> +	switch (hw->mac_type) {
> +	case ICE_MAC_E830:
> +		return ice_is_fw_api_min_ver(hw, ICE_FW_API_LLDP_FLTR_MAJ_E830,
> +					     ICE_FW_API_LLDP_FLTR_MIN_E830,
> +					     ICE_FW_API_LLDP_FLTR_PATCH_E830);
> +	case ICE_MAC_E810:
> +	case ICE_MAC_GENERIC:
> +		return ice_is_fw_api_min_ver(hw, ICE_FW_API_LLDP_FLTR_MAJ,
> +					     ICE_FW_API_LLDP_FLTR_MIN,
> +					     ICE_FW_API_LLDP_FLTR_PATCH);

Sashiko on a previous version of this patch reported:

"
Does this switch statement intentionally omit ICE_MAC_GENERIC_3K_E825?
Since E825 devices use ICE_MAC_GENERIC_3K_E825, they will fall through 
to the
default case and return false. This causes the fallback function
ice_lldp_fltr_add_remove() to return -EOPNOTSUPP on E825 hardware, leaving
these devices without an LLDP filter.
Would it be better to include case ICE_MAC_GENERIC_3K_E825 here, or use the
ice_is_generic_mac() helper?
"

I believe ICE_MAC_GENERIC_3K_E825 also supports this and should be included?

Thanks,
Tony

> +	default:
>   		return false;
> -
> -	return ice_is_fw_api_min_ver(hw, ICE_FW_API_LLDP_FLTR_MAJ,
> -				     ICE_FW_API_LLDP_FLTR_MIN,
> -				     ICE_FW_API_LLDP_FLTR_PATCH);
> +	}
>   }
>   

