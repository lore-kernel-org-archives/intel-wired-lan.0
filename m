Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E789BC3DA6E
	for <intel-wired-lan@archiver.kernel.org>; Wed,  3 Jan 2024 16:03:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 78EF9400D9;
	Wed,  3 Jan 2024 16:03:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 78EF9400D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1704297819;
	bh=72/jrflfX9QyKhRf+2tovaTy3tKCYO3arBi8VRaq8jc=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=lrwUgLZpenBkAPfujcHs9kMFddyqZF13Mll9R+YAe4xcHl2iGfkkgsfTpIseU2zSF
	 NoF01B0PhgBmt3mwWo/tpgf4cuK4Tr64UOCf3CQxirrydGOBl90NOGIQVp2y1iA1cO
	 NTE3tWWfR7H5QCs4z/JJsPYm2WwTpITg27VP9zwWfhhrDAfxZni2JTVOx9QK6WREJ+
	 DTZip73rYm2azPlu/qqkhV3YiGk0GwWqnsxi9VKFvIT+Xk+o4Qw7JjWiPgiH9yp7IZ
	 bCkLp5s8uEuEnhQji2O1xg4cpG+slyBIqAmVyquZS/cQ+H2yMP5lgn1wQc4l2t0F9s
	 OdWZBw/bP5tLA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DVmh9UBmYc3U; Wed,  3 Jan 2024 16:03:39 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id B0AAC40391;
	Wed,  3 Jan 2024 16:03:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B0AAC40391
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 4921B1BF3F3
 for <intel-wired-lan@lists.osuosl.org>; Wed,  3 Jan 2024 16:03:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 210306102E
 for <intel-wired-lan@lists.osuosl.org>; Wed,  3 Jan 2024 16:03:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 210306102E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8KBS082TtLG3 for <intel-wired-lan@lists.osuosl.org>;
 Wed,  3 Jan 2024 16:03:36 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C7DC060C34
 for <intel-wired-lan@lists.osuosl.org>; Wed,  3 Jan 2024 16:03:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C7DC060C34
Received: from [172.23.38.41] (unknown [85.119.46.8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1B72C61E5FE03;
 Wed,  3 Jan 2024 17:02:35 +0100 (CET)
Message-ID: <0187c784-9eb7-4699-a3d0-2ed11c4e7326@molgen.mpg.de>
Date: Wed, 3 Jan 2024 17:02:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>
References: <20240103102458.3687963-1-arnd@kernel.org>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240103102458.3687963-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Intel-wired-lan] [PATCH] ice: fix building withouto XDP
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Paolo Abeni <pabeni@redhat.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Arnd Bergmann <arnd@arndb.de>,
 Larysa Zaremba <larysa.zaremba@intel.com>, netdev@vger.kernel.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Simon Horman <horms@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, intel-wired-lan@lists.osuosl.org,
 Piotr Raczynski <piotr.raczynski@intel.com>,
 Amritha Nambiar <amritha.nambiar@intel.com>, linux-kernel@vger.kernel.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Dear Arnd,


Thank you for your patch. There is a small typo in the commit message 
summary: withouto → without


Kind regards,

Paul
