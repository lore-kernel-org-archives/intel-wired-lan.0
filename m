Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A4DCC6B12
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Oct 2026 16:26:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1FB9580A06;
	Tue, 13 Oct 2026 16:26:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q8TQg-riiMrX; Tue, 13 Oct 2026 16:26:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6BDE380A89
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791908799;
	b=hL8I/blnm9QEo3Mds3IAi0jW3DY5JeRh1j1hEQkk1glNXz0i0KO+I2c/RLQDoGfryOGw
	 MfDEGIS5HJAfTIeGT9iGEt/I4lGO/q/bpY1/pOp9OTyuEH1vZyuIQRdPr26ym9U/XhVZ1
	 MtB85boileftDmEtI/0/q9afrdtwTwqKsqSb675TgvyFiHDWmmngRzy27ycrkIU3GCR6x
	 J0YRybKs2m7gLwGJ4rQgDKO2BntTqGKCuxIUpuaf9I0QgkxxOcvOKdh9nLujZBJUXqPrI
	 z4h8eq0flbrpViWe6+GA7g3hTzEYvVrDHaoy2GGY1fDxeGJSfCswg4TB4ibCwzYJWBw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791908799;
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
	bh=RfDTwIfHPgaYZZ8zqKHEuH58b1X4AzUEhFuHawPFkto=;
	b=iSuQ/inwj27MkxzV2PrjTPBfwoUyKm/fFkgJFPqUB+27bRBn2b16IlALrrcmDmJSPUeA
	 C0JXqnYurv+wRHuiz+Ov3z5jlOVGb8h2j2o680yMuo6it7/kPmaHJ6cXVmCN4YTEZ4lSQ
	 6y6jmR5hUrX8LtSJ0+UxcgicOO9YwbsydFon9qkbu+Nal4XZWqQits/m8ZAUPEZX92rY9
	 mhJutGWHNex4+xv51hRiepOZWK5+mduFXrzRmv+1OTlLzdaulL/JAil7jqOzkUHBK+Ps6
	 50l170FI+XVU7ZNhbcgqdTyHYjp44Ry3ZYpMvS7fUu8L99Owk0mRbua0EXDAER16KLA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791908799;
	bh=RfDTwIfHPgaYZZ8zqKHEuH58b1X4AzUEhFuHawPFkto=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HI7iyQNnfmmb03VGpU82YW65Kr8x0o3818ft4V/dWfIeWgWt7anlTS78OHIHPRCOb
	 TubWtBoBpnF1umal5o5gQ12NYCIeJUjQ+IR26TeAsXk77erB6Q/BkBDgmimtN3/PRd
	 lV9SZC9BZrp/ueBxN62qrT2DjqlMwlJ2YOdybIJGR4Kcmk2vCWSvR38z1mnZqlztYN
	 mJdJyglJ6nl1D5BeFhMDwMiwoyYUoGXKl2A3/oDS76FRzRGdVqdOrfjFfD3lCOBK9T
	 K6MMbRwrhEhwTuFwupE1zGckWoZk6L9QArpkz1OOyTbtAl60uqlgPP3NUcdAMgRojT
	 Pfv99BRLeCXfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6BDE380A89;
	Tue, 13 Oct 2026 16:26:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 55B711DE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 16:26:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4758B4009D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 16:26:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZPF4Rghzxbwx for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Oct 2026 16:26:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2181A40049
Authentication-Results: smtp2.osuosl.org; arc=fail smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791908797;
 b=VHNzIeJawLrsMOLztfIUWdqMyvipZDezGSwr+2h+BRynh6keTrjNrtxsarACX5cNjpLG
 4fbyywxJ5xCnShFXPUf7HPUJYzn/5RHjPsJSLcIYe7GvHW1bEe1PMcUjaKdVeEittpQQt
 da5UHB5GmyRMbu/wN9yJYYmH3+yM7yFKrOQPJpcZ6OqoDRsaaaTpKruF5fnCyP6COAnjV
 ZTPgtzgWk+QqtRo2hglpmoZlQfaJIqKHRYRGxLbTeTzw2Ngzyo5z+Ujdl1t1oe/DdMsyg
 TnfVeY/NvTO5OmaNkWFoBJ9hsEwOXY6ERT9zq6+/CsXOhY7mcZDxDoiP1OrJMv718KQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791908797;
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
 bh=RfDTwIfHPgaYZZ8zqKHEuH58b1X4AzUEhFuHawPFkto=;
 b=rJaaoKyoYnbDbw/13qO1r9nsQks+L79LkuDHZ/b2Lj4DyoElQqkuxonqCv+VprSG//J+
 kWmT/sQbfMvxb8QTfuvymhwADeuItmueK8sv+JlMdCGD0A+UZMTgK/WdaYg07XgVdQXyQ
 hOSna/HXJmTcLW4t+3fAodZLHKIPyqz9f+MWv0tsbuQ2O3C7dNuwdlq42aAu7Kv9LRBhl
 92Y+g1YbT4nAUDSpu7uD9y7tmYLG6/pIyNDkpGEWqiLyD7nmEz46STA/sSjJtEVsok3eg
 HmVZIFoQJDr+ZyiLq19UkoVJtsoOLxM4FTaNrsJ7lG9Ehp4r/dEdmMEZ0puMkrMIVLQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KMjpyh+W; 
 arc=fail smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=emil.s.tantilov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KMjpyh+W
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2181A40049
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 16:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791908798; x=1823444798;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TuwKUaH45nmjBbvptGA0SgJD16KL+KIxtiAH5ShcJ4A=;
 b=KMjpyh+WFXwiCc45WlKkimRQ6Cy0xjDjxQR3vEnWGLxRKVMfRjBsbXc0
 mPpQzVtAGKh5SJjkNEWYsOtPMXtSTwMBPrNKRMdGWSOWYoTqgUYWVRQKF
 bBLZUPPQcLcfel+4VQwwpujkTqdNcoHzZm6lwpdMBjgxQVoUgX6BD+yTU
 3xLvbeuzEm2aKz0ftu86X46qkqnGBkJvZQxP2HRFxDS1QS2KrUv08Lz5G
 6oH0c7IogfmCztH2U47mIGNF/IsN/pCtU6uBwOoZQAmoy0pDbdrxQ5QUn
 yJM4OqUTAMxGKhJ2QpPk5sPP3GRntXxa6rU4zQihlskpuOwxt1i6L4syP A==;
X-CSE-ConnectionGUID: Yfdrmo3SRyaamaI6CD/uIg==
X-CSE-MsgGUID: 0CAeLMDWTMOkMKlBX+LzUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="526543"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="526543"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 09:26:35 -0700
X-CSE-ConnectionGUID: KG8SwDvPR/S87SeWSk3XnQ==
X-CSE-MsgGUID: /0DvvNNDTFC9S/v/NNxv9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="2971539"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 09:26:34 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 09:26:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 09:26:33 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.23) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 09:26:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLrEu5/CJ/qTjR65UdbOjAWNJFksy61lBZX6ds7er9bHQW24H/DSohp+r4sEOpi9pPDSQoV7LQCWj2MPrfg7K/IIE9GY3OzYff/oLLhEuaYHzAavSgEykva3X9msftofODCho/fGzsw5G6+7GSiKuCATbtWFM01VX/XvmOvOpmBz2ptxLO2vdpKIncnq9OVYho3MnUM+hDRjlh6rd9n8FmHNOmmvhb5LVSDa6H7QpXkV5nTBZ/bx90QhjHFw6M00guWJfDcJID7KA/jI0mYURipPSxNC97woeRGj4p/9/9xCcRlqkaY1cFN0IRAHe0AqZmlYreYmCW0D+JrVST2I8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfDTwIfHPgaYZZ8zqKHEuH58b1X4AzUEhFuHawPFkto=;
 b=CxHK7+dZe4MhDmwP2uDbrmnUbHybU0FjnX2TzVInFqS3y9vYT1eAFZprjywYe5WLoCxfijw2qD4tTiYJnoTnihy+0W3kSMsRJy6LEQm8M34L+cktrGwllWsPpOZoE7+NlmSH6WIglJ7xXDAddZghHXybHJVRDd7NPLGMLyI5daj5vNvf1IoOdZHWBCR62kU9qSdcpD4ly0GYS/Ofl8nKhrne3uj5S58jSDtqEtxJk56o7wZK8UBfr2/MvgJkTOjQs2+E6yicyBS+urTh1F+CNn17ImnEWvsTnrH1pShXh4oVSuyf4mnZQEakzsWyHL3UvIXrMQu47QtfKekB2y/Ekw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5) by DS0PR11MB7878.namprd11.prod.outlook.com
 (2603:10b6:8:f6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 16:26:30 +0000
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b]) by SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b%6]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 16:26:30 +0000
Message-ID: <e060d9c7-f80b-4eb7-bbc2-c0f1e26c4fff@intel.com>
Date: Tue, 13 Oct 2026 09:26:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v5 1/3] idpf: ignore Tx timestamp replies once
 removal has started
To: Tian Xun Ng <luckilystar08@gmail.com>, <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <anthony.l.nguyen@intel.com>,
 <przemyslaw.kitszel@intel.com>, <aleksander.lobakin@intel.com>,
 <aleksandr.loktionov@intel.com>, <decot@google.com>,
 <milena.olech@intel.com>, <joshua.a.hay@intel.com>, <alan.brady@intel.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <kuba@kernel.org>, <pabeni@redhat.com>, Tian Xun Ng
 <tianxun.ng@bytedance.com>
References: <20261013121224.84482-1-luckilystar08@gmail.com>
 <20261013121224.84482-2-luckilystar08@gmail.com>
Content-Language: en-US
From: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
In-Reply-To: <20261013121224.84482-2-luckilystar08@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0242.namprd03.prod.outlook.com
 (2603:10b6:303:b4::7) To SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB186312:EE_|DS0PR11MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: ff75a6ac-eab5-4050-9bae-08df2946bcf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|366016|10067099003|261009220027099003|261009221227099003|261009223027099003|261009221727099003|261009223327099003|4143699003|11063799006|6133799003|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: A2Fq4HDAiEYaP2/0AI2wkg7/44UxrIzqnQLryg7U2BYVB2cSrDPHpGY9S5Lqb8SOdXgFKG6IveQWFLGsWMR/3TWQxFP1+2OoKfvHqXoCeeE6dOYkJK9uzZUXRvgXnZuPuUlMRf5oJVeVbaWieNvdSQU5x0Bt5c/jWpehOg7LEVDdYvZiC0lnYmBoSImtwalohNTKAzEnQOnVdW0yyFvwYK1cr5sht7cZBXcegPY10zSoQCGvv8YnbrUiJwLz8o6VXw/IWbXaRoMyJQMBCaH9D0Ku88/8kRIMZ+fqhVPLFPjGzI0mMjCRZqnPUYud+7281ilYDUxT81l+tdhTYGDBkKonU4VqyneOG8eJQkNY50VNT+4qv5rSnS2TTgFsdqYlDjg2/2AMjob54Ca/qLk3jpnfnioZWugDrJRwD458XLslr+ySj6aB32jfNotJijkemSRgT5BHRMiCvaLBr7UHTUNFP+MJD2+SDDRkkkYLMAaXW6mPNPa9j9BOPNh5hIa/Df2aVkDMpxrZisv//OgcOpwXs209+4MkXWeBrVjBUrPgwfA2QyZpNA7fk+1WjNZQ90novE+knXfK3SAmMaObIgDhdJqFC1YRvENoROm5PLwnkkvG2Eu6GBiEEiiQaivZoInqw1aa4i/A67uc+ti4l7T20rZJyrRBAJ8WPQCwwRs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR11MB186312.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(10067099003)(261009220027099003)(261009221227099003)(261009223027099003)(261009221727099003)(261009223327099003)(4143699003)(11063799006)(6133799003)(22082099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1pWMUx5U29FYUZwcVBXZjFDZTQvVlJBSlJGc3h6R1pjRUdiSTBRbUd6RVBu?=
 =?utf-8?B?dVFncWJyOFk5bGR2cXJnWHJ0WTZOZVd2WU95Q2FDQ1k1YUtZL0lxVjJmd0hk?=
 =?utf-8?B?eVA3Q29NZU5CVjFGTCtOb3U1NDJ1WnQ1ZS9kOENMZjNFa1pyU1YxdG11VjdN?=
 =?utf-8?B?NXQyZmdVTkpyQXFTbk5LTGQyeUFuM1VzWWlFcXp3cFlDSTRHMzF2M3pRK2Rs?=
 =?utf-8?B?R2dKMmdDM2hGUGNjNVliNjlyeStYNEZuamc3VmpITldSeVpsa1dFOElhQmlB?=
 =?utf-8?B?OEYwQzRVNW03NEJtUEhyb1JxTzdrRXFHZ1FhOG4yMU5YbytYb3ZFZkI3bDFk?=
 =?utf-8?B?aFNmSnNwRnltK0VCcGN4bkRxenFtNFc1ZEFpVU1BZXR0bitETEVqK0s3UGx6?=
 =?utf-8?B?aERJL3JXRjJLbU5QaW03WC8wTW9zWi9VaWxybGZ5Rk41SEhpN0tBWFF5M2Zi?=
 =?utf-8?B?czNpMEM2c0l4K1hkSGNxZnh2TFRkUzRaR3M2S0V0MDJEZkhFa2ZueHBoTi9W?=
 =?utf-8?B?cllCLyt2OXZCOEhnK2txZU9HQnIyT0p4TUpZcUl2b0hwbEExZHpqa2duZVZL?=
 =?utf-8?B?a01UR01VbXk3ak1vSEtmdVdsaGtwbyt3bi9RK0FkMTFUR3E0cnZadGxTUjFP?=
 =?utf-8?B?UUt2REs4TVIxMDNYaVZhQ3BYTkFsWFQyMlQ3bUJPa0dXVmJIU09ZcW5sOUJq?=
 =?utf-8?B?V0pCeG9PNFFvcnNsTGlTbUYxUjlROUZYZDQzd3I5RjJMN3NLNythS25TVXZE?=
 =?utf-8?B?VFBGOVc5cHZROE1hcm9JK1hGVGdMUElZS3ZUVnZ4WXFxS2pMc3dVVGNpR29i?=
 =?utf-8?B?ejlSaVluL2orK3FiUzFjQWFsT1lXTWtrQWhEQmNvSWVqWGRrUlBYR0x5d3VV?=
 =?utf-8?B?Z3ZEdnFxS0xIK21xZlA1Q1hsZWFqejZHUTJFT0JuMm1BaWJPSENlU2VuakZ6?=
 =?utf-8?B?NnNMQjlKV2hSQ1VzVlQ1S0x1TFZndVRiUTc5QXZOdlVad2JTQkN6VzhOMzZQ?=
 =?utf-8?B?WFBTMExWOTA4TThaSmxPVC9zVkNTWlZ0V0xWVE9IcTIxbEk1MDVXdkJrcFZr?=
 =?utf-8?B?cWRpbEJ4YWgzM0RoWUxMbzkyTTBKakJtR0JLb3BLaEs4MCtNdTZERlVGODVD?=
 =?utf-8?B?VDI5VHBQeDhhSUVnaXJ4czUveTlFaFhSK2lDY0dFd2RibS9CVGxBN251dWdy?=
 =?utf-8?B?aWdCQWU5TzNmR2JVbFprMUxqRW12RThmdjJmNG1vWCtrVW9RdlFXNjVST0Rm?=
 =?utf-8?B?M2o0ZiswS0thV2xWUkcyWWJJYk5qK3hWVS8ycFhsVG5meHgzYnh0RTRrQm0y?=
 =?utf-8?B?dzZibXM0SnZRWGFHaXZlUzBmMnc3Y21jL1NINFRjWXl6NVJVbFlZeitvVFZm?=
 =?utf-8?B?UUs3UThzaVVUWnhQYkIzWkpQbVhBTXN5eDZaRXhTbUN1TkNDZ0g3TWkyc1ZS?=
 =?utf-8?B?ZkV5NElMbFY1aXVwRkJZcVZXSUlGS2FxT291ZDhTeGMvZ2YvUjMwVi91OHR1?=
 =?utf-8?B?SS9mSTZ6NDNFbFplM0FyQ1hUNlZaMU15aElhTkpMKzFINlBOUmhyU2VlZXg0?=
 =?utf-8?B?RzAwSUxIT0FjcUFBd01IdFcvSHpmQjBqVW9yaEdMa2x4NTBoMkpzV3laUnlL?=
 =?utf-8?B?d2l3VWp0aG1Db0EyemZRU3BPQi9XYmUzRXJRRUFrWGxac2ZkVjhFZWg4V0tm?=
 =?utf-8?B?WkUvOTJBWGs1dkJBYnI4b21aVVdUaUhlUlR5dk9IVWwyTUE1eFBjbDQwbU1N?=
 =?utf-8?B?YWc0Qk5LYXlYR0VuaXUrYkg3dkEyUSt3UzVCZ1VjeGVHZE9uUVA4ZWtCL0Fq?=
 =?utf-8?B?SkFDaHZsazc3OHgrdjFPd0FXU2JCNEhIOUc4bXg4R3ZYYWIxdThUaWU0eWFF?=
 =?utf-8?B?eU4zTUJZOFM0czV3UjNEcUJ0dHpxcTRIZXdsemFXVkU5dXhSM2RpbXlzNmRE?=
 =?utf-8?B?NWZoVXo4aitCNitURFRjZ2lUUmlpMWFSeVNlVVpxejltVDB4dVNrWWIrMkRW?=
 =?utf-8?B?RENmUzl6UGhyN2gwYjF3Y0hYOFJQVTMvRmtaYmRYd1IxNnNCWEgzdVR6cHRB?=
 =?utf-8?B?K0FYMjBucStzOFhPZmlZazlCekhKMXdvL05uR04vYno2Wi9KUjBjNUhOenZr?=
 =?utf-8?B?amVZaEpWdm13VkRjaHFkeHFMd0w1RHNXaUt2L2thSER4OFZtbGxSMjF6alNK?=
 =?utf-8?B?RldwQWNwQjZLc2hRWHRYZXEzRU8rbVhRTDFwT0tlVlZvbHhEdm1oWkZxY2gx?=
 =?utf-8?B?cERGSE9FN0hCNmZoRW1hNjlsMW41K0Z6QnJROERYUjBKZ2wzWGNJSDFxRUZn?=
 =?utf-8?B?ZThPZGRFWkkySzBnRWRDOEoxdFgyQk1XS1ZBWjFTVEJxUFNIWERMMFczOEFr?=
 =?utf-8?Q?e8WftB3o4SlQY+dk=3D?=
X-Exchange-RoutingPolicyChecked: q5H+81+NWOP5/vTjZmYJWui6yIXYmOj85S1FrsxSFtYw7Ayj9/+/5pNZtdC+3D2zn0z/DHl2/zbI7K7WFMcunwpLuDSBU4JKVqlCdaL+1zcKXZeuHBt17pCQN11MSXm5T5ufzF9cRrWn4Lyd+ujYqljCCgafw3lZAYwILEXLrz4+aOVUsvDQLpVzolNeGOZPLMQTfUEAlsIKQiy8yWG+7gQctNfHX/btMIybj7621VAcqfEiQzr5ir99CseWtnTR4zqAv0B7gjAyTO5JnO/VQFhR83hLfYqaH540QTqDcx2SE3SrWuqECOaaTdLDFKnx4zI6WmjMm93uB1wd9cwbCg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ff75a6ac-eab5-4050-9bae-08df2946bcf3
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB186312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 16:26:30.5939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mltYd95lYKWoiq69MzBtSRiLawzNUJFWPQwI+NYwACVC2CR/dQufo5BwKTOGsucv5Jc+p8KSm6u1Oqwj2aoJcCb1XRbXChDqYUresLZjODo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7878
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



On 10/13/2026 5:12 AM, Tian Xun Ng wrote:
> From: Tian Xun Ng <tianxun.ng@bytedance.com>
> 
> On remove, idpf_vc_core_deinit() keeps the virtchnl transaction manager
> up until the vports have been torn down, so mbx_task keeps processing
> replies while idpf_ptp_release() frees the Tx timestamp trackers. An
> async VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP reply handled in that window
> reaches idpf_ptp_get_tx_tstamp_async_handler(), which reads
> vport->tx_tstamp_caps and takes its lock after
> idpf_ptp_release_vport_tstamp() may already have freed it.
> 
> Once IDPF_REMOVE_IN_PROG is set, wait for a mailbox task that may be
> running a callback before releasing anything, and make the Tx timestamp
> callback return when the bit is set. Matched replies to synchronous
> transactions are not affected, so the vport teardown still receives
> them; mbx_task is requeued straight away for that.
> 
> The last patch of this series sets IDPF_REMOVE_IN_PROG on shutdown too,
> which would otherwise expose shutdown to the same window.
> 
> Fixes: 1a49cf814fe1 ("idpf: add Tx timestamp flows")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Tian Xun Ng <tianxun.ng@bytedance.com>
> ---
>   drivers/net/ethernet/intel/idpf/idpf_virtchnl.c     | 12 +++++++++++-
>   drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c |  3 ++-
>   2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index 1caf52706..d0db60647 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -3204,8 +3204,18 @@ void idpf_vc_core_deinit(struct idpf_adapter *adapter)
>   
>   	/* Avoid transaction timeouts when called during reset */
>   	remove_in_prog = test_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
> -	if (!remove_in_prog)
> +	if (!remove_in_prog) {
>   		libie_ctlq_xn_shutdown(adapter->xnm);
> +	} else {
> +		/* The transaction manager stays up for the teardown below, so
> +		 * async replies can still arrive. Wait for a mailbox task that
> +		 * may be running an async callback; callbacks that run later
> +		 * see IDPF_REMOVE_IN_PROG and leave the state released below
> +		 * alone.
> +		 */
> +		cancel_delayed_work_sync(&adapter->mbx_task);
> +		queue_delayed_work(adapter->mbx_wq, &adapter->mbx_task, 0);
> +	}
>   
>   	idpf_ptp_release(adapter);
>   	idpf_deinit_task(adapter);
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
> index 14dba40a9..1422b30d0 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
> @@ -550,7 +550,8 @@ idpf_ptp_get_tx_tstamp_async_handler(void *ctx, struct kvec *mem, int status)
>   	u16 num_latches;
>   	u32 vport_id;
>   
> -	if (status)
> +	/* The Tx timestamp trackers are released on remove and shutdown */
> +	if (status || test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
>   		return;
>   
>   	recv_tx_tstamp_msg = mem->iov_base;

Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>

