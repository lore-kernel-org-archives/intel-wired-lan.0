Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6D2CC6B03
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Oct 2026 13:21:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6525A605CC;
	Tue, 13 Oct 2026 13:21:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qHwwhqY4DJpE; Tue, 13 Oct 2026 13:21:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AB6A2605F4
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791897704;
	b=S2zVQOAqT498X0sRgryKkGmG+eFU28wuBPJOovXHAUcBoODr8rXxB5v72/cxh9iNY8RN
	 PngxjCHB/i/GWEJnYzRxN4ENT5ZgPRuYXyswiICOlpOF16hhp463RxnBKetossLL5IjD5
	 8/n3cXzV7KjUVCnTHiTvqc+zrIEd7oTxoWT66gZrLZ85VONcdR6JBalkqy3cmFGsUfnyD
	 ZIeSJu/6fmqy/UzWJR4AnnbxiOqLAncrSzh5DY5WAPLEKLdEfCmcvUqmAkaxofxKwQMYo
	 DndI45tOt7EwnEOuy3BOIBP3g/ddBgXtnnJEYVoLvWgPV/5cv76XfLYvJB6zJchp2WQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791897704;
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
	bh=ycyuxxTcno3fKGSe2OMH5ttGOqsb5Na4gOIUYQ+espY=;
	b=XFK/aqqb1Na9iEbHuwbWU7Z7dy52uEe9/JzXItIgkfVp5W+M3eemY3tbhVZxFhA6dd7k
	 MwPsJsc2/CKQUgG3lqhjoWXVAuNxzGGc5Yec14oUvSQ7MAJz65gQvm6RB7f34k6jUUbYH
	 rBxl3H4vZhQrHD9bnz71/aCO6cz8MNw58qKFfOKcVgtEY/vi1S7JFo1TXGwk2pVSrfQk8
	 b+CUALGnnRyLn4oQzBQBkzxhPxNiz0V9z0qPPJf2UZmDkxBRM3M9gWm8KQmsFvaXOZYbA
	 nn3B3JXe7Wr925Qe/nyxgZi49rmK9xSAt2ZV53h8ZDGjV8CDzNoCn9Jy9igWh+Z5cRA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791897704;
	bh=ycyuxxTcno3fKGSe2OMH5ttGOqsb5Na4gOIUYQ+espY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tVeBjdpNrTUs0fZZ8bbvG3OZjKIeXOGhH3ZgtIoZF+6x1ylP7H56kllnNO66r1Zol
	 LCGWTXIZ8FmIczxgtu7Ut6EiZa5tg6P4yY/L0yRJpYsnMdh2W+Og8LNP1gLjX+XcBA
	 ANeBo84o2SQ1Nho2EiaHu2SzAl4CgZe5B9MJQFP9PYCBXh7xtkmjYmW60kFnoTxaVK
	 Zmz3/Jth6vIEP22fpWECZ38qtooIVaE3UBh0QvYVu5MHZuArsZyffIUHzorU/ttIWC
	 0SIpBw8KbBX3x5GKPZckUhcsVWSKHaLbUvCJNbw7bqEArH7Sa0uFEyabg9nqgehEVP
	 pJDdoxQEKmYFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AB6A2605F4;
	Tue, 13 Oct 2026 13:21:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 17E9EDE0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 13:21:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F1B174007C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 13:21:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X9ZJaSz1VGda for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Oct 2026 13:21:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A64814005C
Authentication-Results: smtp2.osuosl.org; arc=fail smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791897702;
 b=VT+1aGFXvWKw1XlsmL56r3FXv99GdyS0LqrMGpo/az69bSpWbbfqTYfqO1It3xek+gaq
 ROQVcnkMzNEAXkf+OJ/c6nOHExTIevOfcRtfhCZVpe30YgN9ZrHpHI2fVHIH/q0GGL7tR
 Ab8ElpIJwfKTbriKZ9TAC+rAxrg71UdCucZD90sZC3O1zQYIVRBYIc+Rs1Mn5eU1H5h8/
 441nQSP2NgY4l2Qvj2FfYKp0LBpCzJvkMqIqLKIX65SmlUQVw/Z52b0bBSfepk6G20kwO
 WOm3FRGHu/1yK0h9fzmy8y/8spZPhRgoB6G7Koa89+kGhvdXw7G4dd5AwUVKxb02dEA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791897702;
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
 bh=ycyuxxTcno3fKGSe2OMH5ttGOqsb5Na4gOIUYQ+espY=;
 b=rUCwwPSdkUNfQdgh5IcYdrJ1VPGbecIO07jneYmxbTkBjEARTQfh0fXKxSnJeilLlHS2
 E0oMS4QoYhxpHVoGiqTkY+xDbZfnEiaHUfw7KTOeR5q7rZmIPYmkoygWXKHBdX2GWaQeY
 LUVXwZ9klz8ZH3EBteyrTNz6aH0RVP++ATbhahTdrjtq2US73ic/JZp6g65NNDjykwNQ/
 O8wC6yNM50+t48/T667gRFqSORlHpDrFpJd0Cv6Y0V8fK6lcRrmqdG3MNt3iDSFT7Nufl
 C3FlYDLZ/yYVvYUB1LBgYaep3//AqTYwJ1cbHllactHEoC+D8q32wvKMSaqqSiRCxQA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=SOUHIVSk; 
 arc=fail smtp.remote-ip=198.175.65.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=SOUHIVSk
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A64814005C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 13:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791897702; x=1823433702;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uPTvMI9GcgY27ts5ExPREZOvNppMkagw1A4ryILrsgQ=;
 b=SOUHIVSkqdHbSDydumPbfceYzsDt7qIHjATasXc6/n1skiXflPn5bbxa
 RDDqJu+BVibMqsqyVr9RHbpDsp3oWzykTmAqiKcC88g91MPXCL1HSPV8o
 N8J4zSI+i96xOZDNNkKJPTKhJV74hh7krIXc26FTmh7YwQ0o11b8RKOzD
 Y7otFRo3unuPGlV/f1dsjNv8+BW+2M1EywuKdyV+ACQgPUXqd/T+k41f+
 +RRslgcXMmyiNpi9Ita3WXjLZwI3epczXUfhxMpI62Udb/2ReJ0wrsidE
 5ZDveISGjLnRfC/su80P1xoaS4BOMtYuVE8202B5LSZVQgRM1LfS/WejB w==;
X-CSE-ConnectionGUID: JfQICvgRSiCP5nD+q1g8Cg==
X-CSE-MsgGUID: 0D7f4+4BSqGjvy0dZ0lAkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="615635"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="615635"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 06:21:41 -0700
X-CSE-ConnectionGUID: /ko9NeV1RhWMR7xV4LQnww==
X-CSE-MsgGUID: +HvN/8X9S1iNjzyeP/3mOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1136849"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 06:21:40 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 06:21:39 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 06:21:39 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.27) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 06:21:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wrRHF0fiRso8yN2snIomOX4e/eAV+g/f5/DD43px5kfAA4hz1F68IwK6xb4VUTfEXMfx1XsL7Ps/bwQNiHfNmPO9dk/tV1ER9C32c8l1YVP1ZRRXzKD03g+4Uu6FuTvNAEkMA+4KdP2Yd7CimLj9lXP+tnw0CEakjSA00k1UZ/oeKn1re5foHd7N+sbwOqDw/VSl1CiA2SWZFgOo7a3Q94Xv/TGyXHaJhoUFPsbfpW92A15ydGOiavXllWz87FYuXXQd+5CZUOnfQ7dD79ex1P4PXouL20DZ4e30uWXQHe50lFarxIuc5r5RuHqB4K5Ny/mAg4G0JyGyQTouQ0vywA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycyuxxTcno3fKGSe2OMH5ttGOqsb5Na4gOIUYQ+espY=;
 b=ePSQ9+In2ADD1wbf9J1zHa77NeGB5jspfrXPQ/sS1iBtZhxhjroCuv4qAbhR/EFHmsJsjktCQMhaFvhD5+bzO3RRgRmuHfPbzkeFu9JyfOQ1DpY1nisjDpyhhjRUo+svd6t0swOjbyOp3Xex9yhnz83cTnFbiuuEGN56K4TmjggnxuIktlZLxzQGxO/w+dTHj87+Fglx8TgdK4aAX0lkd00Pah6dEJupF2dPgsi+1MkvknBjBGD9JstWHhBTtxUAbIjYaZACLxqxiBNmvdKeG/RMdRSWyiGYaoHV/MrnCDRun/IKLkmJse6ed6tvJXgVLCv7QjzYbFM5kEq24jLcBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by PH8PR11MB8108.namprd11.prod.outlook.com (2603:10b6:510:257::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 13:21:35 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 13:21:35 +0000
Message-ID: <e79ead5e-3851-43fe-847c-10f368f206cb@intel.com>
Date: Tue, 13 Oct 2026 15:27:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 08/14] iavf: temporary rename of
 IAVF_MAX_REQ_QUEUES to IAVF_MAX_REQ_QUEUES_VCV1
To: <sashiko-reviews@lists.linux.dev>
CC: <intel-wired-lan@lists.osuosl.org>
References: <20261009121433.30347-1-przemyslaw.kitszel@intel.com>
 <20261009121433.30347-9-przemyslaw.kitszel@intel.com>
 <sashiko-outbox-166503@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-166503@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0023.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::19) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|PH8PR11MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 283231b6-f2fa-400c-1584-08df292ce78a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|261009223027099003|11063799006|4143699003|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: uA6Ze0E5N+KF3d2K6HdeGTqlkpn56PGwDv15cwnQeLKfY1YJ1Qo+Asl3wPe5m8vIaXN5ozQxwcOWb7SM7lhX2OcbjjYcgYdVAKJd4RKSZNzsBvXWAxJoA4oBFmcPrzI8TiFDmvSddzRvv2Q30Dk4XAqHZomuz0uBp+fcL2opCZtJkFHOX2mb4sUa/RKpD1zgSkJTzqygxtFYBWqPEOVU6jramV0WI1zRyStOT+e4EQOU0nd7vL831rlwJggg1Eur+ekr7cqLybIkLv2C7VNvtcJJxMPV/Nw3dDIFmBPGk8pc0g41qoQmbf40+ZBgwfoLPAL1hVJcNRGEfhByilZHxVmzuoyWT7hQq7TGdMyiyH6v5kyaW8ur547YrzBmGHXZ9v8E49fhiWKN5n6y8hOyC6pukXZc5WRM8bT7DUmPfoEdbmOJSLQWyTcoVDcz0T8OGP0C8Ijg1r7DbRApYkW/myZBQY+FuohZAfFIDkIRgSql1ExpuILEMk+lKZuCZfpINkxIBFRoQEgLoCClztCm72ooc8pbBCqqmqXvJ6k9b3r3MvdC66Y98TGGIaTBHdwVP3DdRBjG/cUJRKaysd8pRYKigIqRLQ8ZVmH3lcbzBiYxu+86sUxCNgtYpmeGnZfa9Bnt2lmDpYsL/tjj9iE2iNuA9ijZno0EWZkyQuDuYj0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(261009223027099003)(11063799006)(4143699003)(18002099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGdVNVBaRWpOT1N3VkZwWE9HdXdZUE8zdmFBaGxPei93MGlVTEpnOC9HQ2tt?=
 =?utf-8?B?VmJXTmhhN0U5RllGMzBYNG4ybGhmRnJHWUJBZDMrak53aWhucG1GUXZ0YjFL?=
 =?utf-8?B?NjBSNjduOTJmbE9velhpaEI1MEx5MWIyNDJ3UU1LclNUcFhwZVdkcWZUU2pO?=
 =?utf-8?B?dnFuM2FJLzJNdVRYS2NpNW83dEZkQjc0U0VpZnVLVDdQQXJGdTdvd0ZSdnVl?=
 =?utf-8?B?dUZxS1JxZlhKaktXdVE0bEJXSDRFR0xTZitGSlhRdUR0UE5TTTNObzlicFVk?=
 =?utf-8?B?cU9EMm9EOEp3aTYzczNBS1JUSVBVV01TbEtaVlNkblIvMUtXOVk3Ti9Va1ly?=
 =?utf-8?B?d2oxaDVUTHFuOTUxNVkwZjVDbEN3MDhoem12Tk5kb0kwUUExUHRUQW5VUThM?=
 =?utf-8?B?elZiUDNsbGk5Y2NtZnI4dDI4UnloUFRiY0YzeWN5MDE5OVBVTzVEWjByRG93?=
 =?utf-8?B?bVNhSW1NYUJvUmw3SUNIc3Z6QUdHVkZxRUhyeTRlSGJxN2p3WHNrcWN5N1h2?=
 =?utf-8?B?Y3RtekdOVzdQTFc3S2ZKZTQzallhcFZJY3F2VDIraFdpMXB1Mm45ZGNGK2Zk?=
 =?utf-8?B?WGN6a2lwQkI2cEhoTXRldTlXb295a3VzcGE3SWNIODhTOE9KYm5UNkZrT1N0?=
 =?utf-8?B?SFBOOGFnZVVCaUR4UGU3ajRmR0xETEJ3LzdaTEJZcVIwUXlRNmw2NUlyWjds?=
 =?utf-8?B?SStYRzkxUmdsVm81U2pBS1VmZ3p5cVMvNjRYdElsSTlUVG8waStCbFh4YmdV?=
 =?utf-8?B?UVFIZlYxKzFRbEUzZUVSWVg0NEp1Q3M5ZTdsZmgxQ1RIb0hjZUZzNTZsVEQx?=
 =?utf-8?B?NGl5S1NpSFBQMnFJM2lDS1RQM3MrR3JqeUlsNlBBNlRRYzczL0t2eTkwY3JX?=
 =?utf-8?B?ZUxmK1hKWjNPODlML0t5NTdQMmxnSTVVdzV0ci9DWHFNYmxOcXFJMllPS2ZI?=
 =?utf-8?B?VWVxbnBJQXpYM3JBNmlwYkpTdlZCOGZRUDFMY3pJVDVNaVBBTGFXdVQvL2xi?=
 =?utf-8?B?MlIvY2MrSk9rWkNQOFczUU5rMU9QOHorV01YSE5LU2Rma1U1N1NYT2NqVWlE?=
 =?utf-8?B?REVUOVF4NDdqOTZFYmZoUXBvN2I1Wmh2SWFkQjRhaysxNTA5UDl6Mjl6eFA2?=
 =?utf-8?B?QVZKaVBPVmRCdzljdFYwUDlQSjlzaTBZallpOXdGNHdJR3JML2ppc3VCeG1P?=
 =?utf-8?B?RU1NTkt3cUN3ZFJQTW5hQS9sUXg0VjY1bXdndis1WHpFbnNqVG1zSHZncjY5?=
 =?utf-8?B?NHE5RjVWbFlzcEF3OS9qa3B2UytsSWdxOTFRR2ZZYUhQRU9GSHlZVkZWUnlF?=
 =?utf-8?B?eE1VK1Y3N1hEQlBZZ2dMZU5xbTRxM3QvcFhldWRoK0lRRlJjRmhLVjh2RHA4?=
 =?utf-8?B?cWRvN0MrVzhmS3h4ck5GeUI0SUhsak1ROWRQMXVHMEk5VU1rMzh2ZzFPNUs4?=
 =?utf-8?B?Umtpb0ZpYXdzanNLV2pZOWpFOHowbk1xcmhSTU5IRmczWC9LMDRYZm5BRldy?=
 =?utf-8?B?ZmxuRWRFOTBxd0EwWEkwenFkM216Vk0rLytpSTJmQzlLV2RDVjZYdVErMlhS?=
 =?utf-8?B?R0JHZHN0Y0QvakR6K2JaWkxtVEtpdHp0VitjV29zOXM1TkkzRCtnbFBvUm5i?=
 =?utf-8?B?eEdES0h1djZyN2JlQWk1b00vQW5DRW1BMnIxOWQvT3R6Y2RaMTRIdFhWbHhQ?=
 =?utf-8?B?T0w0MnFleEhIT2lLWXpNQm1rMmY1NFZ0ZEZCNHIycFZycVBNdGQwalNCc1F3?=
 =?utf-8?B?WWIxNjVVaDh2Wm1vQU83Zm5Ud2IzdTRwSi9USWozd2xlWkNITldQUnlWeDBG?=
 =?utf-8?B?Vkl0ZkxlZGVKL0ZsT2l5MFlQNmxjRUhvYzNtYTAwMzFIcjNWckx6RXo1d1cy?=
 =?utf-8?B?VnJCT2krdnVyM2grUTZscUtFOHZiUkZCYUg0TnIvTVB5UnJvTWFJZ0N0N1Fy?=
 =?utf-8?B?MDlXTUFFTkpmVjRvMWgwamhZYzRJZktqR1hETzNwRGJmVlkwZ3pLNHN2R2V4?=
 =?utf-8?B?aUQyeDNmK3EyelMvaGxuOEZ1SGhJRTVieWNyN1ZoWkJJeVlGY0txQlk2UXJM?=
 =?utf-8?B?ZmVQa0ZoWnAxczg2RkFHQ1p3RUlFcHd5L2Z4SGo2anBWOFhrdGtOeW10b2Ir?=
 =?utf-8?B?ZEVZaWs2b1pOUk1xcDBXZWE0U3VMM3lnWUduWjFkOGt6TkdNMjFTd3ZlNmkx?=
 =?utf-8?B?QnpZRWwvUVlvdCtkWXJnSUtvQXVtQTF4aGFXWmVyZFhzOXBvM2pqc3BQOWpn?=
 =?utf-8?B?UEFyZmVwMWdZQTMrMGd4bEZpRmdzYkNDWWhHdExwcU4xTFRrdjdiYkVkVEM5?=
 =?utf-8?B?Rm04emhRaERiSHNpWkI2UHh3U0x1MDBFS1ViSjNkVk1JK0FNNjB1bzZkUnI5?=
 =?utf-8?Q?aQIhD+NT6bVZQML8=3D?=
X-Exchange-RoutingPolicyChecked: SnBjiVIe1Wz8Tq9xxrVbnKig2bcDXTyW9DG1d8D78igpxj+o502rdhKn0Vs7qXyVC90wc+bF9yZSh20e/8ZYyoUGOFXoKnfrpPKRI/ZAwE62JFz4QGKjZPA4NMIim+Xc4CPtK84JNk3Qk+4nVtPwukHGK9/2VQMek7ZAhJ1zq8+ZFR1wBathc0z7nq1nPvw+0xuLfL6Lk7E3c+wN9W9yqYmgL3eyUj4WHajFBMflnf9w6axCah0dvwhwlW8+H6fm1RAE7rLDUHsXLnTV8w8ZMWqvmpMADIN39sToKS5hQjCV9CzmtGkeMSCILGiDbbMhwfRke7J62vh3x58hqNhdLw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 283231b6-f2fa-400c-1584-08df292ce78a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 13:21:35.1521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cpg0wTKb52tJuz79psd7DwEdWr6w7kpjT8srDIzj9AXd+CXsNPGfxEwEF66tUsgBQE8U6drWLJJ0nchAd5u+UYQrVz8Rm7NphdKdi2rfhEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8108
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

On 10/10/26 2:16 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] net: iavf: missing bounds check on num_vsis causes out-of-bounds write
> --
> 
> commit 96fe4c02ff0c0cd29e48e38845a6fbbedd204284
> Author: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> iavf: temporary rename of IAVF_MAX_REQ_QUEUES to IAVF_MAX_REQ_QUEUES_VCV1
> 
> Rename IAVF_MAX_REQ_QUEUES to IAVF_MAX_REQ_QUEUES_VCV1, in preparation for
> the next patch that will extend the max to 256, using old value of 16 for
> the "v1" variant of virtchnl opcodes.
> 
>> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
>> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
>> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
>> @@ -268,19 +268,19 @@ int iavf_send_vf_ptp_caps_msg(struct iavf_adapter *adapter)
>>    **/
>>   static void iavf_validate_num_queues(struct iavf_adapter *adapter)
>>   {
>> -	if (adapter->vf_res->num_queue_pairs > IAVF_MAX_REQ_QUEUES) {
>> +	if (adapter->vf_res->num_queue_pairs > IAVF_MAX_REQ_QUEUES_VCV1) {
>>   		struct virtchnl_vsi_resource *vsi_res;
>>   		int i;
>>   
>>   		dev_info(&adapter->pdev->dev, "Received %d queues, but can only have a max of %d\n",
>>   			 adapter->vf_res->num_queue_pairs,
>> -			 IAVF_MAX_REQ_QUEUES);
>> +			 IAVF_MAX_REQ_QUEUES_VCV1);
>>   		dev_info(&adapter->pdev->dev, "Fixing by reducing queues to %d\n",
>> -			 IAVF_MAX_REQ_QUEUES);
>> -		adapter->vf_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES;
>> +			 IAVF_MAX_REQ_QUEUES_VCV1);
>> +		adapter->vf_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES_VCV1;
>>   		for (i = 0; i < adapter->vf_res->num_vsis; i++) {
>>   			vsi_res = &adapter->vf_res->vsi_res[i];
>> -			vsi_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES;
>> +			vsi_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES_VCV1;
> 
> [Severity: High]
> Can a maliciously large num_vsis value from the PF cause an out-of-bounds
> write here?
> 
> In iavf_get_vf_config(), the message from the PF is copied into
> adapter->vf_res without validating num_vsis against the allocation
> size:

this is both pre-existing and we should trust PF, will ignore
