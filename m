Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11A4CA9ED2
	for <intel-wired-lan@archiver.kernel.org>; Mon, 12 Oct 2026 21:12:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B903606FA;
	Mon, 12 Oct 2026 21:12:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qS1bc80VAQdY; Mon, 12 Oct 2026 21:12:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 032F660680
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791839561;
	b=W/9yZ3lY9brbVUcoYKLurp3xCetPekf4QrU6o0wsTBJlo3HQ3fYdhTMTOlPykJIKZMie
	 T5c+fg2FM+RFvrOOg4ycNp62FCqWR9gy3L9jXj/oC2mc+QFabnMn1Zb907wDjWlKi1jdm
	 kGqX/D8wqDXi1FYy/T5xwH24AQGEh+uGkVjws/f+Sq0HmCEA6JJytrrsvLw9gFYvr5lCG
	 To1OM4uIp5R/56xH7ttQcdCp3ydpXhNCKwsOjGX8FzHjIcEkf7+NihQTYIOflB9m9c/iP
	 QL9bAaBPdI02+x3+w1GNrkfS+ucUJynIO1K17KTuL0dRpRYQpJIM9VWrBAHEEkFZzEA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791839561;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=ja9ntG+tzMYb+Vs+gsr7sUW+0KSJ9yCDv0HIuAXjetM=;
	b=HwkQ7RvHflkxWh+51QfBR2cJyXE4xNG2fjexBiv7zBgQyS9SDhsxCodx9S+ls8JhxEDn
	 dZbLp5ve1k7WOA+/rdrEurGpFfsmojiMvIyiahrfmjpYaPFJ64ObsKWlbQs6o7cesPW/W
	 89oPSutBXkaqwQdUhehn4dVGtt9itb+fCTlN1P9/Dgpcv417WN5K2ftcMvEAGi7OZe348
	 rOc+UwDXEULGOp1PsCruwjNBrvkdW1VEmEng4/8npjYKkz1WjHBbZpT7SEv4Q4dcTx4Ab
	 MY+nz8bE8YHNwLjASgfb5hmId6ddrDxDAjUxPz4EsLlffs3FArfsABwkpwu/XjN7S+A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791839561;
	bh=ja9ntG+tzMYb+Vs+gsr7sUW+0KSJ9yCDv0HIuAXjetM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dqQlADiCyzUfmsOP4eVJwMG3YV5rbg2PDmQAozJZbNH0oRZbGGvQigIB6RivrwAwU
	 G2MN8YHUsl5H5wLT8E5R1fHU8QeyvOB/cyNIdY+0eig75SdikORJTQurWUhWg1aQOC
	 y1uI3BsXqbFEdFReQRTvNlQBQXhD9to7f5dQ06Dmx2dBfsrsHCk0Nl4RW+X6l1/5a9
	 6jC7rc/ctQqSZ92YCKQVi1n22DxEpLgHTdGOANys2SSTWT0HnXBYhH/xIBoNzVJyb6
	 ai1FaeAATatQi7JXb9d8o7srXdUbrIqdpelsrCupZosWnEqMzBuijVmdqy4J0QyCEL
	 /j1epVw2xdyZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 032F660680;
	Mon, 12 Oct 2026 21:12:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DF5802E0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 21:12:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C5A7740081
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 21:12:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kubz2O5o6i8f for <intel-wired-lan@lists.osuosl.org>;
 Mon, 12 Oct 2026 21:12:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3450D4002B
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=52.101.43.26
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791839559;
 b=tZdme0AsFLssDAzd7E4uCrs+2G+ZDj2e+VrpkwH4aluMxujc5bXwbVfPlXtdMRlU9fnP
 eYlU9w0eoWVz4J6LBcNZybfL3B7HZHjIImb/BC4uLoCcqaPpzROWbjaswnsi5DBBB30vF
 0a05bisCeh7AxxNZJhXmI/Wx7jrcBtQ0LvApIO1CwwCNLdfIrA7sLFQhuKvnDBJVQOGmZ
 QsAqUb7zrP0G9UNMj8z2o2cIP4yT6AN5L5n1RE/Anku6q+mK06r0WEoWsnQa8I7DPKpyu
 Y7l3ayrm/gEIWhYNBaiss7lIZqmehdQLf6B8dDcC8w18My85yuGdWnYcYUctwEO3xew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791839559;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=ja9ntG+tzMYb+Vs+gsr7sUW+0KSJ9yCDv0HIuAXjetM=;
 b=DIe8bOz//mTnnFSbpqGyyNWZs04a6wORsgKfKtsWg2JTe9z2Rvfn38c9ro8iMv4noL78
 qMB20EiDHrbIHJxh9KF1YP1jmwZh3zIFfXkM2+ckYHkWEyoKAy81n4BFU0O03KkNXT50E
 aELPtRTzxayQgHQQMYCH6Yze/o2b4l5EvWfTYhYHQmksI9UbrbBsD5cHfLDlvTmlaubfc
 gpAg/owgxLSyKDaaIS0m4gHdG6UoN9oRPd20k7h8hR5hGOqZXtmSmCxqUPWsrnCzUeBzq
 Ny7a4eSXehYluOsZ0K1Nf6J9aTgElwU/DsWbi5HAayq4yaJhgcnyhc4L/JYCj67y4bg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=nvidia.com;
 dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=jfObQLU7; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.26
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=52.101.43.26;
 helo=sj2pr03cu001.outbound.protection.outlook.com;
 envelope-from=tariqt@nvidia.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=jfObQLU7
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012026.outbound.protection.outlook.com [52.101.43.26])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3450D4002B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 21:12:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HpNm3VC2BrYH141VoNprDWQ2WCaE/S1qCSO7eHebrUhiXAM7S/OzGtn5fgaCgGPh/X1HJt5NEbXVX08gkLAg9oq3M3r8eHXEpGFnDmSLv5CPJzfp27ryAFUl4ap5+VoF4w3AsJ4iFB4mNKqFXW6OvuLeOgBKXseluZTU7JRxwZdzxUNGA+TyDIoRBucqgOZqkx4H/CxoxqGSdT+cuwnScQjrA+iYwtGPVty2d9oH97H65j7amSBUqXZRirb/Xzu0iag7ZC5AjbE7deV3UX2RVFYm5iAvBaTW3Tjp5lxC4t01lnSTFNJdEJ7ryo+jRIqzlJ30mEBAgS7x8R8HSn+tkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ja9ntG+tzMYb+Vs+gsr7sUW+0KSJ9yCDv0HIuAXjetM=;
 b=yp1tcLPQbuSyQixDhmfUNx/rCN3NjeGYY2/bNg9Y8z/1wmwTU6r2L0Wi30VDJMJ+r4QoBJPN6RKy6yvGV73J0EYynDykp2xv36SU/a6Y5PWcH1oQynxCp8sdOWuxegUAKNXHUrZ0rxvO/IAuNGVd0B1m2XFEOPLjVhH6rRvvVeEv/Fy7B8xmg0JIXCvRlO7mHxFRu4HuzQT8c+ehAd+iAjXQniDlRjdufHYuZBp869D4FwX+5EU5Nsp/lgGefkwzP2RhmVg8x3UwDKO/uDnPaWW9OCVwoG9VuhvL3GRIGhqz7a/K8sydmvb7CRuZrNCoEWqG/W64bFSZboJ8/LYKYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ja9ntG+tzMYb+Vs+gsr7sUW+0KSJ9yCDv0HIuAXjetM=;
 b=jfObQLU71JQBGpaK/e0bKE6PonycCn7Z8wtopyBhmQ+E2tUaS3bgQp0RNiluwkDMQLEuCFB4EZQF7/nhSR+NqN1bIziuSy5wYBMVQgt9xCPqIJjzrw8U2gMtH9PRn1f8NNulfGpDlKuTmtZWzC5KU1Fzy2NDq6OJtwqDA8RI6TyxMZVnJPDARV27DMmZfxuKg/6U6+ZSq0kFmQfDo7YZKtMlIzcy/3H+hkwUey/4/L2N9jCh3ux0yNye1Ax0qQ1p1FtJOm9dzRR1S9whgpxxPeRcvPv3lSa7bmfxO74QvLy5Aetz4474WEWXUAmIAph63zN8PQWqEbJGema62HvlWg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB7090.namprd12.prod.outlook.com (2603:10b6:806:2d5::16)
 by CH0PR12MB8463.namprd12.prod.outlook.com (2603:10b6:610:187::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Mon, 12 Oct
 2026 21:12:29 +0000
Received: from SA0PR12MB7090.namprd12.prod.outlook.com
 ([fe80::de78:df30:c2e6:7adc]) by SA0PR12MB7090.namprd12.prod.outlook.com
 ([fe80::de78:df30:c2e6:7adc%3]) with mapi id 15.21.0472.015; Mon, 12 Oct 2026
 21:12:29 +0000
Message-ID: <d2d64d12-24a9-4bf1-b505-3008e0e25c40@nvidia.com>
Date: Tue, 13 Oct 2026 00:12:11 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/9] net/mlx5e: check for failure when pulling
 the Ethernet header after XDP
To: Josef Bacik <josef@toxicpanda.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Manish Chopra <manishc@marvell.com>, Rahul Verma <rahulv@marvell.com>,
 GR-Linux-NIC-Dev@marvell.com, Shahed Shaikh <shshaikh@marvell.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 xen-devel@lists.xenproject.org, intel-wired-lan@lists.osuosl.org
References: <20261007-b4-pskb-pull-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com>
 <20261007-b4-pskb-pull-tail-drivers-v1-2-9512b0fb977b@toxicpanda.com>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20261007-b4-pskb-pull-tail-drivers-v1-2-9512b0fb977b@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0016.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23d::20) To SA0PR12MB7090.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7090:EE_|CH0PR12MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: bec223dc-9360-4aac-46eb-08df28a5858b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|23010399003|1800799024|11063799006|56012099006|10067099003|18002099003|4143699003|22082099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: cjliPQprRqxIENv5FwbXIRVzl9VsWNT+uOZVP68pJbUlmNjEs8XNv86krvj+1mzxvfO1vPyXrmwvmYjiZNerEB6IyQFRCsW6T82SuZodIzP8tUqUFgbZFpWoYk+YosIeNXLlfw8g21opXHYCfv2GIU3HCItU5Fog8usPevR3tiCckg7JwO8K4DPBCSs9qOpeiq9Bav6aQ/3DdFqncYXpTvzZLdTw+SGeQb/jJzGwsJCrRATzcW6V4Ir5MhpdoOjC89cGY0C0yTWD8LBSNwHRQ7PAC+g6pL9hkEDFgFD60faDrXg8yhXni9XawEz0xlWIUX5eqATqyrQ6nUymVI/upbAxLmo4xpVAFOT1wbFqlcvZyK/YzXAkEsrrjCrwyDu71L9TXpq4isez2JxCLSaiHa7V23Skpqp46hJiFdE5b7OFyNAgcNxifof1nlIkvTQIwTCyVTMFfAj5zZWhdWwoGAiz6EGmIsB8VOsfA1siVINeq8mLAj1+vfQNHIL7I1a2L+rJNRWFM3GAMawEMdLfhr4Eg40C9UvKr7dKTS+vTzcqMux3HZ9ajColbWxWoo/ly52khzpNibL/g7eJOIQueU6iKeiV8JTxUCb/SoZ24GC88C54lWAyj3gAjhgo3erFori9SKaLMj4Z3a5cEikZM3kEpLvMQwi9RZNZ/jp6ZO8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7090.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003)(4143699003)(22082099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tm1NOEZLUUpyd250ay94d1EvblZUUnovZUtDS1BJNTF1UW1CK0xUMjFDam9I?=
 =?utf-8?B?dFAvQ1RqSGh6amlyYm05SUUxSFBrNk81eGd4bEcyVHZZWDNaS3ZxMU5sdWJD?=
 =?utf-8?B?TlU5YndmNk1OZ0g1SndYNXNhTm1lV1l4dGtxalc2YzV3VVh3c2RWdVo1N084?=
 =?utf-8?B?d0R0amZxV1EybTh6OUhSMm8zWTNaQlNTODlmaEsrNWhqNVFla1o3MElySUxZ?=
 =?utf-8?B?SHQ2NTVQVTlUTWgzUmRWL0JQUTh5WVVhWXpkUWV4cGtKTWFrSXRrZ3JIakEw?=
 =?utf-8?B?ZEcrV0xFeEREZ0NlUXdpbENLbzNBMk9JR295KzM4ZTAzbHRlbFl3Y0F5T3Ar?=
 =?utf-8?B?TXIzUVJrRTNJZTlweUNKYnJ0cHZmMUFNRzM0RC9ObkJGMzRXbTZ3L2lSb1RF?=
 =?utf-8?B?SGNtVlRmZUY2VkwrRlE3d3Z5aUM1bzVuNmVqWWhyTVk2RU54cmJObnFBM2Zs?=
 =?utf-8?B?TVk3L2N4Sk9kN28ybXpYRnlxQ3E1M2hQMUJyb1JJZHREV0FrQWxOM2RqOXps?=
 =?utf-8?B?aGY5RkVYeWFieU1LN2ZkWWhXK3RjS3AzQXZsSGp4SEFUdlRZWEs5UE1DRTNJ?=
 =?utf-8?B?NGkwU04xRnNKeGJmMkREaStIcXk0REI5bmVLMkF0dW1ZMmFEUkp5dnBRaUZm?=
 =?utf-8?B?OU51clA1VGRzQ0d4a2Z4WUFvSGRFT0hiUjV3alk0ZFU1QnVtRGY4NHl4MG80?=
 =?utf-8?B?dFR0Wk8xY3l5NTVCdnlMcDJZYTZZc2VabCtwU29RUHdkaFlLSUZhWjkrOFBM?=
 =?utf-8?B?QmZrUXkyRDVNRXBFUXAzU2ZlSWlPTnFRTDlVNXR1YnAvUC9nNFFKMU1FUzli?=
 =?utf-8?B?LzV3NmxsdS83bnN5eXFacSt6T2l2YlJ4eWVCR28zWWkzOE9SQTR2MFNXT3dT?=
 =?utf-8?B?MmdxMWhiTEozQWhCQWh4T1pVVVhsQU0zZWR3blNrSGMrc0RKOWhjZU5jSWZM?=
 =?utf-8?B?Yk5GMG5qU2l3S3dWV3NWbm1mbVNqVHF0ek1lMVdNUFEvSVJISnora3IvbHhE?=
 =?utf-8?B?ckNLOGpaMm8yZS85emRRV05TRkdjZHFaOThqZFJTVzZDREVsWEhHUlVrU2hn?=
 =?utf-8?B?NVc4WlhDM29BWThmTUZzR01pbTNvTEdkRm9xeVRJQnlFRFF4L0hxa255eGRH?=
 =?utf-8?B?OStxWUw2dTVSekNVbFI0c2tBY0dUeWd1WXpvSHR0bjZXTjlXaGdCNXFjemhu?=
 =?utf-8?B?b3dOS0tTK3I4dnhHKzB4ZVdYQUFOaC9lTkdrZmVNK3JwT0NTSjhWNExYT002?=
 =?utf-8?B?TU9DYlBtQkNpVDJpM1VBUXd0a3l0T013Z0U2MlZlQTNPbEcxVDZRM0IxdDhV?=
 =?utf-8?B?dmxKdDdhejVlU1o4ZURCTTdrdTNQaVgyUFZLNVpDWC9yWFB3MG9SWTFDYnNw?=
 =?utf-8?B?TnFjbW41SHpWaTNXc05HbEdHb2ExOWFxK1diZ2M5TjFtbm5oY0wwaXpSWGZB?=
 =?utf-8?B?R1pNZW9pTVRWNWxlQ1JnNUZBdnVrTElBQW9YM2hJWFNQMHVxSjNidy9hY1cr?=
 =?utf-8?B?OTlGV2svQzRoQS9QcUt1ZzJGSWx3cmUvY05BQTFCaEJ3bjg5U1AySFg5S3JV?=
 =?utf-8?B?VTl0akZWZmlwVmlhekt2VjVmWVNhRnJXVWJqcXZLNEZDcEVwSExTSTM0N3Az?=
 =?utf-8?B?OExCVEFvT01hWERyekltMkNxUXRnTEsrRyt3b0QzaWlvUHByalh2cDAzdGQy?=
 =?utf-8?B?VG8wd0dnVUxCWDhmbjgwQUtpRWtqdWJHd2c2eDdDTVFaU0NIVEl0ZTgzVEpa?=
 =?utf-8?B?R0hsSFVydWVyb212K0JzcUVHSThsbmFXZTZmZXFuSFRmYVRHV2NHbllER1Ju?=
 =?utf-8?B?SGtJRk42c2NlWFVaVVl1MHIyVkVHOS9xbDNBck5jTmNkWDN0c3VSWDl3T3Yy?=
 =?utf-8?B?V3A2NFN5SGg2YVRsaTVYbW1qelUzVlFsWUNnVHB1Y04xNk5BRmdGTWFsYURk?=
 =?utf-8?B?ZVZWVEV6UDNqVUxBaGRIdmRTbjE1cndLMVpXTjFZN0pJTE52T09zRWdVRUVD?=
 =?utf-8?B?a0M4R2U0VGI2ZXFBK2JvVDJ5THFmVWZ2ZUtFL2JOcmpUOVl5UzdmMlUyZFdN?=
 =?utf-8?B?TnlqaVdHRnAvcnpxaitia0p0Ti85VHVtWjM4V3NvbTI3Y3l1cW9rbk5rZVZl?=
 =?utf-8?B?RGJ0eEdVd0Zqc0VXNllHMENZZTV2T250NEluamxRNEJIdmYrYlZqZFVZM2xC?=
 =?utf-8?B?ODRocUl3bEEvRmFxRE1EN3lQeTdzZDMzQW5BSGNnOGt0NmN2azFMVDVBRlNR?=
 =?utf-8?B?Q0hiWSsveUFOSlhJeTc4T25pVmRQek9NbWF1dS90ZThVdE51dVppMlBhZmRo?=
 =?utf-8?B?bUVxTkwzTS91Uy95amV1TDRaY1VVT2lYV20rMUI4Z00xSUlER3ZoUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bec223dc-9360-4aac-46eb-08df28a5858b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7090.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 21:12:28.9246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8wjkk7or7Pizk+UU9bvqv+O3BPx30Uxcw/S0X7L1JWWg9KVag9NxRDIkLF92eCMv/Z1FLOVpSnEpU6wsBBWGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8463
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



On 07/10/2026 21:16, Josef Bacik wrote:
> When an XDP program leaves less than ETH_HLEN in the linear part of a
> multi-buffer packet, mlx5e_skb_from_cqe_mpwrq_nonlinear() pulls the rest
> of the Ethernet header in from the frags with __pskb_pull_tail() and
> ignores the return value.  If that pull fails, eth_type_trans() later
> finds less than ETH_HLEN in the head and BUG()s in __skb_pull().
> 
> Use pskb_may_pull() instead and drop the packet if it fails.  Pulling
> min(ETH_HLEN, skb->len) keeps today's behaviour for a frame shorter
> than an Ethernet header.
> 
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> index e3f915beebe1..b1e1e30a77e2 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -2060,9 +2060,12 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
>   				pagep->frags++;
>   			while (++pagep < frag_page);
>   
> -			if (len < ETH_HLEN)
> -				__pskb_pull_tail(skb, min(ETH_HLEN - len,
> -							  skb->data_len));
> +			if (len < ETH_HLEN &&
> +			    !pskb_may_pull(skb, min(ETH_HLEN, skb->len))) {
> +				rq->stats->buff_alloc_err++;
> +				dev_kfree_skb_any(skb);
> +				return NULL;

I understand that the real goal is the API change, not this branch.

As of today, this is dead code.
I'd at least mention this in the commit message. You already do so in 
the cover letter, but it vanishes...

Something like:
   This can't fail today, since the head always has at least
   MLX5E_RX_MAX_HEAD bytes of tailroom and the skb is not cloned.

> +			}
>   		}
>   	} else {
>   		if (xdp_buff_has_frags(&mxbuf->xdp)) {
> 


