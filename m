From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 20 Mar 2017 19:42:07 +0000
Subject: [Intel-wired-lan] [PART2 PATCH 5/9] i40e: partition the
 ring_cookie	to get VF index
In-Reply-To: <20170206223852.31177-6-jacob.e.keller@intel.com>
References: <20170206223852.31177-1-jacob.e.keller@intel.com>
 <20170206223852.31177-6-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040654D@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Monday, February 6, 2017 2:39 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PART2 PATCH 5/9] i40e: partition the ring_cookie
> to get VF index
> 
> Do not use the user-def field for determining the VF target. Instead, similar
> to ixgbe, partition the ring_cookie value into 8bits of VF index, along with
> 32bits of queue number. This is better than using the user-def field, because
> it leaves the field open for extension in a future patch which will enable
> flexible data. Also, this matches with convention used by ixgbe and other
> drivers.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-Id: e36745186d817216b12f0313b99ec95cb8a9130c
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 74 ++++++++++++++-------
> -----
>  1 file changed, 40 insertions(+), 34 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


