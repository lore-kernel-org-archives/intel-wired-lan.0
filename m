Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615BB606A320
	for <intel-wired-lan@archiver.kernel.org>; Mon, 26 Oct 2026 22:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=DoygM+OC;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CHY0hHFO
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A96340604;
	Mon, 26 Oct 2026 22:06:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KqjblqDBxTX1; Mon, 26 Oct 2026 22:06:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8D7974060A
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793052409;
	b=U5/Mi2My6ksD6WvlUFNq7mevzShxA9HDuOLjhPYB6FRpvybUEcu+KA6UBQUWsDeTJIPr
	 WuOSde+NCRz2n+Fv8x/uFnzo+SHLIjwdbazQv2TbCfbGgBuO9inGpqPeMT8lVebCqWxRa
	 k/Q8LoSpHFqq42u3wB4In12MrOv7EHYPv+zYSm7AW/rb/PXNBA9QJ/+QaMrwd8pfpf6JU
	 N/DZ/X3NMNAWD/zEhqGz4MDiWpO59fx5KkVK//EYxdBCly48yu4FzKqUNqrcCoWiwJrIC
	 NnfIuuQQ4Fj4yf+vpSsPQsHHdWVT45+q/x22qoPY55kMyXuqoCSuKhIYsxZuvTXumfg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793052409;
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
	bh=ZbxKT+O8atgxTL0hWvP2WdH7NidgWcsuT13uVMzDWis=;
	b=n74tabf9UCnMu3mZRnbK3mtkBO1aoMdb2XGsXxiLOhBgGl1nJMRkZyt8omBu2s0kOL9q
	 rJAwcXdJ9Ok8DxahGkrB4VfMZWahX/P1Ip8CLCJT1eB3YOlqmiy6aGVFN9HkZbrvlbrp5
	 OkDbE1E4RSQhjq5XA6C3V0WH1N7kNILe7whzgT+lIA09lJc4J5Up3bMrOJuNZifZHWDK6
	 91KUwqgaB+D50u0a9TMrX5+x4uPC2uFzVwyCQi9BLPqpNT/+0SSFXBRTxBxdG/02EsIL6
	 d0/vcOJ4DbdsAGx7fPZQX20P/0FHeHZEu8WRYket1qKKEnTXa8rHdc/kaGzYDdXKnPQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793052409;
	bh=ZbxKT+O8atgxTL0hWvP2WdH7NidgWcsuT13uVMzDWis=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DoygM+OChtRi6Ty/ZtnTge/AkYiCF+oUU259waHOEkmyDkkPsSw5l1FxV3r0wlSlE
	 VK9QvUMRuAxro5rZF0IHYqDIX3fVSrDXU2EdwKamM4IIwbbg/cyBQe0IUZuknfHQBs
	 MedJwOkRxlJ9lvLdSydQrry9151p7QPVqWqnJbsg9zVKsTWI7zn+eXRZl8DVPnOZbF
	 QC4bq1lc5MA2W+wLx8uncJ9crRd181vNZwQNyradvaaoJ05sSe3Kn2dIKAFogOo08c
	 z6nt54gQUugA7stZ9LaFgrV38eHZVnal7rtpuG76OxYl/HEPuwBW+dK1Yz5aQzVpwV
	 pHpHW+n0n1IzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D7974060A;
	Mon, 26 Oct 2026 22:06:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C8F623421
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 22:06:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ACF4460607
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 22:06:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6ZBPtwbhZYML for <intel-wired-lan@lists.osuosl.org>;
 Mon, 26 Oct 2026 22:06:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9282C605EF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.18
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793052406;
 b=cJJb8xk4ohdHXRAh3z+VgxLc7PztHw/TRc2YB1OppZiPPX69X3ebVc8Gq1LUVtryY4a9
 RcSVqaTamsenZb6edj6x12UXYuUIuVw9q47dwXMUhhPrVyFyfH4Apa4wlWXLjEGEw3AQ/
 CUh5NNEB0vbUgNOpf9ZhKURYo8DtM951VSV6oFb6PoBoitAZvY0ZKdUDjSp3AmHUmL2GA
 Nh5ny+5pup17C7aGXsfE0WU1UrMw9YsKQI2clP7rvN4z91aaetuDWdep/lsHs02ot3c8i
 I+SXuGZ6iT+LJxQwj7irgqwq/iCLT4aYUbnWHgAJkzcMur2V5xxlMvAzQ/GwraIKKbA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793052406;
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
 bh=ZbxKT+O8atgxTL0hWvP2WdH7NidgWcsuT13uVMzDWis=;
 b=XgYAnJ9OvGvImZLYFi8bH7Ob3BZW3SNxwPAf1fJtV4RYLB2Wbte5R3qG934toZPT5sXb
 ZJc9tueFssbb12MUKTIFocnRHwMQG/VBcXpt1XWIRvaTwwCh3lH2P0MUGvxakdUmNMXcu
 2+EkYiwpZAJkgAj42eAm/2CZIB0D2nwxUzd8NfMqY3u2M8YFKuypqndxhCpzQOC9r69t5
 VRmq84A72HdJOLJyapyCzNiiIEvDOYH9Lu/Af0GkHYAyVc496EegpZUygRfw7E/sedlaR
 DmIhhIB9DERQBZZZMKNKrT1Vb/2sWI2v8+qYfT1A67AaFe1E1bGugbUXd8jHUz9zbWQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CHY0hHFO; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CHY0hHFO
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9282C605EF
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 22:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793052407; x=1824588407;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2YgYMuxU1L6P3iJydDjCVSDwN1LWTKtgDLwLh2Xqk/8=;
 b=CHY0hHFOGyqLs+H1nMrmIxzgo8JnXk2u0EGZd49Zi+fJHi/zcvh+K/Yu
 htqZSpquKfRV+kZq7FLRLYOlHV6v+wleBseIA+aYG/Ycn11ivHztnJ8CT
 54EdFFoN9yEXbkUrqYtYQ77GtgJpjeOYeDgvvSa5FuB1/Ncm3CMW1b4e+
 BMUwvjdlG1FYt1j7RvpBcL6/RJDuAlwJbpN6jwj7IuzH6kuok5n58UszY
 XlPSPKKf/pD1F7byDLV9D9QP5eTBOoA0yOWI0l3Fpz7yNdFxZPL9VB+r1
 gN4H//IYcior9Sgn+p9Xl5RPVgH44RFqYTn9ki3D7eCVPZDyY4lOIm1Hr w==;
X-CSE-ConnectionGUID: V/tYLgepT9KaFIAGI/r8IA==
X-CSE-MsgGUID: DUEUBIjNTdyhew9UrfV2hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1773074"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1773074"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 15:06:45 -0700
X-CSE-ConnectionGUID: HMiRwbfZT2Wc7cBXEo2HmA==
X-CSE-MsgGUID: 3m/+QLIhRoSuWrMhRO/8Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4391610"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 15:06:44 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 15:06:43 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 15:06:43 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.5) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 15:06:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2F5uW1wRnNk3mNJZI5KxdluEGgY0QNBaifux9HN+y8oyfJ5EeMOcxdgvltBIEr1tcjLZPmZ8h/F7eZYI8AL662J4uXI3I73xexAXqIQM8TkJl0PkrzAk3yr90UwXdOuTXIbsRQl7noog9grzobeqCUeY7xI2XaSaZgU1AZFfTqevAIUjfNFmuB6OEvjinuN28EbsnJHbaNQOiLh2ygM3AuiJHw2AjturCvG0RS7VbBlyUmh0XbpRpjF4Vbtm+umNoxHC5kSoJBbwKWFUTNIGTNbFqe9dm/CQaaS55/KVC8o8yuDGjGmAirl0h/EnXydIlGxfbYOOSuikkY/43RddA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbxKT+O8atgxTL0hWvP2WdH7NidgWcsuT13uVMzDWis=;
 b=NhnleYNQYKEO73E+5DAVCLIWBrgGv7w0l95+n8xnZSdUU9jbJ8yCQ1VQris7gCZHfj1FA84iKAIUSNlVlDJ0Gskd9jtz6FGcg5LkVmHFbByfl+t5Y6lBg2pPBtzWikJ74Z369q3sQ6G1FRAovnpJiURD6pN/UEIoIKVJ6ojx6y7vm3OaSxVMNL3bV+mAnaPvceEMICCHmhqlPJjQfgOh3qHY+YAsIooZflwiiiukOgEb8zdx4t/ZfnfC+fmQYeYjGFsp0HF80WNkhMSTwUgUh7wKOWPchkjRWL7jutwCar4Mz4SWJ55N4YkphV1g/sPBm1c3CgHKxhIN800SB0IB/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by SJ2PR11MB8347.namprd11.prod.outlook.com
 (2603:10b6:a03:544::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Mon, 26 Oct
 2026 22:06:40 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 22:06:40 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>, "Ilichev, Konstantin"
 <konstantin.ilichev@intel.com>, "Olech, Milena" <milena.olech@intel.com>
Subject: RE: [PATCH iwl-net 1/2] ixgbe: clear Rx timestamp in packet enable
 bit on disable
Thread-Topic: [PATCH iwl-net 1/2] ixgbe: clear Rx timestamp in packet enable
 bit on disable
Thread-Index: AQHdZWfphoeccAQjOky+LVZT6TcZYLcQYZjg
Date: Mon, 26 Oct 2026 22:06:40 +0000
Message-ID: <CH3PR11MB566895CE6899172FFDBFBC9F3AE5612@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261026163658.2733471-2-przemyslaw.korba@intel.com>
 <20261026163658.2733471-4-przemyslaw.korba@intel.com>
In-Reply-To: <20261026163658.2733471-4-przemyslaw.korba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|SJ2PR11MB8347:EE_
x-ms-office365-filtering-correlation-id: 0ca83f89-d0a1-4edd-2d45-08df33ad69d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|261026140227099003|38070700021|261022105027099003|261021123027099003|4143699003|11063799006|261009223027099003|5023799004|10067099003|56012099006|261021121427099003|261022075727099003;
x-microsoft-antispam-message-info: 4j8oc6NxfbKCQ0P52uO4KoQgn35HW0J7QFkNTKAHpinVJ1uNmk0HBAm1lZIvm9wzsIbGutqtWDo44iHZhYjEHm0SbEF2YsCdd6aFYKula+57p6YvPkx+1oK8Vt1KL1MjOrcZK9Z+GVuocLWnEQke1gufY8ovLSsO0v/egjah5911Hg/8VIYc/RmKqaQuhqFkApv7HbPUHmrAZbX5gBaw7CM5p9r6dktZ6DXgWDDK0GDmDtELASms6CurIR3Fb8Osc78W60vXBkvf2ePI76nX3x6oJSW92fh7diHC30udSes9GqQO85G10OuW+v89V9TmmylzpH7jPkDbsZzXkPs4J0UT5DWPFWYwKbty2S+gPLLkIJWbFPK/eMZ3IR21gSMd6X5/FwdyDHv37wF7K7iI5A6n39O9FXjf0V/H8xlmaH2AZeQ/pere95kuGOoKQGZoooD271Kwv6ciVUp5Y8VFAv/WsYic5blM7vTx3LzBFEswCA+jDEvXWfMMCj6PxpLO6MFDjtpCyo+vOR7D++vIahuCan7KaTDhINyOZY4ni6Hb695pPXLnjVXHUU3ROIeZsjnJBtxIeBcKuZld7dD6RPYuGJmFv9Bvyuhz6ofbUTRwJqjMEKx/4NH75RTraeOIIMIGLDpZq0A8LwWik9hOZZ8TMGy+NARob6oRTTsL+Ob5mYDSIVoMdiG7xmsaQeTvQOPFH6ZYlltCOI5hkUeELIJ1AhDi/vAgWJpbZVQk8Jo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB566895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(261026140227099003)(38070700021)(261022105027099003)(261021123027099003)(4143699003)(11063799006)(261009223027099003)(5023799004)(10067099003)(56012099006)(261021121427099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RFmGUyzmgQSssAArThJQfmCQBa+anZbjNt7YfaqgcoMhvEd1Roj+CO76b9Y/?=
 =?us-ascii?Q?zsFCYop0XZKfvfljEVBnztGkwanNFEO+SlbRcSOoSMo/Sf0QHA/dJAFsZgnt?=
 =?us-ascii?Q?UFe2RLr0mZSnRjBHvoarDj68rUHKrd4WlkFGzVOtKMYnPYLckp/3bYiq43SI?=
 =?us-ascii?Q?TDX699sk6P6hERPWwRN0YmIRN2u0wzy1/cIdiNV0SeqhyC/tbaK7+PaqD1IV?=
 =?us-ascii?Q?M5DAO81Kh7M/ovPqzX0wojCV0In27/Al6yEoOEYln8B00Bm8WqGUeUvnk/d7?=
 =?us-ascii?Q?VJxTsrqx3s/ujQCf5fKFC4nbgFLqJcZctU0rShKns0H992yTr/TybtfYx4TM?=
 =?us-ascii?Q?HbhvNnhEafY5N3HFPFj2Vv9K1TSSx7iNSFV0JnNhrHWDzTUs1fMzQAv8h4Z9?=
 =?us-ascii?Q?SLEMf2xyLdJiPX3949GJx/mbln0u5giyweeK2Ye/DxVUWTb3oYqk1etbW24M?=
 =?us-ascii?Q?HZWH7ViXDEajaYpOi6kcOcOR9MbGbjSVgbpneqXvKI/cTg/bVl+RQQ1ljwdm?=
 =?us-ascii?Q?o6U2A0G+OE5NVgklvsOnmUxjFtLnokYRJP2TjSnDzIlwk94SIZvQByZkTm/C?=
 =?us-ascii?Q?AvCC7z86ObtZeOm7K+qrWLlMDyrkuvgHV/vs5JYMkchRNvQfNaKYqGvo1ZaT?=
 =?us-ascii?Q?YjWERiYFh6aH7OIl4QtF5NW+kspBlO7GcBVIlpJ2auvnVnobJmkec5s/DqrB?=
 =?us-ascii?Q?IZq/YjauJBTExQL47eNZRPDsg+kv+eNHcdBC2ojEWvMDkQcSzwXt6EiB1IzS?=
 =?us-ascii?Q?VxFmffoVW73vsVbVAvq7Vxi4sVZhIfw9mkzYh7rEr+JcOpqca078hW7a85gU?=
 =?us-ascii?Q?pLSRzmNSFj6kfEaaIy9OQmJIJNpOLmRZM9ZEqJyy+1FooeFLkhlkU1TFFCpg?=
 =?us-ascii?Q?8YBWSxpnQtdGKP2BQfxeXvW562jgCX8AfFdXJ+7BYlUuSoLhBiOPy3QcMFzz?=
 =?us-ascii?Q?m7mDTFx3JxmyQiChWBOC27H+a55h2iUY3pD/YzuWB6DbnOFXs7ybDa8bCTwE?=
 =?us-ascii?Q?PX2rgOvgfgn6lKtx29feyvwkgobnKlmo+YGNujujyXDZMAWKg+XYH9OQH2H8?=
 =?us-ascii?Q?ksaWWZFBhFZs7+OCC+jg9s6570VfWPg8dEVc4iQlSGoH3CgUR+J2p59tDnYo?=
 =?us-ascii?Q?16JJXhz5cCPWGrJxuNkzc/mmrent145b2nCRL8Cpurs4B+bMBecCZKwwyi1X?=
 =?us-ascii?Q?NamTV3T4JanGt6R7M1FJ+2FlO8O7acMwnTG8I1m0WfzfaqEFMAqjmVQw+DCn?=
 =?us-ascii?Q?NRHeR+BbS58O1E8a1ioZ6hx4vh7nCGcVX4GKRDZsKPEYOLXQUyfmXN+06Cu1?=
 =?us-ascii?Q?sqmS5qIKsduA6hjs/V2PNutLUMauqmF0BMUOETW+cQ3ITw81ncuq8Nc5zyQa?=
 =?us-ascii?Q?WzCBVRufQL6X4D2FvR48HsVMPdgs3pem+JR7uixhuPHglBL762n/nF4LCcJO?=
 =?us-ascii?Q?nb3ggEFHBT7Ft+NfUftdkIFK+gEEG3j3RLrJB4uiW73338COucuKn+54Xi/v?=
 =?us-ascii?Q?ccZycG464BidqEM32TZ42oqcHsz6l9hRqAsiCR6O6Xl1RmM88VvUKIjvMieR?=
 =?us-ascii?Q?BZwA0h1u4iWogugTp0aDk1uCosVJpmxuD1e15EXOzJTrx7C5XnmKGqw51g5x?=
 =?us-ascii?Q?OyKzz0fjUtwBO7eidCs5Q33uhR/6TIzsn/uNcG9xJyHJwtWOSbOc61/zsIUg?=
 =?us-ascii?Q?GAfvH/jXFnxZF1/+ocO/fqrTQAPm5N2EEURwcNNU88GfvmcHFNky8gB+skUf?=
 =?us-ascii?Q?E4LgqeFXtJQo4fci1tFtllT39B6LFIs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: a842ELceWiG80x1G9Ytzb9la/7LmKyTwz4ivRPbdjbx9PWNsSGaCsmSYxXtHr2hdXY3OsUMVlaIPrELhN/+VyI5/s/6ebpBz2yq+zwOx68VaohqD7mZvM+WwnP3Uhex4TxA4/piizSfItOrrhhWZkNcCODnSYlmFeBlu5IkcMqAj0aDyUkJFvYXMFEJYdEWtymgBq9a64RpD2HhmzLkyBbmkX5GkQbZi2E/3rn8vDX0TR0fG922sns0Azj7Ps6XSWq9PPL7gDo+ibHMVuec8Vs6GZSVfklaNqZWFYhexz8kmOjD6ceEXTb+O8Xl5voPxE3nyWUppEeqxpfv6Yw6AXw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca83f89-d0a1-4edd-2d45-08df33ad69d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 22:06:40.7664 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VoVEAOZ7BUKyz2YeZgiJCeaTuVZPgpHbNVVY4Yt73HDXOuMq63S6gqZRftx0sG1b5SmG09/ubMLimAbR5piYkTUKoMGcc5OEEtjo5aRWZfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8347
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> -----Original Message-----
> From: Korba, Przemyslaw <przemyslaw.korba@intel.com>
> Sent: Monday, October 26, 2026 5:37 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>; Ilichev, Konstantin
> <konstantin.ilichev@intel.com>; Korba, Przemyslaw
> <przemyslaw.korba@intel.com>; Olech, Milena <milena.olech@intel.com>
> Subject: [PATCH iwl-net 1/2] ixgbe: clear Rx timestamp in packet enable
> bit on disable
>=20
> The TSYNCRXCTL read-modify-write in ixgbe_ptp_set_timestamp_mode()
> clears only TSYNCRXCTL.EN and the TYPE field, never TSIP_UT_EN. On X550
> and newer that bit is set whenever an Rx filter is requested, and a
> later HWTSTAMP_FILTER_NONE request takes an early break out of the
> X550/E610 switch arm, leaving the bit set in the register while clearing
> IXGBE_FLAG_RX_HWTSTAMP_ENABLED. That flag is what gates trailer removal
> in ixgbe_ptp_rx_pktstamp(), so frames keep the 8 byte timestamp trailer
> with nothing trimming it, giving wrong skb lengths and rx_bytes. Only a
> MAC reset clears the bit.
>=20
> Add TSIP_UT_EN to the clear mask.
>=20
> Discovered by code review of the Rx timestamping path while working on
> the following patch, and confirmed by code inspection; not reproduced on
> hardware and no kernel modification or error injection was involved.
>=20
> Fixes: a9763f3cb54c ("ixgbe: Update PTP to support X550EM_x devices")
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> Reviewed-by: Milena Olech <milena.olech@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
> index 6885d2343c48..8dc6a009b62c 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
> @@ -1111,7 +1111,8 @@ static int ixgbe_ptp_set_timestamp_mode(struct
> ixgbe_adapter *adapter,
>=20
>  	/* enable/disable RX */
>  	regval =3D IXGBE_READ_REG(hw, IXGBE_TSYNCRXCTL);
> -	regval &=3D ~(IXGBE_TSYNCRXCTL_ENABLED |
> IXGBE_TSYNCRXCTL_TYPE_MASK);
> +	regval &=3D ~(IXGBE_TSYNCRXCTL_ENABLED | IXGBE_TSYNCRXCTL_TYPE_MASK
> |
> +		    IXGBE_TSYNCRXCTL_TSIP_UT_EN);
>  	regval |=3D tsync_rx_ctl;
>  	IXGBE_WRITE_REG(hw, IXGBE_TSYNCRXCTL, regval);
>=20
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
