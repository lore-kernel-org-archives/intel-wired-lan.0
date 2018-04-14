From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 14 Apr 2018 02:16:45 +0000
Subject: [Intel-wired-lan] [next-queue PATCH v7 01/10] igb: Fix not
 adding filter elements to the list
In-Reply-To: <20180410174959.18757-2-vinicius.gomes@intel.com>
References: <20180410174959.18757-1-vinicius.gomes@intel.com>
 <20180410174959.18757-2-vinicius.gomes@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C83A165@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-
> owner at vger.kernel.org] On Behalf Of Vinicius Costa Gomes
> Sent: Tuesday, April 10, 2018 10:50 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Gomes, Vinicius <vinicius.gomes@intel.com>; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; netdev at vger.kernel.org; Sanchez-Palencia,
> Jesus <jesus.sanchez-palencia@intel.com>
> Subject: [next-queue PATCH v7 01/10] igb: Fix not adding filter elements to
> the list
> 
> Because the order of the parameters passes to 'hlist_add_behind()' was
> inverted, the 'parent' node was added "behind" the 'input', as input
> is not in the list, this causes the 'input' node to be lost.
> 
> Fixes: 0e71def25281 ("igb: add support of RX network flow classification")
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested by: Aaron Brown <aaron.f.brown@intel.com>
