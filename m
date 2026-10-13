Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB13CA9ED2
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Oct 2026 12:53:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E18E7403AE;
	Tue, 13 Oct 2026 12:53:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IuW9OBEUEQDl; Tue, 13 Oct 2026 12:53:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D1C35403CE
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791895989;
	b=hzUiXphmqf2e3VbkDXwy1rTy3slzFUBu+yhGT5EXzMR97JZRVitVk7Kbe6XsMQIIYHo4
	 m5GHoYkAiMYEG+HY92V3Sl9WoW5Y4Lk8c2gFeXheDPtuWVjJUDcbggJxJnIjT+OxBvAcl
	 sCRxXsYYaps9oituf4T5TfecrB6Z4UV3zQTncT3OFEIwVpIruLcEd0EEwdfXxcw4cnA5o
	 msUjEohUVKerLam0RwJ07w0Llo2B6Agswp1tdKo55U7fXklS2dKUQgtenTGH4v7HkN2O0
	 m3mWALSafbCYssKGE3Qd+xzAcdOhm7aaeHECzacjBf3nFHUB4dHi06DyNpVSb7WHJhg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791895989;
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
	bh=Mm+MH7FjeO32mZEX8EBNd5KyQ/ypoI83p98GTvO4QAU=;
	b=rLYXRHhcXFAR98E8TNloSB9ftI9EtMSov+MkgXnTNhYg1zGhIdTIPH+4qh1BJzD7lCig
	 VFOcv71bKZ4Gt0GRLsEDxPPq6UKBu5Xcr6nuiAihg4JJagOIxv1LDKERdIhtu3xdzfPuJ
	 mXnVGk/pwfqNzAscK4OpKiHauVAPvJDkC93PS7bhe658R4ka00MR9bnJWyM5VsJtoSyoK
	 waYZL4IFvYySEeEHwBKXznIbJnogSfTGKk/zX9s/5vu4g/K57h4zUwVc/QMP4kyYjBXTu
	 CUVkZjg9gv/2dlonFBFRBkqTN4TfCMNmmme2gqGvymQd38FH7yDpAIVdySKjWnaDc5w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791895989;
	bh=Mm+MH7FjeO32mZEX8EBNd5KyQ/ypoI83p98GTvO4QAU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oqIqUqdYkGoh0k+fdkOjGYKsUKy/VlGP+TI3yoMElvf9jqciYnyrwPHW/KGbu5v+z
	 Bb56/WhNPhFMvACRqZFqrSOU3Y7dTdrr3GM9MI2mWeDIAvRVGZ/MACV+CYGrnDKlHW
	 2VdRzwL0KOHMkoqmm5+VniSh9sbWgN/gAH5UZCA4Y9CIv0rSh8kfmUd0YWpQ224BCe
	 l/5IbonkW0vcuaW3QT/XneDPMZ5hd/2uc5b3V/AsVX2uebmakCUc556EqOQgNp25r+
	 U8BYo8q7/nhpBH5EMAfy/9mDY0eyUB3pSwxwvtfzy8xFLMHhwf/xNtK5m3DEgovHpw
	 BgKNqUOpnjLWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D1C35403CE;
	Tue, 13 Oct 2026 12:53:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 43E8B75
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 12:53:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 295CB605FD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 12:53:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1d-7cPKj4rn7 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Oct 2026 12:53:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0DDFB605F4
Authentication-Results: smtp3.osuosl.org;
 arc=fail smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791895987;
 b=THyvt7/G0a1t2uDTyXGtXZTMj8b7YwfMBRQWmW3whiksY9mdXnH7MApXhsrZeA7Qk2+T
 1Y3iKZ45QzuxUDJAXV4xVsxce2CjqWSoGtUBjju5NquV+mW40PFrGzSmV9UZT0pzdBdrH
 oQ4YanwRbYvrCg1+Rfo3a5ukwG0zepoXmJ/E41u0oDDRZf7gGta4YJbOZDFRHpOONIZpE
 Bf/bjgpWqoIoau1Pb/Ttz9RVerE/yygWtqptMC2a2lDcfK4wXa9sLOivCbRn68Fi2oONF
 MTFSZ1uDf72vF8Gtz0ZIHzNVC7d86q6AcaHgmEx9nFIKmxmNovmEn0W2AkjygCc7FKg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791895987;
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
 bh=Mm+MH7FjeO32mZEX8EBNd5KyQ/ypoI83p98GTvO4QAU=;
 b=lKAwc7JVEsyZx4vgFtf7ozx/e4DbQJV8WWF1Oy2WWbfrjz71Yre9Mi8eeJdtSTcwuiiG
 v+ZTvXl7AbebbTfbGFzekb6E/v9sbpLH+5jdxR2ALEZtv9IwvzcAnJE97Y760l3RXYqgz
 4oyxnBs4eojeNiPr6pItgke7YGesqt2dsiqi3g0pNnt8+rZjpos/fouho7T4in0BSfGAS
 HJ1NNHGLQPwsQWqNvEwDxfx3HeQjUlvGDagXMeSxfboXXec2TTaH08G3KHJg0fTGcvyLF
 10YzQ0Q22RnXGSnREw761M3s7hdRkSmA1G64FhRv3hZwNfNIiEetL5j3551G2LrHZew==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=iR0aGmpM; 
 arc=fail smtp.remote-ip=192.198.163.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=iR0aGmpM
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0DDFB605F4
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 12:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791895987; x=1823431987;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/aLbT23E/iCD1fYFrSNuvNjd3g03N8pAwHt0V2stpac=;
 b=iR0aGmpMoRF/cEEAxaSnDbwJVCJDaDgPBJSN2dl3x5Qy0+MdjS/SH+oK
 Oh2gDu0ZziOMriuO3mR5I+G3NQGdmzShLkemtVmGpd1umUMoyb0XgnmVR
 STnPBK0gqTLzdD9SJmovt9M7+rht+6nnX4YsP36oNZxF9HtsURIXt4LjJ
 DGqcIoGJ/hsES1WTTI2rfkulaD+XlR9hmVOFY/q7sqXHuZ8EfQJKeXlCg
 b2OVaTsu07BNIHlcmL74Ujo5YfidLw8Nl+xGdy3mBZlgEjfEWEYSYZUHD
 FlQniEj9f3QxhsEdx6ea6aG/xK8pSp7EvWkmanxeysgkHWIWsQTHZ/Shx g==;
X-CSE-ConnectionGUID: 4wZuGT1TTciPbRNeaC7o4w==
X-CSE-MsgGUID: Gr/P0oD0QDGfyc2wLgjW9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="721115"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="721115"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 05:53:05 -0700
X-CSE-ConnectionGUID: Zyn1DpR5QHeh3VpkHd4whw==
X-CSE-MsgGUID: YStc29k+SASHj3TPGxiYxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1481945"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 05:53:06 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 05:53:04 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 05:53:04 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.13) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 05:53:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HtmmwikOsD4Bsi43mhUX0s5dnaA53XUVNZy+hs5sdk/5FAcZopDIrNzAQ3ZfothygnvorbFGbANvuBz+p3FZTYw3ey7jpkxeQxlrfAb37JCkJQlaE8GNLc7JJYMx3GSqYq0POucA5FZLifB+uDF2Fo5qQXYlTQ+DpOoEs6ifBWm7Cl8ZLw5H2Ccww77YnIy4xS4ZhLlvQaizeTrlV3t3yKjZsamZzKQGTKsDp5qmhiLTiwrIfuiRmcxru7kUpDG/YS6zv+TtdQiP2C9uHKbpcsX/UfPNN6By/ZAKNbYFXQGkI/Qw7mkyc6zimd2U2MEVsL23ycjw5mAOa1IPM6RXrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mm+MH7FjeO32mZEX8EBNd5KyQ/ypoI83p98GTvO4QAU=;
 b=jWgc1n5i4Bs5tlflns3iNj0SSii+M3lcPcRbJll2NHy0AKmy+Gp3YguCcJjYt+A+qPvjB5E+D1/AnqGQ6vSucWYjKVJd9rnLIYCFVJGbO4yvHELW6bKb2s7L35j3TzljOlhXxhL3u3FhN70r065mn+eRb4fvApJMgkaNYvZRAjoZ8R6fVb9QK+YhoyPSHeehuJbQ/PvJBpfjYOJ7tIqnSCm3lF44g027o+wW7fIT61PG46Ci7tTpYQ/UnTQnQhc2yXovQaGTTPoY6P1vPHt7zF+OrVxq8EGpsg2UGeI0k5g62qQi+xM4W1bB5Wro96tEWrP2qP57rKBoLdux2drrpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by IA1PR11MB7889.namprd11.prod.outlook.com (2603:10b6:208:3fe::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.27; Tue, 13 Oct
 2026 12:52:56 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 12:52:56 +0000
Message-ID: <3680a279-d31f-49c3-91f5-cb7a62e38fe0@intel.com>
Date: Tue, 13 Oct 2026 14:57:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 02/14] ice: use shared devlink to store
 ice_adapters instead of custom xarray
To: <sashiko-reviews@lists.linux.dev>
CC: <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
 <anthony.l.nguyen@intel.com>
References: <20261009121433.30347-1-przemyslaw.kitszel@intel.com>
 <20261009121433.30347-3-przemyslaw.kitszel@intel.com>
 <sashiko-outbox-166496@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-166496@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0051.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:353::12) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|IA1PR11MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: 683823dc-0777-46d5-01cf-08df2928e6fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|6133799003|261009220027099003|10067099003|261009223027099003|22082099003|18002099003|261009223327099003|4143699003|56012099006|261009221727099003|261009221227099003|11063799006;
X-Microsoft-Antispam-Message-Info: F19UtZvexr/Fwl5jtBd6Gz5WldcHJ6fwTT7bZSoW60BM+7B+mlAHMzsiFL1GiDGNo/1evaNSeeuVO62CRcQUKSmbU9JWz84S6VIvBsNftfmYJCxsY/7BEXNMCpRq8lyZTjoK2Q2rh3R+VeWYZjwcbbQWp3V6QKUAzbcC3hKNsTSXcp4MWmLof77n1P9LCxLIy4II1TpfYI/hTMAueivqDnYkBlzhV8QwjcZfw//I91FWu4GEwXrlNap0+VFC1XutkZzyfnymgUyG7gmXPEtdqHAW2rFQcnoEyc21BU1q0Xe6BetwjPAIfgcWD5ZW7gGRClC4uJjLqUTxhMqpww4BB7K0boYAq+Z9B93M2xoq5CF5pJdzzw0Pxu9uufg3Exn1GAjncNwN1nudfVxsIuMclP3JTsUs5RltwF8m4OWyeCpWwqvO+lOEWHJdNatyq7hF4RaQiunrzXEUazgZ4EvAyzHteqEe3c1i7E6pHYxyEBRbIgurVgvHTSvJyK8oY0ApQynMuHAn3xv4gjg3trEmqLXgpJzeN8JIyRl2YTe/4mzm3kd9YgjEGoxej36MGSxlb0TaQg5Faflt320EohVezjPgG0M+KgN26iewaNBbr+1hGeA37qe6ePaqzSjm1vAL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(261009220027099003)(10067099003)(261009223027099003)(22082099003)(18002099003)(261009223327099003)(4143699003)(56012099006)(261009221727099003)(261009221227099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTVwMUpMVUlGWUdvRjY4UE1zTGRPaXNwaThaWVBXMElxd1JTRzVYVjFVR2dr?=
 =?utf-8?B?dTVxQ3laOUtkbnViVWpVVENrQjJtMS9PQ0o3RW1wbW4xVTJWSXNrNmZWbUhE?=
 =?utf-8?B?RXVNemRycnFwaVEzK1ZJM0hMbURQeHVPWDR4R3locG1TZFVXMXpMam92Mnlx?=
 =?utf-8?B?bEFrdXIvTUFuWmQxMENxRkpQUUFRRUpvWE9jdEROSE9UalRndjVVWGp2S0tF?=
 =?utf-8?B?amJoMmcwUWxwR01lbUJpZHpraHJaMHZMaXZ2YzBnVHprNjFxdnNueFNWUWQw?=
 =?utf-8?B?cy9WeEM0SGcwOWFVOGdGdkNYSXQrVGxESFd1VmZEZSs0RXBTY29zckR5Mk0w?=
 =?utf-8?B?SElhaFk3WDNkUVRIcGh1bUxFSnRYaXpNQWs3UWJlRFlabXEwbDl2emNJMk15?=
 =?utf-8?B?Y0Y4MGNEc2dnYTQxVGNZL2NMSklpQVdDQ3N6MVZndkdCNm8vMkRTNDVpcEVx?=
 =?utf-8?B?Zkg3OE94Yy9LODBQWkFKUGVFeml3ZzFPNU1rUVBoUEUzYTFPYnNsR2RhaE1F?=
 =?utf-8?B?RHBnRHZUd0dqVEpSVmxBUi9tZWRTRlM4bXBvWDVDMlhIYWl4cVZNZjRMTnJu?=
 =?utf-8?B?czdubVE2cC92T0dWZDBITG9KMTdURjhLY0VCUXhVcDBCYVFJZHlmREp1ZERT?=
 =?utf-8?B?Rk9RdmNXN1o2R2ZNdS9aZVRBUmNsdWlFNlFzZm9Qbm9KekUvc0dmSzYvbm5q?=
 =?utf-8?B?RjE2d1I2cmNCdzBBTkNsY1I5OWZrTDczbG5BeURMaHNIa014ZE9BWGtaOTh2?=
 =?utf-8?B?S0dRUGt2SFhzUEFIL3REdmNtZDNHVlVYZ2t1VUNibnlrMm52K2RYNlZ1RFBT?=
 =?utf-8?B?eksvWU1qS2hjbllxSTlmdlhac25CaEQ4c3VVRk90Mnp2QTViaGJGY0ovNG5H?=
 =?utf-8?B?a1lYYUJZK1NmMW1OUXhVRDRtbUw3WEx4Ti9wYS9HM2t4ZHJiUGlTN3hLdXR6?=
 =?utf-8?B?aUJ6ZUNZY1NNNzcrZG83RmQwRUJERmlYc1lGb3Z0dC96aVhLNkoyTGZUL0FZ?=
 =?utf-8?B?MHdMbytDOTBVRUg4eVZGODhnZnJOZlUxWTQ4blJtNDNudjdOZjJBYVMwak5o?=
 =?utf-8?B?TDNXbmMzT2NUbmVsTkxseVY0RGw2UnF2NjBBOTRhNXRZMC9KTlJlWUJyTTlM?=
 =?utf-8?B?RjdIeTVvWXJFM0ZBanNpa0hienhNNHN0S1dUUm9UN0syb3ZqNFcrL25zVnBR?=
 =?utf-8?B?aTFaSzF3amlZQWl4cituY3ZOOUtROU9tRlkvTDlicnFtUlJKeFlWRThmQ2JT?=
 =?utf-8?B?c3pVcGQ0UFlIQ1BCdG4wc2Y2aVFHODBjS1RRZ1ZKS0N3SmlWdTNSVUFxZVZk?=
 =?utf-8?B?R3V3MFRxY3llMWo2L2UzTGFBTFJFWVdCNjBCQWgvL0pmcFRLbHR6UFVPWkM5?=
 =?utf-8?B?SXRtd1h6QzI4V1BUQXova0ZVaTNkSE5IQUd5bjFzQlFYMHFmdEwyRGhVblg4?=
 =?utf-8?B?V2tYYnVBQVV5QWwzUlkzdGI5NVEwV1VQaDBCNkJOZWtxTitCcTJhenBuOU0z?=
 =?utf-8?B?NGg0OGhOR3IxRmV4RlJqbUQxWlhEamNFUERnWkxGM0RnZFZ5cUR6Mk1SODBC?=
 =?utf-8?B?KzcrYVlBZHo4aTQ1UG1nOHd3R2ZESEMrSy9hb0c2KytXRTNKbkdwQkJxQ1hV?=
 =?utf-8?B?S1M5aWNyNlVyaCtXNXNWZ3hrL3h6S0N4R0YyVmhldUpOcW9aZllpRUZtSmZq?=
 =?utf-8?B?RGppSCtaTWZmbG9YYy9HNFhVeXNETnZGaXJNbjc3aHFlZGhjUE1xbGFORUs0?=
 =?utf-8?B?TEN0Y2NYcUovdTJxcnZBRDdSbzkyazRrVngwQXBhV2JaNUJ0anFKeGhVM0xa?=
 =?utf-8?B?eklzTnVhVlZZamp6VlYzOXZRR1drdDBnR3p1Z3BsUmVvM2c3RGYxSStCVzFC?=
 =?utf-8?B?d3pXVDN0RGM1R0xNdjczOWZFeHdtSmpVN09KYUsvR3NwbVNpMFMvdXZZdmZ3?=
 =?utf-8?B?V0NscGQrK0FaRU1HVEdQcmZGeThCakw4NTZJaFFIdUN3bXkvMFVQZ1NlQWNw?=
 =?utf-8?B?bkwxK0s5N2N3bXAzTVVLbEJndmpSSDl4aGYyUWRKOUwzVk9sL2Q1d0FUSTVG?=
 =?utf-8?B?VTA3SFY0TkxDSzVGTmE0VzFZR0lYVTJNMXhQTGdoVS84NDJuSC9zcGtsUEls?=
 =?utf-8?B?c29iVmVNUjVxS3AyLyt1WkVRclJwTnhwZUJYZ2FydEluUEhCS2F6NFdPRklo?=
 =?utf-8?B?UkErbnFBU01ORU96bnZjcFZFUXZlNjZQaWNldkRBeXY5NmU1eTc2clJPNzVt?=
 =?utf-8?B?RUhqYlJmRFpwSDQvR28vQXlHQ2ZIc3k1cDFrckcvd2hCK1hqUGxuRVA2UXBp?=
 =?utf-8?B?UUpBM0ZuNmxGaVUyUEc5aE1uS0FzWTdzNkV5ZDJ4OU9KUlBHd0VGNU5WRFVW?=
 =?utf-8?Q?R/ynOw6UJOusFfR0=3D?=
X-Exchange-RoutingPolicyChecked: ef4N8xV8DZoj3W1pQbvcM9wcJYRhZxXqU74f6xvHVGNgN7zz4sLBICmCiS5L1L0rsOM+ZyDtFpfBssXwEWne8KMnhaay2WNcMWYYfJsDiD9Uyt0Y66Tzu5w0C+27QRcQQFH8UNralN23Np/LmFN3jF8ZpfoiMOaq4WyiebhcpCuDcW8YJeYKcMnAa7UgBOR+KLAelhB+oVxDaXjQotHcHpDadvIIcdItMWG6dX43FxAldFbStS3NMG16WdO8LS6pumf5ZSqtL5iD3JVZSRnl2i6PQrfz3dfAIY+1hhMsEkC+qkLXbAnTiquLgwejlDjUpttlXhgVY57uNv/ho599ng==
X-MS-Exchange-CrossTenant-Network-Message-Id: 683823dc-0777-46d5-01cf-08df2928e6fe
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 12:52:56.3398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m9FEuRPFzzh2ktvtJY/+Nbi4o40IbnYGSap1Bfmt2gEB1CGjQy4g6oIlDuVTs+0QALsiQXA2aco/1D21YBXsaA9JzyNLHrN3gMKPpypD18s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7889
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
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] ice: DMA UAF due to missing control queue teardown in recovery mode
> - [High] ice: NULL pointer deref in ice_adapter_put() on recovery mode teardown

both pre-existing, will make separate -net submissions for them

> --
> 
> commit 298f011950fb287bfb913324af33c969b5683c8d
> Author: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Subject: ice: use shared devlink to store ice_adapters instead of custom xarray
> 
> This commit refactors the storage and deduplication logic for ice_adapters
> by moving it to a shared devlink instance. It replaces the custom xarray
> implementation with nested devlink instances for PF devices.
> 
> Link: https://lore.kernel.org/all/20260312100407.551173-1-jiri@resnulli.us
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>> index 454fba07d4ecc..6373cd5ac2884 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> 
> [ ... ]
> 
>> @@ -4946,7 +4946,12 @@ static int ice_init_devlink(struct ice_pf *pf)
>>   		return err;
>>   
>>   	ice_devlink_init_regions(pf);
>> -	ice_devlink_register(pf);
>> +	err = ice_devlink_register(pf);
>> +	if (err) {
>> +		ice_devlink_destroy_regions(pf);
>> +		ice_devlink_unregister_params(pf);
>> +		return err;
>> +	}
> 
> [Severity: High]
> Can this new error path lead to a DMA use-after-free regression in recovery
> mode?
> 
> In ice_probe_recovery_mode(), the hardware control queues are created via
> ice_create_all_ctrlq(), which allocates DMA memory using devres. If
> ice_init_devlink() fails and returns an error here, the function exits
> without calling ice_destroy_all_ctrlq().
> 
> The devres framework will unmap and free the DMA memory upon probe failure,
> but the hardware ATQ/ARQ registers might still point to those freed
> physical addresses since the queues were never gracefully disabled. Could
> this allow the active device to continue performing DMA operations on freed
> memory?

The new error path cannot be reached in recovery mode. In that mode 
pf->adapter is NULL, so ice_devlink_register() skips 
devl_nested_devlink_set() and always returns 0.

The missing ice_destroy_all_ctrlq() is a pre-existing issue that this 
series does not change:

ice_init_devlink() could already fail in recovery mode via 
ice_devlink_register_params().
The recovery-mode branch of ice_remove() doesn't destroy the control 
queues either; only ice_deinit_hw() does.
I will address this in a separate fix for -net rather than in this series.


> 
> [ ... ]
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
>> index 2dc3629d6d0f6..c6301341ccaef 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_adapter.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
> 
> [ ... ]
> 
>> @@ -93,59 +80,37 @@ static void ice_adapter_free(struct ice_adapter *adapter)
> 
> [ ... ]
> 
>> -void ice_adapter_put(struct pci_dev *pdev)
>> +void ice_adapter_put(struct ice_adapter *adapter)
>>   {
>> -	struct ice_adapter *adapter;
>> -	unsigned long index;
>> -
>> -	index = ice_adapter_xa_index(pdev);
>> -	scoped_guard(mutex, &ice_adapters_mutex) {
>> -		adapter = xa_load(&ice_adapters, index);
>> -		if (WARN_ON(!adapter))
>> -			return;
>> -		if (!refcount_dec_and_test(&adapter->refcount))
>> -			return;
>> -
>> -		WARN_ON(xa_erase(&ice_adapters, index) != adapter);
>> -	}
>> -	ice_adapter_free(adapter);
>> +	devlink_shd_put(adapter->devlink);
>>   }
> 
> [Severity: High]
> Will this trigger a NULL pointer dereference regression if the driver is
> probed in recovery mode?
> 
> If the driver probes in recovery mode, pf->adapter is never allocated and
> remains NULL. During ice_remove(), the code checks
> ice_is_recovery_mode(&pf->hw) to determine if it should perform a
> recovery-mode early return or a full teardown.
> 
> Since ice_is_recovery_mode() reads a live volatile hardware register, if
> the firmware clears this bit after probe, the check bypasses the early
> return and falls through to normal teardown:
> 
> drivers/net/ethernet/intel/ice/ice_main.c:ice_remove() {
>      ...
>      ice_adapter_put(pf->adapter);
>      ice_deinit_hw(&pf->hw);
>      ...
> }
> 
> The previous xarray lookup safely returned early on NULL, but the new code
> unconditionally dereferences adapter->devlink. Will this crash on driver
> unload or device unbind when transitioning out of recovery mode?
> 

This is pre-existing, not a regression of this patch. If GL_MNG_FWSM 
changes after a recovery-mode probe, ice_remove() goes down the full 
teardown path for a PF that was never fully initialized. It crashes 
before reaching ice_adapter_put(): ice_unload() calls 
ice_tc_indir_block_unregister() with a NULL main VSI and dereferences 
vsi->netdev.

The proper fix is to remember at probe time that the PF is in recovery 
mode, and check that in ice_remove() instead of reading the register 
again. A NULL check in ice_adapter_put() would only hide one of the 
symptoms. I will send that as a separate fix for -net.


