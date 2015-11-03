From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 3 Nov 2015 20:45:55 +0000
Subject: [Intel-wired-lan] [next PATCH 1/5] fm10k: Cleanup MSI-X
 interrupts	in case of failure
In-Reply-To: <804857E1F29AAC47BF68C404FC60A1847EC6D23F@ORSMSX105.amr.corp.intel.com>
References: <20151027235341.30048.46286.stgit@localhost.localdomain>
 <20151027235912.30048.59266.stgit@localhost.localdomain>
 <804857E1F29AAC47BF68C404FC60A1847EC6D23F@ORSMSX105.amr.corp.intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27225E4E@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Allan, Bruce W
Sent: Wednesday, October 28, 2015 9:11 AM
To: Alexander Duyck <aduyck@mirantis.com>; intel-wired-lan at lists.osuosl.org
Subject: Re: [Intel-wired-lan] [next PATCH 1/5] fm10k: Cleanup MSI-X interrupts in case of failure

> -----Original Message-----
> From: Intel-wired-lan 
> [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of 
> Alexander Duyck
> Sent: Tuesday, October 27, 2015 4:59 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH 1/5] fm10k: Cleanup MSI-X 
> interrupts in case of failure
> 
> If the q_vector allocation fails we should free the resources 
> associated with the MSI-X vector table.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_main.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

