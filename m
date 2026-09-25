Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD717C9830E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 17:32:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C1A9605B7;
	Fri, 25 Sep 2026 17:32:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vn04U3P3Yocn; Fri, 25 Sep 2026 17:32:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 80ACA606BB
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790357557;
	b=KwKSf6+PhQ7oAJEKG/eTs7hS7MMfIWNIQmfwfLWO/aewXoXHyqb4k/OulERPrhXCBgCq
	 ULj157lkmIdtaVq049gtH6cQMgqTnhEKVDnPcwnG5KUDNETKdGjShu7iHQvMrEkTPvFFX
	 Rg5U4/nWu3+pEzRMQ8eDwmlO+m8cGM4xX8x2g9eU0G/rcuU3Q+qADCizdoU9Z50QnAbjD
	 BsfoRv0tJYDu4bFdrLtZtm2AP2moVEwLyUR3sueveGgTle5iSoBz5AurZ5UNmHWWHDmwv
	 f5y6Ao9nIj0ka0vcDMsUto2AlEdERDVzoMrwLy6i1sUiBE2CUcoizzKlFeX9ySgg6hA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790357557;
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
	bh=8sxC0I5IZkwgSypWHdA6FFR4Pd+6VRQz+QIyyO7oRT8=;
	b=qrY9MyOuVyfTQumFwdF9LJt1RhvmcQHRuB12wtc2RmjtUbIAi7HAsr98TMfoSqay5Fo0
	 nQlZ+aRf99XDBcUCyRL+AgVRK01hkjRuG4RDpEq7pGtaejY1VK+yx2qcB+Qsht7qLzsBR
	 nnT0GW/Q9gZ/eVR8UxGZ0Q7Gvcvagy/ObbG6v3r8Tl+DytcIODq3DZzZy2rwcx+JdxOvb
	 xXKpp4g7kuxYIM22eardSQAdcYljdEbg/tsSyoPsaideFV0MFFX8crwDIPskDFYIBK8pK
	 2Qjru9m4mrmvSvfrL3S36I2L6zpSiVco7wcfOIrVh1Okl+mNLlW4kzetwoKa85R2YIg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790357557;
	bh=8sxC0I5IZkwgSypWHdA6FFR4Pd+6VRQz+QIyyO7oRT8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T0rTD7hvEk5JooVryVJh947oBZpLvnAHyZgc1Kp7epkULmriGyZk/4TdunZiuhP2o
	 iQJvYh2xCyBMfoI6x2jnSmsbdDrynj/CuhBa5GtVemrEKz2vzTmzTZDH09NH7EwuK+
	 WLd35xj2S56sJoiZmxKMyedCxsmPnfMIu3C7ZYYHA2uTueCTq8M2Xg6gJr1WIWfPli
	 7xEHPLMS9DidjyU45XYmAwp73OEMhHbCVP0xk2dQJoYs7k4adU6SXm5R98xkOXDxxo
	 kO90LYBWJL90ydRLR8JbfFr4FUAcnl9jgcZ2L9xZdMDVDFTds3SAJt3QnStq6uaf5p
	 WewiVfS1IqJAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80ACA606BB;
	Fri, 25 Sep 2026 17:32:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3AC76355
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 17:32:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2C8C24055A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 17:32:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lP76APpqCjwW for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 17:32:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BE4DC40555
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=192.198.163.8
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790357555;
 b=DyEXrX0MgRhUpnXQQOTZfxsfCtnKE2nxn8cFHjvWCkbgKFZL1tNReLCFvGsx+W7Q+m6L
 0mYKIb6nFFK42eHSBp4UZvRroXB6PIQ0JrRF3fA1uanv995v1Ss/bS1Jknr5FbYIu4gX+
 tZ8JR+Wa+UtWpw5EL7bgnzYojAn4g0amFlCPMTAn/gAfKR7o1I2iBlk/ZzyRml5yPmHlb
 Md0HIbNpgC53UMCwN8F4VaN8GpfGUi1E4LyMsWuoR52PBsxNZiHh636lBdB6vguxG3LmC
 4N9uhl/quCXnAUWa/P2C2zT9Sg4g6VkrFM/3yV4IX+RrkvfcbbXAENxa2BbdLyNCiPA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790357555;
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
 bh=8sxC0I5IZkwgSypWHdA6FFR4Pd+6VRQz+QIyyO7oRT8=;
 b=ixJyb9BWAPeHa5V094cNknK15L35fxBH0qSW+M28pRipAANKvGlRzGsGWHP7qXdRJ3rN
 cFHCI3HnuENV2cj+88dEsLx8sEIW+MSXz9mEjyZ4WVDHTbwBd0D/ct2PlTEkrFtPrTAEK
 UdW6YFizy/iIkjM3ddYNi24t+tbYCXGUWlDKvpoT1QCBfijYR6LVeVWGC5WnTFlA8PmKi
 mQCvYvhJ70MW99lXfAtBsPrGuPgqRTtNOgSnrLhfiVODEFGJz6v+ONBag1Olefhxajryp
 htLj+z57YI3w4KvIr+zdaPlkE0ZpwL29OCzCougAiDaVTqBwSuz1ZpP2aArGWAK0ALA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=JpEL4T6n; 
 arc=fail smtp.remote-ip=192.198.163.8
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=anthony.l.nguyen@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=JpEL4T6n
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BE4DC40555
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 17:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790357555; x=1821893555;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BFymEz5hAHdBfReaqPWq5Pktsft+W9YYu6t4UPDOwf0=;
 b=JpEL4T6naKXatH+OmQkudThxJAkb+S6VINctK9EG4Hy8AgW66tE41eLd
 zFWEaaQa+pyiaR2uosQ7U3uIg/1qZ2RuBx6gCckCnNyBkmpmO3Vs8PMWj
 uNll2N+G+z3onyxNnicTejF6TYgFcuqkS7Bgg5j7zM0AhquSlRtdmS6FS
 NYF9osnIglkVgrZMpHsMaOhvy8J59fkfCUiip9PWVRqIlWeBOLozZNfUi
 LlYHCZzie8hYG3vGXLBFbHbnOufv/XhwYVZpKvvsi2LmhuBOpQXdG2+kK
 VgEQcJFBOBFzIh7xEeRf4rWUuNBXuxiBQhKbDYxpx5KlKy0FggPbFvn79 A==;
X-CSE-ConnectionGUID: jjflKJpsQemUm2/Ly/qzAQ==
X-CSE-MsgGUID: ZG9a0CSSRruOrlf0NzgXRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="108640211"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="108640211"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 10:32:34 -0700
X-CSE-ConnectionGUID: 9tUKmxa8QFWCjg1b5ybJ/A==
X-CSE-MsgGUID: xr4Ly3XKS+Sqv6x4TSIlhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="273899793"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 10:32:33 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 10:32:33 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 10:32:33 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.14)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 10:32:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qehRdD5BpzT0bdNKUHtGiAQVWKZsOutRoJ+kdsMTIJHFqded8IPEQcOdVfkztLJl0n8MZK96hn0gvdphTtZ48IqEOUKmVnk489l7vMhlKhdPPLxCBym1WvUrHwQiJhEm+nyWf2nyLVvIFQQlpD4AX3o02zH0Ll90fXURA1zwSn63vEhgQANFLrZnrqjRI7DgsReYmsMJ/JMfRIFHvCnDut7EuHMX6JPLCh13Eh83N6S8NdAhzJuW3othrYz0v0suqcb4zlYlAfew6A3GgeESaw5N1U1m8QdPT43ykNNvdGH1px9A9NhWtw8UoFKp0xwt15r295NhuRt1gN4NsXGHXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sxC0I5IZkwgSypWHdA6FFR4Pd+6VRQz+QIyyO7oRT8=;
 b=D7762QDVRymVhYm6t9mg+ZzfxzEE0E0B3+2l4Qu70PqsI9Hwa077Fw/LV+/5TgarIsD5bsahujhK8pLKixh8PN9SLSYM+oqJLHW+uKm0PVasKXPU2I8hPIdGY/pVbF4JCVBcFHoaSV1vIs4e+bIH1V3vrnftxN6QLeUog6QamkozoYzsBubAleSU3Eql65UF1bYMbVhqroSXo31M5Dq2n18SixuIrwTdLpxw0fbL+QwKgLzsjnOSU/8jKMoKCtTUCXvyLSPnafR1zeAS3F1RyesrrTVdt16FEViglrRiHPdaN/msSK7MJm2uRXvZSFRS9wRdhaSdriQTpruuUj1lDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by CH0PR11MB8088.namprd11.prod.outlook.com (2603:10b6:610:184::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Fri, 25 Sep
 2026 17:32:31 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%5]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 17:32:30 +0000
Message-ID: <6a65b0b5-165b-4b79-a5df-0032b2260f2e@intel.com>
Date: Fri, 25 Sep 2026 10:32:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] e1000e: heavy packet loss on Lenovo ThinkPad P14s
 Gen 5 (I219-LM, Meteor Lake) after K1 re-enable; fixed by disable-k1
To: Thorsten Leemhuis <regressions@leemhuis.info>, <dima.ruinskiy@intel.com>, 
 <przemyslaw.kitszel@intel.com>
CC: Javier Herrera <javier.herrera@afronta.com>, <vitaly.lifshits@intel.com>, 
 <netdev@vger.kernel.org>, <regressions@lists.linux.dev>,
 <intel-wired-lan@lists.osuosl.org>
References: <CAKRuCQLWEcci9hPgNUmvq44Bd2H30T5_vP=exMjsknXMN5Yh9A@mail.gmail.com>
 <4f37f217-fb94-4d4b-a2aa-9df8069c62bb@leemhuis.info>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <4f37f217-fb94-4d4b-a2aa-9df8069c62bb@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:303:8c::7) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|CH0PR11MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d51398b-aef1-46f6-4c6d-08df1b2af9e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|4143699003|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: CEY99mslEH/gNr0gJg4P/8bLcrnoXhT0yfCItldve22DZdA6l28zvjZztwtjjro+wJhFZHBJxICWJKlq5c5v5WWWFOeUGJflkSkXl9zfyKwzqIJFC8lFaIGEEzSuJeFUnX2L+4LLdXutp5daXCH74FMixkXpCbI103bUV/tqMb1SREopRqhgmYPE3U7tEw7vPU63uEO44L6tCAt0qllPTfjiwBXY8q1/ExTMC875DadZczqtVQz+VOukm5F0S7W6O5ENGts3ksFWeJDQx9Lp3nUnef31TE2S+kncLjD4QX3uj49QaGkOHSR2Z4XNQvD6ortap/6lOFOCuqLTzsgcsCz5mx2CJeMXu7uj2QPFkAwn0WlO/XGCNsyJtewHu1ljmenoT/ngvBcrdh/bwhkPirQs61xsPcSYdK5emANf/k027TX3hQ5TZKkAAMb6Am3JD5Dy9DsR/KembQLIDyO8suM9V9xMlJkNR9Y4osvB54jv/7GF3j0r95Ptr32tQTd+XRGUJUbYOwgNzv62sv1W44fRskxRTQSE1RtPcC4LhtfFXpF+iDEKScOk6xxqm6jQql2F+K70Py/WeIHtuuOfyb6hZoBlmdJ52XcmgfPR1eBmoGXUrg086mJYYKKcxmGwqvFJorQkbHu/9TzI7ap/Wgt/Wc0hChR/DLYyGA0zcwQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8230.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(4143699003)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDg1cXl3M3paN3VaOWNlcC8wVXMxU1lCM0dHTFhKcFRMbTVvcXlTMGJCYnJF?=
 =?utf-8?B?UWhySzVXcTJya3U4ejRWUlFyVmpJNDRmRTYwanYrdW1JdW5qSHlERjhvVnZI?=
 =?utf-8?B?N3pmejFieVdydjNSVnFPRHYxckpPWUZ5b1l0Q0VxanNmVTNNYWEzRTJpaWNu?=
 =?utf-8?B?T2ljQnRyMGZzaDVTLy9kQnF0VWp4bHVoeWtlM2lHSEhtR0R6RVhlUWxZTnZj?=
 =?utf-8?B?K0c4MDVYbk5wVC9SNjlhWkphSDhycnJTYkoxREFLRUVaZVU2NWc1QWh2L0NN?=
 =?utf-8?B?Z3VIT3BwUVR6OW1wYVUyaUphUG1PeFBmb3htNGkwSTQrVEh0Z0pkOWtiWnA5?=
 =?utf-8?B?ZmlUTXZEdEwxSk1TTkpMaHVwUWczYjltUnpGUW90clpUb0FNR0plUTMrU1A4?=
 =?utf-8?B?SGcvWFQ0V3NJODBBNE82VDVOSXdRVVpsazYrb2NpRllJdE1qVndNUzRPN2tS?=
 =?utf-8?B?c3JWOW4xS3RuUncxcjE0UlUreUwxM053UVpuTm53NDhjZ2d2YzBBM3V4dDkw?=
 =?utf-8?B?bE9UL256Y245WENHMUZCaVl6bTBBeGhSaEY5THVDVXZDc21uZzM4KytUTk5v?=
 =?utf-8?B?MlVnUituZ1JXUUlzRGlteTFvbnZwY2hGQ3JOV0doeCtSN1Y0VlBla3ZWU3lL?=
 =?utf-8?B?bXk4dytGSTNRdFpYcE1ycTduY29uL0c2Ry9mTWNsTytwUWU2ZVFiOVJacDBL?=
 =?utf-8?B?bmhaZENuNHZ2cXlpTkxjMzJHUEZiU2dvQWlOR1hnM1oxZStLd3JsOXpWUDZq?=
 =?utf-8?B?b0s0MVM3RlUvYnk3Qkc3c0ppUzExRUtEb1l3bGUzSnFyRzl3TzIyN29kUys1?=
 =?utf-8?B?Ui9lRng2d29xZFRBODh6dWU2SzR5SXBhZG9OblRCVDRjSUsrZG12YStUVnMz?=
 =?utf-8?B?OXJ1RjIySjNMbzJYUzJxRDRCblREU0t3Y1Q2MlJnNW00U3ZqNjlGckQwWEsy?=
 =?utf-8?B?WU9ES05mREJDenNiWTJ2UkJNVDJTMUtnbGU0Vm5KbGJEbWlCNVVCYzRMM0ZT?=
 =?utf-8?B?RUhjK2g4YU1oeHZML0VUdkhOYnlhKzMwMGk4aUJURUkxNHlvRkZadkxqT1FV?=
 =?utf-8?B?WS9mL25CWWpnZUZLVlY4SmF4QnFURDdLd21CZUhSeHd2LzQxQkxReEpLbmRj?=
 =?utf-8?B?NXFSdGttdnQxckRDaXpxY0JES2dNQmxwOUNCNVIzeUE0OGpKeTFmL1htUGd3?=
 =?utf-8?B?bVJTcTY0OHRpVFBJd2JJcWxya1g2M1ozcXVsZXErTVdPeG1mYjExVnY4QldQ?=
 =?utf-8?B?amZpVlNIaHpnNFhEeVI2amVIV3ZsL2RKemd4NWV2aWluU1pIR1FQV3RleVhB?=
 =?utf-8?B?WlhOZnJFNm1JMThoTlhJa3ZnTkZBdzM5NkRxZ3VtdTFScHkvamN2b1EwU3Mw?=
 =?utf-8?B?dVgyM1RXNnQrWTRKWE5NZnJxSkxabzNOdzY2eGJjZjRNNU44cU9MbHNtcXBz?=
 =?utf-8?B?a2NsNVA3YWtqdU9hUHo5aGRCRWE5K2xUaS82VXM4Q3JLUjNvUkNEN2J5N21T?=
 =?utf-8?B?UGhIR2I0aTd6YnY2VmczTVFKRHlWMHIxUlJGemhBZkZsSEJ5dWdOY2p5Z3Jq?=
 =?utf-8?B?RUw0RWU5eDJvaDM5TENtMG9xdVRzU3ZxMEc1bVhZOHlqRnZub3k3eDJEc2dU?=
 =?utf-8?B?T2J0VXRhTHVNS0hqaGVqV0JqSG5Gd2pFZXNibHFGcjFVb09SNWhMTmxYSTdQ?=
 =?utf-8?B?SkJiK1VNRWZNSzVFQ2VjZnpIU1JGa2t0NnZocnZVT3RvLzBtbnVkUSswZ1Fu?=
 =?utf-8?B?cCtwNEozV3FwVUh1ZUFaZ3pqSFp5ZGdUMGlSV0RMUExQUUxJRkhQK3hnV0tz?=
 =?utf-8?B?cXNQS1hXcUZXcGpOcThIU01BSS9PeHpTanQ5dno5aFZVQ1dBaFQzUlJpYVBF?=
 =?utf-8?B?T040Z1F0VzJYaDN1RlVGcHorNUFXWDYwZWR1OEpseHhlOGtIMzduY2lTa2Vj?=
 =?utf-8?B?bm15YXNSdWR0MWw3MFgyaFU5Q1lnblk5TFFaR1c0ZXJUL1hyd2liOUNiOEF4?=
 =?utf-8?B?YnA1NjRHT2xOQlBGWExBazRMVndnVE8yZXpueUpGamk1UmY1dFM4djJTZHND?=
 =?utf-8?B?dGZxOHJIVXZtQnZhTzZ1YWgzVHdMQWt4WVZEKy9UVGdlSXc0NXdlUDNwSE5i?=
 =?utf-8?B?UXBrUFlYK3FrY2NHeFNZSU1IdWphMkxjTHJHYlBRcCtwWlRFdGdmYnUvVU1P?=
 =?utf-8?B?QlJiSG9VY2tGUzk1UnlsZFhIaWhsYTJwWVhVVmpURy9zRzBsOVY4UmtjM0Jo?=
 =?utf-8?B?R0g3NktUMXd0TWdQdEg5Y3JOdndXTVd2THBFcWVnU2VoeXZkc0VOMVJRcDZp?=
 =?utf-8?B?MUVVRDlLaHhYSWpObzZWQzE3ODFuWHJTZlF1M0VMYWpvc0hBUTlaWFFvVHg2?=
 =?utf-8?Q?Xf6qH1XD0Av/f6zI=3D?=
X-Exchange-RoutingPolicyChecked: vK1W+/9bji6J/Miv4bxQmjCKB4/mMBxIWWG3yr5TQNMWTMPdNaUa7RXKVjb6eL6RQFaCJPGZHpv7OAvktRKaf0B62qc5w1j/yQIcSLxjFuwV2dSlmb/zahdss+NV7XqXc2ap9Af5ZsZwaAbuPIuxt+vRjNi5J+0KFbe5FdqxgFdaMTq4ROgQcYmY4KsZS+o7DxVTgLVoTKWj0j+yH+W1HNu5PlRNf1pxSq13RRsG6eKKqBFgdTQpUUKMD5sxcglffNaY1J/KVI96C71iJPa2zmrYLhXIanu2YVJFuIuyGPYE/Et8NzvA8YzYcmOlvtGX3nQjzBXyoOfoJZelYaggwA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d51398b-aef1-46f6-4c6d-08df1b2af9e3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 17:32:30.7522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nqM8tgpHdzBDYuCIY7ImTuvQHUqjMY/Lj3PikwZjHcb9juewtM/Zc+vPEsSo+cZr2jl16r8QKfBZdkj/K//MEWd3AAwV/UD1GQzhdET9LpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8088
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



On 9/24/2026 12:34 AM, Thorsten Leemhuis wrote:
> On 9/15/26 10:57, Javier Herrera wrote:
>>
>> Since commit 578294b8b60d ("e1000e: Reconfigure PLL clock gate timeout and
>> re-enable K1 on Meteor Lake") the integrated I219-LM in a Lenovo ThinkPad
>> P14s Gen 5 (Intel variant, Core Ultra 9 185H) shows constant packet loss
>> and erratic latency on the wired link. Wi-Fi and a USB-C RTL8152 adapter on
>> the same cable, switch and router are fine, so the network itself is not
>> the problem.
>>
>> Setting the private flag "disable-k1" fixes it immediately, so this looks
>> like another system where the PLL clock gate reconfiguration is not enough
>> and the DMI quirk table introduced by that commit should be extended.
>> [...]
> 
> Dima or e1000e maintainers, could you please submit and upstream a quirk
> entry to resolve this regression? Ideally with a stable tag? Javier

Dima is out on vacation at the moment; I'll prepare a patch to add this 
entry to the quirks.

Thanks,
Tony

> afaics provided everything needed for this. Reminder, Linus rule of
> thumb wrt to regressions is "generally fix them within a week,
> preferably before the next rc.":
> https://www.kernel.org/doc/html/latest/process/handling-regressions.html#on-how-quickly-regressions-should-be-fixed
> 
> Or is there some reason why the quirk entry is a bad idea here?
> 
> Sending this as things looked stalled from here; or was there some
> progress to resolve this already which I missed?
> 
> Ciao, Thorsten

