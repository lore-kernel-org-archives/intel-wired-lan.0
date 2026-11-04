Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BBF606A326
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Nov 2026 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=YwTgcays;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L+JYKsux
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD24B606CB;
	Wed,  4 Nov 2026 14:22:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kb1xeM4_pBMx; Wed,  4 Nov 2026 14:22:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 97DDF6067D
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793802171;
	b=GWt49cWfR0t0WhjJJ/exM2Pr899rhZHHO8nuFHHKMzi7vlWVn4resjxtF1LvQf1PINmV
	 6uQRRXLOkT6NMc6Y9wi85m0F9NlmyeBwzBgqNwc2v+uZaMU9Ga6WfbeJ+lk8LkMPE2Iem
	 SNOxzNxMw158iq60xszMhF1olodD80Ae76nInU/X8B7xpu+oqOBm0mPsOOTFj0JJrZTaf
	 uBfiiFi2MXhDfDCy+EFsmSTP4+RDVZdEI9IzaJtj8zZDnCCU0YGtdprLB+AmyoC2CvqAB
	 cPcN8LFb9cvcoytc59iK4nrVIrtulIA0YrPxmGAFEtoHHPr82GTeAVGWuX5PGc21aYw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793802171;
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
	bh=KkppCzhchWLEE+XGwqvQ38PLldVx0cVDlR09JWiin4k=;
	b=SVmOFHoVQATgCMtiFFUUvyUIUoF112nCRc6H/lxVfURf72Rr0qXegnUHswE8Ac5NUigG
	 dACnajNwAsPK72knNiPGUiPKUQSxWXBqwUJwb2MFtpnxn46/1xnsNESFxjjLkegvieGCP
	 LrH3een+d5inmXH1oK3T1Tz+1x7zTyLjVfkX4vWfwbDhGKT3WFJbnbAJnk08SSOcNi5qm
	 iCW/j9xj2d6BZwbrvMulUMRi7AOBi2zXEU6TlAUSZWuM8xa8HEwei2DU+Ej4zzJ1QQueg
	 yNX4sGKJeQmvMVbSeENU+uKFJz86C0YB7i7xdTQUtsJtiv3pigJ7INfcAWQ/AryV0XQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L+JYKsux;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793802171;
	bh=KkppCzhchWLEE+XGwqvQ38PLldVx0cVDlR09JWiin4k=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YwTgcaysTD98X3M2XFLzm97afm8m3fkZ8oV0fGfwaxwbJClqbG5Co/tJHLsni3UIw
	 wQ5aG4RtQaDp2dzFMnYBrBTQw5Io2i63lGar4VxO9vSQ4u4Hz1kfDlfE6l9bUyqRft
	 pM8Nx9SXXAXMDSxbLTMIy9jcXzoKFozjDcPU07k0G4S2ymQsp7abPBHIzVXX17jAUR
	 LoaRUTtKmlTUv0JFwjYVEV+JKd1Kkw0aGBQlqtsNZkYKRdQ5vXbnodFo/yZmW9+lKV
	 N7Mtxa6XyUI/+R5Cdq8EzT07SPtYWk62rkAvPVNss+UxnJUEqdA//Bh5eqXM93jxOQ
	 LQxkQKxXm7XrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97DDF6067D;
	Wed,  4 Nov 2026 14:22:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 13953362
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 14:22:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 04E176067D
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 14:22:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KhZPUq20A8We for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Nov 2026 14:22:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8645060642
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.9
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793802168;
 b=TAkrFWvKZ2kRzT9/12WcVwDaULPEVvv2PmZFMLl9D/rKQ9lwAnNXWiUS46W9CENDTQOA
 fQqhZnPE4CyLgEEeL01iq7fGcm4USH7oJCcDG9btD6VVsxhpVoVA1xjgTznRX7MMEAQp5
 7zR2dX9vsCgPRgOB6nql5g4EHSGIX+VjXzg34TqRJ9Px8kVsFF2SwrBryaPPHmPLu+4Ne
 VpfsmoiEcS27exOiT99uBwgWxv0bfqHRAlL8mfNhm3uz70FOHq/7/7nRrM3HkpGIhYJND
 cBhdHzzNJkQHtLQSjimG35EVgWbyaV3w4LFudBP8tvQcbyT2KDiieB6V0z+m+BCcDjw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793802168;
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
 bh=KkppCzhchWLEE+XGwqvQ38PLldVx0cVDlR09JWiin4k=;
 b=NArb5vfnTXGtnytLrZxTlnQGvC93AZ5dMcKEF5gDyhvWj02EMZfH2rPlMy/k/sg9ye+M
 DgxsQ8OjFvw5+k49xbAjq161I4amETU8sZa+/OxJXRWTz0sR+zQyJ/HyW8lZP3P0w+vVc
 RRHJ7s0W2NsIa7KEbPjueJow5XuGvWdWnjSYGHsGNwK4KHAUaM0TwG4gf3CAG8RRm3D1v
 rJoYkP8fNSfiTTGQkRRAzbklvklHeJcciRso9SAeJCmUNNf42fZNpqE2J/hcpnD3X0da+
 eOABcs+1JQy5ArPInu/8C50SDNLW7pCsggEAceY7GgZyUmoai9ckYUVOUgnckD/ADbQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=L+JYKsux; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=yifan2.li@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=L+JYKsux
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8645060642
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 14:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793802168; x=1825338168;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VA1kCngCBZ51LxkZ692rGk4Ad02DWy7yOpUHgZXoVh8=;
 b=L+JYKsuxO6yFYFkUwFM53FxlNtv5KWjmoGpZ1EEP4kFAmGEXk02Pjgb2
 kmlKwmiZMM5vJYjfJiNQP+ZFzz68jR0qGl1aFlkAKvi57RDplBl49DAER
 DHWhLEHXSIJiBsRM5qdxeuslK5QVe6xvHc41CFYKbSkDxrg6gytF+uYM3
 FXPOTDCoU11clq8vEow08x2i7DupaJojXr1xxE7vW1Iwyz/LMn3+7vR8U
 0ypXM4scqV1yfmE9+wRXNhY4eGKkvSXMh3zkww+4V1lw7AjhZ3Pr0U88E
 vwnU9EzEIQ6lzPY2Y/UtfDB/jmI9SCRAB9uRbBK3FhYDMHPzKj3guOzGn Q==;
X-CSE-ConnectionGUID: IDebgsPqTLSJmzlJQ9q7ag==
X-CSE-MsgGUID: p/3TPrm0Tq653ZKsb7ijAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2431670"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2431670"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 06:22:47 -0800
X-CSE-ConnectionGUID: iUQFJqcSQjOLGXVA8Mff3g==
X-CSE-MsgGUID: /27YA2ELQteHXGCO0tsFKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6626289"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 06:22:47 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 06:22:46 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 06:22:46 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 06:22:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sosakzdu7L+mOXOXNgOZSu/ZWi/PZ93+WlO55EyAsSKIzFh6FV7GwDa8qP34gPZh3sIyYW5uyhDkGLdbFyBlpvx+jiH9aQHI+XKI8yPA2X3KL/6YSqxlgaE5VEIGmIMAWLy4qlEfDNXzIaDZui6Bl/ATqMGPfZQoZDWYt2dfVM5tIHM61EJcDrjaBxg0eEr43oEDOA2OBKXJd3JySQQ/ypAtYoiR1iemxhIMLgWGK9YK14BXr+zhe0po7T95kZrbm/B5UYMdWyzdkV3r9lJMuek3DAAJxgdQP0K/KknBmmRoAxq1ptVa7XYhxNQExa/fIj3VXieHj6mbfoqFn9Ks3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkppCzhchWLEE+XGwqvQ38PLldVx0cVDlR09JWiin4k=;
 b=WC6nuoB9E14qWcWnGNU+VeZ/LT73JR0FM9JezNAvork6jkLtakDtnvROfeEM8fQJkDSYmlJc1TQw4n1t8dLRp561WhDH6kALKLPGQwl2DbMnr+h8r1Iq+RbAju+wAudfRBDtLKWE8UNOrMxunGV58yBy2VZXMFMv1BvU894+iry5OcRYavW8j+YblPa8uxuUi0oC36TyVj0Z+nE+EXTUG+hfmZXk4b1J62sDtWwoBmOWMmbgvLyDMvkiEniI6jclwPul+KkfXqEvNqxNeO/rLgiuHJ0ZanNK3d0C5a5qNCtD/0t7g+KrMBdcbTsctmwVNxkIt3FxRKzXZA3jDV+MAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN7PR11MB170846.namprd11.prod.outlook.com
 (2603:10b6:208:5f0::20) by PH7PR11MB6355.namprd11.prod.outlook.com
 (2603:10b6:510:1fd::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 14:22:40 +0000
Received: from MN7PR11MB170846.namprd11.prod.outlook.com
 ([fe80::c6bd:5893:4010:b667]) by MN7PR11MB170846.namprd11.prod.outlook.com
 ([fe80::c6bd:5893:4010:b667%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 14:22:40 +0000
From: "Li, Yifan2" <yifan2.li@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "Mika
 Westerberg" <mika.westerberg@linux.intel.com>, "Gomes, Vinicius"
 <vinicius.gomes@intel.com>, "Ruinskiy, Dima" <dima.ruinskiy@intel.com>, "Li,
 Lili" <lili.li@intel.com>, "Wang, Jie" <jie.wang@intel.com>
Subject: RE: [PATCH iwl-net] igc: Disable PTM after the last device reset on
 remove
Thread-Topic: [PATCH iwl-net] igc: Disable PTM after the last device reset on
 remove
Thread-Index: AQHdaxl9YJKvLlrrZkKQAHjO1VdN7bcd5FBg
Date: Wed, 4 Nov 2026 14:22:40 +0000
Message-ID: <MN7PR11MB170846508FFD9A89461965524FAF682@MN7PR11MB170846.namprd11.prod.outlook.com>
References: <20261031021928.1714612-1-yifan2.li@intel.com>
 <20261102222817.GA983941@bhelgaas>
In-Reply-To: <20261102222817.GA983941@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN7PR11MB170846:EE_|PH7PR11MB6355:EE_
x-ms-office365-filtering-correlation-id: 6fb716a3-6de5-4024-2861-08df3a7f1598
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|38070700021|56012099006|261021123027099003|5023799004|11063799006|4143699003|261021121427099003|261028144727099003|261022105027099003|261026140227099003|261009223027099003|261026121527099003|261022075727099003|10067099003|261102123227099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: nPvegP7wp4LflKTW6hmcrG6jDuPo1+k7wn9FgHLnVD45/y5BKh6Q+CTaKgsAk6WBVzMLYZOAzVxAv/nJ2+jFio68mpGAlMLNhNQkV9DqJW7Yii01mbYDk2TQ9nYx+pyxFUsv16DJFImu+kOiwH3ec1sfjahGi6TUJmZeSwt8eqr2rIqUZgSNjYzIAP/6/el2R0kMYCqX6cRjlsUQXSz7SVOt0VMMm6o+7Bh7/YMFRGJGg40TibWohHVmgbP5Pc/js49Y11ftjddoqdLq6YsCzh2ktI8RA9i6XSh+Nl9RwmRxt28qdsUuJkDZE90eGkLANTa5DsqA4sCc/HYFJlo79TDsHzjMZK0LAglo64XFvgKKClt/BhTP4bIwO6HhuUSRfFoZPnZarc+W8zMarYC7pGfoWfkaSiRuFViBH1xbhiiejGMh/RZjNrRKgkqkOrZtStVPYn5DnTzoQrJBkf+kviHjeSWVlvXk7/DUAFiNFrr3cjHYOqu+24OL7yflnl3sIHetr42l9LzF92to4QvJWtgtfJLpHyFcq6aUMQlksNdqn9KVNFCTLM/M6erC9y6g85+cYgPm8bq4RjhmKWlIHVZR2fHfcpOo65Ncv2jZbAQjm/UkErwlV/Z0sDSAFqVzlBziOuJOoh4+0YrSM09Xd8HDoLHDhme7/AYVEfXtAtA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN7PR11MB170846.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(56012099006)(261021123027099003)(5023799004)(11063799006)(4143699003)(261021121427099003)(261028144727099003)(261022105027099003)(261026140227099003)(261009223027099003)(261026121527099003)(261022075727099003)(10067099003)(261102123227099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0CvIWPOtaSaMgpNLWTQ0q5jJ54Uioh3DO6Xq9QUv2XUei8hIjHuNqSd7HTv8?=
 =?us-ascii?Q?bUkGPvPP7OHoHYkhGbC2HJIvWdYeGQTsjlhTsG+Vg8KqXRTHqeDlCldmk/02?=
 =?us-ascii?Q?3R/qaaD0IQyRz+idGQdFMRzjQqWsESnDDTEo2NffXIu2b1OAqf45Wml2yuvD?=
 =?us-ascii?Q?UglQELOrCf2nRpUUYjSYZl3nYsPoFgg+jVUDFfnN4r0DLWDTG842+11tFHvY?=
 =?us-ascii?Q?GkGSmiyyi/1L/hHUJAbw62MazG5HF7E+E/fZZ6lxreKlr+42MAA8ux14ATKc?=
 =?us-ascii?Q?X5q12cFTCZhubtDBc2qGs/H/vYHZyDwb4qmT5FwwNNkhs7of0QXbD59i+nfq?=
 =?us-ascii?Q?T4ZYzjpb2hfFD9gZ4hLaj3YNjLvUrSk7Fo6pq/xgWcLpfuNKY/rE0Rf0Awke?=
 =?us-ascii?Q?seFMBkvQVCpirSwKN/j9vEi0AsxRWamOx0rJ8DsjuhXsa3vCiuNsglLh+x8b?=
 =?us-ascii?Q?qYbB1aJWL3EaKWzokXnpzL/LuOLBVSZmA81FEeyxIyZpY9asuE0F64+ynbxs?=
 =?us-ascii?Q?RXIELozF9aV2zbbUoDBXRIGuUTjZJnsjD1dkaDFr8fS6WL4mSjUJHlGHw+Sm?=
 =?us-ascii?Q?tNBR7hpHexfQYwJsOnwLQ2dy7K4SJ2JwOrenOxFabc3OTw5UgYjUVHW3Ksq0?=
 =?us-ascii?Q?5PQitCayjkeEWGau/Ek+tWSOB0GqW/vzK6zUa9K/gD8xYq5XaQBQqLfJAIFo?=
 =?us-ascii?Q?OAdrtqaOIpXh4JXb1YdtGX/0cT7f2HHRYfIM4VFaVK8SHUNg/av10s0P+ceD?=
 =?us-ascii?Q?cqdXty1MdTWorJTXSWGIb+P3ndCfEavWuqT5MpzkZ1eUcZD47A4CeWYtqrBk?=
 =?us-ascii?Q?xswh5Y3dw5V8CMELtqmzcFkfqU27EtLL2wmxAoEpsMOYyRGmZFNOS2Zm0aAU?=
 =?us-ascii?Q?eaQcHmM0K/9dvRAUGfBHJGktM1tmmR5Abm0faud5m4Gh44oMVCBgL1wLd3uz?=
 =?us-ascii?Q?5MCxYsmmmu2drmQQFAMc+jvsHagUdAZA0fiodf+ZkMsK2qxM1sgl0PJV/pFP?=
 =?us-ascii?Q?wZdNVbQjz0Yle6sqf8PcOlsU5tIt2w9MYQls6RUTfZ+xEnLZEqdEuTvv2QX6?=
 =?us-ascii?Q?1YsS2uEeL8wH3fbpGkSwdfB1yUDPXv34tgQbpkpVROW/pbt61UNsue0uRUYi?=
 =?us-ascii?Q?vJ4yolmqtq0IEZ5kSbfEEswzOgw3QOE1uXv7JBBenHwIRfRMHxdlyrG5O+F7?=
 =?us-ascii?Q?yZke3ekU6ncCObA3UXsduXYedLmj1XGlYgYpxr6ngVZkzSfbA0109TBmwLpW?=
 =?us-ascii?Q?GsV03acM46sKBrnw6APE9CNJ/vUrNXqcnuQFE7wnEkmwfIzx1KxxEzYmQsfn?=
 =?us-ascii?Q?LO0gfN1xcahLPKChOtPj5tkv4CYkPQQpWomjuuRAf/xd3aHWva1w/3FU8BvQ?=
 =?us-ascii?Q?alialKbGaWA5W6NNeLRx5JtpsMHhQ49JqBcbRm0Gflj1Dzp9699egHHarvQ4?=
 =?us-ascii?Q?gZAFXkgQLxhen+g8EdUCXZN8Po2vngvVEJz7baP4zt9/3wQSkc3/deaO6nca?=
 =?us-ascii?Q?4C9b0z93de19jH1jen0i0LsSI7aEaOMr2jgRFszolktjsklNavjJwjPpCO7s?=
 =?us-ascii?Q?580RXBWaGfd627adBCju97PerGbXl7b6vBCkWZ71MX+WMntn306BGYLZw7zw?=
 =?us-ascii?Q?j+F8lENv3CGHQCnVZi89B/J6ItCXZja623h4VkBZFtoVTmPQupdLtlLX7uA/?=
 =?us-ascii?Q?9zWL2QVvennVnkaKMMhY8Tz6nhAalSEDho29ql0524h70BAY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OnDzpouPcY0V+D3dxT7gNhQoeAuCwjU1uhlU0ukzRC8t9IgrLO50b6K87Ckf7IiJQBcB3Q6VWb20FYc6gWLIvSjDZt0sKG2U/tbNoTIH8+/h+21SKEJSrVH79NUfMxEb/4jveKjlTrHs56ZC/6OdvLxB0UlOPO31ykaxqTq+e2aXTlCxOE0dXqgaSYq9Ls5DYeAjgYzvt1Tpmq6qOywlQjRAVKFcMuak94WKl5x++epJfV2k1EXnQ6Z67IhiFHS1mglGAbw09QXmG4I9M4qbKpltQhqR8T/WezIW1KDlpXn5T9jTnj0PXlpk4/AmxzdPY80PHLoti6CLyglb3rrtww==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN7PR11MB170846.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb716a3-6de5-4024-2861-08df3a7f1598
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 14:22:40.6992 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EX3aaxA6arvwTpoENp6omAPcHEREoDQgOrne1nslRPPa4FPJEc7hPG3sYSx9m5LQN9ch9+j0ZaajLeuQ4AnlLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6355
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Bjorn,

Thanks for the review.

On Mon, Nov 02, 2026, Bjorn Helgaas wrote:
>=20
> On Sat, Oct 31, 2026 at 10:19:28AM +0800, Li Yifan wrote:
> > I225/I226 have a hardware issue: after a PTM dialog, the next device
> > reset through the RST bit of the Device Control register (CTRL.RST)
>=20
> I assume this Device Control is a device-specific register, not the Devic=
e Control
> in the PCIe Capability, right?

Yes. It is the device-specific CTRL register in MMIO space (IGC_CTRL,
offset 0x0, RST is bit 26). I took the name "Device Control" from the
comment for IGC_CTRL in igc_regs.h. v2 will call it "the
device-specific CTRL register".

>=20
> > can make the device send a PTM Request. The device sends it even if
> > PTM is disabled in its PTM Control register (PCI config space), the EN
> > bit of its PTM_CTRL register (MMIO) is clear
>=20
> And I guess PTM_CTRL is another device-specific register.  The architecte=
d PTM
> Enable bit in the PTM Capability in config space is supposed to be enough=
 to
> prevent the device from issuing PTM Requests, so I guess the device-speci=
fic
> control is only relevant because it's not enough to work around this hard=
ware
> defect.

Yes. PTM_CTRL is also in MMIO space (offset 0x12540, EN is bit 30).
The defect is that the device sends a PTM Request while the PTM Enable
bit in its PTM Capability is clear. When the request comes,
pci_disable_ptm() has already cleared that bit. I mentioned
PTM_CTRL.EN only to show that the driver has no other control that
stops the request. v2 will say this directly.

>=20
> > and Bus Master Enable is
> > clear, so the driver cannot stop it. Commit c080fe262f9e ("igc: Fix
> > possible system crash when loading module") disables PTM before bus
> > mastering because of a related issue (PTM Requests with bus mastering
> > disabled), but that does not stop the request at CTRL.RST.
>=20
> c080fe262f9e and this both mention Bus Master Enable, but I don't think i=
t's
> relevant to either change.  Bus Master Enable controls ability to issue M=
emory
> and I/O Read/Write Requests.  PTM Requests are PCIe Messages (not
> Read/Write Requests) so Bus Master Enable should not affect them.

Agreed. Our data confirms that the I226 sent the request with Bus Master
Enable clear. v2 will remove Bus Master Enable from the description.

>=20
> If this is a documented erratum, can we include an identifier or a pointe=
r to it?

I am working with the I225/I226 hardware team to find out if there is an
erratum for this. If there is a public one, I will cite it in v2.

>=20
> > The request is harmless while the upstream port has PTM enabled. Since
> > commit e1092d5e15e6 ("PCI/PTM: Do not enable PTM automatically for
> > Root and Switch Upstream Ports"), pci_disable_ptm() also disables PTM
> > on the upstream port when the last user goes away. igc_remove() calls
> > pci_disable_ptm() before unregister_netdev(). If the interface is up,
> > unregister_netdev() then resets the device through igc_close() ->
> > igc_down() -> igc_reset(). The upstream port now handles the PTM
> > Request as an Unsupported Request. On an Intel Nova Lake-S system with
> > an I226-LM, this triggers DPC on "modprobe -r igc". Recovery fails
> > because the driver is unbinding, and the next probe fails:
> >
> >   pcieport 0000:80:1d.0: DPC: containment event, status:0x1f01: unmaske=
d
> uncorrectable error detected
> >   pcieport 0000:80:1d.0:    [20] UnsupReq               (First)
> >   pcieport 0000:80:1d.0: AER:   TLP Header: 0x34000000 0x81000052
> 0x00000000 0x00000000
> >
> > Message code 0x52 in the TLP header is a PTM Request from 81:00.0.
> >
> > Reset the device while the upstream port still has PTM enabled, so
> > that the PTM Request gets a response. Then disable PTM and bus
> > mastering. With this order, a later reset sends no PTM Request (tested
> > on I226-LM). igc_ptp_stop() has already cleared IGC_PTP_ENABLED, so no
> > new PTM dialog starts after this reset.
>=20
> IGC_PTP_ENABLED is just a software flag, and it appears to be related to =
PTP,
> not directly related to PTM, so there are some dots missing between it an=
d
> hardware PTM messages.

Sorry, I skipped steps. In igc, PTM is used only for PTP cross
timestamps. The driver starts PTM dialogs only from the PTP code, by
setting the TRIG bit in PTM_CTRL:
- igc_ptp_reset() sets PTM_CTRL.EN and triggers the first dialog.
- igc_ptp_getcrosststamp() triggers dialogs for each cross timestamp
  request.

igc_ptp_stop() runs before the reset and stops both:
1. igc_ptp_suspend() -> igc_ptm_stop() clears PTM_CTRL.EN.
2. ptp_clock_unregister() removes the PHC and waits for the
   getcrosststamp() calls in progress, so no more calls come.
3. It clears IGC_PTP_ENABLED. igc_reset() calls igc_ptp_reset(),
   which returns early when this flag is clear, so the reset path does
   not set PTM_CTRL.EN again.

So IGC_PTP_ENABLED does not control the hardware directly. It only
stops the driver from setting PTM_CTRL.EN again. v2 will describe
these steps.

>=20
> > If the interface is down,
> > unregister_netdev() does not reset the device, so reset it explicitly.
> > PTM is still disabled before bus mastering, as the related fix above
> > requires.
>=20
> Which fix requires PTM disable before bus mastering disable?  And why is =
that
> required?

c080fe262f9e. Its commit message says: "Avoid an i225/i226 hardware
issue that PTM requests can be made even though PCI bus mastering is
not enabled. These unexpected PTM requests can crash some systems."
The order is a workaround for that I225/I226 hardware issue, not a
PCIe spec requirement. The commit message does not say more about
why the order matters, but when I checked with the hardware team, I
found an internal erratum for that issue.

I found c080fe262f9e when I searched the igc history for this PTM
problem. Our issue is different: after the device has done a PTM
dialog, the next CTRL.RST can make it send a PTM Request, even when
PTM Enable is clear.

>=20
> > Skip the reset if the device cannot respond: error recovery is in
> > progress or has failed (pci_channel_offline()), the device is gone
> > (pci_device_is_present()), or igc_rd32() has already reported "PCIe
> > link lost" (IGC_REMOVED()). Otherwise the reset accesses a device in
> > error recovery, or polls all-ones register values for about two
> > seconds until igc_disable_pcie_master() times out.
> >
> > Call pci_disable_ptm() only if PTM is enabled. pci_enable_ptm() can
> > fail in probe, for example if the upstream port does not support PTM,
> > and probe continues without PTM. The PCI/PTM change above also made
> > pci_disable_ptm() use a reference count: it decrements
> > dev->ptm_enable_cnt without a check, and then does the same for the
> > upstream port. Before, it did nothing if PTM was not enabled. After a
> > failed pci_enable_ptm(), the count of the device becomes negative and
> > stays negative after the driver unbinds. pcie_ptm_enabled() returns
> > true for a negative count, so after the next probe
> > igc_is_crosststamp_supported() reports PTM support and igc_ptp_reset()
> > starts PTM cycles on a device that does not have PTM enabled. Commit
> > 650f197d8ea6 ("idpf: disable PTM on probe failure and on remove") adds
> > the same check to idpf.
>=20
> This sounds like a bug in the PCI core PTM support, i.e., maybe
> pci_disable_ptm() should be checking for PTM being enabled?
> Otherwise I'm afraid lots of drivers might trip over this.

Agree and thanks! I sent a PCI core fix:
https://lore.kernel.org/r/20261104121457.2108515-1-yifan2.li@intel.com

v2 will replace this paragraph with a short link to the core fix, and will =
drop
the pcie_ptm_enabled() check.

>=20
> > Fixes: e1092d5e15e6 ("PCI/PTM: Do not enable PTM automatically for
> > Root and Switch Upstream Ports")
> > Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Co-developed-by: Li Lili <lili.li@intel.com>
> > Signed-off-by: Li Lili <lili.li@intel.com>
> > Signed-off-by: Li Yifan <yifan2.li@intel.com>
> > Tested-by: Wang Jie <jie.wang@intel.com>
> > ---
> >  drivers/net/ethernet/intel/igc/igc_main.c | 19 ++++++++++++++++---
> >  1 file changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
> > b/drivers/net/ethernet/intel/igc/igc_main.c
> > index b8ac2f4fea5a..3ee8b05f0515 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > @@ -7406,9 +7406,6 @@ static void igc_remove(struct pci_dev *pdev)
> >
> >  	igc_ptp_stop(adapter);
> >
> > -	pci_disable_ptm(pdev);
> > -	pci_clear_master(pdev);
> > -
> >  	set_bit(__IGC_DOWN, &adapter->state);
> >
> >  	timer_delete_sync(&adapter->watchdog_timer);
> > @@ -7427,6 +7424,22 @@ static void igc_remove(struct pci_dev *pdev)
> >  	igc_release_hw_control(adapter);
> >  	unregister_netdev(netdev);
> >
> > +	/* After a PTM dialog, I225/I226 can send a PTM Request at the next
> > +	 * CTRL.RST, even with PTM and bus mastering disabled on the device.
> > +	 * Reset the device while PTM is still enabled on the upstream port,
> > +	 * so that the request gets a response. unregister_netdev() resets th=
e
> > +	 * device only if the interface was up. Skip the reset if the device
> > +	 * cannot respond (error recovery, surprise removal or an earlier
> > +	 * "PCIe link lost"). Then disable PTM before bus mastering.
> > +	 */
> > +	if (!pci_channel_offline(pdev) && pci_device_is_present(pdev) &&
> > +	    !IGC_REMOVED(adapter->hw.hw_addr))
>=20
> All these tests look racy.  .reset_hw() really should be able to detect a=
nd deal
> with any errors that happen if it tries to access a device that is no lon=
ger
> responding.
=20
Yes, the current checks are racy and too complicated. v2 removes
pci_device_is_present() and IGC_REMOVED() and keeps only
!pci_channel_offline(), the same check that igc_down() does before
igc_reset(). It only skips a reset that cannot work.

>=20
> > +		adapter->hw.mac.ops.reset_hw(&adapter->hw);
> > +
> > +	if (pcie_ptm_enabled(pdev))
> > +		pci_disable_ptm(pdev);
> > +	pci_clear_master(pdev);
>=20
> I don't think bus mastering has any connection to PTM, so why are we movi=
ng
> pci_clear_master()?
=20
You are right. v2 leaves pci_clear_master() where it is and moves only
pci_disable_ptm(). I will test this order on the I226 before I send v2.

>=20
> >  	igc_clear_interrupt_scheme(adapter);
> >  	pci_iounmap(pdev, adapter->io_addr);
> >  	pci_release_mem_regions(pdev);
> >
> > base-commit: c550c1c9727726dcae121221c252013153fa5945
> > --
> > 2.43.0
> >
