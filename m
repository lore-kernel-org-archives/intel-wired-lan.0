Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED327C982D0
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Sep 2026 09:40:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AEDCF60629;
	Thu, 17 Sep 2026 09:40:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kA29fnylOx1M; Thu, 17 Sep 2026 09:40:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 09CCA60840
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789638001;
	b=FBy5g3zd9tz8z1V2CsIR6Ch903BY9uybrXHfoOVuLsMZaAvN/wnyFi9fStDbCxSUZr9w
	 3EH0n5Vor/KMTWqHRVkn+NHBo760bCUZ7/wEEPZ6tR0Xnf0WymEPRxdWuDVNdYWDtxYqV
	 x5VwfMSS3A0xMkGIA2182Zr3BNMBMOr/5F21IjRlTf9Qo8upk2Km0ZkEStXzBRLs/9QR5
	 qBoAhvjxrFkLlT/1+H8qEXopWidKJaUPEBlCz2dqrOQL/xssR3o2OlPdNuFt6P7sPt25v
	 RYL4znVWkxbQvSDFY7mWEzmkCM2Bj9y43Zq4Jh/Cv6CLK0wRbrdW1ENYbjzdRPXeSLQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789638001;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 Received:Received:Received:Received:Received:Received:From:To:CC:
	 Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-ms-publictraffictype:
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
	bh=TQDw3S2bPVZLEnsaonduQw1rtUpf7wAJdpwxBRBW6n0=;
	b=eBwJTjBDxJ7S1slD/UplSCCoRZUc0S2VFb7in8DBDi30PRYggyT6yRIcH62j07fT48Gk
	 hef4+MY98snic0tP4JsuCXEbNmieJ+kIKZyUtVUVjSXAFGVPdGzbVYImTVowcoAaeciwb
	 sXerCatREOZ1TCMD51kAgqJrjPLrN0F/DVyfm1DklOLAXCWItOaNxfyRMzccQT8xdzspG
	 UjUePTcVlELZClMs84R/WpQ42lmlvUop3dGOixsbR4GShPHjgL23X0Osbfrf0PkiH1euO
	 VOEXooGOPmGvPXMw9kKQiZKIT8lXTzms5pxG06ofuKjw2hrCZm59nWClyerl2eRxxQg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789638001;
	bh=TQDw3S2bPVZLEnsaonduQw1rtUpf7wAJdpwxBRBW6n0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rMbFHKXOxAm5qscbOk4si8ypU7tod2pW20S+jJp6g6hpM58ZT6rwVr5cA1bQhvy3Y
	 8OttGiSO0Wq6bRNmlNjRX/629DqoBUbmf/mjKJDK0WSukFG/Vs4LHZcwzrLTTq9Z/D
	 3sM2s3dFVry0lDw0/K7PxFOzfjN6hP3+W7LCjo6TXtLAj26T6S4E7fqAGzCeM9uvY8
	 9ctGj655sHNRVNv1kluldxFvGgE38IMIKgEh7MfwLYWCBQETJfefVbaOzg54mgbWVk
	 oMJpaLwRz6UBqaHdF+Y8NOxxxhLJk+3Cxykn9vhcGTfOUDswyJUt2EEmgt1/Rs67T0
	 Aq6ZJMZsMK6Ug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 09CCA60840;
	Thu, 17 Sep 2026 09:40:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 09BD32EB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 09:39:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EFD8C40746
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 09:39:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wkGflU0wHAo2 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Sep 2026 09:39:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3DD4E406FC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.16
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789637998;
 b=meVczIduR7TvaSs1oPncDB3WSUx86aKqqetiO+Beu5aw4k3H5lJU3SUMpKaXIA8NBRhb
 c5dLLqWk9lrDDVlEHTem6DYo9Rprzs2nD+c1wHawZfgLWF8KrHjGUf9XzF+SClSFdeiPg
 /3GcebaDZ/Fp2a3GaZ6kMYztHmE1IanN3KNTkyntOmV++DskhH04ceQNmOkugbNPQxc1M
 ONUmR0TC9/3F0p79GC5dD7PZcQOhI4o3jN5D3toVmOHQbkDh6hTHPSqfrEV/qwBK5GEnT
 Jq7SSDBJ1iVlVVgYAZ/7RV81UR2K6ZCzXOZH0CIV2+7KosIU8v7A4lOP8pZpV0v4IFA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789637998;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:Received:Received:Received:Received:Received:
 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=TQDw3S2bPVZLEnsaonduQw1rtUpf7wAJdpwxBRBW6n0=;
 b=FZEbpRb1QnxVYvUGU2QCvKc3eZN/zEIqeloUOuNbKjsMpexsRKL4AdXGVcuBZK9P/86C
 SOHUi4fd0UuGmjGbhi2HSrKxEppTrD5UgBLsS8glX1K6g88lli7IRdRB+qNvuircwqffL
 dDeI/3ccJD5QJbclWDblvxmHSkDyOM8vhkhSN7fzcvB+hiVR/ftJJtpyfqm8vBAIxk6QU
 teKdlvTz2n35iJ7X4QzTVuX2f5494/XqhZOyFkNxRfV28Bh1qXAh+JtcaWhJy0X1haq+C
 BzEvZVw4/pUpswQui0Y+zWz28qYTsH85Ra11NZ6HsDbdZRYyVx5XCu8nV0x54ilEUWw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=NmMECexw; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=NmMECexw
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3DD4E406FC
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 09:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789637998; x=1821173998;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LztIpK1/2r122nrRuUAXjR1xClSoSAb3HIsQ8Oh2+7Q=;
 b=NmMECexwoQpxuUA5ghVRRBknSyRibg//Th5bAXk4sw+YfDpN7hAh09FQ
 uIi7Uyg0eMfgHUCbAxKjJwCgS2dZ0rT4JWi7hz2EtodC6Sv7kLCZSsllo
 jXA2sqFsy880gMoaq3CIY7pTRrQFPy51QlwLLLHDQwvJEwTXx1K5nBfR1
 004oqRysSSY4AbWZgFFNzUhTVkD+CZP4DAhJM7pKBvtaTN02AWSoNSW9/
 4sk1meT6WBxQZcRrTjVUEmNzf4kzU+D6iOiEM87hfaeFTwg5QeY268ghY
 d8kR4qqQQrGAgSynvFxixyG9pq9PVwZ47PVUeC3Tu7ZWUO7zRyWSushuK A==;
X-CSE-ConnectionGUID: U7+y8v/fRymw5X3MsI+y1w==
X-CSE-MsgGUID: r36LkzPzRyOF9krOe8LRSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="77606977"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="77606977"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 02:39:57 -0700
X-CSE-ConnectionGUID: zhNQ5vYoQvSF5NITrPJXRQ==
X-CSE-MsgGUID: v0sq76/oSUeYEZIfNmuvbQ==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 02:39:57 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 02:39:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 02:39:56 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.50) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 02:39:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VISBZjO2LsIFt+d+padWQNYz6g4EfXdbgVSvOeEDvkUN/IMRFF/v2CCgb8GCfiw1Ywa+O2Z2BYpjvKoKYsmqkRh5bUg92GLAfKroEl5FKseNbgPec5QlzoKSlea+yvKDZtCXEhJClvGx2+6vuwL0EPsDpS+nd+RcTSf604EYzGV++fOp6K9TCKorvL1KB1KxO0mksWWLO+ILw3JYYIoxi/XXNsCCjXaoqxh4553N2po1+bh4hyfk16LtUWe5jivR9vn71MtQ/tP8gXrGYgfglQps/qgN58dgeVJcdEunExd6tq9pIiohv18THJBrjt6zMZyWzZjUk5FbCeeE1HU2mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQDw3S2bPVZLEnsaonduQw1rtUpf7wAJdpwxBRBW6n0=;
 b=cqZmazFaXz7mRdZWrnyANjl45WZwN9C8ku3hIpNgusD93vIOUa6zh2a1iPeJdMw0BjLAqoegvdPmvfU8bObPrgsYAxdXFERcxHt9Ka40OVUF0sJqFe0aO2QBGJfxmbsXBf2Ca5aMf4USvGRH8E2IiTR2po0PXLOl7hUCpc+Wpbd7f6nisX0r2DMG5hlR8N9Rpa6ivTocZMcezslW8ONxUFlhAbyqERTqzYALXnDRNyrSiICZQW5KBpS/6Iu3VmApIfRNX6n3ViEkhAIRM5xJHB4GwVtLfTpYrBtDbZMqS4d2+zEI8kbIPdfDhIdapKsWPkXvZxWRIlvzPwGAebde4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DSWPR11MB9798.namprd11.prod.outlook.com (2603:10b6:8:3c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 09:39:47 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 09:39:47 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Linkui Xiao <xiaolinkui@126.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "horms@kernel.org" <horms@kernel.org>, "Jagielski, Jedrzej"
 <jedrzej.jagielski@intel.com>, "kees@kernel.org" <kees@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linkui Xiao
 <xiaolinkui@kylinos.cn>
Subject: RE: [Intel-wired-lan] [PATCH net v2 2/2] ixgbe: rename the EMP reset
 timeout constant
Thread-Topic: [Intel-wired-lan] [PATCH net v2 2/2] ixgbe: rename the EMP reset
 timeout constant
Thread-Index: AQHdRnGwJp2KQgNESkePUelUh5pfhbbShAGg
Date: Thu, 17 Sep 2026 09:39:47 +0000
Message-ID: <IA3PR11MB8986514D94996F468E6344B4E5B82@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260917065436.1181073-1-xiaolinkui@126.com>
 <20260917065436.1181073-2-xiaolinkui@126.com>
In-Reply-To: <20260917065436.1181073-2-xiaolinkui@126.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DSWPR11MB9798:EE_
x-ms-office365-filtering-correlation-id: 20549ff7-ce23-4486-91ab-08df149f9d0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|366016|22082099003|18002099003|921020|38070700021|11063799006|4143699003|10067099003|56012099006;
x-microsoft-antispam-message-info: ky0MFsjckZfLk2noIJ3jqNhsuPv0/OKNWYlfetpBdD41HdlObgr2nGWNyhu1V3BXTfoJPvl4gYRKWalDsX4zuY2abV1c3VLihAF5dGNBsxY2aJGv1/N+QG/ows8lDtIWtL162/MZlAIdNK89JV5mNSZw8ar8Ylusbf1I9gPBypCQNzoBq3Ll87XU0pjc/010lBhyK37Acwxg4IX36GY6EFSWf+HYTVYZq5qx1cV2ypG1VZJlkE1qhbpmGrhHBYoHO2tnrccfudGdE7OA8De1zxhFxzvytT3BNxFW98BhxaiL3JGsPPkjfw8F0LgxHuHHXX5mT3E0E8cumoggNz65njG9c3/5d8p2VnMJ/hh8d44ZIkWr9Oo55qRsPYWxDKLY9A+2uxpogTn+3nNtWjvt4j53E495FhVPUIAyxEwZTgbSE5QX9S9LwAfS8geZzcgH8BuP3tQNoQ4OmnUeFlSPWyN2L431aNOhaDchasklQ9Yuy2n06QT6WH58TGo+L4MVvSVw7/E79zaEWppgIoU2r2ImgzDMhhke8fMfURGK4s3HrnjmVaNW+Fl6ufFDyf85WdBZVgy7wKBlNN5FEsYtKNPlhHBBDh1gdhjTagh3dHf++whuEdS7AzOWKW1UQG2kJNr67tlSvbrrTi6orek+IR2ZhiNQKpk2gZTSU67+y98uPdjoQanEupcdFepD12ZHGsDz4u0F504yyhOybfLa30tU5vBdwLwVOMh7dbX8rpvNOrjs1oGYbfD6CP34iTdE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(22082099003)(18002099003)(921020)(38070700021)(11063799006)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DIKXqYW2D6BOCu2ELXGdGuVkKSR0GrG8/PxVD2LtxD6C5QA0j7MO9p7ZpKmS?=
 =?us-ascii?Q?mGJCEo+6y/gNnbTyZE/SBvRJeR5HTysjTO4bwZFglQ48Q/HLd9p+ILyYMOIF?=
 =?us-ascii?Q?A/M2JSVz+dRs1jqxfSZTHXg79cvX0Qs/4M0d27Q8VFzjZ8r5Fvs5AK0K2KBv?=
 =?us-ascii?Q?j7dIEMPmQkZMrTjmOuILeNebRM1G8mORnBHAfyIWRYoti6DDq5bxOXkxP2K1?=
 =?us-ascii?Q?AhBm0JfBvA/INCmKfqiaqn32vhWCQUpeEZAaCK+6xGy2WR/DkCvXJ7Sdf4zL?=
 =?us-ascii?Q?hWXfcXDExaT0CDcQzTzaCguB/Y9HtPww5yY/4xdgL/IQI0mVYm18LAlq55mK?=
 =?us-ascii?Q?b7ztfm7G2TkBo4Sb1f74Xa2CvPoQ9Xb+2S0BtDwcevJgzpcrAyjylMMy6Q7K?=
 =?us-ascii?Q?nZRwN6/hcUxWvNZdW0gPYnj02SXr225l1UTqf/EMu8Bud/79CWzxFrxtmFUr?=
 =?us-ascii?Q?SANMT2nV/b1fp7F6J2A3ALJaXhbWD7Ju1TUVDCZejVtxHzIjV5quNZDefWlB?=
 =?us-ascii?Q?OMX00+ghnNNXTwqdlXEgavGc64dvkijlridt2eZYbSTHY4lUKNzUbEDKOlO3?=
 =?us-ascii?Q?gI3zX99lE3Qbtr8wusqF6yoNxev/Z1X4Z8Q3DfwB+zbjBQWnR/EgLZ5k182j?=
 =?us-ascii?Q?tLroHHwPuCgHEDoc0CjuA0LxRZcK7Gi42+Z9VZr7lt46vishC7avIP9eeqXH?=
 =?us-ascii?Q?+xMDPAK6TKINDpd62NgefKuAkNdMf5r9ta4p9c6jH7RS27F1c7v73tDAiqVT?=
 =?us-ascii?Q?AjQM3IGIOqOncDn0c4cqEoL4DAsLmnflOdLGpbNN4MqnwDd4W/JGauLUs1AD?=
 =?us-ascii?Q?NlTTP7P09Q0sv4alK/vxXtAYCsaisoxWK/GRG595/w94c6z6ZMpju+kbZwEW?=
 =?us-ascii?Q?j5YsJZzgLadk29cy9wf/Kt4hj+N/Ddysq2Hm3suLht0q9uqQbzOuJl0S1SCJ?=
 =?us-ascii?Q?WVmH1iWIIqX3WNpHj3X8rikv/OXbkGsyP7FEUbTQV246TgXgyZwanid5efEc?=
 =?us-ascii?Q?KIlRREi+YeM/eKwR5IcmfhY39YpfVC6pAVHUO+7oGXCyJuf3alAIn9RJlKWG?=
 =?us-ascii?Q?Uh6O0Etq09AzZ/k7zObBKGQ8VwSuRGgy2aziD+tr2pty0zL1qRV9ku8nXtTM?=
 =?us-ascii?Q?spEomSBZxdf1VCKeijumFP417AmsgdhCZujfxzPSEogXejRz+SXd+c4p5mGj?=
 =?us-ascii?Q?rh5Yqrj6Fe9KTXIJEmLNlfMPEC+duflepPahuACtNtcPjY2r+FyEIIBemkvo?=
 =?us-ascii?Q?fYyk45v29X4cUoiRxsNVKaZLP2A0K/RO7nbg0KOcfuG3G2ywA9rkiVTp6VsM?=
 =?us-ascii?Q?1WyfEMKEbHvSf/7NJaNlkBxxPvD3kU6lD4JMfOA+D0XKpqYnTLp4AQt5Nhxu?=
 =?us-ascii?Q?S7YOv6iBNlnvKc7cgva6fUm3MO93FPSKqKKu+Ua6E/RqIZ8/zHyMPJqb0hbH?=
 =?us-ascii?Q?rzCV/CNl11UBJjbNsAxDeYMeQUCKEufs7tjiwFa5F5ZHXfiixO322vzLV2Tu?=
 =?us-ascii?Q?WIWLsdj44VF5kEXK1cOmsBqhnH/eryXT39NJZ8CVcD+RCBRlKS+yuqsc8QMJ?=
 =?us-ascii?Q?7dn7+d7twS96NEpyxc0+LqSQmZJEoUpPCptIvhNvhYhpWMylBb+w2QosJ23U?=
 =?us-ascii?Q?I54Nj3dEXDZEYdl7PfOFRMNQ9/l0ijfZojn2gyc2Z+JYBgjXQXpPDQxbLIdf?=
 =?us-ascii?Q?hDQhrxL4NApWQBDVf7bF5As1/QZE5uF8HQ/Tuny/YH1UfBelNVxtq20xYGuG?=
 =?us-ascii?Q?xMJ0pWH6wvDsdXKPAU8MeQmr+FcUvFc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OpLC5Bhe76oKisL6hP82gpmrssAPt+Pt4tA7kI/iWTCg4p92C1ZvBdHf04KXqfVVvX5O9k7KRPA2DNkmfOfDjiTg7mlRjsai2P7tZ01nJIsLFOzx2z8p2oiHghACVmpTnz3vPzhIXva8hReb+6osp0CgpBIxjlH79DB9pwLw+CRHM46oVFJsYehf5w6x5WrxyBsTDDP8AGIfOsDV+82snnReYWppoKVah4VmwfPtyIbGl++hZwa+ighiJszkzHZGN7FBFpvVe1U2gHIicfxknDPGFoNNCgxTschUvEfDaaAVsNN+NTOlOs2hvQ1TBSh2aL8+aBD4obH5F8zeE2wKVQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20549ff7-ce23-4486-91ab-08df149f9d0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 09:39:47.6269 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NaL7t+rvvX+HexhQgIDsNfucSTYnILuTRehFsMJOV8TmpuMCqcQe+haCUWoRZiFZ37bEmndSXS+yPAuBD/tl/Q4KW6crEYnK2fgwjWaYDhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9798
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
> Sent: Thursday, September 17, 2026 8:55 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; horms@kernel.org; Jagielski, Jedrzej
> <jedrzej.jagielski@intel.com>; kees@kernel.org; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Linkui Xiao <xiaolinkui@kylinos.cn>
> Subject: [Intel-wired-lan] [PATCH net v2 2/2] ixgbe: rename the EMP
> reset timeout constant
>=20
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>=20
> IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC is misleading: the value counts 0.5 s
> poll iterations, not seconds, as the comment right above it already
> explains. Rename it to IXGBE_DEVLINK_RELOAD_MAX_ITER, which says what
> the value actually is.
>=20
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
>  drivers/net/ethernet/intel/ixgbe/devlink/devlink.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
> b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
> index 781f13240a0d..15b14c5a7c4e 100644
> --- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
> +++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
> @@ -430,7 +430,7 @@ static int ixgbe_devlink_reload_empr_start(struct
> devlink *devlink,  }
>=20
>  /*Wait for 10 sec with 0.5 sec tic. EMPR takes no less than half of a
> sec */
> -#define IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC	20
> +#define IXGBE_DEVLINK_RELOAD_MAX_ITER	20
>=20
>  /**
>   * ixgbe_devlink_reload_empr_finish - finishes EMP reset @@ -464,7
> +464,7 @@ static int ixgbe_devlink_reload_empr_finish(struct devlink
> *devlink,
>=20
>  		fwsm =3D IXGBE_READ_REG(hw, IXGBE_FWSM(hw));
>=20
> -		if (i++ >=3D IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC)
> +		if (i++ >=3D IXGBE_DEVLINK_RELOAD_MAX_ITER)
>  			return -ETIME;
>=20
>  	} while (!(fwsm & IXGBE_FWSM_FW_VAL_BIT));
> --
> 2.25.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

