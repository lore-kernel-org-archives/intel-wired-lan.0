Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA178CA5FFF
	for <intel-wired-lan@archiver.kernel.org>; Mon,  5 Oct 2026 10:28:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B7F840647;
	Mon,  5 Oct 2026 10:28:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3YrAjdUtez4M; Mon,  5 Oct 2026 10:28:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 12E4D40648
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791196129;
	b=bhJAsjpnMQm3fpOv3bMRxmhs30xve7wL2JiVrDAGL4urBjBS2DAU4Y5wo6drZr1Asnj1
	 5US0Xk6n9NaCrD66UPGippI+y/yqm7Vz1VxRmS9amZsMz8khglUYt8LjX80uX31ct0HRf
	 xPBnabIml6AprwmO9GJq5ENCOAVWzjtJhTsJLAIZC//1zkQxgE4tB0+bAWU92p7RW9UMf
	 WsXkzdwUSA8FFKUpTF76Sqhxo01cqXr0qt0PXNszri0cH5nKxNaSHsICJujY24olcWD3h
	 6aO/JHF5GxlAAunDzuPd1cdmpjGhSiz3ww6cJHNu8HGChMal3U9zJvGPD4hO78R0PxQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791196129;
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
	bh=Kb0BqDmv0bLbBPUmzHttpS95U0iG0lgBoTK67MB/hhk=;
	b=b3XCDhJzJZVB9BzroxcU83cotvTw4F5cpzsrw4BBCpRuQFCfktw4SkJK8BmDKj2c2Ql9
	 oBqmSibynOJ2CwEG17ZHhnGABOK6zxUjAXPPi7Uv5fTEg54/1XCrO2+9UwnxtUZA/B8a8
	 AlHrBcTQc41bMgzC4SIcxNFhFUYCuJ5gdQTxgT3BiPLq1GT9RvGMbU35vPHZ4bn0mZQgC
	 fg0puE2+3n0/Dmkq2JrNXTwhzErjiiz3AHFUJ3KtebYcO3a6KIhn+wePRHxEIDDNR3eUK
	 giFmPG4ye3hA5SYROmaDXOeMZULjxscV/wiFCn4SBk5CpQFPGCj+9Gjiwo6S055Bw1Q==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791196129;
	bh=Kb0BqDmv0bLbBPUmzHttpS95U0iG0lgBoTK67MB/hhk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YLxrCJwcPmQhIauT6N8bH82D0p6ZIFZxKMS3EUXaqobzhDD1nZkPUNT4ZmF/qPMzC
	 bzLr9qVJjnSUtk9Pk9U1lXyuL4C9TWPVTL9lm5VdRJgJqG76wFeLP95UnQg/biyI2V
	 u/dzVjPTLgTwuYeFUfUoZ3ixSIY9jGHa7mXBaN+1U3BGn1z6L6hxi2+hOzx1i430fU
	 7dk8gY5v2Us+KZveWq0AzpZD+xGMulgP9qJaj1T7WuMGtBJlef1dihUsIPkt0cBYLA
	 7q0tXlPXxr426oUNO8TqhpWjoj2QfNi0If4pMhsqbnFXqbr8MUvxyAQDQW835YxpLv
	 K1ip28SpWYORA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12E4D40648;
	Mon,  5 Oct 2026 10:28:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B2732E0
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 10:27:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 10CFA807E5
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 10:27:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8lFkycInwi-q for <intel-wired-lan@lists.osuosl.org>;
 Mon,  5 Oct 2026 10:27:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 361F0806ED
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.13
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791196065;
 b=NQyT8yCHa+Q8pwFD5ao65DUa8ydtjL13J/G/m3X26uxLsdwgz6jYzCH1pt+wii9rucpc
 hT6OMEergiHfSurP9tixBky2IESkR00lniT6dB1ljdmBoz/9RDXTvX0SuNwJfNdjhCHuP
 tikNZcxpjKC7jiKkZ5oYYfPnE5DzTImFGx33pWssmuJ7KU2E618j+wJ9aRs0sbMg0RPGh
 1Lhvb0rkuTfFlG1U4Br963Pj0895DgHmIadaUHJnxh1JlV3DUYs/bLBR/zkL+SxSCzw8W
 ks7wivM1mbIAU/8fywNffiuS/cwB5wMzS6kwtqQXXu3Q2SIjd5bUHpNiysxwAaUeZ/w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791196065;
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
 bh=Kb0BqDmv0bLbBPUmzHttpS95U0iG0lgBoTK67MB/hhk=;
 b=deXoJ5LPxm2QbdJmL5bteuN4HetrrkIF8pfzXIRHHLd06kMfKqWxhcCFAnNKMrNwTo6B
 fDnvUdORxef16WqpTl47xK+zW2DsZsnKIj2enhJu8U09/ihTeJPJx/f0gsQv2QLWIeZ6H
 W/sg6ib1BYu1eWg7/SYhPxYqJe6orSAfqVzGCp8s2NeenJeYyQJPRr2l3MooDx+fMH+I4
 gix2qya34IJ0AYfE3VU3lGdGka9/hvIBNBQRyolmpqpdb3F+9eCjY5n0v2i32qr5Fi+Pp
 Yz+pTuHC1gHNeJCuuT6w816d6dhJ64LyJMt89k1gbYElAFmcDIk1VXkm5ACPFA/WlWw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ggFlhbWM; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ggFlhbWM
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 361F0806ED
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 10:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791196066; x=1822732066;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ulub+AnKdpUW9KS8GFRRsCL7K1L41ha7HWsn0oWlLco=;
 b=ggFlhbWM23QLXE6AcJCRMA8dbDmIgYYcjkXYWw/6WPm86boqi1sywnmM
 BSmZ4hBXgyoSAXOzAS0JDmM3iXKy4dT/htuoANgxugINSFMKO2xQZJfsL
 FTRV4DQH3tylKTjtEPV2QTFjl+4oxll5T+d80cHS+ywbov6xUfDjnJ2zU
 p6XSUClL/UdG8HVdatjaA6PWpdtl77SsYjGTFiLhVUelYk0s7KIAUSz3V
 NYfvqLcPtJSWzrpMUgmG7LBA8wgMZuPBKktgsLM1+CsBCAGvAJ3bbdLEa
 iEcPfqkH1dO7dnYv6cYSp6FYcG8bs2l09xGzXY0G/D4bq5+ZPuUxwVNEq A==;
X-CSE-ConnectionGUID: yBLbrKyERyKMwBBfQeffNw==
X-CSE-MsgGUID: gtJWVRA5S5mC2oDik//R2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="102024666"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="102024666"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 03:27:45 -0700
X-CSE-ConnectionGUID: OFldWsU/QMio7sVMH9hWrw==
X-CSE-MsgGUID: Dg6qb7RkT5m3GawAzbUyaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="280054138"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 03:27:44 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 03:27:43 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 03:27:43 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.38) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 03:27:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHvecJYZShAVyAD9byDsY3/GeJ5IAp4H6rk8SxuHZYvfwswZf49nZ15kgolyq6RCmzPwmsM0Xbi2cel4wy5HU89alVIyNK02aY3kS0WVXyiR2UNMe06XszXqFMuM2eyIST8aC8aaDZCmAMJeoXrJbL4rfuyz/HMEJqFIbMcopRhtmZ9K/v3lf1Ba5khqqPTLgqvCvV2Ag65G2C2m+Tk6R5qlIRpsfkEYWKXH5MGpZzRLYku5YjxMpDpXz0uwhmN/8lhIFQq9fxInp+/2UArF707dsK2VSE7BhtBFPqtbuVSHiLgmsfb8fIe46T9B9TiDa0pwYIX2rpHeCdMJs90yAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kb0BqDmv0bLbBPUmzHttpS95U0iG0lgBoTK67MB/hhk=;
 b=kQfMbPq2Yy8r4v25LgBw0jHEz/Iz0Y6FdgQjsY7PP+HegkPi3+fD5qz2y1fxIOAD8xzzUwgWGLxlp71a9mRByXjAQbuNsBKTSx4KHB4oloyArFycqWgL7p1O4LV5gVhQ5WfLlZ7oGZFpXKdOkGM6mqj5z6VTntSoCkx+3EIxHhu9OiAhN7UP4rNGkxc+qBl5eVuOy6Ajy4ZSelWFhYPJRob/D7pV/IQD6eOBNq5pSyBHF1y4ItnoIOq94jQo7412ponGqmgwmNoLpSgOWHcWDyIEA+WU7pvOEGQeqMk+0yn4s7iVEBc41PfQ+X259AFjruLRraWAwykiWVVBZzENeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS6PR11MB610166.namprd11.prod.outlook.com (2603:10b6:8:469::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Mon, 5 Oct 2026
 10:27:39 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 10:27:39 +0000
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
Subject: RE: [PATCH iwl-net 09/10] ice: program multicast magic wake before
 tearing down the main VSI
Thread-Topic: [PATCH iwl-net 09/10] ice: program multicast magic wake before
 tearing down the main VSI
Thread-Index: AQHdUnGX+i4BPdDfgkashWYrFzvSRrbuw16g
Date: Mon, 5 Oct 2026 10:27:39 +0000
Message-ID: <IA3PR11MB89867C3F35B4206892F02E2FE5962@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-10-poros@redhat.com>
In-Reply-To: <20261002130752.2597259-10-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS6PR11MB610166:EE_
x-ms-office365-filtering-correlation-id: 9c3ede42-c3b0-4fa5-fcfa-08df22cb4822
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|1800799024|376014|10067099003|4143699003|21046099003|56012099006|38070700021|22082099003|18002099003|6133799003|11063799006;
x-microsoft-antispam-message-info: YABHgOH5wvNf7e4UzqVYOs3No2heup8igVugwgW+I/AADIFLUIYZ4HGruM/grVI9TUtEufI3inumVgxBh86vO9c1yNhh6ienuCgbJgBR9TqBtcAAhNo57+gt0OhC2omjjGeW6bPsrCWDA1fviLgwlXPOoRHTkBtpWIEPGDsMgIDdMy0rLH1kCN8XWwhKEW4qzJ/qoqvl3DVUIuvkstsxdrPS5E6TJkjrA8YAnlhAR/uxlU+K20FARfQMXNugq/2I/NmfeUdoQyz8YBD+EHUag2uUY2D13TgcUQvwV6pWMHqocjHMV29fe1ZkU2vsuSbk8lHOtBlpUUg1/EASx9dDm0/ykRdOSXEoNlHU5fRope750ScEmS+slz6GzRJ8omTDGcdbliiMPXqq6o9hvQTQqi2bmSmv7qFiE/N12p5kdibPtYi7n5JlQFO0jiVLJ0vg1vzMCdkqp5fnXpaAm/9gPHmfzpNMJKMg0p470agBgrR6KaQQ83DOJNL9ocEevWH3cJluBTwSfPEXPMTN7pXAbehiddyKX3dHAgXTnouOIzFeqhw9sKLZVuPvfBRgZkfj0nlamsHsj9U5pXajGurXaXM+1ZepQ1TjQ8kFS805X8fuK58NzSHAvbOIiYAEMcLCtTHihLOhgZ1kejwRfke8Sk6DP/x4lJKQjNVN6gR+u2HXqCeYqWDjU2G2EH3+H3UBR0mluEQQUMDCqfYBkhuBkPouPVzB/VSmp4zNEXnkqX0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(10067099003)(4143699003)(21046099003)(56012099006)(38070700021)(22082099003)(18002099003)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DAs2GM3Srx46qdfgCGVOC0PwrsO3OFZGmcYSOLlOTN2DoycbCX2YzLtSM9jb?=
 =?us-ascii?Q?M1LkF46ev8sXQLoggGCVUbwQJjG/9Qpk/8caeGraEN2jfXUNg5+EWnZ9OeZo?=
 =?us-ascii?Q?Yv2oslnkN2jizzryH3QSSa1f/ZOoAZ7CC37mlxiM4Y8GzpxVZV439NWBQ99/?=
 =?us-ascii?Q?rtWCRYa0mH5g/FdjLFYGMNB9UIlzYu9VZ8pCyk55OybTHWvA3H8ShPFy0v5I?=
 =?us-ascii?Q?rpjlUDP88Sz7cCQpkyQZmXc61ioN2fAiGtdXegWnO7LG+oJ7su0aOgx/m0hQ?=
 =?us-ascii?Q?2qsO77fYHTH1+9DHXcoo1A9IyorjBqHrAbq4f+tkRuuU5MAazPwPBZIdkGL4?=
 =?us-ascii?Q?t+X1aZ8TU93cNydQf4FJwOTay/jCfSIfRDZPZjrcWp3GE386chnFPzx6Wcll?=
 =?us-ascii?Q?cWn7zMGwW5UTtC6okD1hf/uUN9CLC1XoyA5jOM2Q/hxxegmQDd7X0i4SORa5?=
 =?us-ascii?Q?fPSmrnM5uWrvwacAwK1ruVeRiYpULhxEAEtbbBL2WqSYwUFbWFEJxCy3PGx2?=
 =?us-ascii?Q?YaHU/Tvo/uDysSRBfFBTJF+AL482LrWkNQX1fzH/U1OOHK63DhnhsPvbsl4S?=
 =?us-ascii?Q?Bxq3VtmHhB95Uk7kUm3mB7luJ6oz06xNByRLIYclChhCPKKbTg4XKzgqi8j1?=
 =?us-ascii?Q?TJe2eLkalSNf11RZsLLbMKpz9JYL9WSOgnAZFn9iwcDe1ntGlTNEAo8tvDER?=
 =?us-ascii?Q?F2Ib6jNSaN4BL3MtUgd5mdvvb+Qe3p3gGucT1b4K0BEJjA5n75XQmEYr2dRq?=
 =?us-ascii?Q?GgZh1fga7SB2G31b0pTnxFnrGz/c+7Ub3yBiU0z1H8X//p3D2um2eCjGQpMV?=
 =?us-ascii?Q?K3kv60h2u9z0qb9t7veflVHO+nDjHRhrabXOsCH6fVhBhbzz+nr4lCy2Gi/M?=
 =?us-ascii?Q?e0hbyY+Xx/snAkxKL9NDskghP/g+a7gIlMzlVIHPu7dmIFCO3iMHcdnje0wg?=
 =?us-ascii?Q?5XYNiea6ZnnSV7tef0KpZz8QKteTaDnk2tmrDAzn5kxoFYBHR9tr4evVzUM8?=
 =?us-ascii?Q?Ig90rmQu7Blkk9MpZx/atbYXY9K7dupBWJa3Js9Rp1p9StFD5OJv335OLRhy?=
 =?us-ascii?Q?psRaidBdw03NIteLgX9m6s44LG95mCP6bOvJZzBeYAZw8/G8gLRw16vRTbIt?=
 =?us-ascii?Q?9wgPCHfkGZFJTldY0zG4vOSHXXFHhr5shseGX5bKqrtsblwTp+0rCtVuNhKV?=
 =?us-ascii?Q?IqZUyjye+HLLO6qERyeOUvGU0VTFtYS76XviWlR5lqxS39WDE+nTX/IiKMkt?=
 =?us-ascii?Q?0ksgvn8stkCwmGTEvS4w0wmD2VKcnuZAXL+DFpV/HXHcHvbGsRuaVqAVj4V7?=
 =?us-ascii?Q?kiIiizGARQ8fqGzwBboQBqwh2HpTwqDYaciy1s9DDCd2Lq1PxkpmJRn1sU5c?=
 =?us-ascii?Q?BMu343rvWpLubAQN3cC4cIiWpNPm5oijlXVRUkujv0jVXQZtmRUAlSszQ8PI?=
 =?us-ascii?Q?VFcsLK/K4RUZABwaDdDdywb6uKUXOXdYYuIKKcPqAr+O6/buq1U8LyA2w563?=
 =?us-ascii?Q?1jgeXeTkjKaxfvsGTfBWnFZ2sdTfSJh1hKhcRIpJXvg1ccaUGYErGmiwhu6F?=
 =?us-ascii?Q?0F7djgB1IGgxefpTIY1YybsyMv+B9nTi4mTebq2kwosRChIgLhDyNjwzsTgo?=
 =?us-ascii?Q?yCZbgpQmqQh2o+j7Ak96E1sO1Vf4bwEhL67yknKT/O1s3rWm2b3vZQAnH09c?=
 =?us-ascii?Q?RNt+xU2dJFQ8xprz0fZcs3W6qx0KtldumC2XUNid+eT+xtNZ6WnYA5ByLeoW?=
 =?us-ascii?Q?SsYfRy/OQAtfm4/OFvHUOSvFqM+gqQc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: xK+6cpK923NsNRu4vTNkdrFFJPMb/EFv5RrQ5scW60jS8lJKJcu/CTycmtOICIvCKrnZjaoHneE1Q/W9VoLPbd+48u2azadhVxyZhUL6DWG1mscuXteVA9Uo3lTHvIaFcuajzUqveTIx66GTDlI4Q+r2qTwmRyCEaZrXSjNzq/O0mmH2pSoX/LsWx+kviUgXyTmAD4Je+9dbvrrzpaJk8vgCHS1/0TaMEA7arp4Sk/zY52hhWLThxDYCMDpt6NhKueCEvttPWXbOT9Hl0v6Wrr22sBvt+iLV1sw/w1SELNfVEce8Gta5p+h2HMcNR1JCJeYxX9dnKZKkLd3snX1YSw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3ede42-c3b0-4fa5-fcfa-08df22cb4822
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 10:27:39.3780 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RTx0XnKRe1mWiK0C6y4aFhS+86lD7tEKShRP5M8OSKToUjuAsFBjFz29KDhoY5jMvtFPxn/QeAHSVjYBYCmqsfBfJI7Z5RdvKweHsZsAEIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB610166
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
> Subject: [PATCH iwl-net 09/10] ice: program multicast magic wake
> before tearing down the main VSI
>=20
> Since commit 5b246e533d01 ("ice: split probe into smaller functions")
> ice_remove() calls ice_setup_mc_magic_wake() after ice_deinit(), which
> frees pf->vsi. ice_get_main_vsi() then returns NULL and the function
> returns before it sends the Manage MAC Write command, so multicast
> magic packet wake and keeping a locally administered address across
> the PF reset are never set up on shutdown with WoL enabled.
>=20
> Program it before the netdev and the VSIs are torn down, as it was
> done before that commit, so the current netdev address is used again.
>=20
> i40e had a similar problem, where the multicast magic wake setup ran
> after the admin queue had already been shut down, and fixed it in
> commit e661414c98df ("i40e: Remove duplicated prepare call in
> i40e_shutdown").
>=20
> Fixes: 5b246e533d01 ("ice: split probe into smaller functions")
> Assisted-by: LLM
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index ceb9fec2af21e7..a885b3e0baaa5d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5456,6 +5456,8 @@ static void ice_remove(struct pci_dev *pdev)
>  	if (!ice_is_safe_mode(pf))
>  		ice_remove_arfs(pf);
>=20
> +	ice_setup_mc_magic_wake(pf);
> +
>  	devl_lock(priv_to_devlink(pf));
>  	ice_dealloc_all_dynamic_ports(pf);
>  	ice_deinit_devlink(pf);
> @@ -5466,7 +5468,6 @@ static void ice_remove(struct pci_dev *pdev)
>  	ice_deinit(pf);
>  	ice_vsi_release_all(pf);
>=20
> -	ice_setup_mc_magic_wake(pf);
>  	ice_set_wake(pf);
>=20
>  	ice_adapter_put(pdev);
> --
> 2.55.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

