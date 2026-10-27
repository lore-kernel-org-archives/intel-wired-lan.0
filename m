Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFC5606A323
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 08:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=TTaGKeiB;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Bgg4sZgC
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5A96380BE9;
	Tue, 27 Oct 2026 08:19:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UwQAfvutKWPy; Tue, 27 Oct 2026 08:19:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A4BC680C12
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793089176;
	b=DjlKqTf1uqFuRn5uJQ0x+iiXt6nZtkFnonzfHOmEEIwPe2gg1SoM8ufmEl8+TaoxRR+F
	 H6LC7D2VSJs7AX/hUDw724obyOpk/KHOygn4kHt59o51gvbNWSixSiASbvntbSMgrWVVv
	 2LH7th/xhtS1fzIzA6opG2t/yBXnblrxv7h4eWSQVqHT2DWANc+qmEmszShR+bNElmIB5
	 gUGDuvGRqCdXYbuzhqAFLiInJNcWRtcIF8W5RiLoDmWeHHFb+MfL0rSlzK+muW4Hh1sWu
	 eHLpPbLgH//fKtF1MTzD/Z8rO+A2pVl5txgb9GSaqNt1l/S45le05WnCM8LEId7PFVA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793089176;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
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
	bh=KQjj1CGn/w9dFAbHmXn1RINVeUIQ/FR2ffOF/GhrYHk=;
	b=Sx9Kj37rQzmWk5UBk5moSgiymMM5k3KnJQdx8SKh4e7++ev3GpmdbfC3ePG8Fh+8CDWo
	 zGrmRFfAqcgLpCyLpT6EJRKpZpHNnrDY9TV0YDDVDbqhLXT0B6xgBfUZU00ti7KcfccRz
	 3s+374VQsC45LRKZzDlP3imCWCDWPxW43oiVfCTot5WVL1vr/N9WF55pwzcuhPieiK9Rx
	 eeLAtsowDyyT3Sjyn4DtaEomxp9XvCLyr0I2UVQ7LV37EafkkyBAnX57Kj1l0LIwu/5N8
	 +5ucOblf5FBTtENfzRrAhr0mDTaVlu5hl2YhgDTBlL85R/3SLC9tZIPyLM6MI2NJPjA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793089176;
	bh=KQjj1CGn/w9dFAbHmXn1RINVeUIQ/FR2ffOF/GhrYHk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TTaGKeiBAM8cOqg++kj+1BfE9qXxhNF92BFOyJOuvbfKIDUvS/y2VmHlVSF+RWluS
	 TbRQNGWgz4MfHoGUtrb9dQKtgVgoP7KN1FAynU6lfC+AbrtjUZRyc0Wg/lKExpWU4p
	 04W7L19mXpvLrre8oZ/76qQxvUDMf3omeSKjNNEPkf8diyyTYwHKNhopL4PKOK7D25
	 DqDlofUltp2rvS1Utg79nBAqEBZFI19coSH2tBsFDRqDXJEMFqSG0x4O68XfVpGr0h
	 v9WTcB/WElnZwE7HbZTFnjyuqNhvlJ/lRcdafQV2/zrDiPefQgloTVjZcvtDNOde/x
	 CpaY4uCM8RF2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A4BC680C12;
	Tue, 27 Oct 2026 08:19:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AEB3E72
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 08:19:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 946C94025F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 08:19:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pUQ8pWWj0AvI for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Oct 2026 08:19:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6178240259
Authentication-Results: smtp2.osuosl.org;
 arc=fail smtp.remote-ip=192.198.163.10
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793089174;
 b=AcGMzOYUjotKU7OkSPXPlJeuwF1ULcowNdPaj9PuIi8S281j00UAjzqxTlw49x4FNKVw
 ss3ccRfUGOBvovhQQfkpsHpAk13V4uQFv768vZgzUqUVSj0MR8MjMM7hxFkb+fU85Syjx
 XRRMhs5f7NnhrFNttixAs125+x2c/qQ0HWhg+uNYXxAS+QxV5XPLbCacJJo7RtW25QKkw
 tiQm+rFM2xH5gxSrzfMN1Zlz4v6CyPFYUxrLSQT4rzPQMpzxQV/AqdHf/GMaUR4WOTR0g
 fiSzWD8ny897WJPAA3IoJdNg/Lu3xb6FffladOITuoF5wPu8m9vNj1+stAjrYQzOGMQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793089174;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
 References:Content-Type:Content-Disposition:In-Reply-To:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=KQjj1CGn/w9dFAbHmXn1RINVeUIQ/FR2ffOF/GhrYHk=;
 b=Pf1LdDYlvWt9m9sesF16J+Sqfk87nUi29oZckTCQTX2EZKVyo9hFnjYmEufwgcyE5zYX
 7wPfxYzIub6ESFSUUeWTG3ePbpyhIgBEvt1uza1Vj7f7evxdi/zPZhQnupSeUOrmYk9N0
 1oh3cKDWJDzy+BUw+2EdnW/sLHskn5Bu2wlWVyasNRrbdJuRbcORLuDphqRuackJielkG
 UfKrKCx3z9nL33KYgKnFq2DA3FJmXoSgnrG4IuwenjNCJ/2IvinUbRvHm95hUh1/TBM4Q
 MzZUTw/vBK6z/ohnUbFPpZoTho8h1B7iSHBTewsS+Kt9cBi4wV0CIZZJbOL6qSaFV3A==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Bgg4sZgC; 
 arc=fail smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=maciej.fijalkowski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Bgg4sZgC
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6178240259
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 08:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793089174; x=1824625174;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=38celaPPU/zWPBUwAeFE69dN7wI94BGufo4Em3cxBJQ=;
 b=Bgg4sZgCFHe+ijgmvTeTSaQqA7+5NcUv7YLjuAkAkv8+KyCFfC31pIcs
 bMakbDzqN9Eaid87009CxZQF1oL2MlQOgposE0E2NjjZyGWN9pYOQerQE
 oFN9YhmXkSfWYlKNHLfedE4vb6ByBkuOYGs0YA14HJBRpLNlLKiA77BWv
 HYLFDNsUmYYXB2pAeoVGolZiaev909QvMrsJA0LBA3edikLZ+tsIKs88L
 E444JpRr+g5ofnO0m2iVlHltWhxiCdotBu6UNEhRHXuQ306ehoJXA0PZT
 BW17U3Qa7Lar6eAS/GxYB5zEjAcsZl3bC98rdnvCA4GwwEY/fk/CHUx04 g==;
X-CSE-ConnectionGUID: y1pUxji/SB+t8AWWBIi0pg==
X-CSE-MsgGUID: e2DBurF9RfWF3d5rYp6u0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1686102"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1686102"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 01:19:32 -0700
X-CSE-ConnectionGUID: OV8Q7bgxSMmmuzu8RtNqNA==
X-CSE-MsgGUID: dtmjVc+dRd+SMBdvPXFGsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4997095"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 01:19:33 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 01:19:31 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 01:19:31 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.47) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 01:19:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvj83xZ1hpoPACgHmM7m4BfxYAsGdwl97zm1nJMAvlWkR2h6e19LHlRPn3vCiXzzYP7cilPw5qmveYvbKCQdPJdNLXJn8ZNk79q/odZWH+/nhjqOY/+odaSKMmTq4BvlOdkXQhAmWyZEbFXhDb/eH3SNJZ0qVp4m/P9s/s/L3Dydix8tQ/vNPphH+WiQ1BBE6nO43DRoowUS6a4jLW+i2ktPUaZ4KPjzi8FfUNVuEzd2ug/usskjkW/N1BYRn1q9Je6lM+4EUBRuQjO4zinwVrPuPjws5Cx+FAq3GYJPpume3NxUOE2qZreCV3QKeO7q29BY0V52aBmVuVW4qIsbnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQjj1CGn/w9dFAbHmXn1RINVeUIQ/FR2ffOF/GhrYHk=;
 b=wtidjHolXKrl0fJWoBZYMYcCktJezGlzboP3PKxfQLldilF6GFunaL80t//WG9bH0LP1rCYQnW8ocyLHuqQ7qPcBkry+kTOWSCzeZOnk4TJqi4H/3n+EH2E6gCcIS7mASy0vhb6Pwc8jhHHBANysIc8dpekM+CtdDvJYExsQqFf/VkQjReRYn1IubxDIz5Yqsqp80XgMI+HjYByC+LyLl6Zy6Xqq5rIoy0tMHeYGzMwESJpM1oVDbRzfuFR41pRD2KGxs8iWW2ktKmPcHCvHHyRhnpD6dcdTZvCpzT4xBMiYxxQFvpp/jq+rHd2Ly9w/BZEyXpUThyanoror26u+kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by LV2PR11MB6047.namprd11.prod.outlook.com
 (2603:10b6:408:179::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Tue, 27 Oct
 2026 08:19:25 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 08:19:25 +0000
Date: Tue, 27 Oct 2026 09:19:18 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Paul Moses <p@1g4.org>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
 <sdf@fomichev.me>, <intel-wired-lan@lists.osuosl.org>,
 <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] igc: return XSK frame copies on XDP_TX failure
Message-ID: <auBehtniOJTRGfaD@boxer>
References: <20261023141317.3904442-1-p@1g4.org> <at+yluh1NVm78gn6@boxer>
 <HTx28-b95D5R6LIxwQGHksxNXb6wWbEOp6IGCfRU51shEKudZgRxqFylE-Ngqd3ufeFJGlo5VccF1yXfAVeWQlqpNoSMp5oxS8tlJNxH4h0=@1g4.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <HTx28-b95D5R6LIxwQGHksxNXb6wWbEOp6IGCfRU51shEKudZgRxqFylE-Ngqd3ufeFJGlo5VccF1yXfAVeWQlqpNoSMp5oxS8tlJNxH4h0=@1g4.org>
X-ClientProxiedBy: DB8P191CA0022.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::32) To LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|LV2PR11MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: cd921a30-1940-4547-2ba8-08df340302f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|22082099003|18002099003|261026121527099003|11063799006|56012099006|4143699003|10067099003|261009223027099003|261022105027099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: s30dZaxcypXNGrBBcmhm/TJXP19ng/2UoJ7ztNvOL6+0N26MX+yEVOgmGdChpZavES89SJhuEGKWUdyaHYmdGDrAGVZpjeTfrwJqV8FU0/bYlzIDAVIW5nV2VUhUqhri85I8Jd2IQL2/U89N2nNj9rfYB6/tCgMJrG4cjvQN+1baB+/rz8jM0dO+il9wD2IC7HRILgyPOSh9wrmHoOBP7VgpMkxGTTOSkkbEvtfLeo+ylvyS+qxypi3zfbqiEDDiEyZj8TXnniNVj4/fa/cZGNrK4TgvcpnYIWB2i5wbJ1AVHA8ex9b9wv+rvs4jq/xnBsMD2b5I7pMFlY82TJ174Dox5Q7HqEm3x01aZUydAqOsClbIh0AT604dyJnQf8iJxmRsPSjk/Eo98gzUQeXwOpajKcQKqwV8jOfK8B9nRoKsp5XNm19CmwVyOaC8qpOzWUFDW/N8tsH2AOfpTaU4/HW7P5IG56fF95em8J7OE9mNa9fB6gYgVgurQsrTAv3jy6vWbHk8ikxH8NMaqO1O5bHWPf9eE72UqDkOnb6qk5saaFhAfZ8I2NZu9lM8Rc9fmLM2WPHoMtORpvwzfA3+Gjsn61TDnztpMMcqOagC8UjdINsKxSIanqP3tywTNrFU/2ZQp1vG0PFDJgWyknUOAzTkRyoUXqwj2QHRh9/ezXw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB868673.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(261026121527099003)(11063799006)(56012099006)(4143699003)(10067099003)(261009223027099003)(261022105027099003)(261021121427099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vebKL6TvCj9F5S+S6HSnVebTxAG55SyL31FOIxxAX58zLqsPSvk27vwEOVQz?=
 =?us-ascii?Q?Dniw3zqaF7hZxUNfGHde+KEHgAlODEhc6+qy18wiLIZwzeIU53t4jMSCOAou?=
 =?us-ascii?Q?11ATvfQdY+Jyjckhs0eUcxkGscay72U60keM9tnxbWNns/zv8E+m4PKxQPHt?=
 =?us-ascii?Q?bD6+2k5L5/rG9fNpPRPPKxZLMlCZS5EBI9Kb3LPSjf9qhJBHyM/WncgfNwdf?=
 =?us-ascii?Q?rLj17wAcuOJEarXuSlHcuHUYZDvzKT+38uTVtYDfHpV2Iz2WvgUaQ1Ba6Ccz?=
 =?us-ascii?Q?045iD5a2A9w0vbnHKxxnVUtkjhA9bVmjx1Xi7g4XnhmjY5P0Gk1mPGd1PRSi?=
 =?us-ascii?Q?yDUKA01lKxScFqAkE8rPIIZ4LvS9Xxnbvadq/kYzcHCCsUxzUXz3AwPCocqA?=
 =?us-ascii?Q?JV26hEUxu4+NnItW0NT2o/eR+7nAydjeOCt74X3QGz6uoBKSjzaWu7ur9WWj?=
 =?us-ascii?Q?KDt83Edb1Vk2bHavPQjI0km5P9q72oZqSjjb4c3ELQKWj6wxzLGLzE24E8eV?=
 =?us-ascii?Q?iytiUJJ8oIUUx/yaix1JuXmzFjZPiUOcfk0Ag248JxwW7tmjEPNrQSFj6APl?=
 =?us-ascii?Q?5mrO4AOPci2Z5ExjtwJ/P0MzLw5EQzidbGa0Zn7NV6f2szMXWNQyTtZzel7k?=
 =?us-ascii?Q?3Zrq/g8etIvvUQ2bnUE9fNx/dbEfshx6s4p0RG0nWALprZ5FqoXN+sXyWtgy?=
 =?us-ascii?Q?OOVjZSpc4zsfmBqluzG4evqb16VWzHGK+OPSVCk41NuCncs8D4CTASvDXod4?=
 =?us-ascii?Q?KAjbYHjo5ULnugC4JrNwcDUPl4fDqnKUGctb9NPjLEWCF/zv2lU+0k9T1/Eu?=
 =?us-ascii?Q?Tqs38tFC4LI0NxbEn57Vrh6DB7ADzgxeXw+ueIjdIadkTziovKmNC+J6K6pr?=
 =?us-ascii?Q?zU95PNXHIG1lBwb+G9v/LNrBQvPykybLgGUcsZNbUKKeFacGPLJiBKnDTUvC?=
 =?us-ascii?Q?HUikK4JyyBkcap0e/vrMWkrLbyaT7bjqDyA5DWQ84JhLvnYhDZQTX/CGgiRj?=
 =?us-ascii?Q?erP+T0M+x4BI+7NNBtXbfD51ah5SIvnZUOWbBofh96V6EjPNo+Ua1YLBRzQY?=
 =?us-ascii?Q?a2EF612L/19M6+9v5nGRqyV2VjM9xjumHoAD89ghKik9M0iUeoRIiel5gBNO?=
 =?us-ascii?Q?DT8vRRHA2Yj1u+YE7/K0pLAGNWw0AEh+nzcYA00JL9t85DMj7900aKqK/yy8?=
 =?us-ascii?Q?YQQYu+latA46WS8iYFHHwS8aTkTI4yOpvpXtwaT2yGb+m7St76golQH9aCwp?=
 =?us-ascii?Q?1Pjn35ZS2f2ZRt7Cvbn+e3Q3N7l5PlXW073rKp+pvsSiOn/sCCOsCZuEpK3p?=
 =?us-ascii?Q?hgO6trOjMjKINLKa4QQZ9jDfuZC7cSeBcakekrKb+ASO9U/FK3y/Cl7LZO0H?=
 =?us-ascii?Q?BgG+D6ZinH301OMR62+wbvg2Fsj4cnOkHO3Cq/IhC9+XLuzCfCNY83EMX48n?=
 =?us-ascii?Q?rSXGBa2qIZHRaBd6oMi1myUPvvNIwd9K5w60IeKqLkxpjwOHDVuhIm/GfX/w?=
 =?us-ascii?Q?Rb1sP6PTJqKFlss00lbnANn6LTwUfBzeDRgFuZL0MI4qXtHgHe+wvYfjP86H?=
 =?us-ascii?Q?w9NC9t04du4XyiphBrYWpG7KTUDuKmUjw4wUT+3UyWHLwztaRxgIUm8QpSq2?=
 =?us-ascii?Q?zg80B42E2T3SdrPv1j8OQdNrmIUUPn4TrmzLKHYZlkYBgnIEkiYEerNaGozc?=
 =?us-ascii?Q?iGGto/m+FTYgzUl404t+yHvZLxuFcm6z96/oqppMCM/KCIu9+ixpRkmSZmxe?=
 =?us-ascii?Q?0Fv/5gvQcJUKUpdvonIdB1A83JYzbGk=3D?=
X-Exchange-RoutingPolicyChecked: acfd8dNnzVKS50m71lxx5bJgKPOp+SjCkD7wSQYql/6djHG/Jo6mrSd9OjZSrWI/1i5/dL0KHd0y1cZDmFdmUwEicqkjjrXhApGLRMWZ0ctAoME33wXbGjGKw0lVnoBySlEv2ApJuvu1QEcSKMfVUUmF/1LpbGT//serXYWrHfdqUGiMXnaJtFQ3dUsZtyVvTha79Gdj96DCE/VbrBKGJ3ne09VRgLkBSG+RHYVPqIcG1Pg+HH0OLsjaIdDsfPjzEqJFDbccDjdBicFQx43zvrWt4rs9DLufUc65GQl6mRvu0ZwinkszQR7jEliqk0Ko7ccVkXi4bYpVR6GPlOSJsA==
X-MS-Exchange-CrossTenant-Network-Message-Id: cd921a30-1940-4547-2ba8-08df340302f7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 08:19:24.9969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81bs7LX+wtxGepNtAlUp6Zz2TD2P/3Y2Jf0KjN8jC5EpAo6/aPITT2JpG5+9/DSe8JPswuH8N7xN4YWVlyN74jPvXCm/X33cSYARJuLSQiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6047
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 10:18:03PM +0000, Paul Moses wrote:
> On Monday, October 26th, 2026 at 3:07 PM, Maciej Fijalkowski <maciej.fijalkowski@intel.com> wrote:
> 
> > On Fri, Oct 23, 2026 at 02:13:42PM +0000, Paul Moses wrote:
> > > Converting an XSK buffer to an XDP frame allocates a page and returns
> > > the original buffer to its pool. If the TX ring is full or DMA mapping
> > > fails, igc_xdp_xmit_back() returns an error without freeing the copy.
> > > The RX cleaner cannot release it, so the page leaks.
> > >
> > > Return the copied frame on TX failure. Save the RX memory type before
> > > conversion so native frames remain RX-owned on failure.
> > >
> > > Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Paul Moses <p@1g4.org>
> > > ---
> > > Tested on Intel I225-V with baseline and patched kernels. Physical
> > > pause-frame backpressure caused 46 leaked copies on the baseline.
> > > With the fix, all 72 rejected copies were returned once and freed,
> > > and all 192 copies were accounted for.
> > >
> > >  drivers/net/ethernet/intel/igc/igc_main.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> > > index 1fb5f3cbe93c..39263fd04aa9 100644
> > > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > > @@ -2487,6 +2487,7 @@ struct igc_ring *igc_get_tx_ring(struct igc_adapter *adapter, int cpu)
> > >
> > >  static int igc_xdp_xmit_back(struct igc_adapter *adapter, struct xdp_buff *xdp)
> > >  {
> > > +	enum xdp_mem_type mem_type = xdp->rxq->mem.type;
> > 
> > small nit is we require a concept called RCT (reverse christmas tree)
> > which makes you to order variable declarations from longest line to
> > shortest.
> > 
> > >  	struct xdp_frame *xdpf = xdp_convert_buff_to_frame(xdp);
> > >  	int cpu = smp_processor_id();
> > >  	struct netdev_queue *nq;
> > > @@ -2504,6 +2505,10 @@ static int igc_xdp_xmit_back(struct igc_adapter *adapter, struct xdp_buff *xdp)
> > >  	txq_trans_cond_update(nq);
> > >  	res = igc_xdp_init_tx_descriptor(ring, xdpf);
> > >  	__netif_tx_unlock(nq);
> > > +
> > > +	if (res && mem_type == MEM_TYPE_XSK_BUFF_POOL)
> > > +		xdp_return_frame(xdpf);
> > 
> > Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > 
> > > +
> > >  	return res;
> > >  }
> > >
> > > --
> > > 2.56.GIT
> > >
> > >
> > >
> > 
> 
> Never know what to do in these cases, order matters here, so
> do I touch more lines to move the assignment down below?

	struct xdp_frame *xdpf = xdp_convert_buff_to_frame(xdp);
+	enum xdp_mem_type mem_type = xdp->rxq->mem.type;
	int cpu = smp_processor_id();
	struct netdev_queue *nq;

this would satisfy the RCT rule.
