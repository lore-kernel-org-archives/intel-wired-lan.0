Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B979606A337
	for <intel-wired-lan@archiver.kernel.org>; Sun, 22 Nov 2026 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=FpC2ifj4;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M2TKUXIU;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=eEvPeXCM
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5DD93405B9;
	Sun, 22 Nov 2026 12:40:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KNI-OlKS02se; Sun, 22 Nov 2026 12:40:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A452740647
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795351231;
	b=FQsw/gB5NxiesP1+UncpZZA7av41Sto9s0ps8F8tcg7D7o272j8c/h5rhdkXdNYaCtnY
	 e0ZmcWud92NTVNkZf/f/2B0gA4VgNBcNjlBxI3G2/B1ILsG/VN4is3us85oZEnFVRq/hf
	 nLONmwGRb3Gqm0jPQ74uRIgrRg0OHs2IXy8oz6CTlt8Ronye+3SYsEvs7wzmkAUth+MAQ
	 5RlUpi0YV5b/FatW67ZV6Us0V9S4yYeDpx/a44CW8XE5vHw6Hsk3mt3DL0xrhyNLEIB5G
	 IFsmrTe2aS4uby99r+Z8hbyN9fAMoW4EIraMT6tsTnZTxjvgCt0OYC6X0WLavC5Gv1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795351231;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:References:
	 Content-Language:From:Organization:In-Reply-To:Content-Type:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=n+zav7cnY6QzS5ynwtdqeaGTKaFl1jQ2HJvAlmHLVTQ=;
	b=pNevT2EA8f944deFZCc26Era4unbwYcRC3STT0IMPrPGXdUF5U7GANvR+BwyRVZmTsV9
	 K91kiQmnaufr7VQUyJewGwFRcFStDtC/Cxd3MzvCQPqKDz/3K3cGXhq86L5i4BWdj+qXW
	 Yc7BlCto9UcPYaqWumDD82+GOLMwfU7HbU2EVQKMLoBTYSdFR1H8rkfGIjOnGTpba+Hdu
	 kQSytfhJG2j5eXY2LlgeSlqU5SizTpqOMf+3IY83kYGJ3UJNVCCOanb3ZKuwiV4ZGMcTK
	 Og02o8prn4ZnNU9DD/D46prJJ5SmX34OvkJCQUhcaEag3fIPEmUBW8Vcm8bwnSVJX3w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M2TKUXIU;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=eEvPeXCM;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795351231;
	bh=n+zav7cnY6QzS5ynwtdqeaGTKaFl1jQ2HJvAlmHLVTQ=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FpC2ifj4rY826ehQKNmGCzOnsz+J3nT2hoUCPKveDUdKAevkLiM6bjUUCaC33gDkH
	 E1At1Oym035LAGW0PY8SZhhH9gNIhIxI5bwlW1B0DvBUW//yls8RplF1XRcokVfnq8
	 EEMVd47q2A5CBtShmqm0sjtkc2gewhkBHTsbqqWsA8yFs9ZbVX6FHifLzOswhIa2to
	 MJO5eMbfn5kMblK33EFJKu0Od6QboLRZ6wZrw0e3NuzEmRqx/YktTJdVWYE/FUQQbd
	 iL/ZpQX55g+EFhsfYUUa9scGhORqKnT0M6ckUYYA34hMympJGKhQdV6Ru4JTCgZwfw
	 rryC8/BNDJqaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A452740647;
	Sun, 22 Nov 2026 12:40:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 76391465
 for <intel-wired-lan@lists.osuosl.org>; Sun, 22 Nov 2026 12:40:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6837C4065D
 for <intel-wired-lan@lists.osuosl.org>; Sun, 22 Nov 2026 12:40:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wx9GppZvnqRW for <intel-wired-lan@lists.osuosl.org>;
 Sun, 22 Nov 2026 12:40:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3D2C8405B9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.10;
 helo=mgamail.intel.com; envelope-from=michalx.cohen@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=M2TKUXIU; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=eEvPeXCM
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3D2C8405B9
 for <intel-wired-lan@osuosl.org>; Sun, 22 Nov 2026 12:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795351229; x=1826887229;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=5G+eTXf77zkHLJBT1DAJiWIyjpyv2JsmW3vQGJLbK08=;
 b=M2TKUXIUkEeIVqObF/cK3EokqqekFa2qosBOnQROp+VBP4agKiR/Q1Nr
 NpfKpPVZDZmhApxan+FrkNOqduTo+GDIvxP5TtlfRB0NpLP3qz3K2AMxx
 lLlkqZ+1WZ1rOd/FcSDFadDMqhsfnmASGTQ6P6XzHZTod2B1E7v1hrG5k
 DsmN46cR+pKIiDUfI3dVfxWeMjmyGuIPsXtc1POhKEgOlOjvsbDAskvRN
 O7qq1bEAueMcxbZ9rZEzGRGvceF4XtjpFff2j5Ji9fndH7Qixt4OdXbcb
 S1fW4dLAdILVK7f2w9zD3u2vhaFGdRSsMTT6zF7abLFkZDwwHLiuu+ARu Q==;
X-CSE-ConnectionGUID: Yb3Dyh9+SzGhy7w3kFAXAg==
X-CSE-MsgGUID: RghXiHjISral/xKXIPCv8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11973"; a="4079436"
X-IronPort-AV: E=Sophos;i="6.27,226,1787036400"; 
   d="scan'208";a="4079436"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2026 04:40:28 -0800
X-CSE-ConnectionGUID: wxoBwgGMQ26c/37VAiMbmQ==
X-CSE-MsgGUID: B2VRF+ZzSnCT3JjAG5koPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,226,1787036400"; d="scan'208";a="10954162"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2026 04:40:28 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 22 Nov 2026 04:40:27 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Sun, 22 Nov 2026 04:40:27 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.11) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 22 Nov 2026 04:40:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+zav7cnY6QzS5ynwtdqeaGTKaFl1jQ2HJvAlmHLVTQ=;
 b=eEvPeXCMN+DTpftJ2t9SCKOYfcKNAEBZrsMki+HF3GiOzNnLY/gRl78GTjEdDSrtO/evZED1stvp3LOlA4pphzb7TnTHbn5miEsN96adqeV3E5ORAFmpjc/qpwtiE4ISnXskXLMLQ8ohQ+0nZtLto/58ibCFZZko8heXYurQafU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5520.namprd11.prod.outlook.com (2603:10b6:5:39f::20)
 by SA3PR11MB984244.namprd11.prod.outlook.com (2603:10b6:806:530::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Sun, 22 Nov
 2026 12:40:24 +0000
Received: from DM4PR11MB5520.namprd11.prod.outlook.com
 ([fe80::75b2:c8b1:10eb:2ed1]) by DM4PR11MB5520.namprd11.prod.outlook.com
 ([fe80::75b2:c8b1:10eb:2ed1%6]) with mapi id 15.21.0639.012; Sun, 22 Nov 2026
 12:40:23 +0000
Message-ID: <245dd5bb-b561-46d2-90c7-d2ed9636816a@intel.com>
Date: Sun, 22 Nov 2026 14:40:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [iwl-next, v1] igc: remove redundant headers include from
 igc_tsn.c
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Sasha Neftin
 <sashaneftin@gmail.com>, "intel-wired-lan@osuosl.org"
 <intel-wired-lan@osuosl.org>
References: <20261024162405.133786-1-sashaneftin@gmail.com>
 <CH3PR11MB566895B304FA8D9E17260964B0E5612@CH3PR11MB566895.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Cohen, MichalX" <michalx.cohen@intel.com>
Organization: Intel Corporation
In-Reply-To: <CH3PR11MB566895B304FA8D9E17260964B0E5612@CH3PR11MB566895.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::10) To DM4PR11MB5520.namprd11.prod.outlook.com
 (2603:10b6:5:39f::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5520:EE_|SA3PR11MB984244:EE_
X-MS-Office365-Filtering-Correlation-Id: ca7f708d-f69e-4db3-5886-08df4895c704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|11063799006|4143699003|56012099006|261026140227099003|261022105027099003|261022075727099003|261026121527099003|261028144727099003|261021123027099003|261022113327099003|261009223027099003|261102123227099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: 7knHRlVw/o1uTZBZU406ZjjzTXQh7QXNyzy9CbVhBZf+mQy25iVl6KbWVuxxmt+WrM/6O0QXJNCuD/jbn3Ovm+dt/+8puW7zKImoYrxIi2kAv2PQIZ0bUM04cLz2gI1Fdo8qB/jpzN2cezJOHSurXGokR0akK+eQOWK5p1kZWJ1kNVwGXAGBe/cCXSPhgTtPkwQYWlbHCvDtvpYv5zrzI3wb8c3Dcq7QF7+WrgvBHY3/umV5kc9C+05Ewl87Zq2VqSXJL17UgEXNIVnNE6ra/q2IymAZBZ1ratZcQfuTZ09tPTkmvpvjABGKw1ZIOK2GCWNYplKBnkExl6gkAWKQ0Jo0aPmi83r4Jn/hsCf2OOZeWFFdHof7z27IFHtzcTTUDcftMyzmUkl6/pMOxZMnSJsueo3icreCP/BK3FzHGvdz0bgOYJkRhn1yOV8kQoqzQ5V+GnDqwcClcYrC8YrekvAs5c8lfrfyw2ofUdDYkrpn3ZN0xwWzX9A9PZblwCoRcwhcrXaAY6tik1wR2B3CY/RBm4t4MC/ZZZaNg6JpbAfZJ78ZNAqH8NSknDc7d/Q8EQdYCO3kTK7lntVMhDC/KAEcCFfKuhMufrVonBqim7n5J0XhD7HhA9rNxeXDVYKM5Z5pRB2XKgUwtuiMuO0J4AHXtMi4pqeE4qS/qXt0uJ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB5520.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(261026140227099003)(261022105027099003)(261022075727099003)(261026121527099003)(261028144727099003)(261021123027099003)(261022113327099003)(261009223027099003)(261102123227099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlUwVGZhUWtSWkVuWUlTZ0EvWXV6VEtDeU5wbnRDK29kNzIyKzNkMU9EbnVm?=
 =?utf-8?B?bGlHaG9KVFNkZmtUTVVvTVV1d0h3VmdWUm1TS0g1Z2xUYzBSbnc1elBtMng2?=
 =?utf-8?B?blh6QVpvZENzSnRXUVJJMjljd0pwenhPNWFNUGFZOHl2UGRBUUYwdks3OWVM?=
 =?utf-8?B?RTVWakVPTFdYVHFzZUZVT2JxbklnRXhEYkpGaWhpaDNFeDVWMGtsd2t0QVIx?=
 =?utf-8?B?MnE1WlNPOUlkc3JtVFJXMGIzU1FyVjNmSk5IUGdWTGVJazJpUVVxaVFDd2N0?=
 =?utf-8?B?T1FhSlZhRFUrenpNU1h5M2RXaUZvMlVaaXFjODJ0NGVRdndlc05sd3VXUmZQ?=
 =?utf-8?B?U1pqeVpxR3RTelA1VmdMK1FqQVBWdzNMTURLSGM2ci8xN05DYWRsQUwzdTY2?=
 =?utf-8?B?bDN6YUVlaFBDR2wweFJOeVFhZTEwK0ZGWDZVSU9vRVQwTGRTcnhXZUFBNmZY?=
 =?utf-8?B?cGQya3hkc3IzMVNuTmJZMjZJYmR3SUZCMFpiT3JzNzhTQUdaQy95ekZ0K0lx?=
 =?utf-8?B?bTFMWVl3OUR6NlJ5TElwTVJVakdMSm8xeGRSK2VtdTZTclVOMllBekpLVGNn?=
 =?utf-8?B?dUNYbEYyM1hwNXRNbVkwaVNNc09yL1VpN09jVjJ4MTRtZlhBbDN5RUdqaFJo?=
 =?utf-8?B?SnVndTFCNzR4NjQzZzRPVnEwRVgxVFprV0c5RUd2WHdkNEpIaWpJWFdNeGEy?=
 =?utf-8?B?ZTRyTEJuNlNHUm9NZFV4b1B6MS9RUEplaEdEbnAvRVdINUU2UFByd21MbmEz?=
 =?utf-8?B?YzVaSUpCQ2tiTlZsMUFnbmRFZGlQb3grTlRSbzdWQWZBeEhXVyt4Q1BVems3?=
 =?utf-8?B?UWZlWlErSFlKcFVtMnFRbjdoL0NhYzZodmlJamFCTVd6QnF2ZWZwb0p5MXh6?=
 =?utf-8?B?aVZpYXJxODFTdzc1Q25IS3VlSCtwUFk3RTVnc3Z2Nk9yT2w3OFFlRCtlS0RG?=
 =?utf-8?B?ajJMSlU2U3dySUpxMVZGTHhDUWpBRDZwY0ZKUlVTZ2pKSlExRmpYM3VMSkhP?=
 =?utf-8?B?dzR3N2E3SjMxYkttTTRNRXozRi9BUDZ1aGo4bTRBZTh2UmsxellhUlpWWmtR?=
 =?utf-8?B?VTVRaTlCa09PWXBWQ2tkakU2d1Q2c2pUZTVONXBPd3U1RnpwMy9mck5Ia1ht?=
 =?utf-8?B?NXgzM0tEUE9kU2w0UzJuM2JBRWhZVzhoQkt1cTJjTk9RZWMzb05IMERRbWp4?=
 =?utf-8?B?SVpqeklBTVpYbXNKQUx5cVNsY0txNjhqRE85UEZoNzNjYm1oOHFRNWcydk1K?=
 =?utf-8?B?dWNsMzdBdzI2dWVXTmFnS1EwT094TWV0a0ZwUFpmRENXUE13RmkzWmJ0TWRz?=
 =?utf-8?B?eXZvYWtuWDU0bGFqb2dGRTdCMTlKSy9vMXBnZmQ4Y3RzVUdrR0txSmUwd0p5?=
 =?utf-8?B?QlhhS1RRSVZnYkdxT2JpMGNIZmkyenlPOTJYY0hZZFBPcURKaFc4YTdmSG45?=
 =?utf-8?B?ZkdDejNJQlhoWUdsT1I2WTcraDI0SDB4eHE2Q01OVEJFUnQyRkw0a3lpd0dy?=
 =?utf-8?B?ZExCTGFLVmliOXl5SytMMWl5R0NBdERLUmRDc1RaOWsrbjhFTHhYNGFKWnFa?=
 =?utf-8?B?QktmQ2dVS3lxeTJxcVVYeVBKbDJyNElNQ3VjU3VkNXZFUlEyYlp2VnkxNWlG?=
 =?utf-8?B?UUJGa3pxMWlxemdqSXhHcVRuQms1M01zQWdHQVVKdVc0Y0dnRFA2a1ZDMy9G?=
 =?utf-8?B?SjFJcmVxZldFNWxEWUwycGJTeDNpVDBycEMraFBzek1uVVRmWWlsNk1wVUs3?=
 =?utf-8?B?cGFETjg5M0ZaYXBwQnRnK0lkQlIrNXBBeU1VQTdORHZodGFUUklkeHFSZ3d3?=
 =?utf-8?B?RGtGVGEwWWRxUThwS1UxSlpYeTNkMlc3b3V6UzgrREphTjN0dGM5OVF2YVM0?=
 =?utf-8?B?djFFcEhKNkdPZDR6OTBodGVrdlk0KzVEQWpnVUw5K0NwTWp4UWFSeUo1VnN5?=
 =?utf-8?B?SU4vemxSbm9nc01MdFh6UG43T3EvNm5LS2EvZGQwcDgreTZQSUlqVmo3WU1L?=
 =?utf-8?B?OGtmZ1U2dCtmR3dPKzFWQ1FBUVpPWXMwSXhqK3MveVpZOUtSWjVDbUtYeEdu?=
 =?utf-8?B?TzFpNnBWa1BZK1dCZlJUUjNMbHlDcmd4MkVLNUtzSzlGSURxMWFHYTB4UTJk?=
 =?utf-8?B?NWFjajFmd2ZKQlBya1ZyUkxYajdvZmdpWlFVVzZqOCtIMTFDSzdvdjREci9L?=
 =?utf-8?B?SkJwNldWOSs4Y2NwK3RYSE9iNEJyTFpCTSt0ZFk2M3lrUmdBWGlZZ3BxaUdz?=
 =?utf-8?B?RXFmU2xOVVRyZ0lEMWJoZTYwNEZZYm9BRUVrK050eTJBZ1VYWHFZNGdnakRr?=
 =?utf-8?B?R1E0dE16OGx6ZmJEWVg0QTJPK0dMZTluaWJteFNxSEpBeHJRRDY2dz09?=
X-Exchange-RoutingPolicyChecked: QV5sovpjzmHaiECcsRHTzeDFeB/0tvpxUjPq4WApXf+oOQ5glJ58hhcAkskUVUdoU+jYalVgxtBLwzbFUPgHtMy9p5sTv1ezrDFCcNu7/zoHmeJY1Zr81eQf25OnwrGvqPsBgQSQl5qF+9Zl9JOKkyN3F0P8gJf3VK30o995Oi2CCtMbSdTOZMv1F1FRCBmD3kIfjbI4NIdVEyU8EmWIC/r4UHPHN4C/QAOqz5RA/Nz4+1n7a7lOPKez0rlWaal3fVD1vZtly8V7ycfhhwUkVZb+w+NPM2Jspwqx4Almdft+yMQjDgRqDvFsf2rcNhaSrQnBtcSlsNayxZYBwtrk7g==
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7f708d-f69e-4db3-5886-08df4895c704
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5520.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2026 12:40:23.8686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g19++tQZ+isu7X0G8HzrGQb4BUUPPV4taaD29TN2GupHyRiQ894e/9RJmqbjS6kPNZwERg06siFzA3RfSMbPfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB984244
X-OriginatorOrg: intel.com
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 27/10/2026 0:09, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Sasha Neftin <sashaneftin@gmail.com>
>> Sent: Saturday, October 24, 2026 6:24 PM
>> To: intel-wired-lan@osuosl.org
>> Subject: [iwl-next, v1] igc: remove redundant headers include from
>> igc_tsn.c
>>
>> igc.h already includes igc_hw.h and igc_hw.h already includes
>> igc_base.h, so the explicit include in igc_tsn.c is redundant. Drop it.
>>
>> Also, fix a minor typo in the #endif comment in igc_tsn.h.
>>
>> No functional change.
>>
>> Signed-off-by: Sasha Neftin <sashaneftin@gmail.com>
>> ---
>>   drivers/net/ethernet/intel/igc/igc_tsn.c | 2 --
>> drivers/net/ethernet/intel/igc/igc_tsn.h | 2 +-
>>   2 files changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c
>> b/drivers/net/ethernet/intel/igc/igc_tsn.c
>> index d23a45a34fa3..868334e9e396 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_tsn.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
>> @@ -2,8 +2,6 @@
>>   /* Copyright (c)  2019 Intel Corporation */
>>
>>   #include "igc.h"
>> -#include "igc_base.h"
>> -#include "igc_hw.h"
>>   #include "igc_tsn.h"
>>
>>   #define MIN_MULTPLIER_TX_MIN_FRAG	0
>> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.h
>> b/drivers/net/ethernet/intel/igc/igc_tsn.h
>> index e08f48543d99..caca3720525e 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_tsn.h
>> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.h
>> @@ -67,4 +67,4 @@ static inline bool igc_fpe_transmitted_smd_v(union
>> igc_adv_tx_desc *tx_desc)
>>   	return smd == SMD_V;
>>   }
>>
>> -#endif /* _IGC_BASE_H */
>> +#endif /* _IGC_TSN_H */
>> --
>> 2.53.0
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Michal Cohen <michalx.cohen@intel.com>

