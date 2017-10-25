From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 25 Oct 2017 20:41:21 +0000
Subject: [Intel-wired-lan] [PATCH v3] ixgbe: advertise highest capable
 link	speed
In-Reply-To: <1508857240-5201-1-git-send-email-paul.greenwalt@intel.com>
References: <1508857240-5201-1-git-send-email-paul.greenwalt@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAD666@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Paul Greenwalt
> Sent: Tuesday, October 24, 2017 8:01 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v3] ixgbe: advertise highest capable link
> speed
> 
> On module insert advertise highest capable link speed. If module is capable
> of 10G, then advertise 10G, else advertise modules capable link speeds.
> 
> v2 - Simplify logic based on feedback
> v3 - Fix format error
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


