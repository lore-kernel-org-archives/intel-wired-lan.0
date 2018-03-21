From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 21 Mar 2018 18:12:46 +0000
Subject: [Intel-wired-lan] [PATCH 3/5] ixgbevf: Delay tail write for XDP
 packets
In-Reply-To: <20180316223406.7295-4-anthony.l.nguyen@intel.com>
References: <20180316223406.7295-1-anthony.l.nguyen@intel.com>
 <20180316223406.7295-4-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94D27A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, March 16, 2018 3:34 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH 3/5] ixgbevf: Delay tail write for XDP
> packets
> 
> Current XDP implementation hits the tail on every XDP_TX; change the driver
> to only hit the tail after packet processing is complete.
> 
> Based on commit 7379f97a4fce ("ixgbe: delay tail write to every 'n'
> packets")
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 30 ++++++++++++++--
> -------
>  1 file changed, 18 insertions(+), 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


