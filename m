Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5BFCA6011
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 17:35:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5370060825;
	Thu,  8 Oct 2026 17:35:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F9ZQRR8EPNBl; Thu,  8 Oct 2026 17:35:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7EF6E6072E
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791480940;
	b=cda/53OzdmrKpO2lydqP7dNphDSVnbKKSCvD4Bj9JydshaZy/aXrvgGg4dxkRJPkFYQD
	 fi5JgClZK6KhZ4ceQJrhafPVpBwdsuNjRkSEBP7WPDS2vijcIaxCsZN0O+lPHNCkIkFTS
	 tQBMHxk24K5SMHxnJf3F2Cfm0M1euW0u4nLtOxdDnkfjgaWSSwKsngaqfjwr9iTQJ0i6U
	 tb0MOq+hYp16UduUJQ5pDgbkWg2JGRLSNhy5N2nQJe0o2XxuscHd4hR9Y85bHr4HziozP
	 oX207+lcqcra6xkVk579sVb9ANkwDCPqlcmZZvwVRzcG29lRTpR6JLqOyx1jkHV0UZg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791480940;
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
	bh=ggVdJjsQCzIYFsmFqrW7wx3fJCRHgzhE99K2sQjN+HE=;
	b=bvZCiSoo4t91UpxxgwNIEFx9gYhfpX554NbVQCSt8UTlk9+/hjZJT4ier9ZMfks/NRac
	 iXd8untnzWXe0FFYz8/BzOqj1CbXoJwXRaKWpbgrmOFswa2gQuEQb6zE3TPf69L6hj57x
	 8gu3AaKFJbpP+3xdK59WFligDg8MOCUvOsnqwAZLq21d6xdWqysn9kQHxVJml+KpSTV7F
	 AUXpHmpIvy04+wnfkAe8z5Uvzhr3CHcwPDT0tNpWRzsFz05Mq4MNgJZwYilpY8NdHyc67
	 a1nOw+HmNhgITpf9YWYrFh0gyvAKO4xJcgedY+zvXcuctj65qSZNsqcyiEFsYnOL+YQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791480940;
	bh=ggVdJjsQCzIYFsmFqrW7wx3fJCRHgzhE99K2sQjN+HE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nNZfXE4UJ1f0tzBb5ooCtfUC+6lzkF4kc71F8wehq1eeWl9knXULdV6ilX0E1DsoI
	 v0oJ72/4dO54F6+GiIOSw0aTzGvFzsJ5ecSNDueLRXm1ylzKHbQ2gpkugLVvjNc6WF
	 gbDMsCtvTXjbumJy1H20K5JZNljePVMsqRUKthJIvBNB5Y6KCo2cnxp9YctQcIK+fY
	 iBBEJAyesvMrIf3Pfns92Bu59CdiTozySPod1CXD4qP2oXKtBf3gmPShgnpteA3cwb
	 OGVp3wGzWc4ayjWAHI6msuTYpa7QD3hjMRkbIiIWi8G6wVMk9Yr9bA57I66NzDE3wN
	 gRs4oaJ51uRWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7EF6E6072E;
	Thu,  8 Oct 2026 17:35:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id F2AD81A6
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 17:35:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D8CAE81341
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 17:35:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DR_wyNDK4AKA for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 17:35:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C07548133E
Authentication-Results: smtp1.osuosl.org;
 arc=fail smtp.remote-ip=192.198.163.14
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791480938;
 b=Wv1bdwr5cSPnJOrtBry+WIngg/0+BoRn0otEEe+wQq/Ll9M9OVA0EqPIUug6gJzD5TMk
 +cjz13Up0gAq+zBM5t+XOV3y21sWUGuiBiBUahGd9O3a/Tt4a9P4NNA7Xs4t/GQVeSjVf
 DyRUPBAu66Cw1u1RtjmLzGDCxKDKjVE8nQEH1WEZR5mPwNJZ2FPVlzgiKhuIVYYlsdNhA
 hsviAea9eLzDwN8rWDR3jUhduEHyBoc4cMJJ67YpdsQuJgWBWBXaqsBvMKEcODrUuSw6L
 EvUdU+11qpRweEwmQev1uiZi3U1UAwQvS4uap5z1F5G254kyGAE7spHlC+B+pqrBSuA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791480938;
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
 bh=ggVdJjsQCzIYFsmFqrW7wx3fJCRHgzhE99K2sQjN+HE=;
 b=ZAmwnzxWQzdJY/p82HLGOAF91b13IEr1eKVxSUqkxugjQHEmivMAtbzZVmSeBMbMlpku
 zw4/WjBwh8SaOsyKO1nUsE1w8P99h7WfM3UOMBGKjzCWRHOsi+91J2cQSyCSW4d/JkB2g
 T+2TVyMjYSpQLox/dkS071OzFwek+Kg0YCYgLMXrh/LczIDO9RYgBz4cwG8Nkro2FEker
 YUhswJ050m5pvoP8nl2wms85SSr8MgmP7KhtVC0A4BZIcWwArpCNIivjyHKs3s22SvFiD
 un2j8ogaR+7zCEvBdjlA6CNg5Dk9xJZsur4+9YlIax2qIaVH6Z2jV8R7YXMTmBUi8NQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=mRSEc9rQ; 
 arc=fail smtp.remote-ip=192.198.163.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=anthony.l.nguyen@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=mRSEc9rQ
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C07548133E
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 17:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791480938; x=1823016938;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mq6tFlsBwf71mKXXhEoTnKUqDbUTeLsuo/kvgKcfMpg=;
 b=mRSEc9rQlW0178UbZLx/6G9OBDmQivfEcig2LvSOBmNrn5q7UhLLcUVY
 0jnNS2Vw4dtm3Vh7PNAM+A2QO5e+X2tQrIC1rfUmZZjHrK673R+ktxEej
 7aHMEr50/wR3zfjsV2OvaHPYca6IH5WgIiifefiNHtmTeohjPCRF4sLHn
 OSbMHakE/xEge6jTfRxptr0W80MIvLf4GaF5MW5y10JpX/AHOmPX0SNsv
 qipq2NXYe7TLUXX5UhLlH4cb77gCxDVk193fARYJuB0fNw9bkolAZBPHN
 lv/d4sohz8lf2LzCgQG/nemlyO61Pqn0ciay3WtEMDM2/XnJFi0mi2Uoy A==;
X-CSE-ConnectionGUID: qcBhxiaCT52EZfTvRQmIMw==
X-CSE-MsgGUID: bC1OrVeaQ7Sg4VV/cxnGNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="272688"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="272688"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 10:35:36 -0700
X-CSE-ConnectionGUID: 7jV9xy+yTSmBhB/54DvZWQ==
X-CSE-MsgGUID: 6vVvML3PQEyMzH+uWJ5XiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="187558"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 10:35:37 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 10:35:36 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 10:35:36 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.36)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 10:35:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VsT6RFvQl6cQ/fx5imQO8FVv4VvjYGUDewNIgLXrTxulIcodfBMwB40lMfuNrQsuXLV2EOljjUoiwgnnaO2Wljveq+fO+i8XDWRzAyCKz/ztoLA3YfTDSnQkq5KXxtCwaRH2g+tAtdgHPcXDK9Ip0510h59KQwMNmmKpJM1UT8mecZfw696RQNc220bYnQCIlikUxpYQRhR6MxVcR/1yhODm4GrcEgzAp+np5MOCftm5inogLGeDIj+GoJP0pf3nXacK5DLV3BGaSsWOAVC4ZW9QZ1+vH+0yexfq9VOxWoFKeau5viK1Ylo8Wb6KzOw/BdqoewUmgMlUNKqdhb8YNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggVdJjsQCzIYFsmFqrW7wx3fJCRHgzhE99K2sQjN+HE=;
 b=SQpUPCiTfPLB6vSMLeukKTDlrQ+aBh5tEmWrn/5Snbi3jd0C3YC94FK+ZSVsI+K7JJ/kecMC+4B3yI+3NKvChDJZbxq+6Km1YGnuJicun0g/lSfBiIks8B6fsGI4ws2ufY5rPhSNlbLtQ+p4RHkXgehCs0Ts1vIn8XPdh/+7XZqSuVqNIXS5Z+5GeRcG0kGhXm10llF/NKUeFLLnxh0CD8ZGwK+lpQ7Szi1brlmLHPSM4G+QPL40jgnTv+XMHkt5IHoGjOKRpvhjEzReGZeSsRRm4SkkQ/wPQ/6G80KK2f237exqmytrSByOoNJBsAYrA4FyqGOx5gr8AsxXV83rYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by BL3PR11MB6387.namprd11.prod.outlook.com (2603:10b6:208:3b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 17:35:27 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%6]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 17:35:27 +0000
Message-ID: <ccb5c33d-8898-48a0-ae2e-16a2481828f6@intel.com>
Date: Thu, 8 Oct 2026 10:35:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2] ixgbe: remove ixgbe_ping_all_vfs() from link
 state change handlers
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 <intel-wired-lan@lists.osuosl.org>
CC: Simon Horman <horms@kernel.org>
References: <20260918133327.4170034-1-aleksandr.loktionov@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260918133327.4170034-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0202.namprd04.prod.outlook.com
 (2603:10b6:303:86::27) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|BL3PR11MB6387:EE_
X-MS-Office365-Filtering-Correlation-Id: dadc8fd5-6782-4115-db9a-08df25628a86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|6133799003|22082099003|3023799007|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: s47sQEUQ39qeBA2Pim98gLlxZ//sSEGpsKTZkYONliRlCMPrIQKSSMhnzRVNCyj5D8KAqPlKyH8zSTN+izU8K5ZZnulca82etOjYKUo35oWo2Mhs0ubaZ2CILG2bZcAuIl33ZzLrFuKmG9yL/r3B3iIlKoHMVi1bsOlpDC2jND++t+/VFOilq+SI3RYvuQrK8ueZ9uZcFanah7vRyfMmQx5Qd9RisHZGQ5EZSINobS4Cz3cK0Fu1OXEx5wTnwIH44VnKmKA/P07ocvE0Om8UXC4+TyZ5dqXxl1hmj7DLgAkLAPjgvJOuG++TKJLTRSu44Nd6v5XsVFmOqhOKNhkj7+VZ0z7WJMzqVRIH0B3J96lrIJyc1wF47I5MpbyR0hYdctzW3kNKTnG6oyWWUAiatCpZylDBPL5CJ06bvwYykPgfDREXuIHX/midoydJWS9e+lZZYPzMmGytBuTCLdrobNSAldbHihpgjPVZrVDnsPDL+LnEts+hO6GdcJwWrXpLfkBGpSYkGLrOqTl1VcwjkT2Ee0hed6pmDgqmo6iCOPPRAKUQTJ0FhZR+mc1QMccBGTDYDjVEuqAF/xfEcR4xVQHqzRZJELrj9XmZrjRrMI8Oowo3D8UmMclt/qzlHKzpFBcPtJNlI4KBsXyXkBm7GLorSHBuWu8cMof5EWiUw+Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8230.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(22082099003)(3023799007)(18002099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFhNa3F3cDM1YzFoU3h5NkJnZXhBTW02TGcvMjdtSHBOeTZ4ZGJ0ZUFIR1Rh?=
 =?utf-8?B?T21xMHdVa093MlMrc2pYaFhMUEdMZ25BV2JicjFxTWtORWJ2cm83WWZTWEJu?=
 =?utf-8?B?MVBsamNoYm1YWEFLakJaSloyUVNzYjlGcnkrakhsSHM5dmpKSktobVRTS3BL?=
 =?utf-8?B?UFRQVHN5VzZkYVNJZ05PS1l4SFdVaGxlUjVxa24zdS9oTktKeEZudUpCVkNY?=
 =?utf-8?B?YnBiYWpGS2doeU5McnVjVndlVm80dFFhYWRqUVNMV0svcUllZkZsMGVTTmtP?=
 =?utf-8?B?MnlUNXRyQVNXdmxVUjhmYlQ0clE4bUUrUmtZWWRYalRFREw4dlZqNk5qTEpv?=
 =?utf-8?B?WWxoU1V4T2oyTGRic2VlZStFZWNqS29Ma0MzOHVLY0MyMDFXdjZkQUFUOWpJ?=
 =?utf-8?B?WS9LelB3alIydjU4Rng2L2ZoRTd0ZEROTUNLSjhmWGVWeWpOekZYQVArRjdO?=
 =?utf-8?B?SnFUdnJ1dURlbEQrTUc3UUFScEVtYVlWWkduSUtKQkVrM0o2d0ErR2c3UVcv?=
 =?utf-8?B?VFAxOHd0M2NEdGpVeHR0KzY4QnJ2K0xnN2gvcTRtc3Arbmg2WXh4QTVQeDFx?=
 =?utf-8?B?OG9zSlhPVUZMZlUzd1IwQlhzc0ZWdXVQVVZYN2RVUm42V0s3Nk5tV1ozWVFI?=
 =?utf-8?B?RDZKM0Z5d0JBdGNFcXpLV2x1VWV5TUZMUUN4YS81YXcvMFUvU3ZsMTBha0lq?=
 =?utf-8?B?K3NGVXJnME4wR1NQazQ3U2dIdkZaWE9oc0xRdjcxYk1va2JXTmVPMTNuUTh0?=
 =?utf-8?B?ckp1dENDVDN5Qm5sK1JKd2FzZkJyZVVLZXNNY28zVzYvdktXYmN5bmQrWkpC?=
 =?utf-8?B?ZlNlKzhscSs1cXhnd3k3c3kzWW9kMzBxUU5CdW0zdEZZekR5bXhOdzZBZ0xQ?=
 =?utf-8?B?T0cwNFBoblhLdGRZU1B2bUptK1ZIM29tWDVNcTk0R0M2ZHIvSkMzMWROaTdj?=
 =?utf-8?B?dDFYbXlROGdPRDFXTTVJdEw0anhPNXNkMUVKcG54U2tkOG9DbVNKcmwvUmZU?=
 =?utf-8?B?eTR4bDdOcCtQOFBWcHlEUUxJd2tobjljdk93NFczbUtUeWlyUDU0S2ZHMWc0?=
 =?utf-8?B?dUVpb3lJNW55WW5sU1ZzQmp4NW5mK3haU2ltN2JCcFB5dW90ZGlQcDVRR3l0?=
 =?utf-8?B?eFVWRjZuOStLZ1ZBWnd0U3M0dHkzVy9XZjR2U3RXTlFaYytLNHVxbWNLZW9R?=
 =?utf-8?B?UGYzS3lJVWllYTh4VUorVEZHcVAwN3NVZENLclk1V1BaamVBVUVqMlFJcDRn?=
 =?utf-8?B?ZnhMaFVJTUNzNS9uOEEyUmdOdGVRclpvZjVlRHEwT2JwQ2V6N05mNkNpWnlh?=
 =?utf-8?B?M0czYk02K3JEdFN5WFpCNHh1R0VDcGtwTHBGWXk5Mnh4ZXlXT1NhcytQSHdN?=
 =?utf-8?B?TUVORWFzWHRWZDJ5VmlOQnNaRVFDdEsvRld2OUpXbElFR2JDK2RiSXBCWFRx?=
 =?utf-8?B?Vi9yY0NJUGdtU1hoclk4TWQ5cFU2SGtqQ2p1MEZ0T0hCTjVxcWc3UGVLWllr?=
 =?utf-8?B?cDU5ajVtYlQ3dGxKUnM2TmZXaU1qZEFsejZQbXk3WDU4UTMxU3k5aEZ1eUs0?=
 =?utf-8?B?cy9RNmRyd3pRdmtvRG1LQzIvQkhlenJpM1ppdkt6WFkyTTlYeDI5ZWptRmFv?=
 =?utf-8?B?cE9uTUJRVUUrSk9oZDRQbDNPSGMyMXNjNi9BZGRHT0lUSWJGQ2FaR0t0MFNS?=
 =?utf-8?B?VXpXbE9nUU4xUTRvQThhU2ZuenhadFZrRTFDTm5TSHM0ODFhT0w1K0YzYUYr?=
 =?utf-8?B?YTFBcFFiYlVleFNKM0ZOYTY5OHVEdlh1dFhTdGM3SThURzQvR1B6RlVvMnQx?=
 =?utf-8?B?cGZ3bG5PV0JXV0IwRiszYUpJb1NFcUFsY2xQOVBUSWZoVHZXbmVpbWJBQkx0?=
 =?utf-8?B?K3g2bXd2MmNPYllsSjNPZkVCdzBTeHFGN01IblZsWWhMK3JSNlhKakhvaUMv?=
 =?utf-8?B?b1k5SmNTU2FlT1NRUnVES3ViczZoT25SM2w4UHNtL3hEdEh6MjZadktWekNt?=
 =?utf-8?B?ZkV3Yys4WkRKWFVhZHBNVFhkbXdIVDJWVE01VTRZSnVHU3pFNEJZb211dTlM?=
 =?utf-8?B?WUxoODFkbFlzalZTQWpTbU1aZ01mTXAvZDQrczVic2VjZ3ZFTnlhVUdxcGZ5?=
 =?utf-8?B?SlF2bkVWMWhNU2lUK08xclNTWW9xMzZPTzdCUWJ1eWl2WWZjU3lWalNqMG9q?=
 =?utf-8?B?N2VMUTFoOUwxQWNTQ1AzUlZmVWlkL1IrS3l2d2QrNk9iQ1ZlRm14bWJTVjN0?=
 =?utf-8?B?Q0NZNE1OajZIb1h1RC9ibkc3QnBvUUNhTVNwaklLZ3FKMFhnRFdBUDVhWkRO?=
 =?utf-8?B?b1RoTHQ2UUZCR2lGeXZTenB2Yy9zUUFQVTVIRXJFd3NQdnF4VnY0cFlEb2JS?=
 =?utf-8?Q?B8n1tUt/fbdWfV58=3D?=
X-Exchange-RoutingPolicyChecked: o07XD5Vtdu+4SYfKjyQe1gd1NyUF+hqc75C9EmJcKiYYgVVXAuwmV/b7WhKpY2QuVYyP9mrpVkatbXSdSW+vWF3lqLu74CeM2CYpjISE+GbqR0lkSk5vRNoyZ4bvogGiBHs49ZCSJxY1ntA/aehTjtUjDEB+/4R2FkN150HB7HsS7tvTV0ZAmKGBCcqJvjCxWXbxQ6HlpKK/S1UlyHRRoIaAqexgZjT7akUJBVZEAIVkzaJJD+5K/3OmiSHhoMvOy9wIcDyfYO7KA32/KPCKp2Ng0TEYjhfsWNiOBdFRG3bO9NOgiTrzCIqxeUj8j9DOpgo/s+KIcJrmlzSlzkMBnQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: dadc8fd5-6782-4115-db9a-08df25628a86
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 17:35:27.2922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Sx0Y4ZIsv0vYsUteCu7ahPN/2LKNA00LtTY+IW1zFilHgR8A9NlTWz7dTavQvskc/ziCMIoyiWsSIQS7IWUbetGfhMSZoBUL/RKLpPFczQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6387
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



On 9/18/2026 6:33 AM, Aleksandr Loktionov wrote:
> When multiple VFs are brought up simultaneously, a VF can receive a CTS
> (Clear To Send) mailbox message instead of the expected RESET | (N)ACK
> response, because the watchdog fires a gratuitous ping right as the VF
> mailbox transaction is in progress.
> 
> Remove the ixgbe_ping_all_vfs() call from both ixgbe_watchdog_link_is_up()
> and ixgbe_watchdog_link_is_down().  Both paths contain an identical call
> with the same race window during VF initialization: link-state changes
> (up or down) can arrive while VFs are mid-initialization, and the
> gratuitous ping from either direction collides with the VF mailbox state
> machine for the same reason.
> 
> Link-state changes are already communicated to VFs through the normal
> mailbox protocol; these extra pings are redundant on both paths.
> 
> This removes the last two callers of ixgbe_ping_all_vfs(), so remove
> the now-unused function and its declaration as well.
> 
> Suggested-by: Sebastian Basierski <sebastianx.basierski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> v1 -> v2: no code changes, resending to pick up Reviewed-by
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  6 ------
>   drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 14 --------------
>   drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h |  1 -
>   3 files changed, 21 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index f918564..365acf8 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -8181,9 +8181,6 @@ static void ixgbe_watchdog_link_is_up(struct ixgbe_adapter *adapter)
>   
>   	/* update the default user priority for VFs */
>   	ixgbe_update_default_up(adapter);
> -
> -	/* ping all the active vfs to let them know link has changed */
> -	ixgbe_ping_all_vfs(adapter);

 From Sashiko:

Does removing this PF-to-VF mailbox write prevent the PF from sending 
the CTS message required for the VF to transition its internal link 
state from down to up?

The ixgbevf driver appears to rely on this CTS message to correctly 
clear mac->get_link_status and transition to up:

drivers/net/ethernet/intel/ixgbevf/vf.c:ixgbevf_check_mac_link_vf() {
     ...
     if (!(in_msg & IXGBE_VT_MSGTYPE_CTS)) {
         /* msg is not CTS and is NACK we must have lost CTS status */
         if (in_msg & IXGBE_VT_MSGTYPE_FAILURE)
             ret_val = -1;
         goto out;
     }
     ...
     mac->get_link_status = false;
out:
     *link_up = !mac->get_link_status;
}

Without this ping, will the VF persistently fail the mailbox read and 
force the link state down?

>   }
>   
>   /**
> @@ -8214,9 +8211,6 @@ static void ixgbe_watchdog_link_is_down(struct ixgbe_adapter *adapter)
>   
>   	e_info(drv, "NIC Link is Down\n");
>   	netif_carrier_off(netdev);
> -
> -	/* ping all the active vfs to let them know link has changed */
> -	ixgbe_ping_all_vfs(adapter);

Does removing this ping sever the mechanism that triggers the VF's 
mailbox interrupt on physical link drops?

It looks like the ixgbevf driver uses mac->get_link_status to determine 
if it should poll the physical link. Once up, it sets this to false and 
relies on a mailbox interrupt (ixgbevf_msix_other()) to set it back to 1 
on state changes.

Will SR-IOV VFs remain stuck in the up state and permanently report
incorrect link states if they are not notified of link drops via this
mailbox write?

>   }
>   
>   static bool ixgbe_ring_tx_pending(struct ixgbe_adapter *adapter)
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> index 431d77d..da641e9 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> @@ -1515,20 +1515,6 @@ static inline void ixgbe_ping_vf(struct ixgbe_adapter *adapter, int vf)
>   	ixgbe_write_mbx(hw, &ping, 1, vf);
>   }
>   
> -void ixgbe_ping_all_vfs(struct ixgbe_adapter *adapter)
> -{
> -	struct ixgbe_hw *hw = &adapter->hw;
> -	u32 ping;
> -	int i;
> -
> -	for (i = 0 ; i < adapter->num_vfs; i++) {
> -		ping = IXGBE_PF_CONTROL_MSG;
> -		if (adapter->vfinfo[i].clear_to_send)
> -			ping |= IXGBE_VT_MSGTYPE_CTS;
> -		ixgbe_write_mbx(hw, &ping, 1, i);
> -	}
> -}

Is this function actually essential for notifying VFs of asynchronous 
link state changes?

Since VFs do not have access to physical PHY interrupts, it seems they 
might depend on this PF-initiated ping to learn about state transitions.

>   /**
>    * ixgbe_set_all_vfs - update vfs queues
>    * @adapter: Pointer to adapter struct
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h
> index bc4cab9..f755bfd 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h
> @@ -18,7 +18,6 @@ void ixgbe_restore_vf_multicasts(struct ixgbe_adapter *adapter);
>   bool ixgbe_check_mdd_event(struct ixgbe_adapter *adapter);
>   void ixgbe_msg_task(struct ixgbe_adapter *adapter);
>   int ixgbe_vf_configuration(struct pci_dev *pdev, unsigned int event_mask);
> -void ixgbe_ping_all_vfs(struct ixgbe_adapter *adapter);
>   void ixgbe_set_all_vfs(struct ixgbe_adapter *adapter);
>   int ixgbe_ndo_set_vf_mac(struct net_device *netdev, int queue, u8 *mac);
>   int ixgbe_ndo_set_vf_vlan(struct net_device *netdev, int queue, u16 vlan,

