Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE207CA600C
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 15:34:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 885EA40B2C;
	Thu,  8 Oct 2026 15:34:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3HBnCVUfeC8r; Thu,  8 Oct 2026 15:34:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D4DF140B2D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791473658;
	b=TqEKOxkBZd1+18mqnhxwT2UMUfJpcUf3mTk3Sc/tmFYCbW6lhhOllRqdYcK+7IJF0du2
	 UETjbQdDKYebsGbpLhXZn+mihUKGP+FBhqc3CM5htfEB9WQzOvxlUS3yfQqelJpDCtt0y
	 vjyovXbvR2W0owUQZIaiTA26Jv/01YKE+phWjBZhcNiTqGQ+LomUWTrPLqsRmAdp1KcSQ
	 inJf8aqYjApOaoUC/nfvCI7fZHnqc4wKzysGkKdoF4eB2ttl6x/OS/VE7HkN9b0kJ/Ulj
	 RF867C9HY1oCBdiwLGE/Hg+wUOjy//IAo1lmEky7qC0ycPfQZaaMMNUJQuIGbzLCmqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791473658;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PmiBS94RhRYgkmDoyiZb+q08HHwxXf0dc7aXfJhOhW8=;
	b=Hw+ja2bSZ5wfKXxRJKqb7hboOeptmIZwZ/VuJUC66sSbiyPGYTZfbDRvXx+73kH6wcel
	 qb4/SkZCNWuiw3v9+CMFTtqyjWW6Hp2SMlUrtOnW0Hc4dxaiBEn8WvX+K/CUh8VAjSNbf
	 GkX9G1IBSG9CTy/oXk7mxoQ4+aBjnWbAAyfdcXBkaF6S39GGOwfAnbj1/IwWKZoGQ+/H1
	 5GnGctzKs7Va1LWPcLYIdGBd0dBtmf3y01EwoQSEMh4wUAteL45LFIcIB9Ypu2dPj67O7
	 od0E3kD0A1pGmKXS2YBMevcnq8r0aLLGqZv/iATHV03vMH3+LlYiWz/uPFeSBt2KCUA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791473658;
	bh=PmiBS94RhRYgkmDoyiZb+q08HHwxXf0dc7aXfJhOhW8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i8fZMHJRzhqHVOTt1ZuyUuqBYKwQpWG3kBQvE+NPJ4Eq2wsPzbF5LsnxOHb5E8TTm
	 8vvBQNI4pdCUD8mUBZnLotP016p7J4/7Dn3p+dGJN0W0u9sfCGV7y2ofVeycuyR3Mn
	 63wGS8UACGlq8+ddJ0saW66SaJNV9F5JJecWt8fVCLzM3HTruQzb5M7iYZffunAoSO
	 Lmjr37bEVHYgqfYk3bEBcrAV7Mh/9/8VAwMkg4qID5z9W+Pv5J1mcB8c7IwKV0NErj
	 SUmYskXi9rQI+v/X1NT5iciaWdIPqYCmYS7zeDS3Q9SGqF8j7L30rYZ8S+PygkYCI1
	 mLOAC+7fc68ug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D4DF140B2D;
	Thu,  8 Oct 2026 15:34:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 515C91A6
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 15:34:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 36ACB40059
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 15:34:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UMBZ2DEJLYmh for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 15:34:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6487240049
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791473656;
 b=AbZqv0SpfP/SD00F5SD6/TtDJlU6hDRPYNagj7NwJtyi02HK4JMlOqkwWXVhsuw6waYJ
 kgDultoCTwZS+wYgcg3borxmqak0/y2ICFqncdsteGlJQQyCY5dSbOomRHCOhsFvQ8T5I
 7pwHIghVyOMAk5z2vha8VGCTRn1UCTie/deCJaOAYwYvkqtJnwK9YALJtj3z/6pSF/tlT
 YNznNwvr475yfDTDuyM6I7HjosLDQNPX8Ac8dAThfP61lgBK+nR7qrwxdnSHjKxzSRfEW
 IgcImad/oWvMhWS9Bfz8xPxhIT5mGWA9yte2F0AYk04v1qQzHBU0JQpLvaca/yzK0DQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791473656;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=PmiBS94RhRYgkmDoyiZb+q08HHwxXf0dc7aXfJhOhW8=;
 b=mvQTXEALeYBa46i50FXcEVNLRfRb2Fau8qXjlSGRafqCdTBkKOYkOomCtQsUFycwjXMC
 tUG6uOqiAg2010x7KoU2pkgOhysXSTf5HN4MphwWbnMweQxsMIFTKLLiL1nGa8512hdwO
 sYOuFkxXGHMqY7gdr2LqS6q6XqU6J7KUrxDatWEtlaKTrgVaYWyNhntnC+IzxkI3dVB8C
 9ng7YTXGrQqgVrNKwQPTP2SlRjct3oLTFFNRS56MRYJmpr1u3Edwxrh2zwQ/xX3rI+6fT
 haXOIdDZ+7IKJsrWyAfobY7YQMahDJdnlo+iXUZG3LRuP2EAmb9ZNbpGpztNpQxsLuQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="hHucIXP/"; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=hHucIXP/
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6487240049
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 15:34:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2C338601EF;
 Thu,  8 Oct 2026 15:34:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9734D1F000FF;
 Thu,  8 Oct 2026 15:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791473653;
 bh=PmiBS94RhRYgkmDoyiZb+q08HHwxXf0dc7aXfJhOhW8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=hHucIXP/GAdTZh7q6uvGIR5RDdIS+phmIrn6PnLM4XJ9LfCLAS4UdUnZ/vXFfZNPr
 2qc5ALdRNel4hS9Cgz5G1eQbddqw9Q7JW2Q8xodK425XiOJ3pQU9X5Nw7wHKLaqtAL
 qjyoaA0PVOyuMgCI+Pw0NCNhmf1hFtlE+UcAbEoOutHG04zE5SDnZKSg4Nw09I3bFm
 l/3/JYfTou2SWYkfst00jHTU9E22Xi2Crtv7pFoWp2plm1pTXD06c3f+cm+YNID0Ma
 /XZ5uF5M1sCBQavi2MYOL6Pt5aPeR+OBkspk62uqRdxNvPHpArR4rHIEQQjcEiin1a
 nQHfFKn1O5fXw==
Date: Thu, 8 Oct 2026 08:34:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 magnus.karlsson@intel.com, pabeni@redhat.com, horms@kernel.org,
 przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com
Subject: Re: [PATCH iwl-net] ice: keep the RSS hash function on
 indirection-only updates
Message-ID: <20261008083412.23481894@kernel.org>
In-Reply-To: <20261007200311.730443-1-maciej.fijalkowski@intel.com>
References: <20261007200311.730443-1-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed,  7 Oct 2026 22:03:11 +0200 Maciej Fijalkowski wrote:
> The ethtool core passes RXH_XFRM_NO_CHANGE (0xff) in input_xfrm when a
> request does not touch the input transformation, e.g. when it only
> rewrites the RSS indirection table. ice_set_rxfh() tests input_xfrm only
> for RXH_XFRM_SYM_XOR, which 0xff has set, so such an update switches the
> VSI to symmetric Toeplitz hashing behind the user's back.
> 
> Once symmetric-xor is reported, the core requires all hashed flow types
> to be symmetric for any following RSS set. The GTP flow types hash on
> the TEID, so every later netlink RSS update fails with "hash field config
> is not symmetric", including the one that would put the indirection
> table back.
> 
> Keep the current hash function when input_xfrm is RXH_XFRM_NO_CHANGE.
> ice_set_rss_hfunc() then returns early and leaves the VSI as it is.
> 
> This has been encountered while trying to run xskxceiver within drv-net
> tests where one of the setup steps was queue pull out of RSS indirection
> table.
> 
> Fixes: 352e9bf23813 ("ice: enable symmetric-xor RSS for Toeplitz hash function")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Hm, not seeing it on the list now but I thought I submitted this 
a while back:

--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3681,10 +3681,10 @@ ice_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
             struct netlink_ext_ack *extack)
 {
        struct ice_netdev_priv *np = netdev_priv(netdev);
-       u8 hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
        struct ice_vsi *vsi = np->vsi;
        struct ice_pf *pf = vsi->back;
        struct device *dev;
+       u8 hfunc;
        int err;
 
        dev = ice_pf_to_dev(pf);
@@ -3703,9 +3703,12 @@ ice_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
                return -EOPNOTSUPP;
        }
 
-       /* Update the VSI's hash function */
-       if (rxfh->input_xfrm & RXH_XFRM_SYM_XOR)
+       if (rxfh->input_xfrm == RXH_XFRM_NO_CHANGE)
+               hfunc = vsi->rss_hfunc;
+       else if (rxfh->input_xfrm & RXH_XFRM_SYM_XOR)
                hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_SYM_TPLZ;
+       else /* input_xfrm == 0; core rejects any other value */
+               hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
 
        err = ice_set_rss_hfunc(vsi, hfunc);
        if (err)

Could you double check if we need the trailing else as well? 
Not 100% sure now if I added it just in case or it mattered :S
