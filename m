From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Jun 2017 23:14:48 +0000
Subject: [Intel-wired-lan] [next PATCH S74-V2 03/10] i40evf: prevent
	VF	close returning before state tranistions to DOWN
In-Reply-To: <20170623082451.32671-3-alice.michael@intel.com>
References: <20170623082451.32671-1-alice.michael@intel.com>
 <20170623082451.32671-3-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAC05D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, June 23, 2017 1:25 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Mogilappagari, Sudheer <sudheer.mogilappagari@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S74-V2 03/10] i40evf: prevent VF close
> returning before state tranistions to DOWN
> 
> From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> 
> Currently i40evf_close() can return before state transitions to
> __I40EVF_DOWN because of the latency involved in processing and receiving
> response from PF driver and scheduling of VF watchdog_task.
> Due to this inconsistency an immediate call to i40evf_open() fails because
> state is still DOWN_PENDING.
> 
> When a VF interface is in up state and we try to add it as slave, The bonding
> driver calls dev_close() and dev_open() in short duration resulting in
> dev_open returning error. The ifenslave command needs to be run again for
> dev_open to succeed.
> 
> This fix ensures that watchdog timer is scheduled immediately after admin
> queue operations are scheduled in i40evf_down(). In addition a wait
> condition is added at the end of i40evf_close so that function wont return
> when state is still DOWN_PENDING. The timeout value is chosen after some
> profiling and includes some buffer.
> 
> Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf.h          |  2 ++
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c     | 19
> +++++++++++++++++++
>  drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c |  4 +++-
>  3 files changed, 24 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


