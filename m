From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Wed, 28 Oct 2015 16:11:45 +0000
Subject: [Intel-wired-lan] [next PATCH 2/5] fm10k: Cleanup exception
 handling for mailbox interrupt
In-Reply-To: <20151027235918.30048.41769.stgit@localhost.localdomain>
References: <20151027235341.30048.46286.stgit@localhost.localdomain>
 <20151027235918.30048.41769.stgit@localhost.localdomain>
Message-ID: <804857E1F29AAC47BF68C404FC60A1847EC6D251@ORSMSX105.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH 2/5] fm10k: Cleanup exception
> handling for mailbox interrupt
> 
> This patch addresses two issues.
> 
> First is the fact that the fm10k_mbx_free_irq was assuming msix_entries
> was
> valid and that will not always be the case.  As such we need to add a check
> for if it is NULL.
> 
> Second is the fact that we weren't freeing the IRQ if the mailbox API
> returned an error on trying to connect.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c |   13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)

Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>
