From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Jul 2016 14:11:03 +0000
Subject: [Intel-wired-lan] [PATCH v2] ixgbe: fix setup_fc for x550em
In-Reply-To: <20160708001838.11232.8898.stgit@localhost6.localdomain6>
References: <20160708001838.11232.8898.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9EA4AC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Thursday, July 07, 2016 5:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2] ixgbe: fix setup_fc for x550em
> 
> mac->ops.setup_fc can be null for backplanes which can cause the driver
> to crash on load.
> 
> v2 - corrected Reported-by
> 
> Reported-by: Patrick McLean <patrickm@gaikai.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
No crash/panic on init, unload and reload.
