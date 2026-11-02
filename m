Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ED3606A326
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 21:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=kpDN4xGp;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jqm+r2QM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3EBF2605FF;
	Mon,  2 Nov 2026 21:09:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qvn9y1o9XKDS; Mon,  2 Nov 2026 21:09:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 81BBB6060B
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793653766;
	b=ONXJRxgKiNiPzyNn2aXJIvnJ2Uv44l+zjnSZtFArBv0Oiy1U3Ps32Vuubtyg+tMY2lbC
	 GCoXsakdBtWCwIn0utNdW3wzSiPfR16I1UkD/jYE7X1vb9Oj1GkZHBzfE7HG3HkyK7swr
	 ny8711jiGUKGcTcK8QU4zc3M7zm0jRj8M7ubD9xVa0fE9L9RpHmvO39ReTe9C4IUKZgns
	 rO3WkE7kdnvP7ctaBZag6HBg7Ykr5cnLVRaBJlQCIANJ2LzpKwwVSX0iIByC6aNR8u5Td
	 z+9BcTFfVCwvozXyAo8/5es1WVohfr7LQAMc8uK9ob0l5hONEl9vDloaz8f1GaTZNcQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793653766;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:References:From:
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
	bh=vVvutdzLQGKR2l8sNDzXvfu4MmGKFNrGce38m+IuvFk=;
	b=lkUqeoSuZplzZolhhyiv1OvWl1zMQZZQ0rvfbZuhW8WKaG/Vjsttuou5GOwlsZ4RPIYm
	 Olfv9NZrHBb2ekj3M3d9GzUlUdBc5fBuqIsZBNScXMrNNGz6XJMLRLzdGnEdehPMsEQVy
	 BpFpQ5XE8/C8q1q1VBJvcqIntBWP7ZfCD7D+VVeH/2cZez8gXsPcGh7V9P4rd6Ve/QQE8
	 hJ260exWtpEpCZriTeaHiycrgsSUg0bTGKcnlCI7nXyU3OpTMPge/e70hmcLlAwEUmjB+
	 6S5Tkh2TCFfqs0c8m+jL6j5dzYYEeP+IMksw8spl19/jNTvCGe36cWstrNv/wCLnWUA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793653766;
	bh=vVvutdzLQGKR2l8sNDzXvfu4MmGKFNrGce38m+IuvFk=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kpDN4xGpsQMQz51+079KcwzkXBD2Bc3Vebym9ZjlZmovKR9drjGYN1aLMKx5gkkFs
	 eSJEdggM5UuMyAACp2SUjN61dMOSwYP9UUhrYZ76q2G9cq32M45mVNwLTv55EmsLIU
	 tdUBCMbrfqP5u/xheuVPdlbTMGfmNjp2s0zzU0EeUvVmZRa8Ye3WqaDO3jxweg1mAr
	 O2cOG8Emegbq3V9thILZR2ZO5gXDnHrKf3r+DIA6ySkOygMqThlttVAvlAzkA4fqw9
	 pgHlQjf/SBBAkNQMqTc5JJSDIvdKwcwUTj2i2eA1LP85kD/M17o2JF/OPAvjRGkkH5
	 kbz+vwydP+WGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 81BBB6060B;
	Mon,  2 Nov 2026 21:09:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 96C654BC
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 21:09:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7C98E80AB2
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 21:09:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S_J5vqH6Xcd2 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Nov 2026 21:09:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ACF9380AAA
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=198.175.65.14
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793653763;
 b=FDkPb4RTmN4PrQYyvaf4YAyQbPWp0krj+vHKwMRvshGh6Omh6vtK/SjZOdnQVV2T1LV9
 KXwE9ymuYHvXr0Jbi1Ben//fuLxq3ylkEVipmSEZOgzHqyNphGEFcZNjdg0ETkh3wsviD
 whGE3DyZe5l3OR5QpjH7bjtbhYCw1I23h5+qFklegHxo5POuwvZA2xw3Fr54TvEi+CzGh
 K0mYyRLEQ6xW/1Gj7uIAhRHVzIjLhE1lxMMYJsZX+SFEisGsrPWbw8LHUs6AOvbnefTI7
 1Nz6BgEvMYesUawempFT1WfyNXXmWx7JgXy7JhcWs4hjPvED1x5hTyYja79rMNyhC1g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793653763;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:
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
 bh=vVvutdzLQGKR2l8sNDzXvfu4MmGKFNrGce38m+IuvFk=;
 b=Fx8SBal2hov7XT+f0ZklKGMjMFxXddJWiJD9225mIlmAfGe+7d3E2AgxQA5laUUbur2/
 hLVse591LHLAXEGcCDmlVxS4U4lGT5+MGex7x4DNEI3NSmoQIIZy+YUdZu4VTb0XHl6xb
 Eu19uDzE4g3RK3hT0ScdWuEAKa5rN1ROVLl3SclqLHCiTM1f4SGb0zVqUfxCcFuILqaCP
 SlBQz4stGDghz5C1DSZ+8Sj5Jwd96lhZTGWxDwv1OOQ3/V9C9/hS7k+TrBIlqxf6QRvfE
 ksdLP496PpMDN636YsqRy42Vzk7UQ1zHCI8eY9QNZbAmP9eZgP1WwjgCJeDK9YYo0zA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=jqm+r2QM; 
 arc=fail smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=jqm+r2QM
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ACF9380AAA
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 21:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793653764; x=1825189764;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=jBzxkqhQs2g+DT62/IHr4fr8qEF9NjQ93u3cZLJ2U6Q=;
 b=jqm+r2QM6SEr4uLowEK7yq7kGPaMoOgFh3q9AFVEjHqsrNi5RjYttK+L
 FSEAERADqfzUO0pgpcuZmWV8Hsu0Ii1Ifw/PRvZHoJTLmRVPMy881nexA
 X4sK19qKtHi5CjgpbH5RVmJWZSRUCu8xHVKABRccox8tMUxRbpG+rR4N0
 IFfBbYNAQ7PwOmq0uDFcjz2bn6lLLCpprvBCgcSZ8OiidUMvKS/lKlSCG
 NpKf67D01LHr+/XhcDdZzQ28HvR7xZgggoKExrp4xWNcKD6XQXLY0FvlC
 Lqff/vPcdNF0vQAQoAFkVpEHiysGz7W9wu+fu46yvHy/vUpQ7HTrYCQ11 Q==;
X-CSE-ConnectionGUID: kBxcGPtxT7ykhR7KQ/eJlg==
X-CSE-MsgGUID: qAzoay6JQgSl5jyKuF0eoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2245331"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2245331"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 13:09:22 -0800
X-CSE-ConnectionGUID: Hmgpy651Qr+r3tfd3pYYaA==
X-CSE-MsgGUID: GF5DKS1LS+CpIA6c/fKR4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6229826"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 13:09:22 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 13:09:21 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 13:09:21 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.39) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 13:09:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBDCjZ8RYdHtDnRa5PJc9ynBdkLqb2AEmJqu/fKzaDY/+w4HUQ7Qh9NdD65v/khA0ue1KOUwXONouCeKeE3Du5MQOZxNi2o/q+CNHYuNxyWiJcOL6N5E7lJl+2pP6/5JcNIeie9Hry7sUYjCqcu1i38g07YYrEc9YxqUmPev9/x7AIMmmTncoX0LlnnYHIHDCeuw0BXV9hPXf/dp7R8ZMuo3jSvl6kF7C+8ZGq6KIOP9nFNPWgP4W+tVEtiPBMYbzsZEUQft7Eo/HswpWtDTYyxpomKfWIyFnXh+0aNYgf5LpELu9CaKLwHqIs5ELtzT8ula93lx2wCZNTl1M4Du+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVvutdzLQGKR2l8sNDzXvfu4MmGKFNrGce38m+IuvFk=;
 b=fSKnnTA23AM117QvpY1zZRhA5H5kYkzYt8+QxXOfh7/DckEEjNgbrWKBY6TbGHuqzLq4mEq88MZ+e0E/PPZ8y78RSQy9sWqFRXI1VZQgEGXdEUn5vGSvM5LC3/3SCl4MQPt3UXC1qid1S6+040lTjLevi4zonpHi6e54xIBEi81Tdw9dif/H06HVDNOHdER8G5cqSwUcyrba4d5wsI+FZntuc+65frO2H65S0KUODC4bAFvEFmiSe1vo3eBspDwsV7oJ+lt54ntHIwTNeeKBfQnqWXUWuSxVZOHObEq3Qd+k+9HaaSogPWd1qJwqoxqUm/vznOzm+Zj3cMMFQnAB+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by LV3PR11MB8578.namprd11.prod.outlook.com (2603:10b6:408:1b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 21:09:12 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 21:09:12 +0000
Message-ID: <c858f6d0-2adb-4bd6-9889-19e14b0e30eb@intel.com>
Date: Mon, 2 Nov 2026 13:09:10 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2] ice: validate VF FDIR queue and queue region
 actions
To: <sashiko-reviews@lists.linux.dev>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, <intel-wired-lan@lists.osuosl.org>
References: <20261013144435.1406126-1-aleksandr.loktionov@intel.com>
 <sashiko-outbox-169952@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-169952@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::32) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|LV3PR11MB8578:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b62897e-3e4f-4d97-af02-08df39258b2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|10067099003|261102123227099003|22082099003|18002099003|3023799007|56012099006|4143699003|261026121527099003|11063799006|261022105027099003|261022075727099003|261021121427099003|261009223027099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: oWihULSKyn6KIwqaV6jojvI2HKgSC5WWaf5HYP6w7UjtpRQ0TwdFr3Njh/aoZjKTRDATAeHta6aTz+qN/oPD5pUS9jwEHd9VvNUoaAWlh7plmKk3Vp0IM7mlvJu2D7RkxbasR0JdJC2Ip/yGVOzm67M15I9WvJceF3nsNSud4/h/VhtqZRVSerEeTake0BgI6+SNN6bhH/NpalxNHT8FdeJSwT8kPw0z+R9BnzfBFGzFIaFdw53SVbj9QVLT3u33L30h4xyicUrt8kuJ7en5ZFWJu9hH9VrULQoew+y/SQTRS6X7lDwF4WMGqKAwdm7UZt04SSmp5TyysQE6kD+qYHli4+UIPsZ9rtr8YEZ5ZH2Wg9ZwzP9iaJYwp6EsGTVr/vOuPmpEh5mbS3jfcJqoMBh7yot6R9V1XyvHjEDlO1b+x+RhYm3lNn+D08DLrZpdveQcEKGrlEJ36LKNoSx4DkwEqG0/5GFH2Kb6lLZXPVdpYCF9EQNOXVC+dtsv7EjL1ePg2N8j8Rt7aZR2A7wkss3Aa8J1QeAGuYsYCmlXYmCSx7QVn0Oq6OYcaTabNIknlARGM/KV7C4Dw/sIgY2R29L7V+uircN2PjRTzcl0vRJaNBjhUMoMEB5zpEB2On4Sm8dhruf6KDxfSuTmnc/betGDqzjCAYDVWQLb8blCZmE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7381.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(261102123227099003)(22082099003)(18002099003)(3023799007)(56012099006)(4143699003)(261026121527099003)(11063799006)(261022105027099003)(261022075727099003)(261021121427099003)(261009223027099003)(261028144727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3kxbUtwVlZLaHl3ZXo1VGlsUFRJMmUvSWxLYURRUjg2RzlxSFhPcnJpcXlp?=
 =?utf-8?B?ZU82WEdmaWl6ZWNJVEJxbHhtdTR0a2NRWnhEeVhKb0FWZ0p2VHhMN2kxVVNR?=
 =?utf-8?B?aC80ZnNDTUdVdFlRcUVxeGZhaXdxUVg2eFVOWVpjeTlFdExUeGlITDBSVnFK?=
 =?utf-8?B?YjhPcTA0UWd0ZDAzekRGZWJ3YkwwaUpmNUs3TFhHTFNHdkhXeXZ0d216Yi9W?=
 =?utf-8?B?R0taa05tOEtRQXFwTUVBTldzY0xhVzQ3ZWVHTm9vWSsyTjNlODdPQXN1UmVw?=
 =?utf-8?B?UU1yOE4zRXZ1cDIzNkNqUFZrNnVBN2I5UkU4OUpwNmkveHRYc3lXNHI4bjJm?=
 =?utf-8?B?ZFc0Y204VVl2dDNtMUJFaFVEOW0ydk9KZHFuZmVwdGo5YzNBQUV6eXRSVHhZ?=
 =?utf-8?B?WmM5ZktKUXYvbkcwaDlwU3QxeTcvdGlaYWpid3VuMGZHMWpza0xOY29PWHR2?=
 =?utf-8?B?M1ZuRTExNlUrODdsNWJ5VW9rVy81NjI2b3Y1Sk84KzBvY0xORitOWDFrUGRh?=
 =?utf-8?B?T1lnWVZYVW5lbGFaSXYyQUo1aXhEZldJK3ZIRVpVZDkrSk54dnR3TWg2ZGpG?=
 =?utf-8?B?V1M4YTFhRXdROGxlOXlqQjJBQkxCV0o5UzdURyszaStRWWRaSVpWaUVoNzRo?=
 =?utf-8?B?ZkdaZ1FrWjBDZkRzWVRPN1h2dGdCZVlyWFZTS294ZlRtQ0xvSWd0aHlyZi9D?=
 =?utf-8?B?MEE2c25lVGRWczE2Q2lsUkU2MUo4WFl6ZDY3WVRZUjBlVnJvY0dnTVJGS1Uz?=
 =?utf-8?B?MlFla3dlQjVXN3ZRSjM2S0lTVHpycWN3TnBrQlpOamluUFZDSHdjMGlBb2pT?=
 =?utf-8?B?OENJbDlwNlVSR1Z4bFUwVjFYUmJGVm5rVmJaT1hQZC9yQW83MUNqa2JjYTVa?=
 =?utf-8?B?ZjhYY1BzKy9SRWhhaTA3S1l0U3BxMWdVVFJUYkxVTlB1cVp5N1lXVC8ybDcw?=
 =?utf-8?B?c3ZDUFRoL3ByTnFXOFR0bHNTUWFPSkZyd0NIS1o5WHNlbnYvNlA2N3dBRkdG?=
 =?utf-8?B?MHRiTTBpbnI0VFhxNTRXZUF3U3E3OHBkSzE4aSsyNmNRTG45U05oYnlCVm9p?=
 =?utf-8?B?dm43QkF2aXJwMTU2UGNtMzNGL2NEN0R4eWdmd2dES216Z09QRytUUEVHNFoy?=
 =?utf-8?B?bkZjN2JwSmdIY2VWS2xuNXU3dUkrTlVNTSt5Z29SQVllWHBIRUNEa3gwbkJY?=
 =?utf-8?B?QlZpTlNzNVR4ZGUrdWJGOElwRmp1bFNzVTIzRWFYWVZrRkQ5ckxwWVAvaTFR?=
 =?utf-8?B?dVp0eFV2UnRDNVFJVFpEc05DWDhwNVVHYUlueUJ3ZFFqSTZYK0ZIcEppTmE5?=
 =?utf-8?B?eHhCMkhxdnBXSEUwNE5rNGpNbVExNy9uRTR4RXZlOCsxYVJlalpPQlV3UEtL?=
 =?utf-8?B?WjF1SE9WOWkvSUVBUXRtQStmc0libmI0djF2cnA4VXF1VlBPSXlvY29Pb2Ra?=
 =?utf-8?B?dkljR2xGd0QreUZocGFVdHREWndBYW5wUDAvK05RL0ZGSUZoNE0zU05Zb3FI?=
 =?utf-8?B?N08yc045WW5IcGUrRitaR09BQWVrcjRENnMxZUtpUnpoY25QbmZBQW9sOFlD?=
 =?utf-8?B?VHNDbVU2cUZsWkI4YVhsRDJMUm1LaThWYThkU0Vsc3hxcGdlYTU1SjdoK094?=
 =?utf-8?B?ekZBTk84Z1p6RldTR0ZSR1NHU2lPYUZONDZlWEdINWNPMHBObWF0UTVxUCsz?=
 =?utf-8?B?Q0dJUHduOTNlQ01YdkpaRk1ZWE1hVTdiTjQ3anFMTHJMaThnSHRJMzRZY2xt?=
 =?utf-8?B?RUlpY2JMNWVEK0dYYU4zUVUrYWR3MSs2dUJWWTJQTElGV0FpOFlTakxuSXc5?=
 =?utf-8?B?NkVLYWhSdUJPcmVUN1FSOGY2bVZpcUZ4K3k5N2JuRC9pQ01DdndndnM3TklY?=
 =?utf-8?B?ZWJONWltbndjclE1MFVpZE9BR2VXbURHTHRMbC9EaFR4VDl0eXE5K1RxVmNv?=
 =?utf-8?B?WHh1UytpMlZqZXdVcm5FaHM0VUl3dms0UmF5YlNpTG1DS3lWcG9aSWgxNkRU?=
 =?utf-8?B?TzROQWo1bjI0bWhQTXpvbVJzMjZ0cHNWUjdrTXkyV0MyTXcxcTZZMkc4Znd0?=
 =?utf-8?B?Sm15RWVwNEhUUFJJcmoyRDN0bUR3emRuaDhTeUxETWx6dFZGQ1paWWl2UjJL?=
 =?utf-8?B?azkyaUs1SWRMQzllOXlIZEN1WG5FMllwajdZSEEyUUp5bnU5OWkyd1lDcU1B?=
 =?utf-8?B?MytZbS9YeFI0TDdNSXovRDBOaVJHZHlLKzZaVW5jOVlYbjZxalNhaVZ5OWow?=
 =?utf-8?B?SE44ZXBleS9OWkIrcXA3Y1dnRzRReFhLTXN2YWZjekpuMzRKK3cxYUpoemJn?=
 =?utf-8?B?blhFQXl3bXA1Y1Z4ZjFNc3NzRW1vcjhadWlDVjF4cHhMMFQ4NjZXUT09?=
X-Exchange-RoutingPolicyChecked: VoYvFgPf+yb+CYJXM9tvBkJVoKpnSL7bL82eS5Q2qrikjxEsaKE0jxePCr0oB6OLJyZxHC9PkMOsBFYsSqokPVt1jNdLXuit/RoVWlRs0tM1CnxLsBmntTGb+puQWhVOa/aAXL77WfD/vnpdDf/A7KIj1z65dzROzL0IQVZzg/pNhsHcbtJ0sZpEd0Jn/a9DQU82WYkk3jC1CP5Xjue3tXXzY6U3DHw+1taKSq/uFl+1CQ3hB2pgXwj34ntWimXqT9LIAP5pcXc+Tb+y+5wXKS9wLYfA6JkvFKYIE8Gs/Ev++ueDZ/jDpvjc5yS3XUV7ZD4AmuPgrz8ykLkbaScRlg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b62897e-3e4f-4d97-af02-08df39258b2c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 21:09:12.2798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19g23TzwR1YL7Zm7hdaIDmI1wcr8VlVI0SUEv36rFyfvi62QFZfxoeWkcuhXA7FQfLdkVgjf9caGTdcQm/+mGr23JrUNBulAXtjqA/Mv4+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8578
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/13/2026 7:58 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] ice: memory leak of pkt_buf and prof in ice_vc_add_fdir_fltr error path
> --
> 
> commit 6477a5eb13b0a0dff01249d4a775aff5939e63e5
> Author: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> ice: validate VF FDIR queue and queue region actions
> 
> This commit validates the VF-supplied queue index and queue region in
> ice_vc_fdir_parse_action(), rejecting invalid values to prevent a VF from
> steering matched packets to queues beyond its own range.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/virt/fdir.c b/drivers/net/ethernet/intel/ice/virt/fdir.c
>> --- a/drivers/net/ethernet/intel/ice/virt/fdir.c
>> +++ b/drivers/net/ethernet/intel/ice/virt/fdir.c
> [ ... ]
>> @@ -1176,11 +1181,25 @@ ice_vc_fdir_parse_action(struct ice_vf *vf, struct virtchnl_fdir_add *fltr,
>>  			break;
>>  		case VIRTCHNL_ACTION_QUEUE:
>>  			dest_num++;
>> +			if (action->act_conf.queue.index >= vsi->num_rxq) {
>> +				dev_dbg(dev, "Invalid queue index %u for VF %d\n",
>> +					action->act_conf.queue.index, vf->vf_id);
>> +				return -EINVAL;
>> +			}
> 
> [Severity: High]
> This problem wasn't introduced by this patch, but does returning here leak
> memory if conf->pkt_buf and conf->prof were previously allocated?
> 
> In ice_vc_add_fdir_fltr(), if ice_vc_fdir_parse_action() fails, it jumps to
> err_free_conf which frees the outer structure but not the inner ones:
> 
> ice_vc_add_fdir_fltr() {
>     ...
>     ret = ice_vc_fdir_parse_action(vf, fltr, conf);
>     if (ret) {
>         ...
>         goto err_free_conf;
>     }
>     ...
> err_free_conf:
>     devm_kfree(dev, conf);
>     ...
> }
> 
> Earlier in the request handling, if this was a raw flow,
> ice_vc_fdir_parse_raw() allocates pkt_buf and prof and assigns them to the
> conf structure:
> 
> ice_vc_fdir_parse_raw() {
>     ...
>     pkt_buf = kzalloc(pkt_len, GFP_KERNEL);
>     ...
>     conf->pkt_buf = pkt_buf;
>     ...
> }
> 
> Could an untrusted VF exhaust host memory by repeatedly sending requests
> with invalid queue parameters that trigger this return path?
> 

At the very least, this new error should perform cleanup, even if you
don't take the time to fix every existing error path way that is broken.
Can you please investigate?

Thanks,
Jake

>>  			input->dest_ctl = ICE_FLTR_PRGM_DESC_DEST_DIRECT_PKT_QINDEX;
>>  			input->q_index = action->act_conf.queue.index;
>>  			break;
> [ ... ]
> 

