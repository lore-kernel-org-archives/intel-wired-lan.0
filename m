Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2711C982D1
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Sep 2026 13:27:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 535F760629;
	Thu, 17 Sep 2026 13:27:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yOEqxbtzO92V; Thu, 17 Sep 2026 13:27:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5EEE46062C
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789651651;
	b=FeYLabUcNZz6PR+ZARRMfkM4aI+IV8drtdo9tgh4IxdeMVLSIm+jW2K5qE6GfwzUpOL0
	 au0fnQocT7ZIH44pMS6jrKOBCznU+oda//YDXObtblib4kbAbZ1tslCxGK6D5N10Uic/m
	 d0qE9FQPl22tkBXrZ4/z3lsqAroZBH7biZP2hD0cS2NLbxjg87HaI9fXfsPXiXkBGT7Ai
	 uUQj+I2AQBFpmN2+eniA1PFCqbRQ3o6u65nYJuMlKepmFyQPE4jES00Kir7ZIwpCYx9IT
	 QB46X4ZzYtAkUykpaC5uihbupajIG1+XekBDN8q7eJLZhO7WfiopJmw1GHcwcF/SWoQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789651651;
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
	bh=dVPjsNfOM+hpdtOWkvFH/bD0pNQBgYpSPTYzNSetVmw=;
	b=jWmdVTJYbePQfTG6oYbuKIOsduA3NUrsCawihI8fzflNUq0lLmj4OmB1DJDNLKL/fqlg
	 iFS16qaJXGP/Io7CEUfxLfktG6Y1uEt/zIoIz2xGSEXR6RldVr6l/QeQPPdzkKOQ9K69A
	 4bJIEePw85+pMwJxyXkpfmNJj1/em4HBEzcvSUWXBefoAWaW/CGFPuHfkWyk+s/aEap1I
	 sEhEDoOud3R+CXIPfhOgi/iq6/uf6/CRjQmeTShHxQVTNKVDxRv6hlrG/nnfL9h6iF4hf
	 O/2BBCTwZMeGI30Djj/YLFvGptHQlV1I7SWo/SkCXWuJL+U34q0vXnbNZb8F/t4jZMA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789651651;
	bh=dVPjsNfOM+hpdtOWkvFH/bD0pNQBgYpSPTYzNSetVmw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dH2dWYHegziMTL95T5vKGfPXpZIgXeS6rq2pMFpNCe9uZiYkt2FkMAOolHWxEU0pW
	 UPTxWInc2LQ29TAhS6AUC0ZgfY+HG0u0jHoJdj5mg5lAxqwW9VcyiKnZGq7sV+S/BT
	 eaHehNFtvxojAhW9lichY/igIPPtcyyDE43Mnn6KGaPOcdjz2Y7SxionXQ05WJep28
	 JWvyiiBZBjBNsXR6VDFPPGdA8DqvppYy2ERB/QzSaaVY0F2luBxx3mWFYF3u59uPls
	 kLEpfYCesbCoWOEOjI/uKsiRe2Ec/zV9BdADGO2IDgcJJMUjfRcfcCFj8sSQceZMzj
	 AhujMihKbb7og==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5EEE46062C;
	Thu, 17 Sep 2026 13:27:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A8DFD29B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 13:27:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9A2EA8084C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 13:27:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vP3zv0eOEsPY for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Sep 2026 13:27:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3E7FE8083F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.12
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789651646;
 b=rT+GsrSNRIZVr1+eeYX46gd+zvl4utDX4bp/k9Ti6qsMIiswL/VJcA24+m1MfiVPIpD2
 XXtTqSxMOY1oglOL2p7CT3O8he+J8I06YXlrSYlTK+70dpJi3ZQxYqeufHrN5hiqL4w88
 eUENwkfAOluJJWCthEUZkSqbhC2sQalQqrZAvTOmz73xoQGcZnvdJCOCyPbEQnKov3qw/
 p7G7he1m+rFl6ztHW/338y2Bvkv9oi7aFevOQxevQ5mNdASjg3NsdzAsGcwKN2TJWeO4U
 r/6aZdB3J0nq15js2Py6/XsNcbKQFMqn210v9qXR1cLh8O+YUy4ryMkcdAI6ARjVWuQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789651646;
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
 bh=dVPjsNfOM+hpdtOWkvFH/bD0pNQBgYpSPTYzNSetVmw=;
 b=JymKmszsdJH/s/J7ITc5UqKI0O03BdxMzTtrEwmkPAKweilOWENQKTPMJR/NI8M5BBbW
 aOvUuROptkgk0Xav5hHu/xTpv5SJUgS8MFsphzZW2nRORgk8QxME6JYLqZrqNo0cbmt2e
 /C991gI+xNYUKAYCOm3b/Y2Zpsp1uYvCSmWqvBFFDTEifbwFbDcmWoxAvrdarnVw+/oow
 +wgmfcz88YLYBs2L87TafXjqJkJfIbxu6Rza8zkPzU2mhbr3Zc2wKzzJ5GVoKr6LusUoK
 f6U1p5F6IcmGxmLoMtKCLRF2LjfGTpaaiIFQTCty/ChJLRIy2hnTOcrAjFxGk0RRp9g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=EKsQeywr; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=EKsQeywr
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3E7FE8083F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 13:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789651646; x=1821187646;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=EUDNDKgFDXU50lVt//Y8kyqkTt5paJ9g/X6D0BkUd+A=;
 b=EKsQeywrxGhzKjkuPIbw+CfLJ2Yr2eQU1mpjCL+1mrUj6sETIKG864i/
 7kQxPkUZJ+X1EsvKwPEw1rKZfo5Pdjb0+Zsp19ppmSIa4D9TOvxPztxJO
 ov1XaDJzjvnT6naT+Olbf8i2QwQtNhtEfGJTOVL4s6lmbjUMflZQHxRek
 z9OXUSeuayF61nWQ5E33qWChcDxwjcOhUifLbHcD9eaAvc+2X3lJxkFfG
 lnw/j3vzLIobI9kzN1mCesvnBPNsKmubiYfYaqN3QyQiMO0n18Z3M7Pdg
 ZbzVK/DVNBGbM0gUbmKCYCkWKHabdAs7pY3Sj6KRD6WoQsG2IVMFMozQ/ Q==;
X-CSE-ConnectionGUID: f49AaGqhSCirZCJXAF3ccA==
X-CSE-MsgGUID: RuCdNHNrTv+9GXzMcx67dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93902712"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="93902712"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 06:27:25 -0700
X-CSE-ConnectionGUID: 83BlImOFTry7/OQg/vTPQQ==
X-CSE-MsgGUID: Se2On78WSuKjjz1Ot2mB2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="270494405"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 06:27:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 06:27:24 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 06:27:24 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.19) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 06:27:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8p+AwKmOeD9Wbs2iN+efvs1yJY6Kpf9SLqP9/1iRdrkLZSxuIeKJi3jwmEhfV2TZ9oh1fyYIhUHNEmhfoKgfTLSKkPDW+je7nrN7/VaHN1UfRwHmmfw2uYi2raBfvrYrI47YHUdc6soqdgNV9o0cF/zTWwm1qQFgYTt6C7Ez2s7h9scUUf4YYvXHVTLTI3X2HDkLEHUJlQ6PnNi1/tZs4xH4rpuAG9YD7nmlkdMQUM0lrmQZ35t3X+zytLya/8/Z8G4SCkMzOLJi05/r8/WPYo/v1oKmTW1l8R28F6EOmrEphChh/b5wnGAlnB1/P5gf5QeJ/Dirvhf2D5Xmyd4xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVPjsNfOM+hpdtOWkvFH/bD0pNQBgYpSPTYzNSetVmw=;
 b=pHhm17kY4jJJxhl/QJPe3tBa4pxUFDVYQaGW4epjhrDmY3FawxDn+mlmMmQVENkZgc6NtTqfRHaLmyytsShKLrMWNctAoSC0qb9zVkqhW7PEx0sf/h0dehB5lZDxXpBYczj8IvToxofMmkeXD+3WiDZ/4Fx8BbE7yjEPRwwgyeYLzjzLcsNZJ3MxWTmHmHC8q9GM4rrxW2L14ERp6nq3EnrqHnp2ywz/wEmlBt8SjRegMYAqWwlb01eH/xHaSGw9VInT0s+m0669+xU5e5awOiLwPP5XVB8WvhDXuKTh/JtgOGraPr0rJ00iMOh7m5TQD6tzd9iFy2Q5mAd98Q/XrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY5PR11MB6533.namprd11.prod.outlook.com (2603:10b6:930:43::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Thu, 17 Sep
 2026 13:27:15 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 13:27:15 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Linkui Xiao <xiaolinkui@126.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linkui Xiao
 <xiaolinkui@kylinos.cn>
Subject: RE: [Intel-wired-lan] [PATCH net v2] ixgbe: fix incomplete ACI
 command buffer backup on retry
Thread-Topic: [Intel-wired-lan] [PATCH net v2] ixgbe: fix incomplete ACI
 command buffer backup on retry
Thread-Index: AQHdRpuSnWXBzzkghECRdWjAErxF2bbSwzMg
Date: Thu, 17 Sep 2026 13:27:15 +0000
Message-ID: <IA3PR11MB8986D8541E815BE9D19DADB3E5B82@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260917115439.1323766-1-xiaolinkui@126.com>
In-Reply-To: <20260917115439.1323766-1-xiaolinkui@126.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY5PR11MB6533:EE_
x-ms-office365-filtering-correlation-id: f9acbae4-6cfd-4ce1-0ada-08df14bf638c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|921020|10067099003|6133799003|3023799007|22082099003|18002099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: YQjJENTo/EcHVq1UOIqMxWP+etmvJaQcP5atvvwkfh8QMBTXei6SOibY8I7y7jLNhLSp5CLu+awHDX+qNLIO5BginAIG0Fq0p68uQPJ+YhHYffCt8WytN8F+P4dU70GjgmSkqJCIsvW9X2cMBl++L8ddqZwLd3FFU1NtrkY1ZJWzo3xYSp9SJC/a2U/rNvBtLmcdV3LQIkcTu65A8gAg048LSNCbK4cdTN2KtSZEJFhu6z6EUxJrdcAma0lkWFBe3UaXeze0wGCOy9Ay1aluGruKcpE8icyoF/jcaMK9mXazQTOYVy85TMkD42ZLc/tcL4LQ3HyiddWeitR/bBr36U8I4ZOy+lEGWshB/ihrsePU025/0BNT4dVKDNc4nY3ZmCAjye7Zt9uUVStm20ytXjSq6gxeOWdGCEpq2EPmQKJDbFaKyp8N4p7+YkwHzhu2L10UsPTPrH/cDULBwXhn2d2rUcLtX14U9Om12t5mO43qkyMOZIEx+SzbiXTj05QPDugIBl5taPOUy5HziMb4wn4e1+TcRmo6YFwuvBl/xx02rHXXFBOfNKtva8AWsRxzjgfpIRrxK6nJX849NPBp6nT4SWGSdc4JmdMDbvCjqLWaDh+o8waEA8acmDh3wHqSgwVk2LbTjIUi+Zjg/vVT/oVg2IEIaalBZNVpf6p8AewOgj4aJUuLGh8/bOCGZ7RKFzSVf6JrVBjH66u6tBCDO+4fEOy2/QT/KKdu5yvPrQn+CudpiU40q98JN0D6zXwp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(921020)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5NSrew3Z/aOWzIzgkOzVEV/yeBCSJMSrauYNjSg02Dw3jH2ISG4Vue1lC/1X?=
 =?us-ascii?Q?nCA00z9lF0mCxlkZ84HTkz1JvEUVOnQ+wv6YTYnt6FT55I+ZCkmKAN4iGJLP?=
 =?us-ascii?Q?X1t+3h6qDDB3+Y87bZPYK12K/wg5II4UOB0I2PMushX0MptsN1xDeuTJzGOT?=
 =?us-ascii?Q?OGPrhzliub3n7/GS6rnz47M0zfD9Kyt49Wv8D6acebWPlVGg5DVIOwSJbmBX?=
 =?us-ascii?Q?eZJgYPWDBUrmaWA3fAHiTS99acZZEq6arKo+KVN7F3l6O8qu/qtRVy5roeA6?=
 =?us-ascii?Q?/z+lEV4O0jqi3eJu9upQQkUaY9gTkofUOBJQbdWxEA/6DswV2+cDGiJihsJE?=
 =?us-ascii?Q?RdUo3T4dwBe9+p6Bqh3TD713G+voLp5zDsgKmo3sB30NrPavan5/Q6btjwAi?=
 =?us-ascii?Q?+JAkl+XctTxWXtzqaV7/3SqSBJPFb/8PCt0iJGfaz+bB7078urciutng5sLR?=
 =?us-ascii?Q?4WdbSemZjDCCnuw9UfA0RLoP5l0VNmVPiguXiN2ELHsbgKL8WqOS5R3OELYq?=
 =?us-ascii?Q?n0mMqGSbMbxyKMjM5IYa6QsP0Zaobk8pJ2jZIyEr0NlPbs7RmNkV3iy23uBv?=
 =?us-ascii?Q?qDth0HyOk03i8gGHKhPCRuYQ64Jp2/IRXuWY5LASVXRlN3eUKxKrC4d17AQW?=
 =?us-ascii?Q?ZW/UgATQwRKEUBStWkcpHv4KziUJFwTTmun0kZiEC9+8/AdELgsFTPCihfE1?=
 =?us-ascii?Q?l5hdw7eCjymcKJFhsJJMP4J16N5D0k0+BJb11rZ9VrKZC0CrBJH4OJGB03M6?=
 =?us-ascii?Q?vZal4nPkiGa0ehjfeN16DwdmYSDp5vg96Ocsp9DzfN6UqQ1lb6rr971MJzet?=
 =?us-ascii?Q?8ScIw9s21pSbpTQSt66wP73DHugE65NOZG3mwudbBpr3G+eU6lEN8qEDcRuH?=
 =?us-ascii?Q?Ahi8DjBDZuDAAlZWOGzDfO7bEiw3PP4xL7Pm7Y5DAVDW9o2SJOZV4cNiSjUo?=
 =?us-ascii?Q?xeIWTpD9i0G4R/1npq1eFcWtE00rciPtSMd7ZQnedHJM7pfHlEOJjssiLfsZ?=
 =?us-ascii?Q?164VsgmL7ptx1EUgwUngtWdDSM24J11pTBnZrv+zDOped8BSVjutikKAFWsk?=
 =?us-ascii?Q?VqSyWeYANMo9Ijt6+2gBhfvgnt5rJFJOOUe6aBmPqkfB1vAKU8ALfurtas3+?=
 =?us-ascii?Q?NqqWOgpsEIle4Wr+CB73Y9cybFJIlEiTIMrcNbVXWjzP2NR3Nxi+BI1bSRGF?=
 =?us-ascii?Q?QI+6Hr/OmJzqmKf5IRjrMG19u2/RbFXd3GgmlUXbyl5SPGMjAY8Ngbaf4cP+?=
 =?us-ascii?Q?LufKHDWjhI7f6U81C9XLrRx15tiGA46zmr+Q+1VpLDMOWJRljmRZav5BHkaG?=
 =?us-ascii?Q?4WMIAa/Puucfu1aaa+sox6CMWrB+/YCBiLtESrPbPHlZ/sbPO2jsF9A7H8+G?=
 =?us-ascii?Q?XaWHawQYZ1Hd3brZmlG606ekVrAN23gGb9j2gl5T+isPpObOh2VDipzxF87Y?=
 =?us-ascii?Q?RabpNqgq8SnMENQ4UtfG5+dZvlUt7VvzIKljg0KQip8YDktNIVOtlLYndkkD?=
 =?us-ascii?Q?dpARYoqT7axpg7wQ9635ji2VGryLhbu5AbTUQbS14S2Bsty7nYKBDVpY9gTm?=
 =?us-ascii?Q?iWYK4/WXxhRVM0pmN9oXfmzO5yCY0/KntuFWFNlskrfIo+F7it8EWJhDmHei?=
 =?us-ascii?Q?WWgsDEgWJx0dffzgjwyfFv2FJM1w5G22plgoDwZCN5RjP0iNR8es9dviV2S1?=
 =?us-ascii?Q?BoN6GHbemDrWPQIFj2t6F9VRBLEz/NWEq5beF2lwCqHvd1V1INbdBcv6n3bN?=
 =?us-ascii?Q?+bP0w4eD7vF182DOHJ+s5Pbobhml3Xw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 5AAIKJSoaWzrHxHbzsysmhGeC47X9ayzVLy6CQiAeg9WorXsIKV1SObDgaAtGLrhAltUkwNJ6fZElgoR9/3cq70q+bnCEjJpD6FnyP3MqhuOeZjudVvctA2zqBT+RaNedA95Ixap8N7IsdCCAwGZszh6yPcZs+rFl0/+/jhm6K2pP2I81cQyqlfwPGtI1ZgOJHOXf6A7xRUAXNWbX8vzpVR9kwuSrAAilB3veiBDUpeA8SOJdfJnHMvtce3di0dDTNmm7qZmgFf+YTR1IOBLCjVwu+VbKlqv33byd5DtKwKLePSnE6qzcUsXVUVSSOeXHNCRq2IhChnZrWoF/oxZkQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9acbae4-6cfd-4ce1-0ada-08df14bf638c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 13:27:15.1017 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vQ1qes40AQEpiu85u8Wod6NQ1ZfVol8EKkTBOweDXiN7IOicdt7za0kBBVCkTNYdcWdqjWu2PxlTlv7aJtksaVEMLeYv0yNXHVZa1mQrzVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6533
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
> From: Linkui Xiao <xiaolinkui@126.com>
> Sent: Thursday, September 17, 2026 1:55 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Linkui Xiao <xiaolinkui@kylinos.cn>
> Subject: [Intel-wired-lan] [PATCH net v2] ixgbe: fix incomplete ACI
> command buffer backup on retry
>=20
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>=20
> ixgbe_aci_send_cmd() saves only the first byte of the caller's buffer
> before an EBUSY retry, using kmalloc() plus a single-byte store. When
> retries are exhausted, the caller's output buffer is filled with
> uninitialized slab bytes, because only the first byte was saved before
> the retry. The firmware itself does not see this data, since the
> retryable opcodes do not set LIBIE_AQ_FLAG_RD, but the caller still
> receives garbage in its output buffer.
>=20
> Replace the kmalloc() plus single-byte store with kmemdup() so the
> whole indirect command buffer is saved before an EBUSY retry, skip the
> backup when buf_size is 0, and key the restore off buf_cpy instead of
> buf, exactly like ice_sq_send_cmd_retry() already does.
>=20
> Fixes: c9e563cae19e ("ixgbe: add support for devlink reload")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
> V1: https://lore.kernel.org/all/20260912013403.2818191-1-
> xiaolinkui@126.com/
>=20
> V2:
> - reword the impact description: the firmware does not see the
>   uninitialized slab bytes, only the caller's output buffer does,
> since
>   the retryable opcodes do not set LIBIE_AQ_FLAG_RD (Sashiko)
> - fix the ice function reference: the kmemdup()-based backup lives in
>   ice_sq_send_cmd_retry(), not ice_sq_send_cmd() (Sashiko)
>=20
>  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> index 4d8ae5b56145..5dd88ee7ea58 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> @@ -214,11 +214,10 @@ int ixgbe_aci_send_cmd(struct ixgbe_hw *hw,
> struct libie_aq_desc *desc,
>=20
>  	is_cmd_for_retry =3D
> ixgbe_should_retry_aci_send_cmd_execute(opcode);
>  	if (is_cmd_for_retry) {
> -		if (buf) {
> -			buf_cpy =3D kmalloc(buf_size, GFP_KERNEL);
> +		if (buf && buf_size) {
> +			buf_cpy =3D kmemdup(buf, buf_size, GFP_KERNEL);
>  			if (!buf_cpy)
>  				return -ENOMEM;
> -			*buf_cpy =3D *(u8 *)buf;
>  		}
>  		desc_cpy =3D *desc;
>  	}
> @@ -234,7 +233,7 @@ int ixgbe_aci_send_cmd(struct ixgbe_hw *hw, struct
> libie_aq_desc *desc,
>  		    last_status !=3D LIBIE_A Reviewed-by: Aleksandr Loktionov <aleksan=
dr.loktionov@intel.com>Q_RC_EBUSY)
>  			break;
>=20
> -		if (buf)
> +		if (buf_cpy)
>  			memcpy(buf, buf_cpy, buf_size);
>  		*desc =3D desc_cpy;
>=20
> --
> 2.25.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

