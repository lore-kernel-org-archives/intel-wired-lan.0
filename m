Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA989CA5FD2
	for <intel-wired-lan@archiver.kernel.org>; Thu,  1 Oct 2026 15:45:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9C8D760873;
	Thu,  1 Oct 2026 15:45:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rL8xwpKnHRky; Thu,  1 Oct 2026 15:45:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8618860B26
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790869551;
	b=Ko2r9bohBfzoC6qM35Ogu9h2RSlH61rUgDFXXsMoq82a384s4n8072iBfO7et+aRpNwF
	 sB+oLqgMQKYpv3J6rfKH1MaS4WR7iw/tEKUuQrokWAR6PJtOl8oGles6G/X7DtK6KS+Vd
	 lHAD/pm68L9JQyC0MmU5624AJH9p/YvRfplyWqz8Ml+rk9sEajMlyNumtfsYElKzSv3cD
	 mklRJAfqFsAlUqwwX3fvaJScm5tuBly8+1Z620JNu83CksBVDVhC2ZFPsoUzZwCxnLzjA
	 C2nEgKSFIISdjBR25QbFPMLhPbCFLBcSs64LTwX56DZtpe1Q3aEaEqfGBy8y5VG+oZQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790869551;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qDE0qzmTQAKN9okg0JVXv/7ljl2EFhprvtRjcmNwCQ8=;
	b=OMKi4r2r4yexdhlOgpNij8e+wMtolhpply+lbzD/B8w0GHfbtykTRbJY+5DHdIhp27pH
	 x02xcBgGm+zeUx5/uox/ySJlhYzLMbMdBTnmYqcNZeXQ624X28UY/xNYf3PJfDjWiyqTo
	 8scGE+H2boM+uUzYYC/YMo4/vzVwpdvFmvv3+eg/RxD2d75J6+nL1QW9uFiBzkMPplUBt
	 ledX83nqUpxSaBYSTqtCmg4Xb4ABLNTyHjxDxYeMyyvXeFApDxOzsXfgqURpeOr2gt5kL
	 2oytSl/Pcl6ZTYcbr+CysauUCvBC55SUnQ+7CWgDRxIVWnTCPuySSOvsmygv1wWA0TQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790869551;
	bh=qDE0qzmTQAKN9okg0JVXv/7ljl2EFhprvtRjcmNwCQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L29WQpda0CLTjxEsO+rS6ejHd9B60Rf+pE6OcUIF6VM0Y6Xits/Lxc9iflSmqrzIQ
	 KMabG+JIgRs7wI8nWH+x3IJdP8nlmqU9HiN27nYjUJ3U2ov4zalpIcLUJDj3BJhAQu
	 dnfmTUVByXcUfvhrFAK/ikTcvDOkTj1l14AiXEKwZ5jN3LwSRvd6pKVXpCVybrYHXO
	 cKjZ4F/fhmX5lHhMUSaTTaWzSIF27mOcKA61ObniODULvy3Aj2NR1pe27XcHx714rw
	 Du9fLDIvc1Sn2e0yLIRF/GMTKSQoDH4/5t2XV5r1DTsJ/kR4zqWDfK5NwYY6vac0WD
	 tq7DTneITTS8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8618860B26;
	Thu,  1 Oct 2026 15:45:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3195E32A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 15:21:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 233814005E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 15:21:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U3qWdkPDYhYZ for <intel-wired-lan@lists.osuosl.org>;
 Wed, 30 Sep 2026 15:21:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 4CA5040042
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=40.107.149.74
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790781680;
 b=LF6KOast1hacHnbdaDyRpS13X0RW7M+FPIWCiHctr4jQ7HA6ddw4qzHNh/V8LkyVXtDb
 CPqPuLtHt4nOZ6BL4IcHsFqlb4tkylPx4Yf0NB+dTgvTQwgOEv6SMjoEWstvWbZQP4nGv
 2z8oqQzWO2DpjJvoD3YP1OKfISOmy4U/YV1XpvxcoXMyyT0WmoS1QUHes0TQQgI3fc2ub
 hzSGk5FFFgD1TkiO3yi+QInGsktwmFddZKhrQKEpwzw3QbaSxWFYqGmggTPkjqqDY0PYz
 4Z/vQgxPrJr1n2D6/CVC9qLbD3N8YCwad6ZMe1hbCy981Xn2enVp/4Z8K5OG7Wopmaw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790781680;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:
 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=qDE0qzmTQAKN9okg0JVXv/7ljl2EFhprvtRjcmNwCQ8=;
 b=gzdaoMTywVeSu9B/5Z/OvjqVcGMTQeAQtTUz9ECnGfc8EpCSS8hZgVEHKCP5H7AZgKjp
 MhyrzWkSJhGwL6pse8z6lNhcuzeed7StUb0rHQODNxo7ctKBxg7T/xeWyiTI1ZnZ1ETjH
 Kr6+zOOdqoliNwrNtssfUIiCxGRO/ouVff+8S9ZibwBpa2tmeN9+FNcgRsE574s2JkavM
 BOZkek95TUBF6do/ma9JniPmBW1/G4YRyQ3Xezim15qvwd+Ls3oEe8R/Ab9PnuCBDxJbf
 nb7Az2+DegLQCHrtEIqjUHm8a9evlkyQEfcZSHyn2hpZGpHufTqf6GYCm4U+uxcvGPg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=cyberus-technology.de; 
 dkim=pass header.d=cyberus-technology.de header.i=@cyberus-technology.de
 header.a=rsa-sha256 header.s=selector2 header.b=CtpzKyun; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.149.74
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.149.74;
 helo=fr5p281cu006.outbound.protection.outlook.com;
 envelope-from=philipp.schuster@cyberus-technology.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=cyberus-technology.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=cyberus-technology.de header.i=@cyberus-technology.de
 header.a=rsa-sha256 header.s=selector2 header.b=CtpzKyun
Received: from FR5P281CU006.outbound.protection.outlook.com
 (mail-germanywestcentralazon11022074.outbound.protection.outlook.com
 [40.107.149.74])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4CA5040042
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 15:21:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYf7Q56wPVQx+lmJKDLEmXTTsFiNix54B5m3h1H10wggI7haXA4RkysQeM4wUMAk5ZYbDtB1PNCd6PCivljffEr6pYpPj5SXSP4vXSaes0L7JC+fZwjFcgi8wDTWuR3IvtgULGZcwGsQzPBy1qgCay/J/WWx3halEHaVJ1zWTNmGfTSPmHby2K3EQs5dJZl1jemp45iM+o5aK8Q8MJizZUSp2N/1erBieEkh0z/9lmqVwJmWeqJIO1zvRBHe6BniRHLcqmfzH4rAoHDQtO58t6+TlQqn38sd0pr7IlgyUY56PdBmV3lov56DIwDvuwDjqkbyNPI6bnXnvQfr2bNlqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDE0qzmTQAKN9okg0JVXv/7ljl2EFhprvtRjcmNwCQ8=;
 b=QoDkNC77GRcWVKmknGObkg3JpiR1YiTEHMdwCV+RwZMe/NW+xvUoFX4wgdT4HOR6BUvyPxjr27fMYhWb7tb/QHGxdUfxi65FY3e2vNpHCNF8yL0bby3qRQrCSdehJE/j7Pm5e0VqWoQTRX5h6ooNURqFZ/Vmf5b2+7e0JJqQ/Kx/CTDu4PIDF7D2PtlCzOlWX8CP0iwIXgaK60g5NIbbqGaO2m2c5rylOASPJZy/iQ1gmi+TNpdO3AxCejEz0N4MFfVG5L5z//8r7OBe/EYUxRXbEAdNJ6jAhhPHeflzhPmstTDR7kKaLP/y07o7ffVV9o0JMKZKvljx1aG2fVsXJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cyberus-technology.de; dmarc=pass action=none
 header.from=cyberus-technology.de; dkim=pass header.d=cyberus-technology.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberus-technology.de; 
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDE0qzmTQAKN9okg0JVXv/7ljl2EFhprvtRjcmNwCQ8=;
 b=CtpzKyunLcr2VX395ucfz/poLWQPUF7KmZiBXy0wYpwkOMneIAEYyMg94wMOi/LDaja6D07/b69b+QBxQ/DEayagOXTOymOch2ajEihXZZZTtjjVdZnfLv7BRrbb7XrGIniBmRc5dHfAx3S1oWGoqL4wUovxbA8pAmdITKTAZzb+yA4CQy5tAxOHACQIKj73qUnk2zD4VWfVY9q2MjaDYRg+lWBvKuKpEq0edFGQyV6WcRpK2fmSQaRqYYBEDknsgPLrOcnyTVqY1+e/IXFysRqU6XTn4ylsIKvA6gkZSQiaA93Ov+nnHPeQr/LlsWBlKaR9SG1PWyyAsR/Jpv+5ug==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cyberus-technology.de;
Received: from BE0P281MB0148.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:11::16)
 by BEXP281MB0135.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 15:21:11 +0000
Received: from BE0P281MB0148.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3363:e0c5:e17c:912d]) by BE0P281MB0148.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3363:e0c5:e17c:912d%3]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 15:21:11 +0000
From: Philipp Schuster <philipp.schuster@cyberus-technology.de>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Philipp Schuster <philipp.schuster@cyberus-technology.de>,
 Petr Oros <poros@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>,
 David Laight <david.laight.linux@gmail.com>,
 John Ousterhout <ouster@cs.stanford.edu>, stable@vger.kernel.org,
 "Anthony L . Nguyen" <anthony.l.nguyen@intel.com>,
 intel-wired-lan@lists.osuosl.org,
 Przemyslaw Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH net v3] ice: fix packet corruption due
 to extraneous page flip
Date: Wed, 30 Sep 2026 17:21:00 +0200
Message-ID: <20260930152101.1503079-1-philipp.schuster@cyberus-technology.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <ah2qcDLxMlGYNhgf@boxer>
References: <ah2qcDLxMlGYNhgf@boxer>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:66::20) To BE0P281MB0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:11::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE0P281MB0148:EE_|BEXP281MB0135:EE_
X-MS-Office365-Filtering-Correlation-Id: 45e481c1-f70f-4e86-1018-08df1f06755a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|1800799024|376014|366016|10070799003|5023799004|56012099006|10067099003|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zlWG4N0xtwM8QvLwSTUCtWKHJPPAoqN3nSEgfGuwHx91H3tIBg/IrZbc+XKStvZegaO3q+dfTy9ZnYUp+nLhxo9RmtT/3wci8T/5rsF2YTqnY8Aa0U9IDpqT1446gmvoQ29jETtlNg24R/LSyEzWy+CEUycJs9PcblediHdbyhUzjMF/A1RI57Dc/R1YKNqgidME/Ix36u71N0NPRekhWldv0Z3HIfxkG1N9UK0caAl0I6Bk3wgl4BOQvHSBnLjkbwdRPTyJwbNQSQbk8tZ6g2+Ie0OUWHlzF8yTCvzE3pANvsHXtx/WuBcL+atlbudyfQ7ixCjD2eAX5Fo3KLEVPYC72swDBcnjeKfc2ub9jo2PicR06/C6L21APXFmPyf6SO/Hh2EKFq5DpMmKSqMOQFxB+6TesnNzxsDAGsKs1d5+tkBE0Ku2jlPGQD4V2lPCrO7pAHYTnnNNkET4Uzm3ie2jkZ1pZbHSsGVdG9aSQgTi1YxNpxh3chMnjyzwQXh4jwDl9Hkc21esZaUzH8lgIbCMC/wmz/W6COD0IkmV8PxKsMjEWk1fFVXvAIOs1U4RAemjbkePB4iwq02S7TPyMPzC5FT728ZdGVpImbeKL5L29IlF4mAkQAGPQj4B5kBncDuL4xhWksOjjitNJQABvbw4Y/XvMQfz8ZkRiT2C/JU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BE0P281MB0148.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(1800799024)(376014)(366016)(10070799003)(5023799004)(56012099006)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AWqvARL6uwumf58Ni7SuoTGA2pP/KOG85RL1JiF+LTkM6Uz2+8DpedwFIJ6y?=
 =?us-ascii?Q?Biqy/yA5l6E93fQRfkz5dVSvTsRUKxJ5DOdfkP19h1VsSGjVzpstJx56kpNr?=
 =?us-ascii?Q?cBgzOX9y8OtFz9HPhe40oY0OsR76qzgpSbn404v5STflLVhiR3mzJXNGW8z2?=
 =?us-ascii?Q?y5gNkraj92WPAgnVyNXh367NPhh4WTq1V3ihkFy2yYWh7braeZ5J1H6BBaPr?=
 =?us-ascii?Q?hNGg+vTt53OEFVP/hgq2NuFbs8mJ/mw0Wv55PYsEGgN9NzLXCJeN+vc5daXO?=
 =?us-ascii?Q?/XlCgznfk3hhLbIZAGBLgRzQkYZ9Fo5IRHStQaRlPhT7XkcGRogUZhYpmITx?=
 =?us-ascii?Q?jfT7JKA0Dd4oGL6mAyaFnA2XLBxnO+4cHGUm/0e1WlEr/EshuJ47K1QYM4w+?=
 =?us-ascii?Q?/oGqcmdukaCtXJ1PQIT2zcFR8COnCMfhjdPLYFsNajqrzcvz2dbR890eq6o8?=
 =?us-ascii?Q?nuVIxMFSlqW0mBViX7E2QLOH58zd1H7rYHKElCNxqAte3ltfJdqSeNt7X/kP?=
 =?us-ascii?Q?GUruFUAT1nRDIsd4BkQAedPJ8BARybzpHOKjNCBU8jjSJ0FBmVjLywxf04Nk?=
 =?us-ascii?Q?xaxyxbEVKuaw6ChbcA47bSrMtMzIZ+w4QWjXTKYieZnOuM/rH67LljU0W8sS?=
 =?us-ascii?Q?jo/Q0LgMK59rkxLmCny3Hw1QfvJZLOKBcV7HYklYGR8pmmUNgueA4kb2NMJX?=
 =?us-ascii?Q?fDD5uo6tWeTuTUxWMNozPlJ0OaD5qQDyVE7g0ZvteeEGBeUftJGf4OfqoS68?=
 =?us-ascii?Q?GS+oyiAOfihuvXnu/ZHz6ZBgBTvlikiUwINA1PFCP/5tuFi4tO6x4oo/ET2r?=
 =?us-ascii?Q?Sdr2WioTFJtaS5TcYKXDcNenvn2Am023WfyBJMv5w/A13Fq5ni4QUfV2z+Qi?=
 =?us-ascii?Q?3Ix3HRzoeOs5zuYP1H0BSL5RKsHGRX0HeFYkokL9zZjrBvazUTn7ZO0gAE94?=
 =?us-ascii?Q?/hiVQQDt35XXFvfhk7n7br870DVLeQz1YqH1S7K8u0hek7vtw+atWpXr1fDe?=
 =?us-ascii?Q?a/856pCJShNrCzWkPrWdo5hj0UwVPTf/l+c8McJM5Js87HRjVWN2pnf5LrRn?=
 =?us-ascii?Q?bMk3NMq3o1wpF6XgSNlwgxYOo0xTwasxL1vyEeenTrstduDIgdJ2YeLEcdbH?=
 =?us-ascii?Q?17XnaNKqhuLRwYc86NfKB/Wn6A8y2hfVJ4q6vaXyqGyKNAfAnK5KN43HlwT0?=
 =?us-ascii?Q?tFW+cMxJgVH2dFMGzHrxi/cxApf9IJIsfKFMhhwElin4t0FLYmVHwESDuLug?=
 =?us-ascii?Q?5aSxNDSmFo7wFQ8BEizy/+LZnn+4Ph+Sp7nLc3aFRx8o2qVk+z48I5lBPN/n?=
 =?us-ascii?Q?XlnI0jgPXmaANIuAVRyc/pDb/PkNgzGY6yMUw7CCafhmE36ZFydDP0bT088t?=
 =?us-ascii?Q?tHt/TWw+dOinA0Y6niLVb/n4kFXOPYIkTCDbRdeJuov0P5m5f2B2OE9PwZWO?=
 =?us-ascii?Q?CAxMQvjlDHmabFWcABoFhUXAPLgKYJ5P3EylleIXHG0Pqvnc4pgWMo1BpSmQ?=
 =?us-ascii?Q?bp8FQV4BE4LOfLXAZSly3pO32vxWRR1yiNKA+aNn5HN+hfu48a7vgGiVNyUx?=
 =?us-ascii?Q?QDWHmzb7uqBTOSoIAVDGU30wFisVbdQuZRqpWEQM2LsOt4E3O9fM1tpb/LlX?=
 =?us-ascii?Q?qSrN0C6hQ3z8JLVHQb1n9lTXGDH4A48OM6qnqYVRZ8Xtnbc8/B23zWYaL+ED?=
 =?us-ascii?Q?+RfaoZbXR7Z2bvuh4cLYAMbMhQMwIF08A+nboZyKpqKXvGom46Z1I4JBHbzX?=
 =?us-ascii?Q?AsAoJRIHOtoFa0gMgA/gie3qyNFKRxMo0wkEQPiOKcWkbELpF6dGg2dfaUhs?=
X-MS-Exchange-AntiSpam-MessageData-1: +q7yATAoNkAyXxEVRcrTNQgKMXEaF/NjzWZC0SMdhe+ROfO8IuRtgx82
X-OriginatorOrg: cyberus-technology.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e481c1-f70f-4e86-1018-08df1f06755a
X-MS-Exchange-CrossTenant-AuthSource: BE0P281MB0148.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 15:21:11.1927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f4e0f4e0-9d68-4bd6-a95b-0cba36dbac2e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Ae87/diGGtC4XfMtgbemojioWYcaB9Pq026vTPuTHR3GzdySQHkLs5sWK95Da1p/cUXepP2pnMS7JNkCXm1mqPBOU1PP35xGZUX33+orLKa9hbr0Aldin/sWDTAHHqd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEXP281MB0135
X-Mailman-Approved-At: Thu, 01 Oct 2026 15:45:49 +0000
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

Hi there,

We were hitting this bug pretty reliably in one of our setups and it
looks like this patch is fixing our problems. Is there any update on
that? For now, we've moved to a newer kernel (7.2.8) but it might still
be relevant to many folks out there.

I did not monitor memory growth during these tests.

A few details about my observation. Please note that I heavily used
an LLM to track down the issue and to create a reproducer. The LLM's
output and reproducer seemed valid to me:

I ran into this bug while benchmarking live migration with Cloud
Hypervisor between two hosts with Intel E810 NICs (ice, MTU 9000,
6.18.41). We migrate a VM with 120 vCPUs and 20 GiB of memory under a
write-heavy load, using TLS over 8 parallel TCP connections at about
8 GiB/s. On the receiver, up to 5 of 6 migrations failed because TLS
could not decrypt a record, and once even the plaintext record header
was broken. First I suspected our own code. But an in-process check
that decrypted 1.1 billion records again right after encryption found
no mismatch, and switching to another cipher did not help. So the data
was still correct when it left userspace. A plain-TCP test tool with
bulk traffic transferred more than 1.4 TB without any error, so the
trigger had to depend on the traffic pattern. At this point I found this
LKML thread. With the patched ice module on the receiver, my reproducer
passed all runs without a failure (432 GiB). Without the patch, 2 out of
3 runs had corrupted data.

The reproducer is a small C program (about 290 lines) that uses plain
TCP. To trigger the bug reliably, it does four things. First, it chooses
the write lengths so that frames exactly fill one or two 3 KiB Rx
buffers, and it uses TCP_NODELAY so that these frames are really sent
this way. Second, the sender is bursty and fast: 9 parallel connections,
plus 120 busy threads that simulate the vCPUs of a large VM with dirty
page tracking. Third, the receiver keeps many packets queued, because it
reads into scattered locations of a large buffer. Fourth, the stream
content is deterministic, so the receiver can check every byte. Without
the busy threads, 720 GiB went through without errors, and in single
test runs, leaving out one of the other conditions also made the
corruption disappear. Each corrupt block was at most one Rx buffer long
and contained data from the same connection, about 11 MiB later in the
stream. TCP itself reported no error.

Thanks,
Philipp
