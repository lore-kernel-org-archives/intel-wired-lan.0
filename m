Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4119CCDB474
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Oct 2023 00:34:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C214C80DA5;
	Wed, 18 Oct 2023 00:34:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C214C80DA5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1697589297;
	bh=v73OVB1JVyc5ZSyFXFdQPHkShb8Tb8doulWAIzCYtR8=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=ohQyR7MPf2YL7XgBdbzCKvTZLoQgVJ1vjHePuDxEDcmT7EK/GXqZLERya3JlKNgy6
	 /lzulZYw1UFpm7d1eY4Vp78slS+mhMH9yoNJBZd+Mvk7g1SslIXLAQsfeo+AD/Qoun
	 dFLWJobJtPss+qc9V5OPXMRF5nnHemxil51QVdoVeu7zNwpc33SYXN3I1IXhhxCDQo
	 F1yFOS/kym68QiIZkwnfqp3B2Z7ulaUMqVwnDkV7hdQw8CmenWwo5yUNoZS+3TjqSO
	 J0Id4eBKU5rw0ZBawFNppfyrBzHrhwnjtkXVHF47JQdskU+D18IkLkvKS2q5CjVih6
	 opZV+LzzN/PTg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uZMX750-xB5N; Wed, 18 Oct 2023 00:34:57 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id DCE47813D1;
	Wed, 18 Oct 2023 00:34:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DCE47813D1
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 0BFA61BF982
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Oct 2023 00:34:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E3D81813D1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Oct 2023 00:34:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E3D81813D1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bsoQ4eQnwA1t for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Oct 2023 00:34:55 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1BA2480DA5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Oct 2023 00:34:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1BA2480DA5
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5EA4B61582;
 Wed, 18 Oct 2023 00:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75D7C433C7;
 Wed, 18 Oct 2023 00:34:49 +0000 (UTC)
Date: Tue, 17 Oct 2023 17:34:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Message-ID: <20231017173448.3f1c35aa@kernel.org>
In-Reply-To: <CAKgT0Ud4PX1Y6GO9rW+Nvr_y862Cbv3Fpn+YX4wFHEos9rugJA@mail.gmail.com>
References: <20231016154937.41224-1-ahmed.zaki@intel.com>
 <20231016154937.41224-2-ahmed.zaki@intel.com>
 <8d1b1494cfd733530be887806385cde70e077ed1.camel@gmail.com>
 <26812a57-bdd8-4a39-8dd2-b0ebcfd1073e@intel.com>
 <CAKgT0Ud7JjUiE32jJbMbBGVexrndSCepG54PcGYWHJ+OC9pOtQ@mail.gmail.com>
 <14feb89d-7b4a-40c5-8983-5ef331953224@intel.com>
 <CAKgT0UfcT5cEDRBzCxU9UrQzbBEgFt89vJZjz8Tow=yAfEYERw@mail.gmail.com>
 <20231016163059.23799429@kernel.org>
 <CAKgT0Udyvmxap_F+yFJZiY44sKi+_zOjUjbVYO=TqeW4p0hxrA@mail.gmail.com>
 <20231017131727.78e96449@kernel.org>
 <CAKgT0Ud4PX1Y6GO9rW+Nvr_y862Cbv3Fpn+YX4wFHEos9rugJA@mail.gmail.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1697589290;
 bh=s4c03elfdERBy4zrtDjx6kCMTKW/KWYHfHp4XQimaus=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=sczVb/vvpGtFXEO6D/aIRYs6n+ceGsHSEAVInJOS4taE/yqBzcR7cEMIqfeEVMzdM
 Jgxk85NBx9FHN/Rac39XbEFHtqeXPl7CJ/T5L1Nck9hjW9I4goczq3S+81K6XN/XS/
 cMqi0l/3qiDUf4UbOedAOOwY6Amm9U/Uvma2dzr0Q5RZPnPCwo6qomMiloQB7EzWMg
 +M9ipIhle6TQmYJJ8rt5Gccm3F6Mz0InbfExeduA0vZiVd2ff7jlwPyP/q5JBAbA+T
 AvypWJ1+EklpA2wbdzRXaIzVj/+P+S7VBcos/cnI9wsZal3ZUNex4+vKiNk1Q8ci3Z
 T8QBNTWEKNIcA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=sczVb/vv
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 1/6] net: ethtool: allow
 symmetric-xor RSS hash for any flow type
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
Cc: mkubecek@suse.cz, andrew@lunn.ch, willemdebruijn.kernel@gmail.com,
 Wojciech Drewek <wojciech.drewek@intel.com>, corbet@lwn.net,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, jesse.brandeburg@intel.com,
 Ahmed Zaki <ahmed.zaki@intel.com>, edumazet@google.com,
 anthony.l.nguyen@intel.com, horms@kernel.org, vladimir.oltean@nxp.com,
 intel-wired-lan@lists.osuosl.org, pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, 17 Oct 2023 13:41:18 -0700 Alexander Duyck wrote:
> I am thinking of this from a software engineering perspective. This
> symmetric-xor aka simplified-toeplitz is actually much cheaper to
> implement in software than the original. As such I would want it to be
> considered a separate algorithm as I could make use of something like
> that when having to implement RSS in QEMU for instance.

That's exactly why XOR and CRC32 _algorithms_ already exist.
CPUs have instructions to do them word at a time. 

	ETH_RSS_HASH_TOP_BIT, /* Configurable RSS hash function -
	Toeplitz */
	ETH_RSS_HASH_XOR_BIT, /* Configurable RSS hash function - Xor */
	ETH_RSS_HASH_CRC32_BIT, /* Configurable RSS hash function - Crc32 */

If efficient SW implementation is important why do some weird
bastardized para-toeplitz and not crc32? Hashes fairly well
from what I recall with the older NFPs. x86 has an instruction
for it, IIRC it was part of SSE but on normal registers.

> Based on earlier comments it doesn't change the inputs, it just
> changes how I have to handle the data and the key. It starts reducing
> things down to something like the Intel implementation of Flow
> Director in terms of how the key gets generated and hashed.

About Flow Director I know only that it is bad :)
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
