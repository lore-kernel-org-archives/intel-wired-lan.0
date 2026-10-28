Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82832606A31E
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Oct 2026 18:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=zjbZq7Fw;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hyj+ywV5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F2EA8466F;
	Wed, 28 Oct 2026 18:34:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0uC9vg3pmkL1; Wed, 28 Oct 2026 18:34:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1D76A8496B
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793212443;
	b=WdIEz41wuHDM1Ng2zC/Ma50MvwHpFzNsDJ7C5Nwta6iRaxVaM5fUPSFVlzYctg2baAki
	 QA2GXt2b5oBwlNiJg+hVdtiL0ngob8VkgfYpQs1Tl0thNwT4UHqrCiFxyx98uKIt7zFQG
	 Wr8nBBjD0u5PfMypALOyrkN7P4VJ1Y+K5e6WqdsvKDZmvZ8E01Xgx0RtlX4zKpgTyzZTk
	 rxnMShqM3xygyt5DCgkhFECrM33qLeCyC6KABVv3GmQCf1075ennRAaIyicDURQ5fiFKH
	 ZQeqvtdmhGcvPdrD5c1A8+zsr13vS5di2UfOj+UqcFSgNipwvaXXBkdDPqbJuz5s+LA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793212443;
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
	bh=9Qusk7H77YyOp9N1B/tRU8NvLeawvNYeSMk+DM5N+jM=;
	b=OljRXnN3k8SQNH77ZIhw17LwVPfPORiir0gOqF3AAJdseGU5mqu8jZCoSB54uEntXH8c
	 FYA8WB9buN6gE3Pd5T4q1VqtLS/ILe1e8jlZV9AX6oaiIrE2BYn5NHYFQWlS8hz7iYa36
	 qH8ngMBBa6V6FG8tDqFVLBSQyKDikpxQiZ47poDBMkwhSwazg3KIuI/gryvsoQUS0V0mw
	 s5WqMF1ykaH06EoCQ4PA5PvQue8ZpL6nhbf9lsz8OE5GuCws4vrsd+PjM+HKeYdQRh5K4
	 DuiZFZd2KQZ/X14J2JXscihOIIAl5ML8v7DWvhfOlay5yeb+2Pq4uM/ivsOtSCFd58g==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793212443;
	bh=9Qusk7H77YyOp9N1B/tRU8NvLeawvNYeSMk+DM5N+jM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zjbZq7FwE2m6I7Ay6vY8HT5Q0Adu8PKKfXZy+62eSz744i/5yiafna7lN77YA48nH
	 DE4funmtKsS1hw4LAwl5ZiLmFC6pQ36r0njwk2P6L5WsXtWPXqVRFt5oJ4TtihTFVf
	 rXEiplth9ioMMAuis+GsG3pB6ERE6gZJxyoqwjdLOqP7KLGjFFhIWl5cB/sEifZpfg
	 BbGa2gKP9HugpRiLsta73ld5UhX/qQxGI/xQfJxE7Li3Y9k7XU7MTIn8stKiDuRp7V
	 fz9HzFvyHJofK1qHqE4FM2AQj74le/fbfTCS4HdjCIlXlZaNNvWShsMIpUoNHW9y0J
	 vtQtvih5pzPBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D76A8496B;
	Wed, 28 Oct 2026 18:34:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E1A2F356
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 18:34:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CEBCE6F98B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 18:34:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2E83LJkVj9YQ for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 Oct 2026 18:34:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F2C896F9DD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.17
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793212436;
 b=ei8UkC+i+V3RSS99x2J+CnNoqKORZ1UHQkkP7TuN+BvRXYenDQ3vLd4DnNMLsOexCSdY
 fecB9vykJu/MQG7/jfG1jC1eV9wrLObng59ZosaBxVX5Gx2LWRpJTo78pDzTGxlSuX8Ba
 Hy5powkvrOYZJYGxw25yXo96J6Y1MIjzvB9lSfdQb1MJBKOLVVETiGvGp628yq1N1EcF7
 nu+qFcqGPu877nL/PVez2uivKmNAunumtw8zkjDonQgeAcR9ZcwvxED6pdLqUIACzaGvd
 NjkyXye7DUzbYgCow5LE5tpEcmmpzKNs8chupBxjVwhJIcHNpfHJ53FyGzxAa/LvbUA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793212436;
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
 bh=9Qusk7H77YyOp9N1B/tRU8NvLeawvNYeSMk+DM5N+jM=;
 b=cyGw6w59ShMiYg+EzSWHyGUeYsuwBbe99aKqOvkYAWccbX8u4F45RVjQz4l1SqCHkD3T
 fFa5XiZt3n56YkZgp/kj++/gPq+AcPaNrJavsSA3bzys70+saVFcTuIcgzLJM6nps7jhw
 uwYoS5OYFX9uudN1usU5AKjAY4VxUbXKxyW3TPWkP2gYlqn0sXOT03Cq2jBUI6SenztBV
 B5PjRXojhUWNKEtPor4jhwdlZBA4VNO5TZzx8KKI//XVwRGXlmgUbqp3+r7pF7M96AkqN
 zUFUe60yzlMRJyi0NZrT/o2Ef8j7aNelsWGKiXAk5keo8jxf0wXdmbXetWKfnH0QIxw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=hyj+ywV5; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=hyj+ywV5
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F2C896F9DD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 18:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793212436; x=1824748436;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9Qusk7H77YyOp9N1B/tRU8NvLeawvNYeSMk+DM5N+jM=;
 b=hyj+ywV5VlttwRw0VS6Es+L+iBZf8uHuWPpkvTDPuJEy9yiFUvByi6TU
 vPTWaSFf5WbwjkqlBXj8sBVFPMMrc2t5gwfN7w+n50u+1bmf96ArgCCil
 Xz50AjZEesJGcUUvWmfLEVx7K+pxe9GEMVlH0/lRlyJfyGgokT/NlhX96
 VgGyqmeorhGdusUHd4fbGE86Xa9Ix/Gw6Vi/LBFHLmnUMY0QoY1atT2EI
 1duDGaFe5zhJYIwJSluhVeCyoyysbB0eLvgq7c8p0HWqQ5Z7eZrWf9gGK
 oLEyWI1jlq8hLVuE80jqiadwjJDr9Zaexj6Q/rZepQ9655vv7ru5bVPvx A==;
X-CSE-ConnectionGUID: 7nUR1VR0QdC4KMKFAqwAhw==
X-CSE-MsgGUID: tl75haoHTl2rg+eWM4S9XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1959572"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1959572"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 11:33:43 -0700
X-CSE-ConnectionGUID: w1haTX2VQQCRvVYWW0TKXQ==
X-CSE-MsgGUID: pDWQm7UcTkK8z8ICPH7qwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="5306705"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 11:33:42 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 11:33:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 11:33:40 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.9) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 11:33:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+f9vd7B5dXzrhCtWYcEsRB6DpdzsbrvkGDgSJJiFwv/flk5F576W4NMDgwfQ+eczxuYzdgyqJFhYc3wkzy9n+SG2bL+TC9Pt5cJz6SfDS8qOM1y58diE6GS1nkAfAHCuEnJcpQpwC6ePhZFkCGrzkS0cFXEzxmrUNxygu3A4waO0jrtCVOpdXk4abQUWV9gEKy8iQyIyN3ylft1xoUo+Y+M+b+guzmubGiz/Q2Ng8sBFOrB7UFYt0YqqWhCBQcc58SyNILu4nIgy4yaUBFBFWhIKfVotY/kKAkYB6ud9o7NSQNLCrYMb1rXkRRi7ZMa+iHBKIAGUZQi43fmI+I+Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Qusk7H77YyOp9N1B/tRU8NvLeawvNYeSMk+DM5N+jM=;
 b=NfJNEcBNb2O3d+BeRmj7uFYZvJK0EppVR6IiY3ZEc9tfl2fmtN/bkLZeGEcgxafnHB6RQi51VgHsCksKbhtqD7vJyolFAMEp0bpspAikB7chPC2LMIBwi/1nRsxlG/V8BkQnBSzRyrCIlOMTx7/9XiFL1Du187U3oHeb/4SshG+99A6GtwTOjxArg7rqrMOLYYqDh117f/PYtTN7SF0dM2/WXGo+XjspSHeFXX9WhoUyJx7mC24PJ+uyTOubVDYkWstrKY4RjBn7cqp9W6WfsmIw6d881LJUDqi8SnjKNZgvS3ZFH3g1gWKO5uJAC+hU+xL1MExPNhn2u0TvypbM8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by IA1PR11MB7679.namprd11.prod.outlook.com
 (2603:10b6:208:3f1::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 18:31:36 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 18:31:36 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Paul Moses <p@1g4.org>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@kernel.org" <edumazet@kernel.org>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "ast@kernel.org"
 <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "hawk@kernel.org" <hawk@kernel.org>, "john.fastabend@gmail.com"
 <john.fastabend@gmail.com>, "sdf@fomichev.me" <sdf@fomichev.me>,
 "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
 "andre.guedes@intel.com" <andre.guedes@intel.com>, "jithu.joseph@intel.com"
 <jithu.joseph@intel.com>, "vedang.patel@intel.com" <vedang.patel@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: RE: [PATCH net v2] igc: return XSK frame copies on XDP_TX failure
Thread-Topic: [PATCH net v2] igc: return XSK frame copies on XDP_TX failure
Thread-Index: AQHdZrlvTxIT7ao7FUiGA7cGfkliqLcTR5Yg
Date: Wed, 28 Oct 2026 18:31:36 +0000
Message-ID: <CH3PR11MB566895B48741E76FDC7D8BF14DE56F2@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261028084919.3059158-1-p@1g4.org>
In-Reply-To: <20261028084919.3059158-1-p@1g4.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|IA1PR11MB7679:EE_
x-ms-office365-filtering-correlation-id: 894656b2-823a-4ac4-d109-08df3521b322
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|23010399003|1800799024|261021121427099003|261009223027099003|261022075727099003|261022105027099003|10067099003|56012099006|6133799003|18002099003|22082099003|38070700021|261028144727099003|11063799006|261026140227099003;
x-microsoft-antispam-message-info: qKY3wknmApKnSeUEtZ579gUZm8z9vZRY5AoLtDSPb67OACaPJp3Xo3Qno33Nq86jhTcBMhpyKOA/6By7gB3T/ejgKssW7ZgYvZ4h+hcykr7L/UKwhLiWmHQuwG2n5njpzmBsCWLfWbTEKiZhd1+orRYjdY9bquY5NgEhCGTv9yOmRo8epm2LWvQ3y4l6ZFS0lUGw/6hoEh1qrh/eZbAea5FtOqtlXSeyrPFu6Uo1TngoMTlL84vU8R1MggZa3dvXruT+hnp2flIDnb6+Jj81vO+KajTD0OoM04ufBRJ0j+a7K47C8bSp3xHVD4jgR6y3qWkplth7YgLpJzDmLZuR/ADTI6UxqVZMVJBWnKtbA6V2Ukk4tAvc6zyt6IEN2RO98Q7AI/4tqblWNID/ZGNR8WJ1vu9XWaK8HmA5qDpoLGfj0w3GK1BV/l3QdCFIQAEAgxvz+paDLZcRZOMlDGXtwgtFPoknKIcKmrBZ0l0kMDzZJ3Nic+FYbEZfbMrsdFanPColMlIGCzIp01MSgtQzQYstT8zr/1IsD1vP8/3bIs+STM7zXE+Db7rO7YKuJHYgpNnKvlCY57oNHOnQqax6HFzrYfxg+aB2Rv8zIyJGIB+MFfU3CHb9nuXAS1pVrjWSYAzICCwKtXHCwJc4BUd/sNHZgkATIa+qw+VDLC6YVW8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB566895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(261021121427099003)(261009223027099003)(261022075727099003)(261022105027099003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(38070700021)(261028144727099003)(11063799006)(261026140227099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NForTUs5N0dXb0lVY1M4TnZvSVFKY0ZGejRNOXJWeUlHZmpKZnRteGtkUDVY?=
 =?utf-8?B?TEY4VjJpYmNheTNWbmhXdFhCV1gyaWlNV2l2M3RXNm9jVENNbGtnaGM1R1lm?=
 =?utf-8?B?cUlCNmFxeVdpSW9lVHRkdm9XWHl4RGR1MXpnYXRNaVl0T25VTUZOeGZrbWtL?=
 =?utf-8?B?QWE0VVUyaWxoQzJ2aEs1VmNiVzc1SkJpYS9zblFBcTV6dmV5aVJ5WFFYc2dx?=
 =?utf-8?B?WmxzTXlDY0R2eVladVNFVVB6N3NaMzFRSWlwVkNHd0VzMVhhL3NVWUZjZnlt?=
 =?utf-8?B?T3U5OFBtL2k1MTE3T0VYMUE4c2FBbHM3OHVIL0N0TExkUFZHK3U4aC9nZzQy?=
 =?utf-8?B?WGxNdlVMZVFPVFBxTVN0RS8rKzQrN2RGWmd6ZEhGUVZhZTUrSThZbXpvZEZO?=
 =?utf-8?B?bmdBSFQ1UFRsRmtTZGo5ZzBXQTVMNUdCY3hXNG5oSTh3RWlJSndSM2FhbXRm?=
 =?utf-8?B?cC9EQlo5K09hYWtBOHp1SjFaS3M5aEYwTGlFNHRLbjJlN1I3cm15ZGFVcFRr?=
 =?utf-8?B?ZlNVZDBjWTl6K1I3VEJLbStTT3Izd25ucmpVNUk3ckxuK1g3YXVJeDBjOHVL?=
 =?utf-8?B?WGJ0dG1aalppSmpDd253d0FPcGJNR1ZmUjlqSHJjSEhJanNvU0ZjNFoxUm5T?=
 =?utf-8?B?RSt3dHhjYkZqaGRQbU9GWC84dm9lSXpiMTZzVXdueXh5c1Y5WjhUeENoQWJ2?=
 =?utf-8?B?aWJLL3dlMmNqWDZFTkJPTXJ6L05XTjYyTm5UaWxlTXRnS3Y2ZXFSS3RSdUpW?=
 =?utf-8?B?R3Z0MEJQajR0b29EZHRVVlRtcUJnRzhxSzJWdGtsL21kblpFNkhseXdadzRx?=
 =?utf-8?B?UGs2dnUzNjhhUDVqUk9Ubk9WMHdnZUdPMFhYZEFNeWNjVHJOM051cGR6ZXRp?=
 =?utf-8?B?ZjA0blc1N3c5RHhmVERkSHYzUGtGdTlPRXliUVROMnRPWmJVd1VkQXVUQmxu?=
 =?utf-8?B?ZzJsd2hoT1AxUlFzalBWTDRhQktYZHRyUEgzMCt4UUVwNlJmd3RscWliNTZ1?=
 =?utf-8?B?VDZSa1FHeGg3d0NVU1ROd2pXVWtjL0hHRzZuN2ZmNXYvVndQbkt1SEMzYSsw?=
 =?utf-8?B?VmpqcFlSRXNHNzZjRy95YUVlYi81QXJRS1FLc2w5OUlybzJrYmpmSXlXNzZF?=
 =?utf-8?B?eHJ4ekNtY0lMNkFqV0hLNDl1d2wrZEhzRW05bEVDbmsyKzhIbDFaNE5qVVlB?=
 =?utf-8?B?eFBsL1pLTFJVZHFTNGpHV3N2VWhmbG5UNDJpRzkwNGhKMHFLR2lGN2g1a2Vx?=
 =?utf-8?B?Y0tHbzVYNkRaWE94S2dJZW5OalVDUVJINEJxUHpTNDBjQXRGZlVjaFpFdGF6?=
 =?utf-8?B?bzJXVll5dExNemxWZVduaUEvNlBqbU9ZQUszbGdxYTg1eWNRczMwQnVaWDRm?=
 =?utf-8?B?WWJOU0pWTm5pMmlCRjVvSm5VVSt4OElMemRKS3JMUnlOcjZJK012YnQ5MUhH?=
 =?utf-8?B?WXdxWWpWT0trMHVZVVBxVnNBaHRIRi9hYW5aVlM0QzA2WFp6alZEZVQwNHFN?=
 =?utf-8?B?cERHQ29rM2ZlV1F4b1F3U0t5TGVpa0hDTmYvbHZrNUp4b0hJZEdzQXh2Rlpq?=
 =?utf-8?B?TG1kMlZHVTZwVHF3S1NrblNkemxzRGtDbTVyVkVwZlFrTE5ST0ZDa3AwcmM1?=
 =?utf-8?B?Z0pjcVJ3MzVuYmJBVG4wY214Q3Y1QVVqOXlzM0kzQmdOem53Qk5DRk9FT0Uw?=
 =?utf-8?B?WW1hNG9mV2s5NFFWd0VyZnhpZFVIZkxWYUI2R2dBUDZrZXo5ZXlaaGQ1dmcr?=
 =?utf-8?B?RHVqNGxvaENxSXpVMkRwa3NNdy9yenNMQzRnQUExdVRXWFl0Y0tPVDBkL2FV?=
 =?utf-8?B?SStkaTdDL2N6MFhtS2ExbTBGeUdVZFhHVm5yQjRPM2kvQXo2Sy9iQ0VJQm5N?=
 =?utf-8?B?akpPWVlwUGJkQVJnV2tWaWpwSjBsQWJlbXFpUmp4NmJvYlNLaVZ0MTg0NmFp?=
 =?utf-8?B?Q0dtZUU2a2RKc2V0ZytvZFV3ZFA0cU9oZzV0SG9hS1dIcnVjc1lIOWI1eWNT?=
 =?utf-8?B?Zm85czROQ2F1R2U2OGV1cUE5MFVwQVlPVFZEdmxBR1JQU2tFMkI1aWRnUnJo?=
 =?utf-8?B?ZXRmNGdRd1htRFJURmNzZCtDT1dLRVNxc3BHcFEwUFluZ21yb2dKK0pnR2dF?=
 =?utf-8?B?dFdnTjUrWE5adjlPME8xYTVhRFdXNEJVdVBGeUo5MGZvZVJPck02VnVIdVFT?=
 =?utf-8?B?OFJLVGhvM1JhRENyZndrUUlSbUZtbjFPSDlBamc1MlAyRVE3M0V2UTVNUjUx?=
 =?utf-8?B?L1lzaVBjYkp5cXJOeFU3Z2Ura1FFWjQwTFc3NG5UQTUrb0NHUktGUVljVHRr?=
 =?utf-8?B?dE5MdlhhZTNUK3ErOW1EdU1HbkFJMHhMU0F1TlgySkZkSElhKzZ4Tm1NVHlm?=
 =?utf-8?Q?yUgM9m+gJoDrgChs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: e8X+MEddFZZsdrEfhxe7iQedgpGE+5KPsGDiZ33AxCotptTQ1V2iaMQsesrX0fq1BrqaObfWX5G2rEUsCdKvmt8j2efQI1Htxs59aBl2yad+Mq1j1YcfBdiFrwMkr/ptxnu/999HdWDg8ey2O/kOKo++BS+2YzmlWyQtVWNnwcSmdsCqQ4gEc1RfbiP0sqQ01IXxkXH25B1iKnG2zsEcFK3TFy70oud7sRxh9BP7+Uizkh9dRudgIb/a03ODueAIEzFVsGWZLiZ7wAifpE8rWQ55ShYPEDecMXPg0gh30MC/mZZ3bGUeJPjlByZ16vX+ovjTHhctuxSnKpIQ8v6Kmg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894656b2-823a-4ac4-d109-08df3521b322
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 18:31:36.4881 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uxk7s8gJkK8lijoOJT13aiNPClPz/WI4t7TojSDKnLHTlVsuKeWyTxQmwf86UgWNWbRTwHrQB5E0nfwkb1CsprGCnWEQja/WR/odggjXZdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7679
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF1bCBNb3NlcyA8cEAx
ZzQub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMjgsIDIwMjYgOTo1MCBBTQ0KPiBU
bzogaW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmcNCj4gQ2M6IG5ldGRldkB2Z2VyLmtl
cm5lbC5vcmc7IE5ndXllbiwgQW50aG9ueSBMDQo+IDxhbnRob255Lmwubmd1eWVuQGludGVsLmNv
bT47IEtpdHN6ZWwsIFByemVteXNsYXcNCj4gPHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+
OyBhbmRyZXcrbmV0ZGV2QGx1bm4uY2g7DQo+IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0
QGtlcm5lbC5vcmc7IGt1YmFAa2VybmVsLm9yZzsNCj4gcGFiZW5pQHJlZGhhdC5jb207IGFzdEBr
ZXJuZWwub3JnOyBkYW5pZWxAaW9nZWFyYm94Lm5ldDsNCj4gaGF3a0BrZXJuZWwub3JnOyBqb2hu
LmZhc3RhYmVuZEBnbWFpbC5jb207IHNkZkBmb21pY2hldi5tZTsgRmlqYWxrb3dza2ksDQo+IE1h
Y2llaiA8bWFjaWVqLmZpamFsa293c2tpQGludGVsLmNvbT47IGFuZHJlLmd1ZWRlc0BpbnRlbC5j
b207DQo+IGppdGh1Lmpvc2VwaEBpbnRlbC5jb207IHZlZGFuZy5wYXRlbEBpbnRlbC5jb207IGxp
bnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBicGZAdmdlci5rZXJuZWwub3JnOyBzdGFi
bGVAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSCBuZXQgdjJdIGlnYzogcmV0dXJu
IFhTSyBmcmFtZSBjb3BpZXMgb24gWERQX1RYIGZhaWx1cmUNCj4gDQo+IENvbnZlcnRpbmcgYW4g
WFNLIGJ1ZmZlciB0byBhbiBYRFAgZnJhbWUgYWxsb2NhdGVzIGEgcGFnZSBhbmQgcmV0dXJucw0K
PiB0aGUgb3JpZ2luYWwgYnVmZmVyIHRvIGl0cyBwb29sLiBJZiB0aGUgVFggcmluZyBpcyBmdWxs
IG9yIERNQSBtYXBwaW5nDQo+IGZhaWxzLCBpZ2NfeGRwX3htaXRfYmFjaygpIHJldHVybnMgYW4g
ZXJyb3Igd2l0aG91dCBmcmVlaW5nIHRoZSBjb3B5Lg0KPiBUaGUgUlggY2xlYW5lciBjYW5ub3Qg
cmVsZWFzZSBpdCwgc28gdGhlIHBhZ2UgbGVha3MuDQo+IA0KPiBSZXR1cm4gdGhlIGNvcGllZCBm
cmFtZSBvbiBUWCBmYWlsdXJlLiBVc2UgdGhlIFJYIG1lbW9yeSB0eXBlIHNvIG5hdGl2ZQ0KPiBm
cmFtZXMgcmVtYWluIFJYLW93bmVkIG9uIGZhaWx1cmUuDQo+IA0KPiBGaXhlczogZmM5ZGYyYTBi
NTIwICgiaWdjOiBFbmFibGUgUlggdmlhIEFGX1hEUCB6ZXJvLWNvcHkiKQ0KPiBDYzogc3RhYmxl
QHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBQYXVsIE1vc2VzIDxwQDFnNC5vcmc+
DQo+IFJldmlld2VkLWJ5OiBNYWNpZWogRmlqYWxrb3dza2kgPG1hY2llai5maWphbGtvd3NraUBp
bnRlbC5jb20+DQo+IC0tLQ0KPiB2MS4udjINCj4gLSBTb3J0IGRlY2xhcmF0aW9ucw0KPiAtIFVw
ZGF0ZSB0aGUgZGVzY3JpcHRpb24gdG8gbWF0Y2ggdGhlIGluaXRpYWxpemF0aW9uIG9yZGVyDQo+
IA0KPiB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYxMDIzMTQxMzE3LjM5MDQ0
NDItMS1wQDFnNC5vcmcvDQo+IA0KPiB2MSB0ZXN0aW5nOg0KPiBUZXN0ZWQgb24gSW50ZWwgSTIy
NS1WIHdpdGggYmFzZWxpbmUgYW5kIHBhdGNoZWQga2VybmVscy4gUGh5c2ljYWwNCj4gcGF1c2Ut
ZnJhbWUgYmFja3ByZXNzdXJlIGNhdXNlZCA0NiBsZWFrZWQgY29waWVzIG9uIHRoZSBiYXNlbGlu
ZS4NCj4gV2l0aCB0aGUgZml4LCBhbGwgNzIgcmVqZWN0ZWQgY29waWVzIHdlcmUgcmV0dXJuZWQg
b25jZSBhbmQgZnJlZWQsIGFuZA0KPiBhbGwgMTkyIGNvcGllcyB3ZXJlIGFjY291bnRlZCBmb3Iu
DQo+IA0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19tYWluLmMgfCA1ICsr
KysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19tYWluLmMNCj4gYi9kcml2ZXJz
L25ldC9ldGhlcm5ldC9pbnRlbC9pZ2MvaWdjX21haW4uYw0KPiBpbmRleCAxZmI1ZjNjYmUuLmQx
MGRmYmRiMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2ln
Y19tYWluLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19tYWlu
LmMNCj4gQEAgLTI0ODgsNiArMjQ4OCw3IEBAIHN0cnVjdCBpZ2NfcmluZyAqaWdjX2dldF90eF9y
aW5nKHN0cnVjdA0KPiBpZ2NfYWRhcHRlciAqYWRhcHRlciwgaW50IGNwdSkgIHN0YXRpYyBpbnQg
aWdjX3hkcF94bWl0X2JhY2soc3RydWN0DQo+IGlnY19hZGFwdGVyICphZGFwdGVyLCBzdHJ1Y3Qg
eGRwX2J1ZmYgKnhkcCkgIHsNCj4gIAlzdHJ1Y3QgeGRwX2ZyYW1lICp4ZHBmID0geGRwX2NvbnZl
cnRfYnVmZl90b19mcmFtZSh4ZHApOw0KPiArCWVudW0geGRwX21lbV90eXBlIG1lbV90eXBlID0g
eGRwLT5yeHEtPm1lbS50eXBlOw0KPiAgCWludCBjcHUgPSBzbXBfcHJvY2Vzc29yX2lkKCk7DQo+
ICAJc3RydWN0IG5ldGRldl9xdWV1ZSAqbnE7DQo+ICAJc3RydWN0IGlnY19yaW5nICpyaW5nOw0K
PiBAQCAtMjUwNCw2ICsyNTA1LDEwIEBAIHN0YXRpYyBpbnQgaWdjX3hkcF94bWl0X2JhY2soc3Ry
dWN0IGlnY19hZGFwdGVyDQo+ICphZGFwdGVyLCBzdHJ1Y3QgeGRwX2J1ZmYgKnhkcCkNCj4gIAl0
eHFfdHJhbnNfY29uZF91cGRhdGUobnEpOw0KPiAgCXJlcyA9IGlnY194ZHBfaW5pdF90eF9kZXNj
cmlwdG9yKHJpbmcsIHhkcGYpOw0KPiAgCV9fbmV0aWZfdHhfdW5sb2NrKG5xKTsNCj4gKw0KPiAr
CWlmIChyZXMgJiYgbWVtX3R5cGUgPT0gTUVNX1RZUEVfWFNLX0JVRkZfUE9PTCkNCj4gKwkJeGRw
X3JldHVybl9mcmFtZSh4ZHBmKTsNCj4gKw0KPiAgCXJldHVybiByZXM7DQo+ICB9DQo+IA0KPiAt
LQ0KPiAyLjU2LkdJVA0KPiANCg0KUmV2aWV3ZWQtYnk6IEFsZWtzYW5kciBMb2t0aW9ub3YgPGFs
ZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0K
