From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 17 May 2016 17:42:12 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Fix errors resulted while
 turning	off TSO
In-Reply-To: <1463427653-8148-1-git-send-email-tushar.n.dave@oracle.com>
References: <1463427653-8148-1-git-send-email-tushar.n.dave@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D696C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Tushar Dave
> Sent: Monday, May 16, 2016 12:41 PM
> To: intel-wired-lan at lists.osuosl.org; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; Nelson, Shannon
> <shannon.nelson@intel.com>; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; netdev at vger.kernel.org; Wyborny, Carolyn
> <carolyn.wyborny@intel.com>; Skidmore, Donald C
> <donald.c.skidmore@intel.com>; Williams, Mitch A
> <mitch.a.williams@intel.com>; Allan, Bruce W <bruce.w.allan@intel.com>;
> Ronciak, John <john.ronciak@intel.com>
> Cc: sowmini.varadhan at oracle.com; Tushar Dave
> <tushar.n.dave@oracle.com>
> Subject: [Intel-wired-lan] [PATCH] i40e: Fix errors resulted while turning off
> TSO
> 
> On systems with 128 CPUs, turning off TSO results in errors,
> 
> i40e 0000:03:00.0: failed to get tracking for 1 vectors for VSI 400, err=-12 i40e
> 0000:03:00.0: Couldn't create FDir VSI i40e 0000:03:00.0: i40e_ptp_init: PTP
> not supported on eth0 i40e 0000:03:00.0: couldn't add VEB, err
> I40E_ERR_ADMIN_QUEUE_ERROR aq_err I40E_AQ_RC_ENOENT i40e
> 0000:03:00.0: rebuild of switch failed: -1, will try to set up simple PF
> connection i40e 0000:03:00.0 eth0: adding 00:10:e0:8a:24:b6 vid=0
> 
> Enabling FD_SB without checking availability of MSI-X vector is the root
> cause. This change adds necessary check.
> 
> Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |    1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c |    8 ++++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
