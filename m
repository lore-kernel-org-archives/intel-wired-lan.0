Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F97C624A4
	for <intel-wired-lan@archiver.kernel.org>; Thu,  3 Sep 2026 13:20:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1363A40AEF;
	Thu,  3 Sep 2026 13:20:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oeG6fkJSG7pM; Thu,  3 Sep 2026 13:20:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 309A940AED
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788441652;
	b=B/FmX/ORXcN74JK7slQc3XpWyxmzPQQDwpMrtDNB8/s1x/7idY+RGnejL/R07iMn/wUa
	 9jGrdQbiMmQmaMg917j9uOYqAwCUGKX+wtyakbAE2x+YxJctxZr5/ctzJNi+K7kXRdPOO
	 3XQMeOkS1uj9T2/QpHW8wivNqit0RTmXHcz+CTogYLJL5mSLM61qBh75++m7C8Ph1eltW
	 ZQ9k1/cYPokv6SsQA/gIHrzTpLvSgRYrfursbFpLWFSf1tlYGKW7AV2weDRixbth03ORR
	 PUMy/l+DaDgPKs28yil5la43FLne7RdZ/Vh98grxYI8OC/YIdDeoqsvG3Za8c5sOafg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788441652;
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
	bh=tvW4+atUwYgeYRBN4Gre8fX75/VpsZqk4hMyBrg7Igk=;
	b=YM7fjgAsT/D3rfW6vU4nLzPnd4L8NgDeAvYoL3IJGcQ8ISBGxUX0/xNAZ0KwkmE9R+lF
	 IDDWM6f2URMDy9Mh/BJk+/8Y+3Ts9TFlIQDLpgKIz37UmZOjYHliPbeYcnk2nmw/Bqur5
	 qPN3ZhinM2uJVZFetVwSNT/eB6YiHdmn5TP0W4TaPhBxeVi51brXj+NhaUn2RKdEih1Gk
	 O+/8RR0UJud5KoYu1CIbUEomZtrxjUvsGA3Br8oCtVWYCqfWG0pozMCHHlPGoDHM4I4WW
	 TSCBLvHngQRmn5unzhHMkSx0pMFlFsErq2S0kDO3JMSQnzWOM5vuo56ojW0lse52hXQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788441652;
	bh=tvW4+atUwYgeYRBN4Gre8fX75/VpsZqk4hMyBrg7Igk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E5ph6U3n1NN6cFT8DLEBmUHuzw0KRV1ji0pdyPV6pTGK1WfB+0OouIm8JdBE8BdSa
	 R8rlIAYAKPd30ZPqBmJw+12947OXn45HqYyhcepb/6+XAOZsHWhW7A9RFj7devrxBk
	 HrXJdI07vFtXLgFL6S7rLNR3pWF30t0mhr/5yeC5t0rXeeVWj0kaWSmhx4+KwdBwPV
	 HdC3LONAYdYZR/VkHJ4h3DZDsgliD+nWBoLZwUzB1UepeSd9nDR9UHCWycSR8IWgkD
	 FnUCU/ZpGfXiFRH8gZvueIvHdxSqR0/NJUu5ABEOQFoK5V5bnGDaewHNsdPpwN7UXt
	 KhCHLUWBdsviw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 309A940AED;
	Thu,  3 Sep 2026 13:20:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4ED4C2FD
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 13:20:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4080D60B4B
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 13:20:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N9HzWEKjq4nb for <intel-wired-lan@lists.osuosl.org>;
 Thu,  3 Sep 2026 13:20:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6BA0660B66
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=52.101.193.9
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788441650;
 b=AXcMiIZWfuqunT8h0vaJ+rXeCaG2vdOMiR5p9IeiufZZot2tRxcHDyPVFVSrni457lzd
 c0tYwvRFocbxZKPd/vyoMPaZlgy4rLr8zr2T0LaKDStMToKwCGTf3lA8IADkduWmIG330
 q+ZIar3V/QtdssTGRMn9nKQUVN7ljMKiBgwdBf8NTO+BcQTGPLNW/MYeT03HVZRBSdfDS
 oHJPg8Ky96FaQln0Y3ZQ5Zj8gJLGTbN9p7rkqfdmQFIVhTa+6eAiE7oJgiY1cITN9rvLT
 wEcD8WZpVIb6ssXTgSCfspxc9GlceykmP6hTfLFOhnNRxL0D8rXI4zXOsOHgJPI9tVw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788441650;
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
 bh=tvW4+atUwYgeYRBN4Gre8fX75/VpsZqk4hMyBrg7Igk=;
 b=hw3GTCWP4OWidm6nPmXqqs9k4vxHMrjjyQ7lg4T2coD7uJNwnrZItz07LjsxrFX04Skw
 SaSWtIBRcKML6tto1/N7/z4Mk0IxGZNMz8UONfLf6ewipbbh8misZrbQB6mmJJOWn4GSe
 GLAMdmTNZu/YkuhAGJXK2LDlcoVMndRpBaG8jajrRk8o2yZxiOKxV3l399v20ZopYE6QJ
 WZNmpZTk0oY9Pl5yUapGn4jp9wQa/fNV7TPgRYo7tF7bctl/L5QTGNSxOr2sKvoAg26BV
 /l6KAAYQ4VXLqigka/vSsOYmVyGF4ALbTmHi4oJM0WfyCjXGTjVSD4Qct3mECrarykw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=nvidia.com; 
 dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=oQj5IbeL; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.9
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=52.101.193.9;
 helo=ch1pr05cu001.outbound.protection.outlook.com;
 envelope-from=ynorov@nvidia.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=oQj5IbeL
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010009.outbound.protection.outlook.com
 [52.101.193.9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6BA0660B66
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 13:20:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYCggVYzNMG48sAnQ+/CygEdBU3uLSUEEJqzouOAFKpWPR73yH77BY/qcVMDGJ9xli11zkcfSVsyJFKFJ7hxR2oImLJSQF+aMxnFL8IB7rkKJocuOFlZpDCxH61r4P2tDiagfEEsnQus9/UUNM7/Fx/kkIIhvitMd067QPMtR1FEKjq1m2/NUVRgsyVj2lk4GUbV9wFBeHNmSX0cqWgALNZhv+7il4jfVr+O+Sbc731QASnGvqHlhMJBi1SwM2Qp8cv8sm/5KkhWVFPIGpAku7C2ocb/4WvL57mMf4/z/NBsz4fssuEX6SGefKDc8DJZUd+L8jErV8EHH+yeO83TSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvW4+atUwYgeYRBN4Gre8fX75/VpsZqk4hMyBrg7Igk=;
 b=ELUEVf95H+I9vXsP9wihmVy7BRB/gVzjL2yuKtLEbgRw1Tzqfr5R+vT35oTHJg3CF2SbKTvpZ/iIGNMPoeXmIslgGqB2Ds7++4Mzu8i9jItbF/KEjFFk+OZiOsH7V5sbgjWQ4fHreVEceDUsLBM32jn2qZbqSe/AkbaizwCQ3zkdAZNz5bDW6D7rRegtfiNtaRNLjhlC/7bZ2Fb8H6ee7q0g6TWphEF5mw1O8BAyb8a9b5aQbrJF0qSyXIQdXwD9rgPycxy6wPB7P7ypu04wfNfPPXdJR80J9hS1k9ve1ELAeHwdStgyFaXB2nj9sHQzm2szR4QxA2Ua8QNCiq8qyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvW4+atUwYgeYRBN4Gre8fX75/VpsZqk4hMyBrg7Igk=;
 b=oQj5IbeL7D06u3lWpxkIATxNUP1QZbS7lxtxWa/xmE8MirdbguZNP2PKnelEoZeyZk+OWoRTk5PLMTV/zHZscJkkwUVCki2KcnNVcwvaQKoQ7ZAHyctWty/CcFFgp5OrMCywNpW/zeFVIMqVE/Wusmj0IOnjhQb51ocf78G7q5s0i2H8Qt1bJlh8BcSBajenjreT29LcDRkMRUCkjpkmmvqlu425pf+GdFgkhoKxdMQ7hXKk3O24UbIGPesn+dgnc5TXt7Zw1qA7c2YaBe4ZwtwS41eyaKsj/OAGhmcf8kH2JKwUDho8lJq9fxzGlmVZnM+ecVSDomI6TB6SvZZeIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by MN0PR12MB5811.namprd12.prod.outlook.com (2603:10b6:208:377::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 13:20:41 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 13:20:41 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org (open list)
Cc: Yury Norov <ynorov@nvidia.com>
Subject: [PATCH 1/2] ice: simplify ice_pf_state_is_nominal()
Date: Thu,  3 Sep 2026 09:20:35 -0400
Message-ID: <20260903132037.81346-2-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903132037.81346-1-ynorov@nvidia.com>
References: <20260903132037.81346-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0064.namprd16.prod.outlook.com
 (2603:10b6:208:234::33) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|MN0PR12MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 8967014d-dbc7-4bb7-df36-08df09be26ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|10067099003|11063799006|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: TS300r5OreCTCWrjHMxP12EgoNagGKs6Ox1u1gla8rvdnHkcMpWO3fJS1sUPdbGnaGaQPSvZohL2m2oiSw66wamHFHl+nU+v0wa6f+24ewY5W37/pkiF5ZqIEDHZfGRSK8o0rMUSV7s3cRooU9CKG9Wcde23bJ9o8jlrgpCFWNUjRRGcS1A8RLDeMFr4JLjEZ/6oFvvr9q948WhYYNAXkacPZk8uwt2W3vOrSZenpGpsdW0BWJaKuAXRmWw89ROOxH6zV+mhWJXAHT3VRVnpoOcRr6hP+CpbmdIbB5yaNoBXoN0JKVeBGc39grYNpmEYmsBH1WZn1YsO5z4SEoBYeIm/vwAwZ77AcIF/8UvhybWYg5Kje8LnDI4R5AyKkpU7fnBMC1ITfg3ilYLxx2oU1S6E9ypaIVpZVA2Dex1CXfZxIR6ItpZPSzfMQLar+530fUFNnHIbnCyVYPjeVctHE0j29QemFBORSIPcojEXm3UfpIdHJk07tOtTBu0wAUae8QE/pM2ZEKcxT7nMpFHYLuizjtOXYEuVePHlopwWKUHRef+tN1+C3CjcHTAFW53KyvPKNWFQA2q033x2wcv+76On9wQpWlspDOy1EIxH9L937WRKzQ2BrFvf4GUlLIwmLcu2HUuJeqzzP6GOl412MG2cIAKRJk75OuJ8TXHSyKfzsL7DX+GKN0CTepMopV4lLRahhWSPKrQr9KElXg/LUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JFkmdn/vEm50+idjt1QAPmpjnrJ3W7/KcRrr44+qFr65/ljPav19cU/38ds2?=
 =?us-ascii?Q?xbMIgQauBmI8p7M80a8TnNMYuF1Z/g4D9WokhcBh1ZE8v34VuikFMvsJbYeM?=
 =?us-ascii?Q?9aaTZQPGs6l3Vt6XhN9GsqkIEMHSNUcluI3bKB2YmjqoVv/YokULmWK/d2KR?=
 =?us-ascii?Q?M40JgQhIsrl+pe+aGDXuCP6lbFUC6I9s+PbkaTHRWJ4c25KiPYOOhpB8EjXt?=
 =?us-ascii?Q?U3678q8YPJWKT8RTR6FxhyfTGJbm/0OZe7OcFpaZUC1P2fQqEG0JXCYO92JL?=
 =?us-ascii?Q?2apklg7Z4p0Bhjl/azXEIy5tUK6GiDdgRH/SGy7SS3HyRkcX1x5dKMUPDYmF?=
 =?us-ascii?Q?y6YrP3ewW9e2fy961P5xRabxq/0Dr7iCpsFYP1oxIIF7c7A1dLOY5x/FYiE1?=
 =?us-ascii?Q?LWt6FgNBk/QmayshynS7NM/zICyDqVZSgYrpT0vOq0WTfQKcHwvXFO+J9e6/?=
 =?us-ascii?Q?WZkubabHjx1Veu45pQHLAQG7xgav3nIP/mf+KSvN95+jHvXmAnxUhF7pYnto?=
 =?us-ascii?Q?/5Xkm19C/5yl/XuY8Vuul3quDLK7hMcS2x1c3zULSCxfuewVPY+YG3oJv5d4?=
 =?us-ascii?Q?ZItHv/NcjcdnHcbxCiHf+PRD8msFA6KNIwyyNWqkyZrk874pqDcKqOc1R9P7?=
 =?us-ascii?Q?SNGXt0Csloq4Bbt7IM+Q7IfDPe0lLDyL9QF4GfOAb+lN9n54gLY3Iom9FIGw?=
 =?us-ascii?Q?EavQrmJ18LJjtL8bArW7VJ0WXXe+JSERpNNmgfrW6UebsnVJjjJBb1gCpdAR?=
 =?us-ascii?Q?LV4YdJzpQcUySGy+paCIsGLShu58HGb/wZJEXD1KE/UZEydFsuPNfKAAGE0u?=
 =?us-ascii?Q?zwSvsCI5AWAd6r6GFQWFYU4lmRJKai0MEvSQ0qrdcNkMTWgFDEHJcIka86p1?=
 =?us-ascii?Q?h4X4XWZ8JiFnogIxUai3zWI7OaVIhXKt7hZnT8L11SkW9+MiBTmqF//d7mIV?=
 =?us-ascii?Q?eHSxHsqXF6Pvlt0rZaUcaLXOTvAfE1wLaQlXPP1lIQ6WY5DNsI42LsvOiCAe?=
 =?us-ascii?Q?GApBXTSfVFHvMX3nBOgKW4AHsVkiskR0WK7A4+zb6VhXx1ICaXKBKvb3OUtH?=
 =?us-ascii?Q?Qpt7Y4xgoMXvLFZCozTH7VFQqk2J/qOA13e7YXLCgOxTU7KZnZPJsEOdlxEF?=
 =?us-ascii?Q?YfB71c64O0+xTik+sAtz637ZCakzMdCSN5NDP4rFYex57kI5tFMOAsN5PYPY?=
 =?us-ascii?Q?7ZkHQ26ko4QnCvXCiz0qIVl/zqMWJ9qBvj6WUQ8bkH/AGBNc+syoa8mLap5i?=
 =?us-ascii?Q?fsYKD2kudZQSCirsw1jAvt12GlBdh0rwdLiYzfKXmPjQhDZiu4NKDXm/B3Zl?=
 =?us-ascii?Q?It4xmigD3536d3xVgGbM5PlpuOvgNQaAq82i/oyGEilkwQUH3YawWGPvCTcy?=
 =?us-ascii?Q?skPZSDfzFyrYezS6QQlqj6RYx98+zbRSZvXdcvB1pFqrzExDMG3jkYGczRjJ?=
 =?us-ascii?Q?3m1v9pviMoSuKngg2hg7jWw/sIKE0FeN3LNtSwBNQwG7WIodKm+2NOVPHUh7?=
 =?us-ascii?Q?bhdPmhWy+cUAA9joNTRCwiTVI3+9ErfHjxz96qnHTnYv9G+r63TjWVeeZXGs?=
 =?us-ascii?Q?qet/lVCtFO7WXmAEvcxiPiI1JE2Zcv/k3Fb/kjIrgxcRbASwEx1I/Ije5jjO?=
 =?us-ascii?Q?Inmvi1cqDHllUmuPUp2CkMyaViXshIhMz/eyXM7CjRFGU0YHpb9ec1AsA/4o?=
 =?us-ascii?Q?pgJvL6gqqUaO/phoTxIq3WXXgAXbIvw3OUmMqUA+mTyc7bt1mfx0OXBt9Ace?=
 =?us-ascii?Q?38uAbMemtA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8967014d-dbc7-4bb7-df36-08df09be26ec
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 13:20:41.3374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hiRXgMvzRgh0IGmWRn2hhDd0etgBlIKG2cOlOph11iICSTxQvroFu/t7Qe3kqbTdA0kPM1F1hmkU6PIXNI8mZg==
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

The function creates a temporary mask on stack just to check that
first ICE_STATE_NOMINAL_CHECK_BITS is empty. Simplify it by using
the ice_pf_state_is_nominal().

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 9e08db376d3d..73996e3022ef 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1705,16 +1705,10 @@ static void ice_vsi_set_rss_flow_fld(struct ice_vsi *vsi)
  */
 bool ice_pf_state_is_nominal(struct ice_pf *pf)
 {
-	DECLARE_BITMAP(check_bits, ICE_STATE_NBITS) = { 0 };
-
 	if (!pf)
 		return false;
 
-	bitmap_set(check_bits, 0, ICE_STATE_NOMINAL_CHECK_BITS);
-	if (bitmap_intersects(pf->state, check_bits, ICE_STATE_NBITS))
-		return false;
-
-	return true;
+	return bitmap_empty(pf->state, ICE_STATE_NOMINAL_CHECK_BITS);
 }
 
 #define ICE_FW_MODE_REC_M BIT(1)
-- 
2.53.0

