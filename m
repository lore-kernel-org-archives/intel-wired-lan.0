Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D616C61DD3
	for <intel-wired-lan@archiver.kernel.org>; Thu,  3 Sep 2026 13:20:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C8306810DC;
	Thu,  3 Sep 2026 13:20:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0exv82x-Nbes; Thu,  3 Sep 2026 13:20:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5B3B181099
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788441650;
	b=YmG1JbMLcCs78Voa5gPr+uw0RegaK6ErSuLA75EJ3T7SMkWVp2yjXYTJKiVIlBwK0qxo
	 ZTugGLsz5Ozy46+jRSkM09BKIf9KuvzvAHMV67nWgnWXGF3G0cwCAoVjClK6yUlbC/oyv
	 llVC6UVkaOvK9/0Ir4N4uduRhcFRsHKCqR2qX7XJ83KOg3yLRN2QqzoOenw5877x9YCGT
	 B9XkD9il41D5+I7eFwTNuk2+cda81Kh0rYzhmJINhkbJbALWART6iCuAaYl5J3hOwP6x0
	 LyNMshUjan/Gg5dm5JcoaXiqxz1yP2LMGOqGQw1wPuLG+LBkpvqjaMfFl6H6LaNCTfg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788441650;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=kHQm0q52Z5fe7jzQhTDgSy5blIv+xHar935aVlhBrOI=;
	b=YHWMD3iLdbC0D/+ifJe33IdRfx1LKWwlnlo+SVO9DVSM1qPGTCZ1DQxmEvOJjpUsvKsU
	 rQzhqSzmP6htWEwF32Whgayy5jGKMdxvbL5QJQKj+ErtzdYT8rviGfcuXbRQAYb7qFg10
	 ronmru83XYyG4XUi5UoqdAK1IS5EjNKSwJcw1rzl2zp3K++xd8LzVARey0twkZqSUraqK
	 pXCxRNMAciL14IHORlKY7zEfYjaKwxbDLZc30/HY/F/VFVFXc+HY0vLBvnLHRfN4dFeMn
	 8N1WlHJDPABmky538MT1RXaAiJDlj4G3OHvozN5gF0hZQJUh4NaUaWBTo14CYCMJZsw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788441650;
	bh=kHQm0q52Z5fe7jzQhTDgSy5blIv+xHar935aVlhBrOI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=byhyiHqTt5XgmBTIzJ02g57MGN5Tp4wL2EEcGW8lIrhilHk5iwe2P0ct5EmEakubj
	 Nv80VANuGzpco/hfBlOdF4TCUIzOPdoh5pEDYRIYg7IeytE+SNzoOdvbq/EVBtgV58
	 kqPiIBip72bvRzHCGawH31dnZkmqoBpEap17PakDtqz0VHLHXZukavY07JBvgYi26J
	 xiSfqqSuzjF0m1V/MXlbeAil34u/52BZ/Q9zR6SDPpHopDB8HNQWgJJ30LQtClf/KO
	 msjk73ZgjPp9WwE5kAbiMRaRAzAbWKvz+T3sdigk7BpohxrU+J5cwLzVUBp8+8YaMD
	 mDq9FrSbMamXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B3B181099;
	Thu,  3 Sep 2026 13:20:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AF81122F
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 13:20:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A0BBE60B6B
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 13:20:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f1IbKm5ZRK42 for <intel-wired-lan@lists.osuosl.org>;
 Thu,  3 Sep 2026 13:20:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A66CA60B4B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=52.101.193.9
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788441649;
 b=DWmUjFsSVxcJi0EyLFq56cNXWa7JIJwTP9qM4vMDejLe2DqqMP8WPRA9VzL8tG4PaQoL
 L5bptPfleRHrjxZTClkhO/0fXNb8EthWnr1YlgRiP2cms/1Fk6+2Oxh0XsmmfbgHdL9vQ
 6NYd+6PoMl3GSoXySaqUBzyXdxAjgllV3sqRZPKB59L0tXo51Gi7Xr54wCE5wM7ZcBY1N
 PLKQ7WrXP6DWshGS4m9jR+SExNQyhjQfx/Ls86/Kj4I/9c6FHtE/fOXmJB0x+/6n1Yqzo
 vWm7Qvpcvw5Po/q6HG+OGuXlo7qEkKvXyXhchrWYeM3uI0HnKknqqNsNEV6J8W818qA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788441649;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=kHQm0q52Z5fe7jzQhTDgSy5blIv+xHar935aVlhBrOI=;
 b=n73uZtZ+xabsD/XG+gu9OQMhiln5rYlFxAguv5YA+SFE5yJtA7Ss3yisKMAwkVADFjry
 GjJPbEbxUMCkewKq2rnfDHQOZnXt4z8Jj7kPfCscemXQDWrKzx2qPNNB3Jvd220yjr/1t
 Cqyif4b1dwAaakFo3h3XaGqOPze7oM+WW2jTR3eeG7SEVkNMM3ueInN6WHOmzq8BGZ0YP
 v5vuzVELOU9kp+Z00o3J1IgjhXsV40whq2WlIzcAw8jKSmeKJGtKQg9hPyL0ndkzr3HJf
 muNsaVPwLeFfo/4wUm4H3SqLDgCZD6lT1XnvBs1Xszrja2y6VcK8iFhD9Y5wBEZ6DuQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=nvidia.com; 
 dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=kRtawYFa; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.9
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=52.101.193.9;
 helo=ch1pr05cu001.outbound.protection.outlook.com;
 envelope-from=ynorov@nvidia.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=kRtawYFa
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010009.outbound.protection.outlook.com
 [52.101.193.9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A66CA60B4B
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 13:20:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pwZUPk7NIFS7x+8xIVwuekIYv1XjPSxToA+G8owWhCJl1KTVKc8RlWzOoDpVp2xXhVqtwsWA3aXkFaXEtpvNimCo4rWv89XT7ev2VGGW7sE9qSKvp7CJW9m8JWKod7xOKEL4EV+iK3zJ730SHb3K3C1UiU/LktgJALQHX/C8N6PPT/fTx1Hjvz7oP6kU1/YZZqMfXjEPKotsQPtFQZEopyD7lKJuKJyobZOB5gEIuw81kN4ymp94lW4UYQ6u/NLyQwQixSHmvBSA9wLamG639J4Xu+xTl3Uj2VoxakXdqzHFLvsfUBGrOXFZ/2UC50E8Kl6E1X9sonbu8MYm2GsRQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHQm0q52Z5fe7jzQhTDgSy5blIv+xHar935aVlhBrOI=;
 b=SodSoXzQZjWOlQ42noqpII419X/xl9+2Fg87mhQPZHlqEc0/RO4M+VVPpKnJ5N/lAlkFVVYneiTLT/Ov6P62y+93S2rinXNaU2LJK2Zo1g0E+pXmc6bUpuZ4/yO3L8BOtoDxvdG7bOFfjKcDUJKTrjBfG9DTPwWPwNj7lMBeQREU7R8xFdT32g7nuzOTReKSN83GBwPTXMhCDafB/1+welWa8q86LvGzLdzI9M2+QOEK50xoAQaGbSEp98TrDdqONrI/hCEXEOD9X/FkMDWA6Cn1a4InH+H47ewP/4cri09bnkGALRfGcpRjkNslEb3laG0rqn9OALlr0o4DxpwEfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHQm0q52Z5fe7jzQhTDgSy5blIv+xHar935aVlhBrOI=;
 b=kRtawYFap/2x7rljuDp7XeMOoKJWYxG26jHOh85pJ8RW8XXYr91sTTcTkjcuceHlc3FtiZ3WbeuSTFAL9mETs+XYJsvDdjEDSUjHdQwj/UVFa9ukvTHr/JXCr2OR6YkEnIetyaf5JdwHRHeyvV66snHw7u3MkczYc0CjzhRSK7+CC+HIvpasQrY4Ln8EhLrmxTDrff/BL36PgfP+8ug+wPt0s5qCOdTRenSHjBmHI1505SVxhxYo/2TYouPuvwV5vdcJYaHqHhdd1vi2MYl8a/CBdw2KVupZalkfJztODK35c32R7juvwPBkTdkAC4Ig6r8B1lrPz9IPXTcuJj0iWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by MN0PR12MB5811.namprd12.prod.outlook.com (2603:10b6:208:377::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 13:20:39 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 13:20:39 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org (open list)
Cc: Yury Norov <ynorov@nvidia.com>
Subject: [PATCH 0/2] ice: simplify PF nominal-state checking
Date: Thu,  3 Sep 2026 09:20:34 -0400
Message-ID: <20260903132037.81346-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:208:239::29) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|MN0PR12MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 34648ed9-dc16-4deb-ccdf-08df09be25e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|10067099003|11063799006|56012099006|18002099003|921020;
X-Microsoft-Antispam-Message-Info: KkcRylHjViEzqcLx8waIIruh+fINJDb/jXriRnSoicDhBLNbhW/LO1FgL68HSnM2dxCKtmViFx60XLgfZ3aeoHvASifDyB3dLLcvcU6xpzteevlFv1bgZm4+Uro4oR/Ba8qmXLPNy9mptHfdj1IFRDwtSVtZdrTJV+Ci7RwAmS3GMyAPSPp0ORAwrLEi8/isDD6J6jimUz/OJIJJ4x3P4nCudja6iUct70Pwkyv3UN4X7kA9V5vize8JiYUOxlH7q8MmDVFz6eYazX2XI32omjApCSUAy7ODWHmRwlD5SO2dr3pmaBS2PxqyuewpH6E90kpFKNaLbczJoNWphsFWDEN5P/xpWPu+MWagrdHx5sEYi1w9ZHTk/YHjt27iYCktJ9krsuqzXuN8bcF0FiV6j2Y00iRdhEmLBmIBtpIQjo6JXea+arDuCevr3q0KwItyUe8zt1sr507lzo++A+FJcOiMd8rgHOYADBh5LhWG3F1zzXWKBTEVcksMM6Ouli/SbxDRSEgTPE2oVaBvLvdiBWMHp0H7ChyVaYHuTqHZmnN7kbOUrB174Fsj3AhgJEEBP881l29zkAsLzKxBJ65pTKujRQnN8PbWmQ2gjQlPMsAinFX1y3FrOOuH86GnO4dhek5yxFBgt6TkRjtA2lF0GNgmvnMWnYyk5rBf/ohp+2hE4G9gTIvo4LuCNJLPMh78UotxbC075WrZ5sfuaZV6qg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/b5I746Z/f6RiBQ24CUFIlg+CP+NzpDGgP3AJ0fGDbG+Mb14C+EofmuVBi+U?=
 =?us-ascii?Q?TMcBrMVj+JS0a7M1sPZQyz5OMzqJXyDaSke828QbfgM/GR2tqJBWS1juv+Qd?=
 =?us-ascii?Q?8j6ZvYRu87Z0G+sQ1yiKqVf8fJY8LC9hqgIl95WSGMH3wZEdByGeBOJ5MEHQ?=
 =?us-ascii?Q?GNhwJxgIBw60rmo/1MjAqjDKIUJlFC0/V7LQ0OC4yD7m9/Wcfn35NV4O0XO1?=
 =?us-ascii?Q?3DFI9KFqg4iyB4GLuZNtrteYSDJqyYDhtBOlRC6a2zj2+kgs1lzi+hNcu9Gx?=
 =?us-ascii?Q?ngK8yn6GFFZfck2HzE7w3eZLtR7DDE6l9Zlxy1I7uuLY71QmtAHIiiaM9QJw?=
 =?us-ascii?Q?B84wyfrc0jpUqSzOyx+mV2U33UXEAAF/HC0ZWeUienPlMTBVWCkkWBj4TcPx?=
 =?us-ascii?Q?X5m5FhzKkLbC5ujjL296tNSFW9uWGXBLUQ5AE0BPCkzacp5rcaxvhdMAakRA?=
 =?us-ascii?Q?WStvizfEsN8jPHWsa63cjk4DqWzH5KZ4kcCrId5hSI09mYxSKjkyUdilFCGN?=
 =?us-ascii?Q?IytrcQlqkW8u7/6dI+QAfg1M1NzVlUu9WClV+V2zom6UGzMiX+q0Ab5Vl1g6?=
 =?us-ascii?Q?GNTHADJr718vHAQRxkf8FdD8xDvNmIZLE/hfE7wpEaudrUZZEvVStylOzmV2?=
 =?us-ascii?Q?n4NHpqNP3mLrceFwDdaytfgVK9s6iFIuY5x122FN/+TSEpnI0Tl9k4Gu/8VQ?=
 =?us-ascii?Q?iMuCcM+pt2pN4t2cOZM8xKLBGBy7HjI1h2D3knY0EkQf0Yq0wufptsp1web5?=
 =?us-ascii?Q?3X0yjqhvwEOSuvMylvypZWxiCDTRVCN1BjqNb3vv3q9CadknGgSniWi0Mnm+?=
 =?us-ascii?Q?FEUwOFMPC80kpjt7DfGe8knLvoPCFTRxIEDUIyeaZKcykDc7BQbiv/wXHDkr?=
 =?us-ascii?Q?XySqCLdXr2vpn07CbYFSNoPQBnnI4NXnZXWXmylENAGiWaC05Vr+60nKVdsr?=
 =?us-ascii?Q?tN2Fbnip3sSFygk2Uhp+WrVwluRNGU4Y7T+81uRqhMGi/AcmcYj2Nf2zLXWV?=
 =?us-ascii?Q?ZFwtorCHlwG+Ja8OmVxOvY/U+w9XCGI7O69xnp9lzymczZxOpX+m86UC4IGq?=
 =?us-ascii?Q?rRxnkq66RXChtb7C9X4xaLUJ6R7uwInvUDwQknMhHcaqVll5YgH1r6b3tPz1?=
 =?us-ascii?Q?jU0z9pZWAARfaYHF9E9sfalHZ1E8S6X5N7brOg70u+Lc8QGdcJHp6aCZzFtD?=
 =?us-ascii?Q?dl0h+MvWSYWbci+dcfTsucWV7vYM+2Tjq4lOX//9g4wTbTNpNleSm+2Lor3I?=
 =?us-ascii?Q?2jh1UzL2x5OFy+K5LCpR9WafvPbm/P/M7bU+6x+YQwTH8SAsHtyAzIVSVDoX?=
 =?us-ascii?Q?ibzQUHFtvhwJ70+vzueP+jNOSI1WnwqmA1fAKa0WC8mMtAIghOp/5zGfgnt0?=
 =?us-ascii?Q?nFaICwa7nhpN4DNWapdRx85UnQfSjP/EbEAKKQBzg4ELBT0d0BimHEr7xCsd?=
 =?us-ascii?Q?+y556HyHvtoCmdSRVnD6J2VBj2DFSPITiWcfyelS1RdH8rady95AZ5fMFgAy?=
 =?us-ascii?Q?lHsGcT2d8yGU69AdipTorQGJRgGnBgs5R4vp2spSID7R58ncZnl36mCxjpBL?=
 =?us-ascii?Q?CNu4mgxeC+h3CR0TOOoYZr75KpCDVIIww88NJ7AlDScJxi8R+p1HnAHKV0H2?=
 =?us-ascii?Q?yAreNHpVh7A+Mgk9hOfLCiYRYSTCLcC601rUuviMYsik5slLf0skWmTgg55a?=
 =?us-ascii?Q?dDtUwkDLmQtyVAvtTPr2oCyMGJDoKT+n5EoLknxA+phM+HlcU8e6vpsbmTj2?=
 =?us-ascii?Q?Hf+a0iUUzA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34648ed9-dc16-4deb-ccdf-08df09be25e6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 13:20:39.5670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HX9bREbYDWEFqEattGuYWUyQJN8mN/ywycG6gn3mT7mKqhijlTUKN/utkzTvWn2zJzsuLdMktigxzehs4Wgflg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5811
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

Simplify ice_pf_state_is_nominal() by checking the relevant state bits
directly with bitmap_empty(), instead of constructing a temporary bitmap
on the stack.

Two of the three callers dereference the PF before calling the helper.
Move the NULL check to the remaining caller so that
ice_pf_state_is_nominal() becomes a one-liner.

Yury Norov (2):
  ice: simplify ice_pf_state_is_nominal()
  ice: drop pf == NULL check in ice_pf_state_is_nominal()

 drivers/net/ethernet/intel/ice/ice_lib.c  | 11 +----------
 drivers/net/ethernet/intel/ice/ice_main.c |  2 +-
 2 files changed, 2 insertions(+), 11 deletions(-)

-- 
2.53.0
