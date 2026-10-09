Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEADCA601E
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 16:26:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D85C4093F;
	Fri,  9 Oct 2026 16:26:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ykC1CRqhSDIE; Fri,  9 Oct 2026 16:26:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0FAE94092B
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791563191;
	b=jtDvb68cEcNHIj27FPA3s0GucQAIm5WuavbgbDtZqPaXZrc1o7JT/NM0YT4JDGe+oLY/
	 79OJbSk2M0cUS/fiqUYqv90g17x9RmoIj1gVno9vmuV/fMKlAtTlM9Wx4rmd47vs1mta+
	 bJ6V7a9K05X361JTMG1OlvE1eYRSCFEtgAW245Ytcj9LsUhfR4P4niZH1qw8doltpNUnl
	 eDBdDJOyuQ2Xj01pJlTlPp5TWHlcLusOqdkvnfHReBfeJ0wtKTlQURlzGUdpO4ZKViZ/Q
	 aInNVIEST0uSI/SB9aC6lhI2JfW92LF5oM0z1ZsYLi8SbcG2sW8lSjsBgUjFALCl+pQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791563191;
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
	bh=gPbRnZqkmD6umv7RJJjBqXG1H5R5WLus0z9RjF5osR0=;
	b=b6pR1hMTtU4wysWULC20qR0dISBLTxEY+GDf9qkTvBQl7WAeHh4q22Stao8hh+108mWh
	 6/ZoOgEMILNZOKy7v4Q59SVNUF9Y63PSalItWccSiIqkFgZFGY4asacV++wliRV+7n9cj
	 BUs1HrKWLOzD6EK9DS21HLyr1V1l6541uujbNsd4ITNqcrRT4RlE6TiiL3xcd6w9fGsVf
	 sKL76kuuae/Aoxvp5r3a0NkE6bka/hk6Ho2slidhSKrXFNg20qr3uUX7pmYXB8gg8SjpA
	 hS2aMXFzmYfl8baxu+BcV9k3qlD0KRpqM6u36KqQAuzhB2QRo5JiklBL0PA1PTa8rhQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rr0goqJX;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791563191;
	bh=gPbRnZqkmD6umv7RJJjBqXG1H5R5WLus0z9RjF5osR0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dW2PkQtV62sZ7DzYxOWFQrWCVbKr14dGxzwX11GQJJwOYpEDDgvCwDapiq7Bpnhmp
	 1+rM3CGOtaf5ImADOFgDHV4kt5pKMzeAVlmf6wjRsPYn7o//DU5zyRtz0SkgtaB25/
	 Fp+NT2wrsz9oC6Dz4QOpEt6RCVd1uXtkt+dGUBSmrixbpA/dBZTsbTLDamLvw3Ave6
	 CrngviQ/vteEZOUXSskcT6H0v83Rlw1pzGhQvVv7OypNAKhkVSwRQbVC0oHeoc6dgv
	 7oA5WG3VZxr3grwYSyNo/FHQA8Fos1DRNv07owDJCDasyQp/WJPTyI5xt7CXHwLRii
	 5XNBucr6agw9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0FAE94092B;
	Fri,  9 Oct 2026 16:26:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 288BF317
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 16:26:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2608340931
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 16:26:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qrqwj2CLTveB for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 16:26:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 069234092B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.17
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791563188;
 b=pVkoXYw4CFTNQxPa2YUXVYKHc6GRgYv1CIFHVqdusMyQOjFQngZffV8N3i3hqRLRm4KR
 p1VnXIhw22SUDX+M1zdM1Jbof8R/XSn5z9DAT38v2FITvzIQAA6FfOjcJSwKy0sE56Mxy
 ukbRV9cChjRMVDaMHuCjOgHQ7VNrjYATGXI7072Mmu1HFDHMbsxZEYhM1CHf8+jmzspnX
 lmU6CkErV5PlIqSV1Gqzn2C65f1XiLcRt2CDM6NFgOmUB4QTHFl/QcdM3KMhtDyeVu4eD
 KRprWjrbn3jXpHc7ngqD/9m+J8XLCOZvs2GYSAJTFqyi9edhxP3IvER0wKQ929x3paw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791563188;
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
 bh=gPbRnZqkmD6umv7RJJjBqXG1H5R5WLus0z9RjF5osR0=;
 b=WXqR6qNs06WCa6Sz5+dKK5/cBg3z+/KLRQYxuDR5kpwCvVjnIGmljAI1g7uAghBvrpv9
 qPcSps3aQU9LelsJ5U+UVNTROw6ng50I2rFCBkP1ouDMn9XEuO2TnKLrN8mf0Xpi4Ku0a
 t4CYGmobJueo16RCxI/VdS/1TIKF6ccTNIw4wRx8AmJhwVWPaQjClE8filcv13I4EVmRp
 LZHXCch3mxo8C0Nq3ABWbDRDdJYqSGpi+ibHCX4a+QGAzWQN1TwdOxP1dIXkGmWDxpRh1
 uYjNur26dNhrzv/rujL+Oj8uR23lVsfPqDc4LreSklRj167fwuIpipfQo8zxNuTkD0g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Rr0goqJX; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Rr0goqJX
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 069234092B
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 16:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791563188; x=1823099188;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gPbRnZqkmD6umv7RJJjBqXG1H5R5WLus0z9RjF5osR0=;
 b=Rr0goqJXMSeArFWLLuW5AQ+UZNYHataYYBYUzOWXV7NypItflkrqi3BP
 6wA2t4F5OavLMMs1tiC8AP8hLuPNbK/2MFjFpOuxHOOJUgZUhqCP0PHmQ
 uDldks3uXjnbBiHwzrG27osKn/jRKYhRIlWdSjpBLGWZP9gkeM76qNbOY
 gTCA0Dm0AQKlweVCdfyh4klVAf6/B59Wdl0tOCbX6QP+vQYMh/tYwGb9u
 qtV/dEb6U+80Jc3T5h8apyDWuN9j323b46UvlUnRHdWbhF2DbICSeWqn6
 FfGbaZ2hih7C1QxHsMI170Jy9Fw8SPYCta0eL9LuA1qfiUSgwemmD2bZB Q==;
X-CSE-ConnectionGUID: xi26noFEQ+aQBDMT6AFRwg==
X-CSE-MsgGUID: hs7kYMLlSnKWNaTxirUmRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="373499"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="373499"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 09:26:27 -0700
X-CSE-ConnectionGUID: jjshuTdlQT6MUj/kZLpJHQ==
X-CSE-MsgGUID: /bkZvQ4dQ5SE98JhtjxPxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="2173357"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 09:26:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 09:26:26 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 09:26:26 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.70) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 09:26:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7WbiaGxUp+2dw4PFJtedMbW1EoQyp9I3QjDxCIsSo/c5oDzNm570qG5C5KXgWMtth4rO65ScpgQ1dczU9VFWI61zhuYnzuQDJmfjMONlDgFp40Kdjf7AVEIj8APzxcsHwW0wKWbi7aTcNK30eNZN8YNsJkOSWVT2o9ZXo6JSCf0xGNUl2a/oGWJKPopX+hQsE5bo0s5okGOD1MwbxLP6VwVjiwIKyyM78iuSNwEznBEeXqOj3KWrAehve7LqimC5LYLiGpYC3Aed7ErtIVONwzLtN3PqGBg+uOMhN5qB1tTRiWNyS6BodrUcZB2r0BMFFLX0x+yh45DncAGiV67Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPbRnZqkmD6umv7RJJjBqXG1H5R5WLus0z9RjF5osR0=;
 b=TDbxeFeqJ0705uSF6RTXTUvv6j1dA8ICaP/W42SHldcP3kwpEydZMNdTaDemAfrfA4BXEWyWNfCs8eX6rYZ8BUvHZPOL4svuUcAaQtfuMddcGv8sUuk2H+coIDaynHFdlmuUt252D/V6pFnLJw8kCmLCszGdKytjBoz4SWBtcxQe32+PsDSiNISJhAgACSzs9xujka6HkkvkxDO+sPF2Mi9j86HVXcGP+Q5Xf/3bkWrvS9Bofb99fywbx4OxyQB7/yCGhqcizFIysisB6usKthcvX89XsoIuyCY5S6BwakFbLE461u+8Bayo9kySXSIkec5az5QOCU4B4TSta0b04Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ0PR11MB4846.namprd11.prod.outlook.com (2603:10b6:a03:2d8::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Fri, 9 Oct
 2026 16:26:24 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 16:26:24 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
Subject: RE: [PATCH iwl-net v3 2/2] iavf: return 0 when TC flower filter not
 found after qdisc teardown
Thread-Topic: [PATCH iwl-net v3 2/2] iavf: return 0 when TC flower filter not
 found after qdisc teardown
Thread-Index: AQHdVaA+VsQncW5jQ0SxGPz9i6jzS7bwmJ0AgATRu0A=
Date: Fri, 9 Oct 2026 16:26:24 +0000
Message-ID: <IA3PR11MB8986E8FF67A174083BA3933CE5922@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20261006143723.2883728-1-aleksandr.loktionov@intel.com>
 <20261006143723.2883728-3-aleksandr.loktionov@intel.com>
 <20261006144948.734FB1F0089B@smtp.kernel.org>
In-Reply-To: <20261006144948.734FB1F0089B@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ0PR11MB4846:EE_
x-ms-office365-filtering-correlation-id: e36acf95-a63b-4c5d-493f-08df26220f8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|38070700021|56012099006|11063799006|4143699003|22082099003|18002099003|6133799003|3023799007|10067099003;
x-microsoft-antispam-message-info: EIW59EfnXqHLWJV+sq5KfCGjsL+bmDUWYcjlZoin6yE0V4P05xsFTm8UG6PP1UMEGXUrcKbsxkheTe/IT8eGWcAbdO85yc3ctlJD87bqGB0Z9AbjkgGrVqVkZFXgZZk+npfD2Ebtwvybd2gEjXng1yd5yZO8ndmfb4CMs+a4teacZKiqgZsI1CmNCytMga6W4XmHBHbRfGWE2+9hHywMWuLlfTYCQzXQ2Wm/b0KvFUCiD2oNU9+8Cw4HoEy2gaPJ+nrN5Qhlo7/bWBbmIcRlvyUR+cQOMNJ24tzJdnySUWbuArXYFq1qGSsaZIYYfPXO5uf0B0D8KBKFkWqWWAZK2zYnCzlkP+0cLwr3/4HMLS9cwEOUwJ0s7yrx0WtT7VTrBbIHMhv0tiTNZRgkz0jXmRIys5v3j9Y9QuiwE92rEAKgse0uBp4AfC1VVasCIBmvQD4gOo/1E2ohHmpNABRM9Fiyh15+DUD7efpIOjT3rSRK2wLVqhKTjctugh7Q1SpL7N6PobJOfzuMNMgk/bWeq3Hl+X/v6urVvKRj2hrVbsFmbakxrTvzue5QuzF+hgH+R5Rs54jbB7QZm6DAZxmV9laTg+VN1J54TT5nffc1MDSa7/y8xpud70jtoULkAEpdqaVZskYftkEP1eINdiffijWiFcL77nfi76Owy8m5pkk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(6133799003)(3023799007)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0NpSHgzdUdLS2QrdEJPL1pRRXVURS80eFZ0b01mejRPcWhWcEN4ZW5TVkRK?=
 =?utf-8?B?NmhKT2x4bzk5OEl5SEFaNVpNeUNWdjFXT3pEYVhJdkcvTnhZdkpJOWtEL1U2?=
 =?utf-8?B?cWdwKzJwQWlkazluVzhnR1pKd3hUdGt4SzhHYnFHYmI2bjhqNTBZT0hLWVl6?=
 =?utf-8?B?Q3JGZ0tPSGtnNFN6bzdtc0ZaUndkc3BHamNZanRZUytrZzluWFFtaDBVODJu?=
 =?utf-8?B?b1IvQkJNQmRKWTRBNWZNQ3NEVDB6RnZMTlU1am9BR1lqcGF2YUxIRStVT1Fh?=
 =?utf-8?B?Vk5pRnZ3RC9WTG9uMEtLUkpUNnpCSnJZQXFPQTJLWHRFeDhXY0pZNXBseWcr?=
 =?utf-8?B?UjEweVh4YXlibFIxcUlCR3dMUTFyYlBEUUsrSEkwaEJ4L0JSRjZyU09pM29D?=
 =?utf-8?B?YXNJcUlKTSs3MU56SFRQbnBVVTA3TEV2LzRnSTVzZnVaQks4em9oenhicFJZ?=
 =?utf-8?B?UU5GblplNFhsVnVkTTFtZWJjSFp3d21iQnQ0Zml6Tzh4bVY0Wm9hUzdNYklz?=
 =?utf-8?B?WFh4VDBsakxuUTdpVTNaaGo1VHR1bVcxSEpzSXg2OW5COEQ2Rk1jenNyOU03?=
 =?utf-8?B?QTdlQzFUQ0krbGVWSkN1TFZyQmRWdndTdFozZjhkSDZGT0RjQmNlWEVsR1k2?=
 =?utf-8?B?Z1ZtY1NDdnlIeU1VR0h4djRWdFZNUzdWZ1pVTTNuNCtEMWZsUFFuV3ltQVdY?=
 =?utf-8?B?S2t5UDBqTjUvRTdnMjZUSStoRDlnbGNrbndlWkRpSmZVdzc3eFR3dFNpSDZv?=
 =?utf-8?B?VzRlYkNYWlVVTzk5N09UbElocG1Ta25KbFBRa05aY1VDTGpSNWRLanVyWXVB?=
 =?utf-8?B?amx1ZzBPK1RiNVZzbEtwQTdYUXRDYUdxcGRsa2NTcUZBSUlkSW1hdW9KNlZ0?=
 =?utf-8?B?eE1uZFNtVGNUeTdueGN1eEUxTVR2NFNYVjJ3cytWRmpqVGdLdkE2NDNoRWRY?=
 =?utf-8?B?cW1PRTNqMzVQUnZoajVmR01GRGZ0WVhMRnB0elUvQ05YVVJDb3htVmpacmI5?=
 =?utf-8?B?NnJSMlJhdlJzbGpmeXk5a1BUSS93R0tuMG00NkoxRWdVVGF5b3hpaVF1MkNB?=
 =?utf-8?B?VEoxU2V1YjhmMk5MMS8zbWppUURBdE9QcmUvM3dYeE15TU1CQzdRRDZjUlZn?=
 =?utf-8?B?ZDQ4OXNMQlJUUTFTZWdCTUtORDk0RVliRlZneHlIUHVFZFhPNnlWNDZLRXlD?=
 =?utf-8?B?OS8yVElpUUVGN0FnMWNJbm4zRXpPTjl4Uys1QW9IUTNBc2ozUng1YWpuZm5B?=
 =?utf-8?B?b0JOV3Z1OTZIbFhaNE5Hc1N1dEp2NXVpSnVjdytuc0RYMXBRT3VtVDNjYlRv?=
 =?utf-8?B?ODlScGtpb202N2ZyOFhCVitxWG95T3FiN1JHWDZCMW50ajhoQlZ5djhCNVJi?=
 =?utf-8?B?dFZGTnZHYmlPWU52SEpsVFJ6enVrQW1EbnkzR0NoWDdiTHBGNjVkSm9SaXhU?=
 =?utf-8?B?a1ozM3ExVSsvYWNITTdlVnRhQXdhbVY0d25ycXRmNGEySTcwekMyMEdSbmZz?=
 =?utf-8?B?bUEzb2hnTTBLV0RuL0dnMUlkMDVTdGhjNWExbTluZThacTVZSjJmZDhRZGY4?=
 =?utf-8?B?VjJlL1E4THp3YXVlWmk4MzFIcDRRU3FqQS9rV2xiWnRDV2pwT21Gdnc1Y3Yw?=
 =?utf-8?B?RytmU29uOTdNaW11c20vNmRma3Y4RndYM0xjdTNjYjNzRitwMlY0L1FvZWJS?=
 =?utf-8?B?YWtMajhNTm1ZMDhHR0N5SU54QityS242UitqZWp0L3RhT0crYWFCSGJaSnc3?=
 =?utf-8?B?NTJXTDhweFpiTm9JYmViSTBRZGJEeCt6Qk1neExLSkZaQkxRRnZSY2lHWW0v?=
 =?utf-8?B?V29lMU5iM1dqd3lWTVZ6RitLOU9LaDVKRXpVU0ZYcUo3V2VCcFM2QzMyZGFI?=
 =?utf-8?B?R3hYL1VHU3liYlVaZCtiS3dHUnVyd0s0SmQrY2VXMnFHVDRiOTZFd1QyUHpP?=
 =?utf-8?B?SDBZbUNyQm9ha0w2Y3BscHByOHQ4YXBJcEpkc1Z2eThMZXF1UUtuUDc0ZXVZ?=
 =?utf-8?B?a2xNSU5lV2VoWmtKN0lNcUZQVUxhL001YU1HUHpGajdmOVZtRER0Q212dUdD?=
 =?utf-8?B?dnRYR1VnVnpDaWcrVm1lRXZjTjZTc0hvT1BEMzFWNy96WUk4NUxsdE9ZSlVx?=
 =?utf-8?B?QTFLaHBWcjhDZ2V0bmFUVFN5Zk93cFRuTUNVMmJNNFFuVFZ6eGJma1Zyb0xB?=
 =?utf-8?B?WkdNa1NoSlc4cEY4RWNCdml6Z09IaGFvbzR2NkV2TUIrVmszMmNqS2JFNGRr?=
 =?utf-8?B?V2hNTGxxNVpQOXYzRXRrMlc0K2QvMkgzTWFkM3gyRnZsQnFBbmJERU5LbTBH?=
 =?utf-8?B?d2tmYnZ0WDQ4ZEN4NGZ3dFhQZUJmWXc4dHljdkU5Z0dkR2RrQmNoWXYyRlZz?=
 =?utf-8?Q?FUAFiFoT/Xk5n1dQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AK8fSskHpDCrLFXMFJf7cNKAM7Vxp4q+LHDWZQ84Ny1VSA+mH0xO2GNZSPRZLdBMNvx7PwBIXqKXpVGJgu/ruCiCuyIDAfnTAUgh5I5JtbrWxTVyX/LxcH4GZG8NZyCZSe1YRml4vrJBnOsy5U3EOqYOAm0TcuSQzrCJ4gfsVt5fOgI4sx4J5ErgNeeUa/cZ6DB88r7uOlQJ9pp0MmimS6AtltmecvwbZ6fYI3nBBuxloTb+HnlVOkybM+hXL9NIgPdtqusXoChGmsoyep9T4PGAv/v9H2ZCIMCh52XDEyXnI1ASsXJa5v1ACkzgo6gG0c6eLdpE3WG3uHur+QH2uQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e36acf95-a63b-4c5d-493f-08df26220f8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 16:26:24.1595 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BhVPQc8Z4SiBop7gnE2YZc4r9oIj6AaPZZlxWyVzCyNbwZrZlbehd4ib/6yiFgrnFWMVkuCZF0Xs8PNsM/xeztcT7SB7gDTPwojx/a16dyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4846
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogc2FzaGlrby1ib3RAa2Vy
bmVsLm9yZyA8c2FzaGlrby1ib3RAa2VybmVsLm9yZz4NCj4gU2VudDogVHVlc2RheSwgT2N0b2Jl
ciA2LCAyMDI2IDQ6NTAgUE0NCj4gVG86IExva3Rpb25vdiwgQWxla3NhbmRyIDxhbGVrc2FuZHIu
bG9rdGlvbm92QGludGVsLmNvbT4NCj4gQ2M6IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggaXdsLW5ldCB2MyAyLzJdIGlhdmY6IHJldHVybiAw
IHdoZW4gVEMgZmxvd2VyDQo+IGZpbHRlciBub3QgZm91bmQgYWZ0ZXIgcWRpc2MgdGVhcmRvd24N
Cj4gDQo+IFRoYW5rIHlvdSBmb3IgeW91ciBjb250cmlidXRpb24hIFNhc2hpa28gQUkgcmV2aWV3
IGZvdW5kIDEgcG90ZW50aWFsDQo+IGlzc3VlKHMpIHRvIGNvbnNpZGVyOg0KPiAtIFtMb3ddIGlh
dmY6IHJhY2UgY29uZGl0aW9uIGluIGNsc2Zsb3dlciB0ZWFyZG93biBsb2dpYw0KPiAtLQ0KPiAN
Cj4gY29tbWl0IDNjODllNTc0ZjU5ZDcyMzE2NDVhOWM1YWYxZWU2ODE3NGZmODliODANCj4gQXV0
aG9yOiBLaXJhbiBQYXRpbCA8a2lyYW4ucGF0aWxAaW50ZWwuY29tPg0KPiANCj4gaWF2ZjogcmV0
dXJuIDAgd2hlbiBUQyBmbG93ZXIgZmlsdGVyIG5vdCBmb3VuZCBhZnRlciBxZGlzYyB0ZWFyZG93
bg0KPiANCj4gV2hlbiBhbiBlZ3Jlc3MgcWRpc2MgaXMgZGVzdHJveWVkLCB0aGUgZHJpdmVyIHBy
b2FjdGl2ZWx5IGRlbGV0ZXMgYWxsDQo+IGFzc29jaWF0ZWQgY2xvdWQgZmlsdGVycywgZGVjcmVt
ZW50aW5nIG51bV9jbG91ZF9maWx0ZXJzIHRvIHplcm8uIFRoaXMNCj4gY29tbWl0IHJldHVybnMg
MCBpbnN0ZWFkIG9mIC1FSU5WQUwgd2hlbiB0aGUgbmV0ZGV2IGxheWVyIHN1YnNlcXVlbnRseQ0K
PiB0cmllcyB0byBkZWxldGUgYSBmaWx0ZXIgdGhhdCBpc24ndCBmb3VuZCwgcHJvdmlkZWQgbnVt
X2Nsb3VkX2ZpbHRlcnMNCj4gaXMgemVybywgdG8gYXZvaWQgY29uZnVzaW5nIHVwcGVyIGxheWVy
cy4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lhdmYv
aWF2Zl9tYWluLmMNCj4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lhdmYvaWF2Zl9t
YWluLmMNCj4gPiBpbmRleCAyODkwZTNjODAwNWVlLi5jNTAyZTBhNTM5MWYzIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lhdmYvaWF2Zl9tYWluLmMNCj4gPiAr
KysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pYXZmL2lhdmZfbWFpbi5jDQo+ID4gQEAg
LTQxNjMsNyArNDE2Myw4IEBAIHN0YXRpYyBpbnQgaWF2Zl9kZWxldGVfY2xzZmxvd2VyKHN0cnVj
dA0KPiBpYXZmX2FkYXB0ZXIgKmFkYXB0ZXIsDQo+ID4gIAlpZiAoZmlsdGVyKSB7DQo+ID4gIAkJ
ZmlsdGVyLT5kZWwgPSB0cnVlOw0KPiA+ICAJCWFkYXB0ZXItPmFxX3JlcXVpcmVkIHw9IElBVkZf
RkxBR19BUV9ERUxfQ0xPVURfRklMVEVSOw0KPiA+IC0JfSBlbHNlIHsNCj4gPiArCX0gZWxzZSBp
ZiAoYWRhcHRlci0+bnVtX2Nsb3VkX2ZpbHRlcnMpIHsNCj4gPiArCQkvKiBvdGhlciBmaWx0ZXJz
IHN0aWxsIHRyYWNrZWQsIHNvIHRoaXMgb25lIGlzIGEgZ2VudWluZQ0KPiBtaXNzICovDQo+ID4g
IAkJZXJyID0gLUVJTlZBTDsNCj4gPiAgCX0NCj4gDQo+IFtTZXZlcml0eTogTG93XQ0KPiBDYW4g
dGhpcyBsb2dpYyBpbmNvcnJlY3RseSBhc3N1bWUgdGhhdCBhIG5vbi16ZXJvIGFkYXB0ZXItDQo+
ID5udW1fY2xvdWRfZmlsdGVycyBtZWFucyBhIGdlbnVpbmUgbWlzcywgaWdub3JpbmcgdGhhdCBu
ZXcgZmlsdGVycw0KPiBtaWdodCBiZSBhZGRlZCBiZWZvcmUgdGhlIGFzeW5jaHJvbm91cyB0ZWFy
ZG93biBjb21wbGV0ZXM/DQo+IA0KPiBJZiBhIHVzZXIgZXhlY3V0ZXMgJ3RjIHFkaXNjIGRlbCcg
Zm9sbG93ZWQgaW1tZWRpYXRlbHkgYnkgJ3RjIHFkaXNjDQo+IGFkZCcgYW5kICd0YyBmaWx0ZXIg
YWRkJywgdGhlIHFkaXNjIGRlbGV0aW9uIGluaXRpYXRlcyBhIGRlZmVycmVkDQo+IGJsb2NrIGRl
c3RydWN0aW9uIHZpYSB0Y2ZfYmxvY2tfcHV0KCksIHdoaWNoIHF1ZXVlcyB3b3JrIHRvDQo+IHRj
X2ZpbHRlcl93cS4NCj4gDQo+IE1lYW53aGlsZSwgdGhlIG5ldyBxZGlzYyBhbmQgZmlsdGVyIGNh
biBiZSBhZGRlZCBzdWNjZXNzZnVsbHksDQo+IGluY3JlbWVudGluZw0KPiBhZGFwdGVyLT5udW1f
Y2xvdWRfZmlsdGVycy4NCj4gDQo+IFdoZW4gdGhlIGRlZmVycmVkIHRlYXJkb3duIHdvcmsgZmlu
YWxseSBleGVjdXRlcw0KPiBpYXZmX2RlbGV0ZV9jbHNmbG93ZXIoKSBmb3IgdGhlIG9sZCBmaWx0
ZXIsIHRoZSBmaWx0ZXIgd2lsbCBub3QgYmUNCj4gZm91bmQgaW4gdGhlIGxpc3QuDQo+IA0KPiBC
ZWNhdXNlIGFkYXB0ZXItPm51bV9jbG91ZF9maWx0ZXJzIGlzIG5vdyBub24temVybyBmcm9tIHRo
ZSBuZXdseQ0KPiBhZGRlZCBmaWx0ZXIsIHRoZSBkcml2ZXIgdGFrZXMgdGhpcyAnZWxzZSBpZicg
YnJhbmNoIGFuZCBpbmNvcnJlY3RseQ0KPiByZXR1cm5zIC1FSU5WQUwuDQo+IA0KPiBVc2luZyBh
IGdsb2JhbCBjb3VudGVyIHRvIGluZmVyIGFzeW5jaHJvbm91cyB0ZWFyZG93biBjb250ZXh0IHNl
ZW1zDQo+IGJyaXR0bGUgYW5kIGNhbiBuZWdhdGUgdGhlIHBhdGNoJ3MgaW50ZW5kZWQgZml4IHVu
ZGVyIHRoZXNlIHJhY2UNCj4gY29uZGl0aW9ucy4NCj4gDQo+IC0tDQo+IFNhc2hpa28gQUkgcmV2
aWV3IMK3DQo+IGh0dHBzOi8vc2FzaGlrby5kZXYvIy9wYXRjaHNldC8yMDI2MTAwNjE0MzcyMy4y
ODgzNzI4LTEtDQo+IGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tP3BhcnQ9Mg0KDQoNClNh
c2hpa28sIHRoYW5rcyBmb3IgdGhlIHJldmlldyDwn5iKDQoNClRoZSByYWNlIGlzIHJlYWw6IGFk
YXB0ZXItPm51bV9jbG91ZF9maWx0ZXJzIGlzIGdsb2JhbCB0byB0aGUgd2hvbGUNCmFkYXB0ZXIs
IG5vdCBzY29wZWQgdG8gYSBibG9jay9xZGlzYywgc28gYSBmaWx0ZXIgdGhhdCBsYW5kcyBvbiBh
DQpmcmVzaGx5LWFkZGVkIGJsb2NrIGluIGJldHdlZW4gdGhlIG9sZCBibG9jaydzIGRlc3RydWN0
aW9uIGFuZCB0aGUNCmRlZmVycmVkIGlhdmZfZGVsZXRlX2Nsc2Zsb3dlcigpIGNhbGwgZm9yIGl0
cyBsYXN0IGNvb2tpZSBjYW4gbWFrZSB0aGUNCmNvdW50ZXIgbm9uemVybyBhdCBleGFjdGx5IHRo
ZSB3cm9uZyBtb21lbnQuIFRoaXMgcGF0Y2ggY2FuJ3QgdGVsbCB0aGF0DQpjYXNlIGFwYXJ0IGZy
b20gInRoZSBjb29raWUgcmVhbGx5IGlzIG1pc3NpbmciIC0gd2hpY2ggaXMgZXhhY3RseSB0aGUN
CmNhc2UgdGhhdCBzdGlsbCBuZWVkcyAtRUlOVkFMLg0KDQpEcm9wcGluZyB0aGlzIHBhdGNoIGZv
ciBub3cuIEEgcmVhbCBmaXggbmVlZHMgYSBzaWduYWwgc2NvcGVkIHRvIHRoZQ0Kc3BlY2lmaWMg
YmxvY2svcWRpc2MgYmVpbmcgdG9ybiBkb3duIHJhdGhlciB0aGFuIGEgZGV2aWNlLXdpZGUgY291
bnRlcjsNCkkgZG9uJ3QgaGF2ZSB0aGF0IGRlc2lnbiByZWFkeSB5ZXQuDQoNClBhdGNoIDEvMiAo
dGhlIFRDIGJvdW5kYXJ5IGNoZWNrIGZpeCkgZG9lc24ndCBkZXBlbmQgb24gdGhpcyBvbmUgYW5k
DQphbHJlYWR5IGhhcyBTaW1vbidzIFJldmlld2VkLWJ5LCBzbyBpdCBjYW4gZ28gaW4gb24gaXRz
IG93bi4NCg0KVGhhbmtzLA0KQWxla3NhbmRyDQo=
