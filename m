Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C28860A380F
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Nov 2026 11:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=nLNHpDAf;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VwKMOx4y;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=kvRT6WWm
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E74640CFD;
	Fri, 20 Nov 2026 11:43:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ORiTaHgcIuz8; Fri, 20 Nov 2026 11:43:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 407A240D5C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795175014;
	b=rrPiariy6PyebnVuh7aHXGBYZf189IQB7tmX7txcXp6lsc35P6h1V334bQECxg8Qvdpc
	 qYZvmhD4RqmsAldVep6X9N5usqYKY8Q52E2OduJfscx6kbQrPb52xu2u+BS1IKmndpoIU
	 NRkuK9W+XYemRFZ7zpOsilXq4i024tnbm2sYDWzvyU6sfOvK7CVkHTagWk2pLvt9ysadw
	 dohVtMG5z4TDpU69UlCGhzaOdTBAliDMU22mnPGzTZOwBdQO3iWUMK4Y83N2gqPJn2LgL
	 5BKbrmq7qJ3D5aojmxrt9kJuB5co4SDBfor/BinEl62ZrQM89zG1fVyf1jElb5oIhIA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795175014;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=2a3OuG+Hd88MnJ7jHa9NkixVD/qfjiHw4RZVLkoES0I=;
	b=tWKMDlelwXZ+1PbL7KM/ixzKuoWpZX0lWbtSK97mz/PxR/NIlo1DfOT9LlDrX7KPVhsL
	 QWJeiw0Fw4PyuBbfXk5wvbcRljM+UyU7WkiZFWdfHXiifrx76ItpbDf08udCzydNCAI1O
	 V6I1zllTcxB6z9fc6+qXHQjmoiIOi2ccD3+hIhHx2LY8K7fySd5auNCtPvyWfhGQNJ1Ug
	 RADVAE0suIKPtGjfyANXW4YNj+L2YJGkDXzzufn1HX9sn8DwvMm4YysHQxQ82WOZ+5jCx
	 3z2gra52CqkCvnIgw0lZKpkA+f48vvhQHz7h7p+oNbRQHfqagxeRMPL5FQG3CCj/1tw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795175014;
	bh=2a3OuG+Hd88MnJ7jHa9NkixVD/qfjiHw4RZVLkoES0I=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nLNHpDAfR7WA7lgDTRqK3UiAovTlFPOIQcY4jXysDKXguLIoFHX+xguxGQmQIGsQz
	 8B7jM1WWUAfUcr8MOPkrqoA21wirSfW0VxqX5djM+1UWIpl78d479icRC3vLWKSeIC
	 r64lGAidTXGBgm1OHmrc0ioEe3alANdfaG8cD4Q2xOq1yaEdXKXVii5USPHTXplm1J
	 /LAxehpTN9NmtC7W2/zPEgzUx/i3ObtjxXlzf2J/f/CCJsvXbBz9MMI1dy0COkXT9R
	 umkHFezTKIiXVCYAI7/QbB6DUgNk6wt+gRTe3PHGstbBVFKa2/YrWeAFVsiY5TcoNo
	 Ljr5fCgsGGmUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 407A240D5C;
	Fri, 20 Nov 2026 11:43:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5EA1AE52
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 11:43:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 52F2281283
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 11:43:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9tEEXYAxfFY9 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Nov 2026 11:43:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2A08D811AD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=maciej.fijalkowski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=VwKMOx4y; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=kvRT6WWm
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2A08D811AD
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 11:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795175010; x=1826711010;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=sSZ9kcwWcHAny4xzIviaHdZH4ByI09JKqbpAvWA2m0Y=;
 b=VwKMOx4yaf0Ad3ATukBYgDhwDaxlbjoz2JIcazzZqJX7R39DU3hOMVxs
 zuJo3rprIiN/moMfn9dTCmcHlqPHTS22RIBCoxdzgj0nXhbON+JH15pL9
 EG1QlKNzdewqVHbRdo0XU1Xah3xNwvIdsQ07ITTy8QnIpvuD+vBst9KPJ
 ioCgOSCaKt10gb3qt8oSSeIwjtrHcz75y5IAwl6qYx1asu9qik4SLCH7a
 5Fna5OdgulCCtc8xBYFPbXpAGVYG19+xuXqpfRrRK+ZG0pGUgM4XDyYd7
 R4kFstwoVGoRZmAWWVGczuI8CVNc+BxrXFxGOxg28BCaMWLyUNpohW1bj Q==;
X-CSE-ConnectionGUID: ULNm4cfITHuJ8P1UC7TYmg==
X-CSE-MsgGUID: 3ULA/prKRgWoRosTScmAtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4038764"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="4038764"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 03:43:27 -0800
X-CSE-ConnectionGUID: hlbjYkqDTjmNa1MoiptSmA==
X-CSE-MsgGUID: vkFKsz5HT9KAYnPC3aqz+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; d="scan'208";a="11021963"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 03:43:28 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 03:43:26 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 20 Nov 2026 03:43:26 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.9) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 03:43:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2a3OuG+Hd88MnJ7jHa9NkixVD/qfjiHw4RZVLkoES0I=;
 b=kvRT6WWm0jEsBIPx0EzCDr4fam2iTAroTJzqVogW3CxHTmMYt3Mmk9KPSWiKji+w5DRUVH5cfT1tGV0m4i32Dw+XTXvneoLfVBt4nVvIatCjMqUG1/v7RRsV/aRZ194ieihMkdy1CNiTqU3uie0T9FZv7jrqmnXbbz+Mhmxyveg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by DSVPR11MB921876.namprd11.prod.outlook.com
 (2603:10b6:8:3e9::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 11:43:19 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 11:43:19 +0000
Date: Fri, 20 Nov 2026 12:43:08 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: Magnus Karlsson <magnus.karlsson@intel.com>, <netdev@vger.kernel.org>,
 <sdf@fomichev.me>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
 <bjorn@kernel.org>, <kerneljasonxing@gmail.com>,
 <intel-wired-lan@lists.osuosl.org>, <anthony.l.nguyen@intel.com>,
 <przemyslaw.kitszel@intel.com>, <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next 1/5] xsk: add USO support for skb path
Message-ID: <awAyTCpCDrEAsHEw@boxer>
References: <20261119165340.1071525-1-magnus.karlsson@intel.com>
 <20261119165340.1071525-2-magnus.karlsson@intel.com>
 <av9EMbwng6Oc7chm@boxer>
 <CAJ8uoz1yeh1JGHBiE-jfKzzO3e4uKZu=y2qy79KVsSKga0KkgQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ8uoz1yeh1JGHBiE-jfKzzO3e4uKZu=y2qy79KVsSKga0KkgQ@mail.gmail.com>
X-ClientProxiedBy: DB9PR05CA0008.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::13) To LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|DSVPR11MB921876:EE_
X-MS-Office365-Filtering-Correlation-Id: dbc2e361-2d5c-421e-564b-08df46fb78e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|4143699003|261022113327099003|11063799006|261009223027099003|261021121427099003|261102123227099003|56012099006|261026140227099003|261022075727099003|261022115727099003|261028144727099003|261022105027099003|261026121527099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: ATlgGVTUREgYijoCo75PkVY8OG1Ru85BV6WLlykHcyvZ5TV2k99V3S/o+Zxe/TvPcQt15eg3pz1giNGXoDSCyb8jQDopI3Y54BwvnZ1afGlMSceSD+9KBT9mHsBY3SfensGNVGr9PKT3Bsw+Bpo10MZFlXsyxCBuEAs58lABgH5L0ihbqn+fxxHrHogzFK8OqduR4T6a8/6tHq/MG9AFmFbvBlseFKPvuGGZLy56IKAJifK/IiLIGZMjYMu6GpehRQRwzfG3rbLM9druWSQYbTrdzOuWhOXfzcVHGcfbDVHysPojmJwDBCNSUsi/lYTXroEdxHjOivXONGeigbfNBJ4e1wHsA4XaWpaNa++xFN8uq1np5hPRC+lKi1f0gHPIgphxFvRbXcZ7P2RG7nkEbgQYx3xcRm7Gx7zmQMUG7eloWhNF6PaMOXwTuXJjbpQTPtlPqc/5y5CHH4en6DJDRUSdfy1MNFZEp3oBKuTzlMmZBKXobyUdgRSo9QbbkDwCaZkCXYAxrLsgJjJ2D2YtZnkR/sQ9bOr0TFPdnqo4uE+gKhMfsssSGARQCakDg6FWXQvhRg3Vs3K64wCfhvF6PqCWHMHvI85twcvXfStZ4CXLXsEjScjQZ8OtVqtUrtIcOd+IIFWg9sP/eKOz38JjLs7aiYh9yGjdkLaX5XSlYp4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB868673.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(4143699003)(261022113327099003)(11063799006)(261009223027099003)(261021121427099003)(261102123227099003)(56012099006)(261026140227099003)(261022075727099003)(261022115727099003)(261028144727099003)(261022105027099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sEVSMsXSE8hg7O1FOFYOQTbJuhLy9Wy8VgLodk87Ki8i/xj4MKm53bgxtT8k?=
 =?us-ascii?Q?4eL6JtrzBHuGE3yONqPzwOdA0UNNETkxk/rYrAVw2PdU5t5nSzpWs+JkGtIl?=
 =?us-ascii?Q?EfTkAUWikgyyM7CmjlkIV0m7RyBcBT4w7ufiq82Afl8Iz8xF6NyruoFIQ1jx?=
 =?us-ascii?Q?1iauJuUTHsSGPoBh9crEWSM7PRSf+XRH7Beu4m4afSjq6/V6QLGvW9E9nSmn?=
 =?us-ascii?Q?2u8FACAM3IYhgDLXdkuLEgjMdHY6C5XsR0VVs8DZoWwuvhjeQWK3rkYRpCjm?=
 =?us-ascii?Q?wde/+VQlxf2vPAU2Uoos/Rz9mbJfwNusLaqojOj1WWZjw5geoA6+iHCZv4hQ?=
 =?us-ascii?Q?WQJaVQC2epg6rVLi9rHTRUlEYZGYOCOyUNuIL6ELYe+hnivtH8wfzGiun72j?=
 =?us-ascii?Q?N6K24ZgVfN+ns53ZMeDcOuu/KXt/ZvsVe4WS3njHeq4v8fwEQSsLT3/w52ZI?=
 =?us-ascii?Q?6nZtel/Vk2or3hYwAHlydl4O++KDfy6lTIvmI2cIxd/cNQWYC7EBNaJZ8BHR?=
 =?us-ascii?Q?97ksPT2SfGwymlDip80uSwLpIBiWRhe8ZJzo6gdBZ0SHWesu9ZRGtG8PcIsn?=
 =?us-ascii?Q?b+u8GPqTaNNSt1Hd7dfOfQRjQby26Wk09Ad7NNbFtet9g8bLK91HOFj1iMrO?=
 =?us-ascii?Q?c7zgFNqIqbMQ8wkPYqeRthhjerCP73brpJ6cJdCF1DzNZnjQcE5qEqlgsBKH?=
 =?us-ascii?Q?4JOf+gUZz3fDvQKLPLF4SsnwJE624w5WecnGu9RWh+RoGfsSXq9AG0Rz5bVd?=
 =?us-ascii?Q?vb9PUcjB/e2BXxyBl6/ERv1m4IJJPNuEDfScG7SOqNh/1NO03pjh76D4qTiZ?=
 =?us-ascii?Q?W8jser1KS+MB216z6Y5RrwY+I5pNkEi3ePfSL0Rjlz1SQGK6j0h/SkzyZfoY?=
 =?us-ascii?Q?qlEDsC2hOoTeZlVXCtn6hu3cVXS/aid6h0pKCA3JIWtvMbmL4dI0nIdQCxTU?=
 =?us-ascii?Q?vXI19suiZPwaldclroTerbnBPGjlk7nSnB/DUA/4ZGthOlfsp96NDNCs5j80?=
 =?us-ascii?Q?hH50nvcR0jrSRk+cQZMSTYC4cKMDDTEnZ1miOj+xTTiFccE/GzAgT5WFrR9y?=
 =?us-ascii?Q?YiQelvErFvwjIsOjaxG9N0PBlSotkFXGbYp+gaYHT/Jc1nmO0jyIPxZg4uEv?=
 =?us-ascii?Q?YRie66XsvA9a30S2L6e8Wlf3uIRgenLbELDPyWiGwKAlVWqkpLpbYPPjZ1b1?=
 =?us-ascii?Q?lTHxwadciotqASvRCkKvcFK6qZWrPPXzLh0QbqD8/EQHnIB6MnB2mQ8RbrH3?=
 =?us-ascii?Q?uxWEoX3EQKzxmrUOkKte3LlUyq8LiW9RPYtjXCfAL9Sx2KTb6A7iNQ7vgaMM?=
 =?us-ascii?Q?ZLjZGFDwiuQVmyezb1ZG9YS25IIZsYN4ewMbe3NAjLbjGd54zYR9DPeo1WCq?=
 =?us-ascii?Q?ps56orb8PGiaX+oS3dyeNCaSc5eFnbzzaqceHIBTdrygPNp6EeSCGSxVz3eo?=
 =?us-ascii?Q?cmvizwW5YBXmjtIkW8YJka5dUQz8Qj2ON1IkdVgcNRfQOgJbS5Kc50MLIalO?=
 =?us-ascii?Q?8EegZyUHIukrOgyx2ouRvtbOdf2C4YIba4VTp5WRR0KSoMYTz5UWBUwWP2+j?=
 =?us-ascii?Q?KlTwlPkUeIzK/I0/D4jzuThAFZ881Wkxb5q7n0onNIX+jBHGkBV2gHy6xqUm?=
 =?us-ascii?Q?o17Fs4kRMIdq7nrLJGn1KlSzvlVuJ2ciM2HQLbmVDTg7Q+tdWOafCLUDZgs3?=
 =?us-ascii?Q?mkMNPH7534O/cf1XJtf6joqZI83NlLHZz7SO52EFMQ6i1C05QWnhqptFCGqV?=
 =?us-ascii?Q?UtvBc1txgBMmd9nWwLv0hwmgCVNQh1w=3D?=
X-Exchange-RoutingPolicyChecked: WNDE+wAyCaY3n2cNs1d7mdYqYBIpYpeNrRv/kuWSgQj7BPc6aZ3WvHOQtEHlY791hcnTSWMLT48rdD8f5o1muGu7p1cfe8zhmI+fSEde1wDGnY0FpHBMfmlzg2B7LkggjZue9OOVbHglrBdAevWzWZDfJU0l4G4KdfmHpVyUqU33Iz3fWoFGb5sUSw4BB7fIiDTGm91NZjsinHYm0y2DJCwz853TW2GXLBHILPhV4YKqLHoTqU2t2BzFfww2E01lz29wbJti+heZ17fD2HotliAZ+98DMuCzDJSR07ZePQOAXHSMRSvNDsdUoMWeNi3kckmAP/YBFTzY5A57xYKX1Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc2e361-2d5c-421e-564b-08df46fb78e1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 11:43:19.0312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ioA7iE1TAWi+IFifq71kF8YFvTuKfcIKRWHDRwt++rfnrU6fLrH9heexHEycTTWRzvYfMHQI68YLis1/rl5GZlapa55rmkd7khWaXhQRqDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB921876
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

On Fri, Nov 20, 2026 at 09:55:54AM +0100, Magnus Karlsson wrote:
> On Thu, 19 Nov 2026 at 19:47, Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Thu, Nov 19, 2026 at 05:53:36PM +0100, Magnus Karlsson wrote:
> > > Add UDP Segmentation Offload (USO) to the AF_XDP Tx metadata interface
> > > and implement it for copy mode. An application submits one Ethernet
> > > frame holding a single IP and UDP header followed by the aggregate UDP
> > > payload, and the device emits a train of MTU-sized UDP datagrams.
> > >
> > > The uAPI adds the XDP_TXMD_FLAGS_USO flag and splits the reserved u32
> > > in the request part of struct xsk_tx_metadata into two u16 fields:
> > > gso_size, the UDP payload bytes per output datagram, and
> > > network_offset, the IP header offset. USO requires
> > > XDP_TXMD_FLAGS_CHECKSUM, with csum_start pointing at the UDP header,
> > > csum_offset at its checksum field and the checksum field seeded with
> > > the partial pseudoheader checksum of the aggregate packet. It cannot
> > > be combined with XDP_TXMD_FLAGS_TIMESTAMP or
> > > XDP_UMEM_TX_SW_CSUM. Launch time is supported and applies to the start
> > > of the segmented packet.
> > >
> > > The request is turned into a GSO skb of type SKB_GSO_UDP_L4. Before
> > > transmission, the headers are validated. The link layer is not parsed:
> > > the IP header starts at network_offset and its version selects
> > > unfragmented IPv4 or IPv6 without extension headers, followed by UDP.
> > > The IP and UDP lengths must describe the aggregate packet, every output
> > > datagram must fit the MTU, and the number of segments is limited to
> > > UDP_MAX_SEGMENTS. As skb drivers find L3 through the EtherType, the skb
> > > path also requires the EtherType, after any VLAN tags, to lead to the
> > > same IP header. A request that fits in one datagram is sent as an
> > > ordinary checksum offload request.
> > >
> > > network_offset is part of the uAPI because csum_start only locates L4,
> > > while segmentation also needs the start of L3: the device rewrites the
> > > IP header of every datagram and needs the L2 and L3 lengths, and on
> > > the skb path it becomes the network header. With it, the kernel does
> > > not need to understand the link layer, and the fields can be reused
> > > later. Any future tunnel segmentation extension to the uAPI could then
> > > treat network_offset as the outer L3 offset and csum_start as the
> > > inner L4 offset, adding only the outer L4 and inner L3 offsets.
> > >
> > > AF_XDP never segments these packets itself. A request that produces more
> > > than one datagram is rejected unless the bound device advertises
> > > NETIF_F_GSO_UDP_L4, and the GSO skb is passed to its driver unsegmented.
> > > As with UDP_SEGMENT sockets, how the segmentation is carried out is up
> > > to the driver. Stacked devices such as VLAN or bonding forward the
> > > packet to a lower device that may segment it in software.
> > >
> > > A new pool field, tx_uso_supported, records whether USO requests are
> > > accepted on a pool. It is set only for Ethernet devices (ARPHRD_ETHER)
> > > and is cleared when XDP_UMEM_TX_SW_CSUM is used.
> > >
> > > A USO request that fails validation is dropped: its buffers are
> > > completed and counted in tx_invalid_descs. Errors in other Tx metadata
> > > keep failing sendmsg() and leave the descriptor on the Tx ring, so the
> > > existing behaviour for non-USO requests is unchanged. A USO request
> > > that cannot be processed for lack of memory is also left on the Tx
> > > ring, and sendmsg() fails with -EAGAIN, unless part of it was already
> > > released to user space, either by an earlier call or while peeking
> > > further descriptors. That part may already have been reused, so the
> > > request is then dropped.
> > >
> > > The header validator works on a raw header copy instead of an skb, so
> > > that the zero-copy path in a later patch can reuse it. It lives in
> > > the new files net/xdp/xsk_tx_uso.c and include/net/xsk_tx_uso.h.
> > >
> > > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> >
> > Hmm - this looks good to me!
> > Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> >
> > I only had minor comments/questions.
> 
> Thanks for taking a look at this Maciej. Things that I have not
> commented on, I will fix. But please read below for some answers to
> your questions.
> 

(...)

> > > +/* On -EOVERFLOW, the packet was dropped and its descriptors were consumed and
> > > + * completed as invalid. Other errors leave the descriptor on the Tx ring for
> > > + * the application to retry.
> > > + */
> > >  static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > >                                    struct xdp_desc *desc)
> > >  {
> > > @@ -1196,13 +1282,17 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > >       if (skb && !xs->skb)
> > >               kfree_skb(skb);
> > >
> > > +     /* Too many descriptors and invalid USO requests drop the packet. Only
> > > +      * the latter can fail on the first descriptor, which is completed
> > > +      * here. Other errors are returned so that the application can retry.
> > > +      */
> > >       if (err == -EOVERFLOW) {
> > >               if (xs->skb) {
> > >                       /* Drop the packet */
> > >                       xsk_inc_num_desc(xs->skb);
> > >                       xsk_drop_skb(xs->skb);
> > >               } else {
> > > -                     xsk_cq_cancel_locked(xs->pool, 1);
> > > +                     xsk_cq_submit_addr_single_locked(xs->pool, desc);
> > >                       xs->tx->invalid_descs++;
> > >               }
> > >               xskq_cons_release(xs->tx);
> > > @@ -1279,6 +1369,28 @@ static int __xsk_generic_xmit(struct sock *sk)
> > >                       continue;
> > >               }
> > >
> > > +             if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
> > > +                     err = xsk_skb_uso(skb);
> > > +                     /* Descriptors already released to user space may be
> > > +                      * reused, so the packet can only be put back if none
> > > +                      * of them has been released. Otherwise it is dropped.
> >
> > This is the only part i don't follow.
> 
> Before we tell user-space to retry a multi-buffer packet by rewinding
> the ring, we need to make sure that none of those slots making up the
> packet have already been released to user-space. That would break the
> ring as one of those released slots might already have been filled in
> with new data by user-space.

and release can happen during desc peeking via xskq_cons_get_entries() ?

Let me speak in Sashiko words: "this was not introduced by this patch,
but... :D"

I wonder if it's correct to refresh consumer and therefore expose descs to
user space while we are in the middle of packet gathering.

Yet again, this asks for tx path rework where we first grab all descs and
only then proceed to skb build.

> 
> > > +                      */
> > > +                     if (err == -ENOMEM &&
> > > +                         xskq_cons_nb_unreleased(xs->tx) >=
> > > +                         xsk_get_num_desc(skb)) {
> > > +                             /* Tell user-space to retry the send */
> > > +                             xskq_cons_cancel_n(xs->tx, xsk_get_num_desc(skb));
> > > +                             xsk_consume_skb(skb);
> > > +                             err = -EAGAIN;
> > > +                             goto out;
> > > +                     }
> > > +                     if (err) {
> > > +                             xsk_drop_skb(skb);
> > > +                             err = 0;
> > > +                             continue;
> > > +                     }
> > > +             }
> > > +
> > >               err = xsk_skb_sw_csum(skb, xs->pool);
> > >               if (unlikely(err)) {
> > >                       xsk_drop_skb(skb);
> > > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > > index 5ec092f7cb6f..e62f3c2b3362 100644
> > > --- a/net/xdp/xsk_buff_pool.c
> > > +++ b/net/xdp/xsk_buff_pool.c
> > > @@ -1,5 +1,6 @@
> > >  // SPDX-License-Identifier: GPL-2.0
> > >
> > > +#include <linux/if_arp.h>
> > >  #include <linux/netdevice.h>
> > >  #include <net/netdev_lock.h>
> > >  #include <net/xsk_buff_pool.h>
> > > @@ -192,6 +193,8 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
> > >       err = xsk_reg_pool_at_qid(netdev, pool, queue_id);
> > >       if (err)
> > >               return err;
> > > +     pool->tx_uso_supported = !pool->tx_sw_csum &&
> > > +                              netdev->type == ARPHRD_ETHER;
> > >
> > >       if (mbuf)
> > >               pool->umem->flags |= XDP_UMEM_SG_FLAG;
> > > @@ -260,6 +263,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
> > >               goto err_unreg_xsk;
> > >       }
> > >       pool->umem->zc = true;
> > > +     pool->tx_uso_supported = false;
> >
> > I assume this will be lifted on later patch
> 
> Correct.
> 
> > >       pool->xdp_zc_max_segs = netdev->xdp_zc_max_segs;
> > >       return 0;
> > >
> > > diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> > > index 1bc42c8902f4..182cd1cccb74 100644
> > > --- a/net/xdp/xsk_queue.h
> > > +++ b/net/xdp/xsk_queue.h
> > > @@ -390,6 +390,12 @@ static inline void xskq_cons_release(struct xsk_queue *q)
> > >       q->cached_cons++;
> > >  }
> > >
> > > +/* Entries consumed locally but not yet released to the producer. */
> > > +static inline u32 xskq_cons_nb_unreleased(struct xsk_queue *q)
> > > +{
> > > +     return q->cached_cons - q->ring->consumer;
> >
> > READ_ONCE(q->ring->consumer) ?
> >
> > > +}
> > > +
> > >  static inline void xskq_cons_cancel_n(struct xsk_queue *q, u32 cnt)
> > >  {
> > >       q->cached_cons -= cnt;
> > > diff --git a/net/xdp/xsk_tx_uso.c b/net/xdp/xsk_tx_uso.c
> > > new file mode 100644
> > > index 000000000000..a7313ade1092
> > > --- /dev/null
> > > +++ b/net/xdp/xsk_tx_uso.c
> > > @@ -0,0 +1,77 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +#include <net/ip.h>
> > > +#include <net/ipv6.h>
> > > +#include <net/udp.h>
> > > +#include <net/xsk_tx_uso.h>
> > > +
> > > +/**
> > > + * xsk_tx_uso_validate - validate a kernel-owned plain UDP header
> > > + * @header: kernel-owned buffer containing at least uso->header_len bytes
> > > + * @uso: packet length and metadata offsets; receives protocol and segment count
> > > + * @mtu: maximum output IP packet length
> > > + *
> > > + * The link-layer header is not parsed. The IP header starts at network_offset
> > > + * and its version selects IPv4 or IPv6. The caller must provide a nonzero
> > > + * gso_size other than GSO_BY_FRAGS and header_len equal to transport_offset
> > > + * plus the UDP header size.
> > > + *
> > > + * Return: zero on success or a negative error code.
> > > + */
> > > +int xsk_tx_uso_validate(const void *header, struct xsk_tx_uso_info *uso,
> > > +                     u32 mtu)
> > > +{
> > > +     const struct xsk_tx_metadata *meta = &uso->metadata;
> > > +     u32 nhoff = meta->request.network_offset;
> > > +     u32 thoff = meta->request.csum_start;
> > > +     u32 udp_len, payload_len, network_len;
> > > +     const struct udphdr *uh;
> > > +     __be16 protocol;
> > > +
> > > +     if (nhoff < ETH_HLEN || thoff <= nhoff || uso->header_len < thoff ||
> > > +         uso->len < uso->header_len)
> > > +             return -EINVAL;
> > > +
> > > +     network_len = uso->len - nhoff;
> > > +     switch (((const struct iphdr *)(header + nhoff))->version) {
> > > +     case 4: {
> > > +             const struct iphdr *iph = header + nhoff;
> > > +
> > > +             if (thoff - nhoff < sizeof(*iph) ||
> > > +                 iph->ihl < 5 || iph->ihl * 4 != thoff - nhoff ||
> > > +                 ip_is_fragment(iph) ||
> > > +                 ntohs(iph->tot_len) != network_len)
> >
> > question: i keep on seeing this validation of iphdr - don't we have
> > somewhere a generic routine for that?
> 
> I tried finding one but failed. The receive path validators are all
> based on skbs and I do not want to create a fake skb in this path for
> the sake of zero-copy mode. I did look at
> skb_flow_dissect_flow_keys_basic() that can take a raw buffer as
> input. The problem with that one is that it does not validate the
> packet header thoroughly so it would not remove much code as I would
> have to do that anyway. It would only remove two lines and add ten
> more to be exact, so +8 lines and a significant increase in run-time
> as I parse it twice. Another problem is that it can run a BPF program,
> and this program could state that everything is fine with the header,
> even though it is not. I need something predictable that cannot be
> modified by user-space.
> 
> But if we could find something reusable, that would be preferred of
> course. I just could not.

I was adding something similar to BPF prog on xskxceiver side hence this
open question, I think let's leave it as is.

> 
> > > +                     return -EINVAL;
> > > +             protocol = htons(ETH_P_IP);
> > > +             uso->l4_protocol = iph->protocol;
> > > +             break;
> > > +     }
> > > +     case 6: {
> > > +             const struct ipv6hdr *ip6h = header + nhoff;
> > > +
> > > +             if (thoff - nhoff != sizeof(*ip6h) ||
> > > +                 ntohs(ip6h->payload_len) != network_len - sizeof(*ip6h))
> > > +                     return -EINVAL;
> > > +             protocol = htons(ETH_P_IPV6);
> > > +             uso->l4_protocol = ip6h->nexthdr;
> > > +             break;
> > > +     }
> > > +     default:
> > > +             return -EPROTONOSUPPORT;
> > > +     }
> > > +     uso->protocol = protocol;
> > > +     udp_len = uso->len - thoff;
> > > +     uh = header + thoff;
> > > +     if (uso->l4_protocol != IPPROTO_UDP || udp_len > U16_MAX ||
> > > +         ntohs(uh->len) != udp_len)
> > > +             return -EINVAL;
> >
> > nit: i think you should start with this validation?
> >
> > > +     payload_len = udp_len - sizeof(*uh);
> > > +     if (payload_len > meta->request.gso_size * UDP_MAX_SEGMENTS ||
> > > +         uso->header_len - nhoff +
> > > +         min_t(u32, payload_len, meta->request.gso_size) > mtu)
> > > +             return -EINVAL;
> > > +
> > > +     uso->gso_segs = max_t(u32, 1, DIV_ROUND_UP(payload_len,
> > > +                                                meta->request.gso_size));
> > > +     return 0;
> > > +}
