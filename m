From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 26 May 2020 20:24:38 +0000
Subject: [Intel-wired-lan] [PATCH S44 07/14] ice: Refactor Rx checksum
 checks
In-Reply-To: <20200516004226.4795-7-anthony.l.nguyen@intel.com>
References: <20200516004226.4795-1-anthony.l.nguyen@intel.com>
 <20200516004226.4795-7-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB165987DC85CB7F77E79E3CD88CB00@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:42 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S44 07/14] ice: Refactor Rx checksum
> checks
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> We don't need both rx_status and rx_error parameters, as the latter is a
> subset of the former. Remove rx_error completely and check the right bit in
> rx_status.
> 
> Rename rx_status to rx_status0, and rx_status_err1 to rx_status1. This
> naming more closely reflects the specification.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 27 ++++++++-----------
>  1 file changed, 11 insertions(+), 16 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


