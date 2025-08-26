Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96FBBCA0FE7
	for <intel-wired-lan@archiver.kernel.org>; Tue, 26 Aug 2025 17:44:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 456D780B96;
	Tue, 26 Aug 2025 17:44:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cr87GsgZkK4p; Tue, 26 Aug 2025 17:44:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B1E6480B99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1756230241;
	bh=hwz9tPEskN3vrLK+ElXbI8irksynmxj6I9mKRy9BtGQ=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=USxTJnhpUcKQ32hotALmIEInrdDgvajeWxez760Vsp8fxycTNOxbzbSOFOaehR8Uc
	 /KHTS0VUWViQhczBFtiH5qlg8rZpKOjwDLQ508GPsZfanHgo2I/B92PVNvGyDqyxaS
	 CqjCzdzSOfZGlnROyAPvp4TpDcFAdMe9EdI0Y1P1/5BmR7ti4mC9HeWNu9/Z7ESnXR
	 hbJw/Kz6MBsmlhWqoq9nqr1vPJeNEWJtz7UXM9c23Rns+WnH9beg4uZx7taxK8KBYZ
	 szqYP+0/n+HnRLxaOepvHruF20QQ+YJ4nePZBxzWVEgV5rUv7vrSHbXUXAlnZD/LZ7
	 0jnIj9I2x2/qg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1E6480B99;
	Tue, 26 Aug 2025 17:44:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 216B8CD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 Aug 2025 17:44:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F31F660650
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 Aug 2025 17:43:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r_87P6y3xUkQ for <intel-wired-lan@lists.osuosl.org>;
 Tue, 26 Aug 2025 17:43:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7DEC2606A7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7DEC2606A7
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7DEC2606A7
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 Aug 2025 17:43:59 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0FE9E405D0;
 Tue, 26 Aug 2025 17:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3041C4CEF1;
 Tue, 26 Aug 2025 17:43:55 +0000 (UTC)
Date: Tue, 26 Aug 2025 18:43:53 +0100
From: Simon Horman <horms@kernel.org>
To: Emil Tantilov <emil.s.tantilov@intel.com>
Message-ID: <20250826174353.GN5892@horms.kernel.org>
References: <20250814234300.2926-1-emil.s.tantilov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814234300.2926-1-emil.s.tantilov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1756230238;
 bh=KfIK98iHpFl4xX9GWUkDuIHW4w9/i0rlce5U2zyUgmA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EmTeOrKEdtWN2VaptUpZAekTyCN40xu2K14Z7938FNUBbPVoO5g9eILWaSgHnLzsG
 /C8M4L1dOmI7vNj16JAcNp4eGaUoqOHxRo4O7f6G0FgMjoaCSWrgNJ78fx9Q5SVghm
 TEwHtdsnXLe/+ZzU5bq5nq4G8g3P8Fg4vFxyFXB5OecYNlQeWjiO3KpSvT2LBm5jsD
 sZlemhGEDdBAAeH/Y9qUfxakNAzBRsKUWpd3vsczrjC4LjP6LblSPt26YFe50JC2xV
 91UPbPq0rzjz8va0VZGgrf6PesVM8Z/WAUpvl8oa4GAV63F3OG9GCpnRfim/MJodr6
 kn1pJV6lPVHPQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=EmTeOrKE
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v3] idpf: set mac type when
 adding and removing MAC filters
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
Cc: pmenzel@molgen.mpg.de, willemb@google.com, decot@google.com,
 netdev@vger.kernel.org, joshua.a.hay@intel.com, Aleksandr.Loktionov@intel.com,
 andrew+netdev@lunn.ch, edumazet@google.com, jianliu@redhat.com,
 anthony.l.nguyen@intel.com, kuba@kernel.org, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, pabeni@redhat.com, davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Aug 14, 2025 at 04:43:00PM -0700, Emil Tantilov wrote:
> On control planes that allow changing the MAC address of the interface,
> the driver must provide a MAC type to avoid errors such as:
> 
> idpf 0000:0a:00.0: Transaction failed (op 535)
> idpf 0000:0a:00.0: Received invalid MAC filter payload (op 535) (len 0)
> idpf 0000:0a:00.0: Transaction failed (op 536)
> 
> These errors occur during driver load or when changing the MAC via:
> ip link set <iface> address <mac>
> 
> Add logic to set the MAC type when sending ADD/DEL (opcodes 535/536) to
> the control plane. Since only one primary MAC is supported per vport, the
> driver only needs to send an ADD opcode when setting it. Remove the old
> address by calling __idpf_del_mac_filter(), which skips the message and
> just clears the entry from the internal list. This avoids an error on DEL
> as it attempts to remove an address already cleared by the preceding ADD
> opcode.
> 
> Fixes: ce1b75d0635c ("idpf: add ptypes and MAC filter support")
> Reported-by: Jian Liu <jianliu@redhat.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

Reviewed-by: Simon Horman <horms@kernel.org>

