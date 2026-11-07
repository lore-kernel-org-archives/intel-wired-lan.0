Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59837606A32F
	for <intel-wired-lan@archiver.kernel.org>; Sat,  7 Nov 2026 04:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=yJA/s2g8;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kG8M3Zvy
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C0A0813C6;
	Sat,  7 Nov 2026 04:54:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jp7p2GsuXsGJ; Sat,  7 Nov 2026 04:54:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8BD2E813DC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794027284;
	b=YQ/x+F2+7ceymrmvfkzhTUmfD6mM9vhoIiSHBpeAQ+aInCeRkzehsjN3OUeTtxegRilO
	 WWD2qWxk8T9dacS5SjLjicS5uXQWdhixoeu+iMtxHlzbhhNAPKrzY+PB18YOs/zHcHAi1
	 2zkEADNEZJ60pXAiOozoKm3o7a7x2LGcqROL3TkrPYumxpAiJufLL7GLsFNCe5YD7GZQq
	 Dy03m9e7YoGQP98+iIK569hIsxzgTxEoulX/sbVuMBKos6yVQtuciMWEyBaDKnPpQwCov
	 KI7NdhcxxCqqDXqgLJPZJbFUyFfBIS55QPczixTw2D67bTBuuKdLcwzuNhpejcdWh7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794027284;
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
	bh=a5QUFltmlv+0irPqDs+BFNI8qvxG3i0D42wNQCVnrFQ=;
	b=oz2VlXrgkyy8JxK0ocCZNXuMUwDAFlDzaRvOB2LGvqKkgjKDpQq/Efps1wrZ4S4CzNAu
	 JJbXlKzoa7JRq1lH0OBXhEV3prywocix+rjjVN9MM1ZumNLA+5+my9nCd5NPsFOcdzwwf
	 ik9RASo0leAG7b3ZX45yeWAm7pYzmtoO1bLmuEyn6fjSPhH2Imjb0rOrMrSgZ9IjC48OZ
	 pGZi4jrR7YbN2b3KgQ40aFHJ3Rb2cHHv8u8hzSsTbBe6cKEjPPeqinejLU9oQbWGXkoXp
	 TIR1jQVhuhI8l0C9cFayt2IR8vokl/AZ23ySF8Fs5PTjIc/h6izKmHF+hbiu5SvuQAg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794027284;
	bh=a5QUFltmlv+0irPqDs+BFNI8qvxG3i0D42wNQCVnrFQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yJA/s2g89C12ZlIYhYnpXSdYmEHeaTfBFDFdJJrRy08cMyZPmT33jTncuEYeupr4K
	 FDyBN03Ughhsq+mHyYjPWtN5eo5JmP4J1gAv1akCQaUoS0DjYGvaqmMbrikxzLEkgj
	 vMysbj68d4/uxtLkhTs26zRoi5VAL8VNSKY12taxr00KsG6xjA9X+RW7qgvNm8KjA8
	 dIrphYOGfIAEvr42WPDY0pcb+kO+Ke9GQAsPT8OEofvoO4nXBi+qB2uM3gOrfZm0qD
	 Hjq2ZmtkQoAAmA0ho0X2X/1yUYglUaAmc8CN9XvhnztRhddM448qhNdGGxXZM5DCBh
	 iKqoqt2Cq1rtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8BD2E813DC;
	Sat,  7 Nov 2026 04:54:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5188832A
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 04:54:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F01340994
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 04:54:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CiNdNN6ZD2Y5 for <intel-wired-lan@lists.osuosl.org>;
 Sat,  7 Nov 2026 04:54:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5CE8140993
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=kG8M3Zvy
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5CE8140993
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 04:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794027282; x=1825563282;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=92vz2gaO4WgbJW1SVRN2DBc59UafZmWt1Ui8hJe+PfI=;
 b=kG8M3ZvyDBmY4g75CpNTgYWEKw/ZFtk6iTGdZxxIY1Bd4eg+MpyXKynR
 7/+jdEBxQTy5BcVkMQDg0eNvk4Li9DMAZnUaHqRqSKz+gXxtw8U4kvUNw
 GwNu4HQ25157yykHqH92f+Zwvlx9Fk0kHSQsV+cY6L/lOWKxmzAjkXS86
 cjJalZbUGRgjk5ECUXxW/C2a8xdTps7+4Z2oSQM4eXeh97R2zx+c90UT3
 Pv/1+J/vupItTs+4NIb8fb7Diwx7vwIjLzZGVGR4EiAgiZJmoNCYooqUQ
 D74/QH9c2BVM7K8rUxE6vcwcpEfQ1bruup9TVifvnKON8hlLgj+d3GT+V A==;
X-CSE-ConnectionGUID: WDnmdtQZT8+mgwmy1lC+vg==
X-CSE-MsgGUID: B6hNiKE0STy9P83QJglUuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2941179"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2941179"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 20:54:41 -0800
X-CSE-ConnectionGUID: AoOnwmE4QhyfjocETu1v1g==
X-CSE-MsgGUID: 1oPuBBM6S66kWBst1CK8WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7458740"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 20:54:41 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 20:54:40 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 20:54:40 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.55) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 20:54:40 -0800
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by IA0PR11MB7840.namprd11.prod.outlook.com (2603:10b6:208:403::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 04:54:36 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0592.007; Sat, 7 Nov 2026
 04:54:36 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
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
Subject: RE: [PATCH iwl-net 07/10] ice: take the switch rule AQ error from the
 response descriptor
Thread-Topic: [PATCH iwl-net 07/10] ice: take the switch rule AQ error from
 the response descriptor
Thread-Index: AQHdUm8/f0cri7lr0UO0+Iu+GrOUC7ciQy3A
Date: Sat, 7 Nov 2026 04:54:36 +0000
Message-ID: <LV1PR11MB8790A8D241A07D5C0666F26890752@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-8-poros@redhat.com>
In-Reply-To: <20261002130752.2597259-8-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|IA0PR11MB7840:EE_
x-ms-office365-filtering-correlation-id: 337d34af-f904-4af0-3b50-08df3c8b38f8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|1800799024|22082099003|18002099003|21046099003|10067099003|38070700021|56012099006|4143699003|11063799006|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261022113327099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261009223027099003;
x-microsoft-antispam-message-info: duADFSw48GJCk+lrxHNPn2gG/MTazAdZ0RQE2ys5azN2EltBRWI3FfNc5pshfDDRsyJhb7oLFCVuoQrgMVbsGKO4kSQyIqbw006F90R8SBvnbX118/e/1VNRDemu5VZiWIPutlE4XhIgD4MFaZsCa9sxi2MitdiGI1SbrKV4i+6qqFvXOWANRzNMdm/3Ug+Jf8VSxCSRs0IDszHMNuywjYRbqt0pWl5lyOuFyEvkvYelevRrfnw9wLxv/JAXyxx98MV6BPV+1iA0juypNHeBEDzJkgqSNlOdtfNIUM0IsCkaHe7k4zPuF7zoel+H/pTgXNGFvMOapuksqfZNeAOALXmvsTvCeeE2xaCZgwniHM1UV+yHM04UKeSK//vi7MjWTDTh8vAEtOZa6znNCfbGMhzN4O269kjU6g+JrJrk1/Itt9zAuXOz1uDBaH4q/+0zzsiz/2CpUcgAwPk3zjqmiXdOdBoFwkBtQR0Svd+c9ZRTmhiYisy8nw2OHP7LR/6rUKQtVewArjQDviP4qQrCBRx2itOj9/3GShjI/o4C7VFc5744k6s04fEwJYW+47/as56uJ2tlm9ArWGes5q31mD9d1mfijT+CwuOk3q9KMSmdsdvW9PdpgC8GEGe6jv51dB//jkVu5pDLlgo2/jpmhnvnbLRI6vZev8mIEgixUy1QivqrbFPK7KmFt/0MjCnSp4FB+wG4gX4VllcmeSJY9TF9F4sRW9JXnQ0Ah0OjHkw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(22082099003)(18002099003)(21046099003)(10067099003)(38070700021)(56012099006)(4143699003)(11063799006)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261022113327099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ut2pmN/BlqJxb4vbSvAqb0kFhtE4kPKFjeSUA0FvkCb3Z8WtmM3wSv1V9nta?=
 =?us-ascii?Q?gisYNrR/Wvc+CUrlXKJ2eCMPhc01DNe4+KbYLXBaQc0Wwb8mSYvKdSoUbMff?=
 =?us-ascii?Q?4qARMe73dJA5xU2f1e9iCXzDNe2h9N3XtktufZimap/aAxEbP2cFQUG0uIfx?=
 =?us-ascii?Q?ipohy1ccBtmBcGNaUFc88q4t1obtoqXz8lw7j1F4BuECbcULCbP70zljJbtG?=
 =?us-ascii?Q?9GBdmHFKW5VNwcf1Td7C9LWQ3ExZrzFNagyDL91NaxVN+V2j7TPIzN8LnrDY?=
 =?us-ascii?Q?9qvW6nTywbh9pce2dRNIrls4fyfy6wsvFl2w7djMS0Ds4N+keBgwEAamIhrV?=
 =?us-ascii?Q?MuczTOI7H3QBPSBIaJJhCodJPA1iE9UxDhao8EdYFQkyxYDGSzES86rxPnJN?=
 =?us-ascii?Q?c73OgsBaiCUlu9vvlUstCY2X1LT0Hlzpa3BZXtLCwhuv1ey6ypdm/WJUI1cr?=
 =?us-ascii?Q?Mx4xx2lB3NqnT+sVd9ggLG+Utr2JxYlwmT2kOZ5Ng4vvncyqqy2ENIb2XHsr?=
 =?us-ascii?Q?NkTcW+EdEU0ADLVCZLZNjTovsQs2UPgDG9L+7+ca7aM8XqPyCj2l/CUuB+wt?=
 =?us-ascii?Q?4ql+TuqBshonFSNbIHQb6PDMjhYlivSyUrrO8IyfSPh9P1TDzSIAzePn8eAr?=
 =?us-ascii?Q?0snJ1P8DCvuUJP+0BRq3x2GNk5iKTi4EnzbMqwPEyZCS5/Z/BrKUDDSU/1fc?=
 =?us-ascii?Q?Mqrurb4RpUnj59Pj7yiKodzYlv9w1iWg00i3IG+tj8odi+cWRO05duMhHhKG?=
 =?us-ascii?Q?04QbUDAk6xtVoipIGF6eSWdDuh7Pku+SS/HvTxyGgw4oBHfjnF0PSDA2ddNc?=
 =?us-ascii?Q?V96B0iYI1P2XsPfaMGIzycTLEbaQR/dHbW7YAtkAR/81tumHG4PO08ByerYv?=
 =?us-ascii?Q?gmkQPgweI9Z4YEJ5T+95nBkOjj1nIAJaVthoIzyiFaH890gziq9+bITIDYEe?=
 =?us-ascii?Q?ZSob0u2IzwoPe+YmZhhTC4aVy0LcOK22nwei8UXIYliP2h0NUwL4R2zIwve6?=
 =?us-ascii?Q?XCmrTotNe5GipbvgYR7hDdCG/g+emVuzJgOb95D6AAUSZFcaJHlVyN+bp+w8?=
 =?us-ascii?Q?xID6hz0si2xR08W15DDPtjvcGjlq4xqwWsCM//KvhyfU/CQvemPEBbIJeZpY?=
 =?us-ascii?Q?DlHB9hcITFkjBa9ExZGWVTRioR9JBNn9QssVWlQa5UysOZfferoRTBkv5rNG?=
 =?us-ascii?Q?aoJq5XpyRgjDPHW1u7hX60MOBy2G0o8hzWy5uuW5BjIpGTyEpjMZb45MbiMe?=
 =?us-ascii?Q?AsFYWBwrVvuW1myY7DT1CcHKlWXWDHSwa7FwGDeeRczqYcC9Db5CZvFQ5Gvp?=
 =?us-ascii?Q?0RlxHVDp5GiOK/cDPe8/clYLXwM1v8clahZB8JOECDSAaVFtbuLYaGUnoaZc?=
 =?us-ascii?Q?8icdrN4DIeAe2J40JTtq0sSb7xyL9LcPftk9ni1tXn7jGav3NyXtjmdJXatH?=
 =?us-ascii?Q?lspTyUUhsnxhv/l1MElhZ74puUU+jVX2GKnR6JD7c9Ggc7Y2TrWcNdTOtxQh?=
 =?us-ascii?Q?KLLXW1xJa5q+be/WM42NnaPISCEVN4Zo/Mrfa9rp1sG9nkdPyidx96a9MvMD?=
 =?us-ascii?Q?n1dm8audKdI7ylUh2GMuRCYgfcPGtAoPP1RY/YDoF9lZ+84jlE9bcGmb/zd4?=
 =?us-ascii?Q?PhNVhFKeO1rj1BrQUwsYyiynmGRM7Yx4NuifsBisMAmKFjOlGuTnXM8TvGOi?=
 =?us-ascii?Q?5ipbTQ+mQcvZ+ynnKyywiU6IZe8jgvB//YPMfAGu72LBTa7oapjvIjkhbjFm?=
 =?us-ascii?Q?JGxOc2DVJQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Yj43rpC63BqiHM19Vctth3IHKZWfzSQPLlRVb5aHdYlmlR4tkrcsY/xAvXvfHV7hsDmj78qgPPlr6aO4sS3wvjYOmIgvtCDqj30jYcLc73GmWPTjbCmWuLCKSJdo+oHzFatkiiElH7fZyNsqQwSFwgJruxAunFcWzIraetcp0r/r93IeIFrbkD0JZnUAcO3vHVRZA4IA9kAM/2sHZNV3eW0TN+YWZLgYzq/2nLM5ysX+qTHPSplEGLO3dNaYUJdVMcYE+lbS/+Umk9lUuuc+bonFqiXV1+91FOP8OBc/j6u09bjBqmHBlEf01u7DBs9gJXVOd4xm1nmu5/o6sYXsLA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 337d34af-f904-4af0-3b50-08df3c8b38f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2026 04:54:36.3415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SZh3AvUNLWgr2wOJ35vYO10SsQO9fHkrM5Od3G+iuwPtIGFz+jGqj4ASqHUeSUeGulhm02rQUm+zYqTq7D3/WZVLO6JvEpHZGJtEiKZmY/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7840
X-OriginatorOrg: intel.com
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> -----Original Message-----
> From: Petr Oros <poros@redhat.com>=20
> Sent: Friday, October 2, 2026 6:08 AM
> To: netdev@vger.kernel.org
> Cc: Oros, Petr <poros@redhat.com>; Nguyen, Anthony L <anthony.l.nguyen@in=
tel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn <=
andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric Dumazet=
 <edumazet@kernel.org>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabe=
ni@redhat.com>; Lobakin, Aleksander <aleksander.lobakin@intel.com>; Alexei =
Starovoitov <ast@kernel.org>; Daniel Borkmann <daniel@iogearbox.net>; Jespe=
r Dangaard Brouer <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.c=
om>; Stanislav Fomichev <sdf@fomichev.me>; Henry Tieman > <henry.w.tieman@i=
ntel.com>; Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>; Micha=
l Swiatkowski <michal.swiatkowski@linux.intel.com>; Jesse Brandeburg <jbran=
deb@kernel.org>; Preethi Banala <preethi.banala@intel.com>; Kiran Patil <ki=
ran.patil@intel.com>; Dan Nowlin <dan.nowlin@intel.com>; Stephen Hemminger =
<stephen@networkplumber.org>; intel-wired-lan@lists.osuosl.org; linux-kerne=
l@vger.kernel.org; bpf@vger.kernel.org
> Subject: [PATCH iwl-net 07/10] ice: take the switch rule AQ error from th=
e response descriptor
>=20
> ice_aq_sw_rules() decides whether a rule removal failed with ENOENT by re=
ading hw->adminq.sq_last_status after ice_aq_send_cmd() returned. That fiel=
d is shared by every admin queue user and is only stable > while the send q=
ueue lock is held. Another AQ command completing in between can overwrite i=
t, so a failed removal is reported as a generic error, and a successful one=
 can even be turned into -ENOENT, because the check is not limited to the f=
ailure case. A caller that sees -ENOENT keeps its rule bookkeeping while th=
e rule is gone from the hardware.
>=20
> ice_vsi_sync_fltr() has the same problem with ENOSPC. It checks sq_last_s=
tatus only after it has freed the list of filters it tried to add. Every en=
try is a separate devres allocation, so freeing a list of thousands of entr=
ies takes seconds, and by then the value usually belongs to a different com=
mand, so the MAC filter overflow handling is never entered. With debug prin=
ts of the error and sq_last_status added to both places:
>=20
>   ice_aq_sw_rules: opc 0x2a0 status -5 aq 16
>   ice 0000:04:00.0 enp4s0f0np0: Failed to add MAC filters err -5 aq 0
>=20
> Use the retval of the descriptor that ice_aq_send_cmd() copies back, only=
 when the command failed, translate ENOSPC on add to -ENOSPC and let ice_vs=
i_sync_fltr() check the return code instead of sq_last_status.
>=20
> i40e fixed the same kind of race in commit 53a9e346e159 ("i40e: Fix race =
condition while adding/deleting MAC/VLAN filters").
>=20
> Fixes: ca1fdb885e5f ("ice: return correct error code from ice_aq_sw_rules=
")
> Assisted-by: LLM
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c   |  4 +---
>  drivers/net/ethernet/intel/ice/ice_switch.c | 13 ++++++++++---
>  2 files changed, 11 insertions(+), 6 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
