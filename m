Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AEA6EB7EAC
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Mar 2026 09:51:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21B5240809;
	Wed,  4 Mar 2026 09:51:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3eccq_jRtu9h; Wed,  4 Mar 2026 09:51:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CE6D24082F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772617891;
	bh=3Y3/4nncXETDDmv6axBoywWGZmnTJNxF6rR4Y1Aqyzk=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hQY/3drVEw7nJ3hHEboIvGGrGb73rG58Kg8Swn1YeotNc5Kxo88S3cMU6POmOXHL+
	 ukG8yOuJplmm7EZvTn9Trs9xjkVx0WJRiAaz9Y7yHDjFvXC9u3cVseeHlSelfUXZqK
	 HBTB7SJzKPRoxtyZMskXPwmgNwRGun4yS+kxX8CaKCf1fFIH389dmVPZk9B+rJ5+JN
	 wkdmNthChH9MfJ78ZD4pW3S2Cib3kJBHtvxNHHj0Skv6eZDq7yh5F183AHG1MQpdnh
	 hgnzQ45Rd6qY64McJgnxG/47BmlI+VLw0s95N/cTEs1HR14y6T2Q+92+JEMP08LZuC
	 mEDjtj4GqyO8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE6D24082F;
	Wed,  4 Mar 2026 09:51:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D93B231
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Mar 2026 09:51:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E773260621
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Mar 2026 09:51:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yNh5tCLkSk3o for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Mar 2026 09:51:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.20;
 helo=mgamail.intel.com; envelope-from=jani.nikula@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9D07860606
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9D07860606
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9D07860606
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Mar 2026 09:51:27 +0000 (UTC)
X-CSE-ConnectionGUID: vbCBUtVyQuOnuZYVri+SfA==
X-CSE-MsgGUID: b94iZ1dpTna3chyuRyA3Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="73374997"
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; d="scan'208";a="73374997"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 01:51:26 -0800
X-CSE-ConnectionGUID: 1Ea7458+RDWErlLELTBiWg==
X-CSE-MsgGUID: 4l180kpJQLGqACFXzt6ovw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; d="scan'208";a="217531444"
Received: from krybak-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.246.84])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 01:51:22 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Jonathan Corbet
 <corbet@lwn.net>, Kees Cook <kees@kernel.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, intel-wired-lan@lists.osuosl.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Randy Dunlap <rdunlap@infradead.org>,
 Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260303155310.5235b367@localhost>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
 <33d214091909b9a060637f56f81fb8f525cf433b@intel.com>
 <20260303155310.5235b367@localhost>
Date: Wed, 04 Mar 2026 11:51:18 +0200
Message-ID: <b345179eb9c440c597f6618697b7272a8e383eff@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772617888; x=1804153888;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=hOx8/u7ut1L3MguJoU5B49CkW48rFlxVpSD60jdidy0=;
 b=K1CjejwW8ksE1jLX2x3W2gttpvvwy7aZMDP+x7rjMHuRh8qQhi832fwS
 gcuDQxAlGznpXaBswI8TFhMz21fiJNyA/i6Xzmvb9JDsKfcqaGAX0TLBc
 tqctpaRvVxNSyAbW2wHhtAY9aDl0HNAYt5amGi5UecQXDZ3qCwCEt3CeZ
 pwKIenxrD73YYTBc7nSh4yVzo5L7uUZCRYjTnHnT5IjeN9Z9T/VGbhTS1
 4SuUttHBKnJoAGDz0wwxXzrZJM0qo86wqMZ9oqLnl4HZZXc+6bDZw+9G1
 e1s8vxaczssg1sgc68ZVNYMazs4NEKQI8T0Svk0saKmFtu6H6097cD7Yg
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=K1CjejwW
Subject: Re: [Intel-wired-lan] [PATCH 00/38] docs: several improvements to
 kernel-doc
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, 03 Mar 2026, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> On Mon, 23 Feb 2026 15:47:00 +0200
> Jani Nikula <jani.nikula@linux.intel.com> wrote:
>> There's always the question, if you're putting a lot of effort into
>> making kernel-doc closer to an actual C parser, why not put all that
>> effort into using and adapting to, you know, an actual C parser?
>
> Playing with this idea, it is not that hard to write an actual C
> parser - or at least a tokenizer.

Just for the record, I suggested using an existing parser, not going all
NIH and writing your own.

BR,
Jani.

-- 
Jani Nikula, Intel
