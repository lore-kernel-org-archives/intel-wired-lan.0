From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 31 Mar 2017 19:02:07 +0000
Subject: [Intel-wired-lan] [next S65 2/3 v2] i40e: register existing
 client	on probe
In-Reply-To: <20170330074608.52108-2-jeffrey.t.kirsher@intel.com>
References: <20170330074608.52108-1-jeffrey.t.kirsher@intel.com>
 <20170330074608.52108-2-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040A9AE@ORSMSX101.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next S65 2/3 v2] i40e: register existing client on
> probe
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> In some cases, a client (i40iw) may already be present when probe is called.
> Check for this, and add a client instance if necessary.
> 
> Testing Hints (required if no HSD): On OFED 4.x, run 'driverctl unset-override'
> then reload i40e
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I2009312694b7ad81f1023919e4c6c86181f21689
> ---
>  drivers/net/ethernet/intel/i40e/i40e_client.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


