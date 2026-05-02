Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D089ACD13DA
	for <intel-wired-lan@archiver.kernel.org>; Sat,  2 May 2026 17:29:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7E402412DC;
	Sat,  2 May 2026 17:29:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id witQCiXMbFKk; Sat,  2 May 2026 17:29:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 29872412D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777742967;
	bh=GwRX1ujtscnS70hqDe7S/pgRWA4goZ32DFJ/1QLSQu0=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=YNKTf/VkNSG3qn3M81x+k9r4axP0LUfVzbfsbjvKw14m2PCRhqN8X7W+/OX3F1Rzn
	 lGjpxjT1GLtxDOeBB+bDS+a3E6UhthRcQ6HFWxdreRR3Tf6Ivxx3n3pknjHQM/qlnD
	 QXc87NopZXQsBVZhMUogbSa/4tbl+j2PRvxUxzvQ0QQOFSnmyAQKUOyMZVCMbL+q8C
	 BiW4omrR7zhxUCJHEad7WVHgqnVgI6Cmp5EBMb2iziXefw9s6T7tLiR9slqyN05Mgj
	 MtApL9nr10bekNNWflR/Y8vwCKpqUzuzZC2PBCMfN0JqHHBTFFKe5WiEdwuCKRmxAw
	 P9iT2Jet/oRpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 29872412D8;
	Sat,  2 May 2026 17:29:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A13F127
 for <intel-wired-lan@lists.osuosl.org>; Sat,  2 May 2026 17:29:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 57DC140060
 for <intel-wired-lan@lists.osuosl.org>; Sat,  2 May 2026 17:29:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q8qLZIIplDJd for <intel-wired-lan@lists.osuosl.org>;
 Sat,  2 May 2026 17:29:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B854140029
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B854140029
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B854140029
 for <intel-wired-lan@lists.osuosl.org>; Sat,  2 May 2026 17:29:25 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E394A42E5C;
 Sat,  2 May 2026 17:29:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11FDC19425;
 Sat,  2 May 2026 17:29:23 +0000 (UTC)
Date: Sat, 2 May 2026 10:29:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Message-ID: <20260502102923.79d491b1@kernel.org>
In-Reply-To: <20260430094238.987976-4-grzegorz.nitka@intel.com>
References: <20260430094238.987976-1-grzegorz.nitka@intel.com>
 <20260430094238.987976-4-grzegorz.nitka@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1777742964;
 bh=ftq2NTo4CCCcZGp16kODQPjcMmmyZ9VO5wcQNeix6wI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=rvp6Q5pS4d43mbHp/YRnBWWZJul6oHKUx+CQ0BuuCiysilBNgZ0WpdCB13CMfsAOt
 12bcI7HzzN469jRDh8siugt/Qq5c7Jas3FQBWYCse+rA+ff4pf/zpl6y57Lj61m98Q
 Aqriw6Yjt872g0hlbviW3N3WtFRPl13aWiHgUrpebw6KWLHuRb2LSlR1Zo6xhBXj7X
 U2MD0BuC0iIbZD4Ur6usvRYksOudWt+uWuoT7PVpGRxTYKtYd+eyXmwzRz3zTfTM8S
 dIJ78qYRa8doCVb7CYzO6WQSVonyNnvWHa81x/h3X1YP0jSfSNQK5zvP1i8W4MoDIh
 7n7FmX4rojesw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=rvp6Q5pS
Subject: Re: [Intel-wired-lan] [PATCH v7 net-next 3/8] dpll: extend pin
 notifier and netlink events with notification source ID
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
Cc: ivecera@redhat.com, vadim.fedorenko@linux.dev, jiri@resnulli.us,
 edumazet@google.com, Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 netdev@vger.kernel.org, richardcochran@gmail.com, donald.hunter@gmail.com,
 linux-kernel@vger.kernel.org, arkadiusz.kubalewski@intel.com,
 Prathosh.Satish@microchip.com, andrew+netdev@lunn.ch,
 intel-wired-lan@lists.osuosl.org, horms@kernel.org,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com, pabeni@redhat.com,
 davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, 30 Apr 2026 11:42:33 +0200 Grzegorz Nitka wrote:
>  
> -int dpll_pin_delete_ntf(struct dpll_pin *pin)
> +int dpll_pin_delete_ntf(struct dpll_pin *pin,  u64 src_clock_id)

double space
