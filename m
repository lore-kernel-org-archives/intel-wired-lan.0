From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 5 Sep 2019 20:32:54 +0000
Subject: [Intel-wired-lan] [PATCH] iavf: fix MAC address setting for VFs
 when filter is rejected
In-Reply-To: <20190905063422.28743-1-sassmann@kpanic.de>
References: <20190905063422.28743-1-sassmann@kpanic.de>
Message-ID: <16c6fa96d4b54e93891625668a4352e8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Stefan Assmann
> Sent: Wednesday, September 4, 2019 11:34 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; davem at davemloft.net; sassmann at kpanic.de
> Subject: [Intel-wired-lan] [PATCH] iavf: fix MAC address setting for VFs when
> filter is rejected
> 
> Currently iavf unconditionally applies MAC address change requests. This
> brings the VF in a state where it is no longer able to pass traffic if the PF
> rejects a MAC filter change for the VF.
> A typical scenario for a rejected MAC filter is for an untrusted VF to request
> to change the MAC address when an administratively set MAC is present.
> 
> To keep iavf working in this scenario the MAC filter handling in iavf needs to
> act on the PF reply regarding the MAC filter change. In the case of an ack the
> new MAC address gets set, whereas in the case of a nack the previous MAC
> address needs to stay in place.
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c     | 1 -
>  drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 7 +++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


