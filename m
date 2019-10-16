From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 16 Oct 2019 16:24:15 +0000
Subject: [Intel-wired-lan] [PATCH S31 13/15] ice: Get rid of
 ice_cleanup_header
In-Reply-To: <20191009140953.14087-13-anthony.l.nguyen@intel.com>
References: <20191009140953.14087-1-anthony.l.nguyen@intel.com>
 <20191009140953.14087-13-anthony.l.nguyen@intel.com>
Message-ID: <dea06992cfcf49d9ae4e4d0a3de7db5d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, October 9, 2019 7:10 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S31 13/15] ice: Get rid of
> ice_cleanup_header
> 
> From: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
> 
> ice_cleanup_hdrs() has been stripped of most of its content, it only serves as
> a wrapper for eth_skb_pad(). We can get rid of it altogether and simplify the
> codebase.
> 
> Signed-off-by: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 27 ++---------------------
>  1 file changed, 2 insertions(+), 25 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


