Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485D8C98321
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 17:23:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF59640BC8;
	Fri, 25 Sep 2026 17:23:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AXrG7IUzdYD0; Fri, 25 Sep 2026 17:23:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7199B40A85
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790357036;
	b=S8H1mXF+z8f1lPa8jmZM119tBL1/g+alUGKPMmgSeHOEklvW6R60jpR4mcZPEFXn1hjo
	 h6i/aYZN4zU0nxVXj9GVcb/S0yu6S8mQZ9RMXsvNHlTbsoAQeehCvb8F+R1EF8SI9CaOF
	 vG4Df/A9B+MhHbI4/NKpGHs4NKLhK05cPVbLyG31P/egTSB59l+fysvHvW3sz03ONNzln
	 ndW0eTFoN7qpXbjOsLchdyCYXGfFjBTzxxTlmmI/ha2aNLT1QHIAAcDNIG1AO4F06N0ta
	 q2YGSWSNfLF0vUL64z7OgBLa+pjSZOzWddJjrGLD2pOWL1kNZyX15+fWkS9mCt8xXgA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790357036;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zoyaNA6T61X6vQ7cMUVM+bxkczwSb4dnx4amKb8ytNk=;
	b=H7R6beZCyZXW+RixRM5EKZiI/pJGXfCy4x1iBTQZDLLNn9/2AlKgHtT4ErvA9qzmLd7n
	 gBJYgNmXhdpZfhIn5wp66nSsMMhfeq/tvqiXJkeQb2Qj7VhXqtjSStasf/VneW+3Qeq5u
	 QERB3+aL9X/G2tbLprmymKQpmq71NnceuxJmMiWVoPorlxRy2M5kXVdRHrgntraBHS2tB
	 dpFha2hKkJUqo1cd7czxG3KJYD1WTIBcEX6rZ4S/zO09KZlrhDG6oWWyNlnDEhKpKEtKl
	 hAER3rQ4KGSJdTcxh8GX8sIWQMnb3DPGO6jg+9fC26OhwDXSToGdzSlrbP4MzQ+coRg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790357036;
	bh=zoyaNA6T61X6vQ7cMUVM+bxkczwSb4dnx4amKb8ytNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tN5ysCBTJvT4lr2N80m++Mif+Jy9fNSKn1P2dILhfltiy/38kQdiCpC4cWer2iPfc
	 4gEUbWxJVDxzHCeks4FziHJu+WAFOzznRDLtt1ZicPsME1r1eBk4uBTzypEOXp6Prt
	 ih9POzqGqVRvXa65zjveuBIZ1Yxs+1a+aAfRxIYYw2tDMZ5lZ2ByqXL9Xxc0xBSSyZ
	 iIjy6FH8zuGsJ84RYHossB2tPFlMstNwYzgC05cK8T5kRD78YaRhylGJRh3ojOvhsb
	 del8+Qa/zwlQF6Mb22icaEbp4Nvufi28RPtCF9O+QajGyDA6GlhkpmCsS1aANVllT0
	 BsptNJfJKBTuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7199B40A85;
	Fri, 25 Sep 2026 17:23:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A526CF46
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 17:23:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 96F9A60D7F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 17:23:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MpjBiIqvpMT7 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 17:23:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org ECFD460D7E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790357035;
 b=HxVllk4HZImmBTne9z/wg7P1UV2eyECrzjA9Qz0AooFufrna7AqHmvka64CKyuVCLiSg
 aWeIATe54Y/lb8tuEXnyXM98YSjvQxvt6Ml70qRx6IvHOJ2Ej0NSVNBlLyE3zlWtzrX6B
 kNrDcdObhwZXpothcO6Koed3aReH169Xtlk5Pncd1cOufDy5k82lAEHpj19Fk14dIxLpa
 ZMbrKpMkSeaOMZ9WAuAIFKqO/jy9wdtkd0bLOQpvK6tnZet8HnaUBVFpG/iOrrL7ZTZDw
 7TsGx8T9aGw4CTV/tHTbv+65uVi3sUiy6iZIzKHyc1PkleIRxmSxpOB4shTEnYInwdg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790357035;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=zoyaNA6T61X6vQ7cMUVM+bxkczwSb4dnx4amKb8ytNk=;
 b=nn0KCuD6kZEpS17b8kA99ojCP5IXdm8t0g158leNceoZpxaBKWiC8EX0A9o1bKzG2+LK
 HjZY22eD4baxhVln6kitNjMolPT/rChZgYmDjhm9MzaI9o1PAemP6siLvTqN5ohzdnAnE
 TWXTB2dDpmF++ugcDAKVtRpdTteLBxJ80dpbj/36OawTupNbBZQnxkWeHcpMFQLTB7T5k
 Oyaw/hDVXmDMfJ3OtoNF/dp7W301pFSoqPzMAQzPAXIjolLgb3WwyGF8V8kugK2Hk5AKF
 v6bQzhvYHe0ovXOpB8waBC7oCS8SfSHCaA1d9QmjYXyPR3mrEhD5vyK3jLtkqDLx7dQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="N6UNWIR/"; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=N6UNWIR/
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ECFD460D7E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 17:23:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0FE74434D0;
 Fri, 25 Sep 2026 17:23:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E381F00893;
 Fri, 25 Sep 2026 17:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790357033;
 bh=zoyaNA6T61X6vQ7cMUVM+bxkczwSb4dnx4amKb8ytNk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=N6UNWIR/ZRNqMlzQmyZitR6+n/yh741evX+jHCccwsDcg+Z2Jgw2QA0PmA3p2fOlc
 bADggcbepsmFcHBbTpTf6/CMyOE0QlSktqAw2DoKV9o8W2kjWwXJKWDyZm6nh8gtr+
 mlTfIuAage+ZdrWckz1iXGouBf0hfb8+25dew4Dsqc9X9itcigmFx52Zm0AxMsIteP
 /CLx77bOHbnjCdfWYxZJtthiBPGvsAOTjNEZCwVQy3D1Wa68DCrha/2WMVFdxIhtbR
 +TGtuG4XJJ8ZS/mV4T1eQYqr5ZFgIdc3169jxGtvSuaXMAXaSFKh9MWf1DZIAJBkdY
 QXRPcPTySuNKA==
Date: Fri, 25 Sep 2026 18:23:51 +0100
From: Simon Horman <horms@kernel.org>
To: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net v2 3/4] ixgbe: Restore previous XDP program on
 ixgbe_setup_tc() failure
Message-ID: <20260925172351.GU13925@horms.kernel.org>
References: <20260922113558.2288111-1-sergey.temerkhanov@intel.com>
 <20260922113558.2288111-4-sergey.temerkhanov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922113558.2288111-4-sergey.temerkhanov@intel.com>
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

On Tue, Sep 22, 2026 at 11:35:57AM +0000, Sergey Temerkhanov wrote:
> When enabling or disabling an XDP program requires a queue
> reconfiguration, ixgbe_xdp_setup() swaps in the new program with
> xchg() before calling ixgbe_setup_tc(). If ixgbe_setup_tc() fails,
> the adapter was left pointing at the new program even though the
> reconfiguration did not complete, leaking the reference to the old
> program and leaving inconsistent state.
> 
> ixgbe_setup_tc() may have already reconfigured the queues for the new
> program before failing. The XDP ring layout then no longer matches the
> previous program, for example when removing a program has removed the
> XDP TX rings. Restore the previous program and rebuild the queues for
> it so adapter->xdp_prog remains consistent with the ring configuration.
> Otherwise, a later open could run XDP without XDP TX rings and
> dereference a NULL ring. ixgbe_setup_tc() handles the device having
> been left down by the failed reconfiguration.
> 
> Fixes: 3fe1d0a48d21 ("ixgbe: XDP: fix checker warning from rcu pointer")
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

