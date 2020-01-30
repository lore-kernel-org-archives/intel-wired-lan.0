From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 30 Jan 2020 22:47:35 +0000
Subject: [Intel-wired-lan] [PATCH S39 08/15] ice: Support XDP UMEM wake
 up mechanism
In-Reply-To: <20200127085927.13999-8-anthony.l.nguyen@intel.com>
References: <20200127085927.13999-1-anthony.l.nguyen@intel.com>
 <20200127085927.13999-8-anthony.l.nguyen@intel.com>
Message-ID: <8f5d3ee11452418b943c49e02449de1d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Monday, January 27, 2020 12:59 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S39 08/15] ice: Support XDP UMEM wake
> up mechanism
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


