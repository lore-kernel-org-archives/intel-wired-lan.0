From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 31 Mar 2017 19:02:41 +0000
Subject: [Intel-wired-lan] [next S65 3/3 v2] i40e: close client on
 remove	and shutdown
In-Reply-To: <20170330074608.52108-3-jeffrey.t.kirsher@intel.com>
References: <20170330074608.52108-1-jeffrey.t.kirsher@intel.com>
 <20170330074608.52108-3-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040A9BD@ORSMSX101.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next S65 3/3 v2] i40e: close client on remove and
> shutdown
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> When the driver is removed or shut down, close any attached clients (i.e.
> i40iw). This prevents a panic seen sometimes on forced driver removal or
> system shutdown when iWarp is running.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I4f6161e5a73ffbb2fd5883567b007310302bfcb5
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


