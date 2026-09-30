Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F75CA5FA5
	for <intel-wired-lan@archiver.kernel.org>; Wed, 30 Sep 2026 01:14:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5EDDC81111;
	Wed, 30 Sep 2026 01:14:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jCO7Yk4P5rh8; Wed, 30 Sep 2026 01:14:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C884C81104
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790730868;
	b=Dcn0Kkd4p6VXImdTgES/h3CJn5rXRepWFhG0kNfjXXM4lliTl0f9zSPr6OI4FasmIJLJ
	 ZGmEQCXUoptCSD6dmEs94bivffRkPyiDEBlrLEBes1touA67R05xqr/8gckkKXYgKr08K
	 3k9SSCVa7nSnN1Nly1BvuySpj3omb3OlauJP/KkYRkupYmv7WAgGeqbeVZCx5QKsHp8Px
	 8KywyHLNAzl5f8KXoZYyhdbn/Tad98woCFF8pq79Z25xbhHCLCwnnX31wCtleTcN3O85h
	 0gvoQoyxanwGTSUOf9LBcAPhaDjUsNget+OuKfzRTfKmdyu6MnWb0Yyf8ZxmdVJN3Xw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790730868;
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
	bh=6AztreewB0XTYAFI8RhFe1oPSqLG7olVuqxUrWb2gL0=;
	b=lPWBL1aB36mfoNKE76RrRSfuMnQmN5XUe4YWqQtBC7d4MDbIzMkMmP+N19lxlVvDMksK
	 4DfVQfqObpNBjqvaPnNSPs36SyJrb+eKN7xmKOwP/hMaCzlzYpih0uwPnWYxrTQGdsUaE
	 U5yzfQgegT24QK5XGVqTT2QiY9LJmosxft8Cvk1El+3ovTnRLDWUfwNFTgFHZqd1M+Hup
	 rr+kpZDeEPR8WZv2Lh1J6oLXq21PKZn0e2zsRxfyBdJUGCbAG2qf8e+9F7EUgVHzQBYz7
	 zbRHNnIL+JeNFR2rMtL55Re+QPr+P25GAkTptXaUIPfxF+z4z4L3RtkdZUw0axooFuw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790730868;
	bh=6AztreewB0XTYAFI8RhFe1oPSqLG7olVuqxUrWb2gL0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W3rW2bKldocaDy5IVJM/BltDmYmF9zuYKdqGy5t7KdymHfPOWcJI0PnGcyNFHDG+h
	 7KHQIdGlzegmYFCFMLzuEz3AV9+9ENQoxxjVssaSewgR1kl+9vn6jPtqX2fW0bQ8A8
	 Tjm63cJzeis9uXyhH6Z9Dp+dgeGw5SvzI+5+wnYfoca/QOq41WlQkXwrBXcRU9oN6b
	 a0S2bpiHzrSfIp9wCU5e2LkqdoB27Pvnhe/Ava423TweGfJVopHoHHPzLoBnr2tGTT
	 T3nORdgE/2MnsvTX5ho3WtC8MJefiDtZaUbSqxGDHLNg8L5oNAy12U0Ap4FtvCIIk6
	 GOoeX5cdwsYHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C884C81104;
	Wed, 30 Sep 2026 01:14:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 233C0282
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 01:14:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 136EF6082E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 01:14:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mSAnG1V4LjD9 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 30 Sep 2026 01:14:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DBE76607E0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.8
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790730866;
 b=afCxVH8f9b2XPQv9cTG1ZAMtWfJubPapeyFO3VWOmLNpNBH3u9RUyOZt9LhqnfnRZKvt
 TaxS3vUZgkBq04oraVYxgbpoiYbTbFO0RgiU/7Is6P51D1r/29z3r1ME55wao/N9u2RnR
 FQfN8Mds2i51gUqBKoy2iCrl+kQXD7g/ZKiXokq0WpOYOpEE3sFxQ0J4+fnmMI3KaJ1YE
 /L/1+ovWnDhKhJXpGs2MZq2zxZ7lEn/0FuxyBuDR7FhR9hDNw9nCI3YU9HLt495gxmyYr
 Us0fDTDezUaM6mmtmqzuQUFudh0TmYfXhAb7j0wnegLFF9Gr5vQPvD6zIcxu+9TCPYQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790730866;
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
 bh=6AztreewB0XTYAFI8RhFe1oPSqLG7olVuqxUrWb2gL0=;
 b=FfJxXAZ+FXA0o3+7dY5rJVUypYfDj8WFnliAH3YfHCxH0LQY0QBSMEtGF3zkFISYyLWN
 xlJ++aqG5PW5qID4RNH2Ts6dUJir2PWq+FdxfuG9twaTTNnXHIkr2++mzJvYiJTWLrxOe
 vsEK9WmsU/pK6pzA7+bPXTSY6B49BKNvaas1S9iBh4IvPgpaB/sLD4pv+KXUqhKneRXEQ
 9/Zl0vNCxG/TasfPy5tNu651StBXaQk7Zto8jR9YZHbo+qLAdZXtXxVWI05XEd70dNKMi
 6wLxMo2Zms8xcTIW5TEpqJCriWLKzlOuD13g3ZxjyNiFH6rFzCYk/ieSXQH+VWm3ICA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=VpAHJgo6; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.8
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=VpAHJgo6
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DBE76607E0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 01:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790730866; x=1822266866;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bRjqQ6Ke9GICYjEQWJ3YhHsqXsDLseqrIBGhGZs5XJ0=;
 b=VpAHJgo6Y25Bbzmjdf4beaMD4C4nzvRq8XuKoZ2c35iUiya3wvgiPT4x
 q1fZ+6deI3PQF9JdAl2cs6LVEJBQ9T/JfXKrvIuK30Z6L0YIiKAPxBKA+
 9n4am0I124zCzpUd9Kef0dAyX4f5MIjA6ZmLRYtSQfkadz/qd8mL6mcMr
 PlyYVRdX20t+rZFVEjaxkvYDtvXibMo5EE/UWhVmfMjUHJ/I4MsBNT7zK
 KBHwkT7ugWHuuiIwNmXRTmcIEEVWvBAxj0gX7q86NF6HCk780SyMJNV8H
 PjlX+mV5PxCE2jpHR0hgmWBDdM6jaTUg7wlMhPEexsFpZr/wPVwchFohU g==;
X-CSE-ConnectionGUID: rlFgu3UJSaGMqawT5hMdJQ==
X-CSE-MsgGUID: rK4OCv44SJacprkOJqmZfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="108948329"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="108948329"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 18:14:25 -0700
X-CSE-ConnectionGUID: ZWmtnxA0R+mnMPkxYYVGYQ==
X-CSE-MsgGUID: 7h6AdSAbRUqgiKIteA0C6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="273313360"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 18:14:21 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 18:14:15 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 18:14:15 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.60) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 18:14:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hru5rbzao6ag0aQlHXT+IWl0ldpmX4YQmvcHVHwxvw+hKyZd2DtPseOEgzc2snx4TWO/GCWxqtCF16l18EnlCv+VUWvcUeJxUVem5SpGcRNWG56kE4kM6zhAGmuxp4x27R/kanZ7Hloqf8rgUvRpRuyxTP6xo/ownaIhsU/wK5kXDCN6cNwttpnWV4VaqdShwrwWFIEvqV62U6QgDWuwpmRiQyEamJ9BjGAzQ7fKl4EqirpPdkpKPpwxWDxi+FGKiK5gk8pZ8yYV/OkHuuXNFqVdEGgaSwlcoeint93CctYyuu8zRQEuCWv/i2mIK1o1bRRRqDY1pOUgKHaBaktJgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AztreewB0XTYAFI8RhFe1oPSqLG7olVuqxUrWb2gL0=;
 b=HdEqMkwE2kzb6D+vgAa4eFTeo8ySqHxvwbGg+q4lqwuKj0gERRqQj+6I5LSs+VAnc81PIFOWGkMeNy1HNC8EdEhrjkjI6oYxHXFfRYf+iFYQ8d3+IH+1kw3uy+h2qfThM23q1lqqYTE+9fUcZOoO8negEG4qmGFHuRdQ1hf/j+gJri47oz9rh1AlOHH2agrsv1AqRH7n6Q2E3FbZkJ3ikCkGIp+8d8JRx8Iij0si71RX1iMWHb3DuIMyos+9zvWvEDK2c/4QqDUMSbr8P6Bo/XIVVmO/OnHAaMRcGvVCMf3UkxRsnYoqz8KERGU7JGuf9aEarmW/EQzBLH4wM+uhUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by DM4PR11MB5232.namprd11.prod.outlook.com (2603:10b6:5:38b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Wed, 30 Sep
 2026 01:14:08 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 01:14:08 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v1] ice: use global queue index
 in TC to-queue offload
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v1] ice: use global queue index
 in TC to-queue offload
Thread-Index: AQHdB6uxwN3c1PzvQUyNX07iywV/pLbm4neQ
Date: Wed, 30 Sep 2026 01:14:08 +0000
Message-ID: <LV1PR11MB8790366FDDF30974AC5A40E0908B2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260629091203.36482-1-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20260629091203.36482-1-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|DM4PR11MB5232:EE_
x-ms-office365-filtering-correlation-id: f462d3cb-39e6-4d5d-ab0d-08df1e9020d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: +gJ5oPVF+v28nlwNWAEVk5Zftpn6rhtD0+QEHEV3nq0sRq44sVT0ZJRog6VVePVoJ8l7oBcnrjb0GPwpjvi2akc1c4LXTwVshefjMwj/zvXnUNa4zVs5ILTRbSC6owalQeKqs8ZOY58UPsPUyYPE7QTR85AsNyV/RHZXjfjl0uLSPnxHwnNy73CA6aZIdHqzpCsTkYmSyXDqP0oHaDWgV0BpMTKfXdy40YFi77fsFNSLaYRLaBPnCD1JeSJh0G0paizVbDkZS2OR4MfD4YYMhLXOJHvq0+WhIN6k4EEBk9iSRNdnQHqZEOnYjwS4YBjc9aH+DeFbzF7wFTEoHlSGNfvM/ytQzhdbKEuOlaX4P0DBVPTlfQ1jNDpPrpM74d8a24WGixP7CZBLH8mg/Z6iQl9Y/4ab2slgg+MIpFMGr9Scdis+i65e2HfAfzzlTLYXTp+pj/VMY6+5qQpEFWvt+GHFWelAht1Z71uoSH87KeQ7We7M5qjTH0Fh2GlNGOjZHdZY43uUuLG9afCA9HP2dLIEGLlCINVr061AYe1khGMDkZTLd5g22e+r7AV5FgeZzF584Ue9mamaQJuABJOqxdj+5rq881clPWFf5dgfq1TIMX2FQKJV49opM1uhYK9Tc34OlmViDUWY74ZVtkb6Clht9aE8D1IpIoXGmlu1BXiiHrezEMLucd60ohIL4z7NLdi6khl+5NF6Pv6cRBJiC09cJKWqFvdWNzpIxfS8TGU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qObg3WjlM/K5HDcWzN4MQoqLdP/JuT5l7nU+atieE5l3h/w+DVFa9Vi6ATgr?=
 =?us-ascii?Q?2OtRF6mYByf7TTmVK7C0CcrOM5dhkpE9TLJifJj2BqNAZsjfKnQOkJbLjH/p?=
 =?us-ascii?Q?D7IhHwfPDwWA9+e+fqu7Pg74GqGw7Jafdhq64wLKqadufisJHFxoj80pmSGt?=
 =?us-ascii?Q?c32nq3pownO8NT2rFn+ZgorjNjXZWHnm/iYNKSa9H9E9bYRNKPS16TEFuqcF?=
 =?us-ascii?Q?NyYwI2q3SxqxjaFqhGBl8SLkyfMdyMaMgGi79BfcZzPh1nbSljuUeD9U/whP?=
 =?us-ascii?Q?YQeYVqoAbdNa9W+cYIlA+jTded7OUzuiWIa1tFdLG4qLpTyeBnyiBDRG9k40?=
 =?us-ascii?Q?EdswKEpcJuTS5TdbpzV82pfb5eAgxzsMFxl6TUduEE+zjcoxKlDXuGH1Aqsw?=
 =?us-ascii?Q?b1Uo96zILPzU7tKTyT7l9FEjQQTKMgYXPhpU4wq4S4XSLoEfGzu2hfsKtgsS?=
 =?us-ascii?Q?DUmSKPjmkTGlTv8L128VcRpM3eBy8pEhoyV3UeiWX7oR0o9toajbvRtueIz0?=
 =?us-ascii?Q?HmHo7r0fXx5Bmzjd/yyRRO8waV6mWNeeO/NBKx8liVyZ0SisQxfI0UWww7J2?=
 =?us-ascii?Q?aezMZHRshIBCuJ59Wz2/pMIVK38il4ZNjePUmafjJtb/jVZRNfLR24XBsLRz?=
 =?us-ascii?Q?4KvqSkSkksmsDFCFoJCHZ2z0bejtUuKNTllht23OQmTbVmyVE3Sha9w+tD+w?=
 =?us-ascii?Q?IxIjvfJxUOebjv9Que62R7QY4e2XPu8msCOP60t4FQPGCtjikZh9dUnVDLlx?=
 =?us-ascii?Q?CfgcHiwJRzVkBfcoWeG9jZk4Bx0653+RnCts+DdddVgjWdm4/b7SUtC0UWSK?=
 =?us-ascii?Q?1jKpUSYmfal1gKoO0w0Z8VJfCMgWkfrndCkv17ny7cEG1293tXdjWGXqmexH?=
 =?us-ascii?Q?UiG1SGGFtJIb6e6x/52lC+KUYwFryDAKYVTFbRerCFusn97LwqLIlq/rxXfC?=
 =?us-ascii?Q?vjJZXkkx0KyYSLNwnVRFolS6AIVAmDZThEWT5s0ZFzqo1ni1WcN3bkHY9uoD?=
 =?us-ascii?Q?T7vMw2nQvqKtkm061mhvlxnaY9KsB3T4sRYGzk06WDSW8UfqaFrdP1RLn1GC?=
 =?us-ascii?Q?tcnRtcvy4xdyl0zJJWE2i8n69oqUQy3jQBbv2j+k2zghkBCeWLcQnAC0d+n+?=
 =?us-ascii?Q?OqSXmoS5WxuQVn4nR+PdT0zTygwb+R/ieviwWHxzoh9nNUqFVq13N52RhHnl?=
 =?us-ascii?Q?xNK9w4p2AeLWQs0TBNP6dTyjkgkNX2fohAGJlQg7/MYuYG2uVZe5QlRqNv5/?=
 =?us-ascii?Q?zxhXn7w7GMgGBul+aCnPmhTrG0jODjIZLXFi5SYUWiaaX2PEZL6GofQZada+?=
 =?us-ascii?Q?OQGZGo+4czseIU+lsiPJZ9FO7o+HVlA7QlzMSuGwmFKPm+nzoI+9BttNEpAh?=
 =?us-ascii?Q?AjNGEuCi+01S1ZBhtXdAiloQM2cez2zgsC/IbpyAa/clgjARpteRzVv7H+D8?=
 =?us-ascii?Q?JAwcPssMYBPvA0SghH+VzX+dlf54gZYVgbWJOMjWEIE+Um/f85K5mkoh+Fc8?=
 =?us-ascii?Q?UambgFGua0EANGmaqSu0kkssO6Hi4H/obDMAYD1+zUDd7EDOJQjweO6k9+iM?=
 =?us-ascii?Q?kZfgsiSTDWO3tALJwZ5QZpcIxkCJ9J/T6DkuZpdhabAKeF0OOzT+57qtrTsY?=
 =?us-ascii?Q?K9eZF7vbH1DbZtwZcfvJepzSi3LlzCC59LwRXj4w5iajj2d2Q3wwFLyBQ0hR?=
 =?us-ascii?Q?KlWfYLgKxoZTHAtKpUpR7lUm1rqDxI2tXyLgyHaAsebboKNJGvGAGDZGid5N?=
 =?us-ascii?Q?LS3b6JW4Ew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 3AkDnU+eLOWFb/FG404e4S7O8a7egPetZGKq1+sk+r0lKxm9/8qyT/XOEC1F8PdM3E3xZYb1g0cGhOrSmF6qDBeAOhCoi0Wak5bT+tqib32tH7t6kO5PHk0lWeiFXhHkjTWBeBQachaiDLepsdXMvdkigL7frfF7tIwpx3viiMspF0bo36IO+rKXyom6TtE4zXZsdOOVOtUq0tAIuCiFnDndDQLa+DTaKgwEhwzhZuoqc6zx7cqOe3fbwUQP8fIpJvsU7iK2zV6BHOUBE7U2HLLfI+wQFOL6yltrCl8vGITB2UX1Ubz/JTJiHOnv1upQKfe9tWIveSSyO1oZMBClhw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f462d3cb-39e6-4d5d-ab0d-08df1e9020d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 01:14:08.4652 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RRc6LXoj7485I1rUQDyvaemTRF6LJsaj2XvSFPRbh5QGCkl48hXIexO10hUmcpeZLlCDsymlCk2eDaYpaonfW8TgZL15kLgAPbKn/RMe5YU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5232
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
ichal Swiatkowski
> Sent: Monday, June 29, 2026 2:12 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Michal Swiatkowski <michal.swiatkowski@linux.=
intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net v1] ice: use global queue index=
 in TC to-queue offload
>=20
> Previously index within PF was used, which caused rules to fail on any PF=
 other than PF0.
>=20
> Switch to global queue index by adding first RX queue id from caps.
>=20
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Fixes: 143b86f346c7 ("ice: Enable RX queue selection using skbedit action=
")
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_tc_lib.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
