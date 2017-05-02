From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 2 May 2017 19:22:36 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Add error checking to setting
 VF	MAC
In-Reply-To: <20170428194203.24106-1-anthony.l.nguyen@intel.com>
References: <20170428194203.24106-1-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA1F7F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, April 28, 2017 12:42 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Add error checking to setting VF
> MAC
> 
> Currently, when setting a VF MAC address there are no error checks to
> ensure that the MAC filter was successfully added.  This patch adds additional
> error checks, reporting, and propagation of errors.  It also will not set the
> MAC address unless adding the MAC filter was successful.
> 
> With these changes, setting the mac address to zeros can no longer call
> ixgbe_set_vf_mac() as adding a zero MAC address filter is not valid.
> Instead directly delete the filter and, if successful, clear the MAC address.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 54
> +++++++++++++++++++-------
>  1 file changed, 41 insertions(+), 13 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


