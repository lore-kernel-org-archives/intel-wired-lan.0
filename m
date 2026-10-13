Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AA2CC6B19
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Oct 2026 16:27:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F082F806B4;
	Tue, 13 Oct 2026 16:27:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YnxpxCvFs_EK; Tue, 13 Oct 2026 16:27:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 58BAB80845
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791908853;
	b=SDV/7qlo9eY4LzVDEFzKGcsZoEz/YN7iHslyzEHvfsI17lj5VW+EtYHgni+lW6wL+S91
	 XnpvF7Rk8Hl22XgFIxZ+3XVZclpTIVpBooRyji8C0KvgRQ48TcZl8DlBY0A5QmQMNcGvb
	 MpT5kycBCaAks1iROu7eMQ1EpzTLTbgSmROyaACKzEU7uW4UAMm54Oi5q/kHBcoz5WqSs
	 A3YlbZxlNyTESAnmr6mhehyb8nZIY364OzyWUpt5hle4h4+y5dyDg5+1BjRqdvDwf9YI0
	 R7yUb4RqbEFWkusWal0zveiR6JpZ26G/mGFi+w/+Zq7CFTsQKK1vM9IhjbaP1wNfUhQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791908853;
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
	bh=+eHK1zdres7LT1Z+3sTI6yVfERUIMsh1zimgbkNDT/Y=;
	b=FCthPvB/yiFrpF/GYNVD7gX3z73Mq3toj75UfnyX6s7GyF6AmFYgxsJPt0Tj9pjrsbAU
	 TbZTZKBSg4OvlkxX7pSNFFNVN5IKTkpC9Z1hNVx9pHamIEaznZjSGpKYQWSkNpyNJzYmu
	 PIxnssoNaV/c2jOxmtGuMjdmOrGG6ddDwJApWrB+GonYPo2OEzEbQ7GUNDjSw2z8kS3rb
	 0D4UPbaxnKnG9PRwlKFPzOegICpuqclf+780HnGp8vkILXaDDqLibHMmTmV8SK9uaNeyK
	 cP+QC9qmphWE3LmCEBbbI+TqZlTRE7Rfm+klNOw8+icq4vTIXO1quLsLqXbWmdnZh+Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791908853;
	bh=+eHK1zdres7LT1Z+3sTI6yVfERUIMsh1zimgbkNDT/Y=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AUeBxg4kPeODx8dhDkjQUqTLnnOKWwdUAOFBoZQ8p0nbxyp4ttY0cbP7h0WWc808t
	 7fSzzLDqeeAZtMOH8XuC9hM/OY4Zp7Q8Nojx28ZQn3SkCBL1JR1X/fFu+Z+JPkUXrr
	 MMi7lxoCB18CmZ3lTMtsQonWkAM3TqCHMSb9wjD5u+m9p/h/Pjz1KV5HqaVXd0GZ6H
	 hEfICBLi9EI9o1ZkGIJqmEUyzjyvxoR/usGiMcf/OKBljT6p/WLcq26yNMq4Fhdn1A
	 BhcqY3WJ392xYgNy3I03L4z5raYDgRaElRJwARVPtZDJbCWlr4X+1mrzKATI9CBrPA
	 sygAdux6XvYuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58BAB80845;
	Tue, 13 Oct 2026 16:27:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 669F4129B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 16:27:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 58D904009D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 16:27:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R0Sqs18tgbv3 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Oct 2026 16:27:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6ABC740049
Authentication-Results: smtp2.osuosl.org; arc=fail smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791908851;
 b=tDTUs2sAuCsSJUnxYK2o63dv16b71Zo6zy8NrC/VLvxDdUfhNMDfX7GFvBmwR/fukAcI
 spDnnIOMcOmtc0iPA7h5Fe/Z9HAhbbqe72Av0ILOwKfpSMyLov/cTNOF/+pmUCPh0KGlg
 iUu9HADuwWy+OgQaqW5dpiz9C7HOjKZnvCMbum+Pw2uUmsBKo5YYBBInFv8tX1Fm6Irom
 B5M6nzd6FYkD0Dev5vWO0nC0PLptt9Vhpvt8AXp++Qc5fb3q//d/fGRmWnwjK0oJS8v9q
 6GFEqovDopywSfvb9iNriLiAXuWo62eChnPH5GwLGsPCQLv5pbTFLX74grPGIpDheBQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791908851;
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
 bh=+eHK1zdres7LT1Z+3sTI6yVfERUIMsh1zimgbkNDT/Y=;
 b=BmbPBo1rzGYSWtByYYRwAH2kCvGbwG12Ev5EOsYh0UxwilTrHP6z9UpqKhM3WnuU74bj
 +HeU8fQv0NXahLgX9LMX/2L9nrE0RGOufNdbmkxE08w2N3eM6LY9sGJsl3BI2uxb/rOo4
 t9gAqBwT/NosWu7cRdxz/6cChs4ipSI/Q5I2bR7jJ+Yph+F7NMHMWu7op6OvTRWPUHB9q
 uXoMu4QE2cDDqB+XyNMaouuGtegRtDw+5Z3DEya8flueuS3/mqHlOAlxd2yCSj+r8qd/t
 Mu1RyxT08HkSwCEUsguyV6O8IdkudxJr2Whi5ruMVnCvie66pXq5hUlKAJXtwyuU/GA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=O3A3aBtG; 
 arc=fail smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=emil.s.tantilov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=O3A3aBtG
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6ABC740049
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 16:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791908852; x=1823444852;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=t4DPjYu4EvgQO0d25gGdT0U4MdR4RgGwvXxrxhkcDL0=;
 b=O3A3aBtGGWLz5u6Vg8DcevWmxRyxq+YU/IfVY8+g0dQ0nky83RwfaHam
 L5EIBqvL+H8u2bxwzJKE5kgSqMfhsAA2svkzcq50VKekfH7NsT64+tYas
 dv1/1B+4EXzwq55zMhYf9E3ka1u6SxsPSn9f4y//SWtaCamyFWQjpj8p6
 Xrbxwj90mzhdVTUwSn0CBamyV7mFqrq+XxgB0LXn/42ARTsgFFP/DAcxQ
 bL1qsshMA6blwGGZ0fLiB4TU0ldGe2DVQRuJgqj2SXO0/Ipxzdp2EYqYW
 smv9gWEZIGrY7yUSQJWiqsscW0hzHTviHIdlVLWb38JR2i91B5VV6y+w9 A==;
X-CSE-ConnectionGUID: ood+4r2ETbWdwy6qN26A/g==
X-CSE-MsgGUID: 22qXI32jTxOIAO8Gy/xTiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="526643"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="526643"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 09:27:31 -0700
X-CSE-ConnectionGUID: gpgA8DpdQHu4O4WtyfVPfA==
X-CSE-MsgGUID: 8t9E0YDsTK6d+Cf9Dh02Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="2971633"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 09:27:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 09:27:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 09:27:29 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.21) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 09:27:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YSoqHTVOib4AlcxjKtWF7dr6jKAj7Q9uAEzwMWzYG6nN0TolkVAucQzRofpbYfvGNRI1ePGo+1XCZjlruBXYVRZiebS4xCPva3C/IZgmB6v9hwJW80lngMc8jNfqX7QW4OIYatDpA41qqCo1lWzm9Z4Jw69hhVUDpgR3ov/D7ov+q3YPDLNoxSmdUGsnhhrCaps/Y/x3Avn++T84eq5d8pCyz9PfuZlIhR//cL6mgXeWuNT8lqhjntACi8UPM7E9RF5iA8RiAtDjYjPjyrE9NJ2J5nIXGe3RhFsnBuVUv/ASwhKPgUCVJdILyyrmOzSuN0XsdNwJm8MDgNArOwdP6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eHK1zdres7LT1Z+3sTI6yVfERUIMsh1zimgbkNDT/Y=;
 b=zUFoVQKd7NZVIJjlo3GycGLhe5v00PdVKMMO20LL+bPnXHcwPaEZ/dzwnaOBrTF6rFX5qOgOH9HVTAjLIHlkHibTUz7ihtBWOEIVb1vGFYkzBP+jDMe8DwrePzQse1Nt1frjiNfVWKYJfMqNMqGQ5I1lQvzlUZ6OrrcJUQNkGlcHRaJT+wBctfFQI1cWSVyBDNwGlTwQ+m6QLtYYLrU8xXfDTz2g2yALk46YJ41apIKvgxDvOVpKf9h3booLRJSUBFEYZjDYQYQYP+Q1xlnWRT25fwCQijJdfZx08CxGDvb7szW18jWiYSmyB4nbl3KqkIzZjbxtv6lxV6qVrCbFgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5) by IA1PR11MB7246.namprd11.prod.outlook.com
 (2603:10b6:208:42e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 16:27:26 +0000
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b]) by SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b%6]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 16:27:25 +0000
Message-ID: <e798d410-9dce-4206-87f2-5b874bc44ac1@intel.com>
Date: Tue, 13 Oct 2026 09:27:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v5 2/3] idpf: ignore link events once removal has
 started
To: Tian Xun Ng <luckilystar08@gmail.com>, <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <anthony.l.nguyen@intel.com>,
 <przemyslaw.kitszel@intel.com>, <aleksander.lobakin@intel.com>,
 <aleksandr.loktionov@intel.com>, <decot@google.com>,
 <milena.olech@intel.com>, <joshua.a.hay@intel.com>, <alan.brady@intel.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <kuba@kernel.org>, <pabeni@redhat.com>, Tian Xun Ng
 <tianxun.ng@bytedance.com>
References: <20261013121224.84482-1-luckilystar08@gmail.com>
 <20261013121224.84482-3-luckilystar08@gmail.com>
Content-Language: en-US
From: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
In-Reply-To: <20261013121224.84482-3-luckilystar08@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:303:b4::20) To SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB186312:EE_|IA1PR11MB7246:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a948435-ab81-4064-b4cf-08df2946ddcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|22082099003|18002099003|10067099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: KTqWk5OlbU72iQE/Cy8dbBfTlyXuVUhuZjx+xNt6gCKyL7s73Z4Np9hjkFIxJLizSA/ZnihXFRAAXb1BQZK8G6jIxWonn5QG6TbirO7itVXS/7RoCCj4U0w4msfOud7tgyCVz9ilLdWiZwgQ5JzzDstpcqnMcYC77kG+wA449IoSbs59sEGS0Xqwg4+AO4XvPMehD9JGoP5U00wi9BShvpFN8xeyieFgaflxfNGMhEYuwR8aZ9weg+ZXcm6a0fR75l3t9jtVBzsHHwKs/8xai9/nv7eT9nFKV+VVhbcnaV6A/c58RnErndSSK6fLV1atrSC/rizDLfzMep1mAFw8I6hX2pgJqwiI3lUGsSyVnajteUdiRL9UKoAmefM2UXvm8ojBRl82hzpNbw7SVQDplKNYuRsqxUCRVjCgjC+VVJ+sGky25VsAKi8EW/dvplc4vUUdNcdYdQ17MW4u/Tc0QMMN4/mKUbrQdOlQJegULvtrm2nAu1UGRqf8cV+wPcfs/2N4sW2GSCncd01KIi84DtZPPIVX5Gml5ue09smz7QVsurd8zpUXP8y66fBYhMZkErYse/RBSe9mj68qU47G9u1cPzwKw3LZ/Dy0rA6JYD6FXuS0ZisdWVj3rV0HWo9Hedu+3+Ld4iOjsPTdj7R1AN7pMfDebvCy2yceMeXtC6w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR11MB186312.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTVYUGh5eE9vWlAyb0ZsWSs1dURpSStZelNXd0xRaERIR29oYjg4cm1mRFdq?=
 =?utf-8?B?ZWVYajZucTlXaEJkNFFzZ3JmQ0VubHFndlQ1YlZmS2RQbnJYYXFVVURKVVJi?=
 =?utf-8?B?M2krM1RPMjlRRGQyemZjdVcycHRLK0pncUZ4VEZweWpFVG94dHlkSGlFL2U5?=
 =?utf-8?B?RXZ2dnNXKzVuR3ZHNVFhSTlQNDN0N25ObHJBbmsxbko5c1J5cHJkbVdEZDdJ?=
 =?utf-8?B?YW42NEs5SVJicXFxWCtTWjBMaE1tZmIrdWF5ZlpDMFZLMWlobmQ3NWlpWGkv?=
 =?utf-8?B?TTl6VTMzOFZjSzlsQ3RqU25zY21zYVgwRlZDR0ZPVjYrakJ2MjlRdmZ1Mlox?=
 =?utf-8?B?M21GQTF2TVBCZDhXTUl3cTkzNGdsRGNDK1dFcmloSXhwZE5LMzg4cGQ4SFBo?=
 =?utf-8?B?a1lDSVU1UGl0SHArbEVTUzZYZVNWV25mM1VRQmJIcnZ6UU1LWnFnb1l3cnJo?=
 =?utf-8?B?eXo5U00ySnNXOEM5UEM5ZGlSMDlLODVmMkhORllDVHhoYng2WkJSa0l1dFFQ?=
 =?utf-8?B?TlovME1SaEhlUEh2UGQ4TUtiaUQvblh1NEwwak1CRExMQkVSOG5lWWhkcDBw?=
 =?utf-8?B?bW1UMXk4QWw1SmVzMEtVV2VwYjFYL3hwbnFYa3NaNUhOTHMrM29Ed2xXTlRx?=
 =?utf-8?B?MFdxT0NnTEloOWpPZ2Y5aUwrVFlVVGVhMWtVeFFwSEZ1dDJ3SWZYekdSdXRM?=
 =?utf-8?B?NWFobis2bEJhRlU5UnlteUtoY3VIWDFoZmpwMjUxYjRDWncyZ0d2NDBZQlpD?=
 =?utf-8?B?a1BjRkpjOVI4R3BQd0M3djl5bEtDenhxMU5CMjF6aGo5U0ZlamQzYUphV0g3?=
 =?utf-8?B?V3Z0L1FkYlBFbVlSQUZ1eWJZeHl3RjVyd1VlbG5pYkZYc2lYYjd3K3dnY2Za?=
 =?utf-8?B?b1cwNW5oNHVTOXMxZzFpUGYwY1Q5cU1uOTBPaDltK2dIT0xxNXY5UDRsQ0sv?=
 =?utf-8?B?VE00Zi84SUxqWEVQaHVSYjVPL0EwcTJ3Nm1sMjF5Qkh2V1J0UmhPYjdGUnpi?=
 =?utf-8?B?b0M1OWJQeFF2b0ZuUThrTDRMRi9DblJ3d1NZMndYcXJFWUVnOGJFckRia3JZ?=
 =?utf-8?B?ajNQTTU3cVdxckdFTklya1hGbXFmc2w2M1pndXpqVSsrcWZiWUFWTzJlbDJj?=
 =?utf-8?B?dVQ1WEhyNDRJTGMySHliY0JRSWZ5endkbmZpSVBTazNNRUNxRTkzVWw1NzdN?=
 =?utf-8?B?aW55LzNJQ1JaUTc3cWRsZ0h4Q2xuR0xjSGt3NjhhbmpsUllkc0pxRVRvcjZo?=
 =?utf-8?B?U2FoWDE2R3R3S09KbTFhNmc1MVhJM21OU2xBSmVFdXJ1VThkSkFzMXF1dGJj?=
 =?utf-8?B?ZXFvRVJCZFNhdmlIU2dPcDc3cjh4dVZ1ekg3MnJ5T2VPVTZROHNCNFpZYnlw?=
 =?utf-8?B?UmFrUmxYL2NkREpvNlVKakZRQjhNUXBpWCs5RnZPMkFZSEYxYlZ6OUtJTGZr?=
 =?utf-8?B?aUhVQS9DY2xjOERNV2NnQWlMSHplUThzU2d1U0prOG83SnNydWxKbSs2R1dS?=
 =?utf-8?B?dGhKOE5rYzZWZzFUTERHTHY0Vzh0Z1Y4Z3Z5dnI0T1o4V0l0WGlaU3RkZXBI?=
 =?utf-8?B?eHE2dE5HZStjaUU3ZlVFYXlTNkRNUVZYTGNJT1laNHFjN3FXQTJtb29KZ01P?=
 =?utf-8?B?YUErbHIyNzhEL3RzNXEzOU5ydU1kVkhWMWswbHRBUHRXQnhHcEJscEp4QXJU?=
 =?utf-8?B?NEZ3VXAwb09DNzZubFA4R3dLMUpCWGJuVXplMWo1eTVYZjgyVGFsLy9wbS9G?=
 =?utf-8?B?OHBjdTRUWE9BTFZ2d3p3aFZGK1RUSDN3aitrZk9qYjVXUU0zNHF1cXhidmtn?=
 =?utf-8?B?NGtUNlZXZTRWUU5NVTd6azZ1TTkxZ3hFY1NueGRtd1RGbVp6OFJUVmxNSkN1?=
 =?utf-8?B?ZGQ1WktFVnpDV0NVQmF3UExtNld5MHdSeWhUdFRCOFl2bjQ4aFRyY2c2SWJw?=
 =?utf-8?B?UVlZSTIwSkJxeFpENitQZXExSmRHOE83empMYTJzaUpPeHl1R1JnbHpkOHRL?=
 =?utf-8?B?VEF1WWVtS3phRnhSMVk1ZktqQ015aWovRTBNSFA0dEdHVldGNkJCc3BqNnZi?=
 =?utf-8?B?elVDRjVtOUxsTGJUV0l0WGdCTXAxWGMzd1YzOEp0b0tKL090R0VHbVE4bUdu?=
 =?utf-8?B?SzNvdzRIdmw2Z0RQcTBaQVBEeFBPK3JYd0lCYVNkdzc5K1VrajlXY1g5NzYv?=
 =?utf-8?B?VTdkZFl2eGx6Y0RERXcyMXg4MHRia1h4WnNGNzA3b3lWSGtWZmRBWUY0dlkx?=
 =?utf-8?B?Y3orM2orSVZ4bE5XaUdYNHMyZzFaNmt3cGFabTNITmcrQmJCZW55VlR2cHJX?=
 =?utf-8?B?Tmt6ZzlrTlpuOGxoMDZqZUhiblRyVENmeTBqMVdxbENBWkFjMjV1VkFub2gy?=
 =?utf-8?Q?m+YVR5kkaks85ybc=3D?=
X-Exchange-RoutingPolicyChecked: ek466WGbqRGmxmdR+zfJzieJ8LTlZQCfvf2Mo0xjrlQGbToxbJyPHowJ+b2Gy58CttivdCWZFM5HJccDoC9Czose8feSVbyRItNZ/6N39VMvNUG1w9AOYNAq9fi6jUgg59A8SZfpk8Q3UCzTS/U3C+3UkF8OslDULXx3qH+AsEb0Edc6SjNe2F88sK4maJEtG1/wPjkKiivtFqKOgIbYsUw/HBqViLnfwIdg/+YtjAusSEE9gcCTgJwaNEZ/tw4BO8iFTCTCxEyyTPALnZLdfj//HyVSbc073YIIS18nEw8dEyTsc624YKZ2NaB8Y8iKrkZVGzgjd2+Q1iIjf9+Riw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a948435-ab81-4064-b4cf-08df2946ddcf
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB186312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 16:27:25.7167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vf2iIr4v2fcrQlRIL8bzDP/rKhwS74ijzw/CJUJdGkVDbJHVumf++epDxc2664D8ijsXRuxqegCyIkOLnOpXo+SJhFJrw27BKEgcO6yXeeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7246
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
> mbx_task keeps handling mailbox events while idpf_deinit_task() releases
> the vports: it requeues itself, or is queued from the mailbox interrupt,
> until idpf_vc_core_deinit() cancels it once the vports are gone. A
> VIRTCHNL2_EVENT_LINK_CHANGE event handled in that window looks its vport
> up in adapter->vports[] without a lock, and idpf_vport_dealloc()
> releases the netdev and frees the vport before it clears that slot, so
> idpf_handle_event_link() can follow a NULL netdev pointer or use the
> freed vport.
> 
> Make idpf_handle_event_link() return once IDPF_REMOVE_IN_PROG is set.
> The previous patch waits for a running mbx_task after the bit is set and
> before anything is released, so on remove a link event is either handled
> before the vports are torn down or ignored. Shutdown has the same window
> today; the last patch of this series sets the bit there as well. The
> window also remains on a hard reset, which tears the vports down without
> setting the bit; that path is not changed here.
> 
> Fixes: 02cbfba1add5 ("idpf: add ethtool callbacks")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Tian Xun Ng <tianxun.ng@bytedance.com>
> ---
>   drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index d0db60647..2cfd216ae 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -40,6 +40,10 @@ static void idpf_handle_event_link(struct idpf_adapter *adapter,
>   	struct idpf_netdev_priv *np;
>   	struct idpf_vport *vport;
>   
> +	/* The vports are released on remove and shutdown */
> +	if (test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
> +		return;
> +
>   	vport = idpf_vid_to_vport(adapter, le32_to_cpu(v2e->vport_id));
>   	if (!vport) {
>   		dev_err_ratelimited(&adapter->pdev->dev, "Failed to find vport_id %d for link event\n",

Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>
