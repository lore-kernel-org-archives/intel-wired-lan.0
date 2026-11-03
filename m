Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310F4606C5C3
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 10:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=35X3Ni43;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m91N8/Dk
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0ABB0809C0;
	Tue,  3 Nov 2026 10:39:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D0REszOFpsON; Tue,  3 Nov 2026 10:39:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6061780A58
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793702356;
	b=VxXKc6PCNIsOMyARP9SeIR2wUeXHGGDiEvNw964mYKhoFgDUn8xsG1M0p838UN6hDytk
	 Z+cOE3VTPOj3o7VvF6DqYZ4gLPxaA8Wwv9MQc0XbCv7ARTxClxnyhN7m87W0KFKNvELuj
	 J2vLJICdR7w3pPzO6LGf7r4cYTYFs3DnEqEVI1uSyf3Lw/RNdZF6EiVRWmqOc18j0xQL3
	 MZtX6stfIpUWcDr4WEKGQClK21prxqRjVJFlWWpYrRIXXn6z+Nq9SLb3u8HXfGGOVQ9mN
	 ZIsMibJjn99QBdTW81ubP1G3dfg0DAX6wkbhhwlJLmLqQa3uueQplAl0km2s3U+IhPw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793702356;
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
	bh=kdT5Gj3CRXkzlhsNgL7aSB6zloTea5gSpTTLTs/4Lsw=;
	b=iBHhIso9AZPhGSi3R0f3sEu032QVMr5blsYByQ6qnzbCt0SjAdQJkC7dnfIzGLwalRrq
	 D02GfZyIpaFdh51xBCCae3OOmeg1MXyUGfLRZxHzjreLlK7iQ+xE1BYcB4FF5e8eIe55h
	 bDpS1W2Oq+YA7qZIr5i8MV33j4Ad+h70fmZKzkbVamT8PJvULKblhiHmM3ObG/1mSPC8i
	 v9dbMO+eIkO+kNW6yFrP3kUA9+xP0QQ82Tklz8JjNFHo9ZbPwAwJ5yFgzA7IhJcykbqIe
	 1p1EQoiSlzC0gCxt6OZXzCqPpq0NrkeAR9XFbu8ZkwbnR6BD9I3a4snWQ9u60AZBTUQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="m91N8/Dk";
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793702356;
	bh=kdT5Gj3CRXkzlhsNgL7aSB6zloTea5gSpTTLTs/4Lsw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=35X3Ni43RCYuqPHBZOlpf/1j/S5jy0WHV3WNFJHQjdrJEPjzSxLlKXWQd/9Ri/41e
	 vfiiT9MvG9gWAZNX0yJJBduWGfRrBOzuoNZ1TMFGWbJN0uVlrSG58CBkWtlh3yJGJV
	 wRhSXEAeEWQReN7YwYvAB6KKZF7k+0hOzV5IWKwqL2juLlfDgxjHbDDbU0ldr2oikK
	 o/I6pP0mGgn7orzozcW2Y/IoJB0b/dHaixahN0wcbLIupUHRbUZQ/dvj9vpzEfjwpM
	 EiXB2pEUv0iY8wiNiHt7qtGivoaH5hUqSL1SXVg75bucwImknEgWEKjzeEHxjDiGNW
	 iKtuOYHfLQFmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6061780A58;
	Tue,  3 Nov 2026 10:39:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BB2EDD3A
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:39:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A0ADF80C1E
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:39:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pe61Zgac1eEe for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 10:39:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 57498809C0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.11
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793702353;
 b=pgQyLKSDHQQLMIb+Zr3bal7lJb5eZY7SP9eij9NmIYYEZnFaaxJ361WoRPtV8/H/rkeH
 94N92/mY7oVGQZtWRwlFdirwcKO+nKZmIxR4jt+gtonS5xnaTUAw5cAKzBnP0jzKrHAqx
 H/FAp4O5UxZ4LSKYOZTKVshVskDn+liWZU0L3VTffZ3zyBIsFYTYxmh8WLo0X8PvJyVer
 MSeN4AZ/gYVkJil40bsRRNzvLpJqkmfLlkPmT2r2lAhxCmIxT6r/rovy9QqRcHHdfjj/e
 KGTyC4ts43siguHeWU6uTwi4tkADhxtQyf3VbAjjqf8AuKzL4xJpIZMRUDaLO5Xr08w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793702353;
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
 bh=kdT5Gj3CRXkzlhsNgL7aSB6zloTea5gSpTTLTs/4Lsw=;
 b=onN+XoAMeDPh3IDgVcLyRviBsudajYlFLsCqF7IWp+vnDyAVYg2s9UXYA5E6NomLuy57
 H3K88CDQLMRucwyDfQYzbxUwa2phkJTEM5b2M9KQqqBV6GoWbleEHLKcq2v6VI25vlh1H
 CWW+tSiMQwrQMCWKO9IUxRSOZi7pNEQLz4lF434OcGRtrfsrPoYBauDWqJn49N4uW3B7v
 liuqrf2yOe7m7OgnT+6Y47Hl6VFOANABjhCZv8n6gK8O5zoY2nNpIjOTHzYlPyD+ZEBXS
 Df2yTXJ8Ylr+UU0Gp+I3ZRQd/bSKYBA8hjtyVNKfikb38VLsAOnpenB6p72OVrE9FOw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="m91N8/Dk"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=m91N8/Dk
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 57498809C0
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793702353; x=1825238353;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jBYwWjjF1zo0fFdnUr7dGtGgwnOcypATqeQQpR8L/Ak=;
 b=m91N8/Dk4COxcXB7agk+jBcMQk7sMiiYLQ4N6mxAEVo6mnOjhfcf0FYa
 fjcIdlJLo4gQ5NRfzqR3UPZNAaSXl+pFzFy9wmlpjq6sISeUJlDOjr111
 imUuda3VF35b6u4VKZdc6/RqcRSDkBdp8KbsmUx8Q/5r2q/HQAOmmlVeE
 iTvVJksj3aDEEvhMBuTsMBrMC1KqtiYmsA7hshd2hUP9wTBA1TtQUqCqa
 vW4jsBB8QaCTCod2wuSGm9NrlNvBG5knAxewRipUx9BkiOUjK5HwRh8CD
 PdWdWjgtxf5F/JIaIQ4vlJQwv9FVop3IVz1pCHWzHkUVgtFrp8h6FFxPI Q==;
X-CSE-ConnectionGUID: jXj9HUveQ5KFAWw0cB8fNg==
X-CSE-MsgGUID: dzS5EzGpSPGB0aGx/FBxDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2328627"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2328627"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 02:39:12 -0800
X-CSE-ConnectionGUID: +jafoPdqR6ucbsueUc8m+w==
X-CSE-MsgGUID: VCqcjdvsT4K+orIrQn8EVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6251551"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 02:39:11 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 02:39:11 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 02:39:11 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.32) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 02:39:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GB5WF+YLxZ5/sm6z8eBgPbKs/Sv/toc6e44/qrF50fBs/dhWwkfqwdgHKeRuqlqyCKEA2rlszxrRQ2Odt+fGMShikxdQu2nf29QPpULHY4GexxmulhpuGPtkZQSwuz+TqS5rjoKiwvRGniwPWbaW0HujgLA6t3Y8gZtrhHtZVAP6E+AXvos8Dgu5tpj34822YxJjK/Vps5Y4CE24zNcKK3huWGGVuo7g+RgQxvuPdS1Ayr97ItZPBIeyrrJHUxp1TawDldIR5coTKep0S20jCp5PkZLXq+nipdiNHYij+LD9u6Hp35Ft13Js7Wcb9LFTavKhY95vdRKqWdkBRo4pXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdT5Gj3CRXkzlhsNgL7aSB6zloTea5gSpTTLTs/4Lsw=;
 b=Ky2DX7sfKC7DXvZsRIozKWrZd39i/SFVNpDJU47a6p4IhxiEyNO2Mwqge2SIKF+ubvn9zMthZpir00+SzqlCqkyDPDAHcXJs/FZT3qAswytLXQSj1vOrbpB3+t4iNwEgJfkRwmg0BUv0gNo4hqUg45Z5V4KAVPOD/DVJRTI2IQSD0NxxJ+5/iMs+Z3N3+VeOcUof2qaNvLr7aD6a+jpQYqWpQokb1sqvS2kQQzoNKA/j0538PhU4VPx50uRCOAmjrXIGX9Yokv//kWbSR8LARRowEoB10QdOqSbdyAzBsqual4Z5i4lQMNtwqlTtNeGNptQgFPDbbG6/qlRjU64Adg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 10:39:08 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 10:39:08 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Karlsson, Magnus" <magnus.karlsson@intel.com>, "Karlsson, Magnus"
 <magnus.karlsson@intel.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Fijalkowski, Maciej"
 <maciej.fijalkowski@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>
CC: Eric Dumazet <edumazet@kernel.org>
Subject: RE: [PATCH iwl-net 1/2] ice: fix USO for 32-bit systems
Thread-Topic: [PATCH iwl-net 1/2] ice: fix USO for 32-bit systems
Thread-Index: AQHdZ4zMstqaqUV6OEiJY7ikBs9B27ccL98g
Date: Tue, 3 Nov 2026 10:39:08 +0000
Message-ID: <CH3PR11MB5668955BE911AC62E0D42E82CFE5692@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261029100159.920118-1-magnus.karlsson@intel.com>
 <20261029100159.920118-2-magnus.karlsson@intel.com>
In-Reply-To: <20261029100159.920118-2-magnus.karlsson@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|DS0PR11MB7529:EE_
x-ms-office365-filtering-correlation-id: e60d604f-6c41-4265-b334-08df3996b0db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|921020|4143699003|11063799006|56012099006|261009223027099003|261022115727099003|261022075727099003|261021121427099003|261021123027099003|261102123227099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 3vqEHdO2vYc2/kpK1iqzjGZeEkkbYLMC7npHgnuj3ssW/R2HNjkzW00sjJNYfYEF9vP7l5GXNgNyshdUF7gZSz11Zhwv2pYOYQW/tuVG4mMXGcz6XWgmMXCyMPjX14wVr1LbKAed+zwhr7nKt+7hXdTVnwW8qAc4tREp7l9oBJPtxTkSIldbddMDyozMPyqEjBIaINJGFD76QeidlfW93y4HWFkt7+CPMvWrWthZIrFQ7qy3LbRDHuVpZ6jdzrDfNoWzz0cH/m217sZS2pbrdurmCU+dJI52M/iOOzoc8IM0NtxmOrm7ws6L/mqveAIbaBlEOKglY/AnqricAT4QDRcVoKks0GxYwDxorU+KFVZC15bb1Fl3a/lLE4ewslh4SiKQH8CcBsB2odghZMbcW9Xl5up/v/MesfquF56gj5zdnZi7XxfSpm+qaMhmJT+FcVpONlpMadgjLGOcTQhd1Hj8zYVndzNrElT4h+h2tvWVjzb3BY0H29xBUfDYFLwhn9VnNkIfagvIl0MFNRxiP4vlrTB7KD8ILaiu/JpBgx2/jPzPgWQixzdEkKwZP4A6VtlVrv5fT1x/TXBZ95P3zSgoreAwoDu1jam0JNry6wlB931JPSTczHDn2stLxNoa+ywPn0unAHurPdSH8f3FQ+8E5Ox9XbH22eSIF18Ssxnw7Z5K65hoee6kH3KjuZBj4K/4IM1BBZ84C9KWkIuV5/VJOr/4SztcJLZYwD0Wj81PflzD4HevI4sdS8m1GD77
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB566895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(921020)(4143699003)(11063799006)(56012099006)(261009223027099003)(261022115727099003)(261022075727099003)(261021121427099003)(261021123027099003)(261102123227099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?561oi+Ehr8292LWRm3LoXyRYEh1teHdUATWDCG8Gtmgg8FpeTylgMn+gu4dU?=
 =?us-ascii?Q?I2Uaqdrkq4GfXDol0O+Wc7qjyXdIcKlXnw7X1Lmg7sSiJ6u63jF42GG2d9Va?=
 =?us-ascii?Q?ogKJCL4aOxK2bWM1qoLkUsdRFa9vPQTZSVXo7h8X+nBhRWUUVIgAoWw9yR5e?=
 =?us-ascii?Q?kvKKZyYmq9wm9u14svQLYxVwwpM2o2N3/N22gx7NcNb+THaNELuF1WjLyEOx?=
 =?us-ascii?Q?r7u8wKjPZHHxYyH5v5hGOBbJBenu6rmpdWGiXLnxZ4F5endvSIjeJDmGrTOL?=
 =?us-ascii?Q?04d58ltfVeuqEzNQG8Q1bveBgQ/cBpN9ECv8oTyjjit+zHj2YWlhikbSdGpz?=
 =?us-ascii?Q?aB0/oBMsQTwfXD68ky2IwepDZy60MPSjf+9Uewr2xhtJnstcHivVWQRe9ViU?=
 =?us-ascii?Q?lAr+wFaOOuDavfY+jNhEiy3kp4Kz7oA67gaBQDTAlK4xbS3Ed0NqPL3V39M/?=
 =?us-ascii?Q?kWR5K69DLMeJ4ntdSHjJo8axOV2SHP11ICgr31nmA+jJgmovTGQ/qPEMppbn?=
 =?us-ascii?Q?J+JhQWmZZzSy6crsbTytE3kIfJlQWNUtmUjeOCE35YvG0QF/O5V6yK4H5zY5?=
 =?us-ascii?Q?6aw1eKZ56V6OgX8sBMjaVMfhhkuD0aJNWIUjWK8+yauPelfUhuvUjz5u3EkC?=
 =?us-ascii?Q?nIvpdec+CtRmJNq5nN+FcHB4ZDDWvQYeSc+OEwva5iIvm1KVaH0GuA0MGhie?=
 =?us-ascii?Q?AVHifgHRiXaFpSRbQJULeHmL9qdvmof+nntqmueCDA3dED89JXJ3Ida8gVnK?=
 =?us-ascii?Q?7pt+/d34WwqlDwzEd3LVwsz7FJKqO1TsBG0OaUAyhHPUzGuAC4PuRyBRd9dQ?=
 =?us-ascii?Q?7+rHWuXyB5QEf3oCLYdrbAptQeEkQad2iE22pKLkJdCKYA1HvJnHEAHeLJeH?=
 =?us-ascii?Q?rJ2luFLODCldTYQuo1XUg+4BJ4udrG+kwbfYi6UTRmtnSTiwR9Uppq7DSig0?=
 =?us-ascii?Q?kIberu9ToZFo4JqWFQwSaoF5xCkyQw+azVhtPP9CCj45JTBSH0ZCuXImp7MG?=
 =?us-ascii?Q?2TXEf4CW5l/jRBGXQ8QVH4zac8YRJlMAz7ppXc+/V1iUjGCpAc8IRBj87LuH?=
 =?us-ascii?Q?+VNngPWeGVnYMy2xqUxG6pedsRjdgm4bQlGmXEZmZfSZrrfU6BoiWxblZ9Cj?=
 =?us-ascii?Q?EhQThjRQp+EDWA/Czaiwc/KWnSgKc4OM6PmRqXUr3m2SDfuLQxJK0G3Y8DcS?=
 =?us-ascii?Q?vVW9Yhrf8qROMo8BUUHBlGm0bdM9nbkOJvN5xPLTWRMf92zkpCgor4Hboada?=
 =?us-ascii?Q?wg2tfRXUYSUR/Q+CY6u0cBH/k5mzYZFcUdqYv0w0BgdLThJB8sapqg+DFAOu?=
 =?us-ascii?Q?9yR/Hk6OR1tepUw7kHYKeaqz/iP2HFVNNB0DnJOuubTVLEn5vXw+wmmhrWi3?=
 =?us-ascii?Q?41jpqBQyMW6vJ/Au9w8HpMQ00EMZGLkyV5AryYO5UhwNf4neOO7OYCBL1RHv?=
 =?us-ascii?Q?ukfDddD4ToI8ev6kSnew7Pn7PACWb0kJwZq9PEduoNJ3uTthJVxxdbOAH4R5?=
 =?us-ascii?Q?MMXcv4z2L5ZOkgWLpZRkUf8iYvWpK9Le373LFXwjGJGY2NTn+4wXn6Q0PKIa?=
 =?us-ascii?Q?vprXilRgt2PzXMfsuE4W+p7DWew79TFfdvKryCxehwP39IqPc5SqnWB1aMgo?=
 =?us-ascii?Q?gXp22W7APdPXMp0+XY0GRQCNEyN3Mj8ETBiHeuMDSxxYpoJh2+VMw+NH8ILG?=
 =?us-ascii?Q?bbZehIFV0D46alRt3SzwWZkcFrrJMisoILbbTxRnEskQLKTH0OvIbev7Z5hT?=
 =?us-ascii?Q?N3ZAGeccgRXOFh1VIDz//dggiQIOkqE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kFuLJd4tvGntsOAXJ6AcNk+7HU7HKPf0u2Bc/d6SLrv/NQ/XaIMvwcm7Eq+hyLnahsJqcY48PeWu25VHwZZu9q8CrW3h12yLoHpL8Pdfk+izAtnBNnGjTWHJBz7+d9KX7cDRhBhlNtDK03mzFTAaqtgHwkL6U/vf+UBOWAcZ9lbYZdKUt3zg1mBIVFk60EDWTgy4viCSttrGiXLEVlCRjODJ+dAupEv0HxRZ7jjI0IXYczsLtgylxV27Rz7l1DX3dAEpVmUkuAUimknwCiYKhasGbm77waUqTL2gFWLaPx2fuazWoOAIPigeny5PfQZjBgWipJpXL1nCrDmeVq1FAg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e60d604f-6c41-4265-b334-08df3996b0db
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 10:39:08.4499 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e+pcx9LcNlCZUr+PrHVvGNQnvDJrGexBwbzw5GWIhrOjCVywuIVRK9SMt2AXELLSSNBc64mT2UiAoT/ij7LtzYnT+n9P/2/6ZE+xPFzwvQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7529
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> -----Original Message-----
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> Sent: Thursday, October 29, 2026 11:02 AM
> To: Karlsson, Magnus <magnus.karlsson@intel.com>; intel-wired-
> lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> Fijalkowski, Maciej <maciej.fijalkowski@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Cc: Eric Dumazet <edumazet@kernel.org>
> Subject: [PATCH iwl-net 1/2] ice: fix USO for 32-bit systems
>=20
> That USO works for 64-bit systems is just pure luck. Currently, the
> computation of the UDP segmentation header is performed using sizeof() a
> pointer instead of the sizeof() the UDP header that the pointer points
> to. Since the UDP header happens to be 8 bytes long and a pointer is 8
> bytes long on a 64-bit system, this works on all those systems. But no
> such luck for anyone using a 32-bit system as 8 bytes !=3D 4 bytes. So fi=
x
> this by using sizeof() the UDP header that the pointer points to
> instead.
>=20
> This was found by an LLM while implementing something else that used
> USO.
>=20
> Fixes: a54e3b8cffd6 ("ice: Support UDP segmentation offload")
> Reviewed-by: Eric Dumazet <edumazet@kernel.org>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c
> b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index a2c7c4962882..d9ea812c5c4e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -1925,7 +1925,7 @@ int ice_tso(struct ice_tx_buf *first, struct
> ice_tx_offload_params *off)
>  		csum_replace_by_diff(&l4.udp->check,
>  				     (__force __wsum)htonl(paylen));
>  		/* compute length of UDP segmentation header */
> -		off->header_len =3D (u8)sizeof(l4.udp) + l4_start;
> +		off->header_len =3D sizeof(*l4.udp) + l4_start;
>  	} else {
>  		csum_replace_by_diff(&l4.tcp->check,
>  				     (__force __wsum)htonl(paylen));
> --
> 2.38.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
