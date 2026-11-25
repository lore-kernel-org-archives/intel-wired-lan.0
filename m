Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D076606A326
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Nov 2026 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=HKHNvLIl;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bmE7iNLS;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=XH5qV0TB
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 450FD60898;
	Wed, 25 Nov 2026 14:58:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lwwI6g33M_FC; Wed, 25 Nov 2026 14:58:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A53BF6089D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795618693;
	b=LvqrmfBz3vt5VyIVSfi/xPu3C11WPvt+sF67QlPwyu6xaJF2/68Liklf/Dij0vPwjvEh
	 0tDxCfw46h8D9oW/XGPQ8SAaYGodBdqm2WCxjdj7BBiXCeJlcCeNk9pheTwpc8D9gn5Xm
	 ZBNltT7eRy6nGm0MFQ3FcEaQGTbiK7sN8PteeY5Sk69TTwX748xwUZcn2kC9Qs+XQKjx2
	 6RHntOsNCcLmxh5+oiYxvqKByvItyxrQnrjBH4pcDJoQoghAeZTy4XO7TxLl57TmaOt7S
	 aYFjbIW3Zsa9KGOBx0WFFYMiWKiT4joGQB+paEli+cjKZaX68xhyCImjL4kSbCBDOJw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795618693;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:References:
	 From:Content-Language:In-Reply-To:Content-Type:
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
	bh=iB830Ax7fI4SEC9nSZA7Ufdv+Z3MP22/Y28E4w7z7L4=;
	b=F00LPzMTLB3mMFTMc1XPOHC0x7eqJ/1qfILZQLBLy/WKq/VN1yMrW55fd3x7jeb6Zj/K
	 oBOYNUwGBMRe6Ym0x1aEjT7FMugA1i0fA/YDsOdqfP7VErrE9oAeYsxJ5sfx5KnXmkxKU
	 EHUlbEmy90N0wyEupL1TnTiTCIkpIfkD0GscyXPqoiY4OyDUI5NEwLy3zRZJUbfJVoqcP
	 5EoSveq1Srp4Hb3mxcwOrf2exUVbwh/JxoN+PtnQuBvArO6P2vIXp6UgFA/0wTczGkdkJ
	 RSJmYFlS0+26bmgJdhIHE37g5qbhjzpgq1ONbKXw1yLUsEwxjK6xN5Id9CXT0yf94yg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bmE7iNLS;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=XH5qV0TB;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795618693;
	bh=iB830Ax7fI4SEC9nSZA7Ufdv+Z3MP22/Y28E4w7z7L4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HKHNvLIlhGyLYSzpRhwDqrrv1RDi6Mpr0OzOtOA4KXiptoMqZGv3TR8u80wWhQx1K
	 YtJ2cuPiYXBJUgpDX3pNTr/RLuU4t8A5EnEAw2BSnrbdmQKujBTgLee99JgetPOWlV
	 PzHZs4nIv8JJIj/wfjFj4GROBu32sk7ii8tP4q9+QWgG+BmqC/lJQr20/jFJZsjYod
	 STbS4N6BZXATi1bjejxEpVs1Qv3jBHcXAreR77307VtzQPdjoNWr7njX0KLtrB8N0H
	 N5dBR6kbZ/gT1KfLNEofBdeR0kHAffHMsICJNfbJu4Blgtp6E6rlcn7OySigol+hRr
	 KtI5TibkvxnQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A53BF6089D;
	Wed, 25 Nov 2026 14:58:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8FF711C9
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 14:58:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 816F360898
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 14:58:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UvnrCMi_3qIC for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Nov 2026 14:58:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B471460891
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=bmE7iNLS; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=XH5qV0TB
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B471460891
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 14:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795618691; x=1827154691;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uVYeb5jC7wwiVaIBlYg7SPGUfshzmvaoR7lAh1fGSYA=;
 b=bmE7iNLSDi9vQSUBnz2j0jYVs2+l85B1bhjNf3jGfa5K3UCL5+heAXsP
 rr5gkDvI+7lW7W/f+9rxHrwMoXWyDkhVpUfYkQj7exJdsYUfrvvxxKhnr
 skaleMyjwf0mdD+VHTeEGCSKol5J2pJksbxrhZqV9AH/uc8LcxtE7ox77
 6K40ZsrkNjzmp0Skay9y+BZTn3URoYXjArqeHN6bPx6PpWlPoxoXmIzoK
 pxdCfRmRukw0xFCV2t2xoWdlf/kIwKZ2i0xIswEAJfdj7k+0cG/lYzvED
 pWizSsloYjU4j3++jb1eD8op5uXuTpkLzB/euOKQHxACc6ynxq1k4L97A w==;
X-CSE-ConnectionGUID: ++U0YR4+SQW1H9mkVHBgKg==
X-CSE-MsgGUID: N4ez/DMOS/WgorrTifZXpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4358654"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4358654"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 06:41:50 -0800
X-CSE-ConnectionGUID: OmvcMIlhSaO6nS1KDVN9ag==
X-CSE-MsgGUID: tf64ZHHyTluDlKYZvZp9Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; d="scan'208";a="12098932"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 06:35:48 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 06:35:48 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 06:35:48 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.60) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 06:35:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iB830Ax7fI4SEC9nSZA7Ufdv+Z3MP22/Y28E4w7z7L4=;
 b=XH5qV0TBQb9qnyXKXJbNVzKRikIzE52tX+nGj54BeC4ET5vOFN44MTvoi+Ln6kELQ4pkJcpRw5i3gzou8fDfL982fd9IZFPdIApXgBLAzWVGbE66vZyiQ6CkL9GaurZKXFfzMu0x6WhkRM6MU/HKn4HrJT8sQDKFCJlRqIkFVg0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by PH7PR11MB5768.namprd11.prod.outlook.com (2603:10b6:510:131::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Wed, 25 Nov
 2026 14:34:11 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 14:34:11 +0000
Message-ID: <acc7f1aa-75c0-417e-914b-818a5bea74bf@intel.com>
Date: Wed, 25 Nov 2026 15:34:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ice: do not report CHECKSUM_COMPLETE when an XDP
 program is attached
To: Tianyi Gao <tianyi@cloudflare.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
CC: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Paul Greenwalt <paul.greenwalt@intel.com>, Jesse Brandeburg
 <jbrandeb@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>, Alexander Duyck
 <alexander.duyck@gmail.com>, <bpf@vger.kernel.org>,
 <kernel-team@cloudflare.com>, <tianyi.gao@linux.dev>
References: <20261125095201.98279-1-tianyi@cloudflare.com>
 <awbGK9v4k3Fh4U+H@boxer> <20261125133935.36695-1-tianyi@cloudflare.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20261125133935.36695-1-tianyi@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0219.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::14) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|PH7PR11MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: d5aaaeb9-f6cf-4212-99c7-08df4b012be7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|10067099003|5023799004|11063799006|4143699003|56012099006|261021121427099003|261102123227099003|261022105027099003|261028144727099003|261026140227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: IqmJqeuN9sFTZTWU/vJbSqm49104zDjnua7MCZSncDeyPtOUF7stUQMHW5K15BOOKPh6SV0tfJvrEwaKDr91HufSkl4Krp1S6sKgyydjEY86Mj+Ys3yOFOjCQ23pkqi82/qlCPcMERFGmMRn5/MazIN9jb9ah4ljW5xxW1dB/NLceAqrkFaC2aIJ2DjjFhPUaO8BdKDfPJym0mUTZqmjs+5dh56BYqqSIByewM2xjBTTO3ejNI511YK5bc0CuTxvenZhGJBYqp1Tq1YmdxhjKTq9EttxkpRymxWI2t7mixoVp2R0XKVheu4W2p4UyUv4BQEUXnUrjoES6c6HdfD2X3kJ8AXCAN7KDPJ+HT3BBurFR/Vj7/fl1cTLPrYECZRWaJy7CD8HfcUBCxOIWE5U50FMtXjLoaNGpRHhKhrlc9/+tzd06nveROsuHl7jS44NkCyWcrQWuf2SYdZJVNy8Nt4n19y9bJkAfXZHBmy0a7TM8XtM0bPlqzpNRZpd1FQJlXKdu2JNxGL7y+d0Z7Xp+bcTy/NgmyGGxUZLXIoXelEIRpbjp2Re49LKS+hJ4CYPdtcFPMgUsoCZs7GR5twZSa4VQ+0+XogfjIFDaqe+sVCsKxJq8ggzSOA6Dug5Xy2Usmllt5mjcqS5LOOVsy+hD9/+w4T+YywcwAQh9x+YIAc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(261021121427099003)(261102123227099003)(261022105027099003)(261028144727099003)(261026140227099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmRBbmZQWW9IUGEzMVJJNU03SXhuQVZXeTRvNnltdHlhelJ4bStpelNsa0tU?=
 =?utf-8?B?SDV4SDNNNlpVZ0pVYzRQTlpLYUdJVlJhMWFGOG1LRmJjakxjZDZ4VHQxYkVD?=
 =?utf-8?B?cnQ0T043cjZlMWxnb0c0V0JHemZ6cGdPSld1OHFCYkN5SGNzcW9Ld01EZ3BV?=
 =?utf-8?B?em5ZQ0l1RDU1d00rWmVDa211RGtxRXVYbWF0QnhsTkZyU1NFSXBzbVRFajFa?=
 =?utf-8?B?c1VneGlaZmpxc0lCenNTaWsxOHhvVFRQTUlHQzM4REVXcEFIa0wzelpsU1FW?=
 =?utf-8?B?SFNhVGlGUFNpZ3E3OXNBNm5lbG1MRW94TkhyajUvOGFiNk0yaXV3YXJOdTVz?=
 =?utf-8?B?NmZGUkdMYTNhSTMzdmZiL2RhcmIwN2xmWmNPZzk2MGNGejMyWlVaVVlmNFpi?=
 =?utf-8?B?K2s2d1hueU9nS0ZsWnlqczVXUkZQNWl6MGQwSXFkY0s5WHNPTCtiN1RMM25p?=
 =?utf-8?B?NWpCc2VBQmNoWlZwaWlrc0V6eVR5a2lJZnJmZUhCL201UVI3WmlabjBPZ2xO?=
 =?utf-8?B?SUJzd0lYQTYwS0c2MldkK1gvcFhETVVMcTZaRGtybjFmMzFyVVZ6UHhTbDA5?=
 =?utf-8?B?QzdjSGhOb3pwKzZKRm90UmZxc0s3cWRTSFNPVjlzWm1Xb1BoNUhFZkZUYkk0?=
 =?utf-8?B?RFJQMjVjL2hZcXNTL2tBUnM5WkkwalFQYngzUVFseUx1SHppUjM1MEhUYnp0?=
 =?utf-8?B?ZVBkWUpTdHc0cVBRamo4TlY5WTkzMzlQWHcrUWl5NkJFUS81K3Bqa3dPemFY?=
 =?utf-8?B?dlJGTEZxWXZKMzlCZmRyOHVEazMvSk1BaEJHeXlJczliMjZjY3YvRXhvU3Nm?=
 =?utf-8?B?UGxuSVNaR0NrN2UwM3Njb3BZTGQ2MXQ4MjgvMW13ZVBzM1o0RXY4MlROci9o?=
 =?utf-8?B?WmN6bWtFdDdSUitNYXdST3psMlcwbUVGVURuRS9wRDBYd2Fpdzd5NGZEVU5C?=
 =?utf-8?B?SkgrWWN5cUFqS0dNYWZ1Wm5NWXoxUktxNmNsN2NnSHpEV3gyRGt0UTR0TXZY?=
 =?utf-8?B?V0NCRlI1a3AvQStMQ1dwVlpDZXB0R2xWZW1iUDhaUmtVQU9qTVJvdmJROTNO?=
 =?utf-8?B?ZHpMamNVek9LTnhwcWNSOHJRc2hGOWR5UHBOeTBGMTRtc2ZTS25zYUErYnYz?=
 =?utf-8?B?cEVicHRFS3I4MFg3ZGE4M25QSGpqaC9vK1R5cnQ5R3dSWURQbU9OcTJUZ2NL?=
 =?utf-8?B?b3VvUlhXajYzdWdvcGx1eEdZU2JWZFh0YUdaa1FpRzFpeHBma1libndmbmdr?=
 =?utf-8?B?bkk1alZWWHZCM1FQSTU1V2Nrd0Y1N1ZIcTV4cUdZdUoxS244SEtBVU5UOE1a?=
 =?utf-8?B?bHh2WDVPNFBqdnN1RzVnOUF0ZmF6UVpWb2NqSWlLQktreHR5UXRwV1JmZmdF?=
 =?utf-8?B?U2E3Y0NPZllINlMzUGpVbk5ZeGlQWmFqTm9yekRwTzV0VEtBN0VTeXRralJS?=
 =?utf-8?B?WVZvekVINm1HNE9tWG1MR1NhZ2pqYksvc2c1L01qbUhxdVhrRWpteUdlK1JH?=
 =?utf-8?B?d3BuanA5Z0VHMGIwUUlHMzU3V3IvWUpjaGRxOHM3SVNQcUVKUUtjZkdaOXJ4?=
 =?utf-8?B?Uzc5c1F5bUZLc0J0eWFQajUxazB4MVNZTG9lUUhOMzZmV3l1aUMrd1EzaG9S?=
 =?utf-8?B?VG1UZHVpQVF2VE1hdGVuL0c0RVl5M0dSZkhrWTNtR1BjM1pobjBQZktGdm9P?=
 =?utf-8?B?ZGIwS1RGSFZlbkJDOEpxWmxFWCszVkxDRk5IVERCelhISlR5L3BlZnFJNk9Q?=
 =?utf-8?B?ODNpT05Wc0NmeXBLV1JQbGphdTAxbHBDeVM1TVlqamlCcWtKa0RjUDB0MHZj?=
 =?utf-8?B?c1hQbGhidnJVa0RMUXNHTW05TXV3UlVyMHZqS1ROUkVud1k4dGhCMzhHTjdO?=
 =?utf-8?B?d3hpUGFpSW0rVEVhWGZJSVplN0tZem1waHVhdEd1cUE0QVFhN3doc3M0eGhF?=
 =?utf-8?B?VHBSbGhuMGR1eWc5azBaOTd2UEl5WFZYeGNuejErN3BWdThoM0paaWZsQ28y?=
 =?utf-8?B?bGpQWnlPYk1PS3gzTzdrY3pQT0dBRkpzSjFzMFB0d3lIMVVPckpoK0JtazZu?=
 =?utf-8?B?ZXR3Qk1ENFlkZ21aNzgzY2NESzBrTXNCOG1oclRhaUJOb1lwMVAzMWIvMTVJ?=
 =?utf-8?B?cWJmeEMwRHh4TkxGV2JvZDFoNzBBTGo4WmkxSDZ1TS9mOXRKQ0l5U3JLU0RY?=
 =?utf-8?B?UCtjWTZwVGJYalVUMEhNVWhHUFlSU1R4amw0OU5HN0w4czlFUjY0T3JBU0FZ?=
 =?utf-8?B?T2tGcXNsdy9FbjJpTUpUajYyajd4ek1xeXFHMUxubkQ0aEZ5NjVsTCt3VldI?=
 =?utf-8?B?Myt1UU9lMEh1clV3N1htWDBjMzgvdWl0QXFCSjZvczZsUWNuamQ2alZNWWwy?=
 =?utf-8?Q?saTAZ+F3aLnkDXZ8=3D?=
X-Exchange-RoutingPolicyChecked: DGk7pX0Y3WJj769zp3MxlN+w6Wml1zgWfKNstokrMvFTzmkO8O8FKtUO9InywYgsHAgjxIvtfzvw5aJeCkEa2jR078/G6srSXX920Ksvxh8eeBJmQbwGOMXLK3oXJbMS1P3pdKTFmCUEuoenAl5tu8wRuNmlEAmi5sYjsLdhHiadSXE3joOD7ZecYKdt4oTon5vON6xdDG7FPD99O4a0Qtj3RdlMQCBR4aFeS+XPIUqdRLijytLUTRKzi5y0JSwuD1BF4BHpKB6O274QSu2LXttjvC3rfZ26tQxpYjcZrbVQe1KBi1us8zdAJstp+8gwgv4OK3MkLt3O/wZDP+2cqA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d5aaaeb9-f6cf-4212-99c7-08df4b012be7
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 14:34:11.6015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AfOauQ1u0AFVCcEUL6iy4lx6U7kzIfA6luajFwahf7aNo9EB67ppVNsx5W7qr41EWf4sTQWhJMenolYyPwxqHW632/ySi2XeOyq4BRhMYWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5768
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_NONE,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/25/26 2:39 PM, Tianyi Gao wrote:
> On Wed, 2026-11-25 at 12:27 +0100, Maciej Fijalkowski wrote:
>> My ack was meant to say: let us get the behavior aligned to mlx5 and given
>> that there is pending work regarding checksum capabilities in XDP,
>> Alexander's concerns are meant to be addressed at -next kernel candidates.
> 
> Thanks for clarifying, and sorry for dropping it. I was not sure if the
> ack still applied after the change moved to the control path. The
> behavior in v2 is the same as in v1, aligned to mlx5. If you are fine
> with v2, could you send your Acked-by again, or could I just bring it
> back if there is a v3?

no need for a respin just for that, both of you could reply with the tag
(you already received it, so you have the power too :))

and a tag from myself, based on feedback by Maciej and Olek:
Acked-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> 
>> If code has changed *so much* why have you kept the Suggested-by tag from
>> Jesse?
> 
> The Suggested-by tag is mainly about what to fix rather than the code.
> But Jesse and I also discussed the code itself before I sent v1 and v2,
> so I kept it.
> 
> Thanks,
> Tianyi
> 

