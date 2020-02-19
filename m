From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 19 Feb 2020 19:41:18 +0000
Subject: [Intel-wired-lan] [PATCH S39 v2 08/15] ice: Support XDP UMEM
 wake up mechanism
In-Reply-To: <20200213213129.34023-7-anthony.l.nguyen@intel.com>
References: <20200213213129.34023-1-anthony.l.nguyen@intel.com>
 <20200213213129.34023-7-anthony.l.nguyen@intel.com>
Message-ID: <8a8b9ea863f34eb8ad9c16f4faea8fae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 13, 2020 1:31 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S39 v2 08/15] ice: Support XDP UMEM
> wake up mechanism
> 
> From: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
> 
> Add support for a new AF_XDP feature that has already been introduced in
> upstreamed Intel NIC drivers. If a user space application signals that it might
> sleep using the new bind flag XDP_USE_NEED_WAKEUP, the driver will then
> set this flag if it has no more buffers on the NIC Rx ring and yield to the
> application. For Tx, it will set the flag if it has no outstanding Tx completion
> interrupts and return to the application.
> 
> Signed-off-by: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_xsk.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


