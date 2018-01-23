From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 23 Jan 2018 22:53:30 +0000
Subject: [Intel-wired-lan] [next PATCH S86-V2 7/8] i40evf: use
 __dev_[um]c_sync routines in .set_rx_mode
In-Reply-To: <20180122170039.14144-7-alice.michael@intel.com>
References: <20180122170039.14144-1-alice.michael@intel.com>
 <20180122170039.14144-7-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A93A123@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, January 22, 2018 9:01 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S86-V2 7/8] i40evf: use
> __dev_[um]c_sync routines in .set_rx_mode
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Similar to changes done to the PF driver in commit 6622f5cdbaf3 ("i40e:
> make use of __dev_uc_sync and __dev_mc_sync"), replace our home-rolled
> method for updating the internal status of MAC filters with __dev_uc_sync
> and __dev_mc_sync.
> 
> These new functions use internal state within the netdev struct in order to
> efficiently break the question of "which filters in this list need to be added or
> removed" into singular "add this filter" and "delete this filter" requests.
> 
> This vastly improves our handling of .set_rx_mode especially with large
> number of MAC filters being added to the device, and even results in a
> simpler .set_rx_mode handler.
> 
> Under some circumstances, such as when attached to a bridge, we may
> receive a request to delete our own permanent address. Prevent deletion of
> this address during i40evf_addr_unsync so that we don't accidentally stop
> receiving traffic.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 95 +++++++++++++++----
> ------
>  1 file changed, 56 insertions(+), 39 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


