From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 31 Mar 2017 18:28:19 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: delay tail write to every
	'n'	packets
In-Reply-To: <20170328164703.12688.90760.stgit@john-Precision-Tower-5810>
References: <20170328164703.12688.90760.stgit@john-Precision-Tower-5810>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040A94D@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of John Fastabend
> Sent: Tuesday, March 28, 2017 9:47 AM
> To: john.fastabend at gmail.com; alexander.duyck at gmail.com
> Cc: intel-wired-lan at lists.osuosl.org; u9012063 at gmail.com
> Subject: [Intel-wired-lan] [PATCH] ixgbe: delay tail write to every 'n' packets
> 
> Current XDP implementation hits the tail on every XDP_TX return code. This
> patch changes driver behavior to only hit the tail after packet processing is
> complete.
> 
> With this patch I can run XDP drop programs @ 14+Mpps and XDP_TX
> programs are at ~13.5Mpps.
> 
> Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   28 +++++++++++++++----
> ------
>  1 file changed, 17 insertions(+), 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


