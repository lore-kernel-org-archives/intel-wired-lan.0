Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D849CA5FCE
	for <intel-wired-lan@archiver.kernel.org>; Mon,  5 Oct 2026 19:48:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F1C0680C25;
	Mon,  5 Oct 2026 19:48:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J4d3yNA3ZFE3; Mon,  5 Oct 2026 19:48:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0513C80C10
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791229717;
	b=DLt+8Pj8VfGi+dis1yHSAENMIbNTsTjFHQ1TQ9QvfMKe4D3PsauAzjUD5u/0BEV896no
	 ZlfzYXVOVB9JRZHSJ8FkqYy+/NP1jl9gvOjWDxRLC6Qka+31l3aNV4NQNeVxaOkhThB8a
	 r1IuJQeBKbG+fXpvlfvnEpDupTksvjpkMixNo+pSoFha2A4cFBTT2rWe1F67HeyFoph8D
	 1hm8e+f4/hGYe/DnMpsxtgUEKy7r1qD6493fyQ5zaXUUhEudsjLLVEj0MdkHZl6I5nkg+
	 4ie1ckDkw4cBmHOCLtmXyJxL5uq0XE1vOLAM/2w4CyEp8GiKpXlF15p40q5FTM3akJQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791229717;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:CC:References:Content-Language:
	 From:Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
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
	bh=v51DvNo1gBI79DGePW2+ZaIiby2/yyPKVXtVHUCsBMI=;
	b=VQ3noT8Sm6yMyr6jQtFbdCjLTv3x0C5mYWkNY/00tQiV7ZMvbZxRzJzvXsCmnzXV/NEk
	 oz8+gudGGMB8/WVJ4EnBVI1RIq+bUIllgjBJuLUCh88fGgyY9J5BMnKm7KS5uqAD0QDok
	 1T2Oscf/A/yzT9A2Lskw8LeN0WIkby1pejyHIvjzD0NrA6rHCUES2Me4itFJkQnvBewCW
	 L5PP5fX4C4MReTeZ9TPpWD8lzSx9bp5/5idY/lthN/905VkiFntV/21gsTdLk/jDhvtrQ
	 /ulAKX9r2GFFHftf1sE5XI2MHmf2dtbzoKCoJv84CvVYAfH9lO76+5wRj/i2agzIMSg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791229717;
	bh=v51DvNo1gBI79DGePW2+ZaIiby2/yyPKVXtVHUCsBMI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=md/DBBFidj+O6iEoK0n+kTKjQI3ighYGFvyR9/NeeA7jmFOY0gQH0wbC9K8pT4Vmj
	 9AK8FTd4N2PIZFJp19zPIrAJGl4d3sKS726kdBmON8+L08WaXcacu2qDr0rxBACdLR
	 jbxL9Yce6iNMA3DtqGQ79tBtGD58MsYExwLcfZbxPysMw1AmAymL9EmzOA9sdhXiZ0
	 g00mz7s9iZzelrV8eZ2z3J5YGdjC6go/RnIeP+LB0ALxCOizPMx/yezHuuQLNpJO1p
	 9/87g5TWo9EGP8iSwO2KS1z4mN24fgOwTBML6eWc4q8PBwt0OhwETrn4F4tpNKeUNs
	 8T9r267LajvRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0513C80C10;
	Mon,  5 Oct 2026 19:48:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0270322B
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 19:46:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DBF774005A
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 19:46:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BwuB1XpooTx1 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  5 Oct 2026 19:46:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 930F940042
Authentication-Results: smtp2.osuosl.org; arc=fail smtp.remote-ip=198.175.65.12
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791229586;
 b=DAuU7KbZnP0OuuHwcIJpJscBN6zpMj4xI9lfFbkyXJ63PjJ5mz1jsYgbiDioH2/SQiEq
 Y9OCjqeuV2/eh9GacCi8UxmPdfeDiMO2ihCuQpAxFWmmGBuWnaK+zbZ9igMzhKa/0UQdO
 Wl8Yx03kW7TO/VlT7Sq+17sPc/wRk1SqOfvlErnW8kVQfWiQmxGi3CHUvIlDiX3FB6I+g
 nLvJve7yzkLXdlG1bFD6ISD/lmUF9ZWjFwejihCqTNFsr6SeWbu6xwLEWbl9sSZSZjuHB
 awpDz5yHI4aVxjZ7252Te2FXVcshtM6OGkUVo81nE98yZLI/XG7M9+iEWRUWAYKeLXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791229586;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
 References:Content-Language:From:Organization:In-Reply-To:
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
 bh=v51DvNo1gBI79DGePW2+ZaIiby2/yyPKVXtVHUCsBMI=;
 b=lC7C1Eq9AmYIPUpAkie+vgH3FqB3+Jfk2i52f/Px00Tp9gzFqOUwOsB2ccA//Ic1/dKo
 OWRZk/fG35bPruw8dGLhsbyqr7rZ0pNmzssxwf2t4z6wWaM0DH7krkZ6cFrcSlc0v8hIH
 vx30rHeTLPtu4VrhFNefOBPrd/u5o5WSmHE7BQjAaKjoqer6EY6SYEUTk95+jGv3Dbim0
 tUydsFH3s5uJoYaRD5PQTxrlu5nCrIt6mYMtxNVci2lJHdH+vU5kpq4uv+qi+qJJ5M6nx
 xrsnkXzegnavhy47eFCammrpISf6zC7lCKiDltow/mH/5ufYiuXw2OT3hpTM/djsW/Q==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="iJ6/tupm"; 
 arc=fail smtp.remote-ip=198.175.65.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=moriyax.kadosh@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=iJ6/tupm
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 930F940042
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 19:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791229585; x=1822765585;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rf9dFHeQ6/ZFCvdWHx5o6EgZalSlr1hcOXIr+OrlO6c=;
 b=iJ6/tupmhRn8d/OofeyJ64dRgijiqtG9tG7nm0oEflGrY4suFIPnfgFy
 TUn/mcXqneQpsQt6EhC2WV0h/ICpLOECGJcgs4lsEYqoKqNDdKrXTzDaH
 b+jqyuwDIaHmGxjirJDjZaOBT9KZ14pvgnbxDbq12gV0IalwyWBiNiM/4
 ND3TRT9pl3UtD9fPxNKL1XgD2QdXbtcW3UjGhEmDB984uocZq8WsWa7h6
 JxAE0tlw5YhRSbVPrOQjKWP2z54zGTrl5o/ehKcfY981DjlbUQTBaH/z2
 /FC53+M7DiDOkpeyQBbjICnsSrjSxceMIXdaqo2BKvwPtw2M4zSv676Ar A==;
X-CSE-ConnectionGUID: jH/X1SHaTf+wejoZwjLz+A==
X-CSE-MsgGUID: 2iZ5EizZRZG4rpniPqBLdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="102427748"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="102427748"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 12:46:21 -0700
X-CSE-ConnectionGUID: 7GvCgfEdTIuldYZ27baTuA==
X-CSE-MsgGUID: KVkrl6wcQfat0LlC5PRtFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="304848532"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 12:46:21 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 12:46:20 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 12:46:20 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.9) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 12:46:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWlVZM7+h6mnrF083gTwEr3vhyzBRgZOZPPeBzjkoR3cQfbH3ZalwZ4tpSHeLZ9fDRV8XCQEOSCgbAJVSYYLsfN4F4WAdrtaWEwIfUxm2q6F+kFJzcgxVbu9szeA204CmZU4Rfhvg1RZOG1/GDDZ4GxDRTbL8/EK2ANyQ2jOIgUaaNxwrBW1EefFYPygsm8whbcIoAdAZ0lpzukJqbQ3N+di5a3yZudtI/iAgXhgqsrytD46h6F/qA3QsGsiiTYryjqqWO+osjOIeS17ncOr4EufjNwnmumoWowywqTl/bn8FlEDrmURUb1/MftA/4soHWqc2bUEJP+FZDNzURqB+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v51DvNo1gBI79DGePW2+ZaIiby2/yyPKVXtVHUCsBMI=;
 b=W5+fDeo6+a0vDYjsfd/9iyxXyK880l4KWO8dWD6ZOGRsw01Qx7QTaQhyShPjRh0/x3UpfL01/H2Ixm48hnj8+acj8rEUwf/bcs48q5WYgkqSqsTF9jOeoN1BB7FBeLjgrGTVmNah0OeT2l+dR/pHr3AU1+IyDJe0aQMYSZDPgkzWdwFxAma03M5BijeXHSWSXqR+77BHpMn0IpSGCaRzGU9/f9CZogRn4XgqgDfpGTEyHTQTy+/Lufg9u9TP9fQFj3RRJagQ51n/ez/6+zTHS+d0cehcNf+Kpc3a3UX4ztO3JsTaaWMBnAVsRKTanYEUHn9aZfsqbEjC6nS6xpDB6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB4645.namprd11.prod.outlook.com (2603:10b6:208:269::20)
 by LV8PR11MB8486.namprd11.prod.outlook.com (2603:10b6:408:1e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Mon, 5 Oct
 2026 19:46:16 +0000
Received: from MN2PR11MB4645.namprd11.prod.outlook.com
 ([fe80::5cb4:804e:bfb4:dad0]) by MN2PR11MB4645.namprd11.prod.outlook.com
 ([fe80::5cb4:804e:bfb4:dad0%2]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 19:46:16 +0000
Message-ID: <03bb7fa6-beec-446d-989d-9067e83dd926@intel.com>
Date: Mon, 5 Oct 2026 22:46:10 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 2/2] e1000e: fix ps_pages DMA map error sentinel
To: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>, Matt Vollrath
 <tactii@gmail.com>, <intel-wired-lan@lists.osuosl.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <stable@vger.kernel.org>
References: <20260913171555.89537-1-tactii@gmail.com>
 <20260913171555.89537-3-tactii@gmail.com>
 <86add723-6e77-433b-83db-d186d98140ce@intel.com>
Content-Language: en-US
From: "Kadosh, MoriyaX" <moriyax.kadosh@intel.com>
Organization: Intel Israel (74) Limited
In-Reply-To: <86add723-6e77-433b-83db-d186d98140ce@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0023.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::12) To MN2PR11MB4645.namprd11.prod.outlook.com
 (2603:10b6:208:269::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB4645:EE_|LV8PR11MB8486:EE_
X-MS-Office365-Filtering-Correlation-Id: b28cec01-1e2e-435d-81ff-08df231951a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|6133799003|10067099003|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: ubJZPoISR1XH2D1a57P5OD/J/v0aCH3fJ6xKucJyI+Ut9rU/iM7G4pGKhwc2TBIbykAu87o70zv/Yd3eKq4TiiFEw7VJneYQlF61h7pjqXVNfPxvA9KgSUbtkj2QamkoqPkq8VJTmtHfBrHlLwPyc1ffpG0oNSj/8q/093dpn5JLhKgCJZS4mwImK636Sakvn/2Fc27saTH0zZXSlU+TVHEMBaTfAZGAxPUiehvOgab4VGBZ26gpHwtiHZ3Ggi2K8deND/KmvlqjxGE/HFfQHPLESqWvAsDPGKUJqLOcZo6Zfp2S50z5GtGYtltPE7AEz4mxltnB6tqC4qUWU+KCr6BHk+BZeS+cYUHJLLvcKYBpnrTmu9h5A2zBV4F1Lr140lDTWSdn/CKXUf7sdKk5ABgGnJybDAn0LphK3McjaC6w8ESfaq8y8kR4NNUw3LLyelb/c0VMWQCdLlrhPyuLOXaRQzttfX8ia8+0oABuWpZg6Z5gFixtxaYWikHlXNpitSgaNWXYPdElAPOK/rzqWUhv7i79+7ID3GZGBlT45Ob4Q8mLhzhrSd5HcNI/Tg0Ce2SbQOCjGHi7cLGVwRIJsILejFyMnG5N3QhOfNMV6zHeE8TSXGmzKzibnG/uMXFojDN97f9rQx7DA92W9iuMEIrV0t0XYeYM9iDqa4Q57v4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR11MB4645.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFhoYm15Qm9uK0VPcFIzdmdsLy85bHorWDdrY09uR211cmlqWVBEVDcrVC9Z?=
 =?utf-8?B?MWRDYjFSTnludm83Q0pvVnBBdHZLSjlVWE95UmwweG1jNlFWK2ZNNjg2ZFNT?=
 =?utf-8?B?TnZsVVZMeW5JV2pES0ZPV3NIWTFjNUYxclB2MnNvakU0ZFZMMzFJNmxCWmo1?=
 =?utf-8?B?a3R3TDVVRDRXWWsva3Rva0MxUTEweDRkS0dVRHdZRWFaTFkwNHJRNzYyM2M3?=
 =?utf-8?B?VzdBZTgrYUYzc1pGQm5BM2EveEkxM2pRNUVaVG9FVWF5bFovRXM5SVVDSCsy?=
 =?utf-8?B?RmE3UWs3NjR4TDY5QVp4UmNiR2VZZkZoU1NRdkNQR1YyT1hFNFpFbGQxZDRn?=
 =?utf-8?B?S2JQT1NnSCs2WXVqck8wWVh6azhOSWZia285aGQwMStUQVd4M01JOVpIMUlZ?=
 =?utf-8?B?SFFvTDlRSk0xL05ZcHRMWTdDZ01XNFBpMUVhVlp1UG43UTFGUmlGVk4wK2FJ?=
 =?utf-8?B?bHQ1UnhMamo2WEZnTHgvU0haTTluL1VlL2ZWdS9pRlY3NjljNXFPMG92NEhD?=
 =?utf-8?B?My8zTVhrY2tZWDNVUFdiR1RVMFRKQW01ODUwK0Zrek4zOFFjbWtoYXlkTkIw?=
 =?utf-8?B?eVZMajNTb0tkWWlLNkJ4WTU0dWxBM0VYMmpPVnhlVE0xR0FuTUcySXc5eDVj?=
 =?utf-8?B?YWRMQzUrcmZTTDZKVmd3d2FBOGFjZlNTZFRhVytmRzN3UDFEWXkxUGcweUtT?=
 =?utf-8?B?bWxKUVRyY05mNzJtbjVHTFM5ZDdhVWpZUGhCeFVrREZSdmJXQ1Vmd3FaOVFG?=
 =?utf-8?B?Zk85Vm12RVA3bmdZVktrVGpDSlVQWkhzY2JDTkRzVi9jMyt6cFpJWjgyVUpH?=
 =?utf-8?B?amZ5N0Z6VnZSWldhR283OG4xWWVjbkZsMk5JNkZTQStqaVhkcSsyck5Jekth?=
 =?utf-8?B?dm9CNnhZZmloc1lLa25OM2hVK05TOExiTFdLOEdLYkhmWm1keXc2Z0RQL0U0?=
 =?utf-8?B?dW5oa05ReGRHbzd4NGxhYjUzS1AvK2ZNMzV6cW53SVNhUis2Q2JwUnc4V3Y5?=
 =?utf-8?B?ZzRER3dwalpoVERGaVZidnc5dlAzblZQM2tJd2tOSGJMQi9GU3IxV2tsOHNP?=
 =?utf-8?B?WlZnemxEb2ZCRFhuMFhRYlBKVGtXYlVpeWlDUy9VK3l1WExBd2xPZWtCV3VV?=
 =?utf-8?B?amtDeWR6K3AzcmJaNnlEWU8wRWw0MFptOEZNdzh1c0N4WjMzOUVaK1lxYzZt?=
 =?utf-8?B?ZU12OFBHNFJNYy9zYllEcktKcFFqbXZNbW40b3FXRDlvR3RFNjBTMTRiWFRL?=
 =?utf-8?B?Z2tHMWNHekNCVTFFL2FVN1hwN3k5R0IrUEc4VUtXV0dEa2xhTzRRTm1nc0Qy?=
 =?utf-8?B?UnlpT0RBd1huRGdLSzFuL3c3TDVxaTVUTStYRkYyVnZRakNQMzJmcXFKeXo4?=
 =?utf-8?B?OFZyVmZPNjJHVDhBd1VGUUNPbkxyeWxGbVJFWmhHZHZVaTZMNU5JSjUrL2NI?=
 =?utf-8?B?ajlqZGo0eXQwL01zL3ZqS1Q3R1V0VytnTzRsQVBTbFZPY2x3Q0lVQWltRDE5?=
 =?utf-8?B?b1pxNGhrcHM3dmtnWUs0c3Z1SFQ4QmlIMVpBQVI1M3JCZWJkUDgrczVmOGNR?=
 =?utf-8?B?OWJsdEwwUzZyeDJ6OU5kRjNoUmx2elVjSnBlakF6dTUyTjFKVW1ISmlXUjZQ?=
 =?utf-8?B?Rkcxb01QQm9IM2hGMVphcjk0b21FRnk2Wmtta0NMeTJVRGs3UlBjaDJ0Tjgz?=
 =?utf-8?B?ZEVGTVVWTDZoMU1sRjQ1bTdpZExGR29oSThXRVJYQnBFUy9iVkpwUHN1WFdF?=
 =?utf-8?B?OVRuRHRqVmE4VEdzTklTdEIreVp1OS82MUo3KzN6MzU3RFlLc3J6dHg3dUpZ?=
 =?utf-8?B?QVJQVlpXL2NYY3RlYmxOclpqbWkvWU5lSE0xVDBzNzQwQm4yOFhYamFLblNV?=
 =?utf-8?B?bVlVSEFRZHgzZVJvK1pBcGRoRHEyWWxZV2hvOGNhM3pHV0w3VUtlV2sweHI2?=
 =?utf-8?B?V3E4UWU3MTJZVktJUnRzVmdUUjM2U0hOc3RLNExGWnpBRkVhUTJCcTg3SmUr?=
 =?utf-8?B?anJzWHp2NHJJejVxc0MxQnBrMSt2MUFLVnhjZVlFWTE5NXRyV0ZpV3QrekZ2?=
 =?utf-8?B?TDNTZDJOSjZKV0NKbGxKUjQ1SHpkNGZQcmg1bm5PVWhxdnJTeUlnb01LeWdG?=
 =?utf-8?B?NFJzVlI0ZlVRY3pNRHpkdHlZaFRwYVg0bFhZbXdOdDRiU1ZvNnBIT1dWUU5t?=
 =?utf-8?B?WHpIN1JpL1VLUHF3U0V3WXVDMURYaERYQlpqSWh3dUFWSkxDUi9SKy9CRDlV?=
 =?utf-8?B?SUhJWEtzck1yYlZxMmpSOFNLNWJYL040d1JQU1BhOXZFRXJ5WUx5YXpMcGEz?=
 =?utf-8?B?a2Q4aUdVenVwT2J4aFhCVWpCYTNVMk9pL3NibVBpcEF3UWlOUEd1dz09?=
X-Exchange-RoutingPolicyChecked: RbyokN8vZTyGF9gFsD2x3TtJZ0dMx4tbyOT1rBPwAVc3QRtlxwgzFsM/Z3SVf/qgQm5Y+7Tp3SCzadsnzcu1r5qA+TgYuJ+2gHqNUW659XpCx6gcFKnu0iU7755XFyT0ESEJBwXzU0txEFD/InM41b5rR2AfNXGq0ziuDQvvj7BENw/uXMDYCmU0lO1r4XefalEnf9rMGc9uI0nK7edzIldQtopCxnCzESJcclTIvIUSM1e20JT28/9vH+56kHqAkTcYNj60IhhLHl2+fJQzI+HZ8eDgtqFALqjQMz5ShGT9kU+RlGg+zZi6/OLk+vyICwMy8FBvSyeP0sQiRXE4Cw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b28cec01-1e2e-435d-81ff-08df231951a2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 19:46:16.2815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFak/gZ5KbCKTSXuQUFjwiln3NBvF0pe7euEB5lfaOALqd1uTF+gCSG52H67cB4v+Mrs0xuYF+AcZAMao6rmN4xf1DqqnH2YFSqO/EY3a7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8486
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



On 05/10/2026 21:11, Ruinskiy, Dima wrote:
> On 13/09/2026 20:15, Matt Vollrath wrote:
>> While allocating packet-split buffer pages, a failed DMA mapping would
>> leave DMA_MAPPING_ERROR in the ps_page->dma field.
>>
>> This would have two consequences:
>> * The next attempt to allocate that buffer would write DMA_MAPPING_ERROR
>>    to h/w if all pages are allocated. If the h/w uses that buffer and is
>>    handling a frame large enough to touch the affected page, it would
>>    cause a DMA fault and be dropped. The driver would then call
>>    dma_unmap_page() on DMA_MAPPING_ERROR and unknowingly send the
>>    uninitialized page up the stack as part of the frame payload.
>> * On ring teardown, dma_unmap_page() would be called on
>>    DMA_MAPPING_ERROR.
>>
>> This condition is only reachable when MTU > 1500 and PAGE_SIZE <= 16K.
>>
>> Fix this by setting ps_page->dma = 0 upon mapping failure and separately
>> testing ->page and ->dma during allocation and teardown.
>>
>> The rewrite of the ps_pages section of e1000_clean_rx_ring was necessary
>> to recognize the case of an allocated page without a valid DMA mapping.
>> It also fixes a separate bug which would potentially leak pages on ring
>> teardown. The cleaner stops cleaning pages when h/w reported that it did
>> not write to a page in the sequence, leaving the following pages
>> allocated and mapped. The teardown would then break early and leak the
>> unused mapped pages. If the ring is re-constructed by down/up with
>> similar configuration, it would reclaim those lost pages. This would
>> only affect configurations with rx_ps_pages >= 2 (MTU > PAGE_SIZE) and
>> the same condition of MTU > 1500 and PAGE_SIZE <= 16K.
>>
>> Signed-off-by: Matt Vollrath <tactii@gmail.com>
>> Assisted-by: Claude:claude-5-fable
>> Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver 
>> (currently for ICH9 devices only)")
>> Cc: stable@vger.kernel.org
>> ---
>> v2:
>> * Reword last paragraph of description.
>> ---
>>   drivers/net/ethernet/intel/e1000e/netdev.c | 19 ++++++++++++-------
>>   1 file changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ 
>> ethernet/intel/e1000e/netdev.c
>> index 26f45ee8c7e7..063fc8cd2673 100644
>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>> @@ -759,12 +759,15 @@ static void e1000_alloc_rx_buffers_ps(struct 
>> e1000_ring *rx_ring,
>>                       adapter->alloc_rx_buff_failed++;
>>                       goto no_buffers;
>>                   }
>> +            }
>> +            if (!ps_page->dma) {
>>                   ps_page->dma = dma_map_page(&pdev->dev,
>>                                   ps_page->page,
>>                                   0, PAGE_SIZE,
>>                                   DMA_FROM_DEVICE);
>>                   if (dma_mapping_error(&pdev->dev,
>>                                 ps_page->dma)) {
>> +                    ps_page->dma = 0;
>>                       dev_err(&adapter->pdev->dev,
>>                           "Rx DMA page map failed\n");
>>                       adapter->rx_dma_failed++;
>> @@ -1722,13 +1725,15 @@ static void e1000_clean_rx_ring(struct 
>> e1000_ring *rx_ring)
>>           for (j = 0; j < PS_PAGE_BUFFERS; j++) {
>>               ps_page = &buffer_info->ps_pages[j];
>> -            if (!ps_page->page)
>> -                break;
>> -            dma_unmap_page(&pdev->dev, ps_page->dma, PAGE_SIZE,
>> -                       DMA_FROM_DEVICE);
>> -            ps_page->dma = 0;
>> -            put_page(ps_page->page);
>> -            ps_page->page = NULL;
>> +            if (ps_page->dma) {
>> +                dma_unmap_page(&pdev->dev, ps_page->dma,
>> +                           PAGE_SIZE, DMA_FROM_DEVICE);
>> +                ps_page->dma = 0;
>> +            }
>> +            if (ps_page->page) {
>> +                put_page(ps_page->page);
>> +                ps_page->page = NULL;
>> +            }
>>           }
>>       }
> Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Tested-by: Moriya Kadosh <moriyax.kadosh@intel.com>
