From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Jul 2019 17:38:57 +0000
Subject: [Intel-wired-lan] [PATCH S23 v4 12/15] ice: Increase size of
 Mailbox receive queue for many VFs
In-Reply-To: <20190725085541.55104-12-anthony.l.nguyen@intel.com>
References: <20190725085541.55104-1-anthony.l.nguyen@intel.com>
 <20190725085541.55104-12-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40E9BE@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, July 25, 2019 1:56 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S23 v4 12/15] ice: Increase size of Mailbox
> receive queue for many VFs
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently we use the ICE_MBXQ_LEN for both the Mailbox send and receive
> queues that are used to communicate with VFs. This is fine for the send
> queue because the PF driver will lock the queue for every single send, but
> for the Mailbox receive queue every VF is posting to its Mailbox send queue
> and the hardware is then handing the message to the PF on its Mailbox
> receive queue. This becomes a problem with many VFs because it seems to
> overburden the Mailbox receive queue on the PF. Fix this by increasing the
> Mailbox receive queue for the PF to 512 entries.
> 
> The number 512 was determined based on the number of VFs supported by
> the device. We can have a total of 256 VFs so in the worst case this allows the
> VFs to put 2 messages in the PFs Mailbox receive queue at the same time.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h      | 3 ++-
>  drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
>  2 files changed, 4 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


