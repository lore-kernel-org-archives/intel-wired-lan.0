Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B65FDCCF2D3
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Oct 2026 11:25:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B70C40629;
	Mon, 19 Oct 2026 11:25:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ju6QU1pcSATs; Mon, 19 Oct 2026 11:25:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CED9140645
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792409148;
	b=SclxhNhwAIQaOgO0a54GMv+K5bld1mx8WWg4De0eMQdwM6XoqHumw3trrepEMDaPifre
	 qcMn45ENO3lIkeE8kCmTx1kTW2uDNL4PbMifNqWUV50cmBEpz/D79I7UgY1W02cvyZbGw
	 UGt0eaa0AvLyGsexpgNS9NgifU6y/bVxGts7HYlqarJBlQOYkWpuP7w65cNcqAYOrYnDN
	 +VaAHE37UWsETt0+qf+kwkXSKAcUmUi59q42NtBgmehO7mj5/xuZ8jhK0UGaYXc5FW0Oi
	 9hVf5u+PYbZzJSxMNR0g5reCWxla+tuBG/1xeuBFZznGRJmjfoLJvyOmU8KIgG5hRHA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792409148;
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
	bh=RCV4JYtAck9qF0rPtPoCaaS02lD+Y0r23u1simK0tWs=;
	b=GnDZY1KCS53zWL6rQxLEZ/yX8nLO5eyIGbpzZvszM6vtWOf2+DjVQbHO4p+LVXQIrwPA
	 UE41HeA2XirYeUSGbHEbtKeuctsTqQlVCylg9hYNfldOuycxNkalMnmuftS55wOlhecFu
	 8dLGwhBOwfkHSpDPMT+XnKcY4Bokh0Pxf1q02pajNj7xIN/eJ7fyA3DyMmP8q1pk3Mxrn
	 H1ctniSj2cR/nCfAK157IGDZaKIJCPRWElUorIY4UOhaDkR4M0+v2BjYl5aRneIDhJPb9
	 lCod0h2ksF2+nksIefTSX6vVnJVOOTuz5K10gOmzYFDpHOrG5MDgZGdEO0jHuVwz+BQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792409148;
	bh=RCV4JYtAck9qF0rPtPoCaaS02lD+Y0r23u1simK0tWs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hry07G/H+QZj+7Y2yVuM4vltWGfiXPTmP561MaLHpTpfirQVd12Kt91xMZEaniIaN
	 b+1tTw/uUtBkZgOeEYs7bpMiT+0CZZllV7e0og4VrvrsiGcogDDZGMhgSCGAPW6LWN
	 2ZvVAlf9RNkhsKjwxkFBomuDbpBvEUM5IUdbAfidLJk4YrrqeyF917pHICBZvty9g6
	 GIGNdcpDxXWOrZdLi3BPkuQ6eO3gMEBO9W/Nu3n5YwHBNSZFHKKiVaRzwYuZnrj3+B
	 0btP4LCXVUy35XCAspio3R7h3AiRJ94W2KRPqmwFvjQuVstua2dt2VtoEh+wz0ypOi
	 fuvT7yGvRARoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CED9140645;
	Mon, 19 Oct 2026 11:25:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C1711E9
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 11:25:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7D9A380F19
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 11:25:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9xcKpEtr0-ma for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Oct 2026 11:25:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5897F80F24
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792409146;
 b=hybMBb1hf6fpr2TQPh4lIqKuh41iFYu0tjJXFuTqomFxDbgwy5xe3oEAcO93EOHlLiDe
 6Z1mVJAqCBe8rIh1Z8FwhxyrQKScNKoIHummpo04nY5WT5Q65HxXYf+FcjXmQx5hl/Ums
 GFs1AEFctfuQKjpoMB+LcmSmuFWoFXBW9kgBSmq2tKk83Laf+mb0NIqtWhLrj42fWP4HI
 bb0IgTfFWchoSXO76RAU4boOmkmCuroKYS0EeKKYoM6RaA+i2celmX7j/RntHwVZci47q
 HMjqs1VwemWlI0JBjkSlKLfpNPLzDI/EOQ0AR2lHwInfUN4xw3oDlIOj9afnkQH/rGw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792409146;
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
 bh=RCV4JYtAck9qF0rPtPoCaaS02lD+Y0r23u1simK0tWs=;
 b=hk7b4ORQT/EG3ymjVfS82HIoKsQXLLOvFSInTlXyZYuwLTINoAVGOtq+nmsfuhH9qECg
 XAMCHLNeMa4C3QwsNcj2DsUhFUKO37ndwpIqxO4lxa7NHMSYzgMkPlIFX0dl5ORh415O/
 2xJQSys8qwpHA7hecT+ErE/SWWC9vhR6bzWTPVgEshAODEbweYqrwY6gJIz4gYNiNirTL
 3GPM7cRFa+JC3caG1dJgGhTcwjvrFN/TzRzjxp1B75bD3wW7iSEeUVC04CLJLZS5/vjge
 RI7IQmOeQ184/8965sXoiOMPEoYdW5jp1e7PVac/MsbThzZetnhU7JIu9gPr/MW8EwQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cOhZ1Ulr; 
 arc=fail smtp.remote-ip=198.175.65.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=cOhZ1Ulr
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5897F80F24
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 11:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792409147; x=1823945147;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=h2kt3G+pyYm2QIrKIawn+gK8L4eqQfMoT4gShkhiHSk=;
 b=cOhZ1Ulrxuq/JWSKyUamu9WGEwirk0m5qzlZD2NitlIKfb66tXt8kIMc
 iFA150p0ZGbNkcBjcKpW2O7EM8AyRLe0Oswv466tFKqKfo7eDyPbwah7L
 dKGwJgLy6+8rCnlufQWSX8Xg7Goq6dyGqj3h7oYyoliiaWQW2YhfHs1eZ
 sEI4H3XnCi6ekp+L6Aco0qv41K07YYzzvULeUZ1d9Z+oIM2zrTrLa8U72
 mpVSpbzgA3tCrSNI6F/w4geDeiGYjUXCw9BVdS/jYkqkb3xMek+B1LxfN
 kOoa2tXe5pCelG/71+z87+sfNJhLrJb0+FkUoTxfEl7h/N5sXH4/lQzsg Q==;
X-CSE-ConnectionGUID: owTmBi0jToadRvSSl09OxQ==
X-CSE-MsgGUID: 5EjUBZD1R5C2X0i6NdmBAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1089214"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1089214"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 04:25:45 -0700
X-CSE-ConnectionGUID: epQ8jejASROFBgRIO2lukg==
X-CSE-MsgGUID: 9UBMr2f8QTO0FneA0WThIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2914685"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 04:25:45 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 04:25:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 04:25:44 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.58) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 04:25:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjSuYAR9V5lJFv2rshdJbUd+6CiEGnNYto1shsAq3wStAUIcPY5B15pvrnfhtsHXlidRF/2nyhWhptB0j+rOH1w/6fRKKaEHEih0VmVfwM/jPdMKkwQu2eyyEaxHaX/lHJMVAlrh2dXg9oC2w9cX3siXWf0Ve/HfqmgbNM8Lg0KXfQ2ewFNKx4A6YQAQeBizJ1dg7RulzdBtJ96nQzNGNuPw3SUbTWoqmbR1wmTW9M8V3f2Y+crrWyGry8k4vF2wkudagdFF0br+xGZyWn0gFKEuhhYj2CW7OKoydQvLh/nqHVPRY7XgxTFBz8vwJgq+QMgBf4VC66fVQDLxEOmrdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCV4JYtAck9qF0rPtPoCaaS02lD+Y0r23u1simK0tWs=;
 b=jxo3kVLeAdbrDfV3leS3D6heqks7BSr5QpYgZesmjqvJLRbDjHhNu+l3UmYfx24/DCswQHVybcygyN0XspBWCFTWbQqBR4QVwZGJi+AZTu+WYWXfF8LfjgfMSm5CgufqNoKKSbSIbzA7Q2pjsKTV1/1e987gRJQcfu4knmBbDQw0Z4bZsCGNsGbuyejJuFUEuCY5CHAgZ8cGjsDen25Pc+ls/1giwbp3TQ24O0A5+54Ok3+mt2MRhso2avtfN9Uo16FZ9RuJ/21B+AJTppvdjV3lmf6+1EKk758+ykgV8S1hFWaZzFl4LR01+WKq3xlNfc6ZLQYlnCI8t8WI7n3aCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by MN2PR11MB4551.namprd11.prod.outlook.com (2603:10b6:208:269::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 11:25:36 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 11:25:36 +0000
Message-ID: <b16237b9-170a-4763-828c-1be8fb4e8091@intel.com>
Date: Mon, 19 Oct 2026 13:30:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] ice: check the full PF reset polling limit
To: Aaron Ma <aaron.ma@canonical.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 Richard Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Dan Nowlin <dan.nowlin@intel.com>, "Jacob
 Keller" <jacob.e.keller@intel.com>, "moderated list:INTEL ETHERNET DRIVERS"
 <intel-wired-lan@lists.osuosl.org>
References: <20261019105155.3793063-1-aaron.ma@canonical.com>
 <20261019105155.3793063-2-aaron.ma@canonical.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20261019105155.3793063-2-aaron.ma@canonical.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0026.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::22) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|MN2PR11MB4551:EE_
X-MS-Office365-Filtering-Correlation-Id: d70d77e8-75e7-4a23-6152-08df2dd3b248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: KorMDER2iX0tdx5Q5z2kMST83CE8o9jUBMBDszmHI1nBUvPZI9lxvorQ07GkR1+SW/NVsEb/algjj3UuivL5nXmoZBOfBx1KP+7fICSxruafXm4PopeXP5qKSYS31MHHhp3SwGLY+FzLV/PBRGfVVCMjon+NGpqgIdDEvZ2yME5QJD7EAlcSqPcSNv8sWepOErPX1nXyOfmhIaCMv+AXmJJ/2ED6PwvWYr1wyVC5ea6TofIkhkleUjnV1i7GlhDWDAdsmQKbXfFwN5M3PuZaJf1v6JbAjlZRQvO7gZYNZlQgUY/bvRAmNAVn9lvSw29ksPnh1qjcNOMobhW9JdjxFhbhloU/p61SPduUtb8Mc0N/IF9wfXbKsImaP2CoYl2QX54uhYANeTl8lMCd00Xf/F6X/gNkEvng21LcKkXHUfQFWKu5jvQTFm5iIaT+h7vHgvbo/Bf48cHKsZpiT1Z7R7NXz3D0jbDNWklruMMB6yWTf6ms8Fg7y8Od2vRfLR3cou28HPaN9nuEFZXyKluFdhobgOxkkJ8HYLHyy/SdZ9FXVDAYmjAO7k2cEDgpjOKXiTfQJXqZns+l0ILL6LWLXmhg6NFSu8N+fQGmVoU4yrp3+XdliCeE3lyhowhfmVX+L9T92vCWdG9vKzsRIxWcQt2mtuKD1p76FF4S4sv+DyM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkRhakZoQkcrVUdTUGJnZ0htZTNBRHNQWnFlYnJFOVc3RkpoNXNzcTR3NWxu?=
 =?utf-8?B?Zi9UdFhLTkxzOEwrU3M3WFQrVzQ4R0l5djRhNnhxc3BrRVp5WkFZSWlNNk5Q?=
 =?utf-8?B?WFBmbDZSVFN0bHJkOHJtUVdxajRSb2ZQYkdwbUQ1MHFWeWExenM3a2RlV0xo?=
 =?utf-8?B?eStyWkZzQlQ3TVVQcUF2TC9LNE5ZSDdMZzcxcEdjZXM1bHlEcE5xSG5ES0h5?=
 =?utf-8?B?TWkvZzZVQng3VHc3K1N2dzJONjFrRGh3N0Z1K25PTXlIempRUGppb1dMTnRX?=
 =?utf-8?B?SlJaVHBxUnMxREhWQk05REdHenZkaUU3MGFJSzFkaGRQaEVJbzk5d0I3MjlF?=
 =?utf-8?B?VTF3Zk9WZUdNR0ZjTFdVdmRKeEJyajgvcEpPZ2pZSUszZU52cUdQZG9IRzFa?=
 =?utf-8?B?TE5hQkYrWktvbkF6MkwxdzNsZW5TWUF1dmljTERzRW9tM1dTSkt3Tzk4WHR5?=
 =?utf-8?B?eWdGYWJsK1AvVFdORi9SelBZL3Z3ejhuVHNhWVppeTYwSlloMGFmTlZVQmZP?=
 =?utf-8?B?ZG10eHRtME5LbmFYN3VDWmlKZERnUVc3VWxENlEyN2oyV3ljR2VVM0p5b2tJ?=
 =?utf-8?B?SDh0YnJlQ0ExSzlMOGlUOGhLaWtKS2FFVGVrVE1uRkg3R2kybC9Nclpia0VK?=
 =?utf-8?B?SWdRZFdEZTYweENtRlo0V2x2RUM0a1hFWXdWR0N3UWI0NFM5dkhSdExkekZI?=
 =?utf-8?B?Ukt2a3lXcktIVVgzRVdoMW9HK3VPRWZyL2F3RDc4L0xPeHEwNXFaN0RXYXky?=
 =?utf-8?B?S1RLcE52aWk2dmZaTFVpbzNpa1V0UUhETzBaald5TnlaZUNjMUJwR1JXbDFE?=
 =?utf-8?B?N0Z4ek5TT1o3YVl0ZUFCZVpWczBDUWVzU2hPMW5jZ1VMaGI3bjFVZEp6aUhL?=
 =?utf-8?B?OXpwcUlGMS94dUtKeEI4ZFpab1VPQ1QyLzVaTS9xaTc2Wlo1NkxlWW1SVnRB?=
 =?utf-8?B?blkxNnJJN2NvZUx4aXBVbWlyYVNoS09ML3M5bWpxRDdRQzhIZDZVMDZ3MnV0?=
 =?utf-8?B?ZDFwS2I3eFBScnNvL1BEZGM2QkJwRmY1clZxRlp0dmxZSis5N0NNTFlFRWpW?=
 =?utf-8?B?aHhUbkhGL3poSENPWW9yY1Zwanptak9kZWlTeGpDblhicUVJQk9qRzJubTE0?=
 =?utf-8?B?bEN2Zk9YdzZNUWxRZW5tcEZkYllERURZSkFSeEExTzRQTjJmMFFFYnZUTlFj?=
 =?utf-8?B?MS9ZYzl4MDZCZEVzQnh1QW95dzA2bnpFc29USHlyNkliTENnanpqeWRhUWFB?=
 =?utf-8?B?NXhvWU90MXd3K29LTDVnSWNiL3NHUXl5TzZ3Tlp6UzE0SzNCamw2RERveGww?=
 =?utf-8?B?TnZmL29nM05OK0V5K2liK1hvQkhMcXBNOG4ybU5XcTVOSzR6NlhjR2ZISUEx?=
 =?utf-8?B?VHRCMVJLNGRKT29XL2c1YVI1UndOSllwUnFMWTNSc1d2d2FaNDZuRlVNMExR?=
 =?utf-8?B?SWpyRCtkaDdsMHFrTVcxdG45SkUycGJ1clp1bzhXWGNJb3lsVGNjbXBGUmRo?=
 =?utf-8?B?Tnk0cmt2Q1RlTWJQZkRCUzRDZ2xZUndFVkY1NDBvWFdNdGk4ZUwzbmhYc1ZD?=
 =?utf-8?B?N05NL3pRUnBDMjRVSjBoR0dSRE0zQUdSeHpmaXlEaFllNUErSGhDUDNHU3NS?=
 =?utf-8?B?djYyKzRxOTVKNGt3UmlsSnN2TnVCdjRuS29hR1lremlmYWJOWVJUbjV2YlBx?=
 =?utf-8?B?TGlvQW1Vd29TOHJ6VlRZd1d3dmh6dVJheXE2d0xQcEVoWldpbUc0YmdBbzlY?=
 =?utf-8?B?aFVxV1VlbytyOThkN3FiRjU3TVZ2YmppSUhOc0Jza0NSYS81Nkk3ZHk4VE9q?=
 =?utf-8?B?K0VRaVp6ZHJiWnB4Ukw4MTUyWml6MGtTdmF4dkRTcGlxb3lkQU1icEhadkhO?=
 =?utf-8?B?bW9rbVZ6bTJYeE5VcnJ1eWNBTEk1OERVNU5NUDhiZytVMUNnSUZJQUJXbHV5?=
 =?utf-8?B?ZGRaMTBxNWFVV0FQTVZSdGU3TDN2QmdGMXhLWHVFdTQ3cHg0Um5vb3JqUi80?=
 =?utf-8?B?SWlQSXZIbFZ0dVhBN1liSitaTDNZaHpWYnFPeUthcDEwQXFPUUR2ZUVicnFy?=
 =?utf-8?B?ajdHOXJBS1RaaTVEUHRVM2ViZk1rV0U3QnljUTJ2cTc2cUtpLzkreTdtd3FL?=
 =?utf-8?B?d2JienpXSS80VlZwYkViclRaQ005OUlSSWtmZkN0bmgxUm5UTU9iT2JIRVg0?=
 =?utf-8?B?Z3RUSGMzMGlNSHZINUJ6dWt0cUVQU0ZFd0YxYy9GUlBBTkdzWVZBdngydnJh?=
 =?utf-8?B?L2RoWGFzcHVoaXY0WitLZGphbitMeGNKREMrTHB6YmZPWHFtRHFZMFpFSkdX?=
 =?utf-8?B?bGtwV1RtVCtORytoTFgzZ2NUbUZtWGRmSnpuMVQ0SVZyTG9GMUtCYzZnbjk1?=
 =?utf-8?Q?Hqlq0PYF47WjLZQo=3D?=
X-Exchange-RoutingPolicyChecked: i5S0fUMQypoi3kFNbWjS3mJjhsELE/y0ef/QEwn8X/wv2DA4nkqDnQhpBrbOtnobURxoOF1p95txUhpxiXca8ibeLdMboevAJHB8PYxmJAjwL5He1E+QQJ1aCQWDg51zi47n+NDX1ZeOhQqfclkA2nbaaujRFygdoeTMAh1uG/2TB3G0OOfBGUR9O7TW6kCIeDMsyyltHnuG0oB3YT6US2Edm3czdFSCjsan8XaYs+49n2GfbgWxZdi0GPMOoxwfV910evv5Epq3YTtxDQoD4mwj9YNroFGjkFfzr1pwybnFLQ2sNM0bl8dAfD+NoD9BBavLkYBRzvIpk+9DzmHH2g==
X-MS-Exchange-CrossTenant-Network-Message-Id: d70d77e8-75e7-4a23-6152-08df2dd3b248
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 11:25:36.3663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RuOGeN8GKlF+kzvi6aBn/H+1wWHRaSUJ8BIvM3Fwdz13WOmflqFrtiGkvEPip4wCOFhEwWs0LkhWNrI+qhayqxXZSEK9NXj3vXp8Ca2/vnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4551
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

On 10/19/26 12:51, Aaron Ma wrote:
> The PF reset polling loop includes the Global Configuration Lock timeout
> in addition to the normal PF reset wait. Its timeout check still compares
> the iteration count against only the normal PF reset wait.
> 
> Consequently, exhausting the extended loop reports success while PFSWR
> is still set. A reset completing exactly at the old limit can instead
> report a false failure. Subsequent initialization must not proceed on
> the assumption that an unfinished reset succeeded.
> 
> Compare the count against the same bound used by the polling loop.
> 
> Fixes: c9a12d6d2091 ("ice: Increase timeout after PFR")
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index 04633103e3e61..82b803e74aac0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -1291,7 +1291,7 @@ static int ice_pf_reset(struct ice_hw *hw)
>   		mdelay(1);
>   	}
>   
> -	if (cnt == ICE_PF_RESET_WAIT_COUNT) {
> +	if (cnt == ICE_GLOBAL_CFG_LOCK_TIMEOUT + ICE_PF_RESET_WAIT_COUNT) {
>   		ice_debug(hw, ICE_DBG_INIT, "PF reset polling failed to complete.\n");
>   		return -EIO;
>   	}

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
