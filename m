Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1DB606A324
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Nov 2026 19:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=q8sxY9QX;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HvvtrFks
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1947840ACE;
	Fri, 27 Nov 2026 19:27:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tZ0BLsaoX92M; Fri, 27 Nov 2026 19:27:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1160540AD2
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795807647;
	b=AQcnlALHD/xhYsoyzpuyrekf4PXeuo6cGRnQKHDdCc95JdohJwT0l29tqAuJBeCLE1G1
	 Xq1rbr2ZJNeK4WfotwnUiacVlz721eytbVOq/ZmRBs1kw8Z0bXhXTil+elSGAPrA/Su3M
	 03dhZYG29h5ESYq6M6gK8cocHp/d3jKprEn1ar3eOT1/OHlCbYXRlX8/++//j3Om3TwB5
	 lmlQnU0emv4cREOAzbqlsWqUAjxO5FLicHl/elvaEO5+Z9AzCPDUyt27kwWI1Dpaf8XxM
	 ZWLLb0Qqg7Pyhk2ethoMGAMoZ/IfMZh6DF5FMA+amur4MJ7UCWuF2Xs4mtlpBgv1HLg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795807647;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
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
	bh=ijUO5x4kLnYhpiEZhY1vjJVWFY2Q47PgVJ31XrA2mgw=;
	b=TUug2HH+AgyrDhhjKM7BxKlwFMBYZWrqon7kvtW8GN7QsaJK3w201U0DRraXa4L7mcrv
	 nW1IfUqVqJ2+WqLrQxzqyCbg8pGyJvosIP4/V1f3J1Nd1mAns30gpz0y9BaW5IX/y5Bmc
	 d1VhnNChr4gUtpfAbmzZs+wOwifvKShP++5gG13fSo4/5ZPt3hjVpYodooFTLhZNwfeRC
	 nyUrvSoG51sCWMaNMblVmq6dlP6h8umrnytPdjnGzwYPjfCGGY4rgu9KR4Wn7XfZShrx6
	 47vm9y5E1Hg4X7w8yBKyxGOOL4rNgb92M3mg6LF2MqUm5cxbvu5cMtOjjmbtBNFvdhw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HvvtrFks;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795807647;
	bh=ijUO5x4kLnYhpiEZhY1vjJVWFY2Q47PgVJ31XrA2mgw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q8sxY9QXBrFSrrV+gSGk3vYLnhuFbTPtSzboVC75ycl5SQ1Bg2QhWPC5tdCBu/1d4
	 SVlPuPs3vqkFtUz/PVGtgrGT+Z3vnFyJ43GouufuqvmBKWrjkeE/JokpparNYlOr4C
	 FfNUTOFrQzPNBJFEYMwIPLhgHfe9/HMdTdD/au5N/CTmOGRBAyy9rS2+ETAd5npCxp
	 kT/1V/dD2oU2joaxf1bEyOzp9S7D3lPCls2xTy/aU/bnu3tUB5ro0ma3cUfz5jucmh
	 anpx15CQ9eJAhMf/UDMR4ix0Gt0iLwRTxCGK47uq/vnd+m6DakCHKHuJ+Z8Z6R2MlB
	 C1/kfJp6q0eoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1160540AD2;
	Fri, 27 Nov 2026 19:27:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C4002FE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 19:27:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 01C5A40AD2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 19:27:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LF2J5OrFX0pW for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Nov 2026 19:27:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CE5C040ACE
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=198.175.65.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=maciej.fijalkowski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=HvvtrFks
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CE5C040ACE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 19:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795807644; x=1827343644;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=G+L6DERvz5idmt3qyHlGbtxCVkaWFcT+xadA4hI3pgA=;
 b=HvvtrFksa5wfowQzjrc3MwEkrgeyeO1/wZFRfmpvObJ+vSrEZcfcdNgm
 ogSlarYznGw1unzy4lKtq4SYLk3kbv1qLEl/fuGSho1nELx7wAWMj2TAx
 hrrueIAKMlcCkVEqwcftyvJt2hyjZrKAwcF3G3011mcl9losbGiS5JRf4
 k4yaPBvqW/BTe+OuFkzOzKL2ctYbwToT8i/0CgnTwPCKl/3IO0WFXarA5
 DnXbyKcUhVe+vT+IHtXbWr3ihtHM3JsUD6g5mzWsQuaRy7qHcQ+J/8tbc
 ulhsN8o4LiMYjVJNEE/KazbqsNggJ0b9uGQY5fDQF5TYHjALO2C9f8KLM Q==;
X-CSE-ConnectionGUID: ObQQ0g1yTgaOlt9CRc23Dw==
X-CSE-MsgGUID: K/S2Cf5+Qw+ik67YF7fmYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4729034"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4729034"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 11:27:23 -0800
X-CSE-ConnectionGUID: 4U+pfDk9RFWBdjjkesqp8Q==
X-CSE-MsgGUID: xV/BL6tKRjq/jNAOUOAovA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; d="scan'208";a="13053831"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 11:27:22 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 11:27:21 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Fri, 27 Nov 2026 11:27:21 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.41)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 11:27:21 -0800
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by MW4PR11MB6738.namprd11.prod.outlook.com
 (2603:10b6:303:20c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 19:27:12 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 19:27:12 +0000
Date: Fri, 27 Nov 2026 20:26:59 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
CC: Magnus Karlsson <magnus.karlsson@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn
 <willemb@google.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan
 <shuah@kernel.org>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, "Simon
 Horman" <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Larysa Zaremba <larysa.zaremba@intel.com>, Tushar Vyavahare
 <tushar.vyavahare@intel.com>, Jason Xing <kerneljasonxing@gmail.com>,
 "Bastien Curutchet" <bastien.curutchet@bootlin.com>, Colin Ian King
 <colin.i.king@gmail.com>, <intel-wired-lan@lists.osuosl.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net 2/3] xsk: Keep the shared info of zero-copy buffers
 in kernel memory
Message-ID: <awnZgwW2z3fDj1Jx@boxer>
References: <20261127142131.3527737-1-bjorn@kernel.org>
 <20261127142131.3527737-3-bjorn@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261127142131.3527737-3-bjorn@kernel.org>
X-ClientProxiedBy: DU2PR04CA0197.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::22) To LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|MW4PR11MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b9b9f3-14f9-4620-bc28-08df4cbc6fde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|23010399003|1800799024|4143699003|261009223027099003|18002099003|6133799003|22082099003|5023799004|11063799006|10067099003|56012099006|261026121527099003|261102123227099003|261102130727099003|261021121427099003|261022105027099003|261021123027099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: WZ+3Cg81vbhm6ar/McbRqTHNy0CjbQoJeeyK68c2oZ2s3DJvMAFPO960VYeA1J09pC+uHFvK6b7scShf4y7RjinZJxq5aQu3z1nCnp5NmWlIstxduReogtGmciyuoFt1UeuvUn6s79pdjcthtGunOZtjGm6bQC3ZmTYnesZ2K1jVdPxPlX5u8ajp6aqht7I/iR2sz3ubvqQt0uPltVUFjvy1lxs9zxxbXZMEEW+0DqePUlyH8JUlpN3EcKAHDLVVh7SQ5PM4VTJHDEs4BB2Ip6Rmp4CYXrT1YjOxAHCncsBOXhaisyx5kX1hja0y8+9Z2Loa2oqjv089I8JwcnqufIPLO/LCeNoDkNglWQYYjCHbT/GIUtOK8NLTRrhcCM46JsoTVGYNIvqWZPaU9ApI63ANhYamq26+gS/klEhQytePpiivrIGYbNsaumuiLvpawolYNmtzgpawXT9rdfdHg6wBoFwoTVspdBNR9i4ZnagW67bzHbtgcc7Tk85WTQxFE/sdkPNoXl0IVb5aS+WsZ+n9z7ww6sr7qe4BtsxKdfZXHQ0zwmn1tRMD95CTkqKXQayKR9uyqIT09UaXuqu/gkgOOHW4Vu7MSzaKP7NDssspQ7jfXZDz8bK1T5Ln34d9OSRhBPcTilKTkhplfINg/98xMqUGgEhQHggQBaS3zjA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB868673.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(4143699003)(261009223027099003)(18002099003)(6133799003)(22082099003)(5023799004)(11063799006)(10067099003)(56012099006)(261026121527099003)(261102123227099003)(261102130727099003)(261021121427099003)(261022105027099003)(261021123027099003)(261028144727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Z/iuqOkk2TDsTICtKmZTTUqQUQN2FNyUez9vPAT102IxNlxZte/WA8b8HC?=
 =?iso-8859-1?Q?FoCJem3W6GvLzVRBrjZomNGbpKYm+zExoj3PAGjZaQL61+Bb4YqAQWYARr?=
 =?iso-8859-1?Q?HyGWyr3H3gHngv6sedav6n7arQFdxdQBq6BSeehfFcznCY5ygZZmTo+0fq?=
 =?iso-8859-1?Q?xqWLaWqeOTb4QcJShsnjCKdd/DHrZAXGkNxn4ZtpSQWvnc3GSdylrv8lTt?=
 =?iso-8859-1?Q?/0EtM+psjMsu6+qjCYVIAtCHdBy7yhm73/CteaD/29Gj7uSjFbxFgtWvI6?=
 =?iso-8859-1?Q?Cb+sHicij3e8H7bVBs4ba9I0eekvZZQ+rJ3TccmFVFgjf0DcvAfCa8LSEN?=
 =?iso-8859-1?Q?H1oJf0Q91VIIt8ZZQkLPyB/4kgMJcVCjxfbiUueXm2LA35q/MYsXYjNlVU?=
 =?iso-8859-1?Q?8UYM6JH1CNc3pN76reJmVOQX5bfZO5gmIcAb3eWEQzI+qGDjevKq6Mr7uH?=
 =?iso-8859-1?Q?pN7fl3h26Qpg2E8PLlOy1xzpdBU2aXc9w7bD/sn8RN7pJXT2gNZu0QDvJs?=
 =?iso-8859-1?Q?4vdbCe4fJbgPAOJjXceOpMuko57OuJAeObKvFC8Nhk79J26i4Njk/DUP9s?=
 =?iso-8859-1?Q?sme5AjpyV8Cm4M5l9y40Qq4YBfbc+ms7aDww+QAMQBnhbQq0Gz7+DpjKLJ?=
 =?iso-8859-1?Q?LGyfRvgldVCdmRWK35HMi0vS6wm+fwKWlv6XkznweEgivSzbGd5lszt0ee?=
 =?iso-8859-1?Q?FdqpF3GIUZOmBzpK/NGoy7+43Aj2Za4SpMqL/GLGEyaySI6QkUtSp+0vY+?=
 =?iso-8859-1?Q?e7qKnk3viQSdHfp29ZD+o+SlSTGRABcEX4YjuUJOlf11RvWo5v1yPzfVfd?=
 =?iso-8859-1?Q?pF4qRiGdXPf3bC6qrn6QJ6FWfHnSqtE6+I38WGb3mQPCB1oGru7RTEx1WV?=
 =?iso-8859-1?Q?j6cyeiMGbZ8xHR8DkSCbMxx8kaAv8ub1Ef87uPUyOQO3MSsjfUoWRtBc1y?=
 =?iso-8859-1?Q?VZ12O15w5zD2jglsKmfqmAodebbyk4mo+st0mOR4LT8/BE6SL4CkQPVuMM?=
 =?iso-8859-1?Q?ORzrjEyPBaLkzht/UXjf2Yz7oUNdIUvUD6Ra1ThATGuEn3w1gRo/Q7aGpd?=
 =?iso-8859-1?Q?g06ibP0D5PiGdX7B/FGU+K26Vz93tWAKSSwKNDMTCGUO+tfCzwjf+7Rypb?=
 =?iso-8859-1?Q?V1QovU5z/lTQiQHnD0seFNqd4k9nhHltwZQFXw766toDXA1G9yQDYXDLYB?=
 =?iso-8859-1?Q?jz/OcXoUBrVTIMytlFz9NzvR8fEfNYzIBKa6AmmfZ1prxemnnf7jwWGly1?=
 =?iso-8859-1?Q?Vfyzl4a9Hrbeq6ejOBnwhjXoEVncMlBIgDe7jbOOv+5C8abC4ME9LD8Nat?=
 =?iso-8859-1?Q?11j+e+6sVrnpUKyaOh+ffKJkITVfoRtfa+j7UryT21ugnptVW+01or6j78?=
 =?iso-8859-1?Q?2aoyIDl845UDQ6qo7PAm6arhtfWjrAD3+TuXrLNO6fXldp2ztiWKsQ6PqP?=
 =?iso-8859-1?Q?gljB7zEi8hk9JWiFFiW3herWWv0zkray84SXv/YNOtTdqBpqGnUNnIKmu0?=
 =?iso-8859-1?Q?3Fz8GvF7xv+RMZ/q6S69yPpVwXSAeOZNiRB2ukFMoUyNPMqx2MnInBMfTw?=
 =?iso-8859-1?Q?euaLy031FLa3hNMoKLDynpVt3Mqi/PFTOZxtxfkWTOTkZSUv9KA4iSJgLI?=
 =?iso-8859-1?Q?z3I0pgMV5AnWQNwPLIVAB9SLXPEUrhhtZxfJ1iZIpKx81QzP52pr8twFa7?=
 =?iso-8859-1?Q?1ynCY5Lf11hY7T5FZU1b8XZhZ/RtRJbtnGMYCWHwHtqYj99ra+JouokliE?=
 =?iso-8859-1?Q?3m9PIRGMPMESXQcpnx+0oBJLe0y77I2VrB6NgJ2j6LzaSZzTXJ7ZlaNHM/?=
 =?iso-8859-1?Q?LuXZMm44/gYxsZtKxXn1vGVuqqh2F0g=3D?=
X-Exchange-RoutingPolicyChecked: KEcEl3Heec6g4D85q8BGP6Kj6ypWDuHNW+E1mBQui0tEc2xEVxLhwXoXd906deDADjtLI+0zlxRsnONVSLKuGEEn+3quC8Qqg/FJnKtQv8eX3VuAXA7Rs8kCiwAriiDgOUNs6L25LzH4M/f0EojJ19pP9X9Gy525ma+wGpbdp+LwUxexqJYz8GzXa0ZPpjghmFZYMyd0kOJqRfyyaJ5Kf/qgMfVdeshBhOZvJVXcH6BV3t7UqibiUszFuwkByQWvooPjpJAyr/xaGAiZFf4lJKM5OyYyr0hAC1fGI+VWvUhKSrgqpiol3eVZoBCuFS59+iKEdY6GPsvqHdeh3Q8nkQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b9b9f3-14f9-4620-bc28-08df4cbc6fde
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 19:27:12.6001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BebmglxFY0tAajxSwXhmosqgYfAhdum9v08Log8xXtrM20wBZL7VP6XgykbzF9arsrwwN0llhN9yc+DUa4nG+7C1GUQsd4Av7/EFXQGqB0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6738
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 27, 2026 at 03:21:28PM +0100, Björn Töpel wrote:
> A packet that a driver receives in zero-copy mode over several buffers
> keeps its shared info, the fragment list and its count, in the
> tailroom of the UMEM chunk of its head. Userspace may write the UMEM
> at any time, also while the kernel walks the fragments, and a
> rewritten list or count makes the kernel read and write out of bounds.
> 
> Keep the shared info in the buffer pool, which outlives its buffers
> and the queues that point to it, and let the device write up to the
> end of the chunk. One shared info per pool is enough, as a pool builds
> one multi-buffer packet at a time. libeth read it later, at an XDP_TX
> bulk flush, which the previous patch fixes.
> 
> Multi-buffer pools now give the device the whole chunk, as
> single-buffer pools already do, and allow a larger UMEM headroom.
> bpf_xdp_adjust_tail() can grow a packet up to the end of its chunk.
> Copy mode does not change.
> 
> Found by an AI code review agent, in its review of another series.
> 
> Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
> Signed-off-by: Björn Töpel <bjorn@kernel.org>

I applied this change on top of my changes implementing xsk.py in drv-net
selftests and gave this a run, plus a patch 3/3 was adjusted to fit the
new python runner but intent stayed the same.

Test used Intel's e810 (ice) back-to-back connection, 84 cases passed 0
failed.

Tested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  include/net/xdp.h           | 32 ++++++++++++++++++++++++++------
>  include/net/xdp_sock_drv.h  | 29 +++++++++--------------------
>  include/net/xsk_buff_pool.h |  2 ++
>  net/xdp/xdp_umem.c          |  3 +--
>  net/xdp/xsk_buff_pool.c     | 17 +++++++++--------
>  5 files changed, 47 insertions(+), 36 deletions(-)
> 
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 07231adfb5f8..68dc9caacfa9 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -65,6 +65,10 @@ struct xdp_rxq_info {
>  	u32 reg_state;
>  	struct xdp_mem_info mem;
>  	u32 frag_size;
> +	/* Shared info of buffers with %XDP_FLAGS_SINFO_EXT, in the XSk buffer
> +	 * pool, set by xsk_pool_set_rxq_info().
> +	 */
> +	struct skb_shared_info *ext_sinfo;
>  } ____cacheline_aligned; /* perf critical, avoid false-sharing */
>  
>  struct xdp_txq_info {
> @@ -81,6 +85,13 @@ enum xdp_buff_flags {
>  	 * XDP program is not attached.
>  	 */
>  	XDP_FLAGS_FRAGS_UNREADABLE	= BIT(2),
> +	/* The shared info lives in &xdp_rxq_info.ext_sinfo, not at the end of
> +	 * the frame, as userspace may write the frame. The frame reserves no
> +	 * tailroom, so the data may reach its end. The pool builds one such
> +	 * buffer at a time, so a consumer that uses the shared info later
> +	 * must copy what it needs.
> +	 */
> +	XDP_FLAGS_SINFO_EXT		= BIT(3),
>  };
>  
>  struct xdp_buff {
> @@ -178,17 +189,26 @@ xdp_prepare_buff(struct xdp_buff *xdp, unsigned char *hard_start,
>  
>  /* Reserve memory area at end-of data area.
>   *
> - * This macro reserves tailroom in the XDP buffer by limiting the
> - * XDP/BPF data access to data_hard_end.  Notice same area (and size)
> - * is used for XDP_PASS, when constructing the SKB via build_skb().
> + * This reserves tailroom in the XDP buffer by limiting the XDP/BPF data
> + * access to data_hard_end.  Notice same area (and size) is used for
> + * XDP_PASS, when constructing the SKB via build_skb(). Buffers with
> + * %XDP_FLAGS_SINFO_EXT keep the shared info elsewhere and reserve none.
>   */
> -#define xdp_data_hard_end(xdp)				\
> -	((xdp)->data_hard_start + (xdp)->frame_sz -	\
> -	 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
> +static __always_inline void *xdp_data_hard_end(const struct xdp_buff *xdp)
> +{
> +	u32 tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> +
> +	if (xdp->flags & XDP_FLAGS_SINFO_EXT)
> +		tailroom = 0;
> +	return xdp->data_hard_start + xdp->frame_sz - tailroom;
> +}
>  
>  static inline struct skb_shared_info *
>  xdp_get_shared_info_from_buff(const struct xdp_buff *xdp)
>  {
> +	if (xdp->flags & XDP_FLAGS_SINFO_EXT)
> +		return xdp->rxq->ext_sinfo;
> +
>  	return (struct skb_shared_info *)xdp_data_hard_end(xdp);
>  }
>  
> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index a40ad3f90f13..fc22314e72c4 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h
> @@ -41,11 +41,6 @@ static inline u32 xsk_pool_get_headroom(struct xsk_buff_pool *pool)
>  	return XDP_PACKET_HEADROOM + pool->headroom;
>  }
>  
> -static inline u32 xsk_pool_get_tailroom(bool mbuf)
> -{
> -	return mbuf ? SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) : 0;
> -}
> -
>  static inline u32 xsk_pool_get_chunk_size(struct xsk_buff_pool *pool)
>  {
>  	return pool->chunk_size;
> @@ -56,20 +51,13 @@ static inline u32 __xsk_pool_get_rx_frame_size(struct xsk_buff_pool *pool)
>  	return xsk_pool_get_chunk_size(pool) - xsk_pool_get_headroom(pool);
>  }
>  
> +/* Device RX buffers typically come in 128-byte units. The shared info
> + * of zero-copy buffers lives in the pool, see xp_set_rxq_info(), so the
> + * device may write up to the end of the chunk.
> + */
>  static inline u32 xsk_pool_get_rx_frame_size(struct xsk_buff_pool *pool)
>  {
> -	u32 frame_size =  __xsk_pool_get_rx_frame_size(pool);
> -	struct xdp_umem *umem = pool->umem;
> -	bool mbuf;
> -
> -	/* Reserve tailroom only for zero-copy pools that opted into
> -	 * multi-buffer. The reserved area is used for skb_shared_info,
> -	 * matching the XDP core's xdp_data_hard_end() layout.
> -	 */
> -	mbuf = pool->dev && (umem->flags & XDP_UMEM_SG_FLAG);
> -	frame_size -= xsk_pool_get_tailroom(mbuf);
> -
> -	return ALIGN_DOWN(frame_size, 128);
> +	return ALIGN_DOWN(__xsk_pool_get_rx_frame_size(pool), 128);
>  }
>  
>  static inline u32 xsk_pool_get_rx_frag_step(struct xsk_buff_pool *pool)
> @@ -152,7 +140,6 @@ static inline void xsk_buff_free(struct xdp_buff *xdp)
>  		xp_free(pos);
>  	}
>  
> -	xdp_get_shared_info_from_buff(xdp)->nr_frags = 0;
>  	xdp_buff_clear_frags_flag(xdp);
>  out:
>  	xp_free(xskb);
> @@ -226,8 +213,10 @@ static inline void xsk_buff_set_size(struct xdp_buff *xdp, u32 size)
>  	xdp->data = xdp->data_hard_start + XDP_PACKET_HEADROOM;
>  	xdp->data_meta = xdp->data;
>  	xdp->data_end = xdp->data + size;
> -	/* Frags flag is cleared when the frags of a head are released */
> -	xdp->flags &= XDP_FLAGS_HAS_FRAGS;
> +	/* Frags flag is cleared when the frags of a head are released. The
> +	 * shared info flag stays, see xp_set_rxq_info().
> +	 */
> +	xdp->flags &= XDP_FLAGS_HAS_FRAGS | XDP_FLAGS_SINFO_EXT;
>  }
>  
>  static inline dma_addr_t xsk_buff_raw_get_dma(struct xsk_buff_pool *pool,
> diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> index 02e89350faf9..f43e618ae707 100644
> --- a/include/net/xsk_buff_pool.h
> +++ b/include/net/xsk_buff_pool.h
> @@ -59,6 +59,8 @@ struct xsk_buff_pool {
>  	spinlock_t rx_lock;
>  	struct list_head free_list;
>  	struct list_head xskb_list;
> +	/* Fragment list of the packet being built, out of userspace reach */
> +	struct skb_shared_info sinfo;
>  	u32 heads_cnt;
>  	u16 queue_id;
>  
> diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
> index cd8643360eb3..e78a43c3c3e9 100644
> --- a/net/xdp/xdp_umem.c
> +++ b/net/xdp/xdp_umem.c
> @@ -203,8 +203,7 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
>  	if (!unaligned_chunks && chunks_rem)
>  		return -EINVAL;
>  
> -	if (headroom > chunk_size - XDP_PACKET_HEADROOM -
> -		       SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) - 128)
> +	if (headroom > chunk_size - XDP_PACKET_HEADROOM - 128)
>  		return -EINVAL;
>  
>  	if (mr->flags & XDP_UMEM_TX_METADATA_LEN) {
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 5ec092f7cb6f..553630170229 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -125,8 +125,14 @@ void xp_set_rxq_info(struct xsk_buff_pool *pool, struct xdp_rxq_info *rxq)
>  {
>  	u32 i;
>  
> -	for (i = 0; i < pool->heads_cnt; i++)
> +	/* Userspace may write the UMEM. Keep the shared info in the pool,
> +	 * and let the device write up to the end of each chunk.
> +	 */
> +	for (i = 0; i < pool->heads_cnt; i++) {
>  		pool->heads[i].xdp.rxq = rxq;
> +		pool->heads[i].xdp.flags |= XDP_FLAGS_SINFO_EXT;
> +	}
> +	rxq->ext_sinfo = &pool->sinfo;
>  }
>  EXPORT_SYMBOL(xp_set_rxq_info);
>  
> @@ -229,12 +235,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  		segs = 1;
>  	}
>  
> -	/* open-code xsk_pool_get_rx_frame_size() as pool->dev is not
> -	 * set yet at this point; we are before getting down to driver
> -	 */
> -	frame_size = __xsk_pool_get_rx_frame_size(pool) -
> -		     xsk_pool_get_tailroom(mbuf);
> -	frame_size = ALIGN_DOWN(frame_size, 128);
> +	frame_size = xsk_pool_get_rx_frame_size(pool);
>  
>  	if (needed > frame_size * segs) {
>  		err = -EINVAL;
> @@ -629,7 +630,7 @@ struct xdp_buff *xp_alloc(struct xsk_buff_pool *pool)
>  
>  	xskb->xdp.data = xskb->xdp.data_hard_start + XDP_PACKET_HEADROOM;
>  	xskb->xdp.data_meta = xskb->xdp.data;
> -	xskb->xdp.flags &= XDP_FLAGS_HAS_FRAGS;
> +	xskb->xdp.flags &= XDP_FLAGS_HAS_FRAGS | XDP_FLAGS_SINFO_EXT;
>  
>  	if (pool->dev)
>  		xp_dma_sync_for_device(pool, xskb->dma, pool->frame_len);
> -- 
> 2.56.1
> 
