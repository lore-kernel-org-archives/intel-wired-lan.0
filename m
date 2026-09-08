Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A130C79F99
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 13:13:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6587140582;
	Tue,  8 Sep 2026 13:13:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id APdv_cCLGeMn; Tue,  8 Sep 2026 13:13:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B740C40595
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788873215;
	b=h0HR37Soid94acUsZSOufkueL7ooKNdQ9AT4JJlidhYKZf+ZZMhngSQQVtqa2L+JcPwG
	 waaaag3gfZCHxzJsyrRawJ1ONfLE9o11l5ECcMxrMAb+N++9EmqgzIqk9SmsQ6NDXVIsk
	 iAvXaZaerJIs1Wbe2mq3oEL+PP1MmIG0bqNfuta1ZNo8o+6ruANZ18Ry4pHwtpgy1XDxJ
	 fi3Fjn6MElR0ifHYk0SZqbwgqKBKkoVMFKRMz1X4aRBu2lc0Dq9gGu6H2LcczpQ8i//88
	 6lE9ER26eIsLf/I82/YbVe9TeSDnLK4Qbpp5easZO4IF5gbvuNxZYwd6oh02uAMHWIQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788873215;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 From:To:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-ms-publictraffictype:
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
	bh=8hZEq+BQKLH50KT0lC81r1+G2VNWEIc8j9bf6fj/w0w=;
	b=DdIFsGTZ00nE1GMG6RCLsb/fnQ7GxbPMnpbiPVbts/lpPQ3Yo8KLB8qRk8nefqFFz2wp
	 MwIalWfZscZgobX3rA+Vbd8Vy29W2spXCbVbqP9MXDR4xAqkH5jL169MAUgoz49Pj/QiV
	 apG5De1wTmeqi0WwMEqnG4oJb76QTrfiPuGjxfRi77jMY/93OsmSfmcLHw6eQ1pBFrfsu
	 ZtElP+svNGzLqqnu9my6P+XZMP9HptU4Xacp8u80oKGKCuY8p28OOqzN+B5rzS9jxRNON
	 dlVvM+HnWweeL+ldM15aAExluRf9FgrE7bK1HeMa1FgbCnhjh7xxRXnka2AqLBI3HJg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788873215;
	bh=8hZEq+BQKLH50KT0lC81r1+G2VNWEIc8j9bf6fj/w0w=;
	h=From:To:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LTB3z9S7Up3Tk5yd4GNteYwLXdkDPHjeWLmK/6Wm9/b26j04lfbfOxIUL/ZcMfRJU
	 OTE49v/inLv3Xr9/XowljkdcaAvJ7aqa6NO2Kt2jJJQG9h+YkfLBauTlUGHx8DiW23
	 nfKF7GPyZQ8V+9NMnkqiu7mEl0Jy+WM3LrbWejABRJiOMOcPDF+++bM//0NvN0gOz4
	 8nvzMsLXQNjGqY30OI/Q6v9ODZhEHt4l38kS5PvRhgCSfVCSbG6cUGMPlDrADzxC0B
	 +rlCEyOEBsMl3NL7T08IkIBvpYj02lvCgmH7sZ/JxYjnZNV3YSatg7hgBLUxvESZ+B
	 nkY0h8mizJpjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B740C40595;
	Tue,  8 Sep 2026 13:13:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E43E4372
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 13:13:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C9DF5809F6
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 13:13:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aKhdwfvg014y for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 13:13:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E65FF8098C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788873214;
 b=cllQNG3VC1rGAG84Qy6B+2yUFZfBXFZDATL48uc7ZRcqPYH86nKroP3bZgyGY8Qka/Ui
 6C3wM2HY/5s7V5Fs6Bnk5xBGRUYlHRAwQ+6NCrf8eWKnwT8BQgX1p0C3qKtQHKvAJvLHP
 ZuGF2XvyNCy3Kw79OHzRORXMo1T3JipPCMku7NcuplvnK09kIPVoqcSkY4j4udvK2NGKU
 J8PWNNsLD4p7wBGN9gSyidx2QaCjcLkArDcOaJV3QSDMnMyhx9zTr04Nr/q90XYTC2RRv
 Vhq+ua3gC1MJyeAKozPE8Sej8UvKoO7LL6J97rgkWzr+ovsJ9SKa8Nve0suzI5S5a2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788873214;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:From:To:Subject:Thread-Topic:Thread-Index:
 Date:Message-ID:References:In-Reply-To:Accept-Language:
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
 bh=8hZEq+BQKLH50KT0lC81r1+G2VNWEIc8j9bf6fj/w0w=;
 b=KNsLIpMIwjIqCfeCESnyUPP+9t3bVFqp7MUtJKtQCaguiPjk9BkFUTyITAdqVCC7695j
 Ry3WYHvaGwVYi1Xml4e2vU3PznxrO9+8PQnBMJPlbpcCZnvx26J4kC3vK5m281UZPe2MU
 lcUcN0WAvux6SWCqwPHpyloWptojxOmfv9EFiWrzNLNOFw4rMSNr6A/BaD+KKDGKR1KjA
 T/ctH17V7PTl2fK8bFh3dtGCqEWa9kaEjf+AD1cEFfNqqZGAf6WFGmJC9h2cj0TFrhCMr
 aTgG6aVrNYryRggVlJK302C6un6D2qq9UrHwgXN/Q0LJ3AL0vvsjF927wHblGcsWCUA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=PFEXEx1i; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=PFEXEx1i
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E65FF8098C
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 13:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788873214; x=1820409214;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=YTLHq7YrJo5cR2VkCBpdcC5xpbQ4fASI3VXq6SUBFZ8=;
 b=PFEXEx1il2COixHqNdUkNh5zAmkIPr4EBJpd9Ofv/n9ja5WhPcJRbO8a
 IMZ9rzHLpH2RPV6gcAx2GZfbwqcEj0EKAgrRItXm6wm6HStuQIuW08myf
 thZYfBlkCOclG7JEiG5J9i1qavTZkOWImS+Y9ac4s3ZeKc41VprFEWNwp
 YjsESq0IKBPDIILtNRTBt8DCfnF5yddXizqwPN4SBTdA7+5kJ+v/1YLJf
 ltXeUEZ3KihHgD4FQMoumWz038dCBXsWis1Vbg9Cdvl0NcPKuoypnYIt+
 w4R3TYo/+/ZhDHfp6uJe+NGT48Sp/4JSsVx0enhnWOJ+fCAA0LaFDmVRB A==;
X-CSE-ConnectionGUID: xK5ib3PWR82PYglaPmhN/Q==
X-CSE-MsgGUID: wKVanUSBSRGn4+0rA4wkeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="91785587"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="91785587"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 06:13:33 -0700
X-CSE-ConnectionGUID: OMXibpCLQXuAu+NwBsQa9A==
X-CSE-MsgGUID: ATvLTIZYSb+EtQ0n4UIezw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="294498830"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 06:13:33 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:13:32 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 06:13:32 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.39) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:13:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YSyGeUVg0WmO5OOw1KsFjm9ZoYOj9xEOzRsqJVa7CioxZcyNOSXWMGlN4yfAt6y1+gETGOK4AtkeOqw2mWgf/t70BI6qzPgf5JbiMKdgWILZuoiifBlhT2hd8zWySkgNkDO20GGOkV3RaSaehv8ohsAg67uEGDhD2Gj9mikHLdscMNBqd3Mq147XUbiqyPDzvl8dOdarf+fBRaZOlMuo9nGaQxdjM/lQVZGd1nJl7YlX0JkJ85czR1+R6CJoHJc/ui8h7GiSsQy7HomWXnoAvXd6fVqBBVccogUxLMHhuBohwDx4pahoLqUF8iI5E7sai75+31AcUni5l4ZcVRc8kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hZEq+BQKLH50KT0lC81r1+G2VNWEIc8j9bf6fj/w0w=;
 b=OYLu/T6AejOUG7qlveJvPQ9zjYH4QGqdx4DTBJ+Ewnfx+WvD2L67sP4QLj0RrRqLrHcIfo31WvRmDNKz7hHiwhh5PGJO9u+JHaObOqy39QHAkdhNFVwQpNfp9dWPauVTAJIktd/k9ku2me6fuTJ3zJ9ESVT21Om8AdXGtLqHXJW+91USaskjbuhX8ZyCz9FQzLwHlFMLJ4H+M+nrgcDS07n4dWKflpRb2NBdKe6u9il5bo/7wM04rCkZRYvb5bEQlWjY9DxN2/199H56AHAl4mi9mjxa+OdfHFCrKjb3iwezHwNNDy+42mJJxaWA1AOsspylOG/gW813zbj1TtvZmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY8PR11MB7748.namprd11.prod.outlook.com (2603:10b6:930:87::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 13:13:25 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 13:13:25 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Yury Norov <ynorov@nvidia.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] ice: drop pf == NULL check in
 ice_pf_state_is_nominal()
Thread-Topic: [PATCH 2/2] ice: drop pf == NULL check in
 ice_pf_state_is_nominal()
Thread-Index: AQHdO6cdIKKIa/TNbkathCm0zhQM+7bEsE7w
Date: Tue, 8 Sep 2026 13:13:25 +0000
Message-ID: <IA3PR11MB89868D0C0C656B1D2A771A70E5B12@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260903132037.81346-1-ynorov@nvidia.com>
 <20260903132037.81346-3-ynorov@nvidia.com>
In-Reply-To: <20260903132037.81346-3-ynorov@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY8PR11MB7748:EE_
x-ms-office365-filtering-correlation-id: fdadafb6-2589-4d83-0f0e-08df0daaf72c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|921020|18002099003|22082099003|38070700021|4143699003|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info: olTEpKD7C5BOJy5d21ZKxvUUkje/bOusk+Xt/7WLyYp9PgAldaikGMEfLj824yatmcKv6AZHCxTJ4DoS3rgLyb3LoShX4hAqscDCgrKLR8w2m8yEx7ZJpE2Z19C+sCKb9nK0O5ZwvmdMMHNsUA/tpXt4RX2L2ESU3bnEmWjnfJvTS/gYS+xz8gROlMs3qLq7xtUcY13H30PhldstSBacTIvOGFOoVOzKFx2eTWDIRwbXUiSEBVyc6dC+ZeW2oHqiBtq/eKz5Nta8sqWQM4AYaX/Yvk+xkQXuyEXcj4XQaShIZxs1u6RRYeFVMHxcgMQPlqyRzqMFA4q2hu+VDTMMrMgkNzgQqO9RGWlEGLGNdYmCuWE+3lTrFmGhlxJARRBgNAT0o/8JqFuI55SUXXi7uAx/LfifbpSmqaAS9etCAoCOC8yM3lpCo15Y92VkbiCxolpOwHexXNTU/vDpE1lZiyuVK8JQ+wf1QTTaIRt+ztUiljqFxX0U5KhHMMJcIc8u5IlRMXmIL+l/VPZK4ir8UASs84nTqMy/VuRqv2p0KzkP+vE+h2Nh/HOmL6rdVo/yvIZirDaNBCMm+dSMCzyc3THllUQ+xgtoEwS2pxC5LlOlSXojKeJHJQJ1jOEHlBbIAVfP48GETzoAQyrYAqd9spp/VchbIM1tuJ61H18NVHQtmIvYZ2Ew5UlFHiq2A/LwY4XWBOJyvlMsS7jyktM3h27tpVNw0tuzJW0etO4qOJ4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(921020)(18002099003)(22082099003)(38070700021)(4143699003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nmxzkoB7T7wYY3Zt8AAWMac0lDFWTV5Rg86sQ4/KKrUDEGB246IQuV1JlszY?=
 =?us-ascii?Q?P0Ggo6+dNODK7zDyP61Gx9Jv8QNDpOA2Q3HuzA9t15cLeTjj7QL/g9STiInD?=
 =?us-ascii?Q?iEAYaGJwtRocSJMPZ+IaaBUKeCg8cHMVHGW0HEruBGhVGg6/iHFpXc36Mp8F?=
 =?us-ascii?Q?w16lsQ8r6FsRkj3lY9XNfMhwfGwDGIvMHJ0XLjPaoIx/2CjnDBgr1+KSZEQA?=
 =?us-ascii?Q?006mXcCibZNRrfnhWdafkDBhQqu4ragKp0YJH89T3aNAjs3edIlZrFRlb/wr?=
 =?us-ascii?Q?aH4C2ZT/subCP23dT/XYS38Aixj1a1SKfHeYo58X/SlkLmwLLK4hTiXyixHC?=
 =?us-ascii?Q?E5j69Ay3XZRPN7t4oD9ZzC+6eQWTm3ZTWsFoL7avs2x897XJINEahVASDrqe?=
 =?us-ascii?Q?N+SKVhGgIMv8gYzZ3EJHE1IpbMKfheXqPv40W8vgvYljkjtLz8TyEdmROf8Z?=
 =?us-ascii?Q?ChDwd+ZJCsS0JHvFsha3Jr2l+ASb+mu97ivSgJb3AnrR+w1sdgD0Vwy6CRNR?=
 =?us-ascii?Q?DaxrY1x2jsJWKDRiofI4GDjT5K3dIlyBVm3I5UnKcS+ZcXL1yOMo9TWfaTQy?=
 =?us-ascii?Q?b//Mu81WbcF/z4yBqg9NO/zVHGjdBLr14hAyXsLBpBGQozqmHAAzoICscAin?=
 =?us-ascii?Q?agchvBFIoAS1+Z6Zfx/+VNszzXb+hNRsv9qRmS81ACoMertn3+bOZI8mFJdJ?=
 =?us-ascii?Q?wdMKjlS4x1dHcrzkGASfVnYmeg5i81i2OBqShVUm+zkIStKlC480CaswNjsj?=
 =?us-ascii?Q?G6koEjeMd7dBm/OHA3BEB4mMLHmIV0zvtUhdWkv4zVCJ/VPJK12gBWu5I4aI?=
 =?us-ascii?Q?x941yc4KZSBwDzWu4T9hvANhca1A6v2SCrLaoVo1ONYFfgnnTI10RyxQtaDV?=
 =?us-ascii?Q?4ODUn2zLZ1kI1LEFP9OnIwLCbpnUKCHHFFSdGE3Jhn/Q498PvB/Ufbj3GoDn?=
 =?us-ascii?Q?Hl6ZaBzwMootQBr/n5zN7A5QYM664sz3KWwhzFaOF86IFcCE4gbBOIl9oGc2?=
 =?us-ascii?Q?wpg4Wj+q5rP43Dtx+UupENLUoEu0H8EFGwHm7spAyaVEiSlgLzxMwrXfFP2I?=
 =?us-ascii?Q?xZm5cl2qQ3HEGF6icw8WrW9LtZXHhZ69DVHfIN1Tks7ueZwKDP2+j8/Z7mtV?=
 =?us-ascii?Q?E2JeM3xgvlRutkLa/coc4BmNB84546WwfegJyxCWdOZk78KDaZOHCtzjK6N2?=
 =?us-ascii?Q?u5J/ttbtkTEcoqQu/saMnt3kFgqu2GdYp0aEDpDP5F554wpkBJ1TB6Ak22Fq?=
 =?us-ascii?Q?hPSOwtEmyryuWm1EszniuFnM8x84fJvTiBPhPAr4/ybHmnyZVaJWjXcjwsga?=
 =?us-ascii?Q?0ACSiCM9NKtIKHorRWoxvS4GvKezmtOqa4SeYRDuP0/qgTGeQA9Gp+qWpJ5L?=
 =?us-ascii?Q?3aciGtu9LrStCWpP5b309nNoVDgc2NX5XL1nLIivW/RlbziS8h5CUOVGfIH+?=
 =?us-ascii?Q?cpP1QN6yFLiVd5NwTA9x8l0AIhcaB0QaoWOrG25gornL4gmWWdKPaXax55qF?=
 =?us-ascii?Q?SIUyl3ncmr86HD2zWOkpggdQyCF7jmSyV3N25Ks2bvdJEPrRsYNHJANlzRfK?=
 =?us-ascii?Q?JxQ/2nvW0RkQsv/Bk2ZeCEwN4DR8wXUlmb4pdEoNZQa/kix32NKt2udNvrfP?=
 =?us-ascii?Q?Xn2UQMeJ/lLwDOoMeL+xW51qu/eOMxN2jFueFipZxja51pbs1rprFXzvi+v+?=
 =?us-ascii?Q?YsfSTMorM8AXo8V+pxTrb5SxbvDaeJvnVJfhX1Kw3yKtla+ynoHI03l2o7jl?=
 =?us-ascii?Q?z0qYVK8CcMaMVFmNw0Me59kWlYBh74I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KCvJ+aG9aZQHgsXSbCpoQ7yqY5LKAwdEEmeOgOIXE07W1JmRo9/8FVmPAe10wI36Ph377PTmWQXTjttHnk+V37xd7Cc+FK3O2PdTzsA5Bz2JcRj6DBbzmNGwEaIVzhQoov2wZTqNAL/TQxhGtPhvqcq52f0LWsyIQctgzniKoHijSnPtfjAqUAaRENYn4audY4SpYJDticG/Aqs0GuCWCuclXX5MN6PxyffJxYmWfGp1HKVlYiEp3VIkhALzThMeM8SNlAw6aS6GYVb5/OhulFeOpZZoUeprqiRPbb1vkxSHfR74GbQQpRZI8J4xkSStWNWB/K2fwxPMK13BdDaiPw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdadafb6-2589-4d83-0f0e-08df0daaf72c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 13:13:25.1967 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E9R2cDNrvC0ykHOOSrPfTtyr6nBXzY9jWkNdhAlTY7rU9V3/LAYHcqHgGHiHIw8y73Re6CqzDtoJKlTxlHs6wHGBa4SLkTeUeQjGpFwRlpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7748
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
> From: Yury Norov <ynorov@nvidia.com>
> Sent: Thursday, September 3, 2026 3:21 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; open list <linux-kernel@vger.kernel.org>
> Cc: Yury Norov <ynorov@nvidia.com>
> Subject: [PATCH 2/2] ice: drop pf =3D=3D NULL check in
> ice_pf_state_is_nominal()
>=20
> The function has 3 callers, all except one explicitly require pf !=3D
> NULL. Add the corresponding check to the remaining caller, and remove
> it from the ice_pf_state_is_nominal(). It makse the fun function a
> one-liner.
>=20
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 3 ---
> drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
>  2 files changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c
> b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 73996e3022ef..6d5b8acc4764 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -1705,9 +1705,6 @@ static void ice_vsi_set_rss_flow_fld(struct
> ice_vsi *vsi)
>   */
>  bool ice_pf_state_is_nominal(struct ice_pf *pf)  {
> -	if (!pf)
> -		return false;
> -
>  	return bitmap_empty(pf->state, ICE_STATE_NOMINAL_CHECK_BITS);
> }
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index d88835482d3a..168d85f9477f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5521,7 +5521,7 @@ static int ice_suspend(struct device *dev)
>=20
>  	pf =3D pci_get_drvdata(pdev);
>=20
> -	if (!ice_pf_state_is_nominal(pf)) {
> +	if (!pf || !ice_pf_state_is_nominal(pf)) {
>  		dev_err(dev, "Device is not ready, no need to suspend
> it\n");
>  		return -EBUSY;
>  	}
> --
> 2.53.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

