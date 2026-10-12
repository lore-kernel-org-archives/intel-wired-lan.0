Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DB2CA9ED1
	for <intel-wired-lan@archiver.kernel.org>; Mon, 12 Oct 2026 09:06:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C97560619;
	Mon, 12 Oct 2026 09:06:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w6mqT9yWSVi7; Mon, 12 Oct 2026 09:06:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 17C72605F4
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791795968;
	b=o26MO/6/seJyPagK8efiqm60JJU/2Mpl+UMLjQYVLUmCkgX4hV7+Ze+5b9ORuYK9MaUM
	 vk78oB5wPvN3OhY3kayxme3hL0LKax3zFzNpRz8dY4vbH3j1xbljh3vugHQzx+wBGm82N
	 kgI3SsPwZ8+8SnH7YtsTBoFuIpch7YGNzCin/nMPHeECOWwMVdJf5QeJG16pR3MzUQLC/
	 XKFj0gRuMgv6wNEHFTkdYRIccDFrUVdSZ4ws6aZihZUmYoGzBZ6bproOC51l2cR0lGgEi
	 KOZEoaSkBBO9c1IROsZQk52kbi3ufT2tqfwGiNcS/H3VQXs7tr/YqinF27t+V/jpaWg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791795968;
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
	bh=j1bZJVubm7x/q4k/nf5fc0nduzPU4MQYtznCbRdqBOo=;
	b=rPlSs+7mnvpsq8nQyOkIW+WLjJIHhrcD9hbuuewKKLbJB9g4Lpf0iXrpVrWWb9kqHP70
	 Z6l7ggjBE/7Blen7vn63T7MrBkwEMxfLaIUES0DkCOBNhoBlDz4kozVHAJYuasUYFIgHF
	 5lpMjxfyB5XQ9jV346n9KfrekMtht1+fFtxQxQojAQjptvpgnsIn/c8RBZQcIGWomQSSY
	 WIfzaTzMvNdh33icJhOtX/3sleTHgsQYk1gAg0v/iFMetqi5yLdczcxWaCYL9EtB6H4X7
	 0HXBdxnbeAhRpcVmHA5od27gpRnj5QG35xWAHWtkq7BUJ+kEOuYYovDNMuplq+EP4Bg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791795968;
	bh=j1bZJVubm7x/q4k/nf5fc0nduzPU4MQYtznCbRdqBOo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ulEGwRmRGPbXFV674FJflnJcQL8RrfW4xnYwXbRCpfqxcga2+J/maZnuKrp9sCNR8
	 t7ZckGrCuGvF4ORF00lj08uBaQBJEfqHIoypQ93XUlJ9SQ8EiWImsCaOw/1zAvbTDc
	 YIb930GcTPUeYSH8vDgRXqB8XiGcsohId+ql52Mfmo6zqYx3LkpBIr0jpU6zPrf3/p
	 zJbnPmwZXnq6z2TxFV2sTGQTFM4v7d1bvyBCm5yuts9Bga3ze5AZ6HGjVjSzrzOD+a
	 rZjNM5lQSNcWS04hFaEjiJlK+8UZ+bmNXOhbknbqreyOodYWM+lSIZfYZe0k+JHGVd
	 66UzVOkRmUCvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 17C72605F4;
	Mon, 12 Oct 2026 09:06:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 53740105
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 09:06:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 44DB140606
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 09:06:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aipWfJV7CDqb for <intel-wired-lan@lists.osuosl.org>;
 Mon, 12 Oct 2026 09:06:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7F185405F0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.17
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791795963;
 b=J76/QdWsD64wKSJNJUEooeNXYf3uDW8bnDdWgIB59YuIdDD81lBvwRvJZVo5hKrk/QAj
 mzmvULQlYB1267B3sqK5wT8PpzQ7zGWMl4dtzf9a7QqQxRZ5lLP/s8IjpgZ5W9PiIF7x4
 XTydj1cYXYO7QA3kkqyhWBWhWN5ZVtp5zekXloFpfxw3z2uGxbEJwuCHnnhl4u+EEdqTL
 ahtGaeQ4RugvENMgYXs2yNi6S4SEZQQusz0TtmipGblAV95uzQXVXiPNpOtm+eHu+NlwD
 AoqHlVUB//HL4Br8WDkUI5O7Jo5YB2ehT4CPf4cdd/xpD+DPTd1pQN3FVSfB+YVlbFA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791795963;
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
 bh=j1bZJVubm7x/q4k/nf5fc0nduzPU4MQYtznCbRdqBOo=;
 b=JsOVeiB1CGO6/9cGPig5eJfdmb3qsIy/gAt4sHtOuJg2ip4H5ZGkNxEhB1IjNnCwqtOB
 SlziOVm0vrczBA7zB7o+ApsHhK/+KZIDIihcWFWEDYGS/oKJ4GWjgfsrHQTU6j5A/ctWH
 RnRyJhsMA4T6HXHdG1ezTfHWmEb2uzATJTclJuM62M1+13ZDOwDCcMdPWTEMScIXEONZn
 s+Pfa6lxkRa9QUsP2/UNwOV1ymKWMFAQr+ZE1uj7Rw/S6hNw7qw9GahQ6mepUVUgkaZt+
 8HUgvw6bmjWcqIPYTzueBRpmdGXBavu4qHPS1n96ZEJXQ4apBCQvNT8cJJ1riJDhvKw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KrL94yJY; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=KrL94yJY
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7F185405F0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 09:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791795964; x=1823331964;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vCWkgYJ9cwmwk5l2/J05ZVTwAsG+6rS78M63KL1vl1c=;
 b=KrL94yJYXQNPKgMtLXYEZhPiiz8QnTHCvSetocqaJX8b723bHSjpHnz9
 b+6jT0EKndJPj6X7pK9Z28m+c1joayS6sMhbA51t1WnRUj3vOSWb28Btk
 H3Q5m7QG/BoLXcp7UQp8mK6BT0kbPPQ13Ou5LMKIkWW2DYPhccRTjyQXw
 5Kbkq+VQdw9L9vwKaSHJiZDLaUtnKbJ84QQ5nOvzu17weMYAEhzZ1N1IU
 KYShMb0Dmdhu8zueuUNdlaQskQ3DTLrzpeTyLhuJoo+WmqPdRABvX55n5
 9FQN81ALMAQS62OVLnAdKb8utqeBonJdGyEY/cEux4eRSNDXsXbBPcKfm g==;
X-CSE-ConnectionGUID: V0chZLu8T6+DLGwErFfLgA==
X-CSE-MsgGUID: SnYZbqvjTHKotBw4wujdzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="506593"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="506593"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 02:06:01 -0700
X-CSE-ConnectionGUID: /kXXvQc2T02F56TN+B3i+Q==
X-CSE-MsgGUID: q7skKzw5RK2BDNkaIfONpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="770128"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 02:05:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 02:05:01 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 02:05:01 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.20) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 02:05:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUlBnEhKzEGP79O3UCOODykhrsEqPCsgwFmIJ+4/Yh40lGeK01VYDVdFRXHRBRucoS4b4gvrZlKvljznyr3zPsOEKcbfO9f3V6oAjfhd0+Xo3NGi90F8GNAcv5LGqbX+hgZX0W5uDd+eu9AjhC/eIx0ZqJvDcIU/EkUuUEAccAHFaoR9HIY0ZZtJY+YATDfcGLV0Edu/uI7A/byccqVv3CjrFR75wr7oiE4O/nLbNxEjjygxOKDjlq2QOEqL5Ymp5Ze1HOI6ZcJMkM944n3hYFiZAVV3eTFQqsEKN9/aR9aWm9BODE25WqDxvpPJRwc4mVDMWJU9RvQq5jtfToZXEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1bZJVubm7x/q4k/nf5fc0nduzPU4MQYtznCbRdqBOo=;
 b=rgTmtrs/1NN9Pmx07pFXSLhuTYtMbtzQRAJ60z/uJso4CqJoS+luLI9rRQdpTczvCURKfEgC7wnC6tromd5KS/87FcKWXEJWmmwGaf/GuD7ujwHaN9/viY88GA2l4RWsVCwvFEHgpsph3ENajvrsnrPq4ZOljLatnoH51I2YVEgZHfV25aaLWmLH0208+4hx9ogKP6xs0xRHpZ5DRwObg1iYm4rkSM46v91trOgiLX3mxTws1S7dlNLyiiG8pf/fb/0KCChxo8/5R14siBUowrcNdFkSB134rdhv+I+KCFGgskN0xgny3L/D8UD8XV4GaYmzG9dQZrzd3omrE8XsAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH8PR11MB6802.namprd11.prod.outlook.com (2603:10b6:510:1ca::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 09:04:58 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 09:04:58 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "alok.a.tiwarilinux@gmail.com" <alok.a.tiwarilinux@gmail.com>
Subject: RE: [PATCH net-next] ice: correct PTP register access debug messages
Thread-Topic: [PATCH net-next] ice: correct PTP register access debug messages
Thread-Index: AQHdWXTtaWXphcGc/0O7j49H/qMiqLb5no4g
Date: Mon, 12 Oct 2026 09:04:58 +0000
Message-ID: <IA3PR11MB8986155B5F35281999A764C7E59F2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20261011113545.16718-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20261011113545.16718-1-alok.a.tiwari@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH8PR11MB6802:EE_
x-ms-office365-filtering-correlation-id: 68925f06-0b81-4056-e375-08df283fe3f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|38070700021|921020|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 1DayFSrasxnd/OzNefuPpR6RflqgMfnrnJmJLe/43Mu6+yMxy1vsVdx/MW6J6HRVacyyjifU6DFjCosPYjnmSti4PXVnm2c7VHJ+4PyFK0CsJNbMiNldm1lPfX7zCXfx0ZDz2qclZrsdOQqDUu79xtLUMhUG1ediw+XtdOwykVjoLQE1UtprAHauu1NpolAvjXg8KWnnBU9gtjBj0bxAh07B3ihFN58xYWsc7G/QeYSOSmskG9G44B2uGzF1xohurnF4C8Bvr0yPGUu0uYjKOYRDtkyWHuukN9UN+5JaIOrqLO61sLRLYweDbtQynCDbs2PJlj+dVFJURTJqyh03we5ss5Yk3ukLt5zkXN9+G0aTi2+DzPGf33gWk0t6Hq58NurlG9eC3LUqZHMPCqTYb1kDhFvzX+tNe87Ts8kGZK3k9RyT+8qNVRyZi99ZGiijoKkRV6yXQJeQlE+FkJNT3cRi8piM2iGMgxB/Pnk45r1QZO5YPaxNRbvP8l0uG7XrtmfOz9zbX1gCTuEDs48qW644Yc+/5dfMC2GsJ5JoKbCte9gYd7csqdt5/zQ5qA+bnD+ATGEhIEsZ8ct9bx/BLpz5j3BIAop4nc8uDMjeBpQmAQLembshJJ65rNcmPwBiQYsXuqrJspM5IZNLO4yGKuKHpexOGBjdhgORpxfMQuMBTyGHs2TgFs/SgpXJUpWin5j67g/kIHTCWBeECKhH2Rk4HxJ6k66cnwOU5SUNQX3sKIlEmCWWyrYgA97TIiSk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(38070700021)(921020)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9gTuFnSLfORkEMU5lr50SdUA8D/Sz82q+5g1sKXX47BhqzR3Cdb/josWnYre?=
 =?us-ascii?Q?cHnjQes9d5cvxAMQIWUdy7VUvdnKMVtpv46C062hS+kHAyi1Eg9OiQP1LdJr?=
 =?us-ascii?Q?LJQBR/JYEJh9pHu+fPpZqjsHKli9Iles/+SN/I4qh6hNBy0nho7jL92HCm4B?=
 =?us-ascii?Q?fG/CxVkuv3y6aNWd8JSW3MAnBM9ebnrQKpVt63P1gd7VevoiCbCHPovOT2ud?=
 =?us-ascii?Q?baVrD+knx9NXUvDkfhwrYkO9LLGjSekgYogWHm4btMFj8Dc6ey0lRt3UgUhF?=
 =?us-ascii?Q?MbelX/mPDUPEBrfh4Jn6P12ORLIYJfH+EEcyGUIia0IfLFnQm3DZj+4mdyw2?=
 =?us-ascii?Q?F1DKl8PROZtpIdH+fPACCGV9NlzyUOnhGzTXUmM/npYjpM9QiGjxa7H6e2qw?=
 =?us-ascii?Q?8i6toRPNUBltQuktoQQ6fFqEYv6PNW80D16wzAIj1DtLI8IUdlmNFEIZflhe?=
 =?us-ascii?Q?hKGspcPJNd6Ui77IopM6WdHGHzpVI713sR4PXxiuwy6nYSA/QxvZ0c18Nt1r?=
 =?us-ascii?Q?bGpEyxgXn5kmVKxSarI4jKkc8V44XPvPoGoZPzLOboUqWBINUoHwSfO3liET?=
 =?us-ascii?Q?HUaHXAyiD8SaVXFABuh2c9rOFbKwITAlxt0jBFIvkWPXRvQTTMzND8B/qedy?=
 =?us-ascii?Q?xMl5ycBJj2XYbZvqdNYRnErJLGboRxpCjjBI2ShKsPt16UvXZzzEBXO6jBel?=
 =?us-ascii?Q?L53fLrZuS2FixzgQo2Uz7fD85D20Ife+pNjCi57Dzyt3gQMyq693neVtMqJD?=
 =?us-ascii?Q?2tXzjhzyTjeJFKg7d44ntZ+qkq4G4BiOQEvbscbbu1qmqO2ZRQsSUa4WLzox?=
 =?us-ascii?Q?q10a+Gq+oC1aZ7IUlCzW/nP7WCY0MaJoYZG5L9glcFBIUWk/uCb+rQvQXB73?=
 =?us-ascii?Q?kOdmkay1T+Y4kSA0IwBwu1X/SCXfsOJm37IzSngW/uwyfXPI007862y8/5eW?=
 =?us-ascii?Q?3DdGFDhRJnsm53mDVAF6Nau1igXDPwExeX5HQ6uDWlfHUNrbCaW/y4SzeoJD?=
 =?us-ascii?Q?MtiPuvz0eZJJB80bwTtFs07jFEJX3GmkJsppNOSBlAE0ZHGOU3874OAtNvQH?=
 =?us-ascii?Q?/RLf9zjGuVOyqCZfzRoRckZCzWcoVNyniod5Tut0jyNMoET7KszGgBxmvBlL?=
 =?us-ascii?Q?/oxXRo7BRWXEDqJUDalkfE6O5DFcYfD6ug0hnD50r+BLEqUin3TuuzLUwn2l?=
 =?us-ascii?Q?WKfH5F697pvMdyXFQUE+pPZBye1sUCvxY1GGdLLN7KbaCWuN7R1d/tTzl0/i?=
 =?us-ascii?Q?OcyXuxsjOeOi/CehohR5bTDIUINWf1yHUBrkq7RMnPccgIni/FDDzJEQ0JI1?=
 =?us-ascii?Q?UNwXL5bGDyX/VhjkLPdlv9Z4ZFgCLnpm2aP+88phdZ/flGjwiW6gRb7LCArb?=
 =?us-ascii?Q?MO4RUSanlej9FXdrqE81ZjTFm6WlHIl1lLD9Z9GoikvdDQYXN1puhXD7Heq1?=
 =?us-ascii?Q?18MX5EwBjzxrfKrtkz2d6tMeazQyXViMlSm5dq5w+Uf4/y61TV2/m0Vm/kXw?=
 =?us-ascii?Q?RTFZJuDbi13grZH31Gv/dU7BiBUhtP/AMMW31M+jHqZNtKHAAKnJyWLO7MTI?=
 =?us-ascii?Q?t2jQypHdDif5xUuwosHIGkXzKAmGyjUFfeUL8tbs6NxPgk31O0FuglrUs4/M?=
 =?us-ascii?Q?Ji2XvN1pPXNqoZRChMKHbi+Srj3MmZHrqwQA7EgPX3o2cqCHyg2VzKODpNhH?=
 =?us-ascii?Q?nRXTWevNefFvr0Z/GkzVYXQxyjBTpw5RSSLPy3z3bYmbQaJcWndMZDjNVEfg?=
 =?us-ascii?Q?bVkVO5SZe/PaVJlAIaV06vO0DxpAVc8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: k9ixpiiejRT7x5GtHeMW73Vg2W8Wg/Wxc03JEOl68Kl3u8TL0gPFQPAVHRRGlOKFduQgALmOKyL+FKxcbpukfw5BvOIgyKe+BEJH3A1HDo3ayeCTZ/nUL3RWc2xd3HCrMt6F3Hi50GaV4MhJUpGlg+iMlgKlR0QxCbHH0Ff7ZrAfkRIEMYqNcZJSFdRsMmCYUrgAiiDCBmJh29vxRMT+GIko9/H25pg7d68aDSMDN++8ueKlRgRoP88ahtjjspTHDQVXdNe2+/Ke5FsWdxSztNlgjy56IGt2pK3r0LODU/uTwt2l7nbjOR/raGoxW//YK96dRMrXXBFx0OJ7TG6VJw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68925f06-0b81-4056-e375-08df283fe3f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 09:04:58.2358 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iBZQoshj2TsUrqy04Ey2lLmJvvMQyXj6C7C8HwNiqUvewW9KVNmtIF5dawdEGzdji3WylyCvDzu+cLFFZUz0twHykRb86Ts1wr924sYpcbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6802
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
> From: Alok Tiwari <alok.a.tiwari@oracle.com>
> Sent: Sunday, October 11, 2026 1:36 PM
> To: richardcochran@gmail.com; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; netdev@vger.kernel.org; intel-wired-
> lan@lists.osuosl.org
> Cc: alok.a.tiwarilinux@gmail.com; alok.a.tiwari@oracle.com
> Subject: [PATCH net-next] ice: correct PTP register access debug
> messages
>=20
> Report a write failure rather than a read failure when updating
> PHY_VENDOR_TXLANE_THRESH.
>=20
> Fix newline placement in PHY register read and threshold write failure
> messages. No functional changes.
>=20
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index 3a41c711e751..289e0b3ef6ae 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -1529,7 +1529,7 @@ static int ice_phy_cfg_parpcs_eth56g(struct ice_hw
> *hw, u8 port)
>  	err =3D ice_write_xpcs_reg_eth56g(hw, port,
> PHY_VENDOR_TXLANE_THRESH,
>  					ICE_ETH56G_NOMINAL_THRESH4);
>  	if (err) {
> -		ice_debug(hw, ICE_DBG_PTP, "Failed to read
> VENDOR_TXLANE_THRESH, status: %d",
> +		ice_debug(hw, ICE_DBG_PTP, "Failed to write
> VENDOR_TXLANE_THRESH, status: %d",
>  			  err);
>  		return err;
>  	}
> @@ -2589,14 +2589,14 @@ ice_read_64b_phy_reg_e82x(struct ice_hw *hw, u8
> port, u16 low_addr, u64 *val)
>=20
>  	err =3D ice_read_phy_reg_e82x(hw, port, low_addr, &low);
>  	if (err) {
> -		ice_debug(hw, ICE_DBG_PTP, "Failed to read from low
> register 0x%08x\n, err %d",
> +		ice_debug(hw, ICE_DBG_PTP, "Failed to read from low
> register 0x%08x, err %d\n",
>  			  low_addr, err);
>  		return err;
>  	}
>=20
>  	err =3D ice_read_phy_reg_e82x(hw, port, high_addr, &high);
>  	if (err) {
> -		ice_debug(hw, ICE_DBG_PTP, "Failed to read from high
> register 0x%08x\n, err %d",
> +		ice_debug(hw, ICE_DBG_PTP, "Failed to read from high
> register 0x%08x, err %d\n",
>  			  high_addr, err);
>  		return err;
>  	}
> --
> 2.52.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
