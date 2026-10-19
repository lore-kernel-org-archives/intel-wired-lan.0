Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9206FCCF2D6
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Oct 2026 11:28:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 59F5340629;
	Mon, 19 Oct 2026 11:28:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HYRkBFmq4YzC; Mon, 19 Oct 2026 11:28:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A6F7E4068E
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792409315;
	b=dlwN/eURyTK+Mc0fq1ekA3ncjn0G/1sk7vWrg0eYmHIrZKQf1g7Gxy72zxwGr9CGV4TQ
	 x9mj7kIhtc4e1A8OhnwI3CNJATEjZCk550DWFak6g9bJ1Mfc0L4mLhxBWoSv7O+S/SUop
	 Oxqiozy5KTFxkk94qdwEMtDUwEQWGpbdpbPJiTbkzB7fFPARsAc/X5Q9EmGNL2DQChCRR
	 0SaMTFJqDJVu4PjyClfcmBjk22wKZc3+1640rTLBL/CMczcAst0nT3+BO71SWMRV46Q+L
	 Z3NCnHIKYYXnU8+E5d2734PSKoYyKNWhAOccXFagrJUVSN7V7sXqnglpih6vZsLo/ow==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792409315;
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
	bh=bGXJIyH0twufEnL9XrXpNqQOD8vU1QnqcS88Go/zvlQ=;
	b=K+8KLuNaxUyOZlCf8iNoJ+MH/oZQDnn9meLfX/Jedha7Q20GZJuUtjyVM1bJsTYr1eWp
	 n7qjlaSRDXnhS5zmjKMi/A6JAyKn1LloqQYYMFFg15KHCkVJXCwDLsSFVFDCvEi2w9qUC
	 JvXcZ8ZLMEYQ6+cGmk9wlPlm4qA2d/dvaRjqVz3vJEeU04nSQKp/XgO0CocZmKdK13oPV
	 dYbiCis6PcZtsEda3QeUyFKHQLhBDZvigO/yrIDIjXRpSQ5TIyICqeLnwLWY6/7CtF9+o
	 QXlx554NFCiqUsXEOC63tq8ULNy7YgRVNBF7gbZOnWYHBjZ1DU742snW93nXaB5sGnA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792409315;
	bh=bGXJIyH0twufEnL9XrXpNqQOD8vU1QnqcS88Go/zvlQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=7OGw83b29iAMH9H8RdZdybFnvbaxVTPcUfgm9P/U0CBngHvJnMPZLZixs9o9GvKrD
	 /zKXUW6wFee1GljoZWznJKbK0FobnACbQuC4L/L9OT7/m6EHAbtGYzDTiicoAe6raF
	 Y+g5MpQ46dOn9AuG/ChIi8SmwjcfmFRgCIJs1EVlvHcj3AATyQEu+1O7T43LnsXy95
	 kHnvcoPe58UcDycv4nBEcCx09JI53MpBBFg31oskjecit0W9isKlw4zrgWhZ4qd1UL
	 mSFI0PvTROrH87Fjl+q4EaaFP67rfLEO85QhXzQY8pbrZaW1pEtpH4JB7FaPYxiyjg
	 dj4Z4eV01aJiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A6F7E4068E;
	Mon, 19 Oct 2026 11:28:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A74A0769
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 11:28:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9945580F36
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 11:28:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JQclMm4erPxt for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Oct 2026 11:28:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D159380F28
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.16
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792409312;
 b=LC0k9sVp79VZWQ9e23H+nmmL0grnFuM6j0UAVlqRv75fZQ5TTk3KYoYfw0nkTobxAgC0
 2/uwKYX8Gvn0Fu9x4901a6jO62lM7fYY6Op2Hv9HjNOZSnxA6VzKnYMZuayxy4/d2ubU4
 wZlCGLREbZYN0vXXEM/Q1f0m8Eg6mpIPlEDkr7+UwYgAZTNTVHBMbzqsHKkwoTo9SQLFL
 tmGhS3tY1YlwV9DUeh1NWHDcko7VAy0g/e4wWXZctp0oagBLZ23/tp+GGiRm/49UMznxZ
 ojVzCnxPCBzyOEyUzf4PcaRlQJOwUJ0L7YfvBMTU8m/1fjkEd9/5byFkwimyNVDr+lw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792409312;
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
 bh=bGXJIyH0twufEnL9XrXpNqQOD8vU1QnqcS88Go/zvlQ=;
 b=YYpdNSJah+qKbI5yJ23sbpxzCRMiFEwOwaVNQAwHKNLc8b/fAkEmfjIjsziLuIyA4HvO
 P5oivoYQh3bZew9OQ83GUSY5RYaXVh4zbwCeaW3BILkw82BrvXS6zptUoN6+BTsCRBsKq
 Izlb3DbhlTOoxfVUpklhQDeXMcdo/lQgNOYUdu71x3AQYZgvYbwOntC1U2vdnWzyvu7gg
 rIprViBh1XDUPUUN9RcazeTnbdpWk/l4mAr89Jo/9Sr5jc61V91LaJZehG2hY7jrHjB9p
 4xn62PzzeNjHlPvjz+qzIJjKmX5MiLHZ7MXPrS0k8IWdcVMXGspd+jNXGe33IAyjV9A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=YM2XBX3X; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=YM2XBX3X
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D159380F28
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 11:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792409312; x=1823945312;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bGXJIyH0twufEnL9XrXpNqQOD8vU1QnqcS88Go/zvlQ=;
 b=YM2XBX3X94gSRebilFdJPFdfnCzAyiTkCxh3/aiRSJXFLrLlCG4aSOZ4
 mKdzyAVkoU1VXX6mkexgrzxUH8E4UDcBBICS/ZL90keVQnmkz8y7HngfS
 7LrO97CIs3mXsUjtJ/DjKu07GLqoW944wZD+SV61llLpPkOvC2Rw8Avbp
 SQSVBRJzAFxhhRYsg5og2Mq5opXu0Bglbolto03BK5O0BkTLUTzEILlox
 thHNSahy1gzRnCp96y5Mvu205gLyOD60c5B0EPxoc9ykKa2PDSiNlLtUH
 aAq+s9bvXsrlabT99Y78r42FODaSapj8l+RMR25YwcJbFUgbIkVSetFOp g==;
X-CSE-ConnectionGUID: MntlmZjOQomKO7Pi0Efkzg==
X-CSE-MsgGUID: rkS9WoiST4iB6PJqBlQmVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1082700"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1082700"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 04:28:32 -0700
X-CSE-ConnectionGUID: Ejvp90OjR6+gqNrb7gIjbA==
X-CSE-MsgGUID: 5zVr3QALS4CaTMEWznrYHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2489949"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 04:28:31 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 04:28:30 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 04:28:30 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.63) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 04:28:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRLrbI9QdRXjXVQPtZ0stVzlEY3WO5r++Dnovt57/f9J1IWaSztP8RfXBbx/iVmFJNNdyYDmB+23Agz0UuwaPzz1Y8DgIfZCX0jIze2Gi4cDF6ErmfISdyC+W8PdQbSiJlA8q29C4y/Wh04W/zjL8Bshc4agW5wTEi0SRoH2y0mS2g/B9hZFvZ+P1SKALPnlinQjZqz0mN5VRbRbG2vhzW5G+M4jTK5oNC5MjWJVnT3m4QK5wjZ/ndH0JavSBcuRg8wX55hrJEu/tuiJte773gVRXeoFy+T4IZvSQ5Nk2CHEo+iq2C2PQAcRMv4kxWqjuYS2g31V1DbCJshEsYbRGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGXJIyH0twufEnL9XrXpNqQOD8vU1QnqcS88Go/zvlQ=;
 b=Cp1YCOTkdW4P9RmtPJxWTopMUu+cYDteI9DcmodCOqqQHLVntc1a3Ap8x6oVkIHjS9a8uZXYrpKbomkTP7GMmkhrSZqh4Bp1sVCq6B8c863FJHR6y2vBhP8y1wJYn2jeMFurtjLskWUU4sWq7rzT4gVt3cJPem6nhR327QoB3+HI471mtHHslRuhglPzczkPbnBhApb0Ij2xMvIL1CZJkv/t634QcvEwUjnJsgpxHHM2HtwHNISQI0HfCQzZrNh806h5kENWHG1XiLHR/tQXNoY5hNG4cHxPBwVOfiLmG8OsevJRkj/uHF+fNrQniMGMPojxH5ZhHLVPk6tyBW3dRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB6864.namprd11.prod.outlook.com (2603:10b6:303:21b::16)
 by IA1PR11MB7295.namprd11.prod.outlook.com (2603:10b6:208:428::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 19 Oct
 2026 11:28:27 +0000
Received: from MW4PR11MB6864.namprd11.prod.outlook.com
 ([fe80::3cb9:afc2:1be5:5d7b]) by MW4PR11MB6864.namprd11.prod.outlook.com
 ([fe80::3cb9:afc2:1be5:5d7b%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 11:28:27 +0000
From: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>
To: Aaron Ma <aaron.ma@canonical.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, Richard Cochran
 <richardcochran@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
CC: Dan Nowlin <dan.nowlin@intel.com>, Brett Creeley
 <brett.creeley@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>
Subject: RE: [PATCH 1/5] ice: check the full PF reset polling limit
Thread-Topic: [PATCH 1/5] ice: check the full PF reset polling limit
Thread-Index: AQHdX7gIe+QzE7pjy02c7wi+M1jgD7cEujpg
Date: Mon, 19 Oct 2026 11:28:27 +0000
Message-ID: <MW4PR11MB6864B28EF48A22FC7256FBD380982@MW4PR11MB6864.namprd11.prod.outlook.com>
References: <20261019105155.3793063-1-aaron.ma@canonical.com>
 <20261019105155.3793063-2-aaron.ma@canonical.com>
In-Reply-To: <20261019105155.3793063-2-aaron.ma@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB6864:EE_|IA1PR11MB7295:EE_
x-ms-office365-filtering-correlation-id: 873c2bfb-56f4-438f-fc4a-08df2dd41866
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|23010399003|376014|366016|1800799024|10067099003|38070700021|11063799006|4143699003|921020|21046099003|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: 1b2nCB8k2GyOjtpDF5rEgXwqpZcyCwXhwswWZcBetwEDRqsMNHFOSScIpd93wt5duB3qfV6OAyRXJdSpTSpyhYwMqOJ6zncm3vf3cf6uelKj7x6NyPpKnR64+SqNjBrlU8wYBYK2cwa0Yi6pYRHkP8NRQ8Q+nNDQzPNAeb/bXIqpMIBx/wp+jVzKFc+YupXEa9rSemVsfej/kZzn9DqVo8D6KBTXbZq9BhE8sjYBoh/6U8ZEf8tdoZLhBXbzfdBkEfXu/QrJy4B+OKY+CQfY5bBqEsUL1VsKkyB+6d5LAHXYGEJpoO7VHLfiaBWmFEUtvFZ4HhPo6POmafizdzUEsa4lddZryAOafYD9YbYyf/brCEwWFzkZ6gAebnJTyXxBCutltH24dC7M9dtWa4y4f7jvKAr89H8WP0vj8hWLSyFpOvXFIkpzf4N5O+1E9gXd7V9OQJdi46uty1gQ7bAlYOgb44Yzj+YoCTnCFhCwlSW/Bs48Exc8Zl/QgIrHn8BrfECOXE4PF8AWrOmPAE/2yV/VeOgVQwBpR7VUO6zQ/VABhm5EoPzPKvz8fqa5GwQnQ+y0TLR/EO59o1cof8Z526+DTlQ35ZCja91Ho+8eC5gfv8m5na5aNF/q0a08WJzaBeAGUN3GwwCrYT0JzPq8j83N0H/9RUUYVIcxEpr8KPQFpQCgu2T4AMi+IudFJWZxPdYsz8Jr0yvBNGrlwLRfdNWQmjM2Xubrp1LQUU94QlXI6hkVXMbTLYR1fENbHCsU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB6864.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(10067099003)(38070700021)(11063799006)(4143699003)(921020)(21046099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mX39BRrCFeiCNwxQWPYy3711LWN6re2hCKNqrEBjIVx3gS6OpX77kGllXDlH?=
 =?us-ascii?Q?v8o2pc7S84D1raMIfmAJq0xlZUb+tnKnm8dOdPhiM9syj4jRUMygNFpmq4Zb?=
 =?us-ascii?Q?VsHt8dOXCGX3jrByz56xjjapeDVrP7g0FAmyP7iPUZCFuCNcc3ZzGrClEvKm?=
 =?us-ascii?Q?M1W6oXEF90OOt+bLo6bqpfRIipbDWpKcJNrosCF6o8fbQPFmwkAHsvg3Q7K/?=
 =?us-ascii?Q?NuxTIjMaUHxQyWU77J6elMYMeuFw0dj/PFZMSIPbGCcrj9cMXm4/UnZXsBP3?=
 =?us-ascii?Q?6XDq8VrQdr5ffzvK3VC/OyQjpmRsq9cgKdH/KhZu0dTWPNmZe4XA1aXUkFeL?=
 =?us-ascii?Q?TUmeBi8xQrVGlHBZvTUFrfzm8ceUKYeFc9brML4M3488aLWV2hsd4ThYLL6G?=
 =?us-ascii?Q?DK0wMqoX2cKBbah7HPdiG1Ju9U516Sw1jJPP6oKh3tfMEMo4sR7NAcjxEF0k?=
 =?us-ascii?Q?l96dvOEpaV7gzGcyCV/D6P6bTPNcTrW4ZRx5vcNGcOhGy/Q2+VEvWx4KCrdO?=
 =?us-ascii?Q?a91sUZBeOd7Y0dkOyupOM6n8g/OxP0uj5iDEcR6c6tLgk5u8s7rk8/wCNSZd?=
 =?us-ascii?Q?W2lDMQSE0xG5E0/c3yywoUxGkuQwJzAxPai+jQPGA0tuFjyn7ZXFcjEMMapG?=
 =?us-ascii?Q?vtAdaabzwumFgENS9cAieRxMASQa2pTSY2GVRf8cHzbDhxmzR4zlOBFUNtLR?=
 =?us-ascii?Q?acT3KMLIxOwcenc6lI5gh/EW3vn8VAAREmhsSLf0FjWHXTsqbrWsAhUhaS+W?=
 =?us-ascii?Q?eQCA/+VJNHnsFTQxpL/uXE+yZ5dssXjpw1bFtQ15x5+DBMsl+XZ64d1nuDFP?=
 =?us-ascii?Q?4TJvo6hvqxAoS4bokglVVwyATF+W+2MwZHGkI+Oi84A+TqIDTvP5Y5ixjefJ?=
 =?us-ascii?Q?Pjv4cDIRYaJHmdgKWWGDFM4k36LKU/pT6X8ngEoYPnrnDM58bIKmXv9E+er+?=
 =?us-ascii?Q?0doQtTPfiFEDW/181B4M61WsLuW0oraiey55aehesT5pC1xT0u5kaBd5vNz1?=
 =?us-ascii?Q?FbzU2maUr/MMfN7yAhi81Lj74T9FajMaI8cqHX+KjaJtw58Yiqaenrd9uY3M?=
 =?us-ascii?Q?4ppNaWKTxB+QTWCfI321vWRb8uwsU9evD6fiaK8KwPWtlK6QJE/3WiYjO1kg?=
 =?us-ascii?Q?yiyQh0Uuv+UEMCeOLQSp2FrvyoyDSnNxg6RYVtpWaJDKoh1EaugXk1rYBW7m?=
 =?us-ascii?Q?yoZ8x831YcNMghj5egA5mgArTxiIDBeNAqC3JZTAuE11u7U4+UHO/wHk9JaV?=
 =?us-ascii?Q?mLhnF3RxHQ1RZhHA+3ziBrYMhT7zbqLxJVXXjqf5gjQTJ7Ukx9+m5jigHIiQ?=
 =?us-ascii?Q?jXzNWrU5HTYWllvZELcTRxLw65KfGYNprhr/VMPNVE5s1c9PncYi7qOiOxMt?=
 =?us-ascii?Q?hsLoHTSGLRSLiFuVptQQNm0/kMh/U1QyiAbokaylEKa0H5Dty+JuY0vhO0M7?=
 =?us-ascii?Q?y3g6HQA/7zjDdg5apYa9e9rWh+bkn5/wexAaP/l8goE5JV+czhUcM/BRv6vl?=
 =?us-ascii?Q?VFzP/Q2oJStXFGVr1XdxtPYWok3LuOzyBwRxY4I1JZA1yIwirA1To0nW9qsB?=
 =?us-ascii?Q?phX7lCTXDeUTwXR6WFPjkuR91aooz0y8J/9ATSJPGfLiPKMHbqAT+XxgGwjW?=
 =?us-ascii?Q?sFOfeiWQCJkkmL7ZFKKXiDuGMfLYldeD6bO9ta/MWYhxZYF4pj/MTR6xPmCc?=
 =?us-ascii?Q?rufY4sTYKSUamr4QT3xj91z5FwTgmTPsDFj9/CVyXMiU8XuY6xlQc2bUfOaa?=
 =?us-ascii?Q?ibF+Gcl1KS8O3nR1p2xP0OX2Zfgjr6c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nok6gMn4FNnEjyYIGHJGYdAJIojblAcfylAk4Z5tc6F7TbA3IO8bkWIJfFZQufzEe3imaUIIA9f1Jh6XeNTXnT0u8byY5qSffHzYvuQGuEPyPHxaUyzD6qJsUuF0UpU5XB8imDaCmG1kshcVJruzYJe3Fe+VfqCNyzrW0GroK1B51Arcmz1Eq7TyBMT1TPNM3ApmpApNV7qVvhzWFtP1fZN66e8WDVlozTU3HNjQUwjCsls69dBVj6WKDJe6RDNeA6WjY1U2qy96v0pg5VtDLAjKJvw51uWD0VoDlPwvaYkAQpJSXy6qVMo3LBRd0tBU3bjSNXJbW8Ebw3cMX4Bdug==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6864.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 873c2bfb-56f4-438f-fc4a-08df2dd41866
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 11:28:27.5277 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0FyMIGe1hLsm/X6/6LckijKkj+se7DxE3dIIcj4g4Qgr8N/5RTNkQFBaapmNz9C/KJ9Sr+xZtRQV4zmKTx/LwL8aYJT9gQg8jXcV2SowSqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7295
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
> From: Aaron Ma <aaron.ma@canonical.com>
> Sent: Monday, October 19, 2026 12:52 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@kernel.org>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Lobakin, Aleksander <aleksander.lobakin@intel.com>;
> Richard Cochran <richardcochran@gmail.com>; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Cc: Dan Nowlin <dan.nowlin@intel.com>; Brett Creeley
> <brett.creeley@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;
> moderated list:INTEL ETHERNET DRIVERS <intel-wired-lan@lists.osuosl.org>
> Subject: [PATCH 1/5] ice: check the full PF reset polling limit
...

Reviewed-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
