Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B613C79F9F
	for <intel-wired-lan@archiver.kernel.org>; Thu, 10 Sep 2026 03:40:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4CB6840862;
	Thu, 10 Sep 2026 03:40:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id usiaYi5pjarF; Thu, 10 Sep 2026 03:40:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 19A3A40857
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789011606;
	b=CCl71JdNIBKl5U2MI3xmZ7NKWWacd03FqL13lFvMAxzXK+L+a0Tohb1t3vfcX2vhxvVu
	 s7TaSEvmlN7K6xVsuJYzPv8PTiDa+YG3lVpl50Vtj5LweW4PvhnIJSTRwQRlcdFHyEKVg
	 E+125VMb9b0yRWACAwMxcQ5l7nKF5NObjrqAy+8DgIWxQwE0SxxNwbwbHlp+MTq9PO9Bz
	 FCuI7DdbivZ9gSLvHCrr4dsTSpPhJVmTlJSC0DU6jDoRoS79lGFsZY5oaXF1rmwq7HZTC
	 +eFQ+ZmsFpjA47MyflNigkteBMBhWHvvCdmvD2Dqp1M1kCMCgIXI10IofkreTGvUaAQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789011606;
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
	bh=DziKIxwX5o7gOx7ebEqyUcUq4wKUBOhOQciRiZNkj1A=;
	b=g+fBZzJDVwszeUhzdKQk2prVG8/UsXHTylu/HhhMxtaE8hnUypnPuIKuc3N1TNPqnvEa
	 mJ0rf/aYIRXUfVpyzzkzrKDeHCkSCc8YydWWIqsYHiuaDl2oh6jSOsNwet3iMrmFl42jW
	 e2gqIBS1Y4xVwqDrLZHvaHFrcA6u7XeaYUQH1kA3l1k5qeQUlW4HJzf9McgxGa5g4XwUb
	 WkWQtD/2hkk9HwRJgPZyPF35+L6IdwKLoq4/jTk5CP3IpavpfczRFKc9grFI87OxH4SXE
	 fYxqtgtFahiJNF/kIktWUYwTscUnrj4yjvGeV9Xnfc2gFajy5/479mLB7Lqr26XHbow==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789011606;
	bh=DziKIxwX5o7gOx7ebEqyUcUq4wKUBOhOQciRiZNkj1A=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V43z1q5I40MrM7qmUdCaBp5kXnVWVPBhW2ul82k9h/SWwaEtdfyUguDmxY9TWXciz
	 Xr/CWHJug8bAfwNfDhIt/IccAnMEgqWTCfCmjaZQd0nXQmd8TqiuFx0E/2CBl+gc54
	 U6R0eZ3oLSuR43W19W8lUiBQqJtHE42nyc1ohgWxNVdT0m2cKjL+T9zrP9Fy6RkM7X
	 iekDnchQ2p1rQYD1hgIDHZS8KnBr7MAZf05cdMbVFMpZsyg7X1S/mmNNwqfmkV1IXD
	 GvLiNp+T7ZS0r1tH5Wi4lQyf1K7QBdezMJHB2Ud8Hd8p65jDhwR9Jv7lTzQ0O3N0bM
	 vSwkUudFY/TGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19A3A40857;
	Thu, 10 Sep 2026 03:40:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 57F0E32F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 03:40:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 412674007E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 03:40:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KUGToDSJ0K8a for <intel-wired-lan@lists.osuosl.org>;
 Thu, 10 Sep 2026 03:40:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E2D854005A
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.17
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789011604;
 b=l0bskTJyJK9SmlYSDienSQtZhRn6NGLWx20DsVRHgdgHxoNG6VelKQWKhWNBq+L6O4x2
 NYOYqChUunsQkK6odJ0l5/llJu9Nrc4ZOBedIDwrxFr2Po2yAavBzt3l1++p1bb0qOxy3
 kIzCLpmS25CpghWctIfk/jH2QfFFBHieTORGXBoFuZK2HwYJvGXrHxvmp4SmfDytj0ISI
 bjqX6jnnmD1BeEP3FRiIsgN+syBj2MIjxhL+y62hpkmZpeLMoEg4jKkrf81YfPJQshU1c
 IinRurIlhcdfxouHcQ5ItnqwBCm+iBRwMpj/UB8M3PmNEz6+InCqjRBq1r9N5vPNXHg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789011604;
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
 bh=DziKIxwX5o7gOx7ebEqyUcUq4wKUBOhOQciRiZNkj1A=;
 b=mfxo70NjwPbRmMY+G1z5S/nkAJvnv8SgGn7kcKyBd4s/Pp7wqo0b2pCHl8wmU+jgMomX
 DIdQPFBg2RZw0h+W3MTok1AVOPE5yplf6yAvKsIh0k68iysoluVnN0Cr9bNVKl/Nm4tkr
 wtD8hehqg9csnfZC0bvOXj6L74f4jt0epqPtwaLQOYhn26Dqbq7y/iaeOKp8dFFvl0dL1
 l8/siLC8Bj+Bcqgjg4E3Skwya5NCsR8XMmhSjid4rPwkvhu7VHtD6ShXPopneaQaXYdH5
 dz3RW2f3Er9Cdf1QAYhXbWA7SfYD5Z3csqypvOyeQlEH5w9kGQv6SFkD8Gt6jeyqyJg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=n+AOx3kx; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=sx.rinitha@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=n+AOx3kx
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E2D854005A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 03:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789011604; x=1820547604;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=o2VK52HpqNc+WJUPK3KFRubx/wTlyjKNABixmnFDJ8Y=;
 b=n+AOx3kxHe8lNdhuTeOiAI4M/QpUYkj6vu67plEja/s0ybBYaaeGo6JK
 5bWZ/p0ZO4GOuMXWYu42tHs1o2dxZhWTdRIwDmQY30ovT7wRgQOGRQqhv
 PDfYxQtBC6Le5ONH5OYsH5kCb+bpfAzFoGRr79v/VLAfx5z3Sgzakefl5
 ONVhozqDoS7hzsPNvREerdNd1FFui6M9oYhtz9FAegDYdG2j4LQWzrehn
 DYTQtQYXtqFwUCD+fjRLA2hOEozAwQYhIjA0dwqvmAqZ2XbWGxncmvQ+x
 izDqMdkSRyMo4xYkxzlzlkJTfPqlXuQHabsMCOXbWhyZZvEZLEJeUxizt g==;
X-CSE-ConnectionGUID: a/x2x8ywTxuvWKsVKvlu2g==
X-CSE-MsgGUID: 2ZTp1hLfSEuhCw/JZO+2dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89325120"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; d="scan'208";a="89325120"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 20:39:59 -0700
X-CSE-ConnectionGUID: 5hue6rOTTHef6CxdaPuYIQ==
X-CSE-MsgGUID: DAHJERe7SaCKkI6Dj0cjYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; d="scan'208";a="270158952"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 20:39:53 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 20:39:49 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 9 Sep 2026 20:39:49 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.71) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 20:39:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBzeBqM2gTCFMgt3IBBe38+ia+pS2OhuoXwJNl/e+lly6x/cN7RjMoBI7FIURIYpf5tfFvf7rCdInB45pex1oPDB2ixb/hhCg1/4kvzRWBd5T5hgVPTQSskBxl6vpf5FhCSaIvNszO/11BM0f20VNpT+jP94E31vskF/0Q929zNCD4ofKkL9OthvRAST5h1VeNjbAr4o5fSOd1Zn5ZNmL+lgOaLg9IlCotczhs7BEXr990k1M1pbzkJ6KDITZtn9yG3dyj1UJTA6tGDOZRpA+2kmADMQiP4orCXUfpTuwkvYfmnjfUiy1kyW+cWtpEhteJSCxUer4BKAV6Kql8MuoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DziKIxwX5o7gOx7ebEqyUcUq4wKUBOhOQciRiZNkj1A=;
 b=DnaFSb9ZRE3yDrVEs5vL6uqA0tvYfSeLjrZv+aOsL1DenjXZvVICDN5gmBD8TSq9vWyrA4JwUzkNJp9UbU1/i+MAQAWQR2BUbJh93tfidJh0Be4QnZxjcHK2uJ/t3b/P+wWnXj0FWWHHoktDYEPpAz2z7Pfn7R4dUMx+6im109kFkQyl34PKEmEsUOOaMOKlnSL60Pgp6pw72AsMBTWrtpyi9r86WDTotoJ8PyFSbOM++/k96DWj4A+HeNPtemxci8jE+In9T0e/eWEHSbJWzwNDQPDkSlpVGtrZcaIYcwfWHwsOdKuaUYm5Zd3yBgHIp4xRNmPeJLmr7mdS5MCYCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by LV2PR11MB9538.namprd11.prod.outlook.com (2603:10b6:408:378::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Thu, 10 Sep
 2026 03:39:40 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 03:39:40 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
CC: "Vecera, Ivan" <ivecera@redhat.com>, Alice Michael
 <alice.michael@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Eric Dumazet <edumazet@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Martyna
 Szapar-Mudlaw" <martyna.szapar-mudlaw@linux.intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Marcin Szycik <marcin.szycik@linux.intel.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, Simon Horman
 <horms@kernel.org>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v4 1/2] ice: skip per-VLAN
 promisc rules when default VSI Rx rule is set
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v4 1/2] ice: skip per-VLAN
 promisc rules when default VSI Rx rule is set
Thread-Index: AQHdDtmI0Xq5iS1pvk6EOBK3yUUWiLbHjX7A
Date: Thu, 10 Sep 2026 03:39:40 +0000
Message-ID: <IA1PR11MB624104E0EDBB194323D6EFA68BBF2@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260708125755.706263-1-poros@redhat.com>
 <20260708125755.706263-2-poros@redhat.com>
In-Reply-To: <20260708125755.706263-2-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|LV2PR11MB9538:EE_
x-ms-office365-filtering-correlation-id: bf4d71b8-61a0-41a8-e327-08df0eed2539
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|38070700021|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: hryRlLXcnsoT6v56LOt8KxZc+3P3bhl1EFnRPcIlxlMHvlHTg0gvn88Vuh4v+rOz+TPJ81UReVklCN3GQ5wMsR7AbyiOUJxXcTpm1u3Gl4/7w+d6v41+B+Mz51/4MxTwrJEm1zKRKkrbEyC+hkYTCPfkTmPW+uJmPPNoZvl9ckA1FlkFQ8F/uH01zrAhv+TUs1qaHfibwIB7cIXBCs6RYUy2Tcf0Ic6SGJIjlcXrXpJQ7S8Dcfoc7bVLAFv0V2pDBrTag/ilvqRXW+ffNXC+5raT01+y2L2UpJC5ONCzK4aA1jOuSC4GHAMoiFSoWsrB5oHpGjVDhWyGEwC63aYnJOs51PyGZnDttjz4N28yiJzQNb0a6HdF1OxI7HU7e6MJIHRKGD/c5K6BjpAwA4OThScrkl9LRtwWNfEbVNlDOV3H2OlW/xDMmXqpx1rqa62PxUoUPOKDvp4zmjERWIbljoKg+8MAnY1kwJiCyTfXmdq2l3YHMAMaQIcX8aMoLCrOCEr2ns8uz3o3+YrrBY86O+vDTjQSrm5bWsw7qLXLFJ7Xsb9ZEHO6aEhA8ANLnzHYC3oeteMU+LvvhcZZRi5lKtY+XVukojPC5wlVufXSSGiRWpWRUwUtZg3QXnit6fyRjnWd6cHenoA43glZHWPQBI3nyYZ79D1O/ZVsmfO6uRBexyqToB50xcscXKzH4PRTqTlW/DNAmRvieUlyHC9CsG9OuZRueYG0/Of1BzWH1Nc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6241.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(38070700021)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uZbOnIeAqthIfOz5qfKBco5P1ZGDgWI1P/stEz7aZ4bslNeYMTWoJSEYBbAP?=
 =?us-ascii?Q?1VGLIJ7qsy2VuekKeLHrLuL+fPi+eYU/e5g/Xj08uy+WhZynJu3Z+4Wk+wRD?=
 =?us-ascii?Q?INzmsS99c30XkkrkVqxxTbeLxus7H/TMS01XEduXfeuYoFR3zjF9Hwy7Sc2p?=
 =?us-ascii?Q?JE8VLhvSv0MLey8CB92P7OW46c0dEH4BWRK4U5kFg2egprBOV/F4T9G6+O91?=
 =?us-ascii?Q?we7mNbiHtx8c2dA3MQL+vS8n4FVYp/f7tSwqAHOREDDogDzt3rpo0EdYZd2e?=
 =?us-ascii?Q?qs7HRAnUaHTkBl5YUodhQhijF3heDFkPaoxys7RWiqm8tIhmR5WEkQfozJAw?=
 =?us-ascii?Q?xZ7NOyDrE/nONX1HyjUS5l/k16A6sBuLlL14ydQXK6WX55pGYVqHpmKgwwS7?=
 =?us-ascii?Q?CweJPsDfkOvWOMZ658YyDRxtgcmtyhus3IiGWghb5VF4GTnKd4L91+7U5by3?=
 =?us-ascii?Q?YteWFWcdgKDK2SsWl687Dulx0iGdJQKg/9xUyv3eDxkYPWhRTfEvroOp9UKS?=
 =?us-ascii?Q?fDdtDY/4SqB+UIPrfZvPEm8kJkTvafJt04xaM7eHFtyDKte+BQtQQU875B3V?=
 =?us-ascii?Q?TNtgYht8HahdApBtUrrl79pPiZ6oJAaa0uILP8O0WGsbaao8/55t3UhjjXo/?=
 =?us-ascii?Q?Po7rLG/1XSgpHzaUlNHv0CTF1WwnD7O4+Q5rZmqvshU746Xocki83CCkO3Xu?=
 =?us-ascii?Q?CTfBoVxEzbkmDj8uzjexTtcZVL/41CjuswSrv7Be3Q43wbBFJ6fWVoQBPl28?=
 =?us-ascii?Q?lXGX3ZFp7Vv0BE/tSuuQvE+J3C4tQ8hC5uw2ydcXEdUpUhTxNY4IMmL+QByZ?=
 =?us-ascii?Q?ZMZKD0VEL3eW5CgCMnbAMJ1XS5LRtJNNzP3i9AWV6IqdkNCHo15qa9mWMbAK?=
 =?us-ascii?Q?GpA2T90SYwxdAniw6Ak2vp1z/Cds6xZcYsGvr+X/Eb1pdsMF5Vp+aJ8aZpLg?=
 =?us-ascii?Q?Y+xrpU7JR4OOMZBizT6nufEst36TIy7wZEsUcmbWUgzE0QyPwEiAFLdc8Zy+?=
 =?us-ascii?Q?Vxi/cuKDZ+dT22+kTGOCANgA+0IRvvJuoZwb/0O8QxtEyHO2ikWmrrwYCKJe?=
 =?us-ascii?Q?UhM+9/D9z6hgRDpVFyYhawz/cdIinkVmiil+fd95uWpIyivjGXgJ2V2APuFd?=
 =?us-ascii?Q?xay26oy7GVGndwgTFEl0JKYjZzZXKfsvCTOxig99CJqV2BXshV/NB4HuqBKY?=
 =?us-ascii?Q?EIfnwGyKlYEdt9iAjURwQSF+w5HPkacRyFXX/9hJw8uAKTTuiHf6Wnc2y0CH?=
 =?us-ascii?Q?rRpjAhoev0JSy5zrFmVRT8H9h2CCqaZ3hRUbjdYsoVjZSvJRNqCAJPfjc6NG?=
 =?us-ascii?Q?HueZCF3BU7p5484MZ6jKMFF6nsxVKta4UKGjcf25jaEjasX5khh98v91mu33?=
 =?us-ascii?Q?bYRrdZH6eobr57yHshCARYeB53xJtsnhF/MrN6uzhPzZSr9TOlGatCJT0dka?=
 =?us-ascii?Q?CWApH3ARo9rvdR5PMRDglHnCUqmlC/b1ZAx19qlwXxz4Vf18/Najhv6IoanL?=
 =?us-ascii?Q?LtylNYpRaB1SPL3KiPWL2tLX56aj5Si5Pyv05iJ4p0g5afKR8VE08pdJmzzP?=
 =?us-ascii?Q?TWQfnrfjqNwMn5d9INLr9QB/rLAzFoBKBbrJcfCFHQyWZTetaHztBQcs1pHY?=
 =?us-ascii?Q?oldmD4KfKbpLaN/ltzaOyniiieYuRJ7nq1m3+qTE5jRlDguph/8Kp6G44j61?=
 =?us-ascii?Q?r1jQSCeFwJT5BqiZ+ojnmMndZYX/i33etee6ngmegtFQH9YY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JFuIz9BOVX+eaX8c4PpwmwFO3DhClB6QPTIm9eafWPT02k1TLx2nTHLv6P5IGB3iRm9nbnbNgpl3oFqnU19mj0qKb8PvJdoRyo211afPaXgvA6uk/ORpGE3z8mE1U76Tg4FDv6ETOrH0aDer2PEqqITXevAqJtXI3qWZ02XS6yUUPykzLHv9fCSa31qK4BPue0UYa3StmZtSIZpBT6o+3l20DCI+bU7aaA5yWC7ZO+Iw3jdnRC/ITATFEsVowjblnfr5e6C/IRGUpzLvspkjSmyZc5eJDe/bnJYkWs8a6Yn8IzJrzoWDbp+zxLW3BNw+hfgC1SyEXdGdthDpwm0mAw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4d71b8-61a0-41a8-e327-08df0eed2539
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2026 03:39:40.4169 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ug7ySbz0rqdoo9sRoLIF5WxexB5NUYej766aJJLo0A+p9V+YBJckn2lkSNtioNCLO9Bvx6hNIUe6uKkJUeeOpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB9538
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
etr Oros
> Sent: 08 July 2026 18:28
> To: netdev@vger.kernel.org
> Cc: Vecera, Ivan <ivecera@redhat.com>; Alice Michael <alice.michael@intel=
.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Eric Dumazet <ed=
umazet@google.com>; linux-kernel@vger.kernel.org; Martyna Szapar-Mudlaw <ma=
rtyna.szapar-mudlaw@linux.intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>; =
Marcin Szycik <marcin.szycik@linux.intel.com>; Nguyen, Anthony L <anthony.l=
.nguyen@intel.com>; Simon Horman <horms@kernel.org>; intel-wired-lan@lists.=
osuosl.org; Keller, Jacob E <jacob.e.keller@intel.com>; Jakub Kicinski <kub=
a@kernel.org>; Paolo Abeni <pabeni@redhat.com>; David S. Miller <davem@dave=
mloft.net>
> Subject: [Intel-wired-lan] [PATCH iwl-net v4 1/2] ice: skip per-VLAN prom=
isc rules when default VSI Rx rule is set
>
> When an ice port in a vlan-filtering bridge goes promiscuous (typical for=
 bond slaves), the driver installs a per-VLAN ICE_SW_LKUP_PROMISC_VLAN rule=
 for every VID on top of the broad ICE_SW_LKUP_DFLT VSI Rx rule. Each rule =
consumes one of > the ~32K Flow Lookup Unit (FLU) entries the device shares=
 across PFs, so a wide trunk (vid 2-4094) over several PFs overruns the
> pool: firmware rejects further Add Switch Rules with ENOSPC (AQ 0x10) and=
 the DFLT Rx rule itself fails to install:
>
>  ice 0000:5c:00.1: Failed to set VSI 14 as the default forwarding
>                    VSI, error -5
>  ice 0000:5c:00.1 ens1f1: Error -5 setting default VSI 14 Rx rule
>
> Once a switch context is overrun the retries can also come back as ENOENT=
 (AQ 0x2), which has misled triage toward a perceived recipe binding defect=
 rather than a capacity issue.
>
> The DFLT rule already catches every packet on the port regardless of VLAN=
 tag, so the per-VLAN promisc expansion is redundant while it is installed.
> Skip it at the two sites that drive it, ice_set_promisc() and ice_vlan_rx=
_add_vid(), keyed on ice_is_vsi_dflt_vsi() rather than the netdev IFF_PROMI=
SC flag so a failed or LAG-suppressed DFLT install still falls back to the =
per-VLAN rules.
>
> IFF_ALLMULTI and IFF_PROMISC can reach ice_vsi_sync_fltr() in separate pa=
sses (a bridge join sets them through separate calls), so the allmulti pass=
 may expand the per-VID rules before the DFLT rule exists. Drop those now-r=
edundant rules right > after ice_set_dflt_vsi() installs the DFLT rule;
> ice_vsi_exit_dflt_promisc() reinstates them when promisc is cleared.
>=20
> ice_vsi_sync_fltr() subscribed multicast promiscuity only inside the "def=
ault VSI not yet in use" branch, so a promiscuous VSI that finds the defaul=
t VSI rule already present (owned by another VSI, or preserved across a swi=
tchdev session) ended up > in unicast promisc with no multicast subscriptio=
n. Issue ice_set_promisc(ICE_MCAST_PROMISC_BITS) whenever the netdev is pro=
miscuous; it is idempotent and returns 0 if the rule is already present.
>
> Fixes: 1273f89578f2 ("ice: Fix broken IFF_ALLMULTI handling")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
> v4 (review comments from Marcin Szycik):
> - Reworded the ice_clear_promisc() and the per-VID cleanup comments.
> - Flipped the ice_vsi_clear_vlan_mc_promisc() guard to an early return to
>   reduce indentation, and noted that the clear is best-effort.
> No functional change.
>
> v3: https://lore.kernel.org/all/20260701133601.2118382-2-poros@redhat.com=
/
> v2: https://lore.kernel.org/all/20260622113428.2565255-2-poros@redhat.com=
/
> v1: https://lore.kernel.org/all/89efbea9831175e6f57e9fe8557f7a0e48e050b7.=
1781786935.git.poros@redhat.com/
> ---
> drivers/net/ethernet/intel/ice/ice_main.c | 109 +++++++++++++++++-----
> 1 file changed, 88 insertions(+), 21 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
