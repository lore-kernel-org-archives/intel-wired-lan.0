Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE4CC982ED
	for <intel-wired-lan@archiver.kernel.org>; Mon, 21 Sep 2026 15:36:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D292940782;
	Mon, 21 Sep 2026 15:36:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OcCqe4He52bo; Mon, 21 Sep 2026 15:36:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 30E6D4078C
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790004997;
	b=deZBA+ogOGrS8BdRzGeJ69fhMMbqjAAOa9KvHU0Xy8EtRj4oQPbhiRQNTw+fpn9Op/vi
	 HonMrxPGuwubaf7ZiETCXSW7mEiAgbtYsXgZU4CEq52MPxQhzOureSxpD6n1eEB/Sk+uk
	 ydH3qQZxqXP01d8n5hma81fAjHwNAZVzbarFUiTXGf3r1OkS6Dose6v5sFOFDJUstdqOO
	 VjLQYZ02plhJ2Xbmh2OMJg4th1x5Dxp44m/ScclNO1NgFdmOCbyV2IbL8i+7SNpdh6NB+
	 zpW2oK6/bfscIjNQejUz0Cx9bZoDpP719/+rpKg45Ufg5QjAe70oRy4+E0zOZaJQiHg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790004997;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Hcl6T7YCsKXFYeiQxieVESuYjVo12U3EkNNVUK3HhEQ=;
	b=b5dKqBABMIflieQtkbrta3D5ZkZj4vbWdqu3Vpts4JZluyBEy2D/OsGa+Cqy0H8Z5NpC
	 /nt7KASJbyrQqoV1rOCQmJifOWy1/79SoY23xorMbly6fYOnKhU0+VowdyQwl8o17oKF7
	 RaMm27DBPwbIlFcIpZfxSc8AzuN8T4EV4zXwC+4F2bNY8XKSxY71q5YT5XpRT19U3Hbqc
	 oJm020DEQrx6K7nBnveszIlAaKd0W29l73ULkzE/FFM1ZGOrfBeim6VeHx95CdxfAn1Ab
	 nR7ILoYn+UKkKrF4bvYB8oT7uMDC7c8OUZfTJiwNNLQwFGH/NKEDZA6sx8T8kULaWLA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790004997;
	bh=Hcl6T7YCsKXFYeiQxieVESuYjVo12U3EkNNVUK3HhEQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wHQfB/lr9zHcIFdJ/F0iyQEnkVV6p3jjX0BDajvsZd4QJLmqtnONUrVb91ZVP0Ej/
	 C29/scO0Zyuw42GMJ7L0LcQhT7hbkHUkHUIu6p9n8hnwqaIOgXC4uMESrR5487DwAy
	 H2K0kYEQbOqmpWCaQCcoxAtzSmxrUZ7ofPLG0Ma89n8fk8rigwfU4nstexhUXWU0as
	 kXN2lPbCTGFRJAJm8c0Y6oOHEySIhmsQ+WQ/9G1hye909nk8WrSF9J9/1r3xAa4HU3
	 ytijLxliGBdxfGXwEkulEI0B2+symGX6TGEa3+VG/f9WKJXsemXsEB7HecKnjxZQoz
	 XO7gxkNcBuvxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30E6D4078C;
	Mon, 21 Sep 2026 15:36:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6CAC312C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 15:36:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 52CE4401B9
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 15:36:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IvXQVa6EPPLd for <intel-wired-lan@lists.osuosl.org>;
 Mon, 21 Sep 2026 15:36:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 583F6401B1
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.9
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790004994;
 b=FeScqAVrsnTEx/LxFQT/a5f8rW4YHAmO+9tXTiIiRl96A5TKr1RQZYd0nkwYd6SEXRO6
 hhVHhtKbjlEuZCdj/kQPhD4SUEUPLk21SU6U4Nmw0RqGDRnYblPVVb3j/fYIvuYToyYeR
 R4uBYo4tQnfYsvGv5pscCZA1imkjadIWfFN0MEofyDT2QqzanRJUYf4aJ63J3wB7X9sNh
 z1HWiu/xCLrTx4XbV47Mvgj/8fL3HL98OKdoVXOJ7RCnucauh/pEOejvzuIywJ1XlqCxF
 zcDE1bjGd9Em6SSOy/psXdIwvYsB34hCpxbV5TwNdG8n5J21lkWYfXwTYNzbhAkLs4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790004994;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
 x-ms-exchange-antispam-relay:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata-chunkcount:
 x-ms-exchange-antispam-messagedata-0:Content-Type:
 Content-Transfer-Encoding:MIME-Version:
 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=Hcl6T7YCsKXFYeiQxieVESuYjVo12U3EkNNVUK3HhEQ=;
 b=RyLjqo2MFC9s/eAWrkr42tfeop41jXS3uTAFQu19IcFH5V9FgKFLTU5wr77+HxNju6Jw
 h0a7pA7wYKY5jFsIIh1Wj2ln5h+MoeLUFydlZzbqtW7AXvXvmLi+8MzXsFEKZekzqSAww
 LYDrzs3Ipbw4QpdFmHDrj1h88kN0j6iI0qrPp9v30XmUTjiHdyePJMAV7MQBY55a+IUqd
 DcZ8kAPGOWTJTpgtC1Lpra08aUJPmK+XFSqJM/2OsbeKJW9+3cqRPDVnAi+GO5y307Nsb
 u3rYnR3kGZY5WEt5KFnjlIo6yjIAcRNAocpj9f3C6UJ3pc1+vx67iWxRZD6lV1uGSxA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=fDZz2Ttd; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=fDZz2Ttd
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 583F6401B1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 15:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790004994; x=1821540994;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wmqMU5AXAhKdDHtzwrVR6zlJ7owMxAbiazWlMfC6dK8=;
 b=fDZz2TtdvrsxRchnwXf1SVCUNyXZYPeLSzFVgaTG7dOiS5CFZMCwQqO0
 KPF8oRO6FCIBvA9yLzPbb7/8DcoI9Ym5FQqYwy7LHlyKENSA6RTe2UeEZ
 frWH5VZHRpeD3+/M4azZGXrjSMN2MYqWvE4vB+bmmMXwyb0sNYGL1kiaT
 NYRD5R2cErT1aqJZwGnfMTcebyP+mEeo7+fgfFd+xGQ/EwghFiAMnA7lM
 XKtxS9tSkVwmPLkzPbnX76tdYCT2VsehcP0jy9bO9u6xBL0Pk0ppbc68C
 8/TEtIbhXwVvONu9tG6PMeCkSyUxkNtbQDABJ8il6s2xS0/+DFe70AE0d A==;
X-CSE-ConnectionGUID: N4MwOXSqRZSeAZcvs6vGmg==
X-CSE-MsgGUID: bLdj99EfSuO8DlT4K1Ak3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101191630"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; d="scan'208";a="101191630"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 08:30:06 -0700
X-CSE-ConnectionGUID: 8MWeUybBQqOQTMFxXGQ6Og==
X-CSE-MsgGUID: arMqoaZkQ7ixucH8psLxxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; d="scan'208";a="280756206"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 08:30:04 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 08:30:04 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 21 Sep 2026 08:30:04 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.51) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 08:30:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3r4MgPpEolPOfCpJLD09kNq99ABFLedUEh3Qo48Uf7oZr4AaNK3mJFYPCD3yWciC93YJ+X5vFhq0NydTuFlIvEJ2J0FmmIO8xM0kYa2UJl1NnlSbwFq7JlVB07kKLBaZI842NYyq5xRq6YM6UuCD3jwZLdj5li9dC95731/VOXHQnjKMcSTUjFEtSO05J4bCKOAHzYsR15ut7px8rUvSPq2WXZm/YaRA5RgvsATDiDbjazBywp6icG1YTEHJhJcSc/E0phjxN0pjbzJsPNC0RGvyQPlU1q/4bJaTAJNuVcNVMFZ89qCQjCjv3QVbBCaVKeLN3RBkFWEEq3/RMKC6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hcl6T7YCsKXFYeiQxieVESuYjVo12U3EkNNVUK3HhEQ=;
 b=qW8dK6ho3Ow+WeFYL7bQoYO5eN/MvCZ42pQVIaxcMfPZoyeB9maXwnbp3jZxiuHsFGxdhZw5ELOgSYW6PfQ3XOVZt84EQb2Hj7nSWA/xRH/2CsojGZyIOShHXkAiOwKyv6cxulx/AxX+CxS+xy35m8m8yxsoKmcn6ACCL2KEy0CuFtuqpfzM2xnPUilx7jRw+Jc0PDpaKpxtcAPC2S9aLuYPiUZXoWivpgEWtnUNu/Df30JKui6y3VmpD2MSmmHYaGMsC2GK8E4KH8XthAzunyKKncf4vLjzCnhQMFi4/SeDGUDqlBZ7F95N2z4QGROij3vgNhNbvsjhGqahlFd16w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SN7PR11MB8110.namprd11.prod.outlook.com (2603:10b6:806:2e1::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 15:30:00 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 15:29:59 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "kuba@kernel.org" <kuba@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "sln@onemain.com"
 <sln@onemain.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] ixgbe: fix xfrm_state reference leak in ixgbe_ipsec_rx()
Thread-Topic: [PATCH] ixgbe: fix xfrm_state reference leak in ixgbe_ipsec_rx()
Thread-Index: AQHdRpWmRRqu97uWN0yEh5Dys68ZjrbZLuBw
Date: Mon, 21 Sep 2026 15:29:59 +0000
Message-ID: <IA3PR11MB898671C5DC9B8F4DE23EA844E5842@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260917111317.2148568-1-vulab@iscas.ac.cn>
In-Reply-To: <20260917111317.2148568-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SN7PR11MB8110:EE_
x-ms-office365-filtering-correlation-id: 33ba884b-a285-40d9-c1f9-08df17f532ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|38070700021|10067099003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: 418HasSZo3f3CxVc+u9xpI6lrRtIMxl5oDLt2HAzzGJl2WyEypgWR6uYrktw8MWIskiHNVcZQzYLSKRWtM3hOpOfH+kArcziYhX1M3HW59mIc0CBVQPQqW/6CUv6q+YTvUvHULT3JzaUMvESd090FVktyvNOFiJ7bLynShqHcQRR4i/fC39vPn3KU7ZlvSjuHIiQm7Fa8GeV8zQ3xR2RQX1lfXwjIcHc7ARbZUuUS7DJ7+B6/jRI8TjX/iPGiQoPY79SRK6Q72pVZrJdSgZw/TmjeX1mHaKoW/vLwi4JeF/RsLOm6QPQ+u4Qk+g8dZb6KDndSRXPSgbai46x6ZWJ6qOxtcbEIx/z9tVQZQgEVTL0pHNhjR/cLe4LabVO/CBaFRXxzqLR9UE5537HLZ0BVga92U13Ixn1anzoTqQFtORojWTgRSu81woa7QY12xoQqYlseGQVCAlz2Y1AQCBqo0kDEd/xgwe06SLfVaoMbGTHSHg3ouWZIUzZ1u6WBuhE538ruEEMfmu8Eob5xCTMIiKk9Mt4N3xNoADCZO+rjoeUIqm47SS/H3nGvV5J1AbvqgpgW6wOiGlLfs2+OSg/PVB/vixB/TSAN4FA41UzZY8HA8NAQ9KQYREUyeN3L1xf95BgOcxshEoW+9+vJ9ozhVXwovhg5JMVSpaptTEt6MhctWswqfM4P9epTW9GVGW60/bVAB/2n2Czzi6jt9rtSy5vfAU0wzC9wZ+x8ExM1Jc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(38070700021)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BNK1QG9qI7JzEbT/M53K+Aje5COmBrBOxxqE3myNDTiWXEPvrkE/5H31Nam0?=
 =?us-ascii?Q?yO498efp05Fpuw41W85hBlmlh4gSgc109nlP9FCz3OgEYJJ4b1Wva9R1E2vv?=
 =?us-ascii?Q?68vlTj9lpBsj7mxswNnYPGNZKSkoUvS6bCv70LurFJ1QRLlFhX3H8Nvin+e2?=
 =?us-ascii?Q?ySsZBMcxQZWNQVT8YbRWlor18u3DSsDZ+/y2mu5nGUmxKO1QYBLaAfat0frJ?=
 =?us-ascii?Q?GhttAoPVkIhxF0HstNE3/ymWrkUO1jLGEugHMRQHEFIJxpLOWCKPGbtmCTbQ?=
 =?us-ascii?Q?84axqQ9XU58EQd/VQtv91T9rk62z/mhxxxduiINF1kNZgQwdogOfpnQNkVcz?=
 =?us-ascii?Q?JLJTh3erjPbPl2UtEPTksbOV1jOEOq3/TwNVJKT8FlRbIUpe9JBqprJgKGQC?=
 =?us-ascii?Q?c/yL4sIP7kK+bcCwUbTfxN6XRTAyFaHHqViP6sjdBmUnxttLDTE15emZEaks?=
 =?us-ascii?Q?V0HetXGBtKjQjW+EMBxQy8kOC4xncLAarJP+spqC2H8waz+wjbJDsRCDcxdB?=
 =?us-ascii?Q?pxpGbIRboyEQGIq23ERwTXk6XUjskSsCaXtV7IizOyo9mNuAPAnSqX0Gteon?=
 =?us-ascii?Q?WJAPe8epSorGfdWzFIMXJECxMbxQXmHIwNhsHTG3I1qaMrxwXbuxpp21+gfZ?=
 =?us-ascii?Q?qER855qsn4Fsa/62TJYbY2cjsXeyoFiir+FVflKcMJrB7JX5wId8uI6PYLbE?=
 =?us-ascii?Q?u6GXLs/x6nzcazjTUL+CvL+8iUpKDG/5K6sLwGqC7giLshh0eUNcmZ/3Ly67?=
 =?us-ascii?Q?CCUAUoPHWzRrJSSqoR6b7Qm48refKUgC3xpWfB95skh1q7i7Og4inEDdcKrS?=
 =?us-ascii?Q?Uz6xxeMpGFSL9tPPIdbHUzul7m/X2gxpEW6N08B2r6EPdwya3HO9HafRE0Ub?=
 =?us-ascii?Q?zOGOmeSLa8d3gn3NzDkpo90RW4fWanm/irL4bk4x6LS8nSGKwyg0NVVh67+A?=
 =?us-ascii?Q?QSpiQEAD0fUmCB8DYVYimenB+opGo0rI3uXGnfLBkWjFlT8S237uyKKjSXBu?=
 =?us-ascii?Q?mD4wUTGPNxWYX1Tj6y0ZkQ6S9e/jUPqY1v+Y3GV+z1s96Cp+xtPlGLmHV7iJ?=
 =?us-ascii?Q?8eI1zeXTlEO2NdV5bU2FuxsOv3bMLe+W08HRey/fZgJEr6a0LCLQXgF22IcN?=
 =?us-ascii?Q?1r7Z46JGfjXu57dm5koXf9Rwo7/khvlkwkbn0voXGNvMie/SR+Bb/Tnhzm4i?=
 =?us-ascii?Q?GNOu5+zc3nrZa6JvH1Oq0GL4ViqeM9ySXcde5yVOJFXMJXYBbdO5bdOdrDCw?=
 =?us-ascii?Q?3IK+EZTkR4X6DUaKajo2x42GDBKtqYyHAwnTac0i/FE4Ht3bBJNBkadmGJrB?=
 =?us-ascii?Q?DsA7ZT2qHN68Bh8mrJg8+MfRWSn33774C4m6a2KwTFpNrPHTjJgwwECKS303?=
 =?us-ascii?Q?keBZuVKyDesqSXoc2RVrCWS1bXk/9i41hYPhcVThQ4LYDjDLdd0DBKn78c3N?=
 =?us-ascii?Q?EfWxCNyqrxIfP0TyAr23wdTPC2ZGM7pXrnWxWQgzJnFkBS9aQFuY5OvHZGyZ?=
 =?us-ascii?Q?sAQ2juA4fK6GgHzmQCSH7qa2k+FuDDC4NDlK8CXfzu+RShg7Z31DVcK9Q/a9?=
 =?us-ascii?Q?aHKr5NWI5pbQHB3ctoIlgYVVBfFEYqXni6NHRK2xaREr27SIzuvSAYIAck4k?=
 =?us-ascii?Q?/fPx8aMJu2L36KfL/7fu8YdyYPWEwGTq38OMqUBz+GlNzmLVy5yEX72r85xW?=
 =?us-ascii?Q?GiRHorbP4WhIB7YJxyMNcpLazX+RWyVdt8u+VZUQ+kNmUQlf44Q20aFWfHlw?=
 =?us-ascii?Q?bWh6/Y+y8BnOhpoqIvguEZIOWm8G8vc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: emaK//1uIYMqdRucI8M4u12h7uQRmCIJC9unLSr/SoPPEOuKOvAccMUIkGgEbal5d+JZdF8FXT8yTPqJwq3DvNYuffX3W9MaXOGUmH+Y9VfyHrN9Ac62B43/0rynQxeiTtyNtks69pOCnZazRFKr0J0iniiUJZk7m+9btqZabhjY0LzP1RIU5m3WX2NP0H80ohnxfgVNmrHb2ajEAgw5VV9vFnzerA4vfzEeoYku9wUkIwcq2UlivZKfY2+36aBRMo7PP5JN6yr9QbfFyW4f+kYS1kSpBNlTOymBpTnHlYjtLyeqAQixOT70errCB3HOxiXfUofAovbEuLr+OgGG8Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ba884b-a285-40d9-c1f9-08df17f532ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 15:29:59.6678 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fIV6d9EshPE45WMbriPyPa0smOQ0IN8kxn5rI6N9MhyrUw3rz62CQC0sdHzkDbMGLN1zghbqcYWEFCmSrPYx1FWpDRUDZLjWYRJ6W+UIBrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8110
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



> -----Original Message-----
> From: Wentao Liang <vulab@iscas.ac.cn>
> Sent: Thursday, September 17, 2026 1:13 PM
> To: andrew+netdev@lunn.ch
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> davem@davemloft.net; edumazet@google.com; intel-wired-
> lan@lists.osuosl.org; kuba@kernel.org; linux-kernel@vger.kernel.org;
> netdev@vger.kernel.org; pabeni@redhat.com; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; sln@onemain.com; Wentao Liang
> <vulab@iscas.ac.cn>; stable@vger.kernel.org
> Subject: [PATCH] ixgbe: fix xfrm_state reference leak in
> ixgbe_ipsec_rx()
>=20
> ixgbe_ipsec_find_rx_state() returns the state with an extra reference,
> which is handed over to the secpath on the success path. When
> secpath_set() fails, the state has not been stored anywhere yet and
> the reference is dropped on the floor.
>=20
> Release it before returning.
>=20
> Fixes: 92103199f10a3 ("ixgbe: process the Rx ipsec offload")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> index bd397b3d7dea..e44d5eed9ab5 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> @@ -1197,8 +1197,10 @@ void ixgbe_ipsec_rx(struct ixgbe_ring *rx_ring,
>  		return;
>=20
>  	sp =3D secpath_set(skb);
> -	if (unlikely(!sp))
> +	if (unlikely(!sp)) {
> +		xfrm_state_put(xs);
>  		return;
> +	}
>=20
>  	sp->xvec[sp->len++] =3D xs;
>  	sp->olen++;
> --
> 2.34.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
