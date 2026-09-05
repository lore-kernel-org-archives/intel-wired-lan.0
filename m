Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A378C624DB
	for <intel-wired-lan@archiver.kernel.org>; Sat,  5 Sep 2026 23:52:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3BD3C60616;
	Sat,  5 Sep 2026 23:52:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U-LQic4FdPoj; Sat,  5 Sep 2026 23:52:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 140DB6060D
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788652376;
	b=GPJJGmcJTxoINwa9x2V3AVN1UUz9WwgMpPntEc72kKpmhZ7iyMLZzCxanA64HsjDltog
	 hxizd0qZYIUTtTLL5nYD3hk8NKFEQsyMYxab+RDG2feJYDHo7l7Q00dp0nMZIBhoV0bar
	 si461huAitKk1Xe9+eLB1ZKDJeqM2Pfwt4rlLvL/U8nqxnm/7QPvxeTi6NPt2p5YnCUSs
	 lXeEleIFlLuWMvy/PKIZaNMNNBxiIUKMkupHZ9Q8lxhPPl/FxnGF6jnnQIkhejwJ9Nf1l
	 PwSDJSbEQ9cZjRIyeM8wA7hVkqnSdudwB2ZS28Mj86DrAGXp423aW+QoaZGeVhlvusg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788652376;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=43AYT6EtUtCdopr8nBPbAdfQAqtwZ8vZqefdxqOANgQ=;
	b=jZzBDSOIS/9u7asFOkip8zNVDPk93NExrflD7h8Bn31r09CUNmF/qMdEpPnBch8ha6Lp
	 B3DsR+aTS+F3TXWD6LbOdYLaVQNaMrr+B/c0/xhW5OSIOv5O5VtTa9sEHVUoQTeFiGYLW
	 yzPAjvb4Ax/GEXeqz66b/HjAAUUBN8lq7aonT7y5VEfoyTZ1/QiT0V0sH8y5bJboG8oC5
	 PSkHDiMxlwOfiM+jacd45JemaqeGv6soxJzh9Ja8v3Ux2BoD3jAHi24T9ukfzbQWiWhcX
	 ETxkqpb/kUQc0rEI88jT781wtnxCTeIXmwdnihkZ3+sMgKsNNzK4gk9j2BNL9Wi+QeA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788652376;
	bh=43AYT6EtUtCdopr8nBPbAdfQAqtwZ8vZqefdxqOANgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ElUF9vYh/QlcrFeK8n661TSCidAhjrjOYr49COMrO6vAUgQWnj2FbYmpBqrvPnbAg
	 wvLQqtzur6RtS66D2OwF5r0kdNSRtvJPxiP9xni61keVskgv5/Q1q0BW0iXPeVd4x2
	 7YSp1hAzDZhy9piNy+KM5joQjPmwWsJKYQQZ/9tY1P1qEwJaW8mqBnK8eXH2IIX6qz
	 V/4vnDF0b6rwodNvfJe+V3POmgA5SfHMbkfoUuAg91FLJ6P8ENwjBH3tI7O6QaBArI
	 vXGWwuCCh2whYWYifiFoJRwJToHHosPjQABrzbnHiwHUBwQnH2I2uGOzw/g1kuojv8
	 7jzb3RC9Ii5ew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 140DB6060D;
	Sat,  5 Sep 2026 23:52:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 781BD279
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Sep 2026 23:52:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5E48340822
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Sep 2026 23:52:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fxzG7tsQHrTh for <intel-wired-lan@lists.osuosl.org>;
 Sat,  5 Sep 2026 23:52:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F17F340821
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=40.107.201.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788652374;
 b=pRCTomY44bvaR9iKbwRRQEdYUfLo7n2A4jf7+WjI5QIu4OmuE2x+6ZyX/jc1i1mxxDfZ
 ltjsUqQCW2mx+O9Cp/nArQ/zm0n0hbafRT7YNnkcOaOQPO1THGaW5nL9r0R3/BlyrX5q9
 dz+iNWXRYi+mgpPT6RNutmIYrInhw9x3ArQz2k007Slk7eLO+pQZV8acA1yvdkkabLYr9
 pN6b11DknNSW3TaBFEh7KE1us5uM+1rC6UMrEVVOzOvEEJpzVsrk+AwkR0NpCRlv/OyxZ
 I/VR6NN22GYR+T/VFIwQnAA7uiEOnw1d9TJXzHaqHM9DOETTVjyCt/+NqPKX0zCjbzA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788652374;
 h=Received-SPF:DKIM-Signature:Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:Content-Type:Content-Disposition:
 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=43AYT6EtUtCdopr8nBPbAdfQAqtwZ8vZqefdxqOANgQ=;
 b=EmFwUTqxOIbFLukATQpNA7qXsBZas5rtJNvzNURM7SghuaL5K+aG7TcjrL9yaBtZEyuc
 F99gTHw9SgG/OO7okjq8rwfVzilX90gik9IaU4ppvRZyGIa4zaQnXHwfIBUONdKbHidnh
 KU9/silDJhMU86fAMkuvU1jTfONLGSlBjzWHHAV/RaqMAZloN6/E+nVca+VH7PXibqD+t
 GmMFkLnIpw9/76qzuSafHdsMNUkMz3NtnvXX1RdsvtFzy8uNcs7NyFAKqsf2U0lye1hyi
 NlfoJiZ7gvoR5ymWsqDRzZTdNZgzqIG1z4m+902weTRuKoMWCA9sYLDNdNJEUT7Glog==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=nvidia.com; 
 dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=SQjVzLxl; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.201.28;
 helo=ch4pr04cu002.outbound.protection.outlook.com;
 envelope-from=ynorov@nvidia.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=SQjVzLxl
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013028.outbound.protection.outlook.com
 [40.107.201.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F17F340821
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Sep 2026 23:52:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUC309Q7rQBIPSQk3ICh+gk7zQCNJiUfTY+LpfEust6ETMdOHPacqschGs6KLPugm4RMr8xr2dQsRwsR8FClAdqgbzDLQiNgIsUe/ugCUSHnUR6IHG6Knw2kZxrpeRiCsU5cRtmWeks4DK2sHLDcjMgHFVTA8NAaqANeBPFVSlbTTqkynRnxx4xVPTw2g8dgyV4xiIKWoiMAs4veVJSYmpCh9K/N67X7v7Np+15MZGUrwfFjK2YYWrqbEFGyZainvb7smyjjDlAM4nfkTET+TAJLN+TbTP7fRvgWIZEo8nvkKzBuxZSZfROKgeHo0DHlcQ6fFHo0TaL/aWe8ItqyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43AYT6EtUtCdopr8nBPbAdfQAqtwZ8vZqefdxqOANgQ=;
 b=dt7UdDdOCIIVzc/ZFLhEBn/0P5EdQFXxS+WDGMVZqwY5beU8OAt4QchW1k3H+rDhBKtFiRYo7jhvaGB6waELZPfNxFuJQeqfWD1uZ8dPzZZedhNKwNFvFhKsvpWjj+dGTrKmqH+X8+JD0KezpWfAwM5iw5rkaBSfJlXDUtcVrsJqenGl874tEjTvNx/JLupZmEEG5t11c4ld7tIs7yhXI8fYzQygTFE0Ea4Hh2IwlR3+wK9L03OV59JnXRJO8az89c/NJ+8SFFq1ozY0RadRn6Nge4WCiQ3qTG2Xq8HIZ17dQYdK12QxwXJIP8tZIRFA5C9TPWGX+OACKBe0h+dmmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43AYT6EtUtCdopr8nBPbAdfQAqtwZ8vZqefdxqOANgQ=;
 b=SQjVzLxlCBOavTRgx15PqGV3BO0UcIEdWq0h5yrTiFrfh+s6oBiom6kDxay1etYtJ4vCL3z1Liejtwbg9DTvT6xFN6nuP/eTHvMT/+2wfD9dNNdf5wP5LzL8IT9qeK5N7A2PoQ9vVsiPk0Egy0icyXKZ1feFJD3hIBdZoLUWLbz4fap69MvUzsaV3GmoJzGQguCHdSZQY50cpjFRsD5U35mUO1R9VB+PbUz2QKAJ2YcX/oHMq3QmLRldJ3W/tU2BWksyKeJvdN1hAfJjXCZNgm8r2cgl+Ou0zzxbCrk9QefvC3QtJYexOHjDJL4DNEleZLf0bl/0i5/Znyl+3TYnwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by DM4PR12MB5844.namprd12.prod.outlook.com (2603:10b6:8:67::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sat, 5 Sep
 2026 23:52:46 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0382.014; Sat, 5 Sep 2026
 23:52:46 +0000
Date: Sat, 5 Sep 2026 19:52:44 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Simon Horman <horms@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ice: drop pf == NULL check in
 ice_pf_state_is_nominal()
Message-ID: <apyrTFlAsrifzqzB@yury>
References: <20260903132037.81346-1-ynorov@nvidia.com>
 <20260903132037.81346-3-ynorov@nvidia.com>
 <20260905183245.GD40544@horms.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905183245.GD40544@horms.kernel.org>
X-ClientProxiedBy: BN9PR03CA0163.namprd03.prod.outlook.com
 (2603:10b6:408:f4::18) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|DM4PR12MB5844:EE_
X-MS-Office365-Filtering-Correlation-Id: a572a9d3-dfb7-4a48-5679-08df0ba8c8c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|366016|1800799024|376014|10067099003|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: OnktECSQmsleI/V5VtkjV/A48T4ms2YzXreJWQrmIYcLTDRLqQC3/4CR1XAYCU1NHzM3EUWTgfZLtqhe2sn1TbbLwpzxrW0+mZ0sDmWjMUupQBDJEB9GOi7PyzH/p3MGTOWsSrIvXcjNMzHfIC/64966D2k1ylMEn/s+ORaZxbg8RFZbb2d0Qe5bqLwWnCgYO9lEC6DASfizkHUYVb1z9+CIskjBitqV7c/nhDknwzVmU3PiP0jSeFdTbjNfURqaoK9hCaelHbpWJkE1fFAkptl+24EGZmlfY25XSkjeHAGRqHY+f0jRy1aAw1AgzO/N7CVBMsrxeJNMH5nQN13oQSgq8QhBlknyD0wDQmPiUArMza9hUs0f5y6iFSfN96Lsi51RvtpIZVKCon4j7xpkRZrFoLMOeqTYC5jxtlUPy3dFW6SyW6YiSASrru4oElmxs+DrG7pcvdQZvIq/ElEeuq6zL6DEMRgaGcGK/itcSAfqgRi7BJZKAdsIg41/274B5sEunXCTssVvqP3wz9q/N8BOuVZetSWGgL4TzAmcFDTWaF5Y76YP2jiX7MrsKvxiMtpb3+FFxq1SYWfpRpjwQozC+s2Y/9lcu/HtqM4XsAPuWWGrwWunOpgNMb9wkGjFQfCFDnLsZy81NXGAIXeMyWh6QGSRv8I3qit/6mPc6nc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZHq2vWylKw0lcRFTfcqHJZhp4wcNjtImB0CSP+OLhJSdGhSyZcNKDJyISc/A?=
 =?us-ascii?Q?wBnbzLJyyxW6YHDmAo1MYr8xSl0lQ/kBZ96eu58bydW4cc6/8MBlpj7vRTcF?=
 =?us-ascii?Q?7JJSquxk/hevfcqAUXfs45eftcySBpMzifLhZwbD5PX2R4buhS+s3/FkPRQT?=
 =?us-ascii?Q?P3xxIcUCIC1ExJAC58s8yuWzlYX4gHQGlaTZOSltGLryNcEQpJbhuDMGLvqW?=
 =?us-ascii?Q?ylTK6qCWFruvOdzLYynh72UC9O3UsQYR/DKWptE1m5zi95BiqNgfOWr712sC?=
 =?us-ascii?Q?68x2XKSB/L9wR7OS2oUiJREsFelrIMc/+h4LAj2XskUo7FGm7/m8f0/mmwHu?=
 =?us-ascii?Q?neEC9pQ950+yhst6EUU2CZlWbKX75prVO4NUCG5QbZNF/wAri0yKrLUZByKT?=
 =?us-ascii?Q?HLP/2Zu7Tkw1plhfmCK5dld6PWaFb5YBSTqCtD11jDpUbArAyqNtb1RyKT0W?=
 =?us-ascii?Q?cj3Ezo+mgp+2RBY5wqyEsbXr7QzgB/quonDUah33s2LlSDtT4+q5L+t6U3uD?=
 =?us-ascii?Q?3msOBhmzUEFQo/TBPW1xZt/AUzWT4AOy2yuqmJ8L/KLkJGRsLtJE7FLbca0R?=
 =?us-ascii?Q?/1DOaHAsN2AUvEronrYN5pwCpJojcn7m6hckcnlI4ob/C6vM6n3CE4p6Gn1I?=
 =?us-ascii?Q?BxTt11KzGGHTsbXBCuJcdVn1ZK9rIDtui7TVi4wb5SsiYGx4jf18RlXkUmkb?=
 =?us-ascii?Q?1WtNApiaprL5d8UwLisFJgfkZjZ1ZtJXMlAePqMJ7c6PW56Bx+GvJItZ3QXf?=
 =?us-ascii?Q?xoDZlLKwRDlXClYP65VAhCsQsB6LtB5bBcK6/2cxD0vb0qlPeh/mgMMzS90p?=
 =?us-ascii?Q?CGH7IQWDP69AVe6nezFOgrVuq6dYX95yVXM2ZdKWejeExZ9xVVchj7smLVor?=
 =?us-ascii?Q?wvGnbKWZrye+E5355p7WFBZwNlIM7TZPS3FrB4jlFGXCLFsAoz2NQ4ix2Eg8?=
 =?us-ascii?Q?ETbUf6YsuEk6uY75tsW1nYXGgesH7EstwuEqQt5heH+3XR/+PQKTdHEprsJA?=
 =?us-ascii?Q?S8ZLqcGoeMW5qjGWyxyHRHdgdEQ7nG980JeKx8fuIKOps2QQzR07VPz7EKMb?=
 =?us-ascii?Q?zyXO04FJb9RdVFnrHOxhvkdTQgA+qYkX2PSkaZbUZF8ym7mSrpQf7ICTPtSM?=
 =?us-ascii?Q?xKfBf3mhEfMPMFEaE45qDGZmYo7r3wNREVaee/rxrVTvkfByi5IH4HLJr7au?=
 =?us-ascii?Q?+NXm14i49yeuPDyXsOr/a5iL5w1302MdXzsASvb2Khap7clygC6JufErFt3o?=
 =?us-ascii?Q?4yMm7KXKR5Wv9PNs+weTIzC+SUr8/wd+PfIO7K6ZAiC/qxFcgNRcGJRJbW+D?=
 =?us-ascii?Q?IY7I5encxgyt/QM1isRcZ7ACLzwL3hCriv3+BeKRn6UlESMPJ1Au5+3FvJJu?=
 =?us-ascii?Q?llQI4yb0Efkp+aohiuYLhlg/ca74Y9aI7UBp7bzXIQbN4Acjko/yDZByJReK?=
 =?us-ascii?Q?ecc1gCVmfKJCNeRwwM1X2TYNfFuQQYUuO1stJa6+L4pwRaze0rDgkZMCU04a?=
 =?us-ascii?Q?gk/j8AaS1NOKE2XyES1yhASssz0nGdQHAdDez7BsKAYkX3uirGUtA8s08U8K?=
 =?us-ascii?Q?wMWLyVbbKxLX9M5HMZMqpN11S3KnKLh7Cpk58BrI3anPzTnZX9P9DFbTkjhV?=
 =?us-ascii?Q?BXkUl32q+Ee7LduTFTkGBaWViV/BGyPuoAdjkYmuI/yxpLrVLdlr3PY2Iioo?=
 =?us-ascii?Q?jQQFOtYB02/VxUVtWalrQx3+X49pvbRlEQX0M5A/E+xrMhWv/Vmi+jnnhh1y?=
 =?us-ascii?Q?Kgokchtw1A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a572a9d3-dfb7-4a48-5679-08df0ba8c8c1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 23:52:46.1995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNrjqmXCe6/HxBOpVZnW2VIXN87x8sumlSd+RxSLbMxUO8BEG1xyK4LGe3qNQwNlcx55E34jS9NvVS0PeklpTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5844
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

On Sat, Sep 05, 2026 at 07:32:45PM +0100, Simon Horman wrote:
> On Thu, Sep 03, 2026 at 09:20:36AM -0400, Yury Norov wrote:
> > The function has 3 callers, all except one explicitly require
> > pf != NULL. Add the corresponding check to the remaining caller,
> > and remove it from the ice_pf_state_is_nominal(). It makse the
> > fun function a one-liner.
> > 
> > Signed-off-by: Yury Norov <ynorov@nvidia.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_lib.c  | 3 ---
> >  drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
> >  2 files changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> > index 73996e3022ef..6d5b8acc4764 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> > @@ -1705,9 +1705,6 @@ static void ice_vsi_set_rss_flow_fld(struct ice_vsi *vsi)
> >   */
> >  bool ice_pf_state_is_nominal(struct ice_pf *pf)
> >  {
> > -	if (!pf)
> > -		return false;
> > -
> >  	return bitmap_empty(pf->state, ICE_STATE_NOMINAL_CHECK_BITS);
> >  }
> >  
> > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> > index d88835482d3a..168d85f9477f 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > @@ -5521,7 +5521,7 @@ static int ice_suspend(struct device *dev)
> >  
> >  	pf = pci_get_drvdata(pdev);
> >  
> > -	if (!ice_pf_state_is_nominal(pf)) {
> > +	if (!pf || !ice_pf_state_is_nominal(pf)) {
> >  		dev_err(dev, "Device is not ready, no need to suspend it\n");
> >  		return -EBUSY;
> >  	}
> 
> Is the new condition necessary in ice_suspend?

IDK. I'm just trying to stay on the safe side. The
ice_pf_state_is_nominal() was safe against pf == NULL,
so I'm trying to preserve the invariant.

If it's impossible, I can do:

        if (WARN_ON(!pf) || !ice_pf_state_is_nominal(pf)) 

This would imply unlikely(), and more verbose than an implied
assumption that pf is never uninitialized.
