From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Wed, 28 Oct 2015 16:11:29 +0000
Subject: [Intel-wired-lan] [next PATCH 1/5] fm10k: Cleanup MSI-X
 interrupts	in case of failure
In-Reply-To: <20151027235912.30048.59266.stgit@localhost.localdomain>
References: <20151027235341.30048.46286.stgit@localhost.localdomain>
 <20151027235912.30048.59266.stgit@localhost.localdomain>
Message-ID: <804857E1F29AAC47BF68C404FC60A1847EC6D23F@ORSMSX105.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH 1/5] fm10k: Cleanup MSI-X interrupts
> in case of failure
> 
> If the q_vector allocation fails we should free the resources associated
> with the MSI-X vector table.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_main.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>
