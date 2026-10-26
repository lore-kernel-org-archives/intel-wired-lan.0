Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76FA606A31F
	for <intel-wired-lan@archiver.kernel.org>; Mon, 26 Oct 2026 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=3gUcuvgQ;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KHeYON1d
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A21496060D;
	Mon, 26 Oct 2026 11:06:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dff4usjlh_qp; Mon, 26 Oct 2026 11:06:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C77CF60619
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793012807;
	b=inbLv/qg3bcYoNM7NqLdTlyUmylftbHm45bdodB6JUm8FuXRDCxV9Ir2bjVUIgJvgdfZ
	 x2WX6ZpwreiDOslmXd4PapaEqTYXV3FS9+PYdxUa5UPqfk6SiYuUT1OluEMJI178x/Lkk
	 MNosjU/Ib5qbK1cVIiONVpTNRoVQhrvk4X15zSTFhdsasaBkluPbPc96z9QjbARzx/Wag
	 DPawqQVAZ9lSfFU6aYZoSEikapJWmqRjvlmjuTwfhSk3tC6ibn7DZCpdft9MFmcHgBpWk
	 +yjdv/Xe6+T7tl39IsUO67EY1bqrs/ASr6QHEUOG+Iw/boHd5XA8UzgdEXpNbV4qsIQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793012807;
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
	bh=ZM7izgT3/ym73OsNBjv/feUrpl1F6OtRe+HLGo4r40E=;
	b=Qlmbn3/zOlGZ1dIkpm47mrskhDTSAqkTC9snb+VokThmPrhrNB+7xnH3S/s8W7cOHPRu
	 X/ld4SDceciGqyIwZ5T/6rhSzcqhWeRWxgEwWYz2C8ITXfthvvD1MyPBkbbrbPq1Iyr3w
	 v9E1Lq4B2bdKN8PbP9zm7owTzYjYqelJbIrBKP+vekorPaFPbBgjUitM1ZTnrMOP7YAdo
	 fe2GpSrXrk49A0raatRx0ITpyRjO9p6tJu3PhJe3q0aaTeymY9r6b/j/1r3FLkpACmxOg
	 saZao9onI1sVHjW7JTyTf4BxwsqzXbC7gG3DqrmN+ewqzU7rXEqjBbLzH+m1wFLtdUQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KHeYON1d;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793012807;
	bh=ZM7izgT3/ym73OsNBjv/feUrpl1F6OtRe+HLGo4r40E=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=3gUcuvgQKcfqlbSz5VvMgk5Te9Oms0VcZxTm0TiaEuqQesjdKq95z1J3eS0haVFVC
	 w0pLvEF73dHgausflPmMbFmc0L63EAJ9UPGDyEJFrI6NrI9W6oUkM5URPdLmD17nA2
	 pEjlavA00c8Do7X29Xgo/E5Qk3K3zZxsLM5tpdYqgOn4lvqgoVc48GgAYozDGX5yUh
	 0IVZ7BUXvRWozPSvTH7FWJpDYAo/HukYu5fAhk7LgUSfPo95Cr7bdTAxN/oHGXZFdV
	 oKGRTzZybR/r3fCoDWaKUdegYGRwq95Z/RIj8dA+aY8BRNzOo+GVZatF533VH3ESbm
	 eUlF9XdUNWgvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C77CF60619;
	Mon, 26 Oct 2026 11:06:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C6ED334
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 11:06:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 722696064B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 11:06:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Of6CJKoxz7v for <intel-wired-lan@lists.osuosl.org>;
 Mon, 26 Oct 2026 11:06:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7EAA060619
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793012805;
 b=OZDS0swc5XdgYEMS23723AQSCXMUNI//rvGNuygZd4i8R8BoAf8k0bWDrQMjFbmlXtgI
 5apGBxLZIQg72GGD9cLXLLNeU+TpAawpZavrOrnxVKZ3kYUBiVSWVc0v+ukcQAjUsO42d
 LLhlW8C8c+X4MaytkyRnRglU86fXcltsKtZkM47XmXTXdxhYvwTd95IKrgTiPNWxJrVO0
 oH55WAb3rJSM3/kbToNtJCynbedvcC0rRSggP5CjuCkYCwEshuu6w61ThF8XT+4+sYvSV
 AlUTAvbooAa7YxKUEhUTgE/8SYnbvnhrn1N9WFvvBdWeXmBcQ2UOcV7Ij/9/vQrY2Qw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793012805;
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
 bh=ZM7izgT3/ym73OsNBjv/feUrpl1F6OtRe+HLGo4r40E=;
 b=bJKK5onq3hCuF6FmSAbrvP3sasnlvN4Gt+dWoJJwgOG1noVvA8MBkVlqYbpIoOfnJUAV
 AEUS6lbPTj9jMLKdNd6nuJHcWWfw8scDDUw0sQqRlZ6iV9VfozH8HZ8g6F72Oxc1qcneb
 rGGW0DQYsBdFwwhc0apAb/aiY1sPHwAknhjvkVR0ju5yWCTNH/XWPoLN67Vrvl30/Usel
 RV+GoInT1OReOuFDgAnqJRwviYNCnLJlHmsZL+1bnaekIBEAuJHrztgH9ydW31dH4t+dv
 TzhPoHeXamUjk0BnNinRniA5OuA+8KiIFXRzuhTNGvPEdZM4NDOAxVIjRMTgB1ruqew==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KHeYON1d; 
 arc=fail smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=dima.ruinskiy@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KHeYON1d
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7EAA060619
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 11:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793012806; x=1824548806;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1qhzOs7P3GuEKv1KhlWnfEsgz3yUjwysi2r28D3+d8c=;
 b=KHeYON1dAr1lpAF6s4KAabgV7eA7PeVtiRRDuD1ZjJqXlPGA6eS3koXI
 IdO41RA/wCGI44ufTxX0o+6yR9rWowd8GKr3Bifxa9hXt7eWlliy+ph44
 YKWr7s19m54Um30s4Xj2GkF+qC8FncXs3dNgHnhsC/vVnhxvPAg2xQ97P
 6h8n4fN3sKu87EXm6BAEwp/pv/clOCQw/6FoKyG7Ae1f+8qrkje+14yMZ
 YrW6EV48jXwqdIs2Pi0FLDfDreCn5qR8orpuz5iHjTJfzoJUy6TFxwfZU
 HaBa0l/CQw4ZtJQrWBKa5IuYPHVbeKRpbL54YRCSPEcGatg5tAXzYIUMq g==;
X-CSE-ConnectionGUID: VvZyy8odQXy3eabt8Ox6Mw==
X-CSE-MsgGUID: QJxtDUdzRzetFswz4IyFcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1571160"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1571160"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 04:06:44 -0700
X-CSE-ConnectionGUID: 4MVH0cKuRRyQ3m4fhMaElg==
X-CSE-MsgGUID: z8wroVZXQH+wXNQ6H43cBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4295731"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 04:06:44 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 04:06:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 04:06:43 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.32) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 04:06:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WE0VoHx1HauQdSDUPDrDWhuyNY4ErX5Upt/4pvkwRZ8UzjoFhDmMHLNo0WSvMU1tFQPDKd58alp9gPB/LzFtcl0YrWzdy9NI1HOjawqNjVweIvrB6qq8CcZUAZdghac7l51C9rSxFTNgrCEe0EUBVdk3mCa38EVs6JKEZNUOBCe4ewK4O/xbOQWVv7+fXL+iK+3FeDNPKPgWC9GQ0jjPm4FqrfPYCWzqOs7QirMdLfZOV6xg+Q9EavUl9fMtJ5iYCyMu2TMbvNIwY6FexZZLrMXEYolkzGrDH627A3L+FUEpKA7B/2sY+pERyiH+x1HaB0ggibBLVU9025SP9ngghA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZM7izgT3/ym73OsNBjv/feUrpl1F6OtRe+HLGo4r40E=;
 b=aVgEi/+wulP5Bfvia6wis5Y24FnpzFLcq2WPcw5lwY8/+4NbgrhG0H6cgn6JS9lRCPHdmEtWj/9OZERjgxdxHX3HN/rBA0haODPtYAz3SzGyPkBq1nZ4uOJfcxsTUa6uY9jW3+yI9mBp1Bbbou/PBZl2oH9DRww2EsORtj3HYFGdyg6juhe5gB7elXrrf25evOFE0dWKmO+qXZulB74CscruyIJKy8GYtSa4ln7voefKnEdEB1KcrVci8/6u1eeZjRdXOakJGW/1HqKYBVDyKpIcmyqx1Bt2jG/0vGXT2PMzXwnnjA3I4M+OcHQ3lTms0xNEoWN4WbVM4yzXlWltuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5630.namprd11.prod.outlook.com (2603:10b6:a03:3bb::6)
 by BL3PR11MB6531.namprd11.prod.outlook.com (2603:10b6:208:38e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 11:06:40 +0000
Received: from SJ0PR11MB5630.namprd11.prod.outlook.com
 ([fe80::79de:af84:3b43:84e3]) by SJ0PR11MB5630.namprd11.prod.outlook.com
 ([fe80::79de:af84:3b43:84e3%4]) with mapi id 15.21.0546.017; Mon, 26 Oct 2026
 11:06:39 +0000
Message-ID: <77a3c7b1-fc8b-47b2-994c-de8e07b8b2d3@intel.com>
Date: Mon, 26 Oct 2026 13:06:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 1/2] igc: Fix Tx stop threshold to cover empty
 frame descriptors
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Benoit DE RANCOURT
 <b2rancourt@gmail.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "Gomes, Vinicius" <vinicius.gomes@intel.com>, "Sasha
 Neftin" <sasha.neftin@intel.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
References: <20261004152840.61222-1-b2rancourt@gmail.com>
 <20261004152840.61222-2-b2rancourt@gmail.com>
 <IA3PR11MB8986BCCFE3F96262762B5B9EE5962@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <IA3PR11MB8986BCCFE3F96262762B5B9EE5962@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0006.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::16) To SJ0PR11MB5630.namprd11.prod.outlook.com
 (2603:10b6:a03:3bb::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5630:EE_|BL3PR11MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: a286dbe0-1b9c-4b1a-c5a2-08df335135b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|56012099006|11063799006|4143699003|261022075727099003|261021121427099003|261021123027099003|10067099003|261009221727099003|261009220027099003|261009221227099003|261009223327099003|261009223027099003|261021135927099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: JUH6RN9HkHrC/cLTQR9UIeXgD44wtRdYUQztbQA0kT9iU8tQxO4mmGQas6byBxu3AzZpnYSTVaSAWxLG6Vz4GonVaTULu57nkU+sYxIwPv4+eS7HINMC2h7diJ+uUuhkkVaPmhY1GDYgKXpcDicOHzwvSJlk/mEznPT7G4x1c/ilMEPO4X9cwHu8c0R5SkcgeGOhjbPbIjJlXqpIanmop3QfnmLJaYcPFTKs+a2beM8nErh0Cp/vFLtQIou4rqt9UfCTDcNLH9Prp8fBwzAAEb0gJcFofCkeLKyxxp85MZXSv+XqDKlHEW8KfS1U7YB/EqQ+ziHhDdCrUA/x0GpDZ7fYNTbX/TIhx8okAjQbAzjpl5EFUqAtm3+SUT8DwSKVNzQXhrr4b5D2imLgT7T0pOmxt8oWFhE/ZFSjCxnfM1/90lfARNQMGGX+lsCIH3AQrMh9jyDv0ljhVhtQX64M7BMCbyc3uwBfvavEkg/Ci1gAdzpXUXUXRNym+vHhtlVX4ceWHpN6/Vy7xzJzB37c8zm+jO1cq9SozR0Q6Ka+dFDewYk1xQVbuyQwDAY1chQWgWi302RZYzecTQI9Haynu+oB4fFkEp2kiuYY0KR+64Z42jTALNque5xahrI+vdgx2tzxnKfq9ACDpFXGz8FTG6EJnl+xQMvOrbrSlgXb5Vo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5630.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(261022075727099003)(261021121427099003)(261021123027099003)(10067099003)(261009221727099003)(261009220027099003)(261009221227099003)(261009223327099003)(261009223027099003)(261021135927099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajh1ZXVWbTlycG0rWHNIM3ZsRnpRQXl0QUMrU1VNY3JpLyt3SW5kSkh2RG1u?=
 =?utf-8?B?K1J5TTl5UEZVOEx4YkpEb3JFRjlCV05Jd3hSQXBTR0ZFUC9EbitLc2xVVW0v?=
 =?utf-8?B?ZC9adGw2YWdTelB3SkVMVnd3TFc2VUUyd2ZIUzVjUkhWVTFrVlVqTzdPZDQw?=
 =?utf-8?B?aXhLdkRFcnFmRWs4WlFEOXVlR0dFbzFINXFPd0dJRENISlA4ZDViZjRNOVlk?=
 =?utf-8?B?L3ZJODZ4WGx6ck5GRVp3MVJsQ0xtcU1DSjNuRTVscmoxbklQT0pnbW8xTWtp?=
 =?utf-8?B?SEc0ZXhqazJXYkJVTFdObVRUcFYvM1NEbW5HMkZIT294ZUgrSStUTGFvZzhB?=
 =?utf-8?B?RzRNUU93N1VOMkJaTDU3SkhZTjdTWW4zdFVJZ0kwTk1jWVhYRkhrNWtBWGhj?=
 =?utf-8?B?NkJ6RUFCamNQUWQwRzN0a3lra2o2YlBsWGpuN1pYWkJ2THdEZXVBQjZkTFMv?=
 =?utf-8?B?UmMrRFpsdUI1Mm5VZ013blFOSDN4RVIyVTRUdkowREFEV2RDZzF4V3VsOENO?=
 =?utf-8?B?SGs4WTRVSlpIcnd1SjZDdWd4Z0E5NXVXVFhydVJyVjRNTmtYalYvbjVCUDAw?=
 =?utf-8?B?MHVLK0I1RTZpdU51a0FRanF2WVc1OExPbXZsOE1TUkZJdUZGeEQydDFHKzlp?=
 =?utf-8?B?SFdsTUsvanl3VlQ3b2FQemJoQ3lMUEVzRUFDczlYMURZam1MRkdvMDNGTEtD?=
 =?utf-8?B?ZDg5dkk4YjRUTk5vSkZ1M28zdW1hSnFPenBzblppTzFCeEFuM2VCQWFLMjd1?=
 =?utf-8?B?V0lwWWx3bFV6VUxONzhUQ0gvVVRid3UvNUdFNlJRdGxjazgvZmV4ZlpmbHd0?=
 =?utf-8?B?V28zODJvbm1DeHNpK0YrVEJwcjE1WkpDUGlJTTYrR25iSkxiNVZ5OU1xcXZB?=
 =?utf-8?B?OEZUQ1liTXNGMFV4TWZEL01RcFF0eU4zdExSUUgyampFVGQxU2poZjl0L09H?=
 =?utf-8?B?cmdHTnRUSEFWU2F1eUNpVlAwTGUrMlRvY2JDeW9WWFhNZ2JTWmRDR2tpYmxW?=
 =?utf-8?B?cEpnSk5NVmxRc2pQazhvZm5nM05nN1dsZWhBRG85eTlDWjZlRHhkaGd3Y0xZ?=
 =?utf-8?B?QUlQT21mQklZMnJVZjhOWlY2NGk4T0dkcnJJQXhENyt2eUdYSldpUlBOd1hN?=
 =?utf-8?B?U2F2WmprQjBLMkhFY3lsVzFBa0k5QU5FOXBsazhtRVJhc0Vyb0Y1WSttTGs4?=
 =?utf-8?B?YmphcVpjUzRBMzBtVzA3YkEwOElOekVUWGVuMVlKQmN3bEUzaG5sVTd4eTU2?=
 =?utf-8?B?WmZNZ1ZLNjQ3K2Eza2VLRlV0Q3h6MThrckdUSDBFMkdhUURwc25EU2kxMzlz?=
 =?utf-8?B?QlVWYURpVm5iekMwSnZ1anBKQjk4dVBXRWJScVpjd0ZjVDV2czFMVit4WDVp?=
 =?utf-8?B?LzVkajlqbHlPSm5KOGJmRXZ0NDk3WUJha0lhd01CMExZZytHU1JCaEMybHgz?=
 =?utf-8?B?UkZuQzV4MmNGM0NwVWd1bk92R1R2cWlKTzAwNG5nRVliRG5iRTNpMmdoRnh4?=
 =?utf-8?B?ZGxISzVYdEFZcGJSS2t2ekhRVStXVlVHVEpHOWZqNVNhb3lhTkNIdGFTdzZ5?=
 =?utf-8?B?cGJPRkxFck9XdjVNb2g1azg2ZFVZeTNYUHFPRjQ0ZmI4SzBwRTlZTUIwT3du?=
 =?utf-8?B?aHVRb04vNXJqNWVneWZyLytDRnNRYWJUOGlKdUVIbU1Za0hTTFliVWFTNUpu?=
 =?utf-8?B?NkxydllyM0VYTXFBOHJsTDF4eThVVU02SEdRMGFua2hEdUR4ak9tMFFseVVo?=
 =?utf-8?B?L2xDY2Z0THlIVnQ1eEh4TDBLN3pBVDRDV2tjdll6NFZzWnRhZndyYXFINkpN?=
 =?utf-8?B?QVdNK1lYaHhPSU83VC9vdU1VQkhFRnE0eC8wODAycEJFUFBQVUx1ZVZnYTgv?=
 =?utf-8?B?NUZsZlRZSGF1RjljQ215cFZjdEZLWURBdVhiejRsUkhGRCtKdVcxM09OUWd3?=
 =?utf-8?B?TFkwVUFpN29iN0Jid3BsNjhHOXI1WVdaR2I1VlVSUE9ESHRmY09ERnVIb3Zv?=
 =?utf-8?B?TXdLVjQ3VGV1SkRrSDZDN2FueWxoS3ZtMEZjTzdEbDZnZ2xQUkRPOEdhN2JN?=
 =?utf-8?B?aWxOemFqMStjY3JKYXp6V3F5bUExYVZ3bTRQQWZ1a2c2YmEzTitRYjZJMi8x?=
 =?utf-8?B?QjdZNzJmMVk5YlREbkIzdDVGa2cyNXRHL2lWckgxdjVHUjBJalBXelpkMzIv?=
 =?utf-8?B?Vk5yZzZidEEzdFNHeEZ3azFYMVhIV3pIN0lxODNPa2JmUEt1VEY2WjBVdmwr?=
 =?utf-8?B?SkRiRHVIU1ZhWXU3cGtyZkZvOXRTZWUrcGxIa2JxMG8yRkhybWR4UjRYSnNV?=
 =?utf-8?B?blArRTRGVWErK0RHU1M4eFB3Sk15NjgyNE16K2p4NGdUWHRMRXFUZz09?=
X-Exchange-RoutingPolicyChecked: 1HjVeGBzxqWU9nBpANG/2XFsFM/INXA0B7FSoc26xuJubAb8dWYUv0S83g2lfjMs8aJqvv7aV85Bafr6szx+mzeXjXZKl5/YxBScc+fWZyv6a9gKWAyuSr+OsQvnaQPMKWXcEOVZmapj5OUZo1Q7ULY7zZkk+Bbi0dN8QSpj7q5mOcT//85yxR0asBWUGA90DqZ9GOCl87/WMgQIJA9UqCUVCER+4ik0RfYQ11LkDBh/npn7EMFLaI6jzJOb+ayECikcrfOODutQV8v9KQPYkcZXw7aHXumCwITq+uXGJib2Lxlw3Pk7pm6CAx2a9t3NRr+Oijk9SO/vG0wfW9xVxA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a286dbe0-1b9c-4b1a-c5a2-08df335135b2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5630.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 11:06:39.9264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJgQ9XgDG59sWTaulavn0Ou8x5e/zPRuritsDYlliBlKEUzFeHV7SAylkMvLPBxVPNGQ4hpZLk3nmOXa/H+O6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6531
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
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 05/10/2026 13:22, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Benoit DE RANCOURT <b2rancourt@gmail.com>
>> Sent: Sunday, October 4, 2026 5:29 PM
>> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
>> Przemyslaw <przemyslaw.kitszel@intel.com>; intel-wired-
>> lan@lists.osuosl.org
>> Cc: netdev@vger.kernel.org; Andrew Lunn <andrew+netdev@lunn.ch>; David
>> S. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@kernel.org>;
>> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
>> Gomes, Vinicius <vinicius.gomes@intel.com>; Sasha Neftin
>> <sasha.neftin@intel.com>; linux-kernel@vger.kernel.org; Benoit DE
>> RANCOURT <b2rancourt@gmail.com>
>> Subject: [PATCH iwl-net 1/2] igc: Fix Tx stop threshold to cover empty
>> frame descriptors
>>
>> Commit db0b124f02ba ("igc: Enhance Qbv scheduling by using first flag
>> bit") raised the number of free descriptors that igc_xmit_frame_ring()
>> requires before mapping a packet from count + 3 to count + 5, to leave
>> room for the empty frame (one context and one data descriptor) that
>> may be inserted ahead of a launch time packet. DESC_NEEDED was left at
>> MAX_SKB_FRAGS + 4. igc_tx_map() uses it to stop the queue in advance,
>> and TX_WAKE_THRESHOLD is derived from it.
>>
>> A queue left running after a transmit therefore only guarantees
>> MAX_SKB_FRAGS + 4 free descriptors, while the next skb with a linear
>> part and MAX_SKB_FRAGS fragments, each fitting in one data descriptor,
>> requires MAX_SKB_FRAGS + 6. igc_xmit_frame_ring() then returns
>> NETDEV_TX_BUSY, which the queue stop logic is meant to prevent.
>>
>> With TSO this happens routinely. On an I226-V (8086:125c) running
>> 7.2.8 with MAX_SKB_FRAGS = 17, routed and locally generated TCP
>> traffic on a CPU-saturated router produced 10890 NETDEV_TX_BUSY
>> returns in three runs of 180 seconds, all for TSO skbs with 16 or 17
>> fragments, with
>> 21 or 22 free descriptors in all but 5 cases. Together with deferred
>> tail writes (xmit_more), these returns led to 25 Tx timeouts and
>> adapter resets in the same runs:
>>
>>    igc 0000:08:00.0 terra: NETDEV WATCHDOG: CPU: 1: transmit queue 2
>> timed out 5353 ms
>>    igc 0000:08:00.0 terra: Reset adapter
>>
>> The following patch addresses the lost tail write itself.
>>
>> Raise DESC_NEEDED to MAX_SKB_FRAGS + 6 to match the admission check.
>> The additional reservation is currently unconditional, including when
>> launch time is disabled; match that existing admission policy in the
>> proactive stop threshold. With MAX_SKB_FRAGS = 17, the queue is now
>> stopped below 23 free descriptors instead of 21. This also raises the
>> completion-based wake threshold from 42 to 46 free descriptors,
>> preserving the existing two-times-stop-threshold policy. Throughput
>> and latency effects were not measured.
>>
>> With this change alone, three runs of the same test on 7.2.8 produced
>> no NETDEV_TX_BUSY and no Tx timeout over 8.8M NETDEV_TX_OK returns,
>> including 613k TSO skbs with 17 fragments.
>>
>> As before commit db0b124f02ba, an skb whose linear part or fragments
>> exceed IGC_MAX_DATA_PER_TXD may still need more descriptors than
>> DESC_NEEDED accounts for.
>>
>> Fixes: db0b124f02ba ("igc: Enhance Qbv scheduling by using first flag
>> bit")
>> Cc: stable@vger.kernel.org
>> Assisted-by: LLM bpftrace
>> Signed-off-by: Benoit DE RANCOURT <b2rancourt@gmail.com>
>> ---
>>   drivers/net/ethernet/intel/igc/igc.h | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc.h
>> b/drivers/net/ethernet/intel/igc/igc.h
>> index 17f213cc93e4..f1efadbd9f74 100644
>> --- a/drivers/net/ethernet/intel/igc/igc.h
>> +++ b/drivers/net/ethernet/intel/igc/igc.h
>> @@ -575,9 +575,13 @@ enum igc_boards {
>>   #define IGC_MAX_TXD_PWR		15
>>   #define IGC_MAX_DATA_PER_TXD	BIT(IGC_MAX_TXD_PWR)
>>
>> -/* Tx Descriptors needed, worst case */
>>   #define TXD_USE_COUNT(S)	DIV_ROUND_UP((S), IGC_MAX_DATA_PER_TXD)
>> -#define DESC_NEEDED	(MAX_SKB_FRAGS + 4)
>> +
>> +/* Tx descriptor budget for a head and MAX_SKB_FRAGS fragments,
>> + * each fitting in one data descriptor: one context descriptor,
>> + * two descriptors for an optional empty frame, and two spare
>> entries.
>> + */
>> +#define DESC_NEEDED	(MAX_SKB_FRAGS + 6)
>>
>>   struct igc_rx_buffer {
>>   	union {
>>
>> base-commit: a83267db14681b3be481e02a4d5a38177507006c
>> --
>> 2.55.0
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
