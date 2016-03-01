From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 1 Mar 2016 19:16:16 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: add a callback to set the
 maximum	transmit bitrate
In-Reply-To: <1453919610-8197-1-git-send-email-atomnuker@gmail.com>
References: <1453919610-8197-1-git-send-email-atomnuker@gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99C18C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Rostislav Pehlivanov
> Sent: Wednesday, January 27, 2016 10:34 AM
> To: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>;
> Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nelson, Shannon
> <shannon.nelson@intel.com>
> Cc: Rostislav Pehlivanov <atomnuker@gmail.com>
> Subject: [Intel-wired-lan] [PATCH] ixgbe: add a callback to set the maximum
> transmit bitrate
> 
> This commit adds a callback which allows to adjust the maximum transmit
> bitrate the card can output. This makes it possible to get a smooth traffic
> instead of the default burst-y behaviour when trying to output e.g. a video
> stream.
> 
> Much of the logic needed to get a correct bcnrc_val was taken from the
> ixgbe_set_vf_rate_limit() function.
> 
> Signed-off-by: Rostislav Pehlivanov <atomnuker@gmail.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  | 31
> ++++++++++++++++++++++++++
> drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |  2 +-
> drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h |  1 +
>  3 files changed, 33 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Traffic rate smooth as expected
