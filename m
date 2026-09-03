Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7144C61DD3
	for <intel-wired-lan@archiver.kernel.org>; Thu,  3 Sep 2026 10:22:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4747480859;
	Thu,  3 Sep 2026 10:22:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dk2l4X7Ybjmw; Thu,  3 Sep 2026 10:22:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 55E5980805
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788430948;
	b=GQmTJ9fI11VITnFvFeeODPV5+IjYpcWSAUdiFWrcVEzVx51bC6Oumnw0iDqFwSs5XSA2
	 0y0D3CYQvno9NcFnHNjaR9OSzA3EO8h6OlQHFE+wZnOeasJWw67ykOYzESK3Y2TK4pcTw
	 QbQokC7T34fDCm7DkH/orfYWOBo/Eb5/OmkNwyqnPkXjIs9Dk0DWPuTWlOuy03ZrrJyRo
	 KFuY6clr/tGYO626pz8AknQyYuk0pub6El1bAyETubYIbQjdo6HoU5XgHcZGblRY08ZtT
	 uvXZpIh7tuKBL9bj+6KcKzjyonQb+GM9tu70FG8Z7u+j1a4TdhhCdE8Ea6oqAsiWxGQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788430948;
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
	bh=+Vi3AxwENBzwYiD8+8rLur6Yzdgct5N3JfTHAbkRXN4=;
	b=RpjQwOgsubW2+iQy2J0ueNuacsH+ecDULDwZy6KEObqeE9hgCkXjUQoxurHTTCLiSyeT
	 qq4D90Hs2eRnalkYRPpKFmuonuks9BUWYaUULmpQ7CSlSj0+ZTuK8BukiXOxWCWSGtvvf
	 16FrBzZdcmi6ZB9WbbD3x6X59PibL2YqaDncv3vQoVHzIyjL0S0/UHif0+yHgxmvo/t+J
	 PdQeQBw5gn5bqEgcQUqDSnIuWrBZF65g+Ukj8rHybx988Z6Wcia+f5atDai8PKUJZavWh
	 gO4lU4xBmbzbjWtafswTM0Pig1DZOKzmusqAQW7wnHdULYxdOF7X/5/wGYRyicTC0UA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788430948;
	bh=+Vi3AxwENBzwYiD8+8rLur6Yzdgct5N3JfTHAbkRXN4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F15cIOL8s4gK7+OI6L+1zc0xrmcNejgFIqXfnDzZhxYvTd2ipfmxuQD1Yg/aZQSP0
	 8HrIKRQFUANEg/NphTMuyZR7LzwO9wsls/jW2gy1o2tz4aX4pEUn9XivDAGIjLIeoZ
	 7YFJW0tRJEGpRqDQO3PX98h3v2zbwjUeg1hNAFUoc7MkO94uzII+oQU/BzfNamcSYC
	 8zD5kK/ELmkjSwSMo05hc2wuKJK+j1Q2J/baZ3um/MUd62pM7B5VKFltnnuMmuDOsK
	 wKuH7Zg8bgoQF8XLP2HeJmQ23KEu13we3EAuFLZ70jcV3okv/wzz4ysi+yUQbolFld
	 yjH+rT4hFVQBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55E5980805;
	Thu,  3 Sep 2026 10:22:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A14F22F
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 10:22:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3B94B40A6E
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 10:22:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xnpBHe9L1jv5 for <intel-wired-lan@lists.osuosl.org>;
 Thu,  3 Sep 2026 10:22:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 48B6B40A6C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.20
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788430946;
 b=ItS8s5xSUyODqcoAypyl7RcI4tsD35vNbzW5fIGc4Hv7U5iVm7v9YS81SfbWaAqvGTgy
 EWP32FAvMPwMw9RzCRISrylGGCYv0Pku4JKRp3jxp708D108ZbHEJiFUEr/WIXMuLQqmG
 CdaEm+y8tThtUVoWpQr1mY5tktBA+Z9E2ucwFHU2oT47DNdrmEDWrRaBGaFk/UWUZLmlx
 Mcc4vQGeq2x4ZOzNl/UFKg1p0O0li7ICN1ufh0feMsrx/1+WfPN1ldu7RUpsj57W5KsfC
 mQEiMoi+H/CHZwxdrv4VnDm3DFG/1YZZbsgU5oHQnDoL4b55dsl05ZQxIERu5P0Kx1w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788430946;
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
 bh=+Vi3AxwENBzwYiD8+8rLur6Yzdgct5N3JfTHAbkRXN4=;
 b=JJ8Wnfa7LZecr+FC4x+6uzLlayUlNorR8v/0N6m0ndEgS2EQzFii/3VmfS5n1LRZedJk
 /4L6zlglwMP2AT7kiQjQV5IeUv76h/6L9PdWTxJ7k8T9MjaxUCxBq+xQqqoHjg8wA7IsO
 vaZIb8MeBvSiLcC8LZYgSX7TUmUpsi/KErNCAMpAFWjCrULYaRbLqGf9h76H++MtpZlrL
 ru9+bLAcqcR276aKluHm/4JmyAjxgfB9xlfAHxrC0EHRGtlXZiT08iRDJdf7bDAfP1NhU
 IGMLElJLm2pG+H64ljyntB3qWBu71qQc1M4yeKb07J7dK7cBhkS0VoAzbpt7B7MyK2Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=U1UXyNJE; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.20
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.20;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=U1UXyNJE
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 48B6B40A6C
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 10:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788430946; x=1819966946;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2OCa8dpe+IMFC0TKfOe4csV+FL1XQ4dm9VIBbZOm6W4=;
 b=U1UXyNJE/nxoSF4Z1sDXbn8J5e60iKdRE18wDZlEyPCw+AMJrUSioVHQ
 1ZXQhG3YhmoMN39OGoTyQmSt+FoZwzgjWiPoTYBijkA4KcWu52njCROkh
 uD4LIUv6Wns9whntYln5/3YWF6mB0cj3wnIGehTnJ8++WAY7aI4THz5Xh
 /cu+RkCxZ2WazEhyPAxucozh4cunhWki1QQFm6wSEDXzXkUUc3x7vGdUw
 YBT77t232I5/QXKykJOFQZ0+s46FHjLtEWMWpry7pFWIlpqXp50c9jN4s
 FxeEiOsJ/2YNd3ek4SyMoW17fzVCAnzjMkwurPcxsdaUsdO7Tiu8FNb4H A==;
X-CSE-ConnectionGUID: FZeemBqMSaOzGxUU0JFzMg==
X-CSE-MsgGUID: 86cdPOxrTQemxuhuk1YaSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88673615"
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; d="scan'208";a="88673615"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 03:22:23 -0700
X-CSE-ConnectionGUID: E/MBFoJcRgmRHU9rqqXxpA==
X-CSE-MsgGUID: 0/g3bIJSQtCSbRP/uytgBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; d="scan'208";a="299543548"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 03:22:24 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 03:22:23 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 03:22:23 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.50) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 03:22:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6HZVvF6HQI5699NYLq8s09iVfpkIjCJsN96OHHJ+0H8FciYJz3oQqnbQQs/MQRg5BvFbzRrDuhXnlE4xuUTwzQq/pBr32Z7Ri8GCHnVnkrNH1iQ5r6Qly4Q9t6G8XKa2BB6xUz2yD2YwcwbaXtXJDVwS0YfFaALZqM50BtZzsb/J5vzZL/bIrLpIxdHuCLed9uHfE3cowFbftiI/90PO+6Ytv/Hnvs55CaOE1kf8teR++r0vYtMzokuYyodIRfolYdU5GGp+ZLTAbvXzI1vktcNrq7+wQCXzRbdYHpqjG7bPT4IZOKioZbDu6vX8ZircYMJ7DbW5a64RnESsg4uKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Vi3AxwENBzwYiD8+8rLur6Yzdgct5N3JfTHAbkRXN4=;
 b=sgoACUQCtsivP26yjgddhUB93bEtDci10qKnOvHhjKtaq7NIQrYSlWQA/VHKiFBBaLJyQJkl6qQREYgtRDY/nTz3c/VUeJl8Byn6IRBPn3aIzTCDPQEDnoApvulvEAF7xBM8zFM2xSfJZ5MVmldA9x5hmCje4kAgQVChpWGVZyueY66Qhned3BQsWvBCBUzRKPJ9O0V0HUG9hBZVmqhztK9mDguhuaF2WTNPYGevSrlgACu36/Dhsz9rh5afuoA/r3f0NXFGpEOAB6ArWhX7ShwPea3TbXNXEJBnE2cTC4x9KFjFdOsmmsdC+XGIIE3dt6D+ye136P/1MjKG0bJkLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MN0PR11MB6009.namprd11.prod.outlook.com (2603:10b6:208:370::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 10:22:20 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 10:22:20 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Keshav Goyal <keshav74123@gmail.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] igc: remove unreachable break after return in
 XDP path
Thread-Topic: [PATCH net-next] igc: remove unreachable break after return in
 XDP path
Thread-Index: AQHdOu1PUGGBvCA+I0e4Uhx2LyDfjra8pkOQ
Date: Thu, 3 Sep 2026 10:22:19 +0000
Message-ID: <IA3PR11MB8986F43DCC22F802B8236D18E5B62@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260902093443.93466-1-keshav74123@gmail.com>
In-Reply-To: <20260902093443.93466-1-keshav74123@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MN0PR11MB6009:EE_
x-ms-office365-filtering-correlation-id: f7b273a4-a799-4db5-1e7b-08df09a53c90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|38070700021|10067099003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: +gshIqnNNDf4Vlf6BLmsAofYDFae7s1XWoSUg3qw3fuDXBApXdm9q3AYblaILrO3Wj/c8YghwdAunp8gw3y22FR2K2KyiNR1WNzpPfYg5+h8dBXEEM76jk1suBk+Jok3xKjuwWalmJ1t/jqvBesVk4tCMeDri3p4RRL4iKQIxyNHMeFL0eodJnFAK60c6w3eqEHzXMXOIrs/ZWZRbrPt9UEolVNi1XvnNDffHEDzHRHyIVE6H4+vwf/2Hvzg4Hld7eHJ0Opn9XW3nB6edEywV5guqkKQISAZ3FutXJliogG8+nZwUWKkwoKZyBqCJ9yU0vETl+Z3qwFWHAuyLE2z9WlGBcbc3GY2V2ErBz/MkYlNpyebsBIKSFBi55VobCbfbHPVjvKsQ/j1itsP4VE47PLGqerUwn9beKL4k4sD7twb8/WPqJ4SRnldZNZ5eRqIVBumOmWGU8kd6GNOZpeBdBATQXW7fAT5ADLJVYIwfw4ev2ZZkkVi3rPviRpqwl1uZhKPfnTZwZqNZWujoGBn1c5fvyxxYFAtmHoHQaq3XM9aL/I5u1vdXWQX/K+Kk8mZjErU3/aE7XZ4Wt7vMi6vvugZaWyME2hULlAVEvF/T/LnIcTI1R3kaCMaEMZW7zLmOOL7MgnB99mNbGoyX6TMW67o8ermIXJ8OyFx+gYkCehY+zpOyUK9owA/aQSWeL/xxI1Vw7pherG3j3PUq7Rxi3Z7EATlK1BRgAdfw5Ntetk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B4d0ScNes3ylO8Zh7hJjGWkMDjSp4ejKV/yjB5vbz8LLfo2y8FrE6+4BvfkP?=
 =?us-ascii?Q?ubuwd+NIiq4uGh9tD92trjB5LZsY6EaxE0ATd4sHcdpTGws7niz1vjAkEsJi?=
 =?us-ascii?Q?Mpsf/OVCdyRT/eYdX/mL1tqIAQjSJnDHfe/RqUw+fZOl6cckxvT21jEXWSBH?=
 =?us-ascii?Q?oY1FIX1ssn4k05MuYNEyWw4d15ZPeIUgBJbghoXGPBMxXQJTM4pFhQvFNHAs?=
 =?us-ascii?Q?l9kQEfNQ8rJg3XEF0QA3k7+Lt2gwcWYaKGnobZ+N4oGH5M/GMqc7XemdE2by?=
 =?us-ascii?Q?EovvQ9E8jNKaKxzJMIqeAcogj69LZ/HDP9i4n8Znra55XeT9VKyVr/ifWDdr?=
 =?us-ascii?Q?zX16ocaSyYUgGBBoe0OOftgmfv2ibu/Vbmx8osJ3KkMVkzuekjqGu7ZmgdNw?=
 =?us-ascii?Q?s2tHZtXBPsJdvq9R5vqrNl+PedIE1NWVXr73dCWKGum5OlZYActMfIcil5Xi?=
 =?us-ascii?Q?6B7kYVjvEsaLnrIPz1rZexxyFX0vZ6/RkRxOQP72FwxEFu4ucZmFLJJHVg2/?=
 =?us-ascii?Q?p15td89vWTPMJbT5L9STD44BRQs0zlX+bSaQeGwC/fJ9xVIYix6CNDzGZcey?=
 =?us-ascii?Q?7QDiCet3NsRQwQoA/A+3yZtkbBgMgha9WOENxszvc3mXly+VEbA+cnfuAZHk?=
 =?us-ascii?Q?yX15zImM5bXQi3eptveWwkpoZth+djm6uBoXbkSEDPbUXWWZe0h+6nsGBtzp?=
 =?us-ascii?Q?86JnkgSGRfB/H/aGY0LMcuvKH2pYHIG3SMX5sudnc+4TvqhKUP04DiI8/1pU?=
 =?us-ascii?Q?jKlNCMJ7T5Bobcyb0YdUtYGGX9f09jeap5UjeSBJVTQxz7k/4+0sS0qTxLO2?=
 =?us-ascii?Q?YfsaB7PsOeO2NQEmSwzVtJIho5zOsISL6UCou3fNT+ib4qtcdhiWNudsw0gJ?=
 =?us-ascii?Q?Q+owUiY/RcpLeRRJzOmUAUOcilg/T8gwufzyXlmpX957rKup75YAj19cRfN2?=
 =?us-ascii?Q?v/HiKXsHqeudEEkzzehbE0JBD3XlRkV3Irw7H2UknYQOpBLnbOI08z/GhTvv?=
 =?us-ascii?Q?eaPraonq7UuzcjN3yKlgrKI+jazAV8LFYIjuRi9kvKrBPiX0wfOp5jHUPeyw?=
 =?us-ascii?Q?2LNfEDjbW0QryZdZWfDIH49oDNRQdoVeVj4Oabk6sPJd3Vma1QOLGKV1z0vS?=
 =?us-ascii?Q?NyitmOmZwyIiuT0WRl1jKC/gr8nD74NiJNqgRgHAIdk3pk/o+v70crYVSJcs?=
 =?us-ascii?Q?RWwOyGOvRnRVq066i9qHOGtguwaJl6DKBErAT3w5zqSN6WjYSVVrB1S1Cq7n?=
 =?us-ascii?Q?rIVWyA5YtkQyeoul2ds6sLs8zw7d/Zt1ZhjmZvxs4IquJbYxhTKm9Phf6RCP?=
 =?us-ascii?Q?1pQBSRb1gPPpZzt5wL/oylImgkaqFu5Mm5tGGkp4Yo1n9LBCE1k3039PG70d?=
 =?us-ascii?Q?E48CpHIyXAXHzAybnrh29xAAEm9iK1fUyLhElIMHVuzcYS4cxTirOQhILaQr?=
 =?us-ascii?Q?a/heWpwkV1iT5td4VCyS7vROjxxK8vedbYGsgQ60k+o7KRQsE4Ys24p7ehMO?=
 =?us-ascii?Q?mst9UOuuzidFzvsbYzLZwcoSqbuSRtbHDsh06OQ/7HusFokKAV2GOq/olqRG?=
 =?us-ascii?Q?LcTkX+TTiDhoV9V+plGc3zRyQQdNbb5u8jnLQNqPMOYlYQ8vJL3G2Sm/xVP2?=
 =?us-ascii?Q?g7RYsoPkTovy+btF8iin1vAab4YFB1A3q92XeRnfVuWGflqi/hq6pNVLz7pw?=
 =?us-ascii?Q?/u71q3azSYimBWWOghfpf/4P0a8G5WGlf2j7+8YtsCF8iU6EMkBmq3ANacd3?=
 =?us-ascii?Q?uQ0/knWpleIYYpQXl5+mcm28Acfe2z0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hDGAQEgJHb8ClIF7GIMI+4QAUNkCcRK21twD32zSu5fd3winYjm8CNWJnpwxaUuJXF2BncTnF3/3Mo/K6CVHQE9jZaXxmDcqzehs0a7IitSne/npL8k18aslwFkXHKXqmzYgiBkinkvx3iq9Y2j/x85eBKP+p5OJlOWvv65xY7KtT/5vIUw/4zpkQwPPHiytsmhi97QhCl0NmAmiMOAjQ4jrw74cu4nN7LxLu9aVc3VbODvPIQ9tRhJnVvQbT7SYK3sqgtpzLgXsWhtgO5v1yy8ftEL9dR3Eu8DGaDYU3SuBLtLqIsR0G/JH0CoMhmOvBYlYUOn4XOJhYPti/WwWJw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b273a4-a799-4db5-1e7b-08df09a53c90
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 10:22:20.0073 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n38JDyv/cChBajkxeAg+f2zacbpbdCBw+DiX4a37YHjCJYK8ttMtS+WmafWJNqBhZcnr2pOpk34FBaTWJO3ud7a2X7QeRL95XBftdy27bQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6009
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
> From: Keshav Goyal <keshav74123@gmail.com>
> Sent: Wednesday, September 2, 2026 11:35 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>
> Cc: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Keshav Goyal
> <keshav74123@gmail.com>
> Subject: [PATCH net-next] igc: remove unreachable break after return
> in XDP path
>=20
> The break statement after "return IGC_XDP_REDIRECT" in the XDP switch
> case is dead code since the return exits the function unconditionally.
> All other return statements in this switch are not followed by a
> break.
>=20
> This was flagged by checkpatch.pl:
> WARNING: break is not useful after a return
>=20
> Signed-off-by: Keshav Goyal <keshav74123@gmail.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
> b/drivers/net/ethernet/intel/igc/igc_main.c
> index 1fb5f3cbe93c..3b7dd104d8d9 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -2525,7 +2525,6 @@ static int __igc_xdp_run_prog(struct igc_adapter
> *adapter,
>  		if (xdp_do_redirect(adapter->netdev, xdp, prog) < 0)
>  			goto out_failure;
>  		return IGC_XDP_REDIRECT;
> -		break;
>  	default:
>  		bpf_warn_invalid_xdp_action(adapter->netdev, prog, act);
>  		fallthrough;
> --
> 2.55.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

