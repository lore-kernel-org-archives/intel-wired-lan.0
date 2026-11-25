Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE506606A321
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Nov 2026 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=EGV2+K46;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kv75fHX/;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=A1mje2ia
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A293780C9A;
	Wed, 25 Nov 2026 07:43:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oqjmu_5kuMJu; Wed, 25 Nov 2026 07:43:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9F70F80CB0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795592585;
	b=DYSHK4zjFcRj1dIFlc1ke9AQgOMhtFQXVdgzuCa6NxS18EikfVdI3ircSbCcwBQlqDns
	 Ga921OLF1pYuSFDEMSdj2SKE93upT3AED82NqXoaI/tfx9Tj+FjgT2727rtSdpaM6qbxr
	 FQ8NFdHRyY6qP71kCJgU7u5NcucX8fX9miOBhBemZ2xu5ZbhtW0baAW9WLxQTSprSNXUc
	 7+qayCAvDdhfBtBcp+YzRF75MnOjzhQ3JDlCiZq8lcnfFQ4leYqcU7RzkGu9QE/6kLgGu
	 K1zOPN7nBxcxH4TAkv1pBrnTBNWaMTnQ/rc0Ay0pARo8IpPw/1CZujYieqFKNsV/mdw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795592585;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OSAsyZ7K8AdVvx0IvgIwxxj7HkfzmAAYgzja0TA9l9M=;
	b=WddmmQdNvPhWXD2hyGoQvbXgd3kIuWUo3v74zJl97MCTBUNWH+2oKbqOhYPcuGYfVPf3
	 99fk9sN4BIGXjQGMWgKtpjRXEF+a9ddGpG0kzwZw/Km+N7HqxyqFsqPtOIDR/56Z6nl2Z
	 /gnnpp2H+lGxqS6ngATnZFpIfvx+S0C1RW7ACmR3yoB+s13MJDM7uCeWHwT9DdYHQ8ndY
	 UEl9VP4nH3jIkxNWxziQ56fLU8YXQwP3/y7C5H9h+Ju4z0+qpv1d4oNLAVv0a86HEy4zj
	 bb6Z0zLSZD/vaCPbB7TliGI1MQNdne6ikdDb3fcf4CNThbSIikwCZKEgI1P+4ObtyMw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795592585;
	bh=OSAsyZ7K8AdVvx0IvgIwxxj7HkfzmAAYgzja0TA9l9M=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EGV2+K46xPCUgrNBIhNY8rcetNA5WXj5c+CKn1Hf5KVWitU7XHRwdNgExHXE+2Vgp
	 nQIPjDoFv6MMhstU9LGw41I4aF4osIQ8gHcaYYIwxI7MHLsVpAyPHLx5aRKFD//HfP
	 ldCew4s6DmDYA9//oTYx5ag6SKM36UuqcVEBr4vpNcsovJ5vZMftAu/QlkvKYd9ehO
	 IO00Zgien3c5/RSfsz49aKV2HHK3OqC9JghwmdznhO2dkZaSU4O0dY8pI8g/suU8wN
	 n6Rz0aArtH0e2/Q04PIEIWuPZANtEjdI4CuCo6XVe0ri/5AF/dZ5+SEdz+ur/bVn+o
	 Jcg9V+XqXQ8Dw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F70F80CB0;
	Wed, 25 Nov 2026 07:43:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 195741C9
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 07:43:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0A9664061A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 07:43:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lDvKYz2WC0Nx for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Nov 2026 07:43:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D0F7740609
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=dima.ruinskiy@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=kv75fHX/; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=A1mje2ia
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D0F7740609
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 07:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795592583; x=1827128583;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=H4jh2dHZJ2PCTPwex00LNkZn8oD/uK8li8jRTdUM+B0=;
 b=kv75fHX/dN2Ij/ukblbWexBEaeVdmzwQ4RvFX2aqv18W1u1CkTl6g87V
 IEpX9rHJKha3ElKtkcRQxsTfvHv9G6GaFhi2duaWGNYB7NiRnXaNv8qDS
 ybJfrY8mqEaIGqBBdFGt3gjJG/rOoducuVWgOMvVFNurhMw7dZ15ynlXl
 Lw84gRWgNYr3bYB086Vo5K8GkZXocYV/Cz7PZKhlrOhUauuQNWfnzQWtu
 WBTV4+ysai7Lw1J95NwzyDn55d8NCg668Q++0rqhJpb8insOk+G3pneJy
 l0uVqyNKc9z4QEPWR1oN7r7guUPPEIcaf8z4zWIwuKJ99mI0Dt0sWP36U Q==;
X-CSE-ConnectionGUID: i3HMY6lyRA26/UND3W1zHg==
X-CSE-MsgGUID: uY14RYT2S/G6GuF+CeCuMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4435426"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4435426"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 23:42:45 -0800
X-CSE-ConnectionGUID: lItwZTCURbGZvWqfcFUwgw==
X-CSE-MsgGUID: 7EUcMzsRQVCeHXh33pikbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; d="scan'208";a="11779636"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 23:42:31 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 23:42:30 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 23:42:30 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.54) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 23:42:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSAsyZ7K8AdVvx0IvgIwxxj7HkfzmAAYgzja0TA9l9M=;
 b=A1mje2iaqS6H/oGynetwgc8jkUn9sSJnnW4SuXPH5oujKcAZVPkxw2GlLHrvGPNNzSZBF/7gilZUAYXvEfixOrreKx1mgjxCLMTfvEb1r/6LXgjl3GO+7mqaNXo2S7JA2yYTSrenNu+mseRMzqFhVlww6Ng2ZhhsEJc/hDa/AFc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5630.namprd11.prod.outlook.com (2603:10b6:a03:3bb::6)
 by DS2PR11MB230453.namprd11.prod.outlook.com (2603:10b6:8:3c1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Wed, 25 Nov
 2026 07:42:27 +0000
Received: from SJ0PR11MB5630.namprd11.prod.outlook.com
 ([fe80::79de:af84:3b43:84e3]) by SJ0PR11MB5630.namprd11.prod.outlook.com
 ([fe80::79de:af84:3b43:84e3%4]) with mapi id 15.21.0662.001; Wed, 25 Nov 2026
 07:42:27 +0000
Message-ID: <087a9cf2-bd0a-4f57-8dcf-9b0962186fe1@intel.com>
Date: Wed, 25 Nov 2026 09:42:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] e1000e: disable K1 by default on more MTL+ systems
To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
 <intel-wired-lan@lists.osuosl.org>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: Ye Shu <hello@shuye.dev>, Vitaly Lifshits <vitaly.lifshits@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
References: <20261119001818.513503-1-acelan.kao@canonical.com>
 <20261124022233.1234651-1-acelan.kao@canonical.com>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <20261124022233.1234651-1-acelan.kao@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::12) To SJ0PR11MB5630.namprd11.prod.outlook.com
 (2603:10b6:a03:3bb::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5630:EE_|DS2PR11MB230453:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c7b87b1-be86-4dcf-b732-08df4ac7a719
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|11063799006|56012099006|4143699003|261021123027099003|261022105027099003|261022113327099003|261026121527099003|261021135927099003|261022075727099003|261021121427099003|261102123227099003|261028144727099003|261026140227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rJL5d5cB+fqJJtz3plIBaYwhP3Y+p6oInihGV3PM63NzdkwyM3f2AU5lgpAAWl6E6lnARuAKCG6gd4cq69/YrgmhSRD6m+tnDGwp1FICEEiL+dx2WqLYtcM3QMqrmbbqXyr7BaetMeg4gp6nIl8ZKIP1TWiB0JtgBpoSta7iWhIHC9U6sTyNwwGdjeGL1XDq8h0/H6ZyoApgnnk5Ap05Gyl9uSW6pbS17+bUeGa+7PrFtoFyjbkEpIQMSnaxeeZ71I6CeKFz+BN00c5XhfvsJ1zllEAkY2tMdZsNvaiXewG54UXUr+3t3LkOzf4UGBgW3DCqyy2o60dpci7f469BPY53JOH89aeVkIHkVTXajvoQkRaNyRE/NeeJ9AOAuAUC5G3or9LAquDLfBPoCTF9ig8gWMUTIkQJ/eKhFDLcS+sES5GCk4WUZ2KQQlG3YAIbnJhQ/rgUi4hOQcs02aqYXkJaiyf4Hxv/76qRs55QxAoxM22x8niuv9yzHa4PY7+h84RnDXkhxB2ClZPFhsUklJNtiUZY1HL39+atMi0D6Td6CabFqvzrbuzGeQ6UY4haq7ISLZGHNvKOKAyZlyKuirhBqgP6rXKnUVP6zHEqBxNj/VAJLD577xWt19rmGh13GRyj02SWWZ4gUnpu0pjPXDV8ZxH3sEfac8MATxNuNI4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5630.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(4143699003)(261021123027099003)(261022105027099003)(261022113327099003)(261026121527099003)(261021135927099003)(261022075727099003)(261021121427099003)(261102123227099003)(261028144727099003)(261026140227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UStzQStmRVFJdGNyMWIxb1NYc0xtTXRBM1pJRzhTcy9qcTBMOVREdFQ2NnEw?=
 =?utf-8?B?MlZHVFpkcFJPNUk0blR4SzFzTVlBSDFPSlR0N3M2M0oxcmZYNm1mR0VjVkdp?=
 =?utf-8?B?S21sKzUvSFplOUQ0WElrNU5FaVNOMi9SeWp1ejd0NitaNUxlVzFpNGZMRnMy?=
 =?utf-8?B?NHhpWEM5anAzMXpJemhBUi8va1FEZDZ3UTJTYUJqR24xV0YwWFdmbUVMN0dS?=
 =?utf-8?B?OTlpM1lZY2YwOHlRc1Z5VXpTdHk4a2tvdys2QjBBUTFYUWQ4ZWRub0d6dkww?=
 =?utf-8?B?QkhVSkVWeStScHNKaThSLzdXbTRzUVJ6bGJLcm9WQnNYZEcyeFJBU0lzZElB?=
 =?utf-8?B?VzJvY09ta0JxbmhVUVA2d2tXZkVHbUVxclZPdVF4QXZ2T1FlQmo5QTVkanh2?=
 =?utf-8?B?QU54cVZhbTZpTGR1WGN0YWI2R3djREVPbWt3NVZUMTg0bEJ0d3g0SlkwQUU3?=
 =?utf-8?B?K2ZNejk5NnlxZW9LNnFYUy9HVkx3T2lMNzN2cGpoNll5OWU0TE9LWUVvQ2pw?=
 =?utf-8?B?UmtvT21HbTFmZ1V2VmlyQXpSQmx6bVV2T3FZVTVibVdFRk5wYjZrVnp4UDRE?=
 =?utf-8?B?ZHkzWjJkQy9zcUNySlhjNVJqWHBOTDAxa1VqaEVUZ1kyZkI5Q2RUTHRyWDNR?=
 =?utf-8?B?ejQzRWU0SDI5bUxtTlVKb0d4RzUyam9QMkhuVHFYZEhKd2wzbEpyYkluYmJK?=
 =?utf-8?B?NnlKQ21WUENXUFIvc2NuRFMzN2ZZMFBpUG5nczU1S3l5cnlpL3NYQUNUR2hU?=
 =?utf-8?B?dFNjRlFpTHdFSzFLR3JSamFRTHZLOVBaL241QXBRS0tCMk1IdlREaFZmY2t5?=
 =?utf-8?B?aVgzR3VGNEtlZjdpZDJuaytCQUhKbWJHc2lDS0hyZitSYVZuY0RuZlBlNFlT?=
 =?utf-8?B?ZFhVaTVTcVpwcVB5cEYrUHJzNldYejROdlY0S0dzLytlQWJoWFIxa2p2U1Z3?=
 =?utf-8?B?aHBVMld6aFRPdzhsZGx1MzdXQWJhbWFKNXlJT0ZHRVkxSCt0elVTRWI5WmRM?=
 =?utf-8?B?NE5XZDhtQ0s1eEdQQ3hwRUJzL1piTTlPcnZHZm55MHBUaGRqRVRMYitzV0x3?=
 =?utf-8?B?NHBkWkxEZ09jYTVqNkpMT1l1c1ZwM0I3ZXcrbTNxT1puQWlkNGFOdFJlYWJm?=
 =?utf-8?B?d21FVHZFZTdpNWZxQTQvdE5nbjBrVlBzVmZhOENERFpaNEFQaXFnYWk0MU1X?=
 =?utf-8?B?czhmVk1KVmRhSTNnQXVVUEg1cW1ZYjhpTFlPNVlQTXpJUGtCa0JJSXNVOFJM?=
 =?utf-8?B?ODFBTG1FWWRvUVJFU0w5SkMxdnlLcXN6WkNsbFhyMGRvTDl3aWttM09jRWpk?=
 =?utf-8?B?ZUZHdWVPbnl3a2dtejEzaFl3T1ArUXFJWTRSTFZZelJQYWNWdlhrOTk2MnBS?=
 =?utf-8?B?RVVZUkd5N0hXaVZ3V1JFZTdrWTdKdzFnT01zZzEzK0RtQmMwZjVUekZXZHdt?=
 =?utf-8?B?WkkzTWFPdVN3S1R2S1d6eDVCalZqb1JPM1U0dm15blFTcm5WaTR3VzZaN2NL?=
 =?utf-8?B?eGFvOWIrZUpQSDNucmVxKzQyakVvZEVoT3RwanRsRS9Za2pxYlhsQzJHWGNy?=
 =?utf-8?B?L2lWU0lUVDVIaFZTVnFBakJUZ3UvMHQwUm4wSHBoUWlYT2owWnFGRW5xcE5R?=
 =?utf-8?B?eFhYRFNtaGlaUEJBbEwxNGQ1dVZxemV6RVlkU2RQT0tvRzVVUnJvRmVEbFUw?=
 =?utf-8?B?RHpDeVhyd29PMFk3Qmp4Y0FyRHYwQ2pCVmFhd0E5SlZQeS9DR0FETDBNSmFP?=
 =?utf-8?B?dzNYOTB2UzFndjhrSlZuUjRGUG1hbERPRlJsMUxONWNoR3MzTHl6c1hwTFRN?=
 =?utf-8?B?Q1lvSExZd2EyVFgzY3lXS1JpRXVHNGZoSXNUK0N5bTVOK3RZaGEyZW1CcXNq?=
 =?utf-8?B?VGlzWW90a2ZhcW1MQWdZdTZtZXY1QlJvdFZac2I5eHUrMThhbGsyd0wybFJx?=
 =?utf-8?B?NzY2QVJsWUtvcnNLQWxUN1BsZy9TMjF2UkhxQmwxR3B5aUMrbGpIZHptN2wx?=
 =?utf-8?B?UngvNXljTVI1RXhuaTBhS01maGM4aDA2Yll0b0JpUHRwMDM4MWFpRW16WmFk?=
 =?utf-8?B?YnRldndrZ3pkaVllU3hGWS93bGR5eTRLdkM0Qk1yeCtjODN6MHVkZHluNEhq?=
 =?utf-8?B?MzV0cnROQ0w0WTRCUWZzdmwxb1VWNXcwdHZ0ZjJtTHdVMnJrVFpnRks0WW04?=
 =?utf-8?B?QVpCeEJtUTZkMHhSd2s2eUNPV2oyeXZwMDllUnMvNFdaWmJsWXB2aHlQRk5x?=
 =?utf-8?B?WnNsd1NoaXY2Ry90U3ZibGhHMzlORGorVHpZNkpMeWtaeVQ5eXNEQkNTcHNW?=
 =?utf-8?B?bjZNNEEyVHF3Y1dnQjZHNG1BRzVESnppZ2hIR3JFaEQ3Vk56d1JnUT09?=
X-Exchange-RoutingPolicyChecked: n+KpOlnxWYj3weJlJcY9AJVGFfMwtKh37jMzy2DbvkmbDQPQWPlOxVQJFhjNZjI81Z7fBW1eescJHPnjK4bMxBRr48mepHtVq0uno7g4jJeJPcPK7sneHxnKFV4Dy9zZPcFPvL2bdNLlNcJrUoD6lWM8ETsVHLfgyPtLagqnXPBVliSD/OhthTt4vgZVsaRK24839jDjdCvSYhH3BdEJ/zylthAeGQUM84ohtR5v5xax3WG4/gi/lSjgnlT+6RCk4MXCW7xud+loTClxh9pkq6BnlH0LD2Uq4MZY5dnbDTy/fNH3VmaAhaU0uqwA4eIMoL9yNilIgRjlI2dDzk6mtA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7b87b1-be86-4dcf-b732-08df4ac7a719
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5630.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 07:42:27.3461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7C0ZJmSDoU6tNrMbC7o+NjKYQeElCS5vkq8FmnRexR8a2RPMa/0HiMtj1YQr26PLRZ0NFU5PYtXamJamULbKMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR11MB230453
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 24/11/2026 4:22, Chia-Lin Kao (AceLan) wrote:
> Like the Dell Pro 5 Micro P5M1260 added by the previous patch, other
> systems with an I219 on MTL or later no longer enter S0ix during
> s2idle since commit 578294b8b60d ("e1000e: Reconfigure PLL clock gate timeout and re-enable K1 on Meteor Lake").
> Every suspend ends with:
> 
>    intel_pmc_core INT33A1:00: CPU did not enter SLP_S0!!! (S0ix cnt=0)
> 
> Each unit ran 3 s2idle cycles on kernel 7.0 with the default K1
> setting and, if all of them failed to reach SLP_S0, 3 more with
> disable-k1 on. On the following systems the default cycles never
> reached SLP_S0 and the disable-k1 cycles all did:
> 
>    Dell Pro 14 PC14250                       [8086:550a, 57a0]
>    Dell Pro 3 14 P314260                     [8086:57b3]
>    Dell Pro 3 16 P316260                     [8086:57b3]
>    Dell Pro 5 14 P514260                     [8086:57b3]
>    Dell Pro 5 16 P516260                     [8086:57b3]
>    Dell Pro Max 14 MC14250                   [8086:57a0]
>    Dell Pro Max 16 MC16250                   [8086:550a]
>    Dell Pro Precision 5 14 PW514261          [8086:57b3]
>    Dell Pro Precision 5 14S PW514260         [8086:57b3]
>    Dell Pro Precision 5 16S PW516260         [8086:57b3]
>    Dell Pro Rugged 10 Tablet RA00260         [8086:550e]
>    HP ZBook 8 G1i (14/16 inch)               [8086:57a0, 57a1]
>    HP EliteBook 6 G1i (13.3/14 inch)         [8086:57a0]
>    HP EliteDesk 8 Mini G2i                   [8086:57b3]
> 
> Add these systems, matched by DMI vendor and product name, to
> disable_k1_list so K1 is disabled by default. The HP entries match
> the product family, which covers the screen size variants.
> 
> Cc: stable@vger.kernel.org
> Fixes: 578294b8b60d ("e1000e: Reconfigure PLL clock gate timeout and re-enable K1 on Meteor Lake")
> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> ---
>   drivers/net/ethernet/intel/e1000e/netdev.c | 98 ++++++++++++++++++++++
>   1 file changed, 98 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index a8f0d3c0fd750..319c7a44f5a53 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -80,6 +80,104 @@ static const struct dmi_system_id disable_k1_list[] = {
>   			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro 5 Micro P5M1260"),
>   		},
>   	},
> +	{
> +		.ident = "Dell Pro 14 PC14250",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro 14 PC14250"),
> +		},
> +	},
> +	{
> +		.ident = "Dell Pro 3 14 P314260",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro 3 14 P314260"),
> +		},
> +	},
> +	{
> +		.ident = "Dell Pro 3 16 P316260",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro 3 16 P316260"),
> +		},
> +	},
> +	{
> +		.ident = "Dell Pro 5 14 P514260",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro 5 14 P514260"),
> +		},
> +	},
> +	{
> +		.ident = "Dell Pro 5 16 P516260",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro 5 16 P516260"),
> +		},
> +	},
> +	{
> +		.ident = "Dell Pro Max 14 MC14250",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro Max 14 MC14250"),
> +		},
> +	},
> +	{
> +		.ident = "Dell Pro Max 16 MC16250",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro Max 16 MC16250"),
> +		},
> +	},
> +	{
> +		.ident = "Dell Pro Precision 5 14 PW514261",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro Precision 5 14 PW514261"),
> +		},
> +	},
> +	{
> +		.ident = "Dell Pro Precision 5 14S PW514260",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro Precision 5 14S PW514260"),
> +		},
> +	},
> +	{
> +		.ident = "Dell Pro Precision 5 16S PW516260",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro Precision 5 16S PW516260"),
> +		},
> +	},
> +	{
> +		.ident = "Dell Pro Rugged 10 Tablet RA00260",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro Rugged 10 Tablet RA00260"),
> +		},
> +	},
> +	{
> +		.ident = "HP ZBook 8 G1i",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "HP ZBook 8 G1i"),
> +		},
> +	},
> +	{
> +		.ident = "HP EliteBook 6 G1i",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook 6 G1i"),
> +		},
> +	},
> +	{
> +		.ident = "HP EliteDesk 8 Mini G2i",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteDesk 8 Mini G2i"),
> +		},
> +	},
>   	{}
>   };
>   
Hi AceLan,
Thank you for this investigation.

With a list of systems this long, covering multiple generations, this 
suggests a fundamental problem somewhere, probably not what this quirk 
is intended to solve.

Furthemore, as I said, I am not aware of the mechanism by which enabling 
K1 can prevent SLP_S0, and the GBE_D3_STS as a blocker seems 
particularly strange.

I have asked our internal validation team to investigate this, at 
priority. First I want to understand if this is limited to Dell/HP 
systems, and if so - why.

I would rather hold this off for a bit, while we investigate. Though, if 
the investigation turns out complex, we may apply this patch, at least 
temporarily, until a better solution is found.

--Dima

