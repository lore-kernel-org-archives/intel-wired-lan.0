Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6A0CA5FB1
	for <intel-wired-lan@archiver.kernel.org>; Wed, 30 Sep 2026 11:54:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0642260AFE;
	Wed, 30 Sep 2026 11:54:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D22Cok-oBJJ1; Wed, 30 Sep 2026 11:54:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 11134608A8
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790769263;
	b=kjjID6LbAo14N2UgIT2AtWVvHuBMqLlP+xkHmaTo/LPqsLO+T8MQKahGJE6c5qrlC9ts
	 Wi6gBtkVpQDO7C6bULqPD+VCbbgguf3BbXGf26HXnuw5BtIJKXBnD+mafcg3S5xb7ph+Q
	 MYs3E1CVzXj3UvkB3yysOciDbCK+7N+vIDsimHS+1tM5gnlFvSeAq2tbLEUd+j0o75Wbs
	 ebhgZBWRGvd+Gs6Z4vOvNbjxogAxu4HnPMdbeM9LTmThrjUWulpm0K1b2L/X501Ds+duA
	 8r7mbWZfHEOpdLqsFUWOff4SLCIqbTzlTe48Gjg3q5Zt1HTZJMygs20o1oZ0gtjT1ng==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790769263;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:CC:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=y9Yn7+vvHO9pWvd6Yo5GVMjOVJetm0opeXw6H4KVQXQ=;
	b=F9R238Oown7vC8cQ3+kAns9bSLZfo+n85BJPENHuk6XXBl7rIWm2x49UHYG4byLliU0Z
	 EYLMIR+N6xW/l9hODGJXwOLGrhJeJROjoJ6rscjNdJjKmJMhTNgIdFRdukDBxDdnV73sj
	 WyzRg8MuUGEUAD+PUe42pEMCNXP34XxqULSi2kaLhqGLQmCQfG7Pdy6sieaN2JcmBKX6o
	 gVW7kRuz91eB7MWWtQ9ijMguLdiyfC0IijPQ0vUI6MSX1GDvoCzW2JzzU+fCTtQHkj13Z
	 wr4aWqfp2AuDXw7FCxfcKleBEweyVJ2b9gZUzyieeLw+mRw2DNJpHGUHWCxXXKKPSGg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790769263;
	bh=y9Yn7+vvHO9pWvd6Yo5GVMjOVJetm0opeXw6H4KVQXQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=20VxIODHsMuxGngOwg4p2jpjhA0zABlqFyHOImnbv4s3z7xb567rmZfMKLs6B5rQM
	 +8h9Zc3GCdHkjkNTBLeTnHVBVUFLdWfpMyYTkvZ3mmOp4aeh88sDdiF5af7lycjtc0
	 oCznW+BVfp2YhLK0HVeI4yKlFlQhW8h22q58MLByb9ExzboRS1BJ85vXydnimXXIcQ
	 k8/jr7X2WHSML3xRtxSA3vv6n7jV+HXlkfiVMSQ1sSe+5XfCqCn+DllTmgxF6lMLOX
	 pnJWayWGgvS78yE8ulgMeHbt7TrjIW2B/6aZ6nhFqtCqhmvvSKeSN56C4tl3iBAYyR
	 9shxSHiRmtyHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11134608A8;
	Wed, 30 Sep 2026 11:54:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 268A232A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 11:54:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1813540A63
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 11:54:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SAbDW3ZypDOe for <intel-wired-lan@lists.osuosl.org>;
 Wed, 30 Sep 2026 11:54:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DB8B44080D
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790769260;
 b=P6s2lQzsnMzjNpScltWv/8U2pt5s+0e8LkZ8ptLAy+7KX/PLL2PBZ61OtpIL31yiSMhn
 P1+qG2Q4nroDuPcBc/Aja+tvosuQm+aqd/7i4f4iw5oVUuN1SIbR8uULRA1K+L+jKGtcT
 ujGNCbV4PPStRC2Hw/X/L7yBI2rVlPpheSqEGLspXUtLjrb4n8FVzX4m6BLWn0x2gNHbU
 ADMhqOZG/lZJjZ9JCKXKJGfrmR1kNhIF9MnJlOVCw1mr5Jag2ukzJ+hzRF0JJah8dcriV
 4EvUcz+yK5TxndYB4dtyHunygcGqeAJDm2upsmTTVKA4P8oxhzIHclmeh6DjduztKwg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790769260;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
 References:From:Content-Language:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=y9Yn7+vvHO9pWvd6Yo5GVMjOVJetm0opeXw6H4KVQXQ=;
 b=aXjxpG1ODzhCg5eRVkbNNXSdW4Ix3h1eTABhxWHYedRcPpY4wee4e7ioUVYk4rQRhqX7
 rDNd922e8YdXBszlugA/HjFkcGISv4RrE6BsuD9roqMZs5tYlnUfK8PLNptdjNQIM7/kw
 vFmX9R9PPssWUMOuFjkxy/1jm2TOpeEY+9R4/uWkpc9/z6tPCyyHXDqUsER0CYhRAm6pT
 V2rbFbDwi+Jq/WhhmvXyUf+97r4XAqHYDRnVpun2yBtrv2FsMAMasGViFnI6EqInpP2OY
 IYHXicWesraJX/q5CCYDx+CNnfeo0AvPYrkqg7tJyJjzcDKpguGXr2jZrrWMkm1h0YA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=HevhGj92; 
 arc=fail smtp.remote-ip=198.175.65.21
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=HevhGj92
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DB8B44080D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 11:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790769260; x=1822305260;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GeY0Og00Ctc2rectWz0SBzcKZ1C5DCc+vmawRY1YOCU=;
 b=HevhGj92lqNQxF3NXaNvz6M81G8s4PTSa7/eflLcwCfbMOnkqb4/n0Ek
 vgwI1ySirw9F2xgtYDE+1gUNlIivKwoYNPg9jiiFSG+4cJGyW2YWm83di
 hXnHOJjR77Gf/8QGBBmxNqnlop/5/svzsgV3CDjWERHQB8L+d+AJpjcpr
 kBmKJsLikre1CIswKIsHfPd0pdNZwV9wvnHdI7N5NqIVMpkXBN7WHQtmm
 fPbf+shk5nW+W7t4GBcFdjliZQxI5on4KLlUU+OyS7VCc8KHwcWHvnj4Y
 Jxq7ABgOwZUdDGdlREHzC2o3fEKRvAOL4TDIXxwRDggvfSSzRnvW1ZLW7 A==;
X-CSE-ConnectionGUID: sKcnYgtOSRecw3wX/6koqg==
X-CSE-MsgGUID: R4mbFPPlSHiOIBjjgFNHFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90364186"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="90364186"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 04:54:18 -0700
X-CSE-ConnectionGUID: 9uUAB6n8SNueDPfM/eQ2Gg==
X-CSE-MsgGUID: FjUoATyGRkej7kD1/wqcgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="279469128"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 04:54:18 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 04:54:17 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 04:54:17 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 04:54:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EaP+cJqH7867nAq/eVQqlLMyebUq8oPOzK8zJvNhxV3sOqVMtHjhxJA6i0uNH5OqQ5cq2eSObElj/S8/IG80xmM0fBzadI0usoCfeYnS1WDzBlatK/9QiP5yc7BmnIoxO/BMteaXAU6ejumvlPQEAG2NrTf5VoCwcMHbJDZn57/gS99Wxg0EWOO4QEqh2YFmiFfu5UNDgYCp8/ttqrEW+/v7GmpqAXeI1SqHhVy1qoNn2xPpzhQlmI75fpdm6lcUGf2BWkwBHjEJa2PuNi4yyyFTeXfhiXga532WFZMmVtOAt7iUG64nv/CsrZZh8SorBoACqUd9JXVGpB3KTpe38Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9Yn7+vvHO9pWvd6Yo5GVMjOVJetm0opeXw6H4KVQXQ=;
 b=P6AjlVIIL3kNCS91fIMcMNRRPzQpsJiILtzGk44Icm+B1wK9tsiC/aVFPx6z4iYMgq8oBAfrjUzglsDbhtCTKFKTrLLzOFlVAyXPFuKJzjH23UWUotFfb3ku6XgxjB6yLHadWLEHMsjC8btfZLLhMLA876FG4+VKaq8gRhPvEshnSZ7oftf/OJUcIWmZbU8dcfIX6snj5/1HIvlso4Wf2zzlkaPeB8Kx4LLbdLST1R4+nLGLChXc0WKOuXy3EiaJgjYVInhuOCk56kLujj07dh/ZpYtGI7+6vWoIsQU+NZUCUsSEdnmmgY8nA0LH4shoLUsaBANk58i0osvXhUq3vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by SN7PR11MB6704.namprd11.prod.outlook.com (2603:10b6:806:267::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 11:54:11 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0451.026; Wed, 30 Sep 2026
 11:54:11 +0000
Message-ID: <a273aa18-511d-4ed8-9c3a-a7eac49b9338@intel.com>
Date: Wed, 30 Sep 2026 13:54:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 1/6] ice: skip stats handling for channel VSIs on
 rebuild
To: <netdev-bot+sashiko@kernel.org>
CC: <netdev@vger.kernel.org>, <kuba@kernel.org>, <anthony.l.nguyen@intel.com>, 
 <aleksandr.loktionov@intel.com>, <mschmidt@redhat.com>,
 <intel-wired-lan@lists.osuosl.org>, <edumazet@google.com>,
 <horms@kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>
References: <20260925132636.123300-2-przemyslaw.kitszel@intel.com>
 <179069064725.434549.10623558636835220604@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <179069064725.434549.10623558636835220604@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P194CA0002.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::33) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|SN7PR11MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: ac0adf6b-5ba1-4e6b-c7b9-08df1ee98aba
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|11063799006|56012099006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: crfoX8JmcrPQeViX4HB5ooYeWy7HIDQ0x3u3Ur0ku+7g5OG4EgX/Ajv5eNHU/GNL2uleMWVtup3k590cQ6yGRpV7+QYRlSAMzqvTpb90livYQPcjPE8URaqAPcSwQSlB4QaIMYEgzZMTDl+SEcH2i9APao7Oe9gGVU8g0u6MWScKKyvrUCpa6Yv8gw/CVT1oy9otM6nMTcVanA+7SiDvCBL/FjolPh+psGZc3s//PVDHNgyfxUlObfGIoX8Pla60CIKLmSmw9TmFJPFk+pSwF4TqoFWHGaFwMtvLcMlldd3eUZaaVPKgvsxbafLjzHdTQ2FPkDBxjhv/PoXA1Xv8qf7YzVbNyVyzmzTcaky7D8cpNuacXkn5UfS9zmvZ9oBqoyTxrTyozIy9MXIYW5EtRv0o+G5SfyqqAx41vqjBfZLoWOYvfUfIKyi/r6cg/rdsmTowsCjYJIm2AxBs8gw/CC+z7Pdcz3AM3/orIVU7gAvs/rHAodSOzhHOLqu5we0FwinM/G16IhjhT6z41AF7O9Y8L+0WSVk2PKgvporsMxWR0Acob+Byg4VyixtQKIdAr2BQ1drEc8kVPadJ50EGnQE85GutYLRCDMs5bHQgk/0xsIHTsoAfZ+WLSiveQi/W
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3ludklwK1BhNi9KNi9RT0N6Q1pSbXAwNGtzdzJmKzI0Q1Q2d1M3b2RtUkdu?=
 =?utf-8?B?MGJqbXQxRXBOV0RzVGdHWEFQZlFJWnR4ZE9BZzE0SHJKNU9MU01FaE9kdXZB?=
 =?utf-8?B?VWJCT3VVUUQrVE91eXBNMmxKYThGOVZ3N3VLNGhVQkg5dGMveHo0bVRoUFV5?=
 =?utf-8?B?a21XRjVVM1lERUptWjhJMzBOampHbkpXazV4VEYyWXVOcUFTT3NJK2hZd2Zi?=
 =?utf-8?B?RklLME9Oa2Zra0xBNDlNK3NlYTVyY2lzUzJnTEJnMDllWkZlQU4wNmRnT1I3?=
 =?utf-8?B?b1R3R1NqM2hqRlhFRVdTVlNSVzNTbFlOb3VXS2tHamorOEJnUkQ2VmFLNEp6?=
 =?utf-8?B?Vmhvbkdhazg4VnkvRHpvaS84SUF0NVRPU0RwM3ZKeXEvSmlDUm50aUMrZ2ht?=
 =?utf-8?B?SUk2ZytoUloxMUpSbDFLSkw2SDIwM1hSbXBuRHNYekVlS2xqbThxaTV3cDRM?=
 =?utf-8?B?TjAxVVdwTWpZRU40dSs2T0t1dDNiMzhGeVRPNlo3L1NBUjZ1cXNvREg1aEg2?=
 =?utf-8?B?ZmM1YXFKUWt6MkFHczB5NWhMT2FBbTV1Sk1rVVRZZ2ZITE16dTBlWFBrbUs5?=
 =?utf-8?B?QlRmNzd3eWpoL2Jjb000a1h4K2o5VzA2UEt6QkhZeGg4SFljK2N0eUhmTENm?=
 =?utf-8?B?NlZhOGZCSTV4RHdqQjlXTU11cE4wK2Fqa3BOUFNlUFRWTEk2WWo1ZjhyWXVt?=
 =?utf-8?B?ckdaWU9CUm1EVWplaUpCNEFRdUoxZktwUlVLczAyUGxRMVZWbmdkdnAva1FX?=
 =?utf-8?B?SitxbDFRYkNvL1JTR0MvUllVcE56cUFBbk9tQmFQZkNka0NQSXBIL2VBSVJ2?=
 =?utf-8?B?MHB3bDJ4VmVSR2wrM0l3cFpOUWxESnZZUEtCUklXWllPSDJRbHZYbEtvVnMx?=
 =?utf-8?B?ZXRLbERYUEVKTWx2TDA4Qi9zUEV4dmxMLzFSZmJRTURRMnFUT0JqMHpoSTUw?=
 =?utf-8?B?eVdTWm1oUnA3MTZiU2k1MFgwTEhwUzcxdkxrdEZvcUlCcGNINjhUTjd6ZWc5?=
 =?utf-8?B?dWNadlE5TU13My9kSHVwTzVXY3VLMngycVlkTUl6T1dIZ0tIWWViQ1hvRmRG?=
 =?utf-8?B?TDhsT004UTdrZVVpdTRxZ3NMRTVJcFFGY2g4UGFLQ1NKd1BwVUNFK1I0RWkz?=
 =?utf-8?B?cmFVNitpSTVQUmc3RXpvbVBUdkx6TGtKc1hHMm9sUG00OHFiWmRUYkMxMHVL?=
 =?utf-8?B?MzNlcm1nZVlKR1hJbGtPWFB6QysxcXpvcmlmVzJGaFVaamFIendIb3E0bkdO?=
 =?utf-8?B?ckVQUllHM043S0xxMEJiaTUzZjQ4Nk9DT3pWYVJtQ1A4SytTbzVkRHFQVWNu?=
 =?utf-8?B?dGYwSUgwUzhud25DWEdZUG51R1d4TW1IV3JyeXg5bklHVEFRRVVZNTNQVkxX?=
 =?utf-8?B?Z3d4VGhxbDlHbitCZEtBZmNlV25GeW5DNUFRNjlhQVkvNUlGUmdZNGU5OUkw?=
 =?utf-8?B?eXAvL0VUd2Y1dEJuSXF5YXZsQ3FsZUFFeXVVSGk0dFB1NnRqRlF1VjVuc0pX?=
 =?utf-8?B?WWcwempIRVFneWEwcDkvMk83ZENudys3T2YvaEJjTWhremJTeTdNMS81VC8z?=
 =?utf-8?B?THNUQXhqR0RMcTdhU0lhMDlzdEhSWHNZVTQvUk1FblJVV1VsSGMrc3hRMExj?=
 =?utf-8?B?M1U4TWZNRTNMQTNzbkpMRFRzNXJnVkRMK29TMXFGTlRQVmhmR1Z5dElkRGRt?=
 =?utf-8?B?ZDA3UDM5aTIxMkYrRGVHbEJ2ZnJUSDR4U0FNV2hGSmpjWE5oektDcGJWTkVT?=
 =?utf-8?B?OVZwVkRZN1JXaGJCK3pwTmhJaVU1TGhNR2x2TjZLaWw3Vm5OcjNwM0Jaa29l?=
 =?utf-8?B?bk5LUGRnMlI2bHVucGY5S0liaUVxem5aMCsrM1J2akg1RzhuVyt2N3g3R1lm?=
 =?utf-8?B?cnBnV0R0UzNyRmdSWkp5eFVvRGZtTyticFBpZVpVY1JGUFluTFVLNkdjMmM5?=
 =?utf-8?B?a2tvTG9kSFhDSUhEQmxwTEhKTFZGUkU0OGx3NlE3a3dEZ1dPZDFRNFRON3hE?=
 =?utf-8?B?Y0hjbk9VMXNyOXBGSk1hWVA0WjlBRzVtRXR6cUI0dU9OMkpiQkNqUnNWalNq?=
 =?utf-8?B?bVpoUWM1Z0ZwbWFYd3JPYjROUTZSVWJVTzI4ZU5pVndFR1MxNmE2Vyt6djVz?=
 =?utf-8?B?OWlieE5adXFNTFNMbkN3OVUvNjB3WkQ4a2NKL3Y3UGdVT1MwS09DYWVROGU3?=
 =?utf-8?B?VEkyUmRoelpUYm41bk9nZTJ2bXlKamExdXJ3Qnl2TzNZV1FLWGVVNXNrVHkz?=
 =?utf-8?B?dHVpSlpOeE9iZFkrelVCMjJ2MjZNUngyM25GblMrNWJjNnpQM21xbXlyVHJj?=
 =?utf-8?B?VVZIT294ZTg3Y091Y2dsVmhmUmFrQWRPcHJRNlArVFlNTy9FUW9iWFRobE0w?=
 =?utf-8?Q?G0unw2b8DVHyOXjM=3D?=
X-Exchange-RoutingPolicyChecked: ysafF0L4G8zfJtjRgyz/SAF0Y9nWuJngl7rR3D0yfNBxU4WK5wNx5kxP1V/dVRQrgS5xqt0JrUmGmClHtqvpjZ9f/ULgZVqyUeTFbXgjxSYJu2rit80N46cQGQgMUPIwou8SdS7P8iECUkPRpZW3GQboQ11HnzTNUL1G3s+xIZn61rUEfcwOJhNnuTBVt34FruFKqrmlfMa1DSHrl+lo58DJPooXc2WvAPAQHuNmoYU1qJLa1HIEQEiN75xUlEh2rZ/g9dzdk5wBTjIVeJxbaYkfZG8vLMZoj762oWAvpiDjgl0iKtWFTdia6cIzNn59P+cq6sK9KNwNrZ1jrGv6rA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0adf6b-5ba1-4e6b-c7b9-08df1ee98aba
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 11:54:11.5802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c68O/kLqlMtEB63j+es+s3m3nFpGh8ughpr3VeZnpbhUL1dzdVvJaXR+P0WCkwMdrhcC0VKRrCgMMTIcEjvCS0IXN7ex2fZZ3y9xE9YqKC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6704
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


Summary: Ignore.

> [Severity: Medium]
> 
> This guard only checks the VSI type. 

yes, this is a fix for a scenario reachable w/o memory failures
added with hope that bots will complain less on other patches

> Can pf->vsi_stats[vsi->idx] also be
> NULL here for a PF, VF or other non-channel VSI?
 > [...]

TLDR: preexising issue for low memory conditions

> 
> A later patch in this series, "ice: rebuild ring stats arrays instead of
> reallocating them in place", appears to fix this

Then please simply ignore the comment now.
Anyway, patch 1 has fixes tag for newer commit than the last.

side comment:
This was (a screenful...) report to suggest minor change in a very small
patch, normally I would do that, but with our current "new world" it
would simply mean delaying me by 3+ days.

 > Sashiko AI review · 
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925132636.123300-1-przemyslaw.kitszel%40intel.com
