Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF2FCA6016
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 21:26:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 124B2607B2;
	Thu,  8 Oct 2026 21:26:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y25ACBAVQGcT; Thu,  8 Oct 2026 21:26:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 571B66082C
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791494771;
	b=QoA0rH0Q/kObu+ZItisBoyhcSEAyi8RKUJqldDp4jQ6BCI+nTjU1vzFDpCPEkyXdZc9h
	 7Iep7dv+B2dAwmNgKYHnqcAKyKOub2EEnW2sot5MRfDo3o8Lp8GqvEqgzNVg8zHRnyTqZ
	 dLIfLS4MvEQ2yUhgWHZu2KwX7DdHx8EbtYtaD4pz4scddO3DEVJkk+Ysefa2LY2i7smfc
	 3ktaSf0TltcfWJTeeAhcdEVIZnJ7EPVCRBqDdWf/QyspdA5wW/wP44AHYZSSyJsiZmG7s
	 OJXsS5Bnf8xMjzdwY86kMNXcPHHihoc+cfRm/NRHMILR+PnrxrDq8togSqrb7i8sTvQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791494771;
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
	bh=YCF09l13bRn3MrVxMkNAbeX4dr5jjf0Qr+x0eFBtEqQ=;
	b=tJCtNZD0VjPdrhXqMWpVVzRTB7IC8WNr/qzfkr79wpE/xunnA7VJf5vAFKG9gy/5aoV+
	 ReuopYo/XSIhQ6/PNafoxjoM/uLBo8RKaSZROjbyI33ghB/MJTYUbFeKEw1LuK5Du/C3M
	 fN40QCCGYcb6rEQAlfViUhUxJyIH1fcUDxPOj7H4Xi9Y3wA7VJPr23EIOHS0fyKPT5/AO
	 /vGGkixBZCo/kDn5MDET4peR8d2VqRV06cs9sOkZ5BNc+DvQM36lxJ1VX+kOKqh250jqY
	 xP4O4lLcQRxRwlOwNIcVwMZi+kqw+i2b8IAn4ffmy1P7I4AxQNZ+9w2Z+vW2zBx94QQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=n9bq0vBv;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791494771;
	bh=YCF09l13bRn3MrVxMkNAbeX4dr5jjf0Qr+x0eFBtEqQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UgrWZx1Mb3e78DgYaE8r3QIEqVwi4yUjR96mQ76g+3MP5BCSkwPHbn1jNFhHVGfR9
	 70edpIWxy18oSIJWzo1HtTvuo9IXy92JKKMe2RbnSyEuNJ8Ramg07c3Bt6JccZefEZ
	 VSffrdsGPMvqNHgk+e6rHnXJqFy9GsNTbeaZQ4Rsfw7l7OoFf1cdrc/+kYj64hpjee
	 AvxLWOyKhrIVonau1G5bg5mpIx9o6Zw2QF/Mkf2ZA3poZcwl2PreprdKtFnhIdiW5R
	 ewNqOvsZ79o85xDkt6Z//m7jzqU425DuO0JB7zoeAP6h37DkQLlW+bS6EXFnW2xgMd
	 UcX2PdPt/PObw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 571B66082C;
	Thu,  8 Oct 2026 21:26:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 36CFC2B2
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:26:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1CC816082C
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:26:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qA3c0rI7P6_B for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 21:26:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 425EC607B2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791494768;
 b=tfHzJYxxZ8tUYkCrYunXhT45Nbj4mcbvxqpSDsw675xxyZRsCF9204jHFNrYmEaM/Ozq
 rGjI1sQf6eU9NIcUQExtSP4MRTnISwsLxtTW4ai1DcZLGwlPy0I/QraoAjeI31badjsii
 qvEgy+9bkcuFt6oDaWQw0tfKMwp9wlfbox8of7xbvbhnHRqF54x3iYMbnCfpMknZokFpb
 fSr6HiMpLx86JNRiOkrG35kCLe/s/fQ4bCTU6AcKSaeITwBcn2x1cCq8crTA2+UOW97QD
 79v0GU7s3QZKC8V7WXYqb3lNYCE69tLcJRagBnDkLZ+RQnSug3A7Hky/92/wRi14uNQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791494768;
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
 bh=YCF09l13bRn3MrVxMkNAbeX4dr5jjf0Qr+x0eFBtEqQ=;
 b=r3ZC5IZd8zECrT2XU3OL827UsuC41fAf00t4soJB5KjMBlTfPONzzPlT8yTmUno5SHFg
 HV9HxHPtfyC0d7Up2f98tQCjCNWkQCnh/DYp9dST7mwnCGYQEF2unn+JP8zClXitvDWrt
 V6GNBJ/o7yg4NAO2rF5hbFKcIjJI4syXYf9Nz9tJT1KaT3cWP08pgHK7P8ujLO6GyRYR+
 tonZgb63azxxt1bFdZd64u8+L18qIIH+qwU6Wsp0c/U+ywj48ZRl0IpU/8PhbAcmNqb/G
 H9F8XXstEex0bfscqjVMSuxlc5bWVU2vt4t2bsokH4hdEgVLFfqVlUJM/9R2kt0YZ3w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=n9bq0vBv; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=samuel.salin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=n9bq0vBv
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 425EC607B2
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791494769; x=1823030769;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YVJV84sH22+fMjn3nti2RxeMQtks6VAdxyeg0oJHGag=;
 b=n9bq0vBvE9lopLdLe2BlorufIWpRJr09M9GGOEERodEtjrcEUPmNrz05
 mGGvl8B5eZBsMaHJWqHq6S1nO6JZ0h0cT7z5cjafUO3DUnFlkZE3KsqqD
 xOfNrnsLWxcSdlhmBCLurGw495Ws9Fen+MqFQbw+Y0JT/GaMceGG/s+yh
 Ko8Ns8BNBVuV5KRCPIMBXMAoMYeANNL6Ir6Uua0MUf7GCb2iGzSjkkLVQ
 ZPJGbn3piHku2+rcawWD5zfVolcBD9h29ImTskjXlof3MMwbT17+gIwci
 pBegWRMVqrKtKiid27T4Dcrtfv2JwlJC0GGFFNkuXfbd4BROdtE78HfD/ w==;
X-CSE-ConnectionGUID: WuvZeh+1TSS1RyBgCwaBJw==
X-CSE-MsgGUID: KV3xfXc/TaKVsEOBzLqH+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="316598"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="316598"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 14:26:08 -0700
X-CSE-ConnectionGUID: NuIDB/+CS56paHthjVpbQA==
X-CSE-MsgGUID: M08TTxDQTe6f8hbHmNgfDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="597809"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 14:26:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 14:26:06 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 14:26:06 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.45) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 14:26:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5PPQEj6t27uHMahEXnNwQA7JfiIp0Mn/bMZ7KPPl1gkO93XWwZIBjPDtla4uX8x1zrWsf3G6LK4wNvjf8nrbOdEGruid28RKNGkJkENnoLtCdDQWI102oXr22N/7MjZi5MGNVpb5jOIoViLgVPJRwa3VPdoGSC3gOs7KYGBemokp94500yuBUjbjV85SydYt1W7IhgrP3GUiHkOI6newiYT++l207aYiU+qxR86IbLXcl6e+g6Z5Z3Bp0Ou9sYU/1uKirJWrcB7B/FucNXR1e8whw9t1iWABanX5sJ/ZAl5e1LErGyp7+2Dh4EXNDcVGgYX8JIZy8/7uOwrdIw1uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCF09l13bRn3MrVxMkNAbeX4dr5jjf0Qr+x0eFBtEqQ=;
 b=KBDbwafpXkH+M67iOJN+3iK3BWkBlvXswWbvtXBjclRxpBxFCUIXlqF0Uxv/n46obT+D4tT/zWbEVfuumsfAbstWV6LT79R6ZbczfsuEoQwSENJhhee06woZ6caFDOampvAborpZOx7EtgszLjKZLYUln3hbQFO+hKcVU7M9V9J1d6E8SCwz1vykDVtYD5QI4aO/lQ7gl+oPTrB4o9Cd2c9VAOXZPlTJULYZ+N30B8yTn5E1OZEMBb+TZ/0BpJIMNzV9L+PFz2gteXceH16KYhRru59g0jc8xhlqf60Xi8pbx9RfT6DlHEy23FGJ46pMo0HIP7yTpVlw+pdoCnQt2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6422.namprd11.prod.outlook.com (2603:10b6:8:c6::21) by
 DS4PPF8ECAFAD61.namprd11.prod.outlook.com (2603:10b6:f:fc02::3a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 21:26:03 +0000
Received: from DS0PR11MB6422.namprd11.prod.outlook.com
 ([fe80::d257:46d9:13f4:adb7]) by DS0PR11MB6422.namprd11.prod.outlook.com
 ([fe80::d257:46d9:13f4:adb7%4]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 21:26:03 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>, "Zaremba,
 Larysa" <larysa.zaremba@intel.com>
Subject: RE: [PATCH iwl-next v2 05/10] libie, idpf: move irq code to libie
Thread-Topic: [PATCH iwl-next v2 05/10] libie, idpf: move irq code to libie
Thread-Index: AQHdQfHXs9lVB4uQJUueQqh8dshM4Lb0U0Hw
Date: Thu, 8 Oct 2026 21:26:03 +0000
Message-ID: <DS0PR11MB64224C37B7A7E8BE36CA3AC39B932@DS0PR11MB6422.namprd11.prod.outlook.com>
References: <20260911124921.2881348-1-michal.swiatkowski@linux.intel.com>
 <20260911124921.2881348-6-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20260911124921.2881348-6-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6422:EE_|DS4PPF8ECAFAD61:EE_
x-ms-office365-filtering-correlation-id: 88ab7c20-d30c-4554-06f2-08df2582c17c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|10067099003|38070700021|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: sicTqiBCQxgtu1/wJXz8OkqgqkMUma57m1wY6M/9NpcoSqAbW+JNSG1u+PTFZGf3yk4meabFxsoLjfEtHLm0viILO8IKwOqiQeAvY9qV9krnBop34OdwqUG6b7gbCoR5ph7ptEGKvgaah9fXK0kxSn8nM5flmMR3McUp/LfomoUisbU06kBTP8GK/0jxxV2nk486MXf+xlllLB/QcLNC6Yaz1jYPJFqundDkV2j5WtbqLW5wPYN/YGC7pqqJ4C8sdO1VhDhjBQXbcG+XJkOCC3k+1H3l6z0ynVmJ9Q1VNxkN+Al5xeUdTXfzRkYmoJY68rAOjbA6T5x+LfyDmONdqfy2+UUh/EegnYr2NZPaHI+mzuF35+/BPVAbXrD9qOtjAvF9JDaZyZ4L8gd9w2d/QOrndO7wN3cKg1dNDaCC/8aCQomWT0wr0t0rsxRYG7e6rsP2YbsWC62MkhmqSNFFM9ZzIURL37cheP+hZwaWmqKaZH7z6RLVSQ3GWaWqF6Hx+4aUtxiESatFGjuVCxgt0vMsl5c3epOImOeN1ZYvxsZCqIW7gBypUOUsg19jEuH8Lfgu1uiwXCWJO80Nwt5cDRsp5hdr66hyKWZAmXIFko0jHm1iScw9yC1YBvKgxVLYb08KzabrKnqXnnu/rGYaAC/vKjRTMZESf4sMCvIkVhq1NYi6ekDg7zGWOZ5j3K3KlgUpFOUabV42qZN/HWLQGw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6422.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(10067099003)(38070700021)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?13C0M3dnK3uWe/mt8IvH5aOjRYBZrBfZS2HfB299Y97mY/r5CdxnnNnzxxFm?=
 =?us-ascii?Q?FJRkSTCI0LhBIAIV1KUPgJQ3RoYtG0vj4vD5c7HtVs3VVWDEmDnGfZt41fb3?=
 =?us-ascii?Q?vgRVgT5RJHFRI2emOq1kCJWezgFogDJMT0JNl7FtoE90ucBggMrNuqdn/zpR?=
 =?us-ascii?Q?aSSc0Z5dQMw+TOLAq/MCFt7DO0LBZD7eiowp0aZ9boOCmU1GsTZNEuVh24J6?=
 =?us-ascii?Q?nkJWpV2NSRXrVxem9u+Iuecko21bOEnO0pOa3J4wSU1UUTBHrsDm6AG/bj5S?=
 =?us-ascii?Q?N5dbveqLCAyK9xOKpQsK+v85Cpe3q+Hjs4UNN6tkraCXhdJNXJcksD50hs1n?=
 =?us-ascii?Q?lt5pAcRC6s542j9TehCHoMUoWwa1diG1P66hfijedakT3y5uCq5pucR3R/+E?=
 =?us-ascii?Q?kUWWZsyQQBQImKHxhauKkPCmJazbs2XGy0HUPwnH5jOUpczdxPRBwhUS9oUR?=
 =?us-ascii?Q?N0bIpX+MQDDlyphuCXuf/a51msXSa9vWGU3MVYSK/jnkYzCTKHQdTQi/GdAn?=
 =?us-ascii?Q?7SwSkzzif3vrvxSa7eUiG/jGQTtLCILJ+Z5PIEfRqRwu6/Fcitmf2xAkUrNy?=
 =?us-ascii?Q?/yuIqlN+mXBHMK2lVEx1zFNHUglKGwFPphYFa0Tlcl+caCc7X0MMf1TbzOZ/?=
 =?us-ascii?Q?Cdm5UKnzQn5b/ZnOUlPQs1G7w+CwZbvHEXIk1f2HkpRidBJUV3GAfnBjtISo?=
 =?us-ascii?Q?3jB6PkLXLcsJn3Hu4rCRhv8ARR9qWewmO3VxRIue/NApx/P8ZHYmwTUMWopw?=
 =?us-ascii?Q?Dw12F7tCx1Lwl72AnFzWdEhPZOh7N9yEHlQl5VsAMKcRT2rjSPpWTxzyPABs?=
 =?us-ascii?Q?tN9wZzCC/ivhUUZDLopwn2Nm+e70k79KoDWRMN0WEN1H+X3DzurTk11a7SgV?=
 =?us-ascii?Q?pDGX9wWrVwAgab/x4bLKpX5fguYL67VNhgw/ST3UUhBw5Ehlbvudxjmnb0aU?=
 =?us-ascii?Q?HdlpMkxhbKgvsVeZP3DU16c8Tc12r0PXzypiLxIV6hFpVlSBuZDUM0jt3a5E?=
 =?us-ascii?Q?iSX2s2i24GAPcesXa+Wc2m60eFsIsoYmL9EHcgl/pFa3IiFD3brjZ39iw/mI?=
 =?us-ascii?Q?ZqtOhuepRoqrB3j4BIEps3C0H7PTjCtT0IKDSewvtzjLyyOwhPHQMJ/1rT/9?=
 =?us-ascii?Q?tQPpUs2ukrndt7qixJaxMb5LHL/s9ol+Bh/HDyNbvuhOSJOHj3b5gzTAl3JG?=
 =?us-ascii?Q?GpLe3Rox8NiGd093PI/7ybgYkTQYrdxqTjuasGTOMlUTbL0XVFybEdHeTEjQ?=
 =?us-ascii?Q?pVoJ1RfkOsEnEggof99U5s1hPbd6vgo+XTq2MGxWhD+aWNsZ7iphX8NbmGk4?=
 =?us-ascii?Q?aG7FE6PTM+GDSbeQwZSCz+tnHx36REwuSocBTk9+K04v9kPwTeJvGr3Cwrqi?=
 =?us-ascii?Q?5jLNGitmh2eTnZAr7h1ykl/3JIyqCQT8KYZ5afUnWUTOdH6lLIRDYS8l29Zc?=
 =?us-ascii?Q?q6rm99fAFynNh6B0yWwTIuTrfkWxm+z/IbTaeyWu2NUKmqqIGc5eVvDZpotg?=
 =?us-ascii?Q?VJxoz57azuF+LIqEGV2uzx4WeZp59ruHP6pLxwH2vYAFT+lTl++O16BLTV2W?=
 =?us-ascii?Q?lP4JhtaPVejMtfBuJjO/UWY9TaHig4GfTJ1PIGpnRb3d4KxL/a1iakRxJ2Vr?=
 =?us-ascii?Q?WYto8vfTAGcMMFu0IFhghN2Nioy0Xdl5yXEN7aNVhm99/fpwkVC6mYHlxeNk?=
 =?us-ascii?Q?BS6f4PNM9A/ny2IUKBc2pJUsOouX2Zc/uYP7DbaaixqgbkF1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RwSZ7cbcaQlxIPat33W551+aMQpcn9HxTSRTzwtjkYiTOAVaCM6JtGqb0VTDMfALQlapiqaUAi/UXScacAcL7sOqUTO3CEHa34bkhcVRv1ZnQZ78vECnXfm4RDMsLkB/2xwDEpRioGKi2ppGBHBGjQmuFgxKapoBRjw/1ibALPA2QyV5ksl8Y7sp4fuV23QEqz1eMLKnRqi+O+65D9VPWPjt4OJNjmXeViuruf/UjVC7bMOQMcmDa67qruSySPMzEKcb65xgkhsT3H/2ygPo0+Ro9sQRek6LN8JAQoPbNjU0Ynps1pZrscmV3CukbCrBSqEf3XGn7/Gtq44r+f/CGQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6422.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ab7c20-d30c-4554-06f2-08df2582c17c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 21:26:03.1973 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OAVR1A9cZj15z16BlArwHEzDslVYgn+YieEo5SO2WcWr8LyS7ydq2v/IqqyN2mvE0mOtpmT2pKqQn5NPxRUaQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF8ECAFAD61
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
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Sent: Friday, September 11, 2026 5:49 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>
> Subject: [PATCH iwl-next v2 05/10] libie, idpf: move irq code to libie
>=20
> Management of irqs is the same in idpf and ixd driver. Move the common
> code to separate lib to reuse it in ixd.
>=20
> libie_irq keeps the allocated interrupts in an xarray split into two
> index ranges: LIBIE_IRQ_STATIC for the vectors that must exist for the
> device to be functional at all (mailbox, the minimum per default vport,
> RDMA), and LIBIE_IRQ_DYNAMIC for the rest.
>=20
> libie_irq_init() allocates the static range with pci_alloc_irq_vectors()
> at probe.  When the platform supports post-enable MSI-X allocation,
> libie_irq_alloc() backs the dynamic range with pci_msix_alloc_irq_at()
> on demand, so vectors are only claimed once a vport actually needs them;
> when it does not, the whole range is allocated up front and
> LIBIE_IRQ_DYNAMIC is transparently served from the static pool.
>=20
> libie_irq_reserve() hands out an index without an MSI-X vector behind it,
> for queues that are mapped to a vector but never raise an interrupt
> (the idpf NOIRQ vector used by XDP send queues).
>=20
> Move getting irq slot before allocating q_vectors array. Alloc only
> q_vectors for which there is an available interrupt.
>=20
> Allocating more lead to the situation where there are unused q_vector
> which can be confused.
>=20
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
Tested-by: Samuel Salin <Samuel.salin@intel.com>
