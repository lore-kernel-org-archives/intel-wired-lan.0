Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC31C88E77
	for <intel-wired-lan@archiver.kernel.org>; Wed, 16 Sep 2026 14:06:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D6EC40732;
	Wed, 16 Sep 2026 14:06:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6ImPfJMyYJze; Wed, 16 Sep 2026 14:06:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 808324072E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789567573;
	b=T+bsnJm5xDasgpH166S5Qb0E1re8gNPPs4VBoaJ0n+RTOxnm/IvyXlhIbdTZ0wYNRrNB
	 wR67QNBRs/qcRcCAKSzj+ngtcdJbEurIN07/+sgXpvnJsX5/JrCX+jHXhy1/vcNxvdLQg
	 mCKJIREJxfgoL8TM2qiid+K6ll/5UZoDsoYJXINvbOeU4N7yJepkJZ2nRx0MSU1JkDChO
	 Oxh3UKqsgwhxPx9WaOhact160OUpmmKivt5XEPPf+O6mLS4Nu/va40TdiRlHnAeHU8IIT
	 9RU5YNVs4GNjcky0QTwto36DmUD35N1Ct+QsUKVw2Tnys8vObCTXDmpQvhAf+uiT3mg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789567573;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1ppyg6XHGvcBGxEGf9B4sF+LRFUB1IMBECg8BxRq5og=;
	b=NXGIzBIm+0YXfCB6SXH7hnIMCIgaK5igCRMUaQHxzbEo/fKTjpZ4qJsHiuZYKJ4UxsMW
	 BCYYpOWbx85Hx2zFhY8yiR3KC23OTpY04rxvX5dm1ehY1tZ/vpE9/LSfR9DT1sjyQYsnA
	 uw+6aQ0DxCVSabd9Y7/wKkatEYg3FKqJ2DekGxJyPuG6910PsCg5pLZ72vixAjZIhvFVI
	 o93t2TnJ5HZTxzRqfXD1b4V/dqRTL2kwQQhrn0zT6l0103UBbeB5McgrcXCuj31DBkkGk
	 c9ksuxRqHK8Z4unS8yoIL8KMos5yc//DkX1XvP5qRnf9mHguagCZfM0GhEBf8uBEdQA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789567573;
	bh=1ppyg6XHGvcBGxEGf9B4sF+LRFUB1IMBECg8BxRq5og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eP0G+VooA8fqhX0mitTmkYO1ZtJxn5BF+7jrdAO30j4GzjjiFuakDaQRLin8BjRaP
	 xsqIzt2IihCfd8JAFALPOrSgL0TA1Un1j4jNYlsIiYJR7d4EEKWO97iIGttDEbzgqJ
	 O2nAaBC/haoa3b9ocVDPshBEzPGhSLc1pI7dvOPCdQv8yMRaLvpawgN8JgS7EgCiE0
	 7AGXaOip1E9xfSeHh7ek9Bxc6mcBODpwF7gQTkbaSA44cOSRKYtWteV1cbqcBgnn1z
	 C+4fgR/q2k7zSn17/xPffB98fmmn6ggdgB4ZNXv0k2oXnhjDi38uxxM6k6IiHpcJvj
	 PoIllIy2g7ahw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 808324072E;
	Wed, 16 Sep 2026 14:06:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E41E352
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 14:06:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6455980EA8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 14:06:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4VgBDUoIlxRU for <intel-wired-lan@lists.osuosl.org>;
 Wed, 16 Sep 2026 14:06:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C80DA80EA6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789567572;
 b=ImNwEcL4kZdSyA4UOkK/FcyVcSuhcJFocZRF5HzCPm/T+sMd70Ifoh0jxj4/8iLun/QT
 k8R3GcX5A88C6jLaME/1HxbbKQG1J4oOWlC9cDcHsXkDc5UPTyJupHdgt097fw48tJqR0
 c+fRYqbxhxn7pBVw3AWUmnlGb5WLIkTg9QV3pIf/8QdWiMn/FD15koRI1HTBlxAGoPgbU
 CLZ8cfc7Bme+Uy9Wkec7yfFIWgC1idAF2f3BcGVntatnIWbhLd+q1aSiWkc3Hf3d3ZbaY
 qDVtKk/HgmtqQTLak1yvIZGgRShFDukQTWdhYWSnvMEZ/OLFOXAXuTUac+L09/cnOCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789567572;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=1ppyg6XHGvcBGxEGf9B4sF+LRFUB1IMBECg8BxRq5og=;
 b=C1eXZRMIs5sTQ8s7XcFPbNS/kJlCBzbwDI2FFJwIlpEyQxd2CYqeoYMqzWN++5XA9ygG
 Vk5F7WCXYZamiLfpCz0Lgjb8WKHxXn2Rr5aIr3PlX0UQFfaP9P7l5tWXYiy2/jcWk8SDV
 pXyXEttkdTF2BEvAStAiYbhQ3Fr7Y+VeGRoYVAbARKWkhLqTK+1VcWr9nMmT5SV02+9kK
 HEbAltRVORSp0U6kisW3tP1Jqy3zn9xcIgviBqjzZaJ2gGHfIZMrGPc54c8ZIO6Yp6VTs
 6NI916iRDmQr2i8lSumblB1/Vymqr0K1EshhtEqpNfxGjXjLadnkEVtVJJWgZi3T17Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=MeFc8GZH; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=MeFc8GZH
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C80DA80EA6
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 14:06:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BAA2260008;
 Wed, 16 Sep 2026 14:06:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D171F000FF;
 Wed, 16 Sep 2026 14:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789567569;
 bh=1ppyg6XHGvcBGxEGf9B4sF+LRFUB1IMBECg8BxRq5og=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=MeFc8GZHYaEmIe70KimSE1yPvHkOjjK0GZXu4E/Cd0PcXX06lRzUYROGarTn0GDoS
 fjjvq97tKOHHL9JvUf/G9B13BcKk4ZN7yg5DwHdEtUR8n6JVdOffZ21u6rh73mW2z8
 VANGFX8o+90A5Gdg81TDmUELqTXCrb1iJ5y6VOcds4xYQ3QccI4paVWEIbdYH25Cob
 1xiSwOVt00NfN1pWVlulu23Yl8mTEyFcjsidOxd42K7aMjmdgsNMKxOGZD9Cr0+qwP
 cxi3In7lg6ZKvtmrN4X6Agnc9EoU1wRb2nbWcvfr1KMdfPa6QzjSbMc8Rbu4ljK3hm
 2qwPVwz/GgJVw==
Date: Wed, 16 Sep 2026 15:06:05 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Konrad Knitter <konrad.knitter@intel.com>
Subject: Re: [PATCH iwl-net v2 2/3] ice: fix autoneg disable when link
 partner doesn't support AN
Message-ID: <20260916140605.GL51261@horms.kernel.org>
References: <20260915125529.3975723-1-aleksandr.loktionov@intel.com>
 <20260915125529.3975723-3-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915125529.3975723-3-aleksandr.loktionov@intel.com>
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

On Tue, Sep 15, 2026 at 02:55:28PM +0200, Aleksandr Loktionov wrote:
> From: Konrad Knitter <konrad.knitter@intel.com>
> 
> Disabling autonegotiation was silently ignored when autoneg had not yet
> completed (ICE_AQ_AN_COMPLETED was not set), leaving the configuration
> unchanged with no error. This could prevent link from forming if the
> link partner requires non-autoneg mode.
> 
> Extend the condition to also allow disabling autoneg when the link
> partner reports no AN ability (ICE_AQ_LP_AN_ABILITY clear). Gate the
> ICE_AQ_LP_AN_ABILITY check on the link being up so that stale or
> zeroed an_info when link is down does not produce a false positive.
> Introduce the helper ice_autoneg_disable_allowed() to make the check
> explicit.
> 
> Fixes: f1a4a66d2310 ("ice: fix set pause param autoneg check")
> Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

