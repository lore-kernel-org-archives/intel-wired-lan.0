Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B12DCC6B12
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Oct 2026 20:59:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51A5A40448;
	Tue, 13 Oct 2026 20:59:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MJQeTGdwTgiP; Tue, 13 Oct 2026 20:59:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7BE40405B4
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791925158;
	b=K3SSxWskclEbPzVy2FLuhd7hQXanxCApsbqKeRWs5r/Nio5iIw+F6SYMhRxrsh4WxGdt
	 e6XBwOiF6Uedbkn71ldB+570J00+g3aGKS+kQhwAwdZP65cB85OTWd9KNRs+SGCiINsxb
	 zTVlvCsWzdHICbrOybIFSxAzB4vcSGWDPuZxKCGuSohTzJ7vuLQlTRzGih4NJTPeU3j4O
	 LN6Dfpg22BdDe280Ppdz816nGBPa5htInlwLtaiGp/opTH0gOtTAbIj2wtqNcJqECdCAA
	 VDKcl9tLS8PKY0Edqc0ci+/gV2H1gDfBBjfpz4h5IkRhykAgx3jIlAUSHJN9ZJVv+Yg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791925158;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:References:Content-Language:
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
	bh=3ntZVW5FpyyhC0vfAljp6py+3vorRFT2K5K3uF3L2w8=;
	b=gK7pWK0OSsCL6KY0JU/A3bXxQY5hD0WC+VqUwp4u+dHcOYOPS5s3eM3RY5nj1lqcq9PG
	 lUZ9G6CXiDy6/ehJII40Uc+pgBtbT4G+tZikumIK6bEu6qb4VkKROrJJ9617cOEMhKTLK
	 /5+Uc71t5JxoqvT9GjUTnyOZ6u9MCFkh46gKZ+aRv7qm9qEnZv0+9YmJVYjKGgyZ/al/m
	 sLVxHtA4vzXSZp9yOFJQ1lprkGrRlaFALHgvAzGiH1u887rB87tTOmclL1GkBESARjfQ+
	 15gW/To40MLhuWt8WQPN8cvh5Nslam5erJmG7VEMYtyVd2r+UDtzjIIeiGuf0LoAk2A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791925158;
	bh=3ntZVW5FpyyhC0vfAljp6py+3vorRFT2K5K3uF3L2w8=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fIvJKjmM/BNoNYqGIKVOFnlthZHRm22W0OxY4IojQZl0/30SVwOiHtnB5B5J4tXI+
	 x1gI+aLxvWbVxBoJ6upQbcPoOuZi+otgShZnp81GKE58DSEY/fPQ9GiOeu92l5uBdQ
	 /CD/qyaJiApgXTWPRSta+WMcgTOoSYrurWLInZDSF78jGKW6Y6Cu2sVtUazsNPgIJk
	 qjyEkQtMfU4g6rX8n+tvngdlbknq5I9y9nMYMsDIgl6JfR+PKEVR+pzxmw3xbrHa9/
	 zppBgfdkqh7JtfNEvORKqjNDnFnHGicm7U4a5eMPbLslz3Of3wgjVFZtT3DuhTXop5
	 0+lJcLiYQS4Yw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7BE40405B4;
	Tue, 13 Oct 2026 20:59:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F8CE2AC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 20:59:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3522260818
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 20:59:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4KGJa1zcnRDw for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Oct 2026 20:59:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1AA8760816
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=198.175.65.13
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791925156;
 b=nmUFqO/82BHa9+wCFlpSn5L5GFGtVUqhbWIf9CcmrPCWx9kzsayTwYdSnIeyRlHoO/m7
 lfCpzjxfgcifoxE2SgrJT3nNY5H3nE125U9Hg8Qi+xyXi5SfVNAuFIOrVbtUwHuYRa791
 jg5i8RD0gkBZyAiwNLZA7iCyEyoyRkX7oAX6qh+O7KU+2GdHwgfJKguZBBMWBQNoo3BHJ
 DFOYcs+siBOBAT6EPD+kpaRvgFuaNlLbpRt5uODxVSjVj3PHloj2WvERqBm71puglFM1+
 eUE4JIl7OQ4upCUyqeBijDhx3bC7M5BBeJaw4Q2V0zrvZ8AfLNq4EJYP26U5lkA4LOQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791925156;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:
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
 bh=3ntZVW5FpyyhC0vfAljp6py+3vorRFT2K5K3uF3L2w8=;
 b=tbqE/YFB0LCUHLMvF76w0lld1X1FQGu6fOheIJWjgitRkblpVWpCiUW4R8GDG7oKwqcY
 XI0hdHAifxc4cL6LWwGY4E7tJdQjKYjxem/O3A8SgFS2BDmw2gfFqHDIIN5bFCyKsitFX
 smyoWq+GbmS41Mr7eLi861JXzSBKvqnK8A4anLHg42c/MB7ixhvcGoNMoHxttgj0MnexA
 yl5Ppqq9QA2WuESrXuY0G6COA0Z+oJ3Yw0uMaVymUR4Qs8EsKIyyCrGq34qwSiNoo3tbF
 8b5/RhRAXoXzL25yPZy3jsbnsNYDK2ambgxV42Fivh8YpTOSf5Ck2Dko59WKyer0c2w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=dUPYO0P9; 
 arc=fail smtp.remote-ip=198.175.65.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=anthony.l.nguyen@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=dUPYO0P9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1AA8760816
 for <intel-wired-lan@osuosl.org>; Tue, 13 Oct 2026 20:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791925156; x=1823461156;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=T2YIn0nOkWWVwq+jU8KFNdOWKYC8JIln0X/0n4fqUfE=;
 b=dUPYO0P9mk+HpgVyZj4aAwSW38to5xK+/lnDDQ6qWNZMYz0QaXmKS8pj
 WXWg8EWv32asmdw10HoPMb4fJc+Vu19nnQK1lBepkcEdORATYtzwOG1yj
 PEyLaTuBYilnlVXsPYI7KnKdncW0JNooAxK10VBpqHvKUYRS57whJDmx6
 ZdxyKfOlJ2m+JMRNwafnsESNoc9F2xFgTBTuBpPILopyoUxLNDciBVSF5
 zDd9eLV2Wo6Vl+Ql01gqHmIUJv9pHKQIRcd9nAtWFe8OvxygxSsdvBqYv
 4QaOAnxY+1bRQN2muMxLBG2FfHcbPzGCONQ4AQWwtX/l4MCMGcEu4X+JC Q==;
X-CSE-ConnectionGUID: P98Sz8tyQYiHuYyrGLoy+A==
X-CSE-MsgGUID: nmNnhIVjQeuFPDOhOJD4mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="551152"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="551152"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 13:59:12 -0700
X-CSE-ConnectionGUID: ygHXr99xQtSpnI5g0XoiFA==
X-CSE-MsgGUID: X2GmLCSwTfmnMm3MtyRkFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1700919"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 13:59:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 13:59:05 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 13:59:05 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.4) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 13:59:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKMWy7Obegc7cAUPvwRWaJgH2Wlj5yuPGhbra+ifV5QbcDjs63sJxqXWXalYDf82tiV4+1exOg2bg4tsgDdtkXxImN8GHtH9ABNzeUsSxgVob/HAwDDRwFdvUb8ZjH/VGmM5Mx4RPtHa1iQJECqjrbLPn2gjmW/WfDJc7YkvpZ99Q84eRZw1uiLu6pxQm+LCL06kgJ9mUwgagEJRk2+4hluU1tXQQosrXstT5AbNAACA41UujyRnL4ofX9b7Qs3mr7etAIPWQjYJHp98HGp8UkBEZjwC2zmYLhB7X96ohVu3azRXV2LwijxqcT40aj+cGOgigWllcL+oLweTn9CaPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ntZVW5FpyyhC0vfAljp6py+3vorRFT2K5K3uF3L2w8=;
 b=mUEWLv6l8H93/dUzU8HNAdm1GNv8Rki8RkgCz3NiFxebHEWH4TD+ybuRhnA6RSrO8FU7PzVNrXiBm6ZcTb5y+KhBcola6snEg9xpduf/QXyts/xSlvbl+FGnuYeIW9EQfhIGHav7e8v6g59i86f/Wsz+Pk2kST0oOZuyaC/3RvYWXeYkqcEPMTqkUv3Day2u24oSoPs5PeYxO8ZAtE1gVp6iJVyCC54k0mp/WmT47ut5oWCJ11Da4ElPJ27tCbqm4w3Pm0NVo3N0lH8qxwVhvg8B6nBE0Ch+7k3Fg/68FQJp21niOJBAnCVsjM7f/PhaAbVFALrv0nf5nwQxhqFctg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by CH3PR11MB566895.namprd11.prod.outlook.com (2603:10b6:610:34d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 20:59:04 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 20:59:03 +0000
Message-ID: <8bed166e-c70d-4a06-af4c-162e4658e400@intel.com>
Date: Tue, 13 Oct 2026 13:59:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [iwl-next, v1] igc: remove unreachable break in igc_xdp_run_prog
 method
To: Sasha Neftin <sashaneftin@gmail.com>, <intel-wired-lan@osuosl.org>
References: <20261010095727.87751-1-sashaneftin@gmail.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20261010095727.87751-1-sashaneftin@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:303:8f::27) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|CH3PR11MB566895:EE_
X-MS-Office365-Filtering-Correlation-Id: aa5d80c7-6774-4784-c630-08df296ccff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: Gbk39SJHVPGrTvUbeCgDrFnwYgJsVkx6OgwHckUrKRmep/QsBiZcLwfFOO/ZUwZvpDCP+XVNOP5fwbHZHCQcCX+6+EdiI52ZhGDTXGL1R3Held6d58AnGxDpuQVLSb7t9PG6/hCXIRto2xLHn6/ZLBtMA/JSrJcLL7aL6Y/iGPGSNItQp/sTq3niAzULl7Ur4baDiBhNy4oFMaaQINtTEkflhZLnjvFoc2GUoV5kiZGhWySG9C59ldI9AvSdb+czwNlF2mRpf56Q62tkFBezIITm6PAc/VsIqXKXQ5IGdMBBHjnyvptCpeNMj3Z0QQagHQHYCxrI/Kp6If+x0z7JNdW5DgdGb07EbMeM5gLxYS+HdvOlxHaH87VxxKB/7t7ukbYka5juQh5dIw1ryuEzUusUCTyBRA34fT/QexuAoUD9fANUuS4rMrD1avpG0MakxQYfn8ZrxUaKEj0c1Cb2uxF5Tlqv1W4tSVJBr1FqV2DBssBcCorXTxHKjCsD4K/S8Qj3yiIHUx2KX0phMH9a98OkmCeqyuxtHu+Iu18ymjtwxtxhdboej5a1RJqqVVIXTr860O1vqrJOTS5vNC5gLoTy7FkpuLYSzgW04ivIgnHwV7l3Jh/S9YS/ET/MxsLO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8230.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHYvcTd6WnZPb2MrMHVUeXNrVXZ2d2E0MnlmM1k0R2pyK0hqTDZ6K0dWLzlV?=
 =?utf-8?B?dnMwelpBdTAvc0F5b1MrZng2SEtOemErYi9GUUhrYnNHdXlzTUx0U2IrQnRY?=
 =?utf-8?B?VHBBbWx1bmZYQldWKzVKSUhLZGJ3VmtKTFdBS1I2TTI3bnJjM1pVdURhZmxw?=
 =?utf-8?B?cDg0dWtkSFhQc2o3ek16S1VFQUlMNWg2SHJiQUxaQXlRL042SzUwUjVLakpM?=
 =?utf-8?B?SVhXWVRZM2VCaVF1bmtKQkZ5bGZhREd3YXU2NzNHVXVGZElLWEpUcGMvNHdM?=
 =?utf-8?B?WUlHZGZpR1gweFBXQzNWWTFIZU1NSmxVdDl0VUdCK090Wld2UVhvUVUreGlk?=
 =?utf-8?B?T3J0a1Evb3BQVDRHMDczS0xHVFVWV3JtNU9NcUhhdDYrM1JpZXJQQUh0WU5r?=
 =?utf-8?B?S2pVaUd4NFhkYXdRS3l5ZVJHckVSN2E2anZmallDb0JNVURXSTVGMW9hR1h0?=
 =?utf-8?B?cGQ1UVltM0pob3dlWUN6cmlUUHp3cThiYnFTUm1LNHhnd29aTUQyU1ZMRU5W?=
 =?utf-8?B?bjBxVUZiRS9ndDIrcTJCYkxQQUFPcUFoRDRCbG9JUEtuK01WaXEzMlBwOTVw?=
 =?utf-8?B?Wm95akc1TEp1R0J6c0dLemNjQ1dLZVlyMWtZVytaNW4yVXAzZFFiRDBLMXBX?=
 =?utf-8?B?TnVSalZJaU9HNSs1OWtCUjlkaWpTc0h0VkxLdmltQkMxL1NObGxIam1QcnBC?=
 =?utf-8?B?T0tHNUdpNFo0eXhQaG1iYlVQQmFqeklzeW5uekxNOTZWajlqN0Q4ZkcrUFM2?=
 =?utf-8?B?QnlCeWFZeDhlZEdiL0ZtNmdIeHV1clB3TC9SeHNBZjJCV05pTXFYdEt6a0Rs?=
 =?utf-8?B?VXlqMnlXMDEzUVFyTXpJeW1xVHpWcXU1T3A3aVNTUVNWZnNxWkU2ZWVpNVR0?=
 =?utf-8?B?c0dNTlBtbFlWSko3dXFuUGtncjlFbGQveEFkZmFQWjVGaXErK2NxdVMzR05G?=
 =?utf-8?B?d01aU0Z3UDRHakNPWk9JemtoVFdLQlNhZHYyWGhBOXgwYzQyOXJjY0I4UnVG?=
 =?utf-8?B?ZUxBK29EWEZzT3c3SHVpb2NoSDBOSllsVFpBZVZFVHV5emk1c2ZwclQwbDlo?=
 =?utf-8?B?bUgwcytzSzVTUUJIQzhwc2xpbkVoYW9tOExtWWhRTFFuNDF4MncydnR3Ujd1?=
 =?utf-8?B?dzZ0OEJJWHQrMXRpcUFHQnpCcUV1YUtsVEhzSDhWZXZKYjJNYXdsbS9RM2hK?=
 =?utf-8?B?ZmxOaXBPQTEvR3JIYW1FRllhczIyUExqRzM5bDVaR1lORkt0eElwNTVRaytq?=
 =?utf-8?B?MWlEUkROdjFGc0VBZGh0a24zc3o0QU1VWlg3TXZYUU1XKzBieFVqS09mQS9W?=
 =?utf-8?B?S294U1hDckJZSEpNVkdJTlZKemc4aHBrNTZ0UmdWOHZNUS9ZZWsyZnJMZDZm?=
 =?utf-8?B?aHgxMXRDMGZ2NzBHaTZMWC9IY3BPTVcvRU1NZVZVenVuQUdYMjZhZUJQanpB?=
 =?utf-8?B?STA0TU9ZRWhydTdFTk9qSGZLa3VaNlBzYm16dHRES0xTLzBBK0FhZUZtazJu?=
 =?utf-8?B?ZmtGSlFJc3ZWNzNQd3BIeUVWM0tFK3NyRTZlb3BDeXhHZzViQS9KcE1FNVJE?=
 =?utf-8?B?UkdRaWFyOUpxY2s4Sk9mdzdNamVQSFBEbVJpeGM0SmJlc1JDNmdPaHFFQ0xa?=
 =?utf-8?B?ZTBiQU1CU2pvSDZkYVBERnNla1FRQ21SaTA3UkhzMkdFUUk1anpjelRlanFw?=
 =?utf-8?B?WHc2TTJCT0htRlBEajZzVTFFMWtiQTlTa2RlSzBYS1RyejgvL1BiRU5Wc3BG?=
 =?utf-8?B?YW51VzJTQm5LTUxza2l6eGVLWXZ6R1lyU3NONEJFWGtVc0tRYVJ2bnR4dGpo?=
 =?utf-8?B?Tm05UC9kclAvVUlvS0h4bkJOYXR6azJ0ZUIzL3lHeUZHanRCK1RnalgxM24w?=
 =?utf-8?B?bVhYckdsNkEweXFnc2tuSC9sR3RSdmt6N1p6K2dXd05xUmI1RnUwNTZuZlhZ?=
 =?utf-8?B?SmNUNDB5WERIa2FVTjRmaHpTTXBudEd0Ri9DWWdWS2RzazlQYWUwVnV4b2l0?=
 =?utf-8?B?RHdaazJySXRKVHdQRnZpSFo4VWlYR2pQdkU4Mm1LbUduSWlOalhkMnhrdDY0?=
 =?utf-8?B?Z1Y1T05QckxCT2JHZmVNRzFBUTBFYlk3UW5rcVlFajRyU0Fob05tTEdSS2Zj?=
 =?utf-8?B?ZmZxUkdGMzFjVmtsb3l5YUVyNm1uelhxV2pLN1lzYzNubzhFa0JUc3ArY0RY?=
 =?utf-8?B?dzA0SllDbVk5NElYQi8rWlhSbE9ZenY4c3F2VE92bnNNbFFtMkg2Z3E0RUZ4?=
 =?utf-8?B?clRTRGUxTmJDVCtJK1h5b3hnM1RGWnBwd1FVT2JLMmhJM2REekJsaCtkQUY2?=
 =?utf-8?B?R1NWbjN4Y3c1L08xYWdCcW5QVUV2MUhveG1PaTdNZWd1R0hrS0NGeWFEOFRn?=
 =?utf-8?Q?BPRJ80CNxXcmuQIk=3D?=
X-Exchange-RoutingPolicyChecked: X9XwcB+/5W6YaP0AS6s0alwBsU1k0CDOYGtw8ukXx9afDW+5s1fCaPgqZ2IaULJ/nRIUdFwWv4nGZU55zicc3aB25HKMQLekWrTIGyykEU4IVrbn336dniBwBysheCVLgPHgHQs3N2W/tklYwsPmDWsE+ED/C2jLDHj2xcf5nO1GHDN8UA4Di5P+FqYqVN+Rr+x7N0JFH7OAJljGQzncg0Cbq2/m6JFpxQemT2Tiv037e+tzrKc1jJaNYUfQkkDe2DrV2spstupZTbfMej0mg3DSwo1u7eEUVllp00YvAu09r5ox6wHtVyOKcxutdjX6ikwdCZXYxKM1+EM6ukg9UQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5d80c7-6774-4784-c630-08df296ccff9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 20:59:03.7782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOxz0KI2ItyuLfRkCkCh8Hb2FPN3nU+Mx25Ucu090a7jJ/gRVo51kL+6buVaEkj70ruybwIYjCiwBB6cjDAxS2e4Lxs84qHhJZw+pWeEam0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB566895
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



On 10/10/2026 2:57 AM, Sasha Neftin wrote:
> The break after "return IGC_XDP_REDIRECT;" in the XDP_REDIRECT case can
> never be reached. Remove it.
> 
> No functional change.

Hi Sasha,

Thanks for the patch, but we already have it queued up:
https://lore.kernel.org/intel-wired-lan/20260902093443.93466-1-keshav74123@gmail.com/

> Assisted-by: Claude:claude-sonnet-5-5

Also, these should "Assisted-by: LLM" now.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=816d9992d9ed434ec52cfbd63080d518e535a41b

Thanks,
Tony

> Signed-off-by: Sasha Neftin <sashaneftin@gmail.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 1fb5f3cbe93c..3b7dd104d8d9 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -2525,7 +2525,6 @@ static int __igc_xdp_run_prog(struct igc_adapter *adapter,
>   		if (xdp_do_redirect(adapter->netdev, xdp, prog) < 0)
>   			goto out_failure;
>   		return IGC_XDP_REDIRECT;
> -		break;
>   	default:
>   		bpf_warn_invalid_xdp_action(adapter->netdev, prog, act);
>   		fallthrough;

