Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9C8CC6B08
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Oct 2026 13:40:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C68F460730;
	Tue, 13 Oct 2026 13:40:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4GyFDUKp8Lop; Tue, 13 Oct 2026 13:40:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 19B94606FA
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791898843;
	b=pvPN6PI9HY5KZcW4MrXLBFFHFArqvZWyn8COmN45NNI3p2eD/uF7cQ/IkioZcBPQIEoC
	 ceFR7CXIN1Osy+54+iywmVRFO0p2AQ587yCxFxOB1Ps4YhAvBxQerwhOzeGiS9Bqk/UT3
	 wfFCQImuAlK/g4cRcvJF20XH1WSHtKSc2NN7xRLw7LgjfTnwA41GIMX3du0TIwutwrkIl
	 YNIn/e7VrLbB8fHITEArlioS0UQEZZi10pSJKo9FypYcatb3KZqSHKqjYXk9WwPS8lpPj
	 Ks3UKaKy3q/IoObDW055ojETkd4AzzpNU4Yk/n65RTn5qUdesvpXURijigrp+WFCoXA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791898843;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:CC:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
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
	bh=dbojo2OomNf2sZdzqa/DiKJeX4oprkPITFwbGOMBiSY=;
	b=T00bSpN5KngjmmBWxfZZOcrzrrvL+ILuxPV6k926dIFxDLKO4yrewTeMBH4ARc6RK8ue
	 uwklvdl2EbR4go6q+hF4N1Rl8R//rrDX6shv5l8jNqG+BnI5as972SKlJtfmY3VpE/DsT
	 +dDgZ5+llHDh/rNzERlvz295RX0zoJSe6U6Tq8DQG1oAbCaFIGICbao2RNEY2+h6aVvDM
	 nGvp/qjh8KK7z3h0d/4uCY6Q1deyhJLa0mhQjkFaQe+VyWYA/4IJBI3/B0MC4w3HduQoB
	 hP4SPb9PjA0KvzR5B0NQ1cwlywbfKVnGUkCyUrfAqAqBw23yYfDu1n5TWxmhHc1WM/g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZC4oNIM7;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791898843;
	bh=dbojo2OomNf2sZdzqa/DiKJeX4oprkPITFwbGOMBiSY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=2EmdCvLK2N4Hl1fGtEAnaP+5sw4SnmfQ0X7Kz8r3ujABpc/V7qfVSXujXJK26jLEz
	 5+YNACxb/j881Q4TzXla+cIYsY2rVKp36GWSBWQqUHHUNDH1iCzIkeMRC+qsWCSeGf
	 OKgDI2vZztIyBzMstZ05M5rVmRaeiQZWMwdPGVEE1flZ7Ym9ElNODME6aVds3xVd5j
	 1AawU9fd6MO6zkYUI6CwVsb5fWTtW7GKFQklwnP7KT+L2Win+/YGSFcRz1ei96cLKs
	 MopZVJFVD9Q8RuxjNw2vpZzoRnQCnS37dJvJOZW0XOLJ6K/oeGgFdcszrKVOdJCetL
	 +v3YcVM8txGxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19B94606FA;
	Tue, 13 Oct 2026 13:40:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 61644DE0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 13:40:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 470E06071C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 13:40:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fBFpJrCsQbE7 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Oct 2026 13:40:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7DD09606B6
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=198.175.65.20
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791898840;
 b=S1bA23+aAdQnOeyQHP3A21Y2Mfl4Mlg91AdqeGxWe+N3ahJIlP99RecX6HgB4yD0Za1g
 ff1Ps1gPKP/o+yClnUdoLBwWYXwuloJVYbORGIUsOgFUsQdKuPUi6Lo+rsAr+qlJPFl5Q
 jgdheDVatM89kxQIV4ST1Ywuc8nk2wRq4RZ92VGBJi7xT3f7lI3m/fNKG/bIlcGG3F3b6
 evpdU5IeQAEHiQgfkNvVbtJEmcZ+sbxhugh6HrrMWNdhvCLv/VTQS00VYYycIPyPVbcxF
 DGi6WbdyDjdGXzj3tfJ7W0T8FppAO1CKnNzRs/PtJOtgu2elP7h69Fhu88UGzU7n9GA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791898840;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
 References:From:Content-Language:In-Reply-To:Content-Type:
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
 bh=dbojo2OomNf2sZdzqa/DiKJeX4oprkPITFwbGOMBiSY=;
 b=lrws3hss0jcn7hpTZJfzDSD8sbQ5kqOdLQ6LvhEALcYSAg+17HsFOoI1G7YRoNWaU/aA
 ecZXAu4A7cWRJnw+t0ta5VVWNU/bIXJa+WZyA6NvJ0WgUsrufn4g9c+ceyQa1W5m3vFty
 rAcjDZHTiSyLg2Fo3FhrHX0xl0Dl+bQw13xw+imSAlKaKM4xerIEByzrbtvWByqoRvB4x
 znX9CFHIU5JIhM3dBNBJe8MDXDCf5u7UIKryf4sx2CaXdkKVbYrDe3y0ksAwIGaSN2/Bn
 aDSBfgHqQ7Z7mfYPmB9YOoLIMQp6YWKGDdX82aoxHBP7GqBcviwb48kz1vMhfdkS6vA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ZC4oNIM7; 
 arc=fail smtp.remote-ip=198.175.65.20
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.20;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ZC4oNIM7
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7DD09606B6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 13:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791898841; x=1823434841;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kH5ZjrxlurM25LQRk6vS2GuJjmY0Tu0Y0OaaMMLse/c=;
 b=ZC4oNIM7ncdHRB70yEFC22MNr1HKEGhTWsiy/3FSVNn2s+/9ZDqGe4px
 Gtrk9V3Lgg4Ann7JbOP5yYkoF9eM/iEzu/2pFOYwHdyW8MUMrrcJX9USZ
 qPfkXkXg5qwSu0vq2GllGyJjN1fYqUKwbY+y9Lpjdx3xvVI7KP/9Zsjcr
 ap11r/xcdWYB/zSBcHel9NS0d+0inFgkeQ3k3r5UAax9NhVTofyLJxtl+
 ZMsCPLhd96d3deAsnWKoLTX6KBrNgeazepj9Lh7u24PIhQ5kJBF+HNa2f
 AIrMNWki/+Q5VxEmsSQTnW+QvdoAS/ZjMPd4iOBWnXM2XZ22GDmd1L2qE Q==;
X-CSE-ConnectionGUID: L+f2IcFISdSw16lFkVdfNQ==
X-CSE-MsgGUID: KOSz3JUhQUWbKilq27BtGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="627826"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="627826"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 06:40:40 -0700
X-CSE-ConnectionGUID: STPD+E1GTW64C+UTaQEwhQ==
X-CSE-MsgGUID: XowaGnxtQHq4KWznFpPI3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="2927800"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 06:40:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 06:40:38 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 06:40:38 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.58) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 06:40:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCKtEgXR2LwVXCvGzAAk7dNtW6dTzwyFJ9TXf9ei+pg/7tWnjx9KTMwINA2Gfu07wvawzMP31jNSOyTJQSLtl22d6JDWX6lHmclWBM1gnt0CZN0A7qyRzc53f1vl+8ZblnJ1GedFLFxPbpm+sQgisGfqwbJRXM/7EK4O1o3A4RuRrBZ+QwUARo09pK4Nqyf3V9KlqqDQrnT118fQC9/8V+oVPkSzb736OaU2OOQoZLxPwPn9UPnEk/uOkzOAZl+w9hxUNZQeOVXHuGQh2ppWox9DVTM/NkzehBp/XKeTPWc5IiYQPaA+wy62YOjrmXETo66dFVeNtfH6MAX/oVJxfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbojo2OomNf2sZdzqa/DiKJeX4oprkPITFwbGOMBiSY=;
 b=nZrTjvQ6yKInGgC3YWpTFiw4fvrrdLj+AKI//RJkreLyUcvgICUxRiHvKbtuPzAjgZFskRXhBKaOusuMU8/V5q6RkBlqqfrzGsJEpiFYRgy1AZlL+/M6rNUQaKnAS6ljO0Dm6mXjhAufTQJ6swMbRFj3zNfN6tiOte94A4M9mNZPGJu4UL5vN9n8YxadrWoqbaKOzfyRnxv2XSUH+ZcxVRVjyWxX23UxvV21HdgBYJqZ1ZbOxUFa9kOtHIwnmyCwvv3Y7T8dU1hngzBoYtHpIKTqKoervH4c5BiuZgQYXEtdQear7ByxE15eZxRO4PJoJXHiRbXLKrf2+BsWi/L9eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by CY8PR11MB7395.namprd11.prod.outlook.com (2603:10b6:930:86::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.35; Tue, 13 Oct
 2026 13:40:34 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 13:40:34 +0000
Message-ID: <1db07de7-5d4e-43bc-af9d-65ff2e5c52f7@intel.com>
Date: Tue, 13 Oct 2026 15:46:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 06/14] ice: bump to 256qs for VF
To: <sashiko-reviews@lists.linux.dev>
CC: <intel-wired-lan@lists.osuosl.org>
References: <20261009121433.30347-1-przemyslaw.kitszel@intel.com>
 <20261009121433.30347-7-przemyslaw.kitszel@intel.com>
 <sashiko-outbox-166501@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-166501@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0005.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::28) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|CY8PR11MB7395:EE_
X-MS-Office365-Filtering-Correlation-Id: b819906a-390d-4576-9fac-08df292f8e90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|6133799003|18002099003|261009223027099003|10067099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: tPJovYPO+AunZEWxu113f9uF2jKSESqrLAjL2F42TO01jq1WBfvRHAk/rwpU+nlohGT8ki8OaKxp3d7urZo834zulPdu7lAn9mrFS45omcIeX9CGRuxNFN9i/+IOuAjdtvdm2MtHp4QDORzhx6caDXfr7tsov+uZpM7mXF0zfFH9Y1uJntoL4u+wjx6OlkPfGlFrzcbWPaO6HnKEUZEETnHPKOBAEwmxouIJY26vmbMXciEtTsfkMTL2KPopmK03/e+rWpNxR3ea/oSHXcuQZzeMB2ADqa7AxE2ZULaBJVi9rXn68ews/CVBt7BmLIIJOlWkcTJasd95XpinukhZ31y569WEktVLWDAKiBOrdO/JPrVDY/LsoBscnoYfAt5AGnvr1i6jeSxjdcIcVuIueHVTOsYXR6JNIdjiNiclGDXJ7zdA8jL4CGwXDEfT6KJ0UqkvhXpA9gAq4QC37Vkd0+IynevU//mQio70919oAlOzADRX6YLtkPhDWniY/WOAG69HJk8DY8H23b5CeBignPM+ymJ6g9bN8bq9JXoK4BUiqTWZhflXd/MWSWpP8uNjO7YOyb2WiB0nCBoutCytfJ68Un20kd80f6g5bkM4vykcUrzeji/EkPWMCwEiIPuSB5INhTtdv5hpaj3qTPgLQInjQez/nSpraPSR6hX8Gsw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(18002099003)(261009223027099003)(10067099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFNZblp5dGFhWWlKdUNmY2IwSzQrZ2lGaWVwUnE2djZpMWhwYVI4QUUwYWxk?=
 =?utf-8?B?UXduSUFOUjNaVzJJd3g4S2kwOTdUWDZNUzIzczFFTmxvUXoyQ2ZFZ1k0QWV5?=
 =?utf-8?B?bTVTc0x3eThrTkxicEdGT292ekIyZXI2TmlUMTJrRjRxb2pWY2E1RTZTQU9z?=
 =?utf-8?B?Zm1OS0tvdWZQR2lQWE9WRnhhRG1GU0swNy9DcjNGR0ZEM1F3OTVGMGpxaEEz?=
 =?utf-8?B?UE5aVGhOUmtqVzJJeTNSY2wvUTNPclMwZmtvd1dTQk96TEUxYnIrNEU4QnNm?=
 =?utf-8?B?SE1LRHB6Ykl5djhRdVFhN2xONWZ6TUJVRWpwMkpZUlB1TXBWQXNoemlZQ0tI?=
 =?utf-8?B?MUlmNzNqMW1FUEFLSjZFMy9kWmFaSTlEWU1CTVBVK3ptMTdERjdZQ2xRVGVY?=
 =?utf-8?B?YnMrZU9TWVllQkNPcXhiYmtEcWpkMVpDT29NdjAwODNhTTFSalFHb2c0Vmt4?=
 =?utf-8?B?VzE5WGhncU5VNll2emc2V1R2b1REdmlQMlhlVFM0OE1XR0prRTdPUlE3YXpk?=
 =?utf-8?B?SGx5d3M5YlJHY1VnWTU0bEFtSSttcHc3MWhIUDR2NzJCMi9vdTVIMXRGeUhZ?=
 =?utf-8?B?ZTNnMnhRS1V0Y29XNHhCZHVDcDZ3Q1lTeG9xWDdrYnV0aVdCWjlpOTFWdkZX?=
 =?utf-8?B?NlZQanFhNUxQYWhYR1NnSk1PWG9YZmR0N1pDQnFVMlJua0twR2JFVUhmR0ll?=
 =?utf-8?B?T2NjbVROWUhkQm8vNEJEWFZBR0RScHlWeUVNYWZldk5qeXUyeThjbCtEc2x1?=
 =?utf-8?B?RE1QbUgrZkxIRkw0THVSeENjVFlxaTB3NnNqZVB3QkFYWEVNL1pZd1hpc2Fz?=
 =?utf-8?B?Zi9JQVdmeEV0TWV0VVlvQmF0ejZEZWFTVzVGb0JTU25yU2NOUkRiVFQvamg5?=
 =?utf-8?B?dHJXNE5DYWJmUkQvdk5GOUx0R2UwTll3SzRrV2JNZE81N1Voeng4eWszY24r?=
 =?utf-8?B?SEIrS3BpeUNhNUZFSFM1N0RPcUpKZTdiRkQyc3BmR0R3RENndERVNWRrdU5F?=
 =?utf-8?B?OGk1WU1zWC9XNnZvejd3SU9UcVFMMWhKUkpjbWtHTU02TndZd2FFMHdEUW5Y?=
 =?utf-8?B?NmIwc3VJQ0tVcllxSzJVQ3BWTUlrU0NWeTdxdmNTN2IwQ25HYVVDblNNTWhR?=
 =?utf-8?B?NXp4cEZOS3dxd2VuQjcwYU82QUtIc2t2cmFFTGVzL011bnpwd3BZZVVBOTJi?=
 =?utf-8?B?bnZiYWhTM3o4TmtCOFpxWWlPa1ZqbEZFeW1IbGhsZW9FTTFvNkN3bVdUaGow?=
 =?utf-8?B?bFJjRTg2b25JMmFYeWQrN3dpYmlIZEhyck5nb1ZMT0tyczlwZGFSTDRnWnVq?=
 =?utf-8?B?cURpZmVsUWt6SjN4M3QwZElaRjZJWWhnUS9zbE5jbVVldlNiTGtkRml6QWFP?=
 =?utf-8?B?cG50SS8zNEpQS3VxRnl3M3BjTTVXTUZ3QVlWcVd1Tk1sTkczQjZpb1lHRVhi?=
 =?utf-8?B?RjduTlhIM09lUlRXODU2TkhLYWhobEkwdzVzMWpuWHJoLytaTkxTZmpHNXA1?=
 =?utf-8?B?bWd1VmN3aTBmckNCN1hvZm5ZalJXRzFUQitWWWtsMDl4QTgzWnc1L2NrWHRU?=
 =?utf-8?B?VGxGQXJrQUZpWFQyZVZZY0lwYmFQa1J6eHhhTlFhSGFRYllURE9ZRzBSbWpG?=
 =?utf-8?B?UDM5ZS85VkhOckNpdHM3bVZJRHhjVmQ2MHgxRFZyUE16aDZ2SE5PNnA1aktT?=
 =?utf-8?B?TFNpcUNQTzFHT2U2T2xCN05jZU03ZjhBRWEvWVlpTy9mMnlUaUNxc0IrNVE0?=
 =?utf-8?B?amRIb0JnRnJ2QU5WRWdwVjJoQXQweStXcVJYbkMrQ05VM0NTY3hRYkcrSk1Q?=
 =?utf-8?B?dHRjVm9MNmhSOWdQL1N4N0dlSmdVTitvdHE1Y25pdDVyM0h3bVJJTUpMK0RQ?=
 =?utf-8?B?R2d0M2ttMWIrL0NEWGVqQ28ydEtnOG4wS2w1amFqODBlM2YxVC9qYlE5bm1q?=
 =?utf-8?B?d05NQ3dvTFdNT1lqVHJFNXFnSzBTcVNvNDNSazZua3NsNVlUUjQyWk1kb3Vt?=
 =?utf-8?B?aTNqOXIydnBuVmVVSTNhbm1UczhKRFV2M0pzbXhkLzhwUmNQUXF2UmtJVXJN?=
 =?utf-8?B?VnFRNUZzbldwWFJYeGh4NkQrekMxT0NSUFBiOUxNU3VJSHcyTFEzczc0THRm?=
 =?utf-8?B?cmo2RXdPQlF2OVJyV1J2aHQ4NHlYMkNNYXBvUWMyaEJqVXp2dW9aZUtZZWUv?=
 =?utf-8?B?M2svRGFzSzY3YTY4S0oxZ3E5MkRkdmtqalVkclR0czRsTkVMODV2alg1VVBj?=
 =?utf-8?B?UXgyZTdnUFM3L1RZZHY1Tm94S3lIZ2pYb3lMVTFNMVcxc0g5bGZSR3R5MTcw?=
 =?utf-8?B?L1Q0aERTN3c1ZWVGdmc3MFQ0UnlubXZObUg1UXRnemRyMnVKbmQyLzhadFRF?=
 =?utf-8?Q?i3uOP2q+906nVvP4=3D?=
X-Exchange-RoutingPolicyChecked: TDSBnPHYqBIWrOShOqt+v/kmiomkH/CsPWjfyyoFZTptd9Q1QhrWrJB3Rr01wfNfqYp0ji/AQp/gGdBTp0cxJx3AeCwR8P3BZD/vrEONYUJ+pzRlE0sFP3ar8qPI6oWhhwWvlyRqTn6OqAWxdkA8/C6mT0/ZO1RMV/FaviXBRu4YixNTIBszzH8P/J3vn+1i7L8cZkzSdNPr+hC9vmjl5iUZb7FBjnJnwN7X7/czRqa6nUoRVocX7JnyJaT3iLwRX6DFnndX37OvO7Bn3gwP1x5XuzRe4DPb52GrkFqcbGMC26a8LU1/wBy0NIBKSKSIJH2+itqbT7YBQE1R+drQkA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b819906a-390d-4576-9fac-08df292f8e90
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 13:40:34.3038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWs9iQ2DM9S7Ng7uiUe0dCimxLuK/xBoJjrbJC2M9vuq7SPpcDZN5Civnh84WDYHzUwkOf7Z/y3Q6nx9VWDAg4VQLCMOPeQk8X2HLHrgsqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7395
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

On 10/10/26 2:16 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] ice: virtchnl error path disables wrong queues when loop index != queue_id

unlikely error, but easy to fix, will do as v3 is needed anyway

> --
> 
> commit a7e9d03ecfb2e4d593b7ee51e67a3a4e87ee7a85
> Author: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> ice: bump to 256qs for VF
> 
> This commit adjusts limits, bitmaps, and arrays in the ice driver to support
> up to 256 VF queues. It updates the requested and default queue limits while
> retaining the legacy 16-queue limit for older virtchnl opcodes.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/virt/queues.c b/drivers/net/ethernet/intel/ice/virt/queues.c
>> index 2667634e3c8c3..61304493af34b 100644
>> --- a/drivers/net/ethernet/intel/ice/virt/queues.c
>> +++ b/drivers/net/ethernet/intel/ice/virt/queues.c
> [ ... ]
>> @@ -841,7 +841,7 @@ int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
>>   	if (!vsi)
>>   		goto error_param;
>>   
>> -	if (qci->num_queue_pairs > ICE_MAX_QS_PER_VF_VCV1 ||
>> +	if (qci->num_queue_pairs > ICE_MAX_QS_PER_VF ||
>>   	    qci->num_queue_pairs > min_t(u16, vsi->alloc_txq, vsi->alloc_rxq)) {
>>   		dev_err(ice_pf_to_dev(pf), "VF-%d requesting more than supported number of queues: %d\n",
>>   			vf->vf_id, min_t(u16, vsi->alloc_txq, vsi->alloc_rxq));
> 
> [Severity: High]
> With the queue limit raised to 256, does the error handling at the end of
> ice_vc_cfg_qs_msg() disable the correct queues when a failure occurs?
> 
> Since 256 queue pairs exceed the 4096-byte admin queue buffer limit, the VF
> driver must split queue configurations across multiple virtchnl messages. In
> the second and subsequent messages, the array index i will not match the
> actual queue ID being configured (qci->qpair[i].rxq.queue_id).
> 
> If an error occurs during these later messages, the cleanup path iterates
> using the array index i:
> 
> error_param:
>      /* disable whatever we can */
>      for (; i >= 0; i--) {
>          if (ice_vsi_ctrl_one_rx_ring(vsi, false, i, true))
>              ...
>          if (ice_vf_vsi_dis_single_txq(vf, vsi, i))
>              ...
>      }
> 
> Could this use of i instead of the actual queue ID inadvertently disable
> unrelated queues, causing a denial of service to other active queue pairs,
> while leaving the newly configured, partially-initialized queues active?
> 

