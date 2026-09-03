Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EF9C624A4
	for <intel-wired-lan@archiver.kernel.org>; Thu,  3 Sep 2026 13:20:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3EA5B40AF3;
	Thu,  3 Sep 2026 13:20:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hxjhM8b5SZKw; Thu,  3 Sep 2026 13:20:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 04F1140AEE
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788441657;
	b=DUilER9Y5IJPYhjYTbDIx80PfLAaOjEZStZNwRSsF5xCYpygd523rB8PwrWjNtRuYVi2
	 ynKd74z/FbwVzLQHfvUXx250X6+ek1P4lKEI86rcwR3Rruzu8iDk13wUZPDi+UXfetneY
	 jD1cOBNqXtDIN81y9MvRn2H/PFpCuDl+J+kARi83ie/Khycn3pYE6Bhok7qu8Axv2xi7w
	 WSeblmDqvMmbwsD3GXE6KUPIwBoMZN9kX0R+dZW08SoAN9XKjUH4MJXo4/LpJuTXvmi5E
	 emeURg6JXQTBHXbieCisbVoXJFKdBdgAI4EHTWWJN3mjrRFoC6QATLUMoYLzBDRnuhg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788441657;
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
	bh=HVbe5F4syy5ngPx7J3lvj9aGQ3dI5i5GGc9ewu3Im/A=;
	b=eaXl/B/SbzrepA1lTU0Mu3H7CQuMxqymyuzCj0NE+asiyvuHMD/yAjED9dnH6609lVcK
	 PLHXTBMPoivb++++2XA7YuXiR3KXfl2f3xUBbf42FxEtN6t1ESms6R9+HBWEcGMnTIXRg
	 H0egCsFgUuW7IQd4fCeE9nTUmXY9zd9TlPM8XrvR+OauDSZT1wsIvwFcqWuUOBUWOqR3/
	 nk/Fzb0mmx5eFgAsn8+x9X2H1itZfRDbyewx1I+qjxbscMctUGWBjpb3A8lbuf3QCZwxT
	 Q9avA+ITUjnGhEmMCpoLLMl9q3AKDulpwwyuQs2UgxetHdY0j03N1pzE+WdNXNvk6qQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788441657;
	bh=HVbe5F4syy5ngPx7J3lvj9aGQ3dI5i5GGc9ewu3Im/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nGpeizzQrJx0X7i2CXfUEHwswxZ8eSr3sjVITdhz0XaXxx+zNuaE2RUgjaRjeeT8A
	 qzTLEY/zh0jTOsIolosHj2wDm+WUm8qIBG/K2PTHUPBPSKsdpJAQyUEgKDLsiJuGmC
	 howNSyiD8seFE2BdjxtU2pFQPK+vmk+oKyWeGfoTLKX0Btsxnfi/A176qUyBS1Py3/
	 LaMAgwCe69ETHFEuvmQQ3/U04ARWABq5cKsOqZcMa03AEqW4SYt7sMK52pI0MLpWzU
	 enZJf4/gy0q8+xh5aDTZ2wqV4pmzvYlYhbnQBu+LT9A7WeBgKl3P4rtwWC4GXmSFeC
	 oE2rxt6ADgYZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 04F1140AEE;
	Thu,  3 Sep 2026 13:20:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 807692FD
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 13:20:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6685660B66
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 13:20:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l5oRDYr0gzVY for <intel-wired-lan@lists.osuosl.org>;
 Thu,  3 Sep 2026 13:20:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AD5F660B4B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=52.101.193.9
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788441654;
 b=ibzEcNvD84qmNP25FDTfT+vhgNyIuBRIJ181zb8js68emGwvPCwsxQT5o+DP5yZDBdUb
 y9MhDJPbuUVLuLbLpFvXAJ+5kNWUMMbqJPyHNK9xcRmsDLBpl9bHSAPlt3UA50PG2AJY1
 DxOmLymjBWJnVdqaQMURsd2QAGxa2LiJOBD1IG93kFeZgjwkBS5yWFxSNjClpKxhm/E5Q
 6WMAWa68z8UwC4jzCJFQjrJPgVitnLfSqh06GCdEva/G1w+lOlVarKGMYfuzx+zmYaape
 Dl3uoUddBKDuqWkafS8RzXxAdp31OlHo9DIRtg7Jp053Esn6Bh8cc2iqd6Z2+Fbjlsw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788441654;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
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
 bh=HVbe5F4syy5ngPx7J3lvj9aGQ3dI5i5GGc9ewu3Im/A=;
 b=ZcXrBzUoAuCX0ytZmEyGpLCwVGrBtTYB9R6akq2oX/wNHLXaKu03tCOnPi4Vr+ni82mI
 WNBnwSrChpzUJr02QfmFAGiwVq7kY0z8WqTVsMri/03ewlk2DSRVY7g+sJ0jvE+0MyLVf
 SBqbkWC14nYlCpNZGIKr2/kT0JqYtntV1ohIFOrj9uNO2CVsMBcICv/jTxFHL3m2UOIS2
 6SuiQ9MoEqCXyiEkrwvrCBx+Ym5ZE83qsJfy5jnu/fWxW2Ev/l/VUaCnUQz9sbiIHMypW
 ciGGKwsdF6PbhOAc/nUwp+9R6pdoYVhF/IapE7d+nuUFAtSyGrbUJ7KqjDfIRZYVKMg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=nvidia.com; 
 dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=fAr0jYXk; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.9
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=52.101.193.9;
 helo=ch1pr05cu001.outbound.protection.outlook.com;
 envelope-from=ynorov@nvidia.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=fAr0jYXk
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010009.outbound.protection.outlook.com
 [52.101.193.9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AD5F660B4B
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 13:20:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abZqbHD6iQzEKD7OqlQpUv+pvOo2zXUk+p9+tMtMSddv8GPgG/YUSDreAQAvPpD8zs95gNFLCbVeMbB6PC+ccj+9S1zNC8oIDwnIno7cy1la04aoBtFKeymekVgyZtqsFna+Ce+RipGfRx1WmaQUlRZ2gNYSuJ7Cw5TL+ON58zBQvtpTgoxApTOjaJrVkjGmIKgBd2JqRlaz+CbNr27JVO4NMNXwwNhZ5UwR5y9s4Fw+cG2o8oRpghmVD4OuoHkYRbjJLOJD6aVHnYLD/sd2T6H8Xv7dtpdxJsKop9h1WSQuBqRNsPL2rkIHGKRCkulLNntwPWqrL9TegstVemmwJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVbe5F4syy5ngPx7J3lvj9aGQ3dI5i5GGc9ewu3Im/A=;
 b=uL7O0QpxS2c33uUuZ2iKLrwGnG3H2k3GcGiWh33dFItimJxYYm7zQ8AZaZeAoVhFVY3TVNnqkkUH1Ez35BGGIoSosFceN1HeWByjRlCpVjG3P6FM+M2s/3mAvjnHWI5HV2l1wuupu5wWHBCNLbnTWSkhXrutuzAIMTtSSWrS2KtMubS8w2KYZfFtehLAUTf2zPheppjlellfTcgT6asDvhJ9MX+/iZD7GniLgINeTOBTuuB4sgWmwuz7Jh4+P4wVY5QYyUcdmqvUa8ZStb6RxQhzSLo8zMHsi/3LKf+P/suMqMmLv0OpyD4DcDPGeBF/ggvoJzHsk719ZT6V8bEJ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVbe5F4syy5ngPx7J3lvj9aGQ3dI5i5GGc9ewu3Im/A=;
 b=fAr0jYXkDZLBLsE0epvm4dIDAdv3AF16Pu8d5Tt1Og4k5GzzMslV/Id1vXuFBYzgBO0fLvMoQ/1BqtctgMqWJqNcjyb/sWrQg5TEiGfXkX2kY0Ru5bJ0Jb1Ekd3fpohpj2iuasIrLj6tyB4CbNEwoJ7qSLTVIiQDU/wuux2/3JHDihUVkJTt/aNfyTP38VVAgYg8jmlWzUrS9xmhw9f5l9OwfIfZGlABZ94ZprmAevGm4mqwL+ATMvGprjFOTHLJ0JgecJw9TuSxH+whI4dhRb3zKozlTXYnmHyB7CaAS0nzY2UDOby7X9vmwZqSzZ8Xz3mAVYmCYpCgfCSMdjDRWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by MN0PR12MB5811.namprd12.prod.outlook.com (2603:10b6:208:377::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 13:20:43 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 13:20:43 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org (open list)
Cc: Yury Norov <ynorov@nvidia.com>
Subject: [PATCH 2/2] ice: drop pf == NULL check in ice_pf_state_is_nominal()
Date: Thu,  3 Sep 2026 09:20:36 -0400
Message-ID: <20260903132037.81346-3-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903132037.81346-1-ynorov@nvidia.com>
References: <20260903132037.81346-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0097.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::12) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|MN0PR12MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 8330f511-03c9-4bda-3541-08df09be27f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|10067099003|11063799006|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: ieBYIV29m6r2IXgy7PqKLYhg43vj5gWKLl7CH9A14uyo1/bW0LR6gJz1vMKOsGHfwUWijatjf0K1GgkJ7LgpRQX6BZU68X7cli2JOM1kmqKE3ohh9L9MMTaDS3gDDnj+9WjvoU/pjPREema3baW0AATLgITnfZEqwUQb9PXuq0E67IjEp4TTy1J1VO35B61VBYUiCw/VWtigsILP1YnFaL7HjLkd1Xgm/0FkMl3mxfpmAPLKEMMSpRsYcpb+S4hMLOi6oQoEt25Ur2nuZqYgQsHPZrJqJZJZPMkUiB50G9AtYf9kLqZXFKcY0JBQAjFHYPh6lyNGXtBtENbtZVCVXsmlyfnm9NjQFrJUmQosVSwV/Ec5Pg1Iu1qITpfR7c2EjXFWfum2V4j0iJjLbNxmhPscwrnZ1T9rUoIAjT7MyGc6Xdye0zuKQHz0YiUZUwzOxGiqpykV/qXr6xJ0LHytUtxtIwnB3hxck/SXX0FOZ5GZCEgAZx5gJhDbSUkJC7goOPgjasEarYGKMDKjVVf3EbnfrRt/Lyv0GsKSACHFujSZDPDKPRpElhwyO5OHNdi4K4PC+dxOpkMGxBsnxj3zHc1uk8wCjG8bV02oyO/tkLa5Q7XQe3ekRE67k+0Gji5mC2rHdTPqT1PSg9Ts7mXyZ60XLjUUXO93QUynVN02Lv+CqDFvNLKns5MgBrgAlbebLBysRIzOpQ+nT0lJFPIAjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AB+bcWmKwrCKoi/MOKSBZB7xx1jLVlGR9vDeaU0B4LnPkz7IvFDGp+u2+ek8?=
 =?us-ascii?Q?i6IDOxP8T6SYfvWYYzYTBv3QkeR0lbOhV5vsLx7msD1wTnQ8knENGEyk3VKe?=
 =?us-ascii?Q?hSdn5gNV8yDOKH/NAnewQF06RPB+NyCCUclPQlFG5vNn5SA2gxL0pgCvHC8e?=
 =?us-ascii?Q?9HBtQmx2MxKRcwtZXtLMOe2PkRPTF4u0Tc610XIjpBw3tstMU6SSyPer5BFE?=
 =?us-ascii?Q?rpLQhUJQdQRoxoaaw64DNjjorUaSTcAOpu1pIBt5Sytk4eUiIK7X3uRT3U87?=
 =?us-ascii?Q?aJ+dI2Aw1MbxFZ9DFu8ocYTETf5B4sH8WAG9HwMu7rb2uwvbvAXXthqChAHm?=
 =?us-ascii?Q?0Z2oJzwKCND8kmmNGxrZmG9Yw5ZgsmntFtX4NtAGWziMLLn+N165qOpxxH5Z?=
 =?us-ascii?Q?9peKp5SEHTHSQJ2PW0JSdf6iXxw2sjupVT+QNxCgUyvIRuyZ3jEHYE588N4+?=
 =?us-ascii?Q?AnPUgJXiIwrB21Y0oK7T/26hiS8ksOPbO3Vir1Y83YhXvCFrNskVfjsJZKEz?=
 =?us-ascii?Q?dh/1vDPboZqFqNkDysYsoICZ4PtSNcZelJnbm/1NoCMCUmXmh6WNOEOb/RhY?=
 =?us-ascii?Q?GnC5nFf+wWcgBxbKBHz4OU970k85tZJDJZ8GUsr8/LN1DdfInkLq1p1vCcgY?=
 =?us-ascii?Q?6kzrhFp8u3YlBeeXgc5rmUCIyh5G+zRhjSwUvinRRDjxgdyZ9Qe+whkseRhm?=
 =?us-ascii?Q?1YQomlQe75VpAUU1UdUgBo+guIWih79731AZ1EKVPSf3wUqEvuk+9UYvtG0/?=
 =?us-ascii?Q?LxsjEQ1e5+8uoQTcCBb2QbjUBDFV8d+Tkqga1Cq/heYO8jGoyaHQbMtm+NJ5?=
 =?us-ascii?Q?nmkuMmnZNRQcwzoH3k67EeFcZ9vnNHhQ2DqkuI9pbdbiPsZoAHVcBx2nX/Iy?=
 =?us-ascii?Q?fojJ9gNcBwhtAjrgoE6UF8KU8Kpq0KTuzz4uLL2NS86T9Ws3iUlN3u29QfAK?=
 =?us-ascii?Q?bwhT4zA9TdEikUiX9MpOH0OWirjNZxGFmBkHhpXWni7FeIgMmTwaxxsmTPLn?=
 =?us-ascii?Q?Vbv7v+QDQOtqWeBiNv98Mw3UsNaxxcxE/OP2v8RkBPxuHd8q6tppOM+AjLUP?=
 =?us-ascii?Q?gw9xlaChSVW4UCdyhzCBpzELOxrEDhPsd6iwAsdN1vw2R5nevFF4oxjVSSl0?=
 =?us-ascii?Q?1B4+y6+4VFQm3p8B9XQuosLNbjuFRgtOYqqJTGf38w2Pjfz1zIDlxb+9Q/Ry?=
 =?us-ascii?Q?Exf4/NEn0WJ+03EnjNMYRCxXZ3cCyFkXUwCVIkbsTOeooME94k7tmvtErkF1?=
 =?us-ascii?Q?nOMGyypGg9qQhECEOZImZvcMZKgmXnZN2YAVwrng1ky+5KgoAzFqvKUWjS0x?=
 =?us-ascii?Q?buCwU/yNDutu8rZ73BZIYDqMwfphhEXEw+Q65sMV5+zqWvSvAByltwnc9Quk?=
 =?us-ascii?Q?D9OoJq6/gW+YOjymFWyDLsUuUmpwM58OlIiG0rG78Z0Q448nLtW3OXTS4T6v?=
 =?us-ascii?Q?hbj3MlK6ElH2RCgXYhAyTpmx1rTCPt2Jq3UWvaviUjUDp0fDewYzyKBC26LX?=
 =?us-ascii?Q?cGgpkXPzmRnoKJ84Gdzj60AVjRH+kTmUYpOjymajjGzXZ8lDVHJcoeznpGUV?=
 =?us-ascii?Q?YCOGr8lO40taxZ6PfbbUOh7C8MtoaxViNLTSy/JtrOD4HpHdWmjAkQqAGvmH?=
 =?us-ascii?Q?kmo3vNX2enp0y2msf8ofLmy959Be5QrgjXpMndbgiCmJxqD5fRrVAddRMdoU?=
 =?us-ascii?Q?GbbU43PmMpFDYix+XovLlJeEs3V46PBv1e8a4jnDhZIeUtwOTl/Jntz9+KEz?=
 =?us-ascii?Q?P8M+Vmfq7w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8330f511-03c9-4bda-3541-08df09be27f4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 13:20:43.0367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 17QU/OZA40127D90o89LfdjjHd7g6U5YF1dTMTz5JPo5Q8mLM38QgWc12/P9k/4+zqO1RiIkN2cR5k5jH0Oqvw==
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

The function has 3 callers, all except one explicitly require
pf != NULL. Add the corresponding check to the remaining caller,
and remove it from the ice_pf_state_is_nominal(). It makse the
fun function a one-liner.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c  | 3 ---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 73996e3022ef..6d5b8acc4764 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1705,9 +1705,6 @@ static void ice_vsi_set_rss_flow_fld(struct ice_vsi *vsi)
  */
 bool ice_pf_state_is_nominal(struct ice_pf *pf)
 {
-	if (!pf)
-		return false;
-
 	return bitmap_empty(pf->state, ICE_STATE_NOMINAL_CHECK_BITS);
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d88835482d3a..168d85f9477f 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5521,7 +5521,7 @@ static int ice_suspend(struct device *dev)
 
 	pf = pci_get_drvdata(pdev);
 
-	if (!ice_pf_state_is_nominal(pf)) {
+	if (!pf || !ice_pf_state_is_nominal(pf)) {
 		dev_err(dev, "Device is not ready, no need to suspend it\n");
 		return -EBUSY;
 	}
-- 
2.53.0

