Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E1ACA5FB1
	for <intel-wired-lan@archiver.kernel.org>; Wed, 30 Sep 2026 11:56:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E3ED540801;
	Wed, 30 Sep 2026 11:56:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yTo3rKCS2L_8; Wed, 30 Sep 2026 11:56:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DF2A740A90
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790769372;
	b=DZksAlMmIBJKah4pfreNJ4nLs75b6XOj00IbH3YpUiS5l2gdIAcSVUybf8o1NXridrnl
	 LbcJQTtYPZyzZsHX4DmNEshgz7A4rHvuqkaCC+0Aw97zAjeL0DGAAOMOmkJRsmBDFJSq1
	 mfbs4WnTGsNfW4xKXQKc8iKgNOJr8CMUBE0rDjUfeqhrrZc8enPrIunP6iBZNaPNs+xUe
	 iHiaqole2jUWwmiIwmSDlETV76xo5qDeNa/6pH41GNGjKSRN8ILsdDn8sbxUjErfPeFMz
	 YIQmtoBX4EH/IHCah+QzncHeR1aVIDUR3Yj/xCLZ3f9qBFiVP+GeKfjWIqUdAj7EGUA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790769372;
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
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
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
	bh=yETfNp+a6qIo6bomko2BdShJmEjkq8evIBIl2UQ+Lt8=;
	b=eEr+cO5ygVlGOwG6yuIa8Mz7OTH8F7uKJ2aaIRB9Nbej2g1t8smyIFUFvsTUOYbOqJmc
	 pbNRij0yvSmPeFDkAq7MGofoLbZBoYKI7FR6svquy6L9IYnr6EUydlwKNcUuBhlPS8UQJ
	 VNQE0TFoaiAmYN/J0BonArfszvcFSYLCoSbS2PrXjetC2Rumdx2IOlAevYqhomRwv+ntM
	 +/Qr8/yetSgC6gbH8xQ8A2iigP26hf+EFmL1Y/PTrzdonEFqy2y+q4atrDi+UT995vFpx
	 InCD1+/eD35PhdVumJCwhz6VqN2BjBKy+vz+1svjEfhv59ePlFIvSnVvi6QDu28WUHw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790769371;
	bh=yETfNp+a6qIo6bomko2BdShJmEjkq8evIBIl2UQ+Lt8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WbO6BqnFZumBnPdbk4bV84mWhTxK1KWQC0U0ndqa6LqLAVksT5dO5H2pI0f9mWUBA
	 Kxk0aXekYEfuM3w7N1v0Wc640CcjnbwYINPqOnoV2sH23xWHtDrA7+VtFPXmwJzws0
	 tAaUUkpF2nv7SCyf5xHZC0L7nzNgs1InJ1/70Qvzb6Y/k1Ay3kAXBSiRTGpa/WInuf
	 rxK/sXo7KbtMHq66gjrwGWXKKvSt//S8P4XXZlRm0mfYiaP3dWclAcICfLvBMcnY2e
	 qYg3EwFF1l6rqap9S/2MW2IZVmiAHc6tZf2rEYVXmpE0JNkUKNsRNLgvtep36cFiCd
	 sEtvt8SRmT8Ug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF2A740A90;
	Wed, 30 Sep 2026 11:56:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C26432A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 11:56:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 429DA400D7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 11:56:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jg2odTP0ZqcF for <intel-wired-lan@lists.osuosl.org>;
 Wed, 30 Sep 2026 11:56:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 21A514009D
Authentication-Results: smtp2.osuosl.org; arc=fail smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790769369;
 b=s3/BzGwrcQFfw8rG2MBY9JRwg2/Id4VSoz1moyGAz9U9TwekAKJ8A7o2QGq2p1dmIeRk
 uDPzbmJjn1+mbT8aRXZmeC4wJRBDU+rGqkCCM2VfV2To0jSUFs7vzyxhIpB3nxHvK+qKc
 wiPK7SeVO9ZdVQ023yGpSrLZWnl6daMml3QFVeEfPeDVXYyn6Dg/c929kG7Lv4KyPs6PJ
 +8HIn0rB1+xU7/BokyCkHZ36+WFEUNXiNIE4+YJbXMdK9SohLttqlOvi8IyJQC4RnkxFj
 4q3gakUV6kgozpCCaAlphw4I+dI58Ow3qZR8AwajLtgP7C5fxdkM5ORJk1Pfn03z+mQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790769369;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
 References:From:Content-Language:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=yETfNp+a6qIo6bomko2BdShJmEjkq8evIBIl2UQ+Lt8=;
 b=V/wGN5LneMpfM+yu+mXutKh4b+WG2hPsKpsw7j9JDxTL5PIMrU4+Daqc1AYSdz2bNeOx
 +BvqV2hDWyKPJIKi3BD/m3iyF6mxPUIOvwEtrXzdvwokvqlkItGuJkWzoyjtKcH2Nc70M
 DJy8KIykDSokqe3uxz8I5YSpdnPYGAA/mg3BaNIjk/NA8/eZqaQU1OR4gfnbw6e6XOP1n
 n6n6M/iA6orlZuna05MfcWcptAByp67QioJHoomavulh3U+EC7PLtu0bBJVxs/LbG9883
 fVuCm5K0xruzfwAXOyYdxJN4/yWO9EK03XyZsD+piGgs0POhqz/uro+5TVY2M7okAhQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=jchYjv9U; 
 arc=fail smtp.remote-ip=198.175.65.21
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=jchYjv9U
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 21A514009D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 11:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790769369; x=1822305369;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Crr59rbMiXP5OgYydWHhJ5Ese+OJqoIlrkv0dtHnxQU=;
 b=jchYjv9UEqGpyb4RBA35yZTKFbawKBtRQaZ3/eHrBfI64ugdvTGwcari
 SLD6Ltn5A4N1S6iL8NRKLjjLhUJ5u8/YYsMlcO/nxiF1vPf4rMwOtrZ0n
 Dk0QlnMjW2CD8HQ5nNqaArqqAxxyzvy32C3B0x568hId+aeWFC12GT9Wa
 cSiNUT2NmlpxNeINoP4zb7b3nnq/2pUfRkNUBWZytRbbFLtVM3C47LBj1
 12c7rOcGs/Ie3aU0QLohCVwJQ8a+lOW0T7TOe+dP2W6jMUSL1n1jRMc1K
 mp+NROvsjQZ5+zYPcOEH58mdsV/GjAvBLGLxFwusIHRyofdO9gjJmg1Dj w==;
X-CSE-ConnectionGUID: kp5l8lq7QfuuWTvz8nLlNQ==
X-CSE-MsgGUID: eY0dzG6IQ5yN7+/Y0bxu+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90364592"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="90364592"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 04:56:08 -0700
X-CSE-ConnectionGUID: NVcUaV5JR2uhzfbWs3VP/A==
X-CSE-MsgGUID: HTp35B15ThmgncLGNMhYZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="273759251"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 04:56:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 04:56:07 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 04:56:07 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.10) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 04:56:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIeRRXnj6zC3FefHHzgpAsmEJHMQBcoCoMaFWPnozB4/DAqMfjQpGFXDoGfSXihwu6VTU2NxkoCYYN6TvX7+a85n/0tgZ6/MsG4wX/Y3tVbvLO2FAkHxdwduTo/YTAqHu+NJowwwcMlcfa8YNcTEQrU3lUfcyNSB1p+4cELIzwF1qR8ZPfZ+wYrukQcyhBTs+cvu4wLn9OmRxzLgrly9KVCMuaI5d7xA5bN92Hvkqpe398nwlE35ZJ0rDOzNqTOvafHWng55DJRTwgUe+dP9YtHYNEcrKPwz1FLVQud/tEniLAnlN036g7jD/HsPW8gPeYTH0sfzNmtrWqDRHEq/3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yETfNp+a6qIo6bomko2BdShJmEjkq8evIBIl2UQ+Lt8=;
 b=eXh3doCn7zRkVLYoL9zIM0NW1iC0TYe2wXeynJZS9jW0xF566sS8bD6mklnNgRy+Jo5cfxpUe2fXySNnyxhR0eI6Lc4N1AkDWjgMhN/j6uzHxCrIxlUMp/0T1WzsPLZXwMJxq7ytAmYpsJD6VDKolwA0w1D/k4bYzkd/uNTqhfaIt/X0XTS3OnR3ToIZMbagusPjzZ5oMSJmbRZsp1xqQV7ItaHsqKiY2uAGyOyFHQxigcwpwRm/iCHBLwLUyrf5iRwZUok4BK1njujw5mOGzmnNlXu6ae0Vtx0POhGpDS/kLqR5GgEy2BmpRjNUmJW0GotobFQV+Et/zUFSGohhLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by SN7PR11MB6704.namprd11.prod.outlook.com (2603:10b6:806:267::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 11:55:57 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0451.026; Wed, 30 Sep 2026
 11:55:56 +0000
Message-ID: <e917c70b-a0db-4c5d-8fa0-219ee77b49ea@intel.com>
Date: Wed, 30 Sep 2026 13:55:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 0/6] ice: fix stats array overflow via proper
 realloc
To: <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Michal Schmidt <mschmidt@redhat.com>,
 <intel-wired-lan@lists.osuosl.org>, <edumazet@google.com>,
 <horms@kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>
References: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P194CA0021.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::27) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|SN7PR11MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: d7bb47dd-d110-48e5-3914-08df1ee9c952
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: QSsgN7lRqrAodiwlWx3e+y4H/pozMG7NOxHWhipSMRNOWKQ/n7QWOpRUoqErQCaM2UWm7U1E2xWvYQEOVLl2VcFp1HRNLjrvaIMOBIyEG6Rkj6Wc+MFI4Gu8rNgHTxPwIQXY/HftW9JKqsCDO+HX9Ukc76lnGodj3JAz8H2Ap8oiSaKxz753lea7EKx/OZIJscYLSErsxlvniVHBhbrInaYtm/0GcFnhgQqX3riJOTzn3sc3awMcVNQeur8dPiR3rqRpG7+MvQazFT8FDnPqCc8VaSBwfgPOX0uhC9gX6sWGutQDXTofsY9dqzaD4FAC0YTm0ZIVjQiWIx9pIm3BXR626MsBdEzg2lML6846Lgq98hvJnou8lamivPKbaePMrIUtrLDIvizECfyghDl4wjUeuGRujZMPqf3veD+2SYnWe1jHYd5OsizVRYnBwPVu/47dKCKmxME/XGmJPi3JlXHneshT9lI6uBX8+k7Bus80lznxbv+HstLqk/3YbCM0RdCIuiMWh57w4JF86w4/0KUoP2ej6EHuBx2AOiH9OZpJueax3InRdfUn9S4Sbc1Mlh6OospCFYafBN5kKIJm6mEEyFBZHz51oDgEWAu5URY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zlc1bVE3VmxiVnJpUFoyaDViMmdIUmlXd3pMUlo1MEZDaTl3V01pYW44WVRQ?=
 =?utf-8?B?OG5xWGhFNTlvRXB3czlFMU9MdzRmaFE1bmphWEJ0RGpDT1d6QzZVLzVRbXpS?=
 =?utf-8?B?Nk1aSmIramMvYmo0TzBsN1FINzFuK0IwTVBZRGNUSDVERnFtVFFPUklENnpH?=
 =?utf-8?B?QlhLM2hQTHpVUGU4N0xBZUNyeGtyV21OZnJYVG9oRGlkSElHV1dna25EYzk2?=
 =?utf-8?B?OE5vNDViNG5LWkFNT25aU1ZiY3BHWGY0UzhvWGdUTHQvK0RFQ0w2cmRaVXd3?=
 =?utf-8?B?WW04cmFETkNhTGcyOGxuMVNHMnRBVWRoSWFpR3JTLzNPMmUxUXUvaS9ZWEtn?=
 =?utf-8?B?dGNZLzV2OWkwUHFXYmxmbVZyQ0hpdG9zMVZpMnpxcWpZRmoxK1dybjlUNHJ3?=
 =?utf-8?B?bXJBYVN1dks1VG9CeW5xNlk2ZGxPNUpnYlBic2dtcVJCS2hYdmJPSG9qbU9h?=
 =?utf-8?B?Q0l6aFh4cnkvQVhEMjBrQ244R3JWTm11aWl3cGxwNkkrQ1kvUi81MGppZHlh?=
 =?utf-8?B?TFpVYlVhM1ZNeDV5SitTK1JSak8yNmEyREpEM2NrWmlELy9VRmkvbkIrZUV5?=
 =?utf-8?B?cjBPczk0dE5seEZld3c3NG5zNjJRNG40UDBCaWQ5d0tySERlMERYUVhuVDhH?=
 =?utf-8?B?Mm5tS2ZkRmNUcU83cnRiUmJwcFc3a3pLZGo5VXJzekx0cjFaNmlLZHJ1djhW?=
 =?utf-8?B?eEdkSmtxczBqUFZSUUhzdGIyaFBybVA3bk9aQVZoSHVDbEFGYmZvN0IxWXky?=
 =?utf-8?B?cmpDZXMxc1JaTitXeW5vWThFczcwV3RXc2xDMG5LdTVlaHFBNkFOcTNuYU8w?=
 =?utf-8?B?NVVFaXZVazJheU1id09vUnNWU2hrMjVxUU1MVmk1TEd6QnFFN2lyYWxoODJH?=
 =?utf-8?B?TmlPOWMrRzVmSTJwc29vendsOEhaRUl6WkkxVytINEE5L1NzMVl6dVpyRnFm?=
 =?utf-8?B?TGF2Z29qdWJCYWRnWnZHdkpBaGQ5cld6ZHZuQTdBSy8raWJiRUVqTEVJVUov?=
 =?utf-8?B?OVdkSHRNc3lKblhVTnFFUnJSSUpRK1FleUIwaUtETk9SWTRzdWxabVpOWWVq?=
 =?utf-8?B?N3VZbkRrYUpvaElsa3JPMWQ1T3k2WVJWTldtby9Say8vWDhNOWtQUlRtM29F?=
 =?utf-8?B?V0lObHFydnB6TWVwaVhESVVKejVlTjkyd0owMFBZV2puNGlNQUxJWlc3YVJ0?=
 =?utf-8?B?NGJXS0owZmFJcnRmVkhVcTN4WURmYm9leU4rQUNOc2dGUWRFazFoenl5SDB1?=
 =?utf-8?B?Y0hRZ1dDMkd1eXloay9hVFg1czdKWWZxM3VpNDZ4akJqSy9jTXZvd2dWblp5?=
 =?utf-8?B?R1ZYSmc5amxQZi9YZ0dVNGN1citKM3ZMQ01vcjkvTTNpelU5QmpjaHBZVXBt?=
 =?utf-8?B?TC9XZzFsaHZlUUoyanZkaGI5ekI2SXNxME81UkhCUWo4TVFEejB1dTRLWUJ6?=
 =?utf-8?B?bS9qUFpxNjJYSkQxUHpTYlllQko5ZWkyQ0NRN01kUE1kZERZdHhHQmdxMWsw?=
 =?utf-8?B?SGJUUEx1d2tSQnM5NUZWdnRpb2tCaU1VYjErSFJSZjRCOExWeVduT2lXKzhl?=
 =?utf-8?B?SVZMTERCOGE4MUgrbEVsT0phekJkd2Z0ck5lYzNhOGhadEFRZVViVU0rQlVH?=
 =?utf-8?B?a1UwcFdnUVFzdWs3TW92SW1FSXpGT2YzT0xNRDNvSjhJRXlkL2l5WkY5d2hv?=
 =?utf-8?B?Q1VEL0IzSnprNmZySGRqZE9WZzlIQ1h0eVk4b1BpeHl4dlgyVzU5dHluSVFN?=
 =?utf-8?B?Z3NEcTJuNisxQTJSaWl3REx3UklFZVd2dEU0Q0dTRWJnUnMrTWNhS045V2gz?=
 =?utf-8?B?WFErSTVmVi9NUW5uQlhrSkhHaUhIbzVDdEV4UDRHY2d4UVhMRlZqOUJ2MStM?=
 =?utf-8?B?V0p2aHY1eEV5MzBnalQ2MHhSd2o0QkZHYWw1czQzbDdldlcwSi9YR1JNYWhu?=
 =?utf-8?B?ZG5UcTV0cXRTRk1acXo5Q3pzNTg0cHNrTzlzeUxFUVpXaFJOd3lYOE5uNkly?=
 =?utf-8?B?VDhYdTYzZTBTWkhva2ptb1dyMlFCbWlwTTllMlB4OEVoM1pUS0xPa0p1VWZp?=
 =?utf-8?B?cG1yRGVZM0dqd2dOSHVHdk9uT3ozRjJGWklvS0pCWGw5bEtPSW9zWmVENmRa?=
 =?utf-8?B?V2d5d2E4SDNsV3lQUm5lZjgvcDVEaXorKytWcVFuNGZzYnFEcVhyZjJiSVlz?=
 =?utf-8?B?WkFLMXVxKzA2NktFeFdGVjZYKzQ3b2d5eSsvdHkzLy9RNFJYRzh1bHBicU16?=
 =?utf-8?B?VGhBZGI0bzhJNXRtUTduMHp4TUxUTmlGL3VIc29YWmFGZU5IR1VlT0owdG8y?=
 =?utf-8?B?azQrSkdsMXgzU0dOaXZid2VhSldjTE02ZjNKTE42Rm1NMDlRYS9Kd09WSGRr?=
 =?utf-8?Q?SNoJYlkSyaKHDwyg=3D?=
X-Exchange-RoutingPolicyChecked: BDKrY4rlWdRP44Kz8WYhDU0mapwX1vtycP6J5TM5iSz9q2RnFab7UY2y572WWjNBClrdBbJHrrKf51Ek6uMgbSUYur9DNmpz98kH3+5/Y5MjcQ+K5PLNbksVQ6qK6QC2V1I4Qd//PHBk0QpfNPCnsASIozyIT6iwtMNBfkU8f32E9QIrMtTMtAcjOcrxcRAQVlfeBDhTx18dqfufIOs0bOFxkXzzWSp7wQbU58K88WuUvNYUW4G02ZwpExMuDiQU1BICeRWWHq551E/5lg0h4xtprXHKNPJI+vmr7tFqN2ZyGV344rHNwRD/qzn62XcXlowM/3E4wE2nu8LBf3FrGg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d7bb47dd-d110-48e5-3914-08df1ee9c952
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 11:55:56.4829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KGJvzlAX2tO4zjce5pbpUEmgbs0GzPvFWNA8P9azohpLfw5I5FDa8M4BuzifYNrAgx6kVptiERzFQuaRelCtmzxSZRb1J75bpru7eC1M9yE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6704
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

On 9/25/26 3:15 PM, Przemek Kitszel wrote:
> Fix OOB access to the stats arrays.
> 
> The first commit (new in v5) fixes stats code against VSI_CHNL case (ADQ).
> 
> Next three commits are simple refactors to make the rest smaller,
> the fifth one untangles the logic/lifetime of the stats array entries,
> then we have the final fix for OOB access to the stats array (combined
> for both PF and VF VSIs.
> 
> v5 handles now also the PF VSI stats resizes better, fixing devlink reload
> issue reported in v4 by Clashiko.
> 
> v0
> https://lore.kernel.org/netdev/20260520183501.3360810-3-anthony.l.nguyen@intel.com
> v2
> https://sashiko.dev/#/message/20260812204619.32253-3-przemyslaw.kitszel%40intel.com
> v4 (a resend of ~the same v3)
> https://lore.kernel.org/netdev/20260921182106.1015019-1-anthony.l.nguyen@intel.com
> 
> Most notable changes in v5 already noted in the cover letter, individual patches
> have much more notes.
> ---
> 
> 
> Przemek Kitszel (6):
>    ice: skip stats handling for channel VSIs on rebuild
>    ice: extract __ice_vsi_free_stats()
>    ice: extract ice_vsi_new_stat_arrays()
>    ice: extract ice_vsi_get_num_qs()
>    ice: rebuild ring stats arrays instead of reallocating them in place
>    ice: size ring stats arrays from the final queue count
> 
>   drivers/net/ethernet/intel/ice/ice.h     |   8 +-
>   drivers/net/ethernet/intel/ice/ice_lib.c | 343 ++++++++++++++---------
>   2 files changed, 210 insertions(+), 141 deletions(-)
> 

I've replied to all not pre-existing issues. My ask is to merge as-is.
