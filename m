From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 31 Mar 2017 19:01:30 +0000
Subject: [Intel-wired-lan] [next S65 1/3 v2] i40e: remove client
 instance on	driver unload
In-Reply-To: <20170330074608.52108-1-jeffrey.t.kirsher@intel.com>
References: <20170330074608.52108-1-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040A99D@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Thursday, March 30, 2017 12:46 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next S65 1/3 v2] i40e: remove client instance on
> driver unload
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> When the driver is unloaded, we need to remove the client instance,
> otherwise we leak memory.
> 
> Testing Hints (required if no HSD): On OFED 4.x, do "driverctl unset-
> override".
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: If1e7882ac1f6ce15d004722fafbe31afbe0adc9a
> ---
>  drivers/net/ethernet/intel/i40e/i40e_client.c | 3 +++
>  1 file changed, 3 insertions(+)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


