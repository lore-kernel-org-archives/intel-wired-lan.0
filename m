From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Wed, 28 Oct 2015 16:11:58 +0000
Subject: [Intel-wired-lan] [next PATCH 3/5] fm10k: Cleanup exception
 handling for changing queues
In-Reply-To: <20151027235924.30048.24399.stgit@localhost.localdomain>
References: <20151027235341.30048.46286.stgit@localhost.localdomain>
 <20151027235924.30048.24399.stgit@localhost.localdomain>
Message-ID: <804857E1F29AAC47BF68C404FC60A1847EC6D264@ORSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Tuesday, October 27, 2015 4:59 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH 3/5] fm10k: Cleanup exception
> handling for changing queues
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
>  drivers/net/ethernet/intel/fm10k/fm10k_netdev.c |   17 +++++--
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c    |   55
> ++++++++++++++++++-----
>  2 files changed, 55 insertions(+), 17 deletions(-)

Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>
