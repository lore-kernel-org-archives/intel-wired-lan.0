Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2FACA9ED1
	for <intel-wired-lan@archiver.kernel.org>; Mon, 12 Oct 2026 13:55:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 445E5405A4;
	Mon, 12 Oct 2026 13:55:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IoomoI-SkgeB; Mon, 12 Oct 2026 13:55:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3AC76405AE
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791813328;
	b=pP9yrCyz5aPSA+c21y4hcY3b7W9cr0EL4omBsEkwHgYh1ZjB79OK1yAi4OnDQWMDQejd
	 1MjdsKgZ7P9SC/D/zw7MnxDXAMzR5nkNoZb+mWQu+dtDnD1+NS91bXKWmYXJwRRM7ZKn0
	 +e6EX+H9BKorag4uhkYBsyCmyOc+mZWgTdYtprdvXD3sFVFRTcKzoMxn78Fd7Tpv23WP5
	 RipyGHMBSxvxCS0wVAqHf6p+/UVX5NW95Tfoj7bprusgoHFOrzK89EBFNVHo9JgpxErJc
	 NlL2JP0IgzAHiLP402ka/n0oYYlE4FEL7OaCVxRZimcf5FaDBurqxjY4smU5qqaG4vQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791813328;
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
	bh=/OD8UNqM+akCJTHwdlfz/VXV5WMc+j3i8v2m6Fr91R8=;
	b=Nr4mb6dJ3VBrJVcPLSfy6oDjIvAyKF62CbA4maYRzqMURlRCjqBygfQ1RtvyXEyYW3/J
	 OwMwKUzn2jBuhqDnJB4CWp4B8HC/FDng2NQNi6h2bUOQ2OcpIc1Mfl8lVg6nCinNta6/Y
	 1ymoC5BGUCfcMll1+EiTfZ4DOj6U493Zahduehx/G9vUBabD2OuthIsPHUM8VvQJ22aM9
	 J5Se5R9UTR3OpWWUq1QT699n1O/hkdSe78o06ErxbU3OdYRj4neS1Yf3YofjewwNZxFP/
	 OhxzYkg1y1XTtGYsel9qWQcKunXkFN2ELz7INpqi4yDM9aZjrafStfL3aQGZ/MMAqBw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791813328;
	bh=/OD8UNqM+akCJTHwdlfz/VXV5WMc+j3i8v2m6Fr91R8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EpPOQV0krLWbtKWne1IhMvSL4dAWNIp4se8KqQIQcVx0de72py0HVtcbZ7Fjs69Vd
	 yntvLxpC8zAT/4UupB7nUp72nAhRXg+Qm0IqzjNfCj4C6WY3No/3kz1KRFTBFJL8vA
	 /1wngpZk8LAskc5c941VzwG/S7UXvygaa7US1NLifO7gL94Z2WAR48uJtJp7EfLe1I
	 PNxrMn+OW04DOmA5C0qAIGknDTB0Zz4Uoc/RliwZRxtohYaCLwQ/1xGwdoXv/3ETNT
	 QHOS443ObYGEgYOrwW1T53o8HAJgfC0obOC8k5TJ2YrD3ACRFiauvg2L9wpRIPPa9C
	 514NeBHLr+rBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3AC76405AE;
	Mon, 12 Oct 2026 13:55:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B9F882E0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 13:55:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ABAC060678
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 13:55:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2aeWQDbq6PlA for <intel-wired-lan@lists.osuosl.org>;
 Mon, 12 Oct 2026 13:55:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D9CCB605ED
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.18
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813325;
 b=o+pMjuFeiZf/sT5XYk+H46q06LA59GDNgftPVCoaGx/A2X+bmDPofXzkiUxC58ZNN4xI
 8CVtn/tlzeJZm9ODVJusvdPWHqcs+4Xh07RSXs27Z632LtB1gyNuVgQaug4biFfzK/atn
 GTq27X5ZYxu3W1TUVj0ZOyPxteAkdGBD3sn61WETpLmYn7AQdqqLgoagjH+yKiUmbvOJv
 GuOVP71uqfifERhnIGQ0BPD6dKmTORfcUWbK20rc8lyoGmzGQHaM/yCaUA4ruGqtmLcOZ
 LKKXnezuE4RznbcbAIlMpbAlXHDfr3oAz2p/0lCCV8VQaGoCOhl87fF61U1VXz3WOqA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791813325;
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
 bh=/OD8UNqM+akCJTHwdlfz/VXV5WMc+j3i8v2m6Fr91R8=;
 b=LI5hRZUDh5AYawC8CeVhnk2n9z/6gBsNXuIvbbthKchUrgYq/4Fh7nFPv0sUpbZDm8n9
 ijmMqN4GAw1fJ2+qDvxKBCntIv3BUAXd9FfXsHFavBrZUm3VMhLpL4cvwrqR0qV0+cvig
 EMdRA449Unxwpsi2K+eXozxa3C+QkQwdiKFgRCQ578l0J9d10UklI+3xTe/+vBcxDju1x
 zx9GljryUiqkddPPjehbjjccrBNmJavbg7Fiq3IAMe/uyj1XSaz9swvYRj/qoz1Heq+9w
 /vN1Gex6w7mrtvdTAHP842kpy5qPaUP1jBAFz6gmBfMuXKcdM3z2WYwCu7iAUSwTmXA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=MiNCx0hP; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=patryk.holda@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=MiNCx0hP
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D9CCB605ED
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 13:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791813325; x=1823349325;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TifP4SUPyr6V9CnoHy2kXtPil8Eu9yuh64rqRB5zCdU=;
 b=MiNCx0hPFY5leUsUnH/q1wsn4nX0yUQrn44HZVrz/dfZiBxPKXdWbaFe
 pmcl9oWCf5AO1dKK0dcU061+QUEWS+IjaRuqDNHlHF8sEO9E6EhUivaCS
 1gebpNxJJ17qfWypSLw0WZKivHzxgIB4oQER/8ZAwvMMaKi5q1GlGoB+9
 iBFsUJd3XQUSTHu6dLpg4fxS/spKyvUqh0lYMLFaBseVUpMykS1T5yOuh
 JJ+01OVhhCI/uE7MWD99GgxCNTa6fFaJiEY9+Q+GJyxBaFhmMRKiMvBPW
 5NiHnbIUeRvpIxKTE0URAlLkOMmnPI3gOw+73zdOroyo0KO9iFxiBcGny A==;
X-CSE-ConnectionGUID: PXKs9A17SCqfOnS1Y/PzrQ==
X-CSE-MsgGUID: nK6jbAq4QeOJbNBWNra78w==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="524211"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="524211"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 06:55:24 -0700
X-CSE-ConnectionGUID: Kvd8/YcxToSNVxJSmrugFQ==
X-CSE-MsgGUID: 4Ux44NmqQzGC1C6A1H3ODA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="1359455"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 06:55:24 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 06:55:23 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 06:55:23 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.71) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 06:55:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hlElvj99bIrL/OLuHWr5PByKcEj3sgV1e9Sn/Zp6XGq0/mXtREjTDmCWaA/px05Zy6QgMbb6JK4BMteqlK/ZTdMHrIs6t3yDOm9RAP3CfrWWAw2pal5ZdLRLr2bbItEAiFrmiT89FJ3DRz8PiMXjrS5SWG6JTTUkm0qUhqft/EUz6WBjswGXWzdUFtwLTi+/hOipoLhvr2+p/WziHGGn7GxQ6qUoeieUoiDM127f0hPxIR1gL+3wREoLIw5l1E9N/iu5Qq1a27iK7OBld54JIdUGlEwvbqQYFFssgxX5A19HZ3YIY/NTJqLOGjRy40OkHQsgtMbtI0EU9FfIAbSWxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OD8UNqM+akCJTHwdlfz/VXV5WMc+j3i8v2m6Fr91R8=;
 b=W65gBN9Dd3RYcVdqx05mp4+JVQJCi6s98UQb1TZrP2j85K/6DFg4eTHf1qNxKdNTdF/h7BES7Kgx6fgMCzycP/gHbYuHk+UlhH82o7IWDmCnydXmRz1vppkUhyrT7Eq4/Athr39FITXTIdrdM5VJZ0GH7kOHJwec+4M47Z97OgT5jP4XHr8+Xb/0Ry3B108FU9Erkv0AGxN9wueeYFC0Og7Wiig7bAfzqvtKeqJmeumeEoV8SECeYu0giTHbkcfwBtFdPF+pA1vCBk1MRUd7P6atlSps631vpFcQgx57ffG8Xl+CIwbdP3c0yOxUsoNeVj+xwSfDz+/HkSXPHBKfWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9301.namprd11.prod.outlook.com (2603:10b6:208:573::20)
 by MW3PR11MB4652.namprd11.prod.outlook.com (2603:10b6:303:5a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 13:55:11 +0000
Received: from IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c]) by IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c%5]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 13:55:11 +0000
From: "Holda, Patryk" <patryk.holda@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
CC: "Oros, Petr" <poros@redhat.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Kushwaha,
 Priyalee" <priyalee.kushwaha@intel.com>, Kiran Patil <kiran.patil@intel.com>, 
 "Drewek, Wojciech" <wojciech.drewek@intel.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, Simon Horman <horms@kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH iwl-next v2 1/2] ice: fix TC flower filters matching more
 than the ip_proto key
Thread-Topic: [PATCH iwl-next v2 1/2] ice: fix TC flower filters matching more
 than the ip_proto key
Thread-Index: AQHdRemYjWw/HD59nU6KuG3OZ7/OXLb6FrWg
Date: Mon, 12 Oct 2026 13:55:10 +0000
Message-ID: <IA3PR11MB9301CB53FA76ECD75DB6E68A8A9F2@IA3PR11MB9301.namprd11.prod.outlook.com>
References: <20260916144130.2699902-1-poros@redhat.com>
 <20260916144130.2699902-2-poros@redhat.com>
In-Reply-To: <20260916144130.2699902-2-poros@redhat.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9301:EE_|MW3PR11MB4652:EE_
x-ms-office365-filtering-correlation-id: 52297f37-1936-4935-f484-08df28686ec1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|376014|366016|22082099003|10067099003|18002099003|3023799007|38070700021|261009223027099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: ueRzIIZb9JCV3CE1Qq7KVDGY6A6O+0ySXfY304VjFzgUJPUaqq9Go6I2aSxQWIWLnUKi7gqE7FyTEzVZ3+ayM1DnleWz8vY2oJYvKspnlJpC83DPfbmfVp9aa/4rv3Nzt27c+g8XPp0cN2SArc8bpQBFw54wDVt0kKDzBQTHwZ3p9fV29Az0UuZkfCS14AjQGmfb/g/fzK9muR6pJRHyQ5rIvok6X5C+XPwsEJmWZeebIu4xpR6x2naook4Si5lk2X1IcXOAQNfdfquxbUstnATkz4cgKBuR4wFfZBHW+5b9pms9cDuBWQX/hKzosj3NYbE26NA6sa/3Ogei+TAedGqlt/ELR7Jqvuy/0C9PWBjRSzK4L1C9SNK4OpC9blvB4WdDWYYHdFa4HfNf9siHX2jMi/DzXlTf5bMQRQ3Y0OWXlysxpCfR26HLgxf7WFZwVmwPVqJ5h1SeSeZIK00YCkvJLGHzxiLvFf+1iKqTQA1pfkqvNwApZ4egJ6JJAy9nebY4BXmpZIGd0ePVIgOlB4D3fh5F3TssnYTsIPOx/1PFqk3gNt7RC+VQO7iOhAHQ9BcPqq/SGXVtiH2A/wy7Ct/ihcQ98/k6z0Rmp9RzVl1gJu916fI/7loO4cgUyEpV/qk6iDMJKLFBhudjtT8Zio5NSWtnyH/OlgEeFv2xUIY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9301.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(22082099003)(10067099003)(18002099003)(3023799007)(38070700021)(261009223027099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2cBtKTIBBf8BOeBoKfOJ7mpqRn1m7LZrGv9r1m7KlBtHB0nYgjaujOQsFu?=
 =?iso-8859-1?Q?BTAcQiYjI5KUFFerXsCM9FAz8ML2USfYDC9OwS+6qR+UTJmvs527X7c/VR?=
 =?iso-8859-1?Q?ZxtiCCQ+2lnxmHVe1P22IIipzaBmD+2FVzljmdH+5BrPMueIY2S6aPd60M?=
 =?iso-8859-1?Q?Hzlw+kWH5MLF1DqTXTKIOpRLdJJbfJtBKKoBysLeOQkymEJfkf11cV0e16?=
 =?iso-8859-1?Q?TRRE+/mIGhgGptNfvM763Np0XhlHDDEuBIYfKtKtUxeSYWZ+aEeSMEmHj8?=
 =?iso-8859-1?Q?wscqjpoACCiNDNMFYnPOo75PmjQXYfRsapS0TjqB1luEIAa537OyA22V21?=
 =?iso-8859-1?Q?G/zzTeWe5LzHDKqz9Ekhx0HATSQK9yv4IXatiW2nWQwgpySbuC2GLpRaO2?=
 =?iso-8859-1?Q?bSWx6iZUgvC34e9rkeTe1A52XZZkA/QBbjhEXA7VIGM53Xpha9a0iI8IBR?=
 =?iso-8859-1?Q?94mvSWWhJ+oJK2ybdOWA7yrFyjdgChw35Zz8oZjGfqkhgeKS+WLZ7O5Nra?=
 =?iso-8859-1?Q?T9R/ZuWxxluKob2GoJSLQ1ncTNTIw/i0PFqQ4S7lz3DTR+TWWWTjkaLfFg?=
 =?iso-8859-1?Q?Kqzxgv+y44wtjqlBr4gO5Mjak29dKQFtf8y8Mb/fAhLv7q3m2B6qjidqAF?=
 =?iso-8859-1?Q?DfmmbpUj5b4QnLWxMLD7afb6wh4BrRCswladfuq2X0HltIF8LUf5KTQZPK?=
 =?iso-8859-1?Q?jRxAsw+W8pHB/iKmSLPldLSAPdKfBXEja5g5xQD2718YPevtRKHkkbBad+?=
 =?iso-8859-1?Q?+FvnXY/4TsRytNABMXZl4Aq7fvtnWbtezcewUPP3uNm3zNYjfeSeuZMeji?=
 =?iso-8859-1?Q?Ri6WOtLUBnj1ShHk3gLiTvpZVUZ8sqF38wuasFahUjM2zj0xQaEzsdbufq?=
 =?iso-8859-1?Q?cUWj3O5UgE4Qg69B6aDIXZwZtCd3GeD/l4on0GSnfeO0jycKKpfXZQegPk?=
 =?iso-8859-1?Q?aE+VxuhhIG6WkE0Ukry5143HNX+wMNGmB7YyLN9u8bzsbA0QbegudP05iq?=
 =?iso-8859-1?Q?YqxqB6TvrDGkogqE/YeGW/K3wKKRWB5xvsCSTr6qLXi71mwcLOzoeoMrC9?=
 =?iso-8859-1?Q?+h3lDzjNvEyUG2APwrVAAvPZKMm0baCPOf/eP3sDl5Yz/FjhqQsTKVh2G6?=
 =?iso-8859-1?Q?wiKo5CXjkY0RDH71d9m8wQZsNSsRRtToLWTWHea6JURqlwuqREaKwR2o9X?=
 =?iso-8859-1?Q?IhfrkyjrVW6+7xx8l9ex/VmeCYcKbCkZhXl3OOB3JnIzCjp6zoI9EF7QOm?=
 =?iso-8859-1?Q?fWIbYPtiac1cUNCzgwE2bQ9ixufHAFCzMWv8HPN0bxJIW6881U7chfh9SP?=
 =?iso-8859-1?Q?q7nvDymR3GhxAIeH6WQ4lFtiVWyliT8VF2/sBVGbuLdAj9+cHsNyQ7aJUw?=
 =?iso-8859-1?Q?mVKWPiHatbgOel3RkA9qC/Vc3ZphC5fan/Y8ZYHb3pIwxeCPnkTFJeRPTt?=
 =?iso-8859-1?Q?X3raOCkv6MENcQSOR6pW+X/LtuAnVU/LVA0tydgpuofNYNzz+zW8y9uePy?=
 =?iso-8859-1?Q?k+3DKhoR5JaRo8HeJM0x92f2GATKF2gxI3zQXz1LHb4eKI/AAyyPrdii7k?=
 =?iso-8859-1?Q?0H2TFs5Z0GHc45/nJ4jR36fleMT9upxxzDfF7Fxr/FaXYEiBLVYzC6CKhd?=
 =?iso-8859-1?Q?Pc9IBeSbwVFeqhim/g7UQm5gaUqik0OnOUGhB9KtgcveRyru+Jjhz5RbyV?=
 =?iso-8859-1?Q?SISuGwwVQ0H/s1SksHhVxA/Tt7/anjFnpPB/fMpnIk2rv7aNKggQn43oOk?=
 =?iso-8859-1?Q?rU9/u3ANl7himF85j6wJzyeZuCGYP2AD5HSQJxkfI6p/cM?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: i719bOF5a7SAW0OkVwrdx63oxnI7GkJXdE90n4zoVDS++vGxKuwxLvF698x53M781vyr70EomOnrKtKBFKoLwjHaB4vhDHdt+CW+uphXC6xWIVh61Thzm1maWMHCnVXRcEkpYkEYzPxca84A8cXNV2WKwfLXd9YCQd2I7GBvxD27GxXSKw8c+rvof+thZtWOt/cceg7BG/NQBaip+rzyEuBGmjro/kw8JcvyH/u9pidOqU1LCv5Fp70lTZUwyS04uXv0fjVxv+pWmjid2b7P513igoFEsoQiNsLyhjFxuar7MplYKVReLLndm1ahxwT0sKsJLHhN//TCi2eN+if+Bw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9301.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52297f37-1936-4935-f484-08df28686ec1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 13:55:10.9782 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oC7j2dHX8H51+TSiZ1j2NKF3CG6O42MYfajdn0rRIbx7jDBlngczmbNVsdBbAHKwX+QS/8l/idThEUfZOqhrfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4652
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
> From: Petr Oros <poros@redhat.com>
> Sent: Wednesday, September 16, 2026 4:41 PM
> To: netdev@vger.kernel.org
> Cc: Oros, Petr <poros@redhat.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Kushwaha, Priyalee <priyalee.kushwaha@intel.com>;
> Kiran Patil <kiran.patil@intel.com>; Drewek, Wojciech
> <wojciech.drewek@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Simon Horman <horms@kernel.org>;
> intel-wired-lan@lists.osuosl.org; linux-kernel@vger.kernel.org
> Subject: [PATCH iwl-next v2 1/2] ice: fix TC flower filters matching more=
 than
> the ip_proto key
>=20
> ice_parse_cls_flower() stores the ip_proto key from the flow rule but nev=
er
> programs a matching lookup unless the filter also matches on L4 ports or =
the
> L2TPv3 session ID. A filter like:
>=20
>   tc filter add dev $pf ingress protocol ip flower skip_sw \
>       ip_proto udp action drop
>=20
> is silently programmed into the hardware as a match on eth_type ipv4 alon=
e
> and drops every IPv4 packet, not just UDP.
>=20
> Program the IP protocol match through the protocol field of the IPv4 head=
er
> lookup and the next header field of the IPv6 header lookup, the same look=
ups
> that are already used for ToS and TTL. The OS default and comms DDP
> packages provide no profile that extracts the IPv6 next header word, so t=
he
> IPv6 rule programming currently fails with "Required profiles not found" =
and
> the filter falls back to software evaluation instead of over-matching, an=
d the
> offload starts working with a DDP package that can extract it. Note that =
the
> lookup matches the next header byte of the base IPv6 header, so packets
> carrying extension headers are not matched in hardware and fall back to
> software evaluation, which under-matches only for skip_sw filters.
>=20
> GTP tunnel and PPPoE filters rewrite the parsed ethertype, the IP header
> lookups are not available there, so reject an unconsumed ip_proto for the=
m
> instead of silently widening the match. Filters where ip_proto is implied=
 by an
> L4 ports or L2TPv3 session ID lookup are not affected. Based on an earlie=
r
> unapplied patch from Michal Swiatkowski that implemented the IPv4 part [1=
].
>=20
> Link: https://lore.kernel.org/intel-wired-lan/20240222123956.2393-3-
> michal.swiatkowski@linux.intel.com/ [1]
> Fixes: 0d08a441fb1a ("ice: ndo_setup_tc implementation for PF")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
> v2:
> - no code changes, collect Reviewed-by from Aleksandr Loktionov
>=20
> v1: https://lore.kernel.org/all/20260910154824.3603687-2-
> poros@redhat.com/
>  drivers/net/ethernet/intel/ice/ice_tc_lib.c | 37 +++++++++++++++++++--
> drivers/net/ethernet/intel/ice/ice_tc_lib.h |  1 +
>  2 files changed, 35 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> index d20357c0412731..fbd8cbad150a98 100644
> --- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> @@ -78,7 +78,8 @@ static int ice_tc_count_lkups(u32 flags, struct
> ice_tc_flower_fltr *fltr)
>  		     ICE_TC_FLWR_FIELD_DEST_IPV6 |
> ICE_TC_FLWR_FIELD_SRC_IPV6))
>  		lkups_cnt++;
>=20
> -	if (flags & (ICE_TC_FLWR_FIELD_IP_TOS |
> ICE_TC_FLWR_FIELD_IP_TTL))
> +	if (flags & (ICE_TC_FLWR_FIELD_IP_TOS | ICE_TC_FLWR_FIELD_IP_TTL
> |
> +		     ICE_TC_FLWR_FIELD_IP_PROTO))
>  		lkups_cnt++;
>=20
>  	/* are L2TPv3 options specified? */
> @@ -552,7 +553,8 @@ ice_tc_fill_rules(struct ice_hw *hw, u32 flags,
>  	}
>=20
>  	if (headers->l2_key.n_proto =3D=3D htons(ETH_P_IP) &&
> -	    (flags & (ICE_TC_FLWR_FIELD_IP_TOS |
> ICE_TC_FLWR_FIELD_IP_TTL))) {
> +	    (flags & (ICE_TC_FLWR_FIELD_IP_TOS | ICE_TC_FLWR_FIELD_IP_TTL
> |
> +		      ICE_TC_FLWR_FIELD_IP_PROTO))) {
>  		list[i].type =3D ice_proto_type_from_ipv4(inner);
>=20
>  		if (flags & ICE_TC_FLWR_FIELD_IP_TOS) { @@ -567,11
> +569,19 @@ ice_tc_fill_rules(struct ice_hw *hw, u32 flags,
>  				headers->l3_mask.ttl;
>  		}
>=20
> +		if (flags & ICE_TC_FLWR_FIELD_IP_PROTO) {
> +			list[i].h_u.ipv4_hdr.protocol =3D
> +				headers->l3_key.ip_proto;
> +			list[i].m_u.ipv4_hdr.protocol =3D
> +				headers->l3_mask.ip_proto;
> +		}
> +
>  		i++;
>  	}
>=20
>  	if (headers->l2_key.n_proto =3D=3D htons(ETH_P_IPV6) &&
> -	    (flags & (ICE_TC_FLWR_FIELD_IP_TOS |
> ICE_TC_FLWR_FIELD_IP_TTL))) {
> +	    (flags & (ICE_TC_FLWR_FIELD_IP_TOS | ICE_TC_FLWR_FIELD_IP_TTL
> |
> +		      ICE_TC_FLWR_FIELD_IP_PROTO))) {
>  		struct ice_ipv6_hdr *hdr_h, *hdr_m;
>=20
>  		hdr_h =3D &list[i].h_u.ipv6_hdr;
> @@ -592,6 +602,11 @@ ice_tc_fill_rules(struct ice_hw *hw, u32 flags,
>  			hdr_m->hop_limit =3D headers->l3_mask.ttl;
>  		}
>=20
> +		if (flags & ICE_TC_FLWR_FIELD_IP_PROTO) {
> +			hdr_h->next_hdr =3D headers->l3_key.ip_proto;
> +			hdr_m->next_hdr =3D headers->l3_mask.ip_proto;
> +		}
> +
>  		i++;
>  	}
>=20
> @@ -1737,6 +1752,9 @@ ice_parse_cls_flower(struct net_device *filter_dev,
> struct ice_vsi *vsi,
>  		headers->l2_key.n_proto =3D cpu_to_be16(n_proto_key);
>  		headers->l2_mask.n_proto =3D cpu_to_be16(n_proto_mask);
>  		headers->l3_key.ip_proto =3D match.key->ip_proto;
> +		headers->l3_mask.ip_proto =3D match.mask->ip_proto;
> +		if (match.mask->ip_proto)
> +			fltr->flags |=3D ICE_TC_FLWR_FIELD_IP_PROTO;
>  	}
>=20
>  	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
> @@ -1910,6 +1928,19 @@ ice_parse_cls_flower(struct net_device
> *filter_dev, struct ice_vsi *vsi,
>  		}
>  	}
>=20
> +	if (fltr->flags & (ICE_TC_FLWR_FIELD_DEST_L4_PORT |
> +			   ICE_TC_FLWR_FIELD_SRC_L4_PORT |
> +			   ICE_TC_FLWR_FIELD_L2TPV3_SESSID))
> +		fltr->flags &=3D ~ICE_TC_FLWR_FIELD_IP_PROTO;
> +
> +	if ((fltr->flags & ICE_TC_FLWR_FIELD_IP_PROTO) &&
> +	    headers->l2_key.n_proto !=3D htons(ETH_P_IP) &&
> +	    headers->l2_key.n_proto !=3D htons(ETH_P_IPV6)) {
> +		NL_SET_ERR_MSG_MOD(fltr->extack,
> +				   "IP protocol match is not supported with
> GTP or PPPoE");
> +		return -EOPNOTSUPP;
> +	}
> +
>  	/* Ingress filter on representor results in an egress filter in HW
>  	 * and vice versa
>  	 */
> diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.h
> b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
> index 8a3ab2f22af9ba..752af65e70b7bf 100644
> --- a/drivers/net/ethernet/intel/ice/ice_tc_lib.h
> +++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
> @@ -38,6 +38,7 @@
>  #define ICE_TC_FLWR_FIELD_CVLAN_PRIO		BIT(28)
>  #define ICE_TC_FLWR_FIELD_VLAN_TPID		BIT(29)
>  #define ICE_TC_FLWR_FIELD_PFCP_OPTS		BIT(30)
> +#define ICE_TC_FLWR_FIELD_IP_PROTO		BIT(31)
>=20
>  #define ICE_TC_FLOWER_MASK_32   0xFFFFFFFF
>=20
> --
> 2.55.0

Tested-by: Patryk Holda <patryk.holda@intel.com>=A0


