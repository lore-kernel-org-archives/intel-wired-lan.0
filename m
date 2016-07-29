From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 29 Jul 2016 14:14:26 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbevf: fix incorrect MAC address on
 load
In-Reply-To: <20160727175508.31818.55615.stgit@localhost6.localdomain6>
References: <20160727175508.31818.55615.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9EB872@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Wednesday, July 27, 2016 10:55 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbevf: fix incorrect MAC address on load
> 
> The PF driver was only receiving the first 4 bytes of the MAC due to an
> incorrect size parameter for ixgbevf_write_msg_read_ack() in
> ixgbevf_set_rar_vf().
> 
> Correct the size by calculating it on a fly for all instances where we call
> ixgbevf_write_msg_read_ack()
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/vf.c |   21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
 
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

