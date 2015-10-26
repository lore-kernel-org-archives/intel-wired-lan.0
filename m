From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Date: Mon, 26 Oct 2015 10:09:46 +0900
Subject: [Intel-wired-lan] [PATCH net-next 0/4] Automatic adjustment of
 max frame size
In-Reply-To: <20151023044604.GA5024@aiaiai.jf.intel.com>
References: <20151023044604.GA5024@aiaiai.jf.intel.com>
Message-ID: <562D7D5A.6050400@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2015/10/23 13:46, ND Linux CI Server wrote:
...
> checkpatch.pl has some complaints:
> 
> --------------------------------------------------------------------------------
> 
> checkpatch.pl results for patch "[PATCH 2/4] e1000e: Add ndo_enc_hdr_len"
> 
> WARNING:LONG_LINE: line over 80 characters
> #53: FILE: drivers/net/ethernet/intel/e1000e/netdev.c:3981:
> +		if (adapter->max_frame_size > VLAN_ETH_FRAME_LEN + ETH_FCS_LEN) {
> 
> WARNING:LONG_LINE: line over 80 characters
> #62: FILE: drivers/net/ethernet/intel/e1000e/netdev.c:4000:
> +		if (adapter->max_frame_size > VLAN_ETH_FRAME_LEN + ETH_FCS_LEN) {
> 
> WARNING:LONG_LINE: line over 80 characters
> #71: FILE: drivers/net/ethernet/intel/e1000e/netdev.c:4014:
> +		if (adapter->max_frame_size <= VLAN_ETH_FRAME_LEN + ETH_FCS_LEN) {
> 
> total: 0 errors, 3 warnings, 0 checks, 184 lines checked

I was aware of these warnings but my understanding was that lines
without over 80 characters are not mandatory requirement and a short
overrun can be acceptable, like 81 or 82... Not sure what made me think
so, though.

Anyway, I will fix these warnings.

Thanks,
Toshiaki Makita

