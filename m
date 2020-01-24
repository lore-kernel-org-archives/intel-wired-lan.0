From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 24 Jan 2020 23:17:09 +0000
Subject: [Intel-wired-lan] [PATCH S37 10/15] ice: Remove possible null
 dereference
In-Reply-To: <20200122152041.41498-10-anthony.l.nguyen@intel.com>
References: <20200122152041.41498-1-anthony.l.nguyen@intel.com>
 <20200122152041.41498-10-anthony.l.nguyen@intel.com>
Message-ID: <04f5bfa20a4d46a382c1fc3c8bc722e8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, January 22, 2020 7:21 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S37 10/15] ice: Remove possible null
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


