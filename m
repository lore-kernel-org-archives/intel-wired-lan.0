Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCD6606A324
	for <intel-wired-lan@archiver.kernel.org>; Fri, 30 Oct 2026 19:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=2mLdIPgz;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hQOedJc1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B9946079D;
	Fri, 30 Oct 2026 19:00:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GrHSyeUZfWdH; Fri, 30 Oct 2026 19:00:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1B77C60AA2
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793386848;
	b=Th8YzDYWsGlxAFvAUg6CQs7VkjU9gQSUkFSrvQMBMeaiVPSLW98nVPbEZ1hJyr8u2rEm
	 Iugu9cf4WaXbtHKUNrJjFIujKjAdcvqy0e/z3UDtkKqC0j79qNi53IHIvLkrzg+rNCDFi
	 cMGCE1vtt3OCKl1AVLMbjI5ghHyXc9RhogC2oQGdQU2HpxjfK7gV4JuzRIQlM5LtWewhQ
	 vcsbrql/GJzVr+3Qh1Ng/95I4AcX6HawQBxM2GNOrfQ+YyevbkNzOgfm3nN8dZn1dRdk5
	 yiqGEoHE7fAMLwDnxKAXqaoBJP7CWwYdUuNa/lo0eDRVgRzGrnooAFwI14FBVZRiGCQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793386848;
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
	bh=YvK+igMwbJsjhp6WNZYmD8F4bVbwapzNMHJgNyl0FFQ=;
	b=T52UnLq6nhRXQorVVbAlAgV2x4kStDggi9/VNEoh9ZpunyPQG72NbGVTOQJs3/Wx1oKX
	 VZvVd1NW8TLrX9ST4snyYV/JrletngnSf/ptYm9+arc7Y1icrzOhFnyR+kpyq2EMkcLwI
	 ABfontkLUn5RXwTCb87Uez6oHsdwB+3Dkv325M+3sT8XATScUGluV5GfivPSfKtB8aUWw
	 Dc42ZJnIBOi7tDYmqI+Pw+CviAzJrr+O2QcIA2hV8TwGSB0rgywhqiZh4AlJkUBsPiNwR
	 IANaCKseDqux/9gzNjRNZCJ0HbrJzaWXZCXDPFmoFE6pf8ccKGSYGORTQTc4hNmvRLA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793386848;
	bh=YvK+igMwbJsjhp6WNZYmD8F4bVbwapzNMHJgNyl0FFQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=2mLdIPgz46PAFIcP9hWtchy94EMHknsIj2W6ARRLrAk7tlUhGtZ47HIqlHKfBJQ6y
	 eYxKgQlqjZfM1fXLuKUVrqwqvDYLKDnRv/2VVO1fNQQtIV+5rKdatxhxHo/HOpaqqT
	 iadOLxeK9bHmZ+sDTpvDDMjlBDI94Jhj3pEzvMa2lIt57N1msWZGEN24qNQmt5rjnu
	 +lUsR2jW3VEp/E8oeTwM3fkJEboweTKJeej4s+E7WceOjBpIcF5cdyGb9bWygsJZ47
	 HXzl7x8SQyotQcRq1zUathPfKfX5tu3grg7EPv4835fCeoJTdVrkbSWmy4YyBNg1C3
	 agNzT1knyA2AA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B77C60AA2;
	Fri, 30 Oct 2026 19:00:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A4A5235
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 19:00:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E40A440B44
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 19:00:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GjOdMYdE-4ZA for <intel-wired-lan@lists.osuosl.org>;
 Fri, 30 Oct 2026 19:00:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9284E40AD4
Authentication-Results: smtp4.osuosl.org;
 arc=fail smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793386844;
 b=bPettRrx7vlsb++5UPvtlZXq4WwI/Zd2ZQlHzEtPaQVsxsMg4nb8r7KQIQvVoqbW0ecc
 Y9hqnwi50USeFVXIysjO8M8wMyUE2AxmrwI9Z0T58YxBYz9h0pZuNvfZHBWr+8gbyyKPh
 bAN6FcrdiARzUbwUPg+SeSxgtqoX6JbtZ4xrNHgJ5WWEIcUKtC9D+MJyOiStQfVprAOsI
 bTAZmjNJY24pynadXKHpbjRxSaVQdLE1hUt2N/KyJZ0k59NYkc3afxpsYefK8lYiu0lq2
 Dp/OcyczHlDlsqZe0E44MzYu4BeTLuR1FyUP23IGvhDZQOFK+RVGX7JZ6V6ue5wGcPQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793386844;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
 References:Content-Type:Content-Disposition:Content-Transfer-Encoding:
 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
 bh=YvK+igMwbJsjhp6WNZYmD8F4bVbwapzNMHJgNyl0FFQ=;
 b=qBq8fm3WbMtlsWM2pxlLFx4GbsfGogLIfc3Hi2euJjaGpxGfyPv95Lw3RaJUexBehnlJ
 Wo0s4d7/7mJjkJMOIFOZOWtn8OXof+3tQmzfRr9PppP4NagXUyHWe/BaRCY3MTatVBWjk
 mLa2IpGnQ86HldJw4Hj45mTSHm7MlXToyxig5Chjcg8aiTIyjQNDDPXDtdNL7pxgyHuFO
 tycR6I/Yigkp7M04ZxhyBkbLQvkTqyPYhBRUNvMgJUnEZDuePs+sMUCCVUYszRuKT9t50
 quMYShRcxbdR+VeUYsPXRWilbMY2V6VLtfY9znk0rWXhlXIutpa0yy9ViF9FTNmJNmw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=hQOedJc1; 
 arc=fail smtp.remote-ip=192.198.163.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=maciej.fijalkowski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=hQOedJc1
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9284E40AD4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 19:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793386845; x=1824922845;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=BueecJUS38RPOM0yOrhDKwdwZWvwMvyn4/7gT+5zEx0=;
 b=hQOedJc1ujlFT0TLi7xT8uGt5ch3wFkLJJ+SZyGhsTgkn7mHleCfryoV
 6AS+c1qnhN1jEYLiqJoAhrKoUhMis4tRraAdOTwLW8Sa3F49YuT0C3U6N
 0xmBB12W2NP/y0di2eW/91CT6m2W0Va13lgECeD8CA3Rw7nwF5nw+HrRD
 E2Uur3iOsIe2WxTzbCnzOuee+Fs8u2Q/i3bkhpNTsc/OZymt9ayn46Dy5
 utBlM7BDGUzITtc3/begKQTvnQCJXNf0FU0+9QLcz00jVR0Ud9TThC9Bm
 cIYPzhy1Dag10fcRJbpQeUNocY0guRBKlS8BSvuXqypU5DaoINdcpiLZO w==;
X-CSE-ConnectionGUID: toL/5aUzTq2tIz4zUjGCuQ==
X-CSE-MsgGUID: AMpOMGv7Rj2Tbc1lciajjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2152644"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2152644"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 12:00:41 -0700
X-CSE-ConnectionGUID: fvZhljKpQneg6Yv0HZqA8g==
X-CSE-MsgGUID: 282VmcmJTyuWrAWiCnOzZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5396602"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 12:00:40 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 12:00:39 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 30 Oct 2026 12:00:39 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.18)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 12:00:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WlmujP9lsv/QPAx+ME0euPnIdbnT+XpXDh6n4S3yjR0xMD2fF1StSqYWWSb96UZqmDcTnluAngxdy9Sy7rfNHfwqKiK45631dUqvC2WwYDjoBjN2o6+x1B/maR1O2sALsyB30eg86Y76TFiuUF12+z7TDG4TWYETQ12+oHf8KE7ckx4xZHV+5QIV3/qfT41jpriZzSNU4QVO82inFvPQ3A8G8NUuComO+csaFbrrV3+3xX+AggR5oEPp+eV/zEW+Njn85nRTA7ZntVpof2omP8ZZ3kY3ypGZrB4eLSBH2BRs08TOKwSw3F7mCQ4VYkmk38y4bbITR9iF3lh6MdzAmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvK+igMwbJsjhp6WNZYmD8F4bVbwapzNMHJgNyl0FFQ=;
 b=uhLD89/9RN6OmgXdx13X4n/izCsFM1NkISaI2UdxAMFEC03AIv122Bj66td9pJ024iauve96DmUV4RDxYSWc+oFr+/MKoKl/qaDvPT57/K+EJ6okXq9QQv0y325ACH9ixU/F5riEDoGRny8P2769oOgwwwJFnAP+e/NMyFjwbB8O1Y9+E5P1q/FvPWnpUWL7CihqqZ+Uy3XTbsohhFRnlrxK7TDwZ5tjRNcG6W01+HtPn9aO/thmV/Q1EYUYphNnGMDuJVmn7aYEFNXBeS0b3E4VMJupnT4/gbAw0zhZWqqS/UkxBt/WxoIVTUZzZqxef5UDWxmHRE7SHp7l6KYtLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by SA1PR11MB8796.namprd11.prod.outlook.com
 (2603:10b6:806:467::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 19:00:37 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 19:00:37 +0000
Date: Fri, 30 Oct 2026 20:00:30 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Paul Moses <p@1g4.org>
CC: <netdev-bot+sashiko@kernel.org>, <intel-wired-lan@lists.osuosl.org>,
 <netdev@vger.kernel.org>, <anthony.l.nguyen@intel.com>,
 <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <hawk@kernel.org>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
 <vedang.patel@intel.com>, <jithu.joseph@intel.com>, <andre.guedes@intel.com>, 
 <aleksandr.loktionov@intel.com>, <avigailx.dahan@intel.com>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <stable@vger.kernel.org>, <jacob.e.keller@intel.com>
Subject: Re: [PATCH net v3 1/2] igc: only strip RX timestamp header from
 first buffer
Message-ID: <auTpTsEyviSToHKi@boxer>
References: <20261028083344.3047350-2-p@1g4.org>
 <179331704005.3134.12545545223659652020@kernel.org>
 <auSDQtz8l8hzzr86@boxer>
 <K-58hRuSyY_aSjvzkpmwBMeDzvfjQyLMRjMsDlEL1M60FHZJTS1WXTaTrh79pf1igf7bt5MCaORbxYVJJliJ0FhGCzjtiEVvagd50w65Ssg=@1g4.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <K-58hRuSyY_aSjvzkpmwBMeDzvfjQyLMRjMsDlEL1M60FHZJTS1WXTaTrh79pf1igf7bt5MCaORbxYVJJliJ0FhGCzjtiEVvagd50w65Ssg=@1g4.org>
X-ClientProxiedBy: DUZPR01CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::16) To LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|SA1PR11MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d119567-c1ce-45e4-23b3-08df36b8155f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|366016|4143699003|11063799006|56012099006|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261022105027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Z9XI+ebKICUjvEKD43upu650JfodKioFpeVVA+/NPs10rCX8qSIekX4XcP1WDjU2mLdTFrYWMwsavvO07y1UAjnArCVtK6vn94bTg2m7sO+kxohRSMBzaW6jQdGBYXb9aBOIUZpH+VEUEAN6idquFW2pXK9qPTlROcR9oy1m+EOeof8sZfBloossgqZpTeCcyfQ+FTBc90ga7pDftGbFW95SlTGcqa3/pCJQ73N/6HtAqbe131mcZp//qsO1pbOfZ1ZviSsTIMrbOAtorjDBpp91FUXafNDyNAuEjo/SBDLOb9N9tgpk43O43D85G9rbBwwfuVvInvg8ZtiSalR/hSXKgTV1V52UngK2+cE+/gebHdgCqvONX1Lfa5m69DXQqGteqSx7eG9jZ5+tOTBFm0gC5+xj0lOEM3/VbbhSChDvqkgMh3ZBD7dnetPRARKzNTTxaA72o91dv8WMkqsOlYV4Yb2Ml8CjO8ja/w4vDJG9Mz0gEI9PlQMvC5r8IjlnJU7Yrl1ng+bAilZyx3bOwHG/TlMAOxrw+95Txkul6xxusPtfNKsF2hXPf45JNT7FMCzQJdjJa6JuWQ7Pq9jdeQ0V/k9ccf/3L3IZ+DCbUm0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB868673.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zklzc2NzcXN6TUQzRUxSVjF3MllIbXE4dUNQL3M4QkkwMm9OZmN3OFdGYU5h?=
 =?utf-8?B?ZlI3cFVaNTAyQXBvTmt3V2Qrd1V6Ukszb1ZRTXJhZGNjQlZDRjMvcy8rR0pL?=
 =?utf-8?B?LzJKZFJWSFArT2RhcDAzMlFZdkRYTi9uS1hDSFNYYk9qWTRFbnd5R1IvQWZ5?=
 =?utf-8?B?am5zQXlTWDdQREVWVG54VWIzczllZnppNFBoR2QzN1hoTWwrVFdYb1lHcmxp?=
 =?utf-8?B?NU5XblVNSkhoYjBuMHFXT0h6aVJ5RUpkN0pqVG1ydjdPMmZlTnVzOTdsdWVr?=
 =?utf-8?B?anNQL2tCYllwQjl1M0lCZ3pMUitSYkdMY1NzVElQM1Y1b040NUV0dTBhQk9l?=
 =?utf-8?B?Vk94NDhmdVVaMlZWVmN3UzVpUWtVWWk1ZlZ4YzQ3U1JPZkhYZFBCMTh6Mk93?=
 =?utf-8?B?Wi9mK0hqUWhueTJhQU1PZnJVK2FiSXFKSFo3Tk42MXBQdUVwVXY1djFML3Az?=
 =?utf-8?B?YUg4eUtxU0tLUGhtR1pjOGNrQ3ZvckI0R2M1SkJYb0dsZVlSMVNRZFBPb2s2?=
 =?utf-8?B?c2ZxVURhdTlvdFZXaWxVTXRsWVc2a0JsZzlFR3N1VEVMdXhJYWdzT3Q1d2Fj?=
 =?utf-8?B?YVFDMjdtTm56RFBlVWJHMzNkcFFBeTdHWkh0U1VpcDA1dytKNEEzZ0g4YmFU?=
 =?utf-8?B?MitrenlLSE5pSDRMTUsrMGRnSE1ZekQzQ0g2QzRtVTBaci9vNTd6VHVaY1Bx?=
 =?utf-8?B?U3M5M25VYkJzVEEyaTdrYUhJdHpaZTA2Ym9VbDRqZzdGSTNPQUovb09EdFJo?=
 =?utf-8?B?aHRFMEo5ZjlldnVhYXNIZ2VnWnZuZ0pvODBMRWswQXpJVDhpZU1BOTZaQ2Fr?=
 =?utf-8?B?azJ0K0crUGdvMFJqaEVtRFFTb0w5eEEyYzRXbmVpVzZlTGtkZmdIcXN1dDJF?=
 =?utf-8?B?Y0ZXeHpMWWpwNnU2YWRKckZ6NGQrSk1WWmwzTmJjekJpNFU2SnVnUlU4eHZC?=
 =?utf-8?B?aldNeVRUcHU4RVBNN05ZbjFCTHpNMHQ2UC9SNk5tcENsYjJ6UTRTVDR5eGU1?=
 =?utf-8?B?OXFuL3ZNRXdzVHJHeWhzTHc4SUtyNUp5Wm9XR1IzVTk3R0UyV3ZvdE1BL24v?=
 =?utf-8?B?L3FTdW40NG5SZVAxU01VemlBSTYvTjZPSTFBUWhNVmpMaXkwYVFpdkhYN0Zh?=
 =?utf-8?B?WEVEK2hjcFdrMXZGV1E0U0ovSHJ6OEhGODdhQmxpSHdPTm1HWDVqOVVoUVV1?=
 =?utf-8?B?dzF6enhmUHpLMTNUMXYwUkpRbTBMWFQ5WVQzdXlDNnJLbzdyYm9vZyswNzJn?=
 =?utf-8?B?eGhTZ3RDVVNDVnA4VkdLM1c5TWhyY1Zyd1pvNkYrS1dBMWN4S1pINDM4SXM1?=
 =?utf-8?B?OWlybVNkQktlOHJmTVN0S0N2VlV1eC9jQ3hSemg4NWpXR3ZwOHh0cnpsVWdw?=
 =?utf-8?B?Q0lEZVFHTVJBamZVOXVFdW5zYkZLVkF3MXl1RFZicnhqQ2RDb3FyejhMTmR2?=
 =?utf-8?B?a0F4SzlnZjdRKzFWWDZKVFNuaThwU3RoZnhERVpKeUdXWm00Y29BY29POWk5?=
 =?utf-8?B?TWpwTkE1Tit2QjVkZklXdVRIUFpwdnJGRE5tZkNTcDZaOFJsaUlEdlJLNjNC?=
 =?utf-8?B?MDF3dkpKQTA5SFQvdk9NUGFGTjNtY2hHQzlBRHJZa0IyRlJjakVnL3lCU0NR?=
 =?utf-8?B?eXQyNjNvb3JQQ0pzeDZpcTNzb0VsRy91MUJZdmFsS0FWMzRwY3lWNEwzZDNv?=
 =?utf-8?B?Y1BaeUVaWVFmeFhibDJNU1RXQVhWQ1JDZHdGK01YWVpDbUFaZW1xaWluT1py?=
 =?utf-8?B?dzBkc0xUZ3lCaUxYV0ZFTlVPSGtWYW1yVzI4SHgxK3g1aFJxYTh2UXhWcitq?=
 =?utf-8?B?YXF5YjU5Q01iK05BZEFyQmNucUFHamVYTC8wbXJpdzQyY21acHU4UVZYWmw2?=
 =?utf-8?B?UWhhZXNZRzBjNWJselNPRkpzaVlDNzR0Tlp0RDJMZzNzZ3NCRjJiZGlocCtS?=
 =?utf-8?B?aHVvRU12bU9MNzN2RDlLV2U0alhmTFExVzVwVHQzMWxXdVhsRUtIL2xoRTNU?=
 =?utf-8?B?dzlwbS9kU2poTXBidjBuTkw3M2lrRzdxS2NLb0pPMkNsNyszVjIrV3FKRTFR?=
 =?utf-8?B?SGNyWU9KWkJzQjZldVNlYWVHUDhYa1BDZE1YODY4R3I5UnMvYVE1NXhCSDRB?=
 =?utf-8?B?WVM5dzFMVTZvRStWZGZkTU4wRjBWeFV3dHVCYUphSnV5RUg5b3BYb1FqcEZI?=
 =?utf-8?B?TjVKMmJCWnZ5QVpMNFhya2k4a05sbG5aR1UyVkFzUWVMcEc4N1RXcmE1SG5U?=
 =?utf-8?B?bFZOWWVJWEx4UVZveG9RWlFBM3E4T1pkWE9ySFU5RlV5enEzZ2VzcXdocFRH?=
 =?utf-8?B?ek1NOHhaeTUveGVZZ1FtS05qNSt4bHFCbmg0THhBM0V3S09Fc2EyaW1NNnNp?=
 =?utf-8?Q?27SaQzzdYU4F5gN8=3D?=
X-Exchange-RoutingPolicyChecked: DmJ6eynKmI+Pzf/gcAZ4kRKTFrD851gHysjl0PGgeNtnVG1ayW7fVujG8e1KDZcZYjiBq28DZkF9l84hPN29MSRR77oKqG5sWBcqEgzVvEKeMYP80ug1vlhoaDC2kIgNrsBXf/AZlLeHbFouUW9wlznbl4rjf52ByhPpx7De2O7n7sw2sn9aqtlWHDjsImrRYo6Ho0+hiPFv7tD5sVGxQELp9Xm2yySQ9B8zWmkEVvxj3653yTmOeZX1wmres0xMRifhyqFhAKRBlLKRKdKQKf1LEBK4Pci7jadqTxRcvOp57RceO7kqwGCxULKGmGF63Nr0y+MuYhMrjJ4NmZ4Rfw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d119567-c1ce-45e4-23b3-08df36b8155f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 19:00:37.1810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZcjQNlGiB8gff2SiohhweOL4Vs8TnvpvgKEbNa4geOXht0epLNFMzshyBYTGn6kPgR+/jwqDyog1vmee7huiJHKiz4n1wtQkjRbX3mR0tCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8796
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 04:47:36PM +0000, Paul Moses wrote:
> 
> 
> 
> 
> On Friday, October 30th, 2026 at 6:45 AM, Maciej Fijalkowski <maciej.fijalkowski@intel.com> wrote:
> 
> > On Thu, Oct 29, 2026 at 11:37:20PM +0000, netdev-bot+sashiko@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 1 potential
> > > issue(s) to consider.
> > >
> > > Critical: 0 · High: 1 · Medium: 0 · Low: 0
> > >
> > > If you believe none of the issues are legitimate, please reply to each
> > > issue of Medium severity or higher and explain why the AI is wrong.
> > > If any of them are legitimate and you plan to respin, please let patchwork
> > > know by including "pw-bot: cr" as a separate line at the end of your reply
> > > (one such reply per series is enough).
> > >
> > > - [High] At this commit by itself, the new first-buffer test `!skb &&
> > >   igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)` in igc_clean_rx_irq()…
> > >
> > > --
> > >
> > > igc: only strip RX timestamp header from first buffer
> > >
> > > igc_clean_rx_irq() used to subtract IGC_TS_HDR_LEN from every descriptor
> > > with TSIP set, which truncated multi-buffer packets. With this patch the
> > > timestamp header is only stripped when skb is NULL, which the commit treats
> > > as marking the first buffer of a new packet.
> > >
> > > Link: https://lore.kernel.org/all/20260625-igb-rx-ts-fix-v3-1-99b3efa08dca@aweta.nl/
> > >
> > > > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> > > > index 1fb5f3cbe93c5..41b293dc10c3a 100644
> > > > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > > > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > > > @@ -2639,7 +2639,8 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
> > > >
> > > >  		pktbuf = page_address(rx_buffer->page) + rx_buffer->page_offset;
> > > >
> > > > -		if (igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
> > > > +		if (!skb &&
> > > > +		    igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
> > > >  			ctx.rx_ts = pktbuf;
> > > >  			pkt_offset = IGC_TS_HDR_LEN;
> > > >  			size -= IGC_TS_HDR_LEN;
> > >
> > > [Severity: High]
> > >
> > > Is skb == NULL a reliable first-buffer marker when an XDP program is
> > > attached? The commit message says:
> > >
> > >     Only consume the timestamp header when skb is NULL, which identifies the
> > >     first buffer of a new packet.
> > >
> > > Suppose igc_xdp_run_prog() returns IGC_XDP_CONSUMED, IGC_XDP_TX or
> > > IGC_XDP_REDIRECT for the first, non-EOP buffer of a multi-descriptor frame.
> > > Then no skb is built, and igc_clean_rx_irq() moves on to the continuation
> > > descriptor with skb still NULL:
> > >
> > > 		/* fetch next buffer in frame if non-eop */
> > > 		if (igc_is_non_eop(rx_ring, rx_desc))
> > > 			continue;
> > >
> > > The continuation descriptor still has TSIP set, so this check strips
> > > IGC_TS_HDR_LEN a second time. If that descriptor holds fewer than 16 bytes,
> > > can the unsigned size wrap here?
> > >
> > > The continuation buffer then goes through the new-frame path:
> > >
> > > 		if (!skb) {
> > > 			xdp_init_buff(&ctx.xdp, truesize, &rx_ring->xdp_rxq);
> > > 			xdp_prepare_buff(&ctx.xdp, pktbuf - igc_rx_offset(rx_ring),
> > > 					 igc_rx_offset(rx_ring) + pkt_offset,
> > > 					 size, true);
> > >
> > > In that case the XDP program would see a data_end about 4 GiB past data.
> > > On XDP_PASS, the same size would reach igc_build_skb() or
> > > igc_construct_skb(), and the __skb_put() there does not check it.
> > >
> > > At this commit, XDP with multi-descriptor frames looks possible on kernels
> > > with PAGE_SIZE >= 8192. igc_set_rx_mode() only clamps RLPML under the
> > > small-page #if:
> > >
> > > #if (PAGE_SIZE < 8192)
> > > 	if (adapter->max_frame_size <= IGC_MAX_FRAME_BUILD_SKB)
> > > 		rlpml = IGC_MAX_FRAME_BUILD_SKB;
> > > #endif
> > > 	wr32(IGC_RLPML, rlpml);
> > >
> > > On large-page kernels, RLPML therefore stays at MAX_JUMBO_FRAME_SIZE while
> > > igc_rx_bufsz() returns IGC_RXBUFFER_2048. igc_xdp_set_prog() only checks
> > > dev->mtu > ETH_DATA_LEN, not the hardware receive length limit.
> > >
> > > This needs RX hardware timestamping enabled, an XDP program that returns a
> > > non-PASS verdict for a first buffer, and a peer that sends frames larger
> > > than about 2032 bytes.
> > >
> > > The next patch in this series, "igc: fix AF_XDP receive buffer size for 2K
> > > UMEM chunks", adds igc_set_rlpml(). It caps RLPML at 1526 bytes whenever
> > > XDP is enabled, whatever PAGE_SIZE is. It is called from igc_setup_rctl()
> > > and igc_xdp_set_prog(). With that change, XDP frames always fit in a single
> > > descriptor, and skb == NULL becomes a correct first-buffer marker.
> > 
> > Wow - finally.
> > 
> > >
> > > This patch is tagged Cc: stable and could be backported on its own. Should
> > > it depend on that follow-up change, or should the two patches be swapped in
> > > the series?
> > 
> > How would we make sure both commits from this set get actually backported
> > together?
> > 
> > >
> > > --
> > > Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028083344.3047350-1-p%401g4.org
> > 
> 
> I did forget to tag yours for stable, so maybe the will satisfy it?
> 
> I think ultimately, it sees all related bugs as one big problem in
> an effort to catch adjacent. My understanding has been that unless
> there's true interdependence of patches, ie. kernel will be left broken
> unless taken together, a series in itself adequately satisfies this requirement.
> 
> Should I do a v4 to add the tag? Or can this be rectified through 
> intel's process?

CC: Jake

Jake could you make sure we tag 2/2 as stable backport candidate?

Let's not send v4 and start the whole process again, bots are rather happy
so the ball is on tester's side now.

Thanks a lot Paul!

> 
> Paul
