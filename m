From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 7 Feb 2020 22:34:27 +0000
Subject: [Intel-wired-lan] [PATCH S37 v3 10/15] ice: Remove possible
 null dereference
In-Reply-To: <20200206092013.23388-10-anthony.l.nguyen@intel.com>
References: <20200206092013.23388-1-anthony.l.nguyen@intel.com>
 <20200206092013.23388-10-anthony.l.nguyen@intel.com>
Message-ID: <22f83e0754ef43bab667381164a9b8ac@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 6, 2020 1:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S37 v3 10/15] ice: Remove possible null
> dereference
> 
> Commit 1f45ebe0d8fb ("ice: add extra check for null Rx descriptor") moved
> the call to ice_construct_skb() under a null check as Coverity reported a
> possible use of null skb. However, the original call was not deleted, do so
> now.
> 
> Fixes: 1f45ebe0d8fb ("ice: add extra check for null Rx descriptor")
> Reported-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 2 --
>  1 file changed, 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


