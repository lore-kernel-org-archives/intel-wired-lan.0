From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 16 Jul 2020 17:48:03 +0000
Subject: [Intel-wired-lan] [PATCH S50 15/15] ice: fix unused parameter
 warning
In-Reply-To: <20200713205318.32425-15-anthony.l.nguyen@intel.com>
References: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
 <20200713205318.32425-15-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB21455578554800942CF46D568C7F0@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Monday, July 13, 2020 1:53 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S50 15/15] ice: fix unused parameter
> warning
> 
> Depending on PAGE_SIZE, the following unused parameter warning can be
> reported:
> 
> drivers/net/ethernet/intel/ice/ice_txrx.c: In function
> ?ice_rx_frame_truesize?:
> drivers/net/ethernet/intel/ice/ice_txrx.c:513:21: warning: unused
> parameter ?size? [-Wunused-parameter]
>         unsigned int size)
> 
> The 'size' variable is used only when PAGE_SIZE >= 8192. Add
> __maybe_unused to to remove the warning.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


