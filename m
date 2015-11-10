From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Tue, 10 Nov 2015 22:23:39 +0000
Subject: [Intel-wired-lan] [next PATCH v2 3/5] fm10k: Cleanup
	exception	handling for changing queues
In-Reply-To: <1447177230-21312-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1447177230-21312-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <804857E1F29AAC47BF68C404FC60A1847EC96F71@ORSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Tuesday, November 10, 2015 9:41 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Alexander Duyck
> Subject: [Intel-wired-lan] [next PATCH v2 3/5] fm10k: Cleanup exception
> handling for changing queues
> 
> From: Alexander Duyck <aduyck@mirantis.com>
> 
> This patch is meant to cleanup the exception handling for the paths where
> we reset the interrupts and then reconfigure them.  In all of these paths
> we had very different levels of exception handling.  I have updated the
> driver so that all of the paths should result in a similar state if we
> fail.
> 
> Specifically the driver will now unload the mailbox interrupt, free the
> queue vectors and MSI-X, and then detach the interface.
> 
> In addition for any of the PCIe related resets I have added a check with
> the hw_ready function to just make sure the registers are in a readable
> state prior to reopening the interface.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
> v2: cleaned up trailing whitespace
> 
>  drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 17 ++++++--
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c    | 53
> +++++++++++++++++++------
>  2 files changed, 54 insertions(+), 16 deletions(-)

Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>

