From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 21 Mar 2018 11:14:14 -0700
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 35/55]
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:9925:12: error: 'struct
 sk_buff' has no member named 'sp'; did you mean 'sk'?
In-Reply-To: <bf5e19ab-5be3-e6b1-c954-04dd8f313e94@oracle.com>
References: <201803210241.5Al1Tpht%fengguang.wu@intel.com>
 <1521582652.2528.9.camel@intel.com>
 <9e091d1e-c3f9-23ec-ffe8-8bad83ce4ae9@oracle.com>
 <CAKgT0UeCJiL1FnrMYN=htPv55q6X1+DmtHfH4wuu8eeFSoBU-g@mail.gmail.com>
 <bf5e19ab-5be3-e6b1-c954-04dd8f313e94@oracle.com>
Message-ID: <1521656054.12746.7.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2018-03-21 at 09:19 -0700, Shannon Nelson wrote:
> On 3/21/2018 8:53 AM, Alexander Duyck wrote:
> > On Wed, Mar 21, 2018 at 8:33 AM, Shannon Nelson
> > <shannon.nelson@oracle.com> wrote:
> > > 
> > > 
> > > On 3/20/2018 2:50 PM, Duyck, Alexander H wrote:
> > > > 
> > > > On Wed, 2018-03-21 at 02:17 +0800, kbuild test robot wrote:
> > > > > 
> > > > > tree:
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next
> > > > > -queue.git
> > > > > dev-queue
> > > > > head:   87cc3719efa6c6bd875e67892450bd03a9e147e4
> > > > > commit: 747053c601fe8547518069b8791337716b71c4c6 [35/55]
> > > > > ixgbe: enable
> > > > > tso with ipsec offload
> > > > > config: powerpc-skiroot_defconfig (attached as .config)
> > > > > compiler: powerpc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> > > > > reproduce:
> > > > >            wget
> > > > > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin
> > > > > /make.cross -O
> > > > > ~/bin/make.cross
> > > > >            chmod +x ~/bin/make.cross
> > > > >            git checkout
> > > > > 747053c601fe8547518069b8791337716b71c4c6
> > > > >            # save the attached .config to linux build tree
> > > > >            make.cross ARCH=powerpc
> > > > > 
> > > > > All errors (new ones prefixed by >>):
> > > > > 
> > > > >       drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: In
> > > > > function
> > > > > 'ixgbe_features_check':
> > > > > > > 
> > > > > > > drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:9925:12:
> > > > > > > error: 'struct
> > > > > > > sk_buff' has no member named 'sp'; did you mean 'sk'?
> > > > > 
> > > > > 
> > > > >             !skb->sp)
> > > > >                   ^~
> > > > >                   sk
> > > > > 
> > > > > vim +9925 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > > > > 
> > > > >      9896
> > > > >      9897 static netdev_features_t
> > > > >      9898 ixgbe_features_check(struct sk_buff *skb, struct
> > > > > net_device *dev,
> > > > >      9899                      netdev_features_t features)
> > > > >      9900 {
> > > > >      9901         unsigned int network_hdr_len, mac_hdr_len;
> > > > >      9902
> > > > >      9903         /* Make certain the headers can be
> > > > > described by a context
> > > > > descriptor */
> > > > >      9904         mac_hdr_len = skb_network_header(skb) -
> > > > > skb->data;
> > > > >      9905         if (unlikely(mac_hdr_len >
> > > > > IXGBE_MAX_MAC_HDR_LEN))
> > > > >      9906                 return features & ~(NETIF_F_HW_CSUM
> > > > > |
> > > > >      9907                                    
> > > > > NETIF_F_SCTP_CRC |
> > > > >      9908                                    
> > > > > NETIF_F_HW_VLAN_CTAG_TX |
> > > > >      9909                                     NETIF_F_TSO |
> > > > >      9910                                     NETIF_F_TSO6);
> > > > >      9911
> > > > >      9912         network_hdr_len = skb_checksum_start(skb) -
> > > > > skb_network_header(skb);
> > > > >      9913         if (unlikely(network_hdr_len >
> > > > > IXGBE_MAX_NETWORK_HDR_LEN))
> > > > >      9914                 return features & ~(NETIF_F_HW_CSUM
> > > > > |
> > > > >      9915                                    
> > > > > NETIF_F_SCTP_CRC |
> > > > >      9916                                     NETIF_F_TSO |
> > > > >      9917                                     NETIF_F_TSO6);
> > > > >      9918
> > > > >      9919         /* We can only support IPV4 TSO in tunnels
> > > > > if we can
> > > > > mangle the
> > > > >      9920          * inner IP ID field, so strip TSO if
> > > > > MANGLEID is not
> > > > > supported.
> > > > >      9921          * IPsec offoad sets skb->encapsulation but
> > > > > still can
> > > > > handle
> > > > >      9922          * the TSO, so it's the exception.
> > > > >      9923          */
> > > > >      9924         if (skb->encapsulation && !(features &
> > > > > NETIF_F_TSO_MANGLEID) &&
> > > > > > 
> > > > > > 9925                !skb->sp)
> > > > > 
> > > > > 
> > > > >      9926                 features &= ~NETIF_F_TSO;
> > > > >      9927
> > > > >      9928         return features;
> > > > >      9929 }
> > > > 
> > > > 
> > > > What you may want to look at doing in order to fix this is flip
> > > > the
> > > > logic like so:
> > > > 
> > > >           if (!skb->encapsulation || (features &
> > > > NETIF_F_TSO_MANGLEID))
> > > >                   return features;
> > > > #ifdef CONFIG_XFRM
> > > >           /* IPSec is a special case excluded from the above
> > > > rule */
> > > >           if (skb->sp)
> > > >                   return features;
> > > > #endif
> > > >           return features & ~NETIF_F_TSO;
> > > > 
> > > > Anyway just my $0.02, thanks.
> > > 
> > > 
> > > Thanks, Alex, but I think this obfuscates the code a little, and
> > > might make
> > > it harder to add other feature concerns in the future.  I'd
> > > rather keep the
> > > look of the exception if possible.  Maybe something like this?
> > > 
> > >           if (skb->encapsulation && !(features &
> > > NETIF_F_TSO_MANGLEID))
> > > #ifdef CONFIG_XFRM
> > >                   if (!skb->sp)
> > > #endif
> > >                           features &= ~NETIF_F_TSO;
> > > 
> > >           return features;
> > > 
> > > 
> > > sln
> > 
> > That works. My only ask then would be add braces around the
> > statement
> > since it is technically a multi-line statement at that point.
> > 
> > - Alex
> > 
> 
> Sure - that makes sense.
> 
> Jeff, can you tweak this inline or shall I repost it this afternoon?

I can fix it inline.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180321/a447e5fc/attachment-0001.asc>
