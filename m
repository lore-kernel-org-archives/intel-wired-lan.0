From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 18 May 2017 23:56:04 +0000
Subject: [Intel-wired-lan] [PATCH 2/5] ixgbe: add write flush
	when	configuring CS4223/7
In-Reply-To: <20170517221746.15538.89916.stgit@localhost6.localdomain6>
References: <20170517221424.15538.5968.stgit@localhost6.localdomain6>
 <20170517221746.15538.89916.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA3B99@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Wednesday, May 17, 2017 3:18 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 2/5] ixgbe: add write flush when
> configuring CS4223/7
> 
> Make sure the writes are processed immediately. Without the flush it is
> possible for operations on one port to spill over the other as the resource is
> shared.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   20
> ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


