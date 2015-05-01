From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 30 Apr 2015 18:46:51 -0700
Subject: [Intel-wired-lan] [PATCH 1/3] igb, ixgbe(vf), i40e(vf),
 fm10k: Use dev_kfree_skb in Tx cleanup path
In-Reply-To: <20150430205818.1512.11765.stgit@ahduyck-vm-fedora22>
References: <20150430205423.1512.13487.stgit@ahduyck-vm-fedora22>
 <20150430205818.1512.11765.stgit@ahduyck-vm-fedora22>
Message-ID: <1430444811.2669.141.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2015-04-30 at 13:58 -0700, Alexander Duyck wrote:
> This change replaces the use of either dev_kfree_skb_any or
> dev_consume_skb_any in the Tx cleanup paths of these drivers with
> dev_kfree_skb.  There isn't any need for the "_any" version of these
> functions since the NAPI cleanup context is not a hard irq context.
> 
> This change allows us to drop one function call from the clean-up path
> since dev_kfree_skb_any was just calling into dev_kfree_skb in these
> paths
> anyway.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@redhat.com>

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_main.c     |    2 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c       |    2 +-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c     |    2 +-
>  drivers/net/ethernet/intel/igb/igb_main.c         |    2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |    2 +-
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |    2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150430/61e5a6bb/attachment.asc>
