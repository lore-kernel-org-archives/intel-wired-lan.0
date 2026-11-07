Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF70606A32F
	for <intel-wired-lan@archiver.kernel.org>; Sat,  7 Nov 2026 04:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=VigVeoM0;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Bbb9ZhIY
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A1F35606AA;
	Sat,  7 Nov 2026 04:52:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rodq7lpHA8kB; Sat,  7 Nov 2026 04:52:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E6D74608CE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794027128;
	b=Tk7etb99yfGzAuHVwgZWxaglCaTIuFn7fI5Wi/awhroDePrxdQEz3QkEyJSXU3ONj+CW
	 2teH138VgIpRSS7AB9oF3il+6w1Cr7aXKslmv8pKtHWDII5pnXpf10xRiK9hBW9a8MKoY
	 uBwujv8lXVxRmiYwdJa2BYI098shfyyoBf/dAftJDSb9EnspsyBsbfO+wQSQ9kbmurGSl
	 Z5YrSBCvc9wMSXvtCDXS2I9Z6DqvMH0Kv2mbXQ6P0oi/zOs8OFbJ6TMH+0TIiNVMgqv90
	 ZQQCQbopxAMORrZi9p6/z4q5f7A92kC+gA2KGGVOOQvNt+2BNJKIFzo683mnkOOwqMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794027128;
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
	bh=6E/i9+ua+Pafmpqt8zUjThep2kdrNhSLP6vWoCFPmzc=;
	b=Vq1Hb8YBu1MiVZwpikrWhOMQucZpxCIAw8LLq2nJWrK+/wwqnYw93b+zz+T+cu1t117D
	 EMspL6QooOlcd0k7ZctlqwQHjrTXo2DXWf/7deE60a87LYdv1KvY6ggzD4wD8vXnAc4BC
	 slAJm4pHOf8g/s3Uiq8z3Kvd1wHKbH1w0p1uq9F4TEYnoSkm5oMLi4Q8HWMaNwzt9CVBl
	 GxdLGb066IHZvS0swMQgu56wyOxMEbyxZlNuHHisRgA+/QFAdQ8h8oDsLNGbUuHjzzgOx
	 Kp1TRqs4EWJgGCRXegLB8uYzNe8szKT5oQrPqycdl5EV2/hOu+zxQOmHF1o9EzOrusw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Bbb9ZhIY;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794027128;
	bh=6E/i9+ua+Pafmpqt8zUjThep2kdrNhSLP6vWoCFPmzc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VigVeoM0dfvnpMMJr0iu4+NTk030MlIR84xq+oGdyn+b05rju3OU0yDwnpwIao3YC
	 obAdTmfLkFXOyLD8UzE/GBJkrNKxvdLwOASkmfzF89b7Hgaos3Lk+wlz9AnHMvXiU3
	 wJpEsURPfGg/+mJ4bDUsaFaBXKdiPoHNrR7i/9AVQWw6ZHyQhmG+72VMnKZZzUeEKK
	 NvkgI/J/Uqx6WBpmIql18OEJDbumLoF0/VpzSkp4dR2Xksv8CXvo5EdWDLUi/KogV8
	 pDyRqVaQI2tnKRz64QtRhbsDpAInzFCeBgPFw/b5OF/xwOWcdiTseoZgPc3UybsibQ
	 zXNmT8kjq038Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6D74608CE;
	Sat,  7 Nov 2026 04:52:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 23695A64
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 04:52:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 08154606AA
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 04:52:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bS3qXl11r0Qr for <intel-wired-lan@lists.osuosl.org>;
 Sat,  7 Nov 2026 04:52:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 23E8D608CE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Bbb9ZhIY
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 23E8D608CE
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 04:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794027126; x=1825563126;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kUQRGirSF5GtFhEES4inzzqGW3jhS9t3vroL2f9ud7w=;
 b=Bbb9ZhIYekVkVG8/fuomk9eNd472VMpc2jLGSrsLm6poKAikpyG4MyhB
 K20JVqPBqXdGC7SimQxzy3APqQwQ+mbCg5Izxfkfki0JEp83IJM+dKHY8
 muakhhLQQrx9gqp+cKAX3ddykqqZ+u3J7WK/OHpeVyvj3mjtBTyRzj6wz
 uIWNa+zXmFpE4KYu55PlpuA7K6cITAmS3Xt17SLSKyWXsI6q/X3OXEBzB
 7mmN8aciaCkQx+S6zNdcQb0fqS/zYtxCVLkjgRkqDL+CEk18Nbc6riwNc
 7uqp6tLafXZf1q5DKVdVrB4yPBgGxQ7YnGXj4dnmroqhWdxQ5azt1kxM1 A==;
X-CSE-ConnectionGUID: HiNTQCnWTz2inCweNmWz7w==
X-CSE-MsgGUID: QgVGpcazTrKdr4Y/yRFQcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2882012"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2882012"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 20:52:05 -0800
X-CSE-ConnectionGUID: CSZYshYoQAefoq5BPRJ+Pg==
X-CSE-MsgGUID: RUrCci8nRhiG/emd5iqlew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7768667"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 20:52:05 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 20:52:04 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 20:52:04 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.13) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 20:52:04 -0800
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by PH0PR11MB9727.namprd11.prod.outlook.com (2603:10b6:510:399::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Sat, 7 Nov
 2026 04:52:02 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0592.007; Sat, 7 Nov 2026
 04:52:02 +0000
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
Subject: RE: [PATCH iwl-net 02/10] ice: fix IRQ freeing in
 ice_vsi_req_irq_msix() error path
Thread-Topic: [PATCH iwl-net 02/10] ice: fix IRQ freeing in
 ice_vsi_req_irq_msix() error path
Thread-Index: AQHdUm8xkVxgtypUsEKgxPuigWJzQ7ciQmpg
Date: Sat, 7 Nov 2026 04:52:02 +0000
Message-ID: <LV1PR11MB8790FFECF2A95C0822E9D65590752@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-3-poros@redhat.com>
In-Reply-To: <20261002130752.2597259-3-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|PH0PR11MB9727:EE_
x-ms-office365-filtering-correlation-id: 667d6831-f424-4acb-d195-08df3c8add2e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|38070700021|11063799006|4143699003|261021121427099003|261022075727099003|56012099006|261022105027099003|261021123027099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|21046099003|18002099003|22082099003|10067099003;
x-microsoft-antispam-message-info: DI4Utk2/dVNEZXAqZSqSgXB0ybSYZkUGcpwvzuDhVQaqs/5QX1Z47HEyMrbcnb+ZShMUeKv5VaTXx4VWDJQH0zYAayeoEqNi3B4rsUQoFHTEXJ8gae6LEJOtuROvF5/VIW5vpBOljKj4x6Iu6sEgtsAnTw8VAQqS2KnR6ZSXV4akRsRnNIp4oJk21Tlj0zRKyeYc20xK4B/SyJWvwy6bXqXEo47zQc+Y/QZElTDseQxYKa6YCFcJI29cmAACcWjtfeZNqZPAenraW/k8xeP0CECHCU3xYjx39kcqHvueuE2WcdFsOA+ogBcbNEhIXg1qlXUdDcf5SCFpq4kziQOipqOdUiUIxife/iarvdbIrTBFR7hRbuJmhSiqyX1KpdkHssUZdbYVK5XF0T8QYf0RWmLDKhahc+OkiRyRmPUup5k8ttqbQi5aAVxpDRnX7eQBmsNC2OEOg8FtJdU79pn8/gV8KpfiE0nhd7CfleRAd+sATlOavQFgvT0GVU4qJ8hi6uKuenRBJ7nUguExczfmKMOp64SLZKahE0jnQ31zJu0znE23WxJLlXvl0JE7sw/vrVCN5mbNhRdrC5cPLWLtsNlsBzz0SciVyWMjq8DVs/UcB2xD9OjDQpsApxfgz5Yrmq7rdXdeAtxZUD6VvJOjM5DZ6vzzAsp6SNFHhtJN2EXD23a5/hvl9qf8qrmtfc9v4tiBhhJMKXU5bX47MYEU58My/Ka6S/h94dNT8svdghI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(38070700021)(11063799006)(4143699003)(261021121427099003)(261022075727099003)(56012099006)(261022105027099003)(261021123027099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(21046099003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n/p0kiH3RJiq3Gds1YNxWN4FdRfIvfvRIeJ73QZH7LdYBc6azJwcvRKAVW0u?=
 =?us-ascii?Q?SAj3EM/uz3wfP2JoGN0RU1YWV+iBR2TIkR0BFZ1ZOAVWYSIhyVLV8qBmc/d+?=
 =?us-ascii?Q?Y1L9ye9At4RXMdO9pBnj9SqkaS2j2ZIQw74k3lpwLWzcr1UChZ8sjFkTHCW5?=
 =?us-ascii?Q?nPte1/qQSK6n9S2e490JPnzFl+zMqctcQwP2hygUyH4PwYERxK/y8x+NAUXa?=
 =?us-ascii?Q?TA+QR9zHqp+8ecB1NXhqQEOkFLQwWfwUsJmoxF3BD4jY1Xk3RgHaDlv4vOXL?=
 =?us-ascii?Q?84uTA2ZCcfoy+IeTvNss1sKIVMxUCZO5iy5x+fzD8DmTNtzDB18rOkBjJ6DD?=
 =?us-ascii?Q?uUCOHkIZboF4M3dkyX8kHE0mw97v6VwPN1UkCg58nKwA2mNKRvkwyfPhV+XR?=
 =?us-ascii?Q?ZGDVOnNV+yQssydgAKLibd+XOTkSmp8m+WDvqJUQIs4LIani5Y9eOJa3/rRZ?=
 =?us-ascii?Q?2EVAlKeK+B+6n/Dpm6RJom6yTpV/fyUgBzWgNPq+XS51wogx9LO/tuZxhPKv?=
 =?us-ascii?Q?EY32HHHsQGuIdriOGuuXX+od8vkIGnxFkk5yuEOIG80ioRiXDIaWnu6w1Ki2?=
 =?us-ascii?Q?4Bs6YwhnggnZyN8CzsXCYik3H2flshaisT5rjgOLVAhfKmZ+y3kTxWwDeIzo?=
 =?us-ascii?Q?30y50xkmFLvdyXM3YLdf04gDEWLszXgcssaV9MirKcoRZDFEq0geDDhSIH91?=
 =?us-ascii?Q?nHJkRTg1FHklJ7v7vC8MoqLrYVcG1LOA9CujRW0aEtztrXQmYLFHgqiIJ3xe?=
 =?us-ascii?Q?R6+zN4oxbcyVDh/FGoJ/BkXRhQfQsNNEwJ7crrJVz6az1zOD6piSIaO2QEFT?=
 =?us-ascii?Q?T/TK4c3/YUTAv99edGQ6rPH00YaDmtIaKQ832xe3AuFOXt56c0BpB9ev6dOK?=
 =?us-ascii?Q?ZzT/JQsqwYNGQGM00FJPj5DDpskWsiyWus4281zfi9PmZei9g5+DKyCE9Cxm?=
 =?us-ascii?Q?iZQvx3Ptfi30w0IW1w7oR+iZIIGuVCWg82BP4zhlKef/DU5czt8i87RMBfwX?=
 =?us-ascii?Q?/z42eujwdaFC4NSqXoIeVGsg43ll6SRtSuuJK4ta7Ui9cPywoBBAXrzuMCIu?=
 =?us-ascii?Q?yQylwPyQ704ENCzjjNkZkbyNtwE2GVJNwzXneirP3lWHD0PrVAwMRX0dSQee?=
 =?us-ascii?Q?+K/bX/S6rQw/3GhqZ1tFnEhZ9XVBYOz5fsLadWRG7ifdSfaX6eZIN5iI/gyv?=
 =?us-ascii?Q?zGQVgkaST636IMF4TWUi+0h0L96/jqN7qTHT+QJHOAbODAjobIvKaNg5d5XL?=
 =?us-ascii?Q?MDERYNwcQTCr2oM73K3damTWPgK8tPAI7YuOOP7pwN6/ysXj8EVNgk1Af07J?=
 =?us-ascii?Q?ggf24BoxYTqkpeydQ3q3jgLt4xVzJYfnsqoz60oAtD6eo2bDsnFZ6FS4ZsHh?=
 =?us-ascii?Q?WCepsOckse7eCXMP2FGsc1XM629cd2oWlT39aqGkH4YMRz4U+HkWZjkFJr5l?=
 =?us-ascii?Q?qiasLE5ax690SHypTnPNTk98vW6aIMYO74Xe4xIyfbqqv2/TF58XAv5cRGr2?=
 =?us-ascii?Q?K8CV5YlYYXFLW+IsyNlzRUYkdAFJ+32rauu8h5+rPCj6qOHuUrXN8RXDWHBr?=
 =?us-ascii?Q?R8+COI0LKbJAi3ON2+WNnxz++gNWfWgXcjDiALMg4vl1UV8Wc+sz5u8k7Uga?=
 =?us-ascii?Q?tSnAEH1TyA6opOcurDNyMAt/nbiFPEDUnhYSaeju1Wpst7GT8ZjeUCH0KmeA?=
 =?us-ascii?Q?N/nfvibBDvbSvAIztYZqMMTPt2ldNmu3jxPa7eqgB6QUuMN4wkwZVbv3d+fj?=
 =?us-ascii?Q?e+Ooz9D8/Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kgvIwDS4HGpZ/vMrnO7rMxb3hTzw9vdGLMtQnSqwJlhaG2y8e3oPz+lv+vSHqVme/2h/Z8+v2yXg/0QPHZl7TxnqHvu4HXzn6xKUqbb0LWuGA0LJmPVFtI7UqXZryZmd4ooK1ra6bEAquuC+GuYAgVQOXijdAua5i8UdWcJ+Cdr/LA6Wq33gE7CBbT5b1+EqaKjlOb8rYpxAYBVMvWBvC3xclLQpuFCnC4/JeWA5tw6iLLWMz4VOPTHyQ6pYuGRVM6gd9YPQpmTF2swKLs664zec1b2bQjsakxJ22pKTZemTxfprYVcWJhb8U53lnmwpioJEGH090MBPV0DmwFu5pA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 667d6831-f424-4acb-d195-08df3c8add2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2026 04:52:02.3869 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ++tl0b6VhDobHXQQA7EqCikS39aKyaS3/E3bfCUdfJezeoeLu3MdgrfgtAX7SmEO7IB4eFmC94x75rswit764fA+cWfuMMGAxN7LsL+sS9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9727
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
> Subject: [PATCH iwl-net 02/10] ice: fix IRQ freeing in ice_vsi_req_irq_ms=
ix() error path
>=20
> The vectors are requested with the q_vector as dev_id, but the error path=
 frees them with &vsi->q_vectors[vector], which is the address of the array=
 slot. devm_free_irq() finds no matching devres entry, warns and leaves the=
 IRQ requested. The unwind also tries to free vectors that the request loop=
 skipped because they have no rings.
>=20
> Forcing request_irq to fail on the fourth vector during ndo_open gives:
>=20
>   ice 0000:04:00.2 enp4s0f2np2: MSIX request_irq failed, error: -16
>   WARNING: kernel/irq/devres.c:191 at devm_free_irq+0x30/0x40
>   WARNING: kernel/irq/devres.c:191 at devm_free_irq+0x30/0x40
>   WARNING: kernel/irq/devres.c:191 at devm_free_irq+0x30/0x40
>=20
> and the three IRQs stay registered in /proc/interrupts while the interfac=
e is down.
>=20
> Pass the q_vector as dev_id and skip the vectors without rings, which the=
 request loop never requested.
>=20
> i40e fixed the same mistake in commit 915470e1b44e ("i40e: fix IRQ freein=
g in i40e_vsi_request_irq_msix error path").
>=20
> Fixes: cdedef59deb0 ("ice: Configure VSIs for Tx/Rx")
> Assisted-by: LLM
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
