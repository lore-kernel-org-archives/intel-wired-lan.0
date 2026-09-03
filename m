Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD77C624A4
	for <intel-wired-lan@archiver.kernel.org>; Thu,  3 Sep 2026 11:12:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 800FD80BF3;
	Thu,  3 Sep 2026 11:12:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mY8DUXzXePJz; Thu,  3 Sep 2026 11:12:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2C9EA80963
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788433943;
	b=T6cAQ8D9pwHohUy8YnqfLEkXw8Qa+7PlRNag0DvxNz8WL7u0+LJSn4N/MnAjbZVjeHek
	 XCiZiG1lxQcuHFHi7AVADUvj3HLWj8akPUV+RJxjhZZKwBPSawqrPFDixv+SNNnSuA7Ud
	 DBRok86qFBlWESxOINC5z/zhkQyftmL4WX+gcM0Hz2D+2TYQZE8602Ds/I/vjBuFyYVx5
	 HfPiOFcbQGQgSEeGfrW7plRlg8nnIfZiZiGmQlI+h31it6Ofegmw/sReN6ti9Aoy/5hlm
	 yi4UUjEXbjhjSyyL/oTExt5h5NvZFKc4MzbR7eBwI8q/ZFlyUbyNudDQPQ8037st7ag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788433943;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KlBeecTn7vpGQ9ASP6oYD7UZJkpNW1Vd6wM8g7PxlLs=;
	b=MYgBkkGCXlgo5b0+LdeScg+PpOVH0Y6wT4bC9oFmVJ26EJEOLmMhP0HaqgKugzvzYvWx
	 WNi/b6e7UBw1gBuyn0dKX3Ub3ljdq/1Ku1EKwTnAKYvWVWVLRy+h4T2ycjVMCab18gt2c
	 ABLmLb9WD7uhy/1HpH2bXdjVQDIfLaf76ofWdl/hB3PUTcfCkUWbo/Z7LKldaKP6Z9CWr
	 NWxwZP4aXcuixuR2v7MyFRqh5K/A4lYm8da7E3ufIh1/hObT+hq3GzXfijNGr6aMfVZ4w
	 aMwQ7Ox8v2yiSpziri7Iz+zubqVZKlQQaVZeEwVrEHJd15ch1rLeBjo8rfoqb5Eux5w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788433943;
	bh=KlBeecTn7vpGQ9ASP6oYD7UZJkpNW1Vd6wM8g7PxlLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qVRrLER7LjC0g1+0SojvlYpDqLxD08zvpMJHUHJph7Hty+KVxUqweMs92tmBwowfl
	 Ex8S6f7xHMtyf0xmtWUXBMO84WfXWG+20H2lQ/ze0XfwwEj7fVa5kPFx+TaYDK/FRY
	 4+2ToCcNZyqmi1c0vJu4DJQ8nmdzzxp1Kj++xe3gL7dYcLUhUaiaoBqZxlsPVilY3t
	 UTXpMrwYh4eTubichZQY5ufVmgXHJWhJMEi+XZz3vAnN/dzjqhN1PvkdLiycwd82uT
	 ccsu9s3MxBkdAGjmvBuf/paB2OxbTwzQ9LK6nFiFVEAoRdotIILVZ75lEZ5Z86fR1j
	 LsKAS5P6/9vrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C9EA80963;
	Thu,  3 Sep 2026 11:12:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6FE3C498
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 11:12:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 561EA403B7
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 11:12:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j4wNIf7rRFPx for <intel-wired-lan@lists.osuosl.org>;
 Thu,  3 Sep 2026 11:12:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org AD9C240084
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788433940;
 b=FxuuIWumvrCx6iGrZ46Wx6GMHK6Buv+SfkqXYBJP6DSdKS/N32im4mA7LVlTP63e85ni
 d8Kn4UpfMQj11mP7ZDwxxK6VwzcfcKK46EQ97q07e9j6pI/70UOFbBmiQs/Lr8CmHpJwd
 Vzz5SnuFJPMDDFYJN+q5NvGw2kHOQbIHc0gCWYwzxPzcGpuhau2wtyEbXlWc4/AqiFufN
 wZXRL+tgL2KRbUvkuG8kI/11OqurYu8mYH1s6rA/aiyEFJvCCmpEQMX6UYy5t/Z/tZP4d
 237AYv1p9l+gAqjIEHGFhHy54nYWxJg5WDjKzY226y+H6t1DI2RiOI43RaT/8Zm9YDg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788433940;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=KlBeecTn7vpGQ9ASP6oYD7UZJkpNW1Vd6wM8g7PxlLs=;
 b=VGFYCkp793XZIHg1Ial9dzDna2EG+cRAhH33jE7IOKbOO0/8LMsXKROjKNdFdT+bnGwd
 avDD4Xdn5tLREY1HJWQ+epo06ZCAIg6DkY45kuLuWF09hDGXwfgGwLFEZASrVqrSJ+8j3
 HhsZuZvMc2YRE/SN61e35Bs0ZvbaZ1N7KvE68qNDiOTmfagTWAj3qhzltGQHu5RK3rqF2
 RvBj9GAHxE8SDJgBJ0gNQYAcyCuPCdf/hr14a7G4jlszQklAY5/0trhpGvdDQolVd5AQD
 CqRZL8klvzPWplcOWrGmEg24RgraCgBGuCmSWpmw/8qIj561SR1YC5MWDE9FoDQqltA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bfJ0QuJE; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bfJ0QuJE
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AD9C240084
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 11:12:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 73222432B1;
 Thu,  3 Sep 2026 11:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7641F000E9;
 Thu,  3 Sep 2026 11:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788433939;
 bh=KlBeecTn7vpGQ9ASP6oYD7UZJkpNW1Vd6wM8g7PxlLs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bfJ0QuJE3euHnflVrSHYz3OSPSVsSmW8KXYYhBXbHT9PLE0LYtWu6l7/H3jNalAI1
 Lz1AQtBAsCyNA7HPPXosa8opoAup78NHhaCyCLm4Yz6/M33iJWqJ1VJVlcKNDB4dkV
 IOAF97ODByamar7ky4bPntDvtaFxD4Nm/dk5Nds4uMSznAaoa8Lvau7fnPa5DH2pUl
 uDeJe2im9x8dY6Z0OAgZ/xXtDDmomyzzwcnpu0B/D7Ge6q/oQx8QU/ixbl5pvMTEE0
 0xcIOf0xPW/yPieL4uNYMw/7PacGoXx4jj+wj0Q7qwuR0pWmXQiBnm3a9hbibNcJAx
 0DVQUCYRCmctg==
Date: Thu, 3 Sep 2026 12:12:16 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net v2] ice: fix bound parser hash offset before
 reading packet data
Message-ID: <20260903111216.GM396647@horms.kernel.org>
References: <20260824132248.3396788-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824132248.3396788-1-aleksandr.loktionov@intel.com>
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

On Mon, Aug 24, 2026 at 03:22:48PM +0200, Aleksandr Loktionov wrote:
> ice_rt_ho_set() uses the HO register as the starting offset of an
> ICE_GPR_HV_SIZE-byte memcpy() out of rt->pkt_buf. Potentially HO can
> be advanced by user-controlled data reachable through
> ice_parse_raw_rss_pattern() -> ice_parser_run() ->
> ice_parser_rt_execute() -> ice_rt_gpr_set() -> ice_rt_ho_set(), i.e. a
> VF-supplied raw RSS pattern (virt/rss.c), with no bound against the
> size of pkt_buf.
> 
> Clamp HO to the last offset from which ICE_GPR_HV_SIZE bytes can still
> be read out of pkt_buf, deriving the limit from sizeof(rt->pkt_buf)
> so it stays correct if the packet buffer layout changes.
> 
> ice_parser_rt_pktbuf_set() stores the caller's raw pkt_len in
> rt->pkt_len, even though it only ever copies min(ICE_PARSER_MAX_PKT_LEN,
> pkt_len) bytes into rt->pkt_buf. Both ice_parse_raw_rss_pattern() and
> ice_vc_fdir_parse_raw() pass a VF-supplied pkt_len of up to
> VIRTCHNL_MAX_SIZE_RAW_PACKET (1024), i.e. larger than
> ICE_PARSER_MAX_PKT_LEN (504). With HO now capped at 504, the
> "HO >= pkt_len" loop exit in ice_parser_rt_execute() would never be
> reached for such an oversized pkt_len. Store the already-clamped
> length instead, so rt->pkt_len always matches what was actually copied
> into rt->pkt_buf and the loop-exit check remains a valid bound
> regardless of the caller-supplied pkt_len.
> 
> Fixes: 9a4c07aaa0f5 ("ice: add parser execution main loop")
> Cc: stable@vger.kernel.org
> Cc: horms@kernel.org
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v1 -> v2:
> - also clamp rt->pkt_len in ice_parser_rt_pktbuf_set() to the same
>   ICE_PARSER_MAX_PKT_LEN bound already used for the rt->pkt_buf copy,
>   so the "HO >= pkt_len" loop-exit in ice_parser_rt_execute() can't be
>   bypassed by an oversized pkt_len from the raw RSS/FDIR VF paths
>   (reported in review)
> - dropped Przemek's Reviewed-by since the patch changed

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

