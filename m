Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AD3CA5FAD
	for <intel-wired-lan@archiver.kernel.org>; Wed, 30 Sep 2026 01:21:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F68D6081D;
	Wed, 30 Sep 2026 01:21:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gf-19TNUMvP2; Wed, 30 Sep 2026 01:21:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B783F6082E
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790731275;
	b=fotLY3LguMjSSCiRmEma5f+OV0EO8lzhlvQrMzVByknus0AYbMmsx3ZV71iqt6NB0V/7
	 lc+5TEyZKk5UI2G6jk4H8ojyn4Gl5izgCZ8kF3i/v1XWCeo9VI3xKICpDELp7SsVmjn0o
	 XZSn+19CNRKzGHlbcuVJTtFv+FdEbkK2WduaUw7ZnEBnNawc4dgLDJ34+fzFQJWtHr0ls
	 6BBcbwTE0PZHALai/KvnE3DbphU77d2XI8JyMLkkzwJwK48uscRRXeZjgbXKM4h4ehGBe
	 Qujv7AvDstkiMPlqv+unmt9KSZizQn1vStBMlPkY8XOd14X3tGA1vtkRD3ew1kMOGcQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790731275;
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
	 x-ld-processed:x-ms-exchange-senderadcheck:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gKfxOYH/apLzwRelC6jNqI/7r3wvYJYnAU7oCfzHx1U=;
	b=nQjx4+UeTuSCJaIJ6kAot7D97DDqozdY+xgxf0BIAZGNovCUG03xRKTVhsyQgn/ojE72
	 4Wgx7u5q3nKa7p2KtpqjDmHQ4axjW8kgWGCOYYSDzp5ARRHv4rgu2pssKuxHAla1p8zcO
	 iQqqPtY1z9qoI4OmpcUmLeHzBleNO2PKpp5wMz/Q6UO4OUda9jSA/3v5s43Sy6pknaGXJ
	 nZ6+8ftyFUo5qNY1q26UPwmFkV2n0PSlPkL5FWkWUIfbPJBpwMa5k/mvM2PUPpI1MPNp+
	 +Gey1+Tdt6mRx0k1yhAN9fHHB76OAkEMf0LyKXgeDR/iBc4b/gFW3kfjWgUOqE6qRZA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790731275;
	bh=gKfxOYH/apLzwRelC6jNqI/7r3wvYJYnAU7oCfzHx1U=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C+5q28Uo1WFIS0ajW5U7zVA7zXMzjCxn0KGkB3xZj5VcX6nX6jq56PoA5fY+OIzdv
	 O+G3oJ27bRvXXa0OXKfd69NLmTKeI7nxs2LM2JaCLYo6P4R51SDbddGeBmFFUhwR0D
	 gXVXU2gN7NU9FaaO9Og6UhFimx/2iLqRqg9oMBvyQzKPcJFvUXdOH16a++ZB54x8E4
	 MnsT7Ruh07U3l7AErez37dR6XS1+UEBn9efe8wIay5+vSUop+fGw/2rMsvesGIoV/K
	 JZ8UxdzBA1R2a/UUbxmtQJHzNn9N7aSrks3DQjZ8Zsh2mvIgmT+sKyp8XFSrlG7Ky5
	 kL+AgF5F9K7vw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B783F6082E;
	Wed, 30 Sep 2026 01:21:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D56124E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 01:21:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4EF84400AE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 01:21:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gT8r8kt319MW for <intel-wired-lan@lists.osuosl.org>;
 Wed, 30 Sep 2026 01:21:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 4739D40098
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.20
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790731273;
 b=bABxxBgPpMUw4OFYnY1zKEAwO0LZabvNxcwo2jw6wPz+Kq4fYRF9rh5o/5HOtzZXPqdw
 bodDbK/YIWR0jtSI3W8qiVhpp7yMWWTUzC3z2R72ds5ch4nkVxrU8L3rkMVxdjFWaNSM9
 +xV+BIJyP8V//yzqUm42MoxzekE+Rp4j6VKRXbNcSod2qFBBOwA3ycB5uBTXSnah4/zh9
 qax9Wznj2mfqTnbY6pcPuhpJCn/dyMf942E4v8WJnmwx9dpjxb7UHCKTSWJZiY4e/uJmY
 h0LGz10o19I6Z7B6HPDDQeHIer2yCcYniLWjES8mTj8LbsHR002AEOdTwk/1bWOkLjQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790731273;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ld-processed:
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
 bh=gKfxOYH/apLzwRelC6jNqI/7r3wvYJYnAU7oCfzHx1U=;
 b=ATcMzFtSAn/62a+/KnukWSVnxWF1pLSayrDAJucAWZ/riEzYdmZy0Eq1LfBnhZw2Mozk
 hxyfcG98IP3EbvTvHHXfLsAaL0egasVveWBOcFDW7ocWjaqXZ/+xhVrxBnHyzCpbeSC7a
 TnP4+TvBGEZ11mEH8eGiwyDtoAimSMxtZLiABgMHafPMToIQ8x+fNzpbo1kRA1ghFEltJ
 hpRSDkJoDh104xkcWtcfiK2zMYqLoVabKN+SraaaHkBoH4ePJNd1JGviX8EfXrgDDl4Tn
 GMreFZY7dMj9gZa62kBRzsW11V/nAC/92jIfAXanXzVcb6f9qpqdZOUb9PMYxSyFGZw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=EO66ErPB; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.20
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.20;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=EO66ErPB
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4739D40098
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 01:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790731274; x=1822267274;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bJf/Uw6v8H/OSdZ7LcAYlW+nfJWN9whkstDa0DUPLXA=;
 b=EO66ErPBXBwJKwk1WZG8LcJzE66bMCBAFC4YDq3vKbsA3qTeVWw8rLPc
 ZF5LgJ9VNGF7AeMxVYsrgBJb+HpSPOg0fL+eBghUc37Flc731fAZHTA2j
 /XMe/Igp0Oghcmr3Qt9U93bdoh+of20imWtLcZBlQhbiwhOTO7qkfV9g2
 WjDzDXPn2te20Y9FgJ/hLWQzdt/6b4REQd0NPDjQ2z8NhE4upe14Z7SwZ
 iisjw6lD8ojixfac4P3NIz5PLGh4lruhrHBq47Uq91VVF+pRcM2fp1MJu
 XVhm45C7cq/iJPtxj/uja+FabJ7NTwZdP+hOVkxuCBim96oWhbLoO20fM A==;
X-CSE-ConnectionGUID: JUPxCGSpRlGDtz/uAbQGkg==
X-CSE-MsgGUID: hBJI6jGsSD2lwI7puqoROw==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90227173"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="90227173"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 18:21:11 -0700
X-CSE-ConnectionGUID: NBexBKErReGXYq+H0EW/9g==
X-CSE-MsgGUID: xv7QXdDJSamU4o36PbJWeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="280298756"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 18:21:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 18:21:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 18:21:10 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.47) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 18:21:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vf5QsCS0Ia68NYMI1QpJeEYEd3ehroZ7JYNNzc1J+nFStpy94wInc/XDSSOMkSy5zi275amxTR/xsF8vUOAAecloZgDjGiiBpP2vVyLC72WufqA9dBkl2mLDw5BbubjgWlkiHn41H7BEO77qQ+aMTO+3WsqPRXdchPXZkmvXk53+Gyw5+xxe9r3iblQqFZ+sYL3+Q4OH1EdgwMiwxYP0Gk71BFF8wKsKTsmGK5n09Jiv192pPDwceNXnsGKRmTUEraRAbHTS7TXm1enPn7KpcCWavpibrWM/TJQmdJpYwo1TUfsiq9KnR4gmJjHGQuSNBitKqnmv2XnsgJ43iZKLHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKfxOYH/apLzwRelC6jNqI/7r3wvYJYnAU7oCfzHx1U=;
 b=KwNB1IwnypbG9jU+BTHjP8bnnDP+M3PI6dme8T0Y5jD3JqBxiiRxTrFiRCOIkTyCKaDRavFuPNYL9XP0SZcF7ECTxmAUL8HWP9jmfWGehzUZy1utkImXd0ED4iuSxgLatL3XqoEp6DElSfzYlMcqrE1v/LXEGir7glUUpnOl+61+FnHjWLMDttXT+tW2ql/I1anJ41AA5p9xGVIXA1+ox2X9reJ6soXQKCcXlytcW1ytanTA7UQoZqqCaD6kr8dTbIhxcbLWkJNOfUNtwYeP1Of1xZEog57j/nmzKel1zUZxKR5SyQRheQvVegOY1tMiIGBhmlYKlZcQu9apId9gzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by MW4PR11MB8291.namprd11.prod.outlook.com (2603:10b6:303:20d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 01:21:05 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 01:21:05 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
CC: "Oros, Petr" <poros@redhat.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Loktionov,
 Aleksandr" <aleksandr.loktionov@intel.com>, Paul Menzel
 <pmenzel@molgen.mpg.de>, "Keller, Jacob E" <jacob.e.keller@intel.com>, "Kees
 Cook" <kees@kernel.org>, Robert Malz <robert.malz@canonical.com>, "Ratheesh
 Kannoth" <rkannoth@marvell.com>, Daniel Zahka <daniel.zahka@gmail.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH iwl-net] ice: allow reading the last byte of the NVM and
 Shadow RAM regions
Thread-Topic: [PATCH iwl-net] ice: allow reading the last byte of the NVM and
 Shadow RAM regions
Thread-Index: AQHdL7UhIz/fH6S5/UWhPc/+uVBbbLbmlGog
Date: Wed, 30 Sep 2026 01:21:05 +0000
Message-ID: <LV1PR11MB8790EB395A631878F050F9FE908B2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260819082458.665947-1-poros@redhat.com>
In-Reply-To: <20260819082458.665947-1-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|MW4PR11MB8291:EE_
x-ms-office365-filtering-correlation-id: 949787f5-0f57-44d4-eb30-08df1e911976
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|38070700021|10067099003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: N6ze8tCggID6n3AiCOKYplvK8h6bWDe++0zKgjfPIHWLnfLxDCZpE+8hPqHWMfla5+umQDw0lUTZkVGyNZToCAN+uKC5bmXsLaIj7iIn/H4J+/UIfPPAXA5tkvUqkvKI3t/2LjSWlZG9wE07MgBiG55Zaxlp+vreLd1+onpekXtHs80qk+wBUzuZ6eGJZ9j+0hCiFyrAC9lurFSGNYyF+FDoF+iRKdreUjTaZKUBicqVHEwwIoMGSBED0o0lteEbwpCDAenPngYo+XG3wTzCtWYMUoQtx5EWhXVksiT7ortY5mm14fn9VBpN2s8jKUb/Lb5pfbIAj43Uf8AZ2ZD5EtqrJYb+MVHJjH1tqX/TR+ZHfRn9/JCL50p+KlujQY42826c7g0a035h3wmSZOlsxUHCIy6+B2YS815PS906bd5EFsq9RGVzvZRjEfzuTfP98rQzTZMKQkArPxqp3b/flTwA5/WrAU3IroAFhERsb5YiEkO2QhtMiWglKX3w2hRj+1i9pYnLMbGwAvh0YR+YNCMY9By6FDpmvjcGbmDPxqotMQDkgRgYjXAegnl338UIxUTqEAEm/OYcJD+A6VhKmEBEBc9b9ZWKDQ3RIgoUcPTw62gYQ2H1PxY0vXWVsXJoeHE2BN457U/rn12j2nSMxyzcJZY5W2aK9TjI5hpntUURHM5GfcE6LEjhLOEXxMzkvr6i/OdQtxAADQFS0j0gscrTaDB5GsH6nZNt6tFiyxA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(38070700021)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E5dmBcAcxcdnuUiQZciChiNTWwEA81RtEJFSAU9G4fJYGCwOyiSLvJZpsogw?=
 =?us-ascii?Q?BSdYsSTdhuWuMo8ePtWW6FNn0p24fwXjXwEk5UstQHHr8QPYLWQM8OpkE6Qh?=
 =?us-ascii?Q?L8VzXoB0/B9PnPqwlpcaH58xNy+lnnWzdEZkbyhyHEWUO6wsrS2sl0AMoxEO?=
 =?us-ascii?Q?o8ef8GeOQkk96l1fHBuSgeLApMLKu1xoWV4V2JIcOvyp8YOkZeyQO+tRZwLc?=
 =?us-ascii?Q?Uj01WZiHjnHWZvbk+ietBFOxwDdegJuiRJ7QGuuPlxpKFcX1hTv/aV9fQwLM?=
 =?us-ascii?Q?5B+5L4NzRSdQy2OYT3mTlMbySv8nzqlHXy4RsTHmrw5FWbvxFkEWXNDtiCCW?=
 =?us-ascii?Q?Byu79jSSORIbbe90gCiMrEscwMGTSkvNia6tiqccTUis6gVutiGLQ0SdkWNx?=
 =?us-ascii?Q?prkCSFsfEGbpS2WCyT/HzBHY94mvPyxvpQqiBae72rsRLmrBjdHRloMfl9R0?=
 =?us-ascii?Q?evT+3N+O76MaA+C8cpOd4R6cStcCn+SCiYCFYCXYKMVVA/RBxYJQSwitKhI5?=
 =?us-ascii?Q?WY682lii7eimXzA9h74QzTt1lNc/xzMxgGugWFwqovxTEGCKT5bztqPm8wDI?=
 =?us-ascii?Q?PjzC2KzlAtaweBYWli+hDioWsbtN9Wp2rJauB1xGEM8K+W/rc5topguYNc43?=
 =?us-ascii?Q?zCKt9AAZhZNQGaW5nfdhRF7PXqMUWFrZV9chlaRg9ZW9oCZ4XEM6pVK1TPzb?=
 =?us-ascii?Q?Cb1w4jeL85PRQiu7yPbzFYg7zcR0NaaUq4QQvOM+/L2aBZq0lmPXdUs6lBvJ?=
 =?us-ascii?Q?D1APRGHysxsAIfYXgBghPm3UhB5LsWaPbhaWoj5tS2r3jUAIN8OTsl2uI1Vc?=
 =?us-ascii?Q?NZL7BOSO0TvlVzNRjWynNHOafwbdHhO3FJCoOfrrzIPVz7HyxrJeUHe4kAVQ?=
 =?us-ascii?Q?M3kgpVDswdvKIVVRIWl+D4aWHw43crlC/+j09whXrGBHb/TKiw1hhQnjxZ2w?=
 =?us-ascii?Q?CQ6QlxnERb6Q91u7CwgBOBSq7iVEJpjCjnBihFF+7nNrg14VweI5qb8w83FM?=
 =?us-ascii?Q?xXrIDX73Sp9oFMJ8NE29e7ACEKK7KUuE2xggQDRkq5xELcqlrpvrkWByWXL/?=
 =?us-ascii?Q?bXAhSWlej/Fqw5utkNtvxGOKb5NVcK5JlfA1zAV2DeNumX78AUPTWCk7ww61?=
 =?us-ascii?Q?r+HcpXcEN2KPAXBFwtwUbnBN7L8Nx7nHWVbPajA4hd4A9KB39HCOeNwqIeDR?=
 =?us-ascii?Q?CL4czcTGlAbmizD40zBHMedNRtnzfn4S8ibAhgYRb2JcttKvxG0XFQEy1DEH?=
 =?us-ascii?Q?DOcqayMfCsIg8Sx49fzud1qugGGfXeT7VrBQbCnj5s/hbjVFENfJ1mzcvDkb?=
 =?us-ascii?Q?Xyz0e7i7pI/MSP+UXmVACCr0IkRpRn78L9scCg9lmoqpmVSmWMp66aEEinXq?=
 =?us-ascii?Q?etBUQauZmzK40Yws/0TpWxZgAwdUahK4IclMQLxVZg+WNs+q5cGKKhvCq2el?=
 =?us-ascii?Q?onnlV5T0Ono7llVdSt2N7GCzbJRcueofKeNYzrzEDc7XIyEgRlCoU8DVD9WG?=
 =?us-ascii?Q?9uHxcwDvJhFznUPTy9g8vdg4jbGVVlLUxGA3h+Yzl4od+2giOWD1Sr0+B6LF?=
 =?us-ascii?Q?RfGvrDjukFZgJTO8MTqxF2L3+eShnE8RVk+U9l7DXZLPfJyjJanBKAk9+OxY?=
 =?us-ascii?Q?jLE+f1k6dyI1s1ShgBV10DqdVZztcvgf3y95FF3DTELHxy/6TLkLdWWk1xad?=
 =?us-ascii?Q?gBlUnSvXzJjLlu/gwvR+HvTAI8dUI4fDS0fLpECjhzGNBEjR+Vhvsj5bXYyB?=
 =?us-ascii?Q?eOMUVVAIXA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tw7tCJPhah1QI0GAUzsQGqbHg75GFbO15lH77WhyMioc2vInQXedSExIZ/QSmOn3PSb+kuFV/wX6pc/DTmC7p92+IwYDXWuyhrc4wrnS3HS3ZK3QW7lH2IpvOSkkagEj+3mg+DrKdDyCf1rlouU5I4AN6B9OhHMJPK1ckrkW0O5U4ScVRTjraklxNuhzYKFDI9rTVbvwE66Fc4x3S6JfQmDV7Lb94nhslGybXxg7wemXLtBP/lmxHNOfNxUbR21Mj4nHdtRhvymg5uu1hNVYoIk4G0C4x0WZqjOntrE+l59g02/8bi5u/V7tOq5M1gNtrjtyDCyYMdFobHibIzvexA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 949787f5-0f57-44d4-eb30-08df1e911976
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 01:21:05.6172 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uf6PJvCcAxgIp3Toz/kBPWoRrU1RzTxFgEBdUfC0PaxBQAdgBxTzCaaHQrLqW2z0GmZ46w6Q9/lGIm2B9LA5niEAF6uN1c9PqyFfWWsl68w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8291
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
> From: Petr Oros <poros@redhat.com>=20
> Sent: Wednesday, August 19, 2026 1:25 AM
> To: netdev@vger.kernel.org
> Cc: Oros, Petr <poros@redhat.com>; Nguyen, Anthony L <anthony.l.nguyen@in=
tel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn <=
andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric Dumazet=
 <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabe=
ni@redhat.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Paul =
Menzel <pmenzel@molgen.mpg.de>; Keller, Jacob E <jacob.e.keller@intel.com>;=
 Kees Cook <kees@kernel.org>; Robert Malz <robert.malz@canonical.com>; Rath=
eesh Kannoth <rkannoth@marvell.com>; Daniel Zahka <daniel.zahka@gmail.com>;=
 intel-wired-lan@lists.osuosl.org; linux-kernel@vger.kernel.org
> Subject: [PATCH iwl-net] ice: allow reading the last byte of the NVM and =
Shadow RAM regions
>=20
> ice_devlink_nvm_read() rejects a read whose end lands exactly on the regi=
on size, so feeding back the size devlink itself reports fails:
>=20
>   devlink region show pci/0000:04:00.0/nvm-flash
>   pci/0000:04:00.0/nvm-flash: size 10485760 snapshot [] max 1
>=20
>   devlink region read pci/0000:04:00.0/nvm-flash address 0 length 1048576=
0
>   Error: ice: Cannot read beyond the region size.
>=20
> shadow-ram behaves the same. The regions are created with those sizes, so=
 a read ending on the size is the whole region and has to be allowed.
> ice_read_flat_nvm() uses > for its own Shadow RAM check, and so does ixgb=
e, which grew its region support from this code.
>=20
> Fixes: 3af4b40b0f2f ("ice: implement direct read for NVM and Shadow RAM r=
egions")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/devlink/devlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
