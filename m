Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14462CA5FCE
	for <intel-wired-lan@archiver.kernel.org>; Mon,  5 Oct 2026 10:27:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE20C4064A;
	Mon,  5 Oct 2026 10:27:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zm7mCuJBb9fS; Mon,  5 Oct 2026 10:27:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 143A340555
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791196075;
	b=Oo9ptG4v/IiJlrUKIujUrJUTmPjPLvXxEJ2PfTSPJi3xagfaC9nsahKk5NAnJKQBuf/s
	 eJivvK+nZqM5SP+lt806feCEt7Uq7Z4gaP2e/ZWFA2c8bJZr1i5q73JyNKWBkXCK7ezKh
	 EVF24TS5Sqe7jdS17ezgLNlwdlE3kY/raijXbivK1tyIEDH8qimv/jWfDOaUe3VCjnOkQ
	 79k/qM93iSEaYZVs9khGkSmcoWZqTE2jz1BjBRCl+N1oeOd36oHoc/thYgi8qR+4zEVy7
	 j8OtLIy+gsHAOrVw2cJGAJBoD6a/RSCAPupbflFmPlnUu9rd8IKUjB1msXeF/6j5XMw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791196075;
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
	bh=YqGQy4C4AIoqZMd5EZwgmPOhhFS4mwiXV/+poiAIdT4=;
	b=HEXNlbo5E1VxqYhsXJJer7M4u0MfFsYwiFakWBXhPTDBui9Ohv/VV2NT6Cr378oIm5me
	 fnrbPNLr5Q8djOQ4DMbpCM5rnSKuTZa9MFLc6NT9rTjz8wJSXZDGrgyo+bh+rWx60H1bi
	 ffuXwVsLWy3MxNEV3iMxclyme7R/0iM6zNVqZKE0VocQoVt9esB1oVTkL5qW74uXxs1r5
	 hqvPnUtp7Dgt9LC6/UfZF9UWPlrz0B2TbHB8EQcVEBxJEBk//JFlqIrKEyyT5naWxYOIE
	 7ifFhpzGdki3e4BORYGxe8NzFiItE9UoD45C0CcrrJVltLrUCKzLOdtz6cFwbwf71sg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IMx9VX5x;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791196075;
	bh=YqGQy4C4AIoqZMd5EZwgmPOhhFS4mwiXV/+poiAIdT4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gm5UC8dDBqyfPd+Yb/unVteV4Za4UYUDnh8HlYau5kNdNEO/p6+abeO0Sej9o+VHG
	 IjTfOvEH4bwVkpETPhyg6EKyTJfxjANGMfi99i/QXHVWlTI3QJXoh96c2ZjOcU2IW7
	 5Y68fJflYvClM3PoeQmh3cBgTdnA791B0A4Qu9V9ST/TG+GAWeOWxpb8HPvh85UOJu
	 2BXr+vqZFHJ/Gmj7dcpHOqEMdWJdE+tNSZ+AD/yIpcRiZiI0CmcBnp99xkJ7ZnNdhT
	 9cdcxcDa9dHMOIRXtybXUifDM6RJVKyQN0jKTpNJ4chiC7jp4Zrc3J9QHqP0sEq1rh
	 mGMzbItK8XnMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 143A340555;
	Mon,  5 Oct 2026 10:27:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 993102E0
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 10:26:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8A93640647
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 10:26:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PgAlgkBLouBQ for <intel-wired-lan@lists.osuosl.org>;
 Mon,  5 Oct 2026 10:26:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C153840637
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.14
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791196009;
 b=CCeUst9KYG8bby56nrKuNwt7lasMg53GjqZq2L/BfduwqeE0Q2L8mNki9GKHqBOfdR9I
 yZeAU7T+XpGKhBhi5hmIM/q0RNaX9Ahm1o+DqNq1RelhVuynZ8jcYcSbfRQDQk8ZHF6iZ
 gsikGiGH6Ekf84QSoJfFkG5hQYwwlOMIn3YaplawsBs03ymXHUm3j5uL7ijX3BGcc86yd
 1WGmOK7dOShGL8KDgrBBhDG4svMdM/iJqc7tnxouHpmAWaR+EFXsHz+un4WO424ym138Y
 salFlHt+apNnvC9az4jbm5INR8HA1r6mrBQ/D3M3lHdd1OR9xmFZ/Z4OnzIk9Fe6ZJQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791196009;
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
 bh=YqGQy4C4AIoqZMd5EZwgmPOhhFS4mwiXV/+poiAIdT4=;
 b=eAccZya136sUQ7a80YT7GBTSVDwfpbM4bUpQ2Xk8H9LeDbfrbdtQp6avBP1I4lUQmMdO
 Qh66Cnoud5TpWLVtaSlVkhPAGXoK2pfItv41wyZP83CQajB1zoUPqE6MYrhnkFoht4zB4
 vsnV2tgdNrqLENy0S44w5iZA5fcMPH308sTBjcyVJCx3YcQrBUgIZIp99RsTiKkQiAJHT
 PDeRulrrvJtrk6XHAoeQ7GJtqNACCXlxz/mBkbN8c7K2cK5ZO8l1pD4R4koXaLxrb5PT+
 VIIkCDwnL5Y+YuxH2I6FOUHEHAMPnVDR1u2iqmTB+5GWLdmWLgmiD08fHgbdfRqjsVA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=IMx9VX5x; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=IMx9VX5x
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C153840637
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 10:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791196010; x=1822732010;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/RGRaXAtONRbY9aJd+6HHGOkUtHUEYYu310yAFUxWsc=;
 b=IMx9VX5xwlEVlcXfaf7A/T/pIEphHztGoM8lX9wTNLzRHLbEsCEWa88k
 qqorLa/GurfzxCDXV+s34PX41Mqied9t5z7smeXHTeazmyQTi5+LUz6mG
 YvHs8v4epVU5xnlejmk46JwfsPyE5k0Qa50F6m4L0G5y+0M5Uy/OTS7Lr
 5eJVj0Am9x/ySHlaaeOba3aH0KYJ5vg9AVkKwvfAu6vxcHVF2A+DsIvVP
 mwnQBsxR9KMu+7Orha31JMWqPT9/10+SkbTtthXetFRCYjoE5Wb5Jwqf1
 s/Tuiwlt0id1OiggdSB44y1/+v2ZW9DTGSZ5L7Lf/U98HmbEibqahZPNw A==;
X-CSE-ConnectionGUID: BKfVDqUtTFaSWH60WcqZoQ==
X-CSE-MsgGUID: ihM0GO57SNK9KIdx7cRJMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="91887910"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="91887910"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 03:26:49 -0700
X-CSE-ConnectionGUID: GXkBwczLTt6onUH6/PO2+A==
X-CSE-MsgGUID: oCXCQUpAStOxdvXBlnlyVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="276878457"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 03:26:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 03:26:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 03:26:48 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.52) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 03:26:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXQiojSSeHQbJilinS0NYLgxB7PKvXQWJUCcMtriGIV/GWS9E+QsZNGVQQ0jecqcwwPYqzn4aMT1kl67IRTsmq9iS/LWrl8mnySHKHVv+An4sn8bma52UKK+meb+63C1erDJqPsnzN1vy1ML129No537FOSfPp5RKwkkNUGaycjORSQ5V87QQ4e248HylR2ASx2PA5zcECbOYWs/3FhM1AqQayiDiT055LN7SWrC9DMT0ir7TgvOgLA0TemUnMsxGAR2MdPNzzyvS8ldaxW7NxS/X7ySFGGQN6V5RTLZDFm8YYDhaWfh5AgI3doC6POYSvp7LyOoUS8ycL9bxgIUHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqGQy4C4AIoqZMd5EZwgmPOhhFS4mwiXV/+poiAIdT4=;
 b=Gam5cufApZGZSm9mCNSL456CUYnxN4x9dJanuKcv+s5p1FIMIijRL1Kh3jEmOl2CmN2kG3Decr4eN/XzYCvE4Q/PzSXANECk80P7rbZIiTUcsqHMH2QIpvJv7IgcClwmiK74Z3QS+m2YabpQFysRGlt69YIqMg601GhJfZVxDZ6wmfGUS4GV2XMBPV7d8yYDoNc1dtGsaj8v/6lFqgSVfNf8Pcy4FQOWqpUeb4KBRZ7ylNprCu8xX8nR1NLlCFcfqhwnUYuQEJdTH7Yjcfnyx84H/03pQ/+aHyHknVauW+sNG7kaxvAPxm35VD/rAzazA4RQKo3OuUSVGphxkUV9FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MN6PR11MB8220.namprd11.prod.outlook.com (2603:10b6:208:478::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Mon, 5 Oct
 2026 10:26:45 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 10:26:45 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
CC: "Oros, Petr" <poros@redhat.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Henry Tieman
 <henry.w.tieman@intel.com>, Anirudh Venkataramanan
 <anirudh.venkataramanan@intel.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, Jesse Brandeburg <jbrandeb@kernel.org>, 
 Preethi Banala <preethi.banala@intel.com>, Kiran Patil
 <kiran.patil@intel.com>, Dan Nowlin <dan.nowlin@intel.com>, Stephen Hemminger
 <stephen@networkplumber.org>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH iwl-net 06/10] ice: keep adding MAC filters after one that
 already exists
Thread-Topic: [PATCH iwl-net 06/10] ice: keep adding MAC filters after one
 that already exists
Thread-Index: AQHdUm83Y/uiip96Lky+3BNuELoUerbuwx6g
Date: Mon, 5 Oct 2026 10:26:44 +0000
Message-ID: <IA3PR11MB89863ECABCF08E6CE7BF6E6FE5962@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-7-poros@redhat.com>
In-Reply-To: <20261002130752.2597259-7-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MN6PR11MB8220:EE_
x-ms-office365-filtering-correlation-id: 02849b31-24b0-4ef2-bf56-08df22cb27bc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|7416014|38070700021|56012099006|11063799006|10067099003|21046099003|18002099003|22082099003|4143699003;
x-microsoft-antispam-message-info: IIGnKJ8M6GLvMDHp2Ore4lgGgr5dWGf89dKipPJzDxdv8g8oaQ0VC7yGpVGFqCyL+HMsvyazs5uCWUFjLw4vWJyR6d7DftOTYoDI2oVludf8xI7Olr4cPSVEIkJ5Q5A54BU1seFnRIyoFAKIQFTvHQPm0Tc9it9tVFZQyl8asVxCXIQ6pitC74kqtgAeaWyAkn1I73Ru9D/4NirgDJuWiupBfs8wCE284JoZeaHf+wy8vvHgJzlhL7qGSAE6sVlJ169T/aIH9XNSMVvN2wtH1X9yrOd++/qp4hQO9p23zMCHdisuHPje7pMATEEjzo4Mmz6wauHmAM+FRQr6kWAQMD8rjFKHbKQ679Yb8nI89hSatsHYJUC+V8pFIe2F0DN7WST8iqZC5qlruoOzkiDVU++emuP5BqHL2yyx2vi8pHyYoTRhIaGI4FdER9g1jUH9QhqXkIboz7yqEGb1G/zrYrF/+nVlduxNfFfLzAzq70umJ09zXVFa8cw2DBb00sTwI7BqSo04PFWsLIdqYxOKX9rzP//Y+9/nmpHW9ESUHzPGrGaIiD4KYeboJEA/aXxG1JYcXec5eMXQyyzt6ywoP40rjEncPF8LsBLXKZu25jbnYrDL1eKU3FB99gFqHWp6qHXDNtlXmvGYxv7xPL2el5OStqMuAlBiI3qHr1gpnkg7m+jqy4FzdsTTDRJVrTBeL5DNkgBzLS29DT0BifJtflIg1G5puwuSfJVBw2Uq1yQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(7416014)(38070700021)(56012099006)(11063799006)(10067099003)(21046099003)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zQFvEH8CEUzpjkC5dxBE8xAkPHustkMOalmcEy/Pqclj5ixe+kYZ3YEx5c9w?=
 =?us-ascii?Q?KF4JzNFWAIPHEoY0489iYGwIxxewonGzp2flR9EAORRhtUAhT61spftlgG5K?=
 =?us-ascii?Q?jQNXUmzXoueWgFu/GficNh/3pyhrI9ZXZ/rbfcErElrrIueV72SRK5KVSzQC?=
 =?us-ascii?Q?v0Y0vaw/jhBb5zREaejfnSfDMH8GqMEDmMyvN/SucxaElusoLomXJw7xkUXM?=
 =?us-ascii?Q?yL+z2SoDQMpjuRf/JsoapHAfIZqYGCgC9S5LgkFjCWIRGiHKKwDUvvGEvORh?=
 =?us-ascii?Q?laTt+9YrrcL5sskDI8HyMMa3gEJ0GVvFO1LnzleSV5LLR4VYhTifp0KPJoz7?=
 =?us-ascii?Q?VPRnsf4WG5/ba2FQB1EPNrY8B2rDH1yWZUBlswY0WCjPmTUdqu/keuL3ycnN?=
 =?us-ascii?Q?EJMYjCu7BphQrPs5ulCrZUfGJFKJLin+wZOCduOedRO5kwPlxnIMA55z2o8u?=
 =?us-ascii?Q?LDvnesBUEglVry65T40Zr4rUFzrUw30tdYodCLROswX28N0kQ28hhiLtxRpL?=
 =?us-ascii?Q?v3fd6/klB+Vx5tfyFFhhJS93OzN7mX9qZj+owX5/86w7Ih6cHJSRR7wWqK+c?=
 =?us-ascii?Q?gcQLA+JaQtx763djQfb4XSg2UyW/ydgaDZ3WdPbTH0Oh+sNrdysGBUtZ4XzN?=
 =?us-ascii?Q?yzFXM2diXlt0wegHmLVWP9RKRMxthr9dAtxh41c+H1pvaQBuIXc4lov+IVX6?=
 =?us-ascii?Q?0HM7e3AyG9HEBqAD/Ev7nOMI9jzMmhxYJA3PuLblxzffXRKJXEAuEe1m54wv?=
 =?us-ascii?Q?Wuy05dXo+eo7FjCJYTdxPoNCaFSfaEQcA/QF6NnXlypewio+I5W6m/j0YVuo?=
 =?us-ascii?Q?8ujKc1J6ULv2S1bQr0uBa5kAhEdjhvq0lBD7GRhY8bQgOWTzCRnBjwAqs4Zu?=
 =?us-ascii?Q?mkPR4fgHXqNqBclEdgJyhCdqoDrgl04tPyRb+tcMnoDJW7EYiHTEAOdKgifW?=
 =?us-ascii?Q?lGSSdRQC4ZZ1t94R+TYgy21As1BUO93Zufw/tz6JGX5UOokB994JJqoKTBx1?=
 =?us-ascii?Q?BRoyTld++Pfyblhhi4h5adViMLluLoOJ3OkBYhtok16FKX3rJLF554LZlUts?=
 =?us-ascii?Q?vBKT/NffTk2LkSMsIBSUk6pYGO6HItiyldYS2Wht1HqxfNQ83VGA/wZ9IxDG?=
 =?us-ascii?Q?ncNrxvCBSYI5CKZ7KT2zu/tj+X6NMY7+h5m4E4dI7Fo7OMyc/wlUyQHYU+a+?=
 =?us-ascii?Q?SxbPkBGsgqLidWcGCmmV9/bwMskcQv0sC80E1Ud+oErWW8fil89HNLGLsnnR?=
 =?us-ascii?Q?uccHlT8URGBVV6nPIH2K2DfCJkU+wwQDxSh7sr0+VwRmMMKJh5MwWYS9+pUf?=
 =?us-ascii?Q?0ffjy19f/wZtezviAk3vkXV1NAyU8hrfjhoK9+71wgtkfjPxJJU0njKRzU0m?=
 =?us-ascii?Q?V9LhU/aw08qMXzoA2OatOjErqzrwkPAfOtBe8ftCLBc7/q2M/Xmb5FQcrIGq?=
 =?us-ascii?Q?saeDDSNFqwmrrzR2V6oUSi9n17f7Ymu02VqhYjzKgTbGYRbFsQwjjJaB3z5y?=
 =?us-ascii?Q?eYIhE+bB3fRENbDjVnWLd62kGWY92HZr/mAGlTtIz+WtUnlsuicdPo1r42ON?=
 =?us-ascii?Q?IIskJoUENfZG+5ty7o9GTJ1RHi7rdNxOW7yal6/bSlS4AZ8m5dcRDf5vqLJ5?=
 =?us-ascii?Q?H7Qr40VGOv1WfdiuPnbb/ZH+Hgq76rhwocAV4tPSTsdLIMj2CbXIxJZSdzvx?=
 =?us-ascii?Q?juMIxk78cg3opuKbHz+WB54BqYYKlNc77P0TMBLaMTDO1Lj+8SGkIhqsLTkl?=
 =?us-ascii?Q?U2ifeap0Syazan3WVEnnRSwvcI+RYuM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jEmbsDiHXU3Sm32YIaoOabJ4GIpuLDKL7JGiz0JMfwilePwZMTl5zCugovgjGorFXksFYnE4DbVGLIpFQjuEeNPRYPAFzMNhMtkEuEHI8cxeTyv3HOK4mk+uFLAbrUhmpfrEJb80Ai7KyfAsknrqGR4gRAZrTefVrk1fLvlCl5dUl9NllqeV2QztK3YnwH4bu4U+GXmyl5d456JuJ8nGYAAb/3IfcMQzay4pMG1WxdpLwf5cLDnSQcqcUxfret3CjC/l4vI8PeM8vRdAuOJh4g+YTjfy6SVJBJqgEDTg8tMFBKTRfnqNOgZqzDYapSlBMair592hogW2JPmol54KNA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02849b31-24b0-4ef2-bf56-08df22cb27bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 10:26:44.9673 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r0at200+7s3QNOuJQj/Qbfv69t49xG1AJ7oOCZYoPGQrsC25i8F0rtTFdQy8HdisPvmSns/GFXGh/3fk4tBPpwmHN2cs+cpc0N2pm8YfZj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8220
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
> Sent: Friday, October 2, 2026 3:08 PM
> To: netdev@vger.kernel.org
> Cc: Oros, Petr <poros@redhat.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@kernel.org>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Alexei Starovoitov <ast@kernel.org>;
> Daniel Borkmann <daniel@iogearbox.net>; Jesper Dangaard Brouer
> <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.com>;
> Stanislav Fomichev <sdf@fomichev.me>; Henry Tieman
> <henry.w.tieman@intel.com>; Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Jesse Brandeburg
> <jbrandeb@kernel.org>; Preethi Banala <preethi.banala@intel.com>;
> Kiran Patil <kiran.patil@intel.com>; Dan Nowlin
> <dan.nowlin@intel.com>; Stephen Hemminger
> <stephen@networkplumber.org>; intel-wired-lan@lists.osuosl.org; linux-
> kernel@vger.kernel.org; bpf@vger.kernel.org
> Subject: [PATCH iwl-net 06/10] ice: keep adding MAC filters after one
> that already exists
>=20
> ice_add_mac() returns as soon as one entry of the list fails,
> including -EEXIST for a filter that is already programmed for the VSI.
> The rest of the list is never added. ice_vsi_sync_fltr() treats -
> EEXIST as success, so the skipped addresses are considered synced and
> their traffic is dropped until they are removed and added again.
>=20
> In a test that adds 50 multicast addresses to a port in a burst with
> the port MAC address in the middle of it, 19 of them were left without
> a filter.
>=20
> Continue with the next entry on -EEXIST and report it once the whole
> list has been processed. Other errors still stop the loop.
>=20
> There is no i40e counterpart of this fix, i40e keeps its MAC filters
> in a hash with a state per filter and syncs them differently. It was
> found while building a reproducer for the MAC filter overflow handling
> that i40e fixed in commit e58872398684 ("i40e: fix disabling overflow
> promiscuous mode") and commit 7363115efb04 ("i40e: do not force filter
> failure in overflow promiscuous").
>=20
> Commit bbb968e8b34c ("ice: Fix issues updating VSI MAC filters") dealt
> with the same problem for the VF MAC filter requests, which are now
> added one by one with -EEXIST tolerated, but left ice_add_mac() and
> the PF filter sync as they were.
>=20
> Fixes: 89f3e4a5b762 ("ice: Do not bail out when filter already
> exists")
> Assisted-by: LLM
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_switch.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c
> b/drivers/net/ethernet/intel/ice/ice_switch.c
> index 2ee5cb6ffdab1f..239d4d9633baa6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_switch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_switch.c
> @@ -3659,7 +3659,9 @@ int ice_add_mac(struct ice_hw *hw, struct
> list_head *m_list)
>=20
>  		m_list_itr->status =3D ice_add_rule_internal(hw,
> ICE_SW_LKUP_MAC,
>  							   m_list_itr);
> -		if (m_list_itr->status)
> +		if (m_list_itr->status =3D=3D -EEXIST)
> +			status =3D -EEXIST;
> +		else if (m_list_itr->status)
>  			return m_list_itr->status;
>  	}
>=20
> --
> 2.55.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

