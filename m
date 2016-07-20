From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Jul 2016 21:12:17 +0000
Subject: [Intel-wired-lan] [PATCH v2 2/2] ixgbevf: Commonize
	mailbox	write/read
In-Reply-To: <1468431214-23969-1-git-send-email-anthony.l.nguyen@intel.com>
References: <1468431214-23969-1-git-send-email-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9EAF63@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, July 13, 2016 10:34 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 2/2] ixgbevf: Commonize mailbox
> write/read
> 
> From: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
> 
> With changes to ixgbevf_write_msg_read_ack(), other functions are
> performing the same operations done here; change those functions to utilize
> ixgbevf_write_msg_read_ack().
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/vf.c | 35 ++++++---------------------------
>  1 file changed, 6 insertions(+), 29 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
