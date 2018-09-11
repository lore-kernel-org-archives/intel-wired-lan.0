From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 11 Sep 2018 22:00:59 +0000
Subject: [Intel-wired-lan] [PATCH next-queue] ixgbevf: fix msglen for
 ipsec mbx messages
In-Reply-To: <1536089609-32716-1-git-send-email-shannon.nelson@oracle.com>
References: <1536089609-32716-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2ECE91@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Shannon Nelson
> Sent: Tuesday, September 4, 2018 12:33 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Cc: dan.carpenter at oracle.com
> Subject: [Intel-wired-lan] [PATCH next-queue] ixgbevf: fix msglen for ipsec
> mbx messages
> 
> Don't be fancy with message lengths, just set lengths to number of dwords,
> not bytes.
> 
> Fixes: 0062e7cc955e ("ixgbevf: add VF IPsec offload code")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ipsec.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


