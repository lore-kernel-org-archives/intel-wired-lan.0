Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718B2CC6B15
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Oct 2026 20:55:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 238B040698;
	Tue, 13 Oct 2026 20:55:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cQRC-x6Jo4oO; Tue, 13 Oct 2026 20:55:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4E40A4065F
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791924945;
	b=smi5ErkkVw+awPKgo2AozvYp3U4o97TU1+KaQb4cmLEPmzncHGAMqxv/MST1cu8djOCW
	 uU0aGIVbKlhy9oFP3FOA/cRaZFvdggDZh9FxxPRzCXN444vuJN2Yhm9gu4E9h0PvP0iwc
	 nt01Zcu+brfKKOmW3LlI4JGmpmKUlOLKU+2ePO3aEg0o0OD+nBMnUG7HRNMLpWXU87ye2
	 HfMv1uVj+TN8kp9/Ep1dLGmCdZg2qdO9v50glXvwa7WDLzd8Jw2t4Jh/8orYz6nNPPGmW
	 4YzbPNrIRVgBd4NVOMolLq2skdPf2kGaDRJW2USKfunSAHwmRFkx+U1TGxeMvwPIffQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791924945;
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
	bh=ZWjH2HUEmFz79E4ARiunguCSu3rnrn+I2wE+ybx47RQ=;
	b=HV6GAp+K6K7mpmnxFxolp/OEDHz+/GAC2Wx5hthkj82yLidpgwGwsU/vBZwrFLnnLSpO
	 XchUqlCXC1udgqKa4FeaRtfs2g2t2NX7AP8Cbck12sT0Fck6THg56v+nvgDTRdRjg8V4F
	 Gfu8qUM/VOAANPSLEkc7akQNmIBhI4VkBnE7igD70SZrt5b4gVpksYtRO2vSo0e1WpEin
	 LCqxNsuglbAjpFJEWLhpu9s4v17I6Jo86m2r5cVxyRJti5yKwu4T1oRqhEC/a1BAv4XI5
	 lqcyoUopcvu6LjZhqJFDW6PjO5JL17Wr7oNEiRNtImIPNObHN4DOC6/mwgRAkLY/2Pw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d4LPBTxO;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791924945;
	bh=ZWjH2HUEmFz79E4ARiunguCSu3rnrn+I2wE+ybx47RQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AsTA1bq12Nf3krHP6oJq0YE8Bz1DrNvFFKGucsTYNDGnergHi1NmPLjcHQaPGBKuF
	 Sg2Vgs8pvUiBZ+rsf4w0KrbrjS8hgIJGpZ/hnIl2NqgqPqwSWHXNVHtP6Aq1FT460w
	 ELWt6XiBRu2CRFEeej34qDwzxAWjBFnEexcWC0Ix9zOByXg4Glx1mDbez+RBAMlqCN
	 OnI5gmhg9zWe79LHA4FglDnr216uWvHDutnphY7raI2Lh2eqUcxpaITlnkLhcJt7Zj
	 w9DgFbgtx6gWocJ2G+3qyNHVP4gPqC1Fe6/iLCfm2yheG5kEU4WzyBhdwAtY2nOhZt
	 Ri2M1d1lu3QmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4E40A4065F;
	Tue, 13 Oct 2026 20:55:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 417ED2AC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 20:55:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 336874065F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 20:55:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rx1hEW_64yS0 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Oct 2026 20:55:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 28142405B4
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791924943;
 b=PZi8Qv4ne62xYq3Vauf7aSwuNM8Vx1GQTDO6O1yB6wd3NyI94vJ32JXYaMAhjICxHEzX
 s475GR6P63hH0NC5UVX6M/DAgo75nb343gorAH7C9nC/+W49ikIhMf+0tfFy1/yD5NOIX
 bf4gojgLcfohjB7vI34k/BY15JijE/cCGnZ2sacOwVCny1NNNbj3Pauw6H1EXu69TPo9e
 lI01hYI7VEn0bjc/DePJkCqIUMRGgG8rez0fg5f+fVhVzKO4Lt/8eM32Tzdc16g2RbNeu
 1+po88S3MEzv09A8TKIubbg1d1et8g2WdPrWFbDwbzyEE2xFDeTn59bXEUB1MmGVBOA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791924943;
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
 bh=ZWjH2HUEmFz79E4ARiunguCSu3rnrn+I2wE+ybx47RQ=;
 b=gY3dG4CjuHOzYjJZZNZ9nD52trZecr60OZOfW4ZmJqk4qJ5vOjZJPFM8CaarAX25ZAXD
 sXyUMxnjvEI+MTQ7GBxS7caLWT6XCdkSGYGaSGpsb9lI1xHMnbgWZNATt6ZQotSsGCItM
 JQNmosjDKdI7M3xgeCEnZRRvFmNbOsYWnOOYnTrwF81BEQjpWVnv9wpL7qhfR2Z+cUNc9
 zCLHhCGUQE85CgKRpoRpwaPdqWCUjCTGbCA7xguAsHQ0d0m9/fPq5bOS3R4su16/tvDOO
 Yve1CVPkcW8M0YvHYs4XQbvFtvNeIaarjyQXSTkIa+hve5XXhMRJG3HZCz8g4B3+ftg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=d4LPBTxO; 
 arc=fail smtp.remote-ip=198.175.65.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=anthony.l.nguyen@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=d4LPBTxO
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 28142405B4
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 20:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791924943; x=1823460943;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=999YVmVohMVazgOJzwVqEiGGuH2KHRenXoE3AS4/a6M=;
 b=d4LPBTxOQbcBXFsOjDvVDnEBKu2ROdfbUBXHzr4deYmHJX1284hGdGv+
 oxwxantXzvhKY0fgv0Qln7dNxoUy2yO9Cf82NklAJA6wuTz1LI5WDgqS1
 4zpHMP/9RvVteZx7gw6aijsh8elgBOSu1s6Nu3wmaT2hRo+TtOLQXO3Yi
 b5ijh7m4jljYWkVewYGXzBqGygyRHlrWQCpM96LWM12cn43HC9Mjc39Dd
 5Qh+Od6XVGAf7oaFrNbswGYdju6Kx4tzW1Bv+jGxXvPevLt4/XXmlh5XZ
 SUltAQevrwDzXY94RysvpYrRZee0JYpH/sOHoSnb5op16ElAq1Uw1KxPE w==;
X-CSE-ConnectionGUID: 0NVGUoDKQ86a50FP8pVBJw==
X-CSE-MsgGUID: f08BgIyFRKWM7uwcuRlPxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="655467"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="655467"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 13:55:18 -0700
X-CSE-ConnectionGUID: u5jmDYgGSVqM8TN690s5Pg==
X-CSE-MsgGUID: ez+nG6ncS4OSWcj1etsyaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1574620"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 13:55:18 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 13:55:16 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 13:55:16 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.70) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 13:55:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9+Q58aR28iMjC8yDWOC7nByQsUHicNN/TyslEAhHCRZNyrCDlWjzjAWFy0JWfczeJl3OLL+3SbJfTK3G3SnnfpHuMRMkqwq63enUBXO014k3WDIGmKdwJomjlIGRMszKGDNJe3K0JhRQISPUkUjhjzxi/0Z5UaCVOpNlyXmGLkQjQU8wThsQLZu4y1tWU24KdAiJRcP5Jp5tmZujHRj8FWwwrA7bo0FHEZ7bFl00DTuklbZ/4v9YITvTNg4J82RmJxOSD3n7lk9x1Q1RXXEVfCbwUSM02GOWzQHQcvy2pSq93kWhZDqzrMIziXU6iCNadup7B7trsZB2TgkaZhjZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWjH2HUEmFz79E4ARiunguCSu3rnrn+I2wE+ybx47RQ=;
 b=XmzBCo/Mq68+H7y7ZyoVvlrGvoCnfxgVjp1ah61OeCByiuyLlNpVy9o2noBw2Do0HoPxsuFc3Uf6/rZ6+7CWQZtPlroxNYFmh9wWUhKtmizhOcTah8HczXCqgFj72IwlDyRTWra6aSvNBe+k4sbrakJVj/dJAvyLlJwdsOQp4GPN2vJYPFVVdYWNqpEx6eOJ7sXmHUXVi0N9eo3r03axn7+LkVXlY2p8SDfdZ5uMdqkTsWwBi63KfdIzciWsLFpjsQSgzRyaiMzhPbXUhUhhzsJ4cRE6dOAnsKG/6hsW0C+mjvGI4FZKEp9VhvWR8SfWNp+U8OL3sR6LU/kEzEw9UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by CH3PR11MB566895.namprd11.prod.outlook.com (2603:10b6:610:34d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 20:55:15 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 20:55:15 +0000
Message-ID: <73c2d736-068a-425c-bb18-d9419969724f@intel.com>
Date: Tue, 13 Oct 2026 13:55:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v4 2/3] ice: honor autoneg disable requests when
 link is down
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 <intel-wired-lan@lists.osuosl.org>
CC: Konrad Knitter <konrad.knitter@intel.com>
References: <20261006142445.2867917-1-aleksandr.loktionov@intel.com>
 <20261006142445.2867917-3-aleksandr.loktionov@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20261006142445.2867917-3-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:303:8f::30) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|CH3PR11MB566895:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a9e3afe-8b6a-4f98-c0b8-08df296c478e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|6133799003|22082099003|18002099003|10067099003|5023799004|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 4wc11SInFsc0M96/Y65iGdY1YWnKuVuPrNSxWu3J2tZa3e0J2C+QMVMh637mpuAd7UVGfismqotiuUNJN4rxqpFUXMnJu3UOosQGGjldPupwKDDWoI3c3q/j3FwWKjW1yOc/lbmgSbRQYTJJw9bW6HGNxefRbBybvgmym1OpGPmD7gPzDQBVNmz9/1CKyGRtcIV85l2xbmxBnM3PMDEK/nWQvCBPGsk6QmgRwHBt37rmVsPv77k7kqf2Iw6EPO3VjNXqJsEf/1tGpPUe7CSX9RAADK4iEOEvGNcBqtIlPgBgX86FB/GkgIA2BD7HAdowrZVaFVMoWzk4lpN4rGaXAuaiLLxMmENwCb0SuuYBEPi94gZJ7i2Q3huRnw29lej5/9u9Af1n1htzHJkzZvebJWYaslWG0nZk1bzN6yxVsPRj+aIPjDKifUJ/I+WjAB5/yG/Lxm/ht3zAZvysqgKMS6SFw7rqBLq5COzBX72NXM25IWKTlSgw1ezg0WvLMksCyAQR5kHkkuzsBsh/IbrNLsv0MStYO+SrOrcOKetF1OgEMVa4V1DUXUmfSqBzhkdnZrleg6zsxobsb0mIGPokYolVh0U/V5h7eOLTuI9qRopcad9M+Ul1oaHw2NLdkcFoTz6sD0oZq/caSV28JVEiANKaQqVYmMtpii3R18Ejrc0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8230.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(5023799004)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1V3VHY0V3J5cDNrYjBVQlAzQ1llSXVLWE1GeE85NDRyWGhqWkI2dnRkVzdo?=
 =?utf-8?B?QkNHV0FycXVabTRDQTk3K21QYnR1MDFQb1dGQVV5YmxFak9rc0ExT2dwcWFK?=
 =?utf-8?B?UkNnRlVabHVhRURmcTNkajVrZHBsTHkyVGw1NDdWYzQrd1M1dGdUd1A3N3ZB?=
 =?utf-8?B?OFVESG45SnQxTVg5T0Z1Z1ZsSm0vTURMenZPKzBRNGlJdlptbVE0ZDBUb01E?=
 =?utf-8?B?S3ltQ3kxRTZSYncrZXZIYlJjL2NNNmNWMlJiQWZYSCs1ejlSaFpCam8zS08z?=
 =?utf-8?B?QXZVOUhHOFVHR1pBKzgyejBzSWttOXQzOWpVbng4RFVhY2FFZHBsQm03WTE5?=
 =?utf-8?B?eTNnOUk4NDcxcEF0QWt4SHRaN1Y5ajlUbFpqUjc2b3JuTHEzd2xZWjZYSE1i?=
 =?utf-8?B?SDE0R0Y1QmVLeUcrdTQ4NGJpZ0Z0S3QwZFRhVXVKa2dKeUVrbjA5SFRmUGxL?=
 =?utf-8?B?R1ZKVnlkL1poZFEra3hYZUE5OFNwQWlhVzF2a2lpSlVNZXUrTnZORzU1QWNR?=
 =?utf-8?B?YytEWml6WktIRmhLTWw4R1BicDMvcGVhRDVoQnhZSm1qWXhhRlZNQWphZlF0?=
 =?utf-8?B?S0YzUjF1TUlTSlJCQTF3cldXZkk0T3ZtdThPQm5qU3pKcUkyUWNJSzVBM0VL?=
 =?utf-8?B?clFVdzN2QUI1WUhlUVVQczBFb1VvNUNmcm5HdzRXb0V0V2NoTEZScG1KditO?=
 =?utf-8?B?ZjRyNHdJY1dDWTJYVjQ3aXNnckVuVnoxdU8wSzFDZjg3TnorSnNwMDZQMGpo?=
 =?utf-8?B?Q24rM1ZOa3JCd3ZwTklJRU1pRW9VSlpyVjNDeSs1cDU3UksraE9XWE03Wm1H?=
 =?utf-8?B?cEhueDFmTmFpbzNLdjg5ZGczbTlrLyt1N0xZNWRKUUpIb0NESmhXajRGbk5S?=
 =?utf-8?B?dXc3UlR4RUtSNnE1ZThtVXBvL0JxWW9uMy9PYy9uUkpnRU5RSlBBSG50T3U1?=
 =?utf-8?B?bFVLNjVhcndtenpja3NoS0ZmalhjS3c0dklrY3ZuOG94VC91UDdsL2dVV3BW?=
 =?utf-8?B?OGFNQUZNVnFyd2o3RFFOMjY3OWFMaHJIK0JtNkM3eG5uTXNndmtGb1dYbUhO?=
 =?utf-8?B?NGVMSUdEM2YyVklXYzIrVjdqUWdwQ3Zodm5hTVdlbXlIRkhOeC92WUtkNGI2?=
 =?utf-8?B?TldXWGFjazRidXkwbEpFS21tVGhvOWtoQmxoWTEwWmlYZmdlZmYwSWtvbW81?=
 =?utf-8?B?bHRsWFlNbmF3dVl3YnlQZW5ScDV6Vnp1S3ppTGM4YUNpdURQV3BYMVh1cGY4?=
 =?utf-8?B?cWtLbW5DaW9lMm9RbFZ4RFFWem5abktmL3Z0WVpJZGJrWmVUVzk2c2RQU3hH?=
 =?utf-8?B?MHhRazJhU3FaYVMyamxJeWpsQ0haS2JGRE1kTjZnQVlkY05EK3JGZ3krbC9E?=
 =?utf-8?B?bWtoeFhpeGgxVmMyU2lOcnRVdTV5Mm96L1lqeDZzSWI4NUxqc21CWk9lT3B0?=
 =?utf-8?B?M05zU3BqSURVMkFmOXB0VEpoSnVQczE0VzI2bnNncWUzcVN2THpoWi9Mby9p?=
 =?utf-8?B?NTZnTitndEl1MzZrWXZ6a21qZ05sM1NLK2xad2JiKzlCeVBHSFIybFpva3hx?=
 =?utf-8?B?QzM4dHBuTkRCTDdKOFBCb0tWWnZ0eFlvWCtUR0dFcnlpQ1A1OXQyU0EreFln?=
 =?utf-8?B?d0dlMmlBcWt5WEdnMXhJdW5vQ25vaU1CQVQ2eXAyeUpzUGxGaEVzS3JNa3BW?=
 =?utf-8?B?QlBIVkVsNEU4WUNSRmJzUWh0M0xFaVJGeU9GVGcySUhCRmJzLzd0bGZ0L1Rl?=
 =?utf-8?B?SFZQQkdWZ1RlOFBDMzZpYTJFaUxoWDNPN2I3ZDRmWjBSQlhvSkR1ZmZUOHRV?=
 =?utf-8?B?OHYwZnhkNkphNXJQTEd4TG9xY0kvWmFGMGZ2aG15am9qNFlYL0g5UTluSGpz?=
 =?utf-8?B?T2YzbHNSbEJQaXJ6TXRDZ2NDT1NMdjNuMXFyOHl6eUFzSytaL3VvSTBFL2p4?=
 =?utf-8?B?T05zNjdBYWpKRC9PSTc5UjR3MUlWZVdDMHdURmRxQXZ5ZC9pZEVMbWxwcWdU?=
 =?utf-8?B?cURkTW5QcGlwemNRTzdqc2Vjc3dMbCtGVHVtR1IwT3BUV0I5WGtJUVp2Tkpu?=
 =?utf-8?B?UFh5NlpFaGpXRlZFMHVKVWx4M05GRllHRkZVU0RPdnpuV3E2SmdNajl0U2Rr?=
 =?utf-8?B?NTVibkdUL3B5MkFKR25tNVYzRXB0WnFWU1B0UnVDS2hhVVZOb2dySURHQ3E0?=
 =?utf-8?B?emtDamtuRUpvbThBYTgrVUxQZTE1SWxobm9zSWF6NXdVd0dqWWQ3Z3ZjcVN3?=
 =?utf-8?B?RHdkanJOdlp1VXZOQXlzMmxYV0hsVWFQSzhtcFJRUE5OLzZpNHVjV2paNml3?=
 =?utf-8?B?azRaRFU3MTFqSVRPcHZuWEVKSE5SUEN3c0cvc21GeTQ4ZW5QekNlQWJqcEZU?=
 =?utf-8?Q?FM3A/jx1Q3xW0hUY=3D?=
X-Exchange-RoutingPolicyChecked: fUsCqb7fPR44QY+gfy2NJDDAg5YvsgH8nopV/F+SnxZv4vgJ8vLrHosAmXJTBSeF2yUDKbsuYfdYornk5JNh66DbO2ALLPqtOnZr8Or/8Jds9uJQVg27zdFJl5Ghh+0yGFrCRpFn9w5qu81ymgnIisnJ8PKuqHFI+zwxm/7ccUzzOb+PY1Lxeyz9IXolAB7pJa/eXBqhk7svsjYsvD3LXvH4ZQUTck8Zwg6hvjXSSAJg3FU5hsh0uA9b19jthqb550RY4oJB5aAJibY0GCNP/IGbXFK+CSYkSezx/BLg6wwTxQVUqgFRG0c7Znju30tHlgRiKgVwGoPp9ahxwO84Zg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9e3afe-8b6a-4f98-c0b8-08df296c478e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 20:55:15.1075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0RjSO3VTjNuJF703DOyS76Y5F8+56N5W2PvPkwmjpJAj1DZ7llD1B3xOfaVLBTP9Wk4CtyPkVhVnfVKwxS+4xphnL2aM/B+8xqN34W5QBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB566895
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



On 10/6/2026 7:24 AM, Aleksandr Loktionov wrote:
> From: Konrad Knitter <konrad.knitter@intel.com>
> 
> The ethtool setter uses the link-partner AN ability bit to decide whether a
> request to disable autonegotiation can be handled. That bit is valid only
> while the link is up, so a link-down request skips the configuration update
> and returns success.
> 
> Allow link-down requests through to PHY capability validation. On legacy
> MACs, retain the existing restriction for PHYs that advertise autoneg.
> Generic MACs configure Clause 37 through low_power_ctrl_an, and must keep
> AUTO_LINK_UPDT set so firmware applies the change. Handle that field for
> both enable and disable requests.
> 
> Fixes: 48cb27f2fd18 ("ice: Implement handlers for ethtool PHY/link operations")
> Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> Changes since v3:
> - Allow link-down disable requests without relying on stale partner state.
> - Keep the generic-MAC enable bypass; validate E830 Autoneg support before
> 	restoring Clause 37 when its cached bit is clear.
> - Avoid marking unchanged Clause 37 requests as autoneg changes.
> - Correct the Fixes tag to the commit that introduced the ethtool handler.

This series did not apply cleanly, but I manually resolved it and ran 
Sashiko locally. This is what it reported.

I did apply the other two patches as they look ok and don't look to be 
related to this.

Thanks,
Tony
>   drivers/net/ethernet/intel/ice/ice_ethtool.c | 57 +++++++++++++++++++-
>   1 file changed, 55 insertions(+), 2 deletions(-)

...

> @@ -2535,12 +2557,31 @@ ice_setup_autoneg(struct ice_port_info *p, struct ethtool_link_ksettings *ks,
>   	if (autoneg_enabled == AUTONEG_ENABLE) {
>   		/* If autoneg was not already enabled */
>   		if (!(p->phy.link_info.an_info & ICE_AQ_AN_COMPLETED)) {
> +			if (ice_is_generic_mac(p->hw)) {
> +				if (!(config->low_power_ctrl_an &
> +				      ICE_AQC_PHY_AN_EN_CLAUSE37)) {
> +					config->low_power_ctrl_an |=
> +						ICE_AQC_PHY_AN_EN_CLAUSE37;
> +					config->caps |=
> +						ICE_AQ_PHY_ENA_AUTO_LINK_UPDT;
> +					*autoneg_changed = 1;
> +				}
> +				return 0;
> +			}

On generic MACs, this early return comes before the check below:
     if (!ethtool_link_ksettings_test_link_mode(ks, supported, Autoneg))

If the PHY does not have Autoneg in its supported mask, "ethtool -s 
<dev> autoneg on" used to fail with -EINVAL. With this change it sets 
CL37 and AUTO_LINK_UPDT, sends the config to firmware and returns success.

Should the supported check run before this branch? The E830 branch added
below still does the check, so the two MAC families now validate the 
same request differently.

>   			/* If autoneg is not supported, return error */
>   			if (!ethtool_link_ksettings_test_link_mode(ks,
>   								   supported,
>   								   Autoneg)) {
>   				netdev_info(netdev, "Autoneg not supported on this phy.\n");
>   				err = -EINVAL;
> +			} else if (p->hw->mac_type == ICE_MAC_E830) {
> +				if (!(config->low_power_ctrl_an &
> +				      ICE_AQC_PHY_AN_EN_CLAUSE37)) {
> +					config->low_power_ctrl_an |=
> +						ICE_AQC_PHY_AN_EN_CLAUSE37;
> +					config->caps |= ICE_AQ_PHY_ENA_AUTO_LINK_UPDT;
> +					*autoneg_changed = 1;
> +				}
>   			} else {
>   				/* Autoneg is allowed to change */
>   				config->caps |= ICE_AQ_PHY_ENA_AUTO_LINK_UPDT;
> @@ -2548,8 +2589,20 @@ ice_setup_autoneg(struct ice_port_info *p, struct ethtool_link_ksettings *ks,
>   			}
>   		}
>   	} else {
> -		/* If autoneg is currently enabled */
> -		if (p->phy.link_info.an_info & ICE_AQ_AN_COMPLETED) {
> +		/* If autoneg completed or link partner does not support AN */
> +		if (ice_autoneg_disable_allowed(p)) {
> +			if (ice_is_generic_mac(p->hw) ||
> +			    p->hw->mac_type == ICE_MAC_E830) {

The commit message describes two cases: generic MACs, and legacy MACs
that "retain the existing restriction". E830 is not a generic MAC, but 
it takes this branch. So E830 no longer returns "Autoneg cannot be 
disabled on this phy" when the PHY supports Autoneg, and the enable path 
now writes CL37 on E830.

Is the E830 change intended? If so, could the commit message describe it
and explain why, given this patch carries a Fixes: tag?
This branch sits behind ice_autoneg_disable_allowed(). If the link is 
up, ICE_AQ_AN_COMPLETED is clear and the partner advertises 
ICE_AQ_LP_AN_ABILITY, the helper returns false. The whole disable branch
is then skipped: CL37 stays set, autoneg_changed stays 0, and the 
function returns 0.

On these MACs, CL37 in low_power_ctrl_an is configuration and does not
depend on the partner's ability. Does "autoneg off" still succeed
silently and do nothing in that link state?

> +				if (config->low_power_ctrl_an &
> +				    ICE_AQC_PHY_AN_EN_CLAUSE37) {
> +					config->low_power_ctrl_an &=
> +						~ICE_AQC_PHY_AN_EN_CLAUSE37;
> +					config->caps |=
> +						ICE_AQ_PHY_ENA_AUTO_LINK_UPDT;
> +					*autoneg_changed = 1;
> +				}
> +				return 0;
> +			}


Only ICE_AQC_PHY_AN_EN_CLAUSE37 is cleared here. The Clause 28 and
Clause 73 enable bits and ICE_AQC_PHY_AN_MODE in caps are left alone.
ice_is_phy_caps_an_enabled() checks all of these to report the autoneg
state.

If CL37 is already clear, for example on a CL73 backplane or a CL28
BASE-T PHY, this returns 0 with autoneg_changed = 0. Would "ethtool -s
autoneg off" then report success while get_link_ksettings still shows
autoneg on? That is the same silent success the commit says it removes.

>   			/* If autoneg is supported 10GBASE_T is the only PHY
>   			 * that can disable it, so otherwise return error
>   			 */

