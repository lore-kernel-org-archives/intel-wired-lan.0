From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 2 May 2016 14:33:09 +0000
Subject: [Intel-wired-lan] [PATCH v2] ixgbevf: Change the relaxed
	order	settings in VF driver for sparc
In-Reply-To: <1461279409-248697-1-git-send-email-babu.moger@oracle.com>
References: <1461279409-248697-1-git-send-email-babu.moger@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D5596@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Babu Moger
> Sent: Thursday, April 21, 2016 3:57 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; Nelson, Shannon
> <shannon.nelson@intel.com>; Wyborny, Carolyn
> <carolyn.wyborny@intel.com>; Skidmore, Donald C
> <donald.c.skidmore@intel.com>; Allan, Bruce W <bruce.w.allan@intel.com>;
> Ronciak, John <john.ronciak@intel.com>; Williams, Mitch A
> <mitch.a.williams@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org; babu.moger at oracle.com;
> sowmini.varadhan at oracle.com
> Subject: [Intel-wired-lan] [PATCH v2] ixgbevf: Change the relaxed order
> settings in VF driver for sparc
> 
> We noticed performance issues with VF interface on sparc compared to PF.
> Setting the RX to IXGBE_DCA_RXCTRL_DATA_WRO_EN brings it on far with
> PF. Also this matches to the default sparc setting in PF driver.
> 
> Signed-off-by: Babu Moger <babu.moger@oracle.com>
> Acked-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
> ---
> v2:
>   Alexander had concerns about this negativily affecting other architectures.
>   Added CONFIG_SPARC check so this should not affect other architectures.
> 
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Changes applied correctly, driver builds and passes traffic as expected
sparc platform testing performed by patch originators, no detriment to x86_64 performance.
