Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74833C982E6
	for <intel-wired-lan@archiver.kernel.org>; Mon, 21 Sep 2026 15:29:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E0C2402DD;
	Mon, 21 Sep 2026 15:29:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VqQh0PGRZcMt; Mon, 21 Sep 2026 15:29:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6D36440699
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790004551;
	b=GgaPLsGQidQ/7yN1aZ1pfvphO+VVKNwhQSUi3+QEIywG3pewiXqXHQ95tEvHqC2dovtV
	 2xGMbQcklmqnI3XimTNMim+oWoOSZZpuoY1GibnbDvAhdlnMWPw6Jrvk7ICGE7Thzfl7q
	 w/qEjvZiLuEbAtHHAAmsS3pCforNd8lk5bFnYXHQ4H4CIN5Z6PyGHYGcGQRrT2+Td8TXI
	 dcxlkvnn0P18U5G9CL/mmp2/IOghh/s1SZZ9qs1FwSTWGvqYWc0QxTnfA3nEWI9s2ifJU
	 yGpKD7/MacXx/wN3Di2Els4/U0vBBI+q6paIq/QNM3gKasnJojODJo8r/odx/kATjtw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790004551;
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
	bh=DAJut/Rw8JhOOrIzjqhIolrinqLDSjGB0Y8g3YPuz8A=;
	b=HBj+MNmJuQmSykjvePk7xzXhif9kPtyjQm49bBArcE1xDZv2i/5Fz/VgP6AuPv6lcYML
	 MvNWxdFZ2z7ys8NN6aTCe5VWRobcNceKezd9RoMmTXG9v7KnfgOvMjao6m/KU8c9KlwiH
	 L7TY3JmEv+zmPDO4R5E21XOgtKH7Dm7Ps3a95heBfWABAGDBlgxK4uEFexWpO+2DxHTbW
	 gnseAGwyk6PoL+cQLTTTvsIw45p5zu7bst4N3EsKIZIMxis+6S/2ufPdvfGLjcs4gCd6H
	 qawydK11eV1KXwfYqY5GV5lsIWH0ZcAVFSm1D/DR6Wlh7SIhyChotSP7+/SRey/9jAg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=U+Ejexxm;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790004551;
	bh=DAJut/Rw8JhOOrIzjqhIolrinqLDSjGB0Y8g3YPuz8A=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qlY3WYUFKGCZfdkqvRYvI0PGF02IYBWYQpq7m5iLnerM3yXr9q/6EwNjfQONYpIIc
	 fCqBJVOtWnTjHbpY6l64b1hpjZrw2DrVGrron0b6fLe95YIq8e8UznNfK4rDLiKBYw
	 C6FRYvKqy2t1Yr8b8UBjSO6ajpVFyV1XweNBmYfq5fVUj4zjPcJKueiOWxJy/L5oqI
	 LQljh6ZUkCTdtITnnr1ftcfhoMqA7hT4rR3xqYzVE25EjAifPALZh+ExcyiulN3wcA
	 nBr/taAx9OFtmwfkoe0zAnxe6ZlQm6zx0+NGuHbPivz+H2Gx1tbDSApdJIRaswhI2E
	 AHSbd0vjTZX4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6D36440699;
	Mon, 21 Sep 2026 15:29:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4BB8C334
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 15:29:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 48FF740699
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 15:29:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cCcysdBLZufo for <intel-wired-lan@lists.osuosl.org>;
 Mon, 21 Sep 2026 15:29:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 66228402DD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790004548;
 b=dEPMLV9G5Pi9ls4U0kGq0I9wx3qxZhsIZZ9l1qElcpnO3VjtgclfDjNra5irhyDSZgat
 Dt36Dpu33DbNIdIZlsfGkpQsmNZMA5OiZwMoGAMdxrEGXEaOlS+w6Cl1NjsuN4o5unVUb
 uemtYxTJBf9HLd3u7QGljIZUBSm2vG1J1t6tZ983bPRy4haSuCOGFnIH2qRwnOrlX7ty8
 UqpFe3IEvc77r5VHzXXVY227DQ6wZSRUcvZ99t7Shnd90pe3iCQr/yU+4/srfYSz9bvkM
 haYDwz4Nk8agd6V0PiEQKFdAEQPcSTzwDTJ4hk3PcxDwSaRto9oQgzBkvexb+YoOnkg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790004548;
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
 bh=DAJut/Rw8JhOOrIzjqhIolrinqLDSjGB0Y8g3YPuz8A=;
 b=hIBiC0qLgY9mYuR8vcroZwD2cxPVMR2gW6S0y1swwj/i236TWTrTsFrqhytpRe+Qb0oG
 rHj/sIgoiQXx5eIPIyhY/y3y4zXaB52cn1wWh0IsvYZaN1UWcYc0KBRdthkCOIdKTaQeX
 +FCEk4GM/YdkpZe8G2Q3eDCvMnD/PXaKGIawYRN23Vfj0/1wVlWhDm7YeOI01KJDYqIs8
 lL74dgeknQTOP5mJNH8X5OykBqGWSUg4s11khKqtR8FS7rIfwO4HyIXZ8FnM+akRzMQP6
 EtRzBtLRUaNIa1sMuw8yoLqWS8JRzJg6z/3SCHEYLKatYoX+XMbH+3gm/sar2TAtMSw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=U+Ejexxm; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=U+Ejexxm
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 66228402DD
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 15:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790004548; x=1821540548;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=V6z+YA90Hy9OqJNyFOk0cHTic2vOjRro5B/lBkt+gLY=;
 b=U+EjexxmF0jXAb6rxgphVjjivzOfBDkXwnQ/DkqMa9R/P6B91n1lAlmA
 5+Z3Z5e2c7M/ttyA3tEQKcNkbdhtxZlKqDkIbq+OBU+pc3+Ni3u15my/D
 m/MZsp+klNxHf1Fc6kgB2FZxaMmAHoZNQRdBc8CuF1/ID/Rz1oKJHlje3
 orakmD11CJ3j0YgwiQSH7MPU4PkZWyv0LfQVAiEf8nq4B9t+Dx1E/8ByS
 qSDUd25uiwCoGGPJWYZmXhvhcnHjyjEUDxNDuGfGoZb+bMfJ+MFXUKbrC
 dmI7PZjZGtQhCYOfKMhRY3n9HMnzJAaN1a8IyR9K1V/IJCG0rZN8mqeih A==;
X-CSE-ConnectionGUID: ZO9ZMovCSvCEFgQxXu5mHQ==
X-CSE-MsgGUID: I7RdXWItRIen4qrOHOBpDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="89456942"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; d="scan'208";a="89456942"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 08:29:07 -0700
X-CSE-ConnectionGUID: ZYfaS2GOT36uD4wOMYsO/Q==
X-CSE-MsgGUID: 2DFtKfnzR0CL8xpHxC6Wvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; d="scan'208";a="271209794"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 08:29:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 08:29:06 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 21 Sep 2026 08:29:06 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.13) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 08:29:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=to24KcsR5BWgbhFciii/Ash813wgV0NwKqj2WCxRzwCS8GOxK+sNiOx9+35J/C40DKreX0O78xENYgdTnd8oL0116mIeD49L2HBiYH0AWWGIcpZe7n1ZcQYbOa1Qf8/smCg/B4ZU/S9TUX+4HZg5fLJfp1HT5YkphynpU/q8BY/h/DzzMXWcDHqVc1nWneeN2ahoPgKw9mcBr/eaoUnj61FWYfVDBcK3wfyBRK11q+7hwOKYKL3eXZiXSvc5B2GzDwhJl+KlN2W1KDuzeBA47Hi6cRKjOAOFX2n6jYt395l4IO6FDvbQMVrZJ3nqVS/He1d3tmexPuYJeU9Ad2FN3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAJut/Rw8JhOOrIzjqhIolrinqLDSjGB0Y8g3YPuz8A=;
 b=Rqt6TvrhW7mKi3OubfS8mH9hCI68tW/K9JBQq1DEqb+Whn/52fCdfInkJITGBNz/qkohplFUBwZH2JFfkkC8tCtOy3o3SKzBTlrGsJWk9+y7LsnGPgYSKhXiV7uvQr9K/KGYiRDBIqQ5RrVRFXdXJedGbau6N4guw+7wrdfTzFRG2AEI5fKGqY46amc0BIHoKhObY5d/LmN5v+Yg+vS16yyt5wuDlw3jFRn5dZWGY0Vp/bZem4xWJ2pgf/oAwVwaS3j1Pw+7kb0j5xhCbFCy2YUlZeK9457irkVI1hlfhqWzsSOzemzcjQaLw/AHAivHyFgYsAajCzTlM47Aq948GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SN7PR11MB7512.namprd11.prod.outlook.com (2603:10b6:806:345::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Mon, 21 Sep
 2026 15:29:03 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 15:29:03 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Linkui Xiao <xiaolinkui@126.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linkui Xiao
 <xiaolinkui@kylinos.cn>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net] ice: detach the VF representor when ice_start_vfs()
 fails
Thread-Topic: [PATCH net] ice: detach the VF representor when ice_start_vfs()
 fails
Thread-Index: AQHdSXe1lNDkbo6YdkSU11N1ajOqZrbZKNgw
Date: Mon, 21 Sep 2026 15:29:03 +0000
Message-ID: <IA3PR11MB898637C4F026F346D6514697E5842@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260921031616.3390259-1-xiaolinkui@126.com>
In-Reply-To: <20260921031616.3390259-1-xiaolinkui@126.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SN7PR11MB7512:EE_
x-ms-office365-filtering-correlation-id: 41b64219-0ea2-4b6e-ed55-08df17f5113a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|10067099003|5023799004|11063799006|56012099006|6133799003|38070700021|22082099003|18002099003|921020;
x-microsoft-antispam-message-info: tg6LwF1b39fiEFF9NdA6NAL/CEbKxKmU3pBG1uvEdMUQaQQUGKbnKk6TQwDHrET9pQMWS2cYRQUUl7BcPtlSYWUFArMzP2l92thgq6ai4cmxcXtilsIy8s+0DYFsTeIFc5fuAbezAdZrr0GMtRXa9PsHeVUbmFtLN9/mTjQgp7jInJbBEZNms0ict7UG8if+LGHwVCvQpt1wvzJgvY/lSPpG3pJYQypkGVjA9Gbkbp9ndwWxIXixyfX7TMGFDDIR7y1K3cwGIezrd576o2qbipCdnDkyZ7AWzGvMYwuPuy03jxgrDDu5x8nrzkINq6zr0uQVIJulhi9mbUvHDbB7tdcsxVqvlTcTjkPC+U54ol3gqxREsZGPOnXpxhaeAAKJPE9h7+3uIP5VgbfSKc6BGG4prgW8vR7e+peG/AtBTLvf0dxdwheEWv6l3L9oJUT0gukrc9o/TQ0EpghO+sqUZXryEGsC13JskIQyMgg6CZkcRJqUqQVHeg1gE6glZWbzTPdzPUA5U8X38pC++YQhEpGE/bI1wrWL6N9P1amgp+dsSauGr4BLPNKWtBNzFObOploCDbcHrwe8yJOuscZKY7+bmlNvVuuzYmnKsf+kZuEqZ0h4uF47XDksXJzWYWcAR5wpZRkQarmHJHKKZA15orCzCvJh9XFWd/uN9uW9zKMJAqmEExZ3lQTec//g9YYdaFC6HH8QffE1WRAG/R6gisv5T+l8IgpAgHsC7R7UljjhBxQrayMf/N+NxZMMOZce
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(5023799004)(11063799006)(56012099006)(6133799003)(38070700021)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cL4WviHBk554RBb5GBmdXDL60BPkAfHiZRykC0gUIRRu377JLNzbczWa9pZX?=
 =?us-ascii?Q?PxKvmQbflaxxywn4Rlh3vgJ0Mvq3tE004H8Gcc5nBM699+gEjhEKGV2J1Or3?=
 =?us-ascii?Q?s6Yd8T93RGEwVEUzeEC6SgJMhjK/lsvoVXrioK1gMD8gP0PR89eVhMug8SfM?=
 =?us-ascii?Q?+9yBw5QYgWmrJVmu0ri4B4Fb0c3uvhZ03XYucQRsKxTzKdl0yyP7x+6R00cg?=
 =?us-ascii?Q?YOe9I1qiqU6uMLRtnnkOLwCoahbOzqKMb6wicseFcGEXGl4c+fhocMcpW547?=
 =?us-ascii?Q?xMzYaJIPrzxj2Orjbp1YNN6R3jVsAp2iY9PtJ5N4e7QOJpDFz9HOiDWyq7qO?=
 =?us-ascii?Q?eL1c48H8wwPjRzRsT1v0dNHKyD2mJP+utbSDVamun8oQWKj5llXfXFJKr4Ih?=
 =?us-ascii?Q?vexU8ZDgUbp8VrWGNMcxZ1c3rs9HsRpLXbPISwL66Yh+Sqbz6CMcZsb/a7W2?=
 =?us-ascii?Q?n7eMF+lxLy5nxRmkOOzv4lAVu8hpmekPKPt/w2x4I85fnHdK4KyXleG8VShk?=
 =?us-ascii?Q?O8mwU2PowP/ZrtaKai3BUp5AnM6fbzehpRsSDlrJxgkRFvYYXBcvnTzQfTb7?=
 =?us-ascii?Q?wt387kotb6X7h9IgH8np1zxof3t0sj1bsbWdr9cgNOCqMAbgn5mKlLPWsqSw?=
 =?us-ascii?Q?CG2WodoVQNeSMvUOOUSIOGSyGqGAxabxVdeGctQPpQ0n/uTivl24JpRtOqXm?=
 =?us-ascii?Q?pdCE5gq0dBS0o7hPQjOy+N5tGmL39lGGEnn7zhzcNoX3uqYs8aws2Gkq1Yrv?=
 =?us-ascii?Q?4hN7aOd4Pmr+fVOPduuoVJMlNfah2oZbOFlCnxO0aP8rZdrmAMzDpxQDN5HI?=
 =?us-ascii?Q?4BI+hAdjlKtt7O30HHQY7GEnMl7ldyi7jBenHHvcOPxrJoIb/4ZU3g0u71VO?=
 =?us-ascii?Q?fa7manxm85YMAYlZqdHbZolnNViNuwRPOIzpB2p3RRyw70yl2s+Bv3gUSvPU?=
 =?us-ascii?Q?jTXjSeqpL4iI4p6eolKRbm10LlmbhbVyBORy8bZXBSORZCKENK+gQar6i2tI?=
 =?us-ascii?Q?IuMSbFXnQFRDNPqcHw3XpUIqa8PkWySeGV9GG+Y2sLLZMV0VsmDSxoxHXPN8?=
 =?us-ascii?Q?OR+mC2PEDu6WNAD6clTyrU6kojmtH+ktfYQ7NQTkbG9y5sEYXFslUK/NpkRw?=
 =?us-ascii?Q?ifiGznEOYAIlVQ5XkXS6RCyH9mpCCOrUQDTj1V5yN9MEyN2JWwE1YB5WcllM?=
 =?us-ascii?Q?OQEWWBkfT/ZnHYMiRGP9eVmKmTQv8/kSg8unlAD7Ll/hoNAsJtROUDPaBZFF?=
 =?us-ascii?Q?+crhKKQcZskKaCSpjxv7gbciWuR0xSeRB6morMrRYs8/eqvc2gVw9mH90yvL?=
 =?us-ascii?Q?SF6v2TJqWeP3x3oi30TFa7ny8L57QJe3Rl48kN8ZXtAanG56MyYDVmpONiCx?=
 =?us-ascii?Q?jN++GxYhYTcIB/PIo0FHO47tqgAR2lXIcfgq2bfelNpp+nY1uSduNmdLK4xu?=
 =?us-ascii?Q?Nt+Xrj56HoD5L69MW7vrK0VUJEiD/VVmDyhxK/y/9qDonxic5flWUj/RC2Sp?=
 =?us-ascii?Q?vHCaR+YnoOV25NL30v6WaumsRG2KA9+ZcoiMgkKLKczh1cwy7N7k5g2kRaYw?=
 =?us-ascii?Q?wDkC3Xhv9r1C2CF0XZbicHI5slsVxpcQ07UgIK4mY/hZEA7I2Ej39EsHZFio?=
 =?us-ascii?Q?5sdtw6g6XPDU5plJcp1IgzkL+76bcWuHOLb6yYxccA8l07vhfcfVXisQyE82?=
 =?us-ascii?Q?EM323BHy1xkNW3sIAcjX1mA10RFEW9ulO0Ex9f8l8njmMY4x1Ibzps12vb5o?=
 =?us-ascii?Q?HZWBEGyK9hJK2uUFC5QfRqgJ57rlWMc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: X5dwOSND3rdtlcLuKIgL4C69nRPuugZjwpnK0Svqwk/gzlFF6neWnKucTBE8whBU5rx7XgRcOa0s2uveJU3OL+JViQ1cRNYTRwn+vGit5JYPkqLjD1mEs4QkenNBCVg+FjbsoWXpOMDqOR8hEEFIZq83NM41zxDPO4GwkveMQm3Sv0faZCb+Lh0l9wFESoz5D+HmDCBcW4LhJ4DjuKkn/Wk+PvqvYsg3OvNmR6XxmgdwC56L1ThghsUrCgqwq7h7vLKZkdTOTee624iRxfsND58QzXa36r6+woToJVA3vEviJwMJkAzlg0nXM5ekFftBzDGsYBDewL6kHAHCJ/YchQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b64219-0ea2-4b6e-ed55-08df17f5113a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 15:29:03.3077 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0T1hzHOPixOO09dZcleVGAjwO59pRhI0dsFwCU78AzDXK3+n/65lQXWx8Rc6ut2gTKlEx61i4AEamXgaD+WWTw0bsPnruluSIwPbUXdcMCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7512
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
> From: Linkui Xiao <xiaolinkui@126.com>
> Sent: Monday, September 21, 2026 5:16 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Linkui Xiao <xiaolinkui@kylinos.cn>;
> stable@vger.kernel.org
> Subject: [PATCH net] ice: detach the VF representor when
> ice_start_vfs() fails
>=20
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>=20
> ice_start_vfs() attaches every VF it brings up to the eswitch with
> ice_eswitch_attach_vf(), but the teardown path only undoes the queue
> mappings and the VF VSI. Nothing calls ice_eswitch_detach_vf() for the
> VFs that were attached before the failure, and the caller,
> ice_ena_vfs(), goes straight to ice_free_vf_entries(), which drops its
> reference to every VF.
>=20
> The port representors created for those VFs therefore outlive the
> failed VF creation:
>=20
>   - the representor netdev stays registered and its devlink port stays
>     registered too. That port is embedded in struct ice_vf, so it ends
>     up pointing into the memory that ice_sriov_free_vf() releases;
>=20
>   - repr->vf keeps pointing at the freed struct ice_vf, and repr-
> >src_vsi
>     at the VF VSI that ice_vf_vsi_release() tore down. The leftover
>     netdev is still visible to the user, so even a plain
>     "ip -s link show" of it reaches ice_repr_get_stats64(), which
> calls
>     repr->ops.ready() -> ice_check_vf_ready_for_cfg(repr->vf) and then
>     reads repr->src_vsi through ice_update_eth_stats();
>=20
>   - the virtchnl ops of that VF, which ice_repr_add_vf() replaced with
>     ice_virtchnl_set_repr_ops(), are never handed back to
>     ice_virtchnl_set_dflt_ops();
>=20
>   - pf->eswitch.reprs never becomes empty, so ice_eswitch_detach()
> never
>     calls ice_eswitch_disable_switchdev(). pf->eswitch.is_running
> stays
>     true, with the bridge offloads and the devlink rate topology still
>     up, and ice_eswitch_release_env() is skipped, so the uplink VSI is
>     left in the switchdev configuration that ice_eswitch_setup_env()
>     gave it.
>=20
> Detach the representor in the teardown loop the way ice_free_vfs()
> does, ahead of ice_vf_vsi_release(), because ice_repr_rem_vf() and
> ice_eswitch_release_repr() both need repr->src_vsi to still be valid.
> Every VF the teardown loop walks completed ice_eswitch_attach_vf()
> successfully, and ice_eswitch_detach_vf() already returns early for a
> VF without a representor, so no extra condition is needed.
>=20
> Fixes: fff292b47ac1 ("ice: add VF representors one by one")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
>  drivers/net/ethernet/intel/ice/ice_sriov.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
> b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index e04de0215596..1b563aba3bbd 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -508,6 +508,7 @@ static int ice_start_vfs(struct ice_pf *pf)
>  		if (it_cnt =3D=3D 0)
>  			break;
>=20
> +		ice_eswitch_detach_vf(pf, vf);
>  		ice_dis_vf_mappings(vf);
>  		ice_vf_vsi_release(vf);
>  		it_cnt--;
> --
> 2.25.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
