From: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
Date: Mon, 8 Jun 2020 23:19:52 +0000
Subject: [Intel-wired-lan] [PATCH net-next 2/4] ixgbe_ipsec: become
 aware of when running as a bonding slave
In-Reply-To: <20200608210058.37352-3-jarod@redhat.com>
References: <20200608210058.37352-1-jarod@redhat.com>
 <20200608210058.37352-3-jarod@redhat.com>
Message-ID: <61CC2BC414934749BD9F5BF3D5D94044986EFB8B@ORSMSX112.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Jarod Wilson <jarod@redhat.com>
> Sent: Monday, June 8, 2020 14:01
> To: linux-kernel at vger.kernel.org
> Cc: Jarod Wilson <jarod@redhat.com>; Jay Vosburgh
> <j.vosburgh@gmail.com>; Veaceslav Falico <vfalico@gmail.com>; Andy
> Gospodarek <andy@greyhouse.net>; David S. Miller <davem@davemloft.net>;
> Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Jakub Kicinski
> <kuba@kernel.org>; Steffen Klassert <steffen.klassert@secunet.com>;
> Herbert Xu <herbert@gondor.apana.org.au>; netdev at vger.kernel.org; intel-
> wired-lan at lists.osuosl.org
> Subject: [PATCH net-next 2/4] ixgbe_ipsec: become aware of when running as
> a bonding slave
> 
> Slave devices in a bond doing hardware encryption also need to be aware that
> they're slaves, so we operate on the slave instead of the bonding master to do
> the actual hardware encryption offload bits.
> 
> CC: Jay Vosburgh <j.vosburgh@gmail.com>
> CC: Veaceslav Falico <vfalico@gmail.com>
> CC: Andy Gospodarek <andy@greyhouse.net>
> CC: "David S. Miller" <davem@davemloft.net>
> CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> CC: Jakub Kicinski <kuba@kernel.org>
> CC: Steffen Klassert <steffen.klassert@secunet.com>
> CC: Herbert Xu <herbert@gondor.apana.org.au>
> CC: netdev at vger.kernel.org
> CC: intel-wired-lan at lists.osuosl.org
> Signed-off-by: Jarod Wilson <jarod@redhat.com> 

Acked-by: Jeff Kirsher <Jeffrey.t.kirsher@intel.com>

> ---
>  .../net/ethernet/intel/ixgbe/ixgbe_ipsec.c    | 39 +++++++++++++++----
>  1 file changed, 31 insertions(+), 8 deletions(-)
