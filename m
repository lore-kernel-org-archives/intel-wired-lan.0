From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Thu, 12 May 2022 10:53:19 +0000
Subject: [Intel-wired-lan] [PATCH v2 net-next] ixgbe: add xdp frags
 support to ndo_xdp_xmit
In-Reply-To: <e36724d3cdfbedf9af1a2a7f47ebd60aa7932f83.1650978540.git.lorenzo@kernel.org>
References: <e36724d3cdfbedf9af1a2a7f47ebd60aa7932f83.1650978540.git.lorenzo@kernel.org>
Message-ID: <MW3PR11MB455432D1387610945334C1BF9CCB9@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Lorenzo Bianconi
>Sent: Tuesday, April 26, 2022 6:45 PM
To: netdev@vger.kernel.org
>Cc: daniel at iogearbox.net; intel-wired-lan at lists.osuosl.org;
>toke at redhat.com; ast at kernel.org; andrii at kernel.org; jbrouer at redhat.com;
>kuba at kernel.org; bpf at vger.kernel.org; pabeni at redhat.com;
>davem at davemloft.net; Karlsson, Magnus <magnus.karlsson@intel.com>
>Subject: [Intel-wired-lan] [PATCH v2 net-next] ixgbe: add xdp frags support to
>ndo_xdp_xmit
>
>Add the capability to map non-linear xdp frames in XDP_TX and ndo_xdp_xmit
>callback.
>
>Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>---
>Changes since v1:
>- rebase on top of net-next
>---
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 99 ++++++++++++-------
> 1 file changed, 63 insertions(+), 36 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
